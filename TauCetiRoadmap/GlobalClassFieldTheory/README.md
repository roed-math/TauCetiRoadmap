# Roadmap: global class field theory

## Scope

This roadmap builds global class field theory for number fields. It starts from Mathlib's adele
ring, class group and cyclotomic theory. It ends with the reciprocity law, the existence theorem,
the Hilbert class field, Kronecker–Weber, ring class fields, and the global class formation. Every
layer carries the basic theory of the objects it introduces, and not only the named theorem.

Mathlib has the adele ring of a number field. It has no object of global class field theory. It has
none of the following:

- a modulus, a ray class group, or a narrow class group;
- the idele class group;
- a Hecke character;
- the global Artin map, or the reciprocity law;
- the conductor of an abelian extension, or the existence theorem;
- the Hilbert class field, or the Kronecker–Weber theorem.

The section "What Mathlib supplies" names the declarations that do exist.

Suggested home: `TauCeti/NumberTheory/ClassFieldTheory/Global/`. Use one subdirectory for each
layer: `Modulus/`, `RayClass/`, `IdeleClass/`, `Archimedean/`, `HeckeCharacter/`, `NormIndex/`,
`Reciprocity/`, `Existence/`, `RayClassField/`, `HilbertClassField/`, `KroneckerWeber/`,
`Grossencharacter/`, `ClassFormation/`. The name follows Mathlib's own layout for number theory, and
it leaves room for a `ClassFieldTheory/Local/` neighbour. Write the Dedekind-generic material of
Layers 0 and 1 so that it can sit beside `RingTheory/ClassGroup/`, and record that intended split in
the file docstrings.

## How prerequisites are recorded

Every milestone below lists its direct prerequisites. Each prerequisite has one of three classes.

- **M**, an existing Mathlib declaration at the pin. The declaration is named.
- **T**, an existing Tau Ceti declaration in a merged roadmap. The roadmap and the layer are named.
- **L**, an earlier milestone of this roadmap. The milestone number is given.

No other class is allowed. No milestone here depends on a branch, on an open pull request, on a
future pin, on an external repository, or on a roadmap that is not merged.

Global class field theory needs local class field theory, and Tate cohomology in every integer
degree. Neither is in Mathlib at the pin, so this roadmap builds both. Layer T builds Tate
cohomology. Layer I states the local package in milestone I.1 and constructs it in milestone I.4,
with the submilestones and the sources listed there. Every later milestone cites those, and
nothing here is conditional on material outside this repository.

Other roadmaps plan some of the same material. Those relations are alignments and not
prerequisites. `PROVENANCE.md` records them, and it is not normative.

## The contract with the Multiquadratic roadmap

Multiquadratic is a merged roadmap, and the exchange with it runs in both directions. The layer
graph is acyclic: 1.8 supplies the narrow class group; Multiquadratic Layer 3 uses it and builds
the genus field; 8.2 uses that genus field. Nothing here uses 8.2.

| consumer | supplier | exact declaration | type |
|---|---|---|---|
| Multiquadratic Layer 3, real case | this roadmap, 1.8 | the narrow class group `Cl⁺ K` | `RayClassGroup (narrowModulus K)` |
| Multiquadratic Layer 3, real case | this roadmap, 1.8 | the surjection `Cl⁺ ↠ Cl` | `RayClassGroup (narrowModulus K) →* ClassGroup (𝓞 K)`, surjective |
| Multiquadratic Layer 3, real case | this roadmap, 1.8 | the kernel description | `∀ x ∈ ker, x ^ 2 = 1`, with `Nat.card ker * (unitsCongruenceSubgroup (narrowModulus K)).index = 2 ^ nrRealPlaces K` |
| this roadmap, 8.2 | Multiquadratic Layer 3 | the genus field `K_gen` of a quadratic `K/ℚ`, with `Gal(K_gen/K) ≅ Cl(K)/Cl(K)²` | an `IntermediateField ℚ K̄` with that isomorphism |

Milestone 8.2 proves one comparison theorem against that supplier: `K_gen` is the maximal
subfield of the Hilbert class field `H` that is abelian over `ℚ`, and the narrow genus field is
the corresponding subfield of `H⁺`. `Suggested.lean` prototypes the three supplied declarations.
Use the same names on both sides.

## Standing hypotheses

The standing setting is a number field `K`, written `[Field K] [NumberField K]`. Write `𝓞 K` for its
ring of integers, `HeightOneSpectrum (𝓞 K)` for its finite places, and `InfinitePlace K` for its
infinite places.

Spell hypotheses out. Do not bundle them. An abelian extension enters as `[Algebra K L]
[IsAbelianGalois K L]`, with `[Module.Finite K L]` added when finiteness is meant. Infinite abelian
extensions, such as `K^{ab}` and the ray class tower, use the Krull topology and the `IsGaloisGroup`
API, inside the fixed algebraic closure of the conventions table.

Three levels of generality appear, and the difference between them is deliberate.

1. **Dedekind-generic.** The finite-part machinery of Layers 0 and 1 is stated for `(R, K)` with
   `[CommRing R] [IsDedekindDomain R] [Field K] [Algebra R K] [IsFractionRing R K]`. This matches
   Mathlib's own parametrization of `AdeleRing R K`. It covers the finite part of a modulus, the
   fractional ideals prime to it, and the congruence subgroup of `Kˣ`. It also covers the ray
   class quotient, the transition maps, the moving lemma, and the exact sequence. Layer 10B and any
   later function-field
   work reuse this generality.
2. **Finiteness.** A general Dedekind domain has neither finite residue rings nor a finite class
   group. Ray class groups are therefore not finite at that generality, and the cardinality formula
   of Layer 1 fails there. Prove finiteness statements either for number fields or under the
   explicit hypothesis package `Finite (R ⧸ 𝔪₀)ˣ` together with `Finite (ClassGroup R)`. State that
   package once and use it by name. Prefer the package form where it costs nothing, because Layer
   10B needs it for orders.
3. **Number fields.** Every statement about real places, and all of class field theory proper, which
   is Layer 2C and Layers 4 to 11, is stated for number fields only.

Nonmaximal orders are outside the Dedekind-generic statements. An order in a number field is usually
not integrally closed, so it is not a Dedekind domain. Layer 10B builds its invertible-ideal theory
separately.

The function-field case is out of scope. Mathlib's `AdeleRing` docstring records that the definition
is wrong for function fields. Do not add speculative function-field hypotheses to number-field
theorems.

Never assume that `K` is totally imaginary. Never assume that the class group is trivial. Never let
a statement require, without saying so, that there are no real places. The narrow class group, the
wide class group and the unit sign obstruction are what the downstream consumers need. Statements
must carry their true hypotheses.
## Pinned conventions

