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

universe u v

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

⚠ A finite-dimensional space over a local field carries no `TopologicalSpace` instance on its own.
The topology is transported through a basis and then proved independent of the basis; that
independence is the milestone, and it is what makes every later topological statement well posed.
-/

section Layer2

variable {K : Type u} [Field K] [Invertible (2 : K)] [TopologicalSpace K]
variable {V : Type v} [AddCommGroup V] [Module K V]

/-- **Layer 2A**: the topology transported through a chosen basis. -/
@[reducible] def moduleTopologyOfBasis {ι : Type v} [Fintype ι] (b : Module.Basis ι K V) :
    TopologicalSpace V :=
  sorry

/-- **Layer 2A**, the milestone: any two bases give the same topology, because every
change-of-basis map and its inverse are continuous. Only after this is "the" topology on `V`, on
`Module.End K V` and on `V ≃ₗ[K] V` a well-defined object. -/
theorem moduleTopologyOfBasis_eq {ι ι' : Type v} [Fintype ι] [Fintype ι']
    (b : Module.Basis ι K V) (b' : Module.Basis ι' K V) :
    moduleTopologyOfBasis b = moduleTopologyOfBasis b' := by
  sorry

/-! ⚠ From here on the topologies of 2A are carried as hypotheses rather than synthesized. That is
not a workaround: Lean will not produce a `TopologicalSpace (V ≃ₗ[K] V)` from a topology on `V`,
which is precisely why 2A has to construct the transported topology and prove it basis-independent
before any of the statements below are even well posed. -/

variable [TopologicalSpace V] [TopologicalSpace (V ≃ₗ[K] V)]

/-- **Layer 2B**: the orthogonal group is closed, being cut out by polynomial equations. Local
compactness then comes from closedness inside a finite-dimensional space over a locally compact
field. -/
theorem isClosed_orthogonalGroup [FiniteDimensional K V] (Q : QuadraticForm K V) :
    IsClosed {f : V ≃ₗ[K] V | f ∈ orthogonalGroup Q} := by
  sorry

/-- **⚠ Layer 2E**: discreteness of the square-class group makes a *continuous* map into it
locally constant, but does not make an arbitrary map continuous. The real content is that the
kernel is **open**, obtained by factoring through the continuous Clifford norm and the open
quotient map. -/
theorem isOpen_ker_spinorNorm [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) :
    IsOpen {g : orthogonalGroup Q | g ∈ (spinorNorm Q hQ).ker} := by
  sorry

/-- **Layer 2C**: the Eichler transvection attached to an isotropic `u` and an orthogonal `w`. -/
noncomputable def transvection (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) : V ≃ₗ[K] V :=
  sorry

