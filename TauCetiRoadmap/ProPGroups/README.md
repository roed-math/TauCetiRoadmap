# Roadmap: pro-p and Demushkin groups

Mathlib has the category of profinite groups with limits, the finite-quotient limit
description, the profinite completion of an abstract group with its adjunction, and Galois
groups as profinite groups. Beyond that it has essentially **nothing**: no pro-`p` groups, no
supernatural orders, no profinite Sylow theory, no topological Frattini/generation theory, no
free profinite or free pro-`p` groups, no presentations of profinite groups, and nothing on
Demushkin groups (audit below). We build here the complete basic theory of profinite and
pro-`p` groups (order and index, Sylow subgroups, Frattini and generation theory, free
pro-`p` groups, presentations and their generator/relator ranks, the pro-`p` part of
cohomological-dimension theory), and carry it to two main theorems: the **classification of
Demushkin groups** (Demushkin, Serre, Labute) with its orientation theory, and the
**structure of the Galois group `G_K(p)` of the maximal `p`-extension of a `p`-adic field**
(Shafarevich free case, Demushkin case with cyclotomic orientation).

Suggested home: `TauCeti/GroupTheory/Profinite/` for Layers 0–3 (foundations, order, Sylow,
pro-`p`/Frattini/generation, parallel to Mathlib's `GroupTheory/` for the abstract half and
`Topology/Algebra/` for the topological half, which is where Mathlib keeps `OpenSubgroup`,
`ClosedSubgroup`, and `ClopenNhdofOne`), and `TauCeti/GroupTheory/ProP/` for Layers 4–11
(free pro-`p`, presentations, cd, Demushkin, classification, the local instance), with the
Demushkin material in `TauCeti/GroupTheory/ProP/Demushkin/`. The category-level statements
(limits, completion) stay phrased against Mathlib's `ProfiniteGrp`.

