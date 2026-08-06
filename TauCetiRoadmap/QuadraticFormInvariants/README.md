# Roadmap: quadratic forms and cohomological invariants

Mathlib has the *linear algebra* of quadratic forms in real depth: `QuadraticMap` /
`QuadraticForm`, polar forms, orthogonal bases and diagonalization
(`QuadraticForm.equivalent_weightedSumSquares`), `Anisotropic`, the radical and the
EKM-style `QuadraticMap.Nondegenerate`, isometries and `Equivalent`, tensor products,
the real/complex/algebraically-closed classifications, and a full Clifford-algebra
directory. It also has quaternion algebras `ℍ[R,c₁,c₂,c₃]` with conjugation and the
`QuaternionAlgebra.Basis` universal property, and the rank-2 `QuadraticAlgebra R a b`
with its norm. What it has **none** of is the arithmetic theory of quadratic forms over
a field: no hyperbolic-plane theory, no Witt decomposition or Witt cancellation, no
Witt ring, no Pfister forms, no discriminant-and-Hasse-invariant classification, no
Hilbert symbol, no transfer of forms along a field extension, and no Stiefel–Whitney
classes (verified at the pin and on master, 2026-08-06; no open PRs state any of
them). This roadmap builds that arithmetic theory over fields with `2` invertible,
through its classical high points: the four-fold splitting criterion for quaternion
algebras, the complete classification of forms over finite extensions of `ℚ_p` by
`(dim, d, s)`, and Kahn's relative Stiefel–Whitney formula for transferred forms. Its
last three layers put those invariants into mod-2 Galois cohomology.

Suggested homes, mirroring Mathlib's directory conventions:
- `TauCeti/LinearAlgebra/QuadraticForm/` for Witt theory, Pfister forms, the classical
  invariants at the form level, and the Scharlau transfer (Mathlib keeps
  `QuadraticForm` under `LinearAlgebra/`, so the form theory stays there);
- `TauCeti/Algebra/Quaternion/` for the quaternion symbol layer and its Brauer-class
  packaging (Mathlib's quaternion and Brauer material lives under `Algebra/`);
- `TauCeti/NumberTheory/Padics/QuadraticForm/` for the Hilbert symbol and the local
  classification, next to Mathlib's `NumberTheory/Padics/`; statements over a general
  finite extension of `ℚ_p` move to the home the
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) fixes;
- `TauCeti/FieldTheory/QuadraticForm/` for the cohomological layers (the Brauer
  comparison, Stiefel–Whitney classes, Evens–Kahn), next to the landed
  `TauCeti/FieldTheory/SquareClassGroup.lean` they consume, coordinated with the
  home [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  fixes for `H^*(G_K, 𝔽₂)`.

**Scope exclusions** (choices, not omissions; separate future roadmaps are welcome):
the characteristic-2 theory of quadratic and bilinear forms (Arf invariant,
quasilinear forms; Grove's chapters on characteristic 2 and EKM Part II document how
different that theory is, and everything here assumes `2` invertible); the deep theory
of Pfister forms (function-field methods, the Arason–Pfister Hauptsatz, the Milnor
conjecture and the norm-residue theorem, and any classification statement resting on
them); and the cohomological invariant theory of Garibaldi–Merkurjev–Serre beyond
Stiefel–Whitney classes. Pfister forms are defined here in every degree, and the
elementary generation statements for `I`, `I²`, and `I³` are proved because Layer 5's
kernel computation needs them (see Layer 4); nothing past that is claimed.

## Standing hypotheses and pinned conventions

Decide these once; every layer states its results against this table.

- **Base field.** `K` a field with `[Invertible (2 : K)]`. This is the hypothesis
  Mathlib's own quadratic-form theory uses (`QuadraticForm/Basis.lean`,
  `AlgClosed.lean`, the `associated` bilinear form), so we follow it rather than
  `[NeZero (2 : K)]`; over a field the two are interderivable, and where a layer
  meets the multiquadratic roadmap's material (stated with `[NeZero (2 : K)]` or
  `[CharZero K]`) the conversion is part of the interop, not a fork.
- **Forms and regularity.** A form is a `QuadraticForm K V` (`= QuadraticMap K V K`)
  with `[FiniteDimensional K V]` where finiteness is needed, carried as an
  instance, never bundled. Regularity is `QuadraticMap.Nondegenerate Q` (Mathlib's
  EKM-style predicate, `QuadraticForm/Radical.lean`), converted through
  `nondegenerate_associated_iff` / `(QuadraticMap.associated Q).SeparatingLeft`
  when a proof wants the bilinear form (that is the hypothesis Mathlib's
  `equivalent_weightedSumSquares_units_of_nondegenerate'` takes). Anisotropy is
  `QuadraticMap.Anisotropic`; "isotropic" in prose always means
  `¬ Q.Anisotropic` on a nonzero space, never a new predicate.
- **Equivalence and diagonal forms.** Isometry classes via `QuadraticMap.Equivalent`
  (`Nonempty (Q₁.IsometryEquiv Q₂)`, which already compares forms on different
  spaces). The diagonal form `⟨a₁, …, aₙ⟩` is `QuadraticMap.weightedSumSquares K w`
  with `w : Fin n → K`, unit-valued (`w : Fin n → Kˣ`, coerced) whenever the form is
  regular. Orthogonal sum of forms on different spaces is `QuadraticMap.prod`;
  scaling is `a • Q`.
- **Square classes.** The square-class group is `Kˣ ⧸ Subgroup.square Kˣ`,
  interoperating with the landed `TauCeti.SquareClassGroup`
  (`= Additive Kˣ ⧸ (Subgroup.square Kˣ).toAddSubgroup`, an `𝔽₂ = ZMod 2`-vector
  space). Consume it, do not redefine it. In quotient-free statements "same square
  class" is spelled `IsSquare (a * b)` for units `a b : Kˣ` (as in
  `TauCeti.squareClass_eq_zero_iff`), matching the multiquadratic roadmap's
  `Finset`-product idiom.
- **Representation and value sets.** `Represents Q a : Prop` is `∃ v, Q v = a` for
  `a : K`, and `unitValueSet Q : Set Kˣ` is `{a : Kˣ | Represents Q (a : K)}`, the
  classical `D(q)` of nonzero represented values. The two are kept apart on purpose:
  every classification statement below means `D(q)`, and a value set that contains
  `0` would silently make several of them false.
- **Discriminant and signed discriminant.** For `q ≅ ⟨a₁, …, aₙ⟩`, the
  *discriminant* is `d(q) = a₁ ⋯ aₙ` in `Kˣ ⧸ (Kˣ)²` and the **signed
  discriminant** is `d±(q) = (−1)^{n(n−1)/2} · d(q)`. Two distinct names, never an
  overloaded one: `discr` and `signedDiscr`. Serre's classification invariant and
  the Stiefel–Whitney class `w₁` see the *plain* `d`; the Witt-ring isomorphism
  `I/I² ≅ Kˣ/(Kˣ)²` and the quadratic-extension dictionary see `d±`. The
  translation `d± = (−1)^{n(n−1)/2} d` is a stated lemma
  (`signedDiscr_eq_sign_mul_discr`), not folklore, and every conversion in a later
  proof goes through it.
- **The symbol is a quaternion algebra first, a group element later.** For
  `a, b ∈ Kˣ`, the symbol `(a, b)` names the quaternion algebra `ℍ[K, a, b]`
  (Mathlib's two-parameter notation for `QuaternionAlgebra K a 0 b`: `i² = a`,
  `j² = b`, `ij = −ji = k`; see `Mathlib/Algebra/Quaternion.lean`). Through Layer 4
  it is an algebra up to isomorphism and nothing more: "`(a,b) = (c,d)`" is spelled
  `Nonempty (ℍ[K,a,b] ≃ₐ[K] ℍ[K,c,d])` and "`(a,b) = 1`" is
  `Nonempty (ℍ[K,a,b] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K)`. Only in Layer 5, once
  `BrauerGroup K` is a group, does `[(a,b)]` become an element that can be
  multiplied; only in Layer 6 does the local symbol `(a,b)_K` take values in `{±1}`.
  No layer multiplies symbols before the layer that supplies the multiplication.
- **Two Hasse invariants, both named.** `s(q) = ∏_{i<j} (aᵢ, aⱼ)` for
  `q ≅ ⟨a₁, …, aₙ⟩` (empty product for `n ≤ 1`) is the **Lam/Serre convention**
  (Lam V.3.17; Serre's `ε` in *A Course in Arithmetic* IV.2.1). It occurs twice in
  this roadmap with two different codomains, and the names differ accordingly:
  `hasseInvariant q : BrauerGroup K` in Layer 5, and
  `localHasse q : ℤˣ` over a finite extension of `ℚ_p` in Layer 6, built from the
  `{±1}`-valued Hilbert symbol without reference to Layer 5. The theorem that the
  second is the image of the first under `Br(K)[2] ≃ ℤˣ` is stated in Layer 6 and
  used nowhere before it. Documented translations, each a stated lemma once its
  target exists: **O'Meara's Hasse symbol** (63:20 context) is
  `S(q) = ∏_{i≤j} (aᵢ, aⱼ) = s(q) · (d(q), −1)`; the **Witt/Clifford invariant**
  `c(q)` (the Brauer class of `C(q)` or `C₀(q)` by parity, Lam V.3.12) satisfies
  Lam V.3.20: `c = s · (−1, d)^{(n−1)(n−2)/2} · (−1,−1)^{(n+1)n(n−1)(n−2)/24}`,
  and `c = s · (−1,−1)^{m(m−1)/2}` on `I²` with `dim = 2m`. ⚠ Lam records that
  C. T. C. Wall's published version of this translation is **incorrect** (Lam,
  p. 120, "Caution"); do not import the formula from secondary sources, cite Lam
  and prove it once.
- **Hilbert symbol.** Over a finite extension `K/ℚ_p` (and over `ℝ`),
  `(a,b)_K = +1` if `b = x² − a y²` has a solution `x, y ∈ K`, and `−1` otherwise.
  This is a definition, not a consequence of any classification: it needs only the
  norm equation. It agrees with Serre's solvability form (`z² − ax² − by² = 0` has a
  nontrivial zero, *A Course in Arithmetic* III.1.1) and with the norm criterion
  `b ∈ N(K(√a)ˣ)`; the equivalence of the three is the first milestone of Layer 6,
  and symmetry `(a,b)_K = (b,a)_K` is the second, so that the Serre orientation
  (`(a,b) = 1` iff `a ∈ N(K(√b)/K)`) and the one used by `gq2`'s B11a are
  interchangeable from then on. Values live in `ℤˣ = {±1}`; the additive avatar is
  `ZMod 2` via the unique isomorphism, and the cohomological avatar is
  `μ₂ ≃ ZMod 2` (Layer 7). One **value dictionary** file states these once, and
  every later statement picks a side through it. The active Hasse–Minkowski project
  (see "in motion" below) uses an integer-valued `hilbertSym : k → k → ℤ` that is
  `0` on zero arguments; ours is total on `Kˣ × Kˣ`, where no such convention is
  needed, and the comparison lemma to their junk-value convention is part of the
  coordination, not a redesign.
- **Steinberg hypotheses.** Wherever `(a, 1−a)` or `(a) ∪ (1−a)` occurs, the
  statement carries `a : Kˣ` together with `h : (1 : K) − a ≠ 0`, so that `1 − a`
  has a unit coercion. Never `a : K` with the two exclusions left to the reader.
- **Pfister forms.** `⟨⟨a⟩⟩ = ⟨1, −a⟩` and `⟨⟨a, b⟩⟩ = ⟨1, −a⟩ ⊗ ⟨1, −b⟩ ≅
  ⟨1, −a, −b, ab⟩` (the minus-sign convention of Lam Ch. X and
  Elman–Karpenko–Merkurjev; some older sources use `⟨1, a⟩` factors, flag it).
  The `n`-fold `⟨⟨a₁, …, aₙ⟩⟩` is the `n`-fold tensor product, via Mathlib's
  `QuadraticForm` tensor product (`QuadraticForm/TensorProduct.lean`, which already
  carries the needed `Invertible (2 : R)`).
- **Transfer.** The Scharlau transfer `s_*(q)` of a form `q` over `L` along a
  **nonzero `K`-linear functional** `s : L →ₗ[K] K`, for `L/K` finite separable.
  The default functional is the trace `Algebra.trace K L`, written `Tr_*`; every
  theorem is stated for general nonzero `s` with the trace as the named instance.
  Two lemmas make "the" transfer honest and are early targets: the nonzero
  functionals form a single `Lˣ`-orbit (Layer 9), and
  `s'_*(q) ≅ s_*(⟨λ⟩ ⊗ q)` when `s' = s ∘ (λ·)`.
- **Cohomological dictionary** (Layers 7 to 9, consuming the profinite-cohomology
  roadmap): `H¹(G_K, μ₂) ≅ Kˣ/(Kˣ)²` (Kummer), the class of `a` written `(a)`; the
  identification of `Br(K)[2]` with `H²(G_K, μ₂)` is *proved* in Layer 7A and is
  never assumed before it; the total Stiefel–Whitney class of `q ≅ ⟨a₁, …, aₙ⟩` is
  `w(q) = ∏ᵢ (1 + (aᵢ))` (Delzant); `w₁(q) = (d(q))`, the **plain** discriminant,
  not `d±`.

### The carrier for isometry classes

Layers 3 to 5 all speak of functions on isometry classes, and Layer 4 needs a ring
whose elements are such classes. Quotienting the isometry relation over arbitrary
finite-dimensional spaces would force universe and bundling decisions on whoever
implements it first, so the choice is made here instead.

Work with diagonal presentations:

```lean
RegularFormPresentation K := Σ n : ℕ, Fin n → Kˣ
```

reading `(n, w)` as `weightedSumSquares K (fun i => (w i : K))`, and put two
presentations in relation when the forms they present are `QuadraticMap.Equivalent`
(a relation between forms on different spaces, so presentations of different lengths
may be related, and in fact only equal lengths ever are). Set

```lean
RegularFormClass K := Quotient (regularFormSetoid K)
```

The milestones this carrier owes the rest of the roadmap:

- every regular form on a finite-dimensional space has a class, by diagonalization
  (`equivalent_weightedSumSquares_units_of_nondegenerate'`), and the class does not
  depend on the diagonalization chosen;
- two regular forms are `Equivalent` iff their classes are equal;
- orthogonal sum and tensor product of presentations descend to `RegularFormClass K`,
  making it a commutative monoid under each, with the two distributing;
- dimension, `discr`, `signedDiscr`, and later `hasseInvariant` and `localHasse`
  descend to it, in each case by the descent principle of Layer 0;
- the Grothendieck–Witt ring is the Grothendieck group of `(RegularFormClass K, ⊥)`
  with the multiplication induced by `⊗`, and the Witt ring is its quotient by the
  ideal generated by the hyperbolic plane.

`QuadraticModuleCat` is the natural alternative and is acceptable as a replacement,
but only if the roadmap is edited to name it as the carrier and to say how the
universe of the underlying module is fixed; leaving the choice open is not.

## What Mathlib already has (consume)

All checked at the roadmap pin (`9caeba1000`, 2026-06-03) and rechecked on master.

- **Quadratic forms:** `Mathlib/LinearAlgebra/QuadraticForm/Basic.lean`
  (`QuadraticMap`, `QuadraticForm`, `polar`, `associated`, `Anisotropic`, `PosDef`,
  `weightedSumSquares`, `discr'` for forms on `n → R`, matrix representations);
  `Isometry.lean`, `IsometryEquiv.lean` (`Equivalent`,
  `equivalent_weightedSumSquares`, `equivalent_weightedSumSquares_units_of_nondegenerate'`;
  diagonalization is *done*, consume it); `Basis.lean` (`basisRepr`,
  `exists_orthogonal_basis`); `Prod.lean` (`QuadraticMap.prod`, orthogonal sums);
  `TensorProduct.lean` (tensor product of forms, with `Invertible (2 : R)`);
  `Radical.lean` (`QuadraticMap.radical`, `QuadraticMap.Nondegenerate`,
  `nondegenerate_associated_iff`); `Dual.lean`; `Real.lean`, `Complex.lean`,
  `Signature.lean`, `AlgClosed.lean` (the classifications over `ℝ`, `ℂ`,
  algebraically closed fields, the model for our local classification);
  `QuadraticModuleCat.lean`.
- **Bilinear forms:** `LinearMap.BilinForm.Nondegenerate`, `SeparatingLeft`,
  orthogonality (`Mathlib/LinearAlgebra/BilinearForm/*`, `SesquilinearForm/*`).
- **Quaternion algebras:** `Mathlib/Algebra/Quaternion.lean`, the Bourbaki
  three-parameter `QuaternionAlgebra R c₁ c₂ c₃` with notations `ℍ[R,c₁,c₂,c₃]`,
  `ℍ[R,c₁,c₂]` (`= ℍ[R,c₁,0,c₂]`), `ℍ[R]`; conjugation `star` **for the general
  algebra** with `mul_star_eq_coe : a * star a = ((a * star a).re : ℍ[…])`, so the
  scalarness of the norm is already there; but `normSq` (as a `MonoidHom`) and the
  `DivisionRing` instance exist **only for Hamilton's `ℍ[R]`**.
  `Mathlib/Algebra/QuaternionBasis.lean` has `QuaternionAlgebra.Basis` and
  `Basis.lift : Basis A c₁ c₂ c₃ ≃ (ℍ[R,c₁,c₂,c₃] →ₐ[R] A)`, the universal
  property our splitting arguments run through.
- **Rank-2 algebras:** `Mathlib/Algebra/QuadraticAlgebra/{Defs,Basic,NormDeterminant}.lean`
  (A. Chambert-Loir): `QuadraticAlgebra R a b` (`ω² = a + bω`), `star`,
  `norm : QuadraticAlgebra R a b →* R` with
  `norm z = z.re² + b·z.re·z.im − a·z.im²`, `isUnit_iff_norm_isUnit`, the `Field`
  instance when `X² − bX − a` has no root, and `norm = det` of multiplication.
  **`QuadraticAlgebra K a 0` is our vehicle for `K(√a)` and its norm form
  `x² − ay²`**; do not re-adjoin square roots where this algebra serves.
  `Mathlib/FieldTheory/KummerExtension.lean` and
  `TauCeti/FieldTheory/IntermediateField/Quadratic.lean` cover the
  intermediate-field picture when an ambient field is in play.
- **Central-simple and Brauer scaffolding** (for Layer 5): `Mathlib/Algebra/Central/*`
  (`Algebra.IsCentral`, `Algebra.IsCentralSimple`; J. Zhang),
  `Mathlib/Algebra/BrauerGroup/Defs.lean` (`CSA`, `IsBrauerEquivalent`,
  `BrauerGroup` as a `Quotient`, **not yet a group**; Y. Xie, J. Zhang),
  `Mathlib/Algebra/Azumaya/*` (`IsAzumaya`, `AlgHom.mulLeftRight`),
  `Mathlib/RingTheory/SimpleModule/WedderburnArtin.lean`, `SimpleRing/*`.
- **Clifford algebras:** `Mathlib/LinearAlgebra/CliffordAlgebra/*` (base change,
  grading, even subalgebra, equivalences with quaternion algebras in `Equivs.lean`).
  These supply constructions and equivalences, not the central-simplicity theorems
  Layer 5's `cliffordInvariant` needs; those are stated there as our own milestones.
- **Arithmetic fuel for examples:** `Mathlib/NumberTheory/Padics/*` (`ℚ_[p]`,
  `ℤ_[p]`, `PadicInt.toZModPow`, Hensel's lemma),
  `Mathlib/NumberTheory/LegendreSymbol/*` (`legendreSym`, `jacobiSym`, quadratic
  reciprocity, quadratic characters), `Mathlib/FieldTheory/Finite/*`.
- **Trace forms:** `Algebra.traceForm : BilinForm R S` with
  `Algebra.traceForm_nondegenerate` for finite separable extensions
  (`Mathlib/RingTheory/Trace/*`); Layer 9's `Tr_*⟨1⟩` starts here, and the
  quadratic form of a bilinear form is `LinearMap.BilinMap.toQuadraticMap`.
- **Discrete group cohomology** (background for Layers 7 to 9's *statements* only):
  `Mathlib/RepresentationTheory/Homological/GroupCohomology/{LowDegree,Hilbert90,Shapiro}.lean`.
  There is **no continuous cohomology at the pin** (master has
  `RepresentationTheory/Homological/ContCohomology/`); the profinite-cohomology
  roadmap owns that gap.

## What Tau Ceti already has (consume)

This is the first roadmap consuming landed Tau Ceti code; treat these files as
fixed API, cite them in the consuming files, and route improvements through their
own review rather than duplicating.

- **`TauCeti/FieldTheory/SquareClassGroup.lean`**: `TauCeti.SquareClassGroup K`
  (an `𝔽₂`-vector space), `squareClass`, `squareClass_eq_zero_iff`,
  `squareClass_prod`, and `linearIndependent_squareClass_iff` (linear independence
  = no nonempty subset product is a square). Layer 0's square-class calculus lands
  *next to this file*, extending it with the multiplicative avatar and the
  finiteness API rather than shadowing it.
- **`TauCeti/FieldTheory/IntermediateField/Quadratic.lean`**: quadratic normal
  forms `a + b√x`, `finrank_adjoin_simple_eq_two_of_sq_mem_notMem`,
  `isSquare_mul_of_adjoin_simple_eq`, the intermediate-field side of quadratic
  extensions, used when `K(√a)` must live inside a given ambient field.
- **`TauCeti/NumberTheory/Multiquadratic/SquareClass/{Basic,Independence}.lean`**:
  square-class descent in towers (`sqrtTower`, `squareClass_of_sq_mem`); the
  [multiquadratic roadmap](../Multiquadratic/README.md) owns multi-root towers, we
  own one quadratic step's *form theory*, and the shared language is the
  square-class group above.
- **`TauCeti/NumberTheory/LegendreSymbol/SquareClass.lean`**:
  `legendreSym_mul_sq` and friends, the radicand-normalization API our odd-residue
  Hilbert-symbol formula (Layer 6) reuses.
- **`TauCeti/NumberTheory/EffectiveBounds/TraceForm.lean`** and
  `TauCeti/FieldTheory/Trace`: trace-form diagonalization on square-root bases
  (`discr_one_elem_eq_of_sq_algebraMap`, trace-vanishing criterion). Layer 9's
  `Tr_*⟨1⟩ ≅ ⟨2, 2d⟩` for `K(√d)/K` is the form-level restatement; prove it
  through this API, do not re-derive the trace computations.

## What is already in motion elsewhere (cite, follow, do not duplicate)

- **Hasse–Minkowski and the Hilbert symbol:**
  [`mariainesdff/HassePrinciple`](https://github.com/mariainesdff/HassePrinciple)
  (N. Coppola, M. I. de Frutos-Fernández; Apache-2.0; checked at
  [`d2802ddce55e`](https://github.com/mariainesdff/HassePrinciple/commit/d2802ddce55ef34045f68c5bf39c0598e7d0e988),
  2026-07-27)
  formalizes the Hasse–Minkowski theorem over `ℚ` following Serre: an integer-valued
  `hilbertSym` on a general field (Serre's solvability definition), the `p = 2`
  `epsilon`/`omega` residues, `p`-adic squares (`Padics/Squares.lean`), Serre's
  contiguous-orthogonal-bases chain (`QuadraticForm/Chain.lean`, stated with
  `[Invertible (2 : k)]`), and the Hasse–Minkowski invariant with the rank-by-rank
  case analysis. **The coordination requirement in §Provenance must be met before
  Layer 6 borrows anything from them.** Their target is the global theorem over `ℚ`
  with `ForMathlib/` files headed upstream; ours is the general-field invariant
  theory, the local classification over *every* finite extension of `ℚ_p` including
  the dyadic ones, and the cohomological layers. Adopt their conventions where the
  objects coincide (Serre's solvability-valued symbol, the contiguity notion for
  chains), state the comparison lemmas to our `Kˣ × Kˣ` symbol, and flag every
  Layer 6 milestone that should be refactored onto their files when those land in
  Mathlib. (Prior art in the same direction: the 2023 Lorentz-Center workshop
  project on Hasse–Minkowski by A. Best, K. Buzzard, M. Streng, H. Wiersema, and
  R. Winter.)
- **Central simple algebras and the Brauer group:** in-tree scaffolding by
  Y. Xie and J. Zhang (above);
  [`Whysoserioushah/BrauerGroup`](https://github.com/Whysoserioushah/BrauerGroup)
  (Apache-2.0; checked at
  [`283e0df7dc15`](https://github.com/Whysoserioushah/BrauerGroup/commit/283e0df7dc15cd8b469a73fbc763f74637c87147),
  2026-07-16) stages the full program (Wedderburn, Skolem–Noether, double centralizer,
  splitting fields, the group structure, `Br(K) ≅ H²(Gal(K̄/K), K̄ˣ)`,
  `Br(ℝ)`, `Br(𝔽_q)`) with active upstreaming: open PR
  [#26377](https://github.com/leanprover-community/mathlib4/pull/26377) (open at
  `13cac7e3b9bb`, updated 2026-07-16) proves that the tensor product of a simple and
  a central simple algebra is simple, which is the Brauer-multiplication
  prerequisite. Note the ownership inside this family: general CSA and Brauer theory
  is the [semisimple-algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)'s,
  it has landed, and Layer 5 consumes its Layer 4 and Layer 6 milestones by name.
  Upstream Mathlib PRs are refactor triggers for that roadmap and for this one, not
  the only route by which either can be implemented.
- **Quaternion algebras as CSAs:** open PRs
  [#41536](https://github.com/leanprover-community/mathlib4/pull/41536) (open at
  `e95984de0341`, updated 2026-07-18; the quaternion directory split),
  [#41537](https://github.com/leanprover-community/mathlib4/pull/41537) (open at
  `40983fffa9aa`, updated 2026-07-09; two-sided ideal lemmas), and
  [#41538](https://github.com/leanprover-community/mathlib4/pull/41538)
  (Mathias-Stout, J. Springer; open at `86493005d20f`, updated 2026-07-17), which
  depends on both of the first two and proves that `ℍ[R,a,b,c]` over a field is
  central simple when `c·(b² + 4a) ≠ 0`, adding
  `Mathlib/Algebra/Quaternion/CentralSimple.lean`. Layer 5's central-simplicity
  milestone is written to consume #41538's statement if it has landed and to be
  proved here (upstream-compatibly) if it has not; either way the statement is
  required, because `[(a,b)] ∈ BrauerGroup K` does not exist without it. The FLT
  project carries `IsQuaternionAlgebra F D` (a 4-dimensional central simple algebra,
  K. Buzzard, `FLT/Mathlib/Algebra/IsQuaternionAlgebra.lean`, "material destined for
  Mathlib") together with the split-or-division dichotomy for it; Layer 2's abstract
  characterization milestone is stated so that it can be refactored onto that
  predicate when it reaches Mathlib.
- **Reduced norm and trace:** PR
  [#28970](https://github.com/leanprover-community/mathlib4/pull/28970) (open at
  `5a2bcb298759`, last updated 2025-11-19). **Informational only.** The quaternion
  norm form of Layer 2 is built by hand from `star` and `mul_star_eq_coe`, and no
  milestone in this roadmap uses a general reduced norm or trace, so nothing here
  waits on it.
- **Indefinite bilinear forms:** PR
  [#38194](https://github.com/leanprover-community/mathlib4/pull/38194) (indefinite
  metrics) touches real signature theory only; no conflict, noted for awareness.

## What is missing (build here)

Everything below the linear algebra: the **hyperbolic plane** as a studied object
and the isotropy-versus-splitting dichotomy; **Witt decomposition, cancellation, and
the Witt index**; **Witt's chain-equivalence theorem**, without which no
invariant of diagonal tuples is well defined on isometry classes; the **representation
predicate** and the value-set calculus; the **Witt ring** `W(K)`, the fundamental
ideal `I(K)`, and **Pfister forms**; the **quaternion symbol layer** with its norm
form, split-or-division dichotomy, and four-fold splitting criterion; the
**classical invariants** `dim mod 2`, `d`, `d±`; the **Brauer-valued Hasse and
Clifford invariants** and the dimension-≤-3 classification; the **Hilbert symbol**
over finite extensions of `ℚ_p` with the dyadic formulas, bimultiplicativity, and
nondegeneracy; the **complete local classification** by `(dim, d, s)` with
`u(K) = 4` and the unique anisotropic quaternary form; the **comparison of the
Brauer group with `H²`** and the identification of the quaternion class with a
Kummer cup product; **Stiefel–Whitney classes** of forms with the exact
`w₂`-versus-Clifford comparison; and the **Scharlau transfer** with **Kahn's
relative Stiefel–Whitney formula** (Evens–Kahn). None of this exists upstream as
stated; each object gets its complete basic theory, not only the milestone the
headline needs.

`Suggested.lean` pins Lean forms for the design decisions most likely to fork an
implementation, plus the worked examples. It is illustrative and not exhaustive:
the README is the definitive document. Brauer-valued and continuous-cohomology
signatures stay in prose there until the consumed types exist, with the supplier
named in the surrounding comment.

---

## The build, in layers

The order below is the dependency order. Layers 0 to 6 use no cohomology, and only
Layer 5 uses the Brauer group.

### Layer 0: square classes, diagonal calculus, and chain equivalence

- **Square-class interop.** Consume `TauCeti.SquareClassGroup`. Add what the
  invariants need: the multiplicative avatar `Kˣ ⧸ Subgroup.square Kˣ` with the
  `ZMod 2`-module dictionary to the landed additive one; pushforward along field
  maps; finiteness transfer (`Nat.card` API), which is the interface through which
  Layer 6 consumes the local counts.
- **Representation and value sets.** `Represents Q a` and `unitValueSet Q` as pinned
  in the convention table, with their basic calculus: `unitValueSet` is closed under
  multiplication by squares, so it is a union of square classes; `Represents Q 0`
  holds trivially on a nonzero space, which is why the classification statements use
  `unitValueSet`; and the **representation criterion** (Lam I.2.3, I.3.5): for a
  regular `Q` and `a : Kˣ`, `a ∈ unitValueSet Q` iff `Q ⊥ ⟨−a⟩` is isotropic. Every
  later question about which values `q` represents is answered by turning it into
  an isotropy question this way.
- **Binary forms, in normal form.** Two exact theorems, both about units `a b c d`:
  - **representation normal form** (Lam I.2.3 (2)):
    `c ∈ unitValueSet ⟨a,b⟩ ↔ ⟨a,b⟩ ≅ ⟨c, abc⟩`. The second coefficient is `abc`
    because it must have square class `ab/c`, and `ab/c = abc` modulo squares; state
    both spellings and prove them equal, since the sources use both.
  - **binary equivalence criterion** (Lam I.5.1): `⟨a,b⟩ ≅ ⟨c,d⟩` iff
    `IsSquare (a*b*(c*d))` and the two forms represent a common unit.
- **Chain equivalence.** This is the theorem every diagonal invariant's
  well-definedness rests on, so it is stated exactly. For `w w' : Fin n → Kˣ`:
  - `PermutationStep w w'`: there is `σ : Equiv.Perm (Fin n)` with `w' i = w (σ i)`;
  - `BinaryStep w w'`: there are distinct `i j : Fin n` with `w k = w' k` for
    `k ∉ {i,j}` and `⟨w i, w j⟩ ≅ ⟨w' i, w' j⟩`;
  - `DiagonalStep w w'` is the disjunction of the two, and
    `DiagonalChain := Relation.ReflTransGen DiagonalStep`.

  (A transposition is already a `BinaryStep`, since `⟨a,b⟩ ≅ ⟨b,a⟩`, so
  `PermutationStep` is a convenience rather than new generating data; prove that
  containment as a lemma and keep both, because permutation invariance is the
  form most downstream proofs actually apply.)

  The theorem is the equivalence

  ```text
  DiagonalChain w w'  ↔  weightedSumSquares w ≅ weightedSumSquares w'
  ```

  whose two directions are of very different weight. Left to right is elementary:
  each step is an isometry, and isometry is transitive. Right to left is **Witt's
  chain-equivalence theorem** (Lam I.5.2), and it is the real content. Prove it by
  whichever route is convenient, and state the comparison with Serre IV Thm 5's
  contiguous orthogonal bases (`Module.Basis.IsContiguous`, `Chain` in the
  HassePrinciple development) as a separate theorem, so that development can be
  consumed rather than duplicated. The contiguous-basis formulation is a comparison
  target, never an alternative definition of the relation above.
- **The descent principle**, which is the form every later layer uses: a function
  `f` on diagonal tuples of units, invariant under `PermutationStep` and under
  `BinaryStep`, descends uniquely along `Quotient.mk` to a function on
  `RegularFormClass K` agreeing with `f` on each presentation. State it once, in
  exactly this shape, and apply it for `discr`, `signedDiscr`, `hasseInvariant`,
  `localHasse`, and the total Stiefel–Whitney class.

### Layer 1: hyperbolic planes and Witt theory

- **The hyperbolic plane.** `ℍ_q := ⟨1, −1⟩` (with `2` invertible this is equivalent
  to the `xy`-form); universality (`ℍ_q` represents every unit); `⟨a, −a⟩ ≅ ℍ_q`; a
  regular isotropic form splits off a hyperbolic plane (Lam I.3.4); consequently a
  regular isotropic form is universal.
- **Witt decomposition** (Lam I.4.1): every form splits as
  `q ≅ q_t ⊥ (m × ℍ_q) ⊥ q_a` with `q_t` totally isotropic (the zero form on the
  radical) and `q_a` anisotropic, all three unique up to isometry; the **Witt index**
  `m` and the **anisotropic part**; for regular `q`, the Witt index is the dimension
  of any maximal totally isotropic subspace (Lam I.4.4).
- **Witt cancellation** (Lam I.4.2): `q ⊥ q₁ ≅ q ⊥ q₂ → q₁ ≅ q₂`, proved through
  hyperplane reflections (Lam I.4.5 to I.4.7).
- **Reflections and Cartan–Dieudonné** (Lam I.7). For a regular `Q` and a
  nonisotropic `v` (that is, `Q v ≠ 0`), the **reflection**
  `τ_v x = x − (polar Q x v / Q v) • v` is an isometry, `τ_v v = −v`, `τ_v` fixes
  `v^⊥` pointwise, and `τ_v ∘ τ_v = id`. **Cartan–Dieudonné:** every isometry of a
  regular `n`-dimensional quadratic space is a product of at most `n` reflections,
  with the identity as the empty product. No low-dimensional exception arises here:
  the classical counterexample lives in dimension `4` over `𝔽₂`, which our standing
  hypothesis excludes.
- **Witt's extension theorem** (Lam I.4.9): an isometry between regular subspaces of
  a regular space extends to the whole space. Absent from Mathlib in any form, and
  needed later for the transfer and the local uniqueness arguments.

### Layer 2: quaternion algebras and the four-fold splitting criterion

The route through quaternion algebras, rather than a bare cocycle computation, is
deliberate: each equivalence proved there is reusable, whereas a cocycle identity
is not. Nothing in this layer needs central simplicity, and no milestone here
assumes it.

- **Norm form.** For `a, b ∈ Kˣ`: `Nrd(x) = x · star x` is scalar (Mathlib's
  `mul_star_eq_coe`); package `x ↦ (x * star x).re` as a `QuadraticForm K ℍ[K,a,b]`
  and prove `Nrd ≅ ⟨1, −a, −b, ab⟩ = ⟨⟨a, b⟩⟩`, the 2-fold Pfister form; the
  **pure part** `⟨−a, −b, ab⟩` on the trace-zero subspace; multiplicativity
  `Nrd(xy) = Nrd(x)·Nrd(y)`.
- **Split or division.** `ℍ[K,a,b]` is either a division algebra or
  `≃ₐ[K] Matrix (Fin 2) (Fin 2) K`, according to whether `Nrd` is anisotropic
  (Lam III.2.2, 2.7). Route: `x ≠ 0` is invertible iff `Nrd(x) ≠ 0` (the
  `star`-inverse); if `Nrd` is isotropic, run the explicit `M₂(K)`-basis through
  `QuaternionAlgebra.Basis.lift`. Both halves are elementary computations with the
  norm form; state the abstract side so that it can be refactored onto FLT's
  `IsQuaternionAlgebra` when that predicate reaches Mathlib.
- **Symbol relations at the algebra level** (each an `AlgEquiv`, Lam III.2.11):
  `(a,b) ≅ (b,a)`; `(a, c²b) ≅ (a,b)` (square-class invariance in each argument);
  `(a, −a) ≅ M₂(K)`; `(a, b²) ≅ M₂(K)`; `(1, b) ≅ M₂(K)`; and the **Steinberg
  relation** `(a, 1−a) ≅ M₂(K)` for `a : Kˣ` with `1 − a ≠ 0`.
- **Naturality of quaternion equivalences.** A `K`-algebra equivalence
  `f : ℍ[K,a,b] ≃ₐ[K] ℍ[K,c,d]` commutes with the canonical involution `star`, hence
  preserves the reduced trace and reduced norm, maps the trace-zero subspace
  isomorphically onto the trace-zero subspace, and restricts to an isometry of pure
  norm forms `⟨−a,−b,ab⟩ ≅ ⟨−c,−d,cd⟩`. Without this, equality of quaternion
  invariants gives no isometry back, and the dimension-3 classification of Layer 5
  has no proof.
- **The four-fold splitting criterion** (the main theorem of the layer, and the shape
  of `gq2`'s B11a; Lam III.2.7 and III.4.2, Serre III.1.1-1.2,
  Gille–Szamuely 1.1.9). For `a, b ∈ Kˣ`, the following are equivalent:
  1. `ℍ[K,a,b]` splits (`≃ₐ[K] Matrix (Fin 2) (Fin 2) K`);
  2. `b` is a norm from the quadratic algebra `K(√a)`
     (`∃ z : QuadraticAlgebra K a 0, z.norm = b`);
  3. `b = x² − ay²` has a solution in `K`;
  4. `⟨1, −a, −b⟩` is isotropic.

  When `a` is a square all four hold, so no nondegeneracy hypothesis on `a` is
  carried; this matches B11a's "for `a` a square the norm form is universal". A
  fifth equivalent condition, vanishing of the Kummer cup `(a) ∪ (b)`, is Layer 7,
  kept out of here so that Layers 0 to 6 need no cohomology.
- ⚠ **Bimultiplicativity of the symbol is not provable at this layer.** Over a
  general field, `(a, bc)` against `(a,b)` and `(a,c)` is a statement about a group
  law that does not exist yet, and there is no honest `AlgEquiv` formulation of it.
  Do not substitute an ad hoc statement: it is Layer 5 in `Br(K)` and Layer 6 in
  `{±1}`, in each case after the codomain is available.

### Layer 3: the classical invariants that need no Brauer group

Everything here is a function of a diagonalization, well defined by Layer 0's descent
corollary, with values in `ℕ`, `ZMod 2`, or the square-class group. The Hasse
invariant is **not** in this layer: its codomain is a group of Brauer classes and
does not exist before Layer 5.

- **Dimension and dimension mod 2**, with their `Equivalent`-invariance, and the
  induced ring map to `ZMod 2` used by Layer 4.
- **Discriminant and signed discriminant** on `RegularFormClass K`: well-definedness
  through determinants of Gram matrices (Mathlib's `discr'` transported to abstract
  spaces by `basisRepr`) or, equivalently, by the descent principle applied to
  `w ↦ ∏ i, w i`. Prove both descriptions agree.
- **The exact formulas**, for `q` of rank `m` and `r` of rank `n`, all in
  `Kˣ ⧸ (Kˣ)²`:

  ```text
  d(q ⊥ r)  = d(q) · d(r)                d±(q ⊥ r)  = (−1)^{mn} · d±(q) · d±(r)
  d(λ • q)  = λ^m · d(q)                 d±(λ • q)  = λ^m · d±(q)
  d(q ⊗ r)  = d(q)^n · d(r)^m            d±(q ⊗ r)  = (−1)^{mn(mn−1)/2} d(q)^n d(r)^m
  ```

  together with `signedDiscr_eq_sign_mul_discr : d±(q) = (−1)^{m(m−1)/2} · d(q)`,
  which is the only conversion any later proof is allowed to use. Values on the
  standard forms: `d±⟨a⟩ = a`, `d±(ℍ_q) = 1`, `d±⟨⟨a,b⟩⟩ = 1`.
- **The binary quaternion lemma.** If `⟨a,b⟩ ≅ ⟨c,d⟩` for units `a b c d`, then
  `ℍ[K,a,b] ≃ₐ[K] ℍ[K,c,d]` (Lam III.2.11 together with Layer 2's norm form). This
  is the one nontrivial input to the Hasse invariant's well-definedness in Layer 5,
  and it is proved here, where it costs nothing, so that Layer 5 is a statement
  about codomains rather than about forms.
- **Chain induction, prepared.** The two lemmas that Layer 5 and Layer 8 will feed
  into the descent principle: a function of the shape `w ↦ ∏_{i<j} F (w i) (w j)`
  into a commutative monoid is `PermutationStep`-invariant as soon as `F` is
  symmetric, and it is `BinaryStep`-invariant as soon as `F` is bimultiplicative and
  `F a b = F c d` whenever `⟨a,b⟩ ≅ ⟨c,d⟩`. Stating these for an abstract
  commutative monoid `M` and an abstract `F : Kˣ → Kˣ → M` lets Layer 5
  (`M = BrauerGroup K`), Layer 6 (`M = ℤˣ`), and Layer 8 (`M = H²(G_K, 𝔽₂)`,
  written additively) each invoke one lemma instead of repeating the induction.
- **The invariant dictionary, as documentation.** Record in the file docstring which
  named invariant each source means: O'Meara's `∏_{i≤j}`, Serre's `ε`, Lam's `s` and
  `c`, and the ⚠ Wall caution. No definition here, and no formula that mentions a
  Brauer class.

### Layer 4: the Witt ring and the fundamental ideal

Still Brauer-free. Everything below is about `RegularFormClass K` and rings built
from it; the maps into `Br(K)[2]` are Layer 5.

- **`Ŵ(K)` and `W(K)`** (Lam II.1). The commutative monoid `(RegularFormClass K, ⊥)`
  with the multiplication induced by `⊗` is a commutative semiring; its Grothendieck
  group is the **Witt–Grothendieck ring** `Ŵ(K)`, and the **Witt ring** `W(K)` is the
  quotient by the ideal generated by `ℍ_q`. Well-definedness rests exactly on
  Layers 1 and 2 (cancellation and the tensor product). Every **regular** form's Witt
  class is represented by its anisotropic part, and two anisotropic regular forms
  with the same Witt class are isometric (Witt decomposition plus cancellation). The
  complete basic theory: `W` as a functor under field embeddings, and the
  dimension-mod-2 ring map `W(K) → ZMod 2`. General torsion theorems for `W(K)` are
  an explicit scope exclusion.
- **The fundamental ideal.** `I(K) = ker(W(K) → ZMod 2)`. The generation statements,
  all elementary and all proved here:
  - `I` is generated as an ideal (indeed as an additive group) by the 1-fold Pfister
    forms `⟨⟨a⟩⟩ = ⟨1,−a⟩`;
  - `Iⁿ` is generated as an additive group by the `n`-fold Pfister forms
    `⟨⟨a₁,…,aₙ⟩⟩`, which is immediate from the previous item and the definition of
    the power of an ideal; state it for general `n` and record `n = 2, 3` as the
    cases later layers use;
  - `I/I² ≅ Kˣ/(Kˣ)²` via `d±`, which is where the *signed* discriminant is forced.
  No statement about `I³/I⁴` or about the higher filtration is claimed.
- **Pfister forms.** `⟨⟨a₁,…,aₙ⟩⟩` in every degree as the `n`-fold tensor product,
  with the theory developed for `n ≤ 2`:
  - `⟨⟨a,b⟩⟩` is the norm form of `ℍ[K,a,b]` (Layer 2);
  - **round**: for `n ≤ 2`, every `c ∈ unitValueSet ⟨⟨a₁,…,aₙ⟩⟩` is a similarity
    factor, `c • ⟨⟨a₁,…,aₙ⟩⟩ ≅ ⟨⟨a₁,…,aₙ⟩⟩`;
  - `⟨⟨a,b⟩⟩` is isotropic iff it is hyperbolic;
  - `⟨⟨a,b⟩⟩` is hyperbolic iff `ℍ[K,a,b]` splits, which is the four-fold criterion
    in Witt-ring clothing.

  The general theory of `n`-fold Pfister forms (roundness in all degrees, the
  Arason–Pfister Hauptsatz, function-field methods) is excluded; the three bullets
  above are exactly what Layers 5 and 8 consume.

### Layer 5: the Brauer-valued invariants

This is the first layer in which a symbol can be multiplied. It consumes the landed
[semisimple-algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)
by name, and those consumed milestones are prerequisites in the ordinary sense: this
layer cannot be implemented before they are.

From that roadmap's **Layer 4**: the tensor product of two central simple
`K`-algebras is central simple, with `finrank K (A ⊗ B) = finrank K A · finrank K B`;
and the opposite-algebra package `A ⊗_K Aᵒᵖ ≃ₐ[K] End_K A ≃ₐ[K] M_{finrank K A}(K)`.
From its **Layer 6**: the Brauer-triviality prerequisites, the `CommGroup`
structure on `BrauerGroup K` with multiplication induced by `⊗_K`, identity `[K]`,
inverse `[Aᵒᵖ]`, and the quotient API for `Brauer.CSA_Setoid`. Where both roadmaps
name the same fact, the semisimple-algebras statement is the one of record; nothing
here rebuilds Wedderburn, Skolem–Noether, centralizers, splitting fields, or the
index.

- **Quaternion algebras are central simple** (required, not optional). For `a b : Kˣ`
  and `2` invertible, `ℍ[K,a,b]` is a central simple `K`-algebra. Mathlib PR
  [#41538](https://github.com/leanprover-community/mathlib4/pull/41538) proves
  exactly this (with `c·(b² + 4a) ≠ 0`, which our `ℍ[K,a,b] = ℍ[K,a,0,b]` satisfies
  as `b·4a ≠ 0`). If it has landed, consume it and cite the Mathlib file. If it has
  not, coordinate with its authors and either contribute the theorem upstream or
  prove an upstream-compatible version here, exposing the same vocabulary and
  carrying a deletion trigger for when #41538 lands. What is not permitted is
  treating the statement as optional: `[(a,b)] ∈ BrauerGroup K` is undefined
  without it.
- **The quaternion symbol in `Br(K)`.** The class `[(a,b)] := ⟦ℍ[K,a,b]⟧`, and the
  full API that later layers cite by name:
  - symmetry `[(a,b)] = [(b,a)]`;
  - square-class invariance in each argument, `[(a, c²b)] = [(a,b)]`;
  - two-torsion `[(a,b)]² = 1`, from `ℍ[K,a,b]ᵒᵖ ≃ₐ[K] ℍ[K,a,b]` through `star`;
  - **bilinearity** `[(a, bc)] = [(a,b)]·[(a,c)]` and the same in the first
    argument, from the algebra relation `(a,b) ⊗ (a,c) ∼ (a,bc)`
    (Gille–Szamuely 1.5.2 in shape, Lam III.2.11 for the linkage);
  - `[(a, 1−a)] = 1` for `a : Kˣ` with `1 − a ≠ 0` (Steinberg), and `[(a,−a)] = 1`;
  - the resulting factorization through square classes, that is, the biadditive map
    `Kˣ/(Kˣ)² × Kˣ/(Kˣ)² → Br(K)[2]`.
- **The Hasse invariant** `hasseInvariant : RegularFormClass K → BrauerGroup K`,
  `s(⟨a₁,…,aₙ⟩) = ∏_{i<j} [(aᵢ, aⱼ)]` (empty product for `n ≤ 1`). Well-definedness
  is Layer 3's abstract chain-induction lemma applied with `M = BrauerGroup K` and
  `F a b = [(a,b)]`: symmetry and bilinearity are the bullet above, and
  `F a b = F c d` for `⟨a,b⟩ ≅ ⟨c,d⟩` is Layer 3's binary quaternion lemma. Lam
  V.3.18 is this argument. Then the two exact formulas, for `q` of rank `n` and `r`
  of rank `m`, writing `s = hasseInvariant` throughout this layer (the local
  `{±1}`-valued invariant of Layer 6 is always written `localHasse`):

  ```text
  s(q ⊥ r)  = s(q) · s(r) · [(d(q), d(r))]
  s(λ • q)  = s(q) · [(λ, −1)]^{n(n−1)/2} · [(λ, d(q))]^{n−1}
  ```

  (Lam p. 119 and V.3.16; the second follows from bilinearity and
  `[(λ,λ)] = [(λ,−1)]`, and it is written out here because every source states it
  in a different convention.)
- **Classification in dimension at most three** (Lam V.3.21): two regular forms of
  the same dimension `≤ 3` are isometric iff they have the same `d` and the same
  `s`. The proof back from invariants to an isometry runs through Layer 2's
  naturality of quaternion equivalences on pure norm forms.
- **The Clifford invariant.** Mathlib supplies the Clifford algebra, its grading, and
  its even subalgebra, but not the central-simplicity theorems, so those are
  milestones here. For a regular `q` on a finite-dimensional space:
  - if `dim q` is even, `CliffordAlgebra q` is finite-dimensional central simple
    over `K`;
  - if `dim q` is odd, the even subalgebra `CliffordAlgebra.even q` is
    finite-dimensional central simple over `K`;
  - both constructions are invariant under `Equivalent` (an isometry induces an
    algebra equivalence, so the Brauer classes agree);
  - hence `cliffordInvariant q : BrauerGroup K`, the class of whichever of the two
    algebras the parity selects;
  - and the Lam V.3.20 comparison with the Hasse invariant,
    `c(q) = s(q) · [(−1, d(q))]^{(n−1)(n−2)/2} · [(−1,−1)]^{(n+1)n(n−1)(n−2)/24}`,
    with the ⚠ Wall caution of the convention table. On `I²`, where `dim = 2m`,
    this reduces to `c = s · [(−1,−1)]^{m(m−1)/2}`.
- **The `I²` homomorphism.** Using Layer 4's generation of `I²` by 2-fold Pfister
  forms, construct the group homomorphism `c : I² → Br(K)[2]` induced by the
  Clifford invariant, prove it vanishes on `I³` by checking it on Layer 4's 3-fold
  Pfister generators (Lam V.3.4), and obtain `c̄ : I²/I³ → Br(K)[2]` from the
  universal property of the quotient. **No injectivity, surjectivity, or
  classification claim for `c̄` is a milestone of this roadmap.** Injectivity is the
  Merkurjev theorem, for which no roadmap in this family supplies a proof; it is an
  explicit scope exclusion, not a promised interface.

### Layer 6: forms over finite extensions of `ℚ_p`

Scope, pinned: `K` a finite extension of `ℚ_p`, for every prime `p` including
`p = 2`. The dyadic case is the point, and it is not a hypothesis swap away from the
`ℚ_2` case: the number of square classes, the unit filtration, and the explicit
formulas all depend on `[K : ℚ_2]`. The main theorems below are therefore stated at
that generality from the start, and Serre's closed formulas and the `8 × 8` table
are kept as the `K = ℚ_p` acceptance suite. This layer is independent of Layer 5;
the one theorem relating them is stated at the end.

Consumed from [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2),
not restated here:

- its **Layer 0** local-field package (valuation, ring of integers, uniformizer,
  residue field, `e` and `f`);
- its **Layer 1** power classes: `Kˣ/(Kˣ)²` is finite of order `4` when the residue
  characteristic is odd and of order `2^{N+2}` when `K/ℚ_2` has degree `N`, with
  `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8` on the basis `−1, 2, 5` and the deep-square bound
  `U(K, 2e+1) ⊆ (Kˣ)²` as worked instances there. For odd residue characteristic
  the four classes are represented by `1, u, π, uπ` where `π` is a uniformizer and
  `u` is a unit **whose residue is a nonsquare**; that choice of `u` is part of the
  statement, never left implicit. This roadmap adds only the form-theoretic lemmas
  it needs on top of that API, and owns no square-class cardinality.
- its **Layer 2** unramified norms: for `E/K` the unramified quadratic extension,
  `N_{E/K}(Eˣ) = 𝒪[K]ˣ · (Kˣ)² = {x ∈ Kˣ : v_K(x) is even}`, equivalently every unit
  is a norm and a uniformizer is not.

#### 6A. The quadratic defect

The route pinned below for bimultiplicativity is O'Meara's, and it runs on the
quadratic defect, so the defect is a target here rather than an unexplained step in
a proof.

- **Definition.** `𝔡(a) = ⋂_{ξ : K} (a − ξ²) · 𝒪[K]` for `a : Kˣ`, an ideal of
  `𝒪[K]` measuring how far `a` is from being a square: `𝔡(a) = 0` iff `a` is a
  square, and `𝔡(a c²) = c² · 𝔡(a)`, so a square class determines its defect up to
  squares of ideals.
- **The possible defects of a unit** (O'Meara 63:2, with the local square theorem
  63:1). In odd residue characteristic a unit has defect `0` or `𝒪[K]`, by Hensel.
  In residue characteristic 2 with `e = v_K(2)`, the defect of a unit is one of

  ```text
  0,   𝓂[K]^{2e} = 4𝒪[K],   𝓂[K]^{2k+1}  for 0 ≤ k < e
  ```

  a list of length `e + 2`. Over `ℚ_2` (`e = 1`) that is `{0, 4ℤ_2, 2ℤ_2}`, the
  defects of `1`, `5`, and `−1` respectively. The dyadic computation below
  terminates because this list is finite.
- **The three symbol computations** (O'Meara 63:11 to 63:13, in the pinned local-field
  API): the value of `(a,b)_K` in terms of the defect of `a`, its behavior under
  multiplication in each argument, and the existence of `b` with `(a,b)_K = −1` for
  nonsquare `a`.

If a later implementer prefers to derive bimultiplicativity from explicit formulas
instead, that is allowed, but then the formulas must be proved *before*
bimultiplicativity and the defect sublayer may be dropped; what is not allowed is
keeping a proof route whose central object is nowhere a target.

#### 6B. The Hilbert symbol and the local Hasse invariant

- **Definition.** `hilbertSymbol a b : ℤˣ` is `+1` if `∃ x y : K, b = x² − a y²`, and
  `−1` otherwise, for `a b : Kˣ`. Nothing about quaternion algebras or their
  classification enters the definition, so nothing later is circular.
- Then, in this order:
  1. **agreement with the other two descriptions**: `(a,b)_K = 1` iff `b` is a norm
     from `K(√a)` iff `z² − ax² − by² = 0` has a nontrivial zero (Layer 2's four-fold
     criterion, specialized), and square-class invariance in each argument;
  2. **symmetry** `(a,b)_K = (b,a)_K`, after which the Serre orientation and the
     B11a orientation are interchangeable;
  3. the **defect computations** of 6A;
  4. **bimultiplicativity** `(a, bc)_K = (a,b)_K · (a,c)_K`, dyadic case included
     (O'Meara 63:11 to 63:13, Serre III Thm 2 for `K = ℚ_p`);
  5. **nondegeneracy**: for nonsquare `a` there is `b` with `(a,b)_K = −1`; the
     corollary `(Kˣ : N(K(√a)ˣ)) = 2`;
  6. **the local Hasse invariant** `localHasse q = ∏_{i<j} (aᵢ, aⱼ)_K ∈ ℤˣ` for
     `q ≅ ⟨a₁,…,aₙ⟩`, well defined by Layer 3's chain-induction lemma with `M = ℤˣ`
     (symmetry and bilinearity are items 2 and 4; the binary condition
     `(a,b)_K = (c,d)_K` for `⟨a,b⟩ ≅ ⟨c,d⟩` follows from Layer 3's binary quaternion
     lemma and item 1), with the same two formulas as in Layer 5, now in `{±1}`;
  7. **the classification** and its corollaries (6C);
  8. **compatibility with Layer 5**: `localHasse q` is the image of
     `hasseInvariant q` under `Br(K)[2] ≃ ℤˣ`, the local invariant map restricted to
     2-torsion. This theorem needs both layers and is used by neither.
- **Explicit formulas, as the `K = ℚ_p` acceptance suite** (Serre III Thm 1). For odd
  `p`, writing `a = p^α u` and `b = p^β v`:
  `(a,b) = (−1)^{αβ ε(p)} (u|p)^β (v|p)^α` with `ε(p) = (p−1)/2 mod 2`, consuming
  `legendreSym` and `TauCeti/NumberTheory/LegendreSymbol/SquareClass.lean`. For
  `p = 2`: `(a,b) = (−1)^{ε(u)ε(v) + α ω(v) + β ω(u)}` with `ε(u) = (u−1)/2` and
  `ω(u) = (u²−1)/8 mod 2`, read off `PadicInt.toZModPow 3` (adopt HassePrinciple's
  `epsilon`/`omega` once they land). The general odd-residue-characteristic form of
  the first formula, with the quadratic residue character of `𝓀[K]` in place of the
  Legendre symbol, is also stated; there is no closed formula of that kind for a
  general dyadic `K`, which is why 6A carries the dyadic weight.
- **The `8 × 8` table over `ℚ_2`** on the representatives `{±1, ±5, ±2, ±10}`, as a
  family of decidable computations, is the test that the dyadic formula is right.

#### 6C. The classification and its corollaries

Two regular forms over `K` are isometric iff `(dim, d, s)` agree, where `d` is the
**plain** discriminant in `Kˣ/(Kˣ)²` and `s = localHasse` (O'Meara 63:20, Serre IV
Thm 7). Because the dimension is part of the tuple, `(dim, d±, s)` is an equivalent
complete invariant and the conversion is `signedDiscr_eq_sign_mul_discr`; the plain
`d` is the primary one throughout this roadmap.

- **Realization** (O'Meara 63:23, Serre IV Prop 6). A triple `(n, d, s)` with
  `n ≥ 1`, `d ∈ Kˣ/(Kˣ)²`, `s ∈ {±1}` is realized by a regular form except in
  exactly two cases: `n = 1` with `s = −1`, and `n = 2` with `d = [−1]` and
  `s = −1`. Every other triple occurs. (Both exceptions are forced: the empty
  product gives `s = +1` in dimension 1, and `⟨a,−a⟩` has `s = (a,−a)_K = +1`.)
- **Isotropy by rank** (Serre IV Thm 6), in the pinned convention:
  - rank 1: never isotropic;
  - rank 2: isotropic iff `d = [−1]`;
  - rank 3: isotropic iff `s = (−1, −d)_K`;
  - rank 4: isotropic iff `d ≠ [1]`, or `d = [1]` and `s = (−1,−1)_K`;
  - rank at least 5: always isotropic.
- **Representation**, as a corollary rather than a vague reference: for regular `q`
  and `a : Kˣ`, `a ∈ unitValueSet q` iff `q ⊥ ⟨−a⟩` is isotropic (Layer 0), and the
  right-hand side is decided by the rank list above applied to the invariants of
  `q ⊥ ⟨−a⟩`, namely
  `(dim q + 1, −a·d(q), localHasse q · (−a, d(q))_K)`. Spell out the description of
  `unitValueSet q` rank by rank (O'Meara 63:21, Serre IV cor. to Thm 6).
- **`u(K) = 4`**: every regular form of dimension at least 5 over `K` is isotropic,
  and there is an anisotropic form of dimension 4 (O'Meara 63:19).
- **The anisotropic quaternary form is unique** up to isometry (O'Meara 63:17-18,
  Serre IV Thm 7 cor.); it is the norm form of the unique quaternion division
  algebra over `K`, and `⟨1,1,1,1⟩` realizes it when `K = ℚ_2`. Equivalently there
  are exactly two quaternion algebras over `K` up to isomorphism, which is a
  *consequence* of the theory here and is never used to define the symbol.
- **The mod-2 duality reading.** PR #2's Layer 8 states the single theorem
  identifying its local Tate-duality pairing at `n = 2` with the Hilbert symbol
  defined here (suggested name there:
  `hilbertSymbol_eq_tateDuality_pairing`). That theorem is stated there and cited
  here; nondegeneracy is proved independently above, so neither roadmap waits on the
  other.

### Layer 7: the Brauer group in Galois cohomology

Consumes [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1):
its Layer 7 for cup products, its Layer 9 for Kummer theory and the mod-2 Kummer
class, and its Layer 4 exact sequences. Those are their milestones; this layer starts
where those types exist.

The comparison of the algebraic Brauer group with `H²` is not supplied by any sibling
roadmap: the semisimple-algebras roadmap builds `BrauerGroup K` as a group of
algebras and stops, and the profinite-cohomology roadmap builds `H²` and stops. So it
is owned here, and it is written as its own sublayer with its own boundary, because
it is a real piece of mathematics (crossed products) and not a formality.

#### 7A. The comparison with `H²`

- **Construction boundary.** The semisimple-algebras roadmap owns central simple
  algebras and the algebraic Brauer group. The profinite-cohomology roadmap owns
  continuous cochains, `H²`, cup products, restriction and corestriction, and
  Kummer theory. This roadmap owns the crossed-product comparison between them and
  the quaternion-symbol calculation.
- **Milestones.**
  1. the comparison isomorphism
     `BrauerGroup K ≃* H²_cont(G_K, K̄ˣ)`, by crossed products: a finite Galois
     `L/K` splitting `A` gives a 2-cocycle, Brauer equivalence corresponds to
     cohomologous cocycles, and the colimit over `L` gives the continuous `H²`
     (Gille–Szamuely 4.4, Serre *Local Fields* X);
  2. its degree-two Kummer consequence `H²(G_K, μ₂) ≃ Br(K)[2]`, written
     `ι : Br(K)[2] ≃ H²(G_K, μ₂)`, from PR #1 Layer 4's long exact sequence applied
     to `1 → μ₂ → K̄ˣ → K̄ˣ → 1` together with Hilbert 90;
  3. the identification `ι[(a,b)] = (a) ∪ (b)` of the quaternion class with the cup
     of the two mod-2 Kummer classes;
  4. compatibility of the two structures: `ι` carries Brauer multiplication to
     addition of cup products, so Layer 5's bilinearity and Layer 8's additivity are
     the same statement read on two sides.
- **The cyclic computation, stated rather than implied.** Milestone 3's proof is the
  one place where a cocycle meets an algebra, so its steps are separate targets: for
  `L = K(√a)` with `a` a nonsquare, `H²(Gal(L/K), Lˣ) ≃ Kˣ / N_{L/K}(Lˣ)` (the
  degree-two computation for a cyclic group of order two, from PR #1's low-degree
  API); under it the inflation of `(a) ∪ (b)` corresponds to the class of `b`; hence
  `(a) ∪ (b) = 0` iff `b ∈ N_{L/K}(Lˣ)`. The case where `a` is a square is separate
  and trivial.

#### 7B. The symbol as a cup product

- The square-class dictionary `(·) : Kˣ/(Kˣ)² ≃ H¹(G_K, μ₂)` in the cocycle
  normalization PR #1 Layer 9 pins, with compatibility with
  `TauCeti.SquareClassGroup` as a stated lemma.
- **The fifth equivalent condition.** `(a) ∪ (b) = 0` in `H²(G_K, μ₂)` iff the four
  conditions of Layer 2 hold. Given 7A this is the last step of the cyclic
  computation plus the four-fold criterion, and it completes B11a's
  five-fold statement (Serre, *Local Fields* XIV §2 Prop. 4-5;
  Gille–Szamuely 4.7).
- Corollaries: `(a) ∪ (1−a) = 0` for `a : Kˣ` with `1 − a ≠ 0` (Steinberg, from
  Layer 2's algebra splitting); `(a) ∪ (−a) = 0`; and bilinearity of the cup as a
  restatement of Layer 5's bimultiplicativity. Over a finite extension of `ℚ_p` the
  specialization is Layer 6's symbol, through 7A's `ι` and Layer 6's compatibility
  theorem.

### Layer 8: Stiefel–Whitney classes

- **Definition** (Delzant; Milnor's `w` in *Algebraic K-theory and quadratic forms*
  §4): for `q ≅ ⟨a₁, …, aₙ⟩`, the total class
  `w(q) = ∏ᵢ (1 + (aᵢ)) ∈ H^*(G_K, 𝔽₂)`. Well-definedness is Layer 0's descent
  corollary again: permutation invariance is clear, and the binary step is the cup
  identity `(a)(b) = (c)(d)` for `⟨a,b⟩ ≅ ⟨c,d⟩`, which is Layer 7B applied to
  Layer 0's binary criterion. `w` is multiplicative for `⊥` on classes.
- `w₀ = 1`; `w₁(q) = (d(q))` with the **plain** discriminant, per the convention
  table; `w₂` of a diagonal form is `∑_{i<j} (aᵢ)(aⱼ)`, so
  `ι(hasseInvariant q) = w₂(q)` immediately from 7A, both sides being defined on a
  diagonalization.
- ⚠ **The comparison with the Clifford invariant, exact.** The trap is that `c(q)`
  and `s(q)` differ by dimension-dependent terms, so a source that says "`w₂` is the
  Hasse–Witt invariant" has to be read through the convention table first (Fröhlich
  and Serre state their trace-form results with `w₂` against the *Witt* invariant,
  with correction terms of `(2) ∪ (d)` type). Writing

  ```text
  A_n = C(n−1, 2) mod 2      B_n = C(n+1, 4) mod 2
  ```

  for binomial coefficients (these are the exponents `(n−1)(n−2)/2` and
  `(n+1)n(n−1)(n−2)/24` of Lam V.3.20), the milestone is the identity

  ```text
  ι(c(q)) = w₂(q) + A_n · ((−1) ∪ d(q)) + B_n · ((−1) ∪ (−1))
  ```

  in `H²(G_K, μ₂)`, with `ι` from Layer 7A, `d(q)` the plain discriminant class, and
  the whole thing written additively. Keep a `docs`-level note mapping the
  Fröhlich, Serre, and Kahn statements onto it.
- **Acceptance examples**, each naming its forms rather than a bare square class
  (`w₁` and `w₂` are invariants of forms, not of elements): `w(⟨1⟩ⁿ) = 1`;
  `w(⟨a⟩) = 1 + (a)`, so `w₁ = (a)` and `w₂ = 0`; `w(⟨a,b⟩) = 1 + (a) + (b) + (a)(b)`,
  so `w₂⟨a,b⟩ = (a) ∪ (b)`; `w(⟨⟨a,b⟩⟩)`; and the table of `w₁, w₂` over `ℚ_2` for
  the eight forms `⟨a⟩` with `a` running through `{±1, ±5, ±2, ±10}` together with
  the sixteen binary forms `⟨1, a⟩` and `⟨a, a⟩`.

### Layer 9: transfer and the Evens–Kahn formula

- **Which functional.** For `L/K` finite, the nonzero elements of `Hom_K(L,K)` form a
  torsor under `Lˣ`: `Hom_K(L,K)` is one-dimensional as an `L`-vector space under
  `(λ · s)(x) = s(λ x)`, so for nonzero `s, s'` there is a unique `λ : Lˣ` with
  `s'(x) = s(λ x)`. Prove this first; without it the change-of-functional
  theorem compares only a chosen family of functionals, not every two. For `L/K` finite
  separable, `Algebra.trace K L ≠ 0` (from `Algebra.traceForm_nondegenerate`), so the
  trace is a legitimate default.
- **Scharlau transfer** (Lam VII §1, Scharlau Ch. 2 §5): for finite separable `L/K`,
  a nonzero `K`-functional `s`, and a form `q` over `L`, the form `s_*(q) = s ∘ q` on
  the `K`-space underlying the `L`-space of `q`. Milestones:
  `dim_K s_*(q) = [L:K] · dim_L q`; `s_*(q)` regular for regular `q`; additivity
  over `⊥`; **Frobenius reciprocity** `s_*(q ⊗ res_{L/K} r) ≅ s_*(q) ⊗ r`; and
  **change of functional** `(λ · s)_* q ≅ s_*(⟨λ⟩ ⊗ q)`, which with the torsor
  theorem says exactly how much "the" transfer depends on `s`.
- **On Witt rings.** `s_*` takes a hyperbolic plane over `L` to a hyperbolic form
  over `K` (a Lagrangian stays a Lagrangian), hence descends to `W(L) → W(K)`; the
  descended map is additive and, by Frobenius reciprocity, a `W(K)`-module map. It
  is **not** a ring homomorphism, and the roadmap says so where it is defined, since
  that is the usual mistaken expectation.
- **The trace form.** `Tr_*⟨1⟩` is the quadratic form of `Algebra.traceForm`, and for
  `L = K(√d)` it is `⟨2, 2d⟩`; prove it through `TauCeti/FieldTheory/Trace`'s
  diagonalization API rather than re-deriving the trace computations. The twisted
  forms `Tr_*⟨a⟩`, `a : Lˣ`, are the objects Kahn's theorem evaluates.
- **The Galois setup for the cohomological half.** Fix a separable closure `K_s`
  containing `L`. Then `G_L = Gal(K_s/L)` is an open subgroup of `G_K` of index
  `[L:K]`, and restriction and corestriction between `H^*(G_K, 𝔽₂)` and
  `H^*(G_L, 𝔽₂)` are PR #1's. State the independence of this identification from the
  choice of embedding (conjugate embeddings give conjugate subgroups, and the
  resulting maps on cohomology agree), since Kahn's formula is stated for `L/K` and
  not for a chosen embedding.
- **The Evens norm, consumed.** For the general theorem, cite PR #1 Layer 10's
  **abstract finite-index Evens norm** `N^{Ev} : H^q(U, 𝔽₂) → H^{lq}(G, 𝔽₂)` for an
  open `U ≤ G` of index `l`, not its index-two graph cocycle: Kahn's Théorème 2 is
  stated for an arbitrary finite separable `L/K`. The explicit index-two cocycle and
  its identities (restriction, the quadratic expansion, the degree-1 shadow) are
  what the quadratic-extension acceptance theorem below consumes. This roadmap owns
  neither construction, only their application to forms.
- **Kahn's relative Stiefel–Whitney formula** (Kahn, *Classes de Stiefel–Whitney de
  formes quadratiques et de représentations galoisiennes réelles*, Invent. Math. 78
  (1984) 223-256, **Théorème 2**; Kozlowski, Proc. AMS 91 (1984) 309-313, Thm 1.1
  for the homotopy-level transfer; Evens, Trans. AMS 108 (1963) for the norm). For
  `L/K` finite separable and `q` a regular form over `L`,

  ```text
  w(Tr_* q) = N^{Ev}(w(q)) · w(Tr_*⟨1⟩)^{rank q}
  ```

  in `H^*(G_K, 𝔽₂)`, stated at the level of quadratic forms over an arbitrary field
  with `2` invertible (Théorème 2 carries no local hypothesis, and `gq2` §11.2 asks
  for no paper-specific diagonalization in the foundational statement). The
  statement needs one clarification, which is a milestone in its own right: `N^{Ev}`
  is defined on homogeneous classes, so its value on a total class
  `w = 1 + w₁ + w₂ + …` means the multiplicative extension Evens defines
  (`N^{Ev}(1 + x) = 1 + cor(x) + … + N^{Ev}(x)` in the notation of PR #1 Layer 10);
  say which extension is meant and prove the degree-by-degree expansion in the range
  used. Kahn's **Théorème 3**, the rank-1 case through the induced representation
  with its `(2, d)` correction, is the stated corollary connecting this to trace
  forms of `⟨a⟩`.
- **The degree ≤ 2 expansion, written out.** For `L/K` quadratic, `a : Lˣ`,
  `x = (a) ∈ H¹(G_L, 𝔽₂)`, `t₁ = w₁(Tr_*⟨1⟩)`, and `t₂ = w₂(Tr_*⟨1⟩)`:

  ```text
  w₁(Tr_*⟨a⟩) = t₁ + cor(x)
  w₂(Tr_*⟨a⟩) = t₂ + N^{Ev}(x) + t₁ ∪ cor(x)
  ```

  which is the degree-≤-2 part of `w(Tr_*⟨a⟩) = w(Tr_*⟨1⟩) · (1 + cor x + N^{Ev} x)`
  and is exactly the shape `gq2`'s B9 consumes. This is a separate named milestone
  from the general formula.
- **Finite dyadic specialization, as the final acceptance example.** `K` finite over
  `ℚ_2`, `L = K(√d)` quadratic, `q = ⟨a⟩`: the low-degree identity above is `gq2`'s
  `relativeStiefelWhitney_dyadic`, whose left-hand sides are Layer 8's classes of
  the twisted trace forms `Tr_*⟨a⟩`.

---

## Worked examples (acceptance criteria, keeping the definitions honest)

Discharge these alongside their layers; each catches a vacuous definition or a
sign error.

- `⟨1,1⟩ ≇ ⟨1,−1⟩` over `ℚ` (one is anisotropic, one is hyperbolic), the smallest
  non-classification (Layer 1).
- `ℍ_q = ⟨1,−1⟩` represents every `a ∈ ℚˣ` (Layer 1 universality, with the witness
  `((a+1)/2)² − ((a−1)/2)² = a`).
- Chain equivalence in one instance: `⟨1,1⟩ ≅ ⟨2,2⟩` over `ℚ` (both represent `2`,
  and both have discriminant `1`), exhibited as a single `BinaryStep`, so the
  descent principle is applied at least once on a form that is not diagonal in the
  obvious way (Layer 0).
- `ℍ[ℚ,−1,−1]` is a division algebra; `ℍ[ℚ,1,b] ≃ₐ M₂(ℚ)` for every `b ∈ ℚˣ`; and
  `ℍ[ℚ_2,2,5]` is a division algebra while `ℍ[ℚ_2,5,5]` splits (Layer 2, and the
  two entries of the dyadic table used again below).
- The four-fold criterion instantiated over `ℚ_2` twice: at `(a,b) = (2,5)`, where
  all four conditions fail, and at `(a,b) = (5,5)`, where all four hold with the
  witness `5 = 5² − 5·2²` (Layers 2 and 6; B11a-shaped).
- `(−1,−1)_{ℚ_2} = −1` and `(−1,−1)_{ℚ_p} = +1` for odd `p`, so Hamilton's
  quaternions are ramified at `2` and `∞` and nowhere else among these; over `ℝ`,
  `(−1,−1)_ℝ = −1` through `Quaternion.normSq` positivity (Layer 6, with the `ℝ`
  case consuming Mathlib's `ℍ[ℝ]`).
- The full `8 × 8` Hilbert-symbol table over `ℚ_2` on `{±1, ±5, ±2, ±10}` as
  decidable computations; single entries worth naming: `(2,5) = −1`, `(5,5) = +1`
  with the witness above, `(2,−1) = +1`, `(−1,−1) = −1` (Layer 6).
- Exactly one anisotropic quaternary form over `ℚ_2` up to isometry, realized by
  `⟨1,1,1,1⟩`; every form of dimension 5 over `ℚ_p` is isotropic (Layer 6).
- The realization exceptions are real: there is no regular form over `ℚ_2` with
  `(n, d, s) = (1, [1], −1)` and none with `(2, [−1], −1)`, while `(2, [1], −1)` is
  realized by `⟨1,−5⟩` (Layer 6; the check that the two exclusions in the
  realization theorem are not an artifact of the convention).
- `Tr_*⟨1⟩ ≅ ⟨2, 2d⟩` for `ℚ(√d)/ℚ` and for `ℚ_2(√d)/ℚ_2`, recovering
  `TauCeti/NumberTheory/EffectiveBounds/TraceForm.lean`'s `ℂ/ℝ` computation as the
  archimedean sibling (Layer 9).
- An Evens–Kahn instance in low degree: `K = ℚ_2`, `L = ℚ_2(√5)` (the unramified
  quadratic extension), `q = ⟨a⟩`, with both sides of the degree-≤-2 identity
  computed as `a` runs over the **eight unit square classes** of `L`, that is, over
  the image of `𝒪[L]ˣ` in `Lˣ/(Lˣ)²`. That image is the kernel of the
  parity-of-valuation map and has order `8`, while `Lˣ/(Lˣ)²` itself has order `16`
  (PR #2 Layer 1 with `[L : ℚ_2] = 2`); a uniformizer represents the missing coset
  and is excluded here on purpose (Layer 9, the final B9-shaped acceptance).

### Consumed-interface checks (no new mathematics here)

These are not milestones of this roadmap. They are one-line confirmations that the
API we consume says what the later statements assume.

- `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8` with basis `−1, 2, 5`, and `#(ℚ_pˣ/(ℚ_pˣ)²) = 4` for odd
  `p` with representatives `1, u, p, up` for a unit `u` of nonsquare residue
  (PR #2 Layer 1).
- Every unit of `ℤ_2` is a norm from `ℚ_2(√5)`, and `2` is not (PR #2 Layer 2).
- `ℍ[ℝ]` is a division ring (Mathlib), the archimedean instance of the
  split-or-division dichotomy.

## Ordering and parallelism

Layers 0 to 4 are cohomology-free **and** Brauer-free, and can be built immediately.
Within them, Layer 0 comes first, since everything diagonal rests on it; Layers 1 and
2 are independent of each other; Layer 3 needs both; Layer 4 needs 1 to 3.

Layer 5 is the first layer with an outside prerequisite that is not yet met: it needs
the semisimple-algebras roadmap's Layer 4 and Layer 6 to be implemented, because
`BrauerGroup K` is only a quotient until then, and it needs the quaternion
central-simplicity theorem (Mathlib #41538 or an upstream-compatible version proved
here). Until those exist, Layer 5 is a set of statements without types, and the
earlier claim that all of Layers 0 to 6 can be built now does not hold.

Layer 6's own content depends on Layers 0 to 3 and on PR #2's Layers 0 to 2; it does
not depend on Layer 5. Only the last item of 6B, the compatibility of `localHasse`
with `hasseInvariant`, needs both, and nothing else consumes it.

Layer 7A depends on Layer 5 and on PR #1's Layers 4, 7, and 9; Layer 7B on 7A and
Layer 2. Layer 8 depends on Layer 7. Layer 9 splits: the transfer half needs only
Layers 1 to 4 and can be built alongside Layer 5, while the Evens–Kahn half needs
Layer 8 and PR #1's Layer 10.

In the other direction, PR #2's Layer 8 cites Layer 6's Hilbert symbol in its
mod-2 duality theorem, and
[Integral Lattices PR #7](https://github.com/roed-math/TauCetiRoadmap/pull/7)
consumes Layer 6's local classification and the quaternion dictionary.

Until sibling branches merge, the PR links above are canonical. The family-wide
assigned root-list number for this roadmap is `18`; land it after Pro-p Groups `17`.
The integration pass must preserve that number, rebase onto the integration head so
that the root `README.md` list is continuous, keep exactly one import of
`TauCetiRoadmap.QuadraticFormInvariants.Suggested`, check every sibling relative link
once those directories exist, and refresh the "checked on" dates and external PR
heads recorded below.

## References

- T. Y. Lam, *Introduction to Quadratic Forms over Fields*, GSM 67, AMS (2005),
  PRIMARY. Ch. I (diagonalization I.2, hyperbolic I.3, Witt decomposition and
  cancellation I.4, chain equivalence I.5.2, reflections I.7), Ch. II (Witt
  ring, square classes), Ch. III (quaternion algebras and norm forms, III.2.7,
  III.2.11), Ch. V §3 (Clifford, Witt, and Hasse invariants, V.3.17-3.21, the Wall
  caution p. 120), Ch. VI (local fields, VI.2), Ch. VII (Scharlau transfer VII.1),
  Ch. X (Pfister forms).
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), PRIMARY for the
  local theory. Ch. II §3.3 (squares in `ℚ_p`, `ε` and `ω`), Ch. III (Hilbert
  symbol: III.1.1-1.2, Thm 1 formulas including `p = 2`, Thm 2 nondegeneracy),
  Ch. IV §2 (the invariants `d` and `ε`; Thm 5 well-definedness, Thm 6 isotropy,
  Prop 6 realization, Thm 7 classification and the unique anisotropic quaternary
  corollary).
- O. T. O'Meara, *Introduction to Quadratic Forms*, Springer (1963; Classics
  reprint 2000), §63: §63A (the quadratic defect and the local square theorem),
  63:11-13 (symbol computation, bimultiplicativity, nondegeneracy), 63:16
  (unramified norms), 63:17-18 (the anisotropic quaternary space), 63:19 (`u = 4`),
  63:20 (classification), 63:21 (representation), 63:23 (existence). ⚠ Hasse symbol
  `∏_{i≤j}`, translated per the convention table.
- O. T. O'Meara, *Quadratic forms over local fields* (1955), the paper antecedent
  of §63.
- B. Kahn, *Classes de Stiefel-Whitney de formes quadratiques et de
  représentations galoisiennes réelles*, Invent. Math. 78 (1984) 223-256,
  Théorèmes 1-3; B9's source.
- A. Kozlowski, *The Evens-Kahn formula for the total Stiefel-Whitney class*,
  Proc. AMS 91 (1984) 309-313, Thm 1.1.
- L. Evens, *A generalization of the transfer map in the cohomology of groups*,
  Trans. AMS 108 (1963) 54-65, the norm map (consumed via the profinite-cohomology
  roadmap).
- P. Guillot, *The computation of Stiefel-Whitney classes*, Ann. Inst. Fourier 60
  (2010) 565-606, computational companion for SW classes of representations.
- J. Milnor, *Algebraic K-theory and quadratic forms*, Invent. Math. 9 (1970)
  318-344, §4: `w` on square classes and the `I^n`-filtration picture.
- P. Gille, T. Szamuely, *Central Simple Algebras and Galois Cohomology*, CUP
  (2nd ed. 2017): 1.1.9 (the four-fold criterion), 1.5 (symbol bilinearity),
  Ch. 2 and 4.4 (crossed products, cyclic algebras, and `Br(K) ≅ H²`), Ch. 4
  (cup products and the symbol). The reference of record for Layers 5 and 7.
- W. Scharlau, *Quadratic and Hermitian Forms*, Springer (1985), Ch. 2 §5
  (transfer), Ch. 5 (local fields).
- R. Elman, N. Karpenko, A. Merkurjev, *The Algebraic and Geometric Theory of
  Quadratic Forms*, AMS Colloq. 56 (2008): II §7 is the source of Mathlib's
  `Nondegenerate`, and the modern reference for everything in Layers 0 to 4.
- J.-P. Serre, *Local Fields*, GTM 67, Springer (1979): Ch. X (crossed products and
  `H²`), XIV §2 (the symbol as a cup product and the norm criterion; B11a's
  citation).
- L. C. Grove, *Classical Groups and Geometric Algebra*, GSM 39, AMS (2002), cited
  only for the characteristic-2 exclusion note.

## Provenance and coordination

**Coordination snapshot (checked 2026-08-06).** This review made no external contact
and does not claim an ownership agreement. Public repositories and PR metadata were
inspected only. The following conditions must be met before implementation crosses a
project boundary:

- **Project / authors:** `mariainesdff/HassePrinciple`, Nirvana Coppola, María Inés de
  Frutos-Fernández, and contributors. **Exact revision:**
  [`d2802ddce55e`](https://github.com/mariainesdff/HassePrinciple/commit/d2802ddce55ef34045f68c5bf39c0598e7d0e988).
  **Licence:** Apache-2.0. **Overlap:** chain equivalence, the Hilbert symbol,
  `p`-adic squares, Hasse–Minkowski invariants. **Contact status:** not contacted
  during this review. **Agreed ownership:** none recorded. **Plan:** independently
  state the intrinsic general-field and local-classification milestones; consume
  their files only after they land in Mathlib or after explicit coordination.
  **Refactor trigger:** matching `ForMathlib` work lands upstream. **Condition:**
  before adapting code, proof organization, or project-specific statement shapes,
  contact the maintainers and record the division of work.
- **Project / authors:** the Mathlib central-simple and Brauer work: Yunzhou Xie,
  Joël Zhang, Mathias-Stout, J. Springer, and the contributors to PRs #26377,
  #41536, #41537, and #41538. **Exact revisions:** all four were open on 2026-08-06
  at heads `13cac7e3b9bb`, `e95984de0341`, `40983fffa9aa`, and `86493005d20f`
  respectively; #41538 (quaternion central simplicity) depends on both #41536 and
  #41537. **Licence:** Mathlib Apache-2.0. **Overlap:** Brauer multiplication, the
  quaternion directory and API, and quaternion central simplicity. **Contact
  status:** not contacted during this review. **Agreed ownership:** none recorded
  externally; within this family the landed semisimple-algebras roadmap owns general
  CSA and Brauer theory. **Plan:** consume landed Mathlib declarations; keep
  Layer-5 targets that cannot yet be typed in prose. **Refactor trigger:** each cited
  PR lands. **Condition:** no private duplicate group structure; a temporary
  quaternion central-simplicity theorem proved here is permitted (Layer 5 requires
  the statement) only after author contact, must expose the upstream vocabulary, and
  must carry a deletion trigger.
- **PR [#28970](https://github.com/leanprover-community/mathlib4/pull/28970)**
  (reduced norm and trace; open at `5a2bcb298759`, last updated 2025-11-19) is
  **related work, not a prerequisite**. No milestone here uses a general reduced
  norm or trace: Layer 2 builds the quaternion norm form explicitly from `star`. It
  is listed so that a later implementer does not duplicate it, and nothing waits on
  it.
- **Project / authors:** `Whysoserioushah/BrauerGroup` and contributors. **Exact
  revision:**
  [`283e0df7dc15`](https://github.com/Whysoserioushah/BrauerGroup/commit/283e0df7dc15cd8b469a73fbc763f74637c87147).
  **Licence:** Apache-2.0. **Overlap:** the full Brauer-group program and its
  upstream staging, including the comparison `Br(K) ≅ H²(Gal(K̄/K), K̄ˣ)` that
  Layer 7A also states. **Contact status:** not contacted during this review.
  **Agreed ownership:** none recorded. **Plan:** track and consume upstreamed Mathlib
  results rather than migrating staging code into Tau Ceti; if their comparison
  theorem reaches Mathlib first, Layer 7A's milestone 1 becomes a consumed statement
  and only milestones 2 to 4 remain ours. **Condition:** no code adaptation or
  alternate API without recorded coordination.

- **Sibling boundaries.** The
  [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  owns continuous `H^*`, its Layer 7 cup products, its Layer 9 Kummer theory, and
  its Layer 10 Evens norm (both the index-two cocycle and the abstract finite-index
  norm; Layer 9 here cites the latter for Kahn's general theorem). This roadmap's
  Layers 7 to 9 consume those milestones and state only the quadratic-form content,
  with one exception recorded above: the comparison of `BrauerGroup K` with `H²` is
  not theirs and is owned here as Layer 7A.
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) owns
  local-field structure theory, unit filtrations, power classes, unramified norm
  computations, and the mod-2 Tate-duality statement in its Layer 8; Layer 6 here
  consumes all of those and owns the quadratic forms, the Hilbert symbol, the local
  Hasse invariant, and the classification. No theorem is assigned to both.
  [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3) has no
  direct interface with this roadmap. The
  [semisimple algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)
  (landed) owns general CSA, Skolem–Noether, and Brauer-group theory in its
  Layers 4 to 6; Layer 5 here takes exactly the quaternion case, the Clifford case,
  and the 2-torsion packaging, and where both roadmaps name the same fact the
  semisimple-algebras statement is the definition of record.
- **Neighboring Tau Ceti roadmaps.** The
  [multiquadratic roadmap](../Multiquadratic/README.md) shares Layer 0's
  square-class language through the landed `SquareClassGroup.lean`, and the
  `Completed/EffectiveBounds` roadmap contributed the trace-form and
  unit-square-class files we consume; both interfaces are listed in "What Tau
  Ceti already has".
- **External coordination.** HassePrinciple (Coppola, de Frutos-Fernández) and the
  Mathlib CSA line (Xie, Zhang; Whysoserioushah's staging repository; Mathias-Stout
  and J. Springer's quaternion PRs) are described in "What is already in motion".
  Their uncontacted status and the conditions above are the current state; re-run
  the PR search and update the exact revisions at implementation time.
- **`gq2-lean` provenance (secondary; improve rather than canonize).** The
  [`roed-math/gq2-lean`](https://github.com/roed-math/gq2-lean) project
  (Apache-2.0, same ownership as this roadmap) contains working single-purpose
  versions of several targets, over dyadic bases only; they are evidence the
  statements are formalizable and a quarry for proofs, **not** prescriptions of
  form. Map (gq2 file to layer here): `GQ2/StiefelWhitney.lean` (`swOne`/`swTwo`
  with proved Delzant well-definedness over finite dyadic `k`) to Layers 0 and 8;
  `GQ2/TraceForm.lean` (`traceFormOne`/`traceFormTwisted` diagonalizations) to
  Layer 9; `GQ2/HilbertSymbol*.lean` (the `ℚ_2` symbol via `ε` and `ω` with the
  necessity and sufficiency case analysis, in effect the `8 × 8` table) to Layer 6;
  `GQ2/Kummer.lean`, `GQ2/QuadraticAdjoin.lean` (Kummer cocycles, quadratic
  coordinates) to Layer 7, superseded by the profinite roadmap's API;
  `GQ2/EvensKahn.lean`, `GQ2/EvensKahnDerived.lean` (the index-2 two-point Evens
  norm and the derived eq. (111)) to Layer 9; `GQ2/RegularIsometry.lean`,
  `GQ2/RegularSummand.lean`, `GQ2/TrivialSelfDual.lean` are not migrated (marked
  presentation-specific). The `gq2` axioms B11a
  (`hilbertSymbol_normCriterion_finiteDyadic`) and B9
  (`relativeStiefelWhitney_dyadic`) in `GQ2/Foundations/Axioms.lean` are the
  intended *final consumers*: B11a follows from Layer 2's four-fold criterion and
  Layer 7B's cup criterion specialized by Layer 6, and B9 from Layer 9's degree-≤-2
  expansion specialized to finite dyadic bases. `GQ2/QuadraticFp2.lean` and
  `GQ2/GaussSigns*.lean` are characteristic-2 and finite-field material, outside
  this roadmap's scope by the standing exclusion.
- **License note.** The independent comparison formalization
  [`davidturturean/gq2-lean-turturean`](https://github.com/davidturturean/gq2-lean-turturean)
  is GPL-licensed: cite for comparison only; no code transfer into Apache-licensed
  Tau Ceti without an explicit licensing decision.
