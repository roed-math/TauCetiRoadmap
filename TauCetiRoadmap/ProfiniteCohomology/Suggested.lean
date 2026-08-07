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
complex it is the homology of and the degree-0 computation. Mathlib's own rebuild of the same
object carries it on a category named `TopRep k G` with functoriality in compatible pairs. So
`TopRep` below is an abbreviation for the pinned category, Layer 1 states the missing
functoriality against it under Mathlib's names, and the canonical-facing milestones of Layers 3,
10 and 12 are stated against those declarations and nothing else. The two categories are
equivalent and the resolutions agree in shape, so adopting Mathlib's version later is a transport
rather than a redesign; it is not claimed to be definitional.

The two central interfaces are prototyped here rather than described. Layer 1's chain is
`resolutionMap`, `cochainsMap`, `cocyclesMap`, `map`, `map_id`, `map_comp`, `res`,
`quotientToInvariants`, `infl` and `coeffMap`, together with `IsSmoothDiscrete` and the
dictionary `ofDiscreteModule`. Layer 2's explicit theory is `C1`, `C2`, `d0`, `d1`, `Z1`, `Z2`,
`B1`, `B2`, `H1`, `H2` and the two class maps. With those in place Layer 3's four comparison
isomorphisms and Layer 9's class-level `kummerMap` and `kummerIso` are statable, and they are
stated.

Every law below is an equation between named maps. A law about restriction names `res`, one about
corestriction names `corestriction` or its relative form `corestrictionLe`, and one comparing the
explicit model with the canonical object names both sides. Where a map is not yet constructed it is
declared here as a target with a `sorry` body, rather than left as a parameter of the law: a law
quantified over an arbitrary morphism is not a weaker statement about the intended map, it is a
different and false statement about every morphism. The maps carried for that reason are
`ofDiscreteModuleMap`, `ofDiscreteModuleQuotient`, `ofDiscreteModulePair`,
`ofDiscreteModulePairing`, `quotientToInvariantsι`, `explicitMap1`, `explicitInfl1`,
`explicitCor1`, `explicitCup11`, `cochainClass`, `resLe`, `corestrictionLe`, `conjOpenSubgroup`,
`conjMapOf`, `mackeyTerm`, `powerClassMap`, `powerClassNorm`, `kummerRes`, `kummerCor`,
`f2Pairing`, `cupFamily`, `quotientOpenSubgroup`, `trivialF2Quotient`, `trivialF2Infl`,
`trivialF2InflSub`, `evensNormLe`, `evensDoubleCosetFactor`, `evensConj`, `homClass` and
`graphClass`.

Two hypotheses are carried as **data** rather than left implicit, because the constructions do not
exist without them. `CosetTransversal U` bundles a section of `G → G ⧸ U` with the proof that it is
one: for an arbitrary function the Schreier factors need not lie in `U`, so the monomial
homomorphism has no target. `IndexTwoDatum U` bundles `(G : U) = 2` with a choice of `s ∉ U`: for an
arbitrary open subgroup and an arbitrary `s`, conjugation by `s` need not preserve `U` and the graph
cochain need not be a cocycle.

Degree 1 of the index-two form is stated on **cochains**, not on classes. `evensB1` and `evensBs`
are not cocycles: for `G = C₄ = ⟨σ⟩`, `U = ⟨σ²⟩`, `s = σ` and `α ≠ 0`, the values of `evensB1` at
`1, σ, σ², σ³` are `0, 1, 1, 0`, so it is not a homomorphism. Only their sum `evensCorCochain` is,
and only the sum is given a class.

Also prototyped: the discrete-module openness API, the invariant coefficients `M^U` with their
`G ⧸ U`-action, the internal hom with its evaluation pairing, and continuous sections of profinite
quotients (Layer 0); trivial-action `H¹` worked examples through `ContinuousAddMonoidHom` and the
two topological facts the Layer 3 comparison rests on (Layers 2 and 3); the strict finite-level
descent of continuous cocycles and the whole transition package of the finite-quotient system
(Layer 4); the exactness of discrete cochain lifting (Layer 5); the corestriction transversal
calculus for a **variable** transversal, with the representative action that general coefficients
force (Layer 6); the coinduced module, the uniform local constancy behind it, and the trace
morphism all-degree corestriction is built from (Layers 7 and 10); two cup-product cocycle
identities and the `C₂` nontriviality anchor (Layer 8); the profinite Galois group of the
separable closure, the roots of unity and power classes, and the general-`n` Kummer cocycle
(Layer 9); the order-theoretic wrapper behind cohomological dimension (Layer 11); the coefficient
pairing and the bidegree cup (Layer 12); and the index-2 Evens graph cocycle with its `C₈` anchor
(Layer 13).

Two descriptions of the coefficients appear, as `README.md` §3 fixes them. Statements about
explicit cochains are written against the unbundled classes `[AddCommGroup M]
[DistribMulAction G M]`, with `Invariants U M` for `M^U`; statements about cohomology objects
and the arrows between them are written against `TopRep`, and against Mathlib's `Rep k G` at the
finite levels. Layer 1's dictionary identifies the two, on the smooth discrete subcategory and
not on all of `TopRep`.

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
/-- **Layer 1, the canonical carrier.** `TopRep R G` is Mathlib's name for this category. At the
pin it is `Action (TopModuleCat R) G`, and `continuousCohomology R G n` is a functor out of it.
Every canonical-facing statement in the roadmap is written against this abbreviation, so that
adopting Mathlib's `TopRep` later is a rename. -/
abbrev TopRep (R : Type u) [CommRing R] [TopologicalSpace R]
    (G : Type u) [Group G] [TopologicalSpace G] : Type (u + 1) :=
  Action (TopModuleCat.{u} R) G

open CategoryTheory in
/-- **Layer 1, the smooth discrete objects.** An object of `TopRep` carries one continuous
operator per group element and nothing there forces the action to be continuous in the group
variable, so an object whose module is discrete can still have non-open stabilizers. The
dictionary of `README.md` Layer 1 is an equivalence with **this** subcategory and not with all of
`TopRep`, and every canonical-facing comparison below quantifies over it. -/
structure IsSmoothDiscrete (R : Type u) [CommRing R] [TopologicalSpace R]
    {G : Type u} [Group G] [TopologicalSpace G] (X : TopRep R G) : Prop where
  /-- the underlying module is discrete -/
  discreteTopology : DiscreteTopology X.V
  /-- every point stabilizer is open, which for a discrete module is continuity of the action -/
  stabilizer_isOpen : ∀ x : X.V, IsOpen {g : G | (X.ρ g).hom x = x}

section Carrier

open CategoryTheory

variable (R : Type u) [CommRing R] [TopologicalSpace R]
  {G H K : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [Group H] [TopologicalSpace H] [IsTopologicalGroup H]
  [Group K] [TopologicalSpace K] [IsTopologicalGroup K]

/-- **Layer 1, the carrier is already at the pin.** No part of this roadmap builds a continuous
cohomology functor; this example records that the canonical one elaborates here, so that the
statements below are about Mathlib's object rather than a private copy. -/
noncomputable example (n : ℕ) : TopRep R G ⥤ TopModuleCat.{u} R :=
  continuousCohomology R G n

/-- **Layer 1, degree 0 is already computed at the pin.** The only degree Mathlib evaluates.
Layer 3's comparison is checked against this before any harder degree exists. -/
noncomputable example : continuousCohomology R G 0 ≅ ContinuousCohomology.invariants R G :=
  ContinuousCohomology.continuousCohomologyZeroIso R G

/-- **Layer 1, the resolution comparison.** The carrier is the homology of a complex built from
an iterated coinduction; a compatible pair induces a map of those resolutions, and everything
below is its consequence. This is the first link of the chain the pin does not have. -/
noncomputable def resolutionMap (φ : ContinuousMonoidHom H G) (n : ℕ) (X : TopRep R G) :
    (Action.res _ (φ : H →* G)).obj ((ContinuousCohomology.MultiInd.functor R G n).obj X) ⟶
      (ContinuousCohomology.MultiInd.functor R H n).obj
        ((Action.res _ (φ : H →* G)).obj X) :=
  sorry

/-- **Layer 1, the cochain map of a compatible pair.** Mathlib's name for it is
`ContinuousCohomology.cochainsMap`. -/
noncomputable def cochainsMap (φ : ContinuousMonoidHom H G) {X : TopRep R G} {Y : TopRep R H}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y) :
    (ContinuousCohomology.homogeneousCochains R G).obj X ⟶
      (ContinuousCohomology.homogeneousCochains R H).obj Y :=
  sorry

/-- **Layer 1, the induced map on cocycles.** -/
noncomputable def cocyclesMap (φ : ContinuousMonoidHom H G) {X : TopRep R G} {Y : TopRep R H}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y) (n : ℕ) :
    ((ContinuousCohomology.homogeneousCochains R G).obj X).cycles n ⟶
      ((ContinuousCohomology.homogeneousCochains R H).obj Y).cycles n :=
  HomologicalComplex.cyclesMap (cochainsMap R φ f) n

/-- **Layer 1, the compatible-pair map,** the half of the interface the pin does not have. For a
continuous homomorphism `φ : H →ₜ* G` and a morphism `f` from the restriction of `X` to `Y`, this
is the induced map on continuous cohomology. It is the homology of `cochainsMap`, so once that
exists this definition is not a further obligation. Mathlib's name for it is
`ContinuousCohomology.map`. -/
noncomputable def map (φ : ContinuousMonoidHom H G) {X : TopRep R G} {Y : TopRep R H}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶ (continuousCohomology R H n).obj Y :=
  HomologicalComplex.homologyMap (cochainsMap R φ f) n

/-- **Layer 1, the identity law.** -/
theorem map_id (X : TopRep R G) (n : ℕ) :
    map R (ContinuousMonoidHom.id G) (X := X) (Y := X) (𝟙 _) n = 𝟙 _ :=
  sorry

/-- **Layer 1, the composition law.** Compatible pairs compose, and `map` takes the composite to
the composite. -/
theorem map_comp (φ : ContinuousMonoidHom H G) (ψ : ContinuousMonoidHom K H)
    {X : TopRep R G} {Y : TopRep R H} {Z : TopRep R K}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y)
    (g : (Action.res _ (ψ : K →* H)).obj Y ⟶ Z) (n : ℕ) :
    map R (φ.comp ψ) ((Action.res _ (ψ : K →* H)).map f ≫ g) n =
      map R φ f n ≫ map R ψ g n :=
  sorry

