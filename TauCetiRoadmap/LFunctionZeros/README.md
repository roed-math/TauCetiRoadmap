# Roadmap: zeros of L-functions — growth, zero-free regions, counting, and the explicit formula

The zeros of an L-function are what the LMFDB's L-function pages are mostly about, and they
are the part of the analytic theory that Mathlib has least of. At the project pin
(`9caeba1000`, 2026-06-03) the only zeros in the library are `riemannZetaZeros`, known to be
closed and discrete (`isDiscrete_riemannZetaZeros`, `IsCompact.inter_riemannZetaZeros_finite`),
together with the classical trivial zeros and the `RiemannHypothesis` `Prop`. There is no
zero counting, no zero-free region, no explicit formula, and no way to say that a computed
list of zeros is complete.

The complex analysis needed is in better shape than that suggests. Mathlib has Jensen's
formula (`MeromorphicOn.circleAverage_log_norm`) and the disc zero bound it implies
(`AnalyticOnNhd.sum_divisor_le`), Phragmén–Lindelöf on horizontal and vertical strips
(`Complex.PhragmenLindelof.vertical_strip`), the Hadamard three-lines theorem, and — the
piece that matters most for stating anything about zeros correctly — the divisor of a
meromorphic function, `MeromorphicOn.divisor f U : Function.locallyFinsuppWithin U ℤ`, which
records order with sign and multiplicity. What is missing is the growth theory: nothing in
Mathlib bounds `Complex.Gamma` on a vertical strip, nothing defines the order of an entire
function, and there is no Hadamard factorization. The contour theory is missing too — no
argument principle, no winding number, no residue theorem — but that is the
[contour integration roadmap](../ContourIntegration/README.md)'s to build, and Layers 7 and 8
here consume it rather than repeating it.

This roadmap builds the zeros program on top of the completed L-functions produced by the
[L-functions roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/8): the growth theory
of the completed function, the analytic conductor, zero counting with multiplicity, the
classical zero-free regions, the Riemann–von Mangoldt formula, the explicit formula, and the
semantics of a certified list of zeros.

Suggested home: `TauCeti/NumberTheory/LFunctions/Zeros/`, with subdirectories per layer
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
- Interval-arithmetic tactics or decision procedures for discharging a zero certificate. The
  *semantics* of a certificate is in scope (Layer 9); the tooling that produces one is not.
- The residue calculus itself: winding numbers, residues, the residue theorem, the homology
  form of Cauchy's theorem, and the argument principle. Those are the
  [contour integration roadmap](../ContourIntegration/README.md)'s. Layer 7 specializes them
  to a rectangle traversed around a completed L-function and identifies the resulting count
  with Layer 4's divisor sum; nothing here re-derives them.
- Effective and explicit constants. The zero-free regions here are of the shape
  `σ > 1 − c/log(q(|t|+2))` with `c` existentially quantified; Lagarias–Odlyzko-style
  effective Chebotarev is not in scope in either roadmap.
- The Selberg class, converse theorems, and degree classification.

### Interfaces supplied to other roadmaps

- **A zero-counting divisor for a completed L-function**, and the theorem that it agrees with
  `MeromorphicOn.divisor` on any open set where the completion is meromorphic. Any roadmap
  wanting "the zeros of `Λ` in a region, with multiplicity" should use this rather than a
  set-theoretic preimage of `{0}`.
- **Growth of `Gammaℝ` and `Gammaℂ` on vertical strips** (Layer 1). This is ordinary complex
  analysis of the Gamma function and is useful well outside this roadmap.
- **The analytic conductor** `q(s)` (Layer 2), with the comparison lemmas relating it to
  degree, arithmetic conductor, and spectral parameters. The modular forms roadmap pins the
  same Iwaniec–Kowalski (5.7) definition for its own analytic conductor; the two must agree,
  and the agreement is a milestone of Layer 2.
- **Order, the Weierstrass elementary factor, and Hadamard factorization at order at most one**
  (Layer 5), stated for a general entire function rather than only for `Λ`.

## Dependencies

| Dependency | Material consumed here | First consuming layer | Kind |
|---|---|---:|---|
| [L-functions roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/8) Layer 0 | the L-function data record, its polar divisor, and the Dirichlet-agreement, continuation, and functional-equation predicates | 0 | hard |
| L-functions roadmap Layer 0 | the arithmetic/analytic normalization translation, which is what makes "critical line" well defined | 0 | hard |
| L-functions roadmap Layer 3 | the completed Dedekind zeta function, its exact poles at `0` and `1`, and its functional equation | 6 | hard |
| L-functions roadmap Layer 5 | completed Hecke L-functions of primitive finite-order ray-class characters, entire, with `‖W(χ)‖ = 1` | 6 | hard |
| L-functions roadmap Layer 7 | nonvanishing on `Re s = 1` in meromorphic-order form, and the `3-4-1` positivity argument this layer makes quantitative | 6 | hard |
| L-functions roadmap Layer 7 | the ideal von Mangoldt coefficients and `−ζ'_K/ζ_K` as their Dirichlet series, its 7.6 | 8 | hard |
| [Contour integration roadmap](../ContourIntegration/README.md) Layers 0–3 | the winding number of a closed piecewise-`C¹` curve and its integrality off the curve (its 0–1), residues, the residue theorem, and the argument principle `(2πi)⁻¹ ∮_C f'/f = ∑_z ord_z f` (its 2), and the homology form of Cauchy's theorem, under which the general-cycle residue theorem holds (its 3) | 7 | hard |
| [Modular forms roadmap](../ModularForms/README.md) Layer 7 | the analytic conductor `𝔮(f,s)` of a newform, pinned as Iwaniec–Kowalski (5.7) | 2 | agreement only |
| Mathlib `Analysis/Complex/JensenFormula.lean` | `MeromorphicOn.circleAverage_log_norm`, `AnalyticOnNhd.sum_divisor_le` | 4 | existing |
| Mathlib `Analysis/Meromorphic/Divisor.lean` | `MeromorphicOn.divisor` as the multiplicity-carrying zero count | 4 | existing |
| Mathlib `Analysis/Complex/PhragmenLindelof.lean` | `vertical_strip` and the three-lines theorem | 3 | existing |
| Mathlib `Analysis/Normed/Module/MultipliableUniformlyOn.lean`, `Analysis/Calculus/LogDerivUniformlyOn.lean` | `multipliableLocallyUniformlyOn_one_add`, `logDeriv_tprod_eq_tsum` | 5 | existing |
| Mathlib `Analysis/Complex/BorelCaratheodory.lean` | `Complex.borelCaratheodory` | 5 | existing |

