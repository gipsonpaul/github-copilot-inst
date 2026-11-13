# Installation and first-run guide

## What this package contains

- **8 custom agents total:** one coordinator plus exactly seven specialist workers.
- **11 reusable skills** under `.github/skills/`.
- Always-on repository instructions in `.github/copilot-instructions.md`.
- Workspace sandbox settings and security setup guide.
- Root `migrate-target.json` and its JSON schema.
- Report templates and an empty `reports/generated/` destination.

## Install into your Java Maven repository

1. Back up the repository's existing `.github`, `.vscode`, `docs`, `reports`, `migrate-target.json` and `pom.xml`-adjacent configuration. Do not replace your existing project configuration blindly.
2. Extract this ZIP to a temporary folder.
3. Copy/merge the package's `.github/agents`, `.github/skills` and `.github/copilot-instructions.md` into your Java repository. Preserve unrelated agents, skills and instructions. If `.github/copilot-instructions.md` already exists, merge the guardrail sections rather than overwriting your instructions.
4. Merge `.vscode/settings.json` with existing settings. It enables sandboxing and disables broad developer-tool auto-access. Add only read-only JDK/Maven binary locations to User Settings as described in `SECURITY-AND-SETUP.md`.
5. Copy `docs/migrate-target.schema.json` to the `docs/` folder if it is not already present. Keep your existing `migrate-target.json` at the repository root beside the root `pom.xml`. If one already exists, compare and merge; do not overwrite it with this sample.
6. Merge `reports/templates/` and `reports/generated/README.md`. Do not overwrite existing reports. All new runtime-generated reports go under `reports/generated/`.
7. Add `.m2/repository/` to your existing `.gitignore` (see `SECURITY-AND-SETUP.md`). Do not replace your `.gitignore`.
8. Open the **repository root** in VS Code, not a parent folder containing unrelated repositories.

## Configure VS Code

1. Use a current VS Code stable release that supports Copilot custom agents, skills and subagents.
2. Sign in to GitHub Copilot and open Copilot Chat.
3. In the session target selector, select **Copilot**. Do not select Local, Claude or Codex for this package.
4. Select **Agent** mode.
5. Set permission level to **Manual permissions**. Keep tool and URL approvals enabled. Do not use Allow All, Autopilot, `/yolo`, `/autoApprove`, or global auto-approval.
6. Enable/verify Copilot agent sandboxing. Run `/sandbox policy` and ensure terminal write access is limited to the workspace. Decline outside-workspace file prompts.
7. Verify the `web` tool and Copilot subagent/task capability are available in the current session. Tool availability depends on VS Code version, model, Copilot plan and organization policy.
8. Run `Ctrl+Shift+P` → `Chat: Open Customizations`. In Agents, only **Java Modernization Coordinator** should be user-invocable from this package. In Skills, verify the eleven workspace skills are discovered.

## Verify agents and skills

Expected files in `.github/agents/`:

- `java-modernization-coordinator.agent.md` — visible in Agent picker.
- `java-springboot-migration.agent.md` — hidden worker.
- `snyk-fix.agent.md` — hidden worker.
- `unit-test-generator.agent.md` — hidden worker.
- `unit-test-implementation-execution.agent.md` — hidden worker.
- `pmd-check.agent.md` — hidden worker.
- `checkstyle-check.agent.md` — hidden worker.
- `reporter.agent.md` — hidden worker.

Worker agents use `user-invocable: false` and remain eligible for model invocation. The Coordinator is visible and is the only entry the user should select. Do not add an `agents:` field to these Copilot agent files: that named allow-list is Local-harness-specific. Copilot uses its native task delegation mechanism.

## First prompt — read-only discovery

Select **Java Modernization Coordinator** and enter:

> Start with read-only discovery. Read and validate `migrate-target.json`; identify the actual Java/Spring/Maven versions, Maven modules, dependency BOMs, test framework, and configured Snyk, PMD and Checkstyle tools. Use official web documentation to verify current target release and compatibility where applicable. Do not edit or create files and do not run scans/build commands. Return the findings and an exact proposed plan. Do not create reports until you ask me for report-write approval.

The coordinator should ask if it needs clarification and should not write any file at this stage.

## Approve one stage at a time

A good approval is explicit and bounded, for example:

> Approve stage MIG-01 only. You may edit `pom.xml`, `src/main/java/.../X.java`, and `src/test/java/.../XTest.java` for the listed Java/Spring migration findings only. You may run `mvn -Dmaven.repo.local=.m2/repository -B -ntp verify`. No other files or commands are approved.

Do not say only “go ahead” when the scope is unclear. If additional files/commands are needed, the coordinator must ask again.

To authorize reports separately, say:

> Approve creation of timestamped Markdown stage and final reports for this run under `reports/generated/` only. Do not overwrite existing reports.

## Useful prompts to the coordinator

- `Validate migrate-target.json and tell me whether the target is currently stable and supported. Read-only; use official sources.`
- `Assess Java and Spring Boot migration impact. Do not edit files.`
- `Review existing Snyk findings and propose minimal fixes. Do not edit or run snyk yet.`
- `Generate a unit test plan for the service layer. Do not create test files.`
- `Review existing PMD and Checkstyle reports. Do not change code or rulesets.`
- `Implement only the approved test cases and run the approved test command.`
- `Prepare the final report from completed stage results; ask before creating files.`

## Reports

Every generated report is saved under `reports/generated/`. Templates stay under `reports/templates/`. Recommended output includes discovery/target validation, web research, migration, Snyk, unit test, PMD, Checkstyle, Maven validation, and final summary reports. Reports use UTC timestamps and are never overwritten.

## Runtime smoke test

Before any real migration:

1. Confirm the coordinator appears in the picker.
2. Confirm workers do not appear as user-selectable agents.
3. Ask the coordinator to invoke one read-only worker and confirm a result comes back to the coordinator.
4. Ask for read-only documentation research and confirm real source URLs are returned.
5. Attempt an outside-workspace file read only as a security test; deny the request and confirm the coordinator stops.
6. Ask for a proposed edit, do not approve it, and confirm no file changes occur.
7. Approve a harmless, scoped report write and confirm the Reporter writes only under `reports/generated/`.
8. Verify a Maven `-version`/test command can run in the sandbox with the local repository path before approving any migration.

Do not use this package for a real production migration until these smoke tests pass in your actual VS Code environment.
