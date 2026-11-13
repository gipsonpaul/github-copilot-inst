---
name: maven-validation
description: Selects and runs appropriate Maven wrapper/build/test/quality commands and records evidence accurately.
---

# Maven validation workflow

1. Detect OS and whether Maven Wrapper exists.
2. Windows: use `mvnw.cmd`; Unix: use `./mvnw`; otherwise use installed `mvn`.
3. Inspect `pom.xml` profiles and plugin configuration before selecting PMD, Checkstyle, Snyk, test or build goals.
4. Start with the narrowest relevant goal, then run broader validation required by the task.
5. Do not invent plugin goals, profiles or flags. Verify them from project configuration or official plugin documentation.
6. Capture exact command, exit code and relevant output.
7. Separate compilation errors, test failures, plugin/configuration failures and environment failures.
8. Never report success without observed successful command completion.
