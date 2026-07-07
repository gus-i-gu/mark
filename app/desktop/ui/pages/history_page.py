"""
History Page
"""

from PySide6.QtWidgets import QWidget, QLabel, QVBoxLayout


class HistoryPage(QWidget):

    def __init__(self):

        super().__init__()

        layout = QVBoxLayout()

        layout.addWidget(
            QLabel("History")
        )

        self.setLayout(layout)