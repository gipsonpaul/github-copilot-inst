---
name: test-engineering
description: Designs and implements maintainable Java unit and integration tests using the repository's existing testing conventions.
---

# Test engineering workflow

1. Inspect existing JUnit, Mockito, Spring Boot Test and coverage conventions before writing tests.
2. Map tests to production behavior and requirements.
3. Cover happy paths, boundaries, invalid inputs, exceptions, null/empty data and relevant regression cases.
4. Keep unit tests isolated and deterministic; avoid unnecessary Spring context startup.
5. Mock external systems at boundaries; do not mock the class under test.
6. Do not duplicate existing tests or assert implementation details unnecessarily.
7. Never weaken/delete tests to make the build pass.
8. Record test cases, files, commands and actual pass/fail results.
