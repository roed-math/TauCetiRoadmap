# Review resolution: PR #6, global class field theory

This file records what the second review round changed. The previous version of it claimed that
"the substantive remaining concern is external coordination, not an omitted theorem". That was
wrong: the review found two mathematical errors, several missing prerequisites, and an
ownership overlap with a sibling roadmap. All of them are fixed below.

## Mathematical corrections

- **The sign character of `ℚ` does not exist.** The Layer 3 dictionary offered it as an example
  of a Hecke character of conductor `∞`. But `Cl_{((1),∞)}(ℚ) = 1`, since every fractional ideal
  of `ℤ` has a unique positive generator, so there is no such character. It is replaced by the
  odd Dirichlet character `ZMod.χ₄`, of finite conductor `4` and ray conductor `(4)·∞`, and the
  triviality of `Cl_{((1),∞)}(ℚ)` is now a stated target in `Suggested.lean` so that the error
  cannot recur. The parity compatibility (evaluate the product formula at the principal idele
  `−1`; the real sign component is nontrivial exactly for odd characters) is stated explicitly
  rather than left implicit.
- **Cyclotomic ramification.** "Ramified exactly at the `p ∣ n`" is false: `ℚ(ζ₆) = ℚ(ζ₃)` is
  unramified at `2`. Layer 4 now states the normalized level `n₀` (`n/2` when `n ≡ 2 mod 4`,
  else `n`), says that the ramified finite primes are those dividing `n₀` when `n₀ ≥ 3`, keeps
  the `(ζ − 1)` theorem for prime-power level only, and consumes the general `e` and `f`
  formulas at level `p^a m`. The ray class field identity `ℚ_{(n)∞} = ℚ(ζₙ)` for nonminimal
  moduli is kept and is now explicitly distinguished from the conductor.
- **The Hasse norm counterexample is now a theorem, not a "non-theorem".** Layer 5 states the
  knot group, Tate's description of it through `Ĥ^{-3}(G, ℤ)`, and the explicit witness: for
  `L = ℚ(√13, √17)`, the rational `25` is a local norm everywhere and is not a global norm
  (Cassels–Fröhlich Exercise 5.3, p. 360, quoted in Milne CFT VIII §3). The example was checked
  before being written down: `25` and `49` are not global norms while `4` and `9` are, and `5`
  itself is not even a local norm at `5`, so the witness has to be the square.
- **Type `A₀` was defined wrongly.** "All `s_w = 0` with integer exponents" excludes algebraic
  norm twists. Layer 10A now classifies the continuous characters of `ℝˣ` and `ℂˣ` first, gives
  the algebraic infinity type as `∏_σ σ(x)^{n_σ}` with `n_σ ∈ ℤ`, notes that the radial exponent
  at a complex place is `n_σ + n_{σ̄}` and is not zero in general, states the unit-triviality and
  weight conditions, and attaches the number-field-of-values claim to the ideal-side character
  rather than to the idelic one.
- **Two worked examples were relabelled or completed.** The Hilbert-product-formula remark in
  the `ℚ(√5)` norm example is Layer 11 material, not Layer 5. The `x² + 5y²` example now
  requires the class-field statement (complete splitting in `H = ℚ(√−5, i)`), since the
  congruence criterion alone is elementary. The `x² + 14y²` promise of "an explicit degree-8
  field" is now discharged: `H = ℚ(√−14, α)` with `α⁴ + 2α² − 7 = 0`, and a nonmaximal-order
  instance (`x² + 27y²`, the order `ℤ + 6𝓞_K` of discriminant `−108`, ring class field
  `ℚ(√−3, ∛2)`) was added because it is the one that exercises Layer 10B. Both were checked
  numerically before being written down.

## Missing prerequisites, now built

