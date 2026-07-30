import Mathlib

/-!
# Number fields — ramification, Frobenius, and the LMFDB invariants: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 1–8, the worked examples, and the references) is in
`README.md`. Mathlib is strong here — `IsArithFrobAt`, Hilbert ramification theory,
Kummer–Dedekind over `ℤ`, the different ideal with transitivity — and these targets are the
*connective tissue* the README identifies as missing: the number-field Frobenius/Artin-symbol
layer, Dedekind's cycle-type theorem, the relative Kummer–Dedekind invariant matching, exact
different exponents and the discriminant bookkeeping, the double-coset splitting law, the
global↔local seam, monogenicity, and the LMFDB flagship examples. They elaborate against the
pinned Mathlib and are stated with `sorry` (allowed in this human-owned roadmap library).

Conventions (pinned in `README.md`): Frobenius is Mathlib's **arithmetic** `IsArithFrobAt`
(exponent = the *base* residue cardinality); decomposition group = `MulAction.stabilizer`;
splits-completely is the `primesOver`-count equation; concrete fields are presented by a
generator `θ : 𝓞 K` with its `minpoly ℤ θ` and `Algebra.adjoin ℚ {(θ : K)} = ⊤`, matching
the landed TauCeti files. ⚠ `Equiv.Perm.cycleType` omits fixed points; partition-valued
statements add the `1`s back explicitly.
-/

namespace TauCetiRoadmap.NumberFieldArithmetic

open scoped NumberField Pointwise
open Polynomial IsDedekindDomain

variable {K : Type*} [Field K] [NumberField K]

/-! ## Layer 1: the splitting dictionary -/

/-- **Layer 1, the double-coset law** (Neukirch I §9, p. 55; absent upstream). For `M/ℚ`
Galois, `K` an intermediate field with fixing subgroup `H`, and `D` the decomposition group
(`MulAction.stabilizer`) of a prime `Q` over `p`, the primes of `𝓞 K` over `p` biject with
the double cosets `H\G/D`. The `e`/`f` read-off along the bijection is a companion milestone
(README Layer 1). -/
example {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M] (K : IntermediateField ℚ M)
    {p : ℕ} [Fact p.Prime] (Q : Ideal (𝓞 M)) [Q.IsPrime]
    [Q.LiesOver (Ideal.span {(p : ℤ)})] :
    Nonempty ((Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 K)) ≃
      DoubleCoset.Quotient (K.fixingSubgroup : Set (M ≃ₐ[ℚ] M))
        (MulAction.stabilizer (M ≃ₐ[ℚ] M) Q)) :=
  sorry

/-- **Layer 1, totally split ⟺ totally split in the Galois closure** (Neukirch I §9 Ex. 4),
via the double-coset law. `hM` says `M` is the Galois closure of `K`. -/
example {M : Type*} [Field M] [NumberField M] [IsGalois ℚ M] (K : IntermediateField ℚ M)
    (hM : IntermediateField.normalClosure ℚ K M = ⊤) {p : ℕ} [Fact p.Prime] :
    (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 K)).ncard = Module.finrank ℚ K ↔
      (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 M)).ncard = Module.finrank ℚ M :=
  sorry

/-! ## Layer 2: Frobenius elements and the Artin symbol -/

/-- **Layer 2, existence of the relative Frobenius.** For `L/K` finite Galois and `Q` a
nonzero prime of `𝓞 L`, there is a Frobenius `σ ∈ Gal(L/K)` at `Q` — the number-field
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
example [IsGalois ℚ K] {σ τ : K ≃ₐ[ℚ] K} {Q : Ideal (𝓞 K)} [Q.IsPrime] (hQ : Q ≠ ⊥)
    [Algebra.IsUnramifiedAt ℤ Q] (hσ : IsArithFrobAt ℤ σ Q) (hτ : IsArithFrobAt ℤ τ Q) :
    σ = τ :=
  sorry

