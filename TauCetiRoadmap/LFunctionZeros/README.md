# Roadmap: zeros of L-functions — growth, zero-free regions, counting, and the explicit formula

The zeros of an L-function are what the LMFDB's L-function pages are mostly about, and they
are the part of the analytic theory that Mathlib has least of. In the Mathlib the
repository currently builds, the only zeros in the library are `riemannZetaZeros`, known to be
closed and discrete (`isDiscrete_riemannZetaZeros`, `IsCompact.inter_riemannZetaZeros_finite`),
together with the classical trivial zeros and the `RiemannHypothesis` `Prop`. There is no
zero counting, no zero-free region, no explicit formula, and no way to say that a computed
list of zeros is complete.

The complex analysis needed is in better shape than that suggests. Mathlib has Jensen's
formula (`MeromorphicOn.circleAverage_log_norm`) and the disc zero bound it implies
(`AnalyticOnNhd.sum_divisor_le`), Phragmén–Lindelöf on horizontal and vertical strips
(`Complex.PhragmenLindelof.vertical_strip`), the Hadamard three-lines theorem, holomorphic
branches of the logarithm on simply connected sets
(`Complex.exists_continuousOn_eqOn_exp_comp`), and — the piece that matters most for stating
anything about zeros correctly — the divisor of a meromorphic function,
`MeromorphicOn.divisor f U : Function.locallyFinsuppWithin U ℤ`, which records order with
sign and multiplicity. What is missing is the growth theory: nothing in Mathlib bounds
`Complex.Gamma` on a vertical strip, nothing defines the order of an entire function, and
there is no Hadamard factorization. The contour theory is missing too — no argument
principle, no winding number, no residue theorem — but that is the
[contour integration roadmap](../ContourIntegration/README.md)'s to build, and Layers 7 and 8
here consume it rather than repeating it.

This roadmap builds the zeros program on top of the completed L-functions produced by the
[L-functions roadmap](../LFunctions/README.md): the growth theory of the completed function,
the analytic conductor, zero counting with multiplicity, the classical zero-free regions, the
Riemann–von Mangoldt formula, the explicit formula, and the semantics of a certified list of
zeros.

Home: `TauCeti/NumberTheory/LFunctions/Zeros/`, with subdirectories per layer
(`Growth/`, `GammaAsymptotics/`, `AnalyticConductor/`, `Convexity/`, `Counting/`,
`Hadamard/`, `ZeroFree/`, `ExplicitFormula/`, `Certificates/`).

## Scope

### In scope

Every numbered milestone in *The build, in layers*. In one sentence: the analytic theory of
the zeros of a completed L-function that has already been shown to continue meromorphically
and satisfy a functional equation, for the two families where that theory is classical —
the Dedekind zeta function of a number field, and the L-function of a finite-order Hecke
character — plus the general growth, counting, and certificate machinery that those two
instantiate.

### Out of scope

- Constructing L-functions, continuing them, or proving functional equations. All of that is
  the L-functions roadmap's, and this roadmap consumes its output.
- Any statement about the zeros of an L-function whose continuation has not been proved.
  There is no zero theorem here for a bare record of data satisfying the L-functions
  roadmap's predicates: each zero-free region and each counting formula names its family.
- Proving the Riemann hypothesis, the generalized Riemann hypothesis, or the nonexistence of
  Siegel zeros. GRH is stated as a `Prop`; the zero-free region theorems carry an explicit
  exceptional-zero disjunction and no milestone removes it.
- Identifying an exceptional zero as the zero of a quadratic character's L-function. That is
  a Stark-type theorem with its own hypotheses; Layer 6 states only what the zero-free region
  argument proves, namely that at most one such zero exists and that it is real and simple.
- Interval arithmetic, numerical evaluation, and decision procedures for discharging a zero
  certificate. The *semantics* of a certificate is in scope (Layer 9); nothing here proves a
  numerical fact about a particular zero, and no acceptance criterion below asks for one.
- The residue calculus itself: winding numbers, residues, the residue theorem, and the
  homology form of Cauchy's theorem. Those are the
  [contour integration roadmap](../ContourIntegration/README.md)'s. Layer 7 specializes them
  to rectangles and identifies the resulting count with Layer 4's divisor sum; nothing here
  re-derives them.
- Weierstrass factorization at genus above zero: the elementary factors `E_p` for `p ≥ 2`,
  canonical products of higher genus, and Hadamard's theorem beyond order `1`. A completed
  L-function has order `1`, and Layer 5 is stated there.
- Effective and explicit constants. The zero-free regions here are of the shape
  `σ > 1 − c/log(q(|t|+2))` with `c` existentially quantified; Lagarias–Odlyzko-style
  effective Chebotarev is not in scope in either roadmap.
- The Selberg class, converse theorems, and degree classification.

### Interfaces supplied to other roadmaps

- **A zero-counting divisor for a completed L-function** (Layer 4), together with the
  distinction this roadmap pins between the signed divisor count and the natural-number zero
  count. Any roadmap wanting "the zeros of `Λ` in a region, with multiplicity" should use
  these rather than a set-theoretic preimage of `{0}`.
- **Growth of `Gammaℝ` and `Gammaℂ` on vertical strips**, and a holomorphic branch of
  `log Γ` on a sector (Layer 1). This is ordinary complex analysis of the Gamma function and
  is useful well outside this roadmap.
- **The analytic conductor** `q(s)` (Layer 2), with the comparison lemmas relating it to
  degree, arithmetic conductor, and spectral parameters. This roadmap owns the general
  definition; the modular forms roadmap displays the same Iwaniec–Kowalski (5.7) quantity for
  a newform without naming it, and Layer 2.4 proves the specialization that matches it.
- **The order predicate, the Weierstrass elementary factor `E₁`, and Hadamard factorization
  at order at most one** (Layer 5), stated for a general entire function rather than only
  for `Λ`.
- **The rectangle as a contour** (Layer 7.1–7.3): the positively oriented boundary of a
  closed rectangle as a closed piecewise-`C¹` curve, its winding numbers, its null-homology,
  the resulting argument principle, and the continuous argument lift along a nonvanishing
  image curve. These are generic complex analysis rather than L-function mathematics, and this
  roadmap owns them: the contour integration roadmap builds the residue calculus for a general
  cycle, and the rectangle interface on top of it is built and exported here.

## Dependencies

| Dependency | Material consumed here | First consuming layer | Kind |
|---|---|---:|---|
| [L-functions roadmap](../LFunctions/README.md) Layer 0 | `AnalyticLFunctionData` with its `polarOrder`, `degree`, `gammaFactor`, `dualCompleted`, and the predicates `HasDirichletAgreement`, `HasMeromorphicContinuation`, `HasFunctionalEquation`, `HasAverageCoefficientBound` | 0 | hard |
| L-functions roadmap Layer 0 | `ArithmeticLFunctionData` and `NormalizationTranslation` with its `gammaR_eq`, `gammaC_eq`, `completed_eq`, which is what makes "critical line" well defined | 0 | hard |
| L-functions roadmap Layer 1 | `idealCoeff`, `idealCoeffOfWeight`, `HasEulerProduct`, the nonvanishing on `Re s > 1`, and `LSeries.abscissaOfAbsConv (idealCoeff K) = 1`, which is where the lower bound Jensen's formula needs comes from | 4 | hard |
| L-functions roadmap Layer 3 | the completed Dedekind zeta function, its exact poles at `0` and `1`, its functional equation, and the Mellin representation Layer 3.4 turns into finite order | 3 | hard |
| L-functions roadmap Layer 4 | the completed factorizations `ζ_K = ζ · L(χ_d)` for quadratic `K` and `ζ_{ℚ(ζₙ)} = ∏ L(χ)`, with the normalization lemma turning an equality of functions into additivity of divisors | 6 | hard |
| L-functions roadmap Layer 5 | completed Hecke L-functions of primitive finite-order ray-class characters, entire, with `‖W(χ)‖ = 1`, and their Mellin representation | 3 | hard |
| L-functions roadmap Layer 7 | nonvanishing on `Re s = 1` in meromorphic-order form (its 7.5), and the `3-4-1` positivity argument this layer makes quantitative (its 7.4) | 6 | hard |
| L-functions roadmap Layer 7 | the ideal von Mangoldt coefficients and `−ζ'_K/ζ_K` as their Dirichlet series (its 7.6) | 8 | hard |
| [Contour integration roadmap](../ContourIntegration/README.md) Layers 0–4 | `windingNumber`, `residue`, `HasCauchyPV`, `IsPwC1ImmersionOn`, `IsNullHomologous`, `ConditionAprime`, `ConditionB`, `windingNumber_circle`, `argumentPrinciple_local`, and above all the general null-homologous-cycle theorem `hungerbuhlerWasem_residueTheorem` (its Layer 4), which is the first exact statement there that applies to a rectangle: its `argumentPrinciple` and `classicalResidueTheorem_circle` are circle-only | 7 | hard |
| [Modular forms roadmap](../ModularForms/README.md) Layer 7 | the newform analytic conductor `𝔮(f,s)`, a displayed Iwaniec–Kowalski (5.7) formula there with no declaration; this roadmap owns the general `analyticConductorAt` and 2.4 proves the newform specialization | 2 | convention only |
| Mathlib `Analysis/Complex/JensenFormula.lean` | `MeromorphicOn.circleAverage_log_norm`, `AnalyticOnNhd.sum_divisor_le` | 4 | existing |
| Mathlib `Analysis/Meromorphic/Divisor.lean`, `Topology/LocallyFinsupp.lean` | `MeromorphicOn.divisor`, its restriction and positive part, and local finiteness of the support | 4 | existing |
| Mathlib `Analysis/Complex/PhragmenLindelof.lean` | `vertical_strip` and the three-lines theorem | 3 | existing |
| Mathlib `Analysis/Complex/BranchLogRoot.lean` | `Complex.exists_continuousOn_eqOn_exp_comp`, the branch of `log` on a simply connected set | 1 | existing |
| Mathlib `Analysis/Normed/Module/MultipliableUniformlyOn.lean`, `Analysis/Calculus/LogDerivUniformlyOn.lean` | `multipliableLocallyUniformlyOn_one_add`, `logDeriv_tprod_eq_tsum` | 5 | existing |
| Mathlib `Analysis/Complex/BorelCaratheodory.lean` | `Complex.borelCaratheodory` | 5 | existing |

The L-functions roadmap ends at its prime-counting layer and states this roadmap as its
successor; nothing here is duplicated there.

## Standing hypotheses and conventions

