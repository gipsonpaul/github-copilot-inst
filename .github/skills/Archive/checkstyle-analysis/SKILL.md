---
name: checkstyle-analysis
description: Inspects Checkstyle setup and findings, and runs approved read-only Checkstyle checks without changing source or rulesets.
---

# Checkstyle analysis

1. Inspect Checkstyle plugin/version, config/ruleset path, properties, suppressions, modules and report freshness.
2. If not configured, report that fact; do not add or upgrade a plugin without approval.
3. Use official Checkstyle docs to verify check names/properties and plugin compatibility when needed.
4. Do not edit source, POM, ruleset, suppression or report files. Do not mass-format.
5. Run only after explicit approval of the exact command and expected output location.
6. Findings include check name, path/line, message, severity if available, suppression status and suggested fix.

Output: Checkstyle config; report freshness; findings; command; exit code; risks; next action.
