# Roadmap: L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems

Mathlib's L-series library is in unusually good shape. At the pin
(`9caeba1000`, 2026-06-03), `Mathlib/NumberTheory/LSeries/` is a 21-file, ~6900-line stack
(David Loeffler, Michael Stoll, with Xavier Roblot, Chris Birkbeck, Huanyu Zheng; the design
paper is Loeffler–Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959) that
already contains: the L-series `LSeries f s = ∑' n, f n / n ^ s` with a complete
abscissa-of-absolute-convergence theory (`LSeries.abscissaOfAbsConv`), linearity, Dirichlet
convolution (`⍟`), derivatives, coefficient injectivity, and positivity; the abstract
Mellin-transform functional equation `WeakFEPair`/`StrongFEPair`
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

And yet the subject the LMFDB's central section is *about* is barely there. At the pin
there is **no meromorphic data model** for an L-function (nothing carries a degree, conductor, Gamma
data, root number, or motivic weight; even `‖rootNumber χ‖ = 1` is unproved for Dirichlet
characters); `dedekindZeta` has **no Euler product, no analytic continuation
past `Re s > 1`, and no functional equation** (the file's own TODO asks to generalize the
construction); there are **no Hecke characters and no Hecke L-functions** (the only `Hecke` hits at the
pin are the cusp-form coefficient bound `CuspFormClass.qExpansion_isBigO` and
bibliography lines; `Grossencharacter` has zero matches); **no prime-density notion of any kind** (the only
density in Mathlib is `schnirelmannDensity`); **no Chebotarev** (zero matches on the pin
and, at the time of the audit recorded in [`PROVENANCE.md`](PROVENANCE.md), none on master either);
**no Landau theorem, no Tauberian theorem, no PNT, no Mertens**; no zero-free region and no
zero counting; modular forms have no L-series hook; and `WeierstrassCurve.LFunction` is a
theorem-free formal Dirichlet series without a conductor. This roadmap builds that layer:
the LMFDB's L-function axiomatics as composable predicates over genuine meromorphic
continuations of `LSeries`, the analytic
continuation and functional equation of the Dedekind zeta function by Hecke's method on the
pin's own Minkowski-space machinery, Hecke L-functions of ray-class characters and general
Grossencharacters, the density theory culminating in the **Chebotarev density theorem**, the
prime ideal theorem and the natural-density form of Chebotarev, and the ledger that puts
every other roadmap's L-functions into one frame.

Suggested home: `TauCeti/NumberTheory/LFunctions/`, with subdirectories per layer
(`DataModel/`, `IdealSeries/`, `Theta/`, `DedekindZeta/`, `SpecialValues/`, `HeckeL/`,
`Grossencharacter/`, `Nonvanishing/`, `Density/`, `PrimeCounting/`). The
Dedekind zeta files use the namespace `NumberField`, matching
`Mathlib/NumberTheory/NumberField/DedekindZeta.lean`, whose TODO they discharge.

## Scope

### In scope

Every numbered milestone of *The build, in layers*, Layers 0 through 9. Nothing there is
conditional, and nothing waits on anything outside the roadmap. In one sentence: the
analytic theory of the L-functions of a number field — the data model, the Dedekind zeta
function, Hecke L-functions of ray-class characters and of Grossencharacters, nonvanishing,
prime densities, and prime counting — proved for a general number field `K`, and recovering
the classical object at `K = ℚ` in every case.

### Out of scope

- **The zeros program**: zero-free regions, zero counting, the Riemann–von Mangoldt formula,
  the explicit formula, and the semantics of a certified list of zeros. Those need a growth
  theory — order, vertical-strip bounds, Stirling estimates for the gamma factors, an
  analytic conductor, Phragmén–Lindelöf, Hadamard factorization — that this roadmap does not
  build, so stating them over the data record here would be stating them over nothing. They
  are the subject of the separate **zeros of L-functions** roadmap
  (`TauCetiRoadmap/LFunctionZeros/README.md`), which consumes the completed instances
  produced here. The contract is in *Interfaces supplied* below.
- **Tate's thesis**: adelic Fourier analysis, self-dual measures, Schwartz–Bruhat functions,
  local zeta integrals, local ε-factors, and the adelic derivation of the functional
  equation. Layer 3's functional equation is proved by Hecke's method; a second derivation is
  not wanted here. The factorization `W(χ) = ∏_v W_v(χ)` belongs with those ε-factors and so
  is out of scope too.
- **Artin L-functions and Brauer induction.** Layers 5–6 are built at the generality that
  makes Brauer induction possible, and are stated so a representation-theoretic roadmap can
  consume them, but no Artin instance, induction theorem, or `ArtinRepresentation` object is
  built here.
- **Compact-group equidistribution.** Layer 7 proves the nonvanishing of
  `L(χ‖·‖^{it}, 1 + iu)` that an equidistribution argument needs, and Layer 6 packages it
  together with Hecke's equidistribution of the arguments of Gaussian primes. The Weyl
  criterion for a general compact group, and Sato–Tate, are not proved here.
- **Effective and explicit constants.** Lagarias–Odlyzko effective Chebotarev, and error
  terms in any density or counting statement, are out of scope; Layer 9's asymptotics carry
  no error term.
- **Elliptic-curve L-functions.** No continuation and no functional equation is asserted for
  `WeierstrassCurve.LSeries`, because no roadmap yet proves classical modularity. See the
  instance ledger in Layer 0.

### Interfaces supplied to other roadmaps

Each of these is a theorem of a numbered layer here, stated so that another roadmap consumes
it rather than rebuilding it.

- **Poisson summation for a general `ZLattice`, and the Gaussian theta transformation**
  (Layers 2.1–2.8). The [integral lattices
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7) consumes these and proves only
  the arithmetic specialization to a bilinear integral lattice; the sphere-packing project
  wants the same statement. Exact shape: for a `ZLattice L` in a finite-dimensional real
  inner-product space and Schwartz `f`, `∑_{v ∈ L} f v = (ZLattice.covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w`,
  with `Lᵛ` the analytic dual.
- **The completed Dedekind zeta function, its exact polar divisor, and its functional
  equation** (Layer 3), and **completed Hecke L-functions with `‖W(χ)‖ = 1`** (Layers 5–6).
  These are what the zeros roadmap's growth and zero-counting layers attach to.
- **Nonvanishing on `Re s = 1` in meromorphic-order form** (Layer 7.5), and the `3-4-1`
  positivity it rests on, which the zeros roadmap makes quantitative.
- **The Dirichlet-density calculus** (Layer 8A) and **Chebotarev over a general number
  field** (Layer 8D), for any roadmap that needs to say how often a splitting behavior occurs.
- **Landau's theorem on singularities of Dirichlet series with nonnegative coefficients**
  (Layer 7.1), which is general analysis and belongs to nobody in particular.

## Dependencies

The dependency graph is not a chain. Every edge below names a roadmap, the layer of that
roadmap the material comes from, the declaration family consumed, and the first layer here
that needs it.

