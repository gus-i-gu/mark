# Domain Model Notes

## Repository Boundary

Repository is not a domain entity.

Repository is an infrastructure/persistence adapter that reconstructs domain
models from database rows.

`Product`, `Purchase`, `Category`, and `Store` remain domain data structures.

Promotion support should remain deferred unless the model and schema clearly
support it. The current schema contains a `promotions` table, but the current
domain model does not define a `Promotion` class.
