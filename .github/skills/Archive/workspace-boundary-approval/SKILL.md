---
name: workspace-boundary-approval
description: Enforces the project-root boundary, approval-before-editing process, and safe command policy for all modernization tasks.
---

# Workspace boundary and explicit approval

## Use when
Every repository task, before reading or modifying files, executing commands, or asking a worker to act.

## Rules
1. Work only in the one open project root containing both `pom.xml` and `migrate-target.json`.
2. Verify every local path resolves inside that root. Reject parent traversal, outside absolute paths, external symlink/junction targets and other workspace roots.
3. Never inspect home folders, desktop/downloads, other repositories, global/user settings or external local files. Do not read outside-workspace attachments excepts ".m2" and ".mvn".
4. Run commands from project root and restrict command inputs/outputs to workspace paths. Maven uses `-Dmaven.repo.local=.m2/repository`.
5. Do not run `mvnw` by default because it may cache its Maven distribution in the user home. Ask before any outside-workspace exception.
6. Analysis is read-only. Before edits, coordinator must obtain explicit user approval for stage ID, exact paths, changes and commands.
7. Worker task must contain `USER_APPROVAL: GRANTED` and the exact approved path list. Otherwise do not edit.
8. Reporter can create new timestamped reports only below `reports/generated/` after `REPORT_WRITE_APPROVAL: GRANTED`; never overwrite.
9. Do not use Allow All, Autopilot, `/yolo`, global auto-approval or credentials in outputs.

## Output
State which root was used, confirm path scope, approval state, and any blocked access. Never claim sandbox enforcement from instructions alone; confirm VS Code sandbox/permissions separately.