- **Layer 2C, the archimedean local package** (new). The local-fields roadmap is nonarchimedean
  by construction, so global reciprocity had no source for `Art_ℝ`, the archimedean norm index,
  the invariants `inv_ℂ = 0` and `1/2`, the `ℂ/ℝ` Herbrand quotient, the real-place conductor
  clause, or the archimedean Hilbert symbols. They are now targets here.
- **Layer 2B, ideles in a finite extension** (new). The Galois action on `𝔸_L`, the extension
  map, the idele norm with its component formula `N(x)_v = ∏_{w ∣ v} N_{L_w/K_v}(x_w)`, towers
  and base change, the semi-local coinduced description, and `C_L^G ≃ C_K` derived from
  Hilbert 90 rather than assumed. Layer 5 was using all of it without stating it.
- **Layer 0, simultaneous approximation** (new). Surjectivity onto residue classes and signs
  needs one element meeting both kinds of condition; Mathlib has no weak approximation theorem
  at the pin. The pinned route is Artin–Whaples for a finite set of places. The domain of the
  reduction map is now a named subgroup of `Kˣ` rather than "elements coprime to `𝔪₀`".
- **One congruence subgroup, defined once.** `IdeleCongruenceSubgroup 𝔪` is pinned component by
  component in the conventions table, its image in `C_K` is `RaySubgroup 𝔪`, and the dictionary
  is `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. The old text alternated between three variants.
- **Decompositions of the four hardest proofs.** `kummer_le`, the passage from solvable groups
  to all finite Galois groups (the Sylow restriction-corestriction step, which "solvable
  induction" does not supply), Artin's crossing argument, and the existence theorem are each
  broken into numbered milestones with the reference for each step. The Herbrand-lattice
  prerequisites and the `S`-idele setup (which `S`, what `S_L` is, the filtered colimit, the
  Shapiro assembly) are likewise spelled out.
- **Norm limitation.** `C_K/N C_L ≃ Gal(L/K)^{ab}` for nonabelian Galois `L/K` was claimed as a
  cheap half of the abelian theorem in Layer 6. It needs norm limitation, so it moved to
  Layer 7 and is derived there.
- **A fixed algebraic closure** for Layers 7 to 11, so that composita, `K^{ab} = ⨆_𝔪 K_𝔪`, and
  `colim_L C_L` are statements about intermediate fields of one closure; profinite
  identifications are `ContinuousMulEquiv`s.
- **Layers 10A, 10B, 10C** replace the old single Layer 10: infinity types; orders, conductors
  and Picard groups (Mathlib has no order theory, and orders are not Dedekind, so the
  Layer 0 and 1 machinery does not apply to them); ring class fields and `x² + ny²`.
- **Generality split.** Dedekind-generic definitions are separated from the finiteness and
  cardinality statements, which now carry either `NumberField K` or an explicit
  `Finite (R ⧸ 𝔪₀)ˣ` and `Finite (ClassGroup R)` hypothesis package. The claim that nonmaximal
  orders are covered by the Dedekind machinery is removed.
- **Layer 11 scope is now definite.** The `H²` sequence, the local invariants, the sum of
  invariants, and Hilbert reciprocity stay, stated in Galois cohomology. The translation to
  central simple algebras and any Brauer-group API is explicitly out of scope and assigned to a
  separate roadmap, and the vague `H³` bullet is replaced by a clean exclusion of
  Poitou–Tate material.

## Ownership and dependencies

- **Number Field Arithmetic owns the ideal-theoretic Artin symbol**: the abelian collapse, the
  map on ideals prime to the ramified set, multiplicativity, the restriction and tower formulas,
  and the cyclotomic identification of the arithmetic Frobenius with `[p]`. This roadmap
  consumes that object and owns the class field theory about it (factorization through a ray
  class group, kernel, surjectivity, agreement with the idelic map, conductor dependence,
  reciprocity, the classification by ideal groups). Layers 4, 6 and 7 were rewritten to that
  boundary, and the splitting-completely spelling now uses that roadmap's `.ncard` convention
  rather than a second one.
- **Merge prerequisites.** PRs [#1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  (Profinite Cohomology), [#2](https://github.com/roed-math/TauCetiRoadmap/pull/2) (Local
  Fields) and [#9](https://github.com/roed-math/TauCetiRoadmap/pull/9) (Number Field
  Arithmetic) must merge before this one, and this branch is rebased afterwards so that every
  pull-request link becomes a relative path (`../LocalFields/README.md` and so on). The
  prerequisite table at the top of the README names what is consumed from each. PR
  [#8](https://github.com/roed-math/TauCetiRoadmap/pull/8) (L-functions) is a consumer, not a
  prerequisite. The root-list number and the aggregate import are settled at that rebase against
  the family integration branch, not in this branch.

## External state (checked 2026-08-06)

| item | status |
|---|---|
| mathlib #40735 (idele class group) | open, head `ba5cc4688489`, updated 2026-08-05 |
| mathlib #40661 (Hilbert class field wanted statements) | open, head `184a5900ddc0`, updated 2026-07-16 |
| mathlib #36404 (local compactness of `𝔸_K`) | open, head `fca3a6af67b8`, updated 2026-03-21 |
| mathlib #36275 (finite-adele norm) | open, head `df510478253d`, updated 2026-07-29 |
| mathlib #42130 (instance transparency) | **closed unmerged 2026-08-06**, no longer tracked |
| mathlib #40848 (S-integers), #40791 (S-unit theorem), #41591 (decomposition refactor) | open |
| mathlib #41765 (Dirichlet density) | open; L-functions territory, boundary only |
| kbuzzard/ClassFieldTheory | `ccc3323c6750`, top commit 2026-07-31; still no global Lean code |
| FLT | `d18b563029f3`; `AdeleRing.discrete`, `cocompact`, Fujisaki all sorry-free |
| mariainesdff/ideles | `b85d242f18cb`, unchanged since 2023-10-05 |

No outreach was performed. Every provenance entry says so.

## Prototypes and validation

`Suggested.lean` grew from the pin-expressible statements to include the design-sensitive
objects: `Modulus` with its divisibility, the multiplicative congruence and prime-to-modulus
predicates, the congruence subgroup of `Kˣ`, the ideals prime to a modulus, the ray class group
and the narrow class group, the transition map, the idele congruence subgroup with the ray
dictionary, the real reciprocity map, the archimedean norm index and Hilbert symbol, and the
two new `x² + ny²` acceptance shapes. Two prototypes were corrected: the sign map is now
valued in `ℤˣ` rather than `Bool`, and the finite-idele quotient states its unit condition
through `adicCompletionIntegers` instead of the deprecated `Valued.v`.

Validation actually run in this branch, at the repository pin:

- `lake build TauCetiRoadmap.GlobalClassFieldTheory.Suggested`: green, 30 `sorry` warnings and
  no errors.
- `lake build`: green, 8532 jobs, `sorry` warnings only.
- `git diff --check`: clean.
- `git grep -nE 'roadmap in preparation|optional|deferred|for later'` over this roadmap: no
  matches.
- `git grep -n 'ideal-theoretic Artin map'`: two matches, both naming Number Field Arithmetic
  as the owner and this roadmap as the consumer.
- Relative links resolve (`../Multiquadratic/README.md`); one root-list entry and one aggregate
  import, both unchanged and to be renumbered at the family rebase.
- The numerical claims in the worked examples (the class numbers and narrow class numbers of
  `ℚ(√2)` and `ℚ(√3)`, the Hilbert class fields of `ℚ(√−5)` and `ℚ(√−14)`, the ring class field
  for `x² + 27y²` and the order's Picard group, the three splitting criteria checked against all
  primes below 300, 400 and 600 respectively, and the biquadratic norm witness) were checked in
  Sage before being written into the roadmap.