| object | convention |
|---|---|
| normalization | Everything is stated in the **analytic** normalization: the functional equation reflects in `s ↦ 1 − s`, the critical strip is `0 ≤ Re s ≤ 1`, and the critical line is `Re s = 1/2`. An arithmetic-normalized instance reaches these theorems through the L-functions roadmap's translation, and every statement about the critical line for such an instance is that translation applied to a theorem here — never a restatement with a shifted line. |
| order and vanishing | Order is `meromorphicOrderAt f z : WithTop ℤ`, and the divisor is `MeromorphicOn.divisor f U`. "`f` has a zero of order `m` at `ρ`" is `meromorphicOrderAt f ρ = (m : WithTop ℤ)` with `0 < m`; "`f` has no zeros on `S`" is `∀ z ∈ S, meromorphicOrderAt f z ≤ 0`; "`f` has no zeros and no poles on `S`", the boundary regularity every contour and every certificate needs, is `∀ z ∈ S, meromorphicOrderAt f z = 0`. ⚠ Never characterize a zero or a pole through the value `f z`. Mathlib's meromorphic functions are total, and at a pole the representative takes a junk value which for `Complex.Gamma` and `Gammaℝ` is `0`; `f z ≠ 0` is therefore neither necessary nor sufficient for regularity. ⚠ `MeromorphicOn.divisor` is likewise total, with junk value `0` where `f` is not meromorphic on `U`, so meromorphy on a stated open set is a hypothesis of every theorem about a count. |
| the two counts | Two deliberately different notions, and no theorem may substitute one for the other. `divisorCount f U R : ℤ` is `∑ᶠ ρ ∈ R, MeromorphicOn.divisor f U ρ` for `R ⊆ U`, in which poles contribute negatively; it is what the argument principle computes. `zeroCount f U R : ℕ` is `∑ᶠ ρ ∈ R, (MeromorphicOn.divisor f U ρ).toNat`, the multiplicities of the *positive* part of the divisor, and is the count of zeros; it is what `N(T)`, the Riemann–von Mangoldt formula, and every certificate use. They agree exactly when `R` contains no pole, which is a hypothesis, never an inference. |
| rectangles | A closed rectangle is `Set.Icc σ₁ σ₂ ×ℂ Set.Icc t₁ t₂` and a half-open one is `Set.Icc σ₁ σ₂ ×ℂ Set.Ioc t₁ t₂`, written with `Complex.reProdIm`; the half-open direction is the imaginary one. Closed rectangles with regular boundary carry contour integrals and certificates; half-open rectangles carry exact subdivisions in height and `N(T)`. The endpoint ordering `σ₁ ≤ σ₂`, `t₁ ≤ t₂` is a hypothesis carried by every statement whose geometry depends on it, not a field of the region: `Set.Icc` of a reversed pair is empty, so the definitions stay total and an invalid rectangle simply has count `0`. Neither spelling is abbreviated to "box" in a statement. |
| counting convention | `N(T)` is `zeroCount` of the *completed* function `Λ` over the half-open rectangle `Icc 0 1 ×ℂ Ioc 0 T`: zeros with `0 < Im ρ ≤ T` and `0 ≤ Re ρ ≤ 1`, with multiplicity. The real axis is excluded by the half-open convention, and a zero at height exactly `T` is counted. The symmetric count over `\|Im ρ\| ≤ T` is a separate named quantity, and the relation between the two is a theorem with explicit reality hypotheses (Layer 4.9), never an assumption. Trivial zeros do not appear: they are the points where the gamma factor has a pole and `L` a compensating zero, and the completed function is regular and nonvanishing there. |
| finite order | An entire `f` has order `≤ A`, written `OrderLE f A`, when `f =O[cobounded] fun s ↦ Real.exp (‖s‖ ^ A')` for every `A' > A`. This predicate is the only notion of order in the roadmap: no numeric order and no type is defined, and no milestone needs one. ⚠ Do not introduce a limsup-of-`log log` order, or the Nevanlinna order `limsup log T(r,f)/log r` read off `ValueDistribution.characteristic`, unless a lemma proves it agrees with `OrderLE`. |
| conductors | Three names, never one. `arithmeticConductor d : ℕ+` is the finite conductor `N` of the data record. `analyticConductorAt d s : ℝ` is the Iwaniec–Kowalski (5.7) quantity `N · ∏_j (\|s + μ_j\| + 3) · ∏_k (\|s + ν_k\| + 3)(\|s + ν_k + 1\| + 3)`, where each `Gammaℂ(s + ν)` contributes the *pair* of shifts `ν, ν + 1` it splits into under duplication rather than the square of one of them. `centralAnalyticConductor d` is `analyticConductorAt d (1/2)`, the central point in the analytic normalization. The `+3` is part of the convention, not a slack constant to be optimized, and `q(s)` in prose always means `analyticConductorAt`. |
| gamma factors | `Complex.Gammaℝ s = π^{-s/2} Γ(s/2)` and `Complex.Gammaℂ s = 2(2π)^{-s} Γ(s)` as in Mathlib, with `Gammaℝ_mul_Gammaℝ_add_one : Gammaℝ s * Gammaℝ (s + 1) = Gammaℂ s`. ⚠ The Gamma function has **no zeros**; it has simple poles, at `s ∈ {0, −2, −4, …}` for `Gammaℝ` and `s ∈ {0, −1, −2, …}` for `Gammaℂ`. Mathlib's total representative is `0` at those poles, and `Gammaℝ_eq_zero_iff` is a statement about that junk value, not about vanishing. All pole statements go through `meromorphicOrderAt`. |

Work with a fixed completed L-function throughout; do not bundle "L-function with a
zero-free region" into a class.

## What Mathlib already has (consume)

- **Jensen's formula and disc zero counts.** `Mathlib/Analysis/Complex/JensenFormula.lean`:
  `MeromorphicOn.circleAverage_log_norm` (the circle average of `log ‖f‖` equals
  `log ‖trailing coefficient‖` plus the counting sum), `AnalyticOnNhd.circleAverage_log_norm`,
  and `AnalyticOnNhd.sum_divisor_le`, which bounds the number of zeros in a disc of radius
  `r` by the maximum modulus on a larger circle *divided by the value at the center*. Every
  counting statement in Layer 4 is proved from this rather than from the argument principle,
  which arrives only in Layer 7 and from another roadmap.
- **Divisors of meromorphic functions.** `Mathlib/Analysis/Meromorphic/Divisor.lean`:
  `MeromorphicOn.divisor f U : Function.locallyFinsuppWithin U ℤ` built from
  `meromorphicOrderAt`, with congruence lemmas, `AnalyticOnNhd.divisor_nonneg`, and
  `MeromorphicOn.divisor_restrict` (restriction along `V ⊆ U`). The positive part `D⁺`
  (`Function.locallyFinsuppWithin.posPart`) is what the natural-valued zero count sums. Local
  finiteness of the support comes from `Function.locallyFinsupp.locallyFiniteSupport` together
  with `LocallyFiniteSupport.finite_inter_support_of_isCompact`
  (`Mathlib/Topology/LocallyFinsupp.lean`), and `Function.locallyFinsuppWithin.finiteSupport`
  is the compact-domain shortcut. Also
  `Meromorphic/{Order,IsolatedZeros,NormalForm,FactorizedRational,TrailingCoefficient}.lean`,
  in particular `MeromorphicOn.extract_zeros_poles`, which writes a meromorphic `f` as
  `(∏ᶠ u, (· − u)^{divisor f U u}) • g` with `g` analytic and nonvanishing, and
  `meromorphicTrailingCoeffAt`.
- **Branches of the logarithm.** `Mathlib/Analysis/Complex/BranchLogRoot.lean`:
  `Complex.exists_continuousOn_eqOn_exp_comp` produces, for a continuous nonvanishing `g` on
  an open simply connected `U`, a continuous `f` on `U` with `exp ∘ f = g`. This is what
  Layer 1 uses for `log Γ` on a sector, what Layer 5 uses for the entire logarithm of a
  nonvanishing entire function, and what Layer 7 uses to lift `arg Λ` continuously along a
  contour; holomorphy of the branch follows from `exp` being a local biholomorphism, and that
  step is a milestone rather than an assumption.
- **Nevanlinna theory, which does not do this roadmap's counting.**
  `Mathlib/Analysis/Complex/ValueDistribution/` has the proximity function, the log-counting
  function `Function.locallyFinsuppWithin.logCounting`, the characteristic function, and the
  First Main Theorem in both parts (`FirstMainTheorem.lean`). ⚠ None of it is a zero count:
  `logCounting` is the `ℝ`-valued log-weighted `N(r) = ∫₀ʳ (n(t) − n(0))/t dt + n(0) log r`,
  every definition centers its discs at the origin, and the theory is discs and circles where
  this roadmap counts in rectangles and in discs centered on the critical line. Layer 4
  therefore keeps its own counts and consumes `AnalyticOnNhd.sum_divisor_le` instead; the
  comparison with `logCounting` is a Layer 4 milestone so that the two counts are relatable
  rather than rival. Mathlib has no unintegrated `n(r,f)`.
- **Infinite products and logarithmic derivatives.** `multipliableLocallyUniformlyOn_one_add`
  and `hasProdLocallyUniformlyOn_one_add`
  (`Analysis/Normed/Module/MultipliableUniformlyOn.lean`) give locally uniform convergence of
  `∏ (1 + f_i)` from a summable dominating sequence; `Analysis/SpecialFunctions/Log/Summable.lean`
  has the log-to-product dictionary and `tprod_one_add_ne_zero_of_summable`;
  `SummableLocallyUniformlyOn.differentiableOn` and `Analysis/Complex/LocallyUniformLimit.lean`
  give holomorphy of the limit; and `logDeriv_tprod_eq_tsum`
  (`Analysis/Calculus/LogDerivUniformlyOn.lean`) differentiates through the product. The whole
  arc is carried out at genus `0` in `Analysis/SpecialFunctions/Trigonometric/Cotangent.lean`,
  from `Complex.multipliable_sineTerm` to `Complex.cot_series_rep`, which is the exact shape of
  Layer 5.
- **Borel–Carathéodory.** `Mathlib/Analysis/Complex/BorelCaratheodory.lean`:
  `Complex.borelCaratheodory` bounds `‖f‖` on a smaller ball from an upper bound on `Re f` on
  a larger one. Layer 5 runs its exponential-factor argument on this rather than rebuilding it.
- **Convexity.** `Mathlib/Analysis/Complex/PhragmenLindelof.lean`
  (`horizontal_strip`, `vertical_strip`, the quadrant and half-plane versions, and the
  `isBigO_sub_exp_rpow` growth hypotheses they take) and
  `Mathlib/Analysis/Complex/Hadamard.lean` (the three-lines theorem).
- **The Gamma function.** `Gamma/{Basic,Beta,BohrMollerup,Deriv,Digamma,Deligne}.lean`:
  `Complex.Gamma`, `Gamma_ne_zero`, the reflection and duplication formulas, `Complex.digamma`,
  and `Gammaℝ`/`Gammaℂ`. ⚠ There is **no** Stirling estimate for `Complex.Gamma`;
  `Analysis/SpecialFunctions/Stirling.lean` is the factorial asymptotic only, and
  `BohrMollerup` is the real characterization. Layer 1 builds this.
- **Zeta zeros.** `Mathlib/NumberTheory/LSeries/ZetaZeros.lean`: `riemannZetaZeros`,
  `isClosed_riemannZetaZeros`, `isDiscrete_riemannZetaZeros`,
  `IsCompact.inter_riemannZetaZeros_finite`; and in `RiemannZeta.lean` the trivial zeros
  `riemannZeta_neg_two_mul_nat_add_one`, `riemannZeta_zero`, and `RiemannHypothesis`.
- **Nonvanishing on the edge.** `LSeries/Nonvanishing.lean`:
  `riemannZeta_ne_zero_of_one_le_re`, `DirichletCharacter.LFunction_ne_zero_of_one_le_re`,
  and the `3-4-1` product bound `norm_LFunction_product_ge_one` — the qualitative statement
  Layer 6 makes quantitative.
- **Complex analysis substrate.** `Analysis/Complex/{RemovableSingularity, AbsMax,
  LocallyUniformLimit, Liouville, CauchyIntegral}.lean`, `Analysis/Analytic/`, and
  `Analysis/SpecialFunctions/Complex/{Log, LogBounds, LogDeriv, Arg}.lean`.

## What is missing (build here)

The order predicate for an entire function and finite order of a completed L-function. A
holomorphic branch of `log Γ` on a sector and the Stirling asymptotics on it: nothing in
Mathlib bounds `Γ(σ + it)` as `|t| → ∞`. The analytic conductor and its comparison lemmas.
Convexity bounds for the model class from Phragmén–Lindelöf. The two zero counts in a
rectangle and the counting function `N(T)`. The Weierstrass elementary factor and the
canonical product indexed by a divisor, Hadamard factorization at order at most one, and the
resulting partial-fraction expansion of `Λ'/Λ`. The quantitative `3-4-1` argument and the de
la Vallée Poussin zero-free region for the Dedekind zeta function and for Hecke L-functions,
with the exceptional-zero disjunction. The Riemann–von Mangoldt formula, in the
degree-and-conductor-uniform form. The truncated Perron formula and the contour shift it runs
on. The explicit formula relating the ideal von Mangoldt sums to a sum over zeros.
Certificate semantics for a verified list of zeros. None of this exists upstream.

