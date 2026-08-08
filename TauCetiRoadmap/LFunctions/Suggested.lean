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

The file states pin-elaborating targets from **Layer 0** (the analytic data record, its dual,
its ζ and Dirichlet cards, and the normalization translation with its two tests), **Layer 1**
(the norm coefficient, its weighted form, local Euler-factor data, the Euler product, the
partial zeta functions and their common residue), **Layer 2** (the trace-to-Euclidean map and
the functional equation with a level), **Layer 3** (continuation and functional equation of
the Dedekind zeta function), **Layer 4** (the `ℚ(i)` and cyclotomic factorizations),
**Layer 5** (the ray class group, its characters, and the completed Hecke L-function),
**Layer 6** (Grossencharacters), **Layer 7** (Landau's theorem, the cancelling family, and
nonvanishing in meromorphic-order form), **Layer 8** (the density predicates, the Frobenius
class, the crossing constant, and Chebotarev over a general base field), and **Layer 9**
(Wiener–Ikehara, `ψ_K`, `θ_K`, `π_K`, the Frobenius-fibre count, and Mertens), with `sorry`.

⚠ **No milestone here is stated over an interface structure supplied by another roadmap.** An
object that a sibling roadmap will eventually own is *constructed* here, from the modulus and
the ray quotient in Layer 5.1, from the unitary weight and the infinity type in Layer 6.1, and
from Mathlib's `arithFrobAt` in Layer 8.0. A theorem quantified over `(F : SomeInterface)` is
conditional on an arbitrary term of that structure, and unrelated terms satisfy the fields of a
small structure, so the public theorems below take no such parameter.
[`PROVENANCE.md`](PROVENANCE.md) records which sibling roadmap each construction is expected to
be replaced by, and how.

Per the honest-`sorry` rule, a milestone whose *statement* needs API that does not exist at
the pin is not stated here, and lives in `README.md` only. That applies to the lattice theta
transformations of Layer 2, since the pin has no dual lattice.
-/

namespace TauCetiRoadmap.LFunctions

open Complex NumberField NumberField.InfinitePlace Filter Topology Asymptotics
open IsDedekindDomain (HeightOneSpectrum)
open scoped nonZeroDivisors

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
non-self-dual instance needs and the reason `dual` is owned here.

⚠ The two nonpole hypotheses are not decoration. `HasFunctionalEquation.eq_away` constrains
values only where both relevant polar orders vanish, and at a pole the value of the total
representative `completed` is an arbitrary number that no field of the record touches. A version
of this theorem quantified over every `s` asserts an equality between two junk values, and is
false for the ζ card at `s = 0`. -/
theorem hasFunctionalEquation_dual {d : AnalyticLFunctionData} (h : d.HasFunctionalEquation)
    (s : ℂ) (hs : d.polarOrder s = 0) (hr : d.polarOrder (reflectedPoint s) = 0) :
    d.completed s = d.rootNumber * d.dual.completed (1 - s) := sorry

/-- **Layer 0.3, the functional equation at a pole**, which is the statement that survives there:
the two *germs* agree, so the principal parts match. This, and not an equality of values, is what
a consumer working at `s = 0` or `s = 1` may use. -/
theorem hasFunctionalEquation_eventuallyEq {d : AnalyticLFunctionData}
    (hc : d.HasMeromorphicContinuation) (h : d.HasFunctionalEquation) (s : ℂ) :
    (fun z ↦ d.completed z) =ᶠ[𝓝[≠] s]
      (fun z ↦ d.rootNumber * d.dual.completed (1 - z)) := sorry

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
number (fields of the translation) this is the list of invariants the LMFDB relies on.
⚠ Named, because the normalization translation is an interface this roadmap supplies, and a
consumer cannot cite an `example`. -/
theorem NormalizationTranslation.degree_eq (T : NormalizationTranslation) :
    T.analytic.degree = T.arithmetic.toAnalyticLFunctionData.degree := sorry

/-- **Layer 0.4, existence and uniqueness of the translation**: every arithmetic record of
weight `w` has exactly one analytic partner. -/
theorem NormalizationTranslation.existsUnique (a : ArithmeticLFunctionData) (w : ℤ) :
    ∃! T : NormalizationTranslation, T.arithmetic = a ∧ T.weight = w := sorry

/-- **Layer 0.4, the translated functional equation.** The arithmetic equation is centered at
`(w+1)/2`, the analytic one at `1/2`, and under the translation each implies the other. This is
the theorem the modular forms card of 0.7 and the zeros roadmap read; without it the translation
records a change of variables and says nothing about the equation it is there to move.

⚠ The constant `N^{-w/4}` cancels between the two sides. That cancellation is the content: a
translation with the shift in the wrong direction still typechecks, and is caught here and in
`arithmeticFunctionalEquation_delta` below. -/
theorem NormalizationTranslation.hasFunctionalEquation_iff (T : NormalizationTranslation) :
    T.analytic.HasFunctionalEquation ↔
      (‖T.arithmetic.rootNumber‖ = 1 ∧
        (∀ s : ℂ, T.arithmetic.polarOrder s =
          T.arithmetic.polarOrder ((T.weight : ℂ) + 1 - starRingEnd ℂ s)) ∧
        ∀ s : ℂ, T.arithmetic.polarOrder s = 0 →
          T.arithmetic.polarOrder ((T.weight : ℂ) + 1 - starRingEnd ℂ s) = 0 →
            T.arithmetic.completed s =
              T.arithmetic.rootNumber *
                T.arithmetic.toAnalyticLFunctionData.dualCompleted ((T.weight : ℂ) + 1 - s)) :=
  sorry

/-- **Layer 0.4, mandatory test one: `w = 0`.** At weight zero the translation is the identity on
every field, so the analytic and arithmetic records coincide. A translation that put the shift in
the wrong place would still typecheck, and would still pass this test only if the shift is
`w/2` in both directions. -/
theorem NormalizationTranslation.eq_of_weight_zero (T : NormalizationTranslation)
    (hw : T.weight = 0) :
    T.analytic = T.arithmetic.toAnalyticLFunctionData := sorry

/-- **Layer 0.4, mandatory test two: the discriminant form `Δ`, at `w = 11`.** The arithmetic
gamma data of a weight-`k` newform is the single complex shift `0`, so the analytic shift is
`+11/2` and not `−11/2`. This is the instance where a sign error in `gammaC_eq` first becomes
visible; the `w = 0` test cannot see it. -/
theorem NormalizationTranslation.gammaC_delta (T : NormalizationTranslation)
    (hw : T.weight = 11) (hΔ : T.arithmetic.gammaC = {0}) (hR : T.arithmetic.gammaR = 0) :
    T.analytic.gammaC = {(11 : ℂ) / 2} ∧ T.analytic.degree = 2 := sorry

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

/-- **Layer 1.9, the continued L-function of an ideal weight**, on the strip
`Re s > 1 − 1/[K:ℚ]`. ⚠ Named, and not left as the `F` of an `∃`-statement: 7.3, 7.4, 8B.5 and
9.7 all state properties of this object, an anonymous existential cannot be cited by another
roadmap, and Layer 3.5's uniqueness is what makes the two theorems below determine it rather
than merely constrain it. -/
noncomputable def continuedLFunctionOfWeight (χ : IdealWeight K) : ℂ → ℂ := sorry

theorem continuedLFunctionOfWeight_eq (χ : IdealWeight K) {s : ℂ} (hs : 1 < s.re) :
    continuedLFunctionOfWeight K χ s = LSeries (idealCoeffOfWeight K χ.toFun) s := sorry

/-- **Layer 7.2, cancellation gives continuation** into the strip `Re s > 1 - 1/[K:ℚ]`. -/
theorem analyticOnNhd_continuedLFunctionOfWeight (χ : IdealWeight K) (hχ : HasCancellation K χ) :
    AnalyticOnNhd ℂ (continuedLFunctionOfWeight K χ)
      {s : ℂ | 1 - 1 / (Module.finrank ℚ K : ℝ) < s.re} := sorry

/-- **Layer 1.2, the ideals a weight is nonzero on**, as one named predicate. ⚠ `I ≠ ⊥` is part
of it. In `Ideal (𝓞 K)` divisibility is reverse inclusion, so `𝔭 ∣ ⊥` holds for **every** prime,
and a "prime to the bad set" condition written without `I ≠ ⊥` is vacuously satisfied by `⊥`
whenever the bad set is empty. Every weight in this roadmap sends `⊥` to `0`, so a law that
concludes `toFun I = 1` under that vacuous premise is false at the trivial modulus. -/
def IdealWeight.IsGood (χ : IdealWeight K) (I : Ideal (𝓞 K)) : Prop :=
  I ≠ ⊥ ∧ ∀ 𝔭 ∈ χ.bad, ¬ 𝔭.asIdeal ∣ I

/-- **Layer 1.2, the norm twist of an ideal weight**, `χ ‖·‖^{it}`, which the argument on
`Re s = 1` needs and which the closure condition of 7.2 quantifies over. -/
noncomputable def IdealWeight.normTwist (χ : IdealWeight K) (t : ℝ) : IdealWeight K where
  toFun I := χ.toFun I * ((Ideal.absNorm I : ℝ) : ℂ) ^ (Complex.I * (t : ℂ))
  bad := χ.bad
  bad_finite := χ.bad_finite
  map_mul := sorry
  norm_eq_one := sorry
  eq_zero_bad := sorry

/-- **Layer 7.2, the hypothesis package a nonvanishing proof needs.**

⚠ `HasCancellation χ` alone is not enough for any of 7.3, 7.4, 7.5, or 8B.5. The `3-4-1` argument
uses `χ`, `χ²`, and the conjugate of `χ`, and the argument on `Re s = 1` uses the norm twists
`χ ‖·‖^{it}`; cancellation for `χ` implies cancellation for none of them. So the hypotheses are
stated once, over a **family**, and 7.3 and 7.4 are theorems about a `CancellingFamily`,
instantiated in 7.5 by the ray-class characters and in 8B.2 by the cyclotomic ones. A
single-weight statement would be false at the advertised generality. -/
structure CancellingFamily (G : Type*) [CommGroup G] [Fintype G] (w : G → IdealWeight K) :
    Prop where
  /-- The family is a homomorphism to pointwise products, so it is closed under products and
  hence contains `χ²`. -/
  map_mul : ∀ g h : G, ∀ I : Ideal (𝓞 K), (w (g * h)).toFun I = (w g).toFun I * (w h).toFun I
  /-- The identity of `G` is the trivial weight: the value `1` at every **good** ideal. It is the
  member that supplies the pole, and 7.3 and 7.4 exclude it by name.

  ⚠ The carrier is `IdealWeight.IsGood`, which includes `I ≠ ⊥`. Without that the field is false
  for the advertised ray-class instance: at the modulus with finite part `1` the bad set is empty,
  so the prime-to-bad condition holds vacuously at `I = ⊥`, while the derived ray-class weight is
  `0` there because `Modulus.IsCoprimeTo` requires `I ≠ ⊥`. The modulus-one case is the ordinary
  class-group family, so this is not an edge case that can be waved away. -/
  map_one : ∀ I : Ideal (𝓞 K), IdealWeight.IsGood K (w 1) I → (w 1).toFun I = 1
  /-- Every nontrivial member cancels. This is the analytic content, and it is what 7.1 turns
  into continuation into the strip. -/
  cancellation : ∀ g : G, g ≠ 1 → HasCancellation K (w g)
  /-- Closure under conjugation, which the `3-4-1` product needs. -/
  conj : ∀ g : G, ∃ h : G, ∀ I : Ideal (𝓞 K),
    (w h).toFun I = starRingEnd ℂ ((w g).toFun I)
  /-- ⚠ Closure of the cancellation property under the norm twists, for the **nontrivial**
  members only. Without it 7.4 has no hypothesis to run the `3-4-1` inequality on at `1 + it`.

  ⚠ Requiring it at `g = 1` as well, for `t ≠ 0`, makes the structure uninhabitable by its own
  principal examples, so it is false as a field. The twisted trivial weight has coefficients
  `𝔑𝔞^{it}`, and since `#{𝔞 : 𝔑𝔞 ≤ X} ∼ ρ_K X`, partial summation gives
  `∑_{𝔑𝔞 ≤ X} 𝔑𝔞^{it} ∼ ρ_K X^{1+it}/(1+it)`, of absolute value comparable to `X`, while
  `HasCancellation` demands `O(X^{1−1/d})`. Equivalently the series is `ζ_K(s − it)`, which has a
  pole at `s = 1 + it`, and a cancellation hypothesis would make it holomorphic there.

  The trivial member is handled separately, and not through this field: at `t = 0` it is the pole
  of `ζ_K`, and at `t ≠ 0` the nonvanishing of `ζ_K(1 + it)` is
  `meromorphicOrderAt_dedekindZetaC_one_add`, a theorem of 7.4 about `ζ_K` itself. -/
  cancellation_normTwist : ∀ g : G, g ≠ 1 → ∀ t : ℝ,
    HasCancellation K (IdealWeight.normTwist K (w g) t)

/-- **Layer 1.2, the pointwise square of an ideal weight**, which the `3-4-1` product needs. -/
noncomputable def IdealWeight.sq (χ : IdealWeight K) : IdealWeight K where
  toFun I := χ.toFun I ^ 2
  bad := χ.bad
  bad_finite := χ.bad_finite
  map_mul := sorry
  norm_eq_one := sorry
  eq_zero_bad := sorry

/-- **Layer 1.2, the conjugate weight**, the third factor of the `3-4-1` product. -/
noncomputable def IdealWeight.conjugate (χ : IdealWeight K) : IdealWeight K where
  toFun I := starRingEnd ℂ (χ.toFun I)
  bad := χ.bad
  bad_finite := χ.bad_finite
  map_mul := sorry
  norm_eq_one := sorry
  eq_zero_bad := sorry

/-- **Layer 7.2, the hypothesis package for a single, possibly infinite-order, unitary
character.**

⚠ `CancellingFamily` cannot carry this, and the difference is not cosmetic. That structure is
indexed by a `Fintype`, so for every `g` some positive power is `1`; `map_mul` and `map_one` then
force every good value of `w g` to satisfy `x^{#G} = 1`, hence to be a root of unity. A unitary
Grossencharacter with a nonzero archimedean parameter has infinite order, and so does every norm
twist `𝔑^{it}` with `t ≠ 0`, so neither can be a member of a finite family. Layers 7.5 and 8B.2
keep the finite package, because their character groups really are finite; Layer 7.7 is stated
over this one.

The fields are exactly what the `3-4-1` argument consumes: `χ`, `χ²`, the conjugate, and the norm
twists of `χ` and `χ²`. The trivial factor is `ζ_K`, whose pole is
`meromorphicOrderAt_dedekindZetaC_one` and whose boundary nonvanishing is
`meromorphicOrderAt_dedekindZetaC_one_add`, so it is a citation and not a field. -/
structure UnitaryCancelling (χ : IdealWeight K) : Prop where
  cancellation : HasCancellation K χ
  cancellation_sq : HasCancellation K (IdealWeight.sq K χ)
  cancellation_conjugate : HasCancellation K (IdealWeight.conjugate K χ)
  cancellation_normTwist : ∀ t : ℝ, HasCancellation K (IdealWeight.normTwist K χ t)
  cancellation_sq_normTwist : ∀ t : ℝ,
    HasCancellation K (IdealWeight.normTwist K (IdealWeight.sq K χ) t)

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

/-! ### Layers 1.7 and 1.8: moduli, the ray class group, and partial zeta functions

