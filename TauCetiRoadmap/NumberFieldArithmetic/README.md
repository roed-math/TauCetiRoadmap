# Roadmap: number fields, ramification, Frobenius, and the LMFDB invariants

Mathlib's number-field library is strong. It has:

- rings of integers over a Dedekind base;
- the signed discriminant, with Brill's sign theorem and Hermite's finiteness theorem;
- finiteness of the class group;
- Dirichlet's unit theorem, and a regulator defined as a lattice covolume;
- the class number formula, at the residue of the Dedekind zeta function;
- the fundamental identity `Σ eᵢ·fᵢ = n`;
- Hilbert's ramification theory, through `D/I ≅ Gal(residue extension)`;
- the Kummer–Dedekind factorization theorem over `ℤ`, with matching `e` and `f`;
- the different ideal, with transitivity in towers;
- an arithmetic-Frobenius API;
- complete ramification theory of infinite places;
- cyclotomic fields, through their splitting law;
- adeles, with the product formula.

What Mathlib does not have is the connections between those pieces. Nothing instantiates the
Frobenius API for number fields: `Mathlib/RingTheory/Frobenius.lean` has no reverse
dependencies. The following are all absent:

- the Artin symbol;
- the cycle-type form of Dedekind's theorem;
- the relative Dedekind–Kummer theorem;
- the relative discriminant ideal;
- the exact tame and wild different exponents;
- Stickelberger's congruence;
- the double-coset splitting law for non-Galois extensions;
- the local-global dictionary at finite places, although the infinite-place analogue is
  complete;
- a monogenicity predicate;
- a certificate that a named unit generates the units modulo torsion;
- label semantics.

This roadmap builds those connections. The subject is the intrinsic arithmetic invariants of a
number field and the relations among them:

- degree and signature;
- the discriminant and the primes that ramify;
- the splitting type of a prime, and its Frobenius class;
- the different and the relative discriminant;
- integral bases, the index, and monogenicity;
- subfields;
- units, torsion, and the regulator.

