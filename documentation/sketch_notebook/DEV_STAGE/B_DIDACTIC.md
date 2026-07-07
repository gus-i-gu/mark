# [A] Session 003 | 10:44_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Didactic Chat.

Responsibility: learning, glossary candidates, concept mapping, and KANBAN suggestions.

This stage explains the concepts needed to understand turning Markei from a developer-run Python app into a user-run application.

Focus:

```text
script vs application
executable
installer
dependency
packaging
local database
app data folder
user-facing interface vs developer interface
```

This is staged material only. Main Chat must synthesize before any permanent didactic, glossary, KANBAN, design, operational, or application update.

No application source code is modified by this report.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP NOTES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Methodology boot completed from:

1. `AGENTS.md`
2. `documentation/sketch_notebook/INDEX.md`
3. `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
4. `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
5. `documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md`
6. `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
7. `documentation/sketch_notebook/methodology/FLUX.md`

Routing constraint observed:

- Didactic Chat writes only to `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`.
- Didactic Chat does not modify application source files.
- Didactic Chat does not modify permanent notebook files.
- Didactic Chat does not modify methodology files.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. PREVIOUS CONCEPTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Markei currently exists primarily as a development-time Python project.

That means the human developer runs it from the repository, usually with a command such as:

```text
python -m app
```

or another Python entry command defined by the project.

In that mode, the development environment provides many things implicitly:

```text
Python interpreter
installed packages
project folder structure
source files
relative paths
terminal output
local database path
```

A normal user should not need to know those things.

The learning transition is:

```text
developer opens repository and runs Python
↓
user opens an installed program
```

This does not only require a visual interface. Markei already has a PySide6 user interface.

It requires changing the way the software is delivered, started, configured, and allowed to store its data.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2. CURRENT LECTURES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This lesson introduces exactly five concept groups.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
&&& Script vs Application
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A script is usually a file or module executed directly by a developer.

It assumes a development context.

For example, when Markei is run as a Python project, the developer knows:

```text
where the repository is
which command to type
which Python version is installed
which virtual environment is active
where errors appear
how to inspect files
```

An application is a program prepared to be used as a product.

It assumes a user context.

A user-run Markei should allow the user to do something like:

```text
open Markei from the Start Menu or desktop
enter supermarket purchases
view Storage / Shortage / Market / History
close the program
open it again later with data preserved
```

The conceptual difference is not only file size or interface polish.

It is responsibility.

A script depends on the developer's knowledge to start and diagnose it.

An application carries more of those responsibilities inside its delivery structure.

In Markei terms:

```text
dev-run script mindset:
    "I know the command, path, environment, and database location."

user-run application mindset:
    "The installed app knows how to start and where to store its data."
```

Required concepts:

```text
program execution
entry point
runtime environment
```

Related concepts:

```text
main module
terminal
application lifecycle
```

Python example:

```python
# Developer-facing execution idea
# The developer knows this module must be run.
python -m app
```

Application example:

```text
The user clicks Markei.exe.
The app starts without the user knowing the Python command.
```

Next concept:

```text
Executable and installer
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
&&& Executable and Installer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

An executable is a file that the operating system can launch as a program.

On Windows, this is commonly an `.exe` file.

For Markei, an executable would be the thing the user opens instead of typing a Python command.

Conceptually:

```text
source project:
    app/main.py
    app/ui/main_window.py
    app/services.py
    app/repository.py
    requirements

packaged executable:
    Markei.exe
```

The executable hides the developer-facing startup details.

It does not mean the program stops being written in Python.

It means the Python program has been bundled into a launchable form.

An installer is different.

An installer is a delivery program that places the application on the user's machine.

It may:

```text
copy the executable into Program Files or another install location
create Start Menu shortcuts
create a desktop shortcut
prepare app data folders
record uninstall information
include required runtime files
```

The executable starts the app.

The installer installs the app.

They are related, but not the same thing.

In Markei terms:

