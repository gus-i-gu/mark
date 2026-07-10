import sqlite3
import tempfile
import unittest
from pathlib import Path

from app.core import database
from app.core.services import ProductService
from app import main as app_main


class IsolatedDatabaseTest(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.user_dir = Path(self.temp_dir.name) / "Markei"
        self.database_path = self.user_dir / "market.sqlite"

        self.originals = {
            "USER_DATABASE_DIR": database.USER_DATABASE_DIR,
            "DATABASE_DIR": database.DATABASE_DIR,
            "DATABASE_PATH": database.DATABASE_PATH,
            "SCHEMA_PATH": database.SCHEMA_PATH,
            "SEED_PATH": database.SEED_PATH,
        }

        database.USER_DATABASE_DIR = self.user_dir
        database.DATABASE_DIR = self.user_dir
        database.DATABASE_PATH = self.database_path
        database.SCHEMA_PATH = (
            Path(__file__).resolve().parents[1]
            / "app"
            / "database"
            / "schema.sql"
        )
        database.SEED_PATH = (
            Path(__file__).resolve().parents[1]
            / "app"
            / "database"
            / "seed.sql"
        )

    def tearDown(self):
        for name, value in self.originals.items():
            setattr(database, name, value)
        self.temp_dir.cleanup()

    def table_count(self, table_name: str) -> int:
        connection = sqlite3.connect(self.database_path)
        try:
            return connection.execute(
                f"SELECT COUNT(*) FROM {table_name}"
            ).fetchone()[0]
        finally:
            connection.close()

    def test_seed_free_first_launch_creates_empty_business_database(self):
        connection = database.connect()
        connection.close()

        self.assertTrue(self.database_path.exists())
        self.assertEqual(self.table_count("products"), 0)
        self.assertEqual(self.table_count("purchases"), 0)
        self.assertEqual(self.table_count("stores"), 0)
        self.assertEqual(self.table_count("categories"), 0)
        self.assertGreater(self.table_count("settings"), 0)

    def test_first_receipt_creates_user_entered_category_without_seeded_store(self):
        service = ProductService()
        try:
            result = service.register_receipt(
                product_id="P001",
                category_id="PANTRY",
                product_name="Rice",
                brand="",
                quantity=1,
                unit="kg",
                purchase_date="10/07/2026",
                unit_price=7.5,
                total_price=7.5,
                store_id=None,
            )
        finally:
            service.close()

        self.assertTrue(result["success"])
        self.assertEqual(self.table_count("categories"), 1)
        self.assertEqual(self.table_count("products"), 1)
        self.assertEqual(self.table_count("purchases"), 1)
        self.assertEqual(self.table_count("stores"), 0)


class StartupFailureLogTest(unittest.TestCase):
    def test_startup_failure_log_uses_user_data_directory(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            original_user_data_dir = app_main.user_data_dir
            app_main.user_data_dir = lambda: Path(temp_dir) / "Markei"
            try:
                path = app_main.write_startup_failure(RuntimeError("boom"))
            finally:
                app_main.user_data_dir = original_user_data_dir

            self.assertTrue(path.exists())
            self.assertIn("RuntimeError: boom", path.read_text(encoding="utf-8"))
            self.assertIn("Markei", str(path))


if __name__ == "__main__":
    unittest.main()