⚠ Two of the layers here run on contour integration, and Mathlib has none of it: no argument
principle, no winding number, no Rouché, no residue theorem, and no continuous branch of
`arg` along a path. What Mathlib has is Cauchy–Goursat for a rectangle
(`Complex.integral_boundary_rect_eq_zero_of_differentiableOn`), the Cauchy integral formula
for circles, and Jensen's formula, which gives inequalities for a count rather than the exact
count Layer 7 needs. That material is the
[contour integration roadmap](../ContourIntegration/README.md)'s, whose Layers 0–3 build the
winding number of a closed piecewise-`C¹` curve, residues, the residue theorem, the homology
form of Cauchy's theorem, and the argument principle itself. Consume those; do not re-derive
them. What this roadmap adds on top is the rectangle contour and the argument lift (Layer
7.1–7.3), which that roadmap does not construct, and the Perron-formula machinery (Layer 8).

---

## The build, in layers

Layers 0–5 are general analysis and depend on the L-functions roadmap only for the data
record, with three exceptions that name their family: 3.4 (finite order, from its Mellin
representation), 4.7–4.8 (the local zero count, from its Euler product), and 5.7 (the
partial-fraction corollaries, which need 3.4). Layers 6–8 are the arithmetic payoff and depend
throughout on its Dedekind zeta and Hecke L-function instances; 7 and 8 additionally consume
the contour integration roadmap's residue calculus. Layer 9 depends on Layers 0 and 4A.

### Layer 0: growth predicates and the entire completion

The data record of the L-functions roadmap carries coefficients, conductor, spectral
parameters, root number, a total representative of the completed function, and an exact polar
divisor. It records no growth, which is why no zero theorem can be stated against it as it
stands. This layer adds the growth predicates, proves the reductions between them, and builds
the entire function whose zeros the later layers count.

1. `OrderLE (f : ℂ → ℂ) (A : ℝ) : Prop`, for entire `f`: `∀ A' > A, f =O[cobounded ℂ] fun s ↦ Real.exp (‖s‖ ^ A')`.
   Basic API: closure under sums, products, and multiplication by a polynomial; `OrderLE` for
   `exp`, for polynomials, and for `s ↦ exp (a * s)`; monotonicity in `A`. Entirety is a
   hypothesis of the theorems that use `OrderLE`, not part of the predicate, so that the
   predicate composes.
2. **The entire completion.** ⚠ Not a pointwise product: at a pole the record's total
   representative takes a junk value, so `s ↦ (∏_p (s − p)^{polarOrder p}) · Λ(s)` need not
   take the analytically continued value there, and for the zeta instance the raw product is
   `0` at `0` and `1` — exactly fake zeros where the clearing polynomial is meant to remove
   poles. Build it in this order:
   - the clearing polynomial `P(s) = ∏_{p ∈ polarOrder.support} (s − p)^{polarOrder p}`,
     finite because `polarOrder : ℂ →₀ ℕ`;
   - the product `P · Λ` on `Set.univ \ polarOrder.support`, meromorphic there and analytic;
   - the theorem that each point of `polarOrder.support` is a removable singularity of `P · Λ`
     with `meromorphicOrderAt (P · Λ) p = 0`, from the continuation predicate's
     `meromorphicOrderAt Λ p = −polarOrder p`;
   - `entireCompletion d : ℂ → ℂ`, defined as the analytic extension across that finite set
     (`Complex.analyticAt_of_removable`-style removability plus uniqueness of the extension),
     with the theorem that it agrees with `P · Λ` off the polar support and is entire;
   - `meromorphicOrderAt (entireCompletion d) z = meromorphicOrderAt Λ z + polarOrder z` for
     every `z`, hence `divisor (entireCompletion d) univ = divisor Λ univ + polarOrder`;
   - `entireCompletion d p ≠ 0` at each former pole `p`, which is the content of the polar
     orders being exact.
   The normalizing constant is `1`: for the Dedekind zeta instance `entireCompletion` is
   `s(s−1)Λ_K(s)`, not `s(s−1)Λ_K(s)/2`.
3. `IsFiniteOrder d`: `∃ A, OrderLE (entireCompletion d) A`. ⚠ `IsFiniteOrder → OrderLE _ 1`
   is not free; it is proved per family in Layer 3.4 and the predicate does not assume it.
4. `HasVerticalStripGrowth`: for all `σ₁ σ₂ : ℝ` with `σ₁ < σ₂` there are `C > 0`, `A ≥ 0`,
   and a height threshold `T₀ ≥ 0` with `‖Λ(σ + it)‖ ≤ C (1 + |t|)^A` for `σ ∈ [σ₁, σ₂]` and
   `T₀ ≤ |t|`. ⚠ The threshold is existentially quantified and is not `1`. The data record
   permits an arbitrary finite polar divisor, so a record may have a pole at height `T ≥ 1`,
   and no bound on a strip through that pole can hold: the shifted product
   `s ↦ Λ_ζ(s − iT) Λ_ζ(s + iT)` satisfies every predicate of the model and has poles at
   `1 ± iT`, so a fixed threshold of `1` would make this predicate false for it. The layer's
   main theorem: the predicate follows from `IsFiniteOrder` together with the functional
   equation and the Dirichlet-series bound on `Re s > 1`, by Phragmén–Lindelöf, with `T₀`
   any bound for the imaginary parts of the polar support. Prove the companion statement for
   `entireCompletion d`, where the poles are cleared and every `T₀` works, and for the two
   families prove the concrete threshold `T₀ = 2` from the fact that their polar supports lie
   on the real axis. Later layers hypothesize the predicate and carry its threshold.
5. The relation to the average coefficient bound: a record with the average Ramanujan bound
   has its Dirichlet series bounded on `Re s ≥ 1 + δ`, hence `Λ` of at most polynomial growth
   there. State this so that the vertical-strip bound has a starting edge.
6. **The continued uncompleted L-function.** ⚠ The record carries the coefficients and a total
   representative of the *completed* continuation, and nothing else: `LSeries d.coeff s` is a
   junk value off the half-plane of convergence, so no statement about `L` at `1/2 + it` or on
   the left of the critical strip may be phrased through it. Build
   `continuedL d : ℂ → ℂ` as `Λ(s) / (conductor^{s/2} * γ(s))`, with:
   - meromorphy on `ℂ`, from the continuation predicate and the meromorphy of the reciprocal
     gamma factor, whose divisor is Layer 1.5's;
   - `continuedL d s = LSeries d.coeff s` for `1 < Re s`, which is the Dirichlet-agreement
     predicate and is the *only* place the series representation may be used;
   - the global identity `Λ s = conductor^{s/2} * γ(s) * continuedL d s` as an equality of
     meromorphic germs, including at the poles of `γ`, where the zeros of `continuedL`
     compensate;
   - the translated functional equation, relating `continuedL d s` and `continuedL d (1 − s)`
     through the root number and the gamma quotient;
   - the effect of the normalization translation, from Layer 2.3;
   - agreement with the L-functions roadmap's own continued objects at the Dedekind zeta and
     Hecke instances, so that `continuedL` of the ζ_K record is `dedekindZeta K` extended.
   Every unqualified `L(s)` in later layers means `continuedL d s`.

Acceptance: the predicates elaborate over the L-functions roadmap's record and have the API
of 1; `entireCompletion` satisfies the divisor identity and the nonvanishing of 2 for a record
with an exact polar divisor; `continuedL` satisfies the identity and the agreement of 6; and
the implication of 4 is proved. ⚠ No acceptance criterion here names the Dedekind zeta
instance: finite order for the two families is Layer 3.4, and a layer's acceptance may not
depend on a later one.

### Layer 1: Stirling asymptotics for the gamma factors

Complex analysis with no arithmetic content, and independently Mathlib-worthy. All of it is
missing upstream.

1. **A holomorphic branch.** On the sector `S_δ = {s : |arg s| < π − δ, 1 < ‖s‖}`, which is
   open, simply connected, and free of poles and zeros of `Γ`, define `logGamma δ` by
   `Complex.exists_continuousOn_eqOn_exp_comp` applied to `Γ`, prove `exp ∘ logGamma δ = Γ`
   on `S_δ`, prove it is holomorphic there (`exp` is a local biholomorphism), and pin the
   remaining `2πi ℤ` ambiguity by the equation `logGamma δ 2 = 0`, which is consistent because
   `Γ 2 = 1` and `2 ∈ S_δ`. ⚠ Without that equation the branch is determined only up to
   `2πi k`, which changes the constant term of the asymptotic in 2. ⚠ `Complex.log ∘ Gamma`
   is **not** a branch of
   `log Γ`: nonvanishing of `Γ` does not make the principal logarithm of its image
   continuous, and no milestone may use that composition.
2. `Complex.logGamma_asymptotic`: on `S_δ`,
   `logGamma δ s = (s − 1/2) * Complex.log s − s + Real.log (2π)/2 + O(1/‖s‖)` as `‖s‖ → ∞`,
   with `Complex.log` the principal branch, which is legitimate here because `s` itself stays
   in the slit plane.
3. `Complex.norm_Gamma_asymptotic`: for every compact `[a, b] ⊆ ℝ`,
   `log ‖Γ(σ + it)‖ = (σ − 1/2) * Real.log |t| − π|t|/2 + Real.log (2π)/2 + O(1/|t|)`
   uniformly for `σ ∈ [a, b]`, along the filter `cocompact ℝ` in `t`, that is as `|t| → ∞` in
   both directions. This is the estimate every later layer uses; state it in this additive
   `log ‖·‖` form rather than as a ratio tending to `1`, so that it composes over products.
4. The digamma bound `Complex.digamma s = Complex.log s + O(1/‖s‖)` on `S_δ`, from Mathlib's
   `Complex.digamma` and 2; and the logarithmic derivatives of the gamma factors, exactly:
   `logDeriv Gammaℝ s = (Complex.digamma (s/2))/2 − (Real.log π)/2` and
   `logDeriv Gammaℂ s = Complex.digamma s − Real.log (2π)`.
5. **The gamma factor of a record.** For `γ(s) = ∏_j Gammaℝ(s + μ_j) ∏_k Gammaℂ(s + ν_k)` of
   degree `d = #gammaR + 2 * #gammaC`, and every compact `[a, b]`:
   `log ‖γ(σ + it)‖ = −(π d / 4) |t| + A(σ) * Real.log |t| + O(1)` uniformly for `σ ∈ [a, b]`
   as `|t| → ∞`, where
   `A(σ) = ∑_j (σ + Re μ_j − 1)/2 + ∑_k (σ + Re ν_k − 1/2)`.
   Both constants are part of the milestone; a statement with an unnamed coefficient does not
   discharge it. Also: `γ` has no zeros, and its poles are exactly the points
   `−μ_j − 2n (n : ℕ)` and `−ν_k − n (n : ℕ)`, with the orders read off `meromorphicOrderAt`
   and assembled into the divisor of `γ`.

Acceptance: 5 specializes at `d = 1`, `gammaR = {0}`, `gammaC = ∅` to
`log ‖Gammaℝ(σ + it)‖ = −π|t|/4 + ((σ−1)/2) log |t| + O(1)`, the estimate the Riemann–von
Mangoldt formula for `ζ` runs on.

### Layer 2: the analytic conductor

1. The three definitions of the conventions table: `arithmeticConductor`,
   `analyticConductorAt`, and `centralAnalyticConductor = analyticConductorAt d (1/2)`, with
   `1 ≤ analyticConductorAt d s` and positivity of each factor.
2. **Two-sided comparison on a strip.** For every `a ≤ b` there are `C₁, C₂ > 0`, depending
   only on `a`, `b`, the degree, and a bound on the spectral parameters — and *not* on the
   arithmetic conductor — with
   `C₁ * arithmeticConductor d * (|t| + 3)^d ≤ analyticConductorAt d (σ + it) ≤ C₂ * arithmeticConductor d * (|t| + 3)^d`
   for `σ ∈ [a, b]`. ⚠ Do not state monotonicity in `|Im s|`: with a complex shift `μ`, the
   factor `|s + μ| + 3` decreases as `Im s` approaches `−Im μ`. Eventual monotonicity in `|t|`
   beyond `max_j |Im μ_j| + max_k |Im ν_k|` is a corollary that may be added with those exact
   hypotheses.