The L-functions roadmap ends at its prime-counting layer and states this roadmap as its
successor; nothing here is duplicated there.

## Standing hypotheses and conventions

| object | convention |
|---|---|
| normalization | Everything is stated in the **analytic** normalization: the functional equation reflects in `s ↦ 1 − s`, the critical strip is `0 ≤ Re s ≤ 1`, and the critical line is `Re s = 1/2`. An arithmetic-normalized instance reaches these theorems through the L-functions roadmap's translation, and every statement about the critical line for such an instance is that translation applied to a theorem here — never a restatement with a shifted line. |
| the zero object | The zeros of a completed L-function are recorded by `MeromorphicOn.divisor Λ U`, so multiplicity is always present and poles appear with negative order. A "zero of order `m`" means `divisor Λ U ρ = m`; "`Λ` has no zeros in `S`" means `0 ≤ divisor Λ U` fails nowhere on `S`, stated as `∀ ρ ∈ S, 0 ≤ divisor Λ U ρ` together with meromorphy. Set-theoretic zero sets appear only as a derived corollary, never as the primary statement. ⚠ `MeromorphicOn.divisor` is a total function with junk value `0` where `f` is not meromorphic on `U`, so meromorphy is a hypothesis of every theorem about a count, never a consequence of one. |
| counting convention | `N(T)` counts zeros of the *completed* function `Λ` with `0 < Im ρ ≤ T`, with multiplicity, and excludes the real axis. The symmetric count over `\|Im ρ\| ≤ T` is a separate named quantity, equal to `2N(T)` plus the real-axis contribution, and the relation is a theorem. Trivial zeros do not appear: they are the zeros of the gamma factor, and the completed function has none. |
| rectangles | A counting region is a closed rectangle `[σ₁, σ₂] × [t₁, t₂]`; a certificate requires `Λ` to be nonvanishing on its boundary, which is what makes the count stable. |
| finite order | An entire `f` has order `≤ A` when `f =O[cobounded] fun s ↦ Real.exp (‖s‖ ^ A')` for every `A' > A`. The order of `f` is the infimum of such `A`. Do not define order by a limsup of `log log` unless a lemma proves the two agree; the same goes for the Nevanlinna order `limsup log T(r,f)/log r` read off `ValueDistribution.characteristic`, which is a third definition and is not the one used here. |
| analytic conductor | `q(s) = N · ∏_j (\|s + μ_j\| + 3) · ∏_k (\|s + ν_k\| + 3)(\|s + ν_k + 1\| + 3)`, Iwaniec–Kowalski (5.7), with `q = q(0)`. Each `Gammaℂ(s + ν)` contributes the *pair* of shifts `ν, ν + 1` it splits into under duplication, not `(\|s + ν\| + 3)^2`: the two differ by a bounded ratio, and only the paired form is an equality with the modular forms roadmap's `𝔮(f,s)`. The `+3` is part of the convention, not a slack constant to be optimized. |
| gamma factors | `Complex.Gammaℝ`, `Complex.Gammaℂ` as in Mathlib, with the duplication formula `Gammaℝ_mul_Gammaℝ_add_one`. |

Work with a fixed completed L-function throughout; do not bundle "L-function with a
zero-free region" into a class.

## What Mathlib already has (consume)

- **Jensen's formula and disc zero counts.** `Mathlib/Analysis/Complex/JensenFormula.lean`:
  `MeromorphicOn.circleAverage_log_norm` (the circle average of `log ‖f‖` equals
  `log ‖trailing coefficient‖` plus the counting sum), `AnalyticOnNhd.circleAverage_log_norm`,
  and `AnalyticOnNhd.sum_divisor_le`, which bounds the number of zeros in a disc of radius
  `r` by the maximum modulus on a larger circle. Every counting statement in Layer 4 is
  proved from this rather than from the argument principle, which arrives only in Layer 7 and
  from another roadmap.
- **Divisors of meromorphic functions.** `Mathlib/Analysis/Meromorphic/Divisor.lean`:
  `MeromorphicOn.divisor f U : Function.locallyFinsuppWithin U ℤ` built from
  `meromorphicOrderAt`, with congruence lemmas, `AnalyticOnNhd.divisor_nonneg`, and
  `MeromorphicOn.divisor_restrict` (restriction along `V ⊆ U`). Local finiteness of the
  support comes from `Function.locallyFinsupp.locallyFiniteSupport` together with
  `LocallyFiniteSupport.finite_inter_support_of_isCompact`
  (`Mathlib/Topology/LocallyFinsupp.lean`), and `Function.locallyFinsuppWithin.finiteSupport`
  is the compact-domain shortcut. Also
  `Meromorphic/{Order,IsolatedZeros,NormalForm,FactorizedRational,TrailingCoefficient}.lean`,
  in particular `MeromorphicOn.extract_zeros_poles`, which writes a meromorphic `f` as
  `(∏ᶠ u, (· − u)^{divisor f U u}) • g` with `g` analytic and nonvanishing.
