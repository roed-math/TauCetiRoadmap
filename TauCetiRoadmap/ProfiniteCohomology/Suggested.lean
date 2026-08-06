import Mathlib

/-!
# Continuous cohomology of profinite groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (the layer-by-layer build plan Layers 0-12, the worked examples, and
the references) is in `README.md`. The pinned Mathlib predates
`Mathlib/RepresentationTheory/Homological/ContCohomology/`, so the canonical continuous
cohomology object is not available here. That is external prerequisite `E0` of the roadmap:
the canonical-facing milestones (Layer 2's comparison isomorphisms, Layer 9's all-degree
additive package and Layer 11's all-bidegree cup product) have **no Lean prototypes here**,
because their statements cannot yet be written down, and the roadmap's honest-`sorry` rule
forbids naming a condition one cannot state. They are mandatory roadmap content all the same.

What is prototyped is pin-expressible: the discrete-module openness API and continuous
sections of profinite quotients (Layer 0), trivial-action `H¹` worked examples through
`ContinuousAddMonoidHom` (Layer 1), the two topological facts the Layer 2 comparison rests on
(discreteness of `C(G, M)` and the compact-open exponential law), the strict finite-level
descent of continuous cocycles and the well-definedness of the transition maps (Layer 3), the
exactness of discrete cochain lifting (Layer 4), the corestriction transversal calculus for a
**variable** transversal, with the representative action that general coefficients force
(Layer 5), the uniform local constancy behind coinduction (Layer 6), two cup-product cocycle
identities and the `C₂` nontriviality anchor (Layer 7), the profinite Galois group of the
separable closure and the general-`n` Kummer cocycle (Layer 8), the order-theoretic shape of
cohomological dimension (Layer 10), and the index-2 Evens graph cocycle with its `C₈` anchor
(Layer 12).

Cocycle identities are spelled with the pinned Mathlib's own `groupCohomology.IsCocycle₁` and
`IsCocycle₂` (or their explicit trivial-action forms where no `SMul` instance is available),
which fixes the conventions of `README.md`.
-/

namespace TauCetiRoadmap.ProfiniteCohomology

/-! ### Layer 0: discrete modules and continuous sections -/

/-- **Layer 0, discrete modules are smooth.** Over a profinite group (compact, totally
disconnected, in the unbundled classes of the roadmap's conventions), every element of a
discrete module is fixed by an open **normal** subgroup: the orbit map factors elementwise
through a finite quotient, so `M = ⋃_U M^U`. This is what the Layer 3 colimit runs on.
(Consume `stabilizer_isOpen`/`continuousSMul_iff_stabilizer_isOpen` and
`exist_openNormalSubgroup_sub_open_nhds_of_one`.) -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] (m : M) :
    ∃ U : OpenNormalSubgroup G, ∀ u ∈ U, u • m = m :=
  sorry

/-- **Layer 0, continuous sections of profinite quotients** (Ribes-Zalesskii Prop. 2.2.2).
For a **closed** subgroup `H` of a profinite group the projection `G → G ⧸ H` has a
continuous section normalized at the identity coset. This is the input that Layer 4's
transgression, the exactness of Layer 6's coinduction, and the inverse map in Layer 6's
Shapiro isomorphism all lift through, and it is stated once for all three. Nothing here is
needed for an **open** subgroup, where the finite transversal `Quotient.out` already
suffices; `Quotient.out` is *not* a substitute for this statement, since it is not continuous
when `H` has infinite index. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (H : Subgroup G) (hH : IsClosed (H : Set G)) :
    ∃ s : G ⧸ H → G, Continuous s ∧ (∀ x : G ⧸ H, QuotientGroup.mk (s x) = x) ∧
      s (QuotientGroup.mk 1) = 1 :=
  sorry

/-! ### Layer 1: the explicit low-degree complex -/

/-- **Layer 1, worked example `H¹(ℤ_p, ℤ/pᵏ) ≅ ℤ/pᵏ`.** Under the trivial-action
characterization, `H¹` of the profinite additive group `ℤ_p` with discrete coefficients
`ℤ/pᵏ` is the group of continuous additive homomorphisms, and evaluation at `1` identifies it
with `ℤ/pᵏ`. Surjectivity is the content: the dense subgroup `ℤ ⊆ ℤ_p` sends `1` anywhere,
and continuity extends the choice. -/
example (p : ℕ) [Fact p.Prime] (k : ℕ) :
    Function.Bijective (fun φ : ContinuousAddMonoidHom ℤ_[p] (ZMod (p ^ k)) ↦ φ 1) :=
  sorry

/-- **Layer 1, worked example `H¹(ℤ_p, ℤ) = 0`.** With discrete torsion-free coefficients
there are no nonzero continuous homomorphisms from a profinite group: the image is a compact,
hence finite, subgroup of `ℤ`. Continuity is what makes the statement true, since the
abstract group `ℤ_p` has many homomorphisms to torsion-free targets. -/
example (p : ℕ) [Fact p.Prime] (φ : ContinuousAddMonoidHom ℤ_[p] ℤ) : φ = 0 :=
  sorry

/-! ### Layer 2: the two topological facts the comparison rests on -/

/-- **Layer 2, the canonical model is discrete in the arithmetic case.** For compact `G` and
discrete `M`, the compact-open topology on `C(G, M)` is discrete: a continuous map into a
discrete space is locally constant, its fibers are a finite clopen partition of `G`, and the
corresponding basic compact-open neighborhood is a singleton. Iterating, every term of the
canonical homogeneous cochain complex `C(G, C(G, …, M))` is discrete, hence so is every
subquotient. This is why the Layer 2 comparison can be stated as an isomorphism of
`TopModuleCat ℤ` objects rather than only of additive groups after forgetting the topology. -/
example {G : Type*} [TopologicalSpace G] [CompactSpace G] {M : Type*} [TopologicalSpace M]
    [DiscreteTopology M] : DiscreteTopology C(G, M) :=
  sorry

/-- **Layer 2, the exponential law is the hypothesis.** `ContinuousMap.curry` from the
uncurried inhomogeneous cochains to the canonical iterated function spaces exists for
arbitrary spaces; it is the **inverse** that needs local compactness
(`ContinuousMap.uncurry` requires `[LocallyCompactSpace Y]`, and `Homeomorph.curry` requires
it on both factors). So the degree-2 comparison of Layer 2 is exactly a local-compactness
statement, which is why it is stated for profinite `G`: a profinite group is compact
Hausdorff, hence locally compact. This is also the reason Mathlib's `ContCohomology` chose
the homogeneous model, and its module TODO names the `n`-ary description "for locally compact
groups". -/
example {G : Type*} [TopologicalSpace G] [LocallyCompactSpace G] {M : Type*}
    [TopologicalSpace M] :
    Function.Bijective (ContinuousMap.curry : C(G × G, M) → C(G, C(G, M))) :=
  sorry

/-! ### Layer 3: descent to finite levels -/

/-- **Layer 3, continuous 1-cocycles descend strictly.** The degree-1 surjectivity half of
the colimit theorem `H¹(G, M) ≅ colim_U H¹(G ⧸ U, M^U)`, stated raw and with **no coboundary
subtracted**: the zero set of a continuous 1-cocycle is an open subgroup, and any open normal
`U` inside it makes the cocycle right-`U`-invariant (so it factors through `G ⧸ U`) and
`U`-fixed-valued (so it lands in `M^U`). The conclusion says exactly that the original
cocycle is the inflation of `F`. The cocycle identity for `F` as a 1-cocycle of `G ⧸ U` on
`M^U` transports along the factorization once Layer 0 has given `M^U` its `G ⧸ U`-action; a
coboundary enters only in the injectivity half of the colimit theorem. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (f : G → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₁ f) :
    ∃ (U : OpenNormalSubgroup G) (F : G ⧸ U.toSubgroup → M),
      (∀ g : G, F (QuotientGroup.mk g) = f g) ∧ ∀ u ∈ U, ∀ x, u • F x = F x :=
  sorry

/-- **Layer 3, continuous 2-cocycles descend strictly.** The degree-2 half, by uniform local
constancy: a continuous map on the **compact** space `G × G` into a discrete module is
constant on `gU × hU` for a single open normal `U`, and its image is finite, so a further
open normal subgroup fixes every value. Compactness, not just total disconnectedness, is what
descends both variables at once. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (f : G × G → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₂ f) :
    ∃ (U : OpenNormalSubgroup G) (F : (G ⧸ U.toSubgroup) × (G ⧸ U.toSubgroup) → M),
      (∀ g h : G, F (QuotientGroup.mk g, QuotientGroup.mk h) = f (g, h)) ∧
        ∀ u ∈ U, ∀ x, u • F x = F x :=
  sorry

/-- **Layer 3, the transition maps of the finite-quotient system.** For open normal `V ≤ U`
the system's arrow runs from the `U`-level to the `V`-level,
`Hⁱ(G ⧸ U, M^U) → Hⁱ(G ⧸ V, M^V)`, which is why the index category is
`(OpenNormalSubgroup G)ᵒᵖ`: Mathlib's `ProfiniteGrp.toFiniteQuotientFunctor` sends `V ≤ U` to
`G ⧸ V → G ⧸ U`, the other way. The arrow is the compatible pair consisting of that quotient
homomorphism and the coefficient inclusion `M^U ↪ M^V`, and the statement below is what makes
that pair well typed: on `M^U` the action of `g` depends only on the class of `g` in `G ⧸ V`
whenever `V ≤ U`. -/
example {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    {U V : Subgroup G} (hVU : V ≤ U) (m : M) (hm : ∀ u ∈ U, u • m = m) {g g' : G}
    (hgg' : g⁻¹ * g' ∈ V) : g • m = g' • m :=
  sorry

/-! ### Layer 4: exactness of cochains -/

/-- **Layer 4, discrete cochain lifting.** The reason short exact sequences of *discrete*
modules induce long exact sequences: a continuous cochain into a discrete quotient lifts to a
continuous cochain along any surjection of discrete modules (compose with any set-theoretic
section; discreteness of the source of the section makes the composite continuous). Stated
for cochains on an arbitrary topological space, degree-agnostically. -/
example {X : Type*} [TopologicalSpace X] {B C : Type*} [AddCommGroup B] [AddCommGroup C]
    [TopologicalSpace B] [TopologicalSpace C] [DiscreteTopology B] [DiscreteTopology C]
    (p : B →+ C) (hp : Function.Surjective p) (f : X → C) (hf : Continuous f) :
    ∃ g : X → B, Continuous g ∧ p ∘ g = f :=
  sorry

/-! ### Layer 5: the corestriction transversal calculus -/

/-- **Layer 5, the transversal word.** For a **variable** transversal `t : G ⧸ U → G` the word
`ℓᵗ_u(γ) = (t u)⁻¹ * γ * t (γ⁻¹ • u)` lands in `U`. The transversal is a variable and not
`Quotient.out` from the start, because independence of the transversal is a theorem of Layer
5 and cannot even be stated otherwise. -/
example {G : Type*} [Group G] (U : Subgroup G) (t : G ⧸ U → G)
    (ht : ∀ x : G ⧸ U, QuotientGroup.mk (t x) = x) (u : G ⧸ U) (γ : G) :
    (t u)⁻¹ * γ * t (γ⁻¹ • u) ∈ U :=
  sorry

/-- **Layer 5, the transversal 1-cocycle law.** `ℓᵗ_u(γ) * ℓᵗ_{γ⁻¹ • u}(η) = ℓᵗ_u(γ * η)`:
pure group theory, with no normality, no finite index, and no condition on `t` at all. This
identity is what makes the degree-2 corestriction sum a cocycle. -/
example {G : Type*} [Group G] (U : Subgroup G) (t : G ⧸ U → G) (u : G ⧸ U) (γ η : G) :
    ((t u)⁻¹ * γ * t (γ⁻¹ • u)) * ((t (γ⁻¹ • u))⁻¹ * η * t (η⁻¹ • γ⁻¹ • u)) =
      (t u)⁻¹ * (γ * η) * t ((γ * η)⁻¹ • u) :=
  sorry

/-- **Layer 5, corestriction in degree 1, with general coefficients.** The corestriction of a
1-cocycle of `U` is `(cor¹_t f) γ = ∑ u, t u • f (ℓᵗ_u γ)`, and the factor `t u •` is forced:
the proof rewrites `t u * ℓᵗ_u(γ) = γ * t (γ⁻¹ • u)` and reindexes, and without the action
the sum is not a cocycle. The `ZMod 2` formulas of `roed-math/gq2-lean` omit the factor only
because the action there is trivial. `f` is asked to satisfy the 1-cocycle law on `U` alone,
which is all the corestriction of a class of `H¹(U, M)` depends on. -/
example {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [Fintype (G ⧸ U)] (t : G ⧸ U → G)
    (ht : ∀ x : G ⧸ U, QuotientGroup.mk (t x) = x)
    (f : G → M) (hf : ∀ a ∈ U, ∀ b ∈ U, f (a * b) = a • f b + f a) :
    groupCohomology.IsCocycle₁ (fun γ : G ↦ ∑ u : G ⧸ U, t u • f ((t u)⁻¹ * γ * t (γ⁻¹ • u))) :=
  sorry

/-- **Layer 5, `cor ∘ res` is the index only after passing to cohomology.** On cochains the
composite differs from `(G : U) • f` by the coboundary of `c = ∑ u, f (t u)`, so the roadmap
states `cor ∘ res = (G : U) • id` on `H⁰`, `H¹` and `H²` and never as a cochain identity in
positive degrees. The analogous degree-2 statement replaces `c` by an explicit continuous
1-cochain. -/
example {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [Fintype (G ⧸ U)] (t : G ⧸ U → G)
    (ht : ∀ x : G ⧸ U, QuotientGroup.mk (t x) = x)
    (f : G → M) (hf : groupCohomology.IsCocycle₁ f) (γ : G) :
    ∑ u : G ⧸ U, t u • f ((t u)⁻¹ * γ * t (γ⁻¹ • u)) =
      U.index • f γ + (γ • (∑ v : G ⧸ U, f (t v)) - ∑ v : G ⧸ U, f (t v)) :=
  sorry

/-! ### Layer 6: coinduction -/

/-- **Layer 6, uniform local constancy.** On a compact topological group a locally constant
function is uniformly locally constant: its stabilizer under right translation is open. This
is why the coinduced module `Coind_H^G A` of locally constant `H`-equivariant maps is again a
*discrete* `G`-module, which the Shapiro layer needs. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    {A : Type*} (f : G → A) (hf : IsLocallyConstant f) :
    IsOpen {g : G | ∀ x : G, f (x * g) = f x} :=
  sorry

/-! ### Layer 7: cup products in low degrees -/

/-- **Layer 7, the `(1,1)` cup cochain is a 2-cocycle.** For a `G`-equivariant biadditive
pairing of discrete modules and continuous 1-cocycles `a, b` (in the pinned Mathlib's
`IsCocycle₁` convention), the cup formula `(a ⌣ b)(g, h) = μ (a g) (g • b h)` is a continuous
2-cochain satisfying `IsCocycle₂`. This is the cochain-level heart of
`cup11 : H¹(G, M) →+ H¹(G, N) →+ H²(G, P)`. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    {M : Type*} [AddCommGroup M] [TopologicalSpace M] [DiscreteTopology M]
    [DistribMulAction G M] [ContinuousSMul G M]
    {N : Type*} [AddCommGroup N] [TopologicalSpace N] [DiscreteTopology N]
    [DistribMulAction G N] [ContinuousSMul G N]
    {P : Type*} [AddCommGroup P] [TopologicalSpace P] [DiscreteTopology P]
    [DistribMulAction G P] [ContinuousSMul G P]
    (μ : M →+ N →+ P) (hμ : ∀ (g : G) (m : M) (n : N), μ (g • m) (g • n) = g • μ m n)
    {a : G → M} {b : G → N} (ha : Continuous a) (hb : Continuous b)
    (hac : groupCohomology.IsCocycle₁ a) (hbc : groupCohomology.IsCocycle₁ b) :
    groupCohomology.IsCocycle₂ (fun q : G × G ↦ μ (a q.1) (q.1 • b q.2)) ∧
      Continuous (fun q : G × G ↦ μ (a q.1) (q.1 • b q.2)) :=
  sorry

/-- **Layer 7, the `(1,0)` cup cochain is a 1-cocycle.** The shape that the roadmap's
associativity instance `(1,1,0)` needs on its right-hand side, and the reason `(1,0)` and
`(0,0)` belong to the six-shape family rather than being dropped as trivial:
`(a ⌣ n)(g) = μ (a g) (g • n)` for an invariant `n`, that is for a class of `H⁰(G, N)`. -/
example {G : Type*} [Group G]
    {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    {N : Type*} [AddCommGroup N] [DistribMulAction G N]
    {P : Type*} [AddCommGroup P] [DistribMulAction G P]
    (μ : M →+ N →+ P) (hμ : ∀ (g : G) (m : M) (n : N), μ (g • m) (g • n) = g • μ m n)
    {a : G → M} (hac : groupCohomology.IsCocycle₁ a) (n : N) (hn : ∀ g : G, g • n = n) :
    groupCohomology.IsCocycle₁ (fun g : G ↦ μ (a g) (g • n)) :=
  sorry

/-- **Layer 7, worked example: the cup is nontrivial on `C₂`.** With trivial action on
`𝔽₂ = ZMod 2`, the cup square of the nontrivial 1-cocycle on `C₂`, the 2-cochain
`(g, h) ↦ g · h` under the identification `C₂ = Multiplicative (ZMod 2)`, is **not** a
trivial-action coboundary `(g, h) ↦ ψ h - ψ (g * h) + ψ g`. It is the test case for a
degenerate pairing: it gives `H¹(C₂, 𝔽₂) ⌣ H¹(C₂, 𝔽₂) ≠ 0`, the `G_ℝ` Kummer computation
`[-1] ⌣ [-1] ≠ 0`, and every B11a-shaped nondegeneracy downstream. -/
example :
    ¬ ∃ ψ : Multiplicative (ZMod 2) → ZMod 2, ∀ g h : Multiplicative (ZMod 2),
        Multiplicative.toAdd g * Multiplicative.toAdd h = ψ h - ψ (g * h) + ψ g :=
  sorry

/-! ### Layer 8: the Galois interface -/

/-- **Layer 8, the coefficient field is the separable closure.** Mathlib defines
`Field.absoluteGaloisGroup K` as the automorphisms of `AlgebraicClosure K`. For imperfect `K`
the fixed field of that group is the purely inseparable closure of `K`, not `K`, so the
invariants of the units of the algebraic closure are not `Kˣ` and the Kummer sequence would
have the wrong left-hand term. The roadmap uses `SeparableClosure K` throughout, and this is
the comparison that lets the Mathlib name be kept: restriction to the separable closure is an
isomorphism of topological groups. Injectivity comes from
`separableClosure.isPurelyInseparable` with `instSubsingletonAlgHomOfIsPurelyInseparable`,
surjectivity from `AlgEquiv.restrictNormalHom_surjective`; what is left is that both
directions are continuous for the Krull topologies. -/
example (K : Type*) [Field K] :
    ∃ e : Field.absoluteGaloisGroup K ≃* (SeparableClosure K ≃ₐ[K] SeparableClosure K),
      Continuous e ∧ Continuous e.symm :=
  sorry

/-- **Layer 8, the Kummer cocycle for general `n`.** Assume `n` invertible in `K`. For
`a ∈ Kˣ` with a chosen `n`-th root `r` in the separable closure (which exists because
`Xⁿ - a` is separable when `n` is invertible, and `SeparableClosure K` is separably closed),
the map `κ_a(g) = g r / r` takes values in `μₙ`, is a **multiplicative** 1-cocycle for the
natural, in general nontrivial, action of `G_K` on `μₙ`, and is locally constant for the
Krull topology because the stabilizer of `r` is open. Its class is the image of `a` under the
connecting map of `1 → μₙ → (Kˢ)ˣ → (Kˢ)ˣ → 1`, and the resulting map induces the Kummer
isomorphism `Kˣ ⧸ (Kˣ)ⁿ ≅ H¹(G_K, μₙ)`. -/
example (K : Type*) [Field K] (n : ℕ) [NeZero n] (hn : IsUnit (n : K)) (a : Kˣ)
    (r : SeparableClosure K)
    (hr : r ^ n = algebraMap K (SeparableClosure K) (a : K)) :
    (∀ g : SeparableClosure K ≃ₐ[K] SeparableClosure K, (g r / r) ^ n = 1) ∧
      (∀ g h : SeparableClosure K ≃ₐ[K] SeparableClosure K,
        (g * h) r / r = g (h r / r) * (g r / r)) ∧
      IsLocallyConstant (fun g : SeparableClosure K ≃ₐ[K] SeparableClosure K ↦ g r / r) :=
  sorry

/-- **Layer 8, the Kummer class does not depend on the chosen root.** Two `n`-th roots of the
same `a` differ by an element of `μₙ`, and the two cocycles differ by the coboundary of that
element. Without this the connecting map is not well defined on `Kˣ`. -/
example (K : Type*) [Field K] (n : ℕ) [NeZero n] (a : Kˣ) (r r' : SeparableClosure K)
    (hr : r ^ n = algebraMap K (SeparableClosure K) (a : K))
    (hr' : r' ^ n = algebraMap K (SeparableClosure K) (a : K)) :
    ∃ ζ : SeparableClosure K, ζ ^ n = 1 ∧ r' = ζ * r ∧
      ∀ g : SeparableClosure K ≃ₐ[K] SeparableClosure K,
        g r' / r' = (g ζ / ζ) * (g r / r) :=
  sorry

/-! ### Layer 10: cohomological dimension -/

/-- **Layer 10, the shape of `cd_p`.** The roadmap defines cohomological dimension from a
`Prop`-valued predicate `CohomologicalDimensionLE p G n` on `n : ℕ` and only then takes an
infimum, with codomain `ℕ∞` so that "infinite cohomological dimension" is `⊤` rather than an
absent value. The order-theoretic content of that definition, and the reason it deserves to
be made once, is the statement below: for an upward-closed predicate the infimum in `ℕ∞`
inverts the predicate, and the empty case gives `⊤` because `sInf ∅ = ⊤`. Instantiating `P`
at the vanishing predicate of Layer 9 gives `cd_p G ≤ n ↔ CohomologicalDimensionLE p G n`,
and the same shape serves `cd` and `scd_p`. -/
example (P : ℕ → Prop) (hP : ∀ m n : ℕ, m ≤ n → P m → P n) (n : ℕ) :
    sInf {m : ℕ∞ | ∃ k : ℕ, m = (k : ℕ∞) ∧ P k} ≤ (n : ℕ∞) ↔ P n :=
  sorry

/-! ### Layer 12: the Evens norm at index 2 -/

open scoped Classical in
/-- **Layer 12, a degree-1 class of an open subgroup, extended by zero.** `α` is a genuine
continuous homomorphism on the subgroup, that is a trivial-action 1-cocycle of `U`; this is
its extension by zero to `G`, from which the Shapiro components are built. -/
private noncomputable def evensExtend {G : Type*} [Group G] (U : Subgroup G)
    (α : U →* Multiplicative (ZMod 2)) : G → ZMod 2 :=
  fun γ ↦ if h : γ ∈ U then Multiplicative.toAdd (α ⟨γ, h⟩) else 0

open scoped Classical in
/-- **Layer 12, the two-point graph 2-cochain.** With `(G : U) = 2` and `s ∉ U`, the Shapiro
components are `b₁ γ = α γ` for `γ ∈ U` and `α (γ * s)` otherwise, and `b_s γ = b₁ (s⁻¹ γ)`;
the graph cochain is

`ν (γ, η) = b₁ γ * b_s η` if `γ ∈ U`, and `b₁ γ * b₁ η + b₁ η * b_s η` otherwise.

Its class is the index-2 Evens norm `N^{Ev}(α) ∈ H²(G, 𝔽₂)`. The definition is given here
rather than passed as an arbitrary function with side conditions, so that the statements
below are about this cochain and not about anything satisfying its equations. -/
private noncomputable def evensGraphCochain {G : Type*} [Group G] (U : Subgroup G) (s : G)
    (α : U →* Multiplicative (ZMod 2)) : G × G → ZMod 2 :=
  let b₁ : G → ZMod 2 := fun γ ↦
    if γ ∈ U then evensExtend U α γ else evensExtend U α (γ * s)
  let bs : G → ZMod 2 := fun γ ↦ b₁ (s⁻¹ * γ)
  fun q ↦ if q.1 ∈ U then b₁ q.1 * bs q.2 else b₁ q.1 * b₁ q.2 + b₁ q.2 * bs q.2

/-- **Layer 12, the graph cochain is a continuous 2-cocycle.** Continuity belongs in the
conclusion: an open subgroup is clopen, so the case split is continuous, and `α` is
continuous by hypothesis. The 2-cocycle identity is the trivial-action form of
`groupCohomology.IsCocycle₂`. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2) (s : G) (hs : s ∉ U)
    (α : U.toSubgroup →* Multiplicative (ZMod 2)) (hα : Continuous α) :
    Continuous (evensGraphCochain U.toSubgroup s α) ∧
      ∀ g h j : G,
        evensGraphCochain U.toSubgroup s α (g * h, j) + evensGraphCochain U.toSubgroup s α (g, h) =
          evensGraphCochain U.toSubgroup s α (h, j) +
            evensGraphCochain U.toSubgroup s α (g, h * j) :=
  sorry

/-- **Layer 12, the class does not depend on the chosen `s`.** Two elements outside an
index-2 subgroup give graph cochains differing by an explicit continuous coboundary, so the
Evens norm is a well-defined map to `H²(G, 𝔽₂)`. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2) (s s' : G) (hs : s ∉ U) (hs' : s' ∉ U)
    (α : U.toSubgroup →* Multiplicative (ZMod 2)) (hα : Continuous α) :
    ∃ ψ : G → ZMod 2, Continuous ψ ∧ ∀ g h : G,
      evensGraphCochain U.toSubgroup s' α (g, h) - evensGraphCochain U.toSubgroup s α (g, h) =
        ψ h - ψ (g * h) + ψ g :=
  sorry

/-- **Layer 12, the `C₈` anchor.** A class of `H²(C₄, 𝔽₂)` with trivial coefficients
classifies a **central** extension of `C₄` by `C₂`. Since the quotient is cyclic the
extension is abelian (Mathlib's `commutative_of_cyclic_center_quotient`), so it is `C₈` or
`C₂ × C₄` and no nonabelian group of order 8 can occur. The two are told apart by a lift `x`
of a generator: `x ^ 4` always lies in the kernel, and it is the nontrivial kernel element
exactly when `x` has order 8, that is exactly when the class is nonzero. For `G = C₄` and
`U = C₂` the Evens norm of a nonzero `α` restricts to the nonzero square on `U`, so the class
is nonzero and the extension is `C₈`. This fixes the sign and normalization conventions of
the graph cocycle. -/
example {E : Type*} [Group E] (π : E →* Multiplicative (ZMod 4))
    (hπ : Function.Surjective π) (hker : π.ker ≤ Subgroup.center E)
    (hcard : Nat.card π.ker = 2) (x : E) (hx : π x = Multiplicative.ofAdd 1) :
    (∀ a b : E, a * b = b * a) ∧ x ^ 4 ∈ π.ker ∧ (orderOf x = 8 ↔ x ^ 4 ≠ 1) :=
  sorry

end TauCetiRoadmap.ProfiniteCohomology