| object | convention | fixed in |
|---|---|---|
| modulus | `Modulus K` is a structure. It has `finitePart : Ideal (𝓞 K)` with a proof that this ideal is nonzero. It has `infinitePart : Finset {w : InfinitePlace K // w.IsReal}`. Write `𝔪 = (𝔪₀, 𝔪∞)`. The finite part has a second description as a finitely supported exponent function on `HeightOneSpectrum (𝓞 K)`. Lemmas translate between the two descriptions. A complex place never divides a modulus. The infinite part is therefore typed by real places, and carries no side condition. At Dedekind generality only the finite part exists | Layer 0; Janusz IV §1 |
| divisibility of moduli | `𝔪 ∣ 𝔫` means `𝔪₀ ∣ 𝔫₀` as ideals, together with `𝔪∞ ⊆ 𝔫∞`. Equivalently, the exponent at every finite place is weakly larger for `𝔫`. Under this orientation the transition map runs `Cl_𝔫 ↠ Cl_𝔪`. The larger modulus maps onto the smaller one. Set `gcd(𝔪,𝔫) = (𝔪₀ ⊔ 𝔫₀, 𝔪∞ ∩ 𝔫∞)` and `lcm(𝔪,𝔫) = (𝔪₀ ⊓ 𝔫₀, 𝔪∞ ∪ 𝔫∞)`. The exponentwise minimum and maximum descriptions are lemmas | Layer 0 |
| multiplicative congruence | `x ≡ 1 mod* 𝔪` for `x ∈ Kˣ` means two conditions. At each `v ∣ 𝔪₀`, `ord_v(x − 1) ≥ ord_v(𝔪₀)`. At each `w ∈ 𝔪∞`, the real embedding of `x` at `w` is positive. Mathlib's `HeightOneSpectrum.valuation` is multiplicative and takes values in `ℤᵐ⁰`. A higher order of vanishing is therefore a smaller value, so the additive `≥` is a multiplicative `≤`. **Common error.** This is a condition on `Kˣ`. It is not membership in `1 + 𝔪₀` inside `𝓞 K`. The two agree only for integral `x` that are prime to `𝔪₀` | Layer 0 |
| ray class group | `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`. Here `J^{𝔪₀}` is the group of fractional ideals whose support is disjoint from `𝔪₀`. `P_𝔪` is the subgroup of principal ideals `(x)` with `x ≡ 1 mod* 𝔪`. There is a named isomorphism `Cl_{((1),∅)} ≃* ClassGroup (𝓞 K)`. Do not rely on a definitional coincidence | Layer 1 |
| narrow class group | `Cl⁺ K := Cl_𝔪 K` for `𝔪 = ((1), all real places)`. The description `J/P⁺`, with `P⁺` the totally positive principal ideals, is a named lemma. "Narrow" never means that totally positive units exist. A field with no real place has `Cl⁺ = Cl`; that is an instance, not a second definition | Layer 1; Janusz VI §3 |
| idele group, idele class group | `IdeleGroup R K := (AdeleRing R K)ˣ` with the units topology, which comes from the embedding `x ↦ (x, x⁻¹)`. `IdeleClassGroup R K := IdeleGroup R K ⧸ principal ideles`. **Common error.** The idele topology is not the subspace topology from `𝔸_K`; Mathlib's `Topology/Algebra/IsOpenUnits.lean` records this. Mathlib's `Units` topology is already correct, so never add a topology by hand | Layer 2A |
| congruence subgroup of the ideles | One subgroup is used everywhere. Let `n_v = ord_v 𝔪₀`. Then `IdeleCongruenceSubgroup 𝔪 ≤ IdeleGroup (𝓞 K) K` is the product of the following local conditions: `1 + 𝔭_v^{n_v}` at finite `v ∣ 𝔪₀`; `𝒪_vˣ` at finite `v ∤ 𝔪₀`; `ℝ_{>0}` at real `w ∈ 𝔪∞`; all of `ℝˣ` at real `w ∉ 𝔪∞`; all of `ℂˣ` at complex `w`. Write `U_𝔪` for it in prose. Its image in `C_K` is `RaySubgroup 𝔪`, and the dictionary is `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. **Common error.** Do not append a second group of infinite components to `U_𝔪`. The infinite components are already in the definition. The connected component `D_K` enters separately, through `D_K ≤ RaySubgroup 𝔪` for every `𝔪` | Layer 2A |
| idele norm | `‖·‖ : IdeleGroup → ℝ_{>0}` is the product of the normalized local absolute values. At a finite `v`, `‖π_v‖ = 1/q_v`; this matches `FinitePlace` and the interface of Layer I. At a real `w` it is the usual absolute value. At a complex `w` it is the **square** of the modulus, which is the `InfinitePlace.mult`-weighted convention of `ProductFormula.lean`. The product formula says `‖·‖ = 1` on principal ideles. Define `C_K^1 := ker ‖·‖` on classes | Layer 2A; `Mathlib/NumberTheory/NumberField/ProductFormula.lean` |
| nonarchimedean local normalizations | The normalized valuation of a uniformizer is `v(π) = 1`. The residue cardinality is `q_v`. The distinguished generator is the **arithmetic Frobenius** `x ↦ x^{q_v}`. The local Artin map sends a uniformizer to the arithmetic Frobenius: `Art_{K_v}(π) = Frob_v`. These are fields of the Layer I interface, not assumptions about another repository | Layer I |
| archimedean local normalizations | These are built in Layer 2C, because the interface of Layer I is nonarchimedean. `Art_ℂ : ℂˣ → Gal(ℂ/ℂ)` is trivial. `Art_ℝ : ℝˣ → Gal(ℂ/ℝ)` sends a positive element to `1` and a negative element to complex conjugation, so `ker Art_ℝ = ℝ_{>0} = N_{ℂ/ℝ}(ℂˣ)`. The invariants are `inv_ℂ = 0`, and the nontrivial class at a real place has invariant `1/2`. The Hilbert symbols are `(a,b)_ℂ = 1` always, and `(a,b)_ℝ = −1` exactly when both `a < 0` and `b < 0` | Layer 2C |
| Artin map, direction and normalization | At finite level, `θ_{L/K} : C_K ⧸ N_{L/K} C_L ≃* Gal(L/K)` for finite abelian `L/K`. It is **defined** as the compilation of local maps, `θ((x_v)_v) = ∏_v Art_{K_v}(x_v)∣_L`. Normalization: let `v` be unramified in `L`, and let `x` be the class of an idele that is a uniformizer at `v` and a unit elsewhere; then `θ(x) = Frob_v`, arithmetic. At profinite level, `Art_K : C_K →* Gal(K^{ab}/K)` is continuous and **surjective**, with kernel the identity component `D_K`. **Common error.** The local map is injective and not surjective; the global map is surjective and not injective. Do not port a local statement without changing it | Layers 6 and 7; Neukirch ANT VI §5 |
| ideal-theoretic Artin map | Let `L/K` be finite abelian, let `S : Finset (HeightOneSpectrum (𝓞 K))`, and let `hur` say that every prime outside `S` is unramified in `L`. Then `J^S` is the subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of fractional ideals with valuation zero at every prime of `S`, and `artinHomAway S hur : J^S →* (L ≃ₐ[K] L)` sends a prime outside `S` to its arithmetic Frobenius. It is milestone I.2, in the name and the signature of the Number Field Arithmetic roadmap. Layers 6 to 8 use the single instance `S = support 𝔪₀`, where `hur` follows from `𝔣(L/K) ∣ 𝔪`, and the carrier is `J^{𝔪₀}` already | Layer I; Layers 6 to 8 |
| Hecke character | A Hecke character is a continuous homomorphism `χ : IdeleClassGroup (𝓞 K) K →* ℂˣ`, that is a `ContinuousMonoidHom`. Three properties are equivalent: `χ` has finite order; `ker χ` is open; `χ` factors through a ray class group `Cl_𝔪 K`. Each equivalence is a named theorem. "Ray class character" names the composite notion and is never an independent definition. Unitary characters and the decomposition `χ = χ_u · ‖·‖^s` are Layer 3. Algebraic characters and infinity types are Layer 10A | Layer 3 |
| conductor of a character | There are two notions, and neither covers the other. The **finite conductor ideal** of a continuous quasicharacter is assembled from the depths at which its nonarchimedean local components become trivial on principal units. The **ray conductor modulus** is defined for a character that is trivial on the connected component of the archimedean part, in particular for every finite-order character. It is the smallest `𝔪` with `U_𝔪 ⊆ ker χ`, and its infinite part records the real places where the local sign component is nontrivial. **Common error.** A general quasicharacter has no ray conductor, because `‖·‖^s` is trivial on no `U_𝔪`. Over `ℚ`, `DirichletCharacter.conductor` is the finite part, and the parity fixes the infinite part | Layer 3 |
| conductor of an abelian extension | For finite abelian `L/K`, the conductor `𝔣(L/K)` is the smallest modulus `𝔣` with `U_𝔣 ⊆ Kˣ · N_{L/K}(I_L)`. It has a second description: assemble the local conductors of the Layer I interface together with the ramified real places. Both descriptions are stated, and their agreement is a theorem | Layer 7 |
| inequality naming | The two norm-index bounds are named by content. `herbrand_ge` is `[C_K : N C_L] ≥ [L:K]` for cyclic `L/K`, proved with the Herbrand quotient. `kummer_le` is the reverse inequality, proved with Kummer theory. Do not call them "first" and "second". Sources disagree on those ordinals, and a name that changes meaning between sources is a defect | Layer 5 |
| ambient closure | Fix one algebraic closure `K̄`, either as a hypothesis `[IsAlgClosure K K̄]` or as `AlgebraicClosure K`, at the start of Layer 7. Construct every abelian extension of Layers 7 to 11 as an `IntermediateField K K̄`. Composita, intersections, `K^{ab} = ⨆_𝔪 K_𝔪`, the tower of ray class fields and the direct limit `colim_L C_L` are statements inside that closure. An isomorphism of profinite groups is a `ContinuousMulEquiv` and never a bare `MulEquiv` | Layers 7 to 11 |
| class formation interface | At finite level, use the shape of a class formation with a distinguished `H²` class, vanishing `H¹`, and compatible invariant maps. Put the profinite formation `(G_K, colim_L C_L)` on top, in the arrangement of NSW | Layer 11 |

**Pinned route decision.** The global Artin map is assembled from the local reciprocity maps, in the
manner of Neukirch. It is not constructed from a global fundamental class. The map is *defined* on
ideles by `(x_v)_v ↦ ∏_v Art_{K_v}(x_v)∣_L`, and almost all factors are trivial because almost all
places are unramified. Local-global compatibility, which is the statement most used downstream,
therefore holds by construction. The global theorem is then two statements: `θ_{L/K}` kills
principal ideles, and the norm index equals the degree. The inputs are the local interface of Layer
I, the archimedean package of Layer 2C, and the norm-index machinery of Layer 5.

Layer 5 uses two algebraic routes and no analysis. The lower bound comes from the Herbrand quotient
of `S`-idele classes. The upper bound comes from Chevalley's Kummer-theoretic argument. This keeps
the roadmap free of L-series and of density theorems, which belong to a separate analytic
development. A density-dependent proof of reciprocity would invert the dependency order.

The cohomological class formation is not dropped. It is Layer 11. That layer reuses the Layer 5
computations, states the fundamental classes and the invariant maps, and carries the data that
Brauer-facing developments need. Two alternatives were considered and rejected for the main line. A
fundamental-class-first route blocks reciprocity behind `H²` machinery, parallelizes worse, and
turns local-global compatibility from a definition into a chain of theorems. A purely
ideal-theoretic route, without ideles, loses the direct interface to Mathlib's adele stack and to
Hecke characters; it survives here as the dictionary of Layers 7 and 8.
## What Mathlib supplies

Every entry below was checked against the repository's Mathlib pin. Consume these; do not rebuild
them.

- **The adele stack.** `Mathlib/NumberTheory/NumberField/AdeleRing.lean`: `AdeleRing R K`,
  `AdeleRing.principalSubgroup`, `algebraMap_injective`.
  `Mathlib/NumberTheory/NumberField/InfiniteAdeleRing.lean`: `InfiniteAdeleRing K` as the product of
  the completions, its local compactness, and `denseRange_algebraMap`, which is weak approximation
  at the infinite places. `Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean`: `FiniteAdeleRing
  R K` as a restricted product, `isUnit_iff`, and `unitEmbedding : Kˣ →* (FiniteAdeleRing R K)ˣ`.
  `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean`: `HeightOneSpectrum.intValuation`,
  `valuation`, `adicCompletion`, `adicCompletionIntegers`, `valuation_exists_uniformizer`.
  `Mathlib/Topology/Algebra/RestrictedProduct/`: the units of a restricted product carry the
  restricted product topology, so the idele topology is correct by construction.
  `Mathlib/Topology/Algebra/IsOpenUnits.lean`.
- **Places and the product formula.**
  `Mathlib/NumberTheory/NumberField/Completion/FinitePlace.lean`: `FinitePlace K`, `embedding`,
  `adicAbv`, `norm_def`, and the discrete valuation ring instances on `adicCompletionIntegers`.
  `Mathlib/NumberTheory/NumberField/ProductFormula.lean`: `prod_abs_eq_one`, the normalization that
  the idele norm of Layer 2A must match.
  `Mathlib/NumberTheory/NumberField/InfinitePlace/Basic.lean`: `IsReal`, `IsComplex`,
  `embedding_of_isReal`, `mult`, `denseRange_algebraMap_pi`.
  `Mathlib/NumberTheory/NumberField/Completion/InfinitePlace.lean`: `InfinitePlace.Completion`,
  `ringEquivRealOfIsReal`, `ringEquivComplexOfIsComplex`, and the isometry versions.
  `Mathlib/NumberTheory/NumberField/InfinitePlace/Ramification.lean`: `IsUnramified`, `IsRamified`,
  and the class `IsUnramifiedAtInfinitePlaces`.
  `Mathlib/NumberTheory/NumberField/Completion/Ramification.lean`: `InfinitePlace.inertiaDeg`,
  `sum_inertiaDeg_eq_finrank`.
- **Class group and units.** `Mathlib/RingTheory/ClassGroup/Basic.lean`: `ClassGroup R`,
  `ClassGroup.mk0`, `mk0_surjective`. `Mathlib/RingTheory/ClassGroup/ExtendedHom.lean`:
  `ClassGroup.extendedHom` and `extendedHom_eq_one_of_forall_isPrincipal`, which is the exact target
  shape of the principal ideal theorem. `Mathlib/NumberTheory/NumberField/ClassNumber.lean`:
  finiteness and `classNumber`. `Mathlib/NumberTheory/NumberField/Units/`: torsion, Dirichlet's unit
  theorem, the regulator. `Mathlib/RingTheory/DedekindDomain/SInteger.lean`: `Set.integer`,
  `Set.unit`, `Set.unitEquivUnitsInteger`, for a set `S` of finite places.
- **Frobenius and ramification.** `Mathlib/RingTheory/Frobenius.lean`: `AlgHom.IsArithFrobAt`,
  `IsArithFrobAt`, `arithFrobAt`, with existence, uniqueness under unramifiedness, and conjugation.
  `Mathlib/NumberTheory/RamificationInertia/`: `ramificationIdx`, `inertiaDeg`,
  `sum_ramification_inertia`, transitivity of the Galois action, decomposition and inertia fields.
  `Mathlib/RingTheory/Invariant/Basic.lean`: stabilizer and residue-Galois machinery.
  `Mathlib/RingTheory/DedekindDomain/Different.lean`: `differentIdeal`,
  `not_dvd_differentIdeal_iff`, which says that a prime is unramified exactly when it does not
  divide the different.
- **Cyclotomic fields.** `Mathlib/NumberTheory/Cyclotomic/`: `IsCyclotomicExtension`,
  `CyclotomicField`, `autEquivPow`, discriminants, primitive roots.
  `Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean`:
  `IsCyclotomicExtension.Rat.galEquivZMod`, `galEquivZMod_stabilizer` (the decomposition group at `p
  ∤ n` is generated by `[p]`), `intermediateFieldEquivSubgroupChar`, and
  `mem_intermediateFieldEquivSubgroupChar_iff_conductor_dvd`.
  `Mathlib/NumberTheory/NumberField/Cyclotomic/Ideal.lean`: the `(ζ − 1)` ramification package for
  prime-power level, and the general `e`, `f` and `primesOver` counts. Layer 4 is largely a
  repackaging of this pair of files.
- **Dirichlet characters.** `Mathlib/NumberTheory/DirichletCharacter/`: `DirichletCharacter R n`,
  `changeLevel`, `FactorsThrough`, `conductor`, `IsPrimitive`, Gauss sums, orthogonality. With
  `ZMod.χ₄` and `Mathlib/NumberTheory/LegendreSymbol/`, this is the `K = ℚ` face of Layer 3.
- **Abelian Galois bookkeeping.** `Mathlib/FieldTheory/Galois/Abelian.lean`: `IsAbelianGalois`.
  `Mathlib/FieldTheory/Galois/Profinite.lean`, `KrullTopology.lean`, `AbsoluteGaloisGroup.lean` with
  `Field.absoluteGaloisGroup`, `IsGaloisGroup`, `IsAlgClosure`.
- **Group cohomology.** `Mathlib/RepresentationTheory/Homological/GroupCohomology/`: `LowDegree`
  with explicit `H⁰`, `H¹`, `H²`; `Hilbert90.lean`; `FiniteCyclic.lean` with the periodicity that
  the Herbrand quotient uses; `Shapiro.lean` for the coinduced computation;
  `LongExactSequence.lean`; `Functoriality.lean`.
  The pin has no Tate cohomology, and no cup product on it. Layer T builds both, and Layers 2C,
  5, 6, 9 and 11 use Layer T and not a hand-made norm quotient.
- **Group-theoretic transfer.** `Mathlib/GroupTheory/Transfer.lean`: `MonoidHom.transfer` and the
  Burnside machinery, which Layer 8 uses.
- **Assorted.** The chinese remainder theorem for Dedekind domains
  (`IsDedekindDomain.quotientEquivPiOfProdEq`, `quotientEquivPiFactors`,
  `Ideal.quotientInfRingEquivPiQuotient`); `Ideal.absNorm`; fractional ideal norms;
  `Mathlib/Topology/Algebra/ContinuousMonoidHom.lean` and `PontryaginDual.lean`;
  `Mathlib/FieldTheory/KummerExtension.lean`; `Mathlib/NumberTheory/PrimesCongruentOne.lean` with
  `Nat.exists_prime_gt_modEq_one`; `Mathlib/NumberTheory/LocalField/Basic.lean` with
  `IsNonarchimedeanLocalField`; quadratic reciprocity in `Mathlib/NumberTheory/LegendreSymbol/`,
  which the Layer 11 worked example derives again rather than consumes.

Two absences matter, and both are targets here. Mathlib has no weak approximation theorem for
several inequivalent absolute values; it has only the archimedean statement
`InfinitePlace.denseRange_algebraMap_pi`, so Layer 0 proves the mixed statement it needs. Mathlib
has no theory of nonmaximal orders in a number field beyond the generic `ClassGroup R`, so Layer 10B
builds it.

## What this roadmap builds

- Moduli and multiplicative congruences with real places, and the approximation theorem they rest
  on.
- Ray class groups, with finiteness, functoriality and the unit-to-ray exact sequence.
- The narrow class group, and the moving lemma.
- The idele class group: its topology, its norm, the congruence subgroups `U_𝔪`, the isomorphism
  `C_K ⧸ RaySubgroup 𝔪 ≃ Cl_𝔪`, the norm-one subgroup and its compactness, the connected component
  `D_K`, and the structure of the open subgroups.
- Ideles in a finite extension: base change, the Galois action, the extension map, the idele norm
  with its local formula, and `C_L` as a `Gal(L/K)`-module.
- The archimedean local package.
- Hecke characters: the finite-order dictionary, the two conductors, the local components, and the
  Dirichlet dictionary over `ℚ`. Algebraic characters and infinity types.
- The norm-index machinery: the Herbrand quotient of `S`-idele classes, both inequalities, and the
  Hasse norm theorem.
- The global Artin map by local-global compilation, the reciprocity law, functoriality in towers and
  under norms, and the equivalence of ramification with conductor divisibility.
- Norm groups, norm limitation and the existence theorem; the ideal-theoretic dictionary; ray class
  fields.
- The Hilbert class field, capitulation and the principal ideal theorem.
- Kronecker–Weber and the abelian conductor–discriminant formula.
- Orders, their Picard groups, ring class fields, and the `x² + ny²` theorem.
- The global class formation, fundamental classes, invariant maps, the sum-of-invariants theorem,
  and Hilbert reciprocity.

## The build, in layers

The order below is the dependency order. Layers I, 0, 1, 2A, 2B, 2C, 3, 4 and 5 use Mathlib and this
roadmap only. Layer 6 is where the local interface of Layer I becomes essential. Add each milestone
to `Suggested.lean` with `sorry` as soon as its types are expressible.

### Layer T: Tate cohomology of finite groups

Layers 5, 6, 9 and 11, and the local input of Layer I, use Tate cohomology in every integer
degree. The pin has ordinary group cohomology in low degrees, group homology, Shapiro's lemma,
the long exact sequence and periodicity for cyclic groups. It has no Tate cohomology, so this
layer builds it. The material is general, and it is written so that it could sit beside
`Mathlib/RepresentationTheory/Homological/`.

**T.1. Tate cohomology in all degrees.** For a finite group `G` and a `G`-module `M`, define
`Ĥ^n(G, M)` for every `n : ℤ`, through a complete resolution or through the splice of the
standard resolution with its dual. Prove the two low-degree descriptions:
`Ĥ⁰(G, M) = M^G / N_G M` and `Ĥ^{-1}(G, M) = ker N_G / I_G M`.
*Source.* Cassels–Fröhlich Ch. IV §6; Serre, *Local Fields*, Ch. VIII §1; NSW Ch. I §2.
*Prerequisites:* M `Mathlib/RepresentationTheory/Homological/GroupCohomology/`,
M `Mathlib/RepresentationTheory/Homological/GroupHomology/`.
**Basic API.**
- *Constructors:* the class of a cocycle; the class of `m ∈ M^G` in degree zero.
- *Examples:* `Ĥ^n(G, ℤ)`; `Ĥ⁰(Gal(ℂ/ℝ), ℂˣ) ≅ ℤ/2`; a free module, where every group vanishes.
- *Morphisms:* the connecting maps of the long exact sequence.
- *Functoriality:* T.3.
- *Comparison lemmas:* T.2 against ordinary cohomology and homology.
- *Naturality:* the long exact sequence is natural in the short exact sequence of modules.
- *Edge cases:* the trivial group; an induced module, where every group vanishes.
- *Downstream interface:* T.4 to T.6, I.4, 5.2, 5.4, 5.5 and 11.1.

**T.2. Comparison with ordinary cohomology and homology.** Prove `Ĥ^n(G, M) ≅ H^n(G, M)` for
`n ≥ 1`, and `Ĥ^{-n-1}(G, M) ≅ H_n(G, M)` for `n ≥ 1`. State the case that 5.5 uses:
`Ĥ^{-3}(G, ℤ) ≅ H₂(G, ℤ)`, the Schur multiplier.
*Source.* Cassels–Fröhlich Ch. IV §6; NSW Ch. I §2.
*Prerequisites:* L T.1.

**T.3. Functoriality.** Define restriction, corestriction and inflation on Tate cohomology, and
prove: `cor ∘ res = [G : H]`; inflation is defined for `n ≥ 1` on ordinary cohomology and its
compatibility with the Tate groups; the `p`-primary component injects into that of a Sylow
`p`-subgroup. The last statement is what 5.4 uses.
*Source.* Cassels–Fröhlich Ch. IV §6; Serre, *Local Fields*, Ch. VIII §2.
*Prerequisites:* L T.1, M `Sylow`.

**T.4. Periodicity and the Herbrand quotient.** For cyclic `G`, prove `Ĥ^n ≅ Ĥ^{n+2}`. Define
the Herbrand quotient `h(G, M) = #Ĥ⁰ / #Ĥ¹` when both are finite. Prove multiplicativity in
short exact sequences, vanishing on finite modules, and invariance under an equivariant map with
finite kernel and finite cokernel.
*Source.* Serre, *Local Fields*, Ch. VIII §4; Cassels–Fröhlich Ch. IV §8.
*Prerequisites:* L T.1, M
`Mathlib/RepresentationTheory/Homological/GroupCohomology/FiniteCyclic.lean`.

**T.5. Cup products.** Define the cup product on Tate cohomology in the degrees that T.6 uses,
with associativity, graded commutativity, and compatibility with restriction and corestriction.
*Source.* Cassels–Fröhlich Ch. IV §7; NSW Ch. I §4.
*Prerequisites:* L T.1.

**T.6. Class formations and Tate–Nakayama.** Define a finite class formation: a distinguished
class `u ∈ Ĥ²(G, M)` with `Ĥ¹(H, M) = 0` and `Ĥ²(H, M)` cyclic of order `#H`, generated by the
restriction of `u`, for every subgroup `H`. Prove Tate–Nakayama: cup product with `u` is an
isomorphism `Ĥ^n(G, ℤ) → Ĥ^{n+2}(G, M)` for every `n`. State the degree `−2` case, which gives
`G^{ab} ≅ Ĥ⁰(G, M) = M^G / N_G M`.
*Source.* Cassels–Fröhlich Ch. IV §9; Serre, *Local Fields*, Ch. IX §8; NSW Ch. I §7.
*Prerequisites:* L T.1, L T.3, L T.5.

### Layer I: the local input and the ideal-theoretic Artin map

This layer fixes what the global theory takes from the local theory, and constructs it. Layer I
is stated and built in this repository, so that no later layer depends on material outside it.
`Suggested.lean` carries the Lean form of every item.

**I.1. The local class field theory package.** Define one class whose fields quantify over every
nonarchimedean local field `F` and every finite abelian Galois extension `E/F`. One term of the
class therefore carries the whole local theory, and a consumer cannot pick two unrelated pieces
of data. The fields are:

1. a **continuous** homomorphism `Art_{E/F} : Fˣ →* Gal(E/F)`, under the hypotheses
   `[Module.Finite F E]` and `[IsAbelianGalois F E]`;
2. surjectivity of `Art_{E/F}`;
3. the kernel: `Art_{E/F} x = 1` exactly when `x` is a norm from `Eˣ`;
4. restriction in the upper field: for `F ⊆ E ⊆ E'`, the value of `Art_{E'/F}` restricted to `E`
   is the value of `Art_{E/F}`;
5. norm compatibility in the base: for `F ⊆ F' ⊆ E`,
   `Art_{E/F'}(y) = Art_{E/F}(N_{F'/F} y)` on `E`;
6. the arithmetic normalization: for unramified `E/F` and a uniformizer `π` of `F`, `Art(π)`
   acts on the integers of `E` as the `q`-power map modulo the maximal ideal, with `q` the
   residue cardinality of `F`;
7. the conductor exponent `𝔣(E/F) : ℕ`, together with **both** halves of its defining property:
   the principal units of that level are norms, and no smaller level has that property;
8. the local norm index `#(Fˣ / N_{E/F} Eˣ) = [E : F]`, which is `#Ĥ⁰(Gal(E/F), Eˣ) = [E:F]`;
9. the invariant map `inv_{E/F} : H²(Gal(E/F), Eˣ) →+ ℚ/ℤ`, injective, with image the
   `[E:F]`-torsion, so that it is an additive equivalence onto that subgroup;
10. compatibility of `inv` with inflation, which is what glues the local invariants into `ℚ/ℤ`;
11. the quadratic Hilbert symbol in characteristic zero, `(·,·)_F : Fˣ × Fˣ → {±1}`, with the
    conic characterization. Layer 11 consumes the quadratic symbol only, so the package carries
    that one and not an `n`-th symbol with roots-of-unity hypotheses.

Define separately, as ordinary definitions and not as fields: the principal units of level `n`,
and the conductor exponent of a continuous character of `Fˣ`, which is the least level inside
the kernel. I.6 uses the second one.
Item 6 is used by Layer 6. Items 4 and 5 are used by 6.1 and 6.3. Item 7 is used by 6.5, 7.4
and 9.2. Item 8 is used by 5.2. Items 9 and 10 are used by 11.3. Item 11 is used by 11.4.
The package is stated in one universe, because Mathlib's group cohomology puts the coefficient
ring and the group in a single universe.
*Source.* Serre, *Corps Locaux*, Ch. XI to XIV; Neukirch ANT Ch. V; Cassels–Fröhlich Ch. VI.
*Prerequisites:* M `Mathlib/NumberTheory/LocalField/Basic.lean`, M `ValuativeRel`,
M `Mathlib/RepresentationTheory/Homological/GroupCohomology/LowDegree.lean`, L T.1.

