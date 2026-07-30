# Roadmap: global class field theory

Mathlib now has the full adele ring of a number field — `NumberField.AdeleRing R K =
InfiniteAdeleRing K × FiniteAdeleRing R K` (Salvatore Mercuri, María Inés de Frutos-Fernández;
`Mathlib/NumberTheory/NumberField/AdeleRing.lean`), built on de Frutos-Fernández's
`FiniteAdeleRing`/`adicCompletion` stack and Anatole Dedecker's restricted products, with
Fabrizio Barroero's finite places and product formula and, new at our pin, Xavier Roblot's
Galois/Dirichlet-character dictionary for cyclotomic fields
(`Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean`) and Andrew Yang's arithmetic
Frobenius elements (`Mathlib/RingTheory/Frobenius.lean`). What it does **not** have is any of
global class field theory's own objects: no ray class groups or moduli (verified at the pin:
zero matches for ray/narrow class anywhere), no narrow class group, no idele class group (being
defined right now in [PR #40735](https://github.com/leanprover-community/mathlib4/pull/40735)),
no Hecke characters or Grossencharacters (none in any Lean 4 development we could find), no
global Artin map, no reciprocity law, no conductors of abelian extensions, no existence
theorem, no Hilbert class field (now a `theorem_wanted` file in
[PR #40661](https://github.com/leanprover-community/mathlib4/pull/40661)), no Kronecker–Weber.
This roadmap builds that theory: moduli and ray class groups (including the narrow class group
that the [multiquadratic roadmap](../Multiquadratic/README.md) already wants), the idele class
group and its topology, Hecke characters with the finite-order ↔ ray-class dictionary, the
global Artin map assembled from the local reciprocity maps of the
[local-fields roadmap](../LocalFields/README.md) (roadmap in preparation), the reciprocity law
and the existence theorem, conductors, the Hilbert class field with the principal ideal
theorem, Kronecker–Weber, the abelian conductor–discriminant formula, ring class fields, and
the global class formation — each layer with its complete basic theory.

Global class field theory has one substantial prior formalization effort: María Inés de
Frutos-Fernández's Lean 3 development
([mariainesdff/ideles](https://github.com/mariainesdff/ideles), ITP 2022,
[arXiv:2203.16344](https://arxiv.org/abs/2203.16344)) defined the idele class group of a global
field, **stated** the main theorems of global CFT, and proved `ClassGroup` is an explicit
quotient of the idele class group; its adelic substrate was ported and is today's Mathlib
stack, but the CFT statements were not. The active
[kbuzzard/ClassFieldTheory](https://github.com/kbuzzard/ClassFieldTheory) project (`main` =
`4100479`, 2026-07-26) has global ambitions at blueprint level: `blueprint/src/_4_global.tex`
(720 lines) develops the cohomological route — the idele class group as Galois module,
S-ideles, the Herbrand-quotient computation through S-units, a Dirichlet-density route to the
norm-index upper bound, and a prose sketch of fundamental classes — but **no Lean code for the
global half exists there today** (the repository tree is `Cohomology/`,
`IsNonarchimedeanLocalField/`, `LocalCFT/` only). [FLT](https://github.com/ImperialCollegeLondon/FLT)
has proved, sorry-free, the two adelic compactness pillars: `NumberField.AdeleRing.cocompact`
(compactness of `𝔸_K/K`) and Fujisaki's lemma (`FLT/DivisionAlgebra/Finiteness.lean`, the
idelic compactness that subsumes class-number finiteness and the unit theorem). This roadmap
develops global CFT **independently in Tau Ceti** (owner decision: Tau Ceti is the
destination; Mathlib, FLT, and ClassFieldTheory are consumed, cited, and tracked with
refactor-onto flags, not written to), in the pin's vocabulary, convention-compatible with all
three projects (§Provenance).

Suggested home: `TauCeti/NumberTheory/ClassFieldTheory/Global/`, with subdirectories per layer
(`Modulus/`, `RayClass/`, `IdeleClass/`, `HeckeCharacter/`, `NormIndex/`, `Reciprocity/`,
`Existence/`, `RayClassField/`, `HilbertClassField/`, `KroneckerWeber/`, `Grossencharacter/`,
`ClassFormation/`). Justification: `Mathlib/NumberTheory/ClassFieldTheory/Local/Basic.lean` is
the path erdOne's mathlib fork branch `erd1/LCFT` already stakes out for class field theory upstream (see
the local-fields roadmap's audit), so `NumberTheory/ClassFieldTheory/Global/` mirrors the
namespace Mathlib itself is converging on and makes eventual upstreaming a file move; it also
sits beside the prospective `ClassFieldTheory/Local/` home of the local roadmap's late layers.
Purely Dedekind-domain material (the finite-part ray class machinery of Layers 0–1) should be
written so that its eventual Mathlib home could be next to `RingTheory/ClassGroup/`; note the
intended split in file docstrings.

This roadmap is part of the coordinated 2026-07-30 family. It **consumes** the
[local-fields roadmap](../LocalFields/README.md) (roadmap in preparation) — its Layer 7
Artin-map bundle with the arithmetic-Frobenius normalization, its Layer 2 unramified norm
computations, its Layer 3 different/conductor machinery, and its Layer 8 Hilbert symbols — and
the [continuous-cohomology roadmap](../ProfiniteCohomology/README.md) (roadmap in preparation)
for Layer 11 only: the audit finding (sharper than the master plan, which listed
ProfiniteCohomology as a blanket dependency) is that the entire reciprocity core, Layers 0–9,
needs only **finite**-group cohomology, which Mathlib has at the pin
(`RepresentationTheory/Homological/GroupCohomology/` with `FiniteCyclic`, `Hilbert90`,
`Shapiro`, `LongExactSequence`); only the profinite class formation and the Brauer-group
compatibilities of Layer 11 need the sibling. It **shares one bridge** with the
[number-field-arithmetic roadmap](../NumberFieldArithmetic/README.md) (roadmap in preparation),
which owns the uniform decomposition/inertia/Frobenius/Artin-symbol API and the global↔local
dictionary (completions of `K` at finite places are `IsNonarchimedeanLocalField`s): the exact
bridge lemmas this roadmap needs are named in Layer 2 and must be **stated in both roadmaps and
proved once** (coordination note there). It **supplies**: the narrow class group and the
genus-field compatibility to [Multiquadratic](../Multiquadratic/README.md) (its Layer 3 names
the narrow class group as a prerequisite this roadmap now owns); Hecke characters and their
conductors to the [L-functions roadmap](../LFunctions/README.md) (roadmap in preparation),
which owns everything analytic — Hecke L-series, functional equations, **Chebotarev and every
density theorem** — none of which is used here (the build below is deliberately density-free);
and the reciprocity interfaces of the Wave-2 roadmaps ("Wave 2" here and below = the
planned second wave of LMFDB-background roadmaps, following the current wave this roadmap
belongs to) — the Hilbert reciprocity product formula
for QuaternionArithmetic's classification, the invariant-map package for Honda–Tate's Brauer
data, and ring class fields for the CM theory.

## Standing hypotheses

The standing setting is a number field `K`: `[Field K] [NumberField K]`, with `𝓞 K` its ring
of integers, `HeightOneSpectrum (𝓞 K)` its finite places, and `InfinitePlace K` its infinite
places. Spell hypotheses out; do not bundle them. Abelian extensions enter unbundled as
`[Algebra K L] [IsAbelianGalois K L]` (the pin's `Mathlib/FieldTheory/Galois/Abelian.lean`
class, also the vocabulary of PR #40661), with `[Module.Finite K L]` when finiteness is meant;
infinite abelian extensions (`K^{ab}`, ray-class towers) are handled through the Krull-topology
and `IsGaloisGroup` API as in the local roadmap. The **finite-part** ray class machinery of
Layers 0–1 is stated at Dedekind generality — `(R, K)` with `[CommRing R] [IsDedekindDomain R]
[Field K] [Algebra R K] [IsFractionRing R K]`, matching Mathlib's own `AdeleRing R K`
parametrization — because it is free at that generality and serves function fields and orders
later; everything involving real places, and all of class field theory proper (Layers 4–11),
is stated for number fields. ⚠ The function-field case of global CFT is **out of scope** (and
Mathlib's `AdeleRing` docstring itself warns the definition is wrong for function fields);
do not add speculative function-field hypotheses to number-field theorems. ⚠ Never assume
`K` totally imaginary, never assume trivial class group, and never let a statement silently
require "no real places": the narrow/wide distinction and the unit-sign obstructions are
exactly the content several downstream consumers (Multiquadratic genus theory above all) need,
and the literature is full of totally-imaginary shortcuts. Statements must carry their true
hypotheses.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| modulus | `𝔪 = (𝔪₀, 𝔪∞)`: finite part `𝔪₀ : Ideal (𝓞 K)`, nonzero (equivalently a finitely supported exponent function on `HeightOneSpectrum (𝓞 K)` — provide both faces and the translation); infinite part `𝔪∞ : Set (InfinitePlace K)` with `∀ w ∈ 𝔪∞, w.IsReal` (⚠ complex places never divide a modulus). Divisibility of moduli is componentwise | Layer 0; Janusz IV §1 |
| multiplicative congruence | `x ≡ 1 mod* 𝔪` for `x ∈ Kˣ`: at each `v ∣ 𝔪₀`, `ord_v(x − 1) ≥ ord_v(𝔪₀)` (order of vanishing of the element; ⚠ under the pin's multiplicative `ℤᵐ⁰`-valued `HeightOneSpectrum.valuation` higher order means *smaller* value, so this additive `≥` is the multiplicative `≤`); at each `w ∈ 𝔪∞`, `0 < embedding_of_isReal w x`. ⚠ This is a condition on `Kˣ`, multiplicative, **not** membership in `1 + 𝔪₀` inside `𝓞 K` — the two agree only for integral `x` coprime to `𝔪₀` | Layer 0 |
| ray class group | `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`: fractional ideals with support disjoint from `𝔪₀`, modulo principal ideals `(x)` with `x ≡ 1 mod* 𝔪`. `Cl_⊥ := Cl_{((1),∅)} = ClassGroup (𝓞 K)` by a named isomorphism, not by definitional accident | Layer 1 |
| narrow class group | `Cl⁺ K := Cl_𝔪 K` for `𝔪 = ((1), {w ∣ w.IsReal})` — trivial finite part, all real places. Equivalently `J/P⁺` with `P⁺` the totally positive principal ideals; the equivalence is a named lemma. "Narrow" never means "totally positive units exist"; the degenerate cases (no real places ⇒ `Cl⁺ = Cl`) are instances, not separate definitions | Layer 1; Janusz VI §3 ("extended class group") |
| idele group, idele class group | `IdeleGroup R K := (AdeleRing R K)ˣ` with the **units topology** (embedding `x ↦ (x, x⁻¹)`), and `IdeleClassGroup R K := IdeleGroup R K ⧸ principal ideles` — adopt the shapes, names, and generality of PR #40735 (T. Browning) verbatim, so the Tau Ceti development refactors onto it the day it merges. ⚠ The idele topology is **not** the subspace topology from `𝔸_K` (the pin's `Topology/Algebra/IsOpenUnits.lean` records exactly this); Mathlib's `Units` topology gets it right automatically — never re-topologize | Layer 2; PR #40735 |
| idele norm | `‖·‖ : IdeleGroup → ℝ_{>0}`, the product of normalized local absolute values: at finite `v`, `‖π_v‖ = 1/q_v` (= `FinitePlace` normalization, matching the local roadmap's `‖x‖_K = q^{−v_K(x)}`); at real `w` the usual absolute value; at complex `w` the **square** of the modulus (the `InfinitePlace.mult`-weighted convention of the pin's `ProductFormula.lean`). Product formula: `‖·‖ = 1` on principal ideles. `C_K^1 := ker ‖·‖` on classes | Layer 2; `Mathlib/NumberTheory/NumberField/ProductFormula.lean` |
| local normalizations | imported wholesale from the [local-fields roadmap](../LocalFields/README.md) pinned table: normalized valuation `v(π) = 1`, residue cardinality `q_v`, **arithmetic Frobenius** `x ↦ x^{q_v}` is the distinguished generator, `Art_{K_v}(π) = Frob_v` | LocalFields Layers 0/2/7 |
| Artin map, direction and normalization | finite level: `θ_{L/K} : C_K ⧸ N_{L/K} C_L ≃* Gal(L/K)` for finite abelian `L/K`, **defined** as the compilation of local maps, `θ((x_v)_v) = ∏_v Art_{K_v}(x_v)|_L`; normalization: for `v` unramified in `L` and `x` the class of an idele that is a uniformizer at `v` and a unit at every other place, `θ(x) = Frob_v` (arithmetic). Profinite level: `Art_K : C_K →* Gal(K^{ab}/K)` continuous, **surjective** with kernel the identity component `D_K` — ⚠ the exact opposite failure mode from the local case (`Art_{K_v}` injective, not surjective; `Art_K` surjective, not injective); porting local statements verbatim is the classic sign error | Layers 6–7; Neukirch ANT VI §5 |
| ideal-theoretic Artin map | `J^𝔪 →* Gal(L/K)`, `𝔭 ↦ Frob_𝔭` in the pin's `IsArithFrobAt`/`arithFrobAt` vocabulary (`Mathlib/RingTheory/Frobenius.lean`), for `𝔪` divisible by the conductor; agreement with the idelic map under the Layer 2 dictionary is a **named theorem**, not a definition | Layers 6–8 |
| Hecke character | **primary form**: a continuous homomorphism `χ : IdeleClassGroup (𝓞 K) K →* ℂˣ` (Mathlib's `ContinuousMonoidHom`). The dictionary: `χ` has finite order ⟺ `ker χ` open ⟺ `χ` factors through a ray class group `Cl_𝔪 K` (each equivalence a named theorem); "ray class character" is the composite notion, never an independent definition. Unitary characters and the decomposition `χ = χ_u · ‖·‖^s` are Layer 3; Grossencharacters of type `A₀` are Layer 10 | Layer 3 |
| conductor | of a finite abelian `L/K`: the smallest modulus `𝔣` with `U_𝔣 ⊆ Kˣ · N_{L/K}(I_L)` (idelic form), equivalently assembled from the local conductors of the local-fields roadmap Layer 7 with real places entering by ramification of the corresponding real place — both faces stated, translation a theorem. Of a Hecke character: the smallest `𝔪` with `U_𝔪 ⊆ ker χ`. `DirichletCharacter.conductor` compatibility over `ℚ` is a named theorem | Layers 3/7 |
| inequality naming | the two norm-index bounds are named by content — `herbrand_ge` (`[C_K : N C_L] ≥ [L:K]`, cyclic, via the Herbrand quotient) and `kummer_le` (`≤`, via Kummer theory) — **never** "first/second inequality": the literature disagrees on the ordinals (the ClassFieldTheory blueprint's "first inequality" is the density-route `≤`; Neukirch's First is the `≥`), and a name that flips meaning between sources is a defect | Layer 5 |
| class formation interface | identical to the local roadmap's: finite level in the shape of kbuzzard/ClassFieldTheory's `FiniteClassFormation` (distinguished `H²` class, `H¹`-vanishing, compatible invariants); the profinite formation `(G_K, colim_L C_L)` NSW-style on top | Layer 11 |

**Pinned route decision** (delegated by the master plan; recorded here with rationale). The
global Artin map is **assembled from the local reciprocity maps** — Neukirch-style — rather
than constructed from a global fundamental class: the map is *defined* on ideles by
`(x_v)_v ↦ ∏_v Art_{K_v}(x_v)|_L` (almost all factors are trivial by unramifiedness), so that
local–global compatibility, the single most-consumed statement downstream, holds **by
construction**; the global theorem is then exactly the reciprocity law "`θ_{L/K}` kills
principal ideles" plus the norm-index equality. The inputs are the local-fields roadmap's
Layer 7 (a sibling deliverable with the same arithmetic-Frobenius normalization) and the
norm-index machinery of Layer 5, whose proofs are pinned to the **algebraic** routes
(Herbrand quotient of S-idele classes for `≥`; Chevalley's Kummer-theoretic argument for `≤`),
keeping this roadmap free of L-series and density theorems — those belong to the L-functions
sibling, and a density-dependent reciprocity proof would invert the dependency order of the
whole program. The **cohomological global class formation is not dropped**: it is Layer 11, a
compatibility layer that reuses the Layer 5 computations, states the fundamental classes and
invariant maps, and is where Honda–Tate-facing Brauer data lives. This is also where the two
in-motion external designs are reconciled: the ClassFieldTheory blueprint's global chapter is
fundamental-class-first with a density-route inequality (their "first inequality"), and if
their global half lands in Lean, Layer 11's statements are the refactor-onto surface, while
Layers 5–7's remain independent. The alternatives considered and rejected as the *spine*:
fundamental-class-first (blocks reciprocity on `H²`-machinery and on the ProfiniteCohomology
sibling; worse parallelism; local–global compatibility becomes a theorem chain rather than a
definition), and the ideal-theoretic-only classical route (Janusz's, with no ideles — loses
the direct interface to Mathlib's adele stack, to FLT, and to Hecke characters; retained
instead as Layer 7–8's *dictionary*, not the spine).

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:"/"PR:" flags material that landed
after the pin or is in flight, to be consumed on a later bump rather than rebuilt.

- **The adele stack.** `Mathlib/NumberTheory/NumberField/AdeleRing.lean` (`AdeleRing R K`,
  `principalSubgroup`, `algebraMap_injective`; Mercuri–de Frutos-Fernández);
  `InfiniteAdeleRing.lean` (`InfiniteAdeleRing K = Π_v v.Completion`, `locallyCompactSpace`,
  `denseRange_algebraMap` — weak approximation at the infinite places — and a `Norm` instance);
  `Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean` (`FiniteAdeleRing R K` as a
  restricted product, `isUnit_iff`, `unitEmbedding : Kˣ →* (FiniteAdeleRing R K)ˣ`);
  `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean` (`HeightOneSpectrum.intValuation`,
  `valuation : Valuation K ℤᵐ⁰`, `adicCompletion`, `adicCompletionIntegers`,
  `valuation_exists_uniformizer`); `Mathlib/Topology/Algebra/RestrictedProduct/`
  (`Basic/TopologicalSpace/Units` — the units of a restricted product carry the restricted
  product topology: the idele topology comes out right by construction) and
  `Topology/Algebra/IsOpenUnits.lean`. **master:** the notation `𝔸[K]`
  ([PR #40535](https://github.com/leanprover-community/mathlib4/pull/40535), merged
  2026-07-29). **PR:** the idele class group itself (#40735), local compactness of `𝔸_K`
  (#36404, Mercuri's [AFM 2025 paper](https://arxiv.org/abs/2405.19270) upstreaming), the
  finite-adele norm (#36275), transparent `InfiniteAdeleRing` instances (#42130).
- **Places and the product formula.** `Mathlib/NumberTheory/NumberField/Completion/FinitePlace.lean`
  (`FinitePlace K` as absolute values, `embedding`, `adicAbv`, `norm_def`, the
  DVR instances on `adicCompletionIntegers`; Barroero);
  `NumberField/ProductFormula.lean` (`prod_abs_eq_one`: `∏_v |x|_v = 1` over all places with
  the `mult`-weighted infinite factors — the normalization this roadmap's idele norm must
  match); `NumberField/InfinitePlace/Basic.lean` (`IsReal`, `IsComplex`,
  `embedding_of_isReal`, `mult`); `NumberField/InfinitePlace/Ramification.lean`
  (`InfinitePlace.IsUnramified/IsRamified` and the class `IsUnramifiedAtInfinitePlaces` —
  exactly the vocabulary for real places in moduli and for "unramified everywhere" in
  Layer 8); `NumberField/Completion/Ramification.lean` (`InfinitePlace.inertiaDeg`,
  `sum_inertiaDeg_eq_finrank`) and `LiesOverInstances.lean`.
- **Class group and units.** `Mathlib/RingTheory/ClassGroup/Basic.lean` (`ClassGroup R`,
  `ClassGroup.mk0`, `mk0_surjective`) and `ExtendedHom.lean` (`ClassGroup.extendedHom` — the
  capitulation map `ClassGroup (𝓞 K) →* ClassGroup (𝓞 L)`, and
  `extendedHom_eq_one_of_forall_isPrincipal`: the exact target shape of the principal ideal
  theorem; Birkbeck–Brasca); `NumberField/ClassNumber.lean` (finiteness, `classNumber`);
  `NumberField/Units/Basic.lean`, `Units/DirichletTheorem.lean`, `Units/Regulator.lean`
  (torsion `μ(K)`, the unit theorem — the lattice input to Layer 5's S-unit Herbrand
  computation); `Mathlib/RingTheory/DedekindDomain/SInteger.lean` (S-integers, S-units,
  `unitEquivUnitsInteger`; Angdinata). **PR:** S-integers as a localization/Dedekind domain
  (#40848, Barroero), Dirichlet's S-unit theorem (#40791) — Layer 5's Kummer route
  refactors onto these if they land first.
- **Frobenius and ramification.** `Mathlib/RingTheory/Frobenius.lean` (`AlgHom.IsArithFrobAt`,
  `IsArithFrobAt`, `arithFrobAt` — existence, uniqueness-under-unramifiedness, conjugation;
  A. Yang; the mathlib landing of FLT's Frobenius miniproject,
  [PR #19926](https://github.com/leanprover-community/mathlib4/pull/19926));
  `Mathlib/NumberTheory/RamificationInertia/` (`ramificationIdx`, `inertiaDeg`,
  `sum_ramification_inertia`, Galois-action transitivity, decomposition/inertia fields);
  `Mathlib/RingTheory/Invariant/Basic.lean` (stabilizer ↔ residue-Galois machinery). **PR:**
  the ring-level decomposition/inertia refactor wave (#41591 and companions, Roblot) — the
  uniform API is the [number-field-arithmetic sibling](../NumberFieldArithmetic/README.md)'s
  to track; this roadmap consumes whatever spelling that roadmap fixes.
- **Cyclotomic fields.** `Mathlib/NumberTheory/Cyclotomic/` (`IsCyclotomicExtension`,
  `CyclotomicField`, `Gal.lean`'s `autEquivPow`, discriminants, `PrimitiveRoots`);
  `Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean` (Roblot, 2026 — at the pin):
  `IsCyclotomicExtension.Rat.galEquivZMod : Gal(K/ℚ) ≃* (ZMod n)ˣ`,
  **`galEquivZMod_stabilizer`** (the decomposition group at `p ∤ n` is `⟨[p]⟩` — the
  cyclotomic Frobenius law), `intermediateFieldEquivSubgroupChar` (subfields of `ℚ(ζₙ)` ↔
  subgroups of Dirichlet characters, following Washington) and
  `mem_intermediateFieldEquivSubgroupChar_iff_conductor_dvd`; `NumberField/Cyclotomic/Ideal.lean`
  (`(ζ − 1)`-ramification: `e`, `f`, `primesOver`-counts at `p ∣ n`). Layer 4 is largely a
  repackaging of this file pair, and it is why Layer 4 can start on day one.
- **Dirichlet characters.** `Mathlib/NumberTheory/DirichletCharacter/` (`DirichletCharacter R n
  = MulChar (ZMod n) R`, `changeLevel`, `FactorsThrough`, `conductor`, `IsPrimitive`, Gauss
  sums, orthogonality) — the `K = ℚ` face of Layer 3's dictionary. `Mathlib/NumberTheory/MulChar/`.
- **Abelian Galois bookkeeping.** `Mathlib/FieldTheory/Galois/Abelian.lean`
  (`IsAbelianGalois`), `Galois/Profinite.lean`, `KrullTopology.lean`,
  `AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup`,
  `absoluteGaloisGroupAbelianization`), `IsGaloisGroup`.
- **Finite group cohomology** (all of Layers 5–6's cohomological needs, at the pin):
  `Mathlib/RepresentationTheory/Homological/GroupCohomology/` — `LowDegree` (explicit
  `H⁰/H¹/H²`), `Hilbert90.lean` (`H¹(Gal(L/K), Lˣ) = 0`), `FiniteCyclic.lean` (periodicity —
  the Herbrand-quotient engine), `Shapiro.lean` (the semi-local/coinduced computation for
  S-ideles), `LongExactSequence.lean`, `Functoriality.lean`. **master:** `TateCohomology`
  (PR #38553, merged 2026-06-09, six days after the pin) — Layer 5's `Ĥ⁰`-statements are
  phrased as plain norm-quotients at the pin and refactor onto `TateCohomology` at the first
  bump, exactly as the local roadmap's Layer 5 plans; keep the two roadmaps' spellings
  identical.
- **Group-theoretic transfer.** `Mathlib/GroupTheory/Transfer.lean` (`MonoidHom.transfer`,
  Burnside machinery) — the Layer 8 principal-ideal-theorem input.
- **Assorted.** CRT for Dedekind domains
  (`IsDedekindDomain.quotientEquivPiOfProdEq`/`quotientEquivPiFactors`,
  `RingTheory/DedekindDomain/Ideal/Lemmas.lean`; `Ideal.quotientInfRingEquivPiQuotient`);
  `Ideal.absNorm` and `FractionalIdeal` norms; `Mathlib/Topology/Algebra/ContinuousMonoidHom.lean`
  and `PontryaginDual.lean`; `Mathlib/Analysis/Complex/Circle.lean`; Kummer extensions
  (`Mathlib/FieldTheory/KummerExtension.lean`) and `LegendreSymbol/` (quadratic reciprocity —
  re-derived, not consumed, in the Layer 11 worked example, closing a loop rather than a gap).

### What is in motion elsewhere (checked 2026-07-30; coordinate, cite, do not fork)

- **Mathlib PR [#40735](https://github.com/leanprover-community/mathlib4/pull/40735)**
  (T. Browning, open, updated 2026-07-29): defines `NumberField.IdeleGroup R K`,
  `IdeleGroup.principalSubgroup`, `IdeleClassGroup R K`, and the `ofCompletion`/
  `ofAdicCompletion` maps from local units, "to be used to define Hecke L-Functions". This is
  the single most load-bearing in-flight item: Layer 2 adopts its names and shapes verbatim,
  and Layer 3 is heading exactly where its author says he is heading — contact before starting
  either layer (§Provenance).
- **Mathlib PR [#40661](https://github.com/leanprover-community/mathlib4/pull/40661)**
  (F. A. E. Nuccio, open, 2026-07-16): a `theorem_wanted` file
  `NumberTheory/NumberField/HilbertClassField.lean` — Kronecker–Weber
  (`IsAbelianGalois.le_cyclotomicField`), a conductor-as-least-cyclotomic-level, and the
  Hilbert class field with `Gal ≃* ClassGroup (𝓞 K)`, `Algebra.Unramified (𝓞 K) (𝓞 H)`,
  `IsUnramifiedAtInfinitePlaces`, maximality, and the principal ideal theorem via
  `ClassGroup.extendedHom = 1`. Mathlib's own wanted-statement shapes for Layers 8–9; align
  statement forms with it and report divergences on the PR.
- **Mathlib PRs [#36404](https://github.com/leanprover-community/mathlib4/pull/36404)/**
  [#36275](https://github.com/leanprover-community/mathlib4/pull/36275)/#42130 (Mercuri;
  open): local compactness of `𝔸_K`, the finite-adele norm, instance transparency. Layer 2's
  topology milestones refactor onto these.
- **Mathlib PR [#41765](https://github.com/leanprover-community/mathlib4/pull/41765)**
  (R. Brasca, open, updated 2026-07-29): `NumberTheory/NumberField/DirichletDensity` — the
  L-functions sibling's territory; cited here only to delimit the boundary (nothing in this
  roadmap may depend on it).
- **kbuzzard/ClassFieldTheory** (`main = 4100479`, 2026-07-26; maintainer Yunzhou "Edison"
  Xie): global chapter at blueprint level only (`_4_global.tex`: idele-class Herbrand
  quotient via S-ideles and the unit lattice, density-route upper bound, solvable induction
  to `H¹ = 0` and `#H² ≤ n`, fundamental classes by cyclotomic splitting — a faithful
  Artin–Tate skeleton). No global Lean code. Their finite-level abstract machinery
  (`FiniteClassFormation`, Tate cohomology now upstreamed, Herbrand calculus) is exactly what
  Layers 5 and 11 align interfaces with, through the local-fields roadmap's identical
  pinned interface. ⚠ Their day-to-day channel is private (see the local roadmap's
  provenance); repository state is the public proxy.
- **FLT** (ImperialCollegeLondon/FLT, checked 2026-07-30): sorry-free and directly consumable
  as prior art — `NumberField.AdeleRing.discrete` and `NumberField.AdeleRing.cocompact`
  (compact `𝔸_K/K`, general number field, via the base-change equivalence
  `𝔸_L ≃ L ⊗_K 𝔸_K`), and Fujisaki's lemma (`FLT/DivisionAlgebra/Finiteness.lean`,
  `NumberField.AdeleRing.DivisionAlgebra.compact_quotient`, Voight Main Thm 27.6.14(a)) whose
  commutative specialization is Layer 2's compactness of `C_K^1`. The Frobenius miniproject is
  closed (merged as the pin's `RingTheory/Frobenius.lean`). FLT's own class-field-theory
  axiom is **local** (the `erd1/LCFT` interface; A. Yang's update of 2026-07-27, audited by
  the local-fields sibling): no global-reciprocity axiom appears in FLT's staging today, so
  the coordination surface here is the adele/Fujisaki layer, not reciprocity.
- **mariainesdff/ideles** (Lean 3, ITP 2022): the statements-of-global-CFT prior art named in
  the opening; unported. Coordinate with the author (who is also the author of PR #40661's
  wanted-statements and of the dormant LocalClassFieldTheory) before Layers 2 and 7.
- **Zulip decisions in force**: the 2020
  [maths > "Ideal class group"](https://leanprover-community.github.io/archive/stream/116395-maths/topic/Ideal.20class.20group.html)
  thread (Baanen, Buzzard, Best) fixed the `ClassGroup`-through-fractional-ideals design this
  roadmap builds on and already floated idele-class compactness as the unifying statement;
  the `ValuativeRel`-replaces-`Valued` refactor and the local-fields design threads are
  inherited through the [local-fields roadmap](../LocalFields/README.md)'s provenance table
  (its ⚠ "nothing stated against `Valued`" applies verbatim to the completions used here);
  the FLT update thread
  ([FLT > "update"](https://leanprover.zulipchat.com/#narrow/channel/416277-FLT/topic/update/near/613077432),
  A. Yang, 2026-07-27) is the source for the local-only CFT axiom statement above. No Zulip
  thread on ray class groups, Hecke characters, or global reciprocity in Lean exists as of
  today (searched the archive 2026-07-30) — the design space is genuinely open, which is why
  the conventions table above pins it.

## What is missing (build here)

Everything in global CFT's own vocabulary. Moduli and multiplicative congruences with real
places. Ray class groups `Cl_𝔪` with finiteness, functoriality, and the five-term unit/ray
exact sequence; the narrow class group; the coprime-representative ("moving") lemma. The idele
class group's arithmetic: congruence subgroups `U_𝔪`, `C_K ⧸ U_𝔪 ≅ Cl_𝔪`, the norm-one
subgroup and its compactness, the connected component `D_K`, open-subgroup structure. Hecke
characters: the continuous-character definition, the finite-order dictionary, conductors,
local components, the Dirichlet-character equivalence over `ℚ`; Grossencharacters and the
`∞`-type. The norm-index machinery (Herbrand quotient of S-idele classes, both inequalities,
Hasse norm theorem). The global Artin map by local–global compilation, the reciprocity law,
functoriality in towers and under norms, ramification ⟺ conductor divisibility. Norm groups
and the existence theorem; norm limitation; the ideal/idele dictionary for the Artin map; ray
class fields. The Hilbert class field, capitulation, and the principal ideal theorem.
Kronecker–Weber and the conductor–discriminant formula. Ring class fields and the CM-facing
interface. The global class formation, fundamental classes, invariant maps, the
Brauer-group-facing sum-of-invariants statements, and the Hilbert reciprocity product formula.
None of this exists in Mathlib at the pin, in the ClassFieldTheory repository's Lean code, or
in FLT.

---

## The build, in layers

The ordering below is the dependency order. Layers 0–5 elaborate against the pin alone;
Layer 6 is where the [local-fields roadmap](../LocalFields/README.md) becomes load-bearing;
only Layer 11 consumes [ProfiniteCohomology](../ProfiniteCohomology/README.md). As each layer
makes the next layer's types expressible, its milestones are added to `Suggested.lean` with
`sorry`.

### Layer 0: moduli and multiplicative congruences

- **The modulus.** The structure of the conventions table: finite part a nonzero ideal
  (with the exponent-function face and `Ideal.factorization`-compatibility lemmas), infinite
  part a set of real places. Divisibility, lcm/gcd, support; the modulus `(1)` and the
  all-real-places modulus as named instances. ⚠ Real places are the entire point of the
  formalism — a design that makes `𝔪∞ = ∅` the path of least resistance and real conditions
  an afterthought will silently produce the wide class group everywhere; make the two
  components equally weighted in the API, and test with `𝔪∞ ≠ ∅` from the first lemma.
- **The congruence subgroup of `Kˣ`.** `K(𝔪) := {x : Kˣ | x ≡ 1 mod* 𝔪}` per the pinned
  spelling (valuation inequalities at `v ∣ 𝔪₀`, positivity via `embedding_of_isReal` at
  `w ∈ 𝔪∞`), a subgroup; monotonicity in `𝔪`; `K(𝔪) ∩ 𝓞`-descriptions for integral
  elements (the `1 + 𝔪₀`-comparison, with its coprimality caveat as a stated lemma). ⚠ The
  congruence is multiplicative: `x ≡ 1` and `y ≡ 1` give `xy ≡ 1` by the ultrametric/sign
  calculus, not by ring arithmetic in a quotient; do not define `K(𝔪)` through `𝓞 K ⧸ 𝔪₀`.
- **Sign surjectivity at the real places.** The total sign map
  `Kˣ → (Π w real, {±1})`, `x ↦ (sign of x at w)_w`, is surjective — the infinite-place face
  of weak approximation, derivable at the pin from `InfiniteAdeleRing.denseRange_algebraMap`.
  This is the enabling lemma for every narrow-vs-wide comparison downstream and the first
  pin-expressible target of the roadmap.
- **The `(𝓞 K ⧸ 𝔪₀)ˣ × signs` package.** The natural map from
  `{x coprime to 𝔪₀}` to `(𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞} {±1}` and its surjectivity (CRT +
  sign surjectivity); its kernel is `K(𝔪)` intersected with the coprime elements. This is
  the computational face of the ray class exact sequence one layer up.

### Layer 1: ray class groups and the narrow class group

- **`J^{𝔪₀}` and `P_𝔪`.** The subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of fractional
  ideals with support disjoint from `𝔪₀` (spell support through the `v`-adic `count` of the
  factorization; provide the `Ideal`-pair face `I = 𝔞𝔟⁻¹` with `𝔞, 𝔟` coprime to `𝔪₀`);
  the ray `P_𝔪` = principal ideals of elements of `K(𝔪)`. `Cl_𝔪 K` as the quotient;
  functoriality: `𝔪 ∣ 𝔪' ⟹ Cl_{𝔪'} ↠ Cl_𝔪`; `Cl_{(1,∅)} ≃* ClassGroup (𝓞 K)` (via
  `ClassGroup.mk0`-compatibility, a named isomorphism).
- **The moving lemma.** Every class of `Cl_𝔪` — and, the form to prove first, every class of
  `ClassGroup (𝓞 K)` — contains an integral ideal coprime to `𝔪₀`. Route: CRT/approximation
  in the Dedekind domain (`quotientEquivPiOfProdEq` plus a uniformizer-selection argument),
  not geometry of numbers. ⚠ This lemma is genuinely absent from Mathlib (verified; only
  `mk0_surjective` exists) and is the pivot on which surjectivity `Cl_{𝔪'} ↠ Cl_𝔪` and the
  ideal↔idele dictionary both turn; it is a Dedekind-domain statement — prove it at that
  generality.
- **The ray class exact sequence.** For every modulus:
  `1 → 𝓞ˣ-image → (𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞} {±1} → Cl_𝔪 K → ClassGroup (𝓞 K) → 1`,
  with the first map induced by Layer 0's package on global units. Corollaries: `Cl_𝔪` is
  **finite** of cardinality
  `h_K · φ(𝔪₀) · 2^{#𝔪∞} / [𝓞ˣ : 𝓞ˣ ∩ K(𝔪)]`-shape (state the exact index form, not
  just finiteness). ⚠ **The unit-group obstruction is the trap of this layer**: the sequence
  shows `Cl_𝔪` is *not* `(𝓞/𝔪₀)ˣ × signs × Cl` in general — global units glue the factors,
  and the size of the unit image is a genuinely global quantity (it is why ray class groups
  of real quadratic fields are hard and why `Cl⁺ ≠ Cl` exactly when no unit has independent
  signs). Every statement must run through the exact sequence, never through a claimed
  product decomposition.
- **The narrow class group.** `Cl⁺ K` per the pinned convention; `Cl⁺ = Cl` for totally
  imaginary `K`; the 2-group `ker(Cl⁺ ↠ Cl)` computed by the exact sequence (order
  `2^{r_1}/[𝓞ˣ : 𝓞ˣ⁺]`); totally-positive-principal characterization. **Interface milestone
  (Multiquadratic Layer 3):** the narrow class group and the surjection `Cl⁺ ↠ Cl` in exactly
  this spelling are the prerequisites the multiquadratic roadmap names for its real-quadratic
  2-rank theorem; freeze this API in coordination with any implementor working there.
- **Dedekind generality.** Everything above except the `𝔪∞`/sign components is stated for a
  Dedekind domain with fraction field (the "ray class group of `R` mod `𝔪₀`"); the
  number-field statements specialize. This is what ring class groups (Layer 10) and any
  future function-field work reuse.

### Layer 2: the idele class group

- **The objects, aligned with PR #40735.** `IdeleGroup (𝓞 K) K`, `principalSubgroup`,
  `IdeleClassGroup (𝓞 K) K`, the local inclusions `ofCompletion`/`ofAdicCompletion`; basic
  topology: `IdeleGroup` is a locally compact topological group (units of a locally compact
  ring via the `(x, x⁻¹)`-embedding; the finite part by `RestrictedProduct/Units`, the
  ambient local compactness refactoring onto #36404), `Kˣ` embeds discretely (from FLT-style
  `AdeleRing.discrete` + the units embedding), so `IdeleClassGroup` is a locally compact
  Hausdorff group. ⚠ Both #40735 shapes are `abbrev`s over `(AdeleRing R K)ˣ` — keep them
  reducible here too, so every `Units`-lemma of Mathlib applies without glue.
- **The global↔local bridge (coordinate with NumberFieldArithmetic).** The lemma set this
  roadmap needs, stated here, proved once between the two roadmaps: for each finite place
  `v`, `v.adicCompletion K` is an `IsNonarchimedeanLocalField` (uniform hypotheses as in the
  local roadmap's Layer 0); its residue cardinality is `Ideal.absNorm v.asIdeal`; the local
  normalized valuation restricts to `HeightOneSpectrum.valuation` on `K`; `FinitePlace.mk v`
  computes the local `‖·‖`. Everything the compilation map (Layer 6) and local conductors
  (Layer 7) consume crosses this bridge and nothing else.
- **The idele norm and the norm-one subgroup.** `‖·‖ : IdeleGroup →* ℝ_{>0}` per the pinned
  normalization (finite part refactoring onto #36275); the product formula `‖x‖ = 1` for
  principal `x` (globalizing the pin's `prod_abs_eq_one`); `C_K^1 ≤ IdeleClassGroup` closed.
  **Compactness of `C_K^1`** — the crown of the layer: cite and coordinate with FLT's
  sorry-free Fujisaki (`DivisionAlgebra/Finiteness.lean`; the commutative case is this
  statement) and with `AdeleRing.cocompact`; the Tau Ceti development follows the same
  reduction (fundamental-domain counting over `𝔸_K/K`). Corollaries, derived and
  cross-checked against Mathlib's independent proofs: finiteness of `ClassGroup (𝓞 K)` and
  Dirichlet's unit theorem. ⚠ `C_K` itself is **not** compact and not profinite —
  `C_K ≅ C_K^1 × ℝ_{>0}` (a choice-dependent splitting; state it as such); `Nat.card`
  statements about `C_K` are vacuous traps.
- **Congruence subgroups and the two dictionaries.** `U_𝔪 ≤ IdeleGroup`: units at every
  finite `v` with `v(u_v − 1) ≥ v(𝔪₀)` at `v ∣ 𝔪₀`, positive at `𝔪∞`, arbitrary at the
  other infinite places' identity components — fix the exact convention so that:
  (i) `IdeleGroup ⧸ Kˣ·U_𝔪·(∞-components) ≃* Cl_𝔪 K` (the finite-idele-to-ideal map
  `x ↦ ∏_v v^{v(x_v)}`, kernel analysis via the moving lemma); in particular
  (ii) `IdeleClassGroup ⧸ (image of ∏_v 𝒪_vˣ × ∞-components) ≃* ClassGroup (𝓞 K)` — de
  Frutos-Fernández's Lean 3 theorem, re-proved here in the Lean 4 vocabulary. Open subgroups
  of `C_K` all contain some such `U_𝔪`-image (the neighborhood-basis lemma) — the statement
  that makes "finite-order Hecke character ⟺ ray class character" true in Layer 3 and the
  existence theorem finite in Layer 7.
- **The connected component.** `D_K` = identity component of `IdeleClassGroup`: closed,
  divisible, `⋂ U` over open subgroups `U`; `π₀(C_K) = C_K/D_K` is profinite and
  `C_K/D_K ≅ lim_𝔪 Cl_𝔪` (the profinite completion along congruence quotients). The full
  structure of `D_K` (solenoids) is **not** a target; only the three stated properties are
  consumed (by Layers 3 and 7).

### Layer 3: Hecke characters I: the continuous-character theory

- **The definition and the first dictionary.** `HeckeCharacter K := ContinuousMonoidHom
  (IdeleClassGroup (𝓞 K) K) ℂˣ` (primary; the conventions table). The finite-order
  trichotomy, each implication a named lemma: finite order ⟺ open kernel ⟺ factors through
  `C_K/D_K·U_𝔪`-quotients ⟺ is (the pullback of) a character of some `Cl_𝔪 K`. The induced
  bijection {finite-order Hecke characters of conductor dividing `𝔪`} ≃ {characters of
  `Cl_𝔪 K`} — "ray class character" made precise.
- **Conductor.** Of a Hecke character: the gcd of moduli `𝔪` with `U_𝔪 ⊆ ker χ` (exists by
  the neighborhood-basis lemma; ⚠ gcd over both components, and the infinite part records
  exactly the real places where the local sign character is nontrivial); primitivity;
  induction from smaller moduli compatibly with `DirichletCharacter.changeLevel`'s design.
  Local components `χ_v := χ ∘ ofAdicCompletion`-units (and `χ_w` at infinite places), with
  `χ = ∏ χ_v` on ideles and conductor = product of local conductors (the local conductor
  vocabulary crosses the Layer 2 bridge; the statement's local-fields face lands fully in
  Layer 7).
- **Over `ℚ`: Dirichlet characters.** The equivalence {finite-order Hecke characters of `ℚ`
  of conductor dividing `(m)·∞`} ≃ `DirichletCharacter ℂ m`-classes, compatible with
  conductors and with `IsCyclotomicExtension.Rat`'s character dictionary; the sign character
  of `ℚ` (conductor `∞`) and the quadratic characters of `ℚ(√d)` as instances (matching
  `legendreSym`/`ZMod.χ₄`-vocabulary where Mathlib has it).
- **Unitary theory.** `|χ| = ‖·‖^σ` for a unique real `σ` ("the character is unitary after a
  norm twist"): the decomposition `χ = χ_u · ‖·‖^{σ}` with `χ_u` unitary and `σ ∈ ℝ` is
  unique outright — `σ` is pinned by `|χ| = ‖·‖^σ` since `‖·‖` surjects onto `ℝ_{>0}`, and
  the exponent is normalized **real** because a complex exponent is ambiguous exactly up to
  the continuous family of unitary twists `‖·‖^{it}`, `t ∈ ℝ`. This is the normalization
  interface the
  [L-functions roadmap](../LFunctions/README.md) consumes for Hecke L-series, and the
  arithmetic-vs-analytic normalization dictionary lives **there**, not here.
- Grossencharacters with infinite-order `∞`-type (`type A₀`, algebraicity, CM) are
  **Layer 10** — a definite later layer, not an omission here.

### Layer 4: the cyclotomic anchor

Pin-expressible on day one, independent of Layers 0–3, and the arithmetic input every
reciprocity proof reduces to.

- **The splitting law in `ℚ(ζₙ)`.** For `p ∤ n`: the decomposition group at `p` is `⟨[p]⟩`
  under `galEquivZMod` (this *is* the pin's `galEquivZMod_stabilizer` — consume it), hence:
  `f` = order of `p` in `(ℤ/n)ˣ`, `p` splits completely ⟺ `p ≡ 1 (mod n)`; the Frobenius
  at `p` **is** `[p]` in the `IsArithFrobAt` sense (a comparison `arithFrobAt` ↔
  `galEquivZMod` lemma — the pin has both sides but not the bridge). At `p ∣ n`: the
  `(ζ − 1)`-Eisenstein ramification data (consume `NumberField/Cyclotomic/Ideal.lean`).
- **The reciprocity isomorphism over `ℚ`, by hand.** `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ` (Layer 1's
  exact sequence at `K = ℚ`: units `±1` are absorbed by the sign component — the worked
  instance of the unit obstruction) and the composite
  `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ ≃* Gal(ℚ(ζₙ)/ℚ)` sending `[p] ↦ Frob_p` for `p ∤ n`. This is
  the full Artin reciprocity law for `(ℚ, ℚ(ζₙ))`, proved with no class field theory — the
  normalization anchor against which the Layer 6 map is checked, and the base case of the
  Layer 9 conductor–discriminant induction.
- ⚠ Direction check built into the milestone: `[p] ↦ Frob_p` with **arithmetic** Frobenius,
  i.e. `σ_p(ζ) = ζ^p`. The geometric convention would send `[p] ↦ Frob_p⁻¹`; both compose
  with `galEquivZMod` to give ±the identity of `(ℤ/n)ˣ`, which is why an error here survives
  superficial testing — the discriminating test is the `𝔭`-factorization of Gauss sums
  later (LFunctions' territory), so pin it *now* by the stabilizer computation.

### Layer 5: the norm-index machinery (the class field axiom)

All cohomology in this layer is of **finite** groups, at the pin. For cyclic `L/K` set
`G = Gal(L/K)`.

- **S-idele decomposition.** For `S ⊇ S_∞ ∪ ram(L/K)` finite and closed under the Galois
  action: `I_{L,S} = Π_{v ∈ S} Π_{w ∣ v} L_wˣ × Π_{v ∉ S} Π_{w ∣ v} 𝒪_wˣ`; the semi-local
  computation `H^i(G, Π_{w ∣ v} L_wˣ) ≅ H^i(G_w, L_wˣ)` (coinduction from the decomposition
  group; the pin's `Shapiro.lean` at finite level); `I_L = colim_S I_{L,S}` and
  `H^i(G, I_L) ≅ ⊕_v H^i(G_w, L_wˣ)` — the local–global cohomology dictionary at finite
  level. For `S` large enough (classes of `S`-primes generate), `C_L = I_{L,S}/𝓞_{L,S}ˣ`.
- **Herbrand quotients.** `h(G, I_{L,S}) = ∏_{v ∈ S} [L_w : K_v]` (semi-local + the local
  Herbrand quotient `h(G_w, L_wˣ) = [L_w:K_v]` — consumed from the
  [local-fields roadmap](../LocalFields/README.md) Layer 5, which is itself finite-level and
  can proceed in parallel); `h(G, 𝓞_{L,S}ˣ) = (∏_{v ∈ S} [L_w:K_v]) / [L:K]` via the S-unit
  logarithm lattice and the Herbrand-quotient-of-lattices lemma (`h` depends only on
  `ℝ ⊗ M`; Dirichlet/Minkowski input from the pin's `Units/DirichletTheorem` — the S-unit
  generalization is a milestone here, with a refactor-onto flag for PR #40791). Conclusion:
  **`h(G, C_L) = [L:K]`** for cyclic `L/K`, hence `herbrand_ge`:
  `[C_K : N_{L/K} C_L] ≥ [L:K]`.
- **`kummer_le`.** For cyclic `L/K`: `[C_K : N C_L] ≤ [L:K]`, by the pinned **algebraic**
  route (Chevalley): reduce to prime exponent `p` with `μ_p ⊆ K` by a base-change/degree
  argument, then count via Kummer theory of S-units (`Mathlib/FieldTheory/KummerExtension`,
  S-unit indices, and the `I_{K,S}`-open-subgroup calculus). ⚠ The analytic route through
  Dirichlet density (the ClassFieldTheory blueprint's choice) is deliberately **not** used:
  it would make reciprocity depend on the L-functions sibling; record the blueprint's route
  as the alternative proof this layer's statements must remain compatible with.
- **The axiom, packaged.** For cyclic `L/K`: `#Ĥ⁰(G, C_L) = [L:K]` and `H¹(G, C_L) = 1`
  (spelled at the pin as the norm-quotient cardinality and `H¹`; refactor-onto
  `TateCohomology` at the first bump). Solvable induction (inflation–restriction, the pin's
  `LongExactSequence`/`Functoriality`): `H¹(Gal(L/K), C_L) = 1` for **all** finite Galois
  `L/K` and `#H²(Gal(L/K), C_L) ≤ [L:K]` — the "global cohomology bound". Corollary
  package: `N_{L/K} C_L` has finite index dividing `[L:K]` in `C_K` for all finite Galois
  `L/K`.
- **Hasse norm theorem.** For **cyclic** `L/K`: `x ∈ Kˣ` is a norm from `Lˣ` iff it is a
  local norm everywhere (from `H¹(G, C_L) = 1` and the idele/principal exact sequence). ⚠
  State the cyclic hypothesis loudly and record the standard failure for `(ℤ/2)²`
  (Milne CFT VIII §3's biquadratic counterexample) as a stated non-theorem, so nobody
  "generalizes" it.

### Layer 6: the global Artin map and the reciprocity law

From here on the [local-fields roadmap](../LocalFields/README.md) Layer 7 bundle (the local
Artin maps with arithmetic-Frobenius normalization, norm-group lattices, and local
conductors) is load-bearing.

- **The compilation map.** For finite abelian `L/K`:
  `θ_{L/K} : IdeleGroup K →* Gal(L/K)`, `θ((x_v)) = ∏_v Art_{K_v}(x_v)|_{L}` — well-defined
  (almost all factors trivial: `x_v` a unit and `v` unramified ⟹ `Art_{K_v}(x_v)|_L = 1`,
  the local roadmap's Layer 2/7 norm statement), continuous, surjective (the image contains
  every unramified `Frob_v`, so the fixed field of the image is a subextension in which
  almost all primes split completely; a nontrivial cyclic subextension of it would force
  `N C_M = C_K` by weak approximation, contradicting Layer 5's `herbrand_ge` — Janusz V §5,
  Artin–Tate — so the fixed field is `K`; no density needed — ⚠ do not import a
  Chebotarev-style argument here), functorial in `L`, and compatible with the local maps by
  construction (the route decision's payoff: this compatibility is `rfl`-adjacent, not a
  theorem chain).
- **The reciprocity law.** `θ_{L/K}(Kˣ) = 1` — the product formula
  `∏_v Art_{K_v}(x)|_L = 1` for `x ∈ Kˣ`. Pinned proof route: (i) cyclotomic extensions of
  `ℚ` by direct computation (Layer 4's anchor + the local roadmap's cyclotomic-orientation
  clause `χ_cyc(Art(u)) = u⁻¹`; the two conventions meet here, and a sign error anywhere
  upstream dies at this milestone — that is its job); (ii) general abelian `L/K` by Artin's
  crossing argument (reduction to the cyclotomic case using `kummer_le`/`herbrand_ge` for
  the index bookkeeping — Lang ANT X, Janusz V §5, Artin–Tate) — **no analytic input**.
- **The norm-residue isomorphism.** With Layer 5: `θ_{L/K}` descends to
  `C_K ⧸ N_{L/K} C_L ≃* Gal(L/K)` for finite abelian `L/K`. Functoriality package: towers
  (`θ_{M/K}` restricts to `θ_{L/K}`), base change `K'/K` (compatibility with norm on idele
  classes and restriction of automorphisms), the transfer-compatibility statement reserved
  for Layer 8. For finite **Galois** `L/K`: `C_K/N C_L ≃ Gal(L/K)^{ab}` (norm limitation's
  cheap half) — stated now, sharpened in Layer 7.
- **Ramification ⟺ conductor.** `v` (finite or real) is unramified in `L` ⟺ the local
  component of `N_{L/K} C_L` contains the full unit/positivity group at `v` ⟺ `v ∤ 𝔣(L/K)`,
  with `𝔣(L/K)` the conductor of the conventions table; the local-conductor compilation
  `𝔣(L/K) = ∏_v 𝔣_v` (local roadmap Layer 7; real places contribute exactly the ramified
  real places). ⚠ Higher-ramification/upper-numbering refinements stay in the local roadmap;
  what is global here is only the assembly.

### Layer 7: norm groups, the existence theorem, and ray class fields

- **The norm-group lattice.** `N(L/K) := Kˣ·N_{L/K}(I_L)/Kˣ ≤ C_K` for finite abelian
  `L/K`: containment-reversing bijection onto its image lattice, `N(LL') = N(L) ∩ N(L')`,
  `N(L ∩ L') = N(L)·N(L')`, and `L ↦ N(L)` injective — the "Takagi group" dictionary.
  **Norm limitation**: for finite Galois (indeed arbitrary finite) `L/K`,
  `N_{L/K} C_L = N_{L^{ab}/K} C_{L^{ab}}` where `L^{ab}` is the maximal abelian
  subextension — so norm groups see exactly abelian extensions.
- **The existence theorem.** Every open finite-index subgroup of `C_K` is `N(L/K)` for a
  unique finite abelian `L/K`. Route: by the Layer 2 neighborhood-basis lemma reduce to
  subgroups containing a `U_𝔪`-image; manufacture the extensions by Kummer towers over
  cyclotomic base changes (S-unit Kummer theory again; Neukirch ANT VI §6's route — no
  Lubin–Tate-style analytic objects exist globally, so unlike the local roadmap there is no
  formal-group alternative to even flag). ⚠ Openness is **not** automatic from finite
  index: the connected part contributes nothing (`D_K` is divisible, so it lies in every
  finite-index subgroup), but the profinite quotient `π₀(C_K) ≅ Gal(K^{ab}/K)` is not
  topologically finitely generated, so with choice it has dense finite-index subgroups,
  which pull back to non-open finite-index subgroups of `C_K` — the openness hypothesis is
  real; record the contrast with the local case, where open ⟺ finite-index-and-closed
  behaves differently.
- **Ray class fields.** `K_𝔪` := the abelian extension with `N(K_𝔪/K) = ` the `U_𝔪`-image
  (exists by the existence theorem, unique by the lattice): `Gal(K_𝔪/K) ≃* Cl_𝔪 K`
  (composing Layer 2's dictionary), ramification support `⊆ supp 𝔪`, and the **splitting
  law**: for `𝔭 ∤ 𝔪₀`, `Frob_𝔭 ↦ [𝔭]`, so `𝔭` splits completely ⟺ `𝔭 ∈ P_𝔪` (the
  `IsArithFrobAt` spelling). The ideal-theoretic Artin map `J^𝔪 ↠ Gal(L/K)` for arbitrary
  abelian `L/K` of conductor dividing `𝔪`, its kernel `P_𝔪·N(ideals of L)` (Takagi's
  classification in ideal terms — the classical statement form, e.g. for quadratic fields'
  genus theory). `K^{ab} = ⋃_𝔪 K_𝔪` and `Gal(K^{ab}/K) ≅ lim Cl_𝔪 ≅ C_K/D_K` — the
  profinite Artin map, surjective with kernel `D_K` (⚠ the conventions-table contrast with
  the local case).
- **The `ℚ` instance.** The ray class field of `ℚ` mod `(n)∞` is `ℚ(ζₙ)`: containment
  `ℚ(ζₙ) ⊆ ℚ_{(n)∞}` because Layer 4 exhibits the norm group of `ℚ(ζₙ)` above `U_{(n)∞}`,
  and equality by the degree count `#Cl_{(n)∞}(ℚ) = φ(n) = [ℚ(ζₙ) : ℚ]` — the
  pre-Kronecker–Weber form of Layer 9; consequently `Gal(ℚ^{ab}/ℚ) ≅ lim_n (ℤ/n)ˣ = Ẑˣ`.

### Layer 8: the Hilbert class field and the principal ideal theorem

Statement shapes aligned with Mathlib PR #40661's wanted-statements (report divergences
there).

- **The Hilbert class field.** `H = K_{(1,∅)}`: `Gal(H/K) ≃* ClassGroup (𝓞 K)`; `H/K`
  unramified at **all** places — `Algebra.Unramified (𝓞 K) (𝓞 H)` at the finite ones and
  `IsUnramifiedAtInfinitePlaces K H` at the real ones (the pin's two vocabularies; keeping
  them both first-class is why Layer 0 carried real places) — and maximal such; `𝔭` splits
  completely in `H` ⟺ `𝔭` principal; the class-number-one criterion `H = K ⟺ h_K = 1`.
  The **narrow** Hilbert class field `H⁺ = K_{((1),∞_ℝ)}` with `Gal(H⁺/K) ≅ Cl⁺ K` —
  unramified at finite places only. **Interface milestone (Multiquadratic Layer 3):** the
  genus field of a quadratic `K/ℚ` is the maximal subfield of `H` (resp. `H⁺` in the narrow
  variant) abelian over `ℚ`, and `Gal(H/K) ↠ Gal(K_gen/K)` realizes `Cl ↠ Cl/Cl²` — state
  this compatibility here, in the multiquadratic roadmap's vocabulary, closing the loop its
  Layer 3 opens.
- **Capitulation and the principal ideal theorem.** The extension map
  `ClassGroup (𝓞 K) →* ClassGroup (𝓞 H)` is the pin's `ClassGroup.extendedHom`; under the
  two reciprocity isomorphisms it is the group-theoretic **transfer**
  `Gal(H/K)^{ab} → Gal(H'/H)^{ab}` for `H'` the Hilbert class field of `H` (the
  Artin-reciprocity-transfer compatibility — a Layer 6 functoriality instance, stated here
  where it is consumed, with `Mathlib/GroupTheory/Transfer.lean` as the vocabulary).
  **Principal ideal theorem**: `ClassGroup.extendedHom (𝓞 K) (𝓞 H) = 1` — every ideal of
  `K` capitulates in `H`. Route: Artin's reduction plus Furtwängler's group-theoretic
  theorem — *for a finite group `G`, the transfer `G^{ab} → ([G,G])^{ab}` to the commutator
  subgroup is the trivial map* — which is a pure `GroupTheory/Transfer` target and should
  be developed as reusable group theory, not inlined. ⚠ `H'/K` is Galois but usually **not** abelian; the argument lives
  in `Gal(H'/K)` with `Gal(H'/H) = [G, G]` — set up the two-step tower carefully, it is
  where the classical literature hides its bookkeeping.

### Layer 9: Kronecker–Weber and the conductor–discriminant formula

- **Kronecker–Weber.** Every finite abelian `L/ℚ` embeds in `ℚ(ζₙ)` for some `n` — from
  Layer 7's `ℚ`-instance: the conductor of `L/ℚ` is some `(n)∞`-divisor, so
  `L ⊆ ℚ_{(n)∞} = ℚ(ζₙ)`. State both #40661 forms (`∃ n, Nonempty (L →ₐ[ℚ] CyclotomicField
  n ℚ)` and the `IsAlgClosed.lift`-range form), plus the sharp version: the least such `n`
  is the (finite part of the) conductor, and `𝔣(L/ℚ) = (n₀)·∞^{L real?}`-bookkeeping. ⚠ The
  "local Kronecker–Weber ⟹ global" textbook route (via ramification bounds) is subsumed
  here — the global proof through CFT is *shorter* than the elementary one once Layers 6–7
  exist; do not build the elementary route as a prerequisite (the stalled
  Akwardbro/RamificationGroup project aimed that way; cite, don't follow).
- **Conductor–discriminant, abelian case.** For finite abelian `L/K`:
  `d_{L/K} = ∏_{χ : Gal(L/K)^∨} 𝔣₀(χ)` — the product of the (finite parts of the)
  conductors of the ray-class characters of `Gal(L/K)` (via Layer 3's dictionary), where
  `𝔣₀(χ)` is the finite part of the conductor of `χ ∘ θ`. Route: localize — the different
  is the product of local differents (this globalization is the
  [number-field-arithmetic roadmap](../NumberFieldArithmetic/README.md)'s different/
  discriminant layer; consume it, and if this roadmap runs ahead, state the bridging lemma
  there-and-here per the Layer 2 protocol) — and apply the **local**
  conductor–discriminant formula of the local roadmap's Layer 3/7 material (Serre LF Ch. VI
  §3). Worked instance: over `ℚ`, `disc(ℚ(ζₙ))` matches the pin's
  `Cyclotomic/Discriminant.lean` values — an end-to-end consistency test of three
  developments. The **general** (non-abelian, Artin-conductor) formula belongs to the
  ArtinRepresentations Wave-2 roadmap; state the abelian scope explicitly.

### Layer 10: Grossencharacters, ring class fields, and the CM interface

- **Grossencharacters with `∞`-type.** The full character theory deferred from Layer 3:
  the `∞`-type of a Hecke character (its restriction to the identity component of the
  infinite ideles, a character `Π_w K_wˣ° → ℂˣ` of the form
  `Π_w x_w ↦ ∏ x_w^{a_w} |x_w|^{s_w}`-shape — state the classification of continuous
  characters of `ℝ_{>0}`, `ℝˣ`, `ℂˣ` first, as reusable lemmas); **algebraic (type `A₀`)
  characters** (all `s_w = 0`, integer exponents); the value-field of an `A₀`-character is
  a number field. The canonical examples: `‖·‖` (Layer 2), finite-order (Layer 3), and the
  `A₀`-characters of imaginary quadratic fields attached to CM — stated as the interface
  the AbelianVarieties/CM Wave-2 roadmap will instantiate (main theorem of CM is **theirs**;
  the character-side vocabulary is fixed here).
- **Ring class fields.** Orders `O ⊆ 𝓞 K` (conductor `𝔠 = [𝓞 K : O]`-annihilator ideal;
  ⚠ Mathlib has no order-in-number-field API at the pin — building `Picard O ≅` the
  ray-class-style quotient `J^{𝔠}/P_{ℤ,𝔠}` is part of this layer, on the Dedekind-generality
  Layer 1 machinery plus `ClassGroup O` for the non-maximal order, which Mathlib's
  `ClassGroup` already types); the **ring class field** `H_O` with
  `Gal(H_O/K) ≅ Pic O` via the existence theorem applied to the corresponding congruence
  subgroup; ramification support divides `𝔠`; `H_{𝓞 K} = H`. Scope: imaginary quadratic
  `K` gets the worked examples (Cox's program), but the definitions are stated for all `K`.
- **The `x² + ny²` capstone** (Cox, the book the master plan names for this interface): for
  `n ≥ 1` squarefree-appropriate, `p ∤ 2n` is of the form `x² + ny²` ⟺ `p` splits
  completely in the ring class field of `ℤ[√−n]` — with the fully explicit congruence cases
  (`n = 5`: `p ≡ 1, 9 (mod 20)`) as acceptance instances and the non-solvable-by-congruence
  cases (`n = 14`) stated through the ring-class-field criterion. This is simultaneously
  the CM interface's smoke test and the historical *raison d'être* of the theory.

### Layer 11: the global class formation and the local–global compatibilities

Consumes [ProfiniteCohomology](../ProfiniteCohomology/README.md) (continuous cohomology of
`G_K`, colimits over finite quotients) and reuses Layer 5's finite computations.

- **The formation.** `(Gal(K̄/K), colim_L C_L)` is a class formation: `H¹ = 1` (Layer 5),
  `H²(Gal(L/K), C_L)` cyclic of order `[L:K]` with compatible invariant maps
  `inv_{L/K} : H² ≃ (1/[L:K])ℤ/ℤ` — the **fundamental class** `u_{L/K}` with
  `inv(u) = 1/[L:K]`, constructed from the cyclic-cyclotomic case by the inflation
  bookkeeping the ClassFieldTheory blueprint sketches; interface in the
  `FiniteClassFormation` shape shared with the local roadmap. Tate–Nakayama at `r = −2`
  re-derives Layer 6's reciprocity isomorphism — stated as a **compatibility theorem** (the
  two constructions agree), which is the honest content of "the cohomological route" given
  the pinned spine.
- **Sum of local invariants.** The exact sequence
  `0 → H²(G_K, K̄ˣ) → ⊕_v H²(G_{K_v}, K̄_vˣ) → ℚ/ℤ → 0` in invariant-map coordinates: the
  reciprocity statement `∑_v inv_v(α) = 0` for global classes. ⚠ Brauer-group vocabulary
  beyond `Defs` is absent from Mathlib; state this layer in `H²`-of-Galois-cohomology terms
  (the sibling's), with the `Br K`-translation recorded as a milestone gated on Mathlib's
  Brauer development (track Whysoserioushah/BrauerGroup staging, per the master plan) —
  this is the **Honda–Tate-facing interface**: the CurvesOverFiniteFields Wave-2 roadmap
  needs exactly "division algebras over `K` ↔ local invariants summing to zero".
- **Hilbert reciprocity.** `∏_v (a, b)_v = 1` for `a, b ∈ Kˣ` — the product formula for
  Hilbert symbols (the local symbols are the local roadmap's Layer 8 bridge objects, shared
  with QuadraticFormInvariants). This is the **QuaternionArithmetic-facing interface** (its
  classification-by-ramification-sets consumes exactly this), and quadratic reciprocity
  over `ℚ` drops out as the worked example — proving Mathlib's `legendreSym` reciprocity
  *again*, from the global theory, as the designated end-to-end acceptance test.
- **`cd`-statements and what is not here.** `H³(Gal(L/K), C_L) = 1`-type statements and
  strict cohomological dimension of number fields: state only what the formation formalism
  yields directly; the full Poitou–Tate/duality theory of number fields (NSW VIII–IX) is
  **not** in this roadmap — it is the natural successor roadmap (a later wave), gated on this layer plus
  ProfiniteCohomology, and the boundary is recorded here so nobody reads Layer 11 as its
  down payment.

### Long horizon (direction, not this roadmap's deliverables)

Poitou–Tate duality and the full cohomology of number fields (NSW VIII–IX) on top of
Layer 11; explicit reciprocity laws and power-residue symbols (Neukirch ANT VI §8); the
Grunwald–Wang phenomenon (⚠ the classical trap: "an element that is an `n`-th power locally
everywhere is a global `n`-th power" is **false** at `n ≡ 0 (mod 8)` — Milne CFT VIII §1–2;
stated here only as a warning label, developed in the horizon); Tate's thesis (the
L-functions roadmap's route decision); the function-field/geometric theory; explicit class
field theory beyond CM (Stark, Hilbert's 12th).

## Worked examples (acceptance criteria)

Discharge alongside the layers; each catches a specific failure mode (vacuous object, wrong
normalization, dropped real place, unit-obstruction error).

- **`Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`, recovering Dirichlet characters** (Layers 1/3/4): the ray
  class group of `ℚ` mod `n∞` is `(ℤ/n)ˣ` — with the `∞`-less contrast
  `Cl_{(n)}(ℚ) ≃* (ZMod n)ˣ/{±1}` as the unit-obstruction check — and the induced bijection
  {finite-order Hecke characters of conductor `∣ (n)∞`} ≃ `DirichletCharacter ℂ n`
  compatible with conductors.
- **Sign surjectivity and its failure for units** (Layers 0–1): `ℚ(√3)` has
  `Cl(ℚ(√3)) = 1` but `Cl⁺(ℚ(√3)) ≅ ℤ/2` — the fundamental unit `2 + √3` is totally
  positive, so the sign map on units is **not** surjective while (Layer 0) the sign map on
  `Kˣ` is. Contrast: `ℚ(√2)` has `Cl⁺ = Cl = 1` (the unit `1 + √2` has norm `−1`). These
  two fields are the smallest discriminating pair for narrow-class implementations, and the
  `t − 1 = 1` narrow 2-rank of `ℚ(√3)` is the multiquadratic roadmap's Layer 3 test case.
- **Splitting in `ℚ(ζₙ)`** (Layer 4): `p ∤ n` splits completely in `ℚ(ζₙ)` ⟺ `p ≡ 1
  (mod n)`; the Frobenius at `p` is `[p]`; `[ℚ(ζₙ) : ℚ] = φ(n)` with ramification exactly
  at `p ∣ n` (and at `∞` for `n > 2`).
- **The norm-index instance** (Layer 5): `[C_ℚ : N C_{ℚ(√5)}] = 2`, and Hasse's norm
  theorem at `ℚ(√5)/ℚ`: a rational is a norm iff it is a local norm at every place, the
  condition at any single place being implied by the remaining ones via the Hilbert product
  formula — with the biquadratic **failure** recorded as the non-theorem.
- **Hilbert class field of `ℚ(√−5)`** (Layer 8): `h = 2`, `H = ℚ(√−5, i)`
  (= the genus field — the Multiquadratic interface instance), and the classical criterion:
  for `p ≠ 2, 5`, `p = x² + 5y²` ⟺ `p ≡ 1, 9 (mod 20)` ⟺ `p` splits completely in `H`.
- **Kronecker–Weber** (Layer 9): every abelian `L/ℚ` lies in a `ℚ(ζₙ)`; sharply,
  `ℚ(√−1) ⊆ ℚ(ζ₄)`, `ℚ(√2) ⊆ ℚ(ζ₈)`, `ℚ(√5) ⊆ ℚ(ζ₅)` with the least levels `4, 8, 5` —
  the conductor computation in its smallest instances.
- **Conductor of `ℚ(√d)`** (Layers 7/9): the conductor of `ℚ(√d)/ℚ` is
  `(|d_K|)` for `d > 0` and `(|d_K|)·∞` for `d < 0`, where `d_K = disc(ℚ(√d))`. ⚠
  Orientation check built in: the real place ramifies exactly when `d < 0` (complex
  conjugation is the nontrivial automorphism), so the infinite part appears exactly for
  imaginary quadratic fields, while the finite part is `|d_K|` in both cases (Janusz
  VI §1) — an implementation that yields `∞ ∤ 𝔣` for `ℚ(i)` has the real-place convention
  backwards. Conductor–discriminant here reads `|d_K| = 1 · 𝔣₀(χ_d)`: the conductor of the
  quadratic character equals the absolute discriminant — the `legendreSym`-facing
  statement.
- **Hilbert reciprocity ⟹ quadratic reciprocity** (Layer 11): `∏_v (p, q)_v = 1` unpacked
  at odd primes `p ≠ q` recovers `legendreSym p q * legendreSym q p = (−1)^{(p−1)(q−1)/4}`,
  with the local roadmap's `(−1,−1)_2 = −1` table entry closing the `v = 2` case. Mathlib
  already proves quadratic reciprocity; deriving it *again* through eleven layers is the
  point — it certifies every normalization simultaneously.
- **`x² + 14y²`** (Layer 10): `Cl(ℤ[√−14]) ≅ ℤ/4`; `p = x² + 14y²` ⟺ `p` splits completely
  in the ring class field `H_{ℤ[√−14]}` — with the explicit degree-8 field and the
  no-congruence-criterion caveat stated (Cox's motivating non-example).

## Ordering and parallelism

Four lanes can run concurrently from day one: **(A)** Layers 0 → 1 (moduli, ray classes —
pin-only); **(B)** Layer 2 (ideles — pin-only, coordinate with PR #40735 and FLT); **(C)**
Layer 4 (cyclotomic anchor — pin-only, mostly consuming Roblot's files); **(D)** Layer 5's
S-idele/S-unit cohomology (pin's finite `groupCohomology` plus the local roadmap's Layer 5,
itself parallel-safe). Layer 3 needs 2 (and 1 for the dictionary). Layer 6 needs 4 + 5 and is
the first hard consumer of the local roadmap's Layer 7 — it is the synchronization point of
the two roadmaps; everything before it is unconditional. Layer 7 needs 5 + 6; Layer 8 needs
7 (plus `GroupTheory/Transfer` work that can be developed independently *now* — the
Furtwängler theorem is a free-standing group-theory target); Layer 9 needs 6 + 7 (+ the
NumberFieldArithmetic different-globalization for conductor–discriminant); Layer 10 needs 7
(+ 3); Layer 11 needs 5 + 6 + the ProfiniteCohomology sibling, and supplies the Wave-2
interfaces. The worked examples are distributed across all layers and none is deferrable to
the end.

## References

- J. Neukirch, *Algebraic Number Theory* (Grundlehren 322) — **the primary source for the
  pinned route**: Ch. IV (abstract class field theory: the Frobenius-lift reciprocity
  formalism, the class field axiom; §§4–6 are Layer 5–6's skeleton), Ch. V (local theory —
  consumed via the local-fields roadmap), Ch. VI (global: §1 ideles and idele classes =
  Layer 2, §2 ideles in field extensions = Layer 5's semi-local dictionary, §3 the Herbrand
  quotient of the idele class group = `herbrand_ge`, §4 the class field axiom = `kummer_le`,
  §5 the global reciprocity law = Layer 6, §6 global class fields = Layer 7, §7 the
  ideal-theoretic version = Layers 1/7's dictionary, §8 power residues = horizon). Held
  locally.
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed. (GSM 7) — **the layer-decomposition
  source** (the most elementary complete treatment): Ch. III (decomposition groups, the
  Frobenius, the Artin map for abelian extensions), Ch. IV §1 (moduli and ray classes —
  Layer 0–1's statement forms), Ch. V (class field theory: §1 cyclic cohomology, §§2–4 the
  norm-index computations, §5 reciprocity, §6 ideal groups/conductors/class fields, §§7–9
  the existence theorem, §§10–11 consequences and the conductor theorem, §12 the Hilbert
  class field), Ch. VI (§1 the conductor of `ℚ(√d)`, §3 the extended = narrow class group —
  Layer 1's classical source). Held locally.
- S. Lang, *Algebraic Number Theory*, 2nd ed. (GTM 110) — Ch. VII (ideles and adeles,
  §3 ideles), Ch. IX (norm-index computations), Ch. X (the Artin symbol, reciprocity, and
  the crossing argument — Layer 6's route (ii)), Ch. XI (the existence theorem and its
  local corollaries), Ch. XIV (Tate's thesis — the L-functions sibling's fork). Held
  locally.
- J. S. Milne, *Class Field Theory* (v4.03, course notes) — modern statements of both
  routes: Ch. V (global statements: §1 ray class groups, §3 ideal-theoretic main theorems,
  §§4–5 idelic main theorems — the statement-form cross-check for Layers 1/6/7), Ch. VII
  (proofs: §§2–5 idele cohomology and the inequalities, §6 the algebraic `≤`-proof pinned
  in Layer 5, §9 existence), Ch. VIII (complements: §§1–2 Grunwald–Wang ⚠, §3 the Hasse
  norm principle and its biquadratic failure, §4 the fundamental exact sequence = Layer
  11's sum-of-invariants). Held locally.
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed. — Ch. VIII
  (cohomology of global fields: the global formation, `H²`-invariants — Layer 11's
  normalization source, in the same edition the local roadmap pins for its Ch. VII
  citations). Held locally.
- D. A. Cox, *Primes of the Form x² + ny²*, 2nd ed. — §§5–6 (the Hilbert class field and
  genus theory instances), §§7–9 (orders, ring class fields, `x² + ny²` — Layer 10's
  program). **On the acquisition list** (the master plan's reference queue); page-precise
  citations to be added when held.
- L. C. Washington, *Introduction to Cyclotomic Fields*, 2nd ed. (GTM 83) — Ch. 3–4
  (cyclotomic discriminants/conductor–discriminant over `ℚ`; the source Mathlib's
  `Cyclotomic/Galois.lean` already cites). **On the acquisition list.**
- E. Artin, J. Tate, *Class Field Theory* — the crossing argument in its original
  arrangement, the group-theoretic principal ideal theorem, and the class-formation
  axiomatics Layer 11 mirrors. **On the acquisition list.**
- Cassels–Fröhlich (eds.), *Algebraic Number Theory* — Ch. VII (Tate, "Global class field
  theory": the idelic statements Layers 2/6–7 cross-check against), the exercises (incl.
  the classical Hasse-norm counterexample), and Ch. XV (Tate's thesis — the L-functions
  sibling's fork). Held locally (a scanned copy, in the gq2 reference collection alongside
  Neukirch and NSW).
- M. I. de Frutos-Fernández, "Formalizing the Ring of Adèles of a Global Field"
  ([ITP 2022](https://drops.dagstuhl.de/storage/00lipics/lipics-vol237-itp2022/LIPIcs.ITP.2022.14/LIPIcs.ITP.2022.14.pdf),
  [arXiv:2203.16344](https://arxiv.org/abs/2203.16344)) and S. Mercuri, "Formalising the
  local compactness of the adele ring" ([arXiv:2405.19270](https://arxiv.org/abs/2405.19270),
  AFM 2025) — the formalization prior art for Layer 2.

## Provenance and coordination

- **Mathlib adele/CFT upstreamers.** The active authors whose in-flight work this roadmap
  tracks by name: **T. Browning** (tb65536; PR #40735 — the idele class group and, stated
  intent, Hecke L-functions: contact before Layers 2–3, adopt his shapes, and offer the
  Layer 2–3 material as upstream follow-ups), **S. Mercuri** (adele topology PRs #36404/
  #36275; the AFM 2025 paper), **F. A. E. Nuccio** (PR #40661 Hilbert-class-field wanted
  statements — Layers 8–9 alignment; also the mariainesdff-collaboration context),
  **M. I. de Frutos-Fernández** (the Lean 3 ideles development and the Mathlib
  `FiniteAdeleRing`/`AdicValuation` substrate — coordinate before Layers 2 and 7 per the
  root README's coordination rule), **X. Roblot** (cyclotomic Galois dictionary, Layer 4's
  substrate; the RamificationInertia refactor wave), **F. Barroero** (places, product
  formula, S-integers #40848), **R. Brasca** (capitulation `ExtendedHom`; DirichletDensity
  #41765 on the L-functions side), **D. Angdinata** (S-integers). Before starting Layers 0
  and 6–7, announce intentions per the root README's claims process, and file the Zulip
  note in `#maths` — the audit found **no** existing thread on ray class groups or global
  reciprocity, so the announcement creates the coordination venue.
- **kbuzzard/ClassFieldTheory** (Apache-2.0). Same three standing obligations as the
  local-fields roadmap: interface alignment (`FiniteClassFormation`, Herbrand conventions,
  Tate-cohomology spellings on the first bump), citation (their `_4_global.tex` skeleton is
  cited at Layers 5 and 11, including the route divergence pinned in the conventions
  table), refactor-on-landing (if their global half acquires Lean code that reaches
  Mathlib, Layer 11's statements are the refactor surface; Layers 5–7 remain independent
  developments of the same mathematics — cite, coordinate, and diverge only with a recorded
  reason). Their working channel is private; repository state is the public proxy, and
  decision-critical questions go to `#maths` or by direct contact.
- **FLT** (ImperialCollegeLondon/FLT, Apache-2.0). Layer 2's compactness milestones
  duplicate mathematics FLT has already proved (`cocompact`, Fujisaki): per the root
  README, coordinate with the FLT maintainers before implementing — the preferred outcome
  is upstreaming their statements to Mathlib with the Tau Ceti layer consuming the result,
  the fallback an independent proof citing theirs; do not copy code without agreement.
  FLT's CFT axiom surface today is local-only, so no reciprocity-level coordination is
  needed yet; flag Layer 6 to them when it lands (their future global-Langlands chapters
  will want it).
- **Sibling roadmaps.** [LocalFields](../LocalFields/README.md): the consumption contract
  is exactly its Layer 7 "FLT-facing bundle" plus Layer 2 norms, Layer 3
  different/Hasse–Arf, Layer 5 Herbrand, Layer 8 Hilbert symbols; the arithmetic-Frobenius
  and `Art(π) = Frob` normalizations are shared pins, and the cyclotomic-orientation clause
  (`χ_cyc(Art(u)) = u⁻¹`) is the single statement both roadmaps must agree on (its Layer 7,
  our Layer 6). [ProfiniteCohomology](../ProfiniteCohomology/README.md): Layer 11 only.
  [NumberFieldArithmetic](../NumberFieldArithmetic/README.md): owns the global↔local bridge
  and the different/discriminant globalization; the shared-lemma protocol is stated in
  Layer 2. [LFunctions](../LFunctions/README.md): owns everything analytic (Hecke L-series,
  functional equations, densities, **Chebotarev**); this roadmap's density-free discipline
  exists so that the dependency points strictly from there to here; the Hecke-character
  interface (Layer 3's unitary normalization and conductors) is frozen in coordination with
  it, and the master plan's Tate's-thesis-vs-theta route decision is **theirs** (owner
  decision 4), consuming our `C_K` either way. [Multiquadratic](../Multiquadratic/README.md)
  (merged): the narrow class group (Layer 1) and the genus-field compatibility (Layer 8)
  are built to its Layer 3's stated needs. Wave-2 consumers (QuaternionArithmetic:
  Layer 11's Hilbert reciprocity; CurvesOverFiniteFields/Honda–Tate: Layer 11's
  sum-of-invariants; AbelianVarieties/CM: Layer 10's `A₀`-characters and ring class
  fields) — each interface is a named milestone above, so those roadmaps can cite a
  specific target rather than "global CFT".
- **Master-plan deltas (audit wins).** Three refinements to the plan's §4 entry, per its
  own ground rule: (i) the idele class group is not "Mathlib adeles" to consume but an
  **open PR** (#40735) to align with; (ii) ProfiniteCohomology is a Layer-11-only
  dependency, not a blanket one — the reciprocity core runs on the pin's finite
  `groupCohomology`; (iii) two live artifacts the plan predates — the ClassFieldTheory
  global blueprint chapter and the #40661 wanted-statements file — now pin the external
  statement shapes for Layers 5/8/9/11.
