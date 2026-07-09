"""
Settings Page

Application configuration and store editing.
"""

from PySide6.QtWidgets import (
    QComboBox,
    QFormLayout,
    QGroupBox,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QMessageBox,
    QPushButton,
    QVBoxLayout,
    QWidget,
)

from app.core.services import ProductService


class SettingsPage(QWidget):

    def __init__(
        self,
        main_window=None,
    ):

        super().__init__()

        self.main_window = main_window

        self.service = ProductService()

        self.stores = []

        self.build_ui()

        self.load_settings()

        self.load_stores()

    def build_ui(self):

        layout = QVBoxLayout(self)

        title = QLabel("Settings")

        title.setStyleSheet(
            "font-size:20px;font-weight:bold;"
        )

        layout.addWidget(title)

        layout.addWidget(
            self.build_history_group()
        )

        layout.addWidget(
            self.build_store_group()
        )

        layout.addStretch()

    def build_history_group(self):

        group = QGroupBox("History")

        form = QFormLayout(group)

        self.week_boundary_input = QComboBox()

        self.week_boundary_input.addItem(
            "Wednesday",
            "wednesday",
        )

        self.month_boundary_input = QComboBox()

        self.month_boundary_input.addItem(
            "First Wednesday",
            "first_wednesday",
        )

        self.page_order_input = QLineEdit()

        self.save_settings_button = QPushButton(
            "Save History Settings"
        )

        self.save_settings_button.clicked.connect(
            self.save_history_settings
        )

        form.addRow(
            "Week Boundary",
            self.week_boundary_input,
        )

        form.addRow(
            "Month Boundary",
            self.month_boundary_input,
        )

        form.addRow(
            "Page Order",
            self.page_order_input,
        )

        form.addRow(
            "",
            self.save_settings_button,
        )

        return group

    def build_store_group(self):

        group = QGroupBox("Stores")

        layout = QVBoxLayout(group)

        selector_row = QHBoxLayout()

        self.store_selector = QComboBox()

        self.store_selector.currentIndexChanged.connect(
            self.load_selected_store
        )

        self.new_store_button = QPushButton("New")

        self.new_store_button.clicked.connect(
            self.clear_store_form
        )

        selector_row.addWidget(self.store_selector)

        selector_row.addWidget(self.new_store_button)

        layout.addLayout(selector_row)

        form = QFormLayout()

        self.store_id_input = QLineEdit()

        self.store_id_input.setReadOnly(True)

        self.store_name_input = QLineEdit()

        self.store_city_input = QLineEdit()

        self.store_state_input = QLineEdit()

        self.store_address_input = QLineEdit()

        self.save_store_button = QPushButton("Save Store")

        self.save_store_button.clicked.connect(
            self.save_store
        )

        form.addRow("ID", self.store_id_input)

        form.addRow("Name", self.store_name_input)

        form.addRow("City", self.store_city_input)

        form.addRow("State", self.store_state_input)

        form.addRow("Address", self.store_address_input)

        form.addRow("", self.save_store_button)

        layout.addLayout(form)

        return group

    def load_settings(self):

        settings = self.service.get_settings()

        self.set_combo_value(
            self.week_boundary_input,
            settings.get("history.week_boundary"),
        )

        self.set_combo_value(
            self.month_boundary_input,
            settings.get("history.month_boundary_rule"),
        )

        self.page_order_input.setText(
            settings.get(
                "pages.order",
                "Register,Storage,Shortage,Market,History,Settings",
            )
        )

    def load_stores(self):

        self.stores = self.service.get_stores()

        self.store_selector.blockSignals(True)

        self.store_selector.clear()

        self.store_selector.addItem(
            "New store",
            None,
        )

        for store in self.stores:

            self.store_selector.addItem(
                f"{store.id} - {store.name}",
                store.id,
            )

        self.store_selector.blockSignals(False)

        self.clear_store_form()

    def load_selected_store(self):

        store_id = self.store_selector.currentData()

        if store_id is None:

            self.clear_store_form()

            return

        store = next(
            (
                item
                for item in self.stores
                if item.id == store_id
            ),
            None,
        )

        if store is None:

            self.clear_store_form()

            return

        self.store_id_input.setText(str(store.id))

        self.store_name_input.setText(store.name or "")

        self.store_city_input.setText(store.city or "")

        self.store_state_input.setText(store.state or "")

        self.store_address_input.setText(store.address or "")

    def clear_store_form(self):

        self.store_selector.setCurrentIndex(0)

        self.store_id_input.clear()

        self.store_name_input.clear()

        self.store_city_input.clear()

        self.store_state_input.clear()

        self.store_address_input.clear()

    def save_history_settings(self):

        self.service.set_setting(
            "history.week_boundary",
            self.week_boundary_input.currentData(),
        )

        self.service.set_setting(
            "history.month_boundary_rule",
            self.month_boundary_input.currentData(),
        )

        self.service.set_setting(
            "pages.order",
            self.page_order_input.text().strip(),
        )

        self.refresh_dependents()

        QMessageBox.information(
            self,
            "Saved",
            "History settings saved.",
        )

    def save_store(self):

        store_id = None

        if self.store_id_input.text().strip():

            store_id = int(
                self.store_id_input.text().strip()
            )

        try:

            store = self.service.save_store(
                store_id=store_id,
                name=self.store_name_input.text(),
                city=self.store_city_input.text(),
                state=self.store_state_input.text(),
                address=self.store_address_input.text(),
            )

        except Exception as error:

            QMessageBox.critical(
                self,
                "Store save failed",
                str(error),
            )

            return

        self.load_stores()

        self.select_store(store.id)

        self.refresh_dependents()

        QMessageBox.information(
            self,
            "Saved",
            "Store saved.",
        )

    def refresh_dependents(self):

        if self.main_window is not None:

            self.main_window.refresh_pages()

    def select_store(
        self,
        store_id,
    ):

        for index in range(self.store_selector.count()):

            if self.store_selector.itemData(index) == store_id:

                self.store_selector.setCurrentIndex(index)

                return

    def set_combo_value(
        self,
        combo,
        value,
    ):

        for index in range(combo.count()):

            if combo.itemData(index) == value:

                combo.setCurrentIndex(index)

                return

    def refresh(self):

        self.load_settings()

        self.load_stores()

    def closeEvent(
        self,
        event,
    ):

        try:

            self.service.close()

        except Exception:

            pass

        event.accept()
