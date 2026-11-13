---
name: unit-test-implementation-execution
description: Implements approved unit-test-only changes and executes the approved test suite with measured results.
---

# Unit test implementation and execution

## Preconditions
The coordinator task must contain `USER_APPROVAL: GRANTED`, an approved stage ID and an exact list of test files that may be created/changed. Without all three, remain read-only.

## Procedure
1. Read the approved test design and existing test conventions.
2. Write only test files in the approved list. Do not modify production source, POMs or test configuration unless separately approved.
3. Keep tests isolated and deterministic; avoid real external calls unless approved as integration tests.
4. Use web research for version-specific APIs and test framework compatibility.
5. Ask coordinator approval before running any Maven test/build command; do not assume approval to edit includes command approval.
6. Use installed `mvn` from repository root and `-Dmaven.repo.local=.m2/repository`. Avoid Maven Wrapper by default.
7. Run the exact approved targeted tests, then the approved Maven gate. Stop on failure.
8. Report exact commands, exit codes, test run/pass/fail/skip, coverage and artifact paths. Never invent results.

## Output
Test files changed; exact scenarios implemented; commands; exit codes; counts; coverage; failing test details; remaining test gaps.
