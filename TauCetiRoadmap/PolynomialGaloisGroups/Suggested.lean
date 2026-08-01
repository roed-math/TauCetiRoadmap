import Mathlib

/-!
# Galois groups of polynomials: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap. `sorry` is allowed in this human-owned roadmap
library — these are goals, not proofs.

Pinned Mathlib (`9caeba1000`, 2026-06-03) has `Polynomial.Gal` with its faithful action on
roots (transitive for irreducible polynomials), the Chambert-Loir permutation toolkit
(`IsBlock`, `IsPreprimitive`, multiple transitivity, Jordan's swap and 3-cycle theorems),
`Polynomial.discr` (Sylvester form, without the root-product formula), and arithmetic
Frobenius elements (`IsArithFrobAt`) — so essentially the whole roadmap is statable at the
pin, and this file spans layers 0–6 and 9: the permutation representation and the
orbit ↔ factor dictionary (Layer 0), the block–stabilizer correspondence and the
imprimitivity grid (Layer 1), the intermediate-field dictionary (Layer 2), the
discriminant test (Layer 3), resolvents with the quartic worked instance (Layer 4), the
**pinned Frobenius-specialization interface** consumed from the NumberFieldArithmetic
roadmap (in preparation — the one `sorry` below that is a contract with a sibling roadmap
rather than a target of this one; marked at the statement), certificates and worked
examples (Layers 5–6), the degree-5 label predicates (Layer 6), and the `Sₙ` summit
(Layer 9).

The `def`s in the Prototypes section pin suggested *forms* for the objects the examples
mention (each is also a design decision recorded in `README.md`); they are prototypes, not
proved-out API.
-/

namespace TauCetiRoadmap.PolynomialGaloisGroups

open Polynomial MulAction

universe u v

/-! ## Prototypes: suggested forms for the basic objects -/

section Prototypes

open scoped Classical in
/-- **Pinned convention (README, "Cycle types count fixed points").** The cycle type of a
permutation *including* its fixed points as parts equal to `1`: Mathlib's
`Equiv.Perm.cycleType` lists only the cycle lengths `≥ 2`, while Dedekind factorization
types are partitions of `n` with their `1`-parts. Every Frobenius/factorization comparison
below is stated with `fullCycleType`, never with a bare `cycleType`. -/
noncomputable def fullCycleType {α : Type u} [Fintype α] (σ : Equiv.Perm α) : Multiset ℕ :=
  σ.cycleType + Multiset.replicate (Fintype.card α - σ.support.card) 1

/-- **Layer 6 reference subgroups, degree 5** (0-indexed: `referenceSubgroupFive j` is the
LMFDB label `5T(j+1)`): `C₅ = ⟨(01234)⟩`; `D₅` adds the reflection `(14)(23)`; `F₂₀` adds
the multiplication-by-2 map `(1243)`; then `A₅` and `S₅`. The `T`-numbering is
Butler–McKay's, shared by GAP and the LMFDB; the invariant table is in `README.md`. -/
def referenceSubgroupFive : Fin 5 → Subgroup (Equiv.Perm (Fin 5)) :=
  ![Subgroup.closure {finRotate 5},
    Subgroup.closure {finRotate 5, Equiv.swap 1 4 * Equiv.swap 2 3},
    Subgroup.closure {finRotate 5, ([1, 2, 4, 3] : List (Fin 5)).formPerm},
    alternatingGroup (Fin 5),
    ⊤]

/-- **Layer 6 label predicate, degree 5** (prototype of the general
`TransitiveGroupLabel n j`): a subgroup of `Equiv.Perm (Fin 5)` has label `5T(j+1)` when
it is conjugate to the reference subgroup. Conjugates of transitive groups are transitive,
so no separate transitivity clause is needed; the partition theorem below says the five
labels tile the transitive subgroups. -/
def HasTransitiveLabelFive (j : Fin 5) (G : Subgroup (Equiv.Perm (Fin 5))) : Prop :=
  ∃ g : Equiv.Perm (Fin 5),
    Subgroup.map (MulAut.conj g).toMonoidHom (referenceSubgroupFive j) = G

/-- **Layer 4.** The resolvent cubic of the depressed quartic `X⁴ + pX² + qX + r`, from
the `D₄`-invariant `x₁x₃ + x₂x₄`. (Named `resolventCubic`, not `resolvent`: in Mathlib
`resolvent` is spectral theory.) -/
noncomputable def resolventCubic {F : Type u} [Field F] (p q r : F) : F[X] :=
  X ^ 3 - C p * X ^ 2 - C (4 * r) * X + C (4 * p * r - q ^ 2)

open scoped Classical in
/-- **Layer 4 prototype.** The orbit resolvent of an invariant
`Φ ∈ F[x₀, …, x_{n−1}]` evaluated at a root vector `x`: the product of `X − Ψ(x)` over
the (finite) orbit of `Φ` under variable permutation. Its degree is the orbit size
`[Sₙ : Stab Φ]`, and for `x` enumerating the roots of a monic separable `f` its
coefficients descend to `F` (stated below). -/
noncomputable def galResolvent {F : Type u} [Field F] {L : Type v} [Field L] [Algebra F L]
    {n : ℕ} (Φ : MvPolynomial (Fin n) F) (x : Fin n → L) : L[X] :=
  ∏ Ψ ∈ Finset.univ.image fun σ : Equiv.Perm (Fin n) => MvPolynomial.rename (⇑σ) Φ,
    (X - C (MvPolynomial.aeval x Ψ))

/-- **Layers 4 and 8, collision evidence for a specialized orbit resolvent.** A general
resolvent supplies a sound subgroup upper bound only when specialization has preserved the
full orbit degree and distinct orbit values. Over a field, separability records the latter.
`GaloisCertificate.Checks` must contain this evidence (or the same evidence after a checked
Tschirnhausen transform) before its upper-bound theorem may run. -/
structure ResolventSeparationEvidence {F : Type u} [Field F] (R : F[X])
    (expectedOrbitDegree : ℕ) : Prop where
  fullOrbitDegree : R.natDegree = expectedOrbitDegree
  specializationSeparated : R.Separable

end Prototypes

section GaloisSide

variable {F : Type u} [Field F]

/-- A polynomial splits in its own splitting field, recorded as a `Fact` so that
`Polynomial.Gal.galActionHom p p.SplittingField` elaborates (Mathlib registers the
`MulAction` instance `galActionAux` for the splitting field, but `galActionHom` asks for
the `Fact`). -/
local instance (p : F[X]) : Fact ((p.map (algebraMap F p.SplittingField)).Splits) :=
  ⟨IsSplittingField.splits p.SplittingField p⟩

/-! ## Layer 0: the permutation representation -/

/-- **Non-vacuity.** The smallest interesting Galois group of a polynomial:
`x³ − 2` over `ℚ` has Galois group of order 6 (it is `S₃ = 3T2`; LMFDB field
`3.1.108.1`). -/
example : Nat.card (X ^ 3 - 2 : ℚ[X]).Gal = 6 :=
  sorry

open scoped Classical in
/-- **Layer 0, orbits ↔ irreducible factors.** For a separable polynomial, the orbits of
the Galois group on the roots correspond to the distinct monic irreducible factors — the
reducible-polynomial workhorse behind every resolvent argument. -/
example (p : F[X]) (hp : p ≠ 0) (hsep : p.Separable) :
    Nat.card (orbitRel.Quotient p.Gal (p.rootSet p.SplittingField)) =
      (UniqueFactorizationMonoid.normalizedFactors p).toFinset.card :=
  sorry

open scoped Classical in
/-- **Layer 0, parity.** The polynomial's parity invariant (LMFDB's even/odd column):
the image of the Galois group lies in the alternating group iff every element acts by an
even permutation of the roots. Layer 3 computes this by the discriminant. -/
example (p : F[X]) (hsep : p.Separable) :
    (Polynomial.Gal.galActionHom p p.SplittingField).range ≤
        alternatingGroup (p.rootSet p.SplittingField) ↔
      ∀ σ : p.Gal, Equiv.Perm.sign (Polynomial.Gal.galActionHom p p.SplittingField σ) = 1 :=
  sorry

