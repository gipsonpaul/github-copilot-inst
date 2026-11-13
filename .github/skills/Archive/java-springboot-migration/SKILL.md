---
name: java-springboot-migration
description: Plans and applies approved Java, Spring Boot, Spring Cloud, Spring Cloud Azure and Maven dependency/BOM migration changes.
---

# Java and Spring Boot migration

## Procedure
1. Read root `migrate-target.json` and its schema. Compare config with actual repository state.
2. Verify target release status at execution time. Block preview/RC/milestone/snapshot when `allowPrerelease=false`.
3. Use official compatibility evidence for Java, Boot, Spring Cloud and Spring Cloud Azure. Respect all policy flags, especially BOM alignment and unsupported compatibility stop.
4. Inventory Maven parent, dependencyManagement, BOM imports, direct/transitive dependencies, plugin versions, annotation processors, compiler/surefire/failsafe plugins and test libraries.
5. Create a supported-version matrix before changes. Never assume latest means compatible. Prefer Boot/Cloud BOM alignment; explain any required override.
6. Identify breaking changes, removed APIs, package migrations (e.g. framework namespace transitions where applicable), configuration changes and source impacts from official migration guides.
7. Return exact change plan, file list, reasons, evidence, command and risks. No edits until coordinator approval is explicit.
8. Edit only paths listed in `USER_APPROVAL: GRANTED`. Preserve scope. Do not change CI/container/cloud/runtime artifacts unless explicitly approved.
9. Run only approved focused checks followed immediately by the approved Maven gate. Stop on failure.

## Output
Compatibility matrix; version decisions; POM/BOM/dependency changes; API/source impacts; approved files changed; evidence URLs/dates; exact commands and exit codes; unresolved risks.
