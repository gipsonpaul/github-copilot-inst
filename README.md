# Java Modernization Copilot — Coordinator Edition

A smaller, controlled GitHub Copilot agent system for Java and Spring Boot modernization in VS Code.

**8 agents total. One visible coordinator. Seven hidden specialist workers. Reusable skills. Explicit editing approval. Workspace-only file scope. Official web research. Structured reports.**

## What is in this package

| Component | Count | Purpose |
|---|---:|---|
| Custom agents | 8 | Coordinator + exactly seven requested workers |
| Reusable skills | 11 | Repeatable discovery, migration, Snyk, testing, PMD, Checkstyle, build, research and reporting workflows |
| Always-on instructions | 1 | Workspace safety, approval, web research and communication rules |
| Report templates | 6 | Stage, research, security, test, quality, target validation and final report formats |

## Agent roster

| Agent | Picker | Responsibility |
|---|---|---|
| **Java Modernization Coordinator** | Visible | Sole user-facing agent. Plans, delegates, researches, requests approval, validates scope, coordinates reports and summarizes results. |
| Java and Spring Boot Migration Agent | Hidden | Java + Spring Boot + Spring Cloud/Azure + Maven POM/dependency/BOM migration in one worker. |
| Snyk Fix Agent | Hidden | Security findings, advisory research and approved minimal fixes. |
| Unit Test Generator Agent | Hidden | Read-only test discovery, test case design and coverage-gap matrix. |
| Unit Test Implementation and Execution Agent | Hidden | Implements approved tests only, runs approved test commands and returns counts/coverage. |
| PMD Check Agent | Hidden | PMD setup, existing report review and approved read-only PMD checks. |
| Checkstyle Check Agent | Hidden | Checkstyle setup, existing report review and approved read-only Checkstyle checks. |
| Reporter Agent | Hidden | Writes approved timestamped Markdown reports under `reports/generated/` only. |

**All user communication flows through the coordinator.** Workers return structured results to the coordinator; they do not ask the user questions or independently present a final answer. VS Code may still display subagent activity/progress in its UI.

## Copilot-specific delegation — important

This package targets the **Copilot harness** in VS Code (`target: github-copilot`). The coordinator uses Copilot's native subagent/task delegation capability. The Local harness has a different `runSubagent` tool and a Local-only `agents:` allow-list; those are not included here. `tools: ['agent']` is the Copilot-supported capability alias in the coordinator profile; Copilot's runtime manages the actual native task call.

Worker agent profiles set:

```yaml
user-invocable: false
disable-model-invocation: false
```

This hides workers from the picker but keeps them eligible for invocation by another agent. The coordinator remains `user-invocable: true` and is the only agent to select directly. The native `task` tool and subagent runtime must be available in your selected Copilot session.

## Workflow

1. **Read-only discovery:** identify repository modules, root POM, actual Java/Spring versions, BOMs, plugins, tests and existing Snyk/PMD/Checkstyle reports.
2. **Target validation:** validate root `migrate-target.json`; check target stable/preview status and official Java/Spring/Cloud/Azure compatibility.
3. **Analysis:** delegate read-only research and specialist analysis; report stable finding IDs and evidence.
4. **Approval:** coordinator presents exact stage ID, file list, changes, commands and side effects. No edits before explicit user approval.
5. **Implementation:** delegate only the approved paths/findings to the relevant specialist.
6. **Verification:** run the approved focused check, then the approved Maven gate immediately. Stop on failure.
7. **Reporting:** coordinator sends results to Reporter. After report-write approval, Reporter writes timestamped reports under `reports/generated/`.
8. **Final:** coordinator returns the consolidated result, blockers and next decision.

## Reusable skills

