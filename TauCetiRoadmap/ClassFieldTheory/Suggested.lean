import Mathlib
import TauCetiRoadmap.ProfiniteCohomology.Suggested
import TauCetiRoadmap.LocalFieldsRamification.Suggested
import TauCetiRoadmap.GlobalNumberFields.Suggested
import TauCetiRoadmap.NumberFieldArithmetic.Suggested

set_option autoImplicit false

/-!
# Class field theory: target signatures

The normative specification is `README.md`. This file pins the shared finite-Tate, local,
and global class-field-theory names. All continuous cohomology is Mathlib's carrier exposed by
`ProfiniteCohomology`; all valuation and ramification objects come from
`LocalFieldsRamification`; all moduli, ray classes, ideles, Hecke characters, orders and Picard
groups come from `GlobalNumberFields`; and the ideal Artin map comes from
`NumberFieldArithmetic`.

There is no quadratic-form import. The cohomological Hilbert pairing is built from Kummer
classes, the imported continuous cup product, and the local invariant. Hasse--Minkowski is not
declared here.
-/

namespace TauCetiRoadmap.ClassFieldTheory

open CategoryTheory NumberField IsDedekindDomain
open scoped MonoidalCategory nonZeroDivisors ValuativeRel TensorProduct

universe u v

/-! ## Layers 0--1: finite-group Tate cohomology and class formations -/

variable {G : Type} [Group G] [Fintype G]

/-- Tate cohomology `Ĥ^r(G,M)` in every integer degree. -/
noncomputable def tateH {H : Type} [Group H] [Fintype H] (M : Rep ℤ H) (r : ℤ) : Type :=
  sorry

noncomputable instance {H : Type} [Group H] [Fintype H] (M : Rep ℤ H) (r : ℤ) :
    AddCommGroup (tateH M r) :=
  sorry

/-- Coefficient functoriality of Tate cohomology. -/
noncomputable def tateMap {A B : Rep ℤ G} (f : A ⟶ B) (r : ℤ) : tateH A r →+ tateH B r :=
  sorry

theorem tateMap_id (A : Rep ℤ G) (r : ℤ) : tateMap (𝟙 A) r = AddMonoidHom.id _ :=
  sorry

theorem tateMap_comp {A B C : Rep ℤ G} (f : A ⟶ B) (g : B ⟶ C) (r : ℤ) :
    tateMap (f ≫ g) r = (tateMap g r).comp (tateMap f r) :=
  sorry

/-- Ordinary-to-Tate comparison in nonnegative degrees. -/
noncomputable def ordinaryToTate (A : Rep ℤ G) (n : ℕ) :
    groupCohomology A n →+ tateH A (n : ℤ) :=
  sorry

