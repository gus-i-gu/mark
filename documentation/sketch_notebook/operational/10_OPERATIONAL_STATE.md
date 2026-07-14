# 10_OPERATIONAL_STATE.md

> Version: Cycle 09 Sprint 02 post-promotion checkpoint
> Implementation: `1d817972aea0229c9f109f236f4d224671927aab`
> Status: Active Operational checkpoint

# Current State

Implemented: schema v4; Account-scoped immutable Person `@001...` and Payment Method `#001...`; optional references; mandatory immutable Product codes; manual Purchase occurrence; exact code autofill; same-unit BULK read-only total; Catalogue selection/details; History select-all/detail access; narrow Lists language repair; SDK-first theme/components and compact navigation.

Validated within named inherited scope: migration tests 3, repository tests 6, application focused tests 5, app widgets 7, full Flutter suite 43, clean analysis, protected Python tests 5, Windows release build and bounded hidden launch. No application command was rerun during promotion.

Open: theme/components are not consistently consumed; visual convergence is not delivered; Lists lacks full target composition; History double-click focuses detail rather than toggling selection; native sharing is absent and PDF/export remains fallback; manual Windows workflow and manual keyboard/accessibility/screen-reader checks remain open; Purchase (~1,020 lines), Catalogue (~377) and History (~330) require extraction.

Host-unvalidated: Android because Java was unavailable; compact-device lifecycle, physical devices, iOS, signing, distribution and native sharing. Android is not product-failed. Windows build/smoke is not manual acceptance.

Next: Main reconciles domain promotions, then authorizes a dedicated visual-convergence and modularization unit with desktop/compact screenshots plus manual Windows/accessibility evidence.

Recovery: read `04_TODO.md`, latest `11_OPERATIONAL_RECORD.md`, then Sprint 02 rules in `12_OPERATIONAL_MODEL.md`.
