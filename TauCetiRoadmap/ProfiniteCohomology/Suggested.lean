import Mathlib

/-!
# Continuous cohomology of profinite groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (the layer-by-layer build plan Layers 0-13, the worked examples, and
the references) is in `README.md`. The canonical continuous cohomology object is available at
the pin under its former name,
`continuousCohomology R G n : Action (TopModuleCat R) G ⥤ TopModuleCat R`, together with the
complex it is the homology of and the degree-0 computation. Mathlib master has since rebuilt
the same object on a category it calls `TopRep k G` and added functoriality in compatible
pairs, which the pin does not have. So `TopRep` below is an abbreviation for the pin's
category, Layer 1 states the missing functoriality against it, and the canonical-facing
milestones of Layers 3, 10 and 12 are stated against those declarations and nothing else.
Adopting Mathlib's own version later is a rename and a deletion.

What is prototyped: the discrete-module openness API, the invariant coefficients `M^U` with their
`G ⧸ U`-action, and continuous sections of profinite quotients (Layer 0); the canonical carrier,
its compatible-pair functoriality, restriction, and the dictionary out of the unbundled classes
(Layer 1); trivial-action `H¹` worked examples through `ContinuousAddMonoidHom` (Layer 2); the two
topological facts the Layer 3 comparison rests on (discreteness of `C(G, M)` and the compact-open
exponential law); the strict finite-level descent of continuous cocycles and the whole transition
package of the finite-quotient system, quotient map, coefficient inclusion, compatible pair,
transition map and its two functor laws (Layer 4); the exactness of discrete cochain lifting
(Layer 5); the corestriction transversal calculus for a **variable** transversal, with the
representative action that general coefficients force (Layer 6); the uniform local constancy
behind coinduction (Layer 7); two cup-product cocycle identities and the `C₂` nontriviality anchor
(Layer 8); the profinite Galois group of the separable closure, the roots of unity and power
classes, and the general-`n` Kummer cocycle (Layer 9); the order-theoretic wrapper behind
cohomological dimension (Layer 11); and the index-2 Evens graph cocycle with its `C₈` anchor
(Layer 13).

Two descriptions of the coefficients appear, as `README.md` §3 fixes them. Statements about
explicit cochains are written against the unbundled classes `[AddCommGroup M]
[DistribMulAction G M]`, with `Invariants U M` for `M^U`; statements about cohomology objects
and the arrows between them are written against Mathlib's `Rep k G`, with
`Rep.quotientToInvariants`. Layer 0's categorical dictionary identifies the two.

Cocycle identities are spelled with the pinned Mathlib's own `groupCohomology.IsCocycle₁` and
`IsCocycle₂` (or their explicit trivial-action forms where no `SMul` instance is available),
which fixes the conventions of `README.md`.
-/

universe u

namespace TauCetiRoadmap.ProfiniteCohomology

/-! ### Layer 0: discrete modules, invariant coefficients, and continuous sections -/

/-- **Layer 0, every element of a discrete module has an open stabilizer.** Over a profinite
group (compact, totally disconnected, in the unbundled classes of the roadmap's conventions),
every element of a discrete module is fixed by an open **normal** subgroup: the orbit map
factors elementwise
through a finite quotient, so `M = ⋃_U M^U`. The Layer 4 colimit uses that union.
(Consume `stabilizer_isOpen`/`continuousSMul_iff_stabilizer_isOpen` and
`exist_openNormalSubgroup_sub_open_nhds_of_one`.) -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] (m : M) :
    ∃ U : OpenNormalSubgroup G, ∀ u ∈ U, u • m = m :=
  sorry

/-- **Layer 0, the invariant coefficients `M^U`.** The coefficient system of the finite-level
tower, as an additive subgroup of `M`. It is written for an arbitrary subgroup; the two
actions below need `U` normal. -/
def Invariants {G : Type*} [Group G] (U : Subgroup G) (M : Type*) [AddCommGroup M]
    [DistribMulAction G M] : AddSubgroup M where
  carrier := {m | ∀ u ∈ U, u • m = m}
  add_mem' {a b} ha hb u hu := by
    simp only [Set.mem_setOf_eq] at *
    rw [smul_add, ha u hu, hb u hu]
  zero_mem' u _ := smul_zero u
  neg_mem' {a} ha u hu := by
    simp only [Set.mem_setOf_eq] at *
    rw [smul_neg, ha u hu]

