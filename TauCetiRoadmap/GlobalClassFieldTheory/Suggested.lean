import Mathlib

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
-/

namespace TauCetiRoadmap.GlobalClassFieldTheory

open NumberField IsDedekindDomain

open scoped nonZeroDivisors ValuativeRel

universe u

/-! ## Layer I: the local interface

Global class field theory needs local class field theory. This roadmap states the local input
as the interface below. Milestone I.4 asks for an instance, from a Tau Ceti local class field
theory if one exists, and otherwise from the literature. No milestone of this roadmap depends
on anything outside this repository. -/

/-- **I.1, the nonarchimedean local reciprocity interface.** The data and the laws that
Layers 5, 6, 7 and 11 use from local class field theory, for one finite abelian extension
`E/F` of nonarchimedean local fields.

The Frobenius normalization is the third field. It says that `art π` acts on the integers of
`E` as the `q`-power map modulo the maximal ideal, for `q` the residue cardinality of `F`, and
for `π` of maximal valuation among the elements of valuation less than one, that is a
uniformizer. That is Mathlib's `AlgHom.IsArithFrobAt` congruence, written with the valuation so
that no ring instance on the integers is needed. -/
structure LocalArtinMap (F E : Type u)
    [Field F] [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Field E] [ValuativeRel E] [TopologicalSpace E] [IsNonarchimedeanLocalField E]
    [Algebra F E] [Module.Finite F E] where
  /-- The local Artin map. -/
  art : Fˣ →* (E ≃ₐ[F] E)
  /-- The local Artin map is surjective. -/
  art_surjective : Function.Surjective art
  /-- Its kernel is the group of norms from `E`. -/
  ker_art : ∀ x : Fˣ, art x = 1 ↔ ∃ y : Eˣ, Algebra.norm F (y : E) = (x : F)
  /-- Arithmetic normalization at a uniformizer, when `E/F` is unramified. -/
  art_uniformizer :
    ∀ π : Fˣ, ValuativeRel.valuation F (π : F) < 1 →
      (∀ y : F, ValuativeRel.valuation F y < 1 →
        ValuativeRel.valuation F y ≤ ValuativeRel.valuation F (π : F)) →
      (∀ u : Fˣ, ValuativeRel.valuation F (u : F) = 1 → art u = 1) →
      ∀ x : E, ValuativeRel.valuation E x ≤ 1 →
        ValuativeRel.valuation E (art π x - x ^ Nat.card 𝓀[F]) < 1
  /-- The conductor exponent: the least `n` with `1 + 𝔭^n` inside the norm group. It is `0`
  exactly when `E/F` is unramified, which is the case where `art` kills the units. -/
  conductorExp : ℕ
  conductorExp_eq_zero :
    conductorExp = 0 ↔ ∀ u : Fˣ, ValuativeRel.valuation F (u : F) = 1 → art u = 1

/-- **I.1, functoriality of the interface in the upper field.** For `F ⊆ E ⊆ E'` the Artin map
of `E'/F` restricts to the Artin map of `E/F`. Layer 6 uses this to compile the global map. -/
example (F E E' : Type u)
    [Field F] [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Field E] [ValuativeRel E] [TopologicalSpace E] [IsNonarchimedeanLocalField E]
    [Field E'] [ValuativeRel E'] [TopologicalSpace E'] [IsNonarchimedeanLocalField E']
    [Algebra F E] [Module.Finite F E] [Algebra F E'] [Module.Finite F E'] [Algebra E E']
    [IsScalarTower F E E']
    (A : LocalArtinMap F E) (A' : LocalArtinMap F E') :
    ∀ (x : Fˣ) (y : E), algebraMap E E' ((A.art x) y) = (A'.art x) (algebraMap E E' y) :=
  sorry

/-- **I.2, the ideals with support away from a finite set of primes.** The carrier of the
ideal-theoretic Artin map. It is `J^S` of the conventions table, and `J^{𝔪₀}` of Layer 1 is the
special case where `S` is the set of primes dividing the modulus. -/
def idealsAway {K : Type u} [Field K] [NumberField K] (S : Finset (HeightOneSpectrum (𝓞 K))) :
    Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ where
  carrier := {I | ∀ v ∈ S, FractionalIdeal.count K v (I : FractionalIdeal (𝓞 K)⁰ K) = 0}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **I.2, the ideal-theoretic Artin map.** For finite abelian `L/K` and a finite set `S` of
primes that contains every ramified prime, a multiplicative map on `J^S` whose value at a prime
outside `S` is the arithmetic Frobenius. The Frobenius itself is Mathlib's `arithFrobAt`, so
this milestone adds multiplicativity and the functoriality of the README, and not a second
Frobenius. -/
example (K L : Type u) [Field K] [NumberField K] [Field L] [NumberField L] [Algebra K L]
    [IsAbelianGalois K L] (S : Finset (HeightOneSpectrum (𝓞 K)))
    (hS : ∀ v : HeightOneSpectrum (𝓞 K), ¬ Algebra.IsUnramifiedAt (𝓞 K) v.asIdeal → v ∈ S) :
    ∃ f : idealsAway S →* (L ≃ₐ[K] L),
      ∀ (v : HeightOneSpectrum (𝓞 K)) (hv : v ∉ S) (I : idealsAway S),
        ((I : (FractionalIdeal (𝓞 K)⁰ K)ˣ) : FractionalIdeal (𝓞 K)⁰ K) =
            FractionalIdeal.coeIdeal v.asIdeal →
          ∃ Q : Ideal (𝓞 L), Q.IsPrime ∧ Q.under (𝓞 K) = v.asIdeal ∧
            IsArithFrobAt (𝓞 K) (galRestrict (𝓞 K) K L (𝓞 L) (f I)) Q :=
  sorry

/-- **I.3, the completion dictionary at a finite place.** The completion of a number field at a
finite place is a nonarchimedean local field. This statement is where every use of the local
interface enters. The `ValuativeRel` and `IsValuativeTopology` instances are hypotheses,
because producing them from the pin's `Valued` instance on `adicCompletion`, without stating
anything new against `Valued`, is part of the milestone. -/
example {K : Type u} [Field K] [NumberField K] (v : HeightOneSpectrum (𝓞 K))
    [ValuativeRel (v.adicCompletion K)] [IsValuativeTopology (v.adicCompletion K)] :
    IsNonarchimedeanLocalField (v.adicCompletion K) :=
  sorry

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
the pin. Prove Artin–Whaples weak approximation for a finite set of places and read this off. -/
example (S : Finset (HeightOneSpectrum (𝓞 K))) (a : HeightOneSpectrum (𝓞 K) → K)
    (n : HeightOneSpectrum (𝓞 K) → ℕ) (T : Finset {w : InfinitePlace K // w.IsReal})
    (ε : {w : InfinitePlace K // w.IsReal} → ℤˣ) :
    ∃ x : K,
      (∀ v ∈ S, v.valuation K (x - a v) ≤
        ((Multiplicative.ofAdd (-(n v : ℤ)) : Multiplicative ℤ) :
          WithZero (Multiplicative ℤ))) ∧
        ∀ w ∈ T, (0 < InfinitePlace.embedding_of_isReal w.2 x ↔ ε w = 1) :=
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

/-- **2A.7, the ray class dictionary.** `U_𝔪` is open, and `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`. It
is stated as the surjection together with its kernel, and not as an abstract isomorphism of the
quotient, because Layers 3, 6 and 7 use the map itself. -/
example (𝔪 : Modulus K) :
    IsOpen (IdeleCongruenceSubgroup 𝔪 : Set (AdeleRing (𝓞 K) K)ˣ) ∧
      ∃ f : IdeleClassGroup K →* RayClassGroup 𝔪,
        Function.Surjective f ∧ f.ker = RaySubgroup 𝔪 :=
  sorry

/-- **2A.6, antitonicity, which is the compatibility with the transition maps.** The larger
modulus gives the smaller subgroup, and the induced surjections match the maps of 1.4 under the
dictionary. The inverse limit of 7.6 is exactly this compatibility. -/
example (𝔪 𝔫 : Modulus K) (h : 𝔪 ∣ 𝔫) : RaySubgroup 𝔫 ≤ RaySubgroup 𝔪 :=
  sorry

/-! ## Layer 2C: the archimedean local package

The interface of Layer I is nonarchimedean, so the real and complex theory is built here. It is
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

/-- **2C.8, the real Hilbert symbol.** `(a,b)_ℝ = −1` exactly when both `a` and `b` are
negative, and `(a,b)_ℂ = 1` always. It is stated through the conic, because the Hilbert symbol
itself belongs to the interface I.1.11. The product formula of 11.4 ranges over all places, and
these two values close it at infinity. -/
example (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    (∃ x y z : ℝ, (x, y, z) ≠ (0, 0, 0) ∧ z ^ 2 = a * x ^ 2 + b * y ^ 2) ↔ ¬(a < 0 ∧ b < 0) :=
  sorry

/-! ## Layer 3: Hecke characters -/

/-- **3.1, the finite-order dictionary.** A continuous character of the idele class group has
finite order exactly when its kernel is open. With 2A.8 this says that the finite-order Hecke
characters are the ray class characters, and over `ℚ` the Dirichlet characters.

**Common error.** The backward direction uses compactness of `C_K/D_K`, which is 2A.5. It is not
formal. -/
example (χ : ContinuousMonoidHom (IdeleClassGroup K) ℂˣ) :
    (∃ n : ℕ, 0 < n ∧ ∀ y, χ y ^ n = 1) ↔ IsOpen {y | χ y = 1} :=
  sorry

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
        1 < Ideal.ramificationIdx P ℤ) ↔ p ∣ n :=
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
