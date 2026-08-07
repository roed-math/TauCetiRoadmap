# Roadmap: integral quadratic forms and lattices

Mathlib has the material a lattice is made of. It does not have the arithmetic of
lattices. This roadmap builds that arithmetic over `ℤ` and `ℤ_p`.

Mathlib supplies:

- quadratic maps over a commutative semiring, with the polar and companion calculus, which
  works over `ℤ`;
- symmetric bilinear forms, their Gram matrices, and a base change that does not invert 2;
- Smith normal form over a principal ideal domain, with the theorem that the index of a
  full-rank submodule is the absolute value of a determinant;
- the dual submodule of a bilinear form, whose own file asks for the lattice theory below;
- lattices in real vector spaces, with covolume and lattice-point counts;
- root systems and the Cartan matrices, including `CartanMatrix.E₈`;
- Jacobi theta functions with their transformation laws.

Mathlib supplies none of the following, and no other Lean library supplies them either:

- even and odd lattices, and unimodular lattices;
- discriminant groups and discriminant forms;
- Jordan splittings, the genus, and Conway–Sloane genus symbols;
- class numbers and spinor genera;
- the mass formula;
- Nikulin's existence, uniqueness and embedding theory;
- the theta series of a lattice.

The principal results of this roadmap are:

1. the classification of even unimodular lattices in low rank;
2. the Smith–Minkowski–Siegel mass formula in the Conway–Sloane normalization;
3. Nikulin's theory of existence, uniqueness and primitive embeddings for even lattices.

Two projects consume the results. The LMFDB lattice section stores positive definite
integral lattices with their genus representatives. The K3 surface pipeline enumerates
genera and applies Nikulin's embedding criteria.

Suggested homes, which follow Mathlib's directory conventions:

- `TauCeti/LinearAlgebra/QuadraticForm/IntegralLattice/` for Layers 0 to 2. These layers
  hold the lattice structure, the bilinear and quadratic dictionary, dual lattices,
  discriminant groups, finite quadratic forms, reduction theory, and automorphism groups.
- `TauCeti/NumberTheory/IntegralLattice/` for Layers 3 to 8. These layers hold
  localizations, Jordan theory, the genus and its symbols, class numbers, spinor genera,
  Nikulin's theory, the unimodular classification, the mass formula, and theta series.

`PROVENANCE.md` records the Mathlib version this roadmap was checked against, the external
work that overlaps it, and the data model of the LMFDB lattice section. That file is not
part of the specification, and nothing in it is a prerequisite for a milestone.

## Scope

In scope: the arithmetic of integral lattices over `ℤ` and `ℤ_p`, as listed in the layers
below.

Out of scope, with the owner of each subject:

| Subject | Owner |
| --- | --- |
| square classes, Witt theory, Hasse invariants, the Hilbert symbol, classification of forms over a field | [Quadratic Form Invariants](https://github.com/roed-math/TauCetiRoadmap/pull/4) |
| `O(Q)` and `SO(Q)` over a field, Cartan–Dieudonné, the spinor norm, `Pin` and `Spin`, local point groups, adelic points, strong approximation, the Tamagawa volume of `SO` | Orthogonal and Spin Groups |
| structure theory of local fields | [Local Fields](https://github.com/roed-math/TauCetiRoadmap/pull/2) |
| root systems, Weyl groups, `DynkinType`, the ADE classification | [Root Systems](../RepresentationTheory/RootSystems/README.md) |
| Poisson summation and the Gaussian theta transformation for a lattice in a real vector space | [L-functions](https://github.com/roed-math/TauCetiRoadmap/pull/8) |
| modular forms of integral weight, Hecke theory, newforms | [Modular Forms](../ModularForms/README.md) |

The following subjects have no owner and are not part of this roadmap. They are listed so
that a reader can see the boundary.

- Modularity of theta series. No roadmap proves that the theta series of an even lattice
  is a modular form, and half-integral weight is developed nowhere. Layer 8 therefore
  stops after the transformation law.
- The analytic proof of the mass formula, which uses Siegel Eisenstein series, the Weil
  representation and Siegel–Weil. Layer 7 uses the adelic volume of `SO(V)` instead.
- Tamagawa measure theory for a general reductive group.
- Lattices over the ring of integers of a number field. Every statement here is over `ℤ`
  or `ℤ_p`.
- Lattice reduction algorithms beyond the bounds that finiteness needs.
- Automorphism groups of indefinite lattices, and Borcherds' method.
- Sphere packing optimality, and constructions of lattices from codes.

## How to read a milestone

Each layer states its milestones with a label, such as `3E`. Other roadmaps and the tables
below cite these labels. Each layer ends with a table of direct prerequisites. Every
prerequisite has one of four kinds:

- **M**: a declaration that exists in Mathlib.
- **T**: a declaration that exists in Tau Ceti.
- **L**: an earlier milestone of this roadmap.
- **R**: a named layer of another roadmap.

No prerequisite has any other kind. A Mathlib pull request, an external repository, a
branch, and a future Mathlib version are all excluded. `PROVENANCE.md` records such
information, and no milestone depends on it.

## Conventions

These decisions hold in every layer.

**The lattice.** A lattice is a finite free `ℤ`-module with a symmetric integral bilinear
form. The module hypotheses stay as typeclasses. The form and its symmetry are bundled:

```lean
structure IntegralLatticeForm (L : Type u) [AddCommGroup L] [Module ℤ L] where
  form : LinearMap.BilinForm ℤ L
  isSymm : form.IsSymm
```

`IntegralLatticeForm` is a structure and not a class, because one module carries many
forms. `[Module.Free ℤ L]` and `[Module.Finite ℤ L]` appear on the declarations that need
them. The prose writes `β` for the form and `L` for the lattice. The rank is
`Module.finrank ℤ L`. A statement assumes `β.Nondegenerate` only where that hypothesis is
needed.

**The bilinear form is the primary datum.** The norm of `x` is `β x x`. The roadmap never
halves a norm without saying so. `L` is even when `2 ∣ β x x` for every `x`, and odd
otherwise. An even symmetric `β` is `Q.polarBilin` for a unique `Q : QuadraticForm ℤ L`
with `Q x = β x x / 2`. Milestone 0B proves this correspondence in both directions.

**Do not use the associated bilinear form over `ℤ`.** `QuadraticMap.associated` requires
`[Invertible (2 : Module.End R N)]`, which fails for `R = N = ℤ`.
`QuadraticForm.toMatrix`, `QuadraticForm.discr` and `QuadraticForm.baseChange` require
`[Invertible (2 : R)]`, which fails for `R = ℤ`. The polar and companion calculus and the
bilinear Gram and base-change API have no such hypothesis. This is why the roadmap states
everything through the bilinear form.

**Determinant.** The Gram matrix of `β` in a basis `b` is
`LinearMap.BilinForm.toMatrix b β`. A change of basis over `ℤ` has determinant `±1`. Gram
determinants are therefore equal, and not merely equal up to squares, so `det L : ℤ` is an
invariant. The word discriminant is reserved for the discriminant group `A_L` and the
discriminant form `q_L`.

**Signature.** `(t₊, t₋)` is `(sigPos, sigNeg)` of the real form. At the Mathlib version
recorded in `PROVENANCE.md` these two declarations are in the root namespace, although
their file documents them as `QuadraticForm.sigPos`. The signature index is
`τ(L) = t₊ − t₋`.

**Definiteness.** `PosDef` is `QuadraticMap.PosDef` of
`LinearMap.BilinMap.toQuadraticMap β`. `NegDef L` means `PosDef (L(−1))`. Definite means
positive definite or negative definite. Indefinite means `t₊ > 0` and `t₋ > 0` under
nondegeneracy.

**Positive definite, not definite.** Sets of bounded norm, minima, shells, reduction theory
and theta series are stated for positive definite lattices. For a negative definite form
the set `{x | β x x ≤ C}` is infinite, and the theta series diverges. A statement that is
invariant under `β ⇝ −β`, such as finiteness of the automorphism group, is proved for
positive definite lattices and then extended by that substitution.

**Twists and sums.** `L(a)` is the module `L` with the form `a • β`, so `E₈(−1)` is
negative definite. A statement about `L(a)` assumes `a ≠ 0`. A statement that must stay in
the positive definite theory assumes `a > 0`. The orthogonal direct sum `L ⊕ M` carries the
sum of the two forms, and its Gram matrix is the block sum. Isometry is
`LinearMap.BilinForm.Equivalent`. A class is an isometry class over `ℤ`.

**Rational ambient space and quotient types.** The ambient space is `V = ℚ ⊗ L` with
`B = β.baseChange ℚ`. The two quotient groups are `ℚ/ℤ = AddCircle (1 : ℚ)` and
`ℚ/2ℤ = AddCircle (2 : ℚ)`. The halving map `[r] mod 2ℤ ↦ [r/2] mod ℤ` is
`AddCircle.equivAddCircle (2 : ℚ) (1 : ℚ)`, and `AddCircle.equivAddCircle_apply_mk`
evaluates it. The halving map is the only place where this factor of 2 appears.

**Dual lattice.** The dual lattice is `L^⋆ = LinearMap.BilinForm.dualSubmodule B L`.
Integrality of `β` is the statement `L ≤ L^⋆`. The discriminant group is `A_L = L^⋆/L`.

**Discriminant forms.** The discriminant bilinear form is `b_L : A_L × A_L → ℚ/ℤ`,
`b_L(x̄, ȳ) = B(x, y) mod ℤ`. For even `L` the discriminant quadratic form is
`q_L : A_L → ℚ/2ℤ`, `q_L(x̄) = B(x, x) mod 2ℤ`. The target `ℚ/2ℤ` is Nikulin's convention.
A source that values `q` in `ℚ/ℤ` differs from this one by the halving map. An odd lattice
carries `b_L` only.

**Two invariants with different names.** The Gauss-sum invariant `sign q ∈ ℤ/8` of a
nondegenerate finite quadratic form is defined by
`∑_{a ∈ A} e^{πi q(a)} = √#A · e^{2πi·sign(q)/8}`. It is a statement about finite quadratic
forms, and milestone 1H proves it. Milgram's theorem is the different statement that
`t₊ − t₋ ≡ sign q_L (mod 8)` for an even lattice, and milestone 1I proves it. The roadmap
does not use one name for both.

**Scale, norm ideal, level.** `𝔰(L)` is the ideal generated by the values `β x y`, and
`𝔫(L)` is the ideal generated by the values `β x x`. Then `2𝔰 ⊆ 𝔫 ⊆ 𝔰`, and `L` is even
exactly when `𝔫 ⊆ 2ℤ`. The level of a nondegenerate integral `L` is the least `N > 0` such
that `N·G⁻¹` is integral with even diagonal, for a Gram matrix `G`. For even `L` the level
is the least `N` with `N·q_L = 0`.

**Genus symbols.** The symbols are those of Conway–Sloane, SPLAG Chapter 15, in the
terminology of their mass formula paper. A symbol records the Jordan constituents at each
scale `p^i`, their ranks, and their signs `ε = (det f_q | p)`. At `p = 2` it also records
the type, which is I for odd and II for even, and the oddity, which is the trace mod 8.
Dyadic Jordan splittings are not unique, and the resulting moves on symbols are sign
walking and oddity fusion. The canonical 2-adic symbol is the corrected one of
Allcock–Gal–Mark, and not the one printed in SPLAG.

**Nikulin's notation.** `l(A)` is the least number of generators of a finite abelian group
`A`, and `l(A_q) = max_p l(A_{q_p})`. `K(q_p)` is a `p`-adic lattice of rank `l(A_{q_p})`
whose discriminant form is `q_p`, and `discr K(q_p)` is its determinant square class in
`ℤ_p^*/(ℤ_p^*)²`. The generating finite quadratic forms are `q_θ^{(p)}(p^k)` on `ℤ/p^k`,
and `u^{(2)}(2^k)` and `v^{(2)}(2^k)` on `(ℤ/2^k)²`. They are the discriminant forms of the
`p`-adic lattices with Gram matrices `(θ p^k)`, `2^k·!![0,1;1,0]` and `2^k·!![2,1;1,2]`.
Nikulin's `E₈` is negative definite, and this roadmap's `E₈` is positive definite, so a
citation from his paper carries the twist `E₈(−1)`. The K3 lattice is
`Λ_{K3} = U³ ⊕ E₈(−1)²`, which is even unimodular of signature `(3,19)`.

**Theta series.** For positive definite `L`, `Θ_L(τ) = ∑_{x ∈ L} exp(πiτ·β(x,x))` on the
upper half-plane. The nome is `q = e^{πiτ}`, which makes `Θ_ℤ` equal to Mathlib's
`jacobiTheta`. For even `L` the same series has nome `e^{2πiτ}` and exponents the
half-norms. In the transformation law `(τ/i)^{n/2}` means `Complex.cpow (τ/i) (n/2)` for the
principal branch. That branch is correct because `τ/i` has positive real part when `τ` is
in the upper half-plane. The determinant factor is the positive real square root
`Real.sqrt (det L)`, which exists because a positive definite lattice has `det L > 0`.

**Mass.** For a genus `G` of positive definite lattices, the full mass is
`m(G) = ∑_{cls L ∈ G} 1/|O(L)|`, and the proper mass is
`m⁺(G) = ∑_{cls⁺ L ∈ G} 1/|SO(L)|`. The normalization is that of Conway–Sloane, equation
(1) of their mass formula paper. Their sections 3 and 6 record that the formula, as usually
stated, is false in dimension at most 1, where a factor 2 becomes 1. The low rank values
are part of the statement of milestone 7H.

## What Mathlib supplies

Each row is consumed by the milestones in the last column. `PROVENANCE.md` records the
Mathlib version and the check.

| Declarations | File | Consumed by |
| --- | --- | --- |
| `QuadraticMap`, `exists_companion'`, `polar`, `polarBilin`, `ofPolar`, `LinearMap.BilinMap.toQuadraticMap`, `polar_self`, `two_nsmul_associated`, `QuadraticMap.PosDef`, `Matrix.toQuadraticForm'` | `Mathlib/LinearAlgebra/QuadraticForm/Basic.lean` | 0A, 0B, 0E, 2A |
| `IsSymm`, `IsRefl`, `Nondegenerate`, `restrict`, `flip`, `Isometry`, `IsometryEquiv`, `Equivalent` | `Mathlib/LinearAlgebra/BilinearForm/` | 0A, 0G, 2G |
| `LinearMap.BilinForm.toMatrix`, `Matrix.toBilin`, `toMatrix_apply`, `toMatrix_mul_basis_toMatrix`, `nondegenerate_iff_det_ne_zero` | `Mathlib/LinearAlgebra/Matrix/BilinearForm.lean` | 0A, 0C |
| `LinearMap.BilinForm.baseChange`, `baseChange_tmul`, `IsSymm.baseChange` | `Mathlib/LinearAlgebra/BilinearForm/TensorProduct.lean` | 0E, 1A, 3A |
| `dualSubmodule`, `dualSubmodule_span_of_basis`, `dualSubmodule_dualSubmodule_of_basis`, `dualSubmoduleToDual` | `Mathlib/LinearAlgebra/BilinearForm/DualLattice.lean` | 1B, 1C |
| `Submodule.basisOfPid`, `Module.Basis.SmithNormalForm`, `Submodule.smithNormalFormOfRankEq` | `Mathlib/LinearAlgebra/FreeModule/PID.lean` | 1C, 4F |
| `Submodule.natAbs_det_basis_change`, `AddSubgroup.index_eq_natAbs_det`, `AddSubgroup.relIndex_eq_natAbs_det`, `AddSubgroup.relIndex_eq_abs_det` | `Mathlib/LinearAlgebra/FreeModule/Finite/CardQuotient.lean` | 0C, 1C |
| `Submodule.quotientEquivPiZMod` | `Mathlib/LinearAlgebra/FreeModule/Finite/Quotient.lean` | 1C |
| `AddCommGroup.equiv_directSum_zmod_of_finite`, character duality | `Mathlib/GroupTheory/FiniteAbelian/Basic.lean`, `Duality.lean` | 1C, 1G |
| `AddCircle`, `AddCircle.equivAddCircle`, `equivAddCircle_apply_mk` | `Mathlib/Topology/Instances/AddCircle/Defs.lean` | 1D, 1G |
| `IsOrtho`, `iIsOrtho`, `orthogonal`, `nondegenerate_restrict_of_disjoint_orthogonal` | `Mathlib/LinearAlgebra/BilinearForm/Orthogonal.lean` | 0F, 3B |
| `IsZLattice`, `ZLattice.rank`, fundamental domains | `Mathlib/Algebra/Module/ZLattice/Basic.lean` | 2A, 2D, 8A |
| `ZLattice.covolume`, `covolume_eq_det`, `covolume_div_covolume_eq_relIndex`, `tendsto_card_div_pow` | `Mathlib/Algebra/Module/ZLattice/Covolume.lean` | 2D, 2E, 8D |
| norm-power summability over a lattice | `Mathlib/Algebra/Module/ZLattice/Summable.lean` | 8B |
| `exists_ne_zero_mem_lattice_of_measure_mul_two_pow_lt_measure` | `Mathlib/MeasureTheory/Group/GeometryOfNumbers.lean` | 2E |
| `sigPos`, `sigNeg`, `sigPos_add_sigNeg_add_radical`, `QuadraticForm.sigPos_of_equiv_weightedSumSquares`, `isometryEquivSignWeightedSumSquares` | `Mathlib/LinearAlgebra/QuadraticForm/Signature.lean`, `Real.lean` | 0E |
| `CartanMatrix.A`, `CartanMatrix.D`, `CartanMatrix.E₆`, `CartanMatrix.E₇`, `CartanMatrix.E₈` | `Mathlib/LinearAlgebra/Matrix/Cartan.lean` | 0G, 6C |
| `jacobiTheta`, `jacobiTheta_two_add`, `jacobiTheta_S_smul` | `Mathlib/NumberTheory/ModularForms/JacobiTheta/OneVariable.lean` | 8C |
| `Complex.tsum_exp_neg_quadratic`, `Real.tsum_eq_tsum_fourier` | `Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.lean`, `Mathlib/Analysis/Fourier/PoissonSummation.lean` | 8B |
| `Matrix.PosDef`, `Matrix.PosSemidef`, congruence invariance | `Mathlib/LinearAlgebra/Matrix/PosDef.lean` | 0E |
| `ℤ_[p]`, `ℚ_[p]`, Hensel's lemma, `PadicInt.unitCoeff` | `Mathlib/NumberTheory/Padics/` | 3A |
| Gauss sums and quadratic characters | `Mathlib/NumberTheory/LegendreSymbol/GaussSum.lean` | 1H |

Two limits of the Mathlib API shape this roadmap. The eigenvalue and determinant
characterizations of `Matrix.PosDef` require `RCLike`, so milestone 0E builds the transfer
from `ℤ` to `ℝ` itself. The splitting results in `BilinearForm/Orthogonal.lean` are stated
over a field, so milestone 0F proves the correct statement over `ℤ`, where the hypothesis
is unimodularity and not nondegeneracy.

## What Tau Ceti supplies

| Declarations | Location | Consumed by |
| --- | --- | --- |
| `squareClass`, `squareClass_eq_zero_iff`, `linearIndependent_squareClass_iff` | `TauCeti/FieldTheory/SquareClassGroup.lean` | 3C, 4C |
| `orthogonalGroupToLinearIsometryEquiv` | `TauCeti/LinearAlgebra/OrthogonalGroup.lean` | 2C |
| box packing and doubling counts | `TauCeti/NumberTheory/GeometryOfNumbers/Doubling.lean` | 2E, 2G |

## What other roadmaps supply

Each row names one interface. A milestone cites the row, and never a whole roadmap.

| Consumed | Supplier | Consumed by |
| --- | --- | --- |
| square classes and their calculus; Witt decomposition and cancellation over a field | Quadratic Form Invariants, Layers 0 and 1 | 3H, 4C |
| the invariants `discr`, `signedDiscr` and the Hasse invariant `s(q) = ∏_{i<j} (aᵢ,aⱼ)` | Quadratic Form Invariants, Layer 3 | 0C, 3H |
| classification of forms over `ℚ_p` by `(dim, d±, s)`, including `p = 2` | Quadratic Form Invariants, Layer 6 | 3H |
| the Hilbert product formula `∏_v (a,b)_v = 1` over `ℚ` | Global Class Field Theory, Layer 11 | 3G |
| the spinor norm on `O(V_p)`, and the image of `Spin` as the spinor kernel | Orthogonal and Spin Groups, Layers 1 and 2 | 4C |
| finite adelic point groups as restricted products, with diagonal rational points | Orthogonal and Spin Groups, Layer 3 | 4B, 7B |
| strong approximation for `Spin(V)`, `V` indefinite of dimension at least 3 | Orthogonal and Spin Groups, Layer 4 | 4D, 4E |
| Eichler transvections and their spinor norm | Orthogonal and Spin Groups, Layer 4 | 4E |
| canonical local Haar measures, and `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` | Orthogonal and Spin Groups, Layer 5 | 7B, 7F |
| the order of `W(E₈)`, the ADE classification, root systems from a bilinear form | Root Systems, Layer 5 | 6C, 7H |
| Poisson summation and the Gaussian theta transformation for a `ZLattice` | L-functions, Layer 2 | 8D, 8E |

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

---

## The build, in layers

### Layer 0: lattices, the dictionary, and the first invariants

**0A. The lattice and its predicates.** The object is `IntegralLatticeForm`, as fixed in
the conventions. This milestone asks for:

- the predicates `IsEven`, `Nondegenerate`, `IsUnimodular`, which says `det L = ±1`, and
  `PosDef`;
- the orthogonal direct sum, the twist `L(a)`, and isometry;
- the determinant of a direct sum is the product of the determinants, and the determinant
  of `L(a)` is `aⁿ det L`;
- the rank is additive over direct sums;
- the restriction of `β` to a submodule is again a lattice form.

**0B. The even and quadratic dictionary.** An even symmetric `β` is the polar form of a
unique `Q : QuadraticForm ℤ L`. The polar form of any `Q` is symmetric and even, and
satisfies `Q.polarBilin x x = 2 * Q x`. Both round trips are proved. The dictionary is
transported to Gram matrices, where evenness is an even diagonal, and to direct sums and
twists.

**0C. Gram matrices and the determinant.** The Gram matrix of a basis, and equality of
Gram determinants under a change of basis. Then `det L : ℤ` is an invariant of the lattice.
Its behavior under direct sums and twists is proved. For a sublattice `L' ≤ L` of finite
index, `det L' = [L : L']² · det L`.

The comparison with the square-class invariants of the rational form is also proved:
`d(β ⊗ ℚ) = [det L]` and `d±(β ⊗ ℚ) = (−1)^{n(n−1)/2}·[det L]`.

**0D. Scale, norm ideal and level.** The ideals `𝔰(L)` and `𝔫(L)`, the inclusions
`2𝔰 ⊆ 𝔫 ⊆ 𝔰`, and the characterization of evenness by `𝔫 ⊆ 2ℤ`. The level of a
nondegenerate integral lattice, and its independence of the chosen basis.

**0E. Definiteness and signature.** `PosDef` over `ℤ` is equivalent to `PosDef` of the real
form, and to `Matrix.PosDef` of the real Gram matrix. Mathlib proves the real statements
only over an `RCLike` field, so this transfer is proved here. A definite lattice is
nondegenerate. The signature `(t₊, t₋)` of the real form satisfies `t₊ + t₋ = rank L` for
nondegenerate `L`. Every nondegenerate lattice is positive definite, negative definite, or
indefinite.

**0F. Unimodular orthogonal splitting.** If `M ≤ L` and the restriction of `β` to `M` is
unimodular, then `L = M ⊕ M^⊥`. Over `ℤ` the correct hypothesis is unimodularity, not
nondegeneracy. A vector of norm `±1` therefore splits off a summand `⟨±1⟩`. Cancellation
over `ℤ` is false, and the failure is stated with the counterexample given in the table of
hard theorems.

**0G. The standard examples.** The examples are `⟨a⟩`, `Iₙ`, the hyperbolic plane `U` with
Gram matrix `!![0,1;1,0]`, and the root lattices `Aₙ`, `Dₙ`, `E₆`, `E₇` and `E₈`. For each
one the milestone asks for the rank, the determinant, the parity, the signature and the
level. The Cartan matrices are the Gram matrices of the root lattices. The coordinate
models `Aₙ = {x ∈ ℤ^{n+1} : ∑ x = 0}` and `Dₙ = {x ∈ ℤⁿ : ∑ x even}` are constructed, and
the isometries with the Gram matrix models are proved.

| Milestone | Direct prerequisites |
| --- | --- |
| 0A | M `LinearMap.BilinForm.IsSymm`, `Nondegenerate`, `nondegenerate_iff_det_ne_zero`, `QuadraticMap.PosDef` |
| 0B | M `polarBilin`, `exists_companion'`, `polar_self`, `two_nsmul_associated`; L 0A |
| 0C | M `BilinForm.toMatrix`, `toMatrix_mul_basis_toMatrix`, `Submodule.natAbs_det_basis_change`; L 0A; R Quadratic Form Invariants Layer 3 |
| 0D | L 0A, 0C |
| 0E | M `sigPos`, `sigNeg`, `sigPos_add_sigNeg_add_radical`, `Matrix.PosDef`, `LinearMap.BilinForm.baseChange`; L 0A, 0C |
| 0F | M `IsOrtho`, `orthogonal`, `nondegenerate_restrict_of_disjoint_orthogonal`; L 0A, 0C |
| 0G | M `CartanMatrix.A`, `CartanMatrix.D`, `CartanMatrix.E₆`, `CartanMatrix.E₇`, `CartanMatrix.E₈`; L 0A to 0F |

### Layer 1: dual lattices, discriminant groups, and finite quadratic forms

**1A. The rational realization.** `V = ℚ ⊗ L` with `B = β.baseChange ℚ`. A lattice is the
same thing as a full-rank submodule of a rational quadratic space, in both directions, and
every Layer-0 invariant is transported. Integrality of `β` is `L ≤ L^⋆`.

**1B. The dual lattice.** `L^⋆ = B.dualSubmodule L`, with `L^{⋆⋆} = L` for symmetric
nondegenerate `B`. Duality reverses inclusions. For `a ≠ 0`, `(L(a))^⋆ = (L^⋆)(a⁻¹)` inside
`V`. The Gram matrix of the dual basis is `G⁻¹`, and `det L^⋆ = (det L)⁻¹` in `ℚ`. A
lattice is unimodular exactly when `L = L^⋆`.

**1C. The discriminant group.** `A_L = L^⋆/L` is finite of order `|det L|`, and
`l(A_L) ≤ rank L`. Its invariant factors come from `Submodule.quotientEquivPiZMod`. The
pairing `A_L × A_L → ℚ/ℤ` is perfect. Mathlib states finite abelian duality for
homomorphisms into `Mˣ`, so the comparison with the `ℚ/ℤ`-valued dual is part of this
milestone. This discharges the two open requests in
`Mathlib/LinearAlgebra/BilinearForm/DualLattice.lean`.

**1D. The discriminant forms.** `b_L` for a nondegenerate integral lattice, and `q_L` for
an even lattice, with values in the types fixed in the conventions. Polarization of `q_L`
followed by the halving map gives `b_L`. Canonical isometries
`A_{L⊕M} ≅ A_L ⊕ A_M` carrying `q_{L⊕M}` to `q_L ⊕ q_M`, and `A_{L(−1)} ≅ A_L` carrying
`q_{L(−1)}` to `−q_L`. These are isometries of finite quadratic forms, and not equalities
of types.

**1E. Integral overlattices.** Let `L` be nondegenerate and integral, and let `M ⊇ L` have
finite index. Then `M/L ≤ A_L`, and `M` is integral exactly when `b_L` vanishes on `M/L`.
This gives a bijection between integral overlattices and subgroups `H ≤ A_L` with
`b_L|_{H×H} = 0`. For such an `H`, `A_M ≅ H^⊥/H` with the induced form, and
`det M = det L / [M : L]²`.

**1F. Even overlattices.** Let `L` be even. Then an overlattice `M` of finite index is even
exactly when `q_L` vanishes on `M/L`. This gives a bijection between even overlattices and
subgroups `H` with `q_L|_H = 0`, and `A_M ≅ H^⊥/H` carries the induced `q_M`. Isotropy for
`q_L` implies isotropy for `b_L`, so the even correspondence is a restriction of the
integral one. The two are different: milestone 1F is the one Layer 5 uses, and the smallest
lattice where they differ is `A₁ ⊕ A₁`.

**1G. Finite quadratic forms.** A finite quadratic form is a pair `(A, q)` where `A` is a
finite abelian group and `q : A → ℚ/2ℤ` satisfies `q(n • a) = n² q(a)` and has biadditive
polarization. Nondegeneracy is bijectivity of the adjoint `A → (A →+ ℚ/ℤ)`. This milestone asks for:

- orthogonal sums, and the `p`-primary decomposition `q = ⊕_p q_p`;
- isometries, and the group `O(q)`;
- the generators `q_θ^{(p)}(p^k)`, `u^{(2)}(2^k)` and `v^{(2)}(2^k)` of Nikulin
  Proposition 1.8.1, with the theorem that every finite quadratic form is an orthogonal
  sum of them;
- the relations among the generators, which are Nikulin Proposition 1.8.2.

Without the relations the list of generators is not a classification. Layers 3 and 5 need
the classification.

**1H. The Gauss-sum invariant.** For nondegenerate `(A, q)`,
`∑_{a ∈ A} e^{πi q(a)} = √#A · e^{2πi·sign(q)/8}`, which defines `sign q ∈ ℤ/8`. The
invariant is additive over orthogonal sums. Its values on the generators are those of
Nikulin Proposition 1.11.2:

- `sign q_θ^{(p)}(p^k) ≡ k²(1−p) + 4kη (mod 8)` for odd `p`, where `(θ|p) = (−1)^η`;
- `sign q_θ^{(2)}(2^k) ≡ θ + 4kω(θ) (mod 8)`, where `ω(θ) ≡ (θ²−1)/8 (mod 2)`;
- `sign v^{(2)}(2^k) ≡ 4k (mod 8)`;
- `sign u^{(2)}(2^k) ≡ 0 (mod 8)`.

Nikulin Theorem 1.11.3 is proved with them: two finite quadratic forms with isometric
bilinear forms are isometric exactly when their invariants agree mod 8.

**1I. Milgram's theorem.** For an even nondegenerate lattice, `t₊ − t₋ ≡ sign q_L (mod 8)`.
An even unimodular lattice has `A_L = 0`, so `8 ∣ t₊ − t₋`.

**1J. Level.** For an even lattice the level is the exponent of the annihilator of `q_L`,
and it agrees with the definition through `N·G⁻¹`. The level divides `2·det L`, with the
divisibility calculus that follows.

| Milestone | Direct prerequisites |
| --- | --- |
| 1A | M `LinearMap.BilinForm.baseChange`, `IsSymm.baseChange`; L 0A, 0C |
| 1B | M `dualSubmodule`, `dualSubmodule_span_of_basis`, `dualSubmodule_dualSubmodule_of_basis`; L 1A |
| 1C | M `AddSubgroup.relIndex_eq_abs_det`, `Submodule.quotientEquivPiZMod`, `AddCommGroup.equiv_directSum_zmod_of_finite`, `Mathlib/GroupTheory/FiniteAbelian/Duality.lean`; L 1B |
| 1D | M `AddCircle`, `AddCircle.equivAddCircle`; L 1C |
| 1E | L 1C, 1D |
| 1F | L 1E |
| 1G | M `AddCircle`, `AddCommGroup.equiv_directSum_zmod_of_finite`; L 1D |
| 1H | M Gauss sums and quadratic characters; L 1G |
| 1I | L 0E, 1D, 1H |
| 1J | L 0D, 1D |

### Layer 2: positive definite lattices, reduction, and automorphisms

Every statement in this layer assumes that `L` is positive definite, unless it says
otherwise. The negative definite case follows by replacing `β` with `−β`.

**2A. Sets of bounded norm are finite.** For positive definite `L` and any `C`, the set
`{x | β x x ≤ C}` is finite. Two proofs are acceptable: realization in `ℝⁿ` with
`ZLattice` discreteness, or an elementary bound from the Gram matrix.

**2B. Minimum, shells, kissing number.** `min L` is the least value of `β x x` over nonzero
`x`, and it is defined when `rank L ≥ 1`. The shell `S_k(L) = {x | β x x = k}` is defined
for every rank. In rank 0, `S_0 = {0}` and every other shell is empty. The kissing number
is `#S_{min L}(L)`, and `r_L(k) = #S_k(L)` are the theta coefficients of Layer 8.

**2C. Automorphism groups.** `O(L)` is the group of isometries of `L`, and `SO(L)` is its
subgroup of elements of determinant 1. For definite `L`, `O(L)` is finite. Also
`O(L) × O(M) ≤ O(L ⊕ M)`, with the obstruction to equality identified.

**2D. Covolume.** For a positive definite lattice realized in Euclidean space,
`covolume(L)² = det L`. This is where the square root in the theta transformation is fixed.

**2E. Minkowski and Hermite bounds.** `min L ≤ c_n (det L)^{1/n}` from the convex body
theorem, and Hermite's inequality `min L ≤ (4/3)^{(n−1)/2} (det L)^{1/n}` with the explicit
constant. `A₂` attains equality in rank 2.

**2F. Successive minima.** The successive minima `λ₁(L) ≤ … ≤ λₙ(L)` of the Gram form, and
a basis adapted to them.

**2G. Reduction and finiteness of classes.** Minkowski-reduced bases exist. A reduced Gram
matrix of given rank and determinant has entries bounded explicitly in terms of the rank
and the determinant. There are therefore finitely many isometry classes of positive
definite lattices of a given rank and determinant. This is the positive definite case of
class-number finiteness, and it is what the enumeration in the LMFDB rests on.

**2H. Automorphism groups in rank 2.** For an indefinite nondegenerate lattice of rank 2,
`O(L)` is infinite exactly when the form is anisotropic. So `O(U) ≅ (ℤ/2)²` is finite, and
`O(⟨1,−2⟩)` is infinite, being the unit group of `ℤ[√2]`. Milestone 4E treats rank at least
3.

| Milestone | Direct prerequisites |
| --- | --- |
| 2A | M `IsZLattice`, `Matrix.PosDef`; L 0E |
| 2B | L 2A |
| 2C | M `IsZLattice`; T `orthogonalGroupToLinearIsometryEquiv`; L 2A |
| 2D | M `ZLattice.covolume`, `covolume_eq_det`; L 0C, 0E |
| 2E | M `exists_ne_zero_mem_lattice_of_measure_mul_two_pow_lt_measure`, `ZLattice.covolume`; T doubling counts; L 2B, 2D |
| 2F | L 2B, 2E |
| 2G | T doubling counts; L 2E, 2F |
| 2H | M `Matrix.PosDef`; L 0E, 2C |

### Layer 3: localization, Jordan splittings, and the genus

**3A. Lattices over `ℤ_p`.** `L_p = ℤ_p ⊗ L` with `β_p = β.baseChange ℤ_[p]`, which is
defined for every `p`, including `p = 2`. Free finite `ℤ_p`-modules with symmetric forms,
their scale and norm ideals, and unimodular `ℤ_p`-lattices. The splitting result 0F holds
over `ℤ_p`, and it is stronger there: a unimodular summand of maximal scale splits off.

**3B. Jordan splittings exist.** Every nondegenerate `ℤ_p`-lattice is an orthogonal sum
`⊕_i p^i L_i` with each `L_i` unimodular.

**3C. Odd `p`.** A unimodular `ℤ_p`-lattice with `p` odd is diagonalizable. The rank and
the square class of the unit determinant classify such lattices. There are therefore
exactly two of each positive rank, and one of rank 0. The Jordan invariants are unique, and
two lattices are isometric exactly when their Jordan data agree.

**3D. The dyadic case.** Over `ℤ_2` an orthogonal basis need not exist: the hyperbolic
plane `U` is not diagonalizable. Jordan splittings are not unique. The invariants are the
type of each constituent, the norm group, and the weight. The order of work is: the
unimodular classification first, then the general dyadic classification.

**3E. Conway–Sloane 2-adic symbols.** The symbol of a dyadic lattice, with the scale, rank,
sign, type and oddity of each constituent, and with compartments and trains. The theorem is
that two symbols describe isometric lattices exactly when sign walking and oddity fusion
relate them. The canonical form is the corrected one of Allcock–Gal–Mark.

**3F. The genus.** `gen L = gen M` when `L_p ≅ M_p` for every `p` and the real signatures
agree. The genus is determined by finitely many congruence conditions, namely equivalence
over `ℤ/N` for a suitable `N`, which is stated in an effective form.

**3G. Genus symbols and their constraints.** The genus symbol is the family of `p`-adic
symbols for `p ∣ 2·det L`, and it determines the genus. Its well-formedness conditions are
the compatibilities of rank, determinant and oddity, together with the oddity formula and
the sign product conditions. Those two are proved from the Hilbert product formula. The
resulting conditions on symbols are decidable.

**3H. The rational form of a genus.** Two lattices in one genus have equivalent forms over
`ℚ` and over every `ℚ_p`, in the invariants `(rank, d±, s_p, signature)`. Conversely,
rational equivalence together with the integral local data gives membership in one genus.

| Milestone | Direct prerequisites |
| --- | --- |
| 3A | M `LinearMap.BilinForm.baseChange`, `ℤ_[p]`; L 0A, 0D, 0F |
| 3B | M `IsOrtho`, `iIsOrtho`; L 3A |
| 3C | M `PadicInt.unitCoeff`; T `squareClass`; L 3B |
| 3D | L 3B |
| 3E | L 3D |
| 3F | L 0E, 3C, 3D |
| 3G | L 3E, 3F; R Global Class Field Theory Layer 11 |
| 3H | L 3F; R Quadratic Form Invariants Layers 1, 3 and 6 |

### Layer 4: classes, spinor genera, Eichler's theorem, and neighbors

The Orthogonal and Spin Groups roadmap owns the groups and the approximation theorem. This
layer owns their specialization to integral lattices.

**4A. Class sets.** The class `cls L`, the proper class `cls⁺ L`, the genus `gen L`, and
the proper genus, with the inclusions `cls ⊆ spn ⊆ gen` once 4C defines the middle term.
The class number `h(L)` is the number of classes in `gen L`, and the proper class number is
its analogue. For definite `L` the class number is finite. In rank 0 and rank 1 the class
sets are computed directly.

**4B. Stabilizers and the adelic dictionary.** For `V = ℚ ⊗ L`, the stabilizers
`K_p(L) = {g ∈ O(V_p) : g L_p = L_p}` and `K_p⁺(L) = K_p(L) ∩ SO(V_p)`. Each is compact and
open. For all but finitely many `p` it is the stabilizer of a unimodular `ℤ_p`-lattice, in
the form that makes the restricted product well defined. The products `K_f(L)` and
`K_f⁺(L)` are compact open subgroups. The two correspondences are proved in both
directions:

    {classes in gen L}        ≃  O(V)(ℚ) \ O(V)(𝔸_f) / K_f(L),
    {proper classes in gen L} ≃  SO(V)(ℚ) \ SO(V)(𝔸_f) / K_f⁺(L).

**4C. Spinor genera.** The images `θ_p(K_p⁺(L))` of the local spinor norm on the stabilizers,
computed from the Jordan data of Layer 3. The spinor genus `spn L` and the proper spinor genus
`spn⁺ L`. The definition through local spinor norms agrees with the definition through adelic
double cosets.

The number of proper spinor genera in a genus is the order of an explicit finite abelian
quotient. That quotient is the idele class group of `ℚ`, divided by the subgroup generated by
three families: the squares, the images `θ_p(K_p⁺(L))`, and the image of `θ_∞`. Every one of
those subgroups is named in the statement.

**4D. Eichler's theorem.** For an indefinite nondegenerate lattice of rank at least 3, a
proper spinor genus contains exactly one proper class, so `cls⁺ L = spn⁺ L`. The passage
from proper classes to classes needs the analysis of when `O(L) ≠ SO(L)`, and that is part
of the milestone.

**4E. Class numbers of indefinite lattices.** For rank at least 3 the class number is finite,
and it is bounded by the count of 4C. For rank 2 finiteness is a separate theorem. Binary
quadratic forms of a given discriminant correspond to ideal classes of the associated quadratic
order. The class number of that order is finite. The rank-2 proof does not use strong
approximation, and the proof for rank at least 3 does not cover rank 2.

**4F. Automorphism groups of indefinite lattices.** For an indefinite nondegenerate lattice
of rank at least 3, `O(L)` is infinite. The proof produces Eichler transvections in `O(L)`.
Together with 2H this settles the definite hypothesis in 2C, and it is why Layer 7 treats
positive definite genera only.

**4G. Kneser neighbors.** Integral lattices `L` and `M` on `V` are `p`-neighbors when
`[L : L ∩ M] = [M : L ∩ M] = p`. This milestone asks for:

- the definition and its symmetry;
- equality of determinants for neighbors;
- equality of genus when `p ∤ 2 det L`;
- the construction of a neighbor from an isotropic vector mod `p`;
- a decidable check for one edge.

This milestone proves nothing about enumeration. Connectivity of the neighbor graph is not
claimed, and no consumer may infer a complete list of classes from neighbor steps.

| Milestone | Direct prerequisites |
| --- | --- |
| 4A | L 2C, 2G, 3F |
| 4B | L 3A, 3B, 4A; R Orthogonal and Spin Groups Layers 2 and 3 |
| 4C | T `squareClass`; L 3C, 3D, 4B; R Orthogonal and Spin Groups Layers 1 and 2 |
| 4D | L 4B, 4C; R Orthogonal and Spin Groups Layer 4 |
| 4E | L 4C, 4D; R Quadratic Form Invariants Layer 1 |
| 4F | L 2C; R Orthogonal and Spin Groups Layer 4 |
| 4G | M `Submodule.basisOfPid`; L 0C, 3F |

### Layer 5: discriminant forms and Nikulin's theory

Citations are to Nikulin, *Integer symmetric bilinear forms and some of their geometric
applications*, where the numbering of the translation agrees with the original. His `E₈` is
negative definite, so each citation carries the twist.

**5A. The genus and the discriminant form.** For even lattices, `gen L` is determined by
`(t₊, t₋, q_L)`. The odd analogue is stated as well. The translation between the
Conway–Sloane symbols of 3E and the invariants `(t₊, t₋, q)` is proved in both directions.

**5B. Existence.** An even lattice with invariants `(t₊, t₋, q)` exists if and only if:

1. `t₊ − t₋ ≡ sign q (mod 8)`;
2. `t₊ ≥ 0`, `t₋ ≥ 0`, and `t₊ + t₋ ≥ l(A_q)`;
3. `(−1)^{t₋} |A_q| ≡ discr K(q_p) (mod (ℤ_p^*)²)` for every odd prime `p` with
   `t₊ + t₋ = l(A_{q_p})`;
4. `|A_q| ≡ ± discr K(q₂) (mod (ℤ_2^*)²)`, whenever `t₊ + t₋ = l(A_{q₂})` and `q₂` has no
   summand `q_θ^{(2)}(2)`.

This is Theorem 1.10.1. Corollary 1.10.2 is the sufficient form: conditions 1 and 2 with
the strict inequality `t₊ + t₋ > l(A_q)`. Both are milestones, and the corollary does not
replace the theorem.

**5C. Uniqueness.** An even lattice with invariants `(t₊, t₋, q)` is unique in its genus if:

1. `t₊ ≥ 1`, `t₋ ≥ 1`, and `t₊ + t₋ ≥ 3`;
2. for every odd `p`, either `rank ≥ l(A_{q_p}) + 2`, or
   `q_p ≅ q_{θ₁}^{(p)}(p^k) ⊕ q_{θ₂}^{(p)}(p^k) ⊕ q'`;
3. at `p = 2`, either `rank ≥ l(A_{q₂}) + 2`, or `q₂ ≅ u^{(2)}(2^k) ⊕ q'`, or
   `q₂ ≅ v^{(2)}(2^k) ⊕ q'`, or
   `q₂ ≅ q_{θ₁}^{(2)}(2^k) ⊕ q_{θ₂}^{(2)}(2^{k+1}) ⊕ q'`.

This is Theorem 1.13.2. With 5B it gives Corollary 1.13.3: an even lattice with invariants
`(t₊, t₋, q)` exists and is unique when `t₊ − t₋ ≡ sign q (mod 8)`,
`t₊ + t₋ ≥ l(A_q) + 2`, `t₊ ≥ 1` and `t₋ ≥ 1`.

**5D. Stabilization and splitting.** Corollary 1.13.4 has two parts. Let `T` be even with
invariants `(t₊, t₋, q)`. Then `U ⊕ T` is the unique even lattice with invariants
`(t₊+1, t₋+1, q)`. If in addition `t₊ > 0`, then `E₈(−1) ⊕ T` is the unique even lattice
with invariants `(t₊, t₋+8, q)`.

Corollary 1.13.5 also has two parts. Let `S` be an even lattice of signature `(t₊, t₋)`.
Then `S ≅ U ⊕ T` for some `T` when `t₊ ≥ 1`, `t₋ ≥ 1` and `t₊ + t₋ ≥ l(A_S) + 3`. And
`S ≅ E₈(−1) ⊕ T` for some `T` when `t₊ ≥ 1`, `t₋ ≥ 8` and `t₊ + t₋ ≥ l(A_S) + 9`.

**5E. The map from isometries to isometries of the discriminant form.** Theorem 1.14.2
assumes that `T` is an even indefinite lattice with two properties. First,
`rank T ≥ l(A_{T_p}) + 2` for every odd `p`. Second, if `rank T = l(A_{T₂})`, then
`q_{T₂} ≅ u^{(2)}(2) ⊕ q'` or `q_{T₂} ≅ v^{(2)}(2) ⊕ q'`. The conclusion is that the genus
of `T` has one class, and that `O(T) → O(q_T)` is surjective.

Proposition 1.14.1 is proved with it. It reduces the Witt-type statements to three
conditions on the orthogonal complement.

**5F. Primitivity.** An injection of finite free `ℤ`-modules has torsion-free cokernel
exactly when its image is a direct summand. Every statement below quantifies over primitive
embeddings.

**5G. Primitive embeddings into an even unimodular lattice.** Theorem 1.12.2: for an even
lattice `S` with invariants `(t₊, t₋, q)` and integers `l₊`, `l₋`, the following are
equivalent:

1. `S` embeds primitively into some even unimodular lattice of signature `(l₊, l₋)`;
2. an even lattice with invariants `(l₊ − t₊, l₋ − t₋, −q)` exists;
3. all four of: `l₊ − l₋ ≡ 0 (mod 8)`; `l₊ − t₊ ≥ 0`, `l₋ − t₋ ≥ 0` and
   `l₊ + l₋ − t₊ − t₋ ≥ l(A_q)`; `(−1)^{l₊ − t₊} |A_q| ≡ discr K(q_p) (mod (ℤ_p^*)²)` for
   every odd `p` with `l₊ + l₋ − t₊ − t₋ = l(A_{q_p})`; and
   `|A_q| ≡ ± discr K(q₂) (mod (ℤ_2^*)²)` if `l₊ + l₋ − t₊ − t₋ = l(A_{q₂})` and `q₂` has no
   summand `q_θ^{(2)}(2)`.

Corollary 1.12.3 is the sufficient form with `l₊ + l₋ − t₊ − t₋ > l(A_q)`. Theorem 1.12.4
gives the criterion in terms of the signatures alone.

**5H. Uniqueness of a primitive embedding.** Theorem 1.14.4 concerns a primitive embedding
of an even lattice `M` of signature `(t₊, t₋)` into an even unimodular lattice `L` of
signature `(l₊, l₋)`. The embedding is unique up to `O(L)` if:

1. `l₊ − t₊ > 0` and `l₋ − t₋ > 0`;
2. `l₊ + l₋ − t₊ − t₋ ≥ l(A_{M_p}) + 2` for every odd `p`;
3. `q_M ≅ u^{(2)}(2) ⊕ q'` or `q_M ≅ v^{(2)}(2) ⊕ q'`, in the case
   `l₊ + l₋ − t₊ − t₋ = l(A_{M₂})`.

**5I. Primitive embeddings into a general even lattice.** Proposition 1.15.1: primitive
embeddings of `S` into even lattices with invariants `(m₊, m₋, q)` correspond to tuples
`(H_S, H_q, γ; K, γ_K)`. The components are:

- subgroups `H_S ≤ A_S` and `H_q ≤ A_q`;
- an isometry `γ` from `q_S|H_S` to `q|H_q`;
- an even lattice `K` with invariants `(m₊ − t₊, m₋ − t₋, −δ)`, where
  `δ = (q_S ⊕ (−q))|Γ_γ^⊥ / Γ_γ` and `Γ_γ ⊆ A_S ⊕ A_q` is the graph of `γ`;
- an isometry `γ_K` from `q_K` to `−δ`.

Two tuples give isomorphic
embeddings exactly when `H_S = H'_S` and suitable isometries intertwine the data, and
isomorphic primitive sublattices exactly when `H_S` and `H'_S` are conjugate under `O(S)`.
The lattice `K` is the orthogonal complement of `S`. Corollary 1.15.2 states the genus-level
version.

**5J. 2-elementary lattices.** `S` is 2-elementary when `A_S ≅ (ℤ/2)^a`. Then `q_S` is an
orthogonal sum of forms `q_θ^{(2)}(2)`, `u^{(2)}(2)` and `v^{(2)}(2)`, and `δ_S` is 0 when
no summand `q_θ^{(2)}(2)` occurs and 1 otherwise. Theorem 3.6.2: the genus of an even
2-elementary lattice is determined by `(δ_S; t₊, t₋, a)`, and when `t₊ > 0` and `t₋ > 0`
these invariants determine the isometry class. Such a lattice exists, for `δ_S ∈ {0,1}` and
`a, t₊, t₋ ≥ 0`, if and only if:

1. `a ≤ t₊ + t₋`;
2. `t₊ + t₋ + a ≡ 0 (mod 2)`;
3. `t₊ − t₋ ≡ 0 (mod 4)` when `δ_S = 0`;
4. `δ_S = 0` and `t₊ − t₋ ≡ 0 (mod 8)` when `a = 0`;
5. `t₊ − t₋ ≡ ±1 (mod 8)` when `a = 1`;
6. `δ_S = 0` when `a = 2` and `t₊ − t₋ ≡ 4 (mod 8)`;
7. `t₊ − t₋ ≡ 0 (mod 8)` when `δ_S = 0` and `a = t₊ + t₋`.

Theorem 3.6.3: for indefinite even 2-elementary `S`, the map `O(S) → O(q_S)` is surjective.
Nikulin's paper has no `p`-elementary theorem for odd `p`. For odd `p` the classification
follows from 5C, and the roadmap states it that way.

| Milestone | Direct prerequisites |
| --- | --- |
| 5A | L 1D, 1G, 3E, 3F |
| 5B | L 1G, 1H, 3C, 3D, 5A |
| 5C | L 5A, 5B |
| 5D | L 0G, 5C |
| 5E | L 2C, 5C |
| 5F | M `Submodule.basisOfPid`, `IsCompl` |
| 5G | L 1E, 1F, 5B, 5F |
| 5H | L 5E, 5G |
| 5I | L 1F, 5G, 5H |
| 5J | L 1G, 5B, 5C, 5E |

### Layer 6: unimodular lattices in low rank

**6A. Indefinite classification.** An even indefinite unimodular lattice is
`U^{min(t₊,t₋)} ⊕ E₈(±1)^{|τ|/8}`, and its signature determines it. An odd indefinite
unimodular lattice is `⟨1⟩^{t₊} ⊕ ⟨−1⟩^{t₋}`.

**6B. Existence in the definite case.** An even unimodular positive definite lattice of
rank `n` exists exactly when `8 ∣ n`.

**6C. Rank at most 9.** A positive definite unimodular lattice of rank at most 9 is `Iₙ`,
`E₈`, or `E₈ ⊕ I₁`. The proof follows O'Meara: uniqueness of the decomposition into
indecomposable summands, and a count of characteristic vectors. It follows that `E₈` is the
unique even unimodular lattice of rank 8. The alternative proof through root systems, in
which the minimal vectors form a root system of type `E₈`, discharges the same milestone.

**6D. Rank 16.** `E₈²` and `D₁₆⁺` are even unimodular of rank 16, they lie in one genus, and
they are not isometric. Their root systems differ. That there is no third class is a
theorem of this milestone. It is proved either by a complete neighbor argument or from the
mass certificate of 7H.

**6E. Rank 24 reference lattices.** The 24 Niemeier lattices are defined by explicit Gram
data or glue data. For each row: evenness, unimodularity, rank 24, the stated root system,
and non-isometry with the other rows whenever the computed invariants settle it. The name
Leech denotes the row with no roots. This milestone states no completeness theorem for rank
24.

**6F. Two models of `E₈`.** The Gram matrix model of 0G and the coordinate model
`{x ∈ ℤ⁸ ∪ (ℤ+½)⁸ : ∑ x ∈ 2ℤ}` are isometric. The proof gives Tau Ceti one `E₈` and one
isometry, rather than two unrelated lattices.

| Milestone | Direct prerequisites |
| --- | --- |
| 6A | L 1I, 5C, 5D |
| 6B | L 1I, 0G |
| 6C | M `CartanMatrix.E₈`; L 0F, 2G; R Root Systems Layer 5 |
| 6D | L 2C, 3F, 5A, 6B, 4G |
| 6E | L 0C, 1C, 2B |
| 6F | L 0G, 2B |

### Layer 7: the Smith–Minkowski–Siegel mass formula

Every statement in this layer is about positive definite genera. The proof route is the adelic
volume formula for `SO(V)`. The Conway–Sloane mass formula paper is the source for the
normalization. The volume theorem of Orthogonal and Spin Groups Layer 5 differs from the strong
approximation theorem of its Layer 4. Strong approximation is an indefinite statement, and the
volume theorem is what a positive definite mass needs. Neither implies the other.

**7A. Proper mass and full mass.** The two sums are defined, and both are finite. The
relation between them is proved, and not assumed. A class either stays one proper class,
in which case `|O(M)| = 2|SO(M)|`, or splits into two proper classes, in which case
`O(M) = SO(M)`. In both cases `m⁺ = 2m`.

There is no product formula for the mass of a direct sum, and that non-statement is
recorded. The mass of a twist `L(a)` is stated for `a > 0` only.

**7B. The adelic decomposition.** The inputs are the measure and the volume theorem of
Orthogonal and Spin Groups Layer 5, and the dictionary of 4B. The quotient
`SO(V)(ℚ) \ SO(V)(𝔸)` is decomposed into measurable pieces, indexed by the proper classes.
The piece of the class of `M` has volume

    vol(K_∞) / |SO(M)| · ∏_p vol(K_p⁺(M)).

Every quotient and stabilizer in that formula is named.

**7C. Local densities at odd primes.** The local representation density and the local
automorphism density, in the Conway–Sloane normalization. This milestone asks for:

- the normalized congruence counts mod `p^r`;
- existence and stabilization of the limit;
- invariance under a change of basis;
- dependence only on the local isometry class;
- the identification with the Haar volume of `K_p⁺(L)`;
- the standard factor for `p ∤ 2 det L`;
- the reduction of the product to Euler factors and finitely many corrections;
- convergence of the product.

The formula is proved from the Jordan decomposition of 3C.

**7D. The local density at 2.** The dyadic density is a separate milestone with its own
inputs:

- the theorem of Cho that is used, stated in full;
- the smoothened model of the integral automorphism group that it needs;
- the proof that Cho's normalization agrees with the Conway–Sloane factor;
- bound and free constituents, and the convention in dimension 0.

The Conway–Sloane dyadic tables are data, and not a proof.

**7E. The archimedean factor.** The real normalization, and the volume of the compact
orthogonal group of a positive definite space. The route is fixed: identify
`SO(n)/SO(n−1)` with the unit sphere, compute recursively from the sphere volumes, and
derive the product of Gamma values. Compatibility with the global measure is proved. The
final statement displays the factor with every power of `π` and 2.

**7F. The volume theorem, consumed.** `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2`, with the dimension
hypotheses and the normalization of the supplier, and with the low-dimensional exceptions
recorded.

**7G. Low rank.** Rank 0 has mass 1. Rank 1 has mass 1/2. Rank 2 is computed through the
norm-one torus of the associated quadratic order, with its own local and global
normalization. Rank 2 is not a special case of the general derivation.

**7H. The Conway–Sloane formula and its checks.** The formula

    m(f) = 2 π^{−n(n+1)/4} ∏_{j=1}^{n} Γ(j/2) ∏_p 2 m_p(f)

with the dimension guard, together with the dictionary to Siegel's local density notation
`α_p`. Then the checks:

- the rank-8 even unimodular genus has mass `1/696729600`, class number 1, and
  `|O(E₈)| = |W(E₈)| = 696729600`;
- the genus of `A₂` has class number 1;
- in rank 16, `1/|O(E₈²)| + 1/|O(D₁₆⁺)| = m₁₆`.

The rank-16 equality discharges 6D only after 7B, 7C, 7D, 7E, 7F and both automorphism
orders are proved. Before that it is a numerical check.

| Milestone | Direct prerequisites |
| --- | --- |
| 7A | L 2C, 4A, 4E |
| 7B | L 4B, 7A; R Orthogonal and Spin Groups Layers 3 and 5 |
| 7C | L 3B, 3C, 4B |
| 7D | L 3D, 3E, 4B |
| 7E | M `Real.Gamma`, sphere volumes; L 2D |
| 7F | R Orthogonal and Spin Groups Layer 5 |
| 7G | L 7A, 7C, 7E; R Quadratic Form Invariants Layer 1 |
| 7H | L 2C, 6C, 6D, 7B, 7C, 7D, 7E, 7F, 7G; R Root Systems Layer 5 |

### Layer 8: theta series

**8A. The two levels of theta.** The analytic theta takes a lattice in a real inner product
space and a positive definite real quadratic form, and assumes no integrality. The
arithmetic theta of this layer is a wrapper: realize a positive definite `(L, β)` as such a
lattice, and define `Θ_L` as the analytic theta of that realization. The definition does
not depend on the realization. The dual lattice `L^⋆` carries a rational-valued form, so
`Θ_{L^⋆}` is an instance of the analytic theta and not of the arithmetic one.

**8B. Convergence and the q-expansion.** `Θ_L(τ) = ∑_{x ∈ L} exp(πiτ·β(x,x))` converges
absolutely and locally uniformly on the upper half-plane, for positive definite `L`. Its
expansion is `Θ_L = ∑_k r_L(k) q^k` in `q = e^{πiτ}`, where `r_L(k)` are the shell counts
of 2B.

**8C. Sums, twists, and the rank-one case.** `Θ_{L⊕M} = Θ_L·Θ_M`. For `a > 0`,
`Θ_{L(a)}(τ) = Θ_L(aτ)`. `Θ_ℤ = jacobiTheta`, and `Θ_{Iₙ} = jacobiTheta^n`.

**8D. The dual lattice and the covolume.** The analytic dual of the realization of `L` is
the image of the dual lattice of 1B, so the two notions agree. For positive definite `L`,
`covolume(L) = Real.sqrt (det L)`.

**8E. The transformation law.** From the Gaussian theta transformation for real `t > 0`,
together with 8D and analytic continuation in `τ`,

    Θ_L(−1/τ) = (τ/i)^{n/2} (det L)^{−1/2} Θ_{L^⋆}(τ).

Both sides are holomorphic on the upper half-plane and agree on the positive imaginary
axis. The branch of `(τ/i)^{n/2}` and the square root are those fixed in the conventions.
For unimodular `L` this becomes `Θ_L(−1/τ) = (τ/i)^{n/2} Θ_L(τ)`.

| Milestone | Direct prerequisites |
| --- | --- |
| 8A | M `IsZLattice`, `EuclideanSpace`; L 0E, 2A |
| 8B | M `Mathlib/Algebra/Module/ZLattice/Summable.lean`; L 2B, 8A |
| 8C | M `jacobiTheta`; L 0A, 8B |
| 8D | M `ZLattice.covolume`; L 1B, 2D, 8A; R L-functions Layer 2 |
| 8E | L 8B, 8D; R L-functions Layer 2 |

### Layer 9: what the LMFDB lattice columns assert

**9A. The stored columns.** Take a stored record with Gram matrix `G` and label
`dim.det.level.class_number.index`. Then:

- the dimension is the rank of 0A;
- the determinant is that of 0C;
- the level is that of 0D;
- the minimum and the kissing number are those of 2B;
- the automorphism group order is that of 2C;
- the theta coefficients are those of 8B;
- the class number is the number of classes in the genus, by 4A and 4E.

The stored genus representatives are pairwise non-isometric lattices of one genus, by 3F.
The statement that they exhaust the genus is the class-number statement. A mass certificate
from 7H is one way to prove it for a given genus. The fifth label component has no
mathematical content in this roadmap.

| Milestone | Direct prerequisites |
| --- | --- |
| 9A | L 0A, 0C, 0D, 2B, 2C, 3F, 4A, 4E, 7H, 8B |

---

## Basic API for each new object

A definition without lemmas is not a contribution. For each object below the roadmap asks
for the eight items listed. The layer that introduces the object owns them.

### The lattice form (0A)

- **Constructors.** From a symmetric bilinear form; from a Gram matrix over `ℤ`; from a
  quadratic form, when the lattice is even; by restriction to a submodule.
- **Examples.** `⟨a⟩`, `Iₙ`, `U`, the root lattices, `Λ_{K3}` (0G).
- **Morphisms.** Isometries, isometric embeddings, and primitive embeddings (5F).
- **Functoriality.** Direct sums, twists, sublattices of finite index, and orthogonal
  complements.
- **Comparison lemmas.** The Gram matrix in a basis; the real form; the rational form; the
  `ℤ_p`-form.
- **Naturality.** An isometry induces equality of determinant, signature, level, scale and
  norm ideal.
- **Edge cases.** Rank 0; degenerate forms; the zero form.
- **Downstream.** Every later layer.

### The dual lattice (1B)

- **Constructors.** `B.dualSubmodule L` in `V = ℚ ⊗ L`; the dual basis of a basis.
- **Examples.** `L^⋆ = L` for unimodular `L`; `(Aₙ)^⋆/Aₙ ≅ ℤ/(n+1)`.
- **Morphisms.** An isometry of `L` induces an isometry of `L^⋆`.
- **Functoriality.** `(L ⊕ M)^⋆ = L^⋆ ⊕ M^⋆`; `(L(a))^⋆ = (L^⋆)(a⁻¹)` for `a ≠ 0`;
  inclusion reversal.
- **Comparison lemmas.** The Gram matrix of the dual basis is `G⁻¹`;
  `det L^⋆ = (det L)⁻¹`; the analytic dual of the realization is the same submodule (8D).
- **Naturality.** Biduality `L^{⋆⋆} = L`, and its compatibility with sums and twists.
- **Edge cases.** Degenerate `β`, where the dual is not a lattice; rank 0.
- **Downstream.** 1C, 1D, 5G, 8D.

### The discriminant group and its forms (1C, 1D)

- **Constructors.** `A_L = L^⋆/L`; `b_L` from `B`; `q_L` from `B` when `L` is even.
- **Examples.** `A_{E₈} = 0`; `A_{A₂} ≅ ℤ/3` with `q = 2/3`; `A_U = 0`.
- **Morphisms.** `O(L) → O(q_L)`, whose surjectivity is 5E.
- **Functoriality.** Sums and twists, as canonical isometries and not equalities (1D).
- **Comparison lemmas.** `#A_L = |det L|`; `l(A_L) ≤ rank L`; the polarization of `q_L` is
  `b_L`; the invariant-factor description.
- **Naturality.** An isometry of lattices induces an isometry of discriminant forms, and
  this assignment respects composition.
- **Edge cases.** Unimodular `L`, where `A_L = 0`; odd `L`, which has no `q_L`; rank 0.
- **Downstream.** 1E, 1F, 5A to 5J, 6A.

### Finite quadratic forms (1G)

- **Constructors.** From `(A, q)` with the two axioms; the generators `q_θ^{(p)}(p^k)`,
  `u^{(2)}(2^k)`, `v^{(2)}(2^k)`; the discriminant form of an even lattice.
- **Examples.** The forms listed for the standard lattices above.
- **Morphisms.** Isometries, and the group `O(q)`.
- **Functoriality.** Orthogonal sums; the `p`-primary decomposition; restriction to a
  subgroup; the quotient `H^⊥/H` for isotropic `H`.
- **Comparison lemmas.** The relations among generators (Nikulin 1.8.2); the Gauss-sum
  invariant of each generator (1H).
- **Naturality.** `sign` is additive over sums and invariant under isometry.
- **Edge cases.** The trivial group; degenerate forms, which are excluded by hypothesis.
- **Downstream.** 1H, 3E, 5A to 5J.

### Lattices over `ℤ_p` and their Jordan data (3A, 3B)

- **Constructors.** `L_p = ℤ_p ⊗ L`; a Jordan splitting; a Gram matrix over `ℤ_p`.
- **Examples.** Unimodular `ℤ_p`-lattices at odd `p`; `U` over `ℤ_2`.
- **Morphisms.** Isometries over `ℤ_p`, and base change from `ℤ`.
- **Functoriality.** Sums, twists, and scaling by `p^i`.
- **Comparison lemmas.** The Jordan invariants at odd `p` are unique (3C); at `p = 2` the
  splitting is not unique and the symbols of 3E replace it.
- **Naturality.** Localization commutes with sums and twists.
- **Edge cases.** `p = 2`; rank 0; a scale-zero constituent.
- **Downstream.** 3C to 3H, 4C, 7C, 7D.

### Genus symbols (3E, 3G)

- **Constructors.** From a Jordan splitting; from a Gram matrix by an algorithm.
- **Examples.** The symbols of `A₂`, `U`, `E₈`, and one rank-4 lattice with a nontrivial
  2-adic part.
- **Morphisms.** The moves: sign walking and oddity fusion.
- **Functoriality.** The symbol of a direct sum, and of a twist.
- **Comparison lemmas.** Two symbols describe isometric lattices exactly when the moves
  relate them; the symbol determines the genus; the translation to `(t₊, t₋, q)` (5A).
- **Naturality.** The symbol depends only on the isometry class of `L_p`.
- **Edge cases.** `p = 2`; determinant `±1`, where the symbol is empty; rank 0.
- **Downstream.** 3F, 3G, 5A, 7C, 7D, 9A.

### Class, genus and spinor genus (4A, 4C)

- **Constructors.** `cls L`, `cls⁺ L`, `gen L`, `spn L`, `spn⁺ L`.
- **Examples.** Genera of class number 1; the rank-16 genus with two classes (6D).
- **Morphisms.** The inclusions between the five sets, and the double-coset description
  (4B).
- **Functoriality.** Behavior under twists, and under orthogonal sums where it is defined.
- **Comparison lemmas.** The count of proper spinor genera (4C); Eichler's theorem (4D).
- **Naturality.** The double-coset description is compatible with a change of the base
  lattice inside a genus.
- **Edge cases.** Rank 0, 1 and 2; definite and indefinite.
- **Downstream.** 4E to 4G, 7A, 7B, 9A.

### The mass (7A)

- **Constructors.** `m(gen L)` and `m⁺(gen L)`.
- **Examples.** Rank 0 gives 1, rank 1 gives 1/2, and the rank-8 even unimodular genus
  gives `1/696729600` (7H).
- **Morphisms.** None: the mass is a rational number attached to a genus.
- **Functoriality.** Behavior under a positive twist. There is no formula for a direct sum,
  and that non-statement is recorded.
- **Comparison lemmas.** `m⁺ = 2m`; the local factors of 7C and 7D; the dictionary to
  Siegel's `α_p` (7H).
- **Naturality.** The mass depends only on the genus.
- **Edge cases.** Ranks 0, 1 and 2 (7G).
- **Downstream.** 6D, 9A.

### The theta series (8B)

- **Constructors.** `Θ_L` for positive definite `L`, through the realization of 8A.
- **Examples.** `Θ_ℤ = jacobiTheta`; `Θ_{Iₙ}`; `Θ_{E₈}` with `r_{E₈}(2) = 240`.
- **Morphisms.** None on `Θ_L` itself. An isometry gives equality of theta series.
- **Functoriality.** `Θ_{L⊕M} = Θ_L·Θ_M`, and `Θ_{L(a)}(τ) = Θ_L(aτ)` for `a > 0`.
- **Comparison lemmas.** The q-expansion with the shell counts; the transformation law
  (8E).
- **Naturality.** Independence of the chosen realization (8A).
- **Edge cases.** Rank 0, where `Θ_L = 1`; negative definite and indefinite lattices, which
  are excluded.
- **Downstream.** 9A.

## Hard theorems: source, hypotheses, and a nearby false statement

| Theorem | Source | Hypotheses that carry the proof | A nearby false statement |
| --- | --- | --- | --- |
| Unimodular splitting (0F) | O'Meara §82 | the restriction of `β` to `M` is unimodular | "a nondegenerate restriction splits". Take `L = ℤ` with `β(x,y) = xy` and `M = 2ℤ`. Then `β|_M` is nondegenerate, `M^⊥ = 0`, and `M ⊕ M^⊥ ≠ L`. |
| Cancellation over `ℤ` (0F) | Milnor–Husemoller II §5; Serre V.2.2 | none: the statement is false | "`L ⊕ N ≅ M ⊕ N` implies `L ≅ M`". Take `N = U`, `L = E₈²`, `M = D₁₆⁺`. Both sums are even unimodular of signature `(17,1)`, hence isometric, while `E₈² ≇ D₁₆⁺`. |
| Milgram's theorem (1I) | Nikulin Thm 1.3.3; Milnor–Husemoller App. 4 | `L` is even and nondegenerate | "every unimodular lattice has `8 ∣ t₊ − t₋`". The odd lattice `⟨1⟩` is unimodular with `t₊ − t₋ = 1`. |
| Finiteness of `O(L)` (2C) | O'Meara §102 | `L` is definite | "`O(L)` is finite for every nondegenerate `L`". `O(⟨1,−2⟩)` is infinite, being the unit group of `ℤ[√2]` (2H), and 4F gives infinitude in every indefinite rank at least 3. |
| Diagonalization over `ℤ_p` (3C) | O'Meara 92:1 | `p` is odd | "every symmetric form over `ℤ_2` has an orthogonal basis". The hyperbolic plane `U` has none. |
| Two unimodular classes per rank (3C) | O'Meara 92:1a | `p` odd and rank at least 1 | "exactly two for every rank". In rank 0 there is one. |
| Uniqueness of Jordan invariants (3C) | O'Meara 91:9 | `p` is odd | "Jordan invariants are unique for every `p`". At `p = 2` they are not, which is why 3E states the moves. |
| Existence of an even lattice (5B) | Nikulin Thm 1.10.1 | conditions 3 and 4 apply exactly when `t₊ + t₋ = l(A_{q_p})` | "conditions 1 and 2 suffice". They suffice only under the strict inequality `t₊ + t₋ > l(A_q)`, which is Corollary 1.10.2. |
| Uniqueness in a genus (5C) | Nikulin Thm 1.13.2 | `t₊ ≥ 1` and `t₋ ≥ 1`, so `L` is indefinite | "the invariants `(t₊, t₋, q)` determine the isometry class". `E₈²` and `D₁₆⁺` share all three and are not isometric. |
| Surjectivity of `O(T) → O(q_T)` (5E) | Nikulin Thm 1.14.2 | `T` indefinite, and the two rank conditions | "the map is always surjective". It can fail for definite lattices, where the genus can have several classes. |
| Eichler's theorem (4D) | O'Meara 104:5 | indefinite, and rank at least 3 | "every indefinite lattice satisfies `cls⁺ = spn⁺`". Rank 2 is excluded, and 4E proves that case by a different argument. |
| Strong approximation for `Spin` (consumed) | O'Meara 104:4 | dimension at least 3, and a noncompact place | "it also proves the Tamagawa volume theorem". It does not: 7F consumes a separate theorem. |
| The mass formula (7H) | Conway–Sloane, eq. (2) | rank at least 2, in the stated normalization | "the formula holds in every rank". In rank at most 1 a factor 2 becomes 1, and `m` is 1/2 in rank 1 and 1 in rank 0. |
| The local density at 2 (7D) | Cho, Compositio 151 (2015) | residue characteristic 2, with the smoothened model | "the Conway–Sloane dyadic table proves it". The table is stated there without proof. |
| Classification in rank at most 9 (6C) | O'Meara 106:13 | rank at most 9, positive definite | "a positive definite unimodular lattice is determined by its rank and parity". Rank 16 has two even classes (6D). |
| Theta convergence (8B) | Poisson summation; `ZLattice` summability | `L` is positive definite | "the theta series of a definite lattice converges". For a negative definite lattice the terms are unbounded. |

## Worked examples

Each example is discharged with the milestone that owns it. Each one catches a wrong
factor of 2, a wrong sign, or a vacuous definition.

- `⟨1⟩ = ℤ`: odd, unimodular, and `Θ_ℤ = jacobiTheta` (0G, 8C).
- `U`: even, `det = −1`, signature `(1,1)`, level 1, `A_U = 0`, and not diagonalizable over
  `ℤ_2` (0G, 3D).
- `A₂`: even, `det = 3`, level 3, and `A_{A₂} ≅ ℤ/3` with `q = 2/3` in `ℚ/2ℤ`. Its 3-adic
  Jordan splitting has two rank-one constituents, of scales 1 and 3. Equality holds in
  Hermite's bound, and the class number is 1 (0G, 1D, 2E, 3B, 4A).
- The family `Aₙ`: `det(Aₙ) = n+1` and `A_{Aₙ} ≅ ℤ/(n+1)` (0G, 1C).
- `E₈`: even, unimodular, positive definite, `min = 2`, 240 minimal vectors, signature
  `(8,0)`, `sign q_{E₈} = 0`, unique in rank 8, `|O(E₈)| = 696729600`, and mass
  `1/696729600` (0G, 2B, 2C, 6C, 7H).
- Even unimodular lattices have `8 ∣ t₊ − t₋`, so no even unimodular positive definite
  lattice has rank 1 to 7 (1I, 6B).
- Rank 16: `E₈²` and `D₁₆⁺` lie in one genus, are not isometric, and exhaust the genus
  (6D, 7H).
- `Λ_{K3} = U³ ⊕ E₈(−1)²`: even, unimodular, signature `(3,19)`, `det = −1`, and unique
  with that signature. For `d > 0` the lattice `⟨2d⟩` embeds primitively, and uniquely up
  to `O(Λ_{K3})`. Every even lattice of signature `(1, ρ−1)` with `ρ ≤ 10` embeds
  primitively (5G, 5H, 6A).
- One LMFDB record checked end to end: `A₂`, and one rank-4 lattice with a nontrivial
  2-adic symbol (9A).
- Mass conventions: rank 0 gives 1, and the genus of `⟨a⟩` gives 1/2 (7G).

## Ordering and parallelism

Layer 0 comes first. After it, three groups of milestones are independent of each other:

- Layer 2, which needs no dual lattice;
- Layer 1;
- milestones 3A to 3E.

The rest of the order follows the prerequisite tables:

- milestones 3F to 3H need Layer 1 and the two suppliers named in their table;
- Layer 4 needs Layers 2 and 3, and the Orthogonal and Spin Groups roadmap;
- Layer 5 needs Layers 1 and 3;
- Layer 6 needs Layers 1, 2 and 5, and milestone 6C also needs Root Systems;
- Layer 7 needs Layers 2, 3 and 4, the volume theorem, and Layer 6 for its checks;
- milestones 8A to 8C need Layers 0 to 2, and 8D and 8E also need L-functions Layer 2;
- Layer 9 comes last.

The shortest route to the K3 results is `0 → 1 → 5`, together with the comparison 5A. That
route uses no milestone of Layers 2, 4, 6, 7 or 8.

## References

- J. H. Conway, N. J. A. Sloane, *Low-dimensional lattices. IV. The mass formula*, Proc. R.
  Soc. Lond. A 419 (1988) 259–285. This is the source for Layer 7:
  - equation (1) for the mass, and equations (2) and (3) for the formula;
  - section 5 for the species and octane tables;
  - equations (6) to (9), (13), (15) and (16) for the standard mass;
  - sections 3 and 6 for the dimension guard;
  - section 12 for the dictionary to Siegel's densities.
- S. Cho, *Group schemes and local densities of quadratic lattices in residue characteristic
  2*, Compositio Math. 151 (2015) 793–827. The proof of the dyadic local density formula
  used in 7D.
- D. Allcock, I. Gal, A. Mark, *The Conway–Sloane calculus for 2-adic lattices*,
  arXiv:1511.04614. The proof of the symbol calculus and the corrected canonical form, used
  in 3E.
- V. V. Nikulin, *Integer symmetric bilinear forms and some of their geometric
  applications*, Izv. Akad. Nauk SSSR 43 (1979) 111–177; translation Math. USSR-Izv. 14
  (1980) 103–167. Source for Layers 1 and 5: Theorem 1.3.3 (1I); Propositions 1.8.1 and
  1.8.2 (1G); Proposition 1.11.2 and Theorem 1.11.3 (1H); Corollary 1.9.4 (5A); Theorem
  1.10.1 and Corollary 1.10.2 (5B); Theorems 1.13.1 and 1.13.2 with Corollary 1.13.3 (5C);
  Corollaries 1.13.4 and 1.13.5 (5D); Proposition 1.14.1 and Theorem 1.14.2 (5E); Theorems
  1.12.2 and 1.12.4 with Corollary 1.12.3 (5G); Theorem 1.14.4 (5H); Proposition 1.15.1 and
  Corollary 1.15.2 (5I); Theorems 3.6.2 and 3.6.3 (5J).
- O. T. O'Meara, *Introduction to Quadratic Forms*, Grundlehren 117, Springer (1963). This
  is the source for Layers 0, 3, 4 and 6:
  - section 82E (0D);
  - section 91C with 91:9 (3B, 3C), and 92:1 to 92:2 (3C);
  - sections 93A and 93E with 93:16, 93:28 and 93:29 (3D);
  - section 102A with 102:7 (4A, 4C);
  - 103:4 (2G, 4E), and 104:5 (4D);
  - 105:1 and 106:13 (6C), and 106:1 (6B).
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter V. Source for 1I,
  6A and 7H: V.1.3.5, V.1.4.3, V.2 Theorem 2 with Corollary 1, V.2.2, and V.2.3. The
  uniqueness of `E₈` is derived there from a mass formula that the chapter does not prove,
  so 6C uses O'Meara's proof instead.
- J. Milnor, D. Husemoller, *Symmetric Bilinear Forms*, Ergebnisse 73, Springer (1973).
  Chapter II for 6A, and Appendix 4 for 1H and 1I.
- J. H. Conway, N. J. A. Sloane, *Sphere Packings, Lattices and Groups*, 3rd ed.,
  Grundlehren 290, Springer (1999):
  - Chapter 2 for theta series, and Chapter 4 for root lattices and the `Dₙ⁺`
    constructions;
  - Chapter 15 for genus symbols, with the correction cited above;
  - Chapter 16 for unimodular masses;
  - Chapters 17 and 18 for Niemeier lattices, and Chapters 26 and 27 for the Leech
    lattice.
- J. W. S. Cassels, *Rational Quadratic Forms*, Academic Press (1978). Chapters 8 and 9 for
  Layer 3, Chapters 10 and 11 for Layer 4, and Chapter 13 for the binary theory used in 4E.
- W. Ebeling, *Lattices and Codes*, 3rd ed., Springer (2013). Discriminant forms, the
  classification in rank at most 24, and Niemeier lattices through glue codes.
- Y. Kitaoka, *Arithmetic of Quadratic Forms*, Cambridge Tracts 106, CUP (1993). The
  Minkowski–Siegel apparatus for Layer 7, and theta background for Layer 8.
- M. Kneser, *Quadratische Formen*, revised with R. Scharlau, Springer (2002). Neighbors and
  class numbers for Layer 4.
- J. Voight, *Kneser's method of neighbors*, arXiv:2308.11566. An algorithmic reference for
  4G.
- G. Chenevier, J. Lannes, *Automorphic Forms and Even Unimodular Lattices*, Ergebnisse 69,
  Springer (2019). Background for 6E.
- T. Kirschmer, *Definite quadratic and hermitian forms with small class number*,
  Habilitation, RWTH Aachen (2016). Tables of one-class genera and masses, used to validate
  9A.