3. **The normalization translation, as an equality.** For a `NormalizationTranslation` of
   weight `w`, `analyticConductorAt (analytic) s = analyticConductorAt (arithmetic) (s + w/2)`
   for every `s`, and `arithmeticConductor` is the same on both sides. State it as this
   equality rather than as a statement that "`q` is invariant and the parameters shift".
   ⚠ It holds for one sign convention only, the supplier's `gammaR_eq` and `gammaC_eq`: the
   analytic shifts are the arithmetic ones **plus** `w/2`, which is what
   `Λ_an(s) = N^{−w/4} Λ_ar(s + w/2)` forces. Under `μ_an = μ_ar − w/2` the displayed equality
   is false. Two instance tests are part of this milestone, and neither is optional: at
   `w = 0` every field reduces to `rfl` and the two conductors agree literally; and at a
   weight-`k` newform, arithmetic `gammaC = {0}` becomes analytic `gammaC = {(k−1)/2}`, the
   central points `k/2` and `1/2` correspond, and 4 becomes an identity. A wrong sign is
   invisible until the second test.
4. **The newform specialization, which is where the modular forms roadmap meets this one.**
   This roadmap owns the general `analyticConductorAt` of a record. The modular forms roadmap
   fixes the newform quantity `𝔮(f, s) = N · (|s_an + (k−1)/2| + 3) · (|s_an + (k+1)/2| + 3)`
   as a displayed formula in its Layer 7 and names no declaration for it, so the milestone
   here is the specialization, stated so that it *becomes* the agreement the moment that side
   names its quantity: for the newform record of weight `k` and level `N`, which has
   `gammaR = ∅` and `gammaC = {(k−1)/2}`,
   `analyticConductorAt d s = N * (‖s + (k−1)/2‖ + 3) * (‖s + (k+1)/2‖ + 3)` by unfolding, and
   `centralAnalyticConductor d` is that expression at `s = 1/2`, corresponding to `𝔮(f, k/2)`
   through the translation of 3. ⚠ Prove the displayed unfolding. "The two roadmaps use the
   same convention" is not a theorem, and cannot become one until the other side has a name
   for its quantity.
5. The instances: `arithmeticConductor` is `|d_K|` for the Dedekind zeta record and
   `|d_K| * 𝔑(𝔣)` for a Hecke L-function of primitive conductor `𝔣`. ⚠ These are equalities
   of *arithmetic* conductors; the analytic conductor at a point is that quantity times the
   archimedean factors of 1, and no row of this roadmap equates the two.

### Layer 3: convexity in vertical strips

1. The Phragmén–Lindelöf input, packaged for the model class, and stated for a function with
   **no poles in the strip**: if `g` is holomorphic on a closed strip, of finite order there,
   and bounded by `C(1 + |t|)^{a}` on the left edge and `C(1 + |t|)^{b}` on the right edge,
   then it is bounded by `C'(1 + |t|)^{ℓ(σ)}` on the strip, `ℓ` the linear interpolation.
   Consume `Complex.PhragmenLindelof.vertical_strip`; the work is checking its growth
   hypothesis (`isBigO_sub_exp_rpow`) from `IsFiniteOrder`. ⚠ Apply it to
   `entireCompletion d`, never to `Λ` itself on a strip meeting the polar support: no bound
   holds at a pole, and dividing the conclusion by the clearing polynomial afterwards is what
   produces a statement about `Λ` away from that support.
2. **The convexity bound for the model class**, for `continuedL d` of Layer 0.6 — not for
   `LSeries d.coeff`, which is a junk value at `1/2 + it` — obtained from 1 applied to the
   entire completion and then divided by the clearing polynomial, the conductor factor, and
   the gamma factor through Layer 1.5: for every `ε > 0` there is `C` with
   `‖continuedL d (1/2 + it)‖ ≤ C * analyticConductorAt d (1/2 + it) ^ (1/4 + ε)`
   for every record satisfying continuation, the functional equation, finite order, and the
   average coefficient bound. ⚠ Pin the uniformity: `C` depends on `ε`, on the degree, on a
   bound for the spectral parameters, and on the constant in the average coefficient bound,
   and **not** on the arithmetic conductor. A version whose constant may depend on the
   conductor is a different, weaker theorem and does not discharge this milestone.
3. The trivial bound on `Re s = 1 + δ` from absolute convergence, and the reflected bound on
   `Re s = −δ` from the functional equation, which are the two edges the interpolation uses.
4. **Finite order and vertical-strip growth for the two families.** `entireCompletion` of
   `ζ_K`, and of `Λ(χ, ·)` for a primitive finite-order ray-class character `χ`, satisfies
   `OrderLE _ 1`; with Layer 0.4 both families then satisfy `HasVerticalStripGrowth`. Proof:
   the Mellin representation of the L-functions roadmap's Layers 3 and 5 gives an integral
   bound, which 1 turns into the growth hypothesis `isBigO_sub_exp_rpow` wants, and the
   functional equation reflects it to the left half-plane. This discharges the hypothesis
   Layer 0.3 leaves open. ⚠ It lives here, not in Layer 6, because every later family
   statement needs it: Layer 4.7's local count uses the vertical-strip bound and Layer 5.7's
   corollaries use `OrderLE _ 1`, and both come before the zero-free regions. Its only
   arithmetic input is the Mellin representation, so it needs nothing from Layers 4 to 6.

⚠ Subconvexity is out of scope. No milestone improves the exponent `1/4`.

### Layer 4: zero counting

Items 1–6 are generic complex analysis over an arbitrary meromorphic function (4A in the
dependency graph); 7–8 are the family-specific local count that needs the Euler product (4B);
9–11 are the counting function and its API.

1. `divisorCount f U R : ℤ`, the finsum of `MeromorphicOn.divisor f U` over `R ⊆ U`, and
   `zeroCount f U R : ℕ`, the finsum of the positive part `(MeromorphicOn.divisor f U)⁺`.
   Both take the ambient open `U` on which `f` is meromorphic and the counting region `R`
   separately. Theorems: each is finite when `R` is bounded and `f` is meromorphic on a
   neighborhood of its closure (through `Function.locallyFinsupp.locallyFiniteSupport` and
   `LocallyFiniteSupport.finite_inter_support_of_isCompact`); `divisorCount = zeroCount` when
   `R` contains no pole, stated as `∀ z ∈ R, 0 ≤ divisor f U z`; and both are `0` when `R` is
   empty. ⚠ A `∑ᶠ` over an infinite support is silently `0`, so finiteness is a hypothesis or
   a companion theorem of every statement below, never left implicit.
2. `zeroDivisor`: for a record satisfying the continuation predicate, `divisor Λ U` on an open
   `U`, with the theorem that it is nonnegative away from the polar divisor's support and
   agrees with `−polarOrder` on it; and the identity relating it to
   `divisor (entireCompletion d) univ` from Layer 0.2.
3. **Exact additivity, on half-open rectangles.** For a subdivision of
   `Icc σ₁ σ₂ ×ℂ Ioc t₁ t₃` at a height `t₂` into the two half-open rectangles it splits
   into, the counts add; and likewise for a finite subdivision by heights, since the pieces
   are pairwise disjoint with union the whole. ⚠ Finiteness is a hypothesis: `∑ᶠ` is `0` on
   an infinite support, so the statement carries meromorphy on `U`, containment of the closed
   rectangle in `U`, and finiteness of the divisor support there, and says nothing without
   them. ⚠ The half-open direction is the imaginary one, so this is a subdivision in height.
   A subdivision in `Re s` shares a vertical edge, which the convention leaves closed on both
   sides: state that case either with a half-open real interval as well, or under the
   hypothesis that the shared internal edge carries no zeros or poles
   (`meromorphicOrderAt f z = 0` there). ⚠ The fully closed version is false as stated: two
   closed rectangles sharing an edge both contain a zero on it, so it is counted twice.
4. **Monotonicity and enlargement.** Where the divisor is nonnegative, `R ⊆ R'` gives
   `zeroCount f U R ≤ zeroCount f U R'`, by `MeromorphicOn.divisor_restrict` and summation of
   a nonnegative function. The count is unchanged under enlargement exactly when the divisor
   vanishes on `R' \ R`; ⚠ zero-freeness of the two boundaries is not enough, since the
   region between them can contain zeros.
5. **Jensen's bound on a disc, generic.** From `AnalyticOnNhd.sum_divisor_le` with its actual
   hypotheses — `0 < |r| < |R|`, `1 ≤ M`, `f` analytic on `closedBall c |R|`, `f c ≠ 0`, and
   `‖f‖ ≤ M` on `sphere c |R|` — the count of zeros in `closedBall c |r|`, with multiplicity,
   is at most `Real.log (M / ‖f c‖) / Real.log (R / r)`. Its left-hand side is literally
   `zeroCount` for analytic `f`, so no translation lemma is needed. Its trailing-coefficient
   variant drops `f c ≠ 0` in favor of `log ‖meromorphicTrailingCoeffAt f c‖` on the right
   (`MeromorphicOn.circleAverage_log_norm` already tolerates `f c = 0`, and the ingredients are
   in `JensenFormula.lean`). ⚠ Both forms need a **lower** bound on the denominator to yield a
   numerical count. Growth of `f` alone gives none, and no milestone here claims otherwise.
6. **Box-to-disc reduction.** A closed rectangle lies in the disc through its corners:
   `Icc σ₁ σ₂ ×ℂ Icc t₁ t₂ ⊆ closedBall c r₀` with `c` the center and
   `r₀ = ½√((σ₂ − σ₁)² + (t₂ − t₁)²)`. ⚠ Only upper bounds transfer, by 4 and nonnegativity
   of the divisor; the disc count exceeds the rectangle count by the zeros in the four
   circular segments, and no combination of disc counts is an exact rectangle count.
   Subdividing `Icc 0 1 ×ℂ Ioc t (t + T)` into unit-height rectangles puts each inside the
   disc of radius `√2/2` centered on the critical line at `1/2 + i(t + k + 1/2)`.
7. **The local count for the two families.** For `Λ_K` and for `Λ(χ, ·)` with `χ` a primitive
   finite-order ray-class character, and every `T ≥ 2`, the number of zeros of
   `Λ₀ = entireCompletion` in `closedBall (1/2 + iT) 1` is
   `O(log (analyticConductorAt d (iT)))`. ⚠ What Jensen's bound of 5 consumes is the *ratio*
   `M/‖Λ₀ c‖`, and it must be bounded before the two factors are estimated separately: the
   gamma factor contributes `exp(−π d |t| / 4)` to both numerator and denominator, and an
   upper bound `M = O(q(iT)^B)` against a lower bound carrying that exponential would give
   `log(M/‖Λ₀ c‖) = O(T)`, which is useless. The milestone is therefore the ratio bound
   itself, and the exponential factors are cancelled inside it, never estimated apart:
   - basepoint `c = σ₀ + iT` with `σ₀ = 2`, where the Dirichlet series converges absolutely,
     so `continuedL d (σ₀ + iT) = LSeries d.coeff (σ₀ + iT)` by Layer 0.6 and
     `|continuedL d (σ₀ + iT)| ≥ ζ_K(σ₀)^{-1} > 0`, since each Euler factor satisfies
     `|1 − χ(𝔭) 𝔑𝔭^{-s}| ≤ 1 + 𝔑𝔭^{-σ₀}` and `∏_𝔭 (1 + 𝔑𝔭^{-σ₀}) ≤ ζ_K(σ₀)`. This is the
     nonvanishing input Jensen's formula needs and the reason this item consumes the
     L-functions roadmap's Layer 1. ⚠ The Euler product is used **only here**, on
     `Re s = 2 > 1`; nothing below applies Dirichlet agreement off that half-plane;
   - radii `r = 3` and `R = 4`, so that `closedBall (1/2 + iT) 1 ⊆ closedBall c 3` and the
     sphere `sphere c 4` lies in the strip `Re s ∈ [−2, 6]` and in the height range
     `|Im s − T| ≤ 4`;
   - the ratio bound `sup_{z ∈ sphere c 4} ‖Λ₀ z‖ / ‖Λ₀ c‖ ≤ analyticConductorAt d (iT) ^ B`
     for an explicit `B` and all `T ≥ T₀`. Both sides are written through
     `Λ₀ = (clearing polynomial) · conductor^{s/2} · γ · continuedL d` of Layer 0.6, which is
     an identity of meromorphic germs on all of `ℂ` and so is legitimate on the whole sphere;
     the two gamma factors are compared by Layer 1.5 on the same height range, where
     `|Im z| = T + O(1)` makes their exponential parts agree to within a bounded factor and
     leaves a power of `T`. ⚠ The exponential decay cancels only when the numerator keeps it,
     so `continuedL` is bounded on the sphere in three regions, each by a named route and
     none by the Dirichlet series: `Re z ≥ 1 + δ` by absolute convergence;
     `Re z ≤ −δ` by the functional equation of Layer 0.6, which reflects it to the first
     region for the dual record; and the middle strip by Layer 3.1 applied to the entire
     completion, which interpolates between those two edges. Bounded `T ≤ T₀` is a separate
     finite statement;
   - conclude by 5. Both radii, the basepoint, the exponent `B`, and the three-region split
     are part of the statement.
