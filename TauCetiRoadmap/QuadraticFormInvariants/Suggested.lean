import Mathlib
import TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras.Suggested

/-!
# Quadratic forms and cohomological invariants: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers agree on names and signatures. Discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap, that is Layers 0 to 9, the convention table, the worked examples,
and the references, is in `README.md`. Mathlib has the linear algebra of quadratic forms,
that is diagonalization, `Anisotropic`, `Nondegenerate`, and isometry equivalence, and it
has quaternion algebras. It has none of the arithmetic theory: no Witt decomposition, no
Witt cancellation, no Witt ring, no Hasse invariant, no Hilbert symbol, no transfer, and
no Stiefel-Whitney classes. We build that theory in `TauCeti/`.

This file fixes the design decisions that are most likely to fork two implementations:

* the carrier for isometry classes (Layer 0);
* the chain-equivalence relation and the descent principle (Layer 0);
* the binary normal forms (Layer 0);
* the four-fold splitting criterion (Layer 2);
* the Brauer-group data and the Hasse invariant built on it (Layer 5);
* the local-field toolkit (Layer 6A);
* the fractional-ideal carrier of the quadratic defect and its exponent (Layer 6B);
* the Hilbert symbol as a `{±1}`-valued function of the norm equation, and the local
  Hasse invariant built from it (Layer 6C);
* the realization constraints of the local classification (Layer 6D);
* the operations on mod-2 Galois cohomology (Layer 7A);
* the Scharlau transfer and the degree-2 Evens-Kahn identity (Layer 9).

**Carriers are canonical, and only the missing operations are hypotheses.** Three objects
that this roadmap consumes are incomplete in Mathlib: the group structure on
`BrauerGroup K`, the arithmetic of a nonarchimedean local field, and the low-degree API
of continuous Galois cohomology. Each is carried by a structure whose fields are
milestones. The types on which those structures act are the real ones:
`BrauerGroup K` itself, Mathlib's `IsNonarchimedeanLocalField`, and Mathlib's
`continuousCohomology`. So a theorem stated for an arbitrary term of a structure is a
theorem about the intended objects, and a development that supplies the missing
operations replaces the structure field by field.

Layer-6 conventions follow Serre (*A Course in Arithmetic*, ch. III and IV) and O'Meara
(§63). The symbol is defined by the norm equation `b = x² − a·y²`, which needs no
classification of quaternion algebras and no local hypothesis. Every theorem about the
symbol carries the local hypotheses.

Statements elaborate against the pinned Mathlib and use `sorry`, which is allowed in this
human-owned roadmap library.
-/

namespace TauCetiRoadmap.QuadraticFormInvariants

open QuadraticMap CategoryTheory
open scoped Quaternion

universe u v

variable {K : Type u} [Field K]

/-! ## Layer 0: the carrier for isometry classes

Functions on isometry classes appear from Layer 3 onwards, and Layer 4 needs a ring
whose elements are such classes. A quotient over arbitrary finite-dimensional spaces
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
of different ranks may be compared, and only equal ranks are ever related. -/
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
(`equivalent_weightedSumSquares_units_of_nondegenerate'`) gives the presentation. The
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

