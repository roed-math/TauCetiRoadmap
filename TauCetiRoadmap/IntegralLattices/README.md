# Roadmap: integral quadratic forms and lattices

Mathlib has the raw materials for lattices without their arithmetic: quadratic maps
over arbitrary commutative semirings (`QuadraticMap`, with the companion/polar calculus
working over ℤ), symmetric bilinear forms with Gram matrices
(`LinearMap.BilinForm.toMatrix`) and a 2-invertibility-free base change
(`LinearMap.BilinForm.baseChange`), the Smith normal form over PIDs with the
index-equals-determinant theorems (`Submodule.natAbs_det_basis_change`,
`Submodule.quotientEquivPiZMod`), a dual-submodule construction whose own docstring
asks for exactly this roadmap (`LinearMap.BilinForm.dualSubmodule`, TODO: "Properly
develop the material in the context of lattices"), analytic ℤ-lattices with covolume
and lattice-point counting (`Mathlib/Algebra/Module/ZLattice/`), an actively developed
abstract root-system library (`Mathlib/LinearAlgebra/RootSystem/`) with the concrete
Cartan matrices including `CartanMatrix.E₈`, and the Jacobi theta functions with their
modular transformation laws (`Mathlib/NumberTheory/ModularForms/JacobiTheta/`). But it
has **none of the arithmetic theory of integral lattices**: no even/odd theory, no
unimodular lattices, no discriminant groups or discriminant forms, no genus, no Jordan
splittings or Conway–Sloane symbols, no class-number finiteness, no spinor genus, no
mass formula, no Nikulin existence/uniqueness/embedding theory, and no theta series of
a lattice (verified at the pin `9caeba1000` and re-verified on master 2026-07-30: the
five relevant directories are file-for-file unchanged since the pin, and code searches
for `IsUnimodular`, `IntegralLattice`, `discriminantGroup`, "even lattice",
`thetaSeries` return zero hits). This roadmap builds that arithmetic — through its
classical summits: the classification of even unimodular lattices in low rank, the
Smith–Minkowski–Siegel mass formula in the Conway–Sloane normalization, and Nikulin's
discriminant-form theory of existence, uniqueness, and primitive embeddings, the
toolkit of K3-surface theory. It serves the LMFDB's lattice section (five-component
numeric labels, with the genus data stored as Conway–Sloane genus symbols) and the K3
pipeline (genus enumeration validated by masses; primitive-embedding criteria).

Suggested homes, mirroring Mathlib's directory conventions:
- `TauCeti/LinearAlgebra/QuadraticForm/IntegralLattice/` — Layers 0–2: the
  lattice-with-form structures, the bilinear/quadratic dictionary, dual lattices,
  discriminant groups and finite quadratic forms, definite reduction and automorphism
  groups. Mathlib keeps `QuadraticForm`, `BilinearForm` — including
  `BilinearForm/DualLattice.lean`, whose TODOs Layer 1 discharges — under
  `LinearAlgebra/`, and the [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4) (roadmap in preparation) puts the
  ambient form theory at `TauCeti/LinearAlgebra/QuadraticForm/`; the lattice theory
  stays next to both.
- `TauCeti/NumberTheory/IntegralLattice/` — Layers 3–8: localizations and Jordan
  theory, the genus and its symbols, class numbers and spinor genera, Nikulin's
  theory, unimodular classification, the mass formula, theta series. This is
  arithmetic, and it sits beside `TauCeti/NumberTheory/Padics/QuadraticForm/`, the
  quadratic-form-invariants home for the local classification it consumes.

**Scope exclusions** (choices, not omissions; separate roadmaps own or will own them):
the invariant theory of quadratic forms over fields — square classes, Witt theory,
Hasse invariants, the Hilbert symbol, the `(dim, d±, s)` local classification — is the
[quadratic form invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4)'s and is
consumed here, never rebuilt; local-field structure theory is the
[local fields roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s (roadmap in preparation; this
roadmap needs only `ℤ_p`, and states which results generalize to rings of integers of
nonarchimedean local fields as hypothesis swaps); root-system combinatorics and the
ADE classification are the
[root systems roadmap](../RepresentationTheory/RootSystems/README.md)'s — we own the
*integral-lattice packaging* of `Aₙ/Dₙ/E₆/E₇/E₈`, they own `RootPairing`, Weyl groups,
and `DynkinType`; the general analytic lattice-Poisson and theta-transformation engine is
owned by [LFunctions Layer 2](https://github.com/roed-math/TauCetiRoadmap/pull/8), and Layer 8 consumes its precise
`ZLattice`/dual/covolume interface. Modular-form packaging is **out of scope**: roadmap PR
#47 does not currently supply a theorem proving modularity of theta series of even
lattices, and no future half-integral-weight project is treated as a dependency. Layer 8
therefore stops after convergence and the arithmetic specialization of the consumed theta
transformation; lattices over
rings of integers of number fields (O'Meara's Dedekind-domain generality) are a
natural future extension, flagged where the proofs are generic, but every statement
here is over ℤ and ℤ_p; algorithmic reduction (LLL) beyond what finiteness needs, the
deep theory of indefinite lattices beyond what Nikulin's theorems require
(automorphism groups of indefinite lattices, Borcherds' method), sphere-packing
optimality (the sphere-packing project's), and codes-to-lattices constructions are all
out of scope.

## Standing hypotheses and pinned conventions

Decide these once; every layer states its results against this table.

- **The lattice.** A lattice is a finite free ℤ-module with a symmetric integral
  bilinear form, carried unbundled: `L` with
  `[AddCommGroup L] [Module ℤ L] [Module.Free ℤ L] [Module.Finite ℤ L]`, the form
  `β : LinearMap.BilinForm ℤ L` with `hβ : β.IsSymm` as an explicit hypothesis (or as
  the primary structured object where a layer bundles it — the bundling decision is
  Layer 0's first design point, and either way no monolithic "lattice" class hides
  the module hypotheses). Rank is `Module.finrank ℤ L`. Everything is stated for
  possibly-degenerate `β` where degeneracy costs nothing, with
  `β.Nondegenerate` (⟺ Gram determinant ≠ 0, via
  `LinearMap.BilinForm.nondegenerate_iff_det_ne_zero`) an explicit hypothesis
  otherwise.
- **Bilinear versus quadratic — the factor-of-2 bookkeeping (⚠ the central
  convention).** The symmetric bilinear form `β` is the primary datum; the **norm** of
  `x` is `β x x` (Conway–Sloane's `x·x`), never silently halved. `L` is **even** when
  `2 ∣ β x x` for all `x`, **odd** otherwise. Even lattices are equivalent to integral
  quadratic forms: an even symmetric `β` is `Q.polarBilin` for a unique
  `Q : QuadraticForm ℤ L` with `Q x = β x x / 2` (built from `QuadraticMap`'s
  companion structure), and conversely `Q.polarBilin` is always symmetric and even
  with `Q.polarBilin x x = 2 * Q x`. Both directions and both round trips are Layer-0
  milestones. ⚠ Never use `QuadraticMap.associated`, `QuadraticForm.toMatrix`,
  `QuadraticForm.discr`, or `QuadraticForm.baseChange` in the integral theory: all
  require `Invertible (2 : R)`, false over ℤ; the polar/companion calculus and the
  bilinear Gram/base-change API are the 2-free routes (this is the load-bearing reason
  the roadmap is bilinear-first).
- **Gram matrices and the determinant.** The Gram matrix of `β` in a basis `b` is
  `LinearMap.BilinForm.toMatrix b β` (entries `β (b i) (b j)` —
  `BilinForm.toMatrix_apply`); the change-of-basis law is
  `toMatrix_mul_basis_toMatrix` (`Pᵀ G P`). Over ℤ a base change has determinant `±1`,
  so Gram determinants are **equal on the nose**: `det L : ℤ` is an honest invariant
  (Layer 0), not a square class. We say **determinant**, never "discriminant", for
  `det L`; "discriminant" is reserved for the discriminant *group* `A_L` and
  *form* `q_L`. The dictionary to the quadratic-form-invariants roadmap's
  square-class invariants of the rationalized form is a pair of stated lemmas:
  `d(β ⊗ ℚ) = [det L] ∈ ℚˣ/(ℚˣ)²` and `d±(β ⊗ ℚ) = (−1)^{n(n−1)/2}·[det L]` (their
  `discr`/`signedDiscr` convention table governs the right-hand sides).
- **Signature.** `(t₊, t₋) := (sigPos, sigNeg)` of the real form (base change of `β`
  to ℝ, then Mathlib's `sigPos`/`sigNeg`, whose `Equivalent`-invariance and Sylvester
  uniqueness are already upstream; ⚠ at the pin these two live in the *root*
  namespace, though their file's docstring says `QuadraticForm.sigPos` — re-check the
  name on the next toolchain bump). Notation and order follow Nikulin's
  `(t₍₊₎, t₍₋₎)`. `τ(L) = t₊ − t₋` is the **signature index** (Serre's `τ`).
  `PosDef` is `QuadraticMap.PosDef` of `LinearMap.BilinMap.toQuadraticMap β` — stated
  over ℤ directly (the predicate is order-theoretic and 2-free); **definite** means
  `PosDef` or `NegDef := PosDef (−β)`, **indefinite** means `t₊ > 0` and `t₋ > 0`
  under nondegeneracy. The transfer `PosDef over ℤ ⟺ PosDef of the ℝ-form` is a
  Layer-0 lemma (absent from Mathlib, whose `PosDef.det_pos`-style results are
  `RCLike`-walled).
- **Twists and sums.** `L(a)` is the same module with `a • β` (so `E₈(−1)` is the
  negative definite `E₈`); `⊕` is the orthogonal direct sum (forms summed over
  `L × M`), with Gram matrix the block sum. Isometry is
  `LinearMap.BilinForm.Equivalent` (Mathlib's bundled `IsometryEquiv` for bilinear
  forms); "class" always means isometry class over ℤ.
- **Dual lattice and discriminant form.** Realized in the ambient rational space
  `V = ℚ ⊗ L` with `B = β.baseChange ℚ`, the dual lattice is
  `L^⋆ = LinearMap.BilinForm.dualSubmodule B L` (Mathlib's construction; integrality
  of `β` is exactly `L ≤ L^⋆`). The **discriminant group** is `A_L = L^⋆/L`, finite of
  order `|det L|`, generated by ≤ rank L elements. The **discriminant bilinear form**
  is `b_L : A_L × A_L → ℚ/ℤ`; for **even** `L` the **discriminant quadratic form** is
  `q_L : A_L → ℚ/2ℤ` — ⚠ valued in `ℚ/2ℤ`, Nikulin's convention (Nikulin §1,
  point 3°),
  which is what makes `q_L` remember the evenness; sources valuing `q` in `ℚ/ℤ`
  differ by the factor of 2 the convention table already pins. Odd lattices carry
  only `b_L`. The **signature of a finite quadratic form** `sign q ∈ ℤ/8` is defined
  by Milgram's Gauss-sum formula and satisfies `t₊ − t₋ ≡ sign q_L (mod 8)`
  (Nikulin Theorem 1.3.3; explicit generator values Proposition 1.11.2).
- **Scale, norm ideal, level.** `𝔰(L) ⊆ ℤ` is the ideal generated by all `β x y`,
  `𝔫(L)` the ideal generated by all `β x x` (O'Meara §82E); `2𝔰 ⊆ 𝔫 ⊆ 𝔰`, and even
  ⟺ `𝔫 ⊆ 2ℤ`. The **level** of a nondegenerate integral `L` is the least `N > 0`
  such that `N·G⁻¹` is an integral matrix with even diagonal (`G` any Gram matrix;
  basis-independent) — equivalently, for even `L`, the least `N` with `N·q_L = 0`.
  This is the level in the LMFDB's lattice columns and the input a future
  theta-modularity project would consume; no modularity theorem is claimed here.
- **Genus symbols are Conway–Sloane's.** The `p`-adic symbols of SPLAG Chapter 15
  (mass-formula paper §§4–5 for the terminology used here): Jordan constituents
  `f_q` at scales `q = p^i`, with, for odd `p`, ranks and signs
  `ε = (det f_q | p) ∈ {±1}`, and, for `p = 2`, additionally the **type** (I/odd vs
  II/even) and **oddity** (trace mod 8; the mass paper's "octane value"), subject to
  the ⚠ non-uniqueness of dyadic Jordan splittings and the **sign-walking** and
  **oddity-fusion** equivalences on symbols. The 2-adic symbol calculus is *stated as
  Conway–Sloane define it and proved as Allcock–Gal–Mark prove it* — their paper
  (arXiv:1511.04614) is the first published proof of the calculus and **corrects an
  error in Conway–Sloane's canonical-form definition**; do not formalize the SPLAG
  canonical form without their fix. The LMFDB's stored genus data is exactly these
  symbols; the five label components (rank, determinant, level, class number, index)
  are data-semantics predicates of Layer 3/4.
- **Nikulin's triple.** Even lattices are governed by `(t₊, t₋, q)` — signature pair
  plus finite quadratic form. `l(A)` is the minimal number of generators of `A`.
  ⚠ Nikulin's own `E₈` is *negative* definite (signature `(0,8)`); ours is positive
  definite (Gram = `CartanMatrix.E₈`), so his statements are cited with the twist
  `E₈(−1)` made explicit. The K3 lattice is `Λ_{K3} = U³ ⊕ E₈(−1)²`, even unimodular
  of signature `(3,19)`.
- **Theta series.** `Θ_L(τ) = ∑_{x ∈ L} exp(πiτ·β(x,x))` for positive definite `L`
  — the SPLAG normalization `∑ q^{x·x}` with nome `q = e^{πiτ}`, chosen because
  Mathlib's `jacobiTheta τ = ∑ exp(πi n² τ)` is *literally* `Θ_ℤ` in it. ⚠ For even
  `L` this is a series in `e^{2πiτ}` with exponents the half-norms `Q(x)`; the two
  nomes (`e^{πiτ}` for norms, `e^{2πiτ}` for half-norms) are the theta instance of
  the factor-of-2 bookkeeping, and the translation is stated once, next to the
  definition.
- **Mass.** `m(G) = ∑_{cls L ∈ G} 1/|O(L)|` over the classes of a (positive definite)
  genus `G` — Conway–Sloane's normalization, their mass-formula paper eq. (1), with
  the formula in the shape of their eqs. (2)–(3) (standard mass × local corrections,
  eqs. (6)–(7)). ⚠ Their §§3, 6 warn that the formula *as normally stated* is wrong
  in dimensions ≤ 1 (Tamagawa factor 2 becomes 1); the low-dimensional conventions
  are pinned in Layer 7. ⚠ The `p = 2` local factor was stated by Conway–Sloane
  without proof; the first proof is Cho (Compositio 151 (2015)) — Layer 7's honesty
  layering reflects this.

## What Mathlib already has (consume)

All checked at the roadmap pin (`9caeba1000`, 2026-06-03) and rechecked on master
2026-07-30 (no relevant file has changed since the pin).

- **Quadratic maps over ℤ, for free:** `Mathlib/LinearAlgebra/QuadraticForm/Basic.lean`
  — `QuadraticMap` over any `CommSemiring` with the companion structure
  (`exists_companion'`), `polar`, `polarBilin`, `ofPolar`,
  `LinearMap.BilinMap.toQuadraticMap` (`x ↦ β x x`), `polar_self` (`= 2 • Q x`),
  `two_nsmul_associated`, `Anisotropic`, and `QuadraticMap.PosDef` (order-theoretic,
  fully general). ⚠ The `Invertible (2 : R)` wall: `associated`/`associatedHom`,
  `QuadraticForm.toMatrix`/`toMatrix'`, `QuadraticForm.discr`/`discr'`,
  `exists_orthogonal_basis`, and `QuadraticForm.baseChange` are all 2-gated and
  unusable over ℤ — consumed only after base change to ℚ/ℝ/ℚ_p.
  `Matrix.toQuadraticForm'` (`x ↦ xᵀMx`) is 2-free and usable over ℤ.
- **Bilinear forms:** `Mathlib/LinearAlgebra/BilinearForm/*` — `IsSymm`, `IsRefl`,
  `Nondegenerate`, `restrict` (+ `IsSymm.restrict`), `flip`, the bundled
  `Isometry`/`IsometryEquiv`/`Equivalent`; `Mathlib/LinearAlgebra/Matrix/BilinearForm.lean`
  — `BilinForm.toMatrix`/`Matrix.toBilin` (basis) and `toMatrix'`/`Matrix.toBilin'`
  (`n → R`), `toMatrix_apply` (the Gram matrix), the congruence law
  `toMatrix_mul_basis_toMatrix`, and `nondegenerate_iff_det_ne_zero` (any `IsDomain`,
  so ℤ). **Base change without 2:**
  `Mathlib/LinearAlgebra/BilinearForm/TensorProduct.lean` —
  `LinearMap.BilinForm.baseChange` over any `CommSemiring`, with
  `baseChange_tmul` and `IsSymm.baseChange`: the localization vehicle for
  `ℤ → ℚ, ℝ, ℤ_p, ℚ_p`, including `p = 2`.
- **The dual submodule:** `Mathlib/LinearAlgebra/BilinearForm/DualLattice.lean` —
  `LinearMap.BilinForm.dualSubmodule` (for `B` over a field `S`, lattices over
  `R ⊆ S`), `dualSubmodule_span_of_basis` (the dual of a spanned lattice is spanned
  by the `B`-dual basis), `dualSubmodule_dualSubmodule_of_basis` (`L^{⋆⋆} = L` for
  symmetric nondegenerate `B`), and `dualSubmoduleToDual` with *injectivity only* —
  the file's own TODOs ("Properly develop the material in the context of lattices";
  "Show that this is perfect when `N` is a lattice and `B` is nondegenerate") are
  Layer-1 milestones here.
- **Smith normal form and index = |det|:** `Mathlib/LinearAlgebra/FreeModule/PID.lean`
  (`Submodule.basisOfPid`, `Module.Basis.SmithNormalForm`,
  `Submodule.smithNormalFormOfRankEq`, `smithNormalFormCoeffs`),
  `Mathlib/LinearAlgebra/FreeModule/Finite/CardQuotient.lean`
  (`Submodule.natAbs_det_basis_change` — index of a full-rank submodule equals
  `|det|`; `AddSubgroup.index_eq_natAbs_det`, `relIndex_eq_natAbs_det`, and the
  ℚ-ambient `AddSubgroup.relIndex_eq_abs_det`, tailor-made for `[L^⋆ : L]`),
  `Mathlib/LinearAlgebra/FreeModule/Finite/Quotient.lean`
  (`Submodule.quotientEquivPiZMod` — the discriminant group in invariant-factor form).
  ⚠ No invariant-factor *uniqueness* and no matrix-level SNF/HNF algorithm exist at
  the pin; Layer 1 states what it needs and no more.
- **Finite abelian groups:** `Mathlib/GroupTheory/FiniteAbelian/Basic.lean`
  (`AddCommGroup.equiv_directSum_zmod_of_finite` and the f.g. structure theorem) and
  `Duality.lean` (character duality — the nondegeneracy language for `b_L`).
- **Orthogonality over rings:** `Mathlib/LinearAlgebra/BilinearForm/Orthogonal.lean`
  — `IsOrtho`, `iIsOrtho`, `orthogonal`, and the one ring-level splitting tool
  `nondegenerate_restrict_of_disjoint_orthogonal` (`CommRing`). ⚠ The converse
  splitting (`restrict` nondegenerate ⟹ `IsCompl W (B.orthogonal W)`),
  `orthogonal_orthogonal`, and dimension counts are **field + finite-dimensional
  only**; over ℤ the true splitting criterion is *unimodularity* of the restriction,
  and building that is a named Layer-0/1 target, not a Mathlib import.
- **Analytic lattices:** `Mathlib/Algebra/Module/ZLattice/Basic.lean` (`IsZLattice`,
  `ZLattice.rank`, `module_free`, fundamental domains), `Covolume.lean`
  (`ZLattice.covolume`, `covolume_eq_det`-family,
  `covolume_div_covolume_eq_relIndex`, and the lattice-point counting asymptotics
  `tendsto_card_div_pow` — the Minkowski engine), `Summable.lean` (norm-power
  summability over lattices — Layer 8's convergence fuel);
  `Mathlib/MeasureTheory/Group/GeometryOfNumbers.lean`
  (`exists_ne_zero_mem_lattice_of_measure_mul_two_pow_lt_measure` — Minkowski's
  convex-body theorem). ⚠ Open PR #41867 (Y. Dillies) generalizes `ZLattice` from
  ℤ-submodules to `AddSubgroupClass`; Layer 2's consumption is stated against the
  stable covolume API and flagged to re-check at build time.
- **Signature:** `Mathlib/LinearAlgebra/QuadraticForm/Signature.lean` (D. Loeffler,
  new at this pin) — `sigPos`/`sigNeg` (root namespace at the pin, see the convention
  table) with `Equivalent`-invariance and the Sylvester uniqueness pair
  `QuadraticForm.sigPos_of_equiv_weightedSumSquares`/`sigNeg_...`;
  `Real.lean` — the existence half (`isometryEquivSignWeightedSumSquares`). There is
  no bundled signature and no `(p,q)`-classification `iff`; Layer 0 packages what the
  lattice theory needs.
- **Root systems and Cartan matrices:** `Mathlib/LinearAlgebra/RootSystem/*`
  (consumed through the [root systems roadmap](../RepresentationTheory/RootSystems/README.md);
  `OfBilinear.lean` — reflections from a bilinear form — is the natural hook for
  root-lattice isometries) and `Mathlib/Data/Matrix/Cartan.lean` — `CartanMatrix.A/D/E₆/E₇/E₈`
  as explicit integer matrices: the Gram matrices of the root lattices, ready-made.
  (Master moved this file to `Mathlib/LinearAlgebra/Matrix/Cartan.lean`, 2026-06-05,
  and PR #42157 adds a generalized `Eₙ` family — cite the new path on the next bump.)
- **Theta functions:** `Mathlib/NumberTheory/ModularForms/JacobiTheta/OneVariable.lean`
  (`jacobiTheta` — which *is* `Θ_ℤ` in the pinned normalization — with
  `jacobiTheta_two_add` and the `S`-transformation `jacobiTheta_S_smul`),
  `TwoVariable.lean` (`jacobiTheta₂` with its full functional equation),
  `Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.lean`
  (`Complex.tsum_exp_neg_quadratic` — the rank-1 theta transformation);
  `Mathlib/Analysis/Fourier/PoissonSummation.lean` (`Real.tsum_eq_tsum_fourier`).
  ⚠ Poisson summation exists **only on ℝ** at the pin and on master: the
  ℝⁿ/lattice version is owned by [LFunctions Layer 2](https://github.com/roed-math/TauCetiRoadmap/pull/8), whose
  exported `ZLattice` theorem Layer 8 consumes after its sphere-packing coordination gate.
- **Modular forms** (background only; no theorem is consumed by this roadmap):
  `Mathlib/NumberTheory/ModularForms/` — congruence subgroups, `SlashActions`,
  Eisenstein series, q-expansions, level-one dimension formulas; and
  `Mathlib/NumberTheory/Modular.lean` — the `SL₂(ℤ)` fundamental domain (the rank-2
  reduction-theory geometry). `Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean`
  and `MellinEqDirichlet.lean` — the theta-to-Dirichlet-series Mellin bridge in
  rank 1 (the Epstein-zeta horizon's model).
- **Positive definite matrices:** `Mathlib/LinearAlgebra/Matrix/PosDef.lean` +
  `Mathlib/Analysis/Matrix/PosDef.lean` — `Matrix.PosDef`/`PosSemidef`, congruence
  invariance, Schur complements; ⚠ eigenvalue and `det_pos` characterizations are
  `RCLike`-only, so the ℤ-to-ℝ definiteness transfer is built in Layer 0.
- **p-adics:** `Mathlib/NumberTheory/Padics/` — `ℤ_[p]`, `ℚ_[p]`, Hensel's lemma,
  `PadicInt.unitCoeff`: Layer 3's coefficient rings.

## What Tau Ceti already has (consume)

- **`Completed/EffectiveBounds`** (landed): the geometry-of-numbers counting engine
  `TauCeti/NumberTheory/GeometryOfNumbers/Doubling.lean` (box packing/doubling counts,
  deliberately measure-free) and the effective-bounds pattern of reconciling with
  `ZLattice` before building (its Layer-0 instruction). Layer 2 reuses both the
  engine and the pattern for reduction-theory counting.
- **`TauCeti/LinearAlgebra/OrthogonalGroup.lean`** (landed):
  `orthogonalGroupToLinearIsometryEquiv` — the Euclidean orthogonal group as
  isometries; Layer 2's `O(L) ⊆ O(n,ℝ)` discreteness argument lands next to it.
- **`TauCeti/FieldTheory/SquareClassGroup.lean`** (landed): the square-class group as
  a `ZMod 2`-vector space with `squareClass`, `squareClass_eq_zero_iff`,
  `linearIndependent_squareClass_iff` — the shared square-class language with the
  quadratic-form-invariants roadmap; unit-determinant square classes at odd `p`
  (Layer 3's `ε` signs) speak it.
- **The [quadratic form invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4)**
  (sibling, in preparation) — the ambient rational and local theory, consumed by
  name: its Layer 0 chain-equivalence engine and square-class calculus; its Layer 1
  Witt decomposition/cancellation over fields (the ambient `V = ℚ ⊗ L`); its Layer 3
  classical invariants with the pinned `discr`/`signedDiscr` distinction and the
  Lam/Serre Hasse invariant `s(q) = ∏_{i<j} (aᵢ,aⱼ)` valued in quaternion classes;
  its Layer 6 **local classification** of forms over `ℚ_p` by `(dim, d±, s)`
  including the dyadic case, with the Hilbert-symbol value dictionary — the
  rational-shadow layer of the genus (Layer 3 here) consumes exactly these, and every
  interface statement uses their convention table (their `[Invertible (2 : K)]`
  standing hypothesis lives on the *field* side of the base change; nothing on our
  ℤ/ℤ_p side ever assumes it).
- **The [local fields roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2)** (sibling, in preparation)
  — consumed only at the flagged generalization seams: which Layer-3 statements
  survive the swap `ℤ_p ⇝ 𝒪_K` for a nonarchimedean local field `K` (O'Meara's
  §§91–93 generality), and the `Kˣ/(Kˣ)²` finiteness their Layer 1 owns. Nothing here
  blocks on it.
- **The [root systems roadmap](../RepresentationTheory/RootSystems/README.md)**
  (sibling) — its Layer 5 realizes the Dynkin types by explicit coordinate models,
  "E₈ from its even unimodular lattice"; the boundary is: **they** own `RootPairing`,
  bases, Weyl groups, `DynkinType`, and the ADE classification; **we** own the
  integral lattices `Aₙ/Dₙ/E₆/E₇/E₈` (Gram matrices, determinants, discriminant
  groups, evenness) and the statement "the norm-2 vectors of this lattice form a root
  system of the corresponding type" (via `RootSystem/OfBilinear`), which is both our
  Layer-6 tool (E₈ uniqueness) and their realization input. Coordinate rather than
  duplicate the coordinate models; the Layer-7 `|O(E₈)| = |W(E₈)| = 696729600`
  milestone consumes their Weyl-group order and adds only "reflections in roots
  generate `O(E₈)`".
- **The [multiquadratic roadmap](../Multiquadratic/README.md)** (landed code above):
  no direct interface beyond the square-class idiom; its "genus theory" is genus
  theory *of number fields*, a different genus — the name collision is noted so
  nobody links the two.

## What is already in motion elsewhere (cite, follow, do not duplicate)

- **The sphere-packing formalization**
  ([thefundamentaltheor3m/Sphere-Packing-Lean](https://github.com/thefundamentaltheor3m/Sphere-Packing-Lean);
  Apache-2.0; maintainers C. Birkbeck, S. Hariharan, B. Mehta, Seewoo Lee; M.
  Viazovska among the contributors; project paper arXiv:2604.23468; very active —
  last push 2026-07-30). Its `SpherePacking/Basic/E8.lean` (Mehta, Ma) is
  **sorry-free** and contains: `Submodule.E8` (the even-coordinate/half-integer model
  over any field with `NeZero 2`), the explicit basis matrix `E8Matrix` with
  `E8Matrix_unimodular : det = 1` (kernel-checked), `E8Lattice` in
  `EuclideanSpace ℝ (Fin 8)` with `IsZLattice`, integrality (`E8_integral`), evenness
  (`E8_integral_self`), minimal norm √2, and covolume 1. **Cite and coordinate, do
  not re-derive their E₈**: our Layer-0 `E₈` is the abstract Gram-matrix lattice
  (`CartanMatrix.E₈`), and the isometry between the two models is a stated
  reconciliation milestone (Layer 6), so the two projects share one E₈ up to a proved
  isometry. Their `CohnElkies/Prereqs.lean` *states* Poisson summation for an
  arbitrary `IsZLattice` with dual `bilinFormOfRealInner.dualSubmodule Λ` (still
  `sorry` in main; proved inside the Gauss contribution, open PR #341 there) —
  [LFunctions Layer 2](https://github.com/roed-math/TauCetiRoadmap/pull/8), not this roadmap, owns the shared
  Poisson milestone and must coordinate with them (their `ForMathlib/` staging
  directory and open issue #416 "Prepare defs for mathlib" show active upstreaming
  intent on the packing/modular side; no lattice-arithmetic upstreaming is planned by
  them). The companion [math-inc/Sphere-Packing-Lean](https://github.com/math-inc/Sphere-Packing-Lean)
  (Gauss output, Apache-2.0, sorry-free) contains a dimension-24 line — an explicit
  Leech generator matrix, even-unimodular-in-ℝ²⁴ theta machinery
  (`thetaShell`/`thetaCoeff`, discriminant pairings, dual covolumes), and the
  rootless-Niemeier-is-Leech argument — all **hardcoded to
  `EuclideanSpace ℝ (Fin 24)`** and unreviewed by Mathlib standards: quarry and
  citation for Layer 6's Niemeier/Leech reference-data semantics, not a migration source
  without their agreement and a licensing-clean port plan.
- **Mathlib PRs to track:** #41867 (ZLattice `AddSubgroupClass` refactor — touches
  Layer 2's consumption surface), #42071 (a Lie algebra is determined by its root
  system, O. Nash — root-system flagship, no lattice content), #42157 (generalized
  E-type Cartan matrices — Layer 0's `CartanMatrix.E₈` cite), #39460 (`ZLattice`
  torus quotients), #10345 (Voronoi domains, stale), and #38194 ("indefinite
  metrics", a small new-contributor file defining an `IndefiniteMetric` structure —
  no mathematical overlap, but it squats naming territory for indefinite forms;
  flag in review if it moves). There are **zero** open or 2026-merged PRs on
  unimodular/integral lattices, discriminant groups, theta series of lattices, Witt
  rings, or Hermite normal form.
- **HassePrinciple** (mariainesdff/HassePrinciple) and the CSA/Brauer pipeline are
  coordinated by the [quadratic form invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4);
  this roadmap reaches them only through its interfaces.

## What is missing (build here)

Everything arithmetic. The lattice structures with their even/odd dictionary; the
determinant as an honest ℤ-invariant; scale, norm ideal, and level; the ℤ-level
orthogonal-splitting calculus (unimodular summands split — the ring-corrected form of
Mathlib's field-only `IsCompl` theory); definiteness transfer ℤ ↔ ℝ; dual lattices
with `[L^⋆ : L] = |det L|` and perfectness of the pairing (discharging Mathlib's
TODOs); discriminant groups and finite quadratic forms with Milgram's signature and
van der Blij; automorphism-group finiteness and reduction theory for definite
lattices with the finiteness of classes of bounded determinant; `ℤ_p`-lattices,
Jordan splittings (odd-`p` uniqueness; the dyadic invariants and the proved 2-adic
symbol calculus); the genus, Conway–Sloane genus symbols as LMFDB label semantics,
and the rational-shadow interface to the quadratic-form-invariants roadmap; class
numbers, spinor genera, Eichler's theorem, and Kneser neighbors; Nikulin's
discriminant-form theory — existence `(t₊, t₋, q)`, uniqueness and splitting for
indefinite even lattices, 2-elementary classification, primitive embeddings — through
the K3 toolkit; the classification of unimodular lattices in low rank (signature ≡ 0
mod 8; indefinite classification; `E₈` unique in rank 8; rank 16 and the Niemeier
data semantics); the Smith–Minkowski–Siegel mass formula in the Conway–Sloane
normalization with its verification instances; and arithmetic theta series with their first
properties, consuming the general lattice Poisson/theta transformation of LFunctions
Layer 2. None of this exists
upstream as stated.

`Suggested.lean` pins Lean forms for the pin-expressible milestones of Layers 0–3, 5,
6, and 8 plus the worked examples; the symbol calculus (Layer 3), spinor genera
(Layer 4), the discriminant-form calculus of the Nikulin layer (Layer 5), and the
mass formula (Layer 7) stay prose until the earlier layers make their types
expressible in `TauCeti/`, at which point their milestones are added there with
`sorry`.

---

## The build, in layers

The order below is the dependency order; "Ordering and parallelism" names the
independent lanes.

### Layer 0: lattices, the dictionary, and first invariants

- **The objects.** The standing setting (convention table): finite free ℤ-modules
  with symmetric `LinearMap.BilinForm ℤ L`; predicates `IsEven`, `Nondegenerate`
  (consume `nondegenerate_iff_det_ne_zero`), `IsUnimodular` (`det = ±1`), `PosDef`;
  orthogonal direct sums, twists `L(a)`, and `LinearMap.BilinForm.Equivalent` as
  isometry. Basic calculus: determinant of a direct sum is the product; of `L(a)` is
  `aⁿ det L`; rank additivity; restriction to a (primitive or not) submodule.
- **The bilinear/quadratic dictionary** (⚠ done once, used everywhere): even
  symmetric `β` ↔ `Q : QuadraticForm ℤ L` via `polarBilin`, both directions with
  round trips (`Suggested.lean` pins the `∃!` forms); norms vs half-norms; the
  induced dictionary on Gram matrices (even diagonal) and on direct sums and twists.
- **The determinant.** Gram matrices via `BilinForm.toMatrix`; base-change
  determinant equality over ℤ; `det L : ℤ` as an invariant; behavior under sums,
  twists, and finite-index sublattices (`det L' = [L : L']² · det L` — the index
  formula via `natAbs_det_basis_change`, the engine for Layer 1).
- **Scale, norm ideal, level** per the convention table, with the even ⟺
  `𝔫 ⊆ 2ℤ` characterization (O'Meara §82E is the reference shape).
- **Definiteness transfer.** `PosDef` over ℤ ⟺ `PosDef` of the ℝ-form ⟺
  `Matrix.PosDef` of the real Gram matrix (building the ℤ→ℝ bridge Mathlib's
  `RCLike`-walled `PosDef` API lacks); definite ⟹ nondegenerate; signature `(t₊,t₋)`
  via `sigPos`/`sigNeg` of the ℝ-form, with `t₊ + t₋ = rank` for nondegenerate `L`
  (consume `sigPos_add_sigNeg_add_radical`) and the definite/indefinite trichotomy.
- **Unimodular orthogonal splitting** (⚠ the ring-corrected splitting calculus): if
  `M ≤ L` with `β|_M` *unimodular*, then `L = M ⊕ M^⊥` — over ℤ unimodularity, not
  nondegeneracy, is the splitting hypothesis (Mathlib's `IsCompl` route is field-only;
  its one ring-level lemma `nondegenerate_restrict_of_disjoint_orthogonal` is the
  converse direction). Corollaries: splitting off `⟨±1⟩` vectors of unit norm;
  cancellation questions explicitly *deferred* (integral Witt cancellation fails in
  general; the true statements live in Layers 4/6 — record this as a stated
  non-theorem with the classical counterexample so nobody imports field Witt theory
  by reflex).
- **The standard examples**, each with rank, determinant, parity, signature, level:
  `⟨a⟩`, `Iₙ = ⟨1⟩ⁿ`, `U` (Gram `!![0,1;1,0]`), the root lattices `Aₙ`, `Dₙ`, `E₆`,
  `E₇`, `E₈` via their Cartan-matrix Grams (`CartanMatrix.A/D/E₆/E₇/E₈` are already
  the matrices; `Aₙ`'s coordinate model `{x ∈ ℤ^{n+1} : ∑x = 0}` and `Dₙ`'s
  even-coordinate-sum model as alternative presentations with proved isometries),
  and their twists.

### Layer 1: dual lattices, discriminant groups, and finite quadratic forms

- **The ambient realization.** `V = ℚ ⊗ L` with `B = β.baseChange ℚ`; the abstract
  lattice ↔ full-rank-submodule-of-rational-quadratic-space dictionary (both
  directions with transport of all Layer-0 invariants). Integrality ⟺ `L ≤ L^⋆`.
- **The dual lattice.** `L^⋆ = B.dualSubmodule L`; consume
  `dualSubmodule_span_of_basis` and `dualSubmodule_dualSubmodule_of_basis`
  (`L^{⋆⋆} = L`); duality reverses inclusions and exchanges `L(a)`-twists with
  `(1/a)`-scalings; Gram of the dual basis is `G⁻¹`; `det L^⋆ = (det L)⁻¹` (in ℚ);
  unimodular ⟺ `L = L^⋆` (`Suggested.lean`).
- **The discriminant group.** `A_L = L^⋆/L` finite with `#A_L = |det L|` (via
  `relIndex_eq_abs_det` + the dual-basis span), invariant-factor decomposition via
  `quotientEquivPiZMod`, `l(A_L) ≤ rank L`; **perfectness** of
  `A_L × A_L → ℚ/ℤ` — discharging the `dualSubmoduleToDual` TODOs — and the
  discriminant forms `b_L` (always) and `q_L` (even case, ℚ/2ℤ-valued ⚠) with
  functoriality: `A_{L⊕M} = A_L ⊕ A_M` with `q` additive; `A_{L(−1)}` carries `−q`;
  for finite-index `L' ≤ L`, the chain `L' ≤ L ≤ L^⋆ ≤ L'^⋆` and the induced
  isotropic-subgroup correspondence (overlattices of `L` ↔ isotropic subgroups of
  `(A_L, q_L)` — the engine of Nikulin's primitive-embedding theory, proved here).
- **Finite quadratic and bilinear forms, standalone.** `(A, q)` with
  `q : A → ℚ/2ℤ`, `b(x,y) = ½(q(x+y) − q(x) − q(y)) ∈ ℚ/ℤ`; nondegeneracy via the
  character-duality language (`GroupTheory/FiniteAbelian/Duality`); orthogonal
  splitting into `p`-parts; the generator forms `w^ε_{p,k}`, `u_k`, `v_k` and the
  relations among them as data semantics first, with the full classification of
  finite quadratic forms a definite later milestone in this layer (Nikulin
  Proposition 1.8.1's list; only the *existence* of the splitting is needed by
  Layers 3–5, the relations feed the symbol dictionary).
- **The signature of a finite quadratic form** (the layer's summit): **Milgram's
  formula** `∑_{a ∈ A} e^{πi q(a)} = √#A · e^{2πi·sign(q)/8}` defining
  `sign q ∈ ℤ/8` (Gauss-sum computation; consume Mathlib's Gauss-sum and
  quadratic-character library; Milnor–Husemoller Appendix 4 is the reference proof),
  additivity, the generator values (Nikulin Proposition 1.11.2), and **van der
  Blij's lemma** `t₊ − t₋ ≡ sign q_L (mod 8)` for even `L` (Nikulin Theorem 1.3.3).
  Corollary, free of charge: **an even unimodular lattice has `8 ∣ t₊ − t₋`**
  (`A_L = 0`) — Serre V.2 Theorem 2 Corollary 1, landed here rather than in Layer 6
  because the discriminant-form route proves it en passant (Serre's `σ(E)`-invariant
  route via V.1.3.5 is the alternative an implementor may take for the standalone
  statement; both are honest).
- **Level** as the annihilator-exponent of `q_L` (even case) with the `N·G⁻¹`
  characterization of the convention table; `level ∣ 2·det` and the standard
  divisibility calculus.

### Layer 2: definite lattices — reduction, finiteness, automorphisms

An independent lane after Layer 0; no dual-lattice input needed.

- **Vectors of bounded norm.** For definite `L`: `{x | β x x ≤ C}` is finite
  (realization in ℝⁿ + `ZLattice` discreteness, or elementary via the positive
  definite Gram bound); minimal norm `min L`; minimal vectors; kissing number; the
  norm-`k` shells (the future theta coefficients `r_L(k)`, defined here).
- **Automorphism groups.** `O(L) = {e : L ≃ₗ[ℤ] L | isometry}`; **finiteness for
  definite `L`** (embed into permutations of a bounded-norm generating set; the
  `TauCeti/LinearAlgebra/OrthogonalGroup.lean` realization gives the discrete ∩
  compact picture); `O(L ⊕ M) ⊇ O(L) × O(M)` with equality obstructions. ⚠ The
  definite hypothesis is essential, and the indefinite side must be stated
  correctly (a favorite trap): `O(L)` is infinite for every indefinite
  nondegenerate `L` of rank ≥ 3, while in rank 2 it is infinite exactly in the
  anisotropic (Pell) case — `O(U) ≅ (ℤ/2)²` is finite, `O(⟨1,−2⟩)` is infinite
  (units of `ℤ[√2]`). The rank-2 dichotomy is a required worked pair and the rank ≥ 3
  statement is proved in Layer 4's Eichler-transvection toolkit; these results explain
  why Layer 7's mass is restricted to definite genera.
- **The covolume bridge and Minkowski.** Realization of definite `L` in Euclidean
  space with `covolume(L)² = det L` (⚠ the `√det` bookkeeping, fixed once —
  `Suggested.lean`); Minkowski's convex-body bound
  `min L ≤ c_n (det L)^{1/n}` (consume `GeometryOfNumbers` +
  `ZLattice.covolume`); **Hermite's inequality**
  `min L ≤ (4/3)^{(n−1)/2} (det L)^{1/n}` by the classical reduction induction —
  stated with the explicit constant (the effective-bounds house style), with `A₂`
  achieving equality in rank 2 as the worked example.
- **Reduction and finiteness** (the lane's summit): Minkowski-reduced bases exist
  for definite lattices; reduced Gram matrices of given rank and determinant have
  entries bounded explicitly in terms of `(n, det)`; hence **finitely many isometry
  classes of definite lattices of given rank and determinant** (`Suggested.lean`
  pins the `Finset` form) — the definite half of class-number finiteness, and the
  LMFDB-facing enumeration semantics (O'Meara 103:4 is the classical umbrella;
  the effective bound is stated in the explicit form the enumeration needs).
  Consume the `EffectiveBounds` doubling engine where it shortens proofs; follow its
  Layer-0 instruction to reconcile against `ZLattice` before adding counting
  primitives.

### Layer 3: localizations, Jordan splittings, and the genus

Blocks on Layer 0 and (for the rational shadow) on the
[quadratic form invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4)'s Layers
0–3; its dyadic classification statements consume their Layer 6 only at the
worked-example seam.

- **`ℤ_p`-lattices.** `L_p := ℤ_p ⊗ L` with `β_p = β.baseChange ℤ_[p]` (2-free ⚠ —
  this is why the roadmap is bilinear-first); free finite `ℤ_p`-modules with
  symmetric forms; scale and norm ideals over `ℤ_p`; unimodular `ℤ_p`-lattices;
  the splitting calculus of Layer 0 transported (`ℤ_p` is local, so it strengthens:
  any maximal-scale unimodular summand splits off).
- **Jordan splittings.** Existence: every nondegenerate `ℤ_p`-lattice is an
  orthogonal sum `⊕_i p^i L_i` with `L_i` unimodular (O'Meara §91C; the proof is the
  split-off-maximal-scale induction). **Odd `p`**: unimodular `ℤ_p`-lattices are
  diagonalizable and classified by rank + unit-determinant square class (exactly two
  per rank — O'Meara 92:1, 92:1a), Jordan invariants are unique (O'Meara 91:9), and
  two lattices are isometric iff their Jordan data match (O'Meara 92:2); the
  odd-`p` orthogonal-basis statement is pinned in `Suggested.lean`.
- ⚠ **The dyadic case, honestly layered.** Over `ℤ_2` orthogonal bases fail (`U` is
  not diagonalizable — `Suggested.lean` pins the counterexample), Jordan splittings
  are **not unique**, and the invariants are subtler: type I/II per constituent,
  norm group and weight (O'Meara §93A), the fundamental invariants of §93E, with the
  classification O'Meara 93:28 (general dyadic) / 93:29 (the 2-adic case) — build
  the O'Meara route as the theorem set, in this order: unimodular case first
  (93:16), then the general classification as a definite later milestone in this
  layer. The **Conway–Sloane 2-adic symbol** (scale, rank, sign, type, oddity per
  constituent; compartments and trains) with its **sign-walking** and **oddity
  fusion** equivalence moves is the interface format; the theorem "two 2-adic
  symbols name isometric lattices iff related by the equivalence moves" is stated
  against Allcock–Gal–Mark's proof (arXiv:1511.04614) — ⚠ including their
  correction to the SPLAG canonical-form definition; the canonical 2-adic symbol is
  *their* corrected one.
- **The genus.** `gen L = gen M` iff `L_p ≅ M_p` for all `p` and the real signatures
  agree (O'Meara §102A shape); genus is determined by finitely many congruence data
  (equivalence over `ℤ/N` for suitable `N` — the effective form); the **genus
  symbol** (concatenated `p`-adic symbols for `p ∣ 2·det`) determines the genus, and
  its well-formedness constraints (rank/determinant/oddity compatibilities, the
  global **oddity formula** and sign product conditions = the symbol-level shadow of
  Hilbert reciprocity ⚠ — stated as an interface consuming the
  quadratic-form-invariants/global reciprocity chain, with the symbol-side
  verification decidable). **LMFDB label semantics**: the lattice label's components
  (rank, determinant, level, and the stored genus symbol) as mathematical predicates
  of `L` — the data-semantics interface, early and thin.
- **The rational shadow.** Lattices in the same genus have equivalent forms over ℚ
  and over every `ℚ_p` — the invariant dictionary `(rank, d±, s_p, signature)` of the
  quadratic-form-invariants roadmap, consumed by name; conversely rational
  equivalence + integral local data assemble into genus membership. This is the
  interface seam with their Layer 6 and the only place the Hilbert-symbol machinery
  is touched.

### Layer 4: class numbers, spinor genera, and neighbors

- **Class sets.** `cls ⊆ spn ⊆ gen`; the class number `h(L)` of a genus is finite —
  definite case from Layer 2's reduction; general case stated as O'Meara 103:4 with
  the definite proof landing first and the indefinite proof flowing from the spinor
  route below (honest sequencing: 103:4's full proof is reduction theory over the
  adeles; the layered plan proves definite by reduction, indefinite via Eichler,
  and flags the adelic uniform proof as a later unification).
- **Spinor genera.** Spinor norm `θ : O(V_p) → ℚ_pˣ/(ℚ_pˣ)²` (built on the
  quadratic-form-invariants square-class API), proper/improper classes
  (`cls⁺` vs `cls`), the spinor genus `spn L` and proper spinor genus `spn⁺ L`
  (O'Meara §102A definitions), and the **idele-index count** of proper spinor genera
  in a genus (O'Meara 102:7) as a required proved milestone, including the abelian
  square-class computation.
- **Eichler's theorem** (the layer's summit, honestly gated): for indefinite `L` of
  rank ≥ 3, `cls⁺ L = spn⁺ L` and `cls L = spn L` (O'Meara 104:5), by **strong
  approximation for the spin group** (O'Meara 104:4) — the strong-approximation
  input is a required theorem in this layer, and Layer 4 is incomplete until its
  Eichler/Kneser proof is finished; it is the hard analytic-arithmetic
  content; corollaries: indefinite class numbers are powers of 2 bounded by the
  spinor count; concrete one-class criteria.
- **Kneser `p`-neighbors, as data semantics:** `L, M`
  integral on `V` are `p`-neighbors if `[L : L ∩ M] = [M : L ∩ M] = p`; neighbors
  have the same determinant and (for `p ∤ 2 det`) the same genus; and the neighbor-step
  construction from an isotropic vector mod `p`, all with proved checker theorems.
  These targets justify individual neighbor edges but **do not certify enumeration
  completeness**. Connectivity of the neighbor graph on a proper spinor genus and
  spinor-genus transitivity are explicit future directions, outside this roadmap; no
  LMFDB/K3 consumer may infer a complete class list from neighbor traversal alone.
  Completeness inside this roadmap must instead come from a separately proved
  classification theorem or a Layer-7 mass certificate.

### Layer 5: discriminant forms and Nikulin's theory (the K3 toolkit)

Blocks on Layers 1 and 3. Citations are to Nikulin's paper (Izv. Akad. Nauk SSSR 43
(1979); English transl. Math. USSR-Izv. 14 (1980)); the Russian original's numbering
matches the translation. ⚠ Nikulin's `E₈` is negative definite; translate twists.

- **Genus = signature + discriminant form.** For even lattices: `gen L` is
  determined by `(t₊, t₋, q_L)` (Nikulin Corollary 1.9.4, via the local uniqueness
  Theorem 1.9.1 and its one dyadic exception case); the odd/bilinear analogue
  (Corollary 1.16.3) as a stated companion. This is the bridge between Layer 3's
  symbols and the `(t₊, t₋, q)` calculus: the symbol ↔ discriminant-form dictionary
  is a named milestone (it is how the K3 pipeline's genus data and Nikulin's
  invariants translate).
- **Existence** (the layer's first summit): an even lattice with invariants
  `(t₊, t₋, q)` exists iff `t₊ − t₋ ≡ sign q (mod 8)`, `t₊, t₋ ≥ 0`,
  `t₊ + t₋ ≥ l(A_q)`, and the two `p`-adic boundary conditions (Nikulin Theorem
  1.10.1, with the clean sufficient form `t₊ + t₋ > l(A_q)` of Corollary 1.10.2).
- **Uniqueness and splitting for indefinite even lattices**: Kneser's criterion in
  Nikulin's form (Theorem 1.13.1, with the discriminant-form version 1.13.2); the
  workhorse **Corollary 1.13.3** (existence-and-uniqueness when
  `t₊ ≥ 1, t₋ ≥ 1, t₊ + t₋ ≥ l(A_q) + 2`); stabilization (Corollary 1.13.4) and the
  **`U`- and `E₈`-splitting** Corollary 1.13.5 (`t₊ ≥ 1, t₋ ≥ 1,
  t₊ + t₋ ≥ l(A) + 3 ⟹ L ≅ U ⊕ T`); the surjectivity theorem `O(L) → O(q_L)`
  (Theorem 1.14.2) — the automorphism-lifting statement every K3 Torelli argument
  uses, a first-class milestone here, not a remark.
- **2-elementary and `p`-elementary lattices.** The 2-elementary classification by
  `(δ, t₊, t₋, a)` with its existence conditions (Theorem 3.6.2) and the
  surjectivity companion (Theorem 3.6.3). ⚠ There is **no odd-`p` elementary theorem
  in Nikulin's paper**: for odd `p` the classification follows from
  1.13.2/1.13.3 (or is cited to Rudakov–Shafarevich); state it that way — the
  common citation of "Nikulin's `p`-elementary theorem" for odd `p` is folklore
  this roadmap does not repeat.
- **Primitive embeddings** (the layer's second summit): primitivity dictionary
  (torsion-free cokernel ⟺ direct summand — `Suggested.lean`); overlattice ↔
  isotropic-subgroup correspondence (Layer 1's engine, Nikulin §1.4–1.5); embedding
  into **even unimodular** lattices — existence criteria Theorem 1.12.2 (the
  `(l₊ − t₊, l₋ − t₋, −q)`-complement equivalences) and the signature-only
  sufficient form Theorem 1.12.4; **uniqueness** of primitive embeddings
  (Theorem 1.14.4); embeddings into a **general even lattice** — the
  `(H_S, H, γ; K, γ_K)` parametrization of Proposition 1.15.1 with its genus
  version Corollary 1.15.2. Acceptance instances aimed at the K3 pipeline: every
  even lattice of signature `(1, ρ−1)` with `ρ ≤ 10` embeds primitively into
  `Λ_{K3}` (1.12.4 instance); `⟨2d⟩ ↪ Λ_{K3}` primitively and uniquely up to
  `O(Λ_{K3})` (1.14.4 instance — the polarized-K3 normal form).

### Layer 6: unimodular lattices in low rank

- **Indefinite classification** (from Layer 5): even indefinite unimodular lattices
  are `U^{min(t₊,t₋)} ⊕ E₈(±1)^{|τ|/8}`, unique with their signature (via Corollary
  1.13.3; classically Milnor — Serre V.2.2, Milnor–Husemoller II §5); odd indefinite
  unimodular lattices are `⟨1⟩^{t₊} ⊕ ⟨−1⟩^{t₋}` (Serre V.2.2's second structure
  theorem). Both proved milestones; `Suggested.lean` pins the even shape.
- **Existence bookkeeping**: even unimodular definite lattices exist iff `8 ∣ n`
  (O'Meara 106:1 + Layer 1's mod-8 theorem + `E₈`).
- **Rank ≤ 9 definite classification** (proved): a positive definite unimodular
  lattice of rank ≤ 9 is `Iₙ`, `E₈`, or `E₈ ⊕ I₁` (O'Meara 106:13, whose §§105–106
  route — the uniqueness of indecomposable splittings 105:1 plus the
  characteristic-vector counting — is the pinned proof plan). Corollary: **`E₈` is
  the unique even unimodular lattice of rank 8** (Mordell). ⚠ Route honesty: Serre
  §2.3 derives this uniqueness *from the mass formula*, which his chapter does not
  prove — the pinned route is O'Meara's (mass-free); the root-system route (minimal
  vectors of an even unimodular definite rank-8 lattice form a root system of full
  rank, necessarily `E₈` by the ADE classification — consume the
  [root systems roadmap](../RepresentationTheory/RootSystems/README.md)) is the
  alternative, and whichever lands first satisfies the milestone; the mass formula
  then *re-verifies* it in Layer 7.
- **Rank 16**: `E₈²` and `D₁₆⁺` (the half-spinor glue of `D₁₆`) both exist, are
  even unimodular, and are **non-isometric** (root-system count: their norm-2 root
  systems differ) — proved; they lie in one genus (even unimodular of signature
  `(16,0)` is a single genus — from Layer 5's genus criterion); **completeness**
  (Witt: these are the only two classes) is a required classification theorem. Layer 6
  is incomplete until this is proved, either by a fully proved neighbor argument or by
  the fully proved mass certificate of Layer 7.
- **Rank 24, reference-data semantics only:** define the 24 named Niemeier reference
  lattices by explicit Gram/glue data and prove checker theorems for each row (even,
  unimodular, rank 24, the advertised root-system label/norm-2 data, and pairwise
  non-isometry where the checked invariants suffice). The name “Leech” denotes the
  designated rootless reference row. This layer **does not assert** that every rank-24
  even unimodular lattice is one of these rows, nor that every rootless one is isometric
  to the designated Leech row. Those completeness/uniqueness theorems are explicit future
  directions outside this roadmap. Coordinate with math-inc's hardcoded-ℝ²⁴ development
  as a citation and possible quarry, never as a silent migration.
- **Reconciliation with the sphere-packing `E₈`**: `Submodule.E8`/`E8Lattice`
  (their even-coordinate model) is isometric to our `CartanMatrix.E₈` Gram lattice —
  a stated milestone, so Lean has one `E₈` up to proved isometry rather than two
  rival ones.
- **Theta cross-check scope:** `Θ_{E₈²} = Θ_{D₁₆⁺}` is not a milestone here because its
  proposed proof uses modular-form packaging that no current supplier roadmap owns. The
  classical equality is recorded only as a future application; it cannot be used to
  certify any Layer-6 classification claim.

### Layer 7: the Smith–Minkowski–Siegel mass formula (summit)

All statements for positive definite genera; the Conway–Sloane mass paper
(Proc. R. Soc. Lond. A 419 (1988) 259–285) is the
normalization source of record.

- **The mass.** `m(gen L) = ∑ 1/|O(L_i)|` (paper eq. (1)); well-defined by Layers
  2/4 (finite class number, finite automorphism groups); mass of a direct sum ≠
  product ⚠ (no such formula — state the non-theorem); behavior under twists.
- **The local ingredients.** `p`-masses `m_p(f)` from the Jordan data of Layer 3:
  diagonal factors from the species (paper §5, tables 1–2 and eq. (5)), the
  cross-product and type factors (eq. (3)), and — dyadic ⚠ — the type-I/II and
  octane ("oddity") bookkeeping with **bound/free constituents** (their "love
  forms" edge convention at dimension 0). The **standard mass** via zeta values
  (eqs. (6)–(9)) with the Bernoulli/Euler evaluations (eqs. (13), (15), (16)).
- **The theorem** (required summit): `m(f) = 2π^{−n(n+1)/4} ∏_{j≤n} Γ(j/2) ·
  ∏_p 2 m_p(f)` for `n ≥ 2` (paper eq. (2)), stated with ⚠ the dimension guard
  (their §§3, 6: the naive formula is *wrong* in dimensions ≤ 1 — the
  low-dimensional convention is part of the statement, and `m(dim 1) = 1/2`,
  `m(dim 0) = 1` are pinned acceptance values); equivalence with the
  Siegel-density normalization (paper §12, eq. (18) — `m_p` vs `α_p`) as a stated
  dictionary. **Required proof layering:** (i) pin the statement and checker API;
  (ii) prove the odd-`p` local computations; (iii) ⚠ prove the
  `p = 2` local factor — *stated by Conway–Sloane without proof; first proved by
  Cho (Compositio 151 (2015))* — is its own gated milestone citing Cho's
  group-scheme route; (iv) prove the global theorem (Siegel's analytic route, or
  the Tamagawa-number route `τ(SO) = 2`). Layer 7 is not complete after the statement or
  numerical checks; it is complete only after this global proof and every required local
  factor proof land.
- **Verification instances** (the mass formula's acceptance suite, each a decidable
  computation once the layers exist): rank 8 even unimodular: `m = 1/696729600`
  with the class number 1 (E₈; `|O(E₈)| = |W(E₈)| = 696729600` — consume the
  root-systems roadmap's Weyl order, prove `O(E₈) = W(E₈)` reflection generation
  here) — ⚠ the paper itself never prints this number (its §9(iv) delegates
  unimodular masses to SPLAG ch. 16 Theorems 1–2, and Serre §2.3 tabulates `M₈`);
  rank 16: the two-row check `1/|O(E₈²)| + 1/|O(D₁₆⁺)| = m₁₆`; **only after** the
  mass theorem and both automorphism orders are proved does that equality certify that
  no third class exists and discharge Layer 6's completeness theorem. Before then it is
  data validation, not classification. The determinant-3 rank-2 instance is
  (`A₂`, `h = 1`).
- **Mass-formula consequences**: class-number lower bounds (`h ≥ m·min|O|`), the
  explosion of class numbers (Serre §2.3's `n = 32` remark as a data-semantics
  note), and the enumeration-completeness certificates the LMFDB/K3 genus
  enumeration uses (`∑ 1/|O| = m` certifies a complete list — the pipeline's
  practical reason this layer exists).

### Layer 8: arithmetic lattice theta series

- **Definition and convergence.** `Θ_L : ℍ → ℂ`, `Θ_L(τ) = ∑_{x ∈ L}
  exp(πiτ·β(x,x))` for definite `L`; absolute/locally-uniform convergence (the
  `Summable` target of `Suggested.lean`; consume `ZLattice/Summable` and the shell
  finiteness of Layer 2); the q-expansion `Θ_L = ∑_k r_L(k) q^k` with `r_L(k)` the
  Layer-2 shell counts; `Θ_{L⊕M} = Θ_L·Θ_M`; `Θ_{L(a)}(τ) = Θ_L(aτ)`;
  **`Θ_ℤ = jacobiTheta`** (definitional reconciliation with Mathlib — the rank-1
  acceptance example) and `Θ_{Iₙ} = jacobiThetaⁿ`.
- **Consume the analytic engine from LFunctions Layer 2.** That precise supplier owns the
  `ZLattice` Poisson theorem
  `∑_{x ∈ L} f(x) = covolume(L)⁻¹ ∑_{y ∈ L^⋆} f̂(y)` and the positive-quadratic Gaussian
  theta transformation in `IsZLattice`/`dualSubmodule`/`covolume` vocabulary. This layer's
  required work is the arithmetic bridge: identify the analytic dual with Layer 1's
  bilinear dual lattice, replace covolume by `√|det L|`, and derive
  `Θ_L(−1/τ) = (τ/i)^{n/2} (det L)^{−1/2} Θ_{L^⋆}(τ)` (Gaussian instance), with
  `Θ_L(−1/τ) = (τ/i)^{n/2} Θ_L(τ)` for even unimodular `L`. The general analytic theorem
  is consumed, not re-proved; the determinant/dual dictionary and this arithmetic
  specialization are the theorems owned here.
- **Stop before modular-form packaging.** No current supplier proves that `Θ_L` is a
  modular form on `Γ₀(level L)` with its quadratic character, so neither that claim nor
  `Θ_{E₈} = E₄` nor `Θ_{E₈²} = Θ_{D₁₆⁺}` is a completion target. Integral- and
  half-integral-weight modular packaging is an explicit future direction outside this
  roadmap. The arithmetic shell theorem `r_{E₈}(2) = 240` remains a proved Layer-2 target
  independent of modularity.
- **Horizon notes**: Siegel–Weil (average of theta over a genus = Eisenstein
  series) as the analytic face of Layer 7, and Epstein zeta functions via the
  Mellin bridge (`MellinEqDirichlet`) — named, not scheduled; they belong to a
  future analytic continuation once the L-functions roadmap fixes its interfaces.

---

## Worked examples (acceptance criteria, keeping the definitions honest)

Discharge these alongside their layers; each catches a vacuous definition, a wrong
factor of 2, or a sign error.

- `⟨1⟩ = ℤ`: odd, unimodular, `Θ_ℤ = jacobiTheta` (Layers 0, 8).
- `U`: even, `det = −1`, signature `(1,1)`, level 1, `A_U = 0`; not diagonalizable
  over ℤ_2 (Layers 0, 3).
- `A₂`: even, `det = 3`, level 3, `A_{A₂} ≅ ℤ/3` with `q = 2/3 ∈ ℚ/2ℤ` (the
  assignment's sign/2ℤ acceptance check); 3-adic Jordan splitting with scale-1 and
  scale-3 constituents of rank 1; Hermite equality `min = (4/3)^{1/2}(det)^{1/2}`;
  class number 1 in its genus (Layers 0–3, 7).
- `Aₙ` family: `det(Aₙ) = n+1` (`CartanMatrix.A`), `A_{Aₙ} ≅ ℤ/(n+1)` (Layers 0–1).
- `E₈`: even, unimodular, positive definite, `min = 2` with 240 minimal vectors,
  signature `(8,0)`, `sign q_{E₈} = 0`; unique in rank 8; `|O(E₈)| = 696729600`;
  mass of its genus `1/696729600`; isometric to the sphere-packing project's
  `E8Lattice` (Layers 0–2, 6–8).
- Even unimodular ⟹ `8 ∣ t₊ − t₋`; no even unimodular definite lattice in ranks
  1–7 (Layer 1).
- Rank 16: `E₈²` and `D₁₆⁺` — same genus, non-isometric, and proved to exhaust the genus
  by the required Layer-6 classification theorem (or its proved Layer-7 mass certificate).
- `Λ_{K3} = U³ ⊕ E₈(−1)²`: even, unimodular, signature `(3,19)`, `det = −1`; the
  unique even unimodular lattice of its signature; `⟨2d⟩` embeds primitively,
  uniquely up to `O(Λ_{K3})`; every even lattice of signature `(1, ρ−1)`, `ρ ≤ 10`,
  embeds primitively (Layers 5–6 — the K3-pipeline acceptance suite).
- A Conway–Sloane genus symbol computed and compared against its LMFDB lattice
  entry: the label components (rank, determinant, level) and the stored genus
  symbol of a small lattice (`A₂` and one rank-4 lattice with nontrivial 2-adic
  symbol) match the Layer-3 predicates — the data-semantics acceptance (Layer 3).
- Mass conventions: `m(dim 0) = 1`, `m(dim 1 genus of ⟨a⟩) = 1/2` — the ⚠
  low-dimension guard of the Conway–Sloane normalization, checked explicitly
  (Layer 7).

## Ordering and parallelism

Layer 0 is first; everything rests on it. After Layer 0 three lanes are
independent: **the definite lane** (Layer 2 — reduction, finiteness, `O(L)`; no
dual-lattice input), **the discriminant lane** (Layer 1 — duals, `A_L`, finite
quadratic forms, Milgram/mod-8), and **the local lane** (Layer 3's `ℤ_p` and
odd-`p` Jordan theory; its genus assembly consumes the quadratic-form-invariants
roadmap's Layers 0–3 and, at the worked-example seam, Layer 6 — so the genus lane
blocks on that sibling while the two lattice-side lanes do not). Layer 4 consumes
Layers 2–3; Layer 5 consumes Layers 1 and 3; Layer 6 consumes Layers 1, 2, 5 and
the root-systems roadmap (for the definite rank-8 route); Layer 7 consumes Layers
2–4 with Layer 6 as its verification suite; Layer 8's definition/convergence half
needs only Layers 0–2, while its dual/determinant theta-transformation specialization
consumes the general analytic engine owned by LFunctions Layer 2 after that layer's
sphere-packing coordination gate. Modular-form packaging is outside this roadmap.
The Nikulin layer (5) is the K3 pipeline's
critical path: `0 → 1 → 5` plus the `3 → 5` genus bridge is the shortest route to
the embedding theorems, and it avoids Layers 2, 4, 6–8 entirely.

## References

- J. H. Conway, N. J. A. Sloane, *Low-dimensional lattices. IV. The mass formula*,
  Proc. R. Soc. Lond. A 419 (1988) 259–285 — PRIMARY for Layer 7: eq. (1) mass,
  eqs. (2)–(3) the formula, §5 species/octane
  tables, eqs. (6)–(9), (13), (15)–(16) standard mass, §§3, 6 the dimension ≤ 1
  guard, §12 the Siegel-density dictionary. ⚠ No erratum for this paper exists,
  but: the `p = 2` factor is unproved there (see Cho), and the 2-adic canonical
  form of SPLAG ch. 15 contains an error corrected by Allcock–Gal–Mark.
- S. Cho, *Group schemes and local densities of quadratic lattices in residue
  characteristic 2*, Compositio Math. 151 (2015) 793–827 — the first proof of the
  Conway–Sloane `p = 2` local-density formula; Layer 7(iii)'s citation.
- D. Allcock, I. Gal, A. Mark, *The Conway–Sloane calculus for 2-adic lattices*,
  arXiv:1511.04614 — the proof of the 2-adic symbol calculus (sign walking, oddity
  fusion) and the corrected canonical form; Layer 3's dyadic-symbol source of
  record.
- V. V. Nikulin, *Integer symmetric bilinear forms and some of their geometric
  applications*, Izv. Akad. Nauk SSSR 43 (1979) 111–177; transl. Math. USSR-Izv. 14
  (1980) 103–167 — PRIMARY for Layers 1, 5 (Russian original local in
  `references/`; numbering matches the translation): §1 point 3° discriminant forms;
  Thm 1.3.3 signature mod 8; Prop 1.8.1 generator classification; Cor 1.9.4 genus;
  Thm 1.10.1/Cor 1.10.2 existence; Prop 1.11.2 generator signatures; Thm 1.12.2,
  1.12.4, Cor 1.12.3 embeddings into unimodular; Thm 1.13.1–1.13.2,
  Cor 1.13.3–1.13.5 uniqueness/splitting; Thm 1.14.2 `O(L) → O(q_L)`; Thm 1.14.4
  embedding uniqueness; Prop 1.15.1/Cor 1.15.2 general embeddings; Thm 3.6.2–3.6.3
  2-elementary.
- O. T. O'Meara, *Introduction to Quadratic Forms*, Grundlehren 117, Springer
  (1963; corrected 1973) — PRIMARY for Layers 0, 3, 4, 6: §82E
  scale/norm/volume; §91C Jordan splittings with 91:9 invariants; 92:1–92:2
  non-dyadic classification; §93A/§93E dyadic invariants with 93:16, 93:28, 93:29;
  §102A gen/spn definitions with 102:7 spinor count; 103:4 class-number
  finiteness; 104:4 strong approximation; 104:5 Eichler; 105:1 indecomposable
  splitting; 106:1, 106:13 unimodular classification rank ≤ 9.
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter V —
  Layers 1, 6, 7: V.1.3.5 the `σ`-invariant, V.1.4.3 the `Γₙ` construction (E₈'s
  240 roots and Gram), V.2 Theorem 2 + Corollary 1 (signature mod 8), V.2.2 the
  indefinite structure theorems, V.2.3 the mass formula (*) with `M₈, M₁₆, M₂₄`
  and the Mordell/Witt attributions (⚠ E₈-uniqueness there is derived from the
  unproved-in-chapter mass formula — see Layer 6's route note).
- J. Milnor, D. Husemoller, *Symmetric Bilinear Forms*, Ergebnisse 73, Springer
  (1973) — Layers 1, 6: Chapter II (indefinite unimodular classification),
  Appendix 4 (Milgram's formula; van der Blij).
- J. H. Conway, N. J. A. Sloane, *Sphere Packings, Lattices and Groups*, 3rd ed.,
  Grundlehren 290, Springer (1999) — Chapters 2 (theta), 4 (root lattices, `Dₙ⁺`
  constructions), 15 (genus symbols ⚠ with the Allcock–Gal–Mark correction), 16
  (unimodular masses — the Theorems 1–2 the mass paper delegates to), 17–18
  (Niemeier), 26–27 (Leech). Library list.
- J. W. S. Cassels, *Rational Quadratic Forms*, Academic Press (1978) — Chapters
  8–9 (integral forms over ℤ_p and ℤ, the genus), 10–11 (spinor genus, class
  numbers) — the compact alternative exposition for Layers 3–4. Library list.
- W. Ebeling, *Lattices and Codes*, 3rd ed., Springer (2013) — Layers 1, 6:
  discriminant forms, even unimodular classification in rank ≤ 24, Niemeier via
  glue codes. Library list.
- Y. Kitaoka, *Arithmetic of Quadratic Forms*, Cambridge Tracts 106, CUP (1993) —
  Layers 3, 7, 8: the arithmetic theory with the Minkowski–Siegel apparatus and
  theta background. Library list.
- M. Kneser, *Quadratische Formen* (rev. with R. Scharlau), Springer (2002) —
  Layers 4, 6: neighbors, class numbers, the neighbor-method classifications.
  Library list.
- J. Voight, *Kneser's method of neighbors* (survey, arXiv:2308.11566) — Layer 4's
  modern algorithmic reference.
- G. Chenevier, J. Lannes, *Automorphic Forms and Even Unimodular Lattices*,
  Ergebnisse 69, Springer (2019) — Layer 6/8 horizon: Niemeier lattices,
  neighbors, and theta/automorphic dictionaries. Library list.
- T. Kirschmer, *Definite quadratic and hermitian forms with small class number*,
  Habilitation, RWTH Aachen (2016) — the computational one-class/mass tables the
  LMFDB-facing enumeration semantics validate against. Free online.

## Provenance and coordination

The following is the actual status at the 2026-08-01 review refresh. **No outreach was
performed during this review**. Thus “not contacted” is deliberate, and proposed ownership
does not become agreed ownership until the named gate is cleared.

- **Project / authors:** thefundamentaltheor3m/Sphere-Packing-Lean (Birkbeck,
  Hariharan, Mehta, Lee, and contributors).
  **Exact revision or PR:** `d5e6f1181c804a87f667e6f2fd0870e47f63de1a`;
  Poisson PR #341 at `a6042330f897685ee6cd6d7a01e36e2460d60b18`.
  **Licence:** Apache-2.0.
  **Overlap:** explicit `E₈`, the `ZLattice` Poisson theorem, and analytic theta machinery.
  **Contact / coordination status:** not contacted.
  **Agreed ownership:** none yet; proposed split is their analytic `E₈` model, LFunctions
  Layer 2 for the shared Poisson/theta engine, and this roadmap for arithmetic lattice
  invariants plus the proved isometry between `E₈` models.
  **Plan:** cite; seek one shared/upstream declaration; do not copy the Gauss proof or
  `E₈` code without author agreement.
  **Refactor trigger:** PR #341 lands or maintainers select a different shared home.
- **Project / authors:** math-inc/Sphere-Packing-Lean (Gauss output and contributors).
  **Exact revision or PR:** `1e98fb493088948ca7bbf47d7faed49cc5b39fc4`.
  **Licence:** Apache-2.0.
  **Overlap:** hard-coded dimension-24 Leech/Niemeier reference data and theta checks.
  **Contact / coordination status:** not contacted.
  **Agreed ownership:** none; this roadmap currently claims only independent reference-data
  semantics, not Niemeier completeness or rootless uniqueness.
  **Plan:** cite as prior art and possible quarry; any migration requires author agreement
  and a separately recorded port plan.
  **Refactor trigger:** contact authorizes reuse or a reviewed general lattice API lands.
- **Project / authors:** Mathlib root-system authors and upstream RootSystems roadmap.
  **Exact revision or PR:** Mathlib pin `9caeba1000ef8f302920981f4a08651d325abc81`;
  TauCetiRoadmap PR #47 is **not** a theta-modularity supplier (head
  `7b82f7e25590f754d3c1f013a13dc9bcbb461814`).
  **Licence:** Apache-2.0.
  **Overlap:** `CartanMatrix.E₈`, ADE/root combinatorics, Weyl orders, and prospective
  modular-form vocabulary.
  **Contact / coordination status:** not contacted.
  **Agreed ownership:** none yet; proposed split leaves root combinatorics upstream, this
  roadmap the integral-lattice packaging, and scopes modular packaging out.
  **Plan:** consume existing Cartan/root results; prove one reconciliation isometry; do not
  declare a theta-modularity dependency until a supplier adds the exact proved theorem.
  **Refactor trigger:** the root-system API or a genuine lattice-theta modularity theorem lands.

- **Sibling boundaries.** The
  [quadratic form invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4) owns
  everything over fields (Witt theory, `(dim, d±, s)`, Hilbert symbols, local
  classification); this roadmap owns everything over ℤ and ℤ_p, consumes their
  invariants through the base-change seam of Layer 3, and adopts their convention
  table wholesale (Hasse invariant `∏_{i<j}` Lam/Serre with quaternion-class
  values; `discr` vs `signedDiscr`; the square-class idiom `IsSquare (a*b)`; the
  `[Invertible (2 : K)]` ambient hypothesis, which never crosses to the ℤ-side).
  The [local fields roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2) owns local-field structure
  theory; the [root systems roadmap](../RepresentationTheory/RootSystems/README.md)
  owns root-system combinatorics and the ADE classification (we own the lattices;
  the shared `E₈` coordinate model is coordinated, not duplicated);
  `Completed/EffectiveBounds` supplied the geometry-of-numbers counting engine
  Layer 2 consumes. LFunctions Layer 2 owns general Poisson/theta transformation; this
  roadmap consumes it and adds arithmetic lattice specialization. Modular-form packaging
  has no current supplier and is outside this roadmap.
- **The sphere-packing project** is the one external formalization with real
  overlap: its sorry-free `E₈` (and the math-inc dimension-24 line) predates this
  roadmap, and the coordination contract is stated in "What is already in motion":
  cite their `E8.lean`, prove the isometry to the Gram-matrix `E₈` once, and consume
  LFunctions Layer 2's shared lattice-Poisson statement. Contact the maintainers
  (Hariharan, Birkbeck, Mehta, Lee; the project Zulip channel; weekly packathons) before
  LFunctions starts that Poisson milestone or before any Niemeier/Leech data migration.
  Both repos are Apache-2.0; any code movement still requires
  author coordination per this repository's conventions.
- **LMFDB and the K3 pipeline** are the demand side: the LMFDB lattice section
  stores Gram matrices, determinants, levels, class numbers, and Conway–Sloane
  genus symbols — Layer 3's label-semantics predicates make those columns
  mathematical statements; K3-surface work consumes Layer 5 (Nikulin's embedding
  criteria, `O(L) → O(q_L)`), Layer 4's neighbor semantics (genus enumeration),
  and Layer 7's mass certificates (enumeration completeness). These consumers
  motivated the layer boundaries but impose no conventions beyond the pinned
  Conway–Sloane symbols.
- **Honest-classification pattern.** Following the roadmap family's convention for
  big finite classifications: rank ≤ 9 unimodular is proved (O'Meara's route); rank 16
  completeness is a required theorem, with a proved mass certificate as one permitted
  route; rank 24 is reference-data semantics only and asserts no completeness theorem.
