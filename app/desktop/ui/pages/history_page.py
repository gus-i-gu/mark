"""
History Page

Read-only purchase history grouped by service-defined periods.
"""

from PySide6.QtWidgets import (
    QComboBox,
    QFormLayout,
    QGroupBox,
    QHBoxLayout,
    QHeaderView,
    QLabel,
    QLineEdit,
    QPushButton,
    QTableWidget,
    QTableWidgetItem,
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

        self.stores = []

        self.build_ui()

        self.load_history()

    def build_ui(self):

        layout = QVBoxLayout(self)

        title = QLabel("History")

        title.setStyleSheet(
            "font-size:20px;font-weight:bold;"
        )

        self.refresh_button = QPushButton("Refresh History")

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

        layout.addWidget(self.build_analytics_group())

    def build_analytics_group(self):
        group = QGroupBox("Analytics")

        layout = QVBoxLayout(group)

        form = QFormLayout()

        self.analytics_start_input = QLineEdit()
        self.analytics_start_input.setPlaceholderText("DD/MM/YYYY")

        self.analytics_end_input = QLineEdit()
        self.analytics_end_input.setPlaceholderText("DD/MM/YYYY")

        self.analytics_store_input = QComboBox()

        self.analytics_button = QPushButton("Apply")
        self.analytics_button.clicked.connect(self.load_analytics)

        controls = QHBoxLayout()
        controls.addWidget(self.analytics_button)
        controls.addStretch()

        form.addRow("Start", self.analytics_start_input)
        form.addRow("End", self.analytics_end_input)
        form.addRow("Store", self.analytics_store_input)

        layout.addLayout(form)
        layout.addLayout(controls)

        self.analytics_summary_label = QLabel()

        layout.addWidget(self.analytics_summary_label)

        self.analytics_table = QTableWidget()
        self.analytics_table.setColumnCount(8)
        self.analytics_table.setHorizontalHeaderLabels(
            [
                "Product",
                "Brand",
                "Total",
                "%",
                "Purchases",
                "Cycle",
                "Frame Avg",
                "Comparison",
            ]
        )

        header = self.analytics_table.horizontalHeader()
        header.setSectionResizeMode(QHeaderView.Stretch)
        self.analytics_table.setAlternatingRowColors(True)
        self.analytics_table.setEditTriggers(QTableWidget.NoEditTriggers)

        layout.addWidget(self.analytics_table)

        return group

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

        self.load_store_filter()

        self.load_analytics()

    def load_store_filter(self):
        current_store_id = self.analytics_store_input.currentData()

        self.stores = self.service.get_stores()

        self.analytics_store_input.blockSignals(True)

        self.analytics_store_input.clear()

        self.analytics_store_input.addItem("All stores", None)

        for store in self.stores:
            self.analytics_store_input.addItem(
                f"{store.id} - {store.name}",
                store.id,
            )

        self.analytics_store_input.blockSignals(False)

        if current_store_id is not None:
            for index in range(self.analytics_store_input.count()):
                if self.analytics_store_input.itemData(index) == current_store_id:
                    self.analytics_store_input.setCurrentIndex(index)
                    break

    def load_analytics(self):
        result = self.service.get_history_analytics_view(
            start_date=self.analytics_start_input.text().strip() or None,
            end_date=self.analytics_end_input.text().strip() or None,
            store_id=self.analytics_store_input.currentData(),
        )

        self.analytics_summary_label.setText(
            self.analytics_summary_text(result)
        )

        self.analytics_table.setRowCount(0)

        for row_model in result.get("products", []):
            self.add_analytics_row(row_model)

    def analytics_summary_text(
        self,
        result: dict,
    ) -> str:
        frame_average = result.get("frame_average_timelapse_days")

        if frame_average is None:
            average_text = "-"
        else:
            average_text = f"{frame_average:.1f} days"

        return (
            f"Total: {self.money_text(result.get('total_spent'))} | "
            f"Parsed: {result.get('parsed_purchase_count', 0)} | "
            f"Unparsed: {result.get('unparsed_row_count', 0)} | "
            f"Excluded: {result.get('excluded_row_count', 0)} | "
            f"Average timelapse: {average_text}"
        )

    def add_analytics_row(
        self,
        row_model: dict,
    ):
        row = self.analytics_table.rowCount()

        self.analytics_table.insertRow(row)

        values = [
            row_model.get("product_name"),
            row_model.get("brand"),
            self.money_text(row_model.get("total_spent")),
            self.percent_text(row_model.get("expenditure_percentage")),
            row_model.get("purchase_count"),
            self.days_text(row_model.get("average_duration_days")),
            self.days_text(row_model.get("frame_average_timelapse_days")),
            row_model.get("cycle_comparison"),
        ]

        for column, value in enumerate(values):
            self.analytics_table.setItem(
                row,
                column,
                QTableWidgetItem(self.value(value)),
            )

    def value(self, value) -> str:

        if value is None or value == "":

            return "-"

        return str(value)

    def money_text(self, value) -> str:

        if value is None:

            return "-"

        return f"$ {value:.2f}"

    def percent_text(self, value) -> str:

        if value is None:

            return "-"

        return f"{value:.1f}%"

    def days_text(self, value) -> str:

        if value is None:

            return "-"

        if value == 1:

            return "1 day"

        return f"{value:g} days"

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