/-- **Layer 2, the Artin symbol is well defined.** At a prime `p` unramified in `K`, all
Frobenius elements at all primes over `p` lie in one conjugacy class — the class `(p, K/ℚ)`.
Existence is the pin's `IsArithFrobAt.exists_of_isInvariant` (via TauCeti's landed
`exists_isArithFrobAt`); conjugacy across the fiber is `isConj_arithFrobAt`; this statement
packages both as the defining property of the `ConjClasses`-valued symbol. -/
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

/-! ## Layer 3: Dedekind–Kummer and Dedekind's theorem -/

/-- **Layer 3, relative Kummer–Dedekind invariant matching.** The pin matches `fᵢ` with
factor degrees only over `ℤ` (`NumberField.Ideal.inertiaDeg_primesOverSpanEquivMonicFactorsMod_symm_apply`);
this is the AKLB form against the general equivalence of `Mathlib/NumberTheory/KummerDedekind.lean`.
The `eᵢ = multiplicity` companion is the matching milestone. -/
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

open scoped Classical in
/-- **Layer 3, Dedekind's theorem** (the named statement consumed by the
PolynomialGaloisGroups roadmap): at `p` prime to the index with squarefree reduction, the
degree multiset of the monic irreducible factors of `minpoly θ mod p` is the cycle type of
any Frobenius at `p` acting on the roots in a splitting field `M` — as partitions of `n`.
⚠ `Equiv.Perm.cycleType` omits fixed points, hence the explicit `replicate _ 1` correction.
(`M` is any Galois number field where `minpoly` splits — the `Fact` hypothesis is the pin's
`Polynomial.Gal` idiom; the canonical `SplittingField` has no `NumberField` instance.) -/
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

/-! ## Layer 4: the different and the relative discriminant -/

/-- **Layer 4, the relative discriminant ideal, reconciled.** The relative norm of the
different is the (ideal generated by the) absolute discriminant — the ideal-level sharpening
of the pin's `NumberField.absNorm_differentIdeal`, and the `L/ℚ` instance of the missing
`relDiscr A B := Ideal.relNorm A (differentIdeal A B)`. -/
example : Ideal.relNorm ℤ (differentIdeal ℤ (𝓞 K)) = Ideal.span {NumberField.discr K} :=
  sorry

/-- **Layer 4, the relative discriminant in towers** (Neukirch III (2.10)):
`𝔡_{M/K} = 𝔡_{L/K}^{[M:L]} · N_{L/K}(𝔡_{M/L})` at the level of discriminant ideals — from
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
generalizing the pin's `ℚ`-only `NumberField.not_dvd_discr_iff_forall_liesOver`; the
finiteness of the set of ramified primes is the one-line corollary. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (p : Ideal (𝓞 K)) [p.IsMaximal] (hp : p ≠ ⊥) :
    ¬ p ∣ Ideal.relNorm (𝓞 K) (differentIdeal (𝓞 K) (𝓞 L)) ↔
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver p], Algebra.IsUnramifiedAt (𝓞 K) Q :=
  sorry

/-- **Layer 4, the exact tame exponent** (Neukirch III (2.6); the pin has only
`P^{e−1} ∣ 𝔡`): in the tame case `P^e` does *not* divide the different, so
`v_P(𝔡) = e − 1` exactly. -/
example {A B : Type*} [CommRing A] [IsDedekindDomain A] [CommRing B]
    [IsDedekindDomain B] [Algebra A B] [Module.Finite A B] [Module.IsTorsionFree A B]
    {p : Ideal A} [p.IsMaximal] (hp : p ≠ ⊥) [Finite (A ⧸ p)]
    {P : Ideal B} [P.IsPrime] [P.LiesOver p]
    (htame : ¬ ringChar (A ⧸ p) ∣ Ideal.ramificationIdx p P) :
    ¬ P ^ Ideal.ramificationIdx p P ∣ differentIdeal A B :=
  sorry

