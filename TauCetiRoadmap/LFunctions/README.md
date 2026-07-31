# Roadmap: L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems

Mathlib's L-series library is one of its strongest arithmetic assets. At the pin
(`9caeba1000`, 2026-06-03), `Mathlib/NumberTheory/LSeries/` is a 21-file, ~6900-line stack
(David Loeffler, Michael Stoll, with Xavier Roblot, Chris Birkbeck, Huanyu Zheng; the design
paper is Loeffler–Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959) that
already contains: the L-series `LSeries f s = ∑' n, f n / n ^ s` with a complete
abscissa-of-absolute-convergence theory (`LSeries.abscissaOfAbsConv`), linearity, Dirichlet
convolution (`⍟`), derivatives, coefficient injectivity, and positivity; the abstract
Mellin-transform functional-equation engine `WeakFEPair`/`StrongFEPair`
(`LSeries/AbstractFuncEq.lean`) with `Λ(k − s) = ε • Λ^∨(s)`, entirety, and residue
computations; the completed Riemann zeta function with its functional equation
(`completedRiemannZeta_one_sub : Λ(1 − s) = Λ(s)`), values (`riemannZeta_two`,
Bernoulli formulas), and trivial zeros; the full even/odd Hurwitz zeta theory; L-functions of
functions on `ZMod N` and of Dirichlet characters with analytic continuation, Gamma factors,
Gauss-sum root number, and the functional equation
(`DirichletCharacter.IsPrimitive.completedLFunction_one_sub`); non-vanishing on the closed
half-plane `Re s ≥ 1` (`DirichletCharacter.LFunction_ne_zero_of_one_le_re`,
`riemannZeta_ne_zero_of_one_le_re`); Dirichlet's theorem on primes in arithmetic progression
(`Nat.infinite_setOf_prime_and_eq_mod`); and discreteness of the zeta zeros
(`isDiscrete_riemannZetaZeros`). Next door sit Deligne's archimedean Gamma factors `Gammaℝ`,
`Gammaℂ` with the duplication formula (`Gamma/Deligne.lean` — whose docstring already names
the Dedekind zeta function as the intended consumer), the abstract Euler-product machinery
(`Mathlib/NumberTheory/EulerProduct/`), Abel summation, Chebyshev's `ψ/θ` bounds (upstreamed
from PrimeNumberTheoremAnd), the Frobenius vocabulary `IsArithFrobAt`/`arithFrobAt` with
well-defined conjugacy classes (`Mathlib/RingTheory/Frobenius.lean`), and — decisive for this
roadmap — Roblot's `NumberField.dedekindZeta` with the **Dirichlet class number formula**
(`tendsto_sub_one_mul_dedekindZeta_nhdsGT`) resting on his ideal-counting asymptotics and
unit-fundamental-domain machinery (`NumberField/CanonicalEmbedding/FundamentalCone.lean`,
`NumberField/Ideal/Asymptotics.lean`).

And yet the subject the LMFDB's central section is *about* barely exists upstream. At the pin
there is **no data model** for an L-function (nothing carries a degree, conductor, Gamma
data, root number, or motivic weight; even `‖rootNumber χ‖ = 1` is unproved for Dirichlet
characters); `dedekindZeta` is a leaf with **no Euler product, no analytic continuation
past `Re s > 1`, and no functional equation** (the file's own TODO asks to generalize the
construction); there are **no Hecke characters and no Hecke L-functions** (the only `Hecke` hits at the
pin are the cusp-form coefficient bound `CuspFormClass.qExpansion_isBigO` and
bibliography lines; `Grossencharacter` has zero matches); **no prime-density notion of any kind** (the only
density in Mathlib is `schnirelmannDensity`); **no Chebotarev** (zero matches on the pin
and on today's master — though the ecosystem is moving fast here, see *What is in motion*);
**no Landau theorem, no Tauberian theorem, no PNT, no Mertens**; no zero-free region and no
zero counting; modular forms have no L-series hook; and `WeierstrassCurve.LFunction` is a
theorem-free formal Dirichlet series without a conductor. This roadmap builds that layer:
the LMFDB's L-function axiomatics as honest predicates over `LSeries`, the analytic
continuation and functional equation of the Dedekind zeta function by Hecke's method on the
pin's own Minkowski-space machinery, Hecke L-functions of ray-class characters and general
Grossencharacters, the density theory culminating in the **Chebotarev density theorem**, the
prime-counting layer by coordination with PrimeNumberTheoremAnd, and the instance ledger
wiring every other roadmap's L-functions into one frame.

Suggested home: `TauCeti/NumberTheory/LFunctions/`, with subdirectories per layer
(`DataModel/`, `IdealSeries/`, `Theta/`, `DedekindZeta/`, `SpecialValues/`, `HeckeL/`,
`Grossencharacter/`, `Nonvanishing/`, `Density/`, `PrimeCounting/`, `Zeros/`). The
Dedekind-zeta files should be positioned to refactor onto
`Mathlib/NumberTheory/NumberField/DedekindZeta.lean` (same namespace `NumberField`), whose
TODO they discharge.

This roadmap is part of the 2026-07-30 wave and has one upstream sibling dependency: it
**consumes** [GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md) (roadmap in
preparation) for everything ray-class — moduli, ray class groups `J^𝔪/P^𝔪`, their
characters, and the idele-class description. The split is: **GCFT owns the character
algebra; this roadmap owns their L-functions and every analytic statement.** Chebotarev is
deliberately here, not in GCFT (its plan says so), and its pinned proof route (Layer 8) is
the CFT-free one, so the whole density lane runs without GCFT; only Layer 5's *inputs* (the
characters themselves) and the ray-class equidistribution statement wait on GCFT's
definitions. It **aligns** with [LocalFields](../LocalFields/README.md) (sibling in
review on branch `roadmap/local-fields`) on Frobenius and Euler-factor conventions (arithmetic
Frobenius, uniformizer ↦ Frobenius normalization), **serves**
[NumberFieldArithmetic](../NumberFieldArithmetic/README.md) (in preparation; owns the
uniform decomposition/Frobenius/Artin-symbol API this roadmap's Chebotarev statements will
refactor onto), the Wave-2 **ArtinRepresentations** roadmap ("Wave 2" here and below =
the planned second wave of LMFDB-background roadmaps, following the current Wave 1 this
roadmap belongs to; it will consume Layers 5–6 as the Hecke-L engine behind Brauer
induction), **SatoTateGroups** (equidistribution
interface, Layer 6), and the LMFDB semantics of every object's L-function page.

## Standing hypotheses

Work over a number field `K` with `[Field K] [NumberField K]`; write `𝓞 K` for
`NumberField.RingOfIntegers K`. Spell hypotheses out; do not bundle them into new classes.
Coefficients live in `ℂ`; an L-series is always Mathlib's `LSeries` of a coefficient
function `ℕ → ℂ` (the `n = 0` term is dropped by `LSeries.term`), and ideal-indexed series
enter *only* through the named norm-coefficient bridge of Layer 1 — never as a rival
`Ideal`-indexed summation theory. Real-limit statements at `s = 1` use the `𝓝[>] 1` idiom of
the pin's class number formula. Do not assume `K ≠ ℚ`: every construction must recover the
classical object at `K = ℚ` (`dedekindZeta ℚ` versus `riemannZeta` is a worked example, not
an afterthought). Characters of ray class groups are consumed from
[GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md) once its ray-class layer
exists; until then the modulus-one case (characters of `ClassGroup (𝓞 K)`, pin-expressible)
is the stand-in, and no milestone below bakes a particular ray-class-group *encoding* into
its statement. ⚠ Junk values are a standing trap: `LSeries f s = 0` where not summable, so
`dedekindZeta K` is **not** equal to any continued function off `Re s > 1` — identities
between continued L-functions must be stated for the continued objects built here, and
region hypotheses (`1 < s.re`) must appear on every series-level identity. The pin's own
`riemannZeta_one_ne_zero` ("the junk value at `s = 1` happens to be nonzero") shows the
care required.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| L-series carrier | `LSeries f s = ∑' n, LSeries.term f s n`, `f : ℕ → ℂ`; scoped notation `L`, `↗`, `δ`, `⍟`; abscissa via `LSeries.abscissaOfAbsConv` (absolute convergence — the only abscissa at the pin) | `Mathlib/NumberTheory/LSeries/{Basic,Convergence}.lean` |
| Gamma factors | `Complex.Gammaℝ s = π ^ (-s/2) * Gamma (s/2)`, `Complex.Gammaℂ s = 2 * (2*π) ^ (-s) * Gamma s`; duplication `Gammaℝ_mul_Gammaℝ_add_one : Gammaℝ s * Gammaℝ (s+1) = Gammaℂ s`. ⚠ Sources drift by constants here: Lang's completed zeta uses bare `Γ(s/2)^{r₁} Γ(s)^{r₂}` and differs from ours by `2^{r₂}`; such factors are FE-invariant but change nothing-else — never mix normalizations inside one statement | `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean`; LMFDB Γ_ℝ/Γ_ℂ |
| completed L-function | conductor power **included**: `Λ(s) = N^{s/2} · γ(s) · L(s)` with `γ` a product of `Gammaℝ (s + μ)` and `Gammaℂ (s + ν)` factors; then the FE is constant-free, `Λ(s) = ε · Λ^∨(1 − s)` with `‖ε‖ = 1` and `Λ^∨(s) = conj (Λ (conj s))` (the dual = conjugate L-function). The pin's `DirichletCharacter.completedLFunction` does *not* include `N^{s/2}` (its FE carries `N ^ (s - 1/2)`); the dictionary between the two shapes is a named lemma of Layer 0 | Layer 0; matches LMFDB semantics and Neukirch VII (8.6) |
| completed Dedekind zeta | `Λ_K(s) = |d_K|^{s/2} · Gammaℝ(s)^{r₁} · Gammaℂ(s)^{r₂} · ζ_K(s)`; FE `Λ_K(s) = Λ_K(1 − s)`; simple poles at `s = 0, 1` only; `Res_{s=1} ζ_K = 2^{r₁}(2π)^{r₂} h R / (w √|d_K|)` = the pin's `dedekindZeta_residue` | Layer 3; Neukirch VII (5.10)/(5.11) |
| Hecke L conductor | for `χ` primitive mod `𝔪` the completed level is `|d_K| · 𝔑(𝔪)`: `Λ(χ, s) = (|d_K| 𝔑(𝔪))^{s/2} L_∞(χ, s) L(χ, s)`, FE `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)`, `‖W(χ)‖ = 1` | Layer 5; Neukirch VII (8.6) |
| Euler factors | Galois type at a finite prime `𝔭`: `det(1 − Frob_𝔭 · 𝔑𝔭^{-s} ∣ V^{I_𝔭})⁻¹` with **arithmetic** Frobenius — "Frobenius" unqualified always means arithmetic (`x ↦ x^q` on residue fields), the pin's `IsArithFrobAt`/`arithFrobAt` and the LocalFields convention; the geometric-Frobenius form (Deligne) is a translation lemma, never a second convention. For a ray-class character: `(1 − χ(𝔭) 𝔑𝔭^{-s})⁻¹` at `𝔭 ∤ 𝔪` and `1` at `𝔭 ∣ 𝔪` (`χ` primitive), compatible under the Artin map with the Galois form because GCFT's reciprocity sends uniformizers to arithmetic Frobenius | [LocalFields](../LocalFields/README.md) convention table; Layer 1 |
| arithmetic vs analytic normalization | analytic (unitary): coefficients bounded on average, FE center `s = 1/2`. Arithmetic (motivic weight `w`): FE center `s = (w+1)/2`. The dictionary `L_arith(s) = L_an(s − w/2)` is a **named definition plus translation lemmas**, not a convention drift; the dictionary carries `w` and relates both normalizations of the same instance. LMFDB stores both; degree, conductor, root number are normalization-independent | Layer 0 |
| spectral parameters | Gamma data is carried as the multisets `{μ_j}` (for `Gammaℝ(s + μ_j)`) and `{ν_k}` (for `Gammaℂ(s + ν_k)`); `degree = #μ + 2·#ν`. LMFDB's `mu`/`nu` lists | Layer 0 |
| Frobenius | `arithFrobAt R G Q` with `IsArithFrobAt` and conjugacy well-definedness `isConj_arithFrobAt`; decomposition group is `MulAction.stabilizer G Q` (there is no `decompositionSubgroup` for ideals at the pin); statements refactor onto NumberFieldArithmetic's Frobenius API when it lands | `Mathlib/RingTheory/Frobenius.lean`; Layer 8 |
| Dirichlet density | `d(M) = lim_{s→1⁺} (∑_{𝔭∈M} 𝔑𝔭^{-s}) / log((s−1)⁻¹)` along `𝓝[>] 1` (real `s`) | Layer 8; Neukirch VII (13.1) |
| natural density | `δ(M) = lim_{x→∞} #{𝔭 ∈ M ∣ 𝔑𝔭 ≤ x} / #{𝔭 ∣ 𝔑𝔭 ≤ x}`; `δ` exists ⇒ `d` exists and they agree (named lemma, Layer 8); the converse is **false** (leading-digit example) — Chebotarev is stated for Dirichlet density in Layer 8 and upgraded to natural density in Layer 9, and the LMFDB-facing form is the natural one | Layer 8/9 |
| polar density | `m/n` where `ζ_{K,T}(s)^n` extends meromorphically near `s = 1` with a pole of order `m` (Marcus/Milne); exists ⇒ Dirichlet density exists and agrees; the tool that makes the splitting-density theorem CFT-free | Layer 8; Milne CFT VI §3 |
| FE proof route | **Hecke's theta method** (pinned decision, next section); Tate's adelic route is a Long-horizon comparison layer coordinated with FLT, not the proving route here | this roadmap |

