###########################################################
#
# DATABASE CONNECTION
#
###########################################################

def connect() -> sqlite3.Connection:
    """
    Return a configured SQLite connection.

    If the database does not exist,
    it is automatically initialized.
    """

    #######################################################
    # Ensure database exists
    #######################################################

    if not database_exists():

        print(

            "Database not found."

        )

        print(

            "Initializing database...\n"

        )

        initialize()


    #######################################################
    # Open connection
    #######################################################

    connection = sqlite3.connect(

        DATABASE_PATH

    )


    #######################################################
    # Configure connection
    #######################################################

    return configure(

        connection

    )


###########################################################
#
# DATABASE CLOSE
#
###########################################################

def close(

    connection: sqlite3.Connection,

) -> None:
    """
    Safely close a SQLite connection.
    """

    if connection is not None:

        connection.close()


###########################################################
#
# DATABASE RESET
#
###########################################################

def reset() -> None:
    """
    Delete the current database
    and rebuild it from schema.sql.
    """

    initialize()


###########################################################
#
# TEST
#
###########################################################

if __name__ == "__main__":

    initialize()

    print(

        "Database path:",

        DATABASE_PATH,

    )

    print(

        "Database exists:",

        database_exists(),

    )

    #######################################################
    #
    # PRODUCTS
    #
    #######################################################

    def create_product(

        self,

        product: Product,

    ) -> Product:
        """
        Insert a new Product.
        """

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

                price_delta,

                price_delta_percent,

                created_at

            )

            VALUES (

                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                ?, ?, ?, ?, ?, ?, ?, ?, ?

            )
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

                product.price_delta,

                product.price_delta_percent,

                product.created_at,

            ),

        )

        self.commit()

        return product


    #######################################################

    def update_product(

        self,

        product: Product,

    ) -> Product:
        """
        Update an existing Product.
        """

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

                product.price_delta,

                product.price_delta_percent,

                product.id,

            ),

        )

        self.commit()

        return product


    #######################################################

    def rename_product(

        self,

        old_id: str,

        new_id: str,

    ) -> None:
        """
        Rename a Product ID.

        Purchase history follows automatically
        through ON UPDATE CASCADE.
        """

        self.cursor_execute(

            """
            UPDATE products

            SET id = ?

            WHERE id = ?
            """,

            (

                new_id,

                old_id,

            ),

        )

        self.commit()


    #######################################################

    def delete_product(

        self,

        product_id: str,

    ) -> None:
        """
        Delete one Product.

        Purchase history is deleted through
        ON DELETE CASCADE.
        """

        self.cursor_execute(

            """
            DELETE

            FROM products

            WHERE id = ?
            """,

            (

                product_id,

            ),

        )

        self.commit()


    #######################################################

    def get_product(

        self,

        product_id: str,

    ) -> Product | None:

        self.cursor_execute(

            """
            SELECT *

            FROM products

            WHERE id = ?
            """,

            (

                product_id,

            ),

        )

        return self.row_to_product(

            self.cursor.fetchone()

        )


    #######################################################

    def get_products(

        self,

    ) -> list[Product]:

        self.cursor_execute(

            """
            SELECT *

            FROM products

            ORDER BY product_name
            """

        )

        return [

            self.row_to_product(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def exists_product(

        self,

        product_id: str,

    ) -> bool:

        self.cursor_execute(

            """
            SELECT 1

            FROM products

            WHERE id = ?

            LIMIT 1
            """,

            (

                product_id,

            ),

        )

        return self.cursor.fetchone() is not None


    #######################################################

    def count_products(

        self,

    ) -> int:

        self.cursor_execute(

            """
            SELECT COUNT(*)

            FROM products
            """

        )

        return self.cursor.fetchone()[0]

    #######################################################
    #
    # PURCHASES
    #
    #######################################################

    def insert_purchase(

        self,

        purchase: Purchase,

    ) -> Purchase:
        """
        Insert one immutable purchase.
        """

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

                notes

            )

            VALUES (

                ?, ?, ?, ?, ?, ?, ?, ?, ?

            )

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

                purchase.notes,

            ),

        )

        purchase.id = self.cursor.lastrowid

        self.commit()

        return purchase


    #######################################################

    def delete_purchase(

        self,

        purchase_id: int,

    ) -> None:
        """
        Delete one purchase.

        Business logic (summary recalculation)
        belongs to ProductService.
        """

        self.cursor_execute(

            """
            DELETE

            FROM purchases

            WHERE id = ?

            """,

            (

                purchase_id,

            ),

        )

        self.commit()


    #######################################################

    def get_purchase(

        self,

        purchase_id: int,

    ) -> Purchase | None:

        self.cursor_execute(

            """
            SELECT *

            FROM purchases

            WHERE id = ?

            """,

            (

                purchase_id,

            ),

        )

        return self.row_to_purchase(

            self.cursor.fetchone()

        )


    #######################################################

    def get_purchases(

        self,

        product_id: str | None = None,

    ) -> list[Purchase]:
        """
        Return every purchase.

        If product_id is supplied,
        return only that product history.
        """

        if product_id is None:

            self.cursor_execute(

                """
                SELECT *

                FROM purchases

                ORDER BY purchase_date DESC,
                         id DESC
                """

            )

        else:

            self.cursor_execute(

                """
                SELECT *

                FROM purchases

                WHERE product_id = ?

                ORDER BY purchase_date DESC,
                         id DESC
                """,

                (

                    product_id,

                ),

            )

        return [

            self.row_to_purchase(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def get_last_purchase(

        self,

        product_id: str,

    ) -> Purchase | None:
        """
        Return the latest purchase
        of one product.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM purchases

            WHERE product_id = ?

            ORDER BY purchase_date DESC,
                     id DESC

            LIMIT 1
            """,

            (

                product_id,

            ),

        )

        return self.row_to_purchase(

            self.cursor.fetchone()

        )


    #######################################################

    def get_previous_purchase(

        self,

        product_id: str,

    ) -> Purchase | None:
        """
        Return the purchase immediately
        before the latest one.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM purchases

            WHERE product_id = ?

            ORDER BY purchase_date DESC,
                     id DESC

            LIMIT 1 OFFSET 1
            """,

            (

                product_id,

            ),

        )

        return self.row_to_purchase(

            self.cursor.fetchone()

        )


    #######################################################

    def count_purchases(

        self,

    ) -> int:

        self.cursor_execute(

            """
            SELECT COUNT(*)

            FROM purchases
            """

        )

        return self.cursor.fetchone()[0]

    #######################################################
    #
    # CATEGORIES
    #
    #######################################################

    def get_categories(

        self,

    ) -> list[Category]:
        """
        Return every registered category.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM categories

            ORDER BY name
            """

        )

        return [

            self.row_to_category(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def get_category(

        self,

        category_id: str,

    ) -> Category | None:
        """
        Return one category.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM categories

            WHERE id = ?
            """,

            (

                category_id,

            ),

        )

        return self.row_to_category(

            self.cursor.fetchone()

        )


    #######################################################
    #
    # STORES
    #
    #######################################################

    def get_stores(

        self,

    ) -> list[Store]:
        """
        Return every registered store.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM stores

            ORDER BY name
            """

        )

        return [

            self.row_to_store(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def get_store(

        self,

        store_id: int,

    ) -> Store | None:
        """
        Return one store.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM stores

            WHERE id = ?
            """,

            (

                store_id,

            ),

        )

        return self.row_to_store(

            self.cursor.fetchone()

        )


    #######################################################
    #
    # PROMOTIONS
    #
    #######################################################

    def get_promotions(

        self,

    ) -> list[Promotion]:
        """
        Return every promotion.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM promotions

            ORDER BY start_date DESC,
                     id DESC
            """

        )

        return [

            self.row_to_promotion(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def get_product_promotions(

        self,

        product_id: str,

    ) -> list[Promotion]:
        """
        Return every promotion of one product.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM promotions

            WHERE product_id = ?

            ORDER BY start_date DESC,
                     id DESC
            """,

            (

                product_id,

            ),

        )

        return [

            self.row_to_promotion(row)

            for row in self.cursor.fetchall()

        ]


    #######################################################

    def get_active_promotions(

        self,

        current_date: str,

    ) -> list[Promotion]:
        """
        Return active promotions.
        """

        self.cursor_execute(

            """
            SELECT *

            FROM promotions

            WHERE

                start_date <= ?

            AND

                end_date >= ?

            ORDER BY promotional_price
            """,

            (

                current_date,

                current_date,

            ),

        )

        return [

            self.row_to_promotion(row)

            for row in self.cursor.fetchall()

        ]

    #######################################################
    #
    # UTILITIES
    #
    #######################################################

    def exists_purchase(

        self,

        purchase_id: int,

    ) -> bool:
        """
        Check whether a Purchase exists.
        """

        self.cursor_execute(

            """
            SELECT 1

            FROM purchases

            WHERE id = ?

            LIMIT 1
            """,

            (

                purchase_id,

            ),

        )

        return self.cursor.fetchone() is not None


    #######################################################

    def exists_category(

        self,

        category_id: str,

    ) -> bool:
        """
        Check whether a Category exists.
        """

        self.cursor_execute(

            """
            SELECT 1

            FROM categories

            WHERE id = ?

            LIMIT 1
            """,

            (

                category_id,

            ),

        )

        return self.cursor.fetchone() is not None


    #######################################################

    def exists_store(

        self,

        store_id: int,

    ) -> bool:
        """
        Check whether a Store exists.
        """

        self.cursor_execute(

            """
            SELECT 1

            FROM stores

            WHERE id = ?

            LIMIT 1
            """,

            (

                store_id,

            ),

        )

        return self.cursor.fetchone() is not None


    #######################################################

    def count_categories(

        self,

    ) -> int:

        self.cursor_execute(

            """
            SELECT COUNT(*)

            FROM categories
            """

        )

        return self.cursor.fetchone()[0]


    #######################################################

    def count_stores(

        self,

    ) -> int:

        self.cursor_execute(

            """
            SELECT COUNT(*)

            FROM stores
            """

        )

        return self.cursor.fetchone()[0]


    #######################################################

    def count_promotions(

        self,

    ) -> int:

        self.cursor_execute(

            """
            SELECT COUNT(*)

            FROM promotions
            """

        )

        return self.cursor.fetchone()[0]


    #######################################################

    def vacuum(

        self,

    ) -> None:
        """
        Optimize the SQLite database.
        """

        self.cursor_execute(

            "VACUUM"

        )


    #######################################################

    def analyze(

        self,

    ) -> None:
        """
        Refresh SQLite statistics.
        """

        self.cursor_execute(

            "ANALYZE"

        )

    #######################################################
    #
    # CONTEXT MANAGER
    #
    #######################################################

    def __enter__(self):
        """
        Enable

            with Repository() as repo:

                ...

        """

        return self


    #######################################################

    def __exit__(

        self,

        exc_type,

        exc_value,

        traceback,

    ):
        """
        Automatically close the
        SQLite connection.
        """

        self.close()


    #######################################################
    #
    # DATABASE STATUS
    #
    #######################################################

    @property
    def is_open(

        self,

    ) -> bool:
        """
        True while the SQLite
        connection is available.
        """

        try:

            self.connection.execute(

                "SELECT 1"

            )

            return True

        except Exception:

            return False


    #######################################################

    @property
    def in_transaction(

        self,

    ) -> bool:
        """
        Return whether SQLite
        currently has an open
        transaction.
        """

        return self.connection.in_transaction


    #######################################################

    def cursor_execute(

        self,

        sql,

        parameters=(),

    ):
        """
        Internal helper.

        Every Repository method
        should execute SQL through
        this function.

        Makes future logging
        considerably easier.
        """

        return self.cursor_execute(

            sql,

            parameters,

        )