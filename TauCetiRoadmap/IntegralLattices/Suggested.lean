import Mathlib

/-!
# Integral quadratic forms and lattices: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap is in `README.md`: Layers 0 to 9, together with Layer B for binary
lattices, the convention table, the worked examples and the references. Mathlib has quadratic maps over semirings, symmetric
bilinear forms with Gram matrices and base change, `ZLattice` covolumes, Smith normal form
with the index-equals-determinant theorems, and a dual-submodule construction, but no
integral-lattice arithmetic: no even/odd theory, no discriminant groups or forms, no
genus, no mass formula, no Nikulin embedding theory, no lattice theta series. We build that
in `TauCeti/`.

The first section fixes the carriers the whole roadmap is written against: the bundled
lattice form, the two circle groups `ℚ/ℤ` and `ℚ/2ℤ` with the halving map between them,
and finite quadratic forms with their polar bilinear form. These are definitions, not
targets, and the layers below are stated in terms of them.

The second section holds the interfaces to the supplier roadmaps, as structures whose
fields are the exact objects and equations consumed: the spinor norm with its value on a
reflection, the Hilbert symbols with their product formula, and the analytic theta with its
transformation. Each interface elaborates, and each is consumed by an example below, so no
central interface is left as prose. Replacing one with the supplier's declarations is
mechanical, since it means building one term of the structure.

The remaining sections pin targets for **Layer 0** (the bilinear and quadratic dictionary,
Gram determinants, the standard examples), **Layer 1** (dual lattices, the
discriminant-group cardinality, unimodularity, integral against even overlattices, the
signature-mod-8 statement), **Layer 2** (finiteness of automorphism groups and of positive
definite classes, the covolume identity, `|O(E₈)| = 696729600`), **Layer 3** (odd-`p`
orthogonal splitting, the dyadic counterexample, the constraint from the product formula),
**Layer 4** (the spinor norm of a product of reflections), **Layer 5** (the primitivity
dictionary, the K3-lattice existence shape), **Layer 6** (indefinite even unimodular
uniqueness), **Layer 8** (theta convergence at both levels, the restriction of the
holomorphic theta to the imaginary axis, and the transformation law through the
interface) and **Layer 9** (`StoredGenusCertificate`, the object a stored LMFDB lattice
record asserts). They elaborate against the Mathlib version this repository builds
against, and they are stated with `sorry`, which is allowed in this human-owned roadmap
library.

The statements whose types do not exist yet stay in `README.md` only. They are the
Conway–Sloane genus symbols of Layer 3, the adelic double cosets of Layer 4, and the mass
formula of Layer 7. Nothing here stands in for them, since a `Prop`-valued placeholder
would assert nothing. Layer 9 is different: genus membership and isometry are congruence of
Gram matrices over `ℤ_p` and over `ℤ`, which are expressible now, so the certificate is
written out rather than described.

Conventions follow `README.md`: a lattice is a finite free ℤ-module with a symmetric
`LinearMap.BilinForm ℤ L`; the Gram matrix is `LinearMap.BilinForm.toMatrix`; "norm" means
`β x x`; even lattices correspond to `QuadraticForm ℤ L` through `polarBilin` (never
through `associated`, which needs `Invertible (2 : ℤ)`); localization is
`LinearMap.BilinForm.baseChange`, which, unlike `QuadraticForm.baseChange`, is free of
2-invertibility. Statements about bounded norms, minima, reduction and theta series are
stated for **positive** definite lattices, since they are false for negative definite ones;
statements invariant under `β ⇝ −β`, such as finiteness of the automorphism group, are
stated once and extended by that substitution.
-/

namespace TauCetiRoadmap.IntegralLattices

open QuadraticMap MeasureTheory
open scoped Real

universe u v

/-! ## The pinned carriers -/

/-- **The lattice form.** A lattice is a finite free ℤ-module carrying a symmetric integral
bilinear form. The form and its symmetry are bundled; the module hypotheses stay ordinary
typeclasses on the declarations that need them, and this is a structure rather than a class
because one module carries many forms. -/
structure IntegralLatticeForm (L : Type u) [AddCommGroup L] [Module ℤ L] where
  /-- The symmetric integral bilinear form. -/
  form : LinearMap.BilinForm ℤ L
  /-- Symmetry of the form. -/
  isSymm : form.IsSymm

/-- `ℚ/ℤ`, the target of a discriminant bilinear form. -/
abbrev QModOne := AddCircle (1 : ℚ)

/-- `ℚ/2ℤ`, the target of a discriminant quadratic form. Nikulin's convention (§1, point
3°); it is the `2ℤ` that lets `q_L` remember that `L` is even. -/
abbrev QModTwo := AddCircle (2 : ℚ)

/-- **The halving map** `ℚ/2ℤ → ℚ/ℤ`, `[r] ↦ [r/2]`, which is what polarizes a discriminant
quadratic form into a discriminant bilinear form. It is Mathlib's rescaling isomorphism of
circle groups, and `AddCircle.equivAddCircle_apply_mk` computes it as `x ↦ x * (2⁻¹ * 1)`.
Naming it once here keeps the factor of 2 in a single place. -/
noncomputable def half : QModTwo ≃+ QModOne :=
  AddCircle.equivAddCircle (2 : ℚ) (1 : ℚ) (by norm_num) (by norm_num)

/-- **A finite quadratic form** in Nikulin's sense: a `ℚ/2ℤ`-valued quadratic function on a
finite abelian group whose polarization is biadditive. Discriminant forms of even lattices
are the examples (Layer 1), and the existence and uniqueness theorems of Layer 5 quantify
over these. -/
structure FiniteQuadraticForm (A : Type u) [AddCommGroup A] [Finite A] where
  /-- The underlying function. -/
  toFun : A → QModTwo
  /-- Homogeneity of degree two. -/
  map_zsmul : ∀ (n : ℤ) (a : A), toFun (n • a) = (n * n : ℤ) • toFun a
  /-- Additivity of the polarization in its first variable; symmetry gives the second. -/
  polar_add_left : ∀ x y z : A,
    half (toFun (x + y + z) - toFun (x + y) - toFun z)
      = half (toFun (x + z) - toFun x - toFun z) + half (toFun (y + z) - toFun y - toFun z)

