"""
Main Window
"""

from PySide6.QtWidgets import (
    QMainWindow,
    QTabWidget,
)

from app.desktop.ui.pages.register_page import RegisterPage
from app.desktop.ui.pages.storage_page import StoragePage
from app.desktop.ui.pages.shortage_page import ShortagePage
from app.desktop.ui.pages.market_page import MarketPage
from app.desktop.ui.pages.history_page import HistoryPage
from app.desktop.ui.pages.settings_page import SettingsPage


class MainWindow(QMainWindow):

    def __init__(self):

        super().__init__()

        self.setWindowTitle("Markei")

        ####################################################
        # Tabs
        ####################################################

        self.tabs = QTabWidget()

        ####################################################
        # Pages
        ####################################################

        self.register_page = RegisterPage()

        self.storage_page = StoragePage(
            self
        )

        self.shortage_page = ShortagePage(
            self
        )

        self.market_page = MarketPage(
            self
        )

        self.history_page = HistoryPage(
            self
        )

        self.settings_page = SettingsPage(
            self
        )

        self.register_page.main_window = self

        self.storage_page.main_window = self

        self.shortage_page.main_window = self

        self.market_page.main_window = self

        ####################################################
        # Add tabs
        ####################################################

        self.tabs.addTab(
            self.register_page,
            "Register",
        )

        self.tabs.addTab(
            self.storage_page,
            "Storage",
        )

        self.tabs.addTab(
            self.shortage_page,
            "Shortage",
        )

        self.tabs.addTab(
            self.market_page,
            "Market",
        )

        self.tabs.addTab(
            self.history_page,
            "History",
        )

        self.tabs.addTab(
            self.settings_page,
            "Settings",
        )

        ####################################################
        # Central widget
        ####################################################

        self.setCentralWidget(
            self.tabs
        )

    ####################################################
    #
    # Navigation helpers
    #
    ####################################################

    def open_register(self):
        """
        Open Register tab.
        """

        self.tabs.setCurrentWidget(
            self.register_page
        )

    def open_storage(self):
        """
        Open Storage tab.
        """

        self.tabs.setCurrentWidget(
            self.storage_page
        )

    def open_shortage(self):
        """
        Open Shortage tab.
        """

        self.tabs.setCurrentWidget(
            self.shortage_page
        )

    def open_market(self):
        """
        Open Market tab.
        """

        self.tabs.setCurrentWidget(
            self.market_page
        )

    ####################################################
    #
    # Editing
    #
    ####################################################

    def edit_product(
        self,
        product,
    ):
        """
        Open the Register page already populated
        with the selected product.
        """

        self.register_page.load_product(
            product
        )

        self.open_register()
    
    ####################################################
    #
    # Refresh
    #
    ####################################################

    def refresh_pages(self):
        """
        Refresh every inventory page.
        """

        self.storage_page.load_products()

        self.shortage_page.load_products()

        self.market_page.load_products()

        self.history_page.load_history()
