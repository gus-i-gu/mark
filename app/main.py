import sys
import traceback
from datetime import datetime
from pathlib import Path

from PySide6.QtWidgets import QApplication, QMessageBox

from app.core.config import APP_NAME
from app.core.database import user_data_dir

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from app.desktop.main_window import MainWindow
else:
    from app.desktop.main_window import MainWindow


def diagnostic_log_path() -> Path:
    log_dir = user_data_dir() / "logs"
    log_dir.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    return log_dir / f"startup-{stamp}.log"


def write_startup_failure(error: BaseException) -> Path:
    path = diagnostic_log_path()
    path.write_text(
        "".join(traceback.format_exception(error)),
        encoding="utf-8",
    )
    return path


def show_startup_error(app: QApplication | None, log_path: Path) -> None:
    if app is None:
        return

    QMessageBox.critical(
        None,
        f"{APP_NAME} startup failed",
        (
            f"{APP_NAME} could not start.\n\n"
            "Your data was not reset or replaced.\n\n"
            f"Diagnostic log:\n{log_path}"
        ),
    )


def run_application() -> int:
    app = QApplication(sys.argv)

    window = MainWindow()

    window.show()

    return app.exec()


def main() -> int:
    app = QApplication.instance()

    try:
        return run_application()
    except Exception as error:
        try:
            log_path = write_startup_failure(error)
        except Exception:
            log_path = Path("<diagnostic log could not be written>")

        show_startup_error(app or QApplication.instance(), log_path)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
