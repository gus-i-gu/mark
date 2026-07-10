"""
repository.py

Concrete SQLite persistence adapter for Markei.
"""

from __future__ import annotations

import sqlite3

from .contracts import RepositoryContract
from .database import close as close_connection
from .database import connect
from .models import Category
from .models import Product
from .models import Purchase
from .models import Store


class Repository(RepositoryContract):
    """
    Repository implementation used by ProductService.

    The repository owns SQL operations and row-to-model mapping.
    Database lifecycle remains delegated to app.core.database.
    """

    def __init__(self):
        self.connection = connect()
        self.cursor = self.connection.cursor()

    #######################################################
    # Products
    #######################################################

    def create_product(self, product: Product) -> Product:
        self.cursor_execute(
            """
            INSERT INTO products (
                id,
                category_id,
                product_name,
                brand,
                unit,
                minimum_quantity,
                reorder_threshold,
                notes,
                current_quantity,
                current_unit_price,
                previous_unit_price,
                current_purchase_date,
                previous_purchase_date,
                average_daily_consumption,
                average_duration_days,
                expected_next_purchase,
                average_shelf_life_days,
                expected_expiration_date,
                price_delta,
                price_delta_percent,
                created_at
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                product.id,
                product.category_id,
                product.product_name,
                product.brand,
                product.unit,
                product.minimum_quantity,
                product.reorder_threshold,
                product.notes,
                product.current_quantity,
                product.current_unit_price,
                product.previous_unit_price,
                product.current_purchase_date,
                product.previous_purchase_date,
                product.average_daily_consumption,
                product.average_duration_days,
                product.expected_next_purchase,
                product.average_shelf_life_days,
                product.expected_expiration_date,
                product.price_delta,
                product.price_delta_percent,
                product.created_at,
            ),
        )
        self.commit()
        return product

    def update_product(self, product: Product) -> Product:
        self.cursor_execute(
            """
            UPDATE products
            SET
                category_id = ?,
                product_name = ?,
                brand = ?,
                unit = ?,
                minimum_quantity = ?,
                reorder_threshold = ?,
                notes = ?,
                current_quantity = ?,
                current_unit_price = ?,
                previous_unit_price = ?,
                current_purchase_date = ?,
                previous_purchase_date = ?,
                average_daily_consumption = ?,
                average_duration_days = ?,
                expected_next_purchase = ?,
                average_shelf_life_days = ?,
                expected_expiration_date = ?,
                price_delta = ?,
                price_delta_percent = ?
            WHERE id = ?
            """,
            (
                product.category_id,
                product.product_name,
                product.brand,
                product.unit,
                product.minimum_quantity,
                product.reorder_threshold,
                product.notes,
                product.current_quantity,
                product.current_unit_price,
                product.previous_unit_price,
                product.current_purchase_date,
                product.previous_purchase_date,
                product.average_daily_consumption,
                product.average_duration_days,
                product.expected_next_purchase,
                product.average_shelf_life_days,
                product.expected_expiration_date,
                product.price_delta,
                product.price_delta_percent,
                product.id,
            ),
        )
        self.commit()
        return product

    def rename_product(self, old_id: str, new_id: str) -> None:
        self.cursor_execute(
            """
            UPDATE products
            SET id = ?
            WHERE id = ?
            """,
            (new_id, old_id),
        )
        self.commit()

    def delete_product(self, product_id: str) -> None:
        self.cursor_execute(
            """
            DELETE FROM products
            WHERE id = ?
            """,
            (product_id,),
        )
        self.commit()

    def get_product(self, product_id: str) -> Product | None:
        self.cursor_execute(
            """
            SELECT *
            FROM products
            WHERE id = ?
            """,
            (product_id,),
        )
        return self.row_to_product(self.cursor.fetchone())

    def get_products(self) -> list[Product]:
        self.cursor_execute(
            """
            SELECT *
            FROM products
            ORDER BY product_name
            """
        )
        return [self.row_to_product(row) for row in self.cursor.fetchall()]

    def exists_product(self, product_id: str) -> bool:
        self.cursor_execute(
            """
            SELECT 1
            FROM products
            WHERE id = ?
            LIMIT 1
            """,
            (product_id,),
        )
        return self.cursor.fetchone() is not None

    def count_products(self) -> int:
        self.cursor_execute(
            """
            SELECT COUNT(*)
            FROM products
            """
        )
        return self.cursor.fetchone()[0]

    #######################################################
    # Purchases
    #######################################################

    def insert_purchase(self, purchase: Purchase) -> Purchase:
        self.cursor_execute(
            """
            INSERT INTO purchases (
                product_id,
                store_id,
                purchase_date,
                quantity,
                unit,
                unit_price,
                total_price,
                promotion,
                expiration_date,
                notes
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                purchase.product_id,
                purchase.store_id,
                purchase.purchase_date,
                purchase.quantity,
                purchase.unit,
                purchase.unit_price,
                purchase.total_price,
                int(purchase.promotion),
                purchase.expiration_date,
                purchase.notes,
            ),
        )
        purchase.id = self.cursor.lastrowid
        self.commit()
        return purchase

    def delete_purchase(self, purchase_id: int) -> None:
        self.cursor_execute(
            """
            DELETE FROM purchases
            WHERE id = ?
            """,
            (purchase_id,),
        )
        self.commit()

    def get_purchase(self, purchase_id: int) -> Purchase | None:
        self.cursor_execute(
            """
            SELECT *
            FROM purchases
            WHERE id = ?
            """,
            (purchase_id,),
        )
        return self.row_to_purchase(self.cursor.fetchone())

    def get_purchases(self, product_id: str | None = None) -> list[Purchase]:
        if product_id is None:
            self.cursor_execute(
                """
                SELECT *
                FROM purchases
                ORDER BY purchase_date DESC, id DESC
                """
            )
        else:
            self.cursor_execute(
                """
                SELECT *
                FROM purchases
                WHERE product_id = ?
                ORDER BY purchase_date DESC, id DESC
                """,
                (product_id,),
            )

        return [self.row_to_purchase(row) for row in self.cursor.fetchall()]

    def get_average_unit_price(self, product_id: str) -> float | None:
        self.cursor_execute(
            """
            SELECT AVG(unit_price) AS average_unit_price
            FROM purchases
            WHERE product_id = ?
            """,
            (product_id,),
        )
        row = self.cursor.fetchone()

        if row is None:
            return None

        return row["average_unit_price"]

    def get_latest_store_price_rows(self, product_id: str) -> list[dict]:
        self.cursor_execute(
            """
            SELECT
                p.store_id AS store_id,
                s.name AS store_name,
                s.address AS store_address,
                p.unit_price AS latest_unit_price,
                p.purchase_date AS latest_purchase_date
            FROM purchases p
            LEFT JOIN stores s
                ON s.id = p.store_id
            INNER JOIN (
                SELECT
                    store_id,
                    MAX(purchase_date || printf('%010d', id)) AS latest_key
                FROM purchases
                WHERE product_id = ?
                GROUP BY store_id
            ) latest
                ON (
                    latest.store_id IS p.store_id
                    AND latest.latest_key = p.purchase_date || printf('%010d', p.id)
                )
            WHERE p.product_id = ?
            ORDER BY s.name, p.store_id
            """,
            (product_id, product_id),
        )
        return [dict(row) for row in self.cursor.fetchall()]

    def get_last_purchase_rows(
        self,
        product_id: str,
        limit: int = 10,
    ) -> list[dict]:
        self.cursor_execute(
            """
            SELECT
                purchase_date,
                unit_price,
                quantity,
                unit,
                expiration_date
            FROM purchases
            WHERE product_id = ?
            ORDER BY purchase_date DESC, id DESC
            LIMIT ?
            """,
            (product_id, limit),
        )
        return [dict(row) for row in self.cursor.fetchall()]

    def get_last_purchase(self, product_id: str) -> Purchase | None:
        self.cursor_execute(
            """
            SELECT *
            FROM purchases
            WHERE product_id = ?
            ORDER BY purchase_date DESC, id DESC
            LIMIT 1
            """,
            (product_id,),
        )
        return self.row_to_purchase(self.cursor.fetchone())

    def get_previous_purchase(self, product_id: str) -> Purchase | None:
        self.cursor_execute(
            """
            SELECT *
            FROM purchases
            WHERE product_id = ?
            ORDER BY purchase_date DESC, id DESC
            LIMIT 1 OFFSET 1
            """,
            (product_id,),
        )
        return self.row_to_purchase(self.cursor.fetchone())

    def exists_purchase(self, purchase_id: int) -> bool:
        self.cursor_execute(
            """
            SELECT 1
            FROM purchases
            WHERE id = ?
            LIMIT 1
            """,
            (purchase_id,),
        )
        return self.cursor.fetchone() is not None

    def count_purchases(self) -> int:
        self.cursor_execute(
            """
            SELECT COUNT(*)
            FROM purchases
            """
        )
        return self.cursor.fetchone()[0]

    def get_history_purchase_rows(self) -> list[dict]:
        self.cursor_execute(
            """
            SELECT
                p.id AS purchase_id,
                p.product_id AS product_id,
                pr.product_name AS product_name,
                pr.brand AS brand,
                p.store_id AS store_id,
                s.name AS store_name,
                s.city AS store_city,
                s.state AS store_state,
                s.address AS store_address,
                p.purchase_date AS purchase_date,
                p.quantity AS quantity,
                p.unit AS unit,
                p.unit_price AS unit_price,
                p.total_price AS total_price,
                p.promotion AS promotion,
                p.expiration_date AS expiration_date,
                p.notes AS notes
            FROM purchases p
            LEFT JOIN products pr
                ON pr.id = p.product_id
            LEFT JOIN stores s
                ON s.id = p.store_id
            ORDER BY p.id ASC
            """
        )
        return [dict(row) for row in self.cursor.fetchall()]

    #######################################################
    # Categories
    #######################################################

    def create_category(self, category: Category) -> Category:
        self.cursor_execute(
            """
            INSERT INTO categories (
                id,
                name,
                description
            )
            VALUES (?, ?, ?)
            """,
            (
                category.id,
                category.name,
                category.description,
            ),
        )
        self.commit()
        return category

    def get_categories(self) -> list[Category]:
        self.cursor_execute(
            """
            SELECT *
            FROM categories
            ORDER BY name
            """
        )
        return [self.row_to_category(row) for row in self.cursor.fetchall()]

    def get_category(self, category_id: str) -> Category | None:
        self.cursor_execute(
            """
            SELECT *
            FROM categories
            WHERE id = ?
            """,
            (category_id,),
        )
        return self.row_to_category(self.cursor.fetchone())

    def exists_category(self, category_id: str) -> bool:
        self.cursor_execute(
            """
            SELECT 1
            FROM categories
            WHERE id = ?
            LIMIT 1
            """,
            (category_id,),
        )
        return self.cursor.fetchone() is not None

    def count_categories(self) -> int:
        self.cursor_execute(
            """
            SELECT COUNT(*)
            FROM categories
            """
        )
        return self.cursor.fetchone()[0]

    #######################################################
    # Stores
    #######################################################

    def get_stores(self) -> list[Store]:
        self.cursor_execute(
            """
            SELECT *
            FROM stores
            ORDER BY name
            """
        )
        return [self.row_to_store(row) for row in self.cursor.fetchall()]

    def create_store(self, store: Store) -> Store:
        self.cursor_execute(
            """
            INSERT INTO stores (
                name,
                city,
                state,
                address
            )
            VALUES (?, ?, ?, ?)
            """,
            (
                store.name,
                store.city,
                store.state,
                store.address,
            ),
        )
        store.id = self.cursor.lastrowid
        self.commit()
        return store

    def update_store(self, store: Store) -> Store:
        self.cursor_execute(
            """
            UPDATE stores
            SET
                name = ?,
                city = ?,
                state = ?,
                address = ?
            WHERE id = ?
            """,
            (
                store.name,
                store.city,
                store.state,
                store.address,
                store.id,
            ),
        )
        self.commit()
        return store

    def get_store(self, store_id: int) -> Store | None:
        self.cursor_execute(
            """
            SELECT *
            FROM stores
            WHERE id = ?
            """,
            (store_id,),
        )
        return self.row_to_store(self.cursor.fetchone())

    def exists_store(self, store_id: int) -> bool:
        self.cursor_execute(
            """
            SELECT 1
            FROM stores
            WHERE id = ?
            LIMIT 1
            """,
            (store_id,),
        )
        return self.cursor.fetchone() is not None

    def count_stores(self) -> int:
        self.cursor_execute(
            """
            SELECT COUNT(*)
            FROM stores
            """
        )
        return self.cursor.fetchone()[0]

    def count_promotions(self) -> int:
        self.cursor_execute(
            """
            SELECT COUNT(*)
            FROM promotions
            """
        )
        return self.cursor.fetchone()[0]

    #######################################################
    # Settings
    #######################################################

    def get_setting(self, key: str, default: str | None = None) -> str | None:
        self.cursor_execute(
            """
            SELECT value
            FROM settings
            WHERE key = ?
            """,
            (key,),
        )
        row = self.cursor.fetchone()

        if row is None:
            return default

        return row["value"]

    def set_setting(self, key: str, value: str) -> None:
        self.cursor_execute(
            """
            INSERT INTO settings (key, value)
            VALUES (?, ?)
            ON CONFLICT(key) DO UPDATE SET
                value = excluded.value
            """,
            (key, value),
        )
        self.commit()

    def get_settings(self) -> dict[str, str]:
        self.cursor_execute(
            """
            SELECT key, value
            FROM settings
            ORDER BY key
            """
        )
        return {
            row["key"]: row["value"]
            for row in self.cursor.fetchall()
        }

    #######################################################
    # Row mappers
    #######################################################

    def row_to_product(self, row: sqlite3.Row | None) -> Product | None:
        if row is None:
            return None

        return Product(
            id=row["id"],
            category_id=row["category_id"],
            product_name=row["product_name"],
            brand=row["brand"],
            unit=row["unit"],
            minimum_quantity=row["minimum_quantity"],
            reorder_threshold=row["reorder_threshold"],
            notes=row["notes"],
            current_quantity=row["current_quantity"],
            current_unit_price=row["current_unit_price"],
            previous_unit_price=row["previous_unit_price"],
            current_purchase_date=row["current_purchase_date"],
            previous_purchase_date=row["previous_purchase_date"],
            average_daily_consumption=row["average_daily_consumption"],
            average_duration_days=row["average_duration_days"],
            expected_next_purchase=row["expected_next_purchase"],
            average_shelf_life_days=self.row_value(
                row,
                "average_shelf_life_days",
            ),
            expected_expiration_date=self.row_value(
                row,
                "expected_expiration_date",
            ),
            price_delta=self.row_value(row, "price_delta"),
            price_delta_percent=self.row_value(row, "price_delta_percent"),
            created_at=row["created_at"],
        )

    def row_to_purchase(self, row: sqlite3.Row | None) -> Purchase | None:
        if row is None:
            return None

        return Purchase(
            id=row["id"],
            product_id=row["product_id"],
            store_id=row["store_id"],
            purchase_date=row["purchase_date"],
            quantity=row["quantity"],
            unit=row["unit"],
            unit_price=row["unit_price"],
            total_price=row["total_price"],
            promotion=bool(row["promotion"]),
            expiration_date=self.row_value(row, "expiration_date"),
            notes=row["notes"],
        )

    def row_to_category(self, row: sqlite3.Row | None) -> Category | None:
        if row is None:
            return None

        return Category(
            id=row["id"],
            name=row["name"],
            description=row["description"],
        )

    def row_to_store(self, row: sqlite3.Row | None) -> Store | None:
        if row is None:
            return None

        return Store(
            id=row["id"],
            name=row["name"],
            city=row["city"],
            state=row["state"],
            address=self.row_value(row, "address"),
        )

    #######################################################
    # Utilities
    #######################################################

    def commit(self) -> None:
        self.connection.commit()

    def close(self) -> None:
        close_connection(self.connection)

    def cursor_execute(self, sql, parameters=()):
        return self.cursor.execute(sql, parameters)

    def row_value(self, row: sqlite3.Row, column: str, default=None):
        if column not in row.keys():
            return default

        return row[column]

    def vacuum(self) -> None:
        self.cursor_execute("VACUUM")

    def analyze(self) -> None:
        self.cursor_execute("ANALYZE")

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    @property
    def is_open(self) -> bool:
        try:
            self.connection.execute("SELECT 1")
            return True
        except Exception:
            return False

    @property
    def in_transaction(self) -> bool:
        return self.connection.in_transaction
