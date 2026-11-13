---
name: repository-discovery
description: Inventories a Maven repository, modules, runtimes, dependencies, plugins, tests and existing quality/security reports without modifying files.
---

# Repository discovery

## Procedure
1. Confirm project root contains `pom.xml` and `migrate-target.json`.
2. Inventory module POMs, parent/BOMs, profiles, properties, Java/compiler/toolchain settings, Maven plugins, dependencies, annotation processors, test frameworks, coverage plugins, Snyk, PMD and Checkstyle setup.
3. Check whether Maven Wrapper exists but do not run it by default.
4. Use only repository-local `java`/Maven configuration and existing tracked files. Do not read home/global settings.
5. Locate existing reports inside the repository. Record source revision and report timestamps where available; do not assume freshness.
6. Do not run scans/builds during discovery unless the coordinator has approval for an exact command. Do not edit files.

## Output
Repository/module map; detected source Java and Boot versions with evidence; Spring Cloud/Azure/Kafka versions; BOM/dependency-management map; plugins; test and coverage tools; existing Snyk/PMD/Checkstyle reports and freshness; gaps; recommended next action.
