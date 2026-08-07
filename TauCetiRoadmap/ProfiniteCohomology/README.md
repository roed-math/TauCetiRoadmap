# Roadmap: continuous cohomology of profinite groups

Continuous cochain cohomology of a profinite group acting on discrete modules is the language of
Galois cohomology. Local and global class field theory, the duality theorems, Demushkin groups,
and the cohomological invariants of quadratic forms are all written in it. Mathlib is
mid-construction: it has a deep theory of discrete group cohomology, and a continuous cohomology
functor of which only degree `0` has been computed. Almost everything one computes with is
missing, at Mathlib and at every neighboring project: explicit inhomogeneous `H⁰, H¹, H²` with
their cocycle identities, the comparison isomorphisms between models, the description as a colimit
over finite quotients, long exact sequences, corestriction, Shapiro's lemma for closed subgroups,
cup products with their compatibilities, cohomological dimension, Hilbert 90 and Kummer theory in
profinite form, and the Evens norm. This roadmap builds that theory.

One definitional decision is fixed before anything else: **we do not create a third cohomology
theory.** Mathlib's continuous cohomology is the canonical object. An explicit inhomogeneous
low-degree layer, with `H⁰, H¹, H²` presented as subquotients of honest function spaces, is the
calculational interface. Comparison isomorphisms in degrees `0, 1, 2` identify the two, so that
restriction, inflation, corestriction, cup products and connecting maps each have one public
normalization and one computable description. The low-degree layer is where arithmetic happens;
the canonical layer is where the theory is stated in all degrees.

Suggested home: `TauCeti/RepresentationTheory/Homological/ContCohomology/`, mirroring the Mathlib
path so that files can be refactored onto the canonical API one at a time, with the
field-theoretic interface (Hilbert 90, Kummer classes) in
`TauCeti/FieldTheory/GaloisCohomology/`. The Tau Ceti code repository contains no cohomology,
profinite-group, or Galois-theoretic material, so all of this is new work there.

---

## 1. Scope

### Owned here

1. Discrete modules over a topological group: the openness API, the closure properties actually
   used, continuous sections of profinite quotients (Layer 0).
2. The explicit inhomogeneous complex in degrees `0, 1, 2` over an arbitrary topological group,
   with functoriality by compatible pairs and the three named instances (Layer 1).
3. The comparison isomorphisms: explicit against canonical for profinite groups, and continuous
   against Mathlib's discrete `groupCohomology` for discrete groups (Layer 2).
4. The description of `Hⁱ(G, M)` as a colimit over finite quotients, in low degrees explicitly
   and in all degrees canonically (Layers 3 and 9).
5. Long exact sequences, inflation-restriction, and the five-term sequence with an explicit
   transgression (Layer 4).
6. Change of groups: restriction, corestriction, conjugation, transitivity, `cor ∘ res`, and the
   Mackey double-coset formula (Layer 5), and their all-degree forms (Layer 9).
7. Coinduced discrete modules over closed subgroups, Shapiro's lemma, acyclicity, and dimension
   shifting (Layers 6 and 9).
8. Cup products in the six low-degree shapes with associativity, graded commutativity, and the
   restriction, inflation, projection and connecting-map compatibilities (Layer 7), together with
   the graded all-bidegree product (Layer 11).
9. Cohomological dimension `cd_p`, `cd`, `scd_p` with their dévissage and closed-subgroup theory
   (Layer 10).
10. The Galois interface: profinite Hilbert 90 and the Kummer isomorphism with its explicit
    cocycle (Layer 8).
11. The Evens norm on `𝔽₂`-cohomology for open subgroups, in both the explicit index-2 form and
    the general monomial construction (Layer 12).

### Consumed

Named theorem by theorem, or file by file, in §4 (Mathlib) and Appendix A (work in flight
upstream). They are: Mathlib's discrete `groupCohomology` package including `LowDegree`,
`Functoriality`, `LongExactSequence`, `Shapiro` and `Hilbert90`; Mathlib's
`OpenSubgroup`/`OpenNormalSubgroup`, `ProfiniteGrp` and `ClopenNhdofOne` material; Mathlib's
Krull topology, infinite Galois correspondence and separable-closure API; Mathlib's
`ContCohomology` on master, once the pin reaches it (external prerequisite E0 below); and FLT's
canonical cup product.

### Supplied to other roadmaps

Theorem-level contracts only, listed in §2.

### Out of scope

This list is definitive, not a list of things that might come later.

- The Hochschild-Serre spectral sequence. Layer 4 builds the five-term exact sequence directly
  from cochains and stops there.
- Non-discrete topological coefficient modules: `ℤ_p(1)`, Iwasawa-theoretic limits, condensed
  coefficient systems. The canonical object is defined for these, but no theorem here is stated
  for them.
- All-degree explicit inhomogeneous cochains `C(Gⁿ, M)` for groups that are not profinite. Layer
  2 gives the inhomogeneous description exactly where currying is an equivalence.
- Evens norms for coefficients other than `𝔽₂` with trivial action, and the even-degree
  restriction that general coefficients force.
- Profinite Sylow theory and the resulting equality `cd_p G = cd_p G_p`. That belongs to the
  [Pro-p Groups roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/3), which owns the
  existence and conjugacy of pro-`p` Sylow subgroups and supernatural indices.
- Projective representations, factor sets, and Schur multipliers as representation theory. This
  roadmap supplies `H²` and nothing about its representation-theoretic applications.

### External prerequisite E0

**E0.** Tau Ceti's Mathlib pin contains the public `ContCohomology` carrier (`TopRep k G`, the
homogeneous cochain complex, `continuousCohomology n`), its functoriality in compatible pairs, and
the restriction and inflation natural transformations.

E0 is not work anyone does inside this roadmap, and it is not a dependency on an unmerged pull
request: the carrier and its functoriality are on Mathlib master already, so a toolchain bump
satisfies it. Every milestone below marked **(needs E0)** is mandatory roadmap content, built
here, and the roadmap is not complete while any of them is still prose. State those milestones
mathematically, against the objects rather than against the declaration names an open pull request
happens to use, so that a rename costs a search-and-replace and not a redesign. The explicit
low-degree files do not touch E0 at all and can be built first.

---

## 2. Boundaries with neighboring roadmaps

### With the representation theory family

The repository already has
[`RepresentationTheory/InductionRestriction`](../RepresentationTheory/InductionRestriction/README.md),
which covers algebraic induction and coinduction, finite-index comparisons, Mackey theory for
finite groups, and projective representations. The division of labor is:

| That roadmap owns | This roadmap owns |
|---|---|
| Algebraic `Rep` induction and coinduction and their adjunctions | Topological coinduction of discrete modules for closed subgroups of profinite groups |
| `Rep.indCoindIso` and the finite-index algebraic comparison | The comparison of the topological coinduction with the algebraic one for open subgroups |
| Mackey decomposition and the irreducibility criterion for finite groups | Continuous restriction, corestriction, Shapiro, the continuous Mackey formula, and their comparison with the finite-level statements |
| Projective representations, factor sets, Schur multipliers | The continuous and discrete `H²` themselves, with no representation-theoretic application |

Layer 6 cites that roadmap where it uses the algebraic finite-index theory, and does not restate
algebraic induction milestones. The theorem joining the two is Layer 6's comparison for open
subgroups.

### What this roadmap supplies to its consumers

These are theorem-level dependencies, not subject-area ones. The links are the review-time
locations of sibling roadmaps still under review; once they merge, replace each link by a relative
path.

