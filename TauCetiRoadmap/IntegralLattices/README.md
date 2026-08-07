# Roadmap: integral quadratic forms and lattices

Mathlib has the raw materials for lattices and none of their arithmetic. It has quadratic
maps over arbitrary commutative semirings (`QuadraticMap`, whose companion and polar
calculus works over ℤ), symmetric bilinear forms with Gram matrices
(`LinearMap.BilinForm.toMatrix`) and a base change that never inverts 2
(`LinearMap.BilinForm.baseChange`), Smith normal form over a PID with the
index-equals-determinant theorems (`Submodule.natAbs_det_basis_change`,
`Submodule.quotientEquivPiZMod`), a dual-submodule construction whose own docstring asks
for this roadmap (`LinearMap.BilinForm.dualSubmodule`, TODO: "Properly develop the
material in the context of lattices"), analytic ℤ-lattices with covolume and
lattice-point counting (`Mathlib/Algebra/Module/ZLattice/`), an actively developed
root-system library (`Mathlib/LinearAlgebra/RootSystem/`) with the explicit Cartan
matrices including `CartanMatrix.E₈`, and the Jacobi theta functions with their modular
transformation laws (`Mathlib/NumberTheory/ModularForms/JacobiTheta/`). What it has none
of is the arithmetic theory: no even/odd theory, no unimodular lattices, no discriminant
groups or discriminant forms, no genus, no Jordan splittings or Conway–Sloane symbols, no
class-number finiteness, no spinor genus, no mass formula, no Nikulin existence,
uniqueness or embedding theory, and no theta series of a lattice. (Searches for
`IsUnimodular`, `IntegralLattice`, `discriminantGroup` and `thetaSeries` return nothing at
the roadmap pin `9caeba1000`, and nothing has been added since: rechecked on 2026-08-06,
every commit touching the five directories consumed here is a toolchain bump or an API
refactor, among them the `IsApply` reworking of `QuadraticMap` in #42134 and the
`ZLattice/Summable` extraction in #40752.)

This roadmap builds the arithmetic, through its classical high points: the classification
of even unimodular lattices in low rank, the Smith–Minkowski–Siegel mass formula in the
Conway–Sloane normalization, and Nikulin's discriminant-form theory of existence,
uniqueness and primitive embeddings, which is what K3-surface theory actually runs on. It
serves the LMFDB's lattice section, whose records are positive definite integral lattices
with their genus representatives, and the K3 pipeline, which enumerates genera and needs
Nikulin's embedding criteria.

Suggested homes, mirroring Mathlib's directory conventions:

- `TauCeti/LinearAlgebra/QuadraticForm/IntegralLattice/` for Layers 0–2: the
  lattice-with-form structure, the bilinear/quadratic dictionary, dual lattices,
  discriminant groups and finite quadratic forms, reduction theory and automorphism groups
  of positive definite lattices. Mathlib keeps `QuadraticForm` and `BilinearForm`,
  including the `BilinearForm/DualLattice.lean` whose TODOs Layer 1 discharges, under
  `LinearAlgebra/`, and the [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4) puts the ambient form theory
  at `TauCeti/LinearAlgebra/QuadraticForm/`; the lattice theory sits next to both.
- `TauCeti/NumberTheory/IntegralLattice/` for Layers 3–8: localizations and Jordan theory,
  the genus and its symbols, class numbers and spinor genera, Nikulin's theory, the
  unimodular classification, the mass formula, theta series. This is arithmetic, and it
  belongs beside `TauCeti/NumberTheory/Padics/QuadraticForm/`, where the quadratic form
  invariants roadmap puts the local classification consumed here.

## What this roadmap does not cover

These are choices, not omissions. Each is owned by a roadmap named here, or is stated as
work nobody is asking for yet.

- **Quadratic forms over fields.** Square classes, Witt theory, Hasse invariants, the
  Hilbert symbol and the `(dim, d±, s)` local classification belong to the [quadratic form
  invariants roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4) and are consumed
  here, never rebuilt.
- **Orthogonal and spin groups.** The orthogonal and special orthogonal groups of a
  quadratic space over a field, Cartan–Dieudonné, the spinor norm, the Clifford-theoretic
  `Pin/Spin → O/SO` comparison, local topological point groups, finite adelic restricted
  products, strong approximation for `Spin`, and the canonically normalized Tamagawa volume
  of `SO` belong to the Orthogonal and Spin Groups roadmap
  (`TauCetiRoadmap/OrthogonalSpinGroups/`). This roadmap owns the lattice side of that
  story and nothing else: stabilizers of a lattice, the class/genus/spinor-genus double
  cosets, Eichler's theorem for lattice classes, local stabilizer volumes and the
  Conway–Sloane mass formula. No theorem is stated in both roadmaps.
- **Local field structure theory** is the [local fields
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2)'s. This roadmap needs only
  ℤ_p and ℚ_p, and says which of its Layer-3 results survive the substitution ℤ_p ⇝ 𝒪_K
  for a nonarchimedean local field.
- **Root-system combinatorics and the ADE classification** are the [root systems
  roadmap](../RepresentationTheory/RootSystems/README.md)'s. We own the integral-lattice
  packaging of `Aₙ`, `Dₙ`, `E₆`, `E₇`, `E₈`; they own `RootPairing`, Weyl groups and
  `DynkinType`.
- **Poisson summation and the general theta transformation** are owned by [LFunctions Layer
  2](https://github.com/roed-math/TauCetiRoadmap/pull/8). Layer 8 consumes its
  `ZLattice`/dual/covolume interface and proves only the arithmetic specialization.
- **Modular-form packaging.** Nothing here asserts that the theta series of an even lattice
  is a modular form. The [modular forms roadmap](../ModularForms/README.md) develops
  integral-weight Hecke theory, newforms and L-functions; it does not prove modularity of
  lattice theta series, and half-integral weight is not part of it. Layer 8 stops after
  convergence, the q-expansion, and the arithmetic form of the transformation law.
- **The analytic route to the mass formula.** Siegel's theta and Eisenstein-series proof,
  Siegel upper half-spaces, the Weil representation, Siegel–Weil, and Tamagawa measure
  theory for general reductive groups are all outside this roadmap. Layer 7 proves the mass
  formula from the adelic volume of `SO(V)`.
- **Lattices over rings of integers of number fields** (O'Meara's Dedekind-domain
  generality) are a natural extension that nobody is asking for here. Every statement in
  this roadmap is over ℤ and ℤ_p, and the places where a proof is generic are flagged so
  that a later development can reuse them.
- **Also outside:** algorithmic reduction beyond what finiteness needs (LLL), automorphism
  groups of indefinite lattices and Borcherds' method, sphere-packing optimality, and
  constructions of lattices from codes.

## Standing hypotheses and pinned conventions

Decided once here; every layer states its results against this table.

- **The lattice.** A lattice is a finite free ℤ-module with a symmetric integral bilinear
  form. The module hypotheses stay ordinary typeclasses and the form is bundled with its
  symmetry:

  ```lean
  structure IntegralLatticeForm (L : Type u) [AddCommGroup L] [Module ℤ L] where
    form : LinearMap.BilinForm ℤ L
    isSymm : form.IsSymm
  ```

  `[Module.Free ℤ L]` and `[Module.Finite ℤ L]` are required on the declarations that need
  them, not hidden inside the structure, and `IntegralLatticeForm` is a structure, never a
  class: a module can carry many forms. We write `β` for `Λ.form` throughout the prose.
  Rank is `Module.finrank ℤ L`. Results are stated for possibly degenerate `β` wherever
  degeneracy costs nothing, with `β.Nondegenerate` (equivalently Gram determinant nonzero,
  by `LinearMap.BilinForm.nondegenerate_iff_det_ne_zero`) an explicit hypothesis otherwise.
- **Bilinear versus quadratic, and the factor of 2.** The symmetric bilinear form `β` is
  the primary datum; the **norm** of `x` is `β x x` (Conway–Sloane's `x·x`), never silently
  halved. `L` is **even** when `2 ∣ β x x` for all `x` and **odd** otherwise. Even lattices
  are the same thing as integral quadratic forms: an even symmetric `β` is `Q.polarBilin`
  for a unique `Q : QuadraticForm ℤ L` with `Q x = β x x / 2`, built from `QuadraticMap`'s
  companion structure, and conversely `Q.polarBilin` is symmetric and even with
  `Q.polarBilin x x = 2 * Q x`. Both directions and both round trips are Layer-0
  milestones. Never use `QuadraticMap.associated`, `QuadraticForm.toMatrix`,
  `QuadraticForm.discr` or `QuadraticForm.baseChange` in the integral theory: they all
  require `Invertible (2 : R)`, which is false over ℤ. The polar/companion calculus and the
  bilinear Gram and base-change API are the 2-free routes, and that is why this roadmap is
  bilinear-first.
- **Gram matrices and the determinant.** The Gram matrix of `β` in a basis `b` is
  `LinearMap.BilinForm.toMatrix b β`, with entries `β (b i) (b j)`; the change-of-basis law
  is `toMatrix_mul_basis_toMatrix` (`Pᵀ G P`). Over ℤ a base change has determinant `±1`,
  so Gram determinants agree exactly: `det L : ℤ` is a genuine invariant (Layer 0), not a
  square class. We say **determinant**, never "discriminant", for `det L`; "discriminant"
  is reserved for the discriminant *group* `A_L` and *form* `q_L`. The dictionary to the
  square-class invariants of the rationalized form is a pair of stated lemmas,
  `d(β ⊗ ℚ) = [det L] ∈ ℚˣ/(ℚˣ)²` and `d±(β ⊗ ℚ) = (−1)^{n(n−1)/2}·[det L]`, whose
  right-hand sides follow the quadratic form invariants roadmap's `discr`/`signedDiscr`
  conventions.
- **Signature and definiteness.** `(t₊, t₋) := (sigPos, sigNeg)` of the real form (base
  change of `β` to ℝ, then Mathlib's `sigPos`/`sigNeg`, whose `Equivalent`-invariance and
  Sylvester uniqueness are upstream; at the pin these two live in the *root* namespace even
  though their file's docstring says `QuadraticForm.sigPos`, so re-check the name at the
  next toolchain bump). Notation and order follow Nikulin's `(t₍₊₎, t₍₋₎)`, and
  `τ(L) = t₊ − t₋` is the **signature index**. `PosDef` means `QuadraticMap.PosDef` of
  `LinearMap.BilinMap.toQuadraticMap β`, stated over ℤ directly since the predicate is
  order-theoretic and 2-free; `NegDef L` means `PosDef (L(−1))`; **definite** means one or
  the other, and **indefinite** means `t₊ > 0` and `t₋ > 0` under nondegeneracy. Which of
  the three is meant matters: bounded-norm finiteness, minima, reduction theory and theta
  series are stated for **positive definite** lattices, because `{x | β x x ≤ C}` is
  infinite and `Θ_L` diverges when `β` is negative definite. Statements invariant under
  `β ⇝ −β`, automorphism-group finiteness among them, are stated for positive definite
  lattices and then extended to definite ones by that substitution. The transfer `PosDef`
  over ℤ ⟺ `PosDef` of the ℝ-form is a Layer-0 lemma, absent from Mathlib, whose
  `PosDef.det_pos`-style results are walled behind `RCLike`.
- **Twists and sums.** For `a : ℤ`, `L(a)` is the same module with the form `a • β`, so
  `E₈(−1)` is the negative definite `E₈`. Twisting by `0` destroys nondegeneracy, so
  statements about `L(a)` carry `a ≠ 0`; those that stay inside the positive definite
  theory (the theta scaling `Θ_{L(a)}(τ) = Θ_L(aτ)`, mass under twist) carry `a > 0`.
  Orthogonal direct sum `L ⊕ M` puts the summed form on `L × M`, with Gram matrix the block
  sum. Isometry is `LinearMap.BilinForm.Equivalent`, Mathlib's bundled `IsometryEquiv` for
  bilinear forms, and "class" always means isometry class over ℤ.
- **The rational and quotient types, pinned.** The ambient rational space is `V = ℚ ⊗ L`
  with `B = β.baseChange ℚ`. `ℚ/ℤ` is `AddCircle (1 : ℚ)` and `ℚ/2ℤ` is
  `AddCircle (2 : ℚ)`, with `QuotientAddGroup.mk` as the quotient maps; the canonical
  halving homomorphism `[r] mod 2ℤ ↦ [r/2] mod ℤ` is
  `AddCircle.equivAddCircle (2 : ℚ) (1 : ℚ) two_ne_zero one_ne_zero`, which by
  `equivAddCircle_apply_mk` sends `x` to `x * (2⁻¹ * 1)`. It is what polarizes a
  discriminant quadratic form into a discriminant bilinear form, so it is named once and
  used everywhere.
- **Dual lattice and discriminant forms.** The dual lattice is
  `L^⋆ = LinearMap.BilinForm.dualSubmodule B L` inside `V`, and integrality of `β` is
  exactly `L ≤ L^⋆`. The **discriminant group** is `A_L = L^⋆/L`, finite of order
  `|det L|`, generated by at most `rank L` elements. The **discriminant bilinear form** is
  `b_L : A_L × A_L → ℚ/ℤ`, `b_L(x̄, ȳ) = B(x, y) mod ℤ`, defined for every nondegenerate
  integral `L`. For **even** `L` the **discriminant quadratic form** is `q_L : A_L → ℚ/2ℤ`,
  `q_L(x̄) = B(x, x) mod 2ℤ`. The `ℚ/2ℤ` target is Nikulin's convention (§1, point 3°) and
  is what makes `q_L` remember evenness; sources that value `q` in `ℚ/ℤ` differ from ours
  by the halving map above. Odd lattices carry only `b_L`.
- **Two signature invariants, kept apart.** For any nondegenerate finite quadratic form
  `(A, q)` the **Gauss-sum invariant** `sign q ∈ ℤ/8`, also called the Brown invariant, is
  defined by `∑_{a ∈ A} e^{πi q(a)} = √#A · e^{2πi·sign(q)/8}`; that the right-hand side has
  this shape is a theorem about Gauss sums (Layer 1), and it is a statement about finite
  quadratic forms alone, with no lattice in sight. **Milgram's theorem**, also called van
  der Blij's lemma, is the separate statement that for an even lattice `L` the two agree:
  `t₊ − t₋ ≡ sign q_L (mod 8)` (Nikulin Theorem 1.3.3). We never call the definition
  "Milgram's formula".
- **Scale, norm ideal, level.** `𝔰(L) ⊆ ℤ` is the ideal generated by all `β x y` and
  `𝔫(L)` the ideal generated by all `β x x` (O'Meara §82E); `2𝔰 ⊆ 𝔫 ⊆ 𝔰`, and `L` is even
  exactly when `𝔫 ⊆ 2ℤ`. The **level** of a nondegenerate integral `L` is the least `N > 0`
  such that `N·G⁻¹` is integral with even diagonal, for any Gram matrix `G`, which is
  basis-independent, and for even `L` is the least `N` with `N·q_L = 0`. This is the level
  in the LMFDB's lattice columns.
- **Genus symbols are Conway–Sloane's.** The `p`-adic symbols of SPLAG Chapter 15, in the
  terminology of the mass-formula paper §§4–5: Jordan constituents `f_q` at scales
  `q = p^i`, with ranks and signs `ε = (det f_q | p) ∈ {±1}` for odd `p`, and for `p = 2`
  also the **type** (I, odd, or II, even) and the **oddity** (trace mod 8, the mass paper's
  octane value). Dyadic Jordan splittings are not unique, and the resulting equivalences on
  symbols are **sign walking** and **oddity fusion**. The 2-adic symbol calculus is stated
  as Conway–Sloane define it and proved as Allcock–Gal–Mark prove it: theirs
  (arXiv:1511.04614) is the first published proof, and it **corrects an error in
  Conway–Sloane's canonical form**, so the canonical 2-adic symbol formalized here is the
  corrected one.
- **Nikulin's vocabulary.** Even lattices are governed by the triple `(t₊, t₋, q)`.
  `l(A)` is the minimal number of generators of a finite abelian group `A`, and
  `l(A_q) = max_p l(A_{q_p})` over the `p`-primary parts. `K(q_p)` denotes a `p`-adic
  lattice of rank `l(A_{q_p})` whose discriminant form is `q_p`, and `discr K(q_p)` its
  determinant square class in `ℤ_p^*/(ℤ_p^*)²`. The generating finite quadratic forms are
  `q_θ^{(p)}(p^k)` on `ℤ/p^k` (the discriminant form of the rank-one `p`-adic lattice with
  Gram `(θ p^k)`), and `u^{(2)}(2^k)`, `v^{(2)}(2^k)` (the discriminant forms of the rank-two
  2-adic lattices with Grams `2^k·!![0,1;1,0]` and `2^k·!![2,1;1,2]`). Nikulin's own `E₈` is
  *negative* definite, of signature `(0,8)`; ours is positive definite with Gram
  `CartanMatrix.E₈`, so his statements are cited with the twist `E₈(−1)` made explicit. The
  K3 lattice is `Λ_{K3} = U³ ⊕ E₈(−1)²`, even unimodular of signature `(3,19)`.
- **Theta series.** For **positive definite** `L`, `Θ_L(τ) = ∑_{x ∈ L} exp(πiτ·β(x,x))` on
  the upper half-plane: the SPLAG normalization `∑ q^{x·x}` with nome `q = e^{πiτ}`, chosen
  because Mathlib's `jacobiTheta τ = ∑ exp(πi n² τ)` is literally `Θ_ℤ` in it. For even `L`
  this is a series in `e^{2πiτ}` whose exponents are the half-norms `Q(x)`; the two nomes,
  `e^{πiτ}` for norms and `e^{2πiτ}` for half-norms, are the theta instance of the factor-of-2
  bookkeeping, and the translation is stated once beside the definition. In the
  transformation law, `(τ/i)^{n/2}` means `Complex.cpow (τ/i) (n/2)` for the principal
  branch: for `τ` in the upper half-plane `τ/i = -iτ` has positive real part, so the argument
  never meets the cut, and the branch is fixed by `(τ/i)^{n/2} > 0` on the positive imaginary
  axis. The determinant factor is the positive real square root `Real.sqrt (det L)`, which
  makes sense because a positive definite lattice has `det L > 0`.
- **Mass.** For a genus `G` of positive definite lattices, the **full mass** is
  `m(G) = ∑_{cls L ∈ G} 1/|O(L)|` and the **proper mass** is
  `m⁺(G) = ∑_{cls⁺ L ∈ G} 1/|SO(L)|`, the second sum running over proper classes. This is
  Conway–Sloane's normalization, their mass-formula paper eq. (1), and the formula proved
  in Layer 7 has the shape of their eqs. (2)–(3). Their §§3, 6 warn that the formula as
  normally stated is wrong in dimensions `≤ 1`, where the Tamagawa factor 2 becomes 1, so
  the low-dimensional values are part of the statement. The `p = 2` local factor was
  asserted by Conway–Sloane without proof; the first proof is Cho's (Compositio 151
  (2015)), and Layer 7 is arranged accordingly.

## What Mathlib already has (consume)

Checked at the roadmap pin `9caeba1000` (2026-06-03) and rechecked on master 2026-08-06.

- **Quadratic maps over ℤ, for free:** `Mathlib/LinearAlgebra/QuadraticForm/Basic.lean` has
  `QuadraticMap` over any `CommSemiring` with the companion structure (`exists_companion'`),
  `polar`, `polarBilin`, `ofPolar`, `LinearMap.BilinMap.toQuadraticMap` (`x ↦ β x x`),
  `polar_self` (`= 2 • Q x`), `two_nsmul_associated`, `Anisotropic`, and
  `QuadraticMap.PosDef`, which is order-theoretic and fully general. The `Invertible (2 : R)`
  wall runs through `associated`/`associatedHom`, `QuadraticForm.toMatrix`/`toMatrix'`,
  `QuadraticForm.discr`/`discr'`, `exists_orthogonal_basis` and `QuadraticForm.baseChange`:
  all unusable over ℤ, consumed only after base change to ℚ, ℝ or ℚ_p.
  `Matrix.toQuadraticForm'` (`x ↦ xᵀMx`) is 2-free and usable over ℤ.
- **Bilinear forms:** `Mathlib/LinearAlgebra/BilinearForm/*` has `IsSymm`, `IsRefl`,
  `Nondegenerate`, `restrict` with `IsSymm.restrict`, `flip`, and the bundled
  `Isometry`/`IsometryEquiv`/`Equivalent`;
  `Mathlib/LinearAlgebra/Matrix/BilinearForm.lean` has `BilinForm.toMatrix`/`Matrix.toBilin`
  and their primed `n → R` versions, `toMatrix_apply` (the Gram matrix), the congruence law
  `toMatrix_mul_basis_toMatrix`, and `nondegenerate_iff_det_ne_zero` over any `IsDomain`, so
  over ℤ. Base change without 2 is
  `Mathlib/LinearAlgebra/BilinearForm/TensorProduct.lean`'s
  `LinearMap.BilinForm.baseChange` over any `CommSemiring`, with `baseChange_tmul` and
  `IsSymm.baseChange`: this is how we localize to ℚ, ℝ, ℤ_p and ℚ_p, `p = 2` included.
- **The dual submodule:** `Mathlib/LinearAlgebra/BilinearForm/DualLattice.lean` has
  `LinearMap.BilinForm.dualSubmodule` (for `B` over a field `S` and lattices over `R ⊆ S`),
  `dualSubmodule_span_of_basis`, `dualSubmodule_dualSubmodule_of_basis` (`L^{⋆⋆} = L` for
  symmetric nondegenerate `B`), and `dualSubmoduleToDual` with injectivity only. The file's
  own TODOs, "Properly develop the material in the context of lattices" and "Show that this
  is perfect when `N` is a lattice and `B` is nondegenerate", are Layer-1 milestones here.
- **Smith normal form and index = |det|:** `Mathlib/LinearAlgebra/FreeModule/PID.lean`
  (`Submodule.basisOfPid`, `Module.Basis.SmithNormalForm`,
  `Submodule.smithNormalFormOfRankEq`, `smithNormalFormCoeffs`),
  `Mathlib/LinearAlgebra/FreeModule/Finite/CardQuotient.lean`
  (`Submodule.natAbs_det_basis_change`, `AddSubgroup.index_eq_natAbs_det`,
  `relIndex_eq_natAbs_det`, and the ℚ-ambient `AddSubgroup.relIndex_eq_abs_det`, which is
  exactly what `[L^⋆ : L]` needs), and
  `Mathlib/LinearAlgebra/FreeModule/Finite/Quotient.lean`
  (`Submodule.quotientEquivPiZMod`, the discriminant group in invariant-factor form). There
  is no invariant-factor uniqueness theorem and no matrix-level Smith or Hermite algorithm
  at the pin, so Layer 1 states what it needs and no more.
- **Finite abelian groups:** `Mathlib/GroupTheory/FiniteAbelian/Basic.lean`
  (`AddCommGroup.equiv_directSum_zmod_of_finite` and the finitely generated structure
  theorem) and `Duality.lean`, whose duality theorems are stated multiplicatively, for
  homomorphisms into `Mˣ` with enough roots of unity; Layer 1 relates them to the additive
  `ℚ/ℤ`-valued dual it uses for `b_L`.
- **Circle quotients:** `Mathlib/Topology/Instances/AddCircle/Defs.lean` has `AddCircle p`
  as `𝕜 ⧸ AddSubgroup.zmultiples p` and the rescaling isomorphism `AddCircle.equivAddCircle`
  with its `apply_mk` simp lemma, which is where `ℚ/ℤ`, `ℚ/2ℤ` and the halving map come
  from.
- **Orthogonality over rings:** `Mathlib/LinearAlgebra/BilinearForm/Orthogonal.lean` has
  `IsOrtho`, `iIsOrtho`, `orthogonal`, and one ring-level splitting tool,
  `nondegenerate_restrict_of_disjoint_orthogonal` (`CommRing`). The converse splitting
  (`restrict` nondegenerate implies `IsCompl W (B.orthogonal W)`), `orthogonal_orthogonal`
  and the dimension counts are field-and-finite-dimensional only. Over ℤ the correct
  splitting hypothesis is unimodularity of the restriction, and proving that is a Layer-0
  target, not an import.
- **Analytic lattices:** `Mathlib/Algebra/Module/ZLattice/Basic.lean` (`IsZLattice`,
  `ZLattice.rank`, `module_free`, fundamental domains), `Covolume.lean`
  (`ZLattice.covolume`, the `covolume_eq_det` family, `covolume_div_covolume_eq_relIndex`,
  and the counting asymptotics `tendsto_card_div_pow`), `Summable.lean` (norm-power
  summability over lattices, which is Layer 8's convergence input), and
  `Mathlib/MeasureTheory/Group/GeometryOfNumbers.lean`
  (`exists_ne_zero_mem_lattice_of_measure_mul_two_pow_lt_measure`, Minkowski's convex-body
  theorem).
- **Signature:** `Mathlib/LinearAlgebra/QuadraticForm/Signature.lean` (D. Loeffler, new at
  this pin) has `sigPos`/`sigNeg` with `Equivalent`-invariance and the Sylvester uniqueness
  pair `QuadraticForm.sigPos_of_equiv_weightedSumSquares` and its `sigNeg` twin;
  `Real.lean` has the existence half, `isometryEquivSignWeightedSumSquares`. There is no
  bundled signature and no `(p,q)`-classification `iff`, so Layer 0 packages what the
  lattice theory needs.
- **Root systems and Cartan matrices:** `Mathlib/LinearAlgebra/RootSystem/*`, consumed
  through the [root systems roadmap](../RepresentationTheory/RootSystems/README.md), with
  `OfBilinear.lean` (reflections from a bilinear form) the natural hook for root-lattice
  isometries, and `Mathlib/Data/Matrix/Cartan.lean` with `CartanMatrix.A/D/E₆/E₇/E₈` as
  explicit integer matrices: the Gram matrices of the root lattices, ready-made. Master
  moved this file to `Mathlib/LinearAlgebra/Matrix/Cartan.lean` on 2026-06-05, so cite the
  new path at the next bump.
- **Theta functions:** `Mathlib/NumberTheory/ModularForms/JacobiTheta/OneVariable.lean`
  (`jacobiTheta`, which is `Θ_ℤ` in the pinned normalization, with `jacobiTheta_two_add` and
  the `S`-transformation `jacobiTheta_S_smul`), `TwoVariable.lean` (`jacobiTheta₂` with its
  functional equation), `Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.lean`
  (`Complex.tsum_exp_neg_quadratic`, the rank-one theta transformation), and
  `Mathlib/Analysis/Fourier/PoissonSummation.lean` (`Real.tsum_eq_tsum_fourier`). Poisson
  summation exists only on ℝ, at the pin and on master; the ℝⁿ version is LFunctions Layer
  2's.
- **Positive definite matrices:** `Mathlib/LinearAlgebra/Matrix/PosDef.lean` and
  `Mathlib/Analysis/Matrix/PosDef.lean` have `Matrix.PosDef`/`PosSemidef`, congruence
  invariance and Schur complements; the eigenvalue and `det_pos` characterizations are
  `RCLike`-only, which is why the ℤ-to-ℝ definiteness transfer is built in Layer 0.
- **p-adics:** `Mathlib/NumberTheory/Padics/` has `ℤ_[p]`, `ℚ_[p]`, Hensel's lemma and
  `PadicInt.unitCoeff`: Layer 3's coefficient rings.

## What Tau Ceti already has (consume)

- **`Completed/EffectiveBounds`** (landed): the geometry-of-numbers counting results in
  `TauCeti/NumberTheory/GeometryOfNumbers/Doubling.lean` (box packing and doubling counts,
  deliberately measure-free) and its instruction to reconcile with `ZLattice` before adding
  counting primitives. Layer 2 reuses both.
- **`TauCeti/LinearAlgebra/OrthogonalGroup.lean`** (landed):
  `orthogonalGroupToLinearIsometryEquiv`, the Euclidean orthogonal group as isometries.
  Layer 2's argument that `O(L)` is discrete in `O(n,ℝ)` lands next to it.
- **`TauCeti/FieldTheory/SquareClassGroup.lean`** (landed): the square-class group as a
  `ZMod 2`-vector space with `squareClass`, `squareClass_eq_zero_iff` and
  `linearIndependent_squareClass_iff`. Unit-determinant square classes at odd `p`, Layer 3's
  `ε` signs, are stated in this language.
- **The [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4)**, consumed by name: its
  Layer 0 chain-equivalence theory and square-class calculus; its Layer 1 Witt
  decomposition and cancellation over fields, applied to `V = ℚ ⊗ L`; its Layer 3 classical
  invariants with the `discr`/`signedDiscr` distinction and the Lam/Serre Hasse invariant
  `s(q) = ∏_{i<j} (aᵢ,aⱼ)`; and its Layer 6 classification of forms over `ℚ_p` by
  `(dim, d±, s)`, dyadic case included, with the Hilbert-symbol value dictionary. Layer 3's
  rational shadow consumes exactly these, using their convention table. Their standing
  `[Invertible (2 : K)]` hypothesis lives on the field side of the base change and never
  crosses to ours.
- **The Orthogonal and Spin Groups roadmap** (`TauCetiRoadmap/OrthogonalSpinGroups/`),
  consumed by Layers 4 and 7 for: `O(Q)` and `SO(Q)` of a quadratic space over ℚ or ℚ_p and
  their topologies; Cartan–Dieudonné; the spinor norm through reflections, with its
  well-definedness and multiplicativity; the Clifford comparison `Spin(Q) → SO(Q)` with its
  kernel and image; finite adelic restricted products of these point groups; strong
  approximation for `Spin(V)` when `V` is indefinite of dimension at least 3; canonical Haar
  measures at every place; and the Tamagawa volume theorem
  `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` with its dimension hypotheses.
- **The [global class field theory
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/6)**, for exactly one theorem:
  its Layer 11 Hilbert product formula `∏_v (a,b)_v = 1` over ℚ, which is what makes the
  global oddity and sign-product constraints on genus symbols (Layer 3) true. No other part
  of that roadmap is a dependency.
- **The [LFunctions roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/8)**, Layer 2
  items 1–8: the analytic dual lattice and its biduality, the covolume product
  `covol(L)·covol(Lᵛ) = 1`, Poisson summation for a general `ZLattice`, the Fourier
  transform of a Gaussian, and the Gaussian theta transformation
  `Θ_L(1/t) = t^{n/2} covol(L)⁻¹ Θ_{Lᵛ}(t)` for `t > 0`. Layer 8 consumes these and adds the
  arithmetic content.
- **The [root systems roadmap](../RepresentationTheory/RootSystems/README.md)**: its Layer 5
  realizes the Dynkin types by explicit coordinate models, "E₈ from its even unimodular
  lattice". The boundary is that they own `RootPairing`, bases, Weyl groups, `DynkinType`
  and the ADE classification, and we own the integral lattices `Aₙ/Dₙ/E₆/E₇/E₈` with their
  Gram matrices, determinants, discriminant groups and evenness, together with the statement
  that the norm-2 vectors of such a lattice form a root system of the corresponding type
  (through `RootSystem/OfBilinear`). That statement is our tool for `E₈` uniqueness in Layer
  6 and their realization input, so the coordinate models are coordinated rather than
  duplicated. The Layer-7 milestone `|O(E₈)| = |W(E₈)| = 696729600` consumes their Weyl
  group order and adds only that reflections in roots generate `O(E₈)`.
- **The [multiquadratic roadmap](../Multiquadratic/README.md)** (landed code above): no
  interface beyond the square-class idiom. Its "genus theory" is genus theory of number
  fields, a different genus, and the name collision is noted so that nobody connects the
  two.

### Dependencies, by milestone

Each row is a theorem or interface consumed by name, not a whole roadmap.

| Consumed | From | Used by |
| --- | --- | --- |
| square classes, Hilbert symbols, `(dim, d±, s)` classification over `ℚ_p` | Quadratic Form Invariants, Layers 0, 3, 6 | Layers 3, 5 |
| Hilbert product formula `∏_v (a,b)_v = 1` over ℚ | Global Class Field Theory, Layer 11 | Layer 3 (oddity and sign-product constraints) |
| spinor norm on `O(V_p)`, `Spin → SO` and its image | Orthogonal and Spin Groups, Layers 1–2 | Layer 4 (spinor genera) |
| finite adelic restricted products of `O(V)`, `SO(V)`, `Spin(V)` | Orthogonal and Spin Groups, Layer 3 | Layers 4, 7 |
| strong approximation for `Spin(V)`, `V` indefinite, `dim ≥ 3` | Orthogonal and Spin Groups, Layer 4 | Layer 4 (Eichler) |
| canonical local Haar measures and `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` | Orthogonal and Spin Groups, Layer 5 | Layer 7 |
| Poisson summation and the Gaussian theta transformation for a `ZLattice` | LFunctions, Layer 2 (items 1–8) | Layer 8 |
| `\|W(E₈)\|`, ADE classification, root system of a lattice | Root Systems, Layer 5 | Layers 6, 7 |
| box-counting and doubling estimates | `Completed/EffectiveBounds` | Layer 2 |
| `Kˣ/(Kˣ)²` finiteness for nonarchimedean local `K` | Local Fields, Layer 1 | Layer 3's generalization notes |

## What is already in motion elsewhere (cite, follow, do not duplicate)

- **The sphere-packing formalization**
  ([thefundamentaltheor3m/Sphere-Packing-Lean](https://github.com/thefundamentaltheor3m/Sphere-Packing-Lean);
  Apache-2.0; maintainers C. Birkbeck, S. Hariharan, B. Mehta, Seewoo Lee; M. Viazovska
  among the contributors; project paper arXiv:2604.23468). Its `SpherePacking/Basic/E8.lean`
  (Mehta, Ma) is sorry-free and contains `Submodule.E8` (the even-coordinate and
  half-integer model over any field with `NeZero 2`), the explicit basis matrix `E8Matrix`
  with `E8Matrix_unimodular`, `E8Lattice` in `EuclideanSpace ℝ (Fin 8)` with `IsZLattice`,
  integrality, evenness, minimal norm `√2` and covolume 1. Cite and coordinate rather than
  re-deriving their `E₈`: ours is the abstract Gram-matrix lattice, and the isometry between
  the two models is a Layer-6 milestone, so Lean ends up with one `E₈` and a proved
  isometry. Their `CohnElkies/Prereqs.lean` states Poisson summation for an arbitrary
  `IsZLattice` with dual `bilinFormOfRealInner.dualSubmodule Λ` (still `sorry` in main,
  proved inside the Gauss contribution in their open PR #341); LFunctions Layer 2, not this
  roadmap, owns that statement and coordinates with them. The companion
  [math-inc/Sphere-Packing-Lean](https://github.com/math-inc/Sphere-Packing-Lean) (Gauss
  output, Apache-2.0, sorry-free) has a dimension-24 line: an explicit Leech generator
  matrix, even-unimodular theta machinery in ℝ²⁴ (`thetaShell`/`thetaCoeff`, discriminant
  pairings, dual covolumes) and the rootless-Niemeier-is-Leech argument, all hardcoded to
  `EuclideanSpace ℝ (Fin 24)`. That is a citation and a possible quarry for Layer 6's
  Niemeier reference data, not a migration source without the authors' agreement and a
  licence-clean port plan.
- **Mathlib PR #35812** (successive minima and the existence of a directional basis, in
  `MeasureTheory/Group/GeometryOfNumbers`; open and active on 2026-08-06) overlaps Layer 2
  directly: successive minima `λ₁ ≤ … ≤ λₙ` of a lattice with respect to a convex body, and
  a basis adapted to them, are the first two steps of the route to Minkowski's second
  theorem and to reduction bounds. Layer 2 states its minimum and reduction theory in that
  vocabulary and consumes the PR's API if it has landed, and otherwise proves what it needs
  by the elementary route (successive minima of the Gram form directly, without the convex
  body), naming things as the PR does so that adopting it later is an import rather than a
  rewrite. Layer 2 does not wait for it and does not send its own results upstream.
- **Other Mathlib PRs to track:** #41867 (generalizing `ZLattice` from ℤ-submodules to
  `AddSubgroupClass`; open, last touched 2026-07-24) touches Layer 2's consumption surface,
  so Layer 2 states its covolume use against the stable API; #42157 (generalized E-type
  Cartan matrices; open, 2026-07-31) is the `CartanMatrix.E₈` citation; #38194 (a small
  `IndefiniteMetric` structure; open, 2026-07-18) has no mathematical overlap but occupies
  naming territory for indefinite forms; #39460 (`ZLattice` torus quotients) and #10345
  (Voronoi domains) are drafts. There are no open or 2026-merged Mathlib PRs on unimodular
  or integral lattices, discriminant groups, theta series of lattices, Witt rings or Hermite
  normal form.
- **HassePrinciple** (mariainesdff/HassePrinciple) and the central-simple-algebra pipeline
  are coordinated by the [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4); this roadmap reaches them
  only through its interfaces.

## What is missing (build here)

Everything arithmetic: the lattice structure with its even/odd dictionary; the determinant
as a genuine ℤ-invariant; scale, norm ideal and level; the splitting calculus over ℤ, where
unimodular summands split off and nondegenerate ones need not; definiteness transfer between
ℤ and ℝ; dual lattices with `[L^⋆ : L] = |det L|` and perfectness of the discriminant
pairing, discharging Mathlib's TODOs; discriminant groups and finite quadratic forms with
the Gauss-sum invariant and Milgram's theorem; the two overlattice correspondences, integral
and even; finiteness of automorphism groups and reduction theory for positive definite
lattices, with finiteness of classes of bounded determinant; `ℤ_p`-lattices and Jordan
splittings, with odd-`p` uniqueness and the proved 2-adic symbol calculus; the genus, its
Conway–Sloane symbols, and the meaning of the LMFDB's lattice columns; class numbers,
spinor genera, Eichler's theorem and Kneser neighbors, on top of the orthogonal and spin
groups supplied by the sibling roadmap; Nikulin's discriminant-form theory of existence,
uniqueness, splitting and primitive embeddings; the classification of unimodular lattices in
low rank; the Smith–Minkowski–Siegel mass formula in the Conway–Sloane normalization, with
its local densities and verification instances; and arithmetic theta series with their
convergence, q-expansion and transformation law. None of this exists upstream.

`Suggested.lean` pins Lean forms for the milestones whose types are expressible at the pin.
The Conway–Sloane symbol calculus of Layer 3, the spinor genera of Layer 4 and the mass
formula of Layer 7 stay in prose here until the earlier layers make their types
expressible, at which point their statements are added there with `sorry`.

---

## The build, in layers

The order below is the dependency order; "Ordering and parallelism" names the parts that
can be built at the same time.

### Layer 0: lattices, the dictionary, and first invariants

- **The objects.** The setting of the convention table: finite free ℤ-modules with a
  symmetric `LinearMap.BilinForm ℤ L` bundled as `IntegralLatticeForm`; the predicates
  `IsEven`, `Nondegenerate` (consuming `nondegenerate_iff_det_ne_zero`), `IsUnimodular`
  (`det = ±1`) and `PosDef`; orthogonal direct sums, twists `L(a)`, and
  `LinearMap.BilinForm.Equivalent` as isometry. The basic calculus: the determinant of a
  direct sum is the product of the determinants, that of `L(a)` is `aⁿ det L`, rank is
  additive, and restriction to a submodule.
- **The even/quadratic dictionary**, done once and used everywhere: even symmetric `β`
  corresponds to `Q : QuadraticForm ℤ L` through `polarBilin`, in both directions and with
  both round trips (`Suggested.lean` pins the `∃!` forms); norms against half-norms; the
  induced dictionary on Gram matrices (even diagonal), on direct sums and on twists.
- **The determinant.** Gram matrices through `BilinForm.toMatrix`; equality of Gram
  determinants under change of basis over ℤ; `det L : ℤ` as an invariant; its behaviour
  under sums, twists and finite-index sublattices, `det L' = [L : L']² · det L`, proved from
  `natAbs_det_basis_change`. That index formula is what Layer 1 runs on.
- **Scale, norm ideal and level** as in the convention table, with the characterization
  that `L` is even exactly when `𝔫(L) ⊆ 2ℤ` (O'Meara §82E is the model).
- **Definiteness transfer.** `PosDef` over ℤ is equivalent to `PosDef` of the ℝ-form and to
  `Matrix.PosDef` of the real Gram matrix, which is the ℤ-to-ℝ step Mathlib's `RCLike`-walled
  `PosDef` API lacks; definite implies nondegenerate; the signature `(t₊, t₋)` through
  `sigPos`/`sigNeg` of the ℝ-form, with `t₊ + t₋ = rank L` for nondegenerate `L` (consuming
  `sigPos_add_sigNeg_add_radical`) and the positive definite / negative definite /
  indefinite trichotomy.
- **Unimodular orthogonal splitting.** If `M ≤ L` and `β|_M` is *unimodular*, then
  `L = M ⊕ M^⊥`. Over ℤ it is unimodularity, not nondegeneracy, that splits: Mathlib's
  `IsCompl` route is field-only, and its one ring-level lemma
  `nondegenerate_restrict_of_disjoint_orthogonal` goes the other way. Corollaries: a vector
  of norm `±1` splits off a `⟨±1⟩` summand. Integral Witt cancellation is **false**, and this
  layer records that as a stated non-theorem with the classical counterexample, so that
  nobody imports field Witt theory by reflex; the true cancellation statements are Nikulin's,
  in Layer 5.
- **The standard examples**, each with its rank, determinant, parity, signature and level:
  `⟨a⟩`, `Iₙ = ⟨1⟩ⁿ`, `U` with Gram `!![0,1;1,0]`, and the root lattices `Aₙ`, `Dₙ`, `E₆`,
  `E₇`, `E₈` through their Cartan matrices, with `Aₙ`'s coordinate model
  `{x ∈ ℤ^{n+1} : ∑ x = 0}` and `Dₙ`'s even-coordinate-sum model given as alternative
  presentations together with the isometries to the Gram-matrix versions, and their twists.

### Layer 1: dual lattices, discriminant groups, and finite quadratic forms

- **The ambient realization.** `V = ℚ ⊗ L` with `B = β.baseChange ℚ`, and the dictionary
  between abstract lattices and full-rank submodules of a rational quadratic space, in both
  directions, transporting every Layer-0 invariant. Integrality is `L ≤ L^⋆`.
- **The dual lattice.** `L^⋆ = B.dualSubmodule L`, consuming `dualSubmodule_span_of_basis`
  and `dualSubmodule_dualSubmodule_of_basis` (`L^{⋆⋆} = L`); duality reverses inclusions;
  for `a ≠ 0`, `(L(a))^⋆ = (L^⋆)(a⁻¹)` inside `V`, the scaling being by the *nonzero*
  rational `a⁻¹`; the Gram matrix of the dual basis is `G⁻¹`; `det L^⋆ = (det L)⁻¹` in ℚ;
  and `L` is unimodular exactly when `L = L^⋆` (`Suggested.lean`).
- **The discriminant group.** `A_L = L^⋆/L` is finite with `#A_L = |det L|`, by
  `relIndex_eq_abs_det` and the dual-basis span; its invariant-factor decomposition comes
  from `quotientEquivPiZMod`, and `l(A_L) ≤ rank L`. The pairing `A_L × A_L → ℚ/ℤ` is
  **perfect**, which is what Mathlib's `dualSubmoduleToDual` TODO asks for, and relating the
  ℚ/ℤ-valued dual to the multiplicative duality of `GroupTheory/FiniteAbelian/Duality` is
  part of this milestone.
- **The discriminant forms.** `b_L` for every nondegenerate integral `L`, and `q_L` for even
  `L`, valued in the pinned `AddCircle` types, with `b_L` obtained from `q_L` by
  polarization followed by the halving map. Functoriality: canonical isometries
  `A_{L⊕M} ≅ A_L ⊕ A_M` carrying `q_{L⊕M}` to `q_L ⊕ q_M`, and `A_{L(−1)} ≅ A_L` carrying
  `q_{L(−1)}` to `−q_L`. These are isometries of finite quadratic forms, not equalities of
  types, and are stated that way because that is what Lean will prove.
- **Overlattices, in two versions.** For `L` nondegenerate integral and `M ⊇ L` of finite
  index, `M/L` is a subgroup of `A_L`, and:
  1. **integral** overlattices `M` correspond to subgroups `H ≤ A_L` with `b_L|_{H×H} = 0`,
     with `A_M ≅ H^⊥/H` carrying `b_M` induced by `b_L`, where `H^⊥` is the orthogonal
     complement of `H` for `b_L`;
  2. for **even** `L`, the **even** overlattices correspond to the subgroups `H` with
     `q_L|_H = 0`, again with `A_M ≅ H^⊥/H` and `q_M` induced by `q_L`.
  Isotropy for `q_L` implies isotropy for `b_L`, so the second correspondence is the
  restriction of the first; conflating them loses the odd integral overlattices of an even
  lattice. In both cases `det M = det L / [M : L]²`. It is the second correspondence,
  stated for `q`, that Nikulin's embedding theory runs on.
- **Finite quadratic and bilinear forms, standalone.** A finite quadratic form is a pair
  `(A, q)` with `A` a finite abelian group and `q : A → ℚ/2ℤ` satisfying
  `q(n • a) = n² • q(a)` and having biadditive polarization
  `b(x,y) = half(q(x+y) − q(x) − q(y)) ∈ ℚ/ℤ`; nondegeneracy is bijectivity of the adjoint
  `A → (A →+ ℚ/ℤ)`. Required: orthogonal sums; the `p`-primary decomposition
  `q = ⊕_p q_p`; isometries and the group `O(q)`; the generators `q_θ^{(p)}(p^k)`,
  `u^{(2)}(2^k)`, `v^{(2)}(2^k)` of Nikulin Proposition 1.8.1, with the proof that every
  finite quadratic form is an orthogonal sum of them; and the relations among them of
  Nikulin Proposition 1.8.2, which is what makes the list into a classification and is used
  by Layers 3 and 5 to recognize when two symbols name the same form. Both the generation
  statement and the relations are milestones of this layer, since Layer 5's existence and
  uniqueness theorems quantify over these summands by name.
- **The Gauss-sum invariant.** `∑_{a ∈ A} e^{πi q(a)} = √#A · e^{2πi·sign(q)/8}` for
  nondegenerate `(A, q)`, defining `sign q ∈ ℤ/8` (Milnor–Husemoller Appendix 4 is the
  reference proof; Mathlib's Gauss-sum and quadratic-character library is the input), with
  additivity over orthogonal sums and the generator values of Nikulin Proposition 1.11.2:
  `sign q_θ^{(p)}(p^k) ≡ k²(1−p) + 4kη (mod 8)` for odd `p`, where `(θ|p) = (−1)^η`;
  `sign q_θ^{(2)}(2^k) ≡ θ + 4kω(θ) (mod 8)` with `ω(θ) ≡ (θ²−1)/8 (mod 2)`;
  `sign v^{(2)}(2^k) ≡ 4k (mod 8)`; and `sign u^{(2)}(2^k) ≡ 0 (mod 8)`. Nikulin Theorem
  1.11.3, that two finite quadratic forms with isometric bilinear forms are isometric
  exactly when their signatures agree mod 8, is the natural companion and is a milestone
  here.
- **Milgram's theorem** `t₊ − t₋ ≡ sign q_L (mod 8)` for even nondegenerate `L` (Nikulin
  Theorem 1.3.3), with the corollary that an even unimodular lattice has `8 ∣ t₊ − t₋`,
  since `A_L = 0`. This is Serre V.2 Theorem 2 Corollary 1; Serre's route through the
  `σ`-invariant (V.1.3.5) proves the corollary directly and is an equally good proof of it,
  but the discriminant-form statement is the one later layers use.
- **Level** as the exponent of the annihilator of `q_L` in the even case, agreeing with the
  `N·G⁻¹` characterization of the convention table, with `level ∣ 2·det` and the
  divisibility calculus that goes with it.

### Layer 2: positive definite lattices, reduction, and automorphisms

Everything in this layer is stated for positive definite `L` unless it says otherwise. A
negative definite lattice satisfies the corresponding statements for `−β`, and this layer
says so once rather than repeating each result twice.

- **Vectors of bounded norm.** For positive definite `L` the set `{x | β x x ≤ C}` is finite
  (realize in ℝⁿ and use `ZLattice` discreteness, or argue elementarily from the Gram
  bound). The **minimum** `min L` is the least value of `β x x` over *nonzero* `x`, defined
  for `rank L ≥ 1`; the norm-`k` **shells** `S_k(L) = {x | β x x = k}` are defined for every
  rank, including rank 0, where `S_0 = {0}` and the other shells are empty. The **kissing
  number** is `#S_{min L}(L)`, and `r_L(k) = #S_k(L)` are the theta coefficients of Layer 8.
- **Automorphism groups.** `O(L) = {e : L ≃ₗ[ℤ] L | e is an isometry}`, and `SO(L)` its
  subgroup of elements of determinant 1. For definite `L` (either sign), `O(L)` is **finite**:
  embed it into the permutations of a finite generating set of bounded-norm vectors, or use
  the discrete-and-compact picture in `O(n,ℝ)` from
  `TauCeti/LinearAlgebra/OrthogonalGroup.lean`. Also `O(L) × O(M) ≤ O(L ⊕ M)`, with the
  obstruction to equality identified. Definiteness is essential, and the indefinite side has
  to be stated correctly, since it is a favourite trap: `O(L)` is infinite for every
  indefinite nondegenerate `L` of rank at least 3, while in rank 2 it is infinite exactly in
  the anisotropic case, so that `O(U) ≅ (ℤ/2)²` is finite and `O(⟨1,−2⟩)` is infinite, being
  the units of `ℤ[√2]`. The rank-2 dichotomy is a required worked pair; the rank ≥ 3
  statement is proved in Layer 4. Together they are the reason Layer 7 restricts the mass to
  positive definite genera.
- **Covolume and Minkowski.** For positive definite `L` realized in Euclidean space,
  `covolume(L)² = det L` (`Suggested.lean` pins this, and it is where the `√det` bookkeeping
  is settled); Minkowski's convex-body bound `min L ≤ c_n (det L)^{1/n}`, consuming
  `GeometryOfNumbers` and `ZLattice.covolume`; and **Hermite's inequality**
  `min L ≤ (4/3)^{(n−1)/2} (det L)^{1/n}` by the classical induction, stated with the
  explicit constant in the style of `Completed/EffectiveBounds`, with `A₂` achieving
  equality in rank 2 as the worked example.
- **Successive minima.** `λ₁(L) ≤ … ≤ λₙ(L)`, defined from the Gram form, with a basis
  adapted to them; the vocabulary matches Mathlib PR #35812 so that its API can replace this
  development when it lands.
- **Reduction and finiteness.** Minkowski-reduced bases exist for positive definite
  lattices; a reduced Gram matrix of given rank and determinant has entries bounded
  explicitly in terms of `(n, det)`; hence there are **finitely many isometry classes of
  positive definite lattices of given rank and determinant** (`Suggested.lean` pins the
  `Finset` form). This is the definite half of class-number finiteness (O'Meara 103:4 is the
  classical umbrella) and the theorem the LMFDB's enumeration semantics rest on, so the
  bound is stated in the explicit form the enumeration needs.

### Layer 3: localizations, Jordan splittings, and the genus

Blocks on Layer 0, and for the rational shadow on the quadratic form invariants roadmap's
Layers 0–3; its dyadic statements consume that roadmap's Layer 6.

- **`ℤ_p`-lattices.** `L_p := ℤ_p ⊗ L` with `β_p = β.baseChange ℤ_[p]`, which is 2-free and
  therefore usable at `p = 2`; free finite `ℤ_p`-modules with symmetric forms; scale and
  norm ideals over `ℤ_p`; unimodular `ℤ_p`-lattices; and Layer 0's splitting calculus
  transported, where it strengthens because `ℤ_p` is local: a summand of maximal scale that
  is unimodular splits off.
- **Jordan splittings.** Every nondegenerate `ℤ_p`-lattice is an orthogonal sum
  `⊕_i p^i L_i` with each `L_i` unimodular (O'Meara §91C, by splitting off the maximal scale
  and inducting). For **odd `p`**: unimodular `ℤ_p`-lattices are diagonalizable and
  classified by rank together with the unit-determinant square class, so there are exactly
  two of each **positive** rank and one of rank 0 (O'Meara 92:1, 92:1a); the Jordan
  invariants are unique (91:9); and two lattices are isometric exactly when their Jordan
  data agree (92:2). The odd-`p` orthogonal-basis statement is pinned in `Suggested.lean`.
- **The dyadic case.** Over `ℤ_2` orthogonal bases do not exist in general (`U` is not
  diagonalizable, and `Suggested.lean` pins that counterexample), Jordan splittings are not
  unique, and the invariants are subtler: type I or II per constituent, the norm group and
  weight (O'Meara §93A) and the fundamental invariants of §93E. Build O'Meara's route in
  this order: the unimodular classification (93:16) first, then the general dyadic
  classification (93:28) and its 2-adic case (93:29). The **Conway–Sloane 2-adic symbol**
  (scale, rank, sign, type and oddity per constituent, with compartments and trains) is the
  interface format, and the theorem that two 2-adic symbols name isometric lattices exactly
  when they are related by sign walking and oddity fusion is stated and proved following
  Allcock–Gal–Mark (arXiv:1511.04614), including their correction to the SPLAG canonical
  form: the canonical 2-adic symbol built here is theirs.
- **The genus.** `gen L = gen M` when `L_p ≅ M_p` for every `p` and the real signatures
  agree (O'Meara §102A); the genus is determined by finitely many congruence conditions,
  namely equivalence over `ℤ/N` for a suitable `N`, in the effective form; the **genus
  symbol**, the concatenation of the `p`-adic symbols for `p ∣ 2·det`, determines the genus;
  and the well-formedness conditions on symbols, namely rank, determinant and oddity
  compatibilities together with the **oddity formula** and the sign-product conditions.
  Those last two are the symbol-level form of Hilbert reciprocity: they are proved here from
  the Hilbert product formula `∏_v (a,b)_v = 1` supplied by Global Class Field Theory Layer
  11, and the symbol-side verification is decidable.
- **The rational shadow.** Lattices in one genus have equivalent forms over ℚ and over every
  `ℚ_p`, in the invariant dictionary `(rank, d±, s_p, signature)` of the quadratic form
  invariants roadmap; conversely rational equivalence together with the integral local data
  assembles into membership in a genus. This is the seam with their Layer 6 and the only
  place the Hilbert-symbol machinery is touched.
- **What the LMFDB's lattice columns mean.** The section stores **positive definite**
  integral lattices, largely from the Catalogue of Lattices, with the label
  `dim.det.level.class_number.index`. The four kinds of data are different in nature and the
  roadmap keeps them apart:

  | Datum | Kind | Owned by |
  | --- | --- | --- |
  | `dim`, `det`, `level` | invariants of the lattice itself | Layers 0–1 |
  | `class_number` | an invariant of the genus, meaningful once the class set exists | Layer 4 |
  | Gram matrix, genus representatives, minimum, kissing number, `\|Aut\|`, density, Hermite invariant, theta coefficients | stored data, each the value of a predicate proved here | Layers 0, 2, 8 |
  | `index`, the fifth label component | a serial number separating records that agree in the first four, fixed by the database's insertion order | nobody: it has no intrinsic characterization and this roadmap gives it none |

  The genus data the LMFDB stores is a list of Gram matrices, one per class, not a
  Conway–Sloane symbol. Two statements make that list meaningful, and both are targets:
  that the listed matrices are pairwise non-isometric and lie in one genus (Layer 3), and
  that they exhaust the genus (Layer 4's class-number theorem, or Layer 7's mass
  certificate). The Conway–Sloane symbols are this roadmap's own genus interface, used for
  the mass formula and for the K3 pipeline's genus enumeration.

### Layer 4: lattice classes, spinor genera, Eichler, and neighbors

Blocks on Layers 2 and 3, and on the Orthogonal and Spin Groups roadmap through its
spinor-norm, adelic-points and strong-approximation layers. That roadmap owns the groups
and the approximation theorem; this layer owns their specialization to integral lattices.

**4A. Class sets and class numbers.** Isometry classes `cls L` and proper classes `cls⁺ L`
(isometries of determinant 1); the genus `gen L` and the proper genus; the inclusions
`cls ⊆ spn ⊆ gen`; the class number `h(L) = #{classes in gen L}` and its proper analogue.
Finiteness splits by signature and rank, and each case has its own proof:

- definite lattices of any rank: from Layer 2's reduction theory;
- indefinite of rank at least 3: from Eichler's theorem in 4D together with the finite
  spinor-genus count in 4C;
- indefinite of rank 2: a separate theorem, proved through the correspondence between
  binary quadratic forms of given discriminant and ideal classes of the associated
  quadratic order, so that finiteness comes from finiteness of the class number of the
  order (Cassels ch. 13 is the model; the Pell phenomenon that makes `O(L)` infinite here
  is exactly why the rank ≥ 3 argument does not apply);
- rank 0 and 1: directly.

One strong-approximation argument does not cover all indefinite ranks, and this roadmap
does not pretend otherwise.

**4B. Lattice stabilizers and the adelic dictionary.** For `V = ℚ ⊗ L`, define
`K_p(L) = {g ∈ O(V_p) : g L_p = L_p}` and `K_p⁺(L) = K_p(L) ∩ SO(V_p)`. Prove that each is
compact open in the local point group supplied by the sibling; that for all but finitely
many `p` it is the stabilizer of a unimodular `ℤ_p`-lattice, in the explicit form that
makes the restricted product well defined; and that the products `K_f(L)` and `K_f⁺(L)` are
compact open subgroups of the finite adelic groups. Then prove the two correspondences

    {classes in gen L}        ≃  O(V)(ℚ) \ O(V)(𝔸_f) / K_f(L),
    {proper classes in gen L} ≃  SO(V)(ℚ) \ SO(V)(𝔸_f) / K_f⁺(L),

with the maps written down in both directions. The groups and the restricted products come
from the sibling roadmap; the lattice interpretation is proved here.

**4C. Spinor genera.** The local spinor norm `θ_p : O(V_p) → ℚ_p^*/(ℚ_p^*)²` is the
sibling's; here we compute its image on the stabilizers, `θ_p(K_p⁺(L))`, from the Jordan
data of Layer 3, since those subgroups are what the spinor genus is made of. Define the
spinor genus `spn L` and the proper spinor genus `spn⁺ L` (O'Meara §102A), prove that the
local-spinor-norm definition agrees with the adelic double-coset definition, and prove the
count of proper spinor genera in a genus (O'Meara 102:7) as an explicit finite abelian
quotient: the idele class group of ℚ modulo the subgroup generated by the images
`θ_p(K_p⁺(L))`, the squares, and the image of `θ_∞`, with every one of those subgroups
named. "The idele-index count" is not an acceptable statement of this theorem.

**4D. Eichler's theorem.** Consuming the sibling's strong approximation for `Spin(V)` when
`V` is indefinite of dimension at least 3: every proper spinor genus of such a lattice
contains exactly one proper class, `cls⁺ L = spn⁺ L` (O'Meara 104:5); the passage from
proper to improper classes, which needs the analysis of when `O(L) ≠ SO(L)`; and the
consequences for class numbers, namely that indefinite class numbers of rank at least 3 are
bounded by the spinor-genus count of 4C, together with the criteria for a genus to have one
class. Hypotheses needed in small rank or special signature are stated separately rather
than folded into the main statement.

**4E. Kneser `p`-neighbors.** Integral lattices `L, M` on `V` are `p`-neighbors when
`[L : L ∩ M] = [M : L ∩ M] = p`. Targets: the definition and its symmetry; neighbors have
equal determinant, and for `p ∤ 2 det L` they lie in one genus; the construction of a
neighbor from an isotropic vector mod `p`; and checker theorems that verify an individual
edge. These justify individual neighbor steps and prove nothing about enumeration:
connectivity of the neighbor graph on a proper spinor genus, and transitivity of the
neighbor relation, are not claimed here, and no consumer may infer a complete list of
classes from neighbor traversal. Completeness comes from 4A's class-number theorems or from
Layer 7's mass certificate.

### Layer 5: discriminant forms and Nikulin's theory

Blocks on Layers 1 and 3. Citations are to Nikulin's paper (Izv. Akad. Nauk SSSR 43 (1979)
111–177; English translation Math. USSR-Izv. 14 (1980) 103–167), whose numbering matches in
both. His `E₈` is negative definite, so twists are written out. Throughout, `q` is a
nondegenerate finite quadratic form with group `A_q`, `l(A_q) = max_p l(A_{q_p})`, `K(q_p)`
is a `p`-adic lattice of rank `l(A_{q_p})` with discriminant form `q_p`, and `discr` is the
determinant square class in `ℤ_p^*/(ℤ_p^*)²`; the summands `q_θ^{(p)}(p^k)`, `u^{(2)}(2^k)`,
`v^{(2)}(2^k)` are the generators pinned in Layer 1.

- **Genus equals signature plus discriminant form.** For even lattices, `gen L` is
  determined by `(t₊, t₋, q_L)` (Nikulin Corollary 1.9.4, through the local uniqueness
  Theorem 1.9.1 with its one dyadic exception), and the odd analogue is Corollary 1.16.3.
  With it comes the translation between Layer 3's Conway–Sloane symbols and the
  `(t₊, t₋, q)` invariants, which is how the K3 pipeline's genus data and Nikulin's
  statements are compared; that translation is a named milestone, in both directions.
- **Existence (Theorem 1.10.1).** An even lattice with invariants `(t₊, t₋, q)` exists if
  and only if all of:
  1. `t₊ − t₋ ≡ sign q (mod 8)`;
  2. `t₊ ≥ 0`, `t₋ ≥ 0`, and `t₊ + t₋ ≥ l(A_q)`;
  3. `(−1)^{t₋} |A_q| ≡ discr K(q_p) (mod (ℤ_p^*)²)` for every odd prime `p` with
     `t₊ + t₋ = l(A_{q_p})`;
  4. `|A_q| ≡ ± discr K(q₂) (mod (ℤ_2^*)²)`, whenever `t₊ + t₋ = l(A_{q₂})` and `q₂` does
     not split off a summand `q_θ^{(2)}(2)`.

  Corollary 1.10.2 is the clean sufficient form: conditions 1 and 2 with the strict
  inequality `t₊ + t₋ > l(A_q)` suffice. Both the theorem and the corollary are targets;
  the corollary does not replace the theorem.
- **Uniqueness (Theorem 1.13.2).** An even lattice with invariants `(t₊, t₋, q)` is unique
  in its genus if all of:
  1. `t₊ ≥ 1`, `t₋ ≥ 1`, `t₊ + t₋ ≥ 3`;
  2. for every odd `p`, either `rank ≥ l(A_{q_p}) + 2`, or
     `q_p ≅ q_{θ₁}^{(p)}(p^k) ⊕ q_{θ₂}^{(p)}(p^k) ⊕ q'`;
  3. at `p = 2`, either `rank ≥ l(A_{q₂}) + 2`, or `q₂ ≅ u^{(2)}(2^k) ⊕ q'`, or
     `q₂ ≅ v^{(2)}(2^k) ⊕ q'`, or `q₂ ≅ q_{θ₁}^{(2)}(2^k) ⊕ q_{θ₂}^{(2)}(2^{k+1}) ⊕ q'`.

  With Corollary 1.10.2 this gives **Corollary 1.13.3**: an even lattice with invariants
  `(t₊, t₋, q)` exists and is unique when `t₊ − t₋ ≡ sign q (mod 8)`,
  `t₊ + t₋ ≥ l(A_q) + 2`, `t₊ ≥ 1` and `t₋ ≥ 1`. This is the workhorse of the whole layer.
- **Stabilization and splitting.** Corollary 1.13.4: if `T` is even with invariants
  `(t₊, t₋, q)`, then `U ⊕ T` is the unique even lattice with invariants
  `(t₊ + 1, t₋ + 1, q)`, and if `t₊ > 0` then `E₈(−1) ⊕ T` is the unique even lattice with
  invariants `(t₊, t₋ + 8, q)` (Nikulin writes `E₈` for our `E₈(−1)`; the mirror statement
  with our positive definite `E₈` needs `t₋ > 0`). Corollary 1.13.5: an even lattice `S` of
  signature `(t₊, t₋)` satisfies `S ≅ U ⊕ T` for some `T` when `t₊ ≥ 1`, `t₋ ≥ 1` and
  `t₊ + t₋ ≥ l(A_S) + 3`; and `S ≅ E₈(−1) ⊕ T` when `t₊ ≥ 1`, `t₋ ≥ 8` and
  `t₊ + t₋ ≥ l(A_S) + 9`.
- **Automorphisms and the discriminant form (Theorem 1.14.2).** Let `T` be an even
  indefinite lattice such that (a) `rank T ≥ l(A_{T_p}) + 2` for every odd `p`, and (b) if
  `rank T = l(A_{T₂})` then `q_{T₂} ≅ u^{(2)}(2) ⊕ q'` or `q_{T₂} ≅ v^{(2)}(2) ⊕ q'`. Then
  the genus of `T` has one class and `O(T) → O(q_T)` is **surjective**. Every K3 Torelli
  argument uses that surjectivity, so it is a first-class milestone rather than a remark;
  Proposition 1.14.1, which reduces the Witt-type statements to the triple (uniqueness of
  the complement, transitivity of `O(S) × O(K)` on isometries `q_S ≅ −q_K`, surjectivity of
  `O(K) → O(q_K)`), is proved with it.
- **Primitive embeddings.** The primitivity dictionary first: an injection of finite free
  ℤ-modules has torsion-free cokernel exactly when its image is a direct summand
  (`Suggested.lean`), and every statement below quantifies over primitive embeddings.
  Then:
  - **Existence in an even unimodular target (Theorem 1.12.2).** For an even lattice `S`
    with invariants `(t₊, t₋, q)` and integers `l₊, l₋`, the following are equivalent: `S`
    embeds primitively in some even unimodular lattice of signature `(l₊, l₋)`; an even
    lattice with invariants `(l₊ − t₊, l₋ − t₋, −q)` exists; and the four conditions
    `l₊ − l₋ ≡ 0 (mod 8)`; `l₊ − t₊ ≥ 0`, `l₋ − t₋ ≥ 0`, `l₊ + l₋ − t₊ − t₋ ≥ l(A_q)`;
    `(−1)^{l₊ − t₊} |A_q| ≡ discr K(q_p) (mod (ℤ_p^*)²)` for every odd `p` with
    `l₊ + l₋ − t₊ − t₋ = l(A_{q_p})`; and
    `|A_q| ≡ ± discr K(q₂) (mod (ℤ_2^*)²)` if `l₊ + l₋ − t₊ − t₋ = l(A_{q₂})` and `q₂` does
    not split off `q_θ^{(2)}(2)`. Corollary 1.12.3 is the sufficient form with
    `l₊ + l₋ − t₊ − t₋ > l(A_q)`, and Theorem 1.12.4 is the signature-only criterion: every
    even lattice of signature `(t₊, t₋)` embeds primitively into some even unimodular
    lattice of signature `(l₊, l₋)` exactly when the numerical conditions there hold.
  - **Uniqueness (Theorem 1.14.4).** A primitive embedding of an even lattice `M` of
    signature `(t₊, t₋)` into an even unimodular `L` of signature `(l₊, l₋)` is unique up to
    `O(L)` when `l₊ − t₊ > 0`, `l₋ − t₋ > 0`; `l₊ + l₋ − t₊ − t₋ ≥ l(A_{M_p}) + 2` for every
    odd `p`; and, if `l₊ + l₋ − t₊ − t₋ = l(A_{M₂})`, `q_M ≅ u^{(2)}(2) ⊕ q'` or
    `q_M ≅ v^{(2)}(2) ⊕ q'`.
  - **General even targets (Proposition 1.15.1).** Primitive embeddings of `S` into even
    lattices with invariants `(m₊, m₋, q)` correspond to tuples `(H_S, H_q, γ; K, γ_K)`
    where `H_S ≤ A_S` and `H_q ≤ A_q` are subgroups, `γ : q_S|H_S ≅ q|H_q` is an isometry,
    `K` is an even lattice with invariants `(m₊ − t₊, m₋ − t₋, −δ)` for
    `δ = (q_S ⊕ (−q))|Γ_γ^⊥ / Γ_γ` with `Γ_γ ⊆ A_S ⊕ A_q` the (isotropic) graph of `γ`, and
    `γ_K : q_K ≅ −δ` is an isometry; two tuples give isomorphic embeddings exactly when
    `H_S = H'_S` and there are `ξ ∈ O(q)` and an isometry `K ≅ K'` intertwining the data,
    and isomorphic primitive sublattices when `H_S` and `H'_S` are conjugate under `O(S)`
    instead. Under the correspondence, `K` is the orthogonal complement of `S`. Corollary
    1.15.2 is the genus-level version: the triple `(H_S, H_q, γ)` up to `O(q)` determines
    the genus of the embedding.
- **2-elementary lattices (Theorems 3.6.2 and 3.6.3).** `S` is 2-elementary when
  `A_S ≅ (ℤ/2)^a`, equivalently when `q_S` is an orthogonal sum of forms `q_θ^{(2)}(2)`,
  `u^{(2)}(2)`, `v^{(2)}(2)` (Proposition 1.8.1); `δ_S = 0` if `q_S` is a sum of
  `u^{(2)}(2)` and `v^{(2)}(2)` alone and `δ_S = 1` otherwise. Theorem 3.6.2: the genus of
  an even 2-elementary lattice is determined by `(δ_S; t₊, t₋, a)`, and if `t₊ > 0` and
  `t₋ > 0` those invariants determine the isometry class; such a lattice exists (with
  `δ_S ∈ {0,1}` and `a, t₊, t₋ ≥ 0`) if and only if
  1. `a ≤ t₊ + t₋`;
  2. `t₊ + t₋ + a ≡ 0 (mod 2)`;
  3. `t₊ − t₋ ≡ 0 (mod 4)` when `δ_S = 0`;
  4. `δ_S = 0` and `t₊ − t₋ ≡ 0 (mod 8)` when `a = 0`;
  5. `t₊ − t₋ ≡ ±1 (mod 8)` when `a = 1`;
  6. `δ_S = 0` when `a = 2` and `t₊ − t₋ ≡ 4 (mod 8)`;
  7. `t₊ − t₋ ≡ 0 (mod 8)` when `δ_S = 0` and `a = t₊ + t₋`.

  Theorem 3.6.3: for indefinite even 2-elementary `S`, `O(S) → O(q_S)` is surjective. For
  odd `p` there is **no** `p`-elementary theorem in Nikulin's paper: the classification
  follows from 1.13.2 and 1.13.3, or is cited to Rudakov–Shafarevich, and it is stated that
  way here rather than repeating the folklore attribution.
- **Acceptance instances for the K3 pipeline:** every even lattice of signature `(1, ρ−1)`
  with `ρ ≤ 10` embeds primitively into `Λ_{K3}` (an instance of 1.12.4), and for `d > 0`
  the rank-one lattice `⟨2d⟩` embeds primitively into `Λ_{K3}`, uniquely up to `O(Λ_{K3})`
  (an instance of 1.14.4): the normal form of a polarized K3.

### Layer 6: unimodular lattices in low rank

- **Indefinite classification** (from Layer 5): an even indefinite unimodular lattice is
  `U^{min(t₊,t₋)} ⊕ E₈(±1)^{|τ|/8}` and is determined by its signature (Corollary 1.13.3;
  classically Milnor, Serre V.2.2, Milnor–Husemoller II §5); an odd indefinite unimodular
  lattice is `⟨1⟩^{t₊} ⊕ ⟨−1⟩^{t₋}` (Serre V.2.2). Both are proved milestones, and
  `Suggested.lean` pins the even shape.
- **Existence bookkeeping:** an even unimodular definite lattice of rank `n` exists exactly
  when `8 ∣ n` (O'Meara 106:1, Layer 1's mod-8 theorem, and `E₈`).
- **Rank at most 9, definite:** a positive definite unimodular lattice of rank `≤ 9` is
  `Iₙ`, `E₈` or `E₈ ⊕ I₁` (O'Meara 106:13, whose §§105–106 route through the uniqueness of
  indecomposable splittings, 105:1, plus characteristic-vector counting, is the pinned proof
  plan). Corollary: `E₈` is the unique even unimodular lattice of rank 8 (Mordell). Serre
  §2.3 derives this uniqueness from the mass formula, which his chapter does not prove, so
  the route here is O'Meara's, which is mass-free; the root-system route (the minimal
  vectors of an even unimodular positive definite lattice of rank 8 form a root system of
  full rank, necessarily `E₈` by the ADE classification, consuming the [root systems
  roadmap](../RepresentationTheory/RootSystems/README.md)) is an equally good proof of the
  same statement, and whichever lands first discharges the milestone. Layer 7's mass
  computation then re-verifies it.
- **Rank 16:** `E₈²` and `D₁₆⁺`, the half-spinor glue of `D₁₆`, both exist, are even
  unimodular, and are not isometric, since their root systems differ; and they lie in one
  genus, by Layer 5's genus criterion. That there are no others is a **required
  classification theorem** (Witt), proved either by a complete neighbor argument or from
  Layer 7's mass certificate once every input to that certificate is proved. Layer 6 is
  unfinished until it is.
- **Rank 24, as reference data:** define the 24 Niemeier lattices by explicit Gram or glue
  data and prove for each row that it is even, unimodular, of rank 24, with the advertised
  root system, together with pairwise non-isometry wherever the checked invariants settle
  it. The name "Leech" denotes the designated rootless row. This layer does not assert that
  every rank-24 even unimodular lattice is one of these rows, nor that a rootless one is
  isometric to the Leech row; those are theorems nobody is asking for here. Coordinate with
  math-inc's hardcoded ℝ²⁴ development as a citation and a possible quarry, never as a
  silent migration.
- **Reconciliation with the sphere-packing `E₈`:** their `Submodule.E8`/`E8Lattice`, in the
  even-coordinate model, is isometric to our Gram-matrix `E₈`. Proving that once is a
  milestone, so that Lean has one `E₈` up to a proved isometry rather than two rival ones.
- **What is not claimed here:** `Θ_{E₈²} = Θ_{D₁₆⁺}` is not a milestone, since its usual
  proof runs through modular forms that no supplier roadmap provides. The classical equality
  is recorded as an application for a future roadmap, and it certifies nothing in this one.

### Layer 7: the Smith–Minkowski–Siegel mass formula

All statements are about positive definite genera. The Conway–Sloane mass paper (Proc. R.
Soc. Lond. A 419 (1988) 259–285) is the normalization of record. The proof route is pinned:
derive the mass from the adelic volume formula for `SO(V)`, consuming the canonically
normalized Tamagawa volume theorem from the Orthogonal and Spin Groups roadmap and
computing the compact-open stabilizer volumes from Layer 3's Jordan data. That theorem is
about the volume of `SO(V)(ℚ) \ SO(V)(𝔸)` and is not the strong approximation theorem of
Layer 4: strong approximation is an indefinite statement used for class numbers, the volume
theorem is what the positive definite mass formula needs, and neither implies the other.

**7A. Proper mass and full mass.** Define `m⁺(gen L) = ∑_{[M]⁺} 1/|SO(M)|` over proper
classes and `m(gen L) = ∑_{[M]} 1/|O(M)|` over classes; both are finite by Layers 2 and 4.
Prove the relation between them rather than assuming that every lattice has an
orientation-reversing automorphism: a full class either stays one proper class, in which
case `|O(M)| = 2|SO(M)|`, or splits into two, in which case `O(M) = SO(M)`, and the two
sums differ accordingly. State the rank hypotheses, and handle rank 0 separately. There is
no product formula for the mass of a direct sum, and that non-theorem is stated. The
behaviour of the mass under a twist `L(a)` needs `a > 0`, since a negative twist leaves the
positive definite category altogether.

**7B. The adelic decomposition.** Consuming `SO(V)(𝔸)`, its canonical product measure, the
diagonal `SO(V)(ℚ)`, and the volume theorem from the sibling, and using 4B's double-coset
dictionary, prove a disjoint measurable decomposition of `SO(V)(ℚ) \ SO(V)(𝔸)` indexed by
the proper classes in the genus, in which the class of `M` contributes

    vol(K_∞) / |SO(M)| · ∏_p vol(K_p⁺(M))

in the chosen normalization. Every quotient and stabilizer appearing here is named; nothing
jumps from a Tamagawa number directly to a sum over lattice classes.

**7C. Local densities and stabilizer volumes.** For each prime, define the local
representation and automorphism density in the normalization Conway–Sloane use, and prove:
normalized congruence counts modulo `p^r`; existence and stabilization of the limit;
invariance under change of integral basis; dependence only on the local isometry class; the
identification of the density with the canonical Haar volume of `K_p⁺(L)`; the standard
unramified factor for `p ∤ 2 det L`; the reduction of the infinite product to standard Euler
factors times finitely many corrections; and convergence of that product. For odd `p` the
formula is proved from Layer 3's Jordan decomposition. The dyadic prime is a separate
milestone with its own inputs: state the exact theorem of Cho (Compositio 151 (2015)) that
is used, construct the smoothened integral automorphism-group model it needs or name the
exact reusable theorem that supplies it, prove that Cho's normalization agrees with the
Conway–Sloane factor, and cover bound and free constituents together with the
dimension-zero edge convention. The Conway–Sloane dyadic tables are reference data, not
proofs.

**7D. The archimedean factor.** Define the real normalization and compute the volume of the
compact orthogonal group of a positive definite quadratic space, by identifying
`SO(n)/SO(n−1)` with the unit sphere, computing recursively from the known sphere volumes,
and deriving the Gamma-product factor; then prove compatibility with the global canonical
measure from the sibling. This is a concrete route, and it is preferable to making a general
theory of invariant differential forms an unstated prerequisite. The final statement
displays the archimedean factor explicitly, with every power of `π` and 2 accounted for.

**7E. The volume theorem, consumed.** `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` with the sibling's
rank hypotheses and normalization, recorded together with its low-dimensional exceptions.
Combined with 7B, 7C and 7D this gives the proper mass; 7A converts it to the full mass.

**7F. Low rank, directly.** Rank 0: `m = 1`. Rank 1: `m = 1/2` for the genus of a positive
rank-one lattice. Rank 2: a binary computation through the norm-one torus of the associated
quadratic order, with its own local and global normalization statement. Rank 2 is not a
specialization of the semisimple argument, and the general derivation starts in the rank
range where it is valid; the final theorem then packages all ranks with explicit branches.

**7G. The Conway–Sloane normalization and the acceptance suite.** Derive

    m(f) = 2 π^{−n(n+1)/4} ∏_{j=1}^{n} Γ(j/2) ∏_p 2 m_p(f)

with the dimension guard of the paper's §§3 and 6 and the direct low-rank values of 7F, and
prove the dictionary to Siegel's local-density notation `α_p` (paper §12, eq. (18)), listing
every normalization conversion. Only then run the acceptance instances: the rank-8 even
unimodular genus has `m = 1/696729600`, with class number 1 and
`|O(E₈)| = |W(E₈)| = 696729600` (the paper never prints this number; its §9(iv) delegates
unimodular masses to SPLAG ch. 16, and Serre §2.3 tabulates `M₈`); the determinant-3 rank-2
genus is represented by `A₂` and has class number 1; and in rank 16,
`1/|O(E₈²)| + 1/|O(D₁₆⁺)| = m₁₆`. That last equality certifies that no third class exists,
and so discharges Layer 6's completeness theorem, only after the global formula, every local
factor, and both automorphism orders have been proved. Before then it is data validation.

**Consequences.** Class-number lower bounds `h ≥ m·min|O|`; the growth of class numbers
with rank (Serre §2.3's remark on `n = 32`); and the completeness certificates the LMFDB and
K3 genus enumerations use, `∑ 1/|O| = m` certifying that a list of classes is complete,
which is the practical reason this layer exists.

### Layer 8: arithmetic theta series

- **Two levels of theta, and how they fit together.** The analytic theta of LFunctions Layer
  2 takes a `ZLattice` in a finite-dimensional real inner-product space together with a
  positive definite real quadratic form, and assumes nothing about integrality. The
  arithmetic theta of this layer is a wrapper: realize a positive definite `(L, β)` as such
  a lattice, define `Θ_L` as the analytic theta of that realization, and prove that the
  definition does not depend on the realization. The dual lattice `L^⋆` carries the
  rationally extended form, which is rational-valued rather than integral, so `Θ_{L^⋆}` is
  an instance of the *analytic* theta and not of the arithmetic one. Keeping the two levels
  apart is what makes the transformation law below type-correct.
- **Definition, convergence, first properties.** `Θ_L : ℍ → ℂ`,
  `Θ_L(τ) = ∑_{x ∈ L} exp(πiτ·β(x,x))` for positive definite `L`, with absolute and locally
  uniform convergence (the `Summable` target in `Suggested.lean`, consuming
  `ZLattice/Summable` and Layer 2's finite shells); the q-expansion
  `Θ_L = ∑_k r_L(k) q^k` in `q = e^{πiτ}` with `r_L(k)` the shell counts of Layer 2;
  `Θ_{L⊕M} = Θ_L·Θ_M`; `Θ_{L(a)}(τ) = Θ_L(aτ)` for `a > 0`, the positivity being needed for
  both sides to be theta series of positive definite lattices; `Θ_ℤ = jacobiTheta`, which is
  the rank-one reconciliation with Mathlib; and `Θ_{Iₙ} = jacobiTheta^n`.
- **The arithmetic content of the transformation law.** Consume LFunctions Layer 2's
  Gaussian theta transformation `Θ_L(1/t) = t^{n/2} covol(L)⁻¹ Θ_{Lᵛ}(t)` for real `t > 0`,
  and prove here: that their analytic dual `Lᵛ` of the realization is the image of Layer 1's
  `B.dualSubmodule L`, so the two notions of dual lattice agree; that
  `covol(L) = Real.sqrt (det L)` for positive definite `L`, which is Layer 2's covolume
  identity; and the extension from real `t > 0` to `τ ∈ ℍ` by analytic continuation, both
  sides being holomorphic on the upper half-plane and agreeing on the positive imaginary
  axis. The conclusion is

      Θ_L(−1/τ) = (τ/i)^{n/2} (det L)^{−1/2} Θ_{L^⋆}(τ),

  with `(τ/i)^{n/2}` the principal branch of `Complex.cpow` (legitimate because `τ/i` has
  positive real part on `ℍ`) and `(det L)^{−1/2}` the positive real square root. For
  unimodular `L`, where `L^⋆ = L` and `det L = 1`, this specializes to
  `Θ_L(−1/τ) = (τ/i)^{n/2} Θ_L(τ)`. The general analytic theorem is consumed, not reproved;
  the dual and determinant identifications and this specialization are the theorems owned
  here.
- **Where this stops.** No supplier proves that `Θ_L` is a modular form on `Γ₀(level L)`
  with its quadratic character, so neither that statement nor `Θ_{E₈} = E₄` nor
  `Θ_{E₈²} = Θ_{D₁₆⁺}` is a target. The shell count `r_{E₈}(2) = 240` is a Layer-2 target
  and is independent of any modularity. Siegel–Weil and Epstein zeta functions through the
  Mellin transform are named here as the directions this material feeds, and they belong to
  a later roadmap, not to this one.

---

## Worked examples (acceptance criteria)

Discharge these alongside their layers. Each one catches a vacuous definition, a wrong
factor of 2, or a sign error.

- `⟨1⟩ = ℤ`: odd, unimodular, `Θ_ℤ = jacobiTheta` (Layers 0, 8).
- `U`: even, `det = −1`, signature `(1,1)`, level 1, `A_U = 0`, and not diagonalizable over
  `ℤ_2` (Layers 0, 3).
- `A₂`: even, `det = 3`, level 3, `A_{A₂} ≅ ℤ/3` with `q = 2/3 ∈ ℚ/2ℤ` (the acceptance
  check for the sign and the `2ℤ` convention); the 3-adic Jordan splitting with scale-1 and
  scale-3 constituents of rank 1; equality in Hermite's bound,
  `min = (4/3)^{1/2}(det)^{1/2}`; class number 1 in its genus (Layers 0–3, 7).
- The `Aₙ` family: `det(Aₙ) = n+1` from `CartanMatrix.A`, and `A_{Aₙ} ≅ ℤ/(n+1)`
  (Layers 0–1).
- `E₈`: even, unimodular, positive definite, `min = 2` with 240 minimal vectors, signature
  `(8,0)`, `sign q_{E₈} = 0`; unique in rank 8; `|O(E₈)| = 696729600`; the mass of its genus
  is `1/696729600`; isometric to the sphere-packing project's `E8Lattice` (Layers 0–2, 6–8).
- Even unimodular implies `8 ∣ t₊ − t₋`, and there is no even unimodular definite lattice of
  rank 1 to 7 (Layer 1).
- Rank 16: `E₈²` and `D₁₆⁺` lie in one genus, are not isometric, and exhaust the genus by
  Layer 6's classification theorem or its Layer-7 mass certificate.
- `Λ_{K3} = U³ ⊕ E₈(−1)²`: even, unimodular, signature `(3,19)`, `det = −1`; the unique even
  unimodular lattice of that signature; for `d > 0`, `⟨2d⟩` embeds primitively and uniquely
  up to `O(Λ_{K3})`; every even lattice of signature `(1, ρ−1)` with `ρ ≤ 10` embeds
  primitively (Layers 5–6, the K3 acceptance suite).
- An LMFDB record checked end to end: for `A₂` and for one rank-4 lattice with a nontrivial
  2-adic symbol, the label components `dim`, `det`, `level`, the stored minimum, kissing
  number and automorphism order, and the Conway–Sloane genus symbol computed here all agree
  with the database (Layers 0–3).
- Mass conventions: `m(rank 0) = 1` and `m(genus of ⟨a⟩) = 1/2` in rank 1, the
  low-dimensional guard of the Conway–Sloane normalization, checked explicitly (Layer 7).

## Ordering and parallelism

Layer 0 comes first and everything rests on it. After it, three developments are
independent: Layer 2 (reduction, finiteness and `O(L)` for positive definite lattices,
which needs no dual lattices), Layer 1 (duals, `A_L`, finite quadratic forms, the Gauss-sum
invariant and Milgram), and Layer 3's local theory (`ℤ_p`-lattices and odd-`p` Jordan
splittings). Layer 3's genus assembly consumes the quadratic form invariants roadmap's
Layers 0–3 and 6 and the Hilbert product formula of Global CFT Layer 11, so the genus
material depends on siblings while the two lattice-side developments do not. Layer 4
consumes Layers 2 and 3 and the Orthogonal and Spin Groups roadmap; Layer 5 consumes Layers
1 and 3; Layer 6 consumes Layers 1, 2, 5 and the root systems roadmap; Layer 7 consumes
Layers 2 to 4, the sibling's volume theorem, and Layer 6 for its acceptance suite; Layer 8's
definition and convergence need only Layers 0 to 2, while its transformation law consumes
LFunctions Layer 2.

The Nikulin layer is the K3 pipeline's critical path: `0 → 1 → 5`, together with the
`3 → 5` genus comparison, is the shortest route to the embedding theorems, and it avoids
Layers 2, 4 and 6 to 8 entirely.

## References

- J. H. Conway, N. J. A. Sloane, *Low-dimensional lattices. IV. The mass formula*, Proc. R.
  Soc. Lond. A 419 (1988) 259–285. Primary for Layer 7: eq. (1) the mass, eqs. (2)–(3) the
  formula, §5 the species and octane tables, eqs. (6)–(9), (13), (15)–(16) the standard
  mass, §§3 and 6 the guard in dimension `≤ 1`, §12 the Siegel-density dictionary. No
  erratum exists, but the `p = 2` factor is unproved there (see Cho) and the 2-adic
  canonical form of SPLAG ch. 15 contains an error corrected by Allcock–Gal–Mark.
- S. Cho, *Group schemes and local densities of quadratic lattices in residue characteristic
  2*, Compositio Math. 151 (2015) 793–827. The first proof of the Conway–Sloane `p = 2`
  local-density formula; the citation for 7C's dyadic milestone.
- D. Allcock, I. Gal, A. Mark, *The Conway–Sloane calculus for 2-adic lattices*,
  arXiv:1511.04614. The proof of the 2-adic symbol calculus (sign walking, oddity fusion)
  and the corrected canonical form; Layer 3's dyadic source of record.
- V. V. Nikulin, *Integer symmetric bilinear forms and some of their geometric
  applications*, Izv. Akad. Nauk SSSR 43 (1979) 111–177; translation Math. USSR-Izv. 14
  (1980) 103–167. Primary for Layers 1 and 5 (the Russian original is in `references/`;
  numbering matches the translation): §1 point 3° discriminant forms; Thm 1.3.3 signature
  mod 8; Prop 1.8.1 the generators and Prop 1.8.2 the relations among them; Cor 1.9.4 the
  genus; Thm 1.10.1 and Cor 1.10.2 existence; Prop 1.11.2 generator signatures and Thm
  1.11.3 the mod-8 invariant; Thm 1.12.2, Cor 1.12.3 and Thm 1.12.4 embeddings into
  unimodular lattices; Thm 1.13.1–1.13.2 and Cor 1.13.3–1.13.5 uniqueness, stabilization and
  splitting; Prop 1.14.1 and Thm 1.14.2 the map `O(L) → O(q_L)`; Thm 1.14.4 uniqueness of
  primitive embeddings; Prop 1.15.1 and Cor 1.15.2 embeddings into general even lattices;
  Thm 3.6.2–3.6.3 the 2-elementary classification.
- O. T. O'Meara, *Introduction to Quadratic Forms*, Grundlehren 117, Springer (1963;
  corrected 1973). Primary for Layers 0, 3, 4 and 6: §82E scale, norm and volume; §91C
  Jordan splittings with 91:9 the invariants; 92:1–92:2 the non-dyadic classification;
  §93A and §93E the dyadic invariants with 93:16, 93:28 and 93:29; §102A the definitions of
  genus and spinor genus with 102:7 the spinor count; 103:4 class-number finiteness; 104:5
  Eichler's theorem; 105:1 indecomposable splittings; 106:1 and 106:13 the unimodular
  classification in rank `≤ 9`. (104:4, strong approximation for the spin group, is the
  Orthogonal and Spin Groups roadmap's, not this one's.)
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter V. Layers 1, 6 and
  7: V.1.3.5 the `σ`-invariant; V.1.4.3 the `Γₙ` construction with `E₈`'s 240 roots and its
  Gram matrix; V.2 Theorem 2 with Corollary 1 (signature mod 8); V.2.2 the indefinite
  structure theorems; V.2.3 the mass formula with `M₈`, `M₁₆`, `M₂₄` and the Mordell and
  Witt attributions. His `E₈` uniqueness is derived from a mass formula the chapter does not
  prove; see Layer 6.
- J. Milnor, D. Husemoller, *Symmetric Bilinear Forms*, Ergebnisse 73, Springer (1973).
  Layers 1 and 6: Chapter II the indefinite unimodular classification, Appendix 4 Milgram's
  formula and van der Blij's lemma.
- J. H. Conway, N. J. A. Sloane, *Sphere Packings, Lattices and Groups*, 3rd ed.,
  Grundlehren 290, Springer (1999). Chapters 2 (theta series), 4 (root lattices and the
  `Dₙ⁺` constructions), 15 (genus symbols, with the Allcock–Gal–Mark correction), 16 (the
  unimodular masses the mass paper delegates to), 17–18 (Niemeier), 26–27 (Leech).
- J. W. S. Cassels, *Rational Quadratic Forms*, Academic Press (1978). Chapters 8–9
  (integral forms over `ℤ_p` and ℤ, the genus), 10–11 (spinor genus and class numbers), and
  ch. 13 for the binary theory that 4A's rank-2 finiteness runs on.
- W. Ebeling, *Lattices and Codes*, 3rd ed., Springer (2013). Layers 1 and 6: discriminant
  forms, the even unimodular classification in rank `≤ 24`, Niemeier lattices through glue
  codes.
- Y. Kitaoka, *Arithmetic of Quadratic Forms*, Cambridge Tracts 106, CUP (1993). Layers 3, 7
  and 8: the arithmetic theory with the Minkowski–Siegel apparatus and theta background.
- M. Kneser, *Quadratische Formen* (revised with R. Scharlau), Springer (2002). Layers 4 and
  6: neighbors, class numbers, and the neighbor-method classifications.
- J. Voight, *Kneser's method of neighbors* (survey, arXiv:2308.11566). Layer 4's modern
  algorithmic reference.
- G. Chenevier, J. Lannes, *Automorphic Forms and Even Unimodular Lattices*, Ergebnisse 69,
  Springer (2019). Background for Layers 6 and 8: Niemeier lattices, neighbors, and the
  theta and automorphic dictionaries.
- T. Kirschmer, *Definite quadratic and hermitian forms with small class number*,
  Habilitation, RWTH Aachen (2016). The computational one-class and mass tables that the
  LMFDB-facing enumeration is validated against. Free online.

## Provenance and coordination

The status below was checked on 2026-08-06. No outreach has been made, so "not contacted"
is a fact about the world, not a plan, and proposed ownership becomes agreed ownership only
once the named coordination has happened.

- **thefundamentaltheor3m/Sphere-Packing-Lean** (Birkbeck, Hariharan, Mehta, Lee and
  contributors). Revision `bad3de916074748eb88b7d1ee6dbf9494361ad17` (2026-08-05); the
  Poisson pull request #341 is open at `a6042330f897685ee6cd6d7a01e36e2460d60b18`. Licence
  Apache-2.0. Overlap: an explicit `E₈`, the `ZLattice` Poisson statement, and analytic
  theta machinery. Not contacted. Proposed split: their analytic `E₈` model stays theirs,
  LFunctions Layer 2 owns the shared Poisson and theta transformation, and this roadmap owns
  arithmetic invariants and the proved isometry between the two `E₈` models. Plan: cite,
  seek one shared declaration, and copy neither the Gauss proof nor the `E₈` code without
  the authors' agreement. Revisit when #341 lands or when the maintainers choose a different
  home for the shared statement.
- **math-inc/Sphere-Packing-Lean** (Gauss output and contributors). Revision
  `1e98fb493088948ca7bbf47d7faed49cc5b39fc4` (2026-03-02). Licence Apache-2.0. Overlap:
  hardcoded dimension-24 Leech and Niemeier data with theta checks. Not contacted. This
  roadmap claims only the checked invariants of its own rank-24 reference rows, not
  completeness or rootless uniqueness. Plan: cite as prior art and a possible quarry; any
  migration needs the authors' agreement and a recorded port plan.
- **Mathlib**, pin `9caeba1000ef8f302920981f4a08651d325abc81`. Licence Apache-2.0. The open
  pull requests that touch this roadmap's surface are listed under "What is already in
  motion elsewhere": #35812 (successive minima and a directional basis, overlapping Layer
  2), #41867 (the `ZLattice` refactor), #42157 (E-type Cartan matrices), #38194 (naming
  territory for indefinite forms), and the drafts #39460 and #10345. Mathlib owns its API
  decisions; this roadmap names things the way those PRs do so that adopting them later is
  an import, and it never waits for them.
- **Sibling roadmaps.** The [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4) owns everything over fields
  and its convention table is adopted here wholesale, including the Lam/Serre Hasse
  invariant with quaternion-class values, the `discr` versus `signedDiscr` distinction, the
  `IsSquare (a*b)` square-class idiom, and the standing `[Invertible (2 : K)]` hypothesis,
  which never crosses to the ℤ side. The Orthogonal and Spin Groups roadmap owns the group
  theory of Layers 4 and 7, [Global Class Field
  Theory](https://github.com/roed-math/TauCetiRoadmap/pull/6) Layer 11 supplies the Hilbert
  product formula, [LFunctions](https://github.com/roed-math/TauCetiRoadmap/pull/8) Layer 2
  supplies Poisson summation and the Gaussian theta transformation, the [local fields
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2) owns local-field structure
  theory, the [root systems roadmap](../RepresentationTheory/RootSystems/README.md) owns
  root-system combinatorics, and `Completed/EffectiveBounds` supplied the counting results
  Layer 2 uses. Modular-form packaging has no supplier and is outside this roadmap.
- **LMFDB and the K3 pipeline** are the demand side. The LMFDB lattice section stores Gram
  matrices, determinants, levels, class numbers, minima, kissing numbers, automorphism
  orders, theta coefficients and genus representatives, and Layer 3 says what each of those
  columns asserts; the K3 work consumes Layer 5's embedding criteria and `O(L) → O(q_L)`,
  Layer 4's neighbor checkers, and Layer 7's mass certificates. They motivated the layer
  boundaries and impose no conventions beyond the Conway–Sloane symbols already pinned.
- **Classification claims, and what backs each one.** Rank `≤ 9` unimodular is proved by
  O'Meara's route; rank-16 completeness is a required theorem, with the mass certificate one
  permitted proof; rank 24 is reference data with proved row invariants and no completeness
  claim; the 24 Niemeier rows and the Leech row are named, not classified. Nothing in this
  roadmap treats a numerical check as a proof of completeness.
