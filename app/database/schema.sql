CREATE TABLE products (

    id TEXT PRIMARY KEY,

    category_id TEXT NOT NULL,

    product_name TEXT NOT NULL,

    brand TEXT,

    unit TEXT NOT NULL,

    minimum_quantity REAL NOT NULL,

    reorder_threshold INTEGER NOT NULL,

    notes TEXT,

    --------------------------------------------------
    -- Current state
    --------------------------------------------------

    current_quantity REAL NOT NULL,

    current_unit_price REAL,

    previous_unit_price REAL,

    current_purchase_date TEXT,

    previous_purchase_date TEXT,

    average_daily_consumption REAL,

    average_duration_days INTEGER,

    expected_next_purchase TEXT,

    price_delta REAL,

    price_delta_percent REAL,

    --------------------------------------------------

    created_at TEXT NOT NULL,

    FOREIGN KEY(category_id)

        REFERENCES categories(id)

);

CREATE TABLE purchases (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    product_id TEXT NOT NULL,

    store_id INTEGER,

    purchase_date TEXT NOT NULL,

    quantity REAL NOT NULL,

    unit TEXT NOT NULL,

    unit_price REAL NOT NULL,

    total_price REAL NOT NULL,

    promotion INTEGER NOT NULL DEFAULT 0,

    notes TEXT,

    FOREIGN KEY(product_id)

        REFERENCES products(id)

        ON UPDATE CASCADE

        ON DELETE CASCADE,

    FOREIGN KEY(store_id)

        REFERENCES stores(id)

);

CREATE TABLE categories (

    id TEXT PRIMARY KEY,

    name TEXT NOT NULL,

    description TEXT

);

CREATE TABLE stores (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    name TEXT NOT NULL,

    city TEXT,

    state TEXT

);

CREATE TABLE promotions (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    product_id TEXT NOT NULL,

    store_id INTEGER,

    promotion_type TEXT NOT NULL,

    required_quantity REAL NOT NULL,

    promotional_price REAL NOT NULL,

    start_date TEXT,

    end_date TEXT,

    FOREIGN KEY(product_id)

        REFERENCES products(id),

    FOREIGN KEY(store_id)

        REFERENCES stores(id)

);

CREATE INDEX idx_product_name

ON products(product_name);

CREATE INDEX idx_purchase_product

ON purchases(product_id);

CREATE INDEX idx_purchase_date

ON purchases(purchase_date);