"""
Storage Page

Displays every product currently considered
available for consumption.

Products displayed here are considered
safe according to the prediction engine.

This page is READ ONLY.
"""

from datetime import datetime

from PySide6.QtCore import Qt

from PySide6.QtGui import QColor

from PySide6.QtWidgets import (

    QWidget,

    QLabel,

    QVBoxLayout,

    QHBoxLayout,

    QPushButton,

    QHeaderView,

    QTableWidget,

    QTableWidgetItem,

)
from app.core.services import ProductService


class ShortagePage(QWidget):

    ####################################################
    #
    # INITIALIZATION
    #
    ####################################################

    def __init__(
        self,
        main_window,
        ):

        super().__init__()

        self.main_window = main_window

        self.service = ProductService()

        self.build_ui()

        self.load_products()


    ####################################################
    #
    # USER INTERFACE
    #
    ####################################################

    def build_ui(self):

        layout = QVBoxLayout()

        ################################################
        # Title
        ################################################

        title = QLabel("Shortage")

        title.setStyleSheet("""

            font-size:20px;

            font-weight:bold;

        """)

        layout.addWidget(title)

        ################################################
        # Toolbar
        ################################################

        toolbar = QHBoxLayout()

        self.refresh_button = QPushButton(

            "↻ Refresh"

        )

        self.refresh_button.clicked.connect(

            self.load_products

        )

        toolbar.addWidget(

            self.refresh_button

        )

        toolbar.addStretch()

        layout.addLayout(

            toolbar

        )

        ################################################
        # Product table
        ################################################

        self.table = QTableWidget()

        self.table.setColumnCount(8)

        self.table.setHorizontalHeaderLabels([

            "Product",

            "Brand",

            "Quantity",

            "Cycle",

            "Next Purchase",

            "Remaining",

            "Status",

            "ID",

        ])

        header = self.table.horizontalHeader()

        header.setSectionResizeMode(

            QHeaderView.Stretch

        )

        self.table.setAlternatingRowColors(True)

        self.table.setSelectionBehavior(

            QTableWidget.SelectRows

        )

        self.table.setEditTriggers(

            QTableWidget.NoEditTriggers

        )

        layout.addWidget(

            self.table

        )

        self.setLayout(layout)

        self.table.cellDoubleClicked.connect(
        self.edit_selected_product
        )
        
    ####################################################
    #
    # LOAD PRODUCTS
    #
    ####################################################

    def load_products(self):

        self.table.setRowCount(0)

        products = self.service.get_shortage_products()

        for product in products:

            row = self.table.rowCount()

            self.table.insertRow(row)

            ################################################
            # Product
            ################################################

            self.table.setItem(

                row,

                0,

                QTableWidgetItem(

                    product.product_name

                )

            )

            ################################################
            # Brand
            ################################################

            self.table.setItem(

                row,

                1,

                QTableWidgetItem(

                    product.brand

                )

            )

            ################################################
            # Quantity
            ################################################

            quantity = (

                f"{product.current_quantity} "

                f"{product.unit}"

            )

            self.table.setItem(

                row,

                2,

                QTableWidgetItem(

                    quantity

                )

            )

            ################################################
            # Consumption cycle
            ################################################

            cycle = self.format_cycle(

                product.average_duration_days

            )

            self.table.setItem(

                row,

                3,

                QTableWidgetItem(cycle)

            )

            next_purchase = self.format_date(

                product.expected_next_purchase

            )

            self.table.setItem(

            row,

              4,

             QTableWidgetItem(next_purchase)

            )

            remaining = self.format_remaining(

                product

            )

            self.table.setItem(

             row,

              5,

            QTableWidgetItem(remaining)

            )
       ################################################
       # Status
       ################################################

            status_item = self.create_status_item(

            product

            )

            self.table.setItem(

                row,

                6,

                status_item

                )

        ################################################
        # ID
        ################################################

            id_item = QTableWidgetItem(

                product.id

            )

            id_item.setTextAlignment(

                Qt.AlignCenter

            )

            self.table.setItem(

                row,

                7,

                id_item

            )

    ####################################################
    #
    # FORMAT HELPERS
    #
    ####################################################

    def format_cycle(self, days):

        """
        Format the average consumption cycle.
        """

        if days is None:

            return "—"

        if days == 1:

            return "1 day"

        return f"{days} days"


    ####################################################

    def format_date(self, value):

        """
        Convert YYYY-MM-DD into DD/MM/YYYY.
        """

        if value is None:

            return "—"

        try:

            date = datetime.strptime(

                value,

                "%Y-%m-%d",

            )

            return date.strftime(

                "%d/%m/%Y"

            )

        except Exception:

            return value


    ####################################################

    def format_remaining(self, product):

        """
        Format remaining stock time.
        """

        remaining = self.service.days_until_restock(

            product

        )

        if remaining is None:

            return "—"

        if remaining > 1:

            return f"{remaining} days"

        if remaining == 1:

            return "Tomorrow"

        if remaining == 0:

            return "Today"

        return f"{abs(remaining)} days overdue"


    ####################################################

    def create_status_item(self, product):

        """
        Create the colored status indicator.
        """

        status = self.service.product_status(

            product

        )

        item = QTableWidgetItem("●")

        item.setTextAlignment(

            Qt.AlignCenter

        )

        colors = {

            "storage": QColor(46, 204, 113),     # green

            "shortage": QColor(241, 196, 15),    # yellow

            "market": QColor(230, 126, 34),      # orange

        }

        item.setForeground(

            colors.get(

                status,

                QColor(150, 150, 150)

            )

        )

        return item

    def edit_selected_product(
        self,
        row,
        column,
    ):
        """
        User double-clicked a row.
        """

        product_id = self.table.item(row, 7).text()

        product = self.service.get_product(product_id)

        self.main_window.edit_product(
        product
    )