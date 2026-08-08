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
cover of the base built *from* a subgroup or a permutation action — is built here as the
explicit graph-cover engine of Layer 5.4, which is also what makes the figure-eight
fundamental group computable without a Seifert–van Kampen theorem.

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
Layers 3 and 4). Layers 12 and 13 consume
them. That roadmap's exponentiation stops at abelian pro-`p` groups; the **profinite
exponentiation calculus** — `x ^ᶻ a` for `a ∈ ẑ` in an arbitrary profinite group, its laws,
its `ℤ_ℓ`-specialization on pro-`ℓ` groups, and the comparison between the two — is owned
here (Layer 13.1), in the generic `TauCeti/GroupTheory/Profinite/` home, exported for reuse.
So is the continuous-outer-automorphism carrier (Layer 12.4), which no roadmap and no Mathlib
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
`γ∞`" is nullhomotopic, and `μ` turns that into the displayed relation. This display also
matches the LMFDB's knowl for a permutation triple, which states `σ_∞ σ_1 σ_0 = 1`.
⚠ The rival convention `σ0 * σ1 * σinf = 1` produces a *different* third permutation
(`(σ1·σ0)⁻¹` versus `(σ0·σ1)⁻¹`), and sources that compose permutations left-to-right display
the same formula with the other meaning. Every citation of a source convention in this
roadmap records which composition order the source uses, and Layer 14.4 proves the exact
translation to the LMFDB's stored triples once, rather than assuming it. The worked example
`z ↦ z²` in `Suggested.lean` pins the interpretation: `σ0 = σinf = (0 1)`, `σ1 = 1`.

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
representatives are chosen only where a theorem says one exists (Layer 13.5).

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
conjugating the conjugator (the two-line argument is recorded with Layer 13.5).

**Profinite powers.** Powers `x ^ᶻ a` by `a ∈ ẑ` are the canonical operation of Layer 13.1,
defined through the universal property of the profinite completion of `ℤ`; powers by
`u ∈ ℤ_ℓ` on a pro-`ℓ` group factor through the `ℓ`-adic component, and the comparison is a
theorem (Layer 13.2), not a definition. No milestone raises a profinite element to an
"integer representative" power.

**The absolute Galois group and the cyclotomic character.** `Gal(ℚ̄/ℚ)` is the pin's
`Field.absoluteGaloisGroup ℚ` with `ℚ̄ = AlgebraicClosure ℚ` fixed once. The cyclotomic
characters are the pin's `modularCyclotomicCharacter n` and `cyclotomicCharacter ℓ`, whose
defining convention is `g ζ = ζ ^ χ(g)` on `n`-th (respectively `ℓ`-power) roots of unity.
The branch-cycle exponent in Layer 12.6 is `χ(σ)` in exactly this normalization; the
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
| 12.3, 13.1 | ProPGroups Layers 3, 4 | free profinite group, maximal pro-`p` quotient, universal properties, characteristic kernel, `zHat` | `freeProfiniteGroup`, `freeProfiniteGroup.of`, `freeProfiniteGroup.lift`, `proPKernel`, `maximalProPQuotient`, `freeProP`, `zHat`, `maximalProPQuotient p zHat ≃ₜ* Multiplicative ℤ_[p]` |

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
   cyclic triple. The source for this combinatorial argument is Lando–Zvonkin (the
   nonnegativity of the genus of a constellation); `PROVENANCE.md` records the exact
   statement number.
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

*Prerequisites:* Layers 0.7, 4.1, 4.2; Mathlib `ℚ`, complex affine maps.

#### 4.5 Hyperbolic infiniteness

For `χᵒʳᵇ < 0`, `TriangleGroup a b c` is infinite: the explicit hyperbolic rotation
representation into `PSL₂(ℝ)` (generators as explicit matrices with traces
`2cos(π/a), 2cos(π/b)`, the product condition a trigonometric identity, and an element of
trace `> 2`, hence of infinite order, exhibited in the image). The milestone lists the
matrices and the identity; `PROVENANCE.md` records the source pinned for this classical
construction. Faithfulness of the representation is *not* claimed and not needed.

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

The concrete model is affine: `ℙ¹(ℂ) ∖ {0, 1, ∞}` is `ℂ ∖ {0, 1}`. The wedge-of-circles
material below is stated for a wedge of `k` circles, because the same engine at `k = 1`
classifies the punctured-disc covers of Layer 7.1; only 5.1 and 5.2 are specific to the
three-point case.

#### 5.1 The base space

`ThricePuncturedSphere := ↥({0, 1}ᶜ : Set ℂ)`, an open subspace of `ℂ`, with basepoint
`z = 1/2`. Prove: open, connected, path-connected, locally path-connected
(`LocPathConnectedSpace` instance), and semilocally simply connected in the sense of
UniversalCovers' class (open subsets of `ℂ` are locally contractible: convex balls). These
are exactly the standing hypotheses UniversalCovers' classification needs.

*Prerequisites:* Mathlib `Complex`, `LocPathConnectedSpace`; UniversalCovers milestone 2's
hypothesis classes.

#### 5.2 The peripheral loops

The concrete loops based at `1/2`, both counterclockwise as curves in `ℂ`:

```text
γ0 (t) = (1/2) · exp (2πit)          -- the circle |z| = 1/2 around 0
γ1 (t) = 1 − (1/2) · exp (2πit)      -- the circle |z − 1| = 1/2 around 1
```

with `γinf` *defined* as the fundamental-group element `([γ1] * [γ0])⁻¹`, so that the
relation

```text
[γinf] * [γ1] * [γ0] = 1
```

holds by definition — the Layer 0 display, with `μ` of Layer 5.4 sending it to the triple
relation. Prove the orientation statement that pins the geometry: `γinf` is freely homotopic
in `ThricePuncturedSphere` to the *clockwise* circle of radius `2` about `0` — equivalently,
to the loop that is counterclockwise around `∞` in the holomorphic chart `w = 1/z` of the
sphere. ⚠ The chart transition reverses the apparent orientation: a source that calls its
loop around `∞` "counterclockwise" without naming the chart is ambiguous, and every citation
here records the chart.

*Prerequisites:* Layer 5.1; Mathlib `Complex.exp`, `Path`.

#### 5.3 The wedge of `k` circles and the retraction

