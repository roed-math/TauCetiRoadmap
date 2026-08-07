import Mathlib

/-!
# L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

Mathlib has the Loeffler–Stoll `LSeries` stack with the ζ and Dirichlet functional
equations, Roblot's `dedekindZeta` with the class number formula, and the `IsArithFrobAt`
Frobenius vocabulary — but no L-function data model, no translation between the arithmetic
and analytic normalizations, no Dedekind continuation or functional equation, no Hecke
L-functions, no density notions, and no Chebotarev. We build that in `TauCeti/`.

The file states pin-elaborating targets from **Layer 0** (the analytic data record, its ζ and
Dirichlet cards, and the normalization translation), **Layer 1** (the norm coefficient, its
weighted form, local Euler-factor data, the Euler product), **Layer 3** (continuation and
functional equation of the Dedekind zeta function, in `∃`-form since the continued objects do
not exist yet), **Layer 4** (the `ℚ(i)` factorization), **Layer 7** (Landau's theorem and
nonvanishing in meromorphic-order form), **Layer 8** (the density predicates and Chebotarev
over a general base field), and **Layer 9** (Wiener–Ikehara, `ψ_K`, `θ_K`, `π_K`), with
`sorry`.

Four cross-roadmap interfaces are stated here as **compatibility interfaces**, and not left
as prose: `IntegralLatticeInterface` for Layers 2.10 and 2.11, `RayClassCharacter` for
Layer 5.1, `Grossencharacter` for Layer 6.1, and `FrobeniusInterface` for Layer 8.0. Each is a small structure carrying the operations the
later milestones use. When the supplying roadmap's declaration exists, the replacement is
mechanical: delete the structure here, make the name an abbreviation for theirs, and leave
every statement below unchanged.

Per the honest-`sorry` rule, a milestone whose *statement* needs API that does not exist at
the pin is not stated here, and lives in `README.md` only. That applies to the lattice theta
transformations of Layer 2, since the pin has no dual lattice.
-/

namespace TauCetiRoadmap.LFunctions

open Complex NumberField NumberField.InfinitePlace Filter Topology Asymptotics
open IsDedekindDomain (HeightOneSpectrum)

/-! ## Layer 0: the L-function data model -/

/-- **Layer 0.1, the data an LMFDB L-function carries, in the analytic normalization.**
The name is not decoration: the functional equation of `HasFunctionalEquation` reflects in
`s ↦ 1 - s`, Dirichlet agreement holds on `Re s > 1`, and the shifts are the analytic ones.
The record carries no motivic weight; an arithmetic-normalized object reaches these
predicates through `NormalizationTranslation` below.

Conventions (see `README.md`): the completed function *includes* the conductor power
`N^{s/2}`, so the functional equation is constant-free; the spectral parameters are the
`Gammaℝ`/`Gammaℂ` shift multisets. `completed` is a total representative because that is
Mathlib's function type, but no predicate below inspects its values at poles.
`polarOrder p = n` records an exact pole of order `n`; finite support is built into the data,
and order zero means holomorphic, so a zero is allowed there. -/
structure AnalyticLFunctionData where
  /-- Dirichlet coefficients (the `n = 0` value is irrelevant, as in `LSeries`). -/
  coeff : ℕ → ℂ
  /-- The (arithmetic) conductor. -/
  conductor : ℕ+
  /-- Shifts `μ` of the real Gamma factors `Gammaℝ (s + μ)`. -/
  gammaR : Multiset ℂ
  /-- Shifts `ν` of the complex Gamma factors `Gammaℂ (s + ν)`. -/
  gammaC : Multiset ℂ
  /-- The root number `ε`. -/
  rootNumber : ℂ
  /-- The completed L-function `Λ`, conductor power included. -/
  completed : ℂ → ℂ
  /-- Exact finite polar divisor: the value at `p` is the order of the pole at `p`. -/
  polarOrder : ℂ →₀ ℕ

namespace AnalyticLFunctionData

/-- The degree, determined by the Gamma data. -/
def degree (d : AnalyticLFunctionData) : ℕ := d.gammaR.card + 2 * d.gammaC.card

/-- The archimedean factor `γ(s) = ∏ Gammaℝ (s + μ) · ∏ Gammaℂ (s + ν)`. -/
noncomputable def gammaFactor (d : AnalyticLFunctionData) (s : ℂ) : ℂ :=
  (d.gammaR.map fun μ ↦ Gammaℝ (s + μ)).prod * (d.gammaC.map fun ν ↦ Gammaℂ (s + ν)).prod

/-- The conjugate-dual completed function `Λ^∨(s) = conj (Λ (conj s))`; the dual of an
instance is the instance with conjugate coefficients, and the functional equation relates
`Λ(s)` to `Λ^∨(1 − s)`. -/
noncomputable def dualCompleted (d : AnalyticLFunctionData) (s : ℂ) : ℂ :=
  starRingEnd ℂ (d.completed (starRingEnd ℂ s))

/-- The point of the original completed function inspected by the right side of the
functional equation at `s`. -/
noncomputable def reflectedPoint (s : ℂ) : ℂ := 1 - starRingEnd ℂ s

/-- **Layer 0.2, the dual record.** ⚠ `dualCompleted` is a function; the functional equation of
a **non-self-dual** record relates `d` to a whole other *record*, not to itself, and every
consumer that states the equation needs that record by name. It is owned here, so that no
downstream roadmap has to build its own: conjugate coefficients, conjugated shifts, conjugated
root number, the same conductor, `completed = d.dualCompleted`, and the polar divisor
transported along `p ↦ conj p`. -/
noncomputable def dual (d : AnalyticLFunctionData) : AnalyticLFunctionData where
  coeff n := starRingEnd ℂ (d.coeff n)
  conductor := d.conductor
  gammaR := d.gammaR.map (starRingEnd ℂ)
  gammaC := d.gammaC.map (starRingEnd ℂ)
  rootNumber := starRingEnd ℂ d.rootNumber
  completed := d.dualCompleted
  polarOrder := d.polarOrder.mapDomain (starRingEnd ℂ)

theorem dual_gammaFactor (d : AnalyticLFunctionData) (s : ℂ) :
    d.dual.gammaFactor s = starRingEnd ℂ (d.gammaFactor (starRingEnd ℂ s)) := sorry

theorem dual_dual (d : AnalyticLFunctionData) : d.dual.dual = d := sorry

theorem dual_degree (d : AnalyticLFunctionData) : d.dual.degree = d.degree := sorry

/-- **Layer 0.2, self-duality.** For a record with real coefficients and real shifts — which
covers `ζ_K` and every real character — the dual is the record itself, and the functional
equation collapses to the familiar reflection. A non-real finite-order Hecke character is the
test that catches a statement written as though it always did. -/
theorem dual_eq_self {d : AnalyticLFunctionData}
    (hcoeff : ∀ n, starRingEnd ℂ (d.coeff n) = d.coeff n)
    (hR : d.gammaR.map (starRingEnd ℂ) = d.gammaR)
    (hC : d.gammaC.map (starRingEnd ℂ) = d.gammaC)
    (hε : starRingEnd ℂ d.rootNumber = d.rootNumber)
    (hΛ : d.dualCompleted = d.completed)
    (hp : d.polarOrder.mapDomain (starRingEnd ℂ) = d.polarOrder) :
    d.dual = d := sorry

/-- **Layer 0.2, Dirichlet-series agreement.** Independent of continuation, functional
equation, Euler product, and coefficient bounds, because instances satisfy different
subsets. -/
structure HasDirichletAgreement (d : AnalyticLFunctionData) : Prop where
  coeff_one : d.coeff 1 = 1
  degree_pos : 0 < d.degree
  completes : ∀ s : ℂ, 1 < s.re →
    d.completed s = ((d.conductor : ℕ) : ℂ) ^ (s / 2) * d.gammaFactor s * LSeries d.coeff s

/-- **Layer 0.3, genuine meromorphic continuation with exact polar behavior.** A positive
entry in `polarOrder` is certified by `meromorphicOrderAt`; a zero entry requires
nonnegative order, so the point is holomorphic but may be a zero. These conditions depend
only on punctured germs and therefore ignore the representative's arbitrary point values
at poles. -/
structure HasMeromorphicContinuation (d : AnalyticLFunctionData) : Prop where
  meromorphic : Meromorphic d.completed
  exact_pole_order : ∀ p : ℂ, d.polarOrder p ≠ 0 →
    meromorphicOrderAt d.completed p = (- (d.polarOrder p : ℤ) : WithTop ℤ)
  /-- ⚠ Analyticity, and not `0 ≤ meromorphicOrderAt`. `MeromorphicAt` and `meromorphicOrderAt`
  depend only on the punctured germ, so the order condition says nothing about the value at the
  point: changing a genuine continuation at one point leaves it meromorphic with every order
  unchanged. Without this field every statement below about a value of `completed` is a
  statement about an arbitrary number, and the uniqueness milestone 3.5 is false. -/
  regular_away : ∀ p : ℂ, d.polarOrder p = 0 → AnalyticAt ℂ d.completed p

