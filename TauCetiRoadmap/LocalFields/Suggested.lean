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
split into prime-to-residue-characteristic and mixed-characteristic `p`-primary regimes;
equal-characteristic `p`-primary finiteness/duality is explicitly out of scope. As those layers
make their types expressible in `TauCeti/`, add their milestones here with `sorry`.
-/

namespace TauCetiRoadmap.LocalFields

open ValuativeRel

universe u v

variable (K : Type u) [Field K] [ValuativeRel K] [TopologicalSpace K]
  [IsNonarchimedeanLocalField K]
variable (L : Type v) [Field L] [ValuativeRel L] [TopologicalSpace L]
  [IsNonarchimedeanLocalField L]

/-! ## Layer 0: the local-field package -/

/-- **Layer 0, non-vacuity: `ℚ_p` is a nonarchimedean local field.** The pin has
`ValuativeRel ℚ_[p]` (via `Padic.mulValuation`) but neither `IsValuativeTopology ℚ_[p]` nor
this instance; producing them — with the metric/valuative uniformity compatibility as a
lemma, not an accident — is the first milestone. Stated at `p = 2` because every downstream
consumer of this roadmap lives there; the general `p` follows the same route. -/
example : IsNonarchimedeanLocalField ℚ_[2] :=
  sorry

/-- **Layer 0, the normalized valuation.** The valuation of a local field, written
additively but encoded as a homomorphism to `Multiplicative ℤ`: a surjective
`v : Kˣ →* Multiplicative ℤ` whose kernel is exactly the elements of canonical valuation `1`
(the units of `𝒪[K]`). This is `WithZero.log` of Mathlib's canonical valuation transported
along `valueGroupWithZeroIsoInt`. For a uniformizer, the Lean-facing equation is
`v π = Multiplicative.ofAdd 1`; by contrast `v x = 1` means additive value `0` and is reserved
for the kernel condition. ⚠ Sign trap: Mathlib's multiplicative convention has
`valuation K π = exp (−1) < 1` on uniformizers, so the additive normalization carries a
minus sign — keep the translation in one named lemma. -/
example :
    ∃ v : Kˣ →* Multiplicative ℤ, Function.Surjective v ∧
      (∀ x : Kˣ, v x = 1 ↔ valuation K (x : K) = 1) ∧
      ∀ (π : 𝒪[K]) (_hπ : Irreducible π) (hπ0 : (π : K) ≠ 0),
        v (Units.mk0 (π : K) hπ0) = Multiplicative.ofAdd 1 :=
  sorry

/-- **Layer 0, uniformizers generate the value group.** Any irreducible element of the
(discrete valuation) ring `𝒪[K]` has valuation a generator: every nonzero value is an
integer power of it. Together with the previous milestone this pins the Lean-facing equation
`v_K^×(π) = Multiplicative.ofAdd 1`. -/
example (π : 𝒪[K]) (hπ : Irreducible π) :
    ∀ γ : (ValueGroupWithZero K)ˣ,
      ∃ n : ℤ, (γ : ValueGroupWithZero K) = valuation K (π : K) ^ n :=
  sorry

/-- **Layer 0, finite extensions are local fields.** A finite extension of a nonarchimedean
local field, with a compatible valuation class and the valuative topology, is a
nonarchimedean local field. (Existence and uniqueness of the compatible `ValuativeRel L` —
via the spectral norm / `RingTheory/Valuation/Extension.lean` layer — is part of this
milestone; here the instance is hypothesized so the statement elaborates at the pin.) -/
example (M : Type v) [Field M] [ValuativeRel M] [TopologicalSpace M]
    [IsValuativeTopology M] [Algebra K M] [ValuativeExtension K M]
    [Module.Finite K M] :
    IsNonarchimedeanLocalField M :=
  sorry

/-- **Layer 0, `e · f = n`.** For a finite extension `L/K` of local fields: the residue
degree `f` (here characterized by `#𝓀[L] = #𝓀[K] ^ f`) and the ramification index `e` (the
valuation of a uniformizer of `K` is the `e`-th power of that of a uniformizer of `L`)
satisfy `e · f = [L : K]`. The reconciliation with the Dedekind-level
`Ideal.ramificationIdx`/`Ideal.inertiaDeg` (at a local field `𝓂[K]` has the single prime
`𝓂[L]` above it) is a separate named milestone. -/
example [Algebra K L] [ValuativeExtension K L] [Module.Finite K L] :
    ∃ e f : ℕ, 0 < e ∧ 0 < f ∧ e * f = Module.finrank K L ∧
      Nat.card 𝓀[L] = Nat.card 𝓀[K] ^ f ∧
      ∀ (πK : 𝒪[K]) (πL : 𝒪[L]), Irreducible πK → Irreducible πL →
        valuation L (algebraMap K L (πK : K)) = valuation L (πL : L) ^ e :=
  sorry

/-! ## Layer 1: units, the filtration, and the multiplicative group -/

/-- **Layer 1, reduction is surjective on units** — the depth-`0` graded piece
`𝒪[K]ˣ ↠ 𝓀[K]ˣ` of the unit filtration (its kernel is `U(K,1) = 1 + 𝓂[K]`; the deeper
pieces `U(K,i)/U(K,i+1) ≅ 𝓀[K]⁺` are stated once the filtration object exists in
`TauCeti/`). -/
example :
    Function.Surjective
      (Units.map (IsLocalRing.residue 𝒪[K]).toMonoidHom : (𝒪[K])ˣ →* (𝓀[K])ˣ) :=
  sorry

/-- **Layer 1, the Teichmüller section.** The reduction `𝒪[K]ˣ → 𝓀[K]ˣ` has a canonical
multiplicative section (build from `Perfection.teichmuller₀` or by Hensel on
`X^(q−1) − 1`; the roadmap records the choice); its image is the group `μ_{q−1}` of
prime-to-`p` roots of unity of `K`. -/
example :
    ∃ ω : (𝓀[K])ˣ →* (𝒪[K])ˣ,
      ∀ x : (𝓀[K])ˣ, Units.map (IsLocalRing.residue 𝒪[K]).toMonoidHom (ω x) = x :=
  sorry

/-- **Layer 1, the multiplicative decomposition.** A choice of uniformizer splits
`Kˣ ≅ ℤ × 𝒪[K]ˣ`: every unit of `K` is uniquely `π^n · u` with `u ∈ 𝒪[K]ˣ`. (With the
Teichmüller milestone this refines to `Kˣ ≅ π^ℤ × μ_{q−1} × U(K,1)`, and `U(K,1)` is
pro-`p` — the pro-`p` vocabulary is the ProPGroups sibling's.) -/
example (π : 𝒪[K]) (hπ : Irreducible π) (x : Kˣ) :
    ∃! p : ℤ × (𝒪[K])ˣ, (x : K) = (π : K) ^ p.1 * ((p.2 : 𝒪[K]) : K) :=
  sorry

/-- **Layer 1, prime-to-residue-characteristic power classes.** If `n` is a unit in the
valuation ring (equivalently, the residue characteristic does not divide `n`), the
`n`-th-power classes form a finite group in either characteristic. The sharper milestone is
the exact cardinality formula with this hypothesis. -/
example (n : ℕ) (_hn : IsUnit (n : 𝒪[K])) :
    Finite (Kˣ ⧸ (powMonoidHom n : Kˣ →* Kˣ).range) :=
  sorry

/-- **Layer 1, mixed-characteristic power classes.** For a finite extension of `ℚ_p`, the
power-class quotient is finite for every nonzero `n`, including `p`-primary `n`. This is a
separate theorem using deep units; it must not be generalized to equal characteristic.
The equal-characteristic `p`-primary counterexample and its Artin–Schreier–Witt replacement
remain prose-only scope exclusions in the roadmap. -/
example (p : ℕ) [Fact p.Prime] (F : Type*) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (_hn : n ≠ 0) :
    Finite (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) :=
  sorry

/-- **Layer 1, worked example: `ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (classes of `−1, 2, 5`
generate). The odd-`p` count is `4`; this factor-of-two dyadic difference is why no layer
may assume `p ≠ 2`. -/
example : Nat.card (ℚ_[2]ˣ ⧸ (powMonoidHom 2 : ℚ_[2]ˣ →* ℚ_[2]ˣ).range) = 8 :=
  sorry

/-- **Layer 1, worked example: the dyadic deep-square bound.** Units of `ℤ_2` congruent to
`1 mod 8` are squares (`U(K, 2e+1) ⊆ (Kˣ)²` at `K = ℚ_2`, `e = 1`; the sharp threshold). -/
example (u : ℤ_[2]ˣ) (hu : (8 : ℤ_[2]) ∣ ((u : ℤ_[2]) - 1)) : IsSquare u :=
  sorry

/-! ## Layer 2: unramified extensions and Frobenius -/

/-- **Layer 2 (enabler), Galois invariance of the valuation.** Every `K`-algebra
automorphism of a finite extension `L/K` of local fields preserves the canonical valuation
(uniqueness of the extended valuation class). This is what makes `Gal(L/K)` act on `𝒪[L]`,
`𝓂[L]`, and the residue field — the gateway to the decomposition/inertia/ramification
theory of Layer 3. -/
example [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    (σ : L ≃ₐ[K] L) (x : L) :
    valuation L (σ x) = valuation L x :=
  sorry

/-- **Layer 2, worked example: the unramified quadratic extension of `ℚ_2`.** Adjoining the
cube roots of unity (equivalently `√5`, or `√−3`) gives the degree-`2` extension with
residue field `𝔽_4`; the general milestone is `[K(μ_{q^f−1}) : K] = f` with
`Gal ≅ Gal(𝓀-extension)`, Frobenius-generated. -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 3 = 1}) = 2 :=
  sorry

/-- **Layer 2, worked example: units of `ℚ_2` are norms from the unramified quadratic
extension** (`u = x² − 5y²` solvable over `ℤ_2` — norm surjectivity on units,
Serre LF V §2; the input to the fundamental-class layer and to gq2's B10 orientation). -/
example (u : ℤ_[2]ˣ) : ∃ x y : ℤ_[2], (u : ℤ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  sorry

/-- **Layer 2, worked example: `2` is *not* a norm from the unramified quadratic extension**
(`N(ℚ_2(√5)ˣ) = ⟨4⟩ × ℤ_2ˣ` has index `2`; a uniformizer detects the unramified norm
group). -/
example : ¬ ∃ x y : ℚ_[2], (2 : ℚ_[2]) = x ^ 2 - 5 * y ^ 2 :=
  sorry

/-! ## Layer 3: ramification (worked examples; the filtration itself is README-only) -/

/-- **Layer 3, worked example: a totally ramified quadratic extension.** `ℚ_2(√2)/ℚ_2` has
degree `2` (Eisenstein `X² − 2`); the general milestone is the totally-ramified ↔
Eisenstein correspondence. -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 2 = 2}) = 2 :=
  sorry

/-- **Layer 3, worked example: the dyadic cyclotomic tower is totally ramified.**
`[ℚ_2(μ_8) : ℚ_2] = φ(8) = 4` (its ramification filtration `G = G_0 = G_1 ⊋ G_2 = G_3 ⊋
G_4 = 1` is the README's Layer-3 acceptance computation, stated once the filtration
exists). -/
example :
    Module.finrank ℚ_[2]
      (IntermediateField.adjoin ℚ_[2] {x : AlgebraicClosure ℚ_[2] | x ^ 8 = 1}) = 4 :=
  sorry

/-! ## Layers 7–8 acceptance shapes (pin-expressible worked examples)

The reciprocity map, norm groups, regime-correct duality, and the Euler characteristic are
README-only (they consume PR #1). Two mixed-characteristic `ℚ_2` consequences are already
stateable and serve as end-to-end acceptance targets. -/

/-- **Layer 7 acceptance, the norm group of `ℚ_2(√5)` has index 2.** The nonzero values of
the norm form `x² − 5y²` generate an index-`2` subgroup of `ℚ_2ˣ` — the finite-level
norm-group/reciprocity count `[Kˣ : N Lˣ] = [L : K]` in its most concrete instance. -/
example :
    Nat.card
      (ℚ_[2]ˣ ⧸ Subgroup.closure
        {x : ℚ_[2]ˣ | ∃ a b : ℚ_[2], (x : ℚ_[2]) = a ^ 2 - 5 * b ^ 2}) = 2 :=
  sorry

/-- **Layer 8 acceptance, the Hilbert-symbol entry `(−1,−1)_2 = −1`.** `−1` is not a sum of
two squares in `ℚ_2`: the mod-2 duality pairing (through the Kummer identification, the
classical Hilbert symbol — the named bridge statement shared with the
QuadraticFormInvariants roadmap) is nontrivial at `(−1, −1)`. -/
example : ¬ ∃ x y : ℚ_[2], (-1 : ℚ_[2]) = x ^ 2 + y ^ 2 :=
  sorry

/-! ## Layer 9: topological finite generation -/

/-- **Layer 9, `G_K` is topologically finitely generated — sharply, by `[K:ℚ_p] + 2`
elements** (NSW (7.4.1); the route is Layer 9 of `README.md`: reciprocity + the
multiplicative-group module structure + the pro-`p` Frattini criterion from the ProPGroups
sibling on the wild kernel). The bare finite-generation corollary at `K = ℚ_2` is gq2's B1
acceptance statement. -/
example (p : ℕ) [Fact p.Prime] (F : Type*) [Field F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] :
    ∃ s : Finset (Field.absoluteGaloisGroup F),
      s.card ≤ Module.finrank ℚ_[p] F + 2 ∧
        (Subgroup.closure (s : Set (Field.absoluteGaloisGroup F))).topologicalClosure = ⊤ :=
  sorry

end TauCetiRoadmap.LocalFields
