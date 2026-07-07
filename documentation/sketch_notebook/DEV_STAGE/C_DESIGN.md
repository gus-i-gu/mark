# [D] Session 003 | 11:12_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Design Chat

Responsibility: product/interface design, architecture, responsibility boundaries, user-facing simplification, and long-term structural coherence.

This pass evaluates the product/interface design needed for a simplified user-facing Markei version.

No application source code was edited.
No permanent notebook files were edited.
Only this assigned Design staging file was updated.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Read successfully:

- AGENTS.md
- documentation/sketch_notebook/INDEX.md
- documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
- documentation/sketch_notebook/methodology/PROMOTION_RULES.md
- documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
- documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
- documentation/sketch_notebook/methodology/FLUX.md
- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
- app/main.py
- app/desktop/main_window.py
- app/desktop/ui/pages/register_page.py
- app/desktop/ui/pages/storage_page.py
- app/desktop/ui/pages/settings_page.py
- app/core/services.py
- app/core/config.py
- app/core/database.py

Relevant methodology constraints:

- Design Chat writes only `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`.
- Design Chat does not edit application source code.
- Design Chat does not edit permanent notebook folders.
- Design Chat stages architectural and product-interface reasoning for Main Chat synthesis.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK ANALYSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Evaluate the product/interface design needed for a simplified user-facing Markei version.

Focus areas:

1. first-user flow;
2. whether tabs should remain or be simplified;
3. essential MVP pages for users;
4. installable desktop app boundaries;
5. settings/database responsibility;
6. what should stay local-only.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. CURRENT PRODUCT SHAPE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The current desktop UI exposes six top-level tabs:

- Register
- Storage
- Shortage
- Market
- History
- Settings

Current structural observations:

1. `RegisterPage` is explicitly documented as the only writable page.
2. `StoragePage`, `ShortagePage`, and `MarketPage` are inventory interpretation pages.
3. `HistoryPage` is a read-only record surface.
4. `SettingsPage` currently exists as a placeholder.
5. `MainWindow` owns navigation through a `QTabWidget` and directly creates all pages.
6. `ProductService` is the business/application service exposed to the UI.
7. `database.py` owns SQLite database creation, connection configuration, and schema initialization.
8. `config.py` currently owns project constants such as app name, version, database name, database directory, date format, and default reorder threshold.

Design implication:

    The internal architecture is already organized around clear domain surfaces,
    but the user-facing navigation is heavier than the simplified MVP requires.

The six current tabs are useful for development because each tab corresponds to a project concept. For first users, however, the same division risks making the app feel like a database tool rather than a small domestic assistant for remembering what exists, what is ending, and what should be bought again.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2. FIRST-USER FLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Recommended first-user flow:

    Open app
    ↓
    Local database check
    ↓
    If no database exists: create local database automatically
    ↓
    Show simple empty state
    ↓
    Guide user to register first purchase
    ↓
    Save receipt line
    ↓
    Refresh inventory summary
    ↓
    Show what Markei can infer after first data exists

The first launch should not begin with all app concepts exposed equally.

The user should first understand one sentence:

    Markei helps you manually register supermarket purchases and remember what is probably still at home, ending soon, or ready to buy again.

First-run experience should prioritize confidence over completeness.

Minimum first-user flow states:

1. Empty database state

    Message:

        No products registered yet.
        Start by adding one item from your latest supermarket receipt.

    Primary action:

        Add first product

2. First product registration

    Required visible fields should be reduced to the minimum necessary:

    - Product name
    - Brand, optional
    - Quantity
    - Unit
    - Price
    - Purchase date

    Advanced fields such as category, store ID, notes, promotion details, internal product ID, and calculated fields should not dominate the first-user screen.

3. First save confirmation

    After the first item is saved, Markei should immediately answer:

    - what was saved;
    - where it now appears;
    - what the app still cannot infer until more purchases exist.

4. First learning loop

    Because duration prediction requires repeated purchases, the UI should communicate this gently:

        Markei will estimate product cycles after you register the same product more than once.

This avoids promising prediction before the data exists.

Design decision candidate:

    First use should be Register-first, not dashboard-first.

