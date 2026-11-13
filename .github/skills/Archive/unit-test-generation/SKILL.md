---
name: unit-test-generation
description: Creates read-only unit-test plans, edge-case matrices and coverage mappings for Java/Spring code.
---

# Unit test generation and design

This skill is for analysis/design only; it does not create or edit test files.

## Procedure
1. Inspect existing source, tests, fixtures and test dependencies within the project root.
2. Identify actual JUnit, Mockito, AssertJ, Spring test and other versions; verify API details from official docs when needed.
3. For each class/method, list happy paths, boundaries, invalid/null input, exceptions, security cases and important regression behavior.
4. Map tests to branches/conditions and configured line/branch coverage targets. Do not promise exact coverage without running the coverage tool.
5. Recommend unit vs Spring slice vs integration tests and explain trade-offs. Prefer deterministic tests; mock external boundaries only.
6. Propose test class/method names, fixtures, stubs/mocks, assertions and expected behavior.
7. Return plan to coordinator. Only the separate Unit Test Implementation and Execution Agent may write approved test files.

## Output
Test matrix; source method; scenario; test type; expected assertion; mocks/fixtures; coverage mapping; priority; proposed test file; evidence.