/-- **The polar bilinear form** `b(x, y) = ½(q(x+y) − q(x) − q(y)) ∈ ℚ/ℤ` of a finite
quadratic form. -/
noncomputable def FiniteQuadraticForm.polar {A : Type u} [AddCommGroup A] [Finite A]
    (q : FiniteQuadraticForm A) (x y : A) : QModOne :=
  half (q.toFun (x + y) - q.toFun x - q.toFun y)

/-- **Nondegeneracy** of a finite quadratic form: the polar pairing separates points. On a
finite group this is equivalent to the adjoint `A → (A →+ ℚ/ℤ)` being an isomorphism, which
is the form Layer 1 proves and uses; Mathlib's `GroupTheory/FiniteAbelian/Duality` states
the corresponding duality multiplicatively, and relating the two is part of that
milestone. -/
def FiniteQuadraticForm.Nondegenerate {A : Type u} [AddCommGroup A] [Finite A]
    (q : FiniteQuadraticForm A) : Prop :=
  ∀ x : A, (∀ y : A, q.polar x y = 0) → x = 0

/-! ## Interfaces to the supplier roadmaps

Three roadmaps supply objects that this one consumes, and their declarations do not exist
yet: Orthogonal and Spin Groups for the spinor norm, Global Class Field Theory for the
Hilbert product formula, and L-functions for the analytic theta. Each interface below is a
structure whose fields are the exact objects and equations consumed, in the supplier's own
spelling, with the supplier's hypotheses.

An interface must not admit a model that has nothing to do with the intended mathematics, or
a theorem quantified over it proves nothing. Each structure therefore pins its fields: the
orthogonal group by its members, the reflection by its formula, the Hilbert symbols by the
equations they decide, and the analytic lattice by discreteness together with `IsZLattice`.
Replacing an interface with the supplier's declarations means building one term of the
structure, and no consumer statement changes. -/

/-- Square classes, in the spelling of Quadratic Form Invariants Layer 0 and of Orthogonal
and Spin Groups Layer 1. -/
abbrev SquareClass (K : Type u) [Field K] : Type u := Kˣ ⧸ Subgroup.square Kˣ

/-- The unit-to-square-class homomorphism of the same suppliers. -/
def squareClassOfUnit (K : Type u) [Field K] : Kˣ →* SquareClass K :=
  QuotientGroup.mk' _

/-- **What milestone 4C consumes from Orthogonal and Spin Groups, Layers 1 and 2.** The
hypotheses are the supplier's: `2` is invertible, `V` is finite-dimensional, and `Q` is
nondegenerate. The reflection formula is the one the supplier proves, with the same argument
order, so that replacing this structure is a substitution and not a transport.

Milestone 4C computes the images `θ_p(K_p⁺(L))` of the stabilizers of `L_p`. The reflection
formula is what makes that computation possible from the Jordan data of Layer 3, so it is a
field here rather than a consequence left to the reader. The fields determine `spinorNorm`,
because reflections generate the orthogonal group by Cartan–Dieudonné, so a theorem
quantified over this structure is a theorem about the supplier's spinor norm. -/
structure SpinorNormInterface (K : Type u) (V : Type v) [Field K] [Invertible (2 : K)]
    [AddCommGroup V] [Module K V] [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) where
  /-- The orthogonal group of `Q`, inside the linear automorphisms of `V`. -/
  orthogonalGroup : Subgroup (V ≃ₗ[K] V)
  /-- Its elements are exactly the isometries of `Q`. -/
  mem_orthogonalGroup : ∀ f : V ≃ₗ[K] V, f ∈ orthogonalGroup ↔ ∀ x, Q (f x) = Q x
  /-- The reflection in an anisotropic vector. -/
  reflection : ∀ {v : V}, Q v ≠ 0 → V ≃ₗ[K] V
  /-- Its formula, in the supplier's argument order. -/
  reflection_apply : ∀ {v : V} (hv : Q v ≠ 0) (x : V),
    reflection hv x = x - (Q v)⁻¹ • QuadraticMap.polar Q x v • v
  /-- A reflection is an isometry. -/
  reflection_mem : ∀ {v : V} (hv : Q v ≠ 0), reflection hv ∈ orthogonalGroup
  /-- The spinor norm. -/
  spinorNorm : orthogonalGroup →* SquareClass K
  /-- Its value on a reflection is the square class of the norm. -/
  spinorNorm_reflection : ∀ {v : V} (hv : Q v ≠ 0) (u : Kˣ), (u : K) = Q v →
    spinorNorm ⟨reflection hv, reflection_mem hv⟩ = squareClassOfUnit K u

/-- Primes carry the primality instance that `ℚ_[p]` needs. -/
local instance factPrimeOfPrimes (p : Nat.Primes) : Fact (p : ℕ).Prime := ⟨p.2⟩

/-- **What milestone 3G consumes from Global Class Field Theory, Layer 11.** The Hilbert
symbols of `ℚ` at the finite places and at the real place, and the product formula.