/-- **Layer 0.3, the meromorphic functional equation.** The polar divisor is invariant under
`s ↦ 1 - conj s`, and equality is required only off the two polar loci. Together with
`HasMeromorphicContinuation`, equality on this complement determines the same meromorphic
germ and compatible principal part at every pole; no junk value at a pole is compared. -/
structure HasFunctionalEquation (d : AnalyticLFunctionData) : Prop where
  norm_rootNumber : ‖d.rootNumber‖ = 1
  polarOrder_reflect : ∀ s : ℂ, d.polarOrder s = d.polarOrder (reflectedPoint s)
  /-- Equality at the points where `HasMeromorphicContinuation` makes both sides analytic. At a
  pole the corresponding statement is equality of principal parts, and it follows from the
  identity theorem rather than being a field. -/
  eq_away : ∀ s : ℂ, d.polarOrder s = 0 → d.polarOrder (reflectedPoint s) = 0 →
    d.completed s = d.rootNumber * d.dualCompleted (1 - s)

/-- **Layer 0.3, coefficient growth.** The Ramanujan bound in the on-average form, which is
what every instance can prove; pointwise bounds remain instance-specific. -/
structure HasAverageCoefficientBound (d : AnalyticLFunctionData) : Prop where
  coeff_avg : ∀ δ : ℝ, 0 < δ →
    (fun n : ℕ ↦ ∑ k ∈ Finset.Icc 1 n, ‖d.coeff k‖) =O[atTop] fun n ↦ (n : ℝ) ^ (1 + δ)

/-- **Layer 0.2, predicate transport along the dual record.** ⚠ Without these a consumer cannot
use `dual` in any theorem whose hypotheses are the Layer-0 predicates — which is every theorem
about the functional equation, since that equation names the dual record on its right-hand
side. -/
theorem dual_hasDirichletAgreement {d : AnalyticLFunctionData} (h : d.HasDirichletAgreement) :
    d.dual.HasDirichletAgreement := sorry

theorem dual_hasMeromorphicContinuation {d : AnalyticLFunctionData}
    (h : d.HasMeromorphicContinuation) : d.dual.HasMeromorphicContinuation := sorry

theorem dual_hasAverageCoefficientBound {d : AnalyticLFunctionData}
    (h : d.HasAverageCoefficientBound) : d.dual.HasAverageCoefficientBound := sorry

/-- **Layer 0.2, the functional equation against the dual record**, which is the form a
non-self-dual instance needs and the reason `dual` is owned here. -/
theorem hasFunctionalEquation_dual {d : AnalyticLFunctionData} (h : d.HasFunctionalEquation)
    (s : ℂ) : d.completed s = d.rootNumber * d.dual.completed (1 - s) := sorry

end AnalyticLFunctionData

/-- **Layer 0.4, the same data in the arithmetic normalization**, whose functional equation is
centered at `(w+1)/2` for the motivic weight `w`. The fields are those of
`AnalyticLFunctionData`; only the predicates it is asked to satisfy differ, and it reaches
them through `NormalizationTranslation`. -/
structure ArithmeticLFunctionData extends AnalyticLFunctionData

/-- **Layer 0.4, the translation between the two normalizations.** The direction of every
shift is fixed here rather than left to the implementer: the analytic coefficients are the
arithmetic ones divided by `n^{w/2}`, and the analytic completed function is the arithmetic
one evaluated `w/2` to the right.

⚠ Test it on two instances before believing it. At `w = 0` (a Dirichlet character) every
field must reduce to `rfl`; at `w = k - 1` (a weight-`k` newform) the shift is the first one
that is nonzero, and a wrong sign is invisible until then. -/
structure NormalizationTranslation where
  /-- The arithmetic-normalized side. -/
  arithmetic : ArithmeticLFunctionData
  /-- The analytic-normalized side. -/
  analytic : AnalyticLFunctionData
  /-- The motivic weight. -/
  weight : ℤ
  coeff_eq : ∀ n : ℕ,
    analytic.coeff n = arithmetic.coeff n / (n : ℂ) ^ ((weight : ℂ) / 2)
  /-- ⚠ The shifts move **up**. From `coeff_eq` the two Dirichlet series satisfy
  `L_an s = L_ar (s + w/2)`, and both completed functions include the same conductor power
  `N^{s/2}`, so `γ_an s = γ_ar (s + w/2)`. A `- w/2` here contradicts the weight-12 example,
  where an arithmetic `Gammaℂ s` becomes an analytic `Gammaℂ (s + 11/2)`. -/
  gammaR_eq : analytic.gammaR = arithmetic.gammaR.map fun μ ↦ μ + (weight : ℂ) / 2
  gammaC_eq : analytic.gammaC = arithmetic.gammaC.map fun ν ↦ ν + (weight : ℂ) / 2
  /-- ⚠ The constant `N^{-w/4}` is forced by the same computation: expanding
  `Λ_ar (s + w/2)` produces `N^{s/2} · N^{w/4} · γ_ar (s + w/2) · L_an s`. -/
  completed_eq : ∀ s : ℂ,
    analytic.completed s =
      (((arithmetic.conductor : ℕ) : ℂ) ^ (-(weight : ℂ) / 4)) *
        arithmetic.completed (s + (weight : ℂ) / 2)
  polarOrder_eq : ∀ p : ℂ,
    analytic.polarOrder p = arithmetic.polarOrder (p + (weight : ℂ) / 2)
  conductor_eq : analytic.conductor = arithmetic.conductor
  rootNumber_eq : analytic.rootNumber = arithmetic.rootNumber

/-- **Layer 0.4, the degree is normalization-independent.** With the conductor and root
number (fields of the translation) this is the list of invariants the LMFDB relies on. -/
example (T : NormalizationTranslation) :
    T.analytic.degree = T.arithmetic.toAnalyticLFunctionData.degree := sorry

/-- **Layer 0.4, existence and uniqueness of the translation**: every arithmetic record of
weight `w` has exactly one analytic partner. -/
example (a : ArithmeticLFunctionData) (w : ℤ) :
    ∃! T : NormalizationTranslation, T.arithmetic = a ∧ T.weight = w := sorry

/-- **Layer 0.5, the ζ instance card**: degree 1, conductor 1, `gammaR = {0}`, `ε = 1`,
`Λ = completedRiemannZeta`, with exact simple poles at `0` and `1`. Validates the model
against the pin's `completedRiemannZeta_one_sub`, meromorphic API, and residue theorems. -/
noncomputable def riemannZetaData : AnalyticLFunctionData where
  coeff _ := 1
  conductor := 1
  gammaR := {0}
  gammaC := 0
  rootNumber := 1
  completed := completedRiemannZeta
  polarOrder := Finsupp.single 0 1 + Finsupp.single 1 1

/-- **Layer 0.5, non-vacuity**: the ζ card agrees with its Dirichlet series. -/
example : riemannZetaData.HasDirichletAgreement := sorry

/-- **Layer 0.5, non-vacuity**: the ζ card is genuinely meromorphic with the exact two
simple poles recorded by its polar divisor. -/
example : riemannZetaData.HasMeromorphicContinuation := sorry

/-- **Layer 0.5, non-vacuity**: the ζ functional equation is an equality of meromorphic
functions, represented here away from the symmetric polar locus. -/
example : riemannZetaData.HasFunctionalEquation := sorry

/-- **Layer 0.6, the Dirichlet root number has absolute value 1** — asserted in the pin's
docstring for `DirichletCharacter.rootNumber` but not proved there; the first gap the
instance ledger finds. Route: `gaussSum_mul_gaussSum_eq_card`. -/
example {N : ℕ} [NeZero N] {χ : DirichletCharacter ℂ N}
    (hχ : DirichletCharacter.IsPrimitive χ) :
    ‖DirichletCharacter.rootNumber χ‖ = 1 := sorry

/-- **Layer 0.6, the Dirichlet instance card's functional equation, conductor-included**:
with `Λ(χ, s) := N^{s/2} · completedLFunction χ s`, the pin's functional equation
(`DirichletCharacter.IsPrimitive.completedLFunction_one_sub`, which carries `N^{s − 1/2}`)
becomes constant-free with dual character `χ⁻¹`. -/
example {N : ℕ} [NeZero N] {χ : DirichletCharacter ℂ N}
    (hχ : DirichletCharacter.IsPrimitive χ) (s : ℂ) :
    (N : ℂ) ^ ((1 - s) / 2) * DirichletCharacter.completedLFunction χ (1 - s) =
      DirichletCharacter.rootNumber χ *
        ((N : ℂ) ^ (s / 2) * DirichletCharacter.completedLFunction χ⁻¹ s) := sorry

/-! ## Layer 1: ideal-indexed series and Euler products -/

variable (K : Type*) [Field K] [NumberField K]