/-- **Layer 1, restriction to a subgroup,** the first of the three named instances of `map`. The
subgroup carries the subspace topology and needs no openness or closedness hypothesis. -/
noncomputable def res (S : Subgroup G) (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶
      (continuousCohomology R S n).obj ((Action.res _ S.subtype).obj X) :=
  sorry

/-- **Layer 1, the invariants of a closed normal subgroup, as a `G ⧸ N`-object.** The coefficient
half of inflation, and the canonical-side twin of Mathlib's discrete `Rep.quotientToInvariants`. -/
noncomputable def quotientToInvariants (N : Subgroup G) [N.Normal] (X : TopRep R G) :
    TopRep R (G ⧸ N) :=
  sorry

/-- **Layer 1, the invariants of a closed normal subgroup include into the object.** The
coefficient half of the inflation compatible pair, as a morphism of `G`-objects. Layer 12's
inflation compatibility for the cup product is stated through it, because the two pairings that
compatibility relates live on objects with different underlying modules, so they cannot be compared
by an equation between their bilinear maps the way the restricted pairing can. -/
noncomputable def quotientToInvariantsι (N : Subgroup G) [N.Normal] (X : TopRep R G) :
    (Action.res _ (QuotientGroup.mk' N : G →* G ⧸ N)).obj (quotientToInvariants R N X) ⟶ X :=
  sorry

/-- **Layer 1, inflation,** the second named instance. -/
noncomputable def infl (N : Subgroup G) [N.Normal] (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R (G ⧸ N) n).obj (quotientToInvariants R N X) ⟶
      (continuousCohomology R G n).obj X :=
  sorry

/-- **Layer 1, coefficient maps,** the third named instance, at `φ = id`. This one the pin
already gives, since the carrier is a functor. -/
noncomputable def coeffMap {X Y : TopRep R G} (f : X ⟶ Y) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶ (continuousCohomology R G n).obj Y :=
  (continuousCohomology R G n).map f

/-- **Layer 1, the class of a continuous cocycle.** The quotient map from the cocycles of the
canonical complex onto continuous cohomology. A construction given by a cochain formula, such as
Layer 13's norm, is compared with a class-valued map through this, and without it the public
class-valued function would have no stated relation to the cochain it descends from. -/
noncomputable def cochainClass (X : TopRep R G) (n : ℕ)
    (a : ((ContinuousCohomology.homogeneousCochains R G).obj X).X n)
    (ha : (((ContinuousCohomology.homogeneousCochains R G).obj X).d n (n + 1)).hom a = 0) :
    (continuousCohomology R G n).obj X :=
  sorry

/-- **Layer 1, cohomologous cocycles have the same class.** -/
theorem cochainClass_eq_of_sub_eq_d (X : TopRep R G) (n j : ℕ) (hj : j + 1 = n)
    (a b : ((ContinuousCohomology.homogeneousCochains R G).obj X).X n)
    (ha : (((ContinuousCohomology.homogeneousCochains R G).obj X).d n (n + 1)).hom a = 0)
    (hb : (((ContinuousCohomology.homogeneousCochains R G).obj X).d n (n + 1)).hom b = 0)
    (c : ((ContinuousCohomology.homogeneousCochains R G).obj X).X j)
    (hc : a - b = hj ▸ ((((ContinuousCohomology.homogeneousCochains R G).obj X).d j
      (j + 1)).hom c)) :
    cochainClass R X n a ha = cochainClass R X n b hb :=
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
    [IsTopologicalAddGroup M] [DiscreteTopology M] [DistribMulAction G M]
    [ContinuousSMul G M] : TopRep ℤ G :=
  sorry

/-- **Layer 1, the dictionary lands in the smooth subcategory.** The half of the equivalence that
says the constructor is well behaved; the other half says every smooth discrete object arises this
way. Without this pair the dictionary would be a one-way constructor and Layer 3's comparison
would have nothing to quantify over. -/
theorem ofDiscreteModule_isSmoothDiscrete (G : Type) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (M : Type) [AddCommGroup M] [TopologicalSpace M]
    [IsTopologicalAddGroup M] [DiscreteTopology M] [DistribMulAction G M]
    [ContinuousSMul G M] : IsSmoothDiscrete ℤ (ofDiscreteModule G M) :=
  sorry

section CoefficientEquivalence

open CategoryTheory

variable (R : Type u) [CommRing R] [TopologicalSpace R]
  (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]

/-- **Layer 1, the smooth discrete full subcategory.** The half of `TopRep` the dictionary is an
equivalence with. -/
def SmoothDiscreteTopRep : Type _ :=
  ObjectProperty.FullSubcategory (fun X : TopRep R G => IsSmoothDiscrete R X)

noncomputable instance : Category (SmoothDiscreteTopRep R G) :=
  inferInstanceAs (Category (ObjectProperty.FullSubcategory _))

/-- **Layer 1, the inclusion of the smooth discrete subcategory into `TopRep`,** which is how a
coinduced object of Layer 7 reaches the canonical cohomology functor. -/
noncomputable def smoothDiscreteι : SmoothDiscreteTopRep R G ⥤ TopRep R G :=
  ObjectProperty.ι (fun X : TopRep R G => IsSmoothDiscrete R X)

/-- **Layer 1, the unbundled side as a category.** The discrete `G`-modules of `README.md` §3,
bundled so that the dictionary can be an equivalence of categories rather than a constructor. -/
structure DiscreteRep where
  /-- the underlying module -/
  V : Type u
  [addCommGroup : AddCommGroup V]
  [module : Module R V]
  [topologicalSpace : TopologicalSpace V]
  [discrete : DiscreteTopology V]
  [distribMulAction : DistribMulAction G V]
  [smulCommClass : SMulCommClass G R V]
  [continuousSMul : ContinuousSMul G V]

attribute [instance] DiscreteRep.addCommGroup DiscreteRep.module DiscreteRep.topologicalSpace
  DiscreteRep.discrete DiscreteRep.distribMulAction DiscreteRep.smulCommClass
  DiscreteRep.continuousSMul

/-- **Layer 1, the morphisms of the unbundled side:** the continuous equivariant `R`-linear maps,
which are the maps the explicit theory of Layer 2 is functorial in. -/
structure DiscreteRepHom (X Y : DiscreteRep R G) where
  /-- the underlying linear map -/
  toLinearMap : X.V →ₗ[R] Y.V
  /-- continuity -/
  cont : Continuous toLinearMap
  /-- equivariance -/
  equivariant : ∀ (g : G) (x : X.V), toLinearMap (g • x) = g • toLinearMap x

noncomputable instance : Category (DiscreteRep R G) where
  Hom X Y := DiscreteRepHom R G X Y
  id X := ⟨LinearMap.id, continuous_id, fun _ _ => rfl⟩
  comp f g := ⟨g.toLinearMap ∘ₗ f.toLinearMap, g.cont.comp f.cont,
    fun a x => by simp [f.equivariant, g.equivariant]⟩

/-- **Layer 1, the dictionary going in.** -/
noncomputable def toSmoothDiscrete : DiscreteRep R G ⥤ SmoothDiscreteTopRep R G := sorry

/-- **Layer 1, the dictionary coming back.** This is the half a one-way constructor does not
give, and without it the "equivalence" would be an assertion rather than a theorem. -/
noncomputable def ofSmoothDiscrete : SmoothDiscreteTopRep R G ⥤ DiscreteRep R G := sorry

/-- **Layer 1, the equivalence of coefficient categories,** with its unit and counit. This is the
statement that keeps the explicit theory from being a second theory of coefficients. -/
noncomputable def discreteRepEquivSmoothTopRep :
    DiscreteRep R G ≌ SmoothDiscreteTopRep R G :=
  sorry

end CoefficientEquivalence

/-! ### Layer 2: the explicit low-degree complex -/

section ExplicitComplex

variable (G : Type*) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  (M : Type*) [AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M]
  [DistribMulAction G M] [ContinuousSMul G M]

/-- **Layer 2, `C¹`.** Cochains are plain functions with continuity as a predicate, matching the
shape of the pin's `groupCohomology.cocycles₁ : Submodule k (G → A)` rather than bundled
`C(G, M)`; §3 of `README.md` fixes that convention and Layer 3 crosses to the bundled form once. -/
def C1 : AddSubgroup (G → M) where
  carrier := {f | Continuous f}
  add_mem' hf hg := hf.add hg
  zero_mem' := continuous_const
  neg_mem' hf := hf.neg

/-- **Layer 2, `C²`.** -/
def C2 : AddSubgroup (G × G → M) where
  carrier := {f | Continuous f}
  add_mem' hf hg := hf.add hg
  zero_mem' := continuous_const
  neg_mem' hf := hf.neg

/-- **Layer 2, `d⁰ m = fun g ↦ g • m - m`.** -/
def d0 : M →+ (G → M) where
  toFun m := fun g => g • m - m
  map_zero' := by ext g; simp
  map_add' m m' := by ext g; simp only [Pi.add_apply, smul_add]; abel

/-- **Layer 2, `d¹ f (g, h) = g • f h - f (g * h) + f g`.** -/
def d1 : (G → M) →+ (G × G → M) where
  toFun f := fun q => q.1 • f q.2 - f (q.1 * q.2) + f q.1
  map_zero' := by ext q; simp
  map_add' f f' := by ext q; simp only [Pi.add_apply, smul_add]; abel

/-- **Layer 2, `Z¹ = C¹ ⊓ ker d¹`,** with the kernel spelled by the pin's `IsCocycle₁`. -/
def Z1 : AddSubgroup (G → M) :=
  C1 G M ⊓
    { carrier := {f | groupCohomology.IsCocycle₁ f}
      add_mem' := fun {a b} ha hb g h => by
        simp only [Pi.add_apply, ha g h, hb g h, smul_add]; abel
      zero_mem' := fun g h => by simp
      neg_mem' := fun {a} ha g h => by
        simp only [Pi.neg_apply, ha g h, smul_neg]; abel }

/-- **Layer 2, `Z² = C² ⊓ ker d²`.** -/
def Z2 : AddSubgroup (G × G → M) :=
  C2 G M ⊓
    { carrier := {f | groupCohomology.IsCocycle₂ f}
      add_mem' := fun {a b} ha hb g h j => by
        simp only [Pi.add_apply, smul_add]
        rw [add_add_add_comm, ha g h j, hb g h j, add_add_add_comm]
      zero_mem' := fun g h j => by simp
      neg_mem' := fun {a} ha g h j => by
        simp only [Pi.neg_apply, smul_neg, ← neg_add]
        exact congrArg Neg.neg (ha g h j) }

/-- **Layer 2, `B¹ = range d⁰`.** Every such cochain is automatically continuous, which is why no
intersection with `C¹` appears here and one does appear in `B²`. -/
def B1 : AddSubgroup (G → M) := (d0 G M).range

/-- **Layer 2, `B² = d¹(C¹)`,** the image of the **continuous** 1-cochains. -/
def B2 : AddSubgroup (G × G → M) := AddSubgroup.map (d1 G M) (C1 G M)

/-- **Layer 2, `d ∘ d = 0` in the form the quotient needs.** -/
theorem B1_le_Z1 : B1 G M ≤ Z1 G M := sorry

/-- **Layer 2, `d ∘ d = 0` in degree 2.** -/
theorem B2_le_Z2 : B2 G M ≤ Z2 G M := sorry

/-- **Layer 2, `H¹ = Z¹/B¹`.** -/
abbrev H1 := (Z1 G M) ⧸ ((B1 G M).addSubgroupOf (Z1 G M))

/-- **Layer 2, `H² = Z²/B²`.** -/
abbrev H2 := (Z2 G M) ⧸ ((B2 G M).addSubgroupOf (Z2 G M))

/-- **Layer 2, the class map in degree 1.** -/
abbrev H1pi : (Z1 G M) →+ H1 G M := QuotientAddGroup.mk' _

/-- **Layer 2, the class map in degree 2.** -/
abbrev H2pi : (Z2 G M) →+ H2 G M := QuotientAddGroup.mk' _

/-- **Layer 2, `H¹` with the discrete topology.** The quotient topology `H1` inherits comes from
the **pointwise** topology on `G → M`, and for an infinite profinite `G` that is not discrete: with
trivial `ZMod 2` coefficients on a product of infinitely many copies of `C₂`, no finite set of
evaluations isolates the zero character. The canonical side of Layer 3 is discrete, so the
comparison is stated against this object and not against the inherited one. -/
def DiscreteH1 : Type _ := H1 G M

noncomputable instance : AddCommGroup (DiscreteH1 G M) := inferInstanceAs (AddCommGroup (H1 G M))
instance : TopologicalSpace (DiscreteH1 G M) := ⊥
instance : DiscreteTopology (DiscreteH1 G M) := ⟨rfl⟩

/-- **Layer 2, `H²` with the discrete topology.** -/
def DiscreteH2 : Type _ := H2 G M

noncomputable instance : AddCommGroup (DiscreteH2 G M) := inferInstanceAs (AddCommGroup (H2 G M))
instance : TopologicalSpace (DiscreteH2 G M) := ⊥
instance : DiscreteTopology (DiscreteH2 G M) := ⟨rfl⟩

/-- The identity as an additive equivalence, so that computations on representatives stay
available after passing to the discrete object. -/
noncomputable def discreteH1Equiv : DiscreteH1 G M ≃+ H1 G M := AddEquiv.refl _

/-- The degree-2 counterpart. -/
noncomputable def discreteH2Equiv : DiscreteH2 G M ≃+ H2 G M := AddEquiv.refl _

end ExplicitComplex


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

/-! ### Layer 3: the comparison isomorphisms -/

section Comparisons

variable (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  (M : Type) [AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M]
  [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]

/-- **Layer 3, degree 1 against Mathlib's discrete group cohomology.** Every continuity condition
is vacuous for a discrete group, so this identifies subquotients of the same function space.
Layer 4 uses it at every finite level. -/
noncomputable def explicitH1IsoGroupCohomology [DiscreteTopology G] [SMulCommClass G ℤ M] :
    H1 G M ≃+ (groupCohomology (Rep.ofDistribMulAction ℤ G M) 1) :=
  sorry

/-- **Layer 3, degree 2 against Mathlib's discrete group cohomology.** -/
noncomputable def explicitH2IsoGroupCohomology [DiscreteTopology G] [SMulCommClass G ℤ M] :
    H2 G M ≃+ (groupCohomology (Rep.ofDistribMulAction ℤ G M) 2) :=
  sorry

/-- **Layer 3, `H⁰` as an object of `TopModuleCat ℤ`.** `H⁰` is a subgroup of the discrete `M`, so
it is discrete already and needs no separate synonym. -/
noncomputable def explicitH0Obj : TopModuleCat.{0} ℤ :=
  TopModuleCat.of ℤ (Invariants (⊤ : Subgroup G) M)

/-- **Layer 3, `H¹` as an object of `TopModuleCat ℤ`,** built from the **discrete** object. -/
noncomputable def explicitH1Obj : TopModuleCat.{0} ℤ := TopModuleCat.of ℤ (DiscreteH1 G M)

/-- **Layer 3, `H²` as an object of `TopModuleCat ℤ`.** -/
noncomputable def explicitH2Obj : TopModuleCat.{0} ℤ := TopModuleCat.of ℤ (DiscreteH2 G M)

/-- **Layer 1, the dictionary commutes with restriction.** Restricting the canonical object of a
discrete module to a subgroup gives the canonical object of the same module over that subgroup.
The transport squares below cannot be typed without it. -/
noncomputable def ofDiscreteModuleRes (S : Subgroup G) :
    (Action.res _ S.subtype).obj (ofDiscreteModule G M) ≅ ofDiscreteModule S M :=
  sorry

/-- **Layer 2, restriction on the explicit model,** the instance of the compatible-pair pullback
at the inclusion of a subgroup. -/
noncomputable def explicitRes1 (S : Subgroup G) : H1 G M →+ H1 S M := sorry

/-- **Layer 2, a coefficient map on the explicit model.** -/
noncomputable def explicitCoeff1 (N : Type) [AddCommGroup N] [TopologicalSpace N]
    [IsTopologicalAddGroup N] [DiscreteTopology N] [DistribMulAction G N] [ContinuousSMul G N]
    (f : M →+ N) (hf : Continuous f) (hequiv : ∀ (g : G) (m : M), f (g • m) = g • f m) :
    H1 G M →+ H1 G N :=
  sorry

/-- **Layer 3, degree 0 against the canonical object,** in `TopModuleCat ℤ`. The pin computes this
degree, so it is where the comparison is checked first. -/
noncomputable def explicitH0IsoContinuousCohomology
    [CompactSpace G] [TotallyDisconnectedSpace G] :
    explicitH0Obj G M ≅ (continuousCohomology ℤ G 0).obj (ofDiscreteModule G M) :=
  sorry

/-- **Layer 3, degree 1 against the canonical object,** in `TopModuleCat ℤ`. The canonical side is
the image of `M` under Layer 1's dictionary and **not** an arbitrary `TopRep` object: a general
object need not be smooth, and the explicit complex is not a description of its cohomology. -/
noncomputable def explicitH1IsoContinuousCohomology
    [CompactSpace G] [TotallyDisconnectedSpace G] :
    explicitH1Obj G M ≅ (continuousCohomology ℤ G 1).obj (ofDiscreteModule G M) :=
  sorry

/-- **Layer 3, degree 2 against the canonical object,** in `TopModuleCat ℤ`. This is the degree
where the compact-open exponential law is used, hence where profiniteness is not a
convenience. -/
noncomputable def explicitH2IsoContinuousCohomology
    [CompactSpace G] [TotallyDisconnectedSpace G] :
    explicitH2Obj G M ≅ (continuousCohomology ℤ G 2).obj (ofDiscreteModule G M) :=
  sorry

/-- **Layer 3, the underlying additive equivalence,** a corollary of the isomorphism above and not
a substitute for it. -/
noncomputable def explicitH1AddEquivContinuousCohomology
    [CompactSpace G] [TotallyDisconnectedSpace G] :
    H1 G M ≃+ ((continuousCohomology ℤ G 1).obj (ofDiscreteModule G M)) :=
  sorry

/-- **Layer 2, the compatible-pair pullback on the explicit model,** of which `explicitRes1`,
`explicitInfl1` and `explicitCoeff1` are the three named instances. -/
noncomputable def explicitMap1 (H : Type) [Group H] [TopologicalSpace H] [IsTopologicalGroup H]
    (N : Type) [AddCommGroup N] [TopologicalSpace N] [IsTopologicalAddGroup N]
    [DiscreteTopology N] [DistribMulAction H N] [ContinuousSMul H N]
    (φ : ContinuousMonoidHom H G) (f : M →+ N) (hf : Continuous f)
    (hequiv : ∀ (h : H) (m : M), f (φ h • m) = h • f m) :
    H1 G M →+ H1 H N :=
  sorry

/-- **Layer 1, the dictionary carries a compatible pair.** The canonical-side coefficient morphism
of the pair `(φ, f)`, which is what `map` consumes. -/
noncomputable def ofDiscreteModulePair (H : Type) [Group H] [TopologicalSpace H]
    [IsTopologicalGroup H] (N : Type) [AddCommGroup N] [TopologicalSpace N]
    [IsTopologicalAddGroup N] [DiscreteTopology N] [DistribMulAction H N] [ContinuousSMul H N]
    (φ : ContinuousMonoidHom H G) (f : M →+ N) (hf : Continuous f)
    (hequiv : ∀ (h : H) (m : M), f (φ h • m) = h • f m) :
    (Action.res _ (φ : H →* G)).obj (ofDiscreteModule G M) ⟶ ofDiscreteModule H N :=
  sorry

/-- **Layer 3, the comparison is natural in compatible pairs.** The general square, of which the
three transports below are the named instances at a subgroup inclusion, a quotient map and the
identity. The README requires the comparison itself to be natural, not only its three
specializations. -/
theorem explicitIso_map [CompactSpace G] [TotallyDisconnectedSpace G]
    (H : Type) [Group H] [TopologicalSpace H] [IsTopologicalGroup H] [CompactSpace H]
    [TotallyDisconnectedSpace H]
    (N : Type) [AddCommGroup N] [TopologicalSpace N] [IsTopologicalAddGroup N]
    [DiscreteTopology N] [DistribMulAction H N] [ContinuousSMul H N]
    (φ : ContinuousMonoidHom H G) (f : M →+ N) (hf : Continuous f)
    (hequiv : ∀ (h : H) (m : M), f (φ h • m) = h • f m) (x : DiscreteH1 G M) :
    (map ℤ φ (ofDiscreteModulePair G M H N φ f hf hequiv) 1).hom
        ((explicitH1IsoContinuousCohomology G M).hom.hom x) =
      (explicitH1IsoContinuousCohomology H N).hom.hom
        (explicitMap1 G M H N φ f hf hequiv (discreteH1Equiv G M x) : DiscreteH1 H N) :=
  sorry

/-- **Layer 3, transport of restriction.** The square commuting is the statement; a closed
subgroup of a profinite group is profinite, which is what the instance hypotheses record. -/
theorem explicitIso_res [CompactSpace G] [TotallyDisconnectedSpace G] (S : Subgroup G)
    (hS : IsClosed (S : Set G)) [CompactSpace S] [TotallyDisconnectedSpace S]
    (x : DiscreteH1 G M) :
    ((continuousCohomology ℤ S 1).map (ofDiscreteModuleRes G M S).hom).hom
        ((res ℤ S (ofDiscreteModule G M) 1).hom
          ((explicitH1IsoContinuousCohomology G M).hom.hom x)) =
      (explicitH1IsoContinuousCohomology S M).hom.hom
        (explicitRes1 G M S (discreteH1Equiv G M x) : DiscreteH1 S M) :=
  sorry

/-- **Layer 1, the dictionary is functorial in the coefficients.** A continuous `G`-equivariant map
of discrete modules induces a morphism of the canonical objects. The coefficient square below names
this morphism: a square quantified over an arbitrary morphism of the two objects is a different
statement, and a false one, since a general morphism has nothing to do with `f`. -/
noncomputable def ofDiscreteModuleMap (N : Type) [AddCommGroup N] [TopologicalSpace N]
    [IsTopologicalAddGroup N] [DiscreteTopology N] [DistribMulAction G N] [ContinuousSMul G N]
    (f : M →+ N) (hf : Continuous f) (hequiv : ∀ (g : G) (m : M), f (g • m) = g • f m) :
    ofDiscreteModule G M ⟶ ofDiscreteModule G N :=
  sorry

/-- **Layer 3, transport of coefficient maps.** -/
theorem explicitIso_coeffMap [CompactSpace G] [TotallyDisconnectedSpace G]
    (N : Type) [AddCommGroup N] [TopologicalSpace N] [IsTopologicalAddGroup N]
    [DiscreteTopology N] [DistribMulAction G N] [ContinuousSMul G N]
    (f : M →+ N) (hf : Continuous f) (hequiv : ∀ (g : G) (m : M), f (g • m) = g • f m)
    (x : DiscreteH1 G M) :
    (coeffMap ℤ (ofDiscreteModuleMap G M N f hf hequiv) 1).hom
        ((explicitH1IsoContinuousCohomology G M).hom.hom x) =
      (explicitH1IsoContinuousCohomology G N).hom.hom
        (explicitCoeff1 G M N f hf hequiv (discreteH1Equiv G M x) : DiscreteH1 G N) :=
  sorry

/-- **Layer 1, the dictionary commutes with passing to the invariants of a closed normal
subgroup.** The coefficient half of inflation on the canonical side, named so that the inflation
square below is an equation between determined maps. -/
noncomputable def ofDiscreteModuleQuotient (N : Subgroup G) [N.Normal]
    [IsTopologicalGroup (G ⧸ N)] [ContinuousSMul (G ⧸ N) (Invariants N M)] :
    ofDiscreteModule (G ⧸ N) (Invariants N M) ⟶
      quotientToInvariants ℤ N (ofDiscreteModule G M) :=
  sorry

/-- **Layer 2, inflation on the explicit model,** the instance of the compatible-pair pullback at
the quotient map of a closed normal subgroup, with the invariants as coefficients. -/
noncomputable def explicitInfl1 (N : Subgroup G) [N.Normal]
    [IsTopologicalGroup (G ⧸ N)] [ContinuousSMul (G ⧸ N) (Invariants N M)] :
    H1 (G ⧸ N) (Invariants N M) →+ H1 G M :=
  sorry

/-- **Layer 6, corestriction on the explicit model in degree 1,** the `t = Quotient.out`
specialization of the transversal formula of `README.md` §3. The subgroup is **open**, which is
what makes the transversal finite. -/
noncomputable def explicitCor1 (U : OpenSubgroup G) : H1 U.toSubgroup M →+ H1 G M :=
  sorry

/-- **Layer 3, transport of inflation.** Stated in the same shape as restriction, with the
quotient in place of the subgroup. -/
theorem explicitIso_infl [CompactSpace G] [TotallyDisconnectedSpace G] (N : Subgroup G)
    [N.Normal] [CompactSpace (G ⧸ N)] [TotallyDisconnectedSpace (G ⧸ N)]
    [IsTopologicalGroup (G ⧸ N)] [ContinuousSMul (G ⧸ N) (Invariants N M)]
    (x : DiscreteH1 (G ⧸ N) (Invariants N M)) :
    (infl ℤ N (ofDiscreteModule G M) 1).hom
        (((continuousCohomology ℤ (G ⧸ N) 1).map (ofDiscreteModuleQuotient G M N)).hom
          ((explicitH1IsoContinuousCohomology (G ⧸ N) (Invariants N M)).hom.hom x)) =
      (explicitH1IsoContinuousCohomology G M).hom.hom
        (explicitInfl1 G M N (discreteH1Equiv (G ⧸ N) (Invariants N M) x) : DiscreteH1 G M) :=
  sorry

end Comparisons

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

/-- **Layer 7, the coinduced module.** The locally constant `H`-equivariant maps `G → A`, which
is Milne's `M_*` and Ribes-Zalesskii's `Coind_H^G`. The previous statement is why it is again a
*discrete* `G`-module. -/
def Coind (G : Type*) [Group G] [TopologicalSpace G] (U : Subgroup G)
    (A : Type*) [AddCommGroup A] [DistribMulAction U A] : AddSubgroup (G → A) where
  carrier := {f | IsLocallyConstant f ∧ ∀ (u : U) (g : G), f ((u : G) * g) = u • f g}
  add_mem' {a b} ha hb := ⟨ha.1.add hb.1, fun u g => by simp [ha.2 u g, hb.2 u g, smul_add]⟩
  zero_mem' := ⟨IsLocallyConstant.const 0, fun u g => by simp⟩
  neg_mem' {a} ha := ⟨ha.1.neg, fun u g => by simp [ha.2 u g, smul_neg]⟩

/-- **Layer 7, the trace on the underlying carrier,** `f ↦ ∑_{gU} g • f (g⁻¹)`. This is the
elementwise formula; the object all-degree corestriction actually consumes is the bundled
`coindTrace` below, and the two agree by construction. -/
noncomputable def coindTraceRaw {G : Type*} [Group G] [TopologicalSpace G] (U : Subgroup G)
    [Fintype (G ⧸ U)] (M : Type*) [AddCommGroup M] [DistribMulAction G M] :
    Coind G U M →+ M :=
  sorry

section AllDegreeCorestriction

open CategoryTheory

variable (R : Type u) [CommRing R] [TopologicalSpace R]
  {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]

/-- **Layer 1, smooth discreteness is inherited by restriction to a subgroup.** The stabilizer of a
point for the subgroup is the intersection of its `G`-stabilizer with the subgroup. Layer 10 needs
it to feed restricted coefficients to coinduction. -/
theorem IsSmoothDiscrete.res (S : Subgroup G) {X : TopRep R G} (hX : IsSmoothDiscrete R X) :
    IsSmoothDiscrete R ((Action.res _ S.subtype).obj X) :=
  sorry

/-- **Layer 10, the restricted coefficients as a smooth discrete object.** -/
noncomputable def resSmooth (S : Subgroup G) (X : TopRep R G) (hX : IsSmoothDiscrete R X) :
    SmoothDiscreteTopRep R S :=
  ⟨(Action.res _ S.subtype).obj X, hX.res R S⟩

/-- **Layer 7, the coinduced object, bundled.** `Coind_H^G A` with its right-translation action.
The coefficients are **smooth discrete** on both sides, and that is not a convenience: the carrier
`Coind` above is the group of **locally constant** equivariant maps, which for a non-discrete
coefficient object is not the continuous coinduction, so an all-`TopRep` signature would advertise
a construction this one is not. Profiniteness of `G` and closedness of `H` give smoothness of the
result: uniform local constancy on a **compact** group is what makes the right-translation
stabilizer open, and without it a locally constant function need have no common open translation
stabilizer. -/
noncomputable def coindTopRep (H : Subgroup G) (hH : IsClosed (H : Set G))
    (A : SmoothDiscreteTopRep R H) : SmoothDiscreteTopRep R G := sorry

/-- **Layer 7, coinduction is a functor** between the smooth discrete subcategories. -/
noncomputable def coindFunctor (H : Subgroup G) (hH : IsClosed (H : Set G)) :
    SmoothDiscreteTopRep R H ⥤ SmoothDiscreteTopRep R G := sorry

/-- **Layer 7, the functor agrees with the object construction.** -/
theorem coindFunctor_obj (H : Subgroup G) (hH : IsClosed (H : Set G))
    (A : SmoothDiscreteTopRep R H) :
    (coindFunctor R H hH).obj A = coindTopRep R H hH A :=
  sorry

/-- **Layer 7, exactness of coinduction,** which is where Layer 0's continuous section of
`G → G ⧸ H` is used, and hence where closedness of `H` enters. Stated as preservation of the two
one-sided properties, which is the form the long exact sequence and Shapiro consume, and stated in
the smooth discrete subcategory, which is where the section argument applies. -/
theorem coindFunctor_preservesEpimorphisms (H : Subgroup G) (hH : IsClosed (H : Set G)) :
    (coindFunctor R H hH).PreservesEpimorphisms :=
  sorry

/-- **Layer 7, the other half of exactness.** -/
theorem coindFunctor_preservesMonomorphisms (H : Subgroup G) (hH : IsClosed (H : Set G)) :
    (coindFunctor R H hH).PreservesMonomorphisms :=
  sorry

/-- **Layer 7, Shapiro's lemma in every degree,** as an isomorphism in the category the canonical
cohomology objects live in. Closedness of `H` is what supplies the inverse map. -/
noncomputable def shapiroIso (H : Subgroup G) (hH : IsClosed (H : Set G))
    (A : SmoothDiscreteTopRep R H) (n : ℕ) :
    (continuousCohomology R G n).obj ((smoothDiscreteι R G).obj (coindTopRep R H hH A)) ≅
      (continuousCohomology R H n).obj ((smoothDiscreteι R H).obj A) :=
  sorry

/-- **Layer 10, milestone 1: the trace as a morphism of coefficient objects.** A morphism in
`TopRep R G`, not merely an additive map, so that it can be fed to Layer 1's `map`. The subgroup is
**open**: the continuous transfer is defined for open subgroups, and a finite-index abstract
subgroup of a topological group need not be open. -/
noncomputable def coindTrace (U : OpenSubgroup G) (X : TopRep R G) (hX : IsSmoothDiscrete R X) :
    (smoothDiscreteι R G).obj
        (coindTopRep R U.toSubgroup U.isClosed (resSmooth R U.toSubgroup X hX)) ⟶ X :=
  sorry

/-- **Layer 10, milestone 2: all-degree corestriction,** the Shapiro-then-trace composite. It has
a real body, so once `shapiroIso` and `coindTrace` exist this is not a further obligation, which
is the point of choosing this route over an all-degree cochain formula. The coefficients are smooth
discrete because coinduction is, which is the roadmap's scope: §1 puts non-discrete topological
coefficient modules out of scope. -/
noncomputable def corestriction (U : OpenSubgroup G) (X : TopRep R G) (hX : IsSmoothDiscrete R X)
    (n : ℕ) :
    (continuousCohomology R U.toSubgroup n).obj
        ((Action.res _ U.toSubgroup.subtype).obj X) ⟶
      (continuousCohomology R G n).obj X :=
  (shapiroIso R U.toSubgroup U.isClosed (resSmooth R U.toSubgroup X hX) n).inv ≫
    (continuousCohomology R G n).map (coindTrace R U X hX)

/-- **Layer 10, milestone 3: naturality in the coefficients,** as a commuting square. -/
theorem corestriction_naturality (U : OpenSubgroup G) {X Y : TopRep R G}
    (hX : IsSmoothDiscrete R X) (hY : IsSmoothDiscrete R Y) (f : X ⟶ Y) (n : ℕ) :
    corestriction R U X hX n ≫ (continuousCohomology R G n).map f =
      (continuousCohomology R U.toSubgroup n).map ((Action.res _ U.toSubgroup.subtype).map f) ≫
        corestriction R U Y hY n :=
  sorry

/-- **Layer 1, restriction between two open subgroups,** `res^V_W` for open `W ≤ V ≤ G`. Layer 1's
`res` goes down from the ambient group only; the transitivity and Mackey statements below need the
relative map, so it is named here rather than quantified over. -/
noncomputable def resLe (V W : OpenSubgroup G) (hWV : W ≤ V) (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R V.toSubgroup n).obj ((Action.res _ V.toSubgroup.subtype).obj X) ⟶
      (continuousCohomology R W.toSubgroup n).obj
        ((Action.res _ W.toSubgroup.subtype).obj X) :=
  sorry

/-- **Layer 10, corestriction between two open subgroups,** `cor_W^V` for open `W ≤ V ≤ G`. The
relative form of `corestriction`, obtained by running the same Shapiro-then-trace construction
inside `V`. -/
noncomputable def corestrictionLe (V W : OpenSubgroup G) (hWV : W ≤ V) (X : TopRep R G)
    (hX : IsSmoothDiscrete R X) (n : ℕ) :
    (continuousCohomology R W.toSubgroup n).obj ((Action.res _ W.toSubgroup.subtype).obj X) ⟶
      (continuousCohomology R V.toSubgroup n).obj
        ((Action.res _ V.toSubgroup.subtype).obj X) :=
  sorry

/-- **Layer 2, the conjugate of an open subgroup,** `gUg⁻¹`. Conjugation is a homeomorphism, so the
conjugate of an open subgroup is open. -/
def conjOpenSubgroup (g : G) (U : OpenSubgroup G) : OpenSubgroup G where
  toSubgroup := U.toSubgroup.map (MulAut.conj g).toMonoidHom
  isOpen' := sorry

/-- **Layer 2, the conjugation isomorphism on cohomology,** `(g)_*`, between the cohomology of two
named subgroups related by conjugation. It is the compatible pair (conjugation by `g`, the action
of `g`). The Mackey formula names this map; a sum over an arbitrary family of morphisms would be a
different statement, and a false one. -/
noncomputable def conjMapOf (g : G) (W W' : OpenSubgroup G) (hconj : W' = conjOpenSubgroup g W)
    (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R W.toSubgroup n).obj ((Action.res _ W.toSubgroup.subtype).obj X) ⟶
      (continuousCohomology R W'.toSubgroup n).obj
        ((Action.res _ W'.toSubgroup.subtype).obj X) :=
  sorry

/-- **Layer 2, conjugation distributes over the Mackey intersections.** The group-theoretic fact
that makes one term of the Mackey formula typecheck. -/
theorem conjOpenSubgroup_inf (g : G) (U V : OpenSubgroup G) :
    V ⊓ conjOpenSubgroup g U = conjOpenSubgroup g (U ⊓ conjOpenSubgroup g⁻¹ V) :=
  sorry

/-- **Layer 10, milestone 3: transitivity,** `cor_V^G = cor_U^G ∘ cor_V^U` for open `V ≤ U ≤ G`. -/
theorem corestriction_trans (U V : OpenSubgroup G) (hVU : V ≤ U) (X : TopRep R G)
    (hX : IsSmoothDiscrete R X) (n : ℕ) :
    corestriction R V X hX n = corestrictionLe R U V hVU X hX n ≫ corestriction R U X hX n :=
  sorry

/-- **Layer 10, milestone 4: one term of the Mackey double-coset formula,**
`cor^V_{V ⊓ gUg⁻¹} ∘ (g)_* ∘ res^U_{U ⊓ g⁻¹Vg}`. It is named, rather than left as a parameter of
the formula, so that the formula states which sum is meant. -/
noncomputable def mackeyTerm (U V : OpenSubgroup G) (g : G) (X : TopRep R G)
    (hX : IsSmoothDiscrete R X) (n : ℕ) :
    (continuousCohomology R U.toSubgroup n).obj ((Action.res _ U.toSubgroup.subtype).obj X) ⟶
      (continuousCohomology R V.toSubgroup n).obj
        ((Action.res _ V.toSubgroup.subtype).obj X) :=
  resLe R U (U ⊓ conjOpenSubgroup g⁻¹ V) inf_le_left X n ≫
    conjMapOf R g (U ⊓ conjOpenSubgroup g⁻¹ V) (V ⊓ conjOpenSubgroup g U)
        (conjOpenSubgroup_inf g U V) X n ≫
      corestrictionLe R V (V ⊓ conjOpenSubgroup g U) inf_le_left X hX n

/-- **Layer 10, milestone 4: the Mackey double-coset formula in every degree** (NSW (1.5.6)). The
double cosets are supplied as a finite family of representatives, since the indexing set is what
the formula is a sum over; `hdc` says the family is exactly a system of representatives. -/
theorem corestriction_mackey (U V : OpenSubgroup G) (X : TopRep R G)
    (hX : IsSmoothDiscrete R X) (n : ℕ)
    (ι : Type) [Fintype ι] (g : ι → G)
    (hdc : ∀ x : G, ∃! i : ι, ∃ v ∈ V, ∃ u ∈ U, x = v * g i * u) :
    corestriction R U X hX n ≫ res R V.toSubgroup X n =
      ∑ i : ι, mackeyTerm R U V (g i) X hX n :=
  sorry

/-- **Layer 10, milestone 3: `cor ∘ res = (G : U) • id`,** with Layer 1's restriction on the left.
The normalization is this order and this scalar. -/
theorem corestriction_comp_res (U : OpenSubgroup G) (X : TopRep R G)
    (hX : IsSmoothDiscrete R X) (n : ℕ) :
    res R U.toSubgroup X n ≫ corestriction R U X hX n = (U.toSubgroup.index : ℤ) • 𝟙 _ :=
  sorry

end AllDegreeCorestriction

/-- **Layers 3 and 10, milestone 5: agreement of the all-degree corestriction with Layer 6's
explicit transversal formula,** in degree 1, as a commuting square. The degree-0 and degree-2
statements have the same shape. This carries its own binders because the explicit model of Layer 2
lives in `Type` while the all-degree section is universe polymorphic. -/
theorem explicitIso_cor (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G]
    (M : Type) [AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
    (U : OpenSubgroup G) [CompactSpace U.toSubgroup] [TotallyDisconnectedSpace U.toSubgroup]
    (x : DiscreteH1 U.toSubgroup M) :
    (corestriction ℤ U (ofDiscreteModule G M) (ofDiscreteModule_isSmoothDiscrete G M) 1).hom
        (((continuousCohomology ℤ U.toSubgroup 1).map
            (ofDiscreteModuleRes G M U.toSubgroup).inv).hom
          ((explicitH1IsoContinuousCohomology U.toSubgroup M).hom.hom x)) =
      (explicitH1IsoContinuousCohomology G M).hom.hom
        (explicitCor1 G M U (discreteH1Equiv U.toSubgroup M x) : DiscreteH1 G M) :=
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

/-- **Layer 9, `G_K`, fixed once.** The roadmap's absolute Galois group is the automorphisms of
the **separable** closure. Mathlib's `Field.absoluteGaloisGroup` uses the algebraic closure, whose
fixed field is the purely inseparable closure for imperfect `K`; the two are related by a
topological group equivalence, which is a Layer 9 milestone and not a definitional identity. -/
abbrev AbsoluteGaloisGroup (K : Type*) [Field K] : Type _ :=
  SeparableClosure K ≃ₐ[K] SeparableClosure K

/-- **Layer 9, `μₙ`,** the `n`-th roots of unity in the separable closure, as a subgroup of
`(Kˢ)ˣ`. -/
noncomputable def muN (K : Type*) [Field K] (n : ℕ) : Subgroup (SeparableClosure K)ˣ :=
  rootsOfUnity n (SeparableClosure K)

set_option synthInstance.maxHeartbeats 80000 in
/-- **Layer 9, `((Kˢ)ˣ)^{G_K}`.** -/
def unitsInvariants (K : Type*) [Field K] : Subgroup (SeparableClosure K)ˣ where
  carrier := {u | ∀ g : AbsoluteGaloisGroup K, g • u = u}
  mul_mem' {a b} ha hb g := by rw [smul_mul', ha g, hb g]
  one_mem' g := smul_one g
  inv_mem' {a} ha g := by rw [smul_inv', ha g]

/-- **Layer 9, `Kˣ ≅ ((Kˢ)ˣ)^{G_K}`.** These are not the same Lean type, so the roadmap names the
canonical equivalence rather than calling them equal. It is induced by the algebra map and the
fixed-field theorem, and it is the map the Kummer connecting homomorphism starts from. -/
noncomputable def baseUnitsEquivInvariants (K : Type*) [Field K] :
    Kˣ ≃* unitsInvariants K :=
  sorry

set_option synthInstance.maxHeartbeats 80000 in
/-- **Layer 9, `μₙ` is `G_K`-stable.** -/
theorem smul_mem_muN {K : Type*} [Field K] {n : ℕ} (g : AbsoluteGaloisGroup K)
    {ζ : (SeparableClosure K)ˣ} (h : ζ ∈ muN K n) : g • ζ ∈ muN K n := by
  rw [muN, mem_rootsOfUnity] at *
  rw [← smul_pow', h, smul_one]

set_option synthInstance.maxHeartbeats 80000 in
/-- **Layer 9, the natural `G_K`-action on `μₙ`.** The action is what continuous cohomology
depends on, so it is installed rather than assumed. -/
noncomputable instance muNAction {K : Type*} [Field K] {n : ℕ} :
    MulDistribMulAction (AbsoluteGaloisGroup K) (muN K n) where
  smul g ζ := ⟨g • (ζ : (SeparableClosure K)ˣ), smul_mem_muN g ζ.2⟩
  one_smul _ := Subtype.ext (one_smul _ _)
  mul_smul _ _ _ := Subtype.ext (mul_smul _ _ _)
  smul_mul _ _ _ := Subtype.ext (smul_mul' _ _ _)
  smul_one _ := Subtype.ext (smul_one _)

/-- **Layer 9, the Kummer coefficient module.** `μₙ` written additively, through the pin's
`Additive` idiom, and this is the coefficient object the Kummer isomorphism is stated against. -/
abbrev KummerCoeff (K : Type*) [Field K] (n : ℕ) : Type _ := Additive (muN K n)

noncomputable instance {K : Type*} [Field K] {n : ℕ} :
    TopologicalSpace (KummerCoeff K n) := ⊥

noncomputable instance {K : Type*} [Field K] {n : ℕ} :
    DiscreteTopology (KummerCoeff K n) := ⟨rfl⟩

/-- Mathlib has no bridge from `MulDistribMulAction M A` to `DistribMulAction M (Additive A)`, so
the Galois action is transported to additive notation here. -/
noncomputable instance {K : Type*} [Field K] {n : ℕ} :
    DistribMulAction (AbsoluteGaloisGroup K) (KummerCoeff K n) where
  smul g x := Additive.ofMul (g • Additive.toMul x)
  one_smul x := by
    show Additive.ofMul ((1 : AbsoluteGaloisGroup K) • Additive.toMul x) = _
    rw [one_smul]; rfl
  mul_smul g h x := by
    show Additive.ofMul ((g * h) • Additive.toMul x) = _
    rw [mul_smul]; rfl
  smul_zero g := by
    show Additive.ofMul (g • (1 : muN K n)) = _
    rw [smul_one]; rfl
  smul_add g x y := by
    show Additive.ofMul (g • (Additive.toMul x * Additive.toMul y)) = _
    rw [smul_mul']; rfl

/-- **Layer 9, the action is continuous,** since the stabilizer of a root of unity is open. -/
theorem kummerCoeff_continuousSMul (K : Type*) [Field K] (n : ℕ) :
    ContinuousSMul (AbsoluteGaloisGroup K) (KummerCoeff K n) :=
  sorry

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
map induces the Kummer isomorphism `Kˣ ⧸ (Kˣ)ⁿ ≅ H¹(G_K, μₙ)`, which is `kummerIso` below,
against Layer 2's explicit `H¹`. This statement is the cocycle it is built from. -/
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

section KummerClass

variable (K : Type*) [Field K] (n : ℕ) [NeZero n]

/-- **Layer 9, the Kummer map at class level.** The target names the canonical coefficient object,
not an arbitrary module carrying an arbitrary action: continuous cohomology depends on the action,
and a plain group equivalence with `μₙ` would not pin it, so the same abstract cyclic group with
the trivial action would satisfy a generically quantified statement for which the theorem is
false. -/
noncomputable def kummerMap (hn : IsUnit (n : K)) :
    Kˣ →* Multiplicative (H1 (AbsoluteGaloisGroup K) (KummerCoeff K n)) :=
  sorry

/-- **Layer 9, the Kummer isomorphism,** milestone 7 of the layer and the statement the Local
Fields and Quadratic Form Invariants roadmaps consume. The kernel of `kummerMap` is `(Kˣ)ⁿ` and
its surjectivity is Hilbert 90. -/
noncomputable def kummerIso (hn : IsUnit (n : K)) :
    powerClassQuotient K n ≃*
      Multiplicative (H1 (AbsoluteGaloisGroup K) (KummerCoeff K n)) :=
  sorry

/-- **Layer 9, transport along an identification of coefficients.** A consumer that carries its
own model of `μₙ` may use it, but only through a **continuous `G_K`-equivariant** additive
equivalence: the equivariance law `hequiv` is the hypothesis a plain group equivalence lacks, and
the conclusion is the transported isomorphism itself, not a claim that one exists. -/
noncomputable def kummerIsoTransport (hn : IsUnit (n : K))
    (μ : Type*) [AddCommGroup μ] [TopologicalSpace μ] [IsTopologicalAddGroup μ]
    [DiscreteTopology μ] [DistribMulAction (AbsoluteGaloisGroup K) μ]
    (e : KummerCoeff K n ≃+ μ) (he : Continuous e)
    (hequiv : ∀ (g : AbsoluteGaloisGroup K) (x : KummerCoeff K n), e (g • x) = g • e x) :
    powerClassQuotient K n ≃* Multiplicative (H1 (AbsoluteGaloisGroup K) μ) :=
  sorry

/-- **Layer 9, the map of power classes along a field extension,** the identity on representatives
followed by the quotient. -/
noncomputable def powerClassMap (L : Type*) [Field L] [Algebra K L] :
    powerClassQuotient K n →* powerClassQuotient L n :=
  sorry

/-- **Layer 9, the norm on power classes,** induced by `N_{L/K}` on units. -/
noncomputable def powerClassNorm (L : Type*) [Field L] [Algebra K L] [FiniteDimensional K L] :
    powerClassQuotient L n →* powerClassQuotient K n :=
  sorry

/-- **Layer 9, restriction on the Kummer `H¹` along a chosen `K`-embedding of `L` into a separable
closure of `K`.** The embedding is genuine data: without one there is no map `G_L → G_K` at all, so
a square stated for an arbitrary homomorphism is a different statement, and a false one. -/
noncomputable def kummerRes (L : Type*) [Field L] [Algebra K L] [FiniteDimensional K L]
    [Algebra.IsSeparable K L] (ι : L →ₐ[K] SeparableClosure K) :
    Multiplicative (H1 (AbsoluteGaloisGroup K) (KummerCoeff K n)) →*
      Multiplicative (H1 (AbsoluteGaloisGroup L) (KummerCoeff L n)) :=
  sorry

/-- **Layer 9, corestriction on the Kummer `H¹` along the same embedding.** The embedding realizes
`G_L` as an open subgroup of `G_K`, which is what makes the transfer available. -/
noncomputable def kummerCor (L : Type*) [Field L] [Algebra K L] [FiniteDimensional K L]
    [Algebra.IsSeparable K L] (ι : L →ₐ[K] SeparableClosure K) :
    Multiplicative (H1 (AbsoluteGaloisGroup L) (KummerCoeff L n)) →*
      Multiplicative (H1 (AbsoluteGaloisGroup K) (KummerCoeff K n)) :=
  sorry

/-- **Layer 9, the restriction square.** For a finite separable `L/K` with a chosen `K`-embedding
of `L` into `Kˢ`, restriction on cohomology corresponds to the map of power classes. -/
theorem kummerIso_res (hn : IsUnit (n : K)) (L : Type*) [Field L] [Algebra K L]
    [FiniteDimensional K L] [Algebra.IsSeparable K L] (hnL : IsUnit (n : L))
    (ι : L →ₐ[K] SeparableClosure K) (x : powerClassQuotient K n) :
    kummerRes K n L ι (kummerIso K n hn x) = kummerIso L n hnL (powerClassMap K n L x) :=
  sorry

/-- **Layer 9, the norm square.** Corestriction corresponds to the field norm `N_{L/K}`. -/
theorem kummerIso_norm (hn : IsUnit (n : K)) (L : Type*) [Field L] [Algebra K L]
    [FiniteDimensional K L] [Algebra.IsSeparable K L] (hnL : IsUnit (n : L))
    (ι : L →ₐ[K] SeparableClosure K) (y : powerClassQuotient L n) :
    kummerCor K n L ι (kummerIso L n hnL y) = kummerIso K n hn (powerClassNorm K n L y) :=
  sorry

end KummerClass

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

/-! ### Layer 12: the graded cup product in all degrees -/

section GradedCup

open CategoryTheory

variable {R : Type u} [CommRing R] [TopologicalSpace R]
  {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]

/-- **Layer 12, milestone 1: the coefficient pairing.** The input type of the whole layer: an
`R`-bilinear map that is jointly continuous and `G`-equivariant. Joint continuity is automatic
when the coefficients are discrete, which is every arithmetic application, and is not automatic in
general, which is why it is carried. -/
structure TopPairing (X Y Z : TopRep R G) where
  /-- the underlying bilinear map -/
  bil : X.V →ₗ[R] Y.V →ₗ[R] Z.V
  /-- joint continuity -/
  cont : Continuous fun p : X.V × Y.V => bil p.1 p.2
  /-- equivariance -/
  equivariant : ∀ (g : G) (x : X.V) (y : Y.V),
    bil ((X.ρ g).hom x) ((Y.ρ g).hom y) = (Z.ρ g).hom (bil x y)

/-- Transport along an equality of degrees. The cup lands in `H^{m+n}`, and `(p+q)+r` and
`p+(q+r)` are equal but not definitionally so, so associativity and commutativity are stated
through this. -/
noncomputable def degreeCast {m n : ℕ} (h : m = n) (X : TopRep R G) :
    (continuousCohomology R G m).obj X → (continuousCohomology R G n).obj X :=
  fun x => h ▸ x

/-- **Layer 1, the class of an invariant coefficient in degree 0.** Degree 0 is the invariants, so
an invariant element has a class; this is the map the unit laws below name. -/
noncomputable def degreeZeroClass (Y : TopRep R G) (u : Y.V)
    (hinv : ∀ g : G, (Y.ρ g).hom u = u) : (continuousCohomology R G 0).obj Y :=
  sorry

/-- Transport along an equality of degrees, at cochain level. `(m + 1) + n` and `m + (n + 1)` are
equal but not definitionally so, which is why the Leibniz identity below needs it. -/
noncomputable def cochainDegreeCast {m n : ℕ} (h : m = n) (X : TopRep R G) :
    ((ContinuousCohomology.homogeneousCochains R G).obj X).X m →
      ((ContinuousCohomology.homogeneousCochains R G).obj X).X n :=
  fun x => h ▸ x

/-- **Layer 12, milestone 3: the cochain-level product,** on the terms of the complex the carrier
is the homology of. The Leibniz identity is a statement about this, not about classes. -/
noncomputable def cupCochain {X Y Z : TopRep R G} (P : TopPairing X Y Z) (m n : ℕ) :
    ((ContinuousCohomology.homogeneousCochains R G).obj X).X m →
      ((ContinuousCohomology.homogeneousCochains R G).obj Y).X n →
        ((ContinuousCohomology.homogeneousCochains R G).obj Z).X (m + n) :=
  sorry

/-- **Layer 12, milestone 5: the cup product in bidegree `(m, n)`.** A plain function here
because the milestones that make it biadditive, associative and graded commutative are separate;
stating it as an additive map before those are proved would assert them. -/
noncomputable def cup {X Y Z : TopRep R G} (P : TopPairing X Y Z) (m n : ℕ) :
    ((continuousCohomology R G m).obj X) → ((continuousCohomology R G n).obj Y) →
      ((continuousCohomology R G (m + n)).obj Z) :=
  sorry

variable {X Y Z : TopRep R G}

/-- **Layer 12, milestone 4: the Leibniz identity,** with the sign convention fixed here. -/
theorem cupCochain_leibniz (P : TopPairing X Y Z) (m n : ℕ)
    (a : ((ContinuousCohomology.homogeneousCochains R G).obj X).X m)
    (b : ((ContinuousCohomology.homogeneousCochains R G).obj Y).X n) :
    (((ContinuousCohomology.homogeneousCochains R G).obj Z).d (m + n) (m + n + 1)).hom
        (cupCochain P m n a b) =
      cochainDegreeCast (by omega) Z
          (cupCochain P (m + 1) n
            ((((ContinuousCohomology.homogeneousCochains R G).obj X).d m (m + 1)).hom a) b) +
        ((-1 : R) ^ m) •
          cupCochain P m (n + 1) a
            ((((ContinuousCohomology.homogeneousCochains R G).obj Y).d n (n + 1)).hom b) :=
  sorry

/-- **Layer 12, milestone 5: additivity in the first argument.** -/
theorem cup_add_left (P : TopPairing X Y Z) (m n : ℕ)
    (a a' : (continuousCohomology R G m).obj X)
    (b : (continuousCohomology R G n).obj Y) :
    cup P m n (a + a') b = cup P m n a b + cup P m n a' b :=
  sorry

/-- **Layer 12, milestone 5: additivity in the second argument.** -/
theorem cup_add_right (P : TopPairing X Y Z) (m n : ℕ)
    (a : (continuousCohomology R G m).obj X)
    (b b' : (continuousCohomology R G n).obj Y) :
    cup P m n a (b + b') = cup P m n a b + cup P m n a b' :=
  sorry

/-- **Layer 12, milestone 6: the unit on the right.** For a discrete `G`-ring the class of `1` in
`H⁰` is a unit for the cup; the hypothesis is the coefficient-level equation and the conclusion is
the class-level one. -/
theorem cup_one_right (P : TopPairing X Y X) (u : Y.V) (hinv : ∀ g : G, (Y.ρ g).hom u = u)
    (hu : ∀ x : X.V, P.bil x u = x) (m : ℕ) (a : (continuousCohomology R G m).obj X) :
    cup P m 0 a (degreeZeroClass Y u hinv) = a :=
  sorry

/-- **Layer 12, milestone 6: the unit on the left.** -/
theorem cup_one_left (P : TopPairing Y X X) (u : Y.V) (hinv : ∀ g : G, (Y.ρ g).hom u = u)
    (hu : ∀ x : X.V, P.bil u x = x) (n : ℕ) (a : (continuousCohomology R G n).obj X) :
    cup P 0 n (degreeZeroClass Y u hinv) a = degreeCast (Nat.zero_add n).symm X a :=
  sorry

/-- **Layer 12, milestone 7: associativity,** for the four-pairing input of Layer 8 with its
coefficient identity. -/
theorem cup_assoc {A B C D E F : TopRep R G} (μ₁ : TopPairing A B D) (μ₂ : TopPairing D C E)
    (ν₁ : TopPairing B C F) (ν₂ : TopPairing A F E)
    (hcoeff : ∀ (a : A.V) (b : B.V) (c : C.V), μ₂.bil (μ₁.bil a b) c = ν₂.bil a (ν₁.bil b c))
    (p q r : ℕ) (x : (continuousCohomology R G p).obj A)
    (y : (continuousCohomology R G q).obj B) (z : (continuousCohomology R G r).obj C) :
    cup μ₂ (p + q) r (cup μ₁ p q x y) z =
      degreeCast (Nat.add_assoc p q r).symm E (cup ν₂ p (q + r) x (cup ν₁ q r y z)) :=
  sorry

/-- **Layer 12, milestone 8: graded commutativity,** on classes, with the opposite pairing given
by its defining equation. -/
theorem cup_gradedComm (P : TopPairing X Y Z) (Pop : TopPairing Y X Z)
    (hop : ∀ (x : X.V) (y : Y.V), Pop.bil y x = P.bil x y) (m n : ℕ)
    (a : (continuousCohomology R G m).obj X) (b : (continuousCohomology R G n).obj Y) :
    cup P m n a b =
      ((-1 : R) ^ (m * n)) • degreeCast (Nat.add_comm n m) Z (cup Pop n m b a) :=
  sorry

/-- **Layer 12, milestone 9: restriction compatibility.** The restricted pairing is supplied with
its defining equation, since restriction does not change the coefficient map. -/
theorem cup_res (P : TopPairing X Y Z) (S : Subgroup G)
    (Pres : TopPairing ((Action.res _ S.subtype).obj X) ((Action.res _ S.subtype).obj Y)
      ((Action.res _ S.subtype).obj Z))
    (hPres : Pres.bil = P.bil) (m n : ℕ)
    (a : (continuousCohomology R G m).obj X) (b : (continuousCohomology R G n).obj Y) :
    (res R S Z (m + n)).hom (cup P m n a b) =
      cup Pres m n ((res R S X m).hom a) ((res R S Y n).hom b) :=
  sorry

/-- **Layer 12, milestone 9: inflation compatibility.** The quotient pairing is supplied with its
defining equation, which unlike the restricted case cannot be an equality of bilinear maps: the
invariants are a different module, so the two pairings are compared after including the invariants
into the object along `quotientToInvariantsι`. -/
theorem cup_infl (N : Subgroup G) [N.Normal] [IsTopologicalGroup (G ⧸ N)] (P : TopPairing X Y Z)
    (Pinv : TopPairing (quotientToInvariants R N X) (quotientToInvariants R N Y)
      (quotientToInvariants R N Z))
    (hPinv : ∀ (x : (quotientToInvariants R N X).V) (y : (quotientToInvariants R N Y).V),
      (quotientToInvariantsι R N Z).hom (Pinv.bil x y) =
        P.bil ((quotientToInvariantsι R N X).hom x) ((quotientToInvariantsι R N Y).hom y))
    (m n : ℕ)
    (a : (continuousCohomology R (G ⧸ N) m).obj (quotientToInvariants R N X))
    (b : (continuousCohomology R (G ⧸ N) n).obj (quotientToInvariants R N Y)) :
    (infl R N Z (m + n)).hom (cup Pinv m n a b) =
      cup P m n ((infl R N X m).hom a) ((infl R N Y n).hom b) :=
  sorry

/-- **Layer 12, milestone 10: the projection formula,** with Layer 10's corestriction. -/
theorem cup_projection [CompactSpace G] [TotallyDisconnectedSpace G] (U : OpenSubgroup G)
    (hY : IsSmoothDiscrete R Y) (hZ : IsSmoothDiscrete R Z)
    (P : TopPairing X Y Z)
    (Pres : TopPairing ((Action.res _ U.toSubgroup.subtype).obj X)
      ((Action.res _ U.toSubgroup.subtype).obj Y)
      ((Action.res _ U.toSubgroup.subtype).obj Z))
    (hPres : Pres.bil = P.bil) (m n : ℕ)
    (a : (continuousCohomology R G m).obj X)
    (b : (continuousCohomology R U.toSubgroup n).obj
      ((Action.res _ U.toSubgroup.subtype).obj Y)) :
    (corestriction R U Z hZ (m + n)).hom
        (cup Pres m n ((res R U.toSubgroup X m).hom a) b) =
      cup P m n a ((corestriction R U Y hY n).hom b) :=
  sorry

end GradedCup

section CupComparison

open CategoryTheory

variable (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  (M N P : Type) [AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M]
  [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M]
  [AddCommGroup N] [TopologicalSpace N] [IsTopologicalAddGroup N]
  [DiscreteTopology N] [DistribMulAction G N] [ContinuousSMul G N]
  [AddCommGroup P] [TopologicalSpace P] [IsTopologicalAddGroup P]
  [DiscreteTopology P] [DistribMulAction G P] [ContinuousSMul G P]

/-- **Layer 12, the pairing of canonical objects induced by an equivariant pairing of discrete
modules.** Layer 1's dictionary carries the coefficients; this carries the pairing, so that the
agreement statement below has one pairing on each side and neither is arbitrary. -/
noncomputable def ofDiscreteModulePairing (μ : M →+ N →+ P)
    (hμ : Continuous fun p : M × N => μ p.1 p.2)
    (hequiv : ∀ (g : G) (m : M) (x : N), μ (g • m) (g • x) = g • μ m x) :
    TopPairing (ofDiscreteModule G M) (ofDiscreteModule G N) (ofDiscreteModule G P) :=
  sorry

/-- **Layer 8, the `(1,1)` cup product on the explicit model,** at class level: the descent of the
cochain formula `(a ⌣ b)(g, h) = μ (a g) (g • b h)` of `README.md` §3. -/
noncomputable def explicitCup11 (μ : M →+ N →+ P)
    (hμ : Continuous fun p : M × N => μ p.1 p.2)
    (hequiv : ∀ (g : G) (m : M) (x : N), μ (g • m) (g • x) = g • μ m x) :
    H1 G M →+ H1 G N →+ H2 G P :=
  sorry

/-- **Layer 12, milestone 11: agreement with Layer 8's six explicit shapes** under Layer 3. The
`(1,1)` shape is stated; the other five have the same form. Both cup products are named, so the
statement is that these two agree and not that the canonical one agrees with something. -/
theorem explicitIso_cup [CompactSpace G] [TotallyDisconnectedSpace G] (μ : M →+ N →+ P)
    (hμ : Continuous fun p : M × N => μ p.1 p.2)
    (hequiv : ∀ (g : G) (m : M) (x : N), μ (g • m) (g • x) = g • μ m x)
    (x : DiscreteH1 G M) (y : DiscreteH1 G N) :
    cup (ofDiscreteModulePairing G M N P μ hμ hequiv) 1 1
        ((explicitH1IsoContinuousCohomology G M).hom.hom x)
        ((explicitH1IsoContinuousCohomology G N).hom.hom y) =
      (explicitH2IsoContinuousCohomology G P).hom.hom
        (explicitCup11 G M N P μ hμ hequiv (discreteH1Equiv G M x) (discreteH1Equiv G N y) :
          DiscreteH2 G P) :=
  sorry

end CupComparison

/-! ### Layer 13: the Evens norm -/

section GeneralEvens

variable (D : Type*) [Group D] (Q : Type*) [Group Q] (X : Type*) [MulAction Q X]

/-- **Layer 13, milestone 1: the permutation action of `Q` on `X → D`.** -/
noncomputable def wreathAut : Q →* MulAut (X → D) := sorry

/-- **Layer 13, milestone 1: the permutation wreath product `(X → D) ⋊ Q`.** Mathlib has only the
**regular** `RegularWreathProduct`, which is the case `X = Q`; the norm needs `Uˡ ⋊ 𝔖_l` for the
standard action of `𝔖_l` on `Fin l`. The base factor is `X → D` and the top factor is `Q`, which
the docstring says because sources disagree about the notation. -/
abbrev PermutationWreathProduct : Type _ := SemidirectProduct (X → D) Q (wreathAut D Q X)

/-- **Layer 13, milestone 2: the topology on the permutation wreath product.** The base factor
`X → D` carries the product topology and the top factor is discrete, since for the norm it is the
finite symmetric group. This is the topology the monomial homomorphism is continuous for, and it is
a definition rather than an instance because `PermutationWreathProduct` abbreviates
`SemidirectProduct`, on which no such global instance should be imposed. -/
@[reducible] def wreathTopology [TopologicalSpace D] :
    TopologicalSpace (PermutationWreathProduct D Q X) :=
  TopologicalSpace.induced (fun w => (w.left : X → D)) inferInstance ⊓
    TopologicalSpace.induced (fun w => (w.right : Q)) ⊥

end GeneralEvens

/-! ### Layer 13: the explicit index-2 graph cocycle

This block comes before the norm because the index-2 class **is** the class of the cochain built
here: `graphClass` below is defined from `evensGraphCochain`, not declared alongside it. -/

section IndexTwoCochains

variable {G : Type*} [Group G] (U : Subgroup G) (s : G) (α : U →* Multiplicative (ZMod 2))

open scoped Classical in
/-- **Layer 13, a degree-1 class of an open subgroup, extended by zero.** `α` is a genuine
continuous homomorphism on the subgroup, that is a trivial-action 1-cocycle of `U`; this is
its extension by zero to `G`, from which the Shapiro components are built. -/
noncomputable def evensExtend : G → ZMod 2 :=
  fun γ ↦ if h : γ ∈ U then Multiplicative.toAdd (α ⟨γ, h⟩) else 0

open scoped Classical in
/-- **Layer 13, the first Shapiro component** `b₁ γ = α γ` for `γ ∈ U` and `α (γ s)` otherwise.

It is a **cochain and not a cocycle**, so it has no class of its own. For `G = C₄ = ⟨σ⟩`,
`U = ⟨σ²⟩` of index two, `s = σ` and `α ≠ 0`, its values at `1, σ, σ², σ³` are `0, 1, 1, 0`, so
`b₁ (σ * σ) = 1` while `b₁ σ + b₁ σ = 0` and `b₁` is not a homomorphism. Only the sum
`b₁ + b_s` is a cocycle, which is why only that sum is given a class below. -/
noncomputable def evensB1 : G → ZMod 2 :=
  fun γ ↦ if γ ∈ U then evensExtend U α γ else evensExtend U α (γ * s)

/-- **Layer 13, the second Shapiro component** `b_s γ = b₁ (s⁻¹ γ)`. A cochain, for the same
reason as `evensB1`. -/
noncomputable def evensBs : G → ZMod 2 :=
  fun γ ↦ evensB1 U s α (s⁻¹ * γ)

/-- **Layer 13, identity 3 at cochain level: the degree-1 corestriction cochain** `b₁ + b_s`, the
sum of the Shapiro components over the transversal `{1, s}`. The decomposition into the two
components is definitional here; that the sum is a cocycle, and that its class is Layer 10's
corestriction, are the two theorems below. -/
noncomputable def evensCorCochain : G → ZMod 2 :=
  fun γ ↦ evensB1 U s α γ + evensBs U s α γ

open scoped Classical in
/-- **Layer 13, the two-point graph 2-cochain.** With `(G : U) = 2` and `s ∉ U`,

`ν (γ, η) = b₁ γ * b_s η` if `γ ∈ U`, and `b₁ γ * b₁ η + b₁ η * b_s η` otherwise.

Its class is the index-2 Evens norm `N^{Ev}(α) ∈ H²(G, 𝔽₂)`. The definition is given here
rather than passed as an arbitrary function with side conditions, so that the statements
below are about this cochain and not about anything satisfying its equations. -/
noncomputable def evensGraphCochain : G × G → ZMod 2 :=
  fun q ↦ if q.1 ∈ U then evensB1 U s α q.1 * evensBs U s α q.2
    else evensB1 U s α q.1 * evensB1 U s α q.2 + evensB1 U s α q.2 * evensBs U s α q.2

end IndexTwoCochains

section IndexTwoCochainProperties

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  (U : OpenSubgroup G) (s : G) (α : U.toSubgroup →* Multiplicative (ZMod 2))

/-- **Layer 13, the corestriction cochain is a continuous 1-cocycle.** With trivial coefficients a
1-cocycle is a homomorphism, and the index-two and `s ∉ U` hypotheses are both used: the two
expansion cross terms recombine only there. Neither `evensB1` nor `evensBs` satisfies this, which
is why identity 3 below is stated for the sum and not for the two components separately. -/
theorem evensCorCochain_isCocycle (hU : U.toSubgroup.index = 2) (hs : s ∉ U)
    (hα : Continuous α) :
    Continuous (evensCorCochain U.toSubgroup s α) ∧
      ∀ g h : G, evensCorCochain U.toSubgroup s α (g * h) =
        evensCorCochain U.toSubgroup s α g + evensCorCochain U.toSubgroup s α h :=
  sorry

/-- **Layer 13, the graph cochain is a continuous 2-cocycle.** Continuity belongs in the
conclusion: an open subgroup is clopen, so the case split is continuous, and `α` is
continuous by hypothesis. The 2-cocycle identity is the trivial-action form of
`groupCohomology.IsCocycle₂`. -/
theorem evensGraphCochain_isCocycle (hU : U.toSubgroup.index = 2) (hs : s ∉ U)
    (hα : Continuous α) :
    Continuous (evensGraphCochain U.toSubgroup s α) ∧
      ∀ g h j : G,
        evensGraphCochain U.toSubgroup s α (g * h, j) +
            evensGraphCochain U.toSubgroup s α (g, h) =
          evensGraphCochain U.toSubgroup s α (h, j) +
            evensGraphCochain U.toSubgroup s α (g, h * j) :=
  sorry

/-- **Layer 13, the class does not depend on the chosen `s`.** Two elements outside an
index-2 subgroup give graph cochains differing by an explicit continuous coboundary, so the
Evens norm is a well-defined map to `H²(G, 𝔽₂)`. -/
theorem evensGraphCochain_independent_of_rep (hU : U.toSubgroup.index = 2) (s' : G)
    (hs : s ∉ U) (hs' : s' ∉ U) (hα : Continuous α) :
    ∃ ψ : G → ZMod 2, Continuous ψ ∧ ∀ g h : G,
      evensGraphCochain U.toSubgroup s' α (g, h) - evensGraphCochain U.toSubgroup s α (g, h) =
        ψ h - ψ (g * h) + ψ g :=
  sorry

end IndexTwoCochainProperties

section EvensNorm

open CategoryTheory

variable (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]

/-- **Layer 13, the coefficient object.** `𝔽₂` with trivial action, as an object of the category
the all-degree carrier eats. The general norm is stated against this, not against Layer 2's
low-degree abbreviations, because its degree is not bounded by 2. -/
noncomputable def trivialF2 : TopRep ℤ G := ⟨TopModuleCat.of ℤ (ZMod 2), 1⟩

/-- **Layer 13, the trivial `𝔽₂` object is smooth discrete.** `ZMod 2` is discrete and the action is
trivial, so every stabilizer is all of `G`. Layer 10's corestriction consumes this. -/
theorem trivialF2_isSmoothDiscrete : IsSmoothDiscrete ℤ (trivialF2 G) :=
  sorry

/-- **Layer 3, an explicit inhomogeneous 1-cochain as an element of the canonical complex,** with
trivial `𝔽₂` coefficients. The formulas of this layer are functions `G → 𝔽₂` and `G × G → 𝔽₂`, and
this is how they enter the complex whose homology the canonical objects are. Without it an identity
relating an explicit formula to a class could only be stated about an arbitrary element of the
complex. -/
noncomputable def inhomogeneousCochain1 (f : G → ZMod 2) (hf : Continuous f) :
    ((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).X 1 :=
  sorry

/-- **Layer 3, the same in degree 2.** -/
noncomputable def inhomogeneousCochain2 (f : G × G → ZMod 2) (hf : Continuous f) :
    ((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).X 2 :=
  sorry

/-- **Layer 3, the inhomogeneous 1-cocycle condition is the canonical differential.** With trivial
coefficients a 1-cocycle is a homomorphism. -/
theorem inhomogeneousCochain1_d_eq_zero (f : G → ZMod 2) (hf : Continuous f)
    (hcocycle : ∀ g h : G, f (g * h) = f g + f h) :
    (((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).d 1 2).hom
      (inhomogeneousCochain1 G f hf) = 0 :=
  sorry

/-- **Layer 3, the inhomogeneous 2-cocycle condition is the canonical differential.** -/
theorem inhomogeneousCochain2_d_eq_zero (f : G × G → ZMod 2) (hf : Continuous f)
    (hcocycle : ∀ g h j : G, f (g * h, j) + f (g, h) = f (h, j) + f (g, h * j)) :
    (((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).d 2 3).hom
      (inhomogeneousCochain2 G f hf) = 0 :=
  sorry

variable {G}

/-- **Layer 13, a coset transversal of an open subgroup,** bundled with the property that makes it
one. The monomial homomorphism and the cochain norm consume this and not a bare function: for an
arbitrary `rep` the Schreier factors `t(x)⁻¹ γ t(γ⁻¹ x)` need not lie in `U`, so the wreath-product
target could not be built by the advertised formula. -/
structure CosetTransversal (U : OpenSubgroup G) where
  /-- the chosen representative of each coset -/
  rep : G ⧸ U.toSubgroup → G
  /-- it represents that coset -/
  mk_rep : ∀ x, QuotientGroup.mk (rep x) = x

/-- **Layer 13, milestone 2: the transversal-dependent monomial homomorphism** `Φ : G → Uˡ ⋊ 𝔖_l`
for `l = (G : U)`. The base component of `Φ γ` at a coset `x` is the Schreier factor
`t(γ⁻¹ x)⁻¹ γ⁻¹ t(x)`, which lies in `U` exactly because `t` is a transversal, and the top
component is the permutation `x ↦ γ⁻¹ x` of the coset space. -/
noncomputable def monomialHom (U : OpenSubgroup G) [Fintype (G ⧸ U.toSubgroup)]
    (t : CosetTransversal U) :
    G →* PermutationWreathProduct U.toSubgroup (Equiv.Perm (G ⧸ U.toSubgroup))
      (G ⧸ U.toSubgroup) :=
  sorry

/-- **Layer 13, milestone 2: the monomial homomorphism is continuous,** for the topology
`wreathTopology` fixes on the target. Openness of `U` is what makes the coset space discrete and
the Schreier factors locally constant. -/
theorem monomialHom_continuous (U : OpenSubgroup G) [Fintype (G ⧸ U.toSubgroup)]
    (t : CosetTransversal U) :
    @Continuous G _ _ (wreathTopology U.toSubgroup (Equiv.Perm (G ⧸ U.toSubgroup))
      (G ⧸ U.toSubgroup)) (monomialHom U t) :=
  sorry

/-- **Layer 13, milestone 3: the tensor-power coefficient object,** with the permutation action of
the symmetric group and the induced wreath-product action, as an object of the canonical
coefficient category. A bare `Type` would carry none of that structure and could not be fed to the
cohomology functor. -/
noncomputable def tensorInduction (U : OpenSubgroup G) (q : ℕ) (A : TopRep ℤ U.toSubgroup) :
    TopRep ℤ G :=
  sorry

/-- **Layer 13, milestone 3: tensor induction is a functor.** -/
noncomputable def tensorInductionFunctor (U : OpenSubgroup G) (q : ℕ) :
    TopRep ℤ U.toSubgroup ⥤ TopRep ℤ G :=
  sorry

/-- **Layer 13, milestone 3: the functor agrees with the object construction.** -/
theorem tensorInductionFunctor_obj (U : OpenSubgroup G) (q : ℕ) (A : TopRep ℤ U.toSubgroup) :
    (tensorInductionFunctor U q).obj A = tensorInduction U q A :=
  sorry

/-- **Layer 13, milestone 3: tensor induction of the trivial `𝔽₂` object is the trivial `𝔽₂`
object.** The `l`-fold tensor power of `𝔽₂` is `𝔽₂`, and in characteristic two the permutation
action of `𝔖_l` on it is trivial. This is the coefficient equivalence through which the norm lands
in `H^*(G, 𝔽₂)`; without it the cochain norm has tensor-induced coefficients and there is nothing
tying it to the public target. -/
noncomputable def tensorInductionTrivialF2 (U : OpenSubgroup G) (q : ℕ) :
    tensorInduction U q (trivialF2 U.toSubgroup) ≅ trivialF2 G :=
  sorry

/-- **Layer 13, milestone 4: the norm at cochain level, before the coefficient equivalence.** This
is the map produced by `monomialHom` and `tensorInduction`: it is where the degree formula
`q ↦ l * q` comes from, and its coefficients are the tensor-induced ones. -/
noncomputable def evensNormCochainRaw (U : OpenSubgroup G) (q : ℕ) (t : CosetTransversal U) :
    ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
        (trivialF2 U.toSubgroup)).X q →
      ((ContinuousCohomology.homogeneousCochains ℤ G).obj
        (tensorInduction U q (trivialF2 U.toSubgroup))).X (U.toSubgroup.index * q) :=
  sorry

/-- **Layer 13, milestone 4: the norm at cochain level,** with the degree formula `q ↦ l * q`.
This is the map the public function descends from. -/
noncomputable def evensNormCochain (U : OpenSubgroup G) (q : ℕ) (t : CosetTransversal U) :
    ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
        (trivialF2 U.toSubgroup)).X q →
      ((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).X
        (U.toSubgroup.index * q) :=
  sorry

/-- **Layer 13, milestone 4: the cochain norm is the raw norm followed by the coefficient
equivalence.** This is what ties `monomialHom` and `tensorInduction` to the public construction;
without it they are declared and never used. -/
theorem evensNormCochain_eq (U : OpenSubgroup G) (q : ℕ) (t : CosetTransversal U)
    (a : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X q) :
    evensNormCochain U q t a =
      (((ContinuousCohomology.homogeneousCochains ℤ G).map
          (tensorInductionTrivialF2 U q).hom).f (U.toSubgroup.index * q)).hom
        (evensNormCochainRaw U q t a) :=
  sorry

/-- **Layer 13, milestone 5: the cochain norm sends cocycles to cocycles.** Without it the public
norm has no source of classes, and the degree `l * q` is not the degree of anything. -/
theorem evensNormCochain_mem_cycles (U : OpenSubgroup G) (q : ℕ) (t : CosetTransversal U)
    (a : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X q)
    (ha : (((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).d q (q + 1)).hom a = 0) :
    (((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).d
        (U.toSubgroup.index * q) (U.toSubgroup.index * q + 1)).hom
      (evensNormCochain U q t a) = 0 :=
  sorry

/-- **Layer 13, milestone 5: equivalent representatives give the same class.** Cohomologous source
cocycles have cohomologous norm cocycles. The norm is not additive, so this does not follow from
additivity and has to be its own milestone. -/
theorem evensNormCochain_representative_independent (U : OpenSubgroup G) (q : ℕ)
    (t : CosetTransversal U) (j : ℕ) (hj : j + 1 = q) (k : ℕ)
    (hk : k + 1 = U.toSubgroup.index * q)
    (a b : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X q)
    (ha : (((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).d q (q + 1)).hom a = 0)
    (hb : (((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).d q (q + 1)).hom b = 0)
    (c : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X j)
    (hc : a - b = cochainDegreeCast hj (trivialF2 U.toSubgroup)
      ((((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
        (trivialF2 U.toSubgroup)).d j (j + 1)).hom c)) :
    ∃ e : ((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).X k,
      evensNormCochain U q t a - evensNormCochain U q t b =
        cochainDegreeCast hk (trivialF2 G)
          ((((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).d k (k + 1)).hom
            e) :=
  sorry

/-- **Layer 13, milestone 7: the public norm.** A **function**, not an additive homomorphism and
not a categorical morphism: its failure of additivity is identity 2. The degree multiplies by the
index, which is the defining type-level feature of the construction. -/
noncomputable def evensNorm (U : OpenSubgroup G) (q : ℕ) :
    ((continuousCohomology ℤ U.toSubgroup q).obj (trivialF2 U.toSubgroup)) →
      ((continuousCohomology ℤ G (U.toSubgroup.index * q)).obj (trivialF2 G)) :=
  sorry

/-- **Layer 13, milestone 7: the public norm is the class of the norm cochain.** This is what makes
`evensNorm` the descent of `evensNormCochain` rather than an unrelated function of the same type.
Together with the two milestone-5 theorems and transversal independence it is what makes the
descent well defined. -/
theorem evensNorm_eq_class (U : OpenSubgroup G) (q : ℕ) (t : CosetTransversal U)
    (a : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X q)
    (ha : (((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).d q (q + 1)).hom a = 0) :
    evensNorm U q (cochainClass ℤ (trivialF2 U.toSubgroup) q a ha) =
      cochainClass ℤ (trivialF2 G) (U.toSubgroup.index * q) (evensNormCochain U q t a)
        (evensNormCochain_mem_cycles U q t a ha) :=
  sorry

/-- **Layer 13, the index-2 degree-1 specialization,** the case the sibling roadmap consumes. It
is a named specialization of the general norm, not the general definition. -/
noncomputable def evensNormIndexTwo (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2) :
    ((continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) →
      ((continuousCohomology ℤ G 2).obj (trivialF2 G)) :=
  sorry

/-- **Layer 13, milestone 10: the specialization is the general norm.** -/
theorem evensNormIndexTwo_eq (U : OpenSubgroup G) (hU : U.toSubgroup.index = 2)
    (x : (continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) :
    evensNormIndexTwo U hU x =
      degreeCast (by rw [hU]) (trivialF2 G) (evensNorm U 1 x) :=
  sorry

/-- **Layer 13, the coefficient pairing on `𝔽₂`,** multiplication with the trivial action. The
identities below name it: an arbitrary pairing of the trivial object with itself is a different
input, and the statements are false for it. -/
noncomputable def f2Pairing (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] :
    TopPairing (trivialF2 G) (trivialF2 G) (trivialF2 G) :=
  sorry

/-- **Layer 13, the image of an open subgroup in a quotient,** `U ⧸ N` as an open subgroup of
`G ⧸ N`, for closed normal `N ≤ U`. The inflation compatibility of the norm is a statement about
these two groups, so the subgroup has to be named before it can be stated. -/
def quotientOpenSubgroup (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    (U : OpenSubgroup G) (hNU : N ≤ U) :
    OpenSubgroup (G ⧸ N) where
  toSubgroup := U.toSubgroup.map (QuotientGroup.mk' N)
  isOpen' := sorry

/-- **Layer 13, the index is unchanged by passing to the quotient,** for `N ≤ U`. Without it the
two sides of the inflation compatibility below sit in different degrees. -/
theorem quotientOpenSubgroup_index (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    (U : OpenSubgroup G) (hNU : N ≤ U) :
    (quotientOpenSubgroup N hN U hNU).toSubgroup.index = U.toSubgroup.index :=
  sorry

/-- **Layer 13, the invariants of the trivial `𝔽₂` object are the trivial `𝔽₂` object.** -/
noncomputable def trivialF2Quotient (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    [IsTopologicalGroup (G ⧸ N)] :
    trivialF2 (G ⧸ N) ≅ quotientToInvariants ℤ N (trivialF2 G) :=
  sorry

/-- **Layer 13, inflation on trivial `𝔽₂` coefficients,** Layer 1's inflation composed with the
identification of the invariants of the trivial object. -/
noncomputable def trivialF2Infl (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    [IsTopologicalGroup (G ⧸ N)] (n : ℕ) :
    (continuousCohomology ℤ (G ⧸ N) n).obj (trivialF2 (G ⧸ N)) ⟶
      (continuousCohomology ℤ G n).obj (trivialF2 G) :=
  (continuousCohomology ℤ (G ⧸ N) n).map (trivialF2Quotient N hN).hom ≫ infl ℤ N (trivialF2 G) n

/-- **Layer 13, inflation from `U ⧸ N` to `U` on trivial `𝔽₂` coefficients,** where `U ⧸ N` is the
open subgroup `quotientOpenSubgroup N hN U hNU` of `G ⧸ N`. -/
noncomputable def trivialF2InflSub (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    (U : OpenSubgroup G) (hNU : N ≤ U) [IsTopologicalGroup (G ⧸ N)] (n : ℕ) :
    (continuousCohomology ℤ (quotientOpenSubgroup N hN U hNU).toSubgroup n).obj
        (trivialF2 (quotientOpenSubgroup N hN U hNU).toSubgroup) ⟶
      (continuousCohomology ℤ U.toSubgroup n).obj (trivialF2 U.toSubgroup) :=
  sorry

variable (U : OpenSubgroup G) (q : ℕ)

/-- **Layer 13, the norm between two open subgroups,** `N_V^U` for open `V ≤ U ≤ G`, with the
degree multiplied by the relative index. Transitivity below is a statement about this map. -/
noncomputable def evensNormLe (V : OpenSubgroup G) (hVU : V ≤ U) :
    ((continuousCohomology ℤ V.toSubgroup q).obj (trivialF2 V.toSubgroup)) →
      ((continuousCohomology ℤ U.toSubgroup
        (V.toSubgroup.relIndex U.toSubgroup * q)).obj (trivialF2 U.toSubgroup)) :=
  sorry

/-- **Layer 13, milestone 6: independence of the transversal,** at cochain level, where the
dependence lives: for a **cocycle** the two cochains differ by a coboundary of the canonical
complex. The cocycle hypothesis is not removable. For a general cochain the difference is a
coboundary only up to a further term in the source differential, so the unconditional statement is
a different and stronger claim; that stronger form is the cochain homotopy, and it is not what the
public norm needs. -/
theorem evensNormCochain_transversal_independent (t t' : CosetTransversal U) (j : ℕ)
    (hj : j + 1 = U.toSubgroup.index * q)
    (a : ((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).X q)
    (ha : (((ContinuousCohomology.homogeneousCochains ℤ U.toSubgroup).obj
      (trivialF2 U.toSubgroup)).d q (q + 1)).hom a = 0) :
    ∃ c : ((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).X j,
      evensNormCochain U q t a - evensNormCochain U q t' a =
        cochainDegreeCast hj (trivialF2 G)
          ((((ContinuousCohomology.homogeneousCochains ℤ G).obj (trivialF2 G)).d j (j + 1)).hom
            c) :=
  sorry

/-- **Layer 13, milestone 8: multiplicativity,** for the `𝔽₂` pairing on both sides. -/
theorem evensNorm_mul (q' : ℕ)
    (x : (continuousCohomology ℤ U.toSubgroup q).obj (trivialF2 U.toSubgroup))
    (y : (continuousCohomology ℤ U.toSubgroup q').obj (trivialF2 U.toSubgroup)) :
    evensNorm U (q + q') (cup (f2Pairing U.toSubgroup) q q' x y) =
      degreeCast (by ring) (trivialF2 G)
        (cup (f2Pairing G) (U.toSubgroup.index * q) (U.toSubgroup.index * q')
          (evensNorm U q x) (evensNorm U q' y)) :=
  sorry

/-- **Layer 13, milestone 8: transitivity,** `N_V^G = N_U^G ∘ N_V^U` for open `V ≤ U ≤ G`. The
degree hypothesis is `Subgroup.relindex_mul_index`, restated here so that the two sides are
comparable without a rewrite inside the statement. -/
theorem evensNorm_trans (V : OpenSubgroup G) (hVU : V ≤ U)
    (hdeg : U.toSubgroup.index * (V.toSubgroup.relIndex U.toSubgroup * q) =
      V.toSubgroup.index * q)
    (x : (continuousCohomology ℤ V.toSubgroup q).obj (trivialF2 V.toSubgroup)) :
    evensNorm V q x =
      degreeCast hdeg (trivialF2 G)
        (evensNorm U (V.toSubgroup.relIndex U.toSubgroup * q) (evensNormLe U q V hVU x)) :=
  sorry

/-- **Layer 13, the iterated cup product of a family of classes,** with the degrees adding. The
double-coset formula is a **product** over double cosets, not a sum, because the norm is
multiplicative, so the product has to be named before the formula can be stated. The family is
indexed by an unordered type, which is legitimate here because over `𝔽₂` the sign in graded
commutativity is `1`. -/
noncomputable def cupFamily (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    {ι : Type} [Fintype ι] (d : ι → ℕ)
    (x : ∀ i, (continuousCohomology ℤ G (d i)).obj (trivialF2 G)) :
    (continuousCohomology ℤ G (∑ i, d i)).obj (trivialF2 G) :=
  sorry

/-- **Layer 13, milestone 8: one factor of the restriction and double-coset formula,**
`N^V_{V ⊓ gUg⁻¹} ∘ (g)_* ∘ res^U_{U ⊓ g⁻¹Vg}`, the multiplicative analogue of `mackeyTerm`. -/
noncomputable def evensDoubleCosetFactor (V : OpenSubgroup G) (g : G) :
    ((continuousCohomology ℤ U.toSubgroup q).obj (trivialF2 U.toSubgroup)) →
      ((continuousCohomology ℤ V.toSubgroup
        ((V ⊓ conjOpenSubgroup g U).toSubgroup.relIndex V.toSubgroup * q)).obj
          (trivialF2 V.toSubgroup)) :=
  fun x =>
    evensNormLe V q (V ⊓ conjOpenSubgroup g U) inf_le_left
      ((conjMapOf ℤ g (U ⊓ conjOpenSubgroup g⁻¹ V) (V ⊓ conjOpenSubgroup g U)
            (conjOpenSubgroup_inf g U V) (trivialF2 G) q).hom
        ((resLe ℤ U (U ⊓ conjOpenSubgroup g⁻¹ V) inf_le_left (trivialF2 G) q).hom x))

/-- **Layer 13, milestone 8: the restriction and double-coset formula** (Evens §6 Prop. 3). The
restriction of a norm is the cup product of the norms over the double cosets. The degree hypothesis
is the double-coset index identity `∑ [V : V ⊓ gUg⁻¹] = [G : U]`, restated so that the two sides
are comparable without a rewrite inside the statement. -/
theorem evensNorm_res_doubleCoset (V : OpenSubgroup G)
    (ι : Type) [Fintype ι] (g : ι → G)
    (hdc : ∀ x : G, ∃! i : ι, ∃ v ∈ V, ∃ u ∈ U, x = v * g i * u)
    (hdeg : ∑ i : ι, (V ⊓ conjOpenSubgroup (g i) U).toSubgroup.relIndex V.toSubgroup * q =
      U.toSubgroup.index * q)
    (x : (continuousCohomology ℤ U.toSubgroup q).obj (trivialF2 U.toSubgroup)) :
    (res ℤ V.toSubgroup (trivialF2 G) (U.toSubgroup.index * q)).hom (evensNorm U q x) =
      degreeCast hdeg (trivialF2 V.toSubgroup)
        (cupFamily V.toSubgroup
          (fun i => (V ⊓ conjOpenSubgroup (g i) U).toSubgroup.relIndex V.toSubgroup * q)
          (fun i => evensDoubleCosetFactor U q V (g i) x)) :=
  sorry

/-- **Layer 13, milestone 8: inflation compatibility,** for closed normal `N ≤ U`. Both inflations
are Layer 1's, and the degrees match because the index is unchanged in the quotient. -/
theorem evensNorm_infl (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G)) (hNU : N ≤ U)
    [IsTopologicalGroup (G ⧸ N)] [CompactSpace (G ⧸ N)] [TotallyDisconnectedSpace (G ⧸ N)]
    (x : (continuousCohomology ℤ (quotientOpenSubgroup N hN U hNU).toSubgroup q).obj
      (trivialF2 (quotientOpenSubgroup N hN U hNU).toSubgroup)) :
    evensNorm U q (trivialF2InflSub N hN U hNU q x) =
      trivialF2Infl N hN (U.toSubgroup.index * q)
        (degreeCast (by rw [quotientOpenSubgroup_index]) (trivialF2 (G ⧸ N))
          (evensNorm (quotientOpenSubgroup N hN U hNU) q x)) :=
  sorry

/-! The four identities the Quadratic Form Invariants roadmap consumes, as equations of classes.
Identity 2 is the polarization, and its right-hand side is the corestriction of the cup with the
**conjugate** class; a formula without the conjugate is a different statement. -/

/-- **Layer 13, the data of the index-two form.** The index-two hypothesis and the choice of an
element outside `U` are what the constructions of this block depend on, so they are bundled and
carried in every signature. Without them conjugation by `s` need not preserve `U`, the graph cochain
need not be a cocycle, and there is no two-point construction at all: a declaration whose type does
not mention them claims to exist for every open subgroup and every `s`, which is false. -/
structure IndexTwoDatum (U : OpenSubgroup G) where
  /-- the subgroup has index two, so it is normal and the quotient is `C₂` -/
  index_eq_two : U.toSubgroup.index = 2
  /-- the chosen element outside `U`, the second point of the transversal `{1, s}` -/
  representative : G
  /-- it lies outside `U` -/
  representative_not_mem : representative ∉ U

variable (D : IndexTwoDatum U)

/-- **Layer 13, the conjugation action of `s` on `H¹(U, 𝔽₂)`.** An index-2 subgroup is normal, so
conjugation by `s` carries `U` to itself and acts on its cohomology; this is the map written
`α ↦ s · α` in the identities below. Its type carries the index-two datum, since for a general
subgroup and a general `s` there is no such endomorphism. -/
noncomputable def evensConj (D : IndexTwoDatum U) :
    ((continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) →
      ((continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) :=
  sorry

/-- **Layer 13, the class of a continuous trivial-action 1-cocycle.** With trivial `𝔽₂`
coefficients `H¹` is the group of continuous homomorphisms, so a continuous `α` has a class; the
identities below are stated for classes and the cochain constructions for representatives, and this
is the map between the two. -/
noncomputable def homClass (H : Type) [Group H] [TopologicalSpace H] [IsTopologicalGroup H]
    (α : H →* Multiplicative (ZMod 2)) (hα : Continuous α) :
    (continuousCohomology ℤ H 1).obj (trivialF2 H) :=
  sorry

/-- **Layer 13, the class of the graph cocycle,** defined **from** `evensGraphCochain` and its
cocycle theorem, not declared beside them. This is the explicit index-2 degree-1 norm. -/
noncomputable def graphClass (D : IndexTwoDatum U)
    (α : U.toSubgroup →* Multiplicative (ZMod 2)) (hα : Continuous α) :
    (continuousCohomology ℤ G 2).obj (trivialF2 G) :=
  sorry

/-- **Layer 13, the graph class is the class of the graph cochain.** The equation that ties
`graphClass` to `evensGraphCochain`; without it `graphClass` would be an unconstrained map that the
milestone-10 identification could be satisfied by trivially. -/
theorem graphClass_eq_cochainClass (α : U.toSubgroup →* Multiplicative (ZMod 2))
    (hα : Continuous α) :
    graphClass U D α hα =
      cochainClass ℤ (trivialF2 G) 2
        (inhomogeneousCochain2 G (evensGraphCochain U.toSubgroup D.representative α)
          (evensGraphCochain_isCocycle U D.representative α D.index_eq_two
            D.representative_not_mem hα).1)
        (inhomogeneousCochain2_d_eq_zero G _ _
          (evensGraphCochain_isCocycle U D.representative α D.index_eq_two
            D.representative_not_mem hα).2) :=
  sorry

/-- **Layer 13, the graph class descends to `H¹(U, 𝔽₂)`.** Continuous homomorphisms with the same
class give the same graph class, which is what makes `graphClass` a map out of cohomology. -/
theorem graphClass_representative_independent
    (α β : U.toSubgroup →* Multiplicative (ZMod 2)) (hα : Continuous α) (hβ : Continuous β)
    (hcl : homClass U.toSubgroup α hα = homClass U.toSubgroup β hβ) :
    graphClass U D α hα = graphClass U D β hβ :=
  sorry

/-- **Layer 13, identity 1: `res_U N^{Ev}(α) = α ⌣ (s · α)`.** -/
theorem evensNorm_res
    (α : (continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) :
    (res ℤ U.toSubgroup (trivialF2 G) 2).hom (evensNormIndexTwo U D.index_eq_two α) =
      cup (f2Pairing U.toSubgroup) 1 1 α (evensConj U D α) :=
  sorry

/-- **Layer 13, identity 2: the polarization.** Both variables appear, and the right-hand side
carries the **conjugate** class; a formula without the conjugate is a different statement. -/
theorem evensNorm_polarization
    (α β : (continuousCohomology ℤ U.toSubgroup 1).obj (trivialF2 U.toSubgroup)) :
    evensNormIndexTwo U D.index_eq_two (α + β) - evensNormIndexTwo U D.index_eq_two α -
        evensNormIndexTwo U D.index_eq_two β =
      (corestriction ℤ U (trivialF2 G) (trivialF2_isSmoothDiscrete G) 2).hom
        (cup (f2Pairing U.toSubgroup) 1 1 α (evensConj U D β)) :=
  sorry

/-- **Layer 13, identity 3: `cor¹ α = b₁ + b_s`** at the transversal `{1, s}`, as an equation of
**classes on the left and cochains on the right**. `b₁` and `b_s` are not cocycles, so neither has
a class of its own and the identity cannot be stated as a sum of two classes; what is true is that
their sum is a cocycle whose class is the corestriction. -/
theorem evensNorm_cor_shapiro (α : U.toSubgroup →* Multiplicative (ZMod 2))
    (hα : Continuous α) :
    (corestriction ℤ U (trivialF2 G) (trivialF2_isSmoothDiscrete G) 1).hom
        (homClass U.toSubgroup α hα) =
      cochainClass ℤ (trivialF2 G) 1
        (inhomogeneousCochain1 G (evensCorCochain U.toSubgroup D.representative α)
          (evensCorCochain_isCocycle U D.representative α D.index_eq_two
            D.representative_not_mem hα).1)
        (inhomogeneousCochain1_d_eq_zero G _ _
          (evensCorCochain_isCocycle U D.representative α D.index_eq_two
            D.representative_not_mem hα).2) :=
  sorry

/-- **Layer 13, identity 4: compatibility with inflation,** for closed normal `N ≤ U`. -/
theorem evensNorm_identity_infl (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G))
    (hNU : N ≤ U)
    [IsTopologicalGroup (G ⧸ N)] [CompactSpace (G ⧸ N)] [TotallyDisconnectedSpace (G ⧸ N)]
    (hUN : (quotientOpenSubgroup N hN U hNU).toSubgroup.index = 2)
    (α : (continuousCohomology ℤ (quotientOpenSubgroup N hN U hNU).toSubgroup 1).obj
      (trivialF2 (quotientOpenSubgroup N hN U hNU).toSubgroup)) :
    evensNormIndexTwo U D.index_eq_two (trivialF2InflSub N hN U hNU 1 α) =
      trivialF2Infl N hN 2 (evensNormIndexTwo (quotientOpenSubgroup N hN U hNU) hUN α) :=
  sorry

/-- **Layer 13, milestone 10: at index 2 and degree 1 the general norm is the class of the graph
cocycle.** The identification that makes the graph cocycle a standard construction rather than an
ad hoc formula. `graphClass` is the quotient class of `evensGraphCochain`, so this compares the
general construction with the explicit one and not with an unconstrained map. -/
theorem evensNorm_eq_graphClass (α : U.toSubgroup →* Multiplicative (ZMod 2))
    (hα : Continuous α) :
    evensNormIndexTwo U D.index_eq_two (homClass U.toSubgroup α hα) = graphClass U D α hα :=
  sorry

end EvensNorm

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
