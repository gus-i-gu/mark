"""
contracts.py

Canonical architecture contract for Markei.

This file contains NO implementation.

It only defines:

- Domain responsibilities
- Repository responsibilities
- Service responsibilities
- System invariants
"""

from abc import ABC, abstractmethod


###########################################################
#
# DOMAIN CONTRACTS
#
###########################################################

class ProductContract:
    """
    PRODUCT

    Permanent inventory record.

    One row per product.

    Editable by the user.
    """

    EDITABLE_FIELDS = [

        "id",

        "category_id",

        "product_name",

        "brand",

        "unit",

        "minimum_quantity",

        "reorder_threshold",

        "notes",

    ]

    CALCULATED_FIELDS = [

        "current_quantity",

        "current_unit_price",

        "previous_unit_price",

        "current_purchase_date",

        "previous_purchase_date",

        "average_daily_consumption",

        "average_duration_days",

        "expected_next_purchase",

        "price_delta",

        "price_delta_percent",

    ]


###########################################################


class PurchaseContract:
    """
    PURCHASE

    Immutable purchase ledger.

    Every Add Receipt creates exactly one Purchase.
    """

    FIELDS = [

        "purchase_id",

        "product_id",

        "store_id",

        "purchase_date",

        "quantity",

        "unit",

        "unit_price",

        "total_price",

        "promotion",

        "notes",

    ]

    IMMUTABLE = True


###########################################################
#
# REPOSITORY CONTRACT
#
###########################################################

class RepositoryContract(ABC):

    """
    Lowest persistence layer.

    Contains SQL only.
    """

    #######################################################

    @abstractmethod
    def create_product(self, product):
        pass

    @abstractmethod
    def update_product(self, product):
        pass


    @abstractmethod
    def delete_product(
        self,
        product_id,
    ):
        pass

    #######################################################

    @abstractmethod
    def insert_purchase(
        self,
        purchase,
    ):
        pass

    @abstractmethod
    def delete_purchase(
        self,
        purchase_id,
    ):
        pass

    #######################################################

    @abstractmethod
    def get_product(
        self,
        product_id,
    ):
        pass

    @abstractmethod
    def get_products(self):
        pass

    @abstractmethod
    def get_purchases(
        self,
        product_id=None,
    ):
        pass


###########################################################
#
# SERVICE CONTRACT
#
###########################################################

class ServiceContract(ABC):

    """
    Business layer.

    No SQL.

    Coordinates repository operations.
    """

    #######################################################

    @abstractmethod
    def register_receipt(
        self,
        **kwargs,
    ):
        """
        Always creates one Purchase.

        Creates Product only if necessary.

        Recalculates Product summary.
        """
        pass


    #######################################################

    @abstractmethod
    def update_product(
        self,
        product,
    ):
        """
        Update editable Product fields.
        """
        pass



    #######################################################

    @abstractmethod
    def delete_product(
        self,
        product_id,
    ):
        """
        Delete Product and every Purchase.
        """
        pass


    #######################################################

    @abstractmethod
    def delete_purchase(
        self,
        purchase_id,
    ):
        """
        Delete one Purchase.

        Recalculate Product afterwards.
        """
        pass


    #######################################################

    @abstractmethod
    def recalculate_product(
        self,
        product_id,
    ):
        """
        Single source of truth.

        Every calculated Product field
        is generated here.
        """
        pass


###########################################################
#
# SYSTEM INVARIANTS
#
###########################################################

SYSTEM_RULES = {

    "receipt_creates_purchase": True,

    "purchase_is_immutable": True,

    "product_is_editable": True,

    "history_is_purchase_view": True,

    "product_summary_is_calculated": True,


}