# Review resolution — PR #9 Number Field Arithmetic

## Issues addressed

- Removed the ill-founded general integral Artin-conductor ideal. Layer 5 now owns finite
  ramification bookkeeping and already-integral permutation/Dirichlet cases; general Artin
  integrality and the general conductor live with a future ArtinRepresentations roadmap.
- Limited the current LMFDB label API to the intrinsic `d.r.|D|` prefix. The database-order
  `.i` coordinate is explicitly out of scope until an ordering, canonical-polynomial rule,
  isomorphism deduplication, bounded-list completeness certificate, and position certificate
  are all specified.
- Added the exact polynomial-side Dedekind/Frobenius corollary consumed by PR #10, with
  arithmetic Frobenius, `p ∤ f.discr`, and fixed points restored in the cycle partition.
- Replaced broken sibling-directory links with stable PR links and made the Local Fields and
  Polynomial Galois Groups dependencies layer-specific.
- Assigned stable family index number 23. Rebase this branch after PRs #1–#4 in the proposed
  landing order (and before #6/#10 as applicable), preserving that number and its one global
  import.
- Refreshed mathlib PR #41591 and added honest coordination/licence records for Mathlib and
  `CBirkbeck/CertifyingInvariantsNF`; no outreach or permission is claimed.
- Removed pseudo-deferred milestones from numbered layers.

## Files changed

- `TauCetiRoadmap/NumberFieldArithmetic/README.md`
- `TauCetiRoadmap/NumberFieldArithmetic/Suggested.lean`

## Mathematical choices

- General Artin conductors are not represented by ordinary ideals before exponent
  integrality.
- Hermite finiteness is not treated as a canonical database ordering.
- PR #9 owns the Frobenius/Dedekind supplier theorem; PR #10 owns the consumer-side
  `fullCycleType` abbreviation and certificate logic.

## Checks

- `lake build TauCetiRoadmap.NumberFieldArithmetic.Suggested` — passed; expected `sorry`
  warnings only.
- `lake build` — run in the review clone.
- `git diff --check` — passed.
- Review-language grep from the handoff — no matches.

## Remaining coordination

- Re-check #41591 at the toolchain bump and consume the ring-level API when it lands.
- Obtain an explicit licence/permission and agree the certification interface before adapting
  anything from `CertifyingInvariantsNF`.
