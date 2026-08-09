# Roadmap: pro-p and Demushkin groups

Mathlib has four things in this area:

- the category of profinite groups, with limits;
- the description of a profinite group as the limit of its finite quotients;
- the profinite completion of an abstract group, with its adjunction;
- Galois groups as profinite groups.

It has almost nothing else here. There is no pro-`p` predicate, no supernatural order, no
profinite Sylow theory, no topological Frattini theory, no free profinite group, no
presentation of a profinite group, and no Demushkin theory.

This roadmap builds the basic theory of profinite and pro-`p` groups, and then two theorems:

- the classification of Demushkin groups, with its orientation theory (Demushkin, Serre,
  Labute);
- the structure of `G_K(p)`, the Galois group of the maximal `p`-extension of a `p`-adic
  field `K`, in the free case (Shafarevich) and in the Demushkin case with cyclotomic
  orientation.

Suggested home: `TauCeti/GroupTheory/Profinite/` for Layers 0 to 3, and
`TauCeti/GroupTheory/ProP/` for Layers 4 to 11, with the Demushkin material in
`TauCeti/GroupTheory/ProP/Demushkin/`. Layers 0 to 3 are parallel to Mathlib's
`GroupTheory/` for the algebraic half and to `Topology/Algebra/` for the topological half,
which is where Mathlib keeps `OpenSubgroup`, `ClosedSubgroup` and `ClopenNhdofOne`.
Statements about limits and completions stay phrased against Mathlib's `ProfiniteGrp`.

Two subjects are outside this roadmap. The first is the Galois action on the étale
fundamental group of the thrice-punctured line. The second is the structure of the full
absolute Galois group `G_K`, as opposed to its maximal pro-`p` quotient (Jannsen–Wingberg).
Neither is a milestone here.

## How to read this roadmap

This file is the specification. `Suggested.lean` gives suggested Lean forms for the objects
and for some milestones; the markdown is definitive where the two disagree.
`PROVENANCE.md` records dated information about other projects, about Mathlib work in
progress, and about material that this roadmap adapts. Nothing in `PROVENANCE.md` is a
prerequisite of a milestone here.

Each milestone carries the prerequisites it needs, in one of four kinds, and in no other
kind:

| Code | Meaning |
|---|---|
| `M` | a declaration that exists in Mathlib at the pin below |
| `TC` | a declaration that exists in Tau Ceti |
| `L0` to `L11` | an earlier milestone of this roadmap, named in the entry |
| `LF-<layer>`, `PC-<layer>`, `QF-<layer>` | a named layer of the Local Fields, Profinite Cohomology, or Quadratic Form Invariants roadmap |

A milestone never depends on a branch, on a future Mathlib version, or on an external
repository. Cross-roadmap prerequisites are limited to the rows of the interface tables under
"Ordering and parallelism", and each of those rows names the exact declaration that the other
roadmap states.

Each new object carries an API checklist with eight entries: constructors, examples,
morphisms, functoriality, comparison lemmas, naturality, edge cases, and downstream
interfaces. Each hard theorem carries its source, the hypotheses that the source really
uses, and a nearby false statement when one exists.

Every claim below about what Mathlib contains is a claim about the repository's pin, and
`Suggested.lean` elaborates against it. `PROVENANCE.md` records how the surrounding
ecosystem stood when the audit was made.

## Standing hypotheses and conventions

- **Profinite idiom.** State theorems against the unbundled type-class stack
  `[Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [TotallyDisconnectedSpace G]`. Mathlib does the same at the pin: `ProfiniteGrp.of` takes
  exactly these, and `Mathlib/FieldTheory/Galois/Profinite.lean` and
  `Mathlib/Topology/Algebra/ClopenNhdofOne.lean` state their theorems this way. Do **not**
  add `[T2Space G]`. Total disconnectedness makes points closed, and a T1 topological group
  is T2, so the hypothesis is derivable. Layer 0 proves that instance chain once. Use the
  bundled category `ProfiniteGrp` only where a categorical construction needs it, that is
  for limits, for the completion functor, and for diagrams. Give an unbundled restatement of
  anything that a non-categorical consumer needs.
- **Pro-`p`, in quotient form.**
  `IsProP p G := ∀ U : OpenNormalSubgroup G, IsPGroup p (G ⧸ U)`. Every continuous finite
  quotient is a `p`-group. This is the definition. The description of a pro-`p` group as a
  limit of finite `p`-groups is a Layer 3 milestone, not the definition. The quotient form
  is a bare `Prop` over the unbundled stack, it is what every kernel-containment argument
  uses, and it matches Mathlib's `IsPGroup` vocabulary.
- **Order and index take supernatural values.** Supernatural numbers, also called Steinitz
  numbers, are `Supernatural := Nat.Primes → ℕ∞`. They are a Layer 1 object. The order of a
  profinite group and the index of a closed subgroup take values there. This is the
  vocabulary of Ribes–Zalesskii §2.3, and it is the only clean home for the condition "index
  prime to `p`" for a closed subgroup that is not open. The early theorems that Layers 2 and
  3 use are also stated one open subgroup at a time, with Mathlib's `Nat.card`-valued
  `Subgroup.index`, so that those layers do not wait for the Layer 1 calculus. The
  supernatural statements are the final forms.