Reason:

    Markei has no useful dashboard until at least one product exists.
    The first successful registration is the activation moment of the application.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
3. SHOULD TABS REMAIN?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Decision candidate:

    Keep tabs internally for now, but simplify the user-facing navigation.

Current six-tab layout is structurally understandable for development, but too exposed for a simplified user-facing MVP.

Problem with current top-level tabs:

- Storage, Shortage, and Market are not truly separate workflows.
- They are three filtered interpretations of inventory state.
- First users must learn app vocabulary before seeing value.
- The tab row suggests that all pages are equally important.
- Settings appears as a full peer to core workflows even though it should be secondary.

Recommended simplified navigation:

    1. Add Purchase
    2. Inventory
    3. Shopping List
    4. History
    5. Settings

Even better for the earliest MVP:

    1. Add
    2. Home
    3. History
    4. Settings

Where:

- Home contains inventory summary, ending soon, and buy again sections.
- Add is the receipt-entry workflow.
- History is read-only past purchases.
- Settings is secondary.

Alternative if preserving current concepts with less cognitive weight:

    Top-level:

    - Register
    - Products
    - History
    - Settings

    Inside Products:

    - In stock
    - Ending soon
    - Buy again

This keeps the domain distinction without making the user navigate six separate tabs.

Recommended MVP direction:

    Merge Storage, Shortage, and Market into one user-facing inventory/shopping surface.

The terms can remain internally:

- Storage = safe / still available
- Shortage = ending soon
- Market = expected ended / buy again

But the user-facing labels should be simpler:

- In stock
- Ending soon
- Buy again

Design decision candidate:

    Do not remove the architectural concepts.
    Reduce their navigation exposure.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
4. ESSENTIAL MVP USER PAGES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Essential MVP pages for simplified users:

1. Add Purchase / Register

Purpose:

    Let the user manually enter one purchased product from a receipt.

Responsibilities:

- create or update product record;
- create purchase record;
- trigger recalculation;
- refresh visible summaries;
- show success/failure feedback.

User-facing simplification:

- Rename `Register` to `Add Purchase` or `Add`.
- Hide internal IDs unless needed.
- Make category/store/notes optional or advanced.
- Keep the manual receipt-entry promise clear.

2. Home / Inventory

Purpose:

    Show what the user probably has and what needs attention.

Responsibilities:

- show products in stock;
- show products ending soon;
- show products expected to be depleted;
- let the user select a product and edit it;
- provide a refresh action only if necessary.

User-facing simplification:

- One page with sections or filters is preferable to three separate tabs.
- The app should answer: "What do I have?" and "What should I buy?" without requiring the user to understand Storage/Shortage/Market as technical categories.

3. Shopping List / Buy Again

Purpose:

    Show products Markei believes should be bought again.

This can either be:

- its own page, if buying again is the main user action;
- a section inside Home/Inventory, if keeping the MVP very small.

Recommendation:

    For the smallest MVP, make Buy Again a section/filter inside Inventory.
    Later, promote it to a dedicated Shopping List page if it becomes the central workflow.

4. History

Purpose:

    Preserve trust by showing what was registered.

Responsibilities:

- show purchase records;
- allow inspection of past prices and dates;
- support debugging of user mistakes;
- support future product-cycle understanding.

MVP status:

    History is important, but it can be visually secondary.

Reason:

    Users need to trust a local manual-data app. If something looks wrong in Inventory, History is how they verify whether they entered the receipt correctly.

5. Settings

Purpose:

    Control app-level preferences and local data management.

MVP status:

    Essential, but minimal.

Settings should not be a complex administration console.

Minimum settings:

- default reorder threshold in days;
- database location display;
- backup/export local data;
- restore/import local data, later if needed;
- reset database, protected by strong confirmation;
- app version/about.

Non-essential for first MVP:

- account settings;
- cloud sync;
- remote login;
- barcode integrations;
- scraping;
- multi-user sharing;
- store account integrations;
- remote analytics.

Recommended first MVP page set:

    Add Purchase
    Inventory
    History
    Settings

Recommended future page set:

    Home
    Add Purchase
    Shopping List
    Products
    History
    Settings

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
5. INSTALLABLE DESKTOP APP BOUNDARIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Markei should remain an installable local desktop app for the simplified user-facing version.