8. **The counting bounds that need no contour integral.** From 6 and 7:
   `N(T + 1) − N(T) = O(log (analyticConductorAt d (iT)))` for `T ≥ 2`, and
   `N(T) = O(T log (analyticConductorAt d (iT)))`. These are the strongest counting statements
   provable before Layer 7, and Layer 8.4's convergence of the zero side runs on the first of
   them.
9. `N (T : ℝ) : ℕ`, the `zeroCount` of `Λ` over `Icc 0 1 ×ℂ Ioc 0 T` per the counting
   convention, together with:
   - monotonicity in `T`, and `N 0 = 0`;
   - the symmetric count `N± (T)` over `Icc 0 1 ×ℂ Icc (−T) T`;
   - ⚠ the relation between them is **not** `N± = 2N + (real axis)` for every family. It holds
     when the zero divisor is invariant under `ρ ↦ conj ρ`, which for `ζ_K` follows from the
     reality of its coefficients, and for `L(χ, ·)` requires `χ` real. State three theorems:
     the Dedekind zeta case; the real (self-dual) Hecke character case, under the explicit
     hypothesis `Λ(χ, conj s) = conj (Λ(χ, s))`; and for a general finite-order `χ`, the
     relation between the count for `χ` above the axis and the count for `χ̄` below it. No
     bundled class: the reality hypothesis is written into each statement.
10. Finiteness of `N` on every bounded height range, and discreteness of the zero set of `Λ`
    in the critical strip — the model-class generalization of `isDiscrete_riemannZetaZeros`,
    which becomes a corollary at the ζ instance.
11. **The comparison with Nevanlinna theory**, so that the library does not grow two zero
    counts. Exactly three lemmas: `zeroCount f univ (closedBall 0 r)` is the classical
    unintegrated `n(r, f)`, which Mathlib does not name;
    `Function.locallyFinsuppWithin.logCounting (divisor f univ) r` is its log-weighted
    integral `N(r)`; and `n(r) * Real.log (R/r) ≤ N(R) − N(r)` for `0 < r < R`, with
    `logCounting_divisor_eq_circleAverage_sub_const` as the Jensen identity on the
    `logCounting` side.

### Layer 5: Hadamard factorization

The mathematics of this layer is entirely new — Mathlib has no order of an entire function,
no elementary factor, no canonical product, no genus, and no Weierstrass product even for
`Complex.Gamma` — but the infinite-product infrastructure is not. Locally uniform convergence
of `∏ (1 + f_i)`, holomorphy of the limit, and the logarithmic derivative of a product are all
upstream, and `Analysis/SpecialFunctions/Trigonometric/Cotangent.lean` carries the genus-`0`
case through end to end, from `Complex.multipliable_sineTerm` to the partial-fraction
expansion `Complex.cot_series_rep`. That arc is the model for 4 through 6 below; `Λ₀'/Λ₀` is
the same shape of statement as `π cot(πz)`. ⚠ `Analysis/Complex/Hadamard.lean` is the
three-lines theorem, not this. Everything in 1–6 is stated for a general entire function; the
identities special to an L-function are in 7.

1. The counting-function bound for an entire `f` with `OrderLE f A` and `f 0 ≠ 0`: the count
   of zeros in `closedBall 0 r` is `O(r^{A + ε})` for every `ε > 0`, from Layer 4.5 with
   center `0` and the basepoint value `‖f 0‖`. (Mathlib's First Main Theorem gives the
   integrated form `N(r, 0) ≤ log M(r) + O(1)` by
   `characteristic_sub_characteristic_inv_of_ne_zero` and `proximity_nonneg`; that is a check
   on this bound, not a second route to it, since it counts `N(r)` where the rest of this
   layer needs `n(r)`.)
2. **The zero index.** The zeros are the support of `MeromorphicOn.divisor f Set.univ`, which
   is countable and locally finite; the canonical product below is indexed by that support
   with the divisor value as multiplicity, so no enumeration is chosen and no reindexing
   lemma is needed. The milestone is the API: countability of the support, its local
   finiteness, the induced `Multipliable`/`Summable` statements over it, and the convention
   that a zero at `0` is excluded by the standing hypothesis `f 0 ≠ 0` rather than by
   factoring out a power of `s`.
3. The Weierstrass elementary factor `E₁ z = (1 − z) * Complex.exp z`, with its complete basic
   API: `E₁ 0 = 1`, `E₁ z = 0 ↔ z = 1`, `deriv E₁ z = −z * exp z`,
   `logDeriv E₁ z = −z/(1 − z)` for `z ≠ 1`, the estimate `‖E₁ z − 1‖ ≤ C‖z‖²` for
   `‖z‖ ≤ 1/2`, and the crude global bound `Real.log ‖E₁ z‖ ≤ C(1 + ‖z‖)`.
4. **The canonical product.** For `f` entire with `OrderLE f 1` and `f 0 ≠ 0`,
   `∑_ρ (divisor f univ ρ) * ‖ρ‖^{-1-ε} < ∞` for every `ε > 0` by partial summation from 1,
   hence `∑_ρ (divisor f univ ρ) * ‖ρ‖^{-2} < ∞`. The product `∏_ρ E₁(s/ρ)^{divisor f univ ρ}`
   converges locally uniformly on `ℂ` — `MultipliableLocallyUniformlyOn` via
   `multipliableLocallyUniformlyOn_one_add` with the estimate of 3 as dominating sequence —
   its limit is entire (`SummableLocallyUniformlyOn.differentiableOn`), and its divisor is
   `divisor f univ` (`tprod_one_add_ne_zero_of_summable` off the zeros).
5. **The entire logarithm.** A nonvanishing entire `g` is `exp ∘ h` for an entire `h`, unique
   up to `2πi ℤ`: consume `Complex.exists_continuousOn_eqOn_exp_comp` on `Set.univ` (open,
   simply connected) and upgrade continuity to holomorphy. This is a milestone rather than a
   step, because Hadamard's theorem is stated through it.
6. **Hadamard's theorem at order `≤ 1`.** For entire `f` with `OrderLE f 1` and `f 0 ≠ 0`
   there are `a b : ℂ` with `f s = exp (a + b*s) * ∏_ρ E₁(s/ρ)^{divisor f univ ρ}`. The half
   that needs work: the quotient of `f` by the product of 4 is entire and nonvanishing, so by
   5 it is `exp h`; bound `Re h` on a large circle by the order hypothesis, convert to a bound
   on `h` by `Complex.borelCaratheodory`, and conclude `h` is a polynomial of degree `≤ 1` by
   the Cauchy estimates. Then the logarithmic derivative
   `logDeriv f s = b + ∑_ρ (divisor f univ ρ) * (1/(s − ρ) + 1/ρ)` by
   `logDeriv_tprod_eq_tsum`, the series converging locally uniformly on `ℂ \ support`, and
   absolutely for each fixed `s` off the zeros. ⚠ State the mode of convergence in every
   statement; "converges" without one is not a statement.
7. **The L-function corollaries**, where the family enters. For `Λ₀ = entireCompletion d` of
   one of the two families:
   - the nonnegativity `0 ≤ ∑_ρ (divisor Λ₀ univ ρ) * Re (1/(s − ρ))` for `Re s > 1`, as an
     absolutely convergent sum of real parts — never as `Re ∑_ρ 1/(s − ρ)`, which needs a
     summation convention the roadmap does not fix — together with the pointwise statement
     that each summand is *strictly* positive, since `0 ≤ Re ρ ≤ 1 < Re s` gives
     `Re (1/(s − ρ)) = (Re s − Re ρ)/‖s − ρ‖² > 0`. ⚠ The sum itself is only nonnegative
     until a zero is known to exist: strict positivity of an empty sum is false, and the
     existence of a zero is Layer 7.7, which comes later. The zero-free-region argument
     discards this sum and so needs only the inequality as stated;
   - `Re b = −∑_ρ (divisor Λ₀ univ ρ) * Re (1/ρ)`, which is **false for a general entire
     function of order `≤ 1`** (multiplying by `exp (c s)` changes `b` and no zero) and is
     proved here from the functional equation together with the reality hypothesis
     `Λ₀(conj s) = conj (Λ₀ s)`, which `ζ_K` satisfies and a non-real `χ` does not. For a
     non-real character, state instead the relation between `b(χ)` and `b(χ̄)`.
   - the resulting bound on the number of zeros with `|Im ρ − T| ≤ 1`, which is Layer 4.7
     re-proved from the partial-fraction expansion, stated as a bound with the same
     `O(log (analyticConductorAt d (iT)))` shape and used in Layer 6.

### Layer 6: zero-free regions

⚠ Each statement here names its family. There is no zero-free region for a general record
satisfying the Layer-0 predicates: the argument needs the Euler product, nonnegativity of the
von Mangoldt coefficients, and the `3-4-1` inequality, none of which the model class has.

1. **Quantitative `3-4-1`.** For `σ > 1`,
   `3 (−ζ'_K/ζ_K)(σ) + 4 Re(−L'/L)(σ + it, χ) + Re(−L'/L)(σ + 2it, χ²) ≥ 0`,
   from `3 + 4cos θ + cos 2θ ≥ 0` and nonnegativity of the ideal von Mangoldt coefficients.
   This is the L-functions roadmap's Layer-7.4 argument with the inequality kept rather than
   discarded at the limit.
2. **The de la Vallée Poussin region for `ζ_K`.** There is `c > 0`, depending only on the
   degree `[K:ℚ]`, such that `ζ_K` has at most one zero `ρ` with
   `Re ρ ≥ 1 − c/log (analyticConductorAt d (i * Im ρ))`, and if such a `ρ` exists then it is
   real and simple. ⚠ Pin the constant's dependence as displayed: `c` is not absolute and is
   not allowed to depend on the individual field beyond its degree.
3. **The exceptional zero.** `IsExceptionalZero d β`, the predicate saying that `β` is real,
   lies in the region of 2, and is a zero of the completed function; together with the
   uniqueness theorem "at most one `β` satisfies it, and its order is `1`". ⚠ Do not define an
   unconditional `exceptionalZero : ℝ`; a total definition would export an arbitrary real when
   no exceptional zero exists. Either take the argument `(h : ∃ β, IsExceptionalZero d β)` or
   return `Option ℝ` with both cases specified. No milestone claims the exceptional zero does
   not exist, and none identifies it with the zero of a quadratic character's L-function:
   that is a Stark-type theorem and is out of scope.
4. **The region for Hecke L-functions.** For `χ` a primitive finite-order ray-class character:
   if `χ` is not real, `L(χ, ·)` has no zero in the region of 2; if `χ` is real, it has at
   most one, and that one is real and simple. The conductor enters through
   `arithmeticConductor = |d_K| 𝔑(𝔣)` and hence through `analyticConductorAt`.
