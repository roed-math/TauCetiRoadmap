import Mathlib
import TauCetiRoadmap.ProfiniteCohomology.Suggested

/-!
# Local fields, ramification, and local class field theory: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–9, the pinned conventions, the worked examples, and the
references) is in `README.md`. Mathlib has the class `IsNonarchimedeanLocalField` on the
`ValuativeRel` framework, but essentially none of the arithmetic of local fields: no unit
filtration, no unramified/Frobenius theory, no higher ramification, no tame quotient, no
local class field theory, no duality. We build that in `TauCeti/`.

This file holds targets from Layers 0 to 2, the worked examples that reach into the
acceptance criteria of Layers 7 to 9, and the cross-roadmap statements below. Power classes and
Layer 8 are split into the two regimes of the roadmap's standing hypotheses. `p`-power
coefficients in equal characteristic are outside the roadmap, and no statement here is to be
generalized to cover them. The same boundary cuts Layer 7: the existence theorem is a
milestone away from the residue characteristic for a general local field, and in full only
for `K` a finite extension of `ℚ_p`. So anything derived from full existence, such as
injectivity of the Artin map or the ordinary profinite completion of `Kˣ`, is
mixed-characteristic.

Definitions with a `sorry` body (`normalizedValuation`, `ramificationIndex`,
`inertiaDegree`, `teichmuller`, `unitFiltration`, `frobeniusAlgEquiv`, `muNRep`, `tateDual`,
`unitsRep`, `invMap`, `brRes`, `brCor`, `normResidue`, `artinMap`, `unramifiedCoordinate`,
`kummerCupPairing`, `tateEvaluationPairing`, `tateH`, `tateCup`, `tateMap`) are suggested
*names and types* for objects **this roadmap** builds, together with the characteristic lemmas
that fix them. They are placeholders for data whose type is expressible now, and never for a
condition we cannot state. `absoluteRamificationIndex`, `normGroup`, `conductorExponent`,
`conductorIdeal` and `characterConductorExp` carry real bodies instead; what they owe is the
laws stated beside them.

## The cohomology of a profinite group comes from one supplier

Continuous cohomology, its functoriality, its cup product, corestriction, Shapiro, the
finite-quotient colimit, and Kummer theory over a general field are the accepted Profinite
Cohomology roadmap's, and this file imports
`TauCetiRoadmap.ProfiniteCohomology.Suggested` and cites its declarations by name. There is no
second carrier and no second cup product here: `GalRep` and `H` below are abbreviations of
`ProfiniteCohomology.TopRep` and of Mathlib's `continuousCohomology`, and every product is
`ProfiniteCohomology.cup` applied to a `ProfiniteCohomology.TopPairing` that this roadmap
constructs.

The two arithmetic pairings are named objects of this roadmap, `kummerCupPairing` and
`tateEvaluationPairing`, and never arguments of the theorems that use them: a `TopPairing`
carries bilinearity, joint continuity, and Galois equivariance in its fields, so a named term is
what makes the symbol and the duality statements say something about the arithmetic pairing
rather than about every family of maps of the same type.

## Operations that this roadmap does not own

Namespace `Supplied` collects the group theory of pro-`p` groups. Its predicates and carriers are
definitions, with the bodies that the supplying development gives them, so the two are
definitionally equal and a statement here transports to the supplier's name by `rfl`. Its
theorems are the fields of `ProPOps` and `ProPRankInputs`; the supplier constructs the canonical
terms `Supplied.proPOps` and `Supplied.proPRankInputs`, and the rank theorem of Layer 9 is stated
unconditionally by instantiation at them.
-/

namespace TauCetiRoadmap.LocalFields

open ValuativeRel
open scoped WithZero

universe u v

variable (K : Type u) [Field K] [ValuativeRel K] [TopologicalSpace K]
  [IsNonarchimedeanLocalField K]
variable (L : Type v) [Field L] [ValuativeRel L] [TopologicalSpace L]
  [IsNonarchimedeanLocalField L]

/-! ## Layer 0: local fields and their finite extensions -/

/-- **Layer 0, non-vacuity: `ℚ_p` is a nonarchimedean local field.** The pin has
`ValuativeRel ℚ_[p]` (via `Padic.mulValuation`) but neither `IsValuativeTopology ℚ_[p]` nor
this instance; producing them, with the metric/valuative uniformity compatibility as a
lemma rather than an accident, is the first milestone. The milestone is the general `p`;
`p = 2` is the case every downstream consumer of this roadmap uses. -/
example (p : ℕ) [Fact p.Prime] : IsNonarchimedeanLocalField ℚ_[p] :=
  sorry

/-- **Layer 0, the normalized valuation.** The valuation of a local field, written
additively but encoded as a homomorphism to `Multiplicative ℤ`. This is `WithZero.log` of
Mathlib's canonical valuation transported along `valueGroupWithZeroIsoInt`. ⚠ Sign trap:
Mathlib's multiplicative convention has `valuation K π = exp (−1) < 1` on uniformizers, so
the additive normalization carries a minus sign; keep that translation in one named lemma. -/
noncomputable def normalizedValuation : Kˣ →* Multiplicative ℤ :=
  sorry

/-- **Layer 0.** The normalized valuation is surjective: the value group is all of `ℤ`. -/
theorem normalizedValuation_surjective : Function.Surjective (normalizedValuation K) :=
  sorry

/-- **Layer 0.** `v_K^×(x) = 1` says the additive value is `0`, that is, `x` is a unit of
`𝒪[K]`. This is the equation reserved for the kernel condition; the uniformizer equation is
the next lemma, and the two must not be conflated. -/
theorem normalizedValuation_eq_one_iff (x : Kˣ) :
    normalizedValuation K x = 1 ↔ valuation K (x : K) = 1 :=
  sorry

/-- **Layer 0.** For a uniformizer the Lean-facing equation is
`v_K^×(π) = Multiplicative.ofAdd 1`, equivalently `v_K(π) = 1` after decoding with
`Multiplicative.toAdd`. -/
theorem normalizedValuation_irreducible (π : 𝒪[K]) (_hπ : Irreducible π) (hπ0 : (π : K) ≠ 0) :
    normalizedValuation K (Units.mk0 (π : K) hπ0) = Multiplicative.ofAdd 1 :=
  sorry

/-- **Layer 0, uniformizers generate the value group.** Any irreducible element of the
(discrete valuation) ring `𝒪[K]` has valuation a generator: every nonzero value is an
integer power of it. -/
example (π : 𝒪[K]) (_hπ : Irreducible π) :
    ∀ γ : (ValueGroupWithZero K)ˣ,
      ∃ n : ℤ, (γ : ValueGroupWithZero K) = valuation K (π : K) ^ n :=
  sorry

/-- **Layer 0.I, constructing the valuation on a finite extension.** For an abstract finite
extension `M/K` with *no* valuative structure assumed on `M`, there is a valuation on `M`,
with values in `ℤᵐ⁰`, restricting to the valuation class of `K`. This is the milestone the
spectral norm and `RingTheory/Valuation/Extension.lean` are for, and it is what makes the
`ValuativeRel M` instance of the next milestones exist at all; it is *not* prototyped by any
statement that hypothesizes that instance. -/
example (M : Type v) [Field M] [Algebra K M] [Module.Finite K M] :
    ∃ w : Valuation M ℤᵐ⁰, (w.comap (algebraMap K M)).IsEquiv (valuation K) :=
  sorry

/-- **Layer 0.II, uniqueness.** Any two valuations on a finite extension `M/K` restricting to
the valuation class of `K` are equivalent. (Completeness of `K` is what makes this true, and
it is part of `IsNonarchimedeanLocalField K`.) -/
example (M : Type v) [Field M] [Algebra K M] [Module.Finite K M]
    {Γ₁ Γ₂ : Type*} [LinearOrderedCommGroupWithZero Γ₁] [LinearOrderedCommGroupWithZero Γ₂]
    (w₁ : Valuation M Γ₁) (w₂ : Valuation M Γ₂)
    (_h₁ : (w₁.comap (algebraMap K M)).IsEquiv (valuation K))
    (_h₂ : (w₂.comap (algebraMap K M)).IsEquiv (valuation K)) :
    w₁.IsEquiv w₂ :=
  sorry

/-- **Layer 0.II, corollary: Galois invariance of the valuation.** Every `K`-algebra
automorphism of a finite extension `L/K` of local fields preserves the canonical valuation.
This is what makes `Gal(L/K)` act on `𝒪[L]`, `𝓂[L]`, and the residue field, and Layers 2
and 3 use it constantly. -/
example [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    (σ : L ≃ₐ[K] L) (x : L) :
    valuation L (σ x) = valuation L x :=
  sorry

/-- **Layer 0.III, consequences.** Once the compatible valuation class and the valuative
topology are in place, a finite extension of a nonarchimedean local field is a nonarchimedean
local field. ⚠ This statement hypothesizes the structure, so it prototypes step III only;
steps I and II are the two milestones above. -/
example (M : Type v) [Field M] [ValuativeRel M] [TopologicalSpace M]
    [IsValuativeTopology M] [Algebra K M] [ValuativeExtension K M]
    [Module.Finite K M] :
    IsNonarchimedeanLocalField M :=
  sorry

/-- **Layer 0, the ramification index**, defined without choosing a uniformizer: the positive
integer by which the map of normalized value groups multiplies. Its characteristic property
is `normalizedValuation_algebraMap` below. -/
noncomputable def ramificationIndex [Algebra K L] [ValuativeExtension K L] [Module.Finite K L] :
    ℕ :=
  sorry

/-- **Layer 0, the residue degree.** Once Layer 0.III supplies `Algebra 𝓀[K] 𝓀[L]` this is
`Module.finrank 𝓀[K] 𝓀[L]`; that algebra instance does not exist at the pin, so the
definition is stated here by name and pinned down by `card_residueField` below. -/
noncomputable def inertiaDegree [Algebra K L] [ValuativeExtension K L] [Module.Finite K L] :
    ℕ :=
  sorry

/-- **Layer 0, the characteristic property of `e`.** The normalized valuation of `L`
restricted along `K` is the `e`-th power of that of `K`. Stated for all `x`, so no uniformizer
is chosen; specializing to a uniformizer of `K` gives `v_L(π_K) = e`. -/
theorem normalizedValuation_algebraMap [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] (x : Kˣ) :
    normalizedValuation L (Units.map (algebraMap K L : K →+* L).toMonoidHom x)
      = normalizedValuation K x ^ ramificationIndex K L :=
  sorry

/-- **Layer 0, the characteristic property of `f`.** -/
theorem card_residueField [Algebra K L] [ValuativeExtension K L] [Module.Finite K L] :
    Nat.card 𝓀[L] = Nat.card 𝓀[K] ^ inertiaDegree K L :=
  sorry

/-- **Layer 0, `e · f = n`.** With positivity of both factors, and multiplicativity in towers,
this is the fundamental identity of the layer. The reconciliation with the Dedekind-level
`Ideal.ramificationIdx`/`Ideal.inertiaDeg` (at a local field `𝓂[K]` has the single prime
`𝓂[L]` above it) is a separate named milestone. -/
theorem ramificationIndex_mul_inertiaDegree [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] :
    ramificationIndex K L * inertiaDegree K L = Module.finrank K L :=
  sorry

open Classical in
/-- **Layer 0, the absolute ramification index** `e_K(p) = v_K(p)`, the decoded normalized
valuation of the image of the natural number `p` in `K`. For `p` prime and `K/ℚ_p` finite it is
`ramificationIndex ℚ_[p] K`, and it is `0` exactly when `p` is a unit of `𝒪[K]`, that is when `p`
is not the residue characteristic. ⚠ In equal characteristic `p` the image of `p` in `K` is `0`
and there is no such invariant. That branch takes the junk value `0`, in the manner of
`Ideal.ramificationIdx`, so every statement below carries `(p : K) ≠ 0`; the hypothesis is what
separates the two cases, and it is not a convenience. -/
noncomputable def absoluteRamificationIndex (p : ℕ) : ℕ :=
  if h : (p : K) = 0 then 0
  else (Multiplicative.toAdd (normalizedValuation K (Units.mk0 (p : K) h))).toNat

/-- **Layer 0, the characteristic property of the absolute ramification index.** Its value is a
natural number, so the equation also carries the assertion that `p` lies in `𝒪[K]`. -/
theorem normalizedValuation_natCast (p : ℕ) (hp : (p : K) ≠ 0) :
    normalizedValuation K (Units.mk0 (p : K) hp)
      = Multiplicative.ofAdd (absoluteRamificationIndex K p : ℤ) :=
  sorry

/-- **Layer 0, the vanishing criterion.** `e_K(p) = 0` exactly when `p` is invertible in the
valuation ring, which for `p` prime says that `p` is not the residue characteristic. -/
theorem absoluteRamificationIndex_eq_zero_iff (p : ℕ) (_hp : (p : K) ≠ 0) :
    absoluteRamificationIndex K p = 0 ↔ IsUnit (p : ↥𝒪[K]) :=
  sorry

/-! ## Layer 1: units, the filtration, and the multiplicative group -/

/-- **Layer 1, the unit filtration** as an object: `U(K,0) = 𝒪[K]ˣ` and
`U(K,i) = 1 + 𝓂[K]^i` for `i ≥ 1`, a decreasing family of open compact subgroups of `Kˣ`
indexed by `ℕ`. The depth-zero branch is part of the definition, not a special case bolted on
afterwards. -/
def unitFiltration (i : ℕ) : Subgroup Kˣ :=
  sorry

/-- **Layer 1, membership at depth `0`:** the units of `𝒪[K]` inside `Kˣ`. -/
theorem mem_unitFiltration_zero (x : Kˣ) :
    x ∈ unitFiltration K 0 ↔ valuation K (x : K) = 1 :=
  sorry

/-- **Layer 1, membership at positive depth, congruence form:** `x ≡ 1 mod 𝓂[K]^i` for a unit
`x` of `𝒪[K]`. -/
theorem mem_unitFiltration_succ_congr (i : ℕ) (u : (↥𝒪[K])ˣ) :
    Units.map (Subring.subtype 𝒪[K]).toMonoidHom u ∈ unitFiltration K (i + 1) ↔
      (u : ↥𝒪[K]) - 1 ∈ 𝓂[K] ^ (i + 1) :=
  sorry

/-- **Layer 1, membership at positive depth, valuation form:** an inequality on `x − 1`,
measured against a uniformizer. Both forms get used; they are proved equivalent once. -/
theorem mem_unitFiltration_succ_valuation (i : ℕ) (x : Kˣ) (π : 𝒪[K]) (_hπ : Irreducible π) :
    x ∈ unitFiltration K (i + 1) ↔
      valuation K ((x : K) - 1) ≤ valuation K ((π : K) ^ (i + 1)) :=
  sorry

/-- **Layer 1, the filtration is decreasing.** -/
theorem unitFiltration_antitone : Antitone (unitFiltration K) :=
  sorry

/-- **Layer 1, the filtration separates points**, which with openness makes it a neighborhood
basis of `1` in `Kˣ`. -/
theorem iInf_unitFiltration : ⨅ i, unitFiltration K i = ⊥ :=
  sorry

/-- **Layer 1, reduction is surjective on units**, the depth-`0` graded piece
`𝒪[K]ˣ ↠ 𝓀[K]ˣ` of the unit filtration, whose kernel is `U(K,1)`. The deeper pieces
`U(K,i)/U(K,i+1) ≅ 𝓀[K]⁺` are stated once the quotient API is in `TauCeti/`. -/
example :
    Function.Surjective
      (Units.map (IsLocalRing.residue 𝒪[K]).toMonoidHom : (↥𝒪[K])ˣ →* (𝓀[K])ˣ) :=
  sorry

/-- **Layer 1, the Teichmüller section**: the canonical multiplicative section of reduction,
characterized by `teichmuller_section` below together with the uniqueness statement that its
image is the `(q−1)`-torsion of `𝒪[K]ˣ`, that is `μ_{q−1}(K)`. Whether the construction goes
through `Perfection.teichmuller₀` or through Hensel applied to `X^(q−1) − 1` is an
implementation note. -/
noncomputable def teichmuller : (𝓀[K])ˣ →* (↥𝒪[K])ˣ :=
  sorry

/-- **Layer 1.** The Teichmüller map is a section of reduction. -/
theorem teichmuller_section (x : (𝓀[K])ˣ) :
    Units.map (IsLocalRing.residue 𝒪[K]).toMonoidHom (teichmuller K x) = x :=
  sorry

/-- **Layer 1, the multiplicative decomposition.** A choice of uniformizer splits
`Kˣ ≅ ℤ × 𝒪[K]ˣ`: every element of `Kˣ` is uniquely `π^n · u` with `u ∈ 𝒪[K]ˣ`. (With the
Teichmüller milestone this refines to `Kˣ ≅ π^ℤ × μ_{q−1} × U(K,1)`, and `U(K,1)` is pro-`p`,
in the quotient form that `Supplied.IsProP` unfolds to.) -/
example (π : 𝒪[K]) (_hπ : Irreducible π) (x : Kˣ) :
    ∃! p : ℤ × (↥𝒪[K])ˣ, (x : K) = (π : K) ^ p.1 * ((p.2 : ↥𝒪[K]) : K) :=
  sorry

/-- **Layer 1, power classes in the prime-to-residue-characteristic regime.** If `n` is a unit
in the valuation ring, the count is exact and holds in either characteristic: the factor
`q ^ v_K(n)` of the general formula is `1`, which is where the hypothesis is used. -/
theorem card_powerClasses_of_isUnit (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Nat.card (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range)
      = n * Nat.card (rootsOfUnity n K) :=
  sorry

/-- **Layer 1, power classes in the mixed-characteristic regime.** For `K/ℚ_p` finite the same
formula holds for every `n ≠ 0`, including `p ∣ n`, with the extra factor
`q ^ v_K(n) = ‖n‖_K⁻¹` written here as the (finite) cardinality of `𝒪[K]/n𝒪[K]`, which avoids
an integer-to-natural coercion. ⚠ This must not be generalized to equal characteristic: at
`K = 𝔽_q((t))` and `n = p` the left-hand side is infinite. -/
theorem card_powerClasses_mixed (p : ℕ) [Fact p.Prime] [Algebra ℚ_[p] K] [Module.Finite ℚ_[p] K]
    (n : ℕ) (_hn : n ≠ 0) :
    Nat.card (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range)
      = n * Nat.card (rootsOfUnity n K)
        * Nat.card (↥𝒪[K] ⧸ Ideal.span {(n : ↥𝒪[K])}) :=
  sorry

/-- **Layer 1, the square classes away from residue characteristic `2`.** The specialization of
`card_powerClasses_of_isUnit` at `n = 2`: the hypothesis makes `2` invertible in `𝒪[K]`, hence
in `K`, so `μ_2(K) = {±1}` has order `2` and the count is `2 · 2 · 1`. -/
theorem card_squareClasses_of_isUnit (_h2 : IsUnit (2 : ↥𝒪[K])) :
    Nat.card (Kˣ ⧸ (powMonoidHom 2 : Kˣ →* Kˣ).range) = 4 :=
  sorry

/-- **Layer 1, the square classes at residue characteristic `2`, in the `4 · q^e` form.** The
specialization of `card_powerClasses_mixed` at `p = n = 2`, with `q = Nat.card 𝓀[K]` and
`e = absoluteRamificationIndex K 2`. It is `2 · #μ_2(K) · q^e` with `#μ_2(K) = 2`, and
`q ^ e = Nat.card (𝒪[K] ⧸ 2𝒪[K])`. For `K/ℚ_2` of degree `N` it reads `2 ^ (N + 2)`, and at
`K = ℚ_2` it reads `8`. ⚠ The factor `q ^ e` is not `1` here, so this is not the count of
`card_squareClasses_of_isUnit` with a different proof; the two hypotheses are exclusive. -/
theorem card_squareClasses_dyadic [Algebra ℚ_[2] K] [Module.Finite ℚ_[2] K] :
    Nat.card (Kˣ ⧸ (powMonoidHom 2 : Kˣ →* Kˣ).range)
      = 4 * Nat.card 𝓀[K] ^ absoluteRamificationIndex K 2 :=
  sorry

/-- **Layer 1, the two spellings of the square classes.** Mathlib's `Subgroup.square Kˣ` is the
subgroup of squares, and the counts above are stated at the range of `powMonoidHom`. This is the
identification at `n = 2`, and it is what lets a consumer read the count of this layer, and the
Kummer isomorphism of Layer 5, on `Subgroup.square Kˣ`. -/
theorem square_eq_range_powMonoidHom :
    Subgroup.square Kˣ = (powMonoidHom 2 : Kˣ →* Kˣ).range :=
  sorry

/-- **Layer 1, worked example: `ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (the classes of `−1, 2, 5`
generate). The odd-`p` count is `4`; this factor-of-two dyadic difference is why no layer may
assume `p ≠ 2`. -/
example : Nat.card (ℚ_[2]ˣ ⧸ (powMonoidHom 2 : ℚ_[2]ˣ →* ℚ_[2]ˣ).range) = 8 :=
  sorry

/-- **Layer 1, the local square theorem, sharp form.** For `K/ℚ_2` finite and
`e = absoluteRamificationIndex K 2`, every unit of depth `2e+1` is a square. ⚠ This is **not** an
instance of the counts above, which decide how many square classes there are and not which
subgroup lies inside the squares. ⚠ The hypothesis is mixed characteristic: in equal
characteristic `2` the image of `2` is `0`, `absoluteRamificationIndex` takes its junk value, and
the displayed statement is a different assertion. -/
theorem unitFiltration_le_range_powMonoidHom_two [Algebra ℚ_[2] K] [Module.Finite ℚ_[2] K] :
    unitFiltration K (2 * absoluteRamificationIndex K 2 + 1)
      ≤ (powMonoidHom 2 : Kˣ →* Kˣ).range :=
  sorry

/-- **Layer 1, sharpness of the local square theorem.** The threshold `2e+1` cannot be lowered,
over any finite extension of `ℚ_2` and not only over `ℚ_2`: `U(K, 2e)` always meets the
complement of the squares. The obstruction is the Artin–Schreier map `t ↦ t² + t` of `𝓀[K]`,
which is `𝔽_2`-linear with kernel `𝔽_2` and therefore has image of index `2`; since
`𝓂[K]^{2e} = 4 · 𝒪[K]`, a unit `1 + 4c` is a square exactly when the residue of `c` is in that
image, so any `c` outside it is a witness. -/
theorem not_unitFiltration_le_range_powMonoidHom_two [Algebra ℚ_[2] K] [Module.Finite ℚ_[2] K] :
    ¬ unitFiltration K (2 * absoluteRamificationIndex K 2)
      ≤ (powMonoidHom 2 : Kˣ →* Kˣ).range :=
  sorry

/-- **Layer 1, worked example: the dyadic deep-square bound.** Units of `ℤ_2` congruent to
`1 mod 8` are squares (`U(K, 2e+1) ⊆ (Kˣ)²` at `K = ℚ_2`, `e = 1`), and `1 + 4ℤ_2` are not, so
the threshold is sharp there. -/
example (u : ℤ_[2]ˣ) (_hu : (8 : ℤ_[2]) ∣ ((u : ℤ_[2]) - 1)) : IsSquare u :=
  sorry

/-! ## Layer 2: unramified extensions and Frobenius -/

/-- **Layer 2, the Frobenius element** of a finite unramified extension: the preimage of the
arithmetic Frobenius `x ↦ x^q` of the residue extension under the residue correspondence
`Gal(L/K) ≃* Gal(𝓀[L]/𝓀[K])`. It generates `Gal(L/K)`, which is cyclic of order `f`. The
unramifiedness hypothesis is `ramificationIndex K L = 1`; separability of the residue extension,
which the general definition of an unramified extension of valued fields also carries, is
automatic here because `𝓀[K]` is finite. `IsGalois K L` is likewise automatic for an unramified
`L/K`, which is generated over `K` by the `(q^f − 1)`-st roots of unity and so is the splitting
field of a separable polynomial; it is carried because the residue correspondence is stated for
a Galois extension. ⚠ Arithmetic, never geometric: the inverse `(frobeniusAlgEquiv K L h)⁻¹` is
the geometric Frobenius, and no statement of this roadmap uses the unqualified word for it. -/
noncomputable def frobeniusAlgEquiv [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] (_h : ramificationIndex K L = 1) : L ≃ₐ[K] L :=
  sorry

/-- **Layer 2, the characteristic property of Frobenius:** `σ(y) ≡ y^q mod 𝓂[L]` on `𝒪[L]`,
with `q = Nat.card 𝓀[K]`. This is the equation that fixes `frobeniusAlgEquiv`, and it is stated
on the valuation rather than on the residue field so that it needs no separate name for the
induced action on `𝓀[L]`; `valuation L x < 1` is membership in `𝓂[L]`. -/
theorem valuation_frobeniusAlgEquiv_sub_pow [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] [IsGalois K L] (h : ramificationIndex K L = 1) (y : ↥𝒪[L]) :
    valuation L (frobeniusAlgEquiv K L h (y : L) - (y : L) ^ Nat.card 𝓀[K]) < 1 :=
  sorry

/-- **The norm group** `N_{L/K}(Lˣ) : Subgroup Kˣ`, the image of the field norm. Layer 2 computes
it for `L/K` unramified, and Layer 7 item 1 studies it for `L/K` finite abelian: openness, the
index formula `[Kˣ : N_{L/K}Lˣ] = [L:K]`, and the lattice of norm groups. It is a definition and
not a placeholder; the milestones are the laws about it. -/
noncomputable def normGroup [Algebra K L] [Module.Finite K L] : Subgroup Kˣ :=
  (Units.map (Algebra.norm K : L →* K)).range

/-- **Layer 2, norms of units from an unramified extension.** `N_{L/K}(𝒪[L]ˣ) = 𝒪[K]ˣ`, written
on the depth-zero step of the unit filtration, which `mem_unitFiltration_zero` identifies with
the units of the valuation ring. ⚠ *False generalization:* for a ramified extension the norm of
a unit is still a unit, but the image is a proper subgroup; at `L = ℚ_2(√2)` it has index `2` in
`ℤ_2ˣ`. -/
theorem map_norm_unitFiltration_zero [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    (_h : ramificationIndex K L = 1) :
    Subgroup.map (Units.map (Algebra.norm K : L →* K)) (unitFiltration L 0) = unitFiltration K 0 :=
  sorry

/-- **Layer 2, the unramified norm group in norm-equation form.** `N_{L/K}(Lˣ) = π^{fℤ} × 𝒪[K]ˣ`,
stated as the solvability criterion for the norm equation `N_{L/K}(y) = x`: with `e = 1` the
valuation of a norm is `f · v_L(y)`, and units are norms by the milestone above, so `x` is a norm
exactly when `f` divides `v_K(x)`. ⚠ `f` here is `inertiaDegree K L`, the residue degree of
Layer 0, and never a conductor. -/
theorem mem_normGroup_iff_dvd_normalizedValuation [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] (_h : ramificationIndex K L = 1) (x : Kˣ) :
    x ∈ normGroup K L ↔
      (inertiaDegree K L : ℤ) ∣ Multiplicative.toAdd (normalizedValuation K x) :=
  sorry

/-- **Layer 2, worked example: the unramified quadratic extension of `ℚ_2`.** The adjoined set
is *all* cube roots of unity, so the intermediate field is the splitting field of `X³ − 1`
over `ℚ_2` and no primitive root is chosen; it equals `ℚ_2(√5) = ℚ_2(√−3)` and has residue
field `𝔽_4`. The general milestone is `[K(μ_{q^f−1}) : K] = f` with `Gal` isomorphic to the
Galois group of the residue extension, generated by arithmetic Frobenius. -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 3 = 1}) = 2 :=
  sorry

/-- **Layer 2, worked example: units of `ℚ_2` are norms from the unramified quadratic
extension** (`u = x² − 5y²` solvable over `ℤ_2`; norm surjectivity on units, Serre LF V §2,
the input to the fundamental-class layer). -/
example (u : ℤ_[2]ˣ) : ∃ x y : ℤ_[2], (u : ℤ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  sorry

/-- **Layer 2, worked example: `2` is *not* a norm from the unramified quadratic extension**
(`N(ℚ_2(√5)ˣ) = ⟨4⟩ × ℤ_2ˣ` has index `2`; a uniformizer detects the unramified norm
group). -/
example : ¬ ∃ x y : ℚ_[2], (2 : ℚ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  sorry

/-! ## Layer 3: ramification (worked examples; the filtration itself is README-only) -/

/-- **Layer 3, worked example: a totally ramified quadratic extension.** `ℚ_2(√2)/ℚ_2` has
degree `2` (Eisenstein `X² − 2`); the general milestone is the totally-ramified ↔ Eisenstein
correspondence. -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 2 = 2}) = 2 :=
  sorry

/-- **Layer 3, worked example: the dyadic cyclotomic tower is totally ramified.**
`[ℚ_2(μ_8) : ℚ_2] = φ(8) = 4`. Its ramification filtration `G = G_0 = G_1 ⊋ G_2 = G_3 ⊋
G_4 = 1`, the resulting Herbrand jumps, and the failure of lower-numbering quotient
compatibility that it witnesses are the README's Layer-3 acceptance computations, stated once
the filtration exists. -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 8 = 1}) = 4 :=
  sorry

/-! ## Layers 7–8 acceptance statements (pin-expressible worked examples)

The reciprocity map, norm groups, regime-correct duality, and the Euler characteristic appear
in the last section, where they carry their hypotheses. Three mixed-characteristic `ℚ_2`
consequences need none of that, and serve as end-to-end acceptance targets. -/

/-- **Layer 7 acceptance, the norm group of `ℚ_2(√5)` has index 2.** The norm group is the
image of the actual field norm of the unramified quadratic extension, not a subgroup
generated by the values of a quadratic form; that description is the *next* statement, proved
rather than assumed. Finite-dimensionality is hypothesized because it is the Layer-2 worked
example above, not because it is in doubt. -/
example (M : IntermediateField ℚ_[2] (AlgebraicClosure ℚ_[2]))
    (_hM : M = IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 3 = 1})
    [FiniteDimensional ℚ_[2] M] :
    Nat.card (ℚ_[2]ˣ ⧸ (Units.map (Algebra.norm ℚ_[2] : M →* ℚ_[2])).range) = 2 :=
  sorry

/-- **Layer 7 acceptance, the norm form describes that norm group.** `x² − 5y²` is the norm
form of `ℚ_2(√5)/ℚ_2`, so the image of the field norm is exactly its set of nonzero values.
This is the characterization theorem; the definition of the norm group is the image above. -/
example (M : IntermediateField ℚ_[2] (AlgebraicClosure ℚ_[2]))
    (_hM : M = IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 3 = 1})
    [FiniteDimensional ℚ_[2] M] (x : ℚ_[2]ˣ) :
    x ∈ (Units.map (Algebra.norm ℚ_[2] : M →* ℚ_[2])).range ↔
      ∃ a b : ℚ_[2], (x : ℚ_[2]) = a ^ 2 - 5 * b ^ 2 :=
  sorry

/-- **Layer 8 acceptance, the dyadic norm equation at `(−1, −1)`.** `−1` is not a sum of two
squares in `ℚ_2`, equivalently `−1` is not a norm from `ℚ_2(√−1)`. This is field arithmetic over
`ℚ_2` and needs no cohomology; it is the input that makes the duality pairing of Layer 8B
nontrivial at `n = 2`, and the classical symbol that records it is the Quadratic Form Invariants
roadmap's. -/
example : ¬ ∃ x y : ℚ_[2], (-1 : ℚ_[2]) = x ^ 2 + y ^ 2 :=
  sorry

/-! ## Operations that this roadmap does not own

One development carries operations that this roadmap uses and should not build a second time:
the group theory of pro-`p` groups. (The cohomology of a profinite group is the second, and it is
imported and cited by name, so it needs no bundling structure here.) Nothing below postulates a
pro-`p` theorem. The predicates and the carriers are **definitions**, with the bodies that the
supplying development gives them, so the two are definitionally equal and a statement here
transports to the supplier's name by `rfl`. The **theorems** are collected into the two
structures `ProPOps` and `ProPRankInputs`, and the supplier constructs the canonical terms
`proPOps` and `proPRankInputs` from its named theorems.

A theorem stated against those structures is an honest theorem, and not an axiom: it asserts an
implication whose proof needs nothing outside Mathlib and the earlier milestones. The public
Layer 9 rank theorem is not left in that conditional form; it is the instantiation of
`rank_absoluteGaloisGroup_of_inputs` at the two canonical terms. -/

namespace Supplied

open CategoryTheory

variable (p : ℕ)

/-! ### Definitions, with the supplier's bodies -/

/-- The pro-`p` predicate, in quotient form: every continuous finite quotient is a `p`-group.
Fully qualified supplier name: `TauCetiRoadmap.ProPGroups.IsProP`. -/
def IsProP (G : Type u) [Group G] [TopologicalSpace G] : Prop :=
  ∀ U : OpenNormalSubgroup G, IsPGroup p (G ⧸ U.toSubgroup)

/-- Topological finite generation, in the fixed shape.
Fully qualified supplier name: `TauCetiRoadmap.ProPGroups.IsTopologicallyFinitelyGenerated`. -/
def IsTopologicallyFinitelyGenerated (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Prop :=
  ∃ s : Finset G, (Subgroup.closure (s : Set G)).topologicalClosure = ⊤

/-- Every open normal subgroup omits only finitely many elements of the set. The cardinal rank
is an infimum over sets with this property. -/
def ConvergesToOne {G : Type u} [Group G] [TopologicalSpace G] (s : Set G) : Prop :=
  ∀ U : OpenNormalSubgroup G, {x ∈ s | x ∉ U.toSubgroup}.Finite

/-- The cardinal-valued topological rank. ⚠ Dropping `ConvergesToOne` changes the invariant, so
the two rank objects are kept apart. -/
noncomputable def topologicalGeneratorRank (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Cardinal.{u} :=
  ⨅ s : {s : Set G // ConvergesToOne s ∧ (Subgroup.closure s).topologicalClosure = ⊤},
    Cardinal.mk ↥s.1

/-- The natural-number accessor, available exactly when the group is topologically finitely
generated. Every numerical statement, including the rank theorem of Layer 9, is about this
declaration. ⚠ A total `ℕ`-valued rank would report `0` for a group with no finite generating
set, which is why the proof is an argument here. -/
noncomputable def topologicalGeneratorRankNat (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (_h : IsTopologicallyFinitelyGenerated G) : ℕ :=
  sInf {n : ℕ | ∃ s : Finset G,
    s.card = n ∧ (Subgroup.closure (s : Set G)).topologicalClosure = ⊤}

/-- The intersection of the open normal subgroups with `p`-group quotient. -/
def proPKernel (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // IsPGroup p (G ⧸ U.toSubgroup)}, U.1.toSubgroup

instance proPKernel_normal (G : Type u) [Group G] [TopologicalSpace G] :
    (proPKernel p G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-- The maximal pro-`p` quotient `G(p)`. -/
abbrev maximalProPQuotient (G : Type u) [Group G] [TopologicalSpace G] : Type u :=
  G ⧸ proPKernel p G

/-- `G_K(p)`, the maximal pro-`p` quotient of the absolute Galois group. Layer 9 cites this
carrier, and does not re-form the quotient. -/
abbrev absoluteGaloisGroupProP (K : Type u) [Field K] : Type u :=
  maximalProPQuotient p (Field.absoluteGaloisGroup K)

/-- A closed pro-`p` subgroup whose image in every continuous finite quotient has index prime to
`p`. ⚠ Maximality among closed pro-`p` subgroups is equivalent, but that equivalence is a
theorem of Sylow theory, and not the definition. -/
def IsProPSylow {G : Type u} [Group G] [TopologicalSpace G] (P : Subgroup G) : Prop :=
  IsClosed (P : Set G) ∧ IsProP p P ∧
    ∀ U : OpenNormalSubgroup G, ¬ p ∣ (P.map (QuotientGroup.mk' U.toSubgroup)).index

/-- The **free profinite group** on `X`: the profinite completion of the discrete free group.
This is a definition and not a placeholder, and it is the pinned construction. -/
noncomputable abbrev freeProfiniteGroup (X : Type u) : ProfiniteGrp.{u} :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (FreeGroup X))

/-- The generators of the free profinite group. -/
noncomputable def freeProfiniteGroup.of {X : Type u} (x : X) : freeProfiniteGroup X :=
  ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (FreeGroup X)) (FreeGroup.of x)

/-- The profinite group **presented** by generators `X` and relators `rels`: the free profinite
group modulo the *closed* normal closure of the relators. Layer 4 states the Iwasawa
presentation `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^(−q)⟩` against this object. ⚠ It is the profinite object,
not a pro-`p` one, whose pro-`p` quotient would forget the prime-to-`p` tame inertia. -/
noncomputable abbrev presentedProfiniteGroup (X : Type u)
    (rels : Set (freeProfiniteGroup X)) : Type u :=
  freeProfiniteGroup X ⧸ (Subgroup.normalClosure rels).topologicalClosure

/-- The **Frattini subgroup of a pro-`p` group**, in index-`p` form: the intersection of the open
normal subgroups of index `p`. For a pro-`p` group these are exactly the maximal open subgroups,
and this agrees with the closure of `Gᵖ[G,G]`. The definition is stated so that it makes sense
for any topological group. -/
def proPFrattini (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // U.toSubgroup.index = p}, U.1.toSubgroup

instance proPFrattini_normal (G : Type u) [Group G] [TopologicalSpace G] :
    (proPFrattini p G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-- `μ_p ⊆ F`, the hypothesis that separates the two rank statements about `G_F(p)`. -/
def HasMuP (p : ℕ) (F : Type u) [Field F] : Prop := ∃ ζ : F, IsPrimitiveRoot ζ p

/-! ### `ProPOps`: the theorems of pro-`p` group theory, as hypotheses -/

/-- The pro-`p` and profinite group theory that Layers 4 and 9 use. Every field is a statement
about profinite groups, free of Galois vocabulary. -/
structure ProPOps (p : ℕ) : Prop where
  /-- Every profinite group has a pro-`p` Sylow subgroup. -/
  exists_isProPSylow : ∀ (G : Type u) [Group G] [TopologicalSpace G] [CompactSpace G]
    [TotallyDisconnectedSpace G], ∃ P : Subgroup G, IsProPSylow p P
  /-- Every closed pro-`p` subgroup lies in a pro-`p` Sylow subgroup. -/
  exists_le_isProPSylow : ∀ (G : Type u) [Group G] [TopologicalSpace G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (Q : Subgroup G), IsProP p Q → IsClosed (Q : Set G) →
      ∃ P : Subgroup G, IsProPSylow p P ∧ Q ≤ P
  /-- A normal pro-`p` Sylow subgroup is the only one. Layer 4 uses this for wild inertia. -/
  sylow_eq_of_normal : ∀ (G : Type u) [Group G] [TopologicalSpace G] (P Q : Subgroup G),
    IsProPSylow p P → IsProPSylow p Q → P.Normal → P = Q
  /-- The image under a continuous surjection is a pro-`p` Sylow subgroup. -/
  sylow_map_of_surjective : ∀ (G H : Type u) [Group G] [TopologicalSpace G] [Group H]
    [TopologicalSpace H] (f : G →* H), Continuous f → Function.Surjective f →
      ∀ P : Subgroup G, IsProPSylow p P → IsProPSylow p (P.map f)
  /-- The universal property of the free profinite group, with uniqueness. -/
  freeProfiniteGroupLift : ∀ (X : Type u) (G : ProfiniteGrp.{u}) (f : X → G),
    ∃! φ : freeProfiniteGroup X ⟶ G, ∀ x : X, φ (freeProfiniteGroup.of x) = f x
  /-- The rank does not increase under a continuous surjection. Layer 9 uses it for
  `d(G_K) ≥ d(G_K(p))`. -/
  rank_le_of_surjective : ∀ (G H : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [Group H] [TopologicalSpace H] [IsTopologicalGroup H] (f : G →* H), Continuous f →
      Function.Surjective f → topologicalGeneratorRank H ≤ topologicalGeneratorRank G
  /-- The Schreier bound `d(U) ≤ 1 + [G : U](d(G) − 1)` for an open subgroup. Layer 9 uses it
  for the lower bound in the case `μ_p ⊄ K`. -/
  rank_le_of_isOpen : ∀ (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (U : Subgroup G), IsOpen (U : Set G) → ∀ (hG : IsTopologicallyFinitelyGenerated G)
      (hU : IsTopologicallyFinitelyGenerated U),
      topologicalGeneratorRankNat U hU ≤ 1 + U.index * (topologicalGeneratorRankNat G hG - 1)
  /-- The Burnside criterion: a subset of a pro-`p` group generates topologically if and only if
  its image topologically generates the Frattini quotient `G ⧸ Φ(G)`. ⚠ The closure on the
  right is not decoration: without it the statement is false for `∏_ℕ C_p`, where the Frattini
  subgroup is trivial and a countable dense subset generates topologically but not abstractly.
  Layer 9 uses this field for the tame frame. -/
  topologicallyGenerates_iff_frattiniQuotient : ∀ (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G], IsProP p G → ∀ s : Set G,
      (Subgroup.closure s).topologicalClosure = ⊤ ↔
        (Subgroup.closure ((QuotientGroup.mk' (proPFrattini p G)) '' s)).topologicalClosure = ⊤

/-- The rank of the maximal pro-`p` quotient of an absolute Galois group, in the two cases that
Layer 9 uses. ⚠ Every field is about `G_F(p)`, and none is about `G_F`. -/
structure ProPRankInputs (p : ℕ) [Fact p.Prime] : Prop where
  /-- `G_F(p)` is topologically finitely generated. -/
  finiteGen : ∀ (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F],
    IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F)
  /-- Demushkin: `d(G_F(p)) = [F : ℚ_p] + 2` when `μ_p ⊆ F`. -/
  rank_of_mu : ∀ (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F],
    HasMuP p F → ∀ h : IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F),
      topologicalGeneratorRankNat (absoluteGaloisGroupProP p F) h = Module.finrank ℚ_[p] F + 2
  /-- Shafarevich: `d(G_F(p)) = [F : ℚ_p] + 1` when `μ_p ⊄ F`, where `G_F(p)` is free pro-`p`. -/
  rank_of_not_mu : ∀ (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F],
    ¬ HasMuP p F → ∀ h : IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F),
      topologicalGeneratorRankNat (absoluteGaloisGroupProP p F) h = Module.finrank ℚ_[p] F + 1

/-- **The canonical pro-`p` package**: the term of `ProPOps` assembled from the named
supplier theorems (`exists_isProPSylow`, `IsProP.exists_le_isProPSylow`,
`IsProPSylow.eq_of_normal`, `IsProPSylow.map_of_surjective`, `freeProfiniteGroup.lift`,
`topologicalGeneratorRank_le_of_surjective`, `topologicalGeneratorRankNat_le_of_isOpen`,
`topologicallyGenerates_iff_frattiniQuotient`). The interface table names this term, so it
is a stable declaration and not an anonymous example. -/
theorem proPOps (p : ℕ) : ProPOps.{u} p := sorry

/-- **The canonical rank package**: the term of `ProPRankInputs` assembled from the named
Layer 11 theorems (`isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`,
`topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu`,
`topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu`). The interface table names
this term, so it is a stable declaration and not an anonymous example. -/
theorem proPRankInputs (p : ℕ) [Fact p.Prime] : ProPRankInputs.{u} p := sorry

end Supplied

/-! ## The cohomology carrier, and the supplier declarations that act on it

The carrier is Mathlib's `continuousCohomology` on the objects of
`TauCetiRoadmap.ProfiniteCohomology.TopRep`, which carry the discrete topology and the continuous
action that the coefficients must have. `GalRep` and `H` are abbreviations, and not a second
implementation: `GalRep n F` unfolds to `ProfiniteCohomology.TopRep (ZMod n) G_F`, whose ring
universe is independent of the group universe, and `H` unfolds to the value of the Mathlib
functor. The operations on them are `ProfiniteCohomology.cup`, `ProfiniteCohomology.coeffMap`,
`ProfiniteCohomology.res`, `ProfiniteCohomology.infl`, `ProfiniteCohomology.corestriction`,
`ProfiniteCohomology.shapiroIso`, and `ProfiniteCohomology.explicitFiniteQuotientColimit1`. -/

/-- Coefficients for `G_F`, bundled: a topological `ZMod n`-representation, in the supplier's
carrier. -/
abbrev GalRep (n : ℕ) (F : Type u) [Field F] : Type (u + 1) :=
  ProfiniteCohomology.TopRep (ZMod n) (Field.absoluteGaloisGroup F)

/-- `Hⁱ(G_F, A)`, the continuous cohomology of Mathlib. This roadmap uses no other carrier. -/
noncomputable abbrev H (n : ℕ) (F : Type u) [Field F] (i : ℕ) (A : GalRep n F) : Type _ :=
  (continuousCohomology (ZMod n) (Field.absoluteGaloisGroup F) i).obj A

/-! ## Objects and statements that this roadmap owns

`muNRep` and `tateDual` are local arithmetic, so they are targets here and not hypotheses: a
`sorry` body is the roadmap's own obligation. Every theorem below is a named declaration. -/

section Deliverables

open Supplied CategoryTheory
open scoped MonoidalCategory

variable {n : ℕ}

/-- The `G_F`-module `μ_n(Fˢ)`, written additively, as a coefficient object. ⚠ The roots of
unity are taken inside the **separable** closure: over an imperfect field of equal
characteristic, the invariants of the full algebraic closure are the perfect closure. -/
def muNRep (n : ℕ) (F : Type u) [Field F] : GalRep n F := sorry

/-- The Tate dual `A' = Hom(A, μ_n)`, with the conjugation action. -/
def tateDual {n : ℕ} {F : Type u} [Field F] (_A : GalRep n F) : GalRep n F := sorry

/-! ### Layer 4 and Layer 5: the two transports that carry the supplier's Kummer theory here

`ProfiniteCohomology.kummerMapCanonical` and `ProfiniteCohomology.kummerIso` are stated over
`ProfiniteCohomology.AbsoluteGaloisGroup F`, which is `SeparableClosure F ≃ₐ[F] SeparableClosure F`,
with coefficients the `ℤ`-linear `ProfiniteCohomology.KummerCoeff F n`. The pinned conventions of
this roadmap use `Field.absoluteGaloisGroup F` and the `ZMod n`-linear `muNRep n F`. Neither pair
is the same Lean object, so the consumption goes through two named transports, and both are
milestones here. -/

/-- **Layer 4, the Galois-group transport.** `Field.absoluteGaloisGroup F` is the automorphisms of
the algebraic closure and `ProfiniteCohomology.AbsoluteGaloisGroup F` is the automorphisms of the
separable closure; restriction is an isomorphism of topological groups. ⚠ For an imperfect field of
equal characteristic the fixed field of the first acting on the algebraic closure is the purely
inseparable closure, so the comparison is a theorem and not a definitional identity. -/
noncomputable def absoluteGaloisGroupComparison (F : Type u) [Field F] :
    Field.absoluteGaloisGroup F ≃ₜ* ProfiniteCohomology.AbsoluteGaloisGroup F :=
  sorry

/-- **Layer 5, the coefficient dictionary.** `ProfiniteCohomology.KummerCoeff F n` is `μ_n(Fˢ)`
written additively as a discrete `ℤ`-module; `muNRep n F` is the same group as a topological
`ZMod n`-module. The dictionary is the additive equivalence between them, and the two lemmas
below are what make it usable: without continuity and equivariance it would not feed
`ProfiniteCohomology.kummerIsoTransport`. -/
noncomputable def muNRepCoeffDictionary (n : ℕ) (F : Type u) [Field F] :
    ProfiniteCohomology.KummerCoeff F n ≃+ (muNRep n F).V :=
  sorry

/-- **Layer 5.** The coefficient dictionary is continuous. Both sides are discrete, so this is the
statement that the underlying map is one of discrete spaces and not an accident of the carrier. -/
theorem muNRepCoeffDictionary_continuous (n : ℕ) (F : Type u) [Field F] :
    Continuous (muNRepCoeffDictionary n F) :=
  sorry

/-- **Layer 5.** The coefficient dictionary is equivariant, along the Galois-group transport. This
is the hypothesis that a plain group equivalence lacks, and it is what
`ProfiniteCohomology.kummerIsoTransport` consumes. -/
theorem muNRepCoeffDictionary_equivariant (n : ℕ) (F : Type u) [Field F]
    (g : Field.absoluteGaloisGroup F) (x : ProfiniteCohomology.KummerCoeff F n) :
    muNRepCoeffDictionary n F (absoluteGaloisGroupComparison F g • x)
      = ((muNRep n F).ρ g).hom (muNRepCoeffDictionary n F x) :=
  sorry

/-- **Layer 5, `kummerClass`**: the image of `a` in `H¹(G_F, μ_n)`. It is
`ProfiniteCohomology.kummerMapCanonical` read through `absoluteGaloisGroupComparison` and
`muNRepCoeffDictionary`, and not a second Kummer cocycle. -/
def kummerClass (n : ℕ) (F : Type u) [Field F] (_a : Fˣ) : H n F 1 (muNRep n F) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 1.** For `n` invertible in `𝒪[K]`, the Kummer map is an
isomorphism of **groups**, after the multiplicative quotient is written additively. This is
`ProfiniteCohomology.kummerIso` transported along the two milestones above; the hypothesis
`IsUnit (n : ↥𝒪[K])` implies the supplier's `IsUnit (n : K)`, which is the hypothesis its
statement carries. A bare equivalence of types would not support the cup-product square below,
and a `Nonempty` would not be the isomorphism the API promises. -/
noncomputable def kummerEquiv_unit (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Additive (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range) ≃+ H n K 1 (muNRep n K) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 2.** For `K/ℚ_p` finite the same isomorphism holds for
every `n ≠ 0`, including `n = p`, where `n` is still invertible in the **field**, so the supplier's
`ProfiniteCohomology.kummerIso` applies and the arithmetic content is the finiteness of the power
classes. It does not follow from the regime-1 statement. -/
noncomputable def kummerEquiv_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) :
    Additive (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) ≃+ H n F 1 (muNRep n F) :=
  sorry

/-! ### Layer 5: the Brauer group and the invariant map

The coefficient object here is the multiplicative module `(Kˢ)ˣ`, which this roadmap owns, and
the coefficient ring is `ℤ` rather than `ZMod n`: `Br(K)` is not killed by any `n`. So these
statements do not read through `GalRep`/`H`, which are the `ZMod n`-linear abbreviations, and
`unitsRep` is a second **coefficient object**, never a second carrier: the carrier is still
Mathlib's `continuousCohomology`. -/

/-- `ℚ/ℤ`, the target of the invariant map, as the quotient of `ℚ` by the subgroup generated by
`1`. ⚠ Not the circle group of the reals: the `n`-torsion subgroup `(1/n)ℤ/ℤ`, which is where
Layer 8A reads the classes killed by `n`, has to be a subgroup of the target, and the invariant
of a class of `Br(K)` is a rational number and not a real one. -/
abbrev RatModInt : Type := ℚ ⧸ AddSubgroup.zmultiples (1 : ℚ)

/-- **Layer 5, the multiplicative module `(Kˢ)ˣ`**, written additively, as a coefficient object
for `G_F`. ⚠ The units are taken in the **separable** closure, as the pinned conventions require:
over an imperfect field of equal characteristic the invariants of the units of the full algebraic
closure are the units of the perfect closure, so `H⁰` would be wrong. The action of
`Field.absoluteGaloisGroup F` is through `absoluteGaloisGroupComparison`. -/
def unitsRep (F : Type u) [Field F] :
    ProfiniteCohomology.TopRep ℤ (Field.absoluteGaloisGroup F) :=
  sorry

/-- **Layer 5, the Brauer group** `Br(F) = H²(G_F, (Fˢ)ˣ)`, in the one carrier this roadmap
uses. Its identification with classes of central simple algebras belongs to the roadmap that
owns those, and is not needed for anything below. -/
noncomputable abbrev Br (F : Type u) [Field F] : Type _ :=
  (continuousCohomology ℤ (Field.absoluteGaloisGroup F) 2).obj (unitsRep F)

/-- **Layer 5, `inv_K`, the invariant map.** Every class of `Br(K)` is inflated from the
unramified tower, and the resulting isomorphism `Br(K) ≃ ℚ/ℤ` is this map. Bijectivity is the
`≃+`, so injectivity and surjectivity are its two components and not separate milestones. ⚠ The
two squares below do not fix the normalization: they hold for `-inv` as well. What fixes it is
the pinned convention, evaluation at the **arithmetic** Frobenius, which is the normalization
lemma at an unramified class, stated in the README once Layer 5 has the fundamental classes:
`inv_K(u_{L/K}) = 1/[L:K]`. -/
noncomputable def invMap : Br K ≃+ RatModInt :=
  sorry

/-- **Layer 5, restriction on Brauer groups along a `K`-embedding of a finite separable
extension.** ⚠ The embedding is data and not decoration: without one there is no map
`G_L → G_K`, so no square below is a statement about an arbitrary pair of absolute Galois
groups. This is the shape the supplier uses for `ProfiniteCohomology.kummerRes`, at the
coefficient object of this layer. -/
noncomputable def brRes [Algebra K L] [Module.Finite K L] [Algebra.IsSeparable K L]
    (_ι : L →ₐ[K] SeparableClosure K) : Br K →+ Br L :=
  sorry

/-- **Layer 5, corestriction on Brauer groups along the same embedding**, which realizes `G_L` as
an open subgroup of `G_K`. It is `ProfiniteCohomology.corestriction` at this coefficient object,
and never the corestriction of group *homology*, which is a different map. -/
noncomputable def brCor [Algebra K L] [Module.Finite K L] [Algebra.IsSeparable K L]
    (_ι : L →ₐ[K] SeparableClosure K) : Br L →+ Br K :=
  sorry

/-- **Layer 5, the restriction square:** `inv_L(res α) = [L:K] · inv_K(α)`. -/
theorem invMap_brRes [Algebra K L] [Module.Finite K L] [Algebra.IsSeparable K L]
    (ι : L →ₐ[K] SeparableClosure K) (α : Br K) :
    invMap L (brRes K L ι α) = Module.finrank K L • invMap K α :=
  sorry

/-- **Layer 5, the corestriction square:** `inv_K(cor β) = inv_L(β)`, with no degree factor. -/
theorem invMap_brCor [Algebra K L] [Module.Finite K L] [Algebra.IsSeparable K L]
    (ι : L →ₐ[K] SeparableClosure K) (β : Br L) :
    invMap K (brCor K L ι β) = invMap L β :=
  sorry

/-- **Layer 8A, `h2MuEquivZMod_unit`**, the trace isomorphism away from the residue
characteristic. ⚠ The hypotheses are the local-field hypotheses, `n ≠ 0`, and
`IsUnit (n : 𝒪[K])`. Without them the statement is false: over an algebraically closed field
`G_K` is trivial, so `H²` is trivial while `ZMod n` is not. -/
theorem h2MuEquivZMod_unit (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Nonempty (H n K 2 (muNRep n K) ≃+ ZMod n) :=
  sorry

/-- **Layer 8B, `h2MuEquivZMod_mixed`**, the trace isomorphism for **every** `n ≥ 1` in mixed
characteristic. ⚠ `h2MuEquivZMod_unit` says nothing at `n = p`, so this is a separate theorem
and not a corollary. -/
theorem h2MuEquivZMod_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) :
    Nonempty (H n F 2 (muNRep n F) ≃+ ZMod n) :=
  sorry

/-- **Layer 8B, `h2FpEquivZMod_of_mu`.** The transport of the trace isomorphism to the trivial
`ZMod p`-module `T`, which a chosen primitive `p`-th root of unity identifies with `μ_p`. ⚠ The
coefficient object is not quantified freely: the hypothesis `muNRep p F ≅ T` is what makes the
statement true. Without it the zero representation is a counterexample, because its `H²` is
trivial while `ZMod p` is not. The chosen root is an argument, and not a global convention. -/
theorem h2FpEquivZMod_of_mu (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (ζ : F) (_hζ : IsPrimitiveRoot ζ p) (T : GalRep p F) (_hT : Nonempty (muNRep p F ≅ T)) :
    Nonempty (H p F 2 T ≃+ ZMod p) :=
  sorry

/-- **Layer 5, `kummerCupPairing`**, the coefficient pairing `μ_n × μ_n → μ_n` attached to a
chosen primitive `n`-th root of unity. ⚠ This is where a choice hides. Multiplication of roots of
unity is not biadditive, so there is no canonical pairing of `μ_n` with itself into `μ_n` for
general `n`; a primitive `n`-th root of unity produces one through `μ_n ≅ ZMod n`, and `ζ` is
therefore an argument of the object and of every arithmetic statement about it. At `n = 2` the
pairing is canonical, because `μ_2 ≅ ZMod 2` needs no choice.

A `ProfiniteCohomology.TopPairing` carries `bil`, `cont`, and `equivariant` in its fields, so
constructing this term is exactly the milestone: bilinearity over `ZMod n`, joint continuity, and
`G_F`-equivariance of `μ_n × μ_n → μ_n`. -/
noncomputable def kummerCupPairing {n : ℕ} {F : Type u} [Field F] (ζ : F)
    (_hζ : IsPrimitiveRoot ζ n) :
    ProfiniteCohomology.TopPairing (muNRep n F) (muNRep n F) (muNRep n F) :=
  sorry

/-- **Layer 8, `tateEvaluationPairing`**, the coefficient pairing of local duality: evaluation
`A' × A → μ_n` on `A' = Hom(A, μ_n)`. Its `equivariant` field is the statement that evaluation
intertwines the conjugation action on `A'` with the action on `A`, which is what makes the cup
product below land in `H²(G_F, μ_n)`; the supplier's `evalPairing`, `evalPairing_equivariant`, and
`homAction` are the general-shape ingredients this specializes. -/
noncomputable def tateEvaluationPairing {n : ℕ} {F : Type u} [Field F] (A : GalRep n F) :
    ProfiniteCohomology.TopPairing (tateDual A) A (muNRep n F) :=
  sorry

/-- The local symbol at exponent `n`: cup product with a coefficient pairing of `μ_n` with itself
into `μ_n`, followed by a trace isomorphism. The product is `ProfiniteCohomology.cup`, and the
degree of its target is `1 + 1`, carried to `2` by `ProfiniteCohomology.degreeCast`.

This helper stays polymorphic in the pairing because its own content is formal: every statement
below that is *arithmetic* is stated at the named `kummerCupPairing ζ hζ`. -/
noncomputable def localSymbol {n : ℕ} {F : Type u} [Field F]
    (P : ProfiniteCohomology.TopPairing (muNRep n F) (muNRep n F) (muNRep n F))
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (x y : H n F 1 (muNRep n F)) : ZMod n :=
  tr (ProfiniteCohomology.degreeCast (by norm_num) (muNRep n F)
    (ProfiniteCohomology.cup P 1 1 x y))

/-- **Layer 5, `cup_kummerEquiv`, part one: bilinearity.** The symbol is additive in each
variable, which says that it is multiplicative in each argument of `Kˣ`. This one is formal, and
holds for every coefficient pairing, because it is `ProfiniteCohomology.cup_add_left` and
`ProfiniteCohomology.cup_add_right` read through the trace; so the pairing stays universally
quantified here and only here. -/
theorem localSymbol_kummerClass_mul
    (P : ProfiniteCohomology.TopPairing (muNRep n K) (muNRep n K) (muNRep n K))
    (tr : H n K 2 (muNRep n K) ≃+ ZMod n)
    (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a a' b : Kˣ) :
    localSymbol P tr (kummerClass n K (a * a')) (kummerClass n K b)
      = localSymbol P tr (kummerClass n K a) (kummerClass n K b)
        + localSymbol P tr (kummerClass n K a') (kummerClass n K b) :=
  sorry

/-- **Layer 5, `cup_kummerEquiv`, part two: the Steinberg relation.** The symbol vanishes on
`(a, 1 − a)`. With bilinearity this fixes the normalization. ⚠ This is arithmetic and not formal,
so it is stated at the named pairing `kummerCupPairing ζ hζ`: the zero pairing satisfies the
bilinearity above and would satisfy any universally quantified form of this statement without
saying anything about roots of unity. -/
theorem localSymbol_kummerClass_steinberg (ζ : K) (hζ : IsPrimitiveRoot ζ n)
    (tr : H n K 2 (muNRep n K) ≃+ ZMod n)
    (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a b : Kˣ) (_hab : (a : K) + (b : K) = 1) :
    localSymbol (kummerCupPairing ζ hζ) tr (kummerClass n K a) (kummerClass n K b) = 0 :=
  sorry

/-- **Layer 8, the duality pairing**, as the actual map `(x, y) ↦ inv(x ⌣ y)`, at the named
evaluation pairing. ⚠ There is no pairing argument: a family of coefficient maps of the right type
includes the zero map, and perfectness of the zero pairing is false, so the evaluation pairing is
named inside the definition. -/
noncomputable def tateDualityPairing {n : ℕ} {F : Type u} [Field F] (A : GalRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (i j : ℕ) (hij : i + j = 2)
    (x : H n F i (tateDual A)) (y : H n F j A) : ZMod n :=
  tr (ProfiniteCohomology.degreeCast hij (muNRep n F)
    (ProfiniteCohomology.cup (tateEvaluationPairing A) i j x y))

/-- **Layer 8, finiteness.** Every cohomology group in degrees `0`, `1`, `2` of a finite
discrete module is finite. The Euler-characteristic statement below depends on this, because
`Nat.card` is `0` on an infinite type. -/
theorem finite_H (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F) (_hA : Finite A.V) (i : ℕ) (_hi : i ≤ 2) :
    Finite (H n F i A) :=
  sorry

/-- **Layer 8B, `tateDualityPairing_perfect_mixed`.** Perfectness in degrees `0`, `1`, `2`,
written without bundling: the pairing has no left kernel, and every additive functional on the
other factor is represented. The coefficients are killed by `n`, because they are a
`ZMod n`-module, and they are finite and discrete. -/
theorem tateDualityPairing_perfect_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (_hA : Finite A.V) (_hdisc : DiscreteTopology A.V)
    (i j : ℕ) (hij : i + j = 2) :
    (∀ x : H n F i (tateDual A),
        (∀ y : H n F j A, tateDualityPairing A tr i j hij x y = 0) → x = 0) ∧
      (∀ φ : H n F j A →+ ZMod n, ∃ x : H n F i (tateDual A),
        ∀ y : H n F j A, tateDualityPairing A tr i j hij x y = φ y) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_mixed`.** With finiteness available,
`#H⁰ · #H² / #H¹ = ‖#M‖_K`, written over `ℕ` with `‖#M‖_K⁻¹ = p ^ (N · v_p(#M))`. -/
theorem eulerCharacteristic_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F) (_hA : Finite A.V)
    (_h0 : Finite (H n F 0 A)) (_h1 : Finite (H n F 1 A)) (_h2 : Finite (H n F 2 A)) :
    Nat.card (H n F 1 A)
      = Nat.card (H n F 0 A) * Nat.card (H n F 2 A)
        * p ^ (Module.finrank ℚ_[p] F * padicValNat p (Nat.card A.V)) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_finrank_fp`.** The `𝔽_p`-module corollary,
`dim H¹ = dim H⁰ + dim H² + N · dim M`, with the `ZMod p`-module structures on the cohomology
groups. The downstream table consumes this form. -/
theorem eulerCharacteristic_finrank_fp (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (A : GalRep p F) (_hA : Finite A.V) :
    Module.finrank (ZMod p) (H p F 1 A)
      = Module.finrank (ZMod p) (H p F 0 A)
        + Module.finrank (ZMod p) (H p F 2 A)
        + Module.finrank ℚ_[p] F * Module.finrank (ZMod p) A.V :=
  sorry

/-! ### Layer 6: finite-level reciprocity -/

/-- **Layer 6, the norm-residue isomorphism** `θ_{L/K} : Kˣ/N_{L/K}Lˣ ≃* Gal(L/K)^{ab}`, for
`L/K` finite Galois. It is `tateNakayama_top` at `r = −2`, applied to the class formation whose
distinguished class is the fundamental class `u_{L/K}`, in the direction and the normalization of
the pinned conventions. The `Art_K` of Layer 7 is the limit of these maps, and not a second
construction. -/
noncomputable def normResidue [Algebra K L] [Module.Finite K L] [IsGalois K L] :
    (Kˣ ⧸ normGroup K L) ≃* Abelianization (L ≃ₐ[K] L) :=
  sorry

/-- **Layer 6, the unramified normalization `θ(π) = Frob`.** For `L/K` unramified the class of a
uniformizer of `K` goes to the **arithmetic** Frobenius. This is the compatibility between
`inv_K(u_{L/K}) = 1/[L:K]` and the Frobenius normalization, and it is what makes `Art_K` send
uniformizers to arithmetic Frobenius; it is a lemma of its own, not a corollary of the
isomorphism. ⚠ Every uniformizer, with no choice made: the statement is quantified over the
irreducible elements of `𝒪[K]`. -/
theorem normResidue_uniformizer [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] (h : ramificationIndex K L = 1) (π : ↥𝒪[K]) (_hπ : Irreducible π)
    (hπ0 : (π : K) ≠ 0) :
    normResidue K L (QuotientGroup.mk (Units.mk0 (π : K) hπ0))
      = Abelianization.of (frobeniusAlgEquiv K L h) :=
  sorry

/-- **Layer 7, `artinMap`**, with the local-field hypotheses: there is no local Artin map over an
arbitrary field. Continuous, with dense image, and with kernel the intersection of the norm
groups. ⚠ It is not surjective, so it supports no `Nat.card` statement about its target. -/
noncomputable def artinMap : Kˣ →* Field.absoluteGaloisGroupAbelianization K := sorry

/-- **Layer 7, the geometric normalization.** One definition, and not a second convention: it is
`Art_K` precomposed with inversion, so the two differ by exactly the translation lemma below. -/
noncomputable def geometricArtinMap : Kˣ →* Field.absoluteGaloisGroupAbelianization K where
  toFun x := artinMap K x⁻¹
  map_one' := by simp
  map_mul' x y := by simp [mul_comm]

/-- **Layer 7, `Ẑ`**, the target of the unramified coordinate: the profinite completion of `ℤ`,
written multiplicatively. ⚠ It is never `ℤ`. A continuous homomorphism from the compact group
`G_K^{ab}` to the discrete group `ℤ` is trivial, so the `ℤ`-valued form of the normalization is
inconsistent and not merely inconvenient. -/
noncomputable abbrev ZHat : Type :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (Multiplicative ℤ))

/-- **Layer 7, `ι : ℤ → Ẑ`**, the completion map, in the additive-integer coordinate that the
normalization statements read. -/
noncomputable def zhatOfInt (m : ℤ) : ZHat :=
  ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (Multiplicative ℤ)) (Multiplicative.ofAdd m)

/-- **Layer 7, `unramifiedCoordinate`**, the map `ν_K : G_K^{ab} →* Ẑ` normalized by
`ν_K(Frob) = 1` at the **arithmetic** Frobenius. Its defining property is the first normalization
theorem below. -/
noncomputable def unramifiedCoordinate :
    Field.absoluteGaloisGroupAbelianization K →* ZHat :=
  sorry

/-- **Layer 7, the unramified normalization**: `ν_K ∘ Art_K = ι ∘ v_K`. This is the equation that
fixes both `artinMap` and `unramifiedCoordinate`, and it is what makes uniformizers go to
arithmetic Frobenius. -/
theorem unramifiedCoordinate_artinMap (x : Kˣ) :
    unramifiedCoordinate K (artinMap K x)
      = ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (Multiplicative ℤ))
          (normalizedValuation K x) :=
  sorry

/-- **Layer 7, the geometric translation lemma**: `ν^{geo} = −ν`, written multiplicatively. -/
theorem unramifiedCoordinate_geometricArtinMap (x : Kˣ) :
    unramifiedCoordinate K (geometricArtinMap K x)
      = (unramifiedCoordinate K (artinMap K x))⁻¹ :=
  sorry

/-- **Layer 7, `cyclotomicCharacter_artinMap`**, the general form, with the field norm. For
`K/ℚ_p` finite and `u` a unit, `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹`. ⚠ Without the norm the
equation is ill-typed for `K ≠ ℚ_p`, so the `ℚ_p` corollary does not replace it. -/
theorem cyclotomicCharacter_artinMap (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (u : Fˣ) (_hu : valuation F (u : F) = 1)
    (σ : Field.absoluteGaloisGroup F)
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization F) = artinMap F u) :
    Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom
        (cyclotomicCharacter (AlgebraicClosure F) p σ.toRingEquiv)
      = (Units.map (Algebra.norm ℚ_[p] : F →* ℚ_[p]) u)⁻¹ :=
  sorry

/-- **Layer 7, `cyclotomicCharacter_artinMap_padic`**, the corollary at `K = ℚ_p`, where the field
norm is the identity and both sides live in `ℤ_pˣ`. ⚠ A character with values in `𝒪[K]ˣ` and value
`u⁻¹` for a general `K` would be a Lubin–Tate character, which this roadmap does not build. -/
theorem cyclotomicCharacter_artinMap_padic (p : ℕ) [Fact p.Prime]
    [IsNonarchimedeanLocalField ℚ_[p]] (u : ℤ_[p]ˣ) (σ : Field.absoluteGaloisGroup ℚ_[p])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[p])
      = artinMap ℚ_[p] (Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom u)) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[p]) p σ.toRingEquiv = u⁻¹ :=
  sorry

/-! ### Layer 7 worked examples: the `ℚ_2` normalizations

Six consequences of the two normalization theorems above, at `K = ℚ_2`, where the field norm
`N_{K/ℚ_p}` is the identity. They are the regression tests for the sign of the unramified
coordinate and for the direction of the cyclotomic orientation, and each is stated against the
named `artinMap`, `unramifiedCoordinate`, and `geometricArtinMap`. The
`IsNonarchimedeanLocalField ℚ_[2]` instance they carry is the first milestone of Layer 0; it is a
hypothesis here only because the pin does not yet supply it. -/

/-- **Layer 7 acceptance, the arithmetic unramified coordinate of `Art(2)` is `1`.** The
uniformizer goes to arithmetic Frobenius, whose coordinate is `1`. -/
example [IsNonarchimedeanLocalField ℚ_[2]] :
    unramifiedCoordinate ℚ_[2] (artinMap ℚ_[2] (Units.mk0 (2 : ℚ_[2]) (by norm_num)))
      = zhatOfInt 1 :=
  sorry

/-- **Layer 7 acceptance, the geometric coordinate of `Art(2)` is `−1`.** This is the same
computation in the other normalization, and it is the one that catches a dropped inverse. -/
example [IsNonarchimedeanLocalField ℚ_[2]] :
    unramifiedCoordinate ℚ_[2] (geometricArtinMap ℚ_[2] (Units.mk0 (2 : ℚ_[2]) (by norm_num)))
      = zhatOfInt (-1) :=
  sorry

/-- **Layer 7 acceptance, a unit has unramified coordinate `0`.** Equivalently `Art(u)` lies in
the inertia subgroup for every `u ∈ ℤ_2ˣ`. -/
example [IsNonarchimedeanLocalField ℚ_[2]] (u : ℚ_[2]ˣ) (_hu : valuation ℚ_[2] (u : ℚ_[2]) = 1) :
    unramifiedCoordinate ℚ_[2] (artinMap ℚ_[2] u) = 1 :=
  sorry

/-- **Layer 7 acceptance, `χ_cyc(Art(−1)) = −1`.** -/
example [IsNonarchimedeanLocalField ℚ_[2]] (σ : Field.absoluteGaloisGroup ℚ_[2])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[2])
      = artinMap ℚ_[2] (Units.map (algebraMap ℤ_[2] ℚ_[2]).toMonoidHom (-1))) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[2]) 2 σ.toRingEquiv = -1 :=
  sorry

/-- **Layer 7 acceptance, `χ_cyc(Art(−3)) = (−3)⁻¹`.** The class of `−3` is the class of `5` in
`ℚ_2ˣ/(ℚ_2ˣ)²`, and this is the entry of the table that fixes the direction of the orientation:
the value is the **inverse**, and not the unit itself. -/
example [IsNonarchimedeanLocalField ℚ_[2]] (v : ℤ_[2]ˣ) (_hv : (v : ℤ_[2]) = -3)
    (σ : Field.absoluteGaloisGroup ℚ_[2])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[2])
      = artinMap ℚ_[2] (Units.map (algebraMap ℤ_[2] ℚ_[2]).toMonoidHom v)) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[2]) 2 σ.toRingEquiv = v⁻¹ :=
  sorry

/-- **Layer 7 acceptance, `χ_cyc(Art(2)) = 1`.** The uniformizer acts trivially on `μ_{2^∞}`. ⚠ It
is not an instance of `cyclotomicCharacter_artinMap`, whose hypothesis is that the argument is a
unit; it is the complementary half of the normalization. -/
example [IsNonarchimedeanLocalField ℚ_[2]] (σ : Field.absoluteGaloisGroup ℚ_[2])
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[2])
      = artinMap ℚ_[2] (Units.mk0 (2 : ℚ_[2]) (by norm_num))) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[2]) 2 σ.toRingEquiv = 1 :=
  sorry

/-! ### Layer 7: the conductor, of an abelian extension and of a character of `Kˣ` -/

/-- **Layer 7, `conductorExponent`**, the conductor exponent `c(L/K)`: the least depth of the unit
filtration inside the norm group. ⚠ The letter `f` keeps its Layer-0 meaning, the residue degree,
and is never reused for a conductor. The definition is total, and the laws that make it the
conductor carry the hypothesis that `L/K` is finite abelian:
`unitFiltration_conductorExponent_le_normGroup` is attainment, and without a depth inside the
norm group the infimum is the junk value `0`. -/
noncomputable def conductorExponent [Algebra K L] [Module.Finite K L] : ℕ :=
  sInf {n : ℕ | unitFiltration K n ≤ normGroup K L}

/-- **Layer 7, `conductorIdeal`**, the conductor ideal `𝔣(L/K) = 𝓂[K]^{c(L/K)}`. It carries no
information beyond the exponent, and exists because the consumers of this milestone multiply
conductors as ideals. -/
noncomputable def conductorIdeal [Algebra K L] [Module.Finite K L] : Ideal ↥𝒪[K] :=
  𝓂[K] ^ conductorExponent K L

/-- **Layer 7, the conductor exponent is attained.** The set of depths inside the norm group is
not empty, because `N_{L/K}Lˣ` is open, so the infimum is a member of it. This is the first half
of the defining property. -/
theorem unitFiltration_conductorExponent_le_normGroup [Algebra K L] [Module.Finite K L]
    [IsGalois K L] (_hab : ∀ σ τ : L ≃ₐ[K] L, σ * τ = τ * σ) :
    unitFiltration K (conductorExponent K L) ≤ normGroup K L :=
  sorry

/-- **Layer 7, the second half of the defining property: minimality.** For a positive conductor
exponent the previous depth is not inside the norm group. It is `Nat.notMem_of_lt_sInf`, and it
is stated because a consumer that has only attainment cannot tell `c` from any larger depth. -/
theorem not_unitFiltration_pred_le_normGroup [Algebra K L] [Module.Finite K L]
    (hc : 0 < conductorExponent K L) :
    ¬ unitFiltration K (conductorExponent K L - 1) ≤ normGroup K L :=
  Nat.notMem_of_lt_sInf (s := {n : ℕ | unitFiltration K n ≤ normGroup K L})
    (Nat.sub_lt hc Nat.one_pos)

/-- **Layer 7, the unramified criterion.** `c(L/K) = 0` exactly when `L/K` is unramified. It is
stated separately from minimality because `U(K,0)` is `𝒪[K]ˣ` and not a congruence subgroup, so
the depth-zero case is the Layer 2 statement that units are norms exactly in the unramified
direction, and not an instance of a general depth argument. -/
theorem conductorExponent_eq_zero_iff [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] (_hab : ∀ σ τ : L ≃ₐ[K] L, σ * τ = τ * σ) :
    conductorExponent K L = 0 ↔ ramificationIndex K L = 1 :=
  sorry

/-- **Layer 7, `characterConductorExp`**, the conductor exponent `a(χ)` of a continuous character
of `Kˣ`: the least depth of the unit filtration inside the kernel. `U(K,0)` is `𝒪[K]ˣ`, so `a(χ)`
is `0` exactly for a character trivial on the units. This is the character-level companion of the
conductor `c(L/K)` of a finite abelian extension, and the two agree when `χ ∘ θ_{L/K}` cuts out
`L`. -/
noncomputable def characterConductorExp (χ : ContinuousMonoidHom Kˣ ℂˣ) : ℕ :=
  sInf {n | ∀ x ∈ unitFiltration K n, χ x = 1}

/-- **Layer 7, the conductor exponent is attained**, so that the definition above names a depth
that really is inside the kernel; minimality is then `Nat.sInf_le`. ⚠ Continuity and the
neighbourhood basis do not suffice on their own. The proof also uses that `ℂˣ` has no small
subgroups, so that the image of `U(K,n)`, being a subgroup inside a small enough ball around `1`,
is trivial. Against a target with small subgroups the set above can be empty and the infimum is
then the junk value `0`: the identity homomorphism of `Kˣ` is continuous and is trivial on no
`U(K,n)`. -/
theorem unitFiltration_characterConductorExp_le_ker (χ : ContinuousMonoidHom Kˣ ℂˣ) :
    unitFiltration K (characterConductorExp K χ) ≤ χ.toMonoidHom.ker :=
  sorry

/-! ### Layer 6: the Tate cup product and Tate–Nakayama

Tate–Nakayama needs cup product with a class of `Ĥ²` acting on `Ĥ^r` for every integer `r`,
including negative `r`. An ordinary cup product does not provide that, and Mathlib has
no Tate cup product, so Layer 6 of this roadmap owns it. It is not a hypothesis, and the laws
below are the roadmap's own targets. -/

variable {G : Type} [Group G] [Fintype G]

/-- **Layer 5, the Tate carrier.** Mathlib's `tateCohomology`, from the class-field-theory
project, postdates the Mathlib this repository currently builds, so this named carrier stands
in its place: `Ĥ^r(G, M)` for every integer `r`, a construction target of Layer 5 like every
other `sorry` here. Every statement below reads through it, and when the repository's Mathlib
includes `tateCohomology`, the replacement is this one definition and its instance. -/
noncomputable def tateH {H : Type} [Group H] [Fintype H] (M : Rep ℤ H) (r : ℤ) : Type :=
  sorry

noncomputable instance {H : Type} [Group H] [Fintype H] (M : Rep ℤ H) (r : ℤ) :
    AddCommGroup (tateH M r) :=
  sorry

/-- **Layer 5, `tateMap`**, coefficient functoriality of the Tate carrier in every integer degree.
Every law below that would otherwise say "there is some additive equivalence" says instead that
*this* map, applied to a named morphism of coefficients, does the job. -/
noncomputable def tateMap {A B : Rep ℤ G} (f : A ⟶ B) (r : ℤ) : tateH A r →+ tateH B r :=
  sorry

/-- **Layer 5.** `tateMap` is the identity on the identity. -/
theorem tateMap_id (A : Rep ℤ G) (r : ℤ) : tateMap (𝟙 A) r = AddMonoidHom.id _ :=
  sorry

/-- **Layer 5.** `tateMap` is functorial. -/
theorem tateMap_comp {A B C : Rep ℤ G} (f : A ⟶ B) (g : B ⟶ C) (r : ℤ) :
    tateMap (f ≫ g) r = (tateMap g r).comp (tateMap f r) :=
  sorry

/-- **Layer 5, `FiniteClassFormation`.** The interface, defined before any instance of it, so
that Layer 5 needs nothing from Layer 6. The data are a distinguished class for every subgroup,
together with restriction and corestriction on `Ĥ²`; the axioms are the five fields of the
roadmap.

⚠ Field `h2_card` reads `Nat.card H`, and never the index `[G : H]`. The trivial subgroup
refutes the index form at once: `Ĥ²(1, M)` has order `1`, while `[G : 1] = Nat.card G`. The
local model is the reason: for `G = Gal(L/K)`, `M = Lˣ`, and `H = Gal(L/E)`, the group
`Ĥ²(H, M)` is `Br(L/E)`, of order `[L : E] = Nat.card H`.

⚠ `res` and `cor` are data here. Pinning them to the restriction and the corestriction of
group cohomology in non-negative degrees is a Layer 6 obligation, and `res_comp_cor` is the one
law that this file states about them. -/
structure FiniteClassFormation (M : Rep ℤ G) where
  /-- The distinguished class of each subgroup. -/
  cls : ∀ (H : Subgroup G) [Fintype H], tateH (Rep.res H.subtype M) 2
  /-- Restriction on `Ĥ²` along `H' ≤ H`. -/
  res : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateH (Rep.res H.subtype M) 2 →+ tateH (Rep.res H'.subtype M) 2
  /-- Corestriction on `Ĥ²` along `H' ≤ H`. -/
  cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateH (Rep.res H'.subtype M) 2 →+ tateH (Rep.res H.subtype M) 2
  /-- Field 1: `H¹(H, M) = 0` for every subgroup. -/
  h1_eq_zero : ∀ (H : Subgroup G) [Fintype H],
    Subsingleton (groupCohomology (Rep.res H.subtype M) 1)
  /-- Field 2, first half: `Ĥ²(H, M)` is generated by the distinguished class. -/
  h2_cyclic : ∀ (H : Subgroup G) [Fintype H] (x : tateH (Rep.res H.subtype M) 2),
    ∃ m : ℤ, x = m • cls H
  /-- Field 2, second half: its order is `Nat.card H`, and not the index `[G : H]`. -/
  h2_card : ∀ (H : Subgroup G) [Fintype H],
    Nat.card (tateH (Rep.res H.subtype M) 2) = Nat.card H
  /-- Fields 3 and 4: restriction sends a distinguished class to a distinguished class, which
  covers `res^G_H σ_G = σ_H` at `H = ⊤` and the tower case `H' ≤ H` at once. -/
  res_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    res H H' h (cls H) = cls H'
  /-- Field 5: corestriction multiplies the distinguished class by the index. -/
  cor_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    cor H H' h (cls H') = ((H'.subgroupOf H).index : ℤ) • cls H
  /-- The one law relating the two maps: `cor ∘ res` is multiplication by the index. -/
  res_comp_cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H)
    (x : tateH (Rep.res H.subtype M) 2),
    cor H H' h (res H H' h x) = ((H'.subgroupOf H).index : ℤ) • x

/-- **Layer 5, restriction of a class formation to a subgroup.** The five fields of `H ≤ G`
restrict to the five fields of `H' ≤ H`, so a class formation on `G` is one on every subgroup. -/
noncomputable def FiniteClassFormation.restrict {M : Rep ℤ G} (_fcf : FiniteClassFormation M)
    (H : Subgroup G) [Fintype H] : FiniteClassFormation (Rep.res H.subtype M) :=
  sorry

/-- The top subgroup of a finite group is finite. Named, because `fcf.cls ⊤` and the transport
below both need it. -/
noncomputable instance instFintypeTopSubgroup : Fintype (⊤ : Subgroup G) := Fintype.ofFinite _

/-- **Layer 5, the top-subgroup transport.** `Rep.res (⊤ : Subgroup G).subtype M` and `M` are
representations of two different Lean groups, so their Tate cohomologies are related by a named
equivalence and not by an equality. -/
noncomputable def tateHTopEquiv (M : Rep ℤ G) (r : ℤ) :
    tateH (Rep.res (⊤ : Subgroup G).subtype M) r ≃+ tateH M r :=
  sorry

/-- **Layer 5, the transport in a tower.** For `H' ≤ H ≤ G`, restricting twice and restricting
once along the image agree, up to this named equivalence. -/
noncomputable def tateHTowerEquiv (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (H' : Subgroup H)
    [Fintype H'] [Fintype (H'.map H.subtype)] (r : ℤ) :
    tateH (Rep.res H'.subtype (Rep.res H.subtype M)) r
      ≃+ tateH (Rep.res (H'.map H.subtype).subtype M) r :=
  sorry

/-- **Layer 5, the distinguished class of the whole group,** transported to `M` itself. This is
the class that the top-group form of Tate–Nakayama and finite-level reciprocity use, and it is
`fcf.cls ⊤` and nothing else. -/
noncomputable def FiniteClassFormation.topClass {M : Rep ℤ G} (fcf : FiniteClassFormation M) :
    tateH M 2 :=
  tateHTopEquiv M 2 (fcf.cls ⊤)

/-- **Layer 5, tower compatibility of the distinguished classes.** The class that the restricted
formation assigns to `H' ≤ H` is the class that `fcf` assigns to the image of `H'` in `G`. -/
theorem FiniteClassFormation.restrict_cls {M : Rep ℤ G} (fcf : FiniteClassFormation M)
    (H : Subgroup G) [Fintype H] (H' : Subgroup H) [Fintype H'] [Fintype (H'.map H.subtype)] :
    tateHTowerEquiv M H H' 2 ((fcf.restrict H).cls H') = fcf.cls (H'.map H.subtype) :=
  sorry

/-- **Layer 6**, the Tate cup product in all integer bidegrees. The target degree is an argument
together with its defining equation, so that no statement below has to compare `(r + s) + t` with
`r + (s + t)`, which are equal in `ℤ` by a theorem and not by `rfl`.

⚠ A family of additive maps `Ĥ^r(G, ℤ) → Ĥ^{r+2}(G, M)` of the right type is not a cup product,
and supports no part of Tate–Nakayama. The laws below are what make this family usable. -/
noncomputable def tateCup (A B : Rep ℤ G) (r s t : ℤ) (_h : r + s = t) :
    tateH A r →+ tateH B s →+ tateH (A ⊗ B) t :=
  sorry

/-- **Layer 6, associativity**, through `tateMap` of the canonical associator of `Rep ℤ G`. ⚠ "There
is an additive equivalence carrying one side to the other" is too weak to be the cup-product law:
it does not say which equivalence, and the associator is the only one that makes the statement a
theorem about coefficients. -/
theorem tateCup_assoc (A B C : Rep ℤ G) (r s t w : ℤ) (h : r + s + t = w)
    (x : tateH A r) (y : tateH B s) (z : tateH C t) :
    tateMap (α_ A B C).hom w
        (tateCup (A ⊗ B) C (r + s) t w h (tateCup A B r s (r + s) rfl x y) z)
      = tateCup A (B ⊗ C) r (s + t) w (by omega) x (tateCup B C s t (s + t) rfl y z) :=
  sorry

/-- **Layer 6, graded commutativity**, through `tateMap` of the canonical braiding of `Rep ℤ G`,
with the Koszul sign `(−1)^{rs}`. -/
theorem tateCup_comm (A B : Rep ℤ G) (r s t : ℤ) (h : r + s = t) (h' : s + r = t)
    (x : tateH A r) (y : tateH B s) :
    tateMap (β_ B A).hom t (tateCup B A s r t h' y x)
      = ((-1 : ℤ) ^ (r * s).natAbs) • tateCup A B r s t h x y :=
  sorry

/-- **Layer 6, the ordinary cup product of a finite group**, on Mathlib's `groupCohomology`.
Mathlib has none, and the Profinite Cohomology roadmap's `cup` is on the continuous carrier, so
this is a milestone here; `ordinaryCup_explicitCup11` below is what stops it from being a second,
unrelated product. -/
noncomputable def ordinaryCup (A B : Rep ℤ G) (m k : ℕ) :
    groupCohomology A m →+ groupCohomology B k →+ groupCohomology (A ⊗ B) (m + k) :=
  sorry

/-- **Layer 6, `ordinaryToTate`**, the comparison from ordinary to Tate cohomology in
non-negative degrees. It is a named map and never a parameter: with an arbitrary map of this type,
`0` would satisfy every comparison statement below. -/
noncomputable def ordinaryToTate (A : Rep ℤ G) (n : ℕ) : groupCohomology A n →+ tateH A (n : ℤ) :=
  sorry

/-- **Layer 6.** `ordinaryToTate` is natural in the coefficients, against `tateMap` and Mathlib's
`groupCohomology.map` at the identity of the group. -/
theorem tateMap_ordinaryToTate {A B : Rep ℤ G} (f : A ⟶ B) (n : ℕ) (x : groupCohomology A n) :
    tateMap f (n : ℤ) (ordinaryToTate A n x)
      = ordinaryToTate B n ((groupCohomology.map (MonoidHom.id G) f n).hom x) :=
  sorry

/-- **Layer 6, agreement with the ordinary cup product in non-negative degrees.** Both the product
and the comparison are the named declarations above, so the zero map is not a model of this
statement. -/
theorem tateCup_agrees_ordinary (A B : Rep ℤ G) (i j : ℕ)
    (x : groupCohomology A i) (y : groupCohomology B j) :
    ordinaryToTate (A ⊗ B) (i + j) (ordinaryCup A B i j x y)
      = tateCup A B (i : ℤ) (j : ℤ) ((i + j : ℕ) : ℤ) (by push_cast; ring)
          (ordinaryToTate A i x) (ordinaryToTate B j y) :=
  sorry

/-- **Layer 6, restriction on the Tate carrier**, in every integer degree. -/
noncomputable def tateRes (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (r : ℤ) :
    tateH M r →+ tateH (Rep.res H.subtype M) r :=
  sorry

/-- **Layer 6, corestriction on the Tate carrier**, in every integer degree. ⚠ Mathlib has no
corestriction for group cohomology; the corestriction of `GroupHomology/Functoriality.lean` is a
map for group *homology*, which is a different map. -/
noncomputable def tateCor (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (r : ℤ) :
    tateH (Rep.res H.subtype M) r →+ tateH M r :=
  sorry

/-- **Layer 6.** `cor ∘ res` is multiplication by the index. -/
theorem tateCor_comp_tateRes (M : Rep ℤ G) (H : Subgroup G) [Fintype H] (r : ℤ) (x : tateH M r) :
    tateCor M H r (tateRes M H r x) = (H.index : ℤ) • x :=
  sorry

/-- **Layer 6, the projection formula** `cor (res x ⌣ y) = x ⌣ cor y`, which is what makes the
pair `(tateRes, tateCor)` interact with `tateCup` rather than merely coexist with it. -/
theorem tateCup_projection (A B : Rep ℤ G) (H : Subgroup G) [Fintype H] (r s t : ℤ)
    (h : r + s = t) (x : tateH A r) (y : tateH (Rep.res H.subtype B) s) :
    tateCor (A ⊗ B) H t
        (tateCup (Rep.res H.subtype A) (Rep.res H.subtype B) r s t h (tateRes A H r x) y)
      = tateCup A B r s t h x (tateCor B H s y) :=
  sorry

/-- **Layer 6.** `tateMap` commutes with restriction. -/
theorem tateMap_tateRes {A B : Rep ℤ G} (f : A ⟶ B) (H : Subgroup G) [Fintype H] (r : ℤ)
    (x : tateH A r) :
    tateMap ((Rep.resFunctor H.subtype).map f) r (tateRes A H r x)
      = tateRes B H r (tateMap f r x) :=
  sorry

/-- **Layer 6, inflation on the Tate carrier**, in degrees `≥ 1`. ⚠ The restriction to positive
degrees is part of the statement: in degree `0` and below, inflation from the quotient is not
defined on Tate cohomology, because `Ĥ⁰` is a quotient by the norm and not the invariants. -/
noncomputable def tateInfl (M : Rep ℤ G) (N : Subgroup G) [N.Normal] [Fintype (G ⧸ N)] (n : ℕ)
    (_hn : 1 ≤ n) : tateH (M.quotientToInvariants N) (n : ℤ) →+ tateH M (n : ℤ) :=
  sorry

/-- **Layer 6, inflation on ordinary cohomology.** Mathlib's `groupCohomology.map` at the
projection `G ⟶ G ⧸ N` and the inclusion of the `N`-invariants, named once so that the
compatibility below is a statement about two named maps. This one has a body and no `sorry`. -/
noncomputable def ordinaryInfl (M : Rep ℤ G) (N : Subgroup G) [N.Normal] (n : ℕ) :
    groupCohomology (M.quotientToInvariants N) n →+ groupCohomology M n :=
  letI : Module ℤ M.V := M.hV2
  letI : Module ℤ (M.quotientToInvariants N).V := (M.quotientToInvariants N).hV2
  (groupCohomology.map (QuotientGroup.mk' N)
    (Rep.ofHom (M.ρ.quotientToInvariants_lift N)) n).hom.toAddMonoidHom

/-- **Layer 6.** Inflation on the Tate carrier is the inflation of ordinary cohomology, read
through `ordinaryToTate` on both sides. This is what ties `tateInfl` to Mathlib's finite-level
inflation instead of leaving it a map of the right type. -/
theorem tateInfl_ordinaryToTate (M : Rep ℤ G) (N : Subgroup G) [N.Normal] [Fintype (G ⧸ N)]
    (n : ℕ) (hn : 1 ≤ n) (x : groupCohomology (M.quotientToInvariants N) n) :
    tateInfl M N n hn (ordinaryToTate (M.quotientToInvariants N) n x)
      = ordinaryToTate M n (ordinaryInfl M N n x) :=
  sorry

/-- **Layer 6, the comparison with group homology in negative degrees**, `Ĥ^{−n−1}(G, M) ≅ H_n(G, M)`
for `n ≥ 1`. This is the half of the Tate carrier that the ordinary theory does not see. -/
noncomputable def tateHNegEquivGroupHomology (M : Rep ℤ G) (n : ℕ) (_hn : 1 ≤ n) :
    tateH M (-(n : ℤ) - 1) ≃+ groupHomology M n :=
  sorry

/-- **Layer 6, the Schur-multiplier instance** of the comparison above: `Ĥ^{−3}(G, ℤ) ≅ H₂(G, ℤ)`.
Named, because it is the instance downstream statements about the Schur multiplier cite. -/
noncomputable def tateHNegThreeEquivSchurMultiplier (G : Type) [Group G] [Fintype G] :
    tateH (Rep.trivial ℤ G ℤ) (-3) ≃+ groupHomology (Rep.trivial ℤ G ℤ) 2 :=
  sorry

/-- **Layer 6, periodicity for a finite cyclic group**: `Ĥ^r(G, M) ≅ Ĥ^{r+2}(G, M)` for every
integer `r`. This is what makes the Herbrand quotient below well defined in all degrees. -/
noncomputable def tatePeriodicity (M : Rep ℤ G) (_hG : IsCyclic G) (r : ℤ) :
    tateH M r ≃+ tateH M (r + 2) :=
  sorry

/-- **Layer 6, the Sylow injection.** Restriction to a pro-`p` Sylow subgroup is injective on the
`p`-primary component, written pointwise so that no `p`-primary-component object is needed: an
element killed by a power of `p` whose restriction vanishes is zero. The proof is
`tateCor_comp_tateRes` together with the index of a Sylow subgroup being prime to `p`. -/
theorem eq_zero_of_tateRes_sylow_eq_zero (p : ℕ) [Fact p.Prime] (M : Rep ℤ G) (P : Sylow p G)
    [Fintype (P : Subgroup G)] (r : ℤ) (x : tateH M r) (k : ℕ) (_hx : (p ^ k : ℤ) • x = 0)
    (_hres : tateRes M (P : Subgroup G) r x = 0) :
    x = 0 :=
  sorry

/-- **Layer 5, the Herbrand quotient** of a finite cyclic group, `#Ĥ⁰ / #Ĥ¹`. This is a real
definition and not a placeholder; the milestones are the laws about it. ⚠ `Nat.card` is `0` on an
infinite type, so every statement about the value carries the finiteness it needs. -/
noncomputable def herbrandQuotient (M : Rep ℤ G) : ℚ :=
  (Nat.card (tateH M 0) : ℚ) / (Nat.card (tateH M 1) : ℚ)

/-- **Layer 5, invariance of the Herbrand quotient** under an equivariant map with finite kernel
and finite cokernel. This is the form the two local computations use, and it is what makes the
lattice argument work: an open `G`-stable sublattice of `𝒪[L]` differs from `𝒪[L]` by finite
kernel and cokernel, so the two quotients agree. -/
theorem herbrandQuotient_of_finite_ker_coker {M N : Rep ℤ G} (_hG : IsCyclic G) (f : M ⟶ N)
    (_hker : Finite (CategoryTheory.Limits.kernel f).V)
    (_hcoker : Finite (CategoryTheory.Limits.cokernel f).V) :
    herbrandQuotient M = herbrandQuotient N :=
  sorry

/-- **Layer 6**, cup product with a distinguished class of `Ĥ²`, in every integer degree,
**defined from** `tateCup` and never independently of it, and with the coefficient identification
`M ⊗ ℤ ≅ M` supplied by `tateMap` of the canonical right unitor of `Rep ℤ G` rather than by a
quantified family of equivalences. This is the map that Tate–Nakayama inverts. -/
noncomputable def tateCupSigma (M : Rep ℤ G) (cls : tateH M 2) (r : ℤ) :
    tateH (Rep.trivial ℤ G ℤ) r →+ tateH M (2 + r) where
  toFun x := tateMap (ρ_ M).hom (2 + r) (tateCup M (Rep.trivial ℤ G ℤ) 2 r (2 + r) rfl cls x)
  map_zero' := by simp
  map_add' x y := by simp

/-- **Layer 6, Tate–Nakayama**, subgroup-wise. Cup product with the distinguished class **of the
class formation** is an isomorphism in every integer degree, for every subgroup. ⚠ There is no
free class parameter: at `σ = 0` the map is zero, so a statement quantified over an arbitrary
class of `Ĥ²` is false. The class is `fcf.cls H`, and the class-formation argument is used. -/
theorem tateNakayama (M : Rep ℤ G) (fcf : FiniteClassFormation M) (H : Subgroup G) [Fintype H]
    (r : ℤ) :
    Function.Bijective (tateCupSigma (Rep.res H.subtype M) (fcf.cls H) r) :=
  sorry

/-- **Layer 6, the top-group corollary**, at the transported distinguished class of the whole
group. This is the form that finite-level reciprocity cites, at `r = −2`. -/
theorem tateNakayama_top (M : Rep ℤ G) (fcf : FiniteClassFormation M) (r : ℤ) :
    Function.Bijective (tateCupSigma M fcf.topClass r) :=
  sorry

/-- **Layer 6, the trivial `ℚ/ℤ`-module**, the value object of finite-group Tate duality. -/
noncomputable def tateQZ (G : Type) [Group G] [Fintype G] : Rep ℤ G :=
  Rep.trivial ℤ G (ℚ ⧸ AddSubgroup.zmultiples (1 : ℚ))

/-- **Layer 6, the Pontryagin dual** `A^D = Hom(A, ℚ/ℤ)` with the contragredient action. -/
noncomputable def tatePontryaginDual (A : Rep ℤ G) : Rep ℤ G :=
  sorry

/-- **Layer 6, the evaluation morphism** `A ⊗ A^D ⟶ ℚ/ℤ`, whose equivariance is what makes the
duality pairing land in `Ĥ^{−1}(G, ℚ/ℤ)`. -/
noncomputable def tateEvaluation (A : Rep ℤ G) : A ⊗ tatePontryaginDual A ⟶ tateQZ G :=
  sorry

/-- **Layer 6, the value isomorphism** `Ĥ^{−1}(G, ℚ/ℤ) ≅ ZMod (Nat.card G)`. -/
noncomputable def tateValueEquiv (G : Type) [Group G] [Fintype G] :
    tateH (tateQZ G) (-1) ≃+ ZMod (Nat.card G) :=
  sorry

/-- **Layer 6, duality for Tate cohomology of a finite group.** Cup product against the dual
`A^D = Hom(A, ℚ/ℤ)` is a perfect pairing of finite groups, in every integer degree with
`r + s = −1`. Perfectness is written without bundling: no left kernel, and every additive
functional represented.

⚠ The statement quantifies only over `A` and the two degrees. The dual, the evaluation morphism,
and the value isomorphism are the named canonical objects above; with an arbitrary evaluation the
zero map would be a countermodel.

This theorem uses no class formation, and its home is the class-formation directory of Layer 6.
⚠ Layer 8 does not obtain local duality from it by a formal step: the local dual is
`Hom(M, μ_n)`, and the two agree only when the field contains `μ_n`. -/
theorem tateDuality_finiteGroup (A : Rep ℤ G) (r s : ℤ) (h : r + s = -1)
    (_hfinA : Finite (tateH A r)) (_hfinAD : Finite (tateH (tatePontryaginDual A) s)) :
    (∀ x : tateH A r,
        (∀ y : tateH (tatePontryaginDual A) s,
          tateValueEquiv G (tateMap (tateEvaluation A) (-1)
            (tateCup A (tatePontryaginDual A) r s (-1) h x y)) = 0) → x = 0) ∧
      (∀ φ : tateH (tatePontryaginDual A) s →+ ZMod (Nat.card G), ∃ x : tateH A r,
        ∀ y : tateH (tatePontryaginDual A) s,
          tateValueEquiv G (tateMap (tateEvaluation A) (-1)
            (tateCup A (tatePontryaginDual A) r s (-1) h x y)) = φ y) :=
  sorry

/-! ### Layer 6: the comparison of the ordinary cup product with the supplier's

`ordinaryCup` is on Mathlib's `groupCohomology` of a finite group, and
`ProfiniteCohomology.explicitCup11` is on the supplier's explicit low-degree model of a profinite
group. Giving the finite group its discrete topology makes both available, and the theorem below
is the statement that they are the same product. Without it the roadmap would carry a second,
unrelated cup product. -/

section OrdinaryCupComparison

variable (G) [TopologicalSpace G] [IsTopologicalGroup G] [DiscreteTopology G]
  (M N P : Type) [AddCommGroup M] [TopologicalSpace M] [IsTopologicalAddGroup M]
  [DiscreteTopology M] [DistribMulAction G M] [ContinuousSMul G M] [SMulCommClass G ℤ M]
  [AddCommGroup N] [TopologicalSpace N] [IsTopologicalAddGroup N]
  [DiscreteTopology N] [DistribMulAction G N] [ContinuousSMul G N] [SMulCommClass G ℤ N]
  [AddCommGroup P] [TopologicalSpace P] [IsTopologicalAddGroup P]
  [DiscreteTopology P] [DistribMulAction G P] [ContinuousSMul G P] [SMulCommClass G ℤ P]

/-- **Layer 6, the coefficient pairing of `Rep ℤ G` induced by an equivariant biadditive map.**
The `Rep`-level counterpart of `ProfiniteCohomology.ofDiscreteModulePairing`, so that the two
sides of the comparison below carry the same coefficient datum and neither is arbitrary. -/
noncomputable def repPairingOfDistribMulAction (μ : M →+ N →+ P)
    (_hequiv : ∀ (g : G) (a : M) (b : N), μ (g • a) (g • b) = g • μ a b) :
    Rep.ofDistribMulAction ℤ G M ⊗ Rep.ofDistribMulAction ℤ G N ⟶ Rep.ofDistribMulAction ℤ G P :=
  sorry

/-- **Layer 6, `ordinaryCup` is the supplier's cup product.** In bidegree `(1,1)`, under the
supplier's Layer 3 comparisons `explicitH1IsoGroupCohomology` and `explicitH2IsoGroupCohomology`,
`ordinaryCup` followed by the coefficient pairing is `ProfiniteCohomology.explicitCup11`. With
`ProfiniteCohomology.explicitIso_cup` this also identifies it with the all-degree
`ProfiniteCohomology.cup`. -/
theorem ordinaryCup_explicitCup11 (μ : M →+ N →+ P)
    (hμ : Continuous fun q : M × N => μ q.1 q.2)
    (hequiv : ∀ (g : G) (a : M) (b : N), μ (g • a) (g • b) = g • μ a b)
    (x : ProfiniteCohomology.H1 G M) (y : ProfiniteCohomology.H1 G N) :
    (groupCohomology.map (MonoidHom.id G) (repPairingOfDistribMulAction G M N P μ hequiv) 2).hom
        (ordinaryCup _ _ 1 1 (ProfiniteCohomology.explicitH1IsoGroupCohomology G M x)
          (ProfiniteCohomology.explicitH1IsoGroupCohomology G N y))
      = ProfiniteCohomology.explicitH2IsoGroupCohomology G P
          (ProfiniteCohomology.explicitCup11 G M N P μ hμ hequiv x y) :=
  sorry

end OrdinaryCupComparison

/-- **Layer 9, the exact rank of the full absolute Galois group, against the two bundles:**
`d(G_F) = [F : ℚ_p] + 2`, stated as leastness of `[F : ℚ_p] + 2` among the cardinalities of
topologically generating finite sets. The upper bound is NSW VII §4. The lower bound uses the rank
of the maximal pro-`p` quotient, which is `ProPRankInputs`, together with the Schreier bound of
`ProPOps`; the equality is Jarden–Shusterman Thm. 2.1.

⚠ The familiar `[F : ℚ_p] + 1` count is a statement about `G_F(p)`, which is free pro-`p` of
that rank when `μ_p ⊄ F`, and never about `G_F`: the full group has rank `[F : ℚ_p] + 2` in both
cases. -/
theorem rank_absoluteGaloisGroup_of_inputs (p : ℕ) [Fact p.Prime] (_ops : ProPOps.{u} p)
    (_inp : ProPRankInputs.{u} p) (F : Type u) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    IsLeast
      {m : ℕ | ∃ s : Finset (Field.absoluteGaloisGroup F), s.card = m ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤}
      (Module.finrank ℚ_[p] F + 2) :=
  sorry

/-- **Layer 9, the exact rank of the full absolute Galois group.** The public form: no structure
arguments, obtained from the theorem above by instantiation at the canonical terms
`Supplied.proPOps` and `Supplied.proPRankInputs` that the pro-`p` supplier constructs. This proof
is a term and not a `sorry`, so the advertised unconditional theorem is exactly as strong as the
conditional one plus those two terms, and no downstream consumer is left holding a structure for
which nothing constructs an instance. -/
theorem rank_absoluteGaloisGroup (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    IsLeast
      {m : ℕ | ∃ s : Finset (Field.absoluteGaloisGroup F), s.card = m ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤}
      (Module.finrank ℚ_[p] F + 2) :=
  rank_absoluteGaloisGroup_of_inputs p (Supplied.proPOps.{u} p) (Supplied.proPRankInputs.{u} p) F

end Deliverables

end TauCetiRoadmap.LocalFields
