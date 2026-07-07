# Sprint 04
## Android Preparation

Current State
-------------

Desktop MVP

✓ Register

✓ Storage

✓ Shortage

✓ Market

✓ History

✓ Settings

✓ SQLite

✓ Business Layer

Next Goal
---------

Keep exactly the same architecture.

Only replace Desktop UI.

Architecture
------------

UI

↓

ProductService

↓

Repository

↓

SQLite

Everything below UI remains identical.

Files that MUST remain platform-independent
-------------------------------------------

app/models.py

app/repository.py

app/services.py

app/config.py

Only UI will change.

Desktop UI
----------

Current

PySide6

Future

Archive inside

desktop/

Mobile UI
---------

mobile/

Kivy

or

KivyMD

New Mobile Pages
----------------

Register

Storage

Shortage

Market

History

Settings

Service Calls
-------------

The mobile interface should NEVER manipulate SQLite directly.

Only call

ProductService

Examples

Register

↓

service.register_receipt()

Storage

↓

service.get_storage_products()

History

↓

service.get_history()

Market

↓

service.get_market_products()

Shortage

↓

service.get_shortage_products()

Development Order
-----------------

Phase 1

Business Layer Refactor

✓ Sprint 03.5

Phase 2

Freeze services.py

No more UI logic inside.

Phase 3

Create

mobile/

Phase 4

Install

KivyMD

Phase 5

Bottom Navigation

Register

Storage

Shortage

Market

History

Settings

Phase 6

Bind widgets to ProductService

No duplicated business logic.

Phase 7

Android Packaging

Buildozer

APK

Future Improvements
-------------------

Barcode Scanner

Receipt OCR

Cloud Backup

Statistics

Charts

Price Trends

Notifications

Export

Synchronization

Google Drive

Next Sprint Definition
----------------------

Sprint 03.5 finishes when:

✓ Receipt registration updates Product.

✓ Receipt registration creates Purchase.

✓ Product summary stays synchronized.

✓ Desktop UI is stable.

Sprint 04 begins immediately afterwards.