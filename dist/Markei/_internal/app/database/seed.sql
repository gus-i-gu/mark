-- =====================================================
-- MARKei Seed Data
-- =====================================================

-- ==========================
-- Categories
-- ==========================

INSERT INTO categories
(
    id,
    name,
    description
)
VALUES
(
    'F',
    'Food',
    'Food products'
);

-- ==========================
-- Stores
-- ==========================

INSERT INTO stores
(
    id,
    name,
    city,
    state
)
VALUES
(
    1,
    'Muffato',
    'Curitiba',
    'PR'
);

-- ==========================
-- Products
-- ==========================

INSERT INTO products
(
    id,
    category_id,
    product_name,
    brand,
    current_quantity,
    unit,
    minimum_quantity,
    average_daily_consumption,
    notes,
    created_at,
    current_unit_price,
    previous_unit_price,
    current_purchase_date,
    previous_purchase_date,
    average_duration_days,
    reorder_threshold,
    expected_next_purchase
)
VALUES
(
    'F001',
    'F',
    'Rice',
    'Tio João',
    5,
    'kg',
    1,
    0.15,
    '',

    '2026-06-30',

    NULL,

    NULL,

    '2026-06-30',

    NULL,

    NULL,

    5,

    NULL
);