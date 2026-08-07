import Mathlib

/-!
# Global class field theory: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0 to 11, the pinned conventions, the route decision, the worked
examples, and the references) is in `README.md`. Mathlib has the adele ring of a number field
and the classical class group, but none of global class field theory's own objects: no ray
class groups or moduli, no narrow class group, no idele class group (in flight as mathlib
PR #40735, so align rather than fork), no Hecke characters, no reciprocity law, no existence
theorem, no Hilbert class field, no Kronecker–Weber.

Three kinds of item appear below.

* **Data prototypes** (`Modulus`, the divisibility relation, the congruence predicates,
  `unitsCongruenceSubgroup`, `RaySubgroup`) are real definitions, because the shape of the data
  is itself a decision the roadmap makes and a contributor should not have to reinvent it.
* **Structure prototypes** (the congruence and prime-to subgroups of `Kˣ`, the ideal group
  prime to a modulus, the ray class group, the idele congruence subgroup `U_𝔪`) carry the exact
  carrier and leave the routine closure proofs as `sorry`. The carrier is the design decision;
  the closure proofs are milestones of Layers 0, 1 and 2A. Nothing here is an existential
  subgroup whose carrier cannot be read off its type.
* **Milestone statements** are `example`s ending in `sorry`, and each says exactly what its
  docstring claims: where a docstring speaks of a kernel, an exactness, a carrier or a
  uniqueness, the statement carries it.

Per the honest-`sorry` rule, milestones whose *statements* need vocabulary that does not exist
at the pin are not stated here and live in `README.md` only: the idele functoriality of
Layer 2B (the Galois action on `𝔸_L`, the idele norm, `C_L^G ≃ C_K`) needs the base-change
algebra structure on adele rings, which the pin does not have; the norm-index machinery of
Layer 5, the global Artin map and reciprocity law of Layers 6 and 7, and the class formation of
Layer 11 need those objects in turn. As each layer makes its types expressible in `TauCeti/`,
add its milestones here with `sorry`.
-/

namespace TauCetiRoadmap.GlobalClassFieldTheory

open NumberField IsDedekindDomain

open scoped nonZeroDivisors

universe u

/-! ## Layer 0: moduli, approximation, and multiplicative congruences -/

/-- **Layer 0, the modulus.** A modulus of a number field is a nonzero integral ideal together
with a finite set of real places. Typing the infinite part by the real places, rather than by
all infinite places with a side condition, is deliberate: complex places never divide a
modulus, and a design in which the infinite part is easy to forget silently produces the wide
class group everywhere. The finite part has a second face as a finitely supported exponent
function on `HeightOneSpectrum (𝓞 K)`; the translation lemmas are a Layer 0 milestone. -/
structure Modulus (K : Type u) [Field K] [NumberField K] where
  /-- The finite part, a nonzero ideal of the ring of integers. -/
  finitePart : Ideal (𝓞 K)
  /-- Moduli have nonzero finite part; `(1)` is spelled `⊤`, not `⊥`. -/
  finitePart_ne_bot : finitePart ≠ ⊥
  /-- The infinite part: a finite set of real places. -/
  infinitePart : Finset {w : InfinitePlace K // w.IsReal}

variable {K : Type u} [Field K] [NumberField K]

/-- **Layer 0, divisibility of moduli, in the pinned orientation.** `𝔪 ∣ 𝔫` means that the
exponent at every finite place weakly increases and that the infinite part grows. The induced
map on ray class groups then runs `Cl_𝔫 ↠ Cl_𝔪`, the larger modulus mapping onto the
smaller. -/
instance : Dvd (Modulus K) :=
  ⟨fun 𝔪 𝔫 => 𝔪.finitePart ∣ 𝔫.finitePart ∧ 𝔪.infinitePart ⊆ 𝔫.infinitePart⟩

/-- The exponent of a finite place in the finite part of a modulus. -/
noncomputable def Modulus.exponent (𝔪 : Modulus K) (v : HeightOneSpectrum (𝓞 K)) : ℕ :=
  (Associates.mk v.asIdeal).count (Associates.mk 𝔪.finitePart).factors

/-- **Layer 0, multiplicative congruence.** `x ≡ 1 mod* 𝔪` for `x ∈ Kˣ`: the order of
vanishing of `x - 1` at each finite place dividing `𝔪₀` is at least the exponent there, and
`x` is positive at each real place of `𝔪∞`. ⚠ This is a multiplicative condition on `Kˣ`, not
membership in `1 + 𝔪₀` inside `𝓞 K`; the two agree only for integral `x` prime to `𝔪₀`.
Under the pin's multiplicative `ℤᵐ⁰`-valued valuation, a higher order of vanishing means a
smaller value, which is why the inequality below points the way it does. -/
def IsCongrOne (𝔪 : Modulus K) (x : Kˣ) : Prop :=
  (∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
      v.valuation K ((x : K) - 1) ≤
        ((Multiplicative.ofAdd (-(𝔪.exponent v : ℤ)) : Multiplicative ℤ) :
          WithZero (Multiplicative ℤ))) ∧
    ∀ w ∈ 𝔪.infinitePart, 0 < InfinitePlace.embedding_of_isReal w.2 (x : K)

/-- **Layer 0, the elements prime to the finite part.** "Prime to `𝔪₀`" is not a Lean type, so
it is this named subgroup of `Kˣ`, equivalently the unit group of the localization of `𝓞 K`
away from `𝔪₀`. It is the exact domain of the reduction map to `(𝓞 K ⧸ 𝔪₀)ˣ × signs` below,
and it has to be a subgroup rather than a predicate, because Layer 1's exact sequence quotients
by it. -/
def primeToSubgroup (𝔪 : Modulus K) : Subgroup Kˣ where
  carrier := {x | ∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
    v.valuation K (x : K) = 1}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **Layer 0, the congruence subgroup of `Kˣ`.** The carrier is pinned; that it is a subgroup
is the milestone, and it is proved by the ultrametric inequality at the finite places and the
sign calculus at the real ones, never by ring arithmetic in a quotient. -/
def congruenceSubgroup (𝔪 : Modulus K) : Subgroup Kˣ where
  carrier := {x | IsCongrOne 𝔪 x}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **Layer 0, congruence implies prime to the modulus.** If `ord_v(x − 1) ≥ 1` then
`ord_v(x) = 0`, so the containment is free; it is stated because the reduction map below is
defined on `primeToSubgroup 𝔪` and its kernel is `congruenceSubgroup 𝔪`, which only typechecks
against this. -/
example (𝔪 : Modulus K) : congruenceSubgroup 𝔪 ≤ primeToSubgroup 𝔪 :=
  sorry

/-- **Layer 0, simultaneous approximation, in the reusable form.** Independent targets `a v` and
independent depths `n v` at finitely many finite places, and independent signs at finitely many
real places, are met by a *single* global element. This does not follow from the chinese
remainder theorem and sign surjectivity separately, and Mathlib has no weak approximation
theorem for inequivalent absolute values at the pin, so it is a genuine target: prove
Artin–Whaples weak approximation for a finite set of places and read this off. Everything in
Layers 0 and 1 rests on it. -/
example (S : Finset (HeightOneSpectrum (𝓞 K))) (a : HeightOneSpectrum (𝓞 K) → K)
    (n : HeightOneSpectrum (𝓞 K) → ℕ) (T : Finset {w : InfinitePlace K // w.IsReal})
    (ε : {w : InfinitePlace K // w.IsReal} → ℤˣ) :
    ∃ x : K,
      (∀ v ∈ S, v.valuation K (x - a v) ≤
        ((Multiplicative.ofAdd (-(n v : ℤ)) : Multiplicative ℤ) :
          WithZero (Multiplicative ℤ))) ∧
        ∀ w ∈ T, (0 < InfinitePlace.embedding_of_isReal w.2 x ↔ ε w = 1) :=
  sorry

/-- **Layer 0, the ray class corollary of approximation.** The special case Layers 0 and 1
consume: one element congruent to a prescribed `a` modulo the modulus and of prescribed sign at
every real place. It is a corollary of the theorem above and is stated separately because it,
not the general statement, is what the moving lemma and the reduction map call. -/
example (𝔪 : Modulus K) (a : Kˣ) (ε : {w : InfinitePlace K // w.IsReal} → ℤˣ) :
    ∃ x : Kˣ, IsCongrOne 𝔪 (x * a⁻¹) ∧
      ∀ w : {w : InfinitePlace K // w.IsReal},
        (0 < InfinitePlace.embedding_of_isReal w.2 (x : K) ↔ ε w = 1) :=
  sorry

/-- **Layer 0, the reduction map, with its domain and its kernel.** Defined on the prime-to
subgroup, surjective by the approximation theorem, and with kernel exactly the congruence
subgroup: that last identity is the computational form of Layer 1's exact sequence, so it is
proved here rather than reproved there. The sign components are indexed by `𝔪∞` alone, since a
map to the signs at *all* real places would not have the congruence subgroup as its kernel. -/
example (𝔪 : Modulus K) :
    ∃ f : primeToSubgroup 𝔪 →* (𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ),
      Function.Surjective f ∧
        ∀ x : primeToSubgroup 𝔪, f x = 1 ↔ (x : Kˣ) ∈ congruenceSubgroup 𝔪 :=
  sorry

/-- **Layer 0, the sign map is a group homomorphism onto a product of two-element groups.**
The total sign map `Kˣ → Π_{w real} {±1}`, valued in `ℤˣ` rather than in `Bool`, since
Layer 1's exact sequence, Layer 3's parity dictionary and Layer 2C's `Art_ℝ` all have to land
in the same group. Its surjectivity is the archimedean case of the approximation theorem
above. ⚠ The corresponding map on *units* `(𝓞 K)ˣ` is not surjective in general (`ℚ(√3)`);
that failure is what `Cl⁺ ≠ Cl` measures in Layer 1. -/
example :
    ∃ σ : Kˣ →* ({w : InfinitePlace K // w.IsReal} → ℤˣ),
      (∀ (x : Kˣ) (w : {w : InfinitePlace K // w.IsReal}),
          σ x w = 1 ↔ 0 < InfinitePlace.embedding_of_isReal w.2 (x : K)) ∧
        Function.Surjective σ :=
  sorry

/-! ## Layer 1: ray class groups and the narrow class group -/

/-- **Layer 1, the ideals prime to the modulus.** Support disjointness is spelled through the
`v`-adic count of the factorization of a fractional ideal. -/
def idealsPrimeTo (𝔪 : Modulus K) : Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ where
  carrier := {I | ∀ v : HeightOneSpectrum (𝓞 K), v.asIdeal ∣ 𝔪.finitePart →
    FractionalIdeal.count K v (I : FractionalIdeal (𝓞 K)⁰ K) = 0}
  mul_mem' := by sorry
  one_mem' := by sorry
  inv_mem' := by sorry

/-- **Layer 1, the ray.** The principal ideals generated by elements congruent to `1` modulo
the modulus, as a subgroup of the ideals prime to it. Mathlib's `toPrincipalIdeal` is the map
`Kˣ →* (FractionalIdeal (𝓞 K)⁰ K)ˣ` that `ClassGroup` is already built from, so the ray class
group and the class group are quotients of the same objects and the comparison map of the next
milestone is available. -/
def ray (𝔪 : Modulus K) : Subgroup (idealsPrimeTo 𝔪) :=
  (((congruenceSubgroup 𝔪).map (toPrincipalIdeal (𝓞 K) K)).subgroupOf (idealsPrimeTo 𝔪))

/-- **Layer 1, the ray class group.** `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`. For the trivial modulus this
is `ClassGroup (𝓞 K)` by a named isomorphism, never by definitional accident. -/
def RayClassGroup (𝔪 : Modulus K) : Type u :=
  idealsPrimeTo 𝔪 ⧸ ray 𝔪

noncomputable instance (𝔪 : Modulus K) : CommGroup (RayClassGroup 𝔪) :=
  inferInstanceAs (CommGroup (idealsPrimeTo 𝔪 ⧸ ray 𝔪))

/-- **Layer 1, the units congruent to `1` modulo the modulus**, `𝓞_{K,𝔪}ˣ`: the global units
that lie in the congruence subgroup of `Kˣ`. It is a definition rather than a `sorry`, since
the carrier is a pullback and nothing has to be proved to write it down; its index in `𝓞_Kˣ` is
the unit obstruction, it is the left-hand term of the exact sequence below, and for the narrow
modulus it is the group of totally positive units. -/
def unitsCongruenceSubgroup (𝔪 : Modulus K) : Subgroup (𝓞 K)ˣ :=
  (congruenceSubgroup 𝔪).comap (Units.map (algebraMap (𝓞 K) K).toMonoidHom)

/-- **Layer 1, the moving lemma.** Every ideal class of a Dedekind domain contains an integral
ideal prime to a fixed nonzero ideal. Absent from Mathlib (only `ClassGroup.mk0_surjective`
exists); this is what both the surjectivity of `Cl_𝔫 ↠ Cl_𝔪` and the ideal-to-idele
dictionary turn on. Route: the chinese remainder theorem and approximation in the Dedekind
domain, not geometry of numbers; prove it at this generality, since the ray class group
versions specialize. -/
example (R : Type u) [CommRing R] [IsDedekindDomain R] (𝔪 : Ideal R) (h𝔪 : 𝔪 ≠ ⊥)
    (C : ClassGroup R) :
    ∃ I : (Ideal R)⁰, ClassGroup.mk0 I = C ∧ IsCoprime (I : Ideal R) 𝔪 :=
  sorry

/-- **Layer 1, the ray class group is finite, with its order.** The sharp form is the
cardinality formula `#Cl_𝔪 = h_K · #(𝓞 K ⧸ 𝔪₀)ˣ · 2^{#𝔪∞} / [𝓞_Kˣ : 𝓞_{K,𝔪}ˣ]`, written below
without division, and it is what the exact sequence gives. It is false at unrestricted Dedekind
generality, so it is stated for number fields. -/
example (𝔪 : Modulus K) :
    Finite (RayClassGroup 𝔪) ∧
      Nat.card (RayClassGroup 𝔪) * (unitsCongruenceSubgroup 𝔪).index =
        NumberField.classNumber K * Nat.card (𝓞 K ⧸ 𝔪.finitePart)ˣ * 2 ^ 𝔪.infinitePart.card :=
  sorry

/-- **Layer 1, the transition map.** In the pinned divisibility orientation the larger modulus
maps *onto* the smaller, and the surjectivity is the moving lemma. That the transition maps
compose in a tower is equally part of the Layer 1 milestone; stating it needs the map named
rather than existentially quantified, so it lives in `README.md` until the implementation
names it. -/
example (𝔪 𝔫 : Modulus K) (h : 𝔪 ∣ 𝔫) :
    ∃ f : RayClassGroup 𝔫 →* RayClassGroup 𝔪, Function.Surjective f :=
  sorry

/-- **Layer 1, the ray class exact sequence, with the kernel the textbook display hides.**
`1 → 𝓞_{K,𝔪}ˣ → 𝓞_Kˣ → (𝓞 K ⧸ 𝔪₀)ˣ × signs → Cl_𝔪 K → Cl K → 1`, stated as the three maps
together with exactness at each of the three interior spots. The image form and the cardinality
formula are derived from this, not the other way round. ⚠ The sequence is the reason `Cl_𝔪` is
*not* `(𝓞/𝔪₀)ˣ × signs × Cl`: global units glue the factors, and the size of the unit image is
a genuinely global quantity. -/
example (𝔪 : Modulus K) :
    ∃ (g : (𝓞 K)ˣ →* (𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ))
      (h : ((𝓞 K ⧸ 𝔪.finitePart)ˣ × (𝔪.infinitePart → ℤˣ)) →* RayClassGroup 𝔪)
      (f : RayClassGroup 𝔪 →* ClassGroup (𝓞 K)),
      g.ker = unitsCongruenceSubgroup 𝔪 ∧ g.range = h.ker ∧ h.range = f.ker ∧
        Function.Surjective f :=
  sorry

open scoped Classical in
/-- **Layer 1, the narrow class group.** The ray class group of the modulus with trivial finite
part and *all* real places. "Narrow" never means "totally positive units exist"; the degenerate
cases (no real places gives `Cl⁺ = Cl`) are instances, not separate definitions. -/
noncomputable def narrowModulus (K : Type u) [Field K] [NumberField K] : Modulus K where
  finitePart := ⊤
  finitePart_ne_bot := top_ne_bot
  infinitePart := Finset.univ

/-- **Layer 1, the narrow class group surjects onto the class group**, with kernel an
elementary abelian 2-group of order `2^{r₁}/[𝓞_Kˣ : 𝓞_Kˣ⁺]`. Both halves of that description
are in the statement: the kernel has exponent two, and its order times the index of the totally
positive units is `2^{r₁}`. The totally positive units are `unitsCongruenceSubgroup` of the
narrow modulus, which is what that subgroup unfolds to when the finite part is trivial and
every real place is in play. This spelling, together with `Cl⁺` itself, is what the
multiquadratic roadmap's Layer 3 names as a prerequisite: freeze it in coordination with any
implementor working there. -/
example : ∃ f : RayClassGroup (narrowModulus K) →* ClassGroup (𝓞 K),
    Function.Surjective f ∧ (∀ x ∈ f.ker, x ^ 2 = 1) ∧
      Nat.card f.ker * (unitsCongruenceSubgroup (narrowModulus K)).index =
        2 ^ NumberField.InfinitePlace.nrRealPlaces K :=
  sorry

/-- **Layer 1 and Layer 4 over `ℚ`, and the character that does not exist.** The ray class
group of `ℚ` for the modulus consisting of the infinite place alone is **trivial**: every
fractional ideal of `ℤ` has a unique positive generator. Hence `ℚ` has no nontrivial Hecke
character of conductor `∞`, and any roadmap or implementation that offers "the sign character
of `ℚ`" as an example is wrong. The companion computations are
`Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ` and `Cl_{(n)}(ℚ) ≃* (ZMod n)ˣ/{±1}`, whose contrast is the
unit-obstruction check. -/
example : Subsingleton (RayClassGroup (narrowModulus ℚ)) :=
  sorry

/-! ## Layer 2A: the idele class group -/

/-- **Layer 2A, `K` is discrete in its adeles.** One half of the fundamental local-global
finiteness package. Proved sorry-free in FLT (`NumberField.AdeleRing.discrete`); per the
roadmap's provenance section, coordinate with the FLT maintainers, the preferred outcome being
that their statement upstreams and this milestone becomes consume-and-cite. -/
example : DiscreteTopology (AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **Layer 2A, cocompactness.** The quotient `𝔸_K/K` is compact, the adelic form of Minkowski
finiteness. Also sorry-free in FLT (`NumberField.AdeleRing.cocompact`, by base change from
`ℚ`); same coordination note. The multiplicative sequel, compactness of the norm-one idele
class group `C_K^1`, is Fujisaki's lemma, stated in `README.md` Layer 2A and expressible here
once the idele norm exists (mathlib PR #36275 is in flight). -/
example : CompactSpace (AdeleRing (𝓞 K) K ⧸ AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **Layer 2A, the class group is an idele-class quotient.** The quotient of the finite ideles
by the everywhere-integral units and the principal ideles is the ideal class group (the map is
`x ↦ ∏_v v^{ord_v(x_v)}`, and the kernel analysis is the moving lemma). This is de
Frutos-Fernández's Lean 3 theorem restated in the pin's vocabulary, and the prototype of the
Layer 2A dictionary `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪` for a general modulus. ⚠ The unit condition
is stated through `adicCompletionIntegers`, not through `Valued.v`: the local roadmap's rule
that nothing new is stated against the deprecated `Valued` interface applies here too. -/
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

/-- **Layer 2A, the idele class group**, in the pin's vocabulary. Adopt the names and shapes of
mathlib PR #40735 the day they land; until then this quotient is what the statements below
mean by `C_K`, and it is reducible so that every `Units` and `QuotientGroup` lemma applies
without glue. -/
abbrev IdeleClassGroup (K : Type u) [Field K] [NumberField K] :=
  (AdeleRing (𝓞 K) K)ˣ ⧸ (Units.map (algebraMap K (AdeleRing (𝓞 K) K)).toMonoidHom).range

/-- **Layer 2A, principal units of a given level at a finite place**, `x ∈ 1 + 𝔭_v^n`. Stated
through the maximal ideal of `v.adicCompletionIntegers` rather than through `Valued.v`, per the
local roadmap's rule that nothing new is stated against the deprecated `Valued` interface. -/
def IsPrincipalUnitOfLevel (v : HeightOneSpectrum (𝓞 K)) (n : ℕ) (x : v.adicCompletion K) :
    Prop :=
  ∃ y : v.adicCompletionIntegers K, (y : v.adicCompletion K) = x - 1 ∧
    y ∈ (IsLocalRing.maximalIdeal (v.adicCompletionIntegers K)) ^ n

/-- **Layer 2A, the congruence subgroup of the ideles, `U_𝔪`.** One subgroup, used everywhere,
and its carrier is written out here because the carrier is the design decision: principal units
of level `ord_v 𝔪₀` at the finite places dividing `𝔪₀`, local integral units at the other
finite places, positivity at the real places of `𝔪∞`, and **no condition at all** at the
remaining infinite places. ⚠ Never append a second unnamed group of infinite components; they
are already here. -/
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

/-- **Layer 2A, the ray subgroup `RaySubgroup 𝔪 ≤ C_K`**, the image of `U_𝔪` in the idele class
group. Naming it is the point: the dictionary, the conductor of a character, the existence
theorem and the ray class fields all quantify over these subgroups, and an existential whose
carrier cannot be recovered from its type is useless to every one of them. -/
noncomputable def RaySubgroup (𝔪 : Modulus K) : Subgroup (IdeleClassGroup K) :=
  (IdeleCongruenceSubgroup 𝔪).map (QuotientGroup.mk' _)

/-- **Layer 2A, the ray class dictionary.** `U_𝔪` is open, and `C_K ⧸ RaySubgroup 𝔪 ≃* Cl_𝔪 K`
through the map `x ↦ ∏_{v ∤ 𝔪₀} v^{ord_v(x_v)}`, with the kernel computed by the moving lemma
and Layer 0's reduction map. Stated as the surjection together with its kernel rather than as
an abstract isomorphism of the quotient, since the map itself is what Layers 3, 6 and 7 use. -/
example (𝔪 : Modulus K) :
    IsOpen (IdeleCongruenceSubgroup 𝔪 : Set (AdeleRing (𝓞 K) K)ˣ) ∧
      ∃ f : IdeleClassGroup K →* RayClassGroup 𝔪,
        Function.Surjective f ∧ f.ker = RaySubgroup 𝔪 :=
  sorry

/-- **Layer 2A, compatibility with the transition maps.** In the pinned divisibility
orientation the larger modulus gives the smaller subgroup, and the induced surjections
`C_K ⧸ RaySubgroup 𝔫 ↠ C_K ⧸ RaySubgroup 𝔪` match the Layer 1 transition maps
`Cl_𝔫 ↠ Cl_𝔪` under the dictionary. Layer 7's inverse limit is exactly this compatibility. -/
example (𝔪 𝔫 : Modulus K) (h : 𝔪 ∣ 𝔫) : RaySubgroup 𝔫 ≤ RaySubgroup 𝔪 :=
  sorry

/-! ## Layer 2B: ideles in a finite extension

The Galois action on `𝔸_L`, the extension map, the idele norm with its local component
formula, and the invariant comparison `C_L^G ≃ C_K` are `README.md`-only: stating them needs
the base-change algebra structure on adele rings, which the pin does not have (FLT has it, and
coordination is the plan). The one statement that is expressible today is the local dictionary
they all cross, and it belongs to the Number Field Arithmetic roadmap. -/

/-- **Layer 2B, the local dictionary, consumed rather than proved here.** The completion of a
number field at a finite place is a nonarchimedean local field: the statement through which
every consumption of the LocalFields roadmap (local Artin maps, local conductors, local norms)
enters. The compatible `ValuativeRel`/`IsValuativeTopology` instances are hypothesized because
*producing* them from the pin's `Valued` instance on `adicCompletion`, without stating anything
new against `Valued`, is part of the milestone. The Number Field Arithmetic roadmap owns the
global-to-local dictionary: stated in both, proved once, there. -/
example (v : HeightOneSpectrum (𝓞 K))
    [ValuativeRel (v.adicCompletion K)] [IsValuativeTopology (v.adicCompletion K)] :
    IsNonarchimedeanLocalField (v.adicCompletion K) :=
  sorry

/-! ## Layer 2C: the archimedean local package

The local-fields roadmap is nonarchimedean by design, so the real and complex local class field
theory is built here. It is elementary, entirely expressible at the pin, and used by every
layer from 5 onwards. -/

/-- **Layer 2C, the real reciprocity map.** `Art_ℝ : ℝˣ → Gal(ℂ/ℝ)` sends positive elements to
`1` and negative elements to complex conjugation. Surjectivity and the kernel are the content;
the kernel statement is the archimedean local reciprocity isomorphism, in the same shape as the
local roadmap's nonarchimedean one. The complex case is the trivial map, and saying so
explicitly keeps the two places uniform in Layer 6's product over all places. -/
example :
    ∃ f : ℝˣ →* (ℂ ≃ₐ[ℝ] ℂ),
      Function.Surjective f ∧ ∀ x : ℝˣ, f x = 1 ↔ 0 < (x : ℝ) :=
  sorry

/-- **Layer 2C, the archimedean norm group.** `N_{ℂ/ℝ}(ℂˣ) = ℝ_{>0}`, so `ℝˣ/N(ℂˣ)` has order
two and matches `Gal(ℂ/ℝ)`. With the previous statement this is the archimedean case of local
reciprocity, and it is also the real-place clause of the conductor: a real place is unramified
in `L` exactly when the local norm group there is all of `ℝˣ`. -/
example (x : ℝ) : (∃ z : ℂ, z ≠ 0 ∧ Algebra.norm ℝ z = x) ↔ 0 < x :=
  sorry

/-- **Layer 2C, the archimedean Herbrand quotient.** `#Ĥ⁰(Gal(ℂ/ℝ), ℂˣ) = 2` and
`H¹(Gal(ℂ/ℝ), ℂˣ) = 1`, so `h(Gal(ℂ/ℝ), ℂˣ) = 2 = [ℂ:ℝ]`. Stated here as the norm-index form,
which is how Layer 5 consumes it: the archimedean factors carry as much weight in the global
Herbrand computation as the nonarchimedean ones. -/
example :
    ∃ N : Subgroup ℝˣ,
      (∀ x : ℝˣ, x ∈ N ↔ 0 < (x : ℝ)) ∧ Nat.card (ℝˣ ⧸ N) = 2 :=
  sorry

/-- **Layer 2C, the real Hilbert symbol.** `(a,b)_ℝ = −1` exactly when both `a` and `b` are
negative, and `(a,b)_ℂ = 1` always. Stated through the conic, since the Hilbert symbol itself
is the local roadmap's object and does not exist at the pin. Layer 11's product formula ranges
over all places at once, so these two values are what closes it at infinity. -/
example (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    (∃ x y z : ℝ, (x, y, z) ≠ (0, 0, 0) ∧ z ^ 2 = a * x ^ 2 + b * y ^ 2) ↔ ¬(a < 0 ∧ b < 0) :=
  sorry

/-! ## Layer 3: Hecke characters -/

/-- **Layer 3, the finite-order dichotomy.** A continuous character of the idele class group
(the quotient here is the pin-vocabulary spelling of `IdeleClassGroup` from mathlib PR #40735;
keep the shapes aligned) has finite order if and only if its kernel is open. With the Layer 2A
open-subgroup lemma this becomes: the finite-order Hecke characters are exactly the ray class
characters, and over `ℚ` exactly the Dirichlet characters. ⚠ The backward direction uses
compactness of `π₀(C_K)` (Fujisaki, Layer 2A); it is not formal. -/
example (χ : ContinuousMonoidHom (IdeleClassGroup K) ℂˣ) :
    (∃ n : ℕ, 0 < n ∧ ∀ y, χ y ^ n = 1) ↔ IsOpen {y | χ y = 1} :=
  sorry

open scoped Classical in
/-- **The modulus `(n)·∞` of `ℚ`**, which Layers 3, 4, 7 and 9 all evaluate at. -/
noncomputable def ratModulus (n : ℕ) (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) :
    Modulus ℚ where
  finitePart := Ideal.span {(n : 𝓞 ℚ)}
  finitePart_ne_bot := h
  infinitePart := Finset.univ

/-- **Layer 3 and Layer 4 over `ℚ`, the ray class group of `(n)·∞`.** `Cl_{(n)∞}(ℚ) ≃* (ℤ/n)ˣ`,
which is what makes the dictionary between finite-order Hecke characters of `ℚ` with
`U_{(n)∞} ⊆ ker χ` and `DirichletCharacter ℂ n` an equivalence. The dictionary must carry the
parity clause: evaluating the product formula at the principal idele `−1` shows that the finite
components and the real sign component are not independent, and that the real component is
nontrivial exactly when the Dirichlet character is odd, so the infinite place lies in the ray
conductor exactly for odd characters. The smallest instance is `ZMod.χ₄`: finite conductor `4`,
ray conductor `(4)·∞`. Dropping the infinite place gives `Cl_{(n)}(ℚ) ≃* (ℤ/n)ˣ/{±1}`, the
unit-obstruction contrast. -/
example (n : ℕ) [NeZero n] (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) :
    Nonempty (RayClassGroup (ratModulus n h) ≃* (ZMod n)ˣ) :=
  sorry

/-! ## Layer 4: the cyclotomic anchor -/

/-- **Layer 4, the splitting law in `ℚ(ζₙ)`.** A prime `p ∤ n` splits completely in the `n`-th
cyclotomic field iff `p ≡ 1 (mod n)`: the composite of the pin's
`IsCyclotomicExtension.Rat.galEquivZMod_stabilizer` (the decomposition group at `p` is `⟨[p]⟩`)
with the splits-completely dictionary. The count is spelled with `Set.ncard`, which is the
Number Field Arithmetic roadmap's pinned convention; do not introduce a second spelling. -/
example (n p : ℕ) [NeZero n] [Fact p.Prime] (hpn : ¬ p ∣ n) :
    (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 (CyclotomicField n ℚ))).ncard
        = Module.finrank ℚ (CyclotomicField n ℚ) ↔ p ≡ 1 [MOD n] :=
  sorry

/-- **Layer 4, ramification at the conductor-normalized level.** With `n₀ = n/2` for
`n ≡ 2 (mod 4)` and `n₀ = n` otherwise, the finite primes ramifying in `ℚ(ζₙ)` are exactly
those dividing `n₀`, provided `n₀ ≥ 3` (for `n₀ ≤ 2` the field is `ℚ`). ⚠ "Ramified exactly at
the `p ∣ n`" is false: `ℚ(ζ₆) = ℚ(ζ₃)` is unramified at `2`. The `(ζ − 1)`-generates-the-prime
theorem holds for prime-power level only; at general level, write `n = p^a m` with `p ∤ m` and
consume the `e` and `f` formulas of `NumberField/Cyclotomic/Ideal.lean`. -/
example (n : ℕ) (hn : 3 ≤ n) (hn4 : ¬ (n % 4 = 2)) (p : ℕ) [Fact p.Prime] :
    (∃ P ∈ Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 (CyclotomicField n ℚ)),
        1 < Ideal.ramificationIdx (Ideal.span {(p : ℤ)}) P) ↔ p ∣ n :=
  sorry

/-- **Layer 4, Artin reciprocity for `(ℚ, ℚ(ζₙ))`, which is the part of the anchor this roadmap
owns.** The ray class group of the modulus `(n)·∞` is isomorphic to `Gal(ℚ(ζₙ)/ℚ)` by a map
sending the class of `(p)`, for `p` prime to `n`, to the automorphism that `galEquivZMod`
carries to `[p]`. That this automorphism is the *arithmetic* Frobenius at `p`, meaning
`σ x ≡ x^p mod P` on integers, is the Number Field Arithmetic roadmap's theorem: it is consumed
here through the right-hand side below and deliberately not restated as a target, so that the
`arithFrobAt`/`galEquivZMod` bridge has a single proof owner. ⚠ The orientation is what makes
this the normalization anchor rather than the splitting law: the geometric convention would put
`[p]⁻¹` on the right, and both conventions compose with `galEquivZMod` to give an automorphism
of `(ℤ/n)ˣ`, so an error here survives degree-counting tests. -/
example (n : ℕ) [NeZero n] (h : (Ideal.span {(n : 𝓞 ℚ)} : Ideal (𝓞 ℚ)) ≠ ⊥) (F : Type u)
    [Field F] [NumberField F] [IsCyclotomicExtension {n} ℚ F] :
    ∃ θ : RayClassGroup (ratModulus n h) ≃* Gal(F/ℚ),
      ∀ (p : ℕ) (hp : p.Coprime n) (u : ℚˣ), (u : ℚ) = p →
        ∀ hu : toPrincipalIdeal (𝓞 ℚ) ℚ u ∈ idealsPrimeTo (ratModulus n h),
          IsCyclotomicExtension.Rat.galEquivZMod n F
              (θ (QuotientGroup.mk ⟨toPrincipalIdeal (𝓞 ℚ) ℚ u, hu⟩))
            = ZMod.unitOfCoprime p hp :=
  sorry

/-! ## Layer 10A: continuous characters of the archimedean groups

The classification below underlies the infinity type of a Hecke character, and it is worth
having for its own sake: Mathlib has neither statement. The infinity type itself, the
algebraicity condition, and the two conductors of Layer 3 are `README.md`-only, since stating
them needs the Layer 2A and Layer 3 objects. -/

/-- **Layer 10A, the continuous characters of `ℝˣ`.** Every one is `x ↦ |x|^s` times a power of
the sign, for a **unique** exponent `s : ℂ` and parity. The parity is typed as `ZMod 2` and not
as a natural number, because only its class modulo two is determined and a `ℕ`-valued statement
cannot be a uniqueness statement at all. -/
example (χ : ContinuousMonoidHom ℝˣ ℂˣ) :
    ∃! p : ℂ × ZMod 2, ∀ x : ℝˣ,
      (χ x : ℂ) = (‖(x : ℝ)‖ : ℂ) ^ p.1 * (if 0 < (x : ℝ) then 1 else (-1) ^ p.2.val) :=
  sorry

/-- **Layer 10A, the continuous characters of `ℂˣ`.** Every one is `z ↦ (z/|z|)^k · |z|^s` for a
**unique** pair `(k, s) : ℤ × ℂ`, equivalently `z ↦ z^p z̄^q` with `p − q ∈ ℤ`, the translation
being `k = p − q` and `s = p + q`. Uniqueness is proved by restricting to the unit circle,
which pins `k`, and to `ℝ_{>0}`, which pins `s`. ⚠ At a complex place an algebraic infinity
type therefore has *two* integer exponents and its radial exponent `s = p + q` need not vanish:
"type `A₀` means all radial exponents are zero" is not the algebraicity condition, and it would
exclude the algebraic norm twists. -/
example (χ : ContinuousMonoidHom ℂˣ ℂˣ) :
    ∃! p : ℤ × ℂ, ∀ z : ℂˣ,
      (χ z : ℂ) = ((z : ℂ) / (‖(z : ℂ)‖ : ℂ)) ^ p.1 * (‖(z : ℂ)‖ : ℂ) ^ p.2 :=
  sorry

/-! ## Layers 8 to 10: acceptance shapes (pin-expressible worked examples)

The Hilbert class field, the principal ideal theorem, the existence theorem, and the
conductor–discriminant formula are `README.md`-only until the Layer 1 to 7 objects exist in
`TauCeti/`. Four of their concrete consequences are stateable today and serve as end-to-end
acceptance targets. -/

/-- **Layer 10C acceptance, `x² + 5y²`.** For a prime `p ∉ {2, 5}`: `p = x² + 5y²` iff
`p ≡ 1, 9 (mod 20)`. The congruence equivalence alone is elementary and does not test this
roadmap; what tests it is the middle term, that `p` splits completely in the Hilbert class
field `H = ℚ(√−5, i)` of `K = ℚ(√−5)` (class number 2). `H` is also the genus field of `K`, so
this is the Multiquadratic-interface instance and the two roadmaps must prove compatible
statements. -/
example (p : ℕ) (hp : p.Prime) (h2 : p ≠ 2) (h5 : p ≠ 5) :
    (∃ x y : ℤ, (p : ℤ) = x ^ 2 + 5 * y ^ 2) ↔ (p % 20 = 1 ∨ p % 20 = 9) :=
  sorry

/-- **Layer 10C acceptance, `x² + 27y²`, the nonmaximal-order instance.** Gauss's criterion:
for `p ≠ 2, 3`, `p = x² + 27y²` iff `p ≡ 1 (mod 3)` and `2` is a cubic residue modulo `p`. The
class field content is that both sides say `p` splits completely in `ℚ(√−3, ∛2)`, the ring
class field of the order `ℤ[√−27] = ℤ + 6𝓞_K` of discriminant `−108` and conductor `6` in
`ℚ(√−3)`, whose Picard group is `ℤ/3`. This is the example that exercises Layer 10B: the order
is not maximal, so the Dedekind-generic machinery of Layers 0 and 1 does not apply to it. -/
example (p : ℕ) (hp : p.Prime) (h2 : p ≠ 2) (h3 : p ≠ 3) :
    (∃ x y : ℤ, (p : ℤ) = x ^ 2 + 27 * y ^ 2) ↔
      (p % 3 = 1 ∧ ∃ x : ZMod p, x ^ 3 = 2) :=
  sorry

/-- **Layer 9 acceptance, Kronecker–Weber.** Every abelian extension of `ℚ` embeds in a
cyclotomic field. The statement form is aligned with mathlib PR #40661's `theorem_wanted`
(`IsAbelianGalois.le_cyclotomicField`); the sharp form, that the least such `n` is the finite
part of the conductor and is never `≡ 2 (mod 4)`, is the Layer 9 milestone proper. Route: this
is a corollary of the Layer 7 computation that the ray class field of `ℚ` for `(n)·∞` is
`ℚ(ζₙ)`; do not build the elementary ramification-theoretic proof as a prerequisite. -/
example (L : Type u) [Field L] [NumberField L] [IsAbelianGalois ℚ L] :
    ∃ n : ℕ, n ≠ 0 ∧ Nonempty (L →ₐ[ℚ] CyclotomicField n ℚ) :=
  sorry

/-- **Layer 9 acceptance, the smallest conductor computation.** `√5 ∈ ℚ(ζ₅)`: the quadratic
field of discriminant `5` lies in the fifth cyclotomic field, so the least cyclotomic level of
`ℚ(√5)` is its conductor `5`. The companion inclusions `ℚ(i) ⊆ ℚ(ζ₄)` and `ℚ(√2) ⊆ ℚ(ζ₈)` pin
the levels `4` and `8`, and the conductor of `ℚ(√d)` is `(|d_K|)` for `d > 0` and `(|d_K|)·∞`
for `d < 0`: an implementation that puts no infinite place in the conductor of `ℚ(i)` has the
real-place convention backwards. -/
example : ∃ x : CyclotomicField 5 ℚ, x ^ 2 = 5 :=
  sorry

end TauCetiRoadmap.GlobalClassFieldTheory
