Done — I added the didactic report and glossary entries to GitHub.

Files written:

app/documentation/sketch_notebook/DEV_TRACK/02_DIDACTIC.md
app/documentation/sketch_notebook/07_GLOSSARY.md

What I recorded:

Python import resolution
Python first finds the module.
Then it looks for the requested name inside that module.
Module vs class/function export
repository.py being present does not automatically mean Repository exists.
Repository must be a top-level name inside repository.py.
Why from .repository import Repository fails
services.py imports Repository and instantiates it.
Current repository.py does not expose a top-level Repository class/name.
So this is a namespace/export problem, not simply a missing file problem.
KANBAN / glossary decision
KANBAN: yes, as a reusable debugging pattern.
Glossary: yes, because module, namespace, exported name, relative import, ImportError, and ModuleNotFoundError will recur.

Commits created:

Didactic note: bf57342065be8db280c9cf770d8f364a95651543
Glossary entries: 44dc3714f81c3668c0666e2196a1ddd3be7f9c36