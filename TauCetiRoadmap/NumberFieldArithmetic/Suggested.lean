import Mathlib

/-!
# Number fields: ramification, Frobenius, and the LMFDB invariants — target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap. What is prototyped here, in preference to end
theorems, are the objects whose choice of carrier, index type, or map determines everything
downstream.

The narrative roadmap (Layers 1–8, the worked examples, and the references) is in
`README.md`. Mathlib is strong here (`IsArithFrobAt`, Hilbert ramification theory,
Kummer–Dedekind over `ℤ`, the different ideal with transitivity), and these targets are the
connections the README identifies as missing: the number-field Frobenius and Artin-symbol
layer, the power-basis index, Dedekind's criterion and Dedekind's cycle-type theorem, the
relative Kummer–Dedekind invariant matching, the relative discriminant, the global–local
dictionary at finite places, the global ramification consequences, monogenicity, explicit
unit certification, and the intrinsic label prefix. They elaborate against the pinned Mathlib
and are stated with `sorry` (allowed in this human-owned roadmap library).

Conventions (pinned in `README.md`):

* Frobenius is Mathlib's **arithmetic** `IsArithFrobAt`, with exponent the *base* residue
  cardinality, and every Frobenius statement lives in a finite Galois extension. There is no
  canonical Frobenius element or class in an absolute Galois group, and nothing here targets
  one.
* The Artin symbol is attached to a nonzero prime **ideal** of `𝓞 K`; the rational-prime form
  is the `K = ℚ` corollary.
* Decomposition group = `MulAction.stabilizer`; higher ramification groups are indexed by `ℕ`,
  with the decomposition group named separately.
* Splits-completely is the `primesOver`-count equation.
* The ideal-theoretic Artin map takes its excluded set of primes as a parameter; specializing
  it to the support of the relative discriminant is a Layer 4 statement.
* Comparison maps are named objects. Where a milestone is a canonical map or equivalence
  (Layer 5's completion map, semi-local decomposition and decomposition-group comparison) the
  prototype is a `def` with its characteristic property, not `∃!` and never `Nonempty (… ≃ …)`,
  since later theorems have to say what the map does to particular elements.
* Concrete fields are presented by a generator `θ : 𝓞 K` with its `minpoly ℤ θ` and
  `Algebra.adjoin ℚ {(θ : K)} = ⊤`, matching the landed TauCeti files.
* ⚠ `Equiv.Perm.cycleType` omits fixed points; partition-valued statements add the `1`s back.
* No Artin conductor object and no conductor exponent is defined anywhere in this roadmap; the
  abelian conductor–discriminant formula belongs to the Global Class Field Theory roadmap.
-/

namespace TauCetiRoadmap.NumberFieldArithmetic

open scoped NumberField Pointwise nonZeroDivisors
open Polynomial IsDedekindDomain

variable {K : Type*} [Field K] [NumberField K]

/-! ## Layer 1: the splitting dictionary -/

/-- **Layer 1, the double-coset law** (Neukirch I §9, p. 55; absent upstream). For `M/ℚ`
Galois, `K` an intermediate field with fixing subgroup `H`, and `D` the decomposition group
(`MulAction.stabilizer`) of a prime `Q` over `p`, the double cosets `H\G/D` biject with the
primes of `𝓞 K` over `p`. -/
noncomputable def doubleCosetEquiv {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M]
    (K : IntermediateField ℚ M) (p : ℕ) [Fact p.Prime] (Q : Ideal (𝓞 M)) [Q.IsPrime]
    [Q.LiesOver (Ideal.span {(p : ℤ)})] :
    DoubleCoset.Quotient (K.fixingSubgroup : Set (M ≃ₐ[ℚ] M))
        (MulAction.stabilizer (M ≃ₐ[ℚ] M) Q) ≃
      Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 K) :=
  sorry

/-- **Layer 1, the bijection is `HσD ↦ σQ ∩ K`.** Without this the equivalence above says only
that two finite sets have the same size, and the `e`/`f` read-off along it (a companion
milestone, README Layer 1) could not be stated at all. -/
example {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M] (K : IntermediateField ℚ M)
    (p : ℕ) [Fact p.Prime] (Q : Ideal (𝓞 M)) [Q.IsPrime]
    [Q.LiesOver (Ideal.span {(p : ℤ)})] (σ : M ≃ₐ[ℚ] M) :
    (doubleCosetEquiv K p Q (Quotient.mk _ σ) : Ideal (𝓞 K)) = (σ • Q).under (𝓞 K) :=
  sorry

/-- **Layer 1, totally split ⟺ totally split in the Galois closure** (Neukirch I §9 Ex. 4),
via the double-coset law. `hM` says `M` is the Galois closure of `K`. -/
example {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M] (K : IntermediateField ℚ M)
    (hM : IntermediateField.normalClosure ℚ K M = ⊤) {p : ℕ} [Fact p.Prime] :
    (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 K)).ncard = Module.finrank ℚ K ↔
      (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 M)).ncard = Module.finrank ℚ M :=
  sorry

/-! ## Layer 2: Frobenius elements and the Artin symbol, at finite level -/

/-- **Layer 2, existence of the relative Frobenius.** For `L/K` finite Galois and `Q` a
nonzero prime of `𝓞 L`, there is a Frobenius `σ ∈ Gal(L/K)` at `Q`: the number-field
instantiation of the pin's `IsArithFrobAt.exists_of_isInvariant`, generalizing TauCeti's
landed base-`ℚ` `exists_isArithFrobAt`. ⚠ The exponent is the *base* residue cardinality
`#(𝓞 K ⧸ Q ∩ 𝓞 K)`, per the conventions table. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (Q : Ideal (𝓞 L)) [Q.IsPrime] (hQ : Q ≠ ⊥) :
    ∃ σ : L ≃ₐ[K] L, IsArithFrobAt (𝓞 K) σ Q :=
  sorry

/-- **Layer 2, group-level uniqueness at unramified primes.** The pin proves uniqueness at
`AlgHom` level (`AlgHom.IsArithFrobAt.eq_of_isUnramifiedAt`); the Galois-group statement is
the missing faithfulness upgrade. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    {σ τ : L ≃ₐ[K] L} {Q : Ideal (𝓞 L)} [Q.IsPrime] (hQ : Q ≠ ⊥)
    [Algebra.IsUnramifiedAt (𝓞 K) Q] (hσ : IsArithFrobAt (𝓞 K) σ Q)
    (hτ : IsArithFrobAt (𝓞 K) τ Q) :
    σ = τ :=
  sorry

/-- **Layer 2, the Artin symbol is well defined, at a prime ideal of the base.** For `𝔭` a
nonzero prime of `𝓞 K` unramified in `L`, all Frobenius elements at all primes of `𝓞 L` over
`𝔭` lie in one conjugacy class: the class `artinSymbol 𝔭`. Existence is the pin's
`IsArithFrobAt.exists_of_isInvariant`, conjugacy across the fiber is `isConj_arithFrobAt`,
and this statement packages both as the defining property of the `ConjClasses`-valued symbol.
⚠ Relative and prime-ideal-indexed: the familiar `(p, K/ℚ)` is the `K = ℚ` specialization
`𝔭 = Ideal.span {(p : ℤ)}`, stated as a corollary and not as the definition. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (𝔭 : Ideal (𝓞 K)) [𝔭.IsMaximal] (h𝔭 : 𝔭 ≠ ⊥)
    (hur : ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver 𝔭], Algebra.IsUnramifiedAt (𝓞 K) Q) :
    ∃! c : ConjClasses (L ≃ₐ[K] L),
      ∀ (Q : Ideal (𝓞 L)) (σ : L ≃ₐ[K] L), Q.IsPrime →
        Q.LiesOver 𝔭 → IsArithFrobAt (𝓞 K) σ Q → ConjClasses.mk σ = c :=
  sorry