/-- **Layer 1.1, the norm coefficient**: the number of integral ideals of norm `n`, as a
named function (the pin inlines it in `NumberField.dedekindZeta`). -/
noncomputable def idealCoeff : ℕ → ℂ :=
  fun n ↦ (Nat.card {I : Ideal (𝓞 K) // Ideal.absNorm I = n} : ℂ)

/-- `dedekindZeta` is the L-series of `idealCoeff`. -/
example : dedekindZeta K = LSeries (idealCoeff K) := sorry

/-- **Layer 1.2, the weighted norm coefficient.** Every character L-function in the roadmap
is `LSeries (idealCoeffOfWeight χ)` for a suitable ideal weight `χ`, so the summability,
Euler-product and continuation lemmas are proved once here rather than once per family. -/
noncomputable def idealCoeffOfWeight (χ : Ideal (𝓞 K) → ℂ) : ℕ → ℂ :=
  fun n ↦ ∑ᶠ I : {I : Ideal (𝓞 K) // Ideal.absNorm I = n}, χ I

/-- **Layer 1.2, an ideal weight**: multiplicative, unitary away from a finite bad set, zero
on it. The analytic hypothesis such a weight needs for continuation is *not* part of this
structure — it is `HasCancellation` below, and keeping the two apart is the point. -/
structure IdealWeight where
  /-- The weight itself. -/
  toFun : Ideal (𝓞 K) → ℂ
  /-- The primes where the weight vanishes. -/
  bad : Set (HeightOneSpectrum (𝓞 K))
  bad_finite : bad.Finite
  map_mul : ∀ I J : Ideal (𝓞 K), toFun (I * J) = toFun I * toFun J
  norm_eq_one : ∀ 𝔭 ∉ bad, ‖toFun 𝔭.asIdeal‖ = 1
  eq_zero_bad : ∀ 𝔭 ∈ bad, toFun 𝔭.asIdeal = 0

/-- **Layer 1.2, ideal convolution.** ⚠ This, and not the pointwise product, is the operation
that grouping by norm carries to Mathlib's Dirichlet convolution. Writing
`a_χ n = ∑_{𝔑𝔞 = n} χ 𝔞`, the identity `a_{χ·ψ} = a_χ ⍟ a_ψ` is false in general, because
`(a_χ ⍟ a_ψ) n = ∑_{𝔑(𝔟𝔠) = n} χ 𝔟 · ψ 𝔠`, which is `a_{χ ⋆ ψ} n`. -/
noncomputable def idealConvolution (χ ψ : Ideal (𝓞 K) → ℂ) : Ideal (𝓞 K) → ℂ :=
  fun I ↦ ∑ᶠ p : {p : Ideal (𝓞 K) × Ideal (𝓞 K) // p.1 * p.2 = I}, χ (p : _).1.1 * ψ (p : _).1.2

/-- **Layer 1.3, what grouping by norm does.** Ideal convolution becomes Dirichlet convolution.
The corresponding statement for the pointwise product is false. -/
example (χ ψ : Ideal (𝓞 K) → ℂ) :
    idealCoeffOfWeight K (idealConvolution K χ ψ) =
      LSeries.convolution (idealCoeffOfWeight K χ) (idealCoeffOfWeight K ψ) := sorry

/-- **Layer 7.2, the analytic premise.** Finiteness of a quotient of the ideal group does
*not* give analytic continuation: the group of ideals prime to a finite set is free, so it
has finite quotients whose values on primes are arbitrary. This partial-sum estimate is the
hypothesis that does the work, and every nonvanishing theorem takes it rather than deducing
it. It is proved separately for ray-class characters and for cyclotomic Frobenius
characters. -/
def HasCancellation (χ : IdealWeight K) : Prop :=
  (fun X : ℝ ↦ ∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ X}, χ.toFun I)
    =O[atTop] fun X : ℝ ↦ X ^ (1 - 1 / (Module.finrank ℚ K : ℝ))

/-- **Layer 7.2, cancellation gives continuation** into the strip `Re s > 1 - 1/[K:ℚ]`.
Stated in `∃`-form because the continued object is what the milestone builds. -/
example (χ : IdealWeight K) (hχ : HasCancellation K χ) :
    ∃ F : ℂ → ℂ,
      (∀ s : ℂ, 1 < s.re → F s = LSeries (idealCoeffOfWeight K χ.toFun) s) ∧
      AnalyticOnNhd ℂ F {s : ℂ | 1 - 1 / (Module.finrank ℚ K : ℝ) < s.re} := sorry

/-- **Layer 1.5, local Euler-factor data.** The local factors are *data*: an existential
"there is a polynomial at each prime" cannot be referred to by a later theorem. The
properties — constant term `1`, degree bounds, the local coefficient identity, the global
product — are separate predicates over this structure, and the determinant realization with
arithmetic Frobenius is a stronger predicate still, for the instances that have a Galois
representation. -/
structure EulerFactorData where
  /-- The local polynomial at each prime, in the variable `𝔑𝔭^{-s}`. -/
  localPolynomial : HeightOneSpectrum (𝓞 K) → Polynomial ℂ
  /-- The primes where the degree is allowed to drop. -/
  bad : Set (HeightOneSpectrum (𝓞 K))
  bad_finite : bad.Finite

namespace EulerFactorData

variable {K}

/-- **Layer 1.5, the shape of the local factors**: constant term `1`, degree at most `d`
everywhere, and exactly `d` off the bad set. The docstring claim that the bad primes are
where the degree drops is now a field, not prose. -/
structure IsOfDegree (E : EulerFactorData K) (d : ℕ) : Prop where
  coeff_zero : ∀ 𝔭, (E.localPolynomial 𝔭).coeff 0 = 1
  natDegree_le : ∀ 𝔭, (E.localPolynomial 𝔭).natDegree ≤ d
  natDegree_eq : ∀ 𝔭 ∉ E.bad, (E.localPolynomial 𝔭).natDegree = d

/-- **Layer 1.5, the local coefficient identity**, at the level of **ideals**.

⚠ The norm-grouped coefficient `idealCoeffOfWeight χ (𝔑𝔭 ^ k)` is *not* the coefficient of the
local factor at `𝔭`: it collects every ideal of that norm. In `ℚ(i)` the prime `5` splits as
`𝔭 𝔭̄` with `𝔑𝔭 = 𝔑𝔭̄ = 5`, so `idealCoeff K 5 = 2`, while the coefficient of `T` in the local
factor `(1 − T)⁻¹` at `𝔭` is `1`. The values used below are `χ (𝔭 ^ k)`. -/
def HasLocalCoefficients (E : EulerFactorData K) (χ : IdealWeight K) : Prop :=
  ∀ (𝔭 : HeightOneSpectrum (𝓞 K)) (s : ℂ), 1 < s.re →
    HasSum (fun k : ℕ ↦ χ.toFun (𝔭.asIdeal ^ k) *
        (Ideal.absNorm 𝔭.asIdeal : ℂ) ^ (-(k : ℂ) * s))
      (Polynomial.eval ((Ideal.absNorm 𝔭.asIdeal : ℂ) ^ (-s)) (E.localPolynomial 𝔭))⁻¹

/-- **Layer 1.5, the global Euler product**, in the half-plane of absolute convergence. -/
def HasEulerProduct (E : EulerFactorData K) (a : ℕ → ℂ) : Prop :=
  ∀ s : ℂ, 1 < s.re →
    HasProd (fun 𝔭 : HeightOneSpectrum (𝓞 K) ↦
      (Polynomial.eval ((Ideal.absNorm 𝔭.asIdeal : ℂ) ^ (-s)) (E.localPolynomial 𝔭))⁻¹)
      (LSeries a s)

end EulerFactorData

/-- **Layer 1.3, multiplicativity** of the ideal-counting coefficient (unique factorization
of ideals; unproved at the pin). -/
example {m n : ℕ} (h : m.Coprime n) :
    idealCoeff K (m * n) = idealCoeff K m * idealCoeff K n := sorry

/-- **Layer 1.4, the Euler product of the Dedekind zeta function** over the primes of `𝓞 K`
(absent at the pin). -/
example {s : ℂ} (hs : 1 < s.re) :
    HasProd (fun 𝔭 : HeightOneSpectrum (𝓞 K) ↦
      (1 - (Ideal.absNorm 𝔭.asIdeal : ℂ) ^ (-s))⁻¹) (dedekindZeta K s) := sorry

/-- **Layer 1.4, the abscissa**: the Dedekind zeta series converges absolutely exactly for
`Re s > 1`. -/
theorem abscissaOfAbsConv_idealCoeff : LSeries.abscissaOfAbsConv (idealCoeff K) = 1 := sorry

/-- **Layer 1.6, counting ideals in a class with an error term.** The pin has the limit
(`Ideal.tendsto_norm_le_and_mk_eq_div_atTop`); the error form, with the exponent `1 - 1/d`
and an implied constant independent of the class, is what Layers 1.7 and 7 need. It is the
hard analytic milestone of Layer 1. -/
example (c : ClassGroup (𝓞 K)) :
    (fun x : ℝ ↦ (Nat.card {I : Ideal (𝓞 K) //
          (Ideal.absNorm I : ℝ) ≤ x ∧ I ≠ ⊥ ∧ ClassGroup.mk0 ⟨I, sorry⟩ = c} : ℝ) -
        NumberField.dedekindZeta_residue K / (Nat.card (ClassGroup (𝓞 K)) : ℝ) * x)
      =O[atTop] fun x : ℝ ↦ x ^ (1 - 1 / (Module.finrank ℚ K : ℝ)) := sorry

/-- **Layers 1.1 and 3.7, worked example at `K = ℚ`**: on the convergence half-plane the Dedekind
zeta function of `ℚ` is the Riemann zeta function. ⚠ Off `Re s > 1` the raw `LSeries` is
a junk value `0`, so this is *false* globally for `dedekindZeta`; only the continued
object of Layer 3 equals `riemannZeta` everywhere. -/
example {s : ℂ} (hs : 1 < s.re) : dedekindZeta ℚ s = riemannZeta s := sorry

/-! ## Layer 2: a functional equation with a level -/

/-- **Layer 2.14, a functional equation with a level.** Mathlib's `AbstractFuncEq.lean` handles
`f (1/x) = ε • x ^ k • g x`. Its own TODO asks for the level form `f (N/x) = c • x ^ k • g x`
for real `N > 0`, and proposes this name. `Λ_K` has level `|d_K|`, and a Hecke L-function has
level `|d_K| 𝔑𝔣₀`, so both instantiate it.

⚠ Mathlib's shape changed after the pin: PR #41329 (merged 2026-07-04) replaced the
`StrongFEPair` structure by a predicate `IsStrongFEPair` on `WeakFEPair`. This structure is
written against the master shape, so that the reduction theorem below is a theorem about
`WeakFEPair` in either version. -/
structure FEPairWithLevel (E : Type*) [NormedAddCommGroup E] [NormedSpace ℂ E] where
  /-- The level. -/
  level : ℝ
  level_pos : 0 < level
  /-- The two functions, as in `WeakFEPair`. -/
  f : ℝ → E
  g : ℝ → E
  /-- The weight. -/
  k : ℝ
  /-- The root number. -/
  ε : ℂ
  /-- Constant terms at `∞`, as in `WeakFEPair`. -/
  f₀ : E
  g₀ : E
  hf_int : MeasureTheory.LocallyIntegrableOn f (Set.Ioi 0)
  hg_int : MeasureTheory.LocallyIntegrableOn g (Set.Ioi 0)
  hk : 0 < k
  hε : ε ≠ 0
  /-- The functional equation, with the level in place of `1`. -/
  h_feq : ∀ x ∈ Set.Ioi (0 : ℝ), f (level / x) = (ε * ((x ^ k : ℝ) : ℂ)) • g x
  hf_top : ∀ r : ℝ, (fun x ↦ f x - f₀) =O[atTop] fun x : ℝ ↦ x ^ r
  hg_top : ∀ r : ℝ, (fun x ↦ g x - g₀) =O[atTop] fun x : ℝ ↦ x ^ r

/-- **Layer 2.14, the reduction to level one, as a real Mathlib object.** Rescaling by `√N`
sends a level-`N` pair to a genuine `WeakFEPair`, with the same weight and constant terms and
root number `ε · N^{k/2}`. Every rescaled hypothesis is part of the conclusion: local
integrability, the two decay bounds, and the level-one equation.

⚠ The output must be Mathlib's structure and not a second `FEPairWithLevel`. Producing another
lawless shell would leave the continuation, the residues, and the functional equation
unavailable, which is the whole reason this milestone exists. -/
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] (P : FEPairWithLevel E) :
    ∃ Q : WeakFEPair E,
      Q.k = P.k ∧ Q.f₀ = P.f₀ ∧ Q.g₀ = P.g₀ ∧
      Q.ε = P.ε * ((P.level ^ (P.k / 2) : ℝ) : ℂ) ∧
      (∀ x : ℝ, Q.f x = P.f (Real.sqrt P.level * x)) ∧
      (∀ x : ℝ, Q.g x = P.g (Real.sqrt P.level * x)) := sorry

/-- **Layer 2.14, the completed functions differ by a power of the level**, and the residues
carry the same power. This is what Layers 3.4 and 5.7 actually use. -/
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] (P : FEPairWithLevel E)
    (Q : WeakFEPair E) (hQ : ∀ x : ℝ, Q.f x = P.f (Real.sqrt P.level * x)) :
    ∃ Λlevel : ℂ → E, ∀ s : ℂ, Λlevel s = ((P.level : ℂ) ^ (s / 2)) • Q.Λ s := sorry

/-- **Layer 2.14, at level one the object is Mathlib's own.** A milestone that produced a second
copy at `N = 1` would not have reduced anything. -/
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] (P : FEPairWithLevel E)
    (h : P.level = 1) :
    ∃ Q : WeakFEPair E, Q.f = P.f ∧ Q.g = P.g ∧ Q.k = P.k ∧ Q.ε = P.ε := sorry