/-- Restriction in every integer degree. -/
noncomputable def tateRes (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (r : ℤ) :
    tateH M r →+ tateH (Rep.res H.subtype M) r :=
  sorry

/-- Corestriction in every integer degree. -/
noncomputable def tateCor (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (r : ℤ) :
    tateH (Rep.res H.subtype M) r →+ tateH M r :=
  sorry

theorem tateCor_comp_tateRes (M : Rep ℤ G) (H : Subgroup G) [Fintype H]
    (r : ℤ) (x : tateH M r) :
    tateCor M H r (tateRes M H r x) = (H.index : ℤ) • x :=
  sorry

/-- Inflation is deliberately restricted to positive degrees. -/
noncomputable def tateInfl (M : Rep ℤ G) (N : Subgroup G) [N.Normal]
    [Fintype (G ⧸ N)] (n : ℕ) (_hn : 1 ≤ n) :
    tateH (M.quotientToInvariants N) (n : ℤ) →+ tateH M (n : ℤ) :=
  sorry

/-- Tate cup product in all integer bidegrees. -/
noncomputable def tateCup (A B : Rep ℤ G) (r s t : ℤ) (_h : r + s = t) :
    tateH A r →+ tateH B s →+ tateH (A ⊗ B) t :=
  sorry

/-- Two-periodicity for finite cyclic groups. -/
noncomputable def tatePeriodicity (M : Rep ℤ G) (_hG : IsCyclic G) (r : ℤ) :
    tateH M r ≃+ tateH M (r + 2) :=
  sorry

/-- Negative Tate cohomology agrees with group homology. -/
noncomputable def tateHNegEquivGroupHomology (M : Rep ℤ G) (n : ℕ) (_hn : 1 ≤ n) :
    tateH M (-(n : ℤ) - 1) ≃+ groupHomology M n :=
  sorry

/-- Herbrand quotient `#Ĥ⁰/#Ĥ¹`; laws using it carry finiteness hypotheses. -/
noncomputable def herbrandQuotient (M : Rep ℤ G) : ℚ :=
  (Nat.card (tateH M 0) : ℚ) / (Nat.card (tateH M 1) : ℚ)

/-- A finite class formation, with the distinguished class at every subgroup. -/
structure FiniteClassFormation (M : Rep ℤ G) where
  cls : ∀ (H : Subgroup G) [Fintype H], tateH (Rep.res H.subtype M) 2
  res : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateH (Rep.res H.subtype M) 2 →+ tateH (Rep.res H'.subtype M) 2
  cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateH (Rep.res H'.subtype M) 2 →+ tateH (Rep.res H.subtype M) 2
  h1_eq_zero : ∀ (H : Subgroup G) [Fintype H],
    Subsingleton (groupCohomology (Rep.res H.subtype M) 1)
  h2_cyclic : ∀ (H : Subgroup G) [Fintype H]
    (x : tateH (Rep.res H.subtype M) 2), ∃ m : ℤ, x = m • cls H
  h2_card : ∀ (H : Subgroup G) [Fintype H],
    Nat.card (tateH (Rep.res H.subtype M) 2) = Nat.card H
  res_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    res H H' h (cls H) = cls H'
  cor_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    cor H H' h (cls H') = ((H'.subgroupOf H).index : ℤ) • cls H
  res_comp_cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H)
    (x : tateH (Rep.res H.subtype M) 2),
    cor H H' h (res H H' h x) = ((H'.subgroupOf H).index : ℤ) • x

noncomputable def FiniteClassFormation.restrict {M : Rep ℤ G}
    (_fcf : FiniteClassFormation M) (H : Subgroup G) [Fintype H] :
    FiniteClassFormation (Rep.res H.subtype M) :=
  sorry

noncomputable def FiniteClassFormation.topClass {M : Rep ℤ G}
    (_fcf : FiniteClassFormation M) : tateH M 2 :=
  sorry

/-- Cup product with the distinguished class, in every integer degree. -/
noncomputable def tateCupSigma (M : Rep ℤ G) (cls : tateH M 2) (r : ℤ) :
    tateH (Rep.trivial ℤ G ℤ) r →+ tateH M (2 + r) :=
  sorry

/-- Tate--Nakayama for every subgroup and every integer degree. -/
theorem tateNakayama (M : Rep ℤ G) (fcf : FiniteClassFormation M)
    (H : Subgroup G) [Fintype H] (r : ℤ) :
    Function.Bijective (tateCupSigma (Rep.res H.subtype M) (fcf.cls H) r) :=
  sorry

theorem tateNakayama_top (M : Rep ℤ G) (fcf : FiniteClassFormation M) (r : ℤ) :
    Function.Bijective (tateCupSigma M fcf.topClass r) :=
  sorry

/-! ## Layers 2--3: local cohomology, reciprocity, and duality -/

/-- Coefficients for the absolute Galois group, on the imported continuous carrier. -/
abbrev GalRep (n : ℕ) (F : Type u) [Field F] : Type (u + 1) :=
  ProfiniteCohomology.TopRep (ZMod n) (Field.absoluteGaloisGroup F)

/-- `Hⁱ(G_F,A)` on Mathlib's continuous cohomology functor. -/
noncomputable abbrev H (n : ℕ) (F : Type u) [Field F]
    (i : ℕ) (A : GalRep n F) : Type _ :=
  (continuousCohomology (ZMod n) (Field.absoluteGaloisGroup F) i).obj A

section Local

variable (K : Type u) [Field K] [ValuativeRel K] [TopologicalSpace K]
  [IsNonarchimedeanLocalField K]
variable (L : Type v) [Field L] [ValuativeRel L] [TopologicalSpace L]
  [IsNonarchimedeanLocalField L]

/-- The coefficient object `μ_n(Fˢ)`, written additively. -/
def muNRep (n : ℕ) (F : Type u) [Field F] : GalRep n F :=
  sorry

/-- Tate dual `Hom(A,μ_n)` with its conjugation action. -/
def tateDual {n : ℕ} {F : Type u} [Field F] (_A : GalRep n F) : GalRep n F :=
  sorry

/-- The transported Kummer class, not a second Kummer cocycle. -/
def kummerClass (n : ℕ) (F : Type u) [Field F] (_a : Fˣ) : H n F 1 (muNRep n F) :=
  sorry

/-- Mixed-characteristic Kummer equivalence, including `n = p`. -/
noncomputable def kummerEquiv_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) :
    Additive (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) ≃+ H n F 1 (muNRep n F) :=
  sorry

/-- The mixed-characteristic invariant on `H²(F,μ_n)`. -/
theorem h2MuEquivZMod_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) :
    Nonempty (H n F 2 (muNRep n F) ≃+ ZMod n) :=
  sorry

/-- The invariant transported to a coefficient object identified with `μ_p`. -/
theorem h2FpEquivZMod_of_mu (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (ζ : F) (_hζ : IsPrimitiveRoot ζ p) (T : GalRep p F)
    (_hT : Nonempty (muNRep p F ≅ T)) :
    Nonempty (H p F 2 T ≃+ ZMod p) :=
  sorry

/-- The coefficient pairing `μ_n × μ_n → μ_n` selected by a primitive root. -/
noncomputable def kummerCupPairing {n : ℕ} {F : Type u} [Field F]
    (ζ : F) (_hζ : IsPrimitiveRoot ζ n) :
    ProfiniteCohomology.TopPairing (muNRep n F) (muNRep n F) (muNRep n F) :=
  sorry

/-- The local cohomological symbol: cup followed by the invariant. -/
noncomputable def localSymbol {n : ℕ} {F : Type u} [Field F]
    (P : ProfiniteCohomology.TopPairing (muNRep n F) (muNRep n F) (muNRep n F))
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n)
    (x y : H n F 1 (muNRep n F)) : ZMod n :=
  tr (ProfiniteCohomology.degreeCast (by norm_num) (muNRep n F)
    (ProfiniteCohomology.cup P 1 1 x y))

/-- Local Tate-duality evaluation pairing. -/
noncomputable def tateDualityPairing {n : ℕ} {F : Type u} [Field F]
    (A : GalRep n F) (tr : H n F 2 (muNRep n F) ≃+ ZMod n)
    (i j : ℕ) (hij : i + j = 2)
    (_x : H n F i (tateDual A)) (_y : H n F j A) : ZMod n :=
  sorry

/-- Finiteness in local cohomological degrees zero through two. -/
theorem finite_H (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F)
    (_hA : Finite A.V) (i : ℕ) (_hi : i ≤ 2) :
    Finite (H n F i A) :=
  sorry

/-- Perfect local Tate duality in mixed characteristic. -/
theorem tateDualityPairing_perfect_mixed (p : ℕ) [Fact p.Prime]
    (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (_hA : Finite A.V)
    (_hdisc : DiscreteTopology A.V) (i j : ℕ) (hij : i + j = 2) :
    (∀ x : H n F i (tateDual A),
        (∀ y : H n F j A, tateDualityPairing A tr i j hij x y = 0) → x = 0) ∧
      (∀ φ : H n F j A →+ ZMod n, ∃ x : H n F i (tateDual A),
        ∀ y : H n F j A, tateDualityPairing A tr i j hij x y = φ y) :=
  sorry

/-- The `𝔽_p` Euler-characteristic formula consumed by `LocalGaloisGroups`. -/
theorem eulerCharacteristic_finrank_fp (p : ℕ) [Fact p.Prime]
    (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (A : GalRep p F) (_hA : Finite A.V) :
    Module.finrank (ZMod p) (H p F 1 A)
      = Module.finrank (ZMod p) (H p F 0 A)
        + Module.finrank (ZMod p) (H p F 2 A)
        + Module.finrank ℚ_[p] F * Module.finrank (ZMod p) A.V :=
  sorry

/-- Finite-level local reciprocity from Tate--Nakayama. -/
noncomputable def normResidue [Algebra K L] [Module.Finite K L] [IsGalois K L] :
    (Kˣ ⧸ LocalFieldsRamification.normGroup K L) ≃*
      Abelianization (L ≃ₐ[K] L) :=
  sorry

/-- The local Artin map, normalized by arithmetic Frobenius. -/
noncomputable def artinMap : Kˣ →* Field.absoluteGaloisGroupAbelianization K :=
  sorry

/-- Cyclotomic orientation with the required field norm. -/
theorem cyclotomicCharacter_artinMap (p : ℕ) [Fact p.Prime]
    (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (u : Fˣ) (_hu : valuation F (u : F) = 1) (σ : Field.absoluteGaloisGroup F)
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization F) = artinMap F u) :
    Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom
        (cyclotomicCharacter (AlgebraicClosure F) p σ.toRingEquiv)
      = (Units.map (Algebra.norm ℚ_[p] : F →* ℚ_[p]) u)⁻¹ :=
  sorry

/-- The specialization at `ℚ_p`. -/
theorem cyclotomicCharacter_artinMap_padic (p : ℕ) [Fact p.Prime]
    [IsNonarchimedeanLocalField ℚ_[p]] (u : ℤ_[p]ˣ)
    (σ : Field.absoluteGaloisGroup ℚ_[p])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[p])
      = artinMap ℚ_[p] (Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom u)) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[p]) p σ.toRingEquiv = u⁻¹ :=
  sorry

end Local

/-! ## Layers 4--8: global reciprocity, norm principles, and Hilbert reciprocity -/

variable {K : Type u} [Field K] [NumberField K]
variable {L : Type u} [Field L] [NumberField L] [Algebra K L]

/-- The sole adapter from an abelian-Galois hypothesis to the supplier's explicit
commutativity argument. -/
theorem algEquiv_commute_of_isAbelianGalois [IsAbelianGalois K L] :
    ∀ σ τ : L ≃ₐ[K] L, Commute σ τ :=
  fun σ τ => IsMulCommutative.is_comm.comm σ τ

/-- The finite-level ideal Artin map is exactly the `NumberFieldArithmetic` map. -/
noncomputable abbrev abelianArtinHomAway [IsAbelianGalois K L]
    (S : Finset (HeightOneSpectrum (𝓞 K)))
    (hur : ∀ v : HeightOneSpectrum (𝓞 K), v ∉ S →
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal],
        Algebra.IsUnramifiedAt (𝓞 K) Q) :
    NumberFieldArithmetic.idealsAway (K := K) S →* (L ≃ₐ[K] L) :=
  NumberFieldArithmetic.artinHomAway (L := L)
    algEquiv_commute_of_isAbelianGalois S hur

