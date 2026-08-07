# Roadmap: L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems

Mathlib has a large L-series library. The project pin is `9caeba1000` (2026-06-03), and
`Mathlib/NumberTheory/LSeries/` there is 21 files and about 6900 lines. The authors are
David Loeffler and Michael Stoll, with Xavier Roblot, Chris Birkbeck, and Huanyu Zheng; the
design paper is Loeffler–Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959.
That library contains:

- the L-series `LSeries f s = ∑' n, f n / n ^ s`, with the abscissa of absolute convergence
  `LSeries.abscissaOfAbsConv`, linearity, Dirichlet convolution `⍟`, derivatives, coefficient
  injectivity, and positivity;
- the abstract Mellin-transform functional equation `WeakFEPair` and `IsStrongFEPair` in
  `LSeries/AbstractFuncEq.lean`, with `Λ (k − s) = ε • Λ^∨ s`, entirety, and residues;
- the completed Riemann zeta function, its functional equation
  `completedRiemannZeta_one_sub`, its values, and its trivial zeros;
- the even and odd Hurwitz zeta theory in full;
- L-functions of functions on `ZMod N` and of Dirichlet characters, with continuation, gamma
  factors, the Gauss-sum root number, and
  `DirichletCharacter.IsPrimitive.completedLFunction_one_sub`;
- nonvanishing on `Re s ≥ 1`, as `DirichletCharacter.LFunction_ne_zero_of_one_le_re` and
  `riemannZeta_ne_zero_of_one_le_re`;
- Dirichlet's theorem on primes in an arithmetic progression,
  `Nat.infinite_setOf_prime_and_eq_mod`;
- discreteness of the zeros of zeta, `isDiscrete_riemannZetaZeros`.

Adjacent files supply more. `Gamma/Deligne.lean` has the archimedean factors `Gammaℝ` and
`Gammaℂ` with the duplication formula, and its docstring names the Dedekind zeta function as
the intended consumer. `Mathlib/NumberTheory/EulerProduct/` has the abstract Euler product.
`Mathlib/RingTheory/Frobenius.lean` has `IsArithFrobAt` and `arithFrobAt` with well-defined
conjugacy classes. Roblot's `NumberField.dedekindZeta` has the Dirichlet class number formula
`tendsto_sub_one_mul_dedekindZeta_nhdsGT`. That formula rests on his ideal-counting
asymptotics and on his fundamental domain for the unit action.

The subject of the LMFDB's L-function section is nevertheless almost absent. The following
statements hold at the pin, and also on Mathlib master on 2026-08-07 unless marked otherwise:

- No structure carries a degree, a conductor, gamma data, or a root number, and no theorem
  relates them. Even `‖rootNumber χ‖ = 1` is unproved for Dirichlet characters.
- `dedekindZeta` has no Euler product, no continuation past `Re s > 1`, and no functional
  equation. Its file asks in a TODO for a general construction.
- There are no Hecke characters and no Hecke L-functions. `Grossencharacter` has no match.
- There is no Landau theorem, no Tauberian theorem, no prime number theorem, and no Mertens
  theorem.
- There is no Chebotarev density theorem. Master gained
  `Mathlib/NumberTheory/NumberField/DirichletDensity.lean` after the pin; that file has the
  density predicate only, and no density theorem.
- Modular forms have no L-series connection, and `WeierstrassCurve.LFunction` is a formal
  Dirichlet series with no theorems and no conductor.

This roadmap builds that material. It has ten layers:

0. the L-function data model and the instance ledger;
1. ideal-indexed series, Euler products, and continuation into a strip;
2. lattice Poisson summation, theta transformations, and a functional equation with a level;
3. continuation and the functional equation of the Dedekind zeta function, by Hecke's method;
4. special values and the class number formula;
5. Hecke L-functions of finite-order ray-class characters;
6. Grossencharacters;
7. Landau's theorem and nonvanishing;
8. prime densities and the Chebotarev density theorem;
9. the prime ideal theorem and natural densities.

Suggested home: `TauCeti/NumberTheory/LFunctions/`, with one directory per layer
(`DataModel/`, `IdealSeries/`, `Theta/`, `DedekindZeta/`, `SpecialValues/`, `HeckeL/`,
`Grossencharacter/`, `Nonvanishing/`, `Density/`, `PrimeCounting/`). The Dedekind zeta files
use the namespace `NumberField`. That matches
`Mathlib/NumberTheory/NumberField/DedekindZeta.lean`, whose TODO they discharge.

## Scope

### In scope

Every numbered milestone of *The build, in layers*. Nothing there is conditional. In one
sentence: the analytic theory of the L-functions of a number field, proved for a general
number field `K`, and recovering the classical object at `K = ℚ` in every case.

### Out of scope

- **The zeros program.** Zero-free regions, zero counting, the Riemann–von Mangoldt formula,
  the explicit formula, and certified lists of zeros are not proved here. They need a theory
  of growth that this roadmap does not build. The separate roadmap
  `TauCetiRoadmap/LFunctionZeros/README.md` owns them. It consumes the completed instances
  built here; *Interfaces supplied to other roadmaps* below states what it gets.
- **Tate's thesis.** Adelic Fourier analysis, self-dual measures, Schwartz–Bruhat functions,
  local zeta integrals, and local epsilon factors are not built here. Layer 3 proves the
  functional equation by Hecke's method, and a second derivation is not wanted. The
  factorization `W(χ) = ∏_v W_v(χ)` belongs with those epsilon factors, so it is also out of
  scope.
- **Artin L-functions and Brauer induction.** Layers 5 and 6 are built at the generality that
  Brauer induction needs. No Artin instance and no induction theorem is built here.
- **Compact-group equidistribution.** Layer 7.5 proves the nonvanishing that an
  equidistribution argument needs, and Layer 6.6 proves Hecke's equidistribution of the
  arguments of Gaussian primes. The Weyl criterion for a general compact group is not proved
  here.
- **Effective constants and error terms.** No density statement and no counting statement here
  carries an error term. Effective Chebotarev is not in scope.
- **Elliptic-curve L-functions.** No continuation and no functional equation is asserted for
  `WeierstrassCurve.LSeries`. Layer 0.7 states why.

### Interfaces supplied to other roadmaps

Each item is a theorem of a numbered layer here. Another roadmap consumes it and does not
rebuild it.

- **Poisson summation for a general `ZLattice`, and the Gaussian theta transformation**
  (Layers 2.1 to 2.8). For a `ZLattice L` in a finite-dimensional real inner-product space
  and Schwartz `f`, the statement is
  `∑_{v ∈ L} f v = (ZLattice.covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w`, where `Lᵛ` is `ZLattice.dual`. The
  shared table below fixes every name that crosses to that roadmap.
- **The completed Dedekind zeta function, its polar divisor, and its functional equation**
  (Layer 3), and **completed Hecke L-functions with `‖W(χ)‖ = 1`** (Layers 5 and 6).
- **Nonvanishing on `Re s = 1` in meromorphic-order form** (Layer 7.5), with the `3-4-1`
  inequality it rests on (Layer 7.4).
- **The Dirichlet-density calculus** (Layer 8A) and **Chebotarev over a general number field**
  (Layer 8D).
- **Landau's theorem** (Layer 7.1).
- **Wiener–Ikehara** (Layer 9.1).

## How prerequisites are recorded

Every milestone below states its direct prerequisites. Each prerequisite is in exactly one of
four categories:

- **Mathlib** — a named declaration that exists in Mathlib. The pin is `9caeba1000`. Where a
  declaration exists only on master, the milestone says so and builds it here in the master
  shape.
- **Tau Ceti** — a named declaration that already exists in Tau Ceti.
- **Layer n.m** — an earlier milestone of this roadmap.
- **Roadmap X, Layer k** — a named layer of another roadmap.

No other category is permitted. In particular no milestone depends on a branch, an open pull
request, a future pin, an external repository, or a roadmap that does not yet exist.

Two consequences follow.

First, where a sibling roadmap has not fixed the names this roadmap needs, this roadmap
defines a **compatibility interface** and makes it one of its own milestones. Layers 5.1,
6.1, and 8.0 are the three such interfaces. Each is a small structure with the operations the
later layers use. When the sibling roadmap's declaration exists, the replacement is
mechanical: delete the interface, import the sibling declaration, and keep every later
statement unchanged. Each compatibility interface says which roadmap and layer will own it.

Second, Wiener–Ikehara is a milestone of Layer 9 and not an import. It is proved in
PrimeNumberTheoremAnd. That project is neither Mathlib nor Tau Ceti, so it cannot be a
prerequisite. [`PROVENANCE.md`](PROVENANCE.md) records that work as prior art, and states the
coordination obligation.

## Dependencies

