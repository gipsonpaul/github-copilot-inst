---
name: command-discovery
description: Discovers repository-specific Maven, Snyk, PMD, Checkstyle and test commands before executing validation.
---

# Command discovery and validation

1. Inspect the repository root, module layout, Maven Wrapper, POMs, profiles, plugin executions and CI workflow files.
2. Determine the working directory and module for the requested task.
3. Prefer Maven Wrapper when present; otherwise use installed Maven.
4. Select a focused command first, then the appropriate broader verification command.
5. Confirm PMD and Checkstyle plugin configuration before invoking their goals.
6. Confirm Snyk CLI availability, authentication and project-specific arguments before scanning.
7. Do not run upload/monitor/deploy/publish commands unless explicitly requested or required by established project policy.
8. Capture exact command, working directory, exit code and meaningful output.
9. If no valid command can be established, do not guess: report BLOCKED or NOT_RUN with the missing prerequisite.