- **Nevanlinna theory, which does not do this roadmap's counting.**
  `Mathlib/Analysis/Complex/ValueDistribution/` has the proximity function, the log-counting
  function `Function.locallyFinsuppWithin.logCounting`, the characteristic function, and the
  First Main Theorem in both parts (`FirstMainTheorem.lean`). ⚠ None of it is a zero count:
  `logCounting` is the `ℝ`-valued log-weighted `N(r) = ∫₀ʳ (n(t) − n(0))/t dt + n(0) log r`,
  every definition centers its discs at the origin, and the theory is discs and circles where
  this roadmap counts in rectangles and in discs centered on the critical line. Layer 4
  therefore keeps its own `ℤ`-valued count and consumes `AnalyticOnNhd.sum_divisor_le`
  instead; the comparison with `logCounting` is a Layer 4 milestone so that the two counts
  are relatable rather than rival. Mathlib has no unintegrated `n(r,f)`.
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
  `Complex.Gamma`, `Gamma_ne_zero`, the reflection and duplication formulas, the digamma
  function, and `Gammaℝ`/`Gammaℂ` with `Gammaℝ_eq_zero_iff`. ⚠ There is **no** Stirling
  estimate for `Complex.Gamma`; `Analysis/SpecialFunctions/Stirling.lean` is the factorial
  asymptotic only, and `BohrMollerup` is the real characterization. Layer 1 builds this.
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

Order and type of an entire function, and finite order of a completed L-function. Growth of
`Gammaℝ` and `Gammaℂ` in vertical strips, and of their logarithmic derivatives: nothing in
Mathlib bounds `Γ(σ + it)` as `|t| → ∞`. The analytic conductor and its comparison lemmas.
Convexity bounds for the model class from Phragmén–Lindelöf. Zero counting in a rectangle
with multiplicity, and the counting function `N(T)`. The Weierstrass elementary factor and
the canonical product, Hadamard factorization for entire functions of order at most one, and
the resulting partial-fraction expansion of `Λ'/Λ`. The quantitative `3-4-1` argument and the
de la Vallée Poussin zero-free region for the Dedekind zeta function and for Hecke
L-functions, with the exceptional-zero disjunction. The Riemann–von Mangoldt formula, in the
degree-and-conductor-uniform form. The truncated Perron formula and the contour shift it
runs on. The explicit formula relating the ideal von Mangoldt sums to a sum over zeros.
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
them. What this roadmap adds on top is the specialization to a rectangle traversed around a
completed L-function (Layer 7) and the Perron-formula machinery (Layer 8).

---

## The build, in layers

Layers 0–5 are general analysis and depend on the L-functions roadmap only for the data
record. Layers 6–8 are the arithmetic payoff and depend on its Dedekind zeta and Hecke
L-function instances; 7 and 8 additionally consume the contour integration roadmap's residue
calculus. Layer 9 depends on Layer 4 only.

### Layer 0: growth predicates for a completed L-function

The data record of the L-functions roadmap carries coefficients, conductor, spectral
parameters, root number, a total representative of the completed function, and an exact polar
divisor. It records no growth, which is why no zero theorem can be stated against it as it
stands. This layer adds the growth predicates and proves the reductions between them.

1. `orderLE (f : ℂ → ℂ) (A : ℝ) : Prop`, for entire `f`: `∀ A' > A, f =O[cobounded ℂ] fun s ↦ Real.exp (‖s‖ ^ A')`.
   Basic API: closure under sums, products, and multiplication by a polynomial; `orderLE` for
   `exp`, for polynomials, and for `s ↦ exp (a * s)`.
2. `entireCompletion`: for a record satisfying the continuation predicate, the entire function
   obtained by clearing the polar divisor, `Λ₀(s) = (∏_p (s − p)^{polarOrder p}) · Λ(s)`, and
   the theorem that `Λ₀` is entire with `divisor Λ₀ univ = divisor Λ univ + polarOrder`. For
   the Dedekind zeta instance this is the classical `s(s−1)Λ_K(s)/2`; the normalizing constant
   is a matter of taste and is fixed here as `1`. ⚠ Mathlib's `completedRiemannZeta₀` is
   **not** this function: it clears the poles additively
   (`completedRiemannZeta s = completedRiemannZeta₀ s − 1/s − 1/(1 − s)`), so it is entire but
   its zeros are not the zeros of `Λ`. Every counting statement uses the multiplicative
   clearing defined here, and no lemma may silently substitute the Mathlib name.
3. `IsFiniteOrder`: `∃ A, orderLE (entireCompletion d) A`. The theorem `IsFiniteOrder → orderLE _ 1`
   is **not** free and is proved per family in Layer 6; the predicate does not assume it.
4. `HasVerticalStripGrowth`: for every `σ₁ < σ₂` there are `C, A` with
   `‖Λ(σ + it)‖ ≤ C (1 + |t|)^A` for `σ ∈ [σ₁, σ₂]` and `|t| ≥ 1`. Prove that this follows
   from `IsFiniteOrder` together with the functional equation and the Dirichlet-series bound
   on `Re s > 1`, by Phragmén–Lindelöf; that implication is the layer's main theorem and is
   what lets later layers assume only finite order.
5. The relation to the average coefficient bound: a record with the average Ramanujan bound
   has `L(s)` bounded on `Re s ≥ 1 + δ`, hence `Λ` of at most polynomial growth there. State
   this so that the vertical-strip bound has a starting edge.

Acceptance: the Dedekind zeta instance of the L-functions roadmap satisfies `IsFiniteOrder`
and `HasVerticalStripGrowth`, with the first proved in Layer 6 and the second derived here.