/-! ## Layer 2: the Galois ↔ permutation dictionary -/

/-- **Layer 2, prime degree ⟹ primitive** (via `MulAction.IsPreprimitive.of_prime_card`
once the degree bookkeeping is in place). -/
example (p : F[X]) (hp : Irreducible p) (hsep : p.Separable) (hdeg : p.natDegree.Prime) :
    IsPreprimitive p.Gal (p.rootSet p.SplittingField) :=
  sorry

/-- **Layer 2, primitivity ⟺ no proper subfield.** For irreducible separable `p` of
degree `≥ 2` with root `α`: the root action is primitive iff `F(α)/F` has no proper
intermediate field, i.e. iff `F(α)` is an atom of the intermediate-field lattice. (The
degree hypothesis rules out the linear case, where the one-point action is primitive
but `F(α) = ⊥` is not an atom — matching the `[Nontrivial X]` gate on Mathlib's
`isCoatom_stabilizer_iff_preprimitive`, which this transports along the Galois
correspondence and the Layer 1 block–stabilizer dictionary.) -/
example (p : F[X]) (hp : Irreducible p) (hsep : p.Separable) (hdeg : 1 < p.natDegree)
    (α : p.SplittingField) (hα : α ∈ p.rootSet p.SplittingField) :
    IsPreprimitive p.Gal (p.rootSet p.SplittingField) ↔
      IsAtom (IntermediateField.adjoin F {α}) :=
  sorry