**I.2. The ideal-theoretic Artin map.** Let `L/K` be finite abelian, let
`S : Finset (HeightOneSpectrum (𝓞 K))`, and let `hur` say that every prime `Q` of `𝓞 L` above a
prime outside `S` is unramified. That hypothesis is about primes of the upper field: a condition
on `v.asIdeal` alone says nothing about `L/K`. Define
`artinHomAway S hur : J^S →* (L ≃ₐ[K] L)` on the fractional ideals with valuation zero at every
prime of `S`. Prove:

1. the characteristic property: the value at a prime `𝔭 ∉ S` is the arithmetic Frobenius, in the
   sense of Mathlib's `IsArithFrobAt` for a prime `Q` of `𝓞 L` above `𝔭`;
2. uniqueness: a multiplicative map with those values is `artinHomAway`, because the primes
   outside `S` generate `J^S`;
3. the restriction formula: for `K ⊆ L ⊆ M` with `M/K` abelian, `artinHomAway` for `M/K`
   restricted to `L` is `artinHomAway` for `L/K`;
4. the tower formula for `K ⊆ K' ⊆ L` with `L/K` abelian, relating `artinHomAway` over `K'` to
   `artinHomAway` over `K` through the ideal norm;
5. compatibility as `S` grows: for `S ⊆ S'` the carriers are nested and the maps agree.

`S` is a parameter of the construction, and not the ramified set. Layers 6 to 8 use one
instance, `S = support 𝔪₀`. There `hur` holds because the conductor of `L/K` divides `𝔪`, so
every prime outside the support of `𝔪₀` is unramified in `L`. The carrier is then `J^{𝔪₀}`, and
no further restriction is needed.
*Source.* Janusz III §3; Neukirch ANT VI §7.
*Prerequisites:* M `arithFrobAt`, M `IsArithFrobAt`, M `FractionalIdeal`,
M `FractionalIdeal.count`, M `Algebra.IsUnramifiedAt`, M `Ideal.LiesOver`.
**Basic API.**
- *Constructors:* the map from `S` and the unramifiedness hypothesis; the value at a prime.
- *Examples:* `S = ∅`, allowed only for `L/K` unramified everywhere; `S = support 𝔪₀`; `L = K`,
  where the map is trivial; a quadratic extension, where the value is the Legendre symbol.
- *Morphisms:* `J^S →* Gal(L/K)`.
- *Functoriality:* items 3, 4 and 5.
- *Comparison lemmas:* the value on a principal prime; the composite with the map to the ideal
  class group.
- *Naturality:* the square that relates `artinHomAway` for `L/K` and for `M/K`.
- *Edge cases:* a prime of `S` that is unramified; `S` larger than the ramified set.
- *Downstream interface:* Layers 6, 7, 8 and 10C use `artinHomAway` and items 1 to 4.

**I.3. The completion dictionary at a finite place.** For `v : HeightOneSpectrum (𝓞 K)`, the
completion `v.adicCompletion K` is a nonarchimedean local field. Its residue cardinality is
`Ideal.absNorm v.asIdeal`. Its normalized valuation restricts to `HeightOneSpectrum.valuation`
on `K`. The absolute value `FinitePlace.mk v` is `q_v^{-v(·)}`. This statement is where every use
of I.1 enters.
Phrase every unit condition through `adicCompletionIntegers` or through the `ValuativeRel` API.
Do not state new lemmas against the deprecated `Valued` interface.
*Prerequisites:* M `HeightOneSpectrum.adicCompletion`, M `adicCompletionIntegers`,
M `FinitePlace`, M `Ideal.absNorm`, M `IsNonarchimedeanLocalField`.

**I.4. Construction of the package.** Construct the term of I.1. This is local class field
theory, and it is a deliverable of this roadmap. The route is the cohomological one, in seven
submilestones.
1. The unramified tower: `Gal(F^{ur}/F) ≅ Ẑ` with the arithmetic Frobenius as the distinguished
   generator, and the description of the unramified norm groups.
2. The unit filtration `U^{(0)} ⊇ U^{(1)} ⊇ ⋯` with `U^{(0)}/U^{(1)} ≅ 𝓀ˣ` and
   `U^{(n)}/U^{(n+1)} ≅ 𝓀⁺` for `n ≥ 1`, and completeness of `Fˣ` in that filtration.
3. Vanishing: `Ĥ^i(Gal(E/F), U_E) = 0` for every `i` and every unramified `E/F`, from 2 and the
   normal basis theorem.
4. The invariant map: `Ĥ²(Gal(E/F), Eˣ) ≅ (1/[E:F])ℤ/ℤ`, first for unramified `E/F` through the
   valuation and 3, then in general by inflation, giving fields 9 and 10 of I.1.
5. The local class formation: `Ĥ¹(Gal(E/F), Eˣ) = 0`, which is Hilbert 90, and
   `#Ĥ²(Gal(E/F), Eˣ) = [E : F]`, giving field 8.
6. Tate–Nakayama in degree `−2`, from T.6, which produces the reciprocity isomorphism and
   fields 1, 2 and 3; then the normalization 6 by computing on the unramified tower.
7. The conductor and the symbols: field 7 from the unit filtration and the norm groups; field 11
   from the Artin map and Kummer theory.
*Source.* Serre, *Corps Locaux*, Ch. XI to XIV. Cassels–Fröhlich Ch. VI, Serre, "Local class
field theory". Neukirch ANT Ch. V for the Frobenius-lift arrangement. Lubin–Tate theory is the
explicit alternative for 6, and it also gives the explicit reciprocity map.
*Prerequisites:* L I.1, L I.3, L T.1, L T.3, L T.4, L T.6,
M `groupCohomology.H1ofAutOnUnitsUnique`.

**I.5. The cyclotomic orientation over `ℚ_p`.** For `p` a prime, `m` prime to `p`, and
`E = ℚ_p(μ_m)`, prove `χ_cyc(Art_{E/ℚ_p}(u)) = u⁻¹` for `u` a unit of `ℤ_p`, where `χ_cyc` is the
cyclotomic character `Gal(E/ℚ_p) ≅ (ZMod m)ˣ`. Stage 1 of 6.3 consumes this clause, and it is
the statement that fixes the direction of the global map.
**Common error.** The clause is a normalization, not a formality. With the geometric convention
the right-hand side is `u`, and every degree count is unchanged, so a wrong choice here is
invisible until the global reciprocity law fails.
*Source.* Serre, *Corps Locaux*, Ch. XIV §7; Neukirch ANT V §2.
*Prerequisites:* L I.1, L I.4, M `IsCyclotomicExtension.autEquivPow`.

**I.6. The local conductor–discriminant formula.** For finite abelian `E/F`, prove
`v_F(𝔡_{E/F}) = ∑_χ a(χ)`, where `χ` ranges over the characters of `Gal(E/F)`, and `a(χ)` is the
conductor exponent of the character `χ ∘ Art_{E/F}` of `Fˣ`. Milestone 9.2 globalizes this.
*Source.* Serre, *Corps Locaux*, Ch. VI §2, Proposition 6, and Ch. VI §3.
*Prerequisites:* L I.1, L I.4, M `differentIdeal`.

### Layer 0: moduli, approximation, and multiplicative congruences

**0.1. The modulus.** Build the structure of the conventions table: a nonzero ideal together with a
`Finset` of real places. Provide the exponent-function description, and the lemmas that translate
between the two descriptions. Provide the divisibility relation in the pinned orientation, `gcd` and
`lcm` with their exponentwise descriptions, and the support. Provide two named instances: the
trivial modulus `((1), ∅)`, and the modulus with all real places that Layer 1 uses for the narrow
class group. Real places are the reason the formalism exists. A design in which `𝔪∞ = ∅` is the easy
case produces the wide class group everywhere. Give the two components equal weight in the API, and
test with `𝔪∞ ≠ ∅` from the first lemma.
*Prerequisites:* M `Ideal`, M `InfinitePlace.IsReal`, M `UniqueFactorizationMonoid.factorization`,
M `Associates.count`.
**Basic API.**
- *Constructors:* from an ideal and a `Finset`; from an exponent function of finite support.
- *Examples:* `((1), ∅)`; `((1), all real places)`; `((n), ∞)` over `ℚ`.
- *Morphisms:* the divisibility order, `gcd`, `lcm`.
- *Functoriality:* the exponent function is monotone in divisibility.
- *Comparison lemmas:* ideal divisibility against exponentwise inequality; support against the set
  of prime divisors.
- *Naturality:* `gcd` and `lcm` commute with the exponent description.
- *Edge cases:* `𝔪₀ = ⊤`; `𝔪∞ = ∅`; a field with no real place.
- *Downstream interface:* Layers 1, 2A, 3 and 7 use only the two components, divisibility, and the
  exponent function.

**0.2. Simultaneous approximation.** State: let `v₁, …, v_r` be finite places, `a_i ∈ K` targets,
`n_i` exponents, and let `ε_w ∈ {±1}` be a sign at each of finitely many real places `w`. Then there
is one `x ∈ Kˣ` with `ord_{v_i}(x − a_i) ≥ n_i` for every `i`, and `sign_w(x) = ε_w` for every
chosen `w`.
The conclusion is about `Kˣ` and not about `K`. A statement about `K` that reads "`x` is positive
at `w` exactly when `ε_w = 1`" is satisfied by `x = 0` whenever every `ε_w` is `-1`.
Two facts make this a target and not a citation. Mathlib has no weak approximation theorem for
inequivalent absolute values at the pin. The finite conditions and the infinite conditions must
hold for a single element, which the chinese remainder theorem and sign surjectivity do not give
separately.
Route: first prove Artin–Whaples weak approximation, in the form "the image of `K` is dense in
`∏_{v ∈ S} K_v` for a finite set `S` of pairwise inequivalent places". Then read off the
congruence-and-sign form. The archimedean case is Mathlib's
`InfinitePlace.denseRange_algebraMap_pi`, and it is the model for the general proof.
*Source.* Artin–Whaples, as in Janusz IV, Theorem 1.1, p. 137, and Cassels–Fröhlich Ch. II §6.
*False generalization.* Strong approximation is a different statement. It is false to ask for one
element that meets the congruence conditions and is integral at every other place. The obstruction
is the class group. Ask for that only in the `S`-idele form of Layer 5.
*Prerequisites:* M `InfinitePlace.denseRange_algebraMap_pi`, M `HeightOneSpectrum.valuation`,
M `IsDedekindDomain.quotientEquivPiFactors`.

**0.3. Sign maps.** Define the total sign homomorphism `Kˣ →* Π_{w real} {±1}`. Its target is a
group of order two at each place, so use `ℤˣ` or `Multiplicative (ZMod 2)`. Fix that choice once in
`Suggested.lean` and use it unchanged. Layer 1 exact sequence, Layer 3 parity dictionary and Layer
2C `Art_ℝ` all land in the same group. Surjectivity is the archimedean case of 0.2.
*Prerequisites:* M `InfinitePlace.embedding_of_isReal`, L 0.2.

**0.4. The congruence subgroup of `Kˣ`.** Define `K(𝔪) := {x : Kˣ | x ≡ 1 mod* 𝔪}` in the pinned
spelling: valuation inequalities at `v ∣ 𝔪₀`, positivity through `embedding_of_isReal` at `w ∈ 𝔪∞`.
Prove that it is a subgroup, and that it is antitone in `𝔪`. State the comparison with `1 + 𝔪₀` for
integral elements prime to `𝔪₀`, with the hypothesis visible. Prove the subgroup property from the
ultrametric inequality and the sign rules. Do not define `K(𝔪)` through the quotient ring `𝓞 K ⧸
𝔪₀`.
*Prerequisites:* L 0.1, M `HeightOneSpectrum.valuation`, M `InfinitePlace.embedding_of_isReal`.
**Basic API.**
- *Constructors:* membership from the two conditions.
- *Examples:* `K(((1),∅)) = Kˣ`; `K(((1), all real places))` is the totally positive elements.
- *Morphisms:* the inclusion into `Kˣ`.
- *Functoriality:* `𝔪 ∣ 𝔫` gives `K(𝔫) ≤ K(𝔪)`.
- *Comparison lemmas:* against `1 + 𝔪₀`; against the units `𝓞_{K,𝔪}ˣ` of 1.5.
- *Naturality:* intersection with `gcd` and `lcm`.
- *Edge cases:* an element that is a unit at every place of `𝔪₀`; an element with negative sign at a
  place outside `𝔪∞`.
- *Downstream interface:* Layers 1, 2A and 3.

**0.5. The elements prime to the finite part.** "Prime to `𝔪₀`" is not a Lean type. Define the
subgroup `Kˣ_{𝔪₀} := {x : Kˣ | ∀ v ∣ 𝔪₀, ord_v x = 0}` of `Kˣ`. State that it is the unit group of
the localization of `𝓞 K` away from `𝔪₀`, and prove the two descriptions equal.
*Prerequisites:* L 0.1, M `HeightOneSpectrum.valuation`, M `IsLocalization`.

**0.6. The reduction map and its kernel.** On `Kˣ_{𝔪₀}`, define `Kˣ_{𝔪₀} →* (𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞}
{±1}` through the chinese remainder theorem and the sign maps. Prove that it is surjective, with
0.2. Prove that its kernel is exactly `K(𝔪)`. That kernel identity is the computational form of the
Layer 1 exact sequence, so prove it here.
*Prerequisites:* L 0.2, L 0.3, L 0.4, L 0.5, M `IsDedekindDomain.quotientEquivPiFactors`.

### Layer 1: ray class groups and the narrow class group

**1.1. The ideal group and the ray.** Define `J^{𝔪₀}`, the subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ`
of fractional ideals whose support is disjoint from `𝔪₀`. Spell support through the `v`-adic count
of the factorization. Provide the description `I = 𝔞𝔟⁻¹` with `𝔞` and `𝔟` integral and prime to
`𝔪₀`. Define the ray `P_𝔪`, the principal ideals of elements of `K(𝔪)`.
*Prerequisites:* L 0.4, M `FractionalIdeal`, M `toPrincipalIdeal`, M `FractionalIdeal.count`.

**1.2. The ray class group.** Define `Cl_𝔪 K := J^{𝔪₀} ⧸ P_𝔪`. Prove `Cl_{((1),∅)} ≃* ClassGroup (𝓞
K)` as a named isomorphism, through compatibility with `ClassGroup.mk0`.
*Prerequisites:* L 1.1, M `ClassGroup`, M `ClassGroup.mk0`.
**Basic API.**
- *Constructors:* the class of a fractional ideal prime to `𝔪₀`; the class of an integral ideal.
- *Examples:* `Cl_{((1),∅)}(K) = Cl(K)`; `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`; `Cl_{((1),∞)}(ℚ) = 1`.
- *Morphisms:* the quotient map from `J^{𝔪₀}`; the transition maps of 1.4; the map to `ClassGroup (𝓞
  K)` of 1.5.
- *Functoriality:* 1.4 in the modulus.
- *Comparison lemmas:* against `ClassGroup`, against `Pic` of an order in 10B.
- *Naturality:* the transition maps commute in a tower.
- *Edge cases:* `𝔪₀ = ⊤` with `𝔪∞ = ∅`; a field with no real place; class number one.
- *Downstream interface:* Layers 3, 7, 8, 9 and 10C use `Cl_𝔪`, its finiteness, and the transition
  maps.

**1.3. The moving lemma.** Every class of `ClassGroup R`, for `R` a Dedekind domain, contains an
integral ideal prime to a fixed nonzero ideal. Deduce the same statement for `Cl_𝔪`. Route: the
chinese remainder theorem and approximation in the Dedekind domain. Do not use geometry of numbers.
Mathlib has only `ClassGroup.mk0_surjective`, so this is a genuine target. Prove it at Dedekind
generality, because both the surjectivity of `Cl_𝔫 ↠ Cl_𝔪` and the ideal-to-idele dictionary use it.
*Source.* Janusz IV, Proposition 1.5, p. 140, for the ray class form.
*Prerequisites:* M `ClassGroup.mk0_surjective`, M `IsDedekindDomain.quotientEquivPiOfProdEq`,
M `HeightOneSpectrum.valuation_exists_uniformizer`.

**1.4. The transition maps.** For `𝔪 ∣ 𝔫`, construct `Cl_𝔫 ↠ Cl_𝔪`. Prove surjectivity from 1.3.
Prove that the maps compose in a tower `𝔪 ∣ 𝔫 ∣ 𝔩`.
*Prerequisites:* L 1.2, L 1.3.

**1.5. The ray class exact sequence.** Prove the sequence

`1 → 𝓞_{K,𝔪}ˣ → 𝓞_Kˣ → (𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞} {±1} → Cl_𝔪 K → ClassGroup (𝓞 K) → 1`,

where `𝓞_{K,𝔪}ˣ = 𝓞_Kˣ ∩ K(𝔪)`. The third map is 0.6 restricted to global units. The fourth map
sends a class to the ideal it generates. Prove exactness at each interior place as a separate lemma.
Derive the image form `1 → im(𝓞_Kˣ) → (𝓞 K ⧸ 𝔪₀)ˣ × signs → Cl_𝔪 K → Cl K → 1` from it, and not the
reverse.
*Source.* Janusz IV §1, pp. 139–141; Neukirch ANT VI §1.
*Prerequisites:* L 0.6, L 1.2, L 1.3, M `NumberField.Units`.

**1.6. Finiteness and the class number formula.** For a number field, `Cl_𝔪 K` is finite of order
`h_K · #(𝓞 K ⧸ 𝔪₀)ˣ · 2^{#𝔪∞} / [𝓞_Kˣ : 𝓞_{K,𝔪}ˣ]`. State the index form and not only finiteness.
Prove it from 1.5. State it for number fields, or under the explicit finiteness package of the
standing hypotheses.
*False generalization.* The formula is false for a general Dedekind domain, where the class group
and the residue rings can be infinite. The hypotheses are not decoration.
*Source.* Janusz IV, Corollary 1.6 and Proposition 1.7, p. 141.
*Prerequisites:* L 1.5, M `NumberField.classNumber`, M `NumberField.Units.DirichletTheorem`.

