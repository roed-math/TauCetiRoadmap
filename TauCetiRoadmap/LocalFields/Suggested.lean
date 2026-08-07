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
acceptance criteria of Layers 7 to 9, and the cross-roadmap statements below. Power classes and
Layer 8 are split into the two regimes of the roadmap's standing hypotheses. `p`-power
coefficients in equal characteristic are outside the roadmap, and no statement here is to be
generalized to cover them. The same boundary cuts Layer 7: the existence theorem is a
milestone away from the residue characteristic for a general local field, and in full only
for `K` a finite extension of `ℚ_p`. So anything derived from full existence, such as
injectivity of the Artin map or the ordinary profinite completion of `Kˣ`, is
mixed-characteristic.

Definitions with a `sorry` body (`normalizedValuation`, `ramificationIndex`,
`inertiaDegree`, `teichmuller`, `unitFiltration`, `muNRep`, `tateDual`, `artinMap`,
`hilbertSymbol`) are suggested *names and types* for objects **this roadmap** builds, together
with the characteristic lemmas that fix them. They are placeholders for data whose type is
expressible now, and never for a condition we cannot state.

## Operations that this roadmap does not own

Namespace `Supplied` collects the cohomology of a profinite group and the group theory of
pro-`p` groups. Its predicates and carriers are definitions, with the bodies that the supplying
development gives them, so the two are definitionally equal and a statement here transports to
the supplier's name by `rfl`. Its theorems are the fields of `ProPOps`, `ProPRankInputs`, and
`CohomologyOps`, and every statement below that needs one takes it as an argument. Nothing here
postulates an operation that another development owns: a theorem with such an argument asserts
an implication, and an axiom would assert more.

An operation is a field of one of those structures exactly when it occurs in a **statement**
here. Corestriction, Mackey, Shapiro, and the finite-quotient colimit occur only inside proofs,
so they are recorded in `README.md` and are not fields.
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
in the quotient form that `Supplied.IsProP` unfolds to.) -/
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

/-- **Layer 8 acceptance, the Hilbert-symbol entry `(−1,−1)_2 = −1`.** `−1` is not a sum of
two squares in `ℚ_2`: through the Kummer identification, the mod-2 duality pairing is the
classical Hilbert symbol (the named theorem shared with the QuadraticFormInvariants roadmap),
and it is nontrivial at `(−1, −1)`. -/
example : ¬ ∃ x y : ℚ_[2], (-1 : ℚ_[2]) = x ^ 2 + y ^ 2 :=
  sorry

/-! ## Operations that this roadmap does not own

Two developments carry operations that this roadmap uses and should not build a second time:
cohomology of a profinite group, and the group theory of pro-`p` groups. Nothing below
postulates one of them. The predicates and the carriers are **definitions**, with the bodies
that the supplying development gives them, so the two are definitionally equal and a statement
here transports to the supplier's name by `rfl`. The **theorems** are collected into three
structures, and every statement in the last section that needs one takes it as an argument.

A theorem with such an argument is an honest theorem, and not an axiom: it asserts an
implication whose proof needs nothing outside Mathlib and the earlier milestones. A `sorry`
that postulates an object owned elsewhere would assert more than that.

An operation is a field of a structure exactly when it occurs in a **statement** here.
Corestriction, Mackey, Shapiro, and the finite-quotient colimit occur only inside proofs, so
they are recorded in `README.md` as proof obligations and are not fields. -/

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

/-- `G_F(p)`, the maximal pro-`p` quotient of the absolute Galois group. Layer 9 cites this
carrier, and does not re-form the quotient. -/
abbrev absoluteGaloisGroupProP (F : Type u) [Field F] : Type u :=
  maximalProPQuotient p (Field.absoluteGaloisGroup F)

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
  its image generates the Frattini quotient `G ⧸ Φ(G)`. Layer 9 uses it for the tame frame. -/
  topologicallyGenerates_iff_frattiniQuotient : ∀ (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G], IsProP p G → ∀ s : Set G,
      (Subgroup.closure s).topologicalClosure = ⊤ ↔
        Subgroup.closure ((QuotientGroup.mk' (proPFrattini p G)) '' s) = ⊤

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

/-! ### The cohomology carrier

The carrier is Mathlib's `continuousCohomology` on the bundled topological representation
`TopRep`, which carries the discrete topology and the continuous action that the coefficients
must have. Only the cup product and the coefficient functoriality are hypotheses. -/

/-- Coefficients for `G_F`, bundled: a topological `ZMod n`-representation. -/
abbrev GalRep (n : ℕ) (F : Type u) [Field F] : Type (u + 1) :=
  TopRep.{u, 0, u} (ZMod n) (Field.absoluteGaloisGroup F)

/-- `Hⁱ(G_F, A)`, the continuous cohomology of Mathlib. This roadmap uses no other carrier. -/
noncomputable abbrev H (n : ℕ) (F : Type u) [Field F] (i : ℕ) (A : GalRep n F) : Type _ :=
  continuousCohomology i A

/-- The cup product, with the coefficient object of its target as data. ⚠ The target of a cup
product of two classes with coefficients in `A` and `B` is `A ⊗ B`, and never `A` again. That is
why `tensorObj` is a field: naming it is what stops a statement from asserting a coefficient
identification that does not exist. -/
structure CohomologyOps (n : ℕ) (F : Type u) [Field F] where
  /-- The coefficient object `A ⊗ B` of a cup product. -/
  tensorObj : GalRep n F → GalRep n F → GalRep n F
  /-- Cup product, in the degrees this roadmap uses. The degree of the target is an argument
  together with its defining equation, so no degree arithmetic is hidden in a coercion. -/
  cup : ∀ (A B : GalRep n F) (i j k : ℕ), i + j = k →
    H n F i A →+ H n F j B →+ H n F k (tensorObj A B)
  /-- The map induced on cohomology by a morphism of coefficient objects. Mathlib's
  `ContinuousCohomology.cochainsMap`, at the identity group homomorphism, gives it; it is a
  field so that the statements below need no detour through the cochain complex. -/
  coeff : ∀ {A B : GalRep n F}, (A ⟶ B) → ∀ i : ℕ, H n F i A →+ H n F i B

end Supplied

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

/-- **Layer 5, `kummerClass`**: the image of `a` in `H¹(G_F, μ_n)`. -/
def kummerClass (n : ℕ) (F : Type u) [Field F] (_a : Fˣ) : H n F 1 (muNRep n F) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 1.** For `n` invertible in `𝒪[K]`, the Kummer map is an
isomorphism of **groups**, after the multiplicative quotient is written additively. A bare
equivalence of types would not support the cup-product square below. -/
theorem kummerEquiv_unit (n : ℕ) (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) :
    Nonempty (Additive (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range) ≃+
      H n K 1 (muNRep n K)) :=
  sorry

/-- **Layer 5, `kummerEquiv`, regime 2.** For `K/ℚ_p` finite the same isomorphism holds for
every `n ≠ 0`, including `n = p`. It does not follow from the regime-1 statement. -/
theorem kummerEquiv_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) :
    Nonempty (Additive (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) ≃+
      H n F 1 (muNRep n F)) :=
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

/-- The local symbol at exponent `n`, assembled from three named pieces: a cup product, a
morphism `μ_n ⊗ μ_n ⟶ μ_n` of coefficient objects, and a trace isomorphism. ⚠ The middle
argument is where a choice hides. Multiplication of roots of unity is not biadditive, so there
is no canonical morphism `μ_n ⊗ μ_n ⟶ μ_n` for general `n`; a primitive `n`-th root of unity
produces one, and at `n = 2` the morphism is canonical because `μ_2 ≅ ZMod 2` needs no
choice. -/
noncomputable def localSymbol {n : ℕ} {F : Type u} [Field F] (ops : CohomologyOps n F)
    (sq : ops.tensorObj (muNRep n F) (muNRep n F) ⟶ muNRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (x y : H n F 1 (muNRep n F)) : ZMod n :=
  tr (ops.coeff sq 2 (ops.cup _ _ 1 1 2 rfl x y))

/-- **Layer 5, `cup_kummerEquiv`, part one: bilinearity.** The symbol is additive in each
variable, which says that it is multiplicative in each argument of `Kˣ`. -/
theorem localSymbol_kummerClass_mul (ops : CohomologyOps n K)
    (sq : ops.tensorObj (muNRep n K) (muNRep n K) ⟶ muNRep n K)
    (tr : H n K 2 (muNRep n K) ≃+ ZMod n)
    (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a a' b : Kˣ) :
    localSymbol ops sq tr (kummerClass n K (a * a')) (kummerClass n K b)
      = localSymbol ops sq tr (kummerClass n K a) (kummerClass n K b)
        + localSymbol ops sq tr (kummerClass n K a') (kummerClass n K b) :=
  sorry

/-- **Layer 5, `cup_kummerEquiv`, part two: the Steinberg relation.** The symbol vanishes on
`(a, 1 − a)`. With bilinearity this fixes the normalization, and it is the relation that the
norm criterion of Layer 8C specializes at `n = 2`. -/
theorem localSymbol_kummerClass_steinberg (ops : CohomologyOps n K)
    (sq : ops.tensorObj (muNRep n K) (muNRep n K) ⟶ muNRep n K)
    (tr : H n K 2 (muNRep n K) ≃+ ZMod n)
    (_hn : n ≠ 0) (_hn' : IsUnit (n : ↥𝒪[K])) (a b : Kˣ) (_hab : (a : K) + (b : K) = 1) :
    localSymbol ops sq tr (kummerClass n K a) (kummerClass n K b) = 0 :=
  sorry

/-- **Layer 8, the duality pairing**, as the actual map `(x, y) ↦ inv(x ⌣ y)`. The coefficient
map is **evaluation** `A' ⊗ A ⟶ μ_n`, which is equivariant and biadditive; it is an argument,
so no statement below asserts a coefficient identification that does not exist. -/
noncomputable def tateDualityPairing {n : ℕ} {F : Type u} [Field F] (ops : CohomologyOps n F)
    (A : GalRep n F) (ev : ops.tensorObj (tateDual A) A ⟶ muNRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (i j : ℕ) (hij : i + j = 2)
    (x : H n F i (tateDual A)) (y : H n F j A) : ZMod n :=
  tr (ops.coeff ev 2 (ops.cup _ _ i j 2 hij x y))

/-- **Layer 8, finiteness.** Every cohomology group in degrees `0`, `1`, `2` of a finite
discrete module is finite. The Euler-characteristic statement below depends on this, because
`Nat.card` is `0` on an infinite type. -/
theorem finite_H (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F) (_hA : Finite A) (i : ℕ) (_hi : i ≤ 2) :
    Finite (H n F i A) :=
  sorry

/-- **Layer 8B, `tateDualityPairing_perfect_mixed`.** Perfectness in degrees `0`, `1`, `2`,
written without bundling: the pairing has no left kernel, and every additive functional on the
other factor is represented. The coefficients are killed by `n`, because they are a
`ZMod n`-module, and they are finite and discrete. -/
theorem tateDualityPairing_perfect_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) (ops : CohomologyOps n F) (A : GalRep n F)
    (ev : ops.tensorObj (tateDual A) A ⟶ muNRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (_hA : Finite A) (_hdisc : DiscreteTopology A)
    (i j : ℕ) (hij : i + j = 2) :
    (∀ x : H n F i (tateDual A),
        (∀ y : H n F j A, tateDualityPairing ops A ev tr i j hij x y = 0) → x = 0) ∧
      (∀ φ : H n F j A →+ ZMod n, ∃ x : H n F i (tateDual A),
        ∀ y : H n F j A, tateDualityPairing ops A ev tr i j hij x y = φ y) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_mixed`.** With finiteness available,
`#H⁰ · #H² / #H¹ = ‖#M‖_K`, written over `ℕ` with `‖#M‖_K⁻¹ = p ^ (N · v_p(#M))`. -/
theorem eulerCharacteristic_mixed (p : ℕ) [Fact p.Prime] (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (_hn : n ≠ 0) (A : GalRep n F) (_hA : Finite A)
    (_h0 : Finite (H n F 0 A)) (_h1 : Finite (H n F 1 A)) (_h2 : Finite (H n F 2 A)) :
    Nat.card (H n F 1 A)
      = Nat.card (H n F 0 A) * Nat.card (H n F 2 A)
        * p ^ (Module.finrank ℚ_[p] F * padicValNat p (Nat.card A)) :=
  sorry

/-- **Layer 8B, `eulerCharacteristic_finrank_fp`.** The `𝔽_p`-module corollary,
`dim H¹ = dim H⁰ + dim H² + N · dim M`, with the `ZMod p`-module structures on the cohomology
groups. The downstream table consumes this form. -/
theorem eulerCharacteristic_finrank_fp (p : ℕ) [Fact p.Prime] (F : Type u) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (A : GalRep p F) (_hA : Finite A) :
    Module.finrank (ZMod p) (H p F 1 A)
      = Module.finrank (ZMod p) (H p F 0 A)
        + Module.finrank (ZMod p) (H p F 2 A)
        + Module.finrank ℚ_[p] F * Module.finrank (ZMod p) A :=
  sorry

/-- **Layer 7, `artinMap`**, with the local-field hypotheses: there is no local Artin map over an
arbitrary field. Continuous, with dense image, and with kernel the intersection of the norm
groups. ⚠ It is not surjective, so it supports no `Nat.card` statement about its target. -/
noncomputable def artinMap : Kˣ →* Field.absoluteGaloisGroupAbelianization K := sorry

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

/-- **Layer 8C, `tateDualityPairing_eq_normCriterion`.** At `n = 2` the coefficient morphism
`μ_2 ⊗ μ_2 ⟶ μ_2` is canonical, so the symbol needs no chosen root of unity. Read through the
Kummer identification on each factor, it vanishes exactly on the pairs `(a, b)` with `a` a norm
from `K(√b)`. The right-hand side is a statement about `F` alone, so this theorem needs nothing
from another development. -/
theorem tateDualityPairing_eq_normCriterion (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] (_h2 : IsUnit (2 : ↥𝒪[F]))
    (ops : CohomologyOps 2 F) (sq : ops.tensorObj (muNRep 2 F) (muNRep 2 F) ⟶ muNRep 2 F)
    (tr : H 2 F 2 (muNRep 2 F) ≃+ ZMod 2) (a b : Fˣ)
    (M : IntermediateField F (AlgebraicClosure F))
    (_hM : M = IntermediateField.adjoin F
      {x : AlgebraicClosure F | x ^ 2 = algebraMap F (AlgebraicClosure F) (b : F)}) :
    localSymbol ops sq tr (kummerClass 2 F a) (kummerClass 2 F b) = 0 ↔
      a ∈ (Units.map (Algebra.norm F : M →* F)).range :=
  sorry

/-- **Layer 8C, `hilbertSymbol_eq_tateDuality_pairing`**, the `{±1}`-valued form. It is the
theorem above composed with the dictionary between `ZMod 2` and `{±1} ⊆ ℤˣ`. -/
noncomputable def hilbertSymbol (F : Type u) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] (_a _b : Fˣ) : ℤˣ := sorry

theorem hilbertSymbol_eq_tateDuality_pairing (F : Type u) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] (_h2 : IsUnit (2 : ↥𝒪[F]))
    (ops : CohomologyOps 2 F) (sq : ops.tensorObj (muNRep 2 F) (muNRep 2 F) ⟶ muNRep 2 F)
    (tr : H 2 F 2 (muNRep 2 F) ≃+ ZMod 2) (a b : Fˣ) :
    hilbertSymbol F a b = 1 ↔
      localSymbol ops sq tr (kummerClass 2 F a) (kummerClass 2 F b) = 0 :=
  sorry

/-! ### Layer 6: the Tate cup product and Tate–Nakayama

Tate–Nakayama needs cup product with a class of `Ĥ²` acting on `Ĥ^r` for every integer `r`,
including negative `r`. An ordinary cup product does not provide that, and Mathlib `v4.32.2` has
no Tate cup product, so Layer 6 of this roadmap owns it. It is not a hypothesis, and the laws
below are the roadmap's own targets. -/

variable {G : Type} [Group G] [Fintype G]

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
  cls : ∀ (H : Subgroup G) [Fintype H], tateCohomology (Rep.res H.subtype M) 2
  /-- Restriction on `Ĥ²` along `H' ≤ H`. -/
  res : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateCohomology (Rep.res H.subtype M) 2 →+ tateCohomology (Rep.res H'.subtype M) 2
  /-- Corestriction on `Ĥ²` along `H' ≤ H`. -/
  cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'], H' ≤ H →
    tateCohomology (Rep.res H'.subtype M) 2 →+ tateCohomology (Rep.res H.subtype M) 2
  /-- Field 1: `H¹(H, M) = 0` for every subgroup. -/
  h1_eq_zero : ∀ (H : Subgroup G) [Fintype H],
    Subsingleton (groupCohomology (Rep.res H.subtype M) 1)
  /-- Field 2, first half: `Ĥ²(H, M)` is generated by the distinguished class. -/
  h2_cyclic : ∀ (H : Subgroup G) [Fintype H] (x : tateCohomology (Rep.res H.subtype M) 2),
    ∃ m : ℤ, x = m • cls H
  /-- Field 2, second half: its order is `Nat.card H`, and not the index `[G : H]`. -/
  h2_card : ∀ (H : Subgroup G) [Fintype H],
    Nat.card (tateCohomology (Rep.res H.subtype M) 2) = Nat.card H
  /-- Fields 3 and 4: restriction sends a distinguished class to a distinguished class, which
  covers `res^G_H σ_G = σ_H` at `H = ⊤` and the tower case `H' ≤ H` at once. -/
  res_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    res H H' h (cls H) = cls H'
  /-- Field 5: corestriction multiplies the distinguished class by the index. -/
  cor_cls : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H),
    cor H H' h (cls H') = ((H'.subgroupOf H).index : ℤ) • cls H
  /-- The one law relating the two maps: `cor ∘ res` is multiplication by the index. -/
  res_comp_cor : ∀ (H H' : Subgroup G) [Fintype H] [Fintype H'] (h : H' ≤ H)
    (x : tateCohomology (Rep.res H.subtype M) 2),
    cor H H' h (res H H' h x) = ((H'.subgroupOf H).index : ℤ) • x

/-- **Layer 6**, the Tate cup product in all integer bidegrees. The target degree is an argument
together with its defining equation, so that no statement below has to compare `(r + s) + t` with
`r + (s + t)`, which are equal in `ℤ` by a theorem and not by `rfl`.

⚠ A family of additive maps `Ĥ^r(G, ℤ) → Ĥ^{r+2}(G, M)` of the right type is not a cup product,
and supports no part of Tate–Nakayama. The laws below are what make this family usable. -/
noncomputable def tateCup (A B : Rep ℤ G) (r s t : ℤ) (_h : r + s = t) :
    tateCohomology A r →+ tateCohomology B s →+ tateCohomology (A ⊗ B) t :=
  sorry

/-- Associativity, through the associator of the coefficients. -/
theorem tateCup_assoc (A B C : Rep ℤ G) (r s t w : ℤ) (h : r + s + t = w)
    (x : tateCohomology A r) (y : tateCohomology B s) (z : tateCohomology C t) :
    ∃ e : tateCohomology ((A ⊗ B) ⊗ C) w ≃+ tateCohomology (A ⊗ (B ⊗ C)) w,
      e (tateCup (A ⊗ B) C (r + s) t w h (tateCup A B r s (r + s) rfl x y) z)
        = tateCup A (B ⊗ C) r (s + t) w (by omega) x (tateCup B C s t (s + t) rfl y z) :=
  sorry

/-- Graded commutativity, through the braiding of the coefficients. -/
theorem tateCup_comm (A B : Rep ℤ G) (r s t : ℤ) (h : r + s = t) (h' : s + r = t)
    (x : tateCohomology A r) (y : tateCohomology B s) :
    ∃ e : tateCohomology (B ⊗ A) t ≃+ tateCohomology (A ⊗ B) t,
      e (tateCup B A s r t h' y x)
        = ((-1 : ℤ) ^ (r * s).natAbs) • tateCup A B r s t h x y :=
  sorry

/-- Agreement with an ordinary cup product in non-negative degrees, stated against a comparison
map from group cohomology to Tate cohomology. Both the ordinary cup product and the comparison
are arguments, because this roadmap owns neither. -/
theorem tateCup_agrees_ordinary (A B : Rep ℤ G) (i j : ℕ)
    (ordinary : ∀ (X Y : Rep ℤ G) (m k : ℕ),
      groupCohomology X m →+ groupCohomology Y k →+ groupCohomology (X ⊗ Y) (m + k))
    (cmp : ∀ (X : Rep ℤ G) (m : ℕ), groupCohomology X m →+ tateCohomology X (m : ℤ))
    (x : groupCohomology A i) (y : groupCohomology B j) :
    cmp (A ⊗ B) (i + j) (ordinary A B i j x y)
      = tateCup A B (i : ℤ) (j : ℤ) ((i + j : ℕ) : ℤ) (by push_cast; ring)
          (cmp A i x) (cmp B j y) :=
  sorry

/-- **Layer 6**, cup product with a distinguished class of `Ĥ²`, in every integer degree,
**defined from** `tateCup` and never independently of it. This is the map that Tate–Nakayama
inverts. -/
noncomputable def tateCupSigma (M : Rep ℤ G) (σ : tateCohomology M 2) (r : ℤ)
    (iso : ∀ s : ℤ, tateCohomology (M ⊗ Rep.trivial ℤ G ℤ) s ≃+ tateCohomology M s) :
    tateCohomology (Rep.trivial ℤ G ℤ) r →+ tateCohomology M (2 + r) where
  toFun x := iso (2 + r) (tateCup M (Rep.trivial ℤ G ℤ) 2 r (2 + r) rfl σ x)
  map_zero' := by simp
  map_add' x y := by simp

/-- **Layer 6, Tate–Nakayama.** Cup product with the distinguished class of a finite class
formation is an isomorphism in every integer degree. ⚠ The statement is about the map above, and
not about the existence of some isomorphism of the same shape. -/
theorem tateNakayama (M : Rep ℤ G) (_fcf : FiniteClassFormation M) (σ : tateCohomology M 2)
    (r : ℤ) (iso : ∀ s : ℤ, tateCohomology (M ⊗ Rep.trivial ℤ G ℤ) s ≃+ tateCohomology M s) :
    Function.Bijective (tateCupSigma M σ r iso) :=
  sorry

/-- **Layer 6, duality for Tate cohomology of a finite group.** Cup product against the dual
`A^D = Hom(A, ℚ/ℤ)` is a perfect pairing of finite groups, in every integer degree with
`r + s = −1`. Here `QZ` is the trivial module `ℚ/ℤ`, `_ev` is the evaluation `A ⊗ A^D ⟶ ℚ/ℤ`,
`evStar` is the map it induces on `Ĥ^{−1}`, and `val` is the identification
`Ĥ^{−1}(G, ℚ/ℤ) ≅ ZMod (Nat.card G)`. Perfectness is written without bundling: no left kernel,
and every additive functional represented.

This theorem uses no class formation, and its home is the class-formation directory of Layer 6.
⚠ Layer 8 does not obtain local duality from it by a formal step: the local dual is
`Hom(M, μ_n)`, and the two agree only when the field contains `μ_n`. -/
theorem tateDuality_finiteGroup (A AD QZ : Rep ℤ G) (r s : ℤ) (h : r + s = -1)
    (_ev : A ⊗ AD ⟶ QZ)
    (evStar : tateCohomology (A ⊗ AD) (-1) →+ tateCohomology QZ (-1))
    (val : tateCohomology QZ (-1) ≃+ ZMod (Nat.card G))
    (_hfinA : Finite (tateCohomology A r)) (_hfinAD : Finite (tateCohomology AD s)) :
    (∀ x : tateCohomology A r,
        (∀ y, val (evStar (tateCup A AD r s (-1) h x y)) = 0) → x = 0) ∧
      (∀ φ : tateCohomology AD s →+ ZMod (Nat.card G), ∃ x : tateCohomology A r,
        ∀ y, val (evStar (tateCup A AD r s (-1) h x y)) = φ y) :=
  sorry

/-- **Layer 9, the exact rank of the full absolute Galois group:** `d(G_F) = [F : ℚ_p] + 2`,
stated as leastness of `[F : ℚ_p] + 2` among the cardinalities of topologically generating
finite sets. The upper bound is NSW VII §4. The lower bound uses the rank of the maximal pro-`p`
quotient, which is `ProPRankInputs`, together with the Schreier bound of `ProPOps`; the equality
is Jarden–Shusterman Thm. 2.1.

⚠ The familiar `[F : ℚ_p] + 1` count is a statement about `G_F(p)`, which is free pro-`p` of
that rank when `μ_p ⊄ F`, and never about `G_F`: the full group has rank `[F : ℚ_p] + 2` in both
cases. The finite-generation corollary at `F = ℚ_2`, namely generation by 3 elements, is the
label `B1` of the downstream table. -/
theorem rank_absoluteGaloisGroup (p : ℕ) [Fact p.Prime] (_ops : ProPOps.{u} p)
    (_inp : ProPRankInputs.{u} p) (F : Type u) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    IsLeast
      {m : ℕ | ∃ s : Finset (Field.absoluteGaloisGroup F), s.card = m ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤}
      (Module.finrank ℚ_[p] F + 2) :=
  sorry

end Deliverables

end TauCetiRoadmap.LocalFields