This roadmap is one of four coordinated roadmaps (with
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1),
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2), and
[Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4))
whose combined target is the reusable foundation under the `G_{ℚ₂}` presentation project
(`roed-math/gq2-lean`, <https://roed314.github.io/gq2/>); its axiom B3c, the identification
`G_{ℚ₂}(2) ≅ D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩` with cyclotomic orientation, is the worked
acceptance instance of Layers 7–11. The Local Fields relationship runs in both directions, at
different layers: Layers 2, 3 and 4 here are consumed near the start of that roadmap, its
Layers 5, 7 and 8 are consumed by Layer 11 here, and its Layer 9 consumes Layer 11. Every one
of those crossings is a row of the shared layer-DAG table under "Ordering and parallelism"
below, together with the name both roadmaps use for it; that table is maintained identically in
the two roadmaps, and nothing passes between them except through a row of it.
below is stated and built for its own sake, and `gq2` appears only as a migration source
(provenance section) and as acceptance criteria. Two things this roadmap does **not** cover:
the Galois action on the étale `π₁` of the thrice-punctured line (`gq2`'s B8), and the
structure of the full absolute Galois group `G_K` rather than its maximal pro-`p` quotient
(Jannsen–Wingberg). Neither is a milestone here and neither is promised elsewhere.

## Standing hypotheses and pinned conventions

- **Profinite idiom.** State theorems against the unbundled type-class stack
  `[Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [TotallyDisconnectedSpace G]`, following what Mathlib itself does at the pin
  (`ProfiniteGrp.of` takes exactly these; `Mathlib/FieldTheory/Galois/Profinite.lean` and
  `Mathlib/Topology/Algebra/ClopenNhdofOne.lean` state their theorems this way). Do **not**
  add `[T2Space G]`: total disconnectedness makes points closed, and a T1 topological group
  is T2, so the hypothesis is derivable; prove that instance chain early (Layer 0) rather
  than carrying the redundancy. Use the bundled category `ProfiniteGrp` only where a
  categorical construction demands it (limits, the completion functor, diagrams); provide
  unbundled restatements of anything a non-categorical consumer needs.
- **Pro-`p`, quotient form.** `IsProP p G := ∀ U : OpenNormalSubgroup G, IsPGroup p (G ⧸ U)`:
  every continuous finite quotient is a `p`-group. This is the *definition*; the
  inverse-limit description (`G` pro-`p` ⟺ `G ≅ lim` of finite `p`-groups) is a Layer 3
  milestone, not the definition. Rationale: the quotient form is a bare `Prop` over the
  unbundled stack, is what every kernel-containment argument uses directly, and matches
  Mathlib's `IsPGroup` vocabulary.
- **Order and index: supernatural numbers, introduced.** We introduce supernatural
  (Steinitz) numbers, `Supernatural := Nat.Primes → ℕ∞`, as a Layer 1 object, with the
  order of a profinite group and the index of a closed subgroup taking values there. This is
  the literature's vocabulary (Ribes–Zalesskii §2.3) and the only clean home for "index
  prime to `p`" for closed (not open) subgroups. The early theorems that Layers 2–3 rely on
  are *also* stated one open subgroup at a time, with Mathlib's `Nat.card`-valued
  `Subgroup.index` (as in the Sylow definition below), so that those layers do not wait on
  the Layer 1 calculus; the supernatural statements are the final forms.
- **Commutator convention.** Classification normal forms follow Labute:
  `(x, y) = x⁻¹y⁻¹xy` (Labute 1967, p. 106; same as NSW III and Koch/RZ's `[g, h]`).
  Mathlib's `⁅x, y⁆ = xyx⁻¹y⁻¹` is the other convention; the two generate the same
  subgroups (`(x, y) = ⁅x⁻¹, y⁻¹⁆`), so subgroup-level statements (lower `p`-series,
  commutator subgroups) use Mathlib's bracket, while element-level relator words are
  written out explicitly in Labute's form. Never let the two mix silently in one statement.
  ⚠ Serre's Bourbaki exposé uses the **opposite** convention (`(x, y) = xyx⁻¹y⁻¹`), and
  NSW VII (7.5.14) yet another; NSW remark (2nd ed., printed p. 419) that the normal-form
  shapes are insensitive because they agree mod `F₃`; cite each source's exact form,
  never a mixture.
- **Topological generation and rank, two notions kept apart.**
  `IsTopologicallyFinitelyGenerated G := ∃ s : Finset G,
  (Subgroup.closure ↑s).topologicalClosure = ⊤`. This exact shape is a contract, and it is
  the *predicate* that is shared: it is the form in which
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s
  finite-generation theorem for `G_K` delivers its conclusion, and the form the reconstruction
  theorem (Layer 8) takes as a hypothesis. ⚠ Layer 8 consumes the predicate, never that
  theorem: reading the dependency the other way would make the two roadmaps circular (see the
  shared layer-DAG table under "Ordering and parallelism"). Rank comes in two declarations,
  never one overloaded one:
  `topologicalGeneratorRank G : Cardinal` is the least cardinality of a subset **converging
  to `1`** whose generated subgroup is dense, and `topologicalGeneratorRankNat G h : ℕ`
  (with `h : IsTopologicallyFinitelyGenerated G`) is its natural-number value, pinned by the
  theorem `topologicalGeneratorRank G = topologicalGeneratorRankNat G h`. Here `s` converges
  to `1` when every open normal subgroup contains all but finitely many elements of `s`; a
  finite set converges to `1` for free, so the two declarations agree in the finitely
  generated case. We write `d(G)` in prose for whichever of the two the surrounding
  statement means, and every statement below says which. General theorems about bases, rank
  invariance, and monotonicity are cardinal statements; finite presentations, deficiency,
  Euler formulas, and everything involving subtraction are natural-number statements
  carrying `IsTopologicallyFinitelyGenerated` explicitly. `ℕ∞` is used in this roadmap for
  supernatural exponents only, never for a generator count.
  ⚠ **Convergence is part of the definition, not a technicality.** Without it the invariant
  is a different one, and not one any theorem below can use: a product of continuum many
  copies of `ℤ/p` is separable (Hewitt–Marczewski–Pondiczery), so a countable subset of it
  generates a dense subgroup, while the group needs `2^{ℵ₀}` generators converging to `1`.
  Every general rank theorem below is about the converging notion, which is also the one
  Ribes–Zalesskii use.
  For the same reason the Burnside identity at infinite rank is an identity with the
  **discrete dual**: for pro-`p` `G`,
  `topologicalGeneratorRank G = dim_{𝔽_p} Hom_cont(G, 𝔽_p) = dim_{𝔽_p} H¹(G, 𝔽_p)` as
  cardinals (Layer 3 for the first equality, Layer 5 for the second). It is **not**
  `Module.rank (ZMod p) (G/Φ(G))`: the Frattini quotient is a profinite `𝔽_p`-vector space
  `𝔽_p^I`, whose algebraic dimension is `p^{|I|}` for infinite `I` (Erdős–Kaplansky), while
  the invariant we want is `|I|`, the dimension of its discrete dual. Under
  `IsTopologicallyFinitelyGenerated` the two coincide and the finite-dimensional form
  `topologicalGeneratorRankNat G h = Module.finrank (ZMod p) (G/Φ(G))` is the one every
  numerical statement uses.
- **Frattini subgroup.** For a pro-`p` group, `Φ(G)` means the intersection of the
  open normal subgroups of index `p`; that it equals the intersection of the maximal open
  subgroups, and equals `closure (Gᵖ[G,G])`, are Layer 3 milestones. Mathlib's abstract
  `frattini G` (the intersection of *all* maximal subgroups, `Order.radical`) is a different
  object in general (abstract maximal subgroups of a pro-`p` group need not be open when
  `G` is not finitely generated), so do not identify the two except as a theorem where true.
- **Presentation formalism.** A presentation of a pro-`p` group `G` is a continuous
  surjection `π : F ↠ G` from a free pro-`p` group with `R = ker π` (automatically closed);
  a presentation *by relators* takes `R` to be the **closed** normal closure of a relator
  set (the algebraic normal closure need not be closed, so always close). A presentation is
  **minimal** when `R ≤ Φ(F)`, equivalently when `rank F = d(G)`. The relation rank `r(G)`
  is defined as `dim_{𝔽_p} H²(G, 𝔽_p)`; that a minimal presentation needs exactly `r(G)`
  relators (`R` is generated as a closed normal subgroup by `dim H¹(R, 𝔽_p)^F = r(G)`
  elements, via the five-term sequence) is the Layer 5 presentation-independence theorem.
- **Demushkin predicate, with its Lean shape pinned.** Labute's definition (p. 106) says: a
  pro-`p` group `G` is Demushkin when `dim_{𝔽_p} H¹(G, 𝔽_p) < ∞`,
  `dim_{𝔽_p} H²(G, 𝔽_p) = 1`, and the cup product `H¹ × H¹ → H²` is nondegenerate. The
  predicate carries its pro-`p` hypothesis as a field rather than leaving it to the ambient
  context, so that no downstream theorem can be applied to a non-pro-`p` group that happens
  to satisfy the cohomological clauses. The intended declaration, in pseudocode (it does not
  compile at the pin, since the cohomology is
  [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)'s, and its
  names are theirs to fix):

  ```
  structure IsDemushkin (p : ℕ) (G : Type u) [Fact p.Prime]
      [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
      [CompactSpace G] [TotallyDisconnectedSpace G] : Prop where
    proP      : IsProP p G
    h1_fin    : Module.Finite (ZMod p) (H 1 G (trivialModule (ZMod p)))
    h2_rank   : Module.finrank (ZMod p) (H 2 G (trivialModule (ZMod p))) = 1
    cupLeft   : ∀ a ≠ 0, ∃ b, cup a b ≠ 0
    cupRight  : ∀ b ≠ 0, ∃ a, cup a b ≠ 0
  ```

  Here `trivialModule (ZMod p)` is PR #1's trivial discrete `G`-module on `ZMod p` and `cup`
  its `H¹ × H¹ → H²` cup product. Both nondegeneracy clauses are fields. If PR #1 delivers
  graded-commutativity of the cup product in this bidegree, `cupRight` becomes a theorem and
  the field is dropped: one change, recorded here, not two coexisting conventions. Finite
  generation is **derived** (`h1_fin` plus the Burnside basis theorem), never assumed.
  **Rank-1 and degenerate conventions:** `n = 1` is allowed by the definition, and `ℤ/2`
  (at `p = 2`) is the unique finite Demushkin group and the unique rank-1 one (for `p` odd
  the cup pairing on `H¹` is alternating, so on a one-dimensional space it vanishes and
  cannot be nondegenerate); `ℤ_p` is **not** Demushkin (`H² = 0`; it is free pro-`p` of
  rank 1), and no theorem here adopts the occasional literature convention that smuggles it
  in. Labute's
  normal-form theorems require `n ≥ 2` (case `q ≠ 2`) or hold vacuously/separately at
  `n = 1`; each classification statement below carries the `n` hypothesis it actually needs.
- **The `q`-invariant and the orientation, Labute's normalizations.** For a Demushkin group,
  `G^{ab} := G ⧸ closure [G,G]` (the *topological* abelianization) satisfies
  `G^{ab} ≅ ℤ_p^{n-1} × ℤ_p/qℤ_p` with `q = q(G)` a power of `p` or `0`; **`q = 0` is
  Labute's `p^∞` convention for the torsion-free case** and is encoded as the literal `0`.
  The structure theory of finitely generated abelian pro-`p` groups (end of Layer 4) gives
  the decomposition `G^{ab} ≅ ℤ_p^r × T` with `T` finite; that `r = n - 1` and that `T` is
  cyclic come from the one-relator presentation and are proved in Layer 7. `demushkinQ` is
  defined from that torsion subgroup, and never by a containment condition on `Im χ`.
  The **canonical character** (Serre's invariant) is fixed by a prescription property.
  Write `I(χ)` for `ℤ_p` with `G` acting through `g · x = χ(g)x`, and `I(χ)/p^i` for the
  finite discrete quotient `ℤ/p^i` with the induced action. The finite discrete modules are
  the primary objects, since those are what PR #1's cohomology takes. For a continuous
  `χ : G → ℤ_pˣ` the following three conditions on `χ` are equivalent (Labute Prop. 6, for
  `dim H¹(G, 𝔽_p) < ∞`), and *the prescription property* names any one of them:
  1. `H¹(G, I(χ)/p^{i}) → H¹(G, I(χ)/p)` is surjective for every `i ≥ 1`;
  2. `H²(G, I(χ)/p^{i}) → H²(G, I(χ)/p^{i-1})` is injective for every `i ≥ 2` (equivalently
     the connecting map `H¹(G, I(χ)/p^{i-1}) → H²(G, I(χ)/p)` of the coefficient sequence
     `0 → I(χ)/p → I(χ)/p^{i} → I(χ)/p^{i-1} → 0` vanishes);
  3. for a minimal generating tuple `g₁, …, g_n` of `G` and every `(c₁, …, c_n) ∈ ℤ_p^n`
     there is a continuous crossed homomorphism `f : G → I(χ)` with `f(g_j) = c_j`.
  Condition 3 is phrased through the inverse system of finite quotients: for
  every `i` there is a crossed homomorphism `G → I(χ)/p^i` with the prescribed values mod
  `p^i`, compatibly in `i`. A crossed-homomorphism object valued in `I(χ)` itself is used
  only after Layer 7 makes the inverse-limit topology and continuous-cocycle type targets in
  their own right. **Theorem (Serre, Labute Thm 4):** a Demushkin group admits exactly one
  continuous `χ` with the prescription property; `demushkinCharacter G` is that `χ`, `Im χ`
  is a closed subgroup of `ℤ_pˣ`, and it is invariant under topological isomorphism.
  Labute's nonexceptional theorem gives
  `Im χ = 1 + qℤ_p` when `q ≠ 2`, so `(n, q)` is then complete. When `q = 2`
  (only possible for `p = 2`) it is not, and the classification is by `(n, Im χ)`, where
  the possible images are read off the closed-subgroup trichotomy of
  `ℤ₂ˣ = {±1} × (1 + 4ℤ₂)`: the subgroups `U^(f) = 1 + 2^f ℤ₂` (`f ≥ 2`, or `f = ∞`
  meaning `{1}`), `{±1} × U^(f)`, and `U^[f] = closure ⟨-1 + 2^f⟩` (`2 ≤ f < ∞`,
  procyclic); this is the Remark after the Corollary to Labute's Thm 4. All statements use these
  normalizations; do not substitute other parametrizations of the image.
- **Free pro-`C` generality, decided up front.** The class `C` is a bundled structure, not a
  loose predicate. `FiniteGroupClass` is a structure whose data is a predicate
  `mem : ∀ (H : Type) [Group H] [Finite H], Prop` together with proofs of: invariance under
  group isomorphism; membership of the trivial group; closure under subgroups; closure under
  quotients; and closure under extensions (if `N ⊴ H` with `N` and `H/N` in the class, then
  `H` is). Closure under finite products is derived from the trivial group and extensions,
  so it is a theorem, not a field. Universes: `mem` quantifies over `Type` and finite groups
  in higher universes are handled through `Shrink`, with the isomorphism-invariance field
  making that harmless; this is the resizing policy, stated once and used everywhere. The
  `C`-kernel `proCKernel C G` (intersection of the open normal subgroups whose quotient is
  in `C`), the completion `proCCompletion`, and `freeProC C X` are all defined from this
  structure, and `finiteGroupClassP p` (finite `p`-groups) instantiates it, with
  `freeProC (finiteGroupClassP p) X ≅ freeProP p X` a theorem. The core layers (4–9) build
  these **on finite generating sets** (`Fin n` and finite types): that is what
  presentations, Demushkin theory, and the arithmetic instances need. The free pro-`C` group
  on a general **profinite space** (basis
  converging to 1) is Layer 10, a definite later layer rather than an afterthought: its universal
  property quantifies over continuous maps `X → P` from the profinite space, it recovers
  the finite-set object on discrete finite `X`, and it is required for infinite-rank
  subgroup theory (closed subgroups of free pro-`p` groups). For an *infinite discrete set*
  the profinite completion of the discrete free group is the "free pro-`p` group on the
  abstract set" (all maps classify) and differs from the converging-to-1 object; the
  finite-set core avoids the ambiguity, and Layer 10 states both and relates them.
- **Naming.** `IsProP`, `IsTopologicallyFinitelyGenerated`, `ConvergesToOne`,
  `topologicalGeneratorRank`, `topologicalGeneratorRankNat`, `proPKernel`,
  `maximalProPQuotient`, `proPFrattini`, `IsFiniteContinuousQuotient`, `Supernatural`,
  `profiniteOrder`, `profiniteIndex`, `IsProPSylow`, `FiniteGroupClass`,
  `pLowerCentralSeries` (0-based, matching Mathlib's `lowerCentralSeries`; Labute's `F_i` is
  index `i - 1`), `freeProfiniteGroup`, `freeProC`, `freeProP`, `presentedProP`,
  `topAbelianization`, `IsDemushkin`, `demushkinRank`, `demushkinQ`, `demushkinCharacter`.
  `Suggested.lean` fixes the forms. The maximal pro-`p` quotient has exactly one name:
  `proPKernel p G` is the subgroup and `maximalProPQuotient p G := G ⧸ proPKernel p G` the
  quotient. `G(p)` is
  informal prose for `maximalProPQuotient p G` and nothing else; there is no `maxProP`.

## What Mathlib already has (consume)

At the build pin (`9caeba1000`, 2026-06-03):

- **The `ProfiniteGrp` category:** `Mathlib/Topology/Algebra/Category/ProfiniteGrp/Basic.lean`
  (Guan–Zhang–Zhao: the category, `of`, `ofFiniteGrp`, `ofClosedSubgroup`, `pi`, limits via
  `limitCone`/`limitConeIsLimit`), `Limits.lean` (every profinite group is the limit of its
  finite quotients: `toLimit_surjective`/`toLimit_injective`,
  `continuousMulEquivLimittoFiniteQuotientFunctor`), and `Completion.lean` (A. Topaz, Feb
  2026: `ProfiniteGrp.completion` over `FiniteIndexNormalSubgroup G`, the unit `eta`,
  `denseRange`, `mono_eta_iff_residuallyFinite`, `lift`, and the adjunction
  `profiniteCompletion ⊣ forget₂`). Consume all of it; the free profinite group *is*
  `profiniteCompletion` applied to a free group.
- **Subgroup infrastructure:** `Mathlib/Topology/Algebra/OpenSubgroup.lean` (`OpenSubgroup`,
  `OpenNormalSubgroup`, clopenness, `Finite (G ⧸ U)` on compact groups),
  `Mathlib/Topology/Algebra/Group/ClosedSubgroup.lean` (`ClosedSubgroup`,
  `normalCore_isClosed`, closed + finite index ⟹ open),
  `Mathlib/Topology/Algebra/ClopenNhdofOne.lean`
  (`exist_openNormalSubgroup_sub_open_nhds_of_one`, the open-normal neighborhood basis,
  and `closedSubgroup_eq_sInf_open`: a closed subgroup of a profinite group is the
  intersection of the open subgroups above it), `Subgroup.topologicalClosure` and its
  normality (`Mathlib/Topology/Algebra/Group/Basic.lean`).
- **Galois groups as profinite groups:** `Mathlib/FieldTheory/KrullTopology.lean`
  (`krullTopology`, T2, total separatedness), `Mathlib/FieldTheory/Galois/Profinite.lean`
  and `Infinite.lean` (`Gal(K/k) ≅ lim` finite Galois groups, `CompactSpace` instance).
  These are the instances that make every Galois group a customer of this roadmap.
- **Finite group theory:** `Mathlib/GroupTheory/Sylow.lean` (finite Sylow theory, the
  levelwise input to Layer 2), `PGroup.lean` (`IsPGroup`), `Mathlib/GroupTheory/Frattini.lean`
  (abstract `frattini G` as `Order.radical`, `frattini_nongenerating`, `frattini_nilpotent`
  are consumed at the finite levels; see the convention above for why it is not the pro-`p`
  Frattini subgroup), `Nilpotent.lean` (`lowerCentralSeries`, the naming model for the
  lower `p`-series), `Index.lean` (`Subgroup.index`, `relindex`, both `Nat.card`-valued),
  `Finiteness.lean` + `Rank.lean` (`Group.FG`, `Group.rank`), `PresentedGroup.lean` and
  `FreeGroup/` (the discrete objects we complete), `ResiduallyFinite.lean`
  (`Group.ResiduallyFinite`, used by the completion API).
- **`p`-adics:** `Mathlib/NumberTheory/Padics/` (`ℤ_[p]`, `ℤ_[p]ˣ`, `toZModPow`), the home
  of the orientation character's target; `Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean`
  (`cyclotomicCharacter L p : (L ≃+* L) →* ℤ_[p]ˣ`), the character Layer 11 identifies
  with the canonical one.
- **Discrete group cohomology:** `Mathlib/RepresentationTheory/Homological/GroupCohomology/`
  (`H1`, `H2`, `LowDegree`, `Functoriality`, `Shapiro`, long exact sequences, for
  *discrete* groups). Useful for finite-level computations; the continuous theory is the
  ProfiniteCohomology sibling's subject, not ours and not this.

**On master since the pin (track, flag refactor-onto milestones):** continuous cohomology
exists as `Mathlib/RepresentationTheory/Homological/ContCohomology/{Basic,Functoriality,LowDegree}.lean`
(R. Hill, A. Yang, E. Xie; PRs #41144 merged 2026-07-02, #41309 merged 2026-07-03), with
all-degrees `continuousCohomology` via the coinduced resolution but explicit `H⁰` only; open
PRs #41545 (inflation maps, rmhi, 2026-07-11) and #41539 (functoriality refactor, rmhi,
updated 2026-07-27); cup products exist only in FLT staging
(`FLT/Mathlib/.../ContCohomology/CupProduct.lean`, E. Xie, FLT#1098, 2026-07-10). The
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1) owns the interface to this
line of work; every cohomological statement below is written against *its* API, and
refactors onto Mathlib's `ContCohomology` land there, not here. Also relevant on master:
`ProfiniteGrp` additivization (#39973, T. Browning, 2026-06-19). Open PRs to watch:
**#35603** (Frattini extras for finite `p`-groups including the elementary-abelian Frattini
quotient, the finite half of our Layer 3; coordinate with it and use it when it lands),
**#42200** (`IsMulFG` unification, tb65536, the substrate a Mathlib-native
"topologically f.g." would sit on), **#41961** (Iwasawa algebra of measures on profinite
groups, D. Loeffler), adjacent to the completed group algebra `ℤ_p[[Γ]]` that Layer 9's
`q = 2` arguments use. ⚠ #41961 is a **refactor target, not a prerequisite**: the
procyclic completed-algebra package this roadmap needs is specified and owned below (Layer 9
prerequisites), and if a compatible upstream carrier lands, the same theorems are reproved
against it or connected to ours by an explicit comparison isomorphism. No milestone here
waits on the state of an external PR.

## What is missing (build here)

Everything pro-`p`. At the pin **and on master** there is no pro-`p` predicate, no
supernatural order or index, no profinite Sylow theory, no topological finite generation,
no pro-`p` Frattini theory or Burnside basis theorem, no free profinite or free pro-`p`
groups (the completion functor exists but is never applied to free groups), no profinite
presentations, no Hopfian/Gaschütz/reconstruction theory, no lower `p`-series, no
cohomological-dimension results for pro-`p` groups, and no Demushkin theory (verified
against master `ccedd50412`, 2026-07-30; "Demushkin" has zero PRs in any state). The Zulip archive
shows no one building or claiming any of it (the only
pro-`p` design artifact on Zulip is a sketch of a pro-`p` `GroupFilterBasis` in the
Dec 2024 "Refactor `krullTopology`?" thread, never landed). External-repo audit and the
one overlap (a brand-new AI-generated pro-`C` library) are in the coordination section.

---

## The build, in layers

The ordering is the dependency order. As each layer makes the next layer's *types*
expressible in `TauCeti/`, state its milestones in `Suggested.lean` (with `sorry`).
Layers 5–7, 9, and 11 have cohomological statements stated against the
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1) (H¹, H², cup products,
five-term exact sequence, cd formalism); their non-cohomological substatements do not block
on it.

### Layer 0: profinite foundations

- **The instance chain.** Totally disconnected topological groups are T1 (components are
  closed), hence T2, hence T3; a compact totally disconnected group is profinite in every
  sense already in Mathlib. Prove the missing glue instances once, so no statement ever
  carries `[T2Space G]` redundantly.
- **Quotients.** For `G` profinite and `N` a *closed* normal subgroup, `G ⧸ N` is profinite:
  the missing ingredient is `TotallyDisconnectedSpace (G ⧸ N)` (clopen-image basis
  argument); package with the (existing) compactness and topological-group instances.
  ⚠ Closedness of `N` is essential and must be a hypothesis, not an afterthought: quotients
  by non-closed subgroups are not even T1.
- **Closed and open subgroups.** Closed subgroups of profinite groups are profinite
  (the instances exist; assemble them); an element lying in every open normal subgroup is `1`;
  consume `closedSubgroup_eq_sInf_open`; open ⟺ closed of finite index; the correspondence
  between open normal subgroups of `G ⧸ N` and open normal subgroups of `G` above `N`.
- **Inverse limits, unbundled.** Consume `ProfiniteGrp.Limits`; provide the unbundled form
  that later layers use constantly: a compatible family of elements of the finite quotients
  of `G` comes from a unique element (surjectivity and injectivity of `toLimit`, restated
  for consumers outside the category), and the compactness lemma "a directed family of nonempty
  closed subsets of a
  profinite set has nonempty intersection" in the exact König form Layer 8 uses.
- **Profinite completion.** Consume `ProfiniteGrp.ProfiniteCompletion` wholesale. Add: the
  unbundled universal property (continuous homs from the completion to a profinite `P`
  biject with abstract homs from `G`); the unit is bijective on a finite group
  (`Suggested.lean`); the completion of a topologically finitely generated profinite group's
  underlying abstract group is **not** developed here; instead record the warning that abstract
  homs out of profinite groups need not be continuous, so the completion of the *abstract*
  underlying group is generally larger (Nikolov–Segal territory, out of scope).
  ⚠ No global second-countability hypotheses anywhere in this roadmap: absolute Galois
  groups of general fields are not second countable, and every foundation layer must apply
  to them. Where a later theorem wants a countable neighborhood basis it carries
  "countably many open normal subgroups" as an explicit hypothesis, discharged in Layer 3
  for topologically finitely generated groups. Nothing in Layer 0 assumes or proves
  countability: the proof runs through the finiteness of the set of open subgroups of each
  index, which is a Layer 3 theorem.

### Layer 1: supernatural order and index

- **Supernatural numbers.** `Supernatural := Nat.Primes → ℕ∞` with: divisibility (pointwise
  `≤`), multiplication (pointwise `+`), `lcm`/`gcd` (pointwise `⊔`/`⊓`), the embedding
  `ℕ+ → Supernatural` by prime factorization (`padicValNat`), "is a natural number"
  (finitely supported with finite values), and `p`-primary / prime-to-`p` parts. This is
  order theory on exponent functions; keep it computation-friendly.
- **Order of a profinite group.** `profiniteOrder G : Supernatural`, at each prime the
  supremum of the valuations of the finite quotient orders. Compatibility: on a finite
  (discrete) group it is the factorization of `Nat.card G` (`Suggested.lean`).
- **Index of a closed subgroup, one definition and one theorem.** For `H ≤ G` closed, the
  **pinned definition** is primewise through the finite quotients:
  `profiniteIndex H G ℓ = ⨆_N v_ℓ ([G/N : HN/N])`, the supremum over open normal `N ≤ G` of
  the `ℓ`-adic valuation of the index of the image of `H` in `G/N` (a `ℕ∞`-valued supremum
  of naturals, computed with `padicValNat`). Both `G` and `H` live in the same universe;
  closedness of `H` is a hypothesis of every theorem below, not of the definition, which is
  written for arbitrary `H`. **Theorem:**
  `profiniteIndex H G = ⨆ {U : OpenSubgroup G // H ≤ U}, [G : U]` in the supernatural
  lattice (the lcm-over-open-overgroups description) for `H` closed; this is the
  characterization the literature uses and the one downstream arguments quote, and it fails
  for non-closed `H`, which is why closedness is a hypothesis and not decoration. Basic API,
  all of it needed later: invariance under topological isomorphism (of the pair);
  `profiniteIndex H G = 1 ↔ H = ⊤` for closed `H`; multiplicativity in towers
  `K ≤ H ≤ G` of closed subgroups; the image formula under a continuous surjection
  `G ↠ G/N`; **Lagrange**,
  `profiniteOrder G = profiniteOrder H * profiniteIndex H G` (Ribes–Zalesskii §2.3); and
  agreement with Mathlib's `Nat.card`-valued `Subgroup.index` for open `H`, in the form
  `profiniteIndex H G = ofNat (H.index)`.
- **Pro-`p` ⟺ order a power of `p`** (`Suggested.lean`), and `H` open ⟺ closed of finite
  (natural-number) index, restated supernaturally.

### Layer 2: profinite Sylow theory

- **Definition.** `IsProPSylow p P`: `P` closed, pro-`p` (subspace), and of index prime to
  `p`. The per-quotient form is in `Suggested.lean`; the supernatural form
  (`¬ p ∣ profiniteIndex P G`) is proved equivalent to it here.
- **Existence.** Every profinite group has a `p`-Sylow subgroup: the sets of Sylow
  `p`-subgroups of the finite quotients form a surjective inverse system of nonempty finite
  sets; apply the Layer 0 compactness lemma. (Consume `Mathlib/GroupTheory/Sylow.lean` at
  the finite levels.)
- **Conjugacy and the poset.** Any two `p`-Sylow subgroups are conjugate (same inverse-limit
  argument over the finite conjugating sets); every closed pro-`p` subgroup is contained in
  a `p`-Sylow subgroup; a pro-`p` subgroup of index prime to `p` is maximal pro-`p`, and
  conversely a maximal closed pro-`p` subgroup is `p`-Sylow.
- **Functoriality.** The image of a `p`-Sylow subgroup under a continuous surjection is
  `p`-Sylow (`IsProPSylow.map_of_surjective`); the `p`-Sylow subgroup of an inverse limit is an
  inverse limit of `p`-Sylow subgroups. Together with `IsProPSylow`, `exists_isProPSylow`,
  `IsProP.exists_le_isProPSylow` and `IsProPSylow.eq_of_normal` above, these are the citable
  targets [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)
  consumes for wild inertia (the `p`-Sylow of the inertia/ramification groups); keep every one
  of their statements free of Galois vocabulary.
- **Worked instances** (`Suggested.lean`): the Galois group of any Galois extension has
  `p`-Sylow subgroups; every `p`-Sylow subgroup of `ℤ̂ = completion ℤ` is topologically
  isomorphic to `ℤ_p`. The second uses the `ℤ_p` identification chain of Layer 4, so it
  is stated here but proved there, where the universal properties it needs are available. It
  does **not** go through a product decomposition `ℤ̂ ≅ ∏_ℓ ℤ_ℓ`; that decomposition is not
  a target of this roadmap and no argument below assumes it.

### Layer 3: pro-`p` groups, the maximal pro-`p` quotient, Frattini theory, generation

- **The `IsProP` API.** Stability under closed subgroups, quotients by closed normal
  subgroups, finite products, inverse limits; the **equivalence milestone**: a profinite
  group is pro-`p` iff it is (continuously isomorphic to) a limit of finite `p`-groups, via
  `ProfiniteGrp.Limits` and `ofFiniteGrp`.
- **The maximal pro-`p` quotient.** `proPKernel p G` (intersection of open normals with
  `p`-group quotient) with its full subgroup API: closed, normal, characteristic (preserved
  by every topological automorphism), and preserved by continuous homomorphisms. Then
  `maximalProPQuotient p G := G ⧸ proPKernel p G`, which is pro-`p` (compactness: an open
  normal subgroup containing the kernel already contains a member of the defining family).
  Its quotient map, universal property (continuous maps to pro-`p` groups factor uniquely;
  both in `Suggested.lean`), idempotence on pro-`p` groups, and functoriality in `G` are
  stated once, here, and every later layer cites them rather than restating them.
- **Topological generation and rank.** `Subgroup.topologicalClosure`-based generation API;
  `IsTopologicallyFinitelyGenerated` (pinned shape above); generation passes along
  continuous surjections. The convergence predicate (`s` converges to `1` when every open
  normal subgroup omits only finitely many elements of `s`) with its basic API: finite sets
  converge, subsets and continuous images of converging sets converge, and **every profinite
  group has a generating set converging to `1`** (RZ Prop. 2.6.2), so that
  `topologicalGeneratorRank G : Cardinal` is an infimum over a nonempty family. Then:
  monotonicity of the rank under continuous surjections
  (`topologicalGeneratorRank_le_of_surjective`, a row of the shared layer-DAG table);
  invariance under topological isomorphism; finiteness of the cardinal iff
  `IsTopologicallyFinitelyGenerated G`; and the
  accessor `topologicalGeneratorRankNat G h : ℕ` with
  `(topologicalGeneratorRankNat G h : Cardinal) = topologicalGeneratorRank G`,
  proof-irrelevant in `h`. Every numerical rank statement in this roadmap is about the
  accessor.
- **Finitely many open subgroups of each index, and countability.** A topologically finitely
  generated profinite group has finitely many open subgroups of each index (finitely many
  continuous maps to each finite group). The consequences that later layers cite, all proved
  here: the set of open subgroups is countable; the set of open normal subgroups is
  countable; there is a descending sequence `(N_k)` of open normal subgroups cofinal among
  all of them (enumerate and intersect finite initial segments); and hence, for a compatible
  system indexed by that sequence, the sequential form of the Layer 0 compactness lemma:
  a sequence of nonempty finite sets with surjective bonding maps has a limit point. Layer 8
  uses the sequential form; it is a corollary of the general compact-inverse-limit theorem
  stated in Layer 0, which is the version to prefer wherever it suffices. Companion bound:
  an open subgroup `U` of a topologically finitely generated profinite group is topologically
  finitely generated, with `d(U) ≤ 1 + [G : U](d(G) - 1)` in natural numbers (the Schreier
  bound, `topologicalGeneratorRankNat_le_of_isOpen`; RZ Cor. 3.6.3), with equality in the free
  case (Layer 6). That bound is a row of the shared layer-DAG table: the Local Fields roadmap's
  Layer 9 runs its lower bound through it.
- **Hopf property.** A continuous surjective endomorphism of a topologically finitely
  generated profinite group is an isomorphism (`Suggested.lean`). This is the last step of
  every two-sided comparison in Layer 8.
- **Gaschütz lifting.** Along a continuous surjection of profinite groups, an `n`-tuple
  topologically generating the target lifts to an `n`-tuple topologically generating the
  source, provided the source is topologically generated by `n` elements
  (`Suggested.lean`). Nakayama-style corollary: for a quotient map with kernel inside
  `Φ(G)`, generators lift verbatim.
- **Frattini theory for pro-`p` groups.** For pro-`p` `G`: maximal open subgroups are
  normal of index `p` (finite `p`-group input: maximal subgroups of a finite `p`-group are
  normal of index `p`; consume or complete Mathlib's `Frattini.lean` and coordinate with
  PR #35603); `proPFrattini p G` (index-`p` form) is closed, normal, and characteristic, and
  equals both the intersection of the maximal open subgroups and `closure (Gᵖ[G,G])`
  (`Suggested.lean`); the Frattini quotient `G/Φ(G)` is elementary abelian, an
  `𝔽_p`-vector space.
- **Burnside basis theorem.** Elements generate `G` topologically iff their images generate
  `G/Φ(G)` topologically (`topologicallyGenerates_iff_frattiniQuotient`; the closure on the
  quotient side is needed: at infinite rank the images of a generating set span only a dense
  subspace of the Frattini quotient). This generation form, not the numerical one below, is
  what the Local Fields roadmap's Layer 9 cites for its tame frame. Also here: the
  index-`p` detection form (a closed subgroup contained in no open normal subgroup of index
  `p` is everything) and the surjectivity criterion for continuous homomorphisms (surjective
  onto every index-`p` quotient ⟹ surjective), both in `Suggested.lean`. The rank identity
  is proved first as an equality of cardinals, with no finiteness hypothesis, and against the
  **discrete dual**:
  `topologicalGeneratorRank G = Module.rank (ZMod p) (Hom_cont(G/Φ(G), 𝔽_p))`, where
  `Hom_cont(G/Φ(G), 𝔽_p) = Hom_cont(G, 𝔽_p)` is a discrete `𝔽_p`-vector space. (This is
  where the converging-to-`1` condition earns its place: a continuous functional kills all
  but finitely many members of a converging set, so restriction embeds the dual in the
  finitely supported functions on that set, which bounds the dual's dimension by the set's
  cardinality; the dual basis of a converging basis gives the other inequality.) Then `G` is
  topologically finitely generated ⟺ `G/Φ(G)` is finite (`Suggested.lean`), and in that case
  the dual has the same finite dimension as `G/Φ(G)` itself, so
  `topologicalGeneratorRankNat G h = Module.finrank (ZMod p) (G/Φ(G))`.
  ⚠ **Abstract versus topological generation:** all statements are about *topological*
  generation; the Frattini quotient argument is why the two agree numerically for
  pro-`p` groups, but never conflate the closures. Sanity example: `d = 2` for
  `ℤ/4 × ℤ/2` (`Suggested.lean`, via `Group.rank` on the finite instance).

### Layer 4: free pro-`p` (and pro-`C`) groups on finite sets

- **The class `C` as a structure.** `FiniteGroupClass` with the five fields listed in the
  conventions (isomorphism invariance, trivial group, subgroups, quotients, extensions),
  the derived finite-product theorem, and the `Shrink`-based resizing policy. From it:
  `proCKernel C G`, closed, normal, and characteristic, with the same API as `proPKernel`;
  `proCCompletion C G := G ⧸ proCKernel C G` with its universal property; and the
  instantiation `finiteGroupClassP p`, together with `proCKernel (finiteGroupClassP p) G =
  proPKernel p G`. Every pro-`C` statement below is about this structure; there are no
  per-class constructions.
- **Construction.** `freeProfiniteGroup X := profiniteCompletion (FreeGroup X)`;
  `freeProC C X := proCCompletion C (freeProfiniteGroup X)`; and
  `freeProP p X := maximalProPQuotient p (freeProfiniteGroup X)`, the pro-`p` quotient
  taken directly, since `proPKernel` and `proCKernel (finiteGroupClassP p)` are cut out by
  different index sets and agree by a short theorem rather than by unfolding. That
  theorem, `freeProC (finiteGroupClassP p) X ≅ freeProP p X`, is the first milestone below;
  after it no statement has to choose between the two constructions.
- **Universal property.** Maps `X → P` into a profinite `P` in the class `C` extend uniquely
  to continuous homomorphisms (`Suggested.lean` states the pro-`p` case); uniqueness of the
  free object up to unique isomorphism; functoriality in `X`. The ambient case is stated in its
  own right and named `freeProfiniteGroup.lift`, not left implicit in the pro-`C` one: it is
  what [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 4 consumes.
- **Presented profinite groups.** `presentedProfiniteGroup X rels`, the free profinite group on
  `X` modulo the *closed* normal closure of `rels`, with its universal property (continuous
  homomorphisms out of it are the ones killing every relator) and its finite-generation
  corollary; `presentedProP` is its pro-`p` analogue, and the theorem relating the two is
  stated here rather than assumed. The profinite one is the object
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 4 states the
  Iwasawa presentation `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^{−q}⟩` against; ⚠ it is not `presentedProP`, whose
  pro-`p` quotient would lose the prime-to-`p` tame inertia that presentation is about.
- **Basics.** `freeProP p X` is pro-`p`, and for finite `X` it is topologically finitely
  generated (`Suggested.lean`) of rank `|X|`: `topologicalGeneratorRank (freeProP p X) = #X`
  as cardinals, via the Frattini quotient `(ℤ/p)^X` (Layer 3), with the natural-number form
  `topologicalGeneratorRankNat (freeProP p (Fin n)) h = n`. For infinite `X` the rank of
  this object is **not** `#X`, which is why the free objects on infinite bases are Layer 10
  and are built there on a profinite space rather than on a set. The generators are a basis:
  free groups are **residually `p`**, so `FreeGroup X → freeProP p X` is injective
  (`Suggested.lean`; the classical finite-`p`-quotient separation argument, e.g. via the
  finite Heisenberg/upper-triangular representations or the lower `p`-series of the discrete
  free group).
- **Rank one and `ℤ_p`, by universal properties.** `freeProP p (Fin 0) ≅ 1`, and the rank-one
  identification proved as a chain of universal properties, each step a named theorem, with
  no product decomposition of `ℤ̂` anywhere in it:
  1. `maximalProPQuotient p (profiniteCompletion ℤ) ≅ lim_n ℤ/p^nℤ` as topological groups
     (the open normal subgroups of `ℤ̂` with `p`-group quotient are the `p^nℤ̂`);
  2. `lim_n ℤ/p^nℤ ≅ ℤ_p`, i.e. Mathlib's `ℤ_[p]` with its `toZModPow` system is that
     inverse limit as a topological ring, hence as a topological group;
  3. `freeProP p (Fin 1) ≅ Multiplicative ℤ_[p]`: both represent the same functor
     (continuous homomorphisms from either to a pro-`p` group `P` are in natural bijection
     with elements of `P`), so the free object's uniqueness gives the isomorphism;
  4. a closed subgroup `P ≤ ℤ̂` is `p`-Sylow iff the composite `P ↪ ℤ̂ ↠
     maximalProPQuotient p ℤ̂` is a topological isomorphism, which with (1) and (2) proves
     the Layer 2 worked instance.
  Step 3 is what every later `ℤ_p`-coefficient argument cites, in particular the
  identification of `Hom_cont(G, ℤ_pˣ)`-valued characters in Layer 7.

#### Finitely generated abelian pro-`p` groups

Self-contained, and stated without reference to Demushkin groups: nothing in this subsection
mentions them, and the specialization to `G^{ab}` for a Demushkin `G` is Layer 7's. Layer 7
cannot define `q(G)` without this material, and several Layer 9 module arguments use it.
RZ §4.3 is the source of record.

- **Exponentiation by `ℤ_p`.** For `A` abelian pro-`p`, the continuous action
  `ℤ_p × A → A`, `(λ, a) ↦ a^λ`, obtained as the inverse limit of exponentiation in the
  finite abelian `p`-quotients (where `ℤ_p` acts through `ℤ/p^n`); well-definedness is the
  compatibility of those actions, continuity is the limit topology.
- **The `ℤ_p`-module structure.** `A` becomes a topological `ℤ_p`-module, functorially in
  continuous homomorphisms of abelian pro-`p` groups; closed subgroups and quotients are
  submodules and quotient modules; and a continuous group homomorphism between abelian
  pro-`p` groups is automatically `ℤ_p`-linear.
- **Compact `ℤ_p`-modules.** In the topologically finitely generated case, the resulting
  functor from abelian pro-`p` groups to finitely generated `ℤ_p`-modules is an equivalence
  onto its image, in the direction used here: a topologically finitely generated abelian
  pro-`p` group is a finitely generated `ℤ_p`-module, and the two notions of generation
  agree. (The full equivalence of categories is not needed and is not a target.)
- **Structure theorem.** `A ≅ ℤ_p^r × T` as topological `ℤ_p`-modules, with `T` a finite
  abelian `p`-group; `r` and the elementary divisors of `T` are uniquely determined. `T` is
  exactly the torsion subgroup of `A`, and it is closed and open in `A` when `r = 0` and
  closed always. Route: the structure theorem for finitely generated modules over the
  principal ideal domain `ℤ_p` (Mathlib has this), plus the statement that the algebraic
  and topological decompositions agree.
- **The pro-`p` completion of `ℤ`.** The universal-property proof that `freeProP p (Fin 1)`,
  `maximalProPQuotient p (profiniteCompletion ℤ)`, and `Multiplicative ℤ_[p]` agree is the
  rank-one item above; here it is restated as the `ℤ_p`-module fact that `ℤ_p` is the free
  `ℤ_p`-module of rank 1 and the two notions of rank agree.

### Layer 5: presentations and the rank interpretations

Cohomological statements here consume [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
(H¹, H² of profinite groups with `𝔽_p` and finite discrete coefficients, inflation,
restriction, transgression, the five-term exact sequence of a closed normal subgroup).

- **Presentations.** `presentedProP p X rels` (free pro-`p` mod closed normal closure of
  relators); **every topologically finitely generated pro-`p` group `G` admits a
  presentation by a free pro-`p` group of finite rank**, and admits a *minimal* one, with
  `topologicalGeneratorRankNat F = topologicalGeneratorRankNat G`, characterized by
  `R ≤ Φ(F)`. Presentations of arbitrary pro-`p` groups quantify over free objects on
  infinite bases converging to 1, which do not exist until Layer 10; the arbitrary-rank
  presentation theorem is stated there and nowhere before.
- **Non-vacuity, with the map named.** `D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩` (defined in
  `Suggested.lean`) is nontrivial, pro-`2`, and topologically finitely generated. The
  nontriviality proof is not "map it onto some finite `2`-group": the map is
  `φ : freeProP 2 (Fin 3) → ℤ/2` with `φ(A) = 0`, `φ(S) = 1`, `φ(Y) = 0`, given by the
  universal property of Layer 4. The relator maps to `0·2 + 1·4 + 0 = 0` in `ℤ/2` (the
  commutator dies because `ℤ/2` is abelian), so `φ` factors through `D₀`, and the resulting
  `D₀ ↠ ℤ/2` is surjective because `φ` hits the generator. Hence `Nontrivial D₀`. The
  surjection itself is a `Suggested.lean` target, with `Nontrivial demushkinD0` a corollary.

#### Continuous extensions and finite `p`-embedding problems

The dictionary between `H²` and extensions is used from here on and is nobody else's:
PR #1 supplies `H²` and the exact sequences, not a classification of extensions. Everything
in this subsection is a target of this roadmap.

- **The extension object.** For profinite `G` and a finite discrete abelian `p`-primary
  `G`-module `M`, an extension is a short exact sequence `1 → M → E → G → 1` of topological
  groups in which `E` is profinite, `M → E` is an injection onto a **closed** normal
  subgroup (a finite subgroup of a profinite group is automatically closed, and carries the
  subspace topology, so this is a topological embedding), `E → G` is a continuous surjection
  with that subgroup as kernel, and conjugation of `E` on `M` induces the given `G`-action.
  ⚠ Do not ask for `M` to be **open** in `E`: `M` open would make `G ≅ E/M` finite, and the
  groups this dictionary is used on (`G_K`, free pro-`p` groups) are infinite.
  Morphisms are continuous homomorphisms restricting to the identity on `M` and covering the
  identity on `G`; every such morphism is an isomorphism.
- **Continuous sections along a finite kernel.** The lemma the cocycle construction needs,
  stated and proved here in the only case used: if `E` is profinite and `N ≤ E` is a
  **finite** normal subgroup, then `E ↠ E/N` admits a continuous set-theoretic section
  sending `1` to `1`. Proof: `E` has an open normal subgroup `U` with `U ∩ N = 1`
  (intersect the open normal subgroups separating the finitely many nontrivial elements of
  `N` from `1`), so `U` maps isomorphically onto its image, which is open of finite index in
  `E/N`; a section over that image transported by finitely many coset representatives is a
  section over a finite clopen partition of `E/N`, hence continuous.
  ⚠ Not every surjection of profinite **spaces** has a continuous section, so no statement
  here appeals to one. (For profinite *groups* and an arbitrary closed kernel the section
  does exist, RZ Prop. 2.2.2, but the finite-kernel case above is elementary and is all this
  subsection uses.)
- **Cocycles to extensions and back.** From a continuous normalized `2`-cocycle
  `c : G × G → M` build the extension on `M × G` with the twisted multiplication, and check
  that the product topology makes it profinite. From a continuous normalized section of
  `E → G`, which the previous item supplies since `M` is finite, build a continuous
  normalized cocycle. The two constructions are mutually inverse up to the equivalence
  relation.
- **The bijection.** Equivalence classes of extensions correspond bijectively to
  `H²(G, M)`, with the trivial class corresponding to the semidirect product; naturality in
  `M`. State it as a bijection of sets, not an isomorphism of groups (the Baer sum is not
  needed downstream and is not a target).
- **Splitting.** An extension admits a continuous group-theoretic section iff its class in
  `H²(G, M)` is zero.
- **Embedding problems with `p`-group kernel.** A finite embedding problem for `G` is a
  continuous surjection `π : G ↠ Q` onto a finite group together with a surjection
  `α : E ↠ Q` of finite groups; a solution is a continuous `β : G → E` with `α ∘ β = π`.
  Reduce the case `N := ker α` a finite `p`-group to the central elementary-abelian case
  along the **lower `p`-central series of `N`**, `λ_0(N) = N` and
  `λ_{k+1}(N) = λ_k(N)^p [λ_k(N), N]` (Layer 8 studies the same series on a profinite group;
  on a finite group it needs nothing from there). Each `λ_k(N)` is characteristic in `N`,
  hence normal in `E`; the factors `λ_k(N)/λ_{k+1}(N)` are elementary abelian and are
  centralized by `N`, hence are `Q`-modules; and the series reaches `1` in finitely many
  steps because `N` is a finite `p`-group. A solution is built in that many steps, each an
  extension of the kind above. Characteristicity is what makes this work, which is why the
  series is named rather than left as "some central series": an arbitrary central series of
  `N` need not be stable under conjugation by `E`.
- **`H²`-vanishing solves them.** If `H²(G, M) = 0` for every finite discrete elementary
  abelian `p`-primary `G`-module `M`, then every finite embedding problem for `G` with
  `p`-group kernel has a solution, by induction along that central series. If `π` is
  additionally required to be solved by a *surjective* `β`, use the Frattini/Burnside
  criterion of Layer 3 to upgrade a solution to a surjective one.
- **From finite solutions to projectivity.** Compatible solutions over the finite quotients
  assemble to a continuous lift against an arbitrary surjection of pro-`p` groups: apply the
  Layer 0 compactness lemma to the (nonempty, closed) sets of level-`k` solutions. This is
  the projectivity statement in the pro-`p` category that Layer 6 uses.

- **`H²` of a free pro-`p` group vanishes.** For `F` free pro-`p` of finite rank and every
  finite discrete `p`-primary `F`-module `M`, `H²(F, M) = 0`. Proof from the material just
  above: by the extension/cocycle dictionary a class in `H²(F, M)` is an extension
  `1 → M → E → F → 1`, and the universal property of `F` lifts a generating tuple of `F`
  through `E ↠ F`, producing a continuous section, so the class is zero. This theorem is
  proved *here*, in Layer 5, because the relation-rank theorem below needs it; Layer 6
  repackages it as `cd_p F ≤ 1` and proves the converse.

What this subsection takes from
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1): its
explicit cochain model for `H²` with finite discrete coefficients (its Layer 1), and the long
exact and five-term sequences (its Layer 4). The `cd` reformulation in Layer 6 additionally
uses its cohomological-dimension vocabulary (its Layer 8). Nothing else.

#### Rank interpretations

- **`H¹` interpretation.** `H¹(G, 𝔽_p) ≅ Hom_cont(G, 𝔽_p) ≅ (G/Φ(G))^∨`, so
  `dim_{𝔽_p} H¹(G, 𝔽_p) = topologicalGeneratorRankNat G h` for topologically finitely
  generated pro-`p` `G` (the Burnside basis theorem in cohomological clothes; Labute
  §1.3, Serre CG I §4.2). The cardinal form, without finiteness, *is* the Layer 3 identity:
  that identity is already stated against the discrete dual `Hom_cont(G, 𝔽_p)`, and this
  layer only has to identify that dual with `H¹(G, 𝔽_p)`.
- **`H²` interpretation.** For a minimal presentation `1 → R → F → G → 1` of a
  topologically finitely generated pro-`p` group: transgression `H¹(R, 𝔽_p)^F → H²(G, 𝔽_p)` is an
  isomorphism (five-term sequence plus the `H²(F, 𝔽_p) = 0` theorem above);
  `H¹(R, 𝔽_p)^F` is dual to `R/Rᵖ[R,F]`, whose dimension is the minimal number of
  generators of `R` as a closed normal subgroup (Labute §1.4). Hence
  `r(G) = dim H²(G, 𝔽_p)` counts relations, **independently of the chosen minimal
  presentation**. This is the presentation-independence theorem.
- **Deficiency and one-relator groups.** For pro-`p` `G` that is topologically finitely
  generated with `H²(G, 𝔽_p)` finite-dimensional, both `d(G)` and `r(G)` are natural
  numbers and `def(G) := d(G) - r(G)` is stated as `d(G) = def(G) + r(G)` with
  `def(G) : ℤ`, so that no truncated natural subtraction appears (NSW (3.9.4): a finite
  relation system exists iff `H²` is finite, and then `#S - #R ≥ d - r`, again as an
  inequality in `ℤ`, with equality for minimal presentations). `r(G) = 1` ⟺ one-relator
  minimal presentations; a Demushkin group is a one-relator pro-`p` group with relator in
  `Fᵖ[F,F]` (the input to Layer 7).
- **The Golod–Shafarevich inequality.** For a nontrivial finite `p`-group,
  `4 r(G) > d(G)²` (NSW (3.9.7), RZ Thm. 7.8.5), stated in that cleared-denominator form
  over `ℕ`. It is the classical capstone of deficiency theory and the reason finite
  `p`-groups need many relations; nothing downstream here uses it, so it can land late
  within the layer.
- **Sanity example.** `d((ℤ/p)ⁿ) = n`, `r((ℤ/p)ⁿ) = n(n+1)/2`: the
  elementary-abelian count that catches a wrong normalization of `H²`.

### Layer 6: cohomological dimension of pro-`p` groups

The general `cd_p` formalism (definition via vanishing of `H^n` on `p`-torsion discrete
modules, dimension shifting, `cd` of closed subgroups, spectral-sequence generalities)
belongs to [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1); this layer owns the
pro-`p`-specific theorems, stated against that formalism.

- **Free ⟹ `cd ≤ 1`.** Layer 5's theorem `H²(F, M) = 0` for `F` free pro-`p` of finite rank
  and `M` finite discrete `p`-torsion, restated in PR #1's vocabulary as `cd_p F ≤ 1` (via
  their dévissage: for a pro-`p` group, vanishing on finite discrete `p`-primary modules in
  the one degree suffices).
- **Serre's theorem: `cd_p G ≤ 1` ⟹ free pro-`p`**, for topologically finitely generated
  `G`. Pinned route: `cd ≤ 1` gives the projectivity property of Layer 5's embedding-problem
  subsection; a minimal generating tuple gives a continuous surjection `φ : F ↠ G` from the
  free pro-`p` group on `Fin (topologicalGeneratorRankNat G h)`; projectivity produces a
  continuous section `s : G → F` of `φ`; `s(G)` is a closed subgroup mapping onto `F/Φ(F)`
  by minimality, so `s(G) = F` by Burnside, and `φ` is an isomorphism. (NSW III §5, Serre CG
  I §4.2; RZ Ch. 7.) The version without finite generation is a *different theorem* with a
  different proof, stated and proved in Layer 10 once free objects on bases converging to 1
  exist; this layer does not state it.
- **`cd` of open subgroups.** For `U` open in pro-`p` `G` with `cd_p G < ∞`:
  `cd_p U = cd_p G` (Serre; the ProfiniteCohomology restriction/corestriction machinery
  does the work, this layer states and instantiates it for pro-`p`).
- **The two-term Euler formula.** Before the rank count, the exact theorem it uses. Let `G`
  be a topologically finitely generated pro-`p` group with `cd_p G ≤ 1` and let `U ≤ G` be
  open. Then all four spaces `H^i(G, 𝔽_p)`, `H^i(U, 𝔽_p)` (`i = 0, 1`) are
  finite-dimensional, and, in `ℤ`,

  > `finrank H⁰(U, 𝔽_p) - finrank H¹(U, 𝔽_p)
  >   = [G : U] · (finrank H⁰(G, 𝔽_p) - finrank H¹(G, 𝔽_p))`.

  Subtraction is in `ℤ` throughout: the statement is about the integers
  `(finrank H⁰ : ℤ) - (finrank H¹ : ℤ)`, never about `Nat` subtraction, and no symbol `χ` is
  introduced. Finite-dimensionality is part of the theorem, derived from topological finite
  generation of `U` (Layer 3) plus the `H¹`-interpretation of Layer 5, not assumed. The
  proof uses these PR #1 milestones and no others: Shapiro's lemma for the open subgroup `U`
  and the coinduced module `Coind_U^G 𝔽_p` (its Layer 6), the identification of
  `Coind_U^G 𝔽_p` with the `𝔽_p`-vector space on the finite coset space `G/U` as a
  `G`-module, and the long exact sequence in a short exact sequence of finite discrete
  coefficient modules (its Layer 4), together with additivity of `finrank` along a finite
  exact sequence of finite-dimensional `𝔽_p`-vector spaces (Mathlib).
- **The trivial-filtration theorem, and why the Euler formula needs it.** Shapiro and
  additivity turn the left-hand side into the alternating sum for `G` with coefficients in
  `𝔽_p[G/U]`, a module of dimension `[G : U]`; getting from there to `[G : U]` times the
  alternating sum with coefficients in `𝔽_p` is a separate statement, and it is this one.
  For pro-`p` `G`, a nonzero finite discrete `p`-primary `G`-module has nonzero invariants
  (the action factors through a finite `p`-quotient, and a finite `p`-group acting on a
  nonzero finite `p`-group fixes a nonzero element; Mathlib's
  `IsPGroup.card_modEq_card_fixedPoints`). Iterating, every such `M` has a `G`-stable
  filtration whose factors are one-dimensional with trivial action, so any `ℤ`-valued
  function of the coefficients that is additive along short exact sequences takes the value
  `dim_{𝔽_p} M` times its value at `𝔽_p`. This is a pro-`p` statement, hence ours and not PR #1's, and both Euler formulas
  use it: the two-term one above, and the degree-`0,1,2` version stated in Layer 7, where
  the Demushkin rank formula needs it.
- **Pro-`p` Nielsen–Schreier, open case.** An open subgroup `U` of index `m` in a free
  pro-`p` group `F` of finite rank `n ≥ 1` is free pro-`p` of rank `1 + m(n - 1)`
  (`Suggested.lean`). **The route is cohomological.** Freeness via `cd_p U ≤ cd_p F ≤ 1`
  and Serre's theorem; the rank count by substituting `finrank H⁰ = 1`,
  `finrank H¹(F, 𝔽_p) = n` and `finrank H¹(U, 𝔽_p) = d(U)` into the two-term Euler formula
  above, which gives `1 - d(U) = m(1 - n)` in `ℤ` and hence `d(U) = 1 + m(n-1)` in `ℕ` (the
  rearrangement is a separate small lemma, since it is where the natural-number statement is
  recovered). Koch derives his Example 6.3 rank formula the same way from his §5.4. The
  literature's alternative is RZ Thm. 3.6.2, a direct Schreier-transversal argument through
  the pro-`C` completion of the abstract Nielsen–Schreier theorem, for extension-closed
  varieties. We pin the cohomological route because Layers 5–7 build its ingredients anyway,
  and because the closed-subgroup case (Layer 10, RZ Cor. 7.7.5) is cohomological in any
  treatment; RZ 3.6.2 is the cross-check citation, not the plan.
- ⚠ **Closed subgroups are Layer 10.** Closed (non-open) subgroups of free pro-`p` groups
  are free pro-`p` of possibly infinite rank; the statement needs converging-to-1 bases.
  Do not state a truncated finite-rank version here.

### Layer 7: Demushkin groups, their invariants, and the orientation

- **The predicate.** `IsDemushkin p G` with the fields of the pseudocode given in
  the conventions: `IsProP p G`, finite-dimensionality of `H¹` over `ZMod p`,
  `finrank H² = 1`, and nondegeneracy of the cup pairing on each side. Derived immediately:
  `G` is topologically finitely generated (`h1_fin` plus the Burnside basis theorem), so its
  rank is available as the natural number `n(G) := topologicalGeneratorRankNat G h` for the
  witness `h` just derived, which the pseudocode packages as `demushkinRank`; that
  `n(G) = finrank H¹(G, 𝔽_p)`; and that `G` is a one-relator pro-`p` group with relator in
  `Fᵖ[F,F]` (Layer 5). Also proved here: `IsDemushkin` is invariant under topological
  isomorphism. Every numerical statement below is about `demushkinRank`, never about an
  unqualified rank.
- **First examples and non-examples** (Labute p. 106, Serre CG I §4.5): `ℤ/2` is Demushkin
  at `p = 2` (the unique finite one; the cup square of the generator of `H¹(ℤ/2, 𝔽₂)` is
  the extension class of `ℤ/4`); free pro-`p` groups (in particular `1` and `ℤ_p`) are
  **not** Demushkin (`H² = 0`); `ℤ_p × ℤ_p` is Demushkin with `q = 0` (surface relation
  `(x₁, x₂)`); for `p` odd no rank-1 Demushkin groups exist.
- **The abelianization structure theorem.** For Demushkin `G`:
  `G^{ab} ≅ ℤ_p^{n-1} × ℤ_p/qℤ_p` (topological abelianization; Labute p. 106), proved from
  the finitely generated abelian pro-`p` structure theorem of Layer 4 applied to
  `topAbelianization G` together with the one-relator presentation. Its torsion subgroup is
  finite and cyclic (same Layer 4 theorem), which is what makes `demushkinQ G` well defined
  from `hG : IsDemushkin p G` alone: `0` when the torsion is trivial, otherwise its order.
  Worked instance: `D₀^{ab} ≅ ℤ₂² × ℤ/2`, finiteness of its torsion subgroup, and
  `q(D₀) = 2` (`Suggested.lean`), a presentation-level computation that is deliberately
  independent of the classification.
- **The canonical character.** Labute Prop. 6: for `dim H¹ < ∞`, the three prescription
  conditions listed in the conventions are equivalent, and free pro-`p` groups satisfy them
  for every `χ`. **Theorem (Serre/Labute Thm 4): a Demushkin group has a *unique* continuous
  `χ : G → ℤ_pˣ` with the prescription property.** Define `demushkinCharacter G := χ`;
  prove `Im χ` is closed and is an isomorphism invariant (functoriality under continuous
  isomorphisms, the orientation-transport lemma the acceptance instance needs). Prove
  `Im χ = 1 + q(G)ℤ_p` only in the nonexceptional `q(G) ≠ 2` regime. For `q(G) = 2`, retain
  `Im χ` as a separate classification invariant and do not recover `q` from containment.
- **The closed subgroups of `ℤ₂ˣ`.** Self-contained `ℤ_pˣ`-theory, no cohomology. Named
  definitions first: for `f : ℕ∞` with `f ≥ 2`, put `U^(f) := 1 + 2^f ℤ₂` (`U^(∞) = {1}`);
  `V^(f) := {±1} × U^(f)`, the subgroup generated by `-1` together with `U^(f)`; and, for
  `2 ≤ f < ∞`, `U^[f] := closure ⟨-1 + 2^f⟩`, generated by that single unit. Then:
  - **Exhaustiveness and uniqueness.** Every nontrivial closed subgroup of `ℤ₂ˣ` is exactly
    one of `U^(f)` (`2 ≤ f < ∞`), `V^(f)` (`2 ≤ f ≤ ∞`, with `V^(∞) = {±1}`), and
    `U^[f]` (`2 ≤ f < ∞`), and no two entries of that list coincide. `U^(∞) = {1}` is the
    trivial subgroup and so does not appear in this list, though it is a legitimate value of
    the `f = ∞` convention elsewhere (it is the image of `χ` for a free pro-`2` group).
    Route: `ℤ₂ˣ = {±1} × (1 + 4ℤ₂)` with `1 + 4ℤ₂ ≅ ℤ₂` through the logarithm, so the closed
    subgroups of the second factor are the `1 + 2^fℤ₂`; the three families are the three ways
    a closed subgroup can sit over `{±1}`. In `Suggested.lean` the families are indexed by
    `f : ℕ` and the `f = ∞` members are written out separately (as `⊥` and
    `Subgroup.closure {-1}`), since an `ℕ∞`-indexed definition would carry a junk value at
    `∞`; the `f : ℕ∞` indexing here is prose for the same three families.
  - **Procyclicity.** `U^(f)` and `U^[f]` are procyclic; `V^(f)` with `f < ∞` is not (its
    Frattini quotient is `(ℤ/2)²`). Equivalently: a closed subgroup is procyclic iff it does
    not contain `-1` together with a nontrivial element of `1 + 4ℤ₂`, which is the form
    stated in `Suggested.lean`.
  - **Indices and intersections.** `profiniteIndex U^(f) ℤ₂ˣ = 2^{f-1}`,
    `profiniteIndex V^(f) ℤ₂ˣ = 2^{f-2}`, `profiniteIndex U^[f] ℤ₂ˣ = 2^{f-1}`, and
    `U^[f] ∩ (1 + 4ℤ₂) = U^(f+1)`: the generator `g = -1 + 2^f` has `g² = 1 - 2^{f+1}u`
    with `u = 1 - 2^{f-1}` odd, so the even powers of `g` are exactly `U^(f+1)`, and that
    intersection is what makes the index `2^{f-1}` come out. In Layer 8's notation,
    `(A : A²) = 2` for `U^(f)` and for `U^[f]`, and `= 4` for `V^(f)` with `f < ∞`. These
    are the numbers Layer 9's existence statement quotes; check them against `f = 2, 3, 4`
    by squaring, since a shift of one in this exponent silently reparametrizes the whole
    `q = 2` classification.
  - **Odd `p`.** For `p` odd, `ℤ_pˣ ≅ μ_{p-1} × (1 + pℤ_p)`, and the closed subgroups of
    `1 + pℤ_p` are exactly the `1 + p^fℤ_p`, through the `p`-adic logarithm **with its
    domain restricted to `1 + pℤ_p`** (to `1 + 4ℤ₂` when `p = 2`), where it is an
    isomorphism of topological groups onto `pℤ_p` (resp. `4ℤ₂`). The domain restriction is
    part of the statement: the logarithm does not converge on all of `ℤ_pˣ`.
  - **Which subgroups occur as images.** For each normal form of Layer 9, the closed subgroup
    of `ℤ_pˣ` generated by the character values on the normal-form basis, computed
    explicitly. This is the table Layer 9's character theorem produces and Layer 11's
    instances read off.

#### Demushkin duality, concretely

⚠ **Scope decision.** A general theory of profinite duality groups (duality group at `p`,
dualizing module, `PD^n`; NSW (3.4.4)–(3.4.6), (3.7.1)) is not built here, and does not
exist in [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1),
whose layers stop at cohomological dimension. The terms `duality group`, `dualizing module`,
and `PD^n` therefore do not occur anywhere in this roadmap's milestones. What Layer 9 and Layer 11
actually use is a small package of statements about finite discrete modules, and that
package is stated and proved here:

- **Dimension two.** An infinite Demushkin group `G` has `cd_p G = 2` (Tate). Route: `≤ 2`
  from the one-relator presentation of Layer 5 and the five-term sequence; `≥ 2` from
  `H²(G, 𝔽_p) ≠ 0`, which is the definition.
- **The trace isomorphism.** Fix once and for all the isomorphism
  `tr : H²(G, 𝔽_p) ≅ 𝔽_p` determined by a choice of nonzero element (the choice is unique
  up to `𝔽_pˣ`; pin it by naming a generator and record that downstream statements are
  invariant under rescaling). Every pairing below is normalized through `tr`.
- **The perfect pairings that are used.** For each `i ≥ 1` and each finite discrete
  `p`-primary `G`-module `M` occurring in the coefficient systems `I(χ)/p^i` of the
  canonical character, the cup pairing
  `H^j(G, M) × H^{2-j}(G, M^∨(χ)) → H²(G, I(χ)/p^i) ≅ ℤ/p^i` is a perfect pairing of
  finite abelian groups for `j = 0, 1, 2`, where `M^∨(χ) := Hom(M, I(χ)/p^i)` carries the
  diagonal action. Only the modules in that system are claimed, because only they are used; there is
  no unqualified "all finite discrete modules" statement in this roadmap.
- **Naturality.** Compatibility of the pairings with restriction to an open subgroup `U`
  (the pairing for `U` is the restriction of the pairing for `G` composed with
  corestriction) and with corestriction, in the form `⟨res a, b⟩_U = ⟨a, cor b⟩_G`. These
  are the two compatibilities that the open-subgroup theorem uses.
- **The role of the character.** For `i ≤ i'` the transition maps of the system
  `(I(χ)/p^i)_i` are `G`-equivariant, and the induced action on the compatible system of
  duals `Hom(𝔽_p, I(χ)/p^i)` is by `χ mod p^i`. This is the precise sense in which `χ`
  "controls the duality", stated entirely in terms of the finite discrete modules PR #1
  supplies; the inverse limit `ℚ_p/ℤ_p` is not a coefficient module of any statement here.
- **The open-subgroup theorem, proved from this package.** For `G` infinite Demushkin and
  `U ≤ G` open: `U` is Demushkin, `n(U) - 2 = [G : U](n(G) - 2)` in `ℤ`, and
  `demushkinCharacter U = (demushkinCharacter G) ∘ (inclusion U)`. Route: `cd_p U = 2` from
  Layer 6; `finrank H²(U, 𝔽_p) = 1` from the perfect pairing and naturality above;
  nondegeneracy of the cup pairing on `U` likewise; then the degree-`0` through degree-`2`
  Euler formula (below). The `ℤ/2` case is why "infinite" is a hypothesis.
- **The three-term Euler formula.** The degree-`0,1,2` analogue of the Layer 6 theorem: for
  `G` topologically finitely generated pro-`p` with `cd_p G ≤ 2` and `U ≤ G` open, all six
  spaces are finite-dimensional and, in `ℤ`,
  `Σ_{i=0}^{2} (-1)^i finrank H^i(U, 𝔽_p)
   = [G : U] · Σ_{i=0}^{2} (-1)^i finrank H^i(G, 𝔽_p)`.
  Same proof shape as the two-term case, one degree longer: the same PR #1 inputs (Shapiro
  and the long exact sequence) together with Layer 6's trivial-filtration theorem, which is
  what converts the `𝔽_p[G/U]` coefficients into the factor `[G : U]`. Substituting
  `finrank H⁰ = finrank H² = 1` for a Demushkin group turns it into the rank formula above.
- **Recognition criteria (Andozhskii; Dummit–Labute).** For topologically finitely generated
  one-relator pro-`p` `G` with `n(G) > 1`, the following are equivalent (NSW (3.9.15)):
  1. `G` is Demushkin;
  2. `cd_p G = 2` and `finrank H²(N, 𝔽_p) = 1` for every open normal `N ≤ G`;
  3. `cd_p G = 2` and `n(N) - 2 = [G : N](n(G) - 2)` in `ℤ` for every open normal `N ≤ G`.
  The sharpenings in which `N` ranges only over the open normal subgroups of index `p` are
  separate statements with the same proof. These are the criteria Layer 11 applies to
  `G_K(p)`. NSW also lists an equivalent phrased through a dualizing module; that
  formulation needs vocabulary this roadmap does not define, so it is not among the
  equivalences stated or proved here.

### Layer 8: the central-tower comparison method and finite-quotient determinacy

The abstraction of the classification method that has already succeeded in Lean at one
instance (provenance section): compare two pro-`p` groups through the finite quotients of
the lower `p`-series, then assemble. Everything here is cohomology-free.

#### Notation and objects, fixed for Layers 8 and 9

Every symbol used in the two hardest layers is declared here and used with this meaning
throughout. Where Labute's indexing differs from ours the translation is stated, once.

- `λ_k := pLowerCentralSeries p G k`, 0-based: `λ_0 = G` and
  `λ_{k+1} = closure (λ_kᵖ ⬝ [λ_k, G])`. Labute's `F_i` (1-based, `F_1 = F`) is `λ_{i-1}`;
  his `F_3`, the modulus of the normal-form congruences, is our `λ_2`. Every occurrence of
  a Labute index below is translated in place and never left in his numbering.
- `gr_k(G) := λ_k / λ_{k+1}`, a finite elementary abelian `p`-group, hence an
  `𝔽_p`-vector space, written additively. `gr(G) := ⨁_{k ≥ 0} gr_k(G)`, a graded
  `𝔽_p`-vector space.
- The **bracket** `[·,·] : gr_j × gr_k → gr_{j+k+1}` induced by the group commutator
  (degrees shift by one because our indexing is 0-based: `[λ_j, λ_k] ≤ λ_{j+k+1}`), and the
  **`p`-power operator** `π : gr_k → gr_{k+1}`, `π(x λ_{k+1}) = x^p λ_{k+2}`. Both are well
  defined; the bracket is `𝔽_p`-bilinear, alternating, and satisfies the Jacobi identity,
  and `π` commutes with scalars and is additive in every degree except degree zero at
  `p = 2`, which is the next item. These are Labute Prop. 1–2 in our indexing.
- **`π` against the bracket, and the dyadic failure.** For every `p`, the bracket is
  `π`-bilinear away from degree zero: `π[x, y] = [πx, y] = [x, πy]` for `x ∈ λ_j`,
  `y ∈ λ_k` with `j, k ≥ 1` (all three terms in `gr_{j+k+2}`). The group identities behind
  it are `[x², y] = [x, y]²·[[x, y], x]` and `[x, y²] = [x, y]²·[[x, y], y]`, whose
  correction terms have degrees `2j + k + 2` and `j + 2k + 2` and so vanish in `gr_{j+k+2}`
  unless the corresponding argument has degree zero. For `p` odd, `π` is additive as well
  (the Hall–Petrescu corrections carry coefficients `binom(p, i)` divisible by `p`) and the
  degree-zero corrections likewise vanish, so `gr(G)` is a graded Lie algebra over `𝔽_p[π]`
  with `π` of degree one. **For `p = 2` additivity fails in degree zero**, and the exact
  failure is the theorem to state: for `x, y ∈ gr_0(G)`,
  `π(x + y) = π(x) + π(y) + [x, y]` in `gr_1(G)` (the `binom(2, 2)` term of the
  Hall–Petrescu expansion), together with the degree-zero bracket corrections
  `[πx, y] = π[x, y] + [[x, y], x]` for `x ∈ gr_0` and its mirror image. So `gr(F)` for `F`
  free pro-`2` is *not* an `𝔽_2[π]`-Lie algebra, and the milestone is a proof of these
  identities with an explicit witness that the failure is not vacuous: in `F` free pro-`2`
  of rank 2, `[x̄₁, x̄₂] ≠ 0` in `gr_1(F)`, so `π` is not additive on `gr_0(F)`. Every
  `q = 2` argument downstream is shaped by this.
- **Openness and cofinality** (`Suggested.lean`): in a topologically finitely generated
  pro-`p` group every `λ_k` is open (induction: open ⟹ topologically f.g. ⟹ finite
  Frattini-type quotient) and the series is a neighborhood basis of `1`, so
  `G ≅ lim_k G/λ_k` with finite `p`-group levels, and any comparison can run level by level.
  Each `λ_k` is closed, normal, characteristic, and `λ_{k+1} ≤ λ_k`; continuous homomorphisms
  satisfy `f(λ_k(G)) ≤ λ_k(H)`, with equality when `f` is a continuous surjection.
  (RZ Prop. 2.8.13 is the same statement for the iterated-Frattini series; prove it for
  both series, they interleave.)
- **`δ_j`, the basis-modification maps.** Let `F = freeProP p (Fin n)` with basis
  `x_1, …, x_n` and let `r ∈ λ_1(F)` be a relator; `R` denotes the closed normal subgroup
  generated by `r`, and `R_j := R ∩ λ_j(F)`. Modifying the basis by `x_i ↦ x_i w_i` with
  `w_i ∈ λ_{j-1}(F)` (`j ≥ 1`) moves `r` inside its coset by an element of `λ_j(F)` whose
  class in `gr_j(F)` depends only on the classes `w̄_i ∈ gr_{j-1}(F)`. That is the map
  `δ_j : gr_{j-1}(F)^{⊕ n} → gr_j(F)`,
  `δ_j(w̄_1, …, w̄_n) = Σ_i [w̄_i, ∂_i r̄] + Σ_i c_i π(w̄_i)`,
  where `r̄ ∈ gr_1(F)` is the class of the relator, `∂_i r̄ ∈ gr_0(F)` is the coefficient
  of `x_i` in its commutator part, and `c_i ∈ 𝔽_p` is the coefficient of `x_i^p` in its
  `p`-power part. Both terms land in `gr_j(F)`: the bracket raises degree by
  `0 + (j - 1) + 1` and `π` by one. Well-definedness and `𝔽_p`-linearity of `δ_j` are the
  milestone (Labute Prop. 5 in our indexing), with the explicit formula at a relator in
  normal form as its corollary; `Im δ_j ≤ gr_j(F)` is the subspace named in the span
  statements of Layer 9.
- **The tails `T_j`.** For `p = 2` the span statements involve one further subspace:
  `T_j ≤ gr_j(F)` is spanned by the iterated `p`-powers `π^j(x̄_i) ∈ gr_j(F)` over the
  slots `i` with `c_i = 0`, that is over the generators whose exponent in the `p`-power part
  of the relator is not exactly `p` and which therefore contribute no `π`-term to `δ_j`
  (for `r = x₁²x₂^{2^f}(x₂, x₃)⋯` with `f ≥ 2` those are `x₂, …, x_n`, since `π^f(w̄)` lands
  in `gr_{j+f-1}`, above the degree in play). "Tail" means that subspace, and `T_j`
  is written for it from here on rather than described.
- **`(A : A²)` and the parameters of the normal forms.** `A ≤ ℤ_pˣ` always denotes a closed
  subgroup; `A²` is the closed subgroup of squares; `(A : A²)` is `profiniteIndex A² A`,
  which is finite (value 1, 2, or 4) for the closed subgroups of `ℤ₂ˣ`, proved from the
  trichotomy in Layer 7 rather than asserted. In the normal forms: `n ≥ 1` is the rank;
  `f` ranges over `2 ≤ f < ∞` together with the symbol `f = ∞`, encoded as `f : ℕ∞` with
  `U^(∞) := {1}` and `2^∞ := 0` in the exponent, so that `x^{2^f}` means `x^0 = 1` at
  `f = ∞`; `α ∈ 4ℤ₂` is a `2`-adic integer with `v₂(α) ≥ 2` (`α = 0` allowed, and
  `v₂(0) = ∞`); `N` denotes `n/2`, the number of commutator pairs in an even-rank form. Each
  classification statement below repeats the ranges it needs.

#### Finite-quotient determinacy

- **Occurring as a quotient.** `IsFiniteContinuousQuotient G Q` for a finite group `Q`:
  there is a surjection `f : G →* Q` with open kernel (`Suggested.lean`). Phrasing it through
  the kernel rather than through a topology on `Q` is what lets statements quantify over `Q`
  bundled as a `FiniteGrp` instead of over arbitrary types carrying an unspecified topology;
  for a finite discrete `Q` the two conditions agree, and that agreement is a lemma here.
  Also proved here: the predicate depends only on the isomorphism class of `Q`, and only on
  the topological isomorphism class of `G`.
- **Two epimorphisms.** If `G` is topologically finitely generated and `G`, `H` have the same
  continuous finite quotients, then there exist continuous surjections `G ↠ H` and `H ↠ G`.
  Route: for each open normal `N ≤ G` the set of continuous surjections `H ↠ G/N` is
  nonempty (hypothesis) and finite (`G/N` finite and `H` topologically finitely generated,
  or, in the sharp form, by counting through `G`); restriction makes these a surjective inverse
  system; the Layer 0 compactness lemma gives the limit. Note where each finite-generation
  hypothesis is used, since the next item removes one of them.
- **The isomorphism theorem, sharp form** (Fried–Jarden; RZ Thm. 3.2.9): if `G` is
  topologically finitely generated and `G`, `H` have the same continuous finite quotients,
  then `G ≅ H` as topological groups, with **no finite-generation hypothesis on `H`**. Route:
  the two-epimorphism lemma above gives `φ : G ↠ H` and `ψ : H ↠ G`; then `ψ ∘ φ : G ↠ G`
  is onto, so it is an isomorphism by the Hopf property of Layer 3 (which needs finite
  generation of `G` only); hence `φ` is injective, and being a continuous bijection of
  compact Hausdorff groups it is a topological isomorphism. Finite generation of `H` is
  therefore never needed, and `H` is topologically finitely generated as a *conclusion*. If
  the intermediate two-epimorphism step is easier to prove with both hypotheses, state that
  weaker lemma first and then the argument that removes the second hypothesis; do not leave
  the sharp statement unproved.
- **Corollary** (Dixon–Formanek–Poland–Ribes 1982; RZ Cor. 3.2.8): finitely generated
  abstract groups with the same finite quotients have topologically isomorphic profinite
  completions.

#### The levelwise comparison schema

The reusable form of the tower method, stated as a theorem about a finite inverse system
rather than as a description of a technique. The data:

- topologically finitely generated pro-`p` groups `G` and `H`;
- for each `k : ℕ`, a **finite** type `S k` of level-`k` comparison data;
- **realization** maps `ρ_k : S k → (G/λ_k → H/λ_k)` landing in continuous surjective
  homomorphisms;
- **bonding** maps `β_k : S (k+1) → S k`, with each `β_k` surjective and each `S k`
  nonempty;
- **compatibility**: for every `s : S (k+1)` the square built from `ρ_{k+1} s`, `ρ_k (β_k s)`
  and the two projections `G/λ_{k+1} ↠ G/λ_k`, `H/λ_{k+1} ↠ H/λ_k` commutes.

**Theorem.** Under these hypotheses there is a continuous surjection `Φ : G ↠ H` and an
element `s∞` of `lim_k S k` such that `Φ` induces `ρ_k (s∞)_k` on each level. Proof: the
inverse limit of a system of nonempty finite sets with surjective bonding maps is nonempty
(Layer 0), and compatibility makes the induced level maps assemble; surjectivity passes to
the limit by compactness.

The side conditions of a particular application (prescribed values on marked generators, a
character shadow, a normal-form constraint) are carried in the type `S k` itself, so the
theorem needs no separate slot for them: an application chooses `S k` to be the set of
level-`k` comparisons *satisfying* the conditions, and the hypotheses to discharge are then
exactly nonemptiness and surjectivity of the bonding maps. A **predicate on the inverse
limit** (for instance: "the induced map respects the marked generators", or "the induced
character agrees with a prescribed one") may be imposed as an extra hypothesis, in which
case it must be given as a compatible family of predicates on the `S k` so that the limit
argument still applies.

Two applications are stated as immediate corollaries: the two-sided version (data in both
directions, plus the Hopf property, gives `G ≅ H`), and the specialization used in Layer 9
in which `S k` is the set of level-`k` basis changes carrying one Demushkin relator to
another and respecting the character shadow. This is the schema the one-instance `D₀`
classification used (`exists_contSurj_of_levelwise_nonempty` in the provenance source).

### Layer 9 prerequisites: two owned inputs

Both are needed by Labute's proof, neither exists upstream, and neither is supplied by a
sibling roadmap. They are built here, before the classification, and are useful on their own.

#### Bilinear forms over `𝔽_p`, including the characteristic-two nonalternating case

⚠ **Nondependency note.**
[Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4) is a
roadmap about quadratic forms over fields in which `2` is invertible; it states that
hypothesis in its standing conventions and excludes characteristic-two quadratic and
bilinear form theory. It therefore supplies nothing to this layer, and this subsection is
not a duplicate of anything there.

Index conventions: `V` is a finite-dimensional `𝔽_p`-vector space,
`b : V →ₗ[𝔽_p] V →ₗ[𝔽_p] 𝔽_p` is a bilinear form written `b x y`, and matrices are taken
with respect to an ordered basis  `e` by `B_{ij} = b (e i) (e j)`, so that a change of basis
`e' = e ⬝ P` acts by `B' = Pᵀ B P`.

- **Basics.** The left and right radicals of `b`; left and right nondegeneracy; for
  finite-dimensional `V` these coincide, with the radical statement proved rather than
  assumed. Transport of a form along a linear equivalence, and the resulting notion of
  equivalence of forms.
- **Alternating, skew-symmetric, symmetric.** `IsAlternating b := ∀ x, b x x = 0`.
  Expanding `b (x + y) (x + y) = 0` shows that alternating implies **skew-symmetric**
  (`b y x = - b x y`) in every characteristic; it does *not* imply symmetric, except when
  `p = 2`, where skew-symmetric and symmetric are the same condition. For `p = 2` the two
  conditions differ exactly by the diagonal, `x ↦ b x x` being `𝔽_2`-semilinear (additive,
  with `b (cx) (cx) = c² b x x`) when `b` is symmetric. For `p` odd a form that is both
  symmetric and alternating is zero, and the forms this roadmap meets at odd `p` are the
  alternating ones: the cup pairing on `H¹(G, 𝔽_p)` is graded-commutative, so `a ∪ a = 0`
  once `2` is invertible.
- **Symplectic normal form.** A nondegenerate alternating form on `V` admits a basis in
  which the matrix is block diagonal with blocks `[[0, 1], [-1, 0]]`; consequently
  `dim V` is even. Stated for all `p`, including `p = 2`.
- **Characteristic two, nonalternating.** For `p = 2` and `b` symmetric, nondegenerate, and
  **not** alternating, there is a basis in which the matrix is the identity; in particular
  such forms exist in every dimension, odd and even, and any two of the same dimension are
  equivalent. Together with the previous item this is the complete classification of
  nondegenerate symmetric bilinear forms over `𝔽_2`.
- **The change-of-basis theorem Layer 9 needs.** Let `b` be nondegenerate on `V` of
  dimension `n`, and either alternating (any `p`) or symmetric with `p = 2`. Then there is a
  basis in which `B` is: the symplectic block form, if `b` is alternating, and then `n` is
  even; the identity, if `p = 2` and `b` is symmetric but not alternating, and then `n` is
  arbitrary. Those are the only two cases the classification produces, and the statement
  records which one each Demushkin normal form falls into, so that the odd-dimensional
  `p = 2` case is covered explicitly rather than by analogy. Nondegenerate symmetric
  nonalternating forms in odd characteristic (diagonalizable, classified by their
  discriminant) are not part of this prerequisite: no cup form of a Demushkin group at odd
  `p` is one, and nothing below needs them.
- **From the cup matrix to the relator.** The translation used by Layer 9, stated as its own
  theorem: given a relator `r ∈ λ_1(F)` for `F = freeProP p (Fin n)`, the coefficients of
  `r̄ ∈ gr_1(F)` in the standard basis of `gr_1(F) ≅ Λ²(𝔽_p^n) ⊕ 𝔽_p^n` (commutator part
  and `p`-power part) are exactly the entries of the cup matrix `a_{ij}` off the diagonal and
  `(q choose 2) a_i` on it. A basis change `P` of `F` acts on those coefficients by
  `B ↦ PᵀBP`, so a normal form for `B` produces a relator congruent mod `λ_2(F)` to the
  corresponding normal-form word. This is the theorem that turns the linear algebra above
  into the statement about relators, and its two hypotheses are the two cases of that
  linear algebra: `B` is alternating exactly when the diagonal entries `(q choose 2) a_i`
  all vanish, which is automatic for `p` odd and holds at `p = 2` precisely when `q ≠ 2`;
  the symmetric nonalternating case is therefore exactly `p = 2` with `q = 2`.

#### The completed group algebra of a procyclic group

Labute's §1.5 and §4 arguments run over `Λ = ℤ_p[[Γ]]` for `Γ = Im χ` procyclic. The
minimum package is owned here. Mathlib PR #41961 (`p`-adic measures on profinite groups) and
Jz Pan's `lean-iwasawa` are **refactor targets**: if either lands with a compatible carrier,
these theorems are reproved against it or connected to it by an explicit ring isomorphism.
Nothing below is conditional on that happening.

- **The algebra.** For `Γ` a procyclic profinite group and `p` prime,
  `completedGroupAlgebra p Γ := lim_U ℤ_p[Γ/U]` over the open subgroups `U ≤ Γ`, with the
  inverse-limit topology; it is a complete topological `ℤ_p`-algebra. Functoriality in `Γ`
  along continuous homomorphisms, and the map `Γ → (completedGroupAlgebra p Γ)ˣ`.
- **Modules.** The completed modules occurring in the proof (inverse limits of
  `ℤ_p[Γ/U]`-modules with surjective transition maps) form a category with the expected
  exactness (an inverse limit of surjective systems of compact modules is exact), and `Λ`
  acts continuously on each.
- **Power-series coordinates.** For a chosen topological generator `γ` of `Γ ≅ ℤ_p`, the map
  `T ↦ γ - 1` extends to a topological ring isomorphism
  `ℤ_p[[T]] ≅ completedGroupAlgebra p Γ`. State the dependence on `γ`: a different generator
  changes the isomorphism by a substitution `T ↦ (1+T)^u - 1`, `u ∈ ℤ_pˣ`, and every
  statement below is invariant under it. For `Γ` finite procyclic the corresponding
  statement is the truncated one, and the classification only uses the infinite case.
- **Evaluation.** For `ψ ∈ ℤ_p[[T]]` and `c` in the maximal ideal of `ℤ_p` (equivalently
  `|c|_p < 1`), the evaluation `ψ(c) ∈ ℤ_p` converges, and `ψ ↦ ψ(c)` is a continuous
  `ℤ_p`-algebra homomorphism. The convergence hypothesis is `v_p(c) ≥ 1` and is carried in
  every statement.
- **Division.** For `ψ ∈ ℤ_p[[T]]` and `c` with `v_p(c) ≥ 1`, `(T - c) ∣ ψ` in `ℤ_p[[T]]`
  iff `ψ(c) = 0`. Both directions, with the quotient given by the explicit series. (This is
  the special case of the Weierstrass division theorem that Labute uses; the general
  Weierstrass preparation theorem is not needed and is not a target.)
- **The module statements used in Labute Thms 5–6.** For a finitely generated `Λ`-module `M`
  arising as above and `λ ∈ Λ`: the annihilator `Ann_Λ(M)` is a closed ideal; if
  `λ` acts injectively on `M` then `M/λM` computes the obstruction Labute names; and the
  divisibility criterion above transfers to the statement that a given element of `M` lies
  in `λM`. State these with the exact finiteness and topological hypotheses; they are the
  only module-theoretic facts the classification needs.

### Layer 9: the classification of Demushkin groups

The full Demushkin–Serre–Labute classification, sequenced *after* the Layer 8 method
because its proofs are successive-approximation arguments along the lower `p`-series, which
is Layer 8's tower plus per-level linear algebra, and after the two prerequisites above.
Source of record: Labute, *Classification of Demushkin groups* (Canad. J. Math. 19 (1967),
106–132); modern statements NSW III §9. Notation is the one fixed at the head of Layer 8.

- **Cup-form normal forms (Labute Prop. 3–4 + Corollary).** The relator's image in `gr_1(F)`
  computes the cup product: `r̄` paired with `χ_i ∪ χ_j` is `a_{ij}` off the diagonal and
  `(q choose 2) a_i` on it (Prop. 3, the statement that connects Layers 5 and 7 to the
  tower). Feeding the matrix `(a_{ij})` through the normal-form theorem of the bilinear-forms
  prerequisite gives `r ≡ x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{n-1},x_n)` mod `λ_2(F)` when the form is
  alternating (`n` even), and `r ≡ x₁²(x₂,x₃)(x₄,x₅)⋯` mod `λ_2(F)` in the nonalternating
  case, which by the prerequisite is exactly `p = 2` with `q = 2` (`n` odd allowed).
- **The successive-approximation argument (Labute Prop. 5, Thm 3).** The span statements, in
  the notation of Layer 8: for `q ≠ 2`, `gr_j(F) = Im δ_j` for every `j ≥ 2`; for `q = 2`,
  `gr_j(F) = Im δ_j + T_j`, the tails being what the dyadic failure of additivity of `π`
  leaves over. Each is an equality of `𝔽_p`-subspaces of a finite-dimensional space, with
  `δ_j` and `T_j` as declared there. The limit process is then the Layer 8 comparison schema with
  `S k` the (finite, nonempty) set of level-`k` basis corrections carrying the given relator
  into normal form: a Demushkin group with `q(G) = q` has a basis in which
  `r = x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{n-1},x_n)` if `q ≠ 2`;
  `r = x₁²x₂^{2^f}(x₂,x₃)(x₄,x₅)⋯` with `2 ≤ f ≤ ∞` if `q = 2` and `n` is odd; and
  `r = x₁^{2+α}(x₁,x₂)x₃^{2^f}(x₃,x₄)⋯` with `2 ≤ f ≤ ∞`, `α ∈ 4ℤ₂` if `q = 2`, `n` even. Implement
  it through that schema rather than re-deriving a limit argument.
- **Character values in normal form (Labute Thm 4 + Corollary).** Existence of `χ` by
  explicit values on the normal-form basis, fixed here as: case `q ≠ 2`:
  `χ(x₂) = (1-q)^{-1}`, else `1`; case `q = 2, n` odd: `χ(x₁) = -1`,
  `χ(x₃) = (1-2^f)^{-1}`, else `1`; case `q = 2, n` even: `χ(x₂) = -(1+α)^{-1}`,
  `χ(x₄) = (1-2^f)^{-1}`, else `1`; and uniqueness by the forced-derivation computation.
  Image table: `1 + qℤ_p`; `{±1} × U^(f)`; and for `n` even `{±1} × U^(f)` if
  `v₂(α) ≥ f`, `U^[f']` with `f' = v₂(α)` if `f' < f`.
- **The `q = 2` even-rank case (Labute Thm 1 via Thms 5–6).** The arguments over
  `Λ = ℤ₂[[Γ]]` with `Γ = Im χ`, using the completed-algebra prerequisite above (power
  series coordinates, evaluation, and the division criterion `T - c ∣ ψ ⟺ ψ(c) = 0`). Two even-rank
  families, with `N = n/2` the number of commutator pairs and `(A : A²)` as declared in
  Layer 8's notation:
  `r = x₁^{2+2^f}(x₁,x₂)(x₃,x₄)⋯` realizes `Im χ = U^[f]`, where `(A : A²) = 2`, for
  `N ≥ 1` and `2 ≤ f ≤ ∞`; and `r = x₁²(x₁,x₂)x₃^{2^f}(x₃,x₄)⋯` realizes
  `Im χ = {±1} × U^(f)`,
  where `(A : A²) = 4`, for `N ≥ 2` and `2 ≤ f < ∞` (`f = ∞` is excluded here). These
  restrictions on `N` and `f` are Labute Thm 1's, and each statement below carries the ones
  it needs as hypotheses rather than as a remark.
  ⚠ **Cite Labute, not NSW, for completeness:** NSW (3.9.19) states only the *existence*
  of the `q = 2` normal forms; which `(α, f)` give isomorphic groups, the classification
  proper, is Labute Thms 1, 2, 4–6 only. ⚠ NSW's second even-form is printed
  `x₂²(x₁,x₂)x₃^{2^f}⋯` (2nd ed. p. 417) where Labute has `x₁²(x₁,x₂)x₃^{2^f}⋯`;
  equivalent up to a basis change, but quote each source's exact form.
- **The classification theorems.** *Uniqueness:* two Demushkin groups with the same `n`
  and `Im χ` are isomorphic; sharpened to Labute Thm 2 (an automorphism of `F` carries any
  Demushkin relator to any other with the same invariants, which is the statement the
  marked and normalized instances need). *Existence* (Labute Remark 2, quoted verbatim): `(n, A)`
  with `A` a closed subgroup of `ℤ_pˣ` is realized provided (i) `n` even and
  `p^n > (A : A^p)`, or (ii) `n` odd `≥ 3` (so `p = 2`) and `A = {±1} × U^(f)`
  (`f ≥ 2` or `∞`), or (iii) `n = 1` and `A = {±1}`. The small-rank edge cases are part of
  the statement, not exceptions to it; for the odd case cite Serre's Thm 3.2 only for
  `n ≥ 3` (its printed `n ≥ 1` degenerates at `n = 1`) and handle `n = 1` via
  NSW (3.9.10)/Labute Remark 2(iii).
- **Consequences.** The open-subgroup theorem was proved in Layer 7 from the concrete
  duality package there; here it acquires its classification content: for `U` open in an
  infinite Demushkin `G`, the invariants of `U` are `n(U) = 2 + [G : U](n(G) - 2)` and
  `Im(χ|_U) = χ(U)`, and the classification then identifies `U` up to isomorphism (Serre
  1962/63 Thm 9.2). ⚠ At `n = 2` the rank formula has `n(U) = 2` for every `U`, so the
  `q ≠ 2` rank-2 groups `ℤ_p ⋊ ℤ_p` and their subgroup structure are the case worth checking
  first.

### Layer 10: free pro-`C` groups on profinite spaces

The home of the infinite-rank theory, as the conventions promise:

- **Construction and universal property.** `F_C(X, ∗)` on a pointed profinite space
  (basis converging to 1): continuous maps `X → P` sending `∗ ↦ 1` classify continuous
  homomorphisms into a profinite `P` in the class `C`. Recovers Layer 4's object for finite
  discrete `X`. For an infinite discrete set `S` the two candidate objects are
  `freeProC C S` (Layer 4's construction, the completion of the abstract free group, whose
  universal property quantifies over *all* maps `S → P`) and `F_C(S⁺, ∗)` on the one-point
  compactification (whose universal property quantifies over maps converging to `1`). The
  inclusion `S → S⁺` induces a continuous surjection `freeProC C S ↠ F_C(S⁺, ∗)`, and the
  theorem to prove about it is that for infinite `S` it is **not** injective. The witness is
  a rank computation rather than a description of the kernel by generators, which this
  roadmap does not claim: at `C = ` finite `p`-groups the continuous characters of the
  source are all the maps `S → 𝔽_p`, a product of dimension `p^{#S}` (Erdős–Kaplansky),
  while those of the target are the finitely supported ones, of dimension `#S`, so the two
  groups have different ranks in the sense of Layer 3. State both objects, state that map,
  and never write "the free pro-`C` group on `S`" without saying which.
- **Bases and rank.** Existence of converging-to-`1` bases, and their uniqueness of
  cardinality; invariance of `topologicalGeneratorRank` under topological isomorphism, as a
  cardinal and with no finiteness hypothesis; and the infinite-rank Frattini argument in the
  form proved in Layer 3, `topologicalGeneratorRank G = dim_{𝔽_p} Hom_cont(G, 𝔽_p)`. The
  rank of `F_C(X, ∗)` at `C = ` finite `p`-groups is the `𝔽_p`-dimension of the space of
  continuous functions `X → 𝔽_p` vanishing at `∗`, which for `X = S⁺` is `#S`.
- **Presentations at arbitrary rank.** Every pro-`p` group admits a presentation by a free
  pro-`p` group on a profinite space, and a minimal one. This is the general statement that
  Layer 5 deliberately does not make.
- **Serre's theorem, full generality.** `cd_p ≤ 1` ⟺ free pro-`p`, without finite
  generation (the Layer 6 proof upgraded with converging-to-1 bases); **closed** subgroups
  of free pro-`p` groups are free pro-`p` (the full pro-`p` Nielsen–Schreier;
  RZ Cor. 7.7.5).
- Nothing later in *this* roadmap depends on this layer (Layers 9 and 11 need only finite
  rank), but without it the theory is truncated rather than finished. It may proceed in
  parallel with Layer 9, after Layer 6.

### Layer 11: `G_K(p)` for `p`-adic fields

Consumes [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) and
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1). For
`K/ℚ_p` finite of degree `N`, `G_K(p) := Gal(K(p)/K)` is the Galois group of the maximal
`p`-extension; intrinsically, `maximalProPQuotient p (Gal(K^sep/K))`, which Layer 3 makes
well defined and functorial. That carrier is named once, here, as
`absoluteGaloisGroupProP p K := maximalProPQuotient p (Field.absoluteGaloisGroup K)`, and
Local Fields Layer 9 cites the name rather than re-forming the quotient for itself.

⚠ Two letters, held apart throughout this layer and the Local Fields roadmap alike: `N` is the
degree `[K : ℚ_p]`, and `d` is the topological rank `topologicalGeneratorRankNat` of Layer 3.
They occur in the same sentences below, so neither is ever written for the other. The kernel of
`G_K ↠ G_K(p)` is written `R`.

- **Inputs, listed as theorem-level contracts.** Every one is a row of the shared layer-DAG
  table under "Ordering and parallelism" below and is cited by the name that table fixes. No
  statement in this layer uses a Local Fields theorem outside this list, and none restates one
  in its own words.
  1. The mixed-characteristic Euler characteristic of Local Fields Layer 8B and its
     `𝔽_p`-module corollary (`eulerCharacteristic_mixed`, `eulerCharacteristic_finrank_fp`):
     `dim_{𝔽_p} H⁰(G_K, 𝔽_p) = 1` and
     `dim_{𝔽_p} H¹(G_K, 𝔽_p) = 1 + dim H²(G_K, 𝔽_p) + N`. Duality in degree `0` (input 3)
     supplies `dim_{𝔽_p} H²(G_K, 𝔽_p) = dim_{𝔽_p} H⁰(G_K, μ_p)`, whence
     `dim H²(G_K, 𝔽_p) = 1` if `μ_p ⊆ K` and `= 0` otherwise. ⚠ That last equality is a
     duality statement and not an Euler one; it is listed here because the case split below
     reads off both at once.
  2. The trace isomorphism `H²(G_K, μ_p) ≃ ZMod p`, and its transport to `H²(G_K, 𝔽_p)` under
     a choice of `p`-th root of unity when `μ_p ⊆ K` (`h2MuEquivZMod_mixed`,
     `h2FpEquivZMod_of_mu`). ⚠ This is Local Fields Layer **8B**, not 8A: the 8A statement of
     the same shape carries `IsUnit (n : 𝒪[K])` and so says nothing at `n = p` in mixed
     characteristic. Citing 8A here would be citing a theorem that does not apply.
  3. Perfectness of the local Tate duality pairing at `n = p` in mixed characteristic
     (`tateDualityPairing_perfect_mixed`, its Layer 8B), and the identification of that
     pairing with the Hilbert-symbol pairing at `p = 2`
     (`hilbertSymbol_eq_tateDuality_pairing`, its Layer 8C).
  4. Kummer theory `Kˣ/(Kˣ)^p ≃ H¹(G_K, μ_p)` (`kummerEquiv`, its Layer 5) and the
     compatibility square relating Kummer classes to the cup product (`cup_kummerEquiv`),
     which is what identifies the cup pairing on `H¹(G_K, 𝔽_p)` with the symbol pairing on
     square (resp. `p`-th power) classes.
  5. The Artin map (`artinMap`) and the cyclotomic character `χ_cyc : G_K → ℤ_pˣ` with the
     normalization

     ```text
     χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹  in ℤ_pˣ, for u ∈ 𝒪[K]ˣ
     ```

     (`cyclotomicCharacter_artinMap`, its Layer 7), from which the image
     `χ_cyc(G_K) = Gal(K(μ_{p^∞})/K)` and the identification of the finite quotients of the
     cyclotomic module are computed. ⚠ The field norm is part of the statement. The norm-free
     form `χ_cyc(Art_K(u)) = u⁻¹` is the `K = ℚ_p` corollary
     (`cyclotomicCharacter_artinMap_padic`) and is ill-typed for `K ≠ ℚ_p`; an `𝒪[K]ˣ`-valued
     character with that value would be a Lubin–Tate character, which neither roadmap builds.
     Nothing below may cite the corollary in place of the theorem.
  Item 4's compatibility square is also what shows that the finite quotients `μ_{p^i}` of the
  cyclotomic module satisfy the prescription property of Layer 7, used in the orientation
  theorem below. In particular **finite generation is not an input**: it is proved below, and
  Local Fields consumes it rather than supplying it.
- **Inflation in degree one.** Let `R := ker(G_K ↠ G_K(p))`. Inflation
  `H¹(G_K(p), 𝔽_p) → H¹(G_K, 𝔽_p)` is an isomorphism, directly from the universal property
  of the maximal pro-`p` quotient: a continuous homomorphism `G_K → 𝔽_p` factors uniquely
  through `G_K(p)`.
- **`G_K(p)` is topologically finitely generated**
  (`isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`). Input 1 makes `H¹(G_K, 𝔽_p)`
  finite-dimensional; the degree-one isomorphism transports that to `H¹(G_K(p), 𝔽_p)`, which
  is the discrete dual of `G_K(p)/Φ(G_K(p))`, so that Frattini quotient is finite and
  Layer 3's criterion makes the pro-`p` group `G_K(p)` topologically finitely generated,
  with `d(G_K(p)) = dim_{𝔽_p} H¹(G_K, 𝔽_p)`. Nothing in the argument needs finite generation
  of `G_K` itself, which is what keeps the two roadmaps in an acyclic order: Local Fields
  Layers 0–8, then this layer, then Local Fields Layer 9.
- **Injectivity in degree two.** `H¹(R, 𝔽_p)^{G_K(p)} = 0`: a nonzero invariant class would
  produce a `G_K`-stable open subgroup of `R` of index `p`, hence a `p`-extension of `K`
  strictly larger than `K(p)`, contradicting maximality (a Layer 3 argument, using the
  Frattini/Burnside criterion). With the degree-one isomorphism, the five-term sequence
  `0 → H¹(G_K(p)) → H¹(G_K) → H¹(R)^{G_K(p)} → H²(G_K(p)) → H²(G_K)`
  gives that `H²(G_K(p), 𝔽_p) → H²(G_K, 𝔽_p)` is **injective**.
  ⚠ The five-term sequence gives injectivity and nothing more; surjectivity needs the case
  split below, and stating the isomorphism outright would leave a gap in its place.
- **Surjectivity in degree two, by cases on `μ_p`.**
  - If `μ_p ⊄ K`, then `H²(G_K, 𝔽_p) = 0` by input 1, so injectivity forces
    `H²(G_K(p), 𝔽_p) = 0` and inflation is trivially an isomorphism.
  - If `μ_p ⊆ K`, then `dim H²(G_K, 𝔽_p) = 1` by input 1 and the cup pairing on
    `H¹(G_K, 𝔽_p)` is nondegenerate by input 3, so there are classes `a, b ∈ H¹(G_K, 𝔽_p)`
    with `a ∪ b ≠ 0`. Lift them through the degree-one inflation isomorphism to
    `ã, b̃ ∈ H¹(G_K(p), 𝔽_p)`. Inflation commutes with cup products (PR #1, Layer 8), so
    `inf(ã ∪ b̃) = a ∪ b ≠ 0`; hence inflation on `H²` hits a nonzero class of a
    one-dimensional space and is **surjective**. With injectivity, it is an isomorphism.
  This case split is the whole of the degree-two statement; state the two cases as separate
  named theorems and the isomorphism as their corollary.
- **The free case (Shafarevich).** If `μ_p ⊄ K`: `G_K(p)` is free pro-`p` of rank `N + 1`
  (`H²(G_K(p), 𝔽_p) = 0` from input 1 and the degree-two case split above; then Layer 6's
  Serre theorem, whose finite-generation hypothesis is the item above, plus the `H¹` count).
  The rank statement is
  `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu : d(G_K(p)) = N + 1`, which is
  what Local Fields Layer 9 consumes for its lower bound. Also record the `K = ℚ_p, p ≠ 2`
  instance: free of rank 2.
- **The Demushkin case.** If `μ_p ⊆ K`: `G_K(p)` is Demushkin with `n = N + 2` and
  `q = #(μ_{p^∞} ∩ K)` = the largest `p`-power `q` with `μ_q ⊆ K` (Labute §5;
  NSW VII §7.5). Each clause of `IsDemushkin` is verified through the degree-one and
  degree-two inflation isomorphisms above: `dim H¹ = N + 2` and `dim H² = 1` from input 1,
  nondegeneracy of the cup pairing from input 3 plus compatibility of inflation with cup
  products. The rank statement is
  `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu : d(G_K(p)) = N + 2`, the
  companion Local Fields Layer 9 consumes. **The orientation is cyclotomic:** the canonical
  character of Layer 7 is the descent to `G_K(p)` of the cyclotomic character. Route
  (Labute §5): the character `χ_cyc` is trivial on `R` (its values lie in a pro-`p` group, so
  it factors through `G_K(p)`), the Kummer compatibility of input 4 shows that the finite
  quotients `I(χ_cyc)/p^i = μ_{p^i}` satisfy the prescription property of Layer 7, and the
  uniqueness half of Labute Thm 4 then forces `demushkinCharacter (G_K(p)) = χ_cyc`. This is
  the mathematical content of `gq2`'s "dualizing = cyclotomic" clause, and it is a theorem of
  this layer.
- **Explicit presentations** (now corollaries of Layer 9 + the invariants):
  `q ≠ 2`: `G_K(p) = ⟨x₁, …, x_{N+2} ∣ x₁^q(x₁,x₂)(x₃,x₄)⋯(x_{N+1},x_{N+2})⟩` (Demushkin's
  theorem = Labute Thm 7); `q = 2`, `N` odd: `⟨x₁, …, x_{N+2} ∣ x₁²x₂⁴(x₂,x₃)(x₄,x₅)⋯⟩`
  with `Im χ = ℤ₂ˣ` (Serre's theorem = Labute Thm 8; `N` odd forces
  `K ∩ ℚ₂(μ_{2^∞}) = ℚ₂`, so `f = 2`); `q = 2`, `N` even: the two Layer 9 families per
  `Im χ` (Labute Thm 9).
- **Acceptance instances, stated intrinsically.**
  - `K = ℚ₂` (`N = 1`, `q = 2`): `G_{ℚ₂}(2) ≅ D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩`, rank 3,
    `q = 2`, `Im χ = ℤ₂ˣ`, `χ` cyclotomic with (Thm 4 case-2 values, `f = 2`)
    `(χ(A), χ(S), χ(Y)) = (-1, 1, (1-2²)^{-1} = (-3)^{-1})` on the normal-form basis.
    This, and not any marked refinement, is the roadmap's form of the statement; the
    marked-generator normalization stays in `gq2` (provenance section).
  - `K = ℚ₂(√-2)` (`N = 2`, `q = 2`, `Im χ = U^[2] = closure ⟨3⟩`, of index 2 in `ℤ₂ˣ`):
    `G_K(2) = ⟨x, y, z, w ∣ x⁶(x,y)(z,w)⟩`: Labute's closing example, the dyadic-
    exceptional family made concrete, and the acceptance test that the `U^[f]` branch is
    right.
  - `K ⊇ μ_p`, `p` odd, e.g. `K = ℚ_p(μ_p)`: `N = p - 1`, `q = p`, normal form
    `x₁^p(x₁,x₂)(x₃,x₄)⋯(x_p, x_{p+1})`, the `q = p^f ≠ 2` canonical form in a small
    case.

## Worked examples (acceptance criteria)

Collected from the layers; each catches a specific way a definition could go vacuous or get
mis-normalized:

- `ℤ̂`-Sylow: every `p`-Sylow subgroup of the profinite completion of `ℤ` is `ℤ_p`
  (Layers 0–2, proved in Layer 4; `Suggested.lean`).
- `d(ℤ/4 × ℤ/2) = 2` and `d((ℤ/p)ⁿ) = n`, `r((ℤ/p)ⁿ) = n(n+1)/2` (Layers 3, 5).
- `d(∏_{i ∈ ℕ} ℤ/p) = ℵ₀`, while the algebraic dimension of that group as an `𝔽_p`-vector
  space is `2^{ℵ₀}`: the check that the infinite-rank invariant is the dimension of the
  discrete dual and not of the Frattini quotient itself (Layers 3, 10).
- `U^[2] = closure ⟨3⟩` meets `1 + 4ℤ₂` in `U^(3) = 1 + 8ℤ₂` and has index 2 in `ℤ₂ˣ`: the
  smallest case of the depth formula, checked by squaring (`3² = 9 = 1 + 8`), and the one
  the `ℚ₂(√-2)` instance rests on (Layer 7; `Suggested.lean`).
- `ℤ/2` is Demushkin (`n = 1`, `q = 2`, `Im χ = {±1}`); `ℤ_p` and all free pro-`p` groups
  are not; `ℤ_p²` is Demushkin with `q = 0` (Layer 7, the three rank-degenerate checks).
- `D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩`: nontrivial, pro-`2`, `D₀^{ab} ≅ ℤ₂² × ℤ/2`, `q(D₀) = 2`
  (Layers 5, 7; `Suggested.lean`), all *before* the classification, so the acceptance
  instance cannot silently depend on it.
- Open subgroups: index-2 subgroups of `D₀` are Demushkin of rank 4 (the Layer 7 index
  formula at the smallest case); open subgroups of `freeProP p (Fin n)` have rank
  `1 + m(n-1)` (Layer 6; `Suggested.lean`).
- The nondegenerate symmetric bilinear form on `𝔽_2³` with identity matrix is not
  alternating and has odd dimension: the case with no analogue for `p ≠ 2`, and the one the
  `q = 2`, `n` odd normal form depends on (Layer 9 prerequisites).
- The arithmetic instances: `G_{ℚ₂}(2) ≅ D₀` with cyclotomic `χ` values
  `(-1, 1, (-3)^{-1})`; `G_{ℚ₂(√-2)}(2) = ⟨x,y,z,w ∣ x⁶(x,y)(z,w)⟩`; `G_{ℚ_p(μ_p)}(p)` of
  rank `p + 1` in the `q = p` normal form (Layer 11).

## Ordering and parallelism

Layers 0 → 1 → 2 → 3 → 4 are sequential, each consuming the previous; the finitely generated
abelian pro-`p` structure theory at the end of Layer 4 is independent of everything
cohomological and can be built as soon as Layer 4's inverse-limit material is in place.
After Layer 4, three things can run in parallel: Layer 5's presentation material and the
continuous-extension dictionary; Layer 8 (tower, comparison schema, reconstruction), which
is cohomology-free throughout; and Layer 9's two prerequisites (bilinear forms over `𝔽_p`,
and the procyclic completed group algebra), which are self-contained algebra.

The constraints that actually bind:

- Layer 5 cannot finish before the continuous-extension dictionary and the
  `H²(F, M) = 0` theorem for free pro-`p` `F`, both of which are inside Layer 5 and must be
  built before the relation-rank theorem.
- Layer 6's Nielsen–Schreier rank formula cannot finish before the two-term Euler theorem
  stated in the same layer.
- Layer 7 cannot define `q(G)` before the abelian pro-`p` structure theorem of Layer 4, and
  cannot prove the open-subgroup theorem before its own duality package and the three-term
  Euler formula.
- Layer 9 cannot start its normal-form proofs before *both* prerequisites above; the
  characteristic-two bilinear normal form is needed for the `n` odd case at `q = 2`, and the
  completed group algebra for the even-rank `q = 2` case.
- Layer 10 needs Layer 6 and can run in parallel with Layer 9.
- Layer 11's Demushkin case needs Layers 7 and 9; its free case (Shafarevich) needs only
  Layers 5–6 and the `H²(G_K, 𝔽_p) = 0` input, so it can land before the classification.

Everything cohomological in Layers 5–7, 9, and 11 consumes
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1); the
non-cohomological substatements do not. What the Local Fields roadmap consumes from here is
profinite Sylow theory (Layer 2), the pro-`p` predicate together with Frattini, Burnside, rank
and the Schreier bound (Layer 3), the free and presented profinite objects (Layer 4), and the
rank of `G_K(p)` that the inflation isomorphisms give (Layer 11); the first three are early and
worth delivering early, since that roadmap needs them from its Layer 1 onward. ⚠ The
reconstruction theorem (Layer 8) is **not** on that list: it takes
`IsTopologicallyFinitelyGenerated` as a hypothesis and consumes no Local Fields theorem at all.

### Shared layer-DAG table: Local Fields ↔ Pro-`p` Groups

This subsection is the interface record between the Local Fields roadmap
([PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)) and the Pro-`p` Groups roadmap
([PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3)). **It is maintained in both
roadmaps, and the two copies are identical, wording included**; an edit to either is an edit
to both. Every crossing between the two developments is a row here, and a statement that is
not a row is not an interface: neither roadmap may consume the other through prose alone. The
names are provisional and belong to the supplier, which states the object once; the consumer
cites the name and never restates the object in its own words, which is what keeps the two
sides from growing near-duplicate carriers and comparison maps between them.

| Consumer layer | Supplier layer | Exact object or theorem | Agreed provisional name |
|---|---|---|---|
| Local Fields Layer 1, structure of `Kˣ` | Pro-`p` Groups Layer 3 | the quotient-form pro-`p` predicate, applied to `U(K,1) = lim_i U(K,1)/U(K,i)` | `IsProP` |
| Local Fields Layer 4, wild inertia | Pro-`p` Groups Layer 2 | pro-`p` Sylow subgroups of a profinite group: the predicate, existence, the containment of every closed pro-`p` subgroup in one, uniqueness of a normal one, and the image under a continuous surjection. All five are free of Galois vocabulary; identifying the Sylow subgroup of `I_K` with `Gal(K̄/K^t)` is the Local Fields side | `IsProPSylow`, `exists_isProPSylow`, `IsProP.exists_le_isProPSylow`, `IsProPSylow.eq_of_normal`, `IsProPSylow.map_of_surjective` |
| Local Fields Layer 4, Iwasawa presentation | Pro-`p` Groups Layer 4 | the free **profinite** group on a finite set, its generators and its universal property, together with the quotient by the closed normal closure of a set of relators. This is the shape in which `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^{−q}⟩` is stated, and it is a profinite object, not the pro-`p` `presentedProP` of the same layer | `freeProfiniteGroup`, `freeProfiniteGroup.of`, `freeProfiniteGroup.lift`, `presentedProfiniteGroup` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | topological finite generation, in exactly the pinned shape `∃ s : Finset G, (Subgroup.closure ↑s).topologicalClosure = ⊤` | `IsTopologicallyFinitelyGenerated` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | the topological rank in its cardinal and natural-number forms, its monotonicity under continuous surjections, the Schreier bound `d(U) ≤ 1 + [G : U](d(G) − 1)` for open `U`, and the Burnside generation criterion for pro-`p` groups (a subset generates topologically iff its image generates the Frattini quotient) | `topologicalGeneratorRank`, `topologicalGeneratorRankNat`, `topologicalGeneratorRank_le_of_surjective`, `topologicalGeneratorRankNat_le_of_isOpen`, `topologicallyGenerates_iff_frattiniQuotient` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 11 | `G_K(p)` as a carrier, its topological finite generation, and its rank in both cases: `N + 1` when `μ_p ⊄ K` (free, Shafarevich) and `N + 2` when `μ_p ⊆ K` (Demushkin) | `absoluteGaloisGroupProP`, `isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu` |
| Pro-`p` Groups Layer 11, input 1 | Local Fields Layer 8B | the mixed-characteristic Euler characteristic `#H⁰ · #H² / #H¹ = ‖#M‖_K` and its `𝔽_p`-module corollary `dim H¹ = dim H⁰ + dim H² + N · dim M` | `eulerCharacteristic_mixed`, `eulerCharacteristic_finrank_fp` |
| Pro-`p` Groups Layer 11, input 2 | Local Fields Layer 8B | the trace isomorphism `H²(G_K, μ_n) ≃ ZMod n` for **every** `n ≥ 1` in mixed characteristic, which is the value object of the 8B pairing, together with its transport to `H²(G_K, 𝔽_p)` along a choice of `p`-th root of unity when `μ_p ⊆ K`. ⚠ The 8A statement of the same shape carries `IsUnit (n : 𝒪[K])` and therefore says nothing at `n = p`; citing 8A for this input is the mistake to avoid | `h2MuEquivZMod_mixed`, `h2FpEquivZMod_of_mu` |
| Pro-`p` Groups Layer 11, input 3 | Local Fields Layer 8B | perfectness of the local Tate duality pairing at `n = p` in mixed characteristic, in degrees `0`, `1`, `2` | `tateDualityPairing_perfect_mixed` |
| Pro-`p` Groups Layer 11, input 3 | Local Fields Layer 8C | the identification of that pairing at `p = 2` with the classical Hilbert symbol | `hilbertSymbol_eq_tateDuality_pairing` |
| Pro-`p` Groups Layer 11, input 4 | Local Fields Layer 5 | Kummer theory `Kˣ/(Kˣ)ⁿ ≃ H¹(G_K, μ_n)`, and the square relating Kummer classes to the cup product | `kummerEquiv`, `cup_kummerEquiv` |
| Pro-`p` Groups Layer 11, input 5 | Local Fields Layer 7 | the Artin map, and the cyclotomic orientation `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹` for `u ∈ 𝒪[K]ˣ`, with its `K = ℚ_p` corollary `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹`. ⚠ The field norm is part of the statement, not decoration: without it the equation is ill-typed for `K ≠ ℚ_p`, and the `𝒪[K]ˣ`-valued character with value `u⁻¹` is a Lubin–Tate character that neither roadmap builds | `artinMap`, `cyclotomicCharacter_artinMap`, `cyclotomicCharacter_artinMap_padic` |