| Consumer | Milestones supplied here |
|---|---|
| [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) | Layer 2's explicit/canonical and finite-level comparisons; Layer 4's long exact and five-term sequences; Layer 5's restriction and corestriction; Layer 7's evaluation cup pairings; Layer 8's Kummer isomorphism when the coefficient order is invertible in the field; Layer 9's all-degree package and Layer 10's `cd_p` vocabulary |
| [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3) | Layers 1 and 4: `H¹`, `H²` and the five-term sequence for generator and relation ranks; Layer 7's cup products; Layer 9's all-degree package; Layer 10's `cd_p` definitions, monotonicity for closed subgroups, and the prime-to-`p` open-subgroup equality |
| [Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4) | Layer 7's mod-2 cup products; Layer 8's Kummer isomorphism with `2` invertible; Layer 12's index-2 Evens norm and its four characterizing identities |
| [Global Class Field Theory PR #6](https://github.com/roed-math/TauCetiRoadmap/pull/6) | Layers 2 to 7: comparison, exactness, change of groups, Shapiro, and cup products, for its profinite and global duality material. Its finite class-formation core is independent of this roadmap |

Nothing here depends on an unmerged sibling roadmap. The dependency graph between roadmaps is
acyclic at roadmap granularity: Pro-p Groups consumes this roadmap, and this roadmap consumes
nothing from Pro-p Groups.

---

## 3. Standing hypotheses and pinned conventions

- **Groups.** `G` is a topological group: `[Group G] [TopologicalSpace G] [IsTopologicalGroup G]`.
  The explicit low-degree complex (Layer 1) and its exactness and cup-product identities (Layers
  4 and 7) are stated at that generality; profiniteness is not needed to define cochains.
  **Profinite** means the additional classes `[CompactSpace G] [TotallyDisconnectedSpace G]`,
  exactly the hypotheses of Mathlib's `exist_openNormalSubgroup_sub_open_nhds_of_one`.
  Profiniteness enters for the canonical comparison (Layer 2), the colimit theorem (Layer 3),
  continuous sections and the transgression (Layers 0, 4, 6), cohomological dimension (Layer 10)
  and the Galois interface (Layer 8). Do not take `ProfiniteGrp` (the category) as a hypothesis of
  a theorem: use the unbundled classes, as Mathlib's `ClopenNhdofOne.lean` does, and reserve
  `ProfiniteGrp` for categorical statements.
- **Discrete `G`-modules, in Mathlib's classes.** A topological `G`-module is `[AddCommGroup M]
  [TopologicalSpace M] [IsTopologicalAddGroup M] [DistribMulAction G M] [ContinuousSMul G M]`; a
  **discrete** module adds `[DiscreteTopology M]`. No bundling class is introduced: instance
  search composes these freely and each statement quantifies over exactly the classes it needs.
  For discrete `M`, continuity of the action is equivalent to openness of every point stabilizer
  (`continuousSMul_iff_stabilizer_isOpen`); state and use both forms. The categorical form is
  `TopRep k G` for canonical-facing statements, and the translation between the two is a Layer 0
  target modelled on the pin's discrete `Rep.ofDistribMulAction`.
- **Scalars.** The primary coefficient ring is `ℤ`: the explicit theory is stated for
  `DistribMulAction G M`, and the canonical statements are stated against `TopRep ℤ G`. A
  `TopRep k G` refinement for a ring `k` requires a genuine `Module k M` structure on the
  coefficients and a restriction-of-scalars compatibility theorem; state that refinement only
  where the `k`-action exists, and never add a `Module k` hypothesis to a statement about
  profinite groups that does not need it.
- **Left actions throughout**, written `g • m`. A right-module statement, if one ever arises, is
  phrased through `Gᵐᵒᵖ`.
- **Cochains are plain functions with continuity as a predicate.** `C¹(G,M)` is the subgroup of
  continuous elements of `G → M` and `C²(G,M)` of `G × G → M`, matching the shape of the pin's
  `groupCohomology.cocycles₁ : Submodule k (G → A)` rather than bundled `C(G, M)`. The canonical
  object uses bundled iterated `C(G, -)`, and Layer 2 crosses between the two descriptions once.
- **The differentials and cocycle identities are Mathlib's** (`GroupCohomology/LowDegree.lean`,
  Amelia Livingston's conventions), with continuity added:
  - `(d⁰ m) g = g • m - m`;
  - `(d¹ f) (g, h) = g • f h - f (g * h) + f g`;
  - `(d² f) (g, h, j) = g • f (h, j) - f (g * h, j) + f (g, h * j) - f (g, h)`;
  - 1-cocycle identity: `f (g * h) = g • f h + f g`, definitionally
    `groupCohomology.IsCocycle₁`;
  - 2-cocycle identity: `f (g * h, j) + f (g, h) = g • f (h, j) + f (g, h * j)`, definitionally
    `groupCohomology.IsCocycle₂`.

  Cochains are **not normalized**: `f 1 = 0` in degree 1 and the degree-2 normalizations are
  lemmas (`cocycles₁_map_one`, `cocycles₂_map_one_fst/snd`), never definitional conditions.
- **Cohomology presentation.** `H¹(G,M) = Z¹/B¹` and `H²(G,M) = Z²/B²` as quotients of additive
  subgroups of the function spaces, with `Z¹ = C¹ ⊓ ker d¹`, `B¹ = range d⁰` (automatically
  continuous), `Z² = C² ⊓ ker d²`, and `B² = d¹(C¹)`, the image of the **continuous** 1-cochains.
  `H⁰(G,M)` is the invariant subgroup `M^G` itself, not a quotient.
- **Functoriality is by compatible pairs**, in the direction of Mathlib's discrete
  `groupCohomology.cochainsMap` and master's `ContinuousCohomology.cochainsMap`: a continuous
  homomorphism `φ : H →ₜ* G` together with an `H`-equivariant continuous map from the restricted
  module (`f (φ h • m) = h • f m`) induces `Hⁱ(G, M) → Hⁱ(H, N)`. Restriction (`φ` the inclusion
  of a subgroup, any subgroup; openness is needed only for corestriction), inflation (`φ` a
  quotient map, coefficients the invariants) and coefficient maps (`φ = id`) are the three named
  instances, each with its composition laws.
- **Cup products.** A cup product is relative to a `G`-equivariant biadditive pairing
  `μ : M →+ N →+ P` with `μ (g • m) (g • n) = g • μ m n`, together with joint continuity
  `Continuous fun p : M × N => μ p.1 p.2`, which is automatic when `M` and `N` are discrete and so
  holds throughout the arithmetic applications. FLT's canonical cup carries the same hypothesis.
  The explicit theory covers the **six low-degree shapes**
  ```
  (p, q) ∈ {(0,0), (0,1), (1,0), (0,2), (1,1), (2,0)},   p + q ≤ 2,
  ```
  all instances of the general inhomogeneous formula
  `(a ⌣ b)(g₁, …, g_{p+q}) = μ (a (g₁, …, g_p)) ((g₁ ⋯ g_p) • b (g_{p+1}, …, g_{p+q}))`:
  - `(0,0)`: `m ⌣ n = μ m n`;
  - `(0,1)`: `(m ⌣ b) g = μ m (b g)`;
  - `(1,0)`: `(a ⌣ n) g = μ (a g) (g • n)`;
  - `(0,2)`: `(m ⌣ b) (g, h) = μ m (b (g, h))`;
  - `(1,1)`: `(a ⌣ b) (g, h) = μ (a g) (g • b h)`;
  - `(2,0)`: `(a ⌣ n) (g, h) = μ (a (g, h)) ((g * h) • n)`.

  No explicit cup lands above degree `2`; a product of total degree `3`, such as `(1,2)`, is part
  of the all-bidegree canonical package of Layer 11 and is not a target of the low-degree
  quotient model. Signs: the Leibniz rule is `d(a ⌣ b) = da ⌣ b + (-1)^p (a ⌣ db)` for `a` of
  degree `p`, matching FLT's `cup_d_comm`, and graded commutativity is
  `a ⌣_μ b = (-1)^{pq} (b ⌣_{μᵒᵖ} a)` **as an identity of cohomology classes**, where `μᵒᵖ n m =
  μ m n`. In the `𝔽₂`-valued arithmetic applications every sign is `1` and the cup is symmetric on
  classes.
- **Corestriction.** Fix an open subgroup `U ≤ G` (of finite index automatically when `G` is
  compact; include `[U.FiniteIndex]` otherwise). A **transversal** is a map `t : G ⧸ U → G` with
  `(t u : G ⧸ U) = u` for every `u`, and its **transversal word** is
  ```
  ℓᵗ_u(γ) = (t u)⁻¹ * γ * t (γ⁻¹ • u) ∈ U.
  ```
  Corestriction is defined for a variable transversal first:
  - degree 0: `cor⁰_t m = ∑ u : G ⧸ U, t u • m`, the norm;
  - degree 1: `(cor¹_t f) γ = ∑ u : G ⧸ U, t u • f (ℓᵗ_u γ)`;
  - degree 2: `(cor²_t f) (γ, η) = ∑ u : G ⧸ U, t u • f (ℓᵗ_u γ, ℓᵗ_{γ⁻¹ • u} η)`.

  The factor `t u •` is forced, not decoration. The identity `t u * ℓᵗ_u(γ) = γ * t (γ⁻¹ • u)` is
  what turns the `U`-cocycle law for `f` into the `G`-cocycle law for `cor f`, and without the
  action factor the sums are not cocycles. The factor is invisible only when `G` acts trivially on
  the coefficients, which is why the `ZMod 2` formulas in `roed-math/gq2-lean` omit it; Layer 5
  generalizes those formulas rather than transcribing them.

  The public `cor` is the specialization `t = Quotient.out`. Independence of the transversal is a
  **theorem**, proved by exhibiting the difference of the two cochains as a coboundary, and it can
  only be stated once `t` is a variable, which is why the variable-transversal definitions come
  first.
- **The corestriction normalization.** `cor ∘ res = (G : U) • id` **on cohomology** in degrees
  `0, 1, 2`. In degree `0` the identity already holds on invariants. In degree `1` it does not
  hold on cochains: for a continuous 1-cocycle `f` on `G`,
  ```
  cor¹_t (res f) = (G : U) • f + d⁰ c,     where   c = ∑_{u : G ⧸ U} f (t u) ∈ M,
  ```
  and the analogous degree-2 statement holds with an explicit continuous 1-cochain in place of the
  element `c`. Both correction terms are named lemmas of Layer 5. Never state
  `cor ∘ res = index` as a cochain identity.
- **The finite-quotient system.** Mathlib's `OpenNormalSubgroup G` is ordered by inclusion, and
  `ProfiniteGrp.toFiniteQuotientFunctor` sends `V ≤ U` to the quotient map `G ⧸ V → G ⧸ U`. The
  cohomological system goes the other way: for `V ≤ U` the transition map is
  ```
  Hⁱ(G ⧸ U, M^U) ⟶ Hⁱ(G ⧸ V, M^V).
  ```
  So the index category is `(OpenNormalSubgroup G)ᵒᵖ`, and the transition map is the compatible
  pair consisting of the quotient homomorphism `G ⧸ V → G ⧸ U` and the coefficient inclusion
  `M^U ↪ M^V`, which is equivariant after restriction along that quotient homomorphism. Both
  halves are named separately, in `Suggested.lean` as `finiteQuotientMap` and
  `invariantsInclusion` with its equivariance lemma; the pair they assemble to and the map it
  induces on cohomology are `transitionPair` and `finiteLevelTransition`. The comparison map to
  `Hⁱ(G, M)` is inflation along `G → G ⧸ U` followed by the coefficient inclusion `M^U ↪ M`. The
  colimit is taken in `AddCommGrp` for the explicit low-degree statement and in `TopModuleCat ℤ`
  for the canonical all-degree statement of Layer 9.
- **Shapiro's direction.** Coinduction is the right adjoint, and Shapiro's lemma reads
  `Hⁿ(G, Coind_H^G A) ≅ Hⁿ(H, A)`, the direction of the pin's discrete `groupCohomology.coindIso`.
  For profinite `G` and closed `H ≤ G`, `Coind_H^G A` is the discrete module of continuous
  (equivalently locally constant) `H`-equivariant maps `G → A`. For **open** `H` the natural map
  `Ind_H^G A → Coind_H^G A` is an isomorphism, with the pin's discrete `Rep.indCoindIso` as the
  model, and both transports are stated.
- **Transversals and sections are different objects.** An **open** subgroup has finite index, and
  `Quotient.out` is an adequate (set-theoretic, automatically continuous on a discrete quotient)
  transversal for it. A **closed** subgroup of infinite index has no such thing, and every
  construction that lifts through `G → G ⧸ H` for closed `H` uses a genuine continuous section,
  supplied by Layer 0 and cited by name. Do not use `Quotient.out` in the closed-subgroup
  statements.
- **Multiplicative coefficients** (units of a field, roots of unity) enter through `Additive`, by
  the pin's own idiom (`groupCohomology.IsMulCocycle₁`, `Rep.ofMulDistribMulAction`). No parallel
  multiplicative cohomology is developed.
- **The Galois coefficient model.** `Kˢ = SeparableClosure K` is the coefficient field of the
  Galois layer, not the algebraic closure. Mathlib defines `Field.absoluteGaloisGroup K` as
  `AlgebraicClosure K ≃ₐ[K] AlgebraicClosure K`; for an imperfect `K` the fixed field of that
  group is the purely inseparable closure of `K`, not `K`, so the invariants of
  `(AlgebraicClosure K)ˣ` are not `Kˣ` and the Kummer sequence has the wrong left-hand term. An
  algebraic closure is **not** a separable closure in general. Layer 8 either takes
  `G_K = Kˢ ≃ₐ[K] Kˢ` outright or keeps `Field.absoluteGaloisGroup K` and proves it is
  topologically isomorphic to `Kˢ ≃ₐ[K] Kˢ`, compatibly with the action on `Kˢ`; either way every
  coefficient module is a `G_K`-submodule of `(Kˢ)ˣ`.
- **The Evens norm** is developed for `𝔽₂ = ZMod 2` coefficients with trivial action, the
  generality Evens' multiplicative transfer admits with no parity constraint and the one the
  Evens-Kahn formula consumes, for an open subgroup of arbitrary finite index in the general
  construction, with the index-2 degree-`1 → 2` case additionally given by the explicit two-point
  graph cocycle. Layer 12 fixes both and identifies them.

---

## 4. What Mathlib already has (consume)

All paths at the pin `9caeba1000` (2026-06-03).

- **Discrete group cohomology, the model API:**
  `Mathlib/RepresentationTheory/Homological/GroupCohomology/Basic.lean` (`groupCohomology`,
  `inhomogeneousCochains`); `LowDegree.lean` (`d₀₁`, `d₁₂`, `d₂₃`, `cocycles₁/₂`,
  `mem_cocycles₁_iff`, `mem_cocycles₂_iff`, `IsCocycle₁/₂`, `IsCoboundary₁/₂`, the
  `DistribMulAction` and multiplicative translations `cocyclesOfIsCocycle₁`,
  `isMulCocycle₁_of_mem…`, `H0Iso`, `H1π`, `H2π`, `H1IsoOfIsTrivial`); `Functoriality.lean`
  (`cochainsMap` for a pair `(f : G →* H, φ : res f A ⟶ B)`, `map`, `mapCocycles₁/₂`, `H1InfRes`
  with `H1InfRes_exact`, `resNatTrans`, `infNatTrans`, `functor`); `LongExactSequence.lean`
  (`groupCohomology.δ`, `mapShortComplex₁/₂/₃_exact`, `δ₀_apply`, `δ₁_apply`); `Shapiro.lean`
  (`coindIso : Hⁿ(G, Coind_S^G A) ≅ Hⁿ(S, A)`); `Hilbert90.lean` (`H1ofAutOnUnitsUnique`,
  `hilbert90`); `FiniteCyclic.lean` (`groupCohomologyIsoEven/Odd`); `Resolution.lean` (the bar
  resolution).
- **Coinduction and finite index, discrete:** `Mathlib/RepresentationTheory/Coinduced.lean`
  (`Representation.coind` along any `φ`), `Induced.lean`, `FiniteIndex.lean`
  (`Rep.indCoindIso : Ind_S^G A ≅ Coind_S^G A` for `[S.FiniteIndex]`).
- **Continuous representations:** `Mathlib/RepresentationTheory/Continuous/Basic.lean`
  (`ContRepresentation R G V = G →* V →L[R] V`, `ContIntertwiningMap`,
  `ContRepresentation.coind₁`), the pin-side seed of master's `TopRep`.
- **Profinite groups:** `Mathlib/Topology/Algebra/OpenSubgroup.lean` (`OpenSubgroup`,
  `OpenNormalSubgroup`, their lattice structure); `Mathlib/Topology/Algebra/ClopenNhdofOne.lean`
  (`exist_openNormalSubgroup_sub_open_nhds_of_one` under
  `[CompactSpace G] [TotallyDisconnectedSpace G]`, and
  `ProfiniteGrp.closedSubgroup_eq_sInf_open`);
  `Mathlib/Topology/Algebra/Category/ProfiniteGrp/{Basic,Limits,Completion}.lean` (`ProfiniteGrp`,
  `toFiniteQuotientFunctor : OpenNormalSubgroup P ⥤ FiniteGrp`,
  `continuousMulEquivLimittoFiniteQuotientFunctor`);
  `Mathlib/Topology/Algebra/ContinuousMonoidHom.lean` (`ContinuousMonoidHom`,
  `ContinuousAddMonoidHom`).
- **Compact-open function spaces:** `Mathlib/Topology/CompactOpen.lean`
  (`ContinuousMap.curry : C(X × Y, Z) → C(X, C(Y, Z))`, which needs no hypothesis;
  `ContinuousMap.uncurry`, which needs `[LocallyCompactSpace Y]`; and `Homeomorph.curry`, the
  equivalence, which needs local compactness of both factors). Layer 2 rests on exactly these.
- **Discrete actions:** `Mathlib/Topology/Algebra/MulAction.lean` (`stabilizer_isOpen`,
  `continuousSMul_iff_stabilizer_isOpen`).
- **Galois theory:** `Mathlib/FieldTheory/KrullTopology.lean` (the Krull topology,
  `krullTopology_t2`, total separatedness); `Mathlib/FieldTheory/Galois/Profinite.lean`
  (`CompactSpace Gal(K/k)` for `[IsGalois k K]`, `InfiniteGalois.profiniteGalGrp`, the limit
  presentation over `FiniteGaloisIntermediateField`); `Mathlib/FieldTheory/Galois/Infinite.lean`
  (the fundamental theorem of infinite Galois theory:
  `InfiniteGalois.IntermediateFieldEquivClosedSubgroup`,
  `InfiniteGalois.normalAutEquivQuotient : Gal(K/k) ⧸ H ≃* Gal(fixedField H / k)`,
  `InfiniteGalois.isOpen_iff_finite`, `InfiniteGalois.normal_iff_isGalois`,
  `InfiniteGalois.isOpen_and_normal_iff_finite_and_isGalois`);
  `Mathlib/FieldTheory/SeparableClosure.lean` (`separableClosure`, `SeparableClosure F`,
  `separableClosure.isGalois`, `SeparableClosure.isSepClosed`);
  `Mathlib/FieldTheory/PurelyInseparable/Basic.lean`
  (`separableClosure.isPurelyInseparable : IsPurelyInseparable (separableClosure F E) E` for
  algebraic `E/F`, and `instSubsingletonAlgHomOfIsPurelyInseparable`, which together make
  restriction from the algebraic closure to the separable closure injective);
  `Mathlib/FieldTheory/AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup` and its topological
  abelianization); `Mathlib/FieldTheory/KummerExtension.lean` (the polynomial and extension-level
  Kummer theory: `autEquivRootsOfUnity`, `autEquivZmod`).
- **Order and torsion vocabulary for Layer 10:** `ℕ∞` (`ENat`, which is `WithTop ℕ`) as a
  `CompleteLinearOrder`;
  `CommMonoid.primaryComponent` and `AddCommMonoid.primaryComponent`
  (`Mathlib/GroupTheory/Torsion.lean`); `IsSimpleModule`; `CategoryTheory.Simple`.

---

## 5. The build, in layers

The numbering is the dependency order. As each layer makes the next layer's types expressible,
record its milestones in `Suggested.lean` with `sorry`; the pin-expressible targets are there
already. Milestones marked **(needs E0)** are stated mathematically now and implemented after the
toolchain bump; they are mandatory, not secondary.

### Layer 0: discrete modules and continuous sections

The coefficient theory and the two topological inputs the later layers lift through, stated in the
unbundled classes of §3.

- **Openness.** Point stabilizers of a discrete module are open; for finite `M` the kernel of the
  action is open; over a profinite `G`, a finite discrete module has an open **normal** subgroup
  acting trivially, so its action factors through a finite quotient. (Consume
  `continuousSMul_iff_stabilizer_isOpen` and `exist_openNormalSubgroup_sub_open_nhds_of_one`.) For
  an arbitrary discrete `M` over a profinite `G`, every element is fixed by an open normal
  subgroup, so `M = ⋃_U M^U`. Layer 3 uses that union.
- **Constructions.** Invariants `M^U` as a `G ⧸ U`-module for normal `U`, with the induced discrete
  action: this is the coefficient system of the finite-level tower. **Finite** products of
  discrete modules, and subgroups and quotients with their induced and quotient topologies, are
  again discrete `G`-modules. An infinite product of discrete spaces carries the product topology
  and is **not** discrete, so it is absent from that list, and so is the infinite direct sum, whose
  topology and continuity of action would have to be supplied and proved separately. Nothing in
  Layers 1 to 12 needs either. For **finite** `M` and discrete `N`, the internal hom `M →+ N` with
  the conjugation action `(g • φ) m = g • φ (g⁻¹ • m)` is again a discrete `G`-module, and
  evaluation `(M →+ N) →+ M →+ N` is a `G`-equivariant pairing. Layer 7's duality package and
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) consume that pairing,
  and only finite products of it. The precise
  consumer contract is Local Fields' prime-to-residue-characteristic and mixed-characteristic
  duality layers; no equal-characteristic residue-primary duality theorem is assumed here.
- **Continuous sections of profinite quotients.** For a profinite `G` and closed subgroups
  `K ≤ H ≤ G`, the projection `G ⧸ K → G ⧸ H` admits a continuous section, with the normalized
  specialization: `G ⧸ H → G` continuous with `s 1 = 1` (Ribes-Zalesskii Prop. 2.2.2). Prove the
  companion extension lemma in the form the proofs use: a continuous map from a closed subspace of
  a profinite space to a finite discrete target extends continuously. This is stated once and
  consumed in exactly three places: Layer 4's transgression, Layer 6's exactness of coinduction,
  and Layer 6's explicit inverse in Shapiro's lemma. It is not needed anywhere an **open**
  subgroup is in play, where `Quotient.out` already suffices.
- **The categorical dictionary.** The translation between the unbundled classes and `TopRep ℤ G`
  (and, at the pin, `Action (TopModuleCat R) G`), in the style of the discrete
  `Rep.ofDistribMulAction`. This is where the statements of Layers 1 to 8 meet the canonical API.
  ⚠ Keep every *theorem* of Layers 1 to 8 stated against the unbundled classes wherever possible.
  The bundled forms are interfaces, and mismatches between instances and structures here are the
  main source of unusable statements. **(the `TopRep ℤ G` half needs E0)**

### Layer 1: the explicit low-degree complex and its functoriality

- **The complex.** `C¹, C², Z¹, Z², B¹, B²`, `H⁰, H¹, H²` as fixed in §3, with `d ∘ d = 0`, the
  membership lemmas in the exact `IsCocycle₁/₂` shapes, the evaluation lemmas (`Z¹` vanishes at
  `1`, the inverse formula, the degree-2 normalizations), and the trivial-action
  characterizations: `B¹ = ⊥`, `H¹` additively isomorphic to the continuous homomorphisms
  `G →ₜ* M`, and `H⁰ = M`.
- **Compatible-pair functoriality.** The pullback `Hⁱ(G, M) → Hⁱ(H, N)` of §3, on cochains,
  cocycles and cohomology, with the identity and composition laws. This is the continuous twin of
  the pin's `groupCohomology.cochainsMap` package, aligned with master's
  `ContinuousCohomology.cochainsMap`.
- **The three instances.** Restriction `res : Hⁱ(G, M) → Hⁱ(H, M)` for any subgroup with the
  subspace topology; inflation `inf : Hⁱ(G ⧸ N, M^N) → Hⁱ(G, M)` for closed normal `N`; and
  coefficient maps along `G`-equivariant continuous homomorphisms. Composition laws mixing the
  three: `res ∘ inf`, and coefficient naturality of both.
- **Conjugation.** The compatible pair (conjugation by `g`, action of `g`) induces an action of
  `G` on `Hⁱ(N, M)` for closed normal `N`, and **inner automorphisms act trivially on `Hⁱ(G, M)`**,
  by an explicit chain homotopy in degrees `≤ 2`. Without it the `G ⧸ N`-action on `Hⁱ(N, M)` is
  not well defined, and Layer 4's five-term sequence needs that action.
  ⚠ The degree-2 homotopy has many terms and is easy to get wrong. Write it once for the
  compatible-pair form and derive the degree-1 case, rather than proving the two separately.

### Layer 2: the comparison isomorphisms

Without this layer the explicit complex would be a second theory rather than a second description
of the canonical one, so it is what keeps the roadmap from forking the canonical API. It also
answers the condition the community set: when the canonical design was settled on Zulip in
February 2025, Joël Riou asked for a comparison map to Amelia Livingston's inhomogeneous complex
that is a quasi-isomorphism in the discrete case.

- **Continuous against discrete.** For `G` with the discrete topology (finite `G` being the case
  Layer 3 uses) and any discrete `G`-module `M`: `Hⁱ_explicit(G, M) ≅ groupCohomology` in degrees
  `0, 1, 2`, through the pin's `cocycles₁/₂` and `IsCocycle₁/₂`. Every continuity condition is
  vacuous, so this identifies subquotients of the same function spaces. Layer 3 uses it at every
  finite level.
  ⚠ Mathlib's `groupCohomology` is `k`-linear over `Rep k G` while the explicit theory is
  `ℤ`-linear. Compare against `Rep ℤ G` through `Rep.ofDistribMulAction`, and state the `k`-linear
  refinement only where a `k`-action genuinely exists.
- **Inhomogeneous against canonical, for profinite `G`, degrees `0, 1, 2`.** The canonical model
  uses invariant elements of iterated compact-open function spaces `C(G, C(G, …, M))`, not
  functions on `Gⁿ`. Mathlib's `ContinuousMap.curry : C(G × G, M) → C(G, C(G, M))` is defined with
  no hypothesis, but its inverse `ContinuousMap.uncurry` needs `[LocallyCompactSpace G]`, and the
  equivalence `Homeomorph.curry` needs local compactness of both factors. So the passage from the
  canonical description back to functions on `G × G` is exactly a local-compactness statement.
  Mathlib's own module documentation for `ContCohomology` says the same thing: it names "the usual
  description of cochains in terms of `n`-ary functions for locally compact groups" as a TODO, and
  gives avoiding that hypothesis as the reason the homogeneous model was chosen.

  Accordingly this milestone is stated for **profinite `G`**, which is compact Hausdorff and hence
  locally compact, with discrete coefficients. State the compact-open equivalence as an explicit
  prerequisite of the degree-2 comparison. A locally compact Hausdorff generalization may be added
  only when the exact Mathlib theorem and all its hypotheses are named in the statement.

  The chain-level correspondence is the classical one: in degree 1,
  `f (g₀, g₁) = g₀ • c (g₀⁻¹ * g₁)` with inverse `c g = f (1, g)`; in degree 2,
  `f (g₀, g₁, g₂) = g₀ • c (g₀⁻¹ * g₁, g₁⁻¹ * g₂)`. Prove it is a chain map in both directions and
  conclude `Hⁱ_explicit ≅ continuousCohomology i` for `i ≤ 2`, naturally in compatible pairs.
  FLT's `cohomologyIsoQuot` supplies the quotient presentation on the canonical side.
  **(needs E0)**
- **The category of the comparison.** For compact `G` and discrete `M`, prove that `C(G, M)` is
  discrete in the compact-open topology, hence that every term of the homogeneous cochain complex
  and every subquotient of it is discrete. With that in hand, state the comparison as an
  isomorphism in `TopModuleCat ℤ` between discrete objects, rather than as an additive isomorphism
  after forgetting the topology. Whichever of the two a given statement makes, it must say which:
  an `explicit ≅ continuousCohomology` with the category left unsaid is not a usable statement.
  **(needs E0)**
- **Transport.** Under these isomorphisms: restriction to restriction, inflation to inflation,
  coefficient maps to `map`, corestriction to Layer 9's canonical corestriction, and the explicit
  cups of Layer 7 to FLT's `cup`. Each operation gets exactly one transport lemma, carrying the
  same profiniteness hypotheses as the comparison itself. State each one as soon as both of its
  sides exist.
  **(needs E0)**

### Layer 3: the finite-quotient colimit description

For profinite `G` and discrete `M`; the theorem most computations use (NSW (1.2.5),
Ribes-Zalesskii Cor. 6.5.6(a), Koch Thm. 3.16; Serre, *Local Fields* X §3 takes it as the
*definition*, so the three textbooks present the three descriptions Layers 1 to 3 relate).

- **The system.** The functor `U ↦ Hⁱ(G ⧸ U, M^U)` on `(OpenNormalSubgroup G)ᵒᵖ`, with the
  transition maps and comparison maps as fixed in §3. Six separate milestones, not one:
  1. the quotient homomorphism `G ⧸ V → G ⧸ U` for `V ≤ U`;
  2. the coefficient inclusion `M^U ↪ M^V`, on the `G ⧸ U`-module `M^U` supplied by Layer 0;
  3. its equivariance after restriction along the quotient homomorphism, without which the two
     are not a compatible pair;
  4. the induced transition map `Hⁱ(G ⧸ U, M^U) → Hⁱ(G ⧸ V, M^V)`;
  5. the identity law at `V = U`; and
  6. the composition law for `W ≤ V ≤ U`, identifying the `U`-to-`W` map with the composite
     through the `V`-level.

  The word "functor" in the first sentence means items 5 and 6, so state them as theorems rather
  than leaving them inside the phrase "transition maps". Also state functoriality of the whole
  system in `M`. The construction must typecheck against
  `ProfiniteGrp.toFiniteQuotientFunctor`, whose arrows go the other way, which is the reason for
  the opposite category.
- **The colimit theorem.** `Hⁱ(G, M) ≅ colim_U Hⁱ(G ⧸ U, M^U)` in `AddCommGrp`, for `i = 0, 1, 2`
  on the explicit model. Surjectivity is a strict statement: a continuous 1-cocycle is *itself*
  inflated from a finite level, with no coboundary subtracted, because its zero set is an open
  subgroup and any open normal subgroup inside it makes the cocycle both right-invariant and
  invariant-valued. In degree 2, uniform local constancy on the compact space `G × G` descends
  both variables at once, and an open normal subgroup fixing the finite image makes the values
  invariant, again strictly. A coboundary enters only in the injectivity half, where a
  finite-level class that becomes zero in `G` is already zero at some deeper finite level.
  ⚠ Degree 2 is where `CompactSpace` is genuinely used, not just total disconnectedness.
- **Coefficient colimits.** `Hⁱ(G, -)` commutes with filtered colimits of discrete modules for
  `i ≤ 2` on the explicit model: a continuous cochain into a filtered colimit takes its values in
  a single stage, by compactness again. With Layer 0: the cohomology of any discrete module is the
  filtered colimit
  over its finitely generated `ℤ[G ⧸ U]`-submodules.
- **First consequences.** `H⁰(G, M) = M^G`; for finite `M` the tower stabilizes levelwise
  (`M^U = M` for small `U`); and `Hⁱ(G, M)` for `i ≥ 1` is a colimit of cohomology of finite
  groups, which Layer 9's torsion corollary uses.
- **All degrees.** The same theorem against the canonical object, in every degree, is a Layer 9
  milestone and is stated there.

### Layer 4: exact sequences

- **Exactness of cochains.** For a short exact sequence `0 → A → B → C → 0` of discrete
  `G`-modules and any topological group `G`, the cochain sequences
  `0 → Cⁿ(G, A) → Cⁿ(G, B) → Cⁿ(G, C) → 0` are exact: a continuous cochain into discrete `C` is
  locally constant, so composing with **any** set-theoretic section of `B → C` preserves
  continuity.
  ⚠ This is the one place where discreteness of the coefficients cannot be relaxed. For general
  topological modules there is no such section and no long exact sequence; do not state this layer
  beyond discrete coefficients.
- **The long exact sequence** through degree 2 (NSW (1.3.2)): explicit connecting maps
  `δ⁰ : H⁰(G, C) → H¹(G, A)` (choose a preimage, apply `d⁰`) and `δ¹ : H¹(G, C) → H²(G, A)`, their
  well-definedness, exactness at the eight nodes from `H⁰(G, A)` to `H²(G, B)`, and naturality both
  in morphisms of short exact sequences and in compatible pairs, so that restriction and inflation
  commute with `δ`. Mirror the pin's `δ₀_apply`/`δ₁_apply` interface so that the discrete and
  continuous theories are used identically. The all-degree sequence is a Layer 9 milestone, and it
  is on Mathlib's own TODO list for `ContCohomology`, so coordinate rather than duplicate.
- **Inflation-restriction.** The exact sequence `0 → H¹(G ⧸ N, M^N) → H¹(G, M) → H¹(N, M)` for
  closed normal `N`, by a direct cochain argument, with the pin's discrete `H1InfRes_exact` as the
  model. Valid for an arbitrary topological group with discrete coefficients.
- **The five-term sequence, for profinite `G` and closed normal `N`** (NSW (1.6.7),
  Ribes-Zalesskii Cor. 7.2.5(a); Koch Thm. 3.14 gives the degree-`n` form under vanishing below
  `n`, which Layer 10's dévissage uses). The pieces are: `G ⧸ N`-invariance of the image of
  restriction, using Layer 1's conjugation action; the transgression
  `tg : H¹(N, M)^{G ⧸ N} → H²(G ⧸ N, M^N)`, defined by lifting a cocycle on `N` through a
  **continuous section** of `G → G ⧸ N` supplied by Layer 0 and differentiating; independence of
  the chosen section, as an identity of classes; and exactness of
  ```
  0 → H¹(G⧸N, M^N) → H¹(G, M) → H¹(N, M)^{G⧸N} → H²(G⧸N, M^N) → H²(G, M).
  ```
  ⚠ Profiniteness is a genuine hypothesis here, not a convenience: extending a continuous cocycle
  off a closed subgroup, or building one from a section, is exactly what Layer 0's section theorem
  provides and what fails for an arbitrary topological group. The three-term inflation-restriction
  sequence above keeps its wider generality; the five-term sequence does not.
  ⚠ Define `tg` by the explicit lift-and-differentiate formula and prove its two compatibilities,
  with inflation on the right and restriction on the left. Spectral sequences are out of scope
  (§1).

  The presentation theory of
  [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3) is built from this
  sequence; its `𝔽₂` instance, with `N` a Frattini-type kernel, is the case that roadmap consumes.

### Layer 5: change of groups

For open `U ≤ G`, with `[U.FiniteIndex]` carried explicitly where `G` is not compact; everything
through the transversal formulas of §3.

- **The transversal calculus.** For a variable transversal `t`, the word `ℓᵗ_u(γ)` lies in `U` and
  satisfies the 1-cocycle law `ℓᵗ_u(γ) * ℓᵗ_{γ⁻¹ • u}(η) = ℓᵗ_u(γη)`. This is pure group theory,
  stated for an arbitrary subgroup, and `Suggested.lean` fixes both statements. Continuity of
  `γ ↦ ℓᵗ_u(γ)` for open `U`. The identity `t u * ℓᵗ_u(γ) = γ * t (γ⁻¹ • u)`, which the cocycle
  computations use.
- **Corestriction in degrees `0, 1, 2`.** The three formulas of §3, for a variable transversal:
  each takes its values in continuous cochains, sends cocycles to cocycles and coboundaries to
  coboundaries, and is additive. The proof that `cor¹` preserves cocycles visibly uses the factor
  `t u •`; a
  version of the argument that does not is wrong. Then: change of transversal, as an explicit
  coboundary identity between the two cochains, and the resulting independence on cohomology. Only
  after all of that, define the public `cor` as the `t = Quotient.out` specialization.
  ⚠ Prove independence as a change-of-transversal coboundary identity, not by re-deriving the map
  abstractly. Downstream computations use the formula, so the formula is the definition.
- **The identities.** `cor ∘ res = (G : U) • id` on `H⁰, H¹, H²` (NSW (1.5.7); Serre, *Local
  Fields* VII §7 Prop. 6; Koch Thm. 3.10), with the two explicit cochain-level correction terms of
  §3 as named lemmas; naturality in coefficient maps; compatibility with connecting maps
  (`cor ∘ δ = δ ∘ cor`, NSW (1.5.2)); and transitivity `cor_V^G = cor_U^G ∘ cor_V^U` for open
  `V ≤ U ≤ G`.
- **The Mackey double-coset formula** (NSW (1.5.6)). For open `U, V ≤ G`,
  ```
  res^G_V ∘ cor^G_U = ∑_{VgU ∈ V \ G / U} cor^V_{V ∩ gUg⁻¹} ∘ (g)_* ∘ res^U_{U ∩ g⁻¹Vg},
  ```
  with `(g)_*` the conjugation isomorphism of Layer 1. State the exact double-coset indexing and
  the intersection subgroups; prove it first in degrees `0, 1, 2` on the explicit model, and prove
  independence of the double-coset representatives. Add the finite-group specialization as an
  acceptance check, and check it is compatible with the finite-level normalization of
  `kbuzzard/ClassFieldTheory`. Mackey is part of the basic change-of-groups API and is built here
  whether or not a current consumer asks for it.
- **Conjugation, again.** Layer 1 constructs the conjugation maps; this layer states their
  interaction with restriction and corestriction, which the Mackey formula needs.
- **Conventions.** Match `kbuzzard/ClassFieldTheory`'s discrete `cores_res` normalization
  (`index • id`, same direction) so the finite-level specializations are interchangeable; if their
  corestriction reaches Mathlib first, Layer 2's comparison must transport ours onto theirs.
  ⚠ Naming collision: at the pin, Mathlib's `GroupHomology/Functoriality.lean` already uses
  "corestriction" for the covariant functoriality of *homology* along a group homomorphism. Ours
  is the classical cohomological transfer (NSW I §5). Keep the name `cores`/`corestriction`, which
  is NSW's and ClassFieldTheory's usage, say in the docstring which of the two is meant, and never
  abbreviate it to "transfer", since Layer 12's norm is the *multiplicative* transfer.

### Layer 6: coinduced modules and Shapiro's lemma

For profinite `G` and a **closed** subgroup `H ≤ G`, on discrete `H`-modules `A`. The generality is
decided up front: closed, not merely open, since the trivial subgroup is the acyclicity case.

- **The coinduced module.** `Coind_H^G A` is the locally constant `H`-equivariant maps `G → A`
  (`f (h * g) = h • f g`) with the right-translation action `(g • f) x = f (x * g)`; this is
  Milne's `M_*` (ADT Remark 0.11) and Ribes-Zalesskii's `Coind_H^G` (Thm. 6.10.5). Prove it is
  again **discrete** (a locally constant map on a profinite group is uniformly locally constant,
  so stabilizers are open), functorial in `A`, and exact in `A`. Exactness uses Layer 0's
  continuous section of `G → G ⧸ H`, cited by name. Adjunction with restriction:
  `Hom_G(M, Coind_H^G A) ≃ Hom_H(res M, A)`, the continuous Frobenius reciprocity, in the
  direction of the pin's discrete adjunction.
  ⚠ Terminology trap: NSW writes `Ind_G^H` for this **coinduced** functor and flags the abuse only
  in a footnote (2nd ed., p. 61). When citing NSW (1.6.4) next to a Lean `coind`, cite the
  footnote too, and reserve `ind` for the genuine left adjoint.
- **Shapiro's lemma.** `Hⁱ(G, Coind_H^G A) ≅ Hⁱ(H, A)` for `i = 0, 1, 2` on the explicit model
  (NSW (1.6.4), Ribes-Zalesskii Thm. 6.10.5, Koch Thm. 3.9), natural in `A` and compatible with
  restriction and, for open intermediate subgroups, corestriction. The forward map is evaluation
  at `1`; the inverse is built from Layer 0's continuous section for closed `H`, and from a finite
  transversal when `H` is open. The pin's `coindIso` fixes the direction. The all-degree statement
  is a Layer 9 milestone.
- **Open subgroups and the algebraic comparison.** For **open** `H`, prove `Ind_H^G A ≅
  Coind_H^G A` using a finite transversal, with the pin's discrete `Rep.indCoindIso` as the model,
  and derive the induced-module form of Shapiro. Then state the theorem that joins this roadmap to
  the representation theory family: for open `H`, the topological coinduction of a discrete module
  agrees with the algebraic coinduction of
  [`RepresentationTheory/InductionRestriction`](../RepresentationTheory/InductionRestriction/README.md),
  compatibly with both Shapiro isomorphisms. For closed `H` of infinite index only the coinduced
  form is asserted.
- **Acyclicity and dimension shifting.** `Coind_1^G A`, the locally constant maps `G → A`, has
  vanishing `Hⁱ` for `i = 1, 2` (Shapiro at `H = 1`); every discrete `M` embeds in a discrete
  acyclic module `M ↪ Coind_1^G M`; hence dimension shifting `Hⁱ⁺¹(G, M) ≅ Hⁱ(G, Coind_1^G M ⧸ M)`
  in the range where both sides are defined. The statement in all positive degrees, which Layer 10
  runs its induction on, is a Layer 9 milestone.

### Layer 7: cup products in low degrees

On the explicit model, relative to an equivariant pairing as fixed in §3. Discreteness of `M` and
`N` makes every cochain-level continuity automatic.

- **The six low-degree shapes.** `⌣ : H^p(G, M) × H^q(G, N) → H^{p+q}(G, P)` for the six pairs
  `(p, q)` of §3 with `p + q ≤ 2`, each with: the cochain formula, cocycle cup cocycle is a cocycle,
  descent through coboundaries, and biadditivity by construction. The family is closed: every
  operation used in an associativity or commutativity statement below is one of these six.
- **Associativity.** Typing both sides needs four `G`-equivariant biadditive pairings and one
  coefficient identity. Given `μ₁ : A →+ B →+ D`, `μ₂ : D →+ C →+ E`, `ν₁ : B →+ C →+ F` and
  `ν₂ : A →+ F →+ E` with `μ₂ (μ₁ a b) c = ν₂ a (ν₁ b c)` for all `a, b, c`, and classes of degrees
  `p, q, r` with `p + q + r ≤ 2`:
  ```
  (x ⌣_{μ₁} y) ⌣_{μ₂} z = x ⌣_{ν₂} (y ⌣_{ν₁} z)
  ```
  already at the cochain level (Brown V (3.5)). The instances in range are `(0,0,0)`, `(0,0,1)`,
  `(0,1,0)`, `(1,0,0)`, `(0,0,2)`, `(0,1,1)`, `(1,1,0)`, `(1,0,1)`, `(0,2,0)` and `(2,0,0)`.
  The instance `(1,1,0)` needs the `(1,0)` cup on the right-hand side, which is why `(1,0)` and
  `(0,0)` belong to the family. State also the specialization all applications use: a discrete
  `G`-ring `R`, with all four pairings its multiplication.
- **Graded commutativity.** `a ⌣_μ b = (-1)^{pq} (b ⌣_{μᵒᵖ} a)` **in cohomology** (NSW (1.4.4),
  Brown V (3.6)). For `(0,q)` against `(q,0)` the two cochains are literally equal, because the
  degree-0 class is invariant, so state that case at cochain level. For `(1,1)` they are not: give
  the explicit 1-cochain whose `d¹` is the difference, name it in the file docstring, and derive
  the statement on classes from it. State the characteristic-2 symmetric specialization separately,
  since that is the case the arithmetic applications use.
  ⚠ Signs are the usual source of error here, between the `(1,1)` homotopy and the
  connecting-map formulas below. Fix the homotopy formula in the file docstring and refer to it.
- **Compatibilities.** Four theorems, in the degrees where both sides are defined:
  1. restriction: `res (a ⌣ b) = res a ⌣ res b` (NSW (1.5.3)(i));
  2. inflation: `inf (a ⌣ b) = inf a ⌣ inf b`, over the quotient's pairing (NSW (1.5.3)(iii),
     Milne (0.1.6));
  3. coefficient maps, that is naturality in `μ` (NSW (1.4.2));
  4. the **projection formula** `cor (res a ⌣ b) = a ⌣ cor b` for open `U`, by the transversal
     argument (NSW (1.5.3)(iv), Ribes-Zalesskii 7.9.6 and 7.9.7, Brown V (3.8)).
- **Connecting maps, as typed diagrams.** The generic Leibniz identity for `δ` is not a statement
  until the coefficient sequences are named, so state two separate theorems.
  1. *First variable.* For a short exact sequence `0 → A' → A → A'' → 0` of discrete modules, a
     module `B`, and pairings `A × B → C`, `A' × B → C'`, `A'' × B → C''` compatible with a short
     exact sequence `0 → C' → C → C'' → 0`: for `a'' ∈ H^p(G, A'')` and `b ∈ H^q(G, B)`,
     ```
     δ (a'' ⌣ b) = δ(a'') ⌣ b   in H^{p+q+1}(G, C').
     ```
  2. *Second variable.* For `0 → B' → B → B'' → 0` and pairings compatible with
     `0 → C' → C → C'' → 0`: for `a ∈ H^p(G, A)` and `b'' ∈ H^q(G, B'')`,
     ```
     δ (a ⌣ b'') = (-1)^p (a ⌣ δ(b''))   in H^{p+q+1}(G, C').
     ```

  The coefficient diagrams are inputs of the theorems, not prose around an untyped equation. The
  instances required downstream, all with target degree at most 2, are: `δ⁰` in the first variable
  with `(p, q) = (0, 0)` and `(0, 1)`; `δ¹` in the first variable with `(p, q) = (1, 0)`; `δ⁰` in
  the second variable with `(p, q) = (0, 0)` and `(1, 0)`; and `δ¹` in the second variable with
  `(p, q) = (0, 1)`. Each is its own lemma.
- **The Bockstein.** The sum rule `δ(a ⌣ b) = δa ⌣ b + (-1)^p (a ⌣ δb)` is a statement about a
  single derivation, and needs multiplicative short-exact-sequence data that the two theorems above
  do not carry. Build it once, for the case the applications use: the Bockstein
  `β : Hⁿ(G, 𝔽₂) → Hⁿ⁺¹(G, 𝔽₂)` attached to `0 → ℤ/2 → ℤ/4 → ℤ/2 → 0` with its ring structure,
  with `β ∘ β = 0` and `β (x ⌣ y) = β x ⌣ y + x ⌣ β y` in the degrees where both sides are
  defined. No generic derivation formula is stated without those hypotheses.
- **The duality pairings.** For finite discrete `M`, the evaluation pairing of Layer 0 composed
  with the cups gives `Hⁱ(G, Hom(M, N)) × H²⁻ⁱ(G, M) → H²(G, N)` for `i = 0, 1, 2`. These are
  instances of the six-shape API above, and they are what
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) uses as the underlying
  pairing of local Tate duality.
- **Transport to the canonical cup.** Identification of the six explicit shapes with FLT's
  `ContinuousCohomology.cup` under Layer 2, with the same profiniteness hypotheses. FLT's cup has
  the Leibniz rule but neither commutativity nor associativity; this layer supplies both in the
  low-degree range, and Layer 11 supplies them in all bidegrees. Coordinate with its author before
  starting, since the two developments meet on the same object. **(needs E0)**

### Layer 8: the Galois interface: Hilbert 90 and Kummer theory

`K` a field, `Kˢ = SeparableClosure K`, and `G_K` its Galois group with the Krull topology. This
layer needs Layers 2, 3, 4 and 7, and nothing from Layers 9 to 12.

- **The group and its coefficient field.** Either define `G_K = Kˢ ≃ₐ[K] Kˢ`, or keep
  `Field.absoluteGaloisGroup K` and prove that restriction to `Kˢ` is a topological group
  isomorphism `Field.absoluteGaloisGroup K ≃ₜ* (Kˢ ≃ₐ[K] Kˢ)`, compatibly with the action on `Kˢ`.
  Injectivity is `instSubsingletonAlgHomOfIsPurelyInseparable` together with
  `separableClosure.isPurelyInseparable`; surjectivity is `AlgEquiv.restrictNormalHom_surjective`.
  Whichever route is taken, the coefficient modules are `(Kˢ)ˣ` and its submodules, so that
  `H⁰(G_K, (Kˢ)ˣ) = ((Kˢ)ˣ)^{G_K} = Kˣ` on the nose. `G_K` is profinite in the unbundled sense
  (`CompactSpace`, `TotallyDisconnectedSpace`), by `separableClosure.isGalois` together with the
  pin's `[IsGalois k K] → CompactSpace Gal(K/k)`. The module `(Kˢ)ˣ` is **discrete**, since every
  element lies in a finite subextension and so has open stabilizer; so are `μₙ ⊆ (Kˢ)ˣ` and the
  finite subquotients.
- **The finite-level Galois dictionary.** Finite Galois intermediate fields `K ⊆ L ⊆ Kˢ` correspond
  to open normal subgroups of `G_K`; `G_K ⧸ U` is continuously isomorphic to `Gal(L/K)` for the
  corresponding `L`; `(Kˢ)^U = L`; and these subgroups are cofinal in the system Layer 3 uses.
  Most of this is Mathlib's infinite Galois correspondence
  (`InfiniteGalois.isOpen_and_normal_iff_finite_and_isGalois`,
  `InfiniteGalois.normalAutEquivQuotient`, `InfiniteGalois.IntermediateFieldEquivClosedSubgroup`);
  what has to be added is the identification of the quotient as a **topological** group and the
  cofinality statement in the form Layer 3 consumes.
- **Hilbert 90, in two steps.** First, for a specified Galois extension `L/K` with `Gal(L/K)`
  profinite: `H¹(Gal(L/K), Lˣ) = 0` (NSW (6.2.1); multiplicative coefficients through `Additive`).
  Prove it by Layer 3's colimit from the pin's finite-level `groupCohomology.hilbert90`
  (`H1ofAutOnUnitsUnique`) through Layer 2's finite comparison and the dictionary above, citing the
  named quotient and fixed-field equivalences rather than "by Layer 3". Then specialize to
  `L = Kˢ`. Layer 3 makes this proof possible. Write the proof so that a reader can see this.
  ⚠ The pin's `Rep` universe restriction (`k` and `G` in one universe, tracked in Mathlib #33608)
  touches exactly this comparison. Keep the profinite statement universe-clean and confine any
  workaround to the finite-level step.
- **The Kummer sequence and isomorphism**, for `[NeZero n]` and `hn : IsUnit (n : K)`. Split into
  agent-sized targets, in order:
  1. Surjectivity of the `n`-th power map on `(Kˢ)ˣ`: for `a ≠ 0`, `Xⁿ - a` is separable when `n`
     is invertible, and `Kˢ` is separably closed (`SeparableClosure.isSepClosed`).
  2. The short exact sequence `1 → μₙ → (Kˢ)ˣ → (Kˢ)ˣ → 1` of discrete `G_K`-modules, with `μₙ` the
     `n`-torsion subgroup, named as a type used by the rest of the layer.
  3. The subgroup of `n`-th powers `(Kˣ)ⁿ = (powMonoidHom n : Kˣ →* Kˣ).range` and the quotient
     type `Kˣ ⧸ (Kˣ)ⁿ`, again named.
  4. The connecting map `δ⁰ : Kˣ → H¹(G_K, μₙ)` from Layer 4, and the explicit cocycle description:
     for a chosen `n`-th root `α` of `a` in `Kˢ`, `δ⁰(a)` is the class of `g ↦ g α / α`.
  5. Independence of the choice of root: two roots differ by an element of `μₙ`, and the two
     cocycles differ by the corresponding coboundary.
  6. Multiplicativity of `δ⁰`, its kernel `(Kˣ)ⁿ`, and its surjectivity (Hilbert 90).
  7. The resulting isomorphism `Kˣ ⧸ (Kˣ)ⁿ ≅ H¹(G_K, μₙ)` (NSW, the display after (6.2.1), and
     (6.2.2) for the pairing form).
- **Functoriality in the field**, stated as two commuting squares rather than as naturality in `K`,
  which is not a statement without a chosen embedding of separable closures. For a **finite
  separable** extension `L/K` together with a `K`-embedding `L ↪ Kˢ`, which makes `Kˢ` a separable
  closure of `L` as well and `G_L = Gal(Kˢ/L)` an open subgroup of `G_K`:
  - restriction `H¹(G_K, μₙ) → H¹(G_L, μₙ)` corresponds to `Kˣ ⧸ (Kˣ)ⁿ → Lˣ ⧸ (Lˣ)ⁿ`;
  - corestriction `H¹(G_L, μₙ) → H¹(G_K, μₙ)` corresponds to the norm `N_{L/K}`.

  Both squares include the finiteness and separability hypotheses and the chosen embedding
  explicitly. These are the compatibilities that
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) and
  [Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4) consume.
- **The mod-2 specialization.** Under `h2 : IsUnit (2 : K)`, with `μ₂ = {±1} ⊆ K` carrying the
  trivial action and `𝔽₂ = ZMod 2` written additively: the Kummer class `[a] ∈ H¹(G_K, 𝔽₂)` with
  cocycle `g ↦ 0` if `g √a = √a` and `1` otherwise, the square-class isomorphism
  `Kˣ ⧸ (Kˣ)² ≃ H¹(G_K, 𝔽₂)`, and the `𝔽₂`-valued pairing `[a] ⌣ [b]`. These are the objects the
  `gq2` interfaces `kummerClassK` and B11a are written in.
  ⚠ Do not assume `CharZero`. The hypothesis is `IsUnit (n : K)` with `[NeZero n]`, so finite
  fields of odd characteristic remain in scope for `n = 2`.

### Layer 9: continuous cohomology in all degrees

Everything above except Layer 2's comparison is stated in degrees `0, 1, 2`, because that is where
explicit cochains are usable. Cohomological dimension, dévissage, the general torsion statements
and the Evens norm are all-degree statements, and they all rest on this layer. It is stated
against the canonical object throughout. **(the whole layer needs E0)**

- `Hⁿ(G, M)` for all `n`, for a profinite `G` and a discrete `G`-module `M`, as the canonical
  `continuousCohomology n` applied to the image of `M` under Layer 0's dictionary, with `ℤ` the
  default coefficient ring.
- Restriction, inflation, coefficient maps and conjugation in every degree, with their composition
  laws, and their agreement in degrees `0, 1, 2` with Layer 1's explicit maps under Layer 2.
- The finite-quotient colimit theorem `Hⁿ(G, M) ≅ colim_U Hⁿ(G ⧸ U, M^U)` in every degree, over
  `(OpenNormalSubgroup G)ᵒᵖ`, agreeing with Layer 3 in degrees `0, 1, 2`.
- Compatibility with filtered colimits of discrete coefficients in every degree, in the form the
  dévissage of Layer 10 uses.
- The long exact sequence in every degree for a short exact sequence of discrete modules, with the
  connecting maps agreeing with Layer 4's in low degrees.
- Shapiro's lemma in every degree for closed subgroups, exactness of coinduction, acyclicity of
  `Coind_1^G A` in every positive degree, and dimension shifting
  `Hⁱ⁺¹(G, M) ≅ Hⁱ(G, Coind_1^G M ⧸ M)` for `i ≥ 1`.
- Corestriction for open subgroups in every degree, preferably defined from the finite-level
  corestriction through the colimit theorem rather than by an all-degree cochain formula, with
  `cor ∘ res = (G : U) • id`, transitivity, naturality, compatibility with connecting maps, and
  the Mackey formula, each in every degree.
- The comparison theorem: the all-degree corestriction agrees in degrees `0, 1, 2` with Layer 5's
  explicit transversal formulas.
- **Annihilation and torsion** (NSW (1.6.1); Brown III (10.1) is the discrete model). For
  profinite `G` and `i ≥ 1`: a class of `Hⁱ(G, M)` annihilated by restriction to an open `U` is
  annihilated by `(G : U)`; every element of `Hⁱ(G, M)` is torsion; and `Hⁱ(G, M) = 0` when `M` is a
  `ℚ`-vector space. The `p`-primary refinement for pro-`p` groups belongs to
  [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3); state here the general
  torsion statement and the finite-level annihilation the orders of the `G ⧸ U` provide.

### Layer 10: cohomological dimension

For profinite `G` and a prime `p`; NSW III §3 is the source of record. Nothing upstream defines
`cd`: there is no Mathlib declaration and no PR, and the
[C1 fields Zulip thread](https://leanprover-community.github.io/archive/stream/116395-maths/topic/C1.20fields.3F.html)
of August 2025 asked for it and left it open. This layer rests on Layer 9.

- **Types and definitions.** The three invariants `cd_p`, `scd_p` and `cd` are valued in `ℕ∞`
  (Mathlib's `ENat`). The first two are infima of `Prop`-valued predicates on `ℕ`, and each
  predicate is named and stated in its own right rather than folded into the infimum. In the four
  headers below `M` ranges over discrete `G`-modules in the unbundled classes of §3 and `Hⁱ` is
  Layer 9's, so all four are **(needs E0)**; `leastENatBound` is the order-theoretic wrapper of
  `Suggested.lean`, which sends a predicate on `ℕ` to the infimum in `ℕ∞` of the naturals
  satisfying it, and to `⊤` when none does.
  ```lean
  CohomologicalDimensionLE (p : ℕ) (G : Type*) (n : ℕ) : Prop :=
    ∀ M, IsPPrimaryTorsion p M → ∀ i : ℕ, n < i → Hⁱ(G, M) = 0

  StrictCohomologicalDimensionLE (p : ℕ) (G : Type*) (n : ℕ) : Prop :=
    ∀ M, ∀ i : ℕ, n < i → (Hⁱ(G, M)).primaryComponent p = ⊥

  cd_p  (p : ℕ) (G : Type*) : ℕ∞ := leastENatBound (CohomologicalDimensionLE p G)
  scd_p (p : ℕ) (G : Type*) : ℕ∞ := leastENatBound (StrictCohomologicalDimensionLE p G)
  ```
  So `cd_p G ≤ n ↔ CohomologicalDimensionLE p G n`, and `cd_p G = ⊤` exactly when no bound holds;
  likewise for `scd_p`. Finally `cd G = ⨆ p, cd_p G` in `ℕ∞`, over primes `p`.

  The ordinary and the strict predicate differ in both places at once, and swapping either half
  gives the wrong invariant. Ordinary dimension asks the whole of `Hⁱ` to vanish, but only for
  `p`-primary torsion coefficients; strict dimension allows arbitrary discrete coefficients, but
  asks only the `p`-primary part of `Hⁱ` to vanish. In particular `scd_p` still depends on `p`:
  defining it by vanishing of all of `Hⁱ(G, M)` for all discrete `M` would drop `p` from the
  statement. Here `p`-primary means every element is annihilated by a power of `p`
  (`AddCommMonoid.primaryComponent`, which also supplies `.primaryComponent p` above). Also state
  and prove the equivalence of `CohomologicalDimensionLE` with the other common interface for
  *ordinary* dimension, vanishing of the `p`-primary component of `Hⁱ(G, M)` for every discrete
  **torsion** `M`, so that both may be used; NSW (3.3.1) states the latter. That second interface
  is one torsion hypothesis away from the strict predicate, so keep the three statements apart.
- **Dévissage** (NSW (3.3.2)). `CohomologicalDimensionLE p G n` follows from vanishing of
  `Hⁿ⁺¹(G, M)` for every **finite** discrete `p`-primary `M`, by Layer 9's colimit, long exact
  sequence and dimension shifting; and then from vanishing for every finite **simple** such `M`.
  "Simple" is spelled as follows: a finite discrete `p`-primary `G`-module `M` is simple if it is
  nontrivial, `p • M = 0`, and, for one (equivalently any) open normal `U` acting trivially on `M`,
  the corresponding object of `Rep (ZMod p) (G ⧸ U)` is `CategoryTheory.Simple`. Prove the
  independence of `U` as part of the milestone, and include all finiteness hypotheses in the
  reduction theorem. For `G` pro-`p` the single module `𝔽_p` suffices (NSW (3.3.2) final clause;
  Koch Def. 5.1 takes that as the definition); that refinement lives in
  [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3), built on this layer.
- **Subgroups.** Three theorems:
  1. `cd_p H ≤ cd_p G` for closed `H ≤ G`, by coinduction and Shapiro for the cofinal open case
     and then the limit argument (NSW (3.3.5), Ribes-Zalesskii Thm. 7.3.1);
  2. equality when `H` is open of index prime to `p`, from Layer 9's `cor ∘ res`;
  3. `cd_p G ≤ scd_p G ≤ cd_p G + 1` (NSW (3.3.3)). State all three as inequalities in `ℕ∞`,
     including the case `cd_p G = ⊤`, where `⊤ + 1 = ⊤`.
- **First values.** `cd_p G = 0` if and only if `Hⁱ(G, M) = 0` in positive degrees for every
  `p`-primary `M`; `cd_p Ẑ = 1` for every `p` (the worked example in §6); and `H²(Ẑ, M) = 0` for
  finite `M`.
  ⚠ Do not attempt values of `cd_p G_K` for local fields here. That is
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s `cd(G_K) = 2`, which
  rests on this layer plus their duality. The `p`-Sylow equality `cd_p G = cd_p G_p` (NSW (3.3.6))
  belongs to [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3) together with
  the profinite Sylow theory it consumes; this layer supplies the definitions, the monotonicity,
  the prime-to-`p` equality, and Layer 9's all-degree tools that the Sylow argument uses.

### Layer 11: the graded cup product in all degrees

Layer 7's cups are the low-degree calculational interface; the Evens norm multiplies degrees and
so needs the product in every bidegree. FLT already has the construction, so this layer is mostly
completion and comparison rather than new construction. **(the whole layer needs E0)**

- FLT's canonical cup product `ContinuousCohomology.cup` in every bidegree `(m, n)`, together with
  its unit (the class of `1` in `H⁰` for a `G`-ring) and the Leibniz rule `cup_d_comm` it already
  carries.
- Associativity in all bidegrees, for the four-pairing input of Layer 7 and for a discrete
  `G`-ring, and graded commutativity in all bidegrees.
- The characteristic-2 specialization actually consumed by the norm: over `𝔽₂` with trivial action
  the product is commutative and associative with no signs, and `H^•(G, 𝔽₂) = ⨁ₙ Hⁿ(G, 𝔽₂)` is a
  graded-commutative `𝔽₂`-algebra. Fix the graded-object notation and API here, so that the degree
  multiplication `q ↦ l q` in the Evens norm is typeable.
- Compatibility of the all-bidegree cup with restriction, inflation, and Layer 9's all-degree
  corestriction (the projection formula in all bidegrees).
- Agreement with Layer 7's six explicit shapes under Layer 2's comparison.

### Layer 12: the Evens norm

The multiplicative transfer on `𝔽₂`-cohomology for an open subgroup `U ≤ G` of finite index, in
the shape the Evens-Kahn formula uses. Trivial `𝔽₂`-action throughout. The explicit half needs
Layers 5 and 7 only, and is the half the sibling roadmap consumes; the general construction needs
Layer 11.

#### The explicit index-2 form

- For `(G : U) = 2` (so `U` is normal and `G ⧸ U ≅ C₂`), a chosen `s ∉ U`, and a continuous
  homomorphism `α : U → 𝔽₂`: the Shapiro components `b₁ γ = α γ` for `γ ∈ U` and `b₁ γ = α (γ s)`
  otherwise, and `b_s γ = b₁ (s⁻¹ γ)`; then the **two-point graph 2-cochain**
  ```
  ν_α (γ, η) = b₁ γ · b_s η                     if γ ∈ U,
  ν_α (γ, η) = b₁ γ · b₁ η + b₁ η · b_s η       otherwise,
  ```
  its continuity and its 2-cocycle identity, and the resulting class
  `N^{Ev}(α) ∈ H²(G, 𝔽₂)`. Independence of the choice of `s`, as an explicit coboundary.
- **The four characterizing identities**, which are what Evens-Kahn uses (Kozlowski Lemma 2.4 in
  cohomological form):
  1. `res_U N^{Ev}(α) = α ⌣ (s · α)`, the cup with the conjugate class;
  2. `N^{Ev}(α + β) - N^{Ev}(α) - N^{Ev}(β) = cor (α ⌣ (s · β))`, with Layer 5's corestriction;
  3. `cor¹ α = b₁ + b_s`, agreeing with Layer 5's transversal formula at the transversal `{1, s}`;
  4. compatibility with inflation.

  These four are all that
  [Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4)'s
  Evens-Kahn layer needs from here, and its total-Stiefel-Whitney expansion
  `w(Tr ⟨a⟩) = w(Tr ⟨1⟩) · (1 + cor[a] + N^{Ev}[a])` in degrees `≤ 2` is the application. This
  roadmap owns the cohomological operation; that one owns its application to transferred quadratic
  forms.

#### The general construction

Evens' multiplicative transfer (Evens 1963: the monomial embedding from a transversal, §§2-3; the
norm through the wreath product, §§4-5; transitivity, double cosets and multiplicativity, §6
Props. 1-4). Over a commutative `G`-ring Evens' Thm. 1 states the expansion
`𝒩(1 + χ) = 1 + tr(χ) + ⋯ + 𝒩(χ)` for **even-degree** `χ`, the parity coming from signs; over `𝔽₂`
the construction gives a norm in **every** degree, and the mod-2 all-degree form is the one built
here, since Kozlowski's formula consumes it. The construction is not one milestone; it
is these:

1. The wreath product itself. Mathlib has only the **regular** wreath product
   `RegularWreathProduct D Q = (Q → D) × Q` (notation `D ≀ᵣ Q`,
   `Mathlib/GroupTheory/RegularWreathProduct.lean`), and what the norm needs is the permutation
   wreath product `Uˡ ⋊ 𝔖_l` for the standard action of `𝔖_l` on `Fin l`. Generalize Mathlib's
   construction to an arbitrary `Q`-set `X`, giving `(X → D) ⋊ Q` with `RegularWreathProduct` as
   the case `X = Q`. Sources differ on whether this group is written `U ≀ 𝔖_l` or `𝔖_l ≀ U`, so
   name the base and top factors in the docstring rather than relying on the notation.
2. The transversal-dependent continuous monomial homomorphism `Φ : G → Uˡ ⋊ 𝔖_l` for
   `l = (G : U)`, with the left and right conventions stated explicitly, and its continuity for
   open `U`.
3. The tensor-power object and its `𝔖_l`-action in characteristic 2, together with the tensor
   induction functor the norm factors through.
4. The norm at cochain or resolution level, with its degree formula `q ↦ l q`.
5. Cocycles map to cocycles, and equivalent representatives give the same class.
6. Independence of the transversal.
7. The public function
   ```
   N_U^G : H^q(U, 𝔽₂) → H^{l * q}(G, 𝔽₂),
   ```
   which is a **function**, not an additive homomorphism and not a morphism in any category: its
   Lean signature uses `→` between the underlying types, never `→+`, `→ₗ` or `⟶`. Its failure of
   additivity is exactly the content of identity 2 of the explicit form above.
8. Multiplicativity `N(x ⌣ y) = N x ⌣ N y`, transitivity `N_V^G = N_U^G ∘ N_V^U`, the restriction
   and double-coset formula, and inflation compatibility.
9. Comparison with the finite-quotient norms, if the profinite construction is obtained by descent
   through Layer 9's colimit.
10. **Specialization to index 2 and degree 1, and equality with the explicit graph-cocycle class of
    the first half.** This identification is the mathematical content that distinguishes this
    layer from a transcription: it turns the graph cocycle into a standard cohomological
    construction rather than an ad hoc formula.

Every object the norm is built from is constructed in one of those ten milestones or in Layer 11.
A phrase like "the norm through the wreath product" is not a milestone: the wreath product, the
tensor induction and the graded algebra each have to be built. Sequence the explicit form first,
since its four identities are provable directly and are what the sibling roadmap needs; the
general construction is the hardest single piece of work in this roadmap.

##### What the sibling roadmap consumes

[Quadratic Form Invariants PR #4](https://github.com/roed-math/TauCetiRoadmap/pull/4) uses only
the four characterizing identities of the explicit index-2 form, in degrees `1` and `2`. The ten
milestones of the general construction are this roadmap's own completion of the theory, and
nothing there waits on them.

---

## 6. Worked examples (acceptance criteria)

Discharge these alongside the layers. Each catches a specific classic mistake: a vacuous quotient,
a reversed transition map, a sign slip, a degenerate pairing, an impossible group.

- **`H¹(ℤ_p, ℤ/pᵏ)` and `H¹(ℤ_p, ℤ)`** (Layer 1; in `Suggested.lean`). For the profinite additive
  group `ℤ_p`, evaluation at `1` is a bijection from the continuous additive homomorphisms
  `ℤ_p → ℤ/pᵏ` onto `ℤ/pᵏ`, so `H¹ ≅ ℤ/pᵏ` under the trivial-action characterization, while every
  continuous homomorphism `ℤ_p → ℤ` is zero, so `H¹(ℤ_p, ℤ) = 0`. Continuity is what makes both
  statements true.
- **`Hⁱ(Ẑ, -)` and `cd_p Ẑ = 1`** (Layers 3, 5, 9, 10; NSW (1.7.7) and the worked example at NSW
  III p. 173; Serre, *Local Fields* XIII §1 Props. 1-2): `H¹(Ẑ, ℤ/n) ≅ ℤ/n`, `H²(Ẑ, M) = 0` for
  torsion or divisible `M`, and, through the long exact sequence of `0 → ℤ → ℚ → ℚ/ℤ → 0` together
  with Layer 9's torsion corollary killing `Hⁱ(Ẑ, ℚ)`, `H²(Ẑ, ℤ) ≅ ℚ/ℤ`. Build `Ẑ` as the
  profinite completion of `ℤ`, or state the example over an arbitrary procyclic group with a
  topological generator; do not hardcode a product over primes.
- **`H²(Gal(𝔽̄_q/𝔽_q), 𝔽̄_q^×) = 0`** (Layers 3, 4, 8): the Brauer group of a finite field
  vanishes. Route: pass to finite levels by Layer 3, compute
  `H²(Gal(𝔽_{qⁿ}/𝔽_q), 𝔽_{qⁿ}^×) ≅ 𝔽_q^× / N(𝔽_{qⁿ}^×)` by the pin's finite-cyclic API, and use
  surjectivity of the norm of a finite field. This exercises every transition map in the tower and
  fails immediately if the colimit goes in the wrong direction.
- **`cor ∘ res = (G : U)` on `Ẑ`** (Layer 5): for the open subgroup `nẐ ≤ Ẑ`, `cor ∘ res` on
  `H¹(Ẑ, ℤ/m)` is multiplication by `n`, computed on explicit cocycles. This catches both a wrong
  transversal convention and a wrong normalization. Since `Ẑ` acts trivially here, also do the
  same computation for a nontrivial action, so that the representative factor `t u •` is tested.
- **The `C₂` cup and `G_ℝ`** (Layers 7, 8): on `G = C₂` with the discrete topology, the `(1,1)`
  cup of the nontrivial class of `H¹(C₂, 𝔽₂)` with itself is the nontrivial class of
  `H²(C₂, 𝔽₂)`; the raw non-coboundary statement is in `Suggested.lean`. In Galois form: for
  `K = ℝ`, so that `G_ℝ = Gal(ℂ/ℝ) ≅ C₂`, `[-1] ⌣ [-1] ≠ 0` in `H²(G_ℝ, 𝔽₂)`. This is the
  smallest instance of the Kummer cup detecting a non-norm (`-1` is not a norm from `ℂ`), and it
  is the test case that catches a degenerate pairing in the B11a-shaped statements downstream.
- **Kummer over `ℚ`** (Layer 8): `H¹(G_ℚ, 𝔽₂) ≅ ℚˣ ⧸ (ℚˣ)²`, with `[a]` the explicit square-root
  cocycle.
- **The index-2 Evens anchor** (Layer 12): for `G = C₄ ⊇ U = C₂` and `α ≠ 0`, `N^{Ev}(α)`
  restricts to the nontrivial class on `U`, so `N^{Ev}(α) ≠ 0` in `H²(C₄, 𝔽₂) ≅ 𝔽₂`. Read off the
  extension: a class in `H²(C₄, 𝔽₂)` with trivial coefficients classifies a **central** extension
  `1 → C₂ → E → C₄ → 1`, and a central extension whose quotient is cyclic is abelian, so `E` is
  `C₈` or `C₂ × C₄` and no nonabelian group of order 8 can occur. The nonzero class is `C₈`: a
  lift of a generator of `C₄` has fourth power equal to the generator of the kernel, hence order
  8. `Suggested.lean` carries both halves of that computation, and it is the convention anchor for
  the graph cocycle.
- **The duality-pairing shapes** (Layers 0, 7): for finite discrete `M` and `n`-torsion
  coefficients, the three evaluation cup pairings
  `Hⁱ(G, Hom(M, μ)) × H²⁻ⁱ(G, M) → H²(G, μ)`, `i = 0, 1, 2`, exist with their biadditivity and
  naturality, as instances of the six-shape API. This is the shape
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) needs in order to state
  local Tate duality at all; proving perfectness is theirs.

---

## 7. Ordering and parallelism

Layer 0 and the Layer 1 complex come before everything else. After Layer 1, four pieces are
independent of one another and four contributors can work on them at the same time: Layer 2's
finite comparison, Layer 4's exactness and long exact sequence, Layer 5's transversal calculus, and
Layer 7's cup formulas.

| Layer | Needs |
|---|---|
| 0 discrete modules, sections | Mathlib only |
| 1 explicit complex | 0 |
| 2 comparisons | 1; the canonical half also needs E0 |
| 3 finite-quotient colimit | 1, 2 |
| 4 exact sequences | 1; the five-term sequence also needs 0's continuous sections |
| 5 change of groups | 1 |
| 6 coinduction, Shapiro | 0, 1, 5 |
| 7 cup products | 1; the projection formula needs 5, the connecting-map identities need 4 |
| 8 Galois interface | 2, 3, 4, 7 |
| 9 all degrees, additive | E0, and 2, 3, 5, 6, which it generalizes |
| 10 cohomological dimension | 9 |
| 11 all bidegrees, multiplicative | E0, 7 |
| 12 Evens norm | 5, 7 for the explicit form; 11 for the general construction |

Only Layers 9 and 11, and the canonical halves of Layers 2, 3, 6 and 7, depend on E0. Everything
else can be built at the current pin.

---

## 8. References

Item numbers are verified against the editions cited.

- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed., Springer
  Grundlehren 323 (2008), the source of record. Ch. I: (1.2.2) the definition by continuous
  homogeneous cochains with the inhomogeneous translation (I §2), (1.2.5) the finite-quotient
  colimit `lim→_U Hⁿ(G/U, A^U) ≅ Hⁿ(G, A)`, (1.3.2) the long exact sequence, I §4 cup products
  ((1.4.1) Leibniz, (1.4.2) naturality, (1.4.3) and (1.4.5) `δ`-compatibility, (1.4.4)
  associativity and graded commutativity), I §5 change of groups ((1.5.2) `cor ∘ δ`, (1.5.3)(i),
  (iii), (iv) restriction, inflation and the projection formula, (1.5.6) the double-coset formula,
  (1.5.7) `cor ∘ res = (G : U)`), (1.6.1) torsionness, (1.6.4) Shapiro (with the p. 61 footnote
  naming its `Ind` as the coinduced functor), (1.6.7) the five-term sequence, (1.7.7) procyclic
  computations. Ch. III §3 cohomological dimension: (3.3.1) definitions, (3.3.2) the simple-module
  criterion, (3.3.3) `cd ≤ scd ≤ cd + 1`, (3.3.5) closed subgroups, (3.3.6) Sylow. Ch. VI: (6.2.1)
  Hilbert 90 for arbitrary Galois extensions, with the Kummer isomorphism
  `H¹(G_K, μₙ) ≅ Kˣ/(Kˣ)ⁿ` derived on the same page, and (6.2.2) the pairing form.
- L. Ribes, P. Zalesskii, *Profinite Groups*, 2nd ed., Springer Ergebnisse 40 (2010): Prop. 2.2.2
  (continuous sections of profinite quotients), Thm. 2.1.3 (open normal subgroups as a fundamental
  system, `G = lim← G/U`), Def. 6.4.1 and Cor. 6.5.6(a) (cohomology and its colimit description),
  Thm. 6.10.5 (Shapiro, stated for `Coind_H^G` by that name), §6.7 (restriction and
  corestriction), Cor. 7.2.5(a) (five-term), §7.1 (cd definitions), Thm. 7.3.1 (closed subgroups),
  §7.9 (cup products, with `Cor(a ∪ Res b) = Cor(a) ∪ b` at 7.9.6/7.9.7).
- J-P. Serre, *Galois Cohomology*, Springer (1997), Ch. I §§2-4: the compact exposition this
  layer structure follows.
- J-P. Serre, *Local Fields*, Springer GTM 67 (1979), Part Three: Ch. VII (basic facts; §5 change
  of group; §7 Prop. 6 `Cor ∘ Res = n`; §8 the transfer), Ch. VIII (finite groups; §2 Props. 3-4;
  §3 cup products), Ch. X §3 (the profinite theory *defined* by the colimit over open normal
  subgroups, the third of the three descriptions Layers 1 to 3 relate), Ch. XIII §1 (the
  cohomology of `Ẑ`: Prop. 1, Prop. 2 `H²(Ẑ, A) = 0` for `A` divisible or torsion).
- L. Evens, "A generalization of the transfer map in the cohomology of groups", Trans. AMS 108
  (1963), 54-65: §§2-5 the monomial and wreath-product norm; §6 Props. 1-4 (transitivity, double
  cosets, multiplicativity); Thm. 1 (p. 63), for `(G : H) = l` and `χ ∈ H^{2r}(H, k)` with `k` a
  commutative `G`-ring, `𝒩(1 + χ) = 1 + tr(χ) + ⋯ + 𝒩(χ)`, whose lowest terms are `1` and the
  ordinary transfer.
- A. Kozlowski, "The Evens-Kahn formula for the total Stiefel-Whitney class", Proc. AMS 91 (1984),
  309-313: Thm. 1.1 (the transfer on the total-class group commuting with `w`) and **Lemma 2.4**
  (the index-2 expansion in low degrees, whose proof appears not there but in his "The transfer
  in Segal's cohomology", Illinois J. Math.). Layer 12's explicit form is the self-contained
  account of that lemma.
- B. Kahn, "Classes de Stiefel-Whitney de formes quadratiques et de représentations galoisiennes
  réelles", Invent. Math. 78 (1984): the relative Stiefel-Whitney identity that consumes Layer 12,
  owned by `../QuadraticFormInvariants/`.
- H. Koch, *Galois Theory of p-Extensions*, Springer (2002), Ch. 3 "Cohomology of Profinite
  Groups", built directly on continuous **inhomogeneous** cochains (§3.1, the textbook model of
  Layer 1): Thm. 3.9 (Shapiro), Thm. 3.10 (`cor ∘ res = (G : H)`), Thm. 3.14
  (inflation-restriction-transgression in degree `n`), Thm. 3.16 (inductive limits), §3.9 (cup
  products); Ch. 5 (cd of pro-`p` groups through `Hⁿ(G, 𝔽_p)`, Def. 5.1) and Ch. 6 (generator and
  relation ranks through `H¹` and `H²`), which is the `../ProPGroups/` interface.
- J. S. Milne, *Arithmetic Duality Theorems*, 2nd ed. (2006), Ch. I §0: the continuous-cochain
  conventions (p. 2), cup-product properties (0.1.1)-(0.1.6), Remark 0.11 (Shapiro for `M_*`),
  Remark 0.10 (`Ext` colimits), Prop. 0.15 (conjugation acts trivially), the reference point for
  the duality-pairing shapes.
- K. S. Brown, *Cohomology of Groups*, Springer GTM 87 (1982), discrete background: Ch. III §9
  (the transfer, five constructions), III §10 ((10.1) annihilation by the index), Ch. V §3 (cup
  products; (3.5) associativity at the cochain level, (3.6) commutativity, (3.8) the transfer
  formula `cor (res u ⌣ v) = u ⌣ cor v`).

---

## Appendix A: upstream status

Appendices A and B were audited on 2026-08-06; every status and revision below is as of that date,
which is not repeated. They record live status, which changes. The specification above does not
depend on it, and no statement in Layers 0 to 12 is written against a declaration name that exists
only in an open pull request.

- **Mathlib master**, `Mathlib/RepresentationTheory/Homological/ContCohomology/`. Continuous
  cohomology was redefined and moved by PR
  [#41144](https://github.com/leanprover-community/mathlib4/pull/41144) (merged 2026-07-02; Richard
  Hill, Andrew Yang, Edison Xie), from the pin's
  `Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean`
  (`continuousCohomology (n) : Action (TopModuleCat R) G ⥤ TopModuleCat R`, upstreamed from
  `rmhi/ctsToDiscrete`), whose names master deleted. The current form is built on `TopRep k G`
  through an iterated coinduction resolution: `Basic.lean` (`TopRep.homogeneousCochains`,
  `continuousCohomology n`), `Functoriality.lean` (`ContinuousCohomology.cochainsMap φ f`,
  `cocyclesMap`, `map`, for `φ : H →ₜ* G` and `f : res φ X ⟶ Y`; PR
  [#41309](https://github.com/leanprover-community/mathlib4/pull/41309), merged 2026-07-03), and
  `LowDegree.lean` (`zeroIso : H⁰ ≅ invariants`, still the only computed degree). Its module
  documentation states the design reason for the homogeneous model, that `C(Gⁿ, M)` would restrict
  the theory to locally compact groups, and its TODO list names three of this roadmap's layers:
  coincidence with `groupCohomology` for discrete groups, the `n`-ary cochain description for
  locally compact groups, and long exact sequences. Anything written against the pin's deleted
  names must be treated as frozen and renamed at the bump; prefer explicit-model statements, which
  are stable, and keep canonical-facing statements in comparison files.
- **Open Mathlib PRs**, both by Richard Hill (`rmhi`), both still open:
  [#41539](https://github.com/leanprover-community/mathlib4/pull/41539), "refactor functoriality",
  which splits `map` through a `continuousCohomologyFunctor` and a restriction natural
  transformation `resNatTrans` (last updated 2026-07-27), and
  [#41545](https://github.com/leanprover-community/mathlib4/pull/41545), "add inflation maps in
  continuous cohomology", `Hⁿ(G⧸N, π^N) → Hⁿ(G, π)` as a natural transformation, stacked on #41539
  (last updated 2026-07-11). Layer 1's inflation and restriction and Layer 2's comparison follow
  whatever shape these settle; flag both for a refactor pass when they merge. E0 depends on the
  API they provide, not on the pull requests themselves.
- **FLT staging**, `ImperialCollegeLondon/FLT`, `FLT/Mathlib/RepresentationTheory/`:
  `Homological/ContCohomology/CupProduct.lean` (Edison Xie, PR
  [FLT#1098](https://github.com/ImperialCollegeLondon/FLT/pull/1098), merged 2026-07-10) gives cup
  products on the canonical model in full bidegree, built through the coinduction resolution from
  an intertwining pairing with a joint-continuity hypothesis, with the Leibniz rule `cup_d_comm`,
  descent to cocycles and cohomology (`ContinuousCohomology.cup`), and a kernel-mod-coboundary
  presentation `cohomologyIsoQuot` in its companion `Basic.lean`. It has no graded commutativity,
  no associativity, no restriction, corestriction or Shapiro, and no inhomogeneous description.
  Layer 11 completes it rather than competing with it, and Layer 7 proves the low-degree explicit
  cups match it.
- **rmhi/ctsToDiscrete** (Richard Hill). The continuous-to-discrete comparison: for a **discrete**
  group `G`, natural isomorphisms `continuousCohomology ⋙ forget ≅ recursiveGroupCohomology` and
  `recursiveGroupCohomology ≅ groupCohomology.functor` (`ForgetfulFunctors.lean`,
  `RecursiveToMathlib.lean`), with its own `resNatTrans` and `inflNatTrans`. Two caveats, both
  verified: it is stated against a private copy of `continuousCohomology`, not the Mathlib module
  its own upstreaming created, and five `sorry`s remain, three in the leaf `ResolutionMachine.lean`
  and two inside `kerHomogeneousCochainsZeroEquiv`, on which its `H⁰` isomorphism depends. Layer
  2's finite and discrete comparison should consume this work rebased onto the Mathlib API;
  coordinate with the author rather than reproving it silently.
- **kbuzzard/ClassFieldTheory**: entirely finite-group, discrete-module cohomology over Mathlib's
  `groupCohomology`. Restriction (`rest`, with `δ`-naturality), **corestriction** (`coresNatTrans`,
  `cores_res : rest ≫ cores = index • id`, and the Sylow-injectivity corollaries; Buzzard, Aaron
  Liu, Yunzhou Xie), inflation, inflation-restriction (whose exactness still carries four
  `sorry`s), Tate cohomology (since upstreamed: master has
  `Mathlib/RepresentationTheory/Homological/TateCohomology/`), and Herbrand quotients. No cup
  products and no profinite or continuous material. Layer 5's finite-level corestriction facts
  should be convention-compatible with `cores_res`, so that a reader who knows one normalization
  can read the other without translating.
- **Tau Ceti code repository**: no cohomology and no profinite groups, so all of this is new work
  there; the directory convention there mirrors Mathlib's tree, which the suggested home
  follows.
- **Zulip.** The design thread is
  [#mathlib4 > recursive definition of Continuous Cohomology](https://leanprover-community.github.io/archive/stream/287929-mathlib4/topic/recursive.20definition.20of.20Continuous.20Cohomology.html)
  (February 2025; Hill, Buzzard, Riou, Commelin): Hill proposes the iterated-coinduction
  homogeneous model that Mathlib later adopted, over the continuous inhomogeneous alternative
  (which breaks without joint continuity and, under coinduction, without local compactness) and over Buzzard's
  colimit-over-finite-quotients suggestion (Hill: the right answer only for profinite `G` with
  discrete `M`, which is this roadmap's Layer 3). **The acceptance condition Joël Riou set there is
  Layer 2**: he is "very much ok" with the design provided the formalization includes a comparison
  map to Amelia Livingston's complex that is a quasi-isomorphism in the discrete case. A follow-up
  thread,
  [#mathlib4 > Understanding ContCohomology and TopRep](https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/topic/Understanding.20ContCohomology.20and.20TopRep/with/611890095),
  cited from PR #41539, carries the live functoriality-typing discussion; the public archive mirror
  ends 2026-02-28, so it must be read logged in. Also relevant:
  [#maths > C1 fields?](https://leanprover-community.github.io/archive/stream/116395-maths/topic/C1.20fields.3F.html)
  (August 2025) asks for cohomological dimension (`cd ≤ 1` for C₁ fields) and confirms that nothing
  upstream defines it;
  [#mathlib4 > Universes restriction in Rep](https://leanprover-community.github.io/archive/stream/287929-mathlib4/topic/Universes.20restriction.20in.20Rep.html)
  (January 2026) records that `Rep` forces `k` and `G` into one universe (Mathlib #33608), a live
  constraint on every statement here that meets `Rep`; and Mathlib #31613 (non-abelian `H⁰` and
  `H¹`, open) is neighboring discrete work. Zulip has no thread on cup products in group or
  continuous cohomology, none on the cohomological transfer, and no condensed-against-discrete
  decision thread for profinite Galois groups: the canonical-object decision was made in the
  February 2025 thread, and the remaining gaps are open.

## Appendix B: provenance and coordination

These records state evidenced status as of the audit date at the head of Appendix A. "Not
recorded" means that adaptation of source code is blocked until the revision, license and
coordination fields are filled in; it does not mean permission is assumed. Consuming a public API,
and independently implementing a mathematically specified theorem, are not adaptation and are not
blocked by any of this; copying or translating source code is.

| Project | Authors | Revision or PR | License | Overlap | Plan |
|---|---|---|---|---|---|
| Mathlib `ContCohomology` | Richard Hill, Andrew Yang, Edison Xie | #41144, #41309 merged; #41539, #41545 open | Apache-2.0 | canonical carrier, functoriality, restriction, inflation | consume the merged API, build the gaps here, do not fork |
| FLT continuous cup product | Edison Xie | FLT #1098, merge commit `4a42f80d452a387960b458275478723dac893aae` | Apache-2.0 | the all-bidegree canonical cup | consume it, and build Layer 11's completion here, coordinating with the author |
| `rmhi/ctsToDiscrete` | Richard Hill | `fb09713296926c981226d87d6635c9215c40454e` (2026-07-10) | **no LICENSE file at that revision** | continuous-to-discrete comparison | statement-shape audit only; no code transfer unless the author supplies licensing terms |
| `kbuzzard/ClassFieldTheory` | Kevin Buzzard, Aaron Liu, Edison Xie | `ccc3323c6750abca25b49b35106f54eb3a398509` (2026-07-31) | Apache-2.0 | finite-group restriction, corestriction, exact sequences | align normalization, coordinate before touching the same objects |
| `roed-math/gq2-lean` | roed-math contributors | `d0714a7c431b64e18c422fb16cb5e93d79e5be25` | Apache-2.0 | explicit low-degree cohomology, cups, corestriction, Kummer, index-2 Evens | adapt with file-level credit, generalize, and prove the comparison to the canonical model |
| `davidturturean/gq2-lean-turturean` | David Turturean | `e868b9e3b97b2e4891860155b00ac2aa78b25868` | GPL-3.0-or-later | independent low-degree continuous Galois cohomology | mathematical cross-check of statements only; **license incompatible with Apache-2.0, no code transfer** |

No contact outcome with any upstream author is recorded in this repository, and no ownership
agreement is recorded. The roadmap assigns the canonical carrier to Mathlib and claims only the
explicit calculational model, the comparison theorems, and the material of Layers 3 to 12.

**Authors to coordinate with** before integrating existing material, per the root README's
coordination rule: Richard Hill (`rmhi`; Mathlib `ContCohomology`, PRs #41539 and #41545,
`ctsToDiscrete`), Edison (Yunzhou) Xie (`Whysoserioushah`; Mathlib `ContCohomology`, FLT cup
products, ClassFieldTheory), Andrew Yang (Mathlib `ContCohomology`), Amelia Livingston (the
discrete `groupCohomology` API whose conventions this roadmap follows), Kevin Buzzard and Aaron Liu
(ClassFieldTheory corestriction), and Joël Riou (whose quasi-isomorphism acceptance condition Layer
2 discharges). One person, Xie, currently spans three of the four upstream sites: he is easy to
coordinate with, but the coordination stops if he becomes unavailable. Register a Tau Ceti
intention and post the
layer plan on Zulip before Layer 2 or Layer 7 work starts, since those are the two places where
these theorems and in-flight upstream code touch the same objects. On the demand side, FLT's
planning documents name continuous cohomology and the Galois cohomology of local fields (blueprint
`ch_bestiary` §§13.4-13.9) among its blocking definitions, so this roadmap together with
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) supplies what they
need.

**Migration provenance.** The specifications above are the definition of done; the sources here
are evidence of feasibility and a source of material to adapt. [roed-math/gq2-lean](https://github.com/roed-math/gq2-lean)
contains sorry-free, axiom-free implementations of much of the explicit model, specialized in
places to its own paper's needs: `GQ2/Cohomology.lean` (Layer 1: the complex, compatible pairs,
restriction, inflation and coefficient maps, with conventions already identical to the pin's
`IsCocycle₁/₂`); `GQ2/DiscreteModule.lean` (Layer 0's openness API); `GQ2/CupProduct.lean` and
`GQ2/CupSymmetry.lean` (Layer 7: the `(1,1)`, `(0,2)` and `(2,0)` cups and characteristic-2
symmetry); `GQ2/Corestriction.lean` and `GQ2/CorestrictionCohomology.lean` (Layer 5: the
`Quotient.out` transversal calculus, `cor¹`, `cor²`, and `δ`-compatibility); `GQ2/EvensKahn.lean`
(Layer 12: the index-2 graph cocycle and its expansion rules); `GQ2/Kummer.lean` and
`GQ2/LocalKummer.lean` (Layer 8: the mod-2 Kummer cocycle and class map); `GQ2/Transgression.lean`
(Layer 4: a cochain-level transgression); `GQ2/Shapiro/` (Layer 6, specialized to index 2).

Migration is not transcription. Every one of those files is written for `ZMod 2` coefficients with
trivial action, index-2 subgroups, `n = 2`, or open subgroups where this roadmap needs closed ones.
The corestriction formulas in particular are correct there **because** the action is trivial, and
the general formulas of §3 differ from them by the factor `t u •`; the Kummer material is written
inside `AlgebraicClosure`, and this roadmap uses the separable closure. Migration means proving the
general statement, with the existing file as evidence that the low-degree bookkeeping is
manageable, then re-grounding on the canonical comparison. Credit the source in ported files. Its
`docs/cts-cohomology-gap.md` is the earlier gap analysis that Appendix A updates.
