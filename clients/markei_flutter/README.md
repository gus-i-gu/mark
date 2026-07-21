# Markei Flutter Client

## Windows Development Setup

The Windows desktop build requires Flutter's Windows toolchain and native
dependencies discoverable through vcpkg. Use local placeholder values for your
machine:

```powershell
$env:VCPKG_ROOT = '<path-to-vcpkg>'
$env:CMAKE_TOOLCHAIN_FILE = '<path-to-vcpkg>\scripts\buildsystems\vcpkg.cmake'
vcpkg install cpprestsdk:x64-windows
```

Enable the native Closure surface only for diagnostic Windows runs:

```powershell
flutter run -d windows --dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true
```

Register the Auth0 Flutter callback protocol for the current Windows user after
building the desktop executable:

```powershell
.\tool\register_windows_auth0flutter_protocol.ps1 `
  -ExecutablePath '<path-to-built-markei.exe>'
```

The registration script writes only the `auth0flutter` protocol handler under
`HKCU:\Software\Classes`, requires no administrator rights, and does not contain
tenant, credential, callback, or provider configuration values.
