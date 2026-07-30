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

This file pins targets for the cohomology-free part of the roadmap — **Layer 0**
(diagonal calculus, representation, the binary equivalence criterion), **Layer 1**
(hyperbolic planes, Witt decomposition, Witt cancellation), **Layer 2** (quaternion
norm forms, the split/division dichotomy, the four-fold splitting criterion — the
B11a shape), **Layer 3** (discriminant invariance), **Layer 6** (the Hilbert symbol
over `ℚ_p` in norm-equation form: dyadic examples, bimultiplicativity,
nondegeneracy, square-class counts, and the local classification shapes), and the
**Layer 9** transfer entry point (the trace form of a quadratic algebra). They
elaborate against the pinned Mathlib and are stated with `sorry` (allowed in this
human-owned roadmap library). The cohomological layers — the Kummer cup bridge
(Layer 7), Stiefel–Whitney classes (Layer 8), and the Evens–Kahn formula
(Layer 9's summit) — consume the profinite-cohomology roadmap and stay prose-only
here: continuous cohomology does not exist at the pinned Mathlib, so their types are
not yet expressible. As the sibling roadmaps land their APIs, add those milestones
here with `sorry`.

Layer-6 conventions follow Serre (*A Course in Arithmetic*, ch. III–IV); the symbol
statements are phrased through the norm equation `b = x² − a·y²`, which is available
before any symbol is defined. See `README.md` for the convention table (Lam/Serre
Hasse invariant `∏_{i<j}`, signed discriminant, value dictionaries) and for the
coordination notes on the in-motion `HassePrinciple` and central-simple-algebra
developments.
-/

namespace TauCetiRoadmap.QuadraticFormInvariants

open QuadraticMap
open scoped Quaternion

universe u v

variable {K : Type u} [Field K]

/-! ## Layer 0: diagonal calculus and the binary equivalence criterion -/

/-- **Non-vacuity worked example.** `⟨1,1⟩` and `⟨1,−1⟩` are inequivalent over `ℚ`:
the first is anisotropic (positive definite), the second is the hyperbolic plane. -/
example :
    ¬ (weightedSumSquares ℚ ![(1 : ℚ), 1]).Equivalent (weightedSumSquares ℚ ![(1 : ℚ), -1]) :=
  sorry

/-- **Layer 0, the representation criterion** (Lam I.3.5). A regular diagonal form
represents a unit `a` iff `⟨−a⟩ ⊥ q` is isotropic. This is the engine turning
value-set questions into isotropy questions. -/
example [Invertible (2 : K)] {n : ℕ} (w : Fin n → Kˣ) (a : Kˣ) :
    (∃ x : Fin n → K, weightedSumSquares K (fun i => ((w i : K))) x = a) ↔
      ¬ (weightedSumSquares K (Fin.cons (-(a : K)) fun i => ((w i : K)))).Anisotropic :=
  sorry

/-- **Layer 0, the binary equivalence criterion** (Lam I.5.1): two regular binary
diagonal forms are equivalent iff they have the same discriminant in square classes
(`IsSquare (a*b*(c*d))`, the quotient-free spelling — see
`TauCeti.squareClass_eq_zero_iff`) and represent a common unit. This is the "one
binary move" that Witt's chain-equivalence theorem (Lam I.5.2, the well-definedness
engine for all diagonal invariants) reduces every equivalence of diagonal forms to. -/
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
Proved via hyperplane reflections (Lam I.4.5–4.7); the reflection generation of the
orthogonal group lands in the same layer. -/
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

/-- **Layer 2, the split/division dichotomy** (Lam III.2.2, 2.7): a quaternion
algebra over a field is a division algebra or is isomorphic to `M₂(K)`. Consume
Mathlib PR #41538 (`ℍ[K,a,b]` is central simple) and state so this refactors onto
FLT's `IsQuaternionAlgebra` when that predicate reaches Mathlib. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    (∀ x : ℍ[K, (a : K), (b : K)], x ≠ 0 → IsUnit x) ∨
      Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K) :=
  sorry

/-- **Layer 2, the four-fold splitting criterion — the roadmap's first summit and
`gq2` B11a's shape** (Lam III.2.7, Serre *CiA* III.1.1–1.2, Gille–Szamuely 1.1.9).
For `a, b ∈ Kˣ`, TFAE: (1) `ℍ[K,a,b]` splits; (2) `b` is a norm of the quadratic
algebra `K[√a]` (Mathlib's `QuadraticAlgebra K a 0`); (3) `b = x² − ay²` has a
solution; (4) `⟨1, −a, −b⟩` is isotropic. When `a` is a square all four hold, so no
non-square hypothesis is carried. The fifth equivalence — vanishing of the Kummer
cup `(a) ∪ (b)` — is Layer 7, stated once the profinite-cohomology roadmap's
`H²(G_K, μ₂)` exists. -/
example [Invertible (2 : K)] (a b : Kˣ) :
    [Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K),
      ∃ z : QuadraticAlgebra K (a : K) 0, QuadraticAlgebra.norm z = (b : K),
      ∃ x y : K, (b : K) = x ^ 2 - (a : K) * y ^ 2,
      ¬ (weightedSumSquares K ![(1 : K), -(a : K), -(b : K)]).Anisotropic].TFAE :=
  sorry

