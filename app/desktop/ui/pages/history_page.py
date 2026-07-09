"""
History Page

Read-only purchase history grouped by service-defined periods.
"""

from PySide6.QtWidgets import (
    QLabel,
    QPushButton,
    QTreeWidget,
    QTreeWidgetItem,
    QVBoxLayout,
    QWidget,
)

from app.core.services import ProductService


class HistoryPage(QWidget):

    def __init__(
        self,
        main_window=None,
    ):

        super().__init__()

        self.main_window = main_window

        self.service = ProductService()

        self.build_ui()

        self.load_history()

    def build_ui(self):

        layout = QVBoxLayout(self)

        title = QLabel("History")

        title.setStyleSheet(
            "font-size:20px;font-weight:bold;"
        )

        self.refresh_button = QPushButton("Refresh")

        self.refresh_button.clicked.connect(
            self.load_history
        )

        self.warning_label = QLabel()

        self.tree = QTreeWidget()

        self.tree.setColumnCount(8)

        self.tree.setHeaderLabels(
            [
                "Date",
                "Product",
                "Store",
                "Quantity",
                "Unit Price",
                "Total",
                "Average",
                "ID",
            ]
        )

        layout.addWidget(title)

        layout.addWidget(self.refresh_button)

        layout.addWidget(self.warning_label)

        layout.addWidget(self.tree)

    def load_history(self):

        self.tree.clear()

        history = self.service.get_history_view()

        unparsed_count = len(
            history.get("unparsed_rows", [])
        )

        if unparsed_count:
            self.warning_label.setText(
                f"{unparsed_count} purchase date(s) could not be parsed."
            )
        else:
            self.warning_label.setText("")

        for month in history["months"]:

            month_item = QTreeWidgetItem(
                [
                    f"{month['label']} ({month['period_start']} - {month['period_end']})",
                    "",
                    "",
                    self.quantity_text(month["summary"]),
                    self.money_text(month["summary"].get("monetary_total")),
                    self.store_totals_text(month["summary"]),
                    self.average_text(month["summary"]),
                    "",
                ]
            )

            self.tree.addTopLevelItem(month_item)

            for week in month["weeks"]:

                week_item = QTreeWidgetItem(
                    [
                        week["label"],
                        "",
                        "",
                        self.quantity_text(week["summary"]),
                        self.money_text(week["summary"].get("monetary_total")),
                        self.store_totals_text(week["summary"]),
                        self.average_text(week["summary"]),
                        "",
                    ]
                )

                month_item.addChild(week_item)

                for row in week["rows"]:

                    week_item.addChild(
                        QTreeWidgetItem(
                            [
                                self.value(row.get("purchase_date")),
                                self.value(row.get("product_name")),
                                self.value(row.get("store_name")),
                                self.row_quantity_text(row),
                                self.money_text(row.get("unit_price")),
                                self.money_text(row.get("total_price")),
                                "",
                                self.value(row.get("purchase_id")),
                            ]
                        )
                    )

                week_item.addChild(
                    QTreeWidgetItem(
                        [
                            "Total",
                            "",
                            "",
                            self.quantity_text(week["summary"]),
                            "",
                            self.money_text(
                                week["summary"].get("monetary_total")
                            ),
                            self.average_text(week["summary"]),
                            "",
                        ]
                    )
                )

            month_item.setExpanded(True)

        self.tree.expandAll()

    def value(self, value) -> str:

        if value is None or value == "":

            return "-"

        return str(value)

    def money_text(self, value) -> str:

        if value is None:

            return "-"

        return f"$ {value:.2f}"

    def average_text(self, summary: dict) -> str:

        value = summary.get("average_unit_price")

        if value is None:

            return "-"

        return f"Avg unit $ {value:.2f}"

    def row_quantity_text(self, row: dict) -> str:

        quantity = row.get("quantity")

        unit = row.get("unit")

        if quantity is None:

            return "-"

        return f"{quantity:g} {self.value(unit)}"

    def quantity_text(self, summary: dict) -> str:

        totals = summary.get("quantity_totals", {})

        if not totals:

            return "-"

        return ", ".join(
            f"{quantity:g} {unit}"
            for unit, quantity in totals.items()
        )

    def store_totals_text(self, summary: dict) -> str:

        totals = summary.get("store_totals", {})

        if not totals:

            return "-"

        return "; ".join(
            f"{store}: $ {total:.2f}"
            for store, total in totals.items()
        )

    def refresh(self):

        self.load_history()

    def closeEvent(
        self,
        event,
    ):

        try:

            self.service.close()

        except Exception:

            pass

        event.accept()
