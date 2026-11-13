# Security and workspace-boundary setup

This package is designed to keep agent work inside the open Java project. Agent instructions alone are not a security boundary; configure VS Code controls as well.

## 1. Copilot session settings

- Select **Session Target: Copilot**, not Local, Claude or Codex.
- Select **Agent** mode and **Manual permissions**.
- Do not use **Allow all**, **Autopilot**, `/yolo`, `/autoApprove`, or global tool auto-approval for this workflow.
- Review every file, terminal and URL approval dialog. Do not approve a path outside the project root.
- Do not attach files/folders from outside the open workspace.

## 2. Sandbox

The included `.vscode/settings.json` sets `chat.agent.sandbox.enabled` to `on` and sets `chat.agent.sandbox.fileSystem.allowDevToolAccess` to `false`. This is intentionally restrictive. On supported platforms it constrains terminal commands and child processes to the current workspace plus explicitly configured paths. Built-in editor tools have their own permission checks; continue to use Manual permissions and decline outside-workspace file access.

Because developer-tool access is disabled, add only the absolute **read-only** paths for the installed JDK and Maven directories to VS Code **User Settings** by merging `docs/vscode-user-settings-template.jsonc`. Do not add your home folder, full drive, `.ssh`, downloads, or broad system directories. If Maven/JDK cannot run, check `/sandbox policy` and add the narrow tool installation directory only.

The sandbox feature's platform availability and behavior depend on your installed VS Code version/OS. Check the current VS Code sandbox documentation. If sandboxing is not available on your host, do not claim a hard filesystem boundary; use a Dev Container that mounts only the target repository, or pause the workflow until an enforceable boundary is available.

## 3. Maven without writing outside the project

Use the installed `mvn` executable and pass `-Dmaven.repo.local=.m2/repository` to keep downloaded Maven artifacts inside the project. Add this to your project `.gitignore` (do not overwrite your existing file):

```gitignore
# Workspace-local Maven repository used by the Copilot sandbox
.m2/repository/
```

Do not run `mvnw`/`mvnw.cmd` by default. Maven Wrapper commonly downloads and caches its Maven distribution under the user profile, outside the workspace. If the wrapper is the only available Maven option, the coordinator must explain this and ask before using it; the strict workspace-only default is to stop.

Do not read user-level Maven settings. If the build depends on a corporate mirror/proxy, add a workspace-local, approved Maven settings file and configure the exact command to use it. Never put credentials in reports or commit secrets. Maven may invoke project build plugins; approve exact commands and inspect their configuration first.

## 4. File editing approval

The coordinator must first provide an exact stage plan and ask for approval. A stage approval includes only the paths and actions listed. If another file is needed, stop and request new approval. File editing must never start merely because a user asked for analysis or because a worker recommends a change.

Report files are also file writes. Before a run that creates persistent reports, the coordinator must obtain report-write approval for timestamped Markdown files under `reports/generated/`. The reporter cannot write any other location.

## 5. Web research

The `web` tool is separate from shell network access. The custom agents request web capability, but the current Copilot session must actually expose it. URL/domain approval may still be required. Prefer official product documentation and decline unrelated domains. If web is not present, report the gap instead of pretending to search.

## 6. Important limitation

No agent Markdown file can guarantee that an agent obeys every instruction. The supported security controls are the VS Code permission model, sandbox, tool approval and (where necessary) a Dev Container/OS-level isolation. Review actual tool activity and `/sandbox policy` during initial validation.
