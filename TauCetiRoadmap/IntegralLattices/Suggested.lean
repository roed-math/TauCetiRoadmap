import Mathlib

/-!
# Integral quadratic forms and lattices: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–8, the convention table, the worked examples and the
references) is in `README.md`. Mathlib has quadratic maps over semirings, symmetric
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
uniqueness) and **Layer 8** (theta convergence at both levels, and the transformation law
through the interface). They elaborate against the Mathlib version this repository builds
against, and they are stated with `sorry`, which is allowed in this human-owned roadmap
library.

The statements whose types do not exist yet stay in `README.md` only. They are the
Conway–Sloane genus symbols of Layer 3, the adelic double cosets of Layer 4, and the mass
formula of Layer 7. Nothing here stands in for them, since a `Prop`-valued placeholder
would assert nothing.

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

Three roadmaps supply objects that this one consumes: Quadratic Form Invariants, Global
Class Field Theory, and Orthogonal and Spin Groups, together with L-functions for the
analytic theta. Their declarations do not exist yet, so each interface is written here as a
structure whose fields are the exact objects and equations consumed. Every field is a real
statement, and no field is an opaque `Prop`.

Replacing an interface with the supplier's declarations is mechanical: build one term of
the structure from those declarations, and every consumer keeps its statement. The field
names follow the names the supplier roadmaps use. -/

/-- The square-class group `Kˣ/(Kˣ)²`, in the spelling the Quadratic Form Invariants and
Orthogonal and Spin Groups roadmaps use. -/
abbrev SquareClass (K : Type u) [Field K] : Type u := Kˣ ⧸ Subgroup.square Kˣ

/-- **What Layer 4C consumes from Orthogonal and Spin Groups, Layers 1 and 2.** The
orthogonal group of a quadratic space, the reflection in an anisotropic vector, and the
spinor norm with its value on a reflection. Layer 4C computes the images
`θ_p(K_p⁺(L))` of the stabilizers of `L_p`, and the reflection formula is what makes that
computation possible from the Jordan data of Layer 3. -/
structure SpinorNormInterface (K : Type u) (V : Type v) [Field K] [AddCommGroup V]
    [Module K V] (Q : QuadraticForm K V) where
  /-- The orthogonal group of `Q`, inside the linear automorphisms of `V`. -/
  orthogonalGroup : Subgroup (V ≃ₗ[K] V)
  /-- Its elements are exactly the isometries of `Q`. -/
  mem_orthogonalGroup : ∀ f : V ≃ₗ[K] V, f ∈ orthogonalGroup ↔ ∀ x, Q (f x) = Q x
  /-- The reflection in an anisotropic vector. -/
  reflection : ∀ v : V, Q v ≠ 0 → V ≃ₗ[K] V
  /-- Its formula, which is what a spinor-norm computation runs through. -/
  reflection_apply : ∀ (v : V) (hv : Q v ≠ 0) (x : V),
    reflection v hv x = x - ((Q v)⁻¹ * QuadraticMap.polar Q v x) • v
  /-- A reflection is an isometry. -/
  reflection_mem : ∀ (v : V) (hv : Q v ≠ 0), reflection v hv ∈ orthogonalGroup
  /-- The spinor norm. -/
  spinorNorm : orthogonalGroup →* SquareClass K
  /-- Its value on a reflection is the square class of the norm. -/
  spinorNorm_reflection : ∀ (v : V) (hv : Q v ≠ 0),
    spinorNorm ⟨reflection v hv, reflection_mem v hv⟩ = QuotientGroup.mk (Units.mk0 (Q v) hv)

/-- **What Layer 3G consumes from Global Class Field Theory, Layer 11.** The Hilbert symbols
of `ℚ` at the finite places and at the real place, and the product formula for them. Layer
3G proves the oddity formula and the sign-product conditions on genus symbols from this one
statement, and needs nothing else from that roadmap. The symbol is written additively, so
that the product formula becomes a sum. -/
structure HilbertSymbolInterface where
  /-- The symbol at a finite place. -/
  symbol : ℕ → ℚ → ℚ → ZMod 2
  /-- The symbol at the real place. -/
  symbolReal : ℚ → ℚ → ZMod 2
  /-- All but finitely many symbols vanish. -/
  symbol_eq_zero : ∀ a b : ℚ, a ≠ 0 → b ≠ 0 → {p : ℕ | symbol p a b ≠ 0}.Finite
  /-- The product formula. -/
  productFormula : ∀ (a b : ℚ), a ≠ 0 → b ≠ 0 → ∀ S : Finset ℕ,
    (∀ p, symbol p a b ≠ 0 → p ∈ S) → symbolReal a b + ∑ p ∈ S, symbol p a b = 0