/-- **Layer 2, base-`ℚ` specialization of the Artin symbol.** The rational-prime form the
LMFDB pages display, obtained from the relative statement by `𝔭 = Ideal.span {(p : ℤ)}`. -/
example [IsGalois ℚ K] {p : ℕ} [Fact p.Prime]
    (hp : ∀ (Q : Ideal (𝓞 K)) [Q.IsPrime] [Q.LiesOver (Ideal.span {(p : ℤ)})],
      Algebra.IsUnramifiedAt ℤ Q) :
    ∃! c : ConjClasses (K ≃ₐ[ℚ] K),
      ∀ (Q : Ideal (𝓞 K)) (σ : K ≃ₐ[ℚ] K), Q.IsPrime →
        Q.LiesOver (Ideal.span {(p : ℤ)}) → IsArithFrobAt ℤ σ Q → ConjClasses.mk σ = c :=
  sorry

/-- **Layer 2, the order of Frobenius is the inertia degree** (at an unramified prime). With
the pin's `Ideal.card_stabilizer_eq`, this also gives `zpowers (Frob Q) = stabilizer`. -/
example [IsGalois ℚ K] {p : ℕ} [Fact p.Prime] {Q : Ideal (𝓞 K)} [Q.IsPrime]
    [Q.LiesOver (Ideal.span {(p : ℤ)})] [Algebra.IsUnramifiedAt ℤ Q]
    {σ : K ≃ₐ[ℚ] K} (hσ : IsArithFrobAt ℤ σ Q) :
    orderOf σ = (Ideal.span {(p : ℤ)}).inertiaDegIn (𝓞 K) :=
  sorry

/-- **Layer 2, restriction to a normal subextension.** Nothing upstream relates Frobenius
elements along `AlgEquiv.restrictNormal`; this is the tower half of the Artin-symbol
functoriality. -/
example {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M] (K : IntermediateField ℚ M)
    [Normal ℚ K] {σ : M ≃ₐ[ℚ] M} {Q : Ideal (𝓞 M)} (hσ : IsArithFrobAt ℤ σ Q) :
    IsArithFrobAt ℤ (σ.restrictNormal K) (Q.under (𝓞 K)) :=
  sorry

/-- **Layer 2, the ideal-theoretic Artin map, in the carrier the Global Class Field Theory
roadmap pinned.** The excluded set `S` is a **parameter**: any finite set of primes outside
which `L/K` is unramified will do, and the construction says nothing about which primes those
are. That is what keeps this layer independent of the relative discriminant, and it is also
what PR #6 needs, since the support of its modulus `𝔪₀` is generally larger than the ramified
set. `J` is the group `J^S` of invertible fractional ideals with zero valuation on `S`, spelled
inside `(FractionalIdeal (𝓞 K)⁰ K)ˣ` exactly as PR #6 spells `J^{𝔪₀}`, and the map sends a
prime outside `S` to its Frobenius. Uniqueness is automatic because the primes generate `J`, so
the milestone is existence together with the values on primes. Specializing `S` to the support
of the relative discriminant is a Layer 4 statement, below. ⚠ Reciprocity (kernel,
surjectivity, factorization through ray class groups) is deliberately absent: PR #6 owns it
and consumes this map literally. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (hab : ∀ σ τ : L ≃ₐ[K] L, Commute σ τ)
    (S : Finset (HeightOneSpectrum (𝓞 K)))
    (hur : ∀ v : HeightOneSpectrum (𝓞 K), v ∉ S →
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal], Algebra.IsUnramifiedAt (𝓞 K) Q)
    (J : Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ)
    (hJ : ∀ I : (FractionalIdeal (𝓞 K)⁰ K)ˣ,
      I ∈ J ↔ ∀ v ∈ S, FractionalIdeal.count K v (I : FractionalIdeal (𝓞 K)⁰ K) = 0) :
    ∃ φ : J →* (L ≃ₐ[K] L),
      ∀ (v : HeightOneSpectrum (𝓞 K)), v ∉ S → ∀ (I : J),
        ((I : (FractionalIdeal (𝓞 K)⁰ K)ˣ) : FractionalIdeal (𝓞 K)⁰ K) =
          (v.asIdeal : FractionalIdeal (𝓞 K)⁰ K) →
        ∀ (Q : Ideal (𝓞 L)) (_ : Q.IsPrime) (_ : Q.LiesOver v.asIdeal) (σ : L ≃ₐ[K] L),
          IsArithFrobAt (𝓞 K) σ Q → φ I = σ :=
  sorry

/-- **Layer 2, the cyclotomic Frobenius is `p` itself.** The pin has the decomposition
*subgroup* (`IsCyclotomicExtension.Rat.galEquivZMod_stabilizer` = `⟨[p]⟩`) but never
identifies the Frobenius *element*; both halves exist (`IsArithFrobAt.apply_of_pow_eq_one`,
`galEquivZMod_apply_of_pow_eq`). -/
example {n : ℕ} [NeZero n] {K : Type*} [Field K] [NumberField K]
    [IsCyclotomicExtension {n} ℚ K] {p : ℕ} [Fact p.Prime] (hp : p.Coprime n)
    {Q : Ideal (𝓞 K)} [Q.IsPrime] [Q.LiesOver (Ideal.span {(p : ℤ)})]
    {σ : K ≃ₐ[ℚ] K} (hσ : IsArithFrobAt ℤ σ Q) :
    IsCyclotomicExtension.Rat.galEquivZMod n K σ = ZMod.unitOfCoprime p hp :=
  sorry

/-- **Layer 2, the quadratic Frobenius, with every hypothesis written out.** `p` is a finite
prime, odd (so that the Legendre symbol is available) and prime to `d` (so that `p` is
unramified and `θ` has exponent prime to `p`); `θ` is an integral generator with the stated
minimal polynomial. This upgrades TauCeti's landed `isArithFrobAt_apply_sqrt_eq_self_iff`
from an element identity to a statement about the symbol. -/
example {θ : 𝓞 K} {d : ℤ} (hd : Squarefree d) (hmin : minpoly ℤ θ = X ^ 2 - C d)
    (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) [IsGalois ℚ K]
    {p : ℕ} [Fact p.Prime] (hp2 : p ≠ 2) (hpd : ¬ (p : ℤ) ∣ d)
    {Q : Ideal (𝓞 K)} [Q.IsPrime] [Q.LiesOver (Ideal.span {(p : ℤ)})]
    {σ : K ≃ₐ[ℚ] K} (hσ : IsArithFrobAt ℤ σ Q) :
    σ = 1 ↔ legendreSym p d = 1 :=
  sorry

/-- **Layer 2, the canonical element at a ramified real place is complex conjugation.** The
stabilizer of a place of `L` above a real place `w` of `K` that ramifies has order `2` (pin);
this names its generator. ⚠ It is never called a Frobenius: there is no residue field and no
`q`-power congruence at an infinite place. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (w : NumberField.InfinitePlace L) (hw : w.IsComplex)
    (hv : (w.comap (algebraMap K L)).IsReal) :
    ∃ σ : L ≃ₐ[K] L, σ ≠ 1 ∧ σ * σ = 1 ∧
      MulAction.stabilizer (L ≃ₐ[K] L) w = Subgroup.zpowers σ :=
  sorry

/-! ## Layer 3: the index, Dedekind–Kummer, and Dedekind's theorem -/

/-- **Layer 3, the carrier for the power-basis index.** ⚠ The index must not be defined by a
raw `Nat.card` on all of `𝓞 K`: a non-generator gives an infinite quotient and Mathlib's
fallback value `0`, which would make every divisibility statement about it silently true.
Restricting to integral generators keeps it junk-free. -/
def IntegralPrimitiveElement (K : Type*) [Field K] [NumberField K] : Type _ :=
  {θ : 𝓞 K // Algebra.adjoin ℚ {(θ : K)} = ⊤}

/-- **Layer 3, the power-basis index** `[𝓞 K : ℤ[θ]]`, on the junk-free carrier. Positivity
(both modules are free of rank `finrank ℚ K`, so the quotient is finite) is the companion
milestone. -/
noncomputable def index (θ : IntegralPrimitiveElement K) : ℕ :=
  Nat.card (𝓞 K ⧸ Subalgebra.toSubmodule (Algebra.adjoin ℤ {θ.1}))

example (θ : IntegralPrimitiveElement K) : 0 < index θ := sorry

/-- **Layer 3, the index formula** `disc(minpoly θ) = index(θ)² · disc K`, the equation
sharpening TauCeti's landed inequality `abs_discr_le_of_basis_isIntegral`. The link
`Algebra.discr ℚ (powerBasis θ) = Polynomial.discr (minpoly ℤ θ)` is the companion milestone;
both objects exist upstream and are never connected. -/
example (θ : IntegralPrimitiveElement K) :
    (minpoly ℤ θ.1).discr = (index θ : ℤ) ^ 2 * NumberField.discr K :=
  sorry

/-- **Layer 3, index and exponent have the same prime divisors.** ⚠ The two invariants are
different integers in general (`RingOfIntegers.exponent` is the `absNorm` of the contracted
order conductor), and only the index satisfies the formula above; this is what lets a
`p ∤ exponent` hypothesis be checked by discriminant arithmetic. -/
example (θ : IntegralPrimitiveElement K) (p : ℕ) [Fact p.Prime] :
    p ∣ index θ ↔ p ∣ RingOfIntegers.exponent θ.1 :=
  sorry

/-- **Layer 3, the checkable hypothesis.** The implication every polynomial-side statement
below uses, proved here rather than assumed: a prime not dividing the discriminant of the
minimal polynomial does not divide the exponent. -/
example (θ : IntegralPrimitiveElement K) (p : ℕ) [Fact p.Prime]
    (hp : ¬ (p : ℤ) ∣ (minpoly ℤ θ.1).discr) :
    ¬ p ∣ RingOfIntegers.exponent θ.1 :=
  sorry

/-- **Layer 3, relative Kummer–Dedekind invariant matching.** The pin matches `fᵢ` with
factor degrees only over `ℤ`
(`NumberField.Ideal.inertiaDeg_primesOverSpanEquivMonicFactorsMod_symm_apply`); this is the
AKLB form against the general equivalence of `Mathlib/NumberTheory/KummerDedekind.lean`. The
`eᵢ = multiplicity` companion is the matching milestone. -/
example {R S : Type*} [CommRing R] [IsDomain R] [IsIntegrallyClosed R] [CommRing S]
    [IsDedekindDomain S] [Algebra R S] [Module.IsTorsionFree R S] {x : S}
    (hx : IsIntegral R x) {I : Ideal R} (hI : I.IsMaximal) (hI' : I ≠ ⊥)
    (hcond : (conductor R x).comap (algebraMap R S) ⊔ I = ⊤)
    {J : Ideal S} (hJ : J ∈ UniqueFactorizationMonoid.normalizedFactors
      (I.map (algebraMap R S))) :
    Ideal.inertiaDeg I J =
      (KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk
        hI hI' hcond hx ⟨J, hJ⟩).val.natDegree :=
  sorry

/-- **Layer 3, Dedekind's criterion, over `ℤ`** (Cohen §6.1). Stated for the base `ℤ` because
the criterion divides by `p`, which has no base-free meaning; a relative version needs a
chosen uniformizer and explicit localization hypotheses and is not a milestone. `φ` lists the
distinct monic irreducible factors of `f mod p` with multiplicities `e`, `Φ` lists monic lifts,
and `H` is the quotient by `p` of `f − ∏ Φᵢ^{eᵢ}` (whose coefficientwise divisibility by `p`
is a companion milestone, as is independence of the criterion from the choice of lifts).
⚠ `he` says every listed multiplicity is positive, so that `ι` indexes exactly the irreducibles
occurring in the factorization. Without it the statement is false: an index with `eᵢ = 0`
leaves both the factorization and `H` unchanged, but its `φᵢ` still has to divide `H mod p`
for the right-hand side to hold. -/
example (θ : IntegralPrimitiveElement K) (p : ℕ) [Fact p.Prime]
    {ι : Type} [Fintype ι] (φ : ι → (ZMod p)[X]) (e : ι → ℕ) (Φ : ι → ℤ[X]) (H : ℤ[X])
    (hφ : ∀ i, Irreducible (φ i)) (hφm : ∀ i, (φ i).Monic) (hinj : Function.Injective φ)
    (he : ∀ i, 0 < e i)
    (hfact : (minpoly ℤ θ.1).map (Int.castRingHom (ZMod p)) = ∏ i, φ i ^ e i)
    (hΦm : ∀ i, (Φ i).Monic)
    (hΦ : ∀ i, (Φ i).map (Int.castRingHom (ZMod p)) = φ i)
    (hH : C (p : ℤ) * H = minpoly ℤ θ.1 - ∏ i, Φ i ^ e i) :
    ¬ p ∣ index θ ↔ ∀ i, e i = 1 ∨ ¬ φ i ∣ H.map (Int.castRingHom (ZMod p)) :=
  sorry

/-- **Layer 3, splitting fields of rational polynomials are number fields.** Needed so that
`Polynomial.Gal f` is the Galois group of a number field and Frobenius elements are available
in it directly; without it the cycle-type theorem can only be stated in an auxiliary Galois
number field where `f` splits, and the transfer back is left implicit. -/
example (f : ℚ[X]) (hf : f ≠ 0) : NumberField f.SplittingField := sorry

open scoped Classical in
/-- **Layer 3, Dedekind's theorem** (the named statement supplied to the
PolynomialGaloisGroups roadmap): at `p` prime to the exponent with squarefree reduction, the
degree multiset of the monic irreducible factors of `minpoly θ mod p` is the cycle type of any
Frobenius at `p` acting on the roots in a Galois number field `M` where the polynomial splits,
as partitions of `n`. ⚠ `Equiv.Perm.cycleType` omits fixed points, hence the explicit
`replicate _ 1` correction. -/
example {θ : 𝓞 K} (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) {p : ℕ} [Fact p.Prime]
    (hexp : ¬ p ∣ RingOfIntegers.exponent θ)
    (hsq : Squarefree ((minpoly ℤ θ).map (Int.castRingHom (ZMod p))))
    {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M]
    [Fact (((minpoly ℚ (θ : K)).map (algebraMap ℚ M)).Splits)]
    {Q : Ideal (𝓞 M)} [Q.IsPrime] [Q.LiesOver (Ideal.span {(p : ℤ)})]
    {σ : M ≃ₐ[ℚ] M} (hσ : IsArithFrobAt ℤ σ Q) :
    (RingOfIntegers.monicFactorsMod θ p).val.map Polynomial.natDegree =
      (Polynomial.Gal.galActionHom (minpoly ℚ (θ : K)) M
          (Polynomial.Gal.restrict (minpoly ℚ (θ : K)) M σ)).cycleType +
        Multiset.replicate
          (Nat.card (Function.fixedPoints
            (Polynomial.Gal.galActionHom (minpoly ℚ (θ : K)) M
              (Polynomial.Gal.restrict (minpoly ℚ (θ : K)) M σ)))) 1 :=
  sorry

attribute [local instance] Polynomial.Gal.splits_ℚ_ℂ

open scoped Classical in
/-- **Layer 3, the polynomial-side corollary, for arbitrary monic `f`.** This is the exact
interface PolynomialGaloisGroups PR #10 consumes, and it consumes it on **reducible** `f` (it
derives the classical mod-`p` irreducibility criterion from it), so the statement genuinely
covers reducible `f` and the reduction to irreducible factors is a milestone, not an
afterthought: `p ∤ f.discr` gives separability and pairwise coprime reductions of the `ℤ`-irreducible
factors, the root set is their disjoint union, full cycle type and factor-degree multisets are
both additive along that decomposition, and one Frobenius upstairs restricts to a Frobenius on
each factor's field. The right side restores fixed points, matching that roadmap's
`fullCycleType`. -/
example (f : ℤ[X]) (hf : f.Monic) (p : ℕ) [Fact p.Prime] (hp : ¬ (p : ℤ) ∣ f.discr) :
    ∃ σ : (f.map (Int.castRingHom ℚ)).Gal,
      (Polynomial.Gal.galActionHom (f.map (Int.castRingHom ℚ)) ℂ σ).cycleType +
          Multiset.replicate
            (Fintype.card ((f.map (Int.castRingHom ℚ)).rootSet ℂ) -
              (Polynomial.Gal.galActionHom
                (f.map (Int.castRingHom ℚ)) ℂ σ).support.card) 1 =
        Multiset.map (fun g => g.natDegree)
          (UniqueFactorizationMonoid.normalizedFactors (f.map (Int.castRingHom (ZMod p)))) :=
  sorry

/-- **Layer 3, common index divisors and the counting obstruction.** Dedekind's field is the
worked instance: `2` splits completely into three primes of residue degree `1`, but `𝔽₂` has
only two monic linear polynomials, so no integral generator can have index prime to `2`. -/
example (p : ℕ) [Fact p.Prime]
    (hsplit : (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 K)).ncard = Module.finrank ℚ K)
    (hcount : Nat.card {g : (ZMod p)[X] // g.Monic ∧ Irreducible g ∧ g.natDegree = 1} <
      Module.finrank ℚ K) :
    ∀ θ : IntegralPrimitiveElement K, p ∣ index θ :=
  sorry

/-! ## Layer 4: the relative discriminant, algebraically -/

/-- **Layer 4, the relative discriminant ideal, reconciled.** The relative norm of the
different is the (ideal generated by the) absolute discriminant: the ideal-level sharpening
of the pin's `NumberField.absNorm_differentIdeal`, and the `L/ℚ` instance of the missing
`relDiscr A B := Ideal.relNorm A (differentIdeal A B)`. -/
example : Ideal.relNorm ℤ (differentIdeal ℤ (𝓞 K)) = Ideal.span {NumberField.discr K} :=
  sorry

/-- **Layer 4, the relative discriminant in towers** (Neukirch III (2.10)):
`𝔡_{M/K} = 𝔡_{L/K}^{[M:L]} · N_{L/K}(𝔡_{M/L})` at the level of discriminant ideals, from
the pin's different-ideal transitivity (`differentIdeal_eq_differentIdeal_mul_differentIdeal`)
and multiplicativity of `Ideal.relNorm`. The pin has only the absolute `ℤ`-version
(`NumberField.natAbs_discr_eq_absNorm_differentIdeal_mul_natAbs_discr_pow`); the relative
statement is absent upstream. -/
example {L M : Type*} [Field L] [NumberField L] [Field M] [NumberField M] [Algebra K L]
    [Algebra L M] [Algebra K M] [IsScalarTower K L M] :
    Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 M)) =
      Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 L)) ^ Module.finrank L M *
        Ideal.relNorm (𝓞 K) (Ideal.relNorm (𝓞 L) (differentIdeal (𝓞 L) (𝓞 M))) :=
  sorry

