import Mathlib

/-!
# Continuous cohomology of profinite groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (the layer-by-layer build plan Layers 0–10, the worked examples, and
the references) is in `README.md`. The pinned Mathlib predates
`Mathlib/RepresentationTheory/Homological/ContCohomology/` — the canonical continuous
cohomology lives there only on current master — so the canonical-facing milestones (Layer 2's
comparison isomorphisms and the canonical halves of Layers 3–7) have **no Lean prototypes
here**; per the roadmap they stay prose-only until the toolchain bump. What is prototyped is
pin-expressible: the discrete-module openness API (Layer 0), trivial-action `H¹` worked
examples stated through `ContinuousAddMonoidHom` (Layer 1), the finite-level descent of
continuous 1-cocycles (Layer 3), the exactness of discrete cochain lifting (Layer 4), the
corestriction transversal calculus (Layer 5), the uniform local constancy behind coinduction
(Layer 6), the `(1,1)`-cup cocycle identity and its `C₂` nontriviality anchor (Layer 7), the
profinite instances for absolute Galois groups and the mod-2 Kummer cocycle (Layer 9), and
the index-2 Evens graph cocycle (Layer 10). Cocycle identities are spelled with the pinned
Mathlib's own `groupCohomology.IsCocycle₁`/`IsCocycle₂` (or their explicit trivial-action
forms where no `SMul` instance exists), pinning the conventions of `README.md`.
-/

namespace TauCetiRoadmap.ProfiniteCohomology

/-- **Layer 0, discrete modules are smooth.** Over a profinite group (compact, totally
disconnected — the unbundled classes of the roadmap's conventions), every element of a
discrete module is fixed by an open **normal** subgroup: the orbit map factors through a
finite quotient elementwise, so `M = ⋃_U M^U`. This is the smallness fact under the Layer 3
colimit. (Consume `stabilizer_isOpen`/`continuousSMul_iff_stabilizer_isOpen` and
`exist_openNormalSubgroup_sub_open_nhds_of_one`.) -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] (m : M) :
    ∃ U : OpenNormalSubgroup G, ∀ u ∈ U, u • m = m :=
  sorry

/-- **Layer 1, worked example `H¹(ℤ_p, ℤ/pᵏ) ≅ ℤ/pᵏ`.** Under the trivial-action
characterization, `H¹` of the profinite (additive) group `ℤ_p` with discrete coefficients
`ℤ/pᵏ` is the group of continuous additive homomorphisms, and evaluation at `1` identifies it
with `ℤ/pᵏ`. Surjectivity is the content: the dense subgroup `ℤ ⊆ ℤ_p` sends `1` anywhere,
and continuity extends the choice. -/
example (p : ℕ) [Fact p.Prime] (k : ℕ) :
    Function.Bijective (fun φ : ContinuousAddMonoidHom ℤ_[p] (ZMod (p ^ k)) ↦ φ 1) :=
  sorry

/-- **Layer 1, worked example `H¹(ℤ_p, ℤ) = 0`.** With discrete torsion-free coefficients
there are no nonzero continuous homomorphisms from a profinite group: the image is a compact,
hence finite, subgroup of `ℤ`. Continuity is load-bearing — the abstract group `ℤ_p` has many
homomorphisms to `ℤ`-free targets. -/
example (p : ℕ) [Fact p.Prime] (φ : ContinuousAddMonoidHom ℤ_[p] ℤ) : φ = 0 :=
  sorry

/-- **Layer 3, continuous 1-cocycles descend to a finite level.** The degree-1 surjectivity
half of the colimit theorem `H¹(G, M) ≅ colim_U H¹(G ⧸ U, M^U)`, stated raw: after
subtracting the coboundary of some `m : M`, a continuous 1-cocycle (the pinned Mathlib's
`groupCohomology.IsCocycle₁`, continuity added) is right-`U`-invariant and `U`-fixed-valued
for some open normal `U` — i.e. it is the inflation of a 1-cocycle of the finite group
`G ⧸ U` valued in `M^U`. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (f : G → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₁ f) :
    ∃ (U : OpenNormalSubgroup G) (m : M),
      (∀ g : G, ∀ u ∈ U, f (g * u) - ((g * u) • m - m) = f g - (g • m - m)) ∧
        ∀ g : G, ∀ u ∈ U, u • (f g - (g • m - m)) = f g - (g • m - m) :=
  sorry

