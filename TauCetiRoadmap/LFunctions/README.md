# Roadmap: L-functions — axiomatics, Dedekind zeta, Hecke L-functions, and density theorems

Mathlib has a large L-series library: `Mathlib/NumberTheory/LSeries/` is 21 files and
about 6900 lines. The authors are
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
statements hold at the pinned Mathlib. [`PROVENANCE.md`](PROVENANCE.md) records what was also true
of Mathlib master when the roadmap was written; that is dated ecosystem status, and it does not
belong in the specification.

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
  the explicit formula, and certified lists of zeros are not proved here. They need a theory of
  growth that this roadmap does not build. *Interfaces supplied to other roadmaps* below lists
  the durable exports that a development of them would consume, and this roadmap asserts nothing
  about where that development lives.
- **Tate's thesis.** Adelic Fourier analysis, self-dual measures, Schwartz–Bruhat functions,
  local zeta integrals, and local epsilon factors are not built here. Layer 3 proves the
  functional equation by Hecke's method, and a second derivation is not wanted. The
  factorization `W(χ) = ∏_v W_v(χ)` belongs with those epsilon factors, so it is also out of
  scope.
- **Artin L-functions and Brauer induction.** Layers 5 and 6 are built at the generality that
  Brauer induction needs. No Artin instance and no induction theorem is built here.
- **Compact-group equidistribution.** Layer 7.5 proves the nonvanishing that an
  equidistribution argument needs, and Layer 7.8 proves Hecke's equidistribution of the
  arguments of Gaussian primes. The Weyl criterion for a general compact group is not proved
  here.
- **Effective constants and error terms.** No density statement and no counting statement here
  carries an error term. Effective Chebotarev is not in scope.
- **Elliptic-curve L-functions.** No continuation and no functional equation is asserted for
  `WeierstrassCurve.LSeries`. Layer 0.7 states why.

### Interfaces supplied to other roadmaps

Each item is a theorem of a numbered layer here. Another roadmap consumes it and does not
rebuild it.

- **The arithmetic-to-analytic normalization translation** (Layer 0.4). A consumer working
  with completed L-functions in either normalization reads its gamma shifts, its conductor,
  and its critical line through this translation, and does not restate it.
- **Poisson summation for a general `ZLattice`, and the Gaussian theta transformation**
  (Layers 2.1 to 2.8). For a `ZLattice L` in a finite-dimensional real inner-product space
  and Schwartz `f`, the statement is
  `∑_{v ∈ L} f v = (ZLattice.covolume L)⁻¹ ∑_{w ∈ Lᵛ} 𝓕f w`, where `Lᵛ` is `ZLattice.dual`. The
  shared table below fixes every name that crosses to that roadmap.
- **The analytic L-function record of Layer 0.1, with its dual record** (Layer 0.2). The dual is
  owned here because the functional equation of a non-self-dual record names a second *record* on
  its right-hand side, so the roadmap that owns the record owns its dual.
- **The completed Dedekind zeta function, its polar divisor, and its functional equation**
  (Layer 3), and **completed Hecke L-functions with `‖W(χ)‖ = 1`** (Layers 5 and 6). ⚠ Regularity
  away from the recorded poles is exported as `AnalyticAt`, never as `0 ≤ meromorphicOrderAt`:
  the order condition depends only on the punctured germ, so it constrains no value.
- **The Frobenius class of an unramified prime** (Layer 8.0), constructed from `arithFrobAt`,
  with its restriction and tower theorems.
- **Nonvanishing on `Re s = 1` in meromorphic-order form** (Layer 7.5), with the `3-4-1`
  inequality it rests on (Layer 7.4).
- **The ideal von Mangoldt weight and the logarithmic-derivative Dirichlet series**
  (Layer 7.6, with the series identity of Layer 9.2).
- **The Dirichlet-density calculus** (Layer 8A) and **Chebotarev over a general number field**
  (Layer 8D).
- **Landau's theorem** (Layer 7.1).
- **Wiener–Ikehara** (Layer 9.1).

## How prerequisites are recorded

Every milestone below states its direct prerequisites. Each prerequisite is in exactly one of
five categories:

- **Mathlib** — a named declaration that exists in the Mathlib the repository currently
  builds. Where a declaration exists only on Mathlib master, the milestone says so and
  builds it here in the master shape.
- **Tau Ceti** — a named declaration that already exists in Tau Ceti.
- **Layer n.m** — an earlier milestone of this roadmap.
- **Roadmap X, Layer k** — a named layer of another merged roadmap.
- **R Roadmap X, `decl`** — an exact declaration of a roadmap that is earlier in the merge order.

No other category is permitted. In particular no milestone depends on a branch, on a pull request
that this roadmap does not follow in the merge order, on a future pin, on an external repository,
or on a roadmap that does not yet exist.

The fifth category has exactly two suppliers, and both have a contract section below in which
every consumed declaration is a row. A subject is never a prerequisite of this kind: "the ray
class group" is not one, `RayClassGroup` is; "Frobenius" is not one, `artinSymbol` is.

Two consequences follow.

First, an **arithmetic** object with an owner elsewhere is consumed by name, and never rebuilt.
This roadmap owns the analytic theory of L-functions and nothing else. The modulus, the ray class
group, the ray class character and the Hecke character are Global Class Field Theory's; the
Frobenius class is Number Field Arithmetic's. What Layer 6.1 builds is a *presentation* of a
Hecke character — the coordinates from which the coefficients, the gamma factor, the completion
and the root number are computed — with a named map to the object presented.

Second, Wiener–Ikehara is a milestone of Layer 9 and not an import. It is proved in
PrimeNumberTheoremAnd. That project is neither Mathlib nor Tau Ceti, so it cannot be a
prerequisite. [`PROVENANCE.md`](PROVENANCE.md) records that work as prior art, and states the
coordination obligation.

## Dependencies

| Supplier | Material consumed here | First consuming layer | Category |
|---|---|---:|---|
| [Global class field theory](../GlobalClassFieldTheory/README.md) | the modulus, the ray class group and its class map, the ray class character with induction and primitivity, and the Hecke character with its unitary decomposition | 1.7 | R |
| [Number field arithmetic](../NumberFieldArithmetic/README.md) | the Artin symbol and its two functoriality statements | 8.0 | R |
| [Modular forms](../ModularForms/README.md), Layer 7 | the newform L-series, its Euler product, its completion, its functional equation, and its analytic conductor | 0.7 | Roadmap |
| Mathlib | `LSeries` and its convergence theory, `Gammaℝ`, `Gammaℂ`, `WeakFEPair`, `completedRiemannZeta`, `DirichletCharacter.LFunction`, `dedekindZeta`, `arithFrobAt`, `FractionalIdeal.dual`, `mixedEmbedding` | 0.1 | Mathlib |

**Merge order.** This roadmap follows both R suppliers. Number Field Arithmetic has no supplier of
its own and merges first; Global Class Field Theory follows it. Layers 0 to 4, and the analytic
machinery of Layers 2, 7 and 9, are independent of both and can be implemented in parallel.

## What this roadmap consumes from the Global Class Field Theory roadmap

That roadmap is the canonical owner of the modulus, the ray class group, the ray class character
and the Hecke character. Every use of them here is a row below. Backticked names live in the
namespace `TauCetiRoadmap.GlobalClassFieldTheory`, in
`TauCetiRoadmap/GlobalClassFieldTheory/Suggested.lean`. Nothing crosses the boundary except
through a row, and nothing here is a hypothesis of a Lean statement: the declarations are
imported and applied.

| Consumer here | Supplier layer | Declaration | Type or law relied on |
|---|---|---|---|
| 1.7, and through it 5, 7.5, 8E and 9.11 | 0.1 | `Modulus`, `Modulus.exponent`, the `Dvd` instance, `Modulus.one` | a nonzero integral ideal together with a `Finset` of **real** places, typed as a subtype; `𝔫 ∣ 𝔪` exponentwise on the finite part and by inclusion on the infinite part. ⚠ The two components are separate data: the gamma factor of 5.5 reads `𝔪_∞` and the level of 5.7 reads `𝔪₀` |
| 1.7, 1.8, 5.2, 5.3 | 1.1, 1.2, 1.3 | `Modulus.IsCoprimeTo`, `RayClassGroup`, `idealClass`, `idealClass_mul`, `idealClass_eq_one_iff`, `idealClass_surjective` | `Cl_𝔪 K = J^{𝔪₀} ⧸ P_𝔪`; the class of an integral ideal prime to `𝔪₀`, multiplicative, trivial exactly on the ray-principal ideals, and surjective. ⚠ `IsCoprimeTo` excludes `⊥`, so no law guarded by it constrains a value at the zero ideal |
| 1.7, 5.4, 6.1 | 1.4 | `classMap`, `classMap_idealClass`, `classMap_surjective`, `finiteUnitsMap` | the transition `Cl_𝔪 ↠ Cl_𝔫`, compatible with `idealClass`; and the residue-unit reduction, which is the **units-pullback** and never a ring composition, with witness `3 mod 6 ↦ 1 mod 2` |
| 1.7's finite sum over classes; the finite order of every character of 5.1 | 1.6 | `finite_rayClassGroup` | `Cl_𝔪 K` is finite |
| 5.1 | 3.1 | `RayClassCharacter` | `Cl_𝔪 K →* ℂˣ`, carrying no further data and no further laws |
| 5.1, 5.4, 5.9 | 3.3 | `RayClassCharacter.induced`, `RayClassCharacter.IsPrimitive`, `RayClassCharacter.not_isPrimitive_one` | induction as precomposition with `classMap`, primitivity **against that map**, and the imprimitivity of the trivial character of a nontrivial modulus, which 5.9's card demands and the principal regression reads. ⚠ Primitivity written against a bare function agreeing with `χ` away from a divisor is much weaker and is not what is consumed |
| 6.1, and every milestone of 6.2 to 6.4 | 3.1, 2A.6, 2A.7 | `HeckeCharacter`, `HeckeCharacter.ofRayClassCharacter`, `ofRayClassCharacter_apply`, `RaySubgroup` | `HeckeCharacter K = ContinuousMonoidHom (IdeleClassGroup K) ℂˣ`, the object that 6.1's presentation presents; the pullback of a ray class character along `rayClassQuotient`; and the ray subgroup that `exists_presentation` is stated against |
| 6.1's `shift`, and the shifted poles and functional equation of 6.2 to 6.4 | 3.5 | `HeckeCharacter.shift`, `HeckeCharacter.unitaryPart`, `norm_unitaryPart`, `shift_eq_zero_iff`, `shift_ofRayClassCharacter` | the unique **real** exponent with `|χ| = ‖·‖^σ`. ⚠ Real, not complex: with a complex exponent the decomposition is ambiguous up to `𝔑^{it}` and 6.1's uniqueness theorem is false |

**What Layer 6.1 owns, and what it does not.** It owns the presentation: a unitary ideal weight, a
real shift, the finite character of `(𝓞_K/𝔪₀)ˣ` as a `MulChar`, and unitary archimedean data
whose real parity is supported on `𝔪_∞`, glued by one law over every coprime principal ideal, with
the infinity type derived. It owns `toHeckeCharacter`, the map to the presented character;
`toHeckeCharacter_shift`, which matches the stored shift with the supplier's; `exists_presentation`,
the surjectivity half of Neukirch VII (6.9); and `toHeckeCharacter_ofRayClassCharacter`, which says
that the two roads from a ray class character to an idele-class character are the same road. It
does **not** own a notion of Hecke character, and no theorem here quantifies over one.

## What this roadmap consumes from the Number Field Arithmetic roadmap

Layer 8.0 holds no construction. The Artin symbol is that roadmap's, and so are its two
functoriality statements; what is here is the named transport into the `HeightOneSpectrum`
indexing that the density statements of 8A are written over. `Suggested.lean` carries **closed**
proofs — no `sorry` — for the transport and for both compatibilities, so a change to the
supplier's signature fails the build.

| Consumer here | Supplier layer | Declaration | Type or law relied on |
|---|---|---|---|
| 8.0's `frobeniusClass`, and every density set of 8B to 8E and 9 | 2.3 | `artinSymbol` | for `𝔭` maximal in `𝓞 K` and unramified in `L/K` finite Galois, the conjugacy class in `Gal(L/K)` of the arithmetic Frobenius at any prime over `𝔭`. ⚠ The unramifiedness is an **argument of the definition**: at a ramified prime two lifts differ by inertia, and in a totally ramified abelian extension no class is determined, so a total Frobenius class would put junk into every density set |
| 8C.3, 8D.2, and the `frobenius_restrict` field of the crossing datum | 2.4 | `artinSymbol_map_restrictNormalHom` | `ConjClasses.map (restrictNormalHom E)` carries the symbol of `L/K` to the symbol of `E/K` |
| 8D.2's descent, and the fixed-field argument of 8D | 2.4 | `exists_isArithFrobAt_pow_inertiaDeg` | for `Q` over `𝔓` over `𝔭` and `σ` an arithmetic Frobenius **at that `Q`**, some `τ ∈ Gal(L/E)` with `restrictScalars K τ = σ^{f(𝔓/𝔭)}` is an arithmetic Frobenius at `Q`. ⚠ Prime-relative, and unramified. The class-level and arbitrary-representative forms are false when `E/K` is not normal, and at a ramified `𝔭` no equality of automorphisms exists at all |

The unramifiedness predicate `IsUnramifiedAt` of 8.0 is a **spelling** of the supplier's
hypothesis and not an object: it unfolds to the quantified `Algebra.IsUnramifiedAt` that
`artinSymbol` takes, per that roadmap's Layer 1.2 rule against an `IsUnramifiedIn` wrapper. Its
comparison with `ramificationIdxIn 𝔭 = 1` is stated once, as
`isUnramifiedAt_iff_ramificationIdxIn`.

Two remarks.

**The Frobenius convention is the supplier's.** *Pinned conventions* fixes arithmetic Frobenius
and the Euler factor at a ramified prime, and 8B.1 tests the orientation. That is the same
convention the supplier fixes, which is now a fact about a consumed declaration and no longer a
coincidence between two roadmaps.

**No Galois cohomology, and no reciprocity.** Layer 8 proves Chebotarev through cyclotomic
extensions, and no milestone of it uses the reciprocity law, the existence theorem or a norm
index. What it consumes from Global Class Field Theory is Layers 0 to 3 only: moduli, ray class
groups and characters. Layer 8E is proved analytically from 1.7, 1.8, 7.3 and 7.5.

### Shared layer-DAG table: Integral Lattices ↔ L-functions

The dependency is one-way. This roadmap supplies four declarations of Layer 2 and consumes
nothing from the integral lattices roadmap, so this table is the export list and nothing crosses
between the two roadmaps except through a row of it. The supplier owns each name, and the
consumer cites the name instead of restating the object. The carrier is the bundled analytic
lattice: a submodule of a Euclidean space together with its discreteness and its `IsZLattice`
proof.

Milestone 2.11 owns the trace-to-Euclidean map and compares the analytic dual of an ideal lattice
with the **trace** dual, through `FractionalIdeal.dual`. No dual of an integral bilinear form
appears anywhere in Layers 2.10 to 2.13, which is why nothing travels in the other direction.

| Consumer layer | Supplier layer | Exact object or theorem | Agreed provisional name |
| --- | --- | --- | --- |
| Integral Lattices 8D | L-functions Layer 2, item 1 | the dual of a bundled analytic lattice, characterized by integrality of the inner products | `ZLattice.dual` |
| Integral Lattices 8D | L-functions Layer 2, item 2 | biduality `dual (dual Λ) = Λ` | `ZLattice.dual_dual` |
| Integral Lattices 8D | L-functions Layer 2, item 3 | `covolume Λ * covolume (dual Λ) = 1` | `ZLattice.covolume_mul_covolume_dual` |
| Integral Lattices 8E | L-functions Layer 2, item 8 | `Θ_Λ(1/t) = t^{n/2} (covolume Λ)⁻¹ Θ_{dual Λ}(t)` for real `t > 0` | `ZLattice.gaussianTheta_one_div` |

Poisson summation for a lattice is an L-functions target and is not consumed by the integral
lattices roadmap, so it has no row. Milestones 2.1, 2.2, 2.3, and 2.8 are named so that the
integral lattices roadmap's `GaussianThetaInterface` is produced by them, field for field.

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
| Hecke L conductor | For `χ` primitive of conductor `𝔣₀` the completed level is `|d_K| · 𝔑(𝔣₀)`, so `Λ(χ, s) = (|d_K| 𝔑𝔣₀)^{s/2} L_∞(χ, s) L(χ, s)`, with `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)` and `‖W(χ)‖ = 1`. ⚠ The conjugate at `1 − s` is right for a **finite-order** character, where `χ̄ = χ⁻¹`. Layer 6's shifted characters reflect against the inverse, or against the conjugate at `1 + 2σ − s`; do not carry this row past Layer 5 | Layer 5; Neukirch VII (8.6) |
| Archimedean local characters | The normalized absolute value at an infinite place is `‖x‖_v = (v x)^{mult v}` — Mathlib's `v x` at a real place and its **square** at a complex one — so the product formula is `∏_v ‖x‖_v = \|N_{K/ℚ}(x)\|` with no multiplicities (`InfinitePlace.prod_eq_abs_norm`). The unitary local character is `sgn(x)^{ε_v} ‖x‖_v^{-i t_v}` at a real place and `(z/\|z\|)^{m_v} ‖z‖_v^{-i t_v}` at a complex one — radial exponent **negative** — and the full local character multiplies by `‖x‖_v^{-σ}`. The gamma shifts are `ε_v − i t_v` and `\|m_v\|/2 − i t_v`. Jointly with the compatibility law `χ_unit((α)) · χ_f(α) · ∏_v χ_v(α) = 1` this puts the norm twist `𝔑^{iu}` at parameter `t_v = u` with gamma shift `−iu`, as its L-series `ζ_K(s − iu)` requires; flipping any one of the three conventions breaks that card. Norm twists **of ideals** are always written `𝔑^{it}`; a subscripted `‖·‖_v` always means this normalized archimedean absolute value. `χ_f` is a Mathlib `MulChar` of the residue ring — the character of `(𝓞_K/𝔪₀)ˣ` with its canonical zero extension, which is what Gauss sums read — and real parity `ε_v = 1` occurs only at places of `𝔪_∞` | Layer 6.1; Neukirch VII (6.9), (8.5); Mathlib `NumberTheory/NumberField/InfinitePlace/Basic.lean`, `Mathlib/NumberTheory/MulChar/Basic.lean` |
| Euler factors | At a finite prime `𝔭` of Galois type the factor is `det(1 − Frob_𝔭 · 𝔑𝔭^{-s} ∣ V^{I_𝔭})⁻¹` with **arithmetic** Frobenius. Unqualified "Frobenius" always means arithmetic, that is `x ↦ x^q` on residue fields. This is Mathlib's `IsArithFrobAt` and the local fields roadmap's convention. The geometric form is a translation lemma and never a second convention. For a ray-class character the factor is `(1 − χ(𝔭) 𝔑𝔭^{-s})⁻¹` at `𝔭 ∤ 𝔣₀` and `1` at `𝔭 ∣ 𝔣₀` | Local fields roadmap; Layer 1.5 |
| Normalization of the data record | The record of Layer 0.1 is **analytic-normalized**, and its name says so. Its functional equation reflects in `s ↦ 1 − s`, Dirichlet agreement holds on `Re s > 1`, and the gamma shifts are the analytic ones. It carries no motivic weight. An arithmetic-normalized object reaches these predicates through Layer 0.4, which carries the weight `w` and fixes the shift as `L_arith(s) = L_an(s − w/2)`. Degree, conductor, root number, and zero multiplicities are invariant under that translation, and the invariance is a theorem | Layer 0 |
| Spectral parameters | The gamma data is two multisets: `{μ_j}` for the factors `Gammaℝ(s + μ_j)`, and `{ν_k}` for the factors `Gammaℂ(s + ν_k)`. Then `degree = #μ + 2·#ν`. These are the LMFDB's `mu` and `nu` lists | Layer 0 |
| Frobenius | Public statements use `frobeniusClass`, the Frobenius class constructed in Layer 8.0. There is no second Frobenius here, and no public statement takes a Frobenius interface as a parameter. Underneath sit Mathlib's `arithFrobAt` and `isConj_arithFrobAt` over `Algebra.IsInvariant`. The decomposition group is `MulAction.stabilizer G Q`, because Mathlib has no `decompositionSubgroup` for ideals | `Mathlib/RingTheory/Frobenius.lean`; Layer 8.0 |
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

Verified file by file against the Mathlib the repository currently builds. Names are
exact, and the unusual spellings are Mathlib's. Statements about Mathlib master carry
their check dates in `PROVENANCE.md`.

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

The ray class group itself. Mathlib has no modulus, no group of ideals prime to one, no ray
subgroup, and no quotient. Layer 1.7 consumes all four from Global Class Field Theory before any
character exists; the point of the paragraph is unchanged, namely that no milestone here reads a
ray class character before the group it is a character of exists.

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

The representative is total because that is Mathlib's function type. Milestone 0.3 makes it
analytic away from the recorded poles, so it is an ordinary function there.

⚠ The name states the normalization. The record is analytic-normalized, and it carries no
motivic weight. An arithmetic-normalized object reaches these predicates only through 0.4.

Basic API for the record:

- accessors `degree = #gammaR + 2 · #gammaC`, the gamma factor
  `γ(s) = ∏ Gammaℝ(s + μ) ∏ Gammaℂ(s + ν)`, and the conjugate dual `Λ^∨(s) = conj (Λ (conj s))`;
- `ext` and `Simps` lemmas for the fields;
- the dual record, with conjugate coefficients and conjugate root number, and the involution
  lemma `dual (dual d) = d`;
- the field-by-field agreement predicate, comparing every field and the coefficients away from
  the irrelevant `n = 0` slot; it is the comparison the instance tests of 3.10 and 6.4 state,
  because two cards built from different carriers disagree exactly at that junk slot;
- the twist by a Dirichlet character, and the shift `d(· + a)`, with their effect on degree,
  conductor, gamma data, and polar divisor;
- comparison lemmas that say which of the predicates 0.2 and 0.3 the dual, the twist, and the
  shift inherit;
- the edge cases `degree = 0` and `polarOrder = 0`, each with an example;
- the downstream interface: the zeros roadmap attaches its growth predicates to this record,
  so no field may be removed without a change there.

