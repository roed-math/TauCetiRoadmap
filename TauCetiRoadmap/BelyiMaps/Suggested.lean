import Mathlib

/-!
# Belyi maps, dessins d'enfants, and three-point covers: target signatures

**This file is not the roadmap, and it is not exhaustive.** The definitive document is
`README.md`, which numbers the milestones as Layer `n.m`. The statements here suggest Lean
forms for particular milestones, so that contributors and reviewers agree on names and
signatures. Discharging all of them finishes neither a layer nor the roadmap.

What is prototyped here, in preference to end theorems, are the objects whose choice of
carrier, index type, or map determines everything below them: the permutation-triple carrier
with its pinned product relation, the relabeling action, dessins as bipartite ribbon graphs,
triangle groups, the thrice-punctured sphere with its concrete peripheral loops, the
monodromy homomorphism, the analytic Belyi-pair carrier, and the profinite peripheral
objects with the pro-`ℓ` peripheral-power theorem. Every declaration elaborates against the
pinned Mathlib. Proofs are `sorry` where the milestone is the proof; data is real wherever
the formula is the convention being pinned.

Conventions, recorded in `README.md` (§Pinned conventions):

* Multiplication is Mathlib's: `(σ * τ) x = σ (τ x)` in `Equiv.Perm`, and `γ * δ` in
  `FundamentalGroup` is "`δ` first, then `γ`" (`End.mul_def`). The product relation is
  `σinf * σ1 * σ0 = 1`, and the monodromy homomorphism of Layer 5.3 is a genuine
  `MonoidHom` with no `ᵐᵒᵖ`. The `z ↦ z²` example below pins the interpretation.
* Relabeling is the left conjugation `MulAction`; isomorphism is `MulAction.orbitRel`.
* Cycle data always includes fixed points: `fullCycleType` below is a local stand-in for
  the PolynomialGaloisGroups declaration of the same name and definition, and is replaced
  by it when that roadmap lands. Mathlib's bare `Equiv.Perm.cycleType` is never compared
  with a partition of `n`.
* Connectedness of a triple includes `n ≠ 0`; `MulAction.IsPretransitive` alone is
  vacuously true on `Fin 0`.
* The genus is defined only after the Euler-characteristic bounds; the `Int.toNat` in
  `genus` is made junk-free by `two_sub_two_mul_genus`.
* Peripheral elements: `P`, `T` are the images of the free generators, `C := (T * P)⁻¹`,
  so `C * T * P = 1` — the same display order as the triple relation. A source writing
  `P·T·C = 1` names a conjugate of this `C`; see README §Pinned conventions.
* The two sorried `instance`s on `OnePoint ℂ` (charted space, manifold) are the Layer 8.1
  milestones; they are declared as instances so that the analytic carriers below can be
  stated, and they are implemented by the Riemann-sphere milestone, not by consumers.