/-- **Layer 4, ramified ⟺ divides the relative discriminant** (Neukirch III (2.12)),
generalizing the pin's `ℚ`-only `NumberField.not_dvd_discr_iff_forall_liesOver`. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (p : Ideal (𝓞 K)) [p.IsMaximal] (hp : p ≠ ⊥) :
    ¬ p ∣ Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 L)) ↔
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver p], Algebra.IsUnramifiedAt (𝓞 K) Q :=
  sorry

/-- **Layer 4, the ramified support is finite**, being the set of prime divisors of a nonzero
ideal of a Dedekind domain. This is what turns the ramified set into a `Finset`; feeding that
`Finset` and the criterion above into Layer 2's Artin map gives the classical map on the
fractional ideals prime to the discriminant. The dependency runs this way and not the other:
Layer 2 takes its excluded set as a parameter and does not know about `relDiscr`. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] :
    ∃ S : Finset (HeightOneSpectrum (𝓞 K)), ∀ v : HeightOneSpectrum (𝓞 K),
      v ∈ S ↔ v.asIdeal ∣ Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 L)) :=
  sorry

/-- **Layer 4, Stickelberger's congruence** (absent upstream): the discriminant of a number
field is `0` or `1 mod 4`. -/
example : NumberField.discr K % 4 = 0 ∨ NumberField.discr K % 4 = 1 :=
  sorry

/-! ## Layer 5: the global–local dictionary at finite places

⚠ The pin's own `Module.Finite K_v L_w` instance quantifies over an **arbitrary**
`[Algebra K_v L_w] [ContinuousSMul K_v L_w] [IsScalarTower K K_v L_w]`, so a theorem stated
that way is a theorem about an arbitrary compatible structure and can be about the wrong
extension. Nothing in this section does that. The comparison maps are named objects, not
existence statements: `∃! f, …` fixes a map mathematically but leaves later theorems with
nothing to be about, and `Nonempty (… ≃ …)` does not even do that. -/

/-- **Layer 5, completions of number fields are local fields.** The full class, not merely
local compactness, which is one of its corollaries. ⚠ Stated once
`ValuativeRel (v.adicCompletion K)` is available through the `Valued`-compatibility layer;
the `Valued → ValuativeRel` migration must be a refactor of this instance, not a re-proof. -/
example (v : HeightOneSpectrum (𝓞 K)) [ValuativeRel (v.adicCompletion K)] :
    IsNonarchimedeanLocalField (v.adicCompletion K) :=
  sorry

/-- **Layer 5, the canonical completion of an extension**, as an object. For `w ∣ v` there is
exactly one continuous ring map `K_v → L_w` compatible with `K → L`, and this is it; every
theorem below is about this map. -/
noncomputable def completionAlgHom {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    v.adicCompletion K →ₐ[K] w.adicCompletion L :=
  sorry

/-- **Layer 5, continuity of the canonical map.** -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Continuous (completionAlgHom (K := K) v w) :=
  sorry

/-- **Layer 5, uniqueness of the canonical map**: any continuous ring map extending `K → L`
is it. This is what licenses calling it *the* completion of the extension. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal]
    (f : v.adicCompletion K →+* w.adicCompletion L) (hf : Continuous f)
    (hcomp : ∀ x : K, f (algebraMap K (v.adicCompletion K) x) =
      algebraMap L (w.adicCompletion L) (algebraMap K L x)) :
    f = (completionAlgHom (K := K) v w : v.adicCompletion K →+* w.adicCompletion L) :=
  sorry