/-- **Layer 2, 2-transitivity.** The root action of an irreducible separable `p` of
degree `≥ 2` is 2-transitive iff `p/(X − α)` stays irreducible over `F(α)` (stabilizer
transitivity, via `SubMulAction.ofStabilizer`; the degree hypothesis rules out the
vacuously 2-pretransitive one-point case, where the quotient is `1`). -/
example (p : F[X]) (hp : Irreducible p) (hsep : p.Separable) (hdeg : 1 < p.natDegree)
    (α : p.SplittingField) (hα : α ∈ p.rootSet p.SplittingField) :
    IsMultiplyPretransitive p.Gal (p.rootSet p.SplittingField) 2 ↔
      Irreducible
        ((p.map (algebraMap F (IntermediateField.adjoin F {α}))) /ₘ
          (X - C (IntermediateField.AdjoinSimple.gen F α))) :=
  sorry

/-! ## Layer 3: discriminant ↔ alternating -/

/-- **Layer 3, the root-product formula** (the TODO of
`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean` — coordinate upstream): for a monic
polynomial split by `L` with root enumeration `r`,
`disc f = ∏_{i<j} (rᵢ − rⱼ)²`. -/
example {L : Type v} [Field L] [Algebra F L] (f : F[X]) (hf : f.Monic)
    (r : Fin f.natDegree → L)
    (hr : (f.map (algebraMap F L)).roots = Multiset.map r Finset.univ.val) :
    algebraMap F L f.discr = ∏ i, ∏ j ∈ Finset.Ioi i, (r i - r j) ^ 2 :=
  sorry

/-- **Layer 3, base change of the discriminant** — the bridge Layer 5 uses at
`ℤ → ZMod p`. -/
example {R : Type u} {S : Type v} [CommRing R] [CommRing S] (φ : R →+* S) (f : R[X])
    (hf : f.Monic) : (f.map φ).discr = φ f.discr :=
  sorry

/-- **Layer 3.** Nonvanishing of the discriminant detects separability (monic case). -/
example (f : F[X]) (hf : f.Monic) : f.discr ≠ 0 ↔ f.Separable :=
  sorry

open scoped Classical in
/-- **Layer 3, the discriminant test.** In characteristic `≠ 2`, the Galois image is
contained in the alternating group iff the discriminant is a square. ⚠ False in
characteristic 2 (see `README.md`); the hypothesis is not droppable. -/
example (hchar : ringChar F ≠ 2) (f : F[X]) (hf : f.Monic) (hsep : f.Separable) :
    IsSquare f.discr ↔
      (Polynomial.Gal.galActionHom f f.SplittingField).range ≤
        alternatingGroup (f.rootSet f.SplittingField) :=
  sorry

/-- **Layer 3, worked instance:** `disc (x³ − 3x − 1) = 81 = 9²` — the cyclic cubic
(`3T1`, LMFDB field `3.3.81.1`). Its companion `x³ − 2` has discriminant `−108`, not a
square. -/
example : (X ^ 3 - 3 * X - 1 : ℚ[X]).discr = 81 :=
  sorry

example : ¬ IsSquare (X ^ 3 - 2 : ℚ[X]).discr :=
  sorry

/-! ## Layer 4: the resolvent method -/

open scoped Classical in
/-- **Layer 4, rationality of the orbit resolvent.** Evaluated at an enumeration of the
roots of a monic `f`, the orbit resolvent has coefficients in the base field: it descends
to `F[X]` (fundamental theorem of symmetric polynomials). -/
example {L : Type v} [Field L] [Algebra F L] {n : ℕ} (f : F[X]) (hf : f.Monic)
    (hdeg : f.natDegree = n) (Φ : MvPolynomial (Fin n) F) (x : Fin n → L)
    (hx : (f.map (algebraMap F L)).roots = Multiset.map x Finset.univ.val) :
    ∃ R : F[X], galResolvent Φ x = R.map (algebraMap F L) :=
  sorry

/-- **Layer 4, quartic bookkeeping:** a depressed quartic and its resolvent cubic have
the *same* discriminant. -/
example (p q r : ℚ) :
    (X ^ 4 + C p * X ^ 2 + C q * X + C r : ℚ[X]).discr = (resolventCubic p q r).discr :=
  sorry

/-- **Layer 4, one row of the quartic decision table** (the `A₄` row): irreducible
quartic, irreducible resolvent cubic, square discriminant ⟹ Galois group of order 12.
The full table (`4T1`–`4T5`) is a Layer 4 milestone; worked instance:
`x⁴ + 8x + 12` (LMFDB field `4.0.5184.1`, group `A₄ = 4T4`). -/
example (p q r : ℚ) (hf : Irreducible (X ^ 4 + C p * X ^ 2 + C q * X + C r : ℚ[X]))
    (hres : Irreducible (resolventCubic p q r))
    (hsq : IsSquare (X ^ 4 + C p * X ^ 2 + C q * X + C r : ℚ[X]).discr) :
    Nat.card (X ^ 4 + C p * X ^ 2 + C q * X + C r : ℚ[X]).Gal = 12 :=
  sorry

end GaloisSide

/-! ## Layer 1: the permutation toolkit (pure group theory) -/

section PermutationSide

/-- **Layer 1, the block–stabilizer dictionary** (Wielandt 7.5; Dixon–Mortimer 1.5A):
for a transitive action, the blocks containing a point correspond order-isomorphically to
the subgroups between its stabilizer and the whole group. Mathlib has both endpoints
(`MulAction.BlockMem` is a bounded order; `isCoatom_stabilizer_iff_preprimitive`); this
is the full lattice isomorphism that Layer 2 transports to intermediate fields. -/
example {G : Type u} [Group G] {X : Type v} [MulAction G X] [IsPretransitive G X]
    (a : X) :
    Nonempty ({B : Set X // a ∈ B ∧ IsBlock G B} ≃o Set.Icc (stabilizer G a) ⊤) :=
  sorry

/-- **Layer 1, the imprimitivity grid** (wreath-embedding structure theorem, stated
wreath-free; the `WreathProduct` packaging is a Layer 1 milestone coordinated with
Mathlib's `RegularWreathProduct`): a transitive action with a nontrivial block is a
"block-triangular" action on a grid `Fin m × Fin l` — every element permutes the rows. -/
example {G : Type u} [Group G] {X : Type v} [Finite X] [MulAction G X]
    [IsPretransitive G X] {B : Set X} (hB : IsBlock G B)
    (h1 : 1 < B.ncard) (h2 : B.ncard < Nat.card X) :
    ∃ (m l : ℕ) (e : X ≃ Fin m × Fin l), 1 < m ∧ 1 < l ∧
      ∀ g : G, ∃ σ : Equiv.Perm (Fin m),
        ∀ x : Fin m × Fin l, (e (g • e.symm x)).1 = σ x.1 :=
  sorry

/-- **Layer 1, Jordan's prime-cycle theorem** (Wielandt 13.9) — stated in Mathlib's own
vocabulary; this is verbatim the `proof_wanted
alternatingGroup_le_of_isPreprimitive_of_isCycle_mem` of
`Mathlib/GroupTheory/GroupAction/Jordan.lean` (upstream-first: see `README.md`,
coordination). -/
example {α : Type u} [Fintype α] [DecidableEq α] {G : Subgroup (Equiv.Perm α)}
    (hG : IsPreprimitive G α) {p : ℕ} (hp : p.Prime) (hp' : p + 3 ≤ Nat.card α)
    {g : Equiv.Perm α} (hgc : g.IsCycle) (hgp : g.support.card = p) (hg : g ∈ G) :
    alternatingGroup α ≤ G :=
  sorry

/-! ## Layer 6: transitive subgroups in degree ≤ 5 and the labels -/

/-- **Layer 6, the order spectrum in degree 5:** a transitive subgroup of `S₅` has order
5, 10, 20, 60, or 120. -/
example (G : Subgroup (Equiv.Perm (Fin 5))) [IsPretransitive G (Fin 5)] :
    Nat.card G = 5 ∨ Nat.card G = 10 ∨ Nat.card G = 20 ∨
      Nat.card G = 60 ∨ Nat.card G = 120 :=
  sorry

/-- **Layer 6, order classifies in degree 5:** two transitive subgroups of `S₅` of the
same order are conjugate — the theorem that lets Layer 8 certificates terminate in an
order count. -/
example (G H : Subgroup (Equiv.Perm (Fin 5))) [IsPretransitive G (Fin 5)]
    [IsPretransitive H (Fin 5)] (h : Nat.card G = Nat.card H) :
    ∃ g : Equiv.Perm (Fin 5), Subgroup.map (MulAut.conj g).toMonoidHom G = H :=
  sorry

/-- **Layer 6, the label partition, degree 5:** every transitive subgroup of `S₅` has
exactly one label `5T1`–`5T5`. -/
example (G : Subgroup (Equiv.Perm (Fin 5))) [IsPretransitive G (Fin 5)] :
    ∃! j : Fin 5, HasTransitiveLabelFive j G :=
  sorry

/-- **Layer 6, invariants of the references** (the README table as theorems): `5T2 = D₅`
is *even* (its reflections have cycle type `(1,2,2)`) … -/
example : referenceSubgroupFive 1 ≤ alternatingGroup (Fin 5) :=
  sorry

/-- … while `5T3 = F₂₀` is odd (it contains 4-cycles) and has order 20. -/
example : ¬ referenceSubgroupFive 2 ≤ alternatingGroup (Fin 5) :=
  sorry

example : Nat.card (referenceSubgroupFive 2) = 20 :=
  sorry

/-- **Layer 6, degree 4:** order determines the label except at order 4, where cyclicity
splits `4T1 = C₄` from `4T2 = V₄`: two transitive *cyclic* subgroups of `S₄` of order 4
are conjugate. -/
example (G H : Subgroup (Equiv.Perm (Fin 4))) [IsPretransitive G (Fin 4)]
    [IsPretransitive H (Fin 4)] (hG4 : Nat.card G = 4) (hH4 : Nat.card H = 4)
    (hGc : IsCyclic G) (hHc : IsCyclic H) :
    ∃ g : Equiv.Perm (Fin 4), Subgroup.map (MulAut.conj g).toMonoidHom G = H :=
  sorry

end PermutationSide

/-! ## Layer 5: Frobenius specialization, and the worked examples over `ℚ` -/

section Frobenius

attribute [local instance] Polynomial.Gal.splits_ℚ_ℂ

open scoped Classical in
/-- **Layer 5 — THE CONSUMED INTERFACE** (Dedekind's theorem, supplied by the
[Number Field Arithmetic PR #9](https://github.com/roed-math/TauCetiRoadmap/pull/9), Layer 3; the
shape is pinned here and in `README.md` so nothing downstream blocks; this `sorry` is a
contract with that roadmap, not a target of this one): for monic `f : ℤ[X]` and a prime
`p ∤ disc f`, some element of the Galois group realizes the factorization type of
`f mod p` as its (fixed-point-completed) cycle type on the roots. -/
example (f : ℤ[X]) (hf : f.Monic) (p : ℕ) [Fact p.Prime] (hp : ¬ (p : ℤ) ∣ f.discr) :
    ∃ σ : (f.map (Int.castRingHom ℚ)).Gal,
      fullCycleType (Polynomial.Gal.galActionHom (f.map (Int.castRingHom ℚ)) ℂ σ) =
        Multiset.map (fun g => g.natDegree)
          (UniqueFactorizationMonoid.normalizedFactors (f.map (Int.castRingHom (ZMod p)))) :=
  sorry

/-- **Layer 5, the membership oracle run backwards** (worked instance): `x⁴ + 1` has
Galois group `V₄` (no 4-cycle), so it is reducible modulo *every* prime — the classical
example of an irreducible polynomial over `ℚ` that is never irreducible mod `p`. -/
example (p : ℕ) [Fact p.Prime] : ¬ Irreducible (X ^ 4 + 1 : (ZMod p)[X]) :=
  sorry

/-- **Layers 5–6, the `V₄` label data for `x⁴ + 1`** (LMFDB field `4.0.256.1`, `ℚ(ζ₈)`,
group `4T2`): order 4 and not cyclic. (Consume the cyclotomic API
`galCyclotomicEquivUnitsZMod`: the group is `(ZMod 8)ˣ`.) -/
example : Nat.card (X ^ 4 + 1 : ℚ[X]).Gal = 4 ∧ ¬ IsCyclic (X ^ 4 + 1 : ℚ[X]).Gal :=
  sorry

/-- **Layers 5–6, the `S₅` acceptance instance** (`x⁵ − x − 1`; LMFDB field `5.1.2869.1`,
group `5T5`): the Galois action on the five complex roots is the full symmetric group.
Certificate (README): mod 2 the factorization `(x² + x + 1)(x³ + x² + 1)` exhibits an
order-6 element; mod 5 it is Artin–Schreier, hence irreducible — transitive + order 6
forces `S₅`. -/
example : Function.Bijective (Polynomial.Gal.galActionHom (X ^ 5 - X - 1 : ℚ[X]) ℂ) :=
  sorry

example : Nat.card (X ^ 5 - X - 1 : ℚ[X]).Gal = 120 :=
  sorry

/-! ## Layer 9: the `Sₙ` summit -/

/-- **Layer 9, `Sₙ` is a Galois group over `ℚ` for every `n`** — by the three-primes CRT
construction (van der Waerden §61; Serre, *Topics* §4.4), whose ingredients are exactly
Layers 1 + 5: an `n`-cycle, an `(n−1)`-cycle, and a transposition-yielding element, then
Jordan's swap theorem. Stated as: some monic integer polynomial of degree `n` has full
Galois image on its complex roots. -/
example (n : ℕ) (hn : 1 ≤ n) :
    ∃ f : ℤ[X], f.Monic ∧ f.natDegree = n ∧
      Function.Bijective (Polynomial.Gal.galActionHom (f.map (Int.castRingHom ℚ)) ℂ) :=
  sorry

end Frobenius

end TauCetiRoadmap.PolynomialGaloisGroups
