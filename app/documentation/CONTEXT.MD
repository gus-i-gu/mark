##CONTEXT 01

# Markei
## Backend Reconstruction Brief
### Sprint 04A – Backend Architecture

---

# Project Overview

Markei is a desktop-first supermarket inventory application designed around **manual receipt registration**.

The application does **not** use:

- barcode scanning
- OCR
- receipt parsing
- web scraping
- online price APIs
- automatic inventory tracking

The user manually registers every purchased item from a supermarket receipt.

The application remembers purchase history and predicts future purchases based on previous buying patterns.

The project is being developed with desktop as the primary target and Android as the second platform.

---

# Core Philosophy

A Product is **not** a purchase.

A Product is the current summary of an item's state.

A Purchase is an immutable historical record.

Every receipt line always creates one Purchase.

Products are summaries reconstructed from Purchase history.

---

# Business Workflow

```
Add Receipt

↓

Product exists?

        │

   ┌────┴────┐

   │         │

 NO         YES

   │         │

Create      Update editable metadata

Product

   │

Insert Purchase

   │

Recalculate Product Summary

   │

Persist Product

   │

Refresh UI
```

The "Add Receipt" workflow is the primary business operation of the application.

---

# Layered Architecture

```
Desktop UI

↓

ProductService

↓

Repository

↓

Database

↓

SQLite
```

Responsibilities are strictly separated.

---

# Current Backend Structure

```
contracts.py
schema.sql
models.py
database.py
repository.py
services.py
```

---

# contracts.py

Defines the public interfaces of the backend.

Contains:

- RepositoryContract
- ServiceContract

No implementation.

---

# schema.sql

Defines every SQLite table.

Main tables:

- products
- purchases
- categories
- stores
- promotions

Products contain only summary information.

Purchases contain the immutable history.

---

# models.py

Domain dataclasses.

Contains:

- Product
- Purchase
- Category
- Store
- Promotion

Models mirror the schema.

---

# database.py

Responsible only for:

- SQLite configuration
- initialization
- schema execution
- seed execution
- connections
- closing

Contains no SQL business logic.

---

# repository.py

Persistence layer.

Responsibilities:

- SQL execution
- CRUD
- row conversion
- persistence

Repository knows:

- SQLite
- SQL
- schema

Repository never performs business calculations.

---

# services.py

Business layer.

Responsibilities:

- register_receipt()
- update_product()
- delete_product()
- delete_purchase()
- recalculate_product()

Contains all business rules.

No SQL.

---

# Product Summary

Products cache the latest calculated state.

Cached fields include:

- current_quantity
- current_unit_price
- previous_unit_price
- current_purchase_date
- previous_purchase_date
- average_duration_days
- average_daily_consumption
- expected_next_purchase
- price_delta
- price_delta_percent

These values are generated exclusively by:

```
ProductService.recalculate_product()
```

No other component may calculate or directly edit them.

---

# Purchase Philosophy

Purchases are immutable.

Receipt registration always inserts a new Purchase.

Purchases are never edited.

They may only be deleted.

---

# Current Sprint Status

Completed:

- contracts.py
- schema.sql
- models.py
- database.py
- repository.py
- services.py

Desktop UI has **not** yet been migrated to the new backend.

---

# Current Issue

Application currently fails during startup.

Latest traceback:

```
ImportError:
cannot import name 'Repository'
from app.core.repository
```

Likely causes:

- repository import failure
- syntax error
- indentation issue
- import-time exception

This should be debugged before touching the UI.

---

# Immediate Next Sprint

1. Audit repository.py.
2. Fix backend import chain.
3. Launch desktop application.
4. Update Register Page.
5. Reconnect:
   - Storage
   - Shortage
   - Market
6. Begin UI polish.
7. Build installer.
8. Prepare Android adaptation.

---

# Development Principles

- Business logic belongs only in ProductService.
- SQL belongs only in Repository.
- Database handles only connections and initialization.
- Models mirror schema.
- Contracts define public APIs.
- Desktop and Android must consume the same backend.

---

# Long-Term Goal

Maintain a single backend architecture that can be reused by:

- Desktop (PySide6)
- Android
- Future web/API clients

Only the presentation layer should change between platforms.

□ contracts.py audited
□ schema.sql audited
□ models.py audited
□ database.py audited
□ repository.py audited
□ services.py audited

↓

Backend imports

↓

Desktop UI integration

↓

Application boot

↓

Functional testing

↓

Packaging

↓

Android adaptation