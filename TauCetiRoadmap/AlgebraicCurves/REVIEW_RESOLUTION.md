# Review resolution: PR #5

## Issues addressed

- Reclassified every ambiguous future item. Numbered Layers 0–12 now contain required proved
  theorems; positive-characteristic refinements, singular-plane-curve corrections, and the analytic
  comparison live only in an explicit non-deliverable scope-exclusion section.
- Changed `IsFunctionField` from a typeclass to an intrinsic `Prop` passed explicitly as `hF` in
  every prototype.
- Replaced the absent Local Fields sibling-directory link with PR #2 and stated that upper
  numbering/Hasse–Arf is not a prerequisite of this roadmap's lower-numbering work.
- Added theorem-level cross-roadmap contracts and an evidence-only provenance ledger. In
  particular, no contact with `vaca22/riemann-roch-function-fields` is claimed; code adaptation is
  blocked until a revision and contact outcome are recorded.

## Files and sections changed

- Root `README.md`: stable list slot changed from 15 to 19.
- `README.md`: standing hypotheses and convention table; Layers 0, 5, 8, 10, 11, and 12;
  scope exclusions; Ordering's milestone contracts; Provenance and coordination ledger.
- `Suggested.lean`: `IsFunctionField` definition and every function-field hypothesis.
- `TauCetiRoadmap.lean`: the Suggested import remains present exactly once.

## Verification

- `lake build TauCetiRoadmap.AlgebraicCurves.Suggested` — succeeded (only the expected
  target-signature `sorry` warnings).
- `git diff --check` and targeted greps for ambiguous deliverable language,
  `IsFunctionField` typeclass uses, and broken sibling links — clean.

## Landing and rebase order

This roadmap owns stable root-list slot **19**. It is independent of the profinite/local-field
chain and may land in the first family wave alongside PR #1. Rebase onto current `main` immediately
before landing and retain the single `TauCetiRoadmap.AlgebraicCurves.Suggested` import.

## Remaining concerns

The live Riemann–Roch upstreaming stack may change before implementation starts. The roadmap pins
the refactor trigger and forbids adapting external code until the provenance record is completed.
