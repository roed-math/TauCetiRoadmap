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

This file holds targets from Layers 0 to 2, the worked examples that reach into the
acceptance criteria of Layers 7 to 9, and the interface section below. Power classes and
Layer 8 are split into the two regimes of the roadmap's standing hypotheses. `p`-power
coefficients in equal characteristic are outside the roadmap, and no statement here is to be
generalized to cover them. The same boundary cuts Layer 7: the existence theorem is a
milestone away from the residue characteristic for a general local field, and in full only
for `K` a finite extension of `ℚ_p`. So anything derived from full existence, such as
injectivity of the Artin map or the ordinary profinite completion of `Kˣ`, is
mixed-characteristic.

Definitions with a `sorry` body (`normalizedValuation`, `ramificationIndex`,
`inertiaDegree`, `teichmuller`, `unitFiltration`, and the interface section) are suggested
*names and types* for objects the roadmap asks for, together with the characteristic lemmas
that fix them. They are placeholders for data whose type is expressible now, and never for a
condition we cannot state.

## The interface section

Section `Interface` below carries one declaration for each object that another Tau Ceti
roadmap owns, in the name that the shared interface table of `README.md` fixes. Some are real
definitions, and some are placeholders for data. The purpose is that every statement which
crosses a roadmap boundary elaborates here, rather than sitting in prose. When the other
roadmap supplies the object, delete the declaration here and import theirs: the statements
that use it do not change.
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
the pro-`p` vocabulary being PR #3 Layer 3's `IsProP`.) -/
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
topologically generating finite sets. The rank `d` itself is `Interface.topologicalRank`
below, which the Pro-`p` Groups roadmap owns. The upper bound is NSW VII §4. The lower bound
uses the rank of the maximal pro-`p` quotient and the Schreier bound, and the equality is
Jarden–Shusterman Thm. 2.1.

⚠ The familiar `[F : ℚ_p] + 1` count is a statement about the maximal pro-`p` quotient
`G_F(p)`, which is free pro-`p` of that rank when `μ_p ⊄ F`, and never about `G_F`: the full
group has rank `[F : ℚ_p] + 2` in both cases. The finite-generation corollary at `F = ℚ_2`,
namely generation by 3 elements, is the label `B1` of the downstream table. -/
example (p : ℕ) [Fact p.Prime] (F : Type*) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    IsLeast
      {n : ℕ | ∃ s : Finset (Field.absoluteGaloisGroup F), s.card = n ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤}
      (Module.finrank ℚ_[p] F + 2) :=
  sorry

/-! ## Interface: objects owned by a sibling roadmap

One declaration per row of the two contract tables of `README.md`, under the name that the table
fixes. The declarations of the Pro-`p` Groups roadmap are copied with their statements, so that
replacement is a deletion plus an import: a local declaration with the same English description
and a different Lean type is not an interface. Continuous cohomology is Mathlib's
`continuousCohomology`, on the bundled topological representation `TopRep`, which carries the
discrete topology and the continuous action that the coefficients must have.
-/

namespace Interface

open CategoryTheory

/-! ### Pro-`p` Groups roadmap, Layers 2, 3, 4, and 11 -/

variable (p : ℕ)

/-- **Layer 3, `IsProP`**, in quotient form: every continuous finite quotient is a `p`-group. -/
def IsProP (G : Type u) [Group G] [TopologicalSpace G] : Prop :=
  ∀ U : OpenNormalSubgroup G, IsPGroup p (G ⧸ U.toSubgroup)

/-- **Layer 3, `IsTopologicallyFinitelyGenerated`**, in the fixed shape. -/
def IsTopologicallyFinitelyGenerated (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Prop :=
  ∃ s : Finset G, (Subgroup.closure (s : Set G)).topologicalClosure = ⊤

/-- **Layer 3, `ConvergesToOne`**: every open normal subgroup omits only finitely many elements
of the set. The cardinal rank is an infimum over sets with this property. -/
def ConvergesToOne {G : Type u} [Group G] [TopologicalSpace G] (s : Set G) : Prop :=
  ∀ U : OpenNormalSubgroup G, {x ∈ s | x ∉ U.toSubgroup}.Finite

/-- **Layer 3, `topologicalGeneratorRank`**, cardinal-valued. ⚠ Dropping `ConvergesToOne`
changes the invariant, so the two rank objects are kept apart. -/
noncomputable def topologicalGeneratorRank (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Cardinal.{u} :=
  ⨅ s : {s : Set G // ConvergesToOne s ∧ (Subgroup.closure s).topologicalClosure = ⊤},
    Cardinal.mk ↥s.1

/-- **Layer 3, `topologicalGeneratorRankNat`**: the natural-number accessor, available exactly
when the group is topologically finitely generated. Every numerical statement, including the
rank theorem of Layer 9, is about this declaration. ⚠ A total `ℕ`-valued rank would report `0`
for a group with no finite generating set, which is why the proof is an argument here. -/
noncomputable def topologicalGeneratorRankNat (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (_h : IsTopologicallyFinitelyGenerated G) : ℕ :=
  sInf {n : ℕ | ∃ s : Finset G,
    s.card = n ∧ (Subgroup.closure (s : Set G)).topologicalClosure = ⊤}

/-- **Layer 3, `proPKernel`**: the intersection of the open normal subgroups with `p`-group
quotient. -/
def proPKernel (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // IsPGroup p (G ⧸ U.toSubgroup)}, U.1.toSubgroup

instance proPKernel_normal (G : Type u) [Group G] [TopologicalSpace G] :
    (proPKernel p G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-- **Layer 3, `maximalProPQuotient`**, that is `G(p)`. -/
abbrev maximalProPQuotient (G : Type u) [Group G] [TopologicalSpace G] : Type u :=
  G ⧸ proPKernel p G

/-- **Layer 11, `absoluteGaloisGroupProP`**, that is `G_F(p)`, as the maximal pro-`p` quotient
of the absolute Galois group. Layer 9 cites this carrier, and does not re-form the quotient. -/
abbrev absoluteGaloisGroupProP (F : Type u) [Field F] : Type u :=
  maximalProPQuotient p (Field.absoluteGaloisGroup F)

/-- **Layer 2, `IsProPSylow`**: a closed pro-`p` subgroup whose image in every continuous finite
quotient has index prime to `p`. ⚠ Maximality among closed pro-`p` subgroups is equivalent, but
that equivalence is a theorem of Sylow theory, and not the definition. -/
def IsProPSylow {G : Type u} [Group G] [TopologicalSpace G] (P : Subgroup G) : Prop :=
  IsClosed (P : Set G) ∧ IsProP p P ∧
    ∀ U : OpenNormalSubgroup G, ¬ p ∣ (P.map (QuotientGroup.mk' U.toSubgroup)).index

/-- **Layer 2, `exists_isProPSylow`**: a profinite group has a pro-`p` Sylow subgroup. -/
theorem exists_isProPSylow (G : Type u) [Group G] [TopologicalSpace G] [CompactSpace G]
    [TotallyDisconnectedSpace G] : ∃ P : Subgroup G, IsProPSylow p P := sorry

/-- **Layer 2, `IsProP.exists_le_isProPSylow`**: every closed pro-`p` subgroup lies in one. -/
theorem IsProP.exists_le_isProPSylow {G : Type u} [Group G] [TopologicalSpace G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {Q : Subgroup G} (_hQ : IsProP p Q)
    (_hcl : IsClosed (Q : Set G)) : ∃ P : Subgroup G, IsProPSylow p P ∧ Q ≤ P := sorry

/-- **Layer 2, `IsProPSylow.eq_of_normal`**: a normal pro-`p` Sylow subgroup is the only one.
Layer 4 uses this to identify wild inertia. -/
theorem IsProPSylow.eq_of_normal {G : Type u} [Group G] [TopologicalSpace G] {P Q : Subgroup G}
    (_hP : IsProPSylow p P) (_hQ : IsProPSylow p Q) (_hn : P.Normal) : P = Q := sorry

/-- **Layer 2, `IsProPSylow.map_of_surjective`**: the image under a continuous surjection is a
pro-`p` Sylow subgroup. -/
theorem IsProPSylow.map_of_surjective {G H : Type u} [Group G] [TopologicalSpace G] [Group H]
    [TopologicalSpace H] (f : G →* H) (_hf : Continuous f) (_hs : Function.Surjective f)
    {P : Subgroup G} (_hP : IsProPSylow p P) : IsProPSylow p (P.map f) := sorry

/-- **Layer 3, `topologicalGeneratorRank_le_of_surjective`**: the rank does not increase under a
continuous surjection. Layer 9 uses it for `d(G_K) ≥ d(G_K(p))`. -/
theorem topologicalGeneratorRank_le_of_surjective {G H : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [Group H] [TopologicalSpace H] [IsTopologicalGroup H] (f : G →* H)
    (_hf : Continuous f) (_hs : Function.Surjective f) :
    topologicalGeneratorRank H ≤ topologicalGeneratorRank G := sorry

/-- **Layer 3, `topologicalGeneratorRankNat_le_of_isOpen`**, the Schreier bound
`d(U) ≤ 1 + [G : U](d(G) − 1)` for an open subgroup. Layer 9 uses it for the lower bound in the
case `μ_p ⊄ K`. -/
theorem topologicalGeneratorRankNat_le_of_isOpen {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (U : Subgroup G) (_hU : IsOpen (U : Set G))
    (hG : IsTopologicallyFinitelyGenerated G)
    (hU' : IsTopologicallyFinitelyGenerated U) :
    topologicalGeneratorRankNat U hU' ≤ 1 + U.index * (topologicalGeneratorRankNat G hG - 1) :=
  sorry

/-- **Layer 4, `freeProfiniteGroup`**, the free profinite group on a finite set. ⚠ This is the
profinite object, and not the pro-`p` one of the same layer. -/
def freeProfiniteGroup (_X : Type) : ProfiniteGrp := sorry

/-- **Layer 4, `freeProfiniteGroup.of`**, the generators. -/
def freeProfiniteGroup.of {X : Type} (_x : X) : freeProfiniteGroup X := sorry

/-- **Layer 4, `freeProfiniteGroup.lift`**, the universal property. -/
def freeProfiniteGroup.lift {X : Type} (G : ProfiniteGrp) (_f : X → G) :
    freeProfiniteGroup X ⟶ G := sorry

/-- **Layer 4, `presentedProfiniteGroup`**: the quotient by the closed normal closure of a set
of relators. Layer 4 states `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^{−q}⟩` in this shape. -/
def presentedProfiniteGroup (X : Type) (_rels : Set (freeProfiniteGroup X)) : ProfiniteGrp :=
  sorry

/-- `μ_p ⊆ F`, the hypothesis that separates the two rank theorems of Layer 11. -/
def HasMuP (p : ℕ) (F : Type u) [Field F] : Prop := ∃ ζ : F, IsPrimitiveRoot ζ p

/-- **Layer 11**: `G_F(p)` is topologically finitely generated. Layer 9 consumes it. -/
theorem isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP [Fact p.Prime]
    (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] :
    IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F) := sorry

/-- **Layer 11, Demushkin**: `d(G_F(p)) = [F : ℚ_p] + 2` when `μ_p ⊆ F`. -/
theorem topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu [Fact p.Prime]
    (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (_hmu : HasMuP p F)
    (h : IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F)) :
    topologicalGeneratorRankNat (absoluteGaloisGroupProP p F) h = Module.finrank ℚ_[p] F + 2 :=
  sorry

/-- **Layer 11, Shafarevich**: `d(G_F(p)) = [F : ℚ_p] + 1` when `μ_p ⊄ F`, where `G_F(p)` is then
free pro-`p`. ⚠ This is a statement about `G_F(p)`, and never about `G_F`. -/
theorem topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu [Fact p.Prime]
    (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (_hmu : ¬ HasMuP p F)
    (h : IsTopologicallyFinitelyGenerated (absoluteGaloisGroupProP p F)) :
    topologicalGeneratorRankNat (absoluteGaloisGroupProP p F) h = Module.finrank ℚ_[p] F + 1 :=
  sorry

/-! ### The cohomology carrier

`GalRep n F` is the bundled coefficient object: a topological representation of `G_F` over
`ZMod n`. Discreteness of the underlying module is a hypothesis where it is needed, and the
continuity of the action is part of `TopRep`. Cohomology is Mathlib's `continuousCohomology`. -/

/-- Coefficients for `G_F`, bundled: a topological `ZMod n`-representation. -/
abbrev GalRep (n : ℕ) (F : Type u) [Field F] : Type (u + 1) :=
  TopRep.{u, 0, u} (ZMod n) (Field.absoluteGaloisGroup F)

/-- `Hⁱ(G_F, A)`, the continuous cohomology of Mathlib. The Profinite Cohomology roadmap
supplies the comparison with its explicit cochain description, and this roadmap uses no other
carrier. -/
noncomputable abbrev H (n : ℕ) (F : Type u) [Field F] (i : ℕ) (A : GalRep n F) : Type _ :=
  continuousCohomology i A

/-- The `G_F`-module `μ_n(Fˢ)`, written additively, as a coefficient object. ⚠ The roots of
unity are taken inside the **separable** closure. -/
def muNRep (n : ℕ) (F : Type u) [Field F] : GalRep n F := sorry

/-- The Tate dual `A' = Hom(A, μ_n)`, with the conjugation action. -/
def tateDual {n : ℕ} {F : Type u} [Field F] (_A : GalRep n F) : GalRep n F := sorry

/-- **Profinite Cohomology Layer 8**, the low-degree cup product, in the one shape Layers 8 and
8C use: the coefficients are `μ_n` on both factors, and the target is `μ_n` through the
multiplication `μ_n ⊗ μ_n → μ_n` of coefficient modules. Naming the coefficient pairing is what
fixes the normalization of the local symbol below. -/
def cupMu (n : ℕ) (F : Type u) [Field F] :
    H n F 1 (muNRep n F) →+ H n F 1 (muNRep n F) →+ H n F 2 (muNRep n F) := sorry

/-- **Layer 8B, `h2MuEquivZMod_mixed`**, the trace isomorphism, as a separate declaration from
the cup product. -/
def h2MuEquivZMod (n : ℕ) (F : Type u) [Field F] : H n F 2 (muNRep n F) ≃+ ZMod n := sorry

/-- The local pairing, as the composite of the cup product with the trace isomorphism. Both
factors are named above, so a reader can see which cup product and which invariant map fix the
normalization. -/
noncomputable def localPairing {n : ℕ} {F : Type u} [Field F]
    (x y : H n F 1 (muNRep n F)) : ZMod n :=
  h2MuEquivZMod n F (cupMu n F x y)

/-- **Layer 8, duality**, as the actual map `x ↦ (y ↦ inv(x ⌣ y))`, and not as an abstract
equivalence. Perfectness is the statement that this map is bijective. -/
def dualityMap {n : ℕ} {F : Type u} [Field F] (A : GalRep n F) (i : ℕ) :
    H n F i (tateDual A) →+ (H n F (2 - i) A →+ ZMod n) := sorry

/-! ### Quadratic Form Invariants roadmap -/

/-- **Its Layer 6**, the `{±1}`-valued Hilbert symbol over a local field. Its Layer 2 owns the
norm criterion over an arbitrary field, which is what fixes the orientation. -/
def hilbertSymbol (F : Type u) [Field F] (_a _b : Fˣ) : ℤˣ := sorry

/-! ### Tate cohomology in all integer degrees

Tate–Nakayama needs cup product with a class of `Ĥ²` acting on `Ĥ^r` for every integer `r`.
No supplier layer provides that, and Mathlib `v4.32.2` has no Tate cup product, so Layer 6 of
this roadmap owns it. This is its shape. -/

/-- **Layer 6**, cup product with a distinguished class of `Ĥ²`, in every integer degree. This
is the map that Tate–Nakayama inverts, and it is what no supplier layer provides. -/
def tateCupSigma {G : Type} [Group G] [Fintype G] (M : Rep ℤ G)
    (_σ : tateCohomology M 2) (r : ℤ) :
    tateCohomology (Rep.trivial ℤ G ℤ) r →+ tateCohomology M (r + 2) := sorry

end Interface

/-! ## Cross-roadmap statements

Each statement below is a row of a contract table, on the supplying side. They carry the
local-field hypotheses, because there is no local Artin map and no local duality over an
arbitrary field. -/

section Deliverables

variable {n : ℕ}

/-- **Layer 5, the Kummer class** of a unit: the image of `a` in `H¹(G_F, μ_n)`. -/
def kummerClass (n : ℕ) (F : Type u) [Field F] (_a : Fˣ) : Interface.H n F 1 (Interface.muNRep n F) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 1.** For `n` invertible in `𝒪[K]`, the Kummer map is an
isomorphism of **groups**, after the multiplicative quotient is written additively. A bare
equivalence of types would not support the cup-product square below. -/
example (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Nonempty (Additive (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range) ≃+
      Interface.H n K 1 (Interface.muNRep n K)) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 2.** For `K/ℚ_p` finite the same isomorphism holds for
every `n ≠ 0`, including `n = p`. Layer 11 of the Pro-`p` Groups roadmap consumes this case, and
it does not follow from the regime-1 statement. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) :
    Nonempty (Additive (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) ≃+
      Interface.H n F 1 (Interface.muNRep n F)) :=
  sorry

/-- **Layer 5, `cup_kummerEquiv`, part one: bilinearity.** The cup product of Kummer classes is
additive in each variable, which says that the local symbol is multiplicative in each argument. -/
example (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a a' b : Kˣ) :
    Interface.localPairing (kummerClass n K (a * a')) (kummerClass n K b)
      = Interface.localPairing (kummerClass n K a) (kummerClass n K b)
        + Interface.localPairing (kummerClass n K a') (kummerClass n K b) :=
  sorry

/-- **Layer 5, `cup_kummerEquiv`, part two: the Steinberg relation.** The cup product vanishes on
`(a, 1 − a)`. With bilinearity this fixes the normalization of the symbol, and it is the relation
that the norm criterion of Layer 8C specializes at `n = 2`. -/
example (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a b : Kˣ)
    (_hab : (a : K) + (b : K) = 1) :
    Interface.localPairing (kummerClass n K a) (kummerClass n K b) = 0 :=
  sorry

/-- **Layer 7, `artinMap`**, with the local-field hypotheses: there is no local Artin map over an
arbitrary field. Continuous, with dense image, and with kernel the intersection of the norm
groups. ⚠ It is not surjective, so it supports no `Nat.card` statement about its target. -/
noncomputable def artinMap : Kˣ →* Field.absoluteGaloisGroupAbelianization K := sorry

/-- **Layer 7, `cyclotomicCharacter_artinMap`**, the general form, with the field norm. For
`K/ℚ_p` finite and `u` a unit, `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹`. ⚠ Without the norm the
equation is ill-typed for `K ≠ ℚ_p`, so the `ℚ_p` corollary below does not replace it. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (u : Fˣ) (_hu : valuation F (u : F) = 1) (σ : Field.absoluteGaloisGroup F)
    (_hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization F) = artinMap F u) :
    Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom
        (cyclotomicCharacter (AlgebraicClosure F) p σ.toRingEquiv)
      = (Units.map (Algebra.norm ℚ_[p] : F →* ℚ_[p]) u)⁻¹ :=
  sorry

/-- **Layer 8B, `h2MuEquivZMod_mixed`.** The trace isomorphism for **every** `n ≥ 1` in mixed
characteristic. ⚠ The 8A statement of the same shape carries `IsUnit (n : 𝒪[K])`, so it says
nothing at `n = p`. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) :
    Nonempty (Interface.H n F 2 (Interface.muNRep n F) ≃+ ZMod n) :=
  sorry

/-- **Layer 8B, `h2FpEquivZMod_of_mu`.** The transport to `𝔽_p` coefficients under a choice of
primitive `p`-th root of unity. The choice is an argument, and not a global convention. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (ζ : F) (_hζ : IsPrimitiveRoot ζ p) (A : Interface.GalRep p F) :
    Nonempty (Interface.H p F 2 A ≃+ ZMod p) :=
  sorry

/-- **Layer 8, finiteness.** Every cohomology group in degrees `0`, `1`, `2` of a finite discrete
module is finite. The Euler-characteristic statement below depends on this, because `Nat.card` is
`0` on an infinite type. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : Interface.GalRep n F) (_hA : Finite A) (i : ℕ) (_hi : i ≤ 2) :
    Finite (Interface.H n F i A) :=
  sorry

/-- **Layer 8B, `tateDualityPairing_perfect_mixed`.** Perfectness in degrees `0`, `1`, `2`, as
bijectivity of the actual map `x ↦ (y ↦ inv(x ⌣ y))`. The coefficients are killed by `n`,
because they are a `ZMod n`-module, and they are finite and discrete. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : Interface.GalRep n F) (_hA : Finite A)
    (_hdisc : DiscreteTopology A) (i : ℕ) (_hi : i ≤ 2) :
    Function.Bijective (Interface.dualityMap A i) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_mixed`.** With finiteness available,
`#H⁰ · #H² / #H¹ = ‖#M‖_K`, written over `ℕ` with `‖#M‖_K⁻¹ = p ^ (N · v_p(#M))`. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : Interface.GalRep n F) (_hA : Finite A)
    (_h0 : Finite (Interface.H n F 0 A)) (_h1 : Finite (Interface.H n F 1 A))
    (_h2 : Finite (Interface.H n F 2 A)) :
    Nat.card (Interface.H n F 1 A)
      = Nat.card (Interface.H n F 0 A) * Nat.card (Interface.H n F 2 A)
        * p ^ (Module.finrank ℚ_[p] F * padicValNat p (Nat.card A)) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_finrank_fp`.** The `𝔽_p`-module corollary,
`dim H¹ = dim H⁰ + dim H² + N · dim M`, with the `ZMod p`-module structures on the cohomology
groups. Layer 11 of the Pro-`p` Groups roadmap consumes this form. -/
example (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (A : Interface.GalRep p F) (_hA : Finite A) :
    Module.finrank (ZMod p) (Interface.H p F 1 A)
      = Module.finrank (ZMod p) (Interface.H p F 0 A)
        + Module.finrank (ZMod p) (Interface.H p F 2 A)
        + Module.finrank ℚ_[p] F * Module.finrank (ZMod p) A :=
  sorry

/-- **Layer 8C, `hilbertSymbol_eq_tateDuality_pairing`**, with the local-field hypotheses. At
`n = 2` the pairing `localPairing`, read through the Kummer identification on each factor, is the
classical `{±1}`-valued Hilbert symbol. -/
example (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] (_h2 : IsUnit (2 : ↥𝒪[F])) (a b : Fˣ) :
    Interface.localPairing (kummerClass 2 F a) (kummerClass 2 F b) = 0 ↔
      Interface.hilbertSymbol F a b = 1 :=
  sorry

end Deliverables

end TauCetiRoadmap.LocalFields
