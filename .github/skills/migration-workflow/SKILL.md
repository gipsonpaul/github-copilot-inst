---
name: migration-workflow
description: Safely analyse and execute Java and Spring Boot version migrations using migration-target.json, compatibility checks and staged Maven validation.
---

# Java/Spring Boot migration workflow

1. Read `migration-target.json` and validate required source/target values.
2. Inspect `pom.xml`, wrapper, Java compiler/toolchain, Boot parent/BOM, Cloud BOM, dependency management, plugins, annotation processors, tests and CI references in the repository.
3. Establish a baseline build where practical; record pre-existing failures.
4. Check official Java and Spring migration/release documentation for target compatibility.
5. Build a dependency/API compatibility plan before edits.
6. Never use "<classifier>" tag in dependencies.
7. Apply minimal changes in dependency order.
8. Run Maven compile, tests and package/install validation as appropriate.
9. Diagnose failures; do not suppress tests or lower quality/security gates.
10. Report every changed file and unresolved compatibility issue.
