"""
models.py

Markei Domain Models

Every class represents one persistent entity.

Models DO NOT

- execute SQL
- calculate business rules
- manipulate the database

Models only describe domain entities.

Architecture

UI
↓

Service
↓

Repository
↓

Models
↓

SQLite
"""

from dataclasses import dataclass
from typing import Optional


###########################################################
#
# CATEGORY
#
###########################################################

@dataclass(slots=True)
class Category:
    """
    Product category.
    """

    id: str

    name: str

    description: Optional[str] = None


###########################################################
#
# STORE
#
###########################################################

@dataclass(slots=True)
class Store:
    """
    Store where purchases occur.
    """

    id: Optional[int]

    name: str

    city: Optional[str] = None

    state: Optional[str] = None

    def __str__(self) -> str:

        return self.name


###########################################################
#
# PRODUCT
#
###########################################################

@dataclass(slots=True)
class Product:
    """
    Permanent inventory record.

    Exactly one Product exists for each product ID.

    Product stores

    • Editable metadata

    • Inventory state

    • Cached analytical summary

    Historical purchases belong to Purchase.
    """

    #######################################################
    # Editable
    #######################################################

    id: str

    category_id: str

    product_name: str

    brand: Optional[str] = None

    unit: str = "un"

    minimum_quantity: float = 0.0

    reorder_threshold: int = 0

    notes: Optional[str] = None


    #######################################################
    # Inventory
    #######################################################

    current_quantity: float = 0.0


    #######################################################
    # Cached Summary
    #######################################################

    current_unit_price: Optional[float] = None

    previous_unit_price: Optional[float] = None

    current_purchase_date: Optional[str] = None

    previous_purchase_date: Optional[str] = None

    average_daily_consumption: float = 0.0

    average_duration_days: Optional[int] = None

    expected_next_purchase: Optional[str] = None

    price_delta: Optional[float] = None

    price_delta_percent: Optional[float] = None


    #######################################################
    # Metadata
    #######################################################

    created_at: Optional[str] = None


    #######################################################
    # Helpers
    #######################################################

    @property
    def has_purchase_history(self) -> bool:

        return self.current_purchase_date is not None


    @property
    def has_previous_purchase(self) -> bool:

        return self.previous_purchase_date is not None


    @property
    def has_price_history(self) -> bool:

        return (

            self.current_unit_price is not None

            and

            self.previous_unit_price is not None

        )


    #######################################################

    def __str__(self) -> str:

        return f"{self.id} - {self.product_name}"


###########################################################
#
# PURCHASE
#
###########################################################

@dataclass(slots=True)
class Purchase:
    """
    Immutable purchase ledger.

    Every Add Receipt generates exactly
    one Purchase.

    Purchases are never edited.

    If entered incorrectly they may only
    be deleted.
    """

    #######################################################
    # Identity
    #######################################################

    id: Optional[int] = None


    #######################################################
    # Relationships
    #######################################################

    product_id: str = ""

    store_id: Optional[int] = None


    #######################################################
    # Receipt
    #######################################################

    purchase_date: str = ""

    quantity: float = 0.0

    unit: str = "un"

    unit_price: float = 0.0

    total_price: float = 0.0

    promotion: bool = False

    notes: Optional[str] = None


    #######################################################
    # Helpers
    #######################################################

    @property
    def has_store(self) -> bool:

        return self.store_id is not None


    @property
    def is_promotional(self) -> bool:

        return self.promotion


    @property
    def subtotal(self) -> float:

        return self.total_price


    #######################################################

    def __str__(self) -> str:

        return (

            f"Purchase #{self.id}"

            f" | "

            f"{self.product_id}"

            f" | "

            f"{self.purchase_date}"

        )