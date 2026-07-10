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
    QSpinBox,
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

        for label, value in self.weekday_options():

            self.week_boundary_input.addItem(

                label,

                value,

            )

        self.month_boundary_mode_input = QComboBox()

        self.month_boundary_mode_input.addItem(

            "First selected weekday",

            "first_weekday",

        )

        self.month_boundary_mode_input.addItem(

            "Day of month",

            "day_of_month",

        )

        self.month_boundary_mode_input.currentIndexChanged.connect(

            self.update_month_controls

        )

        self.month_boundary_weekday_input = QComboBox()

        for label, value in self.weekday_options():

            self.month_boundary_weekday_input.addItem(

                label,

                value,

            )

        self.month_boundary_day_input = QSpinBox()

        self.month_boundary_day_input.setRange(1, 28)

        self.time_reference_input = QLineEdit()

        self.time_reference_input.setPlaceholderText("00:00")

        self.time_reference_input.setInputMask("00:00")

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
            "Month Boundary Mode",
            self.month_boundary_mode_input,
        )

        form.addRow(
            "Month Boundary Weekday",
            self.month_boundary_weekday_input,
        )

        form.addRow(
            "Month Boundary Day",
            self.month_boundary_day_input,
        )

        form.addRow(
            "Day Boundary Time",
            self.time_reference_input,
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
            self.month_boundary_mode_input,
            settings.get("history.month_boundary_mode"),
        )

        self.set_combo_value(
            self.month_boundary_weekday_input,
            settings.get(
                "history.month_boundary_weekday"
            ),
        )

        self.month_boundary_day_input.setValue(
            int(settings.get("history.month_boundary_day", "1"))
        )

        self.time_reference_input.setText(
            settings.get("time_reference.day_boundary_time", "00:00")
        )

        self.update_month_controls()

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

        try:

            self.service.save_history_settings(
                {
                    "history.week_boundary": (
                        self.week_boundary_input.currentData()
                    ),
                    "history.month_boundary_mode": (
                        self.month_boundary_mode_input.currentData()
                    ),
                    "history.month_boundary_weekday": (
                        self.month_boundary_weekday_input.currentData()
                    ),
                    "history.month_boundary_day": str(
                        self.month_boundary_day_input.value()
                    ),
                    "time_reference.day_boundary_time": (
                        self.time_reference_input.text()
                    ),
                }
            )

        except Exception as error:

            QMessageBox.critical(
                self,
                "Settings save failed",
                str(error),
            )

            return

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

    def weekday_options(self):

        return (
            ("Monday", "monday"),
            ("Tuesday", "tuesday"),
            ("Wednesday", "wednesday"),
            ("Thursday", "thursday"),
            ("Friday", "friday"),
            ("Saturday", "saturday"),
            ("Sunday", "sunday"),
        )

    def update_month_controls(self):

        mode = self.month_boundary_mode_input.currentData()

        self.month_boundary_weekday_input.setEnabled(

            mode == "first_weekday"

        )

        self.month_boundary_day_input.setEnabled(

            mode == "day_of_month"

        )

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