The carriers named in the prose of 1.7 — the modulus, `J^{𝔪₀}`, `P^𝔪`, and the quotient — are
built here, because Layers 5, 7.5, 8E, and 9.11 all read them. Nothing below is stated over an
interface: a ray-class character in Layer 5.1 is a character of the quotient constructed here. -/

/-- **Layer 1.7, a modulus** `𝔪 = 𝔪₀ 𝔪_∞`. ⚠ The finite part and the infinite part are separate
data, and neither may be dropped: the gamma factor of 5.5 reads `𝔪_∞`, and the level of 5.7
reads `𝔪₀`. -/
structure Modulus where
  /-- The finite part `𝔪₀`. -/
  finitePart : Ideal (𝓞 K)
  finitePart_ne_bot : finitePart ≠ ⊥
  /-- The infinite part `𝔪_∞`, a set of **real** places. -/
  infinitePart : Finset (InfinitePlace K)
  infinitePart_isReal : ∀ v ∈ infinitePart, v.IsReal

section RayClass

variable {K}

namespace Modulus

/-- **Layer 1.7, `J^{𝔪₀}`**, the group of fractional ideals prime to the finite part, realized as
the subgroup of the ideal group generated by the primes that do not divide `𝔪₀`. -/
noncomputable def coprimeIdeals (𝔪 : Modulus K) : Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ :=
  Subgroup.closure {I : (FractionalIdeal (𝓞 K)⁰ K)ˣ | ∃ 𝔭 : HeightOneSpectrum (𝓞 K),
    ¬ 𝔭.asIdeal ∣ 𝔪.finitePart ∧
      (I : FractionalIdeal (𝓞 K)⁰ K) = (𝔭.asIdeal : FractionalIdeal (𝓞 K)⁰ K)}

/-- **Layer 1.7, `P^𝔪`**, the ray subgroup: generated by the principal ideals `(α)` with
`α ≡ 1 mod 𝔪₀` and `α` positive at every place of `𝔪_∞`.

⚠ It is the **subgroup generated by** those, and it is a group of *fractional* ideals. A
condition written only on integral `α` is not a subgroup of the ideal group, and a weight
trivial on such a set of integral elements need not factor through the quotient below. That is
the defect a field named `trivial_on_congruence` on an ideal weight has. -/
noncomputable def rayPrincipal (𝔪 : Modulus K) : Subgroup (FractionalIdeal (𝓞 K)⁰ K)ˣ :=
  Subgroup.closure {I : (FractionalIdeal (𝓞 K)⁰ K)ˣ | ∃ α : 𝓞 K, α ≠ 0 ∧
    α - 1 ∈ 𝔪.finitePart ∧
    (∀ v ∈ 𝔪.infinitePart, 0 < (v.embedding (algebraMap (𝓞 K) K α)).re) ∧
    (I : FractionalIdeal (𝓞 K)⁰ K) = ((Ideal.span {α} : Ideal (𝓞 K)) : FractionalIdeal (𝓞 K)⁰ K)}

theorem rayPrincipal_le_coprimeIdeals (𝔪 : Modulus K) :
    𝔪.rayPrincipal ≤ 𝔪.coprimeIdeals := sorry

/-- **Layer 1.7, the ray class group** `J^{𝔪₀}/P^𝔪`, as an explicit quotient of explicit
subgroups. Layer 5.1's characters are characters of this group. -/
noncomputable def RayClassGroup (𝔪 : Modulus K) : Type _ :=
  𝔪.coprimeIdeals ⧸ 𝔪.rayPrincipal.subgroupOf 𝔪.coprimeIdeals

noncomputable instance (𝔪 : Modulus K) : CommGroup 𝔪.RayClassGroup :=
  inferInstanceAs (CommGroup (𝔪.coprimeIdeals ⧸ 𝔪.rayPrincipal.subgroupOf 𝔪.coprimeIdeals))

/-- **Layer 1.7, finiteness of the ray class group.** It is what makes 1.7's sum over `Q` finite
and every character of 5.1 of finite order. -/
theorem finite_rayClassGroup (𝔪 : Modulus K) : Finite 𝔪.RayClassGroup := sorry

/-- **Layer 1.7, coprimality to the modulus**, as one predicate used by everything below. -/
def IsCoprimeTo (𝔪 : Modulus K) (I : Ideal (𝓞 K)) : Prop :=
  I ≠ ⊥ ∧ ∀ 𝔭 : HeightOneSpectrum (𝓞 K), 𝔭.asIdeal ∣ 𝔪.finitePart → ¬ 𝔭.asIdeal ∣ I

/-- **Layer 1.7, the ray class of an integral ideal prime to `𝔪₀`.** The value on an ideal that
is not prime to `𝔪₀` is not used; the three theorems below are the whole interface. -/
noncomputable def idealClass (𝔪 : Modulus K) (I : Ideal (𝓞 K)) : 𝔪.RayClassGroup := sorry

theorem idealClass_mul (𝔪 : Modulus K) {I J : Ideal (𝓞 K)}
    (hI : 𝔪.IsCoprimeTo I) (hJ : 𝔪.IsCoprimeTo J) :
    𝔪.idealClass (I * J) = 𝔪.idealClass I * 𝔪.idealClass J := sorry

/-- **Layer 1.7**: the class map kills exactly the ray-principal ideals. This is what "the weight
factors through the ray class group" means, and it is a theorem about a canonical map rather than
a field on an arbitrary function. -/
theorem idealClass_eq_one_iff (𝔪 : Modulus K) {I : Ideal (𝓞 K)} (hI : 𝔪.IsCoprimeTo I) :
    𝔪.idealClass I = 1 ↔
      ∃ α β : 𝓞 K, α ≠ 0 ∧ β ≠ 0 ∧ α - 1 ∈ 𝔪.finitePart ∧ β - 1 ∈ 𝔪.finitePart ∧
        (∀ v ∈ 𝔪.infinitePart, 0 < (v.embedding (algebraMap (𝓞 K) K α)).re) ∧
        (∀ v ∈ 𝔪.infinitePart, 0 < (v.embedding (algebraMap (𝓞 K) K β)).re) ∧
        I * Ideal.span {β} = Ideal.span {α} := sorry

/-- **Layer 1.7**: every class contains an integral ideal prime to `𝔪₀`. This is the surjectivity
that makes the fibres of `idealClass` a partition of those ideals, and it is what 5.6's choice of
ray-class representatives rests on. -/
theorem idealClass_surjective (𝔪 : Modulus K) (c : 𝔪.RayClassGroup) :
    ∃ I : Ideal (𝓞 K), 𝔪.IsCoprimeTo I ∧ 𝔪.idealClass I = c := sorry

/-- **Layer 1.7, divisibility of moduli**, which is the order induction runs along. -/
def Dvd (𝔫 𝔪 : Modulus K) : Prop :=
  𝔫.finitePart ∣ 𝔪.finitePart ∧ 𝔫.infinitePart ⊆ 𝔪.infinitePart

/-- **Layer 1.7, the canonical projection between the ray class groups of nested moduli.**
Induction of characters in 5.4 is precomposition with this map, and primitivity in 5.1 is stated
against it, so it is a named declaration and not an existential. -/
noncomputable def classMap {𝔫 𝔪 : Modulus K} (h : 𝔫.Dvd 𝔪) :
    𝔪.RayClassGroup →* 𝔫.RayClassGroup := sorry

theorem classMap_idealClass {𝔫 𝔪 : Modulus K} (h : 𝔫.Dvd 𝔪) {I : Ideal (𝓞 K)}
    (hI : 𝔪.IsCoprimeTo I) : classMap h (𝔪.idealClass I) = 𝔫.idealClass I := sorry

theorem classMap_surjective {𝔫 𝔪 : Modulus K} (h : 𝔫.Dvd 𝔪) :
    Function.Surjective (classMap h) := sorry

/-- **Layer 1.7, the ray partial zeta function** on an exact carrier: the fibre of `idealClass`
over `c`, taken over the integral ideals prime to `𝔪₀`.

⚠ `∑'` and not `∑ᶠ`. Mathlib's `finsum` is the sum of a **finitely supported** function and takes
the junk value `0` otherwise, and every fibre here has infinitely many ideals in it. A partial
zeta function written with `∑ᶠ` is the constant `0`, so the sum formula, the residue of 1.8, the
cancellation of 7.5, and the equidistribution of 8E would all be statements about that constant.
`finsum` stays legitimate exactly where the index set is finite: ideals of one fixed norm, ideals
of norm at most `x`, the primes dividing `𝔪₀`, and the sum over classes below. -/
noncomputable def partialZeta (𝔪 : Modulus K) (c : 𝔪.RayClassGroup) (s : ℂ) : ℂ :=
  ∑' I : {I : Ideal (𝓞 K) // 𝔪.IsCoprimeTo I ∧ 𝔪.idealClass I = c},
    (Ideal.absNorm (I : Ideal (𝓞 K)) : ℂ) ^ (-s)