⚠ `degree` is the **absolute** degree, computed from the gamma data. For a Hecke L-function
over `K` that degree is `[K:ℚ]`, not `1`. Milestone 5.9 defines a separate invariant for the
degree relative to `K`, and never writes it into this field.

*Prerequisites:* Mathlib `LSeries`, `Complex.Gammaℝ`, `Complex.Gammaℂ`, `Finsupp`, `Multiset`.

**0.2 Dirichlet agreement.** `HasDirichletAgreement`: `a 1 = 1`, `0 < degree`, and
`Λ(s) = conductor^{s/2} γ(s) (L a)(s)` for `1 < Re s`. ⚠ The region hypothesis cannot be
dropped. Off it, `L a` is a junk value.

*Prerequisites:* Layer 0.1; Mathlib `LSeries`.

**0.3 Continuation, functional equation, and coefficient growth.** Three further predicates.
They are separate because instances satisfy different subsets, and the model has to record
which.

`HasMeromorphicContinuation` has three fields:

- `Meromorphic Λ`;
- `meromorphicOrderAt Λ p = −polarOrder p` at each recorded pole;
- `AnalyticAt ℂ Λ p` at every `p` with `polarOrder p = 0`.

⚠ The third field is the one that makes the record usable, and the obvious weaker form does
not do it. `meromorphicOrderAt` and `MeromorphicAt` depend only on the punctured germ, so
`0 ≤ meromorphicOrderAt Λ p` says nothing about `Λ p`. Changing a genuine continuation at one
point leaves it meromorphic with every order unchanged. Without analyticity, every statement
below about a value of `Λ` is a statement about an arbitrary number.

`HasFunctionalEquation` has three fields:

- `‖ε‖ = 1`;
- invariance of the polar divisor under `s ↦ 1 − conj s`;
- `Λ(s) = ε · Λ^∨(1 − s)` at every `s` where both `s` and `1 − conj s` are outside the polar
  divisor. With `HasMeromorphicContinuation` both sides are analytic there, so this is an
  equality of ordinary values. At a pole, the corresponding statement is equality of principal
  parts, and it follows from the identity theorem rather than being a field.

`HasAverageCoefficientBound`: `∑_{n ≤ x} ‖a n‖ = O(x^{1+δ})` for every `δ > 0`. This is the
form every instance can prove. Pointwise Ramanujan bounds are specific to an instance and are
not part of the model.

Residues and higher principal parts are theorems about an instance. Milestone 3.4 requires them
for the Dedekind zeta function.

*Prerequisites:* Layer 0.1; Mathlib `Meromorphic`, `meromorphicOrderAt`, `AnalyticAt`,
`Asymptotics.IsBigO`.

**0.4 The two normalizations, and the translation between them.** A second record
`ArithmeticLFunctionData` has the same fields, and its functional equation is centered at
`(w+1)/2` for an integer weight `w`. Both records include the conductor power `N^{s/2}` in the
completed function, which fixes every constant below.

Write `L_ar` and `L_an` for the two Dirichlet series. From `a_an(n) = a_ar(n)/n^{w/2}`,

`L_an(s) = L_ar(s + w/2)`.

Since `Λ_ar(s) = N^{s/2} γ_ar(s) L_ar(s)` and `Λ_an(s) = N^{s/2} γ_an(s) L_an(s)`,

`Λ_ar(s + w/2) = N^{s/2} N^{w/4} γ_ar(s + w/2) L_an(s)`.

So the two completed functions agree after a shift and one constant, and the gamma shifts move
**up**:

`γ_an(s) = γ_ar(s + w/2)`, that is `μ_an = μ_ar + w/2` and `ν_an = ν_ar + w/2`;

`Λ_an(s) = N^{−w/4} · Λ_ar(s + w/2)`.

The structure `NormalizationTranslation` records exactly those equations:

```lean
structure NormalizationTranslation where
  arithmetic : ArithmeticLFunctionData
  analytic   : AnalyticLFunctionData
  weight     : ℤ
  coeff_eq      : ∀ n : ℕ, analytic.a n = arithmetic.a n / (n : ℂ) ^ ((weight : ℂ) / 2)
  gammaR_eq     : analytic.gammaR = arithmetic.gammaR.map (· + (weight : ℂ) / 2)
  gammaC_eq     : analytic.gammaC = arithmetic.gammaC.map (· + (weight : ℂ) / 2)
  completed_eq  : ∀ s : ℂ, analytic.Λ s =
                    ((arithmetic.conductor : ℕ) : ℂ) ^ (-(weight : ℂ) / 4) *
                      arithmetic.Λ (s + (weight : ℂ) / 2)
  polarOrder_eq : ∀ p : ℂ, analytic.polarOrder p = arithmetic.polarOrder (p + (weight : ℂ) / 2)
  conductor_eq  : analytic.conductor = arithmetic.conductor
  rootNumber_eq : analytic.rootNumber = arithmetic.rootNumber
```

Theorems, all of them stated and proved and not merely asserted to exist:

- degree is invariant, and so are the conductor, the root number, and the multiplicity of a
  zero;
- a translation exists for every arithmetic record, and is unique;
- the analytic side satisfies 0.2 and 0.3 exactly when the arithmetic side satisfies their
  translates;
- the **translated functional equation**: the arithmetic equation centered at `(w+1)/2` and the
  analytic equation centered at `1/2` are equivalent under the translation, with the constant
  `N^{−w/4}` cancelling on the two sides.

⚠ Two mandatory tests, because a sign error here is invisible until the second one.

- `w = 0`, a Dirichlet character: every equation reduces to the identity, and the constant
  `N^{−w/4}` is `1`.
- `w = 11`, the discriminant form `Δ`: the arithmetic gamma factor is `Gammaℂ(s)`, so
  `ν_ar = 0` and `ν_an = +11/2`. A `−11/2` here would contradict milestone 0.7.

*Prerequisites:* Layers 0.1, 0.2, 0.3.

**0.5 The zeta instance card.** Degree 1, conductor 1, `gammaR = {0}`, `gammaC = 0`, `ε = 1`,
`Λ = completedRiemannZeta`, and simple poles at `0` and `1`. It satisfies 0.2 and 0.3, with
analyticity away from `{0, 1}` from `differentiableAt_completedZeta`. The functional equation is
`completedRiemannZeta_one_sub`. Every ingredient is complete at the pin, so this card validates
the model on the day the model exists.

*Prerequisites:* Layers 0.1, 0.2, 0.3; Mathlib `completedRiemannZeta`,
`completedRiemannZeta_one_sub`, `riemannZeta_residue_one`, `differentiableAt_completedZeta`.

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

**0.7 The instance ledger.** Each row is discharged in the milestone named.

| Instance | Milestone |
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
arithmetic conductor `N`, and the translation of 0.4 at `w = k − 1`. For `Δ` that gives
analytic `gammaC = {11/2}`, coefficients `τ(n)/n^{11/2}`, and central point `1/2`.

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

Basic API: the value at `0` and at `1`; positivity; `idealCoeff ℚ n = 1` for `n ≠ 0`; the
behaviour under a field isomorphism.

*Prerequisites:* Mathlib `NumberField.dedekindZeta`, `Ideal.absNorm`,
`Ideal.finite_setOf_absNorm_eq`.

**1.2 Ideal weights, and the weighted norm coefficient.** An ideal weight is the algebraic
carrier every character L-function in this roadmap uses:

```lean
structure IdealWeight (K : Type*) [Field K] [NumberField K] where
  toFun : Ideal (𝓞 K) → ℂ
  bad : Set (IsDedekindDomain.HeightOneSpectrum (𝓞 K))
  bad_finite : bad.Finite
  map_mul : ∀ I J, toFun (I * J) = toFun I * toFun J
  norm_eq_one : ∀ 𝔭 ∉ bad, ‖toFun 𝔭.asIdeal‖ = 1
  eq_zero_bad : ∀ 𝔭 ∈ bad, toFun 𝔭.asIdeal = 0
  eq_zero_bot : toFun ⊥ = 0
```

⚠ The zero-ideal law `eq_zero_bot` is a field, not a convention. Multiplicativity admits the
constant-one function, which differs from the trivial weight **only at `⊥`** — a difference no
coprimality-guarded law observes, since coprimality excludes `⊥`. Without the law, two weights
differing only there give two unequal primitive bundles in 6.1 that both induce the same
character, so the uniqueness of primitive reduction is false. With it, the value at `⊥` is
canonical, every constructor discharges it, and the rejection test — the constant-one function
inhabits no `IdealWeight` — has a closed proof.

Define `idealCoeffOfWeight χ : ℕ → ℂ` by `n ↦ ∑_{𝔑𝔞 = n} χ 𝔞`, and set
`L(χ, s) = LSeries (idealCoeffOfWeight χ) s`. The convention for bad primes is fixed here and
used unchanged in Layers 5, 6, and 8: `χ 𝔭 = 0` at a prime of the bad set.

Basic API:

- the trivial weight, with `idealCoeffOfWeight 1 = idealCoeff K`;
- the conjugate weight;
- the **pointwise product** `(χ · ψ)(𝔞) = χ(𝔞) ψ(𝔞)`, with the union of the bad sets;
- the **ideal convolution** `(χ ⋆ ψ)(𝔞) = ∑_{𝔟𝔠 = 𝔞} χ(𝔟) ψ(𝔠)`, which is a different
  operation and is the one 1.3 uses;
- the local restriction `χ` to the powers of one prime, `k ↦ χ(𝔭^k)`, which is what 1.5 uses;
- restriction to a larger bad set;
- the value of `idealCoeffOfWeight χ` at `n = 1`.

⚠ The analytic hypothesis these weights need for continuation is not a field of this structure.
It is `HasCancellation`, milestone 7.1, and keeping the two apart is what stops an analytic
conclusion from being derived from an algebraic hypothesis.

*Prerequisites:* Layer 1.1; Mathlib `Ideal.absNorm`, `Ideal.finite_setOf_absNorm_eq`.

**1.3 Multiplicativity, and what grouping by norm does to each product.** Three statements.

- `idealCoeff K` is multiplicative, by unique factorization of ideals and the coprime case of
  the Chinese remainder theorem.
- `idealCoeffOfWeight χ` is multiplicative when `χ` is completely multiplicative on ideals.
- Grouping by norm carries **ideal convolution** to Dirichlet convolution:
  `idealCoeffOfWeight (χ ⋆ ψ) = idealCoeffOfWeight χ ⍟ idealCoeffOfWeight ψ`.

⚠ Pointwise multiplication of weights does **not** become Dirichlet convolution. Writing
`a_χ(n) = ∑_{𝔑𝔞 = n} χ(𝔞)`, the identity `a_{χ·ψ} = a_χ ⍟ a_ψ` is false in general, because
`(a_χ ⍟ a_ψ)(n) = ∑_{𝔑(𝔟𝔠) = n} χ(𝔟) ψ(𝔠)`, which is `a_{χ ⋆ ψ}(n)`. The third statement is
what lets Mathlib's convolution API apply to objects indexed by ideals, and it is about `⋆`.

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
- the **local identity**, at the level of ideals: for a weight `χ` and each prime `𝔭`, the
  power-series coefficients of `(localPolynomial 𝔭)(T)⁻¹` are the values `χ(𝔭^k)`;
- the **global identity**: a `HasProd` for `∏_𝔭 (localPolynomial 𝔭 (𝔑𝔭^{-s}))⁻¹` equal to
  `LSeries (idealCoeffOfWeight χ) s` in the half-plane of absolute convergence. That theorem is
  where multiplying the local series and grouping by norm is done.

⚠ The local identity is at the level of **ideals**, not of norms. The norm-grouped coefficient
`idealCoeffOfWeight χ (𝔑𝔭^k)` is not the coefficient of the local factor at `𝔭`: it collects
every ideal of that norm. In `ℚ(i)` the prime `5` splits as `𝔭 𝔭̄` with `𝔑𝔭 = 𝔑𝔭̄ = 5`, so
`idealCoeff K 5 = 2`, while the coefficient of `T` in the local factor `(1 − T)⁻¹` at `𝔭` is
`1`. That split-prime example is a mandatory test of this milestone.

The determinant realization `P_𝔭(T) = det(1 − Frob_𝔭 T ∣ V^{I_𝔭})`, with arithmetic Frobenius,
is a stronger predicate on top, for instances that have a Galois representation. It is not part
of the definition.

Basic API:

- the data for the trivial weight, which is the Dedekind zeta case;
- the product of two such data;
- the restriction of the data to a larger bad set;
- the lemma that the degree claim in the docstring follows from the fields.

⚠ Two Euler products, kept apart. The product above is indexed by primes of `𝓞 K`. Grouping the
primes above a rational prime `p` gives a rational local polynomial of degree at most `[K:ℚ]`.
That relation is a theorem and a milestone. It is not automorphic induction, and no milestone
calls it that, because no induction object is built anywhere here.

*Prerequisites:* Layers 0.1, 1.2, 1.4; Local fields roadmap, Layer 2, for the convention at a
ramified prime; Mathlib `Polynomial`, `HasProd`.

**1.6 Counting ideals in a class, with an error term.** For a fixed ideal class `𝔎` of `K`,

`#{I ∈ 𝔎 ∣ 𝔑I ≤ x} = ρ_K x + O(x^{1−1/d})` as `x → ∞`,

with `d = [K:ℚ]` and `ρ_K = 2^{r₁}(2π)^{r₂}R/(w√|d_K|)`.

*Source:* Milne, *Class Field Theory*, VI 2.8, which cites Lang VI §3 Thm 3 for the proof.
Janusz IV 2.11 to 2.13 is the same statement over `ℤ`.
*Hypotheses:* `1 − 1/d` is the exponent this roadmap requires, and the sources supply it. The
implied constant depends on `K` and not on `𝔎`. That independence is part of the statement, and
it is what makes the sum over classes work.
*Nearby false statement:* Mathlib's `Ideal.tendsto_norm_le_and_mk_eq_div_atTop` gives the limit
with no error term, so it does not imply this estimate. ⚠ No claim is made that the exponent is
best possible. Improving it is a generalized divisor problem, and an impossibility statement
would need an omega theorem, which this roadmap does not have and does not need.

⚠ This is the hard analytic milestone of the layer. It strengthens Roblot's asymptotics, so
state it in a form his files could adopt.

*Prerequisites:* Mathlib `Ideal.tendsto_norm_le_and_mk_eq_div_atTop`,
`NumberField.CanonicalEmbedding.FundamentalCone`, `ZLattice.covolume`.

**1.7 Partial zeta functions, on an exact carrier.** Two cases, kept apart, because the sum over
fibres and the residue differ.

*The ordinary case.* For `c` in `ClassGroup (𝓞 K)`, put
`ζ(s, c) = ∑_{[𝔞] = c, 𝔞 integral nonzero} 𝔑𝔞^{-s}`. Then `dedekindZeta K = ∑_c ζ(·, c)`, a
finite sum over `h_K` terms.

*The ray case.* The carrier that Layers 5, 7.5, 8E, and 9.11 read is **consumed**, not built. A
**modulus** `𝔪` is the `Modulus` of Global Class Field Theory 0.1: a nonzero ideal `𝔪₀` of `𝓞 K`
together with a finite set `𝔪_∞` of real places. So are the subgroups `J^{𝔪₀}` and `P^𝔪` of the
group of nonzero fractional ideals, the **ray class group** `Cl_𝔪 = J^{𝔪₀}/P^𝔪`, its finiteness,
the class map `𝔞 ↦ [𝔞]` on the integral ideals prime to `𝔪₀` with its three laws — multiplicative,
trivial exactly on the ray-principal ideals, and surjective — and the transition `Cl_𝔪 ↠ Cl_𝔫`
for `𝔫 ∣ 𝔪`. The contract section names every one of them, with the law relied on.

Those laws are what 5.1's derived ideal weight and 5.6's choice of ray representatives rest on,
and that transition is the map 5.1's primitivity and 5.4's induction are stated against. This
milestone consumes them and states none of them again.

What it adds is one adapter and the analytic content. The adapter is `Modulus.realPlaces`, the
places of `𝔪_∞` read among all infinite places: the supplier types the infinite part by real
places, which is right there, and the archimedean data of Layers 5 and 6 is indexed by
`InfinitePlace K`. It is defined from the supplier's field and has no independent content.

⚠ `P^𝔪` is a subgroup of a group of **fractional** ideals. A condition written only on integral
`α` does not define a subgroup, so a weight required to be trivial on such a set of integral
elements need not factor through `Cl_𝔪`. That is a property of the consumed carrier, and it is
why the carrier is consumed rather than replaced by a congruence condition stated here.

Put `ζ(s, c) = ∑_{[𝔞] = c, 𝔞 integral and prime to 𝔪₀} 𝔑𝔞^{-s}` for `c : Cl_𝔪`.

⚠ That inner sum is infinite, so in Lean it is `tsum` and not `finsum`. Mathlib's `∑ᶠ` sums a
finitely supported function and is the junk value `0` otherwise, and every fibre here contains
infinitely many ideals, so a partial zeta function written with `∑ᶠ` is the constant `0` and 1.8,
1.9, 5.3, 7.5, 8E, and 9.11 become statements about that constant. Prove summability on
`Re s > 1` as its own statement, before the interchange with the finite class sum. The **outer**
sum over `Cl_𝔪` may be a `finsum`, because `Cl_𝔪` is finite. Then

`∑_{c : Cl_𝔪} ζ(·, c) = ζ_K(s) · ∏_{𝔭 ∣ 𝔪₀} (1 − 𝔑𝔭^{-s})`.

⚠ The right-hand side is not `ζ_K`. The fibres omit every ideal divisible by a prime of `𝔪₀`, so
the bad Euler factors are removed. The ordinary case is the specialization `𝔪₀ = 1`, `𝔪_∞ = ∅`,
where the product is empty and `Cl_𝔪` is the ideal class group.

In both cases, and more generally for a finite quotient `Q` of `Cl_𝔪` and a character `χ` of `Q`:

- `L(χ, s) = ∑_{c} χ(c) ζ(s, c)`, a finite sum;
- `ζ(s, c) = (#Q)⁻¹ ∑_χ conj (χ c) L(χ, s)`, by orthogonality of characters. Layer 8 uses this
  second form.

Basic API: the case `#Q = 1`; the behaviour under a surjection `Q ↠ Q'`; the abscissa of
`ζ(·, c)`; the set of integral ideals in one fibre.

*Prerequisites:* Layers 1.1, 1.2; `Modulus`, `Modulus.IsCoprimeTo`, `RayClassGroup`,
`idealClass`, `idealClass_mul`, `idealClass_eq_one_iff`, `idealClass_surjective`,
`finite_rayClassGroup`, `classMap`, `classMap_idealClass` (R *Global Class Field Theory*,
Layers 0.1, 1.1 to 1.4, 1.6); Mathlib `FractionalIdeal`, `Subgroup`, `QuotientGroup`,
`ClassGroup`, character orthogonality for a finite abelian group.

**1.8 The residue of a partial zeta function.** Each `ζ(s, c)` has a simple pole at `s = 1`, and
the residue does not depend on `c`:

`Res_{s=1} ζ(·, c) = Res_{s=1} ζ_K · (#Q)⁻¹ · ∏_{𝔭 ∣ 𝔪₀} (1 − 𝔑𝔭^{-1})`.

⚠ Check the specialization before using it. At `𝔪 = 1` and `Q = ClassGroup (𝓞 K)` the product is
empty and `#Q = h_K`, so the residue is `Res_{s=1} ζ_K / h_K = ρ_K`, the per-class counting
constant of 1.6, and the `h_K` residues sum to `Res_{s=1} ζ_K`. A formula giving `ρ_K/h_K` here
would be wrong by a factor of `h_K`.

Consequence: for `χ ≠ 1` the finite sum `L(χ, s) = ∑_c χ(c) ζ(s, c)` is holomorphic at `s = 1`,
because the equal residues cancel. Milestone 7.3 completes that statement by proving the value
is nonzero.

*Prerequisites:* Layers 1.6, 1.7.

**1.9 Continuation into the strip.** From 1.6, each `ζ(·, c)` of 1.7, and therefore
`dedekindZeta K`, extend analytically to `Re s > 1 − 1/d` except for a simple pole at `s = 1`.
This includes the complex form `(s − 1) ζ_K(s) → Res_{s=1} ζ_K` along `𝓝[≠] 1`, which
strengthens Mathlib's one-sided real limit.

This strip is all that Layers 7 and 8 need. They therefore do not wait for the functional
equation.

*Source:* Janusz IV 2.14; Milne VI 2.9 and 2.12.
*Prerequisites:* Layers 1.6, 1.7, 1.8; Mathlib `LSeriesSummable_of_sum_norm_bigO`,
`LSeries_eq_mul_integral`, `tendsto_sub_one_mul_dedekindZeta_nhdsGT`.

### Layer 2: lattice Poisson summation, theta transformations, and a level

Analysis with no arithmetic content until 2.10. Every item is worth having on its own. The
shared table under *Dependencies* states what the integral lattices roadmap takes and what it
gives.

**2.1 The analytic dual lattice, `ZLattice.dual`.** For a `ZLattice L` in a finite-dimensional
real inner-product space `E`, define `Lᵛ = {w ∣ ∀ v ∈ L, ⟪v, w⟫ ∈ ℤ}` and give it its `ZLattice`
instance. Mathlib's `Submodule.dualSubmodule` is the version with a general bilinear form.
Name the analytic dual and prove the two agree for the inner product.

Basic API: the dual of `ℤⁿ` in `ℝⁿ`; monotonicity, that is `L ≤ M → Mᵛ ≤ Lᵛ`; the dual of a
scaled lattice; the dual under a linear equivalence; the dual of a direct sum.

*Prerequisites:* Mathlib `ZLattice`, `Submodule.dualSubmodule`, `InnerProductSpace`.

**2.2 Biduality, `ZLattice.dual_dual`.** `(Lᵛ)ᵛ = L`.
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

*Hypotheses:* `f` Schwartz is sufficient. The one-dimensional version in Mathlib assumes `rpow`
decay of `f` and of `𝓕f`, which is weaker. State the Schwartz version and record the decay
version as a variant.
*Nearby false statement:* the identity fails without a decay hypothesis. Continuity and
summability of `∑ f v` alone are not enough.