/-! ## Layer 2: what the integral lattices roadmap supplies -/

/-- **Layers 2.10 and 2.11, the integral-lattice interface (compatibility interface).** The
integral lattices roadmap, milestones 1B and 8D, owns the dual lattice of an integral bilinear
form and its comparison with the analytic dual. Until those declarations exist, Layers 2.10 and
2.11 are stated over this structure. The field names are the agreed names of the shared
layer-DAG table in `README.md`.

The crossing is carried in Lean on both sides. The integral lattices roadmap's `Suggested.lean`
has `GaussianThetaInterface n` over its bundled `AnalyticLattice n`, with fields `dual`,
`mem_dual`, `dual_dual`, `covolume_mul_covolume_dual`, and `gaussianTheta_one_div`; Layers 2.1,
2.2, 2.3, and 2.8 are named so that one term of that structure comes from them. Neither roadmap
waits for the other.

The replacement is mechanical: delete this structure, take the two fields to be that roadmap's
declarations of the same names, and leave Layers 2.10 and 2.11 unchanged. -/
structure IntegralLatticeInterface (n : ℕ) where
  /-- The dual lattice of an integral bilinear form, `IntegralLattice.dual`. -/
  dual : Submodule ℤ (EuclideanSpace ℝ (Fin n)) → Submodule ℤ (EuclideanSpace ℝ (Fin n))
  /-- The analytic dual of the realization agrees with the bilinear dual,
  `IntegralLattice.analyticDual_eq_dual`. -/
  analyticDual_eq_dual : ∀ Λ : Submodule ℤ (EuclideanSpace ℝ (Fin n)),
    {w : EuclideanSpace ℝ (Fin n) | ∀ v ∈ Λ, ∃ k : ℤ, inner ℝ v w = (k : ℝ)} = (dual Λ : Set _)

/-- **Layer 2.11, the trace-to-Euclidean map.** ⚠ The analytic dual of `mixedEmbedding K '' I`
is **not** `mixedEmbedding K '' (I𝔡)⁻¹`. The trace pairing and the Euclidean inner product on
the mixed space differ at the complex places, by a factor of `2` and a conjugation.

The counterexample is `K = ℚ(i)` with `I = 𝓞_K`. The mixed lattice is `ℤ[i] ⊂ ℂ`, which is
Euclidean self-dual; the different is `(2i)`, so the trace dual is `(1/2)ℤ[i]`, which is not
`ℤ[i]`. The map below sends `(1/2)ℤ[i]` back to `ℤ[i]`.

The map is the identity on each real coordinate and `z ↦ 2 · conj z` on each complex
coordinate, and it satisfies
`⟪mixedEmbedding x, T (mixedEmbedding y)⟫ = Tr_{K/ℚ} (x y)`. Its determinant is `2^{r₂}`, which
is where the powers of `2` in Layers 2.12, 2.13, and 3.1 come from. -/
example (ι κ : Type*) [Fintype ι] [Fintype κ] :
    ∃ T : ((ι → ℝ) × (κ → ℂ)) →ₗ[ℝ] ((ι → ℝ) × (κ → ℂ)),
      ∀ x : (ι → ℝ) × (κ → ℂ),
        T x = (x.1, fun w ↦ 2 * (starRingEnd ℂ) (x.2 w)) := sorry

/-- **Layer 2.12, the covolume of a fractional ideal**, stated so that a reader can see which
constant Layer 3.1 threads: `covolume (mixedEmbedding K '' I) = 2^{-r₂} √|d_K| 𝔑 I`. The
lattice itself is Layer 2.10, whose vocabulary comes from the interface above. -/
example (K : Type*) [Field K] [NumberField K] :
    ∃ c : ℝ, c = 2 ^ (-(nrComplexPlaces K : ℝ)) * Real.sqrt |(discr K : ℝ)| := sorry

/-! ## Layer 3: Dedekind zeta — continuation and functional equation

⚠ The continued objects do not exist at the pin, and building them *is* this layer. They are
declared here as **named** `sorry`-definitions with their characterizing theorems beside them,
and not as anonymous `∃`-statements: a consumer needs a declaration to cite, an `example` is not
one, and the zeros roadmap consumes both objects by name. Layer 3.5's uniqueness
(`eq_of_meromorphic_of_eqOn_halfPlane`) is what makes the characterizations below determine the
objects rather than merely constrain them. -/

/-- **Layer 3.7, the continued Dedekind zeta function**, meromorphic on `ℂ` with a single simple
pole at `s = 1`. -/
noncomputable def dedekindZetaC (K : Type*) [Field K] [NumberField K] : ℂ → ℂ := sorry

