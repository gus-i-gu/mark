# I_DSN_CODEX - Windows Runtime Packaging Design Evidence

- Authority marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
- Baseline SHA after fast-forward: a892c2628df7425124be0e64db66697b7b572b4d
- Final commit SHA: resolved by Git after this report is committed and pushed; Codex terminal response reports it.
- Dependency decision: `auth0_flutter` remains pinned at 2.4.0; no dependency update was needed.

## CMake Direction

The final deployment direction is:

`pinned auth0_flutter/cpprestsdk imported targets -> runner executable link closure -> CMake TARGET_RUNTIME_DLLS -> post-build copy_if_different -> configuration-specific runner directory`.

The post-build command is attached in `windows/runner/CMakeLists.txt`, the same CMake directory
that creates `${BINARY_NAME}`. This placement satisfies CMake's `add_custom_command(TARGET ...)`
directory rule while still allowing generated plugin linkage to contribute to the executable's
runtime dependency closure at generation/build time.

## Configuration Selection

The implementation does not select Debug or Release paths manually. CMake evaluates
`$<TARGET_RUNTIME_DLLS:${BINARY_NAME}>` for the active configuration and copies those resolved DLLs
to `$<TARGET_FILE_DIR:${BINARY_NAME}>`.

Observed outputs confirm configuration separation:

- Debug received debug-suffixed vcpkg libraries, including `cpprest_2_10d.dll` and Boost `gd` DLLs.
- Release received release libraries, including `cpprest_2_10.dll`, OpenSSL, zlib and brotli DLLs.
- Release debug-suffix scan returned empty.

## Runtime Closure Rules

- The executable directory owns the deployable runtime closure.
- Runtime dependencies come from CMake target/imported-target metadata rather than PATH or manual copy.
- CMake versions older than 3.21 fail during configuration with a Markei-specific message because target runtime metadata is unavailable.
- No username, drive letter, vcpkg root, generated build directory, configuration directory or single DLL name is encoded in tracked source.
- DLLs, vcpkg packages, native caches and generated build outputs remain untracked.

## Runner and Plugin Boundary

The source correction does not change Windows callback forwarding, single-instance behavior,
SDK lock handoff, diagnostic mapping, credential validation or token lifecycle behavior accepted at
`1922ffc`. The runner remains responsible for process activation and the Auth0 SDK remains
responsible for OAuth transaction state, PKCE and code exchange.

## Rollback Boundary

Rollback removes only:

- the post-build runtime deployment block in `clients/markei_flutter/windows/runner/CMakeLists.txt`;
- the packaging contract test in `clients/markei_flutter/test/infrastructure/windows_runtime_packaging_contract_test.dart`;
- these G/H/I reports.

Rollback must not remove the accepted Windows callback/credential correction, native Auth0
composition, closure surface, provider diagnostics or local synchronization proof work.

## Deferred Work

Clean real Auth0 provider retest remains human-operated and must occur after this package-ready
commit is published. Device enrollment, hosted synchronization, provider mutation, installer
registration work, dependency upgrades, MCG-02 closure, MCG-03 and Cycle 10 closure remain outside
this correction.