### Layer 1: Stirling asymptotics for the gamma factors

Complex analysis with no arithmetic content, and independently Mathlib-worthy. All of it is
missing upstream.

1. `Complex.log_Gamma_asymptotic`: on the sector `|arg s| ≤ π − δ`,
   `log Γ(s) = (s − 1/2) log s − s + log (2π)/2 + O(1/‖s‖)`, with a named branch of
   `log Γ` on the sector (`Complex.log ∘ Gamma` is fine there since `Gamma_ne_zero`).
2. `Complex.norm_Gamma_asymptotic`: `‖Γ(σ + it)‖ = √(2π) |t|^{σ − 1/2} exp(−π|t|/2) (1 + O(1/|t|))`
   uniformly for `σ` in a compact interval, as `|t| → ∞`. This is the estimate every later
   layer actually uses.
3. The digamma bound `Γ'/Γ(s) = log s + O(1/‖s‖)` on the same sector, from Mathlib's
   `Complex.digamma` plus 1.
4. The same three for `Gammaℝ` and `Gammaℂ`, by unfolding their definitions; and the
   consequence that `γ(s) = ∏ Gammaℝ(s + μ) ∏ Gammaℂ(s + ν)` is nonvanishing off the
   negative real translates and satisfies
   `log ‖γ(σ + it)‖ = (d/2)|t| ... ` — state the exact constant, with `d` the degree.