/-- One step of Witt's chain equivalence. A transposition is already a `BinaryStep`,
because `⟨a,b⟩ ≅ ⟨b,a⟩`, so `PermutationStep` adds no generating data. It is kept
because permutation invariance is what downstream proofs apply. -/
def DiagonalStep [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  PermutationStep w w' ∨ BinaryStep w w'

/-- **Chain equivalence** of diagonal tuples (Lam I.5.2). -/
def DiagonalChain [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) : Prop :=
  Relation.ReflTransGen DiagonalStep w w'

/-- **Layer 0, Witt's chain-equivalence theorem** (Lam I.5.2). The two directions are not
equally hard. Left to right is elementary, because each step is an isometry. Right to
left is Witt's theorem, and it is the difficult direction. -/
example [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ) :
    DiagonalChain w w' ↔
      (weightedSumSquares K fun i => ((w i : K))).Equivalent
        (weightedSumSquares K fun i => ((w' i : K))) :=
  sorry

/-- **Layer 0, the descent principle**, which is the form that every later invariant
consumes. A function of diagonal tuples that is invariant under permutations and under
binary moves descends uniquely to `RegularFormClass K`. It is applied with
`M = BrauerGroup K` (Layer 5), `M = ℤˣ` (Layer 6C), and `M = H²(G_K, 𝔽₂)` written
additively (Layer 8). -/
example [Invertible (2 : K)] {M : Type v} [CommMonoid M] (f : RegularFormPresentation K → M)
    (hperm : ∀ (n : ℕ) (w w' : Fin n → Kˣ), PermutationStep w w' → f ⟨n, w⟩ = f ⟨n, w'⟩)
    (hbin : ∀ (n : ℕ) (w w' : Fin n → Kˣ), BinaryStep w w' → f ⟨n, w⟩ = f ⟨n, w'⟩) :
    ∃! F : RegularFormClass K → M, ∀ p, F (Quotient.mk _ p) = f p :=
  sorry

/-! ## Layer 0: representation, value sets, and binary normal forms -/

/-- **Non-vacuity worked example.** `⟨1,1⟩` and `⟨1,−1⟩` are inequivalent over `ℚ`:
the first is anisotropic, that is positive definite, and the second is the hyperbolic
plane. -/
example :
    ¬ (weightedSumSquares ℚ ![(1 : ℚ), 1]).Equivalent (weightedSumSquares ℚ ![(1 : ℚ), -1]) :=
  sorry

/-- **Layer 0, the representation criterion** (Lam I.3.5). A regular diagonal form
represents a unit `a` exactly when `⟨−a⟩ ⊥ q` is isotropic. This turns every value-set
question into an isotropy question. The criterion is about the unit value set `D(q)`; a
value set that contains `0` makes the classification corollaries false. -/
example [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) (a : Kˣ) :
    (∃ x : Fin n → K, weightedSumSquares K (fun i => ((w i : K))) x = a) ↔
      ¬ (weightedSumSquares K (Fin.cons (-(a : K)) fun i => ((w i : K)))).Anisotropic :=
  sorry

/-- **Layer 0, the binary representation normal form** (Lam I.2.3(2)). A binary form
represents `c` exactly when `c` can be taken as its first coefficient, the second being
forced by the discriminant. The second coefficient is written `a*b*c`, which is the
square class of `a*b/c`. Both spellings occur in the sources, and their agreement is part
of the milestone. -/
example [Invertible (2 : K)] (a b c : Kˣ) :
    (∃ x : Fin 2 → K, weightedSumSquares K ![(a : K), b] x = c) ↔
      (weightedSumSquares K ![(a : K), b]).Equivalent
        (weightedSumSquares K ![(c : K), (a : K) * b * c]) :=
  sorry

/-- **Layer 0, the binary equivalence criterion** (Lam I.5.1). Two regular binary
diagonal forms are equivalent exactly when they have the same discriminant in square
classes, that is `IsSquare (a*b*(c*d))` in the quotient-free spelling of
`TauCeti.squareClass_eq_zero_iff`, and represent a common unit. This is the single
binary move to which chain equivalence reduces every equivalence of diagonal forms. -/
example [Invertible (2 : K)] (a b c d : Kˣ) :
    (weightedSumSquares K ![(a : K), b]).Equivalent (weightedSumSquares K ![(c : K), d]) ↔
      (IsSquare (a * b * (c * d)) ∧
        ∃ e : Kˣ, (∃ x : Fin 2 → K, weightedSumSquares K ![(a : K), b] x = e) ∧
          ∃ x : Fin 2 → K, weightedSumSquares K ![(c : K), d] x = e) :=
  sorry

/-! ## Layer 1: hyperbolic planes and Witt theory -/

/-- **Layer 1, the hyperbolic plane is universal.** `⟨1,−1⟩` represents every unit, with
the witness `((a+1)/2)² − ((a−1)/2)² = a`. -/
example [Invertible (2 : K)] (a : Kˣ) :
    ∃ x : Fin 2 → K, weightedSumSquares K ![(1 : K), -1] x = a :=
  sorry

/-- **Layer 1, isotropic regular forms split off a hyperbolic plane** (Lam I.3.4). A
nondegenerate isotropic form is equivalent to `⟨1,−1⟩ ⊥ q'` with `q'` regular
diagonal. -/
example [Invertible (2 : K)] {V : Type v} [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (h : ¬ Q.Anisotropic) :
    ∃ (r : ℕ) (a : Fin r → Kˣ),
      Q.Equivalent ((weightedSumSquares K ![(1 : K), -1]).prod
        (weightedSumSquares K fun i => ((a i : K)))) :=
  sorry

/-- **Layer 1, Witt decomposition** (Lam I.4.1, nondegenerate case). Every nondegenerate
form is equivalent to `m` hyperbolic planes plus an anisotropic form. Here `m` is the
Witt index, and the anisotropic part is unique up to equivalence; uniqueness is a
separate milestone that uses cancellation below. -/
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

/-- **Layer 1, Witt cancellation** (Lam I.4.2). A common regular orthogonal summand
cancels. Regularity of all three forms is part of the statement: cancellation is false
without it. The proof runs through hyperplane reflections (Lam I.4.5 to I.4.7). -/
example [Invertible (2 : K)] {U V₁ V₂ : Type v}
    [AddCommGroup U] [Module K U] [FiniteDimensional K U]
    [AddCommGroup V₁] [Module K V₁] [FiniteDimensional K V₁]
    [AddCommGroup V₂] [Module K V₂] [FiniteDimensional K V₂]
    (Q : QuadraticForm K U) (Q₁ : QuadraticForm K V₁) (Q₂ : QuadraticForm K V₂)
    (hQ : Q.Nondegenerate) (hQ₁ : Q₁.Nondegenerate) (hQ₂ : Q₂.Nondegenerate)
    (h : (Q.prod Q₁).Equivalent (Q.prod Q₂)) :
    Q₁.Equivalent Q₂ :=
  sorry

/-! ## Layer 2: quaternion algebras and the four-fold splitting criterion -/

/-- **Layer 2, the norm form of a quaternion algebra.** The map `x ↦ (x * star x).re` is
scalar-valued by Mathlib's `QuaternionAlgebra.mul_star_eq_coe`. It is a quadratic form on
`ℍ[K, a, b]`, equivalent to the 2-fold Pfister form `⟨⟨a,b⟩⟩ = ⟨1, −a, −b, ab⟩`. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    ∃ Q : QuadraticForm K ℍ[K, (a : K), (b : K)],
      (∀ x, Q x = (x * star x).re) ∧
      Q.Equivalent (weightedSumSquares K ![(1 : K), -(a : K), -(b : K), (a : K) * b]) :=
  sorry

/-- **Layer 2, split or division** (Lam III.2.2, III.2.7). A quaternion algebra over a
field is a division algebra or is isomorphic to `M₂(K)`. Both halves are computations
with the norm form, and neither needs central simplicity, which is a Layer 5
prerequisite. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    (∀ x : ℍ[K, (a : K), (b : K)], x ≠ 0 → IsUnit x) ∨
      Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K) :=
  sorry

/-- **Layer 2, the four-fold splitting criterion**, the main theorem of the layer and the
statement that `gq2`'s B11a uses (Lam III.2.7, Serre *CiA* III.1.1-1.2, Gille-Szamuely
1.1.9). For `a, b ∈ Kˣ` the following are equivalent: (1) `ℍ[K,a,b]` splits; (2) `b` is a
norm of the quadratic algebra `K[√a]`, that is Mathlib's `QuadraticAlgebra K a 0`; (3)
`b = x² − ay²` has a solution; (4) `⟨1, −a, −b⟩` is isotropic. When `a` is a square all
four hold, so no non-square hypothesis is carried. The fifth equivalent condition, the
vanishing of the Kummer cup `(a) ∪ (b)`, is Layer 7C. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    [Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K),
      ∃ z : QuadraticAlgebra K (a : K) 0, QuadraticAlgebra.norm z = (b : K),
      ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2,
      ¬ (weightedSumSquares K ![(1 : K), -(a : K), -(b : K)]).Anisotropic].TFAE :=
  sorry

/-- **Layer 3, the binary quaternion lemma.** Equivalent binary forms have isomorphic
quaternion algebras. This is the one nontrivial input to the well-definedness of the
Hasse invariant in Layer 5 and of the local Hasse invariant in Layer 6C (Lam III.2.11,
V.3.18). It is proved here, where its codomain is only an isomorphism class of
algebras. -/
example [Invertible (2 : K)] (a b c d : Kˣ)
    (h : (weightedSumSquares K ![(a : K), b]).Equivalent
      (weightedSumSquares K ![(c : K), d])) :
    Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] ℍ[K, (c : K), (d : K)]) :=
  sorry

/-! ## Layer 3: the classical invariants that need no Brauer group -/

/-- **Layer 3, discriminant invariance.** Equivalent regular diagonal forms have the same
discriminant in square classes, in the quotient-free spelling. The signed discriminant
`d± = (−1)^{n(n−1)/2} d` transports along the same statement, because the dimensions
agree. -/
example [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    IsSquare ((∏ i, w i) * ∏ i, w' i) :=
  sorry

/-! ## Layer 5: the Brauer group and the Hasse invariant

The carrier and the group law are both canonical. The law is the accepted
semisimple-algebras declaration `brauerCommGroup`, whose multiplication is induced by
`⊗_K`; this file imports it. What Layer 5 adds is the central simplicity of quaternion
algebras, and then the symbol is the class of `ℍ[K,a,b]` and nothing else. -/

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, quaternion algebras are central.** The hypothesis `Invertible (2 : K)` is
the standing one, and it is what the proof of central simplicity uses. -/
instance quaternionAlgebra_isCentral [Invertible (2 : K)] (a b : Kˣ) :
    Algebra.IsCentral K ℍ[K, (a : K), (b : K)] :=
  sorry

/-- **Layer 5, quaternion algebras are simple.** -/
instance quaternionAlgebra_isSimpleRing [Invertible (2 : K)] (a b : Kˣ) :
    IsSimpleRing ℍ[K, (a : K), (b : K)] :=
  sorry

/-- **Layer 5, quaternion algebras are four-dimensional.** -/
instance quaternionAlgebra_finiteDimensional (a b : Kˣ) :
    FiniteDimensional K ℍ[K, (a : K), (b : K)] :=
  sorry

/-- The quaternion algebra as a central simple algebra. -/
noncomputable def quaternionCSA [Invertible (2 : K)] (a b : Kˣ) : CSA.{u, u} K :=
  { toAlgCat := AlgCat.of K ℍ[K, (a : K), (b : K)] }

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the quaternion symbol** `[(a,b)] = ⟦ℍ[K,a,b]⟧` in `BrauerGroup K`, with the
group law `brauerCommGroup` of the semisimple-algebras roadmap. -/
noncomputable def quaternionClass [Invertible (2 : K)] (a b : Kˣ) : BrauerGroup.{u, u} K :=
  Quotient.mk _ (quaternionCSA a b)

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, symmetry of the symbol.** -/
theorem quaternionClass_symm [Invertible (2 : K)] (a b : Kˣ) :
    quaternionClass a b = quaternionClass b a :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the symbol is 2-torsion**, from `ℍ[K,a,b]ᵒᵖ ≃ₐ[K] ℍ[K,a,b]` through
`star`. -/
theorem quaternionClass_sq [Invertible (2 : K)] (a b : Kˣ) :
    quaternionClass a b ^ 2 = 1 :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, bilinearity of the symbol** (Gille-Szamuely 1.5.2 for the statement,
Lam III.2.11 for the linkage). This is a statement about the tensor-product law, and it
consumes `tensorProduct_isSimpleRing` and `tensorOp_algEquiv_matrix`. -/
theorem quaternionClass_mul [Invertible (2 : K)] (a b c : Kˣ) :
    quaternionClass a (b * c) = quaternionClass a b * quaternionClass a c :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the symbol on equivalent binary forms.** This is the Layer 3 binary
quaternion lemma read in `BrauerGroup K`, and it is what the descent of the Hasse
invariant uses. It does not follow from symmetry, 2-torsion, and bilinearity alone: a
symmetric bilinear pairing on square classes satisfies those three and can take a
nonzero value at `([2],[−1])`, while `⟨2,−1⟩ ≅ ⟨1,−2⟩` forces the value `1`. -/
theorem quaternionClass_congr [Invertible (2 : K)] (a b c d : Kˣ)
    (h : (weightedSumSquares K ![(a : K), b]).Equivalent
      (weightedSumSquares K ![(c : K), d])) :
    quaternionClass a b = quaternionClass c d :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the Steinberg relation** for `a : Kˣ` with `1 − a ≠ 0`. -/
theorem quaternionClass_one_sub [Invertible (2 : K)] (a : Kˣ) (h : (1 : K) - a ≠ 0) :
    quaternionClass a (Units.mk0 ((1 : K) - a) h) = 1 :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the Hasse invariant** on a diagonal tuple, in the Lam and Serre convention
`∏_{i<j}`, with the empty product in ranks `0` and `1`. -/
noncomputable def hasseInvariant [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) :
    BrauerGroup.{u, u} K :=
  ∏ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    quaternionClass (w ij.1) (w ij.2)

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, well-definedness of the Hasse invariant**, by the Layer 0 descent
principle: permutation invariance from `quaternionClass_symm`, and binary invariance from
`quaternionClass_mul` together with `quaternionClass_congr`. -/
theorem hasseInvariant_congr [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    hasseInvariant w = hasseInvariant w' :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the orthogonal-sum formula** (Lam p. 119):
`s(q ⊥ r) = s(q) · s(r) · [(d(q), d(r))]`. -/
theorem hasseInvariant_append [Invertible (2 : K)] {m n : ℕ} (w : Fin m → Kˣ)
    (w' : Fin n → Kˣ) :
    hasseInvariant (Fin.append w w') =
      hasseInvariant w * hasseInvariant w' * quaternionClass (∏ i, w i) (∏ i, w' i) :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the scaling formula** (Lam V.3.16):
`s(λ • q) = s(q) · [(λ, −1)]^{n(n−1)/2} · [(λ, d(q))]^{n−1}`. It is written out because
each source states it in a different convention. -/
theorem hasseInvariant_smul [Invertible (2 : K)] {n : ℕ} (lam : Kˣ) (w : Fin n → Kˣ) :
    hasseInvariant (fun i => lam * w i) =
      hasseInvariant w * quaternionClass lam (-1) ^ (n * (n - 1) / 2) *
        quaternionClass lam (∏ i, w i) ^ (n - 1) :=
  sorry

/-! ## Layer 4: the Witt ring, the fundamental ideal, and the Clifford invariant

These are the carriers that Layer 5's `I²` homomorphism and Layer 8's comparisons use.
Their types and map directions are fixed here; the constructions are milestones. -/

/-- **Layer 4, the semiring of isometry classes**, with `⊥` as addition and `⊗` as
multiplication. -/
noncomputable instance regularFormClassSemiring [Invertible (2 : K)] :
    CommSemiring (RegularFormClass K) :=
  sorry

/-- **Layer 4, the Witt-Grothendieck ring**, the Grothendieck group of that semiring. -/
def wittGrothendieckRing (K : Type u) [Field K] [Invertible (2 : K)] : Type u :=
  sorry

noncomputable instance [Invertible (2 : K)] : CommRing (wittGrothendieckRing K) := sorry

/-- **Layer 4, the Witt ring**, the quotient by the ideal generated by the hyperbolic
plane. -/
def wittRing (K : Type u) [Field K] [Invertible (2 : K)] : Type u :=
  sorry

noncomputable instance [Invertible (2 : K)] : CommRing (wittRing K) := sorry

/-- **Layer 4, the quotient map** from the Witt-Grothendieck ring to the Witt ring. -/
noncomputable def toWittRing [Invertible (2 : K)] :
    wittGrothendieckRing K →+* wittRing K :=
  sorry

/-- **Layer 4, the dimension map** `W(K) → ZMod 2`. -/
noncomputable def wittDimMod2 [Invertible (2 : K)] : wittRing K →+* ZMod 2 :=
  sorry

/-- **Layer 4, the fundamental ideal** `I(K) = ker(W(K) → ZMod 2)`. -/
noncomputable def fundamentalIdeal (K : Type u) [Field K] [Invertible (2 : K)] :
    Ideal (wittRing K) :=
  RingHom.ker (wittDimMod2 (K := K))

/-- **Layer 4, the signed discriminant on the fundamental ideal**, whose kernel is `I²`.
That pair of statements is `I/I² ≅ Kˣ/(Kˣ)²`. -/
noncomputable def signedDiscrHom [Invertible (2 : K)] :
    ↥(fundamentalIdeal K) →+ Additive (Kˣ ⧸ Subgroup.square Kˣ) :=
  sorry

theorem signedDiscrHom_surjective [Invertible (2 : K)] :
    Function.Surjective (signedDiscrHom (K := K)) :=
  sorry

theorem signedDiscrHom_eq_zero_iff [Invertible (2 : K)] (x : ↥(fundamentalIdeal K)) :
    signedDiscrHom x = 0 ↔ (x : wittRing K) ∈ fundamentalIdeal K ^ 2 :=
  sorry

/-- **Layer 4, the `n`-fold Pfister form** `⟨⟨a₁,…,aₙ⟩⟩`, as a presentation of rank
`2^n`. -/
noncomputable def pfisterForm [Invertible (2 : K)] {n : ℕ} (a : Fin n → Kˣ) :
    Fin (2 ^ n) → Kˣ :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the Clifford invariant.** The Brauer class of `C(q)` in even rank and of
`C₀(q)` in odd rank. Central simplicity of those algebras is a Layer 5 milestone. -/
noncomputable def cliffordInvariant [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) :
    BrauerGroup.{u, u} K :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the comparison of the two Brauer-valued invariants** (Lam V.3.20), with
the ⚠ Wall caution of the README's convention table. -/
theorem cliffordInvariant_eq [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) :
    cliffordInvariant w =
      hasseInvariant w * quaternionClass (-1) (∏ i, w i) ^ ((n - 1) * (n - 2) / 2) *
        quaternionClass (-1) (-1) ^ ((n + 1) * n * (n - 1) * (n - 2) / 24) :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, the homomorphism `c : I² → Br(K)[2]`** induced by the Clifford invariant,
using Layer 4's generation of `I²` by 2-fold Pfister forms. -/
noncomputable def cliffordHomI2 [Invertible (2 : K)] :
    ↥(fundamentalIdeal K ^ 2) →+ Additive (BrauerGroup.{u, u} K) :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 5, `c` vanishes on `I³`**, checked on 3-fold Pfister generators
(Lam V.3.4), so it descends to `I²/I³`. No injectivity claim is made: that is
Merkurjev's theorem, an explicit exclusion of this roadmap. -/
theorem cliffordHomI2_eq_zero [Invertible (2 : K)] (x : ↥(fundamentalIdeal K ^ 2))
    (hx : (x : wittRing K) ∈ fundamentalIdeal K ^ 3) :
    cliffordHomI2 x = 0 :=
  sorry

/-! ## Layer 6A: the local-field toolkit

Mathlib's `IsNonarchimedeanLocalField` supplies `𝒪[K]`, `𝓂[K]`, `𝓀[K]`, the discrete
valuation ring structure, and finiteness of the residue field. It supplies no normalized
valuation, no unit filtration, and no square-class arithmetic. Those are named canonical
definitions here, each with the theorems that characterize it. A uniformizer is a choice
satisfying a predicate, and is never stored as data. -/

section LocalField

open scoped ValuativeRel

variable (K)
variable [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]

/-- **Layer 6A, the normalized valuation** `v_K : Kˣ →* Multiplicative ℤ`. -/
noncomputable def normalizedValuation : Kˣ →* Multiplicative ℤ :=
  sorry

/-- The value group is all of `ℤ`. -/
theorem normalizedValuation_surjective : Function.Surjective (normalizedValuation K) :=
  sorry

/-- Nonnegative valuation describes the ring of integers. Units have value `0`. -/
theorem mem_integer_iff_zero_le (x : Kˣ) :
    0 ≤ Multiplicative.toAdd (normalizedValuation K x) ↔ (x : K) ∈ 𝒪[K] :=
  sorry

/-- Agreement with Mathlib's additive valuation on the discrete valuation ring `𝒪[K]`. -/
theorem normalizedValuation_eq_addVal (x : Kˣ) (hx : (x : K) ∈ 𝒪[K]) (y : 𝒪[K])
    (hy : (y : K) = (x : K)) :
    (IsDiscreteValuationRing.addVal 𝒪[K] y : ℕ∞) =
      (Multiplicative.toAdd (normalizedValuation K x)).toNat :=
  sorry

variable {K}

/-- **Layer 6A, a uniformizer** is an element of valuation one. It is a choice, so it is a
predicate and not a field of a package. -/
def IsUniformizer (π : Kˣ) : Prop :=
  normalizedValuation K π = Multiplicative.ofAdd 1

variable (K)

/-- A uniformizer exists. Statements that need one take it and this proof explicitly. -/
theorem exists_isUniformizer : ∃ π : Kˣ, IsUniformizer (K := K) π :=
  sorry

/-- **Layer 6A, the unit filtration** `U(K, i)`. -/
noncomputable def unitFiltration (i : ℕ) : Subgroup Kˣ :=
  sorry

/-- `U(K,0)` is the group of units of `𝒪[K]`. -/
theorem mem_unitFiltration_zero (x : Kˣ) :
    x ∈ unitFiltration K 0 ↔ Multiplicative.toAdd (normalizedValuation K x) = 0 :=
  sorry

/-- `U(K,i+1)` is the group of units congruent to `1` modulo `𝓂[K]^{i+1}`. The quantifier
is vacuous at `x = 1`, where `x − 1` is not a unit. -/
theorem mem_unitFiltration_succ (i : ℕ) (x : Kˣ) :
    x ∈ unitFiltration K (i + 1) ↔
      x ∈ unitFiltration K 0 ∧
        ∀ y : Kˣ, (y : K) = (x : K) - 1 →
          (i + 1 : ℤ) ≤ Multiplicative.toAdd (normalizedValuation K y) :=
  sorry

/-- The filtration decreases. -/
theorem unitFiltration_antitone : Antitone (unitFiltration K) :=
  sorry

/-- **Layer 6A, the absolute ramification index** `e = v_K(2)`. The standing hypothesis
`Invertible (2 : K)` is what makes `2` a unit, so `e` is not data. -/
noncomputable def absoluteRamificationIndex [Invertible (2 : K)] : ℕ :=
  (Multiplicative.toAdd (normalizedValuation K (unitOfInvertible (2 : K)))).toNat

/-- The defining equation of `e`. -/
theorem normalizedValuation_two [Invertible (2 : K)] :
    normalizedValuation K (unitOfInvertible (2 : K)) =
      Multiplicative.ofAdd ((absoluteRamificationIndex K : ℤ)) :=
  sorry

/-- **Layer 6A, the filtration quotients are finite**, which is what the counting
arguments below need. -/
instance unitFiltration_quotient_finite (i : ℕ) :
    Finite (unitFiltration K i ⧸ (unitFiltration K (i + 1)).subgroupOf (unitFiltration K i)) :=
  sorry

/-- **Layer 6A, the depth-zero quotient** `𝒪[K]ˣ / U(K,1) ≃* 𝓀[K]ˣ`. -/
noncomputable def unitFiltrationQuotientZero :
    (unitFiltration K 0 ⧸ (unitFiltration K 1).subgroupOf (unitFiltration K 0)) ≃*
      (IsLocalRing.ResidueField 𝒪[K])ˣ :=
  sorry

/-- **Layer 6A, the deeper quotients** `U(K,i) / U(K,i+1) ≃ 𝓀[K]` as additive groups, for
`i ≥ 1`. -/
noncomputable def unitFiltrationQuotientSucc (i : ℕ) :
    Additive (unitFiltration K (i + 1) ⧸
        (unitFiltration K (i + 2)).subgroupOf (unitFiltration K (i + 1))) ≃+
      IsLocalRing.ResidueField 𝒪[K] :=
  sorry

/-- **Layer 6A, the local square theorem** (O'Meara 63:1): `U(K, 2e+1) ⊆ (Kˣ)²`. -/
theorem unitFiltration_le_square [Invertible (2 : K)] :
    unitFiltration K (2 * absoluteRamificationIndex K + 1) ≤ Subgroup.square Kˣ :=
  sorry

/-- **Layer 6A, sharpness of the local square theorem.** The bound `2e+1` cannot be
lowered. Over `ℚ_2`, where `e = 1`, the unit `5` lies in `U(ℚ_2, 2)` and is not a
square. -/
theorem not_unitFiltration_le_square [Invertible (2 : K)] :
    ¬ (unitFiltration K (2 * absoluteRamificationIndex K) ≤ Subgroup.square Kˣ) :=
  sorry

/-- **Layer 6A, the square-class group is finite.** -/
instance squareClass_finite [Invertible (2 : K)] : Finite (Kˣ ⧸ Subgroup.square Kˣ) :=
  sorry

/-- **Layer 6A, the square-class count in odd residue characteristic**, together with the
representatives `1, u, π, uπ` for a uniformizer `π` and a unit `u` whose residue is a
nonsquare. -/
theorem card_squareClass_of_odd [Invertible (2 : K)]
    (hodd : absoluteRamificationIndex K = 0) :
    Nat.card (Kˣ ⧸ Subgroup.square Kˣ) = 4 :=
  sorry

/-- **Layer 6A, the square-class count in residue characteristic two**, stated
intrinsically as `4 · q^e` with `q = #𝓀[K]` and `e = v_K(2)`. For a finite extension of
`ℚ_2` of degree `N = e·f` this is `2^{N+2}`, and over `ℚ_2` itself it is `8`, on the
basis `−1, 2, 5`. -/
theorem card_squareClass_of_dyadic [Invertible (2 : K)]
    (h2 : absoluteRamificationIndex K ≠ 0) :
    Nat.card (Kˣ ⧸ Subgroup.square Kˣ) =
      4 * Nat.card (IsLocalRing.ResidueField 𝒪[K]) ^ absoluteRamificationIndex K :=
  sorry

/-- **Layer 6A, the unramified quadratic extension and its norms.** There is a nonsquare
unit `Δ` such that `K(√Δ)/K` is the unramified quadratic extension, and an element is a
norm from it exactly when its valuation is even. The statement is phrased through the
norm equation, so it needs no extension-building API. -/
theorem exists_unramified_class [Invertible (2 : K)] :
    ∃ u : Kˣ, ¬ IsSquare u ∧
      ∀ b : Kˣ, (∃ x y : K, (b : K) = x ^ 2 - (u : K) * y ^ 2) ↔
        Even (Multiplicative.toAdd (normalizedValuation K b)) :=
  sorry

end LocalField

/-! ## Layer 6B: the quadratic defect

Two decisions are fixed here. The carrier of the defect is a fractional ideal, because
for a general `a` the intersection `⋂_ξ (a − ξ²)·𝒪` has negative valuation once
`v(a) < 0`. Its exponent is `⊤` on squares, because the approximation order is then
unbounded. -/

section Defect

open scoped ValuativeRel

variable [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]

/-- **Layer 6B, the quadratic defect**, as a predicate that fixes `𝔡` to be the largest
fractional ideal contained in every `(a − ξ²)·𝒪[K]`. `FractionalIdeal` has a `Lattice`
and no infima of infinite families, so the greatest-lower-bound property is the
definition, and existence is a milestone. -/
def IsQuadraticDefect (a : Kˣ) (𝔡 : FractionalIdeal (nonZeroDivisors 𝒪[K]) K) : Prop :=
  (∀ ξ : K, 𝔡 ≤ FractionalIdeal.spanSingleton _ ((a : K) - ξ ^ 2)) ∧
    ∀ 𝔢 : FractionalIdeal (nonZeroDivisors 𝒪[K]) K,
      (∀ ξ : K, 𝔢 ≤ FractionalIdeal.spanSingleton _ ((a : K) - ξ ^ 2)) → 𝔢 ≤ 𝔡

/-- **Layer 6B, the defect exists and is unique.** Uniqueness is antisymmetry. Existence
is the content: the ideals `(a − ξ²)·𝒪[K]` are totally ordered, so the family has an
infimum. -/
theorem existsUnique_isQuadraticDefect (a : Kˣ) : ∃! 𝔡, IsQuadraticDefect a 𝔡 :=
  sorry

/-- **Layer 6B, the defect** as a function, from the previous milestone. -/
noncomputable def quadraticDefect (a : Kˣ) : FractionalIdeal (nonZeroDivisors 𝒪[K]) K :=
  (existsUnique_isQuadraticDefect a).choose

/-- **Layer 6B, the defect measures squareness**: it vanishes exactly on squares. -/
theorem quadraticDefect_eq_zero_iff (a : Kˣ) : quadraticDefect a = 0 ↔ IsSquare a :=
  sorry

/-- **Layer 6B, the defect scales by squares**, in the fractional-ideal sense. -/
theorem quadraticDefect_mul_sq (a c : Kˣ) :
    quadraticDefect (a * c ^ 2) =
      FractionalIdeal.spanSingleton _ ((c : K) ^ 2) * quadraticDefect a :=
  sorry

/-- **Layer 6B, the defect exponent** `δ(a) = sup_ξ v_K(a − ξ²)`, with `⊤` on squares,
where the supremum is unbounded. -/
noncomputable def defectExponent (a : Kˣ) : WithTop ℤ :=
  sorry

/-- **Layer 6B, the exponent detects squares.** -/
theorem defectExponent_eq_top_iff (a : Kˣ) : defectExponent a = ⊤ ↔ IsSquare a :=
  sorry

/-- **Layer 6B, the exponent under scaling by a square.** -/
theorem defectExponent_mul_sq (a c : Kˣ) :
    defectExponent (a * c ^ 2) =
      defectExponent a + (2 * Multiplicative.toAdd (normalizedValuation K c) : ℤ) :=
  sorry

/-- **Layer 6B, the exponent of an element of odd valuation.** Here
`v_K(a − ξ²) = min(v_K(a), 2 v_K(ξ))` for every `ξ`, because the two valuations have
different parities. -/
theorem defectExponent_of_odd (a : Kˣ)
    (ha : ¬ Even (Multiplicative.toAdd (normalizedValuation K a))) :
    defectExponent a = (Multiplicative.toAdd (normalizedValuation K a) : ℤ) :=
  sorry

/-- **Layer 6B, the possible defects of a unit** (O'Meara 63:2). For a unit that is not a
square, the exponent is `2e` or an odd number below `2e`. -/
theorem defectExponent_unit [Invertible (2 : K)] (u : Kˣ)
    (hu : Multiplicative.toAdd (normalizedValuation K u) = 0) (hsq : ¬ IsSquare u) :
    defectExponent u = ((2 * absoluteRamificationIndex K : ℕ) : ℤ) ∨
      ∃ k : ℕ, k < absoluteRamificationIndex K ∧ defectExponent u = ((2 * k + 1 : ℕ) : ℤ) :=
  sorry

/-- **Layer 6B, the ramification dictionary.** A nonsquare of even exponent is, up to
squares, the unramified class of `exists_unramified_class`. -/
theorem exists_sq_mul_eq_unramified [Invertible (2 : K)] (a : Kˣ) (ha : ¬ IsSquare a)
    (d : ℤ) (hd : defectExponent a = (d : ℤ)) (hev : Even d) :
    ∃ c : Kˣ, defectExponent (a * c ^ 2) = ((2 * absoluteRamificationIndex K : ℕ) : ℤ) :=
  sorry

end Defect

/-! ## Layer 6C: the Hilbert symbol and the local Hasse invariant

The symbol is defined from the norm equation, so its definition needs no classification
of quaternion algebras and no local hypothesis. That is what keeps Layer 6 free of the
circularity "values in `{±1}` because there are two local classes, and there are two
local classes by the symbol". Every theorem below carries the local hypotheses. -/

open Classical in
/-- **Layer 6C, the Hilbert symbol**: `+1` when `b` is a norm from `K(√a)`, and `−1`
otherwise. It is total on `Kˣ × Kˣ`, so no junk-value convention is needed. -/
noncomputable def hilbertSymbol (a b : Kˣ) : ℤˣ :=
  if ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2 then 1 else -1

/-- **Layer 6C, the local Hasse invariant** on a diagonal tuple, in the Lam and Serre
convention `∏_{i<j}`, with the empty product in ranks `0` and `1`. Its codomain is `ℤˣ`,
and it is built from the Hilbert symbol alone, so it exists whether or not Layer 5's
Brauer-valued invariant does. -/
noncomputable def localHasse {n : ℕ} (w : Fin n → Kˣ) : ℤˣ :=
  ∏ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    hilbertSymbol (w ij.1) (w ij.2)

section LocalSymbol

open scoped ValuativeRel

variable [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]
  [Invertible (2 : K)]

/-- **Layer 6C, symmetry** (Serre *CiA* III.1.1). It is proved right after the agreement
of the norm, solvability, and splitting descriptions, so that Serre's orientation and
B11a's orientation are interchangeable from then on. -/
theorem hilbertSymbol_comm (a b : Kˣ) : hilbertSymbol a b = hilbertSymbol b a :=
  sorry

/-- **Layer 6C, evaluation against the unramified class.** For the `Δ` of
`exists_unramified_class`, `(Δ, b)_K = (−1)^{v_K(b)}`. This is the only closed formula
available at this generality. -/
theorem hilbertSymbol_unramified (u : Kˣ)
    (hu : ∀ b : Kˣ, (∃ x y : K, (b : K) = x ^ 2 - (u : K) * y ^ 2) ↔
      Even (Multiplicative.toAdd (normalizedValuation K b))) (b : Kˣ) :
    hilbertSymbol u b = if Even (Multiplicative.toAdd (normalizedValuation K b)) then 1 else -1 :=
  sorry

/-- **Layer 6B, the norm index**, which is the form in which multiplicativity is proved.
For a nonsquare `a`, the norm group of `K(√a)` has index `2` in `Kˣ`: a product of two
non-norms is a norm. -/
theorem hilbertSymbol_mul_of_neg (a : Kˣ) (ha : ¬ IsSquare a) (b c : Kˣ)
    (hb : hilbertSymbol a b = -1) (hc : hilbertSymbol a c = -1) :
    hilbertSymbol a (b * c) = 1 :=
  sorry

/-- **Layer 6C, bimultiplicativity, with the dyadic case included** (Serre *CiA* III
Thm 2; O'Meara 63:11 to 63:13 by the quadratic-defect route). It follows from the norm
index and the indicator lemma. -/
theorem hilbertSymbol_mul (a b c : Kˣ) :
    hilbertSymbol a (b * c) = hilbertSymbol a b * hilbertSymbol a c :=
  sorry

/-- **Layer 6C, nondegeneracy** (Serre *CiA* III Thm 2; O'Meara 63:13). For every
nonsquare `a` some `b` fails to be a norm. The witnesses are listed by defect in the
README. -/
theorem exists_hilbertSymbol_eq_neg_one (a : Kˣ) (ha : ¬ IsSquare a) :
    ∃ b : Kˣ, hilbertSymbol a b = -1 :=
  sorry

/-- **Layer 6C, well-definedness of the local Hasse invariant**, by the Layer 0 descent
principle: permutation invariance from symmetry, and binary invariance from
bimultiplicativity together with the Layer 3 binary quaternion lemma. -/
theorem localHasse_congr {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    localHasse w = localHasse w' :=
  sorry

/-- **Layer 6D, the realization constraints, stated exactly** (O'Meara 63:23, Serre *CiA*
IV Prop 6). Every triple `(n, d, s)` with `n ≥ 1` is realized by a regular form, except
`n = 1` with `s = −1`, and `n = 2` with `d = [−1]` and `s = −1`. The two hypotheses below
are exactly those exclusions. -/
theorem exists_of_realization (n : ℕ) (hn : 1 ≤ n) (d : Kˣ) (s : ℤˣ)
    (h₁ : n = 1 → s = 1) (h₂ : n = 2 → IsSquare (-d) → s = 1) :
    ∃ w : Fin n → Kˣ, IsSquare ((∏ i, w i) * d) ∧ localHasse w = s :=
  sorry

/-- **Layer 6D, the second realization exception is forced.** A binary form of
discriminant `[−1]` is `⟨a, −a⟩` up to isometry, and its Hasse invariant is `+1`. -/
theorem localHasse_of_discr_neg_one (a b : Kˣ) (h : IsSquare (-(a * b))) :
    localHasse ![a, b] = 1 :=
  sorry

/-- **Layer 6D, isotropy in rank 2** (Serre *CiA* IV Thm 6). A binary form is isotropic
exactly when its discriminant is `[−1]`. The other ranks are stated in the README against
the same convention. -/
theorem anisotropic_binary_iff (a b : Kˣ) :
    ¬ (weightedSumSquares K ![(a : K), b]).Anisotropic ↔ IsSquare (-(a * b)) :=
  sorry

/-- **Layer 6D, `u(K) = 4`.** Every form in at least five variables is isotropic, with
the dyadic case included (O'Meara 63:19; Serre *CiA* IV Thm 6(iv)). -/
theorem not_anisotropic_of_five (w : Fin 5 → Kˣ) :
    ¬ (weightedSumSquares K fun i => ((w i : K))).Anisotropic :=
  sorry

/-- **Layer 6D, the anisotropic quaternary form is unique** (O'Meara 63:17-18; Serre
*CiA* IV Thm 7 corollary). The unique class is the norm form of the unique quaternion
division algebra. That consequence is never used to define the symbol. -/
theorem equivalent_of_anisotropic_four (w w' : Fin 4 → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Anisotropic)
    (h' : (weightedSumSquares K fun i => ((w' i : K))).Anisotropic) :
    (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K))) :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 6E, the two Hasse invariants agree.** The quaternion classes over a local
field form a group of order two, by Layer 6D, so the map that sends the class of the
division algebra to `−1` identifies them with `ℤˣ`, and it carries `hasseInvariant` to
`localHasse`. This consumes Layer 5 and Layer 6D, and nothing consumes it. -/
theorem hasseInvariant_eq_localHasse :
    ∃ ε : Subgroup.closure (Set.range fun ab : Kˣ × Kˣ => quaternionClass ab.1 ab.2) →* ℤˣ,
      Function.Injective ε ∧
      ∀ {n : ℕ} (w : Fin n → Kˣ) (h : hasseInvariant w ∈
        Subgroup.closure (Set.range fun ab : Kˣ × Kˣ => quaternionClass ab.1 ab.2)),
        ε ⟨hasseInvariant w, h⟩ = localHasse w :=
  sorry

end LocalSymbol

/-! ### Layer 6 worked examples over `ℚ_2`

These are phrased through the norm equation, so they are readable before any symbol
theory. -/

/-- `(−1,−1)_{ℚ_2} = −1`: `−1` is not a sum of two squares in `ℚ_2`, so Hamilton's
quaternions are a division algebra over `ℚ_2`. -/
example : ¬ ∃ x y : ℚ_[2], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- `(−1,−1)_{ℚ_p} = +1` for odd `p`: `−1` is a sum of two squares in `ℚ_p`. Solve modulo
`p` and lift by Hensel's lemma. -/
example (p : ℕ) [Fact p.Prime] (hp : p ≠ 2) : ∃ x y : ℚ_[p], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- `(2,5)_{ℚ_2} = −1`, the entry of the dyadic table where all four conditions of the
four-fold criterion fail. By Serre's formula the exponent is `ω(5) = 1`. -/
example : ¬ ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 2 * y ^ 2 :=
  sorry

/-- `(5,5)_{ℚ_2} = +1`, the entry where all four conditions hold, with the explicit
witness `5 = 5² − 5·2²`. The `8 × 8` table over `{±1, ±5, ±2, ±10}` is a family of
decidable computations of exactly this shape. This entry needs no `sorry`. -/
example : ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  ⟨5, 2, by norm_num⟩

/-- **The realization exceptions are sharp.** No regular form over `ℚ_2` has
`(n, d, s) = (1, [1], −1)` or `(2, [−1], −1)`, while the neighbouring triple
`(2, [1], −1)` is realized by `⟨−1,−1⟩`: its discriminant `(−1)·(−1)` is the trivial
square class, and its Hasse invariant is `(−1,−1)_{ℚ_2} = −1`. -/
example : (∏ i, ![(-1 : ℚ_[2]ˣ), -1] i) = 1 ∧ localHasse ![(-1 : ℚ_[2]ˣ), -1] = -1 :=
  sorry

/-- **Layer 6D, classification acceptance.** `⟨1,1,1,1⟩`, the norm form of Hamilton's
quaternions, is anisotropic over `ℚ_2` (O'Meara 63:17). -/
example : (weightedSumSquares ℚ_[2] fun _ : Fin 4 => (1 : ℚ_[2])).Anisotropic :=
  sorry

/-! ## Layer 7A: mod-2 Galois cohomology in degrees 1 and 2

The carrier is Mathlib's `continuousCohomology`, applied to the absolute Galois group
with its Krull topology. The operations below are named canonical definitions, each with
the theorems that characterize it. No later statement quantifies over an arbitrary
operation record: a cup product that is identically zero satisfies no fewer axioms than
the intended one, and it would falsify Layer 7C. -/

section GaloisCohomology

variable (K)

/-- The absolute Galois group of `K`, with the Krull topology. -/
abbrev absoluteGaloisGroup : Type u := SeparableClosure K ≃ₐ[K] SeparableClosure K

/-- **Layer 7A, the mod-2 coefficient object**: `𝔽₂` with the trivial action, as a
representation of `G_K` on a topological module. -/
noncomputable def mod2Coeff : Action (TopModuleCat.{u} (ZMod 2)) (absoluteGaloisGroup K) :=
  sorry

/-- **Layer 7A, the multiplicative coefficient object**: `Kˢˣ` written additively, with
the Galois action. -/
noncomputable def unitsCoeff : Action (TopModuleCat.{u} ℤ) (absoluteGaloisGroup K) :=
  sorry

/-- **Layer 7A, the coefficient bridge** `μ₂ ≃ ZMod 2`, Galois-equivariantly. It needs
`2` invertible, and it is what lets the mod-2 groups be stated with constant
coefficients. -/
noncomputable def mu2EquivZMod2 [Invertible (2 : K)] :
    (rootsOfUnity 2 (SeparableClosure K)) ≃* Multiplicative (ZMod 2) :=
  sorry

/-- `Hⁿ_cont(G_K, 𝔽₂)`, as Mathlib's continuous cohomology. -/
noncomputable def contH (n : ℕ) : TopModuleCat.{u} (ZMod 2) :=
  (continuousCohomology (ZMod 2) (absoluteGaloisGroup K) n).obj (mod2Coeff K)

/-- `Hⁿ_cont(G_K, Additive Kˢˣ)`. -/
noncomputable def contHUnits (n : ℕ) : TopModuleCat.{u} ℤ :=
  (continuousCohomology ℤ (absoluteGaloisGroup K) n).obj (unitsCoeff K)

/-- `H¹(G_K, 𝔽₂)`. -/
noncomputable abbrev H1 : Type u := (contH K 1 : Type u)

/-- `H²(G_K, 𝔽₂)`. -/
noncomputable abbrev H2 : Type u := (contH K 2 : Type u)

/-- `H²(G_K, Additive Kˢˣ)`, the cohomological Brauer group. -/
noncomputable abbrev H2Units : Type u := (contHUnits K 2 : Type u)

/-- **Layer 7A, the cup product** `H¹ × H¹ → H²`. -/
noncomputable def cup11 : H1 K →+ H1 K →+ H2 K :=
  sorry

/-- **Layer 7A, the Kummer isomorphism** `Kˣ/(Kˣ)² ≃ H¹(G_K, 𝔽₂)`, through the
coefficient bridge. -/
noncomputable def kummerIso [Invertible (2 : K)] :
    Additive (Kˣ ⧸ Subgroup.square Kˣ) ≃+ H1 K :=
  sorry

variable {K}

/-- The Kummer class `(a) ∈ H¹(G_K, 𝔽₂)` of a unit. -/
noncomputable def kummerClass [Invertible (2 : K)] (a : Kˣ) : H1 K :=
  kummerIso K (Additive.ofMul (QuotientGroup.mk a))

variable (K)

/-- **Layer 7A, the map induced by `μ₂ ⊆ Kˢˣ`**, from the Kummer sequence. -/
noncomputable def h2MuToUnits [Invertible (2 : K)] : H2 K →+ H2Units K :=
  sorry

/-- It is injective, by Hilbert 90. -/
theorem h2MuToUnits_injective [Invertible (2 : K)] :
    Function.Injective (h2MuToUnits K) :=
  sorry

/-- Its image is the 2-torsion. -/
theorem h2MuToUnits_range [Invertible (2 : K)] (x : H2Units K) :
    (∃ y, h2MuToUnits K y = x) ↔ x + x = 0 :=
  sorry

end GaloisCohomology

/-! ### Layer 7A: restriction, corestriction, and the index-two Evens norm

Each map is attached to a `K`-embedding `σ : L → Kˢ`, which is what identifies `G_L`
with an open subgroup of `G_K`. Independence of `σ` is a theorem, not an assumption. -/

section Transfer

variable (K) (L : Type u) [Field L] [Algebra K L] [FiniteDimensional K L]
  [Algebra.IsSeparable K L]

/-- **Layer 7A, restriction in degree 1**, along the open subgroup that `σ` determines. -/
noncomputable def res1 (σ : L →ₐ[K] SeparableClosure K) : H1 K →+ H1 L :=
  sorry

/-- **Layer 7A, restriction in degree 2.** -/
noncomputable def res2 (σ : L →ₐ[K] SeparableClosure K) : H2 K →+ H2 L :=
  sorry

/-- **Layer 7A, corestriction in degree 1.** -/
noncomputable def cor1 (σ : L →ₐ[K] SeparableClosure K) : H1 L →+ H1 K :=
  sorry

/-- **Layer 7A, corestriction in degree 2.** -/
noncomputable def cor2 (σ : L →ₐ[K] SeparableClosure K) : H2 L →+ H2 K :=
  sorry

/-- **Layer 7A, restriction on the multiplicative coefficients**, which the coefficient
compatibility below compares against. -/
noncomputable def res2Units (σ : L →ₐ[K] SeparableClosure K) : H2Units K →+ H2Units L :=
  sorry

/-- **Layer 7A, the Evens norm at index two.** The Evens norm multiplies degree by the
index, so a map `H¹(G_L) → H²(G_K)` exists exactly in the index-two case. The degree
hypothesis is part of the signature. -/
noncomputable def evensIndexTwo (σ : L →ₐ[K] SeparableClosure K)
    (hdeg : Module.finrank K L = 2) : H1 L → H2 K :=
  sorry

variable {K L}

/-- **Layer 7A, the conjugate class** at index two, represented through `res ∘ cor`. -/
noncomputable def conjClass (σ : L →ₐ[K] SeparableClosure K) (hdeg : Module.finrank K L = 2)
    (y : H1 L) : H1 L :=
  res1 K L σ (cor1 K L σ y) - y

/-- Restriction is the base change of square classes. -/
theorem res1_kummerClass [Invertible (2 : K)] [Invertible (2 : L)]
    (σ : L →ₐ[K] SeparableClosure K) (a : Kˣ) :
    res1 K L σ (kummerClass a) = kummerClass (Units.map (algebraMap K L : K →* L) a) :=
  sorry

/-- Corestriction is the norm on square classes. -/
theorem cor1_kummerClass [Invertible (2 : K)] [Invertible (2 : L)]
    (σ : L →ₐ[K] SeparableClosure K) (a : Lˣ) :
    cor1 K L σ (kummerClass a) = kummerClass (Units.map (Algebra.norm K : L →* K) a) :=
  sorry

/-- Restriction preserves cup products. -/
theorem res2_cup (σ : L →ₐ[K] SeparableClosure K) (x y : H1 K) :
    res2 K L σ (cup11 K x y) = cup11 L (res1 K L σ x) (res1 K L σ y) :=
  sorry

/-- At index two, `res ∘ cor` is the sum over the two conjugates. -/
theorem res1_cor1 (σ : L →ₐ[K] SeparableClosure K) (hdeg : Module.finrank K L = 2)
    (y : H1 L) :
    res1 K L σ (cor1 K L σ y) = y + conjClass σ hdeg y :=
  sorry

/-- The projection formula. -/
theorem cor2_cup (σ : L →ₐ[K] SeparableClosure K) (x : H1 K) (y : H1 L) :
    cor2 K L σ (cup11 L (res1 K L σ x) y) = cup11 K x (cor1 K L σ y) :=
  sorry

/-- The restriction of an Evens norm is the cup with the conjugate class. -/
theorem res2_evens (σ : L →ₐ[K] SeparableClosure K) (hdeg : Module.finrank K L = 2)
    (x : H1 L) :
    res2 K L σ (evensIndexTwo K L σ hdeg x) = cup11 L x (conjClass σ hdeg x) :=
  sorry

/-- The Evens norm fails additivity by the corestriction of a cup with the **conjugate**
class. This is the identity that Layer 9 uses, and the conjugate is not optional. -/
theorem evens_add (σ : L →ₐ[K] SeparableClosure K) (hdeg : Module.finrank K L = 2)
    (x y : H1 L) :
    evensIndexTwo K L σ hdeg (x + y) =
      evensIndexTwo K L σ hdeg x + evensIndexTwo K L σ hdeg y +
        cor2 K L σ (cup11 L x (conjClass σ hdeg y)) :=
  sorry

/-- Compatibility of the coefficient map with restriction. -/
theorem h2MuToUnits_res2 [Invertible (2 : K)] [Invertible (2 : L)]
    (σ : L →ₐ[K] SeparableClosure K) (x : H2 K) :
    h2MuToUnits L (res2 K L σ x) = res2Units K L σ (h2MuToUnits K x) :=
  sorry

/-- Restriction and corestriction are functorial in a tower `M/L/K`. -/
theorem res1_comp {M : Type u} [Field M] [Algebra K M] [Algebra L M] [IsScalarTower K L M]
    [FiniteDimensional L M] [Algebra.IsSeparable L M]
    (σ : L →ₐ[K] SeparableClosure K) (τ : M →ₐ[L] SeparableClosure L)
    (υ : M →ₐ[K] SeparableClosure K) :
    res1 L M τ ∘ res1 K L σ = res1 K M υ :=
  sorry

/-- **Independence of the embedding.** Two `K`-embeddings of `L` give conjugate open
subgroups, and the induced maps on cohomology agree. Every statement below is therefore
about `L/K` and not about a chosen embedding. -/
theorem res1_embedding_independent (σ τ : L →ₐ[K] SeparableClosure K) :
    res1 K L σ = res1 K L τ :=
  sorry

theorem cor1_embedding_independent (σ τ : L →ₐ[K] SeparableClosure K) :
    cor1 K L σ = cor1 K L τ :=
  sorry

theorem evens_embedding_independent (σ τ : L →ₐ[K] SeparableClosure K)
    (hdeg : Module.finrank K L = 2) :
    evensIndexTwo K L σ hdeg = evensIndexTwo K L τ hdeg :=
  sorry

end Transfer

/-! ## Layer 7B: the comparison of the Brauer group with `H²` -/

section BrauerComparison

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras

variable (K)

/-- The 2-torsion subgroup of the Brauer group. -/
noncomputable def Br2 : Subgroup (BrauerGroup.{u, u} K) :=
  MonoidHom.ker (powMonoidHom 2 : BrauerGroup.{u, u} K →* BrauerGroup.{u, u} K)

/-- **Layer 7B, the crossed-product comparison**, as a named canonical equivalence.
Multiplication of Brauer classes goes to addition of cohomology classes, which is what
`≃+` records. -/
noncomputable def brauerCohomologyEquiv :
    Additive (BrauerGroup.{u, u} K) ≃+ H2Units K :=
  sorry

/-- **Layer 7B, the 2-torsion comparison**, `ι` in the README. -/
noncomputable def brauer2EquivH2 [Invertible (2 : K)] :
    Additive ↥(Br2 K) ≃+ H2 K :=
  sorry

variable {K}

/-- The two comparisons agree on 2-torsion, through the coefficient map. -/
theorem brauer2EquivH2_h2MuToUnits [Invertible (2 : K)] (x : ↥(Br2 K)) :
    h2MuToUnits K (brauer2EquivH2 K (Additive.ofMul x)) =
      brauerCohomologyEquiv K (Additive.ofMul (x : BrauerGroup.{u, u} K)) :=
  sorry

/-- **Layer 7B, the symbol as a cup product.** The quaternion class is 2-torsion by
`quaternionClass_sq`, and its image is the cup of the two Kummer classes. -/
theorem brauer2EquivH2_quaternionClass [Invertible (2 : K)] (a b : Kˣ)
    (h : quaternionClass a b ∈ Br2 K) :
    brauer2EquivH2 K (Additive.ofMul ⟨quaternionClass a b, h⟩) =
      cup11 K (kummerClass a) (kummerClass b) :=
  sorry

end BrauerComparison

/-! ## Layer 7C: the symbol as a cup product -/

/-- **Layer 7C, the fifth equivalent condition.** The cup product of two Kummer classes
vanishes exactly when the four conditions of Layer 2 hold. This is stated against the
canonical cup product, so a zero pairing cannot satisfy it. -/
theorem cup_kummerClass_eq_zero_iff [Invertible (2 : K)] (a b : Kˣ) :
    cup11 K (kummerClass a) (kummerClass b) = 0 ↔
      ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2 :=
  sorry

/-! ## Layer 8: Stiefel-Whitney classes in degrees 1 and 2 -/

/-- **Layer 8, the first Stiefel-Whitney class** of a diagonal tuple,
`w₁(q) = ∑ᵢ (aᵢ) = (d(q))`, with the plain discriminant. -/
noncomputable def sw1 [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) : H1 K :=
  ∑ i, kummerClass (w i)

/-- **Layer 8, the second Stiefel-Whitney class** of a diagonal tuple,
`w₂(q) = ∑_{i<j} (aᵢ)(aⱼ)`. -/
noncomputable def sw2 [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) : H2 K :=
  ∑ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    cup11 K (kummerClass (w ij.1)) (kummerClass (w ij.2))

/-- **Layer 8, well-definedness of the Stiefel-Whitney classes**, by the Layer 0 descent
principle. The binary step is the cup identity `(a)(b) = (c)(d)` for `⟨a,b⟩ ≅ ⟨c,d⟩`,
which is `cup_kummerClass_eq_zero_iff` together with Layer 0's binary criterion. -/
theorem sw_congr [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    sw1 w = sw1 w' ∧ sw2 w = sw2 w' :=
  sorry

/-- **Layer 8, the orthogonal-sum identities**, stated degreewise, since this roadmap has
no total class. -/
theorem sw_append [Invertible (2 : K)] {m n : ℕ} (w : Fin m → Kˣ) (w' : Fin n → Kˣ) :
    sw1 (Fin.append w w') = sw1 w + sw1 w' ∧
      sw2 (Fin.append w w') = sw2 w + sw2 w' + cup11 K (sw1 w) (sw1 w') :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 8, `w₂` is the image of the Hasse invariant** under the canonical `ι` of
Layer 7B. Both sides are defined on a diagonalization. -/
theorem brauer2EquivH2_hasseInvariant [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ)
    (h : hasseInvariant w ∈ Br2 K) :
    brauer2EquivH2 K (Additive.ofMul ⟨hasseInvariant w, h⟩) = sw2 w :=
  sorry

open TauCetiRoadmap.RepresentationTheory.SemisimpleAlgebras in
/-- **Layer 8, the comparison with the Clifford invariant** (Lam V.3.20 read in
cohomology), with the exponents `A_n` and `B_n` of the README. -/
theorem brauer2EquivH2_cliffordInvariant [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ)
    (h : cliffordInvariant w ∈ Br2 K) :
    brauer2EquivH2 K (Additive.ofMul ⟨cliffordInvariant w, h⟩) =
      sw2 w + ((n - 1) * (n - 2) / 2 : ℕ) •
          cup11 K (kummerClass (-1)) (sw1 w) +
        ((n + 1) * n * (n - 1) * (n - 2) / 24 : ℕ) •
          cup11 K (kummerClass (-1)) (kummerClass (-1)) :=
  sorry

/-- **Layer 8, acceptance examples.** `w₁⟨a⟩ = (a)` and `w₂⟨a⟩ = 0`; and
`w₂⟨a,b⟩ = (a) ∪ (b)`. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    sw1 ![a] = kummerClass a ∧ sw2 ![a] = 0 ∧
      sw2 ![a, b] = cup11 K (kummerClass a) (kummerClass b) :=
  sorry

/-! ## Layer 9: the Scharlau transfer and the Evens-Kahn identity -/

/-- **Layer 9, the nonzero functionals form an `Lˣ`-torsor.** `Hom_K(L,K)` is
one-dimensional over `L` under `(λ · s) x = s (λ x)`, so any two nonzero functionals
differ by a unique unit. This is what makes the change-of-functional theorem compare
every two choices. -/
example {L : Type v} [Field L] [Algebra K L] [FiniteDimensional K L]
    (s s' : L →ₗ[K] K) (hs : s ≠ 0) (hs' : s' ≠ 0) :
    ∃! lam : Lˣ, ∀ x : L, s' x = s ((lam : L) * x) :=
  sorry

/-- **Layer 9, the Scharlau transfer** of a form over `L` along a `K`-functional. This is
Mathlib's `LinearMap.compQuadraticMap'` at `R = L` and `S = K`, that is postcomposition
with `s` and restriction of scalars. The milestones are its properties, that is rank,
regularity, additivity, Frobenius reciprocity, and change of functional, and not the
construction. -/
def scharlauTransfer {L : Type v} [Field L] [Algebra K L] {V : Type v} [AddCommGroup V]
    [Module L V] [Module K V] [IsScalarTower K L V] (s : L →ₗ[K] K)
    (q : QuadraticForm L V) : QuadraticForm K V :=
  s.compQuadraticMap' q

/-- **Layer 9, the transfer preserves hyperbolic forms.** A Lagrangian stays a
Lagrangian, so `s_*` descends to `W(L) → W(K)`. The descended map is additive and is a
`W(K)`-module map by Frobenius reciprocity. It is **not** a ring map. -/
example {L : Type v} [Field L] [Algebra K L] [FiniteDimensional K L] [Invertible (2 : K)]
    (s : L →ₗ[K] K) (hs : s ≠ 0) (m : ℕ) (hm : Module.finrank K L = m) :
    (scharlauTransfer s (weightedSumSquares L ![(1 : L), -1])).Equivalent
      (weightedSumSquares K (Sum.elim (fun _ : Fin m => (1 : K)) fun _ : Fin m => (-1 : K))) :=
  sorry

/-- **Layer 9, the transfer of `⟨1⟩` along the trace, diagonalized.** For the quadratic
algebra `K[√d]` the trace form is `⟨2, 2d⟩` on the basis `{1, √d}`. -/
example [Invertible (2 : K)] (d : Kˣ) :
    (LinearMap.BilinMap.toQuadraticMap
        (Algebra.traceForm K (QuadraticAlgebra K (d : K) 0))).Equivalent
      (weightedSumSquares K ![(2 : K), 2 * d]) :=
  sorry

/-- **Layer 9, the Evens-Kahn identity in degrees 1 and 2**, which is the statement that
`gq2`'s B9 consumes (Kahn, Invent. Math. 78 (1984), Théorème 2 in degrees `≤ 2`). The
extension is quadratic and separable, `t` presents the trace form `Tr_*⟨1⟩`, `b` presents
the twisted trace form `Tr_*⟨a⟩`, and the transfer maps are the canonical ones attached
to `L/K`. -/
theorem evensKahn_deg_two {L : Type u} [Field L] [Algebra K L] [FiniteDimensional K L]
    [Algebra.IsSeparable K L] [Invertible (2 : K)] [Invertible (2 : L)]
    (hdeg : Module.finrank K L = 2) (σ : L →ₐ[K] SeparableClosure K)
    (a : Lˣ) (t b : Fin 2 → Kˣ)
    (ht : (weightedSumSquares K fun i => ((t i : K))).Equivalent
      (LinearMap.BilinMap.toQuadraticMap (Algebra.traceForm K L)))
    (hb : (weightedSumSquares K fun i => ((b i : K))).Equivalent
      (scharlauTransfer (Algebra.trace K L) (weightedSumSquares L ![(a : L)]))) :
    sw1 b = sw1 t + cor1 K L σ (kummerClass a) ∧
      sw2 b = sw2 t + evensIndexTwo K L σ hdeg (kummerClass a) +
        cup11 K (sw1 t) (cor1 K L σ (kummerClass a)) :=
  sorry

/-! ## Consumed-interface checks

These confirm that the API this roadmap consumes says what the statements above assume.
They are not milestones. -/

/-- Consumed from Mathlib: `ℍ[ℝ]` is a division ring, which is the archimedean instance
`(−1,−1)_ℝ = −1` of the split-or-division dichotomy. -/
example (x : ℍ[ℝ]) (hx : x ≠ 0) : IsUnit x := hx.isUnit

/-- Consumed from Mathlib: the trace form of a finite separable extension is
nondegenerate, which is what makes the trace a legitimate default functional in
Layer 9. -/
example {L : Type v} [Field L] [Algebra K L] [FiniteDimensional K L] [Algebra.IsSeparable K L] :
    (Algebra.traceForm K L).Nondegenerate :=
  traceForm_nondegenerate K L

end TauCetiRoadmap.QuadraticFormInvariants
