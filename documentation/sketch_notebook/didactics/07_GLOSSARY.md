# Glossary

## module

A Python file loaded as an importable unit.

## module namespace

The set of top-level names available inside a loaded module.

## symbol

A name that points to a Python object, such as a class, function, or constant.

## exported symbol

A module-level name that another module can import.

## top-level name

A name declared at module indentation level, not inside a function, class, or
execution block.

## class declaration

Python syntax that creates a class object and binds it to a name.

## relative import

An import that resolves from the current package, such as
`from .repository import Repository`.

## ImportError

An import failure that can occur after Python finds a module but cannot retrieve
the requested name.

## ModuleNotFoundError

An import failure where Python cannot find the requested module path.

## Repository Pattern

A persistence boundary that hides SQL and storage details behind methods used by
the service layer.

## RepositoryContract

The Markei contract describing required repository responsibilities.

## contract/interface

An abstract responsibility declaration that dependent code can rely on.

## concrete implementation

Executable code that satisfies a contract, such as `Repository`.

## service layer

The business orchestration layer. In Markei, this is `ProductService`.

## persistence layer

The layer that owns SQL, database access, and row-to-model reconstruction.

## refactor drift

A mismatch introduced when code structure changes but dependent import surfaces
or contracts are not updated consistently.

## dependency direction

The intended direction of calls between layers:
`ProductService -> Repository -> database.py -> SQLite`.

## dictionary

A Python mapping from keys to values.

## key

The lookup name used to retrieve a value from a dictionary.

## value

The object stored under a dictionary key.

## missing key

A requested dictionary key that is absent at runtime.

## KeyError

Python exception raised when code requests a missing key from a
dictionary-like object. In the StoragePage failure, the missing key was
`"color"`.

## direct lookup

Dictionary access with square brackets, such as `variation["color"]`, which
fails if the key is missing.

## safe lookup

Dictionary access with a fallback, such as `variation.get("delta")`.

## default value

A fallback value used when expected data is absent.

## exception

A runtime signal that normal execution cannot continue on the current path.

## runtime

The period when the program is executing, as opposed to being edited or
compiled.

## stack trace

The execution path Python prints when an exception is not handled.

## mapping

A data structure that associates keys with values.

## data contract

An agreement about the shape and meaning of data exchanged between code
boundaries.

## implicit contract

An expected interface shape that exists in code usage but is not formally
declared.

## interface expectation

What one module assumes another module will provide.

## boundary

The responsibility line between modules or layers.

## presentation data

Data used to render UI output.

## business data

Application meaning independent of a specific UI toolkit.

## presentation metadata

Display-only data used by the UI, such as color, icon, badge, or row emphasis.

## price variation

The semantic comparison between current and previous product price.

## defensive programming

Coding that handles missing or uncertain input without crashing unnecessarily.

## fail fast

Letting an invalid assumption raise an error immediately so the mismatch is
visible.

## fallback

A substitute value used when the preferred value is unavailable.

## Shiboken

The binding layer used by PySide6 to convert between Python and Qt/C++ values.

## type conversion

Changing or adapting a value from one runtime representation to another.

## script

A file run directly by a developer or command, often assuming a source checkout.

## application

A user-facing program with a stable launch path and persistent behavior.

## entry point

The file or module used to start the app, such as `main.py`.

## executable

A launchable program file, such as `Markei.exe`.

## installer

A tool that places an application on a user's system. Installer polish is later
than the first `onedir` build.

## dependency

Software the project needs in order to run or build.

## runtime dependency

A dependency needed by users when the app runs.

## development dependency

A dependency needed by developers to build, test, or package the app.

## packaging

Preparing the app and its resources so it can run outside the source checkout.

## release artifact

The output given to testers or users, such as a zipped `dist/Markei` folder.

## frozen Python application

A Python application bundled so users do not manually install Python packages.

## local database

A database stored on the user's machine.

## SQLite database file

The single-file database used by Markei for local persistence.

## app data folder

A user-specific folder for persistent app data. For Markei, this contains the
live `market.sqlite` database.

## user data

Information owned by the user, including their saved products and purchases.

## program files

Installed or bundled application files, distinct from user data.

## resource file

A file shipped with the app, such as `schema.sql` or `seed.sql`.

## bundled resource

A resource included inside the packaged app folder.

## runtime path

The actual filesystem location used while the app is running.

## path assumption

Code expecting files to exist at a specific location.

## user-facing interface

The visible app surface a non-developer uses.

## developer interface

Commands, source paths, and tooling used by developers.

## build artifact

A generated output from the build process.

## portable app folder

A folder containing an executable and support files that must stay together.
