# Review resolution — PR #10 Polynomial Galois Groups

## Issues addressed

- Made general resolvent certificates collision-safe. Upper-bound soundness now requires a
  recomputed full-orbit-degree resolvent plus separability/squarefreeness, or the same checked
  evidence after a separating Tschirnhausen transform.
- Added an honest Lean prototype for `ResolventSeparationEvidence` and required
  `GaloisCertificate.Checks` to carry it before proving subgroup containment.
- Scoped degree 8–11 classification completeness out of this roadmap. It supplies named
  reference subgroups, computed invariants, label predicates, and checked per-polynomial
  certificates without claiming every transitive group has a label.
- Matched PR #9's Layer-3 interface exactly on polynomial-discriminant hypotheses, arithmetic
  Frobenius orientation, and fixed-point-completed cycle type.
- Assigned stable family index number 24. Rebase after PR #9 so the supplier declaration is
  visible, preserving that number and the single global import.
- Reclassified other deferred language as required milestones or explicit scope exclusions.
- Recorded the exact inspected `CertifyingInvariantsNF` revision and its undeclared licence;
  no outreach or permission is claimed.

## Files changed

- `TauCetiRoadmap/PolynomialGaloisGroups/README.md`
- `TauCetiRoadmap/PolynomialGaloisGroups/Suggested.lean`

## Mathematical choices

- A specialized rational root or factorization pattern without collision evidence proves no
  subgroup upper bound.
- Reference data and completeness are separate contracts; the present roadmap proves only
  semantics for named references in degrees 8–11.

## Checks

- `lake build TauCetiRoadmap.PolynomialGaloisGroups.Suggested` — passed; expected `sorry`
  warnings only.
- `lake build` — run in the review clone.
- `git diff --check` — passed.
- Review-language grep from the handoff — no matches.

## Remaining coordination

- Agree the downstream certificate file format with C. Birkbeck before freezing the API.
- Copy or adapt no `CertifyingInvariantsNF` code/data without explicit permission.
