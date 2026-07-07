# Product Interface Notes

## Add-First MVP Flow

First-user flow should be Add-first.

When the database is empty, Markei should guide the user to register the first
supermarket purchase rather than showing all conceptual tabs with no data.

After the first save, Markei should show what was saved and communicate that
predictions improve after repeated purchases of the same product.

## Simplified MVP Information Architecture

```text
Add Purchase
    manual receipt entry and save feedback

Inventory
    In stock / Ending soon / Buy again sections or filters

History
    read-only audit trail of registered purchases

Settings
    preferences, data location, backup/export, reset with confirmation,
    version/about
```

Internal modules may remain unchanged while user-facing labels and navigation
are simplified in a later implementation milestone.
