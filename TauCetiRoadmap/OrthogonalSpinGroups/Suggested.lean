import Mathlib

/-!
# Orthogonal and spin groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is `README.md`.
The statements here suggest Lean forms for particular milestones, so that contributors and
reviewers converge on names and signatures; discharging all of them finishes neither a layer nor
the roadmap.

Objects this roadmap builds on but does not own are restated here only so that the file
elaborates on its own, and they carry the **same names and types** as the roadmaps that own them,
so that adoption is a deletion and an import rather than a rewrite: `orthogonalGroup`,
`specialOrthogonalGroup` and `spinToSpecialOrthogonal` are the spin representations roadmap's, and
`SquareClass` is the multiplicative avatar the quadratic form invariants roadmap adds beside the
landed additive `TauCeti.SquareClassGroup`. ⚠ In particular `specialOrthogonalGroup Q` is a
subgroup of `V ≃ₗ[K] V`, **not** of `orthogonalGroup Q`; the determinant kernel inside
`orthogonalGroup Q` is the separately named `specialOrthogonalWithin`.

Conventions follow `README.md`. `K` is a field with `[Invertible (2 : K)]`. The bilinear form is
Mathlib's un-halved `QuadraticMap.polarBilin Q`, so `B x x = 2 • Q x`; the two reflection
spellings `B x v / Q v` and `2 * B x v / B v v` are therefore **equal**, which
`reflectionCoeff_eq` records, and the genuinely wrong form is the mixed `2 * B x v / Q v`. The
Clifford norm is the **`reverse`** norm, with `cliffordNorm_ι` an equality `N (ι v) = Q v` and no
sign ambiguity; Mathlib's `star = reverse ∘ involute` gives the other anti-involution, with value
`-Q v` on a vector, and the two differ by `(-1)^r` on a product of `r` vectors, a difference the
square-class codomain does **not** absorb, since `[-1]` is generally nontrivial.

Three groups of statements are absent, deliberately, because their types are not yet expressible
and a `Prop`-valued placeholder would assert nothing. The general-`S` form of strong approximation
quantifies over `ℚ`-almost-simple factors, which needs the affine group schemes of Layer 3A; only
the concrete `S = {∞}` corollary is pinned below. The Tamagawa statements of Layer 5 need those
schemes together with invariant differential forms. And the algebraic-group comparison of Layer 3A
is itself prose in `README.md` until the reductive groups roadmap's point functor lands.
-/

namespace TauCetiRoadmap.OrthogonalSpinGroups

open QuadraticMap

universe u v w

/-! ## Layer 0: the orthogonal group, its determinant, and reflections -/

section Layer0

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- **The orthogonal group** of a quadratic form. Owned by the spin representations roadmap;
same name and type here. -/
def orthogonalGroup (Q : QuadraticForm K V) : Subgroup (V ≃ₗ[K] V) where
  carrier := {f | ∀ x, Q (f x) = Q x}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **The special orthogonal group**. ⚠ Owned by the spin representations roadmap, and a subgroup
of `V ≃ₗ[K] V`, not of `orthogonalGroup Q`. Redefining it with the other type would make it
impossible to delete this declaration in favour of an import later. -/
def specialOrthogonalGroup (Q : QuadraticForm K V) : Subgroup (V ≃ₗ[K] V) := sorry

theorem specialOrthogonalGroup_le (Q : QuadraticForm K V) :
    specialOrthogonalGroup Q ≤ orthogonalGroup Q := by
  sorry

/-- The inclusion of the accepted `SO(Q)` into the accepted `O(Q)`, as a homomorphism, which is
what later statements restrict along. -/
def specialOrthogonalToOrthogonal (Q : QuadraticForm K V) :
    specialOrthogonalGroup Q →* orthogonalGroup Q :=
  Subgroup.inclusion (specialOrthogonalGroup_le Q)

/-- **The determinant homomorphism** on the orthogonal group, Layer 0A. Named `orthogonalDet`
rather than `det` so that it does not collide with the many other determinants in scope. -/
noncomputable def orthogonalDet (Q : QuadraticForm K V) : orthogonalGroup Q →* Kˣ :=
  (LinearEquiv.det (R := K) (M := V)).comp (orthogonalGroup Q).subtype

