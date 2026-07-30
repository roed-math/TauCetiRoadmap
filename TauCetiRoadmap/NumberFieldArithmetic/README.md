# Roadmap: number fields — ramification, Frobenius, and the LMFDB invariants

Mathlib's number-field library is strong: rings of integers over a Dedekind base, the signed
discriminant with Brill's sign theorem and Hermite's finiteness theorem, finiteness of the class
group, Dirichlet's unit theorem with a regulator defined as a lattice covolume and the class
number formula at the residue of the Dedekind zeta function, the fundamental identity
`Σ eᵢ·fᵢ = n`, Hilbert's ramification theory through `D/I ≅ Gal(residue extension)`, the
Kummer–Dedekind factorization theorem with matching `e`'s and `f`'s over `ℤ`, the different
ideal *with* transitivity in towers, an arithmetic-Frobenius API, complete ramification theory
of infinite places, cyclotomic fields through their splitting law, and adeles with the product
formula. Unlike its sibling roadmaps, this one is therefore a **completion pass, not a
greenfield development**: the deliverable is a precise gap inventory and the API-shaping that
turns these strong but *disconnected* pieces into a library that can state and prove everything
on an [LMFDB number-field page](https://www.lmfdb.org/NumberField/) — the demand-side
specification for this roadmap. What is genuinely missing is the connective tissue: nothing
instantiates the Frobenius API for number fields (`Mathlib/RingTheory/Frobenius.lean` has zero
reverse dependencies at the pin), there is no Artin symbol, no cycle-type form of Dedekind's
theorem, no relative discriminant ideal, no exact tame/wild different exponents, no
Stickelberger congruence, no double-coset splitting law for non-Galois extensions, no
local–global dictionary at finite places (the infinite-place analogue is complete, the
finite-place one is absent), no monogenicity API, and no label semantics.

Suggested home: `TauCeti/NumberTheory/NumberField/` for the number-field-facing layers
(`Splitting/`, `Frobenius/`, `ArtinSymbol/`, `DedekindTheorem/`, `Different/`, `Conductor/`,
`LocalGlobal/`, `Subfield/`, `Monogenic/`, `LMFDB/`), with the Dedekind-generic halves in
`TauCeti/NumberTheory/RamificationInertia/` and `TauCeti/RingTheory/DedekindDomain/`, mirroring
the Mathlib paths that own each notion (and extending the TauCeti files that already live at
exactly these paths).

This roadmap is a coordinated neighbor of several others. It **consumes**
[local fields](../LocalFields/README.md) (roadmap in preparation) for the target vocabulary of
the global↔local dictionary of Layer 6 — completions at finite places are `LocalFields`
objects, and the bridging lemmas here are stated in that roadmap's conventions. It **supplies**
[polynomial Galois groups](../PolynomialGaloisGroups/README.md) (roadmap in preparation) with
its computational workhorse, the cycle-type form of **Dedekind's theorem** (Layer 3), and
Artin representations (a planned roadmap) with Frobenius
conjugacy classes and the conductor–discriminant reductions of Layer 5.
[Global class field theory](../GlobalClassFieldTheory/README.md) (roadmap in preparation) will
*prove* the abelian conductor–discriminant formula and the reciprocity behavior of the Artin
symbol whose ideal-theoretic statements are pinned here. The
[multiquadratic roadmap](../Multiquadratic/README.md) (merged; its Layers 1–2 are largely
landed in TauCeti) is a *content neighbor from below*: its prime-splitting law is the
`(ℤ/2)ⁿ`-instance of the uniform Frobenius API built here, and the TauCeti files it produced
(`NumberField/Frobenius.lean`, `SplitsCompletely.lean`, `Quadratic/Splitting.lean`,
`LegendreSymbol/Frobenius.lean`, `RamificationInertia/Galois.lean`) are consumed and
generalized here, never duplicated or modified (§What TauCeti already has). The completed
[effective-bounds roadmap](../../Completed/EffectiveBounds/README.md) supplies the effective
class-number/discriminant side consumed by the worked examples.

## Standing hypotheses

Two regimes, spelled out, never bundled into a new class.

- **Dedekind-generic regime** (Layers 1–4 wherever the mathematics is not about `ℚ`): Mathlib's
  AKLB setup — `A` a Dedekind domain with fraction field `K`, `L/K` a finite (separable where
  needed) extension, `B` the integral closure of `A` in `L`, spelled with the pin's own
  typeclasses (`[IsDedekindDomain A]`, `[IsFractionRing A K]`, `[IsIntegralClosure B A L]`,
  `[Module.Finite A B]`, `[Module.IsTorsionFree A B]`, `[IsScalarTower A K L]`, …), and residue
  hypotheses per statement (`[Algebra.IsSeparable (A ⧸ p) (B ⧸ P)]` or `[Finite (A ⧸ p)]`)
  exactly where the proof needs them. Do **not** assume finite residue fields in statements that
  hold without them; do not assume separability where the pin's own `sum_ramification_inertia`
  does without it.
- **Number-field regime** (the LMFDB-facing layers): `[Field K] [NumberField K]` with `𝓞 K`,
  Galois groups as `K ≃ₐ[ℚ] K` (or `L ≃ₐ[K] L`), primes presented as
  `Q : Ideal (𝓞 K)` with instance arguments `[Q.IsPrime]`, `[Q.LiesOver (Ideal.span {(p : ℤ)})]`,
  `[Fact p.Prime]` — the idiom of the landed TauCeti files. Concrete fields enter through a
  generator: `{θ : 𝓞 K}` with `(hmin : minpoly ℤ θ = …)` and
  `(hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)`, as in TauCeti's `Quadratic/Splitting.lean` — never
  a bespoke `QuadraticField`/`CubicField` structure.

⚠ Never assume `p ≠ 2` or `p` odd except where the mathematics demands it (quadratic-symbol
statements): the worked-example suite deliberately contains dyadic cases (splitting of `2` in
quadratic fields by `d mod 8`; `2` as a common index divisor) precisely to catch smuggled
oddness hypotheses. Never bake `K = ℚ` into a statement whose proof is uniform in the base;
the `ℚ`-versions are corollaries (TauCeti's `SplitsCompletely.lean` keeps its general-base form
`private` — Layer 1 publishes that shape).

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| Frobenius | **arithmetic**: `σ x ≡ x^q mod Q` with `q = Nat.card (A ⧸ Q.under A)` — exactly Mathlib's `AlgHom.IsArithFrobAt` / `IsArithFrobAt`; "Frobenius" unqualified always means arithmetic; the geometric Frobenius is its inverse and is always named `geometric`. Identical to the [LocalFields](../LocalFields/README.md) convention table row | `Mathlib/RingTheory/Frobenius.lean`; LocalFields Layer 2 |
| Frobenius at ramified primes | `IsArithFrobAt` is satisfiable at every prime with finite residue field, but is canonical only **modulo inertia** (`IsArithFrobAt.mul_inv_mem_inertia`); an unqualified "the Frobenius at `Q`" requires `Algebra.IsUnramifiedAt`; at ramified primes only the coset `σ·I(Q)` is spoken of | Layer 2 |
| Artin symbol | `(p, L/K) : ConjClasses (L ≃ₐ[K] L)`, defined for `p` unramified in `L`; the element `Frob Q` at a chosen prime is well defined (unramified), the class depends only on `p`. For abelian `L/K` the class collapses to an element and the symbol is a monoid hom on ideals prime to the ramified set | Layer 2 |
| decomposition group | `MulAction.stabilizer G Q` — Mathlib's spelling; **no rival named definition**. Inertia group: `Q.inertia G` (`Ideal.inertia`). Decomposition/inertia *fields*: the pin's `IsDecompositionField`/`IsInertiaField` classes, ⚠ slated for deprecation by mathlib PR [#41591](https://github.com/leanprover-community/mathlib4/pull/41591) in favor of ring-level `Ideal.IsDecompositionRing`/`IsInertiaRing` — follow that direction, flag affected milestones | `Mathlib/RingTheory/Ideal/Pointwise.lean`, `…/NumberTheory/RamificationInertia/HilbertTheory.lean`, PR #41591 |
| `e` and `f` | the pin's `Ideal.ramificationIdx p P` / `Ideal.inertiaDeg p P` (no ring-hom argument at this pin) and their Galois-constant versions `ramificationIdxIn`/`inertiaDegIn`. ⚠ Master swapped the definitions post-pin (`ramificationIdx'`→`ramificationIdx` #41234, `inertiaDeg'`→`inertiaDeg` #41325, 2026-06/07): on bump the unprimed names denote the localization/residue-field definitions. State milestones through characterizations robust to the swap (the agreement lemmas `ramificationIdx'_eq_ramificationIdx`, `inertiaDeg'_eq_inertiaDeg` are the bridge) | pin + mathlib PRs #41234/#41325 |
| splitting type | the multiset `{(e₁,f₁), …, (e_g,f_g)}`; "splits completely" is the count equation `(Ideal.primesOver (span {(p:ℤ)}) (𝓞 K)).ncard = finrank ℚ K` (TauCeti's landed convention — no new predicate); cycle types in `Equiv.Perm.cycleType` vocabulary, ⚠ which **omits fixed points**: partition-valued statements must add the `1`s back explicitly | TauCeti `SplitsCompletely.lean`; Layer 3 |
| discriminant, absolute | the signed `NumberField.discr K : ℤ`; its sign is a theorem (`NumberField.sign_discr`, Brill), never a convention. `|discr|` enters labels; the sign is recoverable from the signature | pin |
| discriminant, relative | a **new** ideal `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)` (Layer 4); never conflated with the signed integer — the reconciliation `relDiscr ℤ (𝓞 K) = span {discr K}` is a named lemma | Layer 4 |
| different | Mathlib's `differentIdeal A B : Ideal B` | `Mathlib/RingTheory/DedekindDomain/Different.lean` |
| conductor of an order | Mathlib's bare-namespace `conductor R x : Ideal S`; the number-field index invariant is `RingOfIntegers.exponent θ` (root namespace; the absNorm of the conductor's contraction), ⚠ **not** the ℤ-module index `[𝓞 K : ℤ[θ]]` — the two have the same prime divisors (a Layer-7 lemma), and only the index satisfies `disc(θ) = index² · discr K` | `Mathlib/RingTheory/Conductor.lean`, pin `Ideal/KummerDedekind.lean`; Layer 7 |
| completions at finite places | the pin's `v.adicCompletion K` for `v : HeightOneSpectrum (𝓞 K)`, with `FinitePlace K ≃ HeightOneSpectrum (𝓞 K)`; local-field structure is stated in the `IsNonarchimedeanLocalField`/`ValuativeRel` vocabulary — the class itself is already at the pin (`Mathlib/NumberTheory/LocalField/Basic.lean`, with DVR/finite-residue/completeness instances for abstract local fields), adopted by LocalFields; what is missing is the instance for `v.adicCompletion K`, which is Layer 6's milestone. ⚠ the pin's `adicCompletion` is `Valued`-based while `Valued` is slated for deprecation in favor of `ValuativeRel` (Zulip, Jiedong Jiang, 2026-03-23): Layer 6 states its instances so that the `Valued → ValuativeRel` migration is a refactor, not a re-proof | pin; LocalFields §Provenance |
| absolute values at finite places | the pin's `HeightOneSpectrum.adicAbv`, normalized by `absNorm v.asIdeal` — this **is** LocalFields' `‖x‖ = q^{−v(x)}` normalization; the agreement is a named Layer-6 lemma, and the product formula is the cross-check | pin `Completion/FinitePlace.lean`, `ProductFormula.lean` |
| LMFDB label | `d.r.|D|.i`: degree `d = finrank ℚ K`, `r = nrRealPlaces K`, `|D| = (discr K).natAbs`, and `i` the index in the LMFDB's canonical ordering of fields with the same `(d, r, |D|)`. The first three coordinates are theorems; the index `i` and the canonical defining polynomial are **data semantics** — predicates against a certified enumeration (finite by `NumberField.finite_of_discr_bdd`), with the certification interface aligned with C. Birkbeck's CertifyingInvariantsNF | Layer 8 |

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:" flags material that landed after
the pin, to be consumed on the next toolchain bump rather than rebuilt. This section is long
because the library really is this strong; the point of the inventory is that **none of the
gaps below it are guesses**.

- **Number fields and rings of integers:** `Mathlib/NumberTheory/NumberField/Basic.lean` —
  `NumberField`, `NumberField.RingOfIntegers` (`𝓞 K`) with `IsDedekindDomain (𝓞 K)`,
  `Module.Free ℤ (𝓞 K)`, `IsIntegralClosure (𝓞 K) ℤ K`, `RingOfIntegers.basis`,
  `NumberField.integralBasis`, `RingOfIntegers.rank`, the relative instances
  (`IsIntegralClosure (𝓞 L) (𝓞 K) L`), `Rat.ringOfIntegersEquiv : 𝓞 ℚ ≃+* ℤ`, closure
  properties (`of_module_finite`, instance `of_intermediateField`, `of_tower`), and the
  `MulSemiringAction G (𝓞 K)` instance for `G` acting on `K` — the plumbing Layer 2 needs.
- **Discriminants:** `Discriminant/Defs.lean` — the signed `NumberField.discr K : ℤ`
  (`Algebra.discr ℤ (RingOfIntegers.basis K)`), `discr_ne_zero`, base-change invariance;
  `Discriminant/Basic.lean` — **`NumberField.sign_discr : (discr K).sign = (-1) ^ nrComplexPlaces K`**
  (Brill's theorem — do not re-prove), `rootDiscr`, Minkowski's lower bounds `abs_discr_ge'`/
  `abs_discr_ge`, **`abs_discr_gt_two`** (Hermite–Minkowski, the `|d| > 1` input to "ℚ has no
  unramified extension"), and **Hermite's theorem `NumberField.finite_of_discr_bdd`** (the
  finiteness behind label enumeration). `Mathlib/RingTheory/Discriminant.lean` —
  `Algebra.discr b`, `Algebra.discr_powerBasis_eq_norm` (`disc = ± N(f′(θ))`),
  `discr_isIntegral`, `discr_mul_isIntegral_mem_adjoin`.
- **Units, regulator, torsion:** `Units/Basic.lean` — `isUnit_iff_norm`,
  `NumberField.Units.torsion` with `IsCyclic`, `torsionOrder`,
  **`rootsOfUnity_eq_torsion`**, `even_torsionOrder`; `Units/DirichletTheorem.lean` —
  `logEmbedding`, `unitLattice` (a `ZLattice`), `NumberField.Units.rank`,
  **`rank_modTorsion`** (Dirichlet's rank statement), `fundSystem`,
  **`exist_unique_eq_mul_prod`** (every unit is uniquely `ζ·∏ εᵢ^{nᵢ}`);
  `Units/Regulator.lean` — **`NumberField.Units.regulator := ZLattice.covolume (unitLattice K)`**,
  `regulator_pos`, `regulator_eq_det`, and the index formula
  **`regOfFamily_div_regulator`** (`R(u)/R = [𝓞ˣ : ⟨u⟩ ⊔ torsion]`).
- **Class group and class number:** `RingTheory/ClassGroup.lean`; `NumberField/ClassNumber.lean`
  — the finiteness instance `RingOfIntegers.instFintypeClassGroup`,
  `NumberField.classNumber`, **`classNumber_eq_one_iff : classNumber K = 1 ↔
  IsPrincipalIdealRing (𝓞 K)`** (the pin's idiom for `h = 1` statements),
  `exists_ideal_in_class_of_norm_le` (Minkowski bound), and the practical PID criteria
  (`isPrincipalIdealRing_of_abs_discr_lt`, `…_of_isPrincipal_of_mem_primesOver_of_mem_Icc`)
  that discharge the worked examples' `h = 1` targets. `Rat.classNumber_eq : classNumber ℚ = 1`
  is the **only** computed class number in the tree.
- **Dedekind zeta and the class number formula:** `DedekindZeta.lean` —
  `NumberField.dedekindZeta` (an `LSeries` over ideal counts), `dedekindZeta_residue`
  (`2^{r₁}(2π)^{r₂}hR/(w√|d|)`), and
  **`tendsto_sub_one_mul_dedekindZeta_nhdsGT`** — the Dirichlet class number formula as a
  one-sided real limit at `s = 1⁺`. ⚠ No Euler product, continuation, or functional equation:
  those are the [LFunctions](../LFunctions/README.md) sibling's (roadmap in preparation);
  this roadmap only *consumes* the residue as a worked-example cross-check.
- **Ramification and inertia, Dedekind-generic:** `Mathlib/NumberTheory/RamificationInertia/`
  — `Ramification.lean`/`Inertia.lean`: `Ideal.ramificationIdx p P` (an `sSup`),
  `Ideal.inertiaDeg p P` (junk `0` off the fiber) — ⚠ both carry "will eventually be replaced
  by `ramificationIdx'`/`inertiaDeg'`" notes, and master has already completed that swap (see
  the conventions table); `Basic.lean`: the CRT decomposition `S/pS ≅ ⊕ S/Pᵢ^{eᵢ}` and
  **`Ideal.sum_ramification_inertia`** (`Σ e·f = n`, `p` maximal ≠ ⊥, **no separability
  hypothesis**); `Galois.lean`: the `MulAction G (primesOver p B)`, **transitivity**
  (`exists_smul_eq_of_isGaloisGroup`, instance `isPretransitive_of_isGaloisGroup`), `e` and `f`
  Galois-constant, the well-defined `ramificationIdxIn`/`inertiaDegIn`,
  **`ncard_primesOver_mul_ramificationIdxIn_mul_inertiaDegIn`** (`g·e·f = #G`), tower
  multiplicativity, and the inertia counts `card_inertia_eq_ramificationIdxIn`,
  `card_stabilizer_eq` (`#D = e·f`, needs separable residue); `HilbertTheory.lean`:
  `IsDecompositionField`/`IsInertiaField` classes with all five degree formulas
  (`rank_left/right`, `rank_decompositionField`); `Unramified.lean`: the bridge
  `Algebra.isUnramifiedAt_iff_of_isDedekindDomain` (`e = 1 ↔ IsUnramifiedAt`, number-ring
  hypotheses); `Valuation.lean`: `e` against `HeightOneSpectrum` valuations. master:
  `Mathlib/RingTheory/RamificationInertia/Basic.lean` (#39189, tb65536, 2026-06-08) adds the
  finite-flat `Σ eᵢfᵢ` formula at ring level.
- **Decomposition-group machinery (the real one):** `Mathlib/RingTheory/Ideal/Pointwise.lean` —
  the pointwise `MulSemiringAction` on ideals, `Ideal.inertia_le_stabilizer`, normality of
  inertia in the stabilizer; `Mathlib/RingTheory/Ideal/Over.lean` — `Ideal.LiesOver`,
  `Ideal.under`, `Ideal.primesOver`, **`Ideal.Quotient.stabilizerHom : stabilizer G P →*
  ((B⧸P) ≃ₐ[A⧸p] (B⧸P))`** with `ker_stabilizerHom` (= inertia); ⚠ argument-order trap: `Over.lean`
  takes the top ideal first (`stabilizerHom P p G`), `Invariant/Basic.lean` names fibers the
  other way; `Mathlib/RingTheory/Invariant/Basic.lean` — `Algebra.IsInvariant`,
  `isInvariant_of_isGalois`, `orbit_eq_primesOver`, `IsFractionRing.stabilizerHom` (into
  `Gal(L/K)`) with **`stabilizerHom_surjective`** (both versions — the theorem that makes
  Frobenius exist), **`Ideal.Quotient.stabilizerQuotientInertiaEquiv : D/I ≅ Gal((B⧸Q)/(A⧸P))`**,
  `Ideal.Quotient.normal`, `finite_of_isInvariant`; `Invariant/Profinite.lean` —
  `stabilizerHom_surjective_of_profinite` (infinite Galois, no `Finite G`);
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` — the `IsGaloisGroup G A B` class **with the
  number-field instances `IsGaloisGroup G (𝓞 K) (𝓞 L)` and `IsGaloisGroup G ℤ (𝓞 L)`**;
  `Mathlib/RingTheory/IntegralClosure/IntegralRestrict.lean` — `galRestrict :
  Gal(L/K) ≃* (B ≃ₐ[A] B)`. ⚠ `Mathlib/RingTheory/Valuation/RamificationGroup.lean`
  (`ValuationSubring.decompositionSubgroup`/`inertiaSubgroup`, from M. Karatarakis's 2022 work)
  is a theorem-free stub disconnected from the ideal-theoretic API, with an explicit TODO for
  higher ramification groups — do not build on it; LocalFields owns its future.
- **Frobenius:** `Mathlib/RingTheory/Frobenius.lean` (A. Yang, 2025) — the arithmetic-Frobenius
  API in the invariant-ring setting: `AlgHom.IsArithFrobAt` (`φ x ≡ x^q mod Q`,
  `q = Nat.card (A ⧸ Q.under A)`), the residue restriction `IsArithFrobAt.restrict` with
  `restrict_apply` (`x ↦ x^q`), the roots-of-unity computation
  **`IsArithFrobAt.apply_of_pow_eq_one`** (`φ ζ = ζ^q`), **uniqueness at unramified primes at
  `AlgHom` level** (`eq_of_isUnramifiedAt`), the group-level `IsArithFrobAt R σ Q` with
  `mem_stabilizer`, **`mul_inv_mem_inertia`** (uniqueness mod inertia), `conj`, **existence**
  (`exists_of_isInvariant`, via `stabilizerHom_surjective` and the finite-field Frobenius),
  `exists_primesOver_isConj`, the global choice `arithFrobAt R G Q`, and
  **`isConj_arithFrobAt`** (conjugacy across the fiber). ⚠ **A leaf file: nothing in Mathlib
  imports it**; no number-field instantiation, no Artin symbol, no `σ = σ'` uniqueness in the
  group, no restriction-to-subextension lemma, no order formula — that is Layer 2.
  `Mathlib/FieldTheory/Finite/Basic.lean` — `FiniteField.frobeniusAlgEquivOfAlgebraic` (the
  residue Frobenius, with `orderOf_… = finrank` and cyclicity); `…/Finite/Extension.lean` —
  `FiniteField.exists_forall_apply_eq_pow` (every residue automorphism is a Frobenius power).
- **Kummer–Dedekind:** `Mathlib/NumberTheory/KummerDedekind.lean` — the conductor-avoiding
  factorization: `KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk`
  (factors of `pB` ≃ factors of `f mod p`, hypothesis `(conductor R x).comap (algebraMap R S)
  ⊔ I = ⊤`), multiplicity matching (`emultiplicity_factors_map_eq_emultiplicity`), the
  multiset equality, `Ideal.irreducible_map_of_irreducible_minpoly` (converse an explicit file
  TODO), and the span formula for each factor; `Mathlib/RingTheory/Conductor.lean` — bare
  `conductor R x` with `conductor_eq_top_iff_adjoin_eq_top`, `quotAdjoinEquivQuotMap`. Over
  `ℤ`: `NumberField/Ideal/KummerDedekind.lean` — `RingOfIntegers.exponent θ` with
  `exponent_eq_one_iff`/`not_dvd_exponent_iff`, `monicFactorsMod θ p`, and
  **`NumberField.Ideal.primesOverSpanEquivMonicFactorsMod`** with
  **`inertiaDeg_…_symm_apply`** (`fᵢ = deg` of the factor) and
  **`ramificationIdx_…_symm_apply`** (`eᵢ = multiplicity`) — Dedekind–Kummer with matching
  invariants, **but only for `𝓞 K / ℤ`**; the relative AKLB version does not exist.
- **The different ideal:** `Mathlib/RingTheory/DedekindDomain/Different.lean` —
  `Submodule.traceDual`, `FractionalIdeal.dual` (full involution API), `differentIdeal A B`,
  `differentIdeal_ne_bot`, **transitivity in towers IS at the pin**:
  `differentIdeal_eq_differentIdeal_mul_differentIdeal`
  (`𝔡_{C/A} = 𝔡_{C/B} · 𝔡_{B/A}·C`, with the fractional-ideal engine `dual_eq_dual_mul_dual`),
  **`conductor_mul_differentIdeal`** (`𝔣(x)·𝔡 = (f′(x))`, hence `𝔡 = (f′)` in the monogenic
  case), `aeval_derivative_mem_differentIdeal`, the tame-direction divisibility
  **`pow_sub_one_dvd_differentIdeal`** (`P^{e−1} ∣ 𝔡`), `dvd_differentIdeal_of_not_isSeparable`,
  and the ramification criterion **`not_dvd_differentIdeal_iff` / `dvd_differentIdeal_iff`**
  (`P ∣ 𝔡 ↔ ¬ Algebra.IsUnramifiedAt A P`; ⚠ root namespace, and ⚠ two lemmas are misspelled
  `differentialIdeal_le_iff`/`differentialIdeal_le_fractionalIdeal_iff`);
  `DedekindDomain/LinearDisjoint.lean` — different ideals under linear disjointness
  (`differentIdeal_eq_map_differentIdeal`, coprime-different compositum splitting);
  `Mathlib/RingTheory/Unramified/` — `Algebra.IsUnramifiedAt` (= formally unramified at the
  localization) with `isUnramifiedAt_iff_map_eq` (unramified ⟺ `e = 1` + separable residue).
  `NumberField/Discriminant/Different.lean` — the absolute reconciliations:
  **`NumberField.absNorm_differentIdeal`** (`N(𝔡_{K/ℚ}) = |discr K|`),
  `discr_mem_differentIdeal`, the absolute tower formula
  **`natAbs_discr_eq_absNorm_differentIdeal_mul_natAbs_discr_pow`**
  (`|d_L| = N(𝔡_{L/K})·|d_K|^{[L:K]}`), `discr_dvd_discr`, and
  **`not_dvd_discr_iff_forall_liesOver`** (`p ∤ discr K ↔` all primes over `p` unramified —
  ramified ⟺ divides the discriminant, over `ℚ`). master: `not_dvd_discr_iff_isUnramifiedIn`
  (#40951, xroblot, 2026-06-29) and `Algebra.IsUnramifiedIn` (#41323).
- **Cyclotomic fields:** `Mathlib/NumberTheory/Cyclotomic/` + `NumberField/Cyclotomic/` —
  `IsCyclotomicExtension` with `isGalois`/`isAbelianGalois`, `Rat.finrank = totient`, **ring of
  integers `ℤ[ζ]`** (`cyclotomicRing_isIntegralClosure`, `adjoinEquivRingOfIntegers`),
  **discriminants** (`IsCyclotomicExtension.Rat.discr`, `discr_prime`, `discr_prime_pow`,
  `natAbs_discr`), `IsCyclotomicExtension.autEquivPow` and **`Rat.galEquivZMod : Gal(K/ℚ) ≃*
  (ZMod n)ˣ`** with the restriction square `galEquivZMod_restrictNormal_apply`, **the full
  splitting law** (`NumberField/Cyclotomic/Ideal.lean`: total ramification at `p ∣ n` via
  `(1−ζ)`, `inertiaDeg_eq_of_not_dvd` = `orderOf (p : ZMod m)ˣ`,
  `ramificationIdx_eq_of_not_dvd = 1`, and the general `n = p^k·m` formulas), **the
  decomposition subgroup** `Rat.galEquivZMod_stabilizer` (`= ⟨[p]⟩ ⊆ (ℤ/n)ˣ` — ⚠ the subgroup
  only: no statement identifies a Frobenius *element*, see Layer 2), the character-theoretic
  Galois correspondence (`intermediateFieldEquivSubgroupChar`,
  `mem_…_iff_conductor_dvd`), torsion (`Rat.torsionOrder_eq`), and
  **`Rat.three_pid`/`five_pid`** (`h(ℚ(ζ₃)) = h(ℚ(ζ₅)) = 1`, as `IsPrincipalIdealRing`).
  `DirichletCharacter/` — `conductor`, `isPrimitive`, Gauss sums, orthogonality (with
  `Fintype (DirichletCharacter R n)`) — the character side of Layer 5's worked instances.
- **Infinite places, complete with ramification:** `InfinitePlace/Basic.lean` —
  `InfinitePlace`, `IsReal`/`IsComplex`, `mult`, `nrRealPlaces`/`nrComplexPlaces`,
  `card_add_two_mul_card_eq_rank` (`r₁ + 2r₂ = n`), `prod_eq_abs_norm`;
  `InfinitePlace/Ramification.lean` — the Galois action on infinite places,
  `IsUnramified`/`IsRamified` (ramified ⟺ complex over real), stabilizers of order ≤ 2,
  `IsUnramifiedAtInfinitePlaces`, and the infinite-place fundamental identity
  `unramifedPlacesOver_ncard_add_eq_finrank` (⚠ mathlib's own typo `unramifed` — quote
  verbatim); `TotallyRealComplex.lean` — `IsTotallyReal`/`IsTotallyComplex`,
  `maximalRealSubfield`; `CMField.lean` — `IsCMField` with `complexConj` (canonical complex
  conjugation, `orderOf_complexConj`, `StarRing`) — Layer 2's "Frobenius at a real place"
  consumes exactly this; `Completion/Ramification.lean` — `InfinitePlace.inertiaDeg` with
  `sum_inertiaDeg_eq_finrank` (the archimedean local-global identity — ⚠ its finite-place
  analogue is **absent**, Layer 6's first target).
- **Finite places, completions, adeles, product formula:** `Completion/FinitePlace.lean` —
  `NumberField.FinitePlace` with **`FinitePlace.equivHeightOneSpectrum`**, the normalized
  `HeightOneSpectrum.adicAbv` (by `absNorm`), `FinitePlace.norm_def`/`norm_lt_one_iff_mem`,
  `embedding v : K →+* adicCompletion K v`, `NormedField (adicCompletion K v)`,
  `IsDiscreteValuationRing (adicCompletionIntegers)`, finite mul-support, and `Module.Finite
  K_v L_w` under `LiesOver`; `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean` — the
  underlying `adicCompletion`/`adicCompletionIntegers`; `AdeleRing.lean`/`InfiniteAdeleRing.lean`
  — `NumberField.AdeleRing` (over a general Dedekind base pair), `ringEquiv_mixedSpace`,
  weak approximation at infinite places, `AdeleRing.principalSubgroup`;
  `ProductFormula.lean` — **`NumberField.prod_abs_eq_one`** (the product formula) and
  `FinitePlace.prod_eq_inv_abs_norm`. ⚠ No idele group, no finiteness/compactness statements —
  [GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md)'s territory, not here.
- **Canonical embedding, geometry of numbers:** `CanonicalEmbedding/` — `mixedEmbedding`,
  convex bodies, `minkowskiBound`, the fundamental cone, `NormLeOne` (feeding the ideal-count
  asymptotics `Ideal/Asymptotics.lean`) — consumed by EffectiveBounds and cited here only for
  the worked examples' class-number discharges.
- **Galois correspondence, generic:** `Mathlib/FieldTheory/Galois/Basic.lean` —
  `IsGalois.intermediateFieldEquivSubgroup` (the order-reversing lattice equivalence);
  `FieldTheory/Normal/` — `normalClosure`, `AlgEquiv.restrictNormal(Hom)` with surjectivity;
  `FieldTheory/PolynomialGaloisGroup.lean` — `Polynomial.Gal`, the transitive `galActionHom`
  into `Equiv.Perm (rootSet p E)` with `galActionHom_injective` — the permutation carrier for
  Dedekind's theorem (Layer 3); `Mathlib/GroupTheory/DoubleCoset.lean` — `DoubleCoset.Quotient`
  (the double-coset carrier for Layer 1's non-Galois splitting law).

### What is in motion elsewhere (checked 2026-07-30; coordinate, cite, do not fork)

Mathlib is actively consolidating exactly this area, with two authors working in visible
coordination; every overlapping milestone below carries a refactor-onto flag. (Method note:
mathlib merges via Bors, so merged PRs read `state: CLOSED` with a `[Merged by Bors]` title —
dates below are Bors merge dates.)

- **xroblot's Hilbert-theory wave** (all OPEN as of 2026-07-30): **#41591** — ring-level
  `Ideal.IsDecompositionRing`/`Ideal.IsInertiaRing` predicates, **deprecating the field-level
  `IsDecompositionField`/`IsInertiaField` API and its lemmas**; #35808 — splitting in the
  inertia ring (`f = 1` above, `e` below, unramified over the base); #35991/#36733 —
  decomposition/inertia fields of composita and subfields; #36843 — compositum of unramified
  extensions is unramified (+ totally-split version `ramificationIdx_inertiaDeg_sup_eq_one`);
  #37031 — `ℚ(ζ_m)` is the inertia field of `p` in `ℚ(ζ_{p^k m})`. Merged already: #35802
  (2026-06-08, splitting in the decomposition field — five days *after* the pin). Layer 1's
  corresponding milestones are **comparison-and-consume on landing**, not independent builds.
- **tb65536's inertia program**: merged — the `ramificationIdx`/`inertiaDeg` **definition
  swap** (#41234, #41325, plus ~8 switch-over PRs, 2026-06-29 – 07-04; see the conventions
  table), the `RingTheory/IsGaloisGroup/{Defs,Basic}` + `Invariant/Galois` reorg
  (#40928/#40942/#41071), low-level `Ideal.inertia` API (#40383 et al.),
  `InfinitePlace.mult_mul_finrank` (#41600); open — #40952/#40387/#40757 (inertia-subgroup
  monotonicity/quotients/smul), **#40955** ("Galois groups are generated by inertia subgroups",
  via Minkowski — the group-theoretic form of `ℚ` having no unramified extension), #41415
  (`absoluteGaloisGroup` functoriality), #41377/#41378/#41368/#41100 (generalization churn on
  the new definitions).
- **Adjacent open PRs**: xroblot #41180 (norm congruence at unramified primes), #37023
  (coprime discriminants ⇒ linearly disjoint), #40905 (compositum of abelian extensions);
  fbarroero #40848 (S-integers as localization); kedlaya #41911 (Artin–Schreier).
- **Null results worth recording** (searched 2026-07-30): **zero** open PRs on the
  conductor–discriminant formula or any ideal-theoretic conductor; **zero** on different-ideal
  transitivity beyond what the pin has (`Different.lean` untouched since the pin); **zero**
  extending `IsArithFrobAt` (no Artin-symbol PR; the only "Artin" hits are Artin–Schreier);
  **zero** on higher ramification groups. Layers 2–5's core builds collide with nothing
  in flight.
- **Zulip** (searched via the public archive 2026-07-30; the instance's anonymous REST API is
  disabled, so this sweep is the archive plus the sibling's audited threads): the
  decomposition-group-as-stabilizer convention was settled in
  [new members > "Working on Frobenius elements"](https://leanprover-community.github.io/archive/stream/113489-new-members/topic/Working.20on.20Frobenius.20elements.html)
  (M. Karatarakis, with Buzzard/Commelin/Topaz/Lezeau/Wieser/Dillies/Nuccio, 2022-07/08) — the
  origin of the `ValuationSubring.decompositionSubgroup` stub; **Chebotarev** is a declared
  onward goal of PrimeNumberTheoremAnd (Kontorovich–Tao, stream `#PrimeNumberTheorem+`,
  announced 2024-01) — consistent with this roadmap deliberately *not* owning any density
  statement (→ [LFunctions](../LFunctions/README.md)); the `Valued`-deprecation project
  (J. Jiang, 2026-03-23) and the `ValuativeRel` wave are tracked in the
  [LocalFields](../LocalFields/README.md) §Provenance and constrain Layer 6's instance
  statements as noted in the conventions table.

## What TauCeti already has (consume)

Audited at `TauCetiProject/TauCeti` HEAD, 2026-07-30. These files were authored under the
[Multiquadratic](../Multiquadratic/README.md) roadmap (Layers 1–2) and the completed
[EffectiveBounds](../../Completed/EffectiveBounds/README.md) roadmap; this roadmap consumes and
generalizes them — the quadratic statements become instances of the uniform API, and none of
them is modified.

- `TauCeti/NumberTheory/NumberField/Frobenius.lean` — `exists_isArithFrobAt(_of_liesOver)`
  (existence of `σ : K ≃ₐ[ℚ] K` with `IsArithFrobAt ℤ σ Q`, for `IsGalois ℚ K` — the
  base-`ℚ` instantiation of Mathlib's `exists_of_isInvariant`), and
  `isArithFrobAt_apply_sqrt(_eq_self_iff)` (`σ √d = (d/p)·√d`). Layer 2 generalizes existence
  to relative extensions `L/K` and builds the uniqueness/conjugacy-class layer on top.
- `TauCeti/NumberTheory/LegendreSymbol/Frobenius.lean` — the domain-generic
  `AlgHom.IsArithFrobAt.apply_sqrt` / `IsArithFrobAt.smul_sqrt` (already base-general);
  `LegendreSymbol/SquareClass.lean` — square-class invariance of Legendre data.
- `TauCeti/NumberTheory/NumberField/SplitsCompletely.lean` — splits-completely as the count
  equation, `ncard_primesOver_eq_finrank_iff` (`↔ e = f = 1`) and
  `…_iff_stabilizer_eq_bot` (`↔` trivial decomposition group), over `ℚ`. ⚠ The general-base
  form exists there but is `private`; Layer 1 publishes that shape (coordinate — do not
  re-derive).
- `TauCeti/NumberTheory/NumberField/Quadratic/Splitting.lean` —
  `ncard_primesOver_quadratic_iff` (odd `p ∤ d`: splits ⟺ `legendreSym p d = 1`), presented
  via `minpoly ℤ θ = X² − C d`. The Layer-3 relative Dedekind–Kummer API has this as its
  degree-2 corollary; the `p = 2` and `d ≡ 1 mod 4` cases it excludes are Layer 3/7 worked
  targets here.
- `TauCeti/NumberTheory/NumberField/IntegralSqrt.lean`, `Internal/QuadraticIntegralBasis.lean`
  — `integralSqrt` and the `{1, x}` quadratic integral basis; Layer 7 supplies the full
  `d mod 4`-sensitive `𝓞_{ℚ(√d)}` and generalizes.
- `TauCeti/NumberTheory/RamificationInertia/Galois.lean` —
  `ncard_primesOver_eq_natCard_iff_of_isGaloisGroup` (finite flat Galois extensions of
  domains). Layer 1's relative splitting dictionary extends this file.
- `TauCeti/NumberTheory/Multiquadratic/` — the sign-vector Galois theory
  (`signPattern`/`signHom`/`galoisGroupEquiv`), `MultiquadraticSplitting`, the
  prime-discriminant/`candidateGenusField` layer, and `Multiquadratic/Frobenius.lean`
  (`galoisGroupEquiv_frobenius`: Frobenius = Legendre sign vector) — the `(ℤ/2)ⁿ` instance of
  Layers 1–2; the boundary is: anything `(ℤ/2)ⁿ`-specific stays theirs, the uniform statements
  live here.
- `TauCeti/NumberTheory/EffectiveBounds/` + `GeometryOfNumbers/` — `abs_discr_le_of_basis_isIntegral`,
  `card_ideal_absNorm_le`, `classNumber_le_bound`, `units_sq_index_eq (= 2^{rank+1})`,
  `regulator_eq_one_of_rank_eq_zero`, `discr_cyclotomicField_four = -4`, the Hermite count —
  consumed by Layers 7–8 (the index formula of Layer 7 sharpens
  `abs_discr_le_of_basis_isIntegral` to an equation).
- Conventions the repo enforces (and this roadmap adopts): `TauCeti.*` namespaces mirroring
  Mathlib paths (bare Mathlib namespaces only when extending an existing Mathlib definition's
  API), the module system (`public import`/`public section`, `@[expose]` where needed),
  `Internal/` for shared non-headline helpers, dated `@[deprecated]` wrappers, provenance
  sections in module docstrings, and the presentation idioms recorded in
  §Standing hypotheses.

## What is missing (build here)

The connective tissue, in one list. A uniform Frobenius/Artin-symbol API over number fields
(number-field instantiation of `IsArithFrobAt`; group-level uniqueness at unramified primes;
the conjugacy-class-valued Artin symbol; the abelian collapse; order = `f`; behavior under
restriction and towers; the residue-field bridge; the cyclotomic and quadratic element
identifications; complex conjugation as the class at a real place). The relative Dedekind–Kummer
theorem with matching `e`/`f` (the pin has it only over `ℤ`), its converse-irreducibility TODO,
and **Dedekind's theorem** (factorization type = Frobenius cycle type, with the index-divisor
caveat, the common-index-divisor theory, and Dedekind's criterion). The relative discriminant
ideal with its tower formula and `relNorm`-of-different characterization; exact tame/wild
different exponents; Stickelberger's congruence; the index formula `disc(θ) = i(θ)²·d_K`; the
`Algebra.discr` tower formula and the `Polynomial.discr` link. The Artin-conductor bookkeeping
and both conductor–discriminant statements with their reduction to local data. The finite-place
local–global dictionary (`Σ [L_w:K_v] = n`, `[L_w:K_v] = e·f`, `D_P ≅ Gal(L_w/K_v)`,
different/conductor localization, `IsNonarchimedeanLocalField` instances on completions). The
double-coset splitting law for non-Galois extensions and totally-split-iff-in-the-closure. The
subfield-lattice packaging, monogenicity predicate and quadratic/cyclotomic/Dedekind examples.
LMFDB label semantics with a fully computed flagship suite. None of this exists upstream as
stated; every consumable fragment is cited above.

---

## The build, in layers

The ordering below is the dependency order, with two flagged back-edges (Layer 4's exact
wild exponents and Layer 5's `v_Q(𝔡) = Σ(#Gᵢ − 1)` both route through Layer 6's
completion bridge — the Ordering section spells the true DAG); as each layer makes the
next layer's types expressible, its milestones are added to `Suggested.lean` with `sorry`.

### Layer 1: the splitting dictionary (Hilbert theory, completed and relativized)

- **Publish the relative splitting criteria.** The general-base forms of TauCeti's
  splits-completely dictionary (count `= n` ⟺ `e = f = 1` ⟺ trivial decomposition group), for
  `L/K` finite (Galois where stated) over an arbitrary Dedekind base — publishing the shape
  that is `private` in `SplitsCompletely.lean`, in coordination with that file's authors.
  Alongside: `IsUnramifiedIn`-style predicates for finite sets of primes mirroring the pin's
  archimedean `IsUnramifiedAtInfinitePlaces` (master's `Algebra.IsUnramifiedIn`, #41323, is
  the seed — consume on bump).
- **The prime-in-subfield dictionary** (Neukirch I (9.3)/(9.6)): `e` and `f` of `P ∩ Z` and
  `P ∩ T` for the decomposition and inertia fields — `P` is the only prime of `L` over
  `P ∩ Z`; `e(P∩Z/p) = f(P∩Z/p) = 1`; `f(P∩T/P∩Z) = f`, `e(P∩T/P∩Z) = 1`; the inertia field
  is where `e` concentrates. ⚠ **Refactor-onto flag**: this is exactly xroblot's open wave
  (#35802 merged post-pin; #35808/#35991/#36733 open) on the ring-level predicates of #41591 —
  state these milestones, and convert them to comparison-and-consume when the wave lands.
- **The double-coset law for non-Galois splitting** (Neukirch I §9 p. 55, the "proof left to
  the reader"; genuinely absent upstream): for `M/K` Galois with group `G`, `L` the fixed
  field of `H ≤ G`, and `D = MulAction.stabilizer G Q` for a prime `Q` over `p`: the primes of
  `L` over `p` biject with `DoubleCoset.Quotient H D` via `HσD ↦ σQ ∩ L`; the invariant read-off
  `e(𝔮_σ/p)·f(𝔮_σ/p) = |HσD|/|H| = [σDσ⁻¹ : H ∩ σDσ⁻¹]`, refined to
  `e(𝔮_σ/p) = [σIσ⁻¹ : H ∩ σIσ⁻¹]` with `I = Q.inertia G`; the sanity identity
  `Σ_σ |HσD|/|H| = [L:K]` recovering the fundamental identity.
- **Totally split ⟺ totally split in the Galois closure** (Neukirch I §9 Ex. 4, via the
  double-coset law), and the compositum statements: `p` totally split in `L₁` and `L₂` ⟺ in
  `L₁L₂`; `p` unramified in both ⟹ unramified in the compositum. ⚠ **Refactor-onto**: the
  unramified-compositum half is open PR #36843.

### Layer 2: Frobenius elements and the Artin symbol

The pin has the entire engine (existence, conjugacy, uniqueness-mod-inertia, uniqueness at
unramified primes at `AlgHom` level) as a leaf file; this layer is the missing instantiation
and packaging. Everything is stated in `IsArithFrobAt` vocabulary — no rival definition.

- **Number-field and relative instantiation.** For `L/K` finite Galois (`IsGalois K L`) and
  `Q` a nonzero prime of `𝓞 L`: discharge the `IsArithFrobAt.exists_of_isInvariant`
  hypotheses once (`Finite Gal`, `Algebra.IsInvariant (𝓞 K) (𝓞 L) Gal`, `Finite (𝓞 L ⧸ Q)`
  — all derivable from pin instances) and provide `∃ σ : L ≃ₐ[K] L, IsArithFrobAt (𝓞 K) σ Q`
  — generalizing TauCeti's landed base-`ℚ` `exists_isArithFrobAt`. ⚠ The exponent is
  `Nat.card (𝓞 K ⧸ Q.under (𝓞 K))` — the **base** residue cardinality `N(p)`, not `N(Q)`;
  keep the TauCeti convention.
- **Group-level uniqueness at unramified primes.** Upgrade `AlgHom.IsArithFrobAt.eq_of_isUnramifiedAt`
  to `σ = τ` in the Galois group via faithfulness (`IsGaloisGroup.faithful`), giving
  `Subsingleton {σ // IsArithFrobAt (𝓞 K) σ Q}` at unramified `Q`; at ramified `Q` the honest
  statement is the pin's `mul_inv_mem_inertia` (the Frobenius **coset** mod `Q.inertia`), and
  the ramified convention of the table.
- **The Artin symbol.** `artinSymbol (p) : ConjClasses (L ≃ₐ[K] L)` for `p` unramified in `L`:
  well defined by `isConj_arithFrobAt` + uniqueness; `Frob (σ • Q) = σ (Frob Q) σ⁻¹`;
  **order** `orderOf (Frob Q) = f` and `Subgroup.zpowers (Frob Q) = MulAction.stabilizer` at
  unramified `Q` (from the pin's `card_stabilizer_eq`); the **residue bridge**:
  `Ideal.Quotient.stabilizerHom` sends `Frob Q` to `FiniteField.frobeniusAlgEquivOfAlgebraic`
  (closing the loop between `IsArithFrobAt.restrict` and the finite-field API).
- **Functoriality.** Restriction to subextensions: for `K ⊆ M ⊆ L` with `M/K` Galois,
  `IsArithFrobAt (𝓞 K) σ Q → IsArithFrobAt (𝓞 K) (σ.restrictNormal M) (Q.under (𝓞 M))`
  (nothing like it exists upstream; the cyclotomic `galEquivZMod_restrictNormal_apply` is the
  only restriction square in Mathlib and is not about Frobenius elements); the tower statement
  for `Frob` over an intermediate prime (`Frob_{L/M}(Q) = Frob_{L/K}(Q)^{f(Q∩M/p)}`); the
  compatibility of `artinSymbol` with `AlgEquiv.restrictNormalHom`.
- **The abelian collapse and the ideal-theoretic Artin map.** For abelian `L/K` the symbol is
  an element `((L/K)/p) ∈ Gal(L/K)`; extend multiplicatively to the monoid of ideals prime to
  the ramified set. Its reciprocity properties (kernel, surjectivity) are **not** stated here —
  the map and its formal multiplicativity are; [GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md)
  owns the rest. This is the interface boundary, chosen so that GCFT can state reciprocity
  against this object without refactoring it.
- **Computations.** Cyclotomic: `galEquivZMod n K (Frob Q) = ZMod.unitOfCoprime p hp` — the
  element identification the pin stops short of (both halves exist: `apply_of_pow_eq_one` and
  `galEquivZMod_apply_of_pow_eq`); quadratic: `Frob Q = 1 ↔ legendreSym p d = 1` under the
  `θ`-presentation (generalizing TauCeti's `isArithFrobAt_apply_sqrt_eq_self_iff` to the
  symbol level); **Frobenius at a real place**: for `w` a real place of `K` ramifying in `L`,
  the stabilizer has order 2 (pin) — name its generator (the complex conjugation over `w`,
  via `ComplexEmbedding.IsConj`; `IsCMField.complexConj` is the CM instance) and define the
  archimedean "Frobenius" class the LMFDB displays.
- **Profinite packaging** (later milestone, feeding the planned ArtinRepresentations roadmap):
  the Frobenius class at unramified `p` in `Gal(K̄/K)`-quotients through finite levels, on top
  of `stabilizerHom_surjective_of_profinite` — statement-level here, consumed there. ⚠ The
  pin's existence lemma requires `[Finite G]`; the profinite existence statement is part of
  this milestone, not assumed.

### Layer 3: Dedekind–Kummer and Dedekind's theorem

- **The relative Dedekind–Kummer theorem.** Generalize the pin's `𝓞 K/ℤ` package
  (`primesOverSpanEquivMonicFactorsMod` + `inertiaDeg`/`ramificationIdx` matching) to AKLB:
  for `θ` generating `L/K`, `p` coprime to `conductor A θ`: primes of `B` over `p` ≃ monic
  irreducible factors of `minpoly A θ mod p`, with `fᵢ = deg`, `eᵢ = multiplicity`, and the
  span formula. The general file's TODO (converse of
  `irreducible_map_of_irreducible_minpoly`) closes here. TauCeti's
  `ncard_primesOver_quadratic_iff` becomes the degree-2 corollary.
- **Dedekind's criterion** (Cohen, §6.1; the algorithmic test): for `p` and the factorization
  `f ≡ ∏ ḡᵢ^{eᵢ} mod p`, the criterion for `p ∤ [B : A[θ]]` in terms of
  `gcd(f̄, ḡ, (f − ∏ gᵢ^{eᵢ})/p)` — the practical monogenicity test at `p`, and the tool that
  certifies the worked examples' indices.
- **Dedekind's theorem (the named statement, for [PolynomialGaloisGroups](../PolynomialGaloisGroups/README.md)).**
  Suggested name: `TauCeti.NumberField.factorizationType_eq_cycleType_isArithFrobAt`. For
  `K = ℚ(θ)`, `f = minpoly ℤ θ`, `p ∤ RingOfIntegers.exponent θ` with `f mod p` squarefree,
  `M` the splitting field of `f`, and `σ` any Frobenius at a prime of `𝓞 M` over `p`: the
  multiset of degrees of the monic irreducible factors of `f mod p` equals the cycle type of
  `Polynomial.Gal.galActionHom f M σ` acting on the roots — as partitions of `n`. ⚠ Two traps
  pinned by convention: `Equiv.Perm.cycleType` omits fixed points (the statement adds
  `Multiset.replicate #fixed 1`); and the hypothesis is `p ∤ exponent θ` **plus** squarefreeness
  mod `p` (which forces `p` unramified in `K` but is *assumed*, not derived, at this layer —
  `p ∤ disc f` implies it and is the checkable form). Proof spine: Layer 1's double-coset law
  identifies primes of `K` over `p` with `⟨Frob⟩`-orbits on `H\G` = roots; the relative
  Dedekind–Kummer equivalence identifies primes with factors, matching `f`'s with orbit sizes.
- **Common index divisors** (the caveat made into theory). Definition: `p` is a common index
  divisor of `K` if `p ∣ [𝓞 K : ℤ[θ]]` for **every** generator `θ` of `K/ℚ` integral over
  `ℤ`. The counting obstruction (elementary direction, proved here): if the splitting type of
  `p` in `K` requires more monic irreducible polynomials of some degree `d` over `𝔽_p` than
  exist, then `p` is a common index divisor; hence `𝓞 K` is then non-monogenic. The converse
  (Hensel's criterion: common index divisors are *exactly* the primes whose splitting type is
  unrealizable mod `p`) is a definite later milestone in this layer, cited to Narkiewicz
  (§Still-wanted references). Worked example: `2` in `ℚ[x]/(x³ − x² − 2x − 8)` (Dedekind's
  field; Neukirch III §2 Ex. 1): `2` splits completely (three primes of residue degree 1) but
  `𝔽₂` has only two monic linear polynomials.

### Layer 4: the different and the relative discriminant

The pin's `Different.lean` is strong (transitivity included); this layer adds the discriminant
ideal it never defined and the exact exponents it stops short of.

- **The relative discriminant ideal.** `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)`
  with: multiplicativity in towers `relDiscr A C = (relDiscr A B)^{[M:L]} · relNorm A (relDiscr B C)`
  (Neukirch III (2.10), from the pin's different-transitivity + `relNorm` multiplicativity);
  localization; `P ∣ differentIdeal ↔ P ∩ A ∣ relDiscr`-side criteria (`p` ramified in `B` ⟺
  `p ∣ relDiscr A B`, Neukirch III (2.12), generalizing the pin's `ℚ`-only
  `not_dvd_discr_iff_forall_liesOver`); the absolute reconciliation
  `relDiscr ℤ (𝓞 K) = span {NumberField.discr K}` (against `absNorm_differentIdeal` and the
  sign from `sign_discr`); finiteness of the set of ramified primes (divisors of a nonzero
  ideal — the general-Dedekind statement, whose `ℚ`-corollary is one line from the pin but
  absent).
- **Exact tame/wild exponents** (Neukirch III (2.6); the pin has only `P^{e−1} ∣ 𝔡`):
  `v_P(𝔡) = e − 1` ⟺ tame (`ringChar (A⧸p) ∤ e`), and in the wild case
  `e ≤ v_P(𝔡) ≤ e − 1 + v_P(e)`. Route: localize–complete and compute over the completion
  (the Layer-6 dictionary + Eisenstein generators), or the semi-local direct argument — pin
  the completion route, since Layer 6 exists and [LocalFields](../LocalFields/README.md)
  Layer 3 states the local computation.
- **Discriminants of bases, connected.** The `Algebra.discr` tower formula
  (`disc_{M/K}(compatible bases) = disc_{L/K}^{[M:L]} · N(disc_{M/L})`); the link
  `Algebra.discr (powerBasis θ) = Polynomial.discr (minpoly θ)` (both exist upstream,
  unconnected); **Stickelberger's congruence** `discr K % 4 ∈ {0, 1}` (absent; classical,
  self-contained).
- ⚠ Scope note: the different of a *local* extension and `v(𝔡) = Σ (#Gᵢ − 1)` belong to
  LocalFields (its Layer 3); Layer 5 states the finite-level global filtration it needs, and
  the two meet through Layer 6's localization lemma — see the boundary in Layer 5.

### Layer 5: conductor–discriminant — statements and reductions

This layer owns the *statements and formal reductions*; the two proofs it cannot supply are
named, gated milestones for other roadmaps ([GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md)
for the abelian case, the planned ArtinRepresentations roadmap for the general
case and for integrality of the conductor exponents). Nothing here waits on them except the
final two bullets.

- **The finite-level ramification filtration, global spelling.** For `L/K` Galois, `Q` over
  `p`, define `G_i(Q) = {σ ∈ MulAction.stabilizer | ∀ x : 𝓞 L, σ x − x ∈ Q^{i+1}}` (so
  `G_{−1} = D`, `G_0 = Q.inertia` — reconciliation lemmas to the pin's `Ideal.inertia`), a
  finite decreasing chain of normal subgroups of `D`, eventually trivial. ⚠ This is the
  *finite, ideal-theoretic* object needed for conductor exponents; the local theory (Herbrand,
  upper numbering, Hasse–Arf) is LocalFields Layer 3's, and the comparison `G_i(Q) ≅ G_i` of
  the completed extension is a Layer-6 milestone. Also here:
  `v_Q(differentIdeal) = Σ_{i≥0} (#G_i(Q) − 1)` (Serre LF IV §1 Prop. 4), proved through the
  Layer-6 completion bridge — this is what makes Layer 4's exact exponents and this layer's
  bookkeeping meet.
- **Artin conductor exponents and the global conductor.** `f_p(χ) = Σ_{i≥0} (#G_i/#G_0)·(χ(1) − χ(G_i))`
  for a character `χ` of `Gal(L/K)` (values in ℚ a priori), the global
  `𝔣(χ) = ∏_p p^{f_p(χ)}` (finite product by the filtration's triviality at unramified
  primes); additivity in `χ`, behavior under induction and inflation (Neukirch VII (11.7),
  (11.8): `𝔡_{K'/K}`-twisted induction, `c(L|K, χ)` bookkeeping). **Integrality of `f_p(χ)`
  (Artin's theorem) is explicitly deferred** to ArtinRepresentations — statements here treat
  `f_p(χ) ∈ ℕ` as a hypothesis-or-milestone marker, never silently.
- **The conductor–discriminant formula, both statements.** General (Neukirch VII (11.9)):
  `relDiscr = ∏_χ 𝔣(χ)^{χ(1)}` over irreducible characters — *stated* here, its reduction to
  the per-`p` identity `v_p(relDiscr) = Σ_χ χ(1)·f_p(χ)` *proved* here (from Layer 4's
  `relDiscr = relNorm(𝔡)` and the `Σ(#G_i − 1)` formula, by character-orthogonality
  bookkeeping — this reduction is the actual mathematical content this roadmap owns); abelian
  (via Neukirch VI (6.4)/(6.5)-style local conductors): the specialization to 1-dimensional
  `χ`, handed to GCFT as its named target.
- **Worked instances, fully proved here** (no CFT needed): quadratic — `𝔣(χ_d) = (|discr K|)`
  for the quadratic character of `K = ℚ(√d)`, i.e. discriminant = conductor, including `p = 2`
  ⚠ (the `d mod 4` case split is the point); cyclotomic — for `K = ℚ(ζ_p)`:
  `∏_{χ mod p} cond(χ) = p^{p−2} = |discr K|` against the pin's `DirichletCharacter.conductor`
  and `IsCyclotomicExtension.Rat.discr_prime` (the pin has both sides and no bridge).

### Layer 6: the global ↔ local dictionary

Everything is stated in [LocalFields](../LocalFields/README.md)' vocabulary
(`IsNonarchimedeanLocalField`, their `v_K`/`‖·‖_K` normalizations, their `e`/`f`); their
Layer 0 reconciles the local objects with `Ideal.ramificationIdx` once — the *global* halves
of the reconciliation live here, and this is the single seam where the two roadmaps must
agree. Statement-level work can start as soon as their Layer 0's vocabulary exists; the
completion-side proofs consume their Layers 0–2.

- **Completions are local fields.** For `v : HeightOneSpectrum (𝓞 K)`:
  `IsNonarchimedeanLocalField (v.adicCompletion K)` — the class is the pin's
  (`Mathlib/NumberTheory/LocalField/Basic.lean`); the missing instance chain (from the
  pin's `NormedField`, DVR integers, and finite residue field) is the milestone — the residue-field
  identification `𝓀(K_v) ≅ 𝓞 K ⧸ v.asIdeal`, and the normalization dictionary: the pin's
  `adicAbv` (normalized by `absNorm`) **equals** LocalFields' `‖x‖ = q^{−v(x)}` — one named
  lemma, cross-checked by the product formula. ⚠ `Valued`-vs-`ValuativeRel` migration risk as
  pinned in the conventions table: state instances through the compatibility layer so the
  deprecation is a refactor.
- **Semi-local structure.** `L ⊗_K K_v ≅ ∏_{w ∣ v} L_w` (Neukirch II (8.3)), hence
  **`Σ_{w ∣ v} [L_w : K_v] = [L : K]`** — the finite-place analogue of the pin's archimedean
  `sum_inertiaDeg_eq_finrank`, absent upstream; the norm/trace compatibility
  `N_{L/K} = ∏_w N_{L_w/K_v}` (Neukirch II (8.4) — also the engine of the different
  localization below).
- **Invariant matching.** `[L_w : K_v] = e(w∣v) · f(w∣v)` with `e`, `f` the *global*
  `ramificationIdx`/`inertiaDeg` (their local `e·f = n` is LocalFields'; the equality of the
  two factor pairs is this milestone); `D_Q ≅ Gal(L_w/K_v)` (the canonical isomorphism of the
  decomposition group with the local Galois group, Neukirch II §9), carrying Frobenius to
  Frobenius (`IsArithFrobAt` ↦ LocalFields' Layer-2 Frobenius — the conventions already
  agree, this is the theorem making that a fact), and `G_i(Q) ≅ G_i(L_w/K_v)` at finite level
  (feeding Layer 5).
- **Different, discriminant, conductor localize.** `𝔡_{𝓞L/𝓞K} · 𝓞_{L_w} = 𝔡_{L_w/K_v}`
  (Neukirch III (2.2)(iii)); `v_p(relDiscr) = Σ_{w∣v}`-local data; conductor-exponent
  localization (Layer 5's `f_p(χ)` = the local Artin exponent of `χ|_{D}`).

### Layer 7: subfield lattices, integral bases, and monogenicity

- **The subfield dictionary.** Package `IsGalois.intermediateFieldEquivSubgroup` for number
  fields: for arbitrary `K` with Galois closure `M` (`normalClosure ℚ K M`), the lattice of
  subfields of `K` ↔ subgroups between `Gal(M/K)` and `Gal(M/ℚ)` (anti-isomorphism);
  counting statements; `Gal(M/ℚ) ↪ S_n` via `Polynomial.Gal.galActionHom` with transitivity ⟺
  irreducibility (consume; the classification of which transitive groups occur — the LMFDB
  `nTj` labels — is [PolynomialGaloisGroups](../PolynomialGaloisGroups/README.md)' and is not
  duplicated here). Worked targets: the three subfields of `ℚ(ζ₅)`; `3.1.23.1` has no proper
  subfield.
- **Integral bases and the index.** The ℤ-module index `i(θ) = [𝓞 K : ℤ[θ]]`
  (`Nat.card (𝓞 K ⧸ Algebra.adjoin ℤ {θ})`-style), with: `disc(minpoly θ) = i(θ)² · discr K`
  (the **index formula** — sharpening EffectiveBounds' `abs_discr_le_of_basis_isIntegral` to
  an equation); `p ∣ i(θ) ↔ p ∣ RingOfIntegers.exponent θ` (⚠ the two invariants differ in
  general — same prime support only; this reconciliation is what lets Layer 3's
  `exponent`-hypotheses be checked by discriminant arithmetic).
- **Monogenicity.** `IsMonogenic` for `𝓞 K` (`∃ θ, Algebra.adjoin ℤ {θ} = ⊤`, the pin's
  `exponent_eq_one_iff` as the working criterion); quadratic fields: `𝓞_{ℚ(√d)}` with the
  `d mod 4` case split (`ℤ[√d]` vs `ℤ[(1+√d)/2]`), `discr = d` or `4d` — generalizing
  TauCeti's `IntegralSqrt`/`QuadraticIntegralBasis` to the LMFDB-complete statement, with the
  `p = 2` splitting law by `d mod 8` as the acceptance test; cyclotomic monogenicity
  (consume the pin); **non-monogenicity of Dedekind's field** via Layer 3's common-index
  divisor.
- Relative integral bases and Steinitz classes: long horizon (below), flagged here because the
  LMFDB's relative extension data will eventually want them.

### Layer 8: LMFDB label semantics and the invariant suite

The label grammar and the flagship examples; each invariant on an LMFDB number-field page is
either a theorem from Layers 1–7/Mathlib, a sibling's named deliverable, or a data-semantic
predicate — nothing unaccounted.

- **The label predicate.** `IsLMFDBLabel K d r D i`: `finrank ℚ K = d ∧ nrRealPlaces K = r ∧
  (discr K).natAbs = D` plus the index-`i` clause as a certified-enumeration predicate (the
  finite set exists by `finite_of_discr_bdd`; the ordering and the canonical defining
  polynomial are data semantics with a certification interface — coordinate with C. Birkbeck's
  CertifyingInvariantsNF, which the modular-forms roadmap (#47) already uses at its Layer 9).
  Sign recovery `discr = (−1)^{(d−r)/2}·D` from `sign_discr`.
- **Page coverage map** (where each displayed invariant's mathematics lives): degree/signature/
  discriminant/root discriminant — Mathlib (consume); ramified primes — Layer 4; Galois group
  label — PolynomialGaloisGroups (interface: the `S_n`-embedding of Layer 7); class
  group/number — Mathlib + EffectiveBounds; narrow class group — defined by
  [Multiquadratic](../Multiquadratic/README.md) Layer 3 (consume, do not duplicate); unit
  rank/torsion/fundamental units/regulator — Mathlib (consume); zeta residue — Mathlib CNF
  (consume; continuation is LFunctions'); Frobenius/splitting tables — Layers 2–3; subfields —
  Layer 7; monogenicity/index — Layer 7; local algebras at ramified primes — Layer 6 +
  LocalFields.
- **The flagship suite** (the numbers are verified — see Worked examples; statements in
  `Suggested.lean` for four of the five, with the `2.0.4.1` section to be added alongside
  its dyadic Layer-4 milestone): `2.2.5.1`, `2.0.4.1`, `4.0.125.1`, `3.1.23.1`,
  `3.1.503.1`.

### Long horizon (direction, not this roadmap's deliverables)

Chebotarev-type density of Frobenius classes (→ [LFunctions](../LFunctions/README.md), on
PrimeNumberTheoremAnd's declared path); the absolute-Galois Frobenius formalism and Frobenius
characteristic polynomials (→ ArtinRepresentations, seeded by Layer 2's profinite milestone);
Hensel's realizability criterion completing Layer 3's common-index theory; relative integral
bases and Steinitz classes; power-integral-basis finiteness (Győry); arithmetic equivalence
and Gassmann triples (the LMFDB's "sibling fields" and "arithmetically equivalent" data);
the `Valued → ValuativeRel` migration of Layer 6's instances when mathlib completes the
deprecation.

## Worked examples (acceptance criteria)

Each catches a specific error class (wrong normalization, vacuous instance, smuggled
hypothesis, missing dyadic case). All numerics below were re-verified computationally for this
roadmap (splitting data by factorization mod `p`; discriminants by the cubic formula).

- **`2.2.5.1` = ℚ(√5)** (presentation: `θ` with `minpoly ℤ θ = X² − X − 1`): `discr = 5`,
  signature `(2,0)`, `classNumber = 1` (via the pin's `isPrincipalIdealRing_of_abs_discr_lt`
  route), `torsionOrder = 2`, `Units.rank = 1`, fundamental unit `θ` (the golden ratio),
  **`regulator = Real.log ((1 + √5)/2)`**, and the class-number-formula smoke test
  `dedekindZeta_residue = 2·log((1+√5)/2)/√5` — one equation crossing units, class number,
  discriminant, and the CNF normalization. Splitting: `p` splits ⟺ `p ≡ ±1 mod 5`
  (`legendreSym p 5 = 1` — quadratic reciprocity in action), `2` inert (`5 ≡ 5 mod 8`).
- **`2.0.4.1` = ℚ(i)**: `discr = −4` (⚠ sign: `(−1)^{r₂} = −1` — Brill instance), `ℤ[i]`
  monogenic with index 1; `2 = −i(1+i)²` ramified, `v(𝔡) = 2 = e` — the **wild** lower
  bound attained, with the upper bound `e − 1 + v(e) = 3` strict here (the dyadic case
  Layer 4's tame formula must not claim).
- **`4.0.125.1` = ℚ(ζ₅)** (`CyclotomicField 5 ℚ`): `discr = 125` (sign `+`: `r₂ = 2`),
  signature `(0,4)`, `classNumber = 1` (pin's `five_pid` — consume), `torsionOrder = 10`,
  `Units.rank = 1`, monogenic (`ℤ[ζ₅]`), Galois cyclic of order 4; Frobenius data:
  `f(p) = orderOf (p : ZMod 5)ˣ` — `2, 3, 7` inert (`f = 4`), `19` has `f = 2, g = 2`, `11`
  splits completely, `5` totally ramified via `(1 − ζ)⁴`; subfield lattice
  `{ℚ, ℚ(√5), ℚ(ζ₅)}` (cardinality 3 — the `C₄` subgroup lattice); conductor–discriminant
  instance `∏_{χ mod 5} cond(χ) = 1·5·5·5 = 125`.
- **`3.1.23.1`** (`minpoly = X³ − X² + 1`, `disc = −23` squarefree so index 1): signature
  `(1,1)`, `discr = −23`, non-Galois with `S₃` closure, `classNumber = 1`, unit `θ` fundamental
  (`N(θ) = −1`, `regulator = −log|θ| ≈ 0.2812`, real root `θ ≈ −0.7549`); splitting/cycle-type
  table (Dedekind's theorem instances): `2, 3` inert — cycle type `(3)`; `5, 7` type `(1,2)`;
  `23` ramified, type `(1²·1)` (`x ≡ 15, 16` mod 23, double root at 16); **`59` is the least
  totally split prime** — cycle type `(1,1,1)`, i.e. `Frob = 1`; no proper subfields. The
  density-1/6 statement for split primes is *deliberately absent* (Chebotarev → LFunctions).
- **`3.1.503.1` = Dedekind's field** (`minpoly = X³ − X² − 2X − 8`, `disc(f) = −2012 = −4·503`,
  `discr K = −503`, `i(θ) = 2`): `2` **splits completely** although `f mod 2 = x²(x+1)` —
  the index-divisor caveat as a worked theorem; `2` is a common index divisor; `𝓞 K` is
  **not monogenic** (`∀ θ', 2 ∣ exponent θ'`); Neukirch III §2 Ex. 1 is the citation anchor
  ("außerwesentliche Diskriminantenteiler").
- **Dyadic quadratic law** (Layer 7): for squarefree `d ≡ 1 mod 4` with `θ = (1+√d)/2`
  (`minpoly = X² − X + (1−d)/4`): `2` splits ⟺ `d ≡ 1 mod 8` — unreachable from the
  landed `X² − d` presentation (whose `exponent` is even here), which is the point.

## Ordering and parallelism

Layer 1 first (it is mostly consume-and-publish, plus the double-coset law). Layer 2 needs
Layer 1's dictionary; Layer 3 needs Layer 1 (double cosets) and Layer 2 (Frobenius) for the
cycle-type theorem, but its relative Dedekind–Kummer half needs neither and can run in
parallel with Layer 2. Layer 4 is independent of Layers 2–3 (pure `Different.lean`
completion) and can start immediately; its exact-exponent milestone waits on Layer 6's
bridge. Layer 5's filtration and bookkeeping need Layers 1 and 4; its two gated milestones
wait on GCFT/ArtinRepresentations and block nothing else. Layer 6 is statement-expressible
once LocalFields Layer 0 lands and proof-complete against their Layers 0–2; its seam lemmas
should be co-reviewed with that roadmap's authors. Layer 7 needs Layers 1–3; Layer 8
assembles everything and its flagship targets discharge alongside the layers that enable
them (each example names its layer above). The xroblot/tb65536 refactor-onto flags (Layers 1,
2) convert those milestones to comparison-and-consume as the PRs land — check PR state at
implementation time, not just at roadmap time.

## References

- J. Neukirch, *Algebraic Number Theory*, Springer 1999 — the primary source. Ch. I §2
  (integral bases, discriminants of bases), §8 (Dedekind extensions: (8.1)–(8.2) fundamental
  identity, **(8.3) Dedekind–Kummer via the conductor**, (8.4) finitely many ramified primes,
  (8.5) quadratic splitting, §8 Ex. 4–5 (Galois closure; the index form of (8.3))), §9
  (Hilbert theory: (9.1) transitivity, (9.2) decomposition group, the double-coset bijection
  (p. 55), (9.3)/(9.6) the `Z`/`T` dictionary, (9.4)–(9.5) `D/I ≅ Gal(κ)`, §9 Ex. 2 the
  Frobenius automorphism, Ex. 4 totally-split-iff-closure), §10 (cyclotomic: (10.2) `ℤ[ζ]`,
  (10.3) the splitting law); Ch. II §8 (extensions of valuations, (8.3)–(8.4) semi-local
  structure and norm/trace formulas), §9 (Galois theory of valuations = the global↔local
  decomposition dictionary); Ch. III §2 (the different: (2.1)–(2.2) definition/tower/
  **localization (2.2)(iii)**, (2.4)–(2.5) monogenic and gcd descriptions, (2.6) exact
  tame/wild exponents, (2.9) `𝔡 = N(𝔇)`, (2.10)–(2.12) discriminant tower and ramified ⟺
  divides, §2 Ex. 1 Dedekind's non-monogenic cubic); Ch. VII §11 (the Artin conductor:
  (11.7)–(11.8) functorialities, **(11.9) the conductor–discriminant formula**), §13 (density
  — cited only as the boundary with LFunctions).
- J.-P. Serre, *Local Fields*, GTM 67 — Ch. I §§4–7 (Dedekind decomposition), Ch. III (the
  different: localization and the monogenic case), Ch. IV §1 (ramification filtration;
  Prop. 4 `v(𝔡) = Σ(#Gᵢ − 1)` — Layer 5's spine), Ch. VI §2 (the Artin conductor `f(χ)`).
  The local side of every Layer-6 statement follows [LocalFields](../LocalFields/README.md)'
  reading of this book.
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110 — Ch. I (Dedekind theory, the
  decomposition group), Ch. III (the different and discriminant; alternative proofs of the
  Layer-4 material).
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7 — Ch. I (ramification, the
  Frobenius automorphism, double cosets — the cleanest textbook treatment of Layer 1's
  non-Galois law), Ch. II–III (units, class groups, cyclotomic fields).
- D. A. Marcus, *Number Fields*, 2nd ed. (library list — not held locally) — the
  worked-example goldmine: Ch. 2–3 (integral bases, the Dedekind–Kummer theorem, essential
  discriminant divisors — Dedekind's field appears in the Ch. 2–3 exercise track), Ch. 4
  (decomposition/inertia/Frobenius via exercises). Mathlib's own class-number-formula
  citation.
- H. Cohen, *A Course in Computational Algebraic Number Theory*, GTM 138 (library list) —
  §4.8/§6.1 (Dedekind's criterion, index computations, the algorithmic side of Layers 3
  and 7; the certification interfaces of Layer 8 align with its algorithms).
- W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers*, 3rd ed. (library
  list) — Ch. 4 (inessential discriminant divisors; Hensel's realizability criterion — the
  citation for Layer 3's later milestone).
- L. C. Washington, *Introduction to Cyclotomic Fields*, GTM 83 (library list) — Ch. 1–4
  (cyclotomic worked instances of Layers 2 and 5; the character-conductor dictionary).

## Provenance and coordination

- **Mathlib in motion** (§What is in motion): the xroblot Hilbert-theory wave
  (#41591/#35808/#35991/#36733/#36843/#37031; #35802 merged 2026-06-08) and the tb65536
  inertia program (#40955/#40387/#40952/#40757 open; the `ramificationIdx`/`inertiaDeg`
  definition swap #41234/#41325 merged 2026-06/07) overlap Layers 1–2's consume-and-publish
  milestones — every affected milestone above carries its flag, and the null-result list
  (no conductor, no Artin-symbol, no different-transitivity PRs) delimits where this roadmap
  builds free of collision. Re-audit PR state when each layer starts.
- **TauCeti landed files** (§What TauCeti already has): authored under the Multiquadratic and
  EffectiveBounds roadmaps; the consume-and-generalize contract per file is spelled there.
  Where a landed file keeps a general form `private` (`SplitsCompletely.lean`), publishing it
  is a Layer-1 milestone to be done in coordination, not a fork.
- **[Multiquadratic](../Multiquadratic/README.md)** (merged): the boundary is
  "`(ℤ/2)ⁿ`-specific stays there, uniform lives here" — its splitting law and sign-vector
  Frobenius are instances of Layers 1–2; its Layer 3 owns the narrow class group and genus
  field, which Layer 8's page-coverage map consumes; nothing here re-proves or re-states its
  targets.
- **[LocalFields](../LocalFields/README.md)** (in preparation): the conventions table adopts
  its Frobenius row verbatim; Layer 6 is the seam — the `adicAbv`-normalization lemma, the
  `e·f` matching, the `D ≅ Gal(L_w/K_v)` isomorphism, and the different-localization lemma
  are the four statements both roadmaps must recognize; co-review them there. Its Layer-0
  "`primesOver` is a singleton for local fields" bridging lemma is theirs; the semi-local
  `Σ [L_w:K_v] = n` is ours.
- **[GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md)** (in preparation):
  receives the ideal-theoretic Artin map (Layer 2's abelian collapse) as its stated-here
  interface object, and owes back the abelian conductor–discriminant proof (Layer 5's gated
  milestone) and the reciprocity properties deliberately not stated here.
- **[PolynomialGaloisGroups](../PolynomialGaloisGroups/README.md)** (in preparation):
  consumes Layer 3's named Dedekind theorem in `Polynomial.Gal.galActionHom` vocabulary and
  Layer 7's `S_n`-embedding; owns resolvents, transitive-group classification, and the `nTj`
  label semantics.
- **ArtinRepresentations** (planned roadmap): consumes
  Layer 2's profinite Frobenius packaging and Layer 5's conductor bookkeeping; owes back
  `f_p(χ)`-integrality and the general conductor–discriminant proof.
- **[EffectiveBounds](../../Completed/EffectiveBounds/README.md)** (completed): its bounds
  discharge the worked examples' class-number targets; Layer 7's index formula sharpens its
  discriminant inequality to an equation (a new statement, not a modification).
- **FLT / kbuzzard-ClassFieldTheory**: `Mathlib/RingTheory/Frobenius.lean` (A. Yang) is
  FLT-adjacent infrastructure, and the `erd1/LCFT` local-CFT interface normalizes its Artin
  map at arithmetic Frobenius via `IsArithFrobAt` (see LocalFields §What is in motion) —
  Layer 2's packaging must stay translation-compatible with that shape, which the shared
  `IsArithFrobAt` vocabulary guarantees by construction.
- **Zulip**: threads audited 2026-07-30 as cited in §What is in motion; the instance's
  anonymous API is disabled, so decision-critical claims should be re-confirmed in `#maths`
  when the corresponding layer starts, per the root README's claims process (register an
  intention before Layers 2 and 5–6 in particular).
