"""
database.py

Markei Database Manager

Responsibilities
----------------

• Create the SQLite database.

• Configure every SQLite connection.

• Initialize schema.

• Provide database connections.

• Close database connections.

This module NEVER

• executes SQL business logic

• knows Product

• knows Repository

• performs calculations

Architecture

Repository
        ↓
Database Manager
        ↓
SQLite
"""

import os

import sqlite3

import sys

from pathlib import Path

from .config import (

    DATABASE_NAME,

    SCHEMA_NAME,

    SEED_NAME,

)


###########################################################
#
# PROJECT PATHS
#
###########################################################

def resource_base() -> Path:
    """
    Return the base directory for bundled application resources.
    """

    if getattr(sys, "frozen", False):

        return Path(

            getattr(sys, "_MEIPASS", Path(sys.executable).parent)

        )

    return Path(__file__).resolve().parents[2]


def user_data_dir() -> Path:
    """
    Return Markei's user-writable data directory.
    """

    local_app_data = os.environ.get("LOCALAPPDATA")

    if local_app_data:

        return Path(local_app_data) / "Markei"

    return Path.home() / "AppData" / "Local" / "Markei"


RESOURCE_DATABASE_DIR = resource_base() / "app" / "database"

USER_DATABASE_DIR = user_data_dir()

DATABASE_DIR = USER_DATABASE_DIR

DATABASE_PATH = USER_DATABASE_DIR / DATABASE_NAME

SCHEMA_PATH = RESOURCE_DATABASE_DIR / SCHEMA_NAME

SEED_PATH = RESOURCE_DATABASE_DIR / SEED_NAME


###########################################################
#
# SQLITE CONFIGURATION
#
###########################################################

def configure(

    connection: sqlite3.Connection,

) -> sqlite3.Connection:
    """
    Configure a SQLite connection.

    Every connection created by Markei
    must pass through this function.
    """

    #######################################################
    # Foreign keys
    #######################################################

    connection.execute(

        "PRAGMA foreign_keys = ON;"

    )


    #######################################################
    # WAL journal
    #######################################################

    connection.execute(

        "PRAGMA journal_mode = WAL;"

    )


    #######################################################
    # Performance
    #######################################################

    connection.execute(

        "PRAGMA synchronous = NORMAL;"

    )


    #######################################################
    # sqlite3.Row
    #######################################################

    connection.row_factory = sqlite3.Row


    return connection

###########################################################
#
# DATABASE STATUS
#
###########################################################

def database_exists() -> bool:
    """
    Check whether the SQLite database
    already exists.
    """

    return DATABASE_PATH.exists()


###########################################################
#
# DATABASE INITIALIZATION
#
###########################################################

def initialize(

    recreate: bool = False,

) -> None:
    """
    Create the user database from bundled resources.

    Steps

    1. Create database directory.

    2. Create SQLite database.

    3. Execute schema.sql.

    4. Execute seed.sql (optional).

    5. Commit changes.

    6. Close connection.
    """

    #######################################################
    # Create directory
    #######################################################

    USER_DATABASE_DIR.mkdir(

        parents=True,

        exist_ok=True,

    )


    #######################################################
    # Preserve existing user data unless explicitly reset
    #######################################################

    if DATABASE_PATH.exists():

        if not recreate:

            connection = connect()

            connection.close()

            return

        DATABASE_PATH.unlink()


    #######################################################
    # Open connection
    #######################################################

    connection = sqlite3.connect(

        DATABASE_PATH

    )

    connection = configure(

        connection

    )

    cursor = connection.cursor()


    #######################################################
    # Execute schema.sql
    #######################################################

    with open(

        SCHEMA_PATH,

        "r",

        encoding="utf-8",

    ) as file:

        cursor.executescript(

            file.read()

        )


    #######################################################
    # Execute seed.sql (optional)
    #######################################################

    if SEED_PATH.exists():

        with open(

            SEED_PATH,

            "r",

            encoding="utf-8",

        ) as file:

            cursor.executescript(

                file.read()

            )


    #######################################################
    # Finish
    #######################################################

    connection.commit()

    connection.close()

    print(

        "Database initialized successfully."

    )


###########################################################
#
# DATABASE MIGRATION
#
###########################################################

def table_columns(

    connection: sqlite3.Connection,

    table_name: str,

) -> set[str]:
    """
    Return the current column names for a table.
    """

    rows = connection.execute(

        f"PRAGMA table_info({table_name});"

    ).fetchall()

    return {

        row["name"]

        for row in rows

    }


def ensure_column(

    connection: sqlite3.Connection,

    table_name: str,

    column_name: str,

    definition: str,

) -> None:
    """
    Add a nullable column only when it is missing.
    """

    if column_name in table_columns(connection, table_name):

        return

    connection.execute(

        f"ALTER TABLE {table_name} ADD COLUMN {column_name} {definition};"

    )


def ensure_settings_table(

    connection: sqlite3.Connection,

) -> None:
    """
    Create the key/value settings table when missing.
    """

    connection.execute(

        """
        CREATE TABLE IF NOT EXISTS settings (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
        );
        """

    )


def ensure_default_setting(

    connection: sqlite3.Connection,

    key: str,

    value: str,

) -> None:
    """
    Insert a default setting without overwriting user choices.
    """

    connection.execute(

        """
        INSERT OR IGNORE INTO settings (key, value)
        VALUES (?, ?)
        """,

        (key, value),

    )


def migrate(

    connection: sqlite3.Connection,

) -> None:
    """
    Apply idempotent schema upgrades for existing databases.
    """

    ensure_column(

        connection,

        "purchases",

        "expiration_date",

        "TEXT",

    )

    ensure_column(

        connection,

        "products",

        "average_shelf_life_days",

        "INTEGER",

    )

    ensure_column(

        connection,

        "products",

        "expected_expiration_date",

        "TEXT",

    )

    ensure_column(

        connection,

        "stores",

        "address",

        "TEXT",

    )

    ensure_settings_table(

        connection

    )

    ensure_default_setting(

        connection,

        "history.week_boundary",

        "wednesday",

    )

    ensure_default_setting(

        connection,

        "history.month_boundary_rule",

        "first_wednesday",

    )

    ensure_default_setting(

        connection,

        "pages.order",

        "Register,Storage,Shortage,Market,History,Settings",

    )

    connection.commit()

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

    connection = configure(

        connection

    )

    migrate(

        connection

    )

    return connection


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

    initialize(

        recreate=True,

    )


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