/-- **Layer 3.7**: it continues the series. -/
theorem dedekindZetaC_eq {s : ℂ} (hs : 1 < s.re) :
    dedekindZetaC K s = dedekindZeta K s := sorry

theorem meromorphic_dedekindZetaC : Meromorphic (dedekindZetaC K) := sorry

theorem meromorphicOrderAt_dedekindZetaC_one :
    meromorphicOrderAt (dedekindZetaC K) 1 = (-1 : WithTop ℤ) := sorry

/-- **Layer 3.7**: the pole at `1` is the only one. This is the statement a consumer reads as
`regular_away`, and it is what discharges the zeros roadmap's canonical-representative
hypothesis. -/
theorem meromorphicOrderAt_dedekindZetaC_nonneg {s : ℂ} (hs : s ≠ 1) :
    0 ≤ meromorphicOrderAt (dedekindZetaC K) s := sorry

/-- **Layer 3.7, the residue**, upgrading the pin's real-limit class number formula
(`tendsto_sub_one_mul_dedekindZeta_nhdsGT`) to a genuine complex residue. -/
theorem tendsto_sub_one_mul_dedekindZetaC :
    Tendsto (fun s : ℂ ↦ (s - 1) * dedekindZetaC K s) (𝓝[≠] 1)
      (𝓝 (dedekindZeta_residue K : ℂ)) := sorry

/-- **Layer 3.5, uniqueness of the continuation.** Without this the characterizations above and
below pin nothing: two continuations agreeing on `Re s > 1` agree wherever both are
meromorphic, by the identity theorem on the connected set `ℂ ∖ {0, 1}`. -/
theorem eq_of_meromorphic_of_eqOn_halfPlane (Z W : ℂ → ℂ) (hZ : Meromorphic Z)
    (hW : Meromorphic W) (h : ∀ s : ℂ, 1 < s.re → Z s = W s) :
    ∀ s : ℂ, s ≠ 0 → s ≠ 1 → Z s = W s := sorry

/-- **Layer 3.6, the completed Dedekind zeta function and its functional equation**
(Hecke; Neukirch VII (5.10)): `Λ_K(s) = |d_K|^{s/2} Γ_ℝ(s)^{r₁} Γ_ℂ(s)^{r₂} ζ_K(s)` on
the convergence half-plane, holomorphic on `ℂ ∖ {0, 1}`, with the self-dual equation
`Λ_K(1 − s) = Λ_K(s)`. -/
noncomputable def completedDedekindZeta (K : Type*) [Field K] [NumberField K] : ℂ → ℂ := sorry

theorem completedDedekindZeta_eq {s : ℂ} (hs : 1 < s.re) :
    completedDedekindZeta K s =
      ((|discr K| : ℤ) : ℂ) ^ (s / 2) * Gammaℝ s ^ nrRealPlaces K *
        Gammaℂ s ^ nrComplexPlaces K * dedekindZeta K s := sorry

theorem meromorphic_completedDedekindZeta : Meromorphic (completedDedekindZeta K) := sorry

theorem meromorphicOrderAt_completedDedekindZeta_zero :
    meromorphicOrderAt (completedDedekindZeta K) 0 = (-1 : WithTop ℤ) := sorry

theorem meromorphicOrderAt_completedDedekindZeta_one :
    meromorphicOrderAt (completedDedekindZeta K) 1 = (-1 : WithTop ℤ) := sorry

/-- **Layer 3.6**: the two poles are the only ones — the `regular_away` statement for `Λ_K`. -/
theorem meromorphicOrderAt_completedDedekindZeta_nonneg {s : ℂ} (h0 : s ≠ 0) (h1 : s ≠ 1) :
    0 ≤ meromorphicOrderAt (completedDedekindZeta K) s := sorry

theorem tendsto_sub_one_mul_completedDedekindZeta :
    Tendsto (fun s : ℂ ↦ (s - 1) * completedDedekindZeta K s) (𝓝[≠] 1)
      (𝓝 (((|discr K| : ℤ) : ℂ) ^ ((1 : ℂ) / 2) *
        Gammaℝ 1 ^ nrRealPlaces K * Gammaℂ 1 ^ nrComplexPlaces K *
        (dedekindZeta_residue K : ℂ))) := sorry

theorem tendsto_mul_completedDedekindZeta_zero :
    Tendsto (fun s : ℂ ↦ s * completedDedekindZeta K s) (𝓝[≠] 0)
      (𝓝 (-(((|discr K| : ℤ) : ℂ) ^ ((1 : ℂ) / 2) *
        Gammaℝ 1 ^ nrRealPlaces K * Gammaℂ 1 ^ nrComplexPlaces K *
        (dedekindZeta_residue K : ℂ)))) := sorry

/-- **Layer 3.6, the functional equation.** ⚠ An identity of *values* only away from the two
poles; at `0` and `1` both sides are junk values of a total representative. -/
theorem completedDedekindZeta_one_sub {s : ℂ} (h0 : s ≠ 0) (h1 : s ≠ 1) :
    completedDedekindZeta K (1 - s) = completedDedekindZeta K s := sorry

/-! ## Layer 4: special values — the `ℚ(i)` factorization -/

/-- The primitive quadratic character mod 4, with values in `ℂ` (the pin's `ZMod.χ₄`
composed along `ℤ → ℂ`). -/
noncomputable def χ₄C : DirichletCharacter ℂ 4 :=
  ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)

/-- **Layer 4.1, worked example, coefficient level**: in `ℚ(i)` the number of ideals of
norm `n ≠ 0` is `∑_{e ∣ n} χ₋₄(e)` (the splitting law at every prime, including the
ramified prime `2`). -/
example (F : Type*) [Field F] [NumberField F] [IsCyclotomicExtension {4} ℚ F]
    {n : ℕ} (hn : n ≠ 0) :
    idealCoeff F n = ∑ e ∈ n.divisors, χ₄C (e : ZMod 4) := sorry

/-- **Layer 4.2, worked example, function level**: `ζ_{ℚ(i)} = ζ · L(χ₋₄)` as an identity
of L-series on the convergence half-plane (and, after Layer 3, of the continued
functions everywhere). -/
example (F : Type*) [Field F] [NumberField F] [IsCyclotomicExtension {4} ℚ F]
    {s : ℂ} (hs : 1 < s.re) :
    dedekindZeta F s = riemannZeta s * DirichletCharacter.LFunction χ₄C s := sorry

/-- **Layer 4.2, the quadratic factorization for the continued functions**, which is the form a
consumer counting zeros needs: on `Re s > 1` this is an identity of convergent series, but the
zeros are not there, and off that half-plane a raw `LSeries` is a junk value. ⚠ Named, because
the zeros roadmap turns it into an additivity of divisors and cannot cite an `example`. -/
theorem dedekindZetaC_quadratic (F : Type*) [Field F] [NumberField F]
    (hF : Module.finrank ℚ F = 2) :
    ∃ (N : ℕ) (_ : NeZero N) (χ : DirichletCharacter ℂ N),
      ∀ s : ℂ, dedekindZetaC F s = riemannZeta s * DirichletCharacter.LFunction χ s := sorry