Throughout the table `N = [K : ℚ_p]` and `p` is the residue characteristic; `K` is a finite
extension of `ℚ_p` in every row that mentions either.

Reading the table by layer gives the schedule

```text
Pro-p Groups 0-4  →  Local Fields 0-8  →  Pro-p Groups 11  →  Local Fields 9,
```

which is acyclic. Pro-`p` Groups Layers 5–10 have no Local Fields edge in either direction, so
they are unconstrained relative to this order, and Local Fields Layers 0–3 wait only on the
early pro-`p` foundations. Both roadmaps carry this sentence.

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

| Supplier | Supplied milestones | Consumer |
|---|---|---|
| This PR, Layers 0–2 | existence and conjugacy of pro-`p` Sylow subgroups, supernatural order and index | [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)'s Layer 11 Sylow equality `cd_p G = cd_p G_p` |
| [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1), Layers 2, 5, 6, 7, 8, 11 | explicit `H¹`/`H²` with finite discrete coefficients; long exact and five-term sequences; change of groups; coinduction and Shapiro's lemma for open subgroups; cup products with inflation-compatibility; cohomological-dimension vocabulary and its pro-`p` dévissage | This PR's Layers 5–7, 9, and 11 |

The Profinite Cohomology exchange is split by layer in the same way as the Local Fields one:
its Layer 11 consumes our Layers 0–2, while our Layers 5–11 consume its Layers 2–8 and 11.
Neither supplier waits on a result that it supplies. Cite that roadmap's layers by title as
well as by number, since its numbering moved once while both branches were open.