Basic API: the case `L = ℤⁿ`; the case of a scaled lattice; the version with a translation,
which introduces a character; the version for a Schwartz function on a product.

*Prerequisites:* Layers 2.1, 2.3, 2.4, 2.5.

**2.7 The Fourier transform of a Gaussian.** For a positive-definite quadratic form `Q` on `E`,
`𝓕(exp(−π Q)) = (det Q)^{-1/2} exp(−π Q⁻¹)`.

⚠ The square root needs care. Use `InnerProductSpace` and the self-adjoint square root, and not
raw matrices.

*Prerequisites:* Mathlib `Gaussian` Fourier transform in one variable, `IsSelfAdjoint`,
`QuadraticForm.PosDef`.

**2.8 The Gaussian theta transformation, `ZLattice.gaussianTheta_one_div`.** Define
`ZLattice.analyticTheta L t = ∑' v : L, Real.exp (−π t ‖v‖²)` and prove
`Θ_L(1/t) = t^{n/2} (covolume L)⁻¹ Θ_{Lᵛ}(t)` for `t > 0`. The name of the function is fixed
here too, because the integral lattices roadmap states its own targets in terms of it. Prove
also the multi-parameter version, with one scale `t_v` per coordinate block, which 3.3
integrates.

*Source:* Lang XIII §2, where the multi-parameter form reads
`Θ(c, 𝔞) = (c₁⋯c_N)^{-1/2} Θ(c^{-1}, 𝔞')`.

Basic API:

- convergence for `t > 0`;
- the value at `t = 1` for a self-dual lattice;
- the behaviour under scaling of `L`;
- smoothness in `t`;
- the bound `Θ_L(t) − 1 = O(exp(−c t))` as `t → ∞`, which 3.3 uses to split the Mellin
  integral.

*Prerequisites:* Layers 2.6, 2.7.

**2.9 The polynomial-weighted Gaussian transform.** For `P` a harmonic polynomial, homogeneous
of degree `m`, `𝓕(P · exp(−π ‖·‖²)) = i^{−m} P · exp(−π ‖·‖²)`. Deduce the transformation of
`∑_{v ∈ L} P(v) exp(−π t ‖v‖²)`.

Milestone 6.3 needs exactly this. A roadmap that stopped at 2.8 would lack it.

*Hypotheses:* `P` harmonic is necessary. *Nearby false statement:* for a homogeneous `P` that
is not harmonic the transform is not a multiple of `P · exp(−π ‖·‖²)`; already `P(x) = x₁²`
in two variables fails.

*Prerequisites:* Layers 2.6, 2.7; Mathlib harmonic polynomials, or their construction here.

**2.10 A fractional ideal as a lattice.** `mixedEmbedding K '' I` for a fractional ideal `I`,
as a `ZLattice` in the mixed space `ℝ^{r₁} × ℂ^{r₂}`, with the standard real inner product.
*Prerequisites:* Mathlib `NumberField.mixedEmbedding`, `ZLattice`.

**2.11 The trace-to-Euclidean map, and the dual of an ideal lattice.** The trace pairing and the
Euclidean inner product on the mixed space are not the same. The dual of an ideal lattice is
therefore not the embedded trace dual. Introduce the real-linear map `traceToEuclidean` on the
mixed space:

- the identity on each real coordinate;
- `z ↦ 2 · conj z` on each complex coordinate.

Prove the pairing identity

`⟪mixedEmbedding x, traceToEuclidean (mixedEmbedding y)⟫ = Tr_{K/ℚ}(x y)`,

and then the corrected dual theorem: the analytic dual of `mixedEmbedding K '' I` is the image
under `traceToEuclidean` of `mixedEmbedding K '' (I𝔡)⁻¹`, where `𝔡` is the different. This is
the one place in the roadmap where the different appears.

⚠ *Nearby false statement:* the analytic dual is **not** `mixedEmbedding K '' (I𝔡)⁻¹` itself.
Take `K = ℚ(i)` and `I = 𝓞_K`. The mixed lattice is `ℤ[i] ⊂ ℂ`, which is Euclidean self-dual.
The different is `(2i)`, so the trace dual is `(1/2)ℤ[i]`, which is not `ℤ[i]`. Applying
`traceToEuclidean`, that is `z ↦ 2 conj z`, sends `(1/2)ℤ[i]` back to `ℤ[i]`, which is the
Euclidean dual. This calculation is a mandatory test of the milestone.

Also state the determinant of `traceToEuclidean`, and its effect on covolume and on the
multi-parameter Gaussian of 2.8.

⚠ That determinant is `(−4)^{r₂}`, of absolute value `4^{r₂} = 2^{2r₂}`, and **not** `2^{r₂}`. On
one complex coordinate `z ↦ 2 conj z` is `(a, b) ↦ (2a, −2b)` over `ℝ`, of determinant `−4`. The
covolume identity of 2.3 is the check: with `covolume (σI) = 2^{-r₂} √|d_K| 𝔑I` from 2.12 and
`𝔑𝔡 = |d_K|`, the product `covolume(σI) · covolume(dual(σI))` comes out as `|det| · 2^{-2r₂}`, so
`|det| = 4^{r₂}`. At `K = ℚ(i)` the map carries `(1/2)ℤ[i]`, of covolume `1/4`, to `ℤ[i]`, of
covolume `1`.

*Prerequisites:* Layers 2.1, 2.10; Mathlib `FractionalIdeal.dual`,
`RingTheory/DedekindDomain/Different.lean`, `NumberField.mixedEmbedding`.

**2.12 The covolume of an ideal lattice.**
`covolume (mixedEmbedding K '' I) = 2^{-r₂} √|d_K| 𝔑(I)`, and, from 2.3 and the determinant of
2.11, the covolume of its analytic dual.
*Prerequisites:* Layers 2.3, 2.10, 2.11; Mathlib `ZLattice.covolume`, `NumberField.discr`.

**2.13 The theta series of an ideal class.** Combine 2.8 with 2.10 to 2.12, using the corrected
dual of 2.11. Write out the multi-parameter transformation with every power of the
discriminant, every power of the norm, and every power of `2` produced by `traceToEuclidean`.
Milestone 3.3 integrates this exact statement. ⚠ No constant is left unwritten.
*Prerequisites:* Layers 2.8, 2.10, 2.11, 2.12.

**2.14 A functional equation with a level.** Mathlib's `AbstractFuncEq.lean` handles
`f(1/x) = (ε · x^k) • g(x)`. Its TODO asks for the level form `f(N/x) = c • x^k • g(x)` for real
`N > 0`, and proposes the name `FEPairWithLevel`. Build that.

⚠ The structure must carry Mathlib's analytic hypotheses, and not only the symmetry. A shell
around one equation admits pathological `f` and `g`, and then nothing about continuation,
residues, or the functional equation follows. The fields are those of `WeakFEPair`, with the level equation `f(N/x) = (ε · x^k) • g(x)` in
place of `h_feq`:

- the functions `f`, `g`, the weight `k`, the root number `ε`, and the constant terms `f₀`, `g₀`;
- local integrability of `f` and of `g` on `Ioi 0`;
- `0 < k` and `ε ≠ 0`;
- the two decay bounds `(f · − f₀) =O[atTop] (· ^ r)` and `(g · − g₀) =O[atTop] (· ^ r)`, for
  every real `r`.

The milestone is the rescaling theorem, and its output is a genuine Mathlib object:

- from a `FEPairWithLevel` with level `N`, the rescaled functions `F(x) = f(√N · x)` and
  `G(x) = g(√N · x)` form a `WeakFEPair` with the same `k`, the same constant terms, and root
  number `ε · N^{k/2}`;
- every rescaled hypothesis is proved, not assumed: local integrability, the decay bounds, and
  the level-one equation `F(1/x) = (ε N^{k/2} · x^k) • G(x)`;
- when `f₀ = g₀ = 0`, that pair satisfies Mathlib's strong condition, so `Λ` is entire;
- the completed function of the level pair equals `N^{s/2}` times the completed function of the
  rescaled pair, and the residues at `s = 0` and `s = k` carry the corresponding powers of `N`,
  written out;
- at `N = 1` the rescaling is the identity and the produced object is Mathlib's own, not a
  second copy.

`Λ_K` has level `|d_K|` and a Hecke L-function has level `|d_K| 𝔑𝔣₀`, so both instantiate it.

⚠ Mathlib's shape changed after the pin. PR #41329, merged 2026-07-04, replaced the
`StrongFEPair` structure by the predicate `IsStrongFEPair (P : WeakFEPair E) : Prop`. State the
strong conclusion against whichever of the two the project pin has, and against the predicate
once the pin passes that commit.

*Prerequisites:* Mathlib `WeakFEPair`, `StrongFEPair`, `mellin`, `Λ_residue_k`,
`Λ_residue_zero`.

### Layer 3: the Dedekind zeta function

Hecke's proof, following Lang XIII §§1–3 and Neukirch VII §5, on Layers 1 and 2. This is what
the LMFDB's number field pages display.

**3.1 The theta identity, written out.** The identity of 2.13, in the exact form this layer
integrates: every power of `|d_K|`, every norm `𝔑𝔞`, and every power of `2`, including the
`4^{r₂}` from the determinant of `traceToEuclidean`.
⚠ No milestone here contains the phrase "the explicit factor". A constant that is not written is
not specified.
*Prerequisites:* Layer 2.13.

**3.2 The class pairing.** The functional equation permutes ideal classes by
`𝔎 ↦ 𝔎' := [𝔡]𝔎⁻¹`, where `𝔡` is the different. State this as a typed map
`dualClass : ClassGroup (𝓞 K) → ClassGroup (𝓞 K)`. Prove it is an involution, and prove trace
duality induces it, through the corrected dual of 2.11.

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
*Prerequisites:* Layers 1.7, 2.13, 3.1; Mathlib `NumberField.CanonicalEmbedding.FundamentalCone`,
`mellin`, `NumberField.Units.regulator`.

**3.4 Per-class completion and functional equation.** Set
`Z(𝔎, s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ(s, 𝔎)`. Then `Z(𝔎, ·)` is meromorphic on
`ℂ` and analytic away from `{0, 1}`, with `meromorphicOrderAt (Z 𝔎) 0 = −1`,
`meromorphicOrderAt (Z 𝔎) 1 = −1`, residues `∓ 2^{r₁+r₂} R/w`, and
`Z(𝔎, s) = Z(dualClass 𝔎, 1 − s)`.

The completed constants come out as displayed because `Gammaℝ(1) = 1` and `Gammaℂ(1) = 1/π`,
which absorb the factor `(2π)^{r₂}/√|d_K|` of the uncompleted residue.

*Source:* Neukirch VII (5.9), (5.10).
*Prerequisites:* Layers 1.7, 2.14, 3.2, 3.3.

**3.5 Uniqueness of the continuation.** Two functions that agree on `Re s > 1`, are meromorphic
on `ℂ`, and are analytic on `ℂ ∖ {0, 1}` agree on `ℂ ∖ {0, 1}`, by the identity theorem on that
connected set.

⚠ The analyticity hypothesis cannot be dropped. Meromorphy alone constrains only punctured
germs: given a genuine continuation `Z`, change its value at one point `p` outside the
half-plane and outside `{0, 1}`. The result is still meromorphic with the same orders
everywhere, and it disagrees with `Z` at `p`. That is why 0.3 has an analyticity field.

Without this milestone an existentially stated continuation determines nothing, so 3.6 and 3.7
are definitions and not choices.

*Prerequisites:* Mathlib `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq`, `Meromorphic`.

**3.6 The completed Dedekind zeta function.** `completedDedekindZeta K`, written `Λ_K`, a named
definition equal to `∑_𝔎 Z(𝔎, ·)`. It is meromorphic, analytic on `ℂ ∖ {0, 1}`, has simple poles
at `0` and `1` and nowhere else, residues `∓ 2^{r₁+r₂} hR/w`, the functional equation
`Λ_K(s) = Λ_K(1 − s)` on `ℂ ∖ {0, 1}`, and
`Λ_K(s) = |d_K|^{s/2} Gammaℝ(s)^{r₁} Gammaℂ(s)^{r₂} ζ_K(s)` on `Re s > 1`. Compatibility with
`Λ_residue_k` is a theorem.

Basic API: the value at `K = ℚ`, which must be `completedRiemannZeta`; the behaviour under a
field isomorphism; the self-duality; the relation to `dedekindZetaC` of 3.7.

*Prerequisites:* Layers 3.4, 3.5.

**3.7 The continued zeta function.** `dedekindZetaC K : ℂ → ℂ`, analytic on `ℂ ∖ {1}`, equal
to `dedekindZeta K` on `Re s > 1`, with a simple pole at `1` of residue `dedekindZeta_residue K`.
That residue is now a genuine complex residue, which subsumes Mathlib's one-sided real limit.

Prove `dedekindZetaC ℚ = riemannZeta` everywhere. That equation is why the continued object
leaves this layer, and not the raw `LSeries`. It is false for `dedekindZeta ℚ`, whose values off
the half-plane are the junk value `0`. Coordinate the name with the TODO in `DedekindZeta.lean`.

*Prerequisites:* Layers 1.9, 3.5, 3.6.

**3.8 Exact orders at the trivial zeros.** Give `meromorphicOrderAt (dedekindZetaC K)` at `s = 0`
and at each `s = −m` as a formula in `r₁`, `r₂`, and the parity of `m`. Derive them from the
poles of `Gammaℝ` and `Gammaℂ` and the order arithmetic of `meromorphicOrderAt`. The order at
`s = 0` is `r₁ + r₂ − 1`.

⚠ These are multiplicities, not existence statements, and they use `meromorphicOrderAt`. A
pointwise claim `ζ_K(−2) = 0` is meaningful only because 0.3 makes the representative analytic
there; state the order in any case, since that is what the functional equation determines.

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

*Prerequisites:* Layers 1.9, 4.2.

**4.4 The cyclotomic factorization.** Write `χ*` for the primitive character of conductor `f_χ`
that induces `χ`. Then

`ζ_{ℚ(ζₙ)}(s) = ∏_{χ mod n} L(χ*, s)`,

the product over all Dirichlet characters modulo `n`, equivalently over the characters of
`Gal(ℚ(ζₙ)/ℚ) ≅ (ℤ/n)ˣ`. **There is no correction factor.** The primitive L-functions already
carry exactly the local factors that `ζ_{ℚ(ζₙ)}` has.

The correction appears only if the product is written with the imprimitive level-`n` functions.
Since `L(χ, s) = L(χ*, s) ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p) p^{-s})`, that form reads

`ζ_{ℚ(ζₙ)}(s) = ∏_{χ mod n} L(χ, s) · ∏_{χ mod n} ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p) p^{-s})⁻¹`,

with the product **inverted**. Use one of the two forms and not a mixture.

*Source:* Neukirch VII (5.12).
*Hypotheses:* `n ≥ 1`; for `n ≡ 2 mod 4` the field `ℚ(ζₙ)` equals `ℚ(ζ_{n/2})` and the character
group is the one modulo `n/2`, so state which `n` is meant.
*Nearby false statement:* multiplying the primitive product by
`∏_χ ∏_{p ∣ n, p ∤ f_χ} (1 − χ*(p) p^{-s})` rather than dividing by it is false already at
`n = 4`. There the two characters are trivial and `χ₋₄`, both primitive except for the trivial
one whose primitive form is `ζ`, and the extra factor would give
`ζ_{ℚ(i)}(s) = ζ(s) L(s, χ₋₄) (1 − 2^{-s})`, contradicting 4.2. The case `n = 4` is a mandatory
test of this milestone.

This identity is also how `L(1, χ) ≠ 0` is proved over `ℚ` without class field theory, which
milestone 7.3 cites.

*Prerequisites:* Layers 1.4, 3.7; Mathlib `LFunction_changeLevel`,
`intermediateFieldEquivSubgroupChar`, `IsCyclotomicExtension.Rat.galEquivZMod`.

**4.5 Generalized Bernoulli numbers and values at nonpositive integers.** Define `B_{k,χ}` for
`χ` modulo `N` by `∑_{a=1}^{N} χ(a) t e^{at}/(e^{Nt} − 1) = ∑_k B_{k,χ} t^k/k!`. Prove
`L(1 − k, χ) = −B_{k,χ}/k` for `k ≥ 1`.

*Hypotheses:* `χ` is nontrivial. The trivial character has a pole at `s = 1`, and its values at
the nonpositive integers are Riemann's, which `HurwitzZetaValues.lean` already has. Also
`L(1 − k, χ) = 0` when `χ(−1) ≠ (−1)^k`.

This milestone discharges the TODO in `HurwitzZetaValues.lean`.

Basic API: `B_{k,χ}` for the trivial character, in terms of the ordinary Bernoulli numbers; the
recurrence; the value `B_{1,χ}` for odd `χ`; the behaviour under induction from the conductor.

*Prerequisites:* Mathlib `bernoulli`, `HurwitzZetaValues`, `DirichletCharacter.LFunction`.

**4.6 `L(1, χ₋₄) = π/4`.** Connect it to Mathlib's `Real.tendsto_sum_pi_div_four`. This is the
smallest check that 4.3 and 4.5 agree with something known independently.
*Prerequisites:* Layers 4.3, 4.5; Mathlib `Real.tendsto_sum_pi_div_four`.

### Layer 5: Hecke L-functions of finite-order ray-class characters

The full analytic theory of the L-function of a finite-order Hecke character.

**5.1 The ray-class character, consumed.** A `RayClassCharacter 𝔪` is a homomorphism

`Cl_𝔪 K → ℂˣ`,

for the ray class group of Global Class Field Theory 1.2. The type, the quotient it is a
character of, induction and primitivity are all that roadmap's, by the contract above; **nothing
in this milestone is a construction**. It carries no further data and no further laws, because it
does not need any: on that quotient the operations 5.2 to 5.9 use are the operations of a group of
characters. What this milestone owns is the *derived* ideal weight below and the local signs, which
are analytic data and have no meaning in the supplier.

- the **trivial** character is `1`;
- the **product** of two characters of the same modulus is `χ · ψ`;
- the **conjugate** is `χ⁻¹`, which agrees with the pointwise complex conjugate because the ray
  class group is finite, by the consumed `finite_rayClassGroup`;
- **induction** from a divisor `𝔫` of `𝔪` is the consumed `RayClassCharacter.induced`, which is
  composition with the consumed `classMap`;
- **primitivity** is the consumed `RayClassCharacter.IsPrimitive`, stated against that same map;
- the **local component** at a real place is the sign of 5.5, and is owned here.

The ideal weight of 1.2 is then *derived*: `χ(𝔞)` is the character of the ray class of `𝔞` for
`𝔞` prime to `𝔪₀`, and `0` otherwise. Triviality on the ray subgroup and finite order become
theorems about that derived weight rather than fields on an arbitrary function.

Two characters over `ℚ` are **constructed by name**, with value specifications against Layer 4's
`χ₄` and the quadratic residue symbol mod `5`, and with primitivity as named theorems: the odd
character of modulus `(4)∞` and the even quadratic character of modulus `(5)`. They exist so
that the acceptance tests of 6.4 quantify over nothing: a test of the shape "for every primitive
character of this modulus …" is true when the carrier accidentally empties, and only a
constructed instance fails then. ⚠ The trivial character of any nontrivial modulus is
**imprimitive** — induced from the trivial modulus along the projection — and that is a named
theorem, because 5.9's card demands primitivity and the principal regression reads it.

⚠ The finite part `𝔪₀` and the infinite part `𝔪_∞` are separate data. Neither may be dropped:
the gamma factor of 5.5 reads `𝔪_∞`, and the level of 5.7 reads `𝔪₀`.

⚠ *Nearby false statement:* an ideal weight of finite order with a finite bad set need not come
from a ray-class character. The group `J^{𝔪₀}` is free, so roots of unity may be assigned to its
generators arbitrarily, and Gauss sums and the functional equation do not follow. That is what
carrying the quotient rules out, and it is why a structure whose only congruence field is a
condition on *integral* `α ≡ 1 mod 𝔪₀` is not enough: such a condition is not a statement about a
subgroup of the group of fractional ideals, so a weight satisfying it need not factor through the
quotient at all.

⚠ *Nearby false statement:* primitivity written as "there is no function `ψ` agreeing with `χ`
away from a divisor" is much weaker than primitivity, because a bare function is not required to
be a character. State it against the projection of 1.7.

*Prerequisites:* Layers 1.2, 1.7; `RayClassCharacter`, `RayClassCharacter.induced`,
`RayClassCharacter.IsPrimitive`, `RayClassCharacter.not_isPrimitive_one`, `finite_rayClassGroup`
(R *Global Class Field Theory*, Layers 1.6, 3.1, 3.3); Mathlib `Ideal`,
`NumberField.InfinitePlace`, `MonoidHom`.

**5.2 The L-series and its Euler-factor data.** `L(χ, s) = LSeries (idealCoeffOfWeight χ) s`,
with the convention `χ 𝔞 = 0` when `𝔞` is not coprime to `𝔪₀`. The Euler product is
`∏_{𝔭 ∤ 𝔪₀} (1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` on `Re s > 1`, and the abscissa is `1`. Construct the
`EulerFactorData` of 1.5 for `χ`, with `localPolynomial 𝔭 = 1 − χ(𝔭) T` and
`bad = {𝔭 ∣ 𝔪₀}`, and prove the local and global identities of 1.5 for it. That instance lives
here and not in Layer 1, because it needs the character.
*Source:* Neukirch VII (8.1).
*Prerequisites:* Layers 1.2, 1.4, 1.5, 5.1.

**5.3 Continuation into the strip, and the pole.** From 1.7 and 1.9, `L(χ, ·)` extends to
`Re s > 1 − 1/d`. For `χ ≠ 1` it is holomorphic there, because the equal residues of 1.8 cancel.
For `χ = 1` it has a simple pole at `s = 1`. Write out the finitely many Euler factors at
`𝔭 ∣ 𝔪₀` that separate `L(1, ·)` from `ζ_K`, in the shape of Mathlib's
`LFunctionTrivChar_eq_mul_riemannZeta`.
*Prerequisites:* Layers 1.7, 1.8, 1.9, 5.2.

