#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <sddl.h>
#include <shellapi.h>
#include <string>
#include <thread>
#include <vector>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

const wchar_t* kSingleInstanceMutex = L"markei_auth0flutter_single_instance";
const wchar_t* kRedirectPipeName = L"\\\\.\\pipe\\markei_auth0flutter";
const wchar_t* kCallbackPrefix = L"auth0flutter://callback";

static PSECURITY_DESCRIPTOR BuildCurrentUserSecurityDescriptor() {
  HANDLE token = nullptr;
  if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token)) {
    return nullptr;
  }
  DWORD token_user_bytes = 0;
  GetTokenInformation(token, TokenUser, nullptr, 0, &token_user_bytes);
  if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
    CloseHandle(token);
    return nullptr;
  }
  std::vector<BYTE> token_user_buffer(token_user_bytes);
  auto* token_user = reinterpret_cast<PTOKEN_USER>(token_user_buffer.data());
  if (!GetTokenInformation(token, TokenUser, token_user, token_user_bytes,
                           &token_user_bytes)) {
    CloseHandle(token);
    return nullptr;
  }
  CloseHandle(token);

  LPWSTR sid = nullptr;
  if (!ConvertSidToStringSidW(token_user->User.Sid, &sid)) {
    return nullptr;
  }
  std::wstring descriptor = L"D:(A;;GRGW;;;";
  descriptor += sid;
  descriptor += L")";
  LocalFree(sid);

  PSECURITY_DESCRIPTOR security_descriptor = nullptr;
  ConvertStringSecurityDescriptorToSecurityDescriptorW(
      descriptor.c_str(), SDDL_REVISION_1, &security_descriptor, nullptr);
  return security_descriptor;
}

static bool IsAuth0Callback(const std::wstring& value) {
  const size_t prefix_length = wcslen(kCallbackPrefix);
  return value.size() >= prefix_length &&
         value.compare(0, prefix_length, kCallbackPrefix) == 0;
}

static void BringExistingWindowToFront() {
  HWND window = FindWindowW(L"FLUTTER_RUNNER_WIN32_WINDOW", nullptr);
  if (window) {
    ShowWindow(window, SW_RESTORE);
    SetForegroundWindow(window);
  }
}

static void ForwardToFirstInstance(const wchar_t* uri) {
  if (!WaitNamedPipeW(kRedirectPipeName, 2000)) {
    return;
  }
  HANDLE pipe =
      CreateFileW(kRedirectPipeName, GENERIC_WRITE, 0, nullptr, OPEN_EXISTING,
                  FILE_ATTRIBUTE_NORMAL, nullptr);
  if (pipe == INVALID_HANDLE_VALUE && GetLastError() == ERROR_PIPE_BUSY &&
      WaitNamedPipeW(kRedirectPipeName, 2000)) {
    pipe =
        CreateFileW(kRedirectPipeName, GENERIC_WRITE, 0, nullptr, OPEN_EXISTING,
                    FILE_ATTRIBUTE_NORMAL, nullptr);
  }
  if (pipe == INVALID_HANDLE_VALUE) {
    return;
  }
  DWORD written = 0;
  const DWORD bytes = static_cast<DWORD>((wcslen(uri) + 1) * sizeof(wchar_t));
  WriteFile(pipe, uri, bytes, &written, nullptr);
  CloseHandle(pipe);
}

static void StartCallbackPipeServer() {
  std::thread([] {
    while (true) {
      PSECURITY_DESCRIPTOR descriptor = BuildCurrentUserSecurityDescriptor();
      if (!descriptor) {
        return;
      }
      SECURITY_ATTRIBUTES security_attributes = {};
      security_attributes.nLength = sizeof(security_attributes);
      security_attributes.lpSecurityDescriptor = descriptor;
      security_attributes.bInheritHandle = FALSE;
      HANDLE pipe = CreateNamedPipeW(
          kRedirectPipeName, PIPE_ACCESS_INBOUND,
          PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 0, 0, 0,
          &security_attributes);
      LocalFree(descriptor);
      if (pipe == INVALID_HANDLE_VALUE) {
        return;
      }
      const BOOL connected =
          ConnectNamedPipe(pipe, nullptr) || GetLastError() == ERROR_PIPE_CONNECTED;
      if (connected) {
        wchar_t buffer[2048];
        DWORD read = 0;
        const BOOL read_ok =
            ReadFile(pipe, buffer, sizeof(buffer) - sizeof(wchar_t), &read, nullptr);
        if (read_ok) {
          buffer[read / sizeof(wchar_t)] = L'\0';
          std::wstring callback(buffer);
          if (IsAuth0Callback(callback)) {
            SetEnvironmentVariableW(L"PLUGIN_STARTUP_URL", callback.c_str());
            BringExistingWindowToFront();
          }
        }
      }
      DisconnectNamedPipe(pipe);
      CloseHandle(pipe);
    }
  }).detach();
}

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  int argc = 0;
  LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);
  std::wstring startup_uri;
  if (argv && argc > 1) {
    startup_uri = argv[1];
  }
  if (argv) {
    LocalFree(argv);
  }

  HANDLE mutex = CreateMutexW(nullptr, TRUE, kSingleInstanceMutex);
  const bool already_running =
      mutex && GetLastError() == ERROR_ALREADY_EXISTS;
  if (already_running) {
    BringExistingWindowToFront();
    if (!startup_uri.empty() && IsAuth0Callback(startup_uri)) {
      ForwardToFirstInstance(startup_uri.c_str());
    }
    CloseHandle(mutex);
    return 0;
  }

  SetEnvironmentVariableW(
      L"PLUGIN_STARTUP_URL",
      (!startup_uri.empty() && IsAuth0Callback(startup_uri))
          ? startup_uri.c_str()
          : L"");
  StartCallbackPipeServer();

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"markei", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  if (mutex) {
    CloseHandle(mutex);
  }
  return EXIT_SUCCESS;
}