5. `Gammaℝ` and `Gammaℂ` have no zeros and simple poles at the expected points, with the pole
   set computed as a divisor (`Gammaℝ_eq_zero_iff` gives the reciprocal's zeros at the pin).

Acceptance: the estimates specialize at `d = 1`, `μ = {0}` to the classical
`‖Γ(s/2)‖` bound used in the Riemann–von Mangoldt formula for `ζ`.

### Layer 2: the analytic conductor

1. `analyticConductor (d) (s) : ℝ`, the Iwaniec–Kowalski (5.7) quantity from the conventions
   table, and `analyticConductor d 0` as the conductor of the family.
2. Comparison lemmas: monotonicity in `|Im s|`; `q(s) ≍ q · (|Im s| + 3)^{degree}` with
   explicit implied constants depending on the spectral parameters; `q(s) ≥ 1`; behavior
   under the normalization translation of the L-functions roadmap (`q` is invariant, and the
   spectral parameters shift).
3. Agreement with the modular forms roadmap's `𝔮(f,s)` for the newform instance. Since both
   roadmaps pin Iwaniec–Kowalski (5.7), this should be an equality after unfolding, and the
   milestone is to prove it rather than assert it.
4. The conductor of the Dedekind zeta instance: `q = |d_K|`, `q(s) ≍ |d_K| (|Im s| + 3)^{[K:ℚ]}`.
   The conductor of a Hecke L-function of a primitive character of conductor `𝔣`:
   `q = |d_K| 𝔑(𝔣)`.

### Layer 3: convexity in vertical strips

1. The Phragmén–Lindelöf input, packaged for the model class: if `Λ` is holomorphic on a
   closed strip minus finitely many poles, of finite order there, and bounded by
   `C(1 + |t|)^{a}` on the left edge and `C(1 + |t|)^{b}` on the right edge, then it is
   bounded by `C'(1 + |t|)^{\ell(σ)}` on the strip, `\ell` the linear interpolation. Consume
   `Complex.PhragmenLindelof.vertical_strip`; the work is checking its growth hypothesis
   (`isBigO_sub_exp_rpow`) from `IsFiniteOrder` and clearing poles.
2. The convexity bound for the model class:
   `‖L(1/2 + it)‖ ≪_ε q(1/2 + it)^{1/4 + ε}`, in the analytic normalization, for a record
   satisfying continuation, the functional equation, finite order, and the average
   coefficient bound. State the hypotheses exactly; this is the one general bound in the
   roadmap that does hold for the whole model class.
3. The trivial bound on `Re s = 1 + δ` from absolute convergence, and the reflected bound on
   `Re s = −δ` from the functional equation, which are the two edges the interpolation uses.

⚠ Subconvexity is out of scope. No milestone improves the exponent `1/4`.

### Layer 4: zero counting

1. `zeroDivisor`: for a record satisfying the continuation predicate, `MeromorphicOn.divisor Λ U`
   on an open `U`, together with the theorem that it is nonnegative away from the polar
   divisor's support, and `zeroDivisor` restricted to the support of `polarOrder` recovers
   `−polarOrder`.
2. `zeroCount (σ₁ σ₂ t₁ t₂ : ℝ) : ℤ`, the sum of `zeroDivisor` over the closed rectangle —
   finite because the rectangle is compact (`Function.locallyFinsuppWithin.finiteSupport`).
   Prove additivity over a subdivision of the rectangle, invariance under enlarging the
   rectangle across a zero-free boundary, and monotonicity in the region: where the divisor is
   nonnegative, the count over a sub-region is at most the count over the region, which is
   `MeromorphicOn.divisor_restrict` plus summation of a nonnegative function. That
   monotonicity is what the box-to-disc reduction of 4 runs on, so it is not decoration.
3. Jensen's bound on a disc: from `AnalyticOnNhd.sum_divisor_le` — hypotheses
   `0 < |r| < |R|`, `1 ≤ M`, `Λ₀` analytic on `closedBall c |R|`, `Λ₀ c ≠ 0`, and
   `‖Λ₀‖ ≤ M` on `sphere c |R|` — the number of zeros of `Λ₀` in `|s − c| ≤ r`, with
   multiplicity, is at most `log (M/‖Λ₀ c‖)/log (R/r)`. Its left-hand side is literally
   `zeroCount`, so no translation lemma is needed. Two milestones come with it:
   - the **trailing-coefficient variant**, which drops the hypothesis `Λ₀ c ≠ 0` in favor of
     `log ‖meromorphicTrailingCoeffAt Λ₀ c‖` on the right. The centers this roadmap uses lie
     on the critical line and can be zeros, so the variant is what the later items actually
     apply; `MeromorphicOn.circleAverage_log_norm` already tolerates `f c = 0`, and the
     ingredients are in `JensenFormula.lean`;
   - the deduction that a completed L-function with `HasVerticalStripGrowth` has
     `O(log q(iT))` zeros in a disc of radius `1` centered at `1/2 + iT`, `M` coming from the
     growth bound on a strip wide enough to contain the sphere of radius `R = 2`.
4. **Box-to-disc reduction.** A closed rectangle lies in the disc through its corners:
   `[σ₁, σ₂] × [t₁, t₂] ⊆ closedBall c r₀` with `c` the center and
   `r₀ = ½√((σ₂ − σ₁)² + (t₂ − t₁)²)`. ⚠ Only upper bounds transfer, by 2 and the
   nonnegativity of the divisor; the disc count exceeds the box count by the zeros in the four
   circular segments, and no combination of disc counts is an exact box count. Subdividing
   `[0,1] × [t, t+T]` into unit-height boxes puts each inside a disc of radius `√2/2` centered
   on the critical line at `1/2 + i(t + k + 1/2)`, so 3 applies to each. Milestones:
   `N(T + 1) − N(T) = O(log q(iT))`, one application of 3; and `N(T) = O(T log q(iT))`, the
   sum of `T + O(1)` of them. These are the strongest counting statements provable before the
   argument principle of Layer 7, and they are what the explicit formula's convergence uses.
5. `N (T : ℝ) : ℤ`, the count of zeros with `0 < Im ρ ≤ T` in the closed critical strip, with
   multiplicity, per the counting convention; the symmetric count `N± (T)` and the theorem
   `N± T = 2 * N T + (real-axis contribution)`, the last term computed from the functional
   equation and the reality of the coefficients where those hold.
   ⚠ The counting region is half-open in `Im`, hence not compact, so finiteness does **not**
   follow from `finiteSupport` as in 2. Take it instead from local finiteness of
   `divisor Λ Set.univ` on the compact closure, through
   `Function.locallyFinsupp.locallyFiniteSupport` and
   `LocallyFiniteSupport.finite_inter_support_of_isCompact`, and state the half-open count as
   the closed count minus the real-axis contribution.
6. Monotonicity and finiteness of `N`, and the theorem that the zeros of `Λ` are discrete —
   the model-class generalization of `isDiscrete_riemannZetaZeros`, which becomes a corollary.
7. **The comparison with Nevanlinna theory**, so that the two counts in the library are
   relatable: `zeroCount Λ₀ (closedBall 0 r)` is the classical unintegrated `n(r, Λ₀)`, which
   Mathlib does not name; `Function.locallyFinsuppWithin.logCounting (divisor Λ₀ univ)` is its
   log-weighted integral `N(r)`; the two are related by `n(r) log(R/r) ≤ N(R) − N(r)` for
   `r < R`, and `logCounting` satisfies Jensen's formula in the form
   `logCounting_divisor_eq_circleAverage_sub_const`. Interface hygiene, three or four lemmas,
   and it is what keeps a future Nevanlinna development from growing a second zero count.

### Layer 5: Hadamard factorization

The mathematics of this layer is entirely new — Mathlib has no order of an entire function,
no elementary factor, no canonical product, no genus, and no Weierstrass product even for
`Complex.Gamma` — but the infinite-product infrastructure is not. Locally uniform convergence
of `∏ (1 + f_i)`, holomorphy of the limit, and the logarithmic derivative of a product are all
upstream, and `Analysis/SpecialFunctions/Trigonometric/Cotangent.lean` carries the genus-`0`
case through end to end, from `Complex.multipliable_sineTerm` to the partial-fraction
expansion `Complex.cot_series_rep`. That arc is the model for 3 through 5 below; `Λ₀'/Λ₀` is
the same shape of statement as `π cot(πz)`. ⚠ `Analysis/Complex/Hadamard.lean` is the
three-lines theorem, not this.

1. The counting-function bound for an entire `f` of order `≤ A`: the number of zeros in
   `|s| ≤ r` is `O(r^{A + ε})`, from Layer 4.3. (Mathlib's First Main Theorem gives the
   integrated form `N(r, 0) ≤ log M(r) + O(1)` by
   `characteristic_sub_characteristic_inv_of_ne_zero` and `proximity_nonneg`; that is a check
   on this bound, not a second route to it, since it counts `N(r)` where the rest of this
   layer needs `n(r)`.)
2. The Weierstrass elementary factor `E_1(z) = (1 − z) exp z`, with the two estimates the rest
   of the layer runs on: `‖E_1(z) − 1‖ ≤ C‖z‖²` for `‖z‖ ≤ 1/2`, and the crude global bound
   `log ‖E_1(z)‖ ≤ C(1 + ‖z‖)` used off those discs.
3. The convergence exponent: for `f` of order `≤ 1` with zeros `ρ`, `∑_ρ ‖ρ‖^{-1-ε} < ∞` for
   every `ε > 0` — by partial summation from 1 — and hence `∑_ρ ‖ρ‖^{-2} < ∞`, which is the
   summable dominating sequence the next step wants. Then `∏_ρ E_1(s/ρ)` converges locally
   uniformly on `ℂ`, which is `multipliableLocallyUniformlyOn_one_add` applied to
   `E_1(s/ρ) = 1 + g_ρ(s)` with `‖g_ρ(s)‖ ≤ C‖s‖²‖ρ‖^{-2}` on a compact from 2; the product is
   entire and vanishes exactly on the `ρ` with the right multiplicities
   (`SummableLocallyUniformlyOn.differentiableOn`, `tprod_one_add_ne_zero_of_summable`).
4. Hadamard's theorem at order `≤ 1`: an entire `f` of order `≤ 1` with `f(0) ≠ 0` factors as
   `exp(a + bs) ∏_ρ E_1(s/ρ)`, the product over the zeros with multiplicity. State it for a
   general entire function, not for `Λ`. The half that needs work is that the quotient of `f`
   by the canonical product, entire and nonvanishing, is `exp` of a polynomial of degree at
   most the order: write it as `exp g` and bound `g` from a bound on `Re g` by
   `Complex.borelCaratheodory`, then conclude by the Cauchy estimates. The generality is fixed
   at order `≤ 1`, which is all a completed L-function has; the higher elementary factors
   `E_p` and the general genus are out of scope.
5. The consequence used later: `Λ₀'/Λ₀ (s) = b + ∑_ρ (1/(s − ρ) + 1/ρ)`, converging in the
   stated sense, and the positivity `Re ∑_ρ 1/(s − ρ) > 0` for `Re s > 1` that the
   zero-free-region argument runs on. This is `logDeriv_tprod_eq_tsum` applied to the product
   of 3, plus the derivative of the exponential factor.
6. `Re b = −∑_ρ Re(1/ρ)`, and the resulting bound on the number of zeros near a given height.

### Layer 6: zero-free regions

⚠ Each statement here names its family. There is no zero-free region for a general record
satisfying the Layer-0 predicates: the argument needs the Euler product, nonnegativity of the
von Mangoldt coefficients, and the `3-4-1` inequality, none of which the model class has.

1. **Finite order for the two families.** `Λ_K` (Dedekind zeta) and `Λ(χ, ·)` for a primitive
   finite-order ray-class character have order at most `1`. Proof: the Mellin representation
   of the L-functions roadmap's Layer 3/5 gives an integral bound; combine with the
   functional equation and Phragmén–Lindelöf. This discharges the hypothesis Layer 5 needs
   and closes the gap Layer 0.3 deliberately left open.
2. **Quantitative `3-4-1`.** For `σ > 1`,
   `3 (−ζ'_K/ζ_K)(σ) + 4 Re(−L'/L)(σ + it, χ) + Re(−L'/L)(σ + 2it, χ²) ≥ 0`,
   from `3 + 4cos θ + cos 2θ ≥ 0` and nonnegativity of the ideal von Mangoldt coefficients.
   This is the L-functions roadmap's Layer-7 argument with the inequality kept rather than
   discarded at the limit.
3. **The de la Vallée Poussin region for `ζ_K`.** There is `c > 0` such that `ζ_K` has no
   zero in `σ ≥ 1 − c/log(|d_K| (|t| + 3)^{[K:ℚ]})` — that is, in terms of the analytic
   conductor, `σ ≥ 1 − c/log q(it)` — with the single exception permitted in 4.
4. **The exceptional zero.** State the disjunction: either the region in 3 is zero-free, or
   there is exactly one zero in it, it is real and simple, and it is the zero of `L(χ, ·)`
   for a real character `χ`. Name it `exceptionalZero` and prove the uniqueness and reality;
   no milestone claims it does not exist. Siegel's theorem (an ineffective lower bound on
   `1 − β`) is out of scope.
