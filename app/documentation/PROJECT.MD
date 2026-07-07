# Markei

Markei is a manual receipt manager.

Instead of tracking products automatically, the user manually registers purchases from supermarket receipts.

From this purchase history, Markei estimates when products will likely need replenishment and organizes them into Storage, Shortage and Market views.

The application intentionally avoids price scraping, barcode scanning and external APIs during Phase 1.

The user is the source of truth.

###v0.2

Markei stores every purchase as immutable history.

Products are summaries generated from that history, containing
current stock information, purchase prediction and replenishment status.

The application follows a purchase lifecycle instead of a simple CRUD model.