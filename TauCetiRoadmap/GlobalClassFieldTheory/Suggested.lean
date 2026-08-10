import Mathlib
import TauCetiRoadmap.LocalFields.Suggested
import TauCetiRoadmap.NumberFieldArithmetic.Suggested

/-!
# Global class field theory: target signatures

**This file is not the roadmap and it is not exhaustive.** The definitive document is
`README.md`. The statements here give Lean forms for particular milestones, so that
contributors and reviewers agree on names and signatures. Discharging all of them finishes
neither a layer nor the roadmap. Each declaration is labelled with the milestone number it
belongs to.

Three kinds of item appear below.

* **Interfaces and data prototypes** are real definitions. The shape of the data is a decision
  that the roadmap makes, and a contributor should not have to reinvent it.
* **Structure prototypes** carry the exact carrier and leave the routine closure proofs as
  `sorry`. The carrier is the design decision. Nothing here is an existential subgroup whose
  carrier cannot be read from its type.
* **Milestone statements** are `example`s that end in `sorry`. Each says what its docstring
  claims. Where a docstring speaks of a kernel, an exactness, a carrier or a uniqueness, the
  statement carries it.

Milestones whose statements need vocabulary that the pin does not have are in `README.md` only.
Layer 2B needs the base-change algebra structure on adele rings, which is milestone 2B.1, and
Layers 5, 6, 7 and 11 need the objects that Layer 2B builds. Add each milestone here as soon as
its types are expressible.

Local class field theory, and the generic finite-group Tate and class-formation machinery, are the
Local Fields roadmap's. This file imports `TauCetiRoadmap.LocalFields.Suggested` and applies those
declarations by name; it restates none of them, and it carries no compatibility structure standing
in for them. `README.md` has the exact declaration contract.

The finite ideal-theoretic Artin map is imported from Number Field Arithmetic. This file supplies
only the abelian-hypothesis adapter — `algEquiv_commute_of_isAbelianGalois`, and the reducible
`abelianArtinHomAway` built from it — and uses the imported map in global reciprocity. It defines
no ideal group of its own, no second unramifiedness predicate, and no second Artin map; the
contract checks below are closed applications of the supplier's declarations, so a change to its
carrier or signature breaks this build.
-/

namespace TauCetiRoadmap.GlobalClassFieldTheory

open NumberField IsDedekindDomain

open scoped nonZeroDivisors ValuativeRel TensorProduct

universe u

/-! ## Layer D: the local dictionary and the ideal-theoretic Artin map

Global class field theory needs local class field theory, and this roadmap does not build it. The
Local Fields roadmap owns it, together with the generic finite-group Tate and class-formation
machinery, and `README.md` carries the exact declaration contract. What is here is the dictionary
onto that theory at a finite place of a number field, the ideal-theoretic Artin map, and the
milestones that read the consumed theory one prime at a time.

D.4 is in `README.md` only. Its exponent `a(χ)` is the supplier's `characterConductorExp`, so
nothing is defined here for it, and its own content, the sum `v_F(𝔡_{E/F}) = ∑_χ a(χ ∘ θ_{E/F})`,
needs the different of a local extension, which in turn needs the `Algebra 𝒪[F] 𝒪[E]` instance
that is a Layer 0 milestone of the supplier and does not exist at the pin.

Every name below in the namespace `TauCetiRoadmap.LocalFields` is the supplier's, imported and
applied. None of them is restated here. -/

/-- **D.1, the completion dictionary at a finite place.** The completion of a number field at a
finite place is a nonarchimedean local field, which is what makes every declaration of the Local
Fields roadmap applicable to it. The `ValuativeRel` and `IsValuativeTopology` instances are
hypotheses, because producing them from the pin's `Valued` instance on `adicCompletion`, without
stating anything new against `Valued`, is part of the milestone. -/
example {K : Type} [Field K] [NumberField K] (v : HeightOneSpectrum (𝓞 K))
    [ValuativeRel (v.adicCompletion K)] [IsValuativeTopology (v.adicCompletion K)] :
    IsNonarchimedeanLocalField (v.adicCompletion K) :=
  sorry

/-- **D.1, the residue cardinality.** The residue field of the completion at `v` has
`Ideal.absNorm v.asIdeal` elements, so the `q_v` of the conventions table and the `q` of the
consumed absolute value `‖x‖_K = q^{−v_K(x)}` are the same number. -/
example {K : Type} [Field K] [NumberField K] (v : HeightOneSpectrum (𝓞 K))
    [ValuativeRel (v.adicCompletion K)] [IsNonarchimedeanLocalField (v.adicCompletion K)] :
    Nat.card (IsLocalRing.ResidueField 𝒪[v.adicCompletion K]) = Ideal.absNorm v.asIdeal :=
  sorry

/-- **6.1 item 3, the local factor of the global Artin map at a finite place.** This is the point
where the global compilation meets the consumed local theory: the local component is the Local
Fields roadmap's `artinMap`, at the completion that D.1 identifies as a nonarchimedean local
field. Nothing is defined here beyond that application, and in particular this roadmap has no
local Artin map of its own. Composing with the restriction to a finite abelian `L/K` is 6.1
items 1 and 2, which need the decomposition-group identification of 2B.6. -/
noncomputable def localArtinAt {K : Type} [Field K] [NumberField K]
    (v : HeightOneSpectrum (𝓞 K)) [ValuativeRel (v.adicCompletion K)]
    [IsNonarchimedeanLocalField (v.adicCompletion K)] :
    (v.adicCompletion K)ˣ →* Field.absoluteGaloisGroupAbelianization (v.adicCompletion K) :=
  LocalFields.artinMap (v.adicCompletion K)

/-- **6.1 item 4, the arithmetic normalization of that local factor.** The unramified coordinate
of the local component is the normalized valuation, which is the consumed
`unramifiedCoordinate_artinMap` and nothing further. This is the equation behind "a uniformizer
goes to the arithmetic Frobenius" of the conventions table, and it is what makes almost every
factor of `∏_v Art_{K_v}(x_v)` trivial. -/
theorem unramifiedCoordinate_localArtinAt {K : Type} [Field K] [NumberField K]
    (v : HeightOneSpectrum (𝓞 K)) [ValuativeRel (v.adicCompletion K)]
    [IsNonarchimedeanLocalField (v.adicCompletion K)] (x : (v.adicCompletion K)ˣ) :
    LocalFields.unramifiedCoordinate (v.adicCompletion K) (localArtinAt v x)
      = ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (Multiplicative ℤ))
          (LocalFields.normalizedValuation (v.adicCompletion K) x) :=
  LocalFields.unramifiedCoordinate_artinMap (v.adicCompletion K) x

/-- **D.3 clause 1, the cyclotomic orientation at a `p`-power level.** Stage 1 of 6.3 evaluates
`χ_cyc(Art_{ℚ_p}(u)) = u⁻¹` at level `p ^ k`, with `χ_cyc` Mathlib's `modularCyclotomicCharacter`
and the right-hand side the reduction of `u` along `PadicInt.toZModPow`. It is the consumed
`cyclotomicCharacter_artinMap_padic`, which states the same equation in `ℤ_pˣ`, read modulo
`p ^ k`. The direction is the whole content: with the geometric convention the right-hand side is
`u`, every degree count is unchanged, and the error first shows up in global reciprocity.

⚠ This is a `p`-power-level statement. At a level `m` prime to `p` there is no homomorphism
`ℤ_pˣ → (ZMod m)ˣ`, so the same equation is ill-typed there; the clause that holds away from `p`
is the unramified one, `unramifiedCoordinate_localArtinAt` above. -/
example (p : ℕ) [Fact p.Prime] [IsNonarchimedeanLocalField ℚ_[p]] (k : ℕ)
    (hk : Fintype.card {x // x ∈ rootsOfUnity (p ^ k) (AlgebraicClosure ℚ_[p])} = p ^ k)
    (u : ℤ_[p]ˣ) (σ : Field.absoluteGaloisGroup ℚ_[p])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[p])
      = LocalFields.artinMap ℚ_[p] (Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom u)) :
    modularCyclotomicCharacter (AlgebraicClosure ℚ_[p]) hk σ.toRingEquiv
      = (Units.map (PadicInt.toZModPow k : ℤ_[p] →+* ZMod (p ^ k)).toMonoidHom u)⁻¹ :=
  sorry

/-! ### D.2: the consumed ideal-theoretic Artin map

The carrier `J^S`, the map, and its four characteristic properties are Number Field Arithmetic's.
This roadmap builds none of them. What it owns is one adapter: that roadmap states the abelian
hypothesis as `[IsGalois K L]` together with an explicit `hab : ∀ σ τ, Commute σ τ`, and this one
carries `[IsAbelianGalois K L]`. Translating between the two is the whole of D.2.
-/

/-- **D.2.1, the abelian-hypothesis translation.** The only new ingredient of D.2. `IsAbelianGalois`
is a Galois extension whose group is commutative, and the supplied Artin map takes that
commutativity as an explicit argument, so this is the one lemma that lets every use below be a
call to the supplier. -/
theorem algEquiv_commute_of_isAbelianGalois {K L : Type*} [Field K] [NumberField K] [Field L]
    [NumberField L] [Algebra K L] [IsAbelianGalois K L] :
    ∀ σ τ : L ≃ₐ[K] L, Commute σ τ :=
  fun σ τ => IsMulCommutative.is_comm.comm σ τ

/-- **D.2.2, the Artin map at the abelian hypothesis.** A reducible abbreviation of the supplied
map, and nothing else: it carries no universal property and no construction of its own. Every
statement of Layers 6 to 8 about it is a statement about
`NumberFieldArithmetic.artinHomAway`. -/
noncomputable abbrev abelianArtinHomAway {K L : Type u} [Field K] [NumberField K] [Field L]
    [NumberField L] [Algebra K L] [IsAbelianGalois K L]
    (S : Finset (HeightOneSpectrum (𝓞 K)))
    (hur : ∀ v : HeightOneSpectrum (𝓞 K), v ∉ S →
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal], Algebra.IsUnramifiedAt (𝓞 K) Q) :
    NumberFieldArithmetic.idealsAway (K := K) S →* (L ≃ₐ[K] L) :=
  NumberFieldArithmetic.artinHomAway (L := L) algEquiv_commute_of_isAbelianGalois S hur

section ArtinContract

variable {K L : Type u} [Field K] [NumberField K] [Field L] [NumberField L] [Algebra K L]
  [IsAbelianGalois K L] (S : Finset (HeightOneSpectrum (𝓞 K)))
  (hur : ∀ v : HeightOneSpectrum (𝓞 K), v ∉ S →
    ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal], Algebra.IsUnramifiedAt (𝓞 K) Q)

/-! #### D.2.3, the contract checks

Closed applications of the supplied declarations, with no `sorry`. Nothing below is a milestone:
each says that this roadmap reads the supplier's property rather than restating it, and each stops
elaborating if the supplier's carrier or signature moves. -/

/-- The adapter reduces to the supplied map. -/
example : abelianArtinHomAway S hur =
    NumberFieldArithmetic.artinHomAway (L := L) algEquiv_commute_of_isAbelianGalois S hur :=
  rfl

/-- **The value at a prime**, consumed. -/
example (I : NumberFieldArithmetic.idealsAway (K := K) S) (v : HeightOneSpectrum (𝓞 K))
    (hv : v ∉ S)
    (hI : ((I : (FractionalIdeal (𝓞 K)⁰ K)ˣ) : FractionalIdeal (𝓞 K)⁰ K) =
      (v.asIdeal : FractionalIdeal (𝓞 K)⁰ K))
    (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal] (σ : L ≃ₐ[K] L)
    (hσ : IsArithFrobAt (𝓞 K) σ Q) :
    abelianArtinHomAway S hur I = σ :=
  NumberFieldArithmetic.artinHomAway_apply_prime algEquiv_commute_of_isAbelianGalois S hur
    I v hv hI Q σ hσ

/-- **Uniqueness from the prime values**, consumed. This is what lets Layer 6 recognize its own
global construction as the supplied map. -/
example (φ : NumberFieldArithmetic.idealsAway (K := K) S →* (L ≃ₐ[K] L))
    (hφ : ∀ (I : NumberFieldArithmetic.idealsAway (K := K) S) (v : HeightOneSpectrum (𝓞 K)),
      v ∉ S →
      ((I : (FractionalIdeal (𝓞 K)⁰ K)ˣ) : FractionalIdeal (𝓞 K)⁰ K) =
        (v.asIdeal : FractionalIdeal (𝓞 K)⁰ K) →
      ∀ (Q : Ideal (𝓞 L)) (_ : Q.IsPrime) (_ : Q.LiesOver v.asIdeal) (σ : L ≃ₐ[K] L),
        IsArithFrobAt (𝓞 K) σ Q → φ I = σ) :
    φ = abelianArtinHomAway S hur :=
  NumberFieldArithmetic.artinHomAway_eq_of_apply_prime algEquiv_commute_of_isAbelianGalois S hur
    φ hφ

/-- **Enlargement of the excluded set**, consumed. Layers 6 to 8 take `S = support 𝔪₀`, which is
generally larger than the ramified set, and this is the equation that licenses the enlargement.
⚠ The inequality of carriers is not a substitute: it says nothing about the two maps. -/
example (S' : Finset (HeightOneSpectrum (𝓞 K))) (h : S ⊆ S')
    (hur' : ∀ v : HeightOneSpectrum (𝓞 K), v ∉ S' →
      ∀ (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal], Algebra.IsUnramifiedAt (𝓞 K) Q) :
    abelianArtinHomAway S' hur' =
      (abelianArtinHomAway S hur).comp (NumberFieldArithmetic.idealsAwayInclusion h) :=
  NumberFieldArithmetic.artinHomAway_mono algEquiv_commute_of_isAbelianGalois S hur S' h hur'

/-- **Restriction to a subextension**, consumed. Layer 6's functoriality and Layer 7's tower
statements run along this square. ⚠ The unramified hypothesis for `M/K` is *derived* from the one
for `L/K`, by the supplier's `isUnramifiedAway_of_intermediateField`; a second assumption would
state something weaker. -/
example (M : IntermediateField K L) [NumberField M] [Normal K M] [IsGalois K M]
    (habM : ∀ σ τ : M ≃ₐ[K] M, Commute σ τ) :
    (AlgEquiv.restrictNormalHom (F := K) M).comp (abelianArtinHomAway S hur) =
      NumberFieldArithmetic.artinHomAway (L := M) habM S
        (NumberFieldArithmetic.isUnramifiedAway_of_intermediateField M S hur) :=
  NumberFieldArithmetic.artinHomAway_restrict algEquiv_commute_of_isAbelianGalois S hur M habM

/-- **The integral-ideal form**, consumed. This is the shape the classical statements of Layers 6
and 7 are in, and it is the supplier's composite rather than a second construction here. -/
example (v : HeightOneSpectrum (𝓞 K)) (hv : v ∉ S)
    (hmem : v.asIdeal ∈ NumberFieldArithmetic.integralIdealsAway (K := K) S)
    (Q : Ideal (𝓞 L)) [Q.IsPrime] [Q.LiesOver v.asIdeal] (σ : L ≃ₐ[K] L)
    (hσ : IsArithFrobAt (𝓞 K) σ Q) :
    NumberFieldArithmetic.artinHomAwayIntegral (L := L) algEquiv_commute_of_isAbelianGalois S hur
        ⟨v.asIdeal, hmem⟩ = σ :=
  NumberFieldArithmetic.artinHomAwayIntegral_apply_prime algEquiv_commute_of_isAbelianGalois S hur
    v hv hmem Q σ hσ

end ArtinContract


/-! ## Layer 0: moduli, approximation, and multiplicative congruences -/

/-- **0.1, the modulus.** A modulus of a number field is a nonzero integral ideal together with
a finite set of real places. The infinite part is typed by real places, and not by all infinite
places with a side condition. A complex place never divides a modulus, and a design in which
the infinite part is easy to forget produces the wide class group everywhere. The finite part
has a second description as an exponent function of finite support on
`HeightOneSpectrum (𝓞 K)`; the translation lemmas are part of 0.1. -/
structure Modulus (K : Type u) [Field K] [NumberField K] where
  /-- The finite part, a nonzero ideal of the ring of integers. -/
  finitePart : Ideal (𝓞 K)
  /-- Moduli have nonzero finite part. The unit ideal is `⊤`, and it is allowed. -/
  finitePart_ne_bot : finitePart ≠ ⊥
  /-- The infinite part: a finite set of real places. -/
  infinitePart : Finset {w : InfinitePlace K // w.IsReal}

variable {K : Type u} [Field K] [NumberField K]

/-- **0.1, divisibility of moduli, in the pinned orientation.** `𝔪 ∣ 𝔫` means that the exponent
at every finite place is weakly larger for `𝔫`, and that the infinite part grows. The induced
map on ray class groups then runs `Cl_𝔫 ↠ Cl_𝔪`. -/
instance : Dvd (Modulus K) :=
  ⟨fun 𝔪 𝔫 => 𝔪.finitePart ∣ 𝔫.finitePart ∧ 𝔪.infinitePart ⊆ 𝔫.infinitePart⟩

/-- **0.1, the exponent of a finite place in the finite part of a modulus.** -/
noncomputable def Modulus.exponent (𝔪 : Modulus K) (v : HeightOneSpectrum (𝓞 K)) : ℕ :=
  (Associates.mk v.asIdeal).count (Associates.mk 𝔪.finitePart).factors

/-- **0.4, multiplicative congruence.** `x ≡ 1 mod* 𝔪` for `x ∈ Kˣ`: the order of vanishing of
`x - 1` at each finite place dividing `𝔪₀` is at least the exponent there, and `x` is positive
at each real place of `𝔪∞`. Mathlib's valuation is multiplicative with values in `ℤᵐ⁰`, so a
higher order of vanishing is a smaller value; that is why the inequality points as it does.

**Common error.** This is a condition on `Kˣ`. It is not membership in `1 + 𝔪₀` inside `𝓞 K`.
The two agree only for integral `x` prime to `𝔪₀`. -/
def IsCongrOne (𝔪 : Modulus K) (x : Kˣ) : Prop :=
  (∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
      v.valuation K ((x : K) - 1) ≤
        ((Multiplicative.ofAdd (-(𝔪.exponent v : ℤ)) : Multiplicative ℤ) :
          WithZero (Multiplicative ℤ))) ∧
    ∀ w ∈ 𝔪.infinitePart, 0 < InfinitePlace.embedding_of_isReal w.2 (x : K)

/-- **0.5, the elements prime to the finite part.** "Prime to `𝔪₀`" is not a Lean type, so it is
this named subgroup of `Kˣ`. It is the unit group of the localization of `𝓞 K` away from `𝔪₀`,
and it is the exact domain of the reduction map 0.6. It has to be a subgroup and not a
predicate, because 1.5 quotients by it. -/
def primeToSubgroup (𝔪 : Modulus K) : Subgroup Kˣ where
  carrier := {x | ∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
    v.valuation K (x : K) = 1}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **0.4, the congruence subgroup of `Kˣ`.** The carrier is pinned. That it is a subgroup is
the milestone, and the proof uses the ultrametric inequality at the finite places and the sign
rules at the real ones. Do not use ring arithmetic in a quotient. -/
def congruenceSubgroup (𝔪 : Modulus K) : Subgroup Kˣ where
  carrier := {x | IsCongrOne 𝔪 x}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **0.4, congruence implies prime to the modulus.** If `ord_v(x − 1) ≥ 1` then `ord_v(x) = 0`,
so this containment is free. It is stated because the reduction map 0.6 is defined on
`primeToSubgroup 𝔪` and has kernel `congruenceSubgroup 𝔪`. -/
example (𝔪 : Modulus K) : congruenceSubgroup 𝔪 ≤ primeToSubgroup 𝔪 :=
  sorry

/-- **0.2, simultaneous approximation.** Independent targets and independent depths at finitely
many finite places, and independent signs at finitely many real places, are met by one global
element. This does not follow from the chinese remainder theorem and sign surjectivity
separately, and Mathlib has no weak approximation theorem for inequivalent absolute values at
the pin. Prove Artin–Whaples weak approximation for a finite set of places and read this off.

The conclusion gives a unit of `K`, and not an element of `K`. With `x : K` the sign condition
would only say `¬ (0 < embedding w x)` when `ε w = -1`, and `x = 0` would then satisfy every
negative request. -/
example (S : Finset (HeightOneSpectrum (𝓞 K))) (a : HeightOneSpectrum (𝓞 K) → K)
    (n : HeightOneSpectrum (𝓞 K) → ℕ) (T : Finset {w : InfinitePlace K // w.IsReal})
    (ε : {w : InfinitePlace K // w.IsReal} → ℤˣ) :
    ∃ x : Kˣ,
      (∀ v ∈ S, v.valuation K ((x : K) - a v) ≤
        ((Multiplicative.ofAdd (-(n v : ℤ)) : Multiplicative ℤ) :
          WithZero (Multiplicative ℤ))) ∧
        ∀ w ∈ T, (0 < InfinitePlace.embedding_of_isReal w.2 (x : K) ↔ ε w = 1) :=
  sorry

/-- **0.2, the ray class corollary of approximation.** The case that Layers 0 and 1 use: one
element congruent to a prescribed `a` modulo the modulus, with prescribed signs at every real
place. -/
example (𝔪 : Modulus K) (a : Kˣ) (ε : {w : InfinitePlace K // w.IsReal} → ℤˣ) :
    ∃ x : Kˣ, IsCongrOne 𝔪 (x * a⁻¹) ∧
      ∀ w : {w : InfinitePlace K // w.IsReal},
        (0 < InfinitePlace.embedding_of_isReal w.2 (x : K) ↔ ε w = 1) :=
  sorry

/-- **0.3, the sign map.** The total sign homomorphism `Kˣ →* Π_{w real} {±1}`, valued in `ℤˣ`
and not in `Bool`, because 1.5, 3.4 and 2C.3 all land in the same group. Its surjectivity is the
archimedean case of 0.2.

**Common error.** The map on units `(𝓞 K)ˣ` is not surjective in general, as `ℚ(√3)` shows.
That failure is what `Cl⁺ ≠ Cl` measures in 1.8. -/
example :
    ∃ σ : Kˣ →* ({w : InfinitePlace K // w.IsReal} → ℤˣ),
      (∀ (x : Kˣ) (w : {w : InfinitePlace K // w.IsReal}),
          σ x w = 1 ↔ 0 < InfinitePlace.embedding_of_isReal w.2 (x : K)) ∧
        Function.Surjective σ :=
  sorry

/-- **0.6, the reduction map, with its domain and its kernel.** It is defined on the prime-to
subgroup, it is surjective by 0.2, and its kernel is the congruence subgroup. The kernel
identity is the computational form of 1.5, so it is proved here. The sign components are indexed
by `𝔪∞` alone: a map to the signs at all real places would not have this kernel. -/
example (𝔪 : Modulus K) :
    ∃ f : primeToSubgroup 𝔪 →* (𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ),
      Function.Surjective f ∧
        ∀ x : primeToSubgroup 𝔪, f x = 1 ↔ (x : Kˣ) ∈ congruenceSubgroup 𝔪 :=
  sorry

/-! ## Layer 1: ray class groups and the narrow class group -/

/-- **1.1, the ideals prime to the modulus.** Support disjointness is spelled through the
`v`-adic count of the factorization of a fractional ideal. -/
def idealsPrimeTo (𝔪 : Modulus K) : Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ where
  carrier := {I | ∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
    FractionalIdeal.count K v (I : FractionalIdeal (𝓞 K)⁰ K) = 0}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **1.1, the ray.** The principal ideals generated by elements congruent to `1` modulo the
modulus, as a subgroup of the ideals prime to it. Mathlib's `toPrincipalIdeal` is the map that
`ClassGroup` is built from, so the ray class group and the class group are quotients of the same
objects, and the comparison map of 1.2 is available. -/
def ray (𝔪 : Modulus K) : Subgroup (idealsPrimeTo 𝔪) :=
  (((congruenceSubgroup 𝔪).map (toPrincipalIdeal (𝓞 K) K)).subgroupOf (idealsPrimeTo 𝔪))

/-- **1.2, the ray class group.** `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`. For the trivial modulus this is
`ClassGroup (𝓞 K)` by a named isomorphism, and never by a definitional coincidence. -/
def RayClassGroup (𝔪 : Modulus K) : Type u :=
  idealsPrimeTo 𝔪 ⧸ ray 𝔪

noncomputable instance (𝔪 : Modulus K) : CommGroup (RayClassGroup 𝔪) :=
  inferInstanceAs (CommGroup (idealsPrimeTo 𝔪 ⧸ ray 𝔪))

/-- **1.5, the units congruent to `1` modulo the modulus**, `𝓞_{K,𝔪}ˣ`. Its index in `𝓞_Kˣ` is
the unit obstruction, it is the left-hand term of the exact sequence, and for the narrow modulus
it is the group of totally positive units. -/
def unitsCongruenceSubgroup (𝔪 : Modulus K) : Subgroup (𝓞 K)ˣ :=
  (congruenceSubgroup 𝔪).comap (Units.map (algebraMap (𝓞 K) K).toMonoidHom)

/-- **1.3, the moving lemma.** Every ideal class of a Dedekind domain contains an integral ideal
prime to a fixed nonzero ideal. Mathlib has only `ClassGroup.mk0_surjective`. Route: the chinese
remainder theorem and approximation in the Dedekind domain, and not geometry of numbers. Prove
it at this generality, because the ray class versions specialize. -/
example (R : Type u) [CommRing R] [IsDedekindDomain R] (𝔪 : Ideal R) (h𝔪 : 𝔪 ≠ ⊥)
    (C : ClassGroup R) :
    ∃ I : (Ideal R)⁰, ClassGroup.mk0 I = C ∧ IsCoprime (I : Ideal R) 𝔪 :=
  sorry

/-- **1.6, finiteness and the class number formula.** The sharp form is
`#Cl_𝔪 = h_K · #(𝓞 K ⧸ 𝔪₀)ˣ · 2^{#𝔪∞} / [𝓞_Kˣ : 𝓞_{K,𝔪}ˣ]`, written below without division.
It is false at unrestricted Dedekind generality, so it is stated for number fields. -/
example (𝔪 : Modulus K) :
    Finite (RayClassGroup 𝔪) ∧
      Nat.card (RayClassGroup 𝔪) * (unitsCongruenceSubgroup 𝔪).index =
        NumberField.classNumber K * Nat.card (𝓞 K ⧸ 𝔪.finitePart)ˣ * 2 ^ 𝔪.infinitePart.card :=
  sorry

/-- **1.4, the transition map.** In the pinned orientation the larger modulus maps onto the
smaller, and surjectivity is the moving lemma. That the maps compose in a tower is part of 1.4;
stating it needs the map named rather than existentially quantified, so it stays in `README.md`
until the implementation names it. -/
example (𝔪 𝔫 : Modulus K) (h : 𝔪 ∣ 𝔫) :
    ∃ f : RayClassGroup 𝔫 →* RayClassGroup 𝔪, Function.Surjective f :=
  sorry

/-- **1.5, the ray class exact sequence.**
`1 → 𝓞_{K,𝔪}ˣ → 𝓞_Kˣ → (𝓞 K ⧸ 𝔪₀)ˣ × signs → Cl_𝔪 K → Cl K → 1`, given as the three maps
together with exactness at each interior place. The image form and the cardinality formula
follow from this, and not the reverse.

**Common error.** The sequence is the reason `Cl_𝔪` is not `(𝓞/𝔪₀)ˣ × signs × Cl`. Global units
glue the factors, and the size of the unit image is a global quantity. -/
example (𝔪 : Modulus K) :
    ∃ (g : (𝓞 K)ˣ →* (𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ))
      (h : ((𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ)) →* RayClassGroup 𝔪)
      (f : RayClassGroup 𝔪 →* ClassGroup (𝓞 K)),
      g.ker = unitsCongruenceSubgroup 𝔪 ∧ g.range = h.ker ∧ h.range = f.ker ∧
        Function.Surjective f :=
  sorry

/-! ### The named ray-class API that the L-functions roadmap consumes

Layers 0 to 3 own the modulus, the ray class group, and the characters of both. The L-functions
roadmap imports them rather than rebuilding them, so the operations it uses carry Lean names
here and not only milestone numbers. `README.md`'s contract section with that roadmap is the
list; every name below appears in a row of it. -/

/-- **0.1, the trivial modulus** `((1), ∅)`, the second of the two named instances 0.1 asks for.
It divides every modulus, its ray class group is the class group, and it is the conductor of
every unramified character. -/
def Modulus.one (K : Type u) [Field K] [NumberField K] : Modulus K where
  finitePart := ⊤
  finitePart_ne_bot := top_ne_bot
  infinitePart := ∅

theorem Modulus.one_dvd (𝔪 : Modulus K) : Modulus.one K ∣ 𝔪 := sorry

/-- **1.1, coprimality of an integral ideal to a modulus.** `idealsPrimeTo` is a subgroup of the
*fractional* ideal group; this is the predicate on integral ideals that indexes the coefficients
of an L-series and the fibres of a partial zeta function. ⚠ It excludes `⊥`. A law guarded by
this predicate says nothing at the zero ideal, so a value there is unconstrained junk. -/
def Modulus.IsCoprimeTo (𝔪 : Modulus K) (I : Ideal (𝓞 K)) : Prop :=
  I ≠ ⊥ ∧ ∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart → ¬ v.asIdeal ∣ I

/-- **1.2, the ray class of an integral ideal prime to `𝔪₀`**, the constructor of 1.2's basic
API. The value at an ideal that is not prime to `𝔪₀` is not used, and the three theorems below
are the whole interface. -/
noncomputable def idealClass (𝔪 : Modulus K) (I : Ideal (𝓞 K)) : RayClassGroup 𝔪 := sorry

theorem idealClass_mul (𝔪 : Modulus K) {I J : Ideal (𝓞 K)}
    (hI : 𝔪.IsCoprimeTo I) (hJ : 𝔪.IsCoprimeTo J) :
    idealClass 𝔪 (I * J) = idealClass 𝔪 I * idealClass 𝔪 J := sorry

/-- **1.2**: the class map kills exactly the ray-principal ideals. This is what "a weight factors
through the ray class group" means, and it is a theorem about a canonical map rather than a field
on an arbitrary function. -/
theorem idealClass_eq_one_iff (𝔪 : Modulus K) {I : Ideal (𝓞 K)} (hI : 𝔪.IsCoprimeTo I) :
    idealClass 𝔪 I = 1 ↔
      ∃ α β : 𝓞 K, α ≠ 0 ∧ β ≠ 0 ∧ α - 1 ∈ 𝔪.finitePart ∧ β - 1 ∈ 𝔪.finitePart ∧
        (∀ w ∈ 𝔪.infinitePart,
          0 < InfinitePlace.embedding_of_isReal w.2 (algebraMap (𝓞 K) K α)) ∧
        (∀ w ∈ 𝔪.infinitePart,
          0 < InfinitePlace.embedding_of_isReal w.2 (algebraMap (𝓞 K) K β)) ∧
        I * Ideal.span {β} = Ideal.span {α} := sorry

/-- **1.3, the ray class form of the moving lemma.** Every class contains an integral ideal prime
to `𝔪₀`, so the fibres of `idealClass` partition those ideals. A choice of representatives rests
on this, and so does every partial-zeta decomposition downstream. -/
theorem idealClass_surjective (𝔪 : Modulus K) (c : RayClassGroup 𝔪) :
    ∃ I : Ideal (𝓞 K), 𝔪.IsCoprimeTo I ∧ idealClass 𝔪 I = c := sorry

/-- **1.6, finiteness of the ray class group**, as a named theorem. It is what makes every
character of `RayClassGroup 𝔪` of finite order, and what makes a sum over classes a finite sum.
The sharp cardinality formula is the milestone below. -/
theorem finite_rayClassGroup (𝔪 : Modulus K) : Finite (RayClassGroup 𝔪) := sorry

/-- **1.4, the transition map**, named. In the pinned orientation the larger modulus maps onto
the smaller. Induction of characters is precomposition with this map, and primitivity is stated
against it, so it has to be a declaration and not an existential. -/
noncomputable def classMap {𝔪 𝔫 : Modulus K} (h : 𝔪 ∣ 𝔫) :
    RayClassGroup 𝔫 →* RayClassGroup 𝔪 := sorry

theorem classMap_idealClass {𝔪 𝔫 : Modulus K} (h : 𝔪 ∣ 𝔫) {I : Ideal (𝓞 K)}
    (hI : 𝔫.IsCoprimeTo I) : classMap h (idealClass 𝔫 I) = idealClass 𝔪 I := sorry

theorem classMap_surjective {𝔪 𝔫 : Modulus K} (h : 𝔪 ∣ 𝔫) :
    Function.Surjective (classMap h) := sorry

/-- **0.6 and 1.4, the reduction map on residue units** along a divisibility of moduli. It is
`Ideal.Quotient.factor` restricted to the unit groups, and it is the map that the finite
component of an induced character commutes along.

⚠ It is the units-pullback and never a ring composition: `3 mod 6 ↦ 1 mod 2` is a unit of the
smaller ring whose ring-level lift is not a unit of the larger one. -/
noncomputable def finiteUnitsMap {𝔪 𝔫 : Modulus K} (h : 𝔪 ∣ 𝔫) :
    ((𝓞 K) ⧸ 𝔫.finitePart)ˣ →* ((𝓞 K) ⧸ 𝔪.finitePart)ˣ :=
  Units.map (Ideal.Quotient.factor (Ideal.le_of_dvd h.1)).toMonoidHom

open scoped Classical in
/-- **1.8, the narrow modulus.** Trivial finite part, and every real place. "Narrow" never means
that totally positive units exist. A field with no real place has `Cl⁺ = Cl`; that is an
instance, and not a second definition. -/
noncomputable def narrowModulus (K : Type u) [Field K] [NumberField K] : Modulus K where
  finitePart := ⊤
  finitePart_ne_bot := top_ne_bot
  infinitePart := Finset.univ

/-- **1.8, the narrow class group surjects onto the class group.** The kernel is an elementary
abelian 2-group of order `2^{r₁}/[𝓞_Kˣ : 𝓞_Kˣ⁺]`, and both halves of that description are in
the statement: the kernel has exponent two, and its order times the index of the totally
positive units is `2^{r₁}`. The totally positive units are `unitsCongruenceSubgroup` of the
narrow modulus. The merged Multiquadratic roadmap names this API as a prerequisite. -/
example : ∃ f : RayClassGroup (narrowModulus K) →* ClassGroup (𝓞 K),
    Function.Surjective f ∧ (∀ x ∈ f.ker, x ^ 2 = 1) ∧
      Nat.card f.ker * (unitsCongruenceSubgroup (narrowModulus K)).index =
        2 ^ NumberField.InfinitePlace.nrRealPlaces K :=
  sorry

/-- **3.4 over `ℚ`, the character that does not exist.** The ray class group of `ℚ` for the
modulus consisting of the infinite place alone is trivial, because every fractional ideal of `ℤ`
has a unique positive generator. So `ℚ` has no nontrivial Hecke character of ray conductor `∞`,
and "the sign character of `ℚ`" is not an example of anything. -/
example : Subsingleton (RayClassGroup (narrowModulus ℚ)) :=
  sorry

/-! ## Layer 2A: the idele class group -/

/-- **2A.1, the idele class group.** The quotient below is what the statements here mean by
`C_K`. It is reducible, so that every `Units` and `QuotientGroup` lemma applies without glue. -/
abbrev IdeleClassGroup (K : Type u) [Field K] [NumberField K] :=
  (AdeleRing (𝓞 K) K)ˣ ⧸ (Units.map (algebraMap K (AdeleRing (𝓞 K) K)).toMonoidHom).range

/-- **2A.3, `K` is discrete in its adeles.** One half of the additive local-global finiteness
package that 2A.5 uses. -/
example : DiscreteTopology (AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **2A.3, cocompactness.** The quotient `𝔸_K/K` is compact. This is the adelic form of
Minkowski finiteness, and the multiplicative sequel is 2A.5. -/
example : CompactSpace (AdeleRing (𝓞 K) K ⧸ AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **2A.3, additive strong approximation**: `K` is dense in its **finite** adeles, that is in
the adeles with the archimedean components omitted. This is the one-omitted-place form of the
classical statement, taken at the archimedean place, and it is the form a consumer uses to
approximate an adelic point by a global one away from a fixed finite set.

⚠ This is a **third** statement about `K` inside its adeles, and it is neither of the other two.
It is not weak approximation, 0.2, which is a statement about finitely many completions and says
nothing about integrality at the remaining places. It is not the discreteness–cocompactness pair
above: `K` is discrete in the full adele ring, so no density statement holds there, and omitting
a place is exactly what makes density possible. A consumer that cites "strong approximation from
Layer 0" is citing 0.2, whose own note says that strong approximation is a different statement;
this is the declaration to cite instead.

The multiplicative `S`-idele form is Layer 5 and is a different theorem again. -/
theorem denseRange_algebraMap_finiteAdeleRing :
    DenseRange (algebraMap K (FiniteAdeleRing (𝓞 K) K)) := sorry

/-- **2A.7, the class group as an idele-class quotient.** The quotient of the finite ideles by
the everywhere-integral units and the principal ideles is the ideal class group. The map is
`x ↦ ∏_v v^{ord_v(x_v)}` and the kernel analysis is the moving lemma. This is the special case
`𝔪 = ((1), ∅)` of the dictionary.

The unit condition is stated through `adicCompletionIntegers`, and not through `Valued.v`. I.3
fixes that rule. -/
example :
    ∃ S : Subgroup (FiniteAdeleRing (𝓞 K) K)ˣ,
      (∀ u : (FiniteAdeleRing (𝓞 K) K)ˣ,
        u ∈ S ↔ ∀ v : HeightOneSpectrum (𝓞 K),
          (u : FiniteAdeleRing (𝓞 K) K) v ∈ v.adicCompletionIntegers K ∧
            ((u⁻¹ : (FiniteAdeleRing (𝓞 K) K)ˣ) : FiniteAdeleRing (𝓞 K) K) v ∈
              v.adicCompletionIntegers K) ∧
      Nonempty
        (((FiniteAdeleRing (𝓞 K) K)ˣ ⧸
            (S ⊔ (FiniteAdeleRing.unitEmbedding (𝓞 K) K).range)) ≃* ClassGroup (𝓞 K)) :=
  sorry

/-- **2A.6, principal units of a given level at a finite place**, that is `x ∈ 1 + 𝔭_v^n`. It is
stated through the maximal ideal of `v.adicCompletionIntegers`, and not through `Valued.v`. -/
def IsPrincipalUnitOfLevel (v : HeightOneSpectrum (𝓞 K)) (n : ℕ) (x : v.adicCompletion K) :
    Prop :=
  ∃ y : v.adicCompletionIntegers K, (y : v.adicCompletion K) = x - 1 ∧
    y ∈ (IsLocalRing.maximalIdeal (v.adicCompletionIntegers K)) ^ n

/-- **2A.6, the congruence subgroup of the ideles, `U_𝔪`.** One subgroup, used everywhere. Its
carrier is written out because the carrier is the design decision: principal units of level
`ord_v 𝔪₀` at the finite places dividing `𝔪₀`; local integral units at the other finite places;
positivity at the real places of `𝔪∞`; and no condition at the remaining infinite places.

**Common error.** Do not append a second group of infinite components. They are already here. -/
def IdeleCongruenceSubgroup (𝔪 : Modulus K) : Subgroup (AdeleRing (𝓞 K) K)ˣ where
  carrier := {u |
    (∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
        IsPrincipalUnitOfLevel v (𝔪.exponent v) ((u : AdeleRing (𝓞 K) K).2 v)) ∧
      (∀ v : HeightOneSpectrum (𝓞 K), ¬ v.asIdeal ∣ 𝔪.finitePart →
        (u : AdeleRing (𝓞 K) K).2 v ∈ v.adicCompletionIntegers K ∧
          ((u⁻¹ : (AdeleRing (𝓞 K) K)ˣ) : AdeleRing (𝓞 K) K).2 v ∈
            v.adicCompletionIntegers K) ∧
      ∀ w : {w : InfinitePlace K // w.IsReal}, w ∈ 𝔪.infinitePart →
        0 < InfinitePlace.Completion.ringEquivRealOfIsReal w.2
          ((u : AdeleRing (𝓞 K) K).1 w.1)}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **2A.6, the ray subgroup `RaySubgroup 𝔪 ≤ C_K`**, the image of `U_𝔪` in the idele class
group. Naming it matters: the dictionary, the conductor of a character, the existence theorem
and the ray class fields all quantify over these subgroups. -/
noncomputable def RaySubgroup (𝔪 : Modulus K) : Subgroup (IdeleClassGroup K) :=
  (IdeleCongruenceSubgroup 𝔪).map (QuotientGroup.mk' _)

/-- **2A.7, the ray class dictionary, as a named map.** `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`, given
as the surjection together with its kernel and not as an abstract isomorphism of the quotient,
because Layers 3, 6 and 7 use the map itself — and so does the L-functions roadmap, which builds
its finite-order Hecke characters as pullbacks along it. That is why it is a declaration. -/
noncomputable def rayClassQuotient (𝔪 : Modulus K) :
    IdeleClassGroup K →* RayClassGroup 𝔪 := sorry

theorem rayClassQuotient_surjective (𝔪 : Modulus K) :
    Function.Surjective (rayClassQuotient 𝔪) := sorry

theorem ker_rayClassQuotient (𝔪 : Modulus K) :
    (rayClassQuotient 𝔪).ker = RaySubgroup 𝔪 := sorry

/-- **2A.7, openness of the ray subgroup.** The other half of the dictionary, and the reason a
character trivial on `U_𝔪` has open kernel. -/
example (𝔪 : Modulus K) :
    IsOpen (IdeleCongruenceSubgroup 𝔪 : Set (AdeleRing (𝓞 K) K)ˣ) :=
  sorry

/-- **2A.6, antitonicity, which is the compatibility with the transition maps.** The larger
modulus gives the smaller subgroup, and the induced surjections match the maps of 1.4 under the
dictionary. The inverse limit of 7.6 is exactly this compatibility. -/
example (𝔪 𝔫 : Modulus K) (h : 𝔪 ∣ 𝔫) : RaySubgroup 𝔫 ≤ RaySubgroup 𝔪 :=
  sorry

/-! ## Layer 2C: the archimedean local package

The consumed local theory is nonarchimedean, so the real and complex theory is built here. It is
elementary, it is expressible at the pin, and Layers 5, 6, 7 and 11 use it. -/

/-- **2C.3, the real reciprocity map.** `Art_ℝ : ℝˣ → Gal(ℂ/ℝ)` sends a positive element to `1`
and a negative element to complex conjugation. Surjectivity and the kernel are the content. The
complex case is the trivial map, and saying so keeps the two places uniform in the product of
6.1. -/
example :
    ∃ f : ℝˣ →* (ℂ ≃ₐ[ℝ] ℂ),
      Function.Surjective f ∧ ∀ x : ℝˣ, f x = 1 ↔ 0 < (x : ℝ) :=
  sorry

/-- **2C.4, the archimedean norm group.** `N_{ℂ/ℝ}(ℂˣ) = ℝ_{>0}`, so `ℝˣ/N(ℂˣ)` has order two
and matches `Gal(ℂ/ℝ)`. With 2C.3 this is the archimedean case of local reciprocity, and it is
also the real-place clause of the conductor: a real place is unramified exactly when the local
norm group is all of `ℝˣ`. -/
example (x : ℝ) : (∃ z : ℂ, z ≠ 0 ∧ Algebra.norm ℝ z = x) ↔ 0 < x :=
  sorry

/-- **2C.5, the archimedean Herbrand quotient.** `#Ĥ⁰(Gal(ℂ/ℝ), ℂˣ) = 2` and
`H¹(Gal(ℂ/ℝ), ℂˣ) = 1`, so `h(Gal(ℂ/ℝ), ℂˣ) = 2 = [ℂ:ℝ]`. It is stated in the norm-index form
that 5.2 uses. -/
example :
    ∃ N : Subgroup ℝˣ,
      (∀ x : ℝˣ, x ∈ N ↔ 0 < (x : ℝ)) ∧ Nat.card (ℝˣ ⧸ N) = 2 :=
  sorry

/-- **2C.5, the archimedean Herbrand quotient, on the consumed carrier.** `h(Gal(ℂ/ℝ), ℂˣ) = 2`,
stated with the Local Fields roadmap's `herbrandQuotient` and so on its Tate carrier, and not with
a hand-made norm quotient. 5.2 multiplies this factor with the finite ones, and the two must be the
same object for that product to typecheck. -/
example : LocalFields.herbrandQuotient (Rep.ofAlgebraAutOnUnits ℝ ℂ) = 2 :=
  sorry

/-- **2C.8, the real Hilbert symbol.** `(a,b)_ℝ = −1` exactly when both `a` and `b` are
negative, and `(a,b)_ℂ = 1` always. It is stated through the conic, because the Hilbert symbol
itself belongs to the Quadratic Form Invariants roadmap's `hilbertSymbol`. The product formula of
11.4 ranges over all places, and these two values close it at infinity. -/
example (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    (∃ x y z : ℝ, (x, y, z) ≠ (0, 0, 0) ∧ z ^ 2 = a * x ^ 2 + b * y ^ 2) ↔ ¬(a < 0 ∧ b < 0) :=
  sorry

/-! ## Layer 3: Hecke characters -/

/-- **3.1, the Hecke character.** A continuous character of the idele class group. This is the
canonical carrier of the subject, and every roadmap that consumes "a Hecke character" or "a
Grossencharacter" consumes this type. It is an `abbrev`, so that every `ContinuousMonoidHom`
lemma applies without glue.

⚠ There is no second carrier. A structure that stores an ideal weight, a shift, a finite
character and archimedean data is a *presentation* of a term of this type — Neukirch VII (6.9)
is the dictionary — and belongs to the roadmap that needs the presentation, not here. -/
abbrev HeckeCharacter (K : Type u) [Field K] [NumberField K] :=
  ContinuousMonoidHom (IdeleClassGroup K) ℂˣ

/-- **3.1, the ray class character.** The composite notion 3.1 names: a character of the finite
group `Cl_𝔪 K`. The finite-order Hecke characters with `U_𝔪 ⊆ ker χ` are exactly these, and that
bijection is the milestone below. -/
abbrev RayClassCharacter (𝔪 : Modulus K) := RayClassGroup 𝔪 →* ℂˣ

/-- **3.1, the finite-order dictionary.** A continuous character of the idele class group has
finite order exactly when its kernel is open. With 2A.8 this says that the finite-order Hecke
characters are the ray class characters, and over `ℚ` the Dirichlet characters.

**Common error.** The backward direction uses compactness of `C_K/D_K`, which is 2A.5. It is not
formal. -/
example (χ : HeckeCharacter K) :
    (∃ n : ℕ, 0 < n ∧ ∀ y, χ y ^ n = 1) ↔ IsOpen {y | χ y = 1} :=
  sorry

/-- **3.1, a ray class character as a Hecke character.** The constructor named in 3.1's basic
API, "from a character of `Cl_𝔪 K`". It is the pullback along `rayClassQuotient`, and its
continuity is the openness of `RaySubgroup 𝔪`. Every finite-order Hecke character is of this
form, for its ray conductor; that is 3.3. -/
noncomputable def HeckeCharacter.ofRayClassCharacter {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) :
    HeckeCharacter K := sorry

theorem HeckeCharacter.ofRayClassCharacter_apply {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪)
    (y : IdeleClassGroup K) :
    HeckeCharacter.ofRayClassCharacter χ y = χ (rayClassQuotient 𝔪 y) := sorry

/-- **3.1, the dictionary as an equivalence.** The finite-order Hecke characters trivial on
`RaySubgroup 𝔪` are exactly the pullbacks of characters of `Cl_𝔪 K`, and the pullback is
injective. This is what makes "ray class character" and "finite-order Hecke character of modulus
`𝔪`" one notion, so that a consumer may state a theorem in either vocabulary. -/
example (𝔪 : Modulus K) :
    Function.Injective (HeckeCharacter.ofRayClassCharacter (K := K) (𝔪 := 𝔪)) ∧
      ∀ χ : HeckeCharacter K, (∀ y ∈ RaySubgroup 𝔪, χ y = 1) →
        ∃ η : RayClassCharacter 𝔪, HeckeCharacter.ofRayClassCharacter η = χ :=
  sorry

/-- **3.3, induction of a ray class character** along a divisibility of moduli, in the shape of
`DirichletCharacter.changeLevel`: precomposition with the transition map. -/
noncomputable def RayClassCharacter.induced {𝔪 𝔫 : Modulus K} (h : 𝔪 ∣ 𝔫)
    (η : RayClassCharacter 𝔪) : RayClassCharacter 𝔫 :=
  η.comp (classMap h)

/-- **3.3, primitivity of a ray class character.** Not induced from any proper divisor of its
modulus.

⚠ It is stated against `classMap`, and that is load-bearing. "There is no function agreeing with
`η` away from a divisor" is much weaker, because a bare function is not required to be a
character. -/
def RayClassCharacter.IsPrimitive {𝔫 : Modulus K} (η : RayClassCharacter 𝔫) : Prop :=
  ∀ (𝔪 : Modulus K) (h : 𝔪 ∣ 𝔫), 𝔪 ≠ 𝔫 → ¬ ∃ ψ : RayClassCharacter 𝔪, ψ.induced h = η

/-- **3.3, the trivial character of a nontrivial modulus is imprimitive.** It is induced from the
trivial modulus. This is stated because a consumer whose analytic data demands primitivity reads
it: the principal character owns a presented L-series with removed Euler factors, and no
conductor-bearing record. -/
theorem RayClassCharacter.not_isPrimitive_one {𝔫 : Modulus K} (h : 𝔫 ≠ Modulus.one K) :
    ¬ (1 : RayClassCharacter 𝔫).IsPrimitive := sorry

/-- **3.5, the real exponent of a Hecke character.** `|χ| = ‖·‖^σ` for a unique real `σ`, and
`χ = χ_u · ‖·‖^σ` with `χ_u` unitary. The exponent is normalized to be **real**: with a complex
exponent the decomposition is ambiguous exactly up to the unitary twists `‖·‖^{it}`, and the
uniqueness statement is false.

A consumer that builds analytic data from `χ` reads this exponent as the shift of its L-series,
so it is a declaration. -/
noncomputable def HeckeCharacter.shift (χ : HeckeCharacter K) : ℝ := sorry

/-- **3.5, the unitary part**, the second factor of the decomposition. -/
noncomputable def HeckeCharacter.unitaryPart (χ : HeckeCharacter K) : HeckeCharacter K := sorry

theorem HeckeCharacter.norm_unitaryPart (χ : HeckeCharacter K) (y : IdeleClassGroup K) :
    ‖((χ.unitaryPart y : ℂˣ) : ℂ)‖ = 1 := sorry

/-- **3.5**: the shift vanishes exactly on the unitary characters. This is the form a consumer
tests, and together with `norm_unitaryPart` it says that the decomposition is a decomposition. -/
theorem HeckeCharacter.shift_eq_zero_iff (χ : HeckeCharacter K) :
    χ.shift = 0 ↔ ∀ y : IdeleClassGroup K, ‖((χ y : ℂˣ) : ℂ)‖ = 1 := sorry

/-- **3.5 and 3.1**: a finite-order character has shift `0`. It is the compatibility that lets a
consumer treat the ray-class case as the `shift = 0` case of the general one, rather than as a
separate theory. -/
theorem HeckeCharacter.shift_ofRayClassCharacter {𝔪 : Modulus K} (η : RayClassCharacter 𝔪) :
    (HeckeCharacter.ofRayClassCharacter η).shift = 0 := sorry

open scoped Classical in
/-- **3.4, the modulus `(n)·∞` of `ℚ`**, which Layers 3, 4, 7 and 9 evaluate at. -/
noncomputable def ratModulus (n : ℕ) (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) :
    Modulus ℚ where
  finitePart := Ideal.span {(n : 𝓞 ℚ)}
  finitePart_ne_bot := h
  infinitePart := Finset.univ

/-- **3.4 and 4.3 over `ℚ`, the ray class group of `(n)·∞`.** `Cl_{(n)∞}(ℚ) ≃* (ℤ/n)ˣ`, which
is what makes the dictionary with `DirichletCharacter ℂ n` an equivalence. The dictionary must
carry the parity clause: the product formula at the principal idele `−1` shows that the finite
components and the real sign component are not independent, and that the real component is
nontrivial exactly for odd characters. Dropping the infinite place gives
`Cl_{(n)}(ℚ) ≃* (ℤ/n)ˣ/{±1}`. -/
example (n : ℕ) [NeZero n] (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) :
    Nonempty (RayClassGroup (ratModulus n h) ≃* (ZMod n)ˣ) :=
  sorry

/-! ## Layer 4: the cyclotomic anchor -/

/-- **4.1, the splitting law in `ℚ(ζₙ)`.** A prime `p ∤ n` splits completely exactly when
`p ≡ 1 (mod n)`. It is the composite of `galEquivZMod_stabilizer`, which says that the
decomposition group at `p` is generated by `[p]`, with the splits-completely dictionary. The
count uses `Set.ncard`. -/
example (n p : ℕ) [NeZero n] [Fact p.Prime] (hpn : ¬ p ∣ n) :
    (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 (CyclotomicField n ℚ))).ncard
        = Module.finrank ℚ (CyclotomicField n ℚ) ↔ p ≡ 1 [MOD n] :=
  sorry

/-- **4.2, ramification at the conductor-normalized level.** With `n₀ = n/2` for `n ≡ 2 (mod 4)`
and `n₀ = n` otherwise, the ramified finite primes are those dividing `n₀`, provided `n₀ ≥ 3`.
For `n₀ ≤ 2` the field is `ℚ`.

**Common error.** "Ramified exactly at the primes dividing `n`" is false: `ℚ(ζ₆) = ℚ(ζ₃)` is
unramified at `2`. The `(ζ − 1)` theorem holds for prime-power level only. At general level
write `n = p^a m` with `p ∤ m` and use the `e` and `f` formulas of `Cyclotomic/Ideal.lean`. -/
example (n : ℕ) (hn : 3 ≤ n) (hn4 : ¬ (n % 4 = 2)) (p : ℕ) [Fact p.Prime] :
    (∃ P ∈ Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 (CyclotomicField n ℚ)),
        1 < Ideal.ramificationIdx (Ideal.span {(p : ℤ)}) P) ↔ p ∣ n :=
  sorry

/-- **4.3, Artin reciprocity for `(ℚ, ℚ(ζₙ))`.** The ray class group of `(n)·∞` is isomorphic to
`Gal(ℚ(ζₙ)/ℚ)`, by a map that sends the class of `(p)`, for `p` prime to `n`, to the
automorphism that `galEquivZMod` carries to `[p]`. That this automorphism is the arithmetic
Frobenius is I.2 together with Mathlib's `arithFrobAt`, and it is not restated here.

**Common error.** The geometric convention puts `[p]⁻¹` on the right. Both conventions give an
automorphism of `(ℤ/n)ˣ`, so a degree count does not detect the error. -/
example (n : ℕ) [NeZero n] (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) (F : Type u)
    [Field F] [NumberField F] [IsCyclotomicExtension {n} ℚ F] :
    ∃ θ : RayClassGroup (ratModulus n h) ≃* Gal(F/ℚ),
      ∀ (p : ℕ) (hp : p.Coprime n) (u : ℚˣ), (u : ℚ) = p →
        ∀ hu : toPrincipalIdeal (𝓞 ℚ) ℚ u ∈ idealsPrimeTo (ratModulus n h),
          IsCyclotomicExtension.Rat.galEquivZMod n F
              (θ (QuotientGroup.mk ⟨toPrincipalIdeal (𝓞 ℚ) ℚ u, hu⟩))
            = ZMod.unitOfCoprime p hp :=
  sorry

/-! ## Layer 10B: orders and their Picard groups

Mathlib has no theory of nonmaximal orders in a number field, and the Dedekind-generic machinery
of Layers 0 and 1 does not apply to them, because an order is usually not integrally closed.
This roadmap owns them. The Integral Lattices roadmap consumes the four carriers below for its
binary-form dictionary, so they carry Lean names and `README.md` records the contract. -/

/-- **10B.1, an order in a number field.** A subring of `K` that is finite over `ℤ` and spans `K`
over `ℚ`. The two conditions together are the classical "free of rank `[K:ℚ]` with fraction field
`K`"; they are stated separately because each is what a different milestone uses. -/
structure NumberFieldOrder (K : Type u) [Field K] [NumberField K] where
  /-- The underlying subring, as a `ℤ`-subalgebra of `K`. -/
  toSubalgebra : Subalgebra ℤ K
  /-- Finiteness over `ℤ`. -/
  finite : Module.Finite ℤ toSubalgebra
  /-- The order spans `K` over `ℚ`, so `K` is its field of fractions. -/
  spans : Submodule.span ℚ (toSubalgebra : Set K) = ⊤

/-- **10B.1**: `K` is the fraction field of any order in it. ⚠ Registered as an instance because
every fractional-ideal statement below needs it; it is a milestone of 10B.1 and not an
assumption. -/
noncomputable instance (O : NumberFieldOrder K) : IsFractionRing O.toSubalgebra K := sorry

/-- **10B.2, the conductor** `𝔠(O) = {x ∈ K | x 𝓞_K ⊆ O}`, the largest `𝓞_K`-ideal contained in
`O`. The index formula `disc O = [𝓞_K : O]² disc 𝓞_K` is stated against it. -/
noncomputable def NumberFieldOrder.conductor (O : NumberFieldOrder K) : Ideal (𝓞 K) := sorry

/-- **10B.3, the proper fractional ideals**, those `I` with `{x ∈ K | x I ⊆ I} = O`. ⚠ For a
nonmaximal order this is a *strictly* smaller condition than being a fractional ideal, and it is
the one equivalent to invertibility; a dictionary stated over all fractional ideals is false. -/
noncomputable def NumberFieldOrder.properIdeals (O : NumberFieldOrder K) :
    Subgroup (FractionalIdeal (O.toSubalgebra)⁰ K)ˣ := sorry

/-- **10B.4, the Picard group** `Pic O`, the proper fractional ideals modulo the principal ones.
It is Mathlib's generic `ClassGroup` of the order; 10B.4 is the comparison that says so, and it
is the reason this is a definition and not a new quotient. -/
noncomputable def Pic (O : NumberFieldOrder K) : Type u := ClassGroup O.toSubalgebra

noncomputable instance (O : NumberFieldOrder K) : CommGroup (Pic O) :=
  inferInstanceAs (CommGroup (ClassGroup O.toSubalgebra))

/-- **10B.4, the class of a proper fractional ideal.** -/
noncomputable def NumberFieldOrder.mkPic (O : NumberFieldOrder K) (I : O.properIdeals) : Pic O :=
  sorry

theorem NumberFieldOrder.mkPic_surjective (O : NumberFieldOrder K) :
    Function.Surjective O.mkPic := sorry

/-- **10B.4, the principal ideals with a totally positive generator**, the subgroup the narrow
Picard group is the quotient by. It is a subgroup of the proper ideals and not of all fractional
ideals. -/
noncomputable def NumberFieldOrder.narrowPrincipal (O : NumberFieldOrder K) :
    Subgroup (FractionalIdeal (O.toSubalgebra)⁰ K)ˣ := sorry

/-- **10B.4, the narrow Picard group.** For a real quadratic order this is the target of the
binary-form dictionary, and it is **not** `Pic O`: two proper ideals are identified only when
they differ by a principal ideal with a generator of positive norm.

⚠ This roadmap owns the narrow group as well as the wide one. A consumer that needs the positive
discriminant case consumes this declaration, and does not define a second narrow quotient. -/
def NarrowPic (O : NumberFieldOrder K) : Type u :=
  (FractionalIdeal (O.toSubalgebra)⁰ K)ˣ ⧸ O.narrowPrincipal

noncomputable instance (O : NumberFieldOrder K) : CommGroup (NarrowPic O) :=
  inferInstanceAs (CommGroup ((FractionalIdeal (O.toSubalgebra)⁰ K)ˣ ⧸ O.narrowPrincipal))

/-- **10B.4**: the narrow group surjects onto the wide one, with the kernel generated by the
classes of principal ideals whose generators have negative norm. For a totally imaginary `K` the
two agree. -/
theorem narrowPic_surjective (O : NumberFieldOrder K) :
    ∃ f : NarrowPic O →* Pic O, Function.Surjective f := sorry

/-- **10B.7, finiteness.** Both groups are finite. -/
theorem finite_pic (O : NumberFieldOrder K) : Finite (Pic O) := sorry

theorem finite_narrowPic (O : NumberFieldOrder K) : Finite (NarrowPic O) := sorry

/-- **10C.1, the ring class field.** The abelian extension of `K` corresponding to the congruence
subgroup of 10B.6, with `Gal(H_O/K) ≅ Pic O`. The Integral Lattices roadmap composes this
isomorphism with its binary-form dictionary, so it is a named declaration here. -/
noncomputable def ringClassField (O : NumberFieldOrder K) :
    IntermediateField K (AlgebraicClosure K) := sorry

theorem gal_ringClassField_equiv_pic (O : NumberFieldOrder K) :
    Nonempty ((ringClassField O ≃ₐ[K] ringClassField O) ≃* Pic O) := sorry

/-! ## Layer 10A: continuous characters of the archimedean groups -/

/-- **10A.1, the continuous characters of `ℝˣ`.** Every one is `x ↦ |x|^s` times a power of the
sign, for a unique exponent `s : ℂ` and a unique parity. The parity is typed as `ZMod 2`,
because only its class modulo two is determined, and an `ℕ`-valued statement cannot be a
uniqueness statement. -/
example (χ : ContinuousMonoidHom ℝˣ ℂˣ) :
    ∃! p : ℂ × ZMod 2, ∀ x : ℝˣ,
      (χ x : ℂ) = (‖(x : ℝ)‖ : ℂ) ^ p.1 * (if 0 < (x : ℝ) then 1 else (-1) ^ p.2.val) :=
  sorry

/-- **10A.1, the continuous characters of `ℂˣ`.** Every one is `z ↦ (z/|z|)^k · |z|^s` for a
unique pair `(k, s) : ℤ × ℂ`. Uniqueness follows by restricting to the unit circle, which fixes
`k`, and to `ℝ_{>0}`, which fixes `s`.

**Common error.** At a complex place an algebraic infinity type has two integer exponents, and
the radial exponent `s = p + q` is not zero in general. "All radial exponents are zero" is not
the algebraicity condition, and it excludes the algebraic norm twists. -/
example (χ : ContinuousMonoidHom ℂˣ ℂˣ) :
    ∃! p : ℤ × ℂ, ∀ z : ℂˣ,
      (χ z : ℂ) = ((z : ℂ) / (‖(z : ℂ)‖ : ℂ)) ^ p.1 * (‖(z : ℂ)‖ : ℂ) ^ p.2 :=
  sorry

/-! ## Layer 11: Hasse–Minkowski over number fields

The local theory and the local classification of quadratic forms are the Quadratic Form Invariants
roadmap's. What is here is the one **global** theorem, because its proof consumes weak
approximation (0.2), the cyclic Hasse norm theorem (5.5), and Hilbert reciprocity (11.4), all
constructed in this roadmap.

⚠ Every localization below is an actual `QuadraticForm.baseChange` along an actual completion or
real embedding. Nothing here is a free function in an interface structure, and no predicate is a
`Prop := sorry`. -/

section HasseMinkowski

variable {K : Type u} [Field K] [NumberField K]
  {V : Type v} [AddCommGroup V] [Module K V]

/-- **11.5, localization at a finite place.** The base change of `Q` to `K_v`. -/
noncomputable def atFinitePlace (Q : QuadraticForm K V) (v : HeightOneSpectrum (𝓞 K)) :
    QuadraticForm (v.adicCompletion K) (v.adicCompletion K ⊗[K] V) :=
  Q.baseChange (v.adicCompletion K)

/-- **11.5, localization at a real place.** The base change along the real embedding of `w`,
which is the archimedean vocabulary Layers 0 and 2C already use. There is no second real-place
carrier. -/
noncomputable def atRealPlace (Q : QuadraticForm K V)
    (w : {w : InfinitePlace K // w.IsReal}) :
    letI := (InfinitePlace.embedding_of_isReal w.2).toAlgebra
    QuadraticForm ℝ (ℝ ⊗[K] V) :=
  letI := (InfinitePlace.embedding_of_isReal w.2).toAlgebra
  Q.baseChange ℝ

/-- **11.5, local isotropy.** ⚠ The complex places are **absent by theorem**, not by oversight:
`not_anisotropic_complex` below says a regular form of rank at least `2` over an algebraically
closed field is isotropic, so a complex clause would be vacuous. The finite and the real clauses
are both load-bearing, and dropping either makes 11.6 false. -/
def IsLocallyIsotropic (Q : QuadraticForm K V) : Prop :=
  (∀ v : HeightOneSpectrum (𝓞 K), ¬ (atFinitePlace Q v).Anisotropic) ∧
    ∀ w : {w : InfinitePlace K // w.IsReal}, ¬ (atRealPlace Q w).Anisotropic

/-- **11.5, local equivalence.** Same quantification, and the same reason for it:
`equivalent_of_finrank_eq_complex` makes the complex clause a consequence of equal rank. -/
def LocallyEquivalent {W : Type v} [AddCommGroup W] [Module K W]
    (Q : QuadraticForm K V) (R : QuadraticForm K W) : Prop :=
  (∀ v : HeightOneSpectrum (𝓞 K), (atFinitePlace Q v).Equivalent (atFinitePlace R v)) ∧
    ∀ w : {w : InfinitePlace K // w.IsReal},
      (atRealPlace Q w).Equivalent (atRealPlace R w)

/-- **11.5, complex-place automaticity, the isotropy half.** Over an algebraically closed field a
regular form of rank at least `2` is isotropic. This is why `IsLocallyIsotropic` has no complex
clause. -/
theorem not_anisotropic_complex {W : Type v} [AddCommGroup W] [Module ℂ W]
    [FiniteDimensional ℂ W] (Q : QuadraticForm ℂ W) (hQ : Q.Nondegenerate)
    (h : 2 ≤ Module.finrank ℂ W) : ¬ Q.Anisotropic :=
  sorry

/-- **11.5, complex-place automaticity, the isometry half.** Over an algebraically closed field
the rank is a complete invariant of a regular form. This is why `LocallyEquivalent` has no complex
clause: at a complex place, equal rank already gives equivalence. -/
theorem equivalent_of_finrank_eq_complex {W₁ W₂ : Type v} [AddCommGroup W₁] [Module ℂ W₁]
    [FiniteDimensional ℂ W₁] [AddCommGroup W₂] [Module ℂ W₂] [FiniteDimensional ℂ W₂]
    (Q : QuadraticForm ℂ W₁) (R : QuadraticForm ℂ W₂) (hQ : Q.Nondegenerate)
    (hR : R.Nondegenerate) (h : Module.finrank ℂ W₁ = Module.finrank ℂ W₂) :
    Q.Equivalent R :=
  sorry

/-- **11.6, the Hasse–Minkowski theorem for isotropy** (O'Meara 66:1). A regular form over a
number field is isotropic exactly when it is isotropic at every finite completion and every real
completion.

Suggested name for the implementation: `TauCeti.NumberField.QuadraticForm.hasseMinkowski_isotropic`.

⚠ Neither half of the local hypothesis may be dropped. Isotropy at every **real** place alone is
insufficient — `⟨1, 1, -3⟩` over `ℚ` is indefinite, hence isotropic over `ℝ`, and anisotropic over
`ℚ` because it is anisotropic over `ℚ₃`. Isotropy at all **but one** place is insufficient too:
by Hilbert reciprocity the local obstructions multiply to `1`, so a single missing place carries
the whole failure.

⚠ Two traps in the proof route, which `README.md` writes out in four cases. The quaternary case is
not an instance of the rank-`≥ 5` induction, because that induction needs the complement to have
rank at least `3`. And in that induction the approximation is applied to the **coordinates of a
vector** of the binary summand, with the scalar defined from the result: approximating a scalar in
the right local square classes gives only half of the pair `β = Q x`, `-β = Q y` that the
isotropic vector needs. -/
theorem hasseMinkowski_isotropic [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) :
    ¬ Q.Anisotropic ↔ IsLocallyIsotropic Q :=
  sorry

/-- **11.7, the scalar representation theorem.** `Q` represents a nonzero `a` over `K` exactly
when it does over every finite and every real completion. It is 11.6 applied to `⟨-a⟩ ⊥ Q`, and
not an independent statement. -/
theorem represents_iff_locally_represents [FiniteDimensional K V] (Q : QuadraticForm K V)
    (hQ : Q.Nondegenerate) (a : K) (ha : a ≠ 0) :
    (∃ x : V, Q x = a) ↔
      ((∀ v : HeightOneSpectrum (𝓞 K), ∃ x, atFinitePlace Q v x = algebraMap K _ a) ∧
        ∀ w : {w : InfinitePlace K // w.IsReal},
          ∃ x, atRealPlace Q w x = InfinitePlace.embedding_of_isReal w.2 a) :=
  sorry

/-- **11.7, the representation theorem for forms** (O'Meara 66:3), by induction on `dim W₁` from
the scalar case together with Witt cancellation. This is the statement 11.8 is a corollary of, and
it is derived from 11.6 rather than assumed beside it. -/
theorem represented_iff_locally_represented [FiniteDimensional K V] {W : Type v} [AddCommGroup W]
    [Module K W] [FiniteDimensional K W] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (R : QuadraticForm K W) (hR : R.Nondegenerate) :
    (∃ f : V →ₗ[K] W, Function.Injective f ∧ ∀ x, R (f x) = Q x) ↔
      ((∀ v : HeightOneSpectrum (𝓞 K), ∃ f : _ →ₗ[v.adicCompletion K] _,
          Function.Injective f ∧ ∀ x, atFinitePlace R v (f x) = atFinitePlace Q v x) ∧
        ∀ w : {w : InfinitePlace K // w.IsReal},
          letI := (InfinitePlace.embedding_of_isReal w.2).toAlgebra
          ∃ f : _ →ₗ[ℝ] _, Function.Injective f ∧
            ∀ x, atRealPlace R w (f x) = atRealPlace Q w x) :=
  sorry

/-- **11.8, the Hasse–Minkowski theorem for isometry** (O'Meara 66:4). Two regular forms over a
number field are isometric exactly when they are isometric at every finite completion and every
real completion. This is the theorem the Orthogonal and Spin Groups roadmap consumes, at `K = ℚ`.

Suggested name for the implementation:
`TauCeti.NumberField.QuadraticForm.hasseMinkowski_equivalent`.

The forward direction is scalar extension of an isometry. The reverse is 11.7 at equal rank: a
representation between regular forms of the same dimension is an isometry. -/
theorem hasseMinkowski_equivalent [FiniteDimensional K V] {W : Type v} [AddCommGroup W]
    [Module K W] [FiniteDimensional K W] (Q : QuadraticForm K V) (hQ : Q.Nondegenerate)
    (R : QuadraticForm K W) (hR : R.Nondegenerate) :
    Q.Equivalent R ↔ LocallyEquivalent Q R :=
  sorry

end HasseMinkowski

section HasseMinkowskiRat

/-- **The `K = ℚ` specialization**, in the shape the Orthogonal and Spin Groups roadmap consumes
at its 5H: two regular forms over `ℚ` of the same dimension that are isometric over every finite
and every real completion are isometric over `ℚ`. This is a **closed** application — the theorem
above is the milestone, and this says that its statement already has the shape that consumer
needs, with every coercion elaborating. -/
example {V W : Type} [AddCommGroup V] [Module ℚ V] [FiniteDimensional ℚ V]
    [AddCommGroup W] [Module ℚ W] [FiniteDimensional ℚ W]
    (Q : QuadraticForm ℚ V) (hQ : Q.Nondegenerate) (R : QuadraticForm ℚ W)
    (hR : R.Nondegenerate) (h : LocallyEquivalent Q R) :
    Q.Equivalent R :=
  (hasseMinkowski_equivalent Q hQ R hR).2 h

/-- **W12, the acceptance instance**: `⟨1, 1, -3⟩` over `ℚ` is anisotropic, while it is isotropic
over `ℝ`. The obstruction is at `3`, and 11.6 is what turns the local statement into the global
one; checking archimedean signatures alone would have concluded the opposite. -/
example : (QuadraticMap.weightedSumSquares ℚ ![(1 : ℚ), 1, -3]).Anisotropic :=
  sorry

end HasseMinkowskiRat

/-! ## Acceptance shapes for Layers 8 to 10

These four statements are consequences of the later layers that the pin can already express.
They are end-to-end checks on the whole stack. -/

/-- **W7, `x² + 5y²`.** For a prime `p ∉ {2, 5}`: `p = x² + 5y²` exactly when `p ≡ 1, 9 (mod 20)`.
The congruence equivalence alone is elementary. What tests this roadmap is the middle term: `p`
splits completely in the Hilbert class field `H = ℚ(√−5, i)` of `K = ℚ(√−5)`, which has class
number 2. `H` is also the genus field, so this is the Multiquadratic interface instance. -/
example (p : ℕ) (hp : p.Prime) (h2 : p ≠ 2) (h5 : p ≠ 5) :
    (∃ x y : ℤ, (p : ℤ) = x ^ 2 + 5 * y ^ 2) ↔ (p % 20 = 1 ∨ p % 20 = 9) :=
  sorry

/-- **W11, `x² + 27y²`, the nonmaximal-order instance.** Gauss's criterion: for `p ≠ 2, 3`,
`p = x² + 27y²` exactly when `p ≡ 1 (mod 3)` and `2` is a cubic residue modulo `p`. The class
field content is that both sides say that `p` splits completely in `ℚ(√−3, ∛2)`, the ring class
field of the order `ℤ[√−27] = ℤ + 6𝓞_K` of discriminant `−108` and conductor `6` in `ℚ(√−3)`,
whose Picard group is `ℤ/3`. This is the example that exercises Layer 10B. -/
example (p : ℕ) (hp : p.Prime) (h2 : p ≠ 2) (h3 : p ≠ 3) :
    (∃ x y : ℤ, (p : ℤ) = x ^ 2 + 27 * y ^ 2) ↔
      (p % 3 = 1 ∧ ∃ x : ZMod p, x ^ 3 = 2) :=
  sorry

/-- **9.1, Kronecker–Weber.** Every abelian extension of `ℚ` embeds in a cyclotomic field. The
sharp form, that the least such `n` is the finite part of the conductor and is never
`≡ 2 (mod 4)`, is the milestone proper. Route: it is a corollary of 7.7. Do not build the
elementary ramification-theoretic proof as a prerequisite. -/
example (L : Type u) [Field L] [NumberField L] [IsAbelianGalois ℚ L] :
    ∃ n : ℕ, n ≠ 0 ∧ Nonempty (L →ₐ[ℚ] CyclotomicField n ℚ) :=
  sorry

/-- **W8, the smallest conductor computation.** `√5 ∈ ℚ(ζ₅)`: the quadratic field of
discriminant `5` lies in the fifth cyclotomic field, so the least cyclotomic level of `ℚ(√5)` is
its conductor `5`. The companion inclusions `ℚ(i) ⊆ ℚ(ζ₄)` and `ℚ(√2) ⊆ ℚ(ζ₈)` fix the levels
`4` and `8`. An implementation that puts no infinite place in the conductor of `ℚ(i)` has the
real-place convention backwards. -/
example : ∃ x : CyclotomicField 5 ℚ, x ^ 2 = 5 :=
  sorry

end TauCetiRoadmap.GlobalClassFieldTheory