**1.7. The unit obstruction.** Prove that `Cl_𝔪` is not `(𝓞/𝔪₀)ˣ × signs × Cl` in general. The exact
sequence shows that the global units glue the factors, and the size of the unit image is a global
quantity. It is the reason ray class groups of real quadratic fields are hard, and the reason `Cl⁺ ≠
Cl` exactly when no unit realizes a given sign pattern. Every statement in this layer must go
through 1.5 and not through a claimed product decomposition.
*Prerequisites:* L 1.5, L 1.6.

**1.8. The narrow class group.** Define `Cl⁺ K` as in the conventions table. Prove `Cl⁺ = Cl` for
totally imaginary `K`. Compute the kernel of `Cl⁺ ↠ Cl` from 1.5: it is an elementary abelian
2-group of order `2^{r₁}/[𝓞_Kˣ : 𝓞_Kˣ⁺]`. Prove the characterization by totally positive principal
ideals. The narrow class group and the surjection `Cl⁺ ↠ Cl` are what the merged Multiquadratic
roadmap names as prerequisites for its real-quadratic 2-rank theorem. Freeze this API with any
implementor who works there.
*Prerequisites:* L 1.2, L 1.5.

**1.9. Dedekind generality.** State 1.1 to 1.5, except the sign components, for a Dedekind domain
with fraction field. Specialize to number fields. Layer 10B and any later function-field work reuse
this.
*Prerequisites:* L 1.1 to L 1.5.
### Layer 2A: the idele class group

**2A.1. The objects.** Define `IdeleGroup R K := (AdeleRing R K)ˣ`, its subgroup of principal
ideles, and `IdeleClassGroup R K` as the quotient. Keep both as reducible abbreviations over
`(AdeleRing R K)ˣ`, so that every `Units` lemma of Mathlib applies without glue.
*Prerequisites:* M `NumberField.AdeleRing`, M `AdeleRing.principalSubgroup`, M `Units.map`.
**Basic API.**
- *Constructors:* a principal idele from `x ∈ Kˣ`; an idele supported at one place, `ι_v`.
- *Examples:* `C_ℚ`; the image of `U_𝔪`; the norm-one subgroup `C_K^1`.
- *Morphisms:* the quotient map `I_K → C_K`; the idele norm of 2A.4; the maps `C_K → C_L` and
  `N_{L/K} : C_L → C_K` of Layer 2B.
- *Functoriality:* 2B.3 and 2B.5 in the extension.
- *Comparison lemmas:* 2A.7 against `Cl_𝔪`; the finite-idele description of `ClassGroup`.
- *Naturality:* the quotient map commutes with the norm and with the extension map.
- *Edge cases:* `K = ℚ`; the trivial modulus; a place where the local component is a unit.
- *Downstream interface:* Layers 3, 5, 6, 7 and 11 use `C_K`, its topology, and 2A.6.

**2A.2. The topology of the idele group.** Prove that `IdeleGroup (𝓞 K) K` is a locally compact
topological group. Use the units topology, which comes from `x ↦ (x, x⁻¹)`, and handle the finite
part with `Topology/Algebra/RestrictedProduct/Units.lean`. The idele class group is treated in
2A.3, because its Hausdorffness needs the principal ideles to be closed.
**Common error.** The idele topology is not the subspace topology from `𝔸_K`. Mathlib's `Units`
topology is already the correct one, so do not re-topologize.
*Prerequisites:* L 2A.1, M `RestrictedProduct.instTopologicalSpaceUnits`,
M `Mathlib/Topology/Algebra/IsOpenUnits.lean`.

**2A.3. Discreteness, cocompactness, and the class group topology.** Prove that `Kˣ` is closed and
discrete in `IdeleGroup (𝓞 K) K`, so that `IdeleClassGroup (𝓞 K) K` is a locally compact Hausdorff
group. Prove that `K` is discrete in `𝔸_K`, and that the quotient
`𝔸_K/K` is compact. These are the additive local-global finiteness statements that the rest of the
layer uses.
*Source.* Cassels–Fröhlich Ch. II §§14–16; Weil, *Basic Number Theory*, Ch. IV.
*Prerequisites:* M `NumberField.AdeleRing`, M `NumberField.canonicalEmbedding`,
M `Mathlib/NumberTheory/NumberField/CanonicalEmbedding/`.

**2A.4. The idele norm and the norm-one subgroup.** Define `‖·‖ : IdeleGroup →* ℝ_{>0}` in the
pinned normalization. Prove the product formula `‖x‖ = 1` for principal `x`, from `prod_abs_eq_one`.
Define `C_K^1` as the kernel on classes, and prove that it is closed.
*Prerequisites:* L 2A.1, M `NumberField.prod_abs_eq_one`, M `FinitePlace`, M `InfinitePlace.mult`.

**2A.5. Compactness of `C_K^1`.** Prove that the norm-one idele class group is compact. This is the
main analytic input of the layer, and the source of the two classical finiteness theorems. Derive as
corollaries the finiteness of `ClassGroup (𝓞 K)` and Dirichlet's unit theorem, and compare each with
Mathlib's independent proof. **Common error.** `C_K` itself is neither compact nor profinite. There
is a choice-dependent splitting `C_K ≅ C_K^1 × ℝ_{>0}`, so `Nat.card` statements about `C_K` say
nothing.
*Source.* Cassels–Fröhlich Ch. II §16; Weil, *Basic Number Theory*, Ch. IV §4.
*Prerequisites:* L 2A.3, L 2A.4, M `NumberField.classNumber`,
M `NumberField.Units.DirichletTheorem`.

**2A.6. The congruence subgroups.** Define `IdeleCongruenceSubgroup 𝔪`, written `U_𝔪`, with the
carrier of the conventions table. Define `RaySubgroup 𝔪` as its image in `C_K`. Prove that both are
open, and that both are antitone in `𝔪`.
*Prerequisites:* L 0.1, L 2A.1, M `adicCompletionIntegers`,
M `InfinitePlace.Completion.ringEquivRealOfIsReal`.
**Basic API.**
- *Constructors:* membership from the component conditions.
- *Examples:* `U_{((1),∅)}` is the everywhere-integral units; `U_{((1), all real places)}` adds
  positivity at every real place.
- *Morphisms:* the inclusion into `IdeleGroup`; the quotient map to `RaySubgroup`.
- *Functoriality:* `𝔪 ∣ 𝔫` gives `U_𝔫 ≤ U_𝔪`.
- *Comparison lemmas:* `U_𝔪 ∩ Kˣ = K(𝔪)`, which links Layer 0 to Layer 2A.
- *Naturality:* the component description is compatible with `gcd` and `lcm`.
- *Edge cases:* a complex place, where there is no condition; a real place outside `𝔪∞`, where there
  is no condition.
- *Downstream interface:* Layers 3, 6 and 7 use `U_𝔪`, `RaySubgroup 𝔪`, openness, and 2A.7.

