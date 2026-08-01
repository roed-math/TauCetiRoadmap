# PR #2 review resolution

## Issues addressed

- Replaced the false all-characteristics finiteness theorem for
  `Kˣ/(Kˣ)ⁿ` with separate prime-to-residue-characteristic and
  mixed-characteristic theorems. Equal-characteristic `p`-primary power classes
  are an explicit scope exclusion, with `𝔽_q((t))` recorded as the counterexample.
- Split Layer 8 into prime-to-residue-characteristic duality in both
  characteristics, mixed-characteristic `p`-primary duality for finite
  extensions of `ℚ_p`, and an explicit equal-characteristic `p`-primary
  exclusion requiring Artin–Schreier–Witt/finite-flat methods.
- Restricted Kummer and every cardinality formula to the regime where the
  corresponding étale statement is valid.
- Replaced unqualified `cd`/`scd` slogans with the exact assertions consumed:
  `cd_ℓ(G_K) = 2` for `ℓ ≠ char K`, `cd_p(G_K) = 2` in mixed
  characteristic, and `cd_p(G_K) = 1` in equal characteristic.
- Split the Euler characteristic into its prime-to-`p` value `1` and the
  mixed-characteristic absolute-value formula; no finite equal-characteristic
  `p`-primary formula is claimed.
- Corrected the Lean-facing normalized valuation notation:
  `v_K^×(π) = Multiplicative.ofAdd 1`, while `v_K^×(x) = 1` is reserved for
  the kernel. The reciprocity comparison now includes the map `ℤ → Ẑ`.
- Rewrote the family dependency as a milestone graph: PR #3 Layer 3 supplies
  early pro-`p`/Frattini APIs, PR #1 supplies the named cohomology layers, and
  this roadmap's late layers supply PR #3 Layer 11 and PR #4 Layers 6–7.
- Replaced unresolved sibling-relative links with stable PR links, assigned the
  family-wide root number `16`, and made every milestone's status explicit.
- Added revision-, licence-, contact-, ownership-, plan-, trigger-, and gate-level
  provenance records. No external contact or agreement is claimed.

## Files changed

- `README.md`: family-wide root number `16`.
- `TauCetiRoadmap/LocalFields/README.md`: mathematical redesign, dependencies,
  conventions, ordering, and provenance.
- `TauCetiRoadmap/LocalFields/Suggested.lean`: honest regime-specific power-class
  prototypes and explicit valuation target.

## Checks run

- `git diff --check`
- prohibited-word and stale-sibling-link `rg` campaigns
- `lake exe cache get`
- `lake build` — successful, 8532 jobs; expected `sorry` warnings only

## Landing and rebase order

The family integration order assigns Profinite Cohomology #15, Local Fields #16,
Pro-p Groups #17, and Quadratic Form Invariants #18. Land this PR after #1 and
before #3. Rebase onto the integration head immediately before landing, preserve
root number `16`, and retain exactly one
`TauCetiRoadmap.LocalFields.Suggested` import. This Git order is distinct from
implementation scheduling: PR #3 Layer 3 may be implemented before Local Fields
Layers 1/4/9, while PR #3 Layer 11 must wait for Local Fields Layers 5/7/8.

## Remaining concerns

- The ten-roadmap integration build and repository-relative link check remain a
  family-integration responsibility.
- The provenance gates are intentionally unresolved: no named external author was
  contacted in this review. Unlanded code may not be adapted until the relevant
  licence and coordination outcome are recorded.
