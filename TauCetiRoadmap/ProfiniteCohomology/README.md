# Roadmap: continuous cohomology of profinite groups

Continuous (cochain) cohomology of a profinite group acting on discrete modules is the working
language of Galois cohomology: local and global class field theory, duality theorems, Demushkin
groups, and the cohomological invariants of quadratic forms are all phrased in it. Mathlib is
mid-construction here. At our pin (`9caeba1000`, 2026-06-03) it has a deep **discrete** theory —
`groupCohomology` on `Rep k G` with inhomogeneous cochains, low-degree API, functoriality,
inflation–restriction at `H¹`, long exact sequences, Shapiro's lemma, and Hilbert 90
(`Mathlib/RepresentationTheory/Homological/GroupCohomology/`) — plus a first **continuous**
functor `continuousCohomology (n) : Action (TopModuleCat R) G ⥤ TopModuleCat R`
(`Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean`, upstreamed from
[rmhi/ctsToDiscrete](https://github.com/rmhi/ctsToDiscrete)) whose only computed degree is `0`.
On current master (checked 2026-07-30) that functor has been **redefined and moved** (PR
[#41144](https://github.com/leanprover-community/mathlib4/pull/41144), merged 2026-07-02;
Richard Hill, Andrew Yang, Edison Xie): continuous cohomology now lives at
`Mathlib/RepresentationTheory/Homological/ContCohomology/{Basic,Functoriality,LowDegree}.lean`,
built on `TopRep k G` via an iterated coinduction resolution, with functoriality in compatible
pairs (PR [#41309](https://github.com/leanprover-community/mathlib4/pull/41309)) and, still, only
degree `0` computed. Everything an arithmetic user actually computes with is missing at every
site: the explicit inhomogeneous `H⁰, H¹, H²` with their cocycle identities, the comparison
isomorphisms between models, the finite-quotient colimit description, long exact sequences,
corestriction, Shapiro's lemma for closed subgroups, cup products with their compatibilities
(cup products exist sorry-free in FLT's staging tree, in full bidegree with the Leibniz rule, but
with no commutativity, no associativity, and no restriction to speak against), cohomological
dimension, the profinite Hilbert 90/Kummer interface, and the Evens norm. We build that usable
computational and structural theory here.

The definitional spine is a design decision, adopted from the surrounding program and pinned now:
**do not create a third independent cohomology theory.** The canonical object is Mathlib's
continuous cohomology (the master `ContCohomology` API); an explicit **inhomogeneous** low-degree
layer (`H⁰, H¹, H²` with explicit cocycles and coboundaries) is the calculational interface; and
proven comparison isomorphisms in degrees `0, 1, 2` tie the two together, so every operation
(restriction, inflation, corestriction, cup, connecting map) has one public normalization and a
computable face. Since the canonical object is absent at our pin, `Suggested.lean` prototypes the
pin-expressible layers (explicit cochains, discrete `groupCohomology` of finite quotients,
`OpenNormalSubgroup` colimit data, Krull-topology instances) and leaves canonical-facing
milestones as prose, per the honest-`sorry` rule.

Suggested home: `TauCeti/RepresentationTheory/Homological/ContCohomology/` — mirroring the
Mathlib master path so that material intended to refactor onto (or upstream into) the canonical
API migrates file-by-file — with the field-theoretic interface (Hilbert 90, Kummer classes) in
`TauCeti/FieldTheory/GaloisCohomology/`. The TauCeti code repository has no cohomology,
profinite-group, or Galois-theoretic material today (verified 2026-07-30: zero files matching
`cohomolog`/`profinite` among its 853 Lean files), so this roadmap is greenfield there.

## Standing hypotheses and pinned conventions

- **Groups.** `G` is a topological group: `[Group G] [TopologicalSpace G]
  [IsTopologicalGroup G]`. The explicit low-degree theory (Layers 1, 4, 5, 7) is stated at this
  generality — profiniteness is not needed to define cochains or prove the functoriality,
  exactness, corestriction, or cup-product identities. **Profinite** means the additional classes
  `[CompactSpace G] [TotallyDisconnectedSpace G]`, exactly the hypotheses of Mathlib's
  `exist_openNormalSubgroup_sub_open_nhds_of_one`; profiniteness enters for the colimit theorem
  (Layer 3), cohomological dimension (Layer 8), and the Galois interface (Layer 9). Do not take
  `ProfiniteGrp` (the category) as a hypothesis of theorems; use the unbundled classes, as
  Mathlib's `ClopenNhdofOne.lean` does, and reserve `ProfiniteGrp` for categorical statements.
- **Discrete `G`-modules, spelled in Mathlib classes.** A topological `G`-module is
  `[AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M] [DistribMulAction G M]
  [ContinuousSMul G M]`; a **discrete** module adds `[DiscreteTopology M]`. No bundling class is
  introduced: instance search composes these freely, and each statement quantifies over exactly
  the classes it needs. For discrete `M`, continuity of the action is equivalent to all point
  stabilizers being open (`continuousSMul_iff_stabilizer_isOpen`,
  `Mathlib/Topology/Algebra/MulAction.lean`) — state and use both faces. The categorical form is
  `TopRep k G` (master) for canonical-facing statements; the dictionary between the two is a
  Layer 0 target, in the style of the pin's discrete bridge `Rep.ofDistribMulAction`.
- **Left actions throughout**, written `g • m`. Never introduce right actions; a right-module
  statement is phrased through `Gᵐᵒᵖ` if it ever arises.
- **Cochains are plain functions with continuity as a predicate.** `C¹(G,M)` is the subgroup of
  continuous elements of `G → M`, `C²(G,M)` of `G × G → M` — matching the pin's
  `groupCohomology.cocycles₁ : Submodule k (G → A)` shape, not bundled `C(G, M)`. (The canonical
  object uses bundled iterated `C(G, -)`; the comparison layer crosses that bridge once.)
- **The differentials and cocycle identities are Mathlib's** (`GroupCohomology/LowDegree.lean`,
  Amelia Livingston's conventions), continuity added:
  - `(d⁰ m) g = g • m - m`;
  - `(d¹ f) (g, h) = g • f h - f (g * h) + f g`;
  - `(d² f) (g, h, j) = g • f (h, j) - f (g * h, j) + f (g, h * j) - f (g, h)`;
  - 1-cocycle identity: `f (g * h) = g • f h + f g` — definitionally
    `groupCohomology.IsCocycle₁`;
  - 2-cocycle identity: `f (g * h, j) + f (g, h) = g • f (h, j) + f (g, h * j)` —
    definitionally `groupCohomology.IsCocycle₂`.
  Cochains are **not normalized**: `f 1 = 0` (degree 1) and the degree-2 normalization facts are
  lemmas (`cocycles₁_map_one`, `cocycles₂_map_one_fst/snd`), never definitional conditions.
- **Cohomology presentation.** `H¹(G,M) = Z¹/B¹` and `H²(G,M) = Z²/B²` as quotients of additive
  subgroups of the function spaces, with `Z¹ = C¹ ⊓ ker d¹`, `B¹ = range d⁰` (automatically
  continuous), `Z² = C² ⊓ ker d²`, `B² = d¹(C¹)` — the image of the **continuous** 1-cochains.
  `H⁰(G,M)` is the invariant subgroup `M^G` itself, not a quotient.
- **Functoriality is by compatible pairs**, in the direction of Mathlib's discrete
  `groupCohomology.cochainsMap` and master's continuous `ContinuousCohomology.cochainsMap`: a
  continuous homomorphism `φ : H →ₜ* G` together with an `H`-equivariant continuous map from the
  restricted module (`f (φ h • m) = h • f m`) induces `Hⁱ(G, M) → Hⁱ(H, N)`. Restriction
  (`φ` = inclusion of a subgroup, any subgroup — openness is needed only for corestriction),
  inflation (`φ` = a quotient map, module = the invariants), and coefficient maps (`φ = id`) are
  the three named instances, with composition laws stated for all of them.
- **Cup products** are relative to a `G`-equivariant biadditive pairing `μ : M →+ N →+ P` with
  `μ (g • m) (g • n) = g • μ m n`, together with the joint-continuity hypothesis
  `Continuous fun p : M × N => μ p.1 p.2` — automatic when `M` and `N` are discrete, which is
  the arithmetic case; FLT's staging cup product carries the same hypothesis. The cochain
  formulas, fixed (they are NSW I §4's, with Mathlib's action notation):
  - `(0, q)`: `(m ⌣ b) (g₁, …, g_q) = μ m (b (g₁, …, g_q))`;
  - `(1, 1)`: `(a ⌣ b) (g, h) = μ (a g) (g • b h)`;
  - `(1, 2)`: `(a ⌣ b) (g, h, j) = μ (a g) (g • b (h, j))`;
  - `(2, 0)`: `(a ⌣ b) (g, h) = μ (a (g, h)) ((g * h) • b)`.
  Signs: the Leibniz rule is `d(a ⌣ b) = da ⌣ b + (-1)^p (a ⌣ db)` for `a` of degree `p`
  (matching FLT's `cup_d_comm`), and graded commutativity is
  `a ⌣ b = (-1)^{pq} (b ⌣' a)` with `⌣'` taken along the flipped pairing; in the `𝔽₂`-valued
  arithmetic applications all signs vanish and the cup is symmetric on classes.
- **Shapiro's direction.** Coinduction is the right adjoint; Shapiro's lemma reads
  `Hⁿ(G, Coind_H^G A) ≅ Hⁿ(H, A)` — the direction of the pin's discrete
  `groupCohomology.coindIso`. For a profinite `G` and closed `H ≤ G`, `Coind_H^G A` is the
  discrete module of continuous (equivalently locally constant) `H`-equivariant maps `G → A`;
  for **open** `H` the natural map `Ind_H^G A → Coind_H^G A` is an isomorphism (finite index;
  the pin's discrete `Rep.indCoindIso` is the model), and both transports are stated.
- **Corestriction** is defined for an **open** subgroup `U ≤ G` (automatically finite index in
  the profinite/compact case; carry `[U.FiniteIndex]` explicitly otherwise) by the transversal
  formula, with the transversal pinned to `Quotient.out : G ⧸ U → G`: the transversal word is
  `ℓ_u(γ) = (u.out)⁻¹ * γ * ((γ⁻¹ • u).out) ∈ U`, and
  - degree 1: `(cor f) γ = ∑ u : G ⧸ U, f (ℓ_u γ)`,
  - degree 2: `(cor f) (γ, η) = ∑ u : G ⧸ U, f (ℓ_u γ, ℓ_{γ⁻¹ • u} η)`.
  Independence of the transversal is a **theorem**, not a definitional convenience, and the
  normalization is pinned by `cor ∘ res = (G : U) • id` on `H⁰, H¹, H²`.
- **The colimit convention.** The finite-level system is indexed by `OpenNormalSubgroup G`
  (Mathlib's structure, `Topology/Algebra/OpenSubgroup.lean`), directed by reverse inclusion
  (`V ≤ U` refines), with value `Hⁱ(G ⧸ U, M^U)` — discrete `groupCohomology` of the finite
  quotient — and transition maps the finite-level inflations; the comparison maps to `Hⁱ(G, M)`
  are the (continuous) inflations along `G →ₜ* G ⧸ U`. This matches the indexing of Mathlib's
  `ProfiniteGrp.toFiniteQuotientFunctor` (`ProfiniteGrp/Limits.lean`).
- **Multiplicative coefficients** (units of a field, roots of unity) enter through `Additive`,
  by the pin's own bridging idiom (`groupCohomology.IsMulCocycle₁`,
  `Rep.ofMulDistribMulAction`); no parallel multiplicative cohomology is developed.
- **The Evens norm** is developed for `𝔽₂ = ZMod 2` coefficients with trivial action — the
  generality Evens' multiplicative transfer admits without parity constraints, and the one the
  Evens–Kahn formula consumes — for an open subgroup of arbitrary finite index in the abstract
  construction, with the index-2, degree-`1 → 2` case additionally given by the explicit
  two-point graph cocycle (Layer 10 pins both and identifies them). General coefficients (where
  only even-degree classes have norms) are deliberately out of scope for this roadmap.

## What Mathlib already has (consume)

All paths at the pin `9caeba1000`:

- **Discrete group cohomology, the model API:**
  `Mathlib/RepresentationTheory/Homological/GroupCohomology/Basic.lean` (`groupCohomology`,
  `inhomogeneousCochains`); `LowDegree.lean` (`d₀₁`, `d₁₂`, `d₂₃`, `cocycles₁/₂`,
  `mem_cocycles₁_iff`, `mem_cocycles₂_iff`, `IsCocycle₁/₂`, `IsCoboundary₁/₂`, the
  `DistribMulAction`/multiplicative bridges `cocyclesOfIsCocycle₁`, `isMulCocycle₁_of_mem…`,
  `H0Iso`, `H1π`, `H2π`, `H1IsoOfIsTrivial`); `Functoriality.lean` (`cochainsMap` for a pair
  `(f : G →* H, φ : res f A ⟶ B)`, `map`, `mapCocycles₁/₂`, `H1InfRes` **with
  `H1InfRes_exact`**, `resNatTrans`, `infNatTrans`, `functor`); `LongExactSequence.lean`
  (`groupCohomology.δ`, `mapShortComplex₁/₂/₃_exact`, `δ₀_apply`, `δ₁_apply`);
  `Shapiro.lean` (`coindIso : Hⁿ(G, Coind_S^G A) ≅ Hⁿ(S, A)`); `Hilbert90.lean`
  (`H1ofAutOnUnitsUnique`, `hilbert90`); `FiniteCyclic.lean` (`groupCohomologyIsoEven/Odd` for
  finite cyclic groups); `Resolution.lean` (the bar resolution).
- **Coinduction and finite index (discrete):** `Mathlib/RepresentationTheory/Coinduced.lean`
  (`Representation.coind` along any `φ`), `Induced.lean`, `FiniteIndex.lean`
  (`Rep.indCoindIso : Ind_S^G A ≅ Coind_S^G A` for `[S.FiniteIndex]`).
- **Continuous cohomology, first form:**
  `Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean` (Hill–Yang):
  `continuousCohomology (n) : Action (TopModuleCat R) G ⥤ TopModuleCat R` via invariants of the
  iterated `C(G, -)` complex, `continuousCohomologyZeroIso`. **Warning:** master deleted these
  names (see the next section); state nothing new against them.
- **Continuous representations:** `Mathlib/RepresentationTheory/Continuous/Basic.lean`
  (`ContRepresentation R G V = G →* V →L[R] V`, `ContIntertwiningMap`,
  `ContRepresentation.coind₁`) — the pin-side seed of master's `TopRep`.
- **Profinite groups:** `Mathlib/Topology/Algebra/OpenSubgroup.lean` (`OpenSubgroup`,
  `OpenNormalSubgroup`); `Mathlib/Topology/Algebra/ClopenNhdofOne.lean`
  (`exist_openNormalSubgroup_sub_open_nhds_of_one` under
  `[CompactSpace G] [TotallyDisconnectedSpace G]`);
  `Mathlib/Topology/Algebra/Category/ProfiniteGrp/{Basic,Limits,Completion}.lean`
  (`ProfiniteGrp`, `toFiniteQuotientFunctor : OpenNormalSubgroup P ⥤ FiniteGrp`,
  `continuousMulEquivLimittoFiniteQuotientFunctor` — a profinite group is the limit of its
  finite quotients); `Mathlib/Topology/Algebra/ContinuousMonoidHom.lean`
  (`ContinuousMonoidHom`, `ContinuousAddMonoidHom`).
- **Discrete actions:** `Mathlib/Topology/Algebra/MulAction.lean` (`stabilizer_isOpen`,
  `continuousSMul_iff_stabilizer_isOpen`).
- **Galois groups as profinite groups:** `Mathlib/FieldTheory/KrullTopology.lean` (the Krull
  topology, `krullTopology_t2`, total separatedness); `Mathlib/FieldTheory/Galois/Profinite.lean`
  (`CompactSpace Gal(K/k)` for `[IsGalois k K]`, `InfiniteGalois.profiniteGalGrp`, the limit
  presentation over `FiniteGaloisIntermediateField`);
  `Mathlib/FieldTheory/AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup`, its topological
  abelianization); `Mathlib/FieldTheory/KummerExtension.lean` (the polynomial/extension-level
  Kummer theory: `autEquivRootsOfUnity`, `autEquivZmod`).

## What is in motion upstream (track, and refactor onto when it lands)

Verified live 2026-07-30. The continuous-cohomology stack is an active, single-team work area
(Richard Hill, Andrew Yang, Edison Xie — see the coordination section):

- **Mathlib master** `Mathlib/RepresentationTheory/Homological/ContCohomology/`:
  `Basic.lean` (redefinition over `TopRep k G`, iterated-coinduction resolution,
  `continuousCohomology n A`; PR #41144, merged 2026-07-02), `Functoriality.lean`
  (`ContinuousCohomology.cochainsMap φ f`, `cocyclesMap`, `map`, for `φ : H →ₜ* G` and
  `f : res φ X ⟶ Y`; PR #41309, merged 2026-07-03), `LowDegree.lean` (`zeroIso : H⁰ ≅
  invariants` — degree 0 remains the only computed degree). Its module TODO names exactly our
  Layers 2–4: coincidence with `groupCohomology` for discrete groups, `n`-ary cochains for
  locally compact groups, and long exact sequences.
- **Open Mathlib PRs** (both by Richard Hill, `rmhi`):
  [#41539](https://github.com/leanprover-community/mathlib4/pull/41539) "refactor functoriality"
  (splits `map` through a `continuousCohomologyFunctor` and a restriction natural transformation
  `resNatTrans`; last updated 2026-07-27) and
  [#41545](https://github.com/leanprover-community/mathlib4/pull/41545) "add inflation maps in
  continuous cohomology" (`Hⁿ(G⧸N, π^N) → Hⁿ(G, π)` as a natural transformation; stacked on
  #41539; last updated 2026-07-11). Layer 1's inflation/restriction and Layer 2's comparison
  must land on whatever shape these PRs settle — flag both milestones for a refactor pass when
  they merge.
- **FLT staging** (`ImperialCollegeLondon/FLT`, `FLT/Mathlib/RepresentationTheory/`):
  `Homological/ContCohomology/CupProduct.lean` (584 lines, Edison Xie, merged 2026-07-10, PR
  FLT#1098): cup products on the canonical model in **full bidegree** `(m, n)`, built through
  the coinduction resolution from an intertwining pairing with a joint-continuity hypothesis
  (automatic for discrete coefficients), with the Leibniz rule `cup_d_comm`, descent to
  cocycles/cohomology (`ContinuousCohomology.cup`), and a kernel-mod-coboundary presentation
  `cohomologyIsoQuot` in its companion `Basic.lean`. **Absent there:** graded commutativity,
  associativity, restriction/corestriction/Shapiro (zero hits repo-wide), and any inhomogeneous
  description. Layer 7's canonical-level cup should be FLT's, upstreamed and completed, not a
  rival; our explicit low-degree cups must be proven to match it under the Layer 2 comparison.
- **rmhi/ctsToDiscrete** (Richard Hill; last commit 2026-07-10, mathlib pin of 2026-07-10):
  the continuous-to-discrete comparison — for a **discrete** group `G`, natural isomorphisms
  `continuousCohomology ⋙ forget ≅ recursiveGroupCohomology` and `recursiveGroupCohomology ≅
  groupCohomology.functor` (`ForgetfulFunctors.lean`, `RecursiveToMathlib.lean`), plus its own
  `resNatTrans` (restriction along `φ : G →ₜ* H`) and `inflNatTrans`. Two caveats, verified:
  it is stated against a **private copy** of `continuousCohomology` (it does not import the
  mathlib module its own upstreaming created), and 5 `sorry`s remain (3 in the leaf
  `ResolutionMachine.lean`; 2 inside `kerHomogeneousCochainsZeroEquiv`, on which its `H⁰` iso
  depends). Layer 2's finite/discrete comparison should consume this work rebased onto the
  mathlib API — coordinate with the author rather than reproving silently.
- **kbuzzard/ClassFieldTheory** (last human commits 2026-07-24/25, all by Edison Xie):
  entirely **finite-group, discrete-module** cohomology over Mathlib's `groupCohomology` —
  restriction (`rest`, with `δ`-naturality), **corestriction** (`coresNatTrans`,
  `cores_res : rest ≫ cores = index • id`, Sylow-injectivity corollaries; authors Buzzard, Aaron
  Liu, Yunzhou Xie), inflation, inflation–restriction (exactness still carries 4 `sorry`s), Tate
  cohomology (now upstreamed: master has
  `Mathlib/RepresentationTheory/Homological/TateCohomology/`, post-pin), Herbrand quotients.
  No cup products, no profinite/continuous material (zero hits). Layer 5's finite-level
  corestriction facts should be convention-compatible with `cores_res`, and anything we prove at
  the discrete level should be offered there or to Mathlib rather than kept private.
- **TauCeti code repo:** no cohomology, no profinite groups (verified 2026-07-30) — greenfield;
  the directory convention there mirrors Mathlib's tree, which the suggested home follows.
- **Zulip.** The design thread is
  [#mathlib4 > recursive definition of Continuous Cohomology](https://leanprover-community.github.io/archive/stream/287929-mathlib4/topic/recursive.20definition.20of.20Continuous.20Cohomology.html)
  (Feb 2025; Hill, Buzzard, Riou, Commelin): Hill proposes exactly the iterated-coinduction
  homogeneous model that later landed, over the "continuous inhomogeneous cochains" alternative
  (which breaks without joint continuity and, under coinduction, without local compactness),
  and over Buzzard's colimit-over-finite-quotients suggestion (Hill: right answer only for
  profinite `G` with discrete `M` — i.e., precisely this roadmap's Layer 3). The
  **acceptance condition Joël Riou set there is this roadmap's Layer 2**: he is "very much ok"
  with the design *provided* the formalization includes a comparison map to Amelia
  Livingston's complex that is a quasi-isomorphism in the discrete case. A follow-up thread
  ([#mathlib4 > Understanding ContCohomology and TopRep](https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/topic/Understanding.20ContCohomology.20and.20TopRep/with/611890095),
  cited from PR #41539, ~July 2026) carries the live functoriality-typing discussion; the
  public archive mirror ends 2026-02-28, so it must be read logged-in. Also relevant:
  [#maths > C1 fields?](https://leanprover-community.github.io/archive/stream/116395-maths/topic/C1.20fields.3F.html)
  (Aug 2025) wants cohomological dimension (`cd ≤ 1` for C₁ fields) and confirms nothing
  upstream defines it;
  [#mathlib4 > Universes restriction in Rep](https://leanprover-community.github.io/archive/stream/287929-mathlib4/topic/Universes.20restriction.20in.20Rep.html)
  (Jan 2026) records that `Rep` forces `k` and `G` into one universe (tracked in #33608) —
  a live constraint on every statement here that bridges to `Rep`; and mathlib PR #31613
  (non-abelian `H⁰`/`H¹`, open, updated 2026-05-18) is neighboring discrete work. Zulip has
  **no** thread on cup products in group or continuous cohomology, none on the cohomological
  transfer, and no condensed-vs-discrete decision thread for profinite Galois groups — the
  canonical-object decision was made in the Feb 2025 thread, and the gaps are genuinely open.

## What is missing (build here)

Everything between the canonical functor and a working Galois cohomology. The **explicit
inhomogeneous low-degree theory** with the cocycle identities above, over any topological group,
and its three named functorialities. The **comparison isomorphisms**: inhomogeneous ↔ canonical
in degrees `0, 1, 2`, and continuous ↔ discrete `groupCohomology` for groups with the discrete
topology (in particular finite groups) — no site (Mathlib, FLT, ctsToDiscrete) currently relates
an explicit cocycle to the canonical object in degree `> 0`. The **finite-quotient description**
`Hⁱ(G, M) ≅ colim_U Hⁱ(G ⧸ U, M^U)` for profinite `G` and discrete `M`, the single theorem that
turns finite group cohomology into profinite computations, together with coefficient
filtered-colimit compatibility. **Long exact sequences** for short exact sequences of discrete
modules, with explicit `δ⁰, δ¹` and their naturality (Mathlib's continuous TODO; no site has
them). **Corestriction** for open subgroups with `cor ∘ res = index`, transversal independence,
and the torsion/annihilation corollaries. **Induced/coinduced discrete modules over closed
subgroups and Shapiro's lemma**, with the acyclicity of coinduced modules and dimension
shifting. **Cup products in the arithmetic range** `(0,q), (1,1), (1,2), (2,0)` on the explicit
model, with associativity and graded commutativity in that range, the restriction/inflation
compatibilities, the projection formula against corestriction, the connecting-map formulas, and
the identification with FLT's canonical-model cup. **Cohomological dimension** `cd_p` with the
torsion/finite/simple dévissage and the closed-subgroup theory. The **Galois interface**: the
profinite Hilbert 90 and the Kummer isomorphism `H¹(G_K, μ_n) ≅ K^× / (K^×)^n` with its explicit
cocycle. The **Evens norm** for open subgroups on `𝔽₂`-cohomology, in both its abstract
(monomial/wreath) and explicit index-2 graph-cocycle forms. None of this exists upstream as
stated; each object also gets its basic API, not only its headline theorem.

---

## The build, in layers

The ordering is the dependency order. As each layer makes the next layer's types expressible in
`TauCeti/`, state its milestones in `Suggested.lean` (with `sorry`); the pin-expressible early
targets are there already.

### Layer 0: discrete modules over a topological group

The coefficient theory, stated in the unbundled classes of the conventions section.

- **Openness API.** Point stabilizers of a discrete module are open; for finite `M` the kernel
  of the action is open; over a profinite `G`, a finite discrete module has an open **normal**
  subgroup acting trivially — the action factors through a finite quotient. (Consume
  `continuousSMul_iff_stabilizer_isOpen` and `exist_openNormalSubgroup_sub_open_nhds_of_one`.)
  For arbitrary discrete `M` over profinite `G`: every element is fixed by an open normal
  subgroup, so `M = ⋃_U M^U` — the smallness fact underlying Layer 3.
- **Constructions.** Invariants `M^U` as a `G ⧸ U`-module (for `U` normal, with the induced
  discrete action — the coefficient system of the finite-level tower); products, subgroups and
  quotients of discrete modules; for **finite** `M` and discrete `N`, the internal hom
  `M →+ N` with the conjugation action `(g • φ) m = g • φ (g⁻¹ • m)` is again discrete, and
  evaluation `(M →+ N) →+ M →+ N` is a `G`-equivariant pairing — the input the duality
  pairings of [`../LocalFields/README.md`](../LocalFields/README.md) (roadmap in preparation)
  feed to Layer 7's cups.
- **The categorical dictionary.** The translation between the unbundled classes and `TopRep k G`
  (master) resp. the pin's `Action (TopModuleCat R) G`, in the style of the discrete
  `Rep.ofDistribMulAction`; on master this is where our statements meet the canonical API.
  ⚠ Keep every *theorem* of Layers 1–10 stated against the unbundled classes wherever possible;
  the bundled forms are interfaces, and instance-vs-structure mismatches here are the main
  source of unusable statements.

### Layer 1: the explicit low-degree theory and its functoriality

- **The complex.** `C¹, C², Z¹, Z², B¹, B²`, `H⁰, H¹, H²` as pinned above, with `d ∘ d = 0`,
  the readable membership lemmas (`mem_Z1_iff`, `mem_Z2_iff` in the exact `IsCocycle₁/₂`
  shapes), evaluation lemmas (`Z¹` vanishes at `1`, inverse formula; the degree-2 normalization
  lemmas), and the trivial-action characterizations: `B¹ = ⊥`, `H¹ ≃+` continuous homomorphisms
  `G →ₜ* M`-additively, `H⁰ = M`.
- **Compatible-pair functoriality.** The pullback `Hⁱ(G, M) → Hⁱ(H, N)` of the conventions
  section, on cochains, cocycles and cohomology, with identity and composition laws — the
  continuous twin of the pin's `groupCohomology.cochainsMap` package, aligned with master's
  `ContinuousCohomology.cochainsMap` and with PR #41539's functor/natural-transformation
  refactor when it lands.
- **The three instances.** Restriction `res : Hⁱ(G, M) → Hⁱ(H, M)` for any subgroup (with the
  subspace topology); inflation `inf : Hⁱ(G ⧸ N, M^N) → Hⁱ(G, M)` for closed normal `N`
  (aligned with PR #41545); coefficient maps for `G`-equivariant continuous homomorphisms.
  Composition laws mixing the three (res∘inf, coefficient naturality of both).
- **Conjugation.** The compatible pair (conjugation by `g`, action of `g`) induces an action of
  `G` on `Hⁱ(N, M)` for `N` a normal (closed) subgroup, and **inner automorphisms act trivially
  on `Hⁱ(G, M)` itself** — by the explicit chain homotopy in degrees `≤ 2`. This is what makes
  the `G ⧸ N`-action on `Hⁱ(N, M)` well defined, needed by Layer 4's five-term sequence.
  ⚠ The homotopy in degree 2 is fiddly; write it once, for the compatible-pair form, and derive
  the degree-1 case rather than proving them separately.

### Layer 2: the comparison isomorphisms

The layer that makes "one theory, two faces" true, and the reason nothing here forks the
canonical API. It is also the community's own acceptance condition: when the canonical design
was settled on Zulip (Feb 2025), Joël Riou's stated requirement was a comparison map to the
discrete inhomogeneous complex that is a quasi-isomorphism in the discrete case — this layer,
in low degrees, plus `ctsToDiscrete`'s all-degrees discrete comparison.

- **Continuous ↔ discrete.** For `G` carrying the discrete topology (finite groups the key
  case) and any `G`-module `M` (discrete): `Hⁱ_explicit(G, M) ≅ groupCohomology` in degrees
  `0, 1, 2`, through the pin's `cocycles₁/₂` and `IsCocycle₁/₂` bridges — every continuity
  condition is vacuous, so this is an identification of subquotients of the same function
  spaces. This is the bridge Layer 3 consumes at every finite level.
  ⚠ Mathlib's `groupCohomology` is `k`-linear over `Rep k G`; the explicit theory is
  `ℤ`-linear (`DistribMulAction`). Compare against `Rep ℤ G` via `Rep.ofDistribMulAction`, and
  state the `k`-linear refinement only where a `k`-action genuinely exists — do not smuggle a
  `Module k` hypothesis into the profinite theory.
- **Inhomogeneous ↔ canonical (homogeneous), degrees `0, 1, 2`.** Against master's
  `ContCohomology`: the classical chain-level correspondence — degree 1:
  `f (g₀, g₁) = g₀ • c (g₀⁻¹ * g₁)` with inverse `c g = f (1, g)`; degree 2:
  `f (g₀, g₁, g₂) = g₀ • c (g₀⁻¹ * g₁, g₁⁻¹ * g₂)` — is a continuous chain map in both
  directions (⚠ on the canonical side "cochain" means an invariant element of the *iterated*
  `C(G, C(G, -))`, not a function on `Gⁿ⁺¹`; the currying/uncurrying is where the continuity
  content lives, and FLT's `cohomologyIsoQuot` does the abstract-side quotient-presentation
  half). Conclude `Hⁱ_explicit ≅ continuousCohomology i` for `i ≤ 2`, naturally in compatible
  pairs. Not stateable at the pin (master-facing); prose-only until the toolchain bump, then a
  refactor-onto milestone tracking #41539/#41545.
- **Transport.** Under these isomorphisms: restriction ↔ restriction, inflation ↔ inflation,
  coefficient maps ↔ `map`, and (once Layer 7 exists) explicit cup ↔ FLT's `cup`. Each
  operation gets exactly one transport lemma, stated the day both sides exist.

### Layer 3: the finite-quotient colimit description

For profinite `G` and discrete `M`; the workhorse theorem of the subject (NSW (1.2.5),
Ribes–Zalesskii Cor. 6.5.6(a), Koch Thm. 3.16; Serre, *Local Fields* X §3 takes it as the
*definition* — the three textbooks model the three faces our Layers 1–3 relate).

- **The system.** The functor `U ↦ Hⁱ(G ⧸ U, M^U)` on `OpenNormalSubgroup G` (directed by
  reverse inclusion), transition maps the finite-level inflations, comparison maps the
  continuous inflations — all through Layer 2's finite bridge, consuming the pin's discrete
  `groupCohomology` at each level. Functoriality of the whole system in `M`.
- **The colimit theorem.** `Hⁱ(G, M) ≅ colim_U Hⁱ(G ⧸ U, M^U)` for `i = 0, 1, 2` on the
  explicit model: every continuous cocycle is, up to an explicit coboundary, inflated from a
  finite level, and a finite-level class dying in `G` dies at some deeper finite level.
  ⚠ The degree-2 surjectivity argument needs uniform local constancy (compactness of `G × G`)
  to descend both variables at once — this is where `CompactSpace` is genuinely used, not just
  total disconnectedness. State the all-degrees form against the canonical object as the
  companion milestone (prose until the bump).
- **Coefficient colimits.** `Hⁱ(G, -)` commutes with filtered colimits of discrete modules
  (`i ≤ 2` explicit): a continuous cochain into a filtered colimit lands in a stage
  (compactness again). Corollary, with Layer 0: cohomology of any discrete module is the
  filtered colimit over its finite-type (equivalently, finitely generated `ℤ[G ⧸ U]`-)
  submodules.
- **First consequences.** `H⁰(G, M) = M^G` tautologically; for finite `M` the tower stabilizes
  levelwise (`M^U = M` for small `U`); `Hⁱ(G, M)` for `i ≥ 1` as a colimit of cohomology of
  finite groups — the input to Layer 5's torsion corollary.

### Layer 4: exact sequences

- **Exactness of cochains.** For a short exact sequence `0 → A → B → C → 0` of discrete
  `G`-modules (`G` any topological group), the cochain sequences
  `0 → Cⁿ(G, A) → Cⁿ(G, B) → Cⁿ(G, C) → 0` are exact: a continuous cochain into discrete `C`
  is locally constant, so composing with **any** set-section of `B → C` preserves continuity.
  ⚠ This is the one place discreteness of the coefficients is irreplaceable — for general
  topological modules there is no continuous section and no LES; do not state the layer beyond
  discrete coefficients.
- **The long exact sequence** through degree 2 (NSW (1.3.2)): explicit connecting maps
  `δ⁰ : H⁰(G, C) → H¹(G, A)` (choose a preimage, apply `d⁰`) and `δ¹ : H¹(G, C) → H²(G, A)`,
  well-definedness, exactness at the eight nodes from `H⁰(G, A)` to `H²(G, B)`, naturality in
  morphisms of short exact sequences and in compatible pairs (hence: restriction and inflation
  commute with `δ`). Mirror the pin's discrete `δ₀_apply`/`δ₁_apply` interface so the two
  theories are used identically. The all-degrees LES against the canonical object is the
  companion refactor-onto milestone (it is on master's own TODO list — coordinate, do not
  duplicate).
- **Inflation–restriction.** The exact sequence
  `0 → H¹(G ⧸ N, M^N) → H¹(G, M) → H¹(N, M)` for closed normal `N` (direct cochain proof; the
  pin's discrete `H1InfRes_exact` is the model). Then the **five-term sequence** (NSW (1.6.7),
  Ribes–Zalesskii Cor. 7.2.5(a); Koch Thm. 3.14 gives the degree-`n` form under vanishing
  below `n`, which Layer 8's dévissage wants): the `G ⧸ N`-invariance of the image of
  restriction (Layer 1's conjugation action), the transgression
  `tg : H¹(N, M)^{G ⧸ N} → H²(G ⧸ N, M^N)` by the explicit cochain construction, and
  exactness of
  `0 → H¹(G⧸N, M^N) → H¹(G, M) → H¹(N, M)^{G⧸N} → H²(G⧸N, M^N) → H²(G, M)`.
  This sequence is the generator/relation-rank engine of
  [`../ProPGroups/README.md`](../ProPGroups/README.md) (roadmap in preparation); its `𝔽₂`
  instance with `N` the Frattini-type kernel is what presentation theory consumes.
  ⚠ Define `tg` by the explicit lift-and-differentiate cochain formula and prove its two
  compatibilities (with inflation on the right, with restriction on the left) — spectral
  sequences are deliberately out of scope for this roadmap.

### Layer 5: corestriction

For open `U ≤ G` (with `[U.FiniteIndex]` where `G` is not compact); everything by the pinned
transversal formulas.

- **The transversal calculus.** The word `ℓ_u(γ) = (u.out)⁻¹ * γ * ((γ⁻¹ • u).out)` lies in
  `U` and satisfies the 1-cocycle law `ℓ_u(γ) * ℓ_{γ⁻¹ • u}(η) = ℓ_u(γη)` — pure group theory,
  stated for any subgroup (`Suggested.lean` pins both). Continuity of `γ ↦ ℓ_u(γ)` for open
  `U`.
- **Corestriction in degrees `0, 1, 2`.** `cor⁰ = ` the norm/trace `m ↦ ∑ u, u.out • m` on
  invariants; `cor¹`, `cor²` by the pinned sums; cocycles map to cocycles, coboundaries to
  coboundaries, and the maps on `H⁰, H¹, H²` are additive and independent of the transversal
  (⚠ prove independence as a change-of-transversal coboundary identity, not by re-deriving the
  map abstractly — downstream explicit computations depend on the formula, so the formula, not
  an abstraction, is the definition).
- **The identities.** `cor ∘ res = (G : U) • id` in degrees `0, 1, 2` (NSW (1.5.7); Serre,
  *Local Fields* VII §7 Prop. 6; Koch Thm. 3.10); naturality in coefficient maps;
  compatibility with connecting maps (`cor ∘ δ = δ ∘ cor`, NSW (1.5.2)); transitivity
  `cor_V^G = cor_U^G ∘ cor_V^U` for `V ≤ U ≤ G` open. (The full double-coset/Mackey formula
  NSW (1.5.6) is deliberately deferred to the long horizon; nothing downstream needs it.)
- **Annihilation corollaries** (NSW (1.6.1); Brown III (10.1) is the discrete model). For `G`
  profinite, `i ≥ 1`: a class of `Hⁱ(G, M)` killed by restriction to an open `U` is killed by
  `(G : U)`; combined with Layer 3, every element of `Hⁱ(G, M)` is torsion, and
  `Hⁱ(G, M) = 0` for `ℚ`-vector-space coefficients. (The `p`-primary refinement for pro-`p`
  groups belongs to [`../ProPGroups/README.md`](../ProPGroups/README.md); state here the
  general torsion statement and the finite-level annihilation the `(G ⧸ U)`-orders provide.)
- **Convention duty.** Match `kbuzzard/ClassFieldTheory`'s discrete `cores_res` normalization
  (`index • id`, same direction), so the finite-level specializations are interchangeable; if
  their corestriction reaches Mathlib first, Layer 2's bridge must transport ours onto theirs.
  ⚠ Naming collision: at the pin, Mathlib's `GroupHomology/Functoriality.lean` already uses
  "corestriction" for the *covariant functoriality of homology* along a group homomorphism.
  Ours is the classical cohomological transfer (NSW I §5); keep the name `cores`/`corestriction`
  (NSW and ClassFieldTheory usage) but say in the docstring which of the two conventions is
  meant, and never abbreviate to "transfer" (Layer 10's norm is the *multiplicative* transfer).

### Layer 6: induced and coinduced modules, Shapiro's lemma

For profinite `G` and a **closed** subgroup `H ≤ G` (deciding the generality up front: closed,
not just open — the trivial subgroup is the acyclicity case), on discrete `H`-modules `A`.

- **The coinduced module.** `Coind_H^G A` = the locally constant `H`-equivariant maps `G → A`
  (`f (h * g) = h • f g`), with the right-translation `G`-action `(g • f) x = f (x * g)` —
  Milne's `M_*` (ADT Remark 0.11) and Ribes–Zalesskii's `Coind_H^G` (Thm. 6.10.5).
  Prove it is again **discrete** (compactness: a locally constant map off a profinite group is
  uniformly locally constant, so stabilizers are open), functorial, and exact in `A`.
  Adjunction with restriction: `Hom_G(M, Coind_H^G A) ≃ Hom_H(res M, A)` — the continuous
  Frobenius reciprocity, matching the direction of the pin's discrete adjunction.
  ⚠ Terminology trap: NSW writes `Ind_G^H` for this **coinduced** functor and flags the abuse
  only in a footnote (2nd ed., p. 61); when citing NSW (1.6.4) next to a Lean `coind`, cite
  the footnote too, and reserve `ind` for the genuine left adjoint.
- **Shapiro's lemma.** `Hⁱ(G, Coind_H^G A) ≅ Hⁱ(H, A)` for `i = 0, 1, 2` on the explicit model
  (evaluation at `1` one way, the transversal/section construction back; NSW (1.6.4),
  Ribes–Zalesskii Thm. 6.10.5, Koch Thm. 3.9), natural in `A`, compatible with restriction
  and (for open intermediate subgroups) corestriction. The all-degrees canonical statement is
  the refactor-onto milestone; the pin's `coindIso` pins the direction. ⚠ For **open** `H`,
  prove `Ind ≅ Coind` (finite transversal; the pin's discrete `Rep.indCoindIso` is the model)
  and derive the induced-module form; for closed `H` of infinite index only the coinduced
  form is asserted.
- **Acyclicity and dimension shifting.** `Coind_1^G A` (locally constant maps `G → A`) has
  vanishing `Hⁱ` for `i ≥ 1` (Shapiro at `H = 1`); every discrete `M` embeds in an acyclic
  discrete module (`M ↪ Coind_1^G M`); hence dimension shifting
  `Hⁱ⁺¹(G, M) ≅ Hⁱ(G, Coind_1^G M ⧸ M)` for `i ≥ 1` — the induction engine Layer 8 runs on.

### Layer 7: cup products

On the explicit model, relative to an equivariant pairing as pinned; discreteness of `M, N`
makes every cochain-level continuity automatic.

- **The four shapes.** `⌣ : Hᵖ × Hᵍ → Hᵖ⁺ᵍ` for `(p, q) ∈ {(0, 1), (0, 2), (1, 1), (1, 2),
  (2, 0)}` (include `(0, 1)` — it is free and keeps the family closed under the Leibniz
  bookkeeping), each: the pinned cochain formula, cocycle ⌣ cocycle is a cocycle, descent
  through coboundaries, biadditivity by construction.
- **Identities in the range.** Associativity `(a ⌣ b) ⌣ c = a ⌣ (b ⌣ c)` at the cochain level
  wherever both sides land in total degree `≤ 2` (in particular `(0,1,1)`, `(1,1,0)`,
  `(0,0,q)`; Brown V (3.5): associativity holds already on cochains); graded commutativity
  `a ⌣ b = (-1)^{pq} (b ⌣' a)` for `(1,1)`, `(0,q)`, `(2,0)` (NSW (1.4.4), Brown V (3.6)) —
  for `(1, 1)` by the explicit chain homotopy, written out once; the `𝔽₂`/char-2 symmetric
  specialization stated separately (it is the arithmetic workhorse). ⚠ Fix the homotopy
  formula in the file docstring; silent sign drift between the `(1,1)` homotopy and the
  `δ`-compatibility formulas is the classic failure mode here.
- **Compatibilities.** With restriction (`res (a ⌣ b) = res a ⌣ res b`, NSW (1.5.3)(i)); with
  inflation (`inf (a ⌣ b) = inf a ⌣ inf b` over the quotient's pairing, NSW (1.5.3)(iii),
  Milne (0.1.6)); with coefficient maps (naturality in `μ`, NSW (1.4.2)); the **projection
  formula** `cor (res a ⌣ b) = a ⌣ cor b` for open `U` (NSW (1.5.3)(iv), Ribes–Zalesskii
  7.9.6/7.9.7, Brown V (3.8); degrees within the range; the transversal proof); with
  connecting maps (NSW (1.4.3)/(1.4.5)): for a pairing of short exact sequences,
  `δ (a ⌣ b) = a ⌣ δ b` for `a ∈ H⁰` and the
  `δ (a ⌣ b) = δ a ⌣ b + (-1)^p (a ⌣ δ b)`-instances in the range — state exactly the
  low-degree cases, each as its own lemma.
- **The duality-pairing package.** For finite discrete `M`, the evaluation pairing of Layer 0
  composed with the cups gives `Hⁱ(G, Hom(M, N)) × H²⁻ⁱ(G, M) → H²(G, N)` for `i = 0, 1, 2` —
  stated here, consumed as the underlying pairing of local Tate duality by
  [`../LocalFields/README.md`](../LocalFields/README.md).
- **Canonical transport.** Identification with FLT's `ContinuousCohomology.cup` under Layer 2,
  in the four shapes (refactor-onto milestone; FLT's cup has Leibniz but no commutativity or
  associativity — ours supplies those in the range, theirs supplies all-degrees; upstream the
  union, coordinating with its author).

### Layer 8: cohomological dimension

For profinite `G` and a prime `p`; NSW III §3 is the source of record. Nothing upstream
defines `cd` (verified: no Mathlib declaration, no PR, no claim; the
[C1 fields Zulip thread](https://leanprover-community.github.io/archive/stream/116395-maths/topic/C1.20fields.3F.html)
of Aug 2025 wants it and left it on the table).

- **Definitions** (NSW (3.3.1)). `cd_p G ≤ n` iff the `p`-primary component of `Hⁱ(G, M)`
  vanishes for all `i > n` and all discrete **torsion** `G`-modules `M`; `cd G = ⨆ p, cd_p G`;
  strict `scd_p G` with all discrete modules. (State against the all-degrees canonical object;
  the `n ≤ 2` cases — the ones the arithmetic applications use — get explicit-model
  equivalents.)
- **Dévissage** (NSW (3.3.2)). `cd_p G ≤ n` already follows from vanishing of `Hⁿ⁺¹(G, M)`
  for all **finite discrete `p`-primary simple** `M` (colimit + LES + dimension shifting,
  Layers 3, 4, 6); for `G` pro-`p` the single module `𝔽_p` suffices (NSW (3.3.2) final
  clause; Koch Def. 5.1 takes that as the definition) — that refinement lives in
  [`../ProPGroups/README.md`](../ProPGroups/README.md), grounded on this layer.
- **Subgroups.** `cd_p H ≤ cd_p G` for closed `H ≤ G` (NSW (3.3.5), Ribes–Zalesskii
  Thm. 7.3.1; coinduction/Shapiro for the cofinal open case, then the limit argument);
  equality when `H` is open with `(G : H)` prime to `p` (Layer 5's `cor ∘ res`);
  `scd_p ∈ {cd_p, cd_p + 1}` (NSW (3.3.3)). The `p`-Sylow statement `cd_p G = cd_p G_p`
  (NSW (3.3.6)) is stated here but grounds its Sylow input (existence and conjugacy of
  pro-`p` Sylow subgroups, supernatural indices) as an explicitly cited dependency on
  [`../ProPGroups/README.md`](../ProPGroups/README.md).
- **First values.** `cd_p G = 0` iff `Hⁱ(G, M) (p) = 0` in positive degrees for `p`-primary
  `M`, with the free/trivial examples: `cd_p Ẑ = 1` for every `p` (the worked example below),
  and the vanishing `H²(Ẑ, M) = 0` for finite `M`. ⚠ Do not attempt `cd_p G_K` values for
  local fields here — that is [`../LocalFields/README.md`](../LocalFields/README.md)'s
  `cd(G_K) = 2`, resting on this layer plus their duality.

### Layer 9: the Galois interface: Hilbert 90 and Kummer theory

Where the machine meets `Gal`. `K` a field, `K̄` its algebraic (equivalently, for these
statements, separable) closure, `G_K = Gal(K̄/K)` with the Krull topology.

- **Instances.** `G_K` is profinite in the unbundled sense: `CompactSpace`,
  `TotallyDisconnectedSpace` for `Field.absoluteGaloisGroup K` — glue between the pin's
  `[IsGalois k K] → CompactSpace Gal(K/k)` and `absoluteGaloisGroup` (in char 0 by
  `IsGalois`; in general via restriction to the separable closure). The `G_K`-module `K̄^×` is
  **discrete** (every element lies in a finite subextension, so stabilizers are open — the
  Krull-topology form of Layer 0's openness API), as are `μ_n ⊆ K̄^×` and finite subquotients.
- **Profinite Hilbert 90.** `H¹(G_K, K̄^×) = 0` for any Galois extension (NSW (6.2.1);
  multiplicative coefficients via `Additive`): by Layer 3's colimit from the pin's
  finite-level `groupCohomology.hilbert90` (`H1ofAutOnUnitsUnique`), through Layer 2's finite
  bridge. This is the pattern proof that the colimit machinery exists to enable; write it as
  such. ⚠ The pin's `Rep` universe restriction (`k` and `G` in one universe, Zulip Jan 2026,
  tracked in mathlib #33608) touches exactly this bridge — keep the profinite statement
  universe-clean and confine any workaround to the finite-level comparison.
- **The Kummer sequence and isomorphism.** For `n` invertible in `K` (`char K ∤ n`): the
  discrete short exact sequence `1 → μ_n → K̄^× → K̄^× → 1` (n-th power); Layer 4's LES plus
  Hilbert 90 give the **Kummer isomorphism** `K^× / (K^×)^n ≅ H¹(G_K, μ_n)` (NSW, the display
  following (6.2.1), and (6.2.2) for the pairing form), natural in `K` (restriction ↔
  inclusion `K^×/(K^×)^n → L^×/(L^×)^n`, corestriction ↔ the norm — the compatibility square
  [`../LocalFields/README.md`](../LocalFields/README.md) and
  [`../QuadraticFormInvariants/README.md`](../QuadraticFormInvariants/README.md) both consume).
- **The explicit Kummer cocycle.** For `a ∈ K^×` and a chosen `n`-th root `α`, the class of
  `g ↦ g α / α ∈ μ_n` equals the image of `a` under the connecting map — the cocycle-level
  description (continuity = openness of the stabilizer of `α`). Specialize to `n = 2`,
  `μ₂ = {±1} ⊆ K` with trivial action and `𝔽₂ = ZMod 2` written additively: the mod-2 Kummer
  class `[a] ∈ H¹(G_K, 𝔽₂)` with cocycle `g ↦ (0 if g√a = √a else 1)`, the square-class map
  `K^×/(K^×)² ≃ H¹(G_K, 𝔽₂)`, and `[a] ⌣ [b]` as the `𝔽₂`-valued pairing — the objects the
  `gq2` interfaces `kummerClassK` and B11a are phrased in. ⚠ Do not bake `CharZero` in: the
  hypothesis is `IsUnit (n : K)` (plus `NeZero n`), so finite fields of odd characteristic stay
  in scope for `n = 2`.

### Layer 10: the Evens norm

The multiplicative transfer on `𝔽₂`-cohomology for an open subgroup `U ≤ G` of finite index,
in the shape the Evens–Kahn formula consumes. Trivial `𝔽₂`-action throughout.

- **The index-2 explicit form.** For `(G : U) = 2` (so `U` is normal and `G ⧸ U ≅ C₂`), a
  chosen `s ∉ U`, and a continuous homomorphism `α : U → 𝔽₂` (a trivial-action 1-cocycle):
  the Shapiro components `b₁ γ = α γ` for `γ ∈ U`, `b₁ γ = α (γ * s)` otherwise, and
  `b_s γ = b₁ (s⁻¹ * γ)`; the **two-point graph 2-cochain**
  `ν_α (γ, η) = b₁ γ * b_s η` if `γ ∈ U`, and `= b₁ γ * b₁ η + b₁ η * b_s η` otherwise
  (pinned in `Suggested.lean`), its 2-cocycle identity and continuity, and the class
  `N^{Ev}(α) ∈ H²(G, 𝔽₂)`. Independence of the choice of `s` (a coboundary computation).
- **The characterizing identities** (what Evens–Kahn actually uses — Kozlowski Lemma 2.4 in
  cohomological clothing): restriction `res_U N^{Ev}(α) = α ⌣ (s ⋅ α)` (cup with the
  conjugate class); the quadratic expansion
  `N^{Ev}(α + β) - N^{Ev}(α) - N^{Ev}(β) = cor(α ⌣ (s ⋅ β))` with Layer 5's corestriction;
  the degree-1 shadow `cor¹ α = b₁ + b_s` (agreeing with Layer 5's transversal formula at the
  transversal `{1, s}`); and inflation compatibility. These identities are the acceptance
  interface of [`../QuadraticFormInvariants/README.md`](../QuadraticFormInvariants/README.md)'s
  Evens–Kahn layer (the total-Stiefel–Whitney expansion
  `w(Tr ⟨a⟩) = w(Tr ⟨1⟩) · (1 + cor[a] + N^{Ev}[a])` in degrees `≤ 2`); this roadmap owns the
  cohomological operation, that one owns its application to transferred quadratic forms.
- **The abstract norm.** Evens' multiplicative transfer (Evens 1963: the monomial embedding
  `Φ : G → 𝔖_l ≀ U` from a transversal, §§2–3; the norm through the wreath product, §§4–5;
  transitivity/double-coset/multiplicativity, §6 Props. 1–4). Evens' Thm 1 states the
  expansion `𝒩(1 + χ) = 1 + tr(χ) + ⋯ + 𝒩(χ)` for **even-degree** `χ` over a commutative
  `G`-ring — even degree because of signs; over `𝔽₂` the construction gives a norm
  `N : Hᵍ(U, 𝔽₂) → H^{lq}(G, 𝔽₂)` in **every** degree, and that mod-2 all-degree form is the
  target here (it is the one Kozlowski's formula consumes; his Lemma 2.4's proof lives in
  "The transfer in Segal's cohomology", so our development is the self-contained account).
  **Prove the abstract norm specializes to the graph cocycle at index 2, degree 1** — that
  identification is the "related to a standard cohomological construction, not only an ad hoc
  graph cocycle" acceptance criterion, and it is the mathematical content separating this
  layer from a transcription. ⚠ Sequence the explicit form first: the identities above are
  provable directly and unblock the sibling; the wreath construction is the summit of the
  layer, not its gate.

### Long horizon (direction, not this roadmap's gate)

All-degrees explicit inhomogeneous cochains `C(Gⁿ, M)` for locally compact `G` (master's own
TODO); the full Mackey double-coset formula for `res ∘ cor`; the Hochschild–Serre spectral
sequence (the five-term sequence above is deliberately spectral-sequence-free); norms for
general coefficients in even degrees; continuous cochain cohomology for non-discrete
topological modules (`ℤ_p(1)`-coefficients, Iwasawa-theoretic limits) — the right common
generalization with condensed mathematics should be revisited when Mathlib's condensed library
meets group cohomology.

---

## Worked examples (acceptance criteria, keeping the definitions honest)

Discharge these alongside the layers; each catches a specific classic mistake (a vacuous
quotient, a wrong transition direction, a sign slip, a dead pairing).

- **`H¹(ℤ_p, ℤ/pᵏ)` and `H¹(ℤ_p, ℤ)`** (Layer 1; in `Suggested.lean` at the pin): for the
  profinite additive group `ℤ_p`, evaluation at `1` is a bijection from the continuous
  additive homomorphisms `ℤ_p → ℤ/pᵏ` to `ℤ/pᵏ` (so `H¹ ≅ ℤ/pᵏ` under the trivial-action
  characterization), while every continuous homomorphism `ℤ_p → ℤ` is zero (`H¹(ℤ_p, ℤ) = 0`)
  — continuity is load-bearing in both.
- **`Hⁱ(Ẑ, -)` and `cd_p Ẑ = 1`** (Layers 3–5, 8; NSW (1.7.7) and the worked example at NSW
  III p. 173; Serre, *Local Fields* XIII §1 Props. 1–2): `H¹(Ẑ, ℤ/n) ≅ ℤ/n`,
  `H²(Ẑ, M) = 0` for finite (indeed torsion or divisible) `M`, and — via the LES for
  `0 → ℤ → ℚ → ℚ/ℤ → 0` and the torsion corollary killing `Hⁱ(Ẑ, ℚ)` —
  `H²(Ẑ, ℤ) ≅ ℚ/ℤ`. (Build `Ẑ` as the profinite completion of `ℤ`, or state over an
  arbitrary procyclic group with a topological generator; do not hardcode a product over
  primes.)
- **`H²(Gal(𝔽̄_q/𝔽_q), 𝔽̄_q^×) = 0`** (Layers 3, 4, 9 — the summit computation): the Brauer
  group of a finite field vanishes. Route: colimit to finite levels, `H²(Gal(𝔽_{qⁿ}/𝔽_q),
  𝔽_{qⁿ}^×) ≅ 𝔽_q^× / N(𝔽_{qⁿ}^×)` by the pin's finite-cyclic API, and surjectivity of the
  finite-field norm. Exercises every transition map in the tower; a wrong colimit direction
  cannot pass it.
- **`cor ∘ res = (G : U)` on `Ẑ`** (Layer 5): for the open subgroup `nẐ ≤ Ẑ`,
  `cor ∘ res` on `H¹(Ẑ, ℤ/m)` is multiplication by `n` — computed on the explicit cocycles,
  catching both a wrong transversal convention and a wrong normalization.
- **The `C₂` cup and `G_ℝ`** (Layers 7, 9): on `G = C₂` (discrete), the `(1,1)` cup of the
  nontrivial class in `H¹(C₂, 𝔽₂)` with itself is the nontrivial class of `H²(C₂, 𝔽₂)` — the
  raw non-coboundary statement is in `Suggested.lean`. Galois form: for `K = ℝ`
  (`G_ℝ = Gal(ℂ/ℝ) ≅ C₂`), `[-1] ⌣ [-1] ≠ 0` in `H²(G_ℝ, 𝔽₂)` — the smallest instance of
  "the Kummer cup detects non-norms" (`-1` is not a norm from `ℂ`), and the degenerate-pairing
  canary for the B11a-shaped statements.
- **Kummer over `ℚ`** (Layer 9): `H¹(G_ℚ, 𝔽₂) ≅ ℚ^× / (ℚ^×)²`, with `[a]` the explicit
  square-root cocycle — the acceptance form of the Kummer isomorphism plus its cocycle
  description.
- **The index-2 Evens anchor** (Layer 10): for `G = C₄ ⊇ U = C₂` and `α ≠ 0`,
  `N^{Ev}(α)` restricts to the nontrivial class on `U` (equivalently: the central extension
  attached to the universal two-point cocycle is `D₈`, not `C₂ × C₄` or `Q₈`) — the sign/
  convention anchor for the graph cocycle.
- **The duality-pairing shapes** (Layers 0, 7): for finite discrete `M` and `n`-torsion
  coefficients, the three evaluation cup pairings
  `Hⁱ(G, Hom(M, μ)) × H²⁻ⁱ(G, M) → H²(G, μ)`, `i = 0, 1, 2`, exist with their biadditivity
  and naturality — the statement-shape [`../LocalFields/README.md`](../LocalFields/README.md)
  needs to even *state* local Tate duality (its perfectness is theirs to prove).

## Ordering and parallelism

Layer 0 and the Layer 1 complex are the gate for everything. After Layer 1: Layer 2's finite
bridge, Layer 4's exactness, Layer 5's transversal calculus, and Layer 7's cup formulas are
mutually independent lanes (four workers can run in parallel). Layer 3 needs Layers 1–2;
Layer 4's five-term needs Layer 1's conjugation action; Layer 6 needs Layers 1 and 5's
finite-index vocabulary; Layer 8 needs Layers 3–6; Layer 9 needs Layers 2–4 (Hilbert 90:
2, 3; Kummer: 4) plus Layer 7 for the cup interface; Layer 10 needs Layers 5 and 7. The
canonical-facing halves of Layers 2, 3, 4, 6, 7 additionally wait on the toolchain reaching
master's `ContCohomology` (and PRs #41539/#41545) — sequence each as "explicit now,
transport on the bump", never as "wait".

## References

Item numbers below are verified against the editions cited (2026-07-30).

- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed., Springer
  Grundlehren 323 (2008) — the source of record. Ch. I: (1.2.2) the definition via continuous
  homogeneous cochains with the inhomogeneous translation (I §2), (1.2.5) the finite-quotient
  colimit `lim→_U Hⁿ(G/U, A^U) ≅ Hⁿ(G, A)`, (1.3.2) the long exact sequence, I §4 cup
  products ((1.4.1) Leibniz, (1.4.3) `δ`-compatibility, (1.4.4) associativity and graded
  commutativity), I §5 change of group ((1.5.3)(iv) projection formula, (1.5.6) double-coset
  formula, (1.5.7) `cor ∘ res = (G : U)`), (1.6.1) torsionness, (1.6.4) Shapiro (with the
  p. 61 footnote naming its `Ind` as the coinduced functor), (1.6.7) the five-term exact
  sequence, (1.7.7) procyclic computations. Ch. III §3 cohomological dimension: (3.3.1)
  definitions, (3.3.2) the simple-module criterion, (3.3.3) `cd ≤ scd ≤ cd + 1`, (3.3.5)
  closed subgroups, (3.3.6) Sylow. Ch. VI: (6.2.1) Hilbert 90 for arbitrary Galois
  extensions, with the Kummer isomorphism `H¹(G_K, μ_n) ≅ K^×/(K^×)ⁿ` derived on the same
  page and (6.2.2) the pairing form.
- L. Ribes, P. Zalesskii, *Profinite Groups*, 2nd ed., Springer Ergebnisse 40 (2010) —
  Thm. 2.1.3 (open normal subgroups as a fundamental system; `G = lim← G/U`), Def. 6.4.1 and
  Cor. 6.5.6(a) (cohomology and its colimit description), Thm. 6.10.5 (Shapiro, stated for
  `Coind_H^G` by that name), §6.7 (restriction and corestriction), Cor. 7.2.5(a) (five-term),
  §7.1 (cd definitions), Thm. 7.3.1 (closed subgroups), §7.9 (cup products, with
  `Cor(a ∪ Res b) = Cor(a) ∪ b` at 7.9.6/7.9.7).
- J-P. Serre, *Galois Cohomology*, Springer (1997) — Ch. I §§2–4: the compact exposition the
  layer structure follows. (Not among the local reference PDFs; requested.)
- J-P. Serre, *Local Fields*, Springer GTM 67 (1979) — Part Three: Ch. VII (basic facts;
  §5 change of group; §7 Prop. 6 `Cor ∘ Res = n`; §8 transfer), Ch. VIII (finite groups;
  §2 Props. 3–4; §3 cup products), Ch. X §3 (the profinite theory *defined* by the colimit
  over open normal subgroups — the third face of Layer 2/3's triangle), Ch. XIII §1 (the
  cohomology of `Ẑ`: Prop. 1, Prop. 2 `H²(Ẑ, A) = 0` for `A` divisible or torsion).
- L. Evens, "A generalization of the transfer map in the cohomology of groups", Trans. AMS 108
  (1963), 54–65 — §§2–5 the monomial/wreath-product norm; §6 Props. 1–4 (transitivity, double
  coset, multiplicativity); Thm. 1 (p. 63): for `(G : H) = l` and `χ ∈ H^{2r}(H, k)`, `k` a
  commutative `G`-ring, `𝒩(1 + χ) = 1 + tr(χ) + ⋯ + 𝒩(χ)` with lowest terms `1` and the
  ordinary transfer — Layer 10's abstract half and its expansion template.
- A. Kozlowski, "The Evens–Kahn formula for the total Stiefel–Whitney class", Proc. AMS 91
  (1984), 309–313 — Thm. 1.1 (the transfer on the total-class group commuting with `w`) and
  **Lemma 2.4** (the operative index-2 expansion `N(1 + x) = 1 + Σᵢ Sqⁱ(x) t^{k-i}`-form in
  low degrees; its proof defers to his "The transfer in Segal's cohomology", Illinois J.
  Math.) — what Layer 10's explicit form must supply.
- B. Kahn, "Classes de Stiefel–Whitney de formes quadratiques et de représentations
  galoisiennes réelles", Invent. Math. 78 (1984) — the relative Stiefel–Whitney identity
  consuming Layer 10 (owned by `../QuadraticFormInvariants/`).
- H. Koch, *Galois Theory of p-Extensions*, Springer (2002) — Ch. 3 "Cohomology of Profinite
  Groups", built directly on continuous **inhomogeneous** cochains (§3.1 — the textbook
  model of Layer 1): Thm. 3.9 (Shapiro), Thm. 3.10 (`cor ∘ res = (G : H)`), Thm. 3.14
  (inflation–restriction–transgression in degree `n`), Thm. 3.16 (inductive limits),
  §3.9 (cup products); Ch. 5 (cd of pro-`p` groups via `H^n(G, 𝔽_p)`, Def. 5.1) and Ch. 6
  (generator/relation ranks via `H¹`/`H²`) — the `../ProPGroups/` interface.
- J. S. Milne, *Arithmetic Duality Theorems*, 2nd ed. (2006) — Ch. I §0: the continuous-
  cochain conventions (p. 2), cup-product properties (0.1.1)–(0.1.6), Remark 0.11 (Shapiro
  for `M_*`), Remark 0.10 (`Ext` colimits), Prop. 0.15 (conjugation acts trivially) — the
  reference point for the duality-pairing shapes.
- K. S. Brown, *Cohomology of Groups*, Springer GTM 87 (1982) — discrete background: Ch. III
  §9 (the transfer, five constructions), III §10 ((10.1) annihilation by the index), Ch. V §3
  (cup products; (3.5) associativity at the cochain level, (3.6) commutativity, (3.8) the
  transfer formula `cor (res u ⌣ v) = u ⌣ cor v`).

## Provenance and coordination

- **Upstream authors to coordinate with before integrating or upstreaming** (per the root
  README's coordination rule): Richard Hill (`rmhi`; Mathlib `ContCohomology`, PRs #41539/
  #41545, `ctsToDiscrete`), Edison (Yunzhou) Xie (`Whysoserioushah`; Mathlib `ContCohomology`,
  FLT cup products, ClassFieldTheory's July commits), Andrew Yang (Mathlib `ContCohomology`),
  Amelia Livingston (the discrete `groupCohomology` API whose conventions this roadmap pins),
  Kevin Buzzard and Aaron Liu (ClassFieldTheory corestriction), and Joël Riou (whose
  quasi-isomorphism acceptance condition Layer 2 discharges). One person (Xie) currently
  spans three of the four upstream sites — a coordination point and a bus-factor risk;
  register a TauCeti intention and post the layer plan on Zulip before Layer 2 or Layer 7
  work starts, since those are the two places our theorems and in-flight upstream code touch
  the same objects. Demand-side note: FLT's planning threads name continuous cohomology and
  "Galois cohomology of local fields" (blueprint `ch_bestiary` §§13.4–13.9) among its
  blocking definitions — this roadmap plus [`../LocalFields/README.md`](../LocalFields/README.md)
  are upstream of that need.
- **Migration provenance (secondary; the specifications above are the definition of done, the
  sources below are evidence of feasibility and a mining site).** The
  [roed-math/gq2-lean](https://github.com/roed-math/gq2-lean) formalization (Apache-2.0, same
  owner as this worktree) contains sorry-free, axiom-free implementations of most of the
  explicit-model layers, specialized in places to its paper's needs:
  `GQ2/Cohomology.lean` (Layer 1: the complex, compatible pairs, res/inf/coefficient maps —
  conventions already identical to the pin's `IsCocycle₁/₂`); `GQ2/DiscreteModule.lean`
  (Layer 0 openness API); `GQ2/CupProduct.lean` + `GQ2/CupSymmetry.lean` (Layer 7: `(1,1)`,
  `(0,2)`, `(2,0)` cups, char-2 symmetry); `GQ2/Corestriction.lean` +
  `GQ2/CorestrictionCohomology.lean` (Layer 5: the `Quotient.out` transversal calculus, `cor¹`,
  `cor²`, `δ`-compatibility); `GQ2/EvensKahn.lean` (Layer 10: the index-2 graph cocycle and
  its expansion rules); `GQ2/Kummer.lean` + `GQ2/LocalKummer.lean` (Layer 9: the mod-2 Kummer
  cocycle and class map); `GQ2/Transgression.lean` (Layer 4: a cochain-level transgression
  design); `GQ2/Shapiro/` (Layer 6 ledger machinery, index-2-specialized). Migration means
  de-specializing (arbitrary finite index where it fixes 2; arbitrary `n` where it fixes 2;
  closed subgroups where it takes open), renaming to this roadmap's conventions, and
  re-grounding on the canonical comparison — per the root README, improve rather than
  canonize, and credit the source in ported files. Its `docs/cts-cohomology-gap.md` (rewritten
  2026-07-24) is the prior gap analysis this roadmap's audit updates.
- **Independent audit source:** `davidturturean/gq2-lean-turturean` (GPL-3.0-or-later,
  verified) contains an independent low-degree continuous Galois cohomology
  (`Q2Presentation/Local/Cohomology.lean`, `IsLocallyConstant` encoding). **License is
  incompatible with Apache-2.0: use as an independent cross-check of statements only; no code
  transfer.**
- **Design-history note.** The pin's `Algebra/Category/ContinuousCohomology` and master's
  `RepresentationTheory/Homological/ContCohomology` are the same mathematics with the same
  authors; the move (#41144) deleted the old names. Any TauCeti code written against the pin's
  names must treat them as frozen and schedule the rename with the toolchain bump — that is,
  prefer stating explicit-model theorems (stable) and quarantine canonical-facing statements
  in comparison files (volatile).
