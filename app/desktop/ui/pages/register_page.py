"""
Register Page

The Register page is the only writable page of Markei.

Users manually register purchases from a supermarket receipt.
"""

from PySide6.QtCore import QDate

from PySide6.QtWidgets import (
    QWidget,
    QLabel,
    QVBoxLayout,
    QHBoxLayout,
    QFormLayout,
    QLineEdit,
    QDoubleSpinBox,
    QDateEdit,
    QCheckBox,
    QPushButton,
    QMessageBox,
)

from app.core.services import ProductService


class RegisterPage(QWidget):

    ##################################################
    # Initialization
    ##################################################

    def __init__(self):

        super().__init__()

        self.service = ProductService()

        # Assigned later by MainWindow
        self.main_window = None

        # Product currently being edited
        self.current_product = None

        ##################################################
        # Main layout
        ##################################################

        main_layout = QVBoxLayout(self)

        title = QLabel("Register")
        title.setStyleSheet(
            "font-size:18px;font-weight:bold;"
        )

        subtitle = QLabel(
            "Register one product copied manually from a supermarket receipt."
        )

        main_layout.addWidget(title)
        main_layout.addWidget(subtitle)

        ##################################################
        # Form
        ##################################################

        form = QFormLayout()

        self.id_input = QLineEdit()

        self.category_input = QLineEdit()
        self.category_input.setText("F")

        self.product_input = QLineEdit()

        self.brand_input = QLineEdit()

        self.quantity_input = QDoubleSpinBox()
        self.quantity_input.setMaximum(999999)
        self.quantity_input.setDecimals(3)

        self.unit_input = QLineEdit()
        self.unit_input.setText("un")

        self.unit_price_input = QDoubleSpinBox()
        self.unit_price_input.setMaximum(999999)
        self.unit_price_input.setDecimals(2)
        self.unit_price_input.setPrefix("$ ")

        self.total_price_input = QDoubleSpinBox()
        self.total_price_input.setMaximum(999999)
        self.total_price_input.setDecimals(2)
        self.total_price_input.setPrefix("$ ")

        self.promotion_input = QCheckBox("Promotion")

        self.store_id_input = QLineEdit()
        self.store_id_input.setText("1")

        self.purchase_date_input = QDateEdit()
        self.purchase_date_input.setCalendarPopup(True)
        self.purchase_date_input.setDate(
            QDate.currentDate()
        )

        self.notes_input = QLineEdit()

        ##################################################
        # Form rows
        ##################################################

        form.addRow("ID", self.id_input)
        form.addRow("Category", self.category_input)
        form.addRow("Product", self.product_input)
        form.addRow("Brand", self.brand_input)
        form.addRow("Quantity", self.quantity_input)
        form.addRow("Unit", self.unit_input)
        form.addRow("Unit Price", self.unit_price_input)
        form.addRow("Total Price", self.total_price_input)
        form.addRow("", self.promotion_input)
        form.addRow("Store ID", self.store_id_input)
        form.addRow("Purchase Date", self.purchase_date_input)
        form.addRow("Notes", self.notes_input)

        main_layout.addLayout(form)

        ##################################################
        # Buttons
        ##################################################

        buttons = QHBoxLayout()

        self.add_button = QPushButton("Add")

        self.update_button = QPushButton("Update")

        self.delete_button = QPushButton("Delete")

        self.clear_button = QPushButton("Clear")

        buttons.addWidget(self.add_button)
        buttons.addWidget(self.update_button)
        buttons.addWidget(self.delete_button)
        buttons.addWidget(self.clear_button)

        main_layout.addLayout(buttons)

        ##################################################
        # Status
        ##################################################

        self.status_label = QLabel()

        main_layout.addWidget(
            self.status_label
        )

        main_layout.addStretch()

        ##################################################
        # Signal connections
        ##################################################

        self.add_button.clicked.connect(
            self.add_receipt
        )

        self.update_button.clicked.connect(
            self.update_product
        )

        self.delete_button.clicked.connect(
            self.delete_product
        )

        self.clear_button.clicked.connect(
            self.clear_form
        )

        ##################################################
        # Initial state
        ##################################################

        self.set_edit_mode(False)

            ##################################################
    # Edit mode
    ##################################################

    def set_edit_mode(
        self,
        editing: bool,
    ):
        """
        Enable/disable edit mode.
        """

        self.current_product = (
            self.current_product if editing else None
        )

        self.add_button.setEnabled(
            not editing
        )

        self.update_button.setEnabled(
            editing
        )

        self.delete_button.setEnabled(
            editing
        )

        if editing:
            self.status_label.setText(
                "Editing product"
            )
        else:
            self.status_label.setText(
                ""
            )


    ##################################################
    # Validation
    ##################################################

    def form_is_valid(
        self,
    ) -> bool:
        """
        Validate mandatory fields.
        """

        product_id = self.id_input.text().strip()

        if product_id == "":
            QMessageBox.warning(
                self,
                "Missing field",
                "Product ID is required."
            )
            return False

        if self.product_input.text().strip() == "":
            QMessageBox.warning(
                self,
                "Missing field",
                "Product name is required."
            )
            return False

        if self.category_input.text().strip() == "":
            QMessageBox.warning(
                self,
                "Missing field",
                "Category is required."
            )
            return False

        return True


    ##################################################
    # Helpers
    ##################################################

    def purchase_date_string(
        self,
    ) -> str:

        return (
            self.purchase_date_input
            .date()
            .toString(
                "dd/MM/yyyy"
            )
        )


    def promotion_value(
        self,
    ) -> int:

        return (
            1
            if self.promotion_input.isChecked()
            else 0
        )


    def store_id(
        self,
    ) -> int:

        text = (
            self.store_id_input.text().strip()
        )

        if text == "":
            return 1

        return int(text)


    ##################################################
    # Clear form
    ##################################################

    def clear_form(
        self,
    ):
        """
        Restore default state.
        """

        self.id_input.clear()

        self.category_input.setText(
            "F"
        )

        self.product_input.clear()

        self.brand_input.clear()

        self.quantity_input.setValue(
            0
        )

        self.unit_input.setText(
            "un"
        )

        self.unit_price_input.setValue(
            0
        )

        self.total_price_input.setValue(
            0
        )

        self.promotion_input.setChecked(
            False
        )

        self.store_id_input.setText(
            "1"
        )

        self.purchase_date_input.setDate(
            QDate.currentDate()
        )

        self.notes_input.clear()

        self.current_product = None

        self.set_edit_mode(
            False
        )


    ##################################################
    # Load product
    ##################################################

    def load_product(
        self,
        product,
    ):
        """
        Fill the form from an existing product.
        """

        self.current_product = product

        self.id_input.setText(
            product.id
        )

        self.category_input.setText(
            product.category_id
        )

        self.product_input.setText(
            product.product_name
        )

        self.brand_input.setText(
            product.brand or ""
        )

        self.quantity_input.setValue(
            product.current_quantity
        )

        self.unit_input.setText(
            product.unit
        )

        if product.current_unit_price is not None:
            self.unit_price_input.setValue(
                product.current_unit_price
            )

        self.notes_input.setText(
            product.notes or ""
        )

        if product.current_purchase_date:

            self.purchase_date_input.setDate(
                QDate.fromString(
                    product.current_purchase_date,
                    "dd/MM/yyyy",
                )
            )

        self.set_edit_mode(
            True
        )

            ##################################################
    # Read Form
    ##################################################

    def read_form(self):
        """
        Read every editable field and update the
        current Product object.
        """

        product = self.current_product

        if product is None:
            return None

        product.id = (
            self.id_input.text().strip()
        )

        product.category_id = (
            self.category_input.text().strip()
        )

        product.product_name = (
            self.product_input.text().strip()
        )

        product.brand = (
            self.brand_input.text().strip()
        )

        product.current_quantity = (
            self.quantity_input.value()
        )

        product.unit = (
            self.unit_input.text().strip()
        )

        product.current_unit_price = (
            self.unit_price_input.value()
        )

        product.notes = (
            self.notes_input.text().strip()
        )

        return product


    ##################################################
    # Add Receipt
    ##################################################

    def add_receipt(self):
        """
        Register a new purchase.
        """

        if not self.form_is_valid():
            return

        try:

            result = self.service.register_receipt(

                product_id=self.id_input.text().strip(),

                category_id=self.category_input.text().strip(),

                product_name=self.product_input.text().strip(),

                brand=self.brand_input.text().strip(),

                quantity=self.quantity_input.value(),

                unit=self.unit_input.text().strip(),

                purchase_date=self.purchase_date_string(),

                store_id=self.store_id(),

                unit_price=self.unit_price_input.value(),

                total_price=self.total_price_input.value(),

                promotion=self.promotion_value(),

                notes=self.notes_input.text().strip(),

            )

            purchase = result["purchase"]

            self.status_label.setText(
                f"Purchase #{purchase.id} registered."
            )

            QMessageBox.information(
                self,
                "Success",
                "Product registered successfully."
            )

            if self.main_window is not None:
                self.main_window.refresh_pages()

            self.clear_form()

        except Exception as error:

            QMessageBox.critical(
                self,
                "Registration failed",
                str(error),
            )


    ##################################################
    # Update Product
    ##################################################

    def update_product(self):
        """
        Persist product edition.
        """

        if self.current_product is None:
            return

        product = self.read_form()

        if product is None:
            return

        self.service.update_product(
            product
        )

        QMessageBox.information(
            self,
            "Updated",
            "Product updated successfully."
        )

        if self.main_window is not None:
            self.main_window.refresh_pages()

        self.clear_form()


    ##################################################
    # Delete Product
    ##################################################

    def delete_product(self):
        """
        Delete current product.
        """

        if self.current_product is None:
            return

        reply = QMessageBox.question(

            self,

            "Delete Product",

            f"Delete '{self.current_product.product_name}'?",

            QMessageBox.Yes | QMessageBox.No,

        )

        if reply != QMessageBox.Yes:
            return

        self.service.delete_product(
            self.current_product.id
        )

        QMessageBox.information(
            self,
            "Deleted",
            "Product deleted successfully."
        )

        if self.main_window is not None:
            self.main_window.refresh_pages()

        self.clear_form()

            ##################################################
    # Close Event
    ##################################################

    def closeEvent(
        self,
        event,
    ):
        """
        Close service resources when the page
        is destroyed.
        """

        try:

            self.service.close()

        except Exception:

            pass

        event.accept()


    ##################################################
    # Page Refresh
    ##################################################

    def refresh(self):
        """
        Placeholder for future refresh logic.

        Other pages expose a refresh() method, so
        RegisterPage keeps the same interface.
        """

        return


    ##################################################
    # Debug
    ##################################################

    def __repr__(self):

        mode = (
            "EDIT"
            if self.current_product
            else "ADD"
        )

        return (
            f"<RegisterPage mode={mode}>"
        )