---
name: maven-build-validation
description: Defines safe, reproducible Maven test and verification gates and captures observable command outcomes.
---

# Maven build validation

## Safety
- Run only from project root. Use installed `mvn`, not wrapper by default.
- Pass `-Dmaven.repo.local=.m2/repository` to keep the Maven repository within the workspace.
- Do not read user/global Maven settings. Inspect workspace-local Maven config before execution.
- Provide the exact command and expected side effects to coordinator; require explicit approval for execution.

## Gate sequence
1. Select focused validation for the change: compiler/test-compile, targeted test, Snyk, PMD, Checkstyle, or coverage as configured.
2. Immediately run the approved Maven lifecycle gate (normally `verify` only after inspecting project plugin bindings and profiles).
3. Never add `clean`, `install`, skip flags, fail-never flags or extra profiles unless the exact command was approved.
4. Record command, working directory, exit code, module status, tests run/passed/failed/skipped, coverage metrics, and output paths.
5. A failed/unknown command is not PASS. Stop on failure and return the evidence to coordinator.

## Output
Exact command; reason; working directory; exit code; build status; module/test/coverage summary; report paths; limitations.
