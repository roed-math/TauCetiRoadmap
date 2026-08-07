# Review resolution: PR #6, global class field theory

This file is the pull request's working record, not part of the roadmap. It says what each
review round changed and what remains for whoever lands the branch.

## Round 2: mathematical corrections

- **The sign character of `ℚ` does not exist.** The Layer 3 dictionary offered it as an example
  of a Hecke character of conductor `∞`. But `Cl_{((1),∞)}(ℚ) = 1`, since every fractional ideal
  of `ℤ` has a unique positive generator, so there is no such character. It is replaced by the
  odd Dirichlet character `ZMod.χ₄`, of finite conductor `4` and ray conductor `(4)·∞`, and the
  triviality of `Cl_{((1),∞)}(ℚ)` is a stated target in `Suggested.lean` so that the error
  cannot recur. The parity compatibility (evaluate the product formula at the principal idele
  `−1`; the real sign component is nontrivial exactly for odd characters) is stated explicitly.
- **Cyclotomic ramification.** "Ramified exactly at the `p ∣ n`" is false: `ℚ(ζ₆) = ℚ(ζ₃)` is
  unramified at `2`. Layer 4 states the normalized level `n₀` (`n/2` when `n ≡ 2 mod 4`, else
  `n`), says that the ramified finite primes are those dividing `n₀` when `n₀ ≥ 3`, keeps the
  `(ζ − 1)` theorem for prime-power level only, and consumes the general `e` and `f` formulas at
  level `p^a m`. The ray class field identity `ℚ_{(n)∞} = ℚ(ζₙ)` for nonminimal moduli is kept
  and distinguished from the conductor.
- **The Hasse norm counterexample is a theorem, not a "non-theorem".** Layer 5 states the knot
  group, Tate's description of it through `Ĥ^{-3}(G, ℤ)`, and the explicit witness: for
  `L = ℚ(√13, √17)`, the rational `25` is a local norm everywhere and is not a global norm
  (Cassels–Fröhlich Exercise 5.3, p. 360, quoted in Milne CFT VIII §3). The example was checked
  before being written down: `25` and `49` are not global norms while `4` and `9` are, and `5`
  itself is not even a local norm at `5`, so the witness has to be the square.
- **Type `A₀` was defined wrongly.** "All `s_w = 0` with integer exponents" excludes algebraic
  norm twists. Layer 10A classifies the continuous characters of `ℝˣ` and `ℂˣ` first, gives the
  algebraic infinity type as `∏_σ σ(x)^{n_σ}` with `n_σ ∈ ℤ`, notes that the radial exponent at
  a complex place is `n_σ + n_{σ̄}` and is not zero in general, states the unit-triviality and
  weight conditions, and attaches the number-field-of-values claim to the ideal-side character
  rather than to the idelic one.
- **Two worked examples were relabelled or completed.** The Hilbert-product-formula remark in
  the `ℚ(√5)` norm example is Layer 11 material, not Layer 5. The `x² + 5y²` example requires
  the class-field statement (complete splitting in `H = ℚ(√−5, i)`), since the congruence
  criterion alone is elementary. The `x² + 14y²` promise of "an explicit degree-8 field" is
  discharged: `H = ℚ(√−14, α)` with `α⁴ + 2α² − 7 = 0`, and a nonmaximal-order instance
  (`x² + 27y²`, the order `ℤ + 6𝓞_K` of discriminant `−108`, ring class field `ℚ(√−3, ∛2)`) was
  added because it is the one that exercises Layer 10B. Both were checked numerically first.

## Round 2: missing prerequisites, now built

- **Layer 2C, the archimedean local package.** The local-fields roadmap is nonarchimedean by
  construction, so global reciprocity had no source for `Art_ℝ`, the archimedean norm index, the
  invariants `inv_ℂ = 0` and `1/2`, the `ℂ/ℝ` Herbrand quotient, the real-place conductor
  clause, or the archimedean Hilbert symbols. They are now targets here.
