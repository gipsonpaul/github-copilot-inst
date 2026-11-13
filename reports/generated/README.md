# Generated reports

All runtime-generated reports belong in this directory. The Reporter Agent creates timestamped Markdown files here only after the coordinator has received report-write approval.

Naming convention: `YYYYMMDD-HHmmssZ_<stage-id>_<short-slug>.md`.

Do not overwrite or delete prior reports. Static templates belong in `reports/templates/`. Native Maven/Snyk/PMD/Checkstyle output may remain in its tool-configured workspace folder (often a module's `target/`); generated Markdown reports should reference those artifact paths rather than moving them without approval.