/-- **Layer 4, discrete cochain lifting.** The reason short exact sequences of *discrete*
modules induce long exact sequences: a continuous cochain into a discrete quotient lifts to a
continuous cochain along any surjection of discrete modules (compose with any set-section —
discreteness of the source of the section makes the composite continuous). Stated for
cochains on an arbitrary topological space, degree-agnostically. -/
example {X : Type*} [TopologicalSpace X] {B C : Type*} [AddCommGroup B] [AddCommGroup C]
    [TopologicalSpace B] [TopologicalSpace C] [DiscreteTopology B] [DiscreteTopology C]
    (p : B →+ C) (hp : Function.Surjective p) (f : X → C) (hf : Continuous f) :
    ∃ g : X → B, Continuous g ∧ p ∘ g = f :=
  sorry

/-- **Layer 5, the corestriction transversal word.** With the transversal pinned to
`Quotient.out`, the word `ℓ_u(γ) = (u.out)⁻¹ * γ * ((γ⁻¹ • u).out)` lands in `U` — the
degree-wise ingredient of the pinned corestriction formulas
`(cor f) γ = ∑ u, f (ℓ_u γ)` and `(cor f) (γ, η) = ∑ u, f (ℓ_u γ, ℓ_{γ⁻¹ • u} η)`. -/
example {G : Type*} [Group G] (U : Subgroup G) (u : G ⧸ U) (γ : G) :
    (Quotient.out u)⁻¹ * γ * Quotient.out (γ⁻¹ • u) ∈ U :=
  sorry

/-- **Layer 5, the transversal 1-cocycle law.** `ℓ_u(γ) * ℓ_{γ⁻¹ • u}(η) = ℓ_u(γ * η)` —
pure group theory, no normality, no finite index. This identity is why the degree-2
corestriction cochain sums to a cocycle and why `cor ∘ res = (G : U)` comes out on the nose.
-/
example {G : Type*} [Group G] (U : Subgroup G) (u : G ⧸ U) (γ η : G) :
    ((Quotient.out u)⁻¹ * γ * Quotient.out (γ⁻¹ • u)) *
        ((Quotient.out (γ⁻¹ • u))⁻¹ * η * Quotient.out (η⁻¹ • γ⁻¹ • u)) =
      (Quotient.out u)⁻¹ * (γ * η) * Quotient.out ((γ * η)⁻¹ • u) :=
  sorry

/-- **Layer 6, uniform local constancy.** On a compact topological group, a locally constant
function is uniformly locally constant: its stabilizer under right translation is open. This
is why the coinduced module `Coind_H^G A` of locally constant `H`-equivariant maps is again a
*discrete* `G`-module, the load-bearing fact of the Shapiro layer. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    {A : Type*} (f : G → A) (hf : IsLocallyConstant f) :
    IsOpen {g : G | ∀ x : G, f (x * g) = f x} :=
  sorry

/-- **Layer 7, the `(1,1)`-cup cochain is a 2-cocycle.** For a `G`-equivariant biadditive
pairing of discrete modules and continuous 1-cocycles `a, b` (in the pinned Mathlib's
`IsCocycle₁` convention), the pinned cup formula `(a ⌣ b)(g, h) = μ (a g) (g • b h)` is a
continuous 2-cochain satisfying the pinned Mathlib's `IsCocycle₂` — the cochain-level heart
of `cup11 : H¹(G, M) →+ H¹(G, N) →+ H²(G, P)`. -/
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

/-- **Layer 7, worked example: the cup is nontrivial on `C₂`.** With trivial action on
`𝔽₂ = ZMod 2`, the cup square of the nontrivial 1-cocycle on `C₂` — the 2-cochain
`(g, h) ↦ g · h` under the identification `C₂ = Multiplicative (ZMod 2)` — is **not** a
trivial-action coboundary `(g, h) ↦ ψ h - ψ (g * h) + ψ g`. This is the degenerate-pairing
canary: it seeds `H¹(C₂, 𝔽₂) ⌣ H¹(C₂, 𝔽₂) ≠ 0`, the `G_ℝ` Kummer computation
`[-1] ⌣ [-1] ≠ 0`, and every B11a-shaped nondegeneracy downstream. -/
example :
    ¬ ∃ ψ : Multiplicative (ZMod 2) → ZMod 2, ∀ g h : Multiplicative (ZMod 2),
        Multiplicative.toAdd g * Multiplicative.toAdd h = ψ h - ψ (g * h) + ψ g :=
  sorry