- **Layer 2B, ideles in a finite extension.** The Galois action on `𝔸_L`, the extension map, the
  idele norm with its component formula `N(x)_v = ∏_{w ∣ v} N_{L_w/K_v}(x_w)`, towers and base
  change, the semi-local coinduced description, and `C_L^G ≃ C_K` derived from Hilbert 90 rather
  than assumed. Layer 5 was using all of it without stating it.
- **Layer 0, simultaneous approximation.** Surjectivity onto residue classes and signs needs one
  element meeting both kinds of condition; Mathlib has no weak approximation theorem at the pin.
  The pinned route is Artin–Whaples for a finite set of places.
- **One congruence subgroup, defined once.** `IdeleCongruenceSubgroup 𝔪` is pinned component by
  component in the conventions table, its image in `C_K` is `RaySubgroup 𝔪`, and the dictionary
  is `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. The old text alternated between three variants.
- **Decompositions of the four hardest proofs.** `kummer_le`, the passage from solvable groups
  to all finite Galois groups (the Sylow restriction-corestriction step, which "solvable
  induction" does not supply), Artin's crossing argument, and the existence theorem are each
  broken into numbered milestones with the reference for each step. The Herbrand-lattice
  prerequisites and the `S`-idele setup are likewise spelled out.
- **Norm limitation.** `C_K/N C_L ≃ Gal(L/K)^{ab}` for nonabelian Galois `L/K` was claimed as a
  cheap half of the abelian theorem in Layer 6. It needs norm limitation, so it moved to Layer 7
  and is derived there.
- **A fixed algebraic closure** for Layers 7 to 11, so that composita, `K^{ab} = ⨆_𝔪 K_𝔪`, and
  `colim_L C_L` are statements about intermediate fields of one closure; profinite
  identifications are `ContinuousMulEquiv`s.
- **Layers 10A, 10B, 10C** replace the old single Layer 10: infinity types; orders, conductors
  and Picard groups (Mathlib has no order theory, and orders are not Dedekind, so the Layer 0
  and 1 machinery does not apply to them); ring class fields and `x² + ny²`.
- **Generality split.** Dedekind-generic definitions are separated from the finiteness and
  cardinality statements, which now carry either `NumberField K` or an explicit
  `Finite (R ⧸ 𝔪₀)ˣ` and `Finite (ClassGroup R)` hypothesis package.
- **Layer 11 scope is definite.** The `H²` sequence, the local invariants, the sum of
  invariants, and Hilbert reciprocity stay, stated in Galois cohomology. The translation to
  central simple algebras and any Brauer-group API is out of scope, and the vague `H³` bullet is
  replaced by a clean exclusion of Poitou–Tate material.

## Round 3: the follow-up review

- **Artin's crossing lemma was stated wrongly.** The auxiliary field `E/K` was called
  cyclotomic; it is not. Layer 6 now gives Artin's lemma in the form of Lang X §2 (p. 202) and
  Janusz V, Lemma 5.6 (p. 194): the integer `m` and the field `E` with `L ∩ E = K`,
  `L ∩ K(ζ_m) = K`, `L(ζ_m) = E(ζ_m)`, and `𝔭` split completely in `E/K`, with the field
  lattice drawn, the construction of `E` as the fixed field of
  `⟨σ × τ, Frob_𝔭|L × Frob_𝔭|K(ζ_m)⟩` given, the elementary numerical input identified (Janusz
  V, Lemmas 5.3 and 5.4, the argument behind Mathlib's `Nat.exists_prime_gt_modEq_one`, and not
  a theorem on primes in arithmetic progressions), the one-prime form pinned in preference to a
  simultaneous strengthening, the restriction isomorphism `Gal(LE/E) ≃ Gal(L/K)` and the
  transport identity `θ_{LE/E}(y)|_L = θ_{L/K}(N_{E/K} y)` stated, and the place where the
  norm-index equality is used named (Janusz V, Theorem 5.7: the containment becomes an equality
  because both subgroups have index `[L:K]`). The reduction of the general abelian case to the
  cyclic one is now a decomposition into cyclic quotients rather than an induction on the
  degree, matching Janusz V, Theorem 5.8.
- **The `x² + ny²` hypotheses were wrong for nonsquarefree `n`.** `ℤ[√−n]` is not maximal
  whenever `−n ≢ 1 (mod 4)`; `ℤ[√−12]` is the smallest counterexample. Layer 10C now writes
  `n = f²d` with `d` squarefree, gives `disc(O_n) = −4n`, the field discriminant, the conductor
  (`2f` when `d ≡ 3 mod 4`, else `f`), and maximality exactly when `f = 1` and `d ≢ 3 (mod 4)`.
  The `n = 27` instance is derived from that formula rather than asserted.
- **The two descent placeholders are now propositions.** Layer 5's `kummer_le` step 3 states the
  restriction and corestriction maps on the norm quotients, `cor ∘ res = [K':K]`, the exponent-`p`
  argument that makes restriction injective, and the inequality transported back to `K`.
  Layer 7's existence theorem states the upward-closure lemma, the Kummer construction, the
  descent through norm limitation with the ramification bound it preserves, and the induction on
  `(C_K : U)`, following Milne CFT VII 9.1–9.5.
- **The biquadratic local-norm claim was too compressed.** "A square, hence a local norm" is not
  a reason. The worked example now gives the reason: every decomposition group of `ℚ(√13,√17)/ℚ`
  is a proper cyclic subgroup of `(ℤ/2)²`, so every local degree is at most two and every
  rational square is a local norm everywhere.
- **Four Lean prototypes claimed more than they stated.** `Suggested.lean` now has a general
  approximation theorem with independent local targets and depths (with the ray-class case as a
  separate corollary), `primeToSubgroup` as a named subgroup with the reduction map and its
  kernel, named `IdeleCongruenceSubgroup` and `RaySubgroup` with their carriers written out (the
  principal-unit condition through the maximal ideal of `adicCompletionIntegers`, not through
  `Valued.v`), the ray class exact sequence as three maps with exactness at each interior spot
  plus `unitsCongruenceSubgroup` as its left-hand term, the class number formula, the narrow
  class group's kernel with its exponent and order, and `∃!` in both archimedean character
  classifications with the parity typed as `ZMod 2`.
- **The duplicate Frobenius target is gone.** The Layer 4 example no longer restates the
  `arithFrobAt`/`galEquivZMod` computation owned by Number Field Arithmetic. What it states is
  the ray class comparison this roadmap owns: `Cl_{(n)∞}(ℚ) ≃* Gal(ℚ(ζₙ)/ℚ)` sending the class
  of `(p)` to the automorphism that `galEquivZMod` carries to `[p]`.
- **The consumed declaration is named.** The conventions table and Layer 7 now name
  `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` from the current Number Field Arithmetic revision,
  and record that `J^{𝔪₀} ≤ J^S` for `𝔪₀` divisible by the ramified primes, so the map here is a
  restriction and not a second definition.
- **House rules from the root README.** `main` was merged in, and the roadmap was brought into
  line with the roadmap-writing principles it added: no references to the review or to branch
  operations, no item described as waiting on another roadmap's merge, and no Tau Ceti material
  described as destined for Mathlib. The root list is the alphabetical bullet list the
  `check_roadmap_areas.py` script maintains, and the two issue-template dropdowns were
  regenerated with it.

## Ownership and dependencies

- **Number Field Arithmetic owns the ideal-theoretic Artin symbol**: the abelian collapse, the
  map on ideals prime to the ramified set, multiplicativity, the restriction and tower formulas,
  and the cyclotomic identification of the arithmetic Frobenius with `[p]`. This roadmap
  consumes that object and owns the class field theory about it (factorization through a ray
  class group, kernel, surjectivity, agreement with the idelic map, conductor dependence,
  reciprocity, the classification by ideal groups). Layers 4, 6 and 7 are written to that
  boundary, and the splits-completely spelling uses that roadmap's `.ncard` convention.
- **Landing order.** This roadmap consumes [#1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  (Profinite Cohomology), [#2](https://github.com/roed-math/TauCetiRoadmap/pull/2) (Local
  Fields) and [#9](https://github.com/roed-math/TauCetiRoadmap/pull/9) (Number Field
  Arithmetic), so it should merge after them. When it does, the three pull-request links in the
  prerequisites table become `../ProfiniteCohomology/README.md`, `../LocalFields/README.md` and
  `../NumberFieldArithmetic/README.md`, and the consumed names should be checked against what
  actually landed. PR [#8](https://github.com/roed-math/TauCetiRoadmap/pull/8) (L-functions) is
  a consumer, not a prerequisite.

## External state (checked 2026-08-07)

| item | status |
|---|---|
| mathlib #40735 (idele class group) | open, head `ba5cc4688489`, updated 2026-08-05 |
| mathlib #40661 (Hilbert class field wanted statements) | open, head `184a5900ddc0`, updated 2026-07-16 |
| mathlib #36404 (local compactness of `𝔸_K`) | open, head `fca3a6af67b8`, updated 2026-03-21 |
| mathlib #36275 (finite-adele norm) | open, head `df510478253d`, updated 2026-07-29 |
| mathlib #40848 (S-integers) | open, head `1386a3f5a528`, updated 2026-08-05 |
| mathlib #40791 (S-unit theorem) | open, head `6c4013931e7a`, updated 2026-06-19 |
| mathlib #41591 (decomposition refactor) | open, head `9a76f0e50eee`, updated 2026-07-31 |
| mathlib #41765 (Dirichlet density) | **closed unmerged 2026-08-07**; L-functions territory either way |
| mathlib #42130 (instance transparency) | **closed unmerged 2026-08-06**, no longer tracked |
| kbuzzard/ClassFieldTheory | `ccc3323c6750`, top commit 2026-07-31; still no global Lean code |
| FLT | `d18b563029f3`; `AdeleRing.discrete`, `cocompact`, Fujisaki all sorry-free |
| mariainesdff/ideles | `b85d242f18cb`, unchanged since 2023-10-05 |
| TauCetiRoadmap #1 / #2 / #9 | open, heads `fd1c8cd1e473` / `df27e23c9d48` / `c39fbb4db655` |

No outreach was performed. Every provenance entry says so.

## Validation

**On GitHub**, at head `d5e421e`: the `build` check passes and `resolve` passes (`gate` is
skipped, as it is for every roadmap pull request). The pull request is mergeable. Rounds 1 and
2 had no Actions run at all, so their recorded results were local only; this is the first head
with a CI result.

**Locally**, in this branch at the repository pin:

- `lake build TauCetiRoadmap.GlobalClassFieldTheory.Suggested`: green, `sorry` warnings only.
- `lake build`: green, 8534 jobs, `sorry` warnings only.
- `python3 .github/scripts/check_roadmap_areas.py`: in sync (17 roadmaps).
- `git diff --check`: clean.
- The root README's ban on hedging words, grepped over `README.md` and `Suggested.lean`: no
  matches.
- Relative links resolve; one root-list entry and one aggregate import.
- The numerical claims in the worked examples (the class numbers and narrow class numbers of
  `ℚ(√2)` and `ℚ(√3)`, the Hilbert class fields of `ℚ(√−5)` and `ℚ(√−14)`, the ring class field
  for `x² + 27y²` and the order's Picard group, the three splitting criteria checked against all
  primes below 300, 400 and 600 respectively, and the biquadratic norm witness) were checked in
  Sage before being written into the roadmap. Round 3 added two more checks: the
  order-conductor formula against `n = 5, 8, 12, 14, 20, 27, 45` (order discriminant `−4n`,
  field discriminant, conductor, and maximality all as predicted), and the biquadratic claim
  that every local degree of `ℚ(√13, √17)/ℚ` is at most `2` (verified for every `p < 300`, with
  `13` and `17` each a square modulo the other).
