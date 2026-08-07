import Mathlib

/-!
# Orthogonal and spin groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is `README.md`.
The statements here suggest Lean forms for particular milestones, so that contributors and
reviewers converge on names and signatures; discharging all of them finishes neither a layer nor
the roadmap.

The narrative roadmap (Layers 0 to 5, the convention table, the worked examples and the
references) is in `README.md`. Mathlib has the Clifford algebra with `lipschitzGroup`, `pinGroup`
and `spinGroup`, reflections as linear equivalences attached to a functional, `RestrictedProduct`
with its topology, the adeles as topological rings, and Haar measure with quotient covolumes. It
has no spinor norm, no adelic point group, no strong approximation and no Tamagawa measure.

The objects this roadmap builds on but does not own are restated here only so that the file
elaborates on its own: `orthogonalGroup` and `specialOrthogonalGroup` belong to the spin
representations roadmap, and the reflection belongs to the quadratic form invariants roadmap. Where
those roadmaps land in `TauCeti/`, these definitions are deleted and theirs imported. The
declarations this roadmap genuinely owns are the spinor norm and everything after it.

Conventions follow `README.md`: `K` is a field with `[Invertible (2 : K)]`; the bilinear form is
Mathlib's un-halved `QuadraticMap.polarBilin Q`, so `B x x = 2 • Q x`, and the reflection in an
anisotropic `v` is `x ↦ x - (B x v / Q v) • v`, built through `Module.reflection` rather than by
hand; `SO` means determinant one; the Clifford groups act by twisted conjugation; the spinor norm
is defined through a reflection factorization and lands in `Kˣ ⧸ Subgroup.square Kˣ`.

The Tamagawa statements of Layer 5 are absent here, deliberately. Their types need the adelic
groups of Layer 3 and the canonical measures of Layer 5 to exist in `TauCeti/` first; they stay in
prose in `README.md` until then, and nothing stands in for them, since a `Prop`-valued placeholder
would assert nothing.
-/

namespace TauCetiRoadmap.OrthogonalSpinGroups

open QuadraticMap

universe u v

/-! ## Layer 0: the orthogonal group, its determinant, and reflections -/

section Layer0

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- **The orthogonal group** of a quadratic form, as a subgroup of the linear automorphisms.

Owned by the spin representations roadmap (`orthogonalGroup Q : Subgroup (M ≃ₗ[R] M)`); restated
here only so that this file elaborates. -/
def orthogonalGroup (Q : QuadraticForm K V) : Subgroup (V ≃ₗ[K] V) where
  carrier := {f | ∀ x, Q (f x) = Q x}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **The determinant homomorphism** on the orthogonal group, the restriction of
`LinearEquiv.det`. Layer 0A. -/
noncomputable def det (Q : QuadraticForm K V) : orthogonalGroup Q →* Kˣ :=
  (LinearEquiv.det (R := K) (M := V)).comp (orthogonalGroup Q).subtype