/-- The analytic theta of a lattice in Euclidean space, with respect to the Euclidean norm.
It assumes no integrality, which is why it also applies to the dual lattice, whose form is
rational-valued. The general theory of this function is L-functions Layer 2's. -/
noncomputable def analyticTheta {n : ℕ} (Λ : Submodule ℤ (EuclideanSpace ℝ (Fin n)))
    (t : ℝ) : ℝ :=
  ∑' x : Λ, Real.exp (-π * t * ‖(x : EuclideanSpace ℝ (Fin n))‖ ^ 2)

/-- **What Layers 8D and 8E consume from L-functions, Layer 2.** The analytic dual lattice,
the product of the two covolumes, and the Gaussian theta transformation for a real
parameter. Layer 8 adds the arithmetic content: the analytic dual is the dual lattice of
1B, the covolume is `Real.sqrt (det L)`, and the identity extends from `t > 0` to the upper
half-plane. -/
structure GaussianThetaInterface (n : ℕ) where
  /-- The analytic dual lattice. -/
  dual : Submodule ℤ (EuclideanSpace ℝ (Fin n)) → Submodule ℤ (EuclideanSpace ℝ (Fin n))
  /-- Biduality. -/
  dual_dual : ∀ Λ, dual (dual Λ) = Λ
  /-- The covolumes are inverse to each other. -/
  covolume_mul_covolume_dual : ∀ Λ, ZLattice.covolume Λ * ZLattice.covolume (dual Λ) = 1
  /-- The Gaussian theta transformation, for a real parameter. -/
  theta_one_div : ∀ (Λ : Submodule ℤ (EuclideanSpace ℝ (Fin n))) (t : ℝ), 0 < t →
    analyticTheta Λ (1 / t)
      = t ^ ((n : ℝ) / 2) * (ZLattice.covolume Λ)⁻¹ * analyticTheta (dual Λ) t

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
example (I : HilbertSymbolInterface) (a b : ℚ) (ha : a ≠ 0) (hb : b ≠ 0) (S : Finset ℕ)
    (hS : ∀ p, I.symbol p a b ≠ 0 → p ∈ S) :
    I.symbolReal a b = - ∑ p ∈ S, I.symbol p a b :=
  sorry

end Layer3

section Layer4

/-! ## Layer 4: the spinor norm of a lattice stabilizer -/

variable {V : Type v} [AddCommGroup V] [Module ℚ V]

/-- **Layer 4C, through the interface.** The spinor norm is a homomorphism, so its value on
a product of reflections is the product of the square classes of the norms. Layer 4C applies
this to the reflections that generate the stabilizer `K_p⁺(L)`, and reads the answer off the
Jordan data of Layer 3. -/
example (Q : QuadraticForm ℚ V) (I : SpinorNormInterface ℚ V Q) (v w : V)
    (hv : Q v ≠ 0) (hw : Q w ≠ 0) :
    I.spinorNorm (⟨I.reflection v hv, I.reflection_mem v hv⟩ *
        ⟨I.reflection w hw, I.reflection_mem w hw⟩)
      = QuotientGroup.mk (Units.mk0 (Q v) hv * Units.mk0 (Q w) hw) :=
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

/-- **Layer 8, the analytic level.** The theta of a lattice in a real space needs a
positive definite *real* quadratic form and no integrality whatever: this is the shape of
the API supplied by LFunctions Layer 2, and it is why it also applies to the dual lattice
`L^⋆`, whose form is rational-valued rather than integral. The arithmetic theta of an
integral lattice is a wrapper around this, not a separate construction. -/
example {n : ℕ} (Λ : Submodule ℤ (EuclideanSpace ℝ (Fin n))) [DiscreteTopology Λ]
    [IsZLattice ℝ Λ] (Q : QuadraticForm ℝ (EuclideanSpace ℝ (Fin n))) (hQ : Q.PosDef)
    {t : ℝ} (ht : 0 < t) :
    Summable fun x : Λ => Real.exp (-π * t * Q (x : EuclideanSpace ℝ (Fin n))) :=
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
the shape this roadmap owns. The extension from `t > 0` to `τ` in the upper half-plane is
the second half of 8E, and it uses the branch fixed in `README.md`. -/
example {n : ℕ} (I : GaussianThetaInterface n) (Λ : Submodule ℤ (EuclideanSpace ℝ (Fin n)))
    (d : ℝ) (hd : 0 < d) (hcov : ZLattice.covolume Λ = Real.sqrt d) {t : ℝ} (ht : 0 < t) :
    analyticTheta Λ (1 / t)
      = t ^ ((n : ℝ) / 2) * (Real.sqrt d)⁻¹ * analyticTheta (I.dual Λ) t :=
  sorry

end Layer8

end TauCetiRoadmap.IntegralLattices
