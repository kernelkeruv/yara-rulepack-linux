# Linux YARA Rulepack | Planned detection lab

**Status (October 2026): repository scaffold. No YARA rules, test fixtures, or functional validation harness were found on the default branch in this review.**

## Purpose

An eventual collection of defensive YARA rules to identify known, synthetic Linux malware-like file patterns in an **authorized** test directory. YARA is a content-matching engine, not an antivirus verdict or proof of compromise.

## Planned reproducible lab

1. Commit a small, plainly labeled synthetic test fixture with an inert string, not actual malware.
2. Add one tightly scoped `.yar` rule and document its metadata, strings, and rationale.
3. Verify `yara --version` and `yarac` compilation in a disposable Linux environment.
4. Add a positive fixture (expected match), negative fixture (expected nonmatch), and automated checks that fail when either result deviates.
5. Explain expected false positives, applicability, performance limits, known blind spots and rule update policy.
6. Restrict all scans to explicitly approved fixtures; never publish user evidence, logs, credentials or data feeds.

## Acceptance checks

- [ ] One committed valid rule with comments and versioned rationale
- [ ] Matching and nonmatching synthetic fixtures
- [ ] `yarac` syntax check and CI assertions with nonzero failure on errors
- [ ] README showing **actual sanitized output captured from a test run**
- [ ] Reproducible environment and dependency versions

The presence of generic workflow files does not prove rules or CI detection coverage. Until implemented, describe this repository as a planned lab, not a curated validated detection pack.
