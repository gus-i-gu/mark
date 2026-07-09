"""
Unified Lists page.
"""

from PySide6.QtCore import Qt

from PySide6.QtGui import QColor

from PySide6.QtWidgets import (
    QComboBox,
    QHBoxLayout,
    QHeaderView,
    QLabel,
    QPushButton,
    QTableWidget,
    QTableWidgetItem,
    QVBoxLayout,
    QWidget,
)

from app.core.services import ProductService


class ListsPage(QWidget):
    """
    Public inventory page with internal product views.
    """

    def __init__(
        self,
        main_window=None,
    ):
        super().__init__()

        self.main_window = main_window

        self.service = ProductService()

        self.build_ui()

        self.load_products()

    def build_ui(self):
        layout = QVBoxLayout(self)

        title = QLabel("Lists")
        title.setStyleSheet("font-size:20px;font-weight:bold;")

        toolbar = QHBoxLayout()

        self.view_selector = QComboBox()

        for label, key in [
            ("All products", "all"),
            ("In-house", "in-house"),
            ("Shortage", "shortage"),
            ("To buy", "to-buy"),
            ("In-house + Shortage", "in-house + shortage"),
            ("Shortage + To buy", "shortage + to-buy"),
        ]:
            self.view_selector.addItem(label, key)

        self.view_selector.currentIndexChanged.connect(
            self.load_products
        )

        self.refresh_button = QPushButton("Refresh")
        self.refresh_button.clicked.connect(self.load_products)

        toolbar.addWidget(self.view_selector)
        toolbar.addWidget(self.refresh_button)
        toolbar.addStretch()

        self.table = QTableWidget()
        self.table.setColumnCount(10)
        self.table.setHorizontalHeaderLabels(
            [
                "Product",
                "Brand",
                "Quantity",
                "Price",
                "Δ Price",
                "Cycle",
                "Next Purchase",
                "Remaining",
                "Status",
                "ID",
            ]
        )

        header = self.table.horizontalHeader()
        header.setSectionResizeMode(QHeaderView.Stretch)

        self.table.setAlternatingRowColors(True)
        self.table.setSelectionBehavior(QTableWidget.SelectRows)
        self.table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.table.cellDoubleClicked.connect(self.edit_selected_product)

        layout.addWidget(title)
        layout.addLayout(toolbar)
        layout.addWidget(self.table)

    def load_products(self):
        view_key = self.view_selector.currentData() or "all"

        result = self.service.get_lists_view(view_key)

        self.table.setRowCount(0)

        for row_model in result.get("rows", []):
            self.add_row(row_model)

    def set_view(
        self,
        view_key: str,
    ):
        for index in range(self.view_selector.count()):
            if self.view_selector.itemData(index) == view_key:
                self.view_selector.setCurrentIndex(index)
                self.load_products()
                return

    def add_row(
        self,
        row_model: dict,
    ):
        row = self.table.rowCount()

        self.table.insertRow(row)

        values = [
            row_model.get("product_name"),
            row_model.get("brand") or "-",
            row_model.get("quantity_label"),
            row_model.get("price_label"),
            row_model.get("delta_price_label"),
            row_model.get("cycle_label"),
            row_model.get("next_purchase_label"),
            row_model.get("remaining_label"),
            row_model.get("status_label"),
            row_model.get("product_id"),
        ]

        for column, value in enumerate(values):
            item = QTableWidgetItem(str(value or "-"))

            if column == 4:
                item.setForeground(
                    self.price_delta_color(
                        row_model.get("delta_price_direction")
                    )
                )

            if column == 8:
                item.setForeground(
                    self.status_color(row_model.get("status"))
                )

            if column == 9:
                item.setTextAlignment(Qt.AlignCenter)

            self.table.setItem(row, column, item)

    def price_delta_color(
        self,
        direction: str | None,
    ) -> QColor:
        if direction == "up":
            return QColor(230, 126, 34)

        if direction == "down":
            return QColor(46, 204, 113)

        return QColor(150, 150, 150)

    def status_color(
        self,
        status: str | None,
    ) -> QColor:
        colors = {
            "in-house": QColor(46, 204, 113),
            "shortage": QColor(241, 196, 15),
            "to-buy": QColor(230, 126, 34),
        }

        return colors.get(status, QColor(150, 150, 150))

    def edit_selected_product(
        self,
        row,
        column,
    ):
        product_id_item = self.table.item(row, 9)

        if product_id_item is None:
            return

        product = self.service.get_product(product_id_item.text())

        if product is not None and self.main_window is not None:
            self.main_window.edit_product(product)

    def refresh(self):
        self.load_products()

    def closeEvent(
        self,
        event,
    ):
        try:
            self.service.close()
        except Exception:
            pass

        event.accept()
