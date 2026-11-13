---
name: structured-reporting
description: Creates consistent stage, research, test, quality and final Markdown reports with traceable evidence.
---

# Structured reporting

## Destination
All generated reports belong under `reports/generated/`. Static templates belong under `reports/templates/`. Do not write reports at project root or alongside source files.

## Approval and filenames
Only Reporter Agent writes report files. The coordinator must send `REPORT_WRITE_APPROVAL: GRANTED`. Create a new timestamped Markdown file (UTC timestamp + stage + slug); never overwrite or delete a prior report.

## Required sections
- Title, UTC generated time, stage ID, status and repository revision if known.
- Executive summary and scope (including files/modules examined).
- Configuration: source/target Java, Boot, Cloud/Azure versions as known.
- Findings with stable IDs, severity/priority, evidence, file/line and recommended action.
- Official evidence table: source, title, relevant version, published date (if available), access date and URL.
- Files read/changed and approved scope.
- Exact commands, working directory, exit code and observable output summary.
- Test/coverage/PMD/Checkstyle/Snyk results and artifact paths.
- Decisions, assumptions, risks, blockers, skipped/unavailable checks and next action.

## Status values
`PASS`, `FAIL`, `BLOCKED`, `NOT RUN`, `NOT APPLICABLE`. Never turn a missing report, unexecuted check or inconclusive result into PASS. Separate facts, assumptions and recommendations.

## Report types
Use stage report for any stage, research report for web sources, target validation report for version gates, test report for tests/coverage, quality/security report for Snyk/PMD/Checkstyle, final report for end-to-end result. Keep all generated artifacts under `reports/generated/`.
