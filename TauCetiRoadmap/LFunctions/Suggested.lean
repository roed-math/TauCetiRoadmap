import Mathlib

/-!
# L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–10, the pinned conventions — including the Hecke-theta
route decision —, the instance ledger, the worked examples, and the references) is in
`README.md`. Mathlib has the Loeffler–Stoll `LSeries` stack with the ζ and Dirichlet
functional equations, Roblot's `dedekindZeta` with the class number formula, and the
`IsArithFrobAt` Frobenius vocabulary — but no L-function data model, no Dedekind
continuation or FE, no Hecke L-functions, no density notions, and no Chebotarev. We build
that in `TauCeti/`.

This file holds pin-elaborating targets from **Layer 0** (the data model with its ζ and
Dirichlet instance cards), **Layer 1** (the ideal-norm coefficient bridge, Euler products,
the ℚ-instance), **Layer 3** (continuation and FE of the Dedekind zeta function, in
`∃`-form since the continued objects do not exist yet), **Layer 4** (the `ℚ(i)`
factorization), **Layer 7** (Landau's theorem), **Layers 8–9** (density definitions,
Chebotarev, the prime ideal theorem), stated with `sorry` against the pinned Mathlib. Per
the honest-`sorry` rule, milestones whose *statements* need API that does not exist at the
pin are **not** stated here and live in `README.md` only: the lattice-theta engine and the
level-`N` FE frame (Layer 2 — no dual-lattice or level vocabulary at the pin), Hecke
L-functions of ray-class characters and Grossencharacters (Layers 5–6 — the characters are
the GlobalClassFieldTheory sibling's, in preparation), ray-class nonvanishing (Layer 7),
and the zeros program (Layer 10). As those layers make their types expressible in
`TauCeti/`, add their milestones here with `sorry`.
-/

namespace TauCetiRoadmap.LFunctions

open Complex NumberField NumberField.InfinitePlace Filter Topology Asymptotics
open IsDedekindDomain (HeightOneSpectrum)

/-! ## Layer 0: the L-function data model -/

/-- **Layer 0, the data an LMFDB L-function carries** (prototype; the axioms are the
separate predicate `IsStandard` below, since instances satisfy different subsets).
Conventions (see `README.md`): the completed function *includes* the conductor power
`N^{s/2}`, so the functional equation is constant-free; spectral parameters are the
`Gammaℝ`/`Gammaℂ` shift multisets; the polar locus is carried as data (a set, finite by
axiom), empty for entire instances. -/
structure LFunctionData where
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
  /-- The polar locus of `Λ`. -/
  poles : Set ℂ

namespace LFunctionData

/-- The degree, determined by the Gamma data. -/
def degree (d : LFunctionData) : ℕ := d.gammaR.card + 2 * d.gammaC.card

/-- The archimedean factor `γ(s) = ∏ Gammaℝ (s + μ) · ∏ Gammaℂ (s + ν)`. -/
noncomputable def gammaFactor (d : LFunctionData) (s : ℂ) : ℂ :=
  (d.gammaR.map fun μ ↦ Gammaℝ (s + μ)).prod * (d.gammaC.map fun ν ↦ Gammaℂ (s + ν)).prod

/-- The conjugate-dual completed function `Λ^∨(s) = conj (Λ (conj s))`; the dual of an
instance is the instance with conjugate coefficients, and the functional equation relates
`Λ(s)` to `Λ^∨(1 − s)`. -/
noncomputable def dualCompleted (d : LFunctionData) (s : ℂ) : ℂ :=
  starRingEnd ℂ (d.completed (starRingEnd ℂ s))

/-- **Layer 0, the axioms** an LMFDB-standard L-function satisfies, as a predicate on the
data. The Ramanujan bound is the on-average form (provable for every instance in the
ledger); pointwise bounds are instance-specific and not axioms. -/
structure IsStandard (d : LFunctionData) : Prop where
  coeff_one : d.coeff 1 = 1
  degree_pos : 0 < d.degree
  poles_finite : d.poles.Finite
  norm_rootNumber : ‖d.rootNumber‖ = 1
  completes : ∀ s : ℂ, 1 < s.re →
    d.completed s = ((d.conductor : ℕ) : ℂ) ^ (s / 2) * d.gammaFactor s * LSeries d.coeff s
  differentiableAt : ∀ s : ℂ, s ∉ d.poles → DifferentiableAt ℂ d.completed s
  functional_equation : ∀ s : ℂ, d.completed s = d.rootNumber * d.dualCompleted (1 - s)
  coeff_avg : ∀ δ : ℝ, 0 < δ →
    (fun n : ℕ ↦ ∑ k ∈ Finset.Icc 1 n, ‖d.coeff k‖) =O[atTop] fun n ↦ (n : ℝ) ^ (1 + δ)

end LFunctionData

/-- **Layer 0/1, Euler product of Galois type** for a coefficient sequence: multiplicative,
with a local factor at each prime that is (the reciprocal of) a polynomial of degree at
most `d` in `p^{-s}` with constant term `1`. Bad primes are exactly those where the degree
drops. -/
structure IsGaloisEulerProduct (a : ℕ → ℂ) (d : ℕ) : Prop where
  mult : ∀ ⦃m n : ℕ⦄, m.Coprime n → a (m * n) = a m * a n
  localFactor : ∀ p : ℕ, p.Prime → ∃ P : Polynomial ℂ,
    P.coeff 0 = 1 ∧ P.natDegree ≤ d ∧
    ∀ s : ℂ, 1 < s.re →
      HasSum (fun k : ℕ ↦ a (p ^ k) * (p : ℂ) ^ (-(k : ℂ) * s))
        (Polynomial.eval ((p : ℂ) ^ (-s)) P)⁻¹

/-- **Layer 0, the ζ instance card**: degree 1, conductor 1, `gammaR = {0}`, `ε = 1`,
`Λ = completedRiemannZeta`, poles `{0, 1}`. Validates the model against the pin's
`completedRiemannZeta_one_sub` and `differentiableAt_completedZeta`. -/
noncomputable def riemannZetaData : LFunctionData where
  coeff _ := 1
  conductor := 1
  gammaR := {0}
  gammaC := 0
  rootNumber := 1
  completed := completedRiemannZeta
  poles := {0, 1}

/-- **Layer 0, non-vacuity**: the ζ card is standard. (The functional-equation field needs
the conjugation symmetry of `completedRiemannZeta` on top of
`completedRiemannZeta_one_sub`; conjugation-symmetry lemmas are in motion on Mathlib
master.) -/
example : riemannZetaData.IsStandard := sorry

/-- **Layer 0, the Dirichlet root number has absolute value 1** — asserted in the pin's
docstring for `DirichletCharacter.rootNumber` but not proved there; the first gap the
instance ledger finds. Route: `gaussSum_mul_gaussSum_eq_card`. -/
example {N : ℕ} [NeZero N] {χ : DirichletCharacter ℂ N}
    (hχ : DirichletCharacter.IsPrimitive χ) :
    ‖DirichletCharacter.rootNumber χ‖ = 1 := sorry

/-- **Layer 0, the Dirichlet instance card's functional equation, conductor-included**:
with `Λ(χ, s) := N^{s/2} · completedLFunction χ s`, the pin's FE
(`DirichletCharacter.IsPrimitive.completedLFunction_one_sub`, which carries `N^{s − 1/2}`)
becomes constant-free with dual character `χ⁻¹`. -/
example {N : ℕ} [NeZero N] {χ : DirichletCharacter ℂ N}
    (hχ : DirichletCharacter.IsPrimitive χ) (s : ℂ) :
    (N : ℂ) ^ ((1 - s) / 2) * DirichletCharacter.completedLFunction χ (1 - s) =
      DirichletCharacter.rootNumber χ *
        ((N : ℂ) ^ (s / 2) * DirichletCharacter.completedLFunction χ⁻¹ s) := sorry

/-! ## Layer 1: ideal-indexed series and Euler products -/

variable (K : Type*) [Field K] [NumberField K]

/-- **Layer 1, the norm-coefficient bridge**: the number of integral ideals of norm `n`,
as a named coefficient function (the pin inlines it in `NumberField.dedekindZeta`). -/
noncomputable def idealCoeff : ℕ → ℂ :=
  fun n ↦ (Nat.card {I : Ideal (𝓞 K) // Ideal.absNorm I = n} : ℂ)

/-- The bridge equation: `dedekindZeta` is the L-series of `idealCoeff`. -/
example : dedekindZeta K = LSeries (idealCoeff K) := sorry

/-- **Layer 1, multiplicativity** of the ideal-counting coefficient (unique factorization
of ideals; unproved at the pin). -/
example {m n : ℕ} (h : m.Coprime n) :
    idealCoeff K (m * n) = idealCoeff K m * idealCoeff K n := sorry

/-- **Layer 1, the Euler product of the Dedekind zeta function** over the primes of `𝓞 K`
(absent at the pin). -/
example {s : ℂ} (hs : 1 < s.re) :
    HasProd (fun 𝔭 : HeightOneSpectrum (𝓞 K) ↦
      (1 - (Ideal.absNorm 𝔭.asIdeal : ℂ) ^ (-s))⁻¹) (dedekindZeta K s) := sorry

/-- **Layer 1, the abscissa**: the Dedekind zeta series converges absolutely exactly for
`Re s > 1`. -/
example : LSeries.abscissaOfAbsConv (idealCoeff K) = 1 := sorry

/-- **Layer 1/3, worked example (`K = ℚ`)**: on the convergence half-plane the Dedekind
zeta function of `ℚ` is the Riemann zeta function. ⚠ Off `Re s > 1` the raw `LSeries` is
a junk value `0`, so this is *false* globally for `dedekindZeta`; only the continued
object of Layer 3 equals `riemannZeta` everywhere. -/
example {s : ℂ} (hs : 1 < s.re) : dedekindZeta ℚ s = riemannZeta s := sorry

/-! ## Layer 3: Dedekind zeta — continuation and functional equation

Stated in `∃`-form: the continued objects (`dedekindZetaC`, `completedDedekindZeta`) do
not exist at the pin; building them *is* the layer, and these statements pin their
defining properties. -/

/-- **Layer 3, analytic continuation of `ζ_K`** with its unique simple pole at `s = 1`,
whose residue is the pin's `dedekindZeta_residue` — upgrading the pin's real-limit class
number formula (`tendsto_sub_one_mul_dedekindZeta_nhdsGT`) to a genuine complex residue. -/
example :
    ∃ Z : ℂ → ℂ,
      (∀ s : ℂ, 1 < s.re → Z s = dedekindZeta K s) ∧
      (∀ s : ℂ, s ≠ 1 → DifferentiableAt ℂ Z s) ∧
      Tendsto (fun s : ℂ ↦ (s - 1) * Z s) (𝓝[≠] 1)
        (𝓝 (dedekindZeta_residue K : ℂ)) := sorry

/-- **Layer 3, the completed Dedekind zeta function and its functional equation**
(Hecke; Neukirch VII (5.10)): `Λ_K(s) = |d_K|^{s/2} Γ_ℝ(s)^{r₁} Γ_ℂ(s)^{r₂} ζ_K(s)` on
the convergence half-plane, holomorphic on `ℂ ∖ {0, 1}`, with the self-dual equation
`Λ_K(1 − s) = Λ_K(s)`. -/
example :
    ∃ Λ : ℂ → ℂ,
      (∀ s : ℂ, 1 < s.re →
        Λ s = ((|discr K| : ℤ) : ℂ) ^ (s / 2) * Gammaℝ s ^ nrRealPlaces K *
          Gammaℂ s ^ nrComplexPlaces K * dedekindZeta K s) ∧
      (∀ s : ℂ, s ≠ 0 → s ≠ 1 → DifferentiableAt ℂ Λ s) ∧
      (∀ s : ℂ, Λ (1 - s) = Λ s) := sorry

/-! ## Layer 4: special values — the `ℚ(i)` factorization -/

/-- The primitive quadratic character mod 4, with values in `ℂ` (the pin's `ZMod.χ₄`
composed along `ℤ → ℂ`). -/
noncomputable def χ₄C : DirichletCharacter ℂ 4 :=
  ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)

/-- **Layer 4, worked example, coefficient level**: in `ℚ(i)` the number of ideals of
norm `n ≠ 0` is `∑_{e ∣ n} χ₋₄(e)` (the splitting law at every prime, including the
ramified prime `2`). -/
example (F : Type*) [Field F] [NumberField F] [IsCyclotomicExtension {4} ℚ F]
    {n : ℕ} (hn : n ≠ 0) :
    idealCoeff F n = ∑ e ∈ n.divisors, χ₄C (e : ZMod 4) := sorry

/-- **Layer 4, worked example, function level**: `ζ_{ℚ(i)} = ζ · L(χ₋₄)` as an identity
of L-series on the convergence half-plane (and, after Layer 3, of the continued
functions everywhere). -/
example (F : Type*) [Field F] [NumberField F] [IsCyclotomicExtension {4} ℚ F]
    {s : ℂ} (hs : 1 < s.re) :
    dedekindZeta F s = riemannZeta s * DirichletCharacter.LFunction χ₄C s := sorry

/-! ## Layer 7: the Landau toolkit -/

open scoped ComplexOrder in
/-- **Layer 7, Landau's theorem** (absent at the pin; the engine behind the real-character
nonvanishing and the density dichotomies): a Dirichlet series with nonnegative
coefficients has a genuine singularity at its abscissa of absolute convergence — no
function holomorphic on a neighborhood of the abscissa agrees with it on the half-plane
of convergence. -/
example {a : ℕ → ℂ} (ha₀ : 0 ≤ a) {x₀ : ℝ}
    (hx : LSeries.abscissaOfAbsConv a = (x₀ : EReal)) :
    ¬ ∃ (U : Set ℂ) (F : ℂ → ℂ), IsOpen U ∧ (x₀ : ℂ) ∈ U ∧ DifferentiableOn ℂ F U ∧
      Set.EqOn F (LSeries a) (U ∩ {s : ℂ | x₀ < s.re}) := sorry

/-! ## Layers 8–9: densities and the Chebotarev density theorem -/

/-- **Layer 8, Dirichlet density** for a set of primes of `𝓞 K`:
`d(P) = lim_{s→1⁺} (∑_{𝔭 ∈ P} 𝔑𝔭^{-s}) / log (1/(s−1))`, along real `s ↓ 1`. Alignment
obligation: adopt the spelling of Mathlib PR #41765 (`NumberField.DirichletDensity`) when
it merges. -/
noncomputable def HasDirichletDensity
    (P : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  Tendsto
    (fun s : ℝ ↦ (∑' 𝔭 : P, (Ideal.absNorm (𝔭 : HeightOneSpectrum (𝓞 K)).asIdeal : ℝ) ^ (-s)) /
      Real.log ((s - 1)⁻¹))
    (𝓝[>] 1) (𝓝 δ)

/-- **Layer 8/9, natural density** for a set of primes of `𝓞 K`, by counting primes of
bounded norm. -/
noncomputable def HasNaturalDensity
    (P : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) : Prop :=
  Tendsto
    (fun x : ℝ ↦
      (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) //
          𝔭 ∈ P ∧ (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ) /
      (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ))
    atTop (𝓝 δ)

/-- **Layer 8, natural density implies Dirichlet density**, with the same value (Abel
summation). ⚠ The converse is false; every density statement in this roadmap names its
density. -/
example (P : Set (HeightOneSpectrum (𝓞 K))) (δ : ℝ) (h : HasNaturalDensity K P δ) :
    HasDirichletDensity K P δ := sorry

/-- **Layer 8, the Chebotarev density theorem** (Dirichlet-density form), stated in the
pin's Frobenius vocabulary (`IsArithFrobAt`, arithmetic normalization — the LocalFields
convention) over the invariant-algebra setting of `Mathlib/RingTheory/Frobenius.lean`.
Here `G` is an abstract finite group acting **faithfully** on `𝓞 L` with invariants `ℤ`
(faithfulness is load-bearing: invariance alone lets a group act through a quotient — even
trivially when `L = ℚ` — and the density claim is then false; with faithfulness the two
force `G ≅ Gal(L/ℚ)`) — instantiating `G = L ≃ₐ[ℚ] L` via `galRestrict` is part of the
milestone; the general base `K` replaces `ℤ` by `𝓞 K`. The set is cut out by rational primes `p`, unramified (say `p ∤ disc L`),
admitting a prime `Q` above them whose Frobenius is conjugate to `σ`; its Dirichlet
density is `#⟨σ⟩_conj / #G`. Pinned route: cyclotomic case → crossing → Deuring reduction
(CFT-free; see `README.md` Layer 8 and the coordination obligations). -/
example (L : Type*) [Field L] [NumberField L] (G : Type*) [Group G] [Finite G]
    [MulSemiringAction G (𝓞 L)] [SMulCommClass G ℤ (𝓞 L)]
    [Algebra.IsInvariant ℤ (𝓞 L) G] [FaithfulSMul G (𝓞 L)] (σ : G) :
    Tendsto
      (fun s : ℝ ↦
        (∑' p : {p : ℕ | p.Prime ∧ ¬ (p : ℤ) ∣ discr L ∧
            ∃ Q : Ideal (𝓞 L), Q.IsPrime ∧ Q.under ℤ = Ideal.span {(p : ℤ)} ∧
              ∃ τ : G, IsArithFrobAt ℤ τ Q ∧ IsConj σ τ},
          ((p : ℕ) : ℝ) ^ (-s)) / Real.log ((s - 1)⁻¹))
      (𝓝[>] 1)
      (𝓝 ((Nat.card {τ : G // IsConj σ τ} : ℝ) / (Nat.card G : ℝ))) := sorry

/-- **Layer 9, worked example (natural-density Chebotarev for `ℚ(ζ₅)/ℚ`, i.e. Dirichlet's
theorem mod 5 with density)**: the primes `p ≡ a (mod 5)` have natural density `1/4` —
strictly stronger than the pin's `Nat.infinite_setOf_prime_and_eq_mod`, which becomes a
corollary. -/
example (a : (ZMod 5)ˣ) :
    Tendsto
      (fun n : ℕ ↦
        (Nat.card {p : ℕ // p ≤ n ∧ p.Prime ∧ (p : ZMod 5) = (a : ZMod 5)} : ℝ) /
          (Nat.primeCounting n : ℝ))
      atTop (𝓝 (1 / 4)) := sorry

/-- **Layer 9, the prime ideal theorem** `π_K(x) ∼ x / log x` (Landau) — the Tauberian
input is consumed from PrimeNumberTheoremAnd (`WienerIkeharaTheorem'`), never re-proved;
at `K = ℚ` this specializes to the prime number theorem and must agree with that
project's statements. -/
example :
    Tendsto
      (fun x : ℝ ↦
        (Nat.card {𝔭 : HeightOneSpectrum (𝓞 K) // (Ideal.absNorm 𝔭.asIdeal : ℝ) ≤ x} : ℝ) /
          (x / Real.log x))
      atTop (𝓝 1) := sorry

end TauCetiRoadmap.LFunctions