/-- Principal ideles, on the carrier owned by `GlobalNumberFields`. -/
noncomputable def principalIdele (F : Type u) [Field F] [NumberField F] :
    Fˣ →* GlobalNumberFields.IdeleGroup F :=
  sorry

/-- Norm on ideles in a finite extension; no idele carrier is redefined here. -/
noncomputable def ideleNormMap [Module.Finite K L] :
    GlobalNumberFields.IdeleGroup L →* GlobalNumberFields.IdeleGroup K :=
  sorry

/-- **Frozen public name.** For a cyclic extension, being a global norm is equivalent to
the principal idele being an idele norm, hence to being a norm at every place. -/
theorem cyclicHasseNorm [Module.Finite K L] [IsGalois K L]
    [IsCyclic (L ≃ₐ[K] L)] (x : Kˣ) :
    (∃ y : Lˣ, Units.map (Algebra.norm K : L →* K) y = x) ↔
      principalIdele K x ∈ MonoidHom.range (ideleNormMap (K := K) (L := L)) :=
  sorry

/-- Reciprocity on the imported ray-class carrier. -/
noncomputable def rayClassArtinMap [IsAbelianGalois K L]
    (𝔪 : GlobalNumberFields.Modulus K) :
    GlobalNumberFields.RayClassGroup 𝔪 →* (L ≃ₐ[K] L) :=
  sorry

