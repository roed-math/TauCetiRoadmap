# Roadmap: number fields, ramification, Frobenius, and the LMFDB invariants

Mathlib's number-field library is strong: rings of integers over a Dedekind base, the signed
discriminant with Brill's sign theorem and Hermite's finiteness theorem, finiteness of the class
group, Dirichlet's unit theorem with a regulator defined as a lattice covolume and the class
number formula at the residue of the Dedekind zeta function, the fundamental identity
`Σ eᵢ·fᵢ = n`, Hilbert's ramification theory through `D/I ≅ Gal(residue extension)`, the
Kummer–Dedekind factorization theorem with matching `e`'s and `f`'s over `ℤ`, the different
ideal with transitivity in towers, an arithmetic-Frobenius API, complete ramification theory of
infinite places, cyclotomic fields through their splitting law, and adeles with the product
formula.

Unlike its sibling roadmaps, this one is a completion pass rather than a greenfield
development. What it produces is a precise gap inventory together with the API shaping that
turns those strong but disconnected pieces into a usable theory of the **core intrinsic
arithmetic invariants of a number field, and the relations among them**: degree and signature;
the discriminant and the primes that ramify; how a prime splits, and its Frobenius class; the
different and the relative discriminant; integral bases, the index, and monogenicity;
subfields; units, torsion, and the regulator. An
[LMFDB number-field page](https://www.lmfdb.org/NumberField/) is the demand-side specification
for that list: Layer 8 says, datum by datum, which page entries are theorems proved here, which
are a sibling roadmap's named target, and which are database semantics this roadmap does not
certify at all. The two main exclusions are the label's `.i` coordinate and the choice of a
normalized defining polynomial; neither follows from Hermite finiteness, and no claim of full
page coverage is made anywhere below.

What is absent upstream is not depth but the connections between the pieces. Nothing
instantiates the Frobenius API for number fields (`Mathlib/RingTheory/Frobenius.lean` has zero
reverse dependencies at the pin). There is no Artin symbol, no cycle-type form of Dedekind's
theorem, no relative Dedekind–Kummer theorem, no relative discriminant ideal, no exact tame or
wild different exponent, no Stickelberger congruence, no double-coset splitting law for
non-Galois extensions, no local–global dictionary at finite places (the infinite-place analogue
is complete, the finite-place one is missing entirely), no monogenicity predicate, no
certificate that a named unit generates the units modulo torsion, and no label semantics.

Suggested home: `TauCeti/NumberTheory/NumberField/` for the number-field-facing layers
(`Splitting/`, `Frobenius/`, `ArtinSymbol/`, `DedekindTheorem/`, `Index/`, `Different/`,
`LocalGlobal/`, `Subfield/`, `Monogenic/`, `Units/`, `LMFDB/`), with the Dedekind-generic halves
in `TauCeti/NumberTheory/RamificationInertia/` and `TauCeti/RingTheory/DedekindDomain/`,
mirroring the Mathlib paths that own each notion and extending the TauCeti files that already
live at exactly these paths.

Four sibling roadmaps supply or consume named theorems here. §Cross-roadmap dependencies gives
the exact list, milestone by milestone; the short version is that
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) owns all local
ramification theory and this roadmap owns the comparison of global ideal-theoretic invariants
with it, [Polynomial Galois Groups PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10)
consumes Layer 3's Dedekind theorem,
[Global Class Field Theory PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) consumes
Layer 2's ideal-theoretic Artin map and supplies the narrow class group and the abelian
conductor–discriminant formula, and the merged
[multiquadratic roadmap](../Multiquadratic/README.md) supplies the `(ℤ/2)ⁿ` special case of
Layers 1–2.

## Standing hypotheses

Two regimes, spelled out, never bundled into a new class.

- **Dedekind-generic regime** (Layers 1–4 wherever the mathematics is not about `ℚ`): Mathlib's
  AKLB setup, with `A` a Dedekind domain with fraction field `K`, `L/K` a finite (separable
  where needed) extension, and `B` the integral closure of `A` in `L`, spelled with the pin's
  own typeclasses (`[IsDedekindDomain A]`, `[IsFractionRing A K]`, `[IsIntegralClosure B A L]`,
  `[Module.Finite A B]`, `[Module.IsTorsionFree A B]`, `[IsScalarTower A K L]`, …), and residue
  hypotheses per statement (`[Algebra.IsSeparable (A ⧸ p) (B ⧸ P)]` or `[Finite (A ⧸ p)]`)
  exactly where the proof needs them. Do **not** assume finite residue fields in statements that
  hold without them; do not assume separability where the pin's own `sum_ramification_inertia`
  does without it.
- **Number-field regime** (the LMFDB-facing layers): `[Field K] [NumberField K]` with `𝓞 K`,
  Galois groups as `K ≃ₐ[ℚ] K` (or `L ≃ₐ[K] L`), primes presented as `Q : Ideal (𝓞 K)` with
  instance arguments `[Q.IsPrime]`, `[Q.LiesOver (Ideal.span {(p : ℤ)})]`, `[Fact p.Prime]`,
  which is the idiom of the landed TauCeti files. Concrete fields enter through a generator:
  `{θ : 𝓞 K}` with `(hmin : minpoly ℤ θ = …)` and `(hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)`, as
  in TauCeti's `Quadratic/Splitting.lean`, never a bespoke `QuadraticField`/`CubicField`
  structure.

