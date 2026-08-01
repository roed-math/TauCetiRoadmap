# PR #4 review resolution

## Issues addressed

- Removed the ungrounded claim that the quotient-to-Brauer map is injective. The roadmap now requires
  only `I² → Br(K)[2]`, its vanishing on `I³`, and the induced homomorphism
  `I²/I³ → Br(K)[2]`; it explicitly makes no injectivity, surjectivity, or
  classification claim.
- Made Merkurjev/norm-residue injectivity a scope exclusion because no roadmap
  supplies its proof.
- Updated Layer 5 to reflect the pinned reality that `BrauerGroup` is not yet a
  group and required quaternion/CSA APIs remain in open Mathlib PRs. Unexpressible
  targets stay in prose; no placeholder group or private duplicate is authorized.
- Recorded exact current revisions and licence/contact status for HassePrinciple,
  the Mathlib CSA/Brauer PRs, and `Whysoserioushah/BrauerGroup`. No external
  contact or ownership agreement is claimed; implementation gates are explicit.
- Replaced unresolved sibling-relative links with stable PR-and-layer references.
  PR #1 Layers 7/9/10 and PR #2 Layers 0/1/8B are the precise consumed interfaces;
  this roadmap supplies the local classification/Hilbert dictionary used by PR #7.
- Assigned the family-wide root number `18` and made every milestone's status explicit.

## Files changed

- `README.md`: family-wide root number `18`.
- `TauCetiRoadmap/QuadraticFormInvariants/README.md`: corrected Layer 4/5
  contract, milestone graph, ordering, and provenance.
- `TauCetiRoadmap/QuadraticFormInvariants/Suggested.lean`: documents why the
  quotient map and Brauer targets remain prose-only at this pin.

## Checks run

- `git diff --check`
- prohibited-word, stale-sibling-link, and injectivity `rg` campaigns
- `lake exe cache get`
- `lake build` — successful, 8532 jobs; expected `sorry` warnings only

## Landing and rebase order

The family integration order assigns this roadmap root number `18`. Land it
after Pro-p Groups #17. Rebase onto the integration head immediately before
landing, preserve root number `18`, and retain exactly one
`TauCetiRoadmap.QuadraticFormInvariants.Suggested` import. Its implementation
dependencies remain milestone-specific: the cohomology-free layers can proceed
independently, while Layers 7–9 wait for the named PR #1 milestones and the
general local bridge waits for PR #2.

## Remaining concerns

- The ten-roadmap integration build and repository-relative link check remain a
  family-integration responsibility.
- All external coordination gates remain genuinely unfulfilled. No staging code
  may be adapted and no temporary Brauer wrapper may be introduced without a
  recorded licence/coordination decision and deletion trigger.