User-facing boundary:

    The app lives on the user's computer.
    The user's supermarket data lives on the user's computer.
    The app does not require an account or internet connection for MVP use.

Installer responsibilities:

- install application files;
- ensure the app can start from a normal desktop shortcut/menu entry;
- create or locate the local application data directory;
- initialize the local SQLite database if missing;
- avoid requiring the user to run Python commands;
- avoid requiring the user to inspect repository files;
- avoid exposing schema/database implementation during normal use.

The installed app should not feel like a development checkout.

Developer-facing structure may include:

- source files;
- schema files;
- seed files;
- repository modules;
- service modules;
- notebook files.

User-facing installation should expose:

- the app launcher;
- maybe a local data folder through Settings;
- maybe export/backup files chosen by the user.

Design boundary:

    The user should not need to know that Markei uses SQLite.
    But the user should be able to know where their local data is and how to back it up.

Packaging implication:

    Hard-coded development-relative database paths should eventually become install-safe application-data paths.

The current configuration points the database directory through project configuration. This is acceptable during development, but installed builds should not depend on the app being run from a repository-shaped folder.

Recommended design distinction:

- Development database path: repository-local, useful for debugging.
- Installed database path: user-local application data directory.
- Settings page: displays the active data location in human terms.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
6. SETTINGS AND DATABASE RESPONSIBILITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Settings responsibilities:

- expose user preferences;
- show local data information;
- provide safe user-controlled maintenance actions;
- protect dangerous actions with confirmation;
- avoid exposing low-level database operations.

Database responsibilities:

- create database directory;
- create SQLite database;
- execute schema;
- configure SQLite connections;
- provide connections to Repository;
- avoid business calculations;
- avoid UI decisions;
- avoid user-facing settings logic.

Repository responsibilities:

- execute SQL;
- store and retrieve product/purchase records;
- reconstruct domain objects;
- hide SQL details from ProductService.

ProductService responsibilities:

- register purchases;
- apply business rules;
- calculate product summaries;
- expose application-level operations to UI;
- remain independent from UI widgets and SQLite details.

Settings page should not directly manipulate database internals.

Acceptable Settings actions:

1. Change default reorder threshold

    This is a user preference.
    It affects product status calculations.
    It should be stored persistently, but not hard-coded forever in config if the user can change it.

2. Show data location

    This improves trust and local-only transparency.

3. Export backup

    This should copy/export the local database or export user-readable data.
    The user controls the destination.

4. Restore backup

    This is useful later, but should be protected because it can replace current data.

5. Reset database

    This is dangerous and should require explicit confirmation.
    It should not be presented casually.

Unacceptable Settings responsibilities:

- editing tables directly;
- running arbitrary SQL;
- showing schema internals as normal UI;
- bypassing ProductService/Repository for normal product operations;
- making the user manage database initialization manually.

Design decision candidate:

    Settings owns user preferences and safe data-management commands.
    database.py owns database lifecycle mechanics.
    ProductService owns business meaning.
    Repository owns persistence operations.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
7. WHAT SHOULD STAY LOCAL-ONLY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

For the simplified MVP, the following should stay local-only:

1. Product list

Includes product names, brands, quantities, units, current prices, notes, and product identifiers.

2. Purchase history

Includes receipt-line entries, dates, prices, stores if used, promotions, and quantities.

3. Prediction data

Includes average duration, expected next purchase, remaining days, shortage status, and market/buy-again status.

4. User settings

Includes reorder threshold, interface preferences, and local data choices.

5. Database file

The SQLite database should remain on the user's machine.

6. Backups and exports

Backups should be created only when the user explicitly chooses to export them.

7. App analytics

No analytics are needed for MVP.

8. Accounts and identity

No user account is needed for MVP.

9. Store integrations

No supermarket login, scraping, barcode service, or remote price API should be required for MVP.

10. Network access

The app should be usable offline.

Design decision candidate:

    Markei MVP should be local-first and offline-capable.
    Any future cloud or sync feature must be optional and explicitly user-controlled.