## The route decision: Hecke's theta proof, Tate's thesis later

The planning document left the Dedekind/Hecke functional-equation route — (A) Hecke's
classical theta-function proof versus (B) Tate's thesis — to be decided after the live
audit, with a stated default of (B). **The audit reverses the default: this roadmap pins
route (A), Hecke's proof, as the proving route for Layers 2–6, with the adelic treatment as
a Long-horizon comparison layer.** Rationale, in decreasing order of weight:

1. **Route A is the designed continuation of the pin's own FE technology.** Every completed
   functional equation in Mathlib (ζ, Hurwitz even/odd, `ZMod`, Dirichlet) is proved by
   exactly Hecke's method in dimension 1: a theta kernel, its Poisson-summation
   transformation, and the Mellin-transform engine `WeakFEPair`/`StrongFEPair`. The number
   field case is the same skeleton one dimension up (Lang XIII and Neukirch VII §§3–8 are
   400 lines of mathematics away, not a new theory), and the Loeffler–Stoll line even
   staged the multivariate Fourier prerequisite (`Analysis/Fourier/AddCircleMulti.lean`,
   Loeffler 2023 — multivariate Fourier series with uniform convergence, which is the proof
   engine for lattice Poisson summation).
2. **The shared hard core already exists at the pin.** Both routes need the same genuinely
   hard input (Lang's ch. XIII item vs. its adelic twin in ch. XIV): a fundamental domain
   for the unit action on the norm-one hypersurface of Minkowski space with measure
   proportional to the regulator. That is precisely what Roblot built for the class number
   formula (`NumberField/CanonicalEmbedding/FundamentalCone.lean`, `NormLeOne.lean`,
   `Ideal/Asymptotics.lean`, `ZLattice/Covolume.lean`). Route A consumes it directly; route
   B would rebuild it inside an idele-class fundamental domain.
3. **Route B's prerequisites are absent and serve no Wave-1 consumer.** Tate's thesis needs
   Fourier analysis on local fields and adeles: self-dual characters, Schwartz–Bruhat
   functions, self-dual Haar normalizations (`vol(𝒪) = 𝔑𝔇^{-1/2}`), restricted-product
   integration, adelic Poisson summation/Riemann–Roch, and compactness/discreteness of
   `𝔸_K/K` — none of which exists at the pin (the adele ring stops at its definition plus
   local compactness of the infinite part; there is no idele class group, and Pontryagin
   duality/Fourier inversion at LCA generality — which Lang *assumes* — is itself
   incomplete in Mathlib). These are wonderful targets, but they belong to the
   adelic/automorphic program (FLT's terrain), not on the critical path of the LMFDB
   background.
4. **Route A suffices for every deliverable of this roadmap**, including general
   Grossencharacters: Neukirch VII §§6–8 (the on-hand primary source) executes Hecke's
   proof in full generality — theta series with `N(x^p)` weights, Gauss sums, root number
   `W(χ)` with `|W(χ)| = 1` (Theorem (8.5)/Corollary (8.6)). Lang warns (ANT p. 243) that
   his ch. XIII does ζ_K only and that he does characters "only in Tate's version" — so
   Neukirch, not Lang, is the source of record for Layers 5–6.
5. **The cross-check is a theorem, not a hope.** Both routes produce literally the same
   completed function (Lang XIV Cor. 3 = XIII Thm 2). When the adelic layer arrives (Long
   horizon, in coordination with FLT — which needs adelic infrastructure regardless), its
   acceptance criterion is equality with Layer 3/5's `Λ`, and every consumer downstream of
   this roadmap is insulated from the route by the Layer-0 interface.

Costs accepted with this decision, recorded honestly: the general-Grossencharacter layer
(Layer 6) inherits Hecke's per-infinity-type bookkeeping (route B is uniform in the
character — its real elegance); and the theta route does not by itself produce the local
epsilon-factor factorization `W(χ) = ∏ W_v(χ)` (Tate/Deligne local constants), which is
deliberately deferred to the ArtinRepresentations roadmap's ε-factor layer and the
Long-horizon adelic layer.

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03) file by file. Exact names matter; the
naming quirks are the pin's, not typos here.

- **L-series core:** `Mathlib/NumberTheory/LSeries/Basic.lean` (`LSeries`, `LSeriesSummable`,
  `LSeriesHasSum`, `LSeries.term`, `LSeries.delta`, scoped notation `L`/`↗`/`δ`, `O(n^{x-1})`
  summability criteria); `Convergence.lean` (`LSeries.abscissaOfAbsConv` into `EReal`, with
  `LSeriesSummable_of_abscissaOfAbsConv_lt_re`, `abscissaOfAbsConv_le_of_isBigO_rpow`);
  `Linearity.lean`; `Convolution.lean` (`LSeries.convolution` = `⍟`, `LSeries_convolution'`,
  `abscissaOfAbsConv_convolution_le`); `Deriv.lean` (`LSeries_hasDerivAt`,
  `LSeries_analyticOnNhd`, `LSeries.logMul`, iterated derivatives; note the pin's misspelled
  `LSeries.absicssaOfAbsConv_logPowMul`); `Injectivity.lean` (`LSeries_injOn`,
  `LSeries_eq_iff_of_abscissaOfAbsConv_lt_top` — coefficients are determined);
  `Positivity.lean` (`LSeries.positive`, `LSeries.positive_of_differentiable_of_eqOn` — the
  pin's Landau-substitute); `SumCoeff.lean` (Roblot: `LSeriesSummable_of_sum_norm_bigO`,
  `LSeries_eq_mul_integral`, and the residue bridge
  `LSeries_tendsto_sub_mul_nhds_one_of_tendsto_sum_div(_and_nonneg)`).
- **The FE engine:** `LSeries/AbstractFuncEq.lean` — `WeakFEPair`/`StrongFEPair` (fields
  `f g : ℝ → E`, weight `k`, root number `ε`, constant terms `f₀ g₀`, decay and FE
  hypotheses), `StrongFEPair.functional_equation : Λ (k − s) = ε • symm.Λ s`,
  `WeakFEPair.functional_equation`, `differentiable_Λ₀`, `differentiableAt_Λ`,
  `Λ_residue_k : (s − k) • Λ s → ε • g₀`, `Λ_residue_zero : s • Λ s → −f₀`. ⚠ The file's own
  TODO: no level (`f (N / x) = c • x ^ k • g x`) — Layer 2 discharges it.
  `LSeries/MellinEqDirichlet.lean` (`hasSum_mellin`, `hasSum_mellin_pi_mul_sq(')` — theta
  Mellin transforms are Dirichlet series, even and odd); `Mathlib/Analysis/MellinTransform.lean`
  (`mellin`, `MellinConvergent`, holomorphy from `isBigO_rpow` bounds);
  `Mathlib/Analysis/MellinInversion.lean` (`mellinInv_mellin_eq`; ⚠ no Perron formula, no
  contour shifting).
- **Zeta and Dirichlet instances:** `LSeries/RiemannZeta.lean` (`riemannZeta`,
  `completedRiemannZeta`, `completedRiemannZeta₀`, `completedRiemannZeta_one_sub`,
  `riemannZeta_one_sub`, `differentiableAt_riemannZeta`, `riemannZeta_residue_one`,
  `riemannZeta_zero`, trivial zeros, and the `RiemannHypothesis` `Prop`);
  `HurwitzZetaEven/Odd/HurwitzZeta.lean` (kernels, `WeakFEPair` instances at `k = 1/2` and
  `3/2`, completed FEs `completedHurwitzZetaEven_one_sub` etc., `expZeta`, residues);
  `HurwitzZetaValues.lean` (`riemannZeta_two`, `riemannZeta_two_mul_nat`,
  `riemannZeta_neg_nat_eq_bernoulli`; its TODO: extend to Dirichlet L — Layer 4 territory);
  `ZMod.lean` (`ZMod.LFunction`, `completedLFunction`, discrete-Fourier-dual FEs
  `completedLFunction_one_sub_even/odd` with the `N ^ (s−1)` factor, `LFunction_residue_one`);
  `DirichletContinuation.lean` (`DirichletCharacter.LFunction`, `gammaFactor`,
  `completedLFunction`, `rootNumber` — Gauss-sum definition, ⚠ `‖rootNumber χ‖ = 1` is
  **unproved at the pin** —, `IsPrimitive.completedLFunction_one_sub`,
  `LFunctionTrivChar_eq_mul_riemannZeta`, `LFunction_changeLevel`);
  `Dirichlet.lean` (abscissa `= 1` results, von Mangoldt/logarithmic-derivative identities
  `LSeries_vonMangoldt_eq_deriv_riemannZeta_div`, Möbius);
  `Nonvanishing.lean` (`DirichletCharacter.LFunction_ne_zero_of_one_le_re`,
  `LFunction_ne_zero_of_re_eq_one`, `LFunction_apply_one_ne_zero`,
  `riemannZeta_ne_zero_of_one_le_re`; the `3-4-1` product `norm_LFunction_product_ge_one`
  and the quadratic-character positivity argument);
  `PrimesInAP.lean` (`Nat.infinite_setOf_prime_and_eq_mod` and variants,
  `ArithmeticFunction.vonMangoldt.residueClass` machinery — infinitude only, ⚠ no density);
  `ZetaZeros.lean` (`riemannZetaZeros`, `isDiscrete_riemannZetaZeros`,
  `IsCompact.inter_riemannZetaZeros_finite`).
