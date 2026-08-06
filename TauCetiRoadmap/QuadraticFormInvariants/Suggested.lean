import Mathlib

/-!
# Quadratic forms and cohomological invariants: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–9, the convention table, the worked examples, and the
references) is in `README.md`. Mathlib has the linear algebra of quadratic forms
(diagonalization, `Anisotropic`, `Nondegenerate`, isometry equivalence) and quaternion
algebras, but none of the arithmetic theory: no Witt decomposition or cancellation, no
Witt ring, no Hasse invariant, no Hilbert symbol, no transfer, no Stiefel–Whitney
classes. We build that theory in `TauCeti/`.

What this file pins is the set of design decisions most likely to fork two
implementations: the carrier for isometry classes (Layer 0), the exact chain-equivalence
relation and the descent principle every diagonal invariant uses (Layer 0), the binary
normal forms (Layer 0), the four-fold splitting criterion (Layer 2), the Hilbert symbol
as a `{±1}`-valued function of the norm equation and the local Hasse invariant built
from it (Layer 6), the realization constraints of the local classification (Layer 6),
and the Scharlau transfer with the torsor theorem that makes "the" transfer honest
(Layer 9). Statements elaborate against the pinned Mathlib and are stated with `sorry`
(allowed in this human-owned roadmap library).

Brauer-valued and continuous-cohomology signatures stay in prose in `README.md` until
their consumed types exist. `BrauerGroup K` is only a quotient at the pin, so Layer 3's
Hasse invariant is deliberately absent here and Layer 5's targets are named against the
landed semisimple-algebras roadmap (its Layers 4 and 6) rather than sketched with a
placeholder group; the cohomological Layers 7–9 wait on the profinite-cohomology
roadmap in the same way. Layer 4's induced map `I²/I³ → Br(K)[2]` is prose-only for the
same reason, and the roadmap makes no injectivity claim for it.