⚠ Never assume `p ≠ 2` or `p` odd except where the mathematics demands it (quadratic-symbol
statements). The worked-example suite deliberately contains dyadic cases (splitting of `2` in
quadratic fields by `d mod 8`; `2` as a common index divisor) precisely to catch smuggled
oddness hypotheses. Never bake `K = ℚ` into a statement whose proof is uniform in the base; the
`ℚ`-versions are corollaries. TauCeti's `SplitsCompletely.lean` keeps its general-base form
`private`, and Layer 1 publishes that shape.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| Frobenius | **arithmetic**: `σ x ≡ x^q mod Q` with `q = Nat.card (A ⧸ Q.under A)`, exactly Mathlib's `AlgHom.IsArithFrobAt` / `IsArithFrobAt`; "Frobenius" unqualified always means arithmetic; the geometric Frobenius is its inverse and is always named `geometric`. Identical to the [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) convention table row | `Mathlib/RingTheory/Frobenius.lean`; LocalFields Layer 2 |
| Frobenius at ramified primes | `IsArithFrobAt` is satisfiable at every prime with finite residue field, but is canonical only **modulo inertia** (`IsArithFrobAt.mul_inv_mem_inertia`); an unqualified "the Frobenius at `Q`" requires `Algebra.IsUnramifiedAt`; at ramified primes only the coset `σ·I(Q)` is spoken of | Layer 2 |
| Frobenius is a finite-level notion | every Frobenius statement in this roadmap lives in a **finite** Galois extension, or in the quotient `D_v/I_v ≅ Gal(k̄_v/k_v)`. There is no canonical Frobenius element or conjugacy class in `Gal(K̄/K)`: a lift to `D_v` is well defined only up to inertia, and compatible classes in the finite quotients do not assemble into one. Nothing here claims otherwise | Layer 2; §Explicit scope exclusions |
| infinite places | the canonical element of the order-2 stabilizer at a real place ramifying in `L` is **complex conjugation** (`ComplexEmbedding.IsConj`, `IsCMField.complexConj`), and is never called a Frobenius. `IsRamified`/`IsUnramified` at infinite places are the pin's | `Mathlib/.../InfinitePlace/Ramification.lean`, `CMField.lean` |
| Artin symbol | `artinSymbol 𝔭 : ConjClasses (L ≃ₐ[K] L)` for a nonzero prime `𝔭 : Ideal (𝓞 K)` unramified in `L`. The element `Frob Q` at a chosen `Q ∣ 𝔭` is well defined (unramified case), and the class depends only on `𝔭`. The rational-prime form for `K = ℚ` is a corollary, not the definition | Layer 2 |
| ideal-theoretic Artin map | for finite abelian `L/K` with `S` the (finite) set of primes of `𝓞 K` dividing `relDiscr (𝓞 K) (𝓞 L)`, `J^S` is the subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of fractional ideals whose support avoids `S`, and `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` sends a prime to its Artin symbol. **Same carrier as [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6)'s `J^{𝔪₀}`**, so that its reciprocity layers consume this map literally. The integral-ideal monoid hom is a corollary of it | Layer 2; PR #6 conventions table |
| decomposition group | `MulAction.stabilizer G Q`, Mathlib's spelling; **no rival named definition**. Inertia group: `Q.inertia G` (`Ideal.inertia`). Decomposition/inertia *fields*: the pin's `IsDecompositionField`/`IsInertiaField` classes, ⚠ slated for deprecation by mathlib PR [#41591](https://github.com/leanprover-community/mathlib4/pull/41591) in favor of ring-level `Ideal.IsDecompositionRing`/`IsInertiaRing`; follow that direction and flag affected milestones | `Mathlib/RingTheory/Ideal/Pointwise.lean`, `…/NumberTheory/RamificationInertia/HilbertTheory.lean`, PR #41591 |
| ramification groups, indexing | the higher groups are a family `G i` indexed by `i : ℕ`, so `G 0` is inertia; the decomposition group keeps its own name (`MulAction.stabilizer`) and is never written `G (-1)`. Where a statement genuinely needs the `−1` slot, it names the stabilizer explicitly | Layer 6 |
| `e` and `f` | the pin's `Ideal.ramificationIdx p P` / `Ideal.inertiaDeg p P` (no ring-hom argument at this pin) and their Galois-constant versions `ramificationIdxIn`/`inertiaDegIn`. ⚠ Master swapped the definitions post-pin (`ramificationIdx'`→`ramificationIdx` #41234, `inertiaDeg'`→`inertiaDeg` #41325, 2026-06/07): on bump the unprimed names denote the localization/residue-field definitions. State milestones through characterizations robust to the swap (the agreement lemmas `ramificationIdx'_eq_ramificationIdx`, `inertiaDeg'_eq_inertiaDeg` are the comparison) | pin + mathlib PRs #41234/#41325 |
| splitting type | the multiset `{(e₁,f₁), …, (e_g,f_g)}`; "splits completely" is the count equation `(Ideal.primesOver (span {(p:ℤ)}) (𝓞 K)).ncard = finrank ℚ K` (TauCeti's landed convention, no new predicate); cycle types in `Equiv.Perm.cycleType` vocabulary, ⚠ which **omits fixed points**: partition-valued statements must add the `1`s back explicitly | TauCeti `SplitsCompletely.lean`; Layer 3 |
| discriminant, absolute | the signed `NumberField.discr K : ℤ`; its sign is a theorem (`NumberField.sign_discr`, Brill), never a convention. `\|discr\|` enters labels; the sign is recoverable from the signature | pin |
| discriminant, relative | a **new** ideal `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)` (Layer 4), never conflated with the signed integer; the reconciliation `relDiscr ℤ (𝓞 K) = span {discr K}` is a named lemma | Layer 4 |
| different | Mathlib's `differentIdeal A B : Ideal B` | `Mathlib/RingTheory/DedekindDomain/Different.lean` |
| valuation of an ideal at a prime | `v_P(I) := multiplicity P I` for `P` a nonzero prime of a Dedekind domain, matching the pin's `finprod_heightOneSpectrum_pow_multiplicity` normalization. Every exponent formula in Layers 4–6 is stated in this one normalization, including `v_P(e)` for a natural number `e`, which means the multiplicity of `P` in `span {(e : B)}` | Layers 4, 6 |
| conductor | the only conductor this roadmap forms is Mathlib's bare-namespace **order conductor** `conductor R x : Ideal S`, used by Kummer–Dedekind, together with the number-field invariant `RingOfIntegers.exponent θ` (root namespace; the `absNorm` of the conductor's contraction). No Artin conductor object, and no general conductor exponent `f_𝔭(χ)`, is defined anywhere in this roadmap | `Mathlib/RingTheory/Conductor.lean`, pin `Ideal/KummerDedekind.lean`; Layers 3, 6 |
| the power-basis index | `RingOfIntegers.exponent θ` is ⚠ **not** the `ℤ`-module index `[𝓞 K : ℤ[θ]]`; the two have the same prime divisors (a Layer-3 lemma), and only the index satisfies `disc(minpoly θ) = index² · discr K`. To keep the index free of junk values, it is defined on a subtype `IntegralPrimitiveElement K` of integral generators, never by a raw `Nat.card` on all of `𝓞 K` (Layer 3) | Layer 3 |
| completions at finite places | the pin's `v.adicCompletion K` for `v : HeightOneSpectrum (𝓞 K)`, with `FinitePlace K ≃ HeightOneSpectrum (𝓞 K)`; local-field structure is stated in the `IsNonarchimedeanLocalField`/`ValuativeRel` vocabulary. The class itself is already at the pin (`Mathlib/NumberTheory/LocalField/Basic.lean`, with DVR, finite-residue and completeness instances for abstract local fields), adopted by LocalFields; what is missing is the instance for `v.adicCompletion K`, which is Layer 5's milestone. ⚠ the pin's `adicCompletion` is `Valued`-based while `Valued` is slated for deprecation in favor of `ValuativeRel` (Zulip, Jiedong Jiang, 2026-03-23): Layer 5 states its instances so that the `Valued → ValuativeRel` migration is a refactor, not a re-proof | pin; LocalFields §Provenance |
| the completion of an extension | for `w ∣ v`, the algebra structure of `L_w` over `K_v` is the **canonical** one, constructed in Layer 5 as the unique continuous `K_v`-algebra structure compatible with `L/K`. ⚠ The pin's own `Module.Finite K_v L_w` instance instead quantifies over an arbitrary `[Algebra K_v L_w] [ContinuousSMul K_v L_w] [IsScalarTower K K_v L_w]`; no theorem in this roadmap does that, since accepting arbitrary structure would let a statement be about the wrong extension | Layer 5 |
| absolute values at finite places | the pin's `HeightOneSpectrum.adicAbv`, normalized by `absNorm v.asIdeal`, which **is** LocalFields' `‖x‖ = q^{−v(x)}` normalization; the agreement is a named Layer-5 lemma, and the product formula is the cross-check | pin `Completion/FinitePlace.lean`, `ProductFormula.lean` |
| LMFDB intrinsic label prefix | `d.r.\|D\|`: degree `d = finrank ℚ K`, `r = nrRealPlaces K`, and `\|D\| = (discr K).natAbs`. These three coordinates are intrinsic theorems. The database index `i` and the canonical defining polynomial are deliberately not part of the API: Hermite finiteness alone supplies neither the LMFDB ordering key nor a completeness/deduplication certificate. A full label such as `2.2.5.1` is used below only as an external name for a field, never as a certified output | Layer 8 |

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:" flags material that landed after
the pin, to be consumed on the next toolchain bump rather than rebuilt. This section is long
because the library really is this strong; the point of the inventory is that **none of the
gaps below it are guesses**.

- **Number fields and rings of integers:** `Mathlib/NumberTheory/NumberField/Basic.lean` has
  `NumberField`, `NumberField.RingOfIntegers` (`𝓞 K`) with `IsDedekindDomain (𝓞 K)`,
  `Module.Free ℤ (𝓞 K)`, `IsIntegralClosure (𝓞 K) ℤ K`, `RingOfIntegers.basis`,
  `NumberField.integralBasis`, `RingOfIntegers.rank`, the relative instances
  (`IsIntegralClosure (𝓞 L) (𝓞 K) L`), `Rat.ringOfIntegersEquiv : 𝓞 ℚ ≃+* ℤ`, closure
  properties (`of_module_finite`, instance `of_intermediateField`, `of_tower`), and the
  `MulSemiringAction G (𝓞 K)` instance for `G` acting on `K`, which is the plumbing Layer 2
  needs.
- **Discriminants:** `Discriminant/Defs.lean` has the signed `NumberField.discr K : ℤ`
  (`Algebra.discr ℤ (RingOfIntegers.basis K)`), `discr_ne_zero`, base-change invariance.
  `Discriminant/Basic.lean` has
  **`NumberField.sign_discr : (discr K).sign = (-1) ^ nrComplexPlaces K`** (Brill's theorem; do
  not re-prove), `rootDiscr`, Minkowski's lower bounds `abs_discr_ge'`/`abs_discr_ge`,
  **`abs_discr_gt_two`** (Hermite–Minkowski, the `|d| > 1` input to "ℚ has no unramified
  extension"), and **Hermite's theorem `NumberField.finite_of_discr_bdd`**, the finiteness
  behind label enumeration. `Mathlib/RingTheory/Discriminant.lean` has `Algebra.discr b`,
  `Algebra.discr_powerBasis_eq_norm` (`disc = ± N(f′(θ))`), `discr_isIntegral`,
  `discr_mul_isIntegral_mem_adjoin`.
- **Units, regulator, torsion:** `Units/Basic.lean` has `isUnit_iff_norm`,
  `NumberField.Units.torsion` with `IsCyclic`, `torsionOrder`, **`rootsOfUnity_eq_torsion`**,
  `even_torsionOrder`. `Units/DirichletTheorem.lean` has `logEmbedding`, `unitLattice` (a
  `ZLattice`), `NumberField.Units.rank`, **`rank_modTorsion`** (Dirichlet's rank statement),
  `fundSystem`, **`exist_unique_eq_mul_prod`** (every unit is uniquely `ζ·∏ εᵢ^{nᵢ}`), and
  **`closure_fundSystem_sup_torsion_eq_top`**. `Units/Regulator.lean` has
  **`NumberField.Units.regulator := ZLattice.covolume (unitLattice K)`**, `regulator_pos`,
  `regulator_eq_det`, `regOfFamily_eq_det`, and the index formula
  **`regOfFamily_div_regulator`**
  (`regOfFamily u / regulator K = (Subgroup.closure (Set.range u) ⊔ torsion K).index`).
  ⚠ Nothing upstream certifies that a *particular* unit generates modulo torsion; that is
  Layer 7's explicit-unit milestone, and without it no exact regulator value can be claimed.
- **Bounded-conjugate finiteness:** `InfinitePlace/Embeddings.lean` has
  **`NumberField.Embeddings.finite_of_norm_le`**
  (`{x : K | IsIntegral ℤ x ∧ ∀ φ : K →+* A, ‖φ x‖ ≤ B}.Finite`) and `pow_eq_one_of_norm_eq_one`
  (Kronecker). This is the finiteness that turns "no unit lies strictly between `1` and `u`"
  into a finite check, and it is the proof method Layer 7 names.
- **Class group and class number:** `RingTheory/ClassGroup.lean` and
  `NumberField/ClassNumber.lean` have the finiteness instance
  `RingOfIntegers.instFintypeClassGroup`, `NumberField.classNumber`,
  **`classNumber_eq_one_iff : classNumber K = 1 ↔ IsPrincipalIdealRing (𝓞 K)`** (the pin's
  idiom for `h = 1` statements), `exists_ideal_in_class_of_norm_le` (Minkowski bound), and the
  practical PID criteria (`isPrincipalIdealRing_of_abs_discr_lt`,
  `…_of_isPrincipal_of_mem_primesOver_of_mem_Icc`) that discharge the worked examples' `h = 1`
  targets. `Rat.classNumber_eq : classNumber ℚ = 1` is the **only** computed class number in
  the tree.
- **Dedekind zeta and the class number formula:** `DedekindZeta.lean` has
  `NumberField.dedekindZeta` (an `LSeries` over ideal counts), `dedekindZeta_residue`
  (`2^{r₁}(2π)^{r₂}hR/(w√|d|)`), and **`tendsto_sub_one_mul_dedekindZeta_nhdsGT`**, the
  Dirichlet class number formula as a one-sided real limit at `s = 1⁺`. ⚠ No Euler product, no
  continuation, no functional equation: those are the
  [L-functions PR #8](https://github.com/roed-math/TauCetiRoadmap/pull/8) sibling's, and this
  roadmap only *consumes* the residue as a worked-example cross-check.
- **Ramification and inertia, Dedekind-generic:** `Mathlib/NumberTheory/RamificationInertia/`.
  `Ramification.lean`/`Inertia.lean`: `Ideal.ramificationIdx p P` (an `sSup`),
  `Ideal.inertiaDeg p P` (junk `0` off the fiber); ⚠ both carry "will eventually be replaced by
  `ramificationIdx'`/`inertiaDeg'`" notes, and master has already completed that swap (see the
  conventions table). `Basic.lean`: the CRT decomposition `S/pS ≅ ⊕ S/Pᵢ^{eᵢ}` and
  **`Ideal.sum_ramification_inertia`** (`Σ e·f = n`, `p` maximal ≠ ⊥, **no separability
  hypothesis**). `Galois.lean`: the `MulAction G (primesOver p B)`, **transitivity**
  (`exists_smul_eq_of_isGaloisGroup`, instance `isPretransitive_of_isGaloisGroup`), `e` and `f`
  Galois-constant, the well-defined `ramificationIdxIn`/`inertiaDegIn`,
  **`ncard_primesOver_mul_ramificationIdxIn_mul_inertiaDegIn`** (`g·e·f = #G`), tower
  multiplicativity, and the inertia counts `card_inertia_eq_ramificationIdxIn`,
  `card_stabilizer_eq` (`#D = e·f`, needs separable residue). `HilbertTheory.lean`:
  `IsDecompositionField`/`IsInertiaField` classes with all five degree formulas
  (`rank_left/right`, `rank_decompositionField`). `Unramified.lean`: the comparison
  `Algebra.isUnramifiedAt_iff_of_isDedekindDomain` (`e = 1 ↔ IsUnramifiedAt`, number-ring
  hypotheses). `Valuation.lean`: `e` against `HeightOneSpectrum` valuations. master:
  `Mathlib/RingTheory/RamificationInertia/Basic.lean` (#39189, tb65536, 2026-06-08) adds the
  finite-flat `Σ eᵢfᵢ` formula at ring level.
- **Decomposition-group machinery (the real one):** `Mathlib/RingTheory/Ideal/Pointwise.lean`
  has the pointwise `MulSemiringAction` on ideals, `Ideal.inertia_le_stabilizer`, and normality
  of inertia in the stabilizer. `Mathlib/RingTheory/Ideal/Over.lean` has `Ideal.LiesOver`,
  `Ideal.under`, `Ideal.primesOver`, **`Ideal.Quotient.stabilizerHom : stabilizer G P →*
  ((B⧸P) ≃ₐ[A⧸p] (B⧸P))`** with `ker_stabilizerHom` (= inertia); ⚠ argument-order trap:
  `Over.lean` takes the top ideal first (`stabilizerHom P p G`), `Invariant/Basic.lean` names
  fibers the other way. `Mathlib/RingTheory/Invariant/Basic.lean` has `Algebra.IsInvariant`,
  `isInvariant_of_isGalois`, `orbit_eq_primesOver`, `IsFractionRing.stabilizerHom` (into
  `Gal(L/K)`) with **`stabilizerHom_surjective`** (both versions, the theorem that makes
  Frobenius exist), **`Ideal.Quotient.stabilizerQuotientInertiaEquiv : D/I ≅ Gal((B⧸Q)/(A⧸P))`**,
  `Ideal.Quotient.normal`, `finite_of_isInvariant`. `Invariant/Profinite.lean` has
  `stabilizerHom_surjective_of_profinite` (infinite Galois, no `Finite G`).
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` has the `IsGaloisGroup G A B` class **with the
  number-field instances `IsGaloisGroup G (𝓞 K) (𝓞 L)` and `IsGaloisGroup G ℤ (𝓞 L)`**.
  `Mathlib/RingTheory/IntegralClosure/IntegralRestrict.lean` has
  `galRestrict : Gal(L/K) ≃* (B ≃ₐ[A] B)`. ⚠ `Mathlib/RingTheory/Valuation/RamificationGroup.lean`
  (`ValuationSubring.decompositionSubgroup`/`inertiaSubgroup`, from M. Karatarakis's 2022 work)
  is a theorem-free stub disconnected from the ideal-theoretic API, with an explicit TODO for
  higher ramification groups; do not build on it, and LocalFields owns its future.
- **Frobenius:** `Mathlib/RingTheory/Frobenius.lean` (A. Yang, 2025) has the arithmetic-Frobenius
  API in the invariant-ring setting: `AlgHom.IsArithFrobAt` (`φ x ≡ x^q mod Q`,
  `q = Nat.card (A ⧸ Q.under A)`), the residue restriction `IsArithFrobAt.restrict` with
  `restrict_apply` (`x ↦ x^q`), the roots-of-unity computation
  **`IsArithFrobAt.apply_of_pow_eq_one`** (`φ ζ = ζ^q`), **uniqueness at unramified primes at
  `AlgHom` level** (`eq_of_isUnramifiedAt`), the group-level `IsArithFrobAt R σ Q` with
  `mem_stabilizer`, **`mul_inv_mem_inertia`** (uniqueness mod inertia), `conj`, **existence**
  (`exists_of_isInvariant`, via `stabilizerHom_surjective` and the finite-field Frobenius),
  `exists_primesOver_isConj`, the global choice `arithFrobAt R G Q`, and **`isConj_arithFrobAt`**
  (conjugacy across the fiber). ⚠ **A leaf file: nothing in Mathlib imports it.** No
  number-field instantiation, no Artin symbol, no `σ = σ'` uniqueness in the group, no
  restriction-to-subextension lemma, no order formula; that is Layer 2.
  `Mathlib/FieldTheory/Finite/Basic.lean` has `FiniteField.frobeniusAlgEquivOfAlgebraic` (the
  residue Frobenius, with `orderOf_… = finrank` and cyclicity); `…/Finite/Extension.lean` has
  `FiniteField.exists_forall_apply_eq_pow` (every residue automorphism is a Frobenius power).
- **Kummer–Dedekind:** `Mathlib/NumberTheory/KummerDedekind.lean` has the conductor-avoiding
  factorization `KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk` (factors of
  `pB` ≃ factors of `f mod p`, hypothesis
  `(conductor R x).comap (algebraMap R S) ⊔ I = ⊤`), multiplicity matching
  (`emultiplicity_factors_map_eq_emultiplicity`), the multiset equality,
  `Ideal.irreducible_map_of_irreducible_minpoly` (converse an explicit file TODO), and the span
  formula for each factor. `Mathlib/RingTheory/Conductor.lean` has the bare `conductor R x` with
  `conductor_eq_top_iff_adjoin_eq_top`, `quotAdjoinEquivQuotMap`. Over `ℤ`:
  `NumberField/Ideal/KummerDedekind.lean` has `RingOfIntegers.exponent θ` with
  `exponent_eq_one_iff`/`not_dvd_exponent_iff`, `monicFactorsMod θ p`, and
  **`NumberField.Ideal.primesOverSpanEquivMonicFactorsMod`** with **`inertiaDeg_…_symm_apply`**
  (`fᵢ = deg` of the factor) and **`ramificationIdx_…_symm_apply`** (`eᵢ = multiplicity`), so
  Dedekind–Kummer with matching invariants, **but only for `𝓞 K / ℤ`**; the relative AKLB
  version does not exist.
- **The different ideal:** `Mathlib/RingTheory/DedekindDomain/Different.lean` has
  `Submodule.traceDual`, `FractionalIdeal.dual` (full involution API), `differentIdeal A B`,
  `differentIdeal_ne_bot`, and **transitivity in towers, which IS at the pin**:
  `differentIdeal_eq_differentIdeal_mul_differentIdeal`
  (`𝔡_{C/A} = 𝔡_{C/B} · 𝔡_{B/A}·C`, with the fractional-ideal machinery `dual_eq_dual_mul_dual`);
  **`conductor_mul_differentIdeal`** (`𝔣(x)·𝔡 = (f′(x))`, hence `𝔡 = (f′)` in the monogenic
  case), `aeval_derivative_mem_differentIdeal`, the tame-direction divisibility
  **`pow_sub_one_dvd_differentIdeal`** (`P^{e−1} ∣ 𝔡`), `dvd_differentIdeal_of_not_isSeparable`,
  and the ramification criterion **`not_dvd_differentIdeal_iff` / `dvd_differentIdeal_iff`**
  (`P ∣ 𝔡 ↔ ¬ Algebra.IsUnramifiedAt A P`; ⚠ root namespace, and ⚠ two lemmas are misspelled
  `differentialIdeal_le_iff`/`differentialIdeal_le_fractionalIdeal_iff`).
  `DedekindDomain/LinearDisjoint.lean` has different ideals under linear disjointness
  (`differentIdeal_eq_map_differentIdeal`, coprime-different compositum splitting).
  `Mathlib/RingTheory/Unramified/` has `Algebra.IsUnramifiedAt` (formally unramified at the
  localization) with `isUnramifiedAt_iff_map_eq` (unramified ⟺ `e = 1` plus separable residue).
  `NumberField/Discriminant/Different.lean` has the absolute reconciliations:
  **`NumberField.absNorm_differentIdeal`** (`N(𝔡_{K/ℚ}) = |discr K|`), `discr_mem_differentIdeal`,
  the absolute tower formula
  **`natAbs_discr_eq_absNorm_differentIdeal_mul_natAbs_discr_pow`**
  (`|d_L| = N(𝔡_{L/K})·|d_K|^{[L:K]}`), `discr_dvd_discr`, and
  **`not_dvd_discr_iff_forall_liesOver`** (`p ∤ discr K ↔` all primes over `p` unramified, so
  ramified ⟺ divides the discriminant, over `ℚ`). master:
  `not_dvd_discr_iff_isUnramifiedIn` (#40951, xroblot, 2026-06-29) and `Algebra.IsUnramifiedIn`
  (#41323).
- **Cyclotomic fields:** `Mathlib/NumberTheory/Cyclotomic/` and `NumberField/Cyclotomic/` have
  `IsCyclotomicExtension` with `isGalois`/`isAbelianGalois`, `Rat.finrank = totient`, **the ring
  of integers `ℤ[ζ]`** (`cyclotomicRing_isIntegralClosure`, `adjoinEquivRingOfIntegers`),
  **discriminants** (`IsCyclotomicExtension.Rat.discr`, `discr_prime`, `discr_prime_pow`,
  `natAbs_discr`), `IsCyclotomicExtension.autEquivPow` and
  **`Rat.galEquivZMod : Gal(K/ℚ) ≃* (ZMod n)ˣ`** with the restriction square
  `galEquivZMod_restrictNormal_apply`, **the full splitting law**
  (`NumberField/Cyclotomic/Ideal.lean`: total ramification at `p ∣ n` via `(1−ζ)`,
  `inertiaDeg_eq_of_not_dvd` = `orderOf (p : ZMod m)ˣ`, `ramificationIdx_eq_of_not_dvd = 1`, and
  the general `n = p^k·m` formulas), **the decomposition subgroup**
  `Rat.galEquivZMod_stabilizer` (`= ⟨[p]⟩ ⊆ (ℤ/n)ˣ`; ⚠ the subgroup only, since no statement
  identifies a Frobenius *element*, see Layer 2), the character-theoretic Galois correspondence
  (`intermediateFieldEquivSubgroupChar`, `mem_…_iff_conductor_dvd`), torsion
  (`Rat.torsionOrder_eq`), and **`Rat.three_pid`/`five_pid`**
  (`h(ℚ(ζ₃)) = h(ℚ(ζ₅)) = 1`, as `IsPrincipalIdealRing`). `DirichletCharacter/` has `conductor`,
  `isPrimitive`, Gauss sums, and orthogonality (with `Fintype (DirichletCharacter R n)`); it is
  the character side of the conductor–discriminant cross-checks, which
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) owns and this roadmap only cites.
- **Infinite places, complete with ramification:** `InfinitePlace/Basic.lean` has
  `InfinitePlace`, `IsReal`/`IsComplex`, `mult`, `nrRealPlaces`/`nrComplexPlaces`,
  `card_add_two_mul_card_eq_rank` (`r₁ + 2r₂ = n`), `prod_eq_abs_norm`.
  `InfinitePlace/Ramification.lean` has the Galois action on infinite places,
  `IsUnramified`/`IsRamified` (ramified ⟺ complex over real), stabilizers of order ≤ 2,
  `IsUnramifiedAtInfinitePlaces`, and the infinite-place fundamental identity
  `unramifedPlacesOver_ncard_add_eq_finrank` (⚠ mathlib's own typo `unramifed`; quote verbatim).
  `TotallyRealComplex.lean` has `IsTotallyReal`/`IsTotallyComplex`, `maximalRealSubfield`.
  `CMField.lean` has `IsCMField` with `complexConj` (canonical complex conjugation,
  `orderOf_complexConj`, `StarRing`), which is exactly the element Layer 2 names at a ramified
  real place. `Completion/Ramification.lean` has `InfinitePlace.inertiaDeg` with
  `sum_inertiaDeg_eq_finrank`, the archimedean local–global identity; ⚠ its finite-place
  analogue is **absent**, and is Layer 5's first target.
- **Finite places, completions, adeles, product formula:** `Completion/FinitePlace.lean` has
  `NumberField.FinitePlace` with **`FinitePlace.equivHeightOneSpectrum`**, the normalized
  `HeightOneSpectrum.adicAbv` (by `absNorm`), `FinitePlace.norm_def`/`norm_lt_one_iff_mem`,
  `embedding v : K →+* adicCompletion K v`, `NormedField (adicCompletion K v)`,
  `IsDiscreteValuationRing (adicCompletionIntegers)`, finite mul-support, and
  `Module.Finite K_v L_w` under `LiesOver`; ⚠ that last instance takes an *arbitrary* compatible
  algebra structure as input, so it is not yet a statement about the canonical extension (see
  the conventions table and Layer 5). `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean` has
  the underlying `adicCompletion`/`adicCompletionIntegers`.
  `AdeleRing.lean`/`InfiniteAdeleRing.lean` have `NumberField.AdeleRing` (over a general Dedekind
  base pair), `ringEquiv_mixedSpace`, weak approximation at infinite places, and
  `AdeleRing.principalSubgroup`. `ProductFormula.lean` has **`NumberField.prod_abs_eq_one`** (the
  product formula) and `FinitePlace.prod_eq_inv_abs_norm`. ⚠ No idele group, no
  finiteness/compactness statements: that is
  [Global Class Field Theory PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6)'s
  territory, not this roadmap's.
- **Canonical embedding, geometry of numbers:** `CanonicalEmbedding/` has `mixedEmbedding`,
  convex bodies, `minkowskiBound`, the fundamental cone, and `NormLeOne` (feeding the ideal-count
  asymptotics of `Ideal/Asymptotics.lean`), consumed by EffectiveBounds and cited here only for
  the worked examples' class-number discharges.
- **Galois correspondence, generic:** `Mathlib/FieldTheory/Galois/Basic.lean` has
  `IsGalois.intermediateFieldEquivSubgroup` (the order-reversing lattice equivalence).
  `FieldTheory/Normal/` has `normalClosure`, `AlgEquiv.restrictNormal(Hom)` with surjectivity.
  `FieldTheory/PolynomialGaloisGroup.lean` has `Polynomial.Gal`, the transitive `galActionHom`
  into `Equiv.Perm (rootSet p E)` with `galActionHom_injective`, which is the permutation carrier
  for Dedekind's theorem (Layer 3). `Mathlib/GroupTheory/DoubleCoset.lean` has
  `DoubleCoset.Quotient`, the carrier for Layer 1's non-Galois splitting law.

### What is in motion elsewhere (refreshed 2026-08-01; coordinate, cite, do not fork)

Mathlib is actively consolidating exactly this area, with two authors working in visible
coordination; every overlapping milestone below carries a refactor-onto flag. (Method note:
mathlib merges via Bors, so merged PRs read `state: CLOSED` with a `[Merged by Bors]` title, and
the dates below are Bors merge dates.)

- **xroblot's Hilbert-theory wave:** **#41591** remains open at head
  `9a76f0e50eee06c57a752295f05f00e98ae29ee3` as of 2026-08-01, adding ring-level
  `Ideal.IsDecompositionRing`/`Ideal.IsInertiaRing` predicates and **deprecating the field-level
  `IsDecompositionField`/`IsInertiaField` API and its lemmas**; #35808 (splitting in the inertia
  ring: `f = 1` above, `e` below, unramified over the base); #35991/#36733
  (decomposition/inertia fields of composita and subfields); #36843 (compositum of unramified
  extensions is unramified, plus the totally-split version
  `ramificationIdx_inertiaDeg_sup_eq_one`); #37031 (`ℚ(ζ_m)` is the inertia field of `p` in
  `ℚ(ζ_{p^k m})`). Merged already: #35802 (2026-06-08, splitting in the decomposition field, five
  days *after* the pin). Layer 1's corresponding milestones are **comparison-and-consume on
  landing**, not independent builds.