- **Euler products:** `Mathlib/NumberTheory/EulerProduct/Basic.lean`
  (`EulerProduct.eulerProduct_hasProd`, `_tprod`, completely-multiplicative versions,
  `ArithmeticFunction.IsMultiplicative.eulerProduct`); `DirichletLSeries.lean`
  (`riemannZeta_eulerProduct_tprod`, `DirichletCharacter.LSeries_eulerProduct`,
  `_exp_log`); `ExpLog.lean`. Formal/algebraic side:
  `Mathlib/NumberTheory/ArithmeticFunction/LFunction.lean` (Browning:
  `ArithmeticFunction.ofPowerSeries`, `ArithmeticFunction.eulerProduct` over an index type,
  `Northcott` — the machinery under the elliptic-curve L-function). ⚠ There is **no** Euler
  product for `dedekindZeta` and even the multiplicativity of its coefficient is unproved.
- **Dedekind zeta and its substrate:** `Mathlib/NumberTheory/NumberField/DedekindZeta.lean`
  (Roblot; `NumberField.dedekindZeta K s := LSeries (fun n ↦ Nat.card {I : Ideal (𝓞 K) //
  absNorm I = n}) s`; `dedekindZeta_residue` — a `def`, the constant
  `2^{r₁}(2π)^{r₂}·R·h / (w·√|d_K|)`; the CNF
  `tendsto_sub_one_mul_dedekindZeta_nhdsGT` as a real one-sided limit; reference: Marcus,
  *Number Fields*, ch. 7); `NumberField/Ideal/Asymptotics.lean`
  (`Ideal.tendsto_norm_le_and_mk_eq_div_atTop` — **per-ideal-class** equidistributed
  counting, the partial-zeta input; `tendsto_norm_le_div_atTop`);
  `NumberField/CanonicalEmbedding/` (`mixedEmbedding`, `ConvexBody`, `FundamentalCone`,
  `NormLeOne`, `PolarCoord` — the unit-action fundamental domain with regulator volume);
  `Mathlib/Algebra/Module/ZLattice/{Basic,Covolume,Summable}.lean`;
  `Mathlib/RingTheory/Ideal/Norm/AbsNorm.lean` (`Ideal.absNorm`, `finite_setOf_absNorm_eq`,
  `finite_setOf_absNorm_le`); `Ideal.absNorm_eq_pow_inertiaDeg`
  (`NumberTheory/RamificationInertia/Inertia.lean`); `FractionalIdeal.dual` and the
  different (`Mathlib/RingTheory/DedekindDomain/Different.lean`) — the trace-dual lattice
  for the theta relation.