5. **The region for Hecke L-functions.** The same statement for `L(χ, ·)`, `χ` a primitive
   finite-order ray-class character, with the conductor `|d_K| 𝔑(𝔣)` entering through the
   analytic conductor and with the same exceptional-zero disjunction for real `χ`.
6. **Qualitative corollaries**, recovering what the L-functions roadmap proved
   qualitatively: `Λ_K` has no zero with `Re s ∈ {0, 1}` (away from its poles), and the
   nonvanishing of `ζ_K` on `Re s = 1` is the boundary case of 3.

### Layer 7: the Riemann–von Mangoldt formula

⚠ This is where the count becomes exact, and an exact count is not a Jensen bound: Layer 4
gives inequalities, and equality needs the argument principle. Mathlib has none of the
contour machinery, and this roadmap does not build it. The
[contour integration roadmap](../ContourIntegration/README.md) does: its Layers 0–1 build the
winding number of a closed piecewise-`C¹` curve, its Layer 2 the residue theorem and the
argument principle `(2πi)⁻¹ ∮_C f'/f = ∑_z ord_z f`, and its Layer 3 the homology form of
Cauchy's theorem, which is the hypothesis under which the residue theorem holds for a cycle
that is not a circle. Consume those. What is built here is their specialization to the
rectangles of Layer 4 and to a completed L-function.

1. **The rectangle as a contour.** The positively oriented boundary `∂R` of a closed rectangle
   as a closed piecewise-`C¹` curve in that roadmap's sense, with winding number `1` about
   each interior point and `0` about each exterior point (its Layer 0: integrality and
   homotopy invariance off the curve), and null-homologous in every open set containing `R`.
   These are exactly the hypotheses its residue theorem takes, so this item is what makes the
   rest of the layer applicable rather than merely plausible.
2. **The argument principle for a completed L-function on a rectangle.** For `Λ` meromorphic
   on a neighborhood of `R` and nonvanishing on `∂R`, `(2πi)⁻¹ ∮_{∂R} Λ'/Λ = zeroCount Λ R`.
   The work is the compatibility lemma identifying the contour roadmap's `∑_z ord_z Λ` with
   Layer 4's sum of `MeromorphicOn.divisor Λ R`: both are read off `meromorphicOrderAt`, and
   proving they agree is what keeps the library from carrying two zero counts. With it, a
   count over a boundary-nonvanishing rectangle is computed rather than bounded.
