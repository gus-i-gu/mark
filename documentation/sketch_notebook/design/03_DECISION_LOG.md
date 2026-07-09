# Design Decisions

## Preserve the Repository Object Boundary

Status: Accepted for current MVP repair.

Context:

`services.py` imports and instantiates `Repository`, but `repository.py` did not
expose a top-level `Repository` class.

Decision:

Restore a concrete `Repository` class in `app/core/repository.py`, compatible
with `RepositoryContract`.

Consequences:

- The service layer remains free of SQL.
- The repository layer remains the persistence adapter.
- `database.py` remains responsible for SQLite lifecycle.
- Later dependency injection may allow `ProductService(repository:
  RepositoryContract | None = None)`.

## Keep Price Variation Color Mapping in the UI Layer

Status: Accepted for current MVP repair.

Context:

`StoragePage` failed with `KeyError: "color"` because it expected
`ProductService` price-variation output to contain a presentation key named
`color`.

Decision:

`ProductService` should remain responsible for price variation semantics only.
`StoragePage`, or a future UI-side presentation mapper, should translate
semantic price variation into `QColor` or other visual styling.

Consequences:

- The service layer remains free of PySide6/Qt.
- Service return values remain semantic rather than presentation-specific.
- UI remains responsible for visual choices.
- Future interfaces can reuse `ProductService` without importing Qt.

## Keep Markei Local-First for MVP

Status: Accepted.

Context:

Markei is a household purchase-memory app. Its MVP value does not require
accounts, cloud services, scraping, barcode services, remote APIs, or
analytics.

Decision:

Keep supermarket/product/purchase data local to the user's machine. Future sync
or cloud features must be optional and explicitly user-controlled.

## Simplify User-Facing Navigation

Status: Accepted as MVP design direction.

Context:

The current UI exposes Register, Storage, Shortage, Market, History, and
Settings as equal top-level tabs. This mirrors internal project concepts but may
overburden first users.

Decision:

Move toward Add Purchase, Inventory, History, and Settings as the primary
user-facing surfaces. Treat Storage, Shortage, and Market as sections/filters
inside Inventory.

Consequences:

Internal modules may remain unchanged initially. User-facing labels and
navigation can be simplified first.

## Separate Installed Program Files From User Data

Status: Accepted.

Context:

A packaged app should not store live user data inside the application bundle or
installation folder.

Decision:

Bundled resources such as `schema.sql` and `seed.sql` belong with application
resources. The live `market.sqlite` database belongs in a user-writable app data
folder.

Consequences:

Packaging work must update database path handling before Markei is treated as
reliably installable for non-developer users.
