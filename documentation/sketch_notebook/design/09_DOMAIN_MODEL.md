# Domain Model Notes

## Repository Boundary

Repository is not a domain entity.

Repository is an infrastructure/persistence adapter that reconstructs domain
models from database rows.

`Product`, `Purchase`, `Category`, and `Store` remain domain data structures.

Promotion support should remain deferred unless the model and schema clearly
support it. The current schema contains a `promotions` table, but the current
domain model does not define a `Promotion` class.

## Price Variation Meaning

Price variation has two layers of meaning.

Business/application meaning:

- price increased;
- price decreased;
- price stayed same;
- price comparison unavailable.

Presentation meaning:

- red or orange text;
- green text;
- neutral gray text;
- icon or badge choice.

The first belongs to `ProductService`.

The second belongs to `StoragePage` or another UI-side presentation component.

## Local User Data Boundary

`market.sqlite` is not a bundled program resource.

It is user-owned application data.

The database schema and seed files define how the first database is created.
After creation, the live database belongs to the user and should not be
destructively recreated during normal startup.