Layer-6 conventions follow Serre (*A Course in Arithmetic*, ch. III–IV) and O'Meara
(§63). The symbol is *defined* by the norm equation `b = x² − a·y²`, which needs no
classification of quaternion algebras and no local hypothesis at all; every theorem
about it carries the local hypotheses, and at the pin those are available only for
`ℚ_[p]` (the general finite extension of `ℚ_p` is Local Fields PR #2's package).
-/

namespace TauCetiRoadmap.QuadraticFormInvariants

open QuadraticMap
open scoped Quaternion

universe u v

variable {K : Type u} [Field K]

/-! ## Layer 0: the carrier for isometry classes

Functions on isometry classes appear from Layer 3 onwards, and Layer 4 needs a ring
whose elements are such classes. Quotienting over arbitrary finite-dimensional spaces
would force universe and bundling decisions on the first implementer, so the roadmap
fixes a diagonal presentation instead. -/

/-- A diagonal presentation of a regular quadratic form: a rank `n` together with a
tuple of units, read as `⟨w 0, …, w (n-1)⟩`. -/
abbrev RegularFormPresentation (K : Type u) [Field K] : Type u := Σ n : ℕ, Fin n → Kˣ

/-- The form presented by `(n, w)`, namely `weightedSumSquares K w`. -/
def presentedForm (p : RegularFormPresentation K) : QuadraticForm K (Fin p.1 → K) :=
  weightedSumSquares K fun i => ((p.2 i : K))

/-- Two presentations are related when the forms they present are isometric. Mathlib's
`QuadraticMap.Equivalent` already compares forms on different spaces, so presentations
of different ranks may be compared (and only equal ranks are ever related). -/
instance regularFormSetoid (K : Type u) [Field K] : Setoid (RegularFormPresentation K) where
  r p q := (presentedForm p).Equivalent (presentedForm q)
  iseqv :=
    { refl := fun p => Equivalent.refl (presentedForm p)
      symm := fun h => h.symm
      trans := fun h h' => h.trans h' }

/-- **Layer 0, the carrier.** Isometry classes of regular finite-dimensional quadratic
forms, presented diagonally. Layer 3's invariants are functions on this type, and
Layer 4's Witt-Grothendieck ring is built from its two monoid structures. -/
abbrev RegularFormClass (K : Type u) [Field K] : Type u := Quotient (regularFormSetoid K)

/-- **Layer 0, every regular form has a class.** Diagonalization
(`equivalent_weightedSumSquares_units_of_nondegenerate'`) gives the presentation; the
content of the milestone is that the class does not depend on the diagonalization. -/
example [Invertible (2 : K)] {V : Type v} [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate) :
    ∃ p : RegularFormPresentation K, Q.Equivalent (presentedForm p) :=
  sorry

/-! ## Layer 0: chain equivalence and the descent principle -/

/-- A permutation of the slots of a diagonal tuple. -/
def PermutationStep {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  ∃ σ : Equiv.Perm (Fin n), ∀ i, w' i = w (σ i)

/-- A binary move: two slots change by an isometry of binary forms, the rest are fixed. -/
def BinaryStep [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  ∃ i j : Fin n, i ≠ j ∧ (∀ k, k ≠ i → k ≠ j → w k = w' k) ∧
    (weightedSumSquares K ![(w i : K), (w j : K)]).Equivalent
      (weightedSumSquares K ![(w' i : K), (w' j : K)])

/-- One step of Witt's chain equivalence. A transposition is already a `BinaryStep`
(since `⟨a,b⟩ ≅ ⟨b,a⟩`), so `PermutationStep` adds no generating data; it is kept
because permutation invariance is what downstream proofs actually apply. -/
def DiagonalStep [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  PermutationStep w w' ∨ BinaryStep w w'

/-- **Chain equivalence** of diagonal tuples (Lam I.5.2). -/
def DiagonalChain [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  Relation.ReflTransGen DiagonalStep w w'

/-- **Layer 0, Witt's chain-equivalence theorem** (Lam I.5.2). The two directions are of
very different weight: left to right is elementary (each step is an isometry), right to
left is Witt's theorem and is the real content. -/
example [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) :
    DiagonalChain w w' ↔
      (weightedSumSquares K fun i => ((w i : K))).Equivalent
        (weightedSumSquares K fun i => ((w' i : K))) :=
  sorry

/-- **Layer 0, the descent principle** (the shape every later invariant consumes). A
function of diagonal tuples that is invariant under permutations and under binary moves
descends uniquely to `RegularFormClass K`. Applied with `M = BrauerGroup K` (Layer 5),
`M = ℤˣ` (Layer 6), and `M = H²(G_K, 𝔽₂)` written additively (Layer 8). -/
example [Invertible (2 : K)] {M : Type v} [CommMonoid M] (f : RegularFormPresentation K → M)
    (hperm : ∀ (n : ℕ) (w w' : Fin n → Kˣ), PermutationStep w w' → f ⟨n, w⟩ = f ⟨n, w'⟩)
    (hbin : ∀ (n : ℕ) (w w' : Fin n → Kˣ), BinaryStep w w' → f ⟨n, w⟩ = f ⟨n, w'⟩) :
    ∃! F : RegularFormClass K → M, ∀ p, F (Quotient.mk _ p) = f p :=
  sorry

/-! ## Layer 0: representation, value sets, and binary normal forms -/

/-- **Non-vacuity worked example.** `⟨1,1⟩` and `⟨1,−1⟩` are inequivalent over `ℚ`:
the first is anisotropic (positive definite), the second is the hyperbolic plane. -/
example :
    ¬ (weightedSumSquares ℚ ![(1 : ℚ), 1]).Equivalent (weightedSumSquares ℚ ![(1 : ℚ), -1]) :=
  sorry

/-- **Layer 0, the representation criterion** (Lam I.3.5). A regular diagonal form
represents a unit `a` iff `⟨−a⟩ ⊥ q` is isotropic. This is what turns every value-set
question into an isotropy question. Note the criterion is about the *unit* value set
`D(q)`; a value set containing `0` would make the classification corollaries false. -/
example [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) (a : Kˣ) :
    (∃ x : Fin n → K, weightedSumSquares K (fun i => ((w i : K))) x = a) ↔
      ¬ (weightedSumSquares K (Fin.cons (-(a : K)) fun i => ((w i : K)))).Anisotropic :=
  sorry

/-- **Layer 0, the binary representation normal form** (Lam I.2.3(2)): a binary form
represents `c` exactly when `c` can be taken as its first coefficient, the second being
forced by the discriminant. The second coefficient is written `a*b*c`, which is the
square class of `a*b/c`; both spellings occur in the sources and their agreement is part
of the milestone. -/
example [Invertible (2 : K)] (a b c : Kˣ) :
    (∃ x : Fin 2 → K, weightedSumSquares K ![(a : K), b] x = c) ↔
      (weightedSumSquares K ![(a : K), b]).Equivalent
        (weightedSumSquares K ![(c : K), (a : K) * b * c]) :=
  sorry

/-- **Layer 0, the binary equivalence criterion** (Lam I.5.1): two regular binary
diagonal forms are equivalent iff they have the same discriminant in square classes
(`IsSquare (a*b*(c*d))`, the quotient-free spelling; see
`TauCeti.squareClass_eq_zero_iff`) and represent a common unit. This is the "one binary
move" that chain equivalence reduces every equivalence of diagonal forms to. -/
example [Invertible (2 : K)] (a b c d : Kˣ) :
    (weightedSumSquares K ![(a : K), b]).Equivalent (weightedSumSquares K ![(c : K), d]) ↔
      (IsSquare (a * b * (c * d)) ∧
        ∃ e : Kˣ, (∃ x : Fin 2 → K, weightedSumSquares K ![(a : K), b] x = e) ∧
          ∃ x : Fin 2 → K, weightedSumSquares K ![(c : K), d] x = e) :=
  sorry

/-! ## Layer 1: hyperbolic planes and Witt theory -/

/-- **Layer 1, the hyperbolic plane is universal**: `⟨1,−1⟩` represents every unit
(witness `((a+1)/2)² − ((a−1)/2)² = a`). -/
example [Invertible (2 : K)] (a : Kˣ) :
    ∃ x : Fin 2 → K, weightedSumSquares K ![(1 : K), -1] x = a :=
  sorry

/-- **Layer 1, isotropic regular forms split off a hyperbolic plane** (Lam I.3.4):
a nondegenerate isotropic form is equivalent to `⟨1,−1⟩ ⊥ q'` with `q'` regular
diagonal. -/
example [Invertible (2 : K)] {V : Type v} [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (h : ¬ Q.Anisotropic) :
    ∃ (r : ℕ) (a : Fin r → Kˣ),
      Q.Equivalent ((weightedSumSquares K ![(1 : K), -1]).prod
        (weightedSumSquares K fun i => ((a i : K)))) :=
  sorry

/-- **Layer 1, Witt decomposition** (Lam I.4.1, nondegenerate case): every
nondegenerate form is equivalent to `m` hyperbolic planes plus an anisotropic form;
`m` is the **Witt index** and the anisotropic part is unique up to equivalence
(uniqueness is a separate milestone, via cancellation below). -/
example [Invertible (2 : K)] {V : Type v} [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate) :
    ∃ (m r : ℕ) (a : Fin r → Kˣ),
      Module.finrank K V = 2 * m + r ∧
      Q.Equivalent
        ((weightedSumSquares K
            (Sum.elim (fun _ : Fin m => (1 : K)) fun _ : Fin m => (-1 : K))).prod
          (weightedSumSquares K fun i => ((a i : K)))) ∧
      (weightedSumSquares K fun i => ((a i : K))).Anisotropic :=
  sorry

/-- **Layer 1, Witt cancellation** (Lam I.4.2): a common orthogonal summand cancels.
Proved via hyperplane reflections (Lam I.4.5–4.7); Cartan–Dieudonné, stated in the
README as "at most `n` reflections", lands in the same layer. -/
example [Invertible (2 : K)] {U V₁ V₂ : Type v}
    [AddCommGroup U] [Module K U] [FiniteDimensional K U]
    [AddCommGroup V₁] [Module K V₁] [FiniteDimensional K V₁]
    [AddCommGroup V₂] [Module K V₂] [FiniteDimensional K V₂]
    (Q : QuadraticForm K U) (Q₁ : QuadraticForm K V₁) (Q₂ : QuadraticForm K V₂)
    (h : (Q.prod Q₁).Equivalent (Q.prod Q₂)) :
    Q₁.Equivalent Q₂ :=
  sorry

/-! ## Layer 2: quaternion algebras and the four-fold splitting criterion -/

/-- **Layer 2, the norm form of a quaternion algebra.** `x ↦ (x * star x).re` (scalar
by Mathlib's `QuaternionAlgebra.mul_star_eq_coe`) is a quadratic form on
`ℍ[K, a, b]`, equivalent to the 2-fold Pfister form `⟨⟨a,b⟩⟩ = ⟨1, −a, −b, ab⟩`. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    ∃ Q : QuadraticForm K ℍ[K, (a : K), (b : K)],
      (∀ x, Q x = (x * star x).re) ∧
      Q.Equivalent (weightedSumSquares K ![(1 : K), -(a : K), -(b : K), (a : K) * b]) :=
  sorry

/-- **Layer 2, split or division** (Lam III.2.2, 2.7): a quaternion algebra over a field
is a division algebra or is isomorphic to `M₂(K)`. Both halves are computations with the
norm form; neither needs central simplicity, which is Layer 5's prerequisite. State the
abstract side so it can be refactored onto FLT's `IsQuaternionAlgebra` when that
predicate reaches Mathlib. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    (∀ x : ℍ[K, (a : K), (b : K)], x ≠ 0 → IsUnit x) ∨
      Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K) :=
  sorry

/-- **Layer 2, the four-fold splitting criterion, the main theorem of the layer and
`gq2` B11a's shape** (Lam III.2.7, Serre *CiA* III.1.1–1.2, Gille–Szamuely 1.1.9).
For `a, b ∈ Kˣ`, TFAE: (1) `ℍ[K,a,b]` splits; (2) `b` is a norm of the quadratic
algebra `K[√a]` (Mathlib's `QuadraticAlgebra K a 0`); (3) `b = x² − ay²` has a
solution; (4) `⟨1, −a, −b⟩` is isotropic. When `a` is a square all four hold, so no
non-square hypothesis is carried. The fifth equivalent condition, vanishing of the
Kummer cup `(a) ∪ (b)`, is Layer 7B, stated once the profinite-cohomology roadmap's
`H²(G_K, μ₂)` exists and Layer 7A's comparison with `Br(K)[2]` is proved. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    [Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K),
      ∃ z : QuadraticAlgebra K (a : K) 0, QuadraticAlgebra.norm z = (b : K),
      ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2,
      ¬ (weightedSumSquares K ![(1 : K), -(a : K), -(b : K)]).Anisotropic].TFAE :=
  sorry

/-- **Layer 3, the binary quaternion lemma**: equivalent binary forms have isomorphic
quaternion algebras. This is the one nontrivial input to the well-definedness of the
Hasse invariant `s(⟨a₁,…,aₙ⟩) = ∏_{i<j} (aᵢ, aⱼ)` in Layer 5 and of the local Hasse
invariant in Layer 6 (Lam III.2.11, V.3.18), and it is proved here, where its codomain
is only an isomorphism class of algebras. -/
example [Invertible (2 : K)] (a b c d : Kˣ)
    (h : (weightedSumSquares K ![(a : K), b]).Equivalent
      (weightedSumSquares K ![(c : K), d])) :
    Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] ℍ[K, (c : K), (d : K)]) :=
  sorry

/-! ## Layer 3: the classical invariants that need no Brauer group -/

/-- **Layer 3, discriminant invariance**: equivalent regular diagonal forms have the
same discriminant in square classes (quotient-free spelling; the signed discriminant
`d± = (−1)^{n(n−1)/2} d` then transports along the same statement since the
dimensions agree). Route: determinants of Gram matrices under `basisRepr`, or the
descent principle applied to `w ↦ ∏ i, w i`. -/
example [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    IsSquare ((∏ i, w i) * ∏ i, w' i) :=
  sorry

/-! ## Layer 6: the Hilbert symbol, the local Hasse invariant, and the classification

The symbol is defined from the norm equation, so its definition needs no classification
of quaternion algebras and, indeed, no local hypothesis; that is what keeps Layer 6 free
of the circularity "values in `{±1}` because there are two local classes, and there are
two local classes by the symbol". Every *theorem* below carries the local hypotheses. At
the pin those exist only for `ℚ_[p]`; the general finite extension of `ℚ_p`, which is
the roadmap's actual scope, waits on Local Fields PR #2's Layer 0 package. -/

open Classical in
/-- **Layer 6, the Hilbert symbol**, `+1` when `b` is a norm from `K(√a)` and `−1`
otherwise. Total on `Kˣ × Kˣ`, so no junk-value convention is needed (the bridging lemma
to `HassePrinciple`'s integer-valued `hilbertSym`, which is `0` on zero arguments, is
part of the coordination). -/
noncomputable def hilbertSymbol (a b : Kˣ) : ℤˣ :=
  if ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2 then 1 else -1

/-- **Layer 6, symmetry** (Serre *CiA* III.1.1). Proved right after the agreement of the
norm, solvability, and splitting descriptions, so that the Serre orientation and B11a's
orientation are interchangeable from then on. -/
example (p : ℕ) [Fact p.Prime] (a b : ℚ_[p]ˣ) : hilbertSymbol a b = hilbertSymbol b a :=
  sorry

/-- **Layer 6, bimultiplicativity, the hard dyadic-inclusive input** (Serre *CiA* III
Thm 2; O'Meara 63:11–63:13 by the pinned quadratic-defect route). -/
example (p : ℕ) [Fact p.Prime] (a b c : ℚ_[p]ˣ) :
    hilbertSymbol a (b * c) = hilbertSymbol a b * hilbertSymbol a c :=
  sorry

/-- **Layer 6, nondegeneracy** (Serre *CiA* III Thm 2; O'Meara 63:13): for every
non-square `a` some `b` fails to be a norm. The norm-index form
`(Kˣ : N(K(√a)ˣ)) = 2` is a separate milestone, and the mod-2 Tate-duality reading of
this statement is Local Fields PR #2's Layer 8 theorem, cited there. -/
example (p : ℕ) [Fact p.Prime] (a : ℚ_[p]ˣ) (ha : ¬ IsSquare a) :
    ∃ b : ℚ_[p]ˣ, hilbertSymbol a b = -1 :=
  sorry

/-- **Layer 6, the local Hasse invariant** on a diagonal tuple, in the Lam/Serre
convention `∏_{i<j}` (empty product in ranks `0` and `1`). Its codomain is `ℤˣ` and it
is built from the Hilbert symbol alone, so it exists whether or not Layer 5's
Brauer-valued invariant does; that the two agree under `Br(K)[2] ≃ ℤˣ` is a separate
theorem consuming both. -/
noncomputable def localHasse {n : ℕ} (w : Fin n → Kˣ) : ℤˣ :=
  ∏ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    hilbertSymbol (w ij.1) (w ij.2)

/-- **Layer 6, well-definedness of the local Hasse invariant**, by the Layer 0 descent
principle: permutation invariance from symmetry, binary invariance from
bimultiplicativity together with the Layer 3 binary quaternion lemma. -/
example (p : ℕ) [Fact p.Prime] {n : ℕ} (w w' : Fin n → ℚ_[p]ˣ)
    (h : (weightedSumSquares ℚ_[p] fun i => ((w i : ℚ_[p]))).Equivalent
      (weightedSumSquares ℚ_[p] fun i => ((w' i : ℚ_[p])))) :
    localHasse w = localHasse w' :=
  sorry

/-- **Layer 6, the realization constraints, stated exactly** (O'Meara 63:23, Serre *CiA*
IV Prop 6). Every triple `(n, d, s)` with `n ≥ 1` is realized by a regular form over a
local field, except `n = 1` with `s = −1` and `n = 2` with `d = [−1]` and `s = −1`. The
two hypotheses below are exactly those two exclusions; `IsSquare (-d)` spells
"`d = [−1]` in `Kˣ/(Kˣ)²`" and `IsSquare ((∏ i, w i) * d)` spells "the discriminant of
`w` is `d`". -/
example (p : ℕ) [Fact p.Prime] (n : ℕ) (hn : 1 ≤ n) (d : ℚ_[p]ˣ) (s : ℤˣ)
    (h₁ : n = 1 → s = 1) (h₂ : n = 2 → IsSquare (-d) → s = 1) :
    ∃ w : Fin n → ℚ_[p]ˣ, IsSquare ((∏ i, w i) * d) ∧ localHasse w = s :=
  sorry

/-- **Layer 6, the second realization exception is forced**: a binary form of
discriminant `[−1]` is `⟨a, −a⟩` up to isometry, and its Hasse invariant is `+1`. -/
example (p : ℕ) [Fact p.Prime] (a b : ℚ_[p]ˣ) (h : IsSquare (-(a * b))) :
    localHasse ![a, b] = 1 :=
  sorry

/-- **Layer 6, isotropy in rank 2** (Serre *CiA* IV Thm 6): a binary form is isotropic
iff its discriminant is `[−1]`. The other ranks are stated in the README against the
same convention; rank 3 uses `s = (−1, −d)`, rank 4 uses `d ≠ [1] ∨ s = (−1,−1)`, and
rank at least 5 is unconditional. -/
example (p : ℕ) [Fact p.Prime] (a b : ℚ_[p]ˣ) :
    ¬ (weightedSumSquares ℚ_[p] ![(a : ℚ_[p]), b]).Anisotropic ↔ IsSquare (-(a * b)) :=
  sorry

/-- **Layer 6, `u(K) = 4`**: every form in at least five variables is isotropic, dyadic
case included (O'Meara 63:19; Serre *CiA* IV Thm 6(iv)). -/
example (p : ℕ) [Fact p.Prime] (w : Fin 5 → ℚ_[p]ˣ) :
    ¬ (weightedSumSquares ℚ_[p] fun i => ((w i : ℚ_[p]))).Anisotropic :=
  sorry

/-- **Layer 6, classification acceptance (existence half)**: `⟨1,1,1,1⟩`, the norm form
of Hamilton's quaternions, is anisotropic over `ℚ_2` (O'Meara 63:17). -/
example : (weightedSumSquares ℚ_[2] fun _ : Fin 4 => (1 : ℚ_[2])).Anisotropic :=
  sorry

/-- **Layer 6, classification acceptance (uniqueness half)**: any two anisotropic
quaternary forms over `ℚ_2` are equivalent (O'Meara 63:18; Serre *CiA* IV Thm 7
corollary). The unique class is the norm form of the unique quaternion division algebra,
from which "there are exactly two quaternion algebras locally" follows; that consequence
is never used to define the symbol. -/
example (w w' : Fin 4 → ℚ_[2]ˣ)
    (h : (weightedSumSquares ℚ_[2] fun i => ((w i : ℚ_[2]))).Anisotropic)
    (h' : (weightedSumSquares ℚ_[2] fun i => ((w' i : ℚ_[2]))).Anisotropic) :
    (weightedSumSquares ℚ_[2] fun i => ((w i : ℚ_[2]))).Equivalent
      (weightedSumSquares ℚ_[2] fun i => ((w' i : ℚ_[2]))) :=
  sorry

/-! ### Layer 6 worked examples (the dyadic table)

Phrased through the norm equation, so they are readable before any symbol theory. -/

/-- `(−1,−1)_{ℚ_2} = −1`: `−1` is not a sum of two squares in `ℚ_2`, so Hamilton's
quaternions are division over `ℚ_2`. -/
example : ¬ ∃ x y : ℚ_[2], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- `(−1,−1)_{ℚ_p} = +1` for odd `p`: `−1` is a sum of two squares in `ℚ_p` (solve
mod `p`, lift by Hensel). -/
example (p : ℕ) [Fact p.Prime] (hp : p ≠ 2) : ∃ x y : ℚ_[p], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- `(2,5)_{ℚ_2} = −1`, the entry of the dyadic table where all four conditions of the
four-fold criterion fail: by Serre's formula the exponent is `ω(5) = 1`. -/
example : ¬ ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 2 * y ^ 2 :=
  sorry

/-- `(5,5)_{ℚ_2} = +1`, the entry where all four conditions hold, with the explicit
witness `5 = 5² − 5·2²`. The `8 × 8` table over `{±1, ±5, ±2, ±10}` is a family of
decidable computations of exactly this shape (this entry needs no `sorry`). -/
example : ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  ⟨5, 2, by norm_num⟩

/-! ## Layer 9: the Scharlau transfer -/

/-- **Layer 9, the nonzero functionals form an `Lˣ`-torsor.** `Hom_K(L,K)` is
one-dimensional over `L` under `(λ · s) x = s (λ x)`, so any two nonzero functionals
differ by a unique unit. This is what makes the change-of-functional theorem compare
*every* two choices, and hence what makes "the" transfer honest. -/
example {L : Type v} [Field L] [Algebra K L] [FiniteDimensional K L]
    (s s' : L →ₗ[K] K) (hs : s ≠ 0) (hs' : s' ≠ 0) :
    ∃! lam : Lˣ, ∀ x : L, s' x = s ((lam : L) * x) :=
  sorry

/-- **Layer 9, the Scharlau transfer** of a form over `L` along a `K`-functional. This
is Mathlib's `LinearMap.compQuadraticMap'` at `R = L`, `S = K`: postcomposition with
`s`, with scalars restricted. The milestones are its properties (rank, regularity,
additivity, Frobenius reciprocity, change of functional), not the construction. -/
def scharlauTransfer {L : Type v} [Field L] [Algebra K L] {V : Type v} [AddCommGroup V]
    [Module L V] [Module K V] [IsScalarTower K L V] (s : L →ₗ[K] K)
    (q : QuadraticForm L V) : QuadraticForm K V :=
  s.compQuadraticMap' q

/-- **Layer 9, the transfer preserves hyperbolic forms**: a Lagrangian stays a
Lagrangian, so `s_*` descends to `W(L) → W(K)`. The descended map is additive and a
`W(K)`-module map by Frobenius reciprocity, and is **not** a ring map. -/
example {L : Type v} [Field L] [Algebra K L] [FiniteDimensional K L] [Invertible (2 : K)]
    (s : L →ₗ[K] K) (hs : s ≠ 0) (m : ℕ) (hm : Module.finrank K L = m) :
    (scharlauTransfer s (weightedSumSquares L ![(1 : L), -1])).Equivalent
      (weightedSumSquares K (Sum.elim (fun _ : Fin m => (1 : K)) fun _ : Fin m => (-1 : K))) :=
  sorry

/-- **Layer 9, the transfer of `⟨1⟩` along the trace, diagonalized**: for the quadratic
algebra `K[√d]`, the trace form is `⟨2, 2d⟩` on the basis `{1, √d}`. Prove through
`TauCeti/FieldTheory/Trace`'s diagonalization API. The twisted forms `Tr_*⟨a⟩` are what
Kahn's formula evaluates; the Evens–Kahn identity for `w(Tr_* q)` is stated once the
profinite-cohomology roadmap's Stiefel–Whitney layer exists. -/
example [Invertible (2 : K)] (d : Kˣ) :
    (LinearMap.BilinMap.toQuadraticMap
        (Algebra.traceForm K (QuadraticAlgebra K (d : K) 0))).Equivalent
      (weightedSumSquares K ![(2 : K), 2 * d]) :=
  sorry

/-! ## Consumed-interface checks (no new mathematics, and not milestones here)

These confirm that the API this roadmap consumes says what the statements above assume.
The square-class cardinalities belong to
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s Layer 1, not
to this roadmap: it owns quadratic forms and symbols, that one owns local structure. -/

/-- Consumed from PR #2 Layer 1: `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8`, on the basis `−1, 2, 5`, with
representatives `{±1, ±5, ±2, ±10}` for the dyadic table above. -/
example : Nat.card (ℚ_[2]ˣ ⧸ Subgroup.square ℚ_[2]ˣ) = 8 :=
  sorry

/-- Consumed from PR #2 Layer 1: `#(ℚ_pˣ/(ℚ_pˣ)²) = 4` for odd `p`, with representatives
`1, u, p, up` where `u` is a unit whose residue is a nonsquare. -/
example (p : ℕ) [Fact p.Prime] (hp : p ≠ 2) :
    Nat.card (ℚ_[p]ˣ ⧸ Subgroup.square ℚ_[p]ˣ) = 4 :=
  sorry

/-- Consumed from Mathlib: `ℍ[ℝ]` is a division ring, the archimedean instance
`(−1,−1)_ℝ = −1` of the split-or-division dichotomy. -/
example (x : ℍ[ℝ]) (hx : x ≠ 0) : IsUnit x := hx.isUnit

end TauCetiRoadmap.QuadraticFormInvariants