An [LMFDB number-field page](https://www.lmfdb.org/NumberField/) shows what that list should
contain. Layer 8 goes through such a page datum by datum. For each datum it says whether the
datum is a theorem of this roadmap, or a datum this roadmap does not certify.

Suggested home: `TauCeti/NumberTheory/NumberField/` for the number-field layers, with
subdirectories `Splitting/`, `Frobenius/`, `ArtinSymbol/`, `DedekindTheorem/`, `Index/`,
`Different/`, `LocalGlobal/`, `Subfield/`, `Monogenic/`, `Units/`, and `LMFDB/`. The
Dedekind-generic halves go in `TauCeti/NumberTheory/RamificationInertia/` and
`TauCeti/RingTheory/DedekindDomain/`. These paths mirror the Mathlib paths that own each notion,
and extend the Tau Ceti files that already exist at exactly these paths.

## Prerequisites

Every milestone below lists its direct prerequisites. Each prerequisite is one of four kinds,
and nothing else is allowed:

- **Mathlib.** A declaration that exists in Mathlib at the pin.
- **Tau Ceti.** A declaration that exists in the Tau Ceti code repository.
- **Layer n.** An earlier milestone of this roadmap.
- **Roadmap R, Layer n.** A named layer of another roadmap in this repository.

No milestone here has a prerequisite of any other kind. In particular, no milestone waits on:

- a Mathlib pull request;
- a future pin;
- an external repository;
- a roadmap that does not yet exist.

Sometimes the mathematics needs an object that another roadmap will later own. In that case this
roadmap defines the object itself, under the name and the shape that other roadmap uses.
Layer 6.1 does this for the local ramification filtration. §Boundaries lists every such case.

## Boundaries

Two neighbouring roadmaps overlap this one. The boundaries are stated once here.

**Local Fields.** That roadmap develops the ramification theory of a single local field: the
lower and upper numbering filtrations, Herbrand's theorem, Hasse–Arf, and the local different
formulas. This roadmap develops the canonical completion maps, the comparison of global
ideal-theoretic invariants with local ones, and the global ideal and discriminant corollaries.
This roadmap needs one object from that subject, the local lower ramification filtration of
`L_w/K_v`. Layer 6 defines it, in the shape Serre uses, and proves the comparison theorem
against the global filtration. That definition is a compatibility interface. If a Local Fields
roadmap later supplies the same object, the definition here is deleted and the comparison
theorem is restated against theirs; nothing else changes.

**Global class field theory.** Reciprocity, ray class groups, the narrow class group, and the
abelian conductor–discriminant formula belong to that subject. This roadmap proves none of them.
Layer 2 constructs the ideal-theoretic Artin map. Its carrier is chosen so that a reciprocity
layer can use the map without change. Layer 2 proves nothing about its kernel or its image.

**Polynomial Galois groups.** Resolvents, the classification of transitive groups, and the `nTj`
label semantics belong to that subject. This roadmap proves none of them. Layer 3 proves the
factorization-type theorem in `Polynomial.Gal` vocabulary, which such a roadmap can use.

**Artin representations.** The general Artin conductor, Artin integrality, and the general
conductor–discriminant formula belong to that subject. This roadmap forms no general conductor.

What this roadmap supplies to other subjects:

- the polynomial-side Dedekind theorem (Layer 3);
- the `S_n`-embedding of the Galois closure of a number field (Layer 7);
- the ideal-theoretic Artin map `artinHomAway` (Layer 2);
- the local-field instance on `v.adicCompletion K`, and the localization of the different
  (Layer 5).

## Standing hypotheses

There are two regimes. Neither is bundled into a new class.

**Dedekind-generic regime.** This regime covers Layers 1 to 4 wherever the mathematics is not
about `ℚ`, and the different-exponent statements of Layer 6. It is Mathlib's AKLB setup:

- `A` is a Dedekind domain with fraction field `K`;
- `L/K` is a finite extension;
- `B` is the integral closure of `A` in `L`.

Spell it with the pin's own typeclasses: `[IsDedekindDomain A]`, `[IsFractionRing A K]`,
`[IsIntegralClosure B A L]`, `[Module.Finite A B]`, `[Module.IsTorsionFree A B]`, and
`[IsScalarTower A K L]`. Add residue hypotheses per statement, either
`[Algebra.IsSeparable (A ⧸ p) (B ⧸ P)]` or `[Finite (A ⧸ p)]`, exactly where the proof needs
them.

Two hypotheses are easy to add by accident. Do not assume finite residue fields in a statement
that holds without them. Do not assume residue separability where Mathlib's own
`sum_ramification_inertia` does without it.

⚠ Separability of `L/K` itself is needed for the exact different exponents of Layer 6. State it
as `[Algebra.IsSeparable K L]`, and keep the fraction fields visible in the signature. A
signature with two Dedekind domains and a finite torsion-free algebra between them cannot state
that hypothesis at all.

**Number-field regime.** This regime covers the LMFDB-facing layers. Use `[Field K]` and
`[NumberField K]` with `𝓞 K`. Write Galois groups as `K ≃ₐ[ℚ] K`, or `L ≃ₐ[K] L`. Present a
prime as `Q : Ideal (𝓞 K)` with instance arguments `[Q.IsPrime]`,
`[Q.LiesOver (Ideal.span {(p : ℤ)})]`, and `[Fact p.Prime]`. This is the idiom of the Tau Ceti
files that already exist. Present a concrete field by a generator: `{θ : 𝓞 K}` with
`(hmin : minpoly ℤ θ = …)` and `(hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)`, as in Tau Ceti's
`Quadratic/Splitting.lean`. Do not introduce a `QuadraticField` or `CubicField` structure.

⚠ Never assume `p ≠ 2`, except where the mathematics needs it. Quadratic-symbol statements need
it; almost nothing else does. The worked examples in §Worked examples contain dyadic cases for
this reason: the splitting of `2` in quadratic fields by `d mod 8`, and `2` as a common index
divisor. Those examples detect an unstated oddness hypothesis.

⚠ Never write `K = ℚ` into a statement whose proof is uniform in the base. The `ℚ`-versions are
corollaries. Tau Ceti's `SplitsCompletely.lean` keeps its general-base form `private`, and
Layer 1 publishes that shape.
## Pinned conventions

Decide these before implementation. An implementor who has to guess will guess differently in
two places.

| Object | Convention |
|---|---|
| Frobenius | **Arithmetic**: `σ x ≡ x^q mod Q`, with `q = Nat.card (A ⧸ Q.under A)`. This is Mathlib's `AlgHom.IsArithFrobAt` and `IsArithFrobAt`. "Frobenius" unqualified always means arithmetic. The geometric Frobenius is its inverse and is always called geometric. |
| Frobenius at a ramified prime | `IsArithFrobAt` is satisfiable at every prime with finite residue field. It is canonical only modulo inertia, by `IsArithFrobAt.mul_inv_mem_inertia`. "The Frobenius at `Q`" needs `Algebra.IsUnramifiedAt`. At a ramified prime only the coset `σ·I(Q)` is used. |
| Frobenius is a finite-level notion | Every Frobenius statement here lives in a finite Galois extension, or in the quotient `D_v/I_v ≅ Gal(k̄_v/k_v)`. There is no canonical Frobenius element, and no canonical conjugacy class, in `Gal(K̄/K)`. §Explicit scope exclusions states why. |
| Infinite places | The canonical element of the order-2 stabilizer at a real place that ramifies in `L` is complex conjugation, through `ComplexEmbedding.IsConj` and `IsCMField.complexConj`. It is never called a Frobenius. `IsRamified` and `IsUnramified` at infinite places are Mathlib's. |
| Artin symbol | `artinSymbol 𝔭 : ConjClasses (L ≃ₐ[K] L)`, for `𝔭 : Ideal (𝓞 K)` a nonzero prime that is unramified in `L`. The rational-prime form for `K = ℚ` is a corollary of it, not the definition. |
| Ideal-theoretic Artin map | `artinHomAway S hur : J^S →* (L ≃ₐ[K] L)`, for `L/K` finite abelian and `S` an arbitrary `Finset` of primes of `𝓞 K` that contains every prime that ramifies in `L`. `J^S` is the subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of fractional ideals with valuation zero at every prime of `S`. `S` is a parameter of the construction. Taking `S` to be the ramified support is Layer 4.2. The integral-ideal monoid homomorphism is a corollary. |
| Decomposition group | `MulAction.stabilizer G Q`, Mathlib's spelling. There is no second named definition. |
| Inertia group | `Q.inertia G`, that is `Ideal.inertia`. |
| Decomposition and inertia fields | Mathlib's `IsDecompositionField` and `IsInertiaField`. Mathlib is moving this API to ring level, on predicates of ideals rather than of fields, and §Provenance records that work. State Layer 1.3 so that the move is a change of the class name and nothing more. |
| Higher ramification groups | A family `G i` indexed by `i : ℕ`, so `G 0` is inertia. The decomposition group keeps its own name and is never written `G (-1)`. Where a statement needs the `−1` slot it names the stabilizer. |
| `e` and `f` | `P.ramificationIdx A` and `P.inertiaDeg A`, and the Galois-constant versions `ramificationIdxIn` and `inertiaDegIn`. ⚠ Mathlib has two definitions of each, with **different argument orders**. The unprimed names are the localization and residue-field definitions, and they take the prime of `B` first and the base **ring** `A` second. The primed names `ramificationIdx'` and `inertiaDeg'` are the supremum and quotient-rank definitions, and they take two **ideals**. `ramificationIdx'_eq_ramificationIdx` and `inertiaDeg'_eq_inertiaDeg` relate them. State a milestone through a characterization that holds for both. |
| Splitting type | The multiset `{(e₁,f₁), …, (e_g,f_g)}`. "Splits completely" is the count equation `(Ideal.primesOver (span {(p:ℤ)}) (𝓞 K)).ncard = finrank ℚ K`, which is Tau Ceti's convention. There is no new predicate. Cycle types use `Equiv.Perm.cycleType`, ⚠ which omits fixed points, so a partition-valued statement adds the `1`s back. |
| Discriminant, absolute | The signed `NumberField.discr K : ℤ`. Its sign is a theorem, `NumberField.sign_discr`, not a convention. The label uses `\|discr\|`, and the sign is recovered from the signature. |
| Discriminant, relative | A new ideal `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)`, in Layer 4.1. It is never conflated with the signed integer. The reconciliation `relDiscr ℤ (𝓞 K) = span {discr K}` is a named lemma. |
| Different | Mathlib's `differentIdeal A B : Ideal B`. |
| Valuation of an ideal at a prime | `v_P(I) := multiplicity P I`, for `P` a nonzero prime of a Dedekind domain. This matches Mathlib's `finprod_heightOneSpectrum_pow_multiplicity`. Every exponent formula in Layers 4 to 6 uses this one normalization. That includes `v_P(e)` for a natural number `e`, which means the multiplicity of `P` in `span {(e : B)}`. |
| Conductor | The only conductor formed anywhere in this roadmap is Mathlib's order conductor `conductor R x : Ideal S`, which Kummer–Dedekind uses, together with the number-field invariant `RingOfIntegers.exponent θ`. There is no Artin conductor object and no conductor exponent `f_𝔭(χ)`. |
| The power-basis index | ⚠ `RingOfIntegers.exponent θ` is **not** the `ℤ`-module index `[𝓞 K : ℤ[θ]]`. The two have the same prime divisors, which is Layer 3.4, and only the index satisfies `disc(minpoly θ) = index² · discr K`. The index is defined on the subtype `IntegralPrimitiveElement K` of integral generators, never by `Nat.card` on all of `𝓞 K`. |
| Completions at finite places | Mathlib's `v.adicCompletion K` for `v : HeightOneSpectrum (𝓞 K)`, with `FinitePlace K ≃ HeightOneSpectrum (𝓞 K)`. Local-field structure uses the `IsNonarchimedeanLocalField` vocabulary. ⚠ `adicCompletion` is `Valued`-based, and Mathlib is replacing `Valued` by `ValuativeRel`. Layer 5.1 states its instances through the compatibility layer. |
| The completion of an extension | For `w ∣ v`, the algebra structure of `L_w` over `K_v` is the canonical one of Layer 5.2. ⚠ Mathlib's own `Module.Finite K_v L_w` instead quantifies over an arbitrary `[Algebra K_v L_w] [ContinuousSMul K_v L_w] [IsScalarTower K K_v L_w]`. No theorem in this roadmap does that, because an arbitrary structure lets a statement be about the wrong extension. |
| Absolute values at finite places | Mathlib's `HeightOneSpectrum.adicAbv`, normalized by `absNorm v.asIdeal`. This is the normalization `‖x‖ = q^{−v(x)}`. Layer 5.1 states the agreement, and the product formula is the cross-check. |
| LMFDB intrinsic label prefix | `d.r.\|D\|`, with `d = finrank ℚ K`, `r = nrRealPlaces K`, and `\|D\| = (discr K).natAbs`. These three coordinates are intrinsic theorems. The database index `i` and the canonical defining polynomial are not part of the API. A full label such as `2.2.5.1` is used below only as an external name for a field. |

## What Mathlib supplies

Checked against the Mathlib revision this repository pins. The inventory is long because the
library is strong. Its purpose is that no gap claimed below is a guess.

- **Number fields and rings of integers.** `NumberField`, `NumberField.RingOfIntegers` (`𝓞 K`)
  with `IsDedekindDomain (𝓞 K)`, `Module.Free ℤ (𝓞 K)`, `IsIntegralClosure (𝓞 K) ℤ K`,
  `RingOfIntegers.basis`, `NumberField.integralBasis`, `RingOfIntegers.rank`, the relative
  instances such as `IsIntegralClosure (𝓞 L) (𝓞 K) L`, `Rat.ringOfIntegersEquiv : 𝓞 ℚ ≃+* ℤ`,
  the closure properties `of_module_finite`, `of_intermediateField` and `of_tower`, and the
  `MulSemiringAction G (𝓞 K)` instance for `G` acting on `K`.
- **Discriminants.** The signed `NumberField.discr K : ℤ`, with `discr_ne_zero` and base-change
  invariance. `NumberField.sign_discr` is Brill's theorem, and is not to be re-proved.
  `rootDiscr`; Minkowski's lower bounds `abs_discr_ge'` and `abs_discr_ge`; `abs_discr_gt_two`,
  which is Hermite–Minkowski; and `NumberField.finite_of_discr_bdd`, which is Hermite's theorem.
  `Algebra.discr b`, `Algebra.discr_powerBasis_eq_norm` (`disc = ± N(f′(θ))`), `discr_isIntegral`,
  and `discr_mul_isIntegral_mem_adjoin`.
- **Units, regulator, torsion.** `isUnit_iff_norm`; `NumberField.Units.torsion` with `IsCyclic`,
  `torsionOrder`, `rootsOfUnity_eq_torsion`, `even_torsionOrder`. `logEmbedding`, `unitLattice`,
  `NumberField.Units.rank`, `rank_modTorsion`, `fundSystem`, `exist_unique_eq_mul_prod`, and
  `closure_fundSystem_sup_torsion_eq_top`. `NumberField.Units.regulator`, defined as
  `ZLattice.covolume (unitLattice K)`, with `regulator_pos`, `regulator_eq_det`,
  `regOfFamily_eq_det`, and the index formula `regOfFamily_div_regulator`.
  ⚠ Nothing certifies that a **particular** unit generates modulo torsion. That is Layer 7.4, and
  without it no exact regulator value can be claimed.
- **Bounded-conjugate finiteness.** `NumberField.Embeddings.finite_of_norm_le` and
  `pow_eq_one_of_norm_eq_one`, which is Kronecker's theorem. This finiteness turns the condition "no unit lies strictly
  between `1` and `u`" into a finite check. Layer 7.4 names it as the proof method.
- **Class group and class number.** `RingOfIntegers.instFintypeClassGroup`,
  `NumberField.classNumber`, `classNumber_eq_one_iff`, `exists_ideal_in_class_of_norm_le`, and
  the practical criteria `isPrincipalIdealRing_of_abs_discr_lt` and
  `…_of_isPrincipal_of_mem_primesOver_of_mem_Icc`. `Rat.classNumber_eq` is the only computed
  class number in the library.
- **Dedekind zeta and the class number formula.** `NumberField.dedekindZeta`,
  `dedekindZeta_residue` (`2^{r₁}(2π)^{r₂}hR/(w√|d|)`), and
  `tendsto_sub_one_mul_dedekindZeta_nhdsGT`. ⚠ There is no Euler product, no continuation, and no
  functional equation. This roadmap uses the residue only as a cross-check on a worked example.
- **Ramification and inertia.** `Ideal.ramificationIdx` and `Ideal.inertiaDeg`, together with the
  supremum and quotient-rank forms `ramificationIdx'` and `inertiaDeg'` and the agreement lemmas
  between them. The Chinese remainder decomposition `S/pS ≅ ⊕ S/Pᵢ^{eᵢ}` and
  `Ideal.sum_ramification_inertia` (`Σ e·f = n`, for `p` maximal and nonzero, with no
  separability hypothesis). `MulAction G (primesOver p B)` with transitivity
  (`exists_smul_eq_of_isGaloisGroup`); `e` and `f` Galois-constant, with `ramificationIdxIn` and
  `inertiaDegIn`; `ncard_primesOver_mul_ramificationIdxIn_mul_inertiaDegIn` (`g·e·f = #G`); tower
  multiplicativity; and the inertia counts `card_inertia_eq_ramificationIdxIn` and
  `card_stabilizer_eq` (`#D = e·f`, which needs a separable residue extension).
  `IsDecompositionField` and `IsInertiaField` with all five degree formulas. The comparison
  `Algebra.isUnramifiedAt_iff_of_isDedekindDomain` (`e = 1 ↔ IsUnramifiedAt`) and
  `Algebra.IsUnramifiedIn`.
- **Decomposition-group machinery.** The pointwise `MulSemiringAction` on ideals,
  `Ideal.inertia_le_stabilizer`, and normality of inertia in the stabilizer. `Ideal.LiesOver`,
  `Ideal.under`, `Ideal.primesOver`, and
  `Ideal.Quotient.stabilizerHom : stabilizer G P →* ((B⧸P) ≃ₐ[A⧸p] (B⧸P))` with
  `ker_stabilizerHom`. ⚠ Argument-order trap: `Over.lean` takes the top ideal first, and
  `Invariant/Basic.lean` names the fibres the other way. `Algebra.IsInvariant`,
  `isInvariant_of_isGalois`, `orbit_eq_primesOver`, `IsFractionRing.stabilizerHom` with
  `stabilizerHom_surjective`, `Ideal.Quotient.stabilizerQuotientInertiaEquiv`
  (`D/I ≅ Gal((B⧸Q)/(A⧸P))`), `Ideal.Quotient.normal`, and `finite_of_isInvariant`.
  `stabilizerHom_surjective_of_profinite` for infinite Galois groups. The `IsGaloisGroup G A B`
  class **with the number-field instances** `IsGaloisGroup G (𝓞 K) (𝓞 L)` and
  `IsGaloisGroup G ℤ (𝓞 L)`. `galRestrict : Gal(L/K) ≃* (B ≃ₐ[A] B)`.
  ⚠ `Mathlib/RingTheory/Valuation/RamificationGroup.lean` is a stub with no theorems,
  disconnected from the ideal-theoretic API, and carrying an open TODO for higher ramification
  groups. Do not build on it.
- **Frobenius.** `Mathlib/RingTheory/Frobenius.lean` has the arithmetic-Frobenius API in the
  invariant-ring setting: `AlgHom.IsArithFrobAt`; the residue restriction
  `IsArithFrobAt.restrict` with `restrict_apply`; the roots-of-unity computation
  `IsArithFrobAt.apply_of_pow_eq_one`; uniqueness at unramified primes at `AlgHom` level,
  `eq_of_isUnramifiedAt`; the group-level `IsArithFrobAt R σ Q` with `mem_stabilizer`;
  `mul_inv_mem_inertia`; `conj`; existence, `exists_of_isInvariant`;
  `exists_primesOver_isConj`; the global choice `arithFrobAt R G Q`; and `isConj_arithFrobAt`.
  ⚠ **Nothing in Mathlib imports this file.** There is no number-field instantiation, no Artin
  symbol, no uniqueness in the group, no restriction lemma, and no order formula. That is
  Layer 2. `FiniteField.frobeniusAlgEquivOfAlgebraic` is the residue Frobenius, with its order
  and cyclicity; `FiniteField.exists_forall_apply_eq_pow` says every residue automorphism is a
  power of it.
- **Kummer–Dedekind.** The conductor-avoiding factorization
  `KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk`, with multiplicity
  matching, the multiset equality, `Ideal.irreducible_map_of_irreducible_minpoly` (whose converse
  is an open TODO in that file), and the span formula for each factor. `conductor R x` with
  `conductor_eq_top_iff_adjoin_eq_top` and `quotAdjoinEquivQuotMap`. Over `ℤ`:
  `RingOfIntegers.exponent θ` with `exponent_eq_one_iff` and `not_dvd_exponent_iff`,
  `monicFactorsMod θ p`, and `NumberField.Ideal.primesOverSpanEquivMonicFactorsMod` with the two
  matching lemmas for `f` and for `e`. ⚠ All of this is for `𝓞 K / ℤ` only. The relative AKLB
  version does not exist.
- **The different ideal.** `Submodule.traceDual`, `FractionalIdeal.dual` with the full involution
  API, `differentIdeal A B`, `differentIdeal_ne_bot`, and transitivity in towers,
  `differentIdeal_eq_differentIdeal_mul_differentIdeal`. `conductor_mul_differentIdeal`
  (`𝔣(x)·𝔡 = (f′(x))`, hence `𝔡 = (f′)` in the monogenic case),
  `aeval_derivative_mem_differentIdeal`, the tame-direction divisibility
  `pow_sub_one_dvd_differentIdeal` (`P^{e−1} ∣ 𝔡`), `dvd_differentIdeal_of_not_isSeparable`, and
  the ramification criterion `not_dvd_differentIdeal_iff` (`P ∣ 𝔡 ↔ ¬ Algebra.IsUnramifiedAt A P`;
  ⚠ in the root namespace, and two neighbouring lemmas are misspelled `differentialIdeal_…`).
  Different ideals under linear disjointness. `Algebra.IsUnramifiedAt` with
  `isUnramifiedAt_iff_map_eq`. The absolute reconciliations
  `NumberField.absNorm_differentIdeal` (`N(𝔡_{K/ℚ}) = |discr K|`), `discr_mem_differentIdeal`,
  `natAbs_discr_eq_absNorm_differentIdeal_mul_natAbs_discr_pow`, `discr_dvd_discr`,
  `not_dvd_discr_iff_forall_liesOver`, and `not_dvd_discr_iff_isUnramifiedIn`.
- **Cyclotomic fields.** `IsCyclotomicExtension` with `isGalois` and `isAbelianGalois`;
  `Rat.finrank = totient`; the ring of integers `ℤ[ζ]`; the discriminants
  `IsCyclotomicExtension.Rat.discr`, `discr_prime`, `discr_prime_pow`, and `natAbs_discr`;
  `autEquivPow` and `Rat.galEquivZMod : Gal(K/ℚ) ≃* (ZMod n)ˣ` with the restriction square
  `galEquivZMod_restrictNormal_apply`; the full splitting law, including total ramification at
  `p ∣ n` through `(1−ζ)`, `inertiaDeg_eq_of_not_dvd = orderOf (p : ZMod m)ˣ`,
  `ramificationIdx_eq_of_not_dvd = 1`, and the general `n = p^k·m` formulas; the decomposition
  subgroup `Rat.galEquivZMod_stabilizer` (⚠ the subgroup only: no statement identifies a
  Frobenius **element**, which is Layer 2.6); the character-theoretic Galois correspondence; the
  torsion order; and `Rat.three_pid` and `five_pid`. `DirichletCharacter/` has `conductor`,
  `isPrimitive`, Gauss sums, and orthogonality.
- **Infinite places.** `InfinitePlace`, `IsReal`, `IsComplex`, `mult`, `nrRealPlaces`,
  `nrComplexPlaces`, `card_add_two_mul_card_eq_rank` (`r₁ + 2r₂ = n`), and `prod_eq_abs_norm`.
  The Galois action on infinite places, `IsUnramified` and `IsRamified` (ramified means complex
  over real), stabilizers of order at most 2, `IsUnramifiedAtInfinitePlaces`, and the
  infinite-place fundamental identity `unramifedPlacesOver_ncard_add_eq_finrank` (⚠ Mathlib's own
  spelling, with the typo; quote it exactly). `IsTotallyReal`, `IsTotallyComplex`, and
  `maximalRealSubfield`. `IsCMField` with `complexConj`, `orderOf_complexConj`, and `StarRing`,
  which is the element Layer 2.7 names. `InfinitePlace.inertiaDeg` with
  `sum_inertiaDeg_eq_finrank`, the archimedean local-global identity. ⚠ Its finite-place
  analogue is absent, and is Layer 5.3.
- **Finite places, completions, adeles, product formula.** `NumberField.FinitePlace` with
  `FinitePlace.equivHeightOneSpectrum`; the normalized `HeightOneSpectrum.adicAbv`;
  `FinitePlace.norm_def` and `norm_lt_one_iff_mem`; `embedding v : K →+* adicCompletion K v`;
  `NormedField (adicCompletion K v)`; `IsDiscreteValuationRing (adicCompletionIntegers)`; finite
  multiplicative support; and `Module.Finite K_v L_w` under `LiesOver`, ⚠ which takes an
  arbitrary compatible algebra structure as input and so is not yet a statement about the
  canonical extension. `adicCompletion` and `adicCompletionIntegers` themselves.
  `NumberField.AdeleRing` over a general Dedekind base pair, `ringEquiv_mixedSpace`, weak
  approximation at infinite places, and `AdeleRing.principalSubgroup`.
  `NumberField.prod_abs_eq_one`, the product formula, and `FinitePlace.prod_eq_inv_abs_norm`.
  ⚠ There is no idele group and no compactness statement.
  `IsNonarchimedeanLocalField` is in `Mathlib/NumberTheory/LocalField/Basic.lean`, with the
  discrete-valuation-ring, finite-residue and completeness instances for an abstract local field.
  ⚠ The instance for `v.adicCompletion K` is missing, and is Layer 5.1.
- **Canonical embedding and geometry of numbers.** `mixedEmbedding`, convex bodies,
  `minkowskiBound`, the fundamental cone, and `NormLeOne`. This roadmap cites them only for the
  class-number discharges of the worked examples.
- **Galois correspondence.** `IsGalois.intermediateFieldEquivSubgroup`, the order-reversing
  lattice equivalence. `normalClosure` and `AlgEquiv.restrictNormal` with surjectivity.
  `Polynomial.Gal`, the transitive `galActionHom` into `Equiv.Perm (rootSet p E)` with
  `galActionHom_injective`, which is the permutation carrier for Layer 3.9.
  `DoubleCoset.Quotient`, the carrier for Layer 1.4.

## What Tau Ceti supplies

These files were written under the [Multiquadratic](../Multiquadratic/README.md) roadmap and the
completed [EffectiveBounds](../../Completed/EffectiveBounds/README.md) roadmap. This roadmap uses
them and generalizes them, so that the quadratic statements become instances of a uniform API.

One change to an existing file is planned, and Layer 1.1 names it: a theorem that is `private` in
`SplitsCompletely.lean` is published. That is a change of visibility, made with the agreement of
that file's authors. It is not a fork, and not a duplicate in a second namespace. Nothing else in
these files is edited.

- `TauCeti/NumberTheory/NumberField/Frobenius.lean`: `exists_isArithFrobAt` and
  `exists_isArithFrobAt_of_liesOver`, the base-`ℚ` instantiation of Mathlib's
  `exists_of_isInvariant`; and `isArithFrobAt_apply_sqrt` with
  `isArithFrobAt_apply_sqrt_eq_self_iff`. Layer 2.1 generalizes existence to `L/K`, and Layer 2.3
  builds the symbol on top.
- `TauCeti/NumberTheory/LegendreSymbol/Frobenius.lean`: the domain-generic
  `AlgHom.IsArithFrobAt.apply_sqrt` and `IsArithFrobAt.smul_sqrt`.
  `LegendreSymbol/SquareClass.lean`: square-class invariance of Legendre data.
- `TauCeti/NumberTheory/NumberField/SplitsCompletely.lean`: splits-completely as a count
  equation, with `ncard_primesOver_eq_finrank_iff` and `…_iff_stabilizer_eq_bot`, over `ℚ`.
  ⚠ The general-base form exists there but is `private`. Layer 1.1 publishes that shape.
- `TauCeti/NumberTheory/NumberField/Quadratic/Splitting.lean`:
  `ncard_primesOver_quadratic_iff`, for odd `p` with `p ∤ d`. Layer 3.6 has this as its degree-2
  corollary. The `p = 2` and `d ≡ 1 mod 4` cases it excludes are worked targets here.
- `TauCeti/NumberTheory/NumberField/IntegralSqrt.lean` and
  `Internal/QuadraticIntegralBasis.lean`: `integralSqrt` and the `{1, x}` quadratic integral
  basis. Layer 7.2 gives the full `d mod 4` statement.
- `TauCeti/NumberTheory/RamificationInertia/Galois.lean`:
  `ncard_primesOver_eq_natCard_iff_of_isGaloisGroup`. Layer 1.1 extends this file.
- `TauCeti/NumberTheory/Multiquadratic/`: the sign-vector Galois theory, `MultiquadraticSplitting`,
  the prime-discriminant layer, and `Multiquadratic/Frobenius.lean`, which identifies the
  Frobenius with the Legendre sign vector. This is the `(ℤ/2)ⁿ` instance of Layers 1 and 2.
  Anything specific to `(ℤ/2)ⁿ` stays there, and the uniform statements are here.
- `TauCeti/NumberTheory/EffectiveBounds/` and `GeometryOfNumbers/`:
  `abs_discr_le_of_basis_isIntegral`, `card_ideal_absNorm_le`, `classNumber_le_bound`,
  `units_sq_index_eq`, `regulator_eq_one_of_rank_eq_zero`, `discr_cyclotomicField_four = -4`, and
  the Hermite count. Layer 3.3 sharpens the first of these from an inequality to an equation.
- Conventions that the code repository enforces, and that this roadmap adopts: `TauCeti.*`
  namespaces that mirror Mathlib paths, with bare Mathlib namespaces only when extending the API
  of an existing Mathlib definition; the module system; `Internal/` for shared helpers that are
  not headline results; dated `@[deprecated]` wrappers; and provenance sections in module
  docstrings.

## What is missing

The complete list, in one place.

- A uniform Frobenius and Artin-symbol API over number fields, at finite level: the number-field
  instantiation of `IsArithFrobAt`; uniqueness in the group at an unramified prime; the
  conjugacy-class-valued Artin symbol at a prime ideal of the base; the abelian collapse and the
  fractional-ideal Artin homomorphism; `orderOf Frob = f`; behaviour under restriction and in
  towers; the identification with the residue-field Frobenius; the cyclotomic and quadratic
  element identifications; and complex conjugation as the canonical element at a ramified real
  place.
- The relative Dedekind–Kummer theorem with matching `e` and `f`, together with the converse of
  `irreducible_map_of_irreducible_minpoly`.
- The power-basis index, with `disc(minpoly θ) = index² · discr K`, and the comparison of its
  prime divisors with those of `RingOfIntegers.exponent`.
- Dedekind's criterion over `ℤ`.
- Dedekind's theorem, that the factorization type is the Frobenius cycle type, with the
  common-index-divisor theory that bounds its hypotheses.
- The relative discriminant ideal, with its tower formula and its `relNorm`-of-different
  description; the `Algebra.discr` tower formula; Stickelberger's congruence.
- The canonical completion of an extension at a finite place, and the whole finite-place
  local-global dictionary: `Σ [L_w:K_v] = n`, `[L_w:K_v] = e·f`, `D_Q ≅ Gal(L_w/K_v)`, norm and
  trace, local monogenicity, localization of the different, and the
  `IsNonarchimedeanLocalField` instance on a completion.
- The global ramification consequences carried through that dictionary: the lower filtration and
  its comparison with the local one, the different-exponent formula, the exact tame and wild
  exponents, and the permutation-action discriminant formula.
- The double-coset splitting law for non-Galois extensions, and totally-split in the Galois
  closure.
- The subfield lattice, the monogenicity predicate with its quadratic, cyclotomic and Dedekind
  examples, and explicit unit certification.
- Intrinsic LMFDB label-prefix semantics, with a fully computed worked suite.

None of this exists in Mathlib as stated. Every part that can be used is cited above.
---

## The build, in layers

The eight layers are a dependency order. Every milestone rests on Mathlib, on Tau Ceti, or on an
earlier layer. There are no forward references. Each milestone lists its direct prerequisites.
Each new object lists the basic API that must accompany it. Each hard theorem records its
source, its true hypotheses, and a nearby false statement.

`Suggested.lean` holds a suggested Lean signature for the milestones whose carrier, index type,
or map determines the layers below. It is not a checklist, and it is not exhaustive.

### Layer 1: the splitting dictionary

#### 1.1 The relative splitting criteria

For `L/K` finite over an arbitrary Dedekind base, and Galois where stated, prove the equivalence
of three conditions on a prime `p`:

- the number of primes over `p` equals `[L:K]`;
- `e = 1` and `f = 1` at every prime over `p`;
- the decomposition group at every prime over `p` is trivial.

Tau Ceti's `SplitsCompletely.lean` proves this over `ℚ`, and keeps the general-base form
`private`. This milestone publishes that form. It is a change to the visibility of an existing
declaration, made with the agreement of that file's authors. Do not restate the theorem in a
second namespace.

*Prerequisites:* Tau Ceti `NumberField/SplitsCompletely.lean`; Mathlib
`Ideal.sum_ramification_inertia`, `Ideal.card_stabilizer_eq`.

#### 1.2 Unramified sets of primes

Write a statement about a set of primes being unramified with explicit quantification over the
primes of the set. This mirrors Mathlib's archimedean `IsUnramifiedAtInfinitePlaces`.

⚠ Do not introduce a Tau Ceti `IsUnramifiedIn` wrapper. Mathlib has `Algebra.IsUnramifiedIn`,
and a quantified statement uses it directly.

*Prerequisites:* Mathlib `Algebra.IsUnramifiedIn`, `Algebra.IsUnramifiedAt`.

#### 1.3 The prime-in-subfield dictionary

Let `Z` be the decomposition ring and `T` the inertia ring of `P` over `p`. Prove:

- `P` is the only prime of `L` over `P ∩ Z`;
- `e(P∩Z/p) = 1` and `f(P∩Z/p) = 1`;
- `f(P∩T/P∩Z) = f` and `e(P∩T/P∩Z) = 1`.

State these on Mathlib's `IsDecompositionField` and `IsInertiaField`. Mathlib is moving the same
API to ring level, on predicates of ideals rather than of fields, and `PROVENANCE.md` records
that work. Write the statements so that the move changes the class name and nothing else. State the degree
and index formulas through `Ideal.under`, `ramificationIdx` and `inertiaDeg` of the ideals. Do
not state them through the intermediate field.

*Source:* Neukirch I (9.3) and (9.6).

*Prerequisites:* Mathlib `IsDecompositionField`, `IsInertiaField`,
`Ideal.Quotient.stabilizerHom`, `Ideal.card_stabilizer_eq`; Layer 1.1.

#### 1.4 The double-coset law for non-Galois splitting

Let `M/K` be Galois with group `G`. Let `L` be the fixed field of `H ≤ G`. Let
`D = MulAction.stabilizer G Q` for a prime `Q` of `M` over `p`, and let `I = Q.inertia G`. Build
a bijection

```text
doubleCosetEquiv : DoubleCoset.Quotient H D ≃ Ideal.primesOver p (𝓞 L)
```

and prove that it sends `HσD` to `σQ ∩ L`. Then prove the invariant formulas:

- `e(𝔮_σ/p) · f(𝔮_σ/p) = |HσD| / |H| = [σDσ⁻¹ : H ∩ σDσ⁻¹]`;
- `e(𝔮_σ/p) = [σIσ⁻¹ : H ∩ σIσ⁻¹]`;
- `Σ_σ |HσD| / |H| = [L:K]`, which recovers the fundamental identity.

**New object: `doubleCosetEquiv`.** Basic API:

- *Constructors and instances.* The map, its inverse, and decidability of the index type where a
  count is needed.
- *Examples.* `H = 1`, which recovers the Galois case; `H = D`, which gives a single prime.
- *Morphisms and functoriality.* Behaviour under enlarging `H`, that is, under passing to a
  subfield of `L`.
- *Comparison lemmas and naturality.* The value formula `HσD ↦ σQ ∩ L`; compatibility with the
  `G`-action on `primesOver`.
- *Edge cases.* `p` ramified, where `I ≠ 1` and the two invariant formulas differ; `p` inert.
- *Downstream interfaces.* Layer 1.5 and Layer 3.9 both use the bijection, not merely the count.

*Source:* Neukirch I §9, page 55, where the proof is left to the reader. Janusz Ch. I gives a
complete treatment.

*Hypotheses:* `M/K` Galois and finite. `Q` a nonzero prime of `𝓞 M`. No separability hypothesis
on residue fields is needed for the bijection.

*False generalization:* the formula `e·f = [σDσ⁻¹ : H ∩ σDσ⁻¹]` does not split into separate
formulas for `e` and for `f` by replacing `D` with `I` and with `D/I`. Only the `e` half is a
subgroup index of that kind. The `f` half is an index of images in the quotient, and it is not
`[σ(D/I)σ⁻¹ : H̄ ∩ σ(D/I)σ⁻¹]` in general, because `H ∩ σDσ⁻¹` need not surject onto its image.

*Prerequisites:* Mathlib `DoubleCoset.Quotient`, `Ideal.primesOver`, `Ideal.inertia`,
`Algebra.IsInvariant`, `orbit_eq_primesOver`; Layer 1.3.

#### 1.5 Totally split in `L` and in the Galois closure

Prove that `p` is totally split in `L` if and only if `p` is totally split in the Galois closure
of `L`. Prove the compositum statements:

- `p` totally split in `L₁` and in `L₂` if and only if `p` is totally split in `L₁L₂`;
- `p` unramified in `L₁` and in `L₂` implies `p` unramified in `L₁L₂`.

*Source:* Neukirch I §9 Exercise 4.

*Prerequisites:* Layer 1.4; Mathlib `IntermediateField.normalClosure`,
`Algebra.IsUnramifiedAt`.

### Layer 2: Frobenius elements and the Artin symbol

Mathlib has the whole Frobenius machinery in one file with no reverse dependencies: existence,
conjugacy across a fibre, uniqueness modulo inertia, and uniqueness at unramified primes at
`AlgHom` level. This layer instantiates it for number fields and builds the symbol on top. Every
statement uses `IsArithFrobAt`, with no second definition, and every statement lives in a finite
Galois extension.

#### 2.1 Existence of the relative Frobenius

For `L/K` finite Galois and `Q` a nonzero prime of `𝓞 L`, produce
`σ : L ≃ₐ[K] L` with `IsArithFrobAt (𝓞 K) σ Q`. Discharge the hypotheses of Mathlib's
`IsArithFrobAt.exists_of_isInvariant` once: `Finite (L ≃ₐ[K] L)`,
`Algebra.IsInvariant (𝓞 K) (𝓞 L) (L ≃ₐ[K] L)`, and `Finite (𝓞 L ⧸ Q)`.

⚠ The exponent is `Nat.card (𝓞 K ⧸ Q.under (𝓞 K))`, the residue cardinality of the **base**. It
is not `N(Q)`.

*Prerequisites:* Mathlib `IsArithFrobAt.exists_of_isInvariant`, `IsGaloisGroup (𝓞 K) (𝓞 L)`;
Tau Ceti `NumberField/Frobenius.lean` (`exists_isArithFrobAt`, the base-`ℚ` case).

#### 2.2 Uniqueness at unramified primes, in the Galois group

Mathlib proves uniqueness at `AlgHom` level. Upgrade it to `σ = τ` in the Galois group, by
faithfulness, and record `Subsingleton {σ // IsArithFrobAt (𝓞 K) σ Q}` at unramified `Q`.

At a ramified `Q` the honest statement is Mathlib's `mul_inv_mem_inertia`: the Frobenius is
well defined only modulo `Q.inertia`.

*Prerequisites:* Mathlib `AlgHom.IsArithFrobAt.eq_of_isUnramifiedAt`, `IsGaloisGroup.faithful`,
`IsArithFrobAt.mul_inv_mem_inertia`; Layer 2.1.

#### 2.3 The Artin symbol

For `𝔭` a nonzero prime of `𝓞 K`, unramified in `L`, define

```text
artinSymbol 𝔭 : ConjClasses (L ≃ₐ[K] L)
```

as the common conjugacy class of the Frobenius elements at the primes over `𝔭`.

**New object: `artinSymbol`.** Basic API:

- *Constructors and instances.* Well-definedness, from conjugacy across the fibre together with
  uniqueness at an unramified prime.
- *Examples.* Cyclotomic and quadratic fields, in Layer 2.6.
- *Morphisms and functoriality.* Compatibility with `AlgEquiv.restrictNormalHom`; the tower
  formula `Frob_{L/M}(Q) = Frob_{L/K}(Q)^{f(Q∩M/𝔭)}`.
- *Comparison lemmas and naturality.* `Frob (σ • Q) = σ (Frob Q) σ⁻¹`;
  `orderOf (Frob Q) = f(Q/𝔭)`; `Subgroup.zpowers (Frob Q) = MulAction.stabilizer` at an
  unramified `Q`; the image of `Frob Q` under `Ideal.Quotient.stabilizerHom` is
  `FiniteField.frobeniusAlgEquivOfAlgebraic`.
- *Edge cases.* `𝔭` ramified, where the symbol is not defined and only the coset modulo inertia
  exists; `L/K` abelian, where the class is a single element (Layer 2.5).
- *Downstream interfaces.* Layer 2.5 and Layer 3.9.

⚠ The symbol is indexed by a prime **ideal** of `𝓞 K`. The familiar `(p, K/ℚ)` for a rational
prime is the `K = ℚ` corollary, obtained by taking `𝔭 = Ideal.span {(p : ℤ)}`. It is not the
primary statement.

*Source:* Neukirch I §9 Exercise 2.

*Prerequisites:* Mathlib `IsArithFrobAt.isConj_arithFrobAt`, `Ideal.card_stabilizer_eq`,
`Ideal.Quotient.stabilizerHom`, `FiniteField.frobeniusAlgEquivOfAlgebraic`; Layers 2.1 and 2.2.

#### 2.4 Functoriality of the Frobenius

For `K ⊆ M ⊆ L` with `M/K` Galois, prove

```text
IsArithFrobAt (𝓞 K) σ Q → IsArithFrobAt (𝓞 K) (σ.restrictNormal M) (Q.under (𝓞 M)).
```

Nothing like this exists in Mathlib. The cyclotomic square `galEquivZMod_restrictNormal_apply` is
the only restriction statement there, and it is not about Frobenius elements.

*Prerequisites:* Mathlib `AlgEquiv.restrictNormal`, `Ideal.under`; Layer 2.1.

#### 2.5 The ideal-theoretic Artin map

For `L/K` abelian the symbol is a single element of `Gal(L/K)`. Extend it multiplicatively.

The excluded set is a parameter. Take any `S : Finset (HeightOneSpectrum (𝓞 K))`, together with
the hypothesis that every prime outside `S` is unramified in `L`. Nothing in the construction
needs to know which primes ramify.

Milestones, in order:

1. the carrier `J^S ≤ (FractionalIdeal (𝓞 K)⁰ K)ˣ`, the fractional ideals with valuation zero at
   every prime of `S`, and its generation by the primes outside `S`;
2. the Artin element at a prime outside `S`, from Layer 2.3 and the abelian collapse;
3. the multiplicative extension `artinHomAway S hur : J^S →* (L ≃ₐ[K] L)`, well defined by
   unique factorization;
4. its value at a prime ideal;
5. functoriality in `L`;
6. the restriction to the monoid of integral ideals prime to `S`.

**New object: `artinHomAway`.** Basic API:

- *Constructors and instances.* The carrier `J^S`; the map; generation of `J^S` by primes.
- *Examples.* `S` the ramified support (Layer 4.2); `S` the support of a modulus, which is the
  case a reciprocity roadmap needs.
- *Morphisms and functoriality.* Behaviour under `S ⊆ S'`; functoriality in `L`; the integral
  restriction.
- *Comparison lemmas and naturality.* The value at a prime, which determines the map.
- *Edge cases.* `S = ∅`, allowed only when `L/K` is unramified everywhere; `L = K`, where the map
  is trivial.
- *Downstream interfaces.* A global class field theory roadmap uses this map without change.
  For that reason the carrier is `(FractionalIdeal (𝓞 K)⁰ K)ˣ`, and not a new type.

Its kernel, its image, and its factorization through ray class groups are not stated here.

*Prerequisites:* Mathlib `FractionalIdeal`, `FractionalIdeal.count`,
`UniqueFactorizationMonoid`; Layer 2.3.

#### 2.6 Computations

*Cyclotomic.* For `K` a cyclotomic field of conductor `n` and `p` coprime to `n`, prove
`galEquivZMod n K (Frob Q) = ZMod.unitOfCoprime p hp`. Mathlib has both halves,
`IsArithFrobAt.apply_of_pow_eq_one` and `galEquivZMod_apply_of_pow_eq`, but not the
identification.

*Quadratic.* Let `K = ℚ(√d)`, presented by `θ : 𝓞 K` with `minpoly ℤ θ = X² − C d` and
`Algebra.adjoin ℚ {(θ : K)} = ⊤`. Let `p` be a rational prime with `p` odd and `p ∤ d`, and let
`Q` be a prime of `𝓞 K` over `p`. Prove `Frob Q = 1` if and only if `legendreSym p d = 1`.

*Hypotheses:* all four hypotheses are part of the statement. `p` odd and `p ∤ d` make `p`
unramified and make the Legendre symbol available. The two hypotheses on `θ` make it a generator
whose exponent is prime to `p`.

*Prerequisites:* Mathlib `IsCyclotomicExtension.Rat.galEquivZMod`, `legendreSym`; Tau Ceti
`LegendreSymbol/Frobenius.lean`, `Quadratic/Splitting.lean`; Layer 2.3.

#### 2.7 The canonical element at a ramified real place

Let `w` be a real place of `K` that ramifies in `L`. The stabilizer of a place of `L` above `w`
has order 2. Name its generator: it is complex conjugation. Give the basic API: order 2,
compatibility with restriction, and the fixed field.

⚠ This element is not called a Frobenius anywhere. At an infinite place the local Galois group is
`Gal(ℂ/ℝ)`. There is no residue field and no congruence `σ x ≡ x^q`.

*Prerequisites:* Mathlib `ComplexEmbedding.IsConj`, `IsCMField.complexConj`,
`InfinitePlace.IsRamified`.

### Layer 3: the index, Dedekind–Kummer, and Dedekind's theorem

The index material comes first. The polynomial-side hypothesis `p ∤ f.discr` has to be converted
into the conductor hypothesis that Kummer–Dedekind takes, and that conversion is the index
comparison. Nothing later in the layer may assume it.

#### 3.1 The power-basis index

Define the carrier of integral generators and the index on it:

```text
IntegralPrimitiveElement K := {θ : 𝓞 K // Algebra.adjoin ℚ {(θ : K)} = ⊤}
index θ : ℕ                                  -- the cardinality of 𝓞 K ⧸ ℤ[θ]
```

Prove `0 < index θ`. Both modules are free of rank `finrank ℚ K`, so the quotient is finite.

⚠ Do not define an index by `Nat.card` for every `θ : 𝓞 K`. A non-generator gives an infinite
quotient, and Mathlib's `Nat.card` then returns `0`. Every divisibility statement about that
value would be true for a trivial reason.

**New object: `index`.** Basic API:

- *Constructors and instances.* The subtype `IntegralPrimitiveElement`, its coercion to `𝓞 K`,
  and `Nontrivial` where needed.
- *Examples.* `index θ = 1` for `ℤ[i]`; `index θ = 2` for Dedekind's cubic.
- *Morphisms and functoriality.* Behaviour under `θ ↦ θ + n` and `θ ↦ −θ`, which do not change
  the index.
- *Comparison lemmas and naturality.* Layer 3.3 and Layer 3.4.
- *Edge cases.* `K = ℚ`, where the index is `1` for every generator.
- *Downstream interfaces.* Layers 3.7, 3.11, and 7.3.

*Prerequisites:* Mathlib `Algebra.adjoin`, `NumberField.RingOfIntegers.basis`, `Module.Free`.

#### 3.2 The discriminant of a power basis

Prove `Algebra.discr ℚ (powerBasis θ) = Polynomial.discr (minpoly ℤ θ)` under the canonical maps.
Both objects exist in Mathlib and are never connected there.

*Prerequisites:* Mathlib `Algebra.discr`, `Polynomial.discr`, `Algebra.discr_powerBasis_eq_norm`.

#### 3.3 The index formula

Prove `Polynomial.discr (minpoly ℤ θ) = (index θ)² · NumberField.discr K` for
`θ : IntegralPrimitiveElement K`. This sharpens Tau Ceti's `abs_discr_le_of_basis_isIntegral`
from an inequality to an equation.

*Prerequisites:* Layers 3.1 and 3.2; Mathlib `NumberField.discr`, `Algebra.discr_of_matrix_vecMul`;
Tau Ceti `EffectiveBounds/`.

#### 3.4 Index and exponent have the same prime divisors

Prove `p ∣ index θ ↔ p ∣ RingOfIntegers.exponent θ` for `p` prime.

⚠ The two invariants are different integers in general. `RingOfIntegers.exponent θ` is the
`absNorm` of the contracted order conductor. Only the index satisfies the formula of Layer 3.3.
The statement about prime divisors is what lets one be used in place of the other in a
hypothesis.

*Prerequisites:* Mathlib `RingOfIntegers.exponent`, `conductor`, `Ideal.absNorm`; Layer 3.1.

#### 3.5 The checkable hypothesis

Prove `¬ (p : ℤ) ∣ Polynomial.discr (minpoly ℤ θ) → ¬ p ∣ RingOfIntegers.exponent θ`.

Every polynomial-side statement below uses this implication. It is a named theorem, not a step
inside another proof, and not a hypothesis of the statements that need it.

*Prerequisites:* Layers 3.3 and 3.4.

#### 3.6 The relative Dedekind–Kummer theorem

Mathlib has the `𝓞 K / ℤ` case, with matching `inertiaDeg` and `ramificationIdx`. Generalize it
to AKLB. Let `θ` generate `L/K`, and let `p` be coprime to `conductor A θ`. Then the primes of
`B` over `p` correspond to the monic irreducible factors of `minpoly A θ mod p`. Along that
correspondence, prove:

- `fᵢ` is the degree of the factor;
- `eᵢ` is its multiplicity;
- the span formula for each factor;
- the converse of `irreducible_map_of_irreducible_minpoly`, which is an open TODO in Mathlib's
  file.

Tau Ceti's `ncard_primesOver_quadratic_iff` becomes the degree-2 corollary.

*Source:* Neukirch I (8.3).

*Prerequisites:* Mathlib `KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk`,
`conductor_eq_top_iff_adjoin_eq_top`, `NumberField.Ideal.primesOverSpanEquivMonicFactorsMod`.

#### 3.7 Dedekind's criterion, over `ℤ`

The criterion divides by `p`, and that has no base-free meaning, so it is stated for the base
`ℤ`. A relative version would need a chosen uniformizer and explicit localization hypotheses. It
is not a milestone.

Let `θ : IntegralPrimitiveElement K`, let `f = minpoly ℤ θ`, and let `p` be prime. Write

```text
f mod p = ∏ᵢ φᵢ^{eᵢ},   the φᵢ distinct monic irreducibles of 𝔽_p[X],   each eᵢ > 0,
```

so that the index set is exactly the set of irreducibles that occur. Choose monic lifts
`Φᵢ : ℤ[X]`. Prove that every coefficient of `f − ∏ᵢ Φᵢ^{eᵢ}` is divisible by `p`, and set
`H := (f − ∏ᵢ Φᵢ^{eᵢ}) / p`. Then

```text
¬ p ∣ index θ  ↔  ∀ i, eᵢ = 1 ∨ ¬ φᵢ ∣ (H mod p).
```

Milestones: independence of the criterion from the choice of lifts; the coefficientwise
divisibility statement, so that `H` is well defined in `ℤ[X]`; the criterion itself; and the
corollary `Squarefree (f mod p) → ¬ p ∣ index θ`.

*Source:* Cohen §6.1.

*Hypotheses:* `θ` is an integral generator. Every `eᵢ` is positive.

*False generalization:* the criterion fails if the index set is allowed to contain an `i` with
`eᵢ = 0`. Such an `i` changes neither the factorization nor `H`, but its `φᵢ` would still have to
divide `H mod p` for the right-hand side to hold.

*Prerequisites:* Layers 3.1 and 3.6; Mathlib `Polynomial.map`, `ZMod`, `UniqueFactorizationMonoid`.

#### 3.8 Splitting fields of rational polynomials are number fields

For `0 ≠ f : ℚ[X]`, give the instance `NumberField f.SplittingField`. Without it, Layer 3.9 can be stated only in an
auxiliary Galois number field where `f` splits. The transfer back to `Polynomial.Gal` is then
left implicit.

*Prerequisites:* Mathlib `Polynomial.SplittingField`, `NumberField`,
`Polynomial.IsSplittingField.finiteDimensional`.

#### 3.9 Dedekind's theorem

Suggested name: `TauCeti.NumberField.factorizationType_eq_cycleType_isArithFrobAt`.

Let `K = ℚ(θ)` and `f = minpoly ℤ θ`. Let `p` satisfy `p ∤ RingOfIntegers.exponent θ`, with
`f mod p` squarefree. Let `M` be a Galois number field in which `f` splits, and let `σ` be a
Frobenius at a prime of `𝓞 M` over `p`. Then the multiset of degrees of the monic irreducible
factors of `f mod p` equals the cycle type of `σ` acting on the roots. Read both as partitions
of `n`.

Proof outline: Layer 1.4 identifies the primes of `K` over `p` with the orbits of `⟨Frob⟩` on
`H\G`, that is, on the roots. Layer 3.6 identifies those primes with the factors. The two
identifications match sizes.

*Source:* Neukirch I §8 Exercises 4 and 5; Marcus Ch. 4.

*Hypotheses:* `p ∤ exponent θ` **and** `f mod p` squarefree. Together they force `p` unramified
in `K`, but that is a consequence and not a substitute. `p ∤ disc f` implies both, by Layer 3.5,
and is the checkable form.

*False generalization:* "`p` unramified in `K`" does not suffice. Dedekind's field
`ℚ[x]/(x³ − x² − 2x − 8)` has `2` unramified, yet `f mod 2 = x²(x+1)` while `2` splits completely.
See §Worked examples.

⚠ `Equiv.Perm.cycleType` omits fixed points. The statement adds `Multiset.replicate #fixed 1`.

*Prerequisites:* Layers 1.4, 2.1, 3.5, 3.6, 3.8; Mathlib `Polynomial.Gal.galActionHom`,
`Equiv.Perm.cycleType`, `RingOfIntegers.monicFactorsMod`.

#### 3.10 The polynomial-side corollary, for arbitrary monic `f`

For monic `f : ℤ[X]` and a prime `p ∤ f.discr`, produce `σ : (f.map ℚ).Gal` whose root action has
full cycle type, with fixed points restored, equal to the factor-degree multiset of `f mod p`.

A polynomial Galois groups roadmap uses this interface on **reducible** `f`, to derive the
classical mod-`p` irreducibility criterion. The reduction to the irreducible case is five named
lemmas, not an afterthought:

1. `p ∤ f.discr` gives `f.discr ≠ 0`. So `f` is separable over `ℚ`, and by Gauss
   `f = ∏ⱼ fⱼ` with the `fⱼ` distinct monic irreducibles of `ℤ[X]`.
2. `f.discr = (∏ⱼ fⱼ.discr) · (∏_{j<k} Res(fⱼ, f_k))²`. So `p` divides no factor discriminant
   and no resultant, and the `fⱼ mod p` are squarefree and pairwise coprime.
3. `rootSet f` is the disjoint union of the `rootSet fⱼ`, the Galois action respects the
   decomposition, and full cycle type is additive along it;
4. the factor-degree multiset of `f mod p` is the sum of those of the `fⱼ mod p`;
5. one Frobenius `σ` at one prime of a Galois number field containing all the roots restricts to
   a Frobenius on the closure of each `ℚ(θⱼ)`.

*Prerequisites:* Layers 2.4, 3.8, 3.9; Mathlib `Polynomial.discr`, `Polynomial.resultant`,
`Polynomial.Gal.restrict`.

#### 3.11 Common index divisors

Define: `p` is a common index divisor of `K` if `p ∣ index θ` for **every**
`θ : IntegralPrimitiveElement K`.

Prove the counting obstruction. Suppose the splitting type of `p` in `K` needs more monic
irreducible polynomials of some degree `d` over `𝔽_p` than exist. Then `p` is a common index
divisor, and `𝓞 K` is not monogenic.

*Source:* Neukirch III §2 Exercise 1.

*Hypotheses:* the elementary direction only. The converse is Hensel's criterion: the common index
divisors are exactly the primes whose splitting type is not realizable modulo `p`. That converse
is outside this roadmap, and §References cites Narkiewicz for it.

*Prerequisites:* Layers 3.1, 3.6, 3.7; Mathlib `Polynomial.Monic`, `Irreducible`,
`Ideal.primesOver`.
### Layer 4: the relative discriminant

Mathlib's `Different.lean` is strong, and it includes transitivity. This layer adds the
discriminant ideal that Mathlib never defines, and the identities that need nothing beyond it.
Everything whose proof runs through a completion is in Layer 6.

#### 4.1 The relative discriminant ideal

Define `relDiscr A B : Ideal A := Ideal.relNorm A (differentIdeal A B)`.

**New object: `relDiscr`.** Basic API:

- *Constructors and instances.* The definition; `relDiscr A B ≠ ⊥`, from
  `differentIdeal_ne_bot` and injectivity of `relNorm` on nonzero ideals.
- *Examples.* `relDiscr ℤ (𝓞 K) = Ideal.span {NumberField.discr K}`, the reconciliation with the
  signed integer. The sign comes from `NumberField.sign_discr` and is not part of the ideal.
- *Morphisms and functoriality.* Multiplicativity in towers:
  `relDiscr A C = (relDiscr A B)^{[M:L]} · relNorm A (relDiscr B C)`.
- *Comparison lemmas and naturality.* Localization at a prime of `A`; behaviour under base
  change.
- *Edge cases.* `B = A`, where the ideal is `⊤`; an inseparable extension, where
  `differentIdeal` is `⊥` and the definition is not useful.
- *Downstream interfaces.* Layer 4.2, Layer 5.9, Layer 6.5, Layer 8.2.

Prove the ramification criterion: `p` ramifies in `B` if and only if `p ∣ relDiscr A B`. Mathlib
has the `ℚ`-only form `not_dvd_discr_iff_forall_liesOver`. State the general form.

⚠ `relDiscr` is an ideal of `A`. Do not conflate it with the signed integer `NumberField.discr`.

*Source:* Neukirch III (2.9), (2.10), and (2.12).

*Prerequisites:* Mathlib `differentIdeal`,
`differentIdeal_eq_differentIdeal_mul_differentIdeal`, `Ideal.relNorm`,
`NumberField.absNorm_differentIdeal`, `NumberField.sign_discr`,
`not_dvd_differentIdeal_iff`.

#### 4.2 The ramified support

Define `ramifiedSupport L/K`, the set of primes of `𝓞 K` that divide `relDiscr (𝓞 K) (𝓞 L)`.
Prove that it is finite, being the set of prime divisors of a nonzero ideal of a Dedekind domain.
Prove that a prime lies outside it exactly when that prime is unramified in `L`.

Finiteness makes the ramified set a `Finset`. Layer 2.5 takes a `Finset` as its parameter, so
this milestone produces the classical Artin map on the fractional ideals prime to the
discriminant. The dependency runs in this direction only. Layer 2.5 does not use `relDiscr`.

*Prerequisites:* Layers 2.5 and 4.1; Mathlib `UniqueFactorizationMonoid.factors`,
`Ideal.finite_factors`.

#### 4.3 Discriminants of bases

Prove the `Algebra.discr` tower formula
`disc_{M/K}(compatible bases) = disc_{L/K}^{[M:L]} · N(disc_{M/L})`.

*Prerequisites:* Mathlib `Algebra.discr`, `Algebra.discr_of_matrix_vecMul`, `Algebra.norm`.

#### 4.4 Stickelberger's congruence

Prove `NumberField.discr K % 4 ∈ {0, 1}`.

Proof outline: split the Leibniz expansion of the embedding determinant into the even and the odd
permutations. The two halves are conjugate algebraic integers, say `a` and `b`. Their sum and their product
are therefore rational integers, and the discriminant is `(a − b)² = (a + b)² − 4ab`.

*Source:* Stickelberger 1897; Narkiewicz Ch. 4.

*Hypotheses:* none beyond `[NumberField K]`.

*False generalization:* the congruence is about the **absolute** discriminant. There is no
corresponding statement for `relDiscr A B`, which is an ideal and has no residue modulo 4.

*Prerequisites:* Mathlib `NumberField.discr`, `Algebra.discr`, `Matrix.det_apply`.

⚠ Scope note. The exact exponents are not in this layer. They are `v_P(𝔡) = e − 1` in the tame
case, and `e ≤ v_P(𝔡) ≤ e − 1 + v_P(e)` in the wild case. Their proofs complete, so they are
Layer 6.4, after the Layer 5 dictionary exists.

### Layer 5: the global-local dictionary at finite places

This layer builds the finite-place analogue of Mathlib's complete archimedean theory. Every
comparison map is a named object with a characteristic property. An existence statement fixes a map mathematically, but
leaves later theorems with nothing to refer to. A `Nonempty (… ≃ …)` statement does not even do
that.

⚠ Mathlib's own `Module.Finite K_v L_w` instance quantifies over an arbitrary
`[Algebra K_v L_w] [ContinuousSMul K_v L_w] [IsScalarTower K K_v L_w]`. A theorem stated that way
is a theorem about an arbitrary compatible structure, and can be about the wrong extension.
Nothing in this layer does that.

#### 5.1 Completions are local fields

For `v : HeightOneSpectrum (𝓞 K)`, give the instance
`IsNonarchimedeanLocalField (v.adicCompletion K)`. The class is Mathlib's. The missing part is
the instance chain, from Mathlib's `NormedField`, the discrete valuation ring of integers, and
the finite residue field. State the full class. Local compactness is a corollary, not the target.

With it, prove:

- the residue-field identification `𝓀(K_v) ≅ 𝓞 K ⧸ v.asIdeal`;
- the residue cardinality `Ideal.absNorm v.asIdeal`;
- that Mathlib's `adicAbv`, normalized by `absNorm`, equals the normalization `‖x‖ = q^{−v(x)}`.

The product formula is the cross-check on the normalization.

⚠ `adicCompletion` is `Valued`-based, and Mathlib is replacing `Valued` by `ValuativeRel`. State
the instances through the compatibility layer, so that the move to `ValuativeRel` is a change of
one instance and not a new proof.

*Prerequisites:* Mathlib `IsNonarchimedeanLocalField`,
`IsDedekindDomain.HeightOneSpectrum.adicCompletion`, `adicCompletionIntegers`,
`NumberField.FinitePlace.equivHeightOneSpectrum`, `NumberField.prod_abs_eq_one`.

#### 5.2 The canonical completion of an extension

For `w : HeightOneSpectrum (𝓞 L)` with `w.asIdeal.LiesOver v.asIdeal`, define

```text
completionAlgHom v w : K_v →ₐ[K] L_w
```

by continuous extension of `K → L`.

**New object: `completionAlgHom`.** Basic API:

- *Constructors and instances.* The map; continuity; the induced `Algebra K_v L_w`; the derived
  `IsScalarTower K K_v L_w` and `ContinuousSMul K_v L_w`; `Module.Finite K_v L_w` for that
  instance.
- *Examples.* `L = K`, where the map is the identity; an unramified `w`, where `L_w/K_v` is
  unramified of degree `f`.
- *Morphisms and functoriality.* Transitivity in a tower `K ⊆ M ⊆ L`.
- *Comparison lemmas and naturality.* **Uniqueness**: any continuous ring map `K_v → L_w` that
  extends `K → L` equals this one. The compatibility square with `K → L`.
- *Edge cases.* Several `w` over one `v`, where the maps differ and the index `w` is not
  optional.
- *Downstream interfaces.* Layers 5.3 to 5.9, and Layer 6.

Mathlib's `Module.Finite K_v L_w` for an arbitrary structure is then a corollary of the version
for this instance.

*Source:* Neukirch II §6.

*Prerequisites:* Mathlib `UniformSpace.Completion.extensionHom`,
`HeightOneSpectrum.denseRange_algebraMap`, `Module.Finite`; Layer 5.1.

#### 5.3 Semi-local structure

Write `W v` for the subtype `{w : HeightOneSpectrum (𝓞 L) // w.asIdeal.LiesOver v.asIdeal}`.
Define

```text
semilocalEquiv v : K_v ⊗[K] L  ≃ₐ[K_v]  ∏ (w : W v), L_w
```

and prove its value on pure tensors:

```text
semilocalEquiv v (a ⊗ₜ x) w = algebraMap K_v L_w a * algebraMap L L_w x.
```

The value on pure tensors is what determines the map. Write the completion on the left of the
tensor product, so that the `K_v`-algebra structure on the source is Mathlib's
`Algebra.TensorProduct.leftAlgebra`. Neukirch writes `L ⊗_K K_v`, which is the same object.

Name the equivalence `W v ≃ Ideal.primesOver v.asIdeal (𝓞 L)` as well, so that both spellings are
available.

Consequence: `Σ_{w ∣ v} [L_w : K_v] = [L : K]`, the finite-place analogue of Mathlib's
archimedean `InfinitePlace.sum_inertiaDeg_eq_finrank`.

*Source:* Neukirch II (8.3).

*Hypotheses:* `L/K` finite and separable. Separability is automatic for number fields.

*False generalization:* the statement fails for an inseparable finite extension of general
fields. `𝔽_p(t^{1/p}) ⊗_{𝔽_p(t)} 𝔽_p(t)_v` is not a product of fields; it has nilpotents.

*Prerequisites:* Layer 5.2; Mathlib `Algebra.TensorProduct.leftAlgebra`,
`Ideal.primesOver`, `Algebra.IsSeparable`.

#### 5.4 Norm and trace

For `x : L`, prove

```text
algebraMap K K_v (Algebra.norm K x)   = ∏_{w ∣ v} Algebra.norm K_v (algebraMap L L_w x)
algebraMap K K_v (Algebra.trace K L x) = Σ_{w ∣ v} Algebra.trace K_v L_w (algebraMap L L_w x)
```

These are also what proves the localization of the different, in Layer 5.8.

*Source:* Neukirch II (8.4).

*Prerequisites:* Layer 5.3; Mathlib `Algebra.norm`, `Algebra.trace`.

#### 5.5 Invariant matching

Prove `[L_w : K_v] = e(w ∣ v) · f(w ∣ v)`, with `e` and `f` the **global**
`Ideal.ramificationIdx` and `Ideal.inertiaDeg`.

*Prerequisites:* Layers 5.1 and 5.2; Mathlib `Ideal.ramificationIdx`, `Ideal.inertiaDeg`,
`IsNonarchimedeanLocalField`.

#### 5.6 The decomposition group is the local Galois group

Under `IsGalois K L`, continuous extension gives

```text
decompositionHom v w : MulAction.stabilizer (L ≃ₐ[K] L) w.asIdeal →* (L_w ≃ₐ[K_v] L_w).
```

**New object: `decompositionHom`.** Basic API:

- *Constructors and instances.* The map.
- *Examples.* `w` unramified over `v`, where the group is cyclic of order `f`.
- *Morphisms and functoriality.* Compatibility with the `L ≃ₐ[K] L`-action on the primes over
  `v`. Written out: `decompositionHom v (σ • w) ∘ conj σ = conj (…) ∘ decompositionHom v w`.
- *Comparison lemmas and naturality.* The defining property
  `decompositionHom v w σ (algebraMap L L_w x) = algebraMap L L_w (σ x)`; injectivity, from the
  density of `L` in `L_w`; surjectivity; the resulting `MulEquiv`; compatibility with the residue
  maps; and the statement that an `IsArithFrobAt` element maps to the local Frobenius.
- *Edge cases.* `w` ramified, where the group is larger than the residue Galois group.
- *Downstream interfaces.* Layer 6.2, which is an equality of subgroups along this map.

*Source:* Neukirch II §9.

*Prerequisites:* Layers 2.1, 5.2, 5.5; Mathlib `MulAction.stabilizer`,
`IsFractionRing.stabilizerHom`, `stabilizerHom_surjective`.

#### 5.7 The completed local extension is monogenic

Prove that `𝓞_{L_w}` is generated over `𝓞_{K_v}` by one element:

```text
∃ x : w.adicCompletionIntegers L, Algebra.adjoin (v.adicCompletionIntegers K) {x} = ⊤.
```

Proof outline: the residue extension is an extension of finite fields, hence simple; lift a
residue generator and adjoin a uniformizer.

This milestone is what makes Layer 6 self-contained. With it, Mathlib's
`conductor_mul_differentIdeal` computes the local different as `(g′(x))`, and Layer 6.3 follows
by a valuation count.

*Source:* Serre, *Local Fields*, III §6 Proposition 12.

*Hypotheses:* a complete discrete valuation ring with a **finite**, hence separable, residue
extension. Number fields satisfy this everywhere.

*False generalization:* the statement fails for a complete discrete valuation ring with an
inseparable residue extension. Serre gives the standard counterexample in III §6, Remark.

*Prerequisites:* Layers 5.1 and 5.2; Mathlib `IsDiscreteValuationRing`,
`FiniteField.exists_forall_apply_eq_pow`, `Algebra.adjoin`.

#### 5.8 The different localizes

The canonical map carries `𝓞_{K_v}` into `𝓞_{L_w}`, and the resulting extension is torsion-free.
Both are part of this milestone, because `differentIdeal` cannot be formed without them. Then
prove

```text
(differentIdeal (𝓞 K) (𝓞 L)).map (algebraMap (𝓞 L) (w.adicCompletionIntegers L))
  = differentIdeal (v.adicCompletionIntegers K) (w.adicCompletionIntegers L).
```

State it with the ideal map, not as multiplication by `𝓞_{L_w}`.

*Source:* Neukirch III (2.2)(iii).

*Prerequisites:* Layers 5.2 and 5.4; Mathlib `differentIdeal`, `Ideal.map`,
`Module.IsTorsionFree`.

#### 5.9 The relative discriminant valuation

In the multiplicity normalization of §Pinned conventions, prove

```text
v_𝔭(relDiscr (𝓞 K) (𝓞 L)) = Σ_{P ∣ 𝔭} f(P/𝔭) · v_P(differentIdeal (𝓞 K) (𝓞 L)).
```

The residue-degree weights come from `Ideal.relNorm P = 𝔭 ^ f(P/𝔭)`. Every exponent computation
of Layer 6 reduces to this formula.

*Prerequisites:* Layers 4.1 and 5.5; Mathlib `Ideal.relNorm`, `multiplicity`.

### Layer 6: global ramification consequences

This layer computes the exponents of the different and of the discriminant. It uses the Layer 5
dictionary and nothing beyond it.

#### 6.1 The local lower filtration

Define, for the local extension `L_w/K_v` and `i : ℕ`,

```text
localRamificationGroup i := {τ | ∀ x : 𝓞_{L_w}, τ x − x ∈ 𝔪_{L_w}^{i+1}},
```

a subgroup of `L_w ≃ₐ[K_v] L_w`. Prove that it is a decreasing chain of normal subgroups, that
`localRamificationGroup 0` is the inertia subgroup, and that the chain is eventually trivial.

⚠ This definition is a compatibility interface. The subject of the local ramification filtration
belongs to a local fields roadmap. This roadmap defines the object because Layer 6.2 compares
against it and cannot be stated otherwise. If a local fields roadmap supplies the same object,
delete this definition and restate Layer 6.2 against theirs. Nothing else in this roadmap
changes. The definition here uses Serre's shape, so the replacement is mechanical.

*Source:* Serre, *Local Fields*, IV §1.

*Prerequisites:* Layers 5.1 and 5.2; Mathlib `IsLocalRing.maximalIdeal`, `AlgEquiv`.

#### 6.2 The global filtration, and the comparison

For `L/K` Galois, `Q` a prime of `𝓞 L` over `𝔭`, and `i : ℕ`, define

```text
ramificationGroup Q i := {σ ∈ MulAction.stabilizer (L ≃ₐ[K] L) Q | ∀ x : 𝓞 L, σ x − x ∈ Q^(i+1)}.
```

**New object: `ramificationGroup`.** Basic API:

- *Constructors and instances.* The subgroup structure; normality in the stabilizer;
  `ramificationGroup Q 0 = Q.inertia`; eventual triviality.
- *Examples.* `2` in `ℚ(i)`, where `G_0 = G_1 = ℤ/2` and `G_2 = 1`; an unramified `Q`, where
  `G_0 = 1`.
- *Morphisms and functoriality.* Conjugation: `ramificationGroup (σ • Q) i = σ (ramificationGroup Q i) σ⁻¹`.
- *Comparison lemmas and naturality.* **The comparison theorem**: an element `σ` of the
  stabilizer lies in `ramificationGroup Q i` if and only if `decompositionHom v w σ` lies in
  `localRamificationGroup i`. This is an equality of subgroups along a named map, not an abstract
  isomorphism, because every computation below moves an element across it.
- *Edge cases.* `i` large, where the group is trivial; `Q` ramified but tame, where `G_1 = 1`.
- *Downstream interfaces.* Layers 6.3, 6.4, and 6.5.

⚠ The decomposition group is not a member of this family. It keeps its own name,
`MulAction.stabilizer`, and is never written `G (-1)`.

*Prerequisites:* Layers 5.6 and 6.1; Mathlib `Ideal.inertia`, `galRestrict`,
`MulAction.stabilizer`.

#### 6.3 The different-exponent formula

Prove `v_Q(differentIdeal (𝓞 K) (𝓞 L)) = Σ_{i ≥ 0} (#(G i) − 1)`.

Proof outline: Layer 5.7 gives a generator `x` of the completed local ring. Mathlib's
`conductor_mul_differentIdeal` then gives `𝔡 = (g′(x))` for `g` the minimal polynomial of `x`.
Expand `g′(x) = ∏_{τ ≠ 1} (x − τ x)`, and count: `v(x − τ x) ≥ i + 1` exactly when `τ` lies in
the `i`-th local group. Layers 5.8 and 6.2 carry the result back to `𝓞 L`.

*Source:* Serre, *Local Fields*, IV §1 Proposition 4.

*Hypotheses:* `L/K` Galois. The formula is false without it, because the left side is defined
while the right side is not.

*Prerequisites:* Layers 5.7, 5.8, 6.1, 6.2; Mathlib `conductor_mul_differentIdeal`,
`aeval_derivative_mem_differentIdeal`.

#### 6.4 Exact tame and wild exponents

Prove:

- `v_P(𝔡) = e − 1` when the extension is tame at `P`, that is, `ringChar (A ⧸ 𝔭) ∤ e`;
- `e ≤ v_P(𝔡) ≤ e − 1 + v_P(e)` in the wild case, where `v_P(e)` is the multiplicity of `P` in
  `span {(e : B)}`, in the same normalization as `v_P(𝔡)`.

Mathlib has only the divisibility `P^{e−1} ∣ 𝔡`.

A formulation by divisibility alone, `P^{e−1+v_P(e)+1} ∤ 𝔡`, is acceptable if the additive
valuation of an ideal is awkward. State whichever is used, and use the same one across the layer.

*Source:* Neukirch III (2.6); Serre, *Local Fields*, III §6 Proposition 13.

*Hypotheses:* a finite **separable** extension of fraction fields. Without separability the trace
form vanishes, `differentIdeal` is the zero ideal, and `v_P(𝔡)` is a value with no meaning. State
the hypothesis as `[Algebra.IsSeparable K L]` in a signature where the fraction fields appear.
`Suggested.lean` carries the number-field instance, where separability is automatic.

*False generalization:* the tame formula does not extend to the wild case with `e − 1` replaced
by `e`. In `ℚ(i)` at `P = (1 + i)` the exponent is `2 = e`, so the lower bound is attained; the
upper bound `e − 1 + v_P(e) = 1 + 2 = 3` is strict. Both bounds are therefore sharp in different
examples, and neither is an equality in general.

*Prerequisites:* Layer 6.3; Mathlib `pow_sub_one_dvd_differentIdeal`, `ringChar`,
`multiplicity`.

#### 6.5 The permutation-action discriminant exponent formula

For `L/K` Galois with group `G`, `H ≤ G`, `M = L^H`, `Q` a prime of `𝓞 L` over `𝔭`, and
`𝔮 = Q ∩ 𝓞 M`, prove

```text
e(Q/𝔮) · v_𝔮(differentIdeal (𝓞 K) (𝓞 M)) = Σ_{i ≥ 0} (#(G i) − #(G i ⊓ H)).
```

Both sides are integers, and no conductor object appears. The right side is a fixed-point count
for the action of `G i` on `G/H`: `#(G i ⊓ H)` is the number of elements of `G i` that fix the
base point.

Proof: transitivity of the different, from Mathlib; the subgroup compatibility `H_i = H ∩ G_i`;
and Layer 6.3. Combined with Layer 5.9 and the enumeration of Layer 1.4, this computes
`v_𝔭(relDiscr (𝓞 K) (𝓞 M))`.

*Source:* Serre, *Local Fields*, IV §1 Proposition 2 and IV §2.

*Prerequisites:* Layers 1.4, 5.9, 6.2, 6.3; Mathlib
`differentIdeal_eq_differentIdeal_mul_differentIdeal`.

⚠ No conductor object. This roadmap defines no Artin conductor and no conductor exponent
`f_𝔭(χ)`. It also defines no ideal whose exponents are the sum `Σ_i |G_i|/|G_0| · (…)`; that sum
is rational before Artin's integrality theorem. The only conductor formed anywhere in this
roadmap is the order conductor of §Pinned conventions.
### Layer 7: subfields, integral bases, monogenicity, and explicit units

#### 7.1 The subfield dictionary

For an arbitrary number field `K` with Galois closure `M`, package Mathlib's
`IsGalois.intermediateFieldEquivSubgroup`:

- the lattice of subfields of `K` corresponds, order-reversing, to the subgroups between
  `Gal(M/K)` and `Gal(M/ℚ)`;
- the counting statements;
- the embedding `Gal(M/ℚ) ↪ S_n` through `Polynomial.Gal.galActionHom`, with transitivity
  equivalent to irreducibility.

Worked targets: the three subfields of `ℚ(ζ₅)`; the cubic field of discriminant `−23` has no
proper subfield.

*Prerequisites:* Mathlib `IsGalois.intermediateFieldEquivSubgroup`,
`IntermediateField.normalClosure`, `Polynomial.Gal.galActionHom`; Layer 3.8.

#### 7.2 Integral bases of quadratic fields

Give `𝓞_{ℚ(√d)}` with the case split on `d mod 4`: `ℤ[√d]` when `d ≡ 2, 3`, and `ℤ[(1+√d)/2]`
when `d ≡ 1`. Give the discriminant, `4d` and `d` respectively.

The splitting law for `2` by `d mod 8` is the acceptance test for this milestone.

*Prerequisites:* Tau Ceti `NumberField/IntegralSqrt.lean`,
`Internal/QuadraticIntegralBasis.lean`; Layers 3.6 and 3.7.

#### 7.3 Monogenicity

Define the predicate in the `NumberField` namespace, as a property of the field:

```text
NumberField.IsMonogenic (K : Type*) [Field K] [NumberField K] : Prop :=
  ∃ θ : 𝓞 K, Algebra.adjoin ℤ {θ} = ⊤
```

**New object: `IsMonogenic`.** Basic API:

- *Constructors and instances.* The definition; the criterion `exponent θ = 1`.
- *Examples.* Quadratic fields; cyclotomic fields, from Mathlib; `ℚ(i)`.
- *Morphisms and functoriality.* Monogenicity is not inherited by subfields, and this is worth a
  counterexample rather than a lemma.
- *Comparison lemmas and naturality.* `IsMonogenic K ↔ ∃ θ, index θ = 1`, from Layer 3.4.
- *Edge cases.* `K = ℚ`, which is monogenic; Dedekind's cubic, which is not.
- *Downstream interfaces.* Layer 8.2.

⚠ Search Mathlib for an existing `IsMonogenic` before writing this, and keep it out of the root
namespace. A bare `IsMonogenic` would collide with a future ring-theoretic version. If such a
version exists, make this an abbreviation for it.

*Prerequisites:* Layers 3.1, 3.4, 3.11; Mathlib `RingOfIntegers.exponent_eq_one_iff`,
`Algebra.adjoin`.

#### 7.4 Explicit unit certification, rank one

Mathlib's Dirichlet theorem gives a fundamental system, and `regOfFamily_div_regulator` gives the
index of a candidate family. Nothing in Mathlib certifies that a **named** unit generates modulo
torsion. Without such a certificate no exact regulator value can be asserted, so this milestone
comes before every worked example that states one.

For `K` with `NumberField.Units.rank K = 1` and `u : (𝓞 K)ˣ`, build three statements.

1. *The criterion.* `Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤` if and only if no
   unit `v` satisfies `0 < ‖logEmbedding v‖ < ‖logEmbedding u‖`.
2. *The finiteness that makes the criterion checkable.* A unit with a bounded log embedding has
   bounded archimedean absolute values. Mathlib's `NumberField.Embeddings.finite_of_norm_le`
   then applies, and the candidate set is finite. For a real quadratic field, or a cubic field
   of signature `(1,1)`, this is a finite search over integral minimal polynomials with bounded
   coefficients. That is the proof method the worked examples use.
3. *The evaluation.* From `regOfFamily_div_regulator` with index `1`, and `regOfFamily_eq_det`:

   ```text
   regulator K = w.mult * Real.log (w u)   for any infinite place w with 1 < w u.
   ```

⚠ "Mathlib has Dirichlet's unit theorem" is not a proof that the index is one. No worked example
may cite it as one.

⚠ Do not drop `mult`. In rank one there are exactly two infinite places. The identity
`Σ_w mult w · log (w u) = log |N(u)| = 0` makes the two choices of `w` agree. A version without
`mult` is wrong at every field with a complex place: the regulator of `ℚ(ζ₅)` is
`2·log((1+√5)/2)`, not `log((1+√5)/2)`. Mathlib's `logEmbedding` carries `mult` for this reason.

⚠ `Real.log` is applied to `w u`, a real number. There is no `Real.log` of an element of `K` or
of `𝓞 K`, so every exact regulator statement names an infinite place.

*Source:* Cohen §5.7 for the search method.

*Hypotheses:* rank exactly one. The criterion is false at higher rank, where minimality at one
place does not give generation.

*Prerequisites:* Mathlib `NumberField.Units.rank`, `logEmbedding`, `regOfFamily_div_regulator`,
`regOfFamily_eq_det`, `NumberField.Embeddings.finite_of_norm_le`.

### Layer 8: the intrinsic label prefix and the invariant suite

#### 8.1 The intrinsic prefix predicate

Define

```text
HasLMFDBIntrinsicLabel K d r D :=
  finrank ℚ K = d ∧ nrRealPlaces K = r ∧ (discr K).natAbs = D
```

and prove sign recovery, `discr K = (−1)^{(d−r)/2}·D`, from `NumberField.sign_discr`.

⚠ The `.i` coordinate of a full LMFDB label is not a target of this roadmap in any form. It needs
a certified database ordering, a canonical defining polynomial, deduplication up to isomorphism,
and a certificate that a bounded list is complete. None of the four follows from
`finite_of_discr_bdd`. A full label such as `2.2.5.1` is used below only as an external name for
a field.

*Prerequisites:* Mathlib `Module.finrank`, `NumberField.InfinitePlace.nrRealPlaces`,
`NumberField.discr`, `NumberField.sign_discr`.

#### 8.2 The page coverage map

For each datum that an LMFDB number-field page shows, this table says where it comes from.
`Mathlib` and `Tau Ceti` mean the datum already exists. `Layer n` means a milestone of this
roadmap. `Not built here` means this roadmap makes no claim, and names the subject that would
own it.

| Page datum | Source |
|---|---|
| degree | Mathlib `Module.finrank ℚ K` |
| signature `(r₁, r₂)` | Mathlib `nrRealPlaces`, `nrComplexPlaces` |
| discriminant, signed | Mathlib `NumberField.discr`, `sign_discr` |
| root discriminant | Mathlib `rootDiscr` |
| ramified primes | Layer 4.2 |
| factorization of `p𝓞_K`, `p` unramified | Layers 2.3 and 3.6 |
| factorization of `p𝓞_K`, `p` ramified | Layers 3.6, 4.1, 6.4 |
| Frobenius cycle type at unramified `p` | Layer 3.9 |
| local algebras at a ramified prime | Layer 5.3 |
| Galois group, as an abstract group | Layer 7.1 |
| Galois group `nTj` label | Not built here: polynomial Galois groups |
| class group and class number | Mathlib, with Tau Ceti `EffectiveBounds/` |
| narrow class group | Not built here: global class field theory |
| unit rank, torsion order | Mathlib |
| fundamental units | Layer 7.4 |
| regulator | Mathlib defines it; Layer 7.4 certifies each value |
| Dedekind zeta residue at `s = 1` | Mathlib `dedekindZeta_residue` |
| zeta continuation, functional equation, densities | Not built here: L-functions |
| subfields | Layer 7.1 |
| monogenicity, index, common index divisors | Layers 3.1, 3.11, 7.3 |
| CM and totally real flags | Mathlib `IsCMField`, `IsTotallyReal` |
| intrinsic label prefix `d.r.\|D\|` | Layer 8.1 |
| label index `.i` | Not built here, and not built anywhere yet |
| canonical defining polynomial | Not built here, and not built anywhere yet |
| completeness of a bounded list, deduplication | Not built here, and not built anywhere yet |
| sibling fields, arithmetic equivalence | Not built here, and not built anywhere yet |
| Artin conductors of associated representations | Not built here: Artin representations |

No claim of full page coverage is made anywhere in this roadmap.

*Prerequisites:* Layer 8.1, and the layers named in the table.

#### 8.3 The worked suite

Five fields, computed end to end: `2.2.5.1`, `2.0.4.1`, `4.0.125.1`, `3.1.23.1`, `3.1.503.1`.
§Worked examples states them. Each has a section in `Suggested.lean`.

*Prerequisites:* Layers 1 to 8, as named in each example.

## Explicit scope exclusions

- **No Frobenius in the absolute Galois group.** There is no canonical Frobenius element in
  `Gal(K̄/K)`, and no canonical conjugacy class there. This roadmap constructs none. The
  canonical object at an unramified place is arithmetic Frobenius in
  `D_v / I_v ≅ Gal(k̄_v/k_v) ≅ Ẑ`. A lift to `D_v`, and so to `Gal(K̄/K)`, is well defined only
  modulo inertia. The compatible classes in the finite quotients do not assemble into one
  element. The correct downstream use belongs to an Artin representations subject, and takes
  this form. A representation with finite image that is unramified at `v` is trivial on `I_v`. The
  image
  of any lift of arithmetic Frobenius is therefore well defined up to conjugacy, and its
  characteristic polynomial is an invariant of `v`. That statement needs no absolute-Galois
  Frobenius class.
- **No general Artin conductor**, no Artin integrality, and no general conductor–discriminant
  formula.
- **No density statements.** Chebotarev and the distribution of Frobenius classes belong to an
  L-functions subject.
- **No local ramification theory.** Upper numbering, Herbrand's theorem, and Hasse–Arf belong to
  a local fields subject. Layer 6.1 defines the local lower filtration only, and only as the
  compatibility interface that Layer 6.2 compares against.

Related mathematics that no milestone here covers, and that a later roadmap may take up: Hensel's
realizability criterion; relative integral bases and Steinitz classes; finiteness of power
integral bases; arithmetic equivalence and Gassmann triples; the LMFDB ordering and
canonical-polynomial certificate; unit certification above rank one.

## Worked examples

Each field detects a specific error: a wrong normalization, a vacuous instance, an unstated
hypothesis, a missing dyadic case. Every asserted equality is exact. Decimal values appear only
for orientation and are never targets. Each entry says which assertions are proved here.

### `2.2.5.1` = ℚ(√5)

Presented by `θ` with `minpoly ℤ θ = X² − X − 1`.

*Proved here:* `discr K = 5`; signature `(2,0)`; `torsionOrder = 2`; `Units.rank = 1`;
`Subgroup.closure {θ} ⊔ torsion K = ⊤` by Layer 7.4, hence
`regulator K = Real.log ((1 + √5)/2)`. The splitting law: `p` splits if and only if
`legendreSym p 5 = 1`, that is `p ≡ ±1 mod 5`. In particular `2` is inert, because
`5 ≡ 5 mod 8`.

*From Mathlib:* `classNumber K = 1`, by `isPrincipalIdealRing_of_abs_discr_lt`. Also the class
number formula check `dedekindZeta_residue = 2·log((1+√5)/2)/√5`. That one equation relates the
certified regulator, the class number and the discriminant, and it detects a wrong
normalization.

### `2.0.4.1` = ℚ(i)

*Proved here:* `discr K = −4`; `ℤ[i]` monogenic with index `1`; `2 = −i(1+i)²` is ramified with
`e = 2`, and `v_P(𝔡) = 2 = e`.

This is the dyadic example. The **wild** lower bound of Layer 6.4 is attained, and the upper
bound `e − 1 + v_P(e) = 1 + 2 = 3` is strict. A tame-only exponent formula must not claim this
case.

⚠ The sign of the discriminant is Brill's theorem in use: `r₂ = 1`, so the sign is `−1`.

*From Mathlib:* `classNumber K = 1`; `torsionOrder K = 4`. Tau Ceti's
`discr_cyclotomicField_four` gives a second check on `discr = −4`.

### `4.0.125.1` = ℚ(ζ₅)

Presented as `CyclotomicField 5 ℚ`.

*Proved here:* the Frobenius data, `f(p) = orderOf (p : ZMod 5)ˣ`, in these cases:

- `2`, `3` and `7` are inert, so `f = 4`;
- `19` has `f = 2` and `g = 2`;
- `11` splits completely;
- `5` is totally ramified, through `(1 − ζ)⁴`.

Also the subfield lattice `{ℚ, ℚ(√5), ℚ(ζ₅)}`, of cardinality 3, which matches the subgroup
lattice of `C₄`.

*From Mathlib:* `discr = 125` and signature `(0,4)`, by
`IsCyclotomicExtension.Rat.discr_prime`; `classNumber = 1`, by `five_pid`; `torsionOrder = 10`;
monogenicity, since `𝓞 = ℤ[ζ₅]`.

⚠ The identity `∏_{χ mod 5} cond(χ) = 1·5·5·5 = 125` is the abelian conductor–discriminant
formula. It is not a target of this roadmap, and it is not used here.

### `3.1.23.1`

The non-Galois cubic with `minpoly = X³ − X² + 1`. `disc(minpoly) = −23` is squarefree, so
`index θ = 1` and `discr K = −23`.

*Proved here:* signature `(1,1)`; not Galois, with `S₃` Galois closure; no proper subfield;
`Units.rank = 1` with the explicit unit `u = θ² − θ`, characterized by `θ·(θ² − θ) = −1`, so
`u = −θ⁻¹`; `Subgroup.closure {u} ⊔ torsion K = ⊤` by Layer 7.4; and, with `w` the unique real
place, so `w.mult = 1`, and `1 < w u` because `w u ≈ 1.3247`,

```text
regulator K = Real.log (w ((u : 𝓞 K) : K))
```

exactly. Numerically `≈ 0.2812`, for orientation only.

⚠ Naming `w` is what makes this a statement. `θ² − θ` is an element of `𝓞 K`, not a real number.

*Proved here, splitting:* `2` and `3` are inert, cycle type `(3)`; `5` and `7` have type `(1,2)`;
`59` splits completely, cycle type `(1,1,1)`, so `Frob = 1`. All are instances of Layer 3.9.

⚠ `23` is ramified, and is listed separately. Since `23 ∣ discr K`, there is no Frobenius class at
`23`, and no cycle type. The factorization `𝔭²𝔮` comes from Layer 3.6 with Layers 4.1 and 6.4.
The reduction of `minpoly` modulo `23` has a double root at `16` and a simple root at `15`.

⚠ This roadmap does not claim that `59` is the **least** totally split prime. That would need a
finite check at every smaller prime, which no milestone performs. The claim is that `59` splits
completely.

*From Mathlib:* `classNumber K = 1`, by the principal-ideal-ring criteria.

The density `1/6` for split primes is deliberately absent; density statements belong to an
L-functions subject.

### `3.1.503.1` = Dedekind's field

`ℚ[x]/(x³ − x² − 2x − 8)`, with `disc(f) = −2012 = −4·503`, `index θ = 2`, and `discr K = −503`.

*Proved here:* `2` splits completely, although `minpoly mod 2 = x²(x+1)`; `2` is a common index
divisor, that is, `∀ θ' : IntegralPrimitiveElement K, 2 ∣ index θ'`; hence
`¬ NumberField.IsMonogenic K`.

This example is why Layer 3.10 is hypothesized on `p ∤ f.discr` and not on "`p` unramified". Here
`2` is unramified in `K`, and the factorization of `f mod 2` still does not give the splitting
type.

*Source:* Neukirch III §2 Exercise 1.

*From Mathlib:* `classNumber K = 1`, by the principal-ideal-ring criteria.

### The dyadic quadratic law

Let `d` be squarefree with `d ≡ 1 mod 4`. Let `θ = (1+√d)/2`, so that
`minpoly ℤ θ = X² − X + C ((1−d)/4)`. Prove that `2` splits if and only if `d ≡ 1 mod 8`.

This statement is not reachable from the `X² − d` presentation, whose exponent is even here. That
is why the example is here: it detects an oddness hypothesis that has entered Layer 3 or Layer 7
by accident.

## Ordering

The layer numbering is a dependency order, so any schedule that respects it is valid. The useful
extra information is which layers are independent of each other.

- **Layer 1** comes first. It is mostly publication of existing material, plus the double-coset
  law.
- **Layer 2** needs Layer 1 and nothing else. Its Artin map takes the excluded set as a
  parameter, so it does not need the relative discriminant.
- **Layer 3** needs Layer 1 and Layer 2 for the cycle-type theorem. Its index material and its
  relative Dedekind–Kummer half need neither, and are independent of Layer 2.
- **Layer 4** needs Layer 2.5 only for the specialization of the Artin map. The rest is
  independent of Layers 2 and 3.
- **Layer 5** needs Layer 2 for the Frobenius comparison and Layer 4 for the discriminant
  valuation. Nothing else.
- **Layer 6** needs Layer 5 and nothing else.
- **Layer 7** needs Layers 1 to 3. Its unit certification needs nothing else and can be done
  early. Every statement that quotes a regulator waits for it.
- **Layer 8** assembles the rest. Each worked example names the layers it uses.

## References

**J. Neukirch, *Algebraic Number Theory*, Springer 1999.** The primary source.

- Ch. I §2: integral bases, and discriminants of bases.
- Ch. I §8: Dedekind extensions. (8.1)–(8.2) give the fundamental identity. **(8.3) gives
  Dedekind–Kummer through the conductor.** (8.4) gives finiteness of the ramified primes. (8.5)
  gives quadratic splitting. Exercises 4 and 5 give the Galois closure and the index form
  of (8.3).
- Ch. I §9: Hilbert theory. (9.1) gives transitivity, and (9.2) the decomposition group. The
  double-coset bijection is on page 55. (9.3) and (9.6) give the `Z` and `T` dictionary.
  (9.4)–(9.5) give `D/I ≅ Gal(κ)`. Exercise 2 gives the Frobenius automorphism, and Exercise 4
  gives totally split in the closure.
- Ch. I §10: cyclotomic fields. (10.2) gives `ℤ[ζ]`, and (10.3) the splitting law.
- Ch. II §8: extensions of valuations. (8.3)–(8.4) give the semi-local structure and the norm and
  trace formulas.
- Ch. II §9: the Galois theory of valuations, that is the global-local decomposition dictionary.
- Ch. III §2: the different. (2.1)–(2.2) give the definition and the tower, and **(2.2)(iii) the
  localization.** (2.4)–(2.5) give the monogenic and gcd descriptions. (2.6) gives the exact tame
  and wild exponents. (2.9) gives `𝔡 = N(𝔇)`. (2.10)–(2.12) give the discriminant tower and the
  ramification criterion. Exercise 1 gives Dedekind's non-monogenic cubic.
- Ch. VII §11 on the Artin conductor, and §13 on density, are cited only as boundaries.

**J.-P. Serre, *Local Fields*, GTM 67.**

- Ch. I §§4–7: the Dedekind decomposition.
- Ch. III: the different. §6 Proposition 12 gives local monogenicity, and Proposition 13 the tame
  and wild bounds. §4 Proposition 8 gives the tower identity behind Layer 6.5.
- Ch. IV §1: the ramification filtration. Proposition 2 gives `H_i = H ∩ G_i`, and Proposition 4
  gives `v(𝔡) = Σ(#Gᵢ − 1)`.
- Ch. VI §2 on the Artin conductor is cited only as a boundary.

**S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110.**

- Ch. I: Dedekind theory, and the decomposition group.
- Ch. III: the different and the discriminant, with alternative proofs of the Layer 4 material.

**G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7.**

- Ch. I: ramification, the Frobenius automorphism, and double cosets. This is the cleanest
  textbook treatment of Layer 1.4.
- Ch. II–III: units, class groups, and cyclotomic fields.

**D. A. Marcus, *Number Fields*, 2nd ed.**

- Ch. 2–3: integral bases, the Dedekind–Kummer theorem, and essential discriminant divisors.
  Dedekind's field appears in the exercises.
- Ch. 4: decomposition, inertia, and Frobenius.
- Ch. 5, exercises: the unit computations that Layer 7.4 formalizes.

**H. Cohen, *A Course in Computational Algebraic Number Theory*, GTM 138.**

- §4.8 and §6.1: Dedekind's criterion, and index computations.
- §5.7: fundamental units by bounded search.

**W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers*, 3rd ed.**

- Ch. 4: inessential discriminant divisors, and Hensel's realizability criterion. That criterion
  is the converse deliberately left out of Layer 3.11.

**L. C. Washington, *Introduction to Cyclotomic Fields*, GTM 83.**

- Ch. 1–4: the cyclotomic instances of Layers 2 and 6.