/-- **Layer 4.4, the cyclotomic factorization for the continued functions**, over the primitive
characters inducing the characters modulo `n`. -/
theorem dedekindZetaC_cyclotomic (n : ℕ) [NeZero n] (F : Type*) [Field F] [NumberField F]
    [IsCyclotomicExtension {n} ℚ F] :
    ∃ (m : DirichletCharacter ℂ n → ℕ) (_ : ∀ χ, NeZero (m χ))
      (χ' : ∀ χ : DirichletCharacter ℂ n, DirichletCharacter ℂ (m χ)),
      ∀ s : ℂ, dedekindZetaC F s =
        ∏ χ : DirichletCharacter ℂ n, DirichletCharacter.LFunction (χ' χ) s := sorry

/-! ## Layers 5 and 6: the character interfaces -/

/-- **Layer 5.1, the ray-class character interface (compatibility interface).** The global
class field theory roadmap, Layers 0 to 3, will own this vocabulary. Until its declarations
exist, Layers 5.2 to 5.9 are stated over this structure.

⚠ The finite part and the infinite part of the conductor are separate fields, and neither may
be dropped: the gamma factor of Layer 5.5 reads the infinite part, and the level of Layer 5.7
reads the finite part.

The replacement is mechanical: delete this structure, make the name an abbreviation for that
roadmap's Hecke character type, and leave Layers 5.2 to 5.9 unchanged. -/
structure RayClassCharacter where
  /-- The character, as an ideal weight in the sense of Layer 7.2. -/
  weight : IdealWeight K
  /-- The finite part of the conductor. -/
  conductor₀ : Ideal (𝓞 K)
  conductor₀_ne_zero : conductor₀ ≠ ⊥
  /-- The infinite part of the conductor: the real places where the character is nontrivial on
  the positive elements. -/
  conductorInf : Finset (InfinitePlace K)
  conductorInf_isReal : ∀ v ∈ conductorInf, v.IsReal
  /-- The bad primes of the weight are exactly the primes dividing the finite conductor. -/
  bad_eq : weight.bad = {𝔭 : HeightOneSpectrum (𝓞 K) | 𝔭.asIdeal ∣ conductor₀}
  /-- ⚠ **Triviality on the principal congruence subgroup.** This is the field that makes the
  weight factor through the ray class group. Without it a term of this structure is only an
  assignment of roots of unity to the generators of a free group, and the Gauss sum of 5.6 and
  the functional equation of 5.8 are false for such a term. -/
  trivial_on_congruence : ∀ α : 𝓞 K, α ≠ 0 → (α - 1 : 𝓞 K) ∈ conductor₀ →
    (∀ v ∈ conductorInf, 0 < (v.embedding (algebraMap (𝓞 K) K α)).re) →
      weight.toFun (Ideal.span {α}) = 1
  /-- Finite order, on the ideals where the character does not vanish. ⚠ The quantifier has to
  exclude the bad primes: there the value is `0`, and `0 ^ m = 1` is false. -/
  finiteOrder : ∃ m : ℕ, 0 < m ∧ ∀ I : Ideal (𝓞 K), weight.toFun I ≠ 0 → weight.toFun I ^ m = 1
  /-- Primitivity: no proper divisor of the finite conductor supports a character inducing this
  one. Stated as a field because 5.6 and 5.8 hold only for primitive characters. -/
  primitive : ∀ 𝔫 : Ideal (𝓞 K), 𝔫 ∣ conductor₀ → 𝔫 ≠ conductor₀ →
    ¬ ∃ ψ : Ideal (𝓞 K) → ℂ,
        (∀ I, IsCoprime I 𝔫 → ψ I = weight.toFun I) ∧ ∀ 𝔭 ∈ weight.bad, 𝔭.asIdeal ∣ 𝔫

/-! ### Layers 5.3, 5.7 and 5.8: the Hecke L-function, by name

⚠ Named rather than existential, for the same reason as Layer 3: the zeros roadmap builds its
Hecke instance on these objects and cannot cite an anonymous `example`. -/

/-- **Layer 5.3, the continued Hecke L-function.** -/
noncomputable def heckeLFunctionC (K : Type*) [Field K] [NumberField K]
    (χ : RayClassCharacter K) : ℂ → ℂ := sorry

theorem heckeLFunctionC_eq (χ : RayClassCharacter K) {s : ℂ} (hs : 1 < s.re) :
    heckeLFunctionC K χ s = LSeries (idealCoeffOfWeight K χ.weight.toFun) s := sorry

/-- **Layer 5.7, the completed Hecke L-function**, conductor power and gamma factor included. -/
noncomputable def completedHeckeLFunction (K : Type*) [Field K] [NumberField K]
    (χ : RayClassCharacter K) : ℂ → ℂ := sorry

/-- **Layer 5.7, entirety.** ⚠ For a **nontrivial** primitive character only: the trivial
character's completed function has poles at `0` and `1`, and the statement without that
hypothesis is false there. -/
theorem differentiable_completedHeckeLFunction (χ : RayClassCharacter K)
    (hχ : ∃ I : Ideal (𝓞 K), χ.weight.toFun I ≠ 1 ∧ χ.weight.toFun I ≠ 0) :
    Differentiable ℂ (completedHeckeLFunction K χ) := sorry

/-- **Layer 5.8, the root number.** -/
noncomputable def heckeRootNumber (K : Type*) [Field K] [NumberField K]
    (χ : RayClassCharacter K) : ℂ := sorry

/-- **Layer 5.8, the root number has modulus one**, which is what the Gauss-sum evaluation
`|τ(χ)| = √𝔑𝔣₀` of 5.6 is for, and what every growth estimate downstream needs. -/
theorem norm_heckeRootNumber (χ : RayClassCharacter K) : ‖heckeRootNumber K χ‖ = 1 := sorry

/-- **Layer 5.8, the functional equation**, against the conjugate character and not against `χ`
itself. ⚠ For a non-real `χ` those are different characters, and an equation written as though
they were the same is false. -/
theorem completedHeckeLFunction_one_sub (χ χ' : RayClassCharacter K)
    (hχ' : ∀ I, χ'.weight.toFun I = starRingEnd ℂ (χ.weight.toFun I)) (s : ℂ) :
    completedHeckeLFunction K χ s =
      heckeRootNumber K χ * completedHeckeLFunction K χ' (1 - s) := sorry

/-- **Layer 5.7, the Mellin representation**, which is what a consumer turns into a
vertical-strip bound and hence into finite order. -/
theorem exists_mellin_completedHeckeLFunction (χ : RayClassCharacter K) :
    ∃ θ : ℝ → ℂ, ∀ s : ℂ, 1 < s.re →
      completedHeckeLFunction K χ s =
        ∫ t in Set.Ioi (0 : ℝ), θ t * (t : ℂ) ^ s / (t : ℂ) := sorry

/-- **Layer 6.1, the Grossencharacter interface (compatibility interface).** The global class
field theory roadmap's infinity-type layer will own this vocabulary.

⚠ The unitary decomposition `χ = χ_unit · ‖·‖^σ` is unique only once `σ` is required to be
real. With a complex exponent it is ambiguous up to `‖·‖^{it}`, which is why `shift` is a real
number here. -/
structure Grossencharacter where
  /-- The underlying ideal weight. -/
  weight : IdealWeight K
  /-- The finite part of the conductor. -/
  conductor₀ : Ideal (𝓞 K)
  conductor₀_ne_zero : conductor₀ ≠ ⊥
  /-- The real exponent of the unitary decomposition. ⚠ It has to be real: with a complex
  exponent the decomposition is ambiguous up to `‖·‖^{it}`. -/
  shift : ℝ
  /-- The unitary component, of absolute value `1` away from the bad primes. -/
  unitary : IdealWeight K
  unitary_norm : ∀ 𝔭 ∉ unitary.bad, ‖unitary.toFun 𝔭.asIdeal‖ = 1
  /-- The decomposition `χ = χ_unit · ‖·‖^{shift}`. -/
  decomposition : ∀ I : Ideal (𝓞 K),
    weight.toFun I = unitary.toFun I * ((Ideal.absNorm I : ℝ) ^ shift : ℝ)
  /-- The infinity type at each place. ⚠ A complex place needs a **pair** of integers: the local
  character there is `z ↦ z^{-p} z̄^{-p̄} |z|^{i q}`, and the gamma shift of 6.2 is built from
  both. One integer per place is not enough. -/
  infinityType : InfinitePlace K → ℤ × ℤ
  infinityType_isReal : ∀ v, v.IsReal → (infinityType v).2 = 0
  /-- The archimedean parameters `q_v`. -/
  archimedeanParam : InfinitePlace K → ℝ
  /-- The local character at an infinite place, from the data above. -/
  localChar : InfinitePlace K → K → ℂ
  /-- ⚠ **Admissibility**: the archimedean part is trivial on the units. This is not cosmetic.
  Without it the archimedean data and the ideal weight need not come from one character, and
  Layers 6.2 to 6.4 are false for such a term. -/
  admissible : ∀ u : (𝓞 K)ˣ, ∏ᶠ v : InfinitePlace K,
    localChar v (algebraMap (𝓞 K) K (u : 𝓞 K)) = 1
  /-- Compatibility of the ideal weight with the archimedean components on principal ideals. -/
  compat : ∀ α : 𝓞 K, α ≠ 0 → IsCoprime (Ideal.span {α}) conductor₀ →
    weight.toFun (Ideal.span {α}) *
      ∏ᶠ v : InfinitePlace K, localChar v (algebraMap (𝓞 K) K α) = 1
  /-- The algebraic, or `A₀`, condition. -/
  IsAlgebraic : Prop := ∀ v, archimedeanParam v = 0

/-! ## Layer 7: Landau's theorem and nonvanishing -/

open scoped ComplexOrder in
/-- **Layer 7.1, Landau's theorem** (absent at the pin; behind both the real-character
nonvanishing and the density dichotomies): a Dirichlet series with nonnegative coefficients
has a genuine singularity at its abscissa of absolute convergence — no function holomorphic
on a neighborhood of the abscissa agrees with it on the half-plane of convergence. -/
example {a : ℕ → ℂ} (ha₀ : 0 ≤ a) {x₀ : ℝ}
    (hx : LSeries.abscissaOfAbsConv a = (x₀ : EReal)) :
    ¬ ∃ (U : Set ℂ) (F : ℂ → ℂ), IsOpen U ∧ (x₀ : ℂ) ∈ U ∧ DifferentiableOn ℂ F U ∧
      Set.EqOn F (LSeries a) (U ∩ {s : ℂ | x₀ < s.re}) := sorry

/-- **Layer 7.5, nonvanishing at the trivial character, stated in meromorphic order.**
⚠ This is where a pointwise statement goes wrong: the trivial character's L-function has a
*pole* at `s = 1`, so "`L(χ, 1 + it) ≠ 0` for `χ` arbitrary" compares a junk value there.
For the ζ instance the correct statements are `meromorphicOrderAt riemannZeta 1 = -1` and,
for `t ≠ 0`, order `0` at `1 + it`. Both are pin-expressible; the second is the pin's
`riemannZeta_ne_zero_of_one_le_re` in the form the roadmap wants everywhere. -/
theorem meromorphicOrderAt_riemannZeta_one :
    meromorphicOrderAt riemannZeta 1 = (-1 : WithTop ℤ) := sorry

/-- **Layer 7.5, nonvanishing off the pole**, in the same language. -/
theorem meromorphicOrderAt_riemannZeta_one_add {t : ℝ} (ht : t ≠ 0) :
    meromorphicOrderAt riemannZeta (1 + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.5, nonvanishing for a nontrivial character**: order `0` at every point of the
line, including `s = 1`, where there is no pole. This is the shape the ray-class and
cyclotomic families are stated in. -/
theorem meromorphicOrderAt_dirichletLFunction_one_add {N : ℕ} [NeZero N]
    {χ : DirichletCharacter ℂ N} (hχ : χ ≠ 1) (t : ℝ) :
    meromorphicOrderAt (DirichletCharacter.LFunction χ) (1 + t * I) = (0 : WithTop ℤ) :=
  sorry

/-- **Layer 7.4, nonvanishing on `Re s = 1` for `ζ_K`**, in meromorphic-order form and stated
for the continued function of 3.7 — the only object on which the statement is meaningful, since
at `s = 1` a raw `LSeries` is a junk value. The pole itself is
`meromorphicOrderAt_dedekindZetaC_one`. -/
theorem meromorphicOrderAt_dedekindZetaC_one_add {t : ℝ} (ht : t ≠ 0) :
    meromorphicOrderAt (dedekindZetaC K) (1 + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.3, the `3-4-1` positivity, at its root.** `3 + 4 cos θ + cos 2θ = 2(1 + cos θ)²`
is the whole content of every `3-4-1` product bound: the bound is this inequality applied to the
arguments of the Euler factors. It is named here so that the zeros roadmap's quantitative
version and this roadmap's limiting version make the *same* inequality quantitative. -/
theorem three_four_one_nonneg (θ : ℝ) :
    0 ≤ 3 + 4 * Real.cos θ + Real.cos (2 * θ) := sorry

open scoped Classical in
/-- **Layer 7.6, the ideal von Mangoldt weight**: `log 𝔑𝔭` at a prime power `𝔭^m`, and `0`
otherwise. The coefficient function of `-ζ_K'/ζ_K`. -/
noncomputable def idealVonMangoldt (I : Ideal (𝓞 K)) : ℂ :=
  if h : ∃ (𝔭 : HeightOneSpectrum (𝓞 K)) (m : ℕ), 0 < m ∧ I = 𝔭.asIdeal ^ m then
    Real.log (Ideal.absNorm h.choose.asIdeal)
  else 0

/-- **Layer 7.6, the logarithmic derivative of `ζ_K`** as a Dirichlet series on `Re s > 1`,
in the shape of Mathlib's `LSeries_vonMangoldt_eq_deriv_riemannZeta_div`. -/
theorem LSeries_idealVonMangoldt_eq {s : ℂ} (hs : 1 < s.re) :
    LSeries (idealCoeffOfWeight K (idealVonMangoldt K)) s =
      -deriv (dedekindZeta K) s / dedekindZeta K s := sorry

/-- **Layer 7.6, nonnegativity of the ideal von Mangoldt weight.** ⚠ Named because the `3-4-1`
argument needs exactly this and nothing else about the weight: with
`three_four_one_nonneg` it gives the quantitative inequality the zeros roadmap's zero-free
regions run on. -/
theorem idealVonMangoldt_nonneg (I : Ideal (𝓞 K)) :
    0 ≤ (idealVonMangoldt K I).re ∧ (idealVonMangoldt K I).im = 0 := sorry

/-! ## Layer 8: densities and the Chebotarev density theorem -/

/-- **Layer 8A.1, the partial prime-ideal zeta sum** `∑_{𝔭 ∈ S} 𝔑𝔭^{-s}`.

This and `HasDirichletDensity` are Mathlib #41765's spelling exactly (there in namespace
`NumberField.Set`, used as `S.HasDirichletDensity δ`). They are stated here because they do
not exist at the pin; when that lands, these two declarations are deleted and Mathlib's
imported, and nothing downstream changes. -/
noncomputable def primeIdealZetaSum (S : Set (HeightOneSpectrum (𝓞 K))) (s : ℝ) : ℝ :=
  ∑' 𝔭 : S, (Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℝ) ^ (-s)

/-- **Layer 8A.1, Dirichlet density**, as the ratio to the sum over *all* nonzero primes.
⚠ Neukirch's `log((s-1)⁻¹)` denominator is not a second definition: it is the theorem
below. -/
def HasDirichletDensity (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  Tendsto (fun s : ℝ ↦ primeIdealZetaSum K S s /
    primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s) (𝓝[>] 1) (𝓝 δ)

/-- **Layer 8A.1, upper Dirichlet density.** The crossing argument of Layer 8C produces a
bound on a `liminf` and nothing better, so the one-sided notions are needed, not decorative. -/
def HasUpperDirichletDensity (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  limsup (fun s : ℝ ↦ primeIdealZetaSum K S s /
    primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s) (𝓝[>] 1) = δ

/-- **Layer 8A.1, lower Dirichlet density.** -/
def HasLowerDirichletDensity (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  liminf (fun s : ℝ ↦ primeIdealZetaSum K S s /
    primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s) (𝓝[>] 1) = δ

/-- **Layer 8A.1, a lower bound on the lower Dirichlet density.** ⚠ This inequality, and not
`HasLowerDirichletDensity`, is what the crossing argument of 8C produces: the tagged fibres are
contained in the target set and need not exhaust it. `HasLowerDirichletDensity S δ` asserts an
equality of the `liminf` with `δ`, which is stronger than the argument gives. -/
def LowerDirichletDensityAtLeast (S : Set (HeightOneSpectrum (𝓞 K))) (c : ℝ) : Prop :=
  c ≤ liminf (fun s : ℝ ↦ primeIdealZetaSum K S s /
    primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s) (𝓝[>] 1)

/-- **Layer 8A.3, the squeeze.** Pairwise disjoint sets whose union has density `1`, each with a
lower bound, and whose lower bounds sum to `1`, all have exactly their bounds as densities. This
is the step 8C.8 uses, and it is why 8C only ever produces an inequality. -/
example {ι : Type*} [Fintype ι] (S : ι → Set (HeightOneSpectrum (𝓞 K))) (c : ι → ℝ)
    (hdisj : Pairwise (Function.onFun Disjoint S))
    (hunion : HasDirichletDensity K (⋃ i, S i) 1)
    (hlow : ∀ i, LowerDirichletDensityAtLeast K (S i) (c i))
    (hsum : ∑ i, c i = 1) :
    ∀ i, HasDirichletDensity K (S i) (c i) := sorry

/-- **Layer 8A.2, the denominator theorem.** This is what reconciles the definition above
with Neukirch's, and it is proved once; after it, no statement mentions `log((s−1)⁻¹)`. -/
example :
    Tendsto (fun s : ℝ ↦
        primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s /
          Real.log ((s - 1)⁻¹))
      (𝓝[>] 1) (𝓝 1) := sorry

/-- **Layer 8A.3, upper and lower agreeing gives the density.** -/
example (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ)
    (hu : HasUpperDirichletDensity K S δ) (hl : HasLowerDirichletDensity K S δ) :
    HasDirichletDensity K S δ := sorry

/-- **Layer 8A.3, a finite symmetric difference does not change the density.** With it, the
finitely many ramified primes may be removed from any set for free — the lemma every
statement of Layer 8D quietly needs. -/
example (S T : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ)
    (h : (symmDiff S T).Finite) (hS : HasDirichletDensity K S δ) :
    HasDirichletDensity K T δ := sorry

/-- **Layers 8A.1 and 9, natural density** for a set of primes of `𝓞 K`, by counting primes of
bounded norm. -/
noncomputable def HasNaturalDensity
    (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  Tendsto
    (fun x : ℝ ↦
      (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) //
          𝔭 ∈ S ∧ (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ) /
      (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ))
    atTop (𝓝 δ)

/-- **Layer 8A.7, natural density implies Dirichlet density**, with the same value (Abel
summation). ⚠ The converse is false; every density statement in this roadmap names its
density. -/
example (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) (h : HasNaturalDensity K S δ) :
    HasDirichletDensity K S δ := sorry

section Chebotarev

variable (L : Type*) [Field L] [NumberField L] [Algebra K L]

/-- **Layer 8.0, unramifiedness**, as one shared predicate. Every statement of Layer 8 uses
this and never an ad hoc test against a discriminant. -/
def IsUnramifiedAt (𝔭 : HeightOneSpectrum (𝓞 K)) : Prop :=
  Ideal.ramificationIdxIn 𝔭.asIdeal (𝓞 L) = 1

variable [IsGalois K L]

/-- **Layer 8.0, the Frobenius interface (compatibility interface).** The number field
arithmetic roadmap, Layers 2 and 5, will own this vocabulary. Until its declarations exist,
Layer 8 is stated over this structure, which carries exactly the operations 8A to 8E use.

The replacement is mechanical: delete this structure, take `frobeniusClass` to be that
roadmap's declaration of the same name, and leave 8A to 8E unchanged. This roadmap defines no second Frobenius.

⚠ Frobenius here is arithmetic. Layer 8B.1 tests the orientation, and Layer 8B.5 is the
numerical example that would detect an inverse. -/
structure FrobeniusInterface where
  /-- The Frobenius class of an unramified prime. -/
  frobeniusClass : ∀ 𝔭 : HeightOneSpectrum (𝓞 K), IsUnramifiedAt K L 𝔭 →
    ConjClasses (L ≃ₐ[K] L)
  /-- Only finitely many primes ramify. -/
  unramified_cofinite : {𝔭 : HeightOneSpectrum (𝓞 K) | ¬ IsUnramifiedAt K L 𝔭}.Finite
  /-- The class is realized by an arithmetic Frobenius over some prime of `L`, in the sense of
  Mathlib's `IsArithFrobAt` transported along `galRestrict`. This field is what ties the
  interface to the pin's vocabulary, and it is what a later implementation must prove. -/
  frobeniusClass_spec : ∀ (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭) (σ : L ≃ₐ[K] L),
    σ ∈ (frobeniusClass 𝔭 h).carrier ↔
      ∃ Q : Ideal (𝓞 L), Q.IsPrime ∧ Q.under (𝓞 K) = 𝔭.asIdeal ∧
        ∀ x : 𝓞 L, σ • x - x ^ Nat.card (𝓞 K ⧸ 𝔭.asIdeal) ∈ Q

/-- **Layer 8.0, restriction compatibility**, against Mathlib's canonical restriction
homomorphism `AlgEquiv.restrictNormalHom`, and not against an arbitrary parameter. Milestones
8C.3 and 8D.2 use exactly this square, so it is stated here rather than assumed there. -/
def RestrictionCompatible (F : FrobeniusInterface K L)
    (E : IntermediateField K L) [Normal K E]
    (FE : FrobeniusInterface K E) : Prop :=
  ∀ (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭) (hE : IsUnramifiedAt K E 𝔭),
    ConjClasses.map (AlgEquiv.restrictNormalHom (F := K) (K₁ := L) E)
        (F.frobeniusClass 𝔭 h) = FE.frobeniusClass 𝔭 hE

/-- **Layer 8D.5, the Chebotarev density theorem over a general number field.**

The base is an arbitrary `K`. The prime set is cut out over `HeightOneSpectrum (𝓞 K)`, and
unramifiedness is the shared predicate of Layer 8.0. The Frobenius class comes from the
compatibility interface, so no rival Frobenius is created here. -/
example (F : FrobeniusInterface K L) (C : ConjClasses (L ≃ₐ[K] L)) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | ∃ h : IsUnramifiedAt K L 𝔭, F.frobeniusClass 𝔭 h = C}
      ((Nat.card C.carrier : ℝ) / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

/-- **Layer 8D.6, splitting completely**, as a corollary of the theorem above: the primes that
split completely in `L` have Dirichlet density `1/#Gal(L/K)`. -/
example (F : FrobeniusInterface K L) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | ∃ h : IsUnramifiedAt K L 𝔭, F.frobeniusClass 𝔭 h = 1}
      (1 / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

end Chebotarev

/-- **Layer 8B.5, Dirichlet's theorem with a density**, the specialization of the general
theorem to `ℚ(ζ₅)/ℚ`: the primes `p ≡ a (mod 5)` have Dirichlet density `1/4`, from which
the pin's `Nat.infinite_setOf_prime_and_eq_mod` follows. ⚠ The Frobenius orientation is
arithmetic: `Frob_p` sends `ζ₅ ↦ ζ₅^p` and so gives the class of `p mod 5`, not its
inverse. That a general theorem specializes visibly to this one is an acceptance
criterion. -/
example (a : (ZMod 5)ˣ) :
    Tendsto
      (fun s : ℝ ↦
        (∑' p : {p : ℕ | p.Prime ∧ (p : ZMod 5) = (a : ZMod 5)}, ((p : ℕ) : ℝ) ^ (-s)) /
          Real.log ((s - 1)⁻¹))
      (𝓝[>] 1) (𝓝 (1 / 4)) := sorry

/-! ## Layer 9: prime counting -/

/-- **Layer 9.1, the Tauberian input, with its actual hypotheses.** This is
PrimeNumberTheoremAnd's `WienerIkeharaTheorem'`, absent from Mathlib. Layer 9 either
integrates that proof with its authors' agreement or proves it here in this shape; either
way the hypotheses below are what the rest of the layer may assume, and nothing weaker. -/
example (a : ℕ → ℝ) (F G : ℂ → ℂ) (κ : ℝ) (ha : ∀ n, 0 ≤ a n)
    -- ⚠ Summability is a hypothesis. Without it, Mathlib's `LSeries` is the junk value `0`
    -- where the series diverges, so `hF` is satisfiable by `F = 0` for a rapidly growing
    -- nonnegative `a`, and the conclusion is then false.
    (hsum : ∀ s : ℂ, 1 < s.re → LSeriesSummable (fun n ↦ (a n : ℂ)) s)
    (hF : ∀ s : ℂ, 1 < s.re → F s = LSeries (fun n ↦ (a n : ℂ)) s)
    -- ⚠ The boundary hypothesis names a separate continuous `G`. Asserting continuity of
    -- `s ↦ F s - κ/(s-1)` on the closed half-plane is meaningless at `s = 1`, where both
    -- summands are junk values.
    (hG : ContinuousOn G {s : ℂ | 1 ≤ s.re})
    (hFG : ∀ s : ℂ, 1 < s.re → G s = F s - (κ : ℂ) / (s - 1)) :
    Tendsto (fun x : ℝ ↦ (∑ n ∈ Finset.range ⌊x⌋₊.succ, a n) / x) atTop (𝓝 κ) := sorry

/-- **Layer 9.3, `ψ_K(x) ∼ x`.** -/
noncomputable def psi (x : ℝ) : ℝ :=
  ∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ x}, (idealVonMangoldt K I).re

/-- **Layer 9.3**: apply the Tauberian theorem to `-ζ_K'/ζ_K`, the continuous extension to
`Re s ≥ 1` coming from Layer 7.5. -/
example : Tendsto (fun x : ℝ ↦ psi K x / x) atTop (𝓝 1) := sorry

/-- **Layer 9.4, `θ_K(x) ∼ x`**, after discarding the prime powers, which contribute
`O(√x log² x)`. -/
noncomputable def theta (x : ℝ) : ℝ :=
  ∑ᶠ 𝔭 : {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x},
    Real.log (Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal)

/-- **Layer 9.4**: the prime-power contribution is lower order. -/
example : (fun x : ℝ ↦ psi K x - theta K x) =O[atTop]
    fun x : ℝ ↦ Real.sqrt x * (Real.log x) ^ 2 := sorry

/-- **Layer 9.6, the prime ideal theorem** `π_K(x) ∼ x / log x` (Landau), from `θ_K` by
partial summation. At `K = ℚ` this specializes to the prime number theorem, and the
milestone there is agreement with PrimeNumberTheoremAnd's `pi_asymp`, never a second
proof. -/
example :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ) /
          (x / Real.log x))
      atTop (𝓝 1) := sorry

/-- **Layer 9.7, the counting asymptotic for one Frobenius fibre.**

⚠ Do not apply Wiener–Ikehara to an individual character twist. The coefficients
`χ 𝔞 · Λ_K 𝔞` are signed or complex, and 9.1 is a theorem about **nonnegative** coefficients.
Make the coefficients nonnegative first: for a fixed `σ`, sum the von Mangoldt weight over the
ideals whose Frobenius is `σ`. Character orthogonality, 8B.3, then writes the Dirichlet series
of that nonnegative sequence as a finite combination of logarithmic derivatives, where the
trivial character supplies the pole and each nontrivial one extends continuously to the boundary
by 7.4. -/
example (P : Ideal (𝓞 K) → Prop) (c : ℝ) :
    Tendsto
      (fun x : ℝ ↦
        (∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ x ∧ P I},
          (idealVonMangoldt K (I : Ideal (𝓞 K))).re) / x)
      atTop (𝓝 c) := sorry

/-- **Layer 9.9, natural-density Chebotarev, worked at `ℚ(ζ₅)/ℚ`**: the primes
`p ≡ a (mod 5)` have natural density `1/4`. ⚠ This is obtained through the counting
asymptotic of Layer 9.8, not by converting a Dirichlet density into a natural one — no such
conversion exists. -/
example (a : (ZMod 5)ˣ) :
    Tendsto
      (fun n : ℕ ↦
        (Nat.card {p : ℕ // p ≤ n ∧ p.Prime ∧ (p : ZMod 5) = (a : ZMod 5)} : ℝ) /
          (Nat.primeCounting n : ℝ))
      atTop (𝓝 (1 / 4)) := sorry

end TauCetiRoadmap.LFunctions
