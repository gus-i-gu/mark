"""
services.py

Markei Business Layer

Responsibilities
----------------

• Coordinate repository operations.

• Enforce business rules.

• Register receipts.

• Maintain Product lifecycle.

• Recalculate Product summaries.

• Expose application services to the UI.

This module NEVER

• executes SQL

• knows SQLite

• manipulates database cursors

Architecture

Desktop / Android UI
        ↓
ProductService
        ↓
Repository
        ↓
SQLite
"""

from __future__ import annotations

from datetime import datetime
from datetime import timedelta

from .config import (

    DATE_FORMAT,

    DEFAULT_REORDER_THRESHOLD,

)

from .contracts import (

    ServiceContract,

)

from .models import (

    Product,

    Purchase,

)

from .repository import Repository


###########################################################
#
# PRODUCT SERVICE
#
###########################################################

class ProductService(ServiceContract):
    """
    Business orchestration layer.

    ProductService knows

        • business rules

        • workflows

        • calculations

    ProductService NEVER knows

        • SQL

        • SQLite

        • database schema
    """

    #######################################################
    #
    # INITIALIZATION
    #
    #######################################################

    def __init__(self):

        self.repository = Repository()


    #######################################################
    #
    # GENERIC READ SERVICES
    #
    #######################################################

    def get_products(

        self,

    ) -> list[Product]:
        """
        Return every Product.
        """

        return self.repository.get_products()


    #######################################################

    def get_product(

        self,

        product_id: str,

    ) -> Product | None:
        """
        Return one Product.
        """

        return self.repository.get_product(

            product_id

        )


    #######################################################

    def get_history(

        self,

        product_id: str | None = None,

    ) -> list[Purchase]:
        """
        Return Purchase history.

        If product_id is omitted,
        return every Purchase.
        """

        return self.repository.get_purchases(

            product_id

        )


    #######################################################
    #
    # CLEANUP
    #
    #######################################################

    def close(

        self,

    ) -> None:
        """
        Release repository resources.
        """

        self.repository.close()

    #######################################################
    #
    # REGISTER RECEIPT
    #
    #######################################################

    def register_receipt(

        self,

        product_id: str,

        category_id: str,

        product_name: str,

        brand: str | None,

        quantity: float,

        unit: str,

        purchase_date: str,

        unit_price: float,

        total_price: float,

        store_id: int | None = None,

        promotion: bool = False,

        notes: str = "",

    ) -> dict:
        """
        Register one receipt line.

        Workflow

            1. Validate product.

            2. Create Product if necessary.

            3. Insert Purchase.

            4. Recalculate Product.

            5. Persist Product summary.

            6. Return Product and Purchase.
        """

        ###################################################
        # Product exists?
        ###################################################

        product = self.repository.get_product(

            product_id

        )

        ###################################################
        # New Product
        ###################################################

        if product is None:

            product = Product(

                id=product_id,

                category_id=category_id,

                product_name=product_name,

                brand=brand,

                unit=unit,

                minimum_quantity=0.0,

                reorder_threshold=DEFAULT_REORDER_THRESHOLD,

                notes=notes,

                current_quantity=0.0,

                current_unit_price=None,

                previous_unit_price=None,

                current_purchase_date=None,

                previous_purchase_date=None,

                average_daily_consumption=0.0,

                average_duration_days=None,

                expected_next_purchase=None,

                price_delta=None,

                price_delta_percent=None,

                created_at=purchase_date,

            )

            self.repository.create_product(

                product

            )

        ###################################################
        # Existing Product
        #
        # Editable metadata always follows
        # the newest receipt.
        ###################################################

        else:

            product.category_id = category_id

            product.product_name = product_name

            product.brand = brand

            product.unit = unit

            product.notes = notes

            self.repository.update_product(

                product

            )

        ###################################################
        # Purchase
        ###################################################

        purchase = Purchase(

            product_id=product_id,

            store_id=store_id,

            purchase_date=purchase_date,

            quantity=quantity,

            unit=unit,

            unit_price=unit_price,

            total_price=total_price,

            promotion=promotion,

            notes=notes,

        )

        purchase = self.repository.insert_purchase(

            purchase

        )

        ###################################################
        # Product Summary
        ###################################################

        product = self.recalculate_product(

            product_id

        )

        ###################################################

        return {

            "success": True,

            "product": product,

            "purchase": purchase,

        }

    #######################################################
    #
    # PRODUCT LIFECYCLE
    #
    #######################################################

    def update_product(

        self,

        product: Product,

    ) -> Product:
        """
        Persist editable Product fields.

        Calculated fields are NOT modified
        here.

        Product summary is exclusively
        maintained by recalculate_product().
        """

        ###################################################
        # Preserve calculated fields
        ###################################################

        current = self.repository.get_product(

            product.id

        )

        if current is None:

            raise ValueError(

                f"Unknown product '{product.id}'."

            )

        ###################################################
        # Copy calculated values
        ###################################################

        product.current_quantity = (

            current.current_quantity

        )

        product.current_unit_price = (

            current.current_unit_price

        )

        product.previous_unit_price = (

            current.previous_unit_price

        )

        product.current_purchase_date = (

            current.current_purchase_date

        )

        product.previous_purchase_date = (

            current.previous_purchase_date

        )

        product.average_daily_consumption = (

            current.average_daily_consumption

        )

        product.average_duration_days = (

            current.average_duration_days

        )

        product.expected_next_purchase = (

            current.expected_next_purchase

        )

        product.price_delta = (

            current.price_delta

        )

        product.price_delta_percent = (

            current.price_delta_percent

        )

        product.created_at = (

            current.created_at

        )

        ###################################################

        return self.repository.update_product(

            product

        )


    #######################################################

    def delete_product(

        self,

        product_id: str,

    ) -> None:
        """
        Delete one Product.

        Purchase history is deleted through
        database cascade rules.
        """

        self.repository.delete_product(

            product_id

        )


    #######################################################

    def delete_purchase(

        self,

        purchase_id: int,

    ) -> None:
        """
        Delete one Purchase.

        Product summary is recalculated
        afterwards.
        """

        ###################################################
        # Retrieve purchase before deletion
        ###################################################

        purchase = self.repository.get_purchase(

            purchase_id

        )

        if purchase is None:

            return

        ###################################################
        # Delete purchase
        ###################################################

        self.repository.delete_purchase(

            purchase_id

        )

        ###################################################
        # Recalculate Product
        ###################################################

        self.recalculate_product(

            purchase.product_id

        )

    #######################################################
    #
    # RECALCULATION ENGINE
    #
    #######################################################

    def recalculate_product(

        self,

        product_id: str,

    ) -> Product:
        """
        Recalculate every cached Product field.

        This is the ONLY place where
        Product summary values are generated.
        """

        ###################################################
        # Product
        ###################################################

        product = self.repository.get_product(

            product_id

        )

        if product is None:

            raise ValueError(

                f"Unknown product '{product_id}'."

            )


        ###################################################
        # Purchase history
        ###################################################

        purchases = self.repository.get_purchases(

            product_id

        )


        ###################################################
        # No purchases
        ###################################################

        if not purchases:

            product.current_quantity = 0.0

            product.current_unit_price = None

            product.previous_unit_price = None

            product.current_purchase_date = None

            product.previous_purchase_date = None

            product.average_daily_consumption = 0.0

            product.average_duration_days = None

            product.expected_next_purchase = None

            product.price_delta = None

            product.price_delta_percent = None

            return self.repository.update_product(

                product

            )


        ###################################################
        # Current purchase
        ###################################################

        current = purchases[0]

        product.current_quantity = current.quantity

        product.current_unit_price = current.unit_price

        product.current_purchase_date = (

            current.purchase_date

        )


        ###################################################
        # Previous purchase
        ###################################################

        if len(purchases) > 1:

            previous = purchases[1]

            product.previous_unit_price = (

                previous.unit_price

            )

            product.previous_purchase_date = (

                previous.purchase_date

            )

        else:

            previous = None

            product.previous_unit_price = None

            product.previous_purchase_date = None


        ###################################################
        # Price variation
        ###################################################

        if previous is None:

            product.price_delta = None

            product.price_delta_percent = None

        else:

            delta = (

                current.unit_price

                -

                previous.unit_price

            )

            product.price_delta = delta

            if previous.unit_price == 0:

                product.price_delta_percent = None

            else:

                product.price_delta_percent = (

                    delta

                    /

                    previous.unit_price

                ) * 100


        ###################################################
        # Average duration
        ###################################################

        product.average_duration_days = (

            self.calculate_average_duration(

                purchases

            )

        )


        ###################################################
        # Consumption
        ###################################################

        if (

            product.average_duration_days

            and

            product.average_duration_days > 0

        ):

            product.average_daily_consumption = (

                current.quantity

                /

                product.average_duration_days

            )

        else:

            product.average_daily_consumption = 0.0


        ###################################################
        # Expected purchase
        ###################################################

        product.expected_next_purchase = (

            self.estimate_next_purchase_date(

                current.purchase_date,

                product.average_duration_days,

            )

        )


        ###################################################
        # Persist summary
        ###################################################

        return self.repository.update_product(

            product

        )


    #######################################################

    def get_product_summary(

        self,

        product_id: str,

    ) -> Product:
        """
        Return the current Product summary.
        """

        return self.repository.get_product(

            product_id

        )

    #######################################################
    #
    # READ SERVICES
    #
    #######################################################

    def get_storage_products(

        self,

    ) -> list[Product]:
        """
        Products considered safely stocked.
        """

        return [

            product

            for product in self.repository.get_products()

            if self.product_status(product) == "storage"

        ]


    #######################################################

    def get_shortage_products(

        self,

    ) -> list[Product]:
        """
        Products approaching the
        reorder threshold.
        """

        return [

            product

            for product in self.repository.get_products()

            if self.product_status(product) == "shortage"

        ]


    #######################################################

    def get_market_products(

        self,

    ) -> list[Product]:
        """
        Products expected to require
        a new purchase.
        """

        return [

            product

            for product in self.repository.get_products()

            if self.product_status(product) == "market"

        ]


    #######################################################

    def get_dashboard(

        self,

    ) -> dict:
        """
        Return every collection used
        by the dashboard.
        """

        return {

            "products":

                self.get_products(),

            "storage":

                self.get_storage_products(),

            "shortage":

                self.get_shortage_products(),

            "market":

                self.get_market_products(),

            "history":

                self.get_history(),

        }


    #######################################################

    def get_purchase_history(

        self,

        product_id: str,

    ) -> list[Purchase]:
        """
        Return the complete purchase
        history of one product.
        """

        return self.repository.get_purchases(

            product_id

        )

    #######################################################
    #
    # CALCULATION SERVICES
    #
    #######################################################

    def calculate_duration(

        self,

        first_date: str,

        second_date: str,

    ) -> int:
        """
        Return the number of days
        between two purchase dates.
        """

        first = datetime.strptime(

            first_date,

            DATE_FORMAT,

        )

        second = datetime.strptime(

            second_date,

            DATE_FORMAT,

        )

        return (

            second - first

        ).days


    #######################################################

    def calculate_average_duration(

        self,

        purchases: list[Purchase],

    ) -> int | None:
        """
        Calculate the average number
        of days between purchases.
        """

        if len(purchases) < 2:

            return None


        durations = []


        for index in range(

            len(purchases) - 1

        ):

            current = purchases[index]

            previous = purchases[index + 1]


            durations.append(

                self.calculate_duration(

                    previous.purchase_date,

                    current.purchase_date,

                )

            )


        return round(

            sum(durations)

            /

            len(durations)

        )


    #######################################################

    def estimate_next_purchase_date(

        self,

        purchase_date: str,

        average_duration: int | None,

    ) -> str | None:
        """
        Estimate the next purchase date.
        """

        if average_duration is None:

            return None


        purchase = datetime.strptime(

            purchase_date,

            DATE_FORMAT,

        )


        expected = purchase + timedelta(

            days=average_duration

        )


        return expected.strftime(

            DATE_FORMAT

        )


    #######################################################
    #
    # PRODUCT STATUS
    #
    #######################################################

    def product_status(

        self,

        product: Product,

    ) -> str:
        """
        Classify one Product.

        Returns

            storage

            shortage

            market
        """

        if (

            product.expected_next_purchase

            is None

        ):

            return "storage"


        expected = datetime.strptime(

            product.expected_next_purchase,

            DATE_FORMAT,

        )


        today = datetime.today()


        threshold = timedelta(

            days=product.reorder_threshold

        )


        if expected < today:

            return "market"


        if expected <= today + threshold:

            return "shortage"


        return "storage"


    #######################################################

    def days_until_restock(

        self,

        product: Product,

    ) -> int | None:
        """
        Remaining days until the
        expected purchase.
        """

        if (

            product.expected_next_purchase

            is None

        ):

            return None


        expected = datetime.strptime(

            product.expected_next_purchase,

            DATE_FORMAT,

        )


        return (

            expected

            -

            datetime.today()

        ).days


    #######################################################

    def get_price_variation(

        self,

        product: Product,

    ) -> dict:
        """
        Return price variation data.

        Returned dictionary

            delta

            percentage

            text
        """

        if (

            product.current_unit_price is None

            or

            product.previous_unit_price is None

        ):

            return {

                "delta": None,

                "percentage": None,

                "text": "—",

            }


        delta = (

            product.current_unit_price

            -

            product.previous_unit_price

        )


        if product.previous_unit_price == 0:

            percentage = None

        else:

            percentage = (

                delta

                /

                product.previous_unit_price

            ) * 100


        if percentage is None:

            text = (

                f"{delta:+.2f} R$"

            )

        else:

            text = (

                f"{delta:+.2f} R$ "

                f"({percentage:+.1f}%)"

            )


        return {

            "delta": delta,

            "percentage": percentage,

            "text": text,

        }