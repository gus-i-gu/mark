# Sprint 03.5
## Receipt Registration Refactor

Status
------
Planning

Objective
---------
Refactor the receipt registration workflow so that:

- Register Page becomes a Receipt Entry page.
- Product becomes a database summary.
- Purchase becomes immutable history.
- Every receipt updates both Product and Purchase consistently.

Current Problem
---------------

Current workflow

Register Page
        │
        ▼
register_receipt()

        │

Product exists?

        │

YES ───────────────► create_purchase()

NO  ─► create_product()

                │

                ▼

update_product_summary()

Consequences

✓ Purchase history updates

✓ Consumption cycle updates

✓ Expected purchase updates

✗ Quantity becomes stale

✗ Price becomes stale

✗ Brand becomes stale

✗ Price delta never updates

Root Cause
----------

Existing products are never updated during receipt registration.

Only Purchase receives new information.

Product remains frozen.

Desired Architecture
--------------------

Register Page

↓

register_receipt()

↓

Repository.get_product()

↓

Exists?

│

├── No
│
│   create_product()
│
└── Yes
    │
    apply_receipt_to_product()

↓

repository.update_product()

↓

create_purchase()

↓

recalculate_product()

↓

refresh pages

New Responsibilities
--------------------

Product
--------

Represents ONLY current state.

Contains

- current quantity
- current price
- previous price
- purchase dates
- prediction
- averages

Purchase
---------

Immutable history.

Never edited.

Every receipt creates one Purchase.

UI
--

Add button

Registers receipt.

Update button

Edits product metadata only.

Delete button

Deletes product.

Double click

Storage
Shortage
Market

↓

Register Page

↓

Edition mode

↓

Update button enabled

Files to Modify
---------------

app/services.py

- register_receipt()
- create_product_from_receipt()
+ apply_receipt_to_product()
+ recalculate_product()

app/repository.py

Existing update_product()

May only require small additions.

app/models.py

No structural changes expected.

app/ui/pages/register_page.py

Add mode

Edition mode

Automatic switching

app/ui/main_window.py

Edition routing already exists.

Verify only.

app/ui/pages/storage_page.py

Double-click

Already implemented.

Verify only.

Same for

- shortage_page.py
- market_page.py

Acceptance Criteria
-------------------

[ ] New receipt updates Product

[ ] New receipt creates Purchase

[ ] Quantity updates

[ ] Price updates

[ ] Previous price preserved

[ ] Delta price displayed

[ ] Prediction recalculated

[ ] Storage refreshed

[ ] Shortage refreshed

[ ] Market refreshed