# Roadmap: global class field theory

Mathlib now has the full adele ring of a number field, `NumberField.AdeleRing R K =
InfiniteAdeleRing K × FiniteAdeleRing R K` (Salvatore Mercuri, María Inés de Frutos-Fernández;
`Mathlib/NumberTheory/NumberField/AdeleRing.lean`), built on de Frutos-Fernández's
`FiniteAdeleRing`/`adicCompletion` stack and Anatole Dedecker's restricted products, with
Fabrizio Barroero's finite places and product formula and, new at our pin, Xavier Roblot's
Galois/Dirichlet-character dictionary for cyclotomic fields
(`Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean`) and Andrew Yang's arithmetic
Frobenius elements (`Mathlib/RingTheory/Frobenius.lean`). What it does not have is any of
global class field theory's own objects: no ray class groups or moduli (verified at the pin:
zero matches for ray or narrow class anywhere), no narrow class group, no idele class group
(being defined right now in [PR #40735](https://github.com/leanprover-community/mathlib4/pull/40735)),
no Hecke characters or Grossencharacters (none in any Lean 4 development we could find), no
global Artin map, no reciprocity law, no conductors of abelian extensions, no existence
theorem, no Hilbert class field (now a `theorem_wanted` file in
[PR #40661](https://github.com/leanprover-community/mathlib4/pull/40661)), no Kronecker–Weber.
This roadmap builds that theory: moduli and ray class groups (including the narrow class group
that the [multiquadratic roadmap](../Multiquadratic/README.md) already wants), the idele class
group with its topology and its functoriality in finite extensions, the archimedean local
reciprocity data that the local-fields roadmap deliberately omits, Hecke characters with the
finite-order to ray-class dictionary, the global Artin map assembled from local reciprocity
maps, the reciprocity law and the existence theorem, conductors, the Hilbert class field with
the principal ideal theorem, Kronecker–Weber, the abelian conductor–discriminant formula, ring
class fields, and the global class formation, each layer with its complete basic theory.

Global class field theory has one substantial prior formalization effort: María Inés de
Frutos-Fernández's Lean 3 development
([mariainesdff/ideles](https://github.com/mariainesdff/ideles), ITP 2022,
[arXiv:2203.16344](https://arxiv.org/abs/2203.16344)) defined the idele class group of a global
field, **stated** the main theorems of global CFT, and proved `ClassGroup` is an explicit
quotient of the idele class group; its adelic substrate was ported and is today's Mathlib
stack, but the CFT statements were not. The active
[kbuzzard/ClassFieldTheory](https://github.com/kbuzzard/ClassFieldTheory) project has global
ambitions at blueprint level: `blueprint/src/_4_global.tex` (720 lines) develops the
cohomological route, namely the idele class group as a Galois module, S-ideles, the
Herbrand-quotient computation through S-units, a Dirichlet-density route to the norm-index
upper bound, and a prose sketch of fundamental classes, but no Lean code for the global half
exists there today (the repository tree is `Cohomology/`, `IsNonarchimedeanLocalField/`,
`LocalCFT/` only). [FLT](https://github.com/ImperialCollegeLondon/FLT) has proved, sorry-free,
the two adelic compactness results this roadmap needs: `NumberField.AdeleRing.cocompact`
(compactness of `𝔸_K/K`) and Fujisaki's lemma (`FLT/DivisionAlgebra/Finiteness.lean`, the
idelic compactness that subsumes class-number finiteness and the unit theorem). This roadmap
does not yet choose an independent implementation over those active lines. At the review
refresh recorded in §Provenance no relevant author had been contacted, so the coordination
requirements stated there apply before implementation: prefer consuming or contributing
reusable results upstream; use an independent Tau Ceti proof only after recording why it does
not fork the API. The mathematical targets below are pinned in the pin's vocabulary and remain
convention-compatible with all three projects.

Suggested home: `TauCeti/NumberTheory/ClassFieldTheory/Global/`, with subdirectories per layer
(`Modulus/`, `RayClass/`, `IdeleClass/`, `Archimedean/`, `HeckeCharacter/`, `NormIndex/`,
`Reciprocity/`, `Existence/`, `RayClassField/`, `HilbertClassField/`, `KroneckerWeber/`,
`Grossencharacter/`, `ClassFormation/`). Justification:
`Mathlib/NumberTheory/ClassFieldTheory/Local/Basic.lean` is the path erdOne's mathlib fork
branch `erd1/LCFT` already stakes out for class field theory upstream (see the local-fields
roadmap's audit), so `NumberTheory/ClassFieldTheory/Global/` mirrors the namespace Mathlib
itself is converging on and makes eventual upstreaming a file move; it also sits beside the
prospective `ClassFieldTheory/Local/` home of the local roadmap's late layers. The purely
Dedekind-domain material of Layers 0 and 1 should be written so that its eventual Mathlib home
could be next to `RingTheory/ClassGroup/`; note the intended split in file docstrings.

## Prerequisites, and who owns what

This roadmap is part of the coordinated 2026-07-30 family, and it consumes three of its
siblings. All three are still open pull requests today, and an open pull request is not a
roadmap a contributor can build against. **This roadmap therefore merges only after all three
have merged**, and the merge commit must carry the rebase described here:

| supplier | pull request | what this roadmap consumes | link after the rebase |
|---|---|---|---|
| Local Fields | [#2](https://github.com/roed-math/TauCetiRoadmap/pull/2) | nonarchimedean local reciprocity (its Layer 7), unramified norm computations (Layer 2), differents and local conductors (Layer 3), the local Herbrand quotient (Layer 5), local Hilbert symbols (Layer 8) | `../LocalFields/README.md` |
| Number Field Arithmetic | [#9](https://github.com/roed-math/TauCetiRoadmap/pull/9) | the decomposition/inertia/Frobenius API, the ideal-theoretic Artin symbol and its multiplicativity, the cyclotomic Frobenius computation, the completion dictionary at finite places, the globalization of the different | `../NumberFieldArithmetic/README.md` |
| Profinite Cohomology | [#1](https://github.com/roed-math/TauCetiRoadmap/pull/1) | continuous cohomology of `G_K` and colimits over finite quotients, used by Layer 11 and nothing else | `../ProfiniteCohomology/README.md` |

At that rebase, replace every pull-request link by the relative path above, check that each
link resolves, and settle the
root-list number and the aggregate import in `TauCetiRoadmap.lean` against the family
integration branch rather than against the numbering in this branch.

The [L-functions roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/8) is **not** a
prerequisite. It consumes Layer 3's Hecke characters and owns everything analytic: Hecke
L-series, functional equations, Chebotarev and every density theorem. None of that is used
here, and the build below is deliberately density-free, precisely so that the dependency runs
in one direction only. Its interfaces (the unitary normalization and the conductor of a Hecke
character) are agreed with that roadmap, not imported from it.

The division of labor with Number Field Arithmetic needs stating precisely, because both
roadmaps talk about the Artin symbol. **Number Field Arithmetic owns** the ideal-theoretic
Artin symbol: the abelian collapse of the Frobenius conjugacy class, the map on ideals prime
to the ramified set, its multiplicativity, the restriction and tower formulas, and the
cyclotomic computation identifying the arithmetic Frobenius at `p ∤ n` with `[p]` under
`galEquivZMod`. **This roadmap consumes that map** and owns everything that is class field
theory about it: that it factors through a ray class group, its kernel, its surjectivity, its
agreement with the idelic Artin map, its dependence on the conductor, the reciprocity law, and
the classification of abelian extensions by ideal groups. Layers 4, 6 and 7 below are written
to that boundary; none of them redefines the symbol.

The local-fields roadmap is deliberately nonarchimedean throughout: its objects are
`IsNonarchimedeanLocalField`s. Global class field theory needs local reciprocity at the real
and complex places too, so that theory is built here, in Layer 2C, and is not imported from
anywhere.

This roadmap **supplies**: the narrow class group and the genus-field compatibility to
[Multiquadratic](../Multiquadratic/README.md), whose Layer 3 names the narrow class group as a
prerequisite; Hecke characters and their conductors to the L-functions roadmap; and the
reciprocity interfaces of the Wave-2 roadmaps ("Wave 2" here and below means the planned
second wave of LMFDB-background roadmaps, following the wave this roadmap belongs to),
specifically the Hilbert reciprocity product formula for QuaternionArithmetic's
classification, the invariant maps for Honda–Tate's Brauer data, and ring class fields for CM
theory.

## Standing hypotheses

The standing setting is a number field `K`: `[Field K] [NumberField K]`, with `𝓞 K` its ring
of integers, `HeightOneSpectrum (𝓞 K)` its finite places, and `InfinitePlace K` its infinite
places. Spell hypotheses out; do not bundle them. Abelian extensions enter unbundled as
`[Algebra K L] [IsAbelianGalois K L]` (the pin's `Mathlib/FieldTheory/Galois/Abelian.lean`
class, also the vocabulary of PR #40661), with `[Module.Finite K L]` when finiteness is meant.
Infinite abelian extensions (`K^{ab}`, the ray class tower) are handled through the
Krull-topology and `IsGaloisGroup` API as in the local roadmap, and inside a fixed algebraic
closure as described in the conventions table.

Three levels of generality appear, and the split between them is deliberate.

1. **Dedekind-generic.** The finite-part machinery of Layers 0 and 1 is stated for `(R, K)`
   with `[CommRing R] [IsDedekindDomain R] [Field K] [Algebra R K] [IsFractionRing R K]`,
   matching Mathlib's own `AdeleRing R K` parametrization: the finite part of a modulus,
   fractional ideals prime to it, the congruence subgroup of `Kˣ`, the ray class quotient, the
   transition maps, the moving lemma, and the exact sequence. All of this is free at that
   generality and is what ring class groups (Layer 10B) and any future function-field work
   reuse.
2. **Finiteness.** An arbitrary Dedekind domain has neither finite residue rings nor a finite
   class group, so ray class groups are not finite at that generality and the cardinality
   formula of Layer 1 does not hold there. Finiteness statements are therefore proved either
   for number fields or under an explicit hypothesis package, `Finite (R ⧸ 𝔪₀)ˣ` together with
   `Finite (ClassGroup R)`, stated once and used by name. Choose the hypothesis-package form
   where it costs nothing, since Layer 10B's orders need it.
3. **Number fields.** Everything involving real places, and all of class field theory proper
   (Layers 2C and 4 through 11), is stated for number fields only.

Nonmaximal orders are **not** covered by the Dedekind-generic statements: an order in a number
field is usually not integrally closed, hence not Dedekind, and its invertible-ideal theory is
built separately in Layer 10B. The function-field case of global class field theory is out of
scope (Mathlib's `AdeleRing` docstring itself warns that the definition is wrong for function
fields); do not add speculative function-field hypotheses to number-field theorems.

Never assume `K` totally imaginary, never assume trivial class group, and never let a
statement silently require that there are no real places. The narrow-versus-wide distinction
and the unit-sign obstructions are what several downstream consumers need (Multiquadratic
genus theory above all), and the literature is full of totally-imaginary shortcuts. Statements
must carry their true hypotheses.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| modulus | `Modulus K`, a structure with `finitePart : Ideal (𝓞 K)` together with a proof that it is nonzero, and `infinitePart : Finset {w : InfinitePlace K // w.IsReal}`. Write `𝔪 = (𝔪₀, 𝔪∞)`. The finite part has a second face as a finitely supported exponent function on `HeightOneSpectrum (𝓞 K)`, with `Ideal.factorization`-compatibility lemmas translating the two; the prototype is in `Suggested.lean`. Complex places never divide a modulus, which is why the infinite part is typed by real places rather than carrying a side condition. At Dedekind generality only the finite part exists | Layer 0; Janusz IV §1 |
| divisibility of moduli | `𝔪 ∣ 𝔫` means `𝔪₀ ∣ 𝔫₀` as ideals (equivalently the exponent at every finite place weakly increases) together with `𝔪∞ ⊆ 𝔫∞`. Under this orientation the transition map runs `Cl_𝔫 ↠ Cl_𝔪`, the larger modulus mapping onto the smaller. `gcd(𝔪,𝔫) = (𝔪₀ ⊔ 𝔫₀, 𝔪∞ ∩ 𝔫∞)` and `lcm(𝔪,𝔫) = (𝔪₀ ⊓ 𝔫₀, 𝔪∞ ∪ 𝔫∞)`, with the exponentwise min/max descriptions as lemmas | Layer 0 |
| multiplicative congruence | `x ≡ 1 mod* 𝔪` for `x ∈ Kˣ`: at each `v ∣ 𝔪₀`, `ord_v(x − 1) ≥ ord_v(𝔪₀)`; at each `w ∈ 𝔪∞`, `0 < embedding_of_isReal w x`. Under the pin's multiplicative `ℤᵐ⁰`-valued `HeightOneSpectrum.valuation`, higher order of vanishing means *smaller* value, so this additive `≥` is the multiplicative `≤`. ⚠ This is a multiplicative condition on `Kˣ`, **not** membership in `1 + 𝔪₀` inside `𝓞 K`; the two agree only for integral `x` prime to `𝔪₀` | Layer 0 |
| ray class group | `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`: fractional ideals with support disjoint from `𝔪₀`, modulo principal ideals `(x)` with `x ≡ 1 mod* 𝔪`. `Cl_{((1),∅)} ≃* ClassGroup (𝓞 K)` by a named isomorphism, not by definitional accident | Layer 1 |
| narrow class group | `Cl⁺ K := Cl_𝔪 K` for `𝔪 = ((1), all real places)`. Equivalently `J/P⁺` with `P⁺` the totally positive principal ideals; the equivalence is a named lemma. "Narrow" never means "totally positive units exist"; the degenerate cases (no real places gives `Cl⁺ = Cl`) are instances, not separate definitions | Layer 1; Janusz VI §3 ("extended class group") |
| idele group, idele class group | `IdeleGroup R K := (AdeleRing R K)ˣ` with the units topology (the embedding `x ↦ (x, x⁻¹)`), and `IdeleClassGroup R K := IdeleGroup R K ⧸ principal ideles`. Adopt the shapes, names, and generality of PR #40735 (T. Browning) verbatim, so that the Tau Ceti development refactors onto it the day it merges. ⚠ The idele topology is not the subspace topology from `𝔸_K` (the pin's `Topology/Algebra/IsOpenUnits.lean` records exactly this); Mathlib's `Units` topology gets it right automatically, so never re-topologize | Layer 2A; PR #40735 |
| congruence subgroup of the ideles | one subgroup, used everywhere. For `𝔪 = (𝔪₀, 𝔪∞)` with `n_v = ord_v 𝔪₀`, `IdeleCongruenceSubgroup 𝔪 ≤ IdeleGroup (𝓞 K) K` is the product of: `1 + 𝔭_v^{n_v}` at finite `v ∣ 𝔪₀`; `𝒪_vˣ` at finite `v ∤ 𝔪₀`; `ℝ_{>0}` at real `w ∈ 𝔪∞`; all of `ℝˣ` at real `w ∉ 𝔪∞`; all of `ℂˣ` at complex `w`. Write `U_𝔪` for it in prose. Its image in `C_K` is `RaySubgroup 𝔪`, and the dictionary is exactly `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. ⚠ Never append a second unnamed group of infinite components to `U_𝔪`: the infinite components are already in the definition. The connected component `D_K` enters separately, through `D_K ≤ RaySubgroup 𝔪` for every `𝔪` | Layer 2A |
| idele norm | `‖·‖ : IdeleGroup → ℝ_{>0}`, the product of the normalized local absolute values: at finite `v`, `‖π_v‖ = 1/q_v`, matching `FinitePlace` and the local roadmap's `‖x‖_K = q^{−v_K(x)}`; at real `w` the usual absolute value; at complex `w` the **square** of the modulus (the `InfinitePlace.mult`-weighted convention of the pin's `ProductFormula.lean`). Product formula: `‖·‖ = 1` on principal ideles. `C_K^1 := ker ‖·‖` on classes | Layer 2A; `Mathlib/NumberTheory/NumberField/ProductFormula.lean` |
| nonarchimedean local normalizations | imported from the local-fields roadmap's pinned table: normalized valuation `v(π) = 1`, residue cardinality `q_v`, **arithmetic Frobenius** `x ↦ x^{q_v}` as the distinguished generator, `Art_{K_v}(π) = Frob_v` | LocalFields Layers 0/2/7 |
| archimedean local normalizations | built here, in Layer 2C, since the local roadmap is nonarchimedean. `Art_ℂ : ℂˣ → Gal(ℂ/ℂ)` is trivial; `Art_ℝ : ℝˣ → Gal(ℂ/ℝ)` sends positive elements to `1` and negative elements to complex conjugation, so `ker Art_ℝ = ℝ_{>0} = N_{ℂ/ℝ}(ℂˣ)`. Invariants: `inv_ℂ = 0` and the nontrivial class at a real place has invariant `1/2`. Hilbert symbols: `(a,b)_ℂ = 1` always, and `(a,b)_ℝ = −1` exactly when `a < 0` and `b < 0` | Layer 2C |
| Artin map, direction and normalization | finite level: `θ_{L/K} : C_K ⧸ N_{L/K} C_L ≃* Gal(L/K)` for finite abelian `L/K`, **defined** as the compilation of local maps, `θ((x_v)_v) = ∏_v Art_{K_v}(x_v)∣_L`. Normalization: for `v` unramified in `L` and `x` the class of an idele that is a uniformizer at `v` and a unit at every other place, `θ(x) = Frob_v`, arithmetic. Profinite level: `Art_K : C_K →* Gal(K^{ab}/K)` continuous and **surjective**, with kernel the identity component `D_K`. ⚠ This is the opposite failure mode from the local case, where `Art_{K_v}` is injective and not surjective; porting a local statement verbatim is the classic error | Layers 6–7; Neukirch ANT VI §5 |
| ideal-theoretic Artin map | the map `J^𝔪 →* Gal(L/K)`, `𝔭 ↦ Frob_𝔭` in the pin's `IsArithFrobAt`/`arithFrobAt` vocabulary, is **defined and proved multiplicative in the Number Field Arithmetic roadmap**, and consumed here. Its agreement with the idelic map, under the Layer 2A dictionary and for `𝔪` divisible by the conductor, is a named theorem of Layer 6 | NumberFieldArithmetic Layer 2; Layers 6–8 |
| Hecke character | a continuous homomorphism `χ : IdeleClassGroup (𝓞 K) K →* ℂˣ` (Mathlib's `ContinuousMonoidHom`). The dictionary: `χ` has finite order iff `ker χ` is open iff `χ` factors through a ray class group `Cl_𝔪 K`, each equivalence a named theorem. "Ray class character" is the composite notion, never an independent definition. Unitary characters and the decomposition `χ = χ_u · ‖·‖^s` are Layer 3; algebraic characters and infinity types are Layer 10A | Layer 3 |
| conductor of a character | two notions, because one does not cover the other. The **finite conductor ideal** of an arbitrary continuous quasicharacter is assembled from the depths at which its nonarchimedean local components become trivial on principal units. The **ray conductor modulus** is defined for finite-order characters, and more generally for characters trivial on the connected component of the archimedean part: it is the smallest `𝔪` with `U_𝔪 ⊆ ker χ`, and its infinite part records the real places where the local sign component is nontrivial. ⚠ A general quasicharacter has no ray conductor: `‖·‖^s` is not trivial on any `U_𝔪`. Over `ℚ`, `DirichletCharacter.conductor` matches the finite part, and parity determines the infinite part | Layer 3 |
| conductor of an abelian extension | of a finite abelian `L/K`: the smallest modulus `𝔣` with `U_𝔣 ⊆ Kˣ · N_{L/K}(I_L)`, equivalently the modulus assembled from the local conductors of the local-fields roadmap's Layer 7 together with the ramified real places. Both faces are stated and their agreement is a theorem | Layer 7 |
| inequality naming | the two norm-index bounds are named by content, `herbrand_ge` (`[C_K : N C_L] ≥ [L:K]`, cyclic, via the Herbrand quotient) and `kummer_le` (`≤`, via Kummer theory), and never "first" and "second": the literature disagrees on the ordinals (the ClassFieldTheory blueprint's "first inequality" is the density-route `≤`, Neukirch's First is the `≥`), and a name that flips meaning between sources is a defect | Layer 5 |
| ambient closure | fix one algebraic closure `K̄` (a `[IsAlgClosure K K̄]` hypothesis, or `AlgebraicClosure K`) at the start of Layers 7 through 11 and construct every abelian extension as an `IntermediateField K K̄`. Composita, intersections, `K^{ab} = ⨆_𝔪 K_𝔪`, the tower of ray class fields, and the direct limit `colim_L C_L` are all statements inside that closure. Isomorphisms of profinite groups are `ContinuousMulEquiv`s, never bare `MulEquiv`s | Layers 7–11 |
| class formation interface | identical to the local roadmap's: finite level in the shape of kbuzzard/ClassFieldTheory's `FiniteClassFormation` (distinguished `H²` class, `H¹` vanishing, compatible invariants), with the profinite formation `(G_K, colim_L C_L)` NSW-style on top | Layer 11 |
**Pinned route decision** (delegated by the master plan; recorded here with its rationale).
The global Artin map is **assembled from the local reciprocity maps**, Neukirch-style, rather
than constructed from a global fundamental class. The map is *defined* on ideles by
`(x_v)_v ↦ ∏_v Art_{K_v}(x_v)∣_L`, with almost all factors trivial by unramifiedness, so that
local-global compatibility, the single most-consumed statement downstream, holds by
construction. The global theorem is then the reciprocity law "`θ_{L/K}` kills principal
ideles" together with the norm-index equality. The inputs are the local-fields roadmap's
Layer 7, which uses the same arithmetic-Frobenius normalization, the archimedean package of
Layer 2C, and the norm-index machinery of Layer 5, whose proofs are pinned to the **algebraic**
routes: the Herbrand quotient of S-idele classes for `≥`, and Chevalley's Kummer-theoretic
argument for `≤`. That keeps this roadmap free of L-series and density theorems, which belong
to the L-functions sibling; a density-dependent reciprocity proof would invert the dependency
order of the whole program.

The cohomological global class formation is not dropped. It is Layer 11: a compatibility layer
that reuses the Layer 5 computations, states the fundamental classes and invariant maps, and
carries the Honda–Tate-facing data. It is also where the two in-motion external designs are
reconciled. The ClassFieldTheory blueprint's global chapter is fundamental-class-first with a
density-route inequality (their "first inequality"), and if their global half lands in Lean,
Layer 11's statements are what refactors onto it, while Layers 5 through 7 remain independent.
The alternatives considered and rejected for the main line: fundamental-class-first, which
blocks reciprocity on `H²` machinery and on the ProfiniteCohomology sibling, parallelizes
worse, and turns local-global compatibility from a definition into a chain of theorems; and the
purely ideal-theoretic classical route (Janusz's, with no ideles), which loses the direct
interface to Mathlib's adele stack, to FLT, and to Hecke characters, and which survives here
instead as the *dictionary* of Layers 7 and 8.

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:" and "PR:" flag material that
landed after the pin or is in flight, to be consumed on a later bump rather than rebuilt.

- **The adele stack.** `Mathlib/NumberTheory/NumberField/AdeleRing.lean` (`AdeleRing R K`,
  `principalSubgroup`, `algebraMap_injective`; Mercuri, de Frutos-Fernández);
  `InfiniteAdeleRing.lean` (`InfiniteAdeleRing K = Π_v v.Completion`, `locallyCompactSpace`,
  `denseRange_algebraMap`, which is weak approximation at the infinite places, and a `Norm`
  instance); `Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean` (`FiniteAdeleRing R K` as
  a restricted product, `isUnit_iff`, `unitEmbedding : Kˣ →* (FiniteAdeleRing R K)ˣ`);
  `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean` (`HeightOneSpectrum.intValuation`,
  `valuation : Valuation K ℤᵐ⁰`, `adicCompletion`, `adicCompletionIntegers`,
  `valuation_exists_uniformizer`); `Mathlib/Topology/Algebra/RestrictedProduct/`
  (`Basic/TopologicalSpace/Units`: the units of a restricted product carry the restricted
  product topology, so the idele topology comes out right by construction) and
  `Topology/Algebra/IsOpenUnits.lean`. **master:** the notation `𝔸[K]`
  ([PR #40535](https://github.com/leanprover-community/mathlib4/pull/40535), merged
  2026-07-29). **PR:** the idele class group itself (#40735), local compactness of `𝔸_K`
  (#36404, Mercuri's [AFM 2025 paper](https://arxiv.org/abs/2405.19270) upstreaming), and the
  finite-adele norm (#36275).
- **Places and the product formula.** `Mathlib/NumberTheory/NumberField/Completion/FinitePlace.lean`
  (`FinitePlace K` as absolute values, `embedding`, `adicAbv`, `norm_def`, the DVR instances on
  `adicCompletionIntegers`; Barroero); `NumberField/ProductFormula.lean` (`prod_abs_eq_one`:
  `∏_v |x|_v = 1` over all places with the `mult`-weighted infinite factors, the normalization
  this roadmap's idele norm must match); `NumberField/InfinitePlace/Basic.lean` (`IsReal`,
  `IsComplex`, `embedding_of_isReal`, `mult`, `denseRange_algebraMap_pi`);
  `NumberField/Completion/InfinitePlace.lean` (`InfinitePlace.Completion`,
  `ringEquivRealOfIsReal`, `ringEquivComplexOfIsComplex`, the isometry versions: the exact
  vocabulary Layer 2C's classification of archimedean completions is stated in);
  `NumberField/InfinitePlace/Ramification.lean` (`InfinitePlace.IsUnramified/IsRamified` and the
  class `IsUnramifiedAtInfinitePlaces`, the vocabulary for real places in moduli and for
  "unramified everywhere" in Layer 8); `NumberField/Completion/Ramification.lean`
  (`InfinitePlace.inertiaDeg`, `sum_inertiaDeg_eq_finrank`) and `LiesOverInstances.lean`.
- **Class group and units.** `Mathlib/RingTheory/ClassGroup/Basic.lean` (`ClassGroup R`,
  `ClassGroup.mk0`, `mk0_surjective`) and `ExtendedHom.lean` (`ClassGroup.extendedHom`, the
  capitulation map `ClassGroup (𝓞 K) →* ClassGroup (𝓞 L)`, and
  `extendedHom_eq_one_of_forall_isPrincipal`, the exact target shape of the principal ideal
  theorem; Birkbeck, Brasca); `NumberField/ClassNumber.lean` (finiteness, `classNumber`);
  `NumberField/Units/Basic.lean`, `Units/DirichletTheorem.lean`, `Units/Regulator.lean`
  (torsion `μ(K)`, the unit theorem, the lattice input to Layer 5's S-unit Herbrand
  computation); `Mathlib/RingTheory/DedekindDomain/SInteger.lean` (S-integers, S-units,
  `unitEquivUnitsInteger`; Angdinata). **PR:** S-integers as a localization and Dedekind domain
  (#40848, Barroero), Dirichlet's S-unit theorem (#40791); Layer 5's Kummer route refactors
  onto these if they land first.
- **Frobenius and ramification.** `Mathlib/RingTheory/Frobenius.lean` (`AlgHom.IsArithFrobAt`,
  `IsArithFrobAt`, `arithFrobAt`: existence, uniqueness under unramifiedness, conjugation;
  A. Yang; the mathlib landing of FLT's Frobenius miniproject,
  [PR #19926](https://github.com/leanprover-community/mathlib4/pull/19926));
  `Mathlib/NumberTheory/RamificationInertia/` (`ramificationIdx`, `inertiaDeg`,
  `sum_ramification_inertia`, Galois-action transitivity, decomposition and inertia fields);
  `Mathlib/RingTheory/Invariant/Basic.lean` (stabilizer and residue-Galois machinery). **PR:**
  the ring-level decomposition/inertia refactor wave (#41591 and companions, Roblot); the
  uniform API there is the Number Field Arithmetic sibling's to track, and this roadmap consumes
  whatever spelling that roadmap fixes.
- **Cyclotomic fields.** `Mathlib/NumberTheory/Cyclotomic/` (`IsCyclotomicExtension`,
  `CyclotomicField`, `Gal.lean`'s `autEquivPow`, discriminants, `PrimitiveRoots`);
  `Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean` (Roblot, 2026, at the pin):
  `IsCyclotomicExtension.Rat.galEquivZMod : Gal(K/ℚ) ≃* (ZMod n)ˣ`,
  **`galEquivZMod_stabilizer`** (the decomposition group at `p ∤ n` is `⟨[p]⟩`, the cyclotomic
  Frobenius law), `intermediateFieldEquivSubgroupChar` (subfields of `ℚ(ζₙ)` correspond to
  groups of Dirichlet characters, following Washington) and
  `mem_intermediateFieldEquivSubgroupChar_iff_conductor_dvd`; `NumberField/Cyclotomic/Ideal.lean`
  (the `(ζ − 1)` ramification package for prime-power level, and the general `e`, `f` and
  `primesOver` counts at `p ∣ n`). Layer 4 is largely a repackaging of this file pair, and it is
  why Layer 4 can start on day one.
- **Dirichlet characters.** `Mathlib/NumberTheory/DirichletCharacter/`
  (`DirichletCharacter R n = MulChar (ZMod n) R`, `changeLevel`, `FactorsThrough`, `conductor`,
  `IsPrimitive`, Gauss sums, orthogonality), the `K = ℚ` face of Layer 3's dictionary, together
  with `ZMod.χ₄` and `Mathlib/NumberTheory/LegendreSymbol/` for the standard quadratic
  characters. `Mathlib/NumberTheory/MulChar/`.
- **Abelian Galois bookkeeping.** `Mathlib/FieldTheory/Galois/Abelian.lean` (`IsAbelianGalois`),
  `Galois/Profinite.lean`, `KrullTopology.lean`, `AbsoluteGaloisGroup.lean`
  (`Field.absoluteGaloisGroup`, `absoluteGaloisGroupAbelianization`), `IsGaloisGroup`,
  `IsAlgClosure`.
- **Finite group cohomology**, which covers all of Layers 5 and 6's cohomological needs at the
  pin: `Mathlib/RepresentationTheory/Homological/GroupCohomology/`, namely `LowDegree` (explicit
  `H⁰`, `H¹`, `H²`), `Hilbert90.lean` (`H¹(Gal(L/K), Lˣ) = 0`), `FiniteCyclic.lean`
  (periodicity, the engine behind the Herbrand quotient), `Shapiro.lean` (the coinduced
  computation the semi-local decomposition needs), `LongExactSequence.lean`,
  `Functoriality.lean`. **master:** `TateCohomology` (PR #38553, merged 2026-06-09, six days
  after the pin); Layer 5's `Ĥ⁰` statements are phrased as plain norm quotients at the pin and
  refactor onto `TateCohomology` at the first bump, exactly as the local roadmap's Layer 5
  plans. Keep the two roadmaps' spellings identical.
- **Group-theoretic transfer.** `Mathlib/GroupTheory/Transfer.lean` (`MonoidHom.transfer`,
  Burnside machinery), the input to Layer 8's principal ideal theorem.
- **Assorted.** CRT for Dedekind domains
  (`IsDedekindDomain.quotientEquivPiOfProdEq`/`quotientEquivPiFactors`,
  `RingTheory/DedekindDomain/Ideal/Lemmas.lean`; `Ideal.quotientInfRingEquivPiQuotient`);
  `Ideal.absNorm` and `FractionalIdeal` norms;
  `Mathlib/Topology/Algebra/ContinuousMonoidHom.lean` and `PontryaginDual.lean`;
  `Mathlib/Analysis/Complex/Circle.lean`; Kummer extensions
  (`Mathlib/FieldTheory/KummerExtension.lean`); quadratic reciprocity in
  `LegendreSymbol/`, which the Layer 11 worked example re-derives rather than consumes.

Two things a reader might expect to find upstream and will not. Mathlib has **no weak
approximation theorem** for several inequivalent absolute values (searched at the pin: no
`WeakApproximation`, no approximation theorem for valuations), only the archimedean density
statement `InfinitePlace.denseRange_algebraMap_pi`; Layer 0 therefore proves the mixed
finite-and-infinite statement it needs. And Mathlib has **no theory of nonmaximal orders** in a
number field beyond the generic `ClassGroup R`; Layer 10B builds it.

### What is in motion elsewhere (statuses checked 2026-08-06; coordinate, cite, do not fork)

- **Mathlib PR [#40735](https://github.com/leanprover-community/mathlib4/pull/40735)**
  (T. Browning; open, head `ba5cc4688489`, updated 2026-08-05): defines
  `NumberField.IdeleGroup R K`, `IdeleGroup.principalSubgroup`, `IdeleClassGroup R K`, and the
  `ofCompletion` and `ofAdicCompletion` maps from local units, "to be used to define Hecke
  L-Functions". This is the most consequential in-flight item for us: Layer 2A adopts its names
  and shapes verbatim, and Layer 3 is heading where its author says he is heading. Contact
  before starting either layer (§Provenance).
- **Mathlib PR [#40661](https://github.com/leanprover-community/mathlib4/pull/40661)**
  (F. A. E. Nuccio; open, head `184a5900ddc0`, updated 2026-07-16): a `theorem_wanted` file
  `NumberTheory/NumberField/HilbertClassField.lean` containing Kronecker–Weber
  (`IsAbelianGalois.le_cyclotomicField`), a conductor-as-least-cyclotomic-level statement, and
  the Hilbert class field with `Gal ≃* ClassGroup (𝓞 K)`, `Algebra.Unramified (𝓞 K) (𝓞 H)`,
  `IsUnramifiedAtInfinitePlaces`, maximality, and the principal ideal theorem via
  `ClassGroup.extendedHom = 1`. These are Mathlib's own wanted-statement shapes for Layers 8 and
  9; align with them and report divergences on the PR.
- **Mathlib PRs [#36404](https://github.com/leanprover-community/mathlib4/pull/36404)** (open,
  head `fca3a6af67b8`, last updated 2026-03-21: local compactness of `𝔸_K`) and
  **[#36275](https://github.com/leanprover-community/mathlib4/pull/36275)** (open, head
  `df510478253d`, updated 2026-07-29: the finite-adele norm), both Mercuri. Layer 2A's topology
  and norm milestones refactor onto them. The companion instance-transparency PR #42130 was
  **closed unmerged on 2026-08-06**, so do not plan against it.
- **Mathlib PR [#41765](https://github.com/leanprover-community/mathlib4/pull/41765)**
  (R. Brasca; open, head `0b8f53734ea1`, updated 2026-08-05):
  `NumberTheory/NumberField/DirichletDensity`. This is the L-functions sibling's territory,
  cited here only to mark the boundary: nothing in this roadmap may depend on it.
- **kbuzzard/ClassFieldTheory** (`main = ccc3323c6750abca25b49b35106f54eb3a398509`, top commit
  2026-07-31, checked 2026-08-06; maintainer Yunzhou "Edison" Xie): the global chapter is still
  blueprint only (`_4_global.tex`: the idele-class Herbrand quotient via S-ideles and the unit
  lattice, the density-route upper bound, solvable induction to `H¹ = 0` and `#H² ≤ n`,
  fundamental classes by cyclotomic splitting, a faithful Artin–Tate skeleton). The Lean tree
  is `Cohomology/`, `IsNonarchimedeanLocalField/`, `LocalCFT/`, plus `Mathlib/` and `Tactic/`
  shims: no global code. Their finite-level abstract machinery (`FiniteClassFormation`, Tate
  cohomology now upstreamed, the Herbrand calculus) is what Layers 5 and 11 align interfaces
  with, through the local-fields roadmap's identical pinned interface. Their day-to-day channel
  is private (see the local roadmap's provenance), so repository state is the public proxy.
- **FLT** (ImperialCollegeLondon/FLT, `d18b563029f3`, checked 2026-08-06): sorry-free and
  directly consumable as prior art. `NumberField.AdeleRing.discrete` and
  `NumberField.AdeleRing.cocompact` (compactness of `𝔸_K/K` for a general number field, via the
  base-change equivalence `𝔸_L ≃ L ⊗_K 𝔸_K`) live in `FLT/NumberField/AdeleRing.lean`, and
  Fujisaki's lemma (`NumberField.AdeleRing.DivisionAlgebra.compact_quotient`, Voight Main
  Thm 27.6.14(a)) in `FLT/DivisionAlgebra/Finiteness.lean`; its commutative specialization is
  Layer 2A's compactness of `C_K^1`. The Frobenius miniproject is closed, having merged as the
  pin's `RingTheory/Frobenius.lean`. FLT's own class-field-theory axiom is **local** (the
  `erd1/LCFT` interface; A. Yang's update of 2026-07-27, audited by the local-fields sibling):
  no global-reciprocity axiom appears in FLT's staging today, so what has to be coordinated is
  the adele and Fujisaki material, not reciprocity.
- **mariainesdff/ideles** (Lean 3, ITP 2022, `b85d242f18cb`, unchanged since 2023-10-05): the
  statements-of-global-CFT prior art named in the opening; unported. Coordinate with the author,
  who is also the author of PR #40661's wanted statements and of the dormant
  LocalClassFieldTheory, before Layers 2A and 7.
- **Zulip decisions in force.** The 2020
  [maths > "Ideal class group"](https://leanprover-community.github.io/archive/stream/116395-maths/topic/Ideal.20class.20group.html)
  thread (Baanen, Buzzard, Best) fixed the fractional-ideal design of `ClassGroup` that this
  roadmap builds on, and already floated idele-class compactness as the unifying statement. The
  `ValuativeRel`-replaces-`Valued` refactor and the local-fields design threads are inherited
  through the local-fields roadmap's provenance table, and its rule that nothing new is stated
  against `Valued` applies verbatim to the completions used here. The FLT update thread
  ([FLT > "update"](https://leanprover.zulipchat.com/#narrow/channel/416277-FLT/topic/update/near/613077432),
  A. Yang, 2026-07-27) is the source for the local-only CFT axiom above. No Zulip thread on ray
  class groups, Hecke characters, or global reciprocity in Lean exists (archive searched
  2026-07-30), which is why the conventions table pins the design.

## What is missing (build here)

Everything in global class field theory's own vocabulary. Moduli and multiplicative congruences
with real places, and the simultaneous congruence-and-sign approximation theorem they rest on.
Ray class groups `Cl_𝔪` with finiteness, functoriality, and the unit-to-ray exact sequence; the
narrow class group; the coprime-representative (moving) lemma. The idele class group's
arithmetic: the congruence subgroups `U_𝔪`, the isomorphism `C_K ⧸ RaySubgroup 𝔪 ≃ Cl_𝔪`, the
norm-one subgroup and its compactness, the connected component `D_K`, the open-subgroup
structure. The functoriality of ideles in a finite extension: the Galois action, the extension
map, the idele norm and its local formula, and `C_L` as a `Gal(L/K)`-module. The archimedean
local reciprocity package. Hecke characters: the continuous-character definition, the
finite-order dictionary, the two conductors, local components, the Dirichlet-character
equivalence over `ℚ`; algebraic characters and infinity types. The norm-index machinery (the
Herbrand quotient of S-idele classes, both inequalities, the Hasse norm theorem). The global
Artin map by local-global compilation, the reciprocity law, functoriality in towers and under
norms, and the equivalence of ramification with conductor divisibility. Norm groups, norm
limitation, and the existence theorem; the ideal-theoretic dictionary; ray class fields. The
Hilbert class field, capitulation, and the principal ideal theorem. Kronecker–Weber and the
conductor–discriminant formula. Orders, their Picard groups, ring class fields, and the CM
interface. The global class formation, fundamental classes, invariant maps, the
sum-of-invariants theorem, and the Hilbert reciprocity product formula. None of this exists in
Mathlib at the pin, in the ClassFieldTheory repository's Lean code, or in FLT.
---

## The build, in layers

The ordering below is the dependency order. Layers 0 through 5 elaborate against the pin
alone, except that Layer 2B consumes the Number Field Arithmetic roadmap's completion and
decomposition dictionary and Layer 5 consumes the local-fields roadmap's local Herbrand
quotient. Layer 6 is where the local-fields roadmap's Layer 7 becomes essential; only Layer 11
consumes ProfiniteCohomology. As each layer makes the next layer's types expressible, its
milestones are added to `Suggested.lean` with `sorry`.

### Layer 0: moduli, approximation, and multiplicative congruences

- **The modulus.** The structure of the conventions table: a nonzero ideal together with a
  `Finset` of real places. Provide the exponent-function face and the
  `Ideal.factorization`-compatibility lemmas, the divisibility relation in the pinned
  orientation, `gcd` and `lcm` with their exponentwise descriptions, the support, and the two
  named instances `(1)` (trivial finite part, empty infinite part) and the all-real-places
  modulus of Layer 1's narrow class group. The Lean prototype is in `Suggested.lean` and is
  part of this milestone: do not leave the type of a modulus to the first implementor's taste.
  Real places are the entire point of the formalism, so a design in which `𝔪∞ = ∅` is the path
  of least resistance will silently produce the wide class group everywhere. Weight the two
  components equally in the API and test with `𝔪∞ ≠ ∅` from the first lemma.
- **Simultaneous approximation.** The theorem the rest of the layer rests on: given a finite
  set of finite places `v₁, …, v_r`, targets `a_i ∈ K`, exponents `n_i`, and a sign `ε_w ∈ {±1}`
  at each of finitely many real places, there is one `x ∈ Kˣ` with `ord_{v_i}(x − a_i) ≥ n_i`
  for every `i` and `sign_w(x) = ε_w` for every chosen `w`. Two things make this a real target
  rather than a citation. Mathlib has no weak approximation theorem for inequivalent absolute
  values at the pin, and the finite and infinite conditions must be met by a *single* element,
  which is not what CRT and the sign surjectivity give separately. Pinned route: prove the
  Artin–Whaples weak approximation theorem in the form "the image of `K` is dense in
  `∏_{v ∈ S} K_v` for a finite set `S` of pairwise inequivalent places", which is a reusable
  statement worth stating for its own sake and a plausible Mathlib contribution, then read off
  the congruence-and-sign form. The archimedean-only case is already in Mathlib as
  `InfinitePlace.denseRange_algebraMap_pi` and is the model for the general proof.
- **Sign maps.** The total sign homomorphism `Kˣ →* Π_{w real} {±1}`, whose target
  is a genuine group of order two rather than `Bool`: use `ℤˣ`, or `Multiplicative (ZMod 2)`,
  fixed once in the prototype and used unchanged everywhere downstream, since Layer 1's exact
  sequence, Layer 3's parity dictionary, and Layer 2C's `Art_ℝ` all land in the same group. Its
  surjectivity is the archimedean case of the approximation theorem.
- **The congruence subgroup of `Kˣ`.** `K(𝔪) := {x : Kˣ | x ≡ 1 mod* 𝔪}` in the pinned
  spelling (valuation inequalities at `v ∣ 𝔪₀`, positivity through `embedding_of_isReal` at
  `w ∈ 𝔪∞`), a subgroup, antitone in `𝔪`, with the comparison to `1 + 𝔪₀` for integral
  elements prime to `𝔪₀` stated as a lemma with its hypothesis visible. The congruence is
  multiplicative: `x ≡ 1` and `y ≡ 1` give `xy ≡ 1` by the ultrametric inequality and the sign
  calculus, not by ring arithmetic in a quotient, so do not define `K(𝔪)` through `𝓞 K ⧸ 𝔪₀`.
- **The reduction map and its exact domain.** "Elements prime to `𝔪₀`" is not a Lean type. Use
  `Kˣ_{𝔪₀} := {x : Kˣ | ∀ v ∣ 𝔪₀, ord_v x = 0}`, a subgroup of `Kˣ`, or equivalently the unit
  group of the semi-local localization of `𝓞 K` away from `𝔪₀`; state the equivalence of the
  two descriptions. On it, the reduction map
  `Kˣ_{𝔪₀} →* (𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞} {±1}` is defined through CRT
  (`quotientEquivPiFactors`) and the sign maps, it is **surjective** by the approximation
  theorem above, and its kernel is exactly `K(𝔪)`. That last identity is the computational form
  of Layer 1's exact sequence, so prove it here rather than reproving it there.

### Layer 1: ray class groups and the narrow class group

- **`J^{𝔪₀}` and `P_𝔪`.** The subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of fractional ideals
  with support disjoint from `𝔪₀` (spell support through the `v`-adic count of the
  factorization, and provide the `I = 𝔞𝔟⁻¹` face with `𝔞`, `𝔟` integral and prime to `𝔪₀`);
  the ray `P_𝔪`, the principal ideals of elements of `K(𝔪)`. `Cl_𝔪 K` as the quotient;
  functoriality `𝔪 ∣ 𝔫 ⟹ Cl_𝔫 ↠ Cl_𝔪` with the transition maps composing correctly in a
  tower; `Cl_{((1),∅)} ≃* ClassGroup (𝓞 K)` as a named isomorphism through
  `ClassGroup.mk0`-compatibility.
- **The moving lemma.** Every class of `Cl_𝔪`, and, in the form to prove first, every class of
  `ClassGroup (𝓞 K)`, contains an integral ideal prime to `𝔪₀`. Route: CRT and approximation in
  the Dedekind domain (`quotientEquivPiOfProdEq` plus a uniformizer-selection argument), not
  geometry of numbers. This lemma is genuinely absent from Mathlib (verified; only
  `mk0_surjective` exists) and both the surjectivity of `Cl_𝔫 ↠ Cl_𝔪` and the ideal-idele
  dictionary turn on it. It is a Dedekind-domain statement, so prove it at that generality.
- **The ray class exact sequence.** For every modulus, the full sequence, including the kernel
  that the usual textbook display hides:

  `1 → 𝓞_{K,𝔪}ˣ → 𝓞_Kˣ → (𝓞 K ⧸ 𝔪₀)ˣ × Π_{w ∈ 𝔪∞} {±1} → Cl_𝔪 K → ClassGroup (𝓞 K) → 1`,

  where `𝓞_{K,𝔪}ˣ = 𝓞_Kˣ ∩ K(𝔪)` is the group of units congruent to `1` modulo the finite part
  and positive at the real places of `𝔪∞`. The third map is Layer 0's reduction map restricted
  to global units, the fourth sends a class to the ideal it generates, and exactness at each
  spot is a separate lemma. Derive the image form
  `1 → im(𝓞_Kˣ) → (𝓞 K ⧸ 𝔪₀)ˣ × signs → Cl_𝔪 K → Cl K → 1` from it, not the other way round.
- **Finiteness and the class number formula.** For a number field, `Cl_𝔪 K` is finite of order
  `h_K · #(𝓞 K ⧸ 𝔪₀)ˣ · 2^{#𝔪∞} / [𝓞_Kˣ : 𝓞_{K,𝔪}ˣ]`; state the exact index form, not merely
  finiteness. Prove it from the exact sequence, and state it either for number fields or under
  the explicit hypothesis package `Finite (𝓞 K ⧸ 𝔪₀)ˣ` and `Finite (ClassGroup (𝓞 K))` of the
  standing hypotheses. It is **false** at unrestricted Dedekind generality, so the hypotheses
  are not decoration.
- **The unit obstruction.** The sequence shows that `Cl_𝔪` is *not* `(𝓞/𝔪₀)ˣ × signs × Cl` in
  general: global units glue the factors, and the size of the unit image is a genuinely global
  quantity. It is why ray class groups of real quadratic fields are hard, and why `Cl⁺ ≠ Cl`
  exactly when no unit realizes a given sign pattern. Every statement in this layer must run
  through the exact sequence rather than through a claimed product decomposition.
- **The narrow class group.** `Cl⁺ K` per the pinned convention; `Cl⁺ = Cl` for totally
  imaginary `K`; the kernel of `Cl⁺ ↠ Cl` computed by the exact sequence as an elementary
  abelian 2-group of order `2^{r₁}/[𝓞_Kˣ : 𝓞_Kˣ⁺]`; the characterization by totally positive
  principal ideals. **Interface milestone (Multiquadratic Layer 3):** the narrow class group and
  the surjection `Cl⁺ ↠ Cl` in this spelling are what the multiquadratic roadmap names
  as prerequisites for its real-quadratic 2-rank theorem, so freeze this API in coordination
  with any implementor working there.
- **Dedekind generality.** Everything above except the sign components and the finiteness
  statements is stated for a Dedekind domain with fraction field (the ray class group of `R`
  modulo `𝔪₀`), and the number-field statements specialize. This is what Layer 10B's orders and
  any future function-field work reuse.

### Layer 2A: the idele class group

- **The objects, aligned with PR #40735.** `IdeleGroup (𝓞 K) K`, `principalSubgroup`,
  `IdeleClassGroup (𝓞 K) K`, and the local inclusions `ofCompletion` and `ofAdicCompletion`.
  Basic topology: `IdeleGroup` is a locally compact topological group (the units of a locally
  compact ring through the `(x, x⁻¹)` embedding, with the finite part handled by
  `RestrictedProduct/Units` and the ambient local compactness refactoring onto #36404), `Kˣ`
  embeds discretely (from FLT's `AdeleRing.discrete` together with the units embedding), and
  hence `IdeleClassGroup` is a locally compact Hausdorff group. Both #40735 shapes are `abbrev`s
  over `(AdeleRing R K)ˣ`; keep them reducible here too, so that every `Units` lemma of Mathlib
  applies without glue.
- **The idele norm and the norm-one subgroup.** `‖·‖ : IdeleGroup →* ℝ_{>0}` in the pinned
  normalization, with the finite part refactoring onto #36275; the product formula `‖x‖ = 1` for
  principal `x`, globalizing the pin's `prod_abs_eq_one`; `C_K^1 ≤ IdeleClassGroup` closed.
  **Compactness of `C_K^1`**, the main analytic input of the layer: cite and coordinate with
  FLT's sorry-free Fujisaki lemma (`DivisionAlgebra/Finiteness.lean`, whose commutative case
  this is) and with `AdeleRing.cocompact`; a Tau Ceti proof follows the same reduction, counting
  a fundamental domain in `𝔸_K/K`. Corollaries, derived here and cross-checked against Mathlib's
  independent proofs: finiteness of `ClassGroup (𝓞 K)` and Dirichlet's unit theorem. `C_K`
  itself is neither compact nor profinite: `C_K ≅ C_K^1 × ℝ_{>0}`, a choice-dependent splitting,
  so state it as such, and note that `Nat.card` statements about `C_K` are vacuous.
- **The congruence subgroups.** `IdeleCongruenceSubgroup 𝔪` as pinned in the
  conventions table, and `RaySubgroup 𝔪` its image in `C_K`; openness of both; antitonicity in
  `𝔪`; and the two dictionaries:
  1. `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`, through the map `x ↦ ∏_{v ∤ 𝔪₀} v^{ord_v(x_v)}` on
     ideles, with the kernel computed by the moving lemma and Layer 0's reduction map;
  2. its special case `𝔪 = ((1), ∅)`, `C_K ⧸ RaySubgroup ((1),∅) ≃* ClassGroup (𝓞 K)`, which is
     de Frutos-Fernández's Lean 3 theorem re-proved in Lean 4 vocabulary.

  Compatibility of the isomorphisms with the transition maps of Layer 1 as `𝔪` grows is part of
  the milestone, since Layer 7's inverse limit needs it.
- **Open subgroups and the connected component.** Every open subgroup of `C_K` contains
  `RaySubgroup 𝔪` for some `𝔪` (proved by generating a subgroup from a basic neighborhood of
  `1`, which gives principal units at the finitely many constrained finite places and positivity
  at the real ones). `D_K`, the identity component of `C_K`, is closed and divisible and is
  contained in every open subgroup, hence in every `RaySubgroup 𝔪`; `π₀(C_K) = C_K/D_K` is
  profinite and `C_K/D_K ≅ lim_𝔪 Cl_𝔪` as topological groups. The full structure of `D_K`
  (solenoids) is **not** a target; the three stated properties are what Layers 3 and 7 consume.
  Note that "every open subgroup contains some `U_𝔪`" is a statement about *open* subgroups
  only, and says nothing about an arbitrary continuous character, whose kernel need not be open.

### Layer 2B: ideles in a finite extension

Everything in Layers 5, 6 and 11 that treats `C_L` as a `Gal(L/K)`-module needs this layer, and
none of it is routine notation. Throughout, `L/K` is a finite extension of number fields, and
`w ∣ v` means `w` is a place of `L` above the place `v` of `K`.

- **The local dictionary, consumed rather than proved here.** For each finite place `v`, the
  completion `v.adicCompletion K` is a nonarchimedean local field in the
  `IsNonarchimedeanLocalField` sense; its residue cardinality is `Ideal.absNorm v.asIdeal`; the
  local normalized valuation restricts to `HeightOneSpectrum.valuation` on `K`; and
  `FinitePlace.mk v` computes the local absolute value. The Number Field Arithmetic roadmap owns
  this dictionary, so the rule agreed there applies: the lemmas are stated in both roadmaps and
  proved once, in that one. Everything Layers 5 through 7 take from the local roadmap passes
  through it. Follow the local roadmap's rule that no new statement is made against the
  deprecated `Valued` interface: phrase unit conditions through `adicCompletionIntegers`, the
  local unit subgroup, or the `ValuativeRel` API.
- **The Galois action.** For `L/K` Galois with `G = Gal(L/K)`: the action of `G` on `𝔸_L`, on
  `I_L`, and on `C_L`, permuting the places over each `v` (consume the transitivity statement
  from the Number Field Arithmetic roadmap), acting on each completion by the induced
  isomorphism `L_w ≃ L_{σw}`, continuous, and by ring or group automorphisms. State that the
  principal ideles form a `G`-stable subgroup and that the action on `𝔸_L` restricts to the
  usual action on `L`.
- **The extension map.** `I_K →* I_L`, whose component at `w ∣ v` is induced by `K_v → L_w`,
  well defined on the restricted product (an idele that is a unit outside a finite set of places
  of `K` is a unit outside a finite set of places of `L`), continuous, and injective; its
  descent `C_K →* C_L`, compatible with `K ⊆ L` on principal ideles.
- **The idele norm.** `N_{L/K} : I_L →* I_K` with the component formula
  `N(x)_v = ∏_{w ∣ v} N_{L_w/K_v}(x_w)`; well-definedness on the restricted product, using that
  `N_{L_w/K_v}` maps local units to local units at almost all `w`; continuity; compatibility
  with principal ideles, `N(principal x) = principal (Algebra.norm K x)`, which is the local
  norm formula of the Number Field Arithmetic roadmap summed over `w ∣ v`; and the descent
  `N_{L/K} : C_L →* C_K`.
- **Towers and base change.** `N_{M/K} = N_{L/K} ∘ N_{M/L}` for `K ⊆ L ⊆ M`; the corresponding
  transitivity of extension maps; the commuting squares relating extension, norm, and the Galois
  action; and `N_{L/K} ∘ (extension) = (·)^{[L:K]}` on `I_K` and on `C_K`.
- **The semi-local decomposition.** For `L/K` Galois and `v` a place of `K`, the `G`-module
  `∏_{w ∣ v} L_wˣ` is the module coinduced from the decomposition group `G_w` acting on `L_wˣ`,
  for any chosen `w ∣ v`, and the statement is independent of the choice up to the canonical
  isomorphism. The identification of `G_w` with `Gal(L_w/K_v)` is the Number Field Arithmetic
  roadmap's; consume it by name rather than restating it. This is the input to Shapiro's lemma
  in Layer 5, and the local component formula for the norm above is its multiplicative shadow.
- **Invariants.** For `L/K` Galois: `(I_L)^G ≃ I_K` and, the statement that is not formal,
  `(C_L)^G ≃ C_K`. Derive the second from the first through the exact sequence
  `1 → Lˣ → I_L → C_L → 1` and Hilbert 90 (`H¹(G, Lˣ) = 0`, at the pin), rather than assuming
  it: the cokernel of `C_K → (C_L)^G` injects into `H¹(G, Lˣ)`.

### Layer 2C: the archimedean local package

The local-fields roadmap is nonarchimedean by design, so the real and complex local theory is
built here. It is elementary, it is entirely expressible at the pin, and every layer from 5
onwards uses it. State everything in the `InfinitePlace` vocabulary so that it plugs into the
global statements without translation.

- **Classification of the completions.** For `w` an infinite place of `K`, `w.Completion` is
  `ℝ` when `w.IsReal` and `ℂ` when `w.IsComplex`, through the pin's `ringEquivRealOfIsReal` and
  `ringEquivComplexOfIsComplex` (and their isometry versions). Fix, once, which of the two
  embeddings `ℂ → ℂ` is used at a complex place, and record that the local objects below are
  independent of that choice.
- **The local Galois group.** `Gal(ℂ/ℝ)` is cyclic of order two generated by complex
  conjugation, and `Gal(ℂ/ℂ)` is trivial. State the compatibility with the global picture: for
  `w ∣ v` infinite places of `L/K`, the decomposition group at `w` is trivial when `v` splits
  and is generated by the complex conjugation attached to `w` when `v` is ramified, in the
  vocabulary of `InfinitePlace.IsRamified` and of the Number Field Arithmetic roadmap's
  Frobenius-at-a-real-place milestone.
- **The reciprocity maps.** `Art_ℂ : ℂˣ →* Gal(ℂ/ℂ)`, trivially; `Art_ℝ : ℝˣ →* Gal(ℂ/ℝ)`
  sending positive elements to `1` and negative elements to complex conjugation; surjectivity
  of `Art_ℝ`, and `ker Art_ℝ = ℝ_{>0}`.
- **Norms and norm groups.** `N_{ℂ/ℝ}(ℂˣ) = ℝ_{>0}`, so `ℝˣ / N_{ℂ/ℝ}(ℂˣ)` has order two and
  `Art_ℝ` induces an isomorphism onto `Gal(ℂ/ℝ)`. The corresponding statement at a complex
  place is that the norm map is surjective and the quotient trivial. Together these are the
  archimedean case of the local reciprocity isomorphism, in the same shape as the local
  roadmap's nonarchimedean one.
- **Cohomology.** `H¹(Gal(ℂ/ℝ), ℂˣ) = 1` (a case of Hilbert 90, but also a two-line direct
  computation worth having), `Ĥ⁰(Gal(ℂ/ℝ), ℂˣ) ≅ ℤ/2`, and hence the Herbrand quotient
  `h(Gal(ℂ/ℝ), ℂˣ) = 2 = [ℂ:ℝ]`. These are the archimedean factors in Layer 5's global Herbrand
  computation, where they matter as much as the nonarchimedean ones.
- **Invariants.** `inv_ℂ = 0` and `inv_ℝ : H²(Gal(ℂ/ℝ), ℂˣ) ≃ (1/2)ℤ/ℤ ⊆ ℚ/ℤ`, sending the
  nontrivial class to `1/2`. Compatibility with the local roadmap's normalization of `inv_v`
  is a stated requirement, since Layer 11's sum-of-invariants theorem adds these to the finite
  ones.
- **Ramification and conductors at infinity.** For a finite abelian `L/K` and `w` a real place
  of `K`: `w` is unramified in `L` iff the local norm group at `w` is all of `K_wˣ = ℝˣ` iff
  `w ∉ 𝔣(L/K)∞`. This is the real-place clause of Layer 6's ramification statement and of
  Layer 7's conductor, and it is where the sign conventions of Layer 0 meet the reciprocity
  map.
- **Hilbert symbols.** `(a, b)_ℂ = 1` for all `a, b ∈ ℂˣ`; `(a, b)_ℝ = −1` exactly when both
  `a < 0` and `b < 0`; bimultiplicativity and nondegeneracy in the real case. State these in
  the same symbol vocabulary the local roadmap's Layer 8 fixes for finite places, since
  Layer 11's product formula ranges over all places at once.
### Layer 3: Hecke characters and the finite-order dictionary

- **The definition and the first dictionary.**
  `HeckeCharacter K := ContinuousMonoidHom (IdeleClassGroup (𝓞 K) K) ℂˣ`, as pinned. The
  finite-order trichotomy, each implication a named lemma: `χ` has finite order iff `ker χ` is
  open iff `χ` is the pullback of a character of `Cl_𝔪 K` for some modulus `𝔪`. Then the induced
  bijection between the finite-order Hecke characters with `U_𝔪 ⊆ ker χ` and the characters of
  the finite group `Cl_𝔪 K`, which is what "ray class character" means. The step from an open
  kernel to a ray class character is Layer 2A's open-subgroup lemma; the step back uses that
  `Cl_𝔪 K` is finite.
- **The two conductors.** A general continuous quasicharacter has no ray conductor: `‖·‖^s` is
  trivial on no `U_𝔪`, so the neighborhood-basis lemma does not apply to it. Define both notions
  and keep them apart.
  1. The **finite conductor ideal** of an arbitrary continuous `χ`: at each finite `v`, the
     local component `χ_v` is trivial on `1 + 𝔭_v^{n}` for `n` large, since the principal-unit
     filtration is a neighborhood basis of `1` in `𝒪_vˣ`; let `n_v(χ)` be the least such `n`
     (zero when `χ_v` is trivial on `𝒪_vˣ`), prove `n_v(χ) = 0` for almost all `v`, and set
     `𝔣₀(χ) = ∏_v 𝔭_v^{n_v(χ)}`. Minimality here is a statement about one place at a time, so it
     needs no global argument.
  2. The **ray conductor modulus** of a character trivial on the connected component of the
     archimedean part, in particular of every finite-order character: the least `𝔪` with
     `U_𝔪 ⊆ ker χ`, whose finite part is `𝔣₀(χ)` and whose infinite part is the set of real
     places where the local sign component is nontrivial. Existence of a *least* one is a
     theorem, not a corollary of finding one admissible modulus: prove that the set of admissible
     moduli is closed under `gcd`, using the local description in 1 at the finite places and the
     sign components at the real ones.
  Primitivity, and induction from a smaller modulus compatible with the design of
  `DirichletCharacter.changeLevel`, belong here as well.
- **Local components.** `χ_v := χ ∘ ofAdicCompletion` on local units at finite `v`, and `χ_w`
  at infinite `w`, with `χ = ∏_v χ_v` on ideles (a finite product on each idele) and the
  conductor formula relating `𝔣₀(χ)` to the local conductors. The local-fields face of this
  statement, the conductor of a character of `K_vˣ` in the local roadmap's sense, is used in
  Layer 7; here only the global assembly is claimed.
- **Over `ℚ`: Dirichlet characters, with parity.** For each `n ≥ 1`, an equivalence between the
  finite-order Hecke characters of `ℚ` with `U_{(n)∞} ⊆ ker χ` and `DirichletCharacter ℂ n`
  (that is, `MulChar (ZMod n) ℂ`), compatible with conductors: the finite part of the ray
  conductor is `DirichletCharacter.conductor` and induction on both sides matches. The parity
  statement is part of the milestone and is where the classical bookkeeping actually lives.
  Evaluate the product formula `∏_v χ_v(x) = 1` at the principal idele `x = −1`: the finite
  components and the real sign component are not independent, and the real component is
  nontrivial exactly when the Dirichlet character is odd. Hence the infinite place lies in the
  ray conductor exactly for odd characters. The instance to state is `ZMod.χ₄`, the odd
  quadratic character of finite conductor `4` and ray conductor `(4)·∞`. There is **no** sign
  character of `ℚ`: `Cl_{((1), ∞)}(ℚ) = 1`, because every fractional ideal of `ℤ` has a unique
  positive generator, so a character whose ray conductor is the infinite place alone is trivial.
  State `Cl_{((1),∞)}(ℚ) = 1` explicitly, as the statement that rules this out.
- **Unitary theory.** `|χ| = ‖·‖^σ` for a unique real `σ`, and the decomposition
  `χ = χ_u · ‖·‖^σ` with `χ_u` unitary. Uniqueness holds because `σ` is pinned by `|χ| = ‖·‖^σ`
  and `‖·‖` surjects onto `ℝ_{>0}`; the exponent is normalized to be **real** because a complex
  exponent is ambiguous exactly up to the continuous family of unitary twists `‖·‖^{it}`. This
  is the normalization interface the L-functions roadmap consumes for Hecke L-series; the
  arithmetic-versus-analytic normalization dictionary lives there, not here.
- Characters with an infinite-order infinity type, algebraicity, and the CM examples are
  Layer 10A, a definite later layer rather than an omission here.

### Layer 4: the cyclotomic anchor

Pin-expressible on day one, independent of Layers 0 through 3, and the arithmetic input every
reciprocity proof reduces to. The Frobenius facts here are **consumed** from the Number Field
Arithmetic roadmap's Layer 2, which owns the arithmetic Frobenius and the cyclotomic
computation; what is built here is the ray class computation and the comparison.

- **The splitting law in `ℚ(ζₙ)`.** For `p ∤ n`: the decomposition group at `p` is `⟨[p]⟩`
  under `galEquivZMod` (this is the pin's `galEquivZMod_stabilizer`, consume it), hence `f` is
  the order of `p` in `(ℤ/n)ˣ` and `p` splits completely iff `p ≡ 1 (mod n)`. The identification
  of the arithmetic Frobenius at `p` with `[p]`, that is
  `galEquivZMod n K (Frob 𝔓) = ZMod.unitOfCoprime p hp`, is the Number Field Arithmetic
  roadmap's milestone; cite it, do not restate it. Use that roadmap's `.ncard`-based spelling of
  "splits completely" rather than introducing a second one.
- **Ramification, stated correctly.** Three statements, in increasing generality, because the
  first is often quoted beyond its range.
  1. Prime-power level: for `n = p^a` with `p^a > 2`, the element `ζ_{p^a} − 1` generates the
     unique prime above `p`, which is totally ramified with `e = φ(p^a)` and `f = 1`. This is
     the case Mathlib's `Cyclotomic/Ideal.lean` packages explicitly.
  2. General level: write `n = p^a m` with `p ∤ m`; then `e = φ(p^a)`, `f` is the order of `p`
     in `(ℤ/m)ˣ`, and `g = φ(m)/f`. Consume the general formulas from the same file.
  3. Which primes ramify: define the normalized level `n₀ = n/2` when `n ≡ 2 (mod 4)` and
     `n₀ = n` otherwise, so that `ℚ(ζ_n) = ℚ(ζ_{n₀})`. For `n₀ ≥ 3` the finite primes ramifying
     in `ℚ(ζ_n)` are exactly those dividing `n₀`, and the infinite place ramifies as well (the
     field is totally imaginary); for `n₀ ≤ 2` the field is `ℚ`. "Ramified exactly at the
     `p ∣ n`" is **false** as stated: `ℚ(ζ₆) = ℚ(ζ₃)` is unramified at `2`.
- **The reciprocity isomorphism over `ℚ`, by hand.** `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`, from Layer 1's
  exact sequence at `K = ℚ`, where the units `±1` are absorbed by the sign component; this is
  the worked instance of the unit obstruction. Composing with the consumed
  `(ZMod n)ˣ ≃* Gal(ℚ(ζₙ)/ℚ)` gives a map `Cl_{(n)∞}(ℚ) ≃* Gal(ℚ(ζₙ)/ℚ)` sending `[p]` to
  `Frob_p` for `p ∤ n`: Artin reciprocity for `(ℚ, ℚ(ζₙ))`, proved with no class field theory.
  This is the normalization anchor against which the Layer 6 map is checked and the base case of
  the Layer 9 conductor–discriminant induction.
- **Modulus versus conductor.** The identity `ℚ_{(n)∞} = ℚ(ζₙ)` of Layer 7 holds for every `n`,
  including nonminimal moduli, while the conductor of `ℚ(ζₙ)/ℚ` is `(n₀)·∞` for `n₀ ≥ 3` and
  the trivial modulus otherwise. Keep the two apart in every statement: a ray class field is
  attached to a modulus, and the conductor is the least modulus that works.
- ⚠ Direction check, built into the layer: `[p] ↦ Frob_p` with the **arithmetic** Frobenius,
  `σ_p(ζ) = ζ^p`. The geometric convention would send `[p]` to `Frob_p⁻¹`, and both compose with
  `galEquivZMod` to give an automorphism of `(ℤ/n)ˣ`, which is why an error here survives
  superficial testing. The discriminating test is the factorization of Gauss sums, which is the
  L-functions roadmap's territory, so pin the direction here by the stabilizer computation.

### Layer 5: the norm-index machinery (the class field axiom)

All cohomology in this layer is of **finite** groups, at the pin. For `L/K` finite Galois set
`G = Gal(L/K)`, and use Layer 2B's Galois action, norms, and semi-local decomposition
throughout: none of the statements below typechecks without it.

- **The `S`-idele setup, made exact.** Pin the convention: `S` is a **finite set of places of
  `K`** containing the infinite places and the places ramified in `L`, and `S_L` is the set of
  places of `L` lying over places in `S`. Then `S_L` is finite and `G`-stable, and no separate
  stability hypothesis is needed. Define and prove:
  1. `I_{L,S} := {x ∈ I_L | ∀ w ∉ S_L, x_w ∈ 𝒪_wˣ}`, an open `G`-stable subgroup;
  2. the `S`-unit group `𝓞_{L,S}ˣ = Lˣ ∩ I_{L,S}`, agreeing with Mathlib's `SInteger` units
     for the corresponding set of finite places;
  3. `I_{L,S} = ∏_{v ∈ S} ∏_{w ∣ v} L_wˣ × ∏_{v ∉ S} ∏_{w ∣ v} 𝒪_wˣ` as `G`-modules, the second
     factor a restricted product;
  4. the criterion for `S`: `I_L = I_{L,S} · Lˣ` iff the classes of the primes in `S_L` generate
     `ClassGroup (𝓞 L)`, together with the fact that some finite `S` works (class-group
     finiteness from Layer 2A);
  5. hence `C_L ≅ I_{L,S} / 𝓞_{L,S}ˣ` for such `S`, as `G`-modules;
  6. the transition maps `I_{L,S} ↪ I_{L,S'}` for `S ⊆ S'`, forming a directed system;
  7. `I_L = colim_S I_{L,S}` as `G`-modules, with the colimit filtered;
  8. finite-group cohomology commutes with filtered colimits of modules, so
     `H^i(G, I_L) = colim_S H^i(G, I_{L,S})` in every degree (the cochain complex involves
     finitely many variables, so this is a statement about the explicit complex);
  9. the assembly `H^i(G, I_{L,S}) ≅ ⊕_{v ∈ S} H^i(G_w, L_wˣ) ⊕ ⊕_{v ∉ S} H^i(G_w, 𝒪_wˣ)` from
     Shapiro's lemma applied to Layer 2B's coinduced description, together with the vanishing of
     `H^i(G_w, 𝒪_wˣ)` for `i ≥ 1` at unramified `v` (consumed from the local roadmap's Layer 2),
     giving `H^i(G, I_L) ≅ ⊕_v H^i(G_w, L_wˣ)` for `i ≥ 1`.
  None of this may be hidden inside a single displayed equality.
- **Herbrand quotients.** For `L/K` cyclic, in order:
  1. `h(G, I_{L,S}) = ∏_{v ∈ S} [L_w : K_v]`, from 9 above, the local Herbrand quotient
     `h(G_w, L_wˣ) = [L_w:K_v]` at finite places (consumed from the local roadmap's Layer 5,
     which is finite-level and can proceed in parallel), and the archimedean factors of
     Layer 2C, where the same formula holds with `h(Gal(ℂ/ℝ), ℂˣ) = 2`;
  2. the logarithmic `S`-unit lattice: the map `𝓞_{L,S}ˣ → ⊕_{w ∈ S_L} ℝ`, `u ↦ (log ‖u‖_w)_w`,
     with finite kernel `μ(L)` and image a lattice of rank `#S_L − 1` in the trace-zero
     hyperplane (Dirichlet's `S`-unit theorem, a milestone here at the pin, with a refactor note
     for PR #40791);
  3. the `ℝ[G]`-module comparison `ℝ ⊗ 𝓞_{L,S}ˣ ≅ ℝ[S_L] / ℝ`, where `ℝ[S_L]` is the
     permutation module on the places above `S` and `ℝ` carries the trivial action;
  4. invariance of the Herbrand quotient under an equivariant map with finite kernel and
     cokernel, hence under any comparison that becomes an isomorphism after tensoring with `ℝ`;
  5. the Herbrand quotient of a permutation lattice: `h(G, ℤ[G/H]) = #H` by Shapiro, so
     `h(G, ℤ[S_L]) = ∏_{v ∈ S} [L_w:K_v]` and `h(G, ℤ) = [L:K]`;
  6. combining: `h(G, 𝓞_{L,S}ˣ) = (∏_{v ∈ S} [L_w:K_v]) / [L:K]`, and therefore
     **`h(G, C_L) = [L:K]`**, whence `herbrand_ge`: `[C_K : N_{L/K} C_L] ≥ [L:K]`, since
     `H¹(G, C_L)` is finite.
  The sentence "the Herbrand quotient depends only on `ℝ ⊗ M`" is the content of 4, and is a
  target, not a remark.
- **`kummer_le`.** For `L/K` cyclic, `[C_K : N C_L] ≤ [L:K]`, by the algebraic route
  (Chevalley; Milne CFT VII §6, Lang ANT IX, Janusz V §§2–4), decomposed as:
  1. reduction from cyclic degree `n` to cyclic steps of prime degree `p`, by multiplicativity
     of the index in a tower;
  2. base change to `K' = K(μ_p)`, whose degree over `K` divides `p − 1` and is prime to `p`,
     with the index inequality transported by restriction and corestriction;
  3. the descent lemma returning from `K'` to `K`, stated with its exact hypotheses;
  4. Kummer classification once `μ_p ⊆ K`: `L = K(a^{1/p})` for some `a ∈ Kˣ`, in the
     vocabulary of `Mathlib/FieldTheory/KummerExtension.lean`;
  5. the choice of `S`, containing the infinite places, the places above `p`, the ramified
     places, and enough places for `I_K = I_{K,S}·Kˣ`, together with the `S`-unit Kummer exact
     sequence;
  6. finiteness and the dimension count for `Kˣ_S/(Kˣ_S)^p` as an `𝔽_p`-space, from the `S`-unit
     theorem;
  7. the counting lemma giving `[I_K : Kˣ · N I_L · U] ≤ p` for the relevant open subgroup `U`;
  8. induction back up the tower.
  The analytic route through Dirichlet density (the ClassFieldTheory blueprint's choice) is
  deliberately not used, since it would make reciprocity depend on the L-functions sibling.
  Record it as the alternative proof these statements must stay compatible with.
- **The class field axiom, packaged.** For `L/K` cyclic: `#Ĥ⁰(G, C_L) = [L:K]` and
  `H¹(G, C_L) = 1`, spelled at the pin as a norm-quotient cardinality and an `H¹`, refactoring
  onto `TateCohomology` at the first bump. Then the extension to arbitrary finite Galois `L/K`,
  in two named steps rather than one appeal to induction:
  1. solvable induction using inflation and restriction (the pin's `LongExactSequence` and
     `Functoriality`) gives `H¹(G, C_L) = 1` and `#H²(G, C_L) ≤ #G` for `G` solvable, in
     particular for `p`-groups;
  2. for general `G`, restrict to a Sylow `p`-subgroup `G_p` and use that corestriction composed
     with restriction is multiplication by `[G : G_p]`, which is prime to `p`: the `p`-primary
     component of `H^i(G, C_L)` injects into `H^i(G_p, C_L)`. Applying step 1 to
     `L/L^{G_p}` kills the `p`-part of `H¹` and bounds the `p`-part of `H²` by `#G_p`, and
     multiplying over the primes dividing `#G` gives `H¹(G, C_L) = 1` and `#H²(G, C_L) ≤ [L:K]`.
  Corollary package: `N_{L/K} C_L` has finite index dividing `[L:K]` in `C_K` for every finite
  Galois `L/K`.
- **The Hasse norm theorem, and its exact range.** For **cyclic** `L/K`: `x ∈ Kˣ` is a norm from
  `Lˣ` iff it is a local norm at every place, deduced from `H¹(G, C_L) = 1` and the exact
  sequence `1 → Lˣ → I_L → C_L → 1`. State the cyclic hypothesis prominently, and state the
  failure as a theorem rather than as a warning:
  1. the knot group `Kn(L/K) := (Kˣ ∩ N_{L/K} I_L) / N_{L/K} Lˣ`, trivial exactly when the Hasse
     norm principle holds for `L/K`;
  2. Tate's description of the knot group through `Ĥ^{-3}(G, ℤ) ≅ H₂(G, ℤ)` and the local
     groups `Ĥ^{-3}(G_v, ℤ)`: for `G ≅ (ℤ/2)²` the global group is `ℤ/2`, and if every
     decomposition group is a proper, hence cyclic, subgroup then every local group vanishes and
     the knot group is `ℤ/2`;
  3. the explicit instance: for `L = ℚ(√13, √17)`, the rational `25` is a norm from `L_w/ℚ_v` at
     every place `v` and is not a norm from `L` (Cassels–Fröhlich Exercise 5.3; Milne CFT
     VIII §3). Both halves are milestones: the local assertion at each place, and the global
     negation.
### Layer 6: the global Artin map and the reciprocity law

From here on the local-fields roadmap's Layer 7 (local Artin maps with the arithmetic-Frobenius
normalization, norm-group lattices, local conductors) is essential, together with Layer 2C at
the infinite places.

- **The compilation map, and what it needs.** For `L/K` finite abelian, `θ_{L/K} : I_K →*
  Gal(L/K)`, `θ((x_v)_v) = ∏_v Art_{K_v}(x_v)∣_L`. The definition is short and its ingredients
  are not, so each is a target:
  1. for a place `v` of `K` and a chosen `w ∣ v` in `L`, the identification of `Gal(L_w/K_v)`
     with the decomposition group at `w` (consumed from Number Field Arithmetic at finite places,
     from Layer 2C at infinite ones);
  2. independence of the choice of `w`, which holds because `L/K` is abelian, so that the local
     factor is well defined;
  3. the resulting local factor `Art_{K_v}(·)∣_L : K_vˣ →* Gal(L/K)`, at finite places from the
     local roadmap's Artin map and at infinite places from `Art_ℝ` and `Art_ℂ`;
  4. triviality at almost all places: if `v` is unramified in `L` and `x_v ∈ 𝒪_vˣ` then
     `Art_{K_v}(x_v)∣_L = 1` (the local roadmap's unramified norm statement), which is what makes
     the product finite on each idele;
  5. well-definedness of the product on the restricted product, and its multiplicativity;
  6. continuity of `θ_{L/K}`;
  7. compatibility with ideles supported at a single place, `θ(ι_v(x)) = Art_{K_v}(x)∣_L`, which
     is the local-global compatibility statement everything downstream consumes and which holds
     by construction here;
  8. functoriality in `L`, so that `θ_{M/K}` restricts to `θ_{L/K}` for `K ⊆ L ⊆ M`.
- **Surjectivity, without density.** The image contains `Frob_v` for every unramified `v`, so
  the chain is: if the image were a proper subgroup, its fixed field would be a nontrivial
  subextension `M/K`, which we may take cyclic; the compiled map to `M` is then trivial, so
  every local Artin map to `M` is trivial; by local reciprocity every place of `K` then splits
  completely in `M` and every local norm map `N_{M_w/K_v}` is surjective; Layer 2B's component
  formula for the idele norm makes `N_{M/K} : I_M → I_K` surjective, so `N_{M/K} C_M = C_K` and
  the norm index is `1`; this contradicts `herbrand_ge` for nontrivial cyclic `M/K`. No
  Chebotarev-style argument may be imported here (Janusz V §5; Artin–Tate).
- **The reciprocity law.** `θ_{L/K}(Kˣ) = 1`, that is `∏_v Art_{K_v}(x)∣_L = 1` for `x ∈ Kˣ`.
  Pinned route, in two stages.
  1. Cyclotomic extensions of `ℚ`, by direct computation: Layer 4's anchor together with the
     local roadmap's cyclotomic-orientation clause `χ_cyc(Art(u)) = u⁻¹`, plus the archimedean
     factor from Layer 2C. The two roadmaps' conventions meet at this milestone, and a sign
     error anywhere upstream shows up here, which is its purpose. The base-change statement,
     that reciprocity for `K(ζ_n)/K` follows from the case over `ℚ`, is a separate named lemma
     using the norm compatibility of the local Artin maps.
  2. General abelian `L/K`, by Artin's crossing argument. Spell out the diagram rather than
     naming the argument:
     - the **crossing lemma**: given `L/K` cyclic of degree `n` and a finite set `S` of places,
       there is a cyclotomic extension `E/K` with `L ∩ E = K`, with `LE/E` contained in a
       cyclotomic extension of `E`, and with the places of `S` splitting completely in `E/K`;
     - restriction `Gal(LE/E) ≃ Gal(L/K)`, an isomorphism because `L ∩ E = K`;
     - the transport lemma: `θ_{LE/E}(y)∣_L = θ_{L/K}(N_{E/K} y)` for `y ∈ I_E`, from the local
       norm compatibility of the local Artin maps, which carries triviality on principal ideles
       of `E` down to principal ideles of `K`;
     - the induction: on the degree `n`, reducing a general finite abelian `L/K` to cyclic
       steps, with the norm-index equalities of Layer 5 used to control the index at each step
       and to know that the two sides have the same order;
     - the places in `S`, chosen to contain the ramified ones, so that the local factors that
       are not yet under control are trivial.
     Follow Lang ANT Ch. X §§1–3 and Janusz Ch. V §5 for the exact form of the lemma and the
     induction, and cite the section used for each step. No analytic input is permitted at any
     step.
- **The norm-residue isomorphism.** With Layer 5: `θ_{L/K}` descends to
  `C_K ⧸ N_{L/K} C_L ≃* Gal(L/K)` for finite abelian `L/K`, the two groups having the same
  finite order by `herbrand_ge` and `kummer_le` and the map being surjective. Functoriality
  package: towers (`θ_{M/K}` restricts to `θ_{L/K}`), base change along `K'/K` (compatibility
  with the idele-class norm and with restriction of automorphisms), and the compatibility with
  the transfer, which is stated in Layer 8 where it is used. The nonabelian statement
  `C_K/N C_L ≃ Gal(L/K)^{ab}` is **not** a corollary of this one and belongs to Layer 7, where
  norm limitation is available.
- **Ramification and the conductor.** For finite abelian `L/K` and `v` a finite or real place:
  `v` is unramified in `L` iff the local component of `N_{L/K} C_L` contains the full local unit
  group at `v` (all of `ℝˣ` at a real place) iff `v ∤ 𝔣(L/K)`, with `𝔣(L/K)` the conductor of
  the conventions table; and the local assembly `𝔣(L/K) = ∏_v 𝔣_v`, with the finite local
  conductors consumed from the local roadmap's Layer 7 and the real ones from Layer 2C.
  Higher-ramification and upper-numbering refinements stay in the local roadmap; what is global
  here is only the assembly.

### Layer 7: norm groups, norm limitation, the existence theorem, and ray class fields

All the fields in this layer and the next are intermediate fields of one fixed algebraic
closure `K̄`, as pinned in the conventions table; composita and intersections mean the
operations inside `K̄`, and profinite identifications are `ContinuousMulEquiv`s.

- **The norm-group lattice.** `N(L/K) := (Kˣ · N_{L/K}(I_L))/Kˣ ≤ C_K` for finite abelian `L/K`:
  the map `L ↦ N(L/K)` is inclusion-reversing and injective, `N(LL') = N(L) ∩ N(L')`, and
  `N(L ∩ L') = N(L)·N(L')`, which together are the Takagi correspondence between finite abelian
  extensions and their norm groups.
- **Norm limitation.** For an arbitrary finite extension `L/K` inside `K̄`, with `L^{ab}` the
  maximal subextension abelian over `K`: `N_{L/K} C_L = N_{L^{ab}/K} C_{L^{ab}}`, so norm groups
  see exactly the abelian part. Its consequence, and the right home for the statement Layer 6
  hands over: for finite Galois `L/K`, `C_K / N_{L/K} C_L ≃* Gal(L/K)^{ab}`, obtained by applying
  the norm-residue isomorphism to `L^{ab}/K` and identifying `Gal(L^{ab}/K)` with
  `Gal(L/K)^{ab}`. It is not a weaker half of the abelian theorem; it needs norm limitation.
- **The existence theorem.** Every open subgroup of finite index in `C_K` is `N(L/K)` for a
  unique finite abelian `L/K`. Decompose it:
  1. reduction to subgroups containing some `RaySubgroup 𝔪`, by Layer 2A's open-subgroup lemma;
  2. the cyclic prime-index case as the atom of the induction;
  3. the Kummer construction when `μ_p ⊆ K`: realize the subgroup by an explicit
     `K(a^{1/p})`-type extension built from `S`-units, reusing the Layer 5 counting;
  4. the cyclotomic base change when `μ_p ⊄ K`, adjoining `μ_p` and controlling the degree,
     which is prime to `p`;
  5. the descent step returning the extension and its norm group to `K`, with the exact
     hypotheses under which the norm group is preserved;
  6. induction on the finite abelian quotient `C_K/U`, using compatibility of norm groups with
     quotients;
  7. compositum and intersection compatibility, so that the extensions built for the factors
     assemble;
  8. control of ramification and of the conductor of the extension produced;
  9. uniqueness, from the norm-residue isomorphism and the injectivity of `L ↦ N(L/K)`.
  Neukirch ANT VI §6 is the reference for the route; pin the hypotheses of each step there.
  Openness is **not** automatic from finite index: `D_K` is divisible and so lies in every
  finite-index subgroup, but `π₀(C_K) ≅ Gal(K^{ab}/K)` is not topologically finitely generated,
  so with choice it has dense subgroups of finite index, which pull back to non-open
  finite-index subgroups of `C_K`. The openness hypothesis is doing real work; state the
  contrast with the local case, where finite index behaves differently.
- **Ray class fields.** `K_𝔪`, the abelian extension inside `K̄` with `N(K_𝔪/K) = RaySubgroup 𝔪`,
  which exists by the existence theorem and is unique by the lattice correspondence:
  `Gal(K_𝔪/K) ≃* Cl_𝔪 K` by composing with Layer 2A's dictionary; ramification support contained
  in the support of `𝔪`; and the **splitting law**: for `𝔭 ∤ 𝔪₀`, the Frobenius at `𝔭`
  corresponds to the class `[𝔭]`, so `𝔭` splits completely in `K_𝔪` iff `𝔭 ∈ P_𝔪`. The
  transition maps `K_𝔪 ⊆ K_𝔫` for `𝔪 ∣ 𝔫` correspond to the Layer 1 surjections `Cl_𝔫 ↠ Cl_𝔪`.
- **The ideal-theoretic dictionary.** For finite abelian `L/K` of conductor dividing `𝔪`, the
  Number Field Arithmetic roadmap's ideal-theoretic Artin map `J^𝔪 →* Gal(L/K)` is surjective
  with kernel `P_𝔪 · N_{L/K}(J_L^𝔪)`, and agrees with the idelic map under the Layer 2A
  isomorphism. This is Takagi's classification in ideal terms and the form quadratic genus
  theory consumes; the map itself is consumed, not redefined, and this milestone is the class
  field theory about it.
- **The profinite Artin map.** `K^{ab} = ⨆_𝔪 K_𝔪` inside `K̄`, and
  `Gal(K^{ab}/K) ≃ lim_𝔪 Cl_𝔪 ≃ C_K/D_K` as topological groups, so `Art_K : C_K → Gal(K^{ab}/K)`
  is continuous and surjective with kernel `D_K`. State the compatibility of the limit with the
  transition maps of Layers 1 and 2A, and give the identification as a `ContinuousMulEquiv`.
- **The `ℚ` instance.** The ray class field of `ℚ` for the modulus `(n)·∞` is `ℚ(ζₙ)`:
  containment because Layer 4 exhibits the norm group of `ℚ(ζₙ)` as containing
  `RaySubgroup ((n),∞)`, and equality by the degree count
  `#Cl_{(n)∞}(ℚ) = φ(n) = [ℚ(ζₙ) : ℚ]`. This is the pre-Kronecker–Weber form of Layer 9, and it
  gives `Gal(ℚ^{ab}/ℚ) ≅ lim_n (ℤ/n)ˣ = Ẑˣ` as topological groups.

### Layer 8: the Hilbert class field and the principal ideal theorem

Statement shapes aligned with Mathlib PR #40661's wanted statements; report divergences there.

- **The Hilbert class field.** `H = K_{((1),∅)}`, with `Gal(H/K) ≃* ClassGroup (𝓞 K)`; `H/K` is
  unramified at every place, `Algebra.Unramified (𝓞 K) (𝓞 H)` at the finite ones and
  `IsUnramifiedAtInfinitePlaces K H` at the real ones (the pin's two vocabularies, both kept
  first-class, which is why Layer 0 carried real places); and it is maximal in the exact sense
  that **every finite abelian extension of `K` inside `K̄` that is unramified at all places,
  finite and infinite, is contained in `H`**. Say "maximal finite abelian unramified
  everywhere" rather than "maximal such": since the class group is finite, `H` is in fact the
  largest unramified abelian extension outright, but the theorem to state is the containment
  above, and an unbound "such" is what makes the narrow variant confusing. A prime `𝔭` splits completely in `H` iff it is principal;
  `H = K` iff `h_K = 1`. The **narrow** Hilbert class field `H⁺ = K_{((1), all real places)}`
  has `Gal(H⁺/K) ≅ Cl⁺ K` and is the maximal finite abelian extension unramified at all finite
  places, with no condition at the infinite ones. **Interface milestone (Multiquadratic
  Layer 3):** the genus field of a quadratic `K/ℚ` is the maximal subfield of `H` (respectively
  of `H⁺`) that is abelian over `ℚ`, and `Gal(H/K) ↠ Gal(K_gen/K)` realizes `Cl ↠ Cl/Cl²`;
  state this compatibility here, in the multiquadratic roadmap's vocabulary.
- **Capitulation and the principal ideal theorem.** The extension map
  `ClassGroup (𝓞 K) →* ClassGroup (𝓞 H)` is the pin's `ClassGroup.extendedHom`, and the theorem
  is `ClassGroup.extendedHom (𝓞 K) (𝓞 H) = 1`: every ideal of `K` becomes principal in `H`. The
  route needs four targets, none of which should be inlined:
  1. `H'`, the Hilbert class field of `H`, is Galois over `K` (its formation is canonical, so
     the `K`-conjugates of `H'` all agree);
  2. with `G = Gal(H'/K)`, the subgroup `Gal(H'/H)` is the commutator subgroup `[G, G]`, from
     `Gal(H/K)` abelian and the maximality in the previous item;
  3. under the reciprocity isomorphisms of Layer 6, the extension-of-ideals map corresponds to
     the group-theoretic transfer `G^{ab} → Gal(H'/H)^{ab}`, which is an instance of the Layer 6
     functoriality package and is stated here because this is where it is used;
  4. Furtwängler's theorem in `Mathlib/GroupTheory/Transfer.lean` vocabulary: for a finite
     group `G`, the transfer `G^{ab} → ([G,G])^{ab}` is trivial. This is pure group theory, it
     is reusable, and it should be developed as such rather than inlined into the number-theory
     file.
  `H'/K` is Galois but usually not abelian, so the argument lives in `Gal(H'/K)`; set the
  two-step tower up carefully, since this is where the classical literature hides its
  bookkeeping.

### Layer 9: Kronecker–Weber and the conductor–discriminant formula

- **Kronecker–Weber.** Every finite abelian `L/ℚ` embeds in some `ℚ(ζₙ)`, directly from
  Layer 7's `ℚ` instance: the conductor of `L/ℚ` divides `(n)·∞` for some `n`, so
  `L ⊆ ℚ_{(n)∞} = ℚ(ζₙ)`. State both of PR #40661's forms
  (`∃ n, Nonempty (L →ₐ[ℚ] CyclotomicField n ℚ)` and the `IsAlgClosed.lift`-range form), and the
  sharp version: the least such `n` is the finite part of the conductor of `L/ℚ`, normalized as
  in Layer 4, so that the least `n` is never `≡ 2 (mod 4)`. The textbook route through local
  Kronecker–Weber and ramification bounds is subsumed here: through Layers 6 and 7 the proof is
  shorter than the elementary one, so do not build the elementary route as a prerequisite (the
  stalled Akwardbro/RamificationGroup project aimed that way; cite it, do not follow it).
- **Conductor–discriminant, abelian case.** For finite abelian `L/K`:
  `d_{L/K} = ∏_{χ} 𝔣₀(χ)`, the product over the characters of `Gal(L/K)` of the finite parts of
  the conductors of the corresponding ray class characters, through Layer 3's dictionary applied
  to `χ ∘ θ_{L/K}`. Route: localize, using that the different is the product of the local
  differents (this globalization belongs to the Number Field Arithmetic roadmap's different and
  discriminant layer, so consume it, and if this roadmap runs ahead, state the shared lemma in
  both places as agreed there), and then apply the local conductor–discriminant formula of the
  local roadmap (Serre, *Corps Locaux*, Ch. VI §3). Worked instance: over `ℚ` the formula
  reproduces the pin's `Cyclotomic/Discriminant.lean` values for `disc(ℚ(ζₙ))`, an end-to-end
  consistency check across three developments. The general Artin-conductor formula for
  nonabelian extensions belongs to the ArtinRepresentations roadmap of the next wave; state the
  abelian scope explicitly.
### Layer 10A: continuous and algebraic infinity types

The character theory that Layer 3 leaves to this layer, stated first as a reusable local
classification and only then as a condition on Hecke characters.

- **Continuous characters of the archimedean groups.** Every continuous homomorphism
  `ℝˣ → ℂˣ` is `x ↦ |x|^s · sgn(x)^ε` for a unique `s ∈ ℂ` and `ε ∈ {0,1}`; every continuous
  homomorphism `ℂˣ → ℂˣ` is `z ↦ (z/|z|)^k · |z|^s` for a unique `k ∈ ℤ` and `s ∈ ℂ`,
  equivalently `z ↦ z^p z̄^q` with `p, q ∈ ℂ` and `p − q ∈ ℤ`, the translation between the two
  coordinate systems being `k = p − q` and `s = p + q`. Prove both classifications; they are
  reusable and Mathlib does not have them.
- **The infinity type of a Hecke character.** The restriction of `χ` to the archimedean part of
  the ideles, `χ_∞ = ∏_{w ∣ ∞} χ_w` with each `χ_w` classified as above.
- **Algebraic characters (Weil's type `A₀`).** `χ` is algebraic when `χ_∞` is the restriction of
  an algebraic character of the torus, that is when there are integers `n_σ`, one for each
  embedding `σ : K → ℂ`, with `χ_∞(x) = ∏_σ σ(x)^{n_σ}` on the identity component. At a real
  embedding this is `x ↦ x^{n_σ}`; at a complex place, with `σ` and `σ̄` the two conjugate
  embeddings, it is `z ↦ z^{n_σ} z̄^{n_{σ̄}}`, so in `(z/|z|)^k |z|^s` coordinates the radial
  exponent is `s = n_σ + n_{σ̄}` and **is not zero in general**. The definition "all `s_w = 0`
  with integer exponents" is not the algebraicity condition and would exclude the algebraic norm
  twists; do not use it. State explicitly: the relation between the exponents at conjugate
  embeddings and the weight; the condition that `∏_σ σ(u)^{n_σ} = 1` for units `u` in a
  finite-index subgroup of `𝓞_Kˣ`, which is what allows the infinity type to occur in a Hecke
  character at all and which forces `n_σ` to be constant unless `K` contains a CM subfield; the
  pure case, where `n_σ + n_{σ̄}` is a constant weight; and the norm twists `χ · ‖·‖^m`, which
  are algebraic whenever `χ` is.
- **The associated ideal-side character.** For an algebraic `χ` of conductor `𝔣`, the induced
  character on ideals prime to `𝔣` takes values in a number field, namely the field generated by
  its values, and it is *this* object that has a number field of values. The full idelic
  character does not: its values on archimedean elements are transcendental in general. State
  the ideal-side character, its multiplicativity, and the field-of-values theorem, and keep the
  claim attached to the right object.
- The canonical examples: `‖·‖` (Layer 2A), the finite-order characters (Layer 3), and the
  algebraic characters of imaginary quadratic fields attached to CM elliptic curves, stated here
  as the interface the AbelianVarieties/CM roadmap of the next wave will instantiate. The main
  theorem of complex multiplication is theirs; the character-side vocabulary is fixed here.

### Layer 10B: orders and their Picard groups

Mathlib has no theory of nonmaximal orders in a number field at the pin, and the Dedekind-generic
machinery of Layers 0 and 1 does not apply to them, since an order is usually not integrally
closed. Build the theory here.

1. An **order** `O ⊆ 𝓞 K`: a subring that is free of rank `[K:ℚ]` over `ℤ` and has `K` as its
   field of fractions; equivalently a full-rank subring, in the vocabulary of `Module.Finite`
   and `IsFractionRing`. Basic examples, including `ℤ[√−n]` and `ℤ + f𝓞_K`.
2. The **conductor** `𝔠(O) = {x ∈ K | x 𝓞_K ⊆ O}`, the largest `𝓞_K`-ideal contained in `O`,
   with its annihilator characterization and the index formula `disc O = [𝓞_K : O]² disc 𝓞_K`.
3. **Proper (invertible) fractional `O`-ideals**: `I` with `{x ∈ K | xI ⊆ I} = O`, the
   equivalence with invertibility, and the group they form.
4. The identification of Mathlib's generic `ClassGroup O` with the Picard group `Pic O` of this
   group modulo principal ideals; if the generic definition does not agree, say which object is
   the target and prove the comparison.
5. **Extension and contraction** between proper `O`-ideals prime to `𝔠(O)` and `𝓞_K`-ideals
   prime to `𝔠(O)`: mutually inverse multiplicative bijections.
6. The exact principal congruence subgroup: `Pic O ≅ J^{𝔠}(𝓞_K) / P_{ℤ,𝔠}`, where `P_{ℤ,𝔠}` is
   the group of principal ideals `(α)` with `α ≡ a (mod 𝔠 𝓞_K)` for some rational integer `a`
   prime to `𝔠`. This is the statement that makes `Pic O` a ray-class-style quotient and the
   only reason Layer 7 can produce a class field for it.
7. **Finiteness** of `Pic O`, with the classical index formula in terms of `h_K`, the conductor,
   and the unit index.
8. Specialization: for `O = 𝓞_K` everything above reduces to Layer 1, and the class field of
   the next sublayer to the Hilbert class field.

### Layer 10C: ring class fields and representation by quadratic forms

- **Ring class fields.** For an order `O` in `K` with conductor `𝔠`, the **ring class field**
  `H_O` is the abelian extension of `K` inside `K̄` corresponding, through Layer 7's existence
  theorem, to the congruence subgroup of 10B.6, so that `Gal(H_O/K) ≅ Pic O`; its ramification
  divides `𝔠`; and `H_{𝓞_K} = H`. Definitions for all `K`; the worked examples are imaginary
  quadratic, following Cox.
- **The `x² + ny²` theorem.** Fix `n ≥ 1` and put `O_n = ℤ[√−n]`, an order in `K = ℚ(√−n)` of
  discriminant `−4n`, maximal exactly when `−n ≢ 1 (mod 4)`. For a prime `p ∤ 2n`, the chain to
  prove, each link a milestone:
  1. `p = x² + ny²` for some integers `x, y`;
  2. iff there is a proper `O_n`-ideal of norm `p`, equivalently `p` is represented by the
     principal form of discriminant `−4n`;
  3. iff some prime of `O_n` above `p` is principal, that is trivial in `Pic O_n`;
  4. iff `p` splits completely in `H_{O_n}` **as an extension of `ℚ`**, which for `p ∤ 2n`
     amounts to `p` splitting in `K/ℚ` and the primes above it splitting completely in
     `H_{O_n}/K`; prove that equivalence rather than leaving the base field ambiguous.
  The last step is Layer 7's splitting law applied to the ring class field.
- **Instances.** `n = 5`: `O_5 = ℤ[√−5] = 𝓞_K` is maximal, `h = 2`, `H = ℚ(√−5, i)`, and
  `p = x² + 5y² ⟺ p ≡ 1, 9 (mod 20)` for `p ≠ 2, 5`. Both halves are wanted: the congruence
  criterion, which is elementary and provable without class field theory, **and** the
  class-field statement that the congruence describes complete splitting in `H`; only the second
  tests this roadmap. `n = 14`: again `𝓞_K = ℤ[√−14]` is maximal (`disc = −56`), `h = 4`, and
  the Hilbert class field is `H = ℚ(√−14, α)` with `α⁴ + 2α² − 7 = 0`, that is
  `α = √(2√2 − 1)`, of degree `8` over `ℚ`; `p = x² + 14y² ⟺ p` splits completely in `H`
  (checked against `p < 400`). `n = 27`: the genuinely nonmaximal instance, and the one that
  tests Layer 10B, since `O = ℤ[√−27] = ℤ + 6𝓞_K` has discriminant `−108` and conductor `6` in
  `𝓞_{ℚ(√−3)}`, with `Pic O ≅ ℤ/3` and ring class field `ℚ(√−3, ∛2)`; Gauss's criterion
  `p = x² + 27y² ⟺ p ≡ 1 (mod 3)` and `2` is a cubic residue modulo `p` is then the splitting
  law in that field (checked against `p < 600`).
- **On the absence of congruence criteria.** That no congruence condition on `p` alone can
  decide `p = x² + 14y²` is a statement about the distribution of Frobenius elements and needs
  Chebotarev, which belongs to the L-functions roadmap. Keep it as explanatory prose here, or
  state it as a target there; do not list it as a deliverable of this roadmap.

### Layer 11: the global class formation and the local-global compatibilities

Consumes the ProfiniteCohomology roadmap (continuous cohomology of `G_K`, colimits over finite
quotients) and reuses Layer 5's finite computations.

- **The formation.** `(Gal(K̄/K), colim_L C_L)` is a class formation: `H¹ = 1` from Layer 5,
  `H²(Gal(L/K), C_L)` cyclic of order `[L:K]` with compatible invariant maps
  `inv_{L/K} : H²(Gal(L/K), C_L) ≃ (1/[L:K])ℤ/ℤ`, and the **fundamental class** `u_{L/K}` with
  `inv(u_{L/K}) = 1/[L:K]`, constructed from the cyclic cyclotomic case by the inflation
  bookkeeping the ClassFieldTheory blueprint sketches. Package it in the `FiniteClassFormation`
  shape shared with the local roadmap. Tate–Nakayama in degree `−2` then re-derives Layer 6's
  reciprocity isomorphism, and the milestone is the **compatibility theorem** that the two
  constructions agree, which is the honest content of "the cohomological route" given the route
  pinned above.
- **Sum of local invariants.** The exact sequence
  `0 → H²(G_K, K̄ˣ) → ⊕_v H²(G_{K_v}, K̄_vˣ) → ℚ/ℤ → 0` in invariant-map coordinates, with the
  local invariants at finite places consumed from the local roadmap and at infinite places from
  Layer 2C, and the reciprocity statement `∑_v inv_v(α) = 0` for a global class. This is the
  data the Honda–Tate-facing roadmap of the next wave needs.
- **Hilbert reciprocity.** `∏_v (a, b)_v = 1` for `a, b ∈ Kˣ`, the product formula for Hilbert
  symbols, with the local symbols consumed from the local roadmap's Layer 8 at finite places and
  from Layer 2C at the real ones. This is the interface QuaternionArithmetic consumes for its
  classification by ramification sets, and quadratic reciprocity over `ℚ` falls out as the
  worked example, proving Mathlib's `legendreSym` reciprocity again from the global theory as
  the end-to-end check.
- **Scope, stated definitely.** Everything in this layer is phrased in Galois cohomology. The
  translation to central simple algebras, division algebras, and a Brauer-group API is **out of
  scope** and belongs to a separate Brauer/central-simple-algebra roadmap, which is also where
  "division algebras over `K` correspond to local invariants summing to zero" would be proved:
  this layer supplies the `H²` half of that statement and no algebras. Mathlib has Brauer-group
  vocabulary only in `Defs` at the pin, and the Whysoserioushah/BrauerGroup staging is watched,
  not depended on. Likewise, cohomological dimension statements and `H³` of number fields are
  **not** targets here: the Poitou–Tate duality theory (NSW VIII–IX) is the successor roadmap,
  and the boundary is recorded so that nobody reads Layer 11 as a down payment on it.

### Long horizon (direction, not this roadmap's deliverables)

Poitou–Tate duality and the full cohomology of number fields (NSW VIII–IX) on top of Layer 11;
explicit reciprocity laws and power-residue symbols (Neukirch ANT VI §8); the Grunwald–Wang
phenomenon, whose classical trap is that "an element that is an `n`-th power locally everywhere
is a global `n`-th power" is **false** for `8 ∣ n` (Milne CFT VIII §§1–2), stated here as a
warning label and developed in the horizon; Tate's thesis (the L-functions roadmap's route
decision); the function-field and geometric theory; explicit class field theory beyond CM
(Stark's conjectures, Hilbert's twelfth problem).
## Worked examples (acceptance criteria)

Discharge these alongside the layers; each catches a specific failure mode (a vacuous object, a
wrong normalization, a dropped real place, a unit-obstruction error).

- **`Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`, and Dirichlet characters** (Layers 1, 3, 4). The ray class
  group of `ℚ` for the modulus `(n)·∞` is `(ℤ/n)ˣ`, with the contrast
  `Cl_{(n)}(ℚ) ≃* (ℤ/n)ˣ/{±1}` as the unit-obstruction check, and the induced equivalence
  between finite-order Hecke characters with `U_{(n)∞} ⊆ ker χ` and `DirichletCharacter ℂ n`,
  compatible with conductors.
- **Parity, and the character that does not exist** (Layer 3). `Cl_{((1),∞)}(ℚ) = 1`, so `ℚ` has
  no nontrivial Hecke character whose ray conductor is the infinite place alone. The smallest
  odd example is `ZMod.χ₄`: finite conductor `4`, ray conductor `(4)·∞`, `χ(−1) = −1`, and the
  real sign component nontrivial exactly because of that.
- **Sign surjectivity, and its failure for units** (Layers 0, 1). `ℚ(√3)` has `h = 1` and
  `Cl⁺ ≅ ℤ/2`: its fundamental unit `2 + √3` is totally positive, so the sign map on units is
  not surjective, while the sign map on `Kˣ` is (Layer 0). By contrast `ℚ(√2)` has
  `Cl⁺ = Cl = 1`, since the unit `1 + √2` has norm `−1`. These two fields are the smallest
  discriminating pair for a narrow-class implementation, and `ℚ(√3)` is the multiquadratic
  roadmap's Layer 3 test case.
- **Splitting and ramification in `ℚ(ζₙ)`** (Layer 4). For `p ∤ n`, `p` splits completely iff
  `p ≡ 1 (mod n)`, the Frobenius at `p` is `[p]`, and `[ℚ(ζₙ):ℚ] = φ(n)`. Ramification is stated
  through the normalized level: the ramified finite primes are those dividing `n₀`, with
  `n₀ = n/2` for `n ≡ 2 (mod 4)` and `n₀ = n` otherwise, and the infinite place ramifies exactly
  when `n₀ ≥ 3`. Include `n = 6` as the instance that refutes "ramified exactly at the `p ∣ n`".
- **A norm index and the Hasse norm theorem** (Layer 5). `[C_ℚ : N C_{ℚ(√5)}] = 2`, and a
  rational is a norm from `ℚ(√5)` iff it is a local norm at every place.
- **Failure of the norm principle for a biquadratic field** (Layers 5 and 11). For
  `L = ℚ(√13, √17)`, the rational `25` is a local norm at every place, being a square, and is
  **not** a norm from `L`; the knot group of `L/ℚ` has order `2`. The example is sharper than it
  looks: `4` and `9` are global norms from `L`, so squareness is not the point, and `5` itself
  is not even a local norm at `5`. Cassels–Fröhlich Exercise 5.3, p. 360, quoted in Milne CFT
  VIII §3. The observation that one local condition follows from the others by the Hilbert
  product formula belongs to Layer 11, not Layer 5, so state it there.
- **The Hilbert class field of `ℚ(√−5)`** (Layers 8, 10C). `h = 2` and `H = ℚ(√−5, i)`, which is
  also the genus field, hence the multiquadratic interface instance. The acceptance statement is
  the class-field one: for `p ≠ 2, 5`, `p` splits completely in `H` iff `p = x² + 5y²` iff
  `p ≡ 1, 9 (mod 20)`. The congruence equivalence alone is elementary and does not test this
  roadmap; the splitting equivalence does.
- **Kronecker–Weber in its smallest instances** (Layer 9). Every abelian `L/ℚ` lies in some
  `ℚ(ζₙ)`; sharply, `ℚ(i) ⊆ ℚ(ζ₄)`, `ℚ(√2) ⊆ ℚ(ζ₈)`, `ℚ(√5) ⊆ ℚ(ζ₅)`, with least levels `4`,
  `8`, `5`, which is the conductor computation in miniature.
- **The conductor of `ℚ(√d)`** (Layers 7, 9). It is `(|d_K|)` for `d > 0` and `(|d_K|)·∞` for
  `d < 0`, where `d_K = disc(ℚ(√d))`. The orientation check is built in: the real place ramifies
  exactly when `d < 0`, since complex conjugation is then the nontrivial automorphism, so the
  infinite part appears exactly for imaginary quadratic fields while the finite part is `|d_K|`
  in both cases (Janusz VI §1). An implementation that yields `∞ ∤ 𝔣` for `ℚ(i)` has the
  real-place convention backwards. Conductor–discriminant here reads `|d_K| = 𝔣₀(χ_d)`: the
  conductor of the quadratic character is the absolute discriminant.
- **Hilbert reciprocity implies quadratic reciprocity** (Layer 11). `∏_v (p, q)_v = 1` unpacked
  at odd primes `p ≠ q` gives
  `legendreSym p q * legendreSym q p = (−1)^{(p−1)(q−1)/4}`, with the local roadmap's
  `(−1,−1)_2 = −1` closing the case `v = 2` and Layer 2C closing `v = ∞`. Mathlib already proves
  quadratic reciprocity; deriving it again through eleven layers is the point, since it
  certifies every normalization at once.
- **`x² + 14y²` and `x² + 27y²`** (Layers 10B and 10C). For `n = 14`, `ℤ[√−14]` is the maximal
  order, `h = 4`, and `p = x² + 14y²` iff `p` splits completely in `H = ℚ(√−14, α)`, where
  `α⁴ + 2α² − 7 = 0` and `[H : ℚ] = 8`. For `n = 27`, the order `ℤ[√−27] = ℤ + 6𝓞_K` in `ℚ(√−3)` has
  discriminant `−108`, conductor `6`, and `Pic ≅ ℤ/3`; its ring class field is `ℚ(√−3, ∛2)`, and
  the splitting law there is Gauss's criterion that `p = x² + 27y²` iff `p ≡ 1 (mod 3)` and `2`
  is a cubic residue modulo `p`. The second example is the one that exercises Layer 10B, since
  the order is not maximal.

## Ordering and parallelism

Four lanes can run concurrently from day one: **(A)** Layers 0 and 1 (moduli, approximation, ray
classes; pin only); **(B)** Layer 2A (ideles; pin only, coordinating with PR #40735 and FLT);
**(C)** Layer 2C (the archimedean package; pin only, and small enough to be a good first
contribution) together with Layer 4 (the cyclotomic anchor, mostly consuming Roblot's files);
**(D)** Layer 5's `S`-idele and `S`-unit cohomology, which needs 2A and 2B but not the
reciprocity core, alongside the local roadmap's Layer 5, itself parallel-safe. Layer 8's
Furtwängler theorem is free-standing group theory and can be developed at any time.

The dependency table, in the same order:

| stage | content | prerequisites |
|---|---|---|
| 0 | moduli, simultaneous approximation, congruence subgroups of `Kˣ` | pin only |
| 1 | ray and narrow class groups, moving lemma, exact sequence, finiteness | 0 |
| 2A | ideles, topology, norm-one compactness, `U_𝔪`, `D_K` | pin, coordinated with #40735 and FLT |
| 2B | Galois action, extension maps, idele norms, semi-local decomposition, `C_L^G ≃ C_K` | 2A, merged Number Field Arithmetic, early Local Fields |
| 2C | archimedean reciprocity, norm index, invariants, Hilbert symbols | pin only |
| 3 | Hecke characters, the two conductors, the finite-order and Dirichlet dictionaries | 1, 2A, 2C |
| 4 | the cyclotomic anchor, consuming Number Field Arithmetic's Frobenius | 1, merged Number Field Arithmetic |
| 5 | `S`-ideles, Herbrand computations, `kummer_le`, the class field axiom, Hasse norm | 2B, 2C, Local Fields cohomology |
| 6 | the compiled global Artin map and the reciprocity law | 4, 5, 2C, Local Fields reciprocity |
| 7 | norm limitation, the existence theorem, ray class fields, the profinite Artin map | 6 |
| 8 | Hilbert and narrow Hilbert class fields, the principal ideal theorem | 7, plus transfer theory |
| 9 | Kronecker–Weber, abelian conductor–discriminant | 3, 6, 7, Number Field Arithmetic's different |
| 10A | continuous and algebraic infinity types | 3 |
| 10B | orders, conductors, Picard groups | 1, plus the new non-Dedekind order theory |
| 10C | ring class fields, `x² + ny²` | 7, 10B |
| 11 | the global class formation, the `H²` sequence, Hilbert reciprocity | 5, 6, 7, 2C, merged Profinite Cohomology |

Layer 6 is the synchronization point with the local-fields roadmap; everything before it is
unconditional on that sibling. The worked examples are distributed across the layers, and none
of them waits until the end.

## References

- J. Neukirch, *Algebraic Number Theory* (Grundlehren 322), the primary source for the pinned
  route: Ch. IV (abstract class field theory: the Frobenius-lift formalism and the class field
  axiom; §§4–6 are the skeleton of Layers 5 and 6), Ch. V (local theory, consumed through the
  local-fields roadmap), Ch. VI (global: §1 ideles and idele classes for Layer 2A, §2 ideles in
  field extensions for Layer 2B, §3 the Herbrand quotient of the idele class group for
  `herbrand_ge`, §4 the class field axiom for `kummer_le`, §5 the global reciprocity law for
  Layer 6, §6 global class fields for Layer 7, §7 the ideal-theoretic version for the
  dictionaries of Layers 1 and 7, §8 power residues for the horizon). Held locally.
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed. (GSM 7), the source for the layer
  decomposition and the most elementary complete treatment: Ch. III (decomposition groups, the
  Frobenius, the Artin map for abelian extensions), Ch. IV §1 (moduli and ray classes, the
  statement forms of Layers 0 and 1), Ch. V (class field theory: §1 cyclic cohomology, §§2–4 the
  norm-index computations, §5 reciprocity and the crossing argument, §6 ideal groups,
  conductors, class fields, §§7–9 the existence theorem, §§10–11 consequences and the conductor
  theorem, §12 the Hilbert class field), Ch. VI (§1 the conductor of `ℚ(√d)`, §3 the extended,
  that is narrow, class group). Held locally.
- S. Lang, *Algebraic Number Theory*, 2nd ed. (GTM 110): Ch. VII (ideles and adeles, §3 ideles),
  Ch. IX (norm-index computations), Ch. X (the Artin symbol, reciprocity, and the crossing
  argument, which is Layer 6's route), Ch. XI (the existence theorem and its local corollaries),
  Ch. XIV (Tate's thesis, the L-functions sibling's fork). Held locally.
- J. S. Milne, *Class Field Theory* (v4.03, course notes), modern statements of both routes:
  Ch. V (global statements: §1 ray class groups, §3 the ideal-theoretic main theorems, §§4–5 the
  idelic main theorems, the statement-form cross-check for Layers 1, 6 and 7), Ch. VII (proofs:
  §§2–5 idele cohomology and the inequalities, §6 the algebraic proof of `≤` pinned in Layer 5,
  §9 existence), Ch. VIII (complements: §§1–2 Grunwald–Wang, §3 the Hasse norm principle and the
  biquadratic counterexample quoted above, §4 the fundamental exact sequence, which is Layer
  11's sum of invariants). Held locally.
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed.: Ch. VIII
  (cohomology of global fields, the global formation and `H²` invariants, Layer 11's
  normalization source, in the same edition the local roadmap cites for its Ch. VII material).
  Held locally.
- Cassels–Fröhlich (eds.), *Algebraic Number Theory*: Ch. VII (Tate, "Global class field
  theory", the idelic statements Layers 2 and 6–7 cross-check against), the exercises (including
  Exercise 5.3, p. 360, the biquadratic Hasse-norm counterexample), and Ch. XV (Tate's thesis,
  the L-functions sibling's fork). Held locally, as a scan in the gq2 reference collection
  alongside Neukirch and NSW.
- D. A. Cox, *Primes of the Form x² + ny²*, 2nd ed.: §§5–6 (the Hilbert class field and genus
  theory), §§7–9 (orders, ring class fields, and `x² + ny²`, which is Layer 10's program).
  **On the acquisition list**; page-precise citations to be added when held. The instances in
  Layer 10C were checked independently, so they do not depend on the book arriving.
- L. C. Washington, *Introduction to Cyclotomic Fields*, 2nd ed. (GTM 83): Ch. 3–4 (cyclotomic
  discriminants and conductor–discriminant over `ℚ`, the source Mathlib's `Cyclotomic/Galois.lean`
  already cites). **On the acquisition list.**
- E. Artin, J. Tate, *Class Field Theory*: the crossing argument in its original arrangement, the
  group-theoretic principal ideal theorem, and the class-formation axiomatics Layer 11 mirrors.
  **On the acquisition list.**
- Serre, *Corps Locaux*, Ch. VI §3, for the local conductor–discriminant formula that Layer 9
  globalizes (consumed through the local-fields roadmap).
- M. I. de Frutos-Fernández, "Formalizing the Ring of Adèles of a Global Field"
  ([ITP 2022](https://drops.dagstuhl.de/storage/00lipics/lipics-vol237-itp2022/LIPIcs.ITP.2022.14/LIPIcs.ITP.2022.14.pdf),
  [arXiv:2203.16344](https://arxiv.org/abs/2203.16344)) and S. Mercuri, "Formalising the local
  compactness of the adele ring" ([arXiv:2405.19270](https://arxiv.org/abs/2405.19270), AFM
  2025), the formalization prior art for Layer 2A.

## Provenance and coordination

The ledger below records the status at the 2026-08-06 refresh. **No outreach has been
performed.** Every item is therefore uncontacted, no ownership has been agreed, and the contact
and refactor requirements stated here are part of the corresponding milestone rather than work
delegated to some future implementer.

- **Project / authors:** Mathlib idèle-class-group work, T. Browning.
  **Exact revision or PR:** open PR
  [#40735](https://github.com/leanprover-community/mathlib4/pull/40735), head
  `ba5cc4688489de347cf90eb39a0ac52b6ddc66fc`, last updated 2026-08-05.
  **Licence:** Apache-2.0.
  **Overlap:** `IdeleGroup`, principal idèles, `IdeleClassGroup`, the topology, and the local
  completion maps, which are the whole carrier and API of Layers 2A and 3.
  **Contact status:** not contacted.
  **Agreed ownership:** none. The proposal is that #40735 and Mathlib own these definitions and
  that this roadmap consumes their exact names.
  **Plan:** contact Browning before Layers 2A and 3; offer the reusable follow-up theorems
  upstream; keep prototypes prose-only while the in-flight API is still moving.
  **Refactor trigger:** #40735 merges, or changes a carrier, namespace, topology, or local map.
- **Project / authors:** Mathlib Hilbert-class-field wanted statements, F. A. E. Nuccio.
  **Exact revision or PR:** open PR
  [#40661](https://github.com/leanprover-community/mathlib4/pull/40661), head
  `184a5900ddc04998dd9d5976cb9c242f265dd56b`, last updated 2026-07-16.
  **Licence:** Apache-2.0.
  **Overlap:** the Hilbert class field, the maximal unramified extension, the principal ideal
  theorem, Kronecker–Weber, and the conductor-as-least-cyclotomic-level statement shapes.
  **Contact status:** not contacted.
  **Agreed ownership:** none. The proposal leaves the wanted-statement vocabulary in Mathlib and
  makes Layers 8 and 9 prove or consume those shapes.
  **Plan:** contact Nuccio and report any necessary divergence on #40661; introduce no competing
  public names without agreement.
  **Refactor trigger:** #40661 merges, is superseded by proved files, or its shapes change.
- **Project / authors:** ImperialCollegeLondon/FLT (Buzzard et al.; the adelic work by its
  number-field contributors).
  **Exact revision:** `d18b563029f3`, checked 2026-08-06.
  **Licence:** Apache-2.0.
  **Overlap:** `NumberField.AdeleRing.discrete`, `NumberField.AdeleRing.cocompact`, and Fujisaki
  compactness, which are Layer 2A inputs rather than new targets.
  **Contact status:** not contacted.
  **Agreed ownership:** none. The preference is upstream or FLT ownership of the existing
  proofs, consumed here after an agreed dependency or an upstream move.
  **Plan:** contact the maintainers; prefer contributing the general statements to Mathlib. An
  independent proof is permitted only with a recorded reason and no code copying.
  **Refactor trigger:** any of these theorems lands upstream, or FLT changes their generality.
- **Project / authors:** kbuzzard/ClassFieldTheory (maintainer Yunzhou "Edison" Xie and
  contributors).
  **Exact revision:** `ccc3323c6750abca25b49b35106f54eb3a398509`, top commit 2026-07-31, checked
  2026-08-06.
  **Licence:** Apache-2.0.
  **Overlap:** the global blueprint chapter, `FiniteClassFormation`, the Tate and Herbrand
  conventions, the norm-index proof plan, and future global fundamental classes.
  **Contact status:** not contacted; the private working channel has not been accessed and the
  public repository is only a status proxy.
  **Agreed ownership:** none. The proposed split keeps their abstract interface authoritative,
  makes Layers 5 through 7 independent only where no Lean supplier exists, and refactors
  Layer 11 onto any upstream global class formation.
  **Plan:** seek direct or public `#maths` coordination before implementation; cite the
  blueprint; port neither prose nor code without agreement.
  **Refactor trigger:** global Lean files appear, or the formation interfaces change upstream.
- **Project / authors:** mariainesdff/ideles, M. I. de Frutos-Fernández and contributors.
  **Exact revision:** `b85d242f18cbdb7a8755c048c2d4cb7b3c675127`, unchanged since 2023-10-05.
  **Licence:** Apache-2.0.
  **Overlap:** the Lean 3 idèle class group and the class-group quotient theorem; the historical
  source of Mathlib's current adelic substrate.
  **Contact status:** not contacted.
  **Agreed ownership:** none. This repository is prior art and a possible migration source, not
  implicit permission to port.
  **Plan:** contact the author before any migration; otherwise reprove independently while
  citing the exact source.
  **Refactor trigger:** an author-approved migration plan, or an upstream Lean 4 port.
- **Project / authors:** Mathlib adele, topology, S-integer, and Frobenius contributors
  (Mercuri, Barroero, Roblot, Brasca, Angdinata, Yang, and others).
  **Exact revisions:** project pin `9caeba1000ef8f302920981f4a08651d325abc81`; tracked PRs
  #36404 (head `fca3a6af67b8`), #36275 (`df510478253d`), #40848 (`1386a3f5a528`), #40791
  (`6c4013931e7a`), and #41591 (`9a76f0e50eee`), all open at the 2026-08-06 check. PR #42130
  (instance transparency) was closed unmerged on 2026-08-06 and is no longer tracked.
  **Licence:** Apache-2.0.
  **Overlap:** topology, norms, S-units, decomposition and inertia, and Frobenius vocabulary,
  consumed across Layers 2, 5, and 6 through 9.
  **Contact status:** not contacted.
  **Agreed ownership:** none; the proposal keeps these general-purpose APIs upstream.
  **Plan:** consume landed results, and coordinate any missing reusable lemma with the named
  active author rather than creating a duplicate Tau Ceti API.
  **Refactor trigger:** any tracked PR merges or changes the consumed statements.

Announcements and named contacts. The active authors whose in-flight work this roadmap tracks
are **T. Browning** (PR #40735, the idele class group, and a stated intent to build Hecke
L-functions: contact before Layers 2A and 3, adopt his shapes, and offer the Layer 2A and 3
material as upstream follow-ups), **S. Mercuri** (adele topology, #36404 and #36275, and the AFM
2025 paper), **F. A. E. Nuccio** (#40661, and the mariainesdff collaboration),
**M. I. de Frutos-Fernández** (the Lean 3 ideles development and the Mathlib `FiniteAdeleRing`
and `AdicValuation` substrate: coordinate before Layers 2A and 7, per the root README's
coordination rule), **X. Roblot** (the cyclotomic Galois dictionary that Layer 4 rests on, and
the RamificationInertia refactor), **F. Barroero** (places, the product formula, S-integers),
**R. Brasca** (`ExtendedHom`, and DirichletDensity on the L-functions side), and
**D. Angdinata** (S-integers). Before starting Layers 0 and 6, announce the intention per the
root README's claims process and post the note in `#maths`: the audit found no existing thread
on ray class groups or global reciprocity, so the announcement creates the venue.

Standing obligations toward the two active projects. For **kbuzzard/ClassFieldTheory**: align
interfaces (`FiniteClassFormation`, the Herbrand conventions, the Tate-cohomology spellings at
the first bump), cite their `_4_global.tex` at Layers 5 and 11 including the route divergence
pinned in the conventions table, and refactor Layer 11 onto their global half if it acquires
Lean code that reaches Mathlib, keeping Layers 5 through 7 as independent developments of the
same mathematics, diverging only with a recorded reason. For **FLT**: Layer 2A's compactness
milestones duplicate mathematics they have already proved, so coordinate before implementing;
the preferred outcome is that their statements upstream and this layer consumes them, the
fallback an independent proof that cites theirs, and code is not copied without agreement.
FLT axiomatizes only local class field theory today, so no reciprocity-level coordination
is needed yet; tell them when Layer 6 lands, since their future global chapters will want it.

Sibling roadmaps. From **Local Fields** the consumption contract is its Layer 7 bundle
plus Layer 2 norms, Layer 3 different and Hasse–Arf material, Layer 5 Herbrand quotients, and
Layer 8 Hilbert symbols; the arithmetic-Frobenius and `Art(π) = Frob` normalizations are shared
pins, and the cyclotomic-orientation clause `χ_cyc(Art(u)) = u⁻¹` is the one statement both
roadmaps must agree on (its Layer 7, our Layer 6). From **Profinite Cohomology**, Layer 11 only.
From **Number Field Arithmetic**, the decomposition and Frobenius API, the ideal-theoretic Artin
symbol, and the different globalization, with the ownership boundary stated at the top of this
roadmap. **L-functions** owns everything analytic, including Chebotarev; this roadmap's
density-free discipline exists so that the dependency points from there to here, the
Hecke-character interface of Layer 3 is frozen in coordination with it, and the master plan's
Tate's-thesis-versus-theta route decision is theirs. **Multiquadratic** (merged) receives the
narrow class group of Layer 1 and the genus-field compatibility of Layer 8, built to its
Layer 3's stated needs. The Wave-2 consumers are QuaternionArithmetic (Layer 11's Hilbert
reciprocity), CurvesOverFiniteFields and Honda–Tate (Layer 11's sum of invariants), and
AbelianVarieties and CM (Layer 10A's algebraic characters and Layer 10C's ring class fields);
each interface is a named milestone above, so those roadmaps can cite a specific target rather
than "global class field theory".

Three refinements to the master plan's §4 entry, recorded per its own ground rule: the idele
class group is not Mathlib material to consume but an open PR to align with; ProfiniteCohomology
is a Layer-11-only dependency rather than a blanket one, since the reciprocity core runs on the
pin's finite group cohomology; and two artifacts the plan predates, the ClassFieldTheory global
blueprint chapter and the #40661 wanted-statements file, now fix the external statement shapes
for Layers 5, 8, 9, and 11. A fourth, added at this review: the local-fields roadmap is
nonarchimedean by construction, so the archimedean local theory is this roadmap's to build, and
it is Layer 2C.