/-- **Layer 5, the algebra structure the canonical map induces.** Everything downstream uses
this instance and no other; with an arbitrary compatible structure the statements below could
be about a different extension. -/
@[reducible] noncomputable def completionAlgebra {L : Type*} [Field L] [NumberField L]
    [Algebra K L] (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Algebra (v.adicCompletion K) (w.adicCompletion L) :=
  (completionAlgHom v w : v.adicCompletion K →+* w.adicCompletion L).toAlgebra

attribute [local instance] completionAlgebra

/-- The subtype of primes over `v` carries its `LiesOver` proof; making that an instance is
what lets `K_v`-algebra structures be found for each factor of the semi-local decomposition. -/
local instance liesOverOfMem {L : Type*} [Field L] [NumberField L] [Algebra K L]
    {v : HeightOneSpectrum (𝓞 K)}
    (w : {w : HeightOneSpectrum (𝓞 L) // w.asIdeal.LiesOver v.asIdeal}) :
    w.1.asIdeal.LiesOver v.asIdeal := w.2

/-- **Layer 5, the compatibility instances for the canonical structure.** The pin states
`Module.Finite K_v L_w` for an arbitrary compatible algebra structure; here it is a statement
about `completionAlgebra`, and the pin's version is the corollary. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    IsScalarTower K (v.adicCompletion K) (w.adicCompletion L) :=
  sorry

example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    ContinuousSMul (v.adicCompletion K) (w.adicCompletion L) :=
  sorry

example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Module.Finite (v.adicCompletion K) (w.adicCompletion L) :=
  sorry

open scoped TensorProduct in
/-- **Layer 5, the semi-local decomposition** `K_v ⊗_K L ≅ ∏_{w ∣ v} L_w` (Neukirch II (8.3)),
as a named `K_v`-algebra equivalence. The completion is written on the left so that the
`K_v`-algebra structure on the source is Mathlib's `Algebra.TensorProduct.leftAlgebra`; the
index type is the subtype of `HeightOneSpectrum (𝓞 L)` lying over `v`, and its named
equivalence with `Ideal.primesOver v.asIdeal (𝓞 L)` is a companion milestone so that both
spellings are available. Consequence: `Σ_{w ∣ v} [L_w : K_v] = [L : K]`, the finite-place
analogue of the pin's archimedean `InfinitePlace.sum_inertiaDeg_eq_finrank`. -/
noncomputable def semilocalEquiv {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) :
    (v.adicCompletion K ⊗[K] L) ≃ₐ[v.adicCompletion K]
      ((w : {w : HeightOneSpectrum (𝓞 L) // w.asIdeal.LiesOver v.asIdeal}) →
        w.1.adicCompletion L) :=
  sorry

open scoped TensorProduct in
/-- **Layer 5, what the semi-local equivalence does.** Its value on pure tensors is what pins
it down; without this the definition above could be any of many equivalences and no
compatibility theorem downstream would mean anything. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (a : v.adicCompletion K) (x : L)
    (w : {w : HeightOneSpectrum (𝓞 L) // w.asIdeal.LiesOver v.asIdeal}) :
    semilocalEquiv v (a ⊗ₜ x) w =
      algebraMap (v.adicCompletion K) (w.1.adicCompletion L) a *
        algebraMap L (w.1.adicCompletion L) x :=
  sorry

/-- **Layer 5, the local degree is `e·f` at a finite place**, with `e` and `f` the *global*
`Ideal.ramificationIdx`/`inertiaDeg`. Their local `e·f = n` is the LocalFields roadmap's; the
equality of the two factor pairs is this milestone. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Module.finrank (v.adicCompletion K) (w.adicCompletion L) =
      Ideal.ramificationIdx v.asIdeal w.asIdeal * Ideal.inertiaDeg v.asIdeal w.asIdeal :=
  sorry

/-- **Layer 5, the decomposition group is the local Galois group** (Neukirch II §9), again as
a named map: continuous extension of the action on `L`. -/
noncomputable def decompositionHom {L : Type*} [Field L] [NumberField L] [Algebra K L]
    [IsGalois K L] (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    MulAction.stabilizer (L ≃ₐ[K] L) w.asIdeal →*
      ((w.adicCompletion L) ≃ₐ[v.adicCompletion K] (w.adicCompletion L)) :=
  sorry

/-- **Layer 5, what `decompositionHom` does**: it extends the action on the dense image of
`L`, which is also what forces injectivity. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal]
    (σ : MulAction.stabilizer (L ≃ₐ[K] L) w.asIdeal) (x : L) :
    decompositionHom v w σ (algebraMap L (w.adicCompletion L) x) =
      algebraMap L (w.adicCompletion L) ((σ : L ≃ₐ[K] L) x) :=
  sorry

/-- **Layer 5, `decompositionHom` is bijective**, hence the isomorphism `D_Q ≅ Gal(L_w/K_v)`.
Compatibility with the residue maps, and the fact that it carries `IsArithFrobAt` to the
LocalFields Layer-2 Frobenius, are the companion milestones: the two conventions agree by
construction, and this is what makes that agreement a theorem. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Function.Bijective (decompositionHom v w) :=
  sorry

/-- **Layer 5, the canonical map on integers.** The completion map carries `𝓞_{K_v}` into
`𝓞_{L_w}`; this is the algebra structure the local different is formed for. -/
@[reducible] noncomputable def completionIntegersAlgebra {L : Type*} [Field L] [NumberField L]
    [Algebra K L] (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Algebra (v.adicCompletionIntegers K) (w.adicCompletionIntegers L) :=
  sorry

attribute [local instance] completionIntegersAlgebra

/-- **Layer 5, the completed integer rings form a torsion-free extension.** Part of the same
milestone: without it `differentIdeal` cannot even be formed for the local extension. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal] :
    Module.IsTorsionFree (v.adicCompletionIntegers K) (w.adicCompletionIntegers L) :=
  sorry

/-- **Layer 5, the different localizes** (Neukirch III (2.2)(iii)), written with the actual
ideal map into the completed integer ring rather than as informal multiplication by
`𝓞_{L_w}`. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal]
    [Module.IsTorsionFree (v.adicCompletionIntegers K) (w.adicCompletionIntegers L)] :
    (differentIdeal (𝓞 K) (𝓞 L)).map (algebraMap (𝓞 L) (w.adicCompletionIntegers L)) =
      differentIdeal (v.adicCompletionIntegers K) (w.adicCompletionIntegers L) :=
  sorry

/-- **Layer 5, the relative discriminant valuation, with the residue-degree weights written
out.** In the multiplicity normalization pinned by the conventions table, and stated with a
`finsum` so that no finiteness instance has to be threaded through. This is where every
exponent computation of Layer 6 lands. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] (v : HeightOneSpectrum (𝓞 K)) :
    multiplicity v.asIdeal (Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 L))) =
      ∑ᶠ P ∈ Ideal.primesOver v.asIdeal (𝓞 L),
        Ideal.inertiaDeg v.asIdeal P * multiplicity P (differentIdeal (𝓞 K) (𝓞 L)) :=
  sorry

/-! ## Layer 6: global ramification consequences

This layer transports the LocalFields roadmap's Layer-3 ramification theory through Layer 5.
It builds no second ramification theory: Herbrand's theorem, upper numbering and Hasse–Arf
are theirs and are not restated. -/

/-- **Layer 6, the global lower filtration.** Indexed by `ℕ`, so `G 0` is inertia; the
decomposition group keeps its own name and is never `G (-1)`. The definition is the easy part;
its central API is the comparison with the local filtration of `L_w/K_v` under the Layer-5
isomorphism, which is how every further property is obtained. -/
noncomputable def ramificationGroup {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (Q : Ideal (𝓞 L)) (i : ℕ) : Subgroup (L ≃ₐ[K] L) where
  carrier := {σ | σ ∈ MulAction.stabilizer (L ≃ₐ[K] L) Q ∧ ∀ x : 𝓞 L,
    (galRestrict (𝓞 K) K L (𝓞 L) σ) x - x ∈ Q ^ (i + 1)}
  one_mem' := sorry
  mul_mem' := sorry
  inv_mem' := sorry

example {L : Type*} [Field L] [NumberField L] [Algebra K L] (Q : Ideal (𝓞 L)) :
    ramificationGroup (K := K) Q 0 = Q.inertia (L ≃ₐ[K] L) :=
  sorry

/-- **Layer 6, the comparison with the local filtration**, which is this object's whole
purpose. It is a statement about Layer 5's named `decompositionHom`, so that an element can
actually be moved across the identification; "the two groups are isomorphic" would be useless
here. The local groups enter as a parameter `Gloc` together with their defining congruence,
which is PR #2's definition: the statement is therefore about *their* filtration, and this
roadmap does not build a second one. Once their `G_i` exists, `hGloc` is discharged by
`rfl`-level unfolding and drops out. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal]
    (Gloc : ℕ → Subgroup ((w.adicCompletion L) ≃ₐ[v.adicCompletion K] (w.adicCompletion L)))
    (hGloc : ∀ (j : ℕ) (τ : (w.adicCompletion L) ≃ₐ[v.adicCompletion K] (w.adicCompletion L)),
      τ ∈ Gloc j ↔ ∀ x : w.adicCompletionIntegers L,
        ∃ y ∈ IsLocalRing.maximalIdeal (w.adicCompletionIntegers L) ^ (j + 1),
          τ (x : w.adicCompletion L) - (x : w.adicCompletion L) = (y : w.adicCompletion L))
    (i : ℕ) (σ : MulAction.stabilizer (L ≃ₐ[K] L) w.asIdeal) :
    (σ : L ≃ₐ[K] L) ∈ ramificationGroup (K := K) w.asIdeal i ↔
      decompositionHom v w σ ∈ Gloc i :=
  sorry

/-- **Layer 6, the different-exponent formula** `v_Q(𝔡) = Σ_{i ≥ 0} (#G_i − 1)`
(Serre LF IV §1 Prop. 4), obtained by transporting the LocalFields Layer-3 local formula
through the Layer-5 comparison and different-localization statements. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (Q : Ideal (𝓞 L)) [Q.IsPrime] (hQ : Q ≠ ⊥) :
    multiplicity Q (differentIdeal (𝓞 K) (𝓞 L)) =
      ∑ᶠ i : ℕ, (Nat.card (ramificationGroup (K := K) Q i) - 1) :=
  sorry

/-- **Layer 6, the exact tame exponent** (Neukirch III (2.6); the pin has only
`P^{e−1} ∣ 𝔡`): in the tame case `P^e` does *not* divide the different, so `v_P(𝔡) = e − 1`
exactly.

⚠ Hypotheses. This and the next statement are about a finite **separable** extension of
fraction fields. Without separability the trace form vanishes, `differentIdeal` is the zero
ideal, and `v_P(𝔡)` is a junk value. Two Dedekind domains with a finite torsion-free algebra
between them cannot express that hypothesis, so the prototype is stated for number fields,
where separability is automatic. The milestone in `README.md` is the AKLB form, with `A`
Dedekind with fraction field `K`, `[Algebra.IsSeparable K L]`, and `B` the integral closure of
`A` in `L`; the number-field statement here is its instance and fixes the shape of the
conclusion. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    {p : Ideal (𝓞 K)} [p.IsMaximal] (hp : p ≠ ⊥)
    {P : Ideal (𝓞 L)} [P.IsPrime] [P.LiesOver p]
    (htame : ¬ ringChar (𝓞 K ⧸ p) ∣ Ideal.ramificationIdx p P) :
    ¬ P ^ Ideal.ramificationIdx p P ∣ differentIdeal (𝓞 K) (𝓞 L) :=
  sorry

/-- **Layer 6, the wild bounds** `e ≤ v_P(𝔡) ≤ e − 1 + v_P(e)` (Neukirch III (2.6), Serre LF
III §6 Prop. 13), with `v_P(e)` the multiplicity of `P` in the ideal generated by `e`, in the
same normalization as `v_P(𝔡)`. The lower bound is attained at `2` in `ℚ(i)` and the upper
bound is strict there, which is the dyadic worked example. ⚠ The upper bound is not a
LocalFields milestone and is not cited as one: it is proved here from their structure theorem,
which makes the local extension monogenic, together with the pin's
`conductor_mul_differentIdeal`. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    {p : Ideal (𝓞 K)} [p.IsMaximal] (hp : p ≠ ⊥)
    {P : Ideal (𝓞 L)} [P.IsPrime] [P.LiesOver p]
    (hwild : ringChar (𝓞 K ⧸ p) ∣ Ideal.ramificationIdx p P)
    (he : Ideal.ramificationIdx p P ≠ 0) :
    Ideal.ramificationIdx p P ≤ multiplicity P (differentIdeal (𝓞 K) (𝓞 L)) ∧
      multiplicity P (differentIdeal (𝓞 K) (𝓞 L)) ≤
        Ideal.ramificationIdx p P - 1 +
          multiplicity P (Ideal.span {(Ideal.ramificationIdx p P : 𝓞 L)}) :=
  sorry

/-- **Layer 6, the permutation-action discriminant exponent formula.** Both sides are
integers and no conductor object appears: `#(G i ⊓ H)` is the number of elements of `G i`
fixing the base point of `G/H`, so the right-hand side is a fixed-point count for the
permutation action. A future ArtinRepresentations roadmap may recognize this integer as an
Artin conductor; that identification is theirs and is needed by nothing here. -/
example {L : Type*} [Field L] [NumberField L] [IsGalois ℚ L] (M : IntermediateField ℚ L)
    (Q : Ideal (𝓞 L)) [Q.IsPrime] (hQ : Q ≠ ⊥) :
    Ideal.ramificationIdx (Q.under (𝓞 M)) Q *
        multiplicity (Q.under (𝓞 M)) (differentIdeal ℤ (𝓞 M)) =
      ∑ᶠ i : ℕ, (Nat.card (ramificationGroup (K := ℚ) Q i) -
        Nat.card ((ramificationGroup (K := ℚ) Q i ⊓ M.fixingSubgroup :
          Subgroup (L ≃ₐ[ℚ] L)))) :=
  sorry

/-! ## Layer 7: subfields, integral bases, monogenicity, and explicit units -/

/-- **Layer 7, the monogenicity predicate.** Suggested public name and carrier:
`NumberField.IsMonogenic K`, a property of the field; it is declared in this roadmap's own
namespace here rather than claiming `NumberField.IsMonogenic` before implementation.
⚠ Search Mathlib for an existing `IsMonogenic` at implementation time, and keep it out of the
root namespace: a bare `IsMonogenic` invites a collision with a future generic ring-theoretic
version, and if such a version lands this becomes an abbreviation for it. -/
def IsMonogenic (K : Type*) [Field K] [NumberField K] : Prop :=
  ∃ θ : 𝓞 K, Algebra.adjoin ℤ {θ} = ⊤

/-- **Layer 7, quadratic integral bases, the `d ≡ 1 mod 4` half**: for squarefree
`d ≡ 1 mod 4`, a root of `X² − X + (1−d)/4`, that is `(1+√d)/2`, generates `𝓞 K`. The
`d ≡ 2, 3 mod 4` half (`ℤ[√d]`) and `disc = d` versus `4d` are companions; TauCeti's landed
`QuadraticIntegralBasis` is the `{1, x}`-basis seed this generalizes. -/
example {θ : 𝓞 K} {d : ℤ} (hd : Squarefree d) (hd4 : d % 4 = 1)
    (hmin : minpoly ℤ θ = X ^ 2 - X + C ((1 - d) / 4))
    (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) :
    Algebra.adjoin ℤ {θ} = ⊤ :=
  sorry

/-- **Layer 7 ⚠ dyadic acceptance**: `2` splits in `ℚ(√d)` (`d ≡ 1 mod 4` squarefree,
`ω`-presentation) iff `d ≡ 1 mod 8`. This is unreachable from the `X² − d` presentation, whose
exponent is even here, which is why it is the test that no oddness hypothesis has crept into
Layers 3 or 7. -/
example {θ : 𝓞 K} {d : ℤ} (hd : Squarefree d) (hd4 : d % 4 = 1)
    (hmin : minpoly ℤ θ = X ^ 2 - X + C ((1 - d) / 4))
    (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) :
    (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 2 ↔ d % 8 = 1 :=
  sorry

/-- **Layer 7, explicit unit certification, the criterion.** Mathlib's Dirichlet theorem gives
*a* fundamental system and `regOfFamily_div_regulator` gives the index of a candidate family,
but nothing upstream certifies that a *named* unit generates modulo torsion, so no exact
regulator value can be asserted without this. In rank one there are exactly two infinite
places, `w v = 1` characterizes torsion for either of them, and generation is minimality: no
unit lies strictly between `1` and `u`. -/
example (hrank : NumberField.Units.rank K = 1) (w : NumberField.InfinitePlace K)
    (u : (𝓞 K)ˣ) (hu : 1 < w ((u : 𝓞 K) : K)) :
    Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤ ↔
      ∀ v : (𝓞 K)ˣ, w ((v : 𝓞 K) : K) ≤ 1 ∨ w ((u : 𝓞 K) : K) ≤ w ((v : 𝓞 K) : K) :=
  sorry

/-- **Layer 7, the finiteness that makes the criterion checkable.** A unit bounded at every
infinite place has all its archimedean absolute values bounded, so the pin's
`NumberField.Embeddings.finite_of_norm_le` applies and the candidate set is finite; for a real
quadratic or a signature-`(1,1)` cubic field this becomes a finite search over integral minimal
polynomials with bounded coefficients. ⚠ "Mathlib has Dirichlet's unit theorem" is not a proof
of index one, and no worked example may cite it as one. -/
example (B : ℝ) :
    {u : (𝓞 K)ˣ | ∀ w : NumberField.InfinitePlace K, w ((u : 𝓞 K) : K) ≤ B}.Finite :=
  sorry

/-- **Layer 7, the regulator of a certified generator.** Once the closure statement above
holds, `regOfFamily_div_regulator` has index `1` and the regulator is a computation about one
explicit unit. -/
example (u : (𝓞 K)ˣ) (hu : Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤) :
    NumberField.Units.regOfFamily (fun _ : Fin (NumberField.Units.rank K) => u) =
      NumberField.Units.regulator K :=
  sorry

/-- **Layer 7, the rank-one evaluation.** ⚠ Do not drop `w.mult`. In rank one there are exactly
two infinite places and `Σ_w mult w · log (w u) = log |N u| = 0`, so the two choices of `w`
agree; but a version without the factor is wrong at every field with a complex place, since the
regulator of `ℚ(ζ₅)` is `2·log((1+√5)/2)`. Mathlib's `logEmbedding` carries `mult` for the same
reason. Note also that `Real.log` is applied to `w u`, a real number, and never to a unit:
there is no `Real.log` of an element of `𝓞 K`. -/
example (hrank : NumberField.Units.rank K = 1) (w : NumberField.InfinitePlace K)
    (u : (𝓞 K)ˣ) (hu : 1 < w ((u : 𝓞 K) : K))
    (hgen : Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤) :
    NumberField.Units.regulator K = w.mult * Real.log (w ((u : 𝓞 K) : K)) :=
  sorry

/-! ## Layer 8: the intrinsic LMFDB label prefix and the worked suite

Worked examples as acceptance criteria; the numerics are verified in `README.md`.
Presentations follow the landed TauCeti idiom: a generator `θ : 𝓞 K` with its integral
minimal polynomial and `Algebra.adjoin ℚ {(θ : K)} = ⊤`. The displayed LMFDB names are
external identifiers for the examples; this roadmap certifies only their intrinsic
`d.r.|D|` prefix, never the database-order `.i` coordinate. -/

/-- **Layer 8, the intrinsic label prefix.** The three coordinates that are intrinsic
theorems. ⚠ The `.i` coordinate is deliberately not here and is not a deliverable of this
roadmap in any form: it needs a certified database ordering, a canonical defining polynomial,
isomorphism deduplication, and a bounded-list completeness certificate, none of which is
extractable from `finite_of_discr_bdd`. -/
def HasLMFDBIntrinsicLabel (K : Type*) [Field K] [NumberField K] (d r D : ℕ) : Prop :=
  Module.finrank ℚ K = d ∧ NumberField.InfinitePlace.nrRealPlaces K = r ∧
    (NumberField.discr K).natAbs = D

/-- **Layer 8, sign recovery.** The prefix carries `|D|` only, and Brill's theorem
(`NumberField.sign_discr`) recovers the sign from the signature, so no separate sign datum is
needed. -/
example {d r D : ℕ} (h : HasLMFDBIntrinsicLabel K d r D) :
    NumberField.discr K = (-1 : ℤ) ^ ((d - r) / 2) * D :=
  sorry

section Worked_2_2_5_1
/-! **LMFDB `2.2.5.1` = ℚ(√5)**, presented by `θ = (1+√5)/2`, `minpoly = X² − X − 1`. The
class number and the zeta residue are consumed from Mathlib; the discriminant, torsion, unit
certification and splitting are proved here. -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 2 - X - 1)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = 5 := sorry

example : HasLMFDBIntrinsicLabel K 2 2 5 := sorry

example : NumberField.classNumber K = 1 := sorry

example : NumberField.Units.torsionOrder K = 2 := sorry

/-- The certification: the golden ratio generates the units modulo torsion. Layer 7's
criterion plus the finite search; this is the statement that makes the next one legitimate. -/
example (u : (𝓞 K)ˣ) (hu : (u : 𝓞 K) = θ) :
    Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤ := sorry

/-- Hence `regulator = log((1+√5)/2)`. -/
example : NumberField.Units.regulator K = Real.log ((1 + Real.sqrt 5) / 2) := sorry

/-- The class-number-formula consistency check: `ζ_K` has residue `2·log((1+√5)/2)/√5`, one
equation crossing the certified unit, the class number, the discriminant, and the CNF
normalization. -/
example : NumberField.dedekindZeta_residue K =
    2 * Real.log ((1 + Real.sqrt 5) / 2) / Real.sqrt 5 := sorry

/-- `2` is inert in `ℚ(√5)` (`5 ≡ 5 mod 8`). -/
example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 1 := sorry

end Worked_2_2_5_1

section Worked_2_0_4_1
/-! **LMFDB `2.0.4.1` = ℚ(i)**, presented by `θ = i`, `minpoly = X² + 1`. The dyadic case:
`2` is wildly ramified, the wild lower bound `e ≤ v_P(𝔡)` of Layer 6 is attained, and the
upper bound `e − 1 + v_P(e) = 3` is strict. This is the example a tame-only exponent formula
must not claim. -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 2 + 1)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

/-- ⚠ The sign is Brill's theorem in action: `r₂ = 1`, so `discr < 0`. -/
example : NumberField.discr K = -4 := sorry

example : HasLMFDBIntrinsicLabel K 2 0 4 := sorry

example : NumberField.classNumber K = 1 := sorry

example : NumberField.Units.torsionOrder K = 4 := sorry

/-- `ℤ[i]` is the full ring of integers: index `1`, and `K` is monogenic. -/
example : Algebra.adjoin ℤ {θ} = ⊤ := sorry

/-- `2` is totally ramified: `(2) = P²` with `P = (1 + i)`. -/
example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 1 := sorry

example : Ideal.ramificationIdxIn (Ideal.span {(2 : ℤ)}) (𝓞 K) = 2 := sorry

/-- The wild lower bound is attained: `v_P(𝔡) = 2 = e`, while `e − 1 + v_P(e) = 3`. -/
example {P : Ideal (𝓞 K)} [P.IsPrime] [P.LiesOver (Ideal.span {(2 : ℤ)})] :
    multiplicity P (differentIdeal ℤ (𝓞 K)) = 2 := sorry

end Worked_2_0_4_1

section Worked_4_0_125_1
/-! **LMFDB `4.0.125.1` = ℚ(ζ₅)** as `CyclotomicField 5 ℚ`. Discriminant, class number,
torsion and monogenicity are consumed from the pin (`IsCyclotomicExtension.Rat.discr_prime`,
`five_pid`); the Frobenius data and the subfield lattice are proved here. ⚠ The
conductor–discriminant instance `∏_{χ mod 5} cond(χ) = 125` is **not** a target of this
roadmap: it is the Global Class Field Theory roadmap's abelian conductor–discriminant theorem,
quoted as a cross-check once that roadmap proves it. -/

example : NumberField.discr (CyclotomicField 5 ℚ) = 125 := sorry

example : HasLMFDBIntrinsicLabel (CyclotomicField 5 ℚ) 4 0 125 := sorry

example : NumberField.classNumber (CyclotomicField 5 ℚ) = 1 := sorry

example : NumberField.Units.torsionOrder (CyclotomicField 5 ℚ) = 10 := sorry

/-- The subfield lattice of `ℚ(ζ₅)` is `{ℚ, ℚ(√5), ℚ(ζ₅)}`, the subgroup lattice of `C₄`. -/
example : Nat.card (IntermediateField ℚ (CyclotomicField 5 ℚ)) = 3 := sorry

/-- `11 ≡ 1 mod 5` splits completely in `ℚ(ζ₅)`. -/
example : (Ideal.primesOver (Ideal.span {(11 : ℤ)}) (𝓞 (CyclotomicField 5 ℚ))).ncard = 4 :=
  sorry

/-- `2` has order `4` in `(ℤ/5)ˣ`, so `f(2) = 4`: `2` is inert in `ℚ(ζ₅)`. -/
example : (Ideal.span {(2 : ℤ)}).inertiaDegIn (𝓞 (CyclotomicField 5 ℚ)) = 4 := sorry

end Worked_4_0_125_1

section Worked_3_1_23_1
/-! **LMFDB `3.1.23.1`**: the non-Galois cubic `X³ − X² + 1`, `disc = −23` squarefree (so the
index is `1`), `S₃` Galois closure. The unramified splitting data at `2, 3, 5, 7, 59` are
instances of Layer 3's Dedekind theorem. ⚠ `23` is ramified, so there is **no** Frobenius
class and **no** cycle type at `23`; its factorization is a Kummer–Dedekind statement and is
listed separately below. -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 3 - X ^ 2 + 1)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = -23 := sorry

example : HasLMFDBIntrinsicLabel K 3 1 23 := sorry

example : ¬ IsGalois ℚ K := sorry

example : NumberField.classNumber K = 1 := sorry

example : NumberField.Units.rank K = 1 := sorry

/-- The explicit unit: `θ·(θ² − θ) = −1`, so `θ² − θ = −θ⁻¹` is a positive unit. -/
example : θ * (θ ^ 2 - θ) = -1 := sorry

/-- The certification, by Layer 7's criterion and the finite search: `θ² − θ` generates the
units modulo torsion. Only after this is the regulator value legitimate. -/
example (u : (𝓞 K)ˣ) (hu : (u : 𝓞 K) = θ ^ 2 - θ) :
    Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤ := sorry

/-- The exact regulator, at the unique real place `w` (so `w.mult = 1`), where
`w (θ² − θ) ≈ 1.3247 > 1`. Numerically `≈ 0.2812`, but the decimal is orientation, not the
target. ⚠ The real place has to be named: `θ² − θ` is an element of `𝓞 K`, so `Real.log` of it
is not an expression at all. -/
example (w : NumberField.InfinitePlace K) (hw : w.IsReal)
    (u : (𝓞 K)ˣ) (hu : (u : 𝓞 K) = θ ^ 2 - θ)
    (hgen' : Subgroup.closure {u} ⊔ NumberField.Units.torsion K = ⊤) :
    NumberField.Units.regulator K = Real.log (w ((u : 𝓞 K) : K)) := sorry

/-- `2` is inert, cycle type `(3)`: `X³ + X² + 1` is irreducible over `𝔽₂`. -/
example : (RingOfIntegers.monicFactorsMod θ 2).val.map Polynomial.natDegree = {3} := sorry

example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 1 := sorry

/-- `5` has splitting type `(1,2)`. -/
example : (Ideal.primesOver (Ideal.span {(5 : ℤ)}) (𝓞 K)).ncard = 2 := sorry

/-- `59` splits completely, so its Frobenius class is `1`. ⚠ The roadmap does **not** claim
that `59` is the *least* totally split prime: that needs a finite check at every smaller
prime, which no milestone here performs. -/
example : (Ideal.primesOver (Ideal.span {(59 : ℤ)}) (𝓞 K)).ncard = 3 := sorry

/-- ⚠ `23` is **ramified** (`23 ∣ discr K`), so this is ramification data from
Kummer–Dedekind and the different, not a Frobenius cycle type: `(23) = 𝔭²𝔮`, with the double
root of `minpoly mod 23` at `16` and the simple root at `15`. -/
example : (Ideal.primesOver (Ideal.span {(23 : ℤ)}) (𝓞 K)).ncard = 2 := sorry

/-- `23` divides the discriminant, which is what "ramified" means here (the pin's
`not_dvd_discr_iff_forall_liesOver`); Layer 2's Artin symbol is undefined at such a prime. -/
example : (23 : ℤ) ∣ NumberField.discr K := sorry

/-- `3.1.23.1` has no proper subfield: no subgroup strictly between `C₂` and `S₃`. -/
example : Nat.card (IntermediateField ℚ K) = 2 := sorry

end Worked_3_1_23_1

section Worked_3_1_503_1
/-! **LMFDB `3.1.503.1` = Dedekind's field** `ℚ[x]/(x³ − x² − 2x − 8)`: `disc(f) = −4·503`,
`disc K = −503`, index `2`. The prime `2` splits completely although no cubic over `𝔽₂` has
three distinct linear factors, so `2` is a common index divisor and `𝓞 K` is not monogenic
(Neukirch III §2 Ex. 1). This is why Layer 3's polynomial-side corollary is hypothesized on
`p ∤ f.discr` and not on "`p` unramified": here `2` is unramified and the factorization of
`f mod 2` still lies about the splitting. -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 3 - X ^ 2 - 2 * X - 8)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = -503 := sorry

example : HasLMFDBIntrinsicLabel K 3 1 503 := sorry

/-- The index-divisor caveat as a theorem: `2` splits completely even though
`f mod 2 = x²(x+1)`, so the polynomial factorization does *not* compute the splitting here. -/
example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 3 := sorry

/-- `2` is a common index divisor: every integral generator has even index. -/
example : ∀ θ' : IntegralPrimitiveElement K, 2 ∣ index θ' := sorry

/-- Hence `𝓞 K` is not monogenic. -/
example : ¬ IsMonogenic K := sorry

end Worked_3_1_503_1

end TauCetiRoadmap.NumberFieldArithmetic