**5.4 Induction and the imprimitive correction.** For `χ` modulo `𝔪` induced from a primitive
`χ*` modulo `𝔣₀`,
`L(χ, s) = L(χ*, s) ∏_{𝔭 ∣ 𝔪₀, 𝔭 ∤ 𝔣₀} (1 − χ*(𝔭)𝔑𝔭^{-s})`, a finite product written out. The
functional equation is asserted for primitive characters only, as in Mathlib's `IsPrimitive`
discipline.
*Prerequisites:* Layers 5.1, 5.2.

**5.5 The archimedean parity data and the gamma factor.** At a real place `v`, the local
component of a finite-order character is trivial on the connected subgroup of positive elements.
Its parity is therefore the single sign `χ_v(−1) ∈ {±1}`. Prove that `χ_v(−1) = −1` holds exactly
when `v ∈ 𝔪_∞`. Then the gamma factor is `Gammaℝ(s)` at a real place with `χ_v(−1) = 1`,
`Gammaℝ(s + 1)` at a real place with `χ_v(−1) = −1`, and `Gammaℂ(s)` at each complex place. So
`gammaR` has `r₁` entries, with `#𝔪_∞` of them equal to `1`, and `gammaC` has `r₂` entries.

⚠ *Nearby false statement:* "the character is nontrivial on the positive elements at `v`" never
holds for a finite-order character, because `ℝ_{>0}` is connected and divisible. Parity is
detected at `−1`, and nowhere else.

*Prerequisites:* Layers 0.1, 5.1.

**5.6 Gauss sums.** Define `τ(χ)` for a primitive character and prove `|τ(χ)| = √𝔑(𝔣₀)`.

⚠ Neukirch's device of ideal numbers, his `K̂^*`, is not canonical. Define the Gauss sum against
explicit representatives of the ray classes, using the triviality field of 5.1 to prove the value
does not depend on the choice. The check that this was done correctly is that `W(χ)` in 5.8 does
not depend on the choices.

*Source:* Neukirch VII (6.4), (7.5).
*Hypotheses:* `χ` primitive. *Nearby false statement:* for imprimitive `χ` the modulus of the
Gauss sum is smaller, and `|τ(χ)| = √𝔑(𝔪₀)` is false.
*Prerequisites:* Layer 5.1.

**5.7 The completed L-function.**
`Λ(χ, s) = (|d_K| 𝔑𝔣₀)^{s/2} L_∞(χ, s) L(χ, s)`, with `L_∞` the gamma factor of 5.5, built as an
instance of the level frame of 2.14 at level `|d_K| 𝔑𝔣₀`. It is entire for `χ ≠ 1`. Prove also
the per-class functional equations, which carry the `[𝔣₀𝔡]`-twist exactly as 3.2 carries `[𝔡]`.
*Source:* the theta method of Layer 2 with `χ`-weights; Neukirch VII §7 (7.6), (7.7).
*Prerequisites:* Layers 2.13, 2.14, 3.2, 5.2, 5.5, 5.6.

**5.8 The functional equation and the root number.**
`Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)`, with `W(χ) = τ(χ)/(i^{#𝔪_∞} √𝔑𝔣₀)` written out, and
`‖W(χ)‖ = 1` proved from 5.6.
*Source:* Neukirch VII (8.5), (8.6), restricted to infinity type `(p, 0)` with `p ∈ {0,1}^{r₁}`.
*Prerequisites:* Layers 5.6, 5.7.

**5.9 The instance card, and the two degrees.** Build the card as a **named record** — the
finite-order comparison of 6.4 equates a record with it, and cannot cite an anonymous
field-by-field target: derived-weight coefficients, the level `|d_K| 𝔑𝔪₀` of 5.7, real gamma
shifts `1` exactly at the places of `𝔪_∞`, complex shifts `0`, the Gauss-sum root number of
5.6, the completion of 5.8, and a polar divisor supported at `{0, 1}` exactly for the trivial
character, which is primitive only at the trivial modulus, where the card is the `ζ_K` card of
3.10. ⚠ The primitivity proof is an argument of the **definition**: the card's `conductor` is an
arithmetic invariant with no later predicate to certify it, and at an imprimitive character the
level formula records the presentation modulus — for the principal character at `𝔪₀ = (p)`,
`|d_K| · 𝔑𝔭` where the arithmetic conductor is `|d_K|` — while the presented series carries a
removed Euler factor besides. No card records a presentation modulus as a conductor; an
imprimitive character owns the presented L-function of 5.3 and the Euler-factor correction of
5.4, and no card. The principal regression states exactly that pair: the trivial character of a
nontrivial modulus is imprimitive (a named 5.1 theorem), and its presented series is `ζ_K` times
the removed factors. The card has
`degree = [K:ℚ]`, because `gammaR` has `r₁` entries and `gammaC` has `r₂`, and that is the degree
of the L-series over `ℕ`.

⚠ The familiar phrase "a Hecke character has degree one" refers to a different invariant. Define
it separately, as `relativeDegree = 1`, and never write it into `AnalyticLFunctionData.degree`.
The relation between the two is the grouping theorem of 1.5: the primes above one rational prime
`p` combine into a rational local polynomial of degree at most `[K:ℚ]`, which is the absolute
degree. A record with two values of the same field is not a record.

At `K = ℚ` the construction recovers Mathlib's Dirichlet objects exactly: the two completed
functions are equal, and not merely the two functional equations. That is an acceptance
criterion.

*Prerequisites:* Layers 0.1, 1.5, 5.7, 5.8.

### Layer 6: Grossencharacters

The infinite-order theory, which the LMFDB calls Hecke characters. It completes the family of
degree-one instances over `K`.

**6.1 The presentation of a Hecke character.** The Hecke character itself is the consumed
`HeckeCharacter K` of Global Class Field Theory 3.1, a continuous character of the idele class
group. What is built here is its **presentation** in the sense of Neukirch VII (6.9): the
coordinates from which the coefficients of 6.2, the gamma factor, the completion and the root
number are computed. `toHeckeCharacter` is the map to the object presented,
`toHeckeCharacter_shift` matches the stored shift with the supplier's `HeckeCharacter.shift` of
3.5, `exists_presentation` is the surjectivity half of (6.9), and
`toHeckeCharacter_ofRayClassCharacter` says that the embedding of 5.1 presents the supplier's own
pullback, so that Layer 5 is the finite-order case of this layer and not a parallel theory.

⚠ A presentation is not a second carrier. No milestone of Layers 6.2 to 6.4 quantifies over a
notion of Hecke character defined here; each is a statement about the presented character, reached
through `toHeckeCharacter`. Following Neukirch VII (6.9): First fix the **normalized absolute value** at an
infinite place, `‖x‖_v = (v x)^{mult v}` — the plain `v x` of Mathlib's `InfinitePlace` at a
real place and its **square** at a complex one — so that the product formula reads
`∏_v ‖x‖_v = |N_{K/ℚ}(x)|` with no multiplicities (`InfinitePlace.prod_eq_abs_norm`). Every
archimedean radial exponent in this layer is an exponent of this function; name it once and
prove the real and complex evaluation lemmas and the product formula in this form.

A `Grossencharacter 𝔪` carries:

- the **unitary** ideal weight `χ_unit` in the sense of 1.2, with `bad = {𝔭 ∣ 𝔭 ∣ 𝔪₀}`;
- a **real** exponent `σ`, constrained by nothing else;
- the **finite character** `χ_f` of `(𝓞_K/𝔪₀)ˣ`, carried as a Mathlib `MulChar` of the residue
  ring — unit-valued on the units and **zero off them**, so the carrier holds exactly the unit
  character together with its canonical zero extension, and no unconstrained values;
- the **unitary archimedean data**: a parity `ε_v ∈ {0, 1}` at each real place, an angular
  exponent `m_v ∈ ℤ` at each complex place, and a real `t_v` at every place;
- the **parity support law**: `ε_v = 1` only at places of `𝔪_∞`. An imprimitive presentation
  may carry extra places of `𝔪_∞` with `ε_v = 0`;
- the **compatibility law**, on **every** principal ideal prime to `𝔪₀`:
  `χ_unit((α)) · χ_f(α) · ∏_v χ_v^{unit}(α) = 1`.

⚠ The `MulChar` carrier is not a spelling preference. A bare multiplicative map to `ℂ` carries
nonunit values that no law observes, so the equality of primitive bundles below would compare
junk; and the Gauss sums of 5.6 and 6.2 range over the residue ring, where they must read the
**canonical zero extension** — any other extension changes the sum.

⚠ The parity support law is what makes the infinite part of the modulus visible to the carrier
at all. Without it every field reads only `𝔪₀`, so every term is induced from the modulus with
the same finite part and empty infinite part, nothing with `𝔪_∞ ≠ ∅` is primitive, and the odd
characters break: the primitive odd character modulo `4` over `ℚ` could satisfy no primitivity
hypothesis at its Layer 5 modulus `(4)∞`, and its Layer 6 conductor would silently drop the
real place whose gamma factor `Γ_ℝ(s + 1)` it owns.

Three things are then *defined* and not carried, and that is the point of the layout.

The **unitary archimedean local character** is `sgn(x)^{ε_v} ‖x‖_v^{-i t_v}` at a real place and
`(z/|z|)^{m_v} ‖z‖_v^{-i t_v}` at a complex one. Both have absolute value `1`. Prove that each is
a continuous homomorphism into `ℂˣ`.

⚠ The radial exponent carries a **negative** sign, and it is not a free choice: it is what makes
the compatibility law above coherent with the gamma shifts of 6.2. The witness is `K = ℚ` and
the unitary norm twist `χ_unit((n)) = n^{iu}`: the law gives `n^{iu} · n^{-it} = 1`, so `t = u`,
and 6.2's shift `−it` is then `−iu`, matching the completion `Γ_ℝ(s − iu) ζ(s − iu)` of the
L-series `ζ(s − iu)`. With the positive sign the same two conventions produce `Γ_ℝ(s + iu)`,
whose product with `ζ(s − iu)` has no pole at `s = iu` and infinitely many poles on `Re s < 0`,
so the polar divisor and the continuation predicate of 6.4's norm-twist card would both be
false. At a complex place the same witness over `ℚ(i)` detects the multiplicity: with the
un-normalized `v x` in the radial part, the law forces `t = 2u` and the gamma shift comes out
`−2iu` against the `ζ_{ℚ(i)}(s − iu)` the series is.

The **full quasicharacter** is `χ(𝔞) = χ_unit(𝔞) · 𝔑𝔞^{σ}`, and the **full local character** is
the unitary one times `‖x‖_v^{-σ}` — the normalized absolute value again, so the radial factor
at a complex place is `(v x)^{-2σ}`. Define it; it is what the algebraic comparison of 6.3
evaluates.

**Admissibility is a theorem, not a field**: at a unit `u` the principal ideal is `(1)`, so the
law collapses to `χ_f(u) · ∏_v χ_v^{unit}(u) = 1`, and for `u ≡ 1 mod 𝔪₀` to
`∏_v χ_v^{unit}(u) = 1` — the invariance 6.3's sum over unit orbits reads. Prove both forms.

The **algebraic infinity type** `(p_v, p̄_v)` is a *predicate* over the carrier: the statement
that the full archimedean character is `x ↦ x^{-p_v}` on the positive reals at a real place and
`z ↦ z^{-p_v} z̄^{-p̄_v}` at a complex place. The placewise dictionary with the stored data is:
at a real place `σ = p_v` (and `p̄_v = 0` by convention); at a complex place
`2σ = p_v + p̄_v` and `m_v = p̄_v − p_v`.

⚠ The full weight is **not** an `IdealWeight`, and a structure that stores it as one is
inconsistent for every `σ ≠ 0`. `IdealWeight.norm_eq_one` forces `‖χ(𝔭)‖ = 1` at every prime off
the finite bad set; with the decomposition that forces `𝔑𝔭^{σ} = 1` at all but finitely many
primes, hence `σ = 0`.

⚠ **State compatibility entirely on the unitary components, or entirely on the full ones — never
mixed.** That is the same inconsistency one level down, and it is easy to write by accident. A law
whose finite factor carries `𝔑^{σ}` while its archimedean factors have absolute value `1` forces
`σ = 0`, so the carrier contains no character with a nonzero real shift at all. The witness is
`K = ℚ`, modulus `1`, `χ = 𝔑^{σ}`: for a positive integer `n` the mixed law reads
`χ_unit((n)) · n^{σ} · n^{-i t} = 1`, and the first and third factors have modulus `1`, so
`n^{σ} = 1` for every `n`.

⚠ **The finite character is a field, and the law quantifies over every coprime `α`** — both
halves are load-bearing, and each has its own witness. Without `χ_f`, the law over all coprime
`α` empties the carrier of every ramified character: for a nontrivial even Dirichlet character
`χ` mod `5` and `α = 2` it reads `χ(2) · 1 = 1`, so only characters with trivial finite part
survive and the finite-order comparisons of 6.2 and 6.4 quantify over nothing. Restricting a
`χ_f`-free law to `α ≡ 1 mod^× 𝔪` instead admits a non-character: over `ℚ` with modulus `∞`,
the pair with trivial weight and parity `ε = 1` satisfies the restricted law, which only sees
positive `α`, yet no idele-class character has trivial finite part and sign component `sgn`, and
the would-be completion `Γ_ℝ(s+1) ζ(s)` satisfies no clean functional equation. The law with
`χ_f` over all coprime `α` admits every ray-class character and rejects that pair, which would
need `χ_f(α) = sgn(α)` — not a function of `α mod 𝔪₀`.

Three constructions are the mandatory non-vacuity tests of this milestone, one per numeric
field, and no green build detects the absence of any of them:

- the pure norm character `𝔑^{σ}`, for **arbitrary** real `σ` (trivial `χ_f`, trivial unitary
  data). Without it, every statement mentioning a nonzero shift — the shifted poles, the shifted
  functional equation, nonvanishing on `Re s = 1 + σ` — is vacuous.
- the **unitary norm twist** `𝔑^{iu}`, for arbitrary real `u`: trivial `χ_f`, parameters
  `t_v = u` at **every** place, compatibility discharged along the product formula
  `𝔑((α))^{iu} · ∏_v ‖α‖_v^{-iu} = 1`. It is the only constructor with a nonzero
  `archimedeanParam`, and its card in 6.4 is the witness that fixes the radial sign.
- the embedding of **every ray-class character** of 5.1, with the derived weight, shift `0`,
  parameters `0`, and `χ_f` and the parities produced by decomposing `η([(α)])⁻¹` along residues
  mod `𝔪₀` and signs at `𝔪_∞` — the existence half of Neukirch VII (6.9). Without it a
  compatibility law that a ramified character cannot satisfy leaves the finite-order comparisons
  of 6.2 and 6.4 true and empty. Its specification is four named theorems: the weight, shift,
  and parameter identities; the finite character pinned by the (6.9) law with `η` spelled out;
  the parity of the embedding of a **primitive** `η` odd exactly on `𝔪_∞`; and preservation of
  primitivity, which is what lets 6.4's canonical comparisons run with no side conditions.

⚠ **The algebraic pair is derived, not stored.** `z^{-p} z̄^{-p̄}` has radial size `|z|^{-(p+p̄)}`
and is not unitary, so its radial exponent belongs in the global shift. Storing an arbitrary pair
in the unitary carrier is what makes a nonzero shift impossible.

⚠ A field of type `InfinitePlace K → K → ℂ` is an arbitrary function: it need not be
multiplicative, need not avoid `0`, and need not have the formula the gamma factor of 6.2 is
computed from. Every milestone from 6.2 on is false for some term of a structure that carries the
local character as such a field, so it is built rather than assumed.

⚠ The unitary decomposition is unique only because `σ` is required to be **real**. With a complex
exponent it is ambiguous up to `𝔑^{it}`. Uniqueness is a theorem of this milestone, not a
field.

⚠ *Nearby false statement:* the infinity-type dictionary `p_v = ε_v` at a real place, which
confines the pair to `{0, 1}` and rejects `𝔑²`, whose type is `p_v = 2`. The real-place clause
relates the pair to the **shift**. And a repaired clause `ε_v ≡ p_v (mod 2)` is still wrong:
`𝔑³`, the cube of the Tate character, has `σ = 3` and parity `0` — its full local character
agrees with `x^{-3}` on the positive reals, where the infinity type lives, and the extra
`sgn(x)` on the negatives is finite-part data, not infinity-type data. Every classification
counts `𝔑³` as algebraic, so the parity does not appear in the dictionary at all.

The `A₀` condition is the predicate `IsAlgebraic`: every `t_v` vanishes **and** an integral
infinity type exists. ⚠ The first clause alone is not it: `𝔑^{√2}` has every `t_v = 0` and an
irrational radial exponent. Two tests are mandatory: `𝔑^{n}` is algebraic for every integer `n`
(with pair `p_v = n` at real places and `p_v = p̄_v = n` at complex ones), and `𝔑^{√2}` is not.

**Induction, the conductor, and primitive reduction.** Name the canonical reduction map on
residue units along a divisibility of moduli — the quotient-ring map restricted to unit
groups — and define induction along a divisor `𝔫` of `𝔪` as a **constructor**: restrict the
unitary weight to the ideals prime to `𝔪₀`, pull the finite character back along the residue
units and re-extend by zero, and carry every infinite datum across; the infinite part may grow,
and cannot shed a place supporting odd parity, because the smaller character's support law
already forbids it. Prove that the constructor realizes the induction relation, whose clauses
include the **exact finite-character square** along the named units map — without that clause
the relation transports every datum the Gauss sum reads except the one it evaluates.

⚠ The finite character is **not** composed with the residue projection on the whole ring: the
projection carries nonunits to units (over `ℚ`, `3 mod 6 ↦ 1 mod 2`), so plain composition
inflates the conductor-one character to the **all-one** map on `𝓞_K/(p)`, where the inflated
character is `0` off the units. Pulling back on units and re-extending by zero is the operation,
and the `MulChar` carrier is what makes it canonical.

Bundle the primitive reduction as data — conductor, divisibility, primitive inducing character,
induction witness — and prove it exists and that **any two bundles are equal**: same conductor,
and, across that equality of moduli, the same primitive character. The canonical reduction is
then defined from existence and does not depend on the choice; name the canonical primitive
character, and prove that on a primitive character the reduction is the identity, and that the
**infinite part of a primitive modulus is exactly the parity support** — the theorem that keeps
the Layer 6 conductor of an odd character equal to its Layer 5 conductor, infinite part
included. Layer 6.4's completion, root number, polar divisor, and Layer 0 card are all built
from the canonical primitive character at its conductor, and the imprimitive L-function is
derived by the finite Euler-factor correction.

⚠ A relation `Induces ψ χ` together with a theorem conditional on a *supplied* `ψ` does not
produce the primitive ancestor the rest of the layer consumes. The construction is the milestone.
⚠ Uniqueness of the **conductor** alone is strictly weaker than uniqueness of the bundle: it
leaves two primitive characters of the same conductor both claiming to induce `χ`, and every
"canonical" object of 6.4 would depend on the choice. The statement is an equality of bundles;
its proof transports one primitive character across the conductor equality and compares field by
field, the divisibility and primitivity components being proofs.
⚠ And the conductor used by the completion and the card is the **primitive** one, not the modulus
the character happens to be presented over. ⚠ Without primitivity the carrier admits the principal
character modulo a prime, whose completed L-function is not entire; see 6.4.

*Source:* Neukirch VII (6.9) for the carrier, (6.11) to (6.14) for the idele dictionary.

*Prerequisites:* Layers 1.2, 1.7, 5.1, 5.4.

**6.2 The gamma factor from the unitary infinity data.** At a real place the shift is
`ε_v − i t_v`. At a complex place there is one `Gammaℂ` factor with shift `|m_v|/2 − i t_v`. Write
the translation of Neukirch §4's `G(ℂ|ℝ)`-set formalism into `Gammaℝ` and `Gammaℂ` shifts out at
each real place and at each complex place. These are the first entries of the spectral multisets
of 0.1 that are not real.

⚠ The shifts are computed from the **unitary** data. The radial part of the algebraic pair lives
in `σ` and is recentered away before the completion of 6.4 is formed, so a gamma shift built from
`max(p_v, p̄_v)` mixes the two normalizations and does not match the recentred completion.

⚠ The `−i t_v` here and the `‖x‖_v^{-i t_v}` of 6.1 are one sign convention: for the local
character `‖·‖_v^{-it}` the local factor is `Γ(s − it)`-shaped. Flipping either sign alone
breaks the norm-twist card of 6.4 at the `ℚ`-witness recorded in 6.1.

*Prerequisites:* Layers 0.1, 6.1.

**6.3 The weighted theta series, in the unitary variables.** The general term of the carrier has
an angular exponent `m_v`, not a stored algebraic pair, so the theta weight is stated in `m_v`.
Define the **harmonic factor** at a complex place from the angular exponent alone — `z^{m}` when
`m ≥ 0` and `z̄^{-m}` when `m < 0` — and take `x^{ε_v}` at a real place; on nonzero `z` the
complex factor is `(z/|z|)^{m} |z|^{|m|}`, so the character keeps the unitary angular part while
the radial power `|z|^{|m|}`, together with the parameters `t_v` and the shift, is carried by
the **Mellin exponent** of the assembly. The milestone is the theta series over a fractional
ideal weighted by these factors, its transformation law with its constant, and the Mellin
assembly against 2.13. The harmonic weight is exactly the polynomial of 2.9, which is why that
milestone is in Layer 2; the unit-orbit invariance is the admissibility theorem of 6.1.

Then prove the **comparison with the algebraic description**: under the infinity-type predicate
of 6.1 with vanishing `t_v`, the full local character is `z ↦ z^{-p_v} z̄^{-p̄_v}` at a complex
place, and `x ↦ x^{-p_v}` on the positive reals at a real place, so on algebraic characters the
unitary-variable weight is Neukirch's `N(x^p)`-weight. ⚠ The real-place comparison holds on the
positive reals only; the discrepancy `sgn(x)^{ε_v − p_v}` on the negatives is finite-part data,
which is why the infinity type carries no parity clause.

*Source:* Neukirch VII §7, in full generality.
*Prerequisites:* Layers 2.9, 2.13, 6.1, 6.2.

**6.4 The shift translation, primitivity, poles, root number, and functional equation.** One
consolidated specification; everything here is stated once.

*The shift translation.* Since `χ(𝔞) = χ_unit(𝔞) · 𝔑𝔞^{σ}`, the two Dirichlet series satisfy

`L(χ, s) = L(χ_unit, s − σ)`,