5. **The two edge theorems, for both families**, recovering what the L-functions roadmap
   proved qualitatively: for `Λ` either `Λ_K` or `Λ(χ, ·)`,
   `∀ ρ, 0 < divisor Λ univ ρ → ρ.re ≠ 1`, and its reflection
   `∀ ρ, 0 < divisor Λ univ ρ → ρ.re ≠ 0` through the functional equation. The first is the
   boundary case of 2 and 4, and at `K = ℚ` it is the pin's
   `riemannZeta_ne_zero_of_one_le_re`. Layer 8.6 consumes the second at `s = 0`.

### Layer 7: the Riemann–von Mangoldt formula

⚠ This is where the count becomes exact, and an exact count is not a Jensen bound: Layer 4
gives inequalities, and equality needs the argument principle. Mathlib has none of the contour
machinery, and this roadmap does not build it. The
[contour integration roadmap](../ContourIntegration/README.md) does, and the theorem consumed
here is its Layer 4 summit, not its Layer 2: its pinned `argumentPrinciple` and
`classicalResidueTheorem_circle` are stated for a **circle**, and the general null-homologous
cycle is exactly what `hungerbuhlerWasem_residueTheorem` provides. Items 1–3 build the
rectangle interface that roadmap does not construct, and are stated generically for that
reason.

1. **The rectangle as a contour.** The positively oriented boundary of
   `Icc σ₁ σ₂ ×ℂ Icc t₁ t₂` as an explicit `γ : ℝ → ℂ` on `[0, 4]`, with the exact structure
   that roadmap's theorems hypothesize: `IsPwC1ImmersionOn γ 0 4` (each edge is `C¹` with
   nonvanishing derivative, the corners being the piece boundaries), `γ 0 = γ 4`,
   `windingNumber γ 0 4` equal to `1` about each interior point and `0` about each point
   outside the closed rectangle, and `IsNullHomologous γ 0 4 U` for every open `U` containing
   the closed rectangle.
2. **The argument principle on a rectangle.** For `f` meromorphic on an open `U` containing
   the closed rectangle `R` and regular on `∂R` (`meromorphicOrderAt f z = 0` there),
   `(2πi)⁻¹ ∮_{∂R} logDeriv f = divisorCount f U R`, the signed count. It is
   `hungerbuhlerWasem_residueTheorem` applied to `logDeriv f` with `S` the zeros and poles of
   `f` in `R`, and the work is discharging its hypotheses, each of which is a named
   sub-milestone:
   - `S` is finite and disjoint from the image of `γ`, from Layer 4.1's finiteness and the
     boundary regularity, so `hγa` and the `DifferentiableOn` hypothesis hold;
   - `ConditionAprime γ 0 4 (logDeriv f) S` and `ConditionB γ 0 4 (logDeriv f)` are vacuous
     when no singularity lies on the curve, which is a lemma about those two predicates and
     not an assumption;
   - `HasCauchyPV γ 0 4 (logDeriv f) v` implies the ordinary contour integral equals `v` when
     the integrand is continuous on the image of `γ`, so the principal value in that roadmap's
     conclusion may be replaced by the interval integral here;
   - `residue (logDeriv f) z = meromorphicOrderAt f z` at each `z ∈ S`, which is the local
     content of the argument principle and is that roadmap's `argumentPrinciple_local` read
     through `residue`;
   - the weighted sum `∑ s ∈ S, windingNumber γ 0 4 s * residue (logDeriv f) s` equals
     `divisorCount f U R`, by 1 (the winding numbers are `1` inside and `0` outside) and the
     identification of `meromorphicOrderAt` with `MeromorphicOn.divisor`, which is what keeps
     the library from carrying two counts.
   ⚠ The signed count is what a contour integral computes; the passage to `zeroCount` is the
   no-poles hypothesis of Layer 4.1, and for `Λ` on a rectangle meeting `0` or `1` it is
   `entireCompletion` that must be integrated.
3. **The argument-variation form and `S(T)`.** For `f` regular and nonvanishing on `∂R`, the
   image curve `f ∘ ∂R` misses `0`, so `Complex.exists_continuousOn_eqOn_exp_comp` on an open
   interval containing `[0, 4]` gives a continuous `θ : ℝ → ℝ` with
   `f (∂R t) = ‖f (∂R t)‖ * exp (i θ t)`. ⚠ The lift is unique only up to a global `2π ℤ`, and
   no basepoint value may be *asserted*: `θ 0` is some argument of `f (∂R 0)`, not `0`, and
   every statement uses only a difference `θ b − θ a`, which is independent of the choice.
   With that, `(divisorCount f U R : ℝ) = (θ 4 − θ 0)/(2π)`, and this real number is
   `windingNumber (f ∘ ∂R) 0 4 0` of the contour roadmap's Layer 0.
   `S (T : ℝ) : ℝ` is defined from `riemannZeta`, not from the completed function, whose gamma
   and conductor factors contribute an argument of their own: `π⁻¹` times the variation of a
   continuous argument of `ζ` along the polygonal path `2 → 2 + iT → 1/2 + iT`, started at the
   positive real value `ζ 2`, where the argument is `0` because that value is positive real and
   not by fiat, and with `T` not the ordinate of a zero. This is the form Backlund's method
   runs on; the bound on the number of sign changes of `Re ζ` along the horizontal segment that
   it needs is a Jensen argument on discs, from Layer 4.5.
4. **For `ζ`, first.** `N(T) = (T/2π) * Real.log (T/(2πe)) + O(Real.log T)` for `T ≥ 2`, with
   `N` as in Layer 4.9. Proof by 2 on `Icc (−1) 2 ×ℂ Icc 0 T`, applied to `entireCompletion`
   rather than to `Λ` — whose poles at `0` and `1` sit on the lower edge, so 2 does not apply
   to it, and clearing them is what Layer 0.2 is for. Three steps connect the contour count to
   `N(T)`: the divisor identity of Layer 4.2, so that the count for the entire completion
   differs from the one for `Λ` only at `0` and `1`; the confinement of the remaining zeros to
   the critical strip, so that the count over `Re s ∈ [−1, 2]` is the count over `[0, 1]`; and
   the half-open convention of Layer 4.9 for the bottom edge. The main term comes from Layer
   1.5 for the gamma factor, and the error from Layer 3 for `‖ζ‖` on the right edge together
   with 3 for the argument variation.
5. **Boundary heights.** 4 is proved first for `T` not the ordinate of a zero, where the top
   edge is regular. The extension to every `T ≥ 2` is a milestone, not a remark: `N` is
   right-continuous in `T` by the half-open counting convention, the set of ordinates is
   discrete by Layer 4.10, and moving the top edge up by `η → 0` past a zero of multiplicity
   `m` changes the count by exactly `m` while changing the main term by `O(η log T)`. State
   which convention the formula uses and prove that both one-sided limits satisfy it.
6. **For the two families, uniformly in the conductor.** For `Λ_K` of degree `n = [K:ℚ]`,
   `N±_K(T) = (T/π) * Real.log (|d_K| * (T/(2πe))^n) + O(Real.log (|d_K| * T^n))` for `T ≥ 2`,
   the count being `N±` of Layer 4.9, with the implied constant depending only on `n`; and the
   same statement for `L(χ, ·)`, of the same degree `n`, with `|d_K| 𝔑(𝔣)` in place of
   `|d_K|`. ⚠ The two counting conventions differ by a factor of two; each formula names which
   it uses, and the conversion is Layer 4.9's, with its reality hypothesis. The main term must
   carry the degree and the conductor explicitly — a formula stated only for `ζ` does not
   discharge this milestone.
7. **The corollaries, as a finite list of four.** For fixed `K`: `N(T)/(T log T) → n/(2π)` as
   `T → ∞`; `Λ` has infinitely many zeros; the averaged unit-height count
   `T⁻¹ ∫_0^T (N(t + 1) − N(t)) dt / log T → n/(2π)`; and the specialization of 6 to `K = ℚ`
   recovering 4. ⚠ The third is stated as an average on purpose. The error term in 6 is the
   same order as the main term of the unit-height difference, so 6 does not prove a pointwise
   asymptotic for `N(T+1) − N(T)`, and no pointwise asymptotic is a milestone here. ⚠ Nothing here
   bounds an individual gap between consecutive ordinates, and differencing 6 does not: its
   error is `O(log q(iT))`, the same size as the main term of the difference. The unit-height
   *bound* `N(T+1) − N(T) = O(log q(iT))` is Layer 4.8's and needs no contour integral.

### Layer 8: the explicit formula

Items 1 to 5 are stated for `ζ_K`; the Hecke case is item 6, which lists the exact
substitutions rather than asserting that it has "the same shape". Fix `r₁, r₂` the real and
complex places of `K`, so `γ_K(s) = Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂}` and
`Λ_K(s) = |d_K|^{s/2} γ_K(s) ζ_K(s)`.

1. **The truncated Perron formula.** For `x > 0` with `x ≠ 1`, `c > 0`, and `T ≥ 1`,
   `(2πi)⁻¹ ∫_{c−iT}^{c+iT} x^s/s ds = (if 1 < x then 1 else 0) + E`, where the integral is
   the interval integral along the parametrization `t ↦ c + it` on `[−T, T]` and
   `‖E‖ ≤ x^c / (T * |Real.log x|)`. ⚠ At `x = 1` the finite-`T` integral is **not** `1/2`: it
   is exactly `π⁻¹ * Real.arctan (T / c)`, which tends to `1/2` only as `T → ∞`. State that
   exact value as its own milestone and take the half-weight endpoint only in the limit; 3
   then excludes `x` at a prime-power norm rather than assigning it half weight. ⚠ Mathlib has
   `mellinInv_mellin_eq` and no Perron formula.
2. **The contour shift.** The integrand is `s ↦ (−ζ'_K/ζ_K)(s) * x^s / s`. Move the segment
   from `Re s = c` to `Re s = −(2N + 1/2)` across the rectangle with horizontal edges at
   `±iT`, and let `N → ∞`. The poles crossed, with their residues, are exactly:
   - `s = 1`, from the simple pole of `ζ_K`: residue `x`;
   - each `ρ` with `0 < divisor Λ_K univ ρ` and `|Im ρ| ≤ T`: residue
     `−(divisor Λ_K univ ρ) * x^ρ/ρ`;
   - `s = 0`, where `ζ_K` vanishes to order `r₁ + r₂ − 1`: residue
     `c_K − (r₁ + r₂ − 1) * Real.log x`, with
     `c_K = lim_{s→0} ((−ζ'_K/ζ_K)(s) + (r₁ + r₂ − 1)/s)`;
   - each trivial zero `s = −m`, `1 ≤ m ≤ 2N`, where `ζ_K` vanishes to order `r₁ + r₂` for `m`
     even and `r₂` for `m` odd: residue `(order) * x^{-m}/m`.
   The milestone includes: that the left edge tends to `0` as `N → ∞` for `x > 1`, so the
   trivial-zero residues sum to a convergent series; the lemma that `T` may be chosen with
   `|T − Im ρ| ≫ 1/log q(iT)` for every zero, from Layer 4.8; and the bounds on the horizontal
   edges, from Layer 5.7's partial-fraction expansion together with Layer 1.4.
3. **The truncated formula for `ψ_K`.** With `ψ_K(x) = ∑_{𝔑𝔞 ≤ x} Λ_K(𝔞)` (the ideal von
   Mangoldt weight of the L-functions roadmap's Layer 7.6, summed over integral ideals of norm
   at most `x`, with the convention that a value `𝔑𝔞 = x` is included), for `2 ≤ T ≤ x` and
   `x` not a prime-ideal-norm power:
   ```
   ψ_K(x) = x − ∑_{|Im ρ| ≤ T} (divisor Λ_K univ ρ) * x^ρ/ρ
            − (r₁ + r₂ − 1) * log x + c_K
            − ((r₁ + r₂)/2) * log (1 − x^{-2}) + (r₂/2) * log ((x + 1)/(x − 1))
            + O(x * log x * log (x*T) / T)
   ```
   with the implied constant depending only on `K`. The two logarithmic terms are the sum of
   the residues at the trivial zeros, where `ζ_K` vanishes to order `r₁ + r₂` at `−2n` and to
   order `r₂` at `−(2n−1)` for `n ≥ 1`; computing them in closed form as displayed is part of
   the milestone, and at `K = ℚ` the display must reduce to the classical
   `ψ(x) = x − ∑ x^ρ/ρ − log 2π − ½ log (1 − x^{-2})`.