```text
Markei.exe:
    the program the user runs

Markei Setup.exe:
    the program that installs Markei.exe and related files
```

A developer can often test the executable without an installer.

A normal user usually expects an installer or a simple downloadable app bundle.

Required concepts:

```text
operating system launch
file association
installation location
shortcut
```

Related concepts:

```text
PyInstaller
Nuitka
Inno Setup
MSIX
Windows app distribution
```

Python example:

```text
A packaging tool can take the Python entry point and produce a launchable executable.
```

Application example:

```text
User installs Markei.
User opens Markei from Start Menu.
User never types python -m app.
```

Next concept:

```text
dependencies and packaging
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
%%% Dependency and Packaging
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A dependency is something Markei needs in order to run but does not fully define itself.

For Markei, dependencies include external libraries such as:

```text
PySide6
sqlite3 behavior from Python standard library
possibly packaging/runtime support files
```

Some dependencies are part of Python's standard library.

Some dependencies must be installed separately.

During development, dependencies are usually handled through commands like:

```text
pip install PySide6
```

or through a dependency file.

A user should not need to run those commands.

Packaging is the process of collecting the application and its runtime requirements into a deliverable form.

For a Python desktop app, packaging usually needs to answer:

```text
Which Python files are included?
Which external libraries are included?
Which images, schemas, or resources are included?
What is the app entry point?
Where should the app read/write user data?
How should the operating system launch it?
```

In Markei, packaging is not the same as architecture.

Architecture answers:

```text
What are RegisterPage, ProductService, Repository, and the database responsible for?
```

Packaging answers:

```text
How do all required files and dependencies travel to the user's computer in runnable form?
```

This distinction matters because an app can be architecturally correct and still fail after packaging if the packaged version cannot find:

```text
PySide6 plugins
schema.sql
icons
relative resource paths
the expected database location
```

Required concepts:

```text
runtime requirement
module import
resource inclusion
build artifact
```

Related concepts:

```text
requirements.txt
pyproject.toml
virtual environment
build process
frozen application
```

Python example:

```python
from PySide6.QtWidgets import QApplication
```

That import works only if PySide6 is available in the runtime environment.

Application example:

```text
In dev mode, PySide6 exists because the developer installed it.
In packaged mode, PySide6 must be bundled or otherwise provided.
```

Next concept:

```text
local database and app data folder
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
&%% Local Database and App Data Folder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A local database is a database stored on the user's own machine rather than on a remote server.

Markei uses SQLite, which fits this model well.

Conceptually, SQLite means:

```text
one local database file
no separate database server
application reads and writes through sqlite3
```

During development, Markei may use a database path like:

```text
database/market.sqlite
```

inside the repository.

That is acceptable for development.

It is not ideal for an installed user application.

An installed app should usually not write user data into the installation folder.

Reasons:

```text
installed program folders may be read-only
updates may replace application files
uninstalling may remove program files
users need their data preserved separately from the executable
multiple users on the same computer may need separate data
```

An app data folder is a user-specific folder where an application stores user data and configuration.

On Windows, this is commonly somewhere under the user's AppData area.

Conceptually:

```text
installation folder:
    contains program files

app data folder:
    contains user-created data and settings
```

For Markei:

```text
program files:
    Markei.exe
    bundled Python/runtime files
    bundled UI resources

app data:
    market.sqlite
    settings
    logs if needed
```

This is one of the most important differences between a dev-run app and a user-run app.

In dev mode, repository-relative paths feel natural.

In user mode, data paths must be stable, user-owned, and independent from the install location.

Required concepts:

```text
persistence
file path
user profile
read/write permission
```

Related concepts:

```text
SQLite
schema initialization
migration
configuration
backup
```

Python example:

```python
from pathlib import Path

app_data = Path.home() / "AppData" / "Local" / "Markei"
database_path = app_data / "market.sqlite"
```

This is only a conceptual example, not a patch instruction.

Application example:

