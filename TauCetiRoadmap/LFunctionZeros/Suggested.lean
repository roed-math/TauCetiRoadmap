import Mathlib

/-!
# Zeros of L-functions: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

Mathlib has Jensen's formula, the divisor of a meromorphic function, Phragmén–Lindelöf on a
vertical strip, and the discreteness of `riemannZetaZeros`. It has no growth theory for the
Gamma function on a vertical strip, no order of an entire function, no Hadamard
factorization, no zero counting, no zero-free region, and no way to say that a list of zeros
is complete. We build that in `TauCeti/`.

The file states pin-elaborating targets from **Layer 0** (order and vertical-strip growth),
**Layer 1** (Stirling for `Complex.Gamma`), **Layer 2** (the analytic conductor), **Layer 4**
(zero counting through `MeromorphicOn.divisor`), **Layer 6** (the zero-free region), **Layer
7** (Riemann–von Mangoldt), and **Layer 9** (certificates and `GRH`), stated with `sorry`
against the pinned Mathlib and, wherever possible, for the Riemann zeta function, whose
completed form is the one instance that exists at the pin. Milestones whose statements need
the L-functions roadmap's data record, or objects no layer has built yet — Hadamard
factorization, the explicit formula, the Dedekind and Hecke instances of the zero-free region
— are in `README.md` only, and are added here as those types become expressible.
-/

namespace TauCetiRoadmap.LFunctionZeros

open Complex Filter Topology Asymptotics Bornology MeromorphicOn

/-! ## Layer 0: growth predicates -/

/-- **Layer 0, order at most `A`** for an entire function: `f` is dominated by
`exp (‖s‖ ^ A')` for every `A' > A`. The order of `f` is the infimum of such `A`; this
predicate, not the infimum, is what the later layers hypothesize. -/
def OrderLE (f : ℂ → ℂ) (A : ℝ) : Prop :=
  ∀ A' : ℝ, A < A' → f =O[cobounded ℂ] fun s ↦ Real.exp (‖s‖ ^ A')

/-- **Layer 0, growth in vertical strips**: polynomial growth in `|Im s|`, uniformly on each
closed vertical strip. This is the hypothesis every counting and convexity statement wants;
Layer 0's main theorem derives it from finite order plus the functional equation. -/
def HasVerticalStripGrowth (f : ℂ → ℂ) : Prop :=
  ∀ σ₁ σ₂ : ℝ, ∃ C A : ℝ, ∀ s : ℂ, σ₁ ≤ s.re → s.re ≤ σ₂ → 1 ≤ |s.im| →
    ‖f s‖ ≤ C * (1 + |s.im|) ^ A

/-- **Layer 0, the completed zeta function grows polynomially in vertical strips.** The pin
proves neither this nor the finite order it follows from. -/
example : HasVerticalStripGrowth completedRiemannZeta₀ := sorry

/-- **Layer 0, the completed zeta function has order at most `1`.** The hypothesis Hadamard
factorization needs, and the one place where "finite order" has to be earned rather than
assumed. -/
example : OrderLE completedRiemannZeta₀ 1 := sorry

/-! ## Layer 1: Stirling asymptotics for the gamma factors -/

/-- **Layer 1, the Stirling estimate for `Complex.Gamma` on a vertical line**:
`‖Γ(σ + it)‖ ∼ √(2π) |t|^{σ − 1/2} exp(−π|t|/2)` as `|t| → ∞`. Absent at the pin, where
`Analysis/SpecialFunctions/Stirling.lean` covers only `n !` and `BohrMollerup` only the real
characterization. The roadmap also asks for the version uniform in `σ` over a compact
interval, which needs a statement shape this example does not fix. -/
example (σ : ℝ) :
    Tendsto
      (fun t : ℝ ↦ ‖Gamma (σ + t * I)‖ /
        (Real.sqrt (2 * Real.pi) * |t| ^ (σ - 1 / 2) * Real.exp (-Real.pi * |t| / 2)))
      atTop (𝓝 1) := sorry

/-- **Layer 1, the digamma bound** `Γ'/Γ (s) = log s + O(1/‖s‖)`, on a right half-plane
(the roadmap asks for it on any sector `|arg s| ≤ π − δ`). -/
example :
    (fun s : ℂ ↦ digamma s - Complex.log s) =O[cobounded ℂ ⊓ 𝓟 {s : ℂ | 1 ≤ s.re}]
      fun s ↦ (‖s‖)⁻¹ := sorry

/-! ## Layer 2: the analytic conductor -/

/-- **Layer 2, the analytic conductor** of Iwaniec–Kowalski (5.7), from the arithmetic
conductor and the spectral parameters of the L-functions roadmap's data record. The `+ 3` is
part of the convention. -/
noncomputable def analyticConductor (N : ℕ) (gammaR gammaC : Multiset ℂ) (s : ℂ) : ℝ :=
  (N : ℝ) * (gammaR.map fun μ ↦ ‖s + μ‖ + 3).prod
    * (gammaC.map fun ν ↦ (‖s + ν‖ + 3) ^ 2).prod

/-- **Layer 2, the conductor grows like `q · |t|^{degree}`.** Stated for the Riemann zeta
data (`N = 1`, one real gamma factor at shift `0`), where it is a bound on `|t| + 3`. -/
example :
    (fun t : ℝ ↦ analyticConductor 1 {0} 0 (t * I)) =Θ[atTop] fun t : ℝ ↦ |t| := sorry

/-! ## Layer 4: zero counting -/

/-- **Layer 4, the zero count of `f` in a region**, with multiplicity: the sum of the
divisor. Poles enter with negative sign, which is why every counting statement below is on a
region avoiding them. -/
noncomputable def zeroCount (f : ℂ → ℂ) (R : Set ℂ) : ℤ :=
  ∑ᶠ ρ, MeromorphicOn.divisor f R ρ

/-- **Layer 4, the trivial zeros of `ζ` are not zeros of `Λ`.** They are poles of the gamma
factor. Verifying this on the divisor is the first check that the counting convention is the
intended one. -/
example (n : ℕ) :
    MeromorphicOn.divisor completedRiemannZeta Set.univ (-2 * (n + 1)) = 0 := sorry

/-- **Layer 4, the zeros of `Λ` lie in the critical strip.** With Layer 6 this becomes the
open strip. -/
example (ρ : ℂ) (hρ : 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ) :
    0 ≤ ρ.re ∧ ρ.re ≤ 1 := sorry

/-- **Layer 4, Jensen's bound in the form the counting layer uses**: a completed L-function
of finite order has `O(log(|T| + 3))` zeros in a unit disc at height `T`. Route:
`AnalyticOnNhd.sum_divisor_le`. -/
example :
    ∃ C : ℝ, ∀ T : ℝ, 1 ≤ T →
      zeroCount completedRiemannZeta₀ (Metric.closedBall (1 / 2 + T * I) 1) ≤
        ⌈C * Real.log (T + 3)⌉ := sorry

/-- **Layer 4, the counting function `N(T)`**: zeros of the completed function with
`0 < Im ρ ≤ T`, with multiplicity, in the closed critical strip. ⚠ The symmetric count over
`|Im ρ| ≤ T` is a different quantity; the roadmap keeps them apart and relates them by a
theorem. -/
noncomputable def zeroCountUpTo (f : ℂ → ℂ) (T : ℝ) : ℤ :=
  zeroCount f (Set.Icc (0 : ℝ) 1 ×ℂ Set.Ioc (0 : ℝ) T)

/-! ## Layer 6: the zero-free region -/

/-- **Layer 6, the de la Vallée Poussin region for `ζ`**, the first instance of the general
statement and the one the pin can already talk about. ⚠ The general theorem is stated per
family, never for a bare record satisfying the data-model predicates: the proof needs the
Euler product and the nonnegativity of the von Mangoldt coefficients. -/
example :
    ∃ c : ℝ, 0 < c ∧ ∀ ρ : ℂ, 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ →
      ρ.re < 1 - c / Real.log (|ρ.im| + 3) := sorry

/-- **Layer 6, the qualitative boundary case**, which is the pin's
`riemannZeta_ne_zero_of_one_le_re` recovered from the region. -/
example (ρ : ℂ) (hρ : 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ) :
    ρ.re < 1 := sorry

/-! ## Layer 7: the Riemann–von Mangoldt formula -/

/-- **Layer 7, Riemann–von Mangoldt for `ζ`**: `N(T) = (T/2π) log(T/2πe) + O(log T)`, with
`N` counting `0 < Im ρ ≤ T` with multiplicity. The general form carries the degree and the
conductor in the main term; that statement needs the L-functions roadmap's data record and
so lives in `README.md` until the record is available here. -/
example :
    (fun T : ℝ ↦ (zeroCountUpTo completedRiemannZeta T : ℝ) -
        T / (2 * Real.pi) * Real.log (T / (2 * Real.pi * Real.exp 1)))
      =O[atTop] Real.log := sorry

/-! ## Layer 9: certified zeros -/

/-- **Layer 9, a complete list of zeros in a rectangle.** `boxes` are pairwise disjoint
closed rectangles inside `R`, `mult` their multiplicities. The last conjunct is the whole
point: without it the predicate says only that these are *some* of the zeros. Nonvanishing
on the boundaries is a hypothesis because a zero on a boundary makes the count unstable. -/
structure HasZerosInBoxes (f : ℂ → ℂ) (R : Set ℂ) (boxes : List (Set ℂ)) (mult : List ℤ) :
    Prop where
  /-- Each box lies in the region. -/
  boxes_subset : ∀ B ∈ boxes, B ⊆ R
  /-- The boxes are pairwise disjoint. -/
  boxes_pairwise_disjoint : boxes.Pairwise Disjoint
  /-- `f` does not vanish on the boundary of the region. -/
  ne_zero_frontier : ∀ z ∈ frontier R, f z ≠ 0
  /-- `f` does not vanish on the boundary of any box. -/
  ne_zero_frontier_box : ∀ B ∈ boxes, ∀ z ∈ frontier B, f z ≠ 0
  /-- Each box contains exactly the recorded number of zeros, with multiplicity. -/
  count_box : List.Forall₂ (fun B m ↦ zeroCount f B = m) boxes mult
  /-- The list is complete: the region contains no other zeros. -/
  count_region : zeroCount f R = (mult.sum : ℤ)

/-- **Layer 9, `GRH` for the zeta instance is the pin's `RiemannHypothesis`.** Proving this
is what makes the general definition trustworthy; a `GRH` predicate that does not specialize
to Mathlib's statement is the wrong predicate. -/
example :
    (∀ ρ : ℂ, 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ → ρ.re = 1 / 2) ↔
      RiemannHypothesis := sorry

end TauCetiRoadmap.LFunctionZeros