| Supplier | Material consumed here | First consuming layer | Kind |
|---|---|---:|---|
| [Local fields](https://github.com/roed-math/TauCetiRoadmap/pull/2) | the arithmetic-Frobenius convention; uniformizer ↦ Frobenius; local conductor and unit-group facts behind the Euler factor at a bad prime | 1 | hard |
| [Global class field theory](https://github.com/roed-math/TauCetiRoadmap/pull/6), Layers 0–1 | moduli and ray class groups `J^𝔪/P^𝔪` | 5 | hard |
| Global class field theory, Layers 2–3 | Hecke characters as continuous characters of the idele class group, the finite-order/open-kernel/ray-class factorization, the conductor with its finite and infinite parts, and the unitary decomposition | 5 | hard |
| Global class field theory, its infinity-type layer | infinity types and algebraic (`A₀`) Grossencharacters | 6 | hard |
| [Number field arithmetic](https://github.com/roed-math/TauCetiRoadmap/pull/9) | `frobeniusClass`, restriction and tower compatibility of Frobenius, the finite-place global/local dictionary, and the ideal-theoretic Artin map for abelian extensions | 8 | hard |
| [Integral lattices](https://github.com/roed-math/TauCetiRoadmap/pull/7), Layer 1 | dual-lattice and discriminant vocabulary in the arithmetic setting | 2 | hard |
| [Modular forms](../ModularForms/README.md), Layer 7 | the newform L-series, its Euler product, completion, functional equation, and analytic conductor | 0, instance ledger only | hard for that row only |
| PrimeNumberTheoremAnd | the Wiener–Ikehara theorem, and the rational prime number theorem for the `K = ℚ` agreement check | 9 | external, see [`PROVENANCE.md`](PROVENANCE.md) |

The edge to integral lattices runs both ways, but the graph stays acyclic because the two
directions are between different layers:

> Integral lattices Layer 1 → **this roadmap's Layer 2** → integral lattices Layer 8.

That is: their Layer 1 fixes the arithmetic dual-lattice vocabulary, this roadmap's Layer 2
proves the general analytic Poisson summation and theta transformation, and their Layer 8
consumes it to prove the arithmetic specialization. Neither roadmap duplicates the
other's half.

Two things this roadmap is often assumed to depend on, and does not. **It does not depend on
class field theory for Chebotarev**: Layer 8's route is the one that goes through cyclotomic
extensions, and every milestone of Layer 8 except the ray-class equidistribution statement of
8E is independent of the global class field theory roadmap. **It does not depend on profinite
cohomology**: there is no Galois cohomology anywhere here.

Where a supplier's declarations do not exist yet, build against the shape stated in the layer
text; the dependency is on an interface, not on a schedule. Where Mathlib has an open pull
request covering the same ground, the roadmap fixes that pull request's spelling, so that
adopting it later is a deletion and an import.

## Standing hypotheses

Work over a number field `K` with `[Field K] [NumberField K]`; write `𝓞 K` for
`NumberField.RingOfIntegers K`. Spell hypotheses out; do not bundle them into new classes.
Coefficients live in `ℂ`; an L-series is always Mathlib's `LSeries` of a coefficient
function `ℕ → ℂ` (the `n = 0` term is dropped by `LSeries.term`), and ideal-indexed series
enter *only* through the named norm coefficient of Layer 1 — never as a rival
`Ideal`-indexed summation theory. Real-limit statements at `s = 1` use the `𝓝[>] 1` idiom of
the pin's class number formula. Do not assume `K ≠ ℚ`: every construction must recover the
classical object at `K = ℚ` (`dedekindZeta ℚ` versus `riemannZeta` is a worked example, not
an afterthought). Characters of ray class groups are the ones the [global class field theory
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/6) constructs, and every statement
here is phrased against that interface rather than a private encoding. The modulus-one case
(characters of `ClassGroup (𝓞 K)`) is a worked example of the general theory, not a stepping
stone to be replaced later.

Prime sets have **one carrier**: `IsDedekindDomain.HeightOneSpectrum (𝓞 K)`, matching the
carrier of the Dirichlet-density API. Where a statement is more natural over nonzero prime
ideals of `𝓞 K`, it is stated over `HeightOneSpectrum` and the translation is a named lemma
of Layer 8A, proved once. Mixing carriers between two public theorems is a defect.

⚠ Junk values are a standing trap: `LSeries f s = 0` where not summable, so
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
| Euler factors | Galois type at a finite prime `𝔭`: `det(1 − Frob_𝔭 · 𝔑𝔭^{-s} ∣ V^{I_𝔭})⁻¹` with **arithmetic** Frobenius — "Frobenius" unqualified always means arithmetic (`x ↦ x^q` on residue fields), the pin's `IsArithFrobAt`/`arithFrobAt` and the LocalFields convention; the geometric-Frobenius form (Deligne) is a translation lemma, never a second convention. For a ray-class character: `(1 − χ(𝔭) 𝔑𝔭^{-s})⁻¹` at `𝔭 ∤ 𝔪` and `1` at `𝔭 ∣ 𝔪` (`χ` primitive), compatible under the Artin map with the Galois form because GCFT's reciprocity sends uniformizers to arithmetic Frobenius | [LocalFields](https://github.com/roed-math/TauCetiRoadmap/pull/2) convention table; Layer 1 |
| normalization of the data record | The record built in Layer 0 is **analytic-normalized**, and its name says so: the functional equation reflects in `s ↦ 1 − s`, Dirichlet agreement holds on `Re s > 1`, and the gamma shifts are the analytic ones. It carries no motivic weight. An arithmetic-normalized instance — a weight-`k` newform, say, whose functional equation is centered at `k/2` — is related to an analytic one by the translation structure of Layer 0.4, which carries the weight `w` and pins the direction of the shift `L_arith(s) = L_an(s − w/2)`. Degree, conductor, root number, and the multiplicities of zeros are invariant under the translation, and that invariance is a theorem, not an assumption | Layer 0 |
| spectral parameters | Gamma data is carried as the multisets `{μ_j}` (for `Gammaℝ(s + μ_j)`) and `{ν_k}` (for `Gammaℂ(s + ν_k)`); `degree = #μ + 2·#ν`. LMFDB's `mu`/`nu` lists | Layer 0 |
| Frobenius | The public statements use the number field arithmetic roadmap's `frobeniusClass K L 𝔭` and its unramified-prime predicate; there is no rival `frobeniusClass` here. Underneath, the pin's `arithFrobAt R G Q` with `IsArithFrobAt` and the conjugacy well-definedness `isConj_arithFrobAt`; the decomposition group is `MulAction.stabilizer G Q`, there being no `decompositionSubgroup` for ideals at the pin | `Mathlib/RingTheory/Frobenius.lean`; number field arithmetic; Layer 8 |
| Dirichlet density | The public predicate is `HasDirichletDensity S δ`, the ratio to the sum over *all* nonzero primes: `(∑_{𝔭 ∈ S} 𝔑𝔭^{-s}) / (∑_{𝔭} 𝔑𝔭^{-s}) → δ` along `𝓝[>] 1` in real `s`, with the partial sum named `primeIdealZetaSum S s`. This is Mathlib #41765's spelling exactly, in namespace `NumberField.Set` and used as `S.HasDirichletDensity δ`. Neukirch's `log((s−1)⁻¹)` denominator is **not** a second definition: it is Layer 8A.2's theorem `primeIdealZetaSum univ s / log((s−1)⁻¹) → 1` together with the resulting equivalence. No theorem statement here uses the numerical `dirichletDensity` with its junk value | Layer 8A; Neukirch VII (13.1) |
| upper and lower Dirichlet density | `limsup` and `liminf` of the same ratio, as separate predicates. The crossing argument of Layer 8C produces a lower bound on a `liminf` and nothing else, so these two are used, not decoration; `upper = lower → HasDirichletDensity` is Layer 8A.3 | Layer 8A |
| natural density | `δ(M) = lim_{x→∞} #{𝔭 ∈ M ∣ 𝔑𝔭 ≤ x} / #{𝔭 ∣ 𝔑𝔭 ≤ x}`; `δ` exists ⇒ `d` exists and they agree (named lemma, Layer 8); the converse is **false** (leading-digit example) — Chebotarev is stated for Dirichlet density in Layer 8 and upgraded to natural density in Layer 9, and the LMFDB-facing form is the natural one | Layer 8/9 |
| polar density | `m/n` when `ζ_{K,T}(s)^n` extends meromorphically near `s = 1` with a pole of order `m` (Marcus; Milne CFT VI §3). Existence implies Dirichlet density with the same value. It is what makes the splitting-density theorem provable without class field theory, and it is used nowhere else | Layer 8A; Milne CFT VI §3 |
| functional-equation route | **Hecke's theta method**, for Layers 3, 5, and 6; the reasons are in the next section. Tate's adelic derivation is out of scope | this roadmap |

## Why the functional equation is proved by Hecke's method

There are two classical proofs of the functional equation of the Dedekind zeta function:
Hecke's, by a theta kernel and Poisson summation on the Minkowski lattice, and Tate's, by
Fourier analysis on the ideles. Layers 2, 3, 5, and 6 use Hecke's. The reasons, in decreasing
order of weight:

1. **It continues the functional-equation machinery Mathlib already has.** Every completed
   functional equation in Mathlib (ζ, Hurwitz even/odd, `ZMod`, Dirichlet) is proved by
   exactly Hecke's method in dimension 1: a theta kernel, its Poisson-summation
   transformation, and the Mellin transform `WeakFEPair`/`StrongFEPair`. The number
   field case is the same skeleton one dimension up (Lang XIII and Neukirch VII §§3–8 are
   400 lines of mathematics away, not a new theory), and the Loeffler–Stoll line even
   staged the multivariate Fourier prerequisite (`Analysis/Fourier/AddCircleMulti.lean`,
   Loeffler 2023 — multivariate Fourier series with uniform convergence, which is the proof
   the proof of lattice Poisson summation rests on).
2. **The hard core already exists at the pin.** Both proofs need the same genuinely
   hard input (Lang ch. XIII, and its adelic twin in ch. XIV): a fundamental domain
   for the unit action on the norm-one hypersurface of Minkowski space with measure
   proportional to the regulator. That is precisely what Roblot built for the class number
   formula (`NumberField/CanonicalEmbedding/FundamentalCone.lean`, `NormLeOne.lean`,
   `Ideal/Asymptotics.lean`, `ZLattice/Covolume.lean`). Hecke's proof consumes it directly;
   Tate's would rebuild it inside an idele-class fundamental domain.
3. **The adelic route's prerequisites are absent.** Tate's thesis needs
   Fourier analysis on local fields and adeles: self-dual characters, Schwartz–Bruhat
   functions, self-dual Haar normalizations (`vol(𝒪) = 𝔑𝔇^{-1/2}`), restricted-product
   integration, adelic Poisson summation/Riemann–Roch, and compactness/discreteness of
   `𝔸_K/K` — none of which exists at the pin (the adele ring stops at its definition plus
   local compactness of the infinite part; there is no idele class group, and Pontryagin
   duality/Fourier inversion at LCA generality — which Lang *assumes* — is itself
   incomplete in Mathlib). These are wonderful targets, but they belong to the
   adelic/automorphic program (FLT's terrain), not on the critical path of the LMFDB
   background.
4. **Hecke's method suffices for everything this roadmap promises**, including general
   Grossencharacters: Neukirch VII §§6–8 (the on-hand primary source) executes Hecke's
   proof in full generality — theta series with `N(x^p)` weights, Gauss sums, root number
   `W(χ)` with `|W(χ)| = 1` (Theorem (8.5)/Corollary (8.6)). Lang warns (ANT p. 243) that
   his ch. XIII does ζ_K only and that he does characters "only in Tate's version" — so
   Neukirch, not Lang, is the source of record for Layers 5–6.
5. **Nothing downstream depends on which proof was used.** The two produce literally the same
   completed function (Lang XIV Cor. 3 = XIII Thm 2), and every consumer sees only the
   Layer-0 interface, so an adelic treatment written later in some other roadmap costs this
   one nothing.

Two costs come with the choice, and are worth stating. Layer 6 inherits Hecke's
per-infinity-type bookkeeping, where Tate's argument is uniform in the character; that is the
real elegance of the adelic proof. And the theta method does not produce the factorization of
the root number into local constants, `W(χ) = ∏_v W_v(χ)`, which is why that factorization is
out of scope.

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
  nearest thing to Landau's theorem at the pin); `SumCoeff.lean` (Roblot: `LSeriesSummable_of_sum_norm_bigO`,
  `LSeries_eq_mul_integral`, and the residue theorem
  `LSeries_tendsto_sub_mul_nhds_one_of_tendsto_sum_div(_and_nonneg)`).
- **The abstract functional equation:** `LSeries/AbstractFuncEq.lean` —
  `WeakFEPair`/`StrongFEPair` (fields
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
  L² and uniform convergence, which is what Layer 2's lattice Poisson summation is proved from);
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

## What is missing (build here)

The entire data-model layer: nothing at the pin carries degree, conductor, spectral
parameters, or root number, and no statement links them (`‖rootNumber χ‖ = 1`
is unproved even for Dirichlet characters), nor is there any translation between the
arithmetic and analytic normalizations. The named ideal-norm coefficient function and
its multiplicativity; the Euler product of `dedekindZeta`; local Euler-factor data with its
bad primes recorded. Analytic continuation of `dedekindZeta` beyond `Re s > 1` — into the
strip `Re s > 1 − 1/[K:ℚ]` by ideal counting, and to `ℂ` by the theta method — the
completed `Λ_K`, its functional equation, and its poles/residues; the same for partial zeta
functions per class. Poisson summation for a general lattice, the Hecke theta
transformation, and the level extension of the abstract functional equation. Hecke L-series of ray-class
characters and of Grossencharacters: Euler products, Gauss sums with
`|τ(χ)| = √𝔑(𝔪)`, completed FEs with root numbers, primitivity/induction of characters.
Special values: `L(1, χ)` for quadratic characters, the finite class number formulas, the
factorization `ζ_K = ζ · L(χ_d)` for quadratic fields and `ζ_{ℚ(ζₙ)} = ∏ L(χ)`. Landau's
theorem on singularities of Dirichlet series with nonnegative coefficients; nonvanishing of
ray-class L-functions at `s = 1` and on `Re s = 1`, in meromorphic-order form. Every density notion for primes (Dirichlet,
natural, polar, and the two one-sided ones), their comparison lemmas and the density-zero
reductions; the splitting-density theorem, the Frobenius density theorem, ray-class
equidistribution, and the **Chebotarev density theorem**; Bauer's theorem and the split-set
rigidity corollaries. The prime ideal
theorem `π_K(x) ∼ x/log x`, with the ideal von Mangoldt function and the intermediate
`ψ_K` and `θ_K` asymptotics it goes through, and the natural-density form of Chebotarev.
None of this exists in Mathlib as stated.

---

## The build, in layers

Layers 0 and 1 come first. After them the roadmap splits into three parts that can be built
at the same time and by different people: Layers 2, 3, 5, 6 (the functional equation); Layer 4
(special values); and Layers 7, 8 (nonvanishing and densities), which need only Layer 1's
continuation into the strip `Re s > 1 − 1/[K:ℚ]` and the residue there, never the functional
equation. Layer 9 needs 7 and 8. The full graph, including the edges to other roadmaps, is in
*Ordering* below. As each layer makes the next one's types expressible, its milestones are
added to `Suggested.lean` with `sorry`.

### Layer 0: the L-function data model and the instance ledger

The axiomatics of Iwaniec–Kowalski ch. 5, as a structure with separate predicates over
`LSeries`: the layer every LMFDB L-function page instantiates.

1. **The record.** `AnalyticLFunctionData`, carrying coefficients `a : ℕ → ℂ`; the arithmetic
   conductor `conductor : ℕ+`; the spectral parameters as multisets `gammaR`, `gammaC` of
   complex shifts; the root number `ε`; a total representative `Λ : ℂ → ℂ` of the completed
   function; and an exact finite polar divisor `polarOrder : ℂ →₀ ℕ`. The representative is
   total because that is Mathlib's function type; no predicate below inspects its value at a
   pole. Accessors: `degree = #gammaR + 2·#gammaC`, the gamma factor
   `γ(s) = ∏ Gammaℝ(s + μ) ∏ Gammaℂ(s + ν)`, and the conjugate dual
   `Λ^∨(s) = conj (Λ (conj s))`.
   ⚠ The name is not decoration. The record is **analytic-normalized**: 2 places the
   functional equation at `s ↦ 1 − s`, 3 places Dirichlet agreement on `Re s > 1`, and the
   gamma shifts are the analytic ones. It carries no motivic weight, and no docstring may
   claim it does. An arithmetic-normalized object reaches these predicates only through 4.
2. **Dirichlet agreement.** `HasDirichletAgreement`: `a 1 = 1`, `0 < degree`, and
   `Λ(s) = conductor^{s/2} γ(s) (L a)(s)` for `1 < Re s`. ⚠ The region hypothesis is not
   removable: off it, `L a` is a junk value.
3. **Continuation, functional equation, coefficient growth**, as three further predicates,
   because instances satisfy different subsets and the model has to say which.
   `HasMeromorphicContinuation`: `Meromorphic Λ`, `meromorphicOrderAt Λ p = −polarOrder p` at
   each recorded pole, and nonnegative order elsewhere.
   `HasFunctionalEquation`: `‖ε‖ = 1`, invariance of the polar divisor under `s ↦ 1 − conj s`,
   and `Λ(s) = ε · Λ^∨(1 − s)` off the two polar loci. Together with continuation this is an
   equality of punctured germs, so it fixes matching principal parts without comparing any
   value at a pole. Residues and higher principal parts are instance theorems; Layer 3
   requires them explicitly for the Dedekind zeta function.
   `HasAverageCoefficientBound`: `∑_{n ≤ x} ‖a n‖ = O(x^{1+δ})` for every `δ > 0`. This is the
   form every instance can prove; pointwise Ramanujan is instance-specific and is not part of
   the model.
4. **The arithmetic and analytic normalizations, and the translation between them.** A second
   record `ArithmeticLFunctionData` differing only in that its functional equation is centered
   at `(w+1)/2` for an integer weight `w`, and a structure relating a pair:

   ```lean
   structure NormalizationTranslation where
     arithmetic : ArithmeticLFunctionData
     analytic   : AnalyticLFunctionData
     weight     : ℤ
     coeff      : ∀ n : ℕ, analytic.a n = arithmetic.a n / (n : ℂ) ^ ((weight : ℂ) / 2)
     completed  : ∀ s : ℂ, analytic.Λ s = arithmetic.Λ (s + (weight : ℂ) / 2)
     gammaR     : analytic.gammaR = arithmetic.gammaR.map (· - (weight : ℂ) / 2)
     gammaC     : analytic.gammaC = arithmetic.gammaC.map (· - (weight : ℂ) / 2)
     polar      : ∀ p, analytic.polarOrder p = arithmetic.polarOrder (p + (weight : ℂ) / 2)
   ```

   with the shift direction fixed as displayed and not left to the implementer. Theorems:
   conductor, degree, root number, and the multiplicity of a zero are the same on both sides;
   a translation exists for every arithmetic record and is unique; the analytic side satisfies
   2 and 3 exactly when the arithmetic side satisfies their translates. ⚠ Verify the structure
   against two instances before believing it — the Dirichlet card (`w = 0`, so the translation
   is the identity and the fields must all reduce to `rfl`) and a weight-`k` newform
   (`w = k − 1`, the first genuinely nonzero shift). Getting the sign of the shift wrong is
   invisible until the newform card, which is why the newform check is an acceptance criterion.
5. **The ζ instance card**, immediately, since it is complete at the pin: degree 1, conductor
   1, `gammaR = {0}`, `ε = 1`, `Λ = completedRiemannZeta`, exact simple poles at `0` and `1`;
   the functional equation is `completedRiemannZeta_one_sub`, read off the polar locus.
6. **The Dirichlet instance card**, `χ` primitive mod `N > 1`: degree 1, conductor `N`,
   `gammaR = {0}` or `{1}` by parity, `Λ = N^{s/2} · completedLFunction χ`,
   `ε = rootNumber χ`; including the conductor power in the completion is what makes the
   pin's `N^{s−1/2}` functional equation constant-free, and the dictionary between the two
   shapes is a lemma of this layer. ⚠ This card cannot be closed with what the pin has:
   `‖rootNumber χ‖ = 1` is unproved there and must be proved here, from
   `gaussSum_mul_gaussSum_eq_card`. It is the first thing the model finds missing.
7. **The instance ledger**, each row discharged in the layer named. ζ and Dirichlet here;
   Dedekind `ζ_K` in Layer 3; ray-class Hecke in Layer 5; Grossencharacters in Layer 6; the
   quadratic and cyclotomic factorizations in Layer 4. One row is consumed rather than built:
   a newform card over the [modular forms roadmap](../ModularForms/README.md), whose Layer 7
   supplies convergence, the Euler product, the completed `Λ_N`, the two-form equation
   `Λ_N(k − s, f) = i^k Λ_N(s, g)`, entirety, and the analytic conductor of
   Iwaniec–Kowalski (5.7). The milestone here is only the card: degree 2, arithmetic
   conductor `N`, and the translation of 4 at `w = k − 1`.
   Artin L-functions are not a row. Layers 5–6 are built at the generality a
   representation-theoretic roadmap needs for Brauer induction, and that roadmap owns any
   Artin instance and induction theorem.
   Elliptic curves are not a row either: no roadmap supplies classical modularity, so nothing
   asserts continuation or a functional equation for `WeierstrassCurve.LSeries`. A later
   supplier adds the row without changing anything here, which is why the predicates are
   separate.

### Layer 1: ideal-indexed series, Euler products, and the continuation strip

Everything about `ζ_K` that needs no theta function, and the vocabulary Layers 3, 5, 7, and 8
are all stated in. It discharges the `DedekindZeta.lean` TODO, "Generalize the construction".

1. **The norm coefficient.** `idealCoeff K : ℕ → ℂ`, `n ↦ #{I : Ideal (𝓞 K) ∣ absNorm I = n}`
   — the pin inlines this lambda inside `dedekindZeta` and never names it — with finiteness
   from `Ideal.finite_setOf_absNorm_eq`, and `dedekindZeta K = LSeries (idealCoeff K)`.
2. **The weighted norm coefficient.** For `χ` a function on nonzero ideals of `𝓞 K` with
   values in `ℂ`, `idealCoeffOfWeight χ : ℕ → ℂ`, `n ↦ ∑_{𝔑𝔞 = n} χ 𝔞`, and its L-series
   `L(χ, s) = LSeries (idealCoeffOfWeight χ) s`. Every character L-function in this roadmap
   is this series for a particular `χ`, so the summability, Euler-product, and continuation
   lemmas are proved once here for a general `χ` satisfying stated hypotheses, not once per
   family. Bad primes are handled by the convention `χ 𝔭 = 0` at `𝔭` in the bad set, fixed
   here and used unchanged in Layers 5, 6, and 8.
3. **Multiplicativity and Dirichlet convolution.** `idealCoeff K` is multiplicative, from
   unique factorization of ideals and the coprime-norm case of the Chinese remainder theorem;
   `idealCoeffOfWeight` of a completely multiplicative ideal weight is multiplicative; and the
   norm grouping turns multiplication of ideal weights into Dirichlet convolution `⍟` of the
   resulting coefficient functions, which is the lemma that lets Mathlib's convolution API
   apply to ideal-indexed objects.
4. **The Euler product of the Dedekind zeta function.**
   `∏' 𝔭 : HeightOneSpectrum (𝓞 K), (1 − 𝔑𝔭^{-s})⁻¹ = dedekindZeta K s` on `1 < Re s`, from
   `EulerProduct.eulerProduct_hasProd`. ⚠ The index is primes of `𝓞 K`; the grouping over
   rational `p` by `𝔑𝔭 = p^f` (`Ideal.absNorm_eq_pow_inertiaDeg`) is a *second* statement, not
   the same one, and both are wanted because their consumers differ. Also: nonvanishing on
   `1 < Re s`, the logarithm `log ζ_K(s) = ∑_𝔭 ∑_m 𝔑𝔭^{-ms}/m` (the starting point of every
   density argument), and `abscissaOfAbsConv (idealCoeff K) = 1`.
5. **Local Euler-factor data.** Layer 0's records say nothing about local factors, and an
   existential "there is a polynomial at each prime" is not usable by a later theorem. So the
   local factors are *data*:

   ```lean
   structure EulerFactorData (K : Type*) [Field K] [NumberField K] where
     localPolynomial : IsDedekindDomain.HeightOneSpectrum (𝓞 K) → Polynomial ℂ
     bad : Set (IsDedekindDomain.HeightOneSpectrum (𝓞 K))
     bad_finite : bad.Finite
   ```

   with the properties as separate predicates over it: constant term `1` everywhere; degree
   at most `d` everywhere; degree exactly `d` off `bad`; `bad` contained in the support of the
   conductor; the local identity, that the coefficients of `(localPolynomial 𝔭)(T)⁻¹` as a
   power series are the values of the coefficient function at powers of `𝔭`; and the global
   identity, a `HasProd` for `∏_𝔭 (localPolynomial 𝔭 (𝔑𝔭^{-s}))⁻¹` in the half-plane of
   absolute convergence. The determinant realization
   `P_𝔭(T) = det(1 − Frob_𝔭 T ∣ V^{I_𝔭})` with arithmetic Frobenius is a *stronger* predicate
   on top, for the instances that have a Galois representation; it is not part of the
   definition.
   ⚠ Two Euler products, kept apart. The one above is indexed by primes of `𝓞 K`. Grouping
   the primes above a rational `p` gives a rational local polynomial of degree at most `[K:ℚ]`
   — a theorem relating the two, and a milestone. It is not automorphic induction, and no
   milestone calls it that: no induction object is built anywhere in this roadmap.
6. **Counting ideals in a class, with an error term.** The pin has
   `Ideal.tendsto_norm_le_and_mk_eq_div_atTop`, a limit with the constant independent of the
   class. What Layers 1.7 and 7 need is the error form: for a fixed ideal class `𝔎` of `K`,
   `#{I ∈ 𝔎 ∣ 𝔑I ≤ x} = ρ_K x + O(x^{1−1/d})` as `x → ∞`, with `d = [K:ℚ]` and
   `ρ_K = 2^{r₁}(2π)^{r₂}R/(w√|d_K|)`. The exponent `1 − 1/d` is exact and part of the
   statement; the implied constant depends on `K` and not on `𝔎`, which is also part of the
   statement and is what makes the sum over classes work. Source: Milne CFT VI 2.8, proof
   cited to Lang VI §3 Thm 3; Janusz IV 2.11–2.13 is the same over `ℤ`. ⚠ This is the hard
   analytic milestone of the layer. It strengthens Roblot's limit-only asymptotics, so state
   it so that his files could adopt it.
7. **Continuation into the strip.** From 6 through `LSeriesSummable_of_sum_norm_bigO` and
   `LSeries_eq_mul_integral`: the partial zeta `ζ(s, 𝔎)` of 8, and hence `dedekindZeta K`,
   extend analytically to `Re s > 1 − 1/d` except for a simple pole at `s = 1` (Janusz
   IV 2.14; Milne VI 2.9, 2.12). This includes the complex-residue form
   `(s − 1) ζ_K(s) → dedekindZeta_residue K` along `𝓝[≠] 1`, strengthening the pin's
   one-sided real limit. **This strip is all of Layers 7 and 8 needs**, which is why they do
   not wait on the functional equation.
8. **Partial zeta functions.** For a finite quotient `q : J_K → Q` of the group of fractional
   ideals prime to a modulus — the ideal class group when the modulus is `1`, a ray class
   group otherwise, and in both cases the quotient is named rather than left abstract —
   the partial zeta `ζ(s, c) = ∑_{q(𝔞) = c, 𝔞 integral} 𝔑𝔞^{-s}` for `c : Q`, with
   `dedekindZeta K = ∑_{c} ζ(·, c)` and, for a character `χ` of `Q`,
   `L(χ, s) = ∑_{c} χ(c) ζ(s, c)`. Both are finite sums, written out. The inverse relation
   `ζ(s, c) = (#Q)⁻¹ ∑_χ conj (χ c) L(χ, s)` by orthogonality is the form Layer 8 uses, and
   is a milestone here.
9. **The residue of a partial zeta, and equidistribution of classes.** `ζ(s, c)` has a simple
   pole at `s = 1` with residue `ρ_K/#Q` independent of `c`, from 6 and 7. Consequences: for
   `χ ≠ 1`, `L(χ, s)` is holomorphic at `s = 1`, which is the statement Layer 7's nonvanishing
   completes.

### Layer 2: lattice Poisson summation, theta transformations, and the level-`N` frame

Self-contained analysis: no number theory beyond the lattice vocabulary, and every item is
worth having on its own. This roadmap owns the general theory; the [integral lattices
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7) consumes 1–7 and proves only its
own arithmetic specialization, and 10–13 here consume its Layer-1 dual-lattice vocabulary.

1. **The analytic dual lattice.** For a `ZLattice L` in a finite-dimensional real
   inner-product space `E`, the dual `Lᵛ = {w ∣ ∀ v ∈ L, ⟪v, w⟫ ∈ ℤ}`, with its `ZLattice`
   instance. Mathlib's `Submodule.dualSubmodule` is the pairing-with-a-bilinear-form version;
   name the analytic one and relate the two.
2. **Biduality**: `(Lᵛ)ᵛ = L`.
3. **Covolumes**: `ZLattice.covolume L * ZLattice.covolume Lᵛ = 1`, and the behavior of
   `covolume` under a linear equivalence.
4. **Fourier transform under a linear change of variables.**
   `𝓕(f ∘ B) = |det B|⁻¹ · (𝓕f) ∘ (Bᵀ)⁻¹` for `B` a linear equivalence of `E`, in Mathlib's
   `VectorFourier` normalization, stated so that 6 is a corollary of 5.
5. **Poisson summation for `ℤⁿ`**: `∑_{v ∈ ℤⁿ} f v = ∑_{w ∈ ℤⁿ} 𝓕f w` for Schwartz `f`.
   Route: periodize, expand in a multivariate Fourier series
   (`Analysis/Fourier/AddCircleMulti.lean`, which exists at the pin precisely for this), and
   evaluate at `0` — the same proof as the one-dimensional `Real.tsum_eq_tsum_fourier`.
6. **Poisson summation for a general lattice**:
   `∑_{v ∈ L} f v = (ZLattice.covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w`, by transporting 5 along a basis
   using 4 and 3. This is the declaration the integral lattices roadmap and the sphere-packing
   project both want; one proof serves all three.
7. **The Fourier transform of a Gaussian.** For a positive-definite quadratic form `Q` on `E`,
   `𝓕(exp(−π Q)) = (det Q)^{-1/2} exp(−π Q⁻¹)`. ⚠ The square-root bookkeeping is the trap:
   do it through `InnerProductSpace` and the self-adjoint square root, never through raw
   matrices.
8. **The Gaussian theta transformation.** `Θ_L(t) = ∑_{v ∈ L} exp(−π t ‖v‖²)` and
   `Θ_L(1/t) = t^{n/2} (covolume L)⁻¹ Θ_{Lᵛ}(t)` for `t > 0`, from 6 and 7; and the
   multi-parameter version with one scale `t_v` per coordinate block, which is what Layer 3
   integrates over the norm-one hypersurface (Lang XIII §2:
   `Θ(c, 𝔞) = (c₁⋯c_N)^{-1/2} Θ(c^{-1}, 𝔞')`).
9. **The polynomial-weighted Gaussian transform.** For `P` a harmonic polynomial homogeneous
   of degree `m`, `𝓕(P · exp(−π ‖·‖²)) = i^{−m} P · exp(−π ‖·‖²)`, and the resulting
   transformation of `∑_{v ∈ L} P(v) exp(−π t ‖v‖²)`. This is exactly what Layer 6's infinity
   types need, and it is the piece a roadmap that stopped at 8 would be missing.
10. **A fractional ideal as a lattice.** `mixedEmbedding K '' I` for a fractional ideal `I`,
    as a `ZLattice` in `K ⊗ ℝ`.
11. **Its dual is the trace dual.** The analytic dual of `mixedEmbedding K '' I` is
    `mixedEmbedding K '' (I𝔡)⁻¹`, with `𝔡` the different — the one place in this roadmap
    where the different appears (`FractionalIdeal.dual`,
    `RingTheory/DedekindDomain/Different.lean`).
12. **Its covolume**: `2^{-r₂} √|d_K| 𝔑(I)`, from the pin's covolume machinery.
13. **The theta series of an ideal class**, from 8 and 10–12: the multi-parameter
    transformation with the discriminant and norm factors written out, in the exact form
    Layer 3.1 integrates. No factor is left as "the explicit constant".
14. **The level-`N` functional-equation frame.** Mathlib's `AbstractFuncEq.lean` handles
    `f(1/x) = ε x^k g(x)`; its own TODO asks for the level form `f(N/x) = ε x^k g(x)`,
    producing a completed function with a functional equation `s ↦ k − s` against level `N`.
    Both `Λ_K` (level `|d_K|`) and Hecke L-functions (level `|d_K| 𝔑𝔣`) instantiate it.
    A rescaling `f ↦ f(√N ·)` reducing to the level-one frame is a perfectly good proof; the
    deliverable is the reusable statement with the constants threaded, not a particular proof.
    ⚠ Mathlib reworked this file after the pin (#41329, merged 2026-07-04) around an
    `IsStrongFEPair` predicate, and the level extension is specified against that shape rather
    than the pin's: a predicate `IsLevelFEPair N f g ε k` with the fields of `IsStrongFEPair`
    plus the level, and a theorem reducing it to `IsStrongFEPair` for the rescaled pair. If the
    project pin still predates the rework when this is built, state the predicate on its own
    rather than on `AbstractFuncEq`; the milestone is the predicate and the reduction theorem
    either way.

### Layer 3: the Dedekind zeta function — continuation and functional equation

Hecke's proof (Lang XIII §§1–3; Neukirch VII §5), on Layers 1 and 2. This is what the LMFDB's
number-field pages display.

1. **The theta identity, written out.** For an ideal class `𝔎` with `𝔞 ∈ 𝔎⁻¹`, the identity
   Layer 2.13 supplies, in the exact form this layer integrates: every power of `|d_K|`, every
   norm `𝔑𝔞`, and every factor of `2` present. ⚠ No milestone here may contain the phrase
   "the explicit factor". If a constant is not written, it is not specified.
2. **The class pairing.** The functional equation permutes ideal classes:
   `𝔎 ↦ 𝔎' := [𝔡]𝔎⁻¹`, with `𝔡` the different. State it as a typed map
   `dualClass : ClassGroup (𝓞 K) → ClassGroup (𝓞 K)`, prove it is an involution, and prove it
   is induced by trace duality through Layer 2.11. ⚠ It is `[𝔡]𝔎⁻¹` and not `𝔎⁻¹`; only the
   sum over classes is self-dual, and getting this wrong produces a statement that is true for
   `K = ℚ` and false in general. This is an acceptance criterion.
3. **The Mellin split and the principal parts.** Unfold `ζ(s, 𝔎)` over unit orbits of
   `𝔞 ∖ {0}`, Mellin-transform the ideal theta against the fundamental domain of the unit
   action on the norm-one hypersurface (`FundamentalCone`, measure `2^{r₁+r₂−1} R` — the
   regulator Jacobian, Lang p. 258, the hard point of the layer), split the integral at `1`,
   and identify the two elementary terms that produce the poles. Both terms are named.
4. **Per-class completion and functional equation.**
   `Z(𝔎, s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ(s, 𝔎)` is meromorphic on `ℂ`, with
   `meromorphicOrderAt (Z 𝔎) 0 = −1` and `meromorphicOrderAt (Z 𝔎) 1 = −1`, no other poles,
   residues `∓ 2^{r₁+r₂} R/w` (the completed constants: `Gammaℝ(1) = 1` and `Gammaℂ(1) = 1/π`
   absorb the `(2π)^{r₂}/√|d_K|` of the uncompleted residue), and
   `Z(𝔎, s) = Z(dualClass 𝔎, 1 − s)`.
5. **Uniqueness of the continuation.** The meromorphic continuation of `ζ(·, 𝔎)` from
   `Re s > 1` is unique, by the identity theorem on the connected set `ℂ ∖ {0,1}`. This is
   what makes 6 and 7 definitions rather than choices, and it must be a milestone rather than
   an implicit step: without it, an existentially stated continuation determines nothing.
6. **`completedDedekindZeta K`**, a named definition, `Λ_K = ∑_𝔎 Z(𝔎, ·)`: meromorphic, exact
   simple poles at `0` and `1` and nowhere else, residues `∓ 2^{r₁+r₂} hR/w`, the functional
   equation `Λ_K(s) = Λ_K(1 − s)` as an equality of meromorphic germs, and
   `Λ_K(s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ_K(s)` on `Re s > 1`. Compatibility
   with `WeakFEPair.Λ_residue_k` is a theorem, not a coincidence.
7. **`dedekindZetaC K`**, the continued zeta function itself, holomorphic on `ℂ ∖ {1}`,
   agreeing with `dedekindZeta K` on `Re s > 1`, simple pole at `1` with residue
   `dedekindZeta_residue K` — now a genuine complex residue, subsuming the pin's one-sided
   real limit — and `dedekindZetaC ℚ = riemannZeta` **globally**. That last equation is why
   the continued object rather than the raw `LSeries` is what leaves this layer: it is false
   for `dedekindZeta ℚ`, whose junk values off the half-plane are `0`. Coordinate the name
   with the `DedekindZeta.lean` TODO.
8. **Exact orders at the trivial zeros.** `meromorphicOrderAt (dedekindZetaC K)` at `s = 0`
   and at each `s = −m`, as *formulas* in `r₁`, `r₂`, and the parity of `m`, derived from the
   poles of `Gammaℝ` and `Gammaℂ` through `Gammaℝ_eq_zero_iff` and the order arithmetic of
   `meromorphicOrderAt`. The order at `0` is `r₁ + r₂ − 1`. ⚠ These are multiplicities, not
   existence statements, and they are stated with `meromorphicOrderAt`: a pointwise
   "`ζ_K(−2) = 0`" claim compares a value that the functional equation never determines.
9. **The asymmetric functional equation**, Neukirch (5.11)(iii):
   `ζ_K(1 − s) = |d_K|^{s−1/2} (cos(πs/2))^{r₁+r₂} (sin(πs/2))^{r₂} (2(2π)^{−s}Γ(s))^{[K:ℚ]} ζ_K(s)`,
   written out with that exponent on the discriminant and not its negative, and the derivation
   of 8 from it as a cross-check.
10. **The instance card** for Layer 0's ledger: degree `[K:ℚ]`, conductor `|d_K|`, `gammaR`
    the `r₁`-fold multiset `{0}`, `gammaC` the `r₂`-fold multiset `{0}` (so
    `degree = r₁ + 2r₂` by definition), `ε = 1`, polar divisor supported at `{0,1}` with order
    `1` at each, self-dual. Every coherence condition of the card is a theorem of this layer,
    and `ζ_{ℚ(i)}` is the worked example that keeps the card from being vacuous.

### Layer 4: special values and the class number formula

Everything at `s = 1` and at the integers that the LMFDB's number-field and character pages
display. It needs Layer 1 and, for the statements about continued functions, Layer 3.

1. **The quadratic splitting law as a coefficient identity.** For `K` quadratic of
   discriminant `D`, `idealCoeff K n = ∑_{e ∣ n} χ_D(e)`, where `χ_D` is the primitive
   quadratic character **of conductor `|D|`** — the discriminant, not the radicand; the
   `d ≡ 1 mod 4` bookkeeping is the classical error. Construct `χ_D` explicitly from the
   Kronecker symbol, and prove it primitive; consume `LegendreSymbol`, `jacobiSym`, and
   quadratic reciprocity.
2. **The factorization.** `dedekindZeta K s = riemannZeta s · LFunction χ_D s` on `Re s > 1`,
   and after Layer 3 the same for the continued functions everywhere. The ramified primes
   `p ∣ D` are where this is usually stated wrong: `χ_D(p) = 0` there, both sides have the
   Euler factor `(1 − p^{-s})⁻¹`, and the worked example at `ℚ(i)` checks it at `p = 2`.
3. **Dirichlet's class number formula in finite form.** From 2, the pin's class number formula,
   and the residue of `LFunctionTrivChar`: for `D < 0`, `L(1, χ_D) = 2π h/(w √|D|)`; for
   `D > 0`, `L(1, χ_D) = 2 h log ε₀/√D`, with `ε₀` the fundamental unit. Both hypotheses on the
   sign of `D` are stated; neither formula is claimed in the other's range.
4. **The cyclotomic factorization.** Three readings of "the product over characters mod `n`"
   are in circulation and they differ; this is the one meant. Write `χ*` for the primitive
   character of conductor `f_χ` inducing `χ`. Then
   `ζ_{ℚ(ζₙ)}(s) = ∏_{χ mod n} L(χ*, s) · ∏_{χ mod n} ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p) p^{-s})`,
   the product over all Dirichlet characters mod `n` — equivalently, over the characters of
   `Gal(ℚ(ζₙ)/ℚ) ≅ (ℤ/n)ˣ` — and the second factor is exactly the Euler factors that `L(χ, ·)`
   drops at `p ∣ n` relative to `L(χ*, ·)`. Neukirch (5.12). Consume `LFunction_changeLevel` and
   `intermediateFieldEquivSubgroupChar`. This identity is also how `L(1, χ) ≠ 0` is proved over
   `ℚ` without class field theory (Janusz IV 5.7), which Layer 7 cites.
5. **Generalized Bernoulli numbers and values at nonpositive integers.** Define `B_{k,χ}` by
   `∑_{a=1}^{N} χ(a) t e^{at}/(e^{Nt} − 1) = ∑_k B_{k,χ} t^k/k!` for `χ` mod `N`, and prove
   `L(1 − k, χ) = −B_{k,χ}/k` for `k ≥ 1`. State the parity hypotheses: `L(1 − k, χ) = 0` when
   `χ(−1) ≠ (−1)^k`, and the trivial character is excluded (it has a pole at `s = 1` and its
   values at nonpositive integers are Riemann's, already in `HurwitzZetaValues`). This
   discharges that file's TODO.
6. **`L(1, χ₋₄) = π/4`**, connected to the pin's `Real.tendsto_sum_pi_div_four`. The smallest
   possible check that 3 and 5 agree with something independently known.

### Layer 5: Hecke L-functions of finite-order ray-class characters

The full analytic theory of a finite-order Hecke character's L-function. The characters
themselves come from the [global class field theory
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/6); this layer supplies the analysis
that its layers, and Mathlib's #40735/#40736, deliberately omit — convergence, continuation,
and the functional equation. The local factor `(1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` already agrees with
Browning's `localPolynomial`.

Name the interface precisely rather than saying "a ray-class character":

1. **The character and its data.** The finite-order Hecke character type of the global class
   field theory roadmap; its factorization through a ray class group `J^𝔪/P^𝔪`; the conductor
   `𝔣 = 𝔣₀ 𝔣_∞` with its finite part `𝔣₀` (an ideal) and its infinite part (a subset of the
   real places), which are **separate fields** and neither may be silently dropped; the
   induced character on ideals prime to `𝔣₀`; primitivity, and the change-of-level map
   relating a character mod `𝔪` to the primitive character it is induced from. Each of these
   is a named theorem of that roadmap, cited here, not re-derived.
2. **The L-series.** `L(χ, s) = LSeries (idealCoeffOfWeight χ) s` through Layer 1.2, with the
   convention `χ(𝔞) = 0` when `𝔞` is not coprime to `𝔣₀`; the Euler product
   `∏_{𝔭 ∤ 𝔣₀} (1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` on `Re s > 1` (Neukirch (8.1)); abscissa `1`; and, as an
   instance of Layer 1.5, its `EulerFactorData` with `bad = {𝔭 ∣ 𝔣₀}`.
3. **Continuation into the strip, and the pole.** From Layer 1.8's decomposition
   `L(χ, s) = ∑_c χ(c) ζ(s, c)` and Layer 1.7: `L(χ, ·)` extends to `Re s > 1 − 1/d`,
   holomorphically for `χ ≠ 1` (the residues cancel by orthogonality, Layer 1.9) and with a
   simple pole at `s = 1` for `χ = 1`. The relation between `L(1, ·)` and `ζ_K` differs by the
   Euler factors at `𝔭 ∣ 𝔣₀`, written out, in the shape of
   `LFunctionTrivChar_eq_mul_riemannZeta`.
4. **Imprimitive correction.** For `χ` mod `𝔪` induced from primitive `χ*` mod `𝔣₀`,
   `L(χ, s) = L(χ*, s) ∏_{𝔭 ∣ 𝔪, 𝔭 ∤ 𝔣₀} (1 − χ*(𝔭)𝔑𝔭^{-s})`, a finite product written out.
   The functional equation is asserted only for primitive characters, as in Mathlib's
   `IsPrimitive` discipline.
5. **The archimedean parity data and the gamma factor.** From the infinite part of the
   conductor: `Gammaℝ(s)` at a real place where `χ` is trivial on positive elements,
   `Gammaℝ(s + 1)` where it is not, and `Gammaℂ(s)` at each complex place, so
   `gammaR` has `r₁` entries with multiplicities determined by `𝔣_∞` and `gammaC` has `r₂`
   entries. Say which convention on `𝔣_∞` is used and match it to the supplying roadmap's.
6. **Gauss sums.** `τ(χ)` for a primitive character, and `|τ(χ)| = √𝔑(𝔣₀)`
   (Neukirch VII (6.4), (7.5)). ⚠ Neukirch's ideal-number device (his `K̂^*`) is not
   canonical; define the Gauss sum against explicit representatives, or against the supplying
   roadmap's idele-theoretic data, and prove independence of the choices. The check that this
   was done right is that `W(χ)` in 8 is choice-independent.
7. **The completed L-function.**
   `Λ(χ, s) = (|d_K| 𝔑𝔣₀)^{s/2} L_∞(χ, s) L(χ, s)` with `L_∞` the gamma factor of 5; entire
   for `χ ≠ 1`; and the per-ray-class partial functional equations carrying the `[𝔣₀𝔡]`-twist
   exactly as Layer 3.2 carries `[𝔡]`. Route: Layer 2's theta machinery with `χ`-weights
   (Neukirch VII §7 (7.6), (7.7)).
8. **The functional equation and the root number.**
   `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` with `W(χ) = τ(χ)/(i^{#𝔣_∞} √𝔑𝔣₀)` written out, and
   `‖W(χ)‖ = 1` proved from 6 (Neukirch (8.5)/(8.6), restricted to infinity type `(p,0)` with
   `p ∈ {0,1}^{r₁}`).
9. **The instance card, and the degree over `ℚ`.** Ledger row: degree `1` over `K`. Its
   realization as a degree-`[K:ℚ]` Euler product over `ℚ` is the grouping theorem of Layer 1.5,
   and the card records both. At `K = ℚ` the construction recovers Mathlib's Dirichlet objects
   **exactly**: the two completed functions are equal, not merely the two functional equations.
   That is an acceptance criterion.

### Layer 6: Grossencharacters

The infinite-order theory — the LMFDB's "Hecke characters" in full — which completes the
degree-one-over-`K` family. The characters, their infinity types, and the idele-class to
ideal-theoretic dictionary come from the global class field theory roadmap.

1. **The interface consumed**, named: that roadmap's Grossencharacter type; the unitary twist
   decomposing `χ` as (unitary) × `‖·‖^{σ}`; the algebraic (`A₀`) subtype; the infinity type
   as exponents `(p_v, q_v)` at each place, with `p_v ∈ ℤ` at real places and a pair of
   integers at complex places, `q ∈ ℝ^{r₁+r₂}`; and the admissibility condition (`χ_∞` trivial
   on units) which is a hypothesis here and a theorem there. Neukirch VII (6.11)–(6.14).
2. **The gamma factor from the infinity type.** `L_∞(χ, s) = ∏_v Γ_v(s + (p_v − i q_v))` with
   the exact translation of Neukirch §4's `G(ℂ|ℝ)`-set formalism into `Gammaℝ` and `Gammaℂ`
   shifts, spelling out the exponent at each real and each complex place. These are the first
   genuinely complex entries of Layer 0's spectral multisets.
3. **The weighted theta series**, from Layer 2.9: `∑_{x ∈ 𝔞} N(x^p) exp(−π ∑_v t_v |x_v|²)`,
   its transformation with the constant `W(χ, p̄)`, and the Mellin assembly. The harmonic
   weight is exactly the polynomial of Layer 2.9, which is why that item is in Layer 2.
4. **Continuation, poles, and the functional equation** (Neukirch (8.5)/(8.6)): `Λ(χ, s)` is
   meromorphic, and entire **unless** `𝔣 = 1` and `p = 0`, that is unless `χ` is a power of the
   norm character. In that exceptional case the poles are exactly at
   `s = Tr(−p + iq)/n` and `s = 1 + Tr(p + iq)/n`; the classification of the exceptional case
   is part of the statement, and "the exceptional case" is not left unspecified anywhere.
   `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` with `‖W(χ)‖ = 1`.
5. **The nonvanishing consequences, packaged.** Layer 7.4 proves `L(χ, 1 + it) ≠ 0` for these
   characters; this item packages the consequence a roadmap doing equidistribution wants,
   namely nonvanishing for the twists `χ ‖·‖^{it}` uniformly in `t`, with the exceptional
   norm-power case excluded explicitly by 4. ⚠ This is a typed export, not equidistribution:
   the Weyl criterion for a compact group is out of scope here and belongs to whichever
   roadmap owns Sato–Tate.
6. **Hecke's equidistribution of Gaussian primes**, worked in full: the arguments of the
   primes of `ℤ[i]` are equidistributed in `[0, π/2)`, by applying 5 to the characters
   `𝔞 ↦ (α/|α|)^{4k}` of `ℚ(i)`. This is a theorem of this roadmap, and it is the only
   equidistribution statement here; it exists because it is what checks that 1–5 are usable.

### Layer 7: nonvanishing, Landau's theorem, and the analytic premise behind it

The analytic input to every density theorem, proved **without class field theory** so that
Layer 8 does not wait on it. The class-field-theoretic proof of nonvanishing —
`ζ_L = ζ_K ∏_χ L(χ, ·)` over the class field, Neukirch (13.3), Janusz V 10.2, Milne VIII 7.1 —
is a corollary once the global class field theory roadmap exists, recorded in 7 below, and
nothing here depends on it.

1. **Landau's theorem.** A Dirichlet series with nonnegative real coefficients has a
   singularity at its abscissa of absolute convergence: no function holomorphic on a
   neighborhood of `(abscissa : ℂ)` agrees with the series on the intersection of that
   neighborhood with the half-plane of convergence. Absent at the pin, where
   `LSeries.positive_of_differentiable_of_eqOn` is the nearest thing. It is used in 4 and in
   Layer 8A, and it is worth having on its own.
2. **Weighted ideal characters, as data with an analytic premise.** The theorems below are
   wanted for two different families — ray-class characters (Layer 5) and the Frobenius
   characters `𝔭 ↦ χ(Frob_𝔭)` of an abelian extension (Layer 8) — and the temptation is to
   state them for "a character of a finite quotient of the ideal group". That hypothesis is
   too weak: the group of ideals prime to a finite set is free, so it has finite quotients
   whose values on primes are arbitrary, and no continuation follows. The analytic content
   has to be a hypothesis. So:

   ```lean
   structure IdealWeight (K : Type*) [Field K] [NumberField K] where
     toFun : Ideal (𝓞 K) → ℂ
     bad : Set (IsDedekindDomain.HeightOneSpectrum (𝓞 K))
     bad_finite : bad.Finite
     map_mul : ∀ 𝔞 𝔟, toFun (𝔞 * 𝔟) = toFun 𝔞 * toFun 𝔟
     norm_eq_one : ∀ 𝔭 ∉ bad, ‖toFun 𝔭.asIdeal‖ = 1
     eq_zero_bad : ∀ 𝔭 ∈ bad, toFun 𝔭.asIdeal = 0
   ```

   together with the separate predicate carrying the estimate the continuation actually
   needs:

   ```lean
   def HasCancellation (χ : IdealWeight K) : Prop :=
     (fun X : ℝ ↦ ∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ X}, χ.toFun I)
       =O[atTop] fun X : ℝ ↦ X ^ (1 - 1 / (Module.finrank ℚ K : ℝ))
   ```

   that is, `∑_{𝔑𝔞 ≤ X} χ(𝔞) = O(X^{1 − 1/d})` with `d = [K:ℚ]`. Together with the
   coefficient function `idealCoeffOfWeight χ` of Layer 1.2 this gives what is needed:
   `HasCancellation` implies that `L(χ, ·)` continues holomorphically to `Re s > 1 − 1/d`, by
   Layer 1.7 applied to the partial sums, and every nonvanishing theorem below takes
   `HasCancellation` as a hypothesis rather than deducing it from finiteness of a quotient.
3. **`HasCancellation` for the two families.** For a nontrivial finite-order ray-class
   character, from Layer 1.8's decomposition into partial zetas and Layer 1.6's counting
   estimate with its error term. For a cyclotomic Frobenius character `𝔭 ↦ χ(Frob_𝔭)` of
   `Gal(K(ζ_m)/K)`, from the same counting estimate applied to the ray classes mod `m∞`,
   using Layer 8B.1's identification of the Frobenius with the norm residue. These are two
   theorems, one per family, and each is proved before its use. No family is claimed to have
   the property without such a proof.
4. **`L(χ, 1) ≠ 0` for a nontrivial `χ` with `HasCancellation`.** By the argument Mathlib
   already uses for Dirichlet characters (`Nonvanishing.lean`), generalized: the `3-4-1`
   product `L(1)³ L(χ)⁴ L(χ²)` when `χ² ≠ 1`, and for a real `χ` the positivity of the
   coefficients of `ζ_K(s) L(χ, s)` together with Landau's theorem from 1. Lang XV Thm 2
   proves exactly this for Hecke characters, with no class number formula and no class field
   theory.
5. **Nonvanishing on `Re s = 1`, in meromorphic-order form.** ⚠ This is where a pointwise
   statement goes wrong. The trivial character's L-function has a *pole* at `s = 1`, so
   "`L(χ, 1 + it) ≠ 0` for `χ` arbitrary" is comparing a junk value there. State instead, for
   the continued functions of Layer 1.7 and Layer 5.3:
   - `meromorphicOrderAt (dedekindZetaC K) 1 = −1`;
   - `meromorphicOrderAt (dedekindZetaC K) (1 + it) = 0` for `t ≠ 0`;
   - `meromorphicOrderAt L(χ, ·) (1 + it) = 0` for every `t` and every nontrivial
     finite-order `χ` with `HasCancellation`, which for such `χ` is holomorphic at `1` and so
     is equivalent to `L(χ, 1 + it) ≠ 0`;
   - equivalently and as a corollary: no member of the family has a zero on `Re s = 1`, the
     unique pole being the one recorded above.
   Route: the pattern of `LFunction_ne_zero_of_re_eq_one`, on the `3-4-1` inequality of 4.
   For a Grossencharacter, the twist `χ ‖·‖^{it}` reduces the general case to `t = 0`
   (Lang XV Thm 3), and the exceptional case is exactly the one Layer 6.4 classifies: `χ` a
   power of the norm character, where the pole reappears. "Arbitrary `χ`" is never written
   without that exclusion.
6. **Logarithmic derivatives.** The ideal von Mangoldt weight `Λ_K(𝔞)`, equal to `log 𝔑𝔭` when
   `𝔞 = 𝔭^m` and `0` otherwise; its norm-grouped coefficient function; and
   `−L'/L(χ, s) = LSeries (idealCoeffOfWeight (χ · Λ_K)) s` on `Re s > 1`, in the shape of
   Mathlib's `LSeries_twist_vonMangoldt_eq`. These are shared by Layers 8 and 9.
7. **The class-field-theoretic proof, as a corollary.** Once the global class field theory
   roadmap supplies reciprocity, `ζ_L = ζ_K ∏_{χ ≠ 1} L(χ, ·)` for `L/K` the class field, and
   4 follows from the order of the pole of `ζ_L` at `s = 1`. Prove it, as a consistency check
   on both roadmaps' normalizations; nothing else here uses it.

### Layer 8: prime densities and the Chebotarev density theorem

The main theorem of the roadmap. It is proved without class field theory, by the route of
Lenstra–Stevenhagen and Sharifi Thm 7.2.2, which is also the route of the two existing Lean
developments and of PrimeNumberTheoremAnd's blueprint (see [`PROVENANCE.md`](PROVENANCE.md) —
this is live work by other people, and the conversation with them comes before the code).

The Frobenius vocabulary is the number field arithmetic roadmap's: `frobeniusClass K L 𝔭` for
an unramified `𝔭`, its restriction and tower compatibility, and its unramified-prime
predicate. Underneath sit the pin's `arithFrobAt` and `isConj_arithFrobAt` over
`Algebra.IsInvariant`; a formulation over an abstract group acting faithfully on `𝓞 L` is a
generalization worth having, but the statements of 8D are over `Gal(L/K)` for number fields
`K ⊆ L`, because that is what every consumer wants and what tests the interface.

#### 8A: the density calculus

1. **The three densities**, as in the conventions table: `HasDirichletDensity` in the
   Mathlib #41765 spelling, `HasNaturalDensity`, and polar density. Also `HasUpperDirichletDensity`
   and `HasLowerDirichletDensity` as the `limsup` and `liminf` of the same ratio — the crossing
   argument produces a lower bound and nothing more, so these carry real weight.
2. **The denominator.** `primeIdealZetaSum univ s / log((s−1)⁻¹) → 1` as `s → 1⁺`, from
   Layer 1.7's simple pole and the logarithm of Layer 1.4. Hence the equivalence of the
   universe-denominator definition with Neukirch's logarithmic one — one theorem, proved once,
   after which no statement mentions `log((s−1)⁻¹)` again.
3. **The calculus**: `HasUpperDirichletDensity S δ ∧ HasLowerDirichletDensity S δ →
   HasDirichletDensity S δ`; monotonicity of upper and lower density; a finite set has density
   `0`; a finite symmetric difference does not change any of the three; a finite disjoint union
   adds densities; the complement has density `1 − δ`. Removing the (finitely many) ramified
   primes therefore changes nothing, which is the lemma every statement of 8D silently needs.
4. **Degree-one reduction.** The primes with `𝔑𝔭` not prime have Dirichlet density `0`
   (Milne VI 3.2); so does any set on which the residue degree exceeds `1`. Consequently a
   density may always be computed over degree-one primes.
5. **Transfer under contraction.** For `E/K` finite and `S` a set of primes of `E`, the
   relation between the density of `S` and of its contraction `{𝔭 ∣ ∃ 𝔓 ∈ S, 𝔓 ∩ 𝓞_K = 𝔭}`,
   with the fibre count appearing explicitly. Stated in the exact form 8D uses: if every
   `𝔭` in the target set has exactly `k` primes of `E` above it lying in `S`, and those primes
   have residue degree `1` over `K`, then `d(S) = k · d(target)`. This is the lemma that turns
   a cyclic density into a conjugacy-class density, and it is the single place where the
   `𝔓`-versus-`𝔭` bookkeeping lives.
6. **The carrier.** The equivalence between `HeightOneSpectrum (𝓞 K)` and nonzero prime
   ideals of `𝓞 K`, and transport of all of the above along it. Public statements use
   `HeightOneSpectrum`; this is the one lemma that lets a proof work with ideals.
7. **Comparisons between the notions.** Natural density implies Dirichlet density with the
   same value, by Abel summation on the pin's `AbelSummation.lean`; polar density implies
   Dirichlet density with the same value (Milne VI 4.1(a)). ⚠ Neither converse holds, and the
   standard counterexample to the first is stated. Every theorem in this roadmap names its
   density; "density" unqualified appears in no Lean statement.
8. **Density-free consequences of the calculus**: the splitting-density theorem — the primes
   of `K` splitting completely in a finite `L` have polar density `1/[M:K]` with `M` the
   Galois closure (Milne VI 3.4; the `n`-th root trick is exactly what polar density is for) —
   and `δ = 1/[L:K]` iff `L/K` is Galois; Bauer's theorem, `Spl(L) ⊆ Spl(M) ↔ M ⊆ L` for
   Galois `M`, and the resulting rigidity, that a Galois extension is determined by its split
   primes (Neukirch (13.10)); and the Frobenius density theorem, that the division of `σ` has
   density `t/#G` where `t` is the number of elements of that division (Janusz IV 5.2, by
   induction on the order of `σ`), with its corollary that the Artin map is surjective onto
   `Gal(L/K)` for abelian `L/K` (Janusz IV 5.3, Milne VI 3.8). None of these needs Layer 7.

#### 8B: the cyclotomic case

1. **The cyclotomic Frobenius formula.** For `m` with `𝔭 ∤ m`, the Frobenius of `𝔭` in
   `K(ζ_m)/K` sends `ζ_m ↦ ζ_m^{𝔑𝔭}`. ⚠ Arithmetic, not geometric: an inverse here proves the
   theorem for `C⁻¹` and nothing detects it until a numerical example. Over `K = ℚ` this is
   the pin's `IsCyclotomicExtension.Rat.galEquivZMod_stabilizer`; over general `K` it is a
   milestone, stated through the number field arithmetic roadmap's `frobeniusClass`.
2. **Character orthogonality** on `Gal(K(ζ_m)/K)`: for `σ` in that group,
   `#G⁻¹ ∑_χ conj (χ σ) χ(τ) = if σ = τ then 1 else 0`, over the character group of a finite
   abelian group. Mathlib has the pieces; the milestone is the form used in 4.
3. **The logarithmic comparison.** For `χ` a character of `Gal(K(ζ_m)/K)`, regarded as an
   ideal weight through 1, `log L(χ, s) = ∑_{𝔭 ∤ m} χ(Frob_𝔭) 𝔑𝔭^{-s} + O(1)` as `s → 1⁺`,
   the error term being the prime powers with `m ≥ 2`, which converge. State the error bound
   as a theorem, not as "standard".
4. **Nonvanishing for the cyclotomic characters**: `L(χ, 1) ≠ 0` for `χ ≠ 1`, by Layer 7.4
   with the premise supplied by Layer 7.3. Together with 2 and 3 this gives, for each
   `σ ∈ Gal(K(ζ_m)/K)`, that `{𝔭 ∤ m ∣ Frob_𝔭 = σ}` has Dirichlet density
   `1/[K(ζ_m):K]`.
5. **Dirichlet's theorem with a density**, as the `K = ℚ` case: the primes `p ≡ a (mod q)`
   have Dirichlet density `1/φ(q)`, from which Mathlib's `Nat.infinite_setOf_prime_and_eq_mod`
   follows. That the pin's theorem becomes a corollary is an acceptance criterion.

#### 8C: the abelian case, by crossing with cyclotomic extensions

Given `L/K` abelian with group `G` and `σ ∈ G` of order `f`, the density of
`{𝔭 ∣ Frob_𝔭 = σ}` is obtained by comparing `L` with an auxiliary cyclotomic extension.
Every object below is a milestone; none of them is "the crossing lemma".

1. **Admissible auxiliary moduli.** The predicate on `m` collecting what the argument needs:
   `m` is coprime to the primes ramifying in `L`, `L ∩ K(ζ_m) = K`, and `f ∣ [K(ζ_m):K]`.
   Prove that admissible `m` exist, and that they can be taken with `[K(ζ_m):K]` divisible by
   any prescribed integer.
2. **Linear disjointness and the product decomposition.** For admissible `m`, the restriction
   map `Gal(L·K(ζ_m)/K) → Gal(L/K) × Gal(K(ζ_m)/K)` is an isomorphism. This is where
   `L ∩ K(ζ_m) = K` is used, and it is a theorem about the compositum, stated as such.
3. **Compatibility of Frobenius with restriction.** For `𝔭` unramified in the compositum, the
   Frobenius of `𝔭` in `L·K(ζ_m)/K` maps to the pair of its Frobenius elements in `L/K` and in
   `K(ζ_m)/K`. Consumed from the number field arithmetic roadmap's tower compatibility, or
   proved here if it is not there yet; either way it is named.
4. **The fixed field is cyclotomic over its base.** Let `τ ∈ Gal(K(ζ_m)/K)` with
   `f ∣ orderOf τ`, write `M = L·K(ζ_m)`, and let `E = M^{⟨(σ,τ)⟩}` under the identification
   of 2. Then `⟨(σ,τ)⟩ ∩ Gal(M/K(ζ_m)) = 1` — this is exactly where `f ∣ orderOf τ` is used —
   so `E·K(ζ_m) = M`, and `M/E` is generated by roots of unity. Hence 8B applies over `E`.
   This is what the name "crossing" refers to, and it is what lets a cyclotomic density be
   pushed down to `L`.
5. **The tagged family of Frobenius fibres.** For each `τ ∈ Gal(K(ζ_m)/K)` whose order is
   divisible by `f`, the set `S_τ = {𝔭 ∣ Frob_𝔭 = (σ, τ)}` in the compositum; these are
   pairwise disjoint as `τ` varies, and each contracts into `{𝔭 ∣ Frob_𝔭 = σ}` in `L/K`.
   Disjointness is what makes the densities add, so it is a stated lemma. The divisibility
   condition on the order of `τ` is what 4 needs, and `κ_m` in 6 is the proportion of `τ`
   satisfying it.
6. **The lower bound.** Summing the densities of the `S_τ` obtained from 4 and 8B gives
   `HasLowerDirichletDensity {𝔭 ∣ Frob_𝔭 = σ} (κ_m / #G)` for an explicit `κ_m ≤ 1`. Only a
   lower bound comes out, which is why 8A.1 has `liminf`.
7. **The proportion tends to one.** `κ_m → 1` as `m` runs through admissible moduli with
   `[K(ζ_m):K]` divisible by higher and higher powers: the proportion of `τ` whose order is
   divisible by a prescribed integer tends to `1`. State the limit and prove it; it is a
   statement about `(ℤ/m)ˣ` and nothing else.
8. **The abelian theorem.** `HasDirichletDensity {𝔭 ∣ Frob_𝔭 = σ} (1/#G)` for `L/K` abelian,
   from 6, 7, and the fact that the densities over all `σ ∈ G` sum to `1` (so a family of
   lower bounds summing to `1` forces equality).

#### 8D: the general case, by fixed fields

Let `L/K` be finite Galois with group `G`, let `σ ∈ G` have order `f`, let `C` be its
conjugacy class, and let `E = L^{⟨σ⟩}`.

1. **`L/E` is cyclic**, of degree `f`, with group `⟨σ⟩`.
2. **Frobenius in `L/K` versus `L/E`.** For a prime `𝔓` of `E` unramified in `L`, its
   Frobenius in `L/E` is `σ` exactly when the Frobenius of `𝔓 ∩ 𝓞_K` in `L/K` lies in `C`
   *and* a stated compatibility holds; state the exact relation and prove it, with the
   restriction compatibility of the number field arithmetic roadmap.
3. **The relevant primes of `E`.** The set to which 8C is applied is
   `{𝔓 ∣ 𝔓 unramified in L, Frob_{L/E}(𝔓) = σ}`, and 8A.4 lets it be intersected with the
   degree-one primes of `E` over `K` at no cost. Say which subset is meant, once.
4. **The fibre count.** Each `𝔭` of `K` with `frobeniusClass K L 𝔭 = C` has exactly
   `#G/(#C · f)` primes of `E` in the set of 3, all of residue degree `1` over `K`; and every
   prime of `E` in that set lies over such a `𝔭`. Milne CFT VIII 7.4's explicit bijections are
   the blueprint. ⚠ This is where conjugacy class against element, `𝔓` against `𝔭`, and
   degree-one-over-`K` all meet; it is the one computation of the layer that has to be done
   slowly.
5. **The conclusion.** Apply 8C over `E` to get density `1/f` for the set of 3, then 8A.5 with
   `k = #G/(#C · f)` to get
   `HasDirichletDensity {𝔭 ∣ 𝔭 unramified in L ∧ frobeniusClass K L 𝔭 = C} (#C/#G)`.
   Stated over an arbitrary number field `K`, not only over `ℚ`.
6. **Corollaries, re-derived from 5** rather than proved twice: exact-density forms of every
   statement in 8A.8, the density of the primes splitting completely in `L` (`1/#G`), and the
   splitting densities in a non-Galois extension through its Galois closure.

#### 8E: equidistribution in ray classes, and the consistency check

Once the global class field theory roadmap supplies ray class groups: the primes are
Dirichlet-equidistributed among the classes of any `J^𝔪 ⊇ H ⊇ P^𝔪`, with density
`1/[J^𝔪 : H]` (Neukirch (13.2); Milne VI 4.8 and VIII 7.2). Prove it **twice** — once
analytically, from Layer 1.8's partial zetas and Layer 7.4, and once from 8D together with
Artin reciprocity — and prove that the two agree class by class. That agreement is the check
that this roadmap's arithmetic-Frobenius convention and that roadmap's reciprocity
normalization point the same way; it is the only place the two can be caught disagreeing.

### Layer 9: the prime ideal theorem and natural densities

Layer 8 gives Dirichlet densities. A Dirichlet density does not imply a natural density, so
the natural-density form of Chebotarev is a separate theorem with its own proof, and this
layer supplies that proof rather than asserting the upgrade.

1. **The Tauberian input, stated exactly.** Wiener–Ikehara: if `a : ℕ → ℝ` is nonnegative, the
   Dirichlet series `F(s) = ∑ a n · n^{-s}` converges on `Re s > 1`, and
   `s ↦ F(s) − κ/(s − 1)` extends continuously to `Re s ≥ 1`, then
   `∑_{n ≤ x} a n ∼ κ x`. This is `WienerIkeharaTheorem'` in PrimeNumberTheoremAnd, proved
   sorry-free there and absent from Mathlib. It is a milestone of this layer: either that
   proof is integrated with its authors' agreement, or the theorem is proved here in the same
   shape, so that later replacing one with the other is an import. The hypotheses above are
   what the rest of the layer may assume, and nothing weaker.
2. **The ideal von Mangoldt series.** Layer 7.6's `Λ_K`, and
   `−ζ_K'/ζ_K (s) = LSeries (idealCoeffOfWeight Λ_K) s` on `Re s > 1`.
3. **`ψ_K(x) ∼ x`**, where `ψ_K(x) = ∑_{𝔑𝔞 ≤ x} Λ_K(𝔞)`: apply 1 to 2, with `κ = 1`, the
   continuous extension to `Re s ≥ 1` coming from Layer 7.5 (the pole of `ζ_K` at `1` supplies
   `κ/(s−1)`, and the absence of zeros on `Re s = 1` is exactly what makes `−ζ_K'/ζ_K` minus
   that term continuous up to the line).
4. **`θ_K(x) ∼ x`**, where `θ_K(x) = ∑_{𝔑𝔭 ≤ x} log 𝔑𝔭`: the difference `ψ_K − θ_K` is the
   contribution of the prime powers `𝔭^m` with `m ≥ 2`, which is `O(√x log² x)`. Prove the
   bound; do not call it standard.
5. **Residue degree greater than one contributes nothing.** The primes with `𝔑𝔭 = p^f`,
   `f ≥ 2`, contribute `O(√x log x)` to `θ_K`, so `θ_K` is asymptotically the sum over
   degree-one primes. This is the counting analogue of 8A.4.
6. **The prime ideal theorem.** `π_K(x) ∼ x/log x`, from 4 by partial summation
   (`AbelSummation.lean`). At `K = ℚ` this is the prime number theorem, and the milestone
   there is an **agreement theorem** with PrimeNumberTheoremAnd's `pi_asymp`, not a second
   proof of it. Nothing in this roadmap reproves the rational prime number theorem.
7. **Tauberian asymptotics for the cyclotomic characters.** For `χ` a nontrivial character of
   `Gal(K(ζ_m)/K)` regarded as an ideal weight, `∑_{𝔑𝔞 ≤ x} χ(𝔞) Λ_K(𝔞) = o(x)`, by applying 1
   to `−L'/L(χ, ·)` with `κ = 0`, whose continuous extension to `Re s ≥ 1` is Layer 7.5 for
   `χ`. This is the quantitative form of 8B, and it is what the natural-density argument runs
   on; the Dirichlet-density statement of 8B is not enough.
8. **Counting in a cyclotomic Frobenius fibre.** From 7 and orthogonality (8B.2), for each
   `σ ∈ Gal(K(ζ_m)/K)`, `#{𝔭 ∣ 𝔑𝔭 ≤ x, Frob_𝔭 = σ} ∼ (1/[K(ζ_m):K]) · x/log x`.
9. **Natural-density Chebotarev.** Repeat 8C and 8D with 8 in place of 8B, that is with
   counting asymptotics rather than lower bounds on Dirichlet densities: the tagged families
   of 8C.5 give an asymptotic count for the abelian case, and the fibre count of 8D.4 is a
   finite multiplication which transports it. The result is
   `π_C(x) ∼ (#C/#G) · x/log x`, and `HasNaturalDensity {𝔭 ∣ frobeniusClass K L 𝔭 = C} (#C/#G)`.
   ⚠ This is not a formal consequence of Layer 8; the two arguments share a skeleton and
   differ in what is transported through it, and the roadmap asks for both because neither
   implies the other.
10. **Natural-density ray-class equidistribution**, the same upgrade applied to 8E.
11. **Mertens for `K`**: `∑_{𝔑𝔭 ≤ x} 𝔑𝔭^{-1} = log log x + M_K + o(1)`, and the product form,
    as supporting API. Mathlib's Mertens work over `ℚ` is the model for the statement shapes.

## Worked examples (acceptance criteria)

Discharge these alongside the layers, not at the end. Each is here because it catches a
particular class of error that the general statements do not.

- **`dedekindZeta ℚ` against `riemannZeta`** (Layers 1, 3). On `Re s > 1` they agree, by the
  bijection between nonzero ideals of `ℤ` and positive integers; the *continued*
  `dedekindZetaC ℚ = riemannZeta` everywhere. Catches junk-value abuse and the `n = 0`
  off-by-one in the coefficient function.
- **`ζ_{ℚ(i)} = ζ · L(χ₋₄)`** (Layers 1, 4, then 3). First as the coefficient identity
  `#{I ∣ 𝔑I = n} = ∑_{e ∣ n} χ₋₄(e)`, then as an identity of continued functions. Catches the
  Euler factor at the ramified prime `2` — it is `(1 − 2^{-s})⁻¹` on both sides — and the
  primitivity bookkeeping.
- **The class number formula at `ℚ(√−5)`** (Layers 1, 4). `h = 2`, `w = 2`, `|D| = 20`, so
  `Res_{s=1} ζ_{ℚ(√−5)} = π/√5` and equivalently `L(1, χ₋₂₀) = π/√5`, with the class number
  coming from the multiquadratic roadmap. Catches every constant at once: `2^{r₁}(2π)^{r₂}`,
  `w`, and `√|d|`.
- **Root numbers at `χ₋₄`** (Layer 0). `‖rootNumber χ‖ = 1` proved, and checked at `χ₋₄`,
  where `τ(χ₋₄) = 2i` and `ε = τ/(i√4) = 1`. Catches the archimedean factor
  `I^{if Even then 0 else 1}` and the conductor-power convention.
- **The Δ card, and the direction of the normalization shift** (Layer 0.4, 0.7). The weight-12
  cusp form has arithmetic centre `6` and analytic centre `1/2`; the analytic card has degree
  `2`, conductor `1`, `gammaC = {11/2}`, `ε = 1`, and coefficients `τ(n)/n^{11/2}`. Verify
  that the translation of 0.4 carries the modular forms roadmap's object to this card, that
  the gamma parameters shift in the declared direction, and that degree, conductor, root
  number, and zero multiplicities are unchanged. This is the only instance where a wrong sign
  in the translation is visible, which is why it is an acceptance criterion.
- **The Dirichlet card as a degenerate translation** (Layer 0.4). At `w = 0` every field of
  the translation structure must reduce to `rfl`. Catches a translation defined with the
  shift in the wrong place, which would still typecheck.
- **The two Dirichlet densities agree** (Layer 8A.2). For the mod-5 cyclotomic fibre, the
  universe-denominator density of the public predicate and the `log((s−1)⁻¹)`-denominator
  density of Neukirch's definition are both `1/4`, by the denominator theorem rather than by
  proving the density twice. Catches a second, competing density predicate.
- **Ramified primes do not matter** (Layer 8A.3). Removing the finitely many primes ramifying
  in `L` from a set does not change its Dirichlet density. Catches statements whose
  unramifiedness hypothesis is doing silent work.
- **Chebotarev at `ℚ(ζ₅)/ℚ`** (Layers 8B, 8D). `G ≅ (ℤ/5)ˣ`, every class is a singleton, so
  the primes `p ≡ a (mod 5)` have Dirichlet density `1/4`, and Mathlib's
  `Nat.infinite_setOf_prime_and_eq_mod` follows. Check that the arithmetic Frobenius sends
  `ζ₅ ↦ ζ₅^p` and so produces the class of `p mod 5` and not its inverse — the single most
  consequential sign in the roadmap. Then check that the general theorem of 8D, specialized
  through the number field arithmetic roadmap's `frobeniusClass`, gives back this statement:
  a general theorem that does not visibly specialize is not the right general theorem.
- **Natural density at `ℚ(ζ₅)/ℚ`** (Layer 9.9). The same fibre has natural density `1/4`,
  obtained through the counting asymptotic of 9.8 and not by converting one density notion
  into another. Catches exactly the gap this roadmap is at risk of hiding.
- **The prime ideal theorem at `K = ℚ`** (Layer 9.6). The specialization is
  PrimeNumberTheoremAnd's `pi_asymp`, as an agreement theorem. Catches an accidental second
  proof of the prime number theorem.
- **Nonvanishing does not overreach at the pole** (Layer 7.5). The trivial character at
  `s = 1` has meromorphic order `−1`, a nontrivial quadratic character has order `0` there,
  and `ζ_K` has order `0` at `1 + it` for `t ≠ 0`. Verify that no statement in the layer
  compares a representative's value at a pole.
- **Hecke's equidistribution of Gaussian primes** (Layer 6.6). The arguments of the primes of
  `ℤ[i]` are equidistributed in `[0, π/2)`. Catches an infinity-type interface that typechecks
  but cannot be instantiated.
- **No elliptic-curve card** (Layer 0.7). Verify that no continuation or functional-equation
  predicate is asserted for `WeierstrassCurve.LSeries`. This is a scope check, and it stays
  until some roadmap proves classical modularity.

## Ordering — the dependency graph

Inside the roadmap:

```
  0 data model ──▶ 1 ideal series ─┬─▶ 2 Poisson/theta ──▶ 3 Dedekind ζ ─┬─▶ 4 special values
                                   │                                     │
                                   │                                     └─▶ 5 Hecke L ──▶ 6 Grossencharacters
                                   │
                                   └─▶ 7 nonvanishing ──▶ 8 densities ──▶ 9 prime counting
```

Across roadmaps:

```
  Local fields ─────────────────────▶ 1   (Frobenius and Euler-factor conventions)
  Modular forms, Layer 7 ───────────▶ 0   (the newform row of the instance ledger)
  Integral lattices, Layer 1 ───────▶ 2   (dual-lattice vocabulary)
  Global class field theory ────────▶ 5, 6, 8E   (characters; nothing else)
  Number field arithmetic ──────────▶ 8D, 8E   (frobeniusClass and its compatibilities)
  PrimeNumberTheoremAnd ────────────▶ 9   (Wiener–Ikehara, and the K = ℚ check)

  2 ────────────────────────────────▶ Integral lattices, Layer 8
  3, 5, 7 ──────────────────────────▶ the zeros roadmap
```

Layers 0 and 1 come first; 1 needs 0 only for where the Euler-factor data lives, so they can
be built at the same time. After that the roadmap is three independent pieces:

- **Functional equation**: 2 → 3 → 5 → 6. Layer 2 also supplies the integral lattices
  roadmap, and Layers 5 and 6 take their characters from the global class field theory
  roadmap. Only the *definitions* of that roadmap are needed, not its reciprocity or
  existence theorems, which appear nowhere on this roadmap's critical path.
- **Densities**: 7 → 8, needing only Layer 1's continuation into the strip and its residue.
  Every milestone of Layer 8 except 8E is independent of the global class field theory
  roadmap, and 8D consumes the number field arithmetic roadmap's Frobenius API.
- **Special values**: 4, needing Layer 1 and Mathlib's Dirichlet theory, and Layer 3 for the
  statements about continued functions.

Layer 9 needs 7 and 8. The zeros roadmap starts where Layer 9 ends, and needs 3, 5, and 7 of
this one.

Before writing Layer 5, agree the character interface with the global class field theory
roadmap; before Layer 8, talk to the people working on Chebotarev in Lean; before Layer 9,
talk to PrimeNumberTheoremAnd. Who they are and what they have is in
[`PROVENANCE.md`](PROVENANCE.md).

## References

- J. Neukirch, *Algebraic Number Theory* (Springer 1999) — the primary source for Layers 2–6:
  ch. VII §1–2 (ζ, Dirichlet L as warm-up), §3–4 (theta transformation (3.6),
  higher-dimensional Gamma), §5 (Dedekind zeta: (5.9) partial FE with the `[𝔡]`-twist,
  (5.10) completed FE, (5.11) continuation/residue/asymmetric FE, (5.12) cyclotomic
  factorization), §6 (Grossencharacters: (6.7) infinity types, (6.9) Dirichlet =
  type-`(p,0)`, (6.11)–(6.14) idele dictionary), §7 (Hecke theta: Gauss sums (7.5),
  transformation (7.7)), §8 (Hecke L: Euler product (8.1), **FE (8.5)/(8.6)** with
  `W(χ)`), §13 (densities: (13.1) Dirichlet density, (13.2) ray-class density, (13.3)
  nonvanishing via CFT, **(13.4) Chebotarev** with Deuring reduction, (13.5)–(13.10)
  corollaries).
- S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110 — the source for the choice of proof
  in Layers 2–3, and for Layers 7–9: ch. VI §3 (ideal counting `ρt + O(t^{1−1/N})`, Thm 3), ch.
  VIII §§1–4 (Dirichlet-series lemmas, strip continuation, densities, Thm 10 = Chebotarev
  via Deuring), ch. XIII (**Hecke's FE proof**: Poisson §1, theta relation §2, FE +
  residues Thms 1–3; Lang's `Γ(s/2)^{r₁}Γ(s)^{r₂}` normalization differs from ours by
  `2^{r₂}`), ch. XIV (Tate's thesis, out of scope here; its Cor. 3 is the theorem that the
  two proofs give the same completed function), ch. XV (**Ikehara** §2, Tauberian for Dirichlet series §3,
  **analytic nonvanishing** Thm 2 (`3-4-1` + Landau, no CFT), `Re = 1` Thm 3, natural
  densities + prime ideal theorem Thm 4, equidistribution Thms 5–6).
- G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7 — the elementary treatment: IV §1–2
  (ray classes; ideal counting 2.11/2.13, strip continuation 2.14), IV §4 (L-series,
  density dichotomy 4.8, converse device 4.9), IV §5 (**Frobenius density theorem 5.2**,
  Artin-map surjectivity 5.3, first inequality 5.6, `L(1,χ) ≠ 0` over ℚ without class field
  theory 5.7),
  V §10 (nonvanishing from class field theory 10.2, ray-class density 10.3, Chebotarev 10.4).
- J. S. Milne, *Class Field Theory* (v4.03, course notes) — the Chebotarev formalization
  blueprint: VI §2 (partial zetas 2.8 — statement, proof cited to Lang — strip 2.9–2.12),
  VI §3 (**polar density**, splitting-density Thm 3.4, Bauer 3.6, Artin surjectivity 3.8),
  VI §4 (Dirichlet density 4.1–4.8, second inequality 4.9), V 3.23–3.26 (statement +
  natural-density remark), and **VIII §7 (7.1–7.4: the fibre-counted Chebotarev proof, which
  is what Layer 8D formalizes)**.
- D. Loeffler, M. Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959 —
  the design rationale of the pin's `LSeries/` stack; Layer 2–3 continue it.
- D. A. Marcus, *Number Fields* (2nd ed., Springer 2018) — the reference Mathlib's own class
  number formula cites (ch. 7, which is Layer 1.6's counting), and the polar-density source
  Milne follows.
- H. W. Lenstra, Jr., P. Stevenhagen, "Chebotarëv and his density theorem", Math.
  Intelligencer 18 (1996), 26–37 (free on the authors' pages) — the source for the crossing
  argument of Layer 8C; and R. Sharifi, *Algebraic Number Theory*
  (course notes, free online), Thm 7.2.2, which the existing Lean developments follow.
- H. Iwaniec, E. Kowalski, *Analytic Number Theory*, AMS Colloq. 53 — ch. 5 is the source of
  record for Layer 0: degree, conductor, gamma factor, root number, and the axioms as a
  family of separate conditions.
- L. C. Washington, *Introduction to Cyclotomic Fields* — the source Mathlib's cyclotomic
  Galois theory follows, and the reference for Layer 4.5's generalized Bernoulli numbers.
- W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers* — the functional
  equation as Milne cites it, and a cross-check on Layer 5's constants.