```text
The user updates Markei.
The executable may change.
The user's market.sqlite should remain preserved.
```

Next concept:

```text
user-facing interface vs developer interface
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
&&& User-Facing Interface vs Developer Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A user-facing interface is the part of the program intended for normal use.

For Markei, this is the PySide6 window and its pages:

```text
Register
Storage
Shortage
Market
History
Settings
```

A developer interface is the set of tools and surfaces developers use to run, inspect, debug, and maintain the program.

Examples:

```text
terminal commands
stack traces
source files
repository folders
Git commits
Python virtual environments
manual database inspection
```

Both interfaces are real.

They serve different people and different purposes.

In development, the terminal is useful.

In user operation, the terminal should not be required.

In development, a stack trace is useful.

In user operation, an error message should be understandable, limited, and recoverable when possible.

In development, the developer may know that the database is in `database/market.sqlite`.

In user operation, the app should know where the database is and should create or initialize it when needed.

In Markei terms:

```text
developer interface:
    python -m app
    traceback
    repository tree
    manual DB reset

user-facing interface:
    click app icon
    fill Register form
    view product lists
    change Settings
```

A polished application does not remove the developer interface.

It separates it from the user-facing interface.

The developer still needs logs, tests, commands, and debugging tools.

The user needs predictable buttons, forms, messages, and preserved data.

Required concepts:

```text
human interface
abstraction boundary
error visibility
workflow
```

Related concepts:

```text
UX
logging
configuration screen
settings page
support diagnostics
```

Python example:

```text
Developer sees: ImportError, KeyError, traceback, logs.
User sees: "Markei could not open your database. Try restarting or contact support."
```

Application example:

```text
The same internal failure may need a technical trace for the developer and a simple explanation for the user.
```

Next concept:

```text
release workflow
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
3. APP PROBLEMATICS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 3.1 The current shift is from development execution to product distribution

The educational center of this topic is not merely:

```text
How do we make an .exe?
```

The deeper question is:

```text
What assumptions does Markei currently borrow from the developer environment?
```

A user-run application must reduce those assumptions.

Markei currently depends conceptually on several development-time assumptions:

```text
The user/developer can run Python.
The correct dependencies are installed.
The app is launched from a known project structure.
The database path is reachable.
The terminal is available for errors.
The repository layout is present.
```

A packaged application should instead define:

```text
A clear executable entry point.
A reliable dependency bundle.
A stable app data location.
A startup path independent from the repository.
A user-facing failure strategy.
An installation/update story.
```

## 3.2 The local database becomes user data

During development, the SQLite database can feel like a project artifact.

For a real user, it becomes personal app data.

This changes its meaning.

Development database:

```text
Can be deleted and recreated during testing.
Can live near the source code.
Can be inspected manually.
Can contain seed data.
```

User database:

```text
Contains the user's real purchase history.
Must survive app restarts.
Should survive app updates.
Should not be casually overwritten.
Should live in a user data folder.
```

This is a didactic turning point for Markei.

The same file type, `market.sqlite`, changes category depending on context:

```text
inside repository during dev:
    development artifact

inside app data folder after installation:
    user-owned persistent data
```

## 3.3 Packaging can expose hidden path assumptions

A Python app often works in development because the current working directory and repository layout are familiar.

Packaging can break that illusion.

For example, code that assumes:

```text
schema.sql is next to this file
market.sqlite lives under ./database/
icons are available through a relative path
```

may work from VS Code but fail inside a bundled executable.

This does not mean the app logic is wrong.

It means the runtime environment changed.

Didactically, this teaches that paths are part of an application's execution contract.

## 3.4 The Settings page becomes more important in a user-run app

In developer mode, configuration can be edited manually or changed in code.

In user mode, configuration needs a user-facing surface.

For Markei, the Settings page is therefore not cosmetic.

It is the proper place for user-adjustable behavior such as:

```text
default reorder threshold
possibly database backup/export later
possibly display preferences later
```

The user should not need to edit Python files or database rows to adjust normal behavior.