/-- **Layer 4, the wild lower bound** `e ≤ v_P(𝔡)` (Neukirch III (2.6)): in the wild case
`P^e` *does* divide the different. The upper bound `v_P(𝔡) ≤ e − 1 + v_P(e)` is the
companion milestone. -/
example {A B : Type*} [CommRing A] [IsDedekindDomain A] [CommRing B]
    [IsDedekindDomain B] [Algebra A B] [Module.Finite A B] [Module.IsTorsionFree A B]
    {p : Ideal A} [p.IsMaximal] (hp : p ≠ ⊥) [Finite (A ⧸ p)]
    {P : Ideal B} [P.IsPrime] [P.LiesOver p]
    (hwild : ringChar (A ⧸ p) ∣ Ideal.ramificationIdx p P)
    (he : Ideal.ramificationIdx p P ≠ 0) :
    P ^ Ideal.ramificationIdx p P ∣ differentIdeal A B :=
  sorry

/-- **Layer 4, Stickelberger's congruence** (absent upstream): the discriminant of a number
field is `0` or `1 mod 4`. -/
example : NumberField.discr K % 4 = 0 ∨ NumberField.discr K % 4 = 1 :=
  sorry

/-! ## Layer 5: conductor–discriminant, a worked instance -/

/-- **Layer 5, conductor–discriminant for `ℚ(ζ₅)`, fully in reach of the pin**: the product
of the conductors of the four Dirichlet characters mod `5` is `1·5·5·5 = 125 = |disc ℚ(ζ₅)|`.
The pin has both sides (`DirichletCharacter.conductor`, `IsCyclotomicExtension.Rat.discr_prime`)
and no bridge. -/
example : ∏ χ : DirichletCharacter ℂ 5, χ.conductor =
    (NumberField.discr (CyclotomicField 5 ℚ)).natAbs :=
  sorry

/-! ## Layer 6: the global ↔ local dictionary -/

/-- **Layer 6, local degree = e·f at a finite place** — the finite-place analogue of the
pin's archimedean `InfinitePlace.sum_inertiaDeg_eq_finrank`, and the seam lemma with the
LocalFields roadmap (their local `e·f = n` meets this through `Ideal.ramificationIdx`
reconciliation). The semi-local sum `Σ_{w∣v} [L_w : K_v] = [L : K]` is the companion. -/
example {L : Type*} [Field L] [NumberField L] [Algebra K L]
    (v : HeightOneSpectrum (𝓞 K)) (w : HeightOneSpectrum (𝓞 L))
    [w.asIdeal.LiesOver v.asIdeal]
    [Algebra (v.adicCompletion K) (w.adicCompletion L)]
    [ContinuousSMul (v.adicCompletion K) (w.adicCompletion L)]
    [IsScalarTower K (v.adicCompletion K) (w.adicCompletion L)] :
    Module.finrank (v.adicCompletion K) (w.adicCompletion L) =
      Ideal.ramificationIdx v.asIdeal w.asIdeal * Ideal.inertiaDeg v.asIdeal w.asIdeal :=
  sorry

/-- **Layer 6, completions of number fields are locally compact** — the first stone of the
`IsNonarchimedeanLocalField (v.adicCompletion K)` instance chain (stated here in
pin-available vocabulary; the full instance is the milestone, in the LocalFields
conventions). -/
example (v : HeightOneSpectrum (𝓞 K)) : LocallyCompactSpace (v.adicCompletion K) :=
  sorry

/-! ## Layer 7: integral bases and monogenicity -/

/-- **Layer 7, the index formula** `disc(θ) = [𝓞 K : ℤ[θ]]² · disc K` — the equation
sharpening TauCeti's landed inequality `abs_discr_le_of_basis_isIntegral`. -/
example (θ : 𝓞 K) (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) :
    Algebra.discr ℚ (fun i : Fin (Module.finrank ℚ K) => (θ : K) ^ (i : ℕ)) =
      (Nat.card (𝓞 K ⧸ Subalgebra.toSubmodule (Algebra.adjoin ℤ {θ})) : ℚ) ^ 2 *
        NumberField.discr K :=
  sorry

