import Mathlib

/-!
# Integral quadratic forms and lattices: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–8, the convention table, the worked examples, and the
references) is in `README.md`. Mathlib has quadratic maps over semirings, symmetric
bilinear forms with Gram matrices and base change, `ZLattice` covolumes, Smith normal
form with the index-equals-determinant theorems, and a dual-submodule construction —
but no integral-lattice arithmetic: no even/odd theory, no discriminant groups or
forms, no genus, no mass formula, no Nikulin embedding theory, no lattice theta
series. We build that in `TauCeti/`.

This file pins pin-expressible targets for **Layer 0** (the bilinear/quadratic
dictionary, Gram determinants, the standard examples), **Layer 1** (dual lattices,
the discriminant-group cardinality, unimodularity, the signature-mod-8 statement),
**Layer 2** (finiteness of automorphism groups and of definite classes, the covolume
bridge, `|O(E₈)| = 696729600`), **Layer 3** (odd-`p` orthogonal splitting and the
dyadic counterexample), **Layer 5** (the primitivity dictionary, the K3-lattice
existence shape), **Layer 6** (the indefinite even unimodular uniqueness shape), and
**Layer 8** (theta convergence). They elaborate against the pinned Mathlib and are
stated with `sorry` (allowed in this human-owned roadmap library). The layers whose
types are not yet pin-expressible — Conway–Sloane genus symbols, spinor genera, the
discriminant-form (`t₊`, `t₋`, `q`) calculus of the Nikulin layer, and the mass
formula — stay prose until the earlier layers make them expressible in `TauCeti/`,
at which point their milestones are added here with `sorry`.

Conventions follow `README.md`: a lattice is a finite free ℤ-module with a symmetric
`LinearMap.BilinForm ℤ L`; the Gram matrix is `LinearMap.BilinForm.toMatrix`; "norm"
means `β x x`; even lattices correspond to `QuadraticForm ℤ L` through `polarBilin`
(never through `associated`, which needs `Invertible (2 : ℤ)`); localization is
`LinearMap.BilinForm.baseChange` (which, unlike `QuadraticForm.baseChange`, is
2-invertibility-free).
-/

namespace TauCetiRoadmap.IntegralLattices

open QuadraticMap MeasureTheory
open scoped Real

universe u v

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
over a field). `det L` is then an honest ℤ-valued invariant of the lattice. -/
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

end Layer0

section Layer1

/-! ## Layer 1: dual lattices, discriminant groups, signature mod 8 -/

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

/-- **Layer 1 summit shape: even unimodular lattices have signature ≡ 0 mod 8.**
Stated through the Gram matrix and the real signature (Mathlib's `sigPos`/`sigNeg`
of the base-changed form — root-namespace names at this pin). The pinned route is through the discriminant-form signature
(Milgram's Gauss-sum formula and van der Blij's lemma, Nikulin Theorem 1.3.3): for
unimodular `L` the discriminant group is trivial, so `t₊ − t₋ ≡ sign(q_L) = 0 mod 8`.
Serre's *A Course in Arithmetic* V.2 Theorem 2 with its Corollary 1 is the classical
statement. -/
example {n : ℕ} (G : Matrix (Fin n) (Fin n) ℤ) (hs : G.IsSymm) (he : ∀ i, 2 ∣ G i i)
    (hu : G.det = 1 ∨ G.det = -1) :
    (8 : ℤ) ∣ (sigPos (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) : ℤ)
      - (sigNeg (Matrix.toQuadraticForm' (G.map (Int.cast : ℤ → ℝ))) : ℤ) :=
  sorry

end Layer1

section Layer2

/-! ## Layer 2: definite lattices — automorphisms, reduction, covolume -/

variable {L : Type u} [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]

/-- **Layer 2, automorphism groups of definite lattices are finite.** The isometry
group embeds into the permutations of a finite generating set of bounded-norm vectors
(equivalently: discrete ∩ compact in `O(n,ℝ)` after realization). Indefinite lattices
have infinite isometry groups in rank ≥ 3 (and in rank 2 exactly in the anisotropic
Pell case) — hence the definite hypothesis. -/
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

/-- **Layer 2, the covolume bridge.** For a lattice realized in Euclidean space, the
square of the `ZLattice` covolume is the Gram determinant of the dot-product form:
`covolume(L)² = det L`. This reconciles the analytic `ZLattice` covolume (consumed
for Minkowski-type bounds) with the algebraic determinant, and is where the
⚠ `√det`-versus-`det` bookkeeping is fixed once. -/
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
symbol calculus (README Layer 3 ⚠). -/
example : ¬ ∃ b : Module.Basis (Fin 2) ℤ_[2] (Fin 2 → ℤ_[2]),
    (Matrix.toBilin' ((!![0, 1; 1, 0] : Matrix (Fin 2) (Fin 2) ℤ).map
      (Int.cast : ℤ → ℤ_[2]))).iIsOrtho b :=
  sorry

end Layer3

section Layer5

/-! ## Layer 5: primitive embeddings (the Nikulin layer's entry point) -/

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
II §5; via Nikulin Corollary 1.13.3 in the discriminant-form route). ⚠ The definite
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

/-! ## Layer 8: theta series -/

variable {L : Type u} [AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]

/-- **Layer 8, theta convergence.** For a positive definite integral lattice the theta
sum `∑_{x ∈ L} exp(−π t · β(x,x))` converges for every `t > 0` — the summability
engine behind `Θ_L(τ) = ∑ exp(πiτ·β(x,x))` on the upper half-plane. Mathlib's
`jacobiTheta` is exactly `Θ_ℤ` in this normalization (the rank-1 reconciliation is a
worked example in `README.md`); the modularity of `Θ_L` is *cited*, not built here
(the modular-forms roadmap PR #47's stack, and half-integral weight in a planned
half-integral-weight roadmap). -/
example (β : LinearMap.BilinForm ℤ L) (hpos : (LinearMap.BilinMap.toQuadraticMap β).PosDef)
    {t : ℝ} (ht : 0 < t) :
    Summable fun x : L => Real.exp (-π * t * ((β x x : ℤ) : ℝ)) :=
  sorry

end Layer8

end TauCetiRoadmap.IntegralLattices