so the continued L-function of a Grossencharacter is *defined* from the unitary one and nothing
new has to be continued. State that translation first; everything below reads it.

*Scope: primitive characters.* Define induction from a divisor of the modulus, and primitivity as
not being induced from a proper divisor. Milestone 6.4 is stated for **primitive** characters, and
the imprimitive case is the finite Euler-factor correction of 5.4 written for this layer.

⚠ *Nearby false statement:* a clean completed functional equation, or entirety, for every term of
the carrier. The principal character modulo a prime `p` over `ℚ` is such a term — unitary weight
`1` away from `p` and `0` at `p`, trivial infinite data, shift `0` — and its L-function is
`ζ(s)(1 − p^{-s})`, which still has a pole at `s = 1`. Its finite part is not `1`, so any
exception predicate keyed on the modulus misses it. That character is a mandatory test.

*The polar exception: the norm quasicharacters.* `Λ(χ, ·)` is entire for a primitive `χ` **unless**
the unitary part is a pure norm twist on the good ideals, that is unless `χ = 𝔑^{σ+iu}`. Then the
poles are at `s = σ + iu` and `s = 1 + σ + iu`, shifted with the character, and at conductor `1`
the L-function is `ζ_K(s − σ − iu)`.

The exception predicate is a condition on the **ideal weight alone**, and the theorem that makes
it strong enough to key the polar divisor is the **forcing theorem**: through the compatibility
law over all coprime `α`, a norm-twist weight with exponent `u` forces trivial parity, trivial
angular exponents, trivial `χ_f` on the coprime residues, the **normalized** parameter `t_v = u`
at every place, and the trivial conductor; and the unitary completion of the canonical primitive
character is then `|d_K|^{iu/2} · Λ_K(s − iu)`. ⚠ The constant is not optional: the completion
carries `|d_K|^{s/2}`, which does not commute with the vertical shift. ⚠ The forced parameter is
`u` and not `2u` at a complex place — that is the normalized absolute value of 6.1 doing its one
job.

⚠ *Nearby false statement:* "real powers of the norm with trivial modulus". A pure unitary norm
twist `𝔑^{iu}` with `u ≠ 0` is nontrivial on the good ideals, so an exception keyed on triviality
misses it, yet its L-function is a vertically shifted `ζ_K` and has a pole. It is a mandatory
test, and it is also the character the nonvanishing package of 7.2 must exclude.

⚠ At conductor `≠ 1` the identity with `ζ_K` carries the removed Euler factors. Write them. And
the shifted-completion identity above is for the **canonical primitive character**: for the
presented series of an imprimitive norm quasicharacter the same identity is false at every
modulus with a prime off the conductor, by exactly those factors.

*The inverse and the conjugate, place by place.* Both are needed, and their infinite data are not
the same:

| | real `v` | complex `v` |
|---|---|---|
| `χ⁻¹` | `(p_v, 0) ↦ (−p_v, 0)`, `ε_v ↦ ε_v`, `q_v ↦ −q_v` | `(p_v, p̄_v) ↦ (−p_v, −p̄_v)`, `q_v ↦ −q_v` |
| `χ̄` | `(p_v, 0) ↦ (p_v, 0)`, `ε_v ↦ ε_v`, `q_v ↦ −q_v` | `(p_v, p̄_v) ↦ (p̄_v, p_v)`, `q_v ↦ −q_v` |

with shift `−σ` for the inverse and `σ` for the conjugate. ⚠ On the **unitary** data the two
involutions coincide — both send `ε_v ↦ ε_v`, `m_v ↦ −m_v`, `t_v ↦ −t_v` — so the two characters
differ only in the shift. In algebraic terms that is the same statement: inversion negates the
pair and conjugation swaps it, and `m_v = p̄_v − p_v` changes sign either way.

The involution API is part of the milestone: `(χ⁻¹)⁻¹ = χ`, `(χ̄)‾ = χ`, preservation of
primitivity and of the conductor, all four real/complex gamma-shift comparisons, the root-number
formula for the conjugate, and the comparison of the two completions. A primitive non-real
finite-order character with non-real root number is the regression test: inverting twice must
recover both the character and its root number.

⚠ Real parity is **unchanged** by both. The unitary local character is `sgn(x)^{ε} ‖x‖_v^{-iq}`
with `ε ∈ {0,1}`, and `sgn(x)^{-1} = sgn(x)`; negating `ε` gives `−1`, which the carrier
forbids, so the inverse of every odd real character would be uninhabitable. What the inverse
negates at a real place is the **shift**, hence the type exponent `p_v` of the table. ⚠ At a complex place conjugation
**swaps** the two exponents, because `conj(z^{-p} z̄^{-p̄}) = z^{-p̄} z̄^{-p}`; negating them is the
inverse, and the two agree only when `p_v = p̄_v`. Both constructions are milestones, with their
local-character, ideal-weight, gamma-shift, and completion comparisons proved. An odd real
character is the inverse test, and a complex place with `p_v ≠ p̄_v` is the conjugation test.

*The root number.* Define `W(χ)` for a Grossencharacter, from the Gauss sum of the finite
character `χ_f` at the primitive conductor, as in 5.6, and the unitary infinity data of 6.2, and
prove `‖W(χ)‖ = 1`. The Gauss sum ranges over the residue ring and reads the `MulChar` — the
canonical zero extension of the unit character; any other extension gives a different sum.
⚠ It depends on `χ_f`, the parity, the angular exponents, and the archimedean parameters — and
on nothing else; in particular it never reads the shift, so the conjugate and the inverse, which
differ only there, have **equal** root numbers with no primitivity hypothesis. The root number
of the *trivial* ray-class character does not mention `χ` and is not it.

⚠ The involution is `W(χ⁻¹) = W(χ)⁻¹`, and **not** `conj(W(χ))⁻¹`. Applying the functional
equation twice gives `Λ_χ(s) = W(χ) Λ_{χ⁻¹}(1 − s) = W(χ) W(χ⁻¹) Λ_χ(s)`, so `W(χ)W(χ⁻¹) = 1`.
The form `conj(W)⁻¹` equals `W`, which would force `W² = 1`, and a general Hecke root number is
not confined to `±1`. With `‖W‖ = 1` the correct statement reads `W(χ⁻¹) = conj(W(χ))`.

The finite-order comparison with Layer 5 must fix the **infinite-place data** as well as the
ideal values — at shift `0`, trivial `t_v`, vanishing angular exponents, and parity matching
`𝔪_∞`, it is Layer 5's `W(χ)` — and it requires **both sides primitive**: agreement of ideal
values alone does not identify two completed L-functions, which is the defect fixed in 5.8, and
for the principal character modulo a prime the presented Gauss sum is the imprimitive one —
vanishing under the usual definition — while the Layer 6 root number is built at the primitive
conductor, so an unrestricted comparison equates two different objects. The canonical form of
the comparison is 6.4's, over the embedding of a primitive ray-class character.

*The functional equation*, for a primitive `χ`:

`Λ(χ, s) = W(χ) Λ(χ⁻¹, 1 − s)`, equivalently `Λ(χ, s) = W(χ) Λ(χ̄, 1 + 2σ − s)`.

⚠ *Nearby false statement:* `Λ(χ, s) = W(χ) Λ(χ̄, 1 − s)`, the finite-order formula of 5.8 carried
over unchanged. It is false as soon as `σ ≠ 0`, and the pure norm character `χ = 𝔑^{σ}` is the
mandatory test: `Λ_χ(s) = Λ_K(s − σ)` has poles at `σ` and `1 + σ`, the character is real so
`χ̄ = χ`, and `Λ_χ(1 − s)` has poles at `−σ` and `1 − σ`. Those sets agree only when `σ = 0`.
Against `χ⁻¹` the right-hand side has poles at `σ` and `1 + σ` again. The two correct forms agree
because `χ⁻¹ = χ̄ · 𝔑^{−2σ}`. ⚠ Use the **canonical** conjugate above, not an arbitrary second
character agreeing with `χ̄` on ideal values: that determines neither its infinity type, nor its
gamma factors, nor its completion, and it is the defect already fixed in 5.8.

*The completion, built by recentering.* Write `A = |d_K| 𝔑𝔣₀` for the **primitive** conductor.
Build the unitary completion first,

`Λ_unit(χ, s) = A^{s/2} · γ_unit(χ, s) · L(χ_unit, s)`,

and *define* the full one by recentering:

`Λ(χ, s) = Λ_unit(χ, s − σ)`, equivalently
`Λ(χ, s) = A^{(s−σ)/2} · γ_unit(χ, s − σ) · L(χ, s)`.

⚠ Writing `Λ(χ, s) = A^{s/2} γ(s) L(χ, s)` alongside the unitary formula and `L(χ,s) = L_unit(s−σ)`
is inconsistent for `σ ≠ 0`: the two differ by a conductor factor `A^{σ/2}` **and** a gamma shift.
The recentered definition is what makes both the card's Dirichlet agreement and the reflection
against the inverse come out. Identify `Λ_unit` on the convergence half-plane by a named theorem;
without it the completion is an unconstrained function and every statement about its poles, its
entirety, and its functional equation is about nothing.

⚠ These completions are definitions **for a primitive character**, and the primitivity proof is
an argument of each definition, not a hypothesis of some later theorem: their formulas combine
the conductor with the presented series, which name one L-function exactly in the primitive
case. For an imprimitive character the same formula is the hybrid
`|d_K|^{s/2} γ(s) ζ_K(s)(1 − 𝔑𝔭^{-s})` — primitive conductor, presented Euler-factor-deleted
series — which is neither the canonical completion nor an object with a functional equation, and
the scoping is what makes it inexpressible rather than merely deprecated. The public analytic
objects of an **arbitrary** character are exactly the canonical primitive root number,
completion, and card, through the canonical primitive character, together with the presented
L-series and its Euler-factor correction. Downstream consumers take the canonical objects unless
their input is already primitive.

*The Layer 0 card is the card of the **unitary** part of a **primitive** character.* Build it
explicitly, with its coefficients, conductor, both gamma multisets, root number, the unitary
completion, and its polar divisor, and derive `degree = [K:ℚ]` from the **gamma multisets**. Then
prove that it satisfies all four Layer 0 predicates — Dirichlet agreement, meromorphic
continuation, the functional equation, and the average coefficient bound — for a primitive
character and with no other hypothesis. A type-correct record whose completion does not satisfy
them validates nothing.

The **dual-card comparison is a named theorem, not a hypothesis**: the card of the inverse
character equals the dual record of the card — conjugate coefficients, the same conductor,
conjugated gamma shifts, the conjugated root number, the reflected completion
`s ↦ conj(Λ(conj s))`, and the polar divisor transported along `p ↦ conj p`. The functional
equation of the card is derived from it and takes only primitivity. A version whose dual-card
equality is supplied by the caller leaves the central Layer 0 bridge conditional, and every
consumer would have to rebuild the comparison. Prove also that the conjugate and the inverse
have the **same** card, since they differ only in the shift and no field of the card reads the
shift.

The **canonical card of an arbitrary character is the card of its canonical primitive
character**, and the presented, possibly imprimitive, coefficients never enter it: the presented
series keeps only the Euler-factor correction. The four predicates and the dual comparison then
hold for the canonical card with **no hypothesis at all**, which is the form every downstream
consumer instantiates. ⚠ Giving the presented coefficients of an imprimitive character a card
with the primitive completion and polar divisor asserts a functional equation that the removed
Euler factors falsify; the presented series gets no card.

⚠ The polar divisor is not `0` for every character. When the unitary part is the norm twist
`𝔑^{iu}`, the recentered completion is a vertically shifted Dedekind completion with simple poles
at `iu` and `1 + iu`. Name the exponent `u`, with its uniqueness theorem, so those two points are
available to the record.

Card tests, each an agreement of **every named field** — a completed-function comparison alone
passes with the wrong conductor, gamma multisets, root number, or polar divisor. State the
agreement through a named Layer 0 predicate that compares every field and the coefficients away
from `n = 0`: that slot is irrelevant to `LSeries` (0.1), and the two coefficient conventions
disagree exactly there — a card built from an ideal weight has the canonical `0` (the weight's
zero-ideal law of 1.2), while `idealCoeff` counts the zero ideal and gives `1` — so raw record
equality across the two conventions is false exactly at the junk slot:

- the trivial character recovers the Dedekind-zeta card of 3.10;
- `𝔑^{iu}` recovers the vertically shifted zeta card. Name that card: coefficients
  `𝔞 ↦ 𝔑𝔞^{iu}` grouped by norm, conductor `|d_K|`, all gamma shifts `−iu`, root number
  `|d_K|^{iu}`, completed function `|d_K|^{iu/2} · Λ_K(s − iu)`, poles at `iu` and `1 + iu`.
  ⚠ The two `|d_K|`-constants are forced by including the conductor power in the completion, and
  both are invisible over `ℚ`;
- over `ℚ`: the card of the unitary norm twist has the single real gamma shift `−iu` — not
  `+iu` — and poles at `iu` and `1 + iu`. This is the witness for the radial sign of 6.1;
- over `ℚ(i)`: the same character has the single complex gamma shift `−iu` — not `−2iu` — and
  the same two poles. This is the witness for the multiplicity in the normalized absolute
  value;
- a primitive finite-order character recovers the **named** Layer 5 card of 5.9, with **both
  sides primitive** — the Layer 5 Gauss sum and card are defined there, and the Layer 6 card is
  built there. The canonical form of the comparison runs over the embedding of a primitive
  ray-class character with no data-matching hypotheses at all: its canonical root number is the
  Gauss-sum root number, and its canonical card agrees with the 5.9 card — the acceptance test
  that Layers 5 and 6 use one normalization, one conductor with its infinite part, one gamma
  factor, and one root number;
- the **odd regression instance**: the **constructed** character of 5.1 modulo `(4)∞` over `ℚ`,
  with no character or primitivity hypotheses, so the theorem fails if any carrier on the path
  accidentally empties. Its Layer 6 conductor keeps the real place, its parity is odd there,
  its finite `MulChar` is `χ₄` on the odd residues, its single real gamma shift is `1` — the
  odd `Γ_ℝ(s + 1)` — and its canonical card is the Layer 5 card. This is the instance that a
  carrier without the parity support law silently destroys, and the smallest normalization test
  for the odd real gamma shift;
- the **even regression instance**: the **constructed** quadratic character of 5.1 modulo `(5)`
  over `ℚ` with empty infinite part: even parity, finite `MulChar` the quadratic residue
  symbol on the prime-to-`5` residues, single real gamma shift `0`, canonical card the Layer 5
  card;
- the principal character modulo `𝔪`: canonical primitive data the trivial character of trivial
  conductor, canonical card the Dedekind-zeta card, and **presented** L-series equal to the
  primitive one times the removed Euler factors — `ζ(s)(1 − p^{-s})` over `ℚ` with `𝔪₀ = (p)`.
  This is the test that keeps the presented and the primitive objects apart.

⚠ The degree does not follow from the coefficients. `HasDirichletAgreement` leaves `gammaR`,
`gammaC` and `completed` free: for one coefficient function, choose any extra gamma factors and
define `completed` by the displayed agreement on `Re s > 1`, and the record has whatever positive
degree you like.

⚠ The full shifted function is not an `AnalyticLFunctionData` instance unless it is recentered.
Its coefficients `χ_unit(𝔞)𝔑𝔞^{σ}` converge for `Re s > 1 + σ`, while `HasDirichletAgreement` is
stated on `Re s > 1`; and `AnalyticLFunctionData.dual` conjugates the coefficients, which leaves
the real shift `σ` alone, while the `1 − s` equation needs `−σ`.

*Source:* Neukirch VII (8.5), (8.6).
*Prerequisites:* Layers 2.14, 5.4, 5.6, 6.2, 6.3.

### Layer 7: Landau's theorem, the analytic premise, and nonvanishing

The analytic input to every density theorem, proved without class field theory. Layer 8
therefore does not wait for the global class field theory roadmap.

**7.1 Landau's theorem, and the analytic premise.** Two items that belong together.

*Landau's theorem.* A Dirichlet series with nonnegative real coefficients has a singularity at
its abscissa of absolute convergence. Precisely: no function holomorphic on a neighbourhood of
that abscissa agrees with the series on the intersection of the neighbourhood with the half-plane
of convergence. Mathlib's `LSeries.positive_of_differentiable_of_eqOn` is the nearest thing and
is weaker.

*Source:* Lang VIII §5; Serre, *A Course in Arithmetic*, VI §2.
*Hypotheses:* the coefficients are nonnegative reals, and the abscissa is finite.
*Nearby false statement:* the conclusion fails for complex coefficients. The series
`∑ (−1)^n n^{-s}` has abscissa of absolute convergence `1` and continues to an entire function.

*The premise.* For an ideal weight `χ` of 1.2, define

```lean
def HasCancellation (χ : IdealWeight K) : Prop :=
  (fun X : ℝ ↦ ∑ᶠ I : {I : Ideal (𝓞 K) // (Ideal.absNorm I : ℝ) ≤ X}, χ.toFun I)
    =O[atTop] fun X : ℝ ↦ X ^ (1 - 1 / (Module.finrank ℚ K : ℝ))
```

that is `∑_{𝔑𝔞 ≤ X} χ(𝔞) = O(X^{1 − 1/d})` with `d = [K:ℚ]`. Then `HasCancellation χ` implies
that `L(χ, ·)` continues holomorphically to `Re s > 1 − 1/d`, by 1.9 applied to the partial sums.

⚠ Name the continued object, as `continuedLFunctionOfWeight χ`, with the two theorems that it
agrees with the series on `Re s > 1` and is analytic on the strip. Milestones 7.3, 7.4, 8B.5, and
9.7 all state properties of it, and 3.5's uniqueness is what makes those two theorems determine
it. A statement of the form `∃ F, …` leaves every later milestone quantifying over its own `F`.

⚠ This hypothesis cannot be replaced by an algebraic one. The group of ideals prime to a finite
set is free, so it has finite quotients whose values on primes are arbitrary, and finiteness of a
quotient gives no continuation.

Basic API: `HasCancellation` is preserved by conjugation and by enlarging the bad set by a finite
set; the trivial weight does not satisfy it, since `∑_{𝔑𝔞 ≤ X} 1 ∼ ρ_K X`.

*Prerequisites:* Layers 1.2, 1.9; Mathlib `LSeries.abscissaOfAbsConv`, `AnalyticOnNhd`.

**7.2 The hypothesis package a nonvanishing proof needs.** The `3-4-1` argument uses `χ`, `χ²`,
and the conjugate of `χ`, and the argument on `Re s = 1` uses the norm twists `χ 𝔑^{it}`.
`HasCancellation χ` alone does not give any of the others. So state the hypotheses once, as a
package over a **family** rather than a single weight:

```
CancellingFamily (G : Type*) [Group G] [Fintype G] (w : G → IdealWeight K) : Prop
```
requiring: `w` is a homomorphism to pointwise products; `w 1` takes the value `1` at every
**good** ideal, meaning `I ≠ ⊥` and `I` prime to the bad set;
`HasCancellation (w g)` for every `g ≠ 1`; closure of the family under conjugation; and
`HasCancellation (w g · 𝔑^{it})` for every `g ≠ 1` and every real `t`.

⚠ The last condition is for the **nontrivial** members only. Demanding it at `g = 1` and `t ≠ 0`
makes the package uninhabitable by its own principal example. The twisted trivial weight has
coefficients `𝔑𝔞^{it}`, and since `#{𝔞 ∣ 𝔑𝔞 ≤ X} ∼ ρ_K X`, partial summation gives
`∑_{𝔑𝔞 ≤ X} 𝔑𝔞^{it} ∼ ρ_K X^{1+it}/(1+it)`, of absolute value comparable to `X`, while
`HasCancellation` demands `O(X^{1−1/d})`. Equivalently the associated series is `ζ_K(s − it)`,
which has a pole at `s = 1 + it`, and a cancellation hypothesis there would make it holomorphic
throughout the strip.

The trivial member is handled separately, and not through the package: at `t = 0` it is the pole
of `ζ_K`, and at `t ≠ 0` the nonvanishing of `ζ_K(1 + it)` is the Dedekind-zeta statement of 7.4,
proved from the `3-4-1` inequality applied to `ζ_K` itself.

⚠ `I ≠ ⊥` is part of "good", and dropping it leaves the package uninhabited by the modulus-one
family, which is the ordinary class-group case. Divisibility of ideals is reverse inclusion, so
`𝔭 ∣ ⊥` holds for every prime; at the modulus with finite part `1` the bad set is empty, the
prime-to-bad condition is vacuous at `I = ⊥`, and the law would demand `χ(⊥) = 1` while every
weight here sends `⊥` to `0`. Define the good-ideal predicate once, and use it in the family law,
in the Euler product, and in the ray-class instance.

**A second package, for one possibly infinite-order unitary character.** ⚠ `CancellingFamily` is
indexed by a finite group, so `map_mul` and the trivial-member law force every good value of every
member to satisfy `x^{#G} = 1`, hence to be a root of unity. A unitary Grossencharacter with a
nonzero archimedean parameter, and every norm twist `𝔑^{it}` with `t ≠ 0`, has infinite order,
so no such family contains them and Layer 7.7 cannot be an instance of 7.5's package.

State a second package over a single unitary weight, carrying: that `χ` is **not** a pure norm
twist on its good ideals; cancellation for `χ`, for the conjugate, and for every norm twist of
`χ`; and, for every real `t`, that `(χ 𝔑^{it})²` is either a pure norm twist `𝔑^{iv}` on the
good ideals, or cancels. The trivial factor is `ζ_K`, cited from 7.4 rather than carried.
Milestones 7.3 and 7.4 are then proved twice, once over each package; 7.5 and 8B.2 instantiate the
finite one, and 7.7 the single one.

⚠ Do **not** demand cancellation of the square outright. That excludes the two commonest
nonexceptional characters:

- a nontrivial quadratic ray-class character `η` has `η² = 1` on the good ideals, so its partial
  sums grow linearly and cancellation of `η²` is false, while `L(η, ·)` is entire and nonzero on
  `Re s = 1`;
- `χ = η 𝔑^{iu}` with `η` quadratic and `u ≠ 0` is unitary of **infinite** order, and is not the
  norm-quasicharacter exception of 6.4, yet `χ² = 𝔑^{2iu}`.