## 3.5 Installer decisions are design decisions, not just tooling decisions

Choosing an installer or packaging tool is operational.

But the consequences are architectural and didactic.

The chosen delivery method affects:

```text
where files are installed
where data is stored
how updates happen
how dependencies are bundled
how users launch the app
how errors are reported
```

Therefore, `executable`, `installer`, and `packaging` are not isolated vocabulary words.

They describe the boundary between a programming project and a usable application.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
4. TEMPORARY CONCEPT CANDIDATES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## && Release artifact

A release artifact is a generated file or bundle intended for distribution.

For Markei, possible release artifacts include:

```text
Markei.exe
Markei installer
portable Markei folder
versioned release zip
```

This concept may later belong to Operational or Didactic permanent knowledge depending on Main synthesis.

## && User data ownership

User data ownership means the data created through normal app use belongs to the user and should not be treated like disposable development material.

For Markei, this applies strongly to:

```text
market.sqlite
purchase history
product duration calculations
settings
```

This concept may later connect to design decisions about database location, backups, and migrations.

## && Frozen Python application

A frozen Python application is a Python program bundled so that it can run without the user manually installing Python packages.

The app is still logically Python-based, but it is delivered in a form closer to a normal desktop program.

This concept may later connect to packaging tools such as PyInstaller or Nuitka.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
5. KNOWLEDGE REGISTER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## New staged concepts from this lesson

### &&& Script vs Application

A script relies on developer context to run. An application is prepared for normal user operation.

### &&& Executable

A launchable program file that the operating system can start directly, such as `Markei.exe` on Windows.

### &&& Installer

A delivery program that places the application and related files onto the user's machine.

### %%% Dependency

A runtime requirement that Markei needs in order to execute, such as PySide6.

### %%% Packaging

The process of collecting code, dependencies, runtime files, and resources into a distributable form.

### &%% Local Database

A database stored on the user's machine, represented in Markei by SQLite.

### &%% App Data Folder

A user-specific folder for persistent data and settings separate from the installation folder.

### &&& User-Facing Interface

The interface intended for normal users, such as Markei's PySide6 pages.

### &&& Developer Interface

The interface used by developers to run, inspect, debug, and maintain the app, such as terminal commands and stack traces.

## Concept grouping note

The lesson formally introduced five lecture groups to preserve didactic structure:

```text
1. Script vs Application
2. Executable and Installer
3. Dependency and Packaging
4. Local Database and App Data Folder
5. User-Facing Interface vs Developer Interface
```

The requested focus terms are all included inside those five groups.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
6. ARCHITECTURAL SPINE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Oldest unresolved didactic dependency for this topic:

```text
Markei needs a clear distinction between project files, bundled application files, and user-owned data files.
```

Until this distinction is understood, packaging discussions may collapse into a misleading question:

```text
How do we make an exe?
```

The better learning sequence is:

```text
1. Understand what currently depends on the development environment.
2. Separate launch concerns from installation concerns.
3. Separate dependencies from source code.
4. Separate program files from user data.
5. Only then choose packaging and installer tools.
```

Next suggested lesson:

```text
Release workflow: build, test, package, install, update, and verify user data preservation.
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
7. DIDACTIC CONCLUSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Turning Markei into a user-run application means changing the execution contract.

The development contract is:

```text
A developer with Python, dependencies, repository access, and terminal knowledge can run the app.
```

The user contract should become:

```text
A user can install/open Markei, use its visible interface, and keep their purchase data safely between sessions and updates.
```

The main conceptual movement is therefore:

```text
from command-based execution
    to application launch

from source-folder assumptions
    to packaged runtime assumptions

from repository database
    to user-owned app data

from developer diagnostics
    to user-facing behavior
```

This lesson does not prescribe a packaging tool or implementation patch.

It prepares the concepts needed for Main Chat, Operational Chat, Design Chat, and Codex to later discuss packaging without confusing development convenience with user application behavior.
