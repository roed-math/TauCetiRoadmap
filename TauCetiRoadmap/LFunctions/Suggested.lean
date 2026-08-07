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

Per the honest-`sorry` rule, milestones whose *statements* need API that does not exist at
the pin are not stated here and live in `README.md` only: the lattice theta transformations
and the level-`N` frame (Layer 2 — the pin has no dual lattice and no level), Hecke
L-functions of ray-class characters and of Grossencharacters (Layers 5–6 — the characters
belong to the global class field theory roadmap), and the public form of Chebotarev over the
number field arithmetic roadmap's `frobeniusClass`, whose intended signature is written out in
the docstring of `chebotarev` below. As those types become expressible in `TauCeti/`, add the
milestones here with `sorry`.
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
  no_other_poles : ∀ p : ℂ, d.polarOrder p = 0 →
    0 ≤ meromorphicOrderAt d.completed p

/-- **Layer 0.3, the meromorphic functional equation.** The polar divisor is invariant under
`s ↦ 1 - conj s`, and equality is required only off the two polar loci. Together with
`HasMeromorphicContinuation`, equality on this complement determines the same meromorphic
germ and compatible principal part at every pole; no junk value at a pole is compared. -/
structure HasFunctionalEquation (d : AnalyticLFunctionData) : Prop where
  norm_rootNumber : ‖d.rootNumber‖ = 1
  polarOrder_reflect : ∀ s : ℂ, d.polarOrder s = d.polarOrder (reflectedPoint s)
  eq_away : ∀ s : ℂ, d.polarOrder s = 0 → d.polarOrder (reflectedPoint s) = 0 →
    d.completed s = d.rootNumber * d.dualCompleted (1 - s)

/-- **Layer 0.3, coefficient growth.** The Ramanujan bound in the on-average form, which is
what every instance can prove; pointwise bounds remain instance-specific. -/
structure HasAverageCoefficientBound (d : AnalyticLFunctionData) : Prop where
  coeff_avg : ∀ δ : ℝ, 0 < δ →
    (fun n : ℕ ↦ ∑ k ∈ Finset.Icc 1 n, ‖d.coeff k‖) =O[atTop] fun n ↦ (n : ℝ) ^ (1 + δ)

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
  completed_eq : ∀ s : ℂ,
    analytic.completed s = arithmetic.completed (s + (weight : ℂ) / 2)
  gammaR_eq : analytic.gammaR = arithmetic.gammaR.map fun μ ↦ μ - (weight : ℂ) / 2
  gammaC_eq : analytic.gammaC = arithmetic.gammaC.map fun ν ↦ ν - (weight : ℂ) / 2
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