The two `iff` fields are what make the interface canonical: they say that a symbol is
trivial exactly when the corresponding conic has a rational point over that completion, which
determines the symbol. Without them the constant map to `1` would satisfy the product formula
and prove nothing. Inputs are units, so no argument is junk. -/
structure HilbertSymbolInterface where
  /-- The symbol at a finite place. -/
  symbol : Nat.Primes → ℚˣ → ℚˣ → ℤˣ
  /-- The symbol at the real place. -/
  symbolReal : ℚˣ → ℚˣ → ℤˣ
  /-- The finite symbol decides solvability over `ℚ_[p]`. -/
  symbol_eq_one_iff : ∀ (p : Nat.Primes) (a b : ℚˣ),
    symbol p a b = 1 ↔
      ∃ x y : ℚ_[(p : ℕ)], ((a : ℚ) : ℚ_[(p : ℕ)]) * x ^ 2 + ((b : ℚ) : ℚ_[(p : ℕ)]) * y ^ 2 = 1
  /-- The real symbol decides solvability over `ℝ`. -/
  symbolReal_eq_one_iff : ∀ a b : ℚˣ,
    symbolReal a b = 1 ↔ ∃ x y : ℝ, ((a : ℚ) : ℝ) * x ^ 2 + ((b : ℚ) : ℝ) * y ^ 2 = 1
  /-- All but finitely many finite symbols are trivial. -/
  symbol_ne_one_finite : ∀ a b : ℚˣ, {p : Nat.Primes | symbol p a b ≠ 1}.Finite
  /-- The product formula. -/
  productFormula : ∀ (a b : ℚˣ) (S : Finset Nat.Primes),
    (∀ p, symbol p a b ≠ 1 → p ∈ S) → symbolReal a b * ∏ p ∈ S, symbol p a b = 1

/-- A lattice in Euclidean space, bundled with the two facts that make its covolume and its
theta series meaningful. The theorems of L-functions Layer 2 hold for this carrier and not
for an arbitrary submodule: the zero submodule has no finite inverse covolume. -/
structure AnalyticLattice (n : ℕ) where
  /-- The underlying submodule. -/
  toSubmodule : Submodule ℤ (EuclideanSpace ℝ (Fin n))
  /-- It is discrete. -/
  [discrete : DiscreteTopology toSubmodule]
  /-- It spans the ambient space over `ℝ`. -/
  isZLattice : IsZLattice ℝ toSubmodule

attribute [instance] AnalyticLattice.discrete AnalyticLattice.isZLattice

/-- The covolume of a bundled analytic lattice. -/
noncomputable def AnalyticLattice.covolume {n : ℕ} (Λ : AnalyticLattice n) : ℝ :=
  ZLattice.covolume Λ.toSubmodule

/-- The Gaussian theta of a bundled analytic lattice, at a real parameter. -/
noncomputable def AnalyticLattice.realTheta {n : ℕ} (Λ : AnalyticLattice n) (t : ℝ) : ℝ :=
  ∑' x : Λ.toSubmodule, Real.exp (-π * t * ‖(x : EuclideanSpace ℝ (Fin n))‖ ^ 2)

/-- The holomorphic theta of a bundled analytic lattice, on the upper half-plane. Milestone
8A defines the arithmetic theta of a positive definite integral lattice as this function of
its realization, and 8E states the transformation law here. -/
noncomputable def AnalyticLattice.theta {n : ℕ} (Λ : AnalyticLattice n) (τ : ℂ) : ℂ :=
  ∑' x : Λ.toSubmodule,
    Complex.exp ((π : ℂ) * Complex.I * τ * ((‖(x : EuclideanSpace ℝ (Fin n))‖ ^ 2 : ℝ) : ℂ))

/-- **What milestones 8D and 8E consume from L-functions, Layer 2.** The dual of a bundled
analytic lattice, biduality, the product of the two covolumes, and the Gaussian
transformation at a real parameter. These are the four rows of the shared table in
`README.md`. Poisson summation is an L-functions target and is not consumed here.

The arithmetic content is this roadmap's: the dual is the dual lattice of 1B, the covolume
is `Real.sqrt (det L)`, and the identity extends from `t > 0` to the upper half-plane. -/
structure GaussianThetaInterface (n : ℕ) where
  /-- The analytic dual lattice. -/
  dual : AnalyticLattice n → AnalyticLattice n
  /-- The dual is characterized by integrality of the inner products, so this field is
  determined by the others and not merely constrained by them. -/
  mem_dual : ∀ (Λ : AnalyticLattice n) (x : EuclideanSpace ℝ (Fin n)),
    x ∈ (dual Λ).toSubmodule ↔ ∀ y ∈ Λ.toSubmodule, ∃ m : ℤ, inner ℝ x y = (m : ℝ)
  /-- Biduality. -/
  dual_dual : ∀ Λ, dual (dual Λ) = Λ
  /-- The covolumes are inverse to each other. -/
  covolume_mul_covolume_dual : ∀ Λ : AnalyticLattice n, Λ.covolume * (dual Λ).covolume = 1
  /-- The Gaussian theta transformation, at a real parameter. -/
  gaussianTheta_one_div : ∀ (Λ : AnalyticLattice n) (t : ℝ), 0 < t →
    Λ.realTheta (1 / t) = t ^ ((n : ℝ) / 2) * Λ.covolume⁻¹ * (dual Λ).realTheta t

section Layer0

variable {L : Type u} [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]

/-! ## Layer 0: lattices, the bilinear/quadratic dictionary, Gram determinants -/

/-- **Layer 0, the even-to-quadratic dictionary.** An even symmetric integral bilinear
form is the polar form of a unique integral quadratic form (its values are the
half-norms `β x x / 2`). This is the factor-of-2 bookkeeping done once and for all:
the quadratic form is produced from the companion structure of `QuadraticMap`, never
from `QuadraticMap.associated`, which would demand `Invertible (2 : ℤ)`. -/
example (β : LinearMap.BilinForm ℤ L) (hs : β.IsSymm) (he : ∀ x, 2 ∣ β x x) :
    ∃! Q : QuadraticForm ℤ L, Q.polarBilin = β :=
  sorry

/-- **Layer 0, the quadratic-to-even dictionary.** The polar form of any integral
quadratic form is symmetric and even (`polarBilin Q x x = 2 * Q x`). Together with the
previous target this makes even lattices and integral quadratic forms interchangeable. -/
example (Q : QuadraticForm ℤ L) :
    Q.polarBilin.IsSymm ∧ ∀ x, 2 ∣ Q.polarBilin x x :=
  sorry

