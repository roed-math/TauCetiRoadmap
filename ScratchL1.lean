import Mathlib
universe u
namespace ScratchL1
open CategoryTheory

/-- Mathlib master's spelling, over the pin's category. -/
abbrev TopRep (R : Type u) [CommRing R] [TopologicalSpace R]
    (G : Type u) [Group G] [TopologicalSpace G] : Type (u + 1) :=
  Action (TopModuleCat.{u} R) G

variable (R : Type u) [CommRing R] [TopologicalSpace R]
  {G H : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [Group H] [TopologicalSpace H] [IsTopologicalGroup H]

noncomputable example (n : ℕ) : TopRep R G ⥤ TopModuleCat.{u} R := continuousCohomology R G n

noncomputable example : continuousCohomology R G 0 ≅ ContinuousCohomology.invariants R G :=
  ContinuousCohomology.continuousCohomologyZeroIso R G

/-- Layer 1: the compatible-pair map, the piece the pin does not have. -/
noncomputable def map (φ : ContinuousMonoidHom H G) {X : TopRep R G} {Y : TopRep R H}
    (f : (Action.res _ (φ : H →* G)).obj X ⟶ Y) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶ (continuousCohomology R H n).obj Y :=
  sorry

theorem map_id (X : TopRep R G) (n : ℕ) :
    map R (ContinuousMonoidHom.id G) (X := X) (Y := X) (𝟙 _) n = 𝟙 _ :=
  sorry

/-- Layer 1: restriction to a subgroup. -/
noncomputable def res (S : Subgroup G) (X : TopRep R G) (n : ℕ) :
    (continuousCohomology R G n).obj X ⟶
      (continuousCohomology R S n).obj ((Action.res _ S.subtype).obj X) :=
  sorry

/-- Layer 0's dictionary, at ℤ: a discrete module is an object of `TopRep ℤ G`. -/
noncomputable def ofDiscreteModule (G : Type) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (M : Type) [AddCommGroup M] [TopologicalSpace M]
    [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] : TopRep ℤ G :=
  sorry

end ScratchL1
