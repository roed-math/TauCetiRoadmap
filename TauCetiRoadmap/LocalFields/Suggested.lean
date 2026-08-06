import Mathlib

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

This file holds targets from the **cohomology-free early layers** (Layers 0–2, with worked
examples reaching into the acceptance criteria of Layers 7–9), stated with `sorry` against
the pinned Mathlib. Per the honest-`sorry` rule, milestones whose *statements* need API that
does not exist at the pin are **not** stated here and live in `README.md` only: the
lower/upper ramification filtration and Herbrand functions (Layer 3), the tame quotient and
its Iwasawa presentation (Layer 4 — needs presented profinite groups), and everything
cohomological (Layers 5–8: invariant map, class formations, reciprocity, duality, Euler
characteristic — these consume PR #1 Profinite Cohomology). Power classes and Layer 8 are
split into the two regimes of the roadmap's standing hypotheses; `p`-power coefficients in
equal characteristic are outside the roadmap, and no statement here is to be generalized to
cover them. As later layers make their types expressible in `TauCeti/`, add their milestones
here with `sorry`.

Definitions carrying a `sorry` body (`normalizedValuation`, `ramificationIndex`,
`inertiaDegree`, `teichmuller`, `unitFiltration`) are suggested *names and types* for objects
the roadmap asks for, together with the characteristic lemmas that pin them down. They are
placeholders for data whose type is already expressible, never for a condition we cannot
state.
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

/-- **Layer 1, reduction is surjective on units** — the depth-`0` graded piece
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
the pro-`p` vocabulary being PR #3 Layer 3's.) -/
example (π : 𝒪[K]) (_hπ : Irreducible π) (x : Kˣ) :
    ∃! p : ℤ × (↥𝒪[K])ˣ, (x : K) = (π : K) ^ p.1 * ((p.2 : ↥𝒪[K]) : K) :=
  sorry

/-- **Layer 1, power classes in the prime-to-residue-characteristic regime.** If `n` is a unit
in the valuation ring, the count is exact and holds in either characteristic: the factor
`q ^ v_K(n)` of the general formula is `1`, which is where the hypothesis is used. -/
example (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Nat.card (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range)
      = n * Nat.card (rootsOfUnity n K) :=
  sorry

/-- **Layer 1, power classes in the mixed-characteristic regime.** For `K/ℚ_p` finite the same
formula holds for every `n ≠ 0`, including `p ∣ n`, with the extra factor
`q ^ v_K(n) = ‖n‖_K⁻¹` written here as the (finite) cardinality of `𝒪[K]/n𝒪[K]`, which avoids
an integer-to-natural coercion. ⚠ This must not be generalized to equal characteristic: at
`K = 𝔽_q((t))` and `n = p` the left-hand side is infinite. -/
example (p : ℕ) [Fact p.Prime] [Algebra ℚ_[p] K] [Module.Finite ℚ_[p] K]
    (n : ℕ) (_hn : n ≠ 0) :
    Nat.card (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range)
      = n * Nat.card (rootsOfUnity n K)
        * Nat.card (↥𝒪[K] ⧸ Ideal.span {(n : ↥𝒪[K])}) :=
  sorry

/-- **Layer 1, worked example: `ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (the classes of `−1, 2, 5`
generate). The odd-`p` count is `4`; this factor-of-two dyadic difference is why no layer may
assume `p ≠ 2`. -/
example : Nat.card (ℚ_[2]ˣ ⧸ (powMonoidHom 2 : ℚ_[2]ˣ →* ℚ_[2]ˣ).range) = 8 :=
  sorry

/-- **Layer 1, worked example: the dyadic deep-square bound.** Units of `ℤ_2` congruent to
`1 mod 8` are squares (`U(K, 2e+1) ⊆ (Kˣ)²` at `K = ℚ_2`, `e = 1`; the threshold is sharp). -/
example (u : ℤ_[2]ˣ) (_hu : (8 : ℤ_[2]) ∣ ((u : ℤ_[2]) - 1)) : IsSquare u :=
  sorry

/-! ## Layer 2: unramified extensions and Frobenius -/

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

The reciprocity map, norm groups, regime-correct duality, and the Euler characteristic are
README-only (they consume PR #1). Three mixed-characteristic `ℚ_2` consequences are already
stateable and serve as end-to-end acceptance targets. -/

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

/-- **Layer 8 acceptance, the Hilbert-symbol entry `(−1,−1)_2 = −1`.** `−1` is not a sum of
two squares in `ℚ_2`: through the Kummer identification, the mod-2 duality pairing is the
classical Hilbert symbol (the named theorem shared with the QuadraticFormInvariants roadmap),
and it is nontrivial at `(−1, −1)`. -/
example : ¬ ∃ x y : ℚ_[2], (-1 : ℚ_[2]) = x ^ 2 + y ^ 2 :=
  sorry

/-! ## Layer 9: topological finite generation -/

/-- **Layer 9, the exact rank of the full absolute Galois group:**
`d(G_F) = [F : ℚ_p] + 2`, stated as leastness of `[F : ℚ_p] + 2` among the cardinalities of
topologically generating finite sets (`d` itself is PR #3 Layer 3's definition). The upper
bound is NSW VII §4; the lower bound comes from the rank of the maximal pro-`p` quotient
together with the Schreier bound, and the equality is Jarden–Shusterman Thm. 2.1.

⚠ The familiar `[F : ℚ_p] + 1` count is a statement about the maximal pro-`p` quotient
`G_F(p)`, which is free pro-`p` of that rank when `μ_p ⊄ F` (PR #3 Layer 11), and never about
`G_F`: the full group has rank `[F : ℚ_p] + 2` in both cases. The bare finite-generation
corollary at `F = ℚ_2`, namely generation by 3 elements, is gq2's B1. -/
example (p : ℕ) [Fact p.Prime] (F : Type*) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    IsLeast
      {n : ℕ | ∃ s : Finset (Field.absoluteGaloisGroup F), s.card = n ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤}
      (Module.finrank ℚ_[p] F + 2) :=
  sorry

end TauCetiRoadmap.LocalFields
