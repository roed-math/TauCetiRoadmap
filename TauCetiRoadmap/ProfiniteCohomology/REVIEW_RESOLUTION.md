# Review resolution: PR #1

## Issues addressed

- Added `h2 : IsUnit (2 : K)` to the mod-2 Kummer cocycle prototype. The narrative now
  requires `[NeZero n]` and `hn : IsUnit (n : K)` for general Kummer theory and explicitly
  specializes under `2` invertible, so it makes no square-class/`H^1(G_K, ZMod 2)` claim in
  characteristic `2`.
- Replaced sibling-directory links that are broken on this branch with PR links and named the
  exact downstream interfaces.
- Replaced prospective coordination language with a factual provenance ledger. An absent source
  revision or contact record is a blocker to adaptation, not implied permission.

## Mathematical choice

Invertibility is stated as `IsUnit (n : K)`, rather than `CharZero`, preserving valid Kummer
theory in positive characteristic prime to `n`.

## Files and sections changed

- `README.md`: Layer 0 consumer contract; Layers 4–10 sibling references; Layer 9 Kummer
  hypotheses; Ordering's cross-roadmap milestone table; Provenance and coordination ledger.
- `Suggested.lean`: Layer 9 mod-2 Kummer signature and documentation.
- Root `README.md` / `TauCetiRoadmap.lean`: stable slot 15 retained; the Suggested import occurs
  exactly once.

## Verification

- `lake build TauCetiRoadmap.ProfiniteCohomology.Suggested` — succeeded (only the expected
  target-signature `sorry` warnings).
- `git diff --check` and targeted ambiguity, dependency, and provenance greps — clean.

## Landing and rebase order

This roadmap owns stable root-list slot **15**. Land it in the first family wave (alongside the
independent Algebraic Curves PR #5) and before Pro-p Groups PR #3, Local Fields PR #2, and the
later cohomological consumers. Rebase the branch onto current `main` immediately before landing;
retain the single `TauCetiRoadmap.ProfiniteCohomology.Suggested` import.

## Remaining concerns

Canonical continuous-cohomology interfaces are intentionally prose-only at this Mathlib pin.
The provenance ledger records that no upstream contact outcome is currently evidenced; migration
from an external source must wait until the corresponding record is updated.
