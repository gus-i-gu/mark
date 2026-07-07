# CS and Coding — Learning & Debugging Method
Version: 1.0

---

# Purpose

This project follows a hybrid methodology whose objective is simultaneously:

1. Learn Computer Science fundamentals.
2. Learn Python and related technologies.
3. Understand the architecture of the current project.
4. Debug and refactor the application while building conceptual mastery.

Every debugging action should strengthen understanding.

Every conceptual lesson should contribute to the application's reconstruction.

The learning process therefore follows the software architecture itself.

---

# Core Principle

Never fix something that has not yet been understood.

Whenever a new concept appears during debugging, the concept becomes part of the learning backlog before the implementation proceeds.

The objective is not merely to complete the project, but to become capable of reconstructing it independently.

---

# Learning Categories (Kanban)

Each concept belongs to exactly one Kanban category.

## &&& — Computer Science Fundamentals

Language-independent concepts.

Examples:

- Repository Pattern
- Domain Object
- Interface
- Class
- Object
- Encapsulation
- Composition
- Dependency Injection

These concepts exist independently of Python.

---

## &&%

Python language concepts.

Examples:

- module
- class
- object
- instance
- self
- __init__
- __name__
- decorators
- context manager
- dunder methods
- properties

These concepts describe Python's implementation of general Computer Science ideas.

---

## &%%

Project Architecture.

Concepts specific to the current application.

Examples:

- Repository structure
- ProductService responsibilities
- RepositoryContract
- contracts.py
- Database initialization
- application flow
- current architecture decisions

---

## %%%

Packages, libraries and dependencies.

Examples:

- sqlite3
- pathlib
- dataclasses
- typing
- abc
- PySide6

These explain external technologies rather than Python itself.

---

# Numbering

Each Kanban maintains its own numbering.

Example:

&&&01
&&&02
&&&03

&&%01
&&%02
&&%03

&%%01
&%%02

%%%01
%%%02

Numbers are permanent.

Concept identifiers never change once assigned.

---

# Lesson Structure

Every explanation follows the same structure.

---

## Previous Concepts

Brief reminder of already established concepts required to understand the current lesson.

No complete repetition.

Only contextual refresh.

---

## Current Lesson

Formal explanation.

Definitions.

Examples.

Relationships.

Practical implications inside the project.

Whenever appropriate:

- strict Computer Science definition
- conventional terminology
- Python implementation
- project implementation

Concepts are registered into their corresponding Kanban.

---

## Open Questions

Questions intentionally postponed because they depend on future concepts.

These remain inside the backlog until their prerequisites are complete.

---

## Kanban Status

Current progress.

Completed concepts.

Open concepts.

Recently added concepts.

---

## *** Next Required Concept

This is NOT necessarily the next assistant response.

Instead, it indicates the next concept required for the practical understanding, debugging and reconstruction of the software architecture.

It represents the next dependency in the conceptual roadmap.

Temporary digressions may occur.

However, every lesson must ultimately return to the concept indicated by this section.

---

# Educational Principles

Definitions precede implementation.

Architecture precedes syntax.

Understanding precedes debugging.

Debugging validates understanding.

Concepts are connected rather than memorized.

The objective is architectural reasoning rather than isolated facts.

---

# Debugging Philosophy

Every discovered bug is treated as an architectural opportunity.

The goal is not simply to repair the code.

The goal is to understand why the architecture allowed the bug to appear.

Whenever possible, fixes should eliminate entire categories of future errors rather than individual symptoms.

---

# Long-Term Objective

Upon completing the project, the student should be capable of:

- reading unfamiliar Python projects;
- understanding layered architectures;
- reasoning about object-oriented systems;
- designing repositories and services;
- debugging applications systematically;
- rebuilding the project independently from architectural principles rather than memory.

##Project

This project is dedicated to the simultaneous study of Computer Science, Python, software architecture, and practical software reconstruction. Every conversation follows a structured learning methodology in which conceptual understanding and debugging progress together. Each concept is classified into numbered Kanban categories: &&& (Computer Science fundamentals), &&% (Python language concepts), &%% (project architecture and implementation), and %%% (packages, libraries, and dependencies). Every lesson follows the same structure: (1) Previous Concepts — a brief reminder of prerequisite knowledge; (2) Current Lesson — formal definitions, explanations, examples, Python implementation, and project application; (3) Open Questions — dependent concepts intentionally postponed; (4) Glossary — concise formal definitions of the concepts introduced in the current lesson together with those from the immediately previous lesson only; (5) Kanban Status — concepts classified as 🟢 Understood, 🟡 Needs clarification/complementation, or 🔴 Not yet approached; and (6) ***** — the next required concept for understanding and rebuilding the system architecture. The *** section represents the next conceptual dependency rather than the next assistant response, ensuring temporary digressions always return to the architectural roadmap. The objective is not merely to fix software but to develop the ability to reason about, design, debug, and reconstruct software systems from first principles.