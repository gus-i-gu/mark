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
import calendar

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

    Store,

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

    def get_stores(

        self,

    ) -> list[Store]:
        """
        Return every store for Settings editing.
        """

        return self.repository.get_stores()


    #######################################################

    def save_store(

        self,

        store_id: int | None,

        name: str,

        city: str | None = None,

        state: str | None = None,

        address: str | None = None,

    ) -> Store:
        """
        Create or update a store.
        """

        if not name.strip():

            raise ValueError("Store name is required.")

        store = Store(

            id=store_id,

            name=name.strip(),

            city=(city or "").strip() or None,

            state=(state or "").strip() or None,

            address=(address or "").strip() or None,

        )

        if store.id is None:

            return self.repository.create_store(

                store

            )

        if not self.repository.exists_store(

            store.id

        ):

            raise ValueError(

                f"Unknown store '{store.id}'."

            )

        return self.repository.update_store(

            store

        )


    #######################################################

    def get_settings(

        self,

    ) -> dict[str, str]:
        """
        Return persisted application settings.
        """

        settings = {

            "history.week_boundary": "wednesday",

            "history.month_boundary_rule": "first_wednesday",

            "pages.order": "Register,Storage,Shortage,Market,History,Settings",

        }

        settings.update(

            self.repository.get_settings()

        )

        return settings


    #######################################################

    def set_setting(

        self,

        key: str,

        value: str,

    ) -> None:
        """
        Persist one application setting.
        """

        self.repository.set_setting(

            key,

            value,

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

        expiration_date: str | None = None,

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

                average_shelf_life_days=None,

                expected_expiration_date=None,

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

            expiration_date=expiration_date,

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

        product.average_shelf_life_days = (

            current.average_shelf_life_days

        )

        product.expected_expiration_date = (

            current.expected_expiration_date

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

            product.average_shelf_life_days = None

            product.expected_expiration_date = None

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
        # Shelf-life summary
        ###################################################

        product.average_shelf_life_days = (

            self.calculate_average_shelf_life(

                purchases

            )

        )

        product.expected_expiration_date = (

            self.estimate_expiration_date(

                current.purchase_date,

                product.average_shelf_life_days,

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

    def get_lists_view(

        self,

        view_key: str = "all",

    ) -> dict:
        """
        Return the unified Lists read model.
        """

        available_views = [

            "all",

            "in-house",

            "shortage",

            "to-buy",

            "in-house + shortage",

            "shortage + to-buy",

        ]

        normalized_view = (

            view_key

            if view_key in available_views

            else "all"

        )

        all_rows = [

            self.list_row_model(product)

            for product in self.repository.get_products()

        ]

        status_filters = {

            "all": {"in-house", "shortage", "to-buy"},

            "in-house": {"in-house"},

            "shortage": {"shortage"},

            "to-buy": {"to-buy"},

            "in-house + shortage": {"in-house", "shortage"},

            "shortage + to-buy": {"shortage", "to-buy"},

        }

        rows = [

            row

            for row in all_rows

            if row["status"] in status_filters[normalized_view]

        ]

        return {

            "view_key": normalized_view,

            "default_view_key": "all",

            "available_views": available_views,

            "rows": rows,

            "all_rows": all_rows,

        }


    #######################################################

    def list_row_model(

        self,

        product: Product,

    ) -> dict:
        """
        Convert a Product into a platform-neutral Lists row.
        """

        status = self.product_status(product)

        status_key = self.list_status_key(status)

        price_variation = self.get_price_variation(product)

        remaining_days = self.days_until_restock(product)

        return {

            "product_id": product.id,

            "product_name": product.product_name,

            "brand": product.brand,

            "current_quantity": product.current_quantity,

            "unit": product.unit,

            "quantity_label": self.quantity_label(product),

            "latest_price": product.current_unit_price,

            "previous_price": product.previous_unit_price,

            "delta_price": price_variation["delta"],

            "delta_price_percent": price_variation["percentage"],

            "delta_price_label": price_variation["text"],

            "delta_price_direction": self.price_delta_direction(

                price_variation["delta"]

            ),

            "average_duration_days": product.average_duration_days,

            "cycle_label": self.cycle_label(product.average_duration_days),

            "expected_next_purchase": product.expected_next_purchase,

            "next_purchase_label": self.date_label(

                product.expected_next_purchase

            ),

            "remaining_days": remaining_days,

            "remaining_label": self.remaining_label(remaining_days),

            "status": status_key,

            "status_label": self.status_label(status_key),

            "price_label": self.money_label(product.current_unit_price),

        }


    #######################################################

    def list_status_key(

        self,

        status: str,

    ) -> str:
        """
        Map legacy inventory status names to Lists status keys.
        """

        return {

            "storage": "in-house",

            "shortage": "shortage",

            "market": "to-buy",

        }.get(status, "in-house")


    #######################################################

    def status_label(

        self,

        status: str,

    ) -> str:
        return {

            "in-house": "In-house",

            "shortage": "Shortage",

            "to-buy": "To buy",

        }.get(status, "Unknown")


    #######################################################

    def quantity_label(

        self,

        product: Product,

    ) -> str:
        return f"{product.current_quantity:g} {product.unit}"


    #######################################################

    def money_label(

        self,

        value,

    ) -> str:
        if value is None:

            return "—"

        return f"$ {value:.2f}"


    #######################################################

    def cycle_label(

        self,

        days,

    ) -> str:
        if days is None:

            return "—"

        if days == 1:

            return "1 day"

        return f"{days} days"


    #######################################################

    def date_label(

        self,

        value,

    ) -> str:
        if value is None:

            return "—"

        parsed = self.parse_purchase_date(value)

        if parsed is None:

            return value

        return self.format_date_value(parsed)


    #######################################################

    def remaining_label(

        self,

        days,

    ) -> str:
        if days is None:

            return "—"

        if days > 1:

            return f"{days} days"

        if days == 1:

            return "Tomorrow"

        if days == 0:

            return "Today"

        return f"{abs(days)} days overdue"


    #######################################################

    def price_delta_direction(

        self,

        delta,

    ) -> str:
        if delta is None:

            return "unavailable"

        if delta > 0:

            return "up"

        if delta < 0:

            return "down"

        return "equal"


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

    def get_product_view(

        self,

        product_id: str,

    ) -> dict | None:
        """
        Return the read model used by ProductDetailPanel.
        """

        product = self.repository.get_product(

            product_id

        )

        if product is None:

            return None

        return {

            "product_id": product.id,

            "product_name": product.product_name,

            "brand": product.brand,

            "average_price": self.repository.get_average_unit_price(

                product_id

            ),

            "average_shelf_life_days": (

                product.average_shelf_life_days

            ),

            "expected_expiration_date": (

                product.expected_expiration_date

            ),

            "stores": self.repository.get_latest_store_price_rows(

                product_id

            ),

            "last_purchases": self.repository.get_last_purchase_rows(

                product_id

            ),

        }


    #######################################################

    def get_history_view(

        self,

    ) -> dict:
        """
        Return the grouped History read model.
        """

        settings = self.get_settings()

        week_boundary = settings.get(

            "history.week_boundary",

            "wednesday",

        )

        rows = []

        unparsed_rows = []

        for row in self.repository.get_history_purchase_rows():

            parsed_date = self.parse_purchase_date(

                row.get("purchase_date")

            )

            if parsed_date is None:

                unparsed_rows.append(row)

                continue

            row["parsed_purchase_date"] = parsed_date

            rows.append(row)

        rows.sort(

            key=lambda row: (

                row["parsed_purchase_date"],

                row.get("purchase_id") or 0,

            )

        )

        month_sections = []

        month_lookup = {}

        for row in rows:

            purchase_date = row["parsed_purchase_date"]

            month_start = self.operational_month_start(

                purchase_date

            )

            week_start = self.week_start(

                purchase_date,

                week_boundary,

            )

            month_key = month_start.isoformat()

            week_key = week_start.isoformat()

            if month_key not in month_lookup:

                month_end = (

                    self.next_operational_month_start(month_start)

                    -

                    timedelta(days=1)

                )

                month_section = {

                    "label": self.operational_month_label(month_start),

                    "period_start": self.format_date_value(month_start),

                    "period_end": self.format_date_value(month_end),

                    "weeks": [],

                    "summary": self.empty_summary(),

                }

                month_lookup[month_key] = {

                    "section": month_section,

                    "weeks": {},

                }

                month_sections.append(month_section)

            month_entry = month_lookup[month_key]

            if week_key not in month_entry["weeks"]:

                week_end = week_start + timedelta(days=6)

                week_section = {

                    "label": self.week_label(week_start, week_end),

                    "period_start": self.format_date_value(week_start),

                    "period_end": self.format_date_value(week_end),

                    "rows": [],

                    "summary": self.empty_summary(),

                }

                month_entry["weeks"][week_key] = week_section

                month_entry["section"]["weeks"].append(

                    week_section

                )

            row_model = self.history_row_model(row)

            week_section = month_entry["weeks"][week_key]

            week_section["rows"].append(row_model)

            self.add_to_summary(

                week_section["summary"],

                row_model,

            )

            self.add_to_summary(

                month_entry["section"]["summary"],

                row_model,

            )

        for month_section in month_sections:

            self.finalize_summary(

                month_section["summary"]

            )

            for week_section in month_section["weeks"]:

                self.finalize_summary(

                    week_section["summary"]

                )

        return {

            "settings": settings,

            "months": month_sections,

            "unparsed_rows": unparsed_rows,

        }


    #######################################################

    def get_history_analytics_view(

        self,

        start_date: str | None = None,

        end_date: str | None = None,

        store_id: int | None = None,

    ) -> dict:
        """
        Return embedded History analytics for a date/store frame.
        """

        frame_start = self.parse_purchase_date(start_date)

        frame_end = self.parse_purchase_date(end_date)

        products = {

            product.id: product

            for product in self.repository.get_products()

        }

        stores = {

            store.id: store

            for store in self.repository.get_stores()

        }

        parsed_rows = []

        unparsed_rows = []

        excluded_rows = []

        for row in self.repository.get_history_purchase_rows():

            parsed_date = self.parse_purchase_date(

                row.get("purchase_date")

            )

            if parsed_date is None:

                diagnostic = dict(row)

                diagnostic["reason"] = "unparsed_purchase_date"

                unparsed_rows.append(diagnostic)

                continue

            row["parsed_purchase_date"] = parsed_date

            exclusion_reason = self.analytics_exclusion_reason(

                row,

                frame_start,

                frame_end,

                store_id,

            )

            if exclusion_reason is not None:

                diagnostic = dict(row)

                diagnostic["reason"] = exclusion_reason

                excluded_rows.append(diagnostic)

                continue

            parsed_rows.append(row)

        parsed_rows.sort(

            key=lambda row: (

                row["parsed_purchase_date"],

                row.get("purchase_id") or 0,

            )

        )

        total_spent = sum(

            row.get("total_price") or 0.0

            for row in parsed_rows

        )

        frame_average = self.average_purchase_timelapse(

            parsed_rows

        )

        product_groups = {}

        for row in parsed_rows:

            product_id = row.get("product_id")

            group = product_groups.setdefault(

                product_id,

                {

                    "product_id": product_id,

                    "product_name": row.get("product_name"),

                    "brand": row.get("brand"),

                    "total_spent": 0.0,

                    "purchase_count": 0,

                },

            )

            group["purchase_count"] += 1

            group["total_spent"] += row.get("total_price") or 0.0

        rows = []

        for product_id, group in product_groups.items():

            product = products.get(product_id)

            product_cycle = (

                product.average_duration_days

                if product is not None

                else None

            )

            difference = self.cycle_difference(

                product_cycle,

                frame_average,

            )

            rows.append({

                "product_id": group["product_id"],

                "product_name": group["product_name"],

                "brand": group["brand"],

                "total_spent": group["total_spent"],

                "total_spent_label": self.money_label(

                    group["total_spent"]

                ),

                "expenditure_percentage": (

                    (

                        group["total_spent"]

                        /

                        total_spent

                    ) * 100

                    if total_spent > 0

                    else None

                ),

                "purchase_count": group["purchase_count"],

                "average_duration_days": product_cycle,

                "frame_average_timelapse_days": frame_average,

                "cycle_difference_days": difference,

                "cycle_comparison": self.cycle_comparison_label(

                    product_cycle,

                    frame_average,

                ),

                "insufficient_data_reason": (

                    None

                    if product_cycle is not None and frame_average is not None

                    else "missing_product_cycle_or_frame_average"

                ),

            })

        rows.sort(

            key=lambda row: row["total_spent"],

            reverse=True,

        )

        selected_store = stores.get(store_id)

        return {

            "frame": {

                "start_date": start_date,

                "end_date": end_date,

                "store_id": store_id,

                "store_name": (

                    selected_store.name

                    if selected_store is not None

                    else "All stores"

                ),

            },

            "parsed_purchase_count": len(parsed_rows),

            "unparsed_row_count": len(unparsed_rows),

            "excluded_row_count": len(excluded_rows),

            "unparsed_or_excluded_count": (

                len(unparsed_rows) + len(excluded_rows)

            ),

            "total_spent": total_spent,

            "frame_average_timelapse_days": frame_average,

            "insufficient_data_reason": (

                None

                if frame_average is not None

                else "fewer_than_two_parsed_purchases"

            ),

            "products": rows,

            "rows": rows,

            "unparsed_rows": unparsed_rows,

            "excluded_rows": excluded_rows,

            "unparsed_or_excluded_rows": (

                unparsed_rows + excluded_rows

            ),

        }


    #######################################################

    def analytics_exclusion_reason(

        self,

        row: dict,

        start_date,

        end_date,

        store_id: int | None,

    ) -> str | None:
        purchase_date = row["parsed_purchase_date"]

        if start_date is not None and purchase_date < start_date:

            return "outside_frame"

        if end_date is not None and purchase_date > end_date:

            return "outside_frame"

        if store_id is not None and row.get("store_id") != store_id:

            return "store_filter_mismatch"

        return None


    #######################################################

    def average_purchase_timelapse(

        self,

        rows: list[dict],

    ) -> float | None:
        if len(rows) < 2:

            return None

        gaps = []

        for index in range(len(rows) - 1):

            current_date = rows[index]["parsed_purchase_date"]

            next_date = rows[index + 1]["parsed_purchase_date"]

            gaps.append((next_date - current_date).days)

        return sum(gaps) / len(gaps)


    #######################################################

    def cycle_difference(

        self,

        product_cycle,

        frame_average,

    ) -> float | None:
        if product_cycle is None or frame_average is None:

            return None

        return product_cycle - frame_average


    #######################################################

    def cycle_comparison_label(

        self,

        product_cycle,

        frame_average,

    ) -> str:
        if product_cycle is None or frame_average is None:

            return "unknown"

        if product_cycle < frame_average:

            return "faster"

        if product_cycle > frame_average:

            return "slower"

        return "equal"


    #######################################################

    def parse_purchase_date(

        self,

        value: str | None,

    ):
        """
        Parse known project and legacy date formats.
        """

        if not value:

            return None

        for date_format in (

            DATE_FORMAT,

            "%Y-%m-%d",

        ):

            try:

                return datetime.strptime(

                    value,

                    date_format,

                ).date()

            except ValueError:

                continue

        return None


    #######################################################

    def first_wednesday(

        self,

        year: int,

        month: int,

    ):
        """
        Return the first Wednesday of a calendar month.
        """

        current = datetime(

            year,

            month,

            1,

        ).date()

        while current.weekday() != 2:

            current = current + timedelta(days=1)

        return current


    #######################################################

    def operational_month_start(

        self,

        value,

    ):
        """
        Return the first-Wednesday operational month start.
        """

        current_start = self.first_wednesday(

            value.year,

            value.month,

        )

        if value >= current_start:

            return current_start

        previous_month = value.month - 1

        previous_year = value.year

        if previous_month == 0:

            previous_month = 12

            previous_year -= 1

        return self.first_wednesday(

            previous_year,

            previous_month,

        )


    #######################################################

    def next_operational_month_start(

        self,

        month_start,

    ):
        """
        Return the next first-Wednesday operational month start.
        """

        next_month = month_start.month + 1

        next_year = month_start.year

        if next_month == 13:

            next_month = 1

            next_year += 1

        return self.first_wednesday(

            next_year,

            next_month,

        )


    #######################################################

    def week_start(

        self,

        value,

        boundary: str,

    ):
        """
        Return the configured operational week start.
        """

        weekday = self.weekday_number(

            boundary

        )

        offset = (

            value.weekday()

            -

            weekday

        ) % 7

        return value - timedelta(days=offset)


    #######################################################

    def weekday_number(

        self,

        name: str,

    ) -> int:
        """
        Convert persisted weekday setting into Python weekday number.
        """

        weekdays = {

            day.lower(): index

            for index, day in enumerate(calendar.day_name)

        }

        return weekdays.get(

            (name or "").lower(),

            2,

        )


    #######################################################

    def history_row_model(

        self,

        row: dict,

    ) -> dict:
        """
        Convert a repository row into a History row.
        """

        return {

            "purchase_id": row.get("purchase_id"),

            "purchase_date": row.get("purchase_date"),

            "product_id": row.get("product_id"),

            "product_name": row.get("product_name"),

            "brand": row.get("brand"),

            "store_id": row.get("store_id"),

            "store_name": row.get("store_name"),

            "quantity": row.get("quantity"),

            "unit": row.get("unit"),

            "unit_price": row.get("unit_price"),

            "total_price": row.get("total_price"),

            "expiration_date": row.get("expiration_date"),

        }


    #######################################################

    def empty_summary(

        self,

    ) -> dict:
        """
        Create an aggregate container with explicit meanings.
        """

        return {

            "purchase_count": 0,

            "monetary_total": 0.0,

            "unit_price_total": 0.0,

            "unit_price_count": 0,

            "average_unit_price": None,

            "quantity_totals": {},

            "store_totals": {},

        }


    #######################################################

    def add_to_summary(

        self,

        summary: dict,

        row: dict,

    ) -> None:
        """
        Add one row into explicit aggregate meanings.
        """

        summary["purchase_count"] += 1

        total_price = row.get("total_price")

        if total_price is not None:

            summary["monetary_total"] += total_price

        unit_price = row.get("unit_price")

        if unit_price is not None:

            summary["unit_price_total"] += unit_price

            summary["unit_price_count"] += 1

        unit = row.get("unit")

        quantity = row.get("quantity")

        if unit and quantity is not None:

            current_quantity = summary["quantity_totals"].get(

                unit,

                0.0,

            )

            summary["quantity_totals"][unit] = (

                current_quantity

                +

                quantity

            )

        store_name = row.get("store_name") or "No store"

        current_store_total = summary["store_totals"].get(

            store_name,

            0.0,

        )

        summary["store_totals"][store_name] = (

            current_store_total

            +

            (total_price or 0.0)

        )


    #######################################################

    def finalize_summary(

        self,

        summary: dict,

    ) -> None:
        """
        Finalize average values for display.
        """

        if summary["unit_price_count"] > 0:

            summary["average_unit_price"] = (

                summary["unit_price_total"]

                /

                summary["unit_price_count"]

            )


    #######################################################

    def operational_month_label(

        self,

        month_start,

    ) -> str:
        return (

            f"Operational {month_start.strftime('%B %Y')}"

        )


    #######################################################

    def week_label(

        self,

        week_start,

        week_end,

    ) -> str:
        return (

            f"Week {self.format_date_value(week_start)}"

            f" - {self.format_date_value(week_end)}"

        )


    #######################################################

    def format_date_value(

        self,

        value,

    ) -> str:
        return value.strftime(DATE_FORMAT)

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

        first = self.parse_purchase_date(

            first_date

        )

        second = self.parse_purchase_date(

            second_date

        )

        if first is None or second is None:

            raise ValueError(

                "Could not parse purchase date."

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

    def calculate_average_shelf_life(

        self,

        purchases: list[Purchase],

    ) -> int | None:
        """
        Calculate average days from purchase to expiration.
        """

        durations = []

        for purchase in purchases:

            if not purchase.expiration_date:

                continue

            durations.append(

                self.calculate_duration(

                    purchase.purchase_date,

                    purchase.expiration_date,

                )

            )

        if not durations:

            return None

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


        purchase = self.parse_purchase_date(

            purchase_date

        )

        if purchase is None:

            return None


        expected = purchase + timedelta(

            days=average_duration

        )


        return expected.strftime(

            DATE_FORMAT

        )


    #######################################################

    def estimate_expiration_date(

        self,

        purchase_date: str,

        average_shelf_life: int | None,

    ) -> str | None:
        """
        Estimate expiration from purchase date and shelf-life.
        """

        if average_shelf_life is None:

            return None

        purchase = self.parse_purchase_date(

            purchase_date

        )

        if purchase is None:

            return None

        expected = purchase + timedelta(

            days=average_shelf_life

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


        expected = self.parse_purchase_date(

            product.expected_next_purchase

        )

        if expected is None:

            return "storage"


        today = datetime.today().date()


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


        expected = self.parse_purchase_date(

            product.expected_next_purchase

        )

        if expected is None:

            return None


        return (

            expected

            -

            datetime.today().date()

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