- **Analytic toolbox:** `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean` (`Gammaℝ`,
  `Gammaℂ`, `Gammaℝ_mul_Gammaℝ_add_one`, `Gammaℝ_eq_zero_iff`, `differentiable_Gammaℝ_inv`);
  `Mathlib/Analysis/Fourier/PoissonSummation.lean` (1-dimensional
  `Real.tsum_eq_tsum_fourier` + `_of_rpow_decay`);
  `Mathlib/Analysis/Fourier/AddCircleMulti.lean` (Loeffler — multivariate Fourier series,
  L² and uniform convergence: the engine for Layer 2's lattice Poisson summation);
  `Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.lean` (Jacobi's
  `θ(1/t) = √t·θ(t)`); `Mathlib/NumberTheory/ModularForms/JacobiTheta/{OneVariable,
  TwoVariable,Bounds}.lean`; Schwartz functions and the Fourier transform on `ℝ^n`
  (`Mathlib/Analysis/Distribution/SchwartzSpace.lean`, `Fourier/FourierTransform.lean`);
  `Mathlib/NumberTheory/AbelSummation.lean` (Roblot); `Mathlib/NumberTheory/Chebyshev.lean`
  (Irving–Tao–Van de Velde, partly upstreamed from PrimeNumberTheoremAnd: `Chebyshev.psi`,
  `theta`, two-sided bounds, `primeCounting_eq_theta_div_log_add_integral`);
  `Mathlib/NumberTheory/SumPrimeReciprocals.lean`; `Mathlib/NumberTheory/PrimeCounting.lean`
  (`Nat.primeCounting` — the denominator of rational-prime densities);
  `Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean` (`riemannZeta_one_ne_zero`).
- **Galois/Frobenius vocabulary (for Layer 8):** `Mathlib/RingTheory/Frobenius.lean`
  (A. Yang: `AlgHom.IsArithFrobAt`, `IsArithFrobAt`, existence
  `IsArithFrobAt.exists_of_isInvariant`, the canonical `arithFrobAt R G Q`,
  `IsArithFrobAt.conj`, `isConj_arithFrobAt` — the Frobenius conjugacy class attached to a
  base prime, at the pin); `Mathlib/RingTheory/Invariant/Basic.lean` (Browning:
  `Algebra.IsInvariant`, transitivity `exists_smul_of_under_eq`,
  `Ideal.Quotient.stabilizerHom_surjective`, decomposition-mod-inertia ≃ residue Galois);
  `Mathlib/NumberTheory/RamificationInertia/` (`Ideal.ramificationIdxIn`, `inertiaDegIn`,
  `ncard_primesOver_mul_ramificationIdxIn_mul_inertiaDegIn` — `r·e·f = n` in the Galois
  case; authors cite Neukirch); `Mathlib/RingTheory/IntegralClosure/IntegralRestrict.lean`
  (`galRestrictHom`); `Mathlib/NumberTheory/NumberField/Cyclotomic/Galois.lean` (Roblot
  2026, from Washington: `IsCyclotomicExtension.Rat.galEquivZMod : Gal ≃* (ZMod n)ˣ`,
  `galEquivZMod_stabilizer` — the decomposition group at `p ∤ n` is `⟨[p]⟩`: the cyclotomic
  splitting law, i.e. the ℚ(ζₙ) case of Chebotarev's input, at the pin;
  `intermediateFieldEquivSubgroupChar` — the subfield ↔ Dirichlet-character dictionary).
- **Elliptic-curve L-function (instance ledger):**
  `Mathlib/AlgebraicGeometry/EllipticCurve/LFunction.lean` (Browning 2026:
  `WeierstrassCurve.localPolynomial` — `1 − a T + q T²` good / `1 ∓ T` multiplicative / `1`
  additive —, `localEulerFactor`, `WeierstrassCurve.LFunction : ArithmeticFunction ℤ` as a
  formal Euler product over `HeightOneSpectrum (𝓞 K)`, `WeierstrassCurve.LSeries`;
  ⚠ zero theorems, no conductor, no Hasse-bound convergence) with
  `EllipticCurve/Reduction.lean` (good/multiplicative/additive trichotomy).
- **Adeles (for the Long-horizon layer only):** `NumberField/AdeleRing.lean` (definition +
  `principalSubgroup` only), `InfiniteAdeleRing.lean` (`ringEquiv_mixedSpace`,
  `locallyCompactSpace`), `Completion/FinitePlace.lean`, `ProductFormula.lean`
  (`NumberField.prod_abs_eq_one`), `RingTheory/DedekindDomain/FiniteAdeleRing.lean`.
  ⚠ No compactness of `𝔸_K/K`, no discreteness of `K`, no ideles, no idele class group.

### What is in motion elsewhere (checked 2026-07-30; coordinate, cite, do not fork)

- **Chebotarev is already proved in Lean, outside Mathlib.** `CBirkbeck/AINTLIB`
  (`projects/Chebotarev/CebotarevDensity/`, 15 files, verified sorry-free 2026-07-30)
  proves `Chebotarev.chebotarev_density`: for finite Galois `L/K` and a conjugacy class
  `C`, the unramified primes with Frobenius class `C` have Dirichlet density `#C/#G`
  (with corollaries `dirichlet_primes_in_AP`, `density_split_completely`). Route
  (documented in-repo, following Sharifi Thm 7.2.2 / Lenstra–Stevenhagen): Dedekind-zeta
  factorization for abelian extensions → cyclotomic case via Dirichlet L-functions →
  abelian case by cyclotomic crossing → general case via the fixed field `L^⟨σ⟩`. Caveat:
  AINTLIB is AI-authored/AI-reviewed by design ("deliberately relaxed" standards). The
  human-reviewed rebuild is `CBirkbeck/chebotarev-density` (created 2026-05-28, active
  through 2026-07-25): `Main.lean` states `chebotarev_density` with the proof still
  `sorry` while the `ForMathlib` infrastructure lands via internal PRs reviewed by
  **Xavier Roblot and Riccardo Brasca** (merges 2026-06-30 → 2026-07-11); and Mathlib PR
  **#41765** (riccardobrasca, opened 2026-07-15, open) starts the upstreaming with
  `Mathlib.NumberTheory.NumberField.DirichletDensity`. ⚠ Standing obligations for
  Layer 8: adopt #41765's Dirichlet-density spelling the moment it merges (until then,
  state compatibly); contact Birkbeck–Brasca–Roblot before starting Layer 8 (the root
  README's coordination rule — this is live, reviewed work, not prior art to fork);
  Tau Ceti's development is independent but must stay statement-compatible.
- **Hecke characters/L-functions have open Mathlib PRs (Thomas Browning).** PR **#40735**
  (idele class group: `IdeleGroup`, `IdeleClassGroup` in `AdeleRing.lean`) and PR
  **#40736** (`NumberTheory/NumberField/HeckeLFunction`: `HeckeCharacter R K :=
  MulChar (IdeleClassGroup R K) ℂ` — ⚠ with **no continuity condition** yet —,
  `IsUnramifiedAt`, `localValue` at a uniformizer, `localPolynomial = 1 − χᵥ(ϖᵥ)X`, and
  `LFunction` as a formal `ArithmeticFunction.eulerProduct`), both updated 2026-07-29.
  These are *formal* Dirichlet series: no convergence, continuation, or FE. Perfect
  complementarity, to be preserved: GCFT should align its idele-side character with
  #40735/#40736 (and repair the missing continuity), and this roadmap's Layers 5–6 supply
  the analysis on top; Layer 5's Euler-factor convention `(1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` already
  matches Browning's `localPolynomial`.
- **PrimeNumberTheoremAnd** (AlexKontorovich/PrimeNumberTheoremAnd; very active, last
  push 2026-07-29; Zulip channel `#PrimeNumberTheorem+`). Proved in-repo, sorry-free:
  **Wiener–Ikehara** (`WienerIkeharaTheorem'`), `WeakPNT` (`ψ(x)/x → 1`),
  `WeakPNT_AP`/`WeakPNT_character` (PNT in APs, asymptotic form), `MediumPNT`
  (`ψ(x) = x + O(x·exp(−c (log x)^{1/10}))`), and the `Consequences.lean` package
  (`chebyshev_asymptotic`, `pi_asymp`, `mu_pnt`, `dirichlet_thm`). The classical-error
  **StrongPNT** is a 6-sorry in-progress port of `math-inc/strongpnt` (an AI-generated
  complete strong-PNT formalization, frozen 2025-09). Upstreamed to Mathlib so far:
  `Chebyshev.lean` (#32281), `ZetaZeros.lean` (#37328), log-L Euler products (#41097,
  merged 2026-07-16, post-pin), Costa–Pereira (#40569); **Mertens' three theorems are PR
  #41394 (teorth, open)**. Chebotarev in PNT+ is an *informal blueprint only*
  (`blueprint_comment` sections in `Wiener.lean`, expanded 2026-07-22: cyclotomic case →
  abelian by crossing → general — the same route as AINTLIB). Layer 9 consumes this
  project's Tauberian theorems rather than re-proving them.
- **Mathlib master motion since the pin (2026-06-03), L-series line:** #41329 (Loeffler,
  merged 2026-07-04) refactors `AbstractFuncEq` around an `IsStrongFEPair` predicate —
  ⚠ Layer 2's level-extension must be designed against the *post-refactor* shape at bump
  time; #41097 (Tao) Dirichlet series for `log` of L-functions; #40127 (Meiburg) zeta via
  `completedRiemannZeta₀`; #41133 (merged) and #42101 (open) conjugation symmetry of
  (completed) `riemannZeta` — directly supporting the `Λ^∨ = conj ∘ Λ ∘ conj` dual
  convention of Layer 0; #41251 (Birkbeck, merged 2026-07-08) the abstract `HeckeRing`
  (double-coset Hecke algebras — the modular-forms side, not Hecke characters), with the
  #41253–#41328 stack open; #40540 (open) the Riemann xi function. **Nothing on Dedekind
  zeta continuation/FE or on Tate's thesis has landed or is open** (searches verified
  2026-07-30); `dedekindZeta` post-pin commits are refactors only. Roblot's open
  decomposition/inertia-field stack (#35808, #35991, #36733, #36843, #37031, #41591, …,
  updated 2026-07-30) is the Frobenius-API groundwork Layer 8 and NumberFieldArithmetic
  will sit on.
- **Upstream TauCetiRoadmap PRs.** **#47** (Birkbeck, "Modular forms — Hecke theory,
  newforms, and L-functions", open): its **Layer 7 "L-functions"** ports AINTLIB's proved
  modular L-function package — convergence with abscissa `≤ k/2 + 1` for cusp forms,
  Euler product `∏_p (1 − aₚp^{-s} + χ(p)p^{k−1−2s})⁻¹`, completed `Λ_N` via Mellin,
  two-form FE `Λ_N(k − s, f) = i^k Λ_N(s, g)` with entirety and analytic continuation,
  sign form via Atkin–Lehner, and the **analytic conductor pinned as Iwaniec–Kowalski
  (5.7)**. This roadmap's Layer-0 modular instance card cites that layer and adds only
  the wiring into the data model (degree 2, arithmetic conductor `N`, the
  `𝔮(f,s)`-analytic-conductor relation). **#68** (elliptic curves, open) has **no
  L-function layer** (deliberately); its Hasse-bound and Tate-algorithm/conductor layers
  are the gates for the EC instance card. #81 (modular curves), #80 (adic spaces) are
  disjoint neighbors.
- **FLT** (ImperialCollegeLondon/FLT): no L-functions and no classical modularity
  statement — its modularity notion is `GaloisRep.IsAutomorphicOfLevel` (quaternionic,
  totally-real-of-even-degree, self-described as "far more restrictive… than is found in
  the literature"), so the EC card's "continuation = modularity" import is a statement
  *this roadmap writes* (as a named conjecture predicate over the data model) and
  coordinates with FLT — not one FLT currently exports. FLT's adele/Haar infrastructure
  is being upstreamed (e.g. #40535, adele-ring notation, merged 2026-07-29) and is the
  substrate the Long-horizon Tate layer would consume.
- **MichaelStollBayreuth/EulerProducts**: maintenance mode (content frozen since early
  2025, Mathlib bumps only; README: "Most of the results developed here have by now made
  it into Mathlib"). Remaining unlanded: the `PNT.lean` reduction of asymptotic
  Dirichlet to Wiener–Ikehara. Historical provenance of `LSeries/`, `EulerProduct/`,
  `Nonvanishing`, `PrimesInAP`.

## What is missing (build here)

The entire data-model layer: nothing at the pin carries degree, conductor, spectral
parameters, root number, or motivic weight, and no statement links them (`‖rootNumber χ‖ = 1`
is unproved even for Dirichlet characters). The named ideal-norm coefficient function and
its multiplicativity; the Euler product of `dedekindZeta`; Euler products of Galois type
with factors at bad primes. Analytic continuation of `dedekindZeta` beyond `Re s > 1` — in
the cheap strip `Re s > 1 − 1/[K:ℚ]` (ideal counting) and to `ℂ` (theta method) — the
completed `Λ_K`, its functional equation, and its poles/residues; the same for partial zeta
functions per (ray) class. Lattice Poisson summation in `K_ℝ`, the Hecke theta
transformation, and the level extension of `WeakFEPair`. Hecke L-series of ray-class
characters and of Grossencharacters: Euler products, Gauss sums with
`|τ(χ)| = √𝔑(𝔪)`, completed FEs with root numbers, primitivity/induction of characters.
Special values: `L(1, χ)` for quadratic characters, the finite class number formulas, the
factorization `ζ_K = ζ · L(χ_d)` for quadratic fields and `ζ_{ℚ(ζₙ)} = ∏ L(χ)`. Landau's
theorem on singularities of nonnegative Dirichlet series; nonvanishing of ray-class
L-functions at `s = 1` and on `Re s = 1`. Every density notion for primes (Dirichlet,
natural, polar), their comparison lemmas, the density-zero reductions; the splitting-density
theorem, the Frobenius density theorem, ray-class equidistribution, and the **Chebotarev
density theorem**; Bauer's theorem and the split-set rigidity corollaries. The prime ideal
theorem `π_K(x) ∼ x/log x` and the natural-density upgrade of Chebotarev (Tauberian input
by coordination). Zero-free regions, zero counting, and verified-zeros semantics. None of
this exists upstream as stated.

---

## The build, in layers

The ordering below is the dependency order within each lane; the three lanes (FE lane:
Layers 2–3–5–6; special-values lane: Layer 4; density lane: Layers 7–8, all over
Layer 1) are parallel after Layer 1 —
the density theorems need only the strip continuation and residues, **not** the functional
equation. As each layer makes the next layer's types expressible, its milestones are added
to `Suggested.lean` with `sorry`.

### Layer 0: the L-function data model and the instance ledger

The LMFDB axiomatics (Iwaniec–Kowalski ch. 5 flavor, Selberg-class-adjacent), as a
structure-plus-predicates family over `LSeries` — the *semantic* layer every LMFDB
L-function page instantiates.

- **The data.** A structure carrying: coefficients `a : ℕ → ℂ` (with `a 1 = 1`); `degree`;
  `conductor : ℕ+`; spectral parameters as multisets `gammaR`, `gammaC` of complex shifts;
  the completed function `Λ : ℂ → ℂ`; the root number `ε`; the polar locus (a `Set ℂ`,
  finite by axiom, empty in the entire case). Named accessors: the gamma factor
  `γ(s) = ∏ Gammaℝ(s + μ) · ∏ Gammaℂ(s + ν)`, the conjugate-dual `Λ^∨(s) = conj (Λ (conj s))`.
- **The axioms, as separable predicates** (not one monolith — instances satisfy different
  subsets, and the model must say which): `degree = #gammaR + 2·#gammaC`; agreement
  `Λ(s) = conductor^{s/2} γ(s) (L a)(s)` on `1 < Re s` (⚠ region hypothesis — junk values);
  differentiability of `Λ` off the polar locus with meromorphy data at the poles (order-one
  pole statements in the `Tendsto (s − p) • Λ` idiom of `WeakFEPair.Λ_residue_k`); the
  functional equation `Λ(s) = ε · Λ^∨(1 − s)`; `‖ε‖ = 1`; the Euler-product predicate
  (Layer 1 supplies the definition); the Ramanujan-on-average bound
  `∑_{n ≤ x} ‖a n‖ = O(x^{1+δ})` (the honest, provable-for-all-instances form; pointwise
  Ramanujan is instance-specific and *not* an axiom).
- **The normalization dictionary.** `analyticNormalization` / motivic-weight shift as named
  defs with translation lemmas: shifting `a n ↦ a n / n^{w/2}` carries the arithmetic
  normalization to the analytic one, conductor/degree/ε invariant, gamma shifts translated.
  State once, prove for the model, apply per instance.
- **Instance cards, immediately** (the model is validated the day it exists — both are
  complete at the pin): **ζ** (degree 1, conductor 1, `gammaR = {0}`, `ε = 1`,
  `Λ = completedRiemannZeta`, poles `{0, 1}`; FE card = `completedRiemannZeta_one_sub`) and
  **Dirichlet** (`χ` primitive mod `N > 1`: degree 1, conductor `N`, `gammaR = {0}` or
  `{1}` by parity, `Λ = N^{s/2} · completedLFunction χ`, `ε = rootNumber χ` — the
  conductor-included completion makes the pin's `N^{s−1/2}`-FE constant-free; card FE =
  `IsPrimitive.completedLFunction_one_sub`). ⚠ The Dirichlet card is not closable at the
  pin: `‖rootNumber χ‖ = 1` must be **proved here** (from
  `gaussSum_mul_gaussSum_eq_card`); it is the first gap the model finds.
- **The instance ledger** (the program of this roadmap, each row discharged in the layer
  named): ζ (Layer 0 ✓), Dirichlet (Layer 0 + the root-number gap), Dedekind ζ_K (Layer 3),
  ray-class Hecke (Layer 5), Grossencharacter (Layer 6), quadratic-field factorizations
  (Layer 4), **modular forms** (statement-level card now; wiring milestone gated on the
  upstream ModularForms roadmap PR #47, whose Layer 7 "L-functions" delivers convergence,
  the Euler product, the completed `Λ_N` with the two-form FE
  `Λ_N(k − s, f) = i^k Λ_N(s, g)`, entirety, and the analytic conductor pinned as
  Iwaniec–Kowalski (5.7) — cite, do not build; the card adds only the data-model wiring
  and the arithmetic-conductor ↔ analytic-conductor relation), **elliptic curves** (card
  over `WeierstrassCurve.LSeries` with: convergence from the Hasse bound — gated on PR
  #68's Hasse layer —, conductor from #68's Tate-algorithm layer, and continuation/FE
  recorded as **equivalent to modularity** — an FLT-facing ⚠ *named conjecture predicate
  written here*, since FLT's `IsAutomorphicOfLevel` is deliberately more restrictive than
  classical modularity and exports no EC L-function statement; never a proof obligation),
  **Artin** (interface only: Layers 5–6 constitute the engine the Wave-2
  ArtinRepresentations roadmap consumes via Brauer induction; the ledger row records the
  induction-invariance shape it needs).

### Layer 1: ideal-indexed series, Euler products, and the cheap continuation strip

The bridge between `Ideal (𝓞 K)` and `LSeries`, and everything about `ζ_K` that needs no
theta function. Discharges the `DedekindZeta.lean` TODO ("Generalize the construction").

- **The norm-coefficient bridge.** The named coefficient function (inline lambda at the pin)
  `idealCoeff K : ℕ → ℂ`, `n ↦ #{I : Ideal (𝓞 K) ∣ absNorm I = n}`, and its weighted
  variant `idealCoeff χ` for a function `χ` on ideals (supported away from a modulus);
  `dedekindZeta_eq : dedekindZeta K = LSeries (idealCoeff K)` by `rfl`-adjacent glue.
  Finiteness is the pin's `Ideal.finite_setOf_absNorm_eq`.
- **Multiplicativity and the Euler product.** `idealCoeff K` is multiplicative (unique
  factorization of ideals + CRT for coprime norms); the Euler product
  `∏' 𝔭 : HeightOneSpectrum (𝓞 K), (1 − 𝔑𝔭^{-s})⁻¹ = dedekindZeta K s` on `1 < Re s` via
  `EulerProduct.eulerProduct_hasProd` — ⚠ the index is primes of `𝓞 K`, grouped over
  rational `p` by `𝔑𝔭 = p^f` (`Ideal.absNorm_eq_pow_inertiaDeg`); state both the
  `HeightOneSpectrum`-indexed and the `ℕ`-prime-grouped forms, they serve different
  consumers. Nonvanishing on `1 < Re s` and `log`-expansion
  (`∑_𝔭 ∑_m 𝔑𝔭^{-ms}/m`, the input to every density argument), abscissa
  `abscissaOfAbsConv (idealCoeff K) = 1`.
- **Euler products of Galois type** (the data-model predicate, Layer 0's consumer): local
  factor data `P_𝔭 ∈ ℂ[T]` with `P_𝔭(0) = 1`, `deg P_𝔭 ≤ degree` with equality at good
  primes; the associated coefficients and the `HasProd` statement; degree-1 (`Hecke-shaped`)
  and degree-d determinant shapes, with **arithmetic Frobenius** in the determinant form
  (convention table). The bad-prime convention: the factor is the characteristic polynomial
  on inertia invariants — for a character, `1` at ramified primes.
- **Counting and the strip.** Consume `Ideal.tendsto_norm_le_and_mk_eq_div_atTop` (per
  ideal class, constant independent of the class) and upgrade along Janusz IV §2/Lang VI §3
  to the error form: `#{I ∈ 𝔎 ∣ 𝔑I ≤ x} = ρ_K x + O(x^{1−1/d})`, `d = [K:ℚ]`,
  `ρ_K = 2^{r₁}(2π)^{r₂}R/(w√|d_K|)` (Milne CFT VI 2.8 states exactly this and cites Lang
  VI.3 Thm 3 for the proof; Janusz IV 2.11–2.13 is the integer-argument version). ⚠ This
  is the one genuinely hard analytic milestone of the layer; it strengthens, and must be
  reconciled with, the pin's limit-only asymptotics — coordinate the statement so Roblot's
  files can adopt it.
- **The cheap continuation.** From the error term via `LSeriesSummable_of_sum_norm_bigO` +
  `LSeries_eq_mul_integral`: `ζ(s, 𝔎)` and hence `dedekindZeta` extend analytically to
  `Re s > 1 − 1/d` except a simple pole at `s = 1` (Janusz IV 2.14, Milne VI 2.9/2.12);
  complex-residue upgrade of the pin's real-limit CNF
  (`Tendsto (s − 1) * ζ_K(s) → dedekindZeta_residue K` along `𝓝[≠] 1`). **This strip is
  all the density lane needs**; it unblocks Layers 7–8 independently of Layers 2–3.
- **Partial zeta functions.** `ζ(s, 𝔎)` per ideal class (and per ray class, once GCFT's
  ray class groups exist — statement shapes fixed now, over an abstract finite quotient of
  the ideal group, so the GCFT plug-in is an instantiation, not a refactor), with
  `dedekindZeta = ∑_𝔎 ζ(·, 𝔎)` and `L(χ) = ∑_𝔎 χ(𝔎) ζ(·, 𝔎)`.

### Layer 2: the theta engine — lattice Poisson summation and the level-N FE frame

The analytic core of the Hecke route; self-contained analysis, no number theory beyond the
lattice vocabulary. Every piece is independently Mathlib-worthy.

- **Poisson summation for lattices in ℝ^n.** `∑_{v ∈ L} f v = covol(L)⁻¹ ∑_{w ∈ L^∨} 𝓕f w`
  for Schwartz `f` (or the `rpow`-decay hypotheses of the 1-dim pin version), `L` a
  `ZLattice` with dual `L^∨` and `ZLattice.covolume`; route: reduce to `ℤ^n` by a linear
  change of variables (`𝓕(f ∘ B) = |det B|⁻¹ 𝓕f ∘ B^{-T}`) and prove `ℤ^n` by multivariate
  Fourier series (`AddCircleMulti` — periodize, expand, evaluate at 0, exactly the 1-dim
  proof of `Real.tsum_eq_tsum_fourier`). Gaussian self-duality in `n` variables.
- **Theta functions of positive quadratic forms.** `Θ_Q(t) = ∑_{v ∈ L} exp(−π t Q(v))`-type
  kernels and the transformation `Θ_{L}(1/t) = t^{n/2} covol(L)⁻¹ Θ_{L^∨}(t)` (positive-
  definite `Q` via its self-adjoint square root ⚠ — the matrix-square-root bookkeeping is
  a named trap: do it through `InnerProductSpace` and `IsSelfAdjoint.sqrt`, not raw
  matrices). Multi-parameter version (one scale `t_v` per infinite place, `c`-weights on
  the norm-one hypersurface) as needed by Layer 3 — Lang XIII §2's
  `Θ(c, 𝔞) = (c₁⋯c_N)^{-1/2} Θ(c^{-1}, 𝔞')`.
- **Ideal lattices.** Specialize to `mixedEmbedding K '' I` for a fractional ideal `I`:
  covolume `2^{-r₂}√|d_K| 𝔑(I)` (pin has the covolume machinery), dual lattice = the
  embedded trace-dual `(I𝔡)⁻¹` (`FractionalIdeal.dual`; the different enters here and only
  here). The Hecke theta of an ideal class.
- **The level-N functional-equation frame.** Extend `WeakFEPair` (or add a reduction
  lemma) to the level form `f (N / x) = ε x^k g x`, producing `Λ` with FE
  `s ↦ k − s` against level `N` — the `AbstractFuncEq.lean` TODO, and the shape both
  `Λ_K` (level `|d_K|`) and Hecke L (level `|d_K|𝔑𝔪`) instantiate. Design note: a
  rescaling reduction (`f ↦ f(√N ·)`) to the level-1 frame is acceptable if the constants
  thread cleanly; the deliverable is the reusable statement, not a particular proof.
  ⚠ Master refactored this file after the pin (#41329, Loeffler, merged 2026-07-04:
  an `IsStrongFEPair` predicate) — design the extension against the post-refactor shape
  and propose it upstream rather than maintaining a fork of the frame.

### Layer 3: Dedekind zeta — analytic continuation and functional equation

Hecke's proof (Lang XIII §§1–3; Neukirch VII §5), on Layers 1–2. The summit of the FE lane
for the LMFDB's number-field pages.

- **Per-class completion and FE.** For each ideal class `𝔎`:
  `Z(𝔎, s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ(s, 𝔎)` continues to
  `ℂ ∖ {0, 1}` with simple poles at `0, 1` of residues `∓ 2^{r₁+r₂} R/w` (the
  completed-object constants: `Gammaℝ(1) = 1`, `Gammaℂ(1) = 1/π` absorb the
  `(2π)^{r₂}/√|d_K|` of the uncompleted residue), and
  `Z(𝔎, s) = Z(𝔎', 1 − s)` where `𝔎𝔎' = [𝔡]` — ⚠ **the FE permutes ideal classes through
  the different**; only the sum over classes is self-dual. Getting `𝔎'` right (and not
  `𝔎⁻¹`) is an acceptance criterion. Route: unfold `ζ(s, 𝔎)` over unit orbits of `𝔞 ∖ 0`
  (`𝔞 ∈ 𝔎⁻¹`), Mellin-transform the ideal theta against the fundamental domain of the
  unit action on the norm-one hypersurface (consume `FundamentalCone`; measure
  `2^{r₁+r₂−1} R` — the regulator Jacobian, Lang p. 258, the layer's hard point), apply
  Layer 2's theta transformation and the `WeakFEPair` machinery.
- **The completed Dedekind zeta.** `completedDedekindZeta K` (`Λ_K`) with
  `Λ_K = ∑_𝔎 Z(𝔎, ·)`: entire except simple poles at `0, 1`, `Λ_K(s) = Λ_K(1 − s)`,
  residues `∓ 2^{r₁+r₂} hR/w` at `0, 1` (completed-object constants; the uncompleted
  `2^{r₁}(2π)^{r₂}hR/(w√|d_K|)` is Layer 4's CNF statement), consistent with
  `WeakFEPair.Λ_residue_k`; `Λ_K = |d_K|^{s/2} Gammaℝ^{r₁} Gammaℂ^{r₂} · ζ_K` on
  `1 < Re s`.
- **The continued `dedekindZeta`.** The function the rest of Mathlib should eventually
  own: `dedekindZetaC K : ℂ → ℂ` (naming: coordinate with Roblot's TODO) analytic on
  `ℂ ∖ {1}`, agreeing with `dedekindZeta K` on `1 < Re s`, simple pole at `1` with residue
  `dedekindZeta_residue K` (now as a genuine complex residue — subsuming the pin's real
  CNF), trivial zeros from `Gammaℝ_eq_zero_iff`, `dedekindZetaC ℚ = riemannZeta`
  **globally** (junk-value-free — this is why the continued object, not the raw `LSeries`,
  is the export), asymmetric-form FE with the explicit `A(s)` factor (Neukirch (5.11)(iii)).
- **Instance card** (Layer 0 ledger): degree `[K:ℚ]`, conductor `|d_K|`,
  `gammaR` = `r₁` copies of `0`, `gammaC` = `r₂` copies of `0` (so
  `degree = r₁ + 2r₂` holds definitionally); `ε = 1`; poles
  `{0, 1}` at completed level; self-dual. The card's coherence conditions are theorems of
  this layer, and the `ζ_{ℚ(i)}` worked example is its non-vacuity witness.

### Layer 4: special values and the class number formula bridge

Everything at `s = 1` (and integer points) that the LMFDB number-field and character pages
display. Gated on Layer 1 only (not on the FE lane) except where noted.

- **Quadratic factorization.** For `K` quadratic of discriminant `D`:
  `idealCoeff K n = ∑_{e ∣ n} χ_D(e)` (splitting law = Kronecker symbol; consume
  `LegendreSymbol`/`ZMod` quadratic reciprocity and the pin's `jacobiSym`), hence
  `dedekindZeta K s = riemannZeta s · LFunction χ_D s` on `1 < Re s` and, after Layer 3,
  globally for the continued objects. ⚠ State with the *primitive* character mod `|D|`
  (discriminant, not radicand — the `d ≡ 1 mod 4` bookkeeping is the classical trap).
- **Dirichlet's class number formula, finite form.** Combining the factorization with the
  pin's CNF and `LFunctionTrivChar_residue_one`-style bookkeeping:
  `L(1, χ_D) = 2π h / (w √|D|)` (imaginary) and `= 2 h log ε₀ / √D` (real) — the
  LMFDB-displayed identities; numeric acceptance instance at `D = −20` below.
- **Cyclotomic factorization.** `ζ_{ℚ(ζₙ)} = ∏_{χ mod n} L(χ, ·)` up to the explicit
  imprimitivity correction `G(s) = ∏_{p ∣ n}` … (Neukirch (5.12)); ⚠ primitive vs
  imprimitive Euler factors at `p ∣ n` is exactly where this identity is usually stated
  wrong — pin the primitive-character form with the correction factor named. Consume
  `LFunction_changeLevel`, `intermediateFieldEquivSubgroupChar`. (This identity is also
  the CFT-free engine for `L(1, χ) ≠ 0` over ℚ, Janusz IV 5.7.)
- **Integer values.** Extend `HurwitzZetaValues`' TODO: `L(1 − k, χ)` via generalized
  Bernoulli numbers (define `B_{k,χ}`), `L(1, χ₋₄) = π/4` (Leibniz; connect the pin's
  `Real.tendsto_sum_pi_div_four`), evenness/oddness vanishing. These feed the
  ArtinRepresentations and modular-forms constant-term interfaces.

### Layer 5: Hecke L-functions of ray-class characters

Finite-order Hecke characters: definition over ideals, full analytic theory. Consumes
GCFT's ray-class layer (moduli, `J^𝔪/P^𝔪`, conductor of a character, primitivity); every
statement here is phrased over an abstract character of an ideal-group quotient so that
GCFT's encoding plugs in. Alignment obligation: Mathlib PRs #40735/#40736 (Browning, open)
are building the idele-side `HeckeCharacter` with the *formal* Euler product — GCFT's
character layer should adopt/refine that vocabulary (including the missing continuity
condition), and this layer supplies exactly the analysis those PRs deliberately omit
(convergence, continuation, FE); the local-factor shapes already agree.

- **The L-series.** `L(χ, s) = ∑_𝔞 χ(𝔞) 𝔑𝔞^{-s}` via the Layer-1 bridge (`χ(𝔞) = 0` at
  `𝔞` not coprime to the modulus); Euler product `∏_{𝔭 ∤ 𝔪} (1 − χ(𝔭)𝔑𝔭^{-s})⁻¹`
  (Neukirch (8.1)); abscissa 1; strip continuation `Re s > 1 − 1/d` with the pole only at
  `χ = χ₀` (Layer 1 applied per class + orthogonality); `L(χ₀, s)` versus `ζ_K` with the
  finitely many Euler factors named (the `LFunctionTrivChar_eq_mul_riemannZeta` pattern).
- **Primitivity and induction.** `χ` induced from its conductor `f_χ ∣ 𝔪`; the L-series
  differ by named Euler factors; FE only for primitive `χ` (the pin's `IsPrimitive`
  discipline, lifted to ray classes).
- **Gauss sums.** `τ(χ)` for a ray-class character (Neukirch VII (6.4)/(7.5)):
  `|τ(χ)| = √𝔑(𝔪)` for primitive `χ`; the theta-twisting identities. ⚠ Neukirch's
  *ideal-number* bookkeeping (his `K̂^*`) is a non-canonical device — formalize the Gauss
  sum and the partial thetas against explicit representatives/GCFT's data instead of
  canonizing ideal numbers; the check is that `W(χ)` below is independent of all choices.
- **Functional equation.** `Λ(χ, s) = (|d_K| 𝔑(f_χ))^{s/2} L_∞(χ, s) L(χ, s)` (gamma data:
  `Gammaℝ(s)` or `Gammaℝ(s+1)` per real place by the signature of `χ` at the real places
  — the parity bookkeeping consumed from GCFT's character-at-infinity data; `Gammaℂ` per
  complex place), entire for `χ ≠ χ₀`, FE `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` with
  `W(χ)` explicit in `τ(χ)` and `‖W(χ)‖ = 1` (Neukirch (8.5)/(8.6) restricted to type
  `(p, 0)`, `p ∈ {0,1}^{r₁}`); per-ray-class partial FEs with the `[𝔪𝔡]`-twist as in
  Layer 3. Route: the Layer-2/3 theta machinery with `χ`-weights (Neukirch VII §7 (7.6),
  (7.7)).
- **Instance card + degree-1 closure.** Ledger row: degree 1 over `K` = degree `d` over ℚ
  as a Galois-type Euler product (the induction-to-ℚ statement, base-change row of the
  data model); Dirichlet characters over `K = ℚ` recover the pin's objects **exactly**
  (acceptance criterion: the two `Λ`s agree, not just the two FEs).

### Layer 6: general Grossencharacters

The infinite-order theory (LMFDB's "Hecke characters" in full), completing the
degree-1-over-K instance family. Consumes GCFT's Grossencharacter layer (type `(p, q)`
infinity data, idele-class ↔ ideal-theoretic dictionary, Neukirch VII (6.11)–(6.14)).

- **Infinity types.** The archimedean character data `(p, q)` (`p ∈ ∏_τ ℤ` admissible,
  `q ∈ ℝ^{r₁+r₂}`) and the completed gamma data `L_∞(χ, s) = L_X(s·1 + p − iq)`
  (Neukirch §4/§8's `G(ℂ|ℝ)`-set formalism translated to `Gammaℝ/Gammaℂ` shifts —
  the spectral-parameter multiset of the Layer-0 model, now with genuinely complex shifts).
  ⚠ The admissibility/occurrence bookkeeping (which `(p, q)` arise, `χ_∞` trivial on
  units) is GCFT's; this layer consumes it as hypotheses.
- **Weighted theta and FE.** Theta series with harmonic weights `N(x^p)` (Neukirch VII §7
  in full), transformation with the `W(χ, p̄)` constant, Mellin assembly, and Theorem
  (8.5)/(8.6): meromorphic continuation of `Λ(χ, s)`, entire unless `𝔪 = 1` and `p = 0`
  (poles exactly at `s = Tr(−p+iq)/n` and `1 + Tr(p+iq)/n` in the exceptional case — the
  pole-location bookkeeping is part of the statement), FE `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)`.
- **Equidistribution seeds.** `L(χ, 1 + it) ≠ 0` consequences packaged for consumers
  (Layer 7 supplies the proofs): Hecke's equidistribution of `arg 𝔭` for Gaussian primes
  (the worked example), and the compact-group equidistribution statement (Lang XV Thm 6
  shape) that the SatoTateGroups roadmap's CM lane will instantiate. Interface only; the
  Weyl-criterion equidistribution machinery is **not** at the pin (nothing under
  `Mathlib/Dynamics/` covers it) — building it is a named obligation of the SatoTateGroups
  roadmap (planned), which owns compact-group equidistribution; this layer packages only
  the nonvanishing input.

### Layer 7: nonvanishing and the Landau toolkit

The analytic input to every density theorem. **Pinned route: analytic, CFT-free** — the
density lane must not gate on GCFT's existence theorem; GCFT's reciprocity is consumed
only in Layer 8's Chebotarev endgame. (The CFT proof of nonvanishing — `ζ_L = ζ_K ∏ L(χ)`
over the class field, Neukirch (13.3), Janusz V 10.2, Milne VIII 7.1 — becomes a
*cross-check corollary* once GCFT lands; record it, don't depend on it.)

- **Landau's theorem.** A Dirichlet series with nonnegative coefficients has a singularity
  at its real abscissa of convergence (absent at the pin; the pin's
  `LSeries.positive_of_differentiable_of_eqOn` is the germ). This is the missing general
  lemma behind both the real-character case below and Layer 8's density dichotomies;
  Mathlib-worthy on its own.
- **`L(χ, 1) ≠ 0` for finite-order ideal characters** (`χ ≠ χ₀`) — stated once for a
  character of a finite quotient of an ideal group with finite support removed, so that
  it covers *both* consumers: ray-class characters (Layer 5) and the Frobenius-side
  characters `𝔭 ↦ χ(Frob_𝔭)` of an abelian Galois group (Layer 8's CFT-free lane). By
  the pin's own Dirichlet-case architecture generalized (`Nonvanishing.lean`): the
  `3-4-1` product `L(χ₀)³L(χ)⁴L(χ²)` for `χ² ≠ χ₀`, and for real `χ` the positivity of
  `ζ_K·L(χ)`-type coefficient sums plus Landau (Lang XV Thm 2 proves exactly this for all
  Hecke characters with no class number formula and no CFT). Gives the density lane its
  key at `s = 1`.
- **Nonvanishing on `Re s = 1`.** `L(χ, 1 + it) ≠ 0` for all `t` (`χ` arbitrary,
  including `χ₀` ↦ `ζ_K(1 + it) ≠ 0`), extending
  `LFunction_ne_zero_of_re_eq_one`'s proof pattern; for Grossencharacters via the
  `χ · ‖·‖^{it}`-twist reduction (Lang XV Thm 3). This is the Layer-9 (prime ideal
  theorem) input, stated in the strip — no FE needed.
- **Logarithmic derivatives.** `−L'/L(χ, s) = L-series of χ-twisted von Mangoldt over
  ideals` on `1 < Re s` (the `LSeries_twist_vonMangoldt_eq` pattern for `K`), the Λ_K von
  Mangoldt function on ideal norms, and the standard `log`-expansion lemmas — shared
  plumbing for Layers 8–9.

### Layer 8: densities and the Chebotarev density theorem

The summit. Statement vocabulary: the pin's `IsArithFrobAt`/`arithFrobAt` + conjugacy
(`isConj_arithFrobAt`), over `Algebra.IsInvariant` **with the action faithful**
(`FaithfulSMul` — invariance + faithfulness force `G ≅ Gal`; without faithfulness the
density claim is false for actions through a quotient); refactor-onto flags: restate against
NumberFieldArithmetic's Frobenius API when that sibling lands, and adopt Mathlib PR
#41765's `DirichletDensity` spelling when it merges. ⚠ This layer has live, reviewed
counterparts (AINTLIB's sorry-free proof; the Birkbeck–Brasca–Roblot rebuild) — per the
root README, contact those authors before starting it; the development here is
independent-in-Tau-Ceti but statement-compatible by obligation (see *What is in motion*).

- **The three densities and their calculus.** Dirichlet, natural, polar (convention table
  definitions); finite sets are null; monotonicity/additivity; degree-one reduction
  (primes with `𝔑𝔭` non-prime are polar-null — Milne 3.2); **natural ⇒ Dirichlet with the
  same value** (Abel summation; the pin's `AbelSummation.lean` does the work) and the
  standard non-converse example *stated*; **polar ⇒ Dirichlet** (Milne 4.1(a)). ⚠ Every
  density statement fixes which density it asserts; "density" unqualified is banned in
  this roadmap's Lean statements.
- **CFT-free density theorems** (nothing below this bullet needs GCFT or Layer 7):
  the **splitting-density theorem** — primes of `K` splitting completely in a finite
  extension `L` have polar density `1/[M:K]`, `M` the Galois closure (Milne VI 3.4; the
  `n`-th-root trick is what polar density is for); `δ = 1/n ↔ Galois`; **Bauer's theorem**
  (`Spl(L) ⊆ Spl(M) ↔ M ⊆ L` for Galois targets) and split-set rigidity ("a Galois
  extension is determined by its split primes", Neukirch (13.10)); the **Frobenius density
  theorem** (the division of `σ` has density `t/#G`, with `t` the number of elements of
  the division — Janusz IV 5.2, by induction on
  `ord σ` with the degree-one counting identity; CFT-free and nonvanishing-free), with its
  corollary: surjectivity of the Artin map onto `Gal(L/K)` for abelian `L/K` (Janusz IV
  5.3/Milne VI 3.8 — an input GCFT's second-inequality lane may itself want; export it).
- **Abelian equidistribution, Frobenius-side.** For `L/K` **abelian**, the Artin
  L-function of a character `χ` of `Gal(L/K)` is definable with *no class field theory*
  (`𝔭 ↦ χ(Frob_𝔭)`, Frobenius well-defined since `G` is abelian); the factorization
  `ζ_L = ∏_{χ} L(χ, ·, Gal)` (splitting-law algebra, the general form of Neukirch (5.12));
  hence, with Layer 7's nonvanishing applied to these L-functions, Frobenius elements are
  Dirichlet-equidistributed in `Gal(L/K)`. The **cyclotomic case** `K(ζₙ)/K` and, over
  `K = ℚ`, the pin-supported instance (`galEquivZMod_stabilizer` + the pin's Dirichlet
  nonvanishing) come first: **Dirichlet's theorem with density** `1/φ(q)` — strictly
  stronger than the pin's infinitude statement, which becomes a corollary (acceptance
  criterion).
- **Chebotarev.** For `L/K` finite Galois with group `G` and a conjugacy class `C`, the
  primes `𝔭` of `K`, unramified in `L`, whose Frobenius class at `𝔭` is `C` have
  **Dirichlet density `#C/#G`**. **Pinned route: the CFT-free one** (Lenstra–Stevenhagen;
  Sharifi 7.2.2; the route of the sorry-free AINTLIB proof, of the
  Birkbeck–Brasca–Roblot rebuild, and of PNT+'s informal blueprint — this roadmap follows
  the direction the ecosystem has taken): (i) the cyclotomic/abelian equidistribution
  above; (ii) the **crossing lemma** extending it from `K(ζₘ)`-type extensions to general
  abelian and then cyclic `L/K` by composing with auxiliary cyclotomic extensions;
  (iii) the **Deuring/Artin reduction** to the cyclic case via the fixed field
  `M = L^⟨σ⟩` with the fibre count `𝔓 ∩ 𝓞_K` — each `𝔭` in the target set carries
  exactly `d/(c·f)` primes of `M` in the transported set (`d = #G`, `c = #C`,
  `f = ord σ`), giving `δ = c/d`; Milne CFT VIII 7.4's explicit bijections are the
  formalization blueprint for this step. ⚠ The fibre count is where the conjugacy-class
  vs element, `𝔓` vs `𝔭`, and degree-one-over-`K` bookkeeping all meet. ⚠ Frobenius
  orientation: `Frob_𝔭 = [𝔑𝔭]` on cyclotomic layers (arithmetic — the convention table);
  a `⁻¹` here silently proves the theorem for `C⁻¹`. Corollaries re-derived from the full
  statement: exact-density versions of every CFT-free bullet above, and Galois-closure
  splitting densities.
- **Ray-class equidistribution** (GCFT-gated *statement*, two proofs). Once GCFT's ray
  class groups exist: primes are Dirichlet-equidistributed among the classes of any
  `J^𝔪 ⊇ H ⊇ P^𝔪`, density `1/[J^𝔪 : H]` (Neukirch (13.2), Milne VI 4.8 + VIII 7.2) —
  either directly from Layer 1's partial zetas + Layer 7's `L(1, χ) ≠ 0` (analytic,
  ray-class-side), or from Chebotarev + GCFT's Artin reciprocity (uniformizer ↦
  arithmetic Frobenius, the LocalFields-aligned normalization). Proving **both** and
  matching them is the reciprocity-consistency check of the whole roadmap — the analytic
  and Galois-side densities must agree class by class.

### Layer 9: prime counting — the prime ideal theorem and natural densities

The Tauberian upgrade. **PNT itself is consumed, never re-proved** (coordination:
PrimeNumberTheoremAnd; see Provenance).

- **The Tauberian input.** Wiener–Ikehara is **proved, sorry-free, in
  PrimeNumberTheoremAnd** (`WienerIkeharaTheorem'`, `Wiener.lean`) but not in Mathlib;
  the pinned plan is to consume it — help upstream it if needed rather than re-prove it
  here (Lang XV §§1–3 is the self-contained fallback source only if that coordination
  fails, with an explicit refactor-onto-PNT+ note). Either way the *statement* shape used
  downstream is fixed now: nonnegative coefficients, simple pole at 1,
  `∑_{n≤x} a n ∼ κx`.
- **The prime ideal theorem.** `π_K(x) ∼ x/log x` (Landau; Lang XV Thm 4 shape) from
  Layer 1's `−ζ_K'/ζ_K` + Layer 7's `Re s = 1` nonvanishing + the Tauberian input; the
  `K = ℚ` specialization must literally be PNT — which PNT+ already has (`WeakPNT`,
  `chebyshev_asymptotic`, `pi_asymp`, and `MediumPNT` with an error term; the classical
  de la Vallée Poussin form is their in-progress `StrongPNT` port) — so the general-`K`
  proof must reuse their pipeline shapes, and the `K = ℚ` instance is an agreement
  check against their statements, never an independent PNT proof.
- **Natural-density upgrades.** Natural-density versions of ray-class equidistribution and
  **Chebotarev** (the LMFDB-facing form; Milne V 3.26(d) notes Artin's observation that
  the upgrade holds — prove it): `π_C(x) ∼ (#C/#G)·x/log x`. Mertens-type statements for
  `K` (`∑_{𝔑𝔭 ≤ x} 𝔑𝔭^{-1}`) as supporting API.
- **Effective statements are horizon, not here**: Lagarias–Odlyzko effective Chebotarev
  (GRH and unconditional forms) is recorded in the Long horizon with its reference; no
  milestone in this layer promises error terms.

### Layer 10: the zeros program (definite horizon)

The LMFDB zeros section semantics. These are real, ordered deliverables — later than
Layers 0–9 but part of this roadmap, with the pin's `ZetaZeros.lean` and
`RiemannHypothesis` as the seeds.

- **Zero-free regions.** The classical de la Vallée Poussin region
  `σ > 1 − c/log(|t|+2)` for `ζ_K` and Hecke L (from Layer 7's `3-4-1` machinery made
  quantitative); zero-freeness of `Λ_K` on `Re s ∈ {0, 1}` off the poles as the qualitative
  first step. ⚠ Siegel zeros: the real-character exceptional-zero phenomenon must be
  *stated* (the region theorem carries the exceptional-zero disjunct); no milestone claims
  its elimination.
- **Counting.** `N(T) = (T/2π)log(T/2πe) + O(log T)` (Riemann–von Mangoldt) for ζ first,
  then the conductor-uniform version for the data-model class (degree/conductor enter —
  this is where the Layer-0 model pays analytic rent). Discreteness + compact-finiteness
  for every instance (generalizing `isDiscrete_riemannZetaZeros` to the model).
- **Verified-zeros semantics.** The LMFDB stores certified intervals: the predicate family
  "`Λ` has exactly `n` zeros with `0 < Im ρ ≤ T`, the `j`-th in the interval `I_j`, all on
  the critical line" — statements designed for interval-arithmetic certificates
  (`norm_num`-extension/`Polyrith`-style discharge is a tooling question deliberately out
  of scope; the *semantics* is in scope). GRH for the model class as a `Prop` generalizing
  the pin's `RiemannHypothesis`.

### Long horizon (direction; gated, not scheduled)

Tate's thesis as a second derivation: adelic Fourier theory (self-dual measures,
Schwartz–Bruhat, restricted-product integration, `𝔸_K/K` compactness, adelic
Poisson/Riemann–Roch), local zeta integrals and local ε-factors, the global FE, and the
**comparison theorem** with Layers 3/5/6's `Λ` (Lang XIV Cor. 3 = XIII Thm 2) — to be
coordinated with FLT's adelic needs and only after the idele-class infrastructure exists.
Local-constant factorization `W(χ) = ∏_v W_v(χ)` (Tate/Deligne; the Durham-volume
Tate article) — shared with ArtinRepresentations' ε-factor layer. Effective Chebotarev
(Lagarias–Odlyzko; Durham volume) and explicit-formula infrastructure (Lang XVII).
Converse-theorem and Selberg-class statements (degree classification `d ≤ 1`) as
data-model theorems. Sato–Tate-style equidistribution beyond CM via Layer 6's interface.

## Worked examples (acceptance criteria)

Discharge alongside the layers; each catches a specific class of error.

- **`dedekindZeta ℚ` vs `riemannZeta`** (Layers 1/3): on `1 < Re s` they agree (ideal ↔
  positive-integer bijection); the *continued* `dedekindZetaC ℚ = riemannZeta` globally.
  Catches junk-value abuse and off-by-one in the coefficient bridge (`n = 0`).
- **`ζ_{ℚ(i)} = ζ · L(χ₋₄)`** (Layers 1/4, then 3): first as the coefficient identity
  `#{I ∣ 𝔑I = n} = ∑_{e ∣ n} χ₋₄(e)` (the pin's `ZMod.χ₄` composed to `ℂ`), then as an
  identity of continued functions. Catches Euler-factor conventions at the ramified prime
  `2` (factor `(1 − 2^{-s})⁻¹` on both sides) and primitivity bookkeeping.
- **CNF at `ℚ(√-5)`, numerically shaped** (Layers 1/4): `h = 2`, `w = 2`, `|D| = 20`, so
  `Res_{s=1} ζ_{ℚ(√−5)} = π/√5` and equivalently `L(1, χ₋₂₀) = π/√5`; the pin's
  `dedekindZeta_residue` unfolds to exactly this via `Multiquadratic`'s class-number
  input. Catches every constant at once (`2^{r₁}(2π)^{r₂}`, `w`, `√|d|`).
- **Hurwitz/Dirichlet FE consistency** (Layer 0): the ζ and Dirichlet instance cards'
  `ε`-values against the pin's FEs; `‖rootNumber χ‖ = 1` proved and checked at `χ₋₄`
  (`τ(χ₋₄) = 2i`, `ε = τ/(i·√4) = 1`). Catches the `I^{if Even then 0 else 1}` archimedean
  factor and conductor-power conventions.
- **Chebotarev at `ℚ(ζ₅)/ℚ`** (Layer 8): `G ≅ (ℤ/5)ˣ` (pin's `galEquivZMod`), every
  class is a singleton, so primes with `p ≡ a (mod 5)` have Dirichlet density `1/4` —
  and the pin's `Nat.infinite_setOf_prime_and_eq_mod` follows. Layer 9 upgrades to
  natural density `1/4`. Catches the Frobenius-normalization direction (arithmetic:
  `Frob_p = [p]`, not `[p]⁻¹`) — the single most consequential sign in the roadmap,
  aligned with LocalFields.
- **The Δ instance card** (Layer 0 ledger; statement-level): degree 2, conductor 1,
  `gammaC = {11/2}` analytic (weight-12 arithmetic via the dictionary), `ε = 1`;
  wiring milestone gated on the upstream ModularForms roadmap (PR #47)'s L-function
  layer. Catches the arithmetic↔analytic dictionary on a non-self-dual-normalization
  instance (`a(n) = τ(n)/n^{11/2}`).
- **EC card at `K = ℚ`** (Layer 0 ledger; statement-level): `WeierstrassCurve.LSeries`
  converges for `Re s > 3/2` given the Hasse bound (#68-gated); continuation + FE
  recorded as the modularity import (FLT-facing ⚠, never proved here). Catches the
  data-model's ability to carry *conjectural* continuation honestly (predicates asserted
  as hypotheses, not theorems).

## Ordering and parallelism

Layer 0 and Layer 1 first (0 needs nothing; 1 needs 0 only for the Euler-product
predicate's home — they can be simultaneous). Then three independent lanes: the **FE lane**
Layer 2 → 3 → (4 completes) → 5 → 6, where 5–6's *character* inputs arrive from GCFT
(their analytic content is unblocked as soon as GCFT's ray-class definitions exist —
GCFT's reciprocity/existence theorems are **not** needed anywhere in this roadmap's
critical path); the **density lane** Layer 7 → 8, needing only Layer 1 (strip + residues)
— with the pinned CFT-free Chebotarev route, **every** Layer-8 milestone except the
ray-class-equidistribution statement can land before GCFT does; and the
**special-values lane** Layer 4 (Layer 1 + pin Dirichlet theory only). Layer 9 follows 7–8
and the PNT+ coordination; Layer 10 follows the FE lane and Layer 9. Worked examples are
spread across all layers and none is deferrable to the end. Milestone-level coordination:
with GCFT — agree the ray-class-group and character *interfaces* (not encodings) before
Layer 5 starts, jointly tracking Mathlib #40735/#40736; with NumberFieldArithmetic —
adopt their Frobenius/Artin-symbol API in Layer 8 statements when it exists, pin's
`IsArithFrobAt` until then; with the Chebotarev line (Birkbeck–Brasca–Roblot) and PNT+ —
before Layers 8 and 9 respectively, per the in-motion notes above.

## References

- J. Neukirch, *Algebraic Number Theory* (Springer 1999) — **the primary source for the FE
  lane**: ch. VII §1–2 (ζ, Dirichlet L as warm-up), §3–4 (theta transformation (3.6),
  higher-dimensional Gamma), §5 (Dedekind zeta: (5.9) partial FE with the `[𝔡]`-twist,
  (5.10) completed FE, (5.11) continuation/residue/asymmetric FE, (5.12) cyclotomic
  factorization), §6 (Grossencharacters: (6.7) infinity types, (6.9) Dirichlet =
  type-`(p,0)`, (6.11)–(6.14) idele dictionary), §7 (Hecke theta: Gauss sums (7.5),
  transformation (7.7)), §8 (Hecke L: Euler product (8.1), **FE (8.5)/(8.6)** with
  `W(χ)`), §13 (densities: (13.1) Dirichlet density, (13.2) ray-class density, (13.3)
  nonvanishing via CFT, **(13.4) Chebotarev** with Deuring reduction, (13.5)–(13.10)
  corollaries).
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110 — the route-decision source and the
  density/Tauberian source: ch. VI §3 (ideal counting `ρt + O(t^{1−1/N})`, Thm 3), ch.
  VIII §§1–4 (Dirichlet-series lemmas, strip continuation, densities, Thm 10 = Chebotarev
  via Deuring), ch. XIII (**Hecke's FE proof**: Poisson §1, theta relation §2, FE +
  residues Thms 1–3; Lang's `Γ(s/2)^{r₁}Γ(s)^{r₂}` normalization differs from ours by
  `2^{r₂}`), ch. XIV (Tate's thesis — the Long-horizon blueprint; Cor. 3 = the
  route-comparison theorem), ch. XV (**Ikehara** §2, Tauberian for Dirichlet series §3,
  **analytic nonvanishing** Thm 2 (`3-4-1` + Landau, no CFT), `Re = 1` Thm 3, natural
  densities + prime ideal theorem Thm 4, equidistribution Thms 5–6).
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7 — the elementary lane: IV §1–2
  (ray classes; ideal counting 2.11/2.13, strip continuation 2.14), IV §4 (L-series,
  density dichotomy 4.8, converse device 4.9), IV §5 (**Frobenius density theorem 5.2**,
  Artin-map surjectivity 5.3, first inequality 5.6, CFT-free `L(1,χ) ≠ 0` over ℚ 5.7),
  V §10 (nonvanishing after CFT 10.2, ray-class density 10.3, Chebotarev 10.4).
- J. S. Milne, *Class Field Theory* (v4.03, course notes) — the Chebotarev formalization
  blueprint: VI §2 (partial zetas 2.8 — statement, proof cited to Lang — strip 2.9–2.12),
  VI §3 (**polar density**, splitting-density Thm 3.4, Bauer 3.6, Artin surjectivity 3.8),
  VI §4 (Dirichlet density 4.1–4.8, second inequality 4.9), V 3.23–3.26 (statement +
  natural-density remark), **VIII §7 (7.1–7.4: the fibre-counted Chebotarev proof —
  Layer 8's target)**.
- D. Loeffler, M. Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959 —
  the design rationale of the pin's `LSeries/` stack; Layer 2–3 continue it.
- D. A. Marcus, *Number Fields* (2nd ed., Springer 2018) — the pin's own CNF citation
  (ch. 7 = Layer 1's counting; also the polar-density source Milne follows).
- H. W. Lenstra, Jr., P. Stevenhagen, "Chebotarëv and his density theorem", Math.
  Intelligencer 18 (1996), 26–37 (free on the authors' pages) — the CFT-free
  crossing-route source Layer 8 pins; and R. Sharifi, *Algebraic Number Theory* (course
  notes, free online), Thm 7.2.2 — the route reference the in-motion Lean proofs cite.
- Not held locally at the time of writing (acquisition list, in priority order):
  **H. Iwaniec, E. Kowalski, *Analytic Number Theory*, AMS Colloq. 53 — ch. 5 is the
  data-model source of record for Layer 0 (the axioms: degree, conductor, gamma factor,
  root number, the approximate FE) and the zeros-program reference (ch. 5.7, 10, 16);
  this roadmap's single most-wanted acquisition.** A. Fröhlich (ed.), *Algebraic Number
  Fields* (Durham 1975/1977) — Lagarias–Odlyzko (effective Chebotarev, Layer 9
  horizon/Long horizon), Tate (local constants), Martinet. H. Davenport, *Multiplicative
  Number Theory*, 3rd ed. — zero-free regions and the exceptional zero (Layer 10).
  E. C. Titchmarsh (rev. Heath-Brown), *The Theory of the Riemann Zeta-Function* —
  `N(T)`/Riemann–von Mangoldt (Layer 10). L. C. Washington, *Introduction to Cyclotomic
  Fields* — the pin's cyclotomic-Galois source; Layer 4's `B_{k,χ}`.
  W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers* — Milne's FE
  citation; a useful cross-check for Layer 5 constants.

## Provenance and coordination

- **The Loeffler–Stoll line** (`Mathlib/NumberTheory/LSeries/`, `EulerProduct/`,
  `Gamma/Deligne.lean`, `AddCircleMulti.lean`; design paper arXiv:2503.00959, Annals of
  Formalized Mathematics 1 (2025) 43–56). This roadmap is a direct continuation of that
  program: Layers 2–3 extend their FE frame (the `AbstractFuncEq` level TODO, the
  multivariate Poisson step their `AddCircleMulti` stages), and Layer 7 generalizes their
  `Nonvanishing.lean` architecture. Standing obligations: propose the `AbstractFuncEq`
  level extension upstream (post-#41329 shape) rather than fork it; keep Layer 0's
  completed-L conventions translatable to their `completedLFunction` normalization
  (the `N^{s/2}` dictionary lemma); flag Layer 3's Dedekind FE to them and to Roblot
  before implementation — it is the natural next chapter of their own program.
- **The Roblot line** (`DedekindZeta.lean` + `Ideal/Asymptotics.lean` +
  `CanonicalEmbedding/FundamentalCone.lean`, PR #17914 merged 2025-05-18; cyclotomic
  Galois `Cyclotomic/Galois.lean` 2026; the open decomposition/inertia-field PR stack;
  reviewer of the chebotarev-density rebuild). Layers 1 and 3 sit directly on his
  machinery and discharge his file's TODO; the Layer-1 counting upgrade
  (`O(x^{1−1/d})` error form) should be co-designed with him so his asymptotics files
  adopt it. Contact before Layers 1, 3, and 8.
- **The Chebotarev line** (CBirkbeck/AINTLIB — sorry-free Dirichlet-density Chebotarev,
  AI-authored; CBirkbeck/chebotarev-density — the human-reviewed rebuild, Brasca–Roblot
  reviewing; Mathlib #41765 `DirichletDensity`, open). Layer 8 develops the same
  mathematics independently in Tau Ceti, pinned to the same (CFT-free) route, with three
  obligations: statement compatibility with #41765's density API (adopt on merge);
  citation of both repos on every Layer-8 milestone; coordination with
  Birkbeck–Brasca–Roblot before Layer 8 starts, and again before any statement-level
  divergence. If their rebuild lands in Mathlib first, the corresponding Layer-8
  milestones become comparison-and-consume tasks (the LocalFields refactor-on-landing
  pattern), and the Tau Ceti value concentrates in the natural-density upgrade (Layer 9)
  and the ray-class/reciprocity consistency theorem.
- **The Browning line** (`ArithmeticFunction/LFunction.lean` and
  `EllipticCurve/LFunction.lean` at the pin; open #40735 idele class group + #40736
  formal Hecke L-functions; `RingTheory/Invariant`). Two touchpoints: Layer 5–6 supply
  the analysis over his formal Hecke L (coordinate the character vocabulary through
  GCFT), and the EC instance card wires his `WeierstrassCurve.LSeries` into the data
  model. His `ArithmeticFunction.eulerProduct`/`Northcott` formalism and Layer 1's
  analytic Euler products must be bridged by a comparison lemma, not duplicated.
- **PrimeNumberTheoremAnd** (Kontorovich, Tao, Irving, and many others; Zulip channel
  `#PrimeNumberTheorem+`; blueprint in-source since 2026-01). Layer 9's Tauberian input
  and every `K = ℚ` prime-counting statement are consumed from or checked against this
  project; their Chebotarev blueprint (informal) follows the same route Layer 8 pins.
  Standing obligations: no PNT re-proof under any guise; help upstream Wiener–Ikehara if
  that unblocks Layer 9; track #41394 (Mertens) for the Layer-9 support API. The
  `math-inc/strongpnt` artifact (AI-generated strong PNT, frozen 2025-09) is cited as
  provenance of PNT+'s StrongPNT port, never consumed directly.
- **Upstream TauCetiRoadmap PR #47** (Birkbeck, ModularForms): its Layer 7 owns modular
  L-functions (built from AINTLIB's proved `LFunctionFEqN` package); this roadmap's
  ledger card consumes it and supplies nothing modular. The analytic-conductor
  convention (IK (5.7)) pinned there is adopted here unchanged. **PR #68** (elliptic
  curves): Hasse bound and Tate-algorithm/conductor layers gate the EC card. **PR #81 /
  #80**: disjoint. Worth a direct conversation with Birkbeck before this roadmap and #47
  both go up — he authors the two upstream PRs this roadmap cites most.
- **FLT** (Buzzard et al.): the EC card's modularity predicate is written here as an
  FLT-facing statement and flagged to them; the Long-horizon Tate layer consumes their
  adele/Haar upstreaming (e.g. #40535) when it exists. No FLT code is consumed today.
- **Siblings.** [GlobalClassFieldTheory](../GlobalClassFieldTheory/README.md) (in
  preparation): supplies ray-class/Hecke-character algebra (Layers 5–6 inputs, Layer 8's
  ray-class statement); the interface handshake — character vocabulary aligned with
  #40735/#40736, conductor-of-character API, characters-at-infinity data — happens
  before Layer 5. [LocalFields](../LocalFields/README.md) (sibling, in preparation): the
  arithmetic-Frobenius and uniformizer↦Frobenius conventions adopted here are its;
  Euler-factor conventions at bad primes (inertia invariants) must stay aligned.
  [NumberFieldArithmetic](../NumberFieldArithmetic/README.md) (in preparation): owns the
  eventual Frobenius/Artin-symbol API; Layer 8 refactors onto it.
  [ProfiniteCohomology](../ProfiniteCohomology/README.md) (sibling, in preparation): not consumed (no cohomology
  in this roadmap); listed to record the boundary. Wave 2: **ArtinRepresentations**
  consumes Layers 5–6 (the Brauer-induction engine — the FE of every Artin L-function
  reduces to Hecke's, which is why those layers exist at this generality);
  **SatoTateGroups** consumes Layer 6's equidistribution interface;
  **CurvesOverFiniteFields** shares only the Weil-polynomial vocabulary (local Euler
  factors), via the data model.
- **Zulip.** Direct search was unavailable at audit time (API unauthorized;
  the archive is not search-indexed); load-bearing coordination threads known from
  cross-references: the PNT+ channel `#PrimeNumberTheorem+` (project coordination;
  the "Merging with Morph" thread on the strongpnt upstreaming), and the Mathlib PR
  streams for #40735/#40736/#41765/#41394. Before implementation of Layers 5, 8, 9,
  announce intentions on Zulip per the root README's claims process and confirm the
  state of those PRs.
