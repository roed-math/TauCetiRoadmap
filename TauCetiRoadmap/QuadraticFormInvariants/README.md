# Roadmap: quadratic forms and cohomological invariants

Mathlib has the *linear algebra* of quadratic forms in real depth — `QuadraticMap` /
`QuadraticForm`, polar forms, orthogonal bases and diagonalization
(`QuadraticForm.equivalent_weightedSumSquares`), `Anisotropic`, the radical and the
EKM-style `QuadraticMap.Nondegenerate`, isometries and `Equivalent`, tensor products,
the real/complex/algebraically-closed classifications, and a full Clifford-algebra
directory — and it has quaternion algebras `ℍ[R,c₁,c₂,c₃]` with conjugation and the
`QuaternionAlgebra.Basis` universal property, and the rank-2 `QuadraticAlgebra R a b`
with its norm. But it has **none of the arithmetic theory of quadratic forms over a
field**: no hyperbolic-plane theory, no Witt decomposition or Witt cancellation, no
Witt ring, no Pfister forms, no discriminant-and-Hasse-invariant classification, no
Hilbert symbol, no transfer of forms along a field extension, and no Stiefel–Whitney
classes (verified at the pin and on master, 2026-07-30; no open PRs state any of
them). This roadmap builds that arithmetic theory over fields with `2` invertible,
through its classical summits — the four-fold splitting criterion for quaternion
algebras, the complete classification of forms over `p`-adic fields by
`(dim, d±, s)`, and Kahn's relative Stiefel–Whitney formula for transferred forms —
and, in its final layers, the bridge to mod-2 Galois cohomology.

Suggested homes, mirroring Mathlib's directory conventions:
- `TauCeti/LinearAlgebra/QuadraticForm/` — Witt theory, Pfister forms, the classical
  invariants at the form level, and the Scharlau transfer (Mathlib keeps
  `QuadraticForm` under `LinearAlgebra/`, so the form theory stays there);
- `TauCeti/Algebra/Quaternion/` — the quaternion symbol layer and its Brauer-class
  packaging (Mathlib's quaternion and Brauer material lives under `Algebra/`);
- `TauCeti/NumberTheory/Padics/QuadraticForm/` — the Hilbert symbol over `ℚ_p` and
  the local classification (next to Mathlib's `NumberTheory/Padics/`); statements
  over a general nonarchimedean local field move to the home the
  [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) fixes;
- `TauCeti/FieldTheory/QuadraticForm/` — the cohomological layers (Kummer cup
  bridge, Stiefel–Whitney classes, Evens–Kahn), next to the landed
  `TauCeti/FieldTheory/SquareClassGroup.lean` they consume, coordinated with the
  home [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  fixes for `H^*(G_K, 𝔽₂)`.

**Scope exclusions** (choices, not omissions; separate future roadmaps are welcome):
the characteristic-2 theory of quadratic and bilinear forms (Arf invariant,
quasilinear forms — Grove's chapters on characteristic 2 and EKM Part II document
how different that theory is; everything here assumes `2` invertible); the deep
theory of Pfister forms beyond the 1- and 2-fold cases (function-field methods, the
Arason–Pfister Hauptsatz, the Milnor conjecture — we define `n`-fold Pfister forms
and stop); and the full cohomological invariant theory of
Garibaldi–Merkurjev–Serre beyond Stiefel–Whitney classes.

## Standing hypotheses and pinned conventions

Decide these once; every layer states its results against this table.

- **Base field.** `K` a field with `[Invertible (2 : K)]`. This is the hypothesis
  Mathlib's own quadratic-form theory uses (`QuadraticForm/Basis.lean`,
  `AlgClosed.lean`, the `associated` bilinear form), so we follow it rather than
  `[NeZero (2 : K)]`; over a field the two are interderivable, and where a layer
  meets the multiquadratic roadmap's material (stated with `[NeZero (2 : K)]` or
  `[CharZero K]`) the conversion is part of the interop, not a fork.
- **Forms and regularity.** A form is a `QuadraticForm K V` (`= QuadraticMap K V K`)
  with `[FiniteDimensional K V]` where finiteness is needed — carried as an
  instance, never bundled. Regularity is `QuadraticMap.Nondegenerate Q` (Mathlib's
  EKM-style predicate, `QuadraticForm/Radical.lean`), converted through
  `nondegenerate_associated_iff` / `(QuadraticMap.associated Q).SeparatingLeft`
  when a proof wants the bilinear form (that is the hypothesis Mathlib's
  `equivalent_weightedSumSquares_units_of_nondegenerate'` takes). Anisotropy is
  `QuadraticMap.Anisotropic`; "isotropic" in prose always means
  `¬ Q.Anisotropic` on a nonzero space, never a new predicate.
- **Equivalence and diagonal forms.** Isometry classes via `QuadraticMap.Equivalent`
  (`Nonempty (Q₁.IsometryEquiv Q₂)`). The diagonal form `⟨a₁, …, aₙ⟩` is
  `QuadraticMap.weightedSumSquares K w` with `w : Fin n → K`, unit-valued
  (`w : Fin n → Kˣ`, coerced) whenever the form is regular. Orthogonal sum of forms
  on different spaces is `QuadraticMap.prod`; scaling is `a • Q`.
- **Square classes.** The square-class group is `Kˣ ⧸ Subgroup.square Kˣ`,
  interoperating with the landed `TauCeti.SquareClassGroup`
  (`= Additive Kˣ ⧸ (Subgroup.square Kˣ).toAddSubgroup`, an `𝔽₂ = ZMod 2`-vector
  space) — consume it, do not redefine it. In quotient-free statements "same square
  class" is spelled `IsSquare (a * b)` for units `a b : Kˣ` (as in
  `TauCeti.squareClass_eq_zero_iff`), matching the multiquadratic roadmap's
  `Finset`-product idiom.
- **Discriminant and signed discriminant.** For `q ≅ ⟨a₁, …, aₙ⟩`, the
  *discriminant* is `d(q) = a₁ ⋯ aₙ` in `Kˣ ⧸ (Kˣ)²` and the **signed
  discriminant** is `d±(q) = (−1)^{n(n−1)/2} · d(q)`. Two distinct names, never an
  overloaded one: `discr` and `signedDiscr`. Serre's classification invariant `d`
  and the Stiefel–Whitney class `w₁` see the *plain* `d`; the Witt-ring isomorphism
  `I/I² ≅ Kˣ/(Kˣ)²` and the quadratic-extension dictionary see `d±`. The
  translation `d± = (−1)^{n(n−1)/2} d` is a stated lemma, not folklore.
- **The symbol is a quaternion class.** For `a, b ∈ Kˣ`, the symbol `(a, b)` is the
  isomorphism class of the quaternion algebra `ℍ[K, a, b]` (Mathlib's two-parameter
  notation for `QuaternionAlgebra K a 0 b`: `i² = a`, `j² = b`, `ij = −ji = k`;
  see `Mathlib/Algebra/Quaternion.lean`) — later packaged as its 2-torsion class in
  `BrauerGroup K` (Layer 5), and over a local field collapsed to `{±1}` (Layer 6).
  Until Layer 5, "`(a,b) = (c,d)`" is spelled
  `Nonempty (ℍ[K,a,b] ≃ₐ[K] ℍ[K,c,d])` and "`(a,b) = 1`" is
  `Nonempty (ℍ[K,a,b] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K)`.
- **Hasse invariant.** `s(q) = ∏_{i<j} (aᵢ, aⱼ)` for `q ≅ ⟨a₁, …, aₙ⟩` (empty
  product for `n ≤ 1`), the **Lam/Serre convention** (Lam V.3.17; Serre's `ε` in
  *Course in Arithmetic* IV.2.1), valued in quaternion classes (2-torsion Brauer
  classes after Layer 5, `{±1}` over local fields). Documented translations, each a
  stated lemma once its target exists: **O'Meara's Hasse symbol** (63:20 context)
  is `S(q) = ∏_{i≤j} (aᵢ, aⱼ) = s(q) · (d(q), −1)`; the **Witt/Clifford invariant**
  `c(q)` (the Brauer class of `C(q)` or `C₀(q)` by parity, Lam V.3.12) satisfies
  Lam V.3.20: `c = s · (−1, d)^{(n−1)(n−2)/2} · (−1,−1)^{(n+1)n(n−1)(n−2)/24}`,
  and `c = s · (−1,−1)^{m(m−1)/2}` on `I²` with `dim = 2m`. ⚠ Lam records that
  C. T. C. Wall's published version of this translation is **incorrect** (Lam,
  p. 120, "Caution") — do not import the formula from secondary sources; cite Lam
  and prove it once.
- **Hilbert symbol.** Over a local field (and `ℝ`), `(a,b)_K = 1` iff
  `z² − ax² − by² = 0` has a nontrivial zero, else `−1` (Serre, *Course in
  Arithmetic* III.1.1). Norm criterion in the *Serre orientation*: `(a,b) = 1` iff
  `a ∈ N(K(√b)/K)` — equivalently, by symmetry `(a,b) = (b,a)`, iff `b` is a norm
  from `K(√a)`, the form the four-fold equivalence (Layer 2) and `gq2`'s B11a use;
  state the symmetry early so the two orientations are interchangeable. Values live
  in `ℤˣ = {±1}`; the additive avatar is `ZMod 2` via the unique isomorphism, and
  the cohomological avatar is `μ₂ ≃ ZMod 2` (Layer 7) — one **value dictionary**
  file states these once, and every later statement picks a side through it. The
  active Hasse–Minkowski project (see "in motion" below) uses an integer-valued
  `hilbertSym : k → k → ℤ` that is `0` on zero arguments; our symbol is total on
  `Kˣ × Kˣ` where no such convention is needed, and the bridge lemma to their
  junk-value convention is part of the coordination, not a redesign.
- **Pfister forms.** `⟨⟨a⟩⟩ = ⟨1, −a⟩` and `⟨⟨a, b⟩⟩ = ⟨1, −a⟩ ⊗ ⟨1, −b⟩ ≅
  ⟨1, −a, −b, ab⟩` (the minus-sign convention of Lam Ch. X and
  Elman–Karpenko–Merkurjev; some older sources use `⟨1, a⟩` factors — flag it).
  The `n`-fold `⟨⟨a₁, …, aₙ⟩⟩` is the `n`-fold tensor product, via Mathlib's
  `QuadraticForm` tensor product (`QuadraticForm/TensorProduct.lean`, which already
  carries the needed `Invertible (2 : R)`).
- **Transfer.** The Scharlau transfer `s_*(q)` of a form `q` over `L` along a
  **nonzero `K`-linear functional** `s : L →ₗ[K] K`, for `L/K` finite separable.
  The default functional is the trace `Algebra.trace K L`, written `Tr_*`; every
  theorem is stated for general nonzero `s` with the trace as the named instance,
  and the change-of-functional lemma (`s'_*(q) ≅ s_*(⟨λ⟩ ⊗ q)` when
  `s' = s ∘ (λ·)`, `λ ∈ Lˣ`) is an early target so "the" transfer is honest.
- **Cohomological dictionary** (Layers 7–9, consuming the profinite-cohomology
  roadmap): `H¹(G_K, μ₂) ≅ Kˣ/(Kˣ)²` (Kummer), the class of `a` written `(a)`;
  `H²(G_K, μ₂)` receives quaternion classes; the total Stiefel–Whitney class of
  `q ≅ ⟨a₁, …, aₙ⟩` is `w(q) = ∏ᵢ (1 + (aᵢ))` (Delzant); `w₁(q) = (d(q))` — the
  **plain** discriminant, not `d±`.

## What Mathlib already has (consume)

All checked at the roadmap pin (`9caeba1000`, 2026-06-03) and rechecked on master.

- **Quadratic forms:** `Mathlib/LinearAlgebra/QuadraticForm/Basic.lean`
  (`QuadraticMap`, `QuadraticForm`, `polar`, `associated`, `Anisotropic`, `PosDef`,
  `weightedSumSquares`, `discr'` for forms on `n → R`, matrix representations);
  `Isometry.lean`, `IsometryEquiv.lean` (`Equivalent`,
  `equivalent_weightedSumSquares`, `equivalent_weightedSumSquares_units_of_nondegenerate'`
  — diagonalization is *done*, consume it); `Basis.lean` (`basisRepr`,
  `exists_orthogonal_basis`); `Prod.lean` (`QuadraticMap.prod`, orthogonal sums);
  `TensorProduct.lean` (tensor product of forms, with `Invertible (2 : R)`);
  `Radical.lean` (`QuadraticMap.radical`, `QuadraticMap.Nondegenerate`,
  `nondegenerate_associated_iff`); `Dual.lean`; `Real.lean`, `Complex.lean`,
  `Signature.lean`, `AlgClosed.lean` (the classifications over `ℝ`, `ℂ`,
  algebraically closed fields — the model for our local classification);
  `QuadraticModuleCat.lean`.
- **Bilinear forms:** `LinearMap.BilinForm.Nondegenerate`, `SeparatingLeft`,
  orthogonality (`Mathlib/LinearAlgebra/BilinearForm/*`, `SesquilinearForm/*`).
- **Quaternion algebras:** `Mathlib/Algebra/Quaternion.lean` — the Bourbaki
  three-parameter `QuaternionAlgebra R c₁ c₂ c₃` with notations `ℍ[R,c₁,c₂,c₃]`,
  `ℍ[R,c₁,c₂]` (`= ℍ[R,c₁,0,c₂]`), `ℍ[R]`; conjugation `star` **for the general
  algebra** with `mul_star_eq_coe : a * star a = ((a * star a).re : ℍ[…])` — the
  scalarness of the norm is already there; but `normSq` (as a `MonoidHom`) and the
  `DivisionRing` instance exist **only for Hamilton's `ℍ[R]`**.
  `Mathlib/Algebra/QuaternionBasis.lean` — `QuaternionAlgebra.Basis` and
  `Basis.lift : Basis A c₁ c₂ c₃ ≃ (ℍ[R,c₁,c₂,c₃] →ₐ[R] A)`, the universal
  property our splitting arguments run through.
- **Rank-2 algebras:** `Mathlib/Algebra/QuadraticAlgebra/{Defs,Basic,NormDeterminant}.lean`
  (A. Chambert-Loir) — `QuadraticAlgebra R a b` (`ω² = a + bω`), `star`,
  `norm : QuadraticAlgebra R a b →* R` with
  `norm z = z.re² + b·z.re·z.im − a·z.im²`, `isUnit_iff_norm_isUnit`, the `Field`
  instance when `X² − bX − a` has no root, and `norm = det` of multiplication.
  **`QuadraticAlgebra K a 0` is our vehicle for `K(√a)` and its norm form
  `x² − ay²`** — do not re-adjoin square roots where this algebra serves;
  `Mathlib/FieldTheory/KummerExtension.lean` and
  `TauCeti/FieldTheory/IntermediateField/Quadratic.lean` cover the
  intermediate-field picture when an ambient field is in play.
- **Central-simple/Brauer scaffolding** (for Layer 5): `Mathlib/Algebra/Central/*`
  (`Algebra.IsCentral`, `Algebra.IsCentralSimple`; J. Zhang),
  `Mathlib/Algebra/BrauerGroup/Defs.lean` (`CSA`, `IsBrauerEquivalent`,
  `BrauerGroup` as a `Quotient`, **not yet a group**; Y. Xie, J. Zhang),
  `Mathlib/Algebra/Azumaya/*` (`IsAzumaya`, `AlgHom.mulLeftRight`),
  `Mathlib/RingTheory/SimpleModule/WedderburnArtin.lean`, `SimpleRing/*`.
- **Clifford algebras:** `Mathlib/LinearAlgebra/CliffordAlgebra/*` (base change,
  grading, even subalgebra, equivalences with quaternion algebras in `Equivs.lean`)
  — the raw material for the Witt/Clifford invariant comparison in Layer 3; we
  consume, and do not extend, the Clifford theory itself.
- **Arithmetic fuel for examples:** `Mathlib/NumberTheory/Padics/*` (`ℚ_[p]`,
  `ℤ_[p]`, `PadicInt.toZModPow`, Hensel's lemma),
  `Mathlib/NumberTheory/LegendreSymbol/*` (`legendreSym`, `jacobiSym`, quadratic
  reciprocity, quadratic characters), `Mathlib/FieldTheory/Finite/*`.
- **Trace forms:** `Algebra.traceForm : BilinForm R S` with
  `Algebra.traceForm_nondegenerate` for finite separable extensions
  (`Mathlib/RingTheory/Trace/*`) — Layer 9's `Tr_*⟨1⟩` starts here, and the
  quadratic form of a bilinear form is `LinearMap.BilinMap.toQuadraticMap`.
- **Discrete group cohomology** (background for Layers 7–9's *statements* only):
  `Mathlib/RepresentationTheory/Homological/GroupCohomology/{LowDegree,Hilbert90,Shapiro}.lean`.
  There is **no continuous cohomology at the pin** (master has
  `RepresentationTheory/Homological/ContCohomology/`); the profinite-cohomology
  roadmap owns that gap.

## What Tau Ceti already has (consume)

This is the first roadmap consuming landed Tau Ceti code; treat these files as
fixed API, cite them in the consuming files, and route improvements through their
own review rather than duplicating.

- **`TauCeti/FieldTheory/SquareClassGroup.lean`** — `TauCeti.SquareClassGroup K`
  (an `𝔽₂`-vector space), `squareClass`, `squareClass_eq_zero_iff`,
  `squareClass_prod`, and `linearIndependent_squareClass_iff` (linear independence
  = no nonempty subset product is a square). Layer 0's square-class calculus lands
  *next to this file*, extending it (finiteness/cardinality API, the
  `ℚ_p` computations of Layer 6) rather than shadowing it.
- **`TauCeti/FieldTheory/IntermediateField/Quadratic.lean`** — quadratic normal
  forms `a + b√x`, `finrank_adjoin_simple_eq_two_of_sq_mem_notMem`,
  `isSquare_mul_of_adjoin_simple_eq`: the intermediate-field side of quadratic
  extensions, used when `K(√a)` must live inside a given ambient field.
- **`TauCeti/NumberTheory/Multiquadratic/SquareClass/{Basic,Independence}.lean`** —
  square-class descent in towers (`sqrtTower`, `squareClass_of_sq_mem`); the
  [multiquadratic roadmap](../Multiquadratic/README.md) owns multi-root towers, we
  own one quadratic step's *form theory*; the shared language is the square-class
  group above.
- **`TauCeti/NumberTheory/LegendreSymbol/SquareClass.lean`** —
  `legendreSym_mul_sq` and friends: radicand-normalization API our odd-`p`
  Hilbert-symbol formula (Layer 6) reuses.
- **`TauCeti/NumberTheory/EffectiveBounds/TraceForm.lean`** and
  `TauCeti/FieldTheory/Trace` — trace-form diagonalization on square-root bases
  (`discr_one_elem_eq_of_sq_algebraMap`, trace-vanishing criterion). Layer 9's
  `Tr_*⟨1⟩ ≅ ⟨2, 2d⟩` for `K(√d)/K` is the form-level restatement; prove it
  through this API, do not re-derive the trace computations.

## What is already in motion elsewhere (cite, follow, do not duplicate)

- **Hasse–Minkowski / Hilbert symbol:**
  [`mariainesdff/HassePrinciple`](https://github.com/mariainesdff/HassePrinciple)
  (N. Coppola, M. I. de Frutos-Fernández; Apache-2.0; checked at
  [`d2802ddce55e`](https://github.com/mariainesdff/HassePrinciple/commit/d2802ddce55ef34045f68c5bf39c0598e7d0e988),
  2026-07-27)
  formalizes the Hasse–Minkowski theorem over `ℚ` following Serre: an integer-valued
  `hilbertSym` on a general field (Serre's solvability definition), the `p = 2`
  `epsilon`/`omega` residues, `p`-adic squares (`Padics/Squares.lean`), Serre's
  contiguous-orthogonal-bases chain (`QuadraticForm/Chain.lean`, stated with
  `[Invertible (2 : k)]`), and the Hasse–Minkowski invariant with the rank-by-rank
  case analysis. **The uncontacted-status gate in §Provenance applies before Layer 6**:
  their target is the global
  theorem over `ℚ` with `ForMathlib/` files headed upstream; ours is the
  general-field invariant theory, the local classification for *all* `p`-adic
  fields including dyadic ones, and the cohomological layers. Adopt their
  conventions where the objects coincide (Serre's solvability-valued symbol; the
  contiguity notion for chains), state the bridge lemmas to our `Kˣ × Kˣ` symbol,
  and flag every Layer 6 milestone that should refactor onto their files when they
  land in Mathlib. (Prior art in the same direction: the 2023 Lorentz-Center
  workshop project on Hasse–Minkowski by A. Best, K. Buzzard, M. Streng,
  H. Wiersema, and R. Winter.)
- **Central simple algebras and the Brauer group:** in-tree scaffolding by
  Y. Xie and J. Zhang (above);
  [`Whysoserioushah/BrauerGroup`](https://github.com/Whysoserioushah/BrauerGroup)
  (Apache-2.0; checked at
  [`283e0df7dc15`](https://github.com/Whysoserioushah/BrauerGroup/commit/283e0df7dc15cd8b469a73fbc763f74637c87147),
  2026-07-16) stages the full program (Wedderburn, Skolem–Noether, double centralizer,
  splitting fields, the group structure, `Br(K) ≅ H²(Gal(K̄/K), K̄ˣ)`,
  `Br(ℝ)`, `Br(𝔽_q)`) with active upstreaming: open PRs
  [#26377](https://github.com/leanprover-community/mathlib4/pull/26377) (open at
  `13cac7e3b9bb`, updated 2026-07-16; tensor product of a simple and a central simple
  algebra is simple — the Brauer multiplication prerequisite) and
  [#28970](https://github.com/leanprover-community/mathlib4/pull/28970) (open at
  `5a2bcb298759`, last updated 2025-11-19; reduced norm and trace). Layer 5 is
  prose-only where these APIs are missing and consumes them if they land;
  the [semisimple-algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)
  already scopes the general CSA theory (see "Provenance and coordination").
- **Quaternion algebras as CSAs:** open PRs
  [#41536](https://github.com/leanprover-community/mathlib4/pull/41536) (open at
  `e95984de0341`, updated 2026-07-18; quaternion directory split) and
  [#41538](https://github.com/leanprover-community/mathlib4/pull/41538)
  (Mathias-Stout, J. Springer; open at `86493005d20f`, updated 2026-07-17):
  `ℍ[R,a,b,c]` over a field is
  central simple when `c·(b² + 4a) ≠ 0`, adding
  `Mathlib/Algebra/Quaternion/CentralSimple.lean`. Layer 2's
  "quaternion algebras are central simple" milestone must **consume this PR's
  statement, not restate it**; if it has landed by build time, cite the mathlib
  file. The FLT project carries `IsQuaternionAlgebra F D` (a 4-dimensional central
  simple algebra, K. Buzzard, `FLT/Mathlib/Algebra/IsQuaternionAlgebra.lean`,
  "material destined for Mathlib") together with the split-or-division dichotomy
  for it; Layer 2's abstract characterization milestone is stated so that it can
  refactor onto that predicate when it reaches Mathlib.
- **Indefinite bilinear forms:** PR
  [#38194](https://github.com/leanprover-community/mathlib4/pull/38194) (indefinite
  metrics) touches real signature theory only; no conflict, noted for awareness.

## What is missing (build here)

Everything below the linear algebra: the **hyperbolic plane** as a studied object
and the isotropy ⇔ hyperbolic-splitting dichotomy; **Witt decomposition,
cancellation, and the Witt index**; **Witt's chain-equivalence theorem** as the
well-definedness engine for diagonal invariants; the **representation predicate**
and value-set calculus; the **Witt ring** `W(K)`, the fundamental ideal `I(K)`,
and 1- and 2-fold **Pfister forms**; the **quaternion symbol layer** — norm form,
split/division dichotomy, the four-fold splitting criterion; the **classical
invariants** `dim mod 2`, `d`, `d±`, `s(q)` with their well-definedness and the
dimension-≤-3 classification; the **Brauer-class packaging** of the symbol; the
**Hilbert symbol** over local fields with the dyadic `ε/ω` formula,
bimultiplicativity, and nondegeneracy; the **complete local classification** by
`(dim, d±, s)` with `u(ℚ_p) = 4` and the unique anisotropic quaternary form; the
**Kummer cup bridge** `(a) ∪ (b) = [(a,b)]`; **Stiefel–Whitney classes** of forms
with the `w₂`-versus-Hasse comparison; and the **Scharlau transfer** with
**Kahn's relative Stiefel–Whitney formula** (Evens–Kahn). None of this exists
upstream as stated; each object gets its complete basic theory, not only the
milestone the headline needs.

`Suggested.lean` pins Lean forms for the milestones of Layers 0–6 (all
expressible against the pinned Mathlib) plus the worked examples; the
cohomological Layers 7–9 stay prose until the profinite-cohomology roadmap's
types exist, at which point their milestones are added there with `sorry`.

---

## The build, in layers

The order below is the dependency order. Layers 0–6 are cohomology-free.

### Layer 0: square classes, diagonal calculus, and chain equivalence

- **Square-class interop.** Consume `TauCeti.SquareClassGroup`. Add what the
  invariants need: the multiplicative avatar `Kˣ ⧸ Subgroup.square Kˣ` with the
  `ZMod 2`-module dictionary to the landed additive one; pushforward along field
  maps; finiteness transfer (`Nat.card` API) — the local computations of Layer 6
  land as instances of this API.
- **Representation.** The predicate "`q` represents `a`" (`∃ v, Q v = a`, on the
  nose for `a ≠ 0`; a definition here, because value *sets* `D(q)` and their
  calculus carry a real theory: `D(q)` is closed under square scaling,
  `a ∈ D(q) ↔ ⟨−a⟩ ⊥ q` isotropic for regular `q` (the representation criterion,
  Lam I.2.3-3.5), binary forms represent `e` iff … — Lam I.5.1's criterion for
  binary equivalence: `⟨a,b⟩ ≅ ⟨c,d⟩` iff `d(ab) = d(cd)` in square classes and
  the two forms represent a common element).
- **Chain equivalence** (⚠ the well-definedness engine — get it right once). Two
  routes exist and both are legitimate: Lam I.5.2 (diagonal tuples, *simple
  equivalence* changes at most two slots by a binary isometry; chains of simple
  equivalences connect any two diagonalizations) and Serre IV.Thm 5's contiguous
  orthogonal bases — the route the HassePrinciple project has already started
  (`Module.Basis.IsContiguous`, `Chain`). **Pin: state the theorem in Lam's
  diagonal-tuple form** (that is the form every invariant's well-definedness
  consumes, one binary move at a time), prove it by whichever route, and provide
  the bridge to the contiguous-bases form so the HassePrinciple development can be
  consumed/merged rather than duplicated. Corollary shape used everywhere
  downstream: any isometry-invariant of diagonal tuples that is invariant under
  (i) permutation and (ii) one binary move `⟨a,b⟩ → ⟨c,d⟩` is well-defined on
  equivalence classes of forms.

### Layer 1: hyperbolic planes and Witt theory

- **The hyperbolic plane.** `ℍ_q := ⟨1, −1⟩` (with `2` invertible this is
  equivalent to the `xy`-form); universality (`ℍ_q` represents every unit);
  `⟨a, −a⟩ ≅ ℍ_q`; a regular isotropic form splits off a hyperbolic plane
  (Lam I.3.4); consequences: a regular isotropic form is universal.
- **Witt decomposition** (Lam I.4.1): every form splits as
  `q ≅ q_t ⊥ (m × ℍ_q) ⊥ q_a` with `q_t` totally isotropic (zero form on the
  radical), `q_a` anisotropic, all three unique up to isometry; the **Witt index**
  `m` and the **anisotropic part**; for regular `q`, the Witt index equals the
  dimension of any maximal totally isotropic subspace (Lam I.4.4).
- **Witt cancellation** (Lam I.4.2): `q ⊥ q₁ ≅ q ⊥ q₂ → q₁ ≅ q₂`. Prove via
  hyperplane reflections (Lam I.4.5-4.7); this is where the reflection generation
  of the orthogonal group (Lam I.7, Cartan–Dieudonné) naturally lands — build it
  here as part of the complete basic theory, stated for the isometry group of a
  regular form.
- **Witt's extension theorem** (Lam I.4.9 / Witt's isometry-extension): an isometry
  between regular subspaces of a regular space extends to the whole space. Absent
  from Mathlib in any form; needed later for transfer and local uniqueness
  arguments.

### Layer 2: quaternion algebras and the four-fold splitting criterion

The structural route through quaternion algebras (rather than a bare cocycle
computation) is deliberate: it is what makes each equivalence reusable.

- **Norm form.** For `a, b ∈ Kˣ`: `Nrd(x) = x · star x` is scalar (Mathlib's
  `mul_star_eq_coe`); package `x ↦ (x * star x).re` as a `QuadraticForm K ℍ[K,a,b]`
  and prove `Nrd ≅ ⟨1, −a, −b, ab⟩ = ⟨⟨a, b⟩⟩` (the 2-fold Pfister form); the
  **pure part** `⟨−a, −b, ab⟩` on the trace-zero subspace; multiplicativity
  `Nrd(xy) = Nrd(x)Nrd(y)`.
- **Split/division dichotomy.** `ℍ[K,a,b]` is either a division algebra or
  `≃ₐ[K] Matrix (Fin 2) (Fin 2) K`, according to whether `Nrd` is anisotropic
  (Lam III.2.2, 2.7). Route: `x ≠ 0` is invertible iff `Nrd(x) ≠ 0`
  (`star`-inverse); if `Nrd` is isotropic run the explicit `M₂(K)`-basis through
  `QuaternionAlgebra.Basis.lift`. Consume PR #41538's central-simplicity;
  state the abstract side so it refactors onto FLT's `IsQuaternionAlgebra`.
- **Symbol relations at algebra level** (each an `AlgEquiv`, Lam III.2.11):
  `(a,b) ≅ (b,a)`; `(a, c²b) ≅ (a,b)` (square-class invariance);
  `(a, −a) ≅ M₂(K)`; `(a, 1−a) ≅ M₂(K)` (**Steinberg relation**);
  `(a, b²) ≅ M₂(K)`; `(1, b) ≅ M₂(K)`.
- **The four-fold equivalence** (the roadmap's first summit; `gq2` B11a's shape,
  Lam III.2.7 + III.4.2, Serre III.1.1-1.2, Gille–Szamuely 1.1.9). For
  `a, b ∈ Kˣ`, TFAE:
  1. `ℍ[K,a,b]` splits (`≃ₐ[K] Matrix (Fin 2) (Fin 2) K`);
  2. `b` is a norm of the quadratic algebra `K(√a)`
     (`∃ z : QuadraticAlgebra K a 0, z.norm = b`);
  3. `b = x² − ay²` has a solution in `K`;
  4. `⟨1, −a, −b⟩` is isotropic.
  (When `a` is a square all four hold — no non-degeneracy hypothesis on `a`,
  matching B11a's "for `a` a square the norm form is universal".) Statement (5) —
  the Kummer cup `(a) ∪ (b)` vanishes — is Layer 7, deliberately separated so
  Layers 0–6 stay cohomology-free.
- ⚠ **Bimultiplicativity of the symbol is *not* provable at this layer** over a
  general field in the `AlgEquiv` language (`(a, bc)` against `(a,b)`, `(a,c)`
  needs Brauer multiplication); do not fake it with an ad-hoc statement — it is
  Layer 5 (general, in `Br(K)`) and Layer 6 (local, in `{±1}`).

### Layer 3: the classical invariants

- **Dimension mod 2** and its `Equivalent`-invariance (trivial, stated once).
- **Discriminant and signed discriminant** as functions on isometry classes:
  well-definedness via determinants of Gram matrices (Mathlib's `discr'`
  generalized to abstract spaces through `basisRepr`), the `⊥`- and
  `⊗`-behavior, `d±` on `⟨a⟩`, `ℍ_q`, and `⟨⟨a,b⟩⟩`.
- **The Hasse invariant.** `s(⟨a₁,…,aₙ⟩) = ∏_{i<j} (aᵢ, aⱼ)`, well-defined on
  isometry classes by chain equivalence (Layer 0) plus the binary-move invariance
  — the exact argument of Lam V.3.18, whose one nontrivial step is the
  quaternion-class identity `(a,b) = (c,d)` for `⟨a,b⟩ ≅ ⟨c,d⟩` from Layer 2.
  Until Layer 5 the value is "a quaternion algebra up to isomorphism together
  with the multiplication rule on the products that occur" — concretely: state
  well-definedness as *the multiset of binary symbols changes by moves that
  preserve the Brauer class*, packaged so that Layer 5 upgrades the codomain to
  `BrauerGroup K` and Layer 6 to `{±1}` with **no restatement** of the engine.
  Sum formula `s(q ⊥ q') = s(q)·s(q')·(d(q), d(q'))` (Lam p. 119) and the
  scaling formula for `s(aq)` (the `s`-analogue of Lam V.3.16).
- **Dimension ≤ 3 classification** (Lam V.3.21): forms of equal dimension `≤ 3`
  are isometric iff they have the same `d` and the same `s` — the first
  classification payoff and the template for Layer 6's local one.
- **The Witt/Clifford invariant `c(q)`, as documentation with one lemma.** Define
  nothing new: state the translation `c = s·(−1,d)^…·(−1,−1)^…` (Lam V.3.20
  (A)/(B)) as a milestone *once the Brauer layer can express `c`*, cite the
  ⚠ Wall caution, and record in the file docstring which named invariant each of
  O'Meara (`∏_{i≤j}`), Serre (`ε`), Lam (`s`, `c`) denotes.

### Layer 4: the Witt ring and the fundamental ideal

- **`Ŵ(K)` and `W(K)`** (Lam II.1): the Witt–Grothendieck ring of regular forms
  under `⊥`, `⊗`, and the Witt ring as its quotient by the hyperbolic ideal
  `ℤ·ℍ_q`; well-definedness of the ring structure rests exactly on Layers 1–2
  (cancellation, tensor). Every form's Witt class is its anisotropic part
  (decomposition). The complete basic theory: `W` as a functor under field
  embeddings; the dimension-mod-2 ring map `W(K) → ℤ/2`. General torsion theorems for
  `W(K)` are explicit scope exclusions.
- **The fundamental ideal.** `I(K) = ker(dim mod 2)`, generated by `⟨⟨a⟩⟩`;
  `I²` generated by `⟨⟨a,b⟩⟩`; the two classical isomorphisms that tie this
  roadmap together: `I/I² ≅ Kˣ/(Kˣ)²` via `d±` (this is where the *signed*
  discriminant is forced), and the Hasse/Clifford story on `I²/I³`. Construct the
  homomorphism `c : I² → Br(K)[2]` (`c = s` up to the recorded
  `(−1,−1)`-powers), prove directly that it vanishes on `I³` (Lam V.3.4), and use
  the quotient universal property to obtain the induced homomorphism
  `c̄ : I²/I³ → Br(K)[2]`. **No injectivity, surjectivity, or classification claim
  for `c̄` is a milestone of this roadmap.** Such a claim requires the deep
  Merkurjev/norm-residue theorem, for which this roadmap has no supplier; that
  theorem is an explicit scope exclusion, not a promised interface.
- **Pfister forms, 1- and 2-fold theory.** `⟨⟨a⟩⟩`, `⟨⟨a,b⟩⟩` and their
  characteristic properties at this level: `⟨⟨a,b⟩⟩` is the norm form of
  `(a,b)`; `⟨⟨a,b⟩⟩` hyperbolic iff `(a,b)` splits (the four-fold criterion in
  Witt-ring clothing); round-form basics for these two cases only. General
  `n`-fold definition; deep theory excluded (see scope note).

### Layer 5: the Brauer-class packaging (refactor-flagged)

Everything here is stated against Mathlib's `CSA`/`IsBrauerEquivalent`/
`BrauerGroup` vocabulary. At the branch pin `BrauerGroup` is only a quotient, not
a group, and the required multiplication and quaternion-CSA instances are still
upstream work. Therefore the Brauer-valued statements in this layer remain
**prose targets until their types land**; no placeholder group, junk-valued class,
or private duplicate is authorized. Each milestone consumes the landed Mathlib
API when available, with the exact gates recorded in §Provenance (PRs #26377,
#28970, #41538, and the `Whysoserioushah/BrauerGroup` pipeline). Take only what the
invariants need; the general theory (Wedderburn uniqueness, Skolem–Noether,
centralizers, splitting fields, index) belongs to the
[semisimple-algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)
and is consumed, not rebuilt.

- `ℍ[K,a,b]` is a `CSA K` (consume #41538); its Brauer class `[(a,b)]`;
  `[(a,b)]² = 1` (`(a,b) ≃ (a,b)ᵒᵖ` via `star`… packaged through `IsAzumaya`).
- **Symbol bilinearity in `Br(K)`**: `[(a, bc)] = [(a,b)]·[(a,c)]` — the algebra
  identity `(a,b) ⊗ (a,c) ∼ (a,bc)` (Gille–Szamuely 1.5.2 shape / Lam III.2.11
  linkage), the point where the Layer-3 Hasse invariant's codomain becomes an
  honest group `Br(K)[2]` (or the subgroup `Quat(K)` it generates).
- The Hasse invariant restated with values in `Br(K)`, `s : {forms} → Br(K)`,
  and Lam V.3.19's `Ŵ(K) → BW(K)`-flavored packaging reduced to what we use:
  `(s, d)` as a complete invariant in dimension ≤ 3, and the `I²`-homomorphism
  of Layer 4 together with its factorization `I²/I³ → Br(K)[2]`. This bullet does
  not add injectivity of that factorization.

### Layer 6: forms over local fields

Over `ℚ_p` first (that is where Mathlib's types are), stated so that the
general-nonarchimedean-local versions are a hypothesis swap when the
[Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2) Layer 0 supplies
the field API; the dyadic case is **required** — it is the point. The
HassePrinciple contact gate in §Provenance applies before code or statement-shape adaptation.

- **Local square classes.** `#(ℚ_pˣ/(ℚ_pˣ)²) = 4` for odd `p`, `= 8` for `p = 2`,
  with explicit representatives (`{1, u, p, up}`; `{±1, ±5, ±2, ±10}`) — Serre II
  §3.3; stated through the Layer-0 `Nat.card` API on `Subgroup.square`, consuming
  Mathlib's Hensel and the landed `p`-adic square criteria (and HassePrinciple's
  `Padics/Squares.lean` when it lands).
- **The Hilbert symbol.** Defined by the norm/solvability criterion already
  available from Layer 2 (no new mathematics: `(a,b) = 1 ↔` the four-fold
  criterion holds over `ℚ_p`); values in `{±1}` because the quaternion side has
  exactly two classes locally — which is *proved here* as: there is exactly one
  division quaternion algebra over `ℚ_p` (uniqueness of the anisotropic quaternary
  form below).
- **Bimultiplicativity** (⚠ the hard dyadic-inclusive input — pin the route).
  Three known routes: (i) O'Meara-style direct computation with quadratic defect
  (63:11-63:13; dyadic-uniform, no cohomology); (ii) via Brauer-group
  multiplication (Layer 5) plus the two-classes theorem; (iii) via the mod-2 Tate
  duality of the local-fields roadmap. **Pin: route (i) as the theorem here**,
  keeping Layer 6 free of both cohomology and Layer 5; route (ii) becomes a
  stated compatibility corollary; for route (iii), the local-fields roadmap states
  the ONE bridge milestone — *its `n = 2` duality pairing is this Hilbert
  pairing* — and we cite that statement rather than duplicating it in either
  direction. Also **nondegeneracy** (Serre III Thm 2, O'Meara 63:13): for
  non-square `a` there is `b` with `(a,b) = −1`; and the norm-index-2 corollary
  `(Kˣ : N(K(√a)ˣ)) = 2`.
- **Explicit formulas** (Serre III Thm 1 — the worked-example goldmine):
  odd `p`: `(a,b) = (−1)^{αβ ε(p)} (u|p)^β (v|p)^α` for `a = p^α u`, `b = p^β v`
  (consume `legendreSym` and `TauCeti/NumberTheory/LegendreSymbol/SquareClass.lean`);
  `p = 2`: `(a,b) = (−1)^{ε(u)ε(v) + α ω(v) + β ω(u)}` with `ε(u) = (u−1)/2`,
  `ω(u) = (u²−1)/8 mod 2` read off `PadicInt.toZModPow 3` (adopt HassePrinciple's
  `epsilon`/`omega` once landed). Corollary: the full **8 × 8 Hilbert-symbol table
  over `ℚ_2`** on the representatives `{±1, ±5, ±2, ±10}`, as a decidable
  computation (`decide`/`norm_num`-discharged family) — the acceptance test that
  the dyadic formula is right.
- **The complete classification** (O'Meara 63:20 + 63:23, Serre IV §2): two
  regular forms over `ℚ_p` are equivalent iff `(dim, d, s)` agree (uniqueness),
  and every invariant triple satisfying the two low-dimensional constraints is
  realized (existence). Corollaries, each a named milestone: the isotropy
  criteria by rank (Serre IV Thm 6); the representation theorem (which square
  classes each form represents, O'Meara 63:21 / Serre IV cor. to Thm 6);
  `u(ℚ_p) = 4` (every form of `dim ≥ 5` is isotropic, O'Meara 63:19); **exactly
  one anisotropic quaternary form up to equivalence** — the norm form of the
  unique quaternion division algebra (O'Meara 63:17-18, Serre IV Thm 7 cor.) —
  `⟨1,1,1,1⟩` realizes it over `ℚ_2` (Hamilton quaternions ramified at `2`);
  unit-norm surjectivity for unramified quadratic extensions
  (`N(Eˣ) = uḞ²`, O'Meara 63:16 — the statement `gq2`'s
  `unramifiedQuadratic_units_are_norms` specializes).

### Layer 7: the Kummer cup bridge (first cohomological layer)

Consumes [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
Layer 7 for cup products and Layer 9 for Kummer: continuous `H^*(G_K, μ₂)` with cup products
and the isomorphism `H¹(G_K, μ₂) ≅ Kˣ/(Kˣ)²` are **their** milestones; this layer starts
where those types exist.

- The square-class dictionary `(·) : Kˣ/(Kˣ)² ≅ H¹(G_K, μ₂)` in the concrete
  cocycle normalization the profinite roadmap pins (compatibility with
  `TauCeti.SquareClassGroup` is a stated lemma).
- **The fifth equivalence**: `(a) ∪ (b) = 0` in `H²(G_K, μ₂)` iff the four
  Layer-2 conditions hold (Serre, *Local Fields* XIV §2 Prop. 4-5 shape;
  Gille–Szamuely 4.7). Route: the crossed-product/cyclic-algebra description of
  `(a,b)` against the cup of Kummer cocycles — coordinate the `H²`-of-cyclic
  computation with the profinite roadmap's low-degree API. Corollaries: the
  Steinberg relation `(a) ∪ (1−a) = 0` (from Layer 2's algebra split);
  `(a) ∪ (−a) = 0`; bilinearity of the cup restating Layer 5/6
  bimultiplicativity. This completes B11a's five-fold statement; the dyadic
  specialization is the Layer-6 symbol.

### Layer 8: Stiefel–Whitney classes

- **Definition** (Delzant; Milnor's `w` in *Algebraic K-theory and quadratic
  forms* §4): for `q ≅ ⟨a₁, …, aₙ⟩`, the total class
  `w(q) = ∏ᵢ (1 + (aᵢ)) ∈ H^*(G_K, 𝔽₂)`; well-definedness by exactly the Layer-0
  engine (permutation + one binary move — the binary move is the cup identity
  `(a)(b) = (c)(d)` given `⟨a,b⟩ ≅ ⟨c,d⟩`, i.e. Layer 7's bridge applied to
  Layer 2's binary criterion). `w` is `⊥`-multiplicative on classes.
- `w₀ = 1`, `w₁(q) = (d(q))` (**plain** discriminant — convention table), and
  `w₂` of a diagonal form is `∑_{i<j} (aᵢ)(aⱼ)` — the cohomological shadow of the
  Hasse invariant.
- ⚠ **The `w₂`-versus-Hasse comparison, exact.** `w₂(q)` equals the image of
  `s(q)` in `H²` *by definition of both sides on a diagonalization* — the trap is
  the *Witt/Clifford* invariant: `c(q)` differs from `s(q)` by the
  dimension-dependent `(−1,d)`/`(−1,−1)`-terms of Lam V.3.20, so any source
  phrasing "`w₂` = Hasse–Witt" (Fröhlich's and Serre's papers on trace forms use
  `w₂` against the *Witt* invariant, with Serre's formula
  `w₂(Tr) = (2)(d) + …`-type correction terms) must be translated through the
  convention table before formalization. Milestone: state and prove the exact
  identity `c(q)-image `= w₂(q) + [(−1)-terms per Lam V.3.20]` in `H²`, and keep
  `docs`-level notes mapping Fröhlich/Serre/Kahn statements onto it. The
  specializations `w(⟨1⟩ⁿ) = 1`, `w(⟨⟨a,b⟩⟩)`, and the `ℚ_2` values of `w₁, w₂`
  on the eight square classes are the acceptance examples.

### Layer 9: transfer and the Evens–Kahn formula (the B9 summit)

- **Scharlau transfer** (Lam VII §1, Scharlau's book Ch. 2 §5): for finite
  separable `L/K` and a nonzero `K`-functional `s`, the form `s_*(q)` on the
  `K`-space underlying the `L`-space of `q`; `dim_K s_*(q) = [L:K]·dim_L q`;
  regular for regular `q`; `s_*` additive over `⊥`; **Frobenius reciprocity**
  `s_*(q ⊗ res_{L/K} r) ≅ s_*(q) ⊗ r`; change of functional
  `(s ∘ λ·)_* q ≅ s_*(⟨λ⟩ ⊗ q)`; the induced `W(L) → W(K)` (a `W(K)`-module
  map, not a ring map). Default instance `Tr_* = (Algebra.trace K L)_*`:
  `Tr_*⟨1⟩` is the trace form (`Algebra.traceForm`), and for `L = K(√d)`,
  `Tr_*⟨1⟩ ≅ ⟨2, 2d⟩` — prove through
  `TauCeti/FieldTheory/Trace`'s diagonalization API. The twisted forms
  `Tr_*⟨a⟩` for `a ∈ Lˣ` are the objects Kahn's theorem evaluates.
- **The Evens norm, consumed.** The multiplicative transfer
  `𝒩 : H^*(H, 𝔽₂) → H^*(G, 𝔽₂)` for `[G : H] = 2` is the
  construction of PR #1 Layer 10 (Evens 1963; they own the operation and its axioms — in particular
  the degree-≤-2 expansion of `𝒩(1 + x)` in terms of corestriction and the
  degree-doubling term). This roadmap owns only its *application to forms*.
- **The Evens–Kahn / Kahn relative Stiefel–Whitney formula** (Kahn, *Classes de
  Stiefel–Whitney de formes quadratiques et de représentations galoisiennes
  réelles*, Invent. Math. 78 (1984) 223-256, **Théorème 2**; Kozlowski, Proc. AMS
  91 (1984) 309-313, Thm 1.1 for the homotopy-level transfer; Evens, Trans. AMS
  108 (1963), the norm): for a regular quadratic form `q` over `L`, `L/K`
  separable of finite degree, with `T(q) = Tr_*(q)`:
  `w(T(q)) = 𝒩(w(q)) · w(T(⟨1⟩))^r`, `r = rank q`, the product taken in
  `H^*(G_K, 𝔽₂)` — stated **at the quadratic-form level over an
  arbitrary field of characteristic ≠ 2** (Kahn's Théorème 2 carries no local
  hypothesis; `gq2` §11.2's instruction — no paper-specific diagonalizations in
  the foundational statement). Kahn's **Théorème 3** (the rank-1 case through the
  induced representation, with the `(2, d)`-correction) is the stated corollary
  bridging to trace forms of `⟨a⟩`. The **degree ≤ 2 expansion** — `w₁(T(q))` and
  `w₂(T(q))` in terms of `cor(a)`, `𝒩(a)`, and `w_{1,2}(T(⟨1⟩))` — is a separate
  named milestone (that is the shape `gq2`'s B9 consumes).
- **Finite-dyadic specialization, as the final acceptance example only**: `K`
  finite over `ℚ_2`, `L = K(√d)` quadratic, `q = ⟨a⟩` — the exact low-degree
  identity of `gq2`'s `relativeStiefelWhitney_dyadic`, whose left-hand sides are
  the Layer-8 classes of the Layer-9 twisted trace forms `Tr_*⟨a⟩`.

---

## Worked examples (acceptance criteria, keeping the definitions honest)

Discharge these alongside their layers; each catches a vacuous definition or a
sign error.

- `⟨1,1⟩ ≇ ⟨1,−1⟩` over `ℚ` (one is anisotropic, one is hyperbolic) — the
  smallest non-classification (Layer 1).
- `ℍ_q = ⟨1,−1⟩` represents every `a ∈ ℚˣ` (Layer 1 universality, computable
  witness `((a+1)/2)² − ((a−1)/2)² = a`).
- `ℍ[ℚ,−1,−1]` is a division algebra; `ℍ[ℚ,1,b] ≃ₐ M₂(ℚ)`; `(2, 5)` over `ℚ_2`
  is division while `(5, 2·…)` table entries as below (Layer 2).
- The four-fold equivalence instantiated over `ℚ_2` at `(a,b) = (2,5)` (all four
  false) and at `(a,b) = (5, −1)`… — one instance with all four conditions
  *holding* and one with all four *failing*, as separate examples (Layer 2/6;
  B11a-shaped).
- `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8`, `#(ℚ_pˣ/(ℚ_pˣ)²) = 4` for odd `p` (Layer 6).
- `(−1,−1)_{ℚ_2} = −1` and `(−1,−1)_{ℚ_p} = 1` for odd `p` (Hamilton quaternions
  ramified exactly at `2` and `∞` among these) — and over `ℝ`,
  `(−1,−1)_ℝ = −1` via `Quaternion.normSq` positivity (Layer 6; the `ℝ` case
  consumes Mathlib's `ℍ[ℝ]`).
- The full 8×8 `ℚ_2` Hilbert-symbol table on `{±1, ±5, ±2, ±10}` as decidable
  computations; sample single entries: `(2,5) = −1`, `(5,5) = 1` with witness
  `5 = 5² − 5·2²`, `(−1,−1) = −1` (Layer 6).
- Exactly one anisotropic quaternary form over `ℚ_2` up to equivalence, realized
  by `⟨1,1,1,1⟩`; every form of dimension 5 over `ℚ_p` is isotropic (Layer 6).
- `Tr_*⟨1⟩ ≅ ⟨2, 2d⟩` for `ℚ(√d)/ℚ` and for `ℚ_2(√d)/ℚ_2`, recovering
  `TauCeti/NumberTheory/EffectiveBounds/TraceForm.lean`'s `ℂ/ℝ` computation as
  the archimedean sibling (Layer 9).
- An Evens–Kahn low-degree instance over a small extension: `K = ℚ_2`,
  `L = ℚ_2(√5)` (unramified), `q = ⟨a⟩` for a unit `a`, with both sides of the
  degree-≤-2 identity computed on the eight square classes (Layer 9; the final
  B9-shaped acceptance).

## Ordering and parallelism

Layers 0–6 are cohomology-free and can be built now, before or in parallel with
PR #1; within them, Layer 0 is first (everything
diagonal rests on it), Layers 1 and 2 are independent of each other after
Layer 0, Layer 3 needs both, Layer 4 needs 1–3, Layer 5 needs 2–3 plus the
in-flight Mathlib CSA work it refactors onto, and Layer 6 needs 0–3 (its
bimultiplicativity route (i) deliberately avoids Layer 5). Layer 7 blocks on PR #1
Layer 7 (cup products) and Layer 9 (Kummer); Layer 8 on Layer 7; Layer 9's transfer
half is cohomology-free (it can proceed with Layers 1–3) while its Evens–Kahn half
blocks on PR #1 Layer 10 (Evens norm). PR #2 Layer 0 supplies the general local-field
vocabulary, Layer 1 the square-class finiteness interface in the valid regimes, and
Layer 8B the mixed-characteristic mod-2 duality bridge; only the general-local-field
restatement of Layer 6 and that bridge consume #2. This roadmap in turn supplies the
local classification and Hilbert-symbol/quaternion dictionary consumed by
[Integral Lattices PR #7](https://github.com/roed-math/TauCetiRoadmap/pull/7).

Until sibling branches merge, the PR links above are canonical. The family-wide assigned
root-list number for this roadmap is `18`; the integration pass must preserve it, import every
roadmap exactly once, and check all sibling links after their directories are present.

## References

- T. Y. Lam, *Introduction to Quadratic Forms over Fields*, GSM 67, AMS (2005) —
  PRIMARY. Ch. I (diagonalization I.2, hyperbolic I.3, Witt decomposition/
  cancellation I.4, chain equivalence I.5.2, reflections I.7), Ch. II (Witt
  ring, square classes), Ch. III (quaternion algebras and norm forms, III.2.7),
  Ch. V §3 (Clifford/Witt/Hasse invariants, V.3.17-3.21, the Wall caution
  p. 120), Ch. VI (local fields, VI.2), Ch. VII (Scharlau transfer VII.1).
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973) — PRIMARY for the
  local theory. Ch. II §3.3 (squares in `ℚ_p`, `ε`/`ω`), Ch. III (Hilbert symbol:
  III.1.1-1.2, Thm 1 formulas incl. `p = 2`, Thm 2 nondegeneracy), Ch. IV §2
  (invariants `d`, `ε`; Thm 5 well-definedness, Thm 6 isotropy, Thm 7
  classification, the unique anisotropic quaternary corollary).
- O. T. O'Meara, *Introduction to Quadratic Forms*, Springer (1963; Classics
  reprint 2000) — §63 (63:11-13 symbol computation and quadratic defect —
  bimultiplicativity route (i); 63:16 unramified norms; 63:17-18 the anisotropic
  quaternary space; 63:19 `u = 4`; 63:20 classification; 63:21 representation;
  63:23 existence). ⚠ Hasse symbol `∏_{i≤j}` — translate per the convention
  table.
- O. T. O'Meara, *Quadratic forms over local fields* (1955) — the paper
  antecedent of §63.
- B. Kahn, *Classes de Stiefel-Whitney de formes quadratiques et de
  représentations galoisiennes réelles*, Invent. Math. 78 (1984) 223-256 —
  Théorèmes 1-3; B9's source.
- A. Kozlowski, *The Evens-Kahn formula for the total Stiefel-Whitney class*,
  Proc. AMS 91 (1984) 309-313 — Thm 1.1.
- L. Evens, *A generalization of the transfer map in the cohomology of groups*,
  Trans. AMS 108 (1963) 54-65 — the norm map (consumed via the
  profinite-cohomology roadmap).
- P. Guillot, *The computation of Stiefel-Whitney classes*, Ann. Inst. Fourier 60
  (2010) 565-606 — computational companion for SW classes of representations.
- J. Milnor, *Algebraic K-theory and quadratic forms*, Invent. Math. 9 (1970)
  318-344 — §4: `w` on square classes, the `I^n`-filtration picture.
- P. Gille, T. Szamuely, *Central Simple Algebras and Galois Cohomology*, CUP
  (2nd ed. 2017) — 1.1.9 (four-fold criterion), 1.5 (symbol bilinearity), Ch. 4
  (cup-product bridge); the structural route's reference of record.
- W. Scharlau, *Quadratic and Hermitian Forms*, Springer (1985) — Ch. 2 §5
  (transfer), Ch. 5 (local fields).
- R. Elman, N. Karpenko, A. Merkurjev, *The Algebraic and Geometric Theory of
  Quadratic Forms*, AMS Colloq. 56 (2008) — II §7 is the source of Mathlib's
  `Nondegenerate`; the modern reference for everything Layers 0-4.
- J.-P. Serre, *Local Fields*, GTM 67, Springer (1979) — XIV §2 (symbol = cup,
  norm criterion; B11a's citation).
- L. C. Grove, *Classical Groups and Geometric Algebra*, GSM 39, AMS (2002) —
  cited only for the characteristic-2 exclusion note.

## Provenance and coordination

**Coordination snapshot (checked 2026-08-01).** This review made no external contact and does
not claim an ownership agreement. Public repositories and PR metadata were inspected only.
The following gates are required before implementation crosses project boundaries:

- **Project / authors:** `mariainesdff/HassePrinciple` — Nirvana Coppola, María Inés de
  Frutos-Fernández, and contributors. **Exact revision:**
  [`d2802ddce55e`](https://github.com/mariainesdff/HassePrinciple/commit/d2802ddce55ef34045f68c5bf39c0598e7d0e988).
  **Licence:** Apache-2.0. **Overlap:** chain equivalence, Hilbert symbol, `p`-adic squares,
  Hasse–Minkowski invariants. **Contact / coordination status:** not contacted during this
  review. **Agreed ownership:** none recorded. **Plan:** independently state the intrinsic
  general-field and local-classification milestones; consume files only after they land in
  Mathlib or after explicit coordination. **Refactor trigger:** matching `ForMathlib` work
  lands upstream. **Gate:** before adapting code, proof organization, or project-specific
  statement shapes, contact the maintainers and record the division of work.
- **Project / authors:** Mathlib central-simple/Brauer work — Yunzhou Xie, Joël Zhang,
  Mathias-Stout, J. Springer, and the contributors to PRs #26377, #28970, #41536, #41538.
  **Exact revisions / PRs:** all four PRs were still open on 2026-08-01 at heads
  `13cac7e3b9bb`, `5a2bcb298759`, `e95984de0341`, and `86493005d20f`, respectively.
  **Licence:** Mathlib Apache-2.0. **Overlap:** Brauer multiplication, reduced norm/trace,
  quaternion directory/API, and quaternion central simplicity. **Contact / coordination
  status:** not contacted during this review. **Agreed ownership:** none recorded externally;
  within this roadmap family the landed Semisimple Algebras roadmap owns general CSA/Brauer
  theory. **Plan:** consume landed Mathlib declarations; keep unexpressible Layer-5 targets in
  prose. **Refactor trigger:** each cited PR lands. **Gate:** no private duplicate group
  structure or quaternion-CSA instance; a temporary compatibility wrapper may be proposed only
  after author contact, must expose the upstream vocabulary, and must carry a deletion trigger.
- **Project / authors:** `Whysoserioushah/BrauerGroup` and contributors. **Exact revision:**
  [`283e0df7dc15`](https://github.com/Whysoserioushah/BrauerGroup/commit/283e0df7dc15cd8b469a73fbc763f74637c87147).
  **Licence:** Apache-2.0. **Overlap:** the full Brauer-group program and its upstream staging.
  **Contact / coordination status:** not contacted during this review. **Agreed ownership:**
  none recorded. **Plan:** track and consume upstreamed Mathlib results, not migrate staging
  code into Tau Ceti. **Refactor trigger:** a required group operation or class theorem lands
  in Mathlib. **Gate:** no code adaptation or alternate API without recorded coordination.

- **Sibling boundaries.** The
  [Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)
  owns continuous `H^*`, Layer-7 cup products, Layer-9 Kummer, and the Layer-10 Evens
  norm — this roadmap's Layers 7–9 consume those precise milestones and state only the
  quadratic-form content. [Local Fields PR #2](https://github.com/roed-math/TauCetiRoadmap/pull/2)
  owns local-field structure theory, unit filtrations, and the mixed-characteristic
  mod-2 Tate-duality bridge in its Layer 8B; it states the single theorem identifying
  that pairing with the Layer-6 Hilbert pairing, which we cite and do not restate.
  [Pro-p Groups PR #3](https://github.com/roed-math/TauCetiRoadmap/pull/3) has no direct
  interface with this roadmap. The
  [semisimple algebras roadmap](../RepresentationTheory/SemisimpleAlgebras/README.md)
  (landed) owns general CSA/Skolem-Noether/Brauer-group theory (its Layers 4-6);
  our Layer 5 takes exactly the quaternion case and the 2-torsion packaging, and
  where both roadmaps name the same fact (e.g. the Brauer group's group
  structure) the semisimple-algebras statement is the definition of record.
- **Neighboring Tau Ceti roadmaps.** The
  [multiquadratic roadmap](../Multiquadratic/README.md) shares Layer 0's
  square-class language (via the landed `SquareClassGroup.lean`) and the
  `Completed/EffectiveBounds` roadmap contributed the trace-form and
  unit-square-class files we consume; both interfaces are listed in "What Tau
  Ceti already has".
- **External coordination.** HassePrinciple (Coppola, de Frutos-Fernández) and
  the Mathlib CSA line (Xie, Zhang; Whysoserioushah's staging repo; Mathias-Stout
  and J. Springer's quaternion PRs) are detailed in "What is already in motion".
  Their current uncontacted status and the implementation gates are recorded above;
  re-run the PR search and update the exact revisions at implementation time.
- **`gq2-lean` provenance (secondary; improve rather than canonize).** The
  [`roed-math/gq2-lean`](https://github.com/roed-math/gq2-lean) project
  (Apache-2.0, same ownership as this roadmap) contains working single-purpose
  versions of several targets, over dyadic bases only; they are evidence the
  statements are formalizable and a quarry for proofs, **not** prescriptions of
  form. Map (gq2 file → layer here): `GQ2/StiefelWhitney.lean` (`swOne`/`swTwo`
  with proved Delzant well-definedness over finite dyadic `k`) → Layers 0, 8;
  `GQ2/TraceForm.lean` (`traceFormOne`/`traceFormTwisted` diagonalizations) →
  Layer 9; `GQ2/HilbertSymbol*.lean` (`ℚ_2` symbol via `ε`/`ω` with the
  necessity/sufficiency case analysis — in effect the 8×8 table) → Layer 6;
  `GQ2/Kummer.lean`, `GQ2/QuadraticAdjoin.lean` (Kummer cocycles, quadratic
  coordinates) → Layer 7 (superseded by the profinite roadmap's API);
  `GQ2/EvensKahn.lean`, `GQ2/EvensKahnDerived.lean` (index-2 two-point Evens
  norm, the derived eq. (111)) → Layer 9; `GQ2/RegularIsometry.lean`,
  `GQ2/RegularSummand.lean`, `GQ2/TrivialSelfDual.lean` → not migrated (marked
  presentation-specific). The `gq2` axioms B11a
  (`hilbertSymbol_normCriterion_finiteDyadic`) and B9
  (`relativeStiefelWhitney_dyadic`) in `GQ2/Foundations/Axioms.lean` are the
  intended *final consumers*: B11a follows from Layer 2's four-fold criterion +
  Layer 7's cup bridge specialized by Layer 6, and B9 from Layer 9's degree-≤-2
  Evens-Kahn specialized to finite dyadic bases. `GQ2/QuadraticFp2.lean` and
  `GQ2/GaussSigns*.lean` are characteristic-2/finite-field material, outside this
  roadmap's scope by the standing exclusion.
- **License note.** The independent comparison formalization
  [`davidturturean/gq2-lean-turturean`](https://github.com/davidturturean/gq2-lean-turturean)
  is GPL-licensed: cite for comparison only; no code transfer into Apache-licensed
  Tau Ceti without an explicit licensing decision.