⚠ Nor is *trivial-or-cancelling* enough, and the second example is again the witness. The square
of its twist at `t` is `𝔑^{2i(u+t)}`, which is trivial only at `t = −u`; at every other `t` it
is a **nontrivial** norm twist, and those do not cancel either. From
`#{𝔞 ∣ 𝔑𝔞 ≤ X} = ρ_K X + O(X^{1−1/d})`, partial summation gives
`∑_{𝔑𝔞 ≤ X} 𝔑𝔞^{iv} = ρ_K X^{1+iv}/(1+iv) + O(X^{1−1/d})`, of magnitude comparable to `X`. So the
square has three cases, and the condition above merges the first two.

The `3-4-1` proof splits the same way. Cancelling branch: the product bound. Norm-twist branch
with `v = 0`: `χ` at that twist is real, and the argument is Landau's, applied to the nonnegative
coefficients of `ζ_K(s) L(χ_t, s)` — which is exactly why 7.1 proves Landau's theorem. Norm-twist
branch with `v ≠ 0`: the series is a vertically shifted `ζ_K`, and the input is 7.4's nonvanishing
of `ζ_K` at `1 + iv`.

⚠ "`χ` is not a pure norm twist" is a field of the package, not a remark. If `χ = 𝔑^{iu}` then
its twist by `−u` is the trivial weight and cancellation fails there; the norm quasicharacters are
exactly the polar exception of 6.4, so they are excluded rather than left as unsatisfiable
fields. Both mandatory tests must be stated so that their hypotheses are ones a ray-class
character actually satisfies.

Then 7.3 and 7.4 are theorems about a `CancellingFamily`, and are instantiated twice, in 7.5 and
in 8B.2. A single-weight statement would be false at the advertised generality.

*Prerequisites:* Layer 7.1.

**7.3 `L(χ, 1) ≠ 0` for a nontrivial member of a cancelling family.**

*Source:* Lang XV Thm 2, which proves this for Hecke characters with no class number formula and
no class field theory. Mathlib's `Nonvanishing.lean` has the Dirichlet case.
*Method:* the `3-4-1` product `L(1)³ L(χ)⁴ L(χ²)` when `χ² ≠ 1`. That product needs `L(χ²,·)`,
and hence membership of `χ²` in the family. For a real `χ` the method is instead the positivity
of the coefficients of `ζ_K(s) L(χ, s)`, together with Landau's theorem from 7.1.
*Hypotheses:* `χ ≠ 1`, and `χ` a member of a `CancellingFamily`.
*Nearby false statement:* the `3-4-1` argument alone does not cover a real `χ`, because there
`χ² = 1` and the product degenerates. That case is exactly why Landau's theorem is needed.

*Prerequisites:* Layers 1.4, 7.1, 7.2.

**7.4 Nonvanishing on `Re s = 1`, in meromorphic-order form.**

⚠ This is where a pointwise statement is wrong. The trivial character has a pole at `s = 1`, so
"`L(χ, 1 + it) ≠ 0` for arbitrary `χ`" compares a value at a pole. State instead, for the
continued functions of 1.9 and 5.3:

- `meromorphicOrderAt (dedekindZetaC K) 1 = −1`;
- `meromorphicOrderAt (dedekindZetaC K) (1 + it) = 0` for `t ≠ 0`;
- `meromorphicOrderAt (L(χ, ·)) (1 + it) = 0` for every real `t` and every nontrivial member `χ`
  of a cancelling family. For such `χ` the function is analytic at `s = 1`, so this is equivalent
  to `L(χ, 1 + it) ≠ 0`;
- as a corollary: no member of the family has a zero on `Re s = 1`, and the only pole is the one
  recorded above.

*Source:* Lang XV Thm 3. Mathlib's `LFunction_ne_zero_of_re_eq_one` is the Dirichlet case.
*Method:* the `3-4-1` inequality of 7.3, applied to the norm twist at `1 + it`, which is why 7.2
requires closure under those twists.
*Nearby false statement:* "for arbitrary `χ`, `L(χ, 1 + it) ≠ 0`" is false at `χ = 1`, `t = 0`.

*Prerequisites:* Layers 1.9, 3.7, 5.3, 7.2, 7.3.

**7.5 The ray-class family satisfies the premise.** The characters of a fixed ray class group,
with the pointwise product, form a `CancellingFamily`. Cancellation for a nontrivial member
follows from the decomposition of 1.7 into partial zeta functions and the counting estimate of
1.6 with its error term. This is the first of the two instantiations, and it makes 7.3 and 7.4
available for Layer 5's characters.
*Prerequisites:* Layers 1.6, 1.7, 5.1, 7.2.

**7.6 Logarithmic derivatives, for a general ideal weight.** Define the ideal von Mangoldt weight
`Λ_K(𝔞)`, equal to `log 𝔑𝔭` when `𝔞 = 𝔭^m` for some `m ≥ 1`, and `0` otherwise. For any ideal
weight `χ` of 1.2, prove
`−L'/L(χ, s) = LSeries (idealCoeffOfWeight (χ · Λ_K)) s` on `Re s > 1`, in the shape of Mathlib's
`LSeries_vonMangoldt_eq_deriv_riemannZeta_div`. The statement is generic, so it does not depend
on Layer 5, and it is instantiated for ray-class and for cyclotomic characters where they appear.

Basic API: the value at a prime and at `1`; nonnegativity of `Λ_K`; the norm-grouped coefficient
function; the identity `∑_{𝔞 ∣ 𝔟} Λ_K(𝔞) = log 𝔑𝔟`.

*Prerequisites:* Layers 1.2, 1.4.

**7.7 The nonvanishing consequence for Grossencharacters.** Milestone 7.4, applied over the
**single-character** package of 7.2 to a Grossencharacter's unitary part and its norm twists,
gives nonvanishing on the boundary, with the exceptional case of 6.4 excluded explicitly. Package
that as the typed export an equidistribution argument consumes.

⚠ The boundary is `Re s = 1 + σ`, not `Re s = 1`. By the translation of 6.4 the full
quasicharacter's series is the unitary one shifted by `σ`, so the edge of its critical strip sits
at `1 + σ`. State the `Re s = 1` form only under `σ = 0`; 7.8 uses that case, where it is right.

⚠ The finite family of 7.2 cannot be used here, for the reason recorded there: a unitary
Grossencharacter with a nonzero archimedean parameter has infinite order and is in no finite
character group.

⚠ **Construct the premise; do not take it as a hypothesis.** This milestone owes a theorem
producing the single-character package of 7.2 for every Grossencharacter outside the
norm-quasicharacter exception of 6.4, that is whenever the unitary part is **not a pure norm
twist** on the good ideals. A statement of the form "given the package, nonvanishing holds" leaves
the advertised export true only for the characters a caller can already discharge it for, and 7.8
would then rest on nothing.

⚠ The exclusion is "not a pure norm twist", and not "not trivial". A unitary `𝔑^{iu}` with
`u ≠ 0` is nontrivial on the good ideals, yet its twist by `−u` is the trivial weight, so
cancellation fails for it, and its L-function is a vertically shifted `ζ_K`, which has a pole. It
is the exception, not a member.

⚠ This is an export and not equidistribution. The Weyl criterion for a compact group is out of
scope.

*Prerequisites:* Layers 6.1, 6.4, 7.2, 7.4.

**7.8 Hecke's equidistribution of Gaussian primes.** The arguments of the primes of `ℤ[i]` are
equidistributed in `[0, π/2)`. Prove it by applying 7.7 to the characters `𝔞 ↦ (α/|α|)^{4k}` of
`ℚ(i)`. This is the only equidistribution statement in the roadmap. It is here because it checks
that 6.1 to 6.4 and 7.7 can be used.
*Source:* Lang XV Thm 5.
*Prerequisites:* Layers 6.1, 7.7.

### Layer 8: prime densities and the Chebotarev density theorem

The main theorem of the roadmap. It is proved without class field theory, by the argument of
Lenstra–Stevenhagen and of Sharifi Thm 7.2.2.

**8.0 The Frobenius class, consumed.** For number fields `K ⊆ L` with `L/K` finite Galois, the
Artin symbol is Number Field Arithmetic's, by the contract above. This milestone builds no
Frobenius element, no conjugacy class, and no compatibility; it holds:

- `IsUnramifiedAt K L 𝔭 : Prop` for `𝔭 : HeightOneSpectrum (𝓞 K)`, as the quantified
  `Algebra.IsUnramifiedAt` over the primes of `𝓞 L` above `𝔭` — which is **exactly** the shape
  `artinSymbol` takes its hypothesis, and per that roadmap's Layer 1.2 rule against an
  `IsUnramifiedIn` wrapper. Its comparison with `ramificationIdxIn 𝔭.asIdeal (𝓞 L) = 1` is stated
  once, as `isUnramifiedAt_iff_ramificationIdxIn`, together with finiteness of the ramified set;
- `frobeniusClass K L 𝔭 hur : ConjClasses (L ≃ₐ[K] L)`, **defined as** the consumed
  `artinSymbol 𝔭.asIdeal hur`, transported to the `HeightOneSpectrum` indexing that 8A's density
  statements are written over. It is a definition and not a milestone: `Suggested.lean` closes it
  with no `sorry`. ⚠ The unramifiedness proof is an argument, so a density set reads
  `∃ h : IsUnramifiedAt K L 𝔭, frobeniusClass K L 𝔭 h = C` and never a conjunction with a total
  class. A total class would need a junk value at ramified primes, and every set below would
  silently contain it;
- the characterization at an unramified `𝔭` — `σ` lies in the class exactly when there is a prime
  `Q` of `L` over `𝔭` with `σ • x ≡ x^{𝔑𝔭} mod Q` for every `x` — which is the supplier's Layer
  2.3 and is not restated here;
- **restriction compatibility**, which is the consumed `artinSymbol_map_restrictNormalHom`
  transported along `frobeniusClass`. The transport is a **closed** proof, so the two statements
  cannot drift apart;
- **tower compatibility**, which is the consumed `exists_isArithFrobAt_pow_inertiaDeg`, also
  transported by a closed proof. It is stated relative to one prime of `L`: for `Q` over `𝔓`
  of `E` over `𝔭` of `K`, and `σ` an arithmetic Frobenius **at that `Q`**, the relative Frobenius
  at `Q/𝔓` is `σ^{f(𝔓/𝔭)}` when read in `Gal(L/K)`. The reason is one line of residue arithmetic:
  `σ^f` acts as `x ↦ x^{𝔑𝔭^f}` and `𝔑_E 𝔓 = 𝔑_K 𝔭^f`. ⚠ A version taking an arbitrary
  representative of `frobeniusClass K L 𝔭` and a fixed `𝔓` is false when `E/K` is not normal: a
  conjugate representative need not stabilize `Q`, so `σ^f` need not fix `E` pointwise and is
  then the restriction of nothing in `Gal(L/E)`. The class-level statement is a corollary of the
  prime-relative one, never a replacement for it. ⚠ The prime-relative statement also needs `𝔭`
  **unramified**: at a ramified prime a Frobenius lift is determined only modulo inertia, so no
  equality of automorphisms is available. *Nearby false statement:* take `L/K` nontrivial Galois
  with `Q` totally ramified over `𝔭`, and `E = L`. Then `f(𝔓/𝔭) = 1` and *every* `σ ∈ Gal(L/K)`
  satisfies the Frobenius congruence at `Q`, because inertia acts trivially on the residue field;
  the conclusion asks for `τ ∈ Gal(L/L) = {1}` with restriction `σ`, which fails for `σ ≠ 1`. If a
  ramified statement is wanted, state it in the quotient by inertia, or as a coset;
- the value at a prime that splits completely, which is the identity class, and the cardinality
  of the class.

Milestones 8C and 8D use restriction and tower compatibility directly, so both are named here,
as transports of the two supplied theorems and not as second proofs of them. ⚠ Frobenius here is
arithmetic, which is the supplier's convention; 8B.1 tests the orientation.

⚠ No statement of Layer 8 takes a Frobenius interface as a parameter. A theorem of the shape
`(F : FrobeniusInterface K L) → HasDirichletDensity …` is conditional on an arbitrary term of a
small structure: unrelated assignments of conjugacy classes to primes satisfy its fields, the
theorem holds vacuously for them, and the crossing and fixed-field proofs cannot use restriction
or tower compatibility because those are properties of a term the theorem does not construct.
Consuming a named declaration of an earlier roadmap is the opposite of that, and 8D.5 remains a
theorem about `K` and `L` and about nothing else.

*Prerequisites:* `artinSymbol`, `artinSymbol_map_restrictNormalHom`,
`exists_isArithFrobAt_pow_inertiaDeg` (R *Number Field Arithmetic*, Layers 2.3 and 2.4); Mathlib
`Algebra.IsUnramifiedAt`, `Ideal.ramificationIdxIn`, `AlgEquiv.restrictNormalHom`,
`AlgEquiv.restrictScalars`.

#### 8A: the density calculus

**8A.1 The density notions.** Define `primeIdealZetaSum S s = ∑' 𝔭 ∈ S, 𝔑𝔭^{-s}` and
`HasDirichletDensity S δ` as the ratio to the sum over all nonzero primes, tending to `δ` along
`𝓝[>] 1`. Define also:

- `HasUpperDirichletDensity S δ` and `HasLowerDirichletDensity S δ`, the `limsup` and the
  `liminf` of that ratio being equal to `δ`;
- `LowerDirichletDensityAtLeast S c`, meaning `c ≤ liminf` of that ratio. ⚠ This inequality, and
  not the equality, is what the crossing argument of 8C produces, and 8C.6 is stated with it;
- `HasNaturalDensity`, and polar density.

⚠ Mathlib master has `primeIdealZetaSum` and `HasDirichletDensity` in
`NumberTheory/NumberField/DirichletDensity.lean`, namespace `NumberField.Set`. The pin does not
have them, so 8A.1 builds them in that exact shape, which is what makes every statement below
independent of which of the two is in force.

Basic API:

- the empty set has density `0`, and the set of all primes has density `1`;
- density is nonnegative and at most `1`;
- a set with a density has equal upper and lower density;
- a density implies the corresponding lower bound.

*Prerequisites:* Mathlib `Ideal.absNorm`, `HeightOneSpectrum`, `Filter.limsup`, `Filter.liminf`.

**8A.2 The denominator.** `primeIdealZetaSum univ s / log((s−1)⁻¹) → 1` as `s → 1⁺`. It follows
from the simple pole of 1.9 and the logarithm of 1.4. Hence the definition of 8A.1 is equivalent
to Neukirch's, whose denominator is `log((s−1)⁻¹)`. After this theorem no statement mentions
`log((s−1)⁻¹)`.
*Prerequisites:* Layers 1.4, 1.9, 8A.1.

**8A.3 The calculus.** Seven statements:

- equal upper and lower density gives the density;
- upper density and lower density are monotone, and so is the lower bound predicate;
- a finite set has density `0`;
- a finite symmetric difference changes none of the notions;
- a finite disjoint union adds densities, and adds lower bounds;
- the complement has density `1 − δ`;
- **the squeeze**: if the sets `S_1, …, S_r` are pairwise disjoint, their union has density `1`,
  and `LowerDirichletDensityAtLeast S_i c_i` holds with `∑ c_i = 1`, then each `S_i` has density
  exactly `c_i`. This is the step 8C.8 uses.

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

Then `HasDirichletDensity S δ` and `HasDirichletDensity T (δ/k)` are equivalent, and the same
holds for the lower bound predicate.

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
it until a numerical example. Milestone 8B.5 is that example.

Over `K = ℚ` this is Mathlib's `IsCyclotomicExtension.Rat.galEquivZMod_stabilizer`. Over a
general `K` it is a milestone, stated through 8.0.

Two further items belong here, because 8B.3, 8B.4, and 9.7 all read them.

- `Gal(K(ζ_m)/K)` is **abelian**, since the Frobenius formula embeds it in `(ℤ/m)ˣ`. Everything
  downstream rests on it: the Frobenius class is a singleton, so there is a Frobenius *element*,
  and one-dimensional characters separate the group's elements.
- the **cyclotomic weight** of a character `χ` of that group: the ideal weight of 1.2 whose value
  at an unramified `𝔭` is `χ(Frob_𝔭)`, whose bad set is exactly the primes ramified in
  `K(ζ_m)/K`, and which is therefore `0` there. ⚠ Build it; do not quantify over an arbitrary
  weight specified only at the unramified primes. Such a weight may be a nonzero unit at a
  ramified prime, and 9.7's orthogonality identity sums over every prime while its coefficient
  excludes the ramified ones, so the extra terms make the identity false.

*Prerequisites:* Layer 8.0; Mathlib `IsCyclotomicExtension.Rat.galEquivZMod`,
`galEquivZMod_stabilizer`.

**8B.2 The cyclotomic family satisfies the premise.** The characters of `Gal(K(ζ_m)/K)`,
regarded as ideal weights through 8B.1, form a `CancellingFamily` in the sense of 7.2.
Cancellation for a nontrivial member follows from the counting estimate of 1.6 applied to the ray
classes modulo `m∞`, using 8B.1 to identify the Frobenius with the norm residue. This is the
second instantiation of 7.2, and it is placed here rather than in Layer 7 because it needs 8B.1.
*Prerequisites:* Layers 1.6, 1.7, 7.2, 8B.1.

**8B.3 Character orthogonality.** For `σ` in `Gal(K(ζ_m)/K)`,
`(#G)⁻¹ ∑_χ conj (χ σ) χ(τ) = if σ = τ then 1 else 0`. Mathlib has the pieces; the milestone is
the form that 8B.5 and 9.7 use.
*Prerequisites:* Mathlib character orthogonality for a finite abelian group.

**8B.4 The logarithmic comparison.** For `χ` a character of `Gal(K(ζ_m)/K)`, regarded as an ideal
weight through 8B.1, `log L(χ, s) = ∑_{𝔭 ∤ m} χ(Frob_𝔭) 𝔑𝔭^{-s} + O(1)` as `s → 1⁺`. The error
term is the contribution of the prime powers with `m ≥ 2`, which converges. State that bound as a
theorem.
*Prerequisites:* Layers 1.4, 7.6, 8B.1.

**8B.5 The cyclotomic density theorem.** `L(χ, 1) ≠ 0` for `χ ≠ 1`, by 7.3 with the family
supplied by 8B.2. Together with 8B.3 and 8B.4 this gives: for each `σ ∈ Gal(K(ζ_m)/K)`, the set
`{𝔭 ∤ m ∣ Frob_𝔭 = σ}` has Dirichlet density `1/[K(ζ_m):K]`.
*Prerequisites:* Layers 7.3, 8A.1, 8B.1, 8B.2, 8B.3, 8B.4.

**8B.6 Dirichlet's theorem with a density.** The case `K = ℚ`: the primes `p ≡ a (mod q)` have
Dirichlet density `1/φ(q)`. Mathlib's `Nat.infinite_setOf_prime_and_eq_mod` follows. That it
follows is an acceptance criterion.
*Prerequisites:* Layer 8B.5; Mathlib `Nat.infinite_setOf_prime_and_eq_mod`.

#### 8C: the abelian case, by crossing with cyclotomic extensions

Let `L/K` be abelian with group `G`, and let `σ ∈ G` have order `f`. Every object below is a
milestone. None of them is called "the crossing lemma".

⚠ **Carry the whole diagram, and not just the group isomorphism.** Milestones 8C.5 and 8C.6 are
false for arbitrary finite Galois `L/K`, `M/K`, `N/K` with an abstract isomorphism
`Gal(N/K) ≅ Gal(L/K) × Gal(M/K)`:

- the tagged fibre then has density `#C_σ · #C_τ/(#G · #H)` and not `1/(#G · #H)`. In `S₃ × C₂`
  a transposition paired with the nontrivial element has a conjugacy class of size `3`;
- for a nonabelian `Gal(M/K)`, two distinct but conjugate `τ` determine the *same* class and
  hence the same set of primes, so the fibres are not pairwise disjoint.

Package the diagram once, as the datum of 8C.1 to 8C.4: `L/K` abelian; `M = K(ζ_q)` with
`Gal(M/K)` cyclic; `L ∩ M = K`; `N = L·M`; the map is Mathlib's canonical restriction
homomorphism and it is bijective; and Frobenius under it is the pair of the restricted Frobenius
elements. `L/K` abelian and `Gal(M/K)` cyclic make `Gal(N/K)` abelian and every class a
singleton, which is what the numbers below need; the cyclotomic and compositum conditions are
what make the route non-circular, since 8C.4's fixed field has to be cyclotomic over its base for
8B.5 to apply over it.

**8C.1 The auxiliary primes.** Do not quantify over abstract admissible moduli: construct them.
For an integer `r ≥ 1`, call a rational prime `q` *auxiliary of level `r`* when

- `q` is unramified in `L`;
- `q ≡ 1 mod f^r`;
- `K ∩ ℚ(ζ_q) = ℚ`, so that `Gal(K(ζ_q)/K) ≅ (ℤ/q)ˣ` is **cyclic** of order `q − 1`;
- `L ∩ K(ζ_q) = K`.

Prove that auxiliary primes of every level exist, by Dirichlet's theorem in the progression
`1 mod f^r` together with the finiteness of the excluded set.

⚠ Name the excluded set. "For all but finitely many `q`" hides which finitely many; the set is
the rational primes ramified in `K/ℚ` together with those below the primes ramified in `L/K`, and
avoiding it is exactly what buys the two intersection conditions. State each condition in a form
a later milestone can use: `K ∩ ℚ(ζ_q) = ℚ` as `#Gal(K(ζ_q)/K) = q − 1`, hence cyclic, and
`L ∩ K(ζ_q) = K` as bijectivity of the canonical restriction map of 8C.2.

⚠ Then **construct** the whole diagram, and bundle it. A package of correct hypotheses that
nothing constructs shows only that the hypotheses typecheck, and an adapter that receives the two
auxiliary fields and the linear disjointness turns the desired facts into a structure rather than
proving them. The milestone asks for:

1. the cyclotomic field `M = K(ζ_q)`, taken from Mathlib's `CyclotomicField`;
2. the compositum `N = L·M`, built as the join of the images of `L` and `M` in an algebraic
   closure of `K`, which supplies both embeddings and both scalar towers;
3. `N = L·M` recorded as a property of the diagram — no proper intermediate field contains both
   images — from which injectivity of the restriction map follows;