4. **The Weil form**, over the test class and no other: `φ : ℝ → ℝ` with `ContDiff ℝ ⊤ φ`,
   `HasCompactSupport φ`, and `tsupport φ ⊆ Set.Ioi 0`, with Mellin transform
   `φ̃(s) = ∫ x in Set.Ioi 0, φ x * x^(s−1)` and dual `φ̌ y = φ (1/y) / y`, whose transform is
   `φ̃(1 − s)`. Then
   ```
   ∑_ρ (divisor Λ_K univ ρ) * φ̃(ρ)
     = φ̃(0) + φ̃(1) + (log |d_K|) * φ 1 + A_K(φ) − ∑_𝔞 Λ_K(𝔞) * (φ (𝔑𝔞) + φ̌ (𝔑𝔞))
   ```
   where the archimedean term is
   `A_K(φ) = (2πi)⁻¹ ∫_{(1+δ)} (logDeriv γ_K)(s) * (φ̃(s) + φ̃(1 − s)) ds` with `logDeriv γ_K`
   given explicitly by Layer 1.4 as
   `r₁ * (digamma (s/2)/2 − (log π)/2) + r₂ * (digamma s − log (2π))`. Nothing here is an
   unnamed archimedean or pole term. The supporting facts are milestones too: `φ̃` is entire;
   it decays faster than any power of `|Im s|` on every vertical strip (integration by parts,
   once per power); the zero side converges absolutely, from Layer 4.8 against that decay;
   the terms `φ̃(0)` and `φ̃(1)` come from the simple poles of `Λ_K` at `0` and `1`, where
   `logDeriv Λ_K` has residue `−1`, so each contributes once; and the prime side is the Mellin
   inversion `(2πi)⁻¹ ∫_{(1+δ)} 𝔑𝔞^{-s} φ̃(s) ds = φ (𝔑𝔞)` applied to `−ζ'_K/ζ_K` term by term. The presentation over even
   `C_c^∞(ℝ)` in the coordinate `x = log y` is the same theorem and is proved as a corollary,
   not stated as a second milestone. ⚠ The class is fixed here; the wider Paley–Wiener class
   of transforms of compactly supported distributions is out of scope, and a hypothesis on the
   test function is never an adjective.
5. **The prime ideal theorem with an error term**, as two theorems covering the two branches
   of Layer 6.3's disjunction, both for fixed `K` with `c > 0` and the implied constant
   depending on `K`:
   - under `IsExceptionalZero ζ_K β`,
     `ψ_K(x) = x − x^β/β + O(x * Real.exp (−c * Real.sqrt (Real.log x)))`;
   - under `¬∃ β, IsExceptionalZero ζ_K β`,
     `ψ_K(x) = x + O(x * Real.exp (−c * Real.sqrt (Real.log x)))`.
   The exceptional zero appears as an explicit term rather than being assumed away, and
   together the two cover every `K`, strengthening the L-functions roadmap's asymptotic
   statement. ⚠ Siegel's theorem, which would bound `1 − β` from below ineffectively, is out
   of scope, so no milestone absorbs the exceptional term into the error with an effective
   constant.
6. **The Hecke instance**, for `χ` a primitive nontrivial finite-order ray-class character of
   conductor `𝔣`, whose gamma factor is `γ_χ(s) = ∏_{j ≤ r₁} Gammaℝ(s + a_j) * Gammaℂ(s)^{r₂}`
   with `a_j ∈ {0, 1}` the signature of `χ` at the real places. Items 1 to 4 hold verbatim with
   the following four substitutions, and this item is what discharges them:
   - `ψ_K(x, χ) = ∑_{𝔑𝔞 ≤ x} Λ_K(𝔞) * χ(𝔞)` in place of `ψ_K(x)`, and the zeros of
     `Λ(χ, ·)` in place of those of `Λ_K`;
   - no `x` term: `Λ(χ, ·)` is entire for nontrivial `χ`, so the contour shift crosses no pole
     at `s = 1`, and `φ̃(0) + φ̃(1)` drops out of 4;
   - the order of vanishing of `L(χ, ·)` at `s = 0` is the order of the pole of `γ_χ` there,
     namely `#{j : a_j = 0} + r₂`, replacing `r₁ + r₂ − 1` — with the hypothesis
     `Λ(χ, 0) ≠ 0`, which Layer 6.5's edge theorem supplies and which must be cited rather
     than assumed; and the trivial zeros sit at `s = −m` with order
     `#{j : a_j ≡ m [MOD 2]} + r₂`, replacing the `r₁ + r₂` and `r₂` of 3, so the closed form
     of their residue sum changes accordingly;
   - `log (|d_K| * 𝔑𝔣)` in place of `log |d_K|` in 4, and `logDeriv γ_χ` in place of
     `logDeriv γ_K` in the archimedean term.
   The analogue of 5 is two theorems, not one, and the exceptional term appears in the first
   exactly as it does for `ζ_K`: for fixed `K` and fixed `χ` there is `c > 0` with
   - under `IsExceptionalZero χ β` (possible only for real `χ`, by Layer 6.4),
     `ψ_K(x, χ) = −x^β/β + O(x * Real.exp (−c * Real.sqrt (Real.log x)))`;
   - under `¬∃ β, IsExceptionalZero χ β`,
     `ψ_K(x, χ) = O(x * Real.exp (−c * Real.sqrt (Real.log x)))`.
   There is no `x` main term in either, since `L(χ, ·)` is entire. ⚠ Both constants depend on
   `K` and on `χ`, and neither statement is uniform in the conductor: an exceptional zero may
   sit arbitrarily close to `1`, and absorbing `x^β/β` into the error would need a lower bound
   for `1 − β` that only Siegel's theorem gives, which is out of scope. Nothing here may be
   read as the conductor-uniform disjunction.

### Layer 9: certified zeros

The LMFDB stores lists of zeros with certified accuracy. This layer says what such a list
means. It depends on Layers 0 and 4 only, so it can be built early. ⚠ Nothing here proves that
a particular numerical list is correct: the numerical analysis that would discharge the
hypotheses is out of scope, and every milestone is about the shape of the statement.

1. `HasZerosInRects f U R Bs ms`, over: `U` with `IsOpen U` as a field rather than as prose;
   `f` meromorphic on `U` with `∀ z ∈ R, 0 ≤ divisor f U z` (no poles in the region — for a
   completed L-function whose region meets `0` or `1`, this is why the certificate is stated
   for `entireCompletion`); a closed rectangle `R ⊆ U` and a finite list `Bs` of closed
   rectangles, each with its endpoints in order, since a reversed pair has empty interior and
   a boundary that is not its four edges; and multiplicities `ms : List ℕ`. Its fields:
   - each `B ∈ Bs` satisfies `B ⊆ R`;
   - the interiors of the `B` are pairwise disjoint;
   - `f` is regular and nonvanishing on `∂R` and on each `∂B`, as
     `∀ z ∈ frontier _, meromorphicOrderAt f z = 0`;
   - `List.Forall₂ (fun B m ↦ zeroCount f U B = m) Bs ms`;
   - `zeroCount f U R = ms.sum`.
   ⚠ Every clause is load-bearing. Natural-number multiplicities and the no-poles hypothesis
   are what stop an omitted zero from cancelling an omitted pole in a signed total; the last
   clause is what makes the list *complete* rather than a list of zeros that happen to be
   there.
2. **Coverage**, the theorem that says the predicate means what its name says: from a term of
   `HasZerosInRects f U R Bs ms`, every `ρ ∈ R` with `0 < divisor f U ρ` lies in some
   `B ∈ Bs`. Prove it by summing the nonnegative divisor over `R` and comparing with the
   per-rectangle sums, without subtracting integer counts.
3. **Stability.** Shrinking `R` to a closed rectangle `R'` with `Bs`-membership preserved
   requires `f` regular and nonvanishing on `∂R'`, and then `HasZerosInRects f U R' Bs ms`
   holds. Replacing a rectangle `B` by a closed `B' ⊆ B` requires `f` regular and nonvanishing
   on `∂B'` and `zeroCount f U B' = zeroCount f U B`. Both hypotheses are part of the
   statement; without them the conclusions are false.
4. **`AllOnCriticalLine`**, defined semantically: `∀ ρ ∈ R, 0 < divisor f U ρ → ρ.re = 1/2`.
   ⚠ "Each rectangle meets the critical line" does not imply this and is not the definition; a
   wide rectangle can meet the line and contain off-line zeros. Two reusable sufficient
   criteria, both milestones:
   - per-rectangle localization: if every `B ∈ Bs` satisfies
     `∀ ρ ∈ B, 0 < divisor f U ρ → ρ.re = 1/2`, then with 2 the region satisfies
     `AllOnCriticalLine`;
   - symmetry and uniqueness: if `B` is invariant under `s ↦ 1 − conj s`, the divisor of `f`
     is invariant under the same map, and `zeroCount f U B = 1`, then that zero is fixed by
     the reflection, so `ρ.re = 1/2`. ⚠ The hypothesis is invariance of the *divisor*, which
     for `Λ_K` follows from the functional equation together with the reality of the
     coefficients; `f (1 − conj s) = f s` is false for `Λ`, which satisfies
     `Λ(1 − conj s) = conj (Λ s)`. ⚠ The criterion fails for multiplicity greater than `1`,
     where a reflection-conjugate pair inside `B` satisfies every other hypothesis, so
     multiplicity one is stated explicitly.
5. `GRH`, as a `Prop` over the two families: `∀ ρ, 0 < divisor Λ univ ρ → ρ.re = 1/2`. Prove
   that at the ζ instance it is Mathlib's `RiemannHypothesis`, which is the only thing making
   the definition trustworthy. The bridge is three lemmas: a point of positive divisor of
   `completedRiemannZeta` is exactly a nontrivial zero of `riemannZeta`; the trivial zeros are
   not points of positive divisor, because there `Gammaℝ` has a pole and the completion is
   regular; and `0` and `1` are poles, so they are points of negative divisor.
6. **The boundary convention.** ⚠ `zeroCount` is taken over a *closed* rectangle, so a zero
   on `∂R` or on some `∂B` would be counted; the predicate does not discard it. What the
   predicate does instead is forbid it, through `regular_frontier` and
   `regular_frontier_box`, which is why boundary regularity is a hypothesis rather than a
   conclusion. Prove that if `meromorphicOrderAt f z ≠ 0` for some `z ∈ ∂R` then no
   certificate for `R` exists, so the hypothesis cannot be dropped.

## Worked examples (acceptance criteria)

Each is either a theorem discharged by numbered milestones, or — where marked — a
*type-checking* criterion: the statement must be expressible and its hypotheses must be
exactly what a certificate would supply, with no numerical claim proved here.

- **`ζ`'s trivial zeros are not zeros of `Λ`.** `meromorphicOrderAt completedRiemannZeta (−2n) = 0`
  for `n ≥ 1`: the trivial zeros of `riemannZeta` are cancelled by the poles of `Gammaℝ`.
  Verify that `divisor completedRiemannZeta univ` is supported in the closed critical strip
  together with `{0, 1}`, where it is `−1`. Catches the most common confusion between `L`
  and `Λ`, and the temptation to read a pole off the value `Gammaℝ(−2n) = 0`.
- **A pole with value zero is not a zero.** At `s = 1`, `completedRiemannZeta` has a pole, and
  `meromorphicOrderAt completedRiemannZeta 1 = −1` while the total representative's value is
  junk. No boundary hypothesis in Layers 7 or 9 may be stated as `f z ≠ 0`.
