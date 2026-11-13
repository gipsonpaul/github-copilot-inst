---
name: pmd-analysis
description: Inspects PMD setup and findings, and runs approved read-only PMD checks without changing source or rulesets.
---

# PMD analysis

1. Inspect configured PMD Maven plugin, version, ruleset, exclusions, suppressions, modules and existing report freshness.
2. If not configured, report that fact; do not add a plugin unless another approved agent stage includes it.
3. Use official PMD docs to verify rule semantics/plugin compatibility when needed.
4. Do not edit source, POM, ruleset, suppression or report files. Do not auto-fix.
5. Run PMD only with explicit approval for the exact command and expected output location. Keep native output in the project.
6. Findings include rule, priority, path/line, evidence, impact and suggested fix.

Output: PMD config; report freshness; findings; command; exit code; risks; next action.
