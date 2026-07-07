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