/-- **Layer 2 → 3, the binary move on quaternion symbols**: equivalent binary forms
have isomorphic quaternion algebras. This is the one nontrivial step in the
chain-equivalence well-definedness of the Hasse invariant
`s(⟨a₁,…,aₙ⟩) = ∏_{i<j} (aᵢ, aⱼ)` (Lam V.3.17–3.18). -/
example [Invertible (2 : K)] (a b c d : Kˣ)
    (h : (weightedSumSquares K ![(a : K), b]).Equivalent
      (weightedSumSquares K ![(c : K), d])) :
    Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] ℍ[K, (c : K), (d : K)]) :=
  sorry

/-! ## Layer 3: classical invariants (discriminant) -/

/-- **Layer 3, discriminant invariance**: equivalent regular diagonal forms have the
same discriminant in square classes (quotient-free spelling; the signed discriminant
`d± = (−1)^{n(n−1)/2} d` then transports along the same statement since the
dimensions agree). Route: determinants of Gram matrices under `basisRepr`. -/
example [Invertible (2 : K)] {n : ℕ} (w w' : Fin n → Kˣ)
    (h : (weightedSumSquares K fun i => ((w i : K))).Equivalent
      (weightedSumSquares K fun i => ((w' i : K)))) :
    IsSquare ((∏ i, w i) * ∏ i, w' i) :=
  sorry

/-! ## Layer 6: the Hilbert symbol over `ℚ_p` and the local classification

Symbol statements are phrased through the norm equation `b = x² − a·y²` (condition
(3) of the four-fold criterion), so they are expressible before any symbol function
is defined. Conventions: Serre *CiA* ch. III; coordinate with the in-motion
`HassePrinciple` project (see `README.md`). -/

/-- **Layer 6 worked example: `(−1,−1)_{ℚ_2} = −1`** — `−1` is not a sum of two
squares in `ℚ_2` (Hamilton's quaternions are division over `ℚ_2`). -/
example : ¬ ∃ x y : ℚ_[2], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- **Layer 6 worked example: `(−1,−1)_{ℚ_p} = 1` for odd `p`** — `−1` is a sum of
two squares in `ℚ_p` (solve mod `p`, lift by Hensel). -/
example (p : ℕ) [Fact p.Prime] (hp : p ≠ 2) : ∃ x y : ℚ_[p], x ^ 2 + y ^ 2 = -1 :=
  sorry

/-- **Layer 6 worked example: `(2,5)_{ℚ_2} = −1`** — an entry of the dyadic 8×8
table with a ramified entry: by Serre's formula the exponent is `ω(5) = 1`. -/
example : ¬ ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 2 * y ^ 2 :=
  sorry

/-- **Layer 6 worked example: `(5,5)_{ℚ_2} = 1`, with explicit witness**
`5 = 5² − 5·2²`. The 8×8 table over `{±1, ±5, ±2, ±10}` is a family of decidable
computations of exactly this shape (this entry needs no `sorry`). -/
example : ∃ x y : ℚ_[2], (5 : ℚ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  ⟨5, 2, by norm_num⟩

/-- **Layer 6, the dyadic square-class count**: `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8`, with
representatives `{±1, ±5, ±2, ±10}` (Serre *CiA* II.3.3). Stated through
`Subgroup.square`; interoperates with `TauCeti.SquareClassGroup`. -/
example : Nat.card (ℚ_[2]ˣ ⧸ Subgroup.square ℚ_[2]ˣ) = 8 :=
  sorry

/-- **Layer 6, the odd square-class count**: `#(ℚ_pˣ/(ℚ_pˣ)²) = 4` for odd `p`,
with representatives `{1, u, p, up}` (Serre *CiA* II.3.3). -/
example (p : ℕ) [Fact p.Prime] (hp : p ≠ 2) :
    Nat.card (ℚ_[p]ˣ ⧸ Subgroup.square ℚ_[p]ˣ) = 4 :=
  sorry

/-- **Layer 6, bimultiplicativity of the Hilbert symbol — the hard dyadic-inclusive
input** (Serre *CiA* III Thm 2; O'Meara 63:11–63:13 for the pinned
quadratic-defect route). In norm-equation form: `(a, bc) = (a,b)·(a,c)` becomes an
iff-of-iffs, valid over every `ℚ_p` including `p = 2`. -/
example (p : ℕ) [Fact p.Prime] {a b c : ℚ_[p]} (ha : a ≠ 0) (hb : b ≠ 0)
    (hc : c ≠ 0) :
    (∃ x y : ℚ_[p], b * c = x ^ 2 - a * y ^ 2) ↔
      ((∃ x y : ℚ_[p], b = x ^ 2 - a * y ^ 2) ↔ ∃ x y : ℚ_[p], c = x ^ 2 - a * y ^ 2) :=
  sorry

/-- **Layer 6, nondegeneracy of the Hilbert pairing** (Serre *CiA* III Thm 2;
O'Meara 63:13): for every non-square `a` some `b` fails to be a norm from
`ℚ_p(√a)`. Equivalently `(ℚ_pˣ : N(ℚ_p(√a)ˣ)) = 2` — the norm-index form is a
separate milestone; the mod-2 Tate-duality reading of this statement is the
local-fields roadmap's bridge milestone, cited there. -/
example (p : ℕ) [Fact p.Prime] {a : ℚ_[p]} (ha : a ≠ 0) (h : ¬ IsSquare a) :
    ∃ b : ℚ_[p], b ≠ 0 ∧ ¬ ∃ x y : ℚ_[p], b = x ^ 2 - a * y ^ 2 :=
  sorry

/-- **Layer 6, classification acceptance (existence half)**: `⟨1,1,1,1⟩` — the norm
form of Hamilton's quaternions — is anisotropic over `ℚ_2` (O'Meara 63:17). -/
example : (weightedSumSquares ℚ_[2] fun _ : Fin 4 => (1 : ℚ_[2])).Anisotropic :=
  sorry

/-- **Layer 6, classification acceptance (uniqueness half)**: any two anisotropic
quaternary forms over `ℚ_2` are equivalent (O'Meara 63:18; Serre *CiA* IV Thm 7
corollary) — the unique class is the norm form of the unique quaternion division
algebra. The full classification of regular forms by `(dim, d, s)` (O'Meara 63:20,
63:23) is the layer's main theorem, stated once the Hasse invariant exists. -/
example (w w' : Fin 4 → ℚ_[2]ˣ)
    (h : (weightedSumSquares ℚ_[2] fun i => ((w i : ℚ_[2]))).Anisotropic)
    (h' : (weightedSumSquares ℚ_[2] fun i => ((w' i : ℚ_[2]))).Anisotropic) :
    (weightedSumSquares ℚ_[2] fun i => ((w i : ℚ_[2]))).Equivalent
      (weightedSumSquares ℚ_[2] fun i => ((w' i : ℚ_[2]))) :=
  sorry

/-- **Layer 6, `u(ℚ_p) = 4`**: every form in at least five variables over `ℚ_p` is
isotropic, dyadic case included (O'Meara 63:19; Serre *CiA* IV Thm 6(iv)). -/
example (p : ℕ) [Fact p.Prime] (w : Fin 5 → ℚ_[p]ˣ) :
    ¬ (weightedSumSquares ℚ_[p] fun i => ((w i : ℚ_[p]))).Anisotropic :=
  sorry

/-! ## Layer 9 (transfer half, cohomology-free): the trace form -/

/-- **Layer 9, the transfer of `⟨1⟩` along the trace, diagonalized**: for the
quadratic algebra `K[√d]`, the trace form is `⟨2, 2d⟩` on the basis `{1, √d}`.
Prove through `TauCeti/FieldTheory/Trace`'s diagonalization API. The Scharlau
transfer along a general nonzero functional, Frobenius reciprocity, and the
change-of-functional lemma are the layer's definitional milestones (README); the
Evens–Kahn identity for `w(Tr_* q)` is stated once the profinite-cohomology
roadmap's Stiefel–Whitney layer exists. -/
example [Invertible (2 : K)] (d : Kˣ) :
    (LinearMap.BilinMap.toQuadraticMap
        (Algebra.traceForm K (QuadraticAlgebra K (d : K) 0))).Equivalent
      (weightedSumSquares K ![(2 : K), 2 * d]) :=
  sorry

/-! ## Consumed-fact check (no new mathematics)

Mathlib already knows `ℍ[ℝ]` is a division ring — the archimedean instance
`(−1,−1)_ℝ = −1` of the split/division dichotomy; recorded here as the model for
the `ℚ_2` instance above. -/

example (x : ℍ[ℝ]) (hx : x ≠ 0) : IsUnit x := hx.isUnit

end TauCetiRoadmap.QuadraticFormInvariants