/-- **Layer 0, the determinant is well-defined on the nose.** Over ℤ a change of basis
has determinant `±1`, so Gram determinants agree exactly (not merely up to squares, as
over a field). `det L` is then a genuine ℤ-valued invariant of the lattice. -/
example {ι ι' : Type} [Fintype ι] [DecidableEq ι] [Fintype ι'] [DecidableEq ι']
    (β : LinearMap.BilinForm ℤ L) (b : Module.Basis ι ℤ L) (b' : Module.Basis ι' ℤ L) :
    (LinearMap.BilinForm.toMatrix b β).det = (LinearMap.BilinForm.toMatrix b' β).det :=
  sorry

/-- **Layer 0, worked example: E₈.** The E₈ Cartan matrix is the Gram matrix of the
`E₈` lattice: symmetric, even, unimodular. Its determinant is `1`. -/
example : CartanMatrix.E₈.det = 1 :=
  sorry

/-- **Layer 0, worked example: E₈ is even and symmetric** (decidable checks). -/
example : CartanMatrix.E₈.IsSymm ∧ ∀ i, 2 ∣ CartanMatrix.E₈ i i :=
  sorry

/-- **Layer 0, worked example: E₈ is positive definite.** Stated over ℤ directly:
`Matrix.toQuadraticForm'` and `QuadraticMap.PosDef` are `Invertible 2`-free. -/
example : (Matrix.toQuadraticForm' CartanMatrix.E₈).PosDef :=
  sorry

/-- **Layer 0, worked example: the Aₙ root-lattice determinants.** The type-`A` Cartan
matrix (the Gram matrix of the root lattice `Aₙ`) has determinant `n + 1`; its
discriminant group is cyclic of that order (Layer 1). -/
example (n : ℕ) : (CartanMatrix.A n).det = n + 1 :=
  sorry

/-- **Layer 0, worked example: the hyperbolic plane U.** Gram matrix `!![0,1;1,0]`:
even, unimodular, of signature `(1,1)`, determinant `−1`. -/
example : (!![0, 1; 1, 0] : Matrix (Fin 2) (Fin 2) ℤ).det = -1 :=
  sorry

/-- **Layer 0, positive twists stay positive definite.** `L(a)` is the same module with the
form `a • β`. Positive definiteness is preserved exactly for `a > 0`, which is why the
theta scaling law and the twist statements about masses in Layer 7 carry that hypothesis:
for `a < 0` the twist lands in the negative definite category, and for `a = 0` it is
degenerate. -/
example (β : LinearMap.BilinForm ℤ L) (hpos : (LinearMap.BilinMap.toQuadraticMap β).PosDef)
    {a : ℤ} (ha : 0 < a) :
    (LinearMap.BilinMap.toQuadraticMap (a • β)).PosDef :=
  sorry

end Layer0

section Layer1

/-! ## Layer 1: dual lattices, discriminant groups, overlattices, signature mod 8 -/

variable {ι : Type} [Fintype ι] [DecidableEq ι]
variable {V : Type v} [AddCommGroup V] [Module ℚ V]

/-- **Layer 1, integrality places a lattice inside its dual.** For a lattice realized
as the ℤ-span of a ℚ-basis with integral Gram matrix, `L ≤ L^⋆` where
`L^⋆ = LinearMap.BilinForm.dualSubmodule B L` is Mathlib's dual submodule. -/
example (B : LinearMap.BilinForm ℚ V) (b : Module.Basis ι ℚ V)
    (hint : ∀ i j, B (b i) (b j) ∈ (1 : Submodule ℤ ℚ)) :
    Submodule.span ℤ (Set.range b) ≤ B.dualSubmodule (Submodule.span ℤ (Set.range b)) :=
  sorry

/-- **Layer 1, the discriminant-group cardinality.** The index of a lattice in its dual
is the absolute value of the Gram determinant: `#A_L = |det L|`. The engine is
Mathlib's `AddSubgroup.relIndex_eq_abs_det` combined with
`LinearMap.BilinForm.dualSubmodule_span_of_basis` (the dual lattice is spanned by the
`B`-dual basis). -/
example (B : LinearMap.BilinForm ℚ V) (hB : B.Nondegenerate) (hs : B.IsSymm)
    (b : Module.Basis ι ℚ V) (hint : ∀ i j, B (b i) (b j) ∈ (1 : Submodule ℤ ℚ)) :
    ((Submodule.span ℤ (Set.range b)).toAddSubgroup.relIndex
        (B.dualSubmodule (Submodule.span ℤ (Set.range b))).toAddSubgroup : ℚ)
      = |(LinearMap.BilinForm.toMatrix b B).det| :=
  sorry

/-- **Layer 1, unimodular means self-dual.** A lattice with integral Gram matrix has
Gram determinant `±1` if and only if it equals its dual lattice. -/
example (B : LinearMap.BilinForm ℚ V) (hB : B.Nondegenerate) (hs : B.IsSymm)
    (b : Module.Basis ι ℚ V) (hint : ∀ i j, B (b i) (b j) ∈ (1 : Submodule ℤ ℚ)) :
    ((LinearMap.BilinForm.toMatrix b B).det = 1 ∨ (LinearMap.BilinForm.toMatrix b B).det = -1)
      ↔ B.dualSubmodule (Submodule.span ℤ (Set.range b)) = Submodule.span ℤ (Set.range b) :=
  sorry

/-- **Layer 1, worked example: the discriminant group of A₂ has order 3.** The Gram
matrix `!![2,−1;−1,2]` has determinant `3`; the dual quotient has 3 elements. (The
finer statement — `A_{A₂} ≅ ℤ/3` with discriminant form `q = 2/3 ∈ ℚ/2ℤ` — needs the
Layer-1 discriminant-form API and is stated in prose in `README.md`.) -/
example :
    (Submodule.span ℤ (Set.range (Pi.basisFun ℚ (Fin 2)))).toAddSubgroup.relIndex
        ((Matrix.toBilin' ((!![2, -1; -1, 2] : Matrix (Fin 2) (Fin 2) ℤ).map
          (Int.cast : ℤ → ℚ))).dualSubmodule
            (Submodule.span ℤ (Set.range (Pi.basisFun ℚ (Fin 2))))).toAddSubgroup = 3 :=
  sorry

/-- **Layer 1, integral and even overlattices are governed by different conditions.**
Integral overlattices of a nondegenerate integral lattice correspond to subgroups of `A_L`
on which the discriminant *bilinear* form `b_L` vanishes; even overlattices of an even
lattice correspond to subgroups on which the discriminant *quadratic* form `q_L` vanishes.
The second condition is strictly stronger, and this example is the smallest witness: the
even lattice `A₁ ⊕ A₁` with Gram `!![2,0;0,2]` has the glue vector `(e₁+e₂)/2`, which is
isotropic for `b_L` but has `q_L = 1 ≠ 0` in `ℚ/2ℤ`, so it generates an index-2 integral
overlattice with Gram `!![1,1;1,2]`, which is odd (and in fact unimodular). Conflating the
two correspondences would make this overlattice disappear. -/
example : ∃ P : Matrix (Fin 2) (Fin 2) ℚ,
    |P.det| = 1 / 2 ∧
      P.transpose * (!![2, 0; 0, 2] : Matrix (Fin 2) (Fin 2) ℚ) * P = !![1, 1; 1, 2] :=
  sorry

/-- **Layer 1, even unimodular lattices have signature ≡ 0 mod 8.**
Stated through the Gram matrix and the real signature (Mathlib's `sigPos`/`sigNeg`
of the base-changed form — root-namespace names at this pin). The pinned route is through
the discriminant-form signature: the Gauss-sum invariant of a finite quadratic form, and
Milgram's theorem `t₊ − t₋ ≡ sign q_L (mod 8)` (Nikulin Theorem 1.3.3). For unimodular `L`
the discriminant group is trivial, so the right-hand side is `0`. Serre's *A Course in
Arithmetic* V.2 Theorem 2 with its Corollary 1 is the classical statement. -/
example {n : ℕ} (G : Matrix (Fin n) (Fin n) ℤ) (hs : G.IsSymm) (he : ∀ i, 2 ∣ G i i)
    (hu : G.det = 1 ∨ G.det = -1) :
    (8 : ℤ) ∣ (sigPos (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) : ℤ)
      - (sigNeg (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) : ℤ) :=
  sorry

end Layer1

section Layer2

/-! ## Layer 2: positive definite lattices — automorphisms, reduction, covolume -/

variable {L : Type u} [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]

/-- **Layer 2, bounded-norm sets are finite.** For a positive definite lattice, only
finitely many vectors have norm at most `C`. This is what makes minima, shells, kissing
numbers and theta coefficients well defined, and it is **false** for negative definite
lattices, where `β x x` is unbounded below; the negative definite statements are obtained
by applying this one to `−β`. -/
example (β : LinearMap.BilinForm ℤ L) (hpos : (LinearMap.BilinMap.toQuadraticMap β).PosDef)
    (C : ℤ) :
    {x : L | β x x ≤ C}.Finite :=
  sorry

/-- **Layer 2, automorphism groups of definite lattices are finite.** The isometry
group embeds into the permutations of a finite generating set of bounded-norm vectors
(equivalently: discrete ∩ compact in `O(n,ℝ)` after realization). This statement is
invariant under `β ⇝ −β`, so it is proved for positive definite lattices and then holds for
definite ones. Indefinite lattices have infinite isometry groups in rank ≥ 3 (and in rank 2
exactly in the anisotropic Pell case) — hence the definiteness hypothesis. -/
example (β : LinearMap.BilinForm ℤ L) (hpos : (LinearMap.BilinMap.toQuadraticMap β).PosDef) :
    Finite {e : L ≃ₗ[ℤ] L // ∀ x y, β (e x) (e y) = β x y} :=
  sorry

/-- **Layer 2/7, worked example: `|O(E₈)| = 696729600`.** The isometry group of the
`E₈` lattice is the Weyl group `W(E₈)` (reflections in the 240 roots generate, and
`−1 ∈ W(E₈)`), of order `696729600 = 2¹⁴·3⁵·5²·7`. This is the number the mass
formula divides by: the mass of the rank-8 even unimodular genus is `1/696729600`. -/
example : Nat.card {e : (Fin 8 → ℤ) ≃ₗ[ℤ] (Fin 8 → ℤ) //
      ∀ x y, Matrix.toBilin' CartanMatrix.E₈ (e x) (e y)
        = Matrix.toBilin' CartanMatrix.E₈ x y} = 696729600 :=
  sorry

/-- **Layer 2, reduction-theory finiteness.** There are finitely many positive
definite integral lattices of given rank and determinant up to isometry: every class
contains a (Minkowski-)reduced Gram matrix, and reduced Gram matrices of bounded
determinant have bounded entries. This is the definite half of class-number
finiteness (O'Meara 103:4 is the general statement). -/
example (n : ℕ) (d : ℤ) :
    ∃ S : Finset (Matrix (Fin n) (Fin n) ℤ), ∀ G : Matrix (Fin n) (Fin n) ℤ,
      G.IsSymm → (Matrix.toQuadraticForm' G).PosDef → G.det = d →
        ∃ H ∈ S, (Matrix.toBilin' G).Equivalent (Matrix.toBilin' H) :=
  sorry

/-- **Layer 2, the covolume identity.** For a lattice realized in Euclidean space, the
square of the `ZLattice` covolume is the Gram determinant of the dot-product form:
`covolume(L)² = det L`. This reconciles the analytic `ZLattice` covolume (consumed
for Minkowski-type bounds and by Layer 8) with the algebraic determinant, and is where the
`√det`-versus-`det` bookkeeping is fixed once. -/
example {ι : Type} [Fintype ι] [DecidableEq ι] (b : Module.Basis ι ℝ (ι → ℝ)) :
    ZLattice.covolume (Submodule.span ℤ (Set.range b)) ^ 2
      = |(LinearMap.BilinForm.toMatrix b (Matrix.toBilin' 1)).det| :=
  sorry

end Layer2

section Layer3

/-! ## Layer 3: localization and Jordan splittings -/

/-- **Layer 3, odd-`p` orthogonal splitting.** Over `ℤ_p` with `p ≠ 2` every symmetric
bilinear form on a finite free module admits an orthogonal basis; grouping by scale
gives the Jordan splitting (O'Meara §91C; uniqueness of the invariants is 91:9 and
the non-dyadic classification 92:2). The localized form of an integral lattice is
`LinearMap.BilinForm.baseChange ℤ_[p] β` — which, unlike `QuadraticForm.baseChange`,
needs no `Invertible 2` and hence also works at `p = 2`. -/
example {p : ℕ} [Fact p.Prime] (hp : p ≠ 2) {M : Type u} [AddCommGroup M] [Module ℤ_[p] M]
    [Module.Free ℤ_[p] M] [Module.Finite ℤ_[p] M]
    (β : LinearMap.BilinForm ℤ_[p] M) (hs : β.IsSymm) :
    ∃ (ι : Type) (_ : Fintype ι) (b : Module.Basis ι ℤ_[p] M), β.iIsOrtho b :=
  sorry

/-- **Layer 3, the dyadic trap, as a theorem.** Over `ℤ_2` orthogonal splitting fails:
the hyperbolic plane `U` is *not* diagonalizable (its unimodular even structure
survives 2-adically). Diagonal invariants do not exist at `p = 2`; the dyadic theory
runs on Jordan splittings with non-unique invariants and on the Conway–Sloane 2-adic
symbol calculus (README Layer 3). -/
example : ¬ ∃ b : Module.Basis (Fin 2) ℤ_[2] (Fin 2 → ℤ_[2]),
    (Matrix.toBilin' ((!![0, 1; 1, 0] : Matrix (Fin 2) (Fin 2) ℤ).map
      (Int.cast : ℤ → ℤ_[2]))).iIsOrtho b :=
  sorry

/-- **Layer 3G, the constraint on genus symbols, through the interface.** The product
formula determines the symbol at the real place from the finite ones. The oddity formula
and the sign-product conditions are the specialization of this identity to the symbols of a
genus. -/
example (I : HilbertSymbolInterface) (a b : ℚˣ) (S : Finset Nat.Primes)
    (hS : ∀ p, I.symbol p a b ≠ 1 → p ∈ S) :
    I.symbolReal a b = (∏ p ∈ S, I.symbol p a b)⁻¹ :=
  sorry

end Layer3

section Layer4

/-! ## Layer 4: the spinor norm of a lattice stabilizer -/

variable {K : Type u} [Field K] [Invertible (2 : K)]
variable {V : Type v} [AddCommGroup V] [Module K V] [FiniteDimensional K V]

/-- **Layer 4C, through the interface.** The spinor norm is a homomorphism, so its value on
a product of two reflections is the product of the square classes of the two norms. Layer 4C
applies this to reflections that generate the stabilizer `K_p⁺(L)`, over `K = ℚ_p`, and reads
the answer off the Jordan data of Layer 3. -/
example (Q : QuadraticForm K V) (hQ : Q.Nondegenerate) (I : SpinorNormInterface K V Q hQ)
    {v w : V} (hv : Q v ≠ 0) (hw : Q w ≠ 0) (u u' : Kˣ)
    (hu : (u : K) = Q v) (hu' : (u' : K) = Q w) :
    I.spinorNorm (⟨I.reflection hv, I.reflection_mem hv⟩ *
        ⟨I.reflection hw, I.reflection_mem hw⟩)
      = squareClassOfUnit K (u * u') :=
  sorry

end Layer4

section Layer5

/-! ## Layer 5: primitive embeddings (the entry point to Nikulin's theory) -/

variable {L M : Type u}
variable [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]
variable [AddCommGroup M] [Module ℤ M] [Module.Free ℤ M] [Module.Finite ℤ M]

/-- **Layer 5, the primitivity dictionary.** An embedding of finite free ℤ-modules is
*primitive* when its cokernel is torsion-free; over ℤ this is equivalent to the image
being a direct summand. Every statement of Nikulin's embedding theory quantifies over
primitive embeddings, so this dictionary is stated first. -/
example (f : L →ₗ[ℤ] M) (hf : Function.Injective f) :
    (∀ x : M ⧸ LinearMap.range f, ∀ n : ℤ, n ≠ 0 → n • x = 0 → x = 0)
      ↔ ∃ N : Submodule ℤ M, IsCompl (LinearMap.range f) N :=
  sorry

/-- **Layer 5/6, worked example: the K3 lattice exists.** There is an even unimodular
lattice of signature `(3, 19)` — concretely `U³ ⊕ E₈(−1)²`, the Gram matrix being the
block sum of three hyperbolic planes and two negated `E₈` matrices, of determinant
`−1`. Uniqueness is the indefinite even unimodular classification (Layer 6). -/
example : ∃ G : Matrix (Fin 22) (Fin 22) ℤ, G.IsSymm ∧ (∀ i, 2 ∣ G i i) ∧ G.det = -1 ∧
    sigPos (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) = 3 ∧
    sigNeg (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) = 19 :=
  sorry

end Layer5

section Layer6

/-! ## Layer 6: unimodular lattices in low rank -/

/-- **Layer 6, indefinite even unimodular uniqueness (shape).** Two even unimodular
integral lattices that are indefinite with equal signatures are isometric
(`II_{t₊,t₋} ≅ U^{min(t₊,t₋)} ⊕ E₈(±1)^{|t₊−t₋|/8}`; Serre V.2.2, Milnor–Husemoller
II §5; via Nikulin Corollary 1.13.3 in the discriminant-form route). The definite
analogue is false from rank 16 on (`E₈²` vs `D₁₆⁺`). -/
example {n : ℕ} (G₁ G₂ : Matrix (Fin n) (Fin n) ℤ)
    (h₁s : G₁.IsSymm) (h₂s : G₂.IsSymm)
    (h₁e : ∀ i, 2 ∣ G₁ i i) (h₂e : ∀ i, 2 ∣ G₂ i i)
    (h₁u : G₁.det = 1 ∨ G₁.det = -1) (h₂u : G₂.det = 1 ∨ G₂.det = -1)
    (hp : sigPos (Matrix.toQuadraticForm' (G₁.map (Int.cast : ℤ → ℝ)))
        = sigPos (Matrix.toQuadraticForm' (G₂.map (Int.cast : ℤ → ℝ))))
    (hn : sigNeg (Matrix.toQuadraticForm' (G₁.map (Int.cast : ℤ → ℝ)))
        = sigNeg (Matrix.toQuadraticForm' (G₂.map (Int.cast : ℤ → ℝ))))
    (hindef : 0 < sigPos (Matrix.toQuadraticForm' (G₁.map (Int.cast : ℤ → ℝ))) ∧
        0 < sigNeg (Matrix.toQuadraticForm' (G₁.map (Int.cast : ℤ → ℝ)))) :
    (Matrix.toBilin' G₁).Equivalent (Matrix.toBilin' G₂) :=
  sorry

end Layer6

section Layer8

/-! ## Layer 8: theta series, at both levels -/

variable {L : Type u} [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]

/-- **Layer 8A, the analytic level.** The theta of a bundled analytic lattice needs no
integrality, which is why it also applies to the dual lattice `L^⋆`, whose form is
rational-valued. The arithmetic theta of an integral lattice is this function of its
realization, and not a separate construction. -/
example {n : ℕ} (Λ : AnalyticLattice n) {t : ℝ} (ht : 0 < t) :
    Summable fun x : Λ.toSubmodule =>
      Real.exp (-π * t * ‖(x : EuclideanSpace ℝ (Fin n))‖ ^ 2) :=
  sorry

/-- **Layer 8A, the two thetas agree on the imaginary axis.** The holomorphic theta
restricted to `τ = it` is the Gaussian sum at `t`. This is the identity that lets 8E extend
the transformation law from the real parameter of the supplier to the upper half-plane. -/
example {n : ℕ} (Λ : AnalyticLattice n) {t : ℝ} (ht : 0 < t) :
    Λ.theta (t * Complex.I) = (Λ.realTheta t : ℂ) :=
  sorry

/-- **Layer 8B, holomorphy.** The theta series is holomorphic on the upper half-plane. With
the previous target this is what makes the continuation in 8E legitimate. -/
example {n : ℕ} (Λ : AnalyticLattice n) :
    DifferentiableOn ℂ Λ.theta {τ : ℂ | 0 < τ.im} :=
  sorry

/-- **Layer 8, the arithmetic wrapper: convergence.** For a positive definite integral
lattice the theta sum `∑_{x ∈ L} exp(−π t · β(x,x))` converges for every `t > 0` — the
summability behind `Θ_L(τ) = ∑ exp(πiτ·β(x,x))` on the upper half-plane. Mathlib's
`jacobiTheta` is exactly `Θ_ℤ` in this normalization (the rank-1 reconciliation is a worked
example in `README.md`). Positive definiteness is essential: for a negative definite form
every term with large `β x x` blows up. The transformation law is proved by consuming
LFunctions Layer 2's Gaussian theta transformation, identifying its analytic dual with the
dual lattice of Layer 1, rewriting the covolume as `Real.sqrt (det L)`, and continuing
analytically from `t > 0` to the upper half-plane; modular-form packaging has no supplier
and is outside this roadmap. -/
example (β : LinearMap.BilinForm ℤ L) (hpos : (LinearMap.BilinMap.toQuadraticMap β).PosDef)
    {t : ℝ} (ht : 0 < t) :
    Summable fun x : L => Real.exp (-π * t * ((β x x : ℤ) : ℝ)) :=
  sorry

/-- **Layer 8E, the arithmetic form of the transformation, through the interface.** Once the
covolume of the realization is `Real.sqrt (det L)`, which is 8D, the consumed identity takes
the shape this roadmap owns. -/
example {n : ℕ} (I : GaussianThetaInterface n) (Λ : AnalyticLattice n)
    (d : ℝ) (hd : 0 < d) (hcov : Λ.covolume = Real.sqrt d) {t : ℝ} (ht : 0 < t) :
    Λ.realTheta (1 / t)
      = t ^ ((n : ℝ) / 2) * (Real.sqrt d)⁻¹ * (I.dual Λ).realTheta t :=
  sorry

/-- **Layer 8E, on the upper half-plane.** The same identity for the holomorphic theta, with
the principal branch of `(τ/i)^{n/2}`, which is legitimate because `τ/i` has positive real
part there. This is the statement the roadmap owns, and it follows from the two previous
targets by the identity theorem. -/
example {n : ℕ} (I : GaussianThetaInterface n) (Λ : AnalyticLattice n)
    (d : ℝ) (hd : 0 < d) (hcov : Λ.covolume = Real.sqrt d) {τ : ℂ} (hτ : 0 < τ.im) :
    Λ.theta (-1 / τ)
      = (τ / Complex.I) ^ ((n : ℂ) / 2) * ((Real.sqrt d : ℝ) : ℂ)⁻¹ * (I.dual Λ).theta τ :=
  sorry

end Layer8

section Layer9

/-! ## Layer 9: what a stored LMFDB lattice record asserts -/

/-- **Isometry of lattices, at the level of Gram matrices** (2C): integral congruence by a
matrix invertible over `ℤ`. Over `ℤ` this is `det P = ±1`, so `IsUnit P.det` is the whole
condition; positive definiteness is not needed for the definition. -/
def GramIsometric {n : ℕ} (G H : Matrix (Fin n) (Fin n) ℤ) : Prop :=
  ∃ P : Matrix (Fin n) (Fin n) ℤ, IsUnit P.det ∧ P.transpose * G * P = H

/-- **Local isometry at `p`** (3A, 3F): congruence over `ℤ_p`. Writing it by base change of
the Gram matrix is what keeps `p = 2` in scope, exactly as in the convention that localizes
with `LinearMap.BilinForm.baseChange` rather than `QuadraticForm.baseChange`. -/
def GramIsometricAt (p : ℕ) [Fact p.Prime] {n : ℕ} (G H : Matrix (Fin n) (Fin n) ℤ) : Prop :=
  ∃ P : Matrix (Fin n) (Fin n) ℤ_[p], IsUnit P.det ∧
    P.transpose * G.map (Int.cast : ℤ → ℤ_[p]) * P = H.map (Int.cast : ℤ → ℤ_[p])

/-- **Layer 9A, the stored record as one object.** Each field is a statement an LMFDB
lattice record asserts, and nothing here is a placeholder: every condition is spelled out
in terms of the stored matrices, so no unintended model satisfies it. The label
`dim.det.level.class_number.index` contributes the four fields named after its components;
its fifth component is an insertion-order serial with no mathematical content and has no
field.

Genus membership is 3F written out: congruence over every `ℤ_p`, together with the real
signature, which positive definiteness of both sides supplies. Completeness is the last
field, and it is the statement that a mass certificate from 7H proves for a given genus; it
is not part of the definition of the other fields. -/
structure StoredGenusCertificate where
  /-- The label component `dim`, and the size of the stored Gram matrix. -/
  dim : ℕ
  /-- The stored lattices have positive rank, which is what makes the minimum and the
  kissing number of 2B defined. -/
  dim_pos : 0 < dim
  /-- The stored Gram matrix. -/
  gram : Matrix (Fin dim) (Fin dim) ℤ
  /-- It is symmetric, so it is the Gram matrix of a lattice form (0A, 0C). -/
  gram_isSymm : gram.IsSymm
  /-- It is positive definite, which is what makes 0A to 0E, 2B, 2C, 2G and 8B apply
  (0E). -/
  gram_posDef : (Matrix.toQuadraticForm' gram).PosDef
  /-- The label component `det`, the Gram determinant of 0C. -/
  det : ℤ
  /-- and it is that determinant. -/
  det_eq : det = gram.det
  /-- The label component `level`, in the shape 0D fixes it: the least positive `N` for
  which `N·G⁻¹` is integral with even diagonal. -/
  level : ℕ
  /-- and it is that least element. -/
  level_isLeast :
    IsLeast {N : ℕ | 0 < N ∧ ∃ M : Matrix (Fin dim) (Fin dim) ℤ, (∀ i, 2 ∣ M i i) ∧
      M.map (Int.cast : ℤ → ℚ) = (N : ℚ) • (gram.map (Int.cast : ℤ → ℚ))⁻¹} level
  /-- The stored minimum, `min L` of 2B: the least norm of a nonzero vector. -/
  minimum : ℤ
  /-- and it is that least element. -/
  minimum_isLeast :
    IsLeast {k : ℤ | ∃ x : Fin dim → ℤ, x ≠ 0 ∧ Matrix.toBilin' gram x x = k} minimum
  /-- The stored kissing number, `#S_{min L}(L)` of 2B. -/
  kissing : ℕ
  /-- and it counts the minimal shell. -/
  kissing_eq : kissing = Nat.card {x : Fin dim → ℤ // Matrix.toBilin' gram x x = minimum}
  /-- The stored automorphism group order, `|O(L)|` of 2C, at the level of Gram
  matrices. -/
  autOrder : ℕ
  /-- and it counts the integral congruences of `G` with itself. -/
  autOrder_eq :
    autOrder = Nat.card {P : Matrix (Fin dim) (Fin dim) ℤ // P.transpose * gram * P = gram}
  /-- The stored theta coefficients, `r_L(k) = #S_k(L)` of 2B, which are the coefficients
  of `Θ_L` in 8B. -/
  theta : ℕ → ℕ
  /-- and each one counts its shell. -/
  theta_eq :
    ∀ k : ℕ, theta k = Nat.card {x : Fin dim → ℤ // Matrix.toBilin' gram x x = (k : ℤ)}
  /-- The stored genus representatives. -/
  reps : List (Matrix (Fin dim) (Fin dim) ℤ)
  /-- Each one is the Gram matrix of a positive definite lattice. -/
  reps_posDef : ∀ H ∈ reps, H.IsSymm ∧ (Matrix.toQuadraticForm' H).PosDef
  /-- Each one lies in `gen L`, by 3F: congruent to `G` over every `ℤ_p`. -/
  reps_mem_genus : ∀ H ∈ reps, ∀ (p : ℕ) [Fact p.Prime], GramIsometricAt p gram H
  /-- They are pairwise non-isometric, which is a decidable check for positive definite
  lattices by 2G. -/
  reps_pairwise : reps.Pairwise fun H H' => ¬ GramIsometric H H'
  /-- They are complete: every positive definite lattice in the genus is isometric to a
  listed one. This is the field a mass certificate from 7H discharges. -/
  reps_complete : ∀ H : Matrix (Fin dim) (Fin dim) ℤ, H.IsSymm →
    (Matrix.toQuadraticForm' H).PosDef →
    (∀ (p : ℕ) [Fact p.Prime], GramIsometricAt p gram H) → ∃ H' ∈ reps, GramIsometric H' H
  /-- The label component `class_number`, the invariant of 4A, finite by 2G. -/
  classNumber : ℕ
  /-- and it is the length of the list. -/
  classNumber_eq : classNumber = reps.length

/-- **Layer 9A, what the certificate buys.** Completeness and pairwise non-isometry say
together that the stored list is a set of representatives on the nose: every positive
definite lattice in the genus is isometric to exactly one entry. This is the statement the
`class_number` column asserts, and it is why the two fields have to be separate. -/
example (c : StoredGenusCertificate) (H : Matrix (Fin c.dim) (Fin c.dim) ℤ)
    (hs : H.IsSymm) (hp : (Matrix.toQuadraticForm' H).PosDef)
    (hgen : ∀ (p : ℕ) [Fact p.Prime], GramIsometricAt p c.gram H) :
    ∃! H' : Matrix (Fin c.dim) (Fin c.dim) ℤ, H' ∈ c.reps ∧ GramIsometric H' H :=
  sorry

end Layer9

end TauCetiRoadmap.IntegralLattices
