# Markei Architecture

Version
-------
0.1 (Pre-Mobile Refactor)

Purpose
-------
This document defines the software architecture of Markei.

It is the project's technical constitution.

Whenever new features are added, this document has precedence over implementation details.

The objective is to guarantee that every platform
(Desktop, Android and future Web)
shares exactly the same business logic.


----------------------------------------------------------
ARCHITECTURE
----------------------------------------------------------

                    User

                      │

             Desktop (PySide6)

                 Android (Kivy)

                  Future Web

                      │

                      ▼

             Presentation Layer

                      │

                      ▼

               ProductService

                      │

                      ▼

                Repository

                      │

                      ▼

                  SQLite Database



Only the Presentation Layer changes between platforms.

Everything below ProductService must remain platform-independent.



==========================================================
LAYER 01
Presentation
==========================================================

Responsible for

- widgets
- windows
- pages
- dialogs
- navigation
- user interaction

May

✓ display data

✓ collect user input

✓ call ProductService

Must NOT

✗ execute SQL

✗ calculate business rules

✗ manipulate database directly

✗ calculate statistics

✗ decide product status

Current implementation

PySide6

Future

KivyMD


==========================================================
LAYER 02
Business Layer
==========================================================

ProductService

This is the heart of Markei.

Every rule belongs here.

Responsibilities

✓ register receipts

✓ edit products

✓ delete products

✓ calculate duration

✓ estimate next purchase

✓ calculate shortage

✓ calculate market list

✓ calculate average prices

✓ calculate price variation

✓ validate IDs

✓ detect inconsistencies

Presentation must never reproduce these calculations.


==========================================================
LAYER 03
Persistence
==========================================================

Repository

Repository is the only component allowed to communicate with SQLite.

Responsibilities

✓ INSERT

✓ UPDATE

✓ DELETE

✓ SELECT

Must NOT

✗ calculate duration

✗ calculate statistics

✗ calculate predictions

✗ validate business rules


==========================================================
LAYER 04
Database
==========================================================

SQLite

Contains only persisted information.

The database never decides business rules.

It only stores them.


==========================================================
CORE ENTITIES
==========================================================

----------------------------------------------------------
Product
----------------------------------------------------------

Represents the CURRENT state.

Exactly one Product exists for each product ID.

Contains

ID

Category

Name

Brand

Current Quantity

Current Unit Price

Previous Unit Price

Current Purchase Date

Previous Purchase Date

Average Duration

Expected Next Purchase

Reorder Threshold

Notes


----------------------------------------------------------
Purchase
----------------------------------------------------------

Represents historical information.

Purchase records are immutable.

Every supermarket receipt generates one Purchase.

Purchase contains

Product ID

Purchase Date

Unit Price

Quantity

Store

Promotion

Receipt Notes


==========================================================
WORKFLOW
==========================================================

Receipt Registration


User

↓

Register Page

↓

ProductService.register_receipt()

↓

Repository.get_product()

↓

Product exists?


NO

↓

Create Product

↓

Create Purchase

↓

Recalculate Product

↓

Refresh UI


YES

↓

Apply Receipt

↓

Update Product

↓

Create Purchase

↓

Recalculate Product

↓

Refresh UI


==========================================================
PRODUCT EDITION
==========================================================

Storage

↓

Double Click

↓

Register Page

↓

Edition Mode

↓

Update Product

↓

Refresh UI


Edition never creates purchases.


==========================================================
DELETE
==========================================================

Delete removes

Product

Purchase History

Related records

After confirmation.


==========================================================
PRICE SYSTEM
==========================================================

Every receipt updates

previous_unit_price

↓

current_unit_price

↓

price_delta

↓

percentage_variation


UI never calculates prices.

UI only displays ProductService results.


==========================================================
DATE SYSTEM
==========================================================

Database

YYYY-MM-DD

Presentation

DD/MM/YYYY

Conversions happen only inside ProductService.

Presentation never parses dates manually.


==========================================================
IDENTIFIERS
==========================================================

Product ID

Permanent identifier.

Never changes.

If a receipt contains

ID

already associated with another product

the application warns the user.


==========================================================
USER INTERFACE CONTRACT
==========================================================

Every page must obtain data only through ProductService.

Storage

service.get_storage_products()

Market

service.get_market_products()

Shortage

service.get_shortage_products()

History

service.get_purchase_history()

Register

service.register_receipt()

No page may call Repository directly.


==========================================================
MOBILE STRATEGY
==========================================================

Desktop

PySide6

↓

Sprint 03.5

Business Layer stabilized

↓

Sprint 04

Replace only Presentation Layer

↓

KivyMD

↓

APK


The following files should remain identical between Desktop and Android

app/

models.py

repository.py

services.py

config.py

database.py


Only

app/ui/

will be replaced.


==========================================================
PROJECT PRINCIPLES
==========================================================

1.

One source of truth.

Business rules belong to ProductService.

2.

Repository never contains business logic.

3.

Presentation never contains SQL.

4.

Every receipt creates history.

5.

Every product represents current state only.

6.

History is immutable.

7.

UI may change.

Business Layer should not.

8.

Desktop and Android must behave identically.

Only presentation differs.


==========================================================
LONG-TERM ROADMAP
==========================================================

Desktop MVP

✓

Android APK

✓

Cloud Synchronization

□

Barcode Scanner

□

OCR Receipt Import

□

Charts

□

Statistics

□

Multi-user

□

API Price Integration

□

AI Consumption Forecast

□


#####TREE

markei/

app/
│
├── core/
│   ├── models.py
│   ├── services.py
│   ├── repository.py
│   ├── contracts.py
    ├── database.py
│   └── config.py

│
├── desktop/
│   ├── main_window.py
│   └── pages/
│
├── mobile/
│   ├── main.py
│   ├── screens/
│   └── widgets/
│
├── database/
│
└── docs/
    ├── ARCHITECTURE.md
    ├── ROADMAP.md
    ├── WORKFLOW.md
    └── PROJECT.md