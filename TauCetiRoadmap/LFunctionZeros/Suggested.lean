import Mathlib

/-!
# Zeros of L-functions: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

Mathlib has Jensen's formula, the divisor of a meromorphic function, Phragmén–Lindelöf on a
vertical strip, branches of the logarithm on simply connected sets, and the discreteness of
`riemannZetaZeros`. It has no growth theory for the Gamma function on a vertical strip, no
order of an entire function, no Hadamard factorization, no zero counting, no zero-free region,
and no way to say that a list of zeros is complete. We build that in `TauCeti/`.

The file states pin-elaborating targets from **Layer 0** (order, the entire completion, and
vertical-strip growth), **Layer 1** (Stirling and the branch of `log Γ`), **Layer 2** (the
three conductors), **Layer 4** (the two counts through `MeromorphicOn.divisor`), **Layer 6**
(the zero-free region), **Layer 7** (Riemann–von Mangoldt), and **Layer 9** (certificates and
`GRH`), stated with `sorry` against the pinned Mathlib and, wherever possible, for the Riemann
zeta function, whose completed form is the one instance that exists at the pin. Milestones
whose statements need the L-functions roadmap's data record, or objects no layer has built yet
— Hadamard factorization, the explicit formula, the Dedekind and Hecke instances of the
zero-free region — are in `README.md` only, and are added here as those types become
expressible.

⚠ Two conventions carry most of the weight, and both are stated in the README's conventions
table. Zeros and poles are read off `meromorphicOrderAt` and never off the value `f z`, which
at a pole is a junk value (`Complex.Gamma` and `Gammaℝ` are assigned `0` at theirs). And the
signed `divisorCount`, which the argument principle computes, is a different object from the
natural-valued `zeroCount`, which certificates and `N(T)` use; they agree only on regions with
no poles.
-/

namespace TauCetiRoadmap.LFunctionZeros

open Complex Filter Topology Asymptotics Bornology MeromorphicOn

/-! ## Layer 0: growth predicates and the entire completion -/

/-- **Layer 0, order at most `A`** for an entire function: `f` is dominated by
`exp (‖s‖ ^ A')` for every `A' > A`. Entirety is *not* part of the predicate, so that it
composes; every theorem calling this the order of an entire function carries
`Differentiable ℂ f` as a hypothesis. The roadmap defines no numeric order and no type. -/
def OrderLE (f : ℂ → ℂ) (A : ℝ) : Prop :=
  ∀ A' : ℝ, A < A' → f =O[cobounded ℂ] fun s ↦ Real.exp (‖s‖ ^ A')

/-- **Layer 0, growth in vertical strips**: polynomial growth in `|Im s|`, uniformly on each
closed vertical strip. This is the hypothesis every counting and convexity statement wants;
Layer 0's main theorem derives it from finite order plus the functional equation. The
constants are constrained (`0 < C`, `0 ≤ A`) so that the predicate cannot be satisfied
vacuously, and the strip is nondegenerate. -/
def HasVerticalStripGrowth (f : ℂ → ℂ) : Prop :=
  ∀ σ₁ σ₂ : ℝ, σ₁ < σ₂ → ∃ C A : ℝ, 0 < C ∧ 0 ≤ A ∧ ∀ s : ℂ, σ₁ ≤ s.re → s.re ≤ σ₂ →
    1 ≤ |s.im| → ‖f s‖ ≤ C * (1 + |s.im|) ^ A

/-- **Layer 0, the completed zeta function grows polynomially in vertical strips.** The pin
proves neither this nor the finite order it follows from. Stated for the meromorphic `Λ`
itself: the hypothesis `1 ≤ |s.im|` keeps the poles at `0` and `1` out of range. -/
example : HasVerticalStripGrowth completedRiemannZeta := sorry

/-- **Layer 0.2, the entire completion of `ζ`, by removable extension.** ⚠ The multiplicative
clearing is *not* the pointwise product: `completedRiemannZeta` is a total representative with
a junk value at its poles, so `fun s ↦ s * (s - 1) * completedRiemannZeta s` takes the value
`0` at `s = 0` and `s = 1` — fake zeros exactly where the clearing polynomial is meant to
remove poles. The milestone is the entire *extension* across the polar support, its agreement
off the poles, and the nonvanishing at them that says the polar orders were exact. ⚠ Mathlib's
`completedRiemannZeta₀` is a different function: it clears the poles additively
(`completedRiemannZeta s = completedRiemannZeta₀ s - 1/s - 1/(1 - s)`), so it is entire but its
zeros are not those of `completedRiemannZeta`, and no counting statement may use it. -/
example :
    ∃ g : ℂ → ℂ, Differentiable ℂ g ∧
      (∀ s : ℂ, s ≠ 0 → s ≠ 1 → g s = s * (s - 1) * completedRiemannZeta s) ∧
      g 0 ≠ 0 ∧ g 1 ≠ 0 ∧ OrderLE g 1 := sorry

/-! ## Layer 1: Stirling asymptotics for the gamma factors -/

/-- **Layer 1.1, a holomorphic branch of `log Γ` on a sector.** Route:
`Complex.exists_continuousOn_eqOn_exp_comp` on the sector, which is open and simply connected
and carries no zero or pole of `Γ`, followed by the upgrade from continuity to holomorphy
(`exp` is a local biholomorphism). ⚠ `Complex.log ∘ Gamma` is **not** a branch: nonvanishing
of `Γ` does not make the principal logarithm of its image continuous. ⚠ The normalization
`L 2 = 0` is part of the statement, and is consistent because `Γ 2 = 1`: without it the branch
is determined only up to `2πi k`, which moves the constant term of Stirling's formula. -/
example (δ : ℝ) (hδ : 0 < δ) (hδ' : δ < Real.pi) :
    ∃ L : ℂ → ℂ,
      DifferentiableOn ℂ L {s : ℂ | |s.arg| < Real.pi - δ ∧ 1 < ‖s‖} ∧
      Set.EqOn (Complex.exp ∘ L) Gamma {s : ℂ | |s.arg| < Real.pi - δ ∧ 1 < ‖s‖} ∧
      L 2 = 0 := sorry

/-- **Layer 1.3, the Stirling estimate on a vertical line**, in the additive `log ‖·‖` form the
later layers compose over products, uniformly for `σ` in a compact interval and along
`|t| → ∞` in both directions (`cocompact ℝ`, not `atTop`). -/
example (a b : ℝ) :
    ∃ C : ℝ, ∀ᶠ t : ℝ in cocompact ℝ, ∀ σ ∈ Set.Icc a b,
      |Real.log ‖Gamma (σ + t * I)‖ -
          ((σ - 1 / 2) * Real.log |t| - Real.pi * |t| / 2 + Real.log (2 * Real.pi) / 2)| ≤
        C / |t| := sorry

/-- **Layer 1.4, the digamma bound** `Γ'/Γ (s) = log s + O(1/‖s‖)`, on a right half-plane
(the roadmap asks for it on any sector `|arg s| ≤ π − δ`). -/
example :
    (fun s : ℂ ↦ digamma s - Complex.log s) =O[cobounded ℂ ⊓ 𝓟 {s : ℂ | 1 ≤ s.re}]
      fun s ↦ (‖s‖)⁻¹ := sorry

/-- **Layer 1.5, the gamma factor has no zeros.** Its poles are the negative translates of the
shifts, and the statement is about `meromorphicOrderAt`, never about the value: at a pole of
`Gammaℝ` the total representative is `0`, which is why `Gammaℝ_eq_zero_iff` must not be read
as a vanishing statement. -/
example (n : ℕ) : meromorphicOrderAt Gammaℝ (-2 * n) = (-1 : WithTop ℤ) := sorry

/-! ## Layer 2: the three conductors -/

/-- **Layer 2, the analytic conductor at a point**, Iwaniec–Kowalski (5.7), from the
arithmetic conductor `N` (the record's field, which is what `q` never means on its own) and
the spectral parameters. The `+ 3` is part of the convention. Each `Gammaℂ (s + ν)` contributes
the pair of shifts `ν, ν + 1` that `Gammaℝ_mul_Gammaℝ_add_one` splits it into, not
`(‖s + ν‖ + 3) ^ 2`: only the paired form is an equality with the modular forms roadmap's
`𝔮(f, s)`, whose newform value `N · (|s + (k−1)/2| + 3) · (|s + (k+1)/2| + 3)` is this
definition at `gammaC = {(k−1)/2}`. -/
noncomputable def analyticConductorAt (N : ℕ+) (gammaR gammaC : Multiset ℂ) (s : ℂ) : ℝ :=
  ((N : ℕ) : ℝ) * (gammaR.map fun μ ↦ ‖s + μ‖ + 3).prod
    * (gammaC.map fun ν ↦ (‖s + ν‖ + 3) * (‖s + ν + 1‖ + 3)).prod

/-- **Layer 2, the central analytic conductor**: the value at the central point of the
analytic normalization. The modular forms roadmap's `𝔮(f) = 𝔮(f, k/2)` is this quantity after
the normalization translation, which is why the central point is `1/2` here and `k/2` there. -/
noncomputable def centralAnalyticConductor (N : ℕ+) (gammaR gammaC : Multiset ℂ) : ℝ :=
  analyticConductorAt N gammaR gammaC (1 / 2)

/-- **Layer 2.2, the two-sided comparison on a strip.** ⚠ This replaces monotonicity in
`|Im s|`, which is false for a complex shift: `‖s + μ‖ + 3` decreases as `Im s` approaches
`-Im μ`. ⚠ The quantifier order is the statement: `C₁` and `C₂` are chosen before the
conductor and before the spectral parameters, and depend only on the strip, the degree, and
the bound `B` on the shifts. Quantifying them after `N` would allow them to depend on the
conductor, which is exactly the uniformity the milestone is about. -/
example (a b B : ℝ) (dR dC : ℕ) :
    ∃ C₁ C₂ : ℝ, 0 < C₁ ∧ 0 < C₂ ∧
      ∀ (N : ℕ+) (gammaR gammaC : Multiset ℂ), gammaR.card = dR → gammaC.card = dC →
        (∀ μ ∈ gammaR, ‖μ‖ ≤ B) → (∀ ν ∈ gammaC, ‖ν‖ ≤ B) →
        ∀ σ ∈ Set.Icc a b, ∀ t : ℝ,
          C₁ * ((N : ℕ) : ℝ) * (|t| + 3) ^ (dR + 2 * dC) ≤
              analyticConductorAt N gammaR gammaC (σ + t * I) ∧
            analyticConductorAt N gammaR gammaC (σ + t * I) ≤
              C₂ * ((N : ℕ) : ℝ) * (|t| + 3) ^ (dR + 2 * dC) := sorry

/-- **Layer 2, the conductor grows like `q · |t|^{degree}`.** Stated for the Riemann zeta
data (`N = 1`, one real gamma factor at shift `0`), where it is a bound on `|t| + 3`. -/
example :
    (fun t : ℝ ↦ analyticConductorAt 1 {0} 0 (t * I)) =Θ[atTop] fun t : ℝ ↦ |t| := sorry

/-! ## Layer 4: the two counts -/

/-- **Layer 4.1, the signed divisor count** of `f` over a region `R`, for `f` meromorphic on
an ambient open `U ⊇ R`: poles contribute negatively. This is what a contour integral of
`logDeriv f` computes (Layer 7.2), and it is *not* a number of zeros. ⚠ `MeromorphicOn.divisor`
is total, with junk value `0` off `U` and where `f` is not meromorphic, so meromorphy on `U` is
a hypothesis of every theorem about this count; and a `∑ᶠ` over an infinite support is silently
`0`, so finiteness of the support in `R` is a companion theorem, not an afterthought. -/
noncomputable def divisorCount (f : ℂ → ℂ) (U R : Set ℂ) : ℤ :=
  ∑ᶠ ρ ∈ R, MeromorphicOn.divisor f U ρ

/-- **Layer 4.1, the zero count**: the natural-valued sum of the multiplicities of the
positive part of the divisor, `(MeromorphicOn.divisor f U)⁺` read pointwise. This is what
`N(T)`, Riemann–von Mangoldt, and every certificate use. It equals `divisorCount` exactly when
`R` contains no pole (`∀ z ∈ R, 0 ≤ divisor f U z`), which is a hypothesis and never an
inference: without it, an omitted zero and an omitted pole cancel in the signed count. -/
noncomputable def zeroCount (f : ℂ → ℂ) (U R : Set ℂ) : ℕ :=
  ∑ᶠ ρ ∈ R, (MeromorphicOn.divisor f U ρ).toNat

/-- **The closed rectangle** `[σ₁, σ₂] × [t₁, t₂]`, as a four-real bundle over the exact set
expression the conventions table pins. Closed rectangles with regular boundary carry contour
integrals and certificates. The ordering of the endpoints is `Rect.Valid` rather than a
structure field, so that the definitions below stay total: `Set.Icc` of a reversed pair is
empty, so an invalid rectangle has empty region and count `0`, and validity is carried
explicitly by every statement that needs it. -/
structure Rect where
  /-- Left edge. -/
  σ₁ : ℝ
  /-- Right edge. -/
  σ₂ : ℝ
  /-- Bottom edge. -/
  t₁ : ℝ
  /-- Top edge. -/
  t₂ : ℝ

/-- The underlying set of a closed rectangle. -/
def Rect.toSet (B : Rect) : Set ℂ := Set.Icc B.σ₁ B.σ₂ ×ℂ Set.Icc B.t₁ B.t₂

/-- The endpoints of a rectangle are in order. Required wherever the geometry matters: the
boundary of an invalid rectangle is not the four edges, and its interior is empty. -/
def Rect.Valid (B : Rect) : Prop := B.σ₁ ≤ B.σ₂ ∧ B.t₁ ≤ B.t₂

/-- The half-open rectangle `[σ₁, σ₂] × (t₁, t₂]`, which is what exact partitions and `N(T)`
use: a zero on a shared horizontal edge is counted once rather than twice. -/
def Rect.toSetHalfOpen (B : Rect) : Set ℂ := Set.Icc B.σ₁ B.σ₂ ×ℂ Set.Ioc B.t₁ B.t₂

/-- **Layer 4.3, exact additivity, on half-open rectangles.** ⚠ The closed statement is false:
two closed rectangles sharing an edge both contain a zero on that edge, so a subdivision
double-counts it. The closed version needs the hypothesis that the shared boundary is regular
and zero-free. ⚠ Finiteness is a hypothesis, not a consequence: `∑ᶠ` returns `0` on an
infinite support, and a function meromorphic on `U` can have infinitely many zeros in a
bounded rectangle when that rectangle is not relatively compact in `U`, so the three finsums
would all be junk and the equation would say nothing. The clean sufficient hypothesis is the
one displayed here — meromorphy on `U`, the closed rectangle contained in `U`, and finite
divisor support on it — and the corresponding statement for a vertical subdivision needs a
half-open real interval as well, or the zero-free-shared-edge hypothesis. -/
example (f : ℂ → ℂ) (U : Set ℂ) (σ₁ σ₂ t₁ t₂ t₃ : ℝ) (h₁ : t₁ ≤ t₂) (h₂ : t₂ ≤ t₃)
    (hf : MeromorphicOn f U) (hU : Rect.toSet ⟨σ₁, σ₂, t₁, t₃⟩ ⊆ U)
    (hfin : (Function.support fun ρ ↦ MeromorphicOn.divisor f U ρ) ∩
      Rect.toSet ⟨σ₁, σ₂, t₁, t₃⟩ |>.Finite) :
    zeroCount f U (Rect.toSetHalfOpen ⟨σ₁, σ₂, t₁, t₃⟩) =
      zeroCount f U (Rect.toSetHalfOpen ⟨σ₁, σ₂, t₁, t₂⟩) +
        zeroCount f U (Rect.toSetHalfOpen ⟨σ₁, σ₂, t₂, t₃⟩) := sorry

/-- **Layer 4, the trivial zeros of `ζ` are not zeros of `Λ`.** They are the points where
`Gammaℝ` has a pole and `riemannZeta` a compensating zero, so the completed function is regular
and nonvanishing there. Verifying this on the order is the first check that the counting
convention is the intended one. -/
example (n : ℕ) : meromorphicOrderAt completedRiemannZeta (-2 * (n + 1)) = 0 := sorry

/-- **Layer 4, the poles of `Λ` are points of negative divisor**, not zeros, and not detectable
from the value of the total representative at `1`. -/
example : MeromorphicOn.divisor completedRiemannZeta Set.univ 1 = -1 := sorry

/-- **Layer 4, the zeros of `Λ` lie in the critical strip.** With Layer 6 this becomes the
open strip. -/
example (ρ : ℂ) (hρ : 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ) :
    0 ≤ ρ.re ∧ ρ.re ≤ 1 := sorry

/-- **Layer 4.7, the local count at height `T`.** ⚠ Not a consequence of growth alone: Jensen's
formula bounds the count by `log (M / ‖f c‖)`, and the denominator needs a *lower* bound at an
explicit basepoint. The proof takes the basepoint at `2 + iT`, where the Euler product bounds
`‖ζ‖` away from `0`, and the disc of radius `3` about it contains the unit disc on the critical
line. The region here contains no pole of `Λ` (for `2 ≤ T` the points `0` and `1` are at
distance at least `2`), so the natural-valued count is the right one. -/
example :
    ∃ C : ℝ, ∀ T : ℝ, 2 ≤ T →
      (zeroCount completedRiemannZeta Set.univ (Metric.closedBall (1 / 2 + T * I) 1) : ℝ) ≤
        C * Real.log T := sorry

/-- **Layer 4.9, the counting function `N(T)`**: zeros of the completed function with
`0 < Im ρ ≤ T`, with multiplicity, in the closed critical strip. Half-open in the imaginary
direction, which is what excludes the real axis and makes the partition of 4.3 exact; a zero at
height exactly `T` is counted. ⚠ The symmetric count over `|Im ρ| ≤ T` is a different quantity,
and the factor-of-two relation between them is a theorem with an explicit reality hypothesis
(true for `ζ_K`, and for a Hecke character only when it is real). ⚠ The region is not compact,
so the finiteness that makes this finsum the intended count comes from local finiteness of
`MeromorphicOn.divisor f Set.univ` on the compact closure, through
`Function.locallyFinsupp.locallyFiniteSupport` and
`LocallyFiniteSupport.finite_inter_support_of_isCompact`, not from
`Function.locallyFinsuppWithin.finiteSupport`. -/
noncomputable def zeroCountUpTo (f : ℂ → ℂ) (U : Set ℂ) (T : ℝ) : ℕ :=
  zeroCount f U (Rect.toSetHalfOpen ⟨0, 1, 0, T⟩)

/-- **Layer 4.8, the unit-height count**, which the box-to-disc reduction proves before any
contour integral exists: the unit-height rectangle sits inside the disc of radius `√2/2`
centered on the critical line, so this is one application of the local count. Summing `T` of
them gives `N(T) = O(T log T)` for `ζ`, the strongest counting bound available before Layer 7.
⚠ Differencing the Riemann–von Mangoldt formula does not improve this to an asymptotic: its
error is the same size as the main term of the difference. -/
example :
    (fun T : ℝ ↦ (zeroCountUpTo completedRiemannZeta Set.univ (T + 1) : ℝ) -
        (zeroCountUpTo completedRiemannZeta Set.univ T : ℝ))
      =O[atTop] Real.log := sorry

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

/-- **Layer 7.4, Riemann–von Mangoldt for `ζ`**: `N(T) = (T/2π) log(T/2πe) + O(log T)`, with
`N` counting `0 < Im ρ ≤ T` with multiplicity. The general form carries the degree and the
conductor in the main term; that statement needs the L-functions roadmap's data record and so
lives in `README.md` until the record is available here. The proof runs the argument principle
on the entire completion, not on `Λ`, whose poles at `0` and `1` lie on the lower edge of the
contour. -/
example :
    (fun T : ℝ ↦ (zeroCountUpTo completedRiemannZeta Set.univ T : ℝ) -
        T / (2 * Real.pi) * Real.log (T / (2 * Real.pi * Real.exp 1)))
      =O[atTop] Real.log := sorry

/-! ## Layer 9: certified zeros -/

/-- **Layer 9.1, a complete list of zeros in a rectangle.** `boxes` are closed rectangles
inside `R` with pairwise disjoint interiors, `mult` their multiplicities as natural numbers.
The last field is the whole point: without it the predicate says only that these are *some* of
the zeros. ⚠ Three hypotheses do work that a weaker version silently drops. `no_poles` is what
stops an omitted zero from cancelling an omitted pole in a signed total — with it, the count is
the natural-valued `zeroCount`. Boundary regularity is `meromorphicOrderAt f z = 0`, not
`f z ≠ 0`, because a total representative takes a junk value at a pole and `f z ≠ 0` neither
excludes one nor is implied by regularity. And disjointness is of *interiors*, since abutting
rectangles are the normal case and their shared edge is zero-free by the boundary hypothesis. -/
structure HasZerosInRects (f : ℂ → ℂ) (U : Set ℂ) (R : Rect) (boxes : List Rect)
    (mult : List ℕ) : Prop where
  /-- The ambient set is open. -/
  isOpen : IsOpen U
  /-- The region has its endpoints in order. -/
  valid_region : R.Valid
  /-- Each listed rectangle has its endpoints in order. -/
  valid_boxes : ∀ B ∈ boxes, B.Valid
  /-- `f` is meromorphic on the ambient open set. -/
  meromorphic : MeromorphicOn f U
  /-- The region lies in the ambient set. -/
  region_subset : R.toSet ⊆ U
  /-- No poles in the region, so that the signed and unsigned counts agree on it. -/
  no_poles : ∀ z ∈ R.toSet, 0 ≤ MeromorphicOn.divisor f U z
  /-- Each rectangle lies in the region. -/
  boxes_subset : ∀ B ∈ boxes, B.toSet ⊆ R.toSet
  /-- The rectangles have pairwise disjoint interiors. -/
  boxes_pairwise_disjoint :
    boxes.Pairwise fun B B' ↦ Disjoint (interior B.toSet) (interior B'.toSet)
  /-- `f` is regular and nonvanishing on the boundary of the region. -/
  regular_frontier : ∀ z ∈ frontier R.toSet, meromorphicOrderAt f z = 0
  /-- `f` is regular and nonvanishing on the boundary of each rectangle. -/
  regular_frontier_box : ∀ B ∈ boxes, ∀ z ∈ frontier B.toSet, meromorphicOrderAt f z = 0
  /-- Each rectangle contains exactly the recorded number of zeros, with multiplicity. -/
  count_box : List.Forall₂ (fun B m ↦ zeroCount f U B.toSet = m) boxes mult
  /-- The list is complete: the region contains no other zeros. -/
  count_region : zeroCount f U R.toSet = mult.sum

/-- **Layer 9.2, coverage** — the theorem that says the predicate means what its name says.
Every zero of the region lies in one of the listed rectangles. ⚠ Its proof sums the nonnegative
divisor and compares; it must not subtract signed counts, which is exactly the step the
`no_poles` and `ℕ`-multiplicity choices are there to make unnecessary. -/
example (f : ℂ → ℂ) (U : Set ℂ) (R : Rect) (boxes : List Rect) (mult : List ℕ)
    (h : HasZerosInRects f U R boxes mult) (ρ : ℂ) (hρ : ρ ∈ R.toSet)
    (hpos : 0 < MeromorphicOn.divisor f U ρ) :
    ∃ B ∈ boxes, ρ ∈ B.toSet := sorry

/-- **Layer 9.4, on the critical line**, defined semantically. ⚠ "Each rectangle meets the
line `Re s = 1/2`" is *not* this predicate and does not imply it: a wide rectangle can meet the
line and contain off-line zeros. -/
def AllOnCriticalLine (f : ℂ → ℂ) (U : Set ℂ) (R : Rect) : Prop :=
  ∀ ρ ∈ R.toSet, 0 < MeromorphicOn.divisor f U ρ → ρ.re = 1 / 2

/-- **Layer 9.4, the symmetry-and-uniqueness criterion**, the one a numerical certificate can
actually supply: a rectangle invariant under `s ↦ 1 - conj s`, for a function whose *divisor*
has the same invariance, containing exactly one zero, has that zero on the critical line.
⚠ The hypothesis is on the divisor, not on the values: `Λ` satisfies
`Λ (1 - conj s) = conj (Λ s)`, not `Λ (1 - conj s) = Λ s`, and it is the zero set that the
argument uses. ⚠ Multiplicity one is essential: a reflection-conjugate pair inside the
rectangle satisfies every other hypothesis. -/
example (f : ℂ → ℂ) (U : Set ℂ) (B : Rect)
    (hU : ∀ s ∈ U, 1 - (starRingEnd ℂ) s ∈ U)
    (hf : ∀ s ∈ U, MeromorphicOn.divisor f U (1 - (starRingEnd ℂ) s) =
      MeromorphicOn.divisor f U s)
    (hB : ∀ s ∈ B.toSet, 1 - (starRingEnd ℂ) s ∈ B.toSet)
    (hcount : zeroCount f U B.toSet = 1) :
    AllOnCriticalLine f U B := sorry

/-- **Layer 9.5, `GRH` for the zeta instance is the pin's `RiemannHypothesis`.** Proving this
is what makes the general definition trustworthy; a `GRH` predicate that does not specialize
to Mathlib's statement is the wrong predicate. The bridge is that a point of positive divisor
of `completedRiemannZeta` is exactly a nontrivial zero of `riemannZeta`: the trivial zeros are
cancelled by the poles of `Gammaℝ`, and `0` and `1` are points of negative divisor. -/
example :
    (∀ ρ : ℂ, 0 < MeromorphicOn.divisor completedRiemannZeta Set.univ ρ → ρ.re = 1 / 2) ↔
      RiemannHypothesis := sorry

end TauCetiRoadmap.LFunctionZeros
