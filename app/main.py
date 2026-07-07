"""
main.py

Application entry point.

Responsibilities
----------------
1. Create the Qt application.
2. Create the main window.
3. Display the main window.
4. Start the Qt event loop.
"""

import sys
from pathlib import Path

from PySide6.QtWidgets import QApplication

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from app.desktop.main_window import MainWindow
else:
    from app.desktop.main_window import MainWindow


def main():

    app = QApplication(sys.argv)

    window = MainWindow()

    window.show()

    sys.exit(app.exec())


if __name__ == "__main__":

    main()