- **Commutator convention.** Classification normal forms follow Labute:
  `(x, y) = x⁻¹y⁻¹xy` (Labute 1967, p. 106; the same as NSW III and as Koch's and
  Ribes–Zalesskii's `[g, h]`). Mathlib's `⁅x, y⁆` is `xyx⁻¹y⁻¹`, the other convention. The
  two conventions generate the same subgroups, because `(x, y) = ⁅x⁻¹, y⁻¹⁆`. Therefore
  statements about subgroups, such as the lower `p`-series and commutator subgroups, use
  Mathlib's bracket, and relator words are written out in Labute's form. The two conventions
  must never occur in one statement without saying which is which.
  ⚠ Serre's Bourbaki exposé uses the opposite convention `(x, y) = xyx⁻¹y⁻¹`, and NSW
  VII (7.5.14) uses a third. NSW remark, on printed page 419 of the second edition, that the
  shape of a normal form does not change, because the conventions agree modulo `F₃`. Cite
  the exact form of each source.
- **Topological generation, and two rank declarations.**
  `IsTopologicallyFinitelyGenerated G := ∃ s : Finset G,
  (Subgroup.closure ↑s).topologicalClosure = ⊤`. This exact shape is an interface with the
  Local Fields roadmap; see the shared table below. Rank comes in two declarations, and
  never in one overloaded declaration:
  - `topologicalGeneratorRank G : Cardinal` is the least cardinality of a subset that
    converges to `1` and generates a dense subgroup;
  - `topologicalGeneratorRankNat G h : ℕ`, for `h : IsTopologicallyFinitelyGenerated G`, is
    the natural-number value of that cardinal.

  A subset `s` converges to `1` when every open normal subgroup omits only finitely many
  elements of `s`. A finite set converges to `1`, so the two declarations agree in the
  finitely generated case; the theorem
  `topologicalGeneratorRank G = topologicalGeneratorRankNat G h` records this. In prose
  `d(G)` means whichever of the two the surrounding statement is about, and each statement
  says which. Theorems about bases, rank invariance and monotonicity are cardinal
  statements. Finite presentations, deficiency, Euler formulas, and every statement with a
  subtraction are natural-number statements, and they carry
  `IsTopologicallyFinitelyGenerated` explicitly. `ℕ∞` occurs in this roadmap only for
  supernatural exponents, and never for a generator count.
  ⚠ **Convergence is part of the definition.** Without it the invariant is a different one,
  and no theorem below can use it. A product of continuum many copies of `ℤ/p` is separable
  by the Hewitt–Marczewski–Pondiczery theorem, so a countable subset of it generates a dense
  subgroup, and yet the group needs `2^{ℵ₀}` generators that converge to `1`.
  Ribes–Zalesskii use the converging notion for the same reason.
  ⚠ **At infinite rank the Burnside identity is an identity with the discrete dual.** For
  pro-`p` `G`, `topologicalGeneratorRank G = dim_{𝔽_p} Hom_cont(G, 𝔽_p)` as cardinals.
  It is **not** `Module.rank (ZMod p) (G/Φ(G))`. The Frattini quotient is a profinite
  `𝔽_p`-vector space `𝔽_p^I`, whose algebraic dimension is `p^{|I|}` for infinite `I` by the
  Erdős–Kaplansky theorem, while the invariant we want is `|I|`. Under
  `IsTopologicallyFinitelyGenerated` the two agree, and the finite form
  `topologicalGeneratorRankNat G h = Module.finrank (ZMod p) (G/Φ(G))` is the one that every
  numerical statement uses.
- **Frattini subgroup.** For a pro-`p` group, `Φ(G)` means the intersection of the open
  normal subgroups of index `p`. That it equals the intersection of the maximal open
  subgroups, and that it equals `closure (Gᵖ[G,G])`, are Layer 3 milestones. Mathlib's
  abstract `frattini G`, the intersection of all maximal subgroups, is a different object in
  general, because a maximal subgroup of a pro-`p` group need not be open when the group is
  not finitely generated. Identify the two only where a theorem says so.
- **Presentation formalism.** A presentation of a pro-`p` group `G` is a continuous
  surjection `π : F ↠ G` from a free pro-`p` group, with `R = ker π`, which is closed. A
  presentation by relators takes `R` to be the **closed** normal closure of a set of
  relators, because the algebraic normal closure need not be closed. A presentation is
  minimal when `R ≤ Φ(F)`, equivalently when `rank F = d(G)`. The relation rank `r(G)` is
  `dim_{𝔽_p} H²(G, 𝔽_p)`. That a minimal presentation needs exactly `r(G)` relators is the
  Layer 5 presentation-independence theorem.
- **Cohomology carrier: Mathlib's, described by the Profinite Cohomology roadmap.**
  `H^n(G, M)` means Mathlib's `continuousCohomology`, which exists at the pin in every degree.
  This roadmap defines no second cohomology theory and no second cohomological operation. The
  explicit descriptions of `H⁰`, `H¹` and `H²` by cocycles, the comparison isomorphisms with
  the canonical object, the long exact and five-term sequences, restriction, inflation,
  corestriction, coinduction, Shapiro's lemma for closed subgroups, the cup products and
  cohomological dimension are declarations of the Profinite Cohomology roadmap; the contract
  table names each one. What this roadmap fixes is the coefficient object it computes with, the
  trivial `𝔽_p`-representation `trivialFp`, its cohomology `cohomFp`, and the multiplication
  pairing `fpPairing` whose bidegree-`(1,1)` cup is the cup square `cupFp`.
- **Demushkin predicate.** Labute's definition, on p. 106, says that a pro-`p` group `G` is
  Demushkin when `dim_{𝔽_p} H¹(G, 𝔽_p) < ∞`, `dim_{𝔽_p} H²(G, 𝔽_p) = 1`, and the cup product
  `H¹ × H¹ → H²` is nondegenerate. The predicate carries its pro-`p` hypothesis as a field,
  so that no downstream theorem applies to a group that satisfies only the cohomological
  clauses. `Suggested.lean` has the Lean form. Both nondegeneracy clauses are fields. If the
  cup product is proved graded-commutative in this bidegree, then the second clause becomes
  a theorem and the field is dropped; that is one change, recorded here, and not two
  coexisting conventions. Finite generation is derived from the first clause and the
  Burnside basis theorem, and is never assumed.
  ⚠ **Rank one and degenerate cases.** The definition allows `n = 1`. At `p = 2` the group
  `ℤ/2` is the unique finite Demushkin group and the unique one of rank 1. For odd `p` there
  is no Demushkin group of rank 1, because the cup pairing is then alternating, so it
  vanishes on a one-dimensional space and cannot be nondegenerate. `ℤ_p` is **not**
  Demushkin: its `H²` vanishes and it is free pro-`p` of rank 1. No theorem here uses the
  occasional convention of the literature that includes it. Labute's normal-form theorems
  need `n ≥ 2` in the case `q ≠ 2`; each classification statement below carries the
  hypothesis on `n` that it uses.
- **The `q`-invariant and the orientation.** For a Demushkin group `G`, write
  `G^{ab} := G ⧸ closure [G,G]` for the topological abelianization. Then
  `G^{ab} ≅ ℤ_p^{n-1} × ℤ_p/qℤ_p`, where `q = q(G)` is a power of `p` or is `0`. **The value
  `0` is Labute's `p^∞` convention for the torsion-free case**, and it is encoded as the
  literal `0`. The structure theory of Layer 4 gives a decomposition `ℤ_p^r × T` with `T`
  finite. That `r = n - 1`, and that `T` is cyclic, follow from the one-relator presentation
  and are proved in Layer 7. `demushkinQ` is defined from that torsion subgroup, and never
  by a condition on the image of a character.
- **The canonical character.** Serre's invariant is fixed by a prescription property. Write
  `I(χ)` for `ℤ_p` with `G` acting by `g · x = χ(g)x`, and `I(χ)/p^i` for the finite
  discrete quotient `ℤ/p^i` with the induced action. The finite discrete modules are the
  primary objects, because they are the coefficients of the cohomology carrier. For a
  continuous `χ : G → ℤ_pˣ` the following three conditions are equivalent when
  `dim H¹(G, 𝔽_p) < ∞`, and *the prescription property* means any one of them (Labute
  Prop. 6):
  1. `H¹(G, I(χ)/p^{i}) → H¹(G, I(χ)/p)` is surjective for every `i ≥ 1`;
  2. `H²(G, I(χ)/p^{i}) → H²(G, I(χ)/p^{i-1})` is injective for every `i ≥ 2`, equivalently
     the connecting map `H¹(G, I(χ)/p^{i-1}) → H²(G, I(χ)/p)` of the coefficient sequence
     `0 → I(χ)/p → I(χ)/p^{i} → I(χ)/p^{i-1} → 0` is zero;
  3. for a minimal generating tuple `g₁, …, g_n` of `G` and every `(c₁, …, c_n) ∈ ℤ_p^n`
     there is a continuous crossed homomorphism `f : G → I(χ)` with `f(g_j) = c_j`.

  Condition 3 is phrased through the inverse system of finite quotients. For every `i` there
  is a crossed homomorphism `G → I(χ)/p^i` with the prescribed values modulo `p^i`, and
  these are compatible in `i`. A crossed-homomorphism object valued in `I(χ)` itself is used
  only after Layer 7 makes the inverse limit and the continuous cocycles targets in their
  own right.
  **Theorem (Serre; Labute Thm 4).** A Demushkin group has exactly one continuous `χ` with
  the prescription property. `demushkinCharacter G` is that character, its image is a closed
  subgroup of `ℤ_pˣ`, and the image is invariant under topological isomorphism.
  Labute's nonexceptional theorem gives `Im χ = 1 + qℤ_p` when `q ≠ 2`, so the pair `(n, q)`
  is then a complete invariant. When `q = 2`, which happens only for `p = 2`, the pair is
  not complete, and the classification is by `(n, Im χ)`. The possible images are read from
  the closed subgroups of `ℤ₂ˣ = {±1} × (1 + 4ℤ₂)`, which are the three families
  `U^(f) = 1 + 2^f ℤ₂`, `V^(f) = {±1} × U^(f)`, and `U^[f] = closure ⟨-1 + 2^f⟩`; this is
  the remark after the corollary to Labute's Thm 4. Layer 7 states the families and their
  ranges. Do not substitute another parametrization of the image.
- **Free pro-`C` generality.** The class `C` is a bundled structure, and not a loose
  predicate. `FiniteGroupClass` has one field of data, a predicate
  `mem : ∀ (H : Type) [Group H] [Finite H], Prop`, and five fields of proof:
  - invariance under group isomorphism;
  - membership of the trivial group;
  - closure under subgroups;
  - closure under quotients;
  - closure under extensions.

  Closure under finite products follows from the trivial group and from extensions, so it is
  a theorem and not a field. The field `mem` quantifies over `Type`. A finite group in a
  higher universe is handled through `Shrink`, which the isomorphism-invariance field makes
  harmless; this is the resizing policy, and it is used everywhere. The `C`-kernel
  `proCKernel C G`, the completion `proCCompletion`, and the free object `freeProC C X` are
  defined from this structure. The instantiation `finiteGroupClassP p` is the class of
  finite `p`-groups, and `freeProC (finiteGroupClassP p) X ≅ freeProP p X` is a theorem.
  Layers 4 to 9 use free objects on finite generating sets, which is what presentations,
  Demushkin theory and the arithmetic instances need. The free pro-`C` group on a profinite
  space, with a basis that converges to `1`, is Layer 10.
- **Naming.** `IsProP`, `IsTopologicallyFinitelyGenerated`, `ConvergesToOne`,
  `topologicalGeneratorRank`, `topologicalGeneratorRankNat`, `proPKernel`,
  `maximalProPQuotient`, `absoluteGaloisGroupProP`, `proPFrattini`,
  `IsFiniteContinuousQuotient`, `Supernatural`, `profiniteOrder`, `profiniteIndex`,
  `IsProPSylow`, `FiniteGroupClass`, `pLowerCentralSeries`, `freeProfiniteGroup`,
  `presentedProfiniteGroup`, `freeProC`, `freeProP`, `presentedProP`, `topAbelianization`,
  `trivialFp`, `cohomFp`, `fpPairing`, `cupFp`, `HasPrescriptionProperty`,
  `LocalFieldInputs`, `localFieldInputs`, `IsDemushkin`, `demushkinRank`, `demushkinQ`,
  `demushkinCharacter`, `gradedPiece`, `gradedBracket`, `gradedPow`, `completedGroupAlgebra`,
  `labuteE`, `demushkinD0`, `d0A`, `d0S`, `d0Y`, `standardD0Orientation`.
  `pLowerCentralSeries` is 0-based, which matches Mathlib's
  `lowerCentralSeries`; Labute's `F_i` is index `i - 1`. `Suggested.lean` fixes the Lean
  forms. The maximal pro-`p` quotient has exactly one name: `proPKernel p G` is the
  subgroup, and `maximalProPQuotient p G := G ⧸ proPKernel p G` is the quotient. In prose
  `G(p)` means `maximalProPQuotient p G`, and nothing else.

## What Mathlib gives us (consume)

At the pin:

- **The `ProfiniteGrp` category.** `Mathlib/Topology/Algebra/Category/ProfiniteGrp/Basic.lean`
  has the category, `of`, `ofFiniteGrp`, `ofClosedSubgroup`, `pi`, and limits through
  `limitCone` and `limitConeIsLimit`. `Limits.lean` has the statement that a profinite group
  is the limit of its finite quotients, through `toLimit_surjective`, `toLimit_injective`
  and `continuousMulEquivLimittoFiniteQuotientFunctor`. `Completion.lean` has the profinite
  completion over `FiniteIndexNormalSubgroup G`, the unit `eta`, `denseRange`,
  `mono_eta_iff_residuallyFinite`, `lift`, and the adjunction
  `profiniteCompletion ⊣ forget₂`. The free profinite group is `profiniteCompletion` applied
  to a free group.
- **Subgroups.** `Mathlib/Topology/Algebra/OpenSubgroup.lean` has `OpenSubgroup`,
  `OpenNormalSubgroup`, clopenness, and `Finite (G ⧸ U)` on a compact group.
  `Mathlib/Topology/Algebra/Group/ClosedSubgroup.lean` has `ClosedSubgroup`,
  `normalCore_isClosed`, and the statement that a closed subgroup of finite index is open.
  `Mathlib/Topology/Algebra/ClopenNhdofOne.lean` has
  `exist_openNormalSubgroup_sub_open_nhds_of_one`, the neighbourhood basis of open normal
  subgroups, and `closedSubgroup_eq_sInf_open`, which says that a closed subgroup of a
  profinite group is the intersection of the open subgroups above it.
  `Mathlib/Topology/Algebra/Group/Basic.lean` has `Subgroup.topologicalClosure` and its
  normality.
- **Galois groups.** `Mathlib/FieldTheory/KrullTopology.lean` has `krullTopology`, the T2
  property and total separatedness. `Mathlib/FieldTheory/Galois/Profinite.lean` and
  `Infinite.lean` have `Gal(K/k)` as a limit of finite Galois groups, with the
  `CompactSpace` instance. These instances make every Galois group a consumer of this
  roadmap.
- **Finite group theory.** In `Mathlib/GroupTheory/`:
  - `Sylow.lean`, the levelwise input to Layer 2;
  - `PGroup.lean`, with `IsPGroup` and `IsPGroup.card_modEq_card_fixedPoints`;
  - `Frattini.lean`, with `frattini`, `frattini_nongenerating` and `frattini_nilpotent`;
  - `Nilpotent.lean`, with `lowerCentralSeries`, the naming model for the lower `p`-series;
  - `Index.lean`, with `Subgroup.index` and `relindex`, both `Nat.card`-valued;
  - `Finiteness.lean` and `Rank.lean`, with `Group.FG` and `Group.rank`;
  - `PresentedGroup.lean`, `FreeGroup/` and `ResiduallyFinite.lean`.
- **Locally constant functions.** `Mathlib/Topology/LocallyConstant/Algebra.lean` has
  `LocallyConstant X M` with its `AddCommGroup` and `Module` instances, and
  `IsLocallyConstant.iff_continuous` relates local constancy to continuity for a discrete
  codomain. These carry the cochain groups of Layer 5.
- **`p`-adics.** `Mathlib/NumberTheory/Padics/` has `ℤ_[p]`, `ℤ_[p]ˣ` and `toZModPow`, which
  is where the orientation character takes its values.
  `Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean` has
  `cyclotomicCharacter L p : (L ≃+* L) →* ℤ_[p]ˣ`, the character that Layer 11 identifies
  with the canonical one.
- **Cohomology.** `Mathlib/RepresentationTheory/Homological/GroupCohomology/` has `H1`, `H2`,
  `LowDegree`, `Functoriality`, `Shapiro` and long exact sequences for **discrete** groups,
  which the finite-level computations use.
  `Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean` has `continuousCohomology n`,
  the continuous cohomology of a topological representation in every degree, defined as the
  homology of homogeneous cochains, together with `continuousCohomologyZeroIso`. **This is
  the carrier of every cohomological statement in this roadmap.** It has no explicit
  description in degrees `1` and `2`, no exact sequences, no change-of-group maps and no cup
  product; the Profinite Cohomology roadmap owns all of those, and the contract table names the
  declarations this roadmap consumes.

## What is missing (build here)

Everything about pro-`p` groups. At the pin there is none of the following:

- a pro-`p` predicate, a supernatural order, or a supernatural index;
- profinite Sylow theory;
- topological finite generation, or a topological rank;
- pro-`p` Frattini theory, or the Burnside basis theorem;
- a free profinite group, a free pro-`p` group, or a presentation of either;
- Hopfian, Gaschütz or reconstruction theory;
- the lower `p`-series, or cohomological dimension for pro-`p` groups;
- Demushkin theory.

The completion functor exists, but it is never applied to a free group. `PROVENANCE.md`
records the searches behind these statements.

---

## The build, in layers

The order of the layers is the order of the dependencies. As each layer makes the types of
the next layer expressible, state its milestones in `Suggested.lean` with `sorry`.

### Layer 0: profinite foundations

- **The instance chain.** A totally disconnected topological group is T1, because its
  components are closed, hence T2, hence T3. Prove the missing glue instances once, so that
  no statement carries `[T2Space G]`.
  *Needs:* M `TotallyDisconnectedSpace`, M `IsTopologicalGroup`.
- **Quotients by closed normal subgroups.** For `G` profinite and `N` a closed normal
  subgroup, `G ⧸ N` is profinite. The missing ingredient is
  `TotallyDisconnectedSpace (G ⧸ N)`, by the clopen-image argument; package it with the
  compactness and topological-group instances, which exist.
  *Needs:* M `QuotientGroup.instTopologicalSpace`, M `IsTopologicalGroup`.
  ⚠ Closedness of `N` is a hypothesis, not decoration. A quotient by a non-closed subgroup
  is not T1. Example: `ℤ̂ ⧸ ℤ` with `ℤ` dense.
- **Closed and open subgroups.** A closed subgroup of a profinite group is profinite:
  assemble the instances. An element that lies in every open normal subgroup is `1`. A
  subgroup is open if and only if it is closed of finite index. Open normal subgroups of
  `G ⧸ N` correspond to open normal subgroups of `G` above `N`.
  *Needs:* M `closedSubgroup_eq_sInf_open`, M `ClosedSubgroup`, M `OpenSubgroup`.
- **Inverse limits, unbundled.** Restate the limit description for consumers outside the
  category: a compatible family of elements of the finite quotients of `G` comes from a
  unique element. Prove the compactness lemma in the form that Layer 8 uses: a directed
  family of nonempty closed subsets of a profinite set has nonempty intersection.
  *Needs:* M `ProfiniteGrp.toLimit_surjective`, M `ProfiniteGrp.toLimit_injective`.
  *Source:* Ribes–Zalesskii Prop. 1.1.4 for the compactness lemma.
- **Profinite completion.** Consume `ProfiniteGrp.ProfiniteCompletion`. Add the unbundled
  universal property: continuous homomorphisms from the completion to a profinite `P`
  correspond to abstract homomorphisms from `G`. Add that the unit is bijective on a finite
  group (`Suggested.lean`).
  *Needs:* M `ProfiniteGrp.profiniteCompletion`, M `ProfiniteGrp.ProfiniteCompletion.lift`.
  ⚠ An abstract homomorphism out of a profinite group need not be continuous, so the
  completion of the underlying abstract group of a profinite group is in general larger.
  That subject (Nikolov–Segal) is outside this roadmap.
  ⚠ No milestone of this roadmap assumes second countability. The absolute Galois group of a
  general field is not second countable. Where a later theorem wants a countable
  neighbourhood basis, it carries "countably many open normal subgroups" as a hypothesis,
  which Layer 3 discharges for topologically finitely generated groups.

### Layer 1: supernatural order and index

- **Supernatural numbers.** `Supernatural := Nat.Primes → ℕ∞`, with:
  - divisibility as pointwise `≤`, and multiplication as pointwise `+`;
  - the lattice operations as pointwise `⊔` and `⊓`;
  - the embedding of `ℕ+` by prime factorization;
  - the predicate "is a natural number";
  - the `p`-primary part and the prime-to-`p` part.
  *Needs:* M `padicValNat`, M `Nat.Primes`, M `ℕ∞`.

  API checklist for `Supernatural`:
  - Constructors: the embedding `ofNat : ℕ+ → Supernatural`; the constant `1`; `p ^ ∞`.
  - Examples: the order of `ℤ_p` is `p^∞`; the order of `ℤ̂` is `∏_ℓ ℓ^∞`.
  - Morphisms: the order-preserving embedding of `ℕ+`, and the projection to the `ℓ`-adic
    exponent.
  - Functoriality: none; this is an order-theoretic object.
  - Comparison lemmas: `ofNat` is multiplicative and injective, and it takes `Nat.gcd` and
    `Nat.lcm` to `⊓` and `⊔`.
  - Naturality: divisibility, product and lattice operations agree with the `ℕ+` ones under
    `ofNat`.
  - Edge cases: the value `0` at a prime, and the value `∞`; the theorem that a supernatural
    number is a natural number if and only if it has finite support and finite values.
  - Downstream interfaces: `profiniteOrder`, `profiniteIndex`, and the condition
    `¬ p ∣ profiniteIndex P G` in the Sylow definition of Layer 2.
- **The order of a profinite group.** `profiniteOrder G : Supernatural` takes at each prime
  the supremum of the valuations of the orders of the finite quotients. On a finite discrete
  group it is the factorization of `Nat.card G` (`Suggested.lean`).
  *Needs:* L1 `Supernatural`, M `Nat.card`, M `OpenNormalSubgroup`.
- **The index of a closed subgroup.** The definition is primewise through the finite
  quotients: `profiniteIndex H G ℓ = ⨆_N v_ℓ ([G/N : HN/N])`, the supremum over open normal
  `N ≤ G`. Both groups live in the same universe. The definition is written for an arbitrary
  subgroup; closedness of `H` is a hypothesis of the theorems.
  **Theorem.** For closed `H`, `profiniteIndex H G = ⨆ {U : OpenSubgroup G // H ≤ U}, [G : U]`
  in the supernatural lattice. This is the description that the literature uses.
  *Needs:* L1 `Supernatural`, L0 closed-subgroup theory, M `Subgroup.index`.
  *Source:* Ribes–Zalesskii §2.3.
  Both sides depend only on the closure of `H`, so two further statements come first:
  `profiniteIndex H G = profiniteIndex (closure H) G`, and
  `profiniteIndex H G = 1 ↔ closure H = ⊤`. For closed `H` the second is
  `profiniteIndex H G = 1 ↔ H = ⊤`.
  ⚠ Closedness is a hypothesis of Lagrange and of every statement that treats `H` as a
  profinite group in its own right. It is not needed for the two statements just above, and
  a dense proper subgroup is not a counterexample to them: its image in every finite
  quotient is everything, so both sides are `1`.
- **Index API.** All of the following, which later layers use:
  - invariance under a topological isomorphism of the pair;
  - `profiniteIndex H G = 1` if and only if `H = ⊤`, for closed `H`;
  - multiplicativity in a tower of closed subgroups;
  - the image formula under a continuous surjection;
  - Lagrange: `profiniteOrder G = profiniteOrder H * profiniteIndex H G`;
  - agreement with `Subgroup.index` for open `H`, as
    `profiniteIndex H G = ofNat (H.index)`.
  *Needs:* L1 the two definitions above; M `Subgroup.index_mul_card`.
  *Source:* Ribes–Zalesskii §2.3, Prop. 2.3.2 for Lagrange.
- **Pro-`p` in supernatural terms.** `G` is pro-`p` if and only if `profiniteOrder G` is
  supported at `p` (`Suggested.lean`). `H` is open if and only if it is closed of
  natural-number index.
  *Needs:* L1 order and index; L0 open-versus-closed.

### Layer 2: profinite Sylow theory

- **Definition.** `IsProPSylow p P` says that `P` is closed, is pro-`p` in the subspace
  topology, and has index prime to `p`. `Suggested.lean` has the per-quotient form. The
  supernatural form `¬ p ∣ profiniteIndex P G` is proved equivalent to it here.
  *Needs:* L1 index, L0 closed subgroups, M `IsPGroup`.

  API checklist for `IsProPSylow`:
  - Constructors: from a compatible family of Sylow subgroups of the finite quotients; from
    a maximal closed pro-`p` subgroup.
  - Examples: `P = ⊤` when `G` is pro-`p`; the `p`-Sylow subgroup of `ℤ̂`, which is `ℤ_p`.
  - Morphisms: the inclusion `P ≤ G` as a closed embedding of profinite groups.
  - Functoriality: the image under a continuous surjection is `p`-Sylow.
  - Comparison lemmas: the per-quotient form and the supernatural form agree; on a finite
    group the predicate agrees with Mathlib's `Sylow`.
  - Naturality: conjugation by `g` takes `p`-Sylow subgroups to `p`-Sylow subgroups, and the
    correspondence commutes with continuous surjections.
  - Edge cases: `p` not dividing the order, where `P = 1`; the trivial group.
  - Downstream interfaces: the Local Fields roadmap consumes the predicate and the five
    theorems below for wild inertia; see the shared table.
- **Existence.** Every profinite group has a `p`-Sylow subgroup. Route: the sets of Sylow
  `p`-subgroups of the finite quotients form a surjective inverse system of nonempty finite
  sets, so the Layer 0 compactness lemma applies.
  *Needs:* L0 compactness lemma; M `Sylow.exists_subgroup_card_pow_prime`, M `Sylow`.
  *Source:* Ribes–Zalesskii Cor. 2.3.6.
- **Conjugacy and the poset.** Any two `p`-Sylow subgroups are conjugate, by the same
  inverse-limit argument over the finite sets of conjugating elements. Every closed pro-`p`
  subgroup lies in a `p`-Sylow subgroup. A pro-`p` subgroup of index prime to `p` is maximal
  pro-`p`, and a maximal closed pro-`p` subgroup is `p`-Sylow. A normal `p`-Sylow subgroup
  is unique.
  *Needs:* L2 existence; L0 compactness lemma; M `Sylow.conj_eq`.
  *Source:* Ribes–Zalesskii §2.3.
- **Functoriality.** The image of a `p`-Sylow subgroup under a continuous surjection is
  `p`-Sylow. The `p`-Sylow subgroup of an inverse limit is the inverse limit of `p`-Sylow
  subgroups. Both statements are free of Galois vocabulary, because the Local Fields roadmap
  consumes them for wild inertia.
  *Needs:* L2 existence and conjugacy; L0 inverse limits.
- **Worked instances** (`Suggested.lean`). The Galois group of any Galois extension has
  `p`-Sylow subgroups. Every `p`-Sylow subgroup of `ℤ̂` is topologically isomorphic to
  `ℤ_p`. The second is stated here and proved in Layer 4, where the universal properties it
  uses are available. Its proof does **not** use a product decomposition `ℤ̂ ≅ ∏_ℓ ℤ_ℓ`,
  which is not a target of this roadmap.
  *Needs:* L2 existence; L4 the rank-one identification chain; M `IsGalois`.

### Layer 3: pro-`p` groups, the maximal pro-`p` quotient, Frattini theory, generation

- **The `IsProP` API.** Stability under closed subgroups, under quotients by closed normal
  subgroups, under finite products, and under inverse limits. The equivalence milestone: a
  profinite group is pro-`p` if and only if it is continuously isomorphic to a limit of
  finite `p`-groups.
  *Needs:* M `IsPGroup`, M `ProfiniteGrp.ofFiniteGrp`, M
  `ProfiniteGrp.continuousMulEquivLimittoFiniteQuotientFunctor`; L0 quotients.

  API checklist for `IsProP`:
  - Constructors: from the quotient form; from a presentation as a limit of finite
    `p`-groups; from `IsPGroup` on a finite discrete group.
  - Examples: `ℤ_p`; `ℤ/p^n`; `freeProP p (Fin n)`; `D₀` of Layer 6.
  - Morphisms: continuous homomorphisms between pro-`p` groups; no extra structure.
  - Functoriality: the property passes to closed subgroups, to quotients by closed normal
    subgroups, to finite products and to limits.
  - Comparison lemmas: pro-`p` if and only if the supernatural order is a power of `p`
    (Layer 1); pro-`p` if and only if `proPKernel p G = ⊥`.
  - Naturality: the property is invariant under topological isomorphism.
  - Edge cases: the trivial group is pro-`p` for every `p`; a finite discrete `p`-group is
    pro-`p`; a group that is pro-`p` for two different primes is trivial.
  - Downstream interfaces: the Local Fields roadmap applies it to `U(K,1)`; see the shared
    table.
- **The maximal pro-`p` quotient.** `proPKernel p G` is the intersection of the open normal
  subgroups with `p`-group quotient. It is closed, normal, characteristic for continuous
  automorphisms, and preserved by continuous homomorphisms. Then
  `maximalProPQuotient p G := G ⧸ proPKernel p G`, which is pro-`p`, by the compactness
  argument that an open normal subgroup containing the kernel already contains a member of
  the defining family. State its quotient map, its universal property, its idempotence on
  pro-`p` groups, and its functoriality once, here.
  *Needs:* L0 quotients and closed subgroups; M `OpenNormalSubgroup`; M `IsPGroup`.

  API checklist for `maximalProPQuotient`:
  - Constructors: the quotient map `G ↠ G(p)`; the induced map for a continuous
    homomorphism.
  - Examples: `maximalProPQuotient p ℤ̂ ≅ ℤ_p` (Layer 4); `maximalProPQuotient p G = G` for
    pro-`p` `G`; `absoluteGaloisGroupProP` of Layer 11.
  - Morphisms: continuous homomorphisms to a pro-`p` group factor uniquely through it.
  - Functoriality: functorial in `G` for continuous homomorphisms; idempotent.
  - Comparison lemmas: `proCKernel (finiteGroupClassP p) G = proPKernel p G` (Layer 4).
  - Naturality: the factorization is natural in both the source and the target.
  - Edge cases: `proPKernel p G = ⊤` when `G` has no `p`-group quotient, so `G(p)` is
    trivial; a prime that does not divide the order.
  - Downstream interfaces: `G_K(p) := absoluteGaloisGroupProP` in Layer 11, which the Local
    Fields roadmap consumes.
- **Topological generation and rank.** First the generation API through
  `Subgroup.topologicalClosure`, the predicate `IsTopologicallyFinitelyGenerated`, and the
  statement that generation passes along continuous surjections. Then the convergence
  predicate `ConvergesToOne`, with:
  - finite sets converge to `1`;
  - a subset of a converging set converges to `1`;
  - a continuous image of a converging set converges to `1`;
  - **every profinite group has a generating set that converges to `1`**, so that
    `topologicalGeneratorRank` is an infimum over a nonempty family.

  Then the rank itself, with:
  - monotonicity under continuous surjections;
  - invariance under topological isomorphism;
  - finiteness of the cardinal exactly under `IsTopologicallyFinitelyGenerated`;
  - the accessor `topologicalGeneratorRankNat G h`, with
    `(topologicalGeneratorRankNat G h : Cardinal) = topologicalGeneratorRank G`, and proof
    irrelevance in `h`.
  *Needs:* L0 open normal subgroups; M `Subgroup.topologicalClosure`; M `Cardinal`.
  *Source:* Ribes–Zalesskii Prop. 2.6.2 for the existence of a converging generating set.

  API checklist for `topologicalGeneratorRank`:
  - Constructors: from a converging generating set; from the finite accessor.
  - Examples: `d(ℤ_p) = 1`; `d(freeProP p (Fin n)) = n`; `d(∏_{i ∈ ℕ} ℤ/p) = ℵ₀`.
  - Morphisms: continuous surjections do not raise the rank.
  - Functoriality: monotone under continuous surjections; invariant under topological
    isomorphism.
  - Comparison lemmas: agreement with `topologicalGeneratorRankNat`; agreement with
    `Group.rank` on a finite discrete group; the identity with `dim_{𝔽_p} Hom_cont(G, 𝔽_p)`
    for pro-`p` `G`.
  - Naturality: the rank of a quotient is at most the rank of the group, compatibly with
    composition of surjections.
  - Edge cases: the trivial group has rank `0`; an infinite-rank group, where the accessor
    is unavailable; the difference from the unrestricted notion, which the convention above
    records.
  - Downstream interfaces: the Schreier bound below; the Euler formulas of Layers 6 and 7;
    the Local Fields rank statements in the shared table.
- **Open subgroups of each index, and countability.** A topologically finitely generated
  profinite group has finitely many open subgroups of each index, because it has finitely
  many continuous maps to each finite group. Four consequences are proved here:
  - the set of open subgroups is countable;
  - the set of open normal subgroups is countable;
  - there is a descending sequence `(N_k)` of open normal subgroups, cofinal among them;
  - hence the sequential form of the Layer 0 compactness lemma holds.

  Layer 8 uses the sequential form. Prefer the general form wherever it is enough.
  *Needs:* L3 `IsTopologicallyFinitelyGenerated`; L0 compactness lemma.
- **The Schreier bound.** An open subgroup `U` of a topologically finitely generated
  profinite group is topologically finitely generated, with
  `d(U) ≤ 1 + [G : U](d(G) - 1)` in natural numbers.
  *Needs:* L3 rank; M `Subgroup.index`.
  *Source:* Ribes–Zalesskii Cor. 3.6.3. Layer 6 proves equality in the free case.
- **Hopf property.** A continuous surjective endomorphism of a topologically finitely
  generated profinite group is an isomorphism (`Suggested.lean`). This is the last step of
  every two-sided comparison in Layer 8.
  *Needs:* L3 finitely many open subgroups of each index; L0 compactness.
  *Source:* Ribes–Zalesskii Prop. 2.5.2.
  ⚠ False without finite generation: an infinite product of copies of a finite group admits
  a continuous surjective endomorphism that is not injective, namely the shift.
- **Gaschütz lifting.** Along a continuous surjection of profinite groups, an `n`-tuple that
  topologically generates the target lifts to an `n`-tuple that topologically generates the
  source, provided the source is topologically generated by `n` elements
  (`Suggested.lean`). Corollary: for a quotient map whose kernel lies in `Φ(G)`, generators
  lift.
  *Needs:* L3 generation API; L0 compactness lemma.
  *Source:* Ribes–Zalesskii Prop. 2.5.4.
- **Frattini theory for pro-`p` groups.** For pro-`p` `G`, a maximal open subgroup is normal
  of index `p`; the finite input is that a maximal subgroup of a finite `p`-group is normal
  of index `p`. `proPFrattini p G`, in the index-`p` form, is closed, normal and
  characteristic, and it equals both the intersection of the maximal open subgroups and
  `closure (Gᵖ[G,G])` (`Suggested.lean`). The Frattini quotient `G/Φ(G)` is elementary
  abelian, hence an `𝔽_p`-vector space.
  *Needs:* M `frattini`, M `IsPGroup.exists_maximal_subgroup_normal` and the finite Frattini
  lemmas; L3 `IsProP` API; L0 quotients.

  API checklist for `proPFrattini`:
  - Constructors: the index-`p` definition; the verbal description `closure (Gᵖ[G,G])`.
  - Examples: `Φ(ℤ_p) = pℤ_p`; `Φ(freeProP p (Fin n))` with quotient `(ℤ/p)^n`;
    `Φ((ℤ/p)^n) = 1`.
  - Morphisms: the quotient map to the Frattini quotient, as a map of `𝔽_p`-vector spaces.
  - Functoriality: a continuous surjection sends `Φ(G)` onto `Φ(H)`; every continuous
    endomorphism preserves `Φ(G)`.
  - Comparison lemmas: the two descriptions agree; on a finite `p`-group the object agrees
    with Mathlib's `frattini`.
  - Naturality: the Frattini quotient functor commutes with continuous surjections.
  - Edge cases: `Φ(G) = G` is impossible for nontrivial pro-`p` `G`; the abstract `frattini`
    differs when `G` is not finitely generated.
  - Downstream interfaces: Burnside below; the rank formulas; the Local Fields rank
    statements.
- **Burnside basis theorem.** A subset generates `G` topologically if and only if its image
  generates `G/Φ(G)` topologically. The closure on the quotient side is needed: at infinite
  rank the image of a generating set spans only a dense subspace. Two further forms are in
  `Suggested.lean`:
  - a closed subgroup that lies in no open normal subgroup of index `p` is the whole group;
  - a continuous homomorphism that is surjective onto every index-`p` quotient is
    surjective.

  The rank identity is proved first as an identity of cardinals, with no finiteness
  hypothesis, against the discrete dual:
  `topologicalGeneratorRank G = Module.rank (ZMod p) (Hom_cont(G/Φ(G), 𝔽_p))`, where
  `Hom_cont(G/Φ(G), 𝔽_p) = Hom_cont(G, 𝔽_p)` is a discrete `𝔽_p`-vector space. Then `G` is
  topologically finitely generated if and only if `G/Φ(G)` is finite, and in that case
  `topologicalGeneratorRankNat G h = Module.finrank (ZMod p) (G/Φ(G))`.
  *Needs:* L3 Frattini theory, L3 rank and `ConvergesToOne`; M `Module.rank`, M
  `Module.finrank`.
  *Source:* Ribes–Zalesskii Prop. 2.8.7 and §2.8; NSW (3.9.1).
  Proof note for the cardinal identity. A continuous functional vanishes on all but finitely
  many members of a converging set. So restriction embeds the dual in the finitely supported
  functions on that set, which bounds the dimension of the dual by the cardinality of the
  set. The dual basis of a converging basis gives the other inequality.
  ⚠ **Abstract generation and topological generation are different.** Every statement here
  is about topological generation. The Frattini quotient is why the two agree numerically
  for pro-`p` groups.

### Layer 4: free pro-`p` and pro-`C` groups on finite sets

- **The class `C` as a structure.** `FiniteGroupClass` with the fields listed in the
  conventions, the derived theorem on finite products, and the `Shrink` resizing policy.
  From it: `proCKernel C G`, which is closed, normal and characteristic, with the API of
  `proPKernel`; `proCCompletion C G := G ⧸ proCKernel C G` with its universal property; and
  the instantiation `finiteGroupClassP p`, with
  `proCKernel (finiteGroupClassP p) G = proPKernel p G`. Every pro-`C` statement below is
  about this structure, and there is no per-class construction.
  *Needs:* L3 `proPKernel` API; M `Shrink`; M `IsPGroup`.

  API checklist for `FiniteGroupClass`:
  - Constructors: `finiteGroupClassP p`; the class of all finite groups; the class of finite
    solvable groups. ⚠ The class of finite nilpotent groups is **not** an example: it is not
    closed under extensions, because `1 → C₃ → S₃ → C₂ → 1` has nilpotent kernel and
    quotient while `S₃` is not nilpotent.
  - Examples: finite `p`-groups, where `proCCompletion` is `maximalProPQuotient`.
  - Morphisms: none between classes is needed; inclusion of classes is a predicate on `mem`.
  - Functoriality: `proCKernel C` is preserved by continuous homomorphisms, and
    `proCCompletion C` is functorial and idempotent.
  - Comparison lemmas: `mem_congr` transports membership along a group isomorphism;
    `Shrink` transports it between universes; `proCKernel (finiteGroupClassP p) = proPKernel p`.
  - Naturality: the universal property of `proCCompletion` is natural in `G`.
  - Edge cases: the class that contains only the trivial group, where the completion is
    trivial; a class that is not closed under extensions, which is why that field exists.
  - Downstream interfaces: `freeProC`, and Layer 10's free object on a profinite space.
- **Construction of the free objects.**
  - `freeProfiniteGroup X := profiniteCompletion (FreeGroup X)`, the free profinite group,
    with its generators and its universal property;
  - `presentedProfiniteGroup X rels`, the quotient of `freeProfiniteGroup X` by the closed
    normal closure of a set of relators;
  - `freeProC C X := proCCompletion C (freeProfiniteGroup X)`;
  - `freeProP p X := maximalProPQuotient p (freeProfiniteGroup X)`.

  The pro-`p` quotient is taken directly, because `proPKernel` and
  `proCKernel (finiteGroupClassP p)` are cut out by different index sets and agree by a
  short theorem, not by unfolding. That theorem,
  `freeProC (finiteGroupClassP p) X ≅ freeProP p X`, is the first milestone here, and after
  it no statement has to choose between the two constructions. The profinite objects
  `freeProfiniteGroup` and `presentedProfiniteGroup` are what the Local Fields roadmap uses
  for the Iwasawa presentation of the tame quotient; see the shared table.
  *Needs:* M `ProfiniteGrp.profiniteCompletion`, M `FreeGroup`; L3 `maximalProPQuotient`;
  L4 `FiniteGroupClass`.

  API checklist for `freeProP`:
  - Constructors: `freeProP.of` on generators; the lift of a map `X → P` into a pro-`p`
    group `P`.
  - Examples: `freeProP p (Fin 0) ≅ 1`; `freeProP p (Fin 1) ≅ ℤ_p`; `freeProP 2 (Fin 3)`,
    the source of the relator `A²S⁴(S,Y)`.
  - Morphisms: continuous homomorphisms out of it are exactly maps on generators; the
    quotient maps to presented groups.
  - Functoriality: a map `X → Y` induces a continuous homomorphism, functorially; a
    surjection of generating sets gives a surjection of groups.
  - Comparison lemmas: agreement with `freeProC (finiteGroupClassP p) X`; agreement with the
    pro-`p` completion of the discrete free group; `FreeGroup X → freeProP p X` is
    injective.
  - Naturality: the universal property is natural in `X` and in the target.
  - Edge cases: the empty generating set; a one-element generating set, which gives `ℤ_p`;
    an infinite generating set, where the rank is **not** `#X` and Layer 10 applies.
  - Downstream interfaces: presentations in Layer 5, the tower of Layer 8, the normal forms
    of Layer 9.
- **Universal property.** A map `X → P` into a profinite group `P` in the class `C` extends
  uniquely to a continuous homomorphism (`Suggested.lean` has the pro-`p` case). The free
  object is unique up to unique isomorphism, and it is functorial in `X`.
  *Needs:* L4 construction; M `ProfiniteGrp.ProfiniteCompletion.lift`.
- **Basics.** `freeProP p X` is pro-`p`. For finite `X` it is topologically finitely
  generated (`Suggested.lean`), of rank `#X`, through the Frattini quotient `(ℤ/p)^X` of
  Layer 3, with the natural-number form
  `topologicalGeneratorRankNat (freeProP p (Fin n)) h = n`. The generators are a basis: free
  groups are residually `p`, so `FreeGroup X → freeProP p X` is injective
  (`Suggested.lean`).
  *Needs:* L3 Burnside; L4 universal property; M `FreeGroup`.
  *Source:* the residual `p`-finiteness of free groups; the argument uses the finite
  upper-triangular representations, or the lower `p`-series of the discrete free group.
  ⚠ For infinite `X` the rank of `freeProP p X` is **not** `#X`. Its continuous characters
  are all maps `X → 𝔽_p`, so the rank is `p^{#X}` by the Erdős–Kaplansky theorem. Layer 10
  states the free objects on infinite bases, on a profinite space.
- **Rank one and `ℤ_p`.** `freeProP p (Fin 0) ≅ 1`, and the rank-one identification is a
  chain of universal properties, each step a named theorem, with no product decomposition of
  `ℤ̂` anywhere:
  1. `maximalProPQuotient p (profiniteCompletion ℤ) ≅ lim_n ℤ/p^nℤ` as topological groups,
     because the open normal subgroups of `ℤ̂` with `p`-group quotient are the `p^nℤ̂`;
  2. `lim_n ℤ/p^nℤ ≅ ℤ_p`: Mathlib's `ℤ_[p]` with its `toZModPow` system is that inverse
     limit as a topological ring, hence as a topological group;
  3. `freeProP p (Fin 1) ≅ Multiplicative ℤ_[p]`: both objects represent the same functor,
     because a continuous homomorphism from either to a pro-`p` group `P` is an element of
     `P`, so the uniqueness of the free object gives the isomorphism;
  4. a closed subgroup `P ≤ ℤ̂` is `p`-Sylow if and only if
     `P ↪ ℤ̂ ↠ maximalProPQuotient p ℤ̂` is a topological isomorphism, which with steps 1
     and 2 proves the Layer 2 instance.

  Step 3 is what every later `ℤ_p`-coefficient argument cites, in particular the
  identification of the characters `Hom_cont(G, ℤ_pˣ)` in Layer 7.
  *Needs:* L3 `maximalProPQuotient`; L4 universal property; M `PadicInt.toZModPow`.

#### Finitely generated abelian pro-`p` groups

This subsection mentions no Demushkin group. Layer 7 cannot define `q(G)` without it, and
several Layer 9 module arguments use it. Ribes–Zalesskii §4.3 is the source of record.

- **Exponentiation by `ℤ_p`.** For abelian pro-`p` `A`, the continuous action
  `ℤ_p × A → A`, `(λ, a) ↦ a^λ`, is the inverse limit of exponentiation in the finite
  abelian `p`-quotients, where `ℤ_p` acts through `ℤ/p^n`. Well-definedness is the
  compatibility of those actions, and continuity is the limit topology.
  *Needs:* L0 inverse limits; L3 `IsProP` API; M `ZMod.intCast_cast` and `PadicInt.toZModPow`.
- **The `ℤ_p`-module structure.** `A` becomes a topological `ℤ_p`-module, functorially in
  continuous homomorphisms of abelian pro-`p` groups. Closed subgroups and quotients are
  submodules and quotient modules. A continuous group homomorphism between abelian pro-`p`
  groups is automatically `ℤ_p`-linear.
  *Needs:* L4 exponentiation; M `Module`.
- **Compact `ℤ_p`-modules.** A topologically finitely generated abelian pro-`p` group is a
  finitely generated `ℤ_p`-module, and the two notions of generation agree. The full
  equivalence of categories is not a target.
  *Needs:* L4 module structure; L3 rank.
- **Structure theorem.** `A ≅ ℤ_p^r × T` as topological `ℤ_p`-modules, with `T` a finite
  abelian `p`-group. The number `r` and the elementary divisors of `T` are unique. `T` is
  the torsion subgroup of `A`; it is closed always, and open when `r = 0`.
  *Needs:* L4 compact modules; M the structure theorem for finitely generated modules over a
  principal ideal domain, `Module.equiv_free_prod_directSum` and the `ℤ_[p]` PID instance.
  *Source:* Ribes–Zalesskii §4.3.
  ⚠ The theorem needs topological finite generation. `∏_{i ∈ ℕ} ℤ/p` is abelian pro-`p` and
  is not of this shape.
- **The pro-`p` completion of `ℤ`, as a module statement.** The universal-property proof
  that `freeProP p (Fin 1)`, `maximalProPQuotient p (profiniteCompletion ℤ)` and
  `Multiplicative ℤ_[p]` agree is the rank-one item above. Here it is restated as the fact
  that `ℤ_p` is the free `ℤ_p`-module of rank 1, and that the two notions of rank agree.
  *Needs:* L4 rank-one chain, L4 module structure.

### Layer 5: presentations, extensions, and the rank interpretations

#### The coefficient objects, over the imported carrier

**The carrier is Mathlib's, and its calculus is the Profinite Cohomology roadmap's.** At the
pin, `Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean` defines `continuousCohomology n`
in every degree, as the homology of homogeneous cochains of a topological representation. That
object is the carrier of every cohomological statement in this roadmap. This roadmap defines no
second cohomology theory and no second cohomological operation: a private carrier would admit
terms that satisfy its signatures without satisfying the exactness and pairing laws that the
later layers use, and a private operation would need an unproved comparison with the one that
already exists.

What this layer owns is the coefficient object the pro-`p` theory computes with, and nothing
about the substrate.

- **The coefficient object.** `trivialFp p G` is the trivial `𝔽_p`-representation of `G`, an
  object of `ProfiniteCohomology.TopRep (ZMod p) G`, and `cohomFp p G n` is its cohomology,
  `(continuousCohomology (ZMod p) G n).obj (trivialFp p G)`. Mathlib places the coefficients in
  the universe of `G`, so the trivial module is `ULift (ZMod p)`, which `Suggested.lean`
  records. Every dimension count in this roadmap is about `cohomFp`. The other coefficient
  systems used below are `I(χ)/p^i` and `𝔽_p[G/U]` for `U` open.
  *Needs:* PC-1 `TopRep`, M `continuousCohomology`, M `TopModuleCat`, M `Action`.
- **The multiplication pairing and the cup square.** `fpPairing p G` is the term of
  `ProfiniteCohomology.TopPairing` on `trivialFp p G` given by multiplication in `ZMod p`; it is
  `ZMod p`-bilinear, continuous because the coefficients are discrete, and equivariant because
  the action is trivial. `cupFp p G a b` is `ProfiniteCohomology.cup (fpPairing p G) 1 1 a b`,
  transported from degree `1 + 1` to degree `2`. This is the cup square
  `H¹(G, 𝔽_p) × H¹(G, 𝔽_p) → H²(G, 𝔽_p)` that the Demushkin predicate and the Layer 11 duality
  input are stated against, and it is the only cup product in this roadmap. Its graded
  commutativity, `cupFp a b = - cupFp b a`, is the specialization of
  `ProfiniteCohomology.cup_gradedComm` at the pairing, whose opposite pairing is itself because
  multiplication in `ZMod p` is commutative. Graded commutativity turns right nondegeneracy of a
  cup pairing into a consequence of left nondegeneracy, so Layer 7 and Layer 11 both cite it.
  *Needs:* PC-12 `TopPairing`, `ofDiscreteModulePairing`, `cup`, `cup_gradedComm`, `degreeCast`.
  *Source:* NSW I §1.4 for the cochain formula.

  API checklist for the coefficient objects:
  - Constructors: `trivialFp`; `fpPairing` from multiplication on `ZMod p`; the class of a
    cocycle, through the imported comparison isomorphisms.
  - Examples: `H¹(G, 𝔽_p) ≅ Hom_cont(G, 𝔽_p)`; `H²(ℤ/2, 𝔽₂)` is one-dimensional, generated by
    the class of the extension `ℤ/4`; `H²(F, 𝔽_p) = 0` for `F` free pro-`p` of finite rank.
  - Morphisms: inflation, restriction, corestriction, the connecting map, and the maps induced
    by a map of coefficients, all imported.
  - Functoriality: contravariant in the group, covariant in the coefficients, both imported.
  - Comparison lemmas: `fpPairing_bil`, the defining equation of the pairing; the imported
    `explicitIso_cup` relating the canonical cup to the explicit `(1,1)` shape.
  - Naturality: `cup_res`, `cup_infl`, `cup_coeffMap` and `cup_projection`, all imported.
  - Edge cases: the trivial group, where `H^n` vanishes for `n ≥ 1`; a finite group, where the
    imported comparison with discrete `groupCohomology` applies; coefficients with a nontrivial
    action, where `H⁰` is not all of `M`, which is the `I(χ)/p^i` system of Layer 7.
  - Downstream interfaces: cohomological dimension in Layer 6, the Demushkin predicate in
    Layer 7, the rank interpretations below, and the Layer 11 inputs.

#### Presentations

- **Presented pro-`p` groups.** `presentedProP p X rels` is the free pro-`p` group modulo
  the closed normal closure of the relators. Every topologically finitely generated pro-`p`
  group has a presentation by a free pro-`p` group of finite rank, and has a minimal one,
  with `topologicalGeneratorRankNat F = topologicalGeneratorRankNat G`, characterized by
  `R ≤ Φ(F)`.
  *Needs:* L4 free objects; L3 Burnside and Gaschütz.
  ⚠ A presentation of an arbitrary pro-`p` group needs free objects on an infinite basis
  that converges to `1`, which is Layer 10. The arbitrary-rank presentation theorem is
  stated there.

  API checklist for `presentedProP`:
  - Constructors: the quotient map from the free pro-`p` group; the induced map out of a
    presented group, given that the relators die in the target.
  - Examples: `D₀` at `p = 2`; `presentedProP p X ∅ ≅ freeProP p X`; the normal forms of
    Layer 9.
  - Morphisms: continuous homomorphisms out of it are maps on generators that kill the
    relators.
  - Functoriality: a map of presentations, that is of generator sets and relator sets,
    induces a continuous homomorphism.
  - Comparison lemmas: agreement with `freeProP p X ⧸ R` for `R` the closed normal closure;
    the profinite version `presentedProfiniteGroup` maps onto it.
  - Naturality: the universal property is natural in the target.
  - Edge cases: an empty relator set; a relator set whose closed normal closure is
    everything, where the presented group is trivial; the difference between the algebraic
    and the closed normal closure.
  - Downstream interfaces: minimal presentations and the relation rank below; the Layer 9
    normal forms; the Local Fields Iwasawa presentation, which uses the profinite object.
- **Non-vacuity, with the map named.** `D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩`, defined in
  `Suggested.lean`, is nontrivial, pro-`2` and topologically finitely generated. The proof
  is not "map it onto some finite `2`-group". The map is `φ : freeProP 2 (Fin 3) → ℤ/2` with
  `φ(A) = 0`, `φ(S) = 1`, `φ(Y) = 0`, given by the universal property of Layer 4. The
  relator maps to `0·2 + 1·4 + 0 = 0`, because the commutator vanishes in an abelian group,
  so
  `φ` factors through `D₀`, and `D₀ ↠ ℤ/2` is surjective. Therefore `D₀` is nontrivial.
  *Needs:* L4 universal property; L5 presentations.

#### Continuous extensions and finite `p`-embedding problems

- **The extension object.** For profinite `G` and a finite discrete abelian `p`-primary
  `G`-module `M`, an extension is a short exact sequence `1 → M → E → G → 1` of topological
  groups such that:
  - `E` is profinite;
  - `M → E` is injective onto a **closed** normal subgroup;
  - `E → G` is a continuous surjection whose kernel is that subgroup;
  - conjugation of `E` on `M` induces the given action.

  A finite subgroup of a profinite group is closed and carries the discrete topology, so the
  injection is a topological embedding. Morphisms are the continuous homomorphisms that fix
  `M` and cover the identity of `G`. Every such morphism is an isomorphism.
  *Needs:* L0 profinite foundations.
  ⚠ Do **not** ask `M` to be open in `E`. An open `M` makes `G` finite, and the groups this
  dictionary is used on are infinite.
- **Continuous sections along a finite kernel.** If `E` is profinite and `N ≤ E` is a finite
  normal subgroup, then `E ↠ E/N` has a continuous set-theoretic section that sends `1` to
  `1`. The proof has three steps. First, `E` has an open normal subgroup `U` with
  `U ∩ N = 1`; intersect the open normal subgroups that separate the finitely many
  nontrivial elements of `N` from `1`. Second, `U` maps isomorphically onto an open subgroup
  of `E/N`, which has finite index. Third, finitely many coset translates of that local
  section give a section over a clopen partition of `E/N`.
  *Needs:* L0 open normal subgroups.
  ⚠ A surjection of profinite **spaces** need not have a continuous section, so no statement
  here uses one. For profinite groups with an arbitrary closed kernel a section does exist
  (Ribes–Zalesskii Prop. 2.2.2), but the finite-kernel case is elementary and is all that is
  used.
- **Cocycles and extensions.** From a continuous normalized `2`-cocycle build the extension
  on `M × G` with the twisted multiplication, and check that the product topology makes it
  profinite. From a continuous normalized section build a continuous normalized cocycle. The
  two constructions are mutually inverse up to equivalence of extensions.
  *Needs:* PC-2 the explicit low degrees; L5 sections.
- **The bijection.** Equivalence classes of extensions correspond to `H²(G, M)`, with the
  trivial class corresponding to the semidirect product, naturally in `M`. State it as a
  bijection of sets. The Baer sum is not needed and is not a target.
  *Needs:* L5 cocycles and extensions.
- **Splitting.** An extension has a continuous group-theoretic section if and only if its
  class in `H²(G, M)` is zero.
  *Needs:* L5 the bijection.
- **Embedding problems with `p`-group kernel.** A finite embedding problem for `G` is a
  continuous surjection `π : G ↠ Q` onto a finite group, together with a surjection
  `α : E ↠ Q` of finite groups; a solution is a continuous `β : G → E` with `α ∘ β = π`.
  Reduce the case where `N := ker α` is a finite `p`-group to the central elementary-abelian
  case along the lower `p`-central series of `N`, that is `λ_0(N) = N` and
  `λ_{k+1}(N) = λ_k(N)^p [λ_k(N), N]`. Each `λ_k(N)` is characteristic in `N`, hence normal
  in `E`; each factor is elementary abelian and is centralized by `N`, hence is a
  `Q`-module; and the series reaches `1` in finitely many steps. A solution is built in that
  many steps, each of them an extension of the kind above.
  *Needs:* L5 extensions; M `IsPGroup` and the finite lower `p`-central series.
  ⚠ Characteristicity is what makes the reduction work. An arbitrary central series of `N`
  need not be stable under conjugation by `E`.
- **Vanishing of `H²` solves them.** If `H²(G, M) = 0` for every finite discrete
  elementary abelian `p`-primary `G`-module `M`, then every finite embedding problem for `G`
  with `p`-group kernel has a solution, by induction along that series. The solution is a
  homomorphism `β` with `α ∘ β = π`, and nothing more.
  *Needs:* L5 embedding problems; L5 the extension dictionary.
  ⚠ A solution cannot be made surjective in general, and no statement here says otherwise.
  With `G = C_p`, `Q = 1` and `E = C_p × C_p`, the unique maps form an embedding problem
  whose solutions are the homomorphisms `C_p → C_p × C_p`, none of which is surjective. The
  Burnside criterion certifies that a map which is already surjective on the Frattini
  quotient is surjective; it cannot supply a missing generator. Projectivity needs only the
  weak form, which is what the next item uses.
- **From finite solutions to projectivity.** Compatible solutions over the finite quotients
  assemble to a continuous lift against an arbitrary surjection of pro-`p` groups: apply the
  Layer 0 compactness lemma to the nonempty closed sets of level-`k` solutions. This is the
  projectivity statement that Layer 6 uses.
  *Needs:* L0 compactness lemma; L5 the previous item.
- **`H²` of a free pro-`p` group vanishes.** For `F` free pro-`p` of finite rank and `M`
  finite discrete `p`-primary, `H²(F, M) = 0`. Proof: by the dictionary a class is an
  extension `1 → M → E → F → 1`, and the universal property of `F` lifts a generating tuple
  through `E ↠ F`, which produces a continuous group-theoretic section, so the class is
  zero. This theorem is proved here, because the relation-rank theorem below uses it. Layer
  6 restates it as `cd_p F ≤ 1` and proves the converse.
  *Needs:* L5 the dictionary; L4 universal property.
  *Source:* Serre, *Galois Cohomology* I §3.4; Koch Ch. 4.12.

#### Rank interpretations

- **`H¹` interpretation.** `H¹(G, 𝔽_p) ≅ Hom_cont(G, 𝔽_p) ≅ (G/Φ(G))^∨`, so
  `dim_{𝔽_p} H¹(G, 𝔽_p) = topologicalGeneratorRankNat G h` for topologically finitely
  generated pro-`p` `G`. The cardinal form without finiteness is the Layer 3 identity: that
  identity is already stated against the discrete dual, so this layer only identifies the
  dual with `H¹(G, 𝔽_p)`.
  *Needs:* L5 the coefficient objects; PC-3 the degree-one comparison; L3 Burnside.
  *Source:* Labute §1.3; Serre, *Galois Cohomology* I §4.2; NSW (3.9.1).
- **`H²` interpretation.** For a minimal presentation `1 → R → F → G → 1` of a topologically
  finitely generated pro-`p` group, transgression `H¹(R, 𝔽_p)^F → H²(G, 𝔽_p)` is an
  isomorphism, by the five-term sequence and the vanishing theorem above. The space
  `H¹(R, 𝔽_p)^F` is dual to `R/Rᵖ[R,F]`, whose dimension is the least number of
  generators of `R` as a closed normal subgroup. Hence `r(G) = dim H²(G, 𝔽_p)` counts
  relations, and does not depend on the minimal presentation. This is the
  presentation-independence theorem.
  *Needs:* PC-5 the five-term sequence; L5 vanishing theorem; L5 presentations.
  *Source:* Labute §1.4; NSW (3.9.5).
- **Deficiency and one-relator groups.** For pro-`p` `G` that is topologically finitely
  generated with `H²(G, 𝔽_p)` finite-dimensional, both `d(G)` and `r(G)` are natural
  numbers, and `def(G) : ℤ` is defined by `d(G) = def(G) + r(G)`, so that no truncated
  natural subtraction occurs. A finite relation system exists if and only if `H²` is finite,
  and then `#S - #R ≥ d - r` as an inequality in `ℤ`, with equality for minimal
  presentations. The case `r(G) = 1` is the one-relator case, and a Demushkin group is a
  one-relator pro-`p` group with relator in `Fᵖ[F,F]`, which is the input to Layer 7.
  *Needs:* L5 rank interpretations.
  *Source:* NSW (3.9.4).
- **The Golod–Shafarevich inequality.** For a nontrivial finite `p`-group, `4 r(G) > d(G)²`,
  stated in that form over `ℕ`. It is the classical result on deficiency, and it explains
  why a finite `p`-group needs many relations.
  *Needs:* L5 rank interpretations.
  *Source:* NSW (3.9.7); Ribes–Zalesskii Thm. 7.8.5.
- **Sanity example.** `d((ℤ/p)ⁿ) = n` and `r((ℤ/p)ⁿ) = n(n+1)/2`. This count detects a wrong
  normalization of `H²`.
  *Needs:* L5 rank interpretations.

### Layer 6: cohomological dimension of pro-`p` groups

`cd_p G` is `ProfiniteCohomology.cd_p p G`: the infimum, in `ℕ∞`, of the `n` for which
`H^m(G, M)` vanishes for every `m > n` and every discrete `p`-primary torsion `G`-module `M`.
That declaration belongs to the Profinite Cohomology roadmap, and this roadmap defines no second
cohomological dimension. Three reduction theorems say when a smaller test suffices, and none of
them is the definition:

- testing only the **finite** discrete `p`-primary modules gives the same predicate, by
  compatibility with filtered colimits of coefficients. This is
  `ProfiniteCohomology.cd_p_le_iff_finite_pPrimary`, which is cited and not restated;
- testing only the modules of **bounded exponent** gives the same predicate, for the same
  reason. This is `ProfiniteCohomology.cd_p_le_iff_boundedExponent`;
- for a pro-`p` group, testing the single module `𝔽_p` gives the same predicate, by the
  dévissage below. This one is owned here, as `cd_p_le_iff_elementaryAbelian_of_isProP`,
  because its proof is the pro-`p` trivial-filtration theorem of this layer.

Writing the elementary abelian test as the definition would make the dévissage vacuous and
would not agree with the standard `cd_p`.

- **The trivial-filtration theorem.** For pro-`p` `G`, a nonzero finite discrete `p`-primary
  `G`-module has nonzero invariants: the action factors through a finite `p`-quotient, and a
  finite `p`-group acting on a nonzero finite `p`-group fixes a nonzero element. Iterating,
  every such `M` has a `G`-stable filtration whose factors are one-dimensional with trivial
  action. Hence a `ℤ`-valued function of the coefficients that is additive along short exact
  sequences takes the value `length M` times its value at `𝔽_p`, where
  `length M = padicValNat p (Nat.card M)` is the composition length.
  *Needs:* M `IsPGroup.card_modEq_card_fixedPoints`; L3 `IsProP` API.
  ⚠ Do not write `dim_{𝔽_p} M` here. A finite `p`-primary module is not an `𝔽_p`-vector
  space in general, and `ℤ/p²` is the smallest counterexample. The two agree exactly when
  `M` is killed by `p`. That is the case the Euler formulas use, since they take
  `M = 𝔽_p[G/U]`, where `length = dim_{𝔽_p} = [G : U]`.
- **Dévissage.** For a pro-`p` group, vanishing on the finite discrete elementary abelian
  `p`-primary modules in one degree gives vanishing on all finite discrete `p`-primary
  modules in that degree. Route: the trivial-filtration theorem above, and the long exact
  sequence in that degree.
  *Needs:* L6 trivial filtration; PC-5 the long exact sequence.
  *Source:* Serre, *Galois Cohomology* I §3.
- **Vanishing in one degree gives vanishing above it.** If `H²(G, M) = 0` for every finite
  discrete `p`-primary `G`-module `M`, and `G` is pro-`p`, then `H^n(G, M) = 0` for every
  `n ≥ 2` and every such `M`. Route: dimension shifting through `Coind_1^G M`, which uses
  Shapiro for the **closed** trivial subgroup, the long exact sequence for coefficients that
  are not finite, and the dévissage above. This is the theorem that turns the Layer 5
  vanishing theorem for free pro-`p` groups into `cd_p ≤ 1`.
  *Needs:* L6 dévissage; PC-7 `Coind`, `shapiroIso` for a closed subgroup; L6 dimension shifting.
  *Source:* Serre, *Galois Cohomology* I §3.1; Ribes–Zalesskii 7.7.4.
- **Free implies `cd ≤ 1`.** Layer 5's theorem `H²(F, M) = 0`, for `F` free pro-`p` of
  finite rank and `M` finite discrete `p`-primary, restated as `cd_p F ≤ 1`
  (`cd_p_freeProP_le_one`). Dévissage
  changes the coefficients and the vanishing theorem above changes the degree, so the proof
  needs both.
  *Needs:* L5 vanishing theorem; L6 dévissage; L6 vanishing in one degree gives vanishing
  above it.
- **Serre's theorem: `cd_p G ≤ 1` implies free pro-`p`,** for topologically finitely
  generated `G` (`isFree_of_cd_p_le_one`). The route has four steps:
  1. `cd_p G ≤ 1` gives the projectivity property of Layer 5;
  2. a minimal generating tuple gives a continuous surjection `φ : F ↠ G`, from the free
     pro-`p` group on `Fin (topologicalGeneratorRankNat G h)`;
  3. projectivity gives a continuous homomorphic section `s : G → F`;
  4. the image `s(G)` is closed and maps onto `F/Φ(F)` by minimality, so `s(G) = F` by
     Burnside, and `φ` is an isomorphism.
  *Needs:* L5 projectivity; L3 Burnside; L4 free objects.
  *Source:* NSW III §5; Serre, *Galois Cohomology* I §4.2; Ribes–Zalesskii Ch. 7.
  ⚠ The version without finite generation is a different theorem with a different proof. It
  is stated in Layer 10, once free objects on a basis that converges to `1` exist.
- **`cd` of open subgroups.** For `U` open in pro-`p` `G` with `cd_p G < ∞`,
  `cd_p U = cd_p G` (`cd_p_eq_of_isOpen`).
  ⚠ The imported `ProfiniteCohomology.cd_p_eq_of_index_not_dvd` is the case of an open subgroup
  of index **prime to `p`**, which for pro-`p` `G` means `U = G`. It does not prove this
  milestone.
  *Needs:* PC-11 `cd_p_le_of_isClosed`; PC-7 closed-subgroup Shapiro; L6 dévissage.
  *Source:* Serre, *Galois Cohomology* I §3.3.
- **The Sylow equality.** Let `G` be profinite, and let `G_p` be a `p`-Sylow subgroup of `G`,
  from Layer 2. Then `cd_p G = cd_p G_p`. The route has three steps. First, prove the colimit
  description: the cohomology of a closed subgroup, with discrete coefficients, is the
  filtered colimit of the cohomology of the open subgroups containing it. That description is
  part of this milestone. Second, for open `U ⊇ G_p` the composite of corestriction after
  restriction is multiplication by `[G : U]`, and the Sylow property makes those indices prime
  to `p`. With the colimit, restriction to `G_p` is therefore injective on the cohomology of
  every discrete `p`-primary module, which gives `cd_p G ≤ cd_p G_p`. Third, Shapiro's lemma
  for the closed subgroup `G_p` gives `cd_p G_p ≤ cd_p G`. This is the one milestone here
  about `cd_p` of a group that need not be pro-`p`, and it is named `cd_p_eq_of_isProPSylow`.
  ⚠ A `p`-Sylow subgroup is closed and, unless it is open, is not covered by the imported
  `ProfiniteCohomology.cd_p_eq_of_index_not_dvd`. That theorem is the open prime-to-`p`-index
  case, and it supplies exactly the open subgroups `U ⊇ G_p` of prime-to-`p` index; the colimit
  description of the cohomology of a closed subgroup and the Sylow theory of Layer 2 are what
  turn those into the equality, and they are the part this milestone owns.
  *Needs:* L1 supernatural index; L2 Sylow existence and conjugacy; PC-10 `corestriction`,
  `corestriction_comp_res`; PC-11 `cd_p_eq_of_index_not_dvd`; PC-7 closed-subgroup Shapiro.
  *Source:* NSW (3.3.6); Serre, *Galois Cohomology* I §3.3.
- **The two-term Euler formula.** Let `G` be a topologically finitely generated pro-`p`
  group with `cd_p G ≤ 1`, and let `U ≤ G` be open. Then the four spaces
  `H^i(G, 𝔽_p)` and `H^i(U, 𝔽_p)`, for `i = 0, 1`, are finite-dimensional, and in `ℤ`

  > `finrank H⁰(U, 𝔽_p) - finrank H¹(U, 𝔽_p)
  >   = [G : U] · (finrank H⁰(G, 𝔽_p) - finrank H¹(G, 𝔽_p))`.

  Subtraction is in `ℤ` throughout, and no symbol `χ` is introduced. Finite-dimensionality
  is part of the theorem: it follows from topological finite generation of `U`, by Layer 3
  and the `H¹` interpretation of Layer 5. The proof uses Shapiro for `U`, the identification
  `Coind_U^G 𝔽_p ≅ 𝔽_p[G/U]`, the long exact sequence, the trivial-filtration theorem, and
  additivity of `finrank` along a finite exact sequence of finite-dimensional vector spaces.
  *Needs:* PC-7 Shapiro; PC-5 the long exact sequence; L6 trivial filtration; L3 Schreier bound;
  M `Module.finrank`.
- **Pro-`p` Nielsen–Schreier for open subgroups.** An open subgroup `U` of index `m` in a
  free pro-`p` group `F` of finite rank `n ≥ 1` is free pro-`p` of rank `1 + m(n - 1)`
  (`Suggested.lean`). The route is cohomological: freeness from `cd_p U ≤ cd_p F ≤ 1` and
  Serre's theorem; the rank from the two-term Euler formula with `finrank H⁰ = 1`,
  `finrank H¹(F, 𝔽_p) = n` and `finrank H¹(U, 𝔽_p) = d(U)`, which gives
  `1 - d(U) = m(1 - n)` in `ℤ`, hence `d(U) = 1 + m(n-1)` in `ℕ`. The last rearrangement is
  a separate small lemma, because that is where the natural-number statement is recovered.
  *Needs:* L6 Euler formula, L6 Serre's theorem, L6 `cd` of open subgroups.
  *Source:* Koch Example 6.3, derived the same way from his §5.4. The alternative in the
  literature is Ribes–Zalesskii Thm. 3.6.2, a Schreier-transversal argument through the
  pro-`C` completion of the abstract theorem, for extension-closed varieties. This roadmap
  takes the cohomological route, because Layers 5 to 7 build its ingredients anyway, and
  because the closed-subgroup case in Layer 10 is cohomological in any treatment.
  ⚠ Closed subgroups that are not open are Layer 10. Such a subgroup is free pro-`p` of
  possibly infinite rank, and the statement needs bases that converge to `1`. Do not state a
  truncated finite-rank version here.

### Layer 7: Demushkin groups, their invariants, and the orientation

- **The predicate.** `IsDemushkin p G` has the fields given in the conventions: `IsProP p G`,
  finite-dimensionality of `H¹(G, 𝔽_p)`, `finrank H²(G, 𝔽_p) = 1`, and nondegeneracy of
  the cup pairing on each side. Four things are derived at once:
  - `G` is topologically finitely generated, from the first two fields and Burnside;
  - the rank `n(G) := topologicalGeneratorRankNat G h`, which `Suggested.lean` packages as
    `demushkinRank`;
  - the identity `n(G) = finrank H¹(G, 𝔽_p)`;
  - `G` is a one-relator pro-`p` group, with relator in `Fᵖ[F,F]`.

  Also proved here: `IsDemushkin` is invariant under topological isomorphism. Every
  numerical statement below is about `demushkinRank`.
  *Needs:* L5 the coefficient objects and `cupFp`; L5 rank interpretations; L3 Burnside.
  *Source:* Labute p. 106.

  API checklist for `IsDemushkin`:
  - Constructors: from the four fields; from the recognition criteria below; from Layer 11
    for `G_K(p)` with `μ_p ⊆ K`.
  - Examples: `ℤ/2` at `p = 2`; `ℤ_p × ℤ_p` with `q = 0`; `D₀` at `p = 2` with `n = 3`; the
    non-examples `1`, `ℤ_p` and every free pro-`p` group.
  - Morphisms: topological isomorphisms transport the predicate; open subgroups inherit it,
    which is the open-subgroup theorem below.
  - Functoriality: the invariants `demushkinRank` and `Im (demushkinCharacter)` are
    invariant under topological isomorphism.
  - Comparison lemmas: the recognition criteria below give equivalent conditions for a
    one-relator group; the definition agrees with Labute's and with NSW (3.9.9).
  - Naturality: restriction of the canonical character to an open subgroup is the canonical
    character of that subgroup.
  - Edge cases: rank 1, where only `ℤ/2` occurs; `q = 2`, where `(n, q)` is not a complete
    invariant; finite Demushkin groups, where only `ℤ/2` occurs.
  - Downstream interfaces: the classification of Layer 9, and the arithmetic statements of
    Layer 11.
- **First examples and non-examples.** `ℤ/2` is Demushkin at `p = 2`, is the unique finite
  one, and is the unique one of rank 1; the cup square of the generator of `H¹(ℤ/2, 𝔽₂)`
  is the class of the extension `ℤ/4`. A free pro-`p` group is not Demushkin, because its
  its `H²` vanishes; this covers `1` and `ℤ_p`. The group `ℤ_p × ℤ_p` is Demushkin with
  `q = 0`, with the surface relation `(x₁, x₂)`. For odd `p` there is no Demushkin group of
  rank 1.
  *Needs:* L7 the predicate; L5 the coefficient objects.
  *Source:* Labute p. 106; Serre, *Galois Cohomology* I §4.5.
- **The abelianization structure theorem.** For Demushkin `G`,
  `G^{ab} ≅ ℤ_p^{n-1} × ℤ_p/qℤ_p`, proved from the Layer 4 structure theorem applied to
  `topAbelianization G`, together with the one-relator presentation. The torsion subgroup is
  finite and cyclic, which is what makes `demushkinQ G` well defined from the predicate
  alone: it is `0` when the torsion is trivial, and the order of the torsion otherwise.
  Worked instance: `D₀^{ab} ≅ ℤ₂² × ℤ/2`, its torsion is finite, and `q(D₀) = 2`
  (`Suggested.lean`). That instance is a computation with the presentation, and it does not
  use the classification.
  *Needs:* L4 structure theorem; L5 presentations; L7 the predicate.
  *Source:* Labute p. 106.
- **The canonical character.** For `dim H¹(G, 𝔽_p) < ∞` the three prescription conditions
  of the conventions are equivalent, and a free pro-`p` group satisfies them for every `χ`.
  **Theorem.** A Demushkin group has exactly one continuous `χ : G → ℤ_pˣ` with the
  prescription property. Define `demushkinCharacter G` to be that character. Prove that its
  image is closed, and that it is invariant under topological isomorphism; the second
  statement is the transport lemma that the acceptance instances use. Prove
  `Im χ = 1 + q(G)ℤ_p` only in the case `q(G) ≠ 2`. For `q(G) = 2` keep `Im χ` as a separate
  invariant, and do not recover `q` from a containment.
  *Needs:* L5 the coefficient objects; PC-1 `coeffMap`; L7 the predicate; L4 `ℤ_p` chain.
  *Source:* Labute Prop. 6 and Thm 4.
- **The closed subgroups of `ℤ₂ˣ`.** This item is `ℤ_pˣ`-theory, with no cohomology. Named
  definitions first, for `f : ℕ∞` with `f ≥ 2`:
  - `U^(f) := 1 + 2^f ℤ₂`, with `U^(∞) = {1}`;
  - `V^(f) := {±1} × U^(f)`, the subgroup generated by `-1` and `U^(f)`, with
    `V^(∞) = {±1}`;
  - `U^[f] := closure ⟨-1 + 2^f⟩` for `2 ≤ f < ∞`.

  Then:
  - **Exhaustiveness and uniqueness.** Every nontrivial closed subgroup of `ℤ₂ˣ` is exactly
    one of `U^(f)` for `2 ≤ f < ∞`, `V^(f)` for `2 ≤ f ≤ ∞`, and `U^[f]` for `2 ≤ f < ∞`,
    and no two entries of that list are equal. `U^(∞) = {1}` is trivial, so it is not in the
    list, although it is a legitimate value of the `f = ∞` convention elsewhere: it is the
    image of `χ` for a free pro-`2` group. Route: `ℤ₂ˣ = {±1} × (1 + 4ℤ₂)`, with
    `1 + 4ℤ₂ ≅ ℤ₂` through the logarithm, so the closed subgroups of the second factor are
    the `1 + 2^fℤ₂`; the three families are the three ways a closed subgroup sits over
    `{±1}`. In `Suggested.lean` the families are indexed by `f : ℕ`, and the members at
    `f = ∞` are written separately, because an `ℕ∞`-indexed definition would carry a junk
    value at `∞`.
  - **Procyclicity.** `U^(f)` and `U^[f]` are procyclic. `V^(f)` with `f < ∞` is not,
    because its Frattini quotient is `(ℤ/2)²`. Equivalently, a closed subgroup is procyclic
    if and only if it does not contain `-1` together with a nontrivial element of `1 + 4ℤ₂`;
    that is the form in `Suggested.lean`.
  - **Indices and intersections.** `profiniteIndex U^(f) ℤ₂ˣ = 2^{f-1}`,
    `profiniteIndex V^(f) ℤ₂ˣ = 2^{f-2}`, `profiniteIndex U^[f] ℤ₂ˣ = 2^{f-1}`, and
    `U^[f] ∩ (1 + 4ℤ₂) = U^(f+1)`. For the last one, the generator `g = -1 + 2^f` has
    `g² = 1 - 2^{f+1}u` with `u = 1 - 2^{f-1}` odd, so the even powers of `g` are exactly
    `U^(f+1)`, and that intersection is what gives the index. In the notation of Layer 8,
    `(A : A²) = 2` for `U^(f)` and for `U^[f]`, and `(A : A²) = 4` for `V^(f)` with
    `f < ∞`. Check these at `f = 2, 3, 4` by squaring: a shift of one in this exponent
    changes the parametrization of the whole `q = 2` classification.
  - **Odd `p`.** For odd `p`, `ℤ_pˣ ≅ μ_{p-1} × (1 + pℤ_p)`, and the closed subgroups of
    `1 + pℤ_p` are exactly the `1 + p^fℤ_p`. The proof uses the `p`-adic logarithm with its
    domain restricted to `1 + pℤ_p`, where it is an isomorphism of topological groups onto
    `pℤ_p`. The restriction of the domain is part of the statement: the logarithm does not
    converge on all of `ℤ_pˣ`.
  - **Which subgroups occur as images.** For each normal form of Layer 9, the closed
    subgroup generated by the character values on the normal-form basis, computed
    explicitly. Layer 11 reads its instances from this table.

  *Needs:* L1 index; M `PadicInt`, M `PadicInt.toZModPow`, M the `p`-adic logarithm.
  *Source:* the remark after the corollary to Labute Thm 4.

#### Demushkin duality, concretely

A general theory of profinite duality groups, dualizing modules and `PD^n` is not built
here, and the terms do not occur in any milestone. What Layers 9 and 11 use is a small
package of statements about finite discrete modules, and that package is stated here.

- **Dimension two.** An infinite Demushkin group has `cd_p G = 2`
  (`cd_p_eq_two_of_isDemushkin`). Route: `≤ 2` from the one-relator presentation and the
  five-term sequence; `≥ 2` from `H²(G, 𝔽_p) ≠ 0`, which is part of the definition.
  *Needs:* L6 `cd_p`; PC-6 `transgression`, `fiveTerm_exact_H1N`, `fiveTerm_exact_H2Q`; L7 the
  predicate.
  *Source:* Tate, in Serre, *Structure de certains pro-p-groupes*, §9.1.
- **The trace isomorphism.** Fix the isomorphism `tr : H²(G, 𝔽_p) ≅ 𝔽_p` determined by a
  choice of nonzero element. The choice is unique up to `𝔽_pˣ`; name a generator, and record
  that the statements below do not change under rescaling. Every pairing below is normalized
  through `tr`.
  *Needs:* L7 the predicate.
- **The perfect pairings that are used.** For each `i ≥ 1` and each finite discrete
  `p`-primary `G`-module `M` in the coefficient system `I(χ)/p^i` of the canonical
  character, the cup pairing
  `H^j(G, M) × H^{2-j}(G, M^∨(χ)) → H²(G, I(χ)/p^i) ≅ ℤ/p^i` is a perfect pairing
  of finite abelian groups for `j = 0, 1, 2`, where `M^∨(χ) := Hom(M, I(χ)/p^i)` carries the
  diagonal action. Only the modules of that system are claimed, because only they are used.
  There is no unqualified statement about all finite discrete modules in this roadmap.
  *Needs:* L5 the coefficient objects and `cupFp`; L7 trace and canonical character.
  *Source:* Serre, *Structure de certains pro-p-groupes*, §9.
- **Naturality.** Compatibility of the pairings with restriction to an open subgroup and
  with corestriction, in the form `⟨res a, b⟩_U = ⟨a, cor b⟩_G`. These are the two
  compatibilities that the open-subgroup theorem uses.
  *Needs:* L5 change-of-group maps; L7 the pairings.
- **The role of the character.** For `i ≤ i'` the transition maps of the system
  `(I(χ)/p^i)_i` are `G`-equivariant, and the induced action on the compatible system of
  duals `Hom(𝔽_p, I(χ)/p^i)` is by `χ` modulo `p^i`. This is the precise sense in which `χ`
  controls the duality. The inverse limit `ℚ_p/ℤ_p` is not a coefficient module of any
  statement here.
  *Needs:* L7 canonical character; L5 the coefficient objects.
- **The three-term Euler formula.** For `G` topologically finitely generated pro-`p` with
  `cd_p G ≤ 2`, **with `H^i(G, 𝔽_p)` finite-dimensional for `i = 0, 1, 2`**, and `U ≤ G`
  open: the six spaces are finite-dimensional and, in `ℤ`,
  `Σ_{i=0}^{2} (-1)^i finrank H^i(U, 𝔽_p)
   = [G : U] · Σ_{i=0}^{2} (-1)^i finrank H^i(G, 𝔽_p)`.
  The proof has the shape of the two-term case, one degree longer, with the same inputs:
  Shapiro, the long exact sequence, and the trivial-filtration theorem of Layer 6.
  Finiteness for `U` is part of the conclusion and follows from the hypothesis for `G`
  through Shapiro; finiteness for `G` is a hypothesis, and not a consequence. Substituting
  `finrank H⁰ = finrank H² = 1` for a Demushkin group gives the rank formula.
  ⚠ Topological finite generation bounds `H⁰` and `H¹` only. It does not bound `H²`, whose
  dimension is the relation rank, so the finiteness hypothesis is not redundant: a
  topologically finitely generated pro-`p` group need not be finitely presented. For a
  Demushkin group the hypothesis holds, since `dim H² = 1` is part of the definition, and
  that is the case the open-subgroup theorem uses.
  *Needs:* PC-7 Shapiro; PC-5 the long exact sequence; L6 trivial filtration.
- **The open-subgroup theorem.** For `G` infinite Demushkin and `U ≤ G` open: `U` is
  Demushkin; `n(U) - 2 = [G : U](n(G) - 2)` in `ℤ`; and
  `demushkinCharacter U = (demushkinCharacter G) ∘ (inclusion U)`. Route: `cd_p U = 2` from
  Layer 6; `finrank H²(U, 𝔽_p) = 1` from the perfect pairing and naturality; nondegeneracy
  on `U` likewise; then the three-term Euler formula below.
  *Needs:* L6 `cd` of open subgroups; L7 pairings and naturality; L7 Euler formula.
  *Source:* Serre, *Structure de certains pro-p-groupes*, §9.2.
  ⚠ The hypothesis "infinite" is used: `ℤ/2` is Demushkin and finite, and the rank formula
  fails for it.
- **Recognition criteria.** For a topologically finitely generated one-relator pro-`p` group
  `G` with `n(G) > 1`, the following are equivalent:
  1. `G` is Demushkin;
  2. `cd_p G = 2` and `finrank H²(N, 𝔽_p) = 1` for every open normal `N ≤ G`;
  3. `cd_p G = 2` and `n(N) - 2 = [G : N](n(G) - 2)` in `ℤ` for every open normal `N ≤ G`.

  The sharpened forms, in which `N` ranges only over the open normal subgroups of index `p`,
  are separate statements with the same proof. Layer 11 applies these criteria to `G_K(p)`.
  *Needs:* L7 open-subgroup theorem; L6 `cd`.
  *Source:* NSW (3.9.15), due to Andozhskii and to Dummit–Labute. NSW also lists an
  equivalent condition phrased through a dualizing module; that formulation needs vocabulary
  this roadmap does not define, so it is not among the equivalences here.

### Layer 8: the central-tower comparison method and finite-quotient determinacy

This layer states the classification method as a theorem about a finite inverse system, and
not as a description of a technique. Two pro-`p` groups are compared through the finite
quotients of the lower `p`-series, and the comparison is then assembled. Nothing in this
layer is cohomological.

#### Notation, fixed for Layers 8 and 9

Every symbol used in the two hardest layers is declared here. Where Labute's indexing
differs, the translation is stated once.

- `λ_k := pLowerCentralSeries p G k`, 0-based: `λ_0 = G` and
  `λ_{k+1} = closure (λ_kᵖ ⬝ [λ_k, G])`. Labute's `F_i` is 1-based with `F_1 = F`, so his
  `F_i` is our `λ_{i-1}`, and his `F_3`, the modulus of the normal-form congruences, is our
  `λ_2`. Every Labute index below is translated in place.
- `gr_k(G) := λ_k / λ_{k+1}`, a profinite elementary abelian `p`-group, that is a profinite
  `𝔽_p`-vector space, written additively; `Suggested.lean` names it `gradedPiece` and takes
  `Additive` of the group quotient, so that the additive notation of this layer is the Lean
  notation too. Normality of `λ_{k+1}` inside `λ_k` is a milestone of this layer, and it is a
  hypothesis of every statement about `gradedPiece`. `gr(G) := ⨁_{k ≥ 0} gr_k(G)`.
  ⚠ `gr_k(G)` is **finite** only under topological finite generation, and that is a theorem:
  `IsTopologicallyFinitelyGenerated G → Finite (gr_k G)`, proved from openness of
  `λ_{k+1}`. Without it the statement is false, since `G = ∏_I C_p` with `I` infinite has
  `λ_1(G) = 1` and `gr_0(G) = G`. Every span statement, basis correction and dimension count
  below is therefore stated for a free pro-`p` group of finite rank, or for another group
  that is explicitly topologically finitely generated.
- The **bracket** `gradedBracket : gr_j × gr_k → gr_{j+k+1}`, induced by the group commutator;
  the degree shifts by one because the indexing is 0-based, since `[λ_j, λ_k] ≤ λ_{j+k+1}`. The
  **`p`-power operator** `gradedPow : gr_k → gr_{k+1}` is `π(x λ_{k+1}) = x^p λ_{k+2}`. Both are
  named maps and not existence statements, and each carries its defining equation on classes,
  `gradedBracket_mk` and `gradedPow_mk`; the two degree-raising membership statements
  `commutator_mem_pLowerCentralSeries` and `pow_mem_pLowerCentralSeries` are what make them well
  defined. The laws are `gradedBracket_bilinear`, `gradedBracket_alternating`,
  `gradedBracket_jacobi`, `gradedPow_add_of_pos` and `gradedPow_add_of_odd`; a continuous
  homomorphism induces `gradedMap`, compatible with both operations by `gradedBracket_natural`
  and `gradedPow_natural`. The operator `π` commutes with scalars, and it is additive in every
  degree except degree zero at `p = 2`.
  *Source:* Labute Prop. 1 and Prop. 2, in our indexing.
- **`π` against the bracket, and the dyadic failure.** For every `p` the bracket is
  `π`-bilinear away from degree zero: `π[x, y] = [πx, y] = [x, πy]` for `x ∈ λ_j` and
  `y ∈ λ_k` with `j, k ≥ 1`, all three terms lying in `gr_{j+k+2}`. The group identities
  behind this are `[x², y] = [x, y]²·[[x, y], x]` and `[x, y²] = [x, y]²·[[x, y], y]`, whose
  correction terms have degrees `2j + k + 2` and `j + 2k + 2`, so they vanish in
  `gr_{j+k+2}` unless the corresponding argument has degree zero. For odd `p` the operator
  `π` is additive as well, because the Hall–Petrescu corrections carry coefficients
  `binom(p, i)` that are divisible by `p`, and the degree-zero corrections vanish too; hence
  `gr(G)` is a graded Lie algebra over `𝔽_p[π]`, with `π` of degree one.
  **For `p = 2` additivity fails in degree zero.** The exact failure is
  `π(x + y) = π(x) + π(y) + [x, y]` in `gr_1(G)`, for `x, y ∈ gr_0(G)`, which is the
  `binom(2, 2)` term of the Hall–Petrescu expansion. That equation is the milestone
  `gradedPow_add_zero_dyadic`, stated literally and not as a description. In degree zero the bracket identities
  also acquire the correction `[πx, y] = π[x, y] + [[x, y], x]`, and its mirror image. So
  `gr(F)` for free pro-`2` `F` is not an `𝔽_2[π]`-Lie algebra. The milestones are proofs of
  these identities, `gradedPow_bracket_left` and `gradedPow_bracket_right` away from degree
  zero, with a witness that the failure is not vacuous: in `F` free pro-`2` of rank 2,
  `[x̄₁, x̄₂] ≠ 0` in `gr_1(F)`, which is `gradedBracket_freeProP_two_ne_zero`, so `π` is not
  additive on `gr_0(F)`. Every `q = 2` argument downstream has this shape.
  *Needs:* L8 the graded object; M the commutator identities.
- **Openness and cofinality** (`Suggested.lean`). In a topologically finitely generated
  pro-`p` group every `λ_k` is open, by induction, and the series is a neighbourhood basis
  of `1`, so `G ≅ lim_k G/λ_k` with finite `p`-group levels and any comparison runs level by
  level. Each `λ_k` is closed, normal and characteristic, with `λ_{k+1} ≤ λ_k`. A continuous
  homomorphism satisfies `f(λ_k(G)) ≤ λ_k(H)`, with equality when `f` is surjective.
  *Needs:* L3 Frattini theory and finite generation; L0 inverse limits.
  *Source:* Ribes–Zalesskii Prop. 2.8.13 states the same for the iterated Frattini series;
  prove it for both series, because they interleave.
- **`δ_j`, the basis-modification maps.** Let `F = freeProP p (Fin n)` with basis
  `x_1, …, x_n`, and let `r ∈ λ_1(F)` be a relator; `R` is the closed normal subgroup
  generated by `r`, and `R_j := R ∩ λ_j(F)`. Modifying the basis by `x_i ↦ x_i w_i` with
  `w_i ∈ λ_{j-1}(F)`, for `j ≥ 1`, moves `r` inside its coset by an element of `λ_j(F)`
  whose class in `gr_j(F)` depends only on the classes `w̄_i ∈ gr_{j-1}(F)`. That map is
  `δ_j : gr_{j-1}(F)^{⊕ n} → gr_j(F)`,
  `δ_j(w̄_1, …, w̄_n) = Σ_i [w̄_i, ∂_i r̄] + Σ_i c_i π(w̄_i)`,
  where `r̄ ∈ gr_1(F)` is the class of the relator, `∂_i r̄ ∈ gr_0(F)` is the coefficient of
  `x_i` in the commutator part of `r̄`, and `c_i ∈ 𝔽_p` is the coefficient of `x_i^p` in the
  `p`-power part. Both terms land in `gr_j(F)`: the bracket raises the degree by
  `0 + (j - 1) + 1`, and `π` raises it by one. The image `Im δ_j ≤ gr_j(F)` is the subspace
  in the span statements of Layer 9. Linearity holds in the degrees the span statements use,
  and fails in one case:
  - for `j ≥ 2` the map `δ_j` is `𝔽_p`-linear, because `π` is additive above degree zero;
  - for `j = 1` at `p = 2` with some `c_i ≠ 0`, which is the case of the `q = 2` relators,
    the inputs lie in `gr_0(F)`, where `π(x + y) = π(x) + π(y) + [x, y]`, so `δ_1` is
    quadratic and not additive. Its polarization is
    `δ_1(v + w) - δ_1(v) - δ_1(w) = Σ_i c_i [v_i, w_i]`, and every statement that uses
    `δ_1` at `p = 2` is stated against that corrected map.

  The milestones are well-definedness of `δ_j`, linearity for `j ≥ 2`, the polarization
  identity at `j = 1`, and the explicit formula at a relator in normal form.
  *Needs:* L8 the graded object; L4 free objects.
  *Source:* Labute Prop. 5, in our indexing.
  API checklist for `pLowerCentralSeries` and `gr`:
  - Constructors: the series itself; the class of an element in `gr_k`; the bracket and the
    operator `π`.
  - Examples: `λ_1(G) = Φ(G)`; `gr_0(G) = G/Φ(G)`; `gr(F)` for `F` free pro-`p` of rank `n`,
    where `gr_1(F) ≅ Λ²(𝔽_p^n) ⊕ 𝔽_p^n`.
  - Morphisms: a continuous homomorphism induces a graded map; a continuous surjection
    induces a surjection in each degree.
  - Functoriality: `f(λ_k(G)) ≤ λ_k(H)`, with equality for a continuous surjection; each
    `λ_k` is characteristic.
  - Comparison lemmas: the interleaving with the iterated Frattini series; agreement with
    Mathlib's `lowerCentralSeries` on the commutator part.
  - Naturality: bracket and `π` commute with the induced maps.
  - Edge cases: `p = 2` in degree zero, where `π` is not additive; a group that is not
    topologically finitely generated, where `λ_k` need not be open.
  - Downstream interfaces: `δ_j` and `T_j` below; the comparison schema; the span statements
    of Layer 9.

- **The tails `T_j`.** For `p = 2` the span statements use one further subspace. `T_j` is
  spanned by the iterated `p`-powers `π^j(x̄_i) ∈ gr_j(F)`, over the indices `i` with
  `c_i = 0`, that is over the generators whose exponent in the `p`-power part of the relator
  is not exactly `p`, and which therefore contribute no `π`-term to `δ_j`. For
  `r = x₁²x₂^{2^f}(x₂, x₃)⋯` with `f ≥ 2` these are `x₂, …, x_n`, because `π^f(w̄)` lands in
  `gr_{j+f-1}`, which is above the relevant degree.
  *Needs:* L8 the graded object and `δ_j`.
- **`(A : A²)` and the parameters of the normal forms.** `A ≤ ℤ_pˣ` always denotes a closed
  subgroup, `A²` the closed subgroup of squares, and `(A : A²)` the index
  `profiniteIndex A² A`, which is `1`, `2` or `4` for the closed subgroups of `ℤ₂ˣ`, proved
  from the Layer 7 trichotomy. The parameters of the normal forms are these:
  - `n ≥ 1` is the rank;
  - `f` ranges over `2 ≤ f < ∞` together with `f = ∞`, encoded as `f : ℕ∞` with
    `U^(∞) = {1}` and `2^∞ = 0` in the exponent, so that `x^{2^f}` means `x^0 = 1` at
    `f = ∞`;
  - `α ∈ 4ℤ₂` is a `2`-adic integer with `v₂(α) ≥ 2`, where `α = 0` is allowed and
    `v₂(0) = ∞`;
  - `N` is `n/2`, the number of commutator pairs in an even-rank form.

  Each classification statement repeats the ranges that it uses.
  *Needs:* L7 the trichotomy; L1 index.

#### Finite-quotient determinacy

- **Occurring as a quotient.** `IsFiniteContinuousQuotient G Q`, for a finite group `Q`,
  says that there is a surjection `f : G →* Q` with open kernel (`Suggested.lean`). Phrasing
  it through the kernel, and not through a topology on `Q`, lets statements quantify over
  `Q` bundled as a `FiniteGrp`, and not over arbitrary types with an unspecified topology.
  For a finite discrete `Q` the two conditions agree, and that agreement is a lemma here.
  Also proved here: the predicate depends only on the isomorphism class of `Q`, and only on
  the topological isomorphism class of `G`.
  *Needs:* L0 open subgroups; M `FiniteGrp`.
- **Two epimorphisms.** If `G` is topologically finitely generated, and `G` and `H` have the
  same continuous finite quotients, then there are continuous surjections `G ↠ H` and
  `H ↠ G`. The route has five steps:
  1. `H` is topologically finitely generated, because each of its finite quotients is a
     finite quotient of `G` and so needs at most `d(G)` generators;
  2. for each open normal `N ≤ G` the set `E(N)` of continuous surjections `H ↠ G/N` is
     nonempty, by hypothesis, and finite, by step 1;
  3. for `N' ≤ N` let `E(N', N) ⊆ E(N)` be the image of `E(N')` under composition with
     `G/N' ↠ G/N`; these decrease as `N'` decreases, and each is nonempty and finite, so
     they stabilize at a nonempty set `E∞(N)`;
  4. the `E∞(N)` form an inverse system whose bonding maps **are** surjective, by
     construction, and each is a nonempty finite set;
  5. the Layer 0 compactness lemma gives a compatible family, hence the surjection `H ↠ G`;
     the other direction is symmetric once step 1 is available.

  *Needs:* L0 compactness lemma; L3 finite generation and the Burnside rank bound.
  ⚠ The raw bonding maps on `E(N)` are **not** surjective, so step 3 is not decoration.
  Counterexample: `H = C₄ × C₂` surjects onto `C₂` by the second projection, and that
  surjection does not factor through `C₄ ↠ C₂`, although `H` does surject onto `C₄`.
- **The isomorphism theorem, sharp form.** If `G` is topologically finitely generated, and
  `G` and `H` have the same continuous finite quotients, then `G ≅ H` as topological groups,
  with **no finite-generation hypothesis on `H`**. The route has three steps:
  1. the two epimorphisms give `φ : G ↠ H` and `ψ : H ↠ G`;
  2. `ψ ∘ φ : G ↠ G` is surjective, hence an isomorphism by the Hopf property of Layer 3,
     which needs finite generation of `G` only;
  3. therefore `φ` is injective, and a continuous bijection of compact Hausdorff groups is a
     topological isomorphism.

  Finite generation of `H` is a conclusion, and not a hypothesis. If the two-epimorphism step is
  easier with both hypotheses, state that weaker lemma first, and then the argument that
  removes the second hypothesis.
  *Needs:* L8 two epimorphisms; L3 Hopf property.
  *Source:* Fried–Jarden; Ribes–Zalesskii Thm. 3.2.9.
- **Corollary.** Finitely generated abstract groups with the same finite quotients have
  topologically isomorphic profinite completions.
  *Needs:* L8 the isomorphism theorem; M `ProfiniteGrp.profiniteCompletion`.
  *Source:* Dixon–Formanek–Poland–Ribes 1982; Ribes–Zalesskii Cor. 3.2.8.

#### The levelwise comparison schema

The reusable form of the tower method. The data are:

- topologically finitely generated pro-`p` groups `G` and `H`;
- for each `k : ℕ`, a **finite** type `S k` of level-`k` comparison data;
- realization maps `ρ_k : S k → (G/λ_k → H/λ_k)`, landing in continuous surjective
  homomorphisms;
- bonding maps `β_k : S (k+1) → S k`, each surjective, with each `S k` nonempty;
- compatibility: for every `s : S (k+1)` the square built from `ρ_{k+1} s`, `ρ_k (β_k s)`
  and the two projections commutes.

**Theorem.** Under these hypotheses there is a continuous surjection `Φ : G ↠ H`, and an
element `s∞` of `lim_k S k`, such that `Φ` induces `ρ_k (s∞)_k` on each level. Proof: the
inverse limit of a system of nonempty finite sets with surjective bonding maps is nonempty,
by Layer 0; compatibility makes the induced level maps assemble; surjectivity passes to the
limit by compactness.

*Needs:* L0 compactness lemma; L8 openness and cofinality of the lower `p`-series.

The side conditions of an application, such as prescribed values on marked generators or a
constraint from a character, are carried in the type `S k` itself. An application chooses
`S k` to be the set of level-`k` comparisons that satisfy the conditions, so the hypotheses
to discharge are nonemptiness and surjectivity of the bonding maps. A predicate on the
inverse limit may be imposed as an extra hypothesis, in which case it must be given as a
compatible family of predicates on the `S k`.

Two applications are immediate corollaries:

- the two-sided version, where data in both directions, together with the Hopf property,
  give `G ≅ H`;
- the specialization used in Layer 9, where `S k` is the set of level-`k` basis changes that
  carry one Demushkin relator to another and respect the character.

### Layer 9 prerequisites: two owned inputs

Both are needed by Labute's proof, neither is in Mathlib, and neither is supplied by another
roadmap. They are built here, before the classification, and they are useful on their own.

#### Bilinear forms over `𝔽_p`, including the characteristic-two nonalternating case

Index conventions:

- `V` is a finite-dimensional `𝔽_p`-vector space;
- `b : V →ₗ[𝔽_p] V →ₗ[𝔽_p] 𝔽_p` is a bilinear form, written `b x y`;
- matrices are taken with respect to an ordered basis `e` by `B_{ij} = b (e i) (e j)`, so a
  change of basis `e' = e ⬝ P` acts by `B' = Pᵀ B P`.

- **Basics.** The left and right radicals of `b`; left and right nondegeneracy, which agree
  for finite-dimensional `V`; transport of a form along a linear equivalence, and the
  resulting notion of equivalence of forms.
  *Needs:* M `LinearMap.BilinForm` and its radical API.
- **Alternating, skew-symmetric, symmetric.** `IsAlternating b := ∀ x, b x x = 0`. Expanding
  `b (x + y) (x + y) = 0` shows that alternating implies skew-symmetric, that is
  `b y x = - b x y`, in every characteristic. It does not imply symmetric, except at `p = 2`,
  where skew-symmetric and symmetric are the same condition. At `p = 2` the two conditions
  differ exactly by the diagonal, and `x ↦ b x x` is then `𝔽_2`-semilinear, since it is
  additive with `b (cx) (cx) = c² b x x`. For odd `p` a form that is both symmetric and
  alternating is zero. The forms that occur at odd `p` in this roadmap are the alternating
  ones, because the cup pairing on `H¹(G, 𝔽_p)` is graded-commutative, so `a ∪ a = 0` once
  `2` is invertible.
  *Needs:* L9 basics; L5 `cupFp` and its graded commutativity.
- **Symplectic normal form.** A nondegenerate alternating form on `V` has a basis in which
  the matrix is block diagonal with blocks `[[0, 1], [-1, 0]]`, so `dim V` is even. Stated
  for every `p`, including `p = 2`.
  *Needs:* L9 basics.
  *Source:* standard; Ribes–Zalesskii and NSW use it in this form.
- **Characteristic two, nonalternating.** For `p = 2` and `b` symmetric, nondegenerate and
  not alternating, there is a basis in which the matrix is the identity. Such forms exist in
  every dimension, odd and even, and any two of the same dimension are equivalent. With the
  previous item this is the complete classification of nondegenerate symmetric bilinear
  forms over `𝔽_2`.
  *Needs:* L9 basics.
- **The change-of-basis theorem that Layer 9 uses.** Let `b` be nondegenerate on `V` of
  dimension `n`, and either alternating for any `p`, or symmetric with `p = 2`. Then there
  is a basis in which `B` is one of two matrices:
  - the symplectic block form, if `b` is alternating, and then `n` is even;
  - the identity, if `p = 2` and `b` is symmetric and not alternating, and then `n` is
    arbitrary.

  These are the only two cases that the classification produces. The statement records which
  case each Demushkin normal form falls into, so that the odd-dimensional case at `p = 2` is
  covered explicitly.
  *Needs:* L9 the two normal forms.
  ⚠ Nondegenerate symmetric nonalternating forms in odd characteristic, which are
  diagonalizable and classified by their discriminant, are not part of this prerequisite. No
  cup form of a Demushkin group at odd `p` is one, and nothing below uses them.
- **From the cup matrix to the relator.** Given a relator `r ∈ λ_1(F)` for
  `F = freeProP p (Fin n)`, the coefficients of `r̄ ∈ gr_1(F)` in the standard basis of
  `gr_1(F) ≅ Λ²(𝔽_p^n) ⊕ 𝔽_p^n`, that is in the commutator part and the `p`-power part, are
  the entries `a_{ij}` of the cup matrix off the diagonal, and `(q choose 2) a_i` on it. A
  basis change `P` acts on those coefficients by `B ↦ PᵀBP`, so a normal form for `B` gives
  a relator congruent modulo `λ_2(F)` to the corresponding normal-form word. The hypotheses
  are the two cases above: `B` is alternating exactly when the diagonal entries all vanish,
  which is automatic for odd `p`, and which at `p = 2` holds exactly when `q ≠ 2`; so the
  symmetric nonalternating case is exactly `p = 2` with `q = 2`.
  *Needs:* L9 change-of-basis theorem; L8 the graded object; L5 `cupFp`.
  *Source:* Labute Prop. 3.

#### The completed group algebra of the orientation image

Labute's §1.5 and §4 arguments run over `Λ = ℤ_p[[Γ]]` for `Γ = Im χ`. Two shapes of `Γ`
occur in the dyadic classification, and both are needed:

- `Γ` procyclic, which covers `Im χ = 1 + qℤ_p` for `q ≠ 2` and the branch `Im χ = U^[f]`;
- `Γ ≅ C₂ × ℤ₂`, which is the branch `Im χ = V^(f) = {±1} × U^(f)` with `f < ∞`, and which
  Layer 7 proves is not procyclic.

The package below is stated for the procyclic case first, and then extended to the second
shape. Citing the procyclic package for `V^(f)` is the mistake to avoid: that branch is one
of the two even-rank families, and it carries the orientation images of local fields.

- **The algebra.** For a profinite group `Γ` and a prime `p`,
  `completedGroupAlgebra p Γ := lim_U ℤ_p[Γ/U]` over the open **normal** subgroups `U ≤ Γ`,
  with the inverse-limit topology; the subgroups are normal because `Γ/U` has to be a group for
  `ℤ_p[Γ/U]` to be a group algebra. It is a compact topological `ℤ_p`-algebra: `Ring`,
  `Algebra ℤ_[p]`, `TopologicalSpace`, `IsTopologicalRing`, `CompactSpace` and
  `TotallyDisconnectedSpace` are all part of the milestone. **It is commutative exactly when
  `Γ` is abelian**, which is the case in every use below, since `Γ = Im χ ≤ ℤ_pˣ`; that is
  `completedGroupAlgebra_mul_comm`, stated as an equation rather than as a second ring
  structure. The finite-level projections `completedGroupAlgebra.proj` land in the group algebra
  of `Γ/U` and are surjective, and `Λ` is separated, which together are the inverse-limit
  description. The group elements sit inside `Λ` through
  `completedGroupAlgebra.of : Γ →* Λˣ`, which is continuous. Functoriality is
  `completedGroupAlgebra.map` with `map_id`, `map_comp`, `map_of` and `map_surjective`.
  *Needs:* L0 inverse limits; M `MonoidAlgebra`, M `PadicInt`.

  API checklist for `completedGroupAlgebra`:
  - Constructors: the limit definition; `of` on a group element; the structure map from `ℤ_p`.
  - Examples: `Γ = ℤ_p`, where the algebra is `ℤ_p[[T]]`; `Γ` finite, where it is the finite
    group algebra, which `proj` at `U = 1` records.
  - Morphisms: continuous `ℤ_p`-algebra homomorphisms; evaluation at an element of the
    maximal ideal.
  - Functoriality: `map` for a continuous homomorphism, surjective for a surjection.
  - Comparison lemmas: the power-series coordinate below; `proj_of` at each finite level.
  - Naturality: the power-series coordinate depends on the chosen topological generator, and
    the dependence is the substitution recorded below.
  - Edge cases: the trivial group; a finite procyclic `Γ`, where the truncated statement
    holds and which the classification does not use; a non-abelian `Γ`, where the algebra is
    not commutative and the coordinate does not apply.
  - Downstream interfaces: the module statements of Labute Thms 5 and 6, used in Layer 9.
- **Compact modules.** `IsCompactModule p Γ M` is the predicate on a topological
  `Λ`-module saying that it is a topological additive group with continuous scalar action,
  compact and totally disconnected; for a module over a compact ring that is the same as being
  separated and complete, and it is what the inverse-limit description needs. The milestones
  are separatedness (`IsCompactModule.eq_zero_of_mem_open`), surjectivity of the transition maps
  between quotients by open submodules, stability of the predicate under quotients by closed
  submodules, and the exactness statement `compactModule_limit_surjective`: along a tower with
  surjective transition maps and levelwise surjective comparison maps between compact levels, a
  compatible family downstairs lifts. Without surjectivity of the transition maps that last
  statement is false, so it is a hypothesis and not decoration.
  *Needs:* L9 the algebra; L0 inverse limits.
- **Power-series coordinates.** For a chosen topological generator `γ` of `Γ ≅ ℤ_p`, the
  assignment `T ↦ γ - 1` extends to an isomorphism of `ℤ_p`-algebras
  `ℤ_p[[T]] ≅ completedGroupAlgebra p Γ`, named
  `completedGroupAlgebra.powerSeriesCoordinate`, with its defining value
  `powerSeriesCoordinate_X`. The dependence on `γ` is part of the statement: a different
  generator changes the isomorphism by the substitution `T ↦ (1+T)^u - 1` with `u ∈ ℤ_pˣ`, and
  every statement below is invariant under it.
  `PowerSeries` carries no topology at the pin, so the topological half of the coordinate is
  stated as `powerSeriesCoordinate_filtration`, the identification of the `X`-adic filtration
  with the kernels of the finite-level projections, which is exactly what the inverse-limit
  topology is.
  *Needs:* L9 the algebra; M `PowerSeries`.
  *Source:* Labute §1.5.
- **Evaluation.** For `ψ ∈ ℤ_p[[T]]` and `c` with `v_p(c) ≥ 1`, the evaluation `ψ(c) ∈ ℤ_p`
  converges, and `ψ ↦ ψ(c)` is a `ℤ_p`-algebra homomorphism (`powerSeriesEval`, with
  `powerSeriesEval_add_mul` and the defining values `powerSeriesEval_X_C`). The convergence
  hypothesis `v_p(c) ≥ 1` is carried in every statement.
  *Needs:* M `PowerSeries`, M `PadicInt` completeness.
- **Division.** For `ψ ∈ ℤ_p[[T]]` and `c` with `v_p(c) ≥ 1`, `(T - c) ∣ ψ` in `ℤ_p[[T]]` if
  and only if `ψ(c) = 0`, in both directions, with the quotient given by the explicit
  series (`powerSeries_sub_C_dvd_iff`). This is the special case of Weierstrass division that
  Labute uses on p. 122; the general Weierstrass preparation theorem is not a target. It is the
  step that produces the basis correction of Layer 9.
  *Needs:* L9 evaluation.
  *Source:* Labute §4, p. 122.
- **The dyadic branch `Γ ≅ C₂ × ℤ₂`.** The same package for the second shape, by either of
  two routes, and the roadmap takes the first:
  1. *Direct.* `completedGroupAlgebra 2 Γ ≅ ℤ₂[C₂][[T]]`
     (`completedGroupAlgebra.dyadicCoordinate`), with `T = γ - 1` for a topological generator
     `γ` of the `ℤ₂`-factor. The coefficient ring is the group ring of `C₂` over `ℤ₂`, and `C₂`
     is `Multiplicative (ZMod 2)`, a genuine cyclic group. ⚠ It is **not** `ZMod 2` read as a
     multiplicative monoid, whose monoid algebra is a different ring.
  2. *By descent.* Restrict to the open procyclic subgroup `U^(f) ≤ Γ` of index 2, apply the
     procyclic package there, and descend along the `C₂`-action.

  After inverting `2` the group ring splits into the two eigenspaces of the involution, through
  the idempotents `(1 ± σ)/2`, and each eigenspace of the power-series ring over it is again a
  power-series ring; that is `monoidAlgebraRatPadicCyclicTwoEquiv`. ⚠ **There is no integral
  splitting.** The idempotents use `1/2`, so `ℤ₂[C₂]` does not decompose: its only idempotents
  are `0` and `1`, which is `monoidAlgebraPadicIntCyclicTwo_isIdempotentElem`. Claiming a direct
  product decomposition over `ℤ₂` is the error that statement rules out, and the Layer 9 basis
  corrections are read in the `ℚ₂`-eigenspaces and then cleared of denominators.
  *Needs:* L9 the procyclic package; L7 the closed subgroups of `ℤ₂ˣ`; L1 index.
  *Source:* Labute §4, p. 122, where the two even-rank families are treated separately.

#### Labute's relation module

The module Labute's Thms 5 and 6 work with is **not** the abelianized relation module. His §4
Definition, on p. 121, sets `X = ker(χ)`, `E = X/(X, X)`, `Γ = F/X` and `Λ = Z₂(Γ)`, and makes
`E` a topological `Γ`-module by `α·ξ = ` the class of `y⁻¹xy` for `ξ = x̄` and `α = ȳ`. The
seven points that fix the object are these.

1. **The object.** `E = X/(X, X)`, the topological abelianization of `X = ker χ`. In
   `Suggested.lean` it is `labuteE`, written additively.
2. **Its construction from `1 → R → F → G → 1`.** `χ` is the canonical character of `G`
   composed with `F ↠ G`, regarded as a character **on the free group** `F`; `X = ker(χ : F → Γ)`
   contains `R`; and `Γ = F/X ≅ Im χ`.
3. **What it is not.** It is neither `R/[R, R]` nor `R/[F, R]`. Those are quotients of the
   relation subgroup, while `E` is built from the whole of `ker χ`. The relator enters through
   its image `r̄ ∈ E`, which makes sense because `r ∈ R ⊆ X`.
4. **The map from the full relation module.** The inclusion `R ⊆ X` induces
   `R^{ab} → E` (`relationModuleToLabuteE`), and the proofs use only the image of the relator
   under it. That is why `R^{ab}` carries no milestone of its own here.
5. **The acting algebra.** `Λ = completedGroupAlgebra p Γ` with `Γ = Im χ`. For `Γ ≅ ℤ₂` it is
   `ℤ₂[[T]]` with the generator going to `1 + T`, and for `Γ ≅ C₂ × ℤ₂` it is
   `ℤ₂[C₂] ⊗ ℤ₂[[T]]` (Labute p. 122). Those are the two shapes of the previous subsection.
6. **The theorem connecting the action to `χ`.** The conjugation action of `F` on `E` factors
   through `Γ = F/ker(χ) ≅ Im χ`, because inner automorphisms by elements of `X` act trivially
   on `X/(X, X)`. That is the whole of the connection.
   ⚠ **The action is conjugation by `Γ`, and not multiplication by the scalar `χ(g)`.** The
   scalar reading is false: `ℤ_p² = ⟨x, y ∣ (x, y)⟩` is Demushkin with trivial orientation,
   while its relation module carries the regular action through the conjugates of the relator,
   which a trivial scalar action would collapse to coinvariants.
7. **The hypotheses.** `r` is a Demushkin relator with the §4 normalizations: `q = 2` and `n`
   even. Labute's Thm 5 is the branch `Im χ = U₂[f]` with `f ≠ ∞`, and his Thm 6 the branch
   `Im χ = {±1} × U₂(f)` with `2 ≤ f < ∞`.

The milestones are: `labuteE` with its abelianness `labuteE_add_comm`; the conjugation action
`labuteAction` with its laws and its defining equation `labuteAction_apply`; the scalar action
`labuteSMul` of `Λ`, with the module axioms `labuteSMul_laws`, its continuity, and
`labuteSMul_of` saying that it extends the conjugation action; the comparison map
`relationModuleToLabuteE`; and the relator class `labuteRelatorClass`.
⚠ The module axioms are stated as equations about a named scalar-action map rather than through
a `Module` instance, because `E` is a quotient group and installing a second additive structure
on it would not be definitionally the first.
*Needs:* L5 presentations; L7 canonical character; L9 the algebra and its compact modules; L4
abelian pro-`p` structure theory.
*Source:* Labute §4 Definition, p. 121.

#### The two module criteria that the classification uses

With `E` and `Λ` as above, a chosen topological generator `γ` of `Γ` and `T = γ - 1`:

- **The expression of the relator image.** `E` is topologically generated over `Λ` by finitely
  many classes `ȳ_i` of the basis elements lying in `X` (`labuteE_exists_generators`), and `r̄`
  is a `Λ`-combination of them (`labuteRelatorClass_eq_sum`), with the coefficients read off the
  normal form of `r`. Labute computes on p. 122
  `r̄ = (1 + a + (1+T)^a) ȳ₁ + (2^g + (1+T)^{ab} − 1) ȳ₃`
  in the dyadic even-rank branch.
- **The basis correction.** Applying the division criterion `(T − c) ∣ ψ ⟺ ψ(c) = 0` to those
  coefficients replaces the generators by ones in which the relator image is a single multiple:
  for the parameters `(α, f)` there is `z₁` with `r̄ = (2 + 2^f + T) z̄₁`
  (`labuteRelatorClass_eq_smul_of_dyadic`). The corrections then iterate along the descending
  `2`-central series, which is where Layer 8's comparison schema takes over. This is the exact
  point at which the Division milestone above is used.
- **The annihilator.** The annihilator of `E` as a `Λ`-module is generated by one element, the
  *relator series* `ψ_r`, read off the normal form of `r`
  (`labuteE_annihilator_isPrincipal`); two relators with the same invariants have associated
  series, that is they differ by a unit of `Λ`.
  ⚠ The annihilator statement is about `E`, and **not** about `R^{ab}`: no claim is made here
  about the annihilator of the full relation module.
- **Membership.** For `λ ∈ Λ` corresponding to `T − c` under the coordinate, membership of `r̄`
  in `λE` is the vanishing `ψ_r(c) = 0` (`labuteRelatorClass_mem_smul_iff`). The basis
  correction exists exactly when the membership holds.

Both criteria carry the hypotheses that `E` is a compact `Λ`-module, that it is separated and
complete, and that the transition maps of its defining system are surjective.
`Suggested.lean` has the signatures.
*Needs:* L9 Labute's relation module, L9 power-series coordinates, L9 evaluation, L9 division.
*Source:* Labute Thms 5 and 6, and the computation on p. 122.

### Layer 9: the classification of Demushkin groups

The full Demushkin–Serre–Labute classification, after the Layer 8 method, because its proofs
are successive-approximation arguments along the lower `p`-series, and after the two
prerequisites. Source of record: Labute, *Classification of Demushkin groups*, Canad. J.
Math. 19 (1967), 106–132; modern statements in NSW III §9. The notation is the one fixed in
Layer 8.

- **Cup-form normal forms.** The image of the relator in `gr_1(F)` computes the cup product:
  `r̄` paired with `χ_i ∪ χ_j` is `a_{ij}` off the diagonal and `(q choose 2) a_i` on it.
  Feeding the matrix through the change-of-basis theorem gives
  `r ≡ x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{n-1},x_n)` modulo `λ_2(F)` when the form is alternating, with
  `n` even; and `r ≡ x₁²(x₂,x₃)(x₄,x₅)⋯` modulo `λ_2(F)` in the nonalternating case, which
  is exactly `p = 2` with `q = 2`, and where `n` may be odd.
  *Needs:* L9 prerequisites; L8 notation; L7 the predicate.
  *Source:* Labute Prop. 3, Prop. 4 and their corollary.
- **The successive-approximation argument.** The span statements, in the Layer 8 notation:
  for `q ≠ 2`, `gr_j(F) = Im δ_j` for every `j ≥ 2`; for `q = 2`, `gr_j(F) = Im δ_j + T_j`,
  where the tails are what the dyadic failure of additivity of `π` leaves. Each is an
  identity of subspaces of a finite-dimensional space. The limit process is the Layer 8
  comparison schema, with `S k` the finite nonempty set of level-`k` basis corrections that
  carry the given relator into normal form. The conclusion: a Demushkin group with
  `q(G) = q` has a basis in which
  - `r = x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{n-1},x_n)`, if `q ≠ 2`;
  - `r = x₁²x₂^{2^f}(x₂,x₃)(x₄,x₅)⋯` with `2 ≤ f ≤ ∞`, if `q = 2` and `n` is odd;
  - `r = x₁^{2+α}(x₁,x₂)x₃^{2^f}(x₃,x₄)⋯` with `2 ≤ f ≤ ∞` and `α ∈ 4ℤ₂`, if `q = 2` and `n`
    is even.

  Implement this through the schema, and do not re-derive a limit argument.
  *Needs:* L8 comparison schema, L8 `δ_j` and `T_j`; L9 cup-form normal forms.
  *Source:* Labute Prop. 5 and Thm 3.
- **Character values in normal form.** Existence of `χ` by explicit values on the
  normal-form basis:
  - case `q ≠ 2`: `χ(x₂) = (1-q)^{-1}`, and `1` on the other generators;
  - case `q = 2` with `n` odd: `χ(x₁) = -1`, `χ(x₃) = (1-2^f)^{-1}`, and `1` otherwise;
  - case `q = 2` with `n` even: `χ(x₂) = -(1+α)^{-1}`, `χ(x₄) = (1-2^f)^{-1}`, and `1`
    otherwise.

  Uniqueness follows from the forced computation on a derivation. The image table is
  `1 + qℤ_p`; `{±1} × U^(f)`; and, for `n` even, `{±1} × U^(f)` if `v₂(α) ≥ f`, and
  `U^[f']` with `f' = v₂(α)` if `f' < f`.
  *Needs:* L7 canonical character; L9 normal forms; L7 the subgroups of `ℤ₂ˣ`.
  *Source:* Labute Thm 4 and its corollary.
- **The marked classification.** For each normal-form family, the classification is stated in
  marked form: a continuous isomorphism from the Demushkin group onto
  `presentedProP p (Fin n) {r}` for the normal-form relator `r`, under which the canonical
  character takes the values of the table above on the marked generators. The three statements
  are `isDemushkin_marked_of_q_ne_two`, `isDemushkin_marked_of_q_two_odd` and
  `isDemushkin_marked_of_q_two_even`, and the relator words are the named terms
  `demushkinWordNeTwo`, `demushkinWordTwoOdd` and `demushkinWordTwoEven`, each written on a
  tuple of group elements so that the same word can be read in `F` and in `G`. The character
  values are stated as equations in `ℤ_p`, for instance `χ(x₂)(1 - q) = 1` in place of
  `χ(x₂) = (1-q)^{-1}`, so that no unit has to be constructed in order to state them. The
  unmarked isomorphism statements are corollaries, obtained by forgetting the character
  clause; the marked form is the one the arithmetic instances of Layer 11 use, and it is what
  makes them normalizations.
  *Needs:* L9 normal forms and character values; L9 Labute Thm 2 in marked form; L5
  presentations.
  *Source:* Labute Thms 1, 2 and 4.
- **The `q = 2` even-rank case.** The arguments over `Λ = ℤ₂[[Γ]]` with `Γ = Im χ`, acting on
  Labute's module `E = ker(χ)/(ker χ, ker χ)` and not on `R^{ab}`, using the completed-algebra
  prerequisite, that is the power-series coordinate, evaluation, and the division criterion. Two even-rank families, with `N = n/2` and `(A : A²)` as declared in
  Layer 8:
  - `r = x₁^{2+2^f}(x₁,x₂)(x₃,x₄)⋯` realizes `Im χ = U^[f]`, where `(A : A²) = 2`, for
    `N ≥ 1` and `2 ≤ f < ∞`. ⚠ The endpoint `f = ∞` is a separate statement, because
    `U^[f] = closure ⟨-1 + 2^f⟩` is defined only for finite `f`. At `f = ∞` the relator is
    `x₁²(x₁,x₂)(x₃,x₄)⋯` and the image is `{±1} = V^(∞)`;
  - `r = x₁²(x₁,x₂)x₃^{2^f}(x₃,x₄)⋯` realizes `Im χ = {±1} × U^(f)`, where `(A : A²) = 4`,
    for `N ≥ 2` and `2 ≤ f < ∞`, and `f = ∞` is excluded.

  Each statement carries the restrictions on `N` and `f` as hypotheses.
  *Needs:* L9 completed group algebra; L9 character values; L8 comparison schema.
  *Source:* Labute Thm 1, through Thms 5 and 6.
  ⚠ Cite Labute, and not NSW, for completeness. NSW (3.9.19) states only the existence of
  the `q = 2` normal forms; which pairs `(α, f)` give isomorphic groups is Labute Thms 1, 2,
  4, 5 and 6.
  ⚠ NSW print the second even form as `x₂²(x₁,x₂)x₃^{2^f}⋯` on page 417 of the second
  edition, where Labute has `x₁²(x₁,x₂)x₃^{2^f}⋯`. The two are equivalent under a basis
  change; quote the exact form of each source.
- **The classification theorems.**
  - *Uniqueness:* two Demushkin groups with the same `n` and the same `Im χ` are isomorphic.
  - *Uniqueness, marked form (Labute Thm 2).* An automorphism of `F` carries any Demushkin
    relator to any other with the same invariants; in `Suggested.lean` this is
    `exists_continuousMulEquiv_map_demushkinRelator`, stated as the equality of the two closed
    normal closures. This is a milestone in its own right, and not a remark, because it is what
    turns "isomorphic" into "isomorphic by a basis change" and so makes the marked normal forms
    below a normalization rather than a choice.
  - *Existence:* let `A` be a closed subgroup of `ℤ_pˣ` that is **pro-`p`**. Then `(n, A)`
    is realized in exactly three situations:
    1. `n` is even and `p^n > (A : A^p)`;
    2. `n` is odd and `n ≥ 3`, so `p = 2`, and `A = {±1} × U^(f)` with `f ≥ 2` or `f = ∞`;
    3. `n = 1` and `A = {±1}`.

    ⚠ The hypothesis that `A` is pro-`p` is part of the statement, because `A` is the image
    of a pro-`p` group under a continuous homomorphism. Without it the numerical condition
    admits impossible pairs: at `p = 3` and `n = 2`, the subgroup `A = ℤ₃ˣ` has
    `(A : A³) = 3 < 9`, and it contains `{±1}`, so it is not pro-`3`. For odd `p` the
    condition is `A ≤ 1 + pℤ_p`. For `p = 2` every closed subgroup of `ℤ₂ˣ` is pro-`2`, so
    the three families of Layer 7 are all admissible.

  The small-rank cases are part of the statement. For the odd case cite Serre's Thm 3.2 only
  for `n ≥ 3`, because its printed `n ≥ 1` degenerates at `n = 1`; handle `n = 1` through
  NSW (3.9.10) and Labute Remark 2(iii).
  *Needs:* L9 normal forms and character values; L8 comparison schema; L3 Hopf property.
  *Source:* Labute Thms 1 and 2, and Remark 2.
- **Consequences.** The open-subgroup theorem was proved in Layer 7 from the duality
  package. Here it acquires its classification content: for `U` open in an infinite
  Demushkin `G`, the invariants of `U` are `n(U) = 2 + [G : U](n(G) - 2)` and
  `Im(χ|_U) = χ(U)`, so the classification identifies `U` up to isomorphism.
  *Needs:* L7 open-subgroup theorem; L9 classification.
  *Source:* Serre, *Structure de certains pro-p-groupes*, Thm 9.2.
  ⚠ At `n = 2` the rank formula gives `n(U) = 2` for every `U`, so the rank-2 groups with
  `q ≠ 2`, which are `ℤ_p ⋊ ℤ_p`, are the case to check first.

### Layer 10: free pro-`C` groups on profinite spaces

This layer is the home of the infinite-rank theory.

- **Construction and universal property.** `F_C(X, ∗)` on a pointed profinite space, with a
  basis that converges to `1`: continuous maps `X → P` that send `∗` to `1` correspond to
  continuous homomorphisms into a profinite `P` in the class `C`. It recovers the Layer 4
  object for finite discrete `X`. For an infinite discrete set `S` there are two candidate
  objects:
  - `freeProC C S`, the Layer 4 construction, whose universal property quantifies over all
    maps `S → P`;
  - `F_C(S⁺, ∗)` on the one-point compactification, whose universal property quantifies
    over maps that converge to `1`.

  The inclusion `S → S⁺` induces a continuous surjection `freeProC C S ↠ F_C(S⁺, ∗)`. The
  theorem to prove is that **at `C = finiteGroupClassP p`** this map is not injective for
  infinite `S`. The witness is a computation of ranks, and not a description of the kernel by
  generators, which this roadmap does not claim: the continuous characters of the source are
  all maps `S → 𝔽_p`, a product of dimension `p^{#S}` by the Erdős–Kaplansky theorem, while
  those of the target are the finitely supported maps, of dimension `#S`.
  ⚠ The statement is false for an arbitrary class. If `C` contains only the trivial group,
  both objects are trivial and the map is injective. Do not state it for `FiniteGroupClass`
  when the proof is specific to pro-`p`.
  Never write "the free pro-`C` group on `S`" without saying which object is meant.
  *Needs:* L4 free objects and `FiniteGroupClass`; L3 rank.
  *Source:* Ribes–Zalesskii §3.3.
- **Bases and rank.** Three statements:
  - existence of bases that converge to `1`, and uniqueness of their cardinality;
  - invariance of `topologicalGeneratorRank` under topological isomorphism, as a cardinal
    and with no finiteness hypothesis;
  - the infinite-rank Frattini argument in the form proved in Layer 3, that is
    `topologicalGeneratorRank G = dim_{𝔽_p} Hom_cont(G, 𝔽_p)`.

  The
  rank of `F_C(X, ∗)` at `C = ` finite `p`-groups is the `𝔽_p`-dimension of the space of
  continuous functions `X → 𝔽_p` that vanish at `∗`, which for `X = S⁺` is `#S`.
  *Needs:* L3 rank and Burnside; L10 construction.
- **Presentations at arbitrary rank.** Every pro-`p` group has a presentation by a free
  pro-`p` group on a profinite space, and has a minimal one. This is the general statement
  that Layer 5 does not make.
  *Needs:* L10 construction; L3 Burnside.
- **Serre's theorem in full generality.** `cd_p G ≤ 1` if and only if `G` is free pro-`p`,
  with no finite generation, which is the Layer 6 proof upgraded with bases that converge to
  `1`. Closed subgroups of free pro-`p` groups are free pro-`p`, which is the full pro-`p`
  Nielsen–Schreier theorem.
  *Needs:* L6 Serre's theorem; L10 bases and presentations.
  *Source:* Ribes–Zalesskii Cor. 7.7.5.
- Nothing later in this roadmap uses this layer, because Layers 9 and 11 need only finite
  rank. Without it the theory is truncated.

### Layer 11: `G_K(p)` for `p`-adic fields

For `K/ℚ_p` finite of degree `N`, `G_K(p) := Gal(K(p)/K)` is the Galois group of the maximal
`p`-extension. Intrinsically it is `maximalProPQuotient p (Gal(K^sep/K))`, which Layer 3
makes well defined and functorial, and `Suggested.lean` names it
`absoluteGaloisGroupProP`. Throughout this layer `N` is the degree `[K : ℚ_p]`, and `d` is
never used for a degree.

- **The arithmetic inputs, as a local interface.** The facts below are theorems about `G_K`
  that the Local Fields roadmap proves. This roadmap does not wait for them.
  `Suggested.lean` bundles them as the fields of one structure, `LocalFieldInputs p Γ N hasMu`,
  stated against the Layer 5 carrier, and every theorem of this layer takes that structure as
  a hypothesis. The Local Fields roadmap supplies an instance, and the shared table names the
  object behind each field.
  1. Finiteness and the Euler-characteristic count: `H⁰(G_K, 𝔽_p)`, `H¹(G_K, 𝔽_p)` and
     `H²(G_K, 𝔽_p)` are finite-dimensional; `dim H⁰ = 1`; `H²(G_K, 𝔽_p) = 0` when
     `μ_p ⊄ K` and `dim H² = 1` when `μ_p ⊆ K`; and
     `dim H¹ = 1 + dim H² + N`.
     ⚠ Finite-dimensionality is a separate field from the dimension count. `Module.finrank`
     is `0` for an infinite-dimensional space as well, so `finrank H² = 0` does not say
     that `H²` vanishes, and the free case needs the vanishing.
  2. The trace isomorphism `H²(G_K, μ_p) ≅ 𝔽_p`, and its transport to `H²(G_K, 𝔽_p)`
     under a choice of `p`-th root of unity when `μ_p ⊆ K`.
  3. Nondegeneracy of the cup pairing on `H¹(G_K, 𝔽_p)` when `μ_p ⊆ K`, **on both sides**.
     This is local Tate duality at `n = p`, transported along inputs 2 and 4. Right
     nondegeneracy is a field, and not a consequence, until the graded commutativity of
     Layer 5 is available; when it is, the field is dropped, exactly as for `IsDemushkin`.
  4. Kummer theory `Kˣ/(Kˣ)^p ≅ H¹(G_K, μ_p)`, together with the square that relates
     Kummer classes to the cup product. This is what identifies the cup pairing with the
     symbol pairing on `p`-th power classes, and it is what shows that the finite quotients
     `μ_{p^i}` satisfy the prescription property of Layer 7.
  5. The cyclotomic character `χ_cyc : G_K → ℤ_pˣ`, continuous, with the normalization
     `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹` for `u ∈ 𝒪_Kˣ`; **its image is pro-`p`** when
     `μ_p ⊆ K`, equivalently `χ_cyc ≡ 1 mod p` for odd `p`; and its image is the closed
     subgroup `Gal(K(μ_{p^∞})/K) ≤ ℤ_pˣ`, given as a field of the structure.
     ⚠ The pro-`p` image is what makes `χ_cyc` factor through `G_K(p)`, and nothing else in
     the list forces that factorization: a prime-to-`p` quotient of `Γ` can carry a
     nontrivial character whose twisted `H¹` vanishes, which makes the prescription property
     vacuous there.
  6. The invariant `q = #(μ_{p^∞} ∩ K)`, the largest `p`-power `q` with `μ_q ⊆ K`, as a
     field, together with the statement that the torsion of the abelianization of `G_K(p)`
     has that order. Layer 9 selects a normal form from `q` and from the image in input 5, so
     both are needed before the presentations can be stated.

  No statement of this layer uses a fact about `K` that is not on this list.
  *Needs:* L5 the coefficient objects; and, for an instance, LF-5, LF-7 and LF-8B.
- **The canonical instance, for an actual `p`-adic field.** The interface is not lawless: a
  milestone of this layer builds it for a finite extension `K` of `ℚ_p`, with `G_K` Mathlib's
  `absoluteGaloisGroup K`, `N` the degree `Module.finrank ℚ_[p] K`, and the roots-of-unity
  predicate `HasMuP p K`, that is `∃ ζ : K, IsPrimitiveRoot ζ p`, which is the definition the
  Local Fields roadmap states. The constructor is a named declaration, and not an existence
  statement, because the interface table promises the name. Every field is proved from a
  named theorem of that roadmap, transported through the Layer 5 comparison. The statements below
  are then about `G_K(p)`, and not about an abstract structure supplied as a hypothesis, and
  the acceptance instances for `ℚ₂` and `ℚ₂(√-2)` read end to end.
  *Needs:* L11 the input list; M `absoluteGaloisGroup`; LF-5, LF-7, LF-8B.
  ⚠ Without this constructor every theorem below would be a statement about an arbitrary
  structure. It is a row of the interface table for that reason.
- **The public arithmetic theorems.** The milestones of this layer come in two forms. The
  abstract ones take a `LocalFieldInputs p Γ N hasMu` as a hypothesis and are named
  `isTopologicallyFinitelyGenerated_maximalProPQuotient`,
  `maximalProPQuotient_equiv_free_of_not_mu`, `isDemushkin_maximalProPQuotient_of_mu`,
  `demushkinRank_maximalProPQuotient`, `demushkinQ_maximalProPQuotient` and
  `cyclotomicOrientation_maximalProPQuotient`. The public ones take the field `K` itself and are
  proved by instantiating the abstract ones at `localFieldInputs p K`; they are
  `isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`,
  `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu`,
  `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu`,
  `absoluteGaloisGroupProP_iso_freeProP_of_not_hasMuP`,
  `isDemushkin_absoluteGaloisGroupProP_of_hasMuP`, `demushkinQ_absoluteGaloisGroupProP` and
  `demushkinCharacter_absoluteGaloisGroupProP`. The interface table cites the public names,
  because a consumer wants a statement about `G_K(p)` and not about a structure.
  *Needs:* L11 the canonical instance.
- **The bundling structures and their canonical terms.** The Local Fields roadmap states its
  Layer 9 rank theorem against two structures, `ProPOps` and `ProPRankInputs`, which this
  roadmap repeats verbatim and instantiates: `proPOps` is assembled from the Layer 2, Layer 3
  and Layer 4 theorems named in the interface table, and `proPRankInputs` from the three public
  rank theorems above. Those two terms are what make the Local Fields rank theorem
  unconditional, so they are stable declarations and not anonymous examples.
  *Needs:* L2 Sylow theory; L3 rank and Burnside; L4 free profinite objects; L11 the public
  theorems.
- **Inflation in degree one.** Let `R := ker(G_K ↠ G_K(p))`. Inflation
  `H¹(G_K(p), 𝔽_p) → H¹(G_K, 𝔽_p)` is an isomorphism, directly from the universal
  property of the maximal pro-`p` quotient: a continuous homomorphism `G_K → 𝔽_p` factors
  uniquely through `G_K(p)`.
  *Needs:* L3 universal property; PC-1 `infl`.
- **`G_K(p)` is topologically finitely generated.** Input 1 makes `H¹(G_K, 𝔽_p)`
  finite-dimensional. The degree-one isomorphism transports that to `H¹(G_K(p), 𝔽_p)`,
  which is the discrete dual of the Frattini quotient, so that quotient is finite and Layer
  3 gives topological finite generation, with `d(G_K(p)) = dim_{𝔽_p} H¹(G_K, 𝔽_p)`.
  Nothing in the argument uses finite generation of `G_K` itself, which is what keeps the
  two roadmaps in an acyclic order.
  *Needs:* L11 inflation in degree one; L3 Burnside; L11 input 1.
- **Injectivity in degree two.** `H¹(R, 𝔽_p)^{G_K(p)} = 0`: a nonzero invariant class
  would give a `G_K`-stable open subgroup of `R` of index `p`, hence a `p`-extension of `K`
  larger than `K(p)`, which contradicts maximality. With the degree-one isomorphism, the
  five-term sequence
  `0 → H¹(G_K(p)) → H¹(G_K) → H¹(R)^{G_K(p)} → H²(G_K(p)) → H²(G_K)`
  gives that `H²(G_K(p), 𝔽_p) → H²(G_K, 𝔽_p)` is injective.
  *Needs:* PC-5 the five-term sequence; L3 Burnside; L11 inflation in degree one.
  ⚠ The five-term sequence gives injectivity and nothing more. Surjectivity needs the case
  split below, and stating the isomorphism outright would leave a gap in its place.
- **Surjectivity in degree two, by cases on `μ_p`.**
  - If `μ_p ⊄ K`, then `H²(G_K, 𝔽_p) = 0` by input 1, so injectivity forces
    `H²(G_K(p), 𝔽_p) = 0`, and inflation is an isomorphism.
  - If `μ_p ⊆ K`, then `dim H²(G_K, 𝔽_p) = 1` by input 1, and the cup pairing on
    `H¹(G_K, 𝔽_p)` is nondegenerate by input 3, so there are classes `a` and `b` with
    `a ∪ b ≠ 0`. Lift them through the degree-one isomorphism. Inflation commutes with cup
    products, so the inflation of the lifted product is `a ∪ b ≠ 0`; hence inflation on
    `H²` reaches a nonzero class of a one-dimensional space, so it is surjective. With
    injectivity it is an isomorphism.

  State the two cases as separate named theorems, and the isomorphism as their corollary.
  *Needs:* L11 injectivity; L5 `cupFp`; PC-12 `cup_infl`; L11 inputs
  1 and 3.
- **The free case.** If `μ_p ⊄ K`, then `G_K(p)` is free pro-`p` of rank `N + 1`. Route:
  `H²(G_K(p), 𝔽_p) = 0` from input 1 and the case split; then Serre's theorem of Layer 6,
  whose finite-generation hypothesis is the item above; then the count of `H¹`. Record
  the instance `K = ℚ_p` with `p ≠ 2`, which is free of rank 2.
  *Needs:* L6 Serre's theorem; L11 the case split; L11 finite generation.
  *Source:* Shafarevich 1947.
- **The Demushkin case.** If `μ_p ⊆ K`, then `G_K(p)` is Demushkin with `n = N + 2` and
  `q = #(μ_{p^∞} ∩ K)`, which is input 6. The construction of the `IsDemushkin` term is the
  statement to prove, and `Suggested.lean` prototypes it as
  `isDemushkin_maximalProPQuotient_of_mu`; the rank, `q`, the orientation and the
  presentation are its consequences. Each clause of
  `IsDemushkin` is verified through the two inflation isomorphisms. The dimensions
  `dim H¹ = N + 2` and `dim H² = 1` come from input 1. Nondegeneracy of the cup
  pairing comes from input 3, with the compatibility of inflation and cup products.
  **The orientation is cyclotomic:** the canonical character of Layer 7 is the descent of
  the cyclotomic character to `G_K(p)`. The route has three steps:
  1. `χ_cyc` is trivial on `R`, because its image is pro-`p` by input 5, so the kernel of
     `G_K ↠ G_K(p)` lies in its kernel and it factors through `G_K(p)`;
  2. input 4 shows that the finite quotients `I(χ_cyc)/p^i = μ_{p^i}` satisfy the
     prescription property of Layer 7;
  3. the uniqueness half of Labute Thm 4 forces `demushkinCharacter (G_K(p)) = χ_cyc`.
  *Needs:* L7 the predicate and the canonical character; L11 the case split; L11 inputs 1,
  3, 4 and 5.
  *Source:* Labute §5; NSW VII §7.5.
- **Explicit presentations,** as corollaries of Layer 9 and the invariants:
  - `q ≠ 2`: `G_K(p) = ⟨x₁, …, x_{N+2} ∣ x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{N+1},x_{N+2})⟩`;
  - `q = 2` and `N` odd: `⟨x₁, …, x_{N+2} ∣ x₁²x₂⁴(x₂,x₃)(x₄,x₅)⋯⟩` with `Im χ = ℤ₂ˣ`,
    because `N` odd forces `K ∩ ℚ₂(μ_{2^∞}) = ℚ₂`, so `f = 2`;
  - `q = 2` and `N` even: the two Layer 9 families, according to `Im χ`.

  *Needs:* L9 classification; L11 the Demushkin case.
  *Source:* Labute Thms 7, 8 and 9, which are Demushkin's theorem and Serre's theorem.
- **Acceptance instances, stated intrinsically.**
  - `K = ℚ₂`, so `N = 1` and `q = 2`: the **marked** statement
    `G_{ℚ₂}(2) ≃ D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩`, of rank 3, in which the descended cyclotomic
    character becomes the standard orientation of `D₀` under the isomorphism, its image is all
    of `ℤ₂ˣ`, and its values on the marked generators are
    `(χ(A), χ(S), χ(Y)) = (-1, 1, (1-2²)^{-1} = (-3)^{-1})`. `D₀` is a presented group, so its
    generators `d0A`, `d0S`, `d0Y` are named terms, its orientation `standardD0Orientation` is a
    named character with named values, and `standardD0Orientation_unique` says that it is the
    only continuous character with those values, since the three generators topologically
    generate. The milestone is `absoluteGaloisGroupProP_two_ratPadic_marked`; the unmarked
    isomorphism is its corollary. A consumer identifying `G_{ℚ₂}(2)` with `D₀` therefore needs
    no further automorphism or basis-normalization theorem.
    The values are the Layer 9 table at `q = 2`, `n = 3` odd, `f = 2`, and they are consistent
    with the relator: `(-1)²·1⁴ = 1`, and the commutator dies because `ℤ₂ˣ` is abelian.
  - `K = ℚ₂(√-2)`, so `N = 2` and `q = 2`, with `Im χ = U^[2] = closure ⟨3⟩` of index 2 in
    `ℤ₂ˣ`: `G_K(2) = ⟨x, y, z, w ∣ x⁶(x,y)(z,w)⟩`. This is Labute's closing example, and it
    is the test that the `U^[f]` family is right.
  - `K = ℚ_p(μ_p)` for odd `p`, so `N = p - 1` and `q = p`: the normal form
    `x₁^p(x₁,x₂)(x₃,x₄)⋯(x_p, x_{p+1})`.

  *Needs:* L11 explicit presentations; L7 the subgroups of `ℤ₂ˣ`.

## Worked examples (acceptance criteria)

Each example detects a way in which a definition could become vacuous, or could be
mis-normalized.

- Every `p`-Sylow subgroup of `ℤ̂` is `ℤ_p` (Layers 0 to 2, proved in Layer 4;
  `Suggested.lean`).
- `d(ℤ/4 × ℤ/2) = 2`, `d((ℤ/p)ⁿ) = n`, and `r((ℤ/p)ⁿ) = n(n+1)/2` (Layers 3 and 5).
- `d(∏_{i ∈ ℕ} ℤ/p) = ℵ₀`, while the algebraic dimension of that group as an `𝔽_p`-vector
  space is `2^{ℵ₀}`. This is the check that the infinite-rank invariant is the dimension of
  the discrete dual, and not of the Frattini quotient itself (Layers 3 and 10).
- `U^[2] = closure ⟨3⟩` meets `1 + 4ℤ₂` in `U^(3) = 1 + 8ℤ₂`, and has index 2 in `ℤ₂ˣ`. This
  is the smallest case of the depth formula, checked by squaring, since `3² = 9 = 1 + 8`,
  and the `ℚ₂(√-2)` instance rests on it (Layer 7; `Suggested.lean`).
- `H²(ℤ/2, 𝔽₂)` is one-dimensional, and the cup square of the generator of
  `H¹(ℤ/2, 𝔽₂)` is nonzero: `ℤ/2` is Demushkin with `n = 1`, `q = 2` and `Im χ = {±1}`.
  Neither `ℤ_p` nor any free pro-`p` group is Demushkin. `ℤ_p²` is Demushkin with `q = 0`
  (Layer 7).
- `D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩` is nontrivial and pro-`2`, `D₀^{ab} ≅ ℤ₂² × ℤ/2`, and
  `q(D₀) = 2` (Layers 5 and 7; `Suggested.lean`). All three are proved before the
  classification, so the acceptance instance cannot depend on it. Its marked generators `d0A`,
  `d0S`, `d0Y` topologically generate, and `standardD0Orientation` is the unique continuous
  character with values `(-1, 1, (-3)^{-1})` on them, of image all of `ℤ₂ˣ`.
- Index-2 subgroups of `D₀` are Demushkin of rank 4, which is the Layer 7 index formula at
  its smallest case. Open subgroups of `freeProP p (Fin n)` have rank `1 + m(n-1)` (Layer 6;
  `Suggested.lean`).
- The nondegenerate symmetric bilinear form on `𝔽_2³` with identity matrix is not
  alternating and has odd dimension. This is the case with no analogue for odd `p`, and the
  `q = 2` normal form with `n` odd depends on it (Layer 9 prerequisites).
- The arithmetic instances: the marked `G_{ℚ₂}(2) ≃ D₀`, carrying the descended cyclotomic
  character to `standardD0Orientation`, whose values are `(-1, 1, (-3)^{-1})`; `G_{ℚ₂(√-2)}(2) = ⟨x,y,z,w ∣ x⁶(x,y)(z,w)⟩`; and `G_{ℚ_p(μ_p)}(p)`
  of rank `p + 1` in the `q = p` normal form (Layer 11).

## Ordering and parallelism

Layers 0 to 4 are sequential, and each uses the previous one. The theory of finitely
generated abelian pro-`p` groups at the end of Layer 4 uses nothing cohomological.

After Layer 4, four developments are independent of each other:

- Layer 5, that is the coefficient objects, the presentations and the extension dictionary;
- Layer 8, which is free of cohomology throughout;
- the bilinear forms of the Layer 9 prerequisites;
- the completed group algebra of the Layer 9 prerequisites.

The dependencies that bind are these:

- Layer 5 cannot finish before the extension dictionary and the vanishing theorem
  `H²(F, M) = 0`, both of which are inside Layer 5 and precede the relation-rank theorem.
- Layers 5 to 7, 9 and 11 use the Profinite Cohomology declarations of the contract table.
- Layer 6 cannot finish the Nielsen–Schreier rank formula before the two-term Euler theorem
  of the same layer.
- Layer 7 cannot define `q(G)` before the structure theorem of Layer 4, and cannot prove the
  open-subgroup theorem before its own duality package and the three-term Euler formula.
- Layer 9 cannot start the normal-form proofs before both prerequisites. The
  characteristic-two bilinear normal form is needed for `n` odd at `q = 2`, and the
  completed group algebra for the even-rank case at `q = 2`.
- Layer 10 needs Layer 6, and is independent of Layer 9.
- Layer 11 needs Layers 7 and 9 for the Demushkin case. Its free case needs only Layers 5
  and 6 and the vanishing of `H²(G_K, 𝔽_p)`.
### Interface table: Local Fields and Pro-`p` Groups

The two roadmaps have edges in both directions, at different layers. Every crossing is a row
of the table below, and a statement that is not a row is not an interface: neither roadmap
consumes the other through prose. Each row gives the consuming layer, the supplying layer,
the exact object or theorem, and the name it goes by. The name belongs to the supplier, which
states the object once, and the consumer cites the name instead of restating the object. The
Local Fields and Pro-`p` Groups roadmaps carry the same table.

| Consumer layer | Supplier layer | Exact object or theorem | Name |
|---|---|---|---|
| Local Fields Layer 1, structure of `Kˣ` | Pro-`p` Groups Layer 3 | the quotient-form pro-`p` predicate, applied to `U(K,1) = lim_i U(K,1)/U(K,i)` | `IsProP` |
| Local Fields Layer 4, wild inertia | Pro-`p` Groups Layer 2 | pro-`p` Sylow subgroups of a profinite group: the predicate, existence, the containment of every closed pro-`p` subgroup in one, uniqueness of a normal one, and the image under a continuous surjection. All five are free of Galois vocabulary; identifying the Sylow subgroup of `I_K` with `Gal(K̄/K^t)` is the Local Fields side | `IsProPSylow`, `exists_isProPSylow`, `IsProP.exists_le_isProPSylow`, `IsProPSylow.eq_of_normal`, `IsProPSylow.map_of_surjective` |
| Local Fields Layer 4, Iwasawa presentation | Pro-`p` Groups Layer 4 | the free **profinite** group on a finite set, its generators and its universal property, together with the quotient by the closed normal closure of a set of relators. This is the shape in which `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^{−q}⟩` is stated, and it is a profinite object, not the pro-`p` `presentedProP` of the same layer | `freeProfiniteGroup`, `freeProfiniteGroup.of`, `freeProfiniteGroup.lift`, `presentedProfiniteGroup` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | topological finite generation, in exactly the pinned shape `∃ s : Finset G, (Subgroup.closure ↑s).topologicalClosure = ⊤` | `IsTopologicallyFinitelyGenerated` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | the topological rank in its cardinal and natural-number forms, its monotonicity under continuous surjections, the Schreier bound `d(U) ≤ 1 + [G : U](d(G) − 1)` for open `U`, and the Burnside generation criterion for pro-`p` groups (a subset generates topologically iff its image generates the Frattini quotient) | `topologicalGeneratorRank`, `topologicalGeneratorRankNat`, `topologicalGeneratorRank_le_of_surjective`, `topologicalGeneratorRankNat_le_of_isOpen`, `topologicallyGenerates_iff_frattiniQuotient` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 11 | `G_K(p)` as a carrier, its topological finite generation, and its rank in both cases: `N + 1` when `μ_p ⊄ K` (free, Shafarevich) and `N + 2` when `μ_p ⊆ K` (Demushkin) | `absoluteGaloisGroupProP`, `isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu` |
| Local Fields Layer 9, the exact rank | Pro-`p` Groups Layers 2 to 4 and Layer 11 | the canonical terms of the two bundling structures that the abstract rank theorem takes as arguments, each assembled from the named supplier theorems in the rows above | `proPOps`, `proPRankInputs` |
| Pro-`p` Groups Layer 11, input 1 | Local Fields Layer 8B | the mixed-characteristic Euler characteristic `#H⁰ · #H² / #H¹ = ‖#M‖_K` and its `𝔽_p`-module corollary `dim H¹ = dim H⁰ + dim H² + N · dim M` | `eulerCharacteristic_mixed`, `eulerCharacteristic_finrank_fp` |
| Pro-`p` Groups Layer 11, input 2 | Local Fields Layer 8B | the trace isomorphism `H²(G_K, μ_n) ≃ ZMod n` for **every** `n ≥ 1` in mixed characteristic, which is the value object of the 8B pairing, together with its transport to `H²(G_K, 𝔽_p)` along a choice of `p`-th root of unity when `μ_p ⊆ K`. ⚠ The 8A statement of the same shape carries `IsUnit (n : 𝒪[K])` and therefore says nothing at `n = p`; citing 8A for this input is the mistake to avoid | `h2MuEquivZMod_mixed`, `h2FpEquivZMod_of_mu` |
| Pro-`p` Groups Layer 11, input 3 | Local Fields Layer 8B | perfectness of the local Tate duality pairing at `n = p` in mixed characteristic, in degrees `0`, `1`, `2` | `tateDualityPairing_perfect_mixed` |
| Pro-`p` Groups Layer 11, input 4 | Local Fields Layer 5 | Kummer theory `Kˣ/(Kˣ)ⁿ ≃ H¹(G_K, μ_n)`, and the square relating Kummer classes to the cup product | `kummerEquiv`, `cup_kummerEquiv` |
| Pro-`p` Groups Layer 11, input 5 | Local Fields Layer 7 | the Artin map, and the cyclotomic orientation `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹` for `u ∈ 𝒪[K]ˣ`, with its `K = ℚ_p` corollary `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹`. ⚠ The field norm is part of the statement, not decoration: without it the equation is ill-typed for `K ≠ ℚ_p`, and the `𝒪[K]ˣ`-valued character with value `u⁻¹` is a Lubin–Tate character that neither roadmap builds | `artinMap`, `cyclotomicCharacter_artinMap`, `cyclotomicCharacter_artinMap_padic` |

The constructor `localFieldInputs`, which assembles the Local Fields input rows above into the Layer 11 structure `LocalFieldInputs`, is a Pro-`p` Groups Layer 11 milestone: the structure and its canonical term belong to that roadmap, and the Local Fields side of that contract is exactly the set of input rows. The bundling structures `ProPOps` and `ProPRankInputs` run in the other direction: Local Fields states its Layer 9 theorems against them, the Pro-`p` Groups roadmap supplies the canonical terms `proPOps` and `proPRankInputs` from the named theorems above, and the final rank theorem is stated unconditionally by instantiation at those terms.

Throughout the table `N = [K : ℚ_p]` and `p` is the residue characteristic; `K` is a finite
extension of `ℚ_p` in every row that mentions either.

Reading the table by layer gives the schedule

```text
Pro-p Groups 0-4  →  Local Fields 0-8  →  Pro-p Groups 11  →  Local Fields 9,
```

which is acyclic. Pro-`p` Groups Layers 5–10 have no Local Fields edge in either direction, so
they are unconstrained relative to this order, and Local Fields Layers 0–3 use only the
early pro-`p` foundations.

Two conventions hold across the table, because getting either one wrong is what turns an
acyclic schedule into a circular one or grows a second carrier for an object that already has
one:

- ⚠ **`N` is the degree `[K : ℚ_p]`; `d` is a topological rank and never a degree.** The two
  occur in the same sentences (`d(G_K) = N + 2`, and `d(G_K(p))` is `N + 1` or `N + 2`), so
  neither roadmap writes `d` for the degree, in prose or in a displayed formula.
- ⚠ **Topological finite generation of `G_K` is not an input to Pro-`p` Groups.** Layer 11
  proves finite generation of `G_K(p)` from the `H¹` count alone, and Local Fields Layer 9
  consumes that result. Pro-`p` Groups Layer 8's reconstruction theorem takes
  `IsTopologicallyFinitelyGenerated` as a *hypothesis*: what it consumes is the predicate,
  which is Layer 3's, and never the Local Fields theorem that produces an instance of it.
  Reading that edge the other way would close the cycle
  `Local Fields 9 → Pro-p Groups 8 → Pro-p Groups 9 → Pro-p Groups 11 → Local Fields 9`.

### Other cross-roadmap contracts

The Profinite Cohomology roadmap is the sole owner of the continuous-cohomology substrate and
of every operation on it. This roadmap consumes the declarations below and states nothing about
the substrate itself. Each row gives the consuming milestone, the supplying layer, the exact
declaration, and its mathematical type; a subject name such as "the cup product" is not a
contract, so none appears here. All names are in the namespace
`TauCetiRoadmap.ProfiniteCohomology`.

| Consumer milestone | Supplier layer | Exact declaration | Mathematical type |
|---|---|---|---|
| Layer 5, the coefficient object `trivialFp` | Profinite Cohomology Layer 1 | `TopRep` | the category `Action (TopModuleCat.{u} R) G` of topological representations, with the coefficient ring in its own universe, so `TopRep (ZMod p) G` elaborates for `G : Type u` |
| Layer 5, `cohomFp` and every dimension count | Profinite Cohomology Layer 1 | `map`, `map_id`, `map_comp` | the map on `continuousCohomology` induced by a compatible pair, with its identity and composition laws |
| Layer 11, inflation in degree one; Layer 5, the relation-rank theorem | Profinite Cohomology Layer 1 | `res`, `infl`, `coeffMap` | restriction to a subgroup, inflation along a closed normal subgroup, and the map induced by a map of coefficients |
| Layer 5, the extension dictionary and the cup product | Profinite Cohomology Layers 2 and 3 | `H0`, `H1`, `H2`, `H1pi`, `H2pi`, `explicitH0IsoContinuousCohomology`, `explicitH1IsoContinuousCohomology`, `explicitH2IsoContinuousCohomology` | the explicit invariants, crossed homomorphisms modulo principal ones, and `2`-cocycles modulo coboundaries, with their isomorphisms to the canonical object in degrees `0`, `1`, `2` |
| Layer 5, reading a cocycle statement on the canonical object | Profinite Cohomology Layer 3 | `explicitIso_map`, `explicitIso_res`, `explicitIso_infl`, `explicitIso_coeffMap` | naturality of those isomorphisms under compatible pairs, restriction, inflation and coefficient maps |
| Layer 5, the finite-level computations | Profinite Cohomology Layer 3 | `explicitH1IsoGroupCohomology`, `explicitH2IsoGroupCohomology` | agreement with Mathlib's discrete `groupCohomology` at a finite discrete group |
| Layer 6, the two general reductions of `cd_p` | Profinite Cohomology Layer 4 | `finiteLevelTransition`, `explicitFiniteQuotientSystem1`, `explicitFiniteQuotientColimit1` | the finite-quotient system and the statement that `H¹` is its colimit, which is the filtered-colimit compatibility the reductions use |
| Layer 6, dévissage; Layer 7, the coefficient system `I(χ)/p^i` | Profinite Cohomology Layer 5 | `DiscreteShortExact`, `explicitDelta0`, `explicitDelta1`, `delta`, `explicitIso_delta0`, `explicitIso_delta1` | a short exact sequence of discrete coefficient modules, its connecting maps in the explicit and canonical models, and their agreement |
| Layer 5, the relation-rank theorem; Layer 7, `cd_p = 2`; Layer 11, injectivity in degree two | Profinite Cohomology Layer 5 | `H1ConjInvariants`, `explicitResConj1`, `transgression`, `fiveTerm_exact_H1N`, `fiveTerm_exact_H2Q`, `transgression_comp_res`, `explicitInfl2_transgression` | the five-term inflation-restriction sequence of a closed normal subgroup, with transgression and its two exactness statements |
| Layer 6, the Sylow equality and the Euler formulas | Profinite Cohomology Layer 6 | `corestriction`, `corestrictionLe`, `corestriction_trans`, `corestriction_comp_res`, `corestriction_mackey`, `explicitCor0`, `explicitCor1`, `explicitCor2`, `explicitIso_cor0`, `explicitIso_cor`, `explicitIso_cor2` | corestriction for an open subgroup in all degrees and in degrees `0`, `1`, `2`, with transitivity, `cor ∘ res = [G : U]`, the Mackey formula, and agreement of the two models |
| Layer 6, dimension shifting and the Euler formulas; Layer 7, the duality package | Profinite Cohomology Layer 7 | `Coind`, `coindTopRep`, `coindFunctor`, `shapiroIso`, `coindTrace` | coinduction from a **closed** subgroup and Shapiro's lemma for it, which is what dimension shifting and the Sylow equality need |
| Layer 5, the cup square `cupFp`; Layer 7, the Demushkin predicate; Layer 11, input 3 | Profinite Cohomology Layers 8 and 12 | `TopPairing`, `ofDiscreteModulePairing`, `cup`, `degreeCast`, `cup_add_left`, `cup_add_right`, `cup_assoc`, `cup_gradedComm` | an equivariant continuous bilinear pairing of coefficients, the cup product in every bidegree, and its biadditivity, associativity and graded commutativity |
| Layer 11, surjectivity in degree two; Layer 6, the projection formula | Profinite Cohomology Layers 8 and 12 | `cup_res`, `cup_infl`, `cup_coeffMap`, `cup_projection`, `explicitCup11`, `explicitIso_cup` | compatibility of the cup product with restriction, inflation, coefficient maps and corestriction, and agreement of the canonical cup with the explicit `(1,1)` shape |
| Layer 6, cohomological dimension | Profinite Cohomology Layer 11 | `IsPPrimaryTorsion`, `CohomologicalDimensionLE`, `cd_p`, `cd_p_le_iff`, `cohomologicalDimensionLE_iff_torsion` | the discrete `p`-primary torsion condition, the vanishing predicate, and `cd_p : ℕ∞` with its characterization |
| Layer 6, the two general reductions | Profinite Cohomology Layer 11 | `cd_p_le_iff_finite_pPrimary`, `cd_p_le_iff_boundedExponent` | `cd_p G ≤ n` tested on finite discrete `p`-primary modules, and on modules of bounded exponent |
| Layer 6, `cd` of open subgroups and the Sylow equality | Profinite Cohomology Layer 11 | `cd_p_le_of_isClosed`, `cd_p_eq_of_index_not_dvd` | monotonicity of `cd_p` in a closed subgroup, and equality for an **open** subgroup of index prime to `p` |
| Layer 6, `scd_p` comparisons | Profinite Cohomology Layer 11 | `scd_p`, `cd`, `cd_p_le_scd_p`, `scd_p_le_cd_p_add_one` | the strict dimension, the dimension over all primes, and the two comparisons |

**The Sylow equality is this roadmap's.** `cd_p G = cd_p G_p`, for a `p`-Sylow subgroup `G_p`
from Layer 2, is a Layer 6 milestone here, built on the Sylow theory of Layer 2, which the
Profinite Cohomology roadmap does not develop and excludes by name. The division of labour with
the row above is exact: `cd_p_eq_of_index_not_dvd` supplies the equality for the **open**
subgroups `U ⊇ G_p` whose index is prime to `p`, and this roadmap adds the colimit description
of the cohomology of a closed subgroup together with the Sylow theory that turns those into the
equality for `G_p` itself, which is closed and in general not open. No row crosses in that
direction.

⚠ **Not a supplier.** The Quadratic Form Invariants roadmap is about quadratic forms over
fields in which `2` is invertible, and it excludes characteristic-two quadratic and bilinear
form theory. It supplies nothing here. The characteristic-two bilinear algebra that Labute's
dyadic classification needs is owned in the Layer 9 prerequisites.

## References

- J. P. Labute, *Classification of Demushkin groups*, Canad. J. Math. 19 (1967), 106–132.
  **The source of record for Layers 7 and 9**: the definition on p. 106; §1.3 and §1.4 for
  the rank interpretations; §1.5 for `ℤ_p[[G]]`; §2 for the `q`-central series and the
  graded Lie algebra, Props. 1 to 5; §3 for the invariant `Im χ`, Prop. 6, Thm 4 and its
  corollary; §4 for Thms 5 and 6, the Iwasawa-algebra arguments; Thms 1 and 2 for the
  even-rank classification; §5 for Thms 7 to 9, `G_K(p)`, and the `ℚ₂(√-2)` example.
- J.-P. Serre, *Structure de certains pro-p-groupes (d'après Demuškin)*, Séminaire Bourbaki
  1962/63, no. 252. §2 for the generation and relation criteria and for free ⟺ `H² = 0`; §3
  for Thm 3.1 at `q ≠ 2` and Thm 3.2 at `q = 2` with `n` odd, including the rank-2 family
  `⟨x, y ∣ yxy⁻¹ = x^{-(1+k)}⟩`; §6 and §7 for the `q`-central series and the failure at
  `q = 2`; §9 for Tate's theorems, that is 9.1 `cd = 2` and 9.2 the open-subgroup formula
  `n_H - 2 = [G : H](n_G - 2)`. Its 9.3 characterizes `χ` through a dualizing module, which
  this roadmap replaces by the concrete package of Layer 7.
  ⚠ This source uses the opposite commutator convention; see the conventions.
- J.-P. Serre, *Galois Cohomology* (Springer; translation of *Cohomologie Galoisienne*).
  I §3 and I §4 for `cd`, for free pro-`p` ⟺ `cd ≤ 1`, and for the generator and relation
  ranks; I §4.5 for the Demushkin summary; I Prop. 25 and Prop. 26 for the dualities that
  Labute cites.
- L. Ribes, P. Zalesskii, *Profinite Groups*, 2nd ed., Springer (2010). **The source of
  record for Layers 0 to 4 and 10**: Thm 2.1.3 for the characterizations of profinite
  groups; §2.3 for supernatural order and index, with Prop. 2.3.2 for Lagrange and
  Cor. 2.3.6 for Sylow; §2.6 for generating sets that converge to `1`; §2.8 for the Frattini
  theory, with 2.8.7 for `Φ = closure(Gᵖ[G,G])`, 2.8.10 for finite generation, and 2.8.13
  for the Frattini series as a neighbourhood basis; §3.2 for finite-quotient determinacy,
  3.2.8 and 3.2.9; §3.3 for free pro-`C` groups on profinite spaces, with Prop. 3.3.6 for
  the completion of a free group; Thm 3.6.2 and Cor. 3.6.3 for the open Nielsen–Schreier
  theorem by the transversal route; Ch. 7 for 7.5.1, 7.7.4, 7.7.5 and §7.8, including 7.8.5
  for Golod–Shafarevich.
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed., Springer
  (2008). III §4 and III §7 develop dualizing modules, duality groups and Poincaré groups;
  **that theory is background here, and not a dependency**, because Layer 7 proves the
  concrete statements directly. III §9 is what this roadmap uses: 3.9.1 for Burnside;
  3.9.4 and 3.9.5 for `r = dim H²` and for free ⟺ `cd ≤ 1`; 3.9.7 for Golod–Shafarevich;
  3.9.9 for the definition; 3.9.10 for `ℤ/2`; 3.9.11 for the classification at `q ≠ 2`;
  3.9.12 to 3.9.14 for trace and cup matrices; 3.9.15 for the recognition criteria, of which
  this roadmap states the three that do not mention a dualizing module; and 3.9.19 for the
  existence of the `q = 2` normal forms. From VII §5 it uses 7.5.9, 7.5.10, **7.5.11** for
  the dichotomy for `G_K(p)`, and **7.5.12** for the explicit presentations. VII (7.4.1)
  gives the generator bound `[K : ℚ_p] + 2`.
- H. Koch, *Galois Theory of p-Extensions*, Springer (2002). Ch. 4 for free pro-`p` groups,
  with 4.6 for the universal property, 4.8 for projectivity, 4.10 for the Burnside basis and
  4.12 for free ⟺ `H² = 0`; Ch. 6 for `d(G)` in 6.1 and 6.2, for the relation rank in 6.13,
  and for the Euler-characteristic Schreier formula in Example 6.3; Ch. 10 for
  arithmetically normalized generators of `G_K(p)`, in Thms 10.5, 10.9 and 10.12, where the
  relation is pinned only modulo the Zassenhaus filtration, which is a useful contrast to
  Labute's exact normal forms.
- S. P. Demushkin, *On the maximal p-extension of a local field* (Russian), Izv. Akad. Nauk
  SSSR 25 (1961), 329–346, and *On 2-extensions of a local field* (Russian), Sibirsk. Mat.
  Ž. 4 (1963), 951–955. The original classification at `q ≠ 2`, and the 2-adic attempt that
  Labute Thm 9 corrects with the `U^[f]` family.
- I. R. Shafarevich, *On p-extensions* (Russian), Mat. Sb. 20 (1947), 351–363; translated in
  AMS Transl. Ser. 2, 4 (1956), 59–72. The free case of Layer 11.
- U. Jannsen, K. Wingberg, *Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper*,
  Invent. Math. 70 (1982), 71–98. The full `G_K` for odd `p`, which is the context for why
  the pro-`p` quotient is the first target. It is outside this roadmap.
- M. Lazard, *Sur les groupes nilpotents et les anneaux de Lie*, Ann. Sci. ENS 71 (1954).
  The graded Lie algebra theory under Layers 8 and 9.
- J. D. Dixon, E. Formanek, J. Poland, L. Ribes, *Profinite completions and isomorphic
  finite quotients*, J. Pure Appl. Algebra 23 (1982), 227–231. The determinacy corollary of
  Layer 8 for abstract groups.