/-- **Layer 7, quadratic integral bases, the `d ≡ 1 mod 4` half**: for squarefree
`d ≡ 1 mod 4`, a root of `X² − X + (1−d)/4` (i.e. `(1+√d)/2`) generates `𝓞 K`. The
`d ≡ 2, 3 mod 4` half (`ℤ[√d]`) and `disc = d` vs `4d` are companions; TauCeti's landed
`QuadraticIntegralBasis` is the `{1, x}`-basis seed this generalizes. -/
example {θ : 𝓞 K} {d : ℤ} (hd : Squarefree d) (hd4 : d % 4 = 1)
    (hmin : minpoly ℤ θ = X ^ 2 - X + C ((1 - d) / 4))
    (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) :
    Algebra.adjoin ℤ {θ} = ⊤ :=
  sorry

/-- **Layer 7 ⚠ dyadic acceptance**: `2` splits in `ℚ(√d)` (`d ≡ 1 mod 4` squarefree,
`ω`-presentation) iff `d ≡ 1 mod 8` — unreachable from the `X² − d` presentation, whose
`exponent` is even here; this is the worked example keeping the `p = 2` case honest. -/
example {θ : 𝓞 K} {d : ℤ} (hd : Squarefree d) (hd4 : d % 4 = 1)
    (hmin : minpoly ℤ θ = X ^ 2 - X + C ((1 - d) / 4))
    (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤) :
    (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 2 ↔ d % 8 = 1 :=
  sorry

/-! ## Layer 8: the LMFDB flagship suite

Worked examples as acceptance criteria; the numerics are verified in `README.md`.
Presentations follow the landed TauCeti idiom: a generator `θ : 𝓞 K` with its integral
minimal polynomial and `Algebra.adjoin ℚ {(θ : K)} = ⊤`. -/

section Flagship_2_2_5_1
/-! **LMFDB `2.2.5.1` = ℚ(√5)**, presented by `θ = (1+√5)/2`, `minpoly = X² − X − 1`. -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 2 - X - 1)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = 5 := sorry

example : NumberField.classNumber K = 1 := sorry

example : NumberField.Units.torsionOrder K = 2 := sorry

/-- The fundamental unit of `ℚ(√5)` is the golden ratio: `regulator = log((1+√5)/2)`. -/
example : NumberField.Units.regulator K = Real.log ((1 + Real.sqrt 5) / 2) := sorry

/-- The class-number-formula smoke test: `ζ_K` has residue `2·log((1+√5)/2)/√5` — one
equation crossing the unit, class-number, discriminant, and CNF normalizations. -/
example : NumberField.dedekindZeta_residue K =
    2 * Real.log ((1 + Real.sqrt 5) / 2) / Real.sqrt 5 := sorry

/-- `2` is inert in `ℚ(√5)` (`5 ≡ 5 mod 8`). -/
example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 1 := sorry

end Flagship_2_2_5_1

section Flagship_4_0_125_1
/-! **LMFDB `4.0.125.1` = ℚ(ζ₅)** as `CyclotomicField 5 ℚ`. Class number `1` is the pin's
`IsCyclotomicExtension.Rat.five_pid` (consume); the statements below are the LMFDB-page
forms. -/

example : NumberField.discr (CyclotomicField 5 ℚ) = 125 := sorry

example : NumberField.classNumber (CyclotomicField 5 ℚ) = 1 := sorry

example : NumberField.Units.torsionOrder (CyclotomicField 5 ℚ) = 10 := sorry