/-- **Layer 0A**: for a nondegenerate form the determinant of an isometry is a square root of one,
so it lands in `μ₂`. This is the theorem that makes `SO(Q)` a subgroup of index at most two, and
it is proved from the Gram congruence `Mᵀ G M = G` together with `det G ≠ 0`. -/
theorem det_sq_eq_one [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (g : orthogonalGroup Q) : det Q g ^ 2 = 1 := by
  sorry

/-- **The special orthogonal group**, the kernel of the determinant. Owned by the spin
representations roadmap as `specialOrthogonalGroup Q`. -/
noncomputable def specialOrthogonalGroup (Q : QuadraticForm K V) : Subgroup (orthogonalGroup Q) :=
  (det Q).ker

/-- **Layer 0A**: for a nondegenerate form in positive dimension the special orthogonal group has
index exactly two. The content is that a nondegenerate form in characteristic not two has an
anisotropic vector, hence an improper reflection. Dimension zero is genuinely different, and is
why the hypothesis is stated rather than assumed. -/
theorem index_specialOrthogonalGroup [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (hV : 0 < Module.finrank K V) :
    (specialOrthogonalGroup Q).index = 2 := by
  sorry

/-- The functional cutting out the reflection hyperplane of an anisotropic vector. Its defining
property is `reflectionForm_apply_self`, which is exactly the hypothesis `Module.reflection`
wants. -/
noncomputable def reflectionForm (Q : QuadraticForm K V) (v : V) : Module.Dual K V :=
  (Q v)⁻¹ • Q.polarBilin v

/-- ⚠ The factor of two, pinned. Mathlib's `polar` is un-halved, so `B v v = 2 • Q v` and the
reflection coefficient is `B x v / Q v`, **not** `2 * B x v / B v v`. This lemma is what makes
`Module.reflection` applicable, and it is the acceptance check for the convention. -/
theorem reflectionForm_apply_self (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    reflectionForm Q v v = 2 := by
  sorry

/-- **The reflection** in an anisotropic vector, built through `Module.reflection` so that
involutivity and `τ_v v = -v` come from Mathlib rather than a private definition. Owned by the
quadratic form invariants roadmap; restated here for the determinant and transitivity lemmas
below, which that roadmap does not state. -/
noncomputable def reflection (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) : V ≃ₗ[K] V :=
  Module.reflection (reflectionForm_apply_self Q hv)

theorem reflection_apply (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (x : V) :
    reflection Q hv x = x - (Q v)⁻¹ • polar Q x v • v := by
  sorry

theorem reflection_mem (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    reflection Q hv ∈ orthogonalGroup Q := by
  sorry

/-- **Layer 0D**: the determinant of a reflection is `-1`. Mathlib has no determinant lemma for
`Module.reflection` in any form, and this is what makes the parity statement of Layer 0F
meaningful. -/
theorem det_reflection [FiniteDimensional K V] (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) :
    LinearEquiv.det (reflection Q hv) = -1 := by
  sorry

/-- **Layer 0D**: reflections are conjugated by isometries in the expected way. This is what makes
the spinor norm constant on the conjugacy class of a reflection. -/
theorem reflection_conj (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (g : orthogonalGroup Q)
    (hgv : Q (g.1 v) ≠ 0) :
    (g : V ≃ₗ[K] V) * reflection Q hv * (g : V ≃ₗ[K] V)⁻¹ = reflection Q hgv := by
  sorry

/-- **Layer 0E**, the transitivity engine, in the explicit form the spinor norm computes with. If
`Q v = Q w ≠ 0` and `Q (v - w) ≠ 0`, the reflection in `v - w` carries `v` to `w` on the nose: the
coefficient `polar Q v (v - w) / Q (v - w)` is exactly `1`.

Witt's extension theorem gives the existence of such an isometry and says nothing about its
spinor norm, which is why this explicit statement is a milestone here. -/
theorem reflection_sub_apply (Q : QuadraticForm K V) {v w : V} (hQ : Q v = Q w)
    (h : Q (v - w) ≠ 0) : reflection Q h v = w := by
  sorry

/-- **Layer 0E**, the complementary case. Since `Q (v - w) + Q (v + w) = 2 • Q v + 2 • Q w`, at
least one of the two vectors is anisotropic whenever `Q v = Q w ≠ 0`, so the pair of statements
covers every case. -/
theorem reflection_add_apply (Q : QuadraticForm K V) {v w : V} (hQ : Q v = Q w)
    (h : Q (v + w) ≠ 0) : reflection Q h v = -w := by
  sorry

end Layer0

/-! ## Layer 1: the Clifford norm, the spinor norm, and the comparison sequence -/

section Layer1

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- The square-class group `Kˣ/(Kˣ)²`, the codomain of the spinor norm. This is the quadratic form
invariants roadmap's spelling, interoperating with the landed `TauCeti.SquareClassGroup`; no second
representation is introduced. -/
abbrev SquareClass (K : Type u) [Field K] : Type u := Kˣ ⧸ Subgroup.square Kˣ

/-- **The Clifford norm** on the Lipschitz group, `N g = reverse g * g`.

⚠ The milestone hiding here is that the right-hand side is a scalar; the signature records the
conclusion of that theorem. Mathlib's `pinGroup` is already cut out by `star x * x = 1` with
`star = reverse ∘ involute`, so this is the same expression read on the whole Lipschitz group. -/
noncomputable def cliffordNorm (Q : QuadraticForm K V) :
    lipschitzGroup Q →* Kˣ :=
  sorry

/-- **Layer 1A**: the Clifford norm of a vector is its value under `Q`, up to the sign pinned
against `star_ι`. Since `[-1]` is a square class in its own right, a formula that is right up to
sign is not right, which is why the sign is stated here rather than absorbed into the spinor
norm, whose codomain cannot see it. -/
theorem cliffordNorm_ι (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (g : lipschitzGroup Q)
    (hg : ((g : (CliffordAlgebra Q)ˣ) : CliffordAlgebra Q) = CliffordAlgebra.ι Q v) :
    ((cliffordNorm Q g : Kˣ) : K) = Q v ∨ ((cliffordNorm Q g : Kˣ) : K) = -Q v := by
  sorry

/-- **Layer 1B**: the vector representation of the Lipschitz group, by twisted conjugation.
Surjectivity onto `O(Q)` is Cartan–Dieudonné, and the kernel is exactly the nonzero scalars; that
kernel theorem is the linchpin of the layer. -/
noncomputable def vectorRepresentation (Q : QuadraticForm K V) :
    lipschitzGroup Q →* orthogonalGroup Q :=
  sorry

/-- **Layer 1B**: the vector representation is surjective, which is Cartan–Dieudonné together with
the fact that an anisotropic vector acts as the reflection in it. -/
theorem vectorRepresentation_surjective [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) : Function.Surjective (vectorRepresentation Q) := by
  sorry

/-- **⚠ Layer 1B, the linchpin.** The kernel of twisted conjugation is exactly the nonzero
scalars. The classical proof computes the centre of `CliffordAlgebra Q`, which is `K` in even
dimension and `K ⊕ K·ω` in odd dimension for `ω` the product of an orthogonal basis, while the
graded centre is `K` in both parities. Everything else in this layer rests on it, and it is where
a contributor should expect the work to be. -/
theorem mem_ker_vectorRepresentation [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (g : lipschitzGroup Q) :
    g ∈ (vectorRepresentation Q).ker ↔
      ∃ c : K, ((g : (CliffordAlgebra Q)ˣ) : CliffordAlgebra Q) =
        algebraMap K (CliffordAlgebra Q) c := by
  sorry

/-- **The spinor norm**, Layer 1C, the object this roadmap owns.

Defined through a reflection factorization: `θ (τ_{v₁} ⬝⬝⬝ τ_{v_r}) = [Q v₁ ⬝⬝⬝ Q v_r]`. It is not
defined as a quotient by the image of `Spin`, because computing it on a lattice stabilizer means
computing it one reflection at a time. That it is a homomorphism is part of the signature; that it
is well defined at all is `spinorNorm_reflection` together with Cartan–Dieudonné. -/
noncomputable def spinorNorm (Q : QuadraticForm K V) :
    orthogonalGroup Q →* SquareClass K :=
  sorry

/-- **Layer 1C**: the value on a single reflection. Together with multiplicativity and
Cartan–Dieudonné this characterizes the spinor norm, and it is the whole computational API the
lattice side needs. -/
theorem spinorNorm_reflection (Q : QuadraticForm K V) {v : V} (hv : Q v ≠ 0) (u : Kˣ)
    (hu : (u : K) = Q v) :
    spinorNorm Q ⟨reflection Q hv, reflection_mem Q hv⟩ = QuotientGroup.mk u := by
  sorry

/-- **Layer 1D**: the image of `Spin(Q)(K) → SO(Q)(K)` is the spinor kernel, that is the kernel of
the spinor norm restricted to `SO(Q)`. ⚠ The spinor norm is not surjective on `SO(Q)` in general,
so the comparison is not a short exact sequence and is never written as one; the hyperbolic plane
is the smallest counterexample. -/
theorem range_spinToSpecialOrthogonal [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate)
    (spinToSO : spinGroup Q →* specialOrthogonalGroup Q) :
    spinToSO.range =
      ((spinorNorm Q).comp (specialOrthogonalGroup Q).subtype).ker := by
  sorry

end Layer1

/-! ## Layer 3: restricted products of local point groups

The generic API comes first and is about topological groups only. ⚠ The congruence statement
below has no counterpart in Mathlib: `RestrictedProduct` carries `map`, `mapAlong` and their
monoid- and ring-hom versions, all one-directional, and nothing that produces an equivalence from
componentwise data. It is the most-used lemma of the layer, since it is what lets a consumer swap
in its own compact opens. -/

section Layer3

open scoped RestrictedProduct

variable {ι : Type u} {G : ι → Type v}
variable [Π i, Group (G i)] [Π i, TopologicalSpace (G i)] [∀ i, IsTopologicalGroup (G i)]

/-- **Layer 3A**: two families of compact open subgroups agreeing at all but finitely many places
give isomorphic restricted products. Stated as a multiplicative equivalence here; the milestone in
`README.md` asks for the isomorphism of topological groups, whose statement additionally needs the
map to be a homeomorphism. -/
theorem restrictedProduct_congr (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    Nonempty ((Πʳ i, [G i, (U i : Set (G i))]) ≃* (Πʳ i, [G i, (U' i : Set (G i))])) := by
  sorry

/-- **Layer 3A**: the subgroup of everywhere-integral elements is open. Mathlib supplies this as
`RestrictedProduct.isOpen_forall_mem` for the underlying set; what is recorded here is that it is a
subgroup, which is what the compact-open family has to be for the adelic theory to work. -/
theorem isOpen_structureMap_range (U : Π i, Subgroup (G i)) (hU : ∀ i, IsOpen (U i : Set (G i))) :
    IsOpen {f : Πʳ i, [G i, (U i : Set (G i))] | ∀ i, f.1 i ∈ U i} := by
  sorry

/-- **⚠ Layer 3C**, the diagonal embedding and the hypothesis it needs, stated at the generic
level where it belongs. A rational point maps into the restricted product only once one knows it
lands in the chosen compact open at almost every place, and that is a theorem, not a formality.
The hypothesis is carried explicitly here; Layer 3C.2 discharges it for the stabilizers of the
`ℤ`-span of a basis, and a consumer discharges it for the stabilizers of its own lattice. -/
theorem exists_diagonalEmbedding {Γ : Type u} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i) :
    ∃ ψ : Γ →* Πʳ i, [G i, (U i : Set (G i))], ∀ (γ : Γ) (i : ι), ψ γ i = φ i γ := by
  sorry

end Layer3

end TauCetiRoadmap.OrthogonalSpinGroups
