# Architecture — eight custom agents, reusable skills

## Agents

| Agent | Picker visibility | Role | Editing |
|---|---|---|---|
| Java Modernization Coordinator | Visible | Sole user-facing orchestrator; delegates, asks approvals, reconciles results, requests reports | Only approved report/orchestration writes, never source without approval |
| Java and Spring Boot Migration Agent | Hidden | Java + Spring Boot + Spring Cloud/Azure + Maven POM/dependency/BOM migration | Approved paths only |
| Snyk Fix Agent | Hidden | Snyk vulnerability review and approved targeted fixes | Approved paths only |
| Unit Test Generator Agent | Hidden | Read-only test discovery/design and coverage mapping | No |
| Unit Test Implementation and Execution Agent | Hidden | Approved test-only implementation and test execution | Approved test paths only |
| PMD Check Agent | Hidden | PMD setup/findings and approved read-only scan | No |
| Checkstyle Check Agent | Hidden | Checkstyle setup/findings and approved read-only scan | No |
| Reporter Agent | Hidden | Creates timestamped reports under `reports/generated/` | Reports directory only, after report-write approval |

## Delegation in the Copilot harness

This repository targets **GitHub Copilot in VS Code**. All agent files use `target: github-copilot`. Workers set `user-invocable: false` so they do not clutter the agent picker, and `disable-model-invocation: false` so Copilot may use them as subagents.

Copilot harness delegation is native and uses its `task` mechanism. The Local harness has different `agents:` allow-list and `runSubagent` behavior; those Local-only fields are deliberately not included. The coordinator instructions name the exact worker profiles. The Coordinator is the only user-invocable agent.

The coordinator's tools list uses the Copilot-supported `agent` capability together with read/search/edit/execute/web. The exact runtime tool inventory can vary by VS Code version, model, Copilot plan and organization policy; verify the task and web capabilities in the actual Copilot session before relying on them.

## Skills

Skills provide reusable procedural knowledge, not extra agents. They are under `.github/skills/<skill-name>/SKILL.md` and are available for slash-command invocation and automatic loading when relevant. The coordinator and workers declare the relevant skill names in their frontmatter.

## Workflow

1. Read-only discovery and target validation.
2. Official web research and read-only specialist analysis.
3. Coordinator consolidates a plan with exact file scope and commands.
4. Explicit user approval for each implementation stage and report write.
5. One approved specialist stage at a time.
6. Focused validation then the approved Maven gate.
7. Stop on failure; no unapproved repair.
8. Reporter writes approved stage and final reports under `reports/generated/`.

## Communication

User questions, approvals, progress summaries and final summaries go through the coordinator. Worker agents return structured result payloads to the coordinator. VS Code may still display subagent task activity/progress in its UI.
