# Review resolution: PR #3

## Issues addressed

- Defined `q(G)` from finite torsion in the topological abelianization and made that finiteness
  evidence an explicit argument. There is no longer a natural-number value for groups outside the
  invariant's valid domain.
- Separated `q(G)` from `Im χ`: equality `Im χ = 1 + qℤ_p` is asserted only for `q ≠ 2`; the
  exceptional `q = 2` classification uses `(rank, Im χ)`.
- Preserved and rechecked the `D₀` and `ℚ₂(√-2)` examples under the corrected conventions.
- Replaced absent sibling-directory links with PR links and expanded the Local Fields relation by
  supplied/consumed layers.
- Added an evidence-only provenance ledger; missing revision, licence, or contact fields block code
  adaptation and do not imply permission.

## Files and sections changed

- Root `README.md`: stable list slot changed from 15 to 17.
- `README.md`: pinned `q`/orientation convention; Layers 7 and 11; Ordering's layer-level
  dependency table; Provenance, coordination, and licensing ledger; sibling PR links.
- `Suggested.lean`: valid-domain `demushkinQ` prototype and the `D₀` finiteness/value milestones.
- `TauCetiRoadmap.lean`: the Suggested import remains present exactly once.

## Verification

- `lake build TauCetiRoadmap.ProPGroups.Suggested` — succeeded after the final prototype edit
  (only the expected target-signature `sorry` warnings).
- `git diff --check` and targeted greps for `demushkinQ`, exceptional `q = 2`, dependency wording,
  and ambiguous deliverable terms — clean.

## Landing and rebase order

This roadmap owns stable root-list slot **17**. Rebase and land it after Profinite Cohomology PR #1
(slot 15) and before Local Fields PR #2's final arithmetic layers; foundational Layers 0–3 remain
available to Local Fields independently of the Layer-11 summit. Retain the single
`TauCetiRoadmap.ProPGroups.Suggested` import.

## Remaining concerns

The cohomological `IsDemushkin` predicate remains prose-only at this Mathlib pin. When that predicate
becomes expressible, the preferred final API may take `hG : IsDemushkin p G` and derive torsion
finiteness internally rather than exposing the explicit finiteness witness.