/-- Finite-place cohomological Hilbert invariant, obtained from `localSymbol` at the
completion. -/
noncomputable def finiteHilbertInvariantAt
    (v : HeightOneSpectrum (𝓞 K)) (a b : Kˣ) : ZMod 2 :=
  sorry

/-- Archimedean cohomological Hilbert invariant; it is zero at complex places and detects
two negative arguments at a real place. -/
noncomputable def infiniteHilbertInvariantAt
    (w : InfinitePlace K) (a b : Kˣ) : ZMod 2 :=
  sorry

/-- The finite support of the finite-place Hilbert invariants. -/
noncomputable def finiteHilbertSupport (a b : Kˣ) :
    Finset (HeightOneSpectrum (𝓞 K)) :=
  sorry

theorem finiteHilbertInvariantAt_eq_zero_of_not_mem
    (a b : Kˣ) (v : HeightOneSpectrum (𝓞 K))
    (hv : v ∉ finiteHilbertSupport a b) :
    finiteHilbertInvariantAt v a b = 0 :=
  sorry

/-- **Frozen public name.** Hilbert reciprocity in additive cohomological form. The
multiplicative translation is the product of all local signs being `1`. -/
theorem hilbertProductFormula (a b : Kˣ) :
    (∑ v ∈ finiteHilbertSupport a b, finiteHilbertInvariantAt v a b) +
        ∑ w : InfinitePlace K, infiniteHilbertInvariantAt w a b = 0 :=
  sorry

/-- Kronecker--Weber, retained as a class-field-theory consequence. -/
theorem kroneckerWeber (E : Type u) [Field E] [NumberField E]
    [IsAbelianGalois ℚ E] :
    ∃ n : ℕ, n ≠ 0 ∧ Nonempty (E →ₐ[ℚ] CyclotomicField n ℚ) :=
  sorry

end TauCetiRoadmap.ClassFieldTheory