/-- **Layer 1.7, summability of a fibre** on the convergence half-plane, which is what makes
`partialZeta` the sum of its series rather than `tsum`'s junk value `0`, and what licenses the
finite interchange with the class sum below. -/
theorem summable_partialZeta (𝔪 : Modulus K) (c : 𝔪.RayClassGroup) {s : ℂ} (hs : 1 < s.re) :
    Summable fun I : {I : Ideal (𝓞 K) // 𝔪.IsCoprimeTo I ∧ 𝔪.idealClass I = c} ↦
      (Ideal.absNorm (I : Ideal (𝓞 K)) : ℂ) ^ (-s) := sorry

/-- **Layer 1.7, the fibres sum to `ζ_K` with the bad Euler factors removed.**

⚠ The right-hand side is **not** `ζ_K`. Every ideal divisible by a prime of `𝔪₀` is missing from
every fibre, so the finite product is there. At `𝔪₀ = 1` the product is empty and the statement
is the decomposition over the ideal classes.

⚠ The outer sum over classes is a `finsum`, and that is legitimate: `finite_rayClassGroup` makes
the index type finite. The inner sum over ideals is a `tsum`, and must be. -/
theorem sum_partialZeta (𝔪 : Modulus K) {s : ℂ} (hs : 1 < s.re) :
    ∑ᶠ c : 𝔪.RayClassGroup, 𝔪.partialZeta c s =
      dedekindZeta K s *
        ∏ᶠ 𝔭 : {𝔭 : HeightOneSpectrum (𝓞 K) // 𝔭.asIdeal ∣ 𝔪.finitePart},
          (1 - (Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℂ) ^ (-s)) := sorry

/-- **Layer 1.8, the common residue**, which does not depend on the class.

⚠ Check the specialization before using this. At `𝔪₀ = 1` with no infinite part the product is
empty and the quotient is the class group, so the residue is `Res ζ_K / h_K = ρ_K` **per class**,
and the `h_K` residues sum to `Res ζ_K`. A formula giving `ρ_K/h_K` here is wrong by a factor of
`h_K`, and no single numerical check with `h_K = 1` detects that. -/
theorem tendsto_sub_one_mul_partialZeta (𝔪 : Modulus K) (c : 𝔪.RayClassGroup) :
    Tendsto (fun s : ℂ ↦ (s - 1) * 𝔪.partialZeta c s) (𝓝[≠] 1)
      (𝓝 ((dedekindZeta_residue K : ℂ) / (Nat.card 𝔪.RayClassGroup : ℂ) *
        ∏ᶠ 𝔭 : {𝔭 : HeightOneSpectrum (𝓞 K) // 𝔭.asIdeal ∣ 𝔪.finitePart},
          (1 - (Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℂ)⁻¹))) := sorry

end Modulus

/-- **Layer 1.7, the ordinary partial zeta function**, over the ideal classes. It is the case
`𝔪₀ = 1` of the ray case, and it is stated separately because Layers 3.3 and 3.4 integrate it
class by class. -/
noncomputable def classPartialZeta (c : ClassGroup (𝓞 K)) (s : ℂ) : ℂ :=
  ∑' I : {I : (Ideal (𝓞 K))⁰ // ClassGroup.mk0 I = c}, (Ideal.absNorm I.1.1 : ℂ) ^ (-s)

theorem summable_classPartialZeta (c : ClassGroup (𝓞 K)) {s : ℂ} (hs : 1 < s.re) :
    Summable fun I : {I : (Ideal (𝓞 K))⁰ // ClassGroup.mk0 I = c} ↦
      (Ideal.absNorm I.1.1 : ℂ) ^ (-s) := sorry

theorem sum_classPartialZeta {s : ℂ} (hs : 1 < s.re) :
    ∑ᶠ c : ClassGroup (𝓞 K), classPartialZeta c s = dedekindZeta K s := sorry

/-- **Layer 1.8, the ordinary case**: each class contributes the residue `ρ_K`, and the `h_K` of
them sum to `Res_{s=1} ζ_K`. -/
theorem tendsto_sub_one_mul_classPartialZeta (c : ClassGroup (𝓞 K)) :
    Tendsto (fun s : ℂ ↦ (s - 1) * classPartialZeta c s) (𝓝[≠] 1)
      (𝓝 ((dedekindZeta_residue K : ℂ) / (Nat.card (ClassGroup (𝓞 K)) : ℂ))) := sorry

end RayClass

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

namespace FEPairWithLevel

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E]

/-- **Layer 2.14, the reduction to level one, as a real Mathlib object.** Rescaling by `√N`
sends a level-`N` pair to a genuine `WeakFEPair`, with the same weight and constant terms and
root number `ε · N^{k/2}`. Every rescaled hypothesis is discharged in the construction: local
integrability, the two decay bounds, and the level-one equation.

⚠ The output is Mathlib's structure and not a second `FEPairWithLevel`, and it is a **named
definition** and not an existential. `Λ`, `Λ_residue_k`, `Λ_residue_zero`, and the strong
condition are statements about a particular `WeakFEPair`, so a theorem of the shape
`∃ Q : WeakFEPair E, …` leaves every one of them unavailable. Layers 3.4, 3.6, 5.7, and 6.4
name the object below. -/
noncomputable def toWeakFEPair (P : FEPairWithLevel E) : WeakFEPair E where
  f x := P.f (Real.sqrt P.level * x)
  g x := P.g (Real.sqrt P.level * x)
  k := P.k
  ε := P.ε * ((P.level ^ (P.k / 2) : ℝ) : ℂ)
  f₀ := P.f₀
  g₀ := P.g₀
  hf_int := sorry
  hg_int := sorry
  hk := P.hk
  hε := sorry
  h_feq := sorry
  hf_top := sorry
  hg_top := sorry

/-- **Layer 2.14, the completed function of a level pair**, with the level power included, so
that the functional equation of 3.6 and 5.8 is free of constants. `Λ_K` is this at level
`|d_K|`, and `Λ(χ, ·)` is this at level `|d_K| 𝔑𝔣₀`. -/
noncomputable def Λ (P : FEPairWithLevel E) (s : ℂ) : E :=
  ((P.level : ℂ) ^ (s / 2)) • P.toWeakFEPair.Λ s

/-- **Layer 2.14**: the level completion is a Mellin transform of `P.f`, and not a function
introduced by the equality it is wanted to satisfy.

⚠ This is the milestone. A theorem of the shape `∃ F, ∀ s, F s = N^{s/2} • Q.Λ s` *defines* `F`
by that equation and identifies it with nothing, so it holds for a level pair with no analytic
content at all. -/
theorem Λ_eq_mellin (P : FEPairWithLevel E) (hf : P.f₀ = 0) (hg : P.g₀ = 0) {s : ℂ}
    (hs : P.k < s.re) : P.Λ s = mellin P.f s := sorry

/-- **Layer 2.14, the strong case.** When both constant terms vanish the rescaled pair satisfies
Mathlib's strong condition, so the level completion is entire. Layer 5.7's entirety for a
nontrivial character is this theorem. -/
theorem differentiable_Λ (P : FEPairWithLevel E) (hf : P.f₀ = 0) (hg : P.g₀ = 0) :
    Differentiable ℂ P.Λ := sorry

/-- **Layer 2.14, the residue at `s = k`, with the level written out.** Mathlib's
`WeakFEPair.Λ_residue_k` gives `ε • g₀` for the rescaled pair; the level contributes `N^{k/2}`
from the rescaled root number and `N^{k/2}` again from the factor `N^{s/2}`. -/
theorem Λ_residue_k (P : FEPairWithLevel E) :
    Tendsto (fun s : ℂ ↦ (s - P.k) • P.Λ s) (𝓝[≠] (P.k : ℂ))
      (𝓝 ((((P.level ^ P.k : ℝ) : ℂ) * P.ε) • P.g₀)) := sorry

/-- **Layer 2.14, the residue at `s = 0`.** The factor `N^{s/2}` is `1` there, so this residue
carries no power of the level. That asymmetry is why both residues are written out. -/
theorem Λ_residue_zero (P : FEPairWithLevel E) :
    Tendsto (fun s : ℂ ↦ s • P.Λ s) (𝓝[≠] 0) (𝓝 (-P.f₀)) := sorry

/-- **Layer 2.14, at level one the object is Mathlib's own.** A milestone that produced a second
copy at `N = 1` would not have reduced anything. -/
theorem toWeakFEPair_of_level_one (P : FEPairWithLevel E) (h : P.level = 1) :
    P.toWeakFEPair.f = P.f ∧ P.toWeakFEPair.g = P.g ∧ P.toWeakFEPair.k = P.k ∧
      P.toWeakFEPair.ε = P.ε ∧ P.Λ = P.toWeakFEPair.Λ := sorry

end FEPairWithLevel

/-! ## Layer 2: ideal lattices and the trace-to-Euclidean bridge

⚠ This roadmap owns the arithmetic bridge below, and states no milestone over a structure another
roadmap supplies. The integral lattices roadmap consumes `ZLattice.dual`, `ZLattice.dual_dual`,
`ZLattice.covolume_mul_covolume_dual`, and `ZLattice.gaussianTheta_one_div`, which are Layer 2
items 1, 2, 3, and 8 here. Nothing travels in the other direction. -/

open scoped Classical in
/-- **Layer 2.11, the Euclidean inner product on the mixed space**, written out: the standard
product on the real coordinates and `Re (z · conj w)` on the complex ones. It is stated
explicitly rather than read off a `WithLp` wrapper, because which pairing is meant is the whole
point of 2.11. -/
noncomputable def mixedInner (x y : mixedEmbedding.mixedSpace K) : ℝ :=
  ∑ w : {w : InfinitePlace K // w.IsReal}, x.1 w * y.1 w +
    ∑ w : {w : InfinitePlace K // w.IsComplex}, (x.2 w * starRingEnd ℂ (y.2 w)).re

/-- **Layer 2.11, the trace-to-Euclidean map**, a named real-linear map and not an existential.

⚠ The analytic dual of `mixedEmbedding K '' I` is **not** `mixedEmbedding K '' (I𝔡)⁻¹`. The trace
pairing and the Euclidean inner product on the mixed space differ at the complex places, by a
factor of `2` and a conjugation. The counterexample is `K = ℚ(i)` with `I = 𝓞_K`: the mixed
lattice is `ℤ[i] ⊂ ℂ`, which is Euclidean self-dual, while the different is `(2i)`, so the trace
dual is `(1/2)ℤ[i]`. The map below carries `(1/2)ℤ[i]` back to `ℤ[i]`. -/
noncomputable def traceToEuclidean :
    mixedEmbedding.mixedSpace K →ₗ[ℝ] mixedEmbedding.mixedSpace K where
  toFun x := (x.1, fun w ↦ 2 * starRingEnd ℂ (x.2 w))
  map_add' := sorry
  map_smul' := sorry

/-- **Layer 2.11, the pairing identity**, which is the whole content of the map. -/
theorem mixedInner_traceToEuclidean (x y : K) :
    mixedInner K (mixedEmbedding K x) (traceToEuclidean K (mixedEmbedding K y)) =
      (Algebra.trace ℚ K (x * y) : ℚ) := sorry

/-- **Layer 2.11, the determinant of the trace-to-Euclidean map.**

⚠ It is `(−4)^{r₂}`, of absolute value `4^{r₂} = 2^{2r₂}`, and **not** `2^{r₂}`. On one complex
coordinate `z ↦ 2 · conj z` is `(a, b) ↦ (2a, −2b)` over `ℝ`, whose determinant is `−4`. The
covolume identity of 2.3 is the check: with `covolume (σ I) = 2^{-r₂} √|d_K| 𝔑I` and
`𝔑𝔡 = |d_K|`, the product `covolume (σ I) · covolume (dual (σ I))` comes out as
`|det| · 2^{-2r₂}`, so `|det| = 4^{r₂}`. At `K = ℚ(i)` this is the statement that `(1/2)ℤ[i]`,
of covolume `1/4`, is carried to `ℤ[i]`, of covolume `1`. -/
theorem det_traceToEuclidean :
    LinearMap.det (traceToEuclidean K) = (-4 : ℝ) ^ nrComplexPlaces K := sorry

/-- **Layer 2.11, the corrected dual of an ideal lattice**: the analytic dual of the mixed
embedding of `I` is the image under `traceToEuclidean` of the mixed embedding of the **trace**
dual of `I`. This is the one place in the roadmap where the different appears, through
`FractionalIdeal.dual`. -/
theorem analyticDual_mixedEmbedding (I : FractionalIdeal (𝓞 K)⁰ K) (hI : I ≠ 0) :
    {y : mixedEmbedding.mixedSpace K | ∀ x ∈ mixedEmbedding K '' (I : Set K),
        ∃ n : ℤ, mixedInner K x y = (n : ℝ)} =
      traceToEuclidean K '' (mixedEmbedding K '' (FractionalIdeal.dual ℤ ℚ I : Set K)) := sorry

open scoped Classical in
/-- **Layer 2.12, the covolume transported by `traceToEuclidean`.** This is where the powers of
`2` that 2.13 writes into the theta transformation, and that 3.1 threads, come from: the factor
is `|det| = 4^{r₂}` and not `2^{r₂}`. -/
theorem covolume_map_traceToEuclidean (Λ : Submodule ℤ (mixedEmbedding.mixedSpace K)) :
    ZLattice.covolume (Λ.map ((traceToEuclidean K).restrictScalars ℤ)) MeasureTheory.volume =
      4 ^ nrComplexPlaces K * ZLattice.covolume Λ MeasureTheory.volume := sorry

open scoped Classical in
/-- **Layer 2.12, the covolume of an ideal lattice**, as a named theorem and not an existential
naming a constant: `covolume (mixedEmbedding K '' I) = 2^{-r₂} √|d_K| 𝔑 I`. Layer 3.1 threads
this constant, and 2.13 threads it again through `det_traceToEuclidean`. -/
theorem covolume_mixedEmbedding_ideal (I : Ideal (𝓞 K)) (hI : I ≠ ⊥) :
    ZLattice.covolume
        (Submodule.span ℤ (mixedEmbedding K '' (algebraMap (𝓞 K) K '' (I : Set (𝓞 K)))))
        MeasureTheory.volume =
      2 ^ (-(nrComplexPlaces K : ℝ)) * Real.sqrt |(discr K : ℝ)| * (Ideal.absNorm I : ℝ) :=
  sorry

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

/-- **Layer 3.7**: the pole at `1` is the only one, stated as **analyticity**. This is the
statement a consumer reads as `regular_away`, and it is what discharges the zeros roadmap's
canonical-representative hypothesis.

⚠ `0 ≤ meromorphicOrderAt (dedekindZetaC K) s` is **not** this statement and does not imply it.
`MeromorphicAt` and `meromorphicOrderAt` depend only on the punctured germ, so changing
`dedekindZetaC K` at one point off `{1}` leaves every order unchanged and destroys every
consequence about a value. Over the order inequality alone, the uniqueness milestone 3.5 is
false. -/
theorem analyticAt_dedekindZetaC {s : ℂ} (hs : s ≠ 1) :
    AnalyticAt ℂ (dedekindZetaC K) s := sorry

theorem analyticOnNhd_dedekindZetaC :
    AnalyticOnNhd ℂ (dedekindZetaC K) {(1 : ℂ)}ᶜ := sorry

/-- **Layer 3.7**: the order inequality, kept as a corollary of analyticity and never as the
downstream contract. -/
theorem meromorphicOrderAt_dedekindZetaC_nonneg {s : ℂ} (hs : s ≠ 1) :
    0 ≤ meromorphicOrderAt (dedekindZetaC K) s := sorry

/-- **Layer 3.7, the residue**, upgrading the pin's real-limit class number formula
(`tendsto_sub_one_mul_dedekindZeta_nhdsGT`) to a genuine complex residue. -/
theorem tendsto_sub_one_mul_dedekindZetaC :
    Tendsto (fun s : ℂ ↦ (s - 1) * dedekindZetaC K s) (𝓝[≠] 1)
      (𝓝 (dedekindZeta_residue K : ℂ)) := sorry

/-- **Layer 3.5, uniqueness of the continuation.** Without this the characterizations above and
below pin nothing: two continuations that agree on `Re s > 1` and are **analytic** off `{0, 1}`
agree off `{0, 1}`, by the identity theorem on that connected set.

⚠ The two analyticity hypotheses cannot be dropped, and meromorphy alone does not replace them.
Given a genuine continuation `Z`, change its value at a single point `p` outside the half-plane
and outside `{0, 1}`: the result is still meromorphic with the same order at every point and
still agrees with `Z` on `Re s > 1`, and it differs from `Z` at `p`. That countermodel is why
`HasMeromorphicContinuation` carries `regular_away`. -/
theorem eq_of_meromorphic_of_eqOn_halfPlane (Z W : ℂ → ℂ) (hZ : Meromorphic Z)
    (hW : Meromorphic W)
    (hZa : AnalyticOnNhd ℂ Z {0, 1}ᶜ) (hWa : AnalyticOnNhd ℂ W {0, 1}ᶜ)
    (h : ∀ s : ℂ, 1 < s.re → Z s = W s) :
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

/-- **Layer 3.6**: the two poles are the only ones — the `regular_away` statement for `Λ_K`,
stated as analyticity and not as an order inequality, for the reason recorded at
`analyticAt_dedekindZetaC`. This is the hypothesis the zeros roadmap discharges from here. -/
theorem analyticAt_completedDedekindZeta {s : ℂ} (h0 : s ≠ 0) (h1 : s ≠ 1) :
    AnalyticAt ℂ (completedDedekindZeta K) s := sorry

theorem analyticOnNhd_completedDedekindZeta :
    AnalyticOnNhd ℂ (completedDedekindZeta K) {0, 1}ᶜ := sorry

/-- **Layer 3.6**: the order inequality, a corollary and not the contract. -/
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
characters inducing the characters modulo `n`, and with **no correction factor**.

⚠ The characters on the right are Mathlib's `χ.primitiveCharacter`, of level `χ.conductor`, and
`DirichletCharacter.changeLevel_primitiveCharacter` is the statement that each induces `χ`. An
existential `∃ χ' : ∀ χ, DirichletCharacter ℂ (m χ), …` that does not say the `χ'` are primitive
and do induce the `χ` is satisfied by unrelated characters, so it is not this theorem. The
correction factor appears only in the imprimitive form below, and it is **inverted** there. -/
theorem dedekindZetaC_cyclotomic (n : ℕ) [NeZero n] (F : Type*) [Field F] [NumberField F]
    [IsCyclotomicExtension {n} ℚ F]
    (m : DirichletCharacter ℂ n → ℕ) (hm : ∀ χ, NeZero (m χ)) (hdvd : ∀ χ, m χ ∣ n)
    (χ' : ∀ χ : DirichletCharacter ℂ n, DirichletCharacter ℂ (m χ))
    (hprim : ∀ χ, (χ' χ).IsPrimitive)
    (hind : ∀ χ, DirichletCharacter.changeLevel (hdvd χ) (χ' χ) = χ) (s : ℂ) :
    dedekindZetaC F s =
      ∏ χ : DirichletCharacter ℂ n,
        haveI := hm χ; DirichletCharacter.LFunction (χ' χ) s := sorry

/-- **Layer 4.4, the imprimitive form**, kept because the two are mixed up constantly:
`L(χ, s) = L(χ*, s) ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p)p^{-s})`, so writing the product over the
level-`n` functions puts the extra Euler factors on the **denominator** side. Use one form or the
other, never a mixture. -/
theorem dedekindZetaC_cyclotomic_imprimitive (n : ℕ) [NeZero n] (F : Type*) [Field F]
    [NumberField F] [IsCyclotomicExtension {n} ℚ F]
    (m : DirichletCharacter ℂ n → ℕ) (hdvd : ∀ χ, m χ ∣ n)
    (χ' : ∀ χ : DirichletCharacter ℂ n, DirichletCharacter ℂ (m χ))
    (hprim : ∀ χ, (χ' χ).IsPrimitive)
    (hind : ∀ χ, DirichletCharacter.changeLevel (hdvd χ) (χ' χ) = χ) (s : ℂ) :
    dedekindZetaC F s * ∏ χ : DirichletCharacter ℂ n, ∏ p ∈ n.primeFactors,
        (if p ∣ m χ then (1 : ℂ) else 1 - χ' χ (p : ZMod (m χ)) * (p : ℂ) ^ (-s)) =
      ∏ χ : DirichletCharacter ℂ n, DirichletCharacter.LFunction χ s := sorry

/-- **Layer 4.4, the mandatory test at `n = 4`.** The two characters modulo `4` are the trivial
one, whose primitive form has conductor `1` and L-function `riemannZeta`, and `χ₋₄`, which is
already primitive. So the primitive product is `ζ(s) L(s, χ₋₄)`, which is milestone 4.2, and a
correction factor with the wrong sign of the exponent would give
`ζ_{ℚ(i)}(s) = ζ(s) L(s, χ₋₄)(1 − 2^{-s})` and contradict it. -/
theorem dedekindZetaC_cyclotomic_four (F : Type*) [Field F] [NumberField F]
    [IsCyclotomicExtension {4} ℚ F] (s : ℂ) :
    dedekindZetaC F s = riemannZeta s * DirichletCharacter.LFunction χ₄C s := sorry

/-! ## Layers 5 and 6: ray-class characters and Grossencharacters, constructed

⚠ Neither object is an interface parameter. Layer 5.1 is a character of the explicit quotient
built in Layer 1.7, and Layer 6.1 is built from a unitary ideal weight, a real shift, and an
infinity type. Nothing below quantifies over a structure whose fields unrelated terms satisfy. -/

section HeckeCharacters

variable {K}

/-- **Layer 5.1, a ray-class character**: a character of the explicit quotient `J^{𝔪₀}/P^𝔪` of
Layer 1.7, and nothing else.

Every operation 5.2 to 5.9 uses is then Mathlib's own operation on `→*`, and needs no field: the
trivial character is `1`, the product is `χ * ψ`, the conjugate is `χ⁻¹` (equal to the pointwise
complex conjugate because the group is finite), and induction from a divisor of the modulus is
precomposition with `Modulus.classMap`. That is the reason to carry the quotient rather than a
bare assignment of roots of unity to primes: on the free group of ideals prime to `𝔪₀` those
operations exist too, but they do not preserve the triviality that Gauss sums and the functional
equation need. -/
abbrev RayClassCharacter (𝔪 : Modulus K) : Type _ := 𝔪.RayClassGroup →* ℂˣ

namespace RayClassCharacter

/-- **Layer 5.1, primitivity**, against the canonical projection of 1.7. ⚠ Stated this way, and
not as "there is no function `ψ` agreeing with `χ` away from a divisor": a bare function `ψ` is
not required to be a character, so the negation of its existence is a much weaker condition than
primitivity, and 5.6 and 5.8 are false under it. -/
def IsPrimitive {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) : Prop :=
  ∀ (𝔫 : Modulus K) (h : 𝔫.Dvd 𝔪), 𝔫 ≠ 𝔪 →
    ¬ ∃ ψ : RayClassCharacter 𝔫, ψ.comp (Modulus.classMap h) = χ

/-- **Layer 5.4, induction from a divisor of the modulus**, which is composition with the
projection and therefore automatically a character. -/
noncomputable def induced {𝔫 𝔪 : Modulus K} (h : 𝔫.Dvd 𝔪) (ψ : RayClassCharacter 𝔫) :
    RayClassCharacter 𝔪 :=
  ψ.comp (Modulus.classMap h)

open scoped Classical in
/-- **Layer 5.1, the ideal weight of a ray-class character**, *derived* from the character and
not a field. The value at an ideal prime to `𝔪₀` is the character of its ray class; at a prime
dividing `𝔪₀` it is `0`, which is the convention of 1.2. -/
noncomputable def weight {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) : IdealWeight K where
  toFun I := if h : 𝔪.IsCoprimeTo I then (χ (𝔪.idealClass I) : ℂ) else 0
  bad := {𝔭 : HeightOneSpectrum (𝓞 K) | 𝔭.asIdeal ∣ 𝔪.finitePart}
  bad_finite := sorry
  map_mul := sorry
  norm_eq_one := sorry
  eq_zero_bad := sorry

theorem weight_apply {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) {I : Ideal (𝓞 K)}
    (hI : 𝔪.IsCoprimeTo I) : χ.weight.toFun I = (χ (𝔪.idealClass I) : ℂ) := sorry

/-- **Layer 5.1, triviality on the ray subgroup**, now a *theorem* about the derived weight.
⚠ In the interface version this was a field on an arbitrary ideal weight, quantified over
integral `α` only. That condition does not make the weight factor through the ray class group,
because the ideals prime to `𝔪₀` form a free group and a weight may be prescribed arbitrarily on
its generators; here it is a consequence of `Modulus.idealClass_eq_one_iff`. -/
theorem weight_eq_one_of_ray {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) (α : 𝓞 K) (hα : α ≠ 0)
    (h₀ : α - 1 ∈ 𝔪.finitePart)
    (hinf : ∀ v ∈ 𝔪.infinitePart, 0 < (v.embedding (algebraMap (𝓞 K) K α)).re) :
    χ.weight.toFun (Ideal.span {α}) = 1 := sorry

/-- **Layer 5.1, finite order**, a theorem from the finiteness of the ray class group. -/
theorem weight_isOfFinOrder {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) :
    ∃ m : ℕ, 0 < m ∧ ∀ I : Ideal (𝓞 K), 𝔪.IsCoprimeTo I → χ.weight.toFun I ^ m = 1 := sorry

/-- **Layer 5.1, the conjugate character**, which is the inverse, because the values are roots of
unity. This is what the functional equation of 5.8 names on its right-hand side. -/
theorem weight_inv {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) (I : Ideal (𝓞 K)) :
    χ⁻¹.weight.toFun I = starRingEnd ℂ (χ.weight.toFun I) := sorry

theorem weight_mul {𝔪 : Modulus K} (χ ψ : RayClassCharacter 𝔪) (I : Ideal (𝓞 K)) :
    (χ * ψ).weight.toFun I = χ.weight.toFun I * ψ.weight.toFun I := sorry

theorem weight_one {𝔪 : Modulus K} (I : Ideal (𝓞 K)) (hI : 𝔪.IsCoprimeTo I) :
    (1 : RayClassCharacter 𝔪).weight.toFun I = 1 := sorry

/-- **Layer 5.4, the imprimitive correction**, a finite product of Euler factors. -/
theorem weight_induced {𝔫 𝔪 : Modulus K} (h : 𝔫.Dvd 𝔪) (ψ : RayClassCharacter 𝔫)
    {I : Ideal (𝓞 K)} (hI : 𝔪.IsCoprimeTo I) :
    (induced h ψ).weight.toFun I = ψ.weight.toFun I := sorry

/-- **Layer 5.5, the local sign at a real place.** ⚠ A finite-order character is *always* trivial
on the positive elements at `v`, because `ℝ_{>0}` is connected and divisible. Parity is therefore
detected at `−1` and nowhere else, and the docstring "nontrivial on the positive elements" names
a condition no character satisfies. -/
noncomputable def localSign {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) (v : InfinitePlace K) : ℂ :=
  sorry

theorem localSign_sq {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) {v : InfinitePlace K}
    (hv : v.IsReal) : χ.localSign v ^ 2 = 1 := sorry

/-- **Layer 5.5**: the infinite part of the modulus is exactly where the local sign is `−1`, for a
primitive character. This is the theorem the gamma factor reads. -/
theorem localSign_eq_neg_one_iff {𝔪 : Modulus K} {χ : RayClassCharacter 𝔪} (hχ : χ.IsPrimitive)
    {v : InfinitePlace K} (hv : v.IsReal) :
    χ.localSign v = -1 ↔ v ∈ 𝔪.infinitePart := sorry

end RayClassCharacter

/-! ### Layers 5.3, 5.7 and 5.8: the Hecke L-function, by name

⚠ Named rather than existential, because the zeros roadmap builds its Hecke instance on these
objects and cannot cite an anonymous `example`. -/

/-- **Layer 5.3, the continued Hecke L-function.** -/
noncomputable def heckeLFunctionC {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) : ℂ → ℂ := sorry

theorem heckeLFunctionC_eq {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) {s : ℂ} (hs : 1 < s.re) :
    heckeLFunctionC χ s = LSeries (idealCoeffOfWeight K χ.weight.toFun) s := sorry

/-- **Layer 5.7, the completed Hecke L-function**, conductor power and gamma factor included, as
an instance of the level frame of 2.14 at level `|d_K| 𝔑𝔪₀`. -/
noncomputable def completedHeckeLFunction {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) : ℂ → ℂ :=
  sorry

/-- **Layer 5.7**: the completed function is the level completion of 2.14 and not a second
object, which is what makes `FEPairWithLevel.differentiable_Λ`, `Λ_residue_k` and
`Λ_residue_zero` available here. -/
theorem completedHeckeLFunction_eq_ΛLevel {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) :
    ∃ P : FEPairWithLevel ℂ,
      P.level = |(discr K : ℝ)| * Ideal.absNorm 𝔪.finitePart ∧
        completedHeckeLFunction χ = P.Λ := sorry

/-- **Layer 5.7, entirety.** ⚠ For a **nontrivial** primitive character only: the trivial
character's completed function has poles at `0` and `1`, and the statement without that
hypothesis is false there. -/
theorem differentiable_completedHeckeLFunction {𝔪 : Modulus K} {χ : RayClassCharacter 𝔪}
    (hχ : χ ≠ 1) (hprim : χ.IsPrimitive) :
    Differentiable ℂ (completedHeckeLFunction χ) := sorry

/-- **Layer 5.8, the root number.** -/
noncomputable def heckeRootNumber {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) : ℂ := sorry

/-- **Layer 5.8, the root number has modulus one**, which is what the Gauss-sum evaluation
`|τ(χ)| = √𝔑𝔣₀` of 5.6 is for, and what every growth estimate downstream needs. -/
theorem norm_heckeRootNumber {𝔪 : Modulus K} {χ : RayClassCharacter 𝔪} (hχ : χ.IsPrimitive) :
    ‖heckeRootNumber χ‖ = 1 := sorry

/-- **Layer 5.8, the functional equation**, against the **canonical** conjugate `χ⁻¹` of the same
modulus.

⚠ A version taking a second character `χ'` and assuming only that its ideal weights are the
conjugates of `χ`'s says nothing about the conductor, the infinite parity, the gamma factor, or
the completion of `χ'`, so it does not identify the right-hand side. Naming `χ⁻¹` does, because
`RayClassCharacter.weight_inv` and `IsPrimitive` transport along it. -/
theorem completedHeckeLFunction_one_sub {𝔪 : Modulus K} {χ : RayClassCharacter 𝔪}
    (hχ : χ.IsPrimitive) (s : ℂ) :
    completedHeckeLFunction χ s = heckeRootNumber χ * completedHeckeLFunction χ⁻¹ (1 - s) :=
  sorry

/-- **Layer 5.7, the Mellin representation**, which is what a consumer turns into a
vertical-strip bound and hence into finite order. -/
theorem exists_mellin_completedHeckeLFunction {𝔪 : Modulus K} (χ : RayClassCharacter 𝔪) :
    ∃ θ : ℝ → ℂ, ∀ s : ℂ, 1 < s.re →
      completedHeckeLFunction χ s =
        ∫ t in Set.Ioi (0 : ℝ), θ t * (t : ℂ) ^ s / (t : ℂ) := sorry

/-- **Layer 5.9, the two degrees, exactly.** The card of Layer 0 carries the **absolute** degree,
computed from the gamma data: `r₁` real shifts and `r₂` complex ones give `r₁ + 2r₂ = [K:ℚ]`. -/
theorem degree_of_heckeCard (d : AnalyticLFunctionData)
    (hR : d.gammaR.card = nrRealPlaces K) (hC : d.gammaC.card = nrComplexPlaces K) :
    d.degree = Module.finrank ℚ K := sorry

/-- **Layer 5.9, the relative degree**, the separate invariant that the phrase "a Hecke character
has degree one" refers to. ⚠ It is never written into `AnalyticLFunctionData.degree`; a record
with two values of one field is not a record. -/
def relativeDegree {𝔪 : Modulus K} (_ : RayClassCharacter 𝔪) : ℕ := 1

/-! ### Layer 6: Grossencharacters -/

open scoped Classical in
/-- **Layer 6.1, the archimedean local character determined by an infinity type**, written out
before the structure so that the structure's compatibility fields can name it.

At a real place with `p ∈ {0, 1}` it is `x ↦ sgn(x)^p |x|^{i q}`. At a complex place it is
`z ↦ z^{-p} z̄^{-p̄} |z|^{i q}`. ⚠ A complex place needs the **pair** `(p, p̄)`: one integer is not
enough, and the gamma shift of 6.2 is built from both. -/
noncomputable def archLocalChar (t : InfinitePlace K → ℤ × ℤ) (q : InfinitePlace K → ℝ)
    (v : InfinitePlace K) (x : K) : ℂ :=
  (if v.IsReal then
      (if (v.embedding x).re < 0 then (-1 : ℂ) ^ (t v).1 else 1)
    else (v.embedding x) ^ (-(t v).1) * (starRingEnd ℂ (v.embedding x)) ^ (-(t v).2)) *
    ((v x : ℝ) : ℂ) ^ (Complex.I * (q v : ℂ))

/-- **Layer 6.1, a Grossencharacter**, built rather than assumed.

⚠ The **unitary** part is the `IdealWeight`, and the full weight is `toFun` below. Storing the
full weight as an `IdealWeight` and also asserting `χ = χ_unit · 𝔑^{shift}` with a unitary
`χ_unit` is inconsistent for every `shift ≠ 0`: `IdealWeight.norm_eq_one` forces `‖χ 𝔭‖ = 1` at
every prime off the finite bad set, and the decomposition then forces `𝔑𝔭^{shift} = 1` there, so
`shift = 0`. Such a structure cannot model the characters this layer exists for.

⚠ The exponent `shift` must be **real**. With a complex exponent the decomposition is ambiguous
up to `‖·‖^{it}`, and the uniqueness theorem below is false. -/
structure Grossencharacter (𝔪 : Modulus K) where
  /-- The **unitary** component, which is the ideal weight. -/
  unitary : IdealWeight K
  unitary_bad : unitary.bad = {𝔭 : HeightOneSpectrum (𝓞 K) | 𝔭.asIdeal ∣ 𝔪.finitePart}
  /-- The real exponent of the unitary decomposition. -/
  shift : ℝ
  /-- The infinity type: a pair of integers at every place, with the second one `0` at a real
  place and the first one in `{0, 1}` there. -/
  infinityType : InfinitePlace K → ℤ × ℤ
  infinityType_isReal : ∀ v, v.IsReal → (infinityType v).1 ∈ ({0, 1} : Set ℤ) ∧
    (infinityType v).2 = 0
  /-- The archimedean parameters `q_v`. -/
  archimedeanParam : InfinitePlace K → ℝ
  /-- ⚠ **Admissibility**: the archimedean part is trivial on the units. Without it the
  archimedean data and the ideal weight need not come from one character, and 6.2 to 6.4 are
  false for such a term. -/
  admissible : ∀ u : (𝓞 K)ˣ,
    ∏ᶠ v : InfinitePlace K,
      archLocalChar infinityType archimedeanParam v (algebraMap (𝓞 K) K (u : 𝓞 K)) = 1
  /-- Compatibility of the ideal weight with the archimedean components on principal ideals prime
  to `𝔪₀`: `χ((α)) = ∏_v χ_v(α)⁻¹`. -/
  compat : ∀ α : 𝓞 K, α ≠ 0 → 𝔪.IsCoprimeTo (Ideal.span {α}) →
    unitary.toFun (Ideal.span {α}) *
        ((Ideal.absNorm (Ideal.span {α}) : ℝ) ^ shift : ℝ) *
        ∏ᶠ v : InfinitePlace K,
          archLocalChar infinityType archimedeanParam v (algebraMap (𝓞 K) K α) = 1

namespace Grossencharacter

variable {𝔪 : Modulus K}

/-- **Layer 6.1, the full quasicharacter** `χ = χ_unit · 𝔑^{shift}`, *defined* from the two
fields. It is a plain function on ideals and not an `IdealWeight`, for the reason in the
structure's docstring. -/
noncomputable def toFun (χ : Grossencharacter 𝔪) (I : Ideal (𝓞 K)) : ℂ :=
  χ.unitary.toFun I * ((Ideal.absNorm I : ℝ) ^ χ.shift : ℝ)

theorem toFun_mul (χ : Grossencharacter 𝔪) (I J : Ideal (𝓞 K)) :
    χ.toFun (I * J) = χ.toFun I * χ.toFun J := sorry

/-- **Layer 6.1**: the absolute value of the full weight at a good prime is `𝔑𝔭^{shift}`, which
is the statement that fails for a structure whose full weight is an `IdealWeight`. -/
theorem norm_toFun (χ : Grossencharacter 𝔪) {𝔭 : HeightOneSpectrum (𝓞 K)}
    (h𝔭 : 𝔭 ∉ χ.unitary.bad) :
    ‖χ.toFun 𝔭.asIdeal‖ = (Ideal.absNorm 𝔭.asIdeal : ℝ) ^ χ.shift := sorry

/-- **Layer 6.1, uniqueness of the unitary decomposition**, a theorem and not a field. It is
where `shift : ℝ` is used: over a complex exponent the conclusion is false. -/
theorem shift_unique {χ ψ : Grossencharacter 𝔪} (h : χ.toFun = ψ.toFun) :
    χ.shift = ψ.shift ∧ χ.unitary.toFun = ψ.unitary.toFun := sorry

/-- **Layer 6.1, the archimedean local character**, as a genuine multiplicative character into
`ℂˣ`, built from the infinity type and the archimedean parameter.

⚠ It is a **construction** and not a field. A field of type `InfinitePlace K → K → ℂ` is an
arbitrary function: it need not be multiplicative, need not avoid `0`, and need not have the
formula the gamma factor of 6.2 is computed from, so every later milestone is false for some
term of such a structure. -/
noncomputable def localChar (χ : Grossencharacter 𝔪) (v : InfinitePlace K) : Kˣ →* ℂˣ where
  toFun x := Units.mk0
    (archLocalChar χ.infinityType χ.archimedeanParam v (x : K)) sorry
  map_one' := sorry
  map_mul' _ _ := sorry

theorem localChar_apply (χ : Grossencharacter 𝔪) (v : InfinitePlace K) (x : Kˣ) :
    ((χ.localChar v x : ℂˣ) : ℂ) =
      archLocalChar χ.infinityType χ.archimedeanParam v (x : K) := rfl

/-- **Layer 6.1, continuity of the archimedean formula.** ⚠ Continuity on `Kˣ` is vacuous, since
`K` is discrete, so the content is that the *formula* is continuous on the local field. State it
there: at a complex place `z ↦ z^{-p} z̄^{-p̄} |z|^{i q}` is continuous away from `0`, and its
restriction to the unit circle is a character of that circle. That is what makes the object an
archimedean local character rather than an arbitrary assignment of complex numbers. -/
theorem continuousOn_archLocalCharFormula (p pbar : ℤ) (q : ℝ) :
    ContinuousOn (fun z : ℂ ↦ z ^ (-p) * (starRingEnd ℂ z) ^ (-pbar) *
        ((‖z‖ : ℝ) : ℂ) ^ (Complex.I * (q : ℂ)))
      {z : ℂ | z ≠ 0} := sorry

/-- **Layer 6.2, the gamma shift from the infinity type.** At a real place the shift is
`p_v − i q_v`; at a complex place the single `Gammaℂ` factor has shift `max(p_v, p̄_v) − i q_v`,
and the difference `|p_v − p̄_v|` enters the root number. These are the first entries of the
spectral multisets of 0.1 that are not real. -/
noncomputable def gammaShiftReal (χ : Grossencharacter 𝔪) (v : InfinitePlace K) : ℂ :=
  ((χ.infinityType v).1 : ℂ) - Complex.I * (χ.archimedeanParam v : ℂ)

noncomputable def gammaShiftComplex (χ : Grossencharacter 𝔪) (v : InfinitePlace K) : ℂ :=
  ((max (χ.infinityType v).1 (χ.infinityType v).2 : ℤ) : ℂ) -
    Complex.I * (χ.archimedeanParam v : ℂ)

/-- **Layer 6.1, the `A₀` condition**, as a predicate and not a `Prop`-valued field with a
default value. -/
def IsAlgebraic (χ : Grossencharacter 𝔪) : Prop := ∀ v, χ.archimedeanParam v = 0

/-- **Layer 6.4, the continued L-function of a Grossencharacter**, *defined* from the unitary one
by the shift. Since `χ(𝔞) = χ_unit(𝔞) · 𝔑𝔞^{shift}`, the two Dirichlet series satisfy
`L(χ, s) = L(χ_unit, s − shift)`, so nothing new has to be continued. -/
noncomputable def lFunctionC (χ : Grossencharacter 𝔪) (s : ℂ) : ℂ :=
  continuedLFunctionOfWeight K χ.unitary (s - (χ.shift : ℂ))

/-- **Layer 6.4, the shift translation**, which is what makes the definition above the right
object: on its half-plane of convergence it *is* the Dirichlet series of the full
quasicharacter. -/
theorem lFunctionC_eq (χ : Grossencharacter 𝔪) {s : ℂ} (hs : 1 + χ.shift < s.re) :
    χ.lFunctionC s = LSeries (idealCoeffOfWeight K χ.toFun) s := sorry

/-- **Layer 6.4, continuation and the functional equation.** ⚠ The exceptional case is part of
the statement: `Λ(χ, ·)` is entire **unless** `𝔪₀ = 1`, every `p_v = 0`, and `χ` is a power of
the norm character, and there the poles are exactly at `s = Tr(−p + iq)/n` and
`s = 1 + Tr(p + iq)/n`. -/
noncomputable def completedGrossencharacterLFunction (χ : Grossencharacter 𝔪) : ℂ → ℂ := sorry

theorem differentiable_completedGrossencharacterLFunction (χ : Grossencharacter 𝔪)
    (hexc : ¬ (𝔪.finitePart = 1 ∧ (∀ v, χ.infinityType v = (0, 0)) ∧
      ∃ σ : ℝ, ∀ I, χ.toFun I = ((Ideal.absNorm I : ℝ) ^ σ : ℝ))) :
    Differentiable ℂ (completedGrossencharacterLFunction χ) := sorry

end Grossencharacter

end HeckeCharacters

/-! ## Layer 7: Landau's theorem and nonvanishing -/

open scoped ComplexOrder in
/-- **Layer 7.1, Landau's theorem** (absent at the pin; behind both the real-character
nonvanishing and the density dichotomies): a Dirichlet series with nonnegative coefficients
has a genuine singularity at its abscissa of absolute convergence — no function holomorphic
on a neighborhood of the abscissa agrees with it on the half-plane of convergence. -/
theorem landau_singularity_at_abscissa {a : ℕ → ℂ} (ha₀ : 0 ≤ a) {x₀ : ℝ}
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

/-! ### Layers 7.3 and 7.4 at the generality they are proved: over a cancelling family

⚠ These are the theorems the roadmap actually needs, and neither is a statement about a single
ideal weight. The two special cases above, for `riemannZeta` and for a Dirichlet character, are
the instances Mathlib already has; the general ones are what 7.5, 8B.5, 8C, 8E, and 9.7
consume. -/

/-- **Layer 7.3, `L(χ, 1) ≠ 0` for a nontrivial member of a cancelling family.** The continued
function is the one 7.1 produces from `HasCancellation`, so the statement is about a value and
not about a junk value: for `g ≠ 1` the member is analytic at `s = 1`. -/
theorem continuedLFunctionOfWeight_ne_zero_one {G : Type*} [CommGroup G] [Fintype G]
    {w : G → IdealWeight K} (hw : CancellingFamily K G w) {g : G} (hg : g ≠ 1) :
    continuedLFunctionOfWeight K (w g) 1 ≠ 0 := sorry

/-- **Layer 7.4, nonvanishing on the whole line `Re s = 1`, for a cancelling family.**

⚠ Stated in meromorphic order, and for every real `t` including `t = 0`, because a nontrivial
member has no pole there. The corresponding statement for an arbitrary member is false at `g = 1`
and `t = 0`, where the trivial weight has a pole. -/
theorem meromorphicOrderAt_continuedLFunctionOfWeight {G : Type*} [CommGroup G] [Fintype G]
    {w : G → IdealWeight K} (hw : CancellingFamily K G w) {g : G} (hg : g ≠ 1) (t : ℝ) :
    meromorphicOrderAt (continuedLFunctionOfWeight K (w g)) (1 + t * I) = (0 : WithTop ℤ) :=
  sorry

/-- **Layer 7.3 over the single-character package**: `L(χ, 1) ≠ 0` for a unitary character with
cancellation, with no finiteness anywhere. -/
theorem continuedLFunctionOfWeight_ne_zero_one_of_unitary {χ : IdealWeight K}
    (h : UnitaryCancelling K χ) : continuedLFunctionOfWeight K χ 1 ≠ 0 := sorry

/-- **Layer 7.4 over the single-character package**: nonvanishing on the whole line `Re s = 1`. -/
theorem meromorphicOrderAt_continuedLFunctionOfWeight_of_unitary {χ : IdealWeight K}
    (h : UnitaryCancelling K χ) (t : ℝ) :
    meromorphicOrderAt (continuedLFunctionOfWeight K χ) (1 + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.7, the nonvanishing export for Grossencharacters.**

⚠ The boundary is `Re s = 1 + shift`, and not `Re s = 1`. From `L(χ, s) = L(χ_unit, s − shift)`
the edge of the critical strip for the full quasicharacter sits at `1 + shift`, so a statement at
`1 + iu` is correct only in the unitary case. Milestone 7.8 uses the unitary case, where it is. -/
theorem Grossencharacter.meromorphicOrderAt_lFunctionC (𝔪 : Modulus K) (χ : Grossencharacter 𝔪)
    (h : UnitaryCancelling K χ.unitary) (t : ℝ) :
    meromorphicOrderAt χ.lFunctionC ((1 : ℂ) + (χ.shift : ℂ) + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.7, the unitary case**, where the boundary is the familiar `Re s = 1`. -/
theorem Grossencharacter.meromorphicOrderAt_lFunctionC_of_shift_zero (𝔪 : Modulus K)
    (χ : Grossencharacter 𝔪) (h : UnitaryCancelling K χ.unitary) (hs : χ.shift = 0) (t : ℝ) :
    meromorphicOrderAt χ.lFunctionC (1 + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.8, Hecke's equidistribution of Gaussian primes.** The arguments of the primes of
`ℤ[i]` are equidistributed in `[0, π/2)`. It is the only equidistribution statement in the
roadmap, and it is here because it is the test that 6.1 to 6.4 and 7.7 can actually be used: the
characters `𝔞 ↦ (α/|α|)^{4k}` are unitary of infinite order, so a finite-family package cannot
supply their nonvanishing. -/
theorem equidistribution_gaussianPrimes (F : Type*) [Field F] [NumberField F]
    [IsCyclotomicExtension {4} ℚ F] (v : InfinitePlace F) (hv : v.IsComplex)
    (a b : ℝ) (ha : 0 ≤ a) (hab : a ≤ b) (hb : b ≤ Real.pi / 2) :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 F) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x ∧
            ∃ α : 𝓞 F, 𝔭.asIdeal = Ideal.span {α} ∧
              (v.embedding (algebraMap (𝓞 F) F α)).arg ∈ Set.Icc a b} : ℝ) /
          (Nat.card {𝔭 : HeightOneSpectrum (𝓞 F) //
            (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ))
      atTop (𝓝 ((b - a) / (Real.pi / 2))) := sorry

/-- **Layer 7.5, the ray-class family is a cancelling family.** This is the first of the two
instantiations of 7.2, and it is what makes 7.3 and 7.4 available for Layer 5's characters and
for 8E. Cancellation for a nontrivial member comes from the partial-zeta decomposition of 1.7
and the counting estimate of 1.6 with its error term. -/
theorem cancellingFamily_rayClass (𝔪 : Modulus K) [Fintype (RayClassCharacter 𝔪)] :
    CancellingFamily K (RayClassCharacter 𝔪) (fun χ ↦ χ.weight) := sorry

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
theorem hasDirichletDensity_of_squeeze {ι : Type*} [Fintype ι]
    (S : ι → Set (HeightOneSpectrum (𝓞 K))) (c : ι → ℝ)
    (hdisj : Pairwise (Function.onFun Disjoint S))
    (hunion : HasDirichletDensity K (⋃ i, S i) 1)
    (hlow : ∀ i, LowerDirichletDensityAtLeast K (S i) (c i))
    (hsum : ∑ i, c i = 1) :
    ∀ i, HasDirichletDensity K (S i) (c i) := sorry

/-- **Layer 8A.2, the denominator theorem.** This is what reconciles the definition above
with Neukirch's, and it is proved once; after it, no statement mentions `log((s−1)⁻¹)`. -/
theorem tendsto_primeIdealZetaSum_div_log :
    Tendsto (fun s : ℝ ↦
        primeIdealZetaSum K (Set.univ : Set (HeightOneSpectrum (𝓞 K))) s /
          Real.log ((s - 1)⁻¹))
      (𝓝[>] 1) (𝓝 1) := sorry

/-- **Layer 8A.3, upper and lower agreeing gives the density.** -/
theorem hasDirichletDensity_of_upper_of_lower (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ)
    (hu : HasUpperDirichletDensity K S δ) (hl : HasLowerDirichletDensity K S δ) :
    HasDirichletDensity K S δ := sorry

/-- **Layer 8A.3, a finite symmetric difference does not change the density.** With it, the
finitely many ramified primes may be removed from any set for free — the lemma every
statement of Layer 8D quietly needs. -/
theorem hasDirichletDensity_of_symmDiff_finite (S T : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ)
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
theorem hasDirichletDensity_of_hasNaturalDensity (S : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ)
    (h : HasNaturalDensity K S δ) :
    HasDirichletDensity K S δ := sorry

section Chebotarev

variable (L : Type*) [Field L] [NumberField L] [Algebra K L]

/-- **Layer 8.0, unramifiedness**, as one shared predicate. Every statement of Layer 8 uses
this and never an ad hoc test against a discriminant. -/
def IsUnramifiedAt (𝔭 : HeightOneSpectrum (𝓞 K)) : Prop :=
  Ideal.ramificationIdxIn 𝔭.asIdeal (𝓞 L) = 1

variable [IsGalois K L]

/-! ### Layer 8.0: the Frobenius class, constructed

⚠ Nothing in Layer 8 quantifies over an interface. A theorem of the shape
`(F : FrobeniusInterface K L) → HasDirichletDensity …` is conditional on an arbitrary term of a
small structure, and it gives the crossing and fixed-field proofs no access to the laws they use,
because those laws are fields of a term the theorem does not construct. The class below is built
from Mathlib's `arithFrobAt`, and restriction and tower compatibility are theorems about it. -/

open scoped Classical in
/-- The prime of `L` at which the Frobenius class is computed. Every prime over `𝔭` gives the
same class, by `isConj_arithFrobAt`, so this choice is immaterial; `frobeniusClass_eq_mk` says so.
-/
noncomputable def chosenPrimeOver (𝔭 : HeightOneSpectrum (𝓞 K)) : Ideal (𝓞 L) :=
  if h : (Ideal.primesOver 𝔭.asIdeal (𝓞 L)).Nonempty then h.choose else ⊥

theorem chosenPrimeOver_mem (𝔭 : HeightOneSpectrum (𝓞 K)) :
    chosenPrimeOver K L 𝔭 ∈ Ideal.primesOver 𝔭.asIdeal (𝓞 L) := sorry

/-- **Layer 8.0, the Frobenius class of a prime**, constructed from Mathlib's `arithFrobAt` over
`Algebra.IsInvariant`, and not assumed. ⚠ Frobenius here is **arithmetic**: 8B.1 tests the
orientation and 8B.5 is the numerical example that would detect an inverse. -/
noncomputable def frobeniusClass (𝔭 : HeightOneSpectrum (𝓞 K)) : ConjClasses (L ≃ₐ[K] L) :=
  haveI : (chosenPrimeOver K L 𝔭).IsPrime := sorry
  haveI : Finite (𝓞 L ⧸ chosenPrimeOver K L 𝔭) := sorry
  ConjClasses.mk (arithFrobAt (𝓞 K) (L ≃ₐ[K] L) (chosenPrimeOver K L 𝔭))

/-- **Layer 8.0, well-definedness**: any prime of `L` over `𝔭` computes the same class. This is
`isConj_arithFrobAt`, and it is why the choice above is harmless. -/
theorem frobeniusClass_eq_mk (𝔭 : HeightOneSpectrum (𝓞 K)) (Q : Ideal (𝓞 L)) [Q.IsPrime]
    [Finite (𝓞 L ⧸ Q)] (hQ : Q.under (𝓞 K) = 𝔭.asIdeal) :
    frobeniusClass K L 𝔭 = ConjClasses.mk (arithFrobAt (𝓞 K) (L ≃ₐ[K] L) Q) := sorry

/-- **Layer 8.0, the characterization**: at an **unramified** prime, `σ` lies in the class exactly
when it is an arithmetic Frobenius at some prime of `L` over `𝔭`. This ties the construction to
the pin's vocabulary.

⚠ The unramifiedness hypothesis cannot be dropped. Two Frobenius lifts at the same `Q` differ by
an element of the inertia group, and Mathlib's uniqueness (`IsArithFrobAt.eq_of_isUnramifiedAt`)
assumes exactly that the prime is unramified. In a totally ramified abelian extension every
inertia element acts trivially on the residue field, so the right-hand side holds for several
distinct singleton conjugacy classes while `frobeniusClass` picks one of them; the equivalence is
then false. -/
theorem mem_frobeniusClass_iff (𝔭 : HeightOneSpectrum (𝓞 K)) (hur : IsUnramifiedAt K L 𝔭)
    (σ : L ≃ₐ[K] L) :
    σ ∈ (frobeniusClass K L 𝔭).carrier ↔
      ∃ Q : Ideal (𝓞 L), Q.IsPrime ∧ Q.under (𝓞 K) = 𝔭.asIdeal ∧
        ∀ x : 𝓞 L, σ • x - x ^ Nat.card (𝓞 K ⧸ 𝔭.asIdeal) ∈ Q := sorry

/-- **Layer 8.0, a Frobenius element of a prime.** ⚠ In an **abelian** extension the class is a
singleton and this is *the* Frobenius; in general it is a choice, and only the class is canonical.
Layer 8B.1's cyclotomic weight reads it, and 8B.1 proves the group abelian first. -/
noncomputable def frobeniusElt (𝔭 : HeightOneSpectrum (𝓞 K)) : L ≃ₐ[K] L := sorry

theorem frobeniusClass_eq_mk_frobeniusElt (𝔭 : HeightOneSpectrum (𝓞 K)) :
    frobeniusClass K L 𝔭 = ConjClasses.mk (frobeniusElt K L 𝔭) := sorry

/-- **Layer 8.0**: only finitely many primes ramify. -/
theorem finite_ramified : {𝔭 : HeightOneSpectrum (𝓞 K) | ¬ IsUnramifiedAt K L 𝔭}.Finite := sorry

/-- **Layer 8.0**: a prime that splits completely has the identity class, and conversely. -/
theorem frobeniusClass_eq_one_iff (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭) :
    frobeniusClass K L 𝔭 = 1 ↔ Ideal.inertiaDegIn 𝔭.asIdeal (𝓞 L) = 1 := sorry

/-- **Layer 8.0, restriction compatibility**, against Mathlib's canonical restriction
homomorphism `AlgEquiv.restrictNormalHom`, and as a **theorem** rather than a field or a separate
proposition that no theorem assumes. Milestones 8C.3 and 8D.2 use exactly this square. -/
theorem frobeniusClass_restrictNormalHom (E : IntermediateField K L) [Normal K E]
    [NumberField E] [IsGalois K E]
    (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭) :
    ConjClasses.map (AlgEquiv.restrictNormalHom (F := K) (K₁ := L) E) (frobeniusClass K L 𝔭) =
      frobeniusClass K E 𝔭 := sorry

/-- **Layer 8.0 and 8D.2, tower compatibility, relative to one prime of `L`.** For a prime `Q` of
`L` lying over `𝔓` of `E` over `𝔭` of `K`, and `σ` an arithmetic Frobenius **at that `Q`**, the
relative Frobenius at `Q/𝔓` is `σ ^ f(𝔓/𝔭)` when read in `Gal(L/K)`. The reason is one line of
residue arithmetic: `σ^f` acts as `x ↦ x^{𝔑𝔭^f}` and `𝔑_E 𝔓 = 𝔑_K 𝔭^f`.

⚠ The prime `Q` and the hypothesis `IsArithFrobAt … σ Q` are both load-bearing. A version that
takes an arbitrary representative `σ` of the class `frobeniusClass K L 𝔭` and a fixed `𝔓` is
false when `E/K` is not normal: a conjugate representative need not stabilize `Q`, so `σ^f` need
not fix `E` pointwise and is then not the restriction of any element of `Gal(L/E)`. The
class-level corollary below is derived from this theorem, never assumed in place of it.

⚠ *Nearby false statement:* the same equality **without** `hur`. Take `L/K` a nontrivial Galois
extension with `Q` totally ramified over `𝔭`, and `E = L`. Then `f(𝔓/𝔭) = 1`, and every
`σ ∈ Gal(L/K)` satisfies the arithmetic-Frobenius congruence at `Q`, because every inertia
element acts trivially on the residue field. Pick `σ ≠ 1`. The conclusion asks for
`τ ∈ Gal(L/L) = {1}` with `restrictScalars K τ = σ^1 = σ`, and `restrictScalars K 1 = 1 ≠ σ`. At a
ramified prime a Frobenius lift is determined only modulo inertia, so no equality of
automorphisms is available; if a ramified statement is wanted, state it in the quotient by
inertia, or as a coset. -/
theorem isArithFrobAt_pow_inertiaDeg (E : Type*) [Field E] [NumberField E] [Algebra K E]
    [Algebra E L] [IsScalarTower K E L] [IsGalois E L]
    (Q : HeightOneSpectrum (𝓞 L)) (𝔓 : HeightOneSpectrum (𝓞 E)) (𝔭 : HeightOneSpectrum (𝓞 K))
    (hQE : Q.asIdeal.under (𝓞 E) = 𝔓.asIdeal) (hQK : Q.asIdeal.under (𝓞 K) = 𝔭.asIdeal)
    (hur : IsUnramifiedAt K L 𝔭)
    (σ : L ≃ₐ[K] L) (hσ : IsArithFrobAt (𝓞 K) σ Q.asIdeal) :
    ∃ τ : L ≃ₐ[E] L, IsArithFrobAt (𝓞 E) τ Q.asIdeal ∧
      AlgEquiv.restrictScalars K τ = σ ^ Ideal.inertiaDeg 𝔭.asIdeal 𝔓.asIdeal := sorry

/-- **Layer 8D.2, the class-level corollary**, derived from the prime-relative theorem above and
not stated independently of it. The representative `σ` is still tied to `Q`. -/
theorem frobeniusClass_pow_inertiaDeg (E : Type*) [Field E] [NumberField E] [Algebra K E]
    [Algebra E L] [IsScalarTower K E L] [IsGalois E L]
    (Q : HeightOneSpectrum (𝓞 L)) (𝔓 : HeightOneSpectrum (𝓞 E)) (𝔭 : HeightOneSpectrum (𝓞 K))
    (hQE : Q.asIdeal.under (𝓞 E) = 𝔓.asIdeal) (hQK : Q.asIdeal.under (𝓞 K) = 𝔭.asIdeal)
    (hur : IsUnramifiedAt K L 𝔭) (σ : L ≃ₐ[K] L) (hσ : IsArithFrobAt (𝓞 K) σ Q.asIdeal) :
    ∃ τ : L ≃ₐ[E] L, τ ∈ (frobeniusClass E L 𝔓).carrier ∧
      AlgEquiv.restrictScalars K τ = σ ^ Ideal.inertiaDeg 𝔭.asIdeal 𝔓.asIdeal := sorry

/-- **Layer 8D.5, the Chebotarev density theorem over a general number field.**

The base is an arbitrary `K`, the prime set is cut out over `HeightOneSpectrum (𝓞 K)`,
unramifiedness is the shared predicate of 8.0, and the Frobenius class is the constructed one.
⚠ There is no interface parameter: this is a theorem about `K` and `L`, and about nothing
else. -/
theorem hasDirichletDensity_frobeniusClass (C : ConjClasses (L ≃ₐ[K] L)) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = C}
      ((Nat.card C.carrier : ℝ) / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

/-- **Layer 8D.6, splitting completely**, as a corollary of the theorem above: the primes that
split completely in `L` have Dirichlet density `1/#Gal(L/K)`. -/
theorem hasDirichletDensity_splitsCompletely :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = 1}
      (1 / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

/-! ### Layers 8C.1 to 8C.8: the crossing argument, with its constant written out -/

/-- **Layer 8C.1, the finite exceptional set of rational primes.** An auxiliary prime has to
avoid the primes ramified in `K/ℚ` and the primes below the primes ramified in `L/K`.

⚠ Naming it is part of the milestone. "For all but finitely many `q`" hides which finitely many,
and the two intersection conditions of 8C.1 and 8C.2 are exactly what avoiding this set buys. -/
def crossingExceptional (L : Type*) [Field L] [NumberField L] [Algebra K L] : Set ℕ :=
  {p : ℕ | p.Prime ∧ ((p : ℤ) ∣ discr K ∨
    ∃ 𝔭 : HeightOneSpectrum (𝓞 K), ¬ IsUnramifiedAt K L 𝔭 ∧
      (p : ℤ) ∈ 𝔭.asIdeal.under ℤ)}

theorem finite_crossingExceptional (L : Type*) [Field L] [NumberField L] [Algebra K L]
    [IsGalois K L] : (crossingExceptional K L).Finite := sorry

/-- **Layer 8C.1, auxiliary primes of every level exist**, by Dirichlet's theorem in the
progression `1 mod f^r` together with the finiteness of the exceptional set.

⚠ "`f` divides `[K(ζ_m):K]`" does **not** produce an element of order divisible by `f`.
Divisibility of the order of a finite group gives no such element in general; the cyclicity of
`Gal(K(ζ_q)/K)` is what does, and it is why the construction uses a rational prime `q` rather
than an arbitrary modulus. -/
theorem exists_auxiliaryPrime (L : Type*) [Field L] [NumberField L] [Algebra K L] [IsGalois K L]
    (f r : ℕ) (hf : 0 < f) :
    ∃ q : ℕ, q.Prime ∧ q ∉ crossingExceptional K L ∧ q ≡ 1 [MOD f ^ r] := sorry

/-! ### Layers 8C.5 to 8C.8: the tagged fibres and the constant -/

variable (M : Type*) [Field M] [NumberField M] [Algebra K M] [IsGalois K M]

open scoped Classical in
/-- **Layer 8C.5, the tagged set `H_{q,f}`**: the elements of `H_q = Gal(K(ζ_q)/K)` whose order is
divisible by `f`. ⚠ The crossing argument must use **all** of them. One generator `τ` gives a
single tagged fibre, of density `1/(#G · #H_q)`, and that bound tends to `0` as `q` grows; it is
the union over `H_{q,f}` that reaches `1/#G`. -/
noncomputable def taggedElements (f : ℕ) : Finset (M ≃ₐ[K] M) :=
  Finset.univ.filter fun τ ↦ f ∣ orderOf τ

/-- **Layer 8C.6, the crossing constant, written out.**

`c_q = #H_{q,f} / (#G · #H_q)`.

Each tagged fibre contracts to a set of primes of `K` of density `1/(#G · #H_q)`, and the fibres
are pairwise disjoint, so the bound is their number over that common density. ⚠ No milestone
records a value for `c_q` that has not been derived; this one is derived in
`lowerDirichletDensityAtLeast_crossing` from `hasDirichletDensity_taggedFibre` and
`taggedFibre_pairwiseDisjoint`. -/
noncomputable def crossingConstant (f : ℕ) : ℝ :=
  ((taggedElements K M f).card : ℝ) /
    ((Nat.card (L ≃ₐ[K] L) : ℝ) * (Nat.card (M ≃ₐ[K] M) : ℝ))

variable (N : Type*) [Field N] [NumberField N] [Algebra K N] [IsGalois K N]
variable [Algebra L N] [Algebra M N] [IsScalarTower K L N] [IsScalarTower K M N]

/-- **Layer 8C.2, the canonical restriction map** `Gal(N/K) → Gal(L/K) × Gal(M/K)`, built from
Mathlib's `AlgEquiv.restrictNormalHom`. ⚠ It is this map, and not an arbitrary group isomorphism,
that 8C.3's Frobenius compatibility is a statement about. -/
noncomputable def crossingRestrict : (N ≃ₐ[K] N) →* ((L ≃ₐ[K] L) × (M ≃ₐ[K] M)) :=
  (AlgEquiv.restrictNormalHom (F := K) (K₁ := N) L).prod
    (AlgEquiv.restrictNormalHom (F := K) (K₁ := N) M)

/-- **Layers 8C.1 to 8C.4, the auxiliary crossing diagram, as one datum.**

⚠ The three theorems below are false without it, and not merely unprovable. Stated for arbitrary
finite Galois `L/K`, `M/K`, `N/K` and an abstract isomorphism `Gal(N/K) ≃* Gal(L/K) × Gal(M/K)`:

- the tagged fibre has density `#C_σ · #C_τ / (#G · #H)`, not `1/(#G · #H)` — in `S₃ × C₂` a
  transposition paired with the nontrivial element has a conjugacy class of size `3`;
- for a nonabelian `Gal(M/K)`, distinct conjugate `τ` determine the *same* conjugacy class and
  hence the same set of primes, so the fibres are not pairwise disjoint.

`L/K` abelian and `Gal(M/K)` cyclic make `Gal(N/K)` abelian, every class a singleton, and both
statements true; the cyclotomic and compositum conditions are what make the route of 8C
non-circular, because 8C.4's fixed field has to be cyclotomic over its base for 8B.5 to apply
over it. This is data the construction depends on, not a stand-in for another roadmap's object. -/
structure CrossingDatum where
  /-- **8C**: `L/K` is abelian. -/
  abelian_L : ∀ a b : L ≃ₐ[K] L, a * b = b * a
  /-- **8C.1**: the auxiliary rational prime `q`. -/
  q : ℕ
  q_prime : q.Prime
  /-- **8C.1**: `M = K(ζ_q)`. -/
  isCyclotomic : IsCyclotomicExtension {q} K M
  /-- **8C.1**: `Gal(K(ζ_q)/K)` is **cyclic**, which is what `K ∩ ℚ(ζ_q) = ℚ` buys, and what
  8C.4 and the count of 8C.7 both need. -/
  cyclic_M : IsCyclic (M ≃ₐ[K] M)
  /-- **8C.2**: `N = L·M` with `L ∩ M = K`, in the form that the canonical restriction map is
  bijective. This is the linear disjointness of 8C.2, and it is stated about `crossingRestrict`
  rather than by exhibiting some isomorphism. -/
  bijective_restrict : Function.Bijective ⇑(crossingRestrict K L M N)
  /-- **8C.3**: Frobenius under restriction is the pair of the restricted Frobenius elements.
  This is `frobeniusClass_restrictNormalHom` applied twice, and 8C.5 and 8C.6 read it. -/
  frobenius_restrict : ∀ 𝔭 : HeightOneSpectrum (𝓞 K), IsUnramifiedAt K N 𝔭 →
    ∀ ν : N ≃ₐ[K] N, ν ∈ (frobeniusClass K N 𝔭).carrier →
      (crossingRestrict K L M N ν).1 ∈ (frobeniusClass K L 𝔭).carrier ∧
        (crossingRestrict K L M N ν).2 ∈ (frobeniusClass K M 𝔭).carrier

section CrossingDatumAPI

variable {K L M N}

namespace CrossingDatum

/-- **Layer 8C.2, the crossed group is abelian**, from `abelian_L`, `cyclic_M` and bijectivity.
⚠ This is the theorem that makes every conjugacy class of `Gal(N/K)` a singleton, and hence
makes the density of a tagged fibre `1/(#G · #H)`. -/
theorem commute (D : CrossingDatum K L M N) (a b : N ≃ₐ[K] N) : a * b = b * a := sorry

/-- **Layer 8C.2, the element with prescribed restrictions.** -/
noncomputable def pair (D : CrossingDatum K L M N) (σ : L ≃ₐ[K] L) (τ : M ≃ₐ[K] M) : N ≃ₐ[K] N :=
  (Equiv.ofBijective _ D.bijective_restrict).symm (σ, τ)

theorem crossingRestrict_pair (D : CrossingDatum K L M N) (σ : L ≃ₐ[K] L) (τ : M ≃ₐ[K] M) :
    crossingRestrict K L M N (D.pair σ τ) = (σ, τ) := sorry

/-- **Layer 8C.4, the fixed field of `⟨(σ, τ)⟩` is cyclotomic over its base.** With
`f ∣ ord τ` the subgroup `⟨(σ, τ)⟩` meets `Gal(N/M)` trivially, so `N` is generated over that
fixed field by `ζ_q` and 8B.5 applies there. ⚠ Without `f ∣ ord τ` the intersection is
`⟨(σ^{ord τ}, 1)⟩`, which is nontrivial, and the fixed field's compositum with `M` is a proper
subfield of `N`. -/
theorem disjoint_zpowers_pair (D : CrossingDatum K L M N) (σ : L ≃ₐ[K] L) (τ : M ≃ₐ[K] M)
    (hτ : orderOf σ ∣ orderOf τ) :
    ∀ ν ∈ Subgroup.zpowers (D.pair σ τ),
      (crossingRestrict K L M N ν).2 = 1 → ν = 1 := sorry

end CrossingDatum

end CrossingDatumAPI

/-- **Layer 8C.1, the first intersection condition** `K ∩ ℚ(ζ_q) = ℚ`, in the form that the
cyclotomic Galois group over `K` has full order `q − 1`, and is therefore cyclic. Avoiding
`crossingExceptional` is what buys it. -/
theorem cyclic_of_auxiliary (q : ℕ) (hq : q.Prime) (hex : q ∉ crossingExceptional K L)
    [IsCyclotomicExtension {q} K M] :
    Nat.card (M ≃ₐ[K] M) = q - 1 ∧ IsCyclic (M ≃ₐ[K] M) := sorry

/-- **Layer 8C.2, the second intersection condition** `L ∩ K(ζ_q) = K`, in the form that the
canonical restriction map is bijective. Injectivity is `N = L·M`, and the degree count is the
disjointness. -/
theorem bijective_crossingRestrict_of_auxiliary (q : ℕ) (hq : q.Prime)
    (hex : q ∉ crossingExceptional K L) [IsCyclotomicExtension {q} K M]
    (hcomp : ∀ ν : N ≃ₐ[K] N, crossingRestrict K L M N ν = 1 → ν = 1)
    (hcard : Nat.card (N ≃ₐ[K] N) = Nat.card (L ≃ₐ[K] L) * Nat.card (M ≃ₐ[K] M)) :
    Function.Bijective ⇑(crossingRestrict K L M N) := sorry

/-- **Layers 8C.1 to 8C.4, the canonical constructor of the crossing datum.**

⚠ A structure of correct hypotheses that nothing constructs shows only that the hypotheses
typecheck. This is the declaration that turns 8C.1's auxiliary prime into the exact package the
lower bound consumes, so the crossing route is not merely assumed. -/
noncomputable def crossingDatumOfAuxiliary (q : ℕ) (hq : q.Prime)
    (hex : q ∉ crossingExceptional K L) [hcyc : IsCyclotomicExtension {q} K M]
    (habel : ∀ a b : L ≃ₐ[K] L, a * b = b * a)
    (hcomp : ∀ ν : N ≃ₐ[K] N, crossingRestrict K L M N ν = 1 → ν = 1)
    (hcard : Nat.card (N ≃ₐ[K] N) = Nat.card (L ≃ₐ[K] L) * Nat.card (M ≃ₐ[K] M)) :
    CrossingDatum K L M N where
  abelian_L := habel
  q := q
  q_prime := hq
  isCyclotomic := hcyc
  cyclic_M := (cyclic_of_auxiliary K L M q hq hex).2
  bijective_restrict :=
    bijective_crossingRestrict_of_auxiliary K L M N q hq hex hcomp hcard
  frobenius_restrict := sorry

/-- **Layer 8C.1, the level condition transfers.** From `q ≡ 1 mod f^r` and
`#Gal(K(ζ_q)/K) = q − 1`, the tagged set of 8C.5 is computed at level `r`, which is what 8C.7's
estimate consumes. -/
theorem pow_dvd_card_of_auxiliary (q : ℕ) (hq : q.Prime) (hex : q ∉ crossingExceptional K L)
    [IsCyclotomicExtension {q} K M] (f r : ℕ) (hf : 0 < f) (hq1 : q ≡ 1 [MOD f ^ r]) :
    f ^ r ∣ Nat.card (M ≃ₐ[K] M) := sorry

/-- **Layer 8C.6, the density of one tagged fibre after contraction to `K`.** In the compositum
`N = L·K(ζ_q)`, whose group is `G × H_q` by 8C.2, the primes with Frobenius `(σ, τ)` have density
`1/(#G · #H_q)`. This is 8B.5 applied over the fixed field of `⟨(σ, τ)⟩`, then contracted through
8A.5; `f ∣ ord τ` is what makes that fixed field cyclotomic over its base, and `D.commute` is
what makes the class of `(σ, τ)` a singleton.

⚠ The contraction needs the degree-one reduction of 8A.4 first. A prime `𝔓` of the fixed field of
residue degree `f > 1` over `K` has `Frob_{N/E}(𝔓) = Frob_{N/K}(𝔭)^f`, which does not determine
`Frob_{N/K}(𝔭)`; on the degree-one primes it does, and every prime of `K` in the target fibre
carries `[E:K] = #G·#H_q/ord τ` of them. -/
theorem hasDirichletDensity_taggedFibre (D : CrossingDatum K L M N)
    (σ : L ≃ₐ[K] L) (τ : M ≃ₐ[K] M) (hτ : orderOf σ ∣ orderOf τ) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        IsUnramifiedAt K N 𝔭 ∧ frobeniusClass K N 𝔭 = ConjClasses.mk (D.pair σ τ)}
      (1 / ((Nat.card (L ≃ₐ[K] L) : ℝ) * (Nat.card (M ≃ₐ[K] M) : ℝ))) := sorry

/-- **Layer 8C.5, pairwise disjointness of the tagged fibres**, which is what makes the densities
add rather than merely bound one another. ⚠ It needs `D.commute`: over a nonabelian `Gal(N/K)`,
two distinct conjugate `τ` give the *same* conjugacy class and hence the same set of primes. -/
theorem taggedFibre_pairwiseDisjoint (D : CrossingDatum K L M N) (σ : L ≃ₐ[K] L) :
    Pairwise (Function.onFun Disjoint fun τ : M ≃ₐ[K] M ↦
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        IsUnramifiedAt K N 𝔭 ∧ frobeniusClass K N 𝔭 = ConjClasses.mk (D.pair σ τ)}) := sorry

/-- **Layer 8C.6, the lower bound from one auxiliary prime.**

⚠ The predicate is the inequality of 8A.1 and not an equality: the tagged fibres are contained in
the target set and need not exhaust it, so nothing stronger is available here. -/
theorem lowerDirichletDensityAtLeast_crossing (D : CrossingDatum K L M N) (σ : L ≃ₐ[K] L) :
    LowerDirichletDensityAtLeast K
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = ConjClasses.mk σ}
      (crossingConstant K L M (orderOf σ)) := sorry

/-- **Layer 8C.6, the lower bound from a *constructed* auxiliary diagram**, which is the form
8C.8 consumes. ⚠ The datum is not a hypothesis here: it is produced by `crossingDatumOfAuxiliary`
from the auxiliary prime of 8C.1, so this theorem is the one that shows the crossing route closes.
Its proof is the composition, and carries no `sorry` of its own. -/
theorem lowerDirichletDensityAtLeast_of_auxiliary (q : ℕ) (hq : q.Prime)
    (hex : q ∉ crossingExceptional K L) [IsCyclotomicExtension {q} K M]
    (habel : ∀ a b : L ≃ₐ[K] L, a * b = b * a)
    (hcomp : ∀ ν : N ≃ₐ[K] N, crossingRestrict K L M N ν = 1 → ν = 1)
    (hcard : Nat.card (N ≃ₐ[K] N) = Nat.card (L ≃ₐ[K] L) * Nat.card (M ≃ₐ[K] M))
    (σ : L ≃ₐ[K] L) :
    LowerDirichletDensityAtLeast K
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = ConjClasses.mk σ}
      (crossingConstant K L M (orderOf σ)) :=
  lowerDirichletDensityAtLeast_crossing K L M N
    (crossingDatumOfAuxiliary K L M N q hq hex habel hcomp hcard) σ

/-- **Layer 8C.7, the exact cyclic-group count.** In a cyclic group of order `n` with `f ∣ n`,

`#H_{q,f} = n · ∏_{p ∣ f} (1 − p^{−(v_p(n) − v_p(f) + 1)})`.

The test is `n = 4`, `f = 2`: the formula gives `4(1 − 1/4) = 3`, and the three elements of `C₄`
of order divisible by `2` are `g`, `g²`, `g³`. -/
theorem card_taggedElements (f : ℕ) (hf : 0 < f) (hcyc : IsCyclic (M ≃ₐ[K] M))
    (hdvd : f ∣ Nat.card (M ≃ₐ[K] M)) :
    ((taggedElements K M f).card : ℝ) =
      (Nat.card (M ≃ₐ[K] M) : ℝ) * ∏ p ∈ f.primeFactors,
        (1 - (p : ℝ) ^ (-(((Nat.card (M ≃ₐ[K] M)).factorization p -
          f.factorization p + 1 : ℕ) : ℤ))) := sorry

/-- **Layer 8C.7, the tagged proportion at level `r`.** With `q ≡ 1 mod f^r`, so that
`f^r ∣ #H_q`, every prime `p ∣ f` contributes at most `p^{-r} ≤ 2^{-r}` to the complement, so

`#H_{q,f} / #H_q ≥ 1 − ω(f)·2^{-r}`.

⚠ This is a statement about the cyclic group alone and about nothing in `L`, which is why 8C.7
is a separate milestone from 8C.6. -/
theorem taggedElements_card_ratio_ge (f r : ℕ) (hf : 0 < f) (hcyc : IsCyclic (M ≃ₐ[K] M))
    (hdvd : f ^ r ∣ Nat.card (M ≃ₐ[K] M)) :
    1 - (f.primeFactors.card : ℝ) * (2 : ℝ) ^ (-(r : ℤ)) ≤
      ((taggedElements K M f).card : ℝ) / (Nat.card (M ≃ₐ[K] M) : ℝ) := sorry

/-- **Layer 8C.7, the bound approaches `1/#G`.** -/
theorem crossingConstant_ge (f r : ℕ) (hf : 0 < f) (hcyc : IsCyclic (M ≃ₐ[K] M))
    (hdvd : f ^ r ∣ Nat.card (M ≃ₐ[K] M)) :
    (1 - (f.primeFactors.card : ℝ) * (2 : ℝ) ^ (-(r : ℤ))) / (Nat.card (L ≃ₐ[K] L) : ℝ) ≤
      crossingConstant K L M f := sorry

/-- **Layer 8C.7, the epsilon form**, which is what the squeeze of 8C.8 consumes. ⚠ A bound that
is uniform in `q` but strictly below `1/#G` is not enough: 8C.8 needs the `#G` lower bounds to sum
to `1`, so the bound has to *approach* `1/#G`. -/
theorem exists_level_crossingConstant (f : ℕ) (hf : 0 < f) (ε : ℝ) (hε : 0 < ε) :
    ∃ r : ℕ, (f.primeFactors.card : ℝ) * (2 : ℝ) ^ (-(r : ℤ)) <
      ε * (Nat.card (L ≃ₐ[K] L) : ℝ) := sorry

/-- **Layer 8C.8, the abelian theorem**, from the lower bounds of 8C.6, the epsilon statement of
8C.7, and the squeeze of 8A.3. -/
theorem hasDirichletDensity_abelian (hab : ∀ σ τ : L ≃ₐ[K] L, σ * τ = τ * σ) (σ : L ≃ₐ[K] L) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = ConjClasses.mk σ}
      (1 / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

/-- **Layer 8D.4, the fibre count.** Each prime `𝔭` of `K` with Frobenius class `C = [σ]` has
exactly `#G/(#C · f)` primes of `E = L^{⟨σ⟩}` whose relative Frobenius is `σ` and whose residue
degree over `K` is `1`.

⚠ The counted fibre is the one with relative Frobenius **`σ`**, not the identity. The
split-completely fibre is a different set, and the difference is already visible in the smallest
case: see `card_primesOver_fixedField_cyclic` below.

⚠ `E` is identified as the fixed field of `⟨σ⟩` by `hσE` and `hgen`, and not by a cardinality.
`Nat.card (L ≃ₐ[E] L) = orderOf σ` says only that `[L:E]` is right; it does not say that
`Gal(L/E)` is `⟨σ⟩`, and every step of 8D uses that it is.

⚠ The count is not `#C·f/#G` and not `1`. The consistency check is that 8A.5 turns the density
`1/f` over `E` into `#C/#G` over `K`, and `#G/(#C·f) = #C_G(σ)/f`, a positive integer because
`⟨σ⟩ ⊆ C_G(σ)`. -/
theorem card_primesOver_fixedField (σ : L ≃ₐ[K] L) (E : Type*) [Field E] [NumberField E]
    [Algebra K E] [Algebra E L] [IsScalarTower K E L] [IsGalois E L]
    (σE : L ≃ₐ[E] L) (hσE : AlgEquiv.restrictScalars K σE = σ)
    (hgen : ∀ ρ : L ≃ₐ[E] L, ρ ∈ Subgroup.zpowers σE)
    (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭)
    (hC : frobeniusClass K L 𝔭 = ConjClasses.mk σ) :
    Nat.card {𝔓 : HeightOneSpectrum (𝓞 E) //
        𝔓.asIdeal.under (𝓞 K) = 𝔭.asIdeal ∧ Ideal.inertiaDeg 𝔭.asIdeal 𝔓.asIdeal = 1 ∧
          frobeniusClass E L 𝔓 = ConjClasses.mk σE} =
      Nat.card (L ≃ₐ[K] L) /
        (Nat.card (ConjClasses.mk σ).carrier * orderOf σ) := sorry

/-- **Layer 8D.4, the mandatory test.** Take `L/K` cyclic with `σ` a generator. Then
`⟨σ⟩ = Gal(L/K)`, so `E = L^{⟨σ⟩} = K`, `#C = 1`, `f = ord σ = #G`, and the count is
`#G/(1 · #G) = 1`: the prime `𝔭` is its own fibre.

⚠ Its relative Frobenius is `σ`, not `1`. A version of 8D.4 that counts the primes of `E` with
relative Frobenius `1` gives the empty set here while the displayed count is `1`, so this test
catches the split-completely fibre being used in place of the `σ` fibre.

⚠ `σ ≠ 1` is needed. At the identity extension `L = K` with `σ = 1`, the generator hypothesis
holds, both displayed sets are `{𝔭}`, and the second cardinal is `1` rather than `0`. The test
exists to separate the nonidentity fibre from the split-completely fibre, so it has to exclude
the case where they coincide. -/
theorem card_primesOver_fixedField_cyclic (σ : L ≃ₐ[K] L) (hσ : σ ≠ 1)
    (hgen : ∀ ρ : L ≃ₐ[K] L, ρ ∈ Subgroup.zpowers σ)
    (𝔭 : HeightOneSpectrum (𝓞 K)) (h : IsUnramifiedAt K L 𝔭)
    (hC : frobeniusClass K L 𝔭 = ConjClasses.mk σ) :
    Nat.card {𝔓 : HeightOneSpectrum (𝓞 K) //
        𝔓.asIdeal = 𝔭.asIdeal ∧ frobeniusClass K L 𝔓 = ConjClasses.mk σ} = 1 ∧
      Nat.card {𝔓 : HeightOneSpectrum (𝓞 K) //
        𝔓.asIdeal = 𝔭.asIdeal ∧ frobeniusClass K L 𝔓 = 1} = 0 := sorry

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
theorem wienerIkehara (a : ℕ → ℝ) (F G : ℂ → ℂ) (κ : ℝ) (ha : ∀ n, 0 ≤ a n)
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

section FrobeniusCounting

variable (F : Type*) [Field F] [NumberField F] [Algebra K F] [IsGalois K F]

open scoped Classical in
/-- **Layer 9.7, the nonnegative Frobenius-fibre coefficient**

`a_σ(n) = ∑_{𝔑𝔭^m = n, Frob_𝔭^m = σ} log 𝔑𝔭`.

⚠ The condition is `Frob_𝔭^m = σ`, and **not** `Frob_𝔭 = σ`. The logarithmic derivative of the
Euler factor at `𝔭` is `∑_{m ≥ 1} χ(Frob_𝔭)^m log 𝔑𝔭 · 𝔑𝔭^{-ms}`, and `χ(Frob_𝔭)^m` is
`χ(Frob_𝔭^m)`, so character orthogonality isolates the `m`-th power. The check is a quadratic
cyclotomic extension: at an inert `𝔭` the Frobenius is the nontrivial `g`, but `g² = 1`, so the
`𝔭²` term belongs to the *identity* fibre; a coefficient that filters on `Frob_𝔭 = σ` drops it,
and then the orthogonality identity below is not provable for the named sequence.

⚠ It is this sequence, and never a character twist `χ(𝔞)Λ_K(𝔞)`, that Wiener–Ikehara is applied
to: the twist is signed or complex, and 9.1 is a theorem about **nonnegative** coefficients. -/
noncomputable def frobeniusFibreCoeff (σ : F ≃ₐ[K] F) (n : ℕ) : ℝ :=
  ∑ᶠ p : {p : HeightOneSpectrum (𝓞 K) × ℕ // 0 < p.2 ∧
      Ideal.absNorm p.1.asIdeal ^ p.2 = n ∧ IsUnramifiedAt K F p.1 ∧
      ∃ ρ : F ≃ₐ[K] F, frobeniusClass K F p.1 = ConjClasses.mk ρ ∧ ρ ^ p.2 = σ},
    Real.log (Ideal.absNorm (p : HeightOneSpectrum (𝓞 K) × ℕ).1.asIdeal)

theorem frobeniusFibreCoeff_nonneg (σ : F ≃ₐ[K] F) (n : ℕ) : 0 ≤ frobeniusFibreCoeff K F σ n :=
  sorry

/-- **Layer 8B.1, the cyclotomic Galois group is abelian.** It embeds in `(ℤ/m)ˣ` by the
Frobenius formula, and everything below rests on that: the Frobenius class is a singleton, and
one-dimensional characters separate its elements. -/
theorem commute_cyclotomicGal (m : ℕ) [NeZero m] [IsCyclotomicExtension {m} K F]
    (a b : F ≃ₐ[K] F) : a * b = b * a := sorry

/-- **Layer 8B.1, the ideal weight of a character of `Gal(K(ζ_m)/K)`**, built here rather than
quantified over. Its value at an unramified prime is `χ(Frob_𝔭)`, its bad set is exactly the
ramified primes, and it is `0` there. -/
noncomputable def cyclotomicWeight (χ : (F ≃ₐ[K] F) →* ℂˣ) : IdealWeight K := sorry

theorem cyclotomicWeight_bad (χ : (F ≃ₐ[K] F) →* ℂˣ) :
    (cyclotomicWeight K F χ).bad = {𝔭 : HeightOneSpectrum (𝓞 K) | ¬ IsUnramifiedAt K F 𝔭} :=
  sorry

theorem cyclotomicWeight_apply (χ : (F ≃ₐ[K] F) →* ℂˣ) {𝔭 : HeightOneSpectrum (𝓞 K)}
    (h : IsUnramifiedAt K F 𝔭) :
    (cyclotomicWeight K F χ).toFun 𝔭.asIdeal = (χ (frobeniusElt K F 𝔭) : ℂ) := sorry

/-- ⚠ It vanishes at the ramified primes. Without this the orthogonality identity below is false:
its right-hand side runs over every prime, while `frobeniusFibreCoeff` excludes the ramified
ones, so a weight merely *specified* at the unramified primes may contribute extra terms. -/
theorem cyclotomicWeight_eq_zero (χ : (F ≃ₐ[K] F) →* ℂˣ) {𝔭 : HeightOneSpectrum (𝓞 K)}
    (h : ¬ IsUnramifiedAt K F 𝔭) : (cyclotomicWeight K F χ).toFun 𝔭.asIdeal = 0 := sorry

/-- **Layer 9.7, the orthogonality identity, as a theorem** about the canonical cyclotomic
weight. With `Frob_𝔭^m = σ` as the filter it is exactly 8B.3 applied to `−L'/L` of each character;
with `Frob_𝔭 = σ` it is not provable at all.

⚠ It is stated for a **cyclotomic** `F`, and not for an arbitrary finite Galois extension. The
characters here are one-dimensional, and those separate elements only in the abelianization: in
`S₃` every one-dimensional character takes the same value at the identity and at a three-cycle,
so the character sum returns `1` where the `Frob^m = σ` indicator returns `0`.
`commute_cyclotomicGal` is what rules that out.

⚠ It is also stated for the **named** `cyclotomicWeight` and not for an arbitrary `w` specified
only at unramified primes, for the reason recorded at `cyclotomicWeight_eq_zero`. -/
theorem lSeries_frobeniusFibreCoeff (m : ℕ) [NeZero m] [IsCyclotomicExtension {m} K F]
    (σ : F ≃ₐ[K] F) {s : ℂ} (hs : 1 < s.re) :
    LSeries (fun n ↦ (frobeniusFibreCoeff K F σ n : ℂ)) s =
      (Nat.card (F ≃ₐ[K] F) : ℂ)⁻¹ *
        ∑ᶠ χ : (F ≃ₐ[K] F) →* ℂˣ, starRingEnd ℂ (χ σ : ℂ) *
          LSeries (idealCoeffOfWeight K
            (fun I ↦ (cyclotomicWeight K F χ).toFun I * idealVonMangoldt K I)) s :=
  sorry

/-- **Layer 9.7, the counting asymptotic for one Frobenius fibre.**

Every hypothesis is named: the extension is cyclotomic over `K`, `σ` is an element of its finite
Galois group, the coefficients are the nonnegative `a_σ` above, and `hG`/`hFG` are the
boundary-continuation hypotheses that 7.4 supplies. The orthogonality step is no longer a
hypothesis — it is `lSeries_frobeniusFibreCoeff`. The conclusion constant is
`1/#Gal(K(ζ_m)/K)`, and nothing else.

⚠ The statement this replaces quantified over an arbitrary predicate `P` on ideals and an
arbitrary limit `c`, and was therefore false: take `P` always false and `c = 1`. A green build
shows only that a signature typechecks, so the hypotheses have to be the intended ones. -/
theorem tendsto_frobeniusFibreCoeff (m : ℕ) [NeZero m] [IsCyclotomicExtension {m} K F]
    (σ : F ≃ₐ[K] F) (G : ℂ → ℂ)
    (hsum : ∀ s : ℂ, 1 < s.re →
      LSeriesSummable (fun n ↦ (frobeniusFibreCoeff K F σ n : ℂ)) s)
    (hG : ContinuousOn G {s : ℂ | 1 ≤ s.re})
    (hFG : ∀ s : ℂ, 1 < s.re →
      G s = LSeries (fun n ↦ (frobeniusFibreCoeff K F σ n : ℂ)) s -
        ((Nat.card (F ≃ₐ[K] F) : ℂ))⁻¹ / (s - 1)) :
    Tendsto
      (fun x : ℝ ↦ (∑ n ∈ Finset.range ⌊x⌋₊.succ, frobeniusFibreCoeff K F σ n) / x)
      atTop (𝓝 (1 / (Nat.card (F ≃ₐ[K] F) : ℝ))) := sorry

/-- **Layer 9.7, the prime-counting form**, after the prime powers are removed as in 9.4 and 9.5:
`#{𝔭 ∣ 𝔑𝔭 ≤ x, Frob_𝔭 = σ} ∼ (1/[K(ζ_m):K]) · x/log x`. -/
theorem tendsto_count_frobeniusFibre (m : ℕ) [NeZero m] [IsCyclotomicExtension {m} K F]
    (σ : F ≃ₐ[K] F) :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x ∧
            IsUnramifiedAt K F 𝔭 ∧ frobeniusClass K F 𝔭 = ConjClasses.mk σ} : ℝ) /
          (x / Real.log x))
      atTop (𝓝 (1 / (Nat.card (F ≃ₐ[K] F) : ℝ))) := sorry

end FrobeniusCounting

/-- **Layer 9.8, the count-side contraction lemma**, the counting analogue of 8A.5.

⚠ The residue-degree-one hypothesis is what identifies the two norms; without it the two counts
run over different quantities and the conclusion is false. The error terms transport because `k`
is a constant, and that is the whole reason this is a separate milestone from 8A.5. -/
theorem tendsto_count_of_contraction (E : Type*) [Field E] [NumberField E] [Algebra K E]
    (S : Set (HeightOneSpectrum (𝓞 E))) (T : Set (HeightOneSpectrum (𝓞 K))) (k : ℕ) (hk : 0 < k)
    (c : ℝ)
    (hfibre : ∀ 𝔭 ∈ T, Nat.card {𝔓 : HeightOneSpectrum (𝓞 E) //
      𝔓 ∈ S ∧ 𝔓.asIdeal.under (𝓞 K) = 𝔭.asIdeal} = k)
    (hdeg : ∀ 𝔓 ∈ S, Ideal.inertiaDeg (𝔓.asIdeal.under (𝓞 K)) 𝔓.asIdeal = 1)
    (hover : ∀ 𝔓 ∈ S, ∃ 𝔭 ∈ T, 𝔓.asIdeal.under (𝓞 K) = 𝔭.asIdeal)
    (hS : Tendsto (fun x : ℝ ↦
        (Nat.card {𝔓 : HeightOneSpectrum (𝓞 E) // 𝔓 ∈ S ∧
          (Ideal.absNorm 𝔓.asIdeal : ℝ) ≤ x} : ℝ) / (x / Real.log x)) atTop (𝓝 c)) :
    Tendsto (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // 𝔭 ∈ T ∧
          (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ) / (x / Real.log x)) atTop (𝓝 (c / k)) :=
  sorry

section CountingChebotarev

variable (L : Type*) [Field L] [NumberField L] [Algebra K L] [IsGalois K L]

/-- **Layer 9.9, the count-side abelian theorem.** The crossing argument of 8C, repeated with
9.7 in place of 8B.5 and counting asymptotics in place of densities.

⚠ The limit in `q` is taken **after** the count and not inside it. Reversing the two limits is
the error this milestone exists to prevent, and it is why 9.9 is not a corollary of 8C.8. -/
theorem tendsto_count_abelian (hab : ∀ σ τ : L ≃ₐ[K] L, σ * τ = τ * σ) (σ : L ≃ₐ[K] L) :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x ∧
            IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = ConjClasses.mk σ} : ℝ) /
          (x / Real.log x))
      atTop (𝓝 (1 / (Nat.card (L ≃ₐ[K] L) : ℝ))) := sorry

/-- **Layer 9.10, natural-density Chebotarev**, over a general number field.

⚠ This is not a formal consequence of Layer 8. A Dirichlet density does not imply a natural one,
and the roadmap asks for both because neither implies the other. -/
theorem hasNaturalDensity_frobeniusClass (C : ConjClasses (L ≃ₐ[K] L)) :
    HasNaturalDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = C}
      ((Nat.card C.carrier : ℝ) / (Nat.card (L ≃ₐ[K] L) : ℝ)) := sorry

theorem tendsto_count_frobeniusClass (C : ConjClasses (L ≃ₐ[K] L)) :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x ∧
            IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = C} : ℝ) / (x / Real.log x))
      atTop (𝓝 ((Nat.card C.carrier : ℝ) / (Nat.card (L ≃ₐ[K] L) : ℝ))) := sorry

end CountingChebotarev

/-- **Layer 9.11, natural-density equidistribution in ray classes.** ⚠ 9.11 consumes this named
milestone, and not "the same upgrade": it is 9.7 and 9.9 run over the **ray-class** family of 7.5
in place of the cyclotomic family of 8B.2, and the family hypothesis is what changes. -/
theorem hasNaturalDensity_rayClass (𝔪 : Modulus K) [Fintype (RayClassCharacter 𝔪)]
    (hfam : CancellingFamily K (RayClassCharacter 𝔪) (fun χ ↦ χ.weight))
    (c : 𝔪.RayClassGroup) :
    HasNaturalDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) | 𝔪.IsCoprimeTo 𝔭.asIdeal ∧ 𝔪.idealClass 𝔭.asIdeal = c}
      (1 / (Nat.card 𝔪.RayClassGroup : ℝ)) := sorry

/-- **Layer 9.12, Mertens for `K`, the sum form**: `∑_{𝔑𝔭 ≤ x} 𝔑𝔭^{-1} = log log x + M_K + o(1)`.

⚠ The constant `M_K` is part of the statement, and the leading term alone is what 9.4 and 9.6
already give. -/
theorem mertens_sum :
    ∃ M : ℝ, Tendsto
      (fun x : ℝ ↦
        (∑ᶠ 𝔭 : {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x},
          ((Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℝ))⁻¹) -
        Real.log (Real.log x) - M)
      atTop (𝓝 0) := sorry

/-- **Layer 9.12, the higher-prime-power tail converges.** ⚠ A sub-milestone and not a
hypothesis of the product theorem: it follows from `𝔑𝔭 ≥ 2` and the convergence of
`∑_𝔭 𝔑𝔭^{-2}`, which is the Euler product of 1.4 at `s = 2`. It is where the passage from the
sum form to the product form happens. -/
theorem summable_primePower_tail :
    Summable fun p : HeightOneSpectrum (𝓞 K) × ℕ ↦
      if 2 ≤ p.2 then ((Ideal.absNorm p.1.asIdeal : ℝ) ^ (-(p.2 : ℤ))) / p.2 else 0 := sorry

/-- **Layer 9.12, Mertens for `K`, the product form**:

`∏_{𝔑𝔭 ≤ x} (1 − 𝔑𝔭^{-1})^{-1} ∼ e^{γ} · κ_K · log x`, with `κ_K = Res_{s=1} ζ_K(s)`.

⚠ The residue is part of the constant. The familiar `e^{γ} log x` is the case `K = ℚ`, where
`κ_ℚ = 1`, so a formula that omits `κ_K` passes every rational check and is wrong over every
other field. Through the analytic class number formula the missing factor carries `h`, `R`, `w`,
`|d_K|`, and the signature, which is most of what the theorem is worth.

*Source:* Rosen; Garcia–Lee, *Unconditional explicit Mertens' theorems for number fields*,
Theorem 1. *Test:* `K = ℚ(√−5)`, where `κ_K = π/√5 ≠ 1`. -/
theorem mertens_prod :
    Tendsto
      (fun x : ℝ ↦
        (∏ᶠ 𝔭 : {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x},
          (1 - ((Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℝ))⁻¹)⁻¹) /
        (Real.exp Real.eulerMascheroniConstant * (dedekindZeta_residue K : ℝ) * Real.log x))
      atTop (𝓝 1) := sorry

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
