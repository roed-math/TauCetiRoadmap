import Mathlib

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

The carrier is Mathlib's `BrauerGroup K`. What Mathlib lacks is the group structure,
which the semisimple-algebras roadmap supplies, and the central simplicity of quaternion
algebras, which is a milestone of Layer 5. `BrauerData` carries exactly those, so the
quaternion class below is the class of `ℍ[K,a,b]` and not an abstract symbol. -/

/-- **Layer 5, the Brauer-group data.** -/
structure BrauerData (K : Type u) [Field K] where
  /-- The `CommGroup` structure induced by `⊗_K`, from the semisimple-algebras roadmap. -/
  commGroup : CommGroup (BrauerGroup.{u, u} K)
  /-- Quaternion algebras are central over `K`. -/
  isCentral : ∀ a b : Kˣ, Algebra.IsCentral K ℍ[K, (a : K), (b : K)]
  /-- Quaternion algebras are simple. -/
  isSimple : ∀ a b : Kˣ, IsSimpleRing ℍ[K, (a : K), (b : K)]
  /-- Quaternion algebras are finite-dimensional. -/
  finDim : ∀ a b : Kˣ, FiniteDimensional K ℍ[K, (a : K), (b : K)]

/-- The quaternion algebra as a central simple algebra. -/
noncomputable def BrauerData.quaternionCSA (S : BrauerData K) (a b : Kˣ) : CSA.{u, u} K :=
  letI := S.isCentral a b
  letI := S.isSimple a b
  letI := S.finDim a b
  { toAlgCat := AlgCat.of K ℍ[K, (a : K), (b : K)] }

/-- **Layer 5, the quaternion symbol** `[(a,b)] = ⟦ℍ[K,a,b]⟧` in `BrauerGroup K`. -/
noncomputable def BrauerData.cls (S : BrauerData K) (a b : Kˣ) : BrauerGroup.{u, u} K :=
  Quotient.mk _ (S.quaternionCSA a b)

/-- **Layer 5, symmetry of the symbol.** -/
example (S : BrauerData K) (a b : Kˣ) : S.cls a b = S.cls b a :=
  sorry

/-- **Layer 5, the symbol is 2-torsion**, from `ℍ[K,a,b]ᵒᵖ ≃ₐ[K] ℍ[K,a,b]` through
`star`. -/
example (S : BrauerData K) (a b : Kˣ) :
    letI := S.commGroup
    S.cls a b ^ 2 = 1 :=
  sorry

/-- **Layer 5, bilinearity of the symbol** (Gille-Szamuely 1.5.2 for the statement,
Lam III.2.11 for the linkage). -/
example (S : BrauerData K) (a b c : Kˣ) :
    letI := S.commGroup
    S.cls a (b * c) = S.cls a b * S.cls a c :=
  sorry

/-- **Layer 5, the symbol on equivalent binary forms.** This is the Layer 3 binary
quaternion lemma read in `BrauerGroup K`, and it is what the descent of the Hasse
invariant uses. It is a theorem about the quaternion class, and it does not follow from
symmetry, 2-torsion, and bilinearity alone. -/
example [Invertible (2 : K)] (S : BrauerData K) (a b c d : Kˣ)
    (h : (weightedSumSquares K ![(a : K), b]).Equivalent
      (weightedSumSquares K ![(c : K), d])) :
    S.cls a b = S.cls c d :=
  sorry

/-- **Layer 5, the Steinberg relation** for `a : Kˣ` with `1 − a ≠ 0`. -/
example (S : BrauerData K) (a : Kˣ) (h : (1 : K) - a ≠ 0) :
    letI := S.commGroup
    S.cls a (Units.mk0 ((1 : K) - a) h) = 1 :=
  sorry