/-- The subfield lattice of `ℚ(ζ₅)` is `{ℚ, ℚ(√5), ℚ(ζ₅)}` — the subgroup lattice of `C₄`. -/
example : Nat.card (IntermediateField ℚ (CyclotomicField 5 ℚ)) = 3 := sorry

/-- `11 ≡ 1 mod 5` splits completely in `ℚ(ζ₅)`. -/
example : (Ideal.primesOver (Ideal.span {(11 : ℤ)}) (𝓞 (CyclotomicField 5 ℚ))).ncard = 4 :=
  sorry

/-- `2` has order `4` in `(ℤ/5)ˣ`, so `f(2) = 4`: `2` is inert in `ℚ(ζ₅)`. -/
example : (Ideal.span {(2 : ℤ)}).inertiaDegIn (𝓞 (CyclotomicField 5 ℚ)) = 4 := sorry

end Flagship_4_0_125_1

section Flagship_3_1_23_1
/-! **LMFDB `3.1.23.1`**: the non-Galois cubic `X³ − X² + 1`, `disc = −23`, `S₃` closure.
The splitting data below are Dedekind's-theorem instances (cycle types `(3)`, `(1,1,1)`,
and the ramified `(1²·1)` at `23`). -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 3 - X ^ 2 + 1)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = -23 := sorry

example : ¬ IsGalois ℚ K := sorry

example : NumberField.classNumber K = 1 := sorry

example : NumberField.Units.rank K = 1 := sorry

/-- `2` is inert: cycle type `(3)` — `X³ + X² + 1` is irreducible over `𝔽₂`. -/
example : (RingOfIntegers.monicFactorsMod θ 2).val.map Polynomial.natDegree = {3} := sorry

example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 1 := sorry

/-- `59` is the least totally split prime of `3.1.23.1`: Frobenius class `1`. -/
example : (Ideal.primesOver (Ideal.span {(59 : ℤ)}) (𝓞 K)).ncard = 3 := sorry

/-- `23` is ramified with splitting type `(1²·1)`: two primes above it. -/
example : (Ideal.primesOver (Ideal.span {(23 : ℤ)}) (𝓞 K)).ncard = 2 := sorry

/-- `3.1.23.1` has no proper subfield (no subgroup strictly between `C₂` and `S₃`). -/
example : Nat.card (IntermediateField ℚ K) = 2 := sorry

end Flagship_3_1_23_1

section Flagship_3_1_503_1
/-! **LMFDB `3.1.503.1` = Dedekind's field** `ℚ[x]/(x³ − x² − 2x − 8)`: `disc(f) = −4·503`,
`disc K = −503`, index `2`. The prime `2` splits completely although no cubic over `𝔽₂` has
three distinct linear factors — `2` is a common index divisor and `𝓞 K` is not monogenic
(Neukirch III §2 Ex. 1). -/

variable {θ : 𝓞 K} (hmin : minpoly ℤ θ = X ^ 3 - X ^ 2 - 2 * X - 8)
  (hgen : Algebra.adjoin ℚ {(θ : K)} = ⊤)

include hmin hgen

example : NumberField.discr K = -503 := sorry

/-- The index-divisor caveat as a worked theorem: `2` splits completely even though
`f mod 2 = x²(x+1)` — the polynomial factorization does *not* compute the splitting here. -/
example : (Ideal.primesOver (Ideal.span {(2 : ℤ)}) (𝓞 K)).ncard = 3 := sorry

/-- `2` is a common index divisor: every integral generator has even exponent. -/
example : ∀ θ' : 𝓞 K, Algebra.adjoin ℚ {(θ' : K)} = ⊤ →
    2 ∣ RingOfIntegers.exponent θ' := sorry

/-- Hence `𝓞 K` is not monogenic. -/
example : ¬ ∃ θ' : 𝓞 K, Algebra.adjoin ℤ {θ'} = ⊤ := sorry

end Flagship_3_1_503_1

end TauCetiRoadmap.NumberFieldArithmetic
