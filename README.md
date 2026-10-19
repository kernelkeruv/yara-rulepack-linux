# Linux YARA Rulepack | Synthetic defensive detection lab

**Current implementation:** an inert YARA rule, two text fixtures and a small Bash verification harness. The rule proves a content-matching workflow; it does not detect real malware.

## Why this matters for security operations

Detection engineering requires a falsifiable rule: define what should match, what must *not* match, run tests, inspect false positives and retain versioned evidence of the result. YARA rules are content indicators and must not be treated as security verdicts.

## Repository files

- [Synthetic marker rule](rules/synthetic_marker.yar): looks for a distinctive harmless ASCII marker.
- [Positive fixture](tests/fixtures/positive.txt): contains the marker.
- [Negative fixture](tests/fixtures/negative.txt): does not contain the marker.
- [Test runner](tests/run_rules.sh): compiles the rule and checks both outcomes, writing logs and hashes to a user-selected working directory.

## Reproduce in a disposable Linux VM

Install trusted YARA tooling appropriate to your distribution, verify `yara --version` and `yarac --version`, and set `WORK_DIR` to an existing writable directory. Work on this repository checkout, not personal or production files.

```bash
set -Eeuo pipefail
: "${WORK_DIR:?Export WORK_DIR first}"
bash tests/run_rules.sh
```

**Expected (not a claimed run result):** `PASS: positive fixture matched and negative fixture did not.` The script retains a unique directory named `yara-synthetic.*` under `WORK_DIR`, with compilation output, positive/negative match results and SHA-256 hashes. It exits nonzero for a missing binary, malformed rule, missing positive detection or unexpected negative detection.

## Boundaries and next steps

This initial demonstration has not been executed in a YARA-enabled CI environment as part of the portfolio review. Next add pinned CI validation and real defensive rules only with documented source, license, test coverage, performance and false-positive analysis. Do not commit live malware, user records, production logs, authentication secrets or source evidence.

Status: **minimal proof of concept**, not a curated validated Linux detection pack.