Reason:

    The app's value comes from manual household purchase memory, not from online services.
    Requiring accounts, sync, scraping, or remote integrations would increase complexity before the core habit is proven.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
8. SIMPLIFIED USER-FACING INFORMATION ARCHITECTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Recommended simplified IA for MVP:

    Add Purchase
        manual receipt entry
        success feedback
        edit current product when needed

    Inventory
        all products
        filters/sections:
            In stock
            Ending soon
            Buy again
        double-click or action to edit product

    History
        purchase records
        price/date audit trail
        support trust and correction

    Settings
        reorder threshold
        data location
        backup/export
        reset database with confirmation
        app version

Optional Home version:

    Home
        summary cards:
            In stock count
            Ending soon count
            Buy again count
        quick action:
            Add purchase
        list preview:
            Buy again / Ending soon

    Add Purchase
    Inventory
    History
    Settings

Recommendation:

    Use the four-page MVP first.
    Add Home only if the Inventory page becomes too dense or if first-launch guidance needs a landing surface.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
9. NAMING RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current technical names:

- Register
- Storage
- Shortage
- Market
- History
- Settings

Recommended user-facing names:

- Add Purchase
- Inventory
- Ending Soon
- Buy Again
- History
- Settings

Recommended structural simplification:

- `Register` becomes `Add Purchase`.
- `Storage` becomes `Inventory` or an `In stock` filter inside Inventory.
- `Shortage` becomes `Ending soon`.
- `Market` becomes `Buy again` or `Shopping list`.
- `History` remains `History`.
- `Settings` remains `Settings`, but secondary.

Design decision candidate:

    User-facing vocabulary should describe household action, not internal classification.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
10. MVP DESIGN CONCLUSIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Conclusion 1 — First-user flow should be Add-first.

The app has no meaningful prediction before user data exists. The first success moment is registering a purchase.

Conclusion 2 — Tabs may remain technically, but should be simplified visually.

A `QTabWidget` can remain as a practical MVP navigation mechanism, but six equally weighted tabs should not be the final simplified product shape.

Conclusion 3 — Storage, Shortage, and Market should become sections or filters.

They are interpretations of product status, not separate user workflows.

Conclusion 4 — Essential MVP pages are Add Purchase, Inventory, History, and Settings.

Shopping List / Buy Again can initially be a section inside Inventory, then promoted later if it becomes central.

Conclusion 5 — Installed desktop app should hide development machinery.

The user should launch Markei like a normal app, not run Python or manage project folders.

Conclusion 6 — Settings should manage user preferences and safe local data actions.

Settings should not become a database editor.

Conclusion 7 — Database lifecycle belongs to database.py and persistence operations belong to Repository.

Settings can request safe operations, but should not own SQLite mechanics.

Conclusion 8 — MVP should stay local-only.

No accounts, cloud sync, remote services, scraping, barcode APIs, or analytics are required for the simplified MVP.

Conclusion 9 — Prediction should be explained as learned from repeated purchases.

The UI should not overpromise on first use.

Conclusion 10 — The simplified product should feel like a household memory tool, not a database UI.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MAIN CHAT SYNTHESIS REQUEST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Main Chat should synthesize this design-stage report into materialization instructions only if it decides the UI should be simplified now.

Recommended synthesis direction:

1. Preserve the current architecture boundaries:

    UI
    ↓
    ProductService
    ↓
    Repository
    ↓
    database.py / SQLite

2. Rename user-facing concepts without necessarily renaming internal modules immediately.

3. Reduce top-level navigation from six tabs toward four user-facing surfaces:

    Add Purchase
    Inventory
    History
    Settings

4. Treat Storage, Shortage, and Market as inventory status filters or sections.

5. Keep local SQLite as the MVP persistence mechanism.

6. Move installed-app database location planning into a future packaging/design task.

7. Keep Settings minimal:

    - reorder threshold;
    - data location;
    - backup/export;
    - reset with confirmation;
    - version/about.

8. Keep all supermarket/product/purchase data local-only for MVP.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STAGING RESULT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Design evaluation staged successfully.

Writable file used:

    documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md

No source files changed.
No permanent notebook files changed.
No methodology files changed.