**2A.7. The ray class dictionary.** Prove `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. Use the map `x ↦ ∏_{v ∤
𝔪₀} v^{ord_v(x_v)}` on ideles, and compute the kernel with 1.3 and 0.6. Prove the special case `𝔪 =
((1), ∅)`, which is `C_K ⧸ RaySubgroup ((1),∅) ≃* ClassGroup (𝓞 K)`. Prove that the isomorphisms
commute with the transition maps of 1.4 as `𝔪` grows.
*Source.* Cassels–Fröhlich Ch. II §17; Milne CFT V §4.
*Prerequisites:* L 1.2, L 1.3, L 1.4, L 0.6, L 2A.6.

**2A.8. Open subgroups and the connected component.** Prove that every open subgroup of `C_K`
contains `RaySubgroup 𝔪` for some `𝔪`. Prove that `D_K`, the identity component of `C_K`, is closed
and divisible, and that `D_K ≤ RaySubgroup 𝔪` for every `𝔪`. Prove that `C_K/D_K` is profinite and
that `C_K/D_K ≅ lim_𝔪 Cl_𝔪` as topological groups. The full structure of `D_K` as a solenoid is not
a target. The three properties above are what Layers 3 and 7 use. **Common error.** "Every open
subgroup contains some `U_𝔪`" is a statement about open subgroups. The kernel of a continuous
character need not be open, so it says nothing about a general character.
*Prerequisites:* L 2A.5, L 2A.6, L 2A.7.

### Layer 2B: ideles in a finite extension

`L/K` is a finite extension of number fields. `w ∣ v` means that `w` is a place of `L` above the
place `v` of `K`. Layers 5, 6 and 11 treat `C_L` as a `Gal(L/K)`-module, and every statement they
use is here.

**2B.1. The base-change algebra structure.** Give `𝔸_L` the structure of an `𝔸_K`-algebra, and prove
the comparison `𝔸_L ≃ L ⊗_K 𝔸_K` as topological rings.
*Source.* Cassels–Fröhlich Ch. II §19; Weil,
*Basic Number Theory*, Ch. IV §1.
*Prerequisites:* M `NumberField.AdeleRing`, M `FiniteAdeleRing`, M `InfiniteAdeleRing`, L I.3.

**2B.2. The Galois action.** For `L/K` Galois with `G = Gal(L/K)`, define the action of `G` on
`𝔸_L`, on `I_L` and on `C_L`. Prove that it permutes the places over each `v`, that it acts on each
completion through the induced isomorphism `L_w ≃ L_{σw}`, and that it is continuous. Prove that the
principal ideles form a `G`-stable subgroup, and that the action restricts to the usual action on
`L`.
*Prerequisites:* L 2B.1, M `Ideal.primesOver`, M `MulAction.stabilizer`.

**2B.3. The extension map.** Define `I_K →* I_L` with component at `w ∣ v` induced by `K_v → L_w`.
Prove that it is well defined on the restricted product, continuous and injective. Define the
descent `C_K →* C_L`, and prove compatibility with `K ⊆ L` on principal ideles.
*Prerequisites:* L 2B.1.

**2B.4. The idele norm.** Define `N_{L/K} : I_L →* I_K` with component formula `N(x)_v = ∏_{w ∣ v}
N_{L_w/K_v}(x_w)`. Prove: well-definedness on the restricted product, using that `N_{L_w/K_v}` maps
local units to local units at almost all `w`; continuity; `N(principal x) = principal (Algebra.norm
K x)`; and the descent `N_{L/K} : C_L →* C_K`.
*Prerequisites:* L 2B.1, L I.3, M `Algebra.norm`.

**2B.5. Towers and base change.** Prove `N_{M/K} = N_{L/K} ∘ N_{M/L}` for `K ⊆ L ⊆ M`. Prove the
matching transitivity of extension maps. Prove the commuting squares that relate extension, norm and
the Galois action. Prove `N_{L/K} ∘ (extension) = (·)^{[L:K]}` on `I_K` and on `C_K`.
*Prerequisites:* L 2B.3, L 2B.4.

**2B.6. The semi-local decomposition.** Let `L/K` be Galois and let `v` be a place of `K`. Prove
that the `G`-module `∏_{w ∣ v} L_wˣ` is coinduced from the decomposition group `G_w` acting on
`L_wˣ`, for any chosen `w ∣ v`. Prove that the statement is independent of the choice, up to the
canonical
isomorphism. Prove the identification of `G_w` with `Gal(L_w/K_v)`. This is the input to Shapiro's
lemma in Layer 5. The component formula of 2B.4 is its multiplicative shadow.
*Prerequisites:* L 2B.2, L I.3, M `MulAction.stabilizer`, M `Ideal.ramificationIdx`.

**2B.7. Invariants.** Prove `(I_L)^G ≃ I_K`. Prove `(C_L)^G ≃ C_K`, and derive it from the first
statement through the exact sequence `1 → Lˣ → I_L → C_L → 1` and Hilbert 90. **Common error.**
`(C_L)^G ≃ C_K` is not formal. The cokernel of `C_K → (C_L)^G` injects into `H¹(G, Lˣ)`, and it is
Hilbert 90 that makes that group trivial.
*Prerequisites:* L 2B.2, M `groupCohomology.H1ofAutOnUnitsUnique` (Hilbert 90).

### Layer 2C: the archimedean local package

The interface of Layer I is nonarchimedean. The real and complex theory is built here. It is
elementary, it is expressible at the pin, and Layers 5, 6, 7 and 11 use it. State everything in the
`InfinitePlace` vocabulary.

**2C.1. Classification of the completions.** For an infinite place `w` of `K`, prove that
`w.Completion` is `ℝ` when `w.IsReal` and `ℂ` when `w.IsComplex`. Fix once which of the two
embeddings `ℂ → ℂ` is used at a complex place, and prove that the objects below do not depend on
that choice.
*Prerequisites:* M `InfinitePlace.Completion.ringEquivRealOfIsReal`,
M `ringEquivComplexOfIsComplex`.

**2C.2. The local Galois group.** Prove that `Gal(ℂ/ℝ)` is cyclic of order two, generated by complex
conjugation, and that `Gal(ℂ/ℂ)` is trivial. For `w ∣ v` infinite places of `L/K`, prove that the
decomposition group at `w` is trivial when `v` splits, and is generated by complex conjugation when
`v` ramifies.
*Prerequisites:* L 2C.1, M `InfinitePlace.IsRamified`, M `Complex.conjAe`.

**2C.3. The reciprocity maps.** Define `Art_ℂ : ℂˣ →* Gal(ℂ/ℂ)`, which is trivial. Define `Art_ℝ :
ℝˣ →* Gal(ℂ/ℝ)`, which sends a positive element to `1` and a negative element to complex
conjugation. Prove surjectivity of `Art_ℝ` and `ker Art_ℝ = ℝ_{>0}`.
*Prerequisites:* L 2C.1, L 2C.2.

**2C.4. Norms and norm groups.** Prove `N_{ℂ/ℝ}(ℂˣ) = ℝ_{>0}`, so that `ℝˣ / N_{ℂ/ℝ}(ℂˣ)` has order
two and `Art_ℝ` induces an isomorphism onto `Gal(ℂ/ℝ)`. Prove that at a complex place the norm map
is surjective and the quotient trivial. These two statements are the archimedean case of local
reciprocity, in the shape of I.1.
*Prerequisites:* L 2C.3, M `Complex.normSq`.

**2C.5. Cohomology.** Prove `H¹(Gal(ℂ/ℝ), ℂˣ) = 1` and `Ĥ⁰(Gal(ℂ/ℝ), ℂˣ) ≅ ℤ/2`, hence `h(Gal(ℂ/ℝ),
ℂˣ) = 2 = [ℂ:ℝ]`. Layer 5 uses these as the archimedean factors of the global Herbrand computation,
where they carry as much weight as the finite ones.
*Prerequisites:* L T.1, L T.4, L 2C.4, M
`Mathlib/RepresentationTheory/Homological/GroupCohomology/FiniteCyclic.lean`.

**2C.6. Invariants.** Prove `inv_ℂ = 0` and `inv_ℝ : H²(Gal(ℂ/ℝ), ℂˣ) ≃ (1/2)ℤ/ℤ ⊆ ℚ/ℤ`, with the
nontrivial class going to `1/2`. State the compatibility with the normalization of `inv_v` in
I.1 item 9, because Layer 11 adds the finite and infinite invariants together.
*Prerequisites:* L 2C.5, L I.1.

**2C.7. Ramification and conductors at infinity.** For finite abelian `L/K` and a real place `w` of
`K`, prove that the following are equivalent: `w` is unramified in `L`; the local norm group at `w`
is all of `ℝˣ`; `w ∉ 𝔣(L/K)∞`. This is the real-place clause of 6.5 and of 7.4.
*Prerequisites:* L 2C.4, L 2C.2.

**2C.8. Hilbert symbols.** Prove `(a, b)_ℂ = 1` for all `a, b ∈ ℂˣ`. Prove `(a, b)_ℝ = −1` exactly
when `a < 0` and `b < 0`. Prove bimultiplicativity and nondegeneracy in the real case. Use the same
symbol vocabulary as I.1 item 11, because Layer 11 takes a product over all places.
*Prerequisites:* L 2C.1, L I.1.
### Layer 3: Hecke characters and the finite-order dictionary

**3.1. The definition and the finite-order dictionary.** Define `HeckeCharacter K :=
ContinuousMonoidHom (IdeleClassGroup (𝓞 K) K) ℂˣ`. Prove that the following are equivalent for `χ`:
`χ` has finite order; `ker χ` is open; `χ` is the pullback of a character of `Cl_𝔪 K` for some `𝔪`.
Each implication is a named lemma. Deduce the bijection between the finite-order Hecke characters
with `U_𝔪 ⊆ ker χ` and the characters of the finite group `Cl_𝔪 K`. That composite notion is what
"ray class character" names. The step from an open kernel to a ray class character is 2A.8. The step
back uses finiteness of `Cl_𝔪 K`, and the compactness of `C_K/D_K`; it is not formal.
*Prerequisites:* L 1.6, L 2A.7, L 2A.8, M `ContinuousMonoidHom`.
**Basic API.**
- *Constructors:* from a character of `Cl_𝔪 K`; from a Dirichlet character over `ℚ`; the norm
  character `‖·‖^s`.
- *Examples:* the trivial character; `ZMod.χ₄` over `ℚ`; the quadratic character of `ℚ(√d)`.
- *Morphisms:* pointwise product, inverse, and restriction along a finite extension.
- *Functoriality:* pullback along `C_L → C_K`, and the base-change formula for conductors.
- *Comparison lemmas:* 3.4 against `DirichletCharacter`.
- *Naturality:* the transition maps of 1.4 are compatible with the inclusion of ray class
  characters.
- *Edge cases:* a character with a nonopen kernel, such as `‖·‖^s`; a character trivial on `U_𝔪` for
  the trivial `𝔪`.
- *Downstream interface:* Layers 9 and 10A, and any later analytic development.

**3.2. The finite conductor ideal.** Let `χ` be a continuous quasicharacter. Prove that the local
component `χ_v` is trivial on `1 + 𝔭_v^n` for `n` large. The reason is that the principal-unit
filtration is a neighbourhood basis of `1`. Define `n_v(χ)` as the least such `n`, with `n_v(χ) = 0`
exactly when
`χ_v` is trivial on `𝒪_vˣ`. Prove `n_v(χ) = 0` for almost all `v`, and define `𝔣₀(χ) = ∏_v
𝔭_v^{n_v(χ)}`. Minimality here is one place at a time and needs no global argument.
*Prerequisites:* L 3.1, L I.3.

**3.3. The ray conductor modulus.** Let `χ` be trivial on the connected component of the
archimedean part. Every finite-order character has that property. Define the ray conductor of
`χ` as the least `𝔪` with `U_𝔪 ⊆ ker χ`. Prove that its finite part is `𝔣₀(χ)`, and that its
infinite part is
the set of real places where the local sign component is nontrivial. Prove that a least element
exists: show that the set of admissible moduli is closed under `gcd`, with 3.2 at the finite places
and the sign components at the real places. State primitivity, and induction from a smaller modulus,
in the shape of `DirichletCharacter.changeLevel`. **Common error.** A general quasicharacter has no
ray conductor, because `‖·‖^s` is trivial on no `U_𝔪`. Keep 3.2 and 3.3 apart.
*Prerequisites:* L 3.2, L 2A.6, M `DirichletCharacter.changeLevel`.

**3.4. Local components and the Dirichlet dictionary.** Define `χ_v` on local units at finite `v`,
and `χ_w` at infinite `w`. Prove `χ = ∏_v χ_v` on ideles, as a finite product on each idele. For `K
= ℚ` and each `n ≥ 1`, prove the equivalence between the finite-order Hecke characters of `ℚ` with
`U_{(n)∞} ⊆ ker χ` and `DirichletCharacter ℂ n`, compatible with conductors. Prove the parity
clause, which carries the classical bookkeeping. Evaluate `∏_v χ_v(x) = 1` at the principal idele `x
= −1`. The finite components and the real sign component are then not independent, and the real
component is nontrivial exactly when the Dirichlet character is odd. So the infinite place lies in
the ray conductor exactly for odd characters. State `ZMod.χ₄` as the instance: finite conductor `4`,
ray conductor `(4)·∞`. **Common error.** There is no sign character of `ℚ`. `Cl_{((1),∞)}(ℚ) = 1`,
because every fractional ideal of `ℤ` has a unique positive generator. State that triviality
explicitly.
*Prerequisites:* L 3.1, L 3.3, M `DirichletCharacter`, M `ZMod.χ₄`.

**3.5. Unitary theory.** Prove that `|χ| = ‖·‖^σ` for a unique real `σ`, and that `χ = χ_u · ‖·‖^σ`
with `χ_u` unitary. Uniqueness holds because `σ` is fixed by `|χ| = ‖·‖^σ` and `‖·‖` surjects onto
`ℝ_{>0}`. Normalize the exponent to be real, because a complex exponent is ambiguous exactly up to
the unitary twists `‖·‖^{it}`.
*Prerequisites:* L 2A.4, L 3.1.

### Layer 4: the cyclotomic anchor

This layer is expressible against Mathlib alone, and it is the arithmetic input that every
reciprocity proof reduces to.

**4.1. The splitting law in `ℚ(ζₙ)`.** For `p ∤ n`, prove that the decomposition group at `p` is
generated by `[p]` under `galEquivZMod`. Deduce that `f` is the order of `p` in `(ℤ/n)ˣ`, and that
`p` splits completely exactly when `p ≡ 1 (mod n)`. Spell "splits completely" with `Set.ncard` of
`Ideal.primesOver`.
*Prerequisites:* M `IsCyclotomicExtension.Rat.galEquivZMod`, M `galEquivZMod_stabilizer`,
M `Ideal.primesOver`.

**4.2. Ramification, in three statements.** State them in increasing generality, because the first
is often quoted beyond its range.
1. Prime-power level: for `n = p^a` with `p^a > 2`, the element `ζ_{p^a} − 1` generates the unique
   prime above `p`, which is totally ramified with `e = φ(p^a)` and `f = 1`.
2. General level: write `n = p^a m` with `p ∤ m`; then `e = φ(p^a)`, `f` is the order of `p` in
   `(ℤ/m)ˣ`, and `g = φ(m)/f`.
3. Which primes ramify: define `n₀ = n/2` when `n ≡ 2 (mod 4)`, and `n₀ = n` otherwise, so that
   `ℚ(ζ_n) = ℚ(ζ_{n₀})`. For `n₀ ≥ 3`, the ramified finite primes are exactly those dividing `n₀`,
   and the infinite place ramifies as well. For `n₀ ≤ 2` the field is `ℚ`.

**Common error.** "Ramified exactly at the primes dividing `n`" is false. `ℚ(ζ₆) = ℚ(ζ₃)` is
unramified at `2`.

*Prerequisites:* M `Mathlib/NumberTheory/NumberField/Cyclotomic/Ideal.lean`,
M `IsCyclotomicExtension`.

**4.3. Artin reciprocity for `(ℚ, ℚ(ζₙ))`.** Prove `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ` from 1.5 at `K = ℚ`,
where the units `±1` are absorbed by the sign component. Compose with the Mathlib isomorphism `(ZMod
n)ˣ ≃* Gal(ℚ(ζₙ)/ℚ)` to get `Cl_{(n)∞}(ℚ) ≃* Gal(ℚ(ζₙ)/ℚ)` that sends the class of `(p)` to `Frob_p`
for `p ∤ n`. This is Artin reciprocity for the cyclotomic case, proved with no class field theory,
and it is the normalization anchor for Layer 6. The identification of the arithmetic Frobenius with
`[p]` under `galEquivZMod` is I.2 and Mathlib's `arithFrobAt`; use it, and do not restate it as a
separate target. **Common error.** The geometric convention sends `[p]` to `Frob_p⁻¹`. Both
conventions compose with `galEquivZMod` to give an automorphism of `(ℤ/n)ˣ`, so a degree count does
not detect the error. Fix the direction by the stabilizer computation of 4.1.
*Prerequisites:* L 1.5, L I.2, L 4.1, M `IsCyclotomicExtension.Rat.galEquivZMod`.

**4.4. The conductor of `ℚ(ζₙ)/ℚ`.** Prove that the conductor is `(n₀)·∞` for `n₀ ≥ 3`, and the
trivial modulus otherwise. Prove it here, from the ramification statements of 4.2 and the real
place, and not from the existence theorem.
**Common error.** A ray class field belongs to a modulus, and a conductor is the least modulus that
works. The identity `ℚ_{(n)∞} = ℚ(ζₙ)` holds for every `n`, including every nonminimal modulus;
that identity is 7.7 and belongs to Layer 7, because it uses the existence theorem.
*Prerequisites:* L 4.2, L 4.3.

### Layer 5: the norm-index machinery

All cohomology in this layer is of finite groups. For finite Galois `L/K` set `G = Gal(L/K)`. Every
statement uses the Galois action, the norms and the semi-local decomposition of Layer 2B.

**5.1. The `S`-idele setup.** Fix the convention. `S` is a finite set of places of `K` that
contains the infinite places and the places ramified in `L`. `S_L` is the set of places of `L`
above `S`. Then `S_L` is finite and `G`-stable, so no separate stability hypothesis is needed.
Prove:
1. `I_{L,S} := {x ∈ I_L | ∀ w ∉ S_L, x_w ∈ 𝒪_wˣ}` is an open `G`-stable subgroup;
2. the `S`-unit group `𝓞_{L,S}ˣ = Lˣ ∩ I_{L,S}` agrees with Mathlib's `Set.unit` for the
   corresponding set of finite places;
3. `I_{L,S} = ∏_{v ∈ S} ∏_{w ∣ v} L_wˣ × ∏_{v ∉ S} ∏_{w ∣ v} 𝒪_wˣ` as `G`-modules, with the second
   factor a restricted product;
4. `I_L = I_{L,S} · Lˣ` exactly when the classes of the primes in `S_L` generate `ClassGroup (𝓞 L)`,
   and some finite `S` has that property;
5. `C_L ≅ I_{L,S} / 𝓞_{L,S}ˣ` for such an `S`, as `G`-modules;
6. the transition maps `I_{L,S} ↪ I_{L,S'}` for `S ⊆ S'` form a directed system;
7. `I_L = colim_S I_{L,S}` as `G`-modules, with the colimit filtered;
8. finite-group cohomology commutes with filtered colimits, so `H^i(G, I_L) = colim_S H^i(G,
   I_{L,S})` in every degree;
9. `H^i(G, I_{L,S}) ≅ ⊕_{v ∈ S} H^i(G_w, L_wˣ) ⊕ ⊕_{v ∉ S} H^i(G_w, 𝒪_wˣ)` by Shapiro's lemma
   applied to 2B.6, and `H^i(G_w, 𝒪_wˣ) = 0` for `i ≥ 1` at unramified `v`, so `H^i(G, I_L) ≅ ⊕_v
   H^i(G_w, L_wˣ)` for `i ≥ 1`. Do not hide any of this inside one displayed equality.

*Source.* Neukirch ANT VI §1 and §3; Milne CFT VII §§2–4.
*Prerequisites:* L 2B.4, L 2B.6, L 2A.5, L I.1, M `Set.unit`,
M `groupCohomology.coindIso` (Shapiro).

**5.2. Herbrand quotients.** For cyclic `L/K`, prove in order:
1. `h(G, I_{L,S}) = ∏_{v ∈ S} [L_w : K_v]`, from 5.1.9, from `h(G_w, L_wˣ) = [L_w:K_v]` at finite
   places (I.1 item 8), and from the archimedean factors of 2C.5;
2. the logarithmic `S`-unit lattice: the map `𝓞_{L,S}ˣ → ⊕_{w ∈ S_L} ℝ`, `u ↦ (log ‖u‖_w)_w`, has
   finite kernel `μ(L)` and image a lattice of rank `#S_L − 1` in the trace-zero hyperplane;
3. the `ℝ[G]`-module comparison `ℝ ⊗ 𝓞_{L,S}ˣ ≅ ℝ[S_L] / ℝ`, where `ℝ[S_L]` is the permutation
   module on the places above `S`;
4. invariance of the Herbrand quotient under an equivariant map with finite kernel and finite
   cokernel, hence under any comparison that becomes an isomorphism after tensoring with `ℝ`;
5. the Herbrand quotient of a permutation lattice: `h(G, ℤ[G/H]) = #H`, so `h(G, ℤ[S_L]) = ∏_{v ∈ S}
   [L_w:K_v]` and `h(G, ℤ) = [L:K]`;
6. hence `h(G, 𝓞_{L,S}ˣ) = (∏_{v ∈ S} [L_w:K_v]) / [L:K]`, and therefore `h(G, C_L) = [L:K]`. Deduce
   `herbrand_ge`: `[C_K : N_{L/K} C_L] ≥ [L:K]`, using finiteness of `H¹(G, C_L)`. Item 4 is the
   content of the sentence "the Herbrand quotient depends only on `ℝ ⊗ M`", and it is a target and
   not a remark.

**Common error.** The Herbrand quotient is defined for a finite cyclic group and a module with
finite cohomology. It is not defined for an infinite group, and item 4 fails without the finiteness
of both kernel and cokernel.
*Source.* Neukirch ANT VI §3; Milne CFT VII §§2–5.

*Prerequisites:* L T.4, L 5.1, L 2C.5, M
`Mathlib/RepresentationTheory/Homological/GroupCohomology/FiniteCyclic.lean`, M
`NumberField.Units.DirichletTheorem`, L I.1.

**5.3. `kummer_le`.** For cyclic `L/K`, prove `[C_K : N C_L] ≤ [L:K]`. Use the algebraic route, in
eight steps.
1. Reduce from cyclic degree `n` to cyclic steps of prime degree `p`, by multiplicativity of the
   index in a tower.
2. Base change to `K_cyc := K(μ_p)`. Its degree `e := [K_cyc : K]` divides `p − 1`, so `e` is prime
   to `p`. Then `L ∩ K_cyc = K`, and `L_cyc := L·K_cyc` is cyclic of degree `p` over `K_cyc`.
3. Descend from `K_cyc` to `K`, as follows. The extension map `C_K → C_{K_cyc}` carries `N_{L/K}
   C_L` into `N_{L_cyc/K_cyc} C_{L_cyc}`, so it induces `res : C_K/N_{L/K} C_L →
   C_{K_cyc}/N_{L_cyc/K_cyc} C_{L_cyc}`. The idele class norm `N_{K_cyc/K}` carries `N_{L_cyc/K_cyc}
   C_{L_cyc}` into `N_{L/K} C_L`, so it induces `cor` in the other direction. Then `cor ∘ res` is
   multiplication by `e`, because `N_{K_cyc/K} ∘ (extension) = (·)^e` by 2B.5. Under the
   identification `Gal(L_cyc/K_cyc) ≃ Gal(L/K)` these two maps are restriction and corestriction on
   `Ĥ⁰`. The group `C_K/N_{L/K} C_L` has exponent dividing `p`, because `N_{L/K}(ext x) = x^p`.
   Multiplication by `e` is therefore an automorphism of it, and `res` is injective. Hence `[C_K :
   N_{L/K} C_L] ≤ [C_{K_cyc} : N_{L_cyc/K_cyc} C_{L_cyc}]`, and steps 4 to 7 bound the right side by
   `p`.
4. Classify with Kummer theory once `μ_p ⊆ K`: `L = K(a^{1/p})` for some `a ∈ Kˣ`, in the vocabulary
   of `Mathlib/FieldTheory/KummerExtension.lean`.
5. Choose `S` to contain the infinite places, the places above `p`, the ramified places, and enough
   places for `I_K = I_{K,S} · Kˣ`. State the `S`-unit Kummer exact sequence.
6. Prove finiteness and the dimension count for `Kˣ_S/(Kˣ_S)^p` as an `𝔽_p`-space, from the `S`-unit
   theorem.
7. Prove the counting lemma `[I_K : Kˣ · N I_L · U] ≤ p` for the relevant open subgroup `U`.
8. Induct back up the tower.
*Source.* Chevalley's argument, as in Milne CFT VII §6; Lang ANT Ch. IX; Janusz V §§2–4. **Common
error.** The analytic route through Dirichlet density proves the same inequality. Do not use it
here: reciprocity would then depend on an analytic development, which inverts the dependency order.
Record it only as an alternative proof that these statements stay compatible with.
*Prerequisites:* L 5.1, L 5.2, L 2B.5, M `Mathlib/FieldTheory/KummerExtension.lean`, M `Set.unit`.

**5.4. The class field axiom.** For cyclic `L/K`, prove `#Ĥ⁰(G, C_L) = [L:K]` and `H¹(G, C_L) = 1`.
Then extend to arbitrary finite Galois `L/K` in two named steps.
1. Solvable induction with inflation and restriction gives `H¹(G, C_L) = 1` and `#H²(G, C_L) ≤ #G`
   for solvable `G`, in particular for `p`-groups.
2. For general `G`, restrict to a Sylow `p`-subgroup `G_p`. Corestriction after restriction is
   multiplication by `[G : G_p]`, which is prime to `p`, so the `p`-primary component of `H^i(G,
   C_L)` injects into `H^i(G_p, C_L)`. Apply step 1 to `L/L^{G_p}`. Multiply over the primes
   dividing `#G` to get `H¹(G, C_L) = 1` and `#H²(G, C_L) ≤ [L:K]`. Corollary: `N_{L/K} C_L` has
   finite index dividing `[L:K]` in `C_K`, for every finite Galois `L/K`.

**Common error.** Solvable induction alone does not reach a general finite group. Step 2 is a
separate argument and must be stated.
*Prerequisites:* L T.3, L 5.2, L 5.3, M
`Mathlib/RepresentationTheory/Homological/GroupCohomology/LongExactSequence.lean`, M
`groupCohomology.Functoriality`, M `Sylow`.

**5.5. The Hasse norm theorem.** For **cyclic** `L/K`, prove that `x ∈ Kˣ` is a norm from `Lˣ`
exactly when it is a local norm at every place. Deduce it from `H¹(G, C_L) = 1` and the exact
sequence `1 → Lˣ → I_L → C_L → 1`. State the cyclic hypothesis in the statement, not in a comment.
**False generalization, with a counterexample.** The theorem fails for noncyclic extensions. Define
the knot group `Kn(L/K) := (Kˣ ∩ N_{L/K} I_L) / N_{L/K} Lˣ`, which is trivial exactly when the norm
principle holds. State Tate's description of it through `Ĥ^{-3}(G, ℤ) ≅ H₂(G, ℤ)`, which is T.2,
and the local groups `Ĥ^{-3}(G_v, ℤ)`. For `G ≅ (ℤ/2)²` with every decomposition group proper, hence
cyclic, every
local group vanishes and the knot group is `ℤ/2`. The instance to prove is `L = ℚ(√13, √17)` and the
rational `25`; see the worked examples.
*Source.* Milne CFT VIII §3; Cassels–Fröhlich Exercise 5.3, p. 360.
*Prerequisites:* L 5.4, L 2B.4, L 2B.7, L T.2.
### Layer 6: the global Artin map and the reciprocity law

From here on the interface of Layer I is essential, together with Layer 2C at the infinite places.

**6.1. The compilation map.** For finite abelian `L/K` define `θ_{L/K} : I_K →* Gal(L/K)`,
`θ((x_v)_v) = ∏_v Art_{K_v}(x_v)∣_L`. The definition is short and its ingredients are not, so each
of the following is a target.
1. For a place `v` of `K` and a chosen `w ∣ v` in `L`, identify `Gal(L_w/K_v)` with the
   decomposition group at `w`.
2. Prove independence of the choice of `w`, which holds because `L/K` is abelian, so that the local
   factor is well defined.
3. Define the local factor `Art_{K_v}(·)∣_L : K_vˣ →* Gal(L/K)`, from I.1 at finite places and from
   2C.3 at infinite places.
4. Prove triviality at almost all places: if `v` is unramified in `L` and `x_v ∈ 𝒪_vˣ` then
   `Art_{K_v}(x_v)∣_L = 1`. This is what makes the product finite on each idele.
5. Prove that the product is well defined on the restricted product, and multiplicative.
6. Prove that `θ_{L/K}` is continuous.
7. Prove `θ(ι_v(x)) = Art_{K_v}(x)∣_L` for an idele supported at one place. This is the local-global
   compatibility statement that every later layer uses, and it holds by construction.
8. Prove functoriality in `L`: `θ_{M/K}` restricts to `θ_{L/K}` for `K ⊆ L ⊆ M`.
*Source.* Neukirch ANT VI §5; Milne CFT V §4.
*Prerequisites:* L I.1, L 2B.6, L 2C.3, L 2A.1.

**6.2. Surjectivity, without density.** Prove that `θ_{L/K}` is surjective. Argument: if the image
were a proper subgroup, its fixed field would be a nontrivial subextension `M/K`, which may be taken
cyclic. The compiled map to `M` would then be trivial, so every local Artin map to `M` would be
trivial. By local reciprocity every place of `K` would split completely in `M`, and every local norm
map would be surjective. By 2B.4 the global norm `N_{M/K} : I_M → I_K` would then be surjective, so
`N_{M/K} C_M = C_K` and the norm index would be `1`. That contradicts `herbrand_ge` for nontrivial
cyclic `M/K`. **Common error.** Do not import a Chebotarev-style density argument here.
*Source.* Janusz V §5; Artin–Tate.
*Prerequisites:* L 6.1, L 5.2, L 2B.4, L I.1.

**6.3. The reciprocity law.** Prove `θ_{L/K}(Kˣ) = 1`, that is `∏_v Art_{K_v}(x)∣_L = 1` for `x ∈
Kˣ`. The route has three stages.

*Stage 1, cyclotomic extensions of `ℚ`.* Compute directly, with 4.3 and the cyclotomic orientation
clause `χ_cyc(Art(u)) = u⁻¹` of I.5, together with the archimedean factor of 2C.3. A sign error
anywhere upstream appears here, which is the purpose of the stage. Prove the base change statement
separately: reciprocity for `K(ζ_n)/K` follows from the case over `ℚ`, by the norm
compatibility I.1 item 5.

*Stage 2, cyclic `L/K`, by Artin's crossing argument.* State the lemma in full.

- **Artin's lemma.** Let `L/K` be cyclic of degree `n`, let `𝔭` be a prime of `K` unramified in `L`,
  and let `S` be a finite set of rational primes. There are an integer `m`, prime to every element
  of `S` and to `𝔭`, and a finite extension `E/K` with:
  1. `L ∩ E = K`;
  2. `L ∩ K(ζ_m) = K`;
  3. `L(ζ_m) = E(ζ_m)`, so that `LE ⊆ E(ζ_m)`, and `LE/E` lies in a cyclotomic extension of `E`;
  4. `𝔭` splits completely in `E/K`.

  Since `m` is prime to `𝔭`, and `𝔭` is unramified in `L`, `𝔭` is unramified in `L(ζ_m)/K` and so
  in `LE/K`. **Common error.** `E/K` is not cyclotomic, and nothing in the argument makes it so.
  The cyclotomic extensions in the lemma are `K(ζ_m)/K` and `E(ζ_m)/E`. The lattice:

  ```
      L(ζ_m) = E(ζ_m)
            |
           LE
          /   \
         L     E
          \   /
            K
  ```

  `K(ζ_m)` sits between `K` and `L(ζ_m)`, and meets `L` in `K`. Construction, as targets:
  `Gal(L(ζ_m)/K) ≅ Gal(L/K) × Gal(K(ζ_m)/K)` by item 2. Let `σ` generate `Gal(L/K)`. Let `τ ∈
  Gal(K(ζ_m)/K)` have order divisible by `n`, and generate a cyclic group that meets
  `⟨Frob_𝔭|K(ζ_m)⟩` trivially. Take `E` to be the fixed field of `H = ⟨σ × τ, Frob_𝔭|L ×
  Frob_𝔭|K(ζ_m)⟩`. Then `H` contains the decomposition group of `𝔭`, which gives item 4. `H`
  restricts onto `Gal(L/K)`, which gives item 1. `H ∩ (Gal(L/K) × 1) = 1`, which gives item 3. The
  numerical input, in two lemmas with their exact hypotheses.
  - For integers `a ≥ 2` and `r ≥ 2`, and a prime `q`, some prime `p` has `a` of multiplicative
    order exactly `q^r`. **Common error.** The hypothesis `r ≥ 2` is needed. For `r = 1` the
    statement fails: a prime at which `3` has order two would divide `3² − 1 = 8` and not
    `3 − 1 = 2`, and no such prime exists. Prove the `r ≥ 2` form, and add `a = 3`, `q = 2`,
    `r = 1` as a test that the hypothesis is used.
  - Let `n = q₁^{r₁}⋯q_s^{r_s}` and let `a ≥ 2`. There are infinitely many squarefree
    `m = p₁⋯p_s p'₁⋯p'_s` such that `n` divides the order of `a` modulo `m`. There is also a `b`
    whose order modulo `m` is divisible by `n` and which is independent of `a` modulo `m`. The
    least prime divisor of `m` can be taken arbitrarily large, which is how the `m_i` are made
    pairwise coprime and prime to `S`.
  Apply the second lemma to `a = N𝔭`. Both proofs are elementary, in the style of Mathlib's
  `Nat.exists_prime_gt_modEq_one`. No theorem on primes in arithmetic progressions is used, which
  is what keeps this layer independent of any analytic development.
*Source.* Lang ANT Ch. X §2, p. 202; Janusz V, Lemma 5.6, p. 194. The numerical lemmas are
Janusz V, Lemma 5.3, p. 192, which assumes `a ≥ 2` and `r ≥ 2`, and Janusz V, Lemma 5.4, p. 193.
- **One prime at a time.** Use the one-prime form. Do not state a simultaneous version. The proof
  applies the lemma separately to each prime in the factorization of the ideal whose symbol is
  computed. It chooses the `m_i` pairwise coprime, through the parameter `S`. It then works in
  the compositum `F = E₁⋯E_r`.
- **Restriction.** `L ∩ E = K` makes `res : Gal(LE/E) → Gal(L/K)` an isomorphism, and the same holds
  for `F` in place of `E`. The symbol computed over `E` is read over `K` along that isomorphism.
- **Transport.** `θ_{LE/E}(y)∣_L = θ_{L/K}(N_{E/K} y)` for `y ∈ I_E`, from I.1 item 5. In ideal
  language,
  `(𝔅, LE/E)∣_L = (N_{E/K} 𝔅, L/K)`. Because `𝔭` splits completely in `E`, a prime `𝔓 ∣ 𝔭` of `E`
  has `N_{E/K} 𝔓 = 𝔭`. So the symbol of `𝔭` in `L/K` is the symbol of `𝔓` in `LE/E`, and `LE/E` lies
  in a cyclotomic extension of `E`, where Stage 1 applies.
- **Where the norm index enters.** The crossing argument gives one containment, `ker θ_{L/K}|_{J^𝔪}
  ⊆ P_𝔪 · N_{L/K}(J_L^𝔪)`. Equality, which is the kernel form of the reciprocity law, holds because
  both subgroups have index `[L:K]` in `J^𝔪`. That is 5.2 and 5.3, and it is a hypothesis of the
  cyclic reciprocity theorem (Janusz V, Theorem 5.7, p. 195).

*Stage 3, general abelian `L/K`.* No further induction on the degree is needed. Write `Gal(L/K) = C₁
× ⋯ × C_s`, and put `E_j = L^{H_j}` with `H_j = ∏_{i ≠ j} C_i`. Each `E_j/K` is cyclic, and `L =
E₁⋯E_s`. An automorphism trivial on every `E_j` is trivial on `L`, so 6.1.8 carries the cyclic case
to `L`.
*Source.* Janusz V, Theorem 5.8, p. 197; Lang ANT Ch. X §§1–3.
*Prerequisites:* L 4.3, L 5.2, L 5.3, L 6.1, L 6.2, L I.1, M `Nat.exists_prime_gt_modEq_one`.

**6.4. The norm-residue isomorphism.** Prove that `θ_{L/K}` descends to `C_K ⧸ N_{L/K} C_L ≃*
Gal(L/K)` for finite abelian `L/K`. The two groups have the same finite order by 5.2 and 5.3, and
the map is surjective by 6.2. State the functoriality package: towers, base change along `K'/K`, and
compatibility with the transfer, which Layer 8 uses. **False generalization.** For nonabelian Galois
`L/K` the statement is `C_K/N C_L ≃ Gal(L/K)^{ab}`. It is not a corollary of the abelian case. It
needs norm limitation, so it is 7.2.
*Prerequisites:* L 6.3, L 5.2, L 5.3.

**6.5. Ramification and the conductor.** For finite abelian `L/K` and `v` a finite place or a real
place, prove that the following are equivalent: `v` is unramified in `L`; the local component of
`N_{L/K} C_L` contains the full local unit group at `v`, meaning all of `ℝˣ` at a real place; `v ∤
𝔣(L/K)`. Prove the local assembly `𝔣(L/K) = ∏_v 𝔣_v`, with the finite local conductors from I.1 item
7
and the real ones from 2C.7. Higher-ramification refinements are local and are not targets here;
only the assembly is global.
*Prerequisites:* L 6.4, L I.1, L 2C.7.

### Layer 7: norm groups, the existence theorem, and ray class fields

Every field in this layer and the next is an intermediate field of the fixed algebraic closure `K̄`.
Composita and intersections are taken inside `K̄`. Profinite identifications are
`ContinuousMulEquiv`s.

**7.1. The norm-group lattice.** For finite abelian `L/K` define `N(L/K) := (Kˣ · N_{L/K}(I_L))/Kˣ ≤
C_K`. Prove that `L ↦ N(L/K)` is inclusion-reversing and injective, that `N(LL') = N(L) ∩ N(L')`,
and that `N(L ∩ L') = N(L)·N(L')`. Together these are the Takagi correspondence between finite
abelian extensions and their norm groups.
*Source.* Milne CFT V §3; Neukirch ANT VI §6.
*Prerequisites:* L 6.4, L 2B.4.
**Basic API.**
- *Constructors:* `N(L/K)` from `L`; the extension from an open subgroup, by 7.3.
- *Examples:* `N(K/K) = C_K`; `N(ℚ(ζₙ)/ℚ) = RaySubgroup ((n),∞)`.
- *Morphisms:* the order-reversing bijection with finite abelian extensions.
- *Functoriality:* base change along `K'/K` sends `N(L/K)` to `N(LK'/K')` under the norm.
- *Comparison lemmas:* `N(L/K) ⊇ RaySubgroup 𝔣(L/K)`, which links the lattice to the conductor.
- *Naturality:* compatibility of composita and intersections, above.
- *Edge cases:* `L = K`; a subgroup that is of finite index but not open.
- *Downstream interface:* Layers 8, 9 and 10C.

**7.2. Norm limitation.** For an arbitrary finite extension `L/K` inside `K̄`, with `L^{ab}` the
maximal subextension abelian over `K`, prove `N_{L/K} C_L = N_{L^{ab}/K} C_{L^{ab}}`. Deduce `C_K /
N_{L/K} C_L ≃* Gal(L/K)^{ab}` for finite Galois `L/K`, by applying 6.4 to `L^{ab}/K`.
*Source.* Milne CFT Ch. VIII; Artin–Tate Ch. XI.
*Prerequisites:* L 6.4, L 2B.5.

**7.3. The existence theorem.** Prove that every open subgroup of finite index in `C_K` is `N(L/K)`
for a unique finite abelian `L/K`. Decompose the proof.
1. Upward closure: a subgroup `V` of `C_K` that contains a norm group `N(L/K)` is itself a norm
   group, namely `N(M/K)` for `M` the fixed field of `θ_{L/K}(V)`. This follows from 6.4 and the
   Galois correspondence. Every later step therefore has only to produce some norm group inside the
   given `U`.
2. Reduce to subgroups that contain some `RaySubgroup 𝔪`, by 2A.8.
3. The Kummer construction when `μ_p ⊆ K`. Take `S ⊇ S_∞` finite, containing the places above `p`
   and enough places that `I_K = Kˣ · I_{K,S}`. Write `𝓞_{K,S}ˣ` for the `S`-units, which is
   Mathlib's `Set.unit` for the finite places of `S`. Put
   `L := K((𝓞_{K,S}ˣ)^{1/p})`, the extension generated by the `p`-th roots of every `S`-unit, and
   `E := ∏_{v ∈ S} (K_vˣ)^p × ∏_{v ∉ S} 𝒪_vˣ ≤ I_K`. The construction does not depend on the
   subgroup that the theorem must realize; item 1 does the selection, in substep 5 below. Prove:
   1. `L/K` is abelian of exponent `p`, and `[L : K] = (𝓞_{K,S}ˣ · (Kˣ)^p : (Kˣ)^p) = p^{#S}` by
      Kummer theory and the `S`-unit theorem, where `#S = #S_L` is the number of places in `S`;
   2. `E ⊆ N_{L/K}(I_L)`, from local reciprocity at the places of `S`, where the local extension
      has exponent `p` so that `p`-th powers are norms, and from unramifiedness outside `S`, where
      the local units are norms;
   3. `[I_K : Kˣ·E] = p^{#S}`, from the `S`-unit theorem and the product formula;
   4. hence `[I_K : Kˣ·E] = [I_K : Kˣ·N_{L/K}(I_L)]` and `Kˣ·E = Kˣ·N_{L/K}(I_L)`, so the norm
      group of `L/K` is exactly the image of `E` in `C_K`;
   5. the selection: let `V ≤ C_K` be open with `C_K/V` finite of exponent `p`, and let `Ṽ ≤ I_K`
      be its preimage. Then `Ṽ ⊇ (I_K)^p`, and `Ṽ` contains `𝒪_vˣ` for every `v` outside a finite
      set, so after enlarging `S` we get `Ṽ ⊇ E`. Therefore `N(L/K) ⊆ V`, and item 1 makes `V` a
      norm group.
4. The cyclotomic base change when `μ_p ⊄ K`: work over `K_cyc := K(μ_p)`, whose degree over `K`
   divides `p − 1` and is prime to `p`.
5. The descent step: let `U ≤ C_K` be open of finite index and `F/K` finite, and suppose that
   `U' := N_{F/K}^{-1}(U) ≤ C_F` is a norm group, say `U' = N(M'/F)` for a finite abelian `M'/F`.
   Let `M` be the largest subextension of `M'/K` that is abelian over `K`. Then norm limitation
   gives `N_{M/K} C_M = N_{M'/K} C_{M'} = N_{F/K}(U') ⊆ U`, and item 1 makes `U` itself a norm
   group. Three points matter. `M'/K` is in general neither abelian nor Galois, so the descended
   field is `M` and not `M'`. The step needs the equality of norm groups, which is 7.2; the
   containment `N_{M'/K}C_{M'} ⊆ N_{M/K}C_M` is free from `M ⊆ M'` and is not enough. The
   ramification descends. `M ⊆ M'`, and `M'/K` is ramified only at two kinds of place: the
   places ramified in `F/K`; and the places under the support of `𝔣(M'/F)`. That bounds `𝔣(M/K)`.
   For `F = K_cyc` the first kind divides `p` or is infinite.
6. The induction, on the index `(C_K : U)`. Take a prime `p` dividing it. Apply item 5 with
   `F = K_cyc`, which reduces the problem to a base field that contains `μ_p`; rename that base
   `K` for the rest of the step. Choose `U ≤ U₁ ≤ C_K` with `[C_K : U₁] = p`. Item 3 gives a
   cyclic extension `K₁/K` of degree `p` with `N(K₁/K) = U₁`. Put `U' := N_{K₁/K}^{-1}(U) ≤ C_{K₁}`.
   The map `N_{K₁/K} : C_{K₁} → C_K/U` has image `U₁/U`, which has index `p`, and kernel `U'`, so
   `(C_{K₁} : U') = (C_K : U)/p`. Apply the induction hypothesis over `K₁`, then item 5 with
   `F = K₁` to recover `U` as a norm group over `K`. **Common error.** `K_cyc` and `K₁` are
   different fields. The first has degree dividing `p − 1` over `K`, and the second has degree
   `p`.
7. Compositum and intersection compatibility, so that the extensions built for the factors assemble.
8. Control of the ramification and of the conductor of the extension produced.
9. Uniqueness, from 6.4 and the injectivity in 7.1. **False generalization, with the reason.**
   Openness is not automatic from finite index. `D_K` is divisible, so it lies in every finite-index
   subgroup, and `π₀(C_K) ≅ Gal(K^{ab}/K)` is not topologically finitely generated. With the axiom
   of choice it therefore has dense subgroups of finite index, and these pull back to finite-index
   subgroups of `C_K` that are not open. The openness hypothesis does real work.
*Source.* Milne CFT VII §9, items 9.1 to 9.5; Neukirch ANT VI §6; Janusz V §§7–9. Tate's article in
Cassels–Fröhlich, p. 202, gives the route that avoids norm limitation.
*Prerequisites:* L 6.4, L 7.1, L 7.2, L 2A.8, L 5.1, L 5.3, L I.1, M `Set.unit`,
M `Mathlib/FieldTheory/KummerExtension.lean`.

**7.4. Ray class fields.** Define `K_𝔪` as the abelian extension inside `K̄` with `N(K_𝔪/K) =
RaySubgroup 𝔪`. It exists by 7.3 and is unique by 7.1. Prove `Gal(K_𝔪/K) ≃* Cl_𝔪 K`, by composing
with 2A.7. Prove that the ramification support is inside the support of `𝔪`. Prove the splitting
law: for `𝔭 ∤ 𝔪₀`, the Frobenius at `𝔭` corresponds to the class `[𝔭]`, so `𝔭` splits completely in
`K_𝔪` exactly when `𝔭 ∈ P_𝔪`. Prove that the transition maps `K_𝔪 ⊆ K_𝔫` for `𝔪 ∣ 𝔫` correspond to
the surjections `Cl_𝔫 ↠ Cl_𝔪` of 1.4.
*Source.* Janusz V §6; Milne CFT V §3.
*Prerequisites:* L 7.3, L 2A.7, L 6.4, L 1.4.
**Basic API.**
- *Constructors:* `K_𝔪` from `𝔪`; `H = K_{((1),∅)}`; `H⁺` from the narrow modulus.
- *Examples:* `ℚ_{(n)∞} = ℚ(ζₙ)`; `H` of `ℚ(√−5)`; the ring class field of 10C.1.
- *Morphisms:* `Gal(K_𝔪/K) ≃* Cl_𝔪 K`; the inclusions `K_𝔪 ⊆ K_𝔫` for `𝔪 ∣ 𝔫`.
- *Functoriality:* the inclusions match the surjections `Cl_𝔫 ↠ Cl_𝔪` of 1.4.
- *Comparison lemmas:* the splitting law; the conductor bound of 6.5.
- *Naturality:* the Frobenius at `𝔭` corresponds to the class `[𝔭]` for every admissible `𝔪`.
- *Edge cases:* `𝔪 = ((1), ∅)`, which gives `H`; class number one, where `H = K`.
- *Downstream interface:* Layers 8, 9 and 10C.

**7.5. The ideal-theoretic dictionary.** Let `L/K` be finite abelian of conductor dividing `𝔪`.
Take `artinHomAway (support 𝔪₀) hur` of I.2, where `hur` holds because `𝔣(L/K) ∣ 𝔪`. Prove that
this map is surjective onto `Gal(L/K)`, with kernel `P_𝔪 · N_{L/K}(J_L^𝔪)`. Prove that it agrees
with the idelic map under 2A.7. This is Takagi's classification in ideal terms, and quadratic genus
theory uses this form.
*Prerequisites:* L I.2, L 6.4, L 2A.7, L 7.4.

**7.6. The profinite Artin map.** Prove `K^{ab} = ⨆_𝔪 K_𝔪` inside `K̄`. Prove `Gal(K^{ab}/K) ≃ lim_𝔪
Cl_𝔪 ≃ C_K/D_K` as topological groups, so that `Art_K : C_K → Gal(K^{ab}/K)` is continuous and
surjective with kernel `D_K`. State the compatibility of the limit with the transition maps of 1.4
and 2A.7, and give the identification as a `ContinuousMulEquiv`.
*Source.* Neukirch ANT VI §6; Milne CFT V §5.
*Prerequisites:* L 7.4, L 2A.8, M `Field.absoluteGaloisGroup`, M `IsGaloisGroup`.

**7.7. The instance over `ℚ`.** Prove that the ray class field of `ℚ` for the modulus `(n)·∞` is
`ℚ(ζₙ)`. One containment holds because 4.3 exhibits the norm group of `ℚ(ζₙ)` as containing
`RaySubgroup ((n),∞)`. Equality follows from the degree count `#Cl_{(n)∞}(ℚ) = φ(n) = [ℚ(ζₙ) : ℚ]`.
Deduce `Gal(ℚ^{ab}/ℚ) ≅ lim_n (ℤ/n)ˣ = Ẑˣ` as topological groups.
*Prerequisites:* L 4.3, L 7.4, L 7.6.
### Layer 8: the Hilbert class field and the principal ideal theorem

**8.1. The Hilbert class field.** Define `H := K_{((1),∅)}`. Prove `Gal(H/K) ≃* ClassGroup (𝓞 K)`.
Prove that `H/K` is unramified at every place: `Algebra.Unramified (𝓞 K) (𝓞 H)` at the finite places
and `IsUnramifiedAtInfinitePlaces K H` at the real places. Prove maximality in this exact form:
every finite abelian extension of `K` inside `K̄` that is unramified at all places, finite and
infinite, is contained in `H`. Prove that a prime `𝔭` splits completely in `H` exactly when it is
principal, and that `H = K` exactly when `h_K = 1`. Write "maximal finite abelian unramified
everywhere" and not "maximal such". The class group is finite, so `H` is in fact the largest
unramified abelian extension; but the theorem to state is the containment, and an unbound "such" is
what makes the narrow variant confusing.
*Source.* Janusz V §12; Milne CFT V §3, Example 3.9.
*Prerequisites:* L 7.4, L 6.5, M `Algebra.Unramified`, M `IsUnramifiedAtInfinitePlaces`.
**Basic API.**
- *Constructors:* `H` from `K`.
- *Examples:* `H = ℚ` for `K = ℚ`; `H = ℚ(√−5, i)` for `K = ℚ(√−5)`; `H` of degree 8 for `K =
  ℚ(√−14)`.
- *Morphisms:* `Gal(H/K) ≃* ClassGroup (𝓞 K)`; the inclusion `H ⊆ K_𝔪` for every `𝔪`.
- *Functoriality:* `H_K ⊆ H_L` for `K ⊆ L`, with the capitulation map of 8.3.
- *Comparison lemmas:* `H` against `H⁺` of 8.2, and `H` against the genus field.
- *Naturality:* the splitting law commutes with the isomorphism to the class group.
- *Edge cases:* `h_K = 1`; a field with no real place, where `H = H⁺`.
- *Downstream interface:* Layer 10C and the merged Multiquadratic roadmap.

**8.2. The narrow Hilbert class field.** Define `H⁺ := K_{((1), all real places)}`. Prove `Gal(H⁺/K)
≅ Cl⁺ K`, and that `H⁺` is the maximal finite abelian extension unramified at all finite places,
with no condition at the infinite places. Prove the genus-field compatibility: for quadratic `K/ℚ`,
the genus field is the maximal subfield of `H`, respectively of `H⁺`, that is abelian over `ℚ`, and
`Gal(H/K) ↠ Gal(K_gen/K)` realizes `Cl ↠ Cl/Cl²`. State it in the vocabulary of the merged
Multiquadratic roadmap, which is merged.
*Prerequisites:* L 8.1, L 1.8, T Multiquadratic Layer 3, namely the genus field `K_gen` and
`Gal(K_gen/K) ≅ Cl(K)/Cl(K)²`, as named in the contract table.

**8.3. Capitulation and the principal ideal theorem.** The extension map is Mathlib's
`ClassGroup.extendedHom`. Prove `ClassGroup.extendedHom (𝓞 K) (𝓞 H) = 1`, that is, every ideal of
`K` becomes principal in `H`. Use four targets, and do not inline any of them.
1. `H'`, the Hilbert class field of `H`, is Galois over `K`, because the construction is canonical
   and the `K`-conjugates of `H'` agree.
2. With `G = Gal(H'/K)`, the subgroup `Gal(H'/H)` is the commutator subgroup `[G, G]`, from
   `Gal(H/K)` abelian and the maximality in 8.1.
3. Under the isomorphisms of 6.4, the extension-of-ideals map corresponds to the group-theoretic
   transfer `G^{ab} → Gal(H'/H)^{ab}`.
4. Furtwängler's theorem: for a finite group `G`, the transfer `G^{ab} → ([G,G])^{ab}` is trivial.
   This is group theory, it is reusable, and it belongs in a group-theory file. `H'/K` is Galois but
   usually not abelian, so the argument lives in `Gal(H'/K)`. Set the two-step tower up carefully.
   **False generalization.** Total capitulation in `H` does not continue up the tower. The class
   field tower need not terminate, which is the Golod–Shafarevich theorem, and no statement here
   should suggest that it does.
*Source.* Artin–Tate Ch. XIII; Neukirch ANT VI §7.
*Prerequisites:* L 8.1, L 6.4, M `ClassGroup.extendedHom`, M `MonoidHom.transfer`.

### Layer 9: Kronecker–Weber and the conductor–discriminant formula

**9.1. Kronecker–Weber.** Prove that every finite abelian `L/ℚ` embeds in some `ℚ(ζₙ)`. It follows
from 7.7: the conductor of `L/ℚ` divides `(n)·∞` for some `n`, so `L ⊆ ℚ_{(n)∞} = ℚ(ζₙ)`. State the
two usual forms, the embedding form and the range form. State the sharp version: the least such `n`
is the finite part of the conductor of `L/ℚ`, normalized as in 4.2, so the least `n` is never `≡ 2
(mod 4)`. The route through Layers 6 and 7 is shorter than the elementary route through local
Kronecker–Weber and ramification bounds. Do not build the elementary route as a prerequisite.
**False generalization, with a counterexample.** The theorem is about `ℚ`. Over a general base
field, abelian extensions are not contained in cyclotomic extensions of the base. Take `K = ℚ(√−3)`.
The field `K(∛2)` is abelian over `K`: it is a Kummer extension of degree 3, because `K` contains
`ζ₃`. It is the ring class field of the order of conductor 6, as 10C.2 records.
It is not contained in any `K(ζ_n)`: each `K(ζ_n)` is abelian over `ℚ`, and `ℚ(√−3, ∛2)/ℚ` has
Galois group `S₃`.
*Prerequisites:* L 7.7, L 4.2, L 6.5.

**9.2. The abelian conductor–discriminant formula.** For finite abelian `L/K`, prove `d_{L/K} = ∏_χ
𝔣₀(χ)`. Here `χ` ranges over the characters of `Gal(L/K)`. The term `𝔣₀(χ)` is the finite part of
the conductor of the ray class character `χ ∘ θ_{L/K}`, through 3.3. Route: localize, using that the
different is the product of the local differents, then apply the local conductor–discriminant
formula I.6. Prove the globalization of the different as part of this milestone, from
`differentIdeal` and its multiplicativity in towers. Worked instance: over `ℚ` the formula
reproduces Mathlib's values for `disc(ℚ(ζₙ))`. **False generalization.** The formula as stated is
abelian. For a nonabelian extension the correct statement uses Artin conductors of the irreducible
characters, which needs Artin `L`-functions and is not a target here. State the abelian scope in the
statement.
*Source.* Serre, *Corps Locaux*, Ch. VI §3, for the local formula; Neukirch ANT VII §11.
*Prerequisites:* L 3.3, L 6.4, L 7.4, L I.1, M `differentIdeal`,
M `Mathlib/NumberTheory/Cyclotomic/Discriminant.lean`.

### Layer 10A: continuous and algebraic infinity types

**10A.1. Continuous characters of the archimedean groups.** Prove that every continuous homomorphism
`ℝˣ → ℂˣ` is `x ↦ |x|^s · sgn(x)^ε` for a unique `s ∈ ℂ` and a unique parity `ε`. Prove that every
continuous homomorphism `ℂˣ → ℂˣ` is `z ↦ (z/|z|)^k · |z|^s` for a unique `k ∈ ℤ` and a unique `s ∈
ℂ`. Prove the translation to `z ↦ z^p z̄^q` with `p − q ∈ ℤ`, where `k = p − q` and `s = p + q`.
Mathlib has neither classification, and both are reusable. Type the parity as `ZMod 2`. A `ℕ`-valued
exponent cannot carry a uniqueness statement, because only the parity is determined.
*Prerequisites:* M `ContinuousMonoidHom`, M `Complex.exp`, M `Real.log`.

**10A.2. The infinity type of a Hecke character.** Define `χ_∞ = ∏_{w ∣ ∞} χ_w`, the restriction of
`χ` to the archimedean part of the ideles, with each `χ_w` classified by 10A.1.
*Prerequisites:* L 3.4, L 10A.1.

**10A.3. Algebraic characters.** Define: `χ` is algebraic when `χ_∞` is the restriction of an
algebraic character of the torus. That is, there are integers `n_σ`, one for each embedding `σ : K →
ℂ`, with `χ_∞(x) = ∏_σ σ(x)^{n_σ}` on the identity component. At a real embedding this is `x ↦
x^{n_σ}`. At a complex place, with `σ` and `σ̄` the two conjugate embeddings, it is `z ↦ z^{n_σ}
z̄^{n_{σ̄}}`. In the coordinates of 10A.1 the radial exponent is then `s = n_σ + n_{σ̄}`. State four
further items.
1. The relation between the exponents at conjugate embeddings and the weight.
2. The condition `∏_σ σ(u)^{n_σ} = 1` for units `u` in a finite-index subgroup of `𝓞_Kˣ`. That
   condition is what allows the infinity type to occur at all, and it forces `n_σ` to be constant
   unless `K` contains a CM subfield.
3. The pure case, where `n_σ + n_{σ̄}` is a constant weight.
4. The norm twists `χ · ‖·‖^m`, which are algebraic whenever `χ` is.

**Common error.** "All radial exponents are zero, with integer exponents" is not the algebraicity
condition. That definition excludes the algebraic norm twists, because `s = n_σ + n_{σ̄}` is not
zero in general.
*Prerequisites:* L 10A.2, M `NumberField.Units`, M `NumberField.CMField`.
**Basic API.**
- *Constructors:* the infinity type from the exponents `n_σ`; the norm twist `χ · ‖·‖^m`.
- *Examples:* `‖·‖`; a finite-order character, where every `n_σ` is zero; a CM character of an
  imaginary quadratic field.
- *Morphisms:* the map from algebraic characters to exponent vectors; the ideal-side character
  of 10A.4.
- *Functoriality:* base change along a finite extension multiplies the exponents by the local
  degrees.
- *Comparison lemmas:* the two coordinate systems of 10A.1; the weight against the radial
  exponents.
- *Naturality:* the exponents at conjugate embeddings under complex conjugation.
- *Edge cases:* a totally real field, where the unit condition forces constant exponents; a
  field with no CM subfield.
- *Downstream interface:* the complex multiplication material that consumes 10A.3 and 10C.1.

**10A.4. The associated ideal-side character.** For an algebraic `χ` of conductor `𝔣`, define the
induced character on ideals prime to `𝔣`. Prove that it takes values in a number field, namely the
field generated by its values. Prove multiplicativity. **Common error.** The field-of-values
statement belongs to the ideal-side character. The idelic character takes transcendental values on
archimedean elements in general.
*Prerequisites:* L 10A.3, L 7.5.

### Layer 10B: orders and their Picard groups

Mathlib has no theory of nonmaximal orders in a number field. The Dedekind-generic machinery of
Layers 0 and 1 does not apply to them, because an order is usually not integrally closed.

**10B.1. Orders.** Define an order `O ⊆ 𝓞 K` as a subring that is free of rank `[K:ℚ]` over `ℤ` and
has `K` as its field of fractions. Give the equivalent description as a full-rank subring, in the
vocabulary of `Module.Finite` and `IsFractionRing`. Give the basic examples, including `ℤ[√−n]` and
`ℤ + f𝓞_K`.
*Prerequisites:* M `Module.Finite`, M `IsFractionRing`, M `NumberField.RingOfIntegers`.

**10B.2. The conductor.** Define `𝔠(O) = {x ∈ K | x 𝓞_K ⊆ O}`, and prove that it is the largest
`𝓞_K`-ideal contained in `O`. Prove the annihilator characterization, and the index formula `disc O
= [𝓞_K : O]² disc 𝓞_K`.
*Source.* Cox, *Primes of the Form x² + ny²*, §7.
*Prerequisites:* L 10B.1, M `Algebra.discr`.

**10B.3. Proper fractional ideals.** Define a proper fractional `O`-ideal as an `I` with `{x ∈ K |
xI ⊆ I} = O`. Prove the equivalence with invertibility, and that they form a group.
*Prerequisites:* L 10B.1.

**10B.4. The Picard group.** Identify Mathlib's generic `ClassGroup O` with the group of 10B.3
modulo principal ideals. If the generic definition does not agree, say which object is the target
and prove the comparison.
*Prerequisites:* L 10B.3, M `ClassGroup`.
**Basic API.**
- *Constructors:* the class of a proper fractional `O`-ideal; the class of an ideal prime to
  `𝔠(O)`.
- *Examples:* `Pic 𝓞_K = ClassGroup (𝓞 K)`; `Pic (ℤ + 6𝓞_{ℚ(√−3)}) ≅ ℤ/3`.
- *Morphisms:* the extension and contraction maps of 10B.5; the surjection `Pic O ↠ Pic 𝓞_K`.
- *Functoriality:* `O ⊆ O'` gives `Pic O ↠ Pic O'`.
- *Comparison lemmas:* 10B.6 against the ray class quotient; 10B.8 against Layer 1.
- *Naturality:* extension and contraction commute with the class maps.
- *Edge cases:* `O = 𝓞_K`; a conductor divisible by a ramified prime.
- *Downstream interface:* Layer 10C.

**10B.5. Extension and contraction.** Prove that extension and contraction are mutually inverse
multiplicative bijections between proper `O`-ideals prime to `𝔠(O)` and `𝓞_K`-ideals prime to
`𝔠(O)`.
*Prerequisites:* L 10B.2, L 10B.3.

**10B.6. The congruence description.** Prove `Pic O ≅ J^{𝔠}(𝓞_K) / P_{ℤ,𝔠}`, where `P_{ℤ,𝔠}` is the
group of principal ideals `(α)` with `α ≡ a (mod 𝔠 𝓞_K)` for some rational integer `a` prime to `𝔠`.
This is what makes `Pic O` a ray-class-style quotient, and it is the reason Layer 7 can produce a
class field for it.
*Prerequisites:* L 10B.5, L 1.1.

**10B.7. Finiteness.** Prove that `Pic O` is finite, with the classical index formula in terms of
`h_K`, the conductor and the unit index.
*Prerequisites:* L 10B.6, L 1.6.

**10B.8. Specialization.** Prove that for `O = 𝓞_K` everything above reduces to Layer 1, and that
the class field of 10C.1 reduces to the Hilbert class field.
*Prerequisites:* L 10B.7, L 8.1.

### Layer 10C: ring class fields and representation by quadratic forms

**10C.1. Ring class fields.** Let `O` be an order in `K` with conductor `𝔠`. Define the ring class
field `H_O` as the abelian extension of `K` inside `K̄` that corresponds to the congruence subgroup
of 10B.6, through 7.3. Prove three statements: `Gal(H_O/K) ≅ Pic O`; the ramification divides `𝔠`;
and `H_{𝓞_K} = H`. The definitions are for all `K`. The worked examples are imaginary quadratic.
*Prerequisites:* L 10B.6, L 7.3, L 7.4.

**10C.2. The `x² + ny²` theorem.** Fix `n ≥ 1` and write `n = f²d` with `d > 0` squarefree. Then `K
= ℚ(√−n) = ℚ(√−d)`, and `O_n = ℤ[√−n] = ℤ[f√−d]` is the order of discriminant `disc(O_n) = −4n`. The
field discriminant and the conductor depend on `d` alone:
- if `d ≡ 3 (mod 4)`, then `d_K = −d` and `𝔠(O_n) = 2f`;
- otherwise `d_K = −4d` and `𝔠(O_n) = f`. Both cases follow from `disc(O_n) = 𝔠(O_n)² d_K`. So `O_n`
  is the maximal order exactly when `f = 1` and `d ≢ 3 (mod 4)`. For a prime `p ∤ 2n`, prove the
  chain, where each link is a milestone:
1. `p = x² + ny²` for integers `x, y`;
2. exactly when there is a proper `O_n`-ideal of norm `p`, equivalently `p` is represented by the
   principal form of discriminant `−4n`;
3. exactly when some prime of `O_n` above `p` is principal, that is trivial in `Pic O_n`;
4. exactly when `p` splits completely in `H_{O_n}` **as an extension of `ℚ`**. For `p ∤ 2n` that
   means `p` splits in `K/ℚ` and the primes above it split completely in `H_{O_n}/K`. Prove that
   equivalence, and do not leave the base field ambiguous. The last step is the splitting law 7.4
   applied to the ring class field. The hypothesis `p ∤ 2n` is what makes `p` prime to the conductor
   and unramified in `K`, because the conductor divides `2n`. That is what 10B.5 needs. **Common
   error, with a counterexample.** The criterion "`ℤ[√−n]` is maximal exactly when `−n ≢ 1 (mod 4)`"
   holds for squarefree `n` only. For `n = 12` the congruence holds, and `ℤ[√−12]` is not maximal in
   `ℚ(√−3)`; its conductor is 4.
*Source.* Cox, *Primes of the Form x² + ny²*, §§7–9.

*Prerequisites:* L 10B.2, L 10B.5, L 10B.6, L 10C.1, L 7.4.

**Scope note, on the absence of congruence criteria.** No congruence condition on `p` alone decides
`p = x² + 14y²`. That is a statement about the distribution of Frobenius elements and needs
Chebotarev, which is analytic. Keep it as explanatory prose here. Do not list it as a deliverable of
this roadmap.

### Layer 11: the global class formation and the local-global compatibilities

**11.1. The formation.** Prove that `(Gal(K̄/K), colim_L C_L)` is a class formation: `H¹ = 1` from
5.4; `H²(Gal(L/K), C_L)` cyclic of order `[L:K]` with compatible invariant maps `inv_{L/K} :
H²(Gal(L/K), C_L) ≃ (1/[L:K])ℤ/ℤ`; and a fundamental class `u_{L/K}` with `inv(u_{L/K}) = 1/[L:K]`,
constructed from the cyclic cyclotomic case by inflation. Package it in the shape of the conventions
table. Prove that Tate–Nakayama in degree `−2` re-derives the isomorphism of 6.4, and prove the
compatibility theorem: the two constructions agree. That compatibility is the content of "the
cohomological route", given the route pinned above.
*Source.* NSW Ch. VIII; Artin–Tate Ch. XIV.
*Prerequisites:* L T.6, L 5.4, L 6.4, L 2C.6, M
`Mathlib/RepresentationTheory/Homological/GroupCohomology/FiniteCyclic.lean`, M
`groupCohomology.Functoriality`.

**11.2. Continuous cohomology of the absolute Galois group.** State the continuous cohomology of
`Gal(K̄/K)` with coefficients in a discrete module, as the colimit over the finite quotients. Prove
that the colimit description agrees with the cochain description for a discrete module. This is the
only place where profinite cohomology is used, and it is stated here so that Layer 11 has no
external dependency.
*Source.* NSW Ch. I §2; Serre, *Galois Cohomology*, Ch. I.
*Prerequisites:* M `Mathlib/RepresentationTheory/Homological/GroupCohomology/`,
M `Field.absoluteGaloisGroup`, M `Mathlib/Topology/Algebra/Category/ProfiniteGrp/`.

**11.3. Sum of local invariants.** Prove the exact sequence `0 → H²(G_K, K̄ˣ) → ⊕_v H²(G_{K_v},
K̄_vˣ) → ℚ/ℤ → 0` in invariant-map coordinates. The local invariants come from I.1 item 9 at the
finite places, and from 2C.6 at the infinite places. Prove the reciprocity statement `∑_v inv_v(α) =
0` for
a global class.
*Prerequisites:* L 11.1, L 11.2, L I.1, L 2C.6.

**11.4. Hilbert reciprocity.** Prove `∏_v (a, b)_v = 1` for `a, b ∈ Kˣ`, with the local symbols from
I.1 item 11 at the finite places and from 2C.8 at the real places. Derive quadratic reciprocity over
`ℚ`
as the worked example, and compare with Mathlib's `legendreSym` reciprocity.
*Prerequisites:* L 11.3, L I.1, L 2C.8, M `legendreSym`.

**Scope note.** Everything in this layer is stated in Galois cohomology. The translation to central
simple algebras, division algebras and a Brauer-group API is out of scope. This layer supplies the
`H²` half of the statement "division algebras over `K` correspond to local invariants that sum to
zero", and no algebras. Cohomological dimension and `H³` of number fields are also out of scope, and
belong to a Poitou–Tate development.

## Worked examples

Discharge these alongside the layers. Each one catches a specific failure: a vacuous object, a wrong
normalization, a dropped real place, or a unit-obstruction error.

**W1. `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`, with Dirichlet characters** (Layers 1, 3, 4). Prove the ray class
computation, the contrast `Cl_{(n)}(ℚ) ≃* (ℤ/n)ˣ/{±1}`, and the induced equivalence between
finite-order Hecke characters with `U_{(n)∞} ⊆ ker χ` and `DirichletCharacter ℂ n`, compatible with
conductors.

**W2. Parity, and the character that does not exist** (Layer 3). `Cl_{((1),∞)}(ℚ) = 1`, so `ℚ` has
no nontrivial Hecke character whose ray conductor is the infinite place alone. The smallest odd
example is `ZMod.χ₄`: finite conductor `4`, ray conductor `(4)·∞`, `χ(−1) = −1`, and the real sign
component nontrivial for that reason.

**W3. Sign surjectivity, and its failure for units** (Layers 0, 1). `ℚ(√3)` has `h = 1` and `Cl⁺ ≅
ℤ/2`. Its fundamental unit `2 + √3` is totally positive, so the sign map on units is not surjective,
while the sign map on `Kˣ` is surjective by 0.3. By contrast `ℚ(√2)` has `Cl⁺ = Cl = 1`, because the
unit `1 + √2` has norm `−1`. These two fields are the smallest discriminating pair for a
narrow-class implementation.

**W4. Splitting and ramification in `ℚ(ζₙ)`** (Layer 4). For `p ∤ n`, `p` splits completely exactly
when `p ≡ 1 (mod n)`; the Frobenius at `p` is `[p]`; and `[ℚ(ζₙ):ℚ] = φ(n)`. State ramification
through the normalized level `n₀`. Include `n = 6` as the instance that refutes "ramified exactly at
the primes dividing `n`".

**W5. A norm index and the Hasse norm theorem** (Layer 5). `[C_ℚ : N C_{ℚ(√5)}] = 2`, and a rational
is a norm from `ℚ(√5)` exactly when it is a local norm at every place.

**W6. Failure of the norm principle for a biquadratic field** (Layers 5 and 11). For `L = ℚ(√13,
√17)`, the rational `25` is a local norm at every place and is not a norm from `L`. The knot group
of `L/ℚ` has order `2`. The local half needs its true reason. A square is not a norm from an
arbitrary degree-four local extension. Here every decomposition group of `L/ℚ` is a proper, hence
cyclic, subgroup of `(ℤ/2)²`: the ramified primes `13` and `17` are each a square modulo the other,
so both have residue degree `1`; the unramified decomposition groups are cyclic of order at most
`2`; and the unique real place of `ℚ` splits completely into four real places of `L`, because `L`
is totally real. Every local degree `[L_w : ℚ_v]` is therefore at most `2`. For
`a ∈ ℚˣ` the norm from a local extension of degree at most `2` is `a` or `a²`. Every rational
square is therefore a local norm everywhere in this extension. The example is sharper than it looks:
`4` and `9` are global norms from `L`, so being a square is not the point, and `5` itself is not
even a local norm at `5`.
*Source.* Cassels–Fröhlich Exercise 5.3, p. 360, quoted in Milne CFT VIII §3.

**W7. The Hilbert class field of `ℚ(√−5)`** (Layers 8, 10C). `h = 2` and `H = ℚ(√−5, i)`, which is
also the genus field. The acceptance statement is the class-field one: for `p ≠ 2, 5`, `p` splits
completely in `H` exactly when `p = x² + 5y²`, exactly when `p ≡ 1, 9 (mod 20)`. The congruence
equivalence alone is elementary and does not test this roadmap.

**W8. Kronecker–Weber in its smallest instances** (Layer 9). Every abelian `L/ℚ` lies in some
`ℚ(ζₙ)`. Sharply: `ℚ(i) ⊆ ℚ(ζ₄)`, `ℚ(√2) ⊆ ℚ(ζ₈)`, `ℚ(√5) ⊆ ℚ(ζ₅)`, with least levels `4`, `8` and
`5`.

**W9. The conductor of `ℚ(√d)`** (Layers 7, 9). It is `(|d_K|)` for `d > 0` and `(|d_K|)·∞` for `d <
0`, where `d_K = disc(ℚ(√d))`. The real place ramifies exactly when `d < 0`, because complex
conjugation is then the nontrivial automorphism. An implementation that gives `∞ ∤ 𝔣` for `ℚ(i)` has
the real-place convention backwards. Conductor–discriminant here reads `|d_K| = 𝔣₀(χ_d)`.

**W10. Hilbert reciprocity implies quadratic reciprocity** (Layer 11). Unpack `∏_v (p, q)_v = 1` at
odd primes `p ≠ q` to get `legendreSym p q * legendreSym q p = (−1)^{(p−1)(q−1)/4}`, with `(−1,−1)_2
= −1` closing the case `v = 2` and 2C.8 closing `v = ∞`. Mathlib already proves quadratic
reciprocity. Deriving it again through the whole stack is the end-to-end check.

**W11. `x² + 14y²` and `x² + 27y²`** (Layers 10B, 10C). For `n = 14`, `ℤ[√−14]` is the maximal
order, `h = 4`, and `p = x² + 14y²` exactly when `p` splits completely in `H = ℚ(√−14, α)`, where
`α⁴ + 2α² − 7 = 0` and `[H : ℚ] = 8`. For `n = 27`, write `27 = 3²·3`, so `f = 3` and `d = 3 ≡ 3
(mod 4)`, and 10C.2 gives conductor `2f = 6`. The order `ℤ[√−27] = ℤ + 6𝓞_K` in `ℚ(√−3)` has
discriminant `−108` and `Pic ≅ ℤ/3`. Its ring class field is `ℚ(√−3, ∛2)`, and the splitting law
there is Gauss's criterion: `p = x² + 27y²` exactly when `p ≡ 1 (mod 3)` and `2` is a cubic residue
modulo `p`. The second example is the one that exercises Layer 10B, because the order is not
maximal.

## Ordering and parallelism

The table is generated from the direct prerequisites of the milestones, and the milestone numbers
are a topological order of that graph.

Four lanes can run at once from the start.

- Lane A: Layers 0 and 1, moduli, approximation and ray classes.
- Lane B: Layer 2A, ideles.
- Lane C: Layer 2C, the archimedean package, which is small and is a good first contribution,
  together with Layer 4, the cyclotomic anchor.
- Lane D: Layer T, Tate cohomology, which is general-purpose and uses Mathlib alone.

Layer 8's Furtwängler theorem is free-standing group theory and can be developed at any time.

| stage | content | prerequisites |
|---|---|---|
| T | Tate cohomology in all degrees, functoriality, periodicity, cup products, Tate–Nakayama | Mathlib |
| I | the local package and its construction, the ideal-theoretic Artin map, the completion dictionary, the cyclotomic orientation, the local conductor–discriminant | Mathlib, T |
| 0 | moduli, approximation, congruence subgroups of `Kˣ` | Mathlib |
| 1 | ray and narrow class groups, moving lemma, exact sequence, finiteness | 0 |
| 2A | ideles, topology, discreteness, norm-one compactness, `U_𝔪`, `D_K` | Mathlib, 1 |
| 2B | base change, Galois action, extension maps, idele norms, `C_L^G ≃ C_K` | 2A, I |
| 2C | archimedean reciprocity, norm index, invariants, Hilbert symbols | Mathlib, T, I |
| 3 | Hecke characters, the two conductors, the Dirichlet dictionary | 1, 2A, 2C |
| 4 | the cyclotomic anchor and the cyclotomic conductor | 1, I |
| 5 | `S`-ideles, Herbrand computations, `kummer_le`, class field axiom, Hasse norm | T, I, 2B, 2C |
| 6 | the compiled global Artin map and the reciprocity law | I, 2C, 4, 5 |
| 7 | norm limitation, existence theorem, ray class fields, profinite Artin map | 5, 6 |
| 8 | Hilbert and narrow Hilbert class fields, principal ideal theorem | 7, transfer theory |
| 9 | Kronecker–Weber, abelian conductor–discriminant | I, 3, 6, 7 |
| 10A | continuous and algebraic infinity types | 3, 7 |
| 10B | orders, conductors, Picard groups | 1 |
| 10C | ring class fields, `x² + ny²` | 7, 10B |
| 11 | class formation, the `H²` sequence, Hilbert reciprocity | T, I, 2C, 5, 6, 7 |

Layer 6 is where the local package I.4 must exist. Everything before Layer 6 needs the statement
I.1 only. The worked examples are spread across the layers, and none waits until the end.

## References

- J. Neukirch, *Algebraic Number Theory* (Grundlehren 322). Ch. IV, abstract class field theory and
  the class field axiom, which is the skeleton of Layers 5 and 6. Ch. V, the local theory. Ch. VI:
  §1 ideles and idele classes for Layer 2A; §2 ideles in field extensions for Layer 2B; §3 the
  Herbrand quotient for 5.2; §4 the class field axiom for 5.3; §5 the global reciprocity law for
  Layer 6; §6 global class fields for Layer 7; §7 the ideal-theoretic version for 7.5; §8 power
  residues, which is horizon material.
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed. (GSM 7). Ch. III, decomposition groups and the
  Artin map. Ch. IV §1, moduli and ray classes, which gives the statement form of Layers 0 and 1.
  Ch. V, class field theory: §1 cyclic cohomology; §§2–4 the norm-index computations; §5 reciprocity
  and the crossing argument, with Lemmas 5.3, 5.4 and 5.6 and Theorems 5.7 and 5.8 used by 6.3; §6
  ideal groups, conductors and class fields; §§7–9 the existence theorem; §§10–11 consequences; §12
  the Hilbert class field. Ch. VI §1, the conductor of `ℚ(√d)`; §3, the narrow class group.
- S. Lang, *Algebraic Number Theory*, 2nd ed. (GTM 110). Ch. VII, ideles and adeles. Ch. IX,
  norm-index computations. Ch. X, the Artin symbol, reciprocity and the crossing argument, with
  Artin's lemma on p. 202. Ch. XI, the existence theorem.
- J. S. Milne, *Class Field Theory* (course notes). Ch. V, global statements. Ch. VII, proofs: §§2–5
  idele cohomology and the inequalities; §6 the algebraic proof of the upper bound used in 5.3; §9
  the existence theorem, items 9.1 to 9.5, used in 7.3. Ch. VIII, complements: §§1–2 Grunwald–Wang;
  §3 the Hasse norm principle and the biquadratic counterexample; §4 the fundamental exact sequence,
  which is 11.3.
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed. Ch. VIII, the global
  formation and the `H²` invariants, which is the normalization source for Layer 11.
- Cassels–Fröhlich (eds.), *Algebraic Number Theory*. Ch. II for adeles, approximation and
  compactness, used by Layers 0 and 2A. Ch. VII, Tate, "Global class field theory", the idelic
  statements that Layers 2, 6 and 7 are checked against. Exercise 5.3, p. 360, the biquadratic
  Hasse-norm counterexample. Tate's article p. 202 for the existence theorem without norm
  limitation.
- D. A. Cox, *Primes of the Form x² + ny²*, 2nd ed. §§5–6, the Hilbert class field and genus theory.
  §§7–9, orders, ring class fields and `x² + ny²`, which is the programme of Layer 10.
- L. C. Washington, *Introduction to Cyclotomic Fields*, 2nd ed. (GTM 83). Ch. 3–4, cyclotomic
  discriminants and conductor–discriminant over `ℚ`.
- E. Artin, J. Tate, *Class Field Theory*. The crossing argument in its original arrangement, the
  group-theoretic principal ideal theorem, and the class-formation axiomatics of Layer 11.
- J.-P. Serre, *Corps Locaux*, Ch. VI §3, the local conductor–discriminant formula that 9.2
  globalizes; Ch. XIII and XIV, local class field theory, which is the source for I.4.
- Weil, *Basic Number Theory*, Ch. IV, for 2A.3 and 2A.5.