/-- **Layer 9, absolute Galois groups are compact.** The Krull topology makes
`Gal(K̄/K) = Field.absoluteGaloisGroup K` a profinite group in the unbundled sense; this is
the compactness half, the glue between the pinned `[IsGalois k K] → CompactSpace Gal(K/k)`
and `absoluteGaloisGroup` (through the separable closure in positive characteristic). -/
example (K : Type*) [Field K] : CompactSpace (Field.absoluteGaloisGroup K) :=
  sorry

/-- **Layer 9, absolute Galois groups are totally disconnected.** The other half of
profiniteness for `Field.absoluteGaloisGroup K` (the pinned Mathlib has total separatedness
of Krull topologies over integral extensions; this packages it for the derived instance). -/
example (K : Type*) [Field K] : TotallyDisconnectedSpace (Field.absoluteGaloisGroup K) :=
  sorry

open scoped Classical in
/-- **Layer 9, the mod-2 Kummer cocycle.** Assume `2` is invertible in `K`. For
`a ∈ K^×` with chosen square root `r ∈ K̄`,
the sign cocycle `κ_a(g) = 0` if `g r = r`, else `1`, valued in `𝔽₂ = ZMod 2` with trivial
action: it is continuous for the Krull topology (the stabilizer of `r` is open) and additive
(the trivial-action 1-cocycle identity). Its class is the Kummer class
`[a] ∈ H¹(G_K, 𝔽₂)`, the image of `a` under the connecting map of `1 → μ₂ → K̄^× → K̄^× → 1`,
and `K^×/(K^×)² ≃ H¹(G_K, 𝔽₂)` in the Layer 9 Kummer isomorphism. -/
example (K : Type*) [Field K] (h2 : IsUnit (2 : K)) (a : Kˣ) (r : AlgebraicClosure K)
    (hr : r ^ 2 = algebraMap K (AlgebraicClosure K) (a : K)) :
    Continuous (fun g : AlgebraicClosure K ≃ₐ[K] AlgebraicClosure K ↦
        if g r = r then (0 : ZMod 2) else 1) ∧
      ∀ g h : AlgebraicClosure K ≃ₐ[K] AlgebraicClosure K,
        (if (g * h) r = r then (0 : ZMod 2) else 1) =
          (if g r = r then (0 : ZMod 2) else 1) + if h r = r then (0 : ZMod 2) else 1 :=
  sorry

open scoped Classical in
/-- **Layer 10, the index-2 Evens graph cocycle.** For an index-2 subgroup `U`, a chosen
`s ∉ U`, and `α` additive on `U` (a trivial-action 1-cocycle of `U`), the Shapiro components
are `b₁ γ = α γ` for `γ ∈ U` and `α (γ * s)` otherwise, and `b_s γ = b₁ (s⁻¹ * γ)`; the
two-point graph 2-cochain

`ν (γ, η) = b₁ γ * b_s η` if `γ ∈ U`, and `b₁ γ * b₁ η + b₁ η * b_s η` otherwise

satisfies the trivial-action 2-cocycle identity. Its class is the index-2 Evens norm
`N^{Ev}(α) ∈ H²(G, 𝔽₂)`; the degree-1 corestriction is the shadow `cor α = b₁ + b_s`. The
identification of this cocycle with Evens' wreath-product norm is the Layer 10 summit. -/
example {G : Type*} [Group G] (U : Subgroup G) (hU : U.index = 2) (s : G) (hs : s ∉ U)
    (α b1 bs : G → ZMod 2) (hα : ∀ u v : G, u ∈ U → v ∈ U → α (u * v) = α u + α v)
    (hb1 : ∀ γ : G, b1 γ = if γ ∈ U then α γ else α (γ * s))
    (hbs : ∀ γ : G, bs γ = b1 (s⁻¹ * γ)) (ν : G × G → ZMod 2)
    (hν : ∀ q : G × G,
      ν q = if q.1 ∈ U then b1 q.1 * bs q.2 else b1 q.1 * b1 q.2 + b1 q.2 * bs q.2) :
    ∀ g h j : G, ν (g * h, j) + ν (g, h) = ν (h, j) + ν (g, h * j) :=
  sorry

end TauCetiRoadmap.ProfiniteCohomology