- **The first zero of `ζ`** (type-checking criterion). `HasZerosInRects` for
  `entireCompletion` of the ζ record on `Icc 0 1 ×ℂ Icc 0 15`, with one rectangle around
  `1/2 + 14.134725…i` and multiplicity `1`, together with `AllOnCriticalLine` by the
  symmetry-and-uniqueness criterion of 9.4. ⚠ Stated for the entire completion, since `Λ`
  itself has poles at `0` and `1` on the lower edge and so admits no certificate there; that
  is the same convention as the boundary example below, not an exception to it. The numerical
  hypotheses are inputs, not milestones.
- **`N(T)` for `ζ` at `T = 100`** (type-checking criterion, conditional theorem). A supplied
  certificate for `Icc 0 1 ×ℂ Icc 0 100` with `29` rectangles of multiplicity `1` implies
  `N(100) = 29`. ⚠ `N(100) = 29` is not a consequence of Layer 7.4, whose error term carries
  no explicit constant; what the roadmap proves is the implication. The check is on the
  counting convention: the symmetric count is `58`, and the conversion is Layer 4.9's.
- **`ζ_{ℚ(i)}` versus `ζ · L(χ₋₄)`.** From the L-functions roadmap's Layer 4 factorization and
  its normalization lemma, the divisors add:
  `divisor Λ_{ℚ(i)} univ = divisor Λ_ℚ univ + divisor Λ(χ₋₄) univ`. Catches multiplicity
  handling, since a common zero would have order `2` on the left.
- **Degree and conductor in the main term.** For `K` imaginary quadratic of discriminant `D`,
  Layer 7.6 reads `N±_K(T) = (T/π) log(|D| (T/2πe)^2) + O(log(|D|T^2))`. Verify that this is
  the sum of the ζ and `L(χ_D)` counts, which is a real consistency check on the constants.
- **A boundary pole blocks a certificate.** For `Icc 0 1 ×ℂ Icc (−1) 1` and `Λ_K`, no
  certificate exists in the sense of Layer 9, by 9.6, because of the pole at `s = 1` on the
  boundary. The `entireCompletion` version does admit one.
- **Layers 7 and 9 count the same integer.** The hypotheses of 7.2 — `f` meromorphic on an
  open `U ⊇ R`, regular on `∂R` — are what `HasZerosInRects` supplies, and on a pole-free
  region `divisorCount` and `zeroCount` agree by 4.1. Verify that a certificate's count is the
  contour integral of 7.2. Catches a divergence between the two layers' rectangle conventions.
- **A zero on a subdivision edge.** For a function with a simple zero on the common edge of
  two closed rectangles, the closed-rectangle additivity statement of 4.3 does not apply, and
  the half-open partition counts the zero exactly once. This is a check on the statement of
  4.3, not a theorem about `ζ`.
- **`exp (c s)` is not constrained by its zeros.** Layer 5.6 applied to `f s = exp (c s)`
  gives `b = c` with an empty product; no general milestone may force `c = 0`, which is why
  `Re b = −∑_ρ Re(1/ρ)` is a Layer 5.7 corollary with a reality hypothesis rather than a
  general theorem.
- **A complex gamma shift.** For a record with `gammaR = {i}`, `analyticConductorAt` still
  satisfies the two-sided comparison of 2.2, and is not monotone in `|Im s|` near `Im s = −1`.
  A milestone asserting monotonicity would be refuted by this record.
- **The exceptional zero is not excluded.** Layer 6.2 instantiated at a real character is a
  disjunction, and neither branch is provable from the other milestones. A scope check rather
  than a theorem.

## Ordering — the dependency graph

```
  L-functions Layer 0 ─────────────────▶ 0 growth predicates + entire completion
  Mathlib Gamma, BranchLogRoot ────────▶ 1 Stirling
  L-functions Layer 0 spectral data, 1 ▶ 2 analytic conductor
  0 + 1 + 2 + functional equation ─────▶ 3.1-3.3 convexity
  0 + 3.1 + L-functions Layers 3,5 ────▶ 3.4 finite order for the two families
  Mathlib Jensen/Divisor ──────────────▶ 4A generic counts (4.1-4.6)
  1 + 2 + 3.4 + L-functions Layer 1 ───▶ 4B family local counts (4.7-4.8), then 4.9-4.11
  0 + 4A ──────────────────────────────▶ 5.1-5.6 Hadamard, general
  3.4 + 4B + 5.6 ──────────────────────▶ 5.7 the L-function corollaries
  1 + 2 + 5.7 + L-functions Layers 3,4,5,7 ▶ 6 zero-free regions
  1 + 3 + 4 + contour integration 0-3 ─▶ 7 Riemann-von Mangoldt
  1 + 4 + 5 + 7 + L-functions Layer 7.6 ▶ 8.1-8.4 explicit formula
  6 + 8.4 ─────────────────────────────▶ 8.5 prime ideal theorem error term
  0 + 4A ──────────────────────────────▶ 9 certificates
```

Two starts need nothing from this roadmap: Layer 1 needs only Mathlib, and Layer 4A needs
Mathlib plus the continuation predicate, so the counting theory can be built before any
arithmetic exists. Layer 2 needs the record's spectral parameters and Layer 1; Layer 9 needs
Layer 4A's counting API and Layer 0's entire completion, and nothing else. The arithmetic
instances first appear in Layer 3.4, which is why finite order for the two families is proved
there rather than in Layer 6: Layer 4B's local counts and Layer 5.7's corollaries both need
it, and both come earlier than the zero-free regions. Layers 7 and 8 are where the contour
integration roadmap's residue calculus is needed, and everything before them is stated and
proved without it.

## Sources for the hard milestones

Layers 0 to 5 are stated from first principles and cite Mathlib declarations by name. Layers 6
to 8 make choices a source has to settle: which family, which normalization, which endpoint
convention, and what every constant may depend on. Each row below fixes those, and says so
where the milestone is a combination or a strengthening of what one source proves, because
that is where a formalizer would otherwise guess.

| Milestone | Source and its hypotheses | Translation and constants |
|---|---|---|
| 6.2, the region for `ζ_K` | Kadiri, *Explicit zero-free regions for Dedekind zeta functions*, main theorem: a region of the shape `σ ≥ 1 − 1/(R log(\|d_K\| …))` free of zeros but for at most one, real and simple, with an explicit numerical `R`, for `ζ_K` in the classical normalization. | The shape is kept and the numerics dropped: `c` is existential and depends only on `[K:ℚ]`, and the region is written through `analyticConductorAt` rather than through `\|d_K\|` and `\|t\|` separately, the two being interchangeable by 2.2. The "at most one, real and simple" clause is taken as stated; no milestone here proves an explicit constant. |
| 6.3, the exceptional zero | The same source for existence and uniqueness; Davenport §14 for the `K = ℚ` analogue and the Landau–Page structure of the argument. | Stated as a predicate plus uniqueness, never as a total function. ⚠ Identifying `β` with the zero of a quadratic character's L-function is a Stark-type theorem that neither source proves in this generality, and it is out of scope. |
| 6.4, the region for Hecke L-functions | Lang, *Algebraic Number Theory*, ch. XV for the analytic input; the `3-4-1` route of Davenport §14 carried to a ray-class character. | The real and non-real cases are split explicitly: only a real `χ` may have an exceptional zero. Constants depend on `[K:ℚ]` alone, as in 6.2. |
| 7.4, Riemann–von Mangoldt for `ζ` | Titchmarsh (rev. Heath-Brown), ch. 9, which proves `N(T) = (T/2π) log(T/2π) − T/2π + 7/8 + S(T) + O(1/T)` with `S(T) = O(log T)`, counting `0 < γ ≤ T` and assuming `T` is not the ordinate of a zero. | The count is the same under the half-open convention of 4.9, and `(T/2π) log(T/2πe)` is that main term rearranged. The extension to every `T` in 7.5 is the roadmap's own, stated precisely because the source assumes `T` is not an ordinate. |
| 7.6, the conductor-uniform form | Iwaniec–Kowalski ch. 5, zero counting for a general L-function of the axiomatic class, in the analytic normalization used there. | The implied constant must depend on the degree only; a version whose constant may depend on `\|d_K\|` is weaker and does not discharge the milestone. |
| 8.1, truncated Perron | Davenport §17, for `c > 0`, `x > 0`, `T ≥ 1`, error `x^c/(T\|log x\|)`, `x ≠ 1`. | Kept as stated, with the `x = 1` value given exactly at finite `T` as `π⁻¹ arctan(T/c)` rather than as its limit, which is this roadmap's correction to the usual informal phrasing. |
| 8.2, the contour shift | Davenport §17 for `−ζ'/ζ`, carried to `ζ_K` by the same residue bookkeeping. | The trivial-zero residues are computed here from the gamma-factor pole orders of 1.5 rather than quoted, and at `K = ℚ` the closed form must reproduce the source's. |
| 8.3, the truncated `ψ_K` formula | Lang ch. XVII for the number-field explicit formula; Davenport §17 for the `K = ℚ` case that pins the constants. | Stated for `2 ≤ T ≤ x` with the implied constant depending on `K` only, and with `x` excluded at a prime-power norm rather than given half weight. ⚠ Uniformity in `K` is not claimed. |
| 8.4, the Weil form | Lang ch. XVII, and Iwaniec–Kowalski ch. 5 for the pairing form; both use a test-function class wider than the one fixed here. | The class is narrowed to smooth compactly supported `φ` on `(0, ∞)`, which lies inside every source's class, so this is a special case needing no extra hypothesis. Every term is written out here rather than cited. |
| 8.5 and 8.6, the prime sums | Lang ch. XV and XVII, Davenport §§18–19, for the `exp(−c√log x)` shape. | Split into the two exceptional-zero branches, with constants depending on `K`, and on `χ` in 8.6, and with no claim of conductor-uniformity: absorbing `x^β/β` into the error would need Siegel's theorem. |

⚠ These rows fix the mathematical content, the hypotheses, and the dependence of every
constant. They cite chapters and named statements rather than theorem numbers: pinning the
numbering against physical copies is recorded as an open item in `PROVENANCE.md`, and a wrong
number would be worse than a right chapter.

## References

- H. Iwaniec, E. Kowalski, *Analytic Number Theory*, AMS Colloq. 53 — the source of record:
  ch. 5 (the axioms, the analytic conductor (5.7), the convexity bound, zero counting (5.24)),
  ch. 5.7 and ch. 10 (zero-free regions and the explicit formula), ch. 16 (zeros).
- H. Davenport, *Multiplicative Number Theory*, 3rd ed. — §§17–19 for the truncated Perron
  formula, the contour shift, and the explicit formula for `ψ` in the shape Layer 8 follows,
  and §14 for the classical zero-free region.
- E. C. Titchmarsh (rev. Heath-Brown), *The Theory of the Riemann Zeta-Function* — ch. 9 for
  `N(T)`, `S(T)`, and the Riemann–von Mangoldt formula, including the boundary-height
  convention of Layer 7.5.
- H. Kadiri, *Explicit zero-free regions for Dedekind zeta functions*, Int. J. Number Theory 8
  (2012) — the "at most one zero in the region, real and simple" statement of Layer 6.2, in
  the exact form the milestone takes.
- NIST DLMF §5.11 — Stirling's expansion for the general branch of `log Γ` on a sector, the
  statement Layer 1.2 formalizes.
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110 — ch. XVII for the explicit formula in
  the number-field setting, and ch. XV for the analytic input Layer 6 makes quantitative.
- J. Neukirch, *Algebraic Number Theory* — ch. VII §§5, 8 for the completed functions whose
  zeros these are.
- The [L-functions roadmap](../LFunctions/README.md), which constructs everything this
  roadmap takes as given, and whose conventions table this one extends rather than restates.
- The [contour integration roadmap](../ContourIntegration/README.md), which builds the residue
  calculus and the argument principle that Layers 7 and 8 consume.