3. **The argument-variation form.** `zeroCount Λ R` equals the winding number about the origin
   of the image curve `Λ ∘ ∂R`, hence `(2π)⁻¹` times the variation of `arg Λ` along `∂R`. This
   is the form Backlund's method for `S(T)` runs on; the bound it needs on the number of sign
   changes of `Re Λ` along a horizontal segment is a Jensen argument on discs, from Layer 4.3.
4. **For `ζ`, first.** `N(T) = (T/2π) log (T/2πe) + O(log T)`, with `N` as in Layer 4.5.
   Proof by 2 on the rectangle `[−1, 2] × [0, T]`, applied to the entire completion
   `s(s−1)Λ(s)` of Layer 0.2 rather than to `Λ` — whose poles at `0` and `1` sit on the lower
   edge, so the nonvanishing hypothesis of 2 fails for it and clearing them is exactly what
   Layer 0.2 is for — with Layer 4.1 relating the two counts, Layer 1 for the gamma factor,
   and Layer 3 for `‖ζ‖` on the right edge.
5. **For the two families, uniformly in the conductor.** For `Λ_K` of degree `n = [K:ℚ]` and
   conductor `|d_K|`,
   `N_K(T) = (T/π) log ( |d_K| (T/2πe)^{n} ) + O(log(|d_K| T^n))`
   for `T ≥ 2`, the count being over `|Im ρ| ≤ T` with multiplicity; and the same shape for
   `L(χ, ·)` with `|d_K| 𝔑(𝔣)` in place of `|d_K|`. ⚠ The two counting conventions differ by
   a factor of two; state which each formula uses and prove the relation from Layer 4.5. The
   main term must carry the degree and the conductor explicitly — a formula stated only for
   `ζ` does not discharge this milestone.
6. **Gap and density corollaries** in the same generality; the specialization of 5 to
   `K = ℚ` recovering 4; and the main term for the unit-height count `N(T + 1) − N(T)`, which
   Layer 4.4 bounds by `O(log q(iT))` without any contour integral and which differencing 5
   turns into an asymptotic.

### Layer 8: the explicit formula

1. The Mellin/contour input: the truncated Perron formula
   `(2πi)⁻¹ ∫_{c−iT}^{c+iT} x^s/s ds = 1_{x > 1} + O(x^c/(T |log x|))` for `c > 0`, and the
   contour shift that moves the line of integration past the pole at `s = 1` and past the
   zeros. ⚠ Mathlib has `mellinInv_mellin_eq` and no Perron formula; the residue bookkeeping
   the shift needs is the contour integration roadmap's residue theorem (its Layer 2) together
   with the homology form of Cauchy's theorem (its Layer 3), consumed here as in Layer 7. The
   Perron formula itself, and the estimates on the horizontal and left edges of the shifted
   contour, are milestones of this layer.
2. The explicit formula for `ψ_K`, in the form
   `ψ_K(x) = x − ∑_{|Im ρ| ≤ T} x^ρ/ρ + (archimedean and pole terms) + O(x (log x)^2/T)`,
   with every term named and the archimedean contribution computed from the gamma factor.
3. The Weil-style test-function form,
   `∑_ρ φ̃(ρ) = (archimedean term) − ∑_𝔭 ∑_m (prime term) + (pole terms)`, over the following
   class and no other: `φ : ℝ → ℝ` with `ContDiff ℝ ⊤ φ`, `HasCompactSupport φ`, and
   `tsupport φ ⊆ Set.Ioi 0`, paired through the Mellin transform
   `φ̃(s) = ∫_0^∞ φ(x) x^{s−1} dx`. Prove what makes the statement well formed: `φ̃` is entire
   (differentiation under the integral over a compact support away from `0`), it decays faster
   than any power of `|Im s|` on every vertical strip (integration by parts, once per power),
   and the zero side `∑_ρ φ̃(ρ)` converges absolutely — the last from Layer 4.4's
   `N(T + 1) − N(T) = O(log q(iT))` against that decay. The equivalent presentation over even
   `C_c^∞(ℝ)` in the coordinate `x = log y` is the same theorem and is proved as a corollary,
   not stated as a second milestone. ⚠ The class is fixed here and the wider Paley–Wiener
   class of transforms of compactly supported distributions is out of scope; a hypothesis on
   `h` is never an adjective.
4. Consequences: the zero-free region of Layer 6 plus the explicit formula give
   `ψ_K(x) = x + O(x exp(−c √(log x)))`, the classical error term for the prime ideal
   theorem, strengthening the L-functions roadmap's asymptotic statement.

### Layer 9: certified zeros

The LMFDB stores lists of zeros with certified accuracy. This layer says what such a list
means. It depends on Layer 4 only, so it can be built early.

1. `HasZerosInBoxes`: given a completed L-function `Λ`, a closed rectangle `R`, a finite list
   of pairwise disjoint closed boxes `B_1, …, B_n ⊆ R`, and multiplicities `m_1, …, m_n`, the
   predicate saying that `Λ` is nonvanishing on `∂R` and on each `∂B_j`, that
   `zeroCount B_j = m_j`, and that `zeroCount R = ∑_j m_j` — so the list is *complete* in `R`,
   not merely a list of zeros that happen to be there. Completeness is the whole content;
   a predicate that omits the last clause is useless and must not be the one exported.
2. Stability: the predicate is preserved under shrinking `R` to a rectangle still containing
   every `B_j`, and under replacing a box by a smaller one containing the same zeros.
3. `AllOnCriticalLine`: each `B_j` meets the line `Re s = 1/2`. Combined with 1 this is the
   statement "the first `n` zeros are on the critical line, and there are no others below
   height `T`". Note explicitly that this is a statement in the analytic normalization; for an
   arithmetic-normalized instance it is the translation of this statement, and the
   translation lemma is Layer 0's.