| Supplier | Material consumed here | First consuming layer | Category |
|---|---|---:|---|
| [Local fields](https://github.com/roed-math/TauCetiRoadmap/pull/2), Layer 2 | the arithmetic-Frobenius convention, and the convention for the Euler factor at a ramified prime | 1.5 | Roadmap, convention only |
| [Global class field theory](https://github.com/roed-math/TauCetiRoadmap/pull/6), Layers 0 to 3 | ray class groups, finite-order Hecke characters, the conductor with its finite part and its infinite part, and the unitary decomposition | 5.1 | Roadmap, through the compatibility interface of Layer 5.1 |
| Global class field theory, its infinity-type layer | infinity types and algebraic Grossencharacters | 6.1 | Roadmap, through the compatibility interface of Layer 6.1 |
| [Number field arithmetic](https://github.com/roed-math/TauCetiRoadmap/pull/9), Layers 2 and 5 | the Frobenius class of an unramified prime, and its behaviour under restriction in a tower | 8.0 | Roadmap, through the compatibility interface of Layer 8.0 |
| [Integral lattices](https://github.com/roed-math/TauCetiRoadmap/pull/7), Layers 1B and 8D | the dual lattice of an integral bilinear form, as `IntegralLattice.dual`, and its comparison `IntegralLattice.analyticDual_eq_dual` | 2.10 | Roadmap |
| [Modular forms](../ModularForms/README.md), Layer 7 | the newform L-series, its Euler product, its completion, its functional equation, and its analytic conductor | 0.7 | Roadmap |

Nothing else is a prerequisite. Three remarks on the table.

The local fields row is a convention and not a declaration. This roadmap states the same
conventions in *Pinned conventions*, and the two must agree. No milestone here fails to
typecheck if that roadmap does not exist.

The rows for global class field theory and for number field arithmetic are routed through the
compatibility interfaces of Layers 5.1, 6.1, and 8.0. Those interfaces are milestones of this
roadmap, so no milestone here is blocked.

The roadmap does not depend on class field theory for Chebotarev. Layer 8 uses cyclotomic
extensions, and every milestone of Layer 8 except 8E is independent of the global class field
theory roadmap. The roadmap does not depend on Galois cohomology at all.

### Shared layer-DAG table: Integral Lattices ↔ L-functions

The two roadmaps consume each other at different layers. This table is the whole
interface, and it is byte-identical in both `README.md` files. Nothing crosses between the
two roadmaps except through a row of this table. The supplier owns each name, and the
consumer cites the name instead of restating the object.

| Consumer layer | Supplier layer | Exact object or theorem | Agreed provisional name |
| --- | --- | --- | --- |
| Integral Lattices 8D | L-functions Layer 2, item 1 | the analytic dual of a `ZLattice` in a real inner product space | `ZLattice.dual` |
| Integral Lattices 8D | L-functions Layer 2, item 3 | `covolume L * covolume Lᵛ = 1` | `ZLattice.covolume_mul_covolume_dual` |
| Integral Lattices 8E | L-functions Layer 2, item 6 | Poisson summation `∑_{v ∈ L} f v = (covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w` | `ZLattice.tsum_eq_covolume_inv_mul_tsum_dual` |
| Integral Lattices 8E | L-functions Layer 2, item 8 | `Θ_L(1/t) = t^{n/2} (covolume L)⁻¹ Θ_{Lᵛ}(t)` for real `t > 0` | `ZLattice.gaussianTheta_one_div` |
| L-functions Layer 2, items 10 to 13 | Integral Lattices 1B | the dual lattice of an integral bilinear form, and the vocabulary for it | `IntegralLattice.dual` |
| L-functions Layer 2, items 10 to 13 | Integral Lattices 8D | the analytic dual of the realization of `L` equals `IntegralLattice.dual` | `IntegralLattice.analyticDual_eq_dual` |

The agreed names belong to the supplier. Layer 2 of this roadmap uses `ZLattice.dual` and
`ZLattice.gaussianTheta_one_div` for the objects it owns, and cites `IntegralLattice.dual` for
the object the other roadmap owns.

## Standing hypotheses

Work over a number field `K` with `[Field K] [NumberField K]`. Write `𝓞 K` for
`NumberField.RingOfIntegers K`. State hypotheses directly; do not collect them into new
classes.

Coefficients are complex. An L-series is always Mathlib's `LSeries` of a coefficient function
`ℕ → ℂ`; `LSeries.term` drops the `n = 0` term. Ideal-indexed series enter only through the
named norm coefficient of Layer 1. There is no second summation theory indexed by ideals.

Real limits at `s = 1` use the `𝓝[>] 1` idiom of Mathlib's class number formula.

Do not assume `K ≠ ℚ`. Every construction must recover the classical object at `K = ℚ`. The
comparison of `dedekindZeta ℚ` with `riemannZeta` is a worked example, not an afterthought.

Prime sets have one carrier: `IsDedekindDomain.HeightOneSpectrum (𝓞 K)`. This is the carrier
of Mathlib's density predicate. Where a statement is more natural over nonzero prime ideals of
`𝓞 K`, state it over `HeightOneSpectrum` and use the translation lemma of Layer 8A.6. Two
public theorems must not use different carriers.

⚠ Junk values need care. `LSeries f s = 0` where the series does not converge, so
`dedekindZeta K` is not equal to any continued function off `Re s > 1`. Two consequences.
Identities between continued L-functions are stated for the continued objects built here. Every
identity at the level of series carries the region hypothesis `1 < s.re`. Mathlib's
`riemannZeta_one_ne_zero` shows the care required: the junk value at `s = 1` happens to be
nonzero.

## Pinned conventions

| Object | Convention | Source |
|---|---|---|
| L-series carrier | `LSeries f s = ∑' n, LSeries.term f s n` for `f : ℕ → ℂ`, with scoped notation `L`, `↗`, `δ`, `⍟`. The abscissa is `LSeries.abscissaOfAbsConv`, which is the abscissa of absolute convergence. That is the only abscissa in Mathlib | `Mathlib/NumberTheory/LSeries/{Basic,Convergence}.lean` |
| Gamma factors | `Complex.Gammaℝ s = π ^ (-s/2) * Gamma (s/2)` and `Complex.Gammaℂ s = 2 * (2*π) ^ (-s) * Gamma s`, with `Gammaℝ_mul_Gammaℝ_add_one : Gammaℝ s * Gammaℝ (s+1) = Gammaℂ s`. ⚠ Sources differ here by constants. Lang's completed zeta uses `Γ(s/2)^{r₁} Γ(s)^{r₂}` and differs from this one by `2^{r₂}`. Such a factor does not change the functional equation, but it changes every other statement. Never mix two normalizations in one statement | `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean` |
| Completed L-function | The conductor power is included: `Λ(s) = N^{s/2} · γ(s) · L(s)`, where `γ` is a product of factors `Gammaℝ (s + μ)` and `Gammaℂ (s + ν)`. The functional equation is then free of constants: `Λ(s) = ε · Λ^∨(1 − s)` with `‖ε‖ = 1` and `Λ^∨(s) = conj (Λ (conj s))`. Mathlib's `DirichletCharacter.completedLFunction` does not include `N^{s/2}`, and its functional equation carries `N ^ (s − 1/2)`. Layer 0.6 states the lemma that relates the two shapes | Layer 0; Neukirch VII (8.6) |
| Completed Dedekind zeta | `Λ_K(s) = |d_K|^{s/2} · Gammaℝ(s)^{r₁} · Gammaℂ(s)^{r₂} · ζ_K(s)`, with `Λ_K(s) = Λ_K(1 − s)`, simple poles at `s = 0` and `s = 1` and nowhere else, and `Res_{s=1} ζ_K = 2^{r₁}(2π)^{r₂} h R / (w √|d_K|)`, which is Mathlib's `dedekindZeta_residue` | Layer 3; Neukirch VII (5.10), (5.11) |
| Hecke L conductor | For `χ` primitive of conductor `𝔣₀` the completed level is `|d_K| · 𝔑(𝔣₀)`, so `Λ(χ, s) = (|d_K| 𝔑𝔣₀)^{s/2} L_∞(χ, s) L(χ, s)`, with `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` and `‖W(χ)‖ = 1` | Layer 5; Neukirch VII (8.6) |
| Euler factors | At a finite prime `𝔭` of Galois type the factor is `det(1 − Frob_𝔭 · 𝔑𝔭^{-s} ∣ V^{I_𝔭})⁻¹` with **arithmetic** Frobenius. Unqualified "Frobenius" always means arithmetic, that is `x ↦ x^q` on residue fields. This is Mathlib's `IsArithFrobAt` and the local fields roadmap's convention. The geometric form is a translation lemma and never a second convention. For a ray-class character the factor is `(1 − χ(𝔭) 𝔑𝔭^{-s})⁻¹` at `𝔭 ∤ 𝔣₀` and `1` at `𝔭 ∣ 𝔣₀` | Local fields roadmap; Layer 1.5 |
| Normalization of the data record | The record of Layer 0.1 is **analytic-normalized**, and its name says so. Its functional equation reflects in `s ↦ 1 − s`, Dirichlet agreement holds on `Re s > 1`, and the gamma shifts are the analytic ones. It carries no motivic weight. An arithmetic-normalized object reaches these predicates through Layer 0.4, which carries the weight `w` and fixes the shift as `L_arith(s) = L_an(s − w/2)`. Degree, conductor, root number, and zero multiplicities are invariant under that translation, and the invariance is a theorem | Layer 0 |
| Spectral parameters | The gamma data is two multisets: `{μ_j}` for the factors `Gammaℝ(s + μ_j)`, and `{ν_k}` for the factors `Gammaℂ(s + ν_k)`. Then `degree = #μ + 2·#ν`. These are the LMFDB's `mu` and `nu` lists | Layer 0 |
| Frobenius | Public statements use the Frobenius class of Layer 8.0, whose eventual owner is the number field arithmetic roadmap. There is no second Frobenius here. Underneath sit Mathlib's `arithFrobAt` and `isConj_arithFrobAt` over `Algebra.IsInvariant`. The decomposition group is `MulAction.stabilizer G Q`, because Mathlib has no `decompositionSubgroup` for ideals | `Mathlib/RingTheory/Frobenius.lean`; Layer 8.0 |
| Dirichlet density | The public predicate is `HasDirichletDensity S δ`. It is the ratio to the sum over all nonzero primes: `(∑_{𝔭 ∈ S} 𝔑𝔭^{-s}) / (∑_{𝔭} 𝔑𝔭^{-s}) → δ` along `𝓝[>] 1` in real `s`, with the partial sum named `primeIdealZetaSum S s`. Mathlib master has exactly this in `NumberTheory/NumberField/DirichletDensity.lean`, namespace `NumberField.Set`, used as `S.HasDirichletDensity δ`. The pin does not have it, so Layer 8A.1 builds it in that shape. Neukirch's denominator `log((s−1)⁻¹)` is not a second definition. It is the theorem of Layer 8A.2. No theorem here uses the numerical `dirichletDensity`, which takes a junk value when no density exists | Layer 8A; Neukirch VII (13.1) |
| Upper and lower Dirichlet density | The `limsup` and the `liminf` of the same ratio, as two separate predicates. The crossing argument of Layer 8C produces a bound on a `liminf` and nothing stronger, so both are needed. Layer 8A.3 proves that equality of the two gives the density | Layer 8A |
| Natural density | `δ(M) = lim_{x→∞} #{𝔭 ∈ M ∣ 𝔑𝔭 ≤ x} / #{𝔭 ∣ 𝔑𝔭 ≤ x}`. Natural density implies Dirichlet density with the same value, by Layer 8A.7. ⚠ The converse is false. Chebotarev is proved for Dirichlet density in Layer 8 and for natural density in Layer 9. The LMFDB displays the natural form | Layers 8A, 9 |
| Polar density | The value `m/n`, when `ζ_{K,T}(s)^n` extends meromorphically near `s = 1` with a pole of order `m`. Polar density implies Dirichlet density with the same value. Layer 8A.8 is the only consumer | Layer 8A; Milne CFT VI §3 |
| Functional-equation method | Hecke's theta method, in Layers 2, 3, 5, and 6. The next section states the reasons | this roadmap |

## Why the functional equation uses Hecke's method

There are two classical proofs of the functional equation of the Dedekind zeta function.
Hecke's proof uses a theta kernel and Poisson summation on the Minkowski lattice. Tate's proof
uses Fourier analysis on the ideles. Layers 2, 3, 5, and 6 use Hecke's proof, for four reasons.

1. **It continues the method Mathlib already uses.** Every completed functional equation in
   Mathlib is proved by Hecke's method in dimension one. This holds for zeta, for the even and
   odd Hurwitz zeta functions, for `ZMod N`, and for Dirichlet characters. Each proof uses a
   theta kernel, its Poisson transformation, and the Mellin machinery of `AbstractFuncEq.lean`.
   The number field case is the same argument one dimension up. Mathlib also has the
   multivariate Fourier prerequisite already, in `Analysis/Fourier/AddCircleMulti.lean`.
2. **The hard input already exists.** Both proofs need a fundamental domain for the unit action
   on the norm-one hypersurface of Minkowski space, with measure proportional to the regulator.
   Roblot built exactly that for the class number formula, in
   `NumberField/CanonicalEmbedding/{FundamentalCone,NormLeOne}.lean`,
   `NumberField/Ideal/Asymptotics.lean`, and `Algebra/Module/ZLattice/Covolume.lean`. Hecke's
   proof consumes it. Tate's proof would rebuild it inside an idele-class fundamental domain.
3. **The adelic prerequisites are absent.** Tate's thesis needs self-dual characters,
   Schwartz–Bruhat functions, self-dual Haar normalizations, integration over a restricted
   product, adelic Poisson summation, and compactness of `𝔸_K/K`. None of that is in Mathlib.
   The adele ring stops at its definition and local compactness of the infinite part. There is
   no idele class group. Pontryagin duality at the generality Lang assumes is also incomplete.
4. **Hecke's method proves everything this roadmap promises.** This includes general
   Grossencharacters. Neukirch VII §§6–8 carries out the argument in that generality, with theta
   series weighted by `N(x^p)`, Gauss sums, and the root number `W(χ)` with `|W(χ)| = 1`. Lang
   warns on page 243 that his ch. XIII treats `ζ_K` only, and that he treats characters only in
   Tate's version. Neukirch is therefore the source for Layers 5 and 6.

Two costs come with the choice. Layer 6 inherits Hecke's bookkeeping over infinity types, where
Tate's argument is uniform in the character. Hecke's method also does not produce the
factorization of the root number into local constants, which is why that factorization is out
of scope.

## What Mathlib has

Verified file by file against the pin `9caeba1000` (2026-06-03). Names are exact, and the
unusual spellings are Mathlib's. Statements about Mathlib master are dated 2026-08-07.

**L-series core.**

- `LSeries/Basic.lean`: `LSeries`, `LSeriesSummable`, `LSeriesHasSum`, `LSeries.term`,
  `LSeries.delta`, and the summability criteria from `O(n^{x-1})` bounds.
- `LSeries/Convergence.lean`: `LSeries.abscissaOfAbsConv` into `EReal`, with
  `LSeriesSummable_of_abscissaOfAbsConv_lt_re` and `abscissaOfAbsConv_le_of_isBigO_rpow`.
- `LSeries/Convolution.lean`: `LSeries.convolution`, `LSeries_convolution'`, and
  `abscissaOfAbsConv_convolution_le`.
- `LSeries/Deriv.lean`: `LSeries_hasDerivAt`, `LSeries_analyticOnNhd`, and `LSeries.logMul`.
  Note the misspelled `LSeries.absicssaOfAbsConv_logPowMul`.
- `LSeries/Injectivity.lean`: `LSeries_injOn` and
  `LSeries_eq_iff_of_abscissaOfAbsConv_lt_top`, so coefficients are determined.
- `LSeries/Positivity.lean`: `LSeries.positive` and
  `LSeries.positive_of_differentiable_of_eqOn`. This is the nearest thing to Landau's theorem.
- `LSeries/SumCoeff.lean`: Roblot's `LSeriesSummable_of_sum_norm_bigO`,
  `LSeries_eq_mul_integral`, and `LSeries_tendsto_sub_mul_nhds_one_of_tendsto_sum_div`.

**The abstract functional equation.**

- `LSeries/AbstractFuncEq.lean`: `WeakFEPair`, with fields `f g : ℝ → E`, weight `k`, root
  number `ε`, and constant terms `f₀ g₀`. The theorems are
  `functional_equation : Λ (k − s) = ε • symm.Λ s`, `differentiable_Λ₀`, `differentiableAt_Λ`,
  `Λ_residue_k`, and `Λ_residue_zero`.
- ⚠ The shape changed after the pin. Master has the predicate
  `IsStrongFEPair (P : WeakFEPair E) : Prop`, from PR #41329, merged 2026-07-04. The pin has a
  `StrongFEPair` structure instead. Layer 2.14 builds against the master shape.
- ⚠ The file has a TODO asking for a level, that is for `f (N / x) = c • x ^ k • g x`. It names
  `FEPairWithLevel` as the suggested wrapper. Layer 2.14 builds that.
- `LSeries/MellinEqDirichlet.lean`: `hasSum_mellin` and `hasSum_mellin_pi_mul_sq`.
- `Analysis/MellinTransform.lean`: `mellin` and `MellinConvergent`.
- `Analysis/MellinInversion.lean`: `mellinInv_mellin_eq`. ⚠ There is no Perron formula and no
  contour shifting.

**Zeta and Dirichlet.**

- `LSeries/RiemannZeta.lean`: `riemannZeta`, `completedRiemannZeta`, `completedRiemannZeta₀`,
  `completedRiemannZeta_one_sub`, `riemannZeta_one_sub`, `riemannZeta_residue_one`, the trivial
  zeros, and `RiemannHypothesis`.
- `LSeries/HurwitzZetaEven.lean`, `HurwitzZetaOdd.lean`, `HurwitzZeta.lean`: the kernels, the
  `WeakFEPair` instances at `k = 1/2` and `k = 3/2`, and `expZeta`.
- `LSeries/HurwitzZetaValues.lean`: `riemannZeta_two`, `riemannZeta_two_mul_nat`, and
  `riemannZeta_neg_nat_eq_bernoulli`. Its TODO asks for the Dirichlet case, which is Layer 4.5.
- `LSeries/ZMod.lean`: `ZMod.LFunction`, `completedLFunction`, and `LFunction_residue_one`.
- `LSeries/DirichletContinuation.lean`: `DirichletCharacter.LFunction`, `gammaFactor`,
  `completedLFunction`, `rootNumber`, `IsPrimitive.completedLFunction_one_sub`,
  `LFunctionTrivChar_eq_mul_riemannZeta`, and `LFunction_changeLevel`.
  ⚠ `‖rootNumber χ‖ = 1` is unproved, at the pin and on master.
- `LSeries/Dirichlet.lean`: the abscissa results, and
  `LSeries_vonMangoldt_eq_deriv_riemannZeta_div`.
- `LSeries/Nonvanishing.lean`: `LFunction_ne_zero_of_one_le_re`,
  `LFunction_ne_zero_of_re_eq_one`, and the `3-4-1` bound `norm_LFunction_product_ge_one`.
- `LSeries/PrimesInAP.lean`: `Nat.infinite_setOf_prime_and_eq_mod`. ⚠ It proves infinitude and
  no density.

**Euler products.**

- `EulerProduct/Basic.lean`: `EulerProduct.eulerProduct_hasProd` and
  `ArithmeticFunction.IsMultiplicative.eulerProduct`.
- `EulerProduct/DirichletLSeries.lean`: `riemannZeta_eulerProduct_tprod` and
  `DirichletCharacter.LSeries_eulerProduct`.
- `ArithmeticFunction/LFunction.lean`: Browning's `ArithmeticFunction.eulerProduct` over an
  index type, and `Northcott`.
- ⚠ There is no Euler product for `dedekindZeta`. Even the multiplicativity of its coefficient
  is unproved.

**Dedekind zeta and its substrate.**

- `NumberField/DedekindZeta.lean`: Roblot's `dedekindZeta`, the constant
  `dedekindZeta_residue`, and the class number formula
  `tendsto_sub_one_mul_dedekindZeta_nhdsGT` as a one-sided real limit. Its TODO asks for a
  general construction, and is unchanged on master.
- `NumberField/Ideal/Asymptotics.lean`: `Ideal.tendsto_norm_le_and_mk_eq_div_atTop`, which
  counts the ideals in one class, with a constant that does not depend on the class.
- `NumberField/CanonicalEmbedding/`: `mixedEmbedding`, `FundamentalCone`, `NormLeOne`, and
  `PolarCoord`.
- `Algebra/Module/ZLattice/Covolume.lean`: `ZLattice.covolume`.
- `RingTheory/Ideal/Norm/AbsNorm.lean`: `Ideal.absNorm` and `finite_setOf_absNorm_eq`.
- `RingTheory/DedekindDomain/Different.lean`: `FractionalIdeal.dual`, and the different.

**Analytic toolbox.**

- `Gamma/Deligne.lean`: `Gammaℝ`, `Gammaℂ`, `Gammaℝ_mul_Gammaℝ_add_one`, and
  `Gammaℝ_eq_zero_iff`.
- `Fourier/PoissonSummation.lean`: the one-dimensional `Real.tsum_eq_tsum_fourier`.
- `Fourier/AddCircleMulti.lean`: Loeffler's multivariate Fourier series with uniform
  convergence. Layer 2.5 uses it.
- `Gaussian/PoissonSummation.lean`: Jacobi's `θ(1/t) = √t·θ(t)`.
- `Distribution/SchwartzSpace.lean` and `Fourier/FourierTransform.lean`: Schwartz functions,
  and the Fourier transform on `ℝ^n`.
- `NumberTheory/AbelSummation.lean`: Abel summation.
- `NumberTheory/Chebyshev.lean`: `Chebyshev.psi`, `theta`, and two-sided bounds.
- `NumberTheory/PrimeCounting.lean`: `Nat.primeCounting`.

**Frobenius vocabulary.**

- `RingTheory/Frobenius.lean`: `AlgHom.IsArithFrobAt`, `IsArithFrobAt`,
  `IsArithFrobAt.exists_of_isInvariant`, `arithFrobAt`, and `isConj_arithFrobAt`.
- `RingTheory/Invariant/Basic.lean`: `Algebra.IsInvariant`, and
  `Ideal.Quotient.stabilizerHom_surjective`.
- `NumberTheory/RamificationInertia/Galois.lean`: `Ideal.ramificationIdxIn`,
  `Ideal.inertiaDegIn`, and `ncard_primesOver_mul_ramificationIdxIn_mul_inertiaDegIn`.
- `NumberField/Cyclotomic/Galois.lean`: Roblot's `IsCyclotomicExtension.Rat.galEquivZMod` and
  `galEquivZMod_stabilizer`, which give the cyclotomic splitting law over `ℚ`.

**Density, on master only.**

- `NumberField/DirichletDensity.lean`: `NumberField.Set.primeIdealZetaSum`,
  `NumberField.Set.HasDirichletDensity`, and `dirichletDensity`. It also has the empty set, the
  nonnegativity, and the bound by one.
- ⚠ There is no density theorem there, and no Chebotarev. Layer 8A.1 builds the predicate in
  that exact shape, because the pin does not have it.

## What is missing

The data model in full. Nothing carries a degree, a conductor, spectral parameters, or a root
number, and nothing relates the arithmetic and analytic normalizations.

The named ideal norm coefficient and its multiplicativity. The Euler product of `dedekindZeta`.
Local Euler-factor data with a recorded set of bad primes.

Continuation of `dedekindZeta` past `Re s > 1`: into the strip `Re s > 1 − 1/[K:ℚ]` by ideal
counting, and to `ℂ` by the theta method. The completed `Λ_K`, its functional equation, and its
poles and residues. The same for partial zeta functions.

Poisson summation for a general lattice, the Hecke theta transformation, and a functional
equation with a level.

Hecke L-series of ray-class characters and of Grossencharacters: Euler products, Gauss sums
with `|τ(χ)| = √𝔑(𝔣₀)`, completed functional equations with root numbers, and induction of
characters.

Special values: `L(1, χ)` for quadratic characters, the finite class number formulas, and the
factorizations `ζ_K = ζ · L(χ_D)` and `ζ_{ℚ(ζₙ)} = ∏ L(χ)`.

Landau's theorem. Nonvanishing of ray-class L-functions at `s = 1` and on `Re s = 1`, in
meromorphic-order form.

Every density notion for primes, their comparison lemmas, the splitting-density theorem, the
Frobenius density theorem, ray-class equidistribution, and the Chebotarev density theorem.

Wiener–Ikehara. The prime ideal theorem `π_K(x) ∼ x/log x`, with the ideal von Mangoldt
function and the asymptotics for `ψ_K` and `θ_K` it goes through. The natural-density form of
Chebotarev.

---

## The build, in layers

Layers 0 and 1 come first. After them the roadmap has three independent parts, which different
people can build at the same time:

- Layers 2, 3, 5, 6, the functional equation;
- Layer 4, special values;
- Layers 7 and 8, nonvanishing and densities.

Layers 7 and 8 need only Layer 1.7 and Layer 1.9, never the functional equation. Layer 9 needs
Layers 7 and 8. *Ordering* below has the graph.

As each layer makes the next one's types expressible, add its milestones to `Suggested.lean`
with `sorry`.

### Layer 0: the L-function data model and the instance ledger

The axiomatics of Iwaniec–Kowalski ch. 5, as one structure with separate predicates over
`LSeries`. Every LMFDB L-function page instantiates this layer.

**0.1 The record.** `AnalyticLFunctionData`, with these fields:

- coefficients `a : ℕ → ℂ`;
- the arithmetic conductor `conductor : ℕ+`;
- multisets `gammaR` and `gammaC` of complex shifts;
- the root number `ε`;
- a total representative `Λ : ℂ → ℂ` of the completed function;
- a finite polar divisor `polarOrder : ℂ →₀ ℕ`.

The representative is total because that is Mathlib's function type. No predicate below reads
its value at a pole.

⚠ The name states the normalization. The record is analytic-normalized, and it carries no
motivic weight. An arithmetic-normalized object reaches these predicates only through 0.4.

Basic API for the record:

- accessors `degree = #gammaR + 2 · #gammaC`, the gamma factor
  `γ(s) = ∏ Gammaℝ(s + μ) ∏ Gammaℂ(s + ν)`, and the conjugate dual `Λ^∨(s) = conj (Λ (conj s))`;
- `ext` and `Simps` lemmas for the fields;
- the dual record, with conjugate coefficients and conjugate root number, and the involution
  lemma `dual (dual d) = d`;
- the twist by a Dirichlet character, and the shift `d(· + a)`, with their effect on degree,
  conductor, gamma data, and polar divisor;
- comparison lemmas that say which of the predicates 0.2 and 0.3 the dual, the twist, and the
  shift inherit;
- the edge cases `degree = 0` and `polarOrder = 0`, each with an example;
- the downstream interface: the zeros roadmap attaches its growth predicates to this record,
  so no field may be removed without a change there.

*Prerequisites:* Mathlib `LSeries`, `Complex.Gammaℝ`, `Complex.Gammaℂ`, `Finsupp`, `Multiset`.

**0.2 Dirichlet agreement.** `HasDirichletAgreement`: `a 1 = 1`, `0 < degree`, and
`Λ(s) = conductor^{s/2} γ(s) (L a)(s)` for `1 < Re s`. ⚠ The region hypothesis cannot be
dropped. Off it, `L a` is a junk value.

*Prerequisites:* Layer 0.1; Mathlib `LSeries`.

**0.3 Continuation, functional equation, and coefficient growth.** Three further predicates.
They are separate because instances satisfy different subsets, and the model has to record
which.

- `HasMeromorphicContinuation`: `Meromorphic Λ`, and
  `meromorphicOrderAt Λ p = −polarOrder p` at each recorded pole, and nonnegative order
  elsewhere.
- `HasFunctionalEquation`: `‖ε‖ = 1`, invariance of the polar divisor under `s ↦ 1 − conj s`,
  and `Λ(s) = ε · Λ^∨(1 − s)` off the two polar loci. With `HasMeromorphicContinuation` this is
  an equality of punctured germs. It therefore fixes matching principal parts, and it compares
  no value at a pole.
- `HasAverageCoefficientBound`: `∑_{n ≤ x} ‖a n‖ = O(x^{1+δ})` for every `δ > 0`. This is the
  form every instance can prove. Pointwise Ramanujan bounds are specific to an instance and are
  not part of the model.

Residues and higher principal parts are theorems about an instance. Layer 3.4 requires them for
the Dedekind zeta function.

*Prerequisites:* Layer 0.1; Mathlib `Meromorphic`, `meromorphicOrderAt`, `Asymptotics.IsBigO`.

**0.4 The two normalizations, and the translation between them.** A second record
`ArithmeticLFunctionData` has the same fields, and its functional equation is centered at
`(w+1)/2` for an integer weight `w`. A structure `NormalizationTranslation` relates a pair:

```lean
structure NormalizationTranslation where
  arithmetic : ArithmeticLFunctionData
  analytic   : AnalyticLFunctionData
  weight     : ℤ
  coeff_eq      : ∀ n : ℕ, analytic.a n = arithmetic.a n / (n : ℂ) ^ ((weight : ℂ) / 2)
  completed_eq  : ∀ s : ℂ, analytic.Λ s = arithmetic.Λ (s + (weight : ℂ) / 2)
  gammaR_eq     : analytic.gammaR = arithmetic.gammaR.map (· - (weight : ℂ) / 2)
  gammaC_eq     : analytic.gammaC = arithmetic.gammaC.map (· - (weight : ℂ) / 2)
  polarOrder_eq : ∀ p : ℂ, analytic.polarOrder p = arithmetic.polarOrder (p + (weight : ℂ) / 2)
  conductor_eq  : analytic.conductor = arithmetic.conductor
  rootNumber_eq : analytic.rootNumber = arithmetic.rootNumber
```

The direction of the shift is fixed as displayed. Four theorems:

- degree is invariant;
- a translation exists for every arithmetic record, and is unique;
- the analytic side satisfies 0.2 and 0.3 exactly when the arithmetic side satisfies their
  translates;
- the multiplicity of a zero is invariant.

⚠ Test the structure on two instances before using it. At `w = 0`, which is a Dirichlet
character, every field must reduce to `rfl`. At `w = k − 1`, which is a weight-`k` newform, the
shift is nonzero for the first time. A wrong sign is invisible before the second test.

*Prerequisites:* Layers 0.1, 0.2, 0.3.

**0.5 The zeta instance card.** Degree 1, conductor 1, `gammaR = {0}`, `gammaC = 0`, `ε = 1`,
`Λ = completedRiemannZeta`, and simple poles at `0` and `1`. It satisfies 0.2, 0.3. The
functional equation is `completedRiemannZeta_one_sub`, read off the polar locus. Every instance
is complete at the pin, so this card validates the model on the day the model exists.

*Prerequisites:* Layers 0.1, 0.2, 0.3; Mathlib `completedRiemannZeta`,
`completedRiemannZeta_one_sub`, `riemannZeta_residue_one`.

**0.6 The Dirichlet instance card.** For `χ` primitive modulo `N > 1`: degree 1, conductor `N`,
`gammaR = {0}` or `{1}` by parity, `Λ = N^{s/2} · completedLFunction χ`, and `ε = rootNumber χ`.
Including the conductor power in the completion makes Mathlib's `N^{s−1/2}` functional equation
free of constants. State that relation as a lemma of this layer.

⚠ This card cannot be closed with what Mathlib has. `‖rootNumber χ‖ = 1` is unproved, at the pin
and on master, so prove it here.

*Source:* Mathlib's `gaussSum_mul_gaussSum_eq_card`, applied to a primitive character.
*Hypotheses:* `χ` primitive, `N > 1`. *Nearby false statement:* `‖rootNumber χ‖ = 1` fails for
an imprimitive `χ`, where `rootNumber` takes a junk value.

*Prerequisites:* Layers 0.1, 0.2, 0.3; Mathlib `DirichletCharacter.rootNumber`,
`IsPrimitive.completedLFunction_one_sub`, `gaussSum_mul_gaussSum_eq_card`.

**0.7 The instance ledger.** Each row is discharged in the layer named.

| Instance | Layer |
|---|---|
| Riemann zeta | 0.5 |
| Dirichlet character | 0.6 |
| Dedekind zeta of `K` | 3.10 |
| finite-order ray-class Hecke character | 5.9 |
| Grossencharacter | 6.4 |
| quadratic and cyclotomic factorizations | 4.2, 4.4 |
| newform of weight `k` and level `N` | 0.7, from the modular forms roadmap |

The newform row is consumed and not built. The [modular forms
roadmap](../ModularForms/README.md), Layer 7, supplies convergence, the Euler product, the
completed `Λ_N`, the two-form equation `Λ_N(k − s, f) = i^k Λ_N(s, g)`, entirety, and the
analytic conductor of Iwaniec–Kowalski (5.7). The milestone here is the card only: degree 2,
arithmetic conductor `N`, and the translation of 0.4 at `w = k − 1`.

Artin L-functions are not a row. Layers 5 and 6 are built at the generality that Brauer
induction needs, and a representation-theoretic roadmap owns any Artin instance.

Elliptic curves are not a row. No roadmap supplies classical modularity, so no continuation and
no functional equation is asserted for `WeierstrassCurve.LSeries`. A later supplier adds the row
and changes nothing here. That is why the predicates of 0.2 and 0.3 are separate.

*Prerequisites:* Layers 0.4, 0.5, 0.6; Modular forms roadmap, Layer 7.

### Layer 1: ideal-indexed series, Euler products, and continuation into a strip

Everything about `ζ_K` that needs no theta function. Layers 3, 5, 7, and 8 are stated in this
vocabulary. This layer discharges the TODO in `DedekindZeta.lean`.

**1.1 The norm coefficient.** `idealCoeff K : ℕ → ℂ`, sending `n` to the number of ideals
`I` of `𝓞 K` with `Ideal.absNorm I = n`. Mathlib inlines this lambda inside `dedekindZeta` and
never names it. Prove `dedekindZeta K = LSeries (idealCoeff K)`.

Basic API:

- the value at `0` and at `1`;
- positivity;
- `idealCoeff ℚ n = 1` for `n ≠ 0`;
- the behaviour under a field isomorphism.

*Prerequisites:* Mathlib `NumberField.dedekindZeta`, `Ideal.absNorm`,
`Ideal.finite_setOf_absNorm_eq`.

**1.2 The weighted norm coefficient.** For `χ` a complex-valued function on nonzero ideals of
`𝓞 K`, define `idealCoeffOfWeight χ : ℕ → ℂ` by `n ↦ ∑_{𝔑𝔞 = n} χ 𝔞`, and set
`L(χ, s) = LSeries (idealCoeffOfWeight χ) s`. Every character L-function in this roadmap is
this series for one `χ`. Summability, the Euler product, and continuation are therefore proved
once here for a general `χ` under stated hypotheses, and not once per family.

The convention for bad primes is fixed here and used unchanged in Layers 5, 6, and 8: `χ 𝔭 = 0`
at a prime `𝔭` of the bad set.

Basic API:

- `idealCoeffOfWeight 1 = idealCoeff K`;
- additivity in `χ`;
- the value at `n = 1`;
- the behaviour under multiplication of weights, which is 1.3.

*Prerequisites:* Layer 1.1; Mathlib `Ideal.absNorm`, `Ideal.finite_setOf_absNorm_eq`.

**1.3 Multiplicativity and Dirichlet convolution.** Three statements. `idealCoeff K` is
multiplicative, by unique factorization of ideals and the coprime case of the Chinese remainder
theorem. `idealCoeffOfWeight χ` is multiplicative when `χ` is completely multiplicative on
ideals. Grouping by norm turns multiplication of ideal weights into Dirichlet convolution `⍟`
of the coefficient functions. The third statement is what lets Mathlib's convolution API apply
to objects indexed by ideals.

*Prerequisites:* Layers 1.1, 1.2; Mathlib `UniqueFactorizationMonoid`, `LSeries.convolution`.

**1.4 The Euler product of the Dedekind zeta function.**
`∏' 𝔭 : HeightOneSpectrum (𝓞 K), (1 − 𝔑𝔭^{-s})⁻¹ = dedekindZeta K s` on `1 < Re s`.

⚠ The index is the primes of `𝓞 K`. Grouping over a rational prime `p` by `𝔑𝔭 = p^f` gives a
second statement, not the same one. Both are wanted, because their consumers differ.

Also in this milestone: `dedekindZeta K s ≠ 0` on `1 < Re s`; the logarithm
`log ζ_K(s) = ∑_𝔭 ∑_{m ≥ 1} 𝔑𝔭^{-ms}/m`, which starts every density argument; and
`abscissaOfAbsConv (idealCoeff K) = 1`.

*Prerequisites:* Layers 1.1, 1.3; Mathlib `EulerProduct.eulerProduct_hasProd`,
`Ideal.absNorm_eq_pow_inertiaDeg`.

**1.5 Local Euler-factor data.** The records of Layer 0 say nothing about local factors. An
existential statement of the form "at each prime there is a polynomial" cannot be used by a
later theorem, so the local factors are data:

```lean
structure EulerFactorData (K : Type*) [Field K] [NumberField K] where
  localPolynomial : IsDedekindDomain.HeightOneSpectrum (𝓞 K) → Polynomial ℂ
  bad : Set (IsDedekindDomain.HeightOneSpectrum (𝓞 K))
  bad_finite : bad.Finite
```

The properties are separate predicates over that structure:

- constant term `1` at every prime;
- degree at most `d` at every prime, and exactly `d` off `bad`;
- `bad` contained in the support of the conductor;
- the local identity: the power-series coefficients of `(localPolynomial 𝔭)(T)⁻¹` are the
  values of the coefficient function at the powers of `𝔭`;
- the global identity: a `HasProd` for `∏_𝔭 (localPolynomial 𝔭 (𝔑𝔭^{-s}))⁻¹` in the half-plane
  of absolute convergence.

The determinant realization `P_𝔭(T) = det(1 − Frob_𝔭 T ∣ V^{I_𝔭})`, with arithmetic Frobenius,
is a stronger predicate on top, for instances that have a Galois representation. It is not part
of the definition.

Basic API:

- the data for the constant weight `1`, which is the Dedekind zeta case;
- the data for a ray-class character, from Layer 5.2;
- the product of two such data;
- the restriction of the data to a larger bad set;
- the lemma that the degree claim in the docstring follows from the fields.

⚠ Two Euler products, kept apart. The product above is indexed by primes of `𝓞 K`. Grouping the
primes above a rational prime `p` gives a rational local polynomial of degree at most `[K:ℚ]`.
That relation is a theorem and a milestone. It is not automorphic induction, and no milestone
calls it that, because no induction object is built anywhere here.

*Prerequisites:* Layers 0.1, 1.2, 1.4; Local fields roadmap, Layer 2, for the local conductor;
Mathlib `Polynomial`, `HasProd`.

**1.6 Counting ideals in a class, with an error term.** For a fixed ideal class `𝔎` of `K`,
`#{I ∈ 𝔎 ∣ 𝔑I ≤ x} = ρ_K x + O(x^{1−1/d})` as `x → ∞`, with `d = [K:ℚ]` and
`ρ_K = 2^{r₁}(2π)^{r₂}R/(w√|d_K|)`.

*Source:* Milne, *Class Field Theory*, VI 2.8, which cites Lang VI §3 Thm 3 for the proof.
Janusz IV 2.11 to 2.13 is the same statement over `ℤ`.
*Hypotheses:* the exponent `1 − 1/d` is exact and part of the statement. The implied constant
depends on `K` and not on `𝔎`. That independence is also part of the statement, and it is what
makes the sum over classes work.
*Nearby false statement:* the error term `O(x^{1−1/d})` cannot be improved to `O(x^{1/2})` for
general `K`. Mathlib's `Ideal.tendsto_norm_le_and_mk_eq_div_atTop` gives the limit with no
error term, so it does not imply this milestone.

⚠ This is the hard analytic milestone of the layer. It strengthens Roblot's asymptotics, so
state it in a form his files could adopt.

*Prerequisites:* Mathlib `Ideal.tendsto_norm_le_and_mk_eq_div_atTop`,
`NumberField.CanonicalEmbedding.FundamentalCone`, `ZLattice.covolume`.

**1.7 Continuation into the strip.** From 1.6, the partial zeta function `ζ(s, c)` of 1.8, and
therefore `dedekindZeta K`, extend analytically to `Re s > 1 − 1/d` except for a simple pole at
`s = 1`. This includes the complex form `(s − 1) ζ_K(s) → dedekindZeta_residue K` along
`𝓝[≠] 1`, which strengthens Mathlib's one-sided real limit.

This strip is all that Layers 7 and 8 need. They therefore do not wait for the functional
equation.

*Source:* Janusz IV 2.14; Milne VI 2.9 and 2.12.
*Prerequisites:* Layer 1.6; Mathlib `LSeriesSummable_of_sum_norm_bigO`, `LSeries_eq_mul_integral`,
`tendsto_sub_one_mul_dedekindZeta_nhdsGT`.

**1.8 Partial zeta functions.** Let `q : J_K → Q` be a finite quotient of the group of
fractional ideals prime to a modulus. When the modulus is `1` this is the ideal class group.
Otherwise it is a ray class group. In both cases the quotient is named and not left abstract.
Define `ζ(s, c) = ∑_{q(𝔞) = c, 𝔞 integral} 𝔑𝔞^{-s}` for `c : Q`. Then:

- `dedekindZeta K = ∑_{c} ζ(·, c)`, a finite sum;
- `L(χ, s) = ∑_{c} χ(c) ζ(s, c)` for a character `χ` of `Q`, a finite sum;
- `ζ(s, c) = (#Q)⁻¹ ∑_χ conj (χ c) L(χ, s)`, by orthogonality of characters. Layer 8 uses this
  third form.

Basic API:

- the case `#Q = 1`;
- the behaviour under a surjection `Q ↠ Q'`;
- the abscissa of `ζ(·, c)`;
- the value of `∑_c ζ(s, c)` at a point of `1 < Re s`.

*Prerequisites:* Layers 1.1, 1.2; Mathlib `ClassGroup`, character orthogonality for a finite
abelian group.

**1.9 The residue of a partial zeta function.** `ζ(s, c)` has a simple pole at `s = 1` with
residue `ρ_K/#Q`, independent of `c`. Consequence: for `χ ≠ 1` the function `L(χ, s)` is
holomorphic at `s = 1`. Layer 7.4 completes that statement by proving the value is nonzero.

*Prerequisites:* Layers 1.6, 1.7, 1.8.

### Layer 2: lattice Poisson summation, theta transformations, and a level

Analysis with no arithmetic content beyond the lattice vocabulary. Every item is worth having
on its own. This roadmap owns the general theory; the shared table above states what the
integral lattices roadmap takes and what it gives.

**2.1 The analytic dual lattice, `ZLattice.dual`.** For a `ZLattice L` in a finite-dimensional
real inner-product space `E`, define `Lᵛ = {w ∣ ∀ v ∈ L, ⟪v, w⟫ ∈ ℤ}` and give it its `ZLattice`
instance. Mathlib's `Submodule.dualSubmodule` is the version with a general bilinear form.
Name the analytic dual and prove the two agree for the inner product. The shared table above
fixes the name.

Basic API:

- the dual of `ℤⁿ` in `ℝⁿ`;
- monotonicity, that is `L ≤ M → Mᵛ ≤ Lᵛ`;
- the dual of a scaled lattice;
- the dual under a linear equivalence;
- the dual of a direct sum.

*Prerequisites:* Mathlib `ZLattice`, `Submodule.dualSubmodule`, `InnerProductSpace`.

**2.2 Biduality.** `(Lᵛ)ᵛ = L`.
*Prerequisites:* Layer 2.1.

**2.3 Covolumes, `ZLattice.covolume_mul_covolume_dual`.**
`ZLattice.covolume L * ZLattice.covolume Lᵛ = 1`, and the behaviour of `covolume` under a
linear equivalence.
*Prerequisites:* Layers 2.1, 2.2; Mathlib `ZLattice.covolume`, `covolume_comap`.

**2.4 The Fourier transform under a linear change of variables.**
`𝓕(f ∘ B) = |det B|⁻¹ · (𝓕f) ∘ (Bᵀ)⁻¹` for `B` a linear equivalence of `E`, in Mathlib's
`VectorFourier` normalization. State it so that 2.6 follows from 2.5.
*Prerequisites:* Mathlib `VectorFourier.fourierIntegral`, `SchwartzMap`.

**2.5 Poisson summation for `ℤⁿ`.** `∑_{v ∈ ℤⁿ} f v = ∑_{w ∈ ℤⁿ} 𝓕f w` for Schwartz `f`.
Method: periodize, expand in a multivariate Fourier series, and evaluate at `0`. This is the
proof of the one-dimensional `Real.tsum_eq_tsum_fourier`, one dimension up.
*Source:* the classical proof; Mathlib's `Analysis/Fourier/AddCircleMulti.lean` exists for it.
*Prerequisites:* Mathlib `AddCircleMulti`, `SchwartzMap`, `Real.tsum_eq_tsum_fourier`.

**2.6 Poisson summation for a general lattice,
`ZLattice.tsum_eq_covolume_inv_mul_tsum_dual`.**
`∑_{v ∈ L} f v = (ZLattice.covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w`, by transporting 2.5 along a basis.

*Hypotheses:* `f` Schwartz is sufficient. The one-dimensional version in Mathlib assumes
`rpow` decay of `f` and of `𝓕f`, which is weaker; state the Schwartz version and record the
decay version as a variant.
*Nearby false statement:* the identity fails without a decay hypothesis. Continuity and
summability of `∑ f v` alone are not enough.

Basic API:

- the case `L = ℤⁿ`;
- the case of a scaled lattice;
- the version with a translation, which introduces a character;
- the version for a Schwartz function on a product.

*Prerequisites:* Layers 2.1, 2.3, 2.4, 2.5.

**2.7 The Fourier transform of a Gaussian.** For a positive-definite quadratic form `Q` on `E`,
`𝓕(exp(−π Q)) = (det Q)^{-1/2} exp(−π Q⁻¹)`.

⚠ The square root needs care. Use `InnerProductSpace` and the self-adjoint square root, and not
raw matrices.

*Prerequisites:* Mathlib `Gaussian` Fourier transform in one variable, `IsSelfAdjoint`,
`QuadraticForm.PosDef`.

**2.8 The Gaussian theta transformation, `ZLattice.gaussianTheta_one_div`.** Define
`Θ_L(t) = ∑_{v ∈ L} exp(−π t ‖v‖²)` and prove
`Θ_L(1/t) = t^{n/2} (covolume L)⁻¹ Θ_{Lᵛ}(t)` for `t > 0`. Prove also the multi-parameter
version, with one scale `t_v` per coordinate block. Layer 3.3 integrates that version.

*Source:* Lang XIII §2, where the multi-parameter form reads
`Θ(c, 𝔞) = (c₁⋯c_N)^{-1/2} Θ(c^{-1}, 𝔞')`.
*Basic API:

- * convergence for `t > 0`;
- the value at `t = 1` for a self-dual lattice;
- the behaviour under scaling of `L`;
- smoothness in `t`;
- the bound `Θ_L(t) − 1 = O(exp(−c t))` as `t → ∞`, which Layer 3.3 uses to split the Mellin integral.

*Prerequisites:* Layers 2.6, 2.7.

**2.9 The polynomial-weighted Gaussian transform.** For `P` a harmonic polynomial, homogeneous
of degree `m`, `𝓕(P · exp(−π ‖·‖²)) = i^{−m} P · exp(−π ‖·‖²)`. Deduce the transformation of
`∑_{v ∈ L} P(v) exp(−π t ‖v‖²)`.

Layer 6.3 needs exactly this. A roadmap that stopped at 2.8 would lack it.

*Hypotheses:* `P` harmonic is necessary. *Nearby false statement:* for a homogeneous `P` that
is not harmonic the transform is not a multiple of `P · exp(−π ‖·‖²)`; already `P(x) = x₁² `
in two variables fails.

*Prerequisites:* Layers 2.6, 2.7; Mathlib harmonic polynomials, or their construction here.

**2.10 A fractional ideal as a lattice.** `mixedEmbedding K '' I` for a fractional ideal `I`,
as a `ZLattice` in `K ⊗ ℝ`. Its dual vocabulary is `IntegralLattice.dual`, which the integral
lattices roadmap owns; the shared table above fixes that.
*Prerequisites:* Mathlib `NumberField.mixedEmbedding`, `ZLattice`; Integral lattices roadmap,
Layer 1B.

**2.11 The dual is the trace dual.** The analytic dual of `mixedEmbedding K '' I` is
`mixedEmbedding K '' (I𝔡)⁻¹`, where `𝔡` is the different. This is the one place in the roadmap
where the different appears. Its comparison with the integral dual is
`IntegralLattice.analyticDual_eq_dual`, which the integral lattices roadmap owns.
*Prerequisites:* Layers 2.1, 2.10; Mathlib `FractionalIdeal.dual`,
`RingTheory/DedekindDomain/Different.lean`; Integral lattices roadmap, Layers 1B and 8D.

**2.12 Its covolume.** `covolume (mixedEmbedding K '' I) = 2^{-r₂} √|d_K| 𝔑(I)`.
*Prerequisites:* Layers 2.3, 2.10; Mathlib `ZLattice.covolume`, `NumberField.discr`.

**2.13 The theta series of an ideal class.** Combine 2.8 with 2.10 to 2.12. Write out the
multi-parameter transformation with every power of the discriminant and every power of the norm.
Layer 3.3 integrates this exact statement. ⚠ No constant is left unwritten.
*Prerequisites:* Layers 2.8, 2.10, 2.11, 2.12.

**2.14 A functional equation with a level.** Mathlib's `AbstractFuncEq.lean` handles
`f(1/x) = ε x^k g(x)`. Its TODO asks for the level form `f(N/x) = c • x^k • g(x)` for real
`N > 0`, and proposes the name `FEPairWithLevel`. Build three things:

- a structure `FEPairWithLevel`, with the fields of `WeakFEPair` and a level `N`;
- its completed function, with the functional equation `s ↦ k − s` against level `N`;
- a theorem reducing it to `WeakFEPair` for the rescaled pair `f(√N ·)`.

`Λ_K` has level `|d_K|` and a Hecke L-function has level `|d_K| 𝔑𝔣₀`, so both instantiate it.

Basic API:

- the case `N = 1`, which must give Mathlib's structure back;
- the residues at `s = 0` and `s = k`, with the level in the constant;
- the symmetric pair;
- the entirety criterion.

⚠ Mathlib's shape changed after the pin. PR #41329, merged 2026-07-04, replaced the
`StrongFEPair` structure by the predicate `IsStrongFEPair (P : WeakFEPair E) : Prop`. Build
`FEPairWithLevel` against the master shape, and state the reduction as a theorem to
`IsStrongFEPair`. At the pin, state the predicate directly and do not import `StrongFEPair`.

*Prerequisites:* Mathlib `WeakFEPair`, `mellin`, `Λ_residue_k`, `Λ_residue_zero`.

### Layer 3: the Dedekind zeta function

Hecke's proof, following Lang XIII §§1–3 and Neukirch VII §5, on Layers 1 and 2. This is what
the LMFDB's number field pages display.

**3.1 The theta identity, written out.** The identity of 2.13, in the exact form this layer
integrates: every power of `|d_K|`, every norm `𝔑𝔞`, and every power of `2`.
⚠ No milestone here contains the phrase "the explicit factor". A constant that is not written is
not specified.
*Prerequisites:* Layer 2.13.

**3.2 The class pairing.** The functional equation permutes ideal classes by
`𝔎 ↦ 𝔎' := [𝔡]𝔎⁻¹`, where `𝔡` is the different. State this as a typed map
`dualClass : ClassGroup (𝓞 K) → ClassGroup (𝓞 K)`. Prove it is an involution, and prove trace
duality induces it through 2.11.

⚠ It is `[𝔡]𝔎⁻¹` and not `𝔎⁻¹`. Only the sum over classes is self-dual. *Nearby false
statement:* `dualClass 𝔎 = 𝔎⁻¹` is true for `K = ℚ` and false in general, so a `K = ℚ` test
does not detect the error. Verify at a field with `𝔡` not principal.

*Prerequisites:* Layers 2.11, 3.1; Mathlib `ClassGroup`, `FractionalIdeal.dual`.

**3.3 The Mellin split and the principal parts.** Unfold `ζ(s, 𝔎)` over the unit orbits of
`𝔞 ∖ {0}`. Take the Mellin transform of the ideal theta against the fundamental domain for the
unit action on the norm-one hypersurface. Split the integral at `1`. Identify the two elementary
terms that produce the poles, and name both.

*Source:* Lang XIII §3. The measure of the fundamental domain is `2^{r₁+r₂−1} R`, which is the
regulator Jacobian of Lang p. 258. That computation is the hard point of the layer.
*Prerequisites:* Layers 1.8, 2.13, 3.1; Mathlib `NumberField.CanonicalEmbedding.FundamentalCone`,
`mellin`, `NumberField.Units.regulator`.

**3.4 Per-class completion and functional equation.** Set
`Z(𝔎, s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ(s, 𝔎)`. Then `Z(𝔎, ·)` is meromorphic on
`ℂ`, with `meromorphicOrderAt (Z 𝔎) 0 = −1`, `meromorphicOrderAt (Z 𝔎) 1 = −1`, no other poles,
residues `∓ 2^{r₁+r₂} R/w`, and `Z(𝔎, s) = Z(dualClass 𝔎, 1 − s)`.

The completed constants come out as displayed because `Gammaℝ(1) = 1` and `Gammaℂ(1) = 1/π`,
which absorb the factor `(2π)^{r₂}/√|d_K|` of the uncompleted residue.

*Source:* Neukirch VII (5.9), (5.10).
*Prerequisites:* Layers 1.8, 2.14, 3.2, 3.3.

**3.5 Uniqueness of the continuation.** Two meromorphic functions that agree on `Re s > 1` agree
on `ℂ ∖ {0, 1}`, by the identity theorem on that connected set. Without this milestone an
existentially stated continuation determines nothing, so 3.6 and 3.7 are definitions and not
choices.
*Prerequisites:* Mathlib `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq`, `Meromorphic`.

**3.6 The completed Dedekind zeta function.** `completedDedekindZeta K`, written `Λ_K`, a named
definition equal to `∑_𝔎 Z(𝔎, ·)`. It is meromorphic, with simple poles at `0` and `1` and
nowhere else, residues `∓ 2^{r₁+r₂} hR/w`, the functional equation `Λ_K(s) = Λ_K(1 − s)` as an
equality of meromorphic germs, and
`Λ_K(s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ_K(s)` on `Re s > 1`. Compatibility with
`Λ_residue_k` is a theorem.

Basic API:

- the value at `K = ℚ`, which must be `completedRiemannZeta`;
- the behaviour under a field isomorphism;
- the self-duality;
- the relation to `dedekindZetaC` of 3.7.

*Prerequisites:* Layers 3.4, 3.5.

**3.7 The continued zeta function.** `dedekindZetaC K : ℂ → ℂ`, holomorphic on `ℂ ∖ {1}`, equal
to `dedekindZeta K` on `Re s > 1`, with a simple pole at `1` of residue `dedekindZeta_residue K`.
That residue is now a genuine complex residue, which subsumes Mathlib's one-sided real limit.

Prove `dedekindZetaC ℚ = riemannZeta` everywhere. That equation is why the continued object leaves this layer, and not the raw `LSeries`. It is
false for `dedekindZeta ℚ`, whose values off the half-plane are the junk value `0`. Coordinate
the name with the TODO in `DedekindZeta.lean`.

*Prerequisites:* Layers 1.7, 3.5, 3.6.

**3.8 Exact orders at the trivial zeros.** Give `meromorphicOrderAt (dedekindZetaC K)` at `s = 0`
and at each `s = −m` as a formula in `r₁`, `r₂`, and the parity of `m`. Derive them from the
poles of `Gammaℝ` and `Gammaℂ` and the order arithmetic of `meromorphicOrderAt`. The order at
`s = 0` is `r₁ + r₂ − 1`.

⚠ These are multiplicities, not existence statements, and they use `meromorphicOrderAt`. A
pointwise claim `ζ_K(−2) = 0` compares a value that the functional equation does not determine.

*Prerequisites:* Layers 3.6, 3.7; Mathlib `Gammaℝ_eq_zero_iff`, `meromorphicOrderAt`.

**3.9 The asymmetric functional equation.**
`ζ_K(1 − s) = |d_K|^{s−1/2} (cos(πs/2))^{r₁+r₂} (sin(πs/2))^{r₂} (2(2π)^{−s}Γ(s))^{[K:ℚ]} ζ_K(s)`.

⚠ The exponent on the discriminant is `s − 1/2` and not `1/2 − s`. Derive 3.8 from this
statement as a check.

*Source:* Neukirch VII (5.11)(iii).
*Prerequisites:* Layers 3.6, 3.7.

**3.10 The instance card.** Degree `[K:ℚ]`, conductor `|d_K|`, `gammaR` the `r₁`-fold multiset
`{0}`, `gammaC` the `r₂`-fold multiset `{0}`, so `degree = r₁ + 2r₂` by definition; `ε = 1`;
polar divisor supported at `{0, 1}` with order `1` at each point; self-dual. Every coherence
condition of the card is a theorem of this layer.
*Prerequisites:* Layers 0.1, 0.2, 0.3, 3.6, 3.8.

### Layer 4: special values and the class number formula

What the LMFDB's number field pages and character pages display at `s = 1` and at the integers.

**4.1 The quadratic splitting law as a coefficient identity.** For `K` quadratic of discriminant
`D`, `idealCoeff K n = ∑_{e ∣ n} χ_D(e)`, where `χ_D` is the primitive quadratic character of
conductor `|D|`. Construct `χ_D` from the Kronecker symbol and prove it primitive.

⚠ The conductor is the discriminant and not the radicand. *Nearby false statement:* using the
character modulo `|d|` for `K = ℚ(√d)` with `d ≡ 1 (mod 4)` gives a character of the wrong
conductor, and then 4.2 fails at the primes dividing `2`.

*Prerequisites:* Layer 1.1; Mathlib `legendreSym`, `jacobiSym`, quadratic reciprocity,
`DirichletCharacter.IsPrimitive`.

**4.2 The quadratic factorization.** `dedekindZeta K s = riemannZeta s · LFunction χ_D s` on
`Re s > 1`, and, after Layer 3, the same identity for the continued functions everywhere.

The ramified primes `p ∣ D` are where this identity is usually stated wrongly. There
`χ_D(p) = 0`, and both sides carry the Euler factor `(1 − p^{-s})⁻¹`. The worked example at
`ℚ(i)` checks the case `p = 2`.

*Prerequisites:* Layers 1.4, 3.7, 4.1.

**4.3 Dirichlet's class number formula, in finite form.** For `D < 0`,
`L(1, χ_D) = 2π h/(w √|D|)`. For `D > 0`, `L(1, χ_D) = 2 h log ε₀/√D`, where `ε₀` is the
fundamental unit.

*Source:* Mathlib's `tendsto_sub_one_mul_dedekindZeta_nhdsGT`, combined with 4.2 and the residue
of `LFunctionTrivChar`.
*Hypotheses:* both formulas carry the hypothesis on the sign of `D`, and neither is claimed
outside its range. For `D < 0` the number `w` of roots of unity is `2` except at `D = −3` and
`D = −4`.
*Nearby false statement:* dropping `w` gives a formula that is correct for every imaginary
quadratic field except `ℚ(i)` and `ℚ(√−3)`. A single numerical test will therefore not find the
error.

*Prerequisites:* Layers 1.7, 4.2.

**4.4 The cyclotomic factorization.** Three readings of "the product over the characters modulo
`n`" are in use, and they differ. This is the reading meant here. Write `χ*` for the primitive
character of conductor `f_χ` that induces `χ`. Then

`ζ_{ℚ(ζₙ)}(s) = ∏_{χ mod n} L(χ*, s) · ∏_{χ mod n} ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p) p^{-s})`,

where the products run over all Dirichlet characters modulo `n`, equivalently over the
characters of `Gal(ℚ(ζₙ)/ℚ) ≅ (ℤ/n)ˣ`. The second factor is exactly the Euler factors that
`L(χ, ·)` drops at `p ∣ n` relative to `L(χ*, ·)`.

*Source:* Neukirch VII (5.12).
*Nearby false statement:* `ζ_{ℚ(ζₙ)}(s) = ∏_χ L(χ*, s)` without the correction is false already
at `n = 4`.

This identity is also how `L(1, χ) ≠ 0` is proved over `ℚ` without class field theory, which
Layer 7.4 cites.

*Prerequisites:* Layers 1.4, 3.7; Mathlib `LFunction_changeLevel`,
`intermediateFieldEquivSubgroupChar`, `IsCyclotomicExtension.Rat.galEquivZMod`.

**4.5 Generalized Bernoulli numbers and values at nonpositive integers.** Define `B_{k,χ}` for
`χ` modulo `N` by `∑_{a=1}^{N} χ(a) t e^{at}/(e^{Nt} − 1) = ∑_k B_{k,χ} t^k/k!`. Prove
`L(1 − k, χ) = −B_{k,χ}/k` for `k ≥ 1`.

*Hypotheses:* `χ` is nontrivial. The trivial character has a pole at `s = 1`, and its values at
the nonpositive integers are Riemann's, which `HurwitzZetaValues.lean` already has. Also
`L(1 − k, χ) = 0` when `χ(−1) ≠ (−1)^k`.

This milestone discharges the TODO in `HurwitzZetaValues.lean`.

Basic API:

- `B_{k,χ}` for the trivial character, in terms of the ordinary Bernoulli numbers;
- the recurrence;
- the value `B_{1,χ}` for odd `χ`;
- the behaviour under induction from the conductor.

*Prerequisites:* Mathlib `bernoulli`, `HurwitzZetaValues`, `DirichletCharacter.LFunction`.

**4.6 `L(1, χ₋₄) = π/4`.** Connect it to Mathlib's `Real.tendsto_sum_pi_div_four`. This is the
smallest check that 4.3 and 4.5 agree with something known independently.
*Prerequisites:* Layers 4.3, 4.5; Mathlib `Real.tendsto_sum_pi_div_four`.

### Layer 5: Hecke L-functions of finite-order ray-class characters

The full analytic theory of the L-function of a finite-order Hecke character.

**5.1 The character interface (compatibility interface).** The global class field theory
roadmap, Layers 0 to 3, will own this vocabulary. Until its declarations exist, define here a
structure `RayClassCharacter K` carrying:

- the finite part of the conductor, `𝔣₀ : Ideal (𝓞 K)`, nonzero;
- the infinite part, `𝔣_∞ : Finset (real places of K)`;
- the induced character on ideals prime to `𝔣₀`, as an `IdealWeight K` in the sense of Layer
  7.2, with `bad = {𝔭 ∣ 𝔣₀}`;
- finite order: `∃ m > 0, χ^m = 1`;
- primitivity: no proper divisor of `𝔣₀` supports a character inducing this one.

The later milestones use these operations and no others:

- the value at an ideal;
- the conductor, with its two parts;
- the conjugate character;
- the product of two characters;
- the trivial character;
- induction from a divisor of the modulus.

The replacement is mechanical when the global class field theory roadmap supplies its Hecke
character type and its conductor. Delete `RayClassCharacter`, make it an abbreviation for that
type, and keep 5.2 to 5.9 unchanged.

⚠ The finite part and the infinite part are separate fields. Neither may be dropped. The gamma
factor of 5.5 reads the infinite part, and the level of 5.7 reads the finite part.

*Prerequisites:* Layer 7.2; Mathlib `Ideal`, `NumberField.InfinitePlace`. Eventual owner:
global class field theory roadmap, Layers 0 to 3.

**5.2 The L-series.** `L(χ, s) = LSeries (idealCoeffOfWeight χ) s`, with the convention
`χ 𝔞 = 0` when `𝔞` is not coprime to `𝔣₀`. The Euler product is
`∏_{𝔭 ∤ 𝔣₀} (1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` on `Re s > 1`, the abscissa is `1`, and the `EulerFactorData` of
Layer 1.5 has `bad = {𝔭 ∣ 𝔣₀}`.
*Source:* Neukirch VII (8.1).
*Prerequisites:* Layers 1.2, 1.4, 1.5, 5.1.

**5.3 Continuation into the strip, and the pole.** From Layer 1.8 and Layer 1.7, `L(χ, ·)`
extends to `Re s > 1 − 1/d`. For `χ ≠ 1` it is holomorphic there, because the residues cancel by
orthogonality, which is Layer 1.9. For `χ = 1` it has a simple pole at `s = 1`. Write out the
finitely many Euler factors at `𝔭 ∣ 𝔣₀` that separate `L(1, ·)` from `ζ_K`, in the shape of
Mathlib's `LFunctionTrivChar_eq_mul_riemannZeta`.
*Prerequisites:* Layers 1.7, 1.8, 1.9, 5.2.

**5.4 Induction and the imprimitive correction.** For `χ` modulo `𝔪` induced from a primitive
`χ*` modulo `𝔣₀`,
`L(χ, s) = L(χ*, s) ∏_{𝔭 ∣ 𝔪, 𝔭 ∤ 𝔣₀} (1 − χ*(𝔭)𝔑𝔭^{-s})`, a finite product written out. The
functional equation is asserted for primitive characters only, as in Mathlib's `IsPrimitive`
discipline.
*Prerequisites:* Layers 5.1, 5.2.

**5.5 The archimedean parity data and the gamma factor.** From the infinite part of the
conductor: `Gammaℝ(s)` at a real place where `χ` is trivial on the positive elements,
`Gammaℝ(s + 1)` at a real place where it is not, and `Gammaℂ(s)` at each complex place. So
`gammaR` has `r₁` entries whose shifts are determined by `𝔣_∞`, and `gammaC` has `r₂` entries.
State which convention on `𝔣_∞` is used, and match it to the interface of 5.1.
*Prerequisites:* Layers 0.1, 5.1.

**5.6 Gauss sums.** Define `τ(χ)` for a primitive character and prove `|τ(χ)| = √𝔑(𝔣₀)`.

⚠ Neukirch's device of ideal numbers, his `K̂^*`, is not canonical. Define the Gauss sum against
explicit representatives, or against the idele-theoretic data of the interface of 5.1, and prove
the value does not depend on the choices. The check that this was done correctly is that `W(χ)`
in 5.8 does not depend on the choices.

*Source:* Neukirch VII (6.4), (7.5).
*Hypotheses:* `χ` primitive. *Nearby false statement:* for imprimitive `χ` the modulus of the
Gauss sum is smaller, and the formula `|τ(χ)| = √𝔑(𝔪)` is false.
*Prerequisites:* Layer 5.1.

**5.7 The completed L-function.**
`Λ(χ, s) = (|d_K| 𝔑𝔣₀)^{s/2} L_∞(χ, s) L(χ, s)`, with `L_∞` the gamma factor of 5.5. It is
entire for `χ ≠ 1`. Prove also the per-class functional equations, which carry the `[𝔣₀𝔡]`-twist
exactly as Layer 3.2 carries `[𝔡]`.
*Source:* the theta method of Layer 2 with `χ`-weights; Neukirch VII §7 (7.6), (7.7).
*Prerequisites:* Layers 2.13, 2.14, 3.2, 5.2, 5.5, 5.6.

**5.8 The functional equation and the root number.**
`Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)`, with `W(χ) = τ(χ)/(i^{#𝔣_∞} √𝔑𝔣₀)` written out, and
`‖W(χ)‖ = 1` proved from 5.6.
*Source:* Neukirch VII (8.5), (8.6), restricted to infinity type `(p, 0)` with `p ∈ {0,1}^{r₁}`.
*Prerequisites:* Layers 5.6, 5.7.

**5.9 The instance card, and the degree over `ℚ`.** The card has degree `1` over `K`. Its
realization as an Euler product of degree `[K:ℚ]` over `ℚ` is the grouping theorem of Layer 1.5,
and the card records both.

At `K = ℚ` the construction recovers Mathlib's Dirichlet objects exactly: the two completed
functions are equal, and not merely the two functional equations. That is an acceptance
criterion.

*Prerequisites:* Layers 0.1, 1.5, 5.7, 5.8.

### Layer 6: Grossencharacters

The infinite-order theory, which the LMFDB calls Hecke characters. It completes the family of
degree-one instances over `K`.

**6.1 The infinity-type interface (compatibility interface).** The global class field theory
roadmap will own this vocabulary in its infinity-type layer. Until then, define here a structure
`Grossencharacter K` extending the interface of 5.1 with:

- the unitary decomposition `χ = χ_unit · ‖·‖^{σ}` with `σ` real;
- the infinity type: an integer `p_v` at each real place, a pair of integers at each complex
  place, and a real number `q_v` at each infinite place;
- admissibility: `χ_∞` is trivial on the units;
- a predicate `IsAlgebraic`, which is the `A₀` subtype.

*Source:* Neukirch VII (6.11) to (6.14).
*Hypotheses:* admissibility is a hypothesis here and a theorem in the owning roadmap.
*Nearby false statement:* the decomposition `χ = χ_unit · ‖·‖^{σ}` is unique only after `σ` is
required to be real. With complex `σ` it is ambiguous up to `‖·‖^{it}`.

When that roadmap supplies the type, the replacement is mechanical, as in 5.1.

*Prerequisites:* Layer 5.1. Eventual owner: global class field theory roadmap, infinity-type
layer.

**6.2 The gamma factor from the infinity type.** `L_∞(χ, s) = ∏_v Γ_v(s + (p_v − i q_v))`.
Translate Neukirch §4's `G(ℂ|ℝ)`-set formalism into `Gammaℝ` and `Gammaℂ` shifts. Spell the
translation out at each real place and at each complex place. These are the first entries of the
spectral multisets of Layer 0.1 that are not real.
*Prerequisites:* Layers 0.1, 6.1.

**6.3 The weighted theta series.** From Layer 2.9: the series
`∑_{x ∈ 𝔞} N(x^p) exp(−π ∑_v t_v |x_v|²)`, its transformation with the constant `W(χ, p̄)`, and
the Mellin assembly. The harmonic weight is exactly the polynomial of Layer 2.9, which is why
that milestone is in Layer 2.
*Source:* Neukirch VII §7, in full generality.
*Prerequisites:* Layers 2.9, 2.13, 6.1, 6.2.

**6.4 Continuation, poles, and the functional equation.** `Λ(χ, s)` is meromorphic. It is entire
unless `𝔣 = 1` and `p = 0`, that is unless `χ` is a power of the norm character. In that
exceptional case the poles are exactly at `s = Tr(−p + iq)/n` and at `s = 1 + Tr(p + iq)/n`.
The functional equation is `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` with `‖W(χ)‖ = 1`.

⚠ The classification of the exceptional case is part of the statement. No milestone here writes
"the exceptional case" without saying which case it is.

*Source:* Neukirch VII (8.5), (8.6).
*Prerequisites:* Layers 2.14, 6.2, 6.3.

**6.5 The nonvanishing consequence, packaged.** Layer 7.5 proves `L(χ, 1 + it) ≠ 0` for these
characters. This milestone packages the form an equidistribution argument needs: nonvanishing for
the twists `χ ‖·‖^{it}`, uniformly in `t`, with the exceptional case of 6.4 excluded explicitly.

⚠ This is a typed export and not equidistribution. The Weyl criterion for a compact group is out
of scope.

*Prerequisites:* Layers 6.1, 6.4, 7.5.

**6.6 Hecke's equidistribution of Gaussian primes.** The arguments of the primes of `ℤ[i]` are
equidistributed in `[0, π/2)`. Prove it by applying 6.5 to the characters `𝔞 ↦ (α/|α|)^{4k}` of
`ℚ(i)`. This is the only equidistribution statement in the roadmap. It is here because it checks
that 6.1 to 6.5 can be used.
*Source:* Lang XV Thm 5.
*Prerequisites:* Layers 6.1, 6.5.

### Layer 7: Landau's theorem, the analytic premise, and nonvanishing

The analytic input to every density theorem, proved without class field theory. Layer 8
therefore does not wait for the global class field theory roadmap. Milestone 7.7 records the
class-field-theoretic proof as a corollary, and nothing else uses it.

**7.1 Landau's theorem.** A Dirichlet series with nonnegative real coefficients has a
singularity at its abscissa of absolute convergence. Precisely: no function holomorphic on a
neighbourhood of that abscissa agrees with the series on the intersection of the neighbourhood
with the half-plane of convergence.

Mathlib's `LSeries.positive_of_differentiable_of_eqOn` is the nearest thing and is weaker.
Milestones 7.4 and 8A.8 use this theorem.

*Source:* Lang VIII §5; Serre, *A Course in Arithmetic*, VI §2.
*Hypotheses:* the coefficients are nonnegative reals, and the abscissa is finite.
*Nearby false statement:* the conclusion fails for complex coefficients. The function
`∑ (−1)^n n^{-s}` has abscissa of absolute convergence `1` and continues to an entire function.

*Prerequisites:* Mathlib `LSeries.abscissaOfAbsConv`, `LSeries.positive`, `AnalyticOnNhd`.

**7.2 Ideal weights, and the analytic premise they need.** The theorems below are wanted for two
families. The first is the ray-class characters of Layer 5. The second is the Frobenius
characters `𝔭 ↦ χ(Frob_𝔭)` of an abelian extension, from Layer 8. It is tempting to state them
for a character of an arbitrary finite quotient of the ideal group. That hypothesis is too weak.

The group of ideals prime to a finite set is free. It therefore has finite quotients whose
values on primes are arbitrary, and no continuation follows. The analytic content has to be a
hypothesis. Therefore:

```lean
structure IdealWeight (K : Type*) [Field K] [NumberField K] where
  toFun : Ideal (𝓞 K) → ℂ
  bad : Set (IsDedekindDomain.HeightOneSpectrum (𝓞 K))
  bad_finite : bad.Finite
  map_mul : ∀ I J, toFun (I * J) = toFun I * toFun J
  norm_eq_one : ∀ 𝔭 ∉ bad, ‖toFun 𝔭.asIdeal‖ = 1
  eq_zero_bad : ∀ 𝔭 ∈ bad, toFun 𝔭.asIdeal = 0
```

with a separate predicate carrying the estimate:

```lean
def HasCancellation (χ : IdealWeight K) : Prop :=
  (fun X : ℝ ↦ ∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ X}, χ.toFun I)
    =O[atTop] fun X : ℝ ↦ X ^ (1 - 1 / (Module.finrank ℚ K : ℝ))
```

that is, `∑_{𝔑𝔞 ≤ X} χ(𝔞) = O(X^{1 − 1/d})` with `d = [K:ℚ]`.

Then `HasCancellation χ` implies that `L(χ, ·)` continues holomorphically to `Re s > 1 − 1/d`,
by Layer 1.7 applied to the partial sums. Every nonvanishing theorem below takes
`HasCancellation` as a hypothesis. None derives it from finiteness of a quotient.

Basic API for `IdealWeight`:

- the trivial weight;
- the conjugate weight;
- the product of two weights, with the union of the bad sets;
- the restriction to a larger bad set;
- the induced `EulerFactorData` of Layer 1.5;
- the coefficient function `idealCoeffOfWeight`.

Basic API for `HasCancellation`:

- it is preserved by conjugation;
- it is preserved by enlarging the bad set by a finite set;
- the trivial weight does not satisfy it, because `∑_{𝔑𝔞 ≤ X} 1 ∼ ρ_K X`.

*Prerequisites:* Layers 1.2, 1.7.

**7.3 The premise, proved for the two families.** Two theorems, one per family.

- For a nontrivial finite-order ray-class character: from the decomposition of Layer 1.8 into
  partial zeta functions, and the counting estimate of Layer 1.6 with its error term.
- For a cyclotomic Frobenius character of `Gal(K(ζ_m)/K)`: from the same counting estimate,
  applied to the ray classes modulo `m∞`. Layer 8B.1 identifies the Frobenius with the norm
  residue.

Each is proved before its use. No family is claimed to have the property without such a proof.

*Prerequisites:* Layers 1.6, 1.8, 5.1, 7.2, 8B.1.

**7.4 `L(χ, 1) ≠ 0` for a nontrivial `χ` satisfying `HasCancellation`.**

*Source:* Lang XV Thm 2, which proves this for Hecke characters with no class number formula and
no class field theory. Mathlib's `Nonvanishing.lean` has the Dirichlet case.
*Method:* the `3-4-1` product `L(1)³ L(χ)⁴ L(χ²)` when `χ² ≠ 1`; and for a real `χ` the
positivity of the coefficients of `ζ_K(s) L(χ, s)`, together with Layer 7.1.
*Hypotheses:* `χ ≠ 1`, and `HasCancellation χ`.
*Nearby false statement:* the `3-4-1` argument alone does not cover a real `χ`, because there
`χ² = 1` and the product degenerates. That case is exactly why Layer 7.1 is needed.

*Prerequisites:* Layers 1.4, 7.1, 7.2, 7.3.

**7.5 Nonvanishing on `Re s = 1`, in meromorphic-order form.**

⚠ This is where a pointwise statement is wrong. The trivial character has a pole at `s = 1`, so
"`L(χ, 1 + it) ≠ 0` for arbitrary `χ`" compares a junk value there. State instead, for the
continued functions of Layers 1.7 and 5.3:

- `meromorphicOrderAt (dedekindZetaC K) 1 = −1`;
- `meromorphicOrderAt (dedekindZetaC K) (1 + it) = 0` for `t ≠ 0`;
- `meromorphicOrderAt (L(χ, ·)) (1 + it) = 0` for every real `t` and every nontrivial
  finite-order `χ` satisfying `HasCancellation`. For such `χ` the function is holomorphic at
  `s = 1`, so this is equivalent to `L(χ, 1 + it) ≠ 0`;
- as a corollary: no member of the family has a zero on `Re s = 1`, and the only pole is the one
  recorded above.

*Source:* Lang XV Thm 3. Mathlib's `LFunction_ne_zero_of_re_eq_one` is the Dirichlet case.
*Method:* the `3-4-1` inequality of 7.4, at `1 + it`.
*Hypotheses:* for a Grossencharacter, the twist `χ ‖·‖^{it}` reduces the general case to
`t = 0`. The exceptional case is exactly the one Layer 6.4 classifies, where `χ` is a power of
the norm character and the pole returns.
*Nearby false statement:* "for arbitrary `χ`, `L(χ, 1 + it) ≠ 0`" is false at `χ = 1`, `t = 0`,
where the value is a junk value rather than a nonzero number.

*Prerequisites:* Layers 1.7, 3.7, 5.3, 7.4.

**7.6 Logarithmic derivatives.** Define the ideal von Mangoldt weight `Λ_K(𝔞)`, equal to
`log 𝔑𝔭` when `𝔞 = 𝔭^m` for some `m ≥ 1`, and `0` otherwise. Prove
`−L'/L(χ, s) = LSeries (idealCoeffOfWeight (χ · Λ_K)) s` on `Re s > 1`, in the shape of
Mathlib's `LSeries_vonMangoldt_eq_deriv_riemannZeta_div`.

Basic API:

- the value at a prime;
- the value at `1`;
- nonnegativity of `Λ_K`;
- the norm-grouped coefficient function;
- the identity `∑_{𝔞 ∣ 𝔟} Λ_K(𝔞) = log 𝔑𝔟`.

Layers 8 and 9 both use these.

*Prerequisites:* Layers 1.2, 1.4, 5.2.

**7.7 The class-field-theoretic proof, as a corollary.** Let `L/K` be the class field. Once the
global class field theory roadmap supplies reciprocity, `ζ_L = ζ_K ∏_{χ ≠ 1} L(χ, ·)`. Then 7.4
follows from the order of the pole of `ζ_L` at `s = 1`. Prove it as a consistency check on the
normalizations of both roadmaps. Nothing else here uses it.
*Source:* Neukirch VII (13.3); Janusz V 10.2; Milne VIII 7.1.
*Prerequisites:* Layers 1.7, 7.4; Global class field theory roadmap, its reciprocity layer.

### Layer 8: prime densities and the Chebotarev density theorem

The main theorem of the roadmap. It is proved without class field theory, by the argument of
Lenstra–Stevenhagen and of Sharifi Thm 7.2.2. [`PROVENANCE.md`](PROVENANCE.md) records the
existing Lean developments on that route. It also states the coordination obligation, which
comes before the code.

**8.0 The Frobenius interface (compatibility interface).** The number field arithmetic roadmap,
Layers 2 and 5, will own this vocabulary. Until its declarations exist, define here, for number
fields `K ⊆ L` with `L/K` finite Galois:

- `IsUnramifiedAt K L 𝔭 : Prop` for `𝔭 : HeightOneSpectrum (𝓞 K)`, defined as
  `Ideal.ramificationIdxIn 𝔭.asIdeal (𝓞 L) = 1`;
- `frobeniusClass K L 𝔭 : ConjClasses (L ≃ₐ[K] L)` for an unramified `𝔭`, defined from Mathlib's
  `arithFrobAt` and `isConj_arithFrobAt`;
- the restriction compatibility: for `K ⊆ E ⊆ L` with `L/K` and `E/K` Galois, the image of
  `frobeniusClass K L 𝔭` under restriction is `frobeniusClass K E 𝔭`;
- the tower compatibility: for `K ⊆ E ⊆ L` and a prime `𝔓` of `E` over `𝔭`, the relation between
  `frobeniusClass E L 𝔓` and `frobeniusClass K L 𝔭`. The residue degree of `𝔓` over `𝔭` appears
  in the exponent.

Basic API:

- the value at a prime that splits completely, which is the identity class;
- the behaviour under an isomorphism of extensions;
- the finiteness of the ramified primes;
- the cardinality `#(frobeniusClass K L 𝔭)`.

When the number field arithmetic roadmap supplies these, the replacement is mechanical: delete
the definitions here, import theirs, and keep 8A to 8E unchanged. There is no second Frobenius
in this roadmap.

⚠ Frobenius here is arithmetic. Layer 8B.1 tests the orientation.

*Prerequisites:* Mathlib `arithFrobAt`, `IsArithFrobAt`, `isConj_arithFrobAt`,
`Algebra.IsInvariant`, `Ideal.ramificationIdxIn`. Eventual owner: number field arithmetic
roadmap, Layers 2 and 5.

#### 8A: the density calculus

**8A.1 The three densities.** Define `primeIdealZetaSum S s = ∑' 𝔭 ∈ S, 𝔑𝔭^{-s}` and
`HasDirichletDensity S δ` as the ratio to the sum over all nonzero primes, tending to `δ` along
`𝓝[>] 1`. Define also `HasUpperDirichletDensity` and `HasLowerDirichletDensity` as the `limsup`
and the `liminf` of that ratio, `HasNaturalDensity`, and polar density.

⚠ Mathlib master has `primeIdealZetaSum` and `HasDirichletDensity` in
`NumberTheory/NumberField/DirichletDensity.lean`, namespace `NumberField.Set`. The pin does not
have them. Build them here in that exact shape. When the project pin advances past that file,
delete these two definitions and import Mathlib's; every statement below is unchanged by that.

Basic API:

- the empty set has density `0`;
- the set of all primes has density `1`;
- density is nonnegative and at most `1`;
- a set with a density has equal upper and lower density.

*Prerequisites:* Mathlib `Ideal.absNorm`, `HeightOneSpectrum`, `Filter.limsup`, `Filter.liminf`.

**8A.2 The denominator.** `primeIdealZetaSum univ s / log((s−1)⁻¹) → 1` as `s → 1⁺`. It follows
from the simple pole of Layer 1.7 and the logarithm of Layer 1.4. Hence the definition of 8A.1
is equivalent to Neukirch's, whose denominator is `log((s−1)⁻¹)`. After this theorem no statement
mentions `log((s−1)⁻¹)`.
*Prerequisites:* Layers 1.4, 1.7, 8A.1.

**8A.3 The calculus.** Six statements:

- equal upper and lower density gives the density;
- upper density and lower density are monotone;
- a finite set has density `0`;
- a finite symmetric difference changes none of the three densities;
- a finite disjoint union adds densities;
- the complement has density `1 − δ`.

The fourth statement is why the finitely many ramified primes may be removed from any set at no
cost. Every statement of 8D uses it.

*Prerequisites:* Layers 8A.1, 8A.2.

**8A.4 Degree-one reduction.** The primes with `𝔑𝔭` not prime have Dirichlet density `0`, and so
does any set on which the residue degree exceeds `1`. A density may therefore always be computed
over the degree-one primes.
*Source:* Milne VI 3.2.
*Prerequisites:* Layers 8A.1, 8A.3.

**8A.5 Transfer under contraction.** Let `E/K` be finite and let `S` be a set of primes of `E`.
Assume three things:

- every `𝔭` in a set `T` of primes of `K` has exactly `k` primes of `E` in `S`;
- those primes have residue degree `1` over `K`;
- every prime of `E` in `S` lies over a member of `T`.

Then `HasDirichletDensity S δ` and `HasDirichletDensity T (δ/k)` are equivalent.

This is the lemma that turns a cyclic density into a density for a conjugacy class. It is the
one place where the bookkeeping between primes of `E` and primes of `K` occurs.

*Hypotheses:* the residue-degree-one hypothesis is needed, because it is what makes
`𝔑_E 𝔓 = 𝔑_K 𝔭`. *Nearby false statement:* without it the two Dirichlet series have different
terms and the conclusion fails.

*Prerequisites:* Layers 8A.1, 8A.2, 8A.4.

**8A.6 The carrier.** The equivalence between `HeightOneSpectrum (𝓞 K)` and the nonzero prime
ideals of `𝓞 K`, and transport of 8A.1 to 8A.5 along it. Public statements use
`HeightOneSpectrum`. This lemma is what lets a proof work with ideals.
*Prerequisites:* Mathlib `IsDedekindDomain.HeightOneSpectrum`.

**8A.7 Comparison of the notions.** Natural density implies Dirichlet density with the same
value, by Abel summation. Polar density implies Dirichlet density with the same value.

⚠ Neither converse holds. State the standard counterexample to the first: the set of primes whose
leading decimal digit is `1` has a Dirichlet density and no natural density.

Every theorem in this roadmap names its density. No Lean statement here uses the word "density"
without a qualifier.

*Source:* Milne VI 4.1(a) for the polar case.
*Prerequisites:* Layers 8A.1, 8A.3; Mathlib `AbelSummation`.

**8A.8 Consequences that need no nonvanishing.** Three groups:

- the splitting-density theorem: the primes of `K` that split completely in a finite extension
  `L` have polar density `1/[M:K]`, where `M` is the Galois closure. Also `δ = 1/[L:K]` holds
  exactly when `L/K` is Galois;
- Bauer's theorem, `Spl(L) ⊆ Spl(M) ↔ M ⊆ L` for Galois `M`, and the resulting rigidity: a
  Galois extension is determined by the primes that split completely in it;
- the Frobenius density theorem: the division of `σ` has density `t/#G`, where `t` is the number
  of elements of that division.

*Source:* Milne VI 3.4, 3.6 for the first two; Janusz IV 5.2 for the third, by induction on the
order of `σ`. Janusz IV 5.3 and Milne VI 3.8 give the corollary that the Artin map is surjective
onto `Gal(L/K)` for abelian `L/K`.
*Prerequisites:* Layers 7.1, 8.0, 8A.3, 8A.4, 8A.7.

#### 8B: the cyclotomic case

**8B.1 The cyclotomic Frobenius formula.** For `𝔭 ∤ m`, the Frobenius of `𝔭` in `K(ζ_m)/K` sends
`ζ_m` to `ζ_m^{𝔑𝔭}`.

⚠ This is arithmetic Frobenius and not geometric. *Nearby false statement:* the formula with
`ζ_m ↦ ζ_m^{(𝔑𝔭)^{-1}}` proves every later theorem for `C⁻¹` instead of `C`, and no test detects
it until a numerical example. Layer 8B.5 is that example.

Over `K = ℚ` this is Mathlib's `IsCyclotomicExtension.Rat.galEquivZMod_stabilizer`. Over a
general `K` it is a milestone, stated through the interface of Layer 8.0.

*Prerequisites:* Layer 8.0; Mathlib `IsCyclotomicExtension.Rat.galEquivZMod`,
`galEquivZMod_stabilizer`.

**8B.2 Character orthogonality.** For `σ` in `Gal(K(ζ_m)/K)`,
`(#G)⁻¹ ∑_χ conj (χ σ) χ(τ) = if σ = τ then 1 else 0`. Mathlib has the pieces; the milestone is
the form that 8B.4 uses.
*Prerequisites:* Mathlib character orthogonality for a finite abelian group.

**8B.3 The logarithmic comparison.** For `χ` a character of `Gal(K(ζ_m)/K)`, regarded as an ideal
weight through 8B.1, `log L(χ, s) = ∑_{𝔭 ∤ m} χ(Frob_𝔭) 𝔑𝔭^{-s} + O(1)` as `s → 1⁺`. The error
term is the contribution of the prime powers with `m ≥ 2`, which converges. State that bound as a
theorem.
*Prerequisites:* Layers 1.4, 7.2, 8B.1.

**8B.4 The cyclotomic density theorem.** `L(χ, 1) ≠ 0` for `χ ≠ 1`, by Layer 7.4 with the premise
supplied by Layer 7.3. Together with 8B.2 and 8B.3 this gives: for each `σ ∈ Gal(K(ζ_m)/K)`, the
set `{𝔭 ∤ m ∣ Frob_𝔭 = σ}` has Dirichlet density `1/[K(ζ_m):K]`.
*Prerequisites:* Layers 7.3, 7.4, 8A.1, 8B.1, 8B.2, 8B.3.

**8B.5 Dirichlet's theorem with a density.** The case `K = ℚ`: the primes `p ≡ a (mod q)` have
Dirichlet density `1/φ(q)`. Mathlib's `Nat.infinite_setOf_prime_and_eq_mod` follows. That it
follows is an acceptance criterion.
*Prerequisites:* Layer 8B.4; Mathlib `Nat.infinite_setOf_prime_and_eq_mod`.

#### 8C: the abelian case, by crossing with cyclotomic extensions

Let `L/K` be abelian with group `G`, and let `σ ∈ G` have order `f`. The density of
`{𝔭 ∣ Frob_𝔭 = σ}` is obtained by comparing `L` with an auxiliary cyclotomic extension. Every
object below is a milestone. None of them is called "the crossing lemma".

**8C.1 Admissible auxiliary moduli.** Define: `m` is admissible for `(L/K, σ)` when `m` is
coprime to the primes that ramify in `L`, `L ∩ K(ζ_m) = K`, and `f ∣ [K(ζ_m):K]`. Prove that
admissible `m` exist, and that `[K(ζ_m):K]` can be made divisible by any prescribed integer.
*Prerequisites:* Layer 8.0; Mathlib `IsCyclotomicExtension`.

**8C.2 Linear disjointness and the product decomposition.** For admissible `m`, the restriction
map `Gal(L·K(ζ_m)/K) → Gal(L/K) × Gal(K(ζ_m)/K)` is an isomorphism. The hypothesis
`L ∩ K(ζ_m) = K` is what this uses.
*Prerequisites:* Layer 8C.1; Mathlib `IsGalois`, `IntermediateField`.

**8C.3 Compatibility of Frobenius with restriction.** Let `𝔭` be unramified in the compositum.
Its Frobenius in `L·K(ζ_m)/K` maps to the pair of its Frobenius elements in `L/K` and in
`K(ζ_m)/K`.
*Prerequisites:* Layers 8.0, 8C.2.

**8C.4 The fixed field is cyclotomic over its base.** Let `τ ∈ Gal(K(ζ_m)/K)` with
`f ∣ orderOf τ`. Write `M = L·K(ζ_m)` and `E = M^{⟨(σ,τ)⟩}` under the identification of 8C.2.
Then `⟨(σ,τ)⟩ ∩ Gal(M/K(ζ_m)) = 1`, so `E·K(ζ_m) = M`, and `M/E` is generated by roots of unity.
Layer 8B therefore applies over `E`.

⚠ The hypothesis `f ∣ orderOf τ` is exactly what makes the intersection trivial. *Nearby false
statement:* without it, `⟨(σ,τ)⟩ ∩ Gal(M/K(ζ_m)) = ⟨(σ^{orderOf τ}, 1)⟩`, which is not trivial,
and `E·K(ζ_m)` is a proper subfield of `M`.

*Prerequisites:* Layers 8C.1, 8C.2.

**8C.5 The tagged family of Frobenius fibres.** For each `τ ∈ Gal(K(ζ_m)/K)` with
`f ∣ orderOf τ`, set `S_τ = {𝔭 ∣ Frob_𝔭 = (σ, τ)}` in the compositum. These sets are pairwise
disjoint as `τ` varies, and each contracts into `{𝔭 ∣ Frob_𝔭 = σ}` in `L/K`. Disjointness is
what makes the densities add, so it is a stated lemma.
*Prerequisites:* Layers 8C.2, 8C.3, 8C.4.

**8C.6 The lower bound.** Summing the densities of the sets `S_τ` obtained from 8C.4 and Layer 8B
gives `HasLowerDirichletDensity {𝔭 ∣ Frob_𝔭 = σ} (κ_m / #G)`, where `κ_m ≤ 1` is the proportion
of `τ` with `f ∣ orderOf τ`. Only a lower bound follows, which is why Layer 8A.1 has a `liminf`
predicate.
*Prerequisites:* Layers 8A.3, 8A.5, 8B.4, 8C.5.

**8C.7 The proportion tends to one.** `κ_m → 1` as `m` runs through admissible moduli whose degree
`[K(ζ_m):K]` is divisible by higher and higher powers. This is a statement about `(ℤ/m)ˣ` and
nothing else.
*Prerequisites:* Layer 8C.1.

**8C.8 The abelian theorem.** `HasDirichletDensity {𝔭 ∣ Frob_𝔭 = σ} (1/#G)` for `L/K` abelian. It
follows from 8C.6, 8C.7, and the fact that the densities over all `σ ∈ G` sum to `1`, so a family
of lower bounds that sums to `1` forces equality.
*Prerequisites:* Layers 8A.3, 8C.6, 8C.7.

#### 8D: the general case, by fixed fields

Let `L/K` be finite Galois with group `G`, let `σ ∈ G` have order `f`, let `C` be the conjugacy
class of `σ`, and let `E = L^{⟨σ⟩}`.

**8D.1 `L/E` is cyclic**, of degree `f`, with group `⟨σ⟩`.
*Prerequisites:* Mathlib `IsGalois`, Galois correspondence.

**8D.2 Frobenius in `L/K` against Frobenius in `L/E`.** Let `𝔓` be a prime of `E` unramified in
`L`. State and prove the exact relation between `frobeniusClass E L 𝔓` and
`frobeniusClass K L (𝔓 ∩ 𝓞_K)`. Use the tower compatibility of Layer 8.0.
*Prerequisites:* Layers 8.0, 8D.1.

**8D.3 The relevant primes of `E`.** The set to which 8C is applied is
`{𝔓 ∣ 𝔓 unramified in L, frobeniusClass E L 𝔓 = {σ}}`. Layer 8A.4 lets it be intersected with the
primes of `E` of degree one over `K` at no cost. Say once which set is meant.
*Prerequisites:* Layers 8A.4, 8D.2.

**8D.4 The fibre count.** Each prime `𝔭` of `K` with `frobeniusClass K L 𝔭 = C` has exactly
`#G/(#C · f)` primes of `E` in the set of 8D.3, all of residue degree `1` over `K`. Every prime of
`E` in that set lies over such a `𝔭`.

*Source:* Milne, *Class Field Theory*, VIII 7.4, whose explicit bijections are the plan for the
proof.
*Hypotheses:* the number `#G/(#C · f)` is `#C_G(σ)/f`, which is a positive integer because
`⟨σ⟩ ⊆ C_G(σ)`. State it in that form as well, since the integrality is not visible in the first
form.
*Nearby false statement:* the count is not `#C·f/#G` and not `1`. A consistency check: with the
density `1/f` from 8C over `E`, Layer 8A.5 gives `1/f = k · (#C/#G)`, so `k = #G/(#C·f)`.

⚠ This is where the conjugacy class, the two kinds of prime, and the degree-one condition all
meet. It is the one computation of the layer that needs care.

*Prerequisites:* Layers 8.0, 8D.1, 8D.2, 8D.3.

**8D.5 The Chebotarev density theorem.** Apply 8C over `E` to get density `1/f` for the set of
8D.3. Then apply Layer 8A.5 with `k = #G/(#C · f)`. The result is

`HasDirichletDensity {𝔭 ∣ IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = C} (#C/#G)`

for an arbitrary number field `K`, not only for `K = ℚ`.

*Prerequisites:* Layers 8A.5, 8C.8, 8D.3, 8D.4.

**8D.6 Corollaries.** Derive these three from 8D.5, and do not prove them twice.

- the exact-density form of each statement of 8A.8;
- the density `1/#G` of the primes that split completely in `L`;
- the splitting densities in a non-Galois extension, through its Galois closure.
*Prerequisites:* Layer 8D.5.

#### 8E: equidistribution in ray classes

Once the global class field theory roadmap supplies ray class groups: the primes are
Dirichlet-equidistributed among the classes of any `J^𝔪 ⊇ H ⊇ P^𝔪`, with density
`1/[J^𝔪 : H]`.

Prove it twice. The first proof is analytic, from the partial zeta functions of Layer 1.8 and
Layer 7.4. The second uses 8D.5 and Artin reciprocity. Then prove the two agree class by class.

That agreement is the check that the arithmetic-Frobenius convention of this roadmap and the
reciprocity normalization of the other one point the same way. It is the only place where a
disagreement would be caught.

*Source:* Neukirch VII (13.2); Milne VI 4.8 and VIII 7.2.
*Prerequisites:* Layers 1.8, 7.4, 8D.5; Global class field theory roadmap, its ray-class layer
and its reciprocity layer.

### Layer 9: the prime ideal theorem and natural densities

Layer 8 gives Dirichlet densities. A Dirichlet density does not imply a natural density, so the
natural-density form of Chebotarev is a separate theorem with its own proof. This layer supplies
that proof.

**9.1 Wiener–Ikehara.** If `a : ℕ → ℝ` is nonnegative, if `F(s) = ∑ a n · n^{-s}` converges on
`Re s > 1`, and if `s ↦ F(s) − κ/(s − 1)` extends continuously to `Re s ≥ 1`, then
`∑_{n ≤ x} a n ∼ κ x`.

This is a milestone of this roadmap and not an import. The hypotheses above are what the rest of
the layer may assume, and nothing weaker.

*Source:* Lang XV §§2–3 has a complete proof. PrimeNumberTheoremAnd has it as
`WienerIkeharaTheorem'`, sorry-free; [`PROVENANCE.md`](PROVENANCE.md) records that as prior art
and states the coordination obligation. Mathlib does not have it, at the pin or on master.
*Nearby false statement:* the conclusion fails without nonnegativity. It also fails if the
continuous extension is assumed only on the open half-plane `Re s > 1`.

*Prerequisites:* Mathlib `LSeries`, `Filter.Tendsto`, Fourier analysis on `ℝ`.

**9.2 The ideal von Mangoldt series.** `−ζ_K'/ζ_K (s) = LSeries (idealCoeffOfWeight Λ_K) s` on
`Re s > 1`, with `Λ_K` from Layer 7.6.
*Prerequisites:* Layers 1.4, 7.6.

**9.3 `ψ_K(x) ∼ x`,** where `ψ_K(x) = ∑_{𝔑𝔞 ≤ x} Λ_K(𝔞)`. Apply 9.1 to 9.2 with `κ = 1`. The continuous extension to `Re s ≥ 1` comes from Layer 7.5. The pole of `ζ_K` at `s = 1`
supplies `κ/(s−1)`. The absence of zeros on `Re s = 1` makes the difference continuous up to the
line.
*Prerequisites:* Layers 7.5, 9.1, 9.2.

**9.4 `θ_K(x) ∼ x`,** where `θ_K(x) = ∑_{𝔑𝔭 ≤ x} log 𝔑𝔭`. The difference `ψ_K − θ_K` is the
contribution of the prime powers `𝔭^m` with `m ≥ 2`, which is `O(√x log² x)`. Prove that bound.
*Prerequisites:* Layers 7.6, 9.3.

**9.5 Primes of residue degree above one contribute nothing.** The primes with `𝔑𝔭 = p^f` and
`f ≥ 2` contribute `O(√x log x)` to `θ_K`, so `θ_K` is asymptotically the sum over the
degree-one primes. This is the counting form of Layer 8A.4.
*Prerequisites:* Layer 9.4.

**9.6 The prime ideal theorem.** `π_K(x) ∼ x/log x`, from 9.4 by partial summation.

At `K = ℚ` this is the prime number theorem. The milestone there is an agreement theorem with
PrimeNumberTheoremAnd's `pi_asymp`, and not a second proof of it. Nothing in this roadmap
reproves the rational prime number theorem.

*Source:* Landau; Lang XV Thm 4.
*Prerequisites:* Layers 9.4, 9.5; Mathlib `AbelSummation`, `Nat.primeCounting`.

**9.7 The Tauberian asymptotic for a nontrivial character.** For `χ` a nontrivial character of
`Gal(K(ζ_m)/K)`, regarded as an ideal weight, `∑_{𝔑𝔞 ≤ x} χ(𝔞) Λ_K(𝔞) = o(x)`. Apply 9.1 to
`−L'/L(χ, ·)` with `κ = 0`; the continuous extension to `Re s ≥ 1` is Layer 7.5 for `χ`.

This is the quantitative form of Layer 8B. The Dirichlet-density statement of Layer 8 is not
enough for it.

*Prerequisites:* Layers 7.5, 7.6, 9.1.

**9.8 Counting in a cyclotomic Frobenius fibre.** From 9.7 and orthogonality, Layer 8B.2: for
each `σ ∈ Gal(K(ζ_m)/K)`, `#{𝔭 ∣ 𝔑𝔭 ≤ x, Frob_𝔭 = σ} ∼ (1/[K(ζ_m):K]) · x/log x`.
*Prerequisites:* Layers 8B.2, 9.6, 9.7.

**9.9 Natural-density Chebotarev.** Repeat 8C and 8D with 9.8 in place of 8B, that is with
counting asymptotics in place of lower bounds on Dirichlet densities. The tagged families of 8C.5
give an asymptotic count for the abelian case. The fibre count of 8D.4 is a multiplication by a
constant, which transports it. The result is `π_C(x) ∼ (#C/#G) · x/log x`, and
`HasNaturalDensity {𝔭 ∣ frobeniusClass K L 𝔭 = C} (#C/#G)`.

⚠ This is not a formal consequence of Layer 8. The two arguments share a skeleton and differ in
what is transported through it. The roadmap asks for both, because neither implies the other.

*Prerequisites:* Layers 8C.5, 8D.4, 8D.5, 9.8.

**9.10 Natural-density equidistribution in ray classes.** The same upgrade applied to 8E.
*Prerequisites:* Layers 8E, 9.9.

**9.11 Mertens for `K`.** `∑_{𝔑𝔭 ≤ x} 𝔑𝔭^{-1} = log log x + M_K + o(1)`, and the product form.
Mathlib's Mertens work over `ℚ` is the model for the statement shapes.
*Prerequisites:* Layers 9.4, 9.6.

## Worked examples

Discharge these with the layers, and not at the end. Each one detects an error that the general
statements do not.

- **`dedekindZeta ℚ` against `riemannZeta`** (Layers 1.1, 3.7). The two agree on `Re s > 1`, by
  the bijection between nonzero ideals of `ℤ` and positive integers. The continued function
  satisfies `dedekindZetaC ℚ = riemannZeta` everywhere. This test detects misuse of junk values, and
  an off-by-one at `n = 0`.
- **`ζ_{ℚ(i)} = ζ · L(χ₋₄)`** (Layers 1.1, 4.1, 4.2, then 3.7). First as the coefficient identity
  `#{I ∣ 𝔑I = n} = ∑_{e ∣ n} χ₋₄(e)`, then as an identity of continued functions. This test detects
  the Euler factor at the ramified prime `2`, which is `(1 − 2^{-s})⁻¹` on both sides.
- **The class number formula at `ℚ(√−5)`** (Layers 1.6, 4.3). Here `h = 2`, `w = 2`, `|D| = 20`,
  so `Res_{s=1} ζ_{ℚ(√−5)} = π/√5` and `L(1, χ₋₂₀) = π/√5`. The class number comes from the
  multiquadratic roadmap. This test detects every constant at once: `2^{r₁}`, `(2π)^{r₂}`, `w`, and
  `√|d|`.
- **The root number at `χ₋₄`** (Layer 0.6). Prove `‖rootNumber χ‖ = 1`, and check it at `χ₋₄`,
  where `τ(χ₋₄) = 2i` and `ε = τ/(i√4) = 1`. This test detects the archimedean factor and the
  convention on the power of the conductor.
- **The Δ card, and the direction of the shift** (Layers 0.4, 0.7). The weight-12 cusp form has
  arithmetic centre `6` and analytic centre `1/2`. Its analytic card has degree `2`, conductor
  `1`, `gammaC = {11/2}`, `ε = 1`, and coefficients `τ(n)/n^{11/2}`.

  Check three things. The translation of 0.4 carries the modular forms roadmap's object to this
  card. The gamma parameters shift in the declared direction. Degree, conductor, root number,
  and zero multiplicities are unchanged. A wrong sign in the translation is visible at this
  instance and nowhere else.
- **The Dirichlet card as a degenerate translation** (Layer 0.4). At `w = 0` every field of the
  translation must reduce to `rfl`. This test detects a translation with the shift in the wrong place,
  which would still typecheck.
- **The two Dirichlet densities agree** (Layer 8A.2). For the cyclotomic fibre modulo `5`, both densities
  are `1/4`: the one with the universe denominator, and the one with the denominator
  `log((s−1)⁻¹)`. Obtain the second from the first by the theorem of 8A.2, and not by proving the
  density twice. This test detects a second, competing density predicate.
- **Ramified primes do not matter** (Layer 8A.3). Removing the finitely many primes that ramify in
  `L` does not change the Dirichlet density of a set. This test detects statements whose
  unramifiedness hypothesis is doing unstated work.
- **Chebotarev at `ℚ(ζ₅)/ℚ`** (Layers 8B.5, 8D.5). Here `G ≅ (ℤ/5)ˣ` and every class is a
  singleton, so the primes `p ≡ a (mod 5)` have Dirichlet density `1/4`, and Mathlib's
  `Nat.infinite_setOf_prime_and_eq_mod` follows. Check that the arithmetic Frobenius sends
  `ζ₅` to `ζ₅^p`, so that the class is that of `p mod 5` and not its inverse. Then check that the
  general theorem of 8D.5 gives this statement back through the interface of Layer 8.0. A general
  theorem that does not visibly specialize is not the right general theorem.
- **Natural density at `ℚ(ζ₅)/ℚ`** (Layer 9.9). The same fibre has natural density `1/4`, obtained
  through the counting asymptotic of 9.8. This test detects an attempt to convert one density notion
  into another.
- **The prime ideal theorem at `K = ℚ`** (Layer 9.6). The specialization is
  PrimeNumberTheoremAnd's `pi_asymp`, as an agreement theorem. This test detects an accidental second
  proof of the prime number theorem.
- **Nonvanishing does not overreach at the pole** (Layer 7.5). The trivial character at `s = 1`
  has meromorphic order `−1`. A nontrivial quadratic character has order `0` there. And `ζ_K` has
  order `0` at `1 + it` for `t ≠ 0`. Check that no statement of the layer compares a value at a
  pole.
- **Hecke's equidistribution of Gaussian primes** (Layer 6.6). This test detects an infinity-type
  interface that typechecks and cannot be instantiated.
- **No elliptic-curve card** (Layer 0.7). Check that no continuation predicate and no functional
  equation predicate is asserted for `WeierstrassCurve.LSeries`.

## Ordering

Inside the roadmap:

```
  0 data model ──▶ 1 ideal series ─┬─▶ 2 Poisson, theta ──▶ 3 Dedekind ζ ─┬─▶ 4 special values
                                   │                                      │
                                   │                                      └─▶ 5 Hecke L ──▶ 6 Grossencharacters
                                   │
                                   └─▶ 7 nonvanishing ──▶ 8 densities ──▶ 9 prime counting
```

Across roadmaps:

```
  Local fields, Layer 2 ─────────────▶ 1.5
  Modular forms, Layer 7 ────────────▶ 0.7
  Integral lattices, Layer 1 ────────▶ 2.10, 2.11
  Global class field theory ─────────▶ 5.1, 6.1, 7.7, 8E
  Number field arithmetic ───────────▶ 8.0

  2.6, 2.7, 2.8 ─────────────────────▶ Integral lattices, Layer 8
  3, 5, 7 ───────────────────────────▶ the zeros roadmap
```

Layers 0 and 1 come first. Layer 1 needs Layer 0 only for the place where the Euler-factor data
lives, so the two can be built at the same time.

After that the roadmap has three parts that do not depend on each other:

- **Functional equation**: 2, then 3, then 5, then 6. Layers 5 and 6 use the compatibility
  interfaces of 5.1 and 6.1, so they do not wait for the global class field theory roadmap.
- **Densities**: 7, then 8. These need Layer 1.7 and Layer 1.9 only. Layer 8 uses the
  compatibility interface of 8.0. Every milestone of Layer 8 except 8E is independent of the
  global class field theory roadmap.
- **Special values**: 4, which needs Layer 1 and Mathlib's Dirichlet theory, and Layer 3 for the
  statements about continued functions.

Layer 9 needs Layers 7 and 8. The zeros roadmap starts where Layer 9 ends, and needs Layers 3, 5,
and 7 of this roadmap.

Before writing Layer 5, agree the character interface with the global class field theory roadmap.
Before Layer 8, contact the people working on Chebotarev in Lean. Before Layer 9, contact
PrimeNumberTheoremAnd. [`PROVENANCE.md`](PROVENANCE.md) says who they are and what they have.

## References

- **J. Neukirch, *Algebraic Number Theory*, Springer 1999.** The source for Layers 2 to 6. All
  references are to ch. VII.
  - §§1–2: zeta and Dirichlet L, as a warm-up.
  - §§3–4: the theta transformation (3.6), and the higher-dimensional gamma factor.
  - §5: Dedekind zeta. The partial functional equation is (5.9), the completed one is (5.10),
    continuation and the asymmetric form are (5.11), and the cyclotomic factorization is (5.12).
  - §6: Grossencharacters. Infinity types are (6.7), and the idele dictionary is (6.11) to (6.14).
  - §7: the Hecke theta series. Gauss sums are (7.5) and the transformation is (7.7).
  - §8: Hecke L-functions. The Euler product is (8.1) and the functional equation is (8.5), (8.6).
  - §13: densities. Dirichlet density is (13.1), ray-class density is (13.2), nonvanishing is
    (13.3), Chebotarev is (13.4), and the corollaries are (13.5) to (13.10).
- **S. Lang, *Algebraic Number Theory*, 2nd ed., GTM 110.** The source for the choice of proof
  in Layers 2 and 3, and for Layers 7 to 9.
  - ch. VI §3: ideal counting with an error term, Thm 3.
  - ch. VIII §§1–4: Dirichlet-series lemmas, continuation, densities, and Chebotarev by Deuring's
    reduction, Thm 10.
  - ch. XIII: Hecke's proof. Poisson summation is §1, the theta relation is §2, and the
    functional equation and residues are Thms 1 to 3.
  - ch. XIV: Tate's thesis, which is out of scope here. Its Cor. 3 says the two proofs give the
    same completed function.
  - ch. XV: Ikehara §2, the Tauberian theorem for Dirichlet series §3, nonvanishing Thm 2, the
    case `Re s = 1` Thm 3, the prime ideal theorem Thm 4, and equidistribution Thms 5 and 6.
  - ⚠ Lang's completed zeta uses `Γ(s/2)^{r₁}Γ(s)^{r₂}`. It differs from this roadmap's by
    `2^{r₂}`.
- **G. J. Janusz, *Algebraic Number Fields*, 2nd ed., GSM 7.** The elementary treatment.
  - IV §§1–2: ray classes, ideal counting 2.11 and 2.13, and continuation 2.14.
  - IV §4: L-series, and the density dichotomy 4.8.
  - IV §5: the Frobenius density theorem 5.2, surjectivity of the Artin map 5.3, and
    `L(1,χ) ≠ 0` over `ℚ` without class field theory 5.7.
  - V §10: nonvanishing from class field theory 10.2, ray-class density 10.3, and Chebotarev
    10.4.
- **J. S. Milne, *Class Field Theory*, v4.03.** The plan for Layer 8.
  - VI §2: partial zeta functions 2.8, and continuation 2.9 to 2.12.
  - VI §3: polar density, the splitting-density theorem 3.4, Bauer 3.6, and surjectivity 3.8.
  - VI §4: Dirichlet density 4.1 to 4.8.
  - V 3.23 to 3.26: the statement of Chebotarev, and the remark on natural density.
  - VIII §7, items 7.1 to 7.4: the fibre-counted proof that Layer 8D formalizes.
- **H. Iwaniec and E. Kowalski, *Analytic Number Theory*, AMS Colloquium 53.** Ch. 5 is the source for
  Layer 0: degree, conductor, gamma factor, root number, and the axioms as separate conditions.
- **H. W. Lenstra, Jr. and P. Stevenhagen, "Chebotarëv and his density theorem", Math.
  Intelligencer 18 (1996), 26–37.** The source for the crossing argument of Layer 8C.
- **R. Sharifi, *Algebraic Number Theory*, course notes.** Thm 7.2.2 states the same route.
- **D. Loeffler and M. Stoll, *Formalizing zeta and L-functions in Lean*, arXiv:2503.00959,** Annals
  of Formalized Mathematics 1 (2025) 43–56. The design of Mathlib's `LSeries` stack, which Layers
  2 and 3 continue.
- **D. A. Marcus, *Number Fields*, 2nd ed., Springer 2018.** Ch. 7 is what Mathlib's class
  number formula cites. It is the counting of Layer 1.6, and Milne's source for polar density.
- **L. C. Washington, *Introduction to Cyclotomic Fields*.** The source Mathlib's cyclotomic Galois
  theory follows, and the reference for the generalized Bernoulli numbers of Layer 4.5.
- **W. Narkiewicz, *Elementary and Analytic Theory of Algebraic Numbers*.** The functional
  equation as Milne cites it, and a check on the constants of Layer 5.
