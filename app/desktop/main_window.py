"""
Main Window
"""

from PySide6.QtWidgets import (
    QMainWindow,
    QTabWidget,
)

from app.desktop.ui.pages.register_page import RegisterPage
from app.desktop.ui.pages.lists_page import ListsPage
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

        self.lists_page = ListsPage(
            self
        )

        self.history_page = HistoryPage(
            self
        )

        self.settings_page = SettingsPage(
            self
        )

        self.register_page.main_window = self

        ####################################################
        # Add tabs
        ####################################################

        self.tabs.addTab(
            self.register_page,
            "Register",
        )

        self.tabs.addTab(
            self.lists_page,
            "Lists",
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
        Open Lists tab with the in-house view.
        """

        self.lists_page.set_view(
            "in-house"
        )

        self.tabs.setCurrentWidget(
            self.lists_page
        )

    def open_shortage(self):
        """
        Open Lists tab with the shortage view.
        """

        self.lists_page.set_view(
            "shortage"
        )

        self.tabs.setCurrentWidget(
            self.lists_page
        )

    def open_market(self):
        """
        Open Lists tab with the to-buy view.
        """

        self.lists_page.set_view(
            "to-buy"
        )

        self.tabs.setCurrentWidget(
            self.lists_page
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

        self.lists_page.load_products()

        self.history_page.load_history()