1. `workspace-boundary-approval` — project-root confinement and explicit approval rules.
2. `repository-discovery` — Maven module, dependency, plugin, test and quality-tool inventory.
3. `web-documentation-research` — official versioned documentation, compatibility matrices and advisories.
4. `java-springboot-migration` — Java, Spring Boot/Cloud/Azure, POM, dependency and BOM migration.
5. `snyk-remediation` — vulnerability triage, minimal fixes and re-scan evidence.
6. `unit-test-generation` — read-only test design and coverage mapping.
7. `unit-test-implementation-execution` — approved test-only changes and test execution.
8. `pmd-analysis` — PMD configuration/findings and approved scans.
9. `checkstyle-analysis` — Checkstyle configuration/findings and approved scans.
10. `maven-build-validation` — safe commands, stage gate and exit-code evidence.
11. `structured-reporting` — traceable stage/research/security/test/final reports.

Skills are stored in `.github/skills/<skill-name>/SKILL.md`. Their folder names match their `name` frontmatter and they can be loaded automatically when relevant or invoked with `/` in Copilot Chat when discovered.

## Workspace layout

```text
java-project/
├── pom.xml
├── migrate-target.json
├── docs/
│   ├── migrate-target.schema.json
│   ├── ARCHITECTURE.md
│   ├── INSTALLATION.md
│   ├── SECURITY-AND-SETUP.md
│   └── vscode-user-settings-template.jsonc
├── .vscode/
│   └── settings.json
├── .github/
│   ├── copilot-instructions.md
│   ├── agents/                 # 8 agent profiles
│   └── skills/                 # 11 reusable skills
└── reports/
    ├── generated/               # every runtime-generated report goes here
    └── templates/               # static report templates
```

The included `migrate-target.json` retains the sample values supplied for this package: Java 17 → 25 and Spring Boot 3.x → 4.2.0, with preview releases disabled. Keep your actual file in the repository root beside `pom.xml`. The coordinator must validate the file and recheck release/compatibility status at execution time; a configured target is not proof that it is released or supported.

## Security defaults

- The open project root containing `pom.xml` and `migrate-target.json` is the only permitted data boundary.
- `.vscode/settings.json` turns Copilot agent sandboxing on and disables broad developer-tool auto-access. Add only read-only JDK/Maven installation directories in User Settings as described in `docs/SECURITY-AND-SETUP.md`.
- Use Manual permissions. Decline outside-workspace file reads/edits. Do not attach external folders.
- Maven uses `-Dmaven.repo.local=.m2/repository`; add `.m2/repository/` to `.gitignore`.
- Maven Wrapper is not used by default because it can cache a distribution under the user's home folder. Use an installed Maven executable.
- Agent text is not a hard security boundary; verify sandbox policy and actual tool behavior in VS Code. If sandboxing is unavailable on your host, use a Dev Container mounting only the repository before running this pipeline.
- File changes require user approval for the exact stage and paths. Report writes also require a report-write approval and are restricted to `reports/generated/`.

See `docs/SECURITY-AND-SETUP.md` before running the workflow.

## Web research

Every specialist has the `web` capability; the Reporter is focused on documenting supplied evidence and does not perform new research. Use official sources for Java, Spring Boot, Spring Cloud, Spring Cloud Azure, Kafka/Spring Kafka/Confluent, Maven, Snyk, PMD, Checkstyle, JUnit and Mockito when current facts affect a decision. Record source URLs and dates. If the Copilot session does not expose a web tool, agents must report that limitation and must not pretend to have searched.

## Report policy

Every runtime-generated report belongs under `reports/generated/`. Static Markdown templates stay under `reports/templates/`. Use UTC timestamped filenames; never overwrite. The Reporter Agent is the only worker authorized to persist reports, and only within the generated folder after the coordinator has approval.

## Install and use

Follow `docs/INSTALLATION.md` for merge/copy instructions, Copilot harness selection, smoke tests and sample prompts. Do not extract this ZIP over an existing repository without first backing up/merging its `.github` and `.vscode` customizations.

## Validation status

This package is statically validated for JSON/schema syntax, YAML frontmatter, agent count, agent names, skill references and workspace/report paths. It has not been run inside your VS Code instance, against your Copilot subscription/model, or against your Maven project. Complete the runtime smoke tests in `docs/INSTALLATION.md` before allowing real edits.