/-- **Layer 5, the Hasse invariant** on a diagonal tuple, in the Lam and Serre convention
`∏_{i<j}`, with the empty product in ranks `0` and `1`. -/
noncomputable def hasseInvariant (S : BrauerData K) {n : ℕ} (w : Fin n → Kˣ) :
    BrauerGroup.{u, u} K :=
  letI := S.commGroup
  ∏ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    S.cls (w ij.1) (w ij.2)

/-- **Layer 5, well-definedness of the Hasse invariant**, by the Layer 0 descent
principle: permutation invariance from symmetry, and binary invariance from bilinearity
together with the milestone above on equivalent binary forms. -/
example [Invertible (2 : K)] (S : BrauerData K) {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    hasseInvariant S w = hasseInvariant S w' :=
  sorry

/-- **Layer 5, the orthogonal-sum formula** (Lam p. 119):
`s(q ⊥ r) = s(q) · s(r) · [(d(q), d(r))]`. -/
example (S : BrauerData K) {m n : ℕ} (w : Fin m → Kˣ) (w' : Fin n → Kˣ) :
    letI := S.commGroup
    hasseInvariant S (Fin.append w w') =
      hasseInvariant S w * hasseInvariant S w' * S.cls (∏ i, w i) (∏ i, w' i) :=
  sorry

/-- **Layer 5, the scaling formula** (Lam V.3.16):
`s(λ • q) = s(q) · [(λ, −1)]^{n(n−1)/2} · [(λ, d(q))]^{n−1}`. It is written out because
each source states it in a different convention. -/
example (S : BrauerData K) {n : ℕ} (lam : Kˣ) (w : Fin n → Kˣ) :
    letI := S.commGroup
    hasseInvariant S (fun i => lam * w i) =
      hasseInvariant S w * S.cls lam (-1) ^ (n * (n - 1) / 2) *
        S.cls lam (∏ i, w i) ^ (n - 1) :=
  sorry

/-! ## Layer 6A: the local-field toolkit

Mathlib's `IsNonarchimedeanLocalField` supplies `𝒪[K]`, `𝓂[K]`, `𝓀[K]`, the discrete
valuation ring structure, and finiteness of the residue field. It supplies no normalized
valuation, no unit filtration, and no square-class arithmetic. The structure below states
those, and its fields determine it: the valuation and the filtration are pinned by
`val_nonneg_iff`, `val_unif`, `filt_zero`, and `filt_succ`. Layer 6A proves that a
nonarchimedean local field carries a term, and that the term is unique. -/

open scoped ValuativeRel in
/-- **Layer 6A, the local-field toolkit.** -/
structure LocalFieldToolkit (K : Type u) [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] where
  /-- The normalized valuation `v_K : Kˣ →* Multiplicative ℤ`. -/
  val : Kˣ →* Multiplicative ℤ
  /-- The valuation is onto, so the value group is `ℤ`. -/
  val_surjective : Function.Surjective val
  /-- Nonnegative valuation describes the ring of integers. This pins `val`. -/
  val_nonneg_iff : ∀ x : Kˣ, 0 ≤ Multiplicative.toAdd (val x) ↔ (x : K) ∈ 𝒪[K]
  /-- A uniformizer. -/
  unif : Kˣ
  /-- The uniformizer has valuation one. -/
  val_unif : val unif = Multiplicative.ofAdd 1
  /-- `2` as a unit of `K`; the standing hypothesis makes `2` invertible. -/
  two : Kˣ
  /-- Its coercion is `2`. -/
  two_coe : (two : K) = 2
  /-- The absolute ramification index `e = v_K(2)`. -/
  e : ℕ
  /-- The defining equation of `e`. -/
  val_two : val two = Multiplicative.ofAdd (e : ℤ)
  /-- The unit filtration `U(K, i)`. -/
  filt : ℕ → Subgroup Kˣ
  /-- `U(K,0)` is the group of units of `𝒪[K]`. -/
  filt_zero : ∀ x : Kˣ, x ∈ filt 0 ↔ Multiplicative.toAdd (val x) = 0
  /-- `U(K,i+1)` is the group of units congruent to `1` modulo `𝓂[K]^{i+1}`. The
  quantifier is vacuous at `x = 1`, where `x − 1` is not a unit. This pins `filt`. -/
  filt_succ : ∀ (i : ℕ) (x : Kˣ), x ∈ filt (i + 1) ↔
    x ∈ filt 0 ∧ ∀ y : Kˣ, (y : K) = (x : K) - 1 → (i + 1 : ℤ) ≤ Multiplicative.toAdd (val y)

section LocalField

variable [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]

/-- **Layer 6A, the toolkit exists.** The valuation comes from
`IsDiscreteValuationRing.addVal` on `𝒪[K]`, and the filtration from the congruence
description. -/
example : Nonempty (LocalFieldToolkit K) :=
  sorry

/-- **Layer 6A, the toolkit is unique.** The fields above determine every component, so a
theorem stated for an arbitrary term is a theorem about the canonical one. -/
example (T T' : LocalFieldToolkit K) : T = T' :=
  sorry

/-- **Layer 6A, the local square theorem** (O'Meara 63:1): `U(K, 2e+1) ⊆ (Kˣ)²`. -/
example (T : LocalFieldToolkit K) : T.filt (2 * T.e + 1) ≤ Subgroup.square Kˣ :=
  sorry

/-- **Layer 6A, sharpness of the local square theorem.** The bound `2e+1` cannot be
lowered. Over `ℚ_2`, where `e = 1`, the unit `5` lies in `U(ℚ_2, 2)` and is not a
square. -/
example (T : LocalFieldToolkit K) : ¬ (T.filt (2 * T.e) ≤ Subgroup.square Kˣ) :=
  sorry

open scoped ValuativeRel in
/-- **Layer 6A, the filtration quotients.** `𝒪[K]ˣ / U(K,1) ≅ 𝓀[K]ˣ`, and
`U(K,i) / U(K,i+1) ≅ 𝓀[K]` as additive groups for `i ≥ 1`. -/
example (T : LocalFieldToolkit K) (i : ℕ) :
    Nat.card (T.filt (i + 1) ⧸ (T.filt (i + 2)).subgroupOf (T.filt (i + 1))) =
      Nat.card (IsLocalRing.ResidueField 𝒪[K]) :=
  sorry

/-- **Layer 6A, the square-class count in odd residue characteristic.** -/
example (T : LocalFieldToolkit K) (hodd : T.e = 0) :
    Nat.card (Kˣ ⧸ Subgroup.square Kˣ) = 4 :=
  sorry

/-- **Layer 6A, the square-class count in the dyadic case.** For `K/ℚ_2` of degree `N`,
the square-class group has order `2^{N+2}`. Over `ℚ_2` itself this is `8`, on the basis
`−1, 2, 5`. -/
example [Algebra ℚ_[2] K] [FiniteDimensional ℚ_[2] K] (T : LocalFieldToolkit K) :
    Nat.card (Kˣ ⧸ Subgroup.square Kˣ) = 2 ^ (Module.finrank ℚ_[2] K + 2) :=
  sorry

end LocalField

/-! ## Layer 6B: the quadratic defect

The defect is the object on which O'Meara's route to bimultiplicativity runs. Two
decisions are fixed here. Its carrier is a fractional ideal, because for a general `a`
the intersection `⋂_ξ (a − ξ²)·𝒪` has negative valuation once `v(a) < 0`; and its
exponent is `⊤` on squares, because the approximation order is then unbounded. -/

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
example (a : Kˣ) : ∃! 𝔡, IsQuadraticDefect a 𝔡 :=
  sorry

/-- **Layer 6B, the defect measures squareness**: it vanishes exactly on squares. -/
example (a : Kˣ) : IsQuadraticDefect a 0 ↔ IsSquare a :=
  sorry

/-- **Layer 6B, the defect scales by squares**, in the fractional-ideal sense. -/
example (a c : Kˣ) (𝔡 : FractionalIdeal (nonZeroDivisors 𝒪[K]) K)
    (h : IsQuadraticDefect a 𝔡) :
    IsQuadraticDefect (a * c ^ 2)
      (FractionalIdeal.spanSingleton _ ((c : K) ^ 2) * 𝔡) :=
  sorry

/-- **Layer 6B, the defect exponent** `δ(a) = sup_ξ v_K(a − ξ²)`, with `⊤` on squares,
where the supremum is unbounded. Every later statement about the parity of `δ` carries
the hypothesis that `a` is not a square. -/
noncomputable def defectExponent (T : LocalFieldToolkit K) (a : Kˣ) : WithTop ℤ :=
  sorry

/-- **Layer 6B, the exponent detects squares.** -/
example (T : LocalFieldToolkit K) (a : Kˣ) : defectExponent T a = ⊤ ↔ IsSquare a :=
  sorry

/-- **Layer 6B, the exponent under scaling by a square.** -/
example (T : LocalFieldToolkit K) (a c : Kˣ) :
    defectExponent T (a * c ^ 2) =
      defectExponent T a + (2 * Multiplicative.toAdd (T.val c) : ℤ) :=
  sorry

/-- **Layer 6B, the exponent of an element of odd valuation.** Here
`v_K(a − ξ²) = min(v_K(a), 2 v_K(ξ))` for every `ξ`, because the two valuations have
different parities. -/
example (T : LocalFieldToolkit K) (a : Kˣ) (ha : ¬ Even (Multiplicative.toAdd (T.val a))) :
    defectExponent T a = (Multiplicative.toAdd (T.val a) : ℤ) :=
  sorry

/-- **Layer 6B, the ramification dictionary.** For a nonsquare `a`, the extension
`K(√a)/K` is unramified exactly when `δ(a)` is even. The statement below is the form the
symbol computation uses: a nonsquare of even exponent is, up to squares, the unramified
class of Layer 6C. -/
example (T : LocalFieldToolkit K) (a : Kˣ) (ha : ¬ IsSquare a) (d : ℤ)
    (hd : defectExponent T a = (d : ℤ)) (hev : Even d) :
    ∃ c : Kˣ, defectExponent T (a * c ^ 2) = ((2 * T.e : ℕ) : ℤ) :=
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

variable [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]

/-- **Layer 6C, symmetry** (Serre *CiA* III.1.1). It is proved right after the agreement
of the norm, solvability, and splitting descriptions, so that Serre's orientation and
B11a's orientation are interchangeable from then on. -/
example (T : LocalFieldToolkit K) (a b : Kˣ) : hilbertSymbol a b = hilbertSymbol b a :=
  sorry

/-- **Layer 6C, evaluation against the unramified class.** There is a nonsquare unit `Δ`
with `(Δ, b)_K = (−1)^{v_K(b)}` for every `b`. It is the class of defect `4𝒪[K]`, and the
formula is the unramified norm computation of Layer 6A read through the norm description
of the symbol. This is the only closed formula available at this generality. -/
example (T : LocalFieldToolkit K) :
    ∃ u : Kˣ, ¬ IsSquare u ∧
      ∀ b : Kˣ, hilbertSymbol u b = if Even (Multiplicative.toAdd (T.val b)) then 1 else -1 :=
  sorry

/-- **Layer 6B, the norm index**, which is the form in which multiplicativity is proved.
For a nonsquare `a`, the norm group of `K(√a)` has index `2` in `Kˣ`. Here the norm group
is spelled through the norm equation, and the statement is that a product of two
non-norms is a norm. -/
example (T : LocalFieldToolkit K) (a : Kˣ) (ha : ¬ IsSquare a) :
    ∀ b c : Kˣ, hilbertSymbol a b = -1 → hilbertSymbol a c = -1 →
      hilbertSymbol a (b * c) = 1 :=
  sorry

/-- **Layer 6C, bimultiplicativity, with the dyadic case included** (Serre *CiA* III
Thm 2; O'Meara 63:11 to 63:13 by the quadratic-defect route). It follows from the norm
index and the indicator lemma. -/
example (T : LocalFieldToolkit K) (a b c : Kˣ) :
    hilbertSymbol a (b * c) = hilbertSymbol a b * hilbertSymbol a c :=
  sorry

/-- **Layer 6C, nondegeneracy** (Serre *CiA* III Thm 2; O'Meara 63:13). For every
nonsquare `a` some `b` fails to be a norm. The witnesses are listed by defect in the
README. -/
example (T : LocalFieldToolkit K) (a : Kˣ) (ha : ¬ IsSquare a) :
    ∃ b : Kˣ, hilbertSymbol a b = -1 :=
  sorry

/-- **Layer 6C, well-definedness of the local Hasse invariant**, by the Layer 0 descent
principle: permutation invariance from symmetry, and binary invariance from
bimultiplicativity together with the Layer 3 binary quaternion lemma. -/
example (T : LocalFieldToolkit K) {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    localHasse w = localHasse w' :=
  sorry

/-- **Layer 6D, the realization constraints, stated exactly** (O'Meara 63:23, Serre *CiA*
IV Prop 6). Every triple `(n, d, s)` with `n ≥ 1` is realized by a regular form, except
`n = 1` with `s = −1`, and `n = 2` with `d = [−1]` and `s = −1`. The two hypotheses below
are exactly those exclusions. Here `IsSquare (-d)` spells `d = [−1]` in `Kˣ/(Kˣ)²`, and
`IsSquare ((∏ i, w i) * d)` spells "the discriminant of `w` is `d`". -/
example (T : LocalFieldToolkit K) (n : ℕ) (hn : 1 ≤ n) (d : Kˣ) (s : ℤˣ)
    (h₁ : n = 1 → s = 1) (h₂ : n = 2 → IsSquare (-d) → s = 1) :
    ∃ w : Fin n → Kˣ, IsSquare ((∏ i, w i) * d) ∧ localHasse w = s :=
  sorry

/-- **Layer 6D, the second realization exception is forced.** A binary form of
discriminant `[−1]` is `⟨a, −a⟩` up to isometry, and its Hasse invariant is `+1`. -/
example (T : LocalFieldToolkit K) (a b : Kˣ) (h : IsSquare (-(a * b))) :
    localHasse ![a, b] = 1 :=
  sorry

/-- **Layer 6D, isotropy in rank 2** (Serre *CiA* IV Thm 6). A binary form is isotropic
exactly when its discriminant is `[−1]`. The other ranks are stated in the README against
the same convention: rank 3 uses `s = (−1, −d)`, rank 4 uses `d ≠ [1] ∨ s = (−1,−1)`, and
rank at least 5 is unconditional. -/
example (T : LocalFieldToolkit K) (a b : Kˣ) :
    ¬ (weightedSumSquares K ![(a : K), b]).Anisotropic ↔ IsSquare (-(a * b)) :=
  sorry

/-- **Layer 6D, `u(K) = 4`.** Every form in at least five variables is isotropic, with
the dyadic case included (O'Meara 63:19; Serre *CiA* IV Thm 6(iv)). -/
example (T : LocalFieldToolkit K) (w : Fin 5 → Kˣ) :
    ¬ (weightedSumSquares K fun i => ((w i : K))).Anisotropic :=
  sorry

/-- **Layer 6D, the anisotropic quaternary form is unique** (O'Meara 63:17-18; Serre
*CiA* IV Thm 7 corollary). The unique class is the norm form of the unique quaternion
division algebra, from which "there are exactly two quaternion algebras locally" follows.
That consequence is never used to define the symbol. -/
example (T : LocalFieldToolkit K) (w w' : Fin 4 → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Anisotropic)
    (h' : (weightedSumSquares K fun i => ((w' i : K))).Anisotropic) :
    (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K))) :=
  sorry

/-- **Layer 6E, the comparison of the two Hasse invariants.** The quaternion classes over
a local field form a group of order two, by Layer 6D, so the map that sends the class of
the division algebra to `−1` identifies them with `ℤˣ`, and it carries `hasseInvariant`
to `localHasse`. This statement needs Layer 5 and Layer 6D, and nothing consumes it. -/
example [Invertible (2 : K)] (T : LocalFieldToolkit K) (S : BrauerData K) {n : ℕ}
    (w : Fin n → Kˣ) :
    letI := S.commGroup
    ∃ ε : Subgroup.closure (Set.range fun ab : Kˣ × Kˣ => S.cls ab.1 ab.2) →* ℤˣ,
      Function.Injective ε ∧
      ∀ (v : Fin n → Kˣ) (h : hasseInvariant S v ∈
        Subgroup.closure (Set.range fun ab : Kˣ × Kˣ => S.cls ab.1 ab.2)),
        ε ⟨hasseInvariant S v, h⟩ = localHasse v :=
  sorry

end LocalSymbol

/-! ### Layer 6 worked examples over `ℚ_2`

These are phrased through the norm equation, so they are readable before any symbol
theory, and they do not need the toolkit. -/

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

/-! ## Layer 7A: mod-2 Galois cohomology

The carrier is Mathlib's `continuousCohomology`, applied to the absolute Galois group
with its Krull topology. What Mathlib lacks in the pinned revision is the low-degree
calculational API: the Kummer isomorphism, the cup product, restriction, corestriction,
and the index-2 Evens norm. `Mod2GaloisOps` and `Mod2GaloisTransferOps` carry exactly
those operations, together with the laws that Layers 7 to 9 use. -/

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

end GaloisCohomology

/-- **Layer 7A, the low-degree operations.** These are the milestones that a development
of continuous cohomology supplies; the carriers above are already canonical. -/
structure Mod2GaloisOps (K : Type u) [Field K] where
  /-- The cup product `H¹ × H¹ → H²`. -/
  cup : H1 K →+ H1 K →+ H2 K
  /-- The Kummer isomorphism `Kˣ/(Kˣ)² ≃ H¹(G_K, 𝔽₂)`. -/
  kummer : Additive (Kˣ ⧸ Subgroup.square Kˣ) ≃+ H1 K
  /-- The map induced by `μ₂ ⊆ Kˢˣ`, from the Kummer sequence and Hilbert 90. -/
  toUnits : H2 K →+ H2Units K
  /-- It is injective. -/
  toUnits_injective : Function.Injective toUnits
  /-- Its image is the 2-torsion. -/
  toUnits_range : ∀ x : H2Units K, (∃ y, toUnits y = x) ↔ x + x = 0

/-- The Kummer class `(a) ∈ H¹(G_K, 𝔽₂)` of a unit. -/
noncomputable def kummerClass (D : Mod2GaloisOps K) (a : Kˣ) : H1 K :=
  D.kummer (Additive.ofMul (QuotientGroup.mk a))

/-- **Layer 7A, the transfer operations** for a finite separable `L/K`, with the laws
that the Evens-Kahn identity uses. The Evens norm is a function and not a homomorphism,
and `evens_add` records that failure. -/
structure Mod2GaloisTransferOps (K L : Type u) [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [Algebra.IsSeparable K L]
    (DK : Mod2GaloisOps K) (DL : Mod2GaloisOps L) where
  /-- Restriction in degree 1. -/
  res1 : H1 K →+ H1 L
  /-- Restriction in degree 2. -/
  res2 : H2 K →+ H2 L
  /-- Corestriction in degree 1. -/
  cor1 : H1 L →+ H1 K
  /-- Corestriction in degree 2. -/
  cor2 : H2 L →+ H2 K
  /-- The Evens norm. -/
  evens : H1 L → H2 K
  /-- Restriction is the base change of square classes. -/
  res1_kummer : ∀ a : Kˣ,
    res1 (kummerClass DK a) = kummerClass DL (Units.map (algebraMap K L : K →* L) a)
  /-- Corestriction is the norm on square classes. -/
  cor1_kummer : ∀ a : Lˣ,
    cor1 (kummerClass DL a) = kummerClass DK (Units.map (Algebra.norm K : L →* K) a)
  /-- The projection formula. -/
  projection : ∀ (x : H1 K) (y : H1 L), cor2 (DL.cup (res1 x) y) = DK.cup x (cor1 y)
  /-- The restriction of an Evens norm is a cup with the conjugate class; at index two
  the conjugate of `x` appears through `res1 ∘ cor1`. -/
  evens_res : ∀ x : H1 L, res2 (evens x) = DL.cup x (res1 (cor1 x) - x)
  /-- The Evens norm fails additivity by a corestriction term. -/
  evens_add : ∀ x y : H1 L, evens (x + y) = evens x + evens y + cor2 (DL.cup x y)

/-! ## Layer 7B: the comparison of the Brauer group with `H²` -/

/-- **Layer 7B, the crossed-product comparison.** Multiplication of Brauer classes goes
to addition of cohomology classes, so the comparison is an `≃+` out of
`Additive (BrauerGroup K)`. The construction consumes the finite separable splitting
field of the semisimple-algebras roadmap, its Galois closure, and the finite-quotient
description of continuous cohomology. -/
example (S : BrauerData K) :
    letI := S.commGroup
    Nonempty (Additive (BrauerGroup.{u, u} K) ≃+ H2Units K) :=
  sorry

/-- **Layer 7B, the 2-torsion comparison and the symbol.** The composite `ι` identifies
the 2-torsion of the Brauer group with `H²(G_K, 𝔽₂)`, and it carries the quaternion class
to the cup product of the two Kummer classes. -/
example (S : BrauerData K) (D : Mod2GaloisOps K) :
    letI := S.commGroup
    ∃ ι : Additive (BrauerGroup.{u, u} K) →+ H2Units K,
      Function.Injective ι ∧
      ∀ a b : Kˣ, ι (Additive.ofMul (S.cls a b)) =
        D.toUnits (D.cup (kummerClass D a) (kummerClass D b)) :=
  sorry

/-! ## Layer 7C: the symbol as a cup product -/

/-- **Layer 7C, the fifth equivalent condition.** The cup product of two Kummer classes
vanishes exactly when the four conditions of Layer 2 hold. Given Layer 7B this is the
last step of the cyclic computation together with the four-fold criterion, and it
completes B11a's five-fold statement. -/
example (D : Mod2GaloisOps K) (a b : Kˣ) :
    D.cup (kummerClass D a) (kummerClass D b) = 0 ↔
      ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2 :=
  sorry

/-! ## Layer 8: Stiefel-Whitney classes in degrees 1 and 2 -/

/-- **Layer 8, the first Stiefel-Whitney class** of a diagonal tuple,
`w₁(q) = ∑ᵢ (aᵢ) = (d(q))`, with the plain discriminant. -/
noncomputable def sw1 (D : Mod2GaloisOps K) {n : ℕ} (w : Fin n → Kˣ) : H1 K :=
  ∑ i, kummerClass D (w i)

/-- **Layer 8, the second Stiefel-Whitney class** of a diagonal tuple,
`w₂(q) = ∑_{i<j} (aᵢ)(aⱼ)`. -/
noncomputable def sw2 (D : Mod2GaloisOps K) {n : ℕ} (w : Fin n → Kˣ) : H2 K :=
  ∑ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    D.cup (kummerClass D (w ij.1)) (kummerClass D (w ij.2))

/-- **Layer 8, well-definedness of the Stiefel-Whitney classes**, by the Layer 0 descent
principle. The binary step is the cup identity `(a)(b) = (c)(d)` for `⟨a,b⟩ ≅ ⟨c,d⟩`,
which is Layer 7C applied to Layer 0's binary criterion. -/
example [Invertible (2 : K)] (D : Mod2GaloisOps K) {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    sw1 D w = sw1 D w' ∧ sw2 D w = sw2 D w' :=
  sorry

/-- **Layer 8, `w₂` is the image of the Hasse invariant.** Both sides are defined on a
diagonalization, so the identity follows from the symbol computation of Layer 7B. The
Hasse invariant is a product and `w₂` is a sum, so the statement transports through
`Additive`. -/
example (S : BrauerData K) (D : Mod2GaloisOps K) {n : ℕ} (w : Fin n → Kˣ) :
    letI := S.commGroup
    ∀ ι : Additive (BrauerGroup.{u, u} K) →+ H2Units K,
      (∀ a b : Kˣ, ι (Additive.ofMul (S.cls a b)) =
        D.toUnits (D.cup (kummerClass D a) (kummerClass D b))) →
      ι (Additive.ofMul (hasseInvariant S w)) = D.toUnits (sw2 D w) :=
  sorry

/-- **Layer 8, acceptance examples.** `w₁⟨a⟩ = (a)` and `w₂⟨a⟩ = 0`; and
`w₂⟨a,b⟩ = (a) ∪ (b)`. -/
example (D : Mod2GaloisOps K) (a b : Kˣ) :
    sw1 D ![a] = kummerClass D a ∧ sw2 D ![a] = 0 ∧
      sw2 D ![a, b] = D.cup (kummerClass D a) (kummerClass D b) :=
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
algebra `K[√d]` the trace form is `⟨2, 2d⟩` on the basis `{1, √d}`. Prove it through
`TauCeti/FieldTheory/Trace`'s diagonalization API. The twisted forms `Tr_*⟨a⟩` are what
Kahn's identity evaluates. -/
example [Invertible (2 : K)] (d : Kˣ) :
    (LinearMap.BilinMap.toQuadraticMap
        (Algebra.traceForm K (QuadraticAlgebra K (d : K) 0))).Equivalent
      (weightedSumSquares K ![(2 : K), 2 * d]) :=
  sorry

/-- **Layer 9, the Evens-Kahn identity in degrees 1 and 2**, which is the statement that
`gq2`'s B9 consumes (Kahn, Invent. Math. 78 (1984), Théorème 2 in degrees `≤ 2`). Here
`L/K` is quadratic, `t` presents the trace form `Tr_*⟨1⟩`, and `b` presents the twisted
trace form `Tr_*⟨a⟩`. The identities are `w₁(Tr_*⟨a⟩) = t₁ + cor(x)` and
`w₂(Tr_*⟨a⟩) = t₂ + N^{Ev}(x) + t₁ ∪ cor(x)` with `x = (a)`. -/
example {L : Type u} [Field L] [Algebra K L] [FiniteDimensional K L]
    [Algebra.IsSeparable K L] [Invertible (2 : K)] (hdeg : Module.finrank K L = 2)
    (DK : Mod2GaloisOps K) (DL : Mod2GaloisOps L) (T : Mod2GaloisTransferOps K L DK DL)
    (a : Lˣ) (t b : Fin 2 → Kˣ)
    (ht : (weightedSumSquares K fun i => ((t i : K))).Equivalent
      (LinearMap.BilinMap.toQuadraticMap (Algebra.traceForm K L)))
    (hb : (weightedSumSquares K fun i => ((b i : K))).Equivalent
      (scharlauTransfer (Algebra.trace K L) (weightedSumSquares L ![(a : L)]))) :
    sw1 DK b = sw1 DK t + T.cor1 (kummerClass DL a) ∧
      sw2 DK b = sw2 DK t + T.evens (kummerClass DL a) +
        DK.cup (sw1 DK t) (T.cor1 (kummerClass DL a)) :=
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