/-- **Layer 0A**: for a nondegenerate form the determinant of an isometry squares to one, so it
lands in `μ₂`. Proved from the Gram congruence `Mᵀ G M = G` with `det G ≠ 0`. -/
theorem orthogonalDet_sq [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (g : orthogonalGroup Q) : orthogonalDet Q g ^ 2 = 1 := by
  sorry

/-- The determinant kernel **inside** `orthogonalGroup Q`, kept typographically distinct from the
accepted `specialOrthogonalGroup`. Layer 0A. -/
noncomputable def specialOrthogonalWithin (Q : QuadraticForm K V) : Subgroup (orthogonalGroup Q) :=
  (orthogonalDet Q).ker

/-- **Layer 0A**: the two descriptions agree, so `specialOrthogonalWithin` really is the pullback
of the accepted subgroup along the inclusion. This is the lemma that lets a proof move between the
two spellings. -/
theorem specialOrthogonalWithin_eq_comap (Q : QuadraticForm K V) :
    specialOrthogonalWithin Q = (specialOrthogonalGroup Q).comap (orthogonalGroup Q).subtype := by
  sorry

/-- **Layer 0A**: and the resulting groups are canonically isomorphic. -/
noncomputable def specialOrthogonalWithinEquiv (Q : QuadraticForm K V) :
    specialOrthogonalWithin Q ≃* specialOrthogonalGroup Q :=
  sorry

/-- **Layer 0A**: index exactly two in positive dimension. Dimension zero is genuinely different
and is why the hypothesis is stated. -/
theorem index_specialOrthogonalWithin [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (hV : 0 < Module.finrank K V) :
    (specialOrthogonalWithin Q).index = 2 := by
  sorry

/-- The functional cutting out the reflection hyperplane of an anisotropic vector. -/
noncomputable def reflectionForm (Q : QuadraticForm K V) (v : V) : Module.Dual K V :=
  (Q v)⁻¹ • Q.polarBilin v

/-- **⚠ Layer 0D, the factor of two.** The two coefficient spellings in the literature are
*equal*, because Mathlib's `polar` is un-halved and `B v v = 2 • Q v`. The genuinely wrong form,
which sends `v` to `-3v`, is the mixed `2 * B x v / Q v`, obtained by substituting the un-halved
`B` into a half-polar source's numerator while leaving `Q v` in the denominator. -/
theorem reflectionCoeff_eq (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (x : V) :
    polar Q x v / Q v = 2 * polar Q x v / polar Q v v := by
  sorry

theorem reflectionForm_apply_self (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    reflectionForm Q v v = 2 := by
  sorry

/-- **The reflection** in an anisotropic vector, through `Module.reflection` so that involutivity
and `τ_v v = -v` come from Mathlib. -/
noncomputable def reflection (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) : V ≃ₗ[K] V :=
  Module.reflection (reflectionForm_apply_self Q hv)

theorem reflection_apply (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (x : V) :
    reflection Q hv x = x - (Q v)⁻¹ • polar Q x v • v := by
  sorry

theorem reflection_mem (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    reflection Q hv ∈ orthogonalGroup Q := by
  sorry

/-- **Layer 0D**: absent from Mathlib for `Module.reflection` in any form, and what makes the
parity statement of 0F meaningful. -/
theorem det_reflection [FiniteDimensional K V] (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    LinearEquiv.det (reflection Q hv) = -1 := by
  sorry

/-- **Layer 0D**: what makes the spinor norm constant on a conjugacy class of reflections. -/
theorem reflection_conj (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (g : orthogonalGroup Q)
    (hgv : Q (g.1 v) ≠ 0) :
    (g : V ≃ₗ[K] V) * reflection Q hv * (g : V ≃ₗ[K] V)⁻¹ = reflection Q hgv := by
  sorry

/-- **Layer 0E**, the transitivity engine. The reflection coefficient is exactly `1`, so `τ_{v-w}`
carries `v` to `w` on the nose. Witt's extension theorem gives existence of *an* isometry and says
nothing about its spinor norm, which is why the explicit reflection is the milestone. -/
theorem reflection_sub_apply (Q : QuadraticForm K V) {v w : V} (hQ : Q v = Q w)
    (h : Q (v - w) ≠ 0) : reflection Q h v = w := by
  sorry

/-- **Layer 0E**, the complementary case; one of the two hypotheses always holds. -/
theorem reflection_add_apply (Q : QuadraticForm K V) {v w : V} (hQ : Q v = Q w)
    (h : Q (v + w) ≠ 0) : reflection Q h v = -w := by
  sorry

end Layer0

/-! ## Layer 1: the Clifford norm, the spinor norm, and the comparison sequence -/

section Layer1

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- The **multiplicative** square-class group, the spinor norm's codomain. Owned by the quadratic
form invariants roadmap; same name and type here. ⚠ The landed `TauCeti.SquareClassGroup` is the
*additive* avatar, so the two are related by `squareClassEquivAdditive` and are not
interchangeable without it. -/
abbrev SquareClass (K : Type u) [Field K] : Type u := Kˣ ⧸ Subgroup.square Kˣ

/-- The unit-to-square-class homomorphism. -/
def squareClassOfUnit (K : Type u) [Field K] : Kˣ →* SquareClass K :=
  QuotientGroup.mk' _

/-- The comparison with the landed additive avatar, pinned rather than left as prose. -/
def squareClassEquivAdditive (K : Type u) [Field K] :
    Additive (SquareClass K) ≃+ (Additive Kˣ ⧸ (Subgroup.square Kˣ).toAddSubgroup) :=
  sorry

/-- Base change of square classes along a field homomorphism, which is what the local and adelic
codomains of Layers 2 and 3 are built from. -/
def squareClassMap {L : Type u} [Field L] (f : K →+* L) : SquareClass K →* SquareClass L :=
  sorry

/-- **The Clifford norm**, Layer 1A: the **`reverse`** norm `N g = reverse g * g`. The milestone
hidden in the signature is that the value is a scalar. -/
noncomputable def cliffordNorm (Q : QuadraticForm K V) : lipschitzGroup Q →* Kˣ :=
  sorry

/-- **Layer 1A**: an equality, with no sign ambiguity, from `reverse_ι` and `ι_sq_scalar`. -/
theorem cliffordNorm_ι (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (g : lipschitzGroup Q)
    (hg : ((g : (CliffordAlgebra Q)ˣ) : CliffordAlgebra Q) = CliffordAlgebra.ι Q v) :
    ((cliffordNorm Q g : Kˣ) : K) = Q v := by
  sorry

/-- **Layer 1A**: the other anti-involution, kept separate. Mathlib's `star` is
`reverse ∘ involute`, so its norm takes the value `-Q v` on a vector. ⚠ `[Q v]` and `[-Q v]`
differ by `[-1]`, which is generally nontrivial, so the two conventions disagree on `O(Q)` at odd
reflection length and agree only on `SO(Q)`. -/
theorem starNorm_ι (Q : QuadraticForm K V) (v : V) :
    star (CliffordAlgebra.ι Q v) * CliffordAlgebra.ι Q v
      = algebraMap K (CliffordAlgebra Q) (-Q v) := by
  sorry

/-- The scalar units inside the Lipschitz group, Layer 1B. Defined as a homomorphism so that the
kernel theorem below is an equality of subgroups rather than an existential inside the algebra. -/
noncomputable def scalarUnits (Q : QuadraticForm K V) : Kˣ →* lipschitzGroup Q :=
  sorry

theorem scalarUnits_injective (Q : QuadraticForm K V) :
    Function.Injective (scalarUnits Q) := by
  sorry

/-- **Layer 1C**: the vector representation, by twisted conjugation. -/
noncomputable def vectorRepresentation (Q : QuadraticForm K V) :
    lipschitzGroup Q →* orthogonalGroup Q :=
  sorry

/-- **Layer 1C**: surjectivity, which is Cartan–Dieudonné together with the fact that an
anisotropic vector acts as the reflection in it. -/
theorem vectorRepresentation_surjective [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) : Function.Surjective (vectorRepresentation Q) := by
  sorry

/-- **⚠ Layer 1B, the linchpin**, stated as an equality of subgroups. The classical proof computes
the centre of `CliffordAlgebra Q` over a **general** field, which is `K` in even dimension and
`K ⊕ K·ω` in odd dimension, while the graded centre is `K` in both parities. The spin
representations roadmap's structure theorem is over an algebraically closed field and does not
supply this. -/
theorem ker_vectorRepresentation [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) :
    (vectorRepresentation Q).ker = (scalarUnits Q).range := by
  sorry

/-- **The spinor norm**, Layer 1D. ⚠ Both hypotheses are carried because the construction uses
both: Cartan–Dieudonné needs finite dimension, and the kernel theorem needs nondegeneracy. -/
noncomputable def spinorNorm [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) : orthogonalGroup Q →* SquareClass K :=
  sorry

/-- **Layer 1D**: the value on a single reflection, which with multiplicativity and
Cartan–Dieudonné is the whole computational API the lattice side needs. -/
theorem spinorNorm_reflection [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) {v : V} (hv : Q v ≠ 0) (u : Kˣ) (hu : (u : K) = Q v) :
    spinorNorm Q hQ ⟨reflection Q hv, reflection_mem Q hv⟩ = squareClassOfUnit K u := by
  sorry

/-- The canonical `Spin → SO`. Owned by the spin representations roadmap; same name and type. ⚠ No
theorem below quantifies over a replacement for it: at the trivial homomorphism the range theorem
would be false. -/
noncomputable def spinToSpecialOrthogonal (Q : QuadraticForm K V) :
    spinGroup Q →* specialOrthogonalGroup Q :=
  sorry

/-- The central `μ₂` inside `Spin`. -/
noncomputable def muTwoToSpin (Q : QuadraticForm K V) : (rootsOfUnity 2 K) →* spinGroup Q :=
  sorry

/-- **Layer 1E**: the kernel is `μ₂` in **positive** dimension. Dimension zero is separate, where
the kernel is trivial rather than of order two. -/
theorem ker_spinToSpecialOrthogonal [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (hV : 0 < Module.finrank K V) :
    (spinToSpecialOrthogonal Q).ker = (muTwoToSpin Q).range := by
  sorry

/-- **Layer 1E**: the image is the **spinor kernel**, that is the kernel of the spinor norm
restricted along the inclusion of `SO` into `O`. ⚠ The spinor norm need not be surjective, so this
is not a short exact sequence and is never written as one. -/
theorem range_spinToSpecialOrthogonal [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (hV : 0 < Module.finrank K V) :
    (spinToSpecialOrthogonal Q).range =
      ((spinorNorm Q hQ).comp (specialOrthogonalToOrthogonal Q)).ker := by
  sorry

end Layer1

/-! ## Layer 2: the local topology, and the transvections

⚠ The topology is Mathlib's `moduleTopology`, not a private basis transport, and every statement
below carries `IsModuleTopology` rather than an unconstrained `TopologicalSpace` instance. That is
not bookkeeping: for an arbitrary topology the closedness of the isometry set and the openness of
`ker θ` are both **false**, so omitting the hypothesis would not weaken these theorems, it would
make them wrong.
-/

section Layer2

variable {K : Type u} [Field K] [Invertible (2 : K)] [TopologicalSpace K] [IsTopologicalRing K]
variable {V : Type v} [AddCommGroup V] [Module K V]
variable [TopologicalSpace (Module.End K V)] [IsModuleTopology K (Module.End K V)]

/-- **Layer 2B**: the isometry set is closed in `Module.End K V` for the module topology. Stated
about `End` rather than about `V ≃ₗ[K] V`, since the latter is not a module and so has no module
topology of its own; `pointGroupTopology` below is how it acquires one. -/
theorem isClosed_isometrySet [FiniteDimensional K V] (Q : QuadraticForm K V) :
    IsClosed {f : Module.End K V | ∀ x, Q (f x) = Q x} := by
  sorry

/-- **Layer 2B**: the topology on the point group, pinned as the one induced by `f ↦ (f, f⁻¹)`.
Naming it makes every later statement say *which* topology it means, which is what the previous
draft failed to do. -/
@[reducible] def pointGroupTopology : TopologicalSpace (V ≃ₗ[K] V) :=
  TopologicalSpace.induced
    (fun f : V ≃ₗ[K] V => ((f : Module.End K V), (f.symm : Module.End K V))) inferInstance

/-- **Layer 2B**: it makes `V ≃ₗ[K] V` a topological group. -/
theorem isTopologicalGroup_pointGroupTopology :
    @IsTopologicalGroup (V ≃ₗ[K] V) pointGroupTopology _ := by
  sorry

/-- **Layer 2B**: and the orthogonal group is closed in it. -/
theorem isClosed_orthogonalGroup [FiniteDimensional K V] (Q : QuadraticForm K V) :
    @IsClosed (V ≃ₗ[K] V) pointGroupTopology {f | f ∈ orthogonalGroup Q} := by
  sorry

/-- **⚠ Layer 2E**: discreteness of the square-class group makes a *continuous* map into it
locally constant; it does not make an arbitrary map continuous. The content is that the kernel is
**open**, obtained by factoring through the continuous Clifford norm and the open quotient map. -/
theorem isOpen_ker_spinorNorm [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) :
    @IsOpen (V ≃ₗ[K] V) pointGroupTopology
      {f | ∃ h : f ∈ orthogonalGroup Q, (⟨f, h⟩ : orthogonalGroup Q) ∈ (spinorNorm Q hQ).ker} := by
  sorry

end Layer2

section Transvections

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- **Layer 2C**: the Eichler transvection attached to an isotropic `u` and an orthogonal `w`. -/
noncomputable def transvection (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) : V ≃ₗ[K] V :=
  sorry

theorem transvection_apply (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (x : V) :
    transvection Q hu huw x
      = x + polar Q x u • w - polar Q x w • u - (Q w * polar Q x u) • u := by
  sorry

theorem transvection_mem (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) : transvection Q hu huw ∈ orthogonalGroup Q := by
  sorry

/-- **Layer 2C**: the spinor norm of a transvection is trivial, which is why the transvections lie
in the spinor kernel and lift to `Spin` at all. -/
theorem spinorNorm_transvection [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) {u w : V} (hu : Q u = 0) (huw : polar Q u w = 0) :
    spinorNorm Q hQ ⟨transvection Q hu huw, transvection_mem Q hu huw⟩ = 1 := by
  sorry

/-- **Layer 2C**: only the class of `w` modulo `K u` matters. -/
theorem transvection_add_smul (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (c : K) (h' : polar Q u (w + c • u) = 0) :
    transvection Q hu h' = transvection Q hu huw := by
  sorry

/-- **Layer 2C**: the conjugation law. -/
theorem transvection_conj (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (g : orthogonalGroup Q) (hu' : Q (g.1 u) = 0)
    (huw' : polar Q (g.1 u) (g.1 w) = 0) :
    (g : V ≃ₗ[K] V) * transvection Q hu huw * (g : V ≃ₗ[K] V)⁻¹
      = transvection Q hu' huw' := by
  sorry

/-- **Layer 2C**: the canonical Clifford lift of a single transvection. -/
noncomputable def transvectionLift (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) : spinGroup Q :=
  sorry

theorem spinToSpecialOrthogonal_transvectionLift (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) :
    ((spinToSpecialOrthogonal Q (transvectionLift Q hu huw) : V ≃ₗ[K] V))
      = transvection Q hu huw := by
  sorry

/-- **Layer 2C**: additivity in `w`, which is what upgrades a family of lifts to a subgroup. -/
theorem transvectionLift_add (Q : QuadraticForm K V) {u w w' : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (huw' : polar Q u w' = 0) (hsum : polar Q u (w + w') = 0) :
    transvectionLift Q hu hsum = transvectionLift Q hu huw * transvectionLift Q hu huw' := by
  sorry

/-- **⚠ Layer 2C, the milestone**: the lift bundled as a **homomorphism** out of `u^⊥ / K u`, not
a family of individually chosen lifts. Layer 4 has no root subgroup to generate with until this
exists, and `transvection_add_smul` together with `transvectionLift_add` is what makes it well
defined. -/
noncomputable def transvectionLiftHom (Q : QuadraticForm K V) {u : V} (hu : Q u = 0) :
    (LinearMap.ker (polarBilin Q u) ⧸
        Submodule.comap (LinearMap.ker (polarBilin Q u)).subtype (K ∙ u)) →+
      Additive (spinGroup Q) :=
  sorry

/-- **Layer 2C**: and it agrees with the element-level lift. -/
theorem transvectionLiftHom_apply (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) :
    Additive.toMul (transvectionLiftHom Q hu (Submodule.Quotient.mk ⟨w, by sorry⟩))
      = transvectionLift Q hu huw := by
  sorry

end Transvections

/-! ## Layer 3: restricted products, and adelic points

The generic API first. ⚠ Mathlib's `RestrictedProduct` has `map` and `mapAlong` but **no**
congruence: nothing produces an equivalence from componentwise data. The change-of-family
comparison is built here as a **named canonical** map with an evaluation formula and a
continuous inverse, not as a bare existence statement.
-/

section RestrictedProducts

open scoped RestrictedProduct

variable {ι : Type u} {G : ι → Type v}
variable [Π i, Group (G i)] [Π i, TopologicalSpace (G i)] [∀ i, IsTopologicalGroup (G i)]

/-- **Layer 3B**: the everywhere-integral part as an actual `Subgroup`, not merely a set. -/
def integralSubgroup (U : Π i, Subgroup (G i)) :
    Subgroup (Πʳ i, [G i, (U i : Set (G i))]) where
  carrier := {f | ∀ i, f.1 i ∈ U i}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

theorem isOpen_integralSubgroup (U : Π i, Subgroup (G i))
    (hU : ∀ i, IsOpen (U i : Set (G i))) :
    IsOpen (integralSubgroup U : Set (Πʳ i, [G i, (U i : Set (G i))])) := by
  sorry

theorem isCompact_integralSubgroup (U : Π i, Subgroup (G i))
    (hU : ∀ i, IsOpen (U i : Set (G i))) (hK : ∀ i, IsCompact (U i : Set (G i))) :
    IsCompact (integralSubgroup U : Set (Πʳ i, [G i, (U i : Set (G i))])) := by
  sorry

/-- **⚠ Layer 3B**: the canonical change-of-family equivalence, induced by the identity on
coordinates. Mathlib supplies nothing from which this follows. -/
def restrictedProductCongr (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    (Πʳ i, [G i, (U i : Set (G i))]) ≃* (Πʳ i, [G i, (U' i : Set (G i))]) :=
  sorry

theorem restrictedProductCongr_apply (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i)
    (x : Πʳ i, [G i, (U i : Set (G i))]) (i : ι) :
    (restrictedProductCongr U U' h x) i = x i := by
  sorry

/-- The inverse is the congruence for the reversed hypothesis, which is what makes the pair a
homeomorphism rather than merely a bijection. -/
theorem restrictedProductCongr_symm (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i)
    (h' : ∀ᶠ i in Filter.cofinite, U' i = U i) :
    (restrictedProductCongr U U' h).symm = restrictedProductCongr U' U h' := by
  sorry

theorem continuous_restrictedProductCongr (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    Continuous (restrictedProductCongr U U' h) := by
  sorry

theorem continuous_restrictedProductCongr_symm (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    Continuous (restrictedProductCongr U U' h).symm := by
  sorry

/-- Compatibility with the structure map, that is with `∏ U i` sitting inside the restricted
product. -/
theorem restrictedProductCongr_integralSubgroup (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) (hUU' : ∀ i, U i = U' i) :
    (integralSubgroup U).map (restrictedProductCongr U U' h).toMonoidHom
      = integralSubgroup U' := by
  sorry

/-- **⚠ Layer 3E**: the diagonal map, as a named definition. The hypothesis is a theorem, not a
formality: a rational point lands in the chosen compact open at almost every place only because
one can clear denominators. -/
def diagonalEmbedding {Γ : Type w} [Group Γ] (φ : ∀ i, Γ →* G i) (U : Π i, Subgroup (G i))
    (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i) :
    Γ →* Πʳ i, [G i, (U i : Set (G i))] :=
  sorry

theorem diagonalEmbedding_apply {Γ : Type w} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i)
    (γ : Γ) (i : ι) : diagonalEmbedding φ U h γ i = φ i γ := by
  sorry

/-- Uniqueness: the evaluation formula characterizes it. -/
theorem diagonalEmbedding_unique {Γ : Type w} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i)
    (ψ : Γ →* Πʳ i, [G i, (U i : Set (G i))]) (hψ : ∀ γ i, ψ γ i = φ i γ) :
    ψ = diagonalEmbedding φ U h := by
  sorry

theorem diagonalEmbedding_injective {Γ : Type w} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i)
    (hφ : ∃ i, Function.Injective (φ i)) :
    Function.Injective (diagonalEmbedding φ U h) := by
  sorry

end RestrictedProducts

/-! ## Layer 3C to 3F: the specialized adelic objects

⚠ Everything below is built **from `Q`**. The previous draft stated adelic discreteness and strong
approximation for an arbitrary group with arbitrary local groups and arbitrary homomorphisms;
those statements are false, since `Q` did not appear in them. The objects here carry `Q` through
base change, so the theorems say what the roadmap means.

Finite places are indexed by `Nat.Primes`, and the full adelic group is written concretely over ℚ
as the real point group times the finite adelic group, which avoids a dependent completion type
and matches the README's Layer 3D.
-/

section Adelic

open scoped RestrictedProduct TensorProduct

instance factPrimeOfPrimes (p : Nat.Primes) : Fact (Nat.Prime (p : ℕ)) := ⟨p.2⟩

variable {V : Type v} [AddCommGroup V] [Module ℚ V] [FiniteDimensional ℚ V]

/-- The local quadratic space at a finite place. -/
noncomputable abbrev localForm (Q : QuadraticForm ℚ V) (p : Nat.Primes) :
    QuadraticForm ℚ_[(p : ℕ)] (ℚ_[(p : ℕ)] ⊗[ℚ] V) :=
  Q.baseChange ℚ_[(p : ℕ)]

/-- The local quadratic space at the real place. -/
noncomputable abbrev realForm (Q : QuadraticForm ℚ V) : QuadraticForm ℝ (ℝ ⊗[ℚ] V) :=
  Q.baseChange ℝ

/-- **Layer 0B**, used here: base change of the orthogonal group along a field extension. -/
noncomputable def orthogonalBaseChange (Q : QuadraticForm ℚ V) (p : Nat.Primes) :
    orthogonalGroup Q →* orthogonalGroup (localForm Q p) :=
  sorry

noncomputable def orthogonalBaseChangeReal (Q : QuadraticForm ℚ V) :
    orthogonalGroup Q →* orthogonalGroup (realForm Q) :=
  sorry

/-- **⚠ Layer 3C**: the compatible compact-open data. A single family `U p ≤ O(V_p)` does not
determine the reference subgroups for `SO`, for `Spin`, or for the square-class codomain, so the
parameter is a tuple carrying its compatibility hypotheses. -/
structure CompatibleCompactOpens (Q : QuadraticForm ℚ V) where
  /-- The compact open subgroup of the local orthogonal group. -/
  orth : Π p : Nat.Primes, Subgroup (orthogonalGroup (localForm Q p))
  /-- The compact open subgroup of the local spin group. -/
  spin : Π p : Nat.Primes, Subgroup (spinGroup (localForm Q p))
  /-- ⚠ The local topology is part of the data, because Layer 2B's `pointGroupTopology` is a
  named definition and not an instance; a structure that spoke of open subgroups without saying
  which topology would be meaningless. -/
  top : Π p : Nat.Primes, TopologicalSpace (orthogonalGroup (localForm Q p))
  /-- Openness, at every finite place. -/
  isOpen_orth : ∀ p, @IsOpen _ (top p) (orth p : Set (orthogonalGroup (localForm Q p)))
  /-- Compactness, at every finite place. -/
  isCompact_orth : ∀ p, @IsCompact _ (top p) (orth p : Set (orthogonalGroup (localForm Q p)))
  /-- ⚠ The `Spin` datum is supplied, not obtained as a preimage: a preimage of a compact set
  under `Spin → SO` is compact only once properness is known. -/
  spin_maps : ∀ p, ∀ g ∈ spin p,
    (specialOrthogonalToOrthogonal (localForm Q p)) (spinToSpecialOrthogonal (localForm Q p) g)
      ∈ orth p
  /-- Every rational isometry is integral at almost every place, which is what makes the diagonal
  embedding of 3E well defined. -/
  eventually_mem : ∀ g : orthogonalGroup Q,
    ∀ᶠ p in Filter.cofinite, orthogonalBaseChange Q p g ∈ orth p

/-- The reference subgroup in the local square-class group, `θ_p(U_p^{SO})`. ⚠ Without it there is
no such thing as "the restricted product of the local square-class groups". -/
noncomputable def localSpinorNormImage (Q : QuadraticForm ℚ V) (hQ : Q.Nondegenerate)
    (U : CompatibleCompactOpens Q) (p : Nat.Primes) :
    Subgroup (SquareClass ℚ_[(p : ℕ)]) :=
  sorry

end Adelic

/-! ## Layers 3D to 4: the adelic point groups and strong approximation

⚠ The finite adelic groups below need the local point groups to be topological groups, which is
Layer 2B's `pointGroupTopology`. Pinning those instances is Layer 2's job; the statements here
carry them as hypotheses so that no theorem is stated against an unnamed topology.
-/

section StrongApproximation

open scoped RestrictedProduct TensorProduct

variable {V : Type v} [AddCommGroup V] [Module ℚ V] [FiniteDimensional ℚ V]
variable (Q : QuadraticForm ℚ V)
variable [Π p : Nat.Primes, TopologicalSpace (orthogonalGroup (localForm Q p))]
variable [∀ p : Nat.Primes, IsTopologicalGroup (orthogonalGroup (localForm Q p))]

/-- **Layer 3D**: the finite adelic orthogonal group, a genuine restricted product of the local
point groups of `Q` relative to the chosen compact opens. -/
abbrev finiteAdelicOrthogonal (U : CompatibleCompactOpens Q) : Type _ :=
  Πʳ p : Nat.Primes,
    [orthogonalGroup (localForm Q p), (U.orth p : Set (orthogonalGroup (localForm Q p)))]

/-- **Layer 3E**: the diagonal embedding of the rational points, whose defining hypothesis is
`CompatibleCompactOpens.eventually_mem`. -/
noncomputable def adelicDiagonal (U : CompatibleCompactOpens Q) :
    orthogonalGroup Q →* finiteAdelicOrthogonal Q U :=
  diagonalEmbedding (fun p => orthogonalBaseChange Q p) (fun p => U.orth p) U.eventually_mem

theorem adelicDiagonal_apply (U : CompatibleCompactOpens Q) (g : orthogonalGroup Q)
    (p : Nat.Primes) : adelicDiagonal Q U g p = orthogonalBaseChange Q p g := by
  sorry

/-- **Layer 3D**: the full adelic group, written concretely over ℚ as the real point group times
the finite adelic group. -/
abbrev fullAdelicOrthogonal (U : CompatibleCompactOpens Q)
    [TopologicalSpace (orthogonalGroup (realForm Q))] : Type _ :=
  orthogonalGroup (realForm Q) × finiteAdelicOrthogonal Q U

/-- **⚠ Layer 3E**: the rational points are discrete in the **full** adelic group. Stated for the
actual orthogonal group of `Q`, not for an arbitrary abstract group: the previous generic form was
false, since a nondiscrete local group with the identity diagonal is a counterexample. -/
theorem discreteTopology_fullAdelicDiagonal (U : CompatibleCompactOpens Q)
    [TopologicalSpace (orthogonalGroup (realForm Q))]
    [IsTopologicalGroup (orthogonalGroup (realForm Q))] (hQ : Q.Nondegenerate) :
    DiscreteTopology
      (MonoidHom.range
        ((orthogonalBaseChangeReal Q).prod (adelicDiagonal Q U))) := by
  sorry

/-- **⚠ Layer 3E**, the contrast, and the acceptance test for it: the rational points are **not**
discrete in the finite adelic group, for an isotropic `Q` of dimension at least three. The
transvections `E_{u,tw}` with `t` highly divisible accumulate at the identity, which is exactly
consistent with Layer 4, where that same image is dense. -/
theorem not_discreteTopology_finiteAdelicDiagonal (U : CompatibleCompactOpens Q)
    (hQ : Q.Nondegenerate) (hdim : 3 ≤ Module.finrank ℚ V)
    (hiso : ∃ v : V, v ≠ 0 ∧ Q v = 0) :
    ¬ DiscreteTopology (MonoidHom.range (adelicDiagonal Q U)) := by
  sorry

/-- **Layer 3F**: the adelic spinor norm, valued in the restricted product of the local
square-class groups **relative to the reference subgroups** `θ_p(U_p^{SO})` of 3C. -/
noncomputable def adelicSpinorNorm (hQ : Q.Nondegenerate) (U : CompatibleCompactOpens Q) :
    finiteAdelicOrthogonal Q U →*
      Πʳ p : Nat.Primes, [SquareClass ℚ_[(p : ℕ)],
        (localSpinorNormImage Q hQ U p : Set (SquareClass ℚ_[(p : ℕ)]))] :=
  sorry

/-- **Layer 3F**: the adelic spinor kernel, which is what Layer 4F's closure theorem is about. -/
noncomputable def adelicSpinorKernel (hQ : Q.Nondegenerate) (U : CompatibleCompactOpens Q) :
    Subgroup (finiteAdelicOrthogonal Q U) :=
  (adelicSpinorNorm Q hQ U).ker

/-- **Layer 4E**, the corollary the integral lattices roadmap consumes:
`Spin(V)(𝔸_f) = Spin(V)(ℚ) · W` for every compact open `W`, when `V` is indefinite of dimension at
least three. ⚠ Stated with `Q` genuinely present, unlike the previous draft. Indefiniteness is
spelled through the signature of the real form; note `sigPos` and `sigNeg` live in the **root**
namespace, not under `QuadraticForm`. -/
theorem strongApproximation_finiteAdeles (hQ : Q.Nondegenerate) (hdim : 3 ≤ Module.finrank ℚ V)
    (hindef : 0 < sigPos (realForm Q) ∧ 0 < sigNeg (realForm Q))
    (U : CompatibleCompactOpens Q)
    (W : Subgroup (finiteAdelicOrthogonal Q U))
    (hW : IsOpen (W : Set (finiteAdelicOrthogonal Q U)))
    (hWc : IsCompact (W : Set (finiteAdelicOrthogonal Q U))) :
    ∀ x ∈ adelicSpinorKernel Q hQ U,
      ∃ (g : orthogonalGroup Q) (w : W), x = adelicDiagonal Q U g * (w : _) := by
  sorry

/-- **Layer 4F**: what the theorem gives in `SO`, exactly. The continuous image of a dense set is
dense in the image, not in the ambient group, so the transported statement is about the adelic
spinor kernel: the closure of the diagonal rational image is that subgroup, and the obstruction to
strong approximation for `SO` is measured by the adelic spinor norm rather than being a blanket
failure. -/
theorem closure_adelicDiagonal_range (hQ : Q.Nondegenerate) (hdim : 3 ≤ Module.finrank ℚ V)
    (hindef : 0 < sigPos (realForm Q) ∧ 0 < sigNeg (realForm Q))
    (U : CompatibleCompactOpens Q) :
    closure ((adelicDiagonal Q U).range : Set (finiteAdelicOrthogonal Q U))
      = (adelicSpinorKernel Q hQ U : Set (finiteAdelicOrthogonal Q U)) := by
  sorry

end StrongApproximation

end TauCetiRoadmap.OrthogonalSpinGroups
