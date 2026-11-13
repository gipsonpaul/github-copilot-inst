---
name: security-remediation
description: Triage and fix Java dependency vulnerabilities with Snyk while preserving dependency compatibility and verifying remediation.
---

# Snyk remediation workflow

1. Identify the repository's actual Snyk configuration, executable, authentication state and supported scan command.
2. Capture baseline findings.
3. Trace vulnerable transitive dependencies to their direct dependency/BOM owner.
4. Prefer the narrowest compatible fixed version and avoid unrelated upgrades.
5. Do not suppress findings, alter severity thresholds, disable scanning or add ignores without explicit authorization.
6. Validate Maven compilation/tests after dependency changes.
7. Re-scan and compare baseline with final results.
8. Report fixed, unresolved and unverified findings separately.
