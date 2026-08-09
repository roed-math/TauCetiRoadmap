# Roadmap: Belyi maps, dessins d'enfants, and three-point covers

A Belyi map is a finite cover of the projective line branched over at most `{0, 1, ∞}`. The
subject sits at a crossroads: the covers are classified by finite combinatorial data
(permutation triples, equivalently dessins d'enfants), they are analytic objects (compact
Riemann surfaces with a holomorphic map to the sphere), they are algebraic curves over number
fields (Belyi's theorem), and the absolute Galois group of `ℚ` acts on them faithfully. The
[LMFDB's Belyi section](https://www.lmfdb.org/Belyi/) displays all four faces of each object.

This roadmap builds the subject from the combinatorics up:

- permutation triples, their relabeling classes, passports, and dessins as finite bipartite
  ribbon graphs, with executable enumeration and character-theoretic counts;
- triangle groups and their finite permutation representations;
- the thrice-punctured sphere, its free fundamental group, and the classification of its
  finite covers by triples;
- compactification of those covers to branched covers of the sphere, the complex structure,
  and the analytic Riemann existence theorem for three-point covers;
- algebraic Belyi pairs over a field, the analytic/algebraic comparison over `ℂ`, and Belyi's
  theorem in both directions;
- fields of moduli and fields of definition, the Galois action on dessins, the branch-cycle
  theorem for the profinite fundamental group, a generic pro-`ℓ` peripheral-power theorem, and
  faithfulness of the Galois action;
- the assertion semantics of LMFDB Belyi-map and passport records.

The pinned Mathlib is favourable on exactly the substrate this roadmap starts from: the
permutation cycle and primitivity theory is deep, covering-space lifting comes with a full
monodromy functor (`IsCoveringMap.monodromyFunctor`), Galois categories come with the
profinite classification theorem (`PreGaloisCategory.functorToContAction` is an equivalence),
the profinite completion of a group exists (`ProfiniteGrp.profiniteCompletion`), and both the
mod-`n` and `ℓ`-adic cyclotomic characters are present (`modularCyclotomicCharacter`,
`cyclotomicCharacter`). What Mathlib does not have: dessins, ribbon graphs, triangle groups,
Riemann surfaces (the pin's only nontrivial complex manifold is `ℍ`), Seifert–van Kampen, the
classification of covering spaces as an equivalence, étale fundamental groups, or any outer
automorphism carrier. Those are built here or consumed from the named sibling roadmaps.

Suggested homes, mirroring the Mathlib directories that own each notion. The directories are
suggested homes for the code, not extra layers of this roadmap:

```text
TauCeti/Combinatorics/PermutationTriple/   -- Layers 0, 1, 3
TauCeti/Combinatorics/RibbonGraph/         -- Layer 2
TauCeti/GroupTheory/TriangleGroup/         -- Layer 4
TauCeti/GroupTheory/Profinite/             -- the generic profinite sublayers of Layers 12, 13
TauCeti/AlgebraicTopology/ThreePuncturedSphere/  -- Layers 5, 6
TauCeti/Geometry/RiemannSurface/           -- Layers 7, 8
TauCeti/AlgebraicGeometry/Belyi/           -- Layers 9, 10, 11
TauCeti/NumberTheory/Belyi/                -- Layers 12, 13, 14
```

## Prerequisites

Every milestone below lists its direct prerequisites. Each prerequisite is one of four kinds,
and nothing else is allowed:

- **Mathlib.** A declaration that exists in Mathlib at the pin.
- **Tau Ceti.** A declaration that exists in the Tau Ceti code repository.
- **Layer n.m.** An earlier milestone of this roadmap.
- **Roadmap, Layer n.** A named layer of another roadmap in this repository.

No milestone waits on a Mathlib pull request, a future pin, or an external repository. Where a
consumed roadmap is not yet implemented in the code repository, the citation is to its layer,
which is the definitive specification of the object; `Suggested.lean` carries local
elaboration stand-ins for the carriers this roadmap needs before those layers land, each
marked with the supplier it will be replaced by.

## Boundaries

Seven roadmaps supply material to this one. The boundaries are stated once here.

**Character theory.** Class functions, irreducible characters, the character table, both
orthogonality relations, class sums, structure constants, and central characters belong to
[CharacterTheory](../RepresentationTheory/CharacterTheory/README.md). This roadmap proves none
of them. It consumes, by name: `ClassFunction` (Layer 0), `classSum`, `structureConstant` and
`classSum_mul` (Layer 1), `characterTable` and `char_column_orthogonality` (Layer 3), and
`centralCharacter` with `centralCharacter_coordinate` and the conversion
`ω_χ(K_j) = |C_j|·χ(g_j)/χ(1)` (Layer 4). The Frobenius product-one counting formula is on no
roadmap; **this roadmap owns it** (Layer 3.2), together with the inverse-class operation on
`ConjClasses` it needs.

**Universal covers.** The covering-space classification, deck transformation groups, and the
`N(H)/H` deck-group theorem belong to
[UniversalCovers](../UniversalCovers/README.md) (milestones 4, 5, 7, 8 there). This roadmap
consumes them and builds no universal cover. Two conventions from that roadmap bind here: deck
groups are identified with `(π₁)ᵐᵒᵖ` (its milestone 5), and basepoint change acts on recovered
subgroups by conjugation (its milestone 7). The constructive direction this roadmap needs — a
cover of the base built *from* a permutation action — is Layer 6.2's associated cover
`(Ũ × S)/π₁`, which needs from that roadmap only the universal cover and the free proper
discontinuity of the deck action, and gets the covering property from Mathlib's
`IsQuotientCoveringMap`.

The pin has no Seifert–van Kampen theorem in any form, and this roadmap does not build a
general one. Layer 5.5 builds the single case the fundamental-group computation needs — two
open sets with simply connected intersection — from the subdivision infrastructure the pin
does supply (`exists_monotone_Icc_subset_open_cover_unitInterval` and its square analogue,
with `Mathlib/Topology/Subpath.lean`'s `Path.subpath`/`Path.concat`/`concatSubpath`). That
theorem is generic and is stated for reuse.

**Conformal mapping.** The local theory of holomorphic maps — Rouché, Hurwitz, the local
degree `TauCeti.exists_localDegree`, holomorphic branch roots — belongs to
[ConformalMapping](../ConformalMapping/README.md) (its L0), and Layer 8 consumes it for the
local normal form. Nothing here uses the Riemann mapping theorem, Montel, or the boundary
correspondence. The `ℍ/Γ(2) ≅ ℂ∖{0,1}` λ-uniformization is that roadmap family's material
(recorded there as belonging to ModularForms); no layer here consumes or supplies it — the
route to the fundamental group of the thrice-punctured sphere is the figure-eight retract,
not uniformization.

**Modular forms.** The compact-Riemann-surface cohomology chain — structure sheaf, sheaves of
a divisor, finiteness of `H¹`, analytic Riemann–Roch, Serre duality by residues,
Riemann–Hurwitz for finite holomorphic maps, and the existence of nonzero meromorphic sections
of line bundles — is built inside [ModularForms](../ModularForms/README.md) Layer 10B, stated
there for general compact Riemann surfaces. Layers 8 and 9 here consume that chain and rebuild
none of it. What ModularForms does not pin is a Lean carrier for "compact Riemann surface";
**this roadmap owns the carrier conventions** (the hypothesis stack of Layer 8.1, and the
Riemann sphere instance on `OnePoint ℂ`), chosen so that 10B's statements can be stated
against them. `X(Γ)`, modular curves, and everything `q`-expansion-flavoured stay in
ModularForms; nothing here mentions `ℍ`.

**Algebraic curves.** Function fields of one variable, places, divisors, Riemann–Roch,
extensions with ramification and the different, Riemann–Hurwitz, and the regular-projective
model with the curve/function-field anti-equivalence belong to the AlgebraicCurves roadmap —
cited as AlgebraicCurves Layers 0–8 and 12; that roadmap's own contract table names this
roadmap as the consumer of exactly those layers. Layer 9 here consumes them for the algebraic side of the comparison. The analytic
comparison over `ℂ` — a compact Riemann surface with a Belyi function versus the regular
projective model of its function field — is excluded there by name and **owned here**
(Layers 9.4–9.6).

**Polynomial Galois groups.** The full cycle type `fullCycleType`, the transitive-group
reference data `TransitiveGroupIndex`, `referenceSubgroup`, `numTransitiveGroups`, and the
label predicate `TransitiveGroupLabel` belong to the PolynomialGaloisGroups roadmap (its
Layers 0, 6, 7).
Layer 1 here consumes them for LMFDB label semantics and adds no second `nTj` predicate and no
second cycle-type-with-fixed-points definition. Blocks, primitivity, and transitivity are
always Mathlib's `MulAction.IsBlock`, `MulAction.IsPreprimitive`, `MulAction.IsPretransitive`,
as there.

**Pro-p groups.** The free profinite group on a finite set (`freeProfiniteGroup`, `.of`,
`.lift`), the maximal pro-`p` quotient (`proPKernel`, `maximalProPQuotient`) with its
universal property and the characteristicity of its kernel under continuous automorphisms,
the free pro-`p` group `freeProP`, and the identification
`maximalProPQuotient p zHat ≃ₜ* Multiplicative ℤ_[p]` belong to the ProPGroups roadmap (its
Layers 3 and 4). Layers 12 and 13 consume them. That roadmap's exponentiation stops at
abelian pro-`p` groups; the **profinite
exponentiation calculus** — `x ^ᶻ a` for `a ∈ ẑ` in an arbitrary profinite group, its laws,
its `ℤ_ℓ`-specialization on pro-`ℓ` groups, and the comparison between the two — is owned
here (Layer 12.1), in the generic `TauCeti/GroupTheory/Profinite/` home, exported for reuse.
So is the continuous-outer-automorphism carrier (Layer 12.6), which no roadmap and no Mathlib
file owns.

Path note: AlgebraicCurves, PolynomialGaloisGroups, and ProPGroups are under review as pull
requests on this repository; their paths become `../AlgebraicCurves/README.md`,
`../PolynomialGaloisGroups/README.md`, and `../ProPGroups/README.md` when they land, and
`PROVENANCE.md` records the dated state.

What this roadmap supplies to other subjects:

- the Frobenius product-one formula and generating-triple counts (Layer 3), usable by any
  subject that counts covers or factorizations in finite groups;
- finite bipartite ribbon graphs (Layer 2), reusable for maps and hypermaps on surfaces;
- triangle groups (Layer 4);
- the compact-Riemann-surface carrier conventions, the Riemann sphere, ramification API, and
  the analytic/algebraic comparison for curves with a nonconstant meromorphic function
  (Layers 8, 9) — the GAGA-sized bridge that AlgebraicCurves excludes and ModularForms's 10B
  stops short of;
- the profinite exponentiation calculus and the continuous outer-automorphism carrier
  (Layers 12, 13), generic group theory placed in generic namespaces;
- the branch-cycle theorem and the pro-`ℓ` peripheral-power theorem (Layers 12, 13), the
  reusable arithmetic core for any consumer of the Galois action on covers of
  `ℙ¹ ∖ {0,1,∞}`.

## Pinned conventions

Implementors make no choices about any of the following. Each is fixed here once, and every
layer uses it.

**Multiplication and composition.** Mathlib's `Equiv.Perm` multiplies by function
composition: `(σ * τ) x = σ (τ x)`. Mathlib's `End`/`Aut` monoids in a category do the same
(`End.mul_def : f * g = g ≫ f`), so in `FundamentalGroup X x` the product `γ * δ` is the
homotopy class of "`δ` first, then `γ`". Path concatenation `γ.trans δ` is "`γ` first". The
pin's monodromy is covariant for concatenation:
`monodromy (γ.trans δ) = monodromy δ ∘ monodromy γ` (`IsCoveringMap.monodromy_trans_apply`).
Consequently the fiber monodromy `μ : FundamentalGroup X x →* Equiv.Perm (p ⁻¹' {x})` of
Layer 6.1 is a genuine monoid homomorphism, with no `ᵐᵒᵖ` and no inversion.

**The product relation.** A permutation triple stores `σ0`, `σ1`, `σinf` with the one
relation

```text
σinf * σ1 * σ0 = 1
```

in Mathlib's multiplication. Geometrically: the concatenated loop "`γ0`, then `γ1`, then
`γ∞`" is nullhomotopic, and `μ` turns that into the displayed relation (Layers 5.2, 6.1).

⚠ **A displayed relation means nothing without a composition order, and the LMFDB's display
is not this relation.** The LMFDB's knowl shows `σ_∞ σ_1 σ_0 = 1`, typographically the
relation above; but the stored triples are computed left-to-right, so as *functions* they
satisfy `σ0 ∘ σ1 ∘ σinf = id`, which in Mathlib's multiplication is `σ0 * σ1 * σinf = 1` —
the **opposite** relation. `PROVENANCE.md` verifies this against frozen records rather than
inferring it from the display. The two conventions differ by the componentwise-inversion
involution of Layer 0.1, and Layer 14.2 states that translation as a theorem about the
stored data.

⚠ The rival convention also produces a *different* third permutation (`(σ1·σ0)⁻¹` versus
`(σ0·σ1)⁻¹`), so a triple carried across without the involution has the wrong `σinf` and the
wrong partition at `∞`. Every source citation in this roadmap records the source's
composition order. The worked example `z ↦ z²` in `Suggested.lean` pins the reading here:
`σ0 = σinf = (0 1)`, `σ1 = 1`.

**Ordered branch points.** The branch points are ordered `0, 1, ∞`, in every triple,
passport, and label. The action of permuting the three branch points is the explicit API of
Layer 2.6, never an implicit identification.

**Relabeling.** Relabeling is the left action of `Equiv.Perm (Fin n)` by simultaneous
conjugation, `τ • (σ0, σ1, σinf) = (τσ0τ⁻¹, τσ1τ⁻¹, τσinfτ⁻¹)`, packaged as a `MulAction`.
Isomorphism of triples is membership in one orbit — simultaneous conjugacy, never
componentwise conjugacy by three unrelated elements. Conjugating a subgroup is spelled
`Subgroup.map (MulAut.conj τ).toMonoidHom`, as in PolynomialGaloisGroups.

**Cycle data.** Cycle partitions always include fixed points: the partition attached to `σ`
is PolynomialGaloisGroups' `fullCycleType σ`, a multiset partition of `n`.
⚠ Mathlib's bare `Equiv.Perm.cycleType` omits parts equal to `1` and is never compared with a
partition of `n`; the pin's `Equiv.Perm.partition` is the bundled form, with a comparison
lemma in Layer 0.5.

**Monodromy group and connectedness.** The monodromy group of a triple is
`Subgroup.closure {σ0, σ1}`; the relation puts `σinf` in it. A triple is *connected* when
`n ≠ 0` and the monodromy group acts pretransitively on `Fin n`.
⚠ `MulAction.IsPretransitive` is vacuously true on the empty type, and the genus formula is
false for `n = 0`; the `n ≠ 0` clause is part of the definition, not a convenience.

**Euler characteristic and genus.** The Euler characteristic of a degree-`n` triple is the
integer `χ(t) = c(σ0) + c(σ1) + c(σinf) − n`, where `c` counts cycles including fixed
points. For connected triples, Layer 0.6 proves `χ(t) ≤ 2` and `2 − χ(t)` even *before* the
natural-number genus `g`, with `2 − 2g = χ(t)`, is defined. No milestone states a genus
through unchecked `Nat` subtraction or `Int.toNat`.

**Orders and geometry type.** `(a, b, c) := (orderOf σ0, orderOf σ1, orderOf σinf)`; the
identity has order `1`. The geometry type is spherical, Euclidean, or hyperbolic according as
`1/a + 1/b + 1/c` is greater than, equal to, or less than `1`, compared exactly in `ℚ`.

**Dessins.** A dessin is a connected finite bipartite ribbon graph — a genuine carrier with
edge and vertex types, incidence maps, and cyclic orders typed as permutations that are
`Equiv.Perm.IsCycleOn` each vertex fiber — never a definitional alias for a triple. The
equivalence with triples is the theorem pair of Layers 2.2–2.4.

**Passports.** A passport records a degree, a transitive subgroup of `S_n` up to conjugacy
(carried as a reference subgroup plus the conjugacy predicate, as in
PolynomialGaloisGroups), and the ordered full cycle partitions at `0`, `1`, `∞`. A passport
class is a simultaneous-conjugacy class of connected triples with those invariants. A
passport is not a Galois orbit; one passport can contain several orbits, and the orbit letter
in an LMFDB label is a database enumeration, not an invariant.
⚠ For a fixed embedded monodromy group `G ≤ S_n`, the group acting on generating triples is
the normalizer `N_{S_n}(G)`, not `G` itself (Layer 1.3); no counting milestone conflates the
two, and none identifies a raw Frobenius count with a passport size.

**Primitivity.** Primitive means Mathlib's `MulAction.IsPreprimitive` for the monodromy
action. Block systems, quotient triples, and imprimitivity are Layer 1.4; nothing asserts a
canonical primitivization (Layer 14 encodes the LMFDB's `primitivization` field as a
certificate carrying its block system).

**Riemann surfaces.** "Compact Riemann surface" is the unbundled hypothesis stack of
Layer 8.1 over the pin's manifold vocabulary (`IsManifold 𝓘(ℂ) ω X`, plus compactness,
connectedness, and the separation instances), with the Riemann sphere carried by
`OnePoint ℂ`. Holomorphy of maps is the pin's manifold differentiability at analyticity
exponent `ω`. No private "Riemann surface" structure is introduced.

**Algebraic Belyi pairs.** Over a field `k`, the primary carrier is function-field-first,
matching AlgebraicCurves: a function field `F/k` with exact constants
(`IsIntegrallyClosedIn k F`) together with a finite separable `k`-embedding `k(t) ↪ F`
unramified outside the three places `t = 0`, `t = 1`, `t = ∞` of `k(t)`. The
morphism-of-curves form is the corollary through AlgebraicCurves Layer 12, not a second
definition. "Branch locus contained in `{0,1,∞}`" is containment — a Belyi map may be
unramified over any of the three points.

**Analytic Belyi pairs.** Over `ℂ`: a compact Riemann surface with a nonconstant holomorphic
map to the sphere whose branch values lie in `{0, 1, ∞}`. The analytic and algebraic
definitions are related by the comparison theorems of Layer 9, never identified
definitionally.

**Fields of moduli and definition.** The field of moduli is the fixed field of the stabilizer
of the isomorphism class under `Gal(ℚ̄/ℚ)`. A field of definition carries a model and a
base-change isomorphism. They can differ (Layer 11.6); no milestone treats them as equal.

**The Galois action is outer.** The action of `Gal(ℚ̄/ℚ)` on the profinite fundamental group
is an outer action, because basepoints and comparison paths are not canonical. Peripheral
statements are stated first on conjugacy classes or in outer form; automorphism
representatives are chosen only where a theorem says one exists (Layer 13.3).

**Peripheral elements.** In the profinite completion `F̂₂` of `FreeGroup (Fin 2)`:
`P` and `T` are the images of the two generators `of 0`, `of 1`, and `C := (T * P)⁻¹`, so
that

```text
C * T * P = 1
```

— the profinite image of the Layer 5 relation, in the same display order as the triple
relation. Their images in the maximal pro-`ℓ` quotient keep the same names with a `ℓ`
subscript. ⚠ A source that writes `P·T·C = 1` (composition left-to-right) names as its third
peripheral element a *conjugate* of this `C`; the translation lemma is
`P⁻¹T⁻¹ = P⁻¹·(T·P)⁻¹·P`, and the peripheral-power theorems of Layer 13 transfer along it by
conjugating the conjugator (the two-line argument is recorded with Layer 13.3).

**Profinite powers.** Powers `x ^ᶻ a` by `a ∈ ẑ` are the canonical operation of Layer 12.1,
defined through the universal property of the profinite completion of `ℤ`; powers by
`u ∈ ℤ_ℓ` on a pro-`ℓ` group factor through the `ℓ`-adic component, and the comparison is a
theorem (Layer 12.2), not a definition. No milestone raises a profinite element to an
"integer representative" power.

**The absolute Galois group and the cyclotomic character.** `Gal(ℚ̄/ℚ)` is the pin's
`Field.absoluteGaloisGroup ℚ` with `ℚ̄ = AlgebraicClosure ℚ` fixed once. The cyclotomic
characters are the pin's `modularCyclotomicCharacter n` and `cyclotomicCharacter ℓ`, whose
defining convention is `g ζ = ζ ^ χ(g)` on `n`-th (respectively `ℓ`-power) roots of unity.
The branch-cycle exponent in Layer 12.8 is `χ(σ)` in exactly this normalization; the
milestone states the finite-level `ζ_n` identity explicitly so that a sign or inverse error
cannot hide in prose. ⚠ Sources using the geometric (inverse) convention for the Galois
action on covers state the theorem with `χ(σ)⁻¹`; each citation records the source's
convention.

## What Mathlib supplies

The pin is `9caeba1000` (2026-06-03). The load-bearing imports, verified there:

| Area | Declarations |
| --- | --- |
| Permutations | `Equiv.Perm.cycleType`, `cycleFactorsFinset`, `support`, `Equiv.Perm.partition`, `isConj_iff_cycleType_eq`, `Equiv.Perm.sign`, `IsCycleOn`, `Equiv.Perm.exists_with_cycleType_iff` |
| Actions | `MulAction.IsPretransitive`, `IsBlock`, `IsBlockSystem`, `IsPreprimitive`, `isCoatom_stabilizer_iff_preprimitive`, `ConjAct`, `MulAction.stabilizer`, orbit–stabilizer, Burnside `MulAction.sum_card_fixedBy_eq_card_orbits_mul_card_group` |
| Jordan theorems | `Equiv.Perm.subgroup_eq_top_of_isPreprimitive_of_isSwap_mem`, `alternatingGroup_le_of_isPreprimitive_of_isThreeCycle_mem` |
| Free groups | `FreeGroup`, `FreeGroup.lift`, `IsFreeGroup`, `FreeGroupBasis`, `PresentedGroup`, `PresentedGroup.toGroup`, Nielsen–Schreier |
| Topology | `FundamentalGroup`, `FundamentalGroupoid`, `Path`, `IsCoveringMap` (`Topology/Covering/Basic.lean`), `IsQuotientCoveringMap`, `liftPath`, `liftHomotopy`, `IsCoveringMap.monodromy`, `monodromyFunctor`, `monodromy_trans_apply`, `injective_path_homotopic_map`, the lifting criterion `existsUnique_continuousMap_lifts_of_range_le`, `LocPathConnectedSpace`, `isCoveringMap_exp`, `isCoveringMapOn_zpow` |
| Galois categories | `PreGaloisCategory`, `FiberFunctor`, the profinite topology on `Aut F`, `IsGalois` objects, `functorToContAction` with `IsEquivalence`, `IsFundamentalGroup` with `toAutMulEquiv` |
| Profinite | `ProfiniteGrp`, `ProfiniteGrp.profiniteCompletion` with `eta`, `lift`, adjunction; `ContinuousMulEquiv` (`≃ₜ*`); `PadicInt` |
| Arithmetic | `Field.absoluteGaloisGroup`, Krull topology, `AlgebraicClosure`, `modularCyclotomicCharacter`, `cyclotomicCharacter`, cyclotomic polynomials irreducible over `ℚ`, `IsPrimitiveRoot` |
| Complex analysis | `analyticOrderAt`, `MeromorphicAt/On`, `MeromorphicNFAt`, open mapping, identity theorem, `TendstoLocallyUniformlyOn`, `OnePoint ℂ` with `OnePoint.equivProjectivization` and the `GL(2)` Möbius action |
| Manifolds | `IsManifold 𝓘(ℂ) ω`, `MDifferentiable`, `Mathlib/Geometry/Manifold/Complex.lean` (maximum principle) |

Notable absences at the pin, so that nobody searches for them: any `SemilocallySimplyConnected`
(UniversalCovers owns the class), Seifert–van Kampen in any topological form, `ẑ`, `Out G`,
étale fundamental groups, Riemann surfaces, Riemann–Roch, Riemann–Hurwitz, divisors on
schemes, and any ribbon-graph or triangle-group object.

## What Tau Ceti supplies

Exact contracts with the seven suppliers. The name belongs to the supplier; this roadmap
cites the name and never restates the object.

| Consumer layer | Supplier | Exact object or theorem | Name |
| --- | --- | --- | --- |
| 0.5, 1.1 | PolynomialGaloisGroups Layer 0 | cycle type with fixed points | `fullCycleType` |
| 1.6, 14 | PolynomialGaloisGroups Layers 6, 7 | transitive reference data and label predicate | `numTransitiveGroups`, `TransitiveGroupIndex`, `referenceSubgroup`, `TransitiveGroupLabel` |
| 3.2 | CharacterTheory Layers 1, 3, 4 | class sums, structure constants, column orthogonality, central characters | `classSum`, `structureConstant`, `classSum_mul`, `characterTable`, `char_column_orthogonality`, `centralCharacter`, `centralCharacter_coordinate` |
| 6.3, 6.4 | UniversalCovers milestones 4, 5, 7, 8 | deck groups, `Deck ≅ (π₁)ᵐᵒᵖ`, basepoint change, pointed/unpointed classification, `Deck ≅ N(H)/H` | `Deck`, `deckFundamentalGroupEquiv`, `basepointChangeSubgroup`, the milestone-8 correspondence |
| 8.2 | ConformalMapping L0 | local degree of a holomorphic map | `TauCeti.exists_localDegree` |
| 8.5, 9.2 | ModularForms Layer 10B (i)–(v) | sheaves `𝒪_D`, finiteness of `H¹`, analytic Riemann–Roch, Serre duality, Riemann–Hurwitz, meromorphic sections of line bundles | the 10B chain, cited by its milestone numbers |
| 9.1, 9.4 | AlgebraicCurves Layers 0–8, 12 | `IsFunctionField`, `Place`, `Divisor`, genus, Riemann–Roch, ramification, the different, Riemann–Hurwitz, the regular projective model and anti-equivalence | `IsFunctionField`, `Place`, `Divisor`, `riemannRochSpace`, `genus`, Layers 6–7 and 12A–12E |
| 12.5, 12.1 | ProPGroups Layers 3, 4 | free profinite group, maximal pro-`p` quotient, universal properties, characteristic kernel, `zHat` | `freeProfiniteGroup`, `freeProfiniteGroup.of`, `freeProfiniteGroup.lift`, `proPKernel`, `maximalProPQuotient`, `freeProP`, `zHat`, `maximalProPQuotient p zHat ≃ₜ* Multiplicative ℤ_[p]` |

Merged Tau Ceti files (`RepresentationTheory/CharacterTable/`, `UniversalCover/`,
`Conformal/`) supply the implemented halves of those contracts; `PROVENANCE.md` records which
halves exist at which date, since implementation state is not part of this specification.

## The build, in layers

The fifteen layers are a dependency order: every milestone rests on Mathlib, on Tau Ceti, on
an earlier layer, or on a cited layer of a named roadmap, and there are no forward
references. Layers 0–4 are pure finite mathematics and are startable immediately and in
parallel; Layers 5–8 are topology and analysis; Layers 9–11 are algebraic geometry over `ℂ`
and `ℚ̄`; Layers 12–13 are the arithmetic summit; Layer 14 is the LMFDB interface. The
§Ordering section records which layers are independent.

`Suggested.lean` holds suggested signatures for the milestones whose carrier, index type, or
map determines the layers below them. It is not a checklist, and it is not exhaustive.

### Layer 0: permutation triples

#### 0.1 The carrier

Define the structure of degree-`n` permutation triples:

```lean
structure PermutationTriple (n : ℕ) where
  σ0   : Equiv.Perm (Fin n)
  σ1   : Equiv.Perm (Fin n)
  σinf : Equiv.Perm (Fin n)
  product_eq_one : σinf * σ1 * σ0 = 1
```

**New object: `PermutationTriple`.** Basic API:

- *Constructors and instances.* `ofTwo σ0 σ1` with third component `(σ1 * σ0)⁻¹`;
  extensionality (`σinf` is determined, so two triples agree iff their first two components
  do); `DecidableEq`; `Fintype`; the trivial triple `1` with three identities; degree-zero
  behaviour (`Subsingleton (PermutationTriple 0)`).
- *Examples.* Layer 0.8's suite.
- *Morphisms and functoriality.* Transport along `Fin n ≃ Fin m` (only `n = m` occurs, via
  `Equiv.permCongrHom`); the relabeling action is Layer 0.2.
- *Comparison lemmas.* `σinf = σ0⁻¹ * σ1⁻¹`; the equivalent relations
  `σ1 * σ0 = σinf⁻¹` and cyclic rotations `σ0 * σinf * σ1 = 1`, `σ1 * σ0 * σinf = 1`
  (rotations of the relation hold; arbitrary permutations of it do not).
- *Edge cases.* `n = 0` and `n = 1`.
- *Downstream interfaces.* Everything below; the convention-translation involution next.

**The opposite-convention translation.** Componentwise inversion
`t ↦ (t.σ0⁻¹, t.σ1⁻¹, t.σinf⁻¹)` is a bijection between triples satisfying
`σinf * σ1 * σ0 = 1` and triples satisfying the rival relation `σ0 * σ1 * σinf = 1`. State
it as such, and prove it preserves full cycle types, monodromy groups, connectedness, and
automorphism groups. This is the translation lemma every convention-sensitive source
citation points at.

*Prerequisites:* Mathlib `Equiv.Perm`.

#### 0.2 Relabeling and isomorphism classes

Simultaneous conjugation is a left `MulAction` of `Equiv.Perm (Fin n)` on
`PermutationTriple n`: `(τ • t).σ0 = τ * t.σ0 * τ⁻¹`, and likewise for the other two
components; the relation is preserved because conjugation is a group automorphism. Define
isomorphism of triples as `MulAction.orbitRel`, and the type of isomorphism classes as its
quotient.

- *Constructors and instances.* The `SMul` and `MulAction` instances; decidability of the
  orbit relation (finite search).
- *Comparison lemmas.* `τ • ofTwo σ0 σ1 = ofTwo (τσ0τ⁻¹) (τσ1τ⁻¹)`; compatibility with the
  opposite-convention involution.
- *Preservation.* Relabeling preserves full cycle types (Mathlib
  `Equiv.Perm.cycleType_conj`), the product relation, connectedness, and conjugates the
  monodromy and automorphism groups.
- *Downstream interfaces.* Passport classes (Layer 1.2), dessin isomorphism (Layer 2.4),
  cover isomorphism (Layer 6.3).

*Prerequisites:* Layer 0.1; Mathlib `MulAction`, `MulAction.orbitRel`.

#### 0.3 The monodromy group

`monodromyGroup t := Subgroup.closure {t.σ0, t.σ1}`. Prove: `σinf ∈ monodromyGroup t`;
closure of all three components equals closure of the first two; relabeling by `τ` maps the
monodromy group to its conjugate `Subgroup.map (MulAut.conj τ).toMonoidHom`; the monodromy
groups of isomorphic triples are conjugate.

*Prerequisites:* Layers 0.1, 0.2; Mathlib `Subgroup.closure`.

#### 0.4 Connectedness and automorphisms

`IsConnected t : Prop` is the conjunction of `n ≠ 0` and
`MulAction.IsPretransitive (monodromyGroup t) (Fin n)`, with a decidability instance.
⚠ Pretransitivity alone is vacuously true at `n = 0`, where the genus formula fails; the
`n ≠ 0` clause is part of the definition.

The automorphism group of `t` is `MulAction.stabilizer (Equiv.Perm (Fin n)) t` — the
simultaneous centralizer. Prove:

- `automorphismGroup t = ⨅` of the centralizers of `σ0` and `σ1`, equivalently the
  centralizer of `monodromyGroup t` in `Equiv.Perm (Fin n)`;
- for connected `t` the automorphism action on `Fin n` is free (a permutation centralizing a
  transitive subgroup and fixing a point is the identity), so `Nat.card` of the automorphism
  group divides `n`;
- relabeling conjugates automorphism groups.

⚠ *Nearby false statement:* the automorphism group of a triple is not the automorphism group
of its monodromy group, and is trivial for most triples even when the monodromy group has
many automorphisms.

*Prerequisites:* Layers 0.1–0.3; Mathlib `MulAction.IsPretransitive`, `MulAction.stabilizer`,
`Subgroup.centralizer`.

#### 0.5 Cycle data

Attach to each component its full cycle partition
`fullCycleType σ` (PolynomialGaloisGroups Layer 0) and cycle count
`cycleCount σ := (fullCycleType σ).card`, and prove the bookkeeping this roadmap uses
throughout:

- `(fullCycleType σ).sum = n`, and `cycleCount σ = σ.cycleType.card + (n − σ.support.card)`;
- comparison with the pin's bundled `Equiv.Perm.partition`;
- invariance under conjugation and under transport;
- **the transposition step lemma**: for `i ≠ j`,
  `cycleCount (Equiv.swap i j * σ) = cycleCount σ - 1` if `σ.SameCycle i j` is false, and
  `cycleCount σ + 1` if it holds — the merge/split dichotomy, stated on whichever side of
  multiplication Layer 0.6's induction consumes, with the other side derived;
- **the sign identity**: `Equiv.Perm.sign σ = (-1) ^ (n - cycleCount σ)`, by induction along
  the cycle factors.

*Prerequisites:* PolynomialGaloisGroups Layer 0 `fullCycleType`; Mathlib
`Equiv.Perm.cycleType`, `Equiv.Perm.partition`, `Equiv.Perm.sign`, `Equiv.Perm.SameCycle`.

#### 0.6 Euler characteristic and genus

Define, in `ℤ`,

```text
χ(t) = cycleCount σ0 + cycleCount σ1 + cycleCount σinf − n .
```

Prove, in this order:

1. **Parity.** `2 ∣ (2 - χ(t))` for every product-one triple: applying the sign identity to
   the relation gives `(-1)^(3n - Σ cycleCount) = 1`, so `χ(t)` is even.
2. **Disjoint sums.** The juxtaposition
   `PermutationTriple m → PermutationTriple n → PermutationTriple (m + n)` along
   `finSumFinEquiv`, with `χ` additive, cycle data concatenating, and monodromy the product
   acting componentwise. Conversely every triple decomposes, up to relabeling, as the
   disjoint sum of its restrictions to the monodromy orbits.
3. **The connected bound.** For connected `t`, `χ(t) ≤ 2`. Proof route: write `σ1` as a
   product of `n − cycleCount σ1` transpositions (a minimal factorization along its cycles)
   and induct with the transposition step lemma, tracking the cycle counts of the partial
   products and the orbit count of the partial monodromy; the base case is the transitive
   cyclic triple.

   *Source:* Lando–Zvonkin, *Graphs on Surfaces and Their Applications*, **Proposition
   1.5.3** (p. 44): for a hypermap — their 3-constellation, Definition 1.5.1, which is a
   transitive product-one triple by Definition 1.1.1 — one has
   `χ = c(σ) + c(α) + c(φ) − n = 2 − 2g`.
   ⚠ **Their proof is topological**: `χ ≤ 2` and the parity come from the existence of the
   associated surface, not from combinatorics — as does the other standard reference's, since
   Girondo–González-Diez reaches the genus through **Proposition 1.54** (`χ = 2 − 2g` for a
   compact orientable surface) and **Theorem 1.76** (Riemann–Hurwitz), both presupposing the
   surface. This roadmap deliberately does **not** follow
   it, because Layer 0 must not depend on Layers 5–8; the transposition induction above is
   the combinatorial replacement, and the topological statement reappears independently as
   Layer 8.6's genus reconciliation. An implementer who follows the citation to its proof
   will find the wrong argument for this layer.
4. **The general bound.** `χ(t) ≤ 2 · (number of monodromy orbits)` for `n ≠ 0`, from 2 and
   3.

Then define the genus: `genus t : ℕ := ((2 - χ(t)) / 2).toNat`, with the junk-free
characterization `(genus t : ℤ) = (2 - χ(t)) / 2` and `2 - 2 * (genus t : ℤ) = χ(t)` for
connected `t`, and the display form `genus t = 1 + (n − Σ cycleCount)/2` as an equation of
integers. ⚠ No statement subtracts naturals before the bounds above are in scope.

*Prerequisites:* Layers 0.3–0.5; Mathlib `finSumFinEquiv`, `Int.toNat`.

#### 0.7 Orders and geometry type

`orderTriple t := (orderOf t.σ0, orderOf t.σ1, orderOf t.σinf)` — the LMFDB's `abc` datum.
Prove `orderOf σ = (fullCycleType σ).lcm` (the pin's `lcm_cycleType`, adjusted for the
appended `1`s), and invariance under relabeling.

Define the three-valued `GeometryType` (spherical, Euclidean, hyperbolic) of a connected
triple by the exact rational comparison of `1/a + 1/b + 1/c` with `1`, where `(a,b,c)` is
`orderTriple`. The identity permutation has order `1`. Prove invariance under relabeling and
under the opposite-convention involution.

*Prerequisites:* Layers 0.1, 0.2, 0.5; Mathlib `orderOf`, `Rat` order.

#### 0.8 The example suite

Each example is a named definition with its invariants proved, and each later layer reuses
these rather than inventing new ones:

- **Degree one.** The unique triple of degree `1`; connected; genus `0`.
- **The cyclic triple** `cyclicTriple n` (`n ≥ 1`): `σ0 = finRotate n`, `σ1 = 1`,
  `σinf = (finRotate n)⁻¹` — the monodromy of `z ↦ zⁿ`. Connected; cycle data
  `[n], [1,…,1], [n]`; genus `0`; monodromy cyclic of order `n`; `orderTriple = (n, 1, n)`;
  spherical.
- **A triple unramified over `0`**: degree `2` with `σ0 = 1`, `σ1 = σinf = Equiv.swap 0 1` —
  the monodromy of `z ↦ 4z(1−z)`. Connected; genus `0`. This witnesses that "branch locus
  contained in `{0,1,∞}`" is containment, not equality.
- **A disconnected triple**: the disjoint sum of two cyclic triples, with `χ = 4`.
- **An isomorphic pair**: `cyclicTriple 4` and its relabeling by `Equiv.swap 0 1`, with the
  equivalence exhibited and the equality of passports proved.
- **The Euclidean torus triple** `torusTriple`: degree `4`,
  `σ0 = σ1 = finRotate 4`, `σinf = (finRotate 4 ^ 2)⁻¹`. Connected; cycle data
  `[4], [4], [2,2]`; `χ = 0`; genus `1`; `orderTriple = (4,4,2)`; Euclidean; monodromy
  cyclic of order `4`; automorphism group of order `4` (regular); imprimitive with blocks
  `{0,2},{1,3}`. One example serving Layers 0–4 as the positive-genus, regular, imprimitive,
  Euclidean witness at once.
- **A noncommutative triple**: degree `3`, `σ0 = finRotate 3`, `σ1 = Equiv.swap 0 1`,
  monodromy all of `S₃`; genus `0`; the automorphism group is trivial.

*Prerequisites:* Layers 0.1–0.7; Mathlib `finRotate`, `Equiv.swap`.

### Layer 1: passports, blocks, and finite label semantics

#### 1.1 Passport specifications

```lean
structure PassportSpec (n : ℕ) where
  G : Subgroup (Equiv.Perm (Fin n))
  λ0 λ1 λinf : Multiset ℕ
```

with the well-formedness predicate `PassportSpec.IsAdmissible` (the reference subgroup is
pretransitive; each multiset is a partition of `n`) and the membership predicate: a
connected triple `t` has passport `P` when its monodromy group is conjugate to `P.G` (the
spelling `∃ τ, Subgroup.map (MulAut.conj τ).toMonoidHom (monodromyGroup t) = P.G`, exactly
as PolynomialGaloisGroups spells label membership) and its three full cycle types are the
three partitions. Prove invariance of membership under relabeling, and that membership
depends on `P.G` only through its conjugacy class.

*Prerequisites:* Layers 0.2–0.5; PolynomialGaloisGroups Layer 0.

#### 1.2 Passport classes and passport size

The passport class set of `P` is the (finite) set of isomorphism classes of connected
triples with passport `P`; `passportSize P` is its cardinality. Provide the `Fintype`
instance through Layer 3.1's enumeration, and prove: `passportSize` is invariant under
conjugating the reference subgroup; isomorphic triples have equal passports; the passport
determines degree, genus, `orderTriple`, and geometry type (each is computable from the
partitions alone — with the genus through Layer 0.6's formula).

⚠ *Nearby false statement:* a passport does not determine the isomorphism class; the
smallest counterexamples have several classes in one passport, and Layer 3.5 exhibits one.

*Prerequisites:* Layers 0.6, 0.7, 1.1.

#### 1.3 The normalizer formulation

Fix an embedded pretransitive `G ≤ Equiv.Perm (Fin n)`. Prove the bijection between

- isomorphism classes of connected triples with monodromy group conjugate to `G` and cycle
  data `(λ0, λ1, λinf)`, and
- orbits of the conjugation action of the normalizer `N_{S_n}(G)` on the set of triples
  `(g0, g1, ginf) ∈ G³` with `ginf * g1 * g0 = 1`, `⟨g0, g1⟩ = G`, and the given cycle data.

⚠ The acting group is the normalizer, not `G`: two generating triples of `G` can be
`S_n`-conjugate only through elements normalizing `G`, and inner conjugation is a proper
subgroup of that in general. Every counting statement of Layer 3.4 passes through this
milestone.

*Prerequisites:* Layers 0.2, 0.3, 1.1; Mathlib `Subgroup.normalizer`.

#### 1.4 Blocks, quotient triples, and primitivity

For a connected triple `t`, a block system for the monodromy action (Mathlib
`MulAction.IsBlockSystem`) induces a quotient triple on the finite set of blocks: each
component permutes the blocks, the product relation descends, and the quotient of a
connected triple is connected. Build:

- the quotient construction, packaged with a chosen equiv from the block set to `Fin m`, and
  its independence of that choice up to relabeling;
- compatibility of cycle data: the cycle of a block under the quotient of `σ` has length the
  cycle length of any member point divided by the block-cycle multiplicity — stated
  precisely, this is the block-imprimitivity refinement of `fullCycleType`;
- `IsPrimitive t := MulAction.IsPreprimitive (monodromyGroup t) (Fin n)`, decidable, with
  the trivial-blocks characterization from the pin;
- transitivity of quotients: block systems refine, and quotient triples compose.

Nothing here asserts a canonical primitivization: a triple can admit non-isomorphic maximal
proper quotients, and Layer 14 encodes the LMFDB's `primitivization` as data (a chosen block
system), not as a derived value.

*Prerequisites:* Layers 0.2–0.4; Mathlib `MulAction.IsBlock`, `IsBlockSystem`,
`IsPreprimitive`.

#### 1.5 The passport of a triple

`passportOf t : PassportSpec n` — the monodromy group itself as reference subgroup with the
three full cycle types — with `HasPassport t (passportOf t)`, and the universal property:
`t'` is in the passport class set of `passportOf t` iff `t'` is connected with the same
degree, conjugate monodromy, and equal cycle data. This is the bridge every LMFDB-facing
statement uses to pass from a stored triple to its passport row.

*Prerequisites:* Layers 1.1, 1.2.

#### 1.6 Label semantics at reference degrees

For `n ≤ 11`, interpret the group component of an LMFDB passport label through
PolynomialGaloisGroups: the passport's reference subgroup satisfies
`TransitiveGroupLabel j` for the index `j : TransitiveGroupIndex n` displayed as `nTj+1`.
State the label-semantics predicate for the stable mathematical part of a passport label —
degree, `nTj` group, and the three partitions — as a predicate on `PassportSpec`, and prove
it invariant under conjugating the reference subgroup. The final orbit letter of a full
LMFDB label is an external enumeration of Galois orbits inside a passport; it is
deliberately not interpreted at this layer (Layer 14.4 records its status).

*Prerequisites:* Layer 1.1; PolynomialGaloisGroups Layers 6, 7.

### Layer 2: dessins as finite bipartite ribbon graphs

#### 2.1 The generic carrier

```lean
structure BipartiteRibbonGraph where
  E B W : Type
  [fintypeE : Fintype E] [fintypeB : Fintype B] [fintypeW : Fintype W]
  [decE : DecidableEq E] [decB : DecidableEq B] [decW : DecidableEq W]
  blackEnd : E → B
  whiteEnd : E → W
  rotB : Equiv.Perm E
  rotW : Equiv.Perm E
  blackEnd_surjective : Function.Surjective blackEnd
  whiteEnd_surjective : Function.Surjective whiteEnd
  blackEnd_rotB : ∀ e, blackEnd (rotB e) = blackEnd e
  whiteEnd_rotW : ∀ e, whiteEnd (rotW e) = whiteEnd e
  isCycleOn_rotB : ∀ b, rotB.IsCycleOn (blackEnd ⁻¹' {b})
  isCycleOn_rotW : ∀ w, rotW.IsCycleOn (whiteEnd ⁻¹' {w})
```

Edges are abstract; each edge has one black and one white end; the rotation at a vertex is
the typed cyclic order on its incident edges — a permutation that preserves each incidence
fiber and is a single cycle on it. ⚠ Cyclic orders are never encoded as lists with coverage
side conditions; `Equiv.Perm.IsCycleOn` is the law, and the empty-fiber degenerate case is
excluded by surjectivity of the incidence maps (no isolated vertices — a dessin's vertices
are cycles, so this loses nothing).

**New object: `BipartiteRibbonGraph`.** Basic API: morphisms (triples of maps commuting
with incidences and rotations) and isomorphisms; automorphism groups; the face permutation
`facePerm := (rotW * rotB)⁻¹` with `facePerm * rotW * rotB = 1` — the same display order as
the triple relation; connectedness (`Nonempty E` and joint pretransitivity of
`Subgroup.closure {rotB, rotW}` on `E`); connected components; degree of a vertex = card of
its fiber; the Euler characteristic
`χ = card B + card W − card E + card (faces)` in `ℤ`, where faces are the orbits of
`facePerm`; the edge count `Σ (degree of black vertices) = card E`.

*Prerequisites:* Mathlib `Equiv.Perm.IsCycleOn`, `MulAction.orbitRel`.

#### 2.2 From triples to dessins

For a triple `t` of degree `n ≠ 0`: `E := Fin n`; `B` and `W` are the quotients of `Fin n`
by the orbit relations of the cyclic groups generated by `σ0` and `σ1`; the incidences are
the quotient maps; `rotB := σ0`, `rotW := σ1`. Prove the `IsCycleOn` laws (an orbit of a
single permutation is a cycle of it), that the dessin is connected iff `t` is, that its
faces biject with the cycles of `σinf`, and that its Euler characteristic equals `χ(t)`
(`card B + card W + card faces = Σ cycleCount`, edges `n` counted once).

*Prerequisites:* Layers 0.1–0.6, 2.1.

#### 2.3 From dessins to triples

For a connected `Γ` with a chosen equiv `ν : Γ.E ≃ Fin n`: the triple
`ofTwo (ν.permCongr Γ.rotB) (ν.permCongr Γ.rotW)`. Prove that a different choice of `ν`
yields a relabeled triple, so the isomorphism class of the triple is well-defined, and that
the face permutation transports to `σinf`.

*Prerequisites:* Layers 0.1, 0.2, 2.1.

#### 2.4 The equivalence of classifications

Round trips: triple → dessin → triple is the original up to the identity relabeling of
`Fin n`; dessin → triple → dessin is isomorphic to the original, naturally. Conclude the
bijection between isomorphism classes of connected dessins and isomorphism classes of
connected triples, with automorphism groups matching. Every counting statement about
dessins reduces along this bijection to Layer 3.

*Prerequisites:* Layers 2.2, 2.3.

#### 2.5 Genus of a dessin

`χ`, parity, the connected bound `χ ≤ 2`, and the genus — transported along 2.4 from
Layer 0.6, with the Euler-characteristic equality of 2.2 doing the work. The combinatorial
genus stays independent of any analytic surface until Layer 7.6 proves they agree.

*Prerequisites:* Layers 0.6, 2.2, 2.4.

#### 2.6 The action of permuting branch points

The six operations reindexing the roles of `0, 1, ∞`. The convention forces the exact
formulas; the two generating operations are

- **color swap** `(σ0, σ1, σinf) ↦ (σ1, σ0, σ0⁻¹ · σinf · σ0)` (swap `0 ↔ 1`), and
- **the `1 ↔ ∞` swap** `(σ0, σ1, σinf) ↦ (σ1⁻¹ · σ0 · σ1, σinf, σ1... )` — each stated with
  its proof that the product relation is restored and its effect on cycle data; the
  conjugators are not optional, and the milestone records each of the six operations'
  formula rather than a schema.

Prove: each operation preserves connectedness, genus, and the monodromy group up to
conjugacy; the operations descend to isomorphism classes; on classes they compose as an
action of `S₃`; on dessins the color swap exchanges black and white and the `1 ↔ ∞` swap is
the classical duality exchanging white vertices and faces.

⚠ *Nearby false statement:* on triples themselves (not classes) these operations do not
satisfy the `S₃` relations on the nose; the conjugators obstruct it. Only the induced action
on isomorphism classes is an action.

*Prerequisites:* Layers 0.2, 2.4.

#### 2.7 Dessin examples

The dessins of the Layer 0.8 suite, drawn out as data: the `n`-star of `cyclicTriple n`
(one black vertex, `n` white, `n` edges, one face at genus `0`); the segment dessin of the
`4z(1−z)` triple (two black, one white, two edges); the torus dessin of `torusTriple` (one
black, one white, four edges, two faces, `χ = 0`); and the `S₃` example. Each with its
Euler characteristic computed by `decide`/`#eval`-friendly instances.

*Prerequisites:* Layers 0.8, 2.2.

### Layer 3: finite enumeration and character-theoretic counts

#### 3.1 Executable enumeration

For each fixed `n`, genuine `def`s (never `noncomputable`, never bare existence):

- the `Fintype` instance on `PermutationTriple n` through `ofTwo` (the third component is
  determined);
- decidable connectedness (pretransitivity of the closure is a finite orbit computation) and
  decidable primitivity;
- the `Finset` of connected triples; the partition of it into isomorphism classes (orbit
  enumeration under the relabeling action); the passport fibers;
- soundness and completeness as `Finset` equalities, so that `passportSize` and the class
  lists are `#eval`-able at small degree, with `decide`-checked unit tests at `n ≤ 3`.

Complexity is not a completion criterion; `n!·n!` enumeration is acceptable.

*Prerequisites:* Layers 0.1–0.4, 1.1, 1.2, 1.4.

#### 3.2 The Frobenius product-one formula

This roadmap owns the counting formula; CharacterTheory owns everything it consumes. Build,
in order:

1. **Inverse classes.** The involution `ConjClasses G → ConjClasses G` induced by `g ↦ g⁻¹`,
   with `carrier (C⁻¹) = (carrier C)⁻¹` and its interaction with class sizes. (Small; on no
   other roadmap.)
2. **Count-to-structure-constant conversion.** For conjugacy classes `C0, C1, Cinf` of a
   finite group `G`,

   ```text
   #{(x, y, z) ∈ C0 × C1 × Cinf | z * y * x = 1}
     = Nat.card Cinf * structureConstant C1 C0 (Cinf⁻¹) ,
   ```

   from representative-independence of `structureConstant`.
3. **The character formula for structure constants.**

   ```text
   structureConstant Ci Cj Ck
     = (|Ci| * |Cj| / |G|) * Σ_χ χ(gᵢ) χ(gⱼ) χ(gₖ⁻¹) / χ(1)
   ```

   over the irreducible characters, derived from `centralCharacter_coordinate`, column
   orthogonality `char_column_orthogonality`, and the conversion
   `ω_χ(K_j) = |C_j| · χ(g_j) / χ(1)` (CharacterTheory Layer 4). State it over `ℂ` as an
   identity of complex numbers with the natural-number count cast in.
4. **The assembled product-one formula.**

   ```text
   #{(x, y, z) ∈ C0 × C1 × Cinf | z * y * x = 1}
     = (|C0| * |C1| * |Cinf| / |G|) * Σ_χ χ(g0) χ(g1) χ(ginf) / χ(1) .
   ```

5. **The mandatory worked check**, chosen to detect a wrong class-size factor or a stray
   inverse: in `S₃`, with `C0` the `3`-cycles and `C1 = Cinf` the transpositions, both
   sides equal `6`; and with all three classes the transpositions, both sides equal `0`.
   Proved, not `#eval`-ed (the character side is noncomputable).

⚠ *Nearby false statement:* the raw count is not the number of triples with those cycle
types (a class is a `G`-class, and an `S_n`-cycle type can split into several), it does not
impose generation, and it counts triples, not isomorphism classes. Layers 3.3 and 3.4 close
those three gaps separately.

*Prerequisites:* CharacterTheory Layers 1, 3, 4; Layer 0.1.

#### 3.3 Generating triples

For a finite group `G` and classes as above, the count of triples that in addition generate
`G`, by inclusion–exclusion over the subgroup lattice: define the generating count by strong
downward recursion (`total H = Σ_{K ≤ H} generating K`, with the sum over actual subgroups,
then regrouped by conjugacy with the multiplicity `[N_G(K) : K]`-bookkeeping stated
explicitly), and prove the recursion. A Möbius-function closed form is stated only if the
pin's incidence-algebra API supports it; the recursion is the milestone.

*Prerequisites:* Layer 3.2; Mathlib `Subgroup` lattice, strong induction on finite
subgroup lattices.

#### 3.4 From counts to passport sizes

Combine Layers 1.3, 3.2, 3.3: the passport size is the number of
`N_{S_n}(G)`-orbits of generating triples with the prescribed cycle data, computed from the
generating counts refined over the `G`-classes inside each `S_n`-cycle-type and Burnside's
lemma (`MulAction.sum_card_fixedBy_eq_card_orbits_mul_card_group`) for the normalizer
action. Every ingredient is named; no step identifies a raw Frobenius count with
`passportSize`.

*Prerequisites:* Layers 1.3, 3.2, 3.3; Mathlib Burnside.

#### 3.5 The small complete tables

Run Layer 3.1 at degrees `n ≤ 4`: the complete, proved list of isomorphism classes of
connected triples, their passports, genera, and geometry types, as theorems with `decide`
or `Finset.sort`-normal-form proofs. Exhibit at these degrees: a passport with more than one
class, an imprimitive triple, and agreement of `passportSize` with Layer 3.4's formula for
one nonabelian monodromy group. Compare against the frozen LMFDB records of degree `≤ 4`
recorded in `PROVENANCE.md`: every frozen record's triple data matches exactly one
enumerated class, and distinct records match distinct classes. No claim is made that the
database lists all classes, and none is needed.

*Prerequisites:* Layers 3.1, 3.4; the frozen snapshot in `PROVENANCE.md`.

### Layer 4: triangle groups

#### 4.1 The oriented triangle group

For `a b c : ℕ`, the presented group

```lean
def TriangleGroup (a b c : ℕ) : Type :=
  PresentedGroup {x ^ a, y ^ b, z ^ c, z * y * x}
```

on three generators `x, y, z : FreeGroup (Fin 3)` — the relation in the same display order
as everything else in this roadmap. Universal property via `PresentedGroup.toGroup`: maps to
`H` correspond to triples of elements of orders dividing `(a, b, c)` with `z·y·x ↦ 1`.
API: the three distinguished generators; `TriangleGroup a b c ≃* TriangleGroup` of any cyclic
rotation of `(a,b,c)`; the elimination of `z` (isomorphism with the two-generator
presentation `⟨x, y | x^a, y^b, (y·x)^c⟩`); behaviour at parameter `0` (`x^0 = 1` is the
trivial relator, giving the free-er groups; the LMFDB's `abc` are always `≥ 1`, and
statements assume `1 ≤ a b c` where they need it).

*Source:* Girondo–González-Diez, **Definition 2.28** names `Γ_{n,m,l}` the triangle group of
signature `(n,m,l)`, and **Remark 2.29** gives its uniqueness up to conjugation in
`PSL(2,ℝ)`. ⚠ The abstract presentation `x₁ⁿ = x₂ᵐ = x₃ˡ = x₁x₂x₃ = 1` appears there as
*unnumbered* prose on p. 119, and the book does **not** prove that the geometric group has no
further relations — it cites Jones–Singerman for that. This roadmap takes the presentation as
the **definition**, so nothing here depends on that unproved match; Layer 4.4's spherical
classification and Layer 4.5 are what tie the presented group to a concrete group.

⚠ *Nearby false statement:* `Γ_{∞,∞,∞}` is free of rank two, not of rank three — the third
generator is determined. The presented group here degenerates the same way at parameter `0`.

*Prerequisites:* Mathlib `PresentedGroup`, `FreeGroup`.

#### 4.2 Triples as permutation representations

A degree-`n` triple `t` whose component orders divide `(a, b, c)` induces
`TriangleGroup a b c →* Equiv.Perm (Fin n)` sending `x, y, z` to `σ0, σ1, σinf`; its range
is the monodromy group; `t` is connected iff the induced action on `Fin n` is
pretransitive. Conversely a finite pretransitive action of `TriangleGroup a b c` on a
nonempty `Fin n` yields a connected triple with orders dividing `(a, b, c)`, and the two
constructions are inverse up to relabeling. This is the classification of connected triples
with bounded orders by conjugacy classes of transitive finite permutation representations of
the triangle group.

*Prerequisites:* Layers 0.1–0.4, 4.1.

#### 4.3 Dividing versus exact orders

Separate the three statements a source can mean: orders dividing `(a,b,c)` (the universal
property); orders exactly `(a,b,c)` (the LMFDB's `abc` datum, `orderTriple t = (a,b,c)`);
and the monodromy group as a quotient of the triangle group. Provide the predicate for exact
orders and the lemma that a triple with exact orders exists for `(a,b,c)` iff the evident
divisibility and parity constraints admit it — stated as a constraint interface, with the
constructions at small degree from Layer 0.8 as witnesses.

*Prerequisites:* Layers 0.7, 4.2.

#### 4.4 The trichotomy: spherical and Euclidean cases

Define the orbifold Euler characteristic `χᵒʳᵇ(a,b,c) := 1/a + 1/b + 1/c − 1 ∈ ℚ` and prove
its sign matches Layer 0.7's geometry type of any connected triple with exact orders
`(a,b,c)`. Then:

- **Spherical classification, proved.** For `χᵒʳᵇ > 0` with `1 ≤ a ≤ b ≤ c`, the parameter
  triples are `(1, m, m)`, `(2, 2, m)`, `(2, 3, 3)`, `(2, 3, 4)`, `(2, 3, 5)`; the triangle
  group is finite of order `2/χᵒʳᵇ` — cyclic, dihedral, `A₄`, `S₄`, `A₅` respectively —
  proved via explicit permutation representations (the Layer 0.8 suite supplies the cyclic
  case; the polyhedral cases get explicit triples) and a bound forcing the order.
- **Euclidean infiniteness, proved.** For `χᵒʳᵇ = 0` — parameters `(3,3,3)`, `(2,4,4)`,
  `(2,3,6)` — the triangle group is infinite, by the explicit affine representation: `x` and
  `y` map to rotations of `ℂ` about `0` and `1` through `2π/a`, `2π/b` as elements of the
  affine group `z ↦ αz + β`, the relation is a computation in that group, and the
  commutator `[x, y]` is a nontrivial translation, of infinite order.

*Source:* Girondo–González-Diez, **Remark 2.30**, which states the trichotomy qualitatively —
the group is infinite in the Euclidean case and finite in the spherical case — and constructs
the Euclidean and spherical groups by the same reflection route as the hyperbolic one.
⚠ It is a remark, not a theorem, it gives no orders, and the identification of the spherical
groups with the cyclic, dihedral, `A₄`, `S₄` and `A₅` families is **not** in that section; the
only case it names is `Γ_{2,2,2} ≅ (ℤ/2)²`. The classification above is therefore this
roadmap's own work, and the explicit permutation representations are what prove it.

*Prerequisites:* Layers 0.7, 4.1, 4.2; Mathlib `ℚ`, complex affine maps.

#### 4.5 Hyperbolic infiniteness

For `χᵒʳᵇ < 0`, `TriangleGroup a b c` is infinite. The route is an explicit representation
into `PSL₂(ℝ)`: rotations through `2π/a` and `2π/b` about two points at the hyperbolic
distance the angle sum forces, written as explicit real matrices whose entries involve
`cos(π/a)`, `cos(π/b)`, `cos(π/c)`; the relations are trigonometric identities; and the image
contains an element of trace `> 2`, hence of infinite order, which is what infiniteness
reduces to. The milestone owns the matrices and the identities, and **faithfulness of the
representation is not claimed and not needed** — only that the image is infinite.

*Source:* Girondo–González-Diez §2.4 is the classical treatment, and it takes a different
route: a hyperbolic triangle with angles `π/a, π/b, π/c`, the three reflections in its sides,
and **Theorem 2.27 (Poincaré's polygon theorem)** for discreteness, with infiniteness falling
out of the tessellation. ⚠ **That book prints no matrices for the general hyperbolic case and
no trace formula** — its explicit matrices are confined to the two worked examples
`Γ_{2,3,∞} = PSL(2,ℤ)` (**Theorem 2.31**) and `Γ_{∞,∞,∞} = Γ(2)` (**Theorem 2.34**). So the
construction above is this roadmap's, chosen because it needs only `SL(2,ℝ)` arithmetic and
real trigonometry, where the geometric route would first require hyperbolic area, geodesics
and Poincaré's theorem — a development no roadmap owns and this one does not need.

⚠ *Nearby false statement:* discreteness is *not* what this milestone claims. The image being
infinite needs one element of infinite order; discreteness of the image, and faithfulness,
are strictly stronger and are where the geometric route's real work lies.

*Prerequisites:* Layers 4.1, 4.4; Mathlib `Matrix.SpecialLinearGroup`, real trigonometry.

#### 4.6 Regular triples and normal subgroups

A connected triple is *regular* when its automorphism group acts transitively on `Fin n`
(equivalently, by 0.4, the monodromy action is free and transitive on a nonempty fiber —
each characterization proved). Prove the correspondence: isomorphism classes of regular
connected triples with orders dividing `(a,b,c)` biject with finite-index normal subgroups
of `TriangleGroup a b c`, the deck/automorphism group being the finite quotient; under 4.2
the correspondence restricts the classification to the regular locus. The `torusTriple` is
the worked example (`N ⊴ TriangleGroup 4 4 2` of index `4`).

*Prerequisites:* Layers 0.4, 4.2; Mathlib `Subgroup.Normal`, quotient groups.

### Layer 5: the thrice-punctured sphere and its fundamental group

The concrete model is affine: `ℙ¹(ℂ) ∖ {0, 1, ∞}` is `ℂ ∖ {0, 1}`, and the sphere enters
only through the open embedding of 5.1.

⚠ **There is a classical route that this roadmap deliberately does not take.**
Girondo–González-Diez **Theorem 2.34** identifies the triangle group `Γ_{∞,∞,∞}` with the
principal congruence subgroup `Γ(2)` and with the fundamental group of the thrice-punctured
sphere, and pp. 125–126 match its three generators with loops around `0`, `1` and `∞`
explicitly. Taking that as the definition would import uniformization, Fuchsian groups and
the modular group — material belonging to the modular-forms family that nothing else here
needs. The route below computes the fundamental group directly instead, and Layer 5.6's
result is the same isomorphism.

**The route is pinned, because the pin lacks a Seifert–van Kampen theorem and this
roadmap does not build a general one.** Instead it builds the one case it needs — two
open sets with simply connected intersection — from the subdivision infrastructure the
pin does have: `exists_monotone_Icc_subset_open_cover_unitInterval` and its square
analogue `..._prod_self` refine any open cover of `[0,1]` (respectively of `[0,1]²`) into
a monotone partition subordinate to it, and `Path.subpath`, `Path.concat`,
`Path.Homotopy.concatSubpath` and `Path.Homotopy.subpathTransSubpath`
(`Mathlib/Topology/Subpath.lean`) reassemble the pieces. Those five declarations are the
whole engine: 5.5 is a Lebesgue subdivision in one variable for the generation half and in
two variables for the relation half. The base case `π₁(ℂ ∖ {0}) ≅ ℤ` is not proved by hand
either — it is read off the pin's `Complex.isAddQuotientCoveringMap_exp`, which presents
`exp : ℂ → ℂ ∖ {0}` as the quotient of the (convex, hence simply connected) plane by
`AddSubgroup.zmultiples (2 * π * I)`.

#### 5.1 The base space and its standard two-set cover

Define

```text
U := {z : ℂ // z ≠ 0 ∧ z ≠ 1}
```

with basepoint `b := 1/2`, and the two open sets

```text
A := U ∩ {z | z.re < 1} ,      B := U ∩ {z | 0 < z.re} .
```

Prove the four facts the rest of the layer runs on, each an explicit computation:

- `A ∪ B = U` (if `re z < 1` then `z ∈ A` unless `z = 0`; otherwise `re z ≥ 1 > 0` so
  `z ∈ B` unless `z = 1`);
- `A = {z | z.re < 1} ∖ {0}` and `B = {z | 0 < z.re} ∖ {1}` — each an open **convex** set
  with one point removed, the point being interior to it;
- `A ∩ B = {z | 0 < z.re ∧ z.re < 1}`, the open vertical strip, with **no** point removed,
  because neither `0` nor `1` lies in it. The strip is convex, hence contractible, hence
  simply connected and path-connected, and it contains `b`;
- `b ∈ A ∩ B`.

**New object: `U`.** Basic API:

- *Constructors and instances.* `TopologicalSpace`, `T2Space`, `LocPathConnectedSpace`,
  `PathConnectedSpace`, second countability, and the semilocal simple connectivity class
  UniversalCovers' classification needs — all from "open subset of `ℂ`", each proved once
  here rather than at each use. `Nonempty`, the coercion to `ℂ`, and the two membership
  lemmas `ne_zero`, `ne_one`.
- *Examples.* `b = 1/2`; the two circles of 5.2.
- *Morphisms and functoriality.* The open embedding `U ↪ ℂ`; the open embedding
  `U ↪ OnePoint ℂ` with image the complement of `{0, 1, ∞}` — the statement that makes
  "thrice-punctured **sphere**" honest, and the one Layers 7 and 8 extend across.
- *Comparison lemmas.* The three self-homeomorphisms of `U` permuting the punctures in
  the affine chart (`z ↦ 1 − z` swaps `0, 1` and fixes `∞`; `z ↦ 1/z` swaps `0, ∞`), and
  their compatibility with the branch-point action of Layer 2.6.
- *Edge cases.* `A` and `B` are each connected but neither is simply connected; `A ∩ B` is
  simply connected but is **not** all of `U`.
- *Downstream interfaces.* Layers 6, 7, 8, and the analytic side of 12.3.

⚠ *Nearby false statement:* `A ∩ B` is simply connected only because both punctures lie
on its boundary lines `re = 0` and `re = 1`. Sliding the cut to `A = U ∩ {re < 1/2}`,
`B = U ∩ {re > 1/2}` would leave the same intersection, but shifting it the other way so
that a puncture falls inside the strip destroys the hypothesis of 5.5 and the conclusion
of 5.6 with it.

*Prerequisites:* Mathlib `Complex`, `LocPathConnectedSpace`, `OnePoint`,
`Convex.isPathConnected`; UniversalCovers milestone 2's hypothesis classes.

#### 5.2 The peripheral loops

The two loops at `b`, both traversed counterclockwise in the affine chart:

```text
γ0 (t) = (1/2) · exp (2πit)          -- the circle |z| = 1/2, inside A
γ1 (t) = 1 − (1/2) · exp (2πit)      -- the circle |z − 1| = 1/2, inside B
```

Both are loops at `b = 1/2`, since `γ0 0 = γ0 1 = 1/2` and `γ1 0 = γ1 1 = 1/2`; both avoid
both punctures, since `|γ0 t| = 1/2` and `|γ1 t − 1| = 1/2`; and their images `C₀`, `C₁`
lie in `A` and `B` respectively. The two circles are externally tangent — the distance
between their centres is `1 = 1/2 + 1/2` — so they meet exactly at `b`, which is why the
picture is a figure eight and not two crossing circles.

Define the peripheral elements of `FundamentalGroup U b`:

```text
periph0 := ⟦γ0⟧ ,   periph1 := ⟦γ1⟧ ,   periphInf := (periph1 * periph0)⁻¹ ,
```

so that

```text
periphInf * periph1 * periph0 = 1
```

holds **by definition**. The mathematical content is not this identity but the geometric
identification of `periphInf`, which is the milestone: `periphInf` is freely homotopic in
`U` to the circle `|z| = 2` traversed **clockwise**, equivalently to a small loop
counterclockwise around `∞` in the chart `w = 1/z` of `OnePoint ℂ`. Prove it by the
explicit homotopy through the region `|z| ≥ 2` after a subdivision, or by computing the
winding numbers of the three loops about `0` and about `1` (Mathlib's
`Complex.integral_circle` / index API) and using that a loop in `U` is determined up to
free homotopy in the complement by that pair only for these particular classes — the
milestone records which of the two proofs is intended and carries it out.

⚠ *Nearby false statement:* "the loop around `∞` is counterclockwise" is meaningless
without naming the chart. The transition `w = 1/z` reverses the apparent orientation, so
the same curve is clockwise in `z` and counterclockwise in `w`. Every source citation in
this roadmap that fixes a peripheral orientation records the chart it uses; a citation
that does not is not usable for a sign.

*Prerequisites:* Layer 5.1; Mathlib `Complex.exp`, `Path`, `Path.Homotopic.Quotient`.

#### 5.3 The monodromy homomorphism

For a covering map `p : E → X` and `x : X`, package the pin's `IsCoveringMap.monodromy`
as a group homomorphism

```text
monodromyHom : FundamentalGroup X x →* Equiv.Perm (p ⁻¹' {x}) ,
```

taking `IsCoveringMap.monodromy_bijective` for the `Equiv` and
`IsCoveringMap.monodromy_trans_apply` for multiplicativity.

**New object: `monodromyHom`.** Basic API:

- *Constructors and instances.* The definition; the value lemma
  `monodromyHom γ e = p.monodromy (FundamentalGroup.toPath γ) e`.
- *Examples.* The trivial cover, where it is trivial; the exponential cover of 5.4, where
  it is the translation action of `ℤ` on `2πiℤ`.
- *Morphisms and functoriality.* Naturality in maps of covers over `X`; compatibility with
  `FundamentalGroup.map` under pullback along `f : Y → X`, namely
  `monodromyHom (f* p) = monodromyHom p ∘ FundamentalGroup.map f` modulo the canonical
  identification of fibers.
- *Comparison lemmas and naturality.* Transport along a numbering `ν` of the fiber:
  `ν.permCongr ∘ monodromyHom` is again a homomorphism, and changing `ν` conjugates it.
- *Edge cases.* Empty fiber; fiber of size one.
- *Downstream interfaces.* Layers 5.4, 5.6, 6.1, 6.3, 7.1.

⚠ **The direction is a theorem of the pin, not a choice.** `monodromy_trans_apply` reads
`monodromy (γ.trans γ') = monodromy γ' ∘ monodromy γ`, and `End.mul_def` makes `γ * γ'` in
`FundamentalGroup` the class of `γ'.trans γ`. Together these make `monodromyHom` a
homomorphism with no `ᵐᵒᵖ` and no inversion; the roadmap's product relation
(§Pinned conventions) is the consequence. A treatment that composes paths in the other
order gets an antihomomorphism here and must invert, and that inversion propagates all the
way to the branch-cycle exponent of Layer 12.10.

*Prerequisites:* Mathlib `IsCoveringMap.monodromy`, `monodromy_trans_apply`,
`monodromy_bijective`, `CategoryTheory.End.mul_def`.

#### 5.4 Punctured convex domains

The reusable computation, stated for a convex open `V ⊆ ℂ`, a point `p ∈ V`, and a radius
`r > 0` with the circle `|z − p| = r` contained in `V`:

- **The retraction.** The radial map `z ↦ p + r·(z − p)/|z − p|` is a deformation retraction
  of `V ∖ {p}` onto that circle, along the straight-line homotopy. Both endpoints of each
  homotopy segment lie on the ray from `p` through `z`, at distances between
  `min(|z − p|, r)` and `max(|z − p|, r)` from `p`; convexity of `V` puts the whole segment
  `[p, p + r·u]` in `V`, and the distance bound keeps it off `p`.
- **The base computation.** `π₁(ℂ ∖ {0}, 1) ≅ ℤ`, generated by the counterclockwise unit
  circle. Proof: `Complex.isAddQuotientCoveringMap_exp` exhibits `ℂ ∖ {0}` as the quotient
  of `ℂ` by `AddSubgroup.zmultiples (2πi)` acting freely and properly discontinuously; `ℂ`
  is convex, hence simply connected; so UniversalCovers' quotient-covering identification
  applies and `π₁` is the acting group. ⚠ That identification lands in the **opposite**
  group in general (UniversalCovers milestone 5), which is invisible here only because
  `ℤ` is abelian; do not carry the habit into Layer 6.4, where it is not.
- **The transport.** For `V`, `p`, `r` as above, the inclusion `V ∖ {p} ↪ ℂ ∖ {p}` is a
  homotopy equivalence, because both deformation-retract onto the same circle; hence
  `π₁(V ∖ {p})` is infinite cyclic, generated by the circle loop of radius `r` about `p`.
- **The three instances.** `A` with `p = 0`, `r = 1/2`, whose generator is the class of `γ0`
  **in `A`** — the element that the inclusion `A ↪ U` carries to `periph0`, a distinction
  5.6 needs and 5.2 does not make; `B` with `p = 1`, `r = 1/2`, similarly for `γ1` and
  `periph1` (transport along `z ↦ 1 − z`, which is an isomorphism of the situation and
  reverses no orientation, being holomorphic); and the punctured unit disc `𝔻*` with
  `p = 0`, `r = 1/2`, which Layer 7.1 consumes.

*Source:* the covering-space computation of `π₁(S¹)` is Hatcher, *Algebraic Topology*,
Theorem 1.7; the route here replaces `ℝ → S¹` by the pin's `exp : ℂ → ℂ ∖ {0}`, which is
the same argument with the same proof and an already-formalized covering map.

*Hypotheses:* `V` convex and open, `p ∈ V`, `r > 0`, and `Metric.sphere p r ⊆ V`. Convexity
is used only through "the segment from `p` to a point of the sphere stays in `V`"; a
star-shaped hypothesis about `p` would do, and the milestone states the convex form
because both instances are convex and Mathlib's `Convex` API is the one in place.

⚠ *Nearby false statement:* a punctured **connected** open set is not homotopy equivalent
to a circle — the punctured annulus is a counterexample. Convexity (or star-shapedness
about the puncture) is doing real work.

*Prerequisites:* Mathlib `Complex.isAddQuotientCoveringMap_exp`, `IsQuotientCoveringMap`,
`Convex`, `ContinuousMap.Homotopy`; UniversalCovers milestones 4, 5.

#### 5.5 Van Kampen with a simply connected intersection

The one general topological theorem this roadmap owns. For a space `X`, open `A, B` with
`A ∪ B = X`, a basepoint `x ∈ A ∩ B`, with `A`, `B`, `A ∩ B` path-connected and `A ∩ B`
simply connected, the canonical map from the free product

```text
FundamentalGroup A x ∗ FundamentalGroup B x  →*  FundamentalGroup X x
```

(the `Monoid.Coprod.lift` of the two inclusion-induced maps) is an isomorphism.

- **Surjectivity.** Given a loop `γ` at `x` in `X`, apply
  `exists_monotone_Icc_subset_open_cover_unitInterval` to the cover `{γ⁻¹' A, γ⁻¹' B}` of
  `[0,1]` to get a monotone partition `t₀ = 0 ≤ … ≤ t_m = 1` with each `γ '' [tᵢ, tᵢ₊₁]`
  inside `A` or inside `B`. Each division point lies in `A ∩ B` (it is an endpoint of an
  `A`-piece and of a `B`-piece, or of two pieces of the same type, in which case merge);
  choose for each a path in `A ∩ B` from `x` to it (path-connectedness). Then
  `Path.Homotopy.concatSubpath` rewrites `γ` as the concatenation of the subpaths, and
  inserting the chosen paths and their reverses turns each subpath into a loop at `x`
  inside `A` or inside `B`.
- **Injectivity.** Given a null-homotopy in `X` of a word, apply the square version
  `exists_monotone_Icc_subset_open_cover_unitInterval_prod_self` to the homotopy to get a
  grid of squares each mapping into `A` or into `B`; simple connectivity of `A ∩ B` makes
  the choice of connecting paths irrelevant, so the resulting word reductions are exactly
  the free-product relations. The milestone states the induction over the grid explicitly:
  it is the only place in the roadmap where a two-variable subdivision occurs, and it is
  where the simply connected hypothesis is consumed.

**New object: the van Kampen isomorphism.** Basic API: the isomorphism, its value on each
factor's generators, naturality in maps of triads `(X, A, B)`, the corollary that `X` is
simply connected when both `A` and `B` are, and the corollary for a wedge-shaped
decomposition used in 5.6.

*Source:* Hatcher, *Algebraic Topology*, Theorem 1.20 (van Kampen), specialized to two
sets with simply connected intersection, where the amalgamating subgroup is trivial and
the pushout is the free product.

*Hypotheses:* `A`, `B` open; `A ∪ B = X`; `A ∩ B` path-connected, simply connected, and
containing the basepoint. ⚠ Path-connectedness of `A ∩ B` is not optional even when the
intersection is simply connected in the naive sense: a two-component intersection makes
the theorem false (`S¹` decomposes into two arcs meeting in two contractible pieces, and
`π₁(S¹) = ℤ` is not the free product of two trivial groups).

*Prerequisites:* Mathlib `exists_monotone_Icc_subset_open_cover_unitInterval`,
`exists_monotone_Icc_subset_open_cover_unitInterval_prod_self`, `Path.subpath`,
`Path.concat`, `Path.Homotopy.concatSubpath`, `Path.Homotopy.subpathTransSubpath`,
`Monoid.Coprod`, `Monoid.Coprod.lift`, `SimplyConnectedSpace`.

#### 5.6 The fundamental group of the thrice-punctured sphere

Apply 5.5 to the cover of 5.1 and 5.4's computation of the two factors:

```text
FundamentalGroup U b  ≃*  ℤ ∗ ℤ  ≃*  FreeGroup (Fin 2) ,
```

the second isomorphism being the free-product-of-free-groups identification, and the
composite sending `FreeGroup.of 0 ↦ periph0` and `FreeGroup.of 1 ↦ periph1`. State the
isomorphism as a named `MulEquiv` together with those two value lemmas — later layers use
the values, never the mere existence. Corollaries: `periphInf` corresponds to
`(of 1 * of 0)⁻¹`; the three peripheral elements generate; and a homomorphism out of
`FundamentalGroup U b` is determined by its values on `periph0` and `periph1`, with any
pair of values realized (the free universal property, which is what Layer 6.2 consumes).

⚠ *Nearby false statement:* the three peripheral elements do not freely generate — they
satisfy the one relation of 5.2, and any two of them freely generate while all three do
not. Statements about "the three generators" always mean the ordered triple with its
relation, never a free basis of rank three.

*Prerequisites:* Layers 5.1, 5.2, 5.4, 5.5; Mathlib `FreeGroup`, `Monoid.Coprod`,
`FreeGroup.lift`.

#### 5.7 Basepoint change

Along a path from `b` to another basepoint, the induced isomorphism of fundamental groups
carries the peripheral elements to conjugates of themselves, and the three peripheral
**conjugacy classes** are independent of the path and of the basepoint. State the
conjugacy-class invariance as the milestone; the element-level statement is false without
fixing a path, and that failure is the topological origin of the outer form of the Galois
action in Layer 12.7.

*Prerequisites:* Layers 5.2, 5.6; UniversalCovers milestone 7's basepoint-change API.

### Layer 6: finite covers and their triples

#### 6.1 The monodromy triple of a finite cover

For a covering map `p : E → U` whose fiber over `b` is finite of cardinality `n`, and a
numbering `ν : p ⁻¹' {b} ≃ Fin n`, the triple

```text
σ_i := ν.permCongr (monodromyHom p periph_i)   for i = 0, 1, ∞
```

is a `PermutationTriple n`: the relation is `monodromyHom` applied to 5.2's relation, and
it is a relation on the nose because 5.3 gives a homomorphism.

Prove: `E` is path-connected iff the triple is connected (path lifting identifies the
monodromy orbits on the fiber with the path components of `E`, and `n ≠ 0` matches
`Nonempty E`); the degree is well-defined (the fiber cardinality is locally constant on
the connected base, hence constant); changing `ν` relabels the triple by the corresponding
element of `Equiv.Perm (Fin n)`; changing the basepoint along a path conjugates it (5.7).
Consequently the **isomorphism class** of the triple is an invariant of the cover alone.

⚠ *Nearby false statement:* connectedness of `E` is transitivity of the monodromy group on
the fiber, not transitivity of the image of any one peripheral element, and not
connectedness of `E` as a set of points over a single point. The empty cover has `n = 0`
and is not connected, exactly matching Layer 0.4.

*Source:* Girondo–González-Diez §2.7 defines the monodromy of a degree-`d` morphism and its
`Mon(f) ≤ Σ_d`, with connectedness giving transitivity, and states that the homomorphism is
well defined up to conjugation by the numbering of the fibre and by the base point.

⚠ **That book inverts where this roadmap does not, and the two agree.** It defines
`M_f(γ) = σ_γ⁻¹` and says explicitly that taking `σ_γ` itself "would have obtained an
anti-homomorphism". That is because its `π₁` multiplies paths in the geometers' order; the
pin multiplies them in the opposite order (`End.mul_def`), which makes the *un-inverted*
`σ_γ` a homomorphism here. The net effect is that the book's monodromy triples are the
componentwise inverses of this roadmap's — the same relation the LMFDB's stored triples bear
to it, and the same Layer 0.1 involution translates both. Three independent conventions,
one bridge.

*Prerequisites:* Layers 0.1–0.4, 5.3, 5.7; Mathlib `IsCoveringMap`,
`IsCoveringMap.exists_path_lifts`.

#### 6.2 The associated cover of a `π₁`-set

The converse construction, and the place where a cover is built rather than analysed.
Given a finite `FundamentalGroup U b`-set `S` — equivalently, by 5.6, a pair of
permutations of `S`, equivalently a triple — form

```text
assocCover S := (UniversalCover U × S) ⧸ π₁ ,
```

the quotient of the product by the diagonal action, `S` carrying the discrete topology.
The action is free and properly discontinuous because it already is on the universal cover
(UniversalCovers milestone 3), so the pin's quotient-covering theory
(`IsQuotientCoveringMap`, `Mathlib/Topology/Covering/Quotient.lean`) makes the induced map
to `U` a covering map.

**New object: `assocCover`.** Basic API:

- *Constructors and instances.* The quotient topology, the covering map, the identification
  of the fiber over `b` with `S`, and finiteness of the fiber when `S` is finite.
- *Examples.* `S` a one-point set gives `U` itself; `S = π₁` with the translation action
  gives the universal cover back; `S = Fin n` with the action of a triple gives the cover
  Layer 6.3 pairs with that triple.
- *Morphisms and functoriality.* A map of `π₁`-sets induces a map of covers over `U`;
  the construction is a functor from finite `π₁`-sets to covers, and it preserves
  coproducts.
- *Comparison lemmas and naturality.* `monodromyHom (assocCover S) = ` the given action,
  under the fiber identification — the computation that makes 6.3 an equivalence rather
  than a pair of unrelated constructions.
- *Edge cases.* `S` empty; `S` with a non-transitive action, where the cover is
  disconnected and decomposes as the coproduct over the orbits.
- *Downstream interfaces.* Layers 6.3, 6.5, 7.2.

*Prerequisites:* Layer 5.6; UniversalCovers milestones 3, 4; Mathlib
`IsQuotientCoveringMap`, `MulAction`.

#### 6.3 The classification

The equivalences, each with a named map in each direction:

- pointed connected covers of `(U, b)` with fiber of size `n`, up to pointed isomorphism
  over `U`, ↔ connected `PermutationTriple n` — 6.1 one way, 6.2 the other, with
  uniqueness of the comparison map from the pin's lifting criterion
  `IsCoveringMap.existsUnique_continuousMap_lifts_of_range_le`;
- unpointed connected covers up to isomorphism over `U` ↔ isomorphism classes of connected
  triples (Layer 0.2's quotient), the passage between the two being UniversalCovers
  milestone 8's conjugacy bookkeeping;
- both compatible with the free-group description of 5.6: transitive
  `FreeGroup (Fin 2)`-sets of cardinality `n` ↔ connected triples, by evaluating the
  action homomorphism at the two generators.

Prove that the correspondences match degree with fiber cardinality, and that they are
natural in maps of covers.

*Source:* Girondo–González-Diez **Theorem 2.61**: two morphisms of the same degree with the
same branch-value set are isomorphic coverings if and only if their monodromies are
conjugate. ⚠ Its hypotheses include *equal branch-value sets*, not merely equal degree; the
statement is false without that, and the analogue here is that the three marked points are
fixed once and for all.

*Prerequisites:* Layers 0.2, 5.6, 6.1, 6.2; UniversalCovers milestone 8; Mathlib
`existsUnique_continuousMap_lifts_of_range_le`.

#### 6.4 Deck transformations

For a connected cover with triple `t`, the deck group is isomorphic to
`automorphismGroup t` of Layer 0.4.

⚠ **This is where the `ᵐᵒᵖ` of UniversalCovers milestone 5 is absorbed, once, explicitly.**
That milestone identifies the deck group of the universal cover with `(π₁)ᵐᵒᵖ`; composing
with the monodromy description turns deck transformations into permutations of the fiber
commuting with the monodromy action, which is the simultaneous centralizer, which is
Layer 0.4's automorphism group. The milestone states the composite with its direction
fixed, and the acceptance test is `torusTriple`: its automorphism group is cyclic of order
`4` (Layer 0.8), so the deck group of the corresponding degree-`4` cover must be cyclic of
order `4` and act freely and transitively on the fiber. A milestone that got the direction
wrong would still produce a group of order `4` here, so the test is stated on the **action**
— which element of the deck group corresponds to which permutation — not on the abstract
isomorphism type.

*Prerequisites:* Layers 0.4, 6.1, 6.3; UniversalCovers milestones 4, 5, 8.

#### 6.5 Regular covers

For a connected finite cover the following are equivalent: the deck group acts transitively
on one (equivalently every) fiber; the triple is regular in the sense of Layer 4.6; the
corresponding subgroup of `FreeGroup (Fin 2)` is normal; the monodromy action is free. In
that case the deck group is isomorphic to the monodromy group, and the correspondence
matches Layer 4.6's bijection between regular triples and finite-index normal subgroups of
a triangle group.

*Source:* Girondo–González-Diez **Definition 2.64** (Galois, equivalently normal or regular,
covering), **Proposition 2.65** (`f` is Galois iff `f* : M(S₂) → M(S₁)` is a Galois field
extension, and then the covering group is `Gal(M(S₁)/M(S₂))`), and **Proposition 2.66**
(`f` is normal iff `deg f = |Mon(f)|`) — the last being the cleanest criterion to formalize,
since both sides are already Layer 0 data.

*Prerequisites:* Layers 4.6, 6.3, 6.4; UniversalCovers milestone 8.

### Layer 7: compactification and topological branched covers

#### 7.1 Covers of the punctured disc

Every connected covering map onto the punctured disc `𝔻* = {z | 0 < |z| < 1}` with finite
fiber of cardinality `e` is isomorphic over `𝔻*` to the restriction of `z ↦ z^e`. Route:
5.4 gives `π₁(𝔻*) ≅ ℤ` generated by the circle loop; 6.3's argument, transported to `𝔻*`,
classifies connected finite covers by transitive finite `ℤ`-sets, i.e. by one cyclic
`ℤ`-set per degree `e`; and the pin's `isCoveringMap_zpow` (restricted to the disc)
realizes the degree-`e` one as `z ↦ z^e`, whose monodromy is a single `e`-cycle.

**New object: the local model.** Basic API: the map, its covering property, its degree, its
monodromy (an `e`-cycle), its deck group (`ℤ/e`, generated by multiplication by a primitive
`e`-th root of unity), the uniqueness of the isomorphism up to that deck group, and the
behaviour under composition (`z ↦ z^{ef}` factors as `z^e` after `z^f`).

⚠ *Nearby false statement:* the classification is up to isomorphism **over** `𝔻*`, and the
isomorphism is not unique — it is unique only up to the deck group, i.e. up to a rotation by
an `e`-th root of unity. Layer 7.4's uniqueness statement is about the compactified branched
cover, where the extra point rigidifies nothing either; the uniqueness there comes from
properness, not from this milestone.

*Prerequisites:* Layers 5.4, 6.1–6.3 (transported to `𝔻*`); Mathlib `isCoveringMap_zpow`,
`isCoveringMapOn_zpow`.

#### 7.2 Filling the punctures

For a connected finite cover `p : E → U` with triple `t`, fix for each puncture
`q ∈ {0, 1, ∞}` the standard punctured-disc neighbourhood `D_q^*` inside `U` (radius `1/2`
about `0` and about `1`, and `|z| > 2` for `∞`, in the chart `w = 1/z`). Prove:

- the connected components of `p ⁻¹' D_q^*` are in bijection with the cycles of `σ_q`, the
  component of a cycle having degree its length — 7.1 applied componentwise, with the
  bijection coming from the monodromy orbit computation of 6.1;
- the filled space `fill t`, obtained by adjoining one point per component, carries a
  topology in which each filled component is homeomorphic to a disc via the chart
  `z ↦ z^{1/e}` transported from 7.1;
- `fill t` is compact, connected, Hausdorff, second countable, and locally homeomorphic to
  `ℂ`.

**New object: `fill`.** Basic API: the topology and its universal property (a map out of
`fill t` is continuous iff its restrictions to `E` and to each filled disc are); the open
embedding `E ↪ fill t` with finite complement; the finite set of filled points with its
labelling by the cycles of the three peripheral permutations; functoriality in maps of
covers; the count `#(filled points) = c(σ0) + c(σ1) + c(σinf)`.

⚠ *Nearby false statement:* the components of `p ⁻¹' D_q^*` are not in bijection with the
points of the fiber, nor with the orbits of the whole monodromy group — they are the orbits
of the single element `σ_q`. Compactness of `fill t` needs the cover to have **finite**
degree; an infinite-degree cover of `U` fills to a non-compact surface.

*Prerequisites:* Layers 0.5, 6.1, 7.1; Mathlib quotient/gluing topology.

#### 7.3 The branched covering map

Extend `p` to `fillMap : fill t → OnePoint ℂ`, sending each filled point to its puncture
and using 5.1's open embedding `U ↪ OnePoint ℂ` on `E`. Prove: continuity (by 7.2's
universal property); properness and surjectivity; that the restriction over
`OnePoint ℂ ∖ {0,1,∞}` is the original covering map; and the **local model**, that at a
filled point coming from a cycle of length `e` the map is `w ↦ w^e` in the pinned charts.

*Prerequisites:* Layers 7.1, 7.2; Mathlib `OnePoint`, properness API.

#### 7.4 Uniqueness of the compactification

Any two extensions of `p` to a proper continuous map from a compact Hausdorff space, with
finite fibers over the punctures and the `z^e` local model, are homeomorphic over
`OnePoint ℂ` by a **unique** homeomorphism restricting to the identity on `E`. Route:
uniqueness of the map is density of `E` plus Hausdorffness of the target; existence is that
the added points of either extension are recovered from `E` alone, as the ends of the
components of `p ⁻¹' D_q^*` — the milestone states the ends description as its own lemma,
since it is what makes the compactification canonical rather than merely constructed.

*Source:* Girondo–González-Diez **Lemma 1.80**: for `Y` compact, `Σ ⊂ Y` finite and
`f* : X* → Y ∖ Σ` an unramified holomorphic covering of finite degree, there is a **unique**
compact Riemann surface `X ⊇ X*` to which `f*` extends as a **unique** morphism `X → Y`, with
`X ∖ X*` finite. The uniqueness of `X` is **Proposition 1.81**, and it is stronger than the
statement needs: the compactification of `X*` is independent of `f` altogether. The
construction — decompose `f⁻¹(V_y*)` into components, add one centre per component, declare
the `z ↦ z^{mᵢ}` chart holomorphic — is given there as unnumbered prose in §1.2.7 and is what
Layers 7.2 and 8.5 spell out.

*Prerequisites:* Layers 7.2, 7.3.

#### 7.5 The ramification dictionary

Over each `q ∈ {0, 1, ∞}` prove: the fiber of `fillMap` bijects with the cycles of `σ_q`;
the local degree at a filled point is its cycle length; the multiset of local degrees over
`q` is `fullCycleType σ_q` (Layer 0.5), a partition of the degree `n`; the branch locus is
contained in the three fibers and consists exactly of the points whose cycle has length
`> 1`; and `Σ e = n` over each of the three fibers. Every LMFDB `lambdas` assertion of
Layer 14 flows through this dictionary.

⚠ *Nearby false statement:* the branch locus can be empty over one or two of the three
punctures — a Belyi map is only required to be unramified **outside** `{0,1,∞}`, not
ramified over all of them. Layer 0.8's degree-`2` example `4z(1−z)` is unramified over `0`.

*Prerequisites:* Layers 0.5, 7.2, 7.3.

#### 7.6 The embedded dessin

The preimage `fillMap ⁻¹' [0, 1]` of the closed real segment, with black points over `0`,
white points over `1`, and edges the components of the preimage of the open segment,
realizes the Layer 2.2 dessin of `t`. State it as a bijection of combinatorial data: edges
to `Fin n`, black vertices to the cycles of `σ0`, white vertices to the cycles of `σ1`,
with the incidence maps and the two rotations matching. The rotation matching is the
content: the cyclic order in which the edges at a black vertex leave it, read
counterclockwise in the chart of 7.2, is the cycle of `σ0`. No general theory of embedded
graphs is developed — only these bijections.

*Prerequisites:* Layers 2.2, 7.2, 7.3, 7.5.

### Layer 8: Riemann surfaces and analytic Riemann existence

#### 8.1 The carriers

The Riemann-surface hypothesis stack, pinned once for the repository's use: a type `X`
with

```text
[TopologicalSpace X] [ChartedSpace ℂ X] [IsManifold 𝓘(ℂ) ω X] [T2Space X]
```

together with `[CompactSpace X]` and `[ConnectedSpace X]` where a milestone needs them,
and second countability where it needs that. **No bundled `RiemannSurface` structure is
introduced**; the hypotheses travel unbundled, as they do in the pin's own manifold
statements. Holomorphic maps are `MDifferentiable 𝓘(ℂ) 𝓘(ℂ)`; the comparison with
`ContMDiff` at exponent `ω` is a milestone, not an assumption. Build:

- **the Riemann sphere.** The `ChartedSpace ℂ (OnePoint ℂ)` instance with the two charts
  `z` and `1/z`, and the `IsManifold 𝓘(ℂ) ω` instance, whose content is that the transition
  `z ↦ 1/z` on `ℂ ∖ {0}` is analytic. With compactness and connectedness of `OnePoint ℂ`
  this is the roadmap's one indispensable example, and everything in Layers 8–10 is stated
  against it.
- **open submanifolds.** The instances for an open subset of a Riemann surface, applied to
  `ℂ`, to `U` (5.1), and to `𝔻*`.
- **holomorphic maps to the sphere.** The identification of holomorphic `X → OnePoint ℂ`
  other than the constant `∞` with meromorphic functions in charts, in the pin's
  `MeromorphicAt`/`MeromorphicOn` vocabulary — the bridge Layer 9.2 turns into a field.
- **the maximum principle.** From the pin's `MDifferentiable.isLocallyConstant` and
  `exists_eq_const_of_compactSpace`: a holomorphic function on a compact connected Riemann
  surface is constant.

*Source:* Forster, *Lectures on Riemann Surfaces*, **1.1**–**1.4** for chart, atlas, complex
structure and Riemann surface, **1.5(c)** for `ℙ¹` with its two charts `z` and `1/z`, **1.9**
for holomorphic maps, **2.8** for constancy on a compact surface and **2.9** for
`ℳ(ℙ¹) = ℂ(z)`; the roadmap's carrier differs from Forster's only in being unbundled.
Girondo–González-Diez **Proposition 1.23** is the identification this layer's third bullet
uses — meromorphic functions on `S` *are* the morphisms `S → Ĉ` other than the constant `∞` —
and **Remark 1.25** is the maximum-principle corollary that a compact connected surface
carries no nonconstant holomorphic function.

⚠ *Nearby false statement:* Hausdorffness is not automatic from the charted-space
structure and must be carried — the line with two origins is charted over `ℂ` and is not a
Riemann surface. Second countability is likewise carried where used, and is not deduced
from compactness plus charts without an argument.

*Prerequisites:* Mathlib `IsManifold`, `ChartedSpace`, `OnePoint`,
`Mathlib/Geometry/Manifold/Complex.lean`, `MeromorphicOn`.

#### 8.2 The local normal form

For a nonconstant holomorphic `f` between connected Riemann surfaces and `x` in the source,
there are charts at `x` and at `f x` in which `f` is `w ↦ w^e`, with `e ≥ 1` unique; define
`ramificationIndex f x := e`.

Route, in proof order: in charts, the pin's `analyticOrderAt` gives the order of vanishing
of `f(·) − f(x)`, finite because `f` is nonconstant and the surface is connected (the
identity theorem); ConformalMapping L0's local-degree statement `TauCeti.exists_localDegree`
and its holomorphic root extraction produce a chart in which the map is exactly `w^e`.

**New object: `ramificationIndex`.** Basic API: the definition and its
chart-independence; `e = 1` exactly at the points where `f` is a local biholomorphism;
the branch locus `{x | e > 1}` is closed and discrete, hence finite when the source is
compact; multiplicativity under composition; behaviour under pre- and post-composition
with biholomorphisms; the value on the model maps `z ↦ z^n` and on `cyclicTriple`'s Belyi
map; the identity theorem for maps of connected surfaces as a companion statement.

*Source:* Forster **2.1** — the local normal form, that a nonconstant holomorphic map is
`z ↦ z^k` in suitable charts — with **2.2** for the multiplicity, **1.11** (identity theorem),
**2.4** (open mapping), and **4.3** with **4.5(b)** for the branch points being exactly where
the multiplicity exceeds `1`.

⚠ *Nearby false statement:* `e` is not the cardinality of a nearby fiber of `f` — that
cardinality is the **sum** of the indices over the fiber, and equals `e` only locally, near
`x`. The distinction is exactly what makes 8.3's degree statement a theorem.

*Prerequisites:* Layer 8.1; ConformalMapping L0 (`TauCeti.exists_localDegree`, branch
roots); Mathlib `analyticOrderAt`, `MeromorphicNFAt`, the identity theorem.

#### 8.3 Finiteness and the degree

A nonconstant holomorphic map `f : X → Y` of compact connected Riemann surfaces is
surjective, open, closed, and finite-to-one; its branch locus and branch values are finite;
and

```text
y ↦ Σ_{x ∈ f ⁻¹' {y}} ramificationIndex f x
```

is constant, its value being the degree `d`. Off the branch values, `f` restricts to a
degree-`d` covering map in the pin's `IsCoveringMap` sense.

*Source:* Forster **4.24** is the degree theorem — for a proper nonconstant map, `Σ v(f,x)`
over a fibre is the same for every value — resting on **4.21(a)** (proper plus discrete gives
finite fibres), **4.22** (a proper local homeomorphism is a covering map) and **4.23** (the
branched-covering statement), with **2.7** for surjectivity from a compact source.
Girondo–González-Diez **Theorem 1.74** packages exactly the three statements
this milestone needs: (i) `f` restricts to a covering away from the branch values, (ii) over a
small disc the preimage is a disjoint union of discs on each of which `f` is `z ↦ z^{mᵢ}`, and
(iii) `Σ mₓ(f)` is independent of the point — with **Definition 1.75** taking that common
value as the degree. ⚠ That book warns that "covering" there means an arbitrary morphism of
compact surfaces, ramified or not; this roadmap reserves the word for the pin's
`IsCoveringMap` and says "branched cover" otherwise.

*Hypotheses:* compactness of the source is what makes the map proper and the branch locus
finite; connectedness of the source is what makes "nonconstant" a global condition.
Compactness of the target is not needed for finiteness of the fibers, but is used for the
constancy statement in the form given.

*Prerequisites:* Layers 8.1, 8.2; Mathlib properness API, `IsCoveringMap`.

#### 8.4 Analytic Belyi pairs

An **analytic Belyi pair** is a compact connected Riemann surface `X` (8.1's stack) with a
nonconstant holomorphic `β : X → OnePoint ℂ` whose branch values lie in `{0, 1, ∞}`.

**New object: `AnalyticBelyiPair`.** Basic API:

- *Constructors and instances.* The structure; the equivalent formulation "`β` restricted
  over `OnePoint ℂ ∖ {0,1,∞}` is a covering map" (equivalent by 8.3), which is the form
  `Suggested.lean` prototypes because it is the one Layer 6 consumes directly.
- *Examples.* `(OnePoint ℂ, z ↦ z^n)`; `(OnePoint ℂ, z ↦ 4z(1−z))`; the genus-one pair of
  `torusTriple`.
- *Morphisms and functoriality.* Morphisms are holomorphic maps over `OnePoint ℂ`;
  isomorphisms are biholomorphisms over it; the automorphism group is finite.
- *Comparison lemmas and naturality.* The attached triple, via 8.3 and Layer 6.1, with its
  isomorphism class an invariant of the pair; the ramification data computed by 7.5;
  degree, genus, and cycle data all invariant under isomorphism of pairs.
- *Edge cases.* `β` unramified over one or two of the three points; `β` of degree `1`,
  where `X` is the sphere and the pair is trivial.
- *Downstream interfaces.* Layers 8.5, 8.6, 9.2–9.5, 10, 11.

*Prerequisites:* Layers 6.1, 7.5, 8.1–8.3.

#### 8.5 The complex structure on the filled cover

The filled space `fill t` of Layer 7.2 carries a unique complex structure making `fillMap`
holomorphic, and with it `(fill t, fillMap)` is an analytic Belyi pair. Route: on the
unramified part pull back the charts of the sphere along the covering map; at a filled point
coming from a cycle of length `e` take 7.2's chart `z ↦ z^{1/e}` as the holomorphic chart;
the transition functions are analytic by construction; `fillMap` is holomorphic away from
the filled points, and across them by the removable-singularity theorem in these charts.
Uniqueness: a homeomorphism of Riemann surfaces holomorphic off a finite set is
holomorphic, again by removability.

*Source:* Forster **4.6** (the unique complex structure making a local homeomorphism
holomorphic), then **8.4** for the continuation of an unbranched proper covering of `X ∖ A`
across `A` and **8.5** for its uniqueness up to fibre-preserving biholomorphism, with **8.9**
packaging both as the Riemann surface of an algebraic function; Girondo–González-Diez §1.2.7 for the same construction, where the charts added at the filled
points are declared holomorphic and the transition functions are checked, giving
`m_{P}(f) = mᵢ` — with **Lemma 1.80** and **Proposition 1.81** supplying existence and
uniqueness (Layer 7.4).

⚠ *Nearby false statement:* the complex structure is unique **given** that `fillMap` is
holomorphic. A compact topological surface generally carries many inequivalent complex
structures; it is the map, not the surface, that rigidifies the choice.

*Prerequisites:* Layers 7.2, 7.3, 8.1, 8.2, 8.4; Mathlib removable singularities.

#### 8.6 Analytic Riemann existence for three-point covers

The summit of the analytic track: the following four classifications agree, by explicitly
named maps, and the maps are mutually inverse up to the relevant isomorphisms.

- isomorphism classes of analytic Belyi pairs of degree `n`;
- isomorphism classes of connected topological branched covers of the sphere with branch
  values in `{0,1,∞}` and degree `n` (Layers 7.3, 7.4);
- isomorphism classes of connected `PermutationTriple n` (Layer 6.3);
- isomorphism classes of connected dessins with `n` edges (Layer 2.4).

The two nontrivial directions are 8.4 (a pair gives a triple) and 8.5 (a triple gives a
pair); that they are inverse uses 7.4's uniqueness for one composite and 6.3's for the
other. Prove that degree, the three ramification partitions, automorphism groups, and deck
groups match through all four descriptions.

**Genus reconciliation.** Apply ModularForms Layer 10B(v)'s Riemann–Hurwitz to `β`, with
the genus of `OnePoint ℂ` computed here as the worked instance of that chain on 8.1's
sphere (`g = 0`), to get the analytic genus of `X`; it equals the combinatorial genus of
Layer 0.6. Both sides are `Σ (e − 1)` over the three fibers, by 7.5 on the topological side
and by 8.3 on the analytic side, so the reconciliation is an equality of two computations
of the same sum — the milestone states it that way rather than as a coincidence of two
formulas.

⚠ *Nearby false statement:* Riemann existence in this form is a statement about covers
**with prescribed branch values**, not about arbitrary compact Riemann surfaces. It does not
say that every compact Riemann surface admits a Belyi map — that is Layer 10, and it is
false without the definability hypothesis over `ℚ̄`.

*Prerequisites:* Layers 0.6, 2.4, 6.3, 7.3–7.5, 8.4, 8.5; ModularForms Layer 10B(v).

### Layer 9: algebraic Belyi pairs and algebraization

This layer crosses from analysis to algebra. AlgebraicCurves supplies the algebraic side and
ModularForms Layer 10B the analytic cohomology; what is built here is the comparison, which
neither roadmap owns and which AlgebraicCurves excludes by name.

#### 9.1 The algebraic carrier

Over a field `k`, an **algebraic Belyi pair** is a function field `F/k` in AlgebraicCurves'
sense — `IsFunctionField k F` with exact constants `IsIntegrallyClosedIn k F` — together
with a finite separable `k`-embedding `k(t) ↪ F` such that every place of `F` over a place
of `k(t)` other than the three marked places `t = 0`, `t = 1`, `t = ∞` has ramification
index `1`.

The three marked places are AlgebraicCurves Layer 1's places of the rational function field:
the finite places of the monic irreducibles `t` and `t − 1`, and the infinite place, in that
order — the `0, 1, ∞` convention, algebraically.

**New object: `AlgebraicBelyiPair`.** Basic API:

- *Constructors and instances.* The structure; the degree `[F : k(t)]`; the three
  ramification partitions, as the multisets of `e(P′ | P)` over the places above each marked
  place (AlgebraicCurves Layer 6), each a partition of the degree by the fundamental
  identity, given that all residue degrees are `1` over an algebraically closed `k` and in
  general by `Σ e·f = n`.
- *Examples.* `(k(t), id)` of degree `1`; `(k(t), t ↦ t^n)` via `k(t) ↪ k(u)`, `t ↦ u^n`;
  the degree-`2` pair of `4t(1 − t)`, unramified over `0`.
- *Morphisms and functoriality.* Morphisms are `k(t)`-embeddings; isomorphisms are
  `k(t)`-isomorphisms; base change along `k ↪ k′` (AlgebraicCurves Layer 8's constant-field
  extension), with the caveat recorded there that constants must be re-checked after base
  change.
- *Comparison lemmas.* The morphism-of-curves form — a finite separable morphism from the
  regular projective model of `F` to `ℙ¹_k` with branch locus inside the three rational
  points — is **equivalent**, through AlgebraicCurves Layer 12's anti-equivalence, and is
  proved equivalent rather than offered as a second definition.
- *Edge cases.* Unramified over one or two of the three places; `F = k(t)` itself; `k` not
  algebraically closed, where residue degrees above a marked place can exceed `1` and the
  partitions are partitions of `n` only after weighting by `f`.
- *Downstream interfaces.* Layers 9.5, 9.6, 10, 11, 12.3.

⚠ *Nearby false statement:* "branch locus equal to `{0,1,∞}`" is the wrong condition. The
definition is containment, and the degree-`2` example above is a Belyi pair unramified over
`0`. A roadmap milestone or a database record that assumes equality excludes genuine Belyi
maps.

⚠ *Nearby false statement:* separability of `k(t) ↪ F` is automatic only in characteristic
zero. The definition carries it, and no milestone drops it; AlgebraicCurves Layer 7 records
that the different theory degenerates without it.

*Prerequisites:* AlgebraicCurves Layers 0, 1, 6, 12.

#### 9.2 The meromorphic function field

For a compact connected Riemann surface `X`, define `M(X)`: the holomorphic maps
`X → OnePoint ℂ` other than the constant `∞`, with the field structure defined chartwise off
the polar sets and extended across them by removability. Prove:

- `M(X)` is a field — the milestone is that inverses exist, which is where the identity
  theorem enters: a nonzero `f` has isolated zeros, so `1/f` is holomorphic off a finite set
  and extends;
- the constants are exactly `ℂ` (8.1's maximum principle);
- `M(OnePoint ℂ) = ℂ(t)`, by partial fractions: a meromorphic function on the sphere with
  its finitely many poles (8.3) is a rational function, subtract off the principal parts and
  apply the maximum principle to the remainder;
- a nonconstant holomorphic `β : X → OnePoint ℂ` induces a field embedding
  `ℂ(t) = M(OnePoint ℂ) ↪ M(X)` by composition.

**New object: `M(X)`.** Basic API: the field instance; the `ℂ`-algebra structure; the order
`ord_x f ∈ ℤ` at each point (from `analyticOrderAt` in a chart, negative at poles), with
`ord_x(fg) = ord_x f + ord_x g`; the divisor of `f` as a finitely supported function
(finiteness from compactness); functoriality along nonconstant holomorphic maps; and the
comparison with the pin's `MeromorphicOn` vocabulary in each chart.

⚠ *Nearby false statement:* on a non-compact surface the constants need not be `ℂ` and the
poles need not be finite in number — `M(ℂ)` is enormous. Compactness and connectedness are
both load-bearing, and every statement in this layer carries them.

*Source:* Forster **1.12** and **1.15** for meromorphic functions and their identification
with holomorphic maps to `ℙ¹`, with **1.16** for the field structure. The sphere
computation is Girondo–González-Diez **Proposition 1.26**, `M(ℙ¹) = ℂ(z)`, by subtracting
principal parts and applying Liouville — the classical partial-fraction argument; and
**Proposition 1.23** identifies `M(S)` with the non-constant-`∞` morphisms to `Ĉ`, which is
the definition this milestone uses.

*Prerequisites:* Layers 8.1–8.3; Mathlib `MeromorphicOn`, `analyticOrderAt`, `RatFunc ℂ`.

#### 9.3 The degree theorem

For a nonconstant holomorphic `β : X → OnePoint ℂ` of degree `n` on a compact connected
Riemann surface, `M(X)` is a finite separable extension of `ℂ(t)` of degree exactly `n`. The
two halves, each its own milestone:

- **Every element has degree at most `n` over `ℂ(t)`.** For `f ∈ M(X)`, form the elementary
  symmetric functions of the fiber values of `f`, counted with the multiplicities
  `ramificationIndex β x`. Off the finite set of branch values of `β` together with `β` of
  the poles of `f`, these are well-defined holomorphic functions of `t` (locally, the fiber
  is given by `n` holomorphic sections by 8.3's covering property, and a symmetric function
  of them is single-valued); they extend meromorphically across the finite exceptional set
  because they are locally bounded there after multiplying by a suitable power of a local
  coordinate; so by 9.2's sphere computation they lie in `ℂ(t)`. The resulting monic
  polynomial of degree `n` kills `f`.
- **Some element has degree exactly `n`.** ModularForms Layer 10B's Riemann–Roch chain
  produces, for any two distinct points of `X`, a meromorphic function taking different
  values at them: `ℓ(D)` grows with `deg D`, so for `D` of large degree the space `L(D)` has
  a function with a pole at one point and not the other. Applying this finitely many times
  separates the `n` points of one unbranched fiber of `β`, and the separating `f` then has
  `n` distinct conjugates, so `[ℂ(t)(f) : ℂ(t)] = n`, whence `M(X) = ℂ(t)(f)` by the first
  half.

Separability is automatic in characteristic zero.

⚠ *Nearby false statement:* the first half alone gives only "algebraic of degree at most
`n`", which does not bound `[M(X) : ℂ(t)]` without knowing `M(X)` is generated by one
element — and that is what the second half supplies. Skipping it leaves the degree
unbounded, which is the gap the phrase "the monodromy is finite, so the field is finite"
hides.

*Source:* Girondo–González-Diez **Proposition 1.89** is the first half exactly —
`[ℂ(f) : M(S)] ≤ deg f` by the elementary symmetric functions of the fibre values — and
**Corollary 1.93(iv)** upgrades it to the equality `deg f = [M(S) : ℂ(f)]`. Forster proves the
same over a general base as **8.3** (`π* : ℳ(X) → ℳ(Y)` is algebraic of degree `deg π`), by
the elementary-symmetric-function argument of **8.1** and **8.2**; his separating input is
**14.13**, which rests on the finiteness theorem **14.10**.

⚠ **The second half is where the routes diverge, and the citation is not the plan.** That
book's separating function is its **Theorem 1.90** (given `P ≠ Q` there is `φ ∈ M(S)` with
`φ(P) = 0`, `φ(Q) = ∞`), which it calls "a highly non-trivial result" and proves **by
uniformization**: the Weierstrass `℘`-function in genus one (**Corollary 2.12**) and Poincaré
series for a cocompact Fuchsian group in genus `≥ 2` (**Proposition 2.16**). This roadmap does
not have uniformization and does not want it, so the milestone above gets its separating
function from the Riemann–Roch chain instead. An implementer following the citation to its
proof would be led into chapter 2's Fuchsian machinery, which nothing else here uses.

*Prerequisites:* Layers 8.2, 8.3, 9.2; ModularForms Layer 10B (i)–(iv).

#### 9.4 Points and places

For `X` compact connected with a nonconstant `β`, build the map from points of `X` to places
of `M(X)/ℂ` (AlgebraicCurves Layer 0's `Place`), sending `x` to the valuation `ord_x` of
9.2, and prove it is a **bijection**:

- well-defined: `ord_x` is a discrete valuation trivial on `ℂ` and surjective onto `ℤ` (a
  local coordinate has order `1`);
- injective: by 9.3's separating function;
- surjective: over each place of `ℂ(t)` the analytic fiber count `Σ e = n` of 8.3 matches the
  algebraic fundamental identity `Σ e·f = n` of AlgebraicCurves Layer 6, and every residue
  degree is `1` because the residue fields contain `ℂ` and are finite over it; so the places
  above each place of `ℂ(t)` are exactly as numerous as the points of the fiber, and
  injectivity forces the map onto;
- compatible: the local ramification index of `β` at `x` (8.2) equals `e(ord_x | P)` for `P`
  the place of `ℂ(t)` below, and `ord_x f` is the algebraic order of `f` at the
  corresponding place.

Also prove that `M(X)` has exact constants `ℂ` in AlgebraicCurves' sense
(`IsIntegrallyClosedIn ℂ (M X)`), so that `M(X)` is a function field there.

⚠ *Nearby false statement:* surjectivity is not formal. It fails for non-compact `X` — the
punctured disc has places of its meromorphic field with no corresponding point — and the
proof above uses compactness twice, through 8.3's fiber count and through finiteness of the
polar divisor.

*Prerequisites:* Layers 8.2, 8.3, 9.2, 9.3; AlgebraicCurves Layers 0, 6.

#### 9.5 Algebraization of an analytic pair

For an analytic Belyi pair `(X, β)`: the pair `(M(X), ℂ(t) ↪ M(X))` is an algebraic Belyi
pair over `ℂ` — 9.4's ramification matching turns "branch values in `{0,1,∞}`" into the
three-place unramifiedness of 9.1 — and the comparison with AlgebraicCurves Layer 12's
regular projective model of `M(X)` matches everything:

- the closed points of the model correspond to the points of `X` (9.4, composed with Layer
  12's points-to-places dictionary);
- `β` corresponds to the map induced by `t`;
- analytic and algebraic ramification indices agree at each point;
- the analytic genus (ModularForms 10B) equals AlgebraicCurves' genus: the two `L(D)` spaces
  are literally the same subspace of `M(X)` under 9.4, so the two Riemann–Roch theorems
  compute the same function `ℓ`, and both read `g` off its large-degree regime;
- the divisors of `β`, of `β − 1` and of `1/β` correspond, which is the statement Layer 14
  turns into the `lambdas` assertion;
- automorphism groups correspond.

*Source:* Girondo–González-Diez **Remark 1.94** states the three-way equivalence between
compact Riemann surfaces, function fields in one variable over `ℂ`, and irreducible plane
curves, and observes that only the passage to `M(S)` is choice-free; **Proposition 1.95**
makes it an equivalence of categories, proving faithfulness and the fullness-plus-essential-
surjectivity clause. **Theorem 1.91** is the concrete form used here — for `M(S) = ℂ(f,h)`
with `F(f,h) ≡ 0`, the map `P ↦ (f(P), h(P))` is an isomorphism onto the curve's surface.
⚠ That proof invokes the separation property (Theorem 1.90), so it inherits the route caveat
recorded at Layer 9.3.

*Prerequisites:* Layers 9.1–9.4; AlgebraicCurves Layers 3, 5, 12; ModularForms Layer 10B.

#### 9.6 Analytification of an algebraic pair

For an algebraic Belyi pair `(F, ℂ(t) ↪ F)` over `ℂ`, construct an analytic pair and prove
the two constructions inverse. Route, in proof order:

1. **A primitive element.** `F = ℂ(t)[y]/(m)` for a monic irreducible `m ∈ ℂ(t)[y]` of degree
   `n` — characteristic zero, so the extension is separable and the primitive element theorem
   applies.
2. **The affine analytic model.** Let `Δ ⊂ OnePoint ℂ` be the finite set of poles of the
   coefficients of `m` together with the zeros of its discriminant, and the three marked
   points. Over `OnePoint ℂ ∖ Δ` the vanishing locus of `m` in the product with `ℂ`, with the
   first projection, is a degree-`n` covering map, by the holomorphic implicit function
   theorem applied at each of the `n` simple roots.
3. **Extension over the marked points.** By 9.1 the map is unramified over
   `Δ ∖ {0,1,∞}`, so it extends to a covering map over `OnePoint ℂ ∖ {0,1,∞}`; concretely,
   the fibers over the points of `Δ ∖ {0,1,∞}` are filled in by the removable-singularity
   argument of 8.5 with all `e = 1`.
4. **Compactification.** Layers 7.2–7.4 and 8.5 compactify to an analytic Belyi pair.
5. **Identification.** Its meromorphic field is `F` over `ℂ(t)`: both are degree-`n`
   extensions generated by `y`, and 9.3 makes the comparison a `ℂ(t)`-isomorphism.

Conclude the equivalence: `9.5` and `9.6` are mutually inverse on isomorphism classes, so
analytic Belyi pairs over `ℂ` and algebraic Belyi pairs over `ℂ` are the same objects. This
is the GAGA-sized statement of the roadmap, proved at exactly Belyi generality and no
further.

⚠ *Nearby false statement:* step 2's covering property holds only off the discriminant. A
milestone that takes the vanishing locus of `m` over all of `OnePoint ℂ ∖ {0,1,∞}` and calls
it a cover is wrong wherever the discriminant vanishes, even though 9.1 guarantees the
*final* map is unramified there — the resolution is step 3, which fills those fibers rather
than assuming them.

*Prerequisites:* Layers 7.2–7.4, 8.5, 9.3–9.5; Mathlib implicit function theorem,
`Polynomial.discriminant`, primitive element theorem.

#### 9.7 The comparison contract

The named theorem list downstream layers cite, so that nothing below reaches into the
constructions of 9.5 and 9.6: equality of degrees; of genera; of the three ramification
partitions; of the attached triple's isomorphism class; of automorphism groups; of the
divisors of `β`, `β − 1`, `1/β`; and functoriality in isomorphisms of pairs. Together with
Layer 8.6, this contract says that all six descriptions of a Belyi object over `ℂ` —
permutation triple, dessin, topological branched cover, analytic pair, algebraic pair,
function field with three marked places — carry the same invariants.

*Prerequisites:* Layers 8.6, 9.5, 9.6.

### Layer 10: Belyi's theorem

The classical statement is an equivalence, and this roadmap builds both directions
separately, because they have nothing in common: one is an explicit construction of rational
functions, the other a descent argument.

> A compact Riemann surface is the analytification of a curve over `ℚ̄` if and only if it
> admits a Belyi map.

*Source for the layer as a whole:* Köck, "Belyi's theorem revisited", **(3.3) Theorem**.
⚠ The paper also states the theorem unnumbered in its introduction; cite (3.3), not a
"Theorem 1.1".

#### 10.1 Branch values of composites

For finite separable maps in the Layer 9.1 sense, or for rational functions
`ℙ¹ → ℙ¹` over a field of characteristic zero, prove

```text
BranchValues (g ∘ f) = g '' (BranchValues f) ∪ BranchValues g ,
```

together with the ramification multiplicativity `e_{g∘f}(x) = e_g(f x) · e_f(x)` it rests
on, and the computation of `BranchValues` of a rational function as the image of the zeros
of its derivative together with the images of the poles of order `> 1`. This bookkeeping is
used at every step below and is stated once.

*Prerequisites:* Layer 9.1; AlgebraicCurves Layer 6 (ramification in towers); Layer 8.2 for
the analytic form.

#### 10.2 The degree-reduction step

For a finite set `S ⊂ ℙ¹(ℚ̄)` not contained in `ℙ¹(ℚ)`, let `α ∈ S` have maximal degree
`d > 1` over `ℚ` and let `m ∈ ℚ[x]` be its minimal polynomial. Then `m` maps `S` to a set
whose points have degree `< d`, or degree `d` but fewer of them, at the cost of adjoining the
critical values of `m` — which have degree at most `d − 1`, since they are values of `m` at
roots of `m′`, a polynomial of degree `d − 1` over `ℚ`.

State the induction with its well-founded measure explicitly. Iterating, every finite
`S ⊂ ℙ¹(ℚ̄)` is carried into `ℙ¹(ℚ)` by a composite of rational functions defined over `ℚ`,
whose branch values are also carried into `ℙ¹(ℚ)`.

*Source:* Köck, "Belyi's theorem revisited", **(3.5) Lemma**. ⚠ **His well-founded measure
is `#S` for `S` closed under conjugation over `ℚ`** — the cardinality of the set, not a field
degree — and it drops because the critical values contributed by `m` number at most
`deg m − 1`. Do not substitute "the degree of the field generated by `S`": that does not
decrease at each step, which is the defect Köck's induction exists to repair.

⚠ **Two gaps in the source that are proof obligations here, not citations.** Köck's (3.6)
applies the induction hypothesis to the image set without showing that its cardinality has
dropped (true, but unwritten), and states its hypothesis as `T ⊆ ℚ` where the previous step
supplies `Crit(p) ∪ p(S) ⊆ ℚ ∪ {∞}`. This milestone owns both: the cardinality bookkeeping
is part of the induction, and the `∞` is handled by the Möbius normalization of 10.3.

*Prerequisites:* Layer 10.1; Mathlib `minpoly`, `Polynomial.derivative`,
`Polynomial.roots`.

#### 10.3 The three-point step

For coprime positive `m, n`, the **Belyi polynomial**

```text
B_{m,n}(x) = ((m + n)^{m+n} / (m^m · n^n)) · x^m · (1 − x)^n
```

satisfies: `B_{m,n}(0) = 0`, `B_{m,n}(1) = 0`, `B_{m,n}(∞) = ∞`, and
`B_{m,n}(m/(m+n)) = 1`; its derivative vanishes exactly at `0`, `1` and `m/(m+n)`; so its
critical values lie in `{0, 1, ∞}`. Prove each of these by direct computation — the constant
is chosen precisely to make the third value `1`.

Then, by induction on `#S` for a finite `S ⊂ ℙ¹(ℚ)`: applying a Möbius transformation over
`ℚ` to send three chosen points of `S` to `0, 1, ∞` and a suitable `B_{m,n}` to absorb a
fourth, every finite `S ⊂ ℙ¹(ℚ)` is carried into `{0,1,∞}` by a composite of rational
functions over `ℚ` whose critical values lie in `{0,1,∞}`.

*Source:* Köck, **(3.6) Lemma**, with the polynomial exactly as displayed; Belyi's original
argument uses the same polynomial.

*Prerequisites:* Layer 10.1; Mathlib polynomial calculus, `Matrix.SpecialLinearGroup` for
the Möbius normalization.

#### 10.4 A curve over `ℚ̄` admits a Belyi map

For a function field `F/ℚ̄` (AlgebraicCurves' sense): choose any nonconstant `t₀ ∈ F` —
separating, automatically in characteristic zero — so that `F/ℚ̄(t₀)` is finite separable
with a finite branch set `S ⊂ ℙ¹(ℚ̄)` (AlgebraicCurves Layer 6). Compose `t₀` with the maps
of 10.2 and then 10.3 applied to `S` together with the accumulated critical values. By 10.1
the composite `β` has all its branch values in `{0,1,∞}`, and it is finite and separable as a
composite of such. So `(F, ℚ̄(β) ↪ F)` is an algebraic Belyi pair.

The degree is tracked through the composite and is not optimized; no milestone here claims a
bound on the degree of the resulting Belyi map.

*Prerequisites:* Layers 9.1, 10.1–10.3; AlgebraicCurves Layers 0, 6.

#### 10.5 Specialization

The descent engine. An algebraic Belyi pair over `ℂ` is defined over a subfield finitely
generated over `ℚ̄` — its coefficients, in the presentation `F = ℂ(t)[y]/(m)` of 9.6, are
finitely many complex numbers. Present that subfield as the function field of a `ℚ̄`-variety
and prove: all but a proper closed subset of the `ℚ̄`-points of that variety give
specializations of `m` that remain irreducible of the same degree, separable, and unramified
outside `{0,1,∞}` — the conditions being the non-vanishing of the discriminant and of the
finitely many resultants that 9.1's unramifiedness amounts to.

State it for one transcendence degree at a time and iterate; the milestone records the
finitely many polynomial conditions explicitly rather than appealing to a general spreading-out
theorem.

*Prerequisites:* Layer 9.1, 9.6; AlgebraicCurves Layer 8; Mathlib
`Polynomial.discriminant`, `Polynomial.resultant`, `Transcendental`.

#### 10.6 Finiteness in bounded degree

Over an algebraically closed field of characteristic zero — used at `ℚ̄` and at `ℂ` — there
are finitely many isomorphism classes of algebraic Belyi pairs of degree `n`. Over `ℂ` this
is Layer 9.7 plus 8.6 plus Layer 3.1: classes inject into isomorphism classes of degree-`n`
triples, of which there are finitely many. Over `ℚ̄` it follows by base change to `ℂ`
(AlgebraicCurves Layer 8 makes the base change fully faithful in characteristic zero, so the
injection on isomorphism classes is preserved).

*Source:* Girondo–González-Diez **Proposition 2.63**: for a compact `S`, a finite `B ⊂ S`
and `d ≥ 1`, there are only finitely many pairs `(S̃, f)` with `f : S̃ → S` a degree-`d`
morphism with branch-value set `B`. ⚠ Its proof for `S = ℙ¹` with three branch points is
exactly the argument available here — `Γ(2)` is generated by two elements (**Theorem 2.34**),
so there are finitely many homomorphisms to `Σ_d` — which is Layer 5.6's free generation
again; the general case there cites finite generation of the uniformizing group, which this
roadmap neither has nor needs.

*Prerequisites:* Layers 3.1, 8.6, 9.7; AlgebraicCurves Layer 8.

#### 10.7 Belyi pairs descend to `ℚ̄`

Every algebraic Belyi pair over `ℂ` is the base change of one over `ℚ̄`. Route: by 10.5 the
pair spreads out over a `ℚ̄`-variety `V` with a dense set of good specializations, each a
Belyi pair over `ℚ̄` of the same degree; by 10.6 only finitely many isomorphism classes occur
among them, so one class occurs on a dense subset; and the generic point of `V` therefore
lies in the base change of that class, which forces the original pair to be its base change.
The milestone states the density-and-pigeonhole step precisely — it is the only step that
uses both 10.5 and 10.6, and it is where the argument would fail if either were weakened.

Conclude the classification corollary: analytic Belyi pairs over `ℂ`, algebraic Belyi pairs
over `ℂ`, algebraic Belyi pairs over `ℚ̄`, connected triples, and connected dessins all
classify the same objects. The classical slogan follows in two lines: a compact Riemann
surface admits a Belyi map iff it is the analytification of a curve over `ℚ̄` — the "only if"
by this milestone applied to the pair, the "if" by 10.4 applied to the curve's function
field and 9.6 to analytify.

⚠ *Nearby false statement:* "the cover has finite monodromy, hence the curve is algebraic
over `ℚ̄`" is not an argument; it names no descent datum. The content is 10.5 and 10.6
together, and the roadmap builds them separately for that reason.

**Route decision.** Köck proves this direction differently, and his route is recorded here
so that nobody mistakes the citation for the plan: he descends through the **relative**
field of moduli `M(X, t)` of the *pair* — (3.1) and (3.2) there, feeding his (2.2) — which
is what lets him avoid his own Theorem (1.8), the one result his paper cites without proof.
This roadmap pins the specialization-and-finiteness route instead, because 10.6 is needed
anyway for Layer 11.2 and because the route keeps Layer 10 independent of Layer 11's
moduli-field theory. Both routes are complete; an implementer follows the one written here,
and `PROVENANCE.md` records the comparison.

*Prerequisites:* Layers 9.5–9.7, 10.4–10.6.

#### 10.8 Acceptance examples

- `ℙ¹` with `t^n`, defined over `ℚ`.
- A genus-one pair over `ℚ̄`: `torusTriple` realized algebraically, with its curve exhibited.
- A curve presented without a three-point map — an explicit plane quartic — carried through
  10.2, 10.3 and 10.4, with the intermediate branch sets recorded at each step.
- A pair whose field of moduli is *not* used as a field of definition without proof, with the
  pointer to Layer 11.6.

*Prerequisites:* Layers 10.4, 10.7.

### Layer 11: fields of moduli, fields of definition, and Galois orbits

#### 11.1 Galois conjugation of pairs

For `σ ∈ Gal(ℚ̄/ℚ)` and an algebraic Belyi pair `(F, ℚ̄(t) ↪ F)` over `ℚ̄`, define the
conjugate pair: the same abstract field `F` with its `ℚ̄`-algebra structure precomposed with
`σ⁻¹`, and the same distinguished `t`. This is the function-field spelling of base change
along `σ`; the marked places are preserved because `0, 1, ∞` are `ℚ`-rational.

**New object: the conjugation action.** Basic API: the action on pairs and on isomorphism
classes, with `(στ) · x = σ · (τ · x)`; functoriality in morphisms of pairs; preservation of
degree, of genus, and of the three ramification partitions (these are computed from
`e(P′ | P)`, which base change along a field automorphism preserves); and the compatibility
with composition of the underlying maps.

⚠ *Nearby false statement:* conjugation does **not** fix the isomorphism class, and does not
fix the attached triple. That it moves them is the entire subject: Layer 13.5 proves the
action is faithful.

*Prerequisites:* Layers 9.1, 9.7; Mathlib `Field.absoluteGaloisGroup`.

#### 11.2 Stabilizers and orbits

For an isomorphism class `c` of algebraic Belyi pairs over `ℚ̄`: its stabilizer in
`Gal(ℚ̄/ℚ)` is a subgroup; the orbit is finite, by 10.6, since conjugation preserves degree;
and the stabilizer is **open**, because the pair is defined over a number field (10.5's
spreading-out applied over `ℚ̄` with finitely many coefficients, or directly: the finitely
many coefficients of a presentation generate a number field `K`, and `Gal(ℚ̄/K)` fixes the
pair, hence the class).

*Prerequisites:* Layers 10.5, 10.6, 11.1; Mathlib Krull topology on
`Field.absoluteGaloisGroup`.

#### 11.3 The field of moduli

The **field of moduli** of `c` is the fixed field of its stabilizer. By 11.2 the stabilizer
is open, so the field of moduli is a number field. Prove: it is invariant under isomorphism
of pairs; `moduli(σ · c) = σ(moduli(c))`; it is contained in every field of definition
(11.5); and its degree over `ℚ` is the orbit size (11.7).

⚠ *Nearby false statement:* the field of moduli is defined by a stabilizer of an
**isomorphism class**, not of a pair. The stabilizer of a pair on the nose is usually much
smaller, and taking it would give a larger field with no descent meaning.

*Prerequisites:* Layer 11.2; Mathlib infinite Galois correspondence.

#### 11.4 Weil descent for function fields

Galois descent in the setting this roadmap needs, built here rather than cited: for a number
field `k` and a Belyi pair over `ℚ̄`, a **descent datum** relative to `k` is a family of
isomorphisms `f_σ` from the `σ`-conjugate pair to the pair, for `σ ∈ Gal(ℚ̄/k)`, satisfying
the cocycle condition `f_{στ} = f_σ ∘ σ(f_τ)` and locally constant in `σ` (it factors through
a finite quotient, which is automatic here because the pair is defined over a number field).

Prove effectiveness: a descent datum produces a model over `k` together with a base-change
isomorphism. Route: descend the field `F` as a `k`-vector space with its multiplication, by
Galois descent for the finite level at which the datum factors, then pass to the colimit;
the marked `t` descends because it is fixed by construction.

⚠ *Nearby false statement:* an arbitrary family of isomorphisms is not a descent datum. The
cocycle condition is what makes the descended object exist, and Layer 11.6 is precisely about
when the natural family fails to satisfy it.

*Source:* Weil, "The field of definition of a variety" (1956) — Köck cites it as his
Theorem 1, and Couveignes restates it as **Théorème 3 ("Critère de Weil")**, p. 22, which is
the accessible form the implementation should follow.

*Prerequisites:* Layers 9.1, 11.1; Mathlib Galois descent for vector spaces, infinite Galois
theory.

#### 11.5 Fields of definition

A **field-of-definition certificate** for `c` over a number field `k` is: an algebraic Belyi
pair over `k` (Layer 9.1 at `k`), together with an isomorphism from its base change to `ℚ̄`
onto a representative of `c`. Prove: the cyclic and Chebyshev examples of Layer 0.8 are
defined over `ℚ`; every field of definition contains the field of moduli (a `σ` fixing `k`
fixes the model, hence fixes the class); and definability over `k` is detected at finite
level, so the certificate is finite data.

⚠ *Nearby false statement:* a field of definition is not determined by the class — there can
be several, incomparable ones — and "the" field of definition is never written in this
roadmap.

*Prerequisites:* Layers 9.1, 11.3.

#### 11.6 Rigidity, and the gap between moduli and definition

The positive theorem, proved: **if the automorphism group of the pair is trivial, the field
of moduli is a field of definition.** With trivial automorphisms, the isomorphism `f_σ` from
the `σ`-conjugate is unique, so the family is automatically a cocycle and 11.4 applies.

⚠ **The descended object need not live on `ℙ¹`, even in genus zero.** Couveignes' positive
result (*Calcul et rationalité de fonctions de Belyi en genre 0*, Ann. Inst. Fourier 44
(1994), **Théorème 8**) descends a genus-zero Belyi map with automorphism group cyclic of
odd order — trivial included — to a model over the field of moduli, but the model is a map
from a **conic**, which need not have a rational point and so need not be `ℙ¹` over that
field. Layer 9.1's carrier is a function field precisely so that this case is expressible;
a milestone phrased as "a rational function over the field of moduli" would be false.

The negative statement, cited and not formalized: with nontrivial automorphisms the cocycle
condition can fail, and there are Belyi pairs whose field of moduli is not a field of
definition. For cyclic automorphism group of even order Couveignes gives the obstruction
explicitly, as a Hilbert symbol (his §8.3). The roadmap states this as a precise structural
warning with that citation and constructs no counterexample. **No milestone anywhere in this
roadmap assumes the two fields agree**, and Layer 14.2 keeps the LMFDB's stored `base_field`
distinct from the field of moduli for exactly this reason.

*Prerequisites:* Layers 11.4, 11.5.

#### 11.7 Orbit sizes and embeddings

The orbit of `c` is in bijection with `Gal(ℚ̄/ℚ)` modulo the stabilizer, so its size is the
degree of the field of moduli over `ℚ`. For a pair with a model over a number field `k`, each
embedding `k ↪ ℚ̄` produces a conjugate pair, hence (through Layer 9.7 and 8.6) an embedded
triple; two embeddings give the same class exactly when they differ by an automorphism of `k`
stabilizing the class. This is the mathematics behind the LMFDB's `base_field`, `embeddings`
and `orbit_size` columns, and Layer 14.2 cites it rather than restating it.

⚠ *Nearby false statement:* the orbit size is the degree of the field of **moduli**, not of
the stored base field. They coincide when the base field is the field of moduli and not
otherwise, and 11.6 is why that is not automatic.

*Prerequisites:* Layers 8.6, 9.7, 11.2, 11.3, 11.5.

### Layer 12: profinite powers, the fundamental group, and the branch-cycle theorem

The layer opens with two milestones of generic profinite group theory — the exponentiation
calculus that every later statement is phrased with, which depends on nothing else in this
roadmap. It comes first because 12.9 and 12.10 both consume it, so that the layer's
prerequisites run strictly backwards.

The fundamental group's carrier is field-theoretic: the Galois theory of the maximal
extension of `ℚ̄(t)` unramified outside the three marked places. Every object is then Mathlib Galois theory plus
AlgebraicCurves ramification, and no étale fundamental group of a scheme is used or built —
the comparison with a scheme-theoretic `π₁` is an explicit scope exclusion. The pin's
Galois-category machinery is available for classification statements and is cited where it
shortens one, but it is not the definition.

#### 12.1 The profinite exponentiation calculus

Owned here, in the generic profinite namespace, and exported for reuse; ProPGroups stops at
abelian pro-`p` groups and gains no dependency on this roadmap. Neither this milestone nor
the next mentions Belyi maps, and neither depends on any earlier layer.

Carrier: `ẑ := profiniteCompletion ℤ` (ProPGroups' `zHat`, cited not restated). For a
profinite group `G` and `x : G`, define `x ^ᶻ a` for `a : ẑ` as the image of `a` under the
unique continuous homomorphism `ẑ → G` sending `1` to `x` — the completion's universal
property applied to `n ↦ xⁿ`, which lands in the closed procyclic subgroup generated by `x`.

**New object: `^ᶻ`.** Basic API:

- *Constructors and instances.* The definition; the closed procyclic subgroup `⟨x⟩‾` and the
  fact that `x ^ᶻ a` lies in it.
- *Examples.* `x ^ᶻ (n : ℤ) = x ^ n`; `x ^ᶻ 0 = 1`; `1 ^ᶻ a = 1`; in `ẑ` itself, `^ᶻ` is
  multiplication.
- *Morphisms and functoriality.* **Naturality**: `f (x ^ᶻ a) = (f x) ^ᶻ a` for every
  continuous homomorphism `f`. This is the workhorse of the whole layer — it gives the
  conjugation instance `(c⁻¹ x c) ^ᶻ a = c⁻¹ (x ^ᶻ a) c` used in 12.10 and 13.3, and the
  quotient instance used in 12.2.
- *Comparison lemmas.* `x ^ᶻ (a + b) = x ^ᶻ a * x ^ᶻ b`, `(x ^ᶻ a) ^ᶻ b = x ^ᶻ (a * b)`,
  and continuity in `a` and jointly in `(x, a)`.
- *Edge cases.* `x` of finite order, where `^ᶻ` factors through `ẑ ↠ ℤ/orderOf x`; `x = 1`.
- *Downstream interfaces.* Layers 12.9, 12.10, 12.2, 13.3.

⚠ *Nearby false statement:* `x ^ᶻ a` is not "`x` to the power of an integer representative
of `a`". No such representative exists, and the operation is defined by the universal
property, never by a choice. Nor is `(xy) ^ᶻ a = x ^ᶻ a · y ^ᶻ a` — that needs `x` and `y`
to commute.

*Prerequisites:* Mathlib `ProfiniteGrp.profiniteCompletion` with `lift` and the adjunction;
ProPGroups Layers 0, 4 for `zHat` and its API.

#### 12.2 Pro-`ℓ` powers and the component comparison

On a pro-`ℓ` group the power depends only on the `ℓ`-adic component of the exponent. Using
ProPGroups Layer 4's `maximalProPQuotient ℓ zHat ≃ₜ* Multiplicative ℤ_[ℓ]`, define the
`ℤ_ℓ`-power `x ^[ℓ] u` for `u : ℤ_[ℓ]` on a pro-`ℓ` group, prove it satisfies the same laws
as 12.1, and prove the comparison

```text
x ^ᶻ a = x ^[ℓ] (component_ℓ a)
```

by factoring the powering homomorphism `ẑ → G` through the maximal pro-`ℓ` quotient of `ẑ`
— legitimate by ProPGroups Layer 3's universal property, since `G` is pro-`ℓ`.

⚠ *Nearby false statement:* the factorization uses that the *target* is pro-`ℓ`. On a
general profinite group the `ℓ`-adic component of `a` does not determine `x ^ᶻ a`, and no
milestone applies `^[ℓ]` outside a pro-`ℓ` group.

*Prerequisites:* Layer 12.1; ProPGroups Layers 3, 4.

#### 12.3 The `ℚ̄`/`ℂ` comparison of finite covers

Base change along a fixed embedding `ℚ̄ ↪ ℂ` is an equivalence from algebraic Belyi pairs
over `ℚ̄` to algebraic Belyi pairs over `ℂ`: essentially surjective by 10.7, fully faithful
by AlgebraicCurves Layer 8 (constant-field extension in characteristic zero), and
compatible with degree, ramification partitions, and automorphism groups. Composing with
9.5–9.7 and 6.3, isomorphism classes of Belyi pairs over `ℚ̄` biject with isomorphism
classes of connected triples.

⚠ *Nearby false statement:* full faithfulness is a theorem about *constant* field
extension in characteristic zero, and it is what makes the triple of a `ℚ̄`-pair
well-defined. Without it, a pair could acquire extra automorphisms over `ℂ` and the
correspondence would only be a surjection.

*Source:* Szamuely, *Galois Groups and Fundamental Groups*, **Theorem 4.6.10** — for an
extension `k ⊂ L` of algebraically closed fields of characteristic `0`, base change is an
equivalence between the finite covers étale over `U` and those étale over `U_L`, so
`π₁(U_L) ≅ π₁(U)` — with **Corollary 4.6.11**. That is this milestone at the level of
fundamental groups; the statement here is at the level of Belyi pairs, and 10.7 is what
supplies essential surjectivity in that form.

*Prerequisites:* Layers 6.3, 9.5–9.7, 10.7; AlgebraicCurves Layer 8.

#### 12.4 The geometric fundamental group

Fix an algebraic closure of `ℚ̄(t)` and let `Ω` be the compositum of all finite
subextensions unramified outside the three marked places. Prove `Ω/ℚ̄(t)` is Galois — a
conjugate of an unramified-outside-`S` extension is again one, because the marked places
are preserved — and define

```text
π₁ᵍᵉᵒ := Gal(Ω / ℚ̄(t))
```

with the Krull topology, a profinite group.

**New object: `π₁ᵍᵉᵒ`.** Basic API:

- *Constructors and instances.* The profinite group structure; the identification of its
  open normal subgroups with the finite Galois subextensions unramified outside the marked
  places.
- *Examples.* The Kummer subextensions `ℚ̄(t^{1/n})` (unramified outside `0, ∞`) and their
  analogues at `1`; these are the worked instances 12.8 and 12.10 run on.
- *Morphisms and functoriality.* Finite continuous quotients correspond to finite Belyi
  covers, via the Galois closure of the pair's function field, with the correspondence
  matching monodromy groups; through 12.3 and 6.3 this matches, at every finite level, the
  finite quotients of `FreeGroup (Fin 2)`.
- *Comparison lemmas.* Compatibility of the correspondence with composition of covers and
  with the branch-point action of Layer 2.6.
- *Edge cases.* The trivial cover; a cover unramified over some of the three places.
- *Downstream interfaces.* Layers 12.5, 12.7, 12.8, 13.1.

*Source:* the finite-level statement this layer takes to the limit is
Girondo–González-Diez **Theorem 2.71**, `Mon(x) ≅ Gal(M(S_F)/ℂ(x̃))` — the monodromy group of
a covering of `ℙ¹` is the Galois group of the corresponding function-field extension — with
**Corollary 2.70** giving the injection and **Corollary 2.72** characterizing the
normalization as the Galois closure. That is the bridge that lets this layer define `π₁ᵍᵉᵒ`
field-theoretically and still have it classify covers.

*Prerequisites:* Layers 6.3, 12.3; AlgebraicCurves Layer 6; Mathlib infinite Galois theory,
Krull topology, `IsGalois`.

#### 12.5 The comparison isomorphism

The finite-level bijections of 12.4 assemble into a continuous isomorphism

```text
π₁ᵍᵉᵒ  ≃ₜ*  profiniteCompletion (FreeGroup (Fin 2))
```

by the universal property of the completion together with the fact that a profinite group
is the limit of its finite continuous quotients (ProPGroups Layer 0). The milestone pins the
isomorphism, not merely its existence: it carries the peripheral inertia classes of 12.8 to
the classes of `P`, `T`, `C` of §Pinned conventions, in that order.

This is the profinite Riemann existence theorem, and it is the single place where the
analytic work of Layers 5–9 enters the arithmetic: the finite-level bijections it assembles
come from 12.3, which rests on 10.7, which rests on the analytic classification.

*Source:* Szamuely **Example 4.6.12(3)** states exactly this: for `k` algebraically closed
of characteristic `0`, `π₁(ℙ¹_k ∖ {0,1,∞})` is the free profinite group on two generators —
and draws the consequence this roadmap's Layer 3 makes finite, that every two-generated
finite group is the Galois group of a cover étale outside the three points. **Example
4.6.12(2)** is the Kummer case `π₁(ℙ¹_k ∖ {0,∞}) ≅ ẑ`, realized by normalizing in `xⁿ = t`,
which is the tower Layers 12.8 and 12.10 compute with.

*Prerequisites:* Layers 5.6, 12.4; ProPGroups Layers 0, 4; Mathlib
`ProfiniteGrp.profiniteCompletion` with its adjunction.

#### 12.6 Continuous outer automorphisms

The generic carrier, owned here because neither Mathlib nor any sibling roadmap has one,
and placed in the generic profinite namespace so that it is reusable.

**New object: `ContinuousOut`.** For a profinite group `G`: the group of continuous
automorphisms — `ContinuousMulEquiv G G` under composition — the inner homomorphism
`G →* ContinuousAut G`, normality of its range, and the quotient `ContinuousOut G`. Basic
API:

- *Constructors and instances.* The group structures; the quotient map; the topology on
  `ContinuousAut G` (copying the pattern the pin uses for `Aut F` in
  `CategoryTheory/Galois/Topology.lean`), with the caveat that no continuity of the
  *outer action* is claimed anywhere in this roadmap.
- *Examples.* An abelian `G`, where inner automorphisms are trivial and
  `ContinuousOut G = ContinuousAut G`; `G` with trivial centre, where `G` injects.
- *Morphisms and functoriality.* A topologically characteristic closed normal subgroup `N`
  — one preserved by every continuous automorphism — induces
  `ContinuousOut G → ContinuousOut (G ⧸ N)`. This is what makes Layer 13.1's descent to the
  pro-`ℓ` quotient legitimate, and it is stated here rather than there.
- *Comparison lemmas.* The action of `ContinuousOut G` on the set of conjugacy classes of
  `G`, and on closed subgroups up to conjugacy — the two actions every statement in 12.10
  and 13.3 is phrased against, since neither is defined on elements.
- *Edge cases.* An automorphism that is inner as an abstract automorphism but not by a
  continuous inner map — impossible for profinite `G`, and worth the lemma.
- *Downstream interfaces.* Layers 12.7, 12.10, 13.1, 13.3.

**The outer action of an extension.** For a topological group `E` with closed normal `N`,
conjugation gives `E ⧸ N → ContinuousOut N`, well-defined because conjugation by an element
of `N` is inner. Stated generically here; applied in 12.7.

*Prerequisites:* Mathlib `ContinuousMulEquiv`, `MulAut`, `QuotientGroup`; the pattern of
`CategoryTheory/Galois/Topology.lean`.

#### 12.7 The arithmetic extension and the outer action

`Ω/ℚ(t)` is Galois, and restriction gives the exact sequence

```text
1 → π₁ᵍᵉᵒ → Gal(Ω / ℚ(t)) → Gal(ℚ̄ / ℚ) → 1 ,
```

the surjectivity on the right being that `ℚ̄` and `ℚ̄(t)` are linearly disjoint over `ℚ(t)`
— `t` is transcendental — so `Gal(ℚ̄(t)/ℚ(t)) ≅ Gal(ℚ̄/ℚ)`. Applying 12.6's
extension construction and transporting along 12.5 gives the outer action

```text
ρ : Gal(ℚ̄/ℚ) →* ContinuousOut (profiniteCompletion (FreeGroup (Fin 2))) .
```

⚠ **A section does exist here, and the roadmap still works outer.** Szamuely's
**Corollary 4.7.3**: when `U` has a `k`-rational point the sequence splits and `π₁(U)` is a
semidirect product — and `ℙ¹_ℚ ∖ {0,1,∞}` has plenty of rational points, `t = 2` among them.
So the obstruction to a genuine action is not existence but **canonicity**: each rational
basepoint gives its own splitting, and none is preferred. Every statement below is phrased on
conjugacy classes or in outer form for that reason, not because a lift is unavailable.
Choosing one, and tracking what it does, is the tangential-basepoint theory this roadmap
excludes. Nor is `ρ` asserted continuous — nothing here needs it.

*Prerequisites:* Layers 12.4–12.8; Mathlib infinite Galois theory, linear disjointness.

#### 12.8 Peripheral inertia

For each marked place, the inertia subgroups of `π₁ᵍᵉᵒ` at the places of `Ω` above it, as
the compatible system of finite-level inertia subgroups.

The structural input, proved at finite level first: **in characteristic zero the inertia
group of a place in a finite Galois extension of function fields over `ℚ̄` is cyclic of
order `e`**, because wild inertia is a `p`-group for `p` the residue characteristic and
here `p = 0`; and the canonical tame character

```text
γ ↦ γ(π)/π mod 𝔪 ∈ μ_e(ℚ̄)
```

for a uniformizer `π` is an injective homomorphism independent of the choice of `π`.
Assembling over the tower: each inertia subgroup of `π₁ᵍᵉᵒ` over a marked place is
procyclic with a canonical isomorphism to `lim μ_n(ℚ̄)`, and all of them over one place are
conjugate (transitivity of the Galois action on the places above a place).

**The orientation statement.** The Kummer tower `t^{1/n}` at `0`, and its analogues
`(t−1)^{1/n}` at `1` and `(1/t)^{1/n}` at `∞`, compute the tame character explicitly, and
under 12.5 the class of the compatible inertia generator at `0`, `1`, `∞` goes to the class
of `P`, `T`, `C` respectively. Compatibility with Layer 7.1's `z ↦ z^e` local model is what
fixes which generator, and the milestone proves that compatibility rather than assuming it.

*Source:* Szamuely **Lemma 4.7.2**: for a closed point `P` with residue field `k`, the
stabilizer in `π₁(U_k̄)` of a pro-point above `P` **is** its inertia group — the statement
that makes "the inertia subgroup at a marked point" well defined up to conjugacy, and the
form this milestone assembles over the tower. The three marked points are `ℚ`-rational, so
the hypothesis holds for each.

*Prerequisites:* Layers 7.1, 12.4, 12.5; AlgebraicCurves Layers 6, 7; Mathlib inertia
subgroups, `IsPrimitiveRoot`, roots of unity.

#### 12.9 The `ẑ`-cyclotomic character

Assemble the pin's `modularCyclotomicCharacter n`, over all `n`, into the continuous

```text
χ : Gal(ℚ̄/ℚ) →* ẑˣ
```

on Layer 12.1's carrier, with the finite-level specification `σ ζ = ζ ^ χ_n(σ)` for every
`n`-th root of unity, and with `ℓ`-adic components equal to the pin's
`cyclotomicCharacter ℓ`. The compatibility across levels is the milestone; the pin supplies
each level separately.

*Source:* Szamuely **Example 4.7.4** constructs exactly this character, as
`Gal(k̄|k) → Aut(ẑ) ≅ ẑ^×` obtained from the compatible system of actions on the Kummer
layers, and names it the cyclotomic character. The pin supplies the finite levels; the
compatibility across levels is the milestone.

*Prerequisites:* Layer 12.1 (the `ẑ` carrier and its unit group); Mathlib
`modularCyclotomicCharacter`, `cyclotomicCharacter`.

#### 12.10 The branch-cycle theorem

For every `σ ∈ Gal(ℚ̄/ℚ)`, the outer action of 12.7 satisfies, on conjugacy classes,

```text
ρ(σ) [P] = [P ^ᶻ χ(σ)] ,   ρ(σ) [T] = [T ^ᶻ χ(σ)] ,   ρ(σ) [C] = [C ^ᶻ χ(σ)] ,
```

with `^ᶻ` the profinite power of Layer 12.1 and `χ` the character of 12.9.

**The convention is pinned by a computation inside the theorem, not by a citation.** The
finite-level statement is the Kummer identity: let `ζ` be a primitive `n`-th root of unity,
let `γ` be the geometric automorphism with `γ(t^{1/n}) = ζ · t^{1/n}`, and let `σ̃` be any
lift of `σ` to `Gal(Ω/ℚ(t))`. Then

```text
σ̃ γ σ̃⁻¹ = γ ^ χ_n(σ) ,
```

which the milestone proves by evaluating both sides at `t^{1/n}`: writing
`σ̃(t^{1/n}) = ζ^b t^{1/n}`, the left side sends `t^{1/n}` to `ζ^{χ_n(σ)}·t^{1/n}`, the `b`
cancelling. Every convention enters this one computation — the conjugation is
`x ↦ σ̃ x σ̃⁻¹`, the character is normalized by `σ(ζ) = ζ^{χ(σ)}`, and the tame character is
`γ(π)/π` — so a reader can check the exponent without consulting a source, and a milestone
that flipped one of them would fail here.

The general case follows by transporting along 12.8's identification and assembling over
`n`: a lift of `σ` normalizes the decomposition data at each marked place, because the three
places are `ℚ`-rational, and acts on the procyclic inertia through the tame character.

⚠ *Nearby false statement:* the exponent is `χ(σ)`, not `χ(σ)⁻¹`. Sources using the
geometric (right-action) convention for the Galois action on covers, or normalizing the
cyclotomic character by `σ(ζ) = ζ^{χ(σ)⁻¹}`, state the theorem with the inverse; the
displayed Kummer identity is what distinguishes them, and every citation records which
convention its source uses.

⚠ *Nearby false statement:* the statement is about conjugacy classes. There is no `σ` for
which `ρ(σ)` sends `P` to `P^{χ(σ)}` on the nose — that would require a canonical lift, and
Layer 13.3 obtains an actual automorphism only with conjugators, one per generator, which
need not agree.

*Source:* Szamuely **Remark 4.7.5** is the same theorem in the same generality and with the
same proof: in the situation of his **Lemma 4.7.2**, the action of `Gal(k̄|k)` on the inertia
group `I ≅ ẑ` coming from `1 → I → D → Gal(k̄|k) → 1` **is given by the cyclotomic character
in characteristic zero**, because each degree-`n` layer inside the fixed field of `I` is
generated by an `n`-th root of a local parameter, by Kummer theory. His **Example 4.7.4**
performs the computation on `ℙ¹ ∖ {0,∞}` and fixes the direction — `σ` carries the
automorphism `ⁿ√t ↦ ω_n·ⁿ√t` to `ⁿ√t ↦ σ(ω_n)·ⁿ√t` — which with `σ(ω_n) = ω_n^{χ(σ)}` is
the **non-inverted** exponent displayed above, and is where he defines the cyclotomic
character. The Kummer identity of this milestone is that computation, and the agreement of
two independent sources on the direction is why it is stated rather than cited.

Also: Stix, "On cuspidal sections of algebraic fundamental groups", ASPM 63 (2012),
**Definition 37(i)**, in §7 ("Orientation and degree") — a commutative square whose content
for an element of the decomposition group is exactly `γ x γ⁻¹ = x ^ χ(γ)`, with the
**non-inverted** exponent, matching the Kummer computation above. ⚠ Three citation traps,
each recorded in `PROVENANCE.md`: the formula is in §7 and **not** in §3.3, which only sets
up inertia and decomposition groups; "Definition 37" is numbered only in the published ASPM
version, the arXiv preprint carrying the same content as unnumbered text; and Stix's `π₁` is
the **opposite** group of the deck group, compensated by a matching inverse in his
Definition 10, so the two traps cancel and the exponent is unaffected.

The branch-cycle form is Fried, Comm. Algebra 5 (1977), **(5.2)**. ⚠ Fried states the
exponent as `−c_γ` in his normalization, and Völklein's restatement uses the opposite sign
again; the two differ from the display above by conventions, not by mathematics, which is
why the Kummer identity rather than any citation is what pins this roadmap. Classical
origin: Deligne, "Le groupe fondamental de la droite projective moins trois points",
MSRI 16 (1989).

*Prerequisites:* Layers 12.7–12.11, 12.1, 12.2.

#### 12.11 The finite branch-cycle corollary and passport invariance

For each finite quotient — each connected triple `t` with its Belyi pair over `ℚ̄`, via 12.3
— the triple of the `σ`-conjugate pair is simultaneously conjugate to

```text
(σ0 ^ χ_n(σ) , σ1 ^ χ_n(σ) , σinf ^ χ_n(σ))
```

where `n` is the exponent of the monodromy group, so that `χ_n(σ)` is a unit mod `n`.

Conclude **passport invariance**: along a Galois orbit, the degree, the three full cycle
types, the genus, the conjugacy class of the embedded monodromy group, the abstract
monodromy group, primitivity, and the geometry type are all constant. Each is a separate
small proof: cycle types because raising to a power coprime to the order preserves cycle
type; the monodromy group because a power-generated subgroup coincides with the original;
genus from cycle types by Layer 0.6; primitivity and geometry type because they are
functions of the preceding data. Therefore each Galois orbit is contained in a single
passport, completing Layer 11.2's partial statement.

⚠ The simultaneous conjugator lies in the normalizer `N_{S_n}(G)` of the monodromy group,
not in `G` — the same normalizer that Layer 1.3 identifies as the group acting on generating
triples, and Fried's (5.2) states it that way too. A milestone that placed it in `G` would
be proving something false about passports of imprimitive or small-normalizer type.

⚠ Fried's lemma, in his own words, relates **conjugacy classes** and never chosen
representatives; the same is true of the statement above, and Layer 14.2's record-level
translation is where representatives are finally chosen, by the database rather than by
mathematics.

⚠ *Nearby false statement:* the converse fails, and its failure is the reason a passport is
not a Galois orbit — the frozen `5T1-5_5_5` passport in `PROVENANCE.md` has one passport
and three orbits. Layer 14 never treats `pass_size` and `orbit_size` as the same datum.

*Prerequisites:* Layers 0.5, 0.6, 1.1, 1.4, 11.1, 12.10.

### Layer 13: the pro-`ℓ` peripheral theorem and faithfulness

#### 13.1 The pro-`ℓ` peripheral triple

Define `Δ_ℓ := maximalProPQuotient ℓ (profiniteCompletion (FreeGroup (Fin 2)))` — which is
ProPGroups Layer 4's `freeProP ℓ (Fin 2)`, cited not restated — with `P_ℓ, T_ℓ, C_ℓ` the
images of the peripheral elements and the relation `C_ℓ * T_ℓ * P_ℓ = 1`.

The outer action descends: `proPKernel ℓ` is topologically characteristic (ProPGroups Layer
3), so 12.6's functoriality gives

```text
ρ_ℓ : Gal(ℚ̄/ℚ) →* ContinuousOut (Δ_ℓ) ,
```

and 12.10's statements descend with `^ᶻ` becoming `^[ℓ]` by 12.2.

*Prerequisites:* Layers 12.6, 12.10, 12.1, 12.2; ProPGroups Layers 3, 4.

#### 13.2 Cyclotomic surjectivity

`cyclotomicCharacter ℓ` is surjective onto `ℤ_[ℓ]ˣ`, and the `ẑˣ`-valued character of 12.9
is surjective. Route: at each finite level, irreducibility of the cyclotomic polynomial over
`ℚ` gives `Gal(ℚ(ζ_{ℓ^k})/ℚ) ≅ (ZMod ℓ^k)ˣ`, so `χ_{ℓ^k}` is onto; then surjectivity of the
inverse limit follows from compactness of `Gal(ℚ̄/ℚ)` and surjectivity at each level (an
inverse limit of nonempty compact fibers is nonempty).

*Hypotheses:* the base field is `ℚ`, with `ℚ̄` the fixed `AlgebraicClosure ℚ` of
§Pinned conventions. ⚠ Over a general number field the character is **not** surjective, and
Layer 13.3's "for every `u`" would fail; the milestone states the base field explicitly.

*Prerequisites:* Layer 12.9; Mathlib cyclotomic fields over `ℚ`, `IsPrimitiveRoot.autToPow`,
compactness of Galois groups.

#### 13.3 The peripheral-power theorem

For every prime `ℓ` and every `u ∈ ℤ_[ℓ]ˣ` there exist a continuous automorphism `φ_u` of
`Δ_ℓ` and elements `c_P, c_T, c_C` with

```text
φ_u P_ℓ = c_P⁻¹ · (P_ℓ ^[ℓ] u) · c_P ,
φ_u T_ℓ = c_T⁻¹ · (T_ℓ ^[ℓ] u) · c_T ,
φ_u C_ℓ = c_C⁻¹ · (C_ℓ ^[ℓ] u) · c_C .
```

Proof: choose `σ` with `cyclotomicCharacter ℓ σ = u` (13.2); take `ρ_ℓ(σ)` (13.1) and any
representative automorphism `φ_u` of that outer class; the three conjugacy statements of
12.10, descended by 13.1, say exactly that each `φ_u(X_ℓ)` is conjugate to `X_ℓ ^[ℓ] u`, and
the conjugators are the witnesses.

⚠ **The three conjugators are independent.** Nothing asserts `c_P = c_T = c_C`; a single
conjugator would say `φ_u` is inner-times-the-power-map on the whole group, which is false.

⚠ The assignment `u ↦ φ_u` is **not** asserted to be a homomorphism, to be continuous, or to
be canonical. Each is a strictly stronger statement and each is outside this roadmap.

**The conjugation-transfer remark.** The same theorem holds for any conjugates of the three
peripheral elements, with the conjugators adjusted by 12.1's conjugation naturality. In
particular it holds for the opposite-convention third element `(P_ℓ · T_ℓ)⁻¹`, which is
`P_ℓ⁻¹ · C_ℓ · P_ℓ`: substituting and applying naturality gives the statement with `c_C`
replaced by `c_C · P_ℓ`. Consumers using that spelling need no new mathematics.

*Prerequisites:* Layers 12.2, 12.1, 12.2.

#### 13.4 The dyadic instance

The specialization to `ℓ = 2`, stated as its own named theorem with `u : ℤ_[2]ˣ` on
`Δ_2 = freeProP 2 (Fin 2)`. It is the reusable dyadic peripheral-power statement; nothing in
its statement or its proof mentions anything outside this roadmap.

*Prerequisites:* Layer 13.3.

#### 13.5 Faithfulness of the Galois action on dessins

The action of `Gal(ℚ̄/ℚ)` on isomorphism classes of algebraic Belyi pairs over `ℚ̄` —
equivalently, by 12.3 and 9.7, on isomorphism classes of dessins — is faithful.

**The route is Lenstra's, and it stays in genus zero** — no elliptic curves, no
`j`-invariant, and no dependency on the curves roadmap. Everything below happens in
`ℚ̄[x]`. In proof order:

1. Given `σ ≠ 1`, pick `α ∈ ℚ̄` with `σ(α) ≠ α`.
2. Let `p_α ∈ ℚ(α)[x]` be the antiderivative of `x·(x−1)²·(x−α)³` — degree `7`, with
   critical points exactly `0`, `1`, `α`, of multiplicities `2`, `3`, `4` respectively,
   **pairwise distinct**, which is the whole point of the choice of exponents.
3. Its critical values `p_α(0), p_α(1), p_α(α)` and `∞` lie in `ℚ̄ ∪ {∞}`, so Layers
   10.2–10.3 produce `q_α ∈ ℚ[x]` making `P_α := q_α ∘ p_α` a Belyi polynomial — a Belyi
   map from `ℙ¹` with `P_α⁻¹(∞) = {∞}`, so its dessin is a tree.
4. Conjugating, `P_α^σ = q_α ∘ p_{σ(α)}`, since `q_α` has rational coefficients.
5. Suppose the two pairs were isomorphic. Any isomorphism fixes `∞` (both maps have their
   only pole there), so it is affine, `z ↦ az + b`. The polynomial lemma below turns
   `q_α(p_α(az+b)) = q_α(p_{σ(α)}(z))` into `p_α(az+b) = c·p_{σ(α)}(z) + d`. Comparing the
   critical points of multiplicity `2, 3, 4` on the two sides forces `b = 0`, `a = 1`, and
   then `σ(α) = α` — a contradiction.

**The polynomial lemma**, owned here and stated separately because step 5 is where all the
work is: if `G₁ ∘ H₁ = G₂ ∘ H₂` with `H₁, H₂` of equal degree, then `H₂ = c·H₁ + d` for
constants `c, d`; and if in addition `H₁, H₂` are monic with `H₁(0) = H₂(0) = 0`, then
`H₁ = H₂`. Proved by comparing coefficients from the top down.

Conclude faithfulness on dessins of genus `0`, hence on dessins.

⚠ *Nearby false statement:* faithfulness does not follow from the outer action of Layer 12
being defined, nor from it being injective on any group — it is a statement about the action
on the **set of classes**, and the construction above is what produces a moved class. A
milestone that inferred it from Layer 12 alone would be proving nothing.

⚠ The three multiplicities must be **pairwise distinct**. With `x(x−1)(x−α)` in place of
`x(x−1)²(x−α)³` the critical points all have multiplicity `2`, an affine map can permute
them, and step 5 collapses.

*Source:* Girondo–González-Diez, **Theorem 4.49** (the action on Shabat polynomials is
faithful, hence on genus-zero dessins; the proof is attributed there to Lenstra) with
**Lemma 4.50** for the polynomial lemma, and **Theorem 4.48** for the statement that the
restriction to dessins of genus `g` is faithful for every `g`. ⚠ The book proves 4.48 by
treating each genus separately, so a formalization that wants all genera does not get them
from the genus-zero case for free; this milestone claims genus zero, which suffices for
faithfulness on dessins.

*Prerequisites:* Layers 9.7, 10.2, 10.3, 11.1, 12.3; Mathlib `Polynomial.derivative`,
`Polynomial.roots`, `Polynomial.comp`.

### Layer 14: LMFDB assertion semantics

This layer says what a stored record asserts, mathematically. It certifies no database value
and asserts nothing about the completeness of the database. The schema it mirrors is frozen,
with its retrieval date, in `PROVENANCE.md`; the milestones below cite that snapshot rather
than the live site.

#### 14.1 The passport record

A certificate structure whose fields mirror the frozen `belyi_passports` schema — `plabel`,
`deg`, `group`, `abc`, `a_s`/`b_s`/`c_s`, `g`, `geomtype`, `lambdas`, `pass_size`,
`num_orbits`, `maxdegbf`, `is_primitive`, `primitivization`, `aut_group`, `triples` —
together with a validity predicate tying each field to this roadmap's mathematics:

- `deg`, `lambdas`, `abc`, `g`, `geomtype` to the Layer 0.5–0.7 invariants of the passport
  (Layer 1.5);
- `group` to Layer 1.6's label semantics through PolynomialGaloisGroups;
- `pass_size` to Layer 3.4;
- `is_primitive` to Layer 1.4;
- `primitivization` to a carried block-system certificate (Layer 1.4), not to a derived
  value;
- `num_orbits`, `maxdegbf` to Layer 11's orbit data;
- `aut_group` to Layer 0.4.

Three facts from the frozen snapshot that the certificate must respect, each recorded as a
lemma rather than as a comment:

- ⚠ **`abc` is `(ord σ0, ord σ1, ord σinf)` in that order and is not sorted**, while
  `(a_s, b_s, c_s)` is `abc` **sorted ascending** — a search-only triple, never displayed.
  The certificate ties `abc` to Layer 0.7's `orderTriple` positionally and derives the
  sorted triple from it; it does not identify the two.
- **`abc[i]` is the lcm of `lambdas[i]`**, which is Layer 0.7's
  `orderOf σ = (fullCycleType σ).lcm`, so `abc` is redundant given `lambdas` and the
  certificate proves the relation rather than carrying both as independent data.
- ⚠ **`geomtype` is not a function of the genus.** The frozen records include `g = 0` with
  `geomtype = "E"` and `g = 1` with `geomtype = "H"`. The field is exactly Layer 0.7's
  `geometryType`, computed from `1/a + 1/b + 1/c` against `1`, and the certificate ties it
  there and nowhere near `g`.
- **`pass_size` is a count of isomorphism classes, not of stored rows** — it is exactly
  Layer 1.2's `passportSize`, so the certificate ties it to Layer 3.4 and to nothing about
  the database's own row count. `orbit_size` is per-map, `num_orbits` is passport-only, and
  `maxdegbf`, despite its name, is the **maximum orbit size** in the passport.

*Prerequisites:* Layers 0.4–0.7, 1.1–1.6, 3.4, 11.7.

#### 14.2 The map-orbit record, and the translation of stored triples

A certificate for a single Galois orbit, mirroring the frozen `belyi_galmaps` schema. Its
distinctive content is three theorems, not a list of fields.

**The triple translation, proved.** The stored `triples`/`triples_cyc` satisfy
`σ0 * σ1 * σinf = 1` in Mathlib's multiplication — the LMFDB composes left to right — so the
stored data is the componentwise inverse of a triple in this roadmap's convention. The
milestone states that the Layer 0.1 involution is the translation, and that it preserves
every invariant the record asserts: degree, all three full cycle types, the monodromy group,
connectedness, the automorphism group, the genus, and the passport. `PROVENANCE.md` records
the frozen records the translation was verified against, including which records are
symmetric under the swap and therefore cannot verify it.

**Base field versus field of moduli.** The stored `base_field` is a field of **definition**
(Layer 11.5), and the certificate keeps it distinct from the field of moduli (Layer 11.3).
⚠ No certificate equates them; Layer 11.6 is why.

**Embeddings and orbit size.** `embeddings` and `orbit_size` are tied to Layer 11.7. The
stored triples are indexed by the embeddings, position by position — the `i`-th triple is
the monodromy of the `i`-th complex embedding of the base field — and the number of stored
triples equals `orbit_size`. The certificate asserts that correspondence, which is Layer
11.7's embeddings-to-triples statement; the floating-point embedding values themselves are a
numerical annotation and are certified as nothing.

⚠ **The stored cycle notation omits fixed points**, and the identity is stored as `"()"`.
Recovering `lambdas` from `triples_cyc` therefore needs padding to a partition of the
degree — the database form of Layer 0.5's trap — so the certificate reads ramification data
from `lambdas`, and proves consistency with `triples_cyc` through `fullCycleType`.

Remaining fields — `curve`, `map`, `plane_model`, `plane_constant`, `curve_label`,
`friends` — are carrier-only or checkable per instance as an algebraic Belyi pair over the
stored base field (Layer 9.1). ⚠ **`curve_label` is absent, not null**, on records with no
curve friend, so the Lean field is an `Option` keyed on key-presence.

*Prerequisites:* Layers 0.1, 9.1, 11.3, 11.5, 11.7.

#### 14.3 Certification levels

Classify every field of 14.1 and 14.2 into exactly one of:

- **intrinsic theorem** — provable from the pair or the triple alone;
- **finite certificate** — checkable from supplied finite data;
- **orbit certificate** — needs supplied Galois or descent data;
- **carrier only** — the roadmap says what the value means but certifies no value;
- **outside scope** — a computational or completeness claim not proved here.

The classification is a table, one row per field, so that no consumer overreads a record.

Three cross-field statements belong here, and the layer's value is as much in the one it
**refuses** as in the two it asserts:

- `num_orbits` equals the number of map records sharing the passport label — an
  intrinsic consequence of Layer 11.2's orbit decomposition;
- `maxdegbf` equals the largest `orbit_size` among them;
- ⚠ **`Σ orbit_size = pass_size` is false in general and is not asserted.** It fails
  exactly when the per-embedding triples of a single Galois orbit are simultaneously
  conjugate to one another, so that one isomorphism class is reached by several embeddings;
  `PROVENANCE.md` records the two witnesses in the current database. The correct statement
  is the definitional one — `pass_size` counts simultaneous-conjugacy classes (Layer 1.2) —
  and a certificate that assumed the sum formula would be unsound on real records.

*Prerequisites:* Layers 14.1, 14.2.

#### 14.4 Label semantics

The grammar of passport and map labels, with the mathematical meaning of each component:
degree, the `nTj` group through Layer 1.6, and the three partitions. Prove that a valid
record's label components agree with its certified invariants. ⚠ The trailing orbit letter
is an external enumeration of the Galois orbits inside a passport — carrier-only in 14.3's
classification — and is never derived from the mathematics; the frozen `5T1-5_5_5` passport,
whose three orbits carry the letters `a`, `b`, `c` in an order fixed by the database and not
by any invariant, is the witness.

*Prerequisites:* Layers 1.6, 14.1–14.3.

#### 14.5 The frozen acceptance suite

The five frozen records of `PROVENANCE.md` — genus zero, positive genus, primitive,
imprimitive, a passport with three Galois orbits, and links to both an elliptic and a
genus-two curve — each carried through 14.1–14.4 at the highest certification level its data
admits. ⚠ The database itself is complete only through degree `6` by its own account, and
carries a handful of records its maintainers' own consistency script rejects; neither fact
affects what a certificate asserts, and both are reasons Layer 14 certifies records rather
than the database. Two of them, `6T6-6_6_3.3-a` and `3T1-3_3_3-a`, are related by `primitivization`, so
the pair also exercises Layer 1.4.

Reconcile the frozen degree-`≤ 4` table with Layer 3.5's proved classification: each of the
thirteen records matches exactly one enumerated isomorphism class, distinct records match
distinct classes, and the four imprimitive ones all primitivize to `2T1-2_2_1.1-a`. ⚠ The
reconciliation is one-directional by design: it does not claim that every enumerated class
appears in the database.

*Prerequisites:* Layers 3.5, 14.1–14.4.

## Explicit scope exclusions

None of the following is part of this roadmap, at any layer, and none is "deferred":

- numerical or symbolic algorithms for *discovering* equations of Belyi maps, and interval
  or ball certification of computed maps;
- any claim that the LMFDB's Belyi tables are complete;
- Hurwitz spaces, their compactifications, and moduli stacks of covers;
- branched covers with more than three branch points as a subject (the punctured-disc local
  theory of Layer 7.1 is general, but every global statement here has three branch points);
- the existence of a nonconstant meromorphic function on an *arbitrary* compact Riemann
  surface (every surface here arrives carrying its map; the general existence theorem is
  the Dirichlet-problem analysis this roadmap never needs);
- uniformization, the `λ`-function, and Picard-type applications;
- a general Seifert–van Kampen theorem, and topological surface classification or
  orientation theory;
- the étale fundamental group of a scheme, and the comparison of Layer 12's field-theoretic
  carrier with any scheme-theoretic one;
- tangential basepoints, canonical splittings or liftings of the outer action, continuity
  or homomorphy of `u ↦ φ_u`, and local decomposition-group actions
  `Gal(ℚ̄_p/ℚ_p) → Out`;
- Grothendieck–Teichmüller theory and anabelian reconstruction;
- the inverse Galois problem beyond the monodromy groups the constructions here realize;
- formalized counterexamples where Layer 11.6 records a cited structural warning.

## Worked examples

Two examples are threaded through every layer so that each new construction has an instance
the reader already knows: `cyclicTriple n` (the monodromy of `z ↦ zⁿ`: genus `0`,
spherical, defined over `ℚ`, trivial passport structure) and `torusTriple` (degree `4`,
genus `1`, Euclidean, regular with deck group `ℤ/4`, imprimitive, realized on an elliptic
curve). The per-layer example obligations appear inside the milestones (0.8, 2.7, 3.5, 4.4,
6.4, 10.8, 14.5); a layer introducing a new carrier without instantiating both threaded
examples on it is incomplete.

## Ordering

Two tracks, independent until Layer 12:

- **Track A (finite mathematics):** Layer 0 → Layer 1 → {Layer 2, Layer 3, Layer 4}, the
  last three mutually independent. Startable immediately; everything elaborates against the
  pin plus the two finite-supplier roadmaps.
- **Track B (geometry):** Layer 5 → Layer 6 → Layer 7 → Layer 8 → Layer 9 → Layer 10 →
  Layer 11, consuming Track A only through Layer 0's vocabulary (6.1), Layer 2 (7.6), and
  Layer 3.1 (10.6).
- **The summit:** Layer 12 consumes both tracks (6.3, 7.1, 9–11), except for its opening
  milestones 12.1 and 12.2, which are generic profinite group theory depending on nothing
  else in this roadmap and startable at any time. Layer 13 follows Layer 12. Layer 14's
  finite milestones (14.1 partially, 14.4) need only Track A; its orbit milestones need
  Layer 11.

The layer numbering is the citation order; the two-track structure is the parallelism.

## References

Primary sources, with the convention-sensitive role of each recorded; exact theorem numbers
are verified against the copies recorded in `PROVENANCE.md` before any milestone cites one.

- E. Girondo, G. González-Diez, *Introduction to Compact Riemann Surfaces and Dessins
  d'Enfants*, LMS Student Texts 79, CUP 2012 — the analytic theory at this roadmap's exact
  generality, cited at Layers 0.6, 4.1, 4.4, 4.5, 5, 6.1, 6.3, 6.5, 7.4, 8.1, 8.3, 8.5, 9.2,
  9.3, 9.5, 10.6 and 12.4. ⚠ Two of its routes are deliberately not followed: its separating
  function comes from uniformization (Layer 9.3), and its fundamental group of the
  thrice-punctured sphere comes from `Γ(2)` (Layer 5).
- S. K. Lando, A. K. Zvonkin, *Graphs on Surfaces and Their Applications*, Encyclopaedia
  Math. Sci. 141, Springer 2004 — Layers 0–4: constellations, passports, and Proposition
  1.5.3 for the genus statement of Layer 0.6 (whose proof there is topological; see that
  milestone).
- R. Cori, A. Machì, "Maps, hypermaps and their automorphisms: a survey", Exposition. Math.
  10 (1992) — the same combinatorics, surveyed.
- B. Köck, "Belyi's theorem revisited", Beiträge Algebra Geom. 45 (2004) 253–265
  (arXiv:math/0108222) — Layer 10: both directions, including the specialization descent.
- T. Szamuely, *Galois Groups and Fundamental Groups*, CSAM 117, CUP 2009 — Layer 12
  throughout: base change between algebraically closed fields (**4.6.10**, **4.6.11**), the
  free profinite `π₁` of the three-point line (**Example 4.6.12(3)**) and the Kummer case
  (**4.6.12(2)**), the arithmetic exact sequence and the outer action (**Proposition 4.7.1**,
  §4.7), its splitting at a rational point (**Corollary 4.7.3**), inertia as a stabilizer
  (**Lemma 4.7.2**), the cyclotomic character (**Example 4.7.4**), and the action on inertia
  through it in characteristic zero (**Remark 4.7.5**).
- J.-P. Serre, *Topics in Galois Theory*, 2nd ed., A K Peters 2008 — Layers 12, 13
  context; rigidity.
- J. Stix, "On cuspidal sections of algebraic fundamental groups", in *Galois–Teichmüller
  Theory and Arithmetic Geometry*, ASPM 63 (2012) 519–563 — Layers 12.8–12.10: Definition
  37(i) in §7 is the cyclotomic action on cuspidal inertia. ⚠ Cite the published version;
  the arXiv preprint leaves the statement unnumbered.
- J.-M. Couveignes, "Calcul et rationalité de fonctions de Belyi en genre 0", Ann. Inst.
  Fourier 44 (1994) — Layer 11.4 (Théorème 3, Weil's criterion) and Layer 11.6
  (Théorème 8, and the Hilbert-symbol obstruction of §8.3). Open access on Numdam.
- P. Deligne, "Le groupe fondamental de la droite projective moins trois points", in
  *Galois Groups over ℚ*, MSRI Publ. 16 (1989) — the classical origin of Layer 12.
- M. Fried, "Fields of definition of function fields and Hurwitz families — groups as
  Galois groups", Comm. Algebra 5 (1977) — the branch-cycle lemma.
- A. Weil, "The field of definition of a variety", Amer. J. Math. 78 (1956) — Layer 11.4.
- M. Musty, S. Schiavone, J. Sijsling, J. Voight, "A database of Belyi maps", ANTS XIII,
  Open Book Series 2 (2019) — Layer 14: the database semantics, and the composition
  convention of the stored triples.
- J. Sijsling, J. Voight, "On computing Belyi maps", Publ. Math. Besançon (2014) — Layer 14
  conventions; the computational literature this roadmap's exclusions point away from.
- J. D. Dixon, B. Mortimer, *Permutation Groups*, GTM 163, Springer 1996 — Layers 1.4, 3.
- O. Forster, *Lectures on Riemann Surfaces*, GTM 81 — Layers 8.1–8.3, 8.5, 9.2 and 9.3
  directly (local normal form **2.1**, degree theorem **4.24**, continuation of coverings
  **8.4** with uniqueness **8.5**, and the degree of the meromorphic extension **8.3**), and
  the cohomology chain ModularForms Layer 10B builds and Layers 8–9 consume (finiteness
  **14.10**, Riemann–Roch **16.9**, Serre duality **17.9**, Riemann–Hurwitz **17.14**).
