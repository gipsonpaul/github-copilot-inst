# Static validation

Validation performed when this archive was generated:

- Exactly 8 custom agent files: 1 coordinator and 7 specialist workers.
- Exactly one `user-invocable: true` agent; all seven workers are `user-invocable: false` and `disable-model-invocation: false`.
- Every agent explicitly targets `github-copilot`.
- No Local-only `agents:` allow-list or `runSubagent` tool is configured in Copilot frontmatter; explanatory warnings may mention the Local-only mechanism.
- All agent skill references resolve to a matching `.github/skills/<name>/SKILL.md`.
- Every skill folder name matches its `SKILL.md` frontmatter `name`.
- `migrate-target.json` and its JSON Schema parse successfully.
- Report templates exist under `reports/templates/`; generated report destination exists under `reports/generated/`.
- `.vscode/settings.json` is valid JSONC syntax (comments permitted).

Not verified here: live Copilot tool discovery, subagent selection, web access, manual approval dialogs, sandbox enforcement on your OS, actual Maven build, Snyk, PMD, Checkstyle or unit-test execution. These require your VS Code runtime and repository; follow `docs/INSTALLATION.md`.
