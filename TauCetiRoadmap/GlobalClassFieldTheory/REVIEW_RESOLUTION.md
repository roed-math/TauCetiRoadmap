# Review resolution: PR #6 Global Class Field Theory

## Issues addressed

- Replaced prospective “coordinate later” prose with a provenance/licence ledger recording
  the actual 2026-08-01 status for Mathlib #40735, Mathlib #40661, FLT,
  `kbuzzard/ClassFieldTheory`, `mariainesdff/ideles`, and the remaining active Mathlib
  substrate.
- Recorded exact PR heads or repository revisions, Apache-2.0 licences, overlap, the honest
  uncontacted status, lack of agreed ownership, the intended consume/upstream/independent
  plan, and explicit refactor gates.
- Removed the previous blanket decision to develop independently in Tau Ceti. Overlapping
  implementation is now gated on contact; reusable existing results are preferentially
  consumed or contributed upstream.
- Reclassified the Multiquadratic legacy ambiguous-scope paragraph as an explicit scope
  exclusion/future-direction section. Layers 0–3 remain the complete required roadmap.
- Assigned stable family root-list number 20 and retained exactly one
  `GlobalClassFieldTheory.Suggested` import.

## Files and mathematical choices

- `GlobalClassFieldTheory/README.md`: process/provenance correction only. Existing
  normalizations and the density-free reciprocity route are unchanged.
- `Multiquadratic/README.md`: clarified deliverable semantics without expanding scope.
- Root `README.md`: stable entry 20.
- `TauCetiRoadmap.lean`: one existing Suggested import, unchanged by this review.

No outreach was performed or implied by these edits.

## Validation

- Compared the branch head with reviewed SHA
  `8fe62f8fdd245bc33c7a2fbcf02bcbfa0b29ac22`; it matched before editing.
- Refreshed public GitHub PR/repository heads with `gh api` / `git ls-remote`.
- Ran the family prohibited-phrase grep over the two affected roadmap READMEs and
  `Suggested.lean`.
- `lake exe cache get` completed successfully. The branch-local target build was stopped
  without diagnostics at the integration owner's request; that owner is running the
  combined ten-roadmap build. This review made no Lean changes on PR #6.

## Remaining gates and landing order

The substantive remaining concern is external coordination, not an omitted theorem:
Layers 2–3 must contact the #40735 author; Layers 8–9 must coordinate with #40661; FLT,
ClassFieldTheory, and ideles reuse is gated exactly as the ledger says.

Preferred family landing/rebase order is the review handoff order: foundations and local
fields first, then PR #6; PR #7 follows after shared analytic ownership is settled, and PR
#8 follows after the #6/#7/#9 interfaces are final. Rebase the stable root index/import
edits against the family integration branch rather than renumbering this entry.