- **tb65536's inertia program**: merged are the `ramificationIdx`/`inertiaDeg` **definition
  swap** (#41234, #41325, plus ~8 switch-over PRs, 2026-06-29 – 07-04; see the conventions
  table), the `RingTheory/IsGaloisGroup/{Defs,Basic}` + `Invariant/Galois` reorg
  (#40928/#40942/#41071), low-level `Ideal.inertia` API (#40383 et al.), and
  `InfinitePlace.mult_mul_finrank` (#41600); open are #40952/#40387/#40757 (inertia-subgroup
  monotonicity/quotients/smul), **#40955** ("Galois groups are generated by inertia subgroups",
  via Minkowski, the group-theoretic form of `ℚ` having no unramified extension), #41415
  (`absoluteGaloisGroup` functoriality), and #41377/#41378/#41368/#41100 (generalization churn on
  the new definitions).
- **Adjacent open PRs**: xroblot #41180 (norm congruence at unramified primes), #37023 (coprime
  discriminants ⇒ linearly disjoint), #40905 (compositum of abelian extensions); fbarroero
  #40848 (S-integers as localization); kedlaya #41911 (Artin–Schreier).
- **Null results worth recording** (searched 2026-07-30): **zero** open PRs on the
  conductor–discriminant formula or any ideal-theoretic conductor; **zero** on different-ideal
  transitivity beyond what the pin has (`Different.lean` untouched since the pin); **zero**
  extending `IsArithFrobAt` (no Artin-symbol PR; the only "Artin" hits are Artin–Schreier);
  **zero** on higher ramification groups; **zero** on certifying a named fundamental unit.
  Layers 2–7's core builds collide with nothing in flight.