/-- **Layer 0, `G` acts on `M^U` for normal `U`.** The subgroup `M^U` is `G`-stable because
`u • (g • m) = g • ((g⁻¹ u g) • m)` and `g⁻¹ u g` lies in `U`. -/
instance {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [U.Normal] : DistribMulAction G (Invariants U M) where
  smul g m := ⟨g • (m : M), by
    intro u hu
    have h : (g⁻¹ * u * g) • (m : M) = m := m.2 _ (Subgroup.Normal.conj_mem' ‹_› u hu g)
    calc u • g • (m : M) = (u * g) • (m : M) := (mul_smul _ _ _).symm
      _ = (g * (g⁻¹ * u * g)) • (m : M) := by congr 1; group
      _ = g • ((g⁻¹ * u * g) • (m : M)) := mul_smul _ _ _
      _ = g • (m : M) := by rw [h]⟩
  one_smul m := Subtype.ext (one_smul G (m : M))
  mul_smul g h m := Subtype.ext (mul_smul g h (m : M))
  smul_zero g := Subtype.ext (smul_zero g)
  smul_add g m n := Subtype.ext (smul_add g (m : M) (n : M))

/-- **Layer 0, `U` acts trivially on `M^U`, so the action descends to `G ⧸ U`.** This is the
action that makes the finite-level cocycle statements of Layer 4 well typed. -/
instance {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [U.Normal] : MulAction (G ⧸ U) (Invariants U M) :=
  MulAction.ofEndHom <| QuotientGroup.lift U
    (MulAction.toEndHom : G →* Function.End (Invariants U M))
    (fun g hg => funext fun a => Subtype.ext (a.2 g hg))

instance {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [U.Normal] : DistribMulAction (G ⧸ U) (Invariants U M) where
  smul_zero q := by
    induction q using QuotientGroup.induction_on with | _ g => exact smul_zero g
  smul_add q a b := by
    induction q using QuotientGroup.induction_on with | _ g => exact smul_add g a b

/-- **Layer 0, continuous sections of profinite quotients** (Ribes-Zalesskii Prop. 2.2.2).
For a **closed** subgroup `H` of a profinite group the projection `G → G ⧸ H` has a
continuous section normalized at the identity coset. This is the input that Layer 5's
transgression, the exactness of Layer 7's coinduction, and the inverse map in Layer 7's
Shapiro isomorphism all lift through, and it is stated once for all three. Nothing here is
needed for an **open** subgroup, where the finite transversal `Quotient.out` already
suffices; `Quotient.out` is *not* a substitute for this statement, since it is not continuous
when `H` has infinite index. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (H : Subgroup G) (hH : IsClosed (H : Set G)) :
    ∃ s : G ⧸ H → G, Continuous s ∧ (∀ x : G ⧸ H, QuotientGroup.mk (s x) = x) ∧
      s (QuotientGroup.mk 1) = 1 :=
  sorry

/-- **Layer 0, the internal hom with its conjugation action.** For discrete `M` and `N` the
additive homomorphisms `M →+ N` carry `(g • φ) m = g • φ (g⁻¹ • m)`, and for **finite** `M` this
is again a discrete `G`-module. Evaluation is then a `G`-equivariant biadditive pairing, which is
the pairing the duality package of Layer 8 is an instance of. -/
def homAction {G : Type*} [Group G] {M N : Type*} [AddCommGroup M] [AddCommGroup N]
    [DistribMulAction G M] [DistribMulAction G N] (g : G) (φ : M →+ N) : M →+ N :=
  (DistribSMul.toAddMonoidHom N g).comp (φ.comp (DistribSMul.toAddMonoidHom M g⁻¹))

/-- **Layer 0, evaluation is equivariant.** The statement that makes the duality cup pairings of
Layer 8 well typed, and the one the Local Fields roadmap names when it states local Tate duality.
It is proved rather than assumed, because it is what fixes the sign of the conjugation action. -/
example {G : Type*} [Group G] {M N : Type*} [AddCommGroup M] [AddCommGroup N]
    [DistribMulAction G M] [DistribMulAction G N] (g : G) (φ : M →+ N) (m : M) :
    homAction g φ (g • m) = g • φ m := by
  simp [homAction, inv_smul_smul]

/-! ### Layer 1: the canonical carrier and its functoriality -/

open CategoryTheory in
/-- **Layer 1, the canonical carrier.** Mathlib master calls this category `TopRep R G`. At the
pin it is `Action (TopModuleCat R) G`, and `continuousCohomology R G n` is a functor out of it.
Every canonical-facing statement in the roadmap is written against this abbreviation, so that
adopting master's own `TopRep` later is a rename. -/
abbrev TopRep (R : Type u) [CommRing R] [TopologicalSpace R]
    (G : Type u) [Group G] [TopologicalSpace G] : Type (u + 1) :=
  Action (TopModuleCat.{u} R) G

section Carrier

open CategoryTheory

variable (R : Type u) [CommRing R] [TopologicalSpace R]
  {G H : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [Group H] [TopologicalSpace H] [IsTopologicalGroup H]

/-- **Layer 1, the carrier is already at the pin.** No part of this roadmap builds a continuous
cohomology functor; this example records that the canonical one elaborates here, so that the
statements below are about Mathlib's object rather than a private copy. -/
noncomputable example (n : ℕ) : TopRep R G ⥤ TopModuleCat.{u} R :=
  continuousCohomology R G n

/-- **Layer 1, degree 0 is already computed at the pin.** The only degree Mathlib evaluates.
Layer 3's comparison is checked against this before any harder degree exists. -/
noncomputable example : continuousCohomology R G 0 ≅ ContinuousCohomology.invariants R G :=
  ContinuousCohomology.continuousCohomologyZeroIso R G

/-- **Layer 1, the compatible-pair map,** the half of the interface the pin does not have. For a
continuous homomorphism `φ : H →ₜ* G` and a morphism `f` from the restriction of `X` to `Y`, this
is the induced map on continuous cohomology. Mathlib master calls it
`ContinuousCohomology.map`, so the name here is the same and the eventual swap is mechanical. -/
noncomputable def map (φ : ContinuousMonoidHom H G) {X : TopRep R G} {Y : TopRep R H}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶ (continuousCohomology R H n).obj Y :=
  sorry

/-- **Layer 1, the identity law.** -/
theorem map_id (X : TopRep R G) (n : ℕ) :
    map R (ContinuousMonoidHom.id G) (X := X) (Y := X) (𝟙 _) n = 𝟙 _ :=
  sorry

/-- **Layer 1, restriction to a subgroup,** the first of the three named instances of `map`. The
subgroup carries the subspace topology and needs no openness or closedness hypothesis. -/
noncomputable def res (S : Subgroup G) (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶
      (continuousCohomology R S n).obj ((Action.res _ S.subtype).obj X) :=
  sorry

end Carrier

open CategoryTheory in
/-- **Layer 1, the categorical dictionary.** A discrete `G`-module in the unbundled classes of
`README.md` §3 becomes an object of `TopRep ℤ G`. This is where the explicit statements of
Layers 2 to 9 meet the canonical API, and it is the translation Layer 3's comparison is stated
across. The universe restriction (`ℤ` forces the group into `Type`) is the `Action`/`Rep`
restriction the roadmap flags, not a mathematical hypothesis. -/
noncomputable def ofDiscreteModule (G : Type) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (M : Type) [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] : TopRep ℤ G :=
  sorry

/-! ### Layer 2: the explicit low-degree complex -/

/-- **Layer 2, worked example `H¹(ℤ_p, ℤ/pᵏ) ≅ ℤ/pᵏ`.** Under the trivial-action
characterization, `H¹` of the profinite additive group `ℤ_p` with discrete coefficients
`ℤ/pᵏ` is the group of continuous additive homomorphisms, and evaluation at `1` identifies it
with `ℤ/pᵏ`. Surjectivity is the content: the dense subgroup `ℤ ⊆ ℤ_p` sends `1` anywhere,
and continuity extends the choice. -/
example (p : ℕ) [Fact p.Prime] (k : ℕ) :
    Function.Bijective (fun φ : ContinuousAddMonoidHom ℤ_[p] (ZMod (p ^ k)) ↦ φ 1) :=
  sorry

/-- **Layer 2, worked example `H¹(ℤ_p, ℤ) = 0`.** With discrete torsion-free coefficients
there are no nonzero continuous homomorphisms from a profinite group: the image is a compact,
hence finite, subgroup of `ℤ`. Continuity is what makes the statement true, since the
abstract group `ℤ_p` has many homomorphisms to torsion-free targets. -/
example (p : ℕ) [Fact p.Prime] (φ : ContinuousAddMonoidHom ℤ_[p] ℤ) : φ = 0 :=
  sorry

/-! ### Layer 3: the two topological facts the comparison rests on -/

/-- **Layer 3, the canonical model is discrete in the arithmetic case.** For compact `G` and
discrete `M`, the compact-open topology on `C(G, M)` is discrete: a continuous map into a
discrete space is locally constant, its fibers are a finite clopen partition of `G`, and the
corresponding basic compact-open neighborhood is a singleton. Iterating, every term of the
canonical homogeneous cochain complex `C(G, C(G, …, M))` is discrete, hence so is every
subquotient. This is why the Layer 3 comparison can be stated as an isomorphism of
`TopModuleCat ℤ` objects rather than only of additive groups after forgetting the topology. -/
example {G : Type*} [TopologicalSpace G] [CompactSpace G] {M : Type*} [TopologicalSpace M]
    [DiscreteTopology M] : DiscreteTopology C(G, M) :=
  sorry

/-- **Layer 3, the exponential law is the hypothesis.** `ContinuousMap.curry` from the
uncurried inhomogeneous cochains to the canonical iterated function spaces exists for
arbitrary spaces; it is the **inverse** that needs local compactness
(`ContinuousMap.uncurry` requires `[LocallyCompactSpace Y]`, and `Homeomorph.curry` requires
it on both factors). So the degree-2 comparison of Layer 3 is exactly a local-compactness
statement, which is why it is stated for profinite `G`: a profinite group is compact
Hausdorff, hence locally compact. This is also the reason Mathlib's `ContCohomology` chose
the homogeneous model, and its module TODO names the `n`-ary description "for locally compact
groups". -/
example {G : Type*} [TopologicalSpace G] [LocallyCompactSpace G] {M : Type*}
    [TopologicalSpace M] :
    Function.Bijective (ContinuousMap.curry : C(G × G, M) → C(G, C(G, M))) :=
  sorry

/-! ### Layer 4: descent to finite levels, and the finite-quotient system -/

/-- **Layer 4, continuous 1-cocycles descend strictly.** The degree-1 surjectivity half of
the colimit theorem `H¹(G, M) ≅ colim_U H¹(G ⧸ U, M^U)`, stated raw and with **no coboundary
subtracted**: the zero set of a continuous 1-cocycle is an open subgroup, and any open normal
`U` inside it makes the cocycle right-`U`-invariant (so it factors through `G ⧸ U`) and
`U`-fixed-valued (so it takes its values in `M^U`). The descended `F` is asked to be a 1-cocycle of
`G ⧸ U` on `M^U` on the nose, for the action of Layer 0, so that the conclusion says exactly
that the original cocycle is the inflation of a finite-level cocycle. A coboundary enters
only in the injectivity half of the colimit theorem. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (f : G → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₁ f) :
    ∃ (U : OpenNormalSubgroup G) (F : G ⧸ U.toSubgroup → Invariants U.toSubgroup M),
      groupCohomology.IsCocycle₁ F ∧ ∀ g : G, (F (QuotientGroup.mk g) : M) = f g :=
  sorry

/-- **Layer 4, continuous 2-cocycles descend strictly.** The degree-2 half, by uniform local
constancy: a continuous map on the **compact** space `G × G` into a discrete module is
constant on `gU × hU` for a single open normal `U`, and its image is finite, so a further
open normal subgroup fixes every value. Compactness, not just total disconnectedness, is what
descends both variables at once. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (f : G × G → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₂ f) :
    ∃ (U : OpenNormalSubgroup G)
      (F : (G ⧸ U.toSubgroup) × (G ⧸ U.toSubgroup) → Invariants U.toSubgroup M),
      groupCohomology.IsCocycle₂ F ∧
        ∀ g h : G, (F (QuotientGroup.mk g, QuotientGroup.mk h) : M) = f (g, h) :=
  sorry

/-- **Layer 4, why the coefficient inclusion is equivariant.** For `V ≤ U` the action of `g`
on `M^U` depends only on the class of `g` in `G ⧸ V`. This is the elementary fact behind
`invariantsInclusion_equivariant` below, and the reason the pair `(G ⧸ V → G ⧸ U, M^U ↪ M^V)`
is a compatible pair at all. -/
example {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    {U V : Subgroup G} (hVU : V ≤ U) (m : M) (hm : ∀ u ∈ U, u • m = m) {g g' : G}
    (hgg' : g⁻¹ * g' ∈ V) : g • m = g' • m :=
  sorry

section FiniteQuotientSystem

open CategoryTheory Representation

variable {k G : Type u} [CommRing k] [Group G] [TopologicalSpace G] (A : Rep k G)

/-- **Layer 4, the group half of the transition pair.** For `V ≤ U` this is the quotient
homomorphism `G ⧸ V → G ⧸ U`, the direction of Mathlib's
`ProfiniteGrp.toFiniteQuotientFunctor`. The cohomological transition map built from it runs
the other way, from the `U`-level to the `V`-level, which is why the index category of the
system is `(OpenNormalSubgroup G)ᵒᵖ`. -/
def finiteQuotientMap (U V : OpenNormalSubgroup G) (hVU : V ≤ U) :
    G ⧸ V.toSubgroup →* G ⧸ U.toSubgroup :=
  QuotientGroup.map V.toSubgroup U.toSubgroup (MonoidHom.id G) fun _ hx => hVU hx

/-- **Layer 4, `M^U ⊆ M^V` for `V ≤ U`.** Fewer conditions on the smaller subgroup. -/
theorem invariants_le (U V : OpenNormalSubgroup G) (hVU : V ≤ U) :
    invariants (A.ρ.comp U.toSubgroup.subtype) ≤ invariants (A.ρ.comp V.toSubgroup.subtype) :=
  fun _ hm g => hm ⟨g.1, hVU g.2⟩

/-- **Layer 4, the coefficient half of the transition pair,** the inclusion `M^U ↪ M^V`.
Coefficients are taken on the `Rep` side here, as `Rep.quotientToInvariants`, because that is
where Mathlib's compatible-pair API for cohomology lives; Layer 0's dictionary identifies this
object with `Invariants U M` above. -/
noncomputable def invariantsInclusion (U V : OpenNormalSubgroup G) (hVU : V ≤ U) :
    invariants (A.ρ.comp U.toSubgroup.subtype) →ₗ[k] invariants (A.ρ.comp V.toSubgroup.subtype) :=
  Submodule.inclusion (invariants_le A U V hVU)

/-- **Layer 4, equivariance of the coefficient inclusion** after restriction along
`finiteQuotientMap`: the `G ⧸ U`-action on `M^U`, pulled back to `G ⧸ V`, agrees with the
`G ⧸ V`-action on `M^V`. Together with `finiteQuotientMap` it makes the pair below well typed. -/
theorem invariantsInclusion_equivariant (U V : OpenNormalSubgroup G) (hVU : V ≤ U)
    (x : G ⧸ V.toSubgroup) (m : invariants (A.ρ.comp U.toSubgroup.subtype)) :
    invariantsInclusion A U V hVU
        ((A.quotientToInvariants U.toSubgroup).ρ (finiteQuotientMap U V hVU x) m) =
      (A.quotientToInvariants V.toSubgroup).ρ x (invariantsInclusion A U V hVU m) :=
  sorry

/-- **Layer 4, the transition pair itself,** assembled from its two halves. -/
noncomputable def transitionPair (U V : OpenNormalSubgroup G) (hVU : V ≤ U) :
    Rep.res (finiteQuotientMap U V hVU) (A.quotientToInvariants U.toSubgroup) ⟶
      A.quotientToInvariants V.toSubgroup :=
  Rep.ofHom ⟨invariantsInclusion A U V hVU,
    fun x ↦ LinearMap.ext (invariantsInclusion_equivariant A U V hVU x)⟩

/-- **Layer 4, the transition map of the finite-quotient system,**
`Hⁱ(G ⧸ U, M^U) → Hⁱ(G ⧸ V, M^V)` for `V ≤ U`, through Mathlib's discrete
`groupCohomology.map`. The target category is `ModuleCat k`, which for `k = ℤ` is the
`AddCommGrp` of the roadmap's explicit low-degree statements. -/
noncomputable def finiteLevelTransition (U V : OpenNormalSubgroup G) (hVU : V ≤ U) (i : ℕ) :
    groupCohomology (A.quotientToInvariants U.toSubgroup) i ⟶
      groupCohomology (A.quotientToInvariants V.toSubgroup) i :=
  groupCohomology.map (finiteQuotientMap U V hVU) (transitionPair A U V hVU) i

/-- **Layer 4, the first functor law.** -/
theorem finiteLevelTransition_id (U : OpenNormalSubgroup G) (i : ℕ) :
    finiteLevelTransition A U U le_rfl i = 𝟙 _ :=
  sorry

/-- **Layer 4, the second functor law,** for `W ≤ V ≤ U`: the transition from the `U`-level to
the `W`-level is the composite through the `V`-level. With the previous law this says the
system is a functor on `(OpenNormalSubgroup G)ᵒᵖ`, which the colimit theorem needs. -/
theorem finiteLevelTransition_comp (U V W : OpenNormalSubgroup G) (hVU : V ≤ U) (hWV : W ≤ V)
    (i : ℕ) :
    finiteLevelTransition A U W (hWV.trans hVU) i =
      finiteLevelTransition A U V hVU i ≫ finiteLevelTransition A V W hWV i :=
  sorry

end FiniteQuotientSystem

/-! ### Layer 5: exactness of cochains -/

/-- **Layer 5, discrete cochain lifting.** The reason short exact sequences of *discrete*
modules induce long exact sequences: a continuous cochain into a discrete quotient lifts to a
continuous cochain along any surjection of discrete modules (compose with any set-theoretic
section; discreteness of the source of the section makes the composite continuous). Stated
for cochains on an arbitrary topological space, degree-agnostically. -/
example {X : Type*} [TopologicalSpace X] {B C : Type*} [AddCommGroup B] [AddCommGroup C]
    [TopologicalSpace B] [TopologicalSpace C] [DiscreteTopology B] [DiscreteTopology C]
    (p : B →+ C) (hp : Function.Surjective p) (f : X → C) (hf : Continuous f) :
    ∃ g : X → B, Continuous g ∧ p ∘ g = f :=
  sorry

/-! ### Layer 6: the corestriction transversal calculus -/

/-- **Layer 6, the transversal word** `ℓᵗ_u(γ) = (t u)⁻¹ * γ * t (γ⁻¹ • u)`, for a
**variable** transversal `t : G ⧸ U → G`. The transversal is a variable and not `Quotient.out`
from the start, because independence of the transversal is a theorem of Layer 6 and cannot
even be stated otherwise. -/
def lWord {G : Type*} [Group G] (U : Subgroup G) (t : G ⧸ U → G) (u : G ⧸ U) (γ : G) : G :=
  (t u)⁻¹ * γ * t (γ⁻¹ • u)

/-- **Layer 6, the transversal word takes its value in `U`.** -/
theorem lWord_mem {G : Type*} [Group G] (U : Subgroup G) (t : G ⧸ U → G)
    (ht : ∀ x : G ⧸ U, QuotientGroup.mk (t x) = x) (u : G ⧸ U) (γ : G) : lWord U t u γ ∈ U :=
  sorry

/-- **Layer 6, the transversal 1-cocycle law.** `ℓᵗ_u(γ) * ℓᵗ_{γ⁻¹ • u}(η) = ℓᵗ_u(γ * η)`:
pure group theory, with no normality, no finite index, and no condition on `t` at all. This
identity is why the degree-2 corestriction sum is a cocycle. -/
example {G : Type*} [Group G] (U : Subgroup G) (t : G ⧸ U → G) (u : G ⧸ U) (γ η : G) :
    lWord U t u γ * lWord U t (γ⁻¹ • u) η = lWord U t u (γ * η) :=
  sorry

/-- **Layer 6, corestriction in degree 1, with general coefficients.** The corestriction of a
1-cocycle of `U` is `(cor¹_t f) γ = ∑ u, t u • f (ℓᵗ_u γ)`, and the factor `t u •` is forced:
the proof rewrites `t u * ℓᵗ_u(γ) = γ * t (γ⁻¹ • u)` and reindexes, and without the action
the sum is not a cocycle. The `ZMod 2` formulas of `roed-math/gq2-lean` omit the factor only
because the action there is trivial. The input is a cocycle **on `U`**, since that is all a
class of `H¹(U, M)` is, and the transversal word is fed to it through its membership proof. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    {M : Type*} [AddCommGroup M] [TopologicalSpace M] [DiscreteTopology M]
    [DistribMulAction G M] [ContinuousSMul G M]
    (U : OpenSubgroup G) [Fintype (G ⧸ U.toSubgroup)] (t : G ⧸ U.toSubgroup → G)
    (ht : ∀ x : G ⧸ U.toSubgroup, QuotientGroup.mk (t x) = x)
    (f : U.toSubgroup → M) (hf : Continuous f) (hcoc : groupCohomology.IsCocycle₁ f) :
    groupCohomology.IsCocycle₁
        (fun γ : G ↦ ∑ u : G ⧸ U.toSubgroup, t u • f ⟨lWord U.toSubgroup t u γ,
          lWord_mem U.toSubgroup t ht u γ⟩) ∧
      Continuous (fun γ : G ↦ ∑ u : G ⧸ U.toSubgroup, t u • f ⟨lWord U.toSubgroup t u γ,
        lWord_mem U.toSubgroup t ht u γ⟩) :=
  sorry

/-- **Layer 6, `cor ∘ res` is the index only after passing to cohomology.** On cochains the
composite differs from `(G : U) • f` by the coboundary of `c = ∑ u, f (t u)`, so the roadmap
states `cor ∘ res = (G : U) • id` on `H⁰`, `H¹` and `H²` and never as a cochain identity in
positive degrees. The analogous degree-2 statement replaces `c` by an explicit continuous
1-cochain. Here `f` is a cocycle on all of `G`, since the composite starts by restricting
it. -/
example {G : Type*} [Group G] {M : Type*} [AddCommGroup M] [DistribMulAction G M]
    (U : Subgroup G) [Fintype (G ⧸ U)] (t : G ⧸ U → G)
    (ht : ∀ x : G ⧸ U, QuotientGroup.mk (t x) = x)
    (f : G → M) (hf : groupCohomology.IsCocycle₁ f) (γ : G) :
    ∑ u : G ⧸ U, t u • f (lWord U t u γ) =
      U.index • f γ + (γ • (∑ v : G ⧸ U, f (t v)) - ∑ v : G ⧸ U, f (t v)) :=
  sorry

/-! ### Layer 7: coinduction -/

/-- **Layer 7, uniform local constancy.** On a compact topological group a locally constant
function is uniformly locally constant: its stabilizer under right translation is open. This
is why the coinduced module `Coind_H^G A` of locally constant `H`-equivariant maps is again a
*discrete* `G`-module, which the Shapiro layer needs. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    {A : Type*} (f : G → A) (hf : IsLocallyConstant f) :
    IsOpen {g : G | ∀ x : G, f (x * g) = f x} :=
  sorry

/-! ### Layer 8: cup products in low degrees -/

/-- **Layer 8, the `(1,1)` cup cochain is a 2-cocycle.** For a `G`-equivariant biadditive
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

/-- **Layer 8, the `(1,0)` cup cochain is a 1-cocycle.** The shape that the roadmap's
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

/-- **Layer 8, worked example: the cup is nontrivial on `C₂`.** With trivial action on
`𝔽₂ = ZMod 2`, the cup square of the nontrivial 1-cocycle on `C₂`, the 2-cochain
`(g, h) ↦ g · h` under the identification `C₂ = Multiplicative (ZMod 2)`, is **not** a
trivial-action coboundary `(g, h) ↦ ψ h - ψ (g * h) + ψ g`. It is the test case for a
degenerate pairing: it gives `H¹(C₂, 𝔽₂) ⌣ H¹(C₂, 𝔽₂) ≠ 0`, the `G_ℝ` Kummer computation
`[-1] ⌣ [-1] ≠ 0`, and every B11a-shaped nondegeneracy downstream. -/
example :
    ¬ ∃ ψ : Multiplicative (ZMod 2) → ZMod 2, ∀ g h : Multiplicative (ZMod 2),
        Multiplicative.toAdd g * Multiplicative.toAdd h = ψ h - ψ (g * h) + ψ g :=
  sorry

/-! ### Layer 9: the Galois interface -/

/-- **Layer 9, the coefficient field is the separable closure.** Mathlib defines
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

/-- **Layer 9, `μₙ`,** the `n`-th roots of unity in the separable closure, as a subgroup of
`(Kˢ)ˣ`. It has the natural, in general nontrivial, action of `G_K`, and it is the
coefficient module of the Kummer isomorphism. -/
noncomputable def muN (K : Type*) [Field K] (n : ℕ) : Subgroup (SeparableClosure K)ˣ :=
  rootsOfUnity n (SeparableClosure K)

/-- **Layer 9, the subgroup of `n`-th powers `(Kˣ)ⁿ ≤ Kˣ`.** -/
def powerSubgroup (K : Type*) [Field K] (n : ℕ) : Subgroup Kˣ :=
  (powMonoidHom n : Kˣ →* Kˣ).range

/-- **Layer 9, the group of power classes `Kˣ ⧸ (Kˣ)ⁿ`,** the left-hand side of the Kummer
isomorphism. -/
abbrev powerClassQuotient (K : Type*) [Field K] (n : ℕ) : Type _ :=
  Kˣ ⧸ powerSubgroup K n

-- The action of `Gal(Kˢ/K)` on `(Kˢ)ˣ` is found by instance search, but not within the
-- default budget for a type this deep.
set_option synthInstance.maxHeartbeats 40000 in
/-- **Layer 9, the Kummer cocycle for general `n`.** Assume `n` invertible in `K`. For
`a ∈ Kˣ` with a chosen `n`-th root `r` in the separable closure (which exists because
`Xⁿ - a` is separable when `n` is invertible, and `SeparableClosure K` is separably closed),
the map `κ_a(g) = g r / r` takes its values in `μₙ`, is a **multiplicative** 1-cocycle, and is
locally constant for the Krull topology because the stabilizer of `r` is open. Its class is
the image of `a` under the connecting map of `1 → μₙ → (Kˢ)ˣ → (Kˢ)ˣ → 1`, and the resulting
map induces the Kummer isomorphism `Kˣ ⧸ (Kˣ)ⁿ ≅ H¹(G_K, μₙ)`. That last sentence is a
mandatory `README.md` milestone rather than a statement here: the class-level signature needs
Layer 2's explicit `H¹`, and inventing a placeholder for it would assert nothing. -/
example (K : Type*) [Field K] (n : ℕ) [NeZero n] (hn : IsUnit (n : K)) (a : Kˣ)
    (r : (SeparableClosure K)ˣ)
    (hr : (r : SeparableClosure K) ^ n = algebraMap K (SeparableClosure K) (a : K)) :
    ∃ κ : (SeparableClosure K ≃ₐ[K] SeparableClosure K) → muN K n,
      (∀ g, (κ g : (SeparableClosure K)ˣ) = g • r / r) ∧
        groupCohomology.IsMulCocycle₁ (fun g ↦ (κ g : (SeparableClosure K)ˣ)) ∧
        IsLocallyConstant κ :=
  sorry

set_option synthInstance.maxHeartbeats 40000 in
/-- **Layer 9, the Kummer class does not depend on the chosen root.** Two `n`-th roots of the
same `a` differ by an `n`-th root of unity, and the two cocycles differ by the coboundary of
that root of unity. Without this the connecting map is not well defined on `Kˣ`. The factor
`ζ` is typed as an element of `μₙ`, not as a field element that happens to satisfy
`ζ ^ n = 1`. -/
example (K : Type*) [Field K] (n : ℕ) [NeZero n] (a : Kˣ) (r r' : (SeparableClosure K)ˣ)
    (hr : (r : SeparableClosure K) ^ n = algebraMap K (SeparableClosure K) (a : K))
    (hr' : (r' : SeparableClosure K) ^ n = algebraMap K (SeparableClosure K) (a : K)) :
    ∃ ζ : muN K n, (r' : (SeparableClosure K)ˣ) = (ζ : (SeparableClosure K)ˣ) * r ∧
      ∀ g : SeparableClosure K ≃ₐ[K] SeparableClosure K,
        g • r' / r' =
          (g • (ζ : (SeparableClosure K)ˣ) / (ζ : (SeparableClosure K)ˣ)) * (g • r / r) :=
  sorry

/-! ### Layer 11: cohomological dimension -/

/-- **Layer 11, the least bound of a predicate on `ℕ`, in `ℕ∞`.** The roadmap defines
cohomological dimension from a `Prop`-valued predicate on `ℕ` and only then takes an infimum,
with codomain `ℕ∞` so that "infinite cohomological dimension" is `⊤` rather than an absent
value. All four of `CohomologicalDimensionLE`, `StrictCohomologicalDimensionLE`, `cd_p` and
`scd_p` are stated against Layer 10's `Hⁿ`; the order-theoretic wrapper is not, and
it is made once here rather than three times inline. -/
noncomputable def leastENatBound (P : ℕ → Prop) : ℕ∞ :=
  sInf {m : ℕ∞ | ∃ n : ℕ, m = (n : ℕ∞) ∧ P n}

/-- **Layer 11, the characterization for an upward-closed predicate.** Instantiating `P` at
the vanishing predicate of Layer 10 gives `cd_p G ≤ n ↔ CohomologicalDimensionLE p G n`, and
the same shape serves `cd` and `scd_p`. -/
theorem leastENatBound_le_iff (P : ℕ → Prop) (hP : ∀ m n : ℕ, m ≤ n → P m → P n) (n : ℕ) :
    leastENatBound P ≤ (n : ℕ∞) ↔ P n :=
  sorry

/-- **Layer 11, the empty case.** No bound at all gives `⊤`, since `sInf ∅ = ⊤` in `ℕ∞`. -/
theorem leastENatBound_eq_top (P : ℕ → Prop) (hP : ∀ n : ℕ, ¬ P n) : leastENatBound P = ⊤ :=
  sorry

/-! ### Layer 13: the Evens norm at index 2 -/

open scoped Classical in
/-- **Layer 13, a degree-1 class of an open subgroup, extended by zero.** `α` is a genuine
continuous homomorphism on the subgroup, that is a trivial-action 1-cocycle of `U`; this is
its extension by zero to `G`, from which the Shapiro components are built. -/
private noncomputable def evensExtend {G : Type*} [Group G] (U : Subgroup G)
    (α : U →* Multiplicative (ZMod 2)) : G → ZMod 2 :=
  fun γ ↦ if h : γ ∈ U then Multiplicative.toAdd (α ⟨γ, h⟩) else 0

open scoped Classical in
/-- **Layer 13, the two-point graph 2-cochain.** With `(G : U) = 2` and `s ∉ U`, the Shapiro
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

/-- **Layer 13, the graph cochain is a continuous 2-cocycle.** Continuity belongs in the
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

/-- **Layer 13, the class does not depend on the chosen `s`.** Two elements outside an
index-2 subgroup give graph cochains differing by an explicit continuous coboundary, so the
Evens norm is a well-defined map to `H²(G, 𝔽₂)`. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2) (s s' : G) (hs : s ∉ U) (hs' : s' ∉ U)
    (α : U.toSubgroup →* Multiplicative (ZMod 2)) (hα : Continuous α) :
    ∃ ψ : G → ZMod 2, Continuous ψ ∧ ∀ g h : G,
      evensGraphCochain U.toSubgroup s' α (g, h) - evensGraphCochain U.toSubgroup s α (g, h) =
        ψ h - ψ (g * h) + ψ g :=
  sorry

/-- **Layer 13, the `C₈` anchor.** A class of `H²(C₄, 𝔽₂)` with trivial coefficients
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

/-! ### What the sibling roadmaps consume -/

/-- **Layer 13, the restriction identity, at cochain level.** The first of the four identities the
Quadratic Form Invariants roadmap consumes: on `U × U` the graph cochain is the cup of `α` with
its conjugate, `res_U N^{Ev}(α) = α ⌣ (s · α)`. Stated on cochains here, since that is the form
the proof produces and the form a reader can check against the definition above. -/
example {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2) (s : G) (hs : s ∉ U)
    (α : U.toSubgroup →* Multiplicative (ZMod 2)) (γ η : G) (hγ : γ ∈ U) (hη : η ∈ U) :
    evensGraphCochain U.toSubgroup s α (γ, η) =
      evensExtend U.toSubgroup α γ * evensExtend U.toSubgroup α (s⁻¹ * η * s) :=
  sorry

set_option synthInstance.maxHeartbeats 40000 in
/-- **Layer 9, the mod-2 Kummer class.** With `2` invertible in `K`, the class of `a` is the
continuous homomorphism `G_K → 𝔽₂` that is trivial exactly on the automorphisms fixing a chosen
square root. This is the object the Quadratic Form Invariants roadmap calls the Kummer class, and
its square-class isomorphism `Kˣ ⧸ (Kˣ)² ≅ H¹(G_K, 𝔽₂)` is the Layer 9 milestone it consumes.
Multiplicative notation, through `Additive`, is the pin's own idiom for coefficients that are
units. -/
example (K : Type*) [Field K] (h2 : IsUnit (2 : K)) (a : Kˣ) (r : (SeparableClosure K)ˣ)
    (hr : (r : SeparableClosure K) ^ 2 = algebraMap K (SeparableClosure K) (a : K)) :
    ∃ κ : (SeparableClosure K ≃ₐ[K] SeparableClosure K) → Multiplicative (ZMod 2),
      (∀ g, κ g = 1 ↔ g • r = r) ∧ IsLocallyConstant κ ∧
        ∀ g h, κ (g * h) = κ g * κ h :=
  sorry

end TauCetiRoadmap.ProfiniteCohomology