4. the degree count `#Gal(N/K) = #Gal(L/K)·#Gal(M/K)`, **proved** from
   `q ∉ crossingExceptional`, which is where the linear disjointness `L ∩ K(ζ_q) = K` is spent;
5. all of it bundled with the resulting crossing datum, and an existence theorem producing one
   bundle for every level `r`.

Milestone 8C.6 is then stated over the bundle, and its statement mentions no compositum, no
disjointness, and no auxiliary field. Separating (3) from (4) is the point: being the compositum
is a property of the diagram one constructs, while the disjointness is the arithmetic the
auxiliary prime buys, and taking either as a hypothesis of the lower bound leaves the route
conditional on the step it exists to take.

⚠ *Nearby false statement:* "`f` divides `[K(ζ_m):K]`" does not give an element of order
divisible by `f`. Divisibility of the order of a finite group does not produce such an element
in general. The cyclicity in the third clause is what does, and it is why the construction uses a
rational prime `q` rather than an arbitrary modulus.

*Prerequisites:* Layer 8.0; Mathlib `IsCyclotomicExtension`, Dirichlet's theorem.

**8C.2 Linear disjointness and the product decomposition.** For an auxiliary `q`, the restriction
map `Gal(L·K(ζ_q)/K) → Gal(L/K) × Gal(K(ζ_q)/K)` is an isomorphism. The hypothesis
`L ∩ K(ζ_q) = K` is what this uses.
*Prerequisites:* Layer 8C.1; Mathlib `IsGalois`, `IntermediateField`.

**8C.3 Compatibility of Frobenius with restriction.** For `𝔭` unramified in the compositum, the
Frobenius of `𝔭` in `L·K(ζ_q)/K` maps to the pair of its Frobenius elements in `L/K` and in
`K(ζ_q)/K`. This is the restriction field of 8.0, applied twice.
*Prerequisites:* Layers 8.0, 8C.2.

**8C.4 The fixed field is cyclotomic over its base.** Let `τ ∈ Gal(K(ζ_q)/K)` with
`f ∣ orderOf τ`, which exists because that group is cyclic of order `q − 1` and `f ∣ q − 1`.
Write `M = L·K(ζ_q)` and `E = M^{⟨(σ,τ)⟩}` under the identification of 8C.2. Then
`⟨(σ,τ)⟩ ∩ Gal(M/K(ζ_q)) = 1`, so `E·K(ζ_q) = M`, and `M/E` is generated by roots of unity.
Milestone 8B therefore applies over `E`.

⚠ The hypothesis `f ∣ orderOf τ` is exactly what makes the intersection trivial. *Nearby false
statement:* without it, `⟨(σ,τ)⟩ ∩ Gal(M/K(ζ_q)) = ⟨(σ^{orderOf τ}, 1)⟩`, which is not trivial,
and `E·K(ζ_q)` is a proper subfield of `M`.

*Prerequisites:* Layers 8C.1, 8C.2.

**8C.5 The tagged family of Frobenius fibres.** For each `τ ∈ Gal(K(ζ_q)/K)` with
`f ∣ orderOf τ`, set `S_τ = {𝔭 ∣ Frob_𝔭 = (σ, τ)}` in the compositum. These sets are pairwise
disjoint as `τ` varies, and each contracts into `{𝔭 ∣ Frob_𝔭 = σ}` in `L/K`. Disjointness is what
makes the densities add, so it is a stated lemma.
*Prerequisites:* Layers 8C.2, 8C.3, 8C.4.

**8C.6 The lower bound from one auxiliary prime, with its constant written out.** Fix an
auxiliary `q`. Write

`H_q = Gal(K(ζ_q)/K)`, which is cyclic of order `q − 1` by 8C.1;

`H_{q,f} = {τ ∈ H_q ∣ f ∣ ord(τ)}`, the tagged elements of 8C.5;

`M = L·K(ζ_q)`, with `Gal(M/K) ≅ G × H_q` by 8C.2.

For `τ ∈ H_{q,f}`, let `E_τ` be the fixed field of `⟨(σ, τ)⟩`, which is cyclotomic over its base
by 8C.4, and let `n_τ = ord(τ) = [M:E_τ]`. Then:

1. **The density of one tagged fibre.** Milestone 8B.5 over `E_τ` gives the primes `𝔓` of `E_τ`
   with `Frob_{M/E_τ}(𝔓) = (σ, τ)` the density `1/n_τ`. Intersect that set with the primes of
   degree one over `K`, which by 8A.4 changes no density. Then:

   - a member `𝔓` of the intersection, lying over `𝔭`, has
     `Frob_{M/E_τ}(𝔓) = Frob_{M/K}(𝔭)^{f(𝔓/𝔭)} = Frob_{M/K}(𝔭)`, so `Frob_{M/K}(𝔭) = (σ, τ)`;
   - conversely, if `Frob_{M/K}(𝔭) = (σ, τ)` then the decomposition group of any prime of `M`
     over `𝔭` is `⟨(σ, τ)⟩ = Gal(M/E_τ)`, so every one of the `[E_τ:K] = #G·#H_q/n_τ` primes of
     `E_τ` over `𝔭` has degree one over `K` and lies in the intersection.

   Those are exactly the three hypotheses of 8A.5, with `k = #G·#H_q/n_τ`, so contracting gives

   `HasDirichletDensity {𝔭 ∣ Frob_{M/K}(𝔭) = (σ, τ)} (1/(#G · #H_q))`,

   a value independent of `τ`. ⚠ The degree-one intersection is not a convenience. Without it the
   first bullet fails: a prime of `E_τ` of residue degree `f > 1` over `K` has
   `Frob_{M/E_τ}(𝔓) = Frob_{M/K}(𝔭)^f`, which does not determine `Frob_{M/K}(𝔭)`.
2. **Pairwise disjointness.** Distinct `τ` give distinct elements `(σ, τ)` of the abelian group
   `Gal(M/K)`, so the fibres are pairwise disjoint. This is 8C.5.
3. **The lower bound.** Every one of those fibres lies inside `{𝔭 ∣ Frob_{L/K}(𝔭) = σ}`, by
   restriction, so the finite disjoint union of 8A.3 gives

   `LowerDirichletDensityAtLeast {𝔭 ∣ Frob_𝔭 = σ} c_q` with **`c_q = #H_{q,f} / (#G · #H_q)`**.

⚠ The union over **all** of `H_{q,f}` is needed. One generator `τ` gives a single fibre, hence
`c_q = 1/(#G(q−1))`, which tends to `0` as `q` grows and proves nothing.

⚠ The predicate is the inequality of 8A.1 and not an equality. The tagged fibres are contained
in the target set and need not exhaust it, so nothing stronger is available here.

*Source:* Lenstra–Stevenhagen §3 and Sharifi Thm 7.2.2 carry out this computation; the four
AINTLIB files named in [`PROVENANCE.md`](PROVENANCE.md) contain a machine-checked version of it.

*Prerequisites:* Layers 8A.3, 8A.5, 8B.5, 8C.3, 8C.4, 8C.5.

**8C.7 The bound approaches `1/#G`.** Since `c_q = (#H_{q,f}/#H_q)/#G`, the statement to prove is
that the tagged proportion approaches `1`. It is an elementary count in a cyclic group, about the
auxiliary construction alone and not about `L`.

*The exact count.* In a cyclic group of order `n` with `f ∣ n`,

`#H_{q,f} = n · ∏_{p ∣ f} (1 − p^{−(v_p(n) − v_p(f) + 1)})`,

because for each prime `p ∣ f` the elements `τ` with `v_p(ord τ) < v_p(f)` are exactly the
subgroup of index `p^{v_p(n) − v_p(f) + 1}`, and those conditions are independent across `p`. The
test is `n = 4`, `f = 2`: the formula gives `4(1 − 1/4) = 3`, and the elements of `C₄` of order
divisible by `2` are `g`, `g²`, `g³`.

*The estimate.* An auxiliary prime of level `r` has `q ≡ 1 mod f^r`, so `f^r ∣ n = q − 1` and
`v_p(n) − v_p(f) + 1 ≥ (r − 1)v_p(f) + 1 ≥ r` for every `p ∣ f`. Hence

`#H_{q,f}/#H_q ≥ 1 − ω(f)·2^{−r}`,

with `ω(f)` the number of distinct primes of `f`. So for every `ε > 0`, choosing `r` with
`ω(f)·2^{−r} < ε·#G` and an auxiliary prime of that level gives `1/#G − ε < c_q`.

⚠ *Nearby false statement:* `c_q = 1/#G` for a single `q` would make 8C.8 immediate and 8C.7
unnecessary. It is false: `H_{q,f}` is a proper subset of `H_q` whenever `f > 1`. A bound that is
uniform in `q` but strictly below `1/#G` is also not enough, because 8C.8 needs the sum of the
bounds over `G` to reach `1`.

*Prerequisites:* Layers 8C.1, 8C.6.

**8C.8 The abelian theorem.** `HasDirichletDensity {𝔭 ∣ Frob_𝔭 = σ} (1/#G)` for `L/K` abelian.

The fibres over the `#G` elements of `G` are pairwise disjoint. Their union is the set of
unramified primes, which has density `1` by 8A.3. Milestones 8C.6 and 8C.7 give each fibre a
lower bound approaching `1/#G`, and the squeeze of 8A.3 then forces equality.

*Prerequisites:* Layers 8A.3, 8C.6, 8C.7.

#### 8D: the general case, by fixed fields

Let `L/K` be finite Galois with group `G`, let `σ ∈ G` have order `f`, let `C` be the conjugacy
class of `σ`, and let `E = L^{⟨σ⟩}`.

**8D.1 `L/E` is cyclic**, of degree `f`, with group `⟨σ⟩`.
*Prerequisites:* Mathlib `IsGalois`, the Galois correspondence.

**8D.2 Frobenius in `L/K` against Frobenius in `L/E`.** Let `𝔓` be a prime of `E` unramified in
`L`. State and prove the exact relation between `frobeniusClass E L 𝔓` and
`frobeniusClass K L (𝔓 ∩ 𝓞_K)`, using the tower compatibility of 8.0.
*Prerequisites:* Layers 8.0, 8D.1.

**8D.3 The relevant primes of `E`.** The set to which 8C is applied is
`{𝔓 ∣ 𝔓 unramified in L, frobeniusClass E L 𝔓 = {σ}}`. Milestone 8A.4 lets it be intersected
with the primes of `E` of degree one over `K` at no cost. Say once which set is meant.
*Prerequisites:* Layers 8A.4, 8D.2.

**8D.4 The fibre count.** Each prime `𝔭` of `K` with `frobeniusClass K L 𝔭 = C` has exactly
`#G/(#C · f)` primes of `E` in the set of 8D.3, all of residue degree `1` over `K`. Every prime of
`E` in that set lies over such a `𝔭`.

⚠ The set of 8D.3 is the one with relative Frobenius **`σ`**, not the identity. The
split-completely fibre is a different set. The smallest case shows the difference: take `L/K`
cyclic with `σ` a generator and `σ ≠ 1`, so `⟨σ⟩ = G` and `E = L^{⟨σ⟩} = K`. Then `#C = 1`,
`f = #G`, and the displayed count is `#G/(1·#G) = 1` — the prime `𝔭` is its own fibre, with
relative Frobenius `σ`. The set of primes of `E = K` with relative Frobenius `1` is empty. That
case is a mandatory test of this milestone.

⚠ `σ ≠ 1` is part of the test. At the identity extension `L = K` with `σ = 1` the generator
condition still holds, both sets are `{𝔭}`, and the second count is `1` rather than `0`. The test
exists to separate the two fibres, so it has to exclude the case where they coincide.

⚠ `E` is the fixed field of `⟨σ⟩`, and that has to be said. `[L:E] = ord σ` says only that the
degree is right; every step here uses that `Gal(L/E)` *is* `⟨σ⟩`, so state it as: an element
`σ_E` of `Gal(L/E)` restricting to `σ`, generating `Gal(L/E)`.

*Source:* Milne, *Class Field Theory*, VIII 7.4, whose explicit bijections are the plan for the
proof.
*Hypotheses:* the number `#G/(#C · f)` equals `#C_G(σ)/f`, which is a positive integer because
`⟨σ⟩ ⊆ C_G(σ)`. State it in that form as well, since the integrality is not visible in the first
form.
*Nearby false statement:* the count is not `#C·f/#G` and not `1`. A consistency check: with the
density `1/f` from 8C over `E`, milestone 8A.5 gives `1/f = k · (#C/#G)`, so `k = #G/(#C·f)`.

⚠ This is where the conjugacy class, the two kinds of prime, and the degree-one condition all
meet. It is the one computation of the layer that needs care.

*Prerequisites:* Layers 8.0, 8D.1, 8D.2, 8D.3.

**8D.5 The Chebotarev density theorem.** Apply 8C over `E` to get density `1/f` for the set of
8D.3. Then apply 8A.5 with `k = #G/(#C · f)`. The result is

`HasDirichletDensity {𝔭 ∣ IsUnramifiedAt K L 𝔭 ∧ frobeniusClass K L 𝔭 = C} (#C/#G)`

for an arbitrary number field `K`, not only for `K = ℚ`.

*Prerequisites:* Layers 8A.5, 8C.8, 8D.3, 8D.4.

**8D.6 Corollaries.** Derive these three from 8D.5, and do not prove them twice.

- the exact-density form of each statement of 8A.8;
- the density `1/#G` of the primes that split completely in `L`;
- the splitting densities in a non-Galois extension, through its Galois closure.

*Prerequisites:* Layer 8D.5.

#### 8E: equidistribution in ray classes

For a modulus `𝔪` and a finite quotient `Q` as in 1.7, the primes prime to `𝔪₀` are
Dirichlet-equidistributed among the classes of `Q`, with density `1/#Q`.

The proof is analytic: 1.7 decomposes the partial zeta functions, 1.8 gives the equal residues,
7.5 gives the family, and 7.3 gives `L(χ, 1) ≠ 0` for each nontrivial character.

⚠ There is one proof here, not two. The classical second proof goes through Artin reciprocity and
therefore through class field theory, which is not a prerequisite of this roadmap. When the global
class field theory roadmap is accepted, comparing the two is worth doing, and
[`PROVENANCE.md`](PROVENANCE.md) records why.

*Source:* Neukirch VII (13.2); Milne VI 4.8.
*Prerequisites:* Layers 1.7, 1.8, 7.3, 7.5, 8A.1.

### Layer 9: the prime ideal theorem and natural densities

Layer 8 gives Dirichlet densities. A Dirichlet density does not imply a natural density, so the
natural-density form of Chebotarev is a separate theorem with its own proof. This layer supplies
that proof.

**9.1 Wiener–Ikehara.** Let `a : ℕ → ℝ` be nonnegative. Assume:

- `∑ a n · n^{-σ}` converges for every real `σ > 1`, so that `F(s) = ∑ a n · n^{-s}` is defined
  and analytic on `Re s > 1`;
- there is a function `G`, continuous on `{s ∣ 1 ≤ Re s}`, with `G s = F s − κ/(s − 1)` for every
  `s` with `Re s > 1`.

Then `∑_{n ≤ x} a n ∼ κ x`.

⚠ Both hypotheses are load-bearing. Without summability, Mathlib's `LSeries` takes a junk value
where the series diverges, and "F equals the L-series on `Re s > 1`" is satisfied by `F = 0` for a
rapidly growing nonnegative `a`; the conclusion is then false. And the boundary hypothesis must
name a separate continuous `G` rather than assert continuity of `s ↦ F s − κ/(s − 1)` on the
closed half-plane, since at `s = 1` that expression is a junk value on both summands.

This is a milestone of this roadmap and not an import. The hypotheses above are what the rest of
the layer may assume, and nothing weaker.

*Source:* Lang XV §§2–3 has a complete proof. PrimeNumberTheoremAnd has it as
`WienerIkeharaTheorem'`, sorry-free. Mathlib does not have it, at the pin or on master.
*Nearby false statement:* the conclusion fails for signed or complex coefficients. Milestone 9.7
therefore does not apply this theorem to a character twist.

*Prerequisites:* Mathlib `LSeries`, `LSeriesSummable`, `Filter.Tendsto`, Fourier analysis on `ℝ`.

**9.2 The ideal von Mangoldt series.** `−ζ_K'/ζ_K (s) = LSeries (idealCoeffOfWeight Λ_K) s` on
`Re s > 1`, with `Λ_K` from 7.6, together with the summability that 9.1 requires.
*Prerequisites:* Layers 1.4, 7.6.

**9.3 `ψ_K(x) ∼ x`,** where `ψ_K(x) = ∑_{𝔑𝔞 ≤ x} Λ_K(𝔞)`. Apply 9.1 to 9.2 with `κ = 1`. The
boundary function `G` comes from 7.4: the pole of `ζ_K` at `s = 1` supplies `κ/(s−1)`, and the
absence of zeros on `Re s = 1` makes the difference continuous up to the line.
*Prerequisites:* Layers 7.4, 9.1, 9.2.

**9.4 `θ_K(x) ∼ x`,** where `θ_K(x) = ∑_{𝔑𝔭 ≤ x} log 𝔑𝔭`. The difference `ψ_K − θ_K` is the
contribution of the prime powers `𝔭^m` with `m ≥ 2`, which is `O(√x log² x)`. Prove that bound.
*Prerequisites:* Layers 7.6, 9.3.

**9.5 Primes of residue degree above one contribute nothing.** The primes with `𝔑𝔭 = p^f` and
`f ≥ 2` contribute `O(√x log x)` to `θ_K`, so `θ_K` is asymptotically the sum over the
degree-one primes. This is the counting form of 8A.4.
*Prerequisites:* Layer 9.4.

**9.6 The prime ideal theorem.** `π_K(x) ∼ x/log x`, from 9.4 by partial summation.

At `K = ℚ` this is the prime number theorem. The milestone there is an agreement theorem with
PrimeNumberTheoremAnd's `pi_asymp`, and not a second proof of it. Nothing in this roadmap
reproves the rational prime number theorem.

*Source:* Landau; Lang XV Thm 4.
*Prerequisites:* Layers 9.4, 9.5; Mathlib `AbelSummation`, `Nat.primeCounting`.

**9.7 Counting in a cyclotomic Frobenius fibre.** Fix `m` and `σ ∈ Gal(K(ζ_m)/K)`, and define the
**nonnegative** coefficient

`a_σ(n) = ∑_{𝔑𝔭^m = n, m ≥ 1, Frob_𝔭^m = σ} log 𝔑𝔭`,

the sum over prime powers of norm `n` whose Frobenius, raised to the exponent, is `σ`. By
orthogonality, 8B.3, its Dirichlet series is the finite combination
`(#G)⁻¹ ∑_χ conj(χ σ) · (−L'/L)(χ, s)`, and that identity is a **theorem** about this sequence,
not a hypothesis imposed on it.

⚠ The condition is `Frob_𝔭^m = σ` and not `Frob_𝔭 = σ`. The logarithmic derivative of the Euler
factor at `𝔭` is `∑_{m ≥ 1} χ(Frob_𝔭)^m log 𝔑𝔭 · 𝔑𝔭^{-ms}`, and `χ(Frob_𝔭)^m = χ(Frob_𝔭^m)`, so
orthogonality isolates the `m`-th power. The test is a quadratic cyclotomic extension: at an
inert `𝔭` the Frobenius is the nontrivial `g`, but `g² = 1`, so the `𝔭²` term belongs to the
*identity* fibre. A coefficient filtered on `Frob_𝔭 = σ` drops it, and then the orthogonality
identity is not provable for the named sequence.

⚠ Two more things the orthogonality identity needs, and 8B.1 supplies. First, `Gal(K(ζ_m)/K)`
must be **abelian**: the characters here are one-dimensional, and those separate elements only in
the abelianization, so over `S₃` every one-dimensional character agrees at the identity and at a
three-cycle and the character sum returns `1` where the indicator returns `0`. Second, the ideal
weight of a character must be the **named** cyclotomic one of 8B.1, whose bad set is exactly the
ramified primes and which vanishes there. A weight merely *specified* at the unramified primes may
be nonzero at a ramified one, and the right-hand side runs over every prime while `a_σ` excludes
the ramified ones.

In the combination, the trivial character contributes the pole `1/(s−1)`, and each nontrivial
character contributes a function continuous up to `Re s = 1`, by 7.4 with the family of 8B.2.
Apply 9.1 to `a_σ` with `κ = 1/#G`, and then remove the prime powers as in 9.4 and 9.5. The
result is

`#{𝔭 ∣ 𝔑𝔭 ≤ x, Frob_𝔭 = σ} ∼ (1/[K(ζ_m):K]) · x/log x`.

⚠ Do not apply 9.1 to an individual character twist. The coefficients `χ(𝔞) Λ_K(𝔞)` are signed or
complex, and 9.1 is a theorem about nonnegative coefficients. The orthogonality step above is what
makes the coefficients nonnegative before the Tauberian theorem is used.

*Prerequisites:* Layers 7.4, 7.6, 8B.2, 8B.3, 9.1, 9.4, 9.5.

**9.8 The count-side contraction lemma.** The counting analogue of 8A.5: with the hypotheses of
8A.5, if the primes of `E` in `S` satisfy `#{𝔓 ∈ S ∣ 𝔑𝔓 ≤ x} ∼ c · x/log x`, then
`#{𝔭 ∈ T ∣ 𝔑𝔭 ≤ x} ∼ (c/k) · x/log x`. The degree-one hypothesis is what identifies the two
norms, and the error terms transport because `k` is a constant.
*Prerequisites:* Layers 8A.4, 8A.5, 9.5.

**9.9 The count-side crossing and abelian case.** Repeat 8C.4 to 8C.8 with 9.7 in place of
8B.5, and with counting asymptotics in place of densities. Three steps:

1. the tagged fibres of 8C.5, counted with 9.7 over the fixed field `E`, give
   `#{𝔭 ∣ Frob_𝔭 = σ, 𝔑𝔭 ≤ x} ≥ c_q · x/log x · (1 + o(1))` for each auxiliary `q`, with the
   same constant `c_q` as 8C.6;
2. milestone 8C.7 makes `c_q` approach `1/#G`;
3. the `#G` fibres partition the unramified primes, whose total count is `π_K(x) ∼ x/log x` by
   9.6, so the lower bounds squeeze each fibre to `(1/#G) · x/log x`.