4. `GRH`, as a `Prop` over the two families: every zero of `Λ` in the critical strip has
   `Re ρ = 1/2`. Prove that for `K = ℚ` and the trivial character it is `RiemannHypothesis`,
   which is the only thing making the definition trustworthy.
5. The boundary convention: a zero *on* `∂B_j` is not counted by `HasZerosInBoxes`, which is
   why nonvanishing on the boundary is a hypothesis rather than a conclusion. Prove that if
   `Λ` has a zero on `∂R` then no certificate for `R` exists, so the hypothesis cannot be
   dropped.

## Worked examples (acceptance criteria)

- **`ζ`'s trivial zeros are not zeros of `Λ`.** `completedRiemannZeta` has no zeros at
  `s = −2, −4, …`; the trivial zeros of `riemannZeta` are the poles of `Gammaℝ`. Verify that
  `zeroDivisor` for the ζ instance is supported in the critical strip. Catches the most
  common confusion between `L` and `Λ`.
- **The first zero of `ζ`.** A certificate in the sense of Layer 9 for the rectangle
  `[0,1] × [0,15]` with one box around `1/2 + 14.134725…i` and multiplicity `1`. The
  numerical verification is not in scope; the milestone is that the *statement* is
  well formed and that its hypotheses are exactly what a certificate would have to supply.
- **`N(T)` for `ζ` at `T = 100`.** `N(100) = 29`. Checks the counting convention: the
  symmetric count is `58`, and getting `29` rather than `58` is the point.
- **`ζ_{ℚ(i)}` versus `ζ · L(χ₋₄)`.** The zero divisors add. Catches multiplicity handling,
  since a common zero would have order `2` on the left.
- **Degree and conductor in the main term.** For `K` imaginary quadratic of discriminant `D`,
  Layer 7.5 reads `N_K(T) = (T/π) log(|D| (T/2πe)^2) + O(log(|D|T^2))`. Verify that this is
  the sum of the ζ and `L(χ_D)` counts, which is a real consistency check on the constants.
- **Layers 7 and 9 count the same integer.** The hypotheses of the argument principle in
  Layer 7.2 — `Λ` meromorphic on a neighborhood of `R`, nonvanishing on `∂R` — are exactly
  what `HasZerosInBoxes` supplies, and `zeroCount` is the same object on both sides. Verify
  that a certificate's count is the contour integral of Layer 7.2. Catches a divergence
  between the two layers' rectangle conventions, which would otherwise surface only when
  someone tries to certify a zero using Riemann–von Mangoldt.
- **A boundary zero blocks a certificate.** For the rectangle `[0,1] × [−1,1]` and the
  instance `Λ_K`, no certificate exists in the sense of Layer 9 unless the boundary is moved,
  because of the pole at `s = 1`. Catches the pole/zero confusion in the certificate
  predicate.
- **The exceptional zero is not excluded.** Verify that the Layer-6 statement, instantiated
  at a real character, is a disjunction and that neither branch is provable from the other
  milestones. This is a scope check rather than a theorem.

## Ordering — the dependency graph

```
  L-functions roadmap Layer 0 ─┬─▶ 0 growth predicates ─┬─▶ 3 convexity ──┐
                               │                        │                 │
  Mathlib Gamma ──────────────▶ 1 Stirling ─────────────┼─────────────────┼─▶ 6 zero-free
                               │                        │                 │      regions
  Mathlib Jensen/Divisor ─────▶ 4 counting ──▶ 5 Hadamard ────────────────┘        │
                               │      │                                            │
  Modular forms Layer 7 ──────▶ 2 analytic conductor                               │
                                      │                                            ▼
                                      └──▶ 9 certificates          7 Riemann–von Mangoldt
                                                                                   │
  Contour integration Layers 0-3 ──────────────────────────────────────────────────┤
                                                                                   │
  L-functions roadmap Layers 3,5,7 ────────────────────────────────────────────────┴─▶ 8 explicit formula
```

Layers 1, 2, and 9 are independent of each other and of Layer 0 beyond the data record, so
three contributors can start at once. Layer 4 needs only Mathlib and the continuation
predicate. Layer 6 is the first place the arithmetic instances are needed, and it is where
the L-functions roadmap's Layers 3, 5, and 7 must already be finished. Layers 7 and 8 are
also where the contour integration roadmap's residue calculus is needed, and everything
before them is stated and proved without it.

## References

- H. Iwaniec, E. Kowalski, *Analytic Number Theory*, AMS Colloq. 53 — the source of record:
  ch. 5 (the axioms, the analytic conductor (5.7), the convexity bound, zero counting (5.24)),
  ch. 5.7 and ch. 10 (zero-free regions and the explicit formula), ch. 16 (zeros).
- H. Davenport, *Multiplicative Number Theory*, 3rd ed. — the classical zero-free region,
  the exceptional zero, and the explicit formula for `ψ`, in the shape Layer 6 and Layer 8
  follow.
- E. C. Titchmarsh (rev. Heath-Brown), *The Theory of the Riemann Zeta-Function* — ch. 9 for
  `N(T)` and the Riemann–von Mangoldt formula.
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110 — ch. XVII for the explicit formula in
  the number-field setting, and ch. XV for the analytic input Layer 6 makes quantitative.
- J. Neukirch, *Algebraic Number Theory* — ch. VII §§5, 8 for the completed functions whose
  zeros these are.
- The [L-functions roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/8), which
  constructs everything this roadmap takes as given, and whose conventions table this one
  extends rather than restates.
- The [contour integration roadmap](../ContourIntegration/README.md), which builds the residue
  calculus and the argument principle that Layers 7 and 8 consume.