⚠ **Not a supplier.**
[Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4) is a
roadmap about quadratic forms over fields with `2` invertible and explicitly excludes
characteristic-two quadratic and bilinear form theory. It supplies nothing to this roadmap,
and the characteristic-two bilinear algebra that Labute's dyadic classification needs is
owned here, in the Layer 9 prerequisites.

## References

- J. P. Labute, *Classification of Demushkin groups*, Canad. J. Math. 19 (1967), 106–132.
  **The source of record for Layers 7 and 9**: the definition (p. 106), §1.3–1.4 (rank
  interpretations), §1.5 (`ℤ_p[[G]]`), §2 (the `q`-central series and the graded Lie
  algebra, Props. 1–5), §3 (the invariant `Im χ`, Prop. 6, Thm 4 and its Corollary), §4
  (Thms 5–6, the Iwasawa-algebra arguments), Thms 1–2 (the even-rank classification), §5
  (Thms 7–9, `G_K(p)`, and the `ℚ₂(√-2)` example).
- J.-P. Serre, *Structure de certains pro-p-groupes (d'après Demuškin)*, Séminaire Bourbaki
  1962/63, no. 252. §2 (2.1–2.3: generation/relation criteria, free ⟺ `H² = 0`), §3
  (Thm 3.1 `q ≠ 2`, Thm 3.2 `q = 2` `n` odd incl. the `n = 2` family
  `⟨x, y ∣ yxy⁻¹ = x^{-(1+k)}⟩`), §§6–7 (the `q`-central series and the `q = 2`
  breakdown), §9 (Tate: 9.1 `cd = 2`, 9.2 open subgroups Demushkin with
  `n_H - 2 = [G : H](n_G - 2)`; 9.3 characterizes `χ` through the dualizing module, a
  formulation this roadmap replaces by the concrete finite-coefficient package of Layer 7).
  ⚠ opposite commutator convention (see conventions).
- J.-P. Serre, *Galois Cohomology* (Springer; transl. of *Cohomologie Galoisienne*). I
  §3–§4: `cd`, free pro-`p` ⟺ `cd ≤ 1`, generator/relation ranks, I §4.5 Demushkin summary,
  I Prop. 25–26 (the generation/relation dualities Labute cites).
- L. Ribes, P. Zalesskii, *Profinite Groups*, 2nd ed., Springer (2010). **The source of
  record for Layers 0–4 and 10**: Thm 2.1.3 (profinite characterizations), §2.3
  (supernatural order and index, Prop 2.3.2 Lagrange; Sylow: Cor 2.3.6), §2.8 (Frattini:
  2.8.7 `Φ = closure(Gᵖ[G,G])`, 2.8.10 f.g. ⟺ `Φ` open, 2.8.13 Frattini series as
  neighborhood basis), §3.2 (3.2.8–3.2.9 finite-quotient determinacy), §3.3 (free pro-`C`:
  profinite spaces, converging-to-1, Prop 3.3.6 completion of a free group), Thm 3.6.2 +
  Cor 3.6.3 (open Nielsen–Schreier, transversal route), Ch. 7 (7.5.1 embedding-problem
  characterization of `cd ≤ 1`, 7.7.4 `cd ≤ 1` ⟺ `H² = 0` ⟺ free ⟺ projective, 7.7.5
  closed subgroups, §7.8 rank theory incl. 7.8.5 Golod–Shafarevich).
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed., Springer
  (2008). III §4 and III §7 develop dualizing modules, duality groups, and Poincaré groups
  in general; **that theory is background here, not a dependency**, and no milestone above
  uses those notions (Layer 7 proves the concrete Demushkin statements directly). III §9
  is what we consume: 3.9.1 (Burnside, `d = dim H¹`),
  3.9.4–3.9.5 (`r = dim H²`, free ⟺ `cd ≤ 1`), 3.9.7 (Golod–Shafarevich), 3.9.9 (Demushkin
  definition), 3.9.10 (`ℤ/2`), 3.9.11 (`q ≠ 2` classification), 3.9.12–3.9.14 (trace and cup
  matrices), 3.9.15 (Andozhskii–Dummit–Labute characterizations; we state the three of its
  equivalences that do not mention a dualizing module), 3.9.19 (`q = 2` normal forms,
  existence only). Also VII §5 (7.5.9 `ℓ ≠ p`, 7.5.10 char `p`, **7.5.11** the `G_K(p)`
  dichotomy, **7.5.12** explicit presentations) and VII (7.4.1) for the `[K : ℚ_p] + 2`
  generator bound the LocalFields sibling proves.
- H. Koch, *Galois Theory of p-Extensions*, Springer (2002). Ch. 4 (free pro-`p`: 4.6
  universal property, 4.8 projectivity, 4.10 Burnside basis, 4.12 free ⟺ `H² = 0`), Ch. 6
  (6.1–6.2 `d(G)`, 6.13 relation rank = `dim H²`, Example 6.3 the Euler-characteristic
  Schreier formula), Ch. 10 (arithmetically normalized generators for `G_K(p)`; Thms 10.5,
  10.9, 10.12, where the relation is pinned only mod the Zassenhaus filtration, a useful contrast
  to Labute's exact normal forms).
- S. P. Demushkin, *On the maximal p-extension of a local field* (Russian), Izv. Akad. Nauk
  SSSR 25 (1961), 329–346; *On 2-extensions of a local field* (Russian), Sibirsk. Mat. Ž. 4
  (1963), 951–955. The original `q ≠ 2` classification (and the flawed 2-adic attempt
  corrected by Labute Thm 9's `U^[f]` family).
- I. R. Shafarevich, *On p-extensions* (Russian), Mat. Sb. 20 (1947), 351–363; transl.
  AMS Transl. Ser. 2, 4 (1956), 59–72. The free case of Layer 11.
- U. Jannsen, K. Wingberg, *Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper*,
  Invent. Math. 70 (1982), 71–98. The full `G_K` (not just `G_K(p)`) for `p` odd; context
  for why the pro-`p` quotient is the right first target (out of scope here beyond
  citation).
- M. Lazard, *Sur les groupes nilpotents et les anneaux de Lie*, Ann. Sci. ENS 71 (1954).
  The graded-Lie-algebra theory under Layer 8/9 (Labute's reference (6)).
- J. D. Dixon, E. Formanek, J. Poland, L. Ribes, *Profinite completions and isomorphic
  finite quotients*, J. Pure Appl. Algebra 23 (1982), 227–231. Layer 8's determinacy
  corollary for abstract groups.

## Provenance, coordination, and licensing

The records below state only evidenced status as of 2026-08-01. Missing revision, licence, or
contact information blocks code adaptation; it never stands for tacit permission.

- **Project / authors:** `roed-math/gq2-lean` / roed-math contributors. **Exact revision or PR:**
  `d0714a7c431b64e18c422fb16cb5e93d79e5be25`. **Licence:** Apache-2.0. **Overlap:** single-
  instance implementations across Layers 0, 3–5, and 7–8. **Contact / coordination status:** same
  repository owner; no separate author-contact outcome is asserted. **Agreed ownership:** the
  intrinsic reusable API belongs here; marked `G_{Q_2}` adapters remain in `gq2`. **Plan:** adapt
  with file-level credit and generalize, never copy project-local axioms or encodings as the
  specification. **Refactor trigger:** each public Tau Ceti layer acquiring its target types.
- **Project / authors:** `davidturturean/gq2-lean-turturean` / David Turturean. **Exact revision or
  PR:** no immutable revision is pinned in this branch. **Licence:** GPL-3.0. **Overlap:** maximal
  pro-2 quotient and an axiomatized Labute classification. **Contact / coordination status:** no
  contact outcome is recorded. **Agreed ownership:** none required because no integration is
  planned. **Plan:** statement/decomposition audit only; no code transfer to Apache-2.0 Tau Ceti.
  **Refactor trigger:** none.
- **Project / authors:** `n-yamaguchi-0729/ProCGroups` / repository contributors. **Exact revision
  or PR:** no immutable revision is pinned in this branch. **Licence:** Apache-2.0 as reported by
  the repository audit. **Overlap:** free pro-`C` groups, maximal quotients, completed group
  algebras, Fox calculus, and Reidemeister–Schreier. **Contact / coordination status:** no contact
  outcome is recorded. **Agreed ownership:** none recorded. **Plan:** no reuse or API adaptation
  until a revision is pinned, the work is reviewed declaration-by-declaration, and coordination is
  recorded; independent development with citation remains the current plan. **Refactor trigger:**
  completion of that audit and coordination record.
- **Project / authors:** Mathlib profinite-group line / Nailin Guan, Yuyang Zhao, Jujian Zhang,
  Adam Topaz, Thomas Browning; continuous-cohomology line / Richard Hill, Andrew Yang, Edison Xie.
  **Exact revision or PR:** #16648, #16992, #16993, #20740, #34893, #35540, #39973, #42200,
  #41539, and #41545. **Licence:** Apache-2.0 (Mathlib). **Overlap:** foundational profinite
  categories/completion/finiteness and cohomological interfaces. **Contact / coordination status:**
  no direct contact outcome is recorded in this repository. **Agreed ownership:** no agreement is
  recorded; Mathlib owns its existing categories and canonical cohomology carrier. **Plan:**
  consume those APIs and contribute compatible general lemmas upstream; do not fork them.
  **Refactor trigger:** each listed PR landing or changing public names.
- **Project / authors:** Mathlib `p`-adic measures #41961 / David Loeffler, and `lean-iwasawa` /
  Jz Pan. **Exact revision or PR:** Mathlib #41961; no immutable `lean-iwasawa` revision is pinned.
  **Licence:** Mathlib is Apache-2.0; `lean-iwasawa` licence is not recorded here. **Overlap:**
  completed group algebras, used here by the `q = 2` even-rank case. **Contact / coordination
  status:** no contact outcome is recorded. **Agreed ownership:** none recorded. **Plan:** build the
  procyclic package specified in the Layer 9 prerequisites; it is small, and the
  classification cannot be stated without it. If a compatible upstream carrier lands, reprove the
  same theorems
  against it or supply a proved ring isomorphism to it; the intrinsic statements do not change
  either way. **Refactor trigger:** #41961 landing with a carrier that supports the power-series
  coordinate and the division criterion.

**Migration source (primary).** `roed-math/gq2-lean` (Apache-2.0, same owner, so no licensing
obstacle) contains working single-instance implementations of much of Layers 0, 3–5, 7–8 at
a June-2026 Mathlib. Per the "improve, don't canonize" rule, the roadmap above specifies the
mathematics intrinsically; this map is for provenance and reviewer orientation only, and
none of these files' choices (universe placements, `Nat.card` dimension encodings, marked
generators) is prescriptive:

- `GQ2/ProfiniteQuotient.lean` → Layer 0 (quotients by closed normal subgroups profinite).
- `GQ2/MaxProP.lean` → Layer 3 (`IsProP`, `proPKernel`, universal property; the roadmap
  keeps its quotient-form pro-`p` definition).
- `GQ2/FinitelyGenerated.lean` → Layer 3 (the `IsTopologicallyFinitelyGenerated` shape and
  its surjection stability).
- `GQ2/FrattiniCriterion.lean`, `GQ2/FrattiniNongen.lean` → Layer 3 (index-`p` detection,
  Burnside surjectivity criterion; finite `p`-group coatom lemmas).
- `GQ2/FreeProfinite.lean`, `GQ2/ProfinitePresentation.lean` → Layers 4–5 (completion-based
  free profinite groups, closed-normal-closure presentations).
- `GQ2/Zhat.lean` → Layers 0–2 stress objects (`ℤ̂`, profinite exponentiation; the
  `x^λ, λ ∈ ℤ̂` calculus is worth migrating with Layer 4).
- `GQ2/Demushkin.lean` → Layer 7 (an `IsDemushkin` structure with `Nat.card` clauses
  against a project-local continuous-cohomology API; the `ℤ/2` positive and trivial-group
  negative stress tests migrate as Layer 7 examples). ⚠ Its `demushkinQ` (torsion count,
  no `q = 0` case) is a documented deviation the roadmap's convention *fixes*; port the
  statement, not the convention.
- `GQ2/Orientation.lean` + axiom `B3c` (`GQ2/Foundations/Axioms.lean`) → the Layer 11
  `ℚ₂` instance. The axiom bundles (a) Labute Thm 4(2) values, (b) dualizing = cyclotomic,
  (c) a marked-isomorphism normalization; Layers 7/9/11 make (a) and (b) theorems, and (c)
  (the choice of marked generators `A, S, Y` and the exact value bundle) **stays in
  `gq2`** as a thin adapter, per its own documentation.
- `GQ2/Roe/Labute/{TwoCentralTower,Levelwise,StageLemma,SpanFoundation,GradedLie/*,Assembly}.lean`
  + `GQ2/Reconstruction.lean` → Layer 8. This is the completed one-instance rank-3 `q = 2`
  classification (`bLab`, sorry-free at the standard axioms): lower 2-central tower with
  openness/cofinality, levelwise comparison sets with a character shadow as the side
  condition, span/stage lemmas along `gr`, König assembly
  (`exists_contSurj_of_levelwise_nonempty`), two epimorphisms and the Hopf property. Layer 8 is its
  abstraction (the side-condition slot generalizes the χ-shadow); Layer 9 is the general
  theorem it instantiated. Its graded-Lie span arguments are the seed of Layer 9's
  Prop.-5 approximation argument.
- `GQ2/Devissage*.lean` (module-coefficient two-out-of-three dévissage) is **not** in this
  roadmap's scope: it is self-duality machinery for the `gq2` paper's word complex, cited
  here only to delimit the migration.

**Independent formalization (audit only, no code transfer).**
`davidturturean/gq2-lean-turturean` (GPL-3.0) contains a from-scratch maximal pro-2
quotient (`Q2Presentation/Boundary/MaximalPro2.lean`) and consumes the classification as an
axiom (`labute_GQ2_maxPro2_marked` in `Local/LabuteClassification.lean`), useful as an
independent decomposition cross-check for Layers 3 and 11. GPL: no code may be copied into
Apache-licensed Tau Ceti without an explicit licensing decision; cite, don't port.

**Overlapping new work (assess and coordinate before building).**
`n-yamaguchi-0729/ProCGroups` (Apache-2.0, created 2026-07-28, AI-generated, unreviewed,
unannounced on Zulip) claims free pro-`C` groups with universal property, maximal pro-`C`
quotients, completed group algebras, Fox calculus, Reidemeister–Schreier, and profinite
Crowell exact sequences, overlapping Layers 3–5 and the Layer 9 prerequisites (no
Demushkin content). Audit it declaration-by-declaration and contact the author; the license
permits reuse, but the coordination rule (and review standards) apply. Independent
development with citation is the default and no milestone above is contingent on the audit's
outcome: if its material passes review it saves work in Layers 3–5, and if it does not the
targets are unchanged.

**Mathlib coordination.** The `ProfiniteGrp` line is Nailin Guan, Yuyang Zhao, Jujian
Zhang (category, limits, Galois-profinite; Zulip PR-review threads #16648, #16992, #16993,
#20740) with Adam Topaz (completion, #34893) and Thomas Browning (residual finiteness
#35540, additivization #39973, `IsMulFG` #42200). Contact before upstreaming anything
touching those files, and follow their Hom-wrapper category conventions. The continuous-
cohomology line (R. Hill, A. Yang, E. Xie; open #41539/#41545) is coordinated through the
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1). D. Loeffler's `p`-adic
measure PRs (#41961) and Jz Pan's `lean-iwasawa` (Iwasawa algebras over `ℤ_p`-extensions)
border Layer 9's `ℤ₂[[Γ]]` needs. Register intentions per the repository's claims process
before substantial pushes.
