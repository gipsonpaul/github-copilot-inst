---
name: snyk-remediation
description: Reviews Snyk vulnerabilities and applies approved minimal remediations while preserving dependency compatibility and BOM alignment.
---

# Snyk vulnerability remediation

## Procedure
1. Inspect existing in-workspace Snyk JSON/HTML/SARIF/text reports first; record timestamp, revision, project/module and freshness.
2. If a scan is required, inspect `snyk` CLI availability and the project's existing configuration, then ask coordinator approval for the exact command. Do not expose environment variables, tokens or credentials.
3. For each issue record package, severity, installed/fixed version, direct/transitive path, affected module and advisory ID.
4. Verify the recommended fixed version from Snyk and vendor/package documentation using web research. Check Spring/Maven BOM compatibility.
5. Recommend minimal targeted upgrades. Avoid blanket upgrades, overrides, exclusions, suppressions, `.snyk` ignore rules or disabling the scanner without explicit scope approval.
6. Do not run broad `snyk fix` unless the coordinator obtains explicit command and file approval.
7. Edit only approved paths. Run approved re-scan and Maven gate; report residual findings.

## Output
Finding ID; affected package/path; advisory and severity; remediation; version evidence; approved changed files; scan command/status; residual risk.
