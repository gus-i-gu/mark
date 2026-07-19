# H_DDC_CODEX - Windows Runtime Packaging State Evidence

- Authority marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
- Baseline SHA after fast-forward: a892c2628df7425124be0e64db66697b7b572b4d
- Final commit SHA: resolved by Git after this report is committed and pushed; Codex terminal response reports it.
- Result classification: runtime package ready locally; clean provider retest required.

## States Distinguished

- `authentication-validated`: retained from sanitized human evidence after `1922ffc`; provider login, protocol callback consumption, authorization-code exchange, credential acceptance, stable status, logout and re-sign-in passed.
- `runtime-dependency-missing`: retained as the prior failure mode; the callback-launched process could not load `cpprest_2_10.dll` until DLLs were manually copied beside `markei.exe`.
- `runtime-package-ready`: materialized locally by CMake target-runtime deployment plus Debug and Release build/output launch evidence.
- `clean-provider-retest-required`: current post-Codex state; real Auth0 login must be repeated from clean packaged output without PATH or manual-copy assistance.

Reserved and not claimed:

- `clean-provider-retest-passed`
- Device enrollment success
- hosted synchronization success
- MCG-02 closure
- Cycle 10 closure
- MCG-03 activation

## Semantic Tests

- Packaging contract test proves the tracked CMake contract uses executable target runtime metadata, copies to the target output directory, expands runtime dependency lists and fails configuration clearly when CMake lacks the required metadata feature.
- Packaging contract test proves no hard-coded vcpkg path, drive path, username, build directory, Debug/Release directory or one-DLL model entered the tracked runner CMake contract.
- Packaging contract test proves generated Windows build outputs, DLLs and EXEs are not tracked in the Flutter client path.
- Callback contract tests remain passing and preserve exact callback prefix, bounded forwarding, current-user pipe security, SDK lock usage and no callback logging.
- Native authentication and closure-surface focused tests remain passing; no phase before usable credentials says authenticated.
- Full Flutter suite remains passing with existing skips.

## Privacy and Wording Evidence

No report, source change or test output exposes tokens, authorization codes, PKCE material, state,
nonce, email, user ID, full callback URLs, provider credentials, Neon strings or Render secrets.
The sanitized invalid callback used for launch validation contains no secret-bearing material.

User-facing semantics remain neutral: authentication can be validated, runtime packaging can be
ready, and provider retest can remain required without claiming enrollment, synchronization or
overall MCG-02 completion.