⚠ Name the `o(1)` transport at each step. It is uniform in `x` for a fixed `q`, and the limit in
`q` is taken after the count, not inside it. Reversing the two limits is the error this milestone
exists to prevent.

*Prerequisites:* Layers 8C.5, 8C.6, 8C.7, 9.6, 9.7, 9.8.

**9.10 Natural-density Chebotarev.** Apply 9.9 over `E = L^{⟨σ⟩}` and then 9.8 with
`k = #G/(#C · f)` from 8D.4. The result is `π_C(x) ∼ (#C/#G) · x/log x`, and
`HasNaturalDensity {𝔭 ∣ frobeniusClass K L 𝔭 = C} (#C/#G)`.

⚠ This is not a formal consequence of Layer 8. The two arguments share a skeleton and differ in
what is transported through it. The roadmap asks for both, because neither implies the other.

*Prerequisites:* Layers 8D.4, 8D.5, 9.8, 9.9.

**9.11 Natural-density equidistribution in ray classes.** For a modulus `𝔪` and the ray class
group of 1.7, the primes prime to `𝔪₀` are equidistributed among the classes by **natural**
density, with density `1/#(J^{𝔪₀}/P^𝔪)`.

The proof is 9.7 and 9.9 run over the **ray-class** family of 7.5 in place of the cyclotomic
family of 8B.2, and nothing else changes: 9.7's nonnegative coefficient is the von Mangoldt
weight summed over the ideals in one ray class, 8B.3's orthogonality is replaced by orthogonality
for the characters of `J^{𝔪₀}/P^𝔪`, and the boundary continuation comes from 7.4 with the family
of 7.5. Name that milestone; it is a different Tauberian input from 9.7's, and 8E gives only the
Dirichlet form.

*Prerequisites:* Layers 1.7, 7.4, 7.5, 8E, 9.1, 9.4, 9.5.

**9.12 Mertens for `K`.** The two statements

`∑_{𝔑𝔭 ≤ x} 𝔑𝔭^{-1} = log log x + M_K + o(1)` and
`∏_{𝔑𝔭 ≤ x} (1 − 𝔑𝔭^{-1})^{-1} ∼ e^{γ} · κ_K · log x`, with `κ_K = Res_{s=1} ζ_K(s)`,

need more than 9.4 and 9.6, which give only the leading term.

⚠ The residue is part of the product constant. The familiar `e^{γ} log x` is the case `K = ℚ`,
where `κ_ℚ = 1`, so a formula that omits `κ_K` passes every rational check and is wrong over
every other field. Through the analytic class number formula the missing factor carries `h`, `R`,
`w`, `|d_K|`, and the signature. Test it at `K = ℚ(√−5)`, where `κ_K = π/√5`.

*Source:* Rosen; Garcia–Lee, *Unconditional explicit Mertens' theorems for number fields and
Dedekind zeta residue bounds*, Theorem 1.

The chain is:

1. the logarithmic Euler product near `s = 1`: `log ζ_K(s) = ∑_𝔭 𝔑𝔭^{-s} + H(s)` with `H`
   analytic on `Re s > 1/2`, from 1.4;
2. `∑_𝔭 𝔑𝔭^{-s} = log(1/(s−1)) + C_K + o(1)` as `s → 1⁺`, from 1.9 and the analyticity of `H`;
3. the passage from the Dirichlet-series asymptotic to the partial sum, by 9.4 and partial
   summation, which is where the constant `M_K` is extracted;
4. the passage from the sum to the product, by expanding `log(1 − t)⁻¹` and bounding the tail
   `∑_𝔭 ∑_{m ≥ 2} 𝔑𝔭^{-m}/m`. ⚠ Convergence of that tail is a **sub-milestone here**, proved
   from `𝔑𝔭 ≥ 2` and the Euler product of 1.4 at `s = 2`, and not a hypothesis carried on the
   final theorem. It is where the two constants separate, so a statement that assumes it assumes
   the step the milestone exists to take.

*Prerequisites:* Layers 1.4, 1.9, 9.4, 9.6.

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
- **Hecke's equidistribution of Gaussian primes** (Layer 7.8). This test detects an infinity-type
  interface that typechecks and cannot be instantiated.
- **The split prime in `ℚ(i)`** (Layer 1.5). At `𝔭` above `5`, `idealCoeff K 5 = 2` while the
  coefficient of `T` in the local factor `(1 − T)⁻¹` at `𝔭` is `1`. This test detects a local
  Euler-factor predicate that reads the norm-grouped coefficient instead of the value at a power
  of the prime.
- **The Euclidean dual of `ℤ[i]`** (Layer 2.11). The mixed lattice of `𝓞_{ℚ(i)}` is `ℤ[i] ⊂ ℂ`,
  which is Euclidean self-dual. The different is `(2i)`, so the trace dual is `(1/2)ℤ[i]`, and
  `traceToEuclidean` sends that to `ℤ[i]`. This test detects the claim that the analytic dual is
  the embedded trace dual, which is false here. It also fixes the determinant: `(1/2)ℤ[i]` has
  covolume `1/4` and `ℤ[i]` has covolume `1`, so `|det| = 4 = 4^{r₂}`, and a recorded value of
  `2^{r₂}` is wrong by a square.
- **The tagged count in `C₄`** (Layer 8C.7). With `n = 4` and `f = 2`, the formula
  `#H_{q,f} = n ∏_{p ∣ f}(1 − p^{−(v_p(n) − v_p(f) + 1)})` gives `4(1 − 1/4) = 3`, and the
  elements of `C₄` of order divisible by `2` are `g`, `g²`, `g³`. This test detects an off-by-one
  in the exponent, which is invisible when `v_p(n) = v_p(f)`.
- **One generator is not enough** (Layer 8C.6). Taking a single `τ` gives
  `c_q = 1/(#G(q−1))`, which tends to `0`. This test detects a crossing argument that tags one
  fibre instead of all of `H_{q,f}`, which no typecheck and no single numerical case will find.
- **The Grossencharacter with a nonzero shift** (Layer 6.1). Take `K = ℚ`, `χ_unit = 1`, and
  `σ = 1`, so `χ(𝔞) = 𝔑𝔞`. Check that the structure admits it. A structure whose full weight is an
  `IdealWeight` does not: `norm_eq_one` would force `‖χ(p)‖ = 1` at cofinitely many primes. This
  test detects a carrier that typechecks and excludes every character Layer 6 exists for.
- **The cyclotomic factorization at `n = 4`** (Layer 4.4). The primitive product is
  `ζ(s) L(s, χ₋₄)`, with no correction factor, and it agrees with Layer 4.2. This test detects a
  correction factor with the wrong sign of the exponent.
- **A residue that sums correctly** (Layer 1.8). At `𝔪 = 1` the `h_K` class partial zeta
  functions each have residue `ρ_K`, and their residues sum to `Res_{s=1} ζ_K`. This test detects
  a residue divided by the class number.
- **The isolated value** (Layers 0.3, 3.5). Take a continuation, change its value at one point
  away from the poles, and check that the modified function still satisfies every condition of
  `HasMeromorphicContinuation` except analyticity. This test detects a data model whose
  representative is unconstrained away from its poles, and it is why 0.3 has an analyticity
  field.
- **The twisted trivial character does not cancel** (Layer 7.2). At `K = ℚ`, the weight
  `n ↦ n^{it}` has `∑_{n ≤ X} n^{it} ∼ X^{1+it}/(1+it)`, of size comparable to `X`, while
  `HasCancellation` at degree one demands `O(1)`. This test detects a `CancellingFamily` whose
  norm-twist condition is imposed on the trivial member, which no example satisfies.
- **A nonabelian crossing gives the wrong density** (Layer 8C.5). In `S₃ × C₂`, the class of a
  transposition paired with the nontrivial element has size `3`, so its fibre has density
  `3/(6·2)` and not `1/(6·2)`, and two conjugate transpositions give the *same* fibre. This test
  detects crossing contracts stated over an abstract product decomposition with no abelianness.
- **The cyclic fixed field** (Layer 8D.4). For `L/K` cyclic with `σ` a generator, `E = K`, the
  count is `1`, and the one prime in the fibre has relative Frobenius `σ`. The set with relative
  Frobenius `1` is empty. This test detects the split-completely fibre used in place of the `σ`
  fibre.
- **The inert prime squared** (Layer 9.7). In a quadratic cyclotomic extension, an inert `𝔭` has
  `Frob_𝔭 = g ≠ 1` but `Frob_𝔭² = 1`, so the `𝔭²` term belongs to the identity fibre. This test
  detects a von Mangoldt fibre coefficient filtered on `Frob_𝔭 = σ` instead of `Frob_𝔭^m = σ`.
- **Mertens away from `ℚ`** (Layer 9.12). At `K = ℚ(√−5)` the residue is `κ_K = π/√5 ≠ 1`, so
  `∏_{𝔑𝔭 ≤ x}(1 − 𝔑𝔭^{-1})^{-1} ∼ e^{γ} κ_K log x` differs from `e^{γ} log x`. This test detects a
  product constant that omits the Dedekind-zeta residue, which every rational check passes.
- **The infinite fibre** (Layer 1.7). A ray class contains infinitely many integral ideals, so its
  partial zeta function is a `tsum`. This test detects a `finsum`, which is the junk value `0`
  there and makes every later statement about that constant.
- **The zero ideal is not a good ideal** (Layer 7.2). At the modulus with finite part `1` the bad
  set is empty, so a "prime to the bad set" condition holds vacuously at `I = ⊥` — divisibility of
  ideals is reverse inclusion, so `𝔭 ∣ ⊥` for every `𝔭`. Every weight sends `⊥` to `0`, so a
  trivial-member law without `I ≠ ⊥` is unsatisfiable there. This test detects a family package
  that no class-group family inhabits.
- **The totally ramified tower** (Layer 8.0). With `Q` totally ramified over `𝔭` and `E = L`, the
  residue degree is `1` and every `σ ∈ Gal(L/K)` is a Frobenius at `Q`, so no equality
  `τ = σ^{f}` with `τ ∈ Gal(L/L) = {1}` can hold for `σ ≠ 1`. This test detects a tower statement
  that omits unramifiedness.
- **One-dimensional characters do not separate `S₃`** (Layers 8B.1, 9.7). Every one-dimensional
  character of `S₃` agrees at the identity and at a three-cycle, so a character sum returns `1`
  where the `Frob^m = σ` indicator returns `0`. This test detects an orthogonality identity stated
  for an arbitrary finite Galois extension instead of an abelian one.
- **A Grossencharacter with a nonzero shift** (Layers 6.4, 7.7). Its L-series is the unitary one
  translated by `σ`, so its boundary is `Re s = 1 + σ`. This test detects a nonvanishing export
  stated at `Re s = 1` for the full quasicharacter, and a nonvanishing package indexed by a finite
  group, which no infinite-order character belongs to.
- **The quadratic character** (Layer 7.2). A nontrivial quadratic ray-class character `η` has
  `η² = 1` on the good ideals, so `η²` has linear partial sums and does not cancel, while
  `L(η, ·)` is entire and nonvanishing on `Re s = 1`. This test detects a nonvanishing package
  that demands cancellation of the square outright.
- **The quadratic times a norm twist** (Layer 7.2). `χ = η 𝔑^{iu}` with `u ≠ 0` is unitary of
  infinite order and is not the norm-character exception, yet `χ² = 𝔑^{2iu}` is trivial after
  the twist by `−2u`. This test detects the same defect inside the regime the single-character
  package was introduced for, so finite order is not the issue.
- **The pure norm character** (Layers 6.4, 7.7). `χ = 𝔑^{σ}` has `L(χ, s) = ζ_K(s − σ)`, so
  `Λ_χ` has poles at `σ` and `1 + σ` while `Λ_χ(1 − s)` has poles at `−σ` and `1 − σ`. This test
  detects a functional equation reflecting against the conjugate at `1 − s` instead of against
  the inverse, and it is invisible whenever `σ = 0`.
- **The pure norm character inhabits the carrier** (Layer 6.1). Over `K = ℚ` with modulus `1`,
  `χ = 𝔑^{σ}` for arbitrary real `σ` must typecheck and discharge compatibility. A carrier whose
  compatibility law mixes a finite `𝔑^{σ}` with unitary archimedean factors forces `σ = 0`, and
  then every shifted statement in Layers 6.4 and 7.7 is vacuous. This is a non-vacuity test, and
  no green build detects its absence.
- **The ramified character inhabits the carrier** (Layer 6.1). A nontrivial even Dirichlet
  character mod `5` satisfies no `χ_f`-free law over all coprime `α` (`α = 2` reads
  `χ(2) · 1 = 1`), and the pair with trivial weight and parity `1` over `ℚ` mod `∞` satisfies
  the law restricted to `α ≡ 1 mod^× 𝔪` while being no character at all. The two witnesses
  together force the finite character as a field and the law over every coprime `α`; the
  embedding of every ray-class character is the non-vacuity construction.
- **The odd character survives primitive reduction** (Layers 6.1, 6.4). Without a law supporting
  parity on `𝔪_∞`, no structure field reads the infinite part, so every term is induced from
  the modulus with empty infinite part: the primitive odd character modulo `4` over `ℚ` is then
  never primitive at `(4)∞`, its Layer 6 conductor drops the real place its `Γ_ℝ(s+1)` reads,
  and every finite-order comparison is vacuous for odd characters. This test detects a carrier
  whose moduli carry an infinite part that nothing observes.
- **Inflation is a units-pullback, not a ring composition** (Layer 6.1). The residue projection
  carries nonunits to units (`3 mod 6 ↦ 1 mod 2`), so composing the conductor-one character
  with it gives the all-one map on `𝓞_K/(p)` where the inflated character is `0` off the
  units. This test detects a finite character carried without its canonical zero extension.
- **The radial sign, over `ℚ`** (Layers 6.1, 6.4). The unitary norm twist `𝔑^{iu}` has
  compatibility `n^{iu} · n^{-it} = 1`, so `t = u` and the single real gamma shift is `−iu`,
  matching `Γ_ℝ(s − iu) ζ(s − iu)` with poles at `iu` and `1 + iu`. With the positive radial
  sign the shift is `+iu` and the product `Γ_ℝ(s + iu) ζ(s − iu)` has no pole at `iu` and
  infinitely many on `Re s < 0`, so the card's polar divisor and continuation predicate fail.
- **The complex multiplicity, over `ℚ(i)`** (Layers 6.1, 6.4). With the normalized absolute
  value `‖z‖_v = (v z)²` the same twist has parameter `t = u` at the complex place and gamma
  shift `−iu`; with the plain `v z` the parameter is forced to `2u` and the shift to `−2iu`,
  against the `ζ_{ℚ(i)}(s − iu)` the series is.
- **The two `|d_K|`-constants of the shifted card** (Layer 6.4). The card of `𝔑^{iu}` completes
  to `|d_K|^{iu/2} · Λ_K(s − iu)` and has root number `|d_K|^{iu}`, both forced by the conductor
  power `|d_K|^{s/2}`, and both equal to `1` over `ℚ`. This test detects a norm-twist card
  written as the bare shifted completion with root number `1`, which only a field with
  `|d_K| ≠ 1` can see.
- **`𝔑²`, `𝔑³`, and `𝔑^{√2}`** (Layer 6.1). The square is algebraic with real-place exponent
  `p_v = 2`, which a dictionary `p_v = ε_v` rejects; the cube is algebraic with parity `0`,
  which a dictionary `ε_v ≡ p_v (mod 2)` rejects; and `𝔑^{√2}` has every `t_v = 0` yet is not
  algebraic, which an `IsAlgebraic` reading only the parameters accepts. Three tests, three
  wrong dictionaries.
- **Primitive reduction is one bundle** (Layer 6.1). Two reductions of the same character must
  be **equal as bundles** — conductor and, across that equality, the primitive character. A
  uniqueness statement whose conclusion repeats a field of one bundle and never compares the
  other proves only conductor uniqueness, and every "canonical" analytic object then depends on
  a choice.
- **The recentered card agrees with itself** (Layers 0.2, 6.4). With `A = |d_K|𝔑𝔣₀`, the card's
  Dirichlet agreement needs `A^{s/2}γ(s)L_unit(s)` while `Λ_full(s + σ)` gives
  `A^{(s+σ)/2}γ(s+σ)L_unit(s)`. This test detects a completion defined by the unshifted formula
  instead of by recentering, and the discrepancy is exactly a conductor factor and a gamma shift.
- **The root number is not an involution up to conjugation** (Layer 6.2). Applying the functional
  equation twice forces `W(χ)W(χ⁻¹) = 1`. The form `W(χ⁻¹) = conj(W(χ))⁻¹` equals `W(χ)`, hence
  `W² = 1`. This test detects a root-number law that silently restricts to `±1`.
- **The odd real character has an inverse** (Layer 6.4). At a real place with parity `ε_v = 1`,
  the inverse unitary local character is `sgn(x)^{-1}‖x‖_v^{-iq} = sgn(x)‖x‖_v^{-iq}`, so the
  parity is unchanged. This test detects an inverse that negates the parity, which would give
  `ε_v = −1`, outside `{0, 1}`, and make the inverse of every odd real character uninhabitable.
- **The conjugate swaps at a complex place** (Layer 6.4). `conj(z^{-p}z̄^{-p̄}) = z^{-p̄}z̄^{-p}`, so
  conjugation exchanges the two exponents while inversion negates them. This test detects the two
  constructions being identified, which is invisible whenever `p_v = p̄_v`.
- **The principal character modulo `p`** (Layers 6.1, 6.4). Over `ℚ` it is a term of the carrier
  with trivial infinite data and shift `0`, and `L(s) = ζ(s)(1 − p^{-s})` has a pole at `s = 1`,
  although its finite part is not `1`. This test detects an entirety claim made for every term
  instead of for the primitive ones, an identity with `ζ_K` that omits the removed Euler
  factors, and a "canonical" card built from the presented coefficients with the primitive
  conductor — its canonical card is the ζ card, and its presented series gets none.
- **The vertical norm twist** (Layers 6.4, 7.2). `𝔑^{iu}` with `u ≠ 0` is nontrivial on the good
  ideals, but its L-function is `ζ_K(s − iu)`, with a pole at `1 + iu`. This test detects a polar
  exception restricted to real powers, and a nonvanishing package whose exclusion is "not
  trivial" instead of "not a pure norm twist".
- **Wiener–Ikehara needs summability** (Layer 9.1). For a rapidly growing nonnegative `a`,
  Mathlib's `LSeries a` is the junk value `0` off the region of convergence, so `F = 0` and
  `κ = 0` satisfy an equality hypothesis while `∑_{n ≤ x} a n` is not `o(x)`. This test detects a
  Tauberian statement without a convergence hypothesis.
- **No elliptic-curve card** (Layer 0.7). Check that no continuation predicate and no functional
  equation predicate is asserted for `WeierstrassCurve.LSeries`.

## Ordering and parallelism

The layer numbers are a filing system, not a schedule. Milestone prerequisites are what a
contributor selects work by, and a few of them cross layers. The graph below is at the milestone
level, and it is acyclic.

Within a layer, the milestones are in prerequisite order, so `n.i` never needs `n.j` with
`j > i`. The edges that leave a layer are these, and there are no others:

| Edge | From | To | Why |
|---|---|---|---|
| a | 1.2 | 7.1 | `HasCancellation` is a predicate on the ideal weight of 1.2 |
| b | 1.6, 1.7 | 7.5 | the ray-class family's cancellation is the counting estimate |
| c | 1.6, 1.7 | 8B.2 | the same, for the cyclotomic family |
| d | 2.13, 2.14 | 3.3, 3.4 | the theta identity and the level frame |
| e | 2.13, 2.14, 3.2 | 5.7 | the same, with character weights |
| f | 2.9, 2.13, 2.14 | 6.3, 6.4 | the weighted theta series |
| g | 3.7 | 4.2, 4.4, 7.4 | statements about the continued zeta function |
| h | 5.1, 5.3 | 7.4, 7.5 | the ray-class family and its continuation |
| i | 6.1, 6.4 | 7.7, 7.8 | the Grossencharacter export and the Gaussian-prime example |
| j | 7.1 to 7.6 | 8A, 8B, 8E | Landau, nonvanishing, and logarithmic derivatives |
| k | 8.0 | 8A.8, 8B.1, 8C, 8D | the Frobenius class |
| l | 8B.1 | 8B.2 | the cyclotomic family needs the Frobenius formula |
| m | 7.4, 7.6, 8B.2, 8B.3 | 9.7 | the Tauberian input for one fibre |
| n | 8C, 8D | 9.9, 9.10 | the count-side repeat of the crossing and fixed-field steps |

Two edges deserve comment, because an earlier arrangement of this roadmap had them wrong.

Edge **l** with edge **c** used to be a cycle: the cyclotomic family's cancellation sat in
Layer 7 and needed 8B.1, while 8B's density theorem needed Layer 7. It is broken by keeping only
the general hypothesis package in Layer 7, milestone 7.2, and putting each instantiation with the
family it describes: the ray-class one in 7.5, and the cyclotomic one in 8B.2.

Edge **i** is why the Grossencharacter nonvanishing and the Gaussian-prime example are
milestones 7.7 and 7.8, and not milestones of Layer 6. They need 7.4, and Layer 6 does not.

What can be built at the same time:

- **Layers 0 and 1** come first. Layer 1 needs Layer 0 only for where the Euler-factor data
  lives, so the two can be built together.
- **Layer 2** needs nothing after 1.1, and 2.1 to 2.9 need no arithmetic at all. It is the
  largest piece that one contributor can take on alone.
- **Layer 4** needs 1.4 and 3.7, and nothing else.
- **Layers 7.1 to 7.6, then 8** need Layer 1 and Layer 3.7. They do not need the functional
  equation, and every milestone of Layer 8 is independent of the global class field theory
  roadmap.
- **Layer 9** needs 7.4, 7.6, 8B, 8C, and 8D.

A development of the zeros program starts where Layer 9 ends. It needs 0.1 to 0.4, 3.6, 3.7,
5.7, 5.8, 7.4, and 7.6 of this roadmap, and nothing else. Those are the durable exports listed
under *Interfaces supplied to other roadmaps*.

The interface with the integral lattices roadmap is the shared table under *Dependencies*.
Nothing crosses between the two roadmaps except through a row of it.

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