Build the wedge `W k` of `k` circles concretely for the case needed here and abstractly for
reuse: for `k = 2`, the subspace `C0 ∪ C1` of `ThricePuncturedSphere` where `C0`, `C1` are
the circles of radius `1/2` about `0` and `1` — they meet exactly at the basepoint `1/2`.
Prove the deformation retraction of `ThricePuncturedSphere` onto `C0 ∪ C1` (explicit
piecewise-radial formula: outside the two closed discs retract radially onto the circle
`|z − 1/2| = ...`; the milestone records the exact formula and continuity proof
obligations), and that the inclusion is a homotopy equivalence, inducing an isomorphism of
fundamental groups (the pin's fundamental-groupoid functoriality plus homotopy invariance).
The peripheral loops `γ0`, `γ1` are loops in the wedge on the nose.

*Prerequisites:* Layers 5.1, 5.2; Mathlib `ContinuousMap.Homotopy`,
`FundamentalGroupoid` functoriality.

#### 5.4 The graph-cover engine and the monodromy homomorphism

The two generic constructions the rest of the roadmap runs on.

**The monodromy homomorphism.** For a covering map `p` with `x` in the base, package the
pin's `IsCoveringMap.monodromy` as a monoid homomorphism

```text
monodromyHom : FundamentalGroup X x →* Equiv.Perm (p ⁻¹' {x}) ,
```

using `monodromy_bijective` for the `Equiv` and `monodromy_trans_apply` with the
`End`-multiplication convention for multiplicativity — a homomorphism with no `ᵐᵒᵖ`, as
recorded in §Pinned conventions. Functoriality in maps over the base, and compatibility with
`FundamentalGroup.map`.

**The engine.** For a type `S` (any cardinality, `Nonempty` where needed) and permutations
`ρ : Fin k → Equiv.Perm S`, build the covering space of the wedge `W k` with fiber `S` and
monodromy `ρ`: total space the quotient of `S × Fin k × [0,1]` gluing `(s, i, 1)` to
`(ρ i s, i', 0)` at the wedge point — concretely, `S` copies of the wedge's edge set glued
along `ρ`; the covering map; local triviality (the fiber-preserving homeomorphisms over the
two standard open sets of a wedge: the complement of the basepoint, and the union of the
open edges around it); and the computation

```text
monodromyHom (engine ρ) [γᵢ] = ρ i .
```

Prove the engine cover is connected iff the subgroup generated by the `ρ i` acts
pretransitively on nonempty `S`.

*Prerequisites:* Layer 5.3; Mathlib `IsCoveringMap`, quotient topology,
`monodromy_trans_apply`.

#### 5.5 The fundamental group is free

The homomorphism `φ : FreeGroup (Fin k) →* FundamentalGroup (W k) basepoint` sending
`of i ↦ [γᵢ]` (via `FreeGroup.lift`) is an isomorphism.

- *Surjectivity.* Every loop in the wedge is homotopic to an edge word: subdivide by
  preimages of the basepoint, and push each arc into an edge traversal (the interval
  compactness/Lebesgue argument, stated as its own lemma on paths in a wedge).
- *Injectivity.* Apply the engine to `S := FreeGroup (Fin k)` with `ρ i` = right
  multiplication by `of i`. Then `monodromyHom ∘ φ` sends a word `w` to right multiplication
  by `w` (induction on the word through the engine computation), which moves `1` unless
  `w = 1`.

Conclude `FundamentalGroup ThricePuncturedSphere (1/2) ≃* FreeGroup (Fin 2)` through 5.3,
sending the generators to `[γ0]`, `[γ1]`, with `[γinf]` the inverse of the product in the
pinned order. ⚠ No Seifert–van Kampen theorem exists at the pin and none is built here; the
engine *is* the injectivity proof, and the subdivision lemma *is* the surjectivity proof.

*Prerequisites:* Layers 5.3, 5.4; Mathlib `FreeGroup.lift`.

#### 5.6 Basepoint change

For a path from `1/2` to another basepoint, the induced isomorphism of fundamental groups
carries the peripheral elements to conjugates, and the conjugacy classes of `[γ0]`, `[γ1]`,
`[γinf]` are independent of every choice. This — not any equality of elements — is the
invariant content, and it is the topological origin of the outer form of the Galois action
in Layer 12.

*Prerequisites:* Layers 5.2, 5.5; UniversalCovers milestone 7's basepoint-change API.

### Layer 6: finite covers and their triples

#### 6.1 The monodromy triple of a finite cover

For a covering map `p : E → ThricePuncturedSphere` with finite fiber of size `n` over the
basepoint and a numbering `ν : p ⁻¹' {1/2} ≃ Fin n`, the triple

```text
σᵢ := ν.permCongr (monodromyHom p [γᵢ])   for i = 0, 1, ∞
```

is a `PermutationTriple n` — the relation is `μ` applied to 5.2's relation. Prove: `E`
path-connected iff the triple is connected (path lifting identifies the fiber's
monodromy orbits with path components); the degree is well-defined (fiber cardinality is
locally constant, hence constant, on the connected base); changing `ν` relabels the triple;
changing the basepoint conjugates it (5.6). ⚠ The empty cover has `n = 0` and is not
connected, matching Layer 0.4's convention exactly.

*Prerequisites:* Layers 0.1–0.4, 5.4, 5.6; Mathlib `IsCoveringMap`.

#### 6.2 The cover of a triple

From a triple `t` of degree `n`, the engine cover of `W 2` with `S = Fin n`,
`ρ = (t.σ0, t.σ1)`, pulled back along the retraction `r : ThricePuncturedSphere → W 2` of
5.3. Prerequisite lemma, owned here: **the pullback of a covering map is a covering map**,
with fiber and monodromy identified (`monodromyHom (r*p) = monodromyHom p ∘ FundamentalGroup.map r`).
Prove the round trip: the monodromy triple of the constructed cover is `t` (up to the
canonical numbering), using 5.5's identification.

*Prerequisites:* Layers 5.3–5.5, 6.1.

#### 6.3 The classification

The equivalences, each direction named:

- pointed connected degree-`n` covers of `ThricePuncturedSphere` up to pointed isomorphism
  ↔ connected `PermutationTriple n` (6.1, 6.2, with uniqueness from the pin's lifting
  criterion `existsUnique_continuousMap_lifts_of_range_le`);
- unpointed connected covers up to isomorphism over the base ↔ isomorphism classes of
  connected triples (UniversalCovers milestone 8's conjugacy bookkeeping);
- both compatible with the free-group description: transitive
  `FreeGroup (Fin 2)`-sets of size `n` ↔ triples, by evaluation of `σ` at the generators.

*Prerequisites:* Layers 0.2, 5.5, 6.1, 6.2; UniversalCovers milestone 8; Mathlib lifting
criterion.

#### 6.4 Deck transformations

For a connected finite cover with triple `t`: the deck group is isomorphic to
`automorphismGroup t` of Layer 0.4 — the identification goes through UniversalCovers'
`Deck` and its `(π₁)ᵐᵒᵖ` convention, and the `ᵐᵒᵖ` is absorbed exactly once, here, with the
worked degree-`4` example (`torusTriple`, deck group `ℤ/4`) proving the direction of the
composition is right.

*Prerequisites:* Layers 0.4, 6.3; UniversalCovers milestones 4, 5, 8.

#### 6.5 Regular covers

A connected finite cover is regular (its deck group acts transitively on a fiber) iff its
triple is regular in the sense of Layer 4.6 iff the corresponding subgroup of
`FreeGroup (Fin 2)` is normal. The deck group is then the monodromy group, and the
correspondence with finite quotients of the free group commutes with Layer 4.6's
triangle-group refinement.

*Prerequisites:* Layers 4.6, 6.3, 6.4; UniversalCovers milestone 8.

### Layer 7: compactification and topological branched covers

#### 7.1 Covers of the punctured disc

For the punctured disc `𝔻* := {z : ℂ | 0 < |z| < 1}`: every connected covering map onto
`𝔻*` with finite fiber of size `e` is isomorphic over `𝔻*` to
`z ↦ z^e : 𝔻*(1) → 𝔻*` precomposed with a homeomorphism (concretely: the `e`-th power map
on the punctured unit disc, whose covering property is the pin's `isCoveringMapOn_zpow`).
Route: `𝔻*` deformation-retracts onto the circle `|z| = 1/2` = the wedge `W 1`; Layer 5.5
at `k = 1` gives `π₁(𝔻*) ≃* FreeGroup (Fin 1)` (infinite cyclic); connected finite covers
correspond to finite cyclic quotients, one per degree `e`; and the `z^e` cover realizes the
degree-`e` one. This local classification is the engine of the compactification and is never
inlined into it.

*Prerequisites:* Layers 5.3–5.5 (at `k = 1`), 6.1–6.3 transported to `𝔻*`; Mathlib
`isCoveringMapOn_zpow`.

#### 7.2 Filling the punctures

For a connected finite cover `p : E → ThricePuncturedSphere` with triple `t`, build the
filled space: for each puncture `q ∈ {0, 1, ∞}` fix the standard punctured-disc
neighborhood `D_q^* ⊂ ThricePuncturedSphere`; the components of `p ⁻¹' D_q^*` biject with
the cycles of `σ_q` (7.1 applied to each component, with the component's degree the cycle
length — the bijection is through the monodromy orbit computation of 6.1); the filled space
`fill t` adjoins one point per component, topologized by declaring the filled component of
a length-`e` cycle homeomorphic to the disc via the `z^{1/e}`-chart. Prove: `fill t` is
compact, connected, Hausdorff, second countable, and locally homeomorphic to `ℂ` (a
topological surface, charted concretely; no abstract orientation theory is built — the
complex structure of Layer 8.5 carries the orientation content downstream).

*Prerequisites:* Layers 6.1, 7.1; Mathlib one-point/quotient topology tools.

#### 7.3 The branched covering map

Extend `p` to `fill p : fill t → OnePoint ℂ`, sending the filled point of a component to
its puncture (with `∞` the `OnePoint` point). Prove continuity, properness, surjectivity,
and the local model: at a filled point of cycle length `e`, in the pinned charts, `fill p`
is `w ↦ w^e`.

*Prerequisites:* Layer 7.2; Mathlib `OnePoint ℂ`.

#### 7.4 Uniqueness of the compactification

Any two extensions of a connected finite cover of `ThricePuncturedSphere` to a proper map
from a compact Hausdorff space, finite over the punctures and with the `z^e` local model,
are homeomorphic over `OnePoint ℂ` by a unique homeomorphism extending the identity of the
cover. Route: the filled points over `q` are recovered from the cover as the components of
the punctured neighborhoods (their "ends"), and properness forces the extension on them.

*Prerequisites:* Layers 7.2, 7.3.

#### 7.5 The ramification dictionary

Over each `q ∈ {0, 1, ∞}`: the fiber of `fill p` bijects with the cycles of `σ_q`; the
local degree at a point is the length of its cycle; the full cycle type at `q` is the
partition of `n` by local degrees; the branch locus is contained in the three filled fibers
and hits exactly the cycles of length `> 1`; the sum of local degrees over each fiber is
`n`. Every LMFDB `lambdas` statement flows through this dictionary.

*Prerequisites:* Layers 0.5, 7.2, 7.3.

#### 7.6 The embedded dessin

The preimage `(fill p) ⁻¹' [0, 1]` (the closed real interval inside `OnePoint ℂ`), with
black points over `0`, white points over `1`, and open edges the preimage components of the
open interval, realizes the Layer 2.2 dessin of `t`: the incidence structure matches, and
the rotation at each vertex matches the monodromy cyclic order. Stated as a bijection of
combinatorial data (edge set to `Fin n`, vertex sets to the cycle quotients); no embedded
graph theory beyond the incidence statements is developed.

*Prerequisites:* Layers 2.2, 7.2, 7.3, 7.5.

### Layer 8: Riemann surfaces and analytic Riemann existence

#### 8.1 The carriers

The Riemann-surface hypothesis stack, pinned once for the whole repository's use:
a type `X` with `[TopologicalSpace X] [ChartedSpace ℂ X] [IsManifold 𝓘(ℂ) ω X]`, plus
`[T2Space X]`, `[CompactSpace X]`, `[ConnectedSpace X]` (and second countability where a
milestone needs it) — never a bundled `RiemannSurface` structure. Holomorphic maps are
`MDifferentiable 𝓘(ℂ) 𝓘(ℂ)` (equivalently `ContMDiff` at exponent `ω` — the comparison is a
milestone). Build:

- **the Riemann sphere**: the `ChartedSpace ℂ (OnePoint ℂ)` instance with the two charts
  `z` and `1/z`, the `IsManifold 𝓘(ℂ) ω` instance (the transition on `ℂˣ` is `z ↦ 1/z`,
  analytic), compactness, and the identification of holomorphic maps into it with
  meromorphic-function data in charts;
- instances for `ℂ`, for open subsets (`ThricePuncturedSphere` as an open submanifold), and
  the restriction/corestriction API for holomorphic maps;
- the maximum-principle consequences from the pin (`MDifferentiable.isLocallyConstant` on
  compact complex manifolds): holomorphic functions on a compact connected surface are
  constant.

*Prerequisites:* Mathlib `IsManifold`, `OnePoint ℂ`, `Geometry/Manifold/Complex.lean`.

#### 8.2 The local normal form

For a nonconstant holomorphic map `f` of connected Riemann surfaces and a point `x`: charts
at `x` and `f x` in which `f` is `w ↦ w^e`, with `e ≥ 1` unique — `ramificationIndex f x`.
Route: in charts, the pin's `analyticOrderAt` gives the vanishing order; ConformalMapping
L0's local degree and holomorphic root extraction produce the normalizing chart. Prove:
`e = 1` off a discrete closed set; the identity theorem for maps of connected surfaces
(nonconstant maps have isolated fibers); multiplicativity of `e` under composition.

*Prerequisites:* Layer 8.1; ConformalMapping L0 (`TauCeti.exists_localDegree`, branch
roots); Mathlib `analyticOrderAt`, `MeromorphicNFAt`, identity theorem.

#### 8.3 Finiteness and the degree

A nonconstant holomorphic map of *compact* connected Riemann surfaces is surjective, open,
closed, and finite-to-one; the branch locus and branch values are finite; and the
degree-count function `y ↦ Σ_{x ∈ f⁻¹ y} ramificationIndex f x` is locally constant, hence
constant — the degree, with `Σ e = d` over *every* fiber. Off the branch values the map
restricts to a degree-`d` covering map (local homeomorphism + properness, packaged to the
pin's `IsCoveringMap` on the complement).

*Prerequisites:* Layers 8.1, 8.2; Mathlib properness/compactness, `IsCoveringMap`.

#### 8.4 Analytic Belyi pairs and their triples

`AnalyticBelyiPair`: `X` as in 8.1 with a nonconstant holomorphic `β : X → OnePoint ℂ`
whose branch values lie in `{0, 1, ∞}`. By 8.3 the restriction over
`ThricePuncturedSphere` is a finite covering map, so Layer 6.1 attaches a connected
isomorphism class of triples; 7.5's dictionary computes its cycle data from ramification.
Morphisms and isomorphisms of pairs (holomorphic over the sphere), automorphism groups,
and invariance statements.

*Prerequisites:* Layers 6.1, 7.5, 8.1–8.3.

#### 8.5 The complex structure on the filled cover

The filled space `fill t` of Layer 7.2 carries a unique complex structure making
`fill p` holomorphic: pull back charts on the unramified part; at a filled point the
`z^{1/e}`-chart *is* the holomorphic chart; holomorphy across the filled points is the
removable-singularity theorem in the charts; uniqueness because a continuous map of
surfaces holomorphic off a discrete set is holomorphic (removability again). This upgrades
7.2's topological surface to a compact Riemann surface and `fill p` to an analytic Belyi
pair.

*Prerequisites:* Layers 7.2, 7.3, 8.1, 8.2; Mathlib removable singularities.

#### 8.6 Analytic Riemann existence

The four classifications coincide: isomorphism classes of analytic Belyi pairs of degree
`n` ↔ connected topological branched covers as in Layer 7 ↔ isomorphism classes of
connected degree-`n` triples ↔ isomorphism classes of connected dessins with `n` edges —
with 8.4 and 8.5 as the two nontrivial directions (uniqueness of the analytic structure via
7.4 plus removability), and degree, cycle data, automorphism/deck groups matching through
every description. The genus reconciliation: ModularForms 10B(v)'s Riemann–Hurwitz applied
to `β` over the sphere (with `g(OnePoint ℂ) = 0` computed here as the worked instance of
the 10B chain on the Layer 8.1 sphere) gives the analytic genus of `X`, and it equals the
combinatorial genus of Layer 0.6 — the two `2 − 2g` computations agree because both count
`Σ (e − 1)` over the three fibers.

*Prerequisites:* Layers 0.6, 2.4, 6.3, 7.4, 8.4, 8.5; ModularForms Layer 10B (v).

### Layer 9: algebraic Belyi pairs and algebraization

#### 9.1 The algebraic carrier

Over a field `k`: an algebraic Belyi pair is a function field `F/k` in AlgebraicCurves'
sense (`IsFunctionField k F`, exact constants `IsIntegrallyClosedIn k F`) together with a
finite separable `k`-embedding `k(t) ↪ F` such that every place of `F` lying over a place
of `k(t)` other than `t = 0`, `t = 1`, `t = ∞` is unramified (AlgebraicCurves Layer 6's
`e(P′∣P)`). The three excluded places are the Layer-1 places of the rational function field
named by the monic irreducibles `t`, `t − 1` and the infinite place, in that order — the
`0, 1, ∞` convention algebraically. The morphism-of-curves form (a finite morphism to the
projective line with branch locus in `{0,1,∞}`) is the corollary through AlgebraicCurves
Layer 12, proved equivalent, not defined separately. Base examples: `t` itself; `t^n`; the
degree-`2` pair of `4t(1−t)`.

*Prerequisites:* AlgebraicCurves Layers 0, 1, 6, 12.

#### 9.2 The meromorphic function field

For a compact connected Riemann surface `X`: the field `M(X)` of meromorphic functions —
holomorphic maps `X → OnePoint ℂ` other than the constant `∞`, with field operations
defined chartwise off the polar sets and extended by removability, and the field axioms
proved. Then: `M(X)`-constants are exactly `ℂ` (8.1's maximum principle); a nonconstant
`β` embeds `ℂ(t) ↪ M(X)` by composition (`M(OnePoint ℂ) = ℂ(t)` — the rational-function
computation of the sphere, a milestone here: pole subtraction by partial fractions against
8.3's finiteness); and pullback along `β` is a field embedding.

*Prerequisites:* Layers 8.1, 8.3; Mathlib `RatFunc ℂ`.

#### 9.3 The degree theorem

For a nonconstant `β : X → OnePoint ℂ` of degree `n`: `M(X)` is a finite separable
extension of `ℂ(t)` of degree exactly `n`, and it is generated by any function separating
one unbranched fiber. The two halves:

- **Algebraicity of degree ≤ `n`.** For `f ∈ M(X)`, the elementary symmetric functions of
  the fiber values of `f` are well-defined holomorphic functions off the branch values and
  the images of poles of `f`, extend meromorphically across the finite exceptional set
  (boundedness control from the local normal form), hence lie in `ℂ(t)` by 9.2's sphere
  computation; `f` satisfies the resulting monic polynomial of degree `n`.
- **A separating function.** ModularForms 10B's Riemann–Roch chain produces, for any two
  distinct points of `X`, a meromorphic function distinguishing them (`ℓ(D)` growth plus
  the standard separation corollaries, stated here as named consequences on the Layer 8.1
  carrier); applied to an unbranched fiber it gives `f` whose minimal polynomial has degree
  exactly `n`. Separability is automatic in characteristic zero.

*Prerequisites:* Layers 8.2, 8.3, 9.2; ModularForms Layer 10B (i)–(iv).

#### 9.4 Points and places

For `X` compact connected with nonconstant `β`: every point `x` defines a place of
`M(X)/ℂ` (the vanishing-order valuation in a chart, well-defined by 8.2), giving an
injection from `X` to the places of `M(X)` (injectivity by 9.3's separation); the local
ramification index of `β` at `x` equals AlgebraicCurves' `e` of that place over the place
of `ℂ(t)` below it; and the map is onto the places — over each place of `ℂ(t)`, the
analytic fiber count `Σ e = n` of 8.3 matches the algebraic fundamental identity
`Σ e·f = n` with all residue degrees `1` (residue fields are `ℂ`), so the injection is a
bijection fiberwise. `M(X)` has exact constants `ℂ`.

*Prerequisites:* Layers 8.2, 8.3, 9.3; AlgebraicCurves Layers 0, 6 (fundamental identity).

#### 9.5 Algebraization of an analytic pair

For an analytic Belyi pair `(X, β)`: the pair `(M(X), ℂ(t) ↪ M(X))` is an algebraic Belyi
pair over `ℂ` (ramification matching of 9.4 turns branch-value containment into the
three-place condition), and the comparison with AlgebraicCurves Layer 12's regular
projective model of `M(X)` identifies `X` with the model's closed points, `β` with `t`,
analytic with algebraic ramification, the analytic genus with AlgebraicCurves' genus
(compare `ℓ(D)` on both sides through 9.4's dictionary — the function spaces are literally
the same subspaces of `M(X)` — and read off `g` from the large-degree regime on both
sides), divisors of `β`, `β − 1`, `1/β` with the corresponding algebraic divisors, and
automorphism groups.

*Prerequisites:* Layers 9.1–9.4; AlgebraicCurves Layers 3, 5, 12; ModularForms Layer 10B.

#### 9.6 Analytification of an algebraic pair

For an algebraic Belyi pair `(F, ℂ(t) ↪ F)` over `ℂ`: choose a primitive element
`F = ℂ(t)[y]/(m)`; off the (finite) discriminant-and-branch locus the vanishing set of `m`
in `ThricePuncturedSphere × ℂ` with first-projection is a finite covering map (holomorphic
implicit function theorem, stated on the concrete affine chart); Layers 7–8 compactify it
to an analytic Belyi pair; and 9.3–9.5 identify its meromorphic field with `F` over
`ℂ(t)` (both are degree-`deg m` subfields of a common splitting closure generated by `y`).
The two constructions `9.5` and `9.6` are mutually inverse up to isomorphism of pairs —
stated as the equivalence of the analytic and algebraic classifications over `ℂ`, the
GAGA-sized statement this roadmap owns at exactly Belyi generality.

*Prerequisites:* Layers 7.2–7.4, 8.5, 9.3–9.5; Mathlib implicit function theorem,
`Polynomial.discriminant`.

#### 9.7 The comparison contract

The named theorem list downstream layers cite, assembled from 9.5–9.6: equality of degrees;
of genera; of ramification data at each of `0, 1, ∞`; of the triple's isomorphism class
(algebraic pairs acquire triples through analytification, and Layer 12.2 will re-derive the
same class algebraically); of automorphism groups; and functoriality in isomorphisms of
pairs. Nothing downstream reaches into the constructions of 9.5–9.6; everything cites this
contract.

*Prerequisites:* Layers 9.5, 9.6.

### Layer 10: Belyi's theorem

Both directions, as separate constructions. The descent direction follows Köck's route;
`PROVENANCE.md` records the exact statements against the paper.

#### 10.1 Branch values of composites

For finite separable maps in the Layer 9.1 sense, the branch-value formula for a composite:
`BranchValues (g ∘ f) = g '' (BranchValues f) ∪ BranchValues g`, with the corresponding
statement for the critical values of a rational map `ℙ¹ → ℙ¹` computed from the derivative.
Applied repeatedly, this is the bookkeeping for the whole layer, and it is stated once.

*Prerequisites:* Layer 9.1; AlgebraicCurves Layer 6 (composites and ramification
multiplicativity).

#### 10.2 The degree-reduction step

For a finite set `S ⊂ ℙ¹(ℚ̄)`, composing with the minimal polynomial `m ∈ ℚ[x]` of an
element of `S` of maximal degree over `ℚ` replaces `S` by a set whose non-rational locus has
strictly smaller maximal degree, at the cost of adjoining the critical values of `m` —
which are of smaller degree. State the induction precisely (the well-founded measure is the
multiset of degrees, per Köck) and conclude: every finite `S ⊂ ℙ¹(ℚ̄)` is moved by a
composite of `ℚ`-rational maps into `ℙ¹(ℚ)`.

*Prerequisites:* Layer 10.1; Mathlib `minpoly`, `Polynomial.derivative`.

#### 10.3 The three-point step

For a finite `S ⊂ ℙ¹(ℚ)`: the Belyi polynomials
`x ↦ ((m+n)^{m+n}/(m^m n^n)) · x^m (1−x)^n` fix `{0, 1, ∞}` and send `m/(m+n)` into
`{0, 1, ∞}` while branching only over `{0, 1, ∞}` — the explicit critical-value computation
— and induction on `#S` moves all of `S` into `{0, 1, ∞}`.

*Prerequisites:* Layer 10.1; Mathlib polynomial calculus.

#### 10.4 Curves over `ℚ̄` admit Belyi maps

For a function field `F/ℚ̄` (AlgebraicCurves sense): starting from any nonconstant
`t₀ ∈ F` (a separating element exists in characteristic zero), the finite branch set of
`F/ℚ̄(t₀)` composed with 10.2 and 10.3 produces `β` with `(F, ℚ̄(t) ↪ F)` an algebraic
Belyi pair. Every step is an explicit composite; the degree is tracked, not optimized.

*Prerequisites:* Layers 9.1, 10.1–10.3; AlgebraicCurves Layers 0, 6.

#### 10.5 Specialization

The descent engine: a Belyi pair over `ℂ` is defined over a subfield finitely generated
over `ℚ̄`; presenting that subfield as the function field of a `ℚ̄`-variety, all but
finitely many `ℚ̄`-specializations preserve the degree, separability, and
unramified-outside-`{0,1,∞}` conditions (discriminant and difference loci avoidance,
stated on a chosen presentation `F = ℂ(t)[y]/(m)`). Stated for one transcendence degree at
a time and iterated.

*Prerequisites:* Layer 9.1; AlgebraicCurves Layer 8 (constant-field extension); Mathlib
`Polynomial.discriminant`, `Transcendental`.

#### 10.6 Finiteness of classes in bounded degree

Over any algebraically closed field of characteristic zero — used at `ℚ̄` and `ℂ` — there
are finitely many isomorphism classes of Belyi pairs of degree `≤ n`, because classes embed
into isomorphism classes of degree-`≤ n` triples (Layers 9.7 and 6.3 over `ℂ`; over `ℚ̄`
through 10.5's base-change compatibility), and Layer 3.1 makes the latter a finite type.

*Prerequisites:* Layers 3.1, 6.3, 9.7, 10.5.

#### 10.7 Belyi pairs descend to `ℚ̄`

Every algebraic Belyi pair over `ℂ` is the base change of one over `ℚ̄`, uniquely up to
isomorphism: specialize (10.5) and use finiteness (10.6) to see that some — hence, by the
pigeonhole over the parameter variety, a dense set of — specializations are isomorphic to
the original after base change, forcing definition over `ℚ̄`. This, with 9.5–9.6, closes
the loop: analytic pairs over `ℂ`, algebraic pairs over `ℂ`, algebraic pairs over `ℚ̄`,
triples, and dessins classify the same objects. State the classification corollary as the
layer's summit, and the classical slogan — a compact Riemann surface admits a Belyi map iff
it is definable over `ℚ̄` — as its two-line consequence.

*Prerequisites:* Layers 9.5–9.7, 10.4–10.6.

#### 10.8 Acceptance examples

`ℙ¹` with `t^n`; a genus-one pair over `ℚ̄` (the `torusTriple` realized algebraically); a
curve presented without a three-point map (an explicit plane quartic run through 10.4's
steps at small degree); and one pair whose field-of-moduli discussion is deferred to
Layer 11 with the pointer recorded.

*Prerequisites:* Layers 10.4, 10.7.

### Layer 11: fields of moduli, fields of definition, and Galois orbits

#### 11.1 Galois conjugation of pairs

For `σ ∈ Gal(ℚ̄/ℚ)` and an algebraic Belyi pair over `ℚ̄`: the conjugate pair (the same
abstract field with the `ℚ̄`-algebra structure twisted through `σ⁻¹`, and the distinguished
`t` unchanged — the function-field spelling of base change along `σ`). Prove: conjugation
is functorial, preserves degree, genus, and ramification partitions, sends isomorphic pairs
to isomorphic pairs, and fixes the three marked places (they are `ℚ`-rational). ⚠ It does
*not* fix the triple's isomorphism class in general — that failure is the Galois action on
dessins.

*Prerequisites:* Layers 9.1, 9.7; Mathlib `Field.absoluteGaloisGroup`.

#### 11.2 Stabilizers and orbits

The stabilizer of an isomorphism class is a subgroup of `Gal(ℚ̄/ℚ)`; the orbit is finite
(Layer 10.6); the orbit is contained in one passport — stated here as containment in the
degree-and-genus data, with the full passport statement finished by Layer 12.9. The
stabilizer is open: the pair descends to a number field (10.7's argument specialized), so
the stabilizer contains the open subgroup fixing that number field.

*Prerequisites:* Layers 10.6, 10.7, 11.1.

#### 11.3 The field of moduli

The fixed field of the stabilizer: a number field by 11.2. Invariance under isomorphism;
containment in every field of definition; behaviour under conjugation
(`moduli(σ · class) = σ(moduli(class))`).

*Prerequisites:* Layer 11.2; Mathlib infinite Galois correspondence.

#### 11.4 Weil descent for function fields

Galois descent along `ℚ̄/k` for a number field `k`, in the function-field setting: descent
data (isomorphisms `f_σ` from each conjugate pair back, for `σ` fixing `k`, satisfying the
cocycle condition and a continuity/finite-level condition), and effectiveness: a descent
datum produces a model over `k` with a base-change isomorphism, by Galois descent of the
field structure at finite level and passage to the colimit. This is linear-algebra Galois
descent plus multiplication, stated and proved here for function fields; no scheme descent
is invoked.

*Prerequisites:* Layers 9.1, 11.1; Mathlib Galois descent primitives
(`galois` fixed-field theory).

#### 11.5 Fields of definition

The certificate: a model over `k` (an algebraic Belyi pair over `k` in Layer 9.1's
`k`-generality) plus a base-change isomorphism to the given pair. Prove: the cyclic
examples are defined over `ℚ`; a field of definition contains the field of moduli;
finitely many conjugates detect definability at finite level.

*Prerequisites:* Layers 9.1, 11.3.

#### 11.6 Rigidity, and the gap between moduli and definition

The positive theorem, proved: if the pair has trivial automorphism group, the field of
moduli is a field of definition — the descent datum is unique, hence a cocycle, and 11.4
applies. The structural warning, stated with citation and no formalized counterexample:
with nontrivial automorphisms the cocycle condition can fail, and fields of moduli need not
be fields of definition; no milestone anywhere assumes they agree. `PROVENANCE.md` records
the cited counterexample literature.

*Prerequisites:* Layers 11.4, 11.5.

#### 11.7 Orbit sizes and embeddings

The orbit of a class bijects with `Gal(ℚ̄/ℚ) / stabilizer`, of size the degree of the field
of moduli; for a pair defined over a number field `k`, each embedding `k ↪ ℚ̄` produces a
conjugate pair and, through Layer 9.7's triples, an embedded triple — with the exact
statement of when two embeddings give the same class (they differ by an automorphism of
`k` stabilizing the class). This is the mathematics of the LMFDB's `embeddings`,
`orbit_size`, and `base_field` columns.

*Prerequisites:* Layers 11.2, 11.3, 11.5.

### Layer 12: the profinite fundamental group and the branch-cycle theorem

The carrier is field-theoretic — Galois theory of the maximal extension of `ℚ̄(t)`
unramified outside the three marked places — so that every object is Mathlib Galois theory
plus AlgebraicCurves ramification; no scheme-theoretic étale fundamental group is used or
built. The Galois-category machinery of the pin is used for classification statements, not
as the definition.

#### 12.1 The `ℚ̄`/`ℂ` comparison of finite covers

Base change along `ℚ̄ ↪ ℂ` is an equivalence from algebraic Belyi pairs over `ℚ̄` to those
over `ℂ`, compatible with degree, ramification, triples, and automorphisms — the assembly
of 10.7 (essential surjectivity) with AlgebraicCurves Layer 8 (fully faithful constant
extension in characteristic zero). Through 9.5–9.7 and 6.3, isomorphism classes of Belyi
pairs over `ℚ̄` therefore biject with isomorphism classes of connected triples, finite
level by finite level.

*Prerequisites:* Layers 6.3, 9.5–9.7, 10.7; AlgebraicCurves Layer 8.

#### 12.2 The geometric fundamental group

Inside a fixed algebraic closure of `ℚ̄(t)`: the compositum `Ω` of all finite subextensions
unramified outside the three marked places is Galois over `ℚ̄(t)` (conjugates of unramified
extensions are unramified — the marked places are stable); define
`π₁ᵍᵉᵒ := Gal(Ω/ℚ̄(t))` with the Krull topology, a profinite group. Its finite continuous
quotient data is exactly the finite Belyi covers (Galois closure bookkeeping stated), and
12.1 with Layer 6.3 gives compatible bijections at every finite level between its finite
quotients and those of `FreeGroup (Fin 2)`.

*Prerequisites:* Layer 12.1; AlgebraicCurves Layer 6; Mathlib infinite Galois theory,
Krull topology.

#### 12.3 The comparison isomorphism

The finite-level bijections of 12.2 assemble into a continuous isomorphism

```text
π₁ᵍᵉᵒ ≃ₜ* profiniteCompletion (FreeGroup (Fin 2)) ,
```

through the universal property of the completion and the profinite-groups-are-limits
machinery (ProPGroups Layer 0; the pin's `ProfiniteGrp.profiniteCompletion` adjunction).
The isomorphism is pinned, not just existence: it sends the peripheral classes below to the
classes of `P`, `T`, `C` of §Pinned conventions. This milestone is the profinite Riemann
existence theorem, and it is where the analytic input of Layers 5–9 enters arithmetic.

*Prerequisites:* Layers 5.5, 12.2; ProPGroups Layers 0, 4; Mathlib
`ProfiniteGrp.profiniteCompletion`.

#### 12.4 Continuous outer automorphisms

The generic carrier, owned here in the generic profinite namespace: for a profinite `G`,
the group of continuous automorphisms (`ContinuousMulEquiv G G` under composition), the
inner homomorphism from `G`, normality of its range, the quotient `ContinuousOut G`, the
action of `ContinuousOut G` on conjugacy classes of `G` and on closed subgroups up to
conjugacy, and functoriality: a topologically characteristic closed normal subgroup `N`
(preserved by every continuous automorphism) induces `ContinuousOut G → ContinuousOut (G/N)`.
The construction of an outer action from a topological extension: a closed normal `N ≤ E`
gives `E/N → ContinuousOut N` by conjugation.

*Prerequisites:* Mathlib `ContinuousMulEquiv`; ProPGroups Layer 3 (the characteristicity
statements it will be applied to).

#### 12.5 The arithmetic extension and the outer action

`Ω/ℚ(t)` is Galois; restriction gives the exact sequence

```text
1 → π₁ᵍᵉᵒ → Gal(Ω/ℚ(t)) → Gal(ℚ̄/ℚ) → 1
```

(the quotient identification through `Gal(ℚ̄(t)/ℚ(t)) ≅ Gal(ℚ̄/ℚ)`, `t` transcendental).
Via 12.4 this induces the outer action

```text
ρ : Gal(ℚ̄/ℚ) →* ContinuousOut π₁ᵍᵉᵒ ,
```

transported by 12.3 to `ContinuousOut` of the profinite free group. No section, no lifting,
and no continuity statement about `ρ` itself is claimed or needed.

*Prerequisites:* Layers 12.2–12.4; Mathlib infinite Galois theory.

#### 12.6 Peripheral inertia

For each marked place: the inertia subgroups of `π₁ᵍᵉᵒ` at places of `Ω` over it, as the
compatible system of finite-level inertia subgroups (Mathlib's inertia subgroups through
AlgebraicCurves' finite-level ramification). Prove, at finite level first, the
characteristic-zero structure: the inertia group of a finite Galois extension of function
fields over `ℚ̄` at a place is *cyclic* of order `e` — wild inertia is a `p`-group for `p`
the residue characteristic, which is `0` — with the canonical tame character into the roots
of unity of the residue field (`γ ↦ γ(π)/π mod 𝔪` for a uniformizer `π`, well-defined).
Assemble: each inertia subgroup of `π₁ᵍᵉᵒ` over a marked place is procyclic, isomorphic to
`lim μ_n(ℚ̄)`, all of them conjugate over one place; and the Kummer tower `t^{1/n}` (with
`(t−1)^{1/n}`, `(1/t)^{1/n}` at the other two places) computes the tame character
explicitly. The comparison 12.3 carries the class of a compatibly-oriented inertia
generator at `0`, `1`, `∞` to the class of `P`, `T`, `C` respectively — the orientation
statement that fixes all later signs, proved through the finite-level monodromy of the
`z^{1/n}`-covers matching Layer 7.1.

*Prerequisites:* Layers 7.1, 12.2, 12.3; AlgebraicCurves Layer 6; Mathlib inertia
subgroups, roots of unity.

#### 12.7 The `ẑ`-cyclotomic character

Assemble the pin's `modularCyclotomicCharacter n` over all `n` into the continuous
character `χ : Gal(ℚ̄/ℚ) →* ẑˣ` (the compatible-system milestone; `ẑ` is Layer 13.1's
carrier, consumed here), with the finite-level specs `σ ζ = ζ ^ χₙ(σ)` and the `ℓ`-adic
components equal to the pin's `cyclotomicCharacter ℓ`.

*Prerequisites:* Layer 13.1's `ẑ` carrier (the calculus sublayer is ordered before this
milestone in implementation; see §Ordering); Mathlib `modularCyclotomicCharacter`,
`cyclotomicCharacter`.

#### 12.8 The branch-cycle theorem

For every `σ ∈ Gal(ℚ̄/ℚ)`, the outer action satisfies, on conjugacy classes of
`π₁ᵍᵉᵒ ≃ F̂₂`:

```text
ρ(σ) [P] = [P ^ᶻ χ(σ)] ,   ρ(σ) [T] = [T ^ᶻ χ(σ)] ,   ρ(σ) [C] = [C ^ᶻ χ(σ)] ,
```

with `^ᶻ` the Layer 13.1 power and `χ` the Layer 12.7 character in the pinned
normalization. Proof: a lift of `σ` to `Gal(Ω/ℚ(t))` normalizes the decomposition data at
each marked place (the places are `ℚ`-rational), and conjugation acts on each finite-level
inertia through the tame character by exactly the finite-level cyclotomic action on the
Kummer tower — the `σ(t^{1/n}) = ζ_n^{χₙ(σ)}-t^{1/n}`-computation of 12.6, assembled over
`n`. ⚠ The exponent is `χ(σ)`, not its inverse, in the convention where conjugation is
`x ↦ σ̃ x σ̃⁻¹` and the tame character is `γ(π)/π`; both choices are recorded at the
statement, and the finite-level `ζ`-identity is part of the theorem so that the convention
cannot silently flip.

*Prerequisites:* Layers 12.5–12.7, 13.1 (calculus), 13.2 (conjugation-naturality of
powers).

#### 12.9 The finite branch-cycle corollary and passport invariance

For each finite quotient — each connected triple `t` with its Belyi pair over `ℚ̄` — the
`σ`-conjugate pair's triple is simultaneously conjugate to
`(σ0^{χₙ(σ)}, σ1^{χₙ(σ)}, σinf^{χₙ(σ)})` up to the relabeling class, where `n` is the
monodromy exponent. Conclude the invariance of passports under the Galois action: degree,
full cycle types (powering by a unit preserves cycle type), genus, the conjugacy class of
the monodromy subgroup, primitivity, and geometry type are constant on orbits — finishing
Layer 11.2's containment: each Galois orbit lies in one passport.

*Prerequisites:* Layers 0.5, 1.1, 11.1, 12.8.

### Layer 13: profinite powers, the pro-`ℓ` peripheral theorem, and faithfulness

#### 13.1 The profinite exponentiation calculus

Owned here, in the generic profinite namespace, exported for reuse. The carrier
`ẑ := profiniteCompletion ℤ` (ProPGroups' `zHat`, cited). For a profinite `G` and `x : G`,
the power `x ^ᶻ a` for `a : ẑ`, defined as the image of `a` under the unique continuous
homomorphism `ẑ → G` sending `1 ↦ x` (the completion's universal property applied to
`n ↦ xⁿ`, landing in the closed procyclic subgroup generated by `x`). The laws:

- agreement with integer powers along `ℤ → ẑ`;
- `x ^ᶻ (a + b) = x ^ᶻ a * x ^ᶻ b` and `(x ^ᶻ a) ^ᶻ b = x ^ᶻ (a * b)`;
- continuity in `a`, and joint continuity in `(x, a)`;
- **naturality**: `f (x ^ᶻ a) = (f x) ^ᶻ a` for continuous homomorphisms `f` — the
  workhorse — with the conjugation instance `(c⁻¹ x c) ^ᶻ a = c⁻¹ (x ^ᶻ a) c`.

*Prerequisites:* Mathlib `ProfiniteGrp.profiniteCompletion` with `lift`/adjunction;
ProPGroups Layers 0, 4 (`zHat` and its API).

#### 13.2 Pro-`ℓ` powers and the component comparison

On a pro-`ℓ` group, `x ^ᶻ a` depends only on the `ℓ`-adic component of `a`: through
ProPGroups' `maximalProPQuotient ℓ zHat ≃ₜ* Multiplicative ℤ_[ℓ]`, define the `ℤ_ℓ`-power
`x ^[ℓ] u` for `u : ℤ_[ℓ]`, prove the same laws, and prove the comparison
`x ^ᶻ a = x ^[ℓ] (component_ℓ a)` — the factorization of the powering homomorphism through
the maximal pro-`ℓ` quotient of `ẑ`, by ProPGroups Layer 3's universal property.

*Prerequisites:* Layer 13.1; ProPGroups Layers 3, 4.

#### 13.3 The pro-`ℓ` peripheral triple

`Δ_ℓ := maximalProPQuotient ℓ (profiniteCompletion (FreeGroup (Fin 2)))` — ProPGroups'
`freeProP ℓ (Fin 2)` by definition, cited not restated — with the images `P_ℓ, T_ℓ, C_ℓ`
of the peripheral elements and the relation `C_ℓ * T_ℓ * P_ℓ = 1`. The outer action
descends: `proPKernel` is topologically characteristic (ProPGroups Layer 3), so 12.4's
functoriality gives `Gal(ℚ̄/ℚ) →* ContinuousOut Δ_ℓ`, and 12.8's power-conjugacy statements
descend with `^ᶻ` becoming `^[ℓ]` by 13.2.

*Prerequisites:* Layers 12.4, 12.8, 13.1, 13.2; ProPGroups Layers 3, 4.

#### 13.4 Cyclotomic surjectivity

`cyclotomicCharacter ℓ : Gal(ℚ̄/ℚ) →* ℤ_[ℓ]ˣ` is surjective — from the pin's
irreducibility of cyclotomic polynomials over `ℚ` (so `Gal(ℚ(ζ_{ℓ^k})/ℚ) ≃ (ZMod ℓ^k)ˣ` at
every level) and a compactness/inverse-limit lifting argument; likewise the `ẑˣ`-character
of 12.7 is surjective. Stated for the fixed `ℚ̄` of §Pinned conventions.

*Prerequisites:* Layer 12.7; Mathlib cyclotomic fields over `ℚ`, `IsPrimitiveRoot.autToPow`
machinery, compactness of Galois groups.

#### 13.5 The peripheral-power theorem

For every prime `ℓ` and every `u ∈ ℤ_[ℓ]ˣ`: there exist a continuous automorphism `φ_u` of
`Δ_ℓ` and elements `c_P, c_T, c_C` with

```text
φ_u P_ℓ = c_P⁻¹ * (P_ℓ ^[ℓ] u) * c_P ,
φ_u T_ℓ = c_T⁻¹ * (T_ℓ ^[ℓ] u) * c_T ,
φ_u C_ℓ = c_C⁻¹ * (C_ℓ ^[ℓ] u) * c_C .
```

Proof: choose `σ` with `cyclotomicCharacter ℓ σ = u` (13.4), take a representative of
`ρ(σ)` descended to `Δ_ℓ` (13.3), and read off the three conjugacies from the descended
branch-cycle theorem. The choices `u ↦ φ_u` are not asserted to be a homomorphism, to be
continuous in `u`, or to be canonical; those are strictly stronger statements and are
outside this roadmap. A remark records the conjugation-transfer: the same theorem for any
conjugates of the three peripheral elements — in particular for the opposite-convention
third element `(P·T)⁻¹ = P⁻¹ · C_ℓ · P` — follows by adjusting the conjugators through
13.1's conjugation-naturality.

*Prerequisites:* Layers 13.2–13.4.

#### 13.6 The dyadic instance

The specialization `ℓ = 2`, stated as its own named theorem with `u : ℤ_[2]ˣ`, on
`Δ_2 = freeProP 2 (Fin 2)`. It is the reusable dyadic peripheral-power statement; nothing
in its statement or proof refers to anything outside this roadmap.

*Prerequisites:* Layer 13.5.

#### 13.7 Faithfulness on dessins

The action of `Gal(ℚ̄/ℚ)` on isomorphism classes of algebraic Belyi pairs over `ℚ̄`
(equivalently, by 12.1 and 9.7, on isomorphism classes of dessins) is faithful. The
construction that detects a nontrivial `σ`: pick `j ∈ ℚ̄` with `σ j ≠ j`; the elliptic
curve with `j`-invariant `j` (the pin's `WeierstrassCurve.ModelsWithJ`, bridged to its
function field by AlgebraicCurves Layer 10) admits a Belyi map (10.4); the `σ`-conjugate
pair lives on the curve with `j`-invariant `σ j`, not isomorphic to the original since the
`j`-invariant classifies over `ℚ̄` (`IsomOfJ`), so the pair classes differ. ⚠ Faithfulness
is a construction, not a consequence of the outer action being defined; no milestone infers
it from Layer 12 alone.

*Prerequisites:* Layers 10.4, 11.1, 12.1; AlgebraicCurves Layer 10; Mathlib
`WeierstrassCurve.ModelsWithJ`, `IsomOfJ`.

### Layer 14: LMFDB assertion semantics

This layer says what a stored record asserts, mathematically. It certifies no database
value and asserts nothing about completeness of the database.

#### 14.1 The passport record

A certificate structure whose fields mirror the LMFDB passport schema — degree, group
label, `abc`, the three `lambdas`, genus, geometry type, passport size, number of orbits,
primitivity flag, primitivization data, maximal degree of a base field over the passport —
together with the validity predicate tying each field to the mathematics: degree, `abc`,
`lambdas`, genus, and geometry type to Layers 0.5–0.7 invariants of a `PassportSpec`
(Layer 1.5), the group label to Layer 1.6, passport size to Layer 3.4, primitivity to
Layer 1.4, primitivization to a carried block-system certificate (Layer 1.4), and the
orbit-count and base-field-degree fields to Layer 11's orbit data. `PROVENANCE.md` freezes
the schema snapshot this mirrors, with date and source commit.

*Prerequisites:* Layers 0.5–0.7, 1.1–1.6, 3.4, 11.7.

#### 14.2 The map-orbit record

The certificate for a single Galois orbit of Belyi maps: the passport reference; the stored
permutation triples with **the proved translation between the database's composition
convention and this roadmap's** (the dictionary of §Pinned conventions, verified against
the frozen records — the componentwise-inversion involution of Layer 0.1 is the translation
in the nonidentity case); orbit size (Layer 11.7); base field versus field of moduli, kept
distinct (Layer 11.5, 11.3 — ⚠ the stored `base_field` is a field of definition, and no
certificate equates it with the field of moduli); embeddings and their induced triples
(Layer 11.7); the curve model and map as an algebraic Belyi pair over the stored base field
with the well-formedness conditions (Layer 9.1) checkable per instance; and links
(`curve_label`, `friends`, plane models) as carrier-only fields.

*Prerequisites:* Layers 0.1, 9.1, 11.3, 11.5, 11.7.

#### 14.3 Certification levels

For every field of 14.1–14.2, the classification into exactly one of: **intrinsic theorem**
(provable from the pair alone), **finite certificate** (checkable from supplied finite
data), **orbit certificate** (requires supplied Galois/descent data), **carrier only** (the
roadmap defines the meaning but certifies no value), **outside scope** (computational or
completeness claims). The classification is itself a table in this layer, one row per
field, so that no consumer overreads a record.

*Prerequisites:* Layers 14.1, 14.2.

#### 14.4 Label semantics

The grammar of passport and map labels with the mathematical interpretation of each
component (degree, `nTj` through Layer 1.6, the three partitions), the theorem that a valid
record's label components agree with its certified invariants, and the explicit statement
that the trailing orbit letter is an external enumeration (carrier-only, Layer 14.3's
classification applied).

*Prerequisites:* Layers 1.6, 14.1–14.3.

#### 14.5 The frozen acceptance records

A small diverse set of LMFDB records — one genus `0`, one of positive genus, one
imprimitive, one passport with more than one Galois orbit, one map with a linked elliptic
or genus-`2` curve — frozen byte-for-byte in `PROVENANCE.md` with retrieval dates, each
carried through 14.1–14.4 at the highest certification level its data admits, and the
degree-`≤ 4` records reconciled with Layer 3.5's proved tables.

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
- **The summit:** Layer 12 consumes both tracks (6.3, 7.1, 9–11); Layer 13's calculus
  sublayer (13.1, 13.2) is independent generic group theory that 12.7 already consumes, so
  in implementation order it precedes the rest of Layer 12; Layers 13.3–13.7 follow 12.
  Layer 14's finite milestones (14.1 partially, 14.4) need only Track A; its orbit
  milestones need Layer 11.

The layer numbering is the citation order; the two-track structure is the parallelism.

## References

Primary sources, with the convention-sensitive role of each recorded; exact theorem numbers
are verified against the copies recorded in `PROVENANCE.md` before any milestone cites one.

- E. Girondo, G. González-Diez, *Introduction to Compact Riemann Surfaces and Dessins
  d'Enfants*, LMS Student Texts 79, CUP 2012 — Layers 5–9, 11: the analytic theory at
  exactly this roadmap's generality.
- S. K. Lando, A. K. Zvonkin, *Graphs on Surfaces and Their Applications*, Encyclopaedia
  Math. Sci. 141, Springer 2004 — Layers 0–4: constellations, the genus bound, passports.
- R. Cori, A. Machì, "Maps, hypermaps and their automorphisms: a survey", Exposition. Math.
  10 (1992) — the combinatorial genus inequality of Layer 0.6.
- B. Köck, "Belyi's theorem revisited", Beiträge Algebra Geom. 45 (2004) 253–265
  (arXiv:math/0108222) — Layer 10: both directions, including the specialization descent.
- T. Szamuely, *Galois Groups and Fundamental Groups*, CSAM 117, CUP 2009 — Layers 5, 6,
  12: the field-theoretic fundamental group and Riemann existence.
- J.-P. Serre, *Topics in Galois Theory*, 2nd ed., A K Peters 2008 — Layers 12, 13
  context; rigidity.
- J. Stix, "On cuspidal sections of algebraic fundamental groups", in *Galois–Teichmüller
  Theory and Arithmetic Geometry*, ASPM 63 (2012) 519–563 — Layer 12.6–12.8: cuspidal
  inertia and the cyclotomic action, the convention source of record.
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
- S. Katok, *Fuchsian Groups*, University of Chicago Press 1992 — Layer 4.5's matrices.
- O. Forster, *Lectures on Riemann Surfaces*, GTM 81 — through ModularForms Layer 10B,
  whose chain Layers 8–9 consume.