* Layers 9–11 (algebraic Belyi pairs, Belyi's theorem, fields of moduli) have no Lean
  prototypes here: their statements need the AlgebraicCurves carriers, and the honest-`sorry`
  rule keeps milestones whose *statements* cannot yet be formed out of this file.
* A literal `PermutationTriple n` is the invariant of a **fiber-numbered** cover
  (`FiberNumberedCover` below), not of a pointed one: a chosen point of the fiber leaves
  `(n−1)!` relabelings. README Layer 6.3 classifies the three rigidifications separately.
* `SemilocallySimplyConnectedSpace` below is a local stand-in for UniversalCovers
  Stage 0.2's class of the same name, absent from the pinned Mathlib. Layer 6.2's
  associated-cover theorem carries it because the universal-cover construction requires it.
* `proPKernel` and `maximalProPQuotient` below are local elaboration stand-ins mirroring
  the ProPGroups roadmap's pinned shapes (its Layer 3), and are replaced by that roadmap's
  declarations when it lands, as are `freeProfiniteTwo` (its `freeProfiniteGroup (Fin 2)`)
  and `zhat` (its `zHat`).
-/

open scoped Manifold ContDiff Topology Pointwise

namespace TauCetiRoadmap.BelyiMaps

universe u v

/-! ## Layer 0: permutation triples -/

/-- **Layer 0.1.** A degree-`n` permutation triple, with the pinned relation
`σinf * σ1 * σ0 = 1` in Mathlib's multiplication: the concatenated loop
"`γ0`, then `γ1`, then `γ∞`" is nullhomotopic, and monodromy is covariant. -/
@[ext]
structure PermutationTriple (n : ℕ) where
  σ0 : Equiv.Perm (Fin n)
  σ1 : Equiv.Perm (Fin n)
  σinf : Equiv.Perm (Fin n)
  product_eq_one : σinf * σ1 * σ0 = 1

namespace PermutationTriple

variable {n : ℕ}

/-- **Layer 0.1.** The constructor from the first two components. -/
def ofTwo (σ0 σ1 : Equiv.Perm (Fin n)) : PermutationTriple n where
  σ0 := σ0
  σ1 := σ1
  σinf := (σ1 * σ0)⁻¹
  product_eq_one := by group

@[simp] theorem ofTwo_σ0 (σ0 σ1 : Equiv.Perm (Fin n)) : (ofTwo σ0 σ1).σ0 = σ0 := rfl
@[simp] theorem ofTwo_σ1 (σ0 σ1 : Equiv.Perm (Fin n)) : (ofTwo σ0 σ1).σ1 = σ1 := rfl
@[simp] theorem ofTwo_σinf (σ0 σ1 : Equiv.Perm (Fin n)) :
    (ofTwo σ0 σ1).σinf = (σ1 * σ0)⁻¹ := rfl

/-- **Layer 0.1.** `σinf` is determined by the other two components. -/
theorem σinf_eq (t : PermutationTriple n) : t.σinf = (t.σ1 * t.σ0)⁻¹ := by
  have h := t.product_eq_one
  rw [mul_assoc] at h
  exact eq_inv_of_mul_eq_one_left h

/-- **Layer 0.1.** Extensionality on the first two components. -/
theorem ext_of_two {t t' : PermutationTriple n} (h0 : t.σ0 = t'.σ0) (h1 : t.σ1 = t'.σ1) :
    t = t' := by
  ext1
  · exact h0
  · exact h1
  · rw [t.σinf_eq, t'.σinf_eq, h0, h1]

/-- **Layer 0.1.** A triple is exactly a pair of permutations: the third component is
determined. This is the `Equiv` that carries the `Fintype` and `DecidableEq` instances, and
the one Layer 3.1's enumeration runs on. -/
def equivPair (n : ℕ) : PermutationTriple n ≃ Equiv.Perm (Fin n) × Equiv.Perm (Fin n) where
  toFun t := (t.σ0, t.σ1)
  invFun p := ofTwo p.1 p.2
  left_inv _ := ext_of_two rfl rfl
  right_inv _ := rfl

/-- **Layer 0.1.** Finiteness, computably, through `equivPair`. -/
instance : Fintype (PermutationTriple n) :=
  Fintype.ofEquiv _ (equivPair n).symm

/-- **Layer 0.1.** Decidable equality, computably, through `ext_of_two`. -/
instance : DecidableEq (PermutationTriple n) := fun t t' =>
  decidable_of_iff (t.σ0 = t'.σ0 ∧ t.σ1 = t'.σ1)
    ⟨fun h => ext_of_two h.1 h.2, fun h => h ▸ ⟨rfl, rfl⟩⟩

/-- **Layer 0.1, the opposite-convention translation.** Componentwise inversion is the
bijection with triples for the rival relation `σ0 * σ1 * σinf = 1`; it preserves cycle
types, monodromy, connectedness, and automorphisms (README, Layer 0.1). -/
theorem inv_components_reverse (t : PermutationTriple n) :
    t.σ0⁻¹ * t.σ1⁻¹ * t.σinf⁻¹ = 1 := by
  have h := t.product_eq_one
  have : (t.σinf * t.σ1 * t.σ0)⁻¹ = 1 := by rw [h]; simp
  simpa [mul_inv_rev, mul_assoc] using this

/-- **Layer 0.1, the convention-pinning example.** The monodromy triple of `z ↦ z²`:
`σ0 = σinf = (0 1)`, `σ1 = 1`. -/
example : (ofTwo (Equiv.swap 0 1) 1 : PermutationTriple 2).σinf = Equiv.swap 0 1 := by
  simp

/-! ### The LMFDB translation, machine-checked

The frozen LMFDB record `3T2-3_2.1_2.1-a` (`PROVENANCE.md`) stores the triple
`(1,2,3)`, `(2,3)`, `(1,2)`, which `0`-indexed is `finRotate 3`, `swap 1 2`, `swap 0 1`.
Because the database composes permutations left to right, that stored triple satisfies the
**opposite** relation in Mathlib's multiplication — and its componentwise inverse, the
Layer 0.1 involution, is a triple in this roadmap's convention. The two `decide`s below are
the machine-checked form of Layer 14.2's translation lemma on one record; a record whose
data is symmetric under the swap (`σ1 = σ0`, `σinf = 1`) would check both relations and
verify nothing. -/

/-- The stored LMFDB triple satisfies `σ0 * σ1 * σinf = 1`, not this roadmap's relation. -/
example : finRotate 3 * Equiv.swap 1 2 * Equiv.swap 0 1 = 1 := by decide

/-- It does **not** satisfy this roadmap's relation: the two conventions really differ. -/
example : Equiv.swap 0 1 * Equiv.swap 1 2 * finRotate 3 ≠ 1 := by decide

/-- The componentwise inverse does satisfy this roadmap's relation. -/
example : Equiv.swap 0 1 * Equiv.swap 1 2 * (finRotate 3)⁻¹ = 1 := by decide

/-- The frozen record as a `PermutationTriple` in this roadmap's convention. -/
def lmfdb3T2 : PermutationTriple 3 :=
  ⟨(finRotate 3)⁻¹, Equiv.swap 1 2, Equiv.swap 0 1, by decide⟩

/-! ### Layer 0.2: relabeling -/

/-- **Layer 0.2.** Simultaneous conjugation, as a left action. -/
instance : SMul (Equiv.Perm (Fin n)) (PermutationTriple n) where
  smul τ t :=
    { σ0 := MulAut.conj τ t.σ0
      σ1 := MulAut.conj τ t.σ1
      σinf := MulAut.conj τ t.σinf
      product_eq_one := by
        rw [← map_mul, ← map_mul, t.product_eq_one, map_one] }

@[simp] theorem smul_σ0 (τ : Equiv.Perm (Fin n)) (t : PermutationTriple n) :
    (τ • t).σ0 = τ * t.σ0 * τ⁻¹ := rfl
@[simp] theorem smul_σ1 (τ : Equiv.Perm (Fin n)) (t : PermutationTriple n) :
    (τ • t).σ1 = τ * t.σ1 * τ⁻¹ := rfl
@[simp] theorem smul_σinf (τ : Equiv.Perm (Fin n)) (t : PermutationTriple n) :
    (τ • t).σinf = τ * t.σinf * τ⁻¹ := rfl

instance : MulAction (Equiv.Perm (Fin n)) (PermutationTriple n) where
  one_smul t := by ext1 <;> simp
  mul_smul τ υ t := by ext1 <;> simp [mul_assoc]

/-- **Layer 0.2.** Isomorphism of triples is simultaneous conjugacy. -/
def Equivalent (t t' : PermutationTriple n) : Prop :=
  ∃ τ : Equiv.Perm (Fin n), τ • t = t'

/-- **Layer 0.2.** The type of isomorphism classes. -/
def IsoClass (n : ℕ) : Type :=
  MulAction.orbitRel.Quotient (Equiv.Perm (Fin n)) (PermutationTriple n)

/-! ### Layers 0.3, 0.4: monodromy, connectedness, automorphisms -/

/-- **Layer 0.3.** The monodromy group, generated by the first two components. -/
def monodromyGroup (t : PermutationTriple n) : Subgroup (Equiv.Perm (Fin n)) :=
  Subgroup.closure {t.σ0, t.σ1}

theorem σinf_mem_monodromyGroup (t : PermutationTriple n) :
    t.σinf ∈ monodromyGroup t := by
  rw [t.σinf_eq]
  exact inv_mem (mul_mem (Subgroup.subset_closure (by simp))
    (Subgroup.subset_closure (by simp)))

/-- **Layer 0.4.** Connectedness. ⚠ The `n ≠ 0` clause is part of the definition:
pretransitivity is vacuous on `Fin 0`, and the genus formula fails there. -/
def IsConnected (t : PermutationTriple n) : Prop :=
  n ≠ 0 ∧ MulAction.IsPretransitive (monodromyGroup t) (Fin n)

/-- **Layer 0.2, 0.4.** Connectedness is invariant under relabeling — the lemma that makes
`ConnectedTriple` an `Equiv.Perm (Fin n)`-set. -/
theorem isConnected_smul (τ : Equiv.Perm (Fin n)) {t : PermutationTriple n}
    (ht : t.IsConnected) : (τ • t).IsConnected := by
  sorry

/-- **Layer 3.1.** The closure of a set of labels under the two generators, one round. -/
def orbitStep (t : PermutationTriple n) (s : Finset (Fin n)) : Finset (Fin n) :=
  s ∪ s.image (fun i => t.σ0 i) ∪ s.image (fun i => t.σ1 i)

/-- **Layer 3.1.** Connectedness, computably: `n` rounds of closure from each label
saturate iff the monodromy group is transitive. `n` rounds suffice because a round that
adds nothing is stationary and each earlier round adds at least one label. -/
def isConnectedB (t : PermutationTriple n) : Bool :=
  decide (n ≠ 0) && decide (∀ i : Fin n, (orbitStep t)^[n] {i} = Finset.univ)

/-- **Layer 3.1.** Soundness of the computable connectedness test. -/
theorem isConnectedB_eq_true_iff (t : PermutationTriple n) :
    isConnectedB t = true ↔ t.IsConnected := by
  sorry

/-- **Layer 0.4.** The automorphism group is the stabilizer under relabeling —
definitionally the simultaneous centralizer. -/
def automorphismGroup (t : PermutationTriple n) : Subgroup (Equiv.Perm (Fin n)) :=
  MulAction.stabilizer (Equiv.Perm (Fin n)) t

/-- **Layer 0.4.** The automorphism group is the centralizer of the monodromy group. -/
theorem automorphismGroup_eq_centralizer (t : PermutationTriple n) :
    automorphismGroup t = Subgroup.centralizer (monodromyGroup t) := by
  sorry

/-- **Layer 0.4.** For connected triples the automorphism action on `Fin n` is free, so
the automorphism group's order divides `n`. -/
theorem card_automorphismGroup_dvd (t : PermutationTriple n) (ht : t.IsConnected) :
    Nat.card (automorphismGroup t) ∣ n := by
  sorry

/-! ### Layer 0.5: cycle data

`fullCycleType` is a local stand-in for the PolynomialGaloisGroups Layer 0 declaration of
the same name and definition (its `Suggested.lean`); it is replaced by that roadmap's copy
when it lands. -/

open scoped Classical in
/-- Local stand-in; supplier: PolynomialGaloisGroups Layer 0 `fullCycleType`. The cycle
type *with* fixed points: a partition of `Fintype.card α`. -/
noncomputable def fullCycleType {α : Type u} [Fintype α] (σ : Equiv.Perm α) : Multiset ℕ :=
  σ.cycleType + Multiset.replicate (Fintype.card α - σ.support.card) 1

/-- **Layer 0.5.** The number of cycles, fixed points included. -/
noncomputable def cycleCount {α : Type u} [Fintype α] (σ : Equiv.Perm α) : ℕ :=
  (fullCycleType σ).card

theorem fullCycleType_sum {α : Type u} [Fintype α] (σ : Equiv.Perm α) :
    (fullCycleType σ).sum = Fintype.card α := by
  sorry

/-! **Layer 3.1: the computable cycle decomposition.** `fullCycleType` above is built from
Mathlib's `Equiv.Perm.cycleType`, which goes through `cycleFactorsFinset` and is not an
executable decomposition; every `#eval` and `decide` in Layers 3 and 14 runs on the
definitions below instead, and `computedCycleType_eq_fullCycleType` is what licenses that. -/

/-- **Layer 3.1.** The length of the cycle of `σ` through `i`: the least `k ≥ 1` with
`σ ^ k i = i`, found by a bounded scan. -/
def cycleLenOf (σ : Equiv.Perm (Fin n)) (i : Fin n) : ℕ :=
  ((List.range n).find? fun k => decide ((σ ^ (k + 1)) i = i)).elim n (· + 1)

/-- **Layer 3.1.** Whether `i` is the least label in its `σ`-orbit — the orbit
representative the decomposition below selects. The quantifier is bounded, hence
decidable. -/
def isOrbitMin (σ : Equiv.Perm (Fin n)) (i : Fin n) : Bool :=
  decide (∀ k < n, i ≤ (σ ^ k) i)

/-- **Layer 3.1.** The full cycle type, computably: one part per orbit, fixed points
included. -/
def computedCycleType (σ : Equiv.Perm (Fin n)) : Multiset ℕ :=
  (Finset.univ.filter fun i => isOrbitMin σ i = true).val.map (cycleLenOf σ)

/-- **Layer 3.1, the comparison theorem.** The executable decomposition agrees with the
abstract one. Without this, none of Layer 3's `#eval`s is evidence about `fullCycleType`. -/
theorem computedCycleType_eq_fullCycleType (σ : Equiv.Perm (Fin n)) :
    computedCycleType σ = fullCycleType σ := by
  sorry

/-- **Layer 0.5, the transposition step lemma.** Multiplying by a transposition merges two
cycles or splits one. -/
theorem cycleCount_swap_mul {α : Type u} [Fintype α] [DecidableEq α]
    (σ : Equiv.Perm α) {i j : α} (hij : i ≠ j) :
    cycleCount (Equiv.swap i j * σ) =
      if σ.SameCycle i j then cycleCount σ + 1 else cycleCount σ - 1 := by
  sorry

/-- **Layer 0.5, the sign identity.** -/
theorem sign_eq_pow_sub_cycleCount {α : Type u} [Fintype α] [DecidableEq α]
    (σ : Equiv.Perm α) :
    Equiv.Perm.sign σ = (-1 : ℤˣ) ^ (Fintype.card α - cycleCount σ) := by
  sorry

/-! ### Layer 0.6: Euler characteristic and genus -/

/-- **Layer 0.6.** The Euler characteristic, in `ℤ`, before any genus is defined. -/
noncomputable def eulerChar (t : PermutationTriple n) : ℤ :=
  cycleCount t.σ0 + cycleCount t.σ1 + cycleCount t.σinf - n

/-- **Layer 0.6 (parity).** For every product-one triple, `2 - χ` is even — the sign
identity applied to the relation. No connectedness is needed. -/
theorem even_two_sub_eulerChar (t : PermutationTriple n) : Even (2 - t.eulerChar) := by
  sorry

/-- **Layer 0.6 (the connected bound).** `χ ≤ 2` for connected triples. Proof route:
induction along a minimal transposition factorization of `σ1` with
`cycleCount_swap_mul`; source Lando–Zvonkin (see `PROVENANCE.md`). -/
theorem eulerChar_le_two (t : PermutationTriple n) (ht : t.IsConnected) :
    t.eulerChar ≤ 2 := by
  sorry

/-- **Layer 0.6.** The genus. Junk-free by `two_sub_two_mul_genus`; never used before the
bounds above. -/
noncomputable def genus (t : PermutationTriple n) : ℕ :=
  ((2 - t.eulerChar) / 2).toNat

/-- **Layer 0.6.** `2 - 2g = χ` for connected triples: the `toNat` loses nothing. -/
theorem two_sub_two_mul_genus (t : PermutationTriple n) (ht : t.IsConnected) :
    2 - 2 * (t.genus : ℤ) = t.eulerChar := by
  sorry

/-! ### Layer 0.7: orders and geometry type -/

/-- **Layer 0.7.** The order triple — the LMFDB's `abc` datum. -/
noncomputable def orderTriple (t : PermutationTriple n) : ℕ × ℕ × ℕ :=
  (orderOf t.σ0, orderOf t.σ1, orderOf t.σinf)

/-- **Layer 0.7.** Spherical, Euclidean, or hyperbolic. -/
inductive GeometryType : Type
  | spherical
  | euclidean
  | hyperbolic
  deriving DecidableEq, Repr

/-- **Layer 0.7.** The geometry type, by exact comparison in `ℚ`. -/
noncomputable def geometryType (t : PermutationTriple n) : GeometryType :=
  let s : ℚ := (orderOf t.σ0 : ℚ)⁻¹ + (orderOf t.σ1 : ℚ)⁻¹ + (orderOf t.σinf : ℚ)⁻¹
  if 1 < s then .spherical else if s = 1 then .euclidean else .hyperbolic

/-! ### Layer 0.8: the example suite -/

/-- **Layer 0.8.** The monodromy triple of `z ↦ zⁿ`. -/
def cyclicTriple (n : ℕ) : PermutationTriple n := ofTwo (finRotate n) 1

/-- **Layer 0.8.** The monodromy triple of `z ↦ 4z(1−z)`: unramified over `0`. -/
def chebyshevTriple : PermutationTriple 2 := ofTwo 1 (Equiv.swap 0 1)

/-- **Layer 0.8.** The Euclidean genus-one triple: degree `4`, cycle data
`[4], [4], [2,2]`, regular with deck group `ℤ/4`, imprimitive. -/
def torusTriple : PermutationTriple 4 := ofTwo (finRotate 4) (finRotate 4)

/-- **Layer 0.8.** A triple with monodromy all of `S₃` and trivial automorphisms. -/
def s3Triple : PermutationTriple 3 := ofTwo (finRotate 3) (Equiv.swap 0 1)

example : torusTriple.σinf = (finRotate 4 ^ 2)⁻¹ := by simp [torusTriple, sq]

theorem cyclicTriple_isConnected (n : ℕ) (hn : n ≠ 0) : (cyclicTriple n).IsConnected := by
  sorry

theorem genus_torusTriple : torusTriple.genus = 1 := by
  sorry

/-! ### Layer 2.6: the branch-point action

The two adjacent transpositions, with the conjugators that make them preserve the pinned
relation, and a `decide`-checked witness that the naive color swap does not. -/

/-- **Layer 2.6.** Swap the roles of `0` and `1`. An involution on the nose. -/
def swap01 (t : PermutationTriple n) : PermutationTriple n where
  σ0 := t.σ1
  σ1 := t.σ0
  σinf := t.σ1⁻¹ * t.σinf * t.σ1
  product_eq_one := by rw [t.σinf_eq]; group

/-- **Layer 2.6.** Swap the roles of `1` and `∞`. ⚠ Its square is simultaneous conjugation
by `σ1`, not the identity, which is why the `S₃`-action lives on isomorphism classes. -/
def swap1Inf (t : PermutationTriple n) : PermutationTriple n where
  σ0 := t.σ0
  σ1 := t.σ1⁻¹ * t.σinf * t.σ1
  σinf := t.σ1
  product_eq_one := by rw [t.σinf_eq]; group

/-- **Layer 2.6, the counterexample.** The naive color swap `(a,b,c) ↦ (b,a,a⁻¹ca)` does
**not** preserve the relation: on `s3Triple` the would-be product is not `1`. -/
example :
    ¬ ((s3Triple.σ0⁻¹ * s3Triple.σinf * s3Triple.σ0) * s3Triple.σ0 * s3Triple.σ1 = 1) := by
  decide

/-- The corrected `swap01` does preserve it, on the same triple. -/
example : (swap01 s3Triple).σinf * (swap01 s3Triple).σ1 * (swap01 s3Triple).σ0 = 1 :=
  (swap01 s3Triple).product_eq_one

/-- **Layer 2.6.** `swap01` is an involution on triples, on the nose. -/
theorem swap01_involutive (t : PermutationTriple n) : swap01 (swap01 t) = t := by
  sorry

/-- **Layer 2.6.** `swap1Inf` squared is simultaneous conjugation by `σ1`, **not** the
identity — the statement that forces the `S₃`-action onto `IsoClass n`. -/
theorem swap1Inf_sq (t : PermutationTriple n) : swap1Inf (swap1Inf t) = t.σ1⁻¹ • t := by
  sorry

-- **Layer 12.12, the counterexample.** Componentwise powers of a triple are **not** a
-- triple: raising the three entries of `s3Triple` to the fifth power destroys the product
-- relation. This is why the finite branch-cycle statement is class-by-class and never a
-- statement about the tuple of powers.
set_option maxRecDepth 8000 in
example : s3Triple.σinf ^ 5 * s3Triple.σ1 ^ 5 * s3Triple.σ0 ^ 5 ≠ 1 := by decide

/-- **Layer 12.12, the class-by-class ingredients.** What survives the counterexample above
is a statement about **conjugacy classes**, one slot at a time, and passport invariance
follows from these two finite facts alone. Powering by a unit modulo the order preserves the
full cycle type... -/
theorem fullCycleType_pow_of_coprime {α : Type u} [Fintype α] [DecidableEq α]
    (σ : Equiv.Perm α) {u : ℕ} (hu : Nat.Coprime u (orderOf σ)) :
    fullCycleType (σ ^ u) = fullCycleType σ := by
  sorry

/-- ...and it does not change the generated subgroup, which is why the monodromy group is a
Galois invariant. -/
theorem closure_pow_eq {α : Type u} [Fintype α] [DecidableEq α]
    (t : PermutationTriple n) {u : ℕ}
    (hu : Nat.Coprime u (Monoid.exponent (monodromyGroup t))) :
    Subgroup.closure {t.σ0 ^ u, t.σ1 ^ u} = monodromyGroup t := by
  sorry

/-- **Layer 2.6.** The Coxeter braid relation, on isomorphism classes. -/
theorem braid_on_isoClass (t : PermutationTriple n) :
    Equivalent (swap01 (swap1Inf (swap01 (swap1Inf (swap01 (swap1Inf t)))))) t := by
  sorry

end PermutationTriple

/-! ## Layer 1: passports

⚠ Passports are attached to **connected** triples only (README, Layer 1.1). The carrier
below is what every predicate and every function of this layer is stated on; none is stated
on a bare triple and then hedged with a hypothesis. -/

/-- **Layer 1.1.** The connected-triple carrier. -/
def ConnectedTriple (n : ℕ) : Type :=
  {t : PermutationTriple n // t.IsConnected}

namespace ConnectedTriple

variable {n : ℕ}

instance : SMul (Equiv.Perm (Fin n)) (ConnectedTriple n) where
  smul τ t := ⟨τ • t.1, PermutationTriple.isConnected_smul τ t.2⟩

instance : MulAction (Equiv.Perm (Fin n)) (ConnectedTriple n) where
  one_smul _ := Subtype.ext (one_smul _ _)
  mul_smul _ _ _ := Subtype.ext (mul_smul _ _ _)

end ConnectedTriple

open PermutationTriple in
/-- **Layer 1.1.** A passport specification: a reference transitive subgroup (up to the
conjugacy stated in `HasPassport`) and the three full cycle partitions. -/
structure PassportSpec (n : ℕ) where
  G : Subgroup (Equiv.Perm (Fin n))
  lam0 : Multiset ℕ
  lam1 : Multiset ℕ
  laminf : Multiset ℕ

namespace PassportSpec

variable {n : ℕ}

/-- **Layer 1.1.** Well-formedness: nonzero degree, transitive reference, three partitions
of `n` into positive parts. ⚠ `n ≠ 0` is part of admissibility for the same reason it is
part of connectedness: `IsPretransitive` is vacuous on `Fin 0` and the empty multiset is a
partition of `0`, so without it the degenerate specification is admissible and inhabited by
nothing. -/
def IsAdmissible (P : PassportSpec n) : Prop :=
  n ≠ 0 ∧
    MulAction.IsPretransitive P.G (Fin n) ∧
    (P.lam0.sum = n ∧ ∀ i ∈ P.lam0, 0 < i) ∧
    (P.lam1.sum = n ∧ ∀ i ∈ P.lam1, 0 < i) ∧
    (P.laminf.sum = n ∧ ∀ i ∈ P.laminf, 0 < i)

/-- **Layer 1.1.** Passport membership, on a **connected** triple: conjugate monodromy (the
exact PolynomialGaloisGroups spelling) and equal cycle data. -/
def HasPassport (t : ConnectedTriple n) (P : PassportSpec n) : Prop :=
  (∃ τ : Equiv.Perm (Fin n),
      (PermutationTriple.monodromyGroup t.1).map (MulAut.conj τ).toMonoidHom = P.G) ∧
    PermutationTriple.fullCycleType t.1.σ0 = P.lam0 ∧
    PermutationTriple.fullCycleType t.1.σ1 = P.lam1 ∧
    PermutationTriple.fullCycleType t.1.σinf = P.laminf

end PassportSpec

namespace ConnectedTriple

variable {n : ℕ}

/-- **Layer 1.5.** The passport of a connected triple. ⚠ The domain is `ConnectedTriple n`:
on a disconnected triple this would produce an inadmissible specification. -/
noncomputable def passportOf (t : ConnectedTriple n) : PassportSpec n :=
  ⟨PermutationTriple.monodromyGroup t.1, PermutationTriple.fullCycleType t.1.σ0,
    PermutationTriple.fullCycleType t.1.σ1, PermutationTriple.fullCycleType t.1.σinf⟩

/-- **Layer 1.5.** `passportOf` lands in admissible specifications. -/
theorem isAdmissible_passportOf (t : ConnectedTriple n) : (passportOf t).IsAdmissible := by
  sorry

/-- **Layer 1.5.** A connected triple has its own passport. -/
theorem hasPassport_passportOf (t : ConnectedTriple n) :
    PassportSpec.HasPassport t (passportOf t) := by
  sorry

end ConnectedTriple

namespace PermutationTriple

variable {n : ℕ}

/-- **Layer 1.4.** Primitivity of the monodromy action, Mathlib's notion. -/
def IsPrimitive (t : PermutationTriple n) : Prop :=
  MulAction.IsPreprimitive (monodromyGroup t) (Fin n)

end PermutationTriple

/-! ## Layer 2: dessins as bipartite ribbon graphs -/

/-- **Layer 2.1.** A finite bipartite ribbon graph: abstract edges, two vertex types,
incidences, and rotations that are typed cyclic orders — `Equiv.Perm.IsCycleOn` each
incidence fiber. Surjectivity of the incidences excludes isolated vertices, which is no
loss for dessins (vertices are cycles). ⚠ Cyclic orders are never lists with coverage side
conditions. -/
structure BipartiteRibbonGraph : Type (u + 1) where
  E : Type u
  B : Type u
  W : Type u
  [fintypeE : Fintype E]
  [fintypeB : Fintype B]
  [fintypeW : Fintype W]
  [decidableEqE : DecidableEq E]
  [decidableEqB : DecidableEq B]
  [decidableEqW : DecidableEq W]
  blackEnd : E → B
  whiteEnd : E → W
  rotB : Equiv.Perm E
  rotW : Equiv.Perm E
  blackEnd_surjective : Function.Surjective blackEnd
  whiteEnd_surjective : Function.Surjective whiteEnd
  blackEnd_rotB : ∀ e, blackEnd (rotB e) = blackEnd e
  whiteEnd_rotW : ∀ e, whiteEnd (rotW e) = whiteEnd e
  isCycleOn_rotB : ∀ b, rotB.IsCycleOn (blackEnd ⁻¹' {b})
  isCycleOn_rotW : ∀ w, rotW.IsCycleOn (whiteEnd ⁻¹' {w})

namespace BipartiteRibbonGraph

attribute [instance] fintypeE fintypeB fintypeW decidableEqE decidableEqB decidableEqW

variable (Γ : BipartiteRibbonGraph.{u})

/-- **Layer 2.1.** The face permutation, in the pinned display order:
`facePerm * rotW * rotB = 1`. -/
def facePerm : Equiv.Perm Γ.E := (Γ.rotW * Γ.rotB)⁻¹

theorem facePerm_mul : Γ.facePerm * Γ.rotW * Γ.rotB = 1 := by
  simp [facePerm, mul_assoc]

/-- **Layer 2.1.** Connectedness: jointly transitive rotations on a nonempty edge set. -/
def IsConnected : Prop :=
  Nonempty Γ.E ∧ MulAction.IsPretransitive (Subgroup.closure {Γ.rotB, Γ.rotW}) Γ.E

/-- **Layer 2.1.** The Euler characteristic: vertices minus edges plus faces. -/
noncomputable def eulerChar : ℤ :=
  Nat.card Γ.B + Nat.card Γ.W + PermutationTriple.cycleCount Γ.facePerm - Nat.card Γ.E

/-- **Layer 2.3.** The triple of a dessin, along a numbering of the edges. Changing the
numbering relabels the triple (README, Layer 2.3). -/
def toTriple {n : ℕ} (ν : Γ.E ≃ Fin n) : PermutationTriple n :=
  PermutationTriple.ofTwo (ν.permCongr Γ.rotB) (ν.permCongr Γ.rotW)

end BipartiteRibbonGraph

/-- **Layer 2.2.** The dessin of a connected triple: edges `Fin n`, vertices the cycles
(orbits) of `σ0` and `σ1`, rotations the permutations themselves. -/
noncomputable def PermutationTriple.toDessin {n : ℕ} (t : PermutationTriple n)
    (ht : t.IsConnected) : BipartiteRibbonGraph := by
  sorry

/-! ## Layer 3: enumeration and counting

The executable-enumeration milestones (Layer 3.1) are instance-level and appear as the
`Fintype`/`DecidableEq` obligations on `PermutationTriple`; the Frobenius product-one
formula (Layer 3.2) and its corrections (3.3, 3.4) are stated in `README.md` only, because
their statements consume the CharacterTheory carriers (`classSum`, `structureConstant`,
`characterTable`), which live in that roadmap. -/

/-- **Layer 3.2 (the inverse-class involution).** Owned here; on no other roadmap. -/
noncomputable def ConjClasses.inv {G : Type u} [Group G] (C : ConjClasses G) :
    ConjClasses G := by
  sorry

/-! ## Layer 4: triangle groups -/

/-- **Layer 4.1.** The relators of the `(a,b,c)` triangle group, in the pinned display
order: `z * y * x` is the product relator. -/
def triangleRelators (a b c : ℕ) : Set (FreeGroup (Fin 3)) :=
  {FreeGroup.of 0 ^ a, FreeGroup.of 1 ^ b, FreeGroup.of 2 ^ c,
    FreeGroup.of 2 * FreeGroup.of 1 * FreeGroup.of 0}

/-- **Layer 4.1.** The oriented triangle group `Δ(a,b,c)`. -/
abbrev TriangleGroup (a b c : ℕ) : Type := PresentedGroup (triangleRelators a b c)

namespace TriangleGroup

variable {a b c : ℕ}

/-- The generator `x`, mapping to `σ0`. -/
def x (a b c : ℕ) : TriangleGroup a b c := PresentedGroup.of 0

/-- The generator `y`, mapping to `σ1`. -/
def y (a b c : ℕ) : TriangleGroup a b c := PresentedGroup.of 1

/-- The generator `z`, mapping to `σinf`. -/
def z (a b c : ℕ) : TriangleGroup a b c := PresentedGroup.of 2

theorem z_mul_y_mul_x (a b c : ℕ) : z a b c * y a b c * x a b c = 1 := by
  sorry

theorem x_pow (a b c : ℕ) : x a b c ^ a = 1 := by
  sorry

/-- **Layer 4.2.** A triple with component orders dividing `(a, b, c)` is a permutation
representation of the triangle group, with range the monodromy group. -/
noncomputable def toPerm {n : ℕ} (t : TauCetiRoadmap.BelyiMaps.PermutationTriple n)
    (ha : t.σ0 ^ a = 1) (hb : t.σ1 ^ b = 1) (hc : t.σinf ^ c = 1) :
    TriangleGroup a b c →* Equiv.Perm (Fin n) := by
  sorry

end TriangleGroup

/-! ## Layer 5: the thrice-punctured sphere -/

/-- **Layer 5.1.** The affine model of `ℙ¹(ℂ) ∖ {0, 1, ∞}`. -/
def ThricePuncturedSphere : Type := {z : ℂ // z ≠ 0 ∧ z ≠ 1}

namespace ThricePuncturedSphere

instance : TopologicalSpace ThricePuncturedSphere :=
  inferInstanceAs (TopologicalSpace {z : ℂ // z ≠ 0 ∧ z ≠ 1})

/-- **Layer 5.1.** The pinned basepoint `1/2` — on the real segment, so that the embedded
graph of Layer 7.6 passes through it. -/
noncomputable def basePt : ThricePuncturedSphere :=
  ⟨1 / 2, by norm_num, by norm_num⟩

/-- **Layer 5.2.** The peripheral loop around `0`: the counterclockwise circle
`t ↦ (1/2)·exp(2πit)` of radius `1/2` about `0`, based at `1/2`. -/
noncomputable def γ0 : Path basePt basePt where
  toFun t :=
    ⟨(1 / 2 : ℂ) * Complex.exp (2 * Real.pi * Complex.I * (t : ℝ)), by sorry⟩
  continuous_toFun := by sorry
  source' := by sorry
  target' := by sorry

/-- **Layer 5.2.** The peripheral loop around `1`: the counterclockwise circle
`t ↦ 1 − (1/2)·exp(2πit)` of radius `1/2` about `1`, based at `1/2`. -/
noncomputable def γ1 : Path basePt basePt where
  toFun t :=
    ⟨1 - (1 / 2 : ℂ) * Complex.exp (2 * Real.pi * Complex.I * (t : ℝ)), by sorry⟩
  continuous_toFun := by sorry
  source' := by sorry
  target' := by sorry

/-- **Layer 5.2.** The class of `γ0` in the fundamental group. -/
noncomputable def periph0 : FundamentalGroup ThricePuncturedSphere basePt :=
  FundamentalGroup.fromPath ⟦γ0⟧

/-- **Layer 5.2.** The class of `γ1`. -/
noncomputable def periph1 : FundamentalGroup ThricePuncturedSphere basePt :=
  FundamentalGroup.fromPath ⟦γ1⟧

/-- **Layer 5.2.** The peripheral element at `∞`, *defined* so that the pinned relation
holds; the orientation statement identifying it with a clockwise large circle is the
Layer 5.2 milestone. -/
noncomputable def periphInf : FundamentalGroup ThricePuncturedSphere basePt :=
  (periph1 * periph0)⁻¹

/-- The pinned relation, in the same display order as the triple relation. -/
theorem periphInf_mul_periph1_mul_periph0 : periphInf * periph1 * periph0 = 1 := by
  simp [periphInf, mul_assoc]

/-- **Layer 5.5.** The **canonical** map out of the free product: the `Monoid.Coprod.lift`
of the two inclusion-induced homomorphisms. Van Kampen is the statement that *this* map is
an isomorphism; a bare `Nonempty (… ≃* …)` would not let Layer 5.6 read off the values on
`periph0` and `periph1`. -/
noncomputable def vanKampenLift {X : Type u} [TopologicalSpace X] (A B : Set X)
    {x : X} (hxA : x ∈ A) (hxB : x ∈ B) :
    Monoid.Coprod (FundamentalGroup ↥A ⟨x, hxA⟩) (FundamentalGroup ↥B ⟨x, hxB⟩) →*
      FundamentalGroup X x :=
  Monoid.Coprod.lift
    (FundamentalGroup.map ⟨Subtype.val, continuous_subtype_val⟩ (⟨x, hxA⟩ : ↥A))
    (FundamentalGroup.map ⟨Subtype.val, continuous_subtype_val⟩ (⟨x, hxB⟩ : ↥B))

/-- **Layer 5.5.** Van Kampen for two open sets with simply connected intersection — the
one general topological theorem this roadmap owns, and the reason no figure-eight
retraction is needed. The pin has no Seifert–van Kampen theorem in any form; this case is
built from `exists_monotone_Icc_subset_open_cover_unitInterval` (generation) and its square
analogue `..._prod_self` (relations), with `Path.subpath`, `Path.concat` and
`Path.Homotopy.concatSubpath` reassembling the pieces.

⚠ `IsPathConnected (A ∩ B)` is not implied by simple connectivity of the intersection and is
not optional: a two-component intersection makes the conclusion false. -/
theorem vanKampenLift_bijective {X : Type u} [TopologicalSpace X]
    {A B : Set X} (_hA : IsOpen A) (_hB : IsOpen B) (_hAB : A ∪ B = Set.univ)
    (_hApc : IsPathConnected A) (_hBpc : IsPathConnected B)
    (_hIpc : IsPathConnected (A ∩ B)) [SimplyConnectedSpace ↥(A ∩ B)]
    {x : X} (hxA : x ∈ A) (hxB : x ∈ B) :
    Function.Bijective (vanKampenLift A B hxA hxB) := by
  sorry

/-- **Layer 5.5.** The van Kampen isomorphism, as a named `MulEquiv` whose underlying
homomorphism is `vanKampenLift` by construction — which is what
`MulEquiv.ofBijective` delivers and what `vanKampenEquiv_toMonoidHom` records. -/
noncomputable def vanKampenEquiv {X : Type u} [TopologicalSpace X]
    {A B : Set X} (hA : IsOpen A) (hB : IsOpen B) (hAB : A ∪ B = Set.univ)
    (hApc : IsPathConnected A) (hBpc : IsPathConnected B)
    (hIpc : IsPathConnected (A ∩ B)) [SimplyConnectedSpace ↥(A ∩ B)]
    {x : X} (hxA : x ∈ A) (hxB : x ∈ B) :
    Monoid.Coprod (FundamentalGroup ↥A ⟨x, hxA⟩) (FundamentalGroup ↥B ⟨x, hxB⟩)
      ≃* FundamentalGroup X x :=
  MulEquiv.ofBijective _
    (vanKampenLift_bijective hA hB hAB hApc hBpc hIpc hxA hxB)

theorem vanKampenEquiv_toMonoidHom {X : Type u} [TopologicalSpace X]
    {A B : Set X} (hA : IsOpen A) (hB : IsOpen B) (hAB : A ∪ B = Set.univ)
    (hApc : IsPathConnected A) (hBpc : IsPathConnected B)
    (hIpc : IsPathConnected (A ∩ B)) [SimplyConnectedSpace ↥(A ∩ B)]
    {x : X} (hxA : x ∈ A) (hxB : x ∈ B) :
    (vanKampenEquiv hA hB hAB hApc hBpc hIpc hxA hxB).toMonoidHom
      = vanKampenLift A B hxA hxB :=
  rfl

/-- **Layer 5.6.** The fundamental group is free on the two peripheral generators.
Route: the two-set cover of 5.1, `π₁` of a punctured convex domain (5.4), and the
simply-connected-intersection van Kampen theorem of 5.5, which this roadmap owns and
builds from the pin's subdivision lemmas. -/
noncomputable def freeGroupEquiv :
    FreeGroup (Fin 2) ≃* FundamentalGroup ThricePuncturedSphere basePt := by
  sorry

theorem freeGroupEquiv_of0 : freeGroupEquiv (FreeGroup.of 0) = periph0 := by
  sorry

theorem freeGroupEquiv_of1 : freeGroupEquiv (FreeGroup.of 1) = periph1 := by
  sorry

end ThricePuncturedSphere

/-! ## Layers 5.4, 6: monodromy -/

/-- **Layer 5.3.** The fiber monodromy, packaged as a `MonoidHom` — a genuine
homomorphism, with no `ᵐᵒᵖ`, by `IsCoveringMap.monodromy_trans_apply` and the
`End`-multiplication convention. -/
noncomputable def monodromyHom {E : Type u} {X : Type v} [TopologicalSpace E]
    [TopologicalSpace X]
    {p : E → X} (hp : IsCoveringMap p) (x : X) :
    FundamentalGroup X x →* Equiv.Perm (p ⁻¹' {x}) := by
  sorry

theorem monodromyHom_apply {E : Type u} {X : Type v} [TopologicalSpace E]
    [TopologicalSpace X]
    {p : E → X} (hp : IsCoveringMap p) (x : X)
    (γ : FundamentalGroup X x) (e : p ⁻¹' {x}) :
    monodromyHom hp x γ e = hp.monodromy (FundamentalGroup.toPath γ) e := by
  sorry

/-- Local stand-in; supplier: UniversalCovers Stage 0.2's `SemilocallySimplyConnectedSpace`.
⚠ Absent from the pinned Mathlib, and **not** implied by path- plus local path-connectedness:
the Hawaiian earring satisfies those two and has no universal cover. Layer 6.2 carries it
because the universal-cover construction it consumes requires it. -/
class SemilocallySimplyConnectedSpace (X : Type u) [TopologicalSpace X] : Prop where
  exists_nhds_nullhomotopic : ∀ x : X, ∃ U : Set X, IsOpen U ∧ x ∈ U ∧
    ∀ γ : Path x x, (∀ t, γ t ∈ U) →
      (⟦γ⟧ : Path.Homotopic.Quotient x x) = ⟦Path.refl x⟧

/-- **Layer 6.2, the general construction.** For an **arbitrary discrete** `π₁`-set `S`, the
associated cover `(Ũ × S) ⧸ π₁` exists and has monodromy the given action. Stated as the
contract — a cover exists with prescribed monodromy — because the universal cover itself is
UniversalCovers' object, not this roadmap's.

The diagonal action is pinned in the README: with `ũ · γ` the deck action (which is a
**right** action, because UniversalCovers milestone 5 identifies deck transformations with
`(π₁)ᵐᵒᵖ`), it is `γ ⋆ (ũ, s) = (ũ · γ⁻¹, act γ s)`. That inverse is exactly what makes the
conclusion below carry `act γ` rather than `act γ⁻¹`. -/
theorem exists_cover_with_monodromy {X : Type u} [TopologicalSpace X]
    [PathConnectedSpace X] [LocPathConnectedSpace X] [SemilocallySimplyConnectedSpace X]
    (x : X) {S : Type u} [TopologicalSpace S] [DiscreteTopology S]
    (act : FundamentalGroup X x →* Equiv.Perm S) :
    ∃ (E : Type u) (_ : TopologicalSpace E) (p : E → X) (hp : IsCoveringMap p)
      (ν : ↥(p ⁻¹' {x}) ≃ S), ∀ γ, ν.permCongr (monodromyHom hp x γ) = act γ := by
  sorry

/-- **Layer 6.2, the finite corollary.** The form Layer 6.3 consumes: a numbering of the
fiber by `Fin n`, hence a literal `PermutationTriple n`. ⚠ The general theorem above is
**not** the finite one specialized — the regular `π₁`-set is infinite for
`π₁(U, b) ≃* FreeGroup (Fin 2)`, so the universal cover is an instance of the general
construction only. -/
theorem exists_finiteCover_with_monodromy {X : Type u} [TopologicalSpace X]
    [PathConnectedSpace X] [LocPathConnectedSpace X] [SemilocallySimplyConnectedSpace X]
    (x : X) {n : ℕ} (act : FundamentalGroup X x →* Equiv.Perm (Fin n)) :
    ∃ (E : Type u) (_ : TopologicalSpace E) (p : E → X) (hp : IsCoveringMap p)
      (ν : ↥(p ⁻¹' {x}) ≃ Fin n), ∀ γ, ν.permCongr (monodromyHom hp x γ) = act γ := by
  sorry

/-- **Layer 6.1.** A cover **with a numbered fiber** — the carrier that a literal
`PermutationTriple n` classifies. ⚠ A *pointed* cover is a different carrier: one chosen
point of the fiber leaves `(n−1)!` relabelings, and Layer 6.3 classifies pointed covers by
subgroups of `π₁`, never by literal triples. -/
structure FiberNumberedCover {X : Type u} [TopologicalSpace X] (x : X) (n : ℕ) where
  E : Type u
  [topE : TopologicalSpace E]
  p : E → X
  isCoveringMap : IsCoveringMap p
  ν : ↥(p ⁻¹' {x}) ≃ Fin n

attribute [instance] FiberNumberedCover.topE

open ThricePuncturedSphere in
/-- **Layer 6.1.** The monodromy triple of a fiber-numbered cover of the thrice-punctured
sphere. The third component automatically computes the monodromy of `periphInf` (README,
Layer 6.1). -/
noncomputable def FiberNumberedCover.triple {n : ℕ}
    (c : FiberNumberedCover basePt n) : PermutationTriple n :=
  PermutationTriple.ofTwo
    (c.ν.permCongr (monodromyHom c.isCoveringMap basePt periph0))
    (c.ν.permCongr (monodromyHom c.isCoveringMap basePt periph1))

/-! ## Layer 8: analytic Belyi pairs

The two sorried instances are the Riemann-sphere milestones of Layer 8.1: the charts are
`z` and `1/z`. They are declared as instances so that the carriers below can be stated. -/

/-- **Layer 8.1 (milestone, stated as an instance).** The Riemann sphere's charted-space
structure on `OnePoint ℂ`, with the two standard charts. -/
noncomputable instance : ChartedSpace ℂ (OnePoint ℂ) := by
  sorry

/-- **Layer 8.1 (milestone, stated as an instance).** The complex-manifold structure: the
transition `z ↦ 1/z` on `ℂˣ` is analytic. -/
instance : IsManifold 𝓘(ℂ) ω (OnePoint ℂ) := by
  sorry

open OnePoint in
/-- **Layer 8.4.** An analytic Belyi pair: a compact connected Riemann surface — the
unbundled hypothesis stack pinned in README §Pinned conventions — with a nonconstant
holomorphic map to the sphere that is an even covering away from `{0, 1, ∞}`. The
equivalence with the branch-value formulation is the Layer 8.4 milestone. -/
structure AnalyticBelyiPair : Type (u + 1) where
  X : Type u
  [topX : TopologicalSpace X]
  [chartedX : ChartedSpace ℂ X]
  [manifoldX : IsManifold 𝓘(ℂ) ω X]
  [t2X : T2Space X]
  [compactX : CompactSpace X]
  [connectedX : ConnectedSpace X]
  β : X → OnePoint ℂ
  mdifferentiable : MDifferentiable 𝓘(ℂ) 𝓘(ℂ) β
  exists_ne : ∃ x y, β x ≠ β y
  isCoveringMapOn :
    IsCoveringMapOn β
      ({((0 : ℂ) : OnePoint ℂ), ((1 : ℂ) : OnePoint ℂ), OnePoint.infty}ᶜ)

attribute [instance] AnalyticBelyiPair.topX AnalyticBelyiPair.chartedX
  AnalyticBelyiPair.manifoldX AnalyticBelyiPair.t2X AnalyticBelyiPair.compactX
  AnalyticBelyiPair.connectedX

/-! ## Layers 12, 13: profinite peripheral objects

Local stand-ins mirroring the ProPGroups roadmap's pinned shapes; each is replaced by that
roadmap's declaration when it lands. Layers 9–11 have no prototypes here (see the header).
-/

/-- Local stand-in; supplier: ProPGroups Layer 4 `freeProfiniteGroup (Fin 2)`. The
profinite completion of the free group on two generators. -/
noncomputable abbrev freeProfiniteTwo : ProfiniteGrp :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (FreeGroup (Fin 2)))

/-- **Layer 12.6 / §Pinned conventions.** The peripheral element `P`. -/
noncomputable def periphP : freeProfiniteTwo :=
  ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (FreeGroup (Fin 2))) (FreeGroup.of 0)

/-- The peripheral element `T`. -/
noncomputable def periphT : freeProfiniteTwo :=
  ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (FreeGroup (Fin 2))) (FreeGroup.of 1)

/-- The peripheral element `C := (T * P)⁻¹`, so that `C * T * P = 1` — the profinite image
of the Layer 5.2 relation, in the pinned display order. -/
noncomputable def periphC : freeProfiniteTwo := (periphT * periphP)⁻¹

/-- **§Pinned conventions, P0.2.** The opposite-convention third peripheral element is the
conjugate `P · C · P⁻¹`, **not** `P⁻¹ · C · P`. Stated on an abstract group, since it is a
word identity. -/
theorem opposite_third_peripheral {G : Type u} [Group G] (P T : G) :
    (P * T)⁻¹ = P * ((T * P)⁻¹) * P⁻¹ := by group

theorem periphC_mul_periphT_mul_periphP : periphC * periphT * periphP = 1 := by
  simp [periphC, mul_assoc]

/-- **Layer 12.1.** The profinite integers as a topological commutative **ring**, as the
subring of compatible systems inside `∀ n : ℕ+, ZMod n`.
⚠ ProPGroups supplies the profinite completion of the infinite cyclic *group*; that is not
enough for `(x ^ᶻ a) ^ᶻ b = x ^ᶻ (a * b)`, for `ẑˣ`, or for the `ℓ`-adic components, all of
which Layers 12.2, 12.3 and 12.10 use. This milestone owns the ring.
⚠ The index runs over `ℕ+`, not `ℕ`: `ZMod 0` is `ℤ`, every `n` divides `0`, and including
it would collapse the limit to `ℤ`. -/
def profiniteIntSubring : Subring (∀ n : ℕ+, ZMod (n : ℕ)) where
  carrier := {f | ∀ (m n : ℕ+) (h : (n : ℕ) ∣ (m : ℕ)),
    ZMod.castHom h (ZMod (n : ℕ)) (f m) = f n}
  zero_mem' := by intro m n h; simp
  one_mem' := by intro m n h; simpa using map_one (ZMod.castHom h (ZMod (n : ℕ)))
  add_mem' ha hb := by intro m n h; simp [map_add, ha m n h, hb m n h]
  mul_mem' ha hb := by intro m n h; simp [map_mul, ha m n h, hb m n h]
  neg_mem' ha := by intro m n h; simp [map_neg, ha m n h]

/-- **Layer 12.1.** The carrier. An `abbrev` so that the `Subring` instances and the
coercion to `∀ n : ℕ+, ZMod n` are found without transport. -/
abbrev ProfiniteInt : Type := profiniteIntSubring

/-- **Layer 12.1.** The remaining structure — a topological ring, compact and totally
disconnected — is the milestone; the pin has no profinite-integer development to consume.
The `CommRing` and `TopologicalSpace` instances are inherited from the ambient product. -/
instance : IsTopologicalRing ProfiniteInt := sorry
instance : CompactSpace ProfiniteInt := sorry
instance : TotallyDisconnectedSpace ProfiniteInt := sorry

/-- **Layer 12.1.** The projections to the finite rings, compatible under divisibility. -/
def ProfiniteInt.toZMod (n : ℕ+) : ProfiniteInt →+* ZMod (n : ℕ) where
  toFun a := (a : ∀ m : ℕ+, ZMod (m : ℕ)) n
  map_one' := rfl
  map_mul' _ _ := rfl
  map_zero' := rfl
  map_add' _ _ := rfl

/-- **Layer 12.1.** Compatibility of the projections — the limit property in usable form. -/
theorem ProfiniteInt.castHom_toZMod (m n : ℕ+) (h : (n : ℕ) ∣ (m : ℕ)) (a : ProfiniteInt) :
    ZMod.castHom h (ZMod (n : ℕ)) (ProfiniteInt.toZMod m a) = ProfiniteInt.toZMod n a :=
  a.2 m n h

/-- **Layer 12.1.** The `ℓ`-adic component, a **ring** homomorphism — this is the map
Layer 12.3's comparison `x ^ᶻ a = x ^[ℓ] (component_ℓ a)` is stated with. -/
noncomputable def ProfiniteInt.component (ℓ : ℕ) [Fact ℓ.Prime] :
    ProfiniteInt →+* ℤ_[ℓ] := sorry

/-- **Layer 12.1.** Unit criterion: an element is a unit iff every finite-level image is.
This is what makes `ẑˣ` a usable target for the cyclotomic character of Layer 12.10. -/
theorem ProfiniteInt.isUnit_iff (a : ProfiniteInt) :
    IsUnit a ↔ ∀ n : ℕ+, IsUnit (ProfiniteInt.toZMod n a) := sorry

/-- Local stand-in; supplier: ProPGroups Layer 0–2 `zHat`. The profinite completion of
`ℤ` **as a group**; Layer 12.1's comparison theorem identifies it with the additive
procyclic group of `ProfiniteInt`. -/
noncomputable abbrev zhat : ProfiniteGrp :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (Multiplicative ℤ))

/-- **Layer 12.1, the comparison.** The ring's procyclic group is the supplier's `zHat`.
Stated as a theorem, so that no milestone silently switches between the two structures. -/
theorem profiniteInt_mulEquiv_zhat :
    Nonempty (Multiplicative ProfiniteInt ≃ₜ* zhat) := sorry

/-- **Layer 12.2.** The profinite power `x ^ᶻ a`: the image of `a` under the unique
continuous homomorphism `ẑ → G` with `1 ↦ x`. The laws — agreement with integer powers,
additivity, multiplicativity **through 12.1's ring product**, continuity, and naturality
under continuous homomorphisms (hence under conjugation) — are the Layer 12.2 milestones. -/
noncomputable def zhatPow {G : ProfiniteGrp} (x : G) (a : ProfiniteInt) : G := by
  sorry

/-- **Layer 12.2.** The law that forces the ring milestone to come first. -/
theorem zhatPow_zhatPow {G : ProfiniteGrp} (x : G) (a b : ProfiniteInt) :
    zhatPow (zhatPow x a) b = zhatPow x (a * b) := by
  sorry

/-- Local stand-in; supplier: ProPGroups Layer 3 `proPKernel`. -/
def proPKernel (p : ℕ) (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // IsPGroup p (G ⧸ U.1.toSubgroup)}, U.1.toSubgroup

/-- Local stand-in; supplier: ProPGroups Layer 3 `proPKernel_normal`. -/
instance proPKernel_normal (p : ℕ) (G : Type u) [Group G] [TopologicalSpace G] :
    (proPKernel p G).Normal := by
  sorry

/-- Local stand-in; supplier: ProPGroups Layer 3 `maximalProPQuotient`. -/
abbrev maximalProPQuotient (p : ℕ) (G : Type u) [Group G] [TopologicalSpace G] : Type u :=
  G ⧸ proPKernel p G

/-- **Layer 13.1.** The maximal pro-`ℓ` quotient of the profinite free group on two
generators — ProPGroups' `freeProP ℓ (Fin 2)` once that roadmap lands. ⚠ Every Layer 13
declaration carries `[Fact ℓ.Prime]`: neither `maximalProPQuotient` nor `ℤ_[ℓ]` is the
intended object for composite `ℓ`. -/
noncomputable abbrev DeltaL (ℓ : ℕ) [Fact ℓ.Prime] : Type :=
  maximalProPQuotient ℓ freeProfiniteTwo

/-- **Layer 13.1.** The pro-`ℓ` peripheral element `P_ℓ`. -/
noncomputable def periphPL (ℓ : ℕ) [Fact ℓ.Prime] : DeltaL ℓ := QuotientGroup.mk periphP

/-- The pro-`ℓ` peripheral element `T_ℓ`. -/
noncomputable def periphTL (ℓ : ℕ) [Fact ℓ.Prime] : DeltaL ℓ := QuotientGroup.mk periphT

/-- The pro-`ℓ` peripheral element `C_ℓ`. -/
noncomputable def periphCL (ℓ : ℕ) [Fact ℓ.Prime] : DeltaL ℓ := QuotientGroup.mk periphC

theorem periphCL_mul_periphTL_mul_periphPL (ℓ : ℕ) [Fact ℓ.Prime] :
    periphCL ℓ * periphTL ℓ * periphPL ℓ = 1 := by
  sorry

/-- **Layer 12.3.** The `ℤ_ℓ`-power on the maximal pro-`ℓ` quotient: the canonical
operation through which `zhatPow` factors on pro-`ℓ` groups, with the same laws. Not an
arbitrary function argument — the comparison with `zhatPow` is the Layer 12.3 theorem. -/
noncomputable def padicPow {ℓ : ℕ} [Fact ℓ.Prime] (x : DeltaL ℓ) (u : ℤ_[ℓ]) :
    DeltaL ℓ := by
  sorry

/-- **Layer 13.2.** Surjectivity of the `ℓ`-adic cyclotomic character of `ℚ`, from the
finite cyclotomic levels and compactness. Ring automorphisms of `ℚ̄` are exactly
`Gal(ℚ̄/ℚ)`, since every ring automorphism fixes the prime field. -/
theorem cyclotomicCharacter_surjective (ℓ : ℕ) [Fact ℓ.Prime] :
    Function.Surjective (cyclotomicCharacter (AlgebraicClosure ℚ) ℓ) := by
  sorry

/-- **Layer 13.3, the peripheral-power theorem.** For every prime `ℓ` and every
`u ∈ ℤ_ℓˣ` there is a continuous automorphism of `Δ_ℓ` carrying each peripheral element to
a conjugate of its `u`-th power. The assignment `u ↦ φ_u` is not asserted to be a
homomorphism, continuous, or canonical (README, Layer 13.3). -/
theorem exists_peripheralPowerAutomorphism (ℓ : ℕ) [Fact ℓ.Prime] (u : ℤ_[ℓ]ˣ) :
    ∃ φ : DeltaL ℓ ≃ₜ* DeltaL ℓ, ∃ cP cT cC : DeltaL ℓ,
      φ (periphPL ℓ) = cP⁻¹ * padicPow (periphPL ℓ) u * cP ∧
      φ (periphTL ℓ) = cT⁻¹ * padicPow (periphTL ℓ) u * cT ∧
      φ (periphCL ℓ) = cC⁻¹ * padicPow (periphCL ℓ) u * cC := by
  sorry

/-- **Layer 13.3, the conjugation-transfer lemma.** The conjugator for a conjugate element
is **computed**, not guessed: `d := q * c * (φ q)⁻¹`. ⚠ It involves `φ q`, and is not
obtained by multiplying `c` by `q` on one side. Stated on an abstract group with an abstract
power operation, since that is all the proof uses — naturality of the power under
conjugation (Layer 12.2) supplies `pow (q * x * q⁻¹) = q * pow x * q⁻¹`. -/
theorem conjugation_transfer {G : Type u} [Group G] (φ : G ≃* G) (pow : G → G)
    (hpow : ∀ q x : G, pow (q * x * q⁻¹) = q * pow x * q⁻¹)
    {x c : G} (hx : φ x = c⁻¹ * pow x * c) (q : G) :
    φ (q * x * q⁻¹) =
      (q * c * (φ q)⁻¹)⁻¹ * pow (q * x * q⁻¹) * (q * c * (φ q)⁻¹) := by
  have h : φ (q * x * q⁻¹) = φ q * (c⁻¹ * pow x * c) * (φ q)⁻¹ := by
    simp [map_mul, map_inv, hx]
  rw [h, hpow]
  group

/-- **§Pinned conventions.** The transfer applied at `q = P`, `x = C`: the rival
convention's third peripheral element `(P * T)⁻¹` is `P * C * P⁻¹`, so a consumer using it
needs no new mathematics, only the conjugator the lemma computes. -/
example {G : Type u} [Group G] (P T : G) : (P * T)⁻¹ = P * ((T * P)⁻¹) * P⁻¹ :=
  opposite_third_peripheral P T

end TauCetiRoadmap.BelyiMaps