/-- **Layer 1.5, the local coefficient identity**: the reciprocal of the local polynomial is
the local factor of the Dirichlet series, prime by prime. -/
def HasLocalCoefficients (E : EulerFactorData K) (a : ℕ → ℂ) : Prop :=
  ∀ (𝔭 : HeightOneSpectrum (𝓞 K)) (s : ℂ), 1 < s.re →
    HasSum (fun k : ℕ ↦ a (Ideal.absNorm 𝔭.asIdeal ^ k) *
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
example : LSeries.abscissaOfAbsConv (idealCoeff K) = 1 := sorry

/-- **Layer 1.6, counting ideals in a class with an error term.** The pin has the limit
(`Ideal.tendsto_norm_le_and_mk_eq_div_atTop`); the error form, with the exponent `1 - 1/d`
and an implied constant independent of the class, is what Layers 1.7 and 7 need. It is the
hard analytic milestone of Layer 1. -/
example (c : ClassGroup (𝓞 K)) :
    (fun x : ℝ ↦ (Nat.card {I : Ideal (𝓞 K) //
          (Ideal.absNorm I : ℝ) ≤ x ∧ I ≠ ⊥ ∧ ClassGroup.mk0 ⟨I, sorry⟩ = c} : ℝ) -
        NumberField.dedekindZeta_residue K / (Nat.card (ClassGroup (𝓞 K)) : ℝ) * x)
      =O[atTop] fun x : ℝ ↦ x ^ (1 - 1 / (Module.finrank ℚ K : ℝ)) := sorry

/-- **Layer 1/3, worked example (`K = ℚ`)**: on the convergence half-plane the Dedekind
zeta function of `ℚ` is the Riemann zeta function. ⚠ Off `Re s > 1` the raw `LSeries` is
a junk value `0`, so this is *false* globally for `dedekindZeta`; only the continued
object of Layer 3 equals `riemannZeta` everywhere. -/
example {s : ℂ} (hs : 1 < s.re) : dedekindZeta ℚ s = riemannZeta s := sorry

/-! ## Layer 3: Dedekind zeta — continuation and functional equation

Stated in `∃`-form: the continued objects (`dedekindZetaC`, `completedDedekindZeta`) do
not exist at the pin; building them *is* the layer, and these statements pin their
defining properties. Layer 3.5 (uniqueness of the continuation) is what makes these
`∃`-statements determine anything. -/

/-- **Layer 3.7, analytic continuation of `ζ_K`** with its unique simple pole at `s = 1`,
whose residue is the pin's `dedekindZeta_residue` — upgrading the pin's real-limit class
number formula (`tendsto_sub_one_mul_dedekindZeta_nhdsGT`) to a genuine complex residue. -/
example :
    ∃ Z : ℂ → ℂ,
      (∀ s : ℂ, 1 < s.re → Z s = dedekindZeta K s) ∧
      Meromorphic Z ∧
      meromorphicOrderAt Z 1 = (-1 : WithTop ℤ) ∧
      (∀ s : ℂ, s ≠ 1 → 0 ≤ meromorphicOrderAt Z s) ∧
      Tendsto (fun s : ℂ ↦ (s - 1) * Z s) (𝓝[≠] 1)
        (𝓝 (dedekindZeta_residue K : ℂ)) := sorry

/-- **Layer 3.5, uniqueness of the continuation.** Without this the `∃`-statements above and
below pin nothing: two continuations agreeing on `Re s > 1` agree wherever both are
meromorphic, by the identity theorem on the connected set `ℂ ∖ {0, 1}`. -/
example (Z W : ℂ → ℂ) (hZ : Meromorphic Z) (hW : Meromorphic W)
    (h : ∀ s : ℂ, 1 < s.re → Z s = W s) :
    ∀ s : ℂ, s ≠ 0 → s ≠ 1 → Z s = W s := sorry

/-- **Layer 3.6, the completed Dedekind zeta function and its functional equation**
(Hecke; Neukirch VII (5.10)): `Λ_K(s) = |d_K|^{s/2} Γ_ℝ(s)^{r₁} Γ_ℂ(s)^{r₂} ζ_K(s)` on
the convergence half-plane, holomorphic on `ℂ ∖ {0, 1}`, with the self-dual equation
`Λ_K(1 − s) = Λ_K(s)`. -/
example :
    ∃ Λ : ℂ → ℂ,
      (∀ s : ℂ, 1 < s.re →
        Λ s = ((|discr K| : ℤ) : ℂ) ^ (s / 2) * Gammaℝ s ^ nrRealPlaces K *
          Gammaℂ s ^ nrComplexPlaces K * dedekindZeta K s) ∧
      Meromorphic Λ ∧
      meromorphicOrderAt Λ 0 = (-1 : WithTop ℤ) ∧
      meromorphicOrderAt Λ 1 = (-1 : WithTop ℤ) ∧
      (∀ s : ℂ, s ≠ 0 → s ≠ 1 → 0 ≤ meromorphicOrderAt Λ s) ∧
      Tendsto (fun s : ℂ ↦ (s - 1) * Λ s) (𝓝[≠] 1)
        (𝓝 (((|discr K| : ℤ) : ℂ) ^ ((1 : ℂ) / 2) *
          Gammaℝ 1 ^ nrRealPlaces K * Gammaℂ 1 ^ nrComplexPlaces K *
          (dedekindZeta_residue K : ℂ))) ∧
      Tendsto (fun s : ℂ ↦ s * Λ s) (𝓝[≠] 0)
        (𝓝 (-(((|discr K| : ℤ) : ℂ) ^ ((1 : ℂ) / 2) *
          Gammaℝ 1 ^ nrRealPlaces K * Gammaℂ 1 ^ nrComplexPlaces K *
          (dedekindZeta_residue K : ℂ)))) ∧
      (∀ s : ℂ, s ≠ 0 → s ≠ 1 → Λ (1 - s) = Λ s) := sorry

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
example : meromorphicOrderAt riemannZeta 1 = (-1 : WithTop ℤ) := sorry

/-- **Layer 7.5, nonvanishing off the pole**, in the same language. -/
example {t : ℝ} (ht : t ≠ 0) :
    meromorphicOrderAt riemannZeta (1 + t * I) = (0 : WithTop ℤ) := sorry

/-- **Layer 7.5, nonvanishing for a nontrivial character**: order `0` at every point of the
line, including `s = 1`, where there is no pole. This is the shape the ray-class and
cyclotomic families are stated in. -/
example {N : ℕ} [NeZero N] {χ : DirichletCharacter ℂ N} (hχ : χ ≠ 1) (t : ℝ) :
    meromorphicOrderAt (DirichletCharacter.LFunction χ) (1 + t * I) = (0 : WithTop ℤ) :=
  sorry

open scoped Classical in
/-- **Layer 7.6, the ideal von Mangoldt weight**: `log 𝔑𝔭` at a prime power `𝔭^m`, and `0`
otherwise. The coefficient function of `-ζ_K'/ζ_K`. -/
noncomputable def idealVonMangoldt (I : Ideal (𝓞 K)) : ℂ :=
  if h : ∃ (𝔭 : HeightOneSpectrum (𝓞 K)) (m : ℕ), 0 < m ∧ I = 𝔭.asIdeal ^ m then
    Real.log (Ideal.absNorm h.choose.asIdeal)
  else 0

/-- **Layer 7.6, the logarithmic derivative of `ζ_K`** as a Dirichlet series on `Re s > 1`,
in the shape of Mathlib's `LSeries_vonMangoldt_eq_deriv_riemannZeta_div`. -/
example {s : ℂ} (hs : 1 < s.re) :
    LSeries (idealCoeffOfWeight K (idealVonMangoldt K)) s =
      -deriv (dedekindZeta K) s / dedekindZeta K s := sorry

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

/-- **Layer 8/9, natural density** for a set of primes of `𝓞 K`, by counting primes of
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

variable (L : Type*) [Field L] [NumberField L] [Algebra K L] [FiniteDimensional K L]
variable (G : Type*) [Group G] [Finite G] [MulSemiringAction G (𝓞 L)]
variable [SMulCommClass G (𝓞 K) (𝓞 L)] [Algebra.IsInvariant (𝓞 K) (𝓞 L) G]
variable [FaithfulSMul G (𝓞 L)]

/-- **Layer 8D.5, the Chebotarev density theorem over a general number field.**

The base is an arbitrary `K`, the prime set is cut out over `HeightOneSpectrum (𝓞 K)`, and
unramifiedness is the shared predicate `ramificationIdxIn = 1` rather than a divisibility
test against a discriminant. `G` acts faithfully on `𝓞 L` with invariants `𝓞 K`;
faithfulness is doing real work, since invariance alone lets a group act through a quotient —
even trivially — and the density claim is then false. With it, `G ≅ Gal(L/K)`, and
instantiating `G = L ≃ₐ[K] L` through `galRestrict` is part of the milestone.

⚠ The public form of this theorem is over the number field arithmetic roadmap's
`frobeniusClass`, which does not exist at the pin. Its intended signature, in that roadmap's
vocabulary, is

```text
HasDirichletDensity
  {𝔭 : HeightOneSpectrum (𝓞 K) | UnramifiedIn K L 𝔭.asIdeal ∧ frobeniusClass K L 𝔭.asIdeal = C}
  (Nat.card C.carrier / Nat.card Gal(L/K))
```

for `C : ConjClasses Gal(L/K)`. This roadmap creates no rival `frobeniusClass`; when that
one exists, the statement below is restated over it and the version here becomes the
abstract-group generalization. -/
example (σ : G) :
    HasDirichletDensity K
      {𝔭 : HeightOneSpectrum (𝓞 K) |
        Ideal.ramificationIdxIn 𝔭.asIdeal (𝓞 L) = 1 ∧
        ∃ Q : Ideal (𝓞 L), Q.IsPrime ∧ Q.under (𝓞 K) = 𝔭.asIdeal ∧
          ∃ τ : G, IsArithFrobAt (𝓞 K) τ Q ∧ IsConj σ τ}
      ((Nat.card {τ : G // IsConj σ τ} : ℝ) / (Nat.card G : ℝ)) := sorry

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
example (a : ℕ → ℝ) (F : ℂ → ℂ) (κ : ℝ) (ha : ∀ n, 0 ≤ a n)
    (hF : ∀ s : ℂ, 1 < s.re → F s = LSeries (fun n ↦ (a n : ℂ)) s)
    (hFc : ContinuousOn (fun s : ℂ ↦ F s - κ / (s - 1)) {s : ℂ | 1 ≤ s.re}) :
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

/-- **Layer 9.7, the Tauberian asymptotic for a nontrivial character**, the quantitative form
of Layer 8B and the input the natural-density argument runs on. Here `κ = 0`, and the
continuous extension to `Re s ≥ 1` is Layer 7.5 for `χ`. The Dirichlet-density statement of
Layer 8 is *not* enough for this. -/
example (χ : IdealWeight K) (hχ : HasCancellation K χ) :
    Tendsto
      (fun x : ℝ ↦
        (∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ x},
          (χ.toFun I * idealVonMangoldt K I).re) / x)
      atTop (𝓝 0) := sorry

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