- **Zulip** (searched via the public archive 2026-07-30; the instance's anonymous REST API is
  disabled, so this sweep is the archive plus the sibling's audited threads): the
  decomposition-group-as-stabilizer convention was settled in
  [new members > "Working on Frobenius elements"](https://leanprover-community.github.io/archive/stream/113489-new-members/topic/Working.20on.20Frobenius.20elements.html)
  (M. Karatarakis, with Buzzard/Commelin/Topaz/Lezeau/Wieser/Dillies/Nuccio, 2022-07/08), which
  is the origin of the `ValuationSubring.decompositionSubgroup` stub; **Chebotarev** is a
  declared onward goal of PrimeNumberTheoremAnd (Kontorovich–Tao, stream `#PrimeNumberTheorem+`,
  announced 2024-01), consistent with this roadmap deliberately *not* owning any density
  statement (→ [L-functions PR #8](https://github.com/roed-math/TauCetiRoadmap/pull/8)); and the
  `Valued`-deprecation project (J. Jiang, 2026-03-23) with the `ValuativeRel` wave is tracked in
  the [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) §Provenance and
  constrains Layer 5's instance statements as noted in the conventions table.

### Coordination and licence ledger

- **Project / authors:** Mathlib ramification/inertia work, principally the authors and
  reviewers of the PRs cited above.
- **Exact revision or PR:** mathlib PR
  [#41591](https://github.com/leanprover-community/mathlib4/pull/41591), open at
  `9a76f0e50eee06c57a752295f05f00e98ae29ee3` when refreshed 2026-08-01; the
  `ramificationIdx`/`inertiaDeg` switch-over series #41234/#41325 is already represented in the
  current Mathlib API even though the individual Bors PR pages are closed.
- **Licence:** Mathlib is Apache-2.0.
- **Overlap:** decomposition/inertia predicates and the `e`/`f` names in Layers 1–2.
- **Contact / coordination status:** no new author contact was made during this review pass; the
  cited public PR discussions are the current coordination record.
- **Agreed ownership:** Mathlib owns the generic ring-level API; this roadmap owns only the
  number-field comparisons and the downstream Frobenius packaging.
- **Plan:** consume the landed Mathlib declarations and contribute missing generic comparison
  lemmas upstream; do not freeze wrappers around the field-level API while #41591 is open.
- **Refactor trigger:** re-elaborate Layers 1–2 at the first toolchain bump containing #41591.

- **Project / authors:** C. Birkbeck,
  [`CBirkbeck/CertifyingInvariantsNF`](https://github.com/CBirkbeck/CertifyingInvariantsNF).
- **Exact revision or PR:** `59ae55dbe49840d26d267a86c3e5c8f4a866d169` (2026-06-30), the
  repository head when refreshed 2026-08-01.
- **Licence:** no licence is declared in the repository metadata; therefore no code or data is to
  be copied or adapted without explicit permission.
- **Overlap:** certified per-field invariant files and the eventual database-label interface.
- **Contact / coordination status:** not contacted during this review pass.
- **Agreed ownership:** none recorded. In particular, this roadmap does not claim the LMFDB
  ordering/canonical-polynomial layer.
- **Plan:** prove only the intrinsic `d.r.|D|` prefix here. A later data-index project may add
  `.i` after its ordering, canonical-polynomial selection, isomorphism deduplication, bounded-list
  completeness, and position certificate have all been specified and coordinated.
- **Refactor trigger:** an explicitly licensed, reviewed certification interface with those five
  ingredients.

## What TauCeti already has (consume)

Audited at `TauCetiProject/TauCeti` HEAD, 2026-07-30. These files were authored under the
[Multiquadratic](../Multiquadratic/README.md) roadmap (Layers 1–2) and the completed
[EffectiveBounds](../../Completed/EffectiveBounds/README.md) roadmap; this roadmap consumes and
generalizes them, so that the quadratic statements become instances of the uniform API. One
narrowly scoped amendment to a landed file is planned and is named as such: Layer 1 publishes a
theorem that is currently `private` in `SplitsCompletely.lean`. That is an API change to an
existing file, to be made in coordination with its authors, not a fork and not a duplicate in a
rival namespace. Nothing else in these files is edited.

- `TauCeti/NumberTheory/NumberField/Frobenius.lean`: `exists_isArithFrobAt(_of_liesOver)`
  (existence of `σ : K ≃ₐ[ℚ] K` with `IsArithFrobAt ℤ σ Q`, for `IsGalois ℚ K`, the base-`ℚ`
  instantiation of Mathlib's `exists_of_isInvariant`), and
  `isArithFrobAt_apply_sqrt(_eq_self_iff)` (`σ √d = (d/p)·√d`). Layer 2 generalizes existence to
  relative extensions `L/K` and builds the uniqueness and conjugacy-class layer on top.
- `TauCeti/NumberTheory/LegendreSymbol/Frobenius.lean`: the domain-generic
  `AlgHom.IsArithFrobAt.apply_sqrt` / `IsArithFrobAt.smul_sqrt` (already base-general);
  `LegendreSymbol/SquareClass.lean`: square-class invariance of Legendre data.
- `TauCeti/NumberTheory/NumberField/SplitsCompletely.lean`: splits-completely as the count
  equation, `ncard_primesOver_eq_finrank_iff` (`↔ e = f = 1`) and `…_iff_stabilizer_eq_bot`
  (`↔` trivial decomposition group), over `ℚ`. ⚠ The general-base form exists there but is
  `private`; Layer 1 publishes that shape (coordinate; do not re-derive).
- `TauCeti/NumberTheory/NumberField/Quadratic/Splitting.lean`: `ncard_primesOver_quadratic_iff`
  (odd `p ∤ d`: splits ⟺ `legendreSym p d = 1`), presented via `minpoly ℤ θ = X² − C d`. The
  Layer-3 relative Dedekind–Kummer API has this as its degree-2 corollary; the `p = 2` and
  `d ≡ 1 mod 4` cases it excludes are Layer 3 and Layer 7 worked targets here.
- `TauCeti/NumberTheory/NumberField/IntegralSqrt.lean`,
  `Internal/QuadraticIntegralBasis.lean`: `integralSqrt` and the `{1, x}` quadratic integral
  basis; Layer 7 supplies the full `d mod 4`-sensitive `𝓞_{ℚ(√d)}` and generalizes.
- `TauCeti/NumberTheory/RamificationInertia/Galois.lean`:
  `ncard_primesOver_eq_natCard_iff_of_isGaloisGroup` (finite flat Galois extensions of domains).
  Layer 1's relative splitting dictionary extends this file.
- `TauCeti/NumberTheory/Multiquadratic/`: the sign-vector Galois theory
  (`signPattern`/`signHom`/`galoisGroupEquiv`), `MultiquadraticSplitting`, the
  prime-discriminant/`candidateGenusField` layer, and `Multiquadratic/Frobenius.lean`
  (`galoisGroupEquiv_frobenius`: Frobenius = Legendre sign vector), the `(ℤ/2)ⁿ` instance of
  Layers 1–2. The boundary is that anything `(ℤ/2)ⁿ`-specific stays theirs and the uniform
  statements live here.
- `TauCeti/NumberTheory/EffectiveBounds/` and `GeometryOfNumbers/`:
  `abs_discr_le_of_basis_isIntegral`, `card_ideal_absNorm_le`, `classNumber_le_bound`,
  `units_sq_index_eq (= 2^{rank+1})`, `regulator_eq_one_of_rank_eq_zero`,
  `discr_cyclotomicField_four = -4`, and the Hermite count, consumed by Layers 3, 7 and 8 (the
  index formula of Layer 3 sharpens `abs_discr_le_of_basis_isIntegral` to an equation).
- Conventions the repo enforces, and this roadmap adopts: `TauCeti.*` namespaces mirroring
  Mathlib paths (bare Mathlib namespaces only when extending an existing Mathlib definition's
  API), the module system (`public import`/`public section`, `@[expose]` where needed),
  `Internal/` for shared non-headline helpers, dated `@[deprecated]` wrappers, provenance
  sections in module docstrings, and the presentation idioms recorded in §Standing hypotheses.

## What is missing (build here)

The list, in one place. A uniform Frobenius and Artin-symbol API over number fields at finite
level: the number-field instantiation of `IsArithFrobAt`; group-level uniqueness at unramified
primes; the conjugacy-class-valued Artin symbol at a prime ideal of the base; the abelian
collapse and the fractional-ideal Artin homomorphism; `orderOf Frob = f`; behavior under
restriction and in towers; the identification with the residue-field Frobenius; the cyclotomic
and quadratic element identifications; and complex conjugation as the canonical element at a
ramified real place. The relative Dedekind–Kummer theorem with matching `e`/`f` (the pin has it
only over `ℤ`) together with its converse-irreducibility TODO; the power-basis index with
`disc(minpoly θ) = index² · discr K` and the same-prime-support comparison with
`RingOfIntegers.exponent`; Dedekind's criterion over `ℤ`; **Dedekind's theorem** (factorization
type = Frobenius cycle type) with the common-index-divisor theory that bounds its hypotheses.
The relative discriminant ideal with its tower formula and `relNorm`-of-different
characterization; the `Algebra.discr` tower formula and the `Polynomial.discr` link;
Stickelberger's congruence. The canonical completion of an extension at a finite place and the
whole finite-place local–global dictionary (`Σ [L_w:K_v] = n`, `[L_w:K_v] = e·f`,
`D_Q ≅ Gal(L_w/K_v)`, norm and trace, localization of the different,
`IsNonarchimedeanLocalField` instances on completions). Global ramification consequences
transported through that dictionary: the lower filtration compared with the local one, the
different-exponent formula, exact tame and wild exponents, and the permutation-action
discriminant formula. The double-coset splitting law for non-Galois extensions and
totally-split-iff-in-the-closure. The subfield-lattice packaging, the monogenicity predicate with
its quadratic, cyclotomic and Dedekind examples, and explicit unit certification. Intrinsic LMFDB
label-prefix semantics with a fully computed worked suite. None of this exists upstream as
stated; every consumable fragment is cited above.

## Cross-roadmap dependencies

Each row is one named milestone crossing a roadmap boundary. Nothing else crosses.

| Supplier | Exact supplied milestone | Consumer |
|---|---|---|
| [PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 0 | local-field structure, the local `e`/`f`, and the `‖x‖ = q^{−v(x)}` normalization | PR #9 Layer 5 |
| [PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 2 | unramified extensions and the local Frobenius | PR #9 Layer 5 (Frobenius comparison) |
| [PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 3 | the lower filtration `G_i`, `v_L(𝔡) = Σ_{i≥0}(#G_i − 1)`, tame `v_L(𝔡) = e − 1`, and the wild bound | PR #9 Layer 6 |
| PR #9 Layer 3 | the polynomial-side Dedekind theorem: for monic `f : ℤ[X]` and `p ∤ f.discr`, some `σ ∈ (f/ℚ).Gal` whose root action has full cycle type the factor-degree multiset of `f mod p` | [PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10) Layer 5 |
| PR #9 Layer 7 | the `S_n`-embedding of the Galois closure of a number field | [PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10) |
| [PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10) | `nTj` transitive-group label semantics and low-degree recognition | PR #9 Layer 8 only |
| PR #9 Layer 2 | `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` on the fractional ideals prime to the ramified set, in PR #6's `(FractionalIdeal (𝓞 K)⁰ K)ˣ` carrier | [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layers 6–8 |
| PR #9 Layer 5 | `IsNonarchimedeanLocalField (v.adicCompletion K)` with the residue-cardinality and normalization lemmas, and the localization of the different | [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layers 2, 9 |
| [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 1 | the narrow class group `Cl⁺ K` and the surjection `Cl⁺ ↠ Cl` | PR #9 Layer 8 |
| [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 9 | the abelian conductor–discriminant formula, used only as a cross-check on the worked examples | PR #9 §Worked examples |
| [Multiquadratic](../Multiquadratic/README.md) (merged) | the landed TauCeti files listed in §What TauCeti already has | PR #9 Layers 1–2, 7 |
| [EffectiveBounds](../../Completed/EffectiveBounds/README.md) (completed) | discriminant and class-number bounds | PR #9 Layers 3, 7–8 |

Ownership at the boundary with Local Fields, stated once because it is the boundary most likely
to be crossed twice: **PR #2 owns the local ramification theory**, meaning the lower and upper
numbering filtrations, Herbrand's theorem, Hasse–Arf, and the local different formulas. **PR #9
owns the canonical completion maps, the comparison of global ideal-theoretic invariants with the
local ones, and the global ideal and discriminant corollaries.** This roadmap does not rebuild a
second lower-ramification theory. Its global filtration (Layer 6) exists to be compared with the
local one, and the comparison theorem is that object's central API.

---

## The build, in layers

The eight layers below are a dependency order: every milestone in Layer `n` rests on Mathlib, on
TauCeti, on an earlier layer, or on a sibling roadmap's milestone named in §Cross-roadmap
dependencies. There are no forward references. As each layer makes the next layer's types
expressible, its milestones are added to `Suggested.lean` with `sorry`.

### Layer 1: the splitting dictionary (Hilbert theory, completed and relativized)

- **Publish the relative splitting criteria.** The general-base forms of TauCeti's
  splits-completely dictionary (count `= n` ⟺ `e = f = 1` ⟺ trivial decomposition group), for
  `L/K` finite (Galois where stated) over an arbitrary Dedekind base. This publishes the shape
  that is `private` in `SplitsCompletely.lean`, as a narrowly scoped public-API amendment to that
  file made in coordination with its authors; the theorem is not restated in a second namespace.
- **Unramified sets of primes, without a new predicate.** Statements about a finite set of primes
  being unramified are written with explicit pointwise quantification over the primes of the set,
  mirroring the pin's archimedean `IsUnramifiedAtInfinitePlaces`. ⚠ Do **not** introduce a Tau
  Ceti `IsUnramifiedIn` wrapper: master already has `Algebra.IsUnramifiedIn` (#41323), and
  pointwise statements refactor onto it directly at the next bump, whereas a wrapper would have
  to be deprecated the day it lands.
- **The prime-in-subfield dictionary** (Neukirch I (9.3)/(9.6)): `e` and `f` of `P ∩ Z` and
  `P ∩ T` for the decomposition and inertia fields. `P` is the only prime of `L` over `P ∩ Z`;
  `e(P∩Z/p) = f(P∩Z/p) = 1`; `f(P∩T/P∩Z) = f`, `e(P∩T/P∩Z) = 1`; the inertia field is where `e`
  concentrates. ⚠ **Refactor-onto flag**: this is exactly xroblot's open wave (#35802 merged
  post-pin; #35808/#35991/#36733 open) on the ring-level predicates of #41591. State these
  milestones, and convert them to comparison-and-consume when the wave lands.
- **The double-coset law for non-Galois splitting** (Neukirch I §9 p. 55, the "proof left to the
  reader"; genuinely absent upstream): for `M/K` Galois with group `G`, `L` the fixed field of
  `H ≤ G`, and `D = MulAction.stabilizer G Q` for a prime `Q` over `p`, the primes of `L` over
  `p` biject with `DoubleCoset.Quotient H D` via `HσD ↦ σQ ∩ L`; the invariant read-off
  `e(𝔮_σ/p)·f(𝔮_σ/p) = |HσD|/|H| = [σDσ⁻¹ : H ∩ σDσ⁻¹]`, refined to
  `e(𝔮_σ/p) = [σIσ⁻¹ : H ∩ σIσ⁻¹]` with `I = Q.inertia G`; and the consistency identity
  `Σ_σ |HσD|/|H| = [L:K]` recovering the fundamental identity.
- **Totally split ⟺ totally split in the Galois closure** (Neukirch I §9 Ex. 4, via the
  double-coset law), and the compositum statements: `p` totally split in `L₁` and `L₂` ⟺ in
  `L₁L₂`; `p` unramified in both ⟹ unramified in the compositum. ⚠ **Refactor-onto**: the
  unramified-compositum half is open PR #36843.

### Layer 2: Frobenius elements and the Artin symbol, at finite level

The pin has the entire machinery (existence, conjugacy, uniqueness mod inertia, uniqueness at
unramified primes at `AlgHom` level) as a leaf file; this layer is the missing instantiation and
packaging. Everything is stated in `IsArithFrobAt` vocabulary, with no rival definition, and
everything lives in a finite Galois extension.

- **Number-field and relative instantiation.** For `L/K` finite Galois (`IsGalois K L`) and `Q` a
  nonzero prime of `𝓞 L`: discharge the `IsArithFrobAt.exists_of_isInvariant` hypotheses once
  (`Finite Gal`, `Algebra.IsInvariant (𝓞 K) (𝓞 L) Gal`, `Finite (𝓞 L ⧸ Q)`, all derivable from
  pin instances) and provide `∃ σ : L ≃ₐ[K] L, IsArithFrobAt (𝓞 K) σ Q`, generalizing TauCeti's
  landed base-`ℚ` `exists_isArithFrobAt`. ⚠ The exponent is `Nat.card (𝓞 K ⧸ Q.under (𝓞 K))`,
  the **base** residue cardinality `N(𝔭)`, not `N(Q)`; keep the TauCeti convention.
- **Group-level uniqueness at unramified primes.** Upgrade
  `AlgHom.IsArithFrobAt.eq_of_isUnramifiedAt` to `σ = τ` in the Galois group via faithfulness
  (`IsGaloisGroup.faithful`), giving `Subsingleton {σ // IsArithFrobAt (𝓞 K) σ Q}` at unramified
  `Q`. At ramified `Q` the honest statement is the pin's `mul_inv_mem_inertia`, the Frobenius
  coset modulo `Q.inertia`, and the ramified convention of the table.
- **The Artin symbol, at a prime of the base.** For `𝔭 : Ideal (𝓞 K)` nonzero prime and
  unramified in `L`, `artinSymbol 𝔭 : ConjClasses (L ≃ₐ[K] L)`, well defined by
  `isConj_arithFrobAt` together with the uniqueness above; `Frob (σ • Q) = σ (Frob Q) σ⁻¹`; the
  **order** `orderOf (Frob Q) = f(Q/𝔭)` and `Subgroup.zpowers (Frob Q) = MulAction.stabilizer` at
  unramified `Q` (from the pin's `card_stabilizer_eq`); and the identification with the residue
  Frobenius, namely that `Ideal.Quotient.stabilizerHom` sends `Frob Q` to
  `FiniteField.frobeniusAlgEquivOfAlgebraic`, closing the loop between `IsArithFrobAt.restrict`
  and the finite-field API. ⚠ The Artin symbol is indexed by a prime **ideal** of `𝓞 K`; the
  familiar `(p, K/ℚ)` for a rational prime `p` is the `K = ℚ` corollary, obtained by specializing
  `𝔭 = span {(p : ℤ)}`, and is never the primary statement.
- **Functoriality.** Restriction to subextensions: for `K ⊆ M ⊆ L` with `M/K` Galois,
  `IsArithFrobAt (𝓞 K) σ Q → IsArithFrobAt (𝓞 K) (σ.restrictNormal M) (Q.under (𝓞 M))` (nothing
  like it exists upstream; the cyclotomic `galEquivZMod_restrictNormal_apply` is the only
  restriction square in Mathlib and is not about Frobenius elements); the tower statement for
  `Frob` over an intermediate prime (`Frob_{L/M}(Q) = Frob_{L/K}(Q)^{f(Q∩M/𝔭)}`); and
  compatibility of `artinSymbol` with `AlgEquiv.restrictNormalHom`.
- **The abelian collapse and the ideal-theoretic Artin map.** For abelian `L/K` the symbol is a
  single element `((L/K)/𝔭) ∈ Gal(L/K)`. Extend it multiplicatively, in exactly the carrier
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) pinned for `J^{𝔪₀}`: let `S` be the
  finite set of primes of `𝓞 K` dividing `relDiscr (𝓞 K) (𝓞 L)` (Layer 4 supplies the ideal;
  `S` finite is Layer 4's finiteness statement), let `J^S ≤ (FractionalIdeal (𝓞 K)⁰ K)ˣ` be the
  subgroup of fractional ideals whose support avoids `S`, and define
  `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` by prime factorization and the prime-level symbol.
  Milestones: well-definedness through unique factorization; the values on primes; the
  restriction of `artinHomUnramified` to integral ideals as a monoid hom (a corollary, not the
  primary object); functoriality in `L`. Its reciprocity properties (kernel, surjectivity,
  factorization through ray class groups) are **not** stated here: PR #6 owns those and consumes
  this map literally, which is why the carrier is pinned rather than invented.
- **Computations.** Cyclotomic: `galEquivZMod n K (Frob Q) = ZMod.unitOfCoprime p hp`, the
  element identification the pin stops short of (both halves exist: `apply_of_pow_eq_one` and
  `galEquivZMod_apply_of_pow_eq`). Quadratic: for `K = ℚ(√d)` presented by `θ : 𝓞 K` with
  `minpoly ℤ θ = X² − C d` and `Algebra.adjoin ℚ {(θ : K)} = ⊤`, and for a rational prime `p`
  with `p` odd, `p ∤ d`, and `Q` a prime of `𝓞 K` over `p`, `Frob Q = 1 ↔ legendreSym p d = 1`.
  ⚠ All four hypotheses are part of the statement: `p` odd and `p ∤ d` are what make `p`
  unramified and the Legendre symbol available, and `hmin`/`hgen` are what make `θ` a generator
  whose exponent is prime to `p`. This generalizes TauCeti's
  `isArithFrobAt_apply_sqrt_eq_self_iff` from an element identity to the symbol.
- **The canonical element at a ramified real place.** For `w` a real place of `K` ramifying in
  `L`, the stabilizer of a place of `L` above `w` has order 2 (pin). Name its generator: it is
  complex conjugation, via `ComplexEmbedding.IsConj`, with `IsCMField.complexConj` as the CM
  instance, and give the basic API (order 2, compatibility with restriction, the fixed field is
  the real subfield). ⚠ This element is **not** called a Frobenius anywhere: at an infinite place
  the local Galois group is `Gal(ℂ/ℝ)`, there is no residue field and no `q`-power congruence,
  and conflating the two notions is exactly the error the naming convention exists to prevent.

### Layer 3: the index, Dedekind–Kummer, and Dedekind's theorem

The index material comes first in this layer because the polynomial-side hypothesis `p ∤ f.discr`
has to be converted into the conductor hypothesis Kummer–Dedekind actually takes, and that
conversion is the index comparison. Nothing later in the layer may assume it.

- **The power-basis index, on a carrier with no junk values.** Define
  `IntegralPrimitiveElement K := {θ : 𝓞 K // Algebra.adjoin ℚ {(θ : K)} = ⊤}` and, on that
  subtype only, `index θ : ℕ`, the cardinality of `𝓞 K ⧸ Algebra.adjoin ℤ {θ}` as a `ℤ`-module
  quotient, together with `0 < index θ` (both are free of rank `finrank ℚ K`, so the quotient is
  finite). ⚠ Do **not** define an index by raw `Nat.card` for every `θ : 𝓞 K`: a non-generator
  gives an infinite quotient and Mathlib's fallback value `0`, and every subsequent divisibility
  statement would then be silently true. If a total definition is later wanted, it must be
  introduced with its junk value documented and with the primitive-element hypothesis retained in
  the theorems.
- **The discriminant of a power basis.**
  `Algebra.discr ℚ (powerBasis θ) = Polynomial.discr (minpoly ℤ θ)` under the canonical maps;
  both objects exist upstream and are never connected.
- **The index formula.** `Polynomial.discr (minpoly ℤ θ) = (index θ)² · NumberField.discr K` for
  `θ : IntegralPrimitiveElement K`. This sharpens EffectiveBounds'
  `abs_discr_le_of_basis_isIntegral` from an inequality to an equation.
- **Index and exponent have the same prime divisors.** `p ∣ index θ ↔ p ∣ RingOfIntegers.exponent θ`
  for `p` prime. ⚠ The two invariants are different integers in general (the exponent is the
  `absNorm` of the contracted order conductor), and only the index satisfies the formula above;
  the same-prime-support statement is what makes them interchangeable in hypotheses.
- **The checkable hypothesis.** Combining the previous two:
  `¬ (p : ℤ) ∣ Polynomial.discr (minpoly ℤ θ) → ¬ p ∣ RingOfIntegers.exponent θ`. This is the
  implication every polynomial-side statement below uses, and it is stated and proved here rather
  than assumed. If a bump supplies it directly, cite the upstream name and drop the local proof;
  do not leave it implicit either way.
- **The relative Dedekind–Kummer theorem.** Generalize the pin's `𝓞 K/ℤ` package
  (`primesOverSpanEquivMonicFactorsMod` with `inertiaDeg`/`ramificationIdx` matching) to AKLB:
  for `θ` generating `L/K` and `p` coprime to `conductor A θ`, primes of `B` over `p` correspond
  to monic irreducible factors of `minpoly A θ mod p`, with `fᵢ = deg`, `eᵢ = multiplicity`, and
  the span formula. The general file's TODO (the converse of
  `irreducible_map_of_irreducible_minpoly`) closes here. TauCeti's
  `ncard_primesOver_quadratic_iff` becomes the degree-2 corollary.
- **Dedekind's criterion, over `ℤ`** (Cohen §6.1). Stated for the base `ℤ`, because the criterion
  divides by `p` and that has no base-free meaning; a relative version would need a chosen
  uniformizer and explicit localization hypotheses, and is not a milestone here. Let
  `θ : IntegralPrimitiveElement K`, `f = minpoly ℤ θ`, and `p` prime. Write
  `f mod p = ∏ᵢ φᵢ^{eᵢ}` with the `φᵢ` distinct monic irreducibles of `𝔽_p[X]`, choose monic
  lifts `Φᵢ : ℤ[X]`, prove that `f − ∏ᵢ Φᵢ^{eᵢ}` has all coefficients divisible by `p`, and set
  `H := (f − ∏ᵢ Φᵢ^{eᵢ})/p`. Then

  ```text
  ¬ p ∣ index θ  ↔  ∀ i, eᵢ = 1 ∨ ¬ φᵢ ∣ (H mod p).
  ```

  Milestones: independence of the criterion from the choice of lifts `Φᵢ`; the coefficientwise
  divisibility statement (so that `H` is well defined in `ℤ[X]`); the criterion itself; and the
  corollary `Squarefree (f mod p) → ¬ p ∣ index θ`. `Suggested.lean` carries the signature.
- **Splitting fields of rational polynomials are number fields.** For `0 ≠ f : ℚ[X]`, an instance
  `NumberField f.SplittingField`, so that `Polynomial.Gal f` is the Galois group of a number
  field and Frobenius elements are available in it. Without this the theorem below can only be
  stated for an auxiliary Galois number field in which `f` splits, and the transfer back to the
  canonical `Polynomial.Gal` object is left to the reader; state whichever of the two is used,
  and state it here.
- **Dedekind's theorem** (the named statement supplied to
  [Polynomial Galois Groups PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10)).
  Suggested name: `TauCeti.NumberField.factorizationType_eq_cycleType_isArithFrobAt`. For
  `K = ℚ(θ)`, `f = minpoly ℤ θ`, `p ∤ RingOfIntegers.exponent θ` with `f mod p` squarefree, `M` a
  Galois number field in which `f` splits, and `σ` any Frobenius at a prime of `𝓞 M` over `p`:
  the multiset of degrees of the monic irreducible factors of `f mod p` equals the cycle type of
  `Polynomial.Gal.galActionHom f M σ` on the roots, as partitions of `n`. ⚠ Two traps pinned by
  convention: `Equiv.Perm.cycleType` omits fixed points (the statement adds
  `Multiset.replicate #fixed 1`), and the hypothesis is `p ∤ exponent θ` **together with**
  squarefreeness mod `p`, which forces `p` unramified in `K` but is assumed rather than derived;
  `p ∤ disc f` implies both, by the index material above, and is the checkable form. Proof
  outline: Layer 1's double-coset law identifies the primes of `K` over `p` with `⟨Frob⟩`-orbits
  on `H\G`, that is, on the roots, and the relative Dedekind–Kummer correspondence identifies
  those primes with the factors, matching `f`'s with orbit sizes.
- **The polynomial-side corollary, for arbitrary monic `f`.** For monic `f : ℤ[X]` and a prime
  `p ∤ f.discr`, produce `σ : (f.map ℚ).Gal` whose arithmetic-Frobenius root action has full
  cycle type (cycle type with fixed points restored) equal to the factor-degree multiset of
  `f mod p`. This is the exact interface PR #10 consumes, and PR #10 uses it on reducible `f`
  (it derives the classical mod-`p` irreducibility criterion from it), so the statement must
  genuinely cover reducible `f`. The reduction is a milestone, not an afterthought:
  - `p ∤ f.discr` gives `f.discr ≠ 0`, hence `f` separable over `ℚ`, hence
    `f = ∏ⱼ fⱼ` with the `fⱼ` distinct monic irreducibles of `ℤ[X]` (Gauss);
  - `f.discr = (∏ⱼ fⱼ.discr) · (∏_{j<k} Res(fⱼ, f_k))²`, so `p` divides no factor discriminant
    and no resultant, hence the `fⱼ mod p` are squarefree and pairwise coprime;
  - `rootSet f` is the disjoint union of the `rootSet fⱼ`, the Galois action respects the
    decomposition, and full cycle type is additive along it;
  - the factor-degree multiset of `f mod p` is the sum of those of the `fⱼ mod p`;
  - a single Frobenius `σ` at one prime of a Galois number field containing all the roots
    restricts to a Frobenius on each `ℚ(θⱼ)`'s closure, so one `σ` realizes all the pieces at
    once.

  Each of those five is a named lemma. Do not derive the reducible case silently from the
  irreducible one.
- **Common index divisors.** Definition: `p` is a common index divisor of `K` if `p ∣ index θ`
  for **every** `θ : IntegralPrimitiveElement K`. The counting obstruction, the elementary
  direction, proved here: if the splitting type of `p` in `K` requires more monic irreducible
  polynomials of some degree `d` over `𝔽_p` than exist, then `p` is a common index divisor, and
  hence `𝓞 K` is not monogenic. The converse (Hensel's criterion: common index divisors are
  exactly the primes whose splitting type is unrealizable mod `p`) is outside this roadmap and is
  cited to Narkiewicz in §References. Worked example: `2` in `ℚ[x]/(x³ − x² − 2x − 8)`
  (Dedekind's field; Neukirch III §2 Ex. 1), where `2` splits completely into three primes of
  residue degree 1 but `𝔽₂` has only two monic linear polynomials.

### Layer 4: the relative discriminant, algebraically

The pin's `Different.lean` is strong and includes transitivity; this layer adds the discriminant
ideal it never defined, and the identities that need nothing beyond it. Everything whose proof
runs through a completion is in Layer 6.

- **The relative discriminant ideal.**
  `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)` with: multiplicativity in
  towers, `relDiscr A C = (relDiscr A B)^{[M:L]} · relNorm A (relDiscr B C)` (Neukirch III (2.10),
  from the pin's different-transitivity plus multiplicativity of `relNorm`); localization; the
  ramification criterion `p` ramified in `B` ⟺ `p ∣ relDiscr A B` (Neukirch III (2.12),
  generalizing the pin's `ℚ`-only `not_dvd_discr_iff_forall_liesOver`); the absolute
  reconciliation `relDiscr ℤ (𝓞 K) = span {NumberField.discr K}` (against
  `absNorm_differentIdeal`, with the sign from `sign_discr`); and finiteness of the set of
  ramified primes, as divisors of a nonzero ideal. That finiteness statement is what Layer 2's
  `S` and `J^S` are built on, so it is stated in the general-Dedekind form, whose `ℚ`-corollary
  is one line from the pin but is absent upstream.
- **Discriminants of bases, connected.** The `Algebra.discr` tower formula
  `disc_{M/K}(compatible bases) = disc_{L/K}^{[M:L]} · N(disc_{M/L})`.
- **Stickelberger's congruence** `discr K % 4 ∈ {0, 1}`: absent upstream, classical, and
  self-contained (split the Leibniz expansion of the embedding determinant into even and odd
  permutations, and observe that the two halves are conjugate algebraic integers).
- ⚠ Scope note. The exact exponents `v_P(𝔡) = e − 1` in the tame case and `e ≤ v_P(𝔡) ≤ e − 1 +
  v_P(e)` in the wild case are **not** here, because their proofs localize and complete. They are
  Layer 6, after the Layer-5 dictionary exists. The local computations they rest on belong to
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 3.

### Layer 5: the global–local dictionary at finite places

Everything is stated in
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s vocabulary
(`IsNonarchimedeanLocalField`, their `v_K`/`‖·‖_K` normalizations, their `e`/`f`). Their Layer 0
reconciles the local objects with `Ideal.ramificationIdx` once; the global halves of that
reconciliation live here. Signatures can be written as soon as their Layer-0 vocabulary exists;
the proofs consume their Layers 0–2 and nothing deeper. ⚠ Nothing in this layer uses the local
higher ramification filtration; that dependency is Layer 6's, on their Layer 3.

- **Completions are local fields.** For `v : HeightOneSpectrum (𝓞 K)`, the instance
  `IsNonarchimedeanLocalField (v.adicCompletion K)`. The class itself is the pin's
  (`Mathlib/NumberTheory/LocalField/Basic.lean`); the milestone is the missing instance chain,
  from the pin's `NormedField`, DVR integers, and finite residue field, and it is stated as the
  full class, with local compactness as one corollary rather than as the target. With it: the
  residue-field identification `𝓀(K_v) ≅ 𝓞 K ⧸ v.asIdeal`, the residue cardinality
  `Ideal.absNorm v.asIdeal`, and the normalization lemma saying that the pin's `adicAbv`
  (normalized by `absNorm`) equals LocalFields' `‖x‖ = q^{−v(x)}`, cross-checked by the product
  formula. ⚠ `Valued`-versus-`ValuativeRel` migration risk as pinned in the conventions table:
  state the instances through the compatibility layer so the deprecation is a refactor.
- **The canonical completion of an extension.** For `w : HeightOneSpectrum (𝓞 L)` with
  `w.asIdeal.LiesOver v.asIdeal`, construct the canonical continuous ring map
  `K_v → L_w` extending `K → L`, prove it continuous, prove `IsScalarTower K K_v L_w`, and prove
  that it is the **unique** continuous `K`-algebra map `K_v → L_w`. Every theorem below is stated
  about this algebra structure. ⚠ The pin's own `Module.Finite K_v L_w` instance takes
  `[Algebra K_v L_w] [ContinuousSMul K_v L_w] [IsScalarTower K K_v L_w]` as hypotheses; a theorem
  stated that way is a theorem about an arbitrary compatible structure, and can be about the
  wrong extension. Re-derive `Module.Finite` for the canonical map, and state the pin's instance
  as the corollary.
- **Semi-local structure.** The algebra equivalence

  ```text
  L ⊗[K] K_v  ≃ₐ[K_v]  ∏ (w : {w : HeightOneSpectrum (𝓞 L) // w.asIdeal.LiesOver v.asIdeal}), L_w
  ```

  (Neukirch II (8.3)), with a named equivalence between that index type and
  `Ideal.primesOver v.asIdeal (𝓞 L)` so both spellings are available. Consequence:
  **`Σ_{w ∣ v} [L_w : K_v] = [L : K]`**, the finite-place analogue of the pin's archimedean
  `InfinitePlace.sum_inertiaDeg_eq_finrank`, absent upstream.
- **Norm and trace, with every map written out.** For `x : L`,

  ```text
  algebraMap K K_v (Algebra.norm K x)  = ∏_{w ∣ v} Algebra.norm K_v (algebraMap L L_w x)
  algebraMap K K_v (Algebra.trace K L x) = Σ_{w ∣ v} Algebra.trace K_v L_w (algebraMap L L_w x)
  ```

  (Neukirch II (8.4)). These are also what proves the different localization below.
- **Invariant matching.** `[L_w : K_v] = e(w ∣ v) · f(w ∣ v)` with `e` and `f` the *global*
  `Ideal.ramificationIdx`/`inertiaDeg` (their local `e·f = n` is LocalFields'; the equality of
  the two factor pairs is this milestone).
- **The decomposition group is the local Galois group.** Under `IsGalois K L`, the canonical
  group homomorphism `MulAction.stabilizer (L ≃ₐ[K] L) w.asIdeal → (L_w ≃ₐ[K_v] L_w)` induced by
  continuity, together with injectivity (density of `L` in `L_w`), surjectivity, and hence the
  isomorphism (Neukirch II §9). With it: compatibility with the residue maps, and the statement
  that an `IsArithFrobAt` element of the stabilizer maps to LocalFields' Layer-2 Frobenius. The
  two conventions already agree by construction; this is the theorem that makes the agreement a
  fact rather than a hope.
- **The different localizes.** Using the actual ideal map into the completed integer ring,

  ```text
  (differentIdeal (𝓞 K) (𝓞 L)).map (algebraMap (𝓞 L) (w.adicCompletionIntegers L))
    = differentIdeal (v.adicCompletionIntegers K) (w.adicCompletionIntegers L)
  ```

  (Neukirch III (2.2)(iii)), stated with the map and not as informal multiplication by
  `𝓞_{L_w}`.
- **The relative discriminant valuation.** In the multiplicity normalization of the conventions
  table,

  ```text
  v_𝔭(relDiscr (𝓞 K) (𝓞 L)) = Σ_{P ∣ 𝔭} f(P/𝔭) · v_P(differentIdeal (𝓞 K) (𝓞 L)),
  ```

  the residue-degree weights coming from `Ideal.relNorm P = 𝔭 ^ f(P/𝔭)`. This is the statement
  every exponent computation in Layer 6 lands in.

### Layer 6: global ramification consequences

This layer transports the local ramification theory of
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 3 through the
Layer-5 dictionary and reads off global ideal-theoretic corollaries. It does **not** develop a
second ramification theory: Herbrand's theorem, upper numbering and Hasse–Arf are PR #2's and are
neither restated nor re-proved here.

- **The global filtration, defined to be compared.** For `L/K` Galois, `Q` a prime of `𝓞 L` over
  `𝔭`, and `i : ℕ`, set
  `G i := {σ ∈ MulAction.stabilizer (L ≃ₐ[K] L) Q | ∀ x : 𝓞 L, σ x − x ∈ Q^(i+1)}`,
  a decreasing chain of normal subgroups of the stabilizer, eventually trivial, with
  `G 0 = Q.inertia` (a reconciliation lemma against the pin's `Ideal.inertia`). ⚠ The
  decomposition group is *not* a member of this family; it keeps its own name, per the
  conventions table. **The central API of this object is the comparison theorem**: under the
  Layer-5 isomorphism `MulAction.stabilizer ≃* (L_w ≃ₐ[K_v] L_w)`, `G i` corresponds to the local
  `G_i` of `L_w/K_v`. Every property of `G i` beyond the definition and this comparison is
  obtained by transport.
- **The different-exponent formula.** `v_Q(differentIdeal (𝓞 K) (𝓞 L)) = Σ_{i ≥ 0} (#(G i) − 1)`
  (Serre LF IV §1 Prop. 4), proved by transporting PR #2's local formula through the comparison
  theorem and the different-localization lemma of Layer 5.
- **Exact tame and wild exponents** (Neukirch III (2.6); the pin has only `P^{e−1} ∣ 𝔡`):
  `v_P(𝔡) = e − 1` exactly when the extension is tame at `P` (`ringChar (A ⧸ 𝔭) ∤ e`), and in the
  wild case `e ≤ v_P(𝔡) ≤ e − 1 + v_P(e)`, where `v_P(e)` is the multiplicity of `P` in
  `span {(e : B)}`, in the same normalization as `v_P(𝔡)`. Route: localize and complete, then
  quote PR #2 Layer 3's local computation, then descend through Layer 5. A divisibility-only
  formulation (`P^{e−1+v_P(e)+1} ∤ 𝔡`) is acceptable if the additive ideal valuation turns out to
  be awkward in Mathlib; state whichever is used and keep it consistent across the layer.
- **The permutation-action discriminant exponent formula.** For `L/K` Galois with group `G`,
  `H ≤ G`, `M = L^H`, `Q` a prime of `𝓞 L` over `𝔭`, and `𝔮 = Q ∩ 𝓞 M`:

  ```text
  e(Q/𝔮) · v_𝔮(differentIdeal (𝓞 K) (𝓞 M)) = Σ_{i ≥ 0} (#(G i) − #(G i ⊓ H)).
  ```

  Both sides are integers and no conductor object appears. The right-hand side is a fixed-point
  count for the permutation action of `G i` on `G/H`: `#(G i ⊓ H)` is the number of elements of
  `G i` fixing the base point. Proof: different-transitivity (pin) plus the subgroup
  compatibility `H_i = H ∩ G_i` (PR #2 Layer 3) plus the exponent formula above. Combined with
  Layer 5's discriminant-valuation formula and Layer 1's double-coset enumeration of the primes
  of `M` over `𝔭` (using `G i (σ • Q) = σ (G i Q) σ⁻¹`), this computes `v_𝔭(relDiscr (𝓞 K) (𝓞 M))`
  outright. ⚠ A future ArtinRepresentations roadmap may recognize this integer as the Artin
  conductor of the permutation character; that identification is theirs, and is not needed to
  state or prove anything here.
- ⚠ No conductor object. This roadmap defines no Artin conductor, no conductor exponent
  `f_𝔭(χ)`, and no ideal whose exponents are the ramification sum `Σ_i |G_i|/|G_0| · (…)`, which
  is rational before Artin's integrality theorem. General Artin conductors, Artin integrality,
  and the general conductor–discriminant formula belong to a future ArtinRepresentations roadmap;
  the abelian conductor–discriminant formula is
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 9's. The only conductor
  formed anywhere in this roadmap is the order conductor of the conventions table.

### Layer 7: subfields, integral bases, monogenicity, and explicit units

- **The subfield dictionary.** Package `IsGalois.intermediateFieldEquivSubgroup` for number
  fields: for arbitrary `K` with Galois closure `M` (`normalClosure ℚ K M`), the lattice of
  subfields of `K` corresponds anti-isomorphically to the subgroups between `Gal(M/K)` and
  `Gal(M/ℚ)`; the counting statements; and `Gal(M/ℚ) ↪ S_n` via `Polynomial.Gal.galActionHom`,
  with transitivity ⟺ irreducibility (consume). The classification of which transitive groups
  occur, and the `nTj` labels, are
  [Polynomial Galois Groups PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10)'s and
  are not duplicated here; the `S_n`-embedding is what this roadmap supplies to it. Worked
  targets: the three subfields of `ℚ(ζ₅)`, and that the cubic field of discriminant `−23` has no
  proper subfield.
- **Integral bases of quadratic fields.** `𝓞_{ℚ(√d)}` with the `d mod 4` case split (`ℤ[√d]`
  versus `ℤ[(1+√d)/2]`) and `discr = d` or `4d`, generalizing TauCeti's `IntegralSqrt` and
  `QuadraticIntegralBasis` to the statement the LMFDB page needs, with the `p = 2` splitting law
  by `d mod 8` as the acceptance test.
- **Monogenicity.** The predicate, in the `NumberField` namespace and applied to the field:

  ```text
  NumberField.IsMonogenic (K : Type*) [Field K] [NumberField K] : Prop :=
    ∃ θ : 𝓞 K, Algebra.adjoin ℤ {θ} = ⊤
  ```

  ⚠ Search Mathlib for an existing `IsMonogenic` at implementation time, and do not put this in
  the root namespace: a bare `IsMonogenic` invites a collision with a future generic
  ring-theoretic version, and if such a version lands, this becomes an abbreviation for it. The
  working criterion is the pin's `exponent_eq_one_iff`. Instances: quadratic fields, cyclotomic
  fields (consume the pin), and the **non-monogenicity** of Dedekind's cubic, via Layer 3's
  common-index-divisor obstruction.
- **Explicit unit certification (rank one).** Mathlib's Dirichlet theorem gives a fundamental
  system, and `regOfFamily_div_regulator` gives the index of a candidate family, but nothing
  upstream certifies that a *named* unit generates modulo torsion. Without such a certificate no
  exact regulator value can be asserted, so this is a prerequisite for the worked examples, not
  an extra. For `K` with `NumberField.Units.rank K = 1` and `u : (𝓞 K)ˣ`, build:
  - the criterion `Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤ ↔` no unit `v` has
    `0 < ‖logEmbedding v‖ < ‖logEmbedding u‖`;
  - the finiteness that makes the right-hand side checkable: a unit whose log embedding is
    bounded has all its archimedean absolute values bounded, so
    `NumberField.Embeddings.finite_of_norm_le` applies, and the candidate set is finite. For a
    real quadratic or a signature-`(1,1)` cubic field this becomes an explicit finite search over
    integral minimal polynomials with bounded coefficients, which is the proof method the worked
    examples use. ⚠ "Mathlib has Dirichlet's unit theorem" is not a proof of index one, and no
    example below may cite it as one;
  - the consequence `regOfFamily ![u] = NumberField.Units.regulator K` from
    `regOfFamily_div_regulator` with index `1`, and the rank-one evaluation
    `regulator K = |Real.log (w u)|` for an infinite place `w`, from `regOfFamily_eq_det`.

  With those three, an exact regulator value is a computation about one explicit unit, and the
  worked examples state their units and their generation theorems rather than a decimal.

### Layer 8: the intrinsic label prefix and the invariant suite

- **The intrinsic prefix predicate.** `HasLMFDBIntrinsicLabel K d r D` means
  `finrank ℚ K = d ∧ nrRealPlaces K = r ∧ (discr K).natAbs = D`, together with sign recovery
  `discr K = (−1)^{(d−r)/2}·D` from `sign_discr`. ⚠ The full label's `.i` coordinate is not a
  deliverable of this roadmap in any form: it requires an external certified database ordering, a
  canonical defining polynomial, isomorphism deduplication, and a bounded-list completeness
  certificate, none of which is extractable from `finite_of_discr_bdd`. A label such as `2.2.5.1`
  is used below only as an external name for a field.
- **Page coverage map.** For each datum an LMFDB number-field page displays, who owns it and what
  its status is. `existing` means Mathlib or landed TauCeti; `built here` means a milestone of
  Layers 1–8; `sibling` means another roadmap's named milestone; `out of scope` means this
  roadmap makes no claim.

  | Page datum | Owner | Status |
  |---|---|---|
  | degree, defining-polynomial degree | Mathlib (`Module.finrank ℚ K`) | existing |
  | signature `(r₁, r₂)` | Mathlib (`nrRealPlaces`, `nrComplexPlaces`) | existing |
  | discriminant, signed | Mathlib (`NumberField.discr`, `sign_discr`) | existing |
  | root discriminant | Mathlib (`rootDiscr`) | existing |
  | ramified primes | Layer 4 | built here |
  | factorization of `p𝓞_K`, unramified `p` | Layers 2–3 | built here |
  | factorization of `p𝓞_K`, ramified `p` | Layer 3 (Kummer–Dedekind) with Layers 4, 6 | built here |
  | Frobenius cycle type at unramified `p` | Layer 3 | built here |
  | local algebras at a ramified prime | Layer 5 with PR #2 | built here / sibling |
  | Galois group, as an abstract group | Layer 7 (`S_n`-embedding) | built here |
  | Galois group `nTj` label | [PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10) | sibling |
  | class group and class number | Mathlib with EffectiveBounds | existing |
  | narrow class group | [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 1 | sibling |
  | unit rank, torsion order | Mathlib | existing |
  | fundamental units | Layer 7 (explicit unit certification) | built here |
  | regulator | Mathlib defines it; Layer 7 certifies each value | existing / built here |
  | Dedekind zeta residue at `s = 1` | Mathlib (class number formula) | existing |
  | zeta continuation, functional equation, densities | [PR #8](https://github.com/roed-math/TauCetiRoadmap/pull/8) | sibling |
  | subfields | Layer 7 | built here |
  | monogenicity, index, common index divisors | Layers 3, 7 | built here |
  | CM and totally real flags | Mathlib (`IsCMField`, `IsTotallyReal`) | existing |
  | intrinsic label prefix `d.r.\|D\|` | Layer 8 | built here |
  | label index `.i` | nobody | out of scope |
  | canonical/normalized defining polynomial | nobody | out of scope |
  | completeness of a bounded list, isomorphism deduplication | nobody | out of scope |
  | sibling fields, arithmetic equivalence | nobody | out of scope |
  | Artin conductors of associated representations | future ArtinRepresentations | out of scope |

- **The worked suite.** Five fields, computed end to end: `2.2.5.1`, `2.0.4.1`, `4.0.125.1`,
  `3.1.23.1`, `3.1.503.1`. Each is stated in §Worked examples with its assertions split into what
  is proved here and what is consumed from a sibling, and each has a section in `Suggested.lean`.

### Explicit scope exclusions and future directions

- **No Frobenius in the absolute Galois group.** There is no canonical Frobenius element or
  conjugacy class in `Gal(K̄/K)`, and this roadmap constructs none. The canonical object at an
  unramified place is arithmetic Frobenius in `D_v / I_v ≅ Gal(k̄_v/k_v) ≅ Ẑ`; a lift to `D_v`,
  and hence to `Gal(K̄/K)`, differs by inertia. The correct downstream use belongs to a future
  ArtinRepresentations roadmap and takes the form: a representation with finite image that is
  unramified at `v` kills `I_v`, so the image of *any* lift of arithmetic Frobenius is well
  defined up to conjugacy, and its characteristic polynomial is an invariant of `v`. That
  statement needs no absolute-Galois Frobenius class, and none is offered here.
- **No general Artin conductor**, no Artin integrality, and no general conductor–discriminant
  formula (→ ArtinRepresentations). The abelian conductor–discriminant formula is
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 9's.
- **No density statements.** Chebotarev and the distribution of Frobenius classes go to
  [L-functions PR #8](https://github.com/roed-math/TauCetiRoadmap/pull/8), on
  PrimeNumberTheoremAnd's declared path.
- **No local ramification theory.** Upper numbering, Herbrand's theorem and Hasse–Arf are
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 3's.
- Hensel's realizability criterion, extending Layer 3's common-index-divisor theory; relative
  integral bases and Steinitz classes; finiteness of power integral bases (Győry); arithmetic
  equivalence and Gassmann triples (the LMFDB's "sibling fields" and "arithmetically equivalent"
  data); the LMFDB `.i` ordering and canonical-polynomial certificate described above; unit
  certification beyond rank one; and the `Valued → ValuativeRel` migration of Layer 5's instances
  when mathlib completes the deprecation.

## Worked examples (acceptance criteria)

Each field catches a specific error class: a wrong normalization, a vacuous instance, a smuggled
hypothesis, a missing dyadic case. All numerics were re-verified computationally for this
roadmap (splitting data by factorization mod `p`; discriminants by the cubic formula). Decimal
values appear only as orientation and are never theorem targets; every asserted equality below is
exact. Each entry says which assertions are proved here and which are consumed.

- **`2.2.5.1` = ℚ(√5)**, presented by `θ` with `minpoly ℤ θ = X² − X − 1`.
  *Proved here:* `discr K = 5`; signature `(2,0)`; `torsionOrder = 2`; `Units.rank = 1`;
  `Subgroup.closure {θ} ⊔ torsion K = ⊤` by Layer 7's certification, hence
  `regulator K = Real.log ((1 + √5)/2)`; splitting, `p` splits ⟺ `legendreSym p 5 = 1`, that is
  `p ≡ ±1 mod 5`, with `2` inert since `5 ≡ 5 mod 8`.
  *Consumed:* `classNumber K = 1` from the pin's `isPrincipalIdealRing_of_abs_discr_lt`;
  the class-number-formula consistency check
  `dedekindZeta_residue = 2·log((1+√5)/2)/√5` from the pin's `dedekindZeta_residue`, which turns
  the certified regulator, the class number, and the discriminant into one equation and catches a
  wrong CNF normalization.
- **`2.0.4.1` = ℚ(i)**.
  *Proved here:* `discr K = −4` (⚠ the sign is Brill's theorem in action, `(−1)^{r₂} = −1`);
  `ℤ[i]` monogenic with index `1`; `2 = −i(1+i)²` is ramified with `e = 2`, and
  `v_P(𝔡) = 2 = e`, so the **wild** lower bound of Layer 6 is attained while the upper bound
  `e − 1 + v_P(e) = 1 + 2 = 3` is strict. This is the dyadic case that a tame-only exponent
  formula must not claim, and it is why Layer 6 states the wild bounds separately.
  *Consumed:* `classNumber K = 1` and `torsionOrder K = 4` from the pin; `discr = −4` also
  cross-checks TauCeti's landed `discr_cyclotomicField_four`.
- **`4.0.125.1` = ℚ(ζ₅)**, as `CyclotomicField 5 ℚ`.
  *Proved here:* the Frobenius data, `f(p) = orderOf (p : ZMod 5)ˣ`, with `2, 3, 7` inert
  (`f = 4`), `19` of type `f = 2, g = 2`, `11` split completely, and `5` totally ramified via
  `(1 − ζ)⁴`; the subfield lattice `{ℚ, ℚ(√5), ℚ(ζ₅)}`, of cardinality 3, matching the subgroup
  lattice of `C₄`.
  *Consumed:* `discr = 125` and signature `(0,4)` from `IsCyclotomicExtension.Rat.discr_prime`;
  `classNumber = 1` from the pin's `five_pid`; `torsionOrder = 10` and monogenicity (`ℤ[ζ₅]`)
  from the pin. The conductor–discriminant instance `∏_{χ mod 5} cond(χ) = 1·5·5·5 = 125` is
  **not** a target of this roadmap: it is
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 9's abelian
  conductor–discriminant theorem, quoted here only as a cross-check once that roadmap proves it.
- **`3.1.23.1`**, the non-Galois cubic `minpoly = X³ − X² + 1`, `disc(minpoly) = −23` squarefree,
  so `index θ = 1` and `discr K = −23`.
  *Proved here:* signature `(1,1)`; non-Galois with `S₃` Galois closure; no proper subfield;
  `Units.rank = 1` with the explicit unit `u = θ² − θ`, characterized by `θ·(θ² − θ) = −1`, so
  `u = −θ⁻¹`; `Subgroup.closure {u} ⊔ torsion K = ⊤` by Layer 7's certification, hence
  `regulator K = Real.log (θ² − θ)` exactly (numerically `≈ 0.2812`, for orientation only).
  Unramified splitting and cycle types, all instances of Layer 3's Dedekind theorem: `2` and `3`
  are inert, cycle type `(3)`; `5` and `7` have type `(1,2)`; `59` splits completely, cycle type
  `(1,1,1)`, that is `Frob = 1`. ⚠ Ramified `23` is listed **separately** and is not a
  cycle-type statement: `23 ∣ discr K`, so there is no Frobenius class at `23`, and the
  factorization `𝔭²𝔮` there comes from Kummer–Dedekind (Layer 3) together with the different
  (Layers 4 and 6). The root of `minpoly mod 23` is a double root at `16` and a simple root at
  `15`; nothing about a "cycle type at `23`" is asserted anywhere.
  ⚠ Also not asserted: that `59` is the *least* totally split prime. That would require a finite
  check at every smaller prime, which no milestone here performs. The claim is that `59` splits
  completely.
  *Consumed:* `classNumber K = 1` from the pin's PID criteria. The density-`1/6` statement for
  split primes is deliberately absent (Chebotarev → PR #8).
- **`3.1.503.1` = Dedekind's field**, `minpoly = X³ − X² − 2X − 8`, with
  `disc(minpoly) = −2012 = −4·503`, `index θ = 2`, `discr K = −503`.
  *Proved here:* `2` **splits completely** even though `minpoly mod 2 = x²(x+1)`, the
  index-divisor caveat as a theorem rather than a warning; `2` is a common index divisor
  (`∀ θ' : IntegralPrimitiveElement K, 2 ∣ index θ'`); hence `¬ NumberField.IsMonogenic K`. The
  citation anchor is Neukirch III §2 Ex. 1 ("außerwesentliche Diskriminantenteiler"). ⚠ This
  example is the reason Layer 3's polynomial-side corollary is hypothesized on `p ∤ f.discr` and
  not on "`p` unramified": here `2` is unramified in `K` and the factorization of `f mod 2`
  still lies about the splitting.
  *Consumed:* `classNumber K = 1` from the pin's PID criteria.
- **The dyadic quadratic law** (Layer 7): for squarefree `d ≡ 1 mod 4` with `θ = (1+√d)/2`, so
  `minpoly ℤ θ = X² − X + C ((1−d)/4)`, `2` splits ⟺ `d ≡ 1 mod 8`. This is unreachable from the
  landed `X² − d` presentation, whose exponent is even here, which is exactly the point: it is
  the test that no statement in Layers 3 or 7 has quietly acquired an oddness hypothesis.

## Ordering and parallelism

The layer numbering is a topological order, so any schedule that respects it is valid. The useful
extra information is which layers can run at the same time.

- **Layer 1** goes first: it is mostly consume-and-publish, plus the double-coset law.
- **Layer 2** needs Layer 1's dictionary, and Layer 2's `J^S` needs one statement from Layer 4
  (finiteness of the ramified set). Either sequence Layer 4's discriminant definition before
  Layer 2's abelian collapse, or state `S` as an abstract finite set of primes and instantiate it
  once Layer 4 lands; the first is simpler and is the recommended order.
- **Layer 3** needs Layer 1 (double cosets) and Layer 2 (Frobenius) for the cycle-type theorem.
  Its index material and its relative Dedekind–Kummer half need neither, and can run in parallel
  with Layer 2 from the start.
- **Layer 4** needs nothing from Layers 2–3 and can begin immediately; it is `Different.lean`
  completion plus `relNorm`.
- **Layer 5** is statement-expressible as soon as
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 0 lands, and
  proof-complete against their Layers 0–2. It needs Layer 4 for the discriminant-valuation
  formula and Layer 2 for the Frobenius comparison. Its four boundary statements (the
  `adicAbv` normalization lemma, the `e·f` matching, `D ≅ Gal(L_w/K_v)`, and the
  different-localization lemma) should be co-reviewed with that roadmap's authors.
- **Layer 6** needs Layer 5 and PR #2 **Layer 3**, not their Layers 0–2. It is the only layer
  here that consumes local higher ramification theory, and it cannot start before that lands.
- **Layer 7** needs Layers 1–3. Its unit certification needs nothing else and can run early;
  everything downstream that quotes a regulator waits on it.
- **Layer 8** assembles the rest, and its worked targets discharge alongside the layers that
  enable them; each example above names the layers it uses.

Layers 1–3 can therefore land well before PR #10's material, which only Layer 8 consumes, and
before PR #2 Layer 3, which only Layer 6 consumes. The xroblot and tb65536 refactor-onto flags in
Layers 1–2 convert those milestones to comparison-and-consume as the PRs land; check PR state at
implementation time, not just at roadmap time.

## References

- J. Neukirch, *Algebraic Number Theory*, Springer 1999, the primary source. Ch. I §2
  (integral bases, discriminants of bases), §8 (Dedekind extensions: (8.1)–(8.2) fundamental
  identity, **(8.3) Dedekind–Kummer via the conductor**, (8.4) finitely many ramified primes,
  (8.5) quadratic splitting, §8 Ex. 4–5 for the Galois closure and the index form of (8.3)), §9
  (Hilbert theory: (9.1) transitivity, (9.2) decomposition group, the double-coset bijection on
  p. 55, (9.3)/(9.6) the `Z`/`T` dictionary, (9.4)–(9.5) `D/I ≅ Gal(κ)`, §9 Ex. 2 the Frobenius
  automorphism, Ex. 4 totally-split-iff-closure), §10 (cyclotomic: (10.2) `ℤ[ζ]`, (10.3) the
  splitting law); Ch. II §8 (extensions of valuations, (8.3)–(8.4) semi-local structure and the
  norm/trace formulas), §9 (Galois theory of valuations, that is the global–local decomposition
  dictionary); Ch. III §2 (the different: (2.1)–(2.2) definition, tower and
  **localization (2.2)(iii)**, (2.4)–(2.5) the monogenic and gcd descriptions, (2.6) exact
  tame/wild exponents, (2.9) `𝔡 = N(𝔇)`, (2.10)–(2.12) the discriminant tower and ramified ⟺
  divides, §2 Ex. 1 Dedekind's non-monogenic cubic). Ch. VII §11 (the Artin conductor) and §13
  (density) are cited only as boundaries: both are outside this roadmap.
- J.-P. Serre, *Local Fields*, GTM 67. Ch. I §§4–7 (Dedekind decomposition), Ch. III (the
  different: localization and the monogenic case; §4 Prop. 8 for the tower identity behind
  Layer 6's permutation formula), Ch. IV §1 (the ramification filtration; Prop. 2 for
  `H_i = H ∩ G_i`; Prop. 4 for `v(𝔡) = Σ(#Gᵢ − 1)`, the source of Layer 6's exponent formula).
  Ch. VI §2 (the Artin conductor) is a boundary citation only. The local side of every Layer-5
  and Layer-6 statement follows
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s reading of this
  book.
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110. Ch. I (Dedekind theory, the decomposition
  group), Ch. III (the different and discriminant; alternative proofs of the Layer-4 material).
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7. Ch. I (ramification, the Frobenius
  automorphism, double cosets; the cleanest textbook treatment of Layer 1's non-Galois law),
  Ch. II–III (units, class groups, cyclotomic fields).
- D. A. Marcus, *Number Fields*, 2nd ed. (library list, not held locally). Ch. 2–3 (integral
  bases, the Dedekind–Kummer theorem, essential discriminant divisors; Dedekind's field appears
  in the Ch. 2–3 exercise track), Ch. 4 (decomposition, inertia and Frobenius via exercises), and
  the unit computations of Ch. 5 Ex. that Layer 7's certification formalizes. Mathlib's own
  class-number-formula citation.
- H. Cohen, *A Course in Computational Algebraic Number Theory*, GTM 138 (library list).
  §4.8 and §6.1 (Dedekind's criterion, index computations, the algorithmic side of Layers 3
  and 7), §5.7 (fundamental units by bounded search, the algorithmic form of Layer 7's
  certification).
- W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers*, 3rd ed. (library list).
  Ch. 4 (inessential discriminant divisors; Hensel's realizability criterion, the citation for
  the converse deliberately left out of Layer 3).
- L. C. Washington, *Introduction to Cyclotomic Fields*, GTM 83 (library list). Ch. 1–4
  (cyclotomic worked instances of Layers 2 and 6; the character-conductor dictionary that
  PR #6 owns).

## Provenance and coordination

- **Mathlib in motion** (§What is in motion): the xroblot Hilbert-theory wave
  (#41591/#35808/#35991/#36733/#36843/#37031, with #35802 merged 2026-06-08) and the tb65536
  inertia program (#40955/#40387/#40952/#40757 open; the `ramificationIdx`/`inertiaDeg`
  definition swap #41234/#41325 merged 2026-06/07) overlap Layers 1–2's consume-and-publish
  milestones. Every affected milestone above carries its flag, and the null-result list (no
  conductor, no Artin-symbol, no different-transitivity, no unit-certification PRs) delimits where
  this roadmap builds free of collision. Re-audit PR state when each layer starts.
- **TauCeti landed files** (§What TauCeti already has): authored under the Multiquadratic and
  EffectiveBounds roadmaps; the consume-and-generalize contract per file is spelled there. One
  landed file is amended: `SplitsCompletely.lean` keeps its general-base form `private`, and
  publishing it is a Layer-1 milestone, to be done as a narrowly scoped public-API change in
  coordination with its authors rather than by duplicating the theorem in a rival namespace.
- **[Multiquadratic](../Multiquadratic/README.md)** (merged): the boundary is that
  `(ℤ/2)ⁿ`-specific material stays there and the uniform statements live here. Its splitting law
  and sign-vector Frobenius are instances of Layers 1–2. ⚠ The narrow class group is **not**
  taken from this roadmap: under the current family contract
  [PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 1 owns `Cl⁺` and the
  surjection `Cl⁺ ↠ Cl`, Multiquadratic consumes them, and Layer 8's page map consumes them from
  PR #6.
- **[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2):** the conventions
  table adopts its Frobenius row verbatim. Layer 5 is the boundary, and the `adicAbv`
  normalization lemma, the `e·f` matching, the `D ≅ Gal(L_w/K_v)` isomorphism and the
  different-localization lemma are the four statements both roadmaps must recognize; co-review
  them there. Their Layer-0 lemma that `primesOver` is a singleton for local fields is theirs;
  the semi-local `Σ [L_w:K_v] = n` is this roadmap's. Ownership of ramification theory is stated
  once in §Cross-roadmap dependencies: their Layer 3 owns the local filtration and the local
  different formulas, and Layer 6 here owns only the comparison and the global corollaries.
- **[Global Class Field Theory PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6):**
  consumes Layer 2's `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` literally, in its own `J^{𝔪₀}`
  carrier, and consumes Layer 5's local-field instances and different localization. It supplies
  the narrow class group (its Layer 1) and the abelian conductor–discriminant formula (its
  Layer 9), the latter used here only as a cross-check on `ℚ(ζ₅)`. No conductor–discriminant
  statement is a milestone of this roadmap.
- **[Polynomial Galois Groups PR #10](https://github.com/roed-math/TauCetiRoadmap/pull/10):**
  consumes Layer 3's Dedekind theorem in `Polynomial.Gal.galActionHom` vocabulary, including the
  reducible case, and Layer 7's `S_n`-embedding; it owns resolvents, transitive-group
  classification and the `nTj` label semantics, which Layer 8 consumes back.
- **ArtinRepresentations** (future roadmap, not a current dependency): owns the general conductor
  object, Artin integrality, the general conductor–discriminant theorem, and whatever profinite
  Frobenius formalism it needs. Layer 6's permutation-action discriminant formula and finite
  ramification filtration are stated so that they can be recognized there as special cases. This
  roadmap forms no general conductor and claims no absolute-Galois Frobenius class.
- **[EffectiveBounds](../../Completed/EffectiveBounds/README.md)** (completed): its bounds
  discharge the worked examples' class-number targets, and Layer 3's index formula sharpens its
  discriminant inequality to an equation, which is a new statement rather than a modification.
- **FLT / kbuzzard-ClassFieldTheory**: `Mathlib/RingTheory/Frobenius.lean` (A. Yang) is
  FLT-adjacent infrastructure, and the `erd1/LCFT` local-CFT interface normalizes its Artin map
  at arithmetic Frobenius via `IsArithFrobAt` (see LocalFields §What is in motion). Layer 2's
  packaging stays translation-compatible with that shape, which the shared `IsArithFrobAt`
  vocabulary guarantees by construction.
- **Zulip**: threads audited 2026-07-30 as cited in §What is in motion; the instance's anonymous
  API is disabled, so decision-critical claims should be re-confirmed in `#maths` when the
  corresponding layer starts, per the root README's claims process (register an intention before
  Layers 2, 5 and 6 in particular).
