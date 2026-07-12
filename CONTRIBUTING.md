# Contributing to Markei

Thank you for considering a contribution.

Markei is developed through a documented cycle-and-sprint methodology. Before changing code or permanent documentation, identify the active branch, current cycle, authorized scope, and evidence requirements in the Sketch Notebook.

## Before opening work

1. Read `AGENTS.md`.
2. Read `documentation/sketch_notebook/INDEX.md`.
3. Recover the current state from `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md`.
4. Confirm the required branch and the domain that owns the proposed change.
5. Search existing issues and pull requests for related work.

Do not assume the repository default branch is the active development branch.

## Good contributions

A useful contribution is:

- small enough to review coherently;
- explicit about the problem it solves;
- consistent with the current architecture and privacy boundaries;
- accompanied by validation evidence;
- free of unrelated refactors;
- documented when it changes an accepted behavior or model.

## Issues

Use issues for reproducible defects, bounded proposals, documentation gaps, or questions that need a durable project record. Include the affected version or commit, environment, reproduction steps, expected behavior, actual behavior, and relevant logs without private household data.

## Pull requests

A pull request should explain:

- the problem and authorized scope;
- the exact files and behaviors changed;
- tests or validation commands performed;
- remaining risks or unvalidated assumptions;
- documentation updated, when applicable.

Keep generated binaries, databases, credentials, private receipts, and personal household data out of commits unless the repository explicitly documents an approved fixture or artifact policy.

## Privacy

Never submit real household purchase histories, addresses, account credentials, partner secrets, or personally identifying datasets. Use synthetic fixtures for tests and examples.

## Security

Do not open a public issue for a suspected vulnerability that could expose data or enable misuse. Follow `SECURITY.md`.

## License status

The repository does not yet declare an open-source license. A contribution does not by itself change that status. Licensing terms should be resolved before accepting substantial external code contributions.
