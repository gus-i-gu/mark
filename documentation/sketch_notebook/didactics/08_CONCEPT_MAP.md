# Concept Map

```text
Python import system
    -> module namespace
    -> exported symbol
    -> class declaration

ImportError
    -> module found but symbol missing

ModuleNotFoundError
    -> module path not found

Repository Pattern
    -> service layer
    -> persistence layer
    -> RepositoryContract
    -> concrete implementation

ProductService
    -> depends on Repository-compatible object
    -> should not know SQL

Repository
    -> implements RepositoryContract
    -> owns SQL operations
    -> maps sqlite3 rows to domain models
```

```text
Python dictionary
    -> key
    -> value
    -> direct lookup
    -> safe lookup
    -> KeyError

KeyError
    -> runtime exception
    -> stack trace
    -> missing key

StoragePage initialization
    -> service-to-UI contract
    -> product display data
    -> presentation metadata

ProductService
    -> business data
    -> price variation semantics

StoragePage
    -> presentation data
    -> maps semantic data to visual style

PySide6 / Shiboken
    -> Python-to-C++ type conversion
    -> warning may be separate from Python exception
```

```text
Developer-run project
    -> Python interpreter
    -> virtual environment
    -> requirements.txt
    -> terminal command
    -> repository-relative paths

User-run application
    -> executable
    -> installer or portable folder
    -> app data folder
    -> visible interface
    -> persistent user data

Packaging
    -> dependencies
    -> bundled resources
    -> executable
    -> release artifact

Local database
    -> SQLite database file
    -> user data ownership
    -> app data folder
    -> backup/export later

Runtime path contract
    -> source-tree paths
    -> frozen application paths
    -> bundled resources
    -> user-writable data paths
```