theorem transvection_apply (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (x : V) :
    transvection Q hu huw x
      = x + polar Q x u • w - polar Q x w • u - (Q w * polar Q x u) • u := by
  sorry

/-- **Layer 2C**: additivity in `w`, which is what makes the transvections a one-parameter
subgroup rather than a family of elements. -/
theorem transvection_add (Q : QuadraticForm K V) {u w w' : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) (huw' : polar Q u w' = 0)
    (hsum : polar Q u (w + w') = 0) :
    transvection Q hu hsum = transvection Q hu huw * transvection Q hu huw' := by
  sorry

/-- **⚠ Layer 2C**: the canonical Clifford lift. Trivial spinor norm gives each transvection *a*
lift, and a family of lifts is not a subgroup; the milestone is this explicit homomorphic lift,
whose additivity in `w` and compatibility with `spinToSpecialOrthogonal` are what Layer 4
generates with. -/
noncomputable def transvectionLift (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) : spinGroup Q :=
  sorry

theorem spinToSpecialOrthogonal_transvectionLift (Q : QuadraticForm K V) {u w : V} (hu : Q u = 0)
    (huw : polar Q u w = 0) :
    ((spinToSpecialOrthogonal Q (transvectionLift Q hu huw) : V ≃ₗ[K] V))
      = transvection Q hu huw := by
  sorry

end Layer2

/-! ## Layer 3: restricted products, and adelic points

The generic API first. ⚠ Mathlib's `RestrictedProduct` has `map` and `mapAlong` but **no**
congruence: nothing produces an equivalence from componentwise data. The change-of-family
comparison is therefore built here, and as a **named canonical** map with an evaluation formula,
not as a bare existence statement, because the arithmetic needs to know which map it holds.
-/

section Layer3

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
coordinates. This is the lemma a consumer needs in order to substitute its own compact opens, and
Mathlib supplies nothing from which it follows. -/
def restrictedProductCongr (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    (Πʳ i, [G i, (U i : Set (G i))]) ≃* (Πʳ i, [G i, (U' i : Set (G i))]) :=
  sorry

/-- Its defining property: it is the identity on every coordinate. -/
theorem restrictedProductCongr_apply (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i)
    (x : Πʳ i, [G i, (U i : Set (G i))]) (i : ι) :
    (restrictedProductCongr U U' h x) i = x i := by
  sorry

theorem continuous_restrictedProductCongr (U U' : Π i, Subgroup (G i))
    (h : ∀ᶠ i in Filter.cofinite, U i = U' i) :
    Continuous (restrictedProductCongr U U' h) := by
  sorry

/-- **⚠ Layer 3E**: the diagonal map, as a named definition rather than an existence statement.
The hypothesis is a theorem, not a formality: a rational point lands in the chosen compact open at
almost every place only because one can clear denominators. -/
def diagonalEmbedding {Γ : Type u} [Group Γ] (φ : ∀ i, Γ →* G i) (U : Π i, Subgroup (G i))
    (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i) :
    Γ →* Πʳ i, [G i, (U i : Set (G i))] :=
  sorry

theorem diagonalEmbedding_apply {Γ : Type u} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i)
    (γ : Γ) (i : ι) : diagonalEmbedding φ U h γ i = φ i γ := by
  sorry

theorem diagonalEmbedding_injective {Γ : Type u} [Group Γ] (φ : ∀ i, Γ →* G i)
    (U : Π i, Subgroup (G i)) (h : ∀ γ : Γ, ∀ᶠ i in Filter.cofinite, φ i γ ∈ U i)
    (hφ : ∃ i, Function.Injective (φ i)) :
    Function.Injective (diagonalEmbedding φ U h) := by
  sorry

end Layer3

/-! ## Layer 3D: the index types, pinned

⚠ The roadmap's `p` and `v` are informal. The Lean statements need one type for the finite places
and one for all places, fixed once, so that `𝔸_f`, `𝔸^S` and `𝔸` are three different restricted
products over three explicitly related index types rather than three uses of one notation.
-/

/-- The places of `ℚ`. -/
inductive Place
  | infinite : Place
  | finite : Nat.Primes → Place
  deriving DecidableEq

section Adelic

open scoped RestrictedProduct

variable {G : Place → Type v} [Π v, Group (G v)] [Π v, TopologicalSpace (G v)]
variable [∀ v, IsTopologicalGroup (G v)]

/-- **Layer 3D**: points away from a finite set `S` of places. `𝔸_f` is the case `S = {∞}` and the
full adelic group the case `S = ∅`, so the three objects are one construction at three values of
`S`, which is why the away-`S` object is the one defined. -/
abbrev awayPoints (S : Finset Place) (U : Π v, Subgroup (G v)) : Type _ :=
  Πʳ v : {v : Place // v ∉ S}, [G v.1, (U v.1 : Set (G v.1))]

/-- The diagonal map into the away-`S` points. -/
def awayDiagonal {Γ : Type v} [Group Γ] (S : Finset Place) (φ : ∀ v, Γ →* G v)
    (U : Π v, Subgroup (G v))
    (h : ∀ γ : Γ, ∀ᶠ v in Filter.cofinite, φ v γ ∈ U v) :
    Γ →* awayPoints (G := G) S U :=
  sorry

theorem awayDiagonal_apply {Γ : Type v} [Group Γ] (S : Finset Place) (φ : ∀ v, Γ →* G v)
    (U : Π v, Subgroup (G v)) (h : ∀ γ : Γ, ∀ᶠ v in Filter.cofinite, φ v γ ∈ U v)
    (γ : Γ) (v : {v : Place // v ∉ S}) :
    awayDiagonal S φ U h γ v = φ v.1 γ := by
  sorry

/-- **⚠ Layer 3E**: the rational points are discrete in the **full** adelic group, that is at
`S = ∅`, once the real place is included. They are **not** discrete at `S = {∞}`: the
transvections `E_{u,tw}` with `t` a highly divisible integer accumulate at the identity there,
which is exactly consistent with Layer 4, where that same image is dense. Every fundamental-domain
and covolume statement of Layer 5 is made against the full adelic group for this reason. -/
theorem discreteTopology_awayDiagonal_range {Γ : Type v} [Group Γ] (φ : ∀ v, Γ →* G v)
    (U : Π v, Subgroup (G v)) (h : ∀ γ : Γ, ∀ᶠ v in Filter.cofinite, φ v γ ∈ U v)
    (hopen : ∀ v, IsOpen (U v : Set (G v))) :
    DiscreteTopology (awayDiagonal (G := G) (∅ : Finset Place) φ U h).range := by
  sorry

end Adelic

/-! ## Layer 4: strong approximation, in the form the lattice side consumes

⚠ Only the `S = {∞}` corollary is pinned here. The general-`S` statement quantifies over
`ℚ`-almost-simple factors of `Spin(V)`, which needs the affine group schemes of Layer 3A; it stays
in prose in `README.md` until those exist, since a `Prop`-valued placeholder would assert nothing.
The compact-open reformulation additionally requires `∞ ∈ S`, so that `𝔸^S` is totally
disconnected; that hypothesis holds automatically in the corollary below.
-/

section Layer4

open scoped RestrictedProduct

variable {V : Type v} [AddCommGroup V] [Module ℚ V] [FiniteDimensional ℚ V]
variable {G : Place → Type v} [Π v, Group (G v)] [Π v, TopologicalSpace (G v)]
variable [∀ v, IsTopologicalGroup (G v)]

/-- **Layer 4E**, the corollary the integral lattices roadmap consumes:
`Spin(V)(𝔸_f) = Spin(V)(ℚ) · W` for every compact open `W`, when `V` is indefinite of dimension at
least three. Indefiniteness is spelled through the signature of the real form; ⚠ note that
`sigPos` and `sigNeg` live in the **root** namespace, not under `QuadraticForm`. -/
theorem strongApproximation_finiteAdeles {Γ : Type v} [Group Γ]
    (Q : QuadraticForm ℚ V) (hQ : Q.Nondegenerate) (hdim : 3 ≤ Module.finrank ℚ V)
    (hindef : 0 < sigPos (Q.baseChange ℝ) ∧ 0 < sigNeg (Q.baseChange ℝ))
    (φ : ∀ v, Γ →* G v) (U : Π v, Subgroup (G v))
    (h : ∀ γ : Γ, ∀ᶠ v in Filter.cofinite, φ v γ ∈ U v)
    (W : Subgroup (awayPoints (G := G) {Place.infinite} U))
    (hW : IsOpen (W : Set (awayPoints (G := G) {Place.infinite} U)))
    (hWc : IsCompact (W : Set (awayPoints (G := G) {Place.infinite} U))) :
    ∀ x : awayPoints (G := G) {Place.infinite} U,
      ∃ (γ : Γ) (w : W), x = awayDiagonal {Place.infinite} φ U h γ * (w : _) := by
  sorry

end Layer4

end TauCetiRoadmap.OrthogonalSpinGroups
