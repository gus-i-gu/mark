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

import sqlite3

from pathlib import Path

from .config import (

    DATABASE_DIR_NAME,

    DATABASE_NAME,

    SCHEMA_NAME,

    SEED_NAME,

)


###########################################################
#
# PROJECT PATHS
#
###########################################################

# app/core/

APP_DIR = Path(__file__).resolve().parent


# markei/

PROJECT_DIR = APP_DIR.parent.parent


# markei/database/

DATABASE_DIR = PROJECT_DIR / DATABASE_DIR_NAME


# markei/database/market.sqlite

DATABASE_PATH = DATABASE_DIR / DATABASE_NAME


# markei/database/schema.sql

SCHEMA_PATH = DATABASE_DIR / SCHEMA_NAME


# markei/database/seed.sql

SEED_PATH = DATABASE_DIR / SEED_NAME


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

def initialize() -> None:
    """
    Create a fresh database.

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

    DATABASE_DIR.mkdir(

        parents=True,

        exist_ok=True,

    )


    #######################################################
    # Recreate database
    #######################################################

    if DATABASE_PATH.exists():

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