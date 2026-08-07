# Roadmap: orthogonal and spin groups

Mathlib has the Clifford algebra and nothing for it to act on. It has `CliffordAlgebra` over a
commutative ring with the embedding `ι`, the grade involution `involute`, the anti-automorphism
`reverse`, the `ZMod 2` grading and the even subalgebra; it has `lipschitzGroup`, `pinGroup` and
`spinGroup` with their group structures and the theorems that twisted conjugation preserves the
embedded copy of the underlying module; it has `Module.reflection` as a linear equivalence
attached to a functional; it has `QuadraticMap.IsometryEquiv`, carrying no group structure; it has
`Matrix.orthogonalGroup`, which is the orthogonal group of the standard form only and which
carries no topology; it has `RestrictedProduct` with its topology, the finite adele ring of a
Dedekind domain, the adele ring of a number field, and Haar measure with quotient covolumes. What
it has none of is the spinor norm, any adelic point group, strong approximation, or a Tamagawa
measure. `spinGroup` has no consumer anywhere in the library.

This roadmap develops the arithmetic of the orthogonal and spin groups attached to a
finite-dimensional nondegenerate quadratic space over a field of characteristic not two: the
spinor norm through reflections, the Clifford comparison and its spinor kernel, local topological
point groups, finite adelic restricted products, strong approximation for `Spin`, and the
canonically normalized orthogonal Tamagawa-volume theorem. It supplies the reusable
group-theoretic and adelic infrastructure consumed by the [integral lattices
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7).

Two theorems here are the reason the roadmap exists, and they are independent of each other.
**Strong approximation for `Spin` is a noncompact-place theorem**: it requires each
`ℚ`-almost-simple factor of `Spin(V)` to be noncompact at some place of a chosen finite set `S`,
a condition a positive definite form can meet at a finite place. It is therefore the corollary at
`S = {∞}`, and not the theorem itself, that is about indefinite forms, and that corollary is what
Eichler's theorem on lattice classes runs on. **The Tamagawa volume theorem for `SO` is a separate
global theorem**, with no isotropy hypothesis at all, and it is the input to the mass formula of
positive definite genera. Neither is a corollary of the other, no proof here derives one from the
other, and no ordering statement below puts one after the other.

**Scope exclusions** (choices, not omissions; each names its owner). **The Clifford algebra, the
Pin and Spin groups, the orthogonal group of a quadratic form, and the low-rank exceptional
isomorphisms over an algebraically closed field** belong to the [spin representations
roadmap](../RepresentationTheory/SpinRepresentations/README.md); the general-field spinor norm,
the general-field image of `Spin → SO`, and the twisted rational forms of the low-rank
isomorphisms are this roadmap's. **Reflections, Cartan–Dieudonné, Witt decomposition, Witt
cancellation, Witt's extension theorem, square classes, Hasse invariants, the Hilbert symbol, and
the classification of forms over local fields** belong to the [quadratic form invariants
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4). **Affine group schemes,
representability, root data, and the classification of reductive groups** belong to the [reductive
algebraic groups roadmap](../ReductiveGroups/README.md); Layer 3A consumes its functor of points
and its structure theory to build the specialized schemes `O_Q`, `SO_Q` and `Spin_Q`, which Layers
4 and 5 require. **Lattice stabilizers and their arithmetic**, isometry classes, genera, spinor
genera, Eichler's theorem for lattice classes, local densities, and the mass formula belong to the
[integral lattices roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7); Layer 3E
constructs the `ℤ`-span of a chosen basis and proves no arithmetic about it. **Characteristic
two** is excluded: every field here has `2` invertible, and the Dickson invariant is not
developed. **The connected components of the real orthogonal groups**, their maximal compacts and
their symmetric spaces are outside. **Automorphic representations, the Weil representation, and
Siegel–Weil** are outside. **Hermitian and unitary groups, quadratic forms over division algebras,
and orthogonal groups of forms over rings of integers of number fields** are outside.

The general Tamagawa machinery of Layer 5A to 5E is **in** scope, and is written to be independent
of quadratic forms so that it can be lifted into a roadmap of its own without rewriting.

Suggested homes, mirroring Mathlib's directory conventions:

- `TauCeti/LinearAlgebra/QuadraticForm/OrthogonalGroup/` for Layers 0 and 1, the field-level
  algebra with no arithmetic in it, beside the ambient form theory the quadratic form invariants
  roadmap puts at `TauCeti/LinearAlgebra/QuadraticForm/`.
- `TauCeti/NumberTheory/QuadraticForm/OrthogonalGroup/` for Layers 2 to 5: local point groups,
  restricted products, approximation and measures.
- `TauCeti/Topology/Algebra/RestrictedProduct/` for the generic restricted-product API of Layer 3,
  which is about topological groups and not about quadratic forms. Every roadmap that eventually
  wants the adelic points of a group will want it, and it should not be buried under a
  quadratic-form namespace.

## Standing hypotheses and pinned conventions

Decided once here; every layer states its results against this table.

- **The quadratic space.** `K` is a field with `[Invertible (2 : K)]`, `V` a finite-dimensional
  `K`-vector space, and `Q : QuadraticForm K V`. This is the quadratic form invariants roadmap's
  standing hypothesis, and its results are consumed throughout. Nondegeneracy is
  `QuadraticMap.Nondegenerate Q`, which that roadmap calls regularity in prose; results are proved
  without it wherever it costs nothing. Dimension is `Module.finrank K V`.
- **The bilinear form, un-halved.** `B := QuadraticMap.polar Q`, bundled as
  `QuadraticMap.polarBilin Q`, so that `B x x = 2 • Q x` (`QuadraticMap.polar_self`, whose
  right-hand side is an `nsmul` and not a product) and `Q x = B x x / 2`. This is Mathlib's polarization, not the half-polar form of sources whose
  bilinear form satisfies `b v v = Q v`. Every displayed formula below is against `B`.
- **⚠ The reflection formula.** For `v` with `Q v ≠ 0`, these two spellings are **equal**, and
  both are correct:

      τ_v (x) = x - (B x v / Q v) • v
              = x - (2 · B x v / B v v) • v,

  since `B v v = 2 • Q v`. Their equality is a stated lemma, not a remark, because the two forms
  are what the two halves of the literature write and a proof will meet both. What is genuinely
  wrong is the **mixed** form `x - (2 · B x v / Q v) • v`, obtained by taking a half-polar
  source's `2 · b x v / b v v`, substituting `b ⇝ B` in the numerator, and leaving `Q v` in the
  denominator: it sends `v` to `-3v`. The first spelling above is the quadratic form invariants
  roadmap's, and it is what Mathlib's `Module.reflection` wants: that takes `f : V →ₗ[K] K` and
  `x : V` with `f x = 2` and returns `y ↦ y - f y • x`, and `f := (Q v)⁻¹ • polarBilin Q v` has
  `f v = B v v / Q v = 2` on the nose.
- **Orthogonal group.** `O(Q)` is `orthogonalGroup Q : Subgroup (V ≃ₗ[K] V)` and `SO(Q)` is
  `specialOrthogonalGroup Q`, both from the [spin representations
  roadmap](../RepresentationTheory/SpinRepresentations/README.md). They are consumed, never
  redefined, and no second notion of isometry is introduced beside Mathlib's
  `QuadraticMap.IsometryEquiv`. `Matrix.orthogonalGroup`, being the orthogonal group of the
  standard form, is a comparison target after choosing a basis and never a definition. We say
  **proper** for an element of `SO(Q)` and **improper** otherwise.
- **`SO` means determinant one**, which is correct in characteristic not two. The determinant is
  `LinearEquiv.det` restricted to `O(Q)`.
- **Square classes.** `Kˣ/(Kˣ)²` is the quadratic form invariants roadmap's, interoperating with
  the landed `TauCeti.SquareClassGroup`; in quotient-free statements "same square class" is
  `IsSquare (a * b)` for units. The spinor norm lands there and adds no third spelling.
- **The Clifford action is twisted conjugation.** The Lipschitz, Pin and Spin groups act on `V`
  by `x ↦ involute g * x * g⁻¹`, matching Mathlib's `pinGroup` and `spinGroup`, which are defined
  through `involute`. Under this action an anisotropic `v` acts as `τ_v` exactly, with no sign.
  Untwisted conjugation sends `v` to `-τ_v`, so a source using it differs from this roadmap by
  `(-1)^r` on a product of `r` vectors; the comparison is stated once as a lemma and never left
  to the reader.
- **The spinor norm** is `θ : O(Q) → Kˣ/(Kˣ)²`, `θ(τ_{v₁} ⬝⬝⬝ τ_{v_r}) = [Q v₁ ⬝⬝⬝ Q v_r]`,
  defined through a reflection factorization and proved independent of it. It is not defined as a
  quotient by the image of `Spin`: the reflection formula is the API the lattice side computes
  with, one reflection at a time.
- **⚠ The Clifford norm is the `reverse` norm, and the sign matters on odd length.** `N g` means
  `reverse g * g`, so that `N (ι v) = Q v` **exactly**, by `reverse_ι` followed by `ι_sq_scalar`.
  Mathlib's `star` is `reverse ∘ involute`, giving the other anti-involution, and
  `star (ι v) * ι v = -Q v` by `star_ι`. The two norms agree on even homogeneous elements and
  differ by `(-1)^r` on a product of `r` vectors. This is not a cosmetic difference that a
  square-class codomain absorbs: `[Q v]` and `[-Q v]` differ by `[-1]`, which is nontrivial over
  ℚ and over `ℚ_p`, so the two conventions genuinely disagree on `O(Q)` at odd reflection length,
  and agree on `SO(Q)`. Every statement below uses the `reverse` norm.
- **Places and adeles.** Over ℚ we write `ℚ_v` with `ℚ_∞ = ℝ`; for a number field the places are
  as the global class field theory roadmap names them. `𝔸_f` is the finite adeles, `𝔸` the full
  adeles, `𝔸^S` the adeles away from a finite set `S` of places. Which is meant is never left
  implicit: Layer 3 builds finite adelic groups, Layer 4 approximates away from a set containing
  the archimedean place, Layer 5 works with the full adeles.
- **Adelic points are restricted products of point groups.** `O(V)(𝔸_f)` means the restricted
  product of the topological groups `O(V_p)` relative to a chosen family of compact open
  subgroups, not the orthogonal group of a form over the ring `𝔸_f`. The compact-open family is a
  parameter, so a consumer can instantiate it with the stabilizers of its own lattice.
- **Haar normalization** is fixed in Layer 5 and is intrinsic: defined from the quadratic space,
  not from a chosen basis or lattice, and proved invariant under isometry. The comparison with the
  lattice-relative normalization a local density is stated against is a milestone of that layer,
  not an assumption.

## What Mathlib already has (consume)

Capability statements only. The pin, the inspection date, the upstream pull requests tracked and
the re-check notes are in [`PROVENANCE.md`](PROVENANCE.md).

- **Clifford algebras:** `Mathlib/LinearAlgebra/CliffordAlgebra/` (14 files) has `ι` with
  `ι_sq_scalar`, the universal property, `map` and **`equivOfIsometry`**, the only declaration
  anywhere that turns an isometry of quadratic forms into an isomorphism of Clifford algebras, and
  therefore the route every `Equivalent`-invariance statement in Layer 1 takes;
  `Conjugation.lean` has `involute`, `reverse` and
  their interaction lemmas; `Star.lean` has `star_def : star x = reverse (involute x)` and
  `star_ι : star (ι Q m) = -ι Q m`, which is what pins the sign in the Clifford norm;
  `Grading.lean` has `evenOdd` with `GradedAlgebra`, `evenOdd_isCompl` and the even and odd
  induction principles; `Even.lean` has the even subalgebra with its lift; **`Inversion.lean` has
  `invertibleιOfInvertible`**, which is how an anisotropic vector becomes a unit and hence enters
  the Lipschitz group; `Equivs.lean` already identifies small Clifford algebras with ℂ and with
  the quaternions.
- **Lipschitz, Pin and Spin:** `SpinGroup.lean` has
  `lipschitzGroup Q : Subgroup (CliffordAlgebra Q)ˣ` defined as the closure of the preimage of the
  vectors, `pinGroup Q` and `spinGroup Q` as submonoids with `Group` instances, and the theorems
  `conjAct_smul_range_ι` and `involute_act_ι_mem_range_ι` that the action preserves the embedded
  copy of `V`. ⚠ Every such theorem carries `[Invertible (2 : R)]`, and the docstring records that
  the closure definition of `lipschitzGroup` agrees with the "conjugation preserves `V`"
  definition only in finite dimensions, with the reverse inclusion an open TODO. Note that
  `pinGroup` is defined as an intersection with `unitary`, so membership already encodes
  `reverse (involute x) * x = 1`; Layer 1C states the Clifford norm against that rather than
  introducing a competing one.
- **Reflections:** `Mathlib/LinearAlgebra/Reflection.lean` has `Module.preReflection` and
  `Module.reflection` as linear equivalences from a functional `f` and a vector `x` with `f x = 2`,
  with involutivity, `reflection_apply_self`, and the products-of-two-reflections API.
  `Mathlib/LinearAlgebra/RootSystem/OfBilinear.lean` has `LinearMap.IsReflective` with
  `coroot_apply_self` supplying the `f x = 2` hypothesis from a form, and
  `isOrthogonal_reflection`, the only statement anywhere that a reflection preserves a bilinear
  form. **Gap: there is no determinant of `Module.reflection`.** The only reflection determinant in
  Mathlib is `Submodule.det_reflection` for the inner-product-space reflection.
- **Quadratic forms:** `QuadraticForm/Basic.lean` has `polar`, `polarBilin`, `polar_self`,
  `Anisotropic` and `exists_orthogonal_basis` (with `[Invertible (2 : K)]`);
  `IsometryEquiv.lean` has `QuadraticMap.IsometryEquiv` with `refl`, `symm`, `trans` and **no group
  structure**; `Radical.lean` has `Nondegenerate` and the radical API.
- **Matrix groups:** `Mathlib/LinearAlgebra/UnitaryGroup.lean` has `Matrix.orthogonalGroup` as an
  abbreviation for `Matrix.unitaryGroup` with the trivial involution, so the standard form only,
  with `mem_orthogonalGroup_iff : A ∈ orthogonalGroup n R ↔ A * Aᵀ = 1`, and
  `Matrix.specialOrthogonalGroup`. ⚠ **Neither carries a topology instance, and neither is known
  compact**; only `SL n R` and `GL n R` have topology at the pin. Layer 2 therefore topologizes
  `O(Q)` through `Module.End K V`, not through a matrix group.
- **Restricted products:** `Mathlib/Topology/Algebra/RestrictedProduct/` (three files) has
  `RestrictedProduct` as a subtype of the dependent product cut out by an `∀ᶠ` condition relative
  to an arbitrary filter, with `structureMap`, `inclusion`, algebra instances up to `CommRing`
  through subobject classes, the evaluation homomorphisms, the inductive-limit topology,
  `isOpen_forall_mem`, **`isOpenEmbedding_structureMap`**, **`locallyCompactSpace_of_group`**, the
  topological group and ring instances, `mapAlong` with its monoid- and ring-hom versions, and
  `unitsEquiv`. This is a better substrate than a first look suggests. **⚠ Gap: there is no
  congruence API at all.** There is no `MulEquiv`, `RingEquiv` or `Homeomorph` induced by
  componentwise equivalences, only one-directional homomorphisms, so the change-of-compact-open
  comparison of Layer 3A has to be built here.
- **Adeles:** `Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean` defines `FiniteAdeleRing`
  as a `RestrictedProduct` of adic completions relative to their integers, with its topological
  ring structure and `unitEmbedding`; `Mathlib/NumberTheory/NumberField/AdeleRing.lean` is 74
  lines and defines `AdeleRing` as a product together with `principalSubgroup`, about which
  **nothing is proved**: no discreteness, no cocompactness. `ProdAdicCompletions` no longer exists.
  Nothing constructs the points of a group over the adeles.
- **Measure theory:** `Mathlib/MeasureTheory/Measure/Haar/` has `haarMeasure` for a locally
  compact Hausdorff Borel topological group, with **no second-countability hypothesis for
  existence** (it is needed only for σ-finiteness), `IsHaarMeasure`, `haarScalarFactor` and the
  uniqueness results, `mulEquivHaarChar`, and `Quotient.lean`'s `haarMeasure_quotient`.
  `MeasureTheory/Group/FundamentalDomain.lean` has `IsFundamentalDomain`,
  `QuotientMeasureEqMeasurePreimage` and `covolume`. ⚠ Three constraints that shape Layer 5:
  `covolume` is `ℝ≥0∞`-valued and is `0` when no fundamental domain exists; `haarMeasure_quotient`
  wants `Γ` countable, `μ` finite, and the measure both left-Haar and right-invariant; and **there
  is no `IsUnimodular` class**, so unimodularity is spelled as that pair of typeclasses.
- **Signature:** `Mathlib/LinearAlgebra/QuadraticForm/Signature.lean` has `sigPos` and `sigNeg`
  with `Equivalent`-invariance, Sylvester uniqueness, and `sigPos_add_sigNeg_add_radical`. ⚠ They
  are in the **root namespace**, not under `QuadraticForm`, despite the file's docstring;
  `QuadraticForm.sigPos` does not exist.
- **`p`-adics:** `Mathlib/NumberTheory/Padics/` has `ℤ_[p]` and `ℚ_[p]`, Hensel's lemma,
  `PadicInt.compactSpace`, and `ProperSpace ℚ_[p]`, from which local compactness follows by
  instance search although no declaration names it.

## What Tau Ceti already has (consume)

- **The [spin representations roadmap](../RepresentationTheory/SpinRepresentations/README.md)**,
  consumed by name for the objects this roadmap builds on and does not restate: its Layer 1
  Clifford structure theorem; its Layer 2 `orthogonalGroup Q` and `specialOrthogonalGroup Q` with
  the comparison to `Matrix.orthogonalGroup` under a basis, `ιRangeEquiv`, `pinToOrthogonal`,
  `spinToSpecialOrthogonal`, the theorem that a unit vector maps to a reflection, and the kernel
  `{±1}` of the double cover; and its Layer 6 low-dimensional exceptional isomorphisms. That
  roadmap proves surjectivity of the double cover over an algebraically closed field, and its
  Clifford structure theorem is stated there too. ⚠ **Ownership of the general-field theory is
  here, and is not shared**: the spinor norm, the graded centre over a general field (Layer 1B),
  the image of `Spin → SO` at `K`-points, and the twisted rational forms of the low-rank
  isomorphisms are this roadmap's targets, and the spin representations roadmap consumes them if
  it needs them. Its algebraically closed structure theorem does not supply Layer 1B, which is why
  Layer 1B is owned rather than cited. This roadmap also adds the theory of `O(Q)` the
  representation theory has no reason to prove: the determinant, base change, and the bilinear
  dictionary.
- **The [quadratic form invariants
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4)**, consumed by name: its Layer 0
  square-class calculus and orthogonal bases; its Layer 1 hyperbolic planes, Witt decomposition,
  Witt cancellation, **Witt's extension theorem**, **reflections** with the formula pinned above,
  and **Cartan–Dieudonné**, that every isometry of a regular `n`-dimensional space is a product of
  at most `n` reflections; its Layer 3 `discr` and `signedDiscr`; its Layer 6 Hilbert symbol and
  the classification of forms over a finite extension of `ℚ_p` by `(dim, d, s)`, which is what
  makes the local spinor-norm images of Layer 2 computable. Its standing `[Invertible (2 : K)]`
  is this roadmap's too.
- **The [local fields roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2)**, for the local
  structure Layer 2 needs: local compactness of a nonarchimedean local field with `𝒪[K]` compact
  open and `Kˣ` locally compact (its Layer 0), and the power-class cardinality formula of its
  Layer 1, whose `n = 2` case gives finiteness of `Kˣ/(Kˣ)²`. That roadmap does not state
  openness of `(Kˣ)²` on its own, and openness is what makes the square-class group discrete and
  hence the spinor norm continuous; its Layer 1 instance `U(K, 2e+1) ⊆ (Kˣ)²` supplies it, since
  the unit filtration is open, and Layer 2 below cites it in that form.
- **The [global class field theory
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/6)**, for one theorem: its Layer 11
  Hilbert reciprocity `∏_v (a,b)_v = 1`. Layer 5's passage from the local spinor-norm quotients to
  the global one is exactly a reciprocity statement, and it is consumed from there rather than
  reproved. This is the same theorem the integral lattices roadmap consumes.
- **`TauCeti/FieldTheory/SquareClassGroup.lean`** (landed): `TauCeti.SquareClassGroup K`, the
  **additive** avatar `Additive Kˣ ⧸ (Subgroup.square Kˣ).toAddSubgroup` as a `ZMod 2`-vector
  space, with `squareClass` and its characterizations. ⚠ The spinor norm is multiplicative, so its
  codomain is the **multiplicative** avatar `Kˣ ⧸ Subgroup.square Kˣ` that the quadratic form
  invariants roadmap's Layer 0 adds, and the two are not interchangeable without a map. Four things
  are pinned rather than left as "interoperating with": the unit-to-square-class homomorphism; the
  named equivalence between the multiplicative avatar and the landed additive one; base change along
  a field homomorphism, which is what the local and adelic codomains of Layers 2 and 3 are built
  from; and the single spelling used by `spinorNorm`. Until that roadmap lands, this roadmap's
  prototype carries the same name and type, so adoption is a deletion and an import.
- **`TauCeti/LinearAlgebra/OrthogonalGroup.lean`** (landed):
  `orthogonalGroupToLinearIsometryEquiv`, the Euclidean orthogonal group as linear isometries.
  Layer 0's comparison for a positive definite real form lands next to it, and Layer 2's
  compactness statement at the real place uses it.
- **The [integral lattices roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7)** is the
  consumer, not a dependency. It takes four interfaces, named here so the two documents can be
  checked against each other: the spinor norm on `O(V_p)` with `Spin → SO` and its image (Layers 1
  and 2), finite adelic restricted products of the three point groups (Layer 3), the `S = {∞}`
  corollary of strong approximation for `Spin(V)` with `V` indefinite of dimension at least 3
  (Layer 4E), and canonical local Haar measures with `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` (Layers 5G
  and 5I). ⚠ Its Layer 4B additionally needs Layer 0C, the identification of the automorphism
  group of a symmetric bilinear form with that of its quadratic form, which is what places its
  bilinear-first `O(L)` inside `O(V_p)`.

### Dependencies, by milestone

Each row is a theorem or interface consumed by name, not a whole roadmap.

| Consumed | From | Used by |
| --- | --- | --- |
| `orthogonalGroup Q`, `specialOrthogonalGroup Q`, the matrix comparison | Spin Representations, Layer 2 | Layers 0 to 5 |
| `ιRangeEquiv`, `pinToOrthogonal`, `spinToSpecialOrthogonal`, kernel `{±1}` | Spin Representations, Layer 2 | Layer 1 |
| the Clifford structure theorem | Spin Representations, Layer 1 | Layer 1 |
| the low-dimensional exceptional isomorphisms | Spin Representations, Layer 6 | Layers 4, 5 |
| reflections, with the pinned formula | Quadratic Form Invariants, Layer 1 | Layers 0, 1 |
| Cartan–Dieudonné | Quadratic Form Invariants, Layer 1 | Layer 1 (well-definedness of `θ`) |
| Witt cancellation and Witt's extension theorem | Quadratic Form Invariants, Layer 1 | Layers 0, 2 |
| orthogonal bases over a field with `2` invertible | Quadratic Form Invariants, Layer 0 | Layers 0, 1 |
| the square-class group and its calculus | Quadratic Form Invariants, Layer 0 | Layers 1, 2, 5 |
| the classification over `ℚ_p` by `(dim, d, s)`, with the Hilbert symbol | Quadratic Form Invariants, Layers 3, 6 | Layer 2 |
| local compactness, `𝒪[K]` compact open, `U(K, 2e+1) ⊆ (Kˣ)²` | Local Fields, Layers 0, 1 | Layers 2, 3 |
| Hilbert reciprocity `∏_v (a,b)_v = 1` over ℚ | Global Class Field Theory, Layer 11 | Layer 5H |
| the functor of points of an affine group scheme, and morphisms of such | Reductive Groups, Layer 0 | Layer 3A |
| smoothness, connectedness, semisimplicity, simple connectedness, central isogenies | Reductive Groups, Layers 3, 6 | Layer 3A |
| the decomposition of a semisimple group into `K`-almost-simple factors | Reductive Groups, Layer 7 | Layers 3A, 4D |
| finite-dimensionality of `CliffordAlgebra Q`, that is `dim = 2^n` | Spin Representations, Layer 0 | Layer 2A |
| the multiplicative square-class avatar `Kˣ ⧸ Subgroup.square Kˣ` and its additive comparison | Quadratic Form Invariants, Layer 0 | Layers 1D, 2F, 3F |

## What is missing (build here)

The spinor norm, which nothing upstream and no sibling defines: its construction from a reflection
factorization, its independence of that factorization, its multiplicativity, its behaviour under
equivalence and base change, and the identification of the spinor kernel as the image of `Spin`.
The theory of `O(Q)` that the arithmetic needs and the representation theory does not: that the
determinant lands in `μ₂` and `SO(Q)` has index exactly 2, base change along a field extension,
functoriality, the identification of `O(Q)` with the automorphism group of the polar bilinear
form, and the explicit reflection-transitivity lemmas that a spinor-norm computation runs on.
Local topological point groups with the continuity of the determinant, the spinor norm and the
Spin action, and sharp compactness criteria. A congruence API for restricted products, absent
upstream, and the orthogonal specialization with diagonal rational points. Eichler transvections
and strong approximation for `Spin`. Canonical Haar measures at every place with their invariance
and product, finiteness of the adelic covolume, the measure comparison along `Spin → SO`, and the
Tamagawa volume theorem. None of this exists upstream.

`Suggested.lean` pins the load-bearing objects (`spinorNorm`, the reflection through
`Module.reflection`, the determinant homomorphism, the restricted-product specialization) and the
named milestones below as `sorry`-targets, so that each is claimable and the principal statements
are machine-checked to be expressible against the pinned Mathlib. The Tamagawa statements of Layer 5
stay in prose until Layer 3's adelic groups and Layer 5's measures exist in `TauCeti/`, at which
point they are added there with `sorry`; nothing stands in for them in the meantime, since a
`Prop`-valued placeholder would assert nothing.

---

## The build, in layers

### Layer 0: the orthogonal group, and what the arithmetic needs from it

**Direct prerequisites.** Mathlib: `QuadraticMap.IsometryEquiv`, `LinearEquiv.det`, `polarBilin`,
`Module.reflection`, `BilinForm.baseChange`. Spin Representations Layer 2: `orthogonalGroup`,
`specialOrthogonalGroup`. Quadratic Form Invariants Layer 0: orthogonal bases; Layer 1:
reflections, Cartan–Dieudonné, Witt's extension theorem. Internal: none.

The objects are the spin representations roadmap's `orthogonalGroup Q` and
`specialOrthogonalGroup Q`, and the reflections are the quadratic form invariants roadmap's. This
layer proves what neither states.

**0A. The determinant, and the two spellings of `SO`.** `orthogonalDet : O(Q) →* Kˣ`, the
restriction of `LinearEquiv.det`. For nondegenerate `Q`, `(orthogonalDet g)² = 1`, proved from the
Gram congruence `Mᵀ G M = G` and `det G ≠ 0`, so the determinant lands in `μ₂`.

⚠ The accepted `specialOrthogonalGroup Q` is a subgroup of `V ≃ₗ[K] V`, not of `O(Q)`, and this
roadmap does not redefine it with a different type: a local redefinition could never be deleted in
favour of an import. The determinant kernel is therefore a **separately named** subgroup
`specialOrthogonalWithin Q : Subgroup (O(Q))`, together with the interface that ties the two
together and that every later layer quotes: the inclusion
`specialOrthogonalToOrthogonal : SO(Q) →* O(Q)`; the equality
`specialOrthogonalWithin Q = (orthogonalDet Q).ker`; a named multiplicative equivalence between
`specialOrthogonalWithin Q` and the accepted `specialOrthogonalGroup Q`, obtained by pulling the
latter back along `(O(Q)).subtype`; and the compatibility of `spinToSpecialOrthogonal` with
`specialOrthogonalToOrthogonal`.

For nondegenerate `Q` with `dim V ≥ 1` the index is exactly 2, since such a form has an anisotropic
vector and hence an improper reflection. Dimension 0 is stated separately: both groups are trivial,
and no statement below silently assumes `dim V ≥ 1`.

**0B. Functoriality and base change.** An isometry `Q ≃qᵢ Q'` induces `O(Q) ≃* O(Q')`, so `O` is an
invariant of `QuadraticMap.Equivalent`; a field extension `K → L` induces an injective
`O(Q) →* O(Q ⊗ L)`, compatible with composition of extensions; an orthogonal direct sum gives
`O(Q₁) × O(Q₂) ↪ O(Q₁ ⊞ Q₂)` whose **image is exactly the subgroup preserving each summand**,
stated as that equality rather than as an unidentified obstruction. Any criterion for the embedding
to be onto is a separate statement with its own hypotheses, and none is claimed here. Each of these
carries its determinant compatibility, so the same statements hold for `SO`. This is the machinery
every later layer localizes with.

**0C. The bilinear dictionary.** With `2` invertible, `O(Q)` and the automorphism group of the
symmetric bilinear form `B = polarBilin Q` are the same group: an isometry of `Q` preserves `B` by
polarization, and an isometry of `B` preserves `Q` because `Q x = B x x / 2`. The milestone is the
group isomorphism `O(Q) ≃* O(B)` in both directions, with its determinant compatibility and hence
`SO(Q) ≃* SO(B)`. Beside it, the base-change map for a symmetric bilinear form over a commutative
ring, `O(β) →* O(β.baseChange S)`, stated over the ring rather than the field. ⚠ Without this
milestone the group here and the group an integral lattice's automorphisms sit in are two
different objects, and the roadmaps do not connect: the integral lattices roadmap is bilinear-first
because it works over ℤ, where `2` is not invertible, and this is the only place the two
conventions are reconciled.

**0D. Reflections, as this roadmap uses them.** The reflection `τ_v` is the quadratic form
invariants roadmap's, and this layer records the construction through `Module.reflection` with
`f := (Q v)⁻¹ • polarBilin Q v`, so that involutivity and `τ_v v = -v` come from Mathlib rather
than a private definition. Beside it, the lemma that the two coefficient spellings agree,
`B x v / Q v = 2 · B x v / B v v` for `Q v ≠ 0`, which is what lets a proof move between this
roadmap's convention and a half-polar source's without recomputing, and which is the acceptance
check against the mixed form that sends `v` to `-3v`. What the quadratic form invariants roadmap
does not state, and Layer 1 needs: `det τ_v = -1`
(absent from Mathlib for `Module.reflection` in any form); `τ_{a v} = τ_v` for `a ≠ 0`; the
conjugation law `g τ_v g⁻¹ = τ_{g v}` for `g ∈ O(Q)`; and compatibility with scalar extension,
`τ_v` base changing to the reflection in the image of `v`. The determinant computation is what
makes the parity statement of 0F meaningful, and the conjugation law is what makes the spinor norm
a class function on conjugacy classes of reflections.

**0E. Transitivity, explicitly.** For `v, w` with `Q v = Q w ≠ 0` and `v ≠ w`: since
`Q(v−w) + Q(v+w) = 2 Q v + 2 Q w ≠ 0`, at least one of `v−w` and `v+w` is anisotropic. If
`Q(v−w) ≠ 0` then `τ_{v−w} v = w`, because `B v (v−w) = 2 Q v − B v w = Q(v−w)` makes the
reflection coefficient exactly 1. If instead `Q(v+w) ≠ 0` then `τ_{v+w} v = −w`, so
`τ_w τ_{v+w}` takes `v` to `w`. Hence `O(Q)` acts transitively on each nonzero norm level by at
most two reflections, with the reflections written down. This is a step inside the classical proof
of Cartan–Dieudonné, but it is not stated there as API, and the explicit reflections are exactly
what a spinor-norm computation needs: Witt's extension theorem gives the existence of an isometry
and says nothing about its spinor norm.

**0F. Parity.** The number of reflections in any factorization of `g` has the parity of `det g`,
immediately from `det τ_v = -1`. So `SO(Q)` consists of the elements admitting an even
factorization, and is generated by products of two reflections. Combined with Cartan–Dieudonné,
this is the statement Layer 1B uses to prove that the Spin action has determinant one.

### Layer 1: the Lipschitz group and the spinor norm

**Direct prerequisites.** Mathlib: `lipschitzGroup`, `pinGroup`, `spinGroup`, `reverse`,
`involute`, `star_ι`, `ι_sq_scalar`, `equivOfIsometry`, `evenOdd`, `invertibleιOfInvertible`.
Spin Representations Layer 2: `ιRangeEquiv`, `pinToOrthogonal`, `spinToSpecialOrthogonal`.
Quadratic Form Invariants Layer 0: orthogonal bases, the multiplicative square-class avatar;
Layer 1: Cartan–Dieudonné. Internal: 0A, 0D, 0E, 0F.

The Pin and Spin groups, the maps `pinToOrthogonal` and `spinToSpecialOrthogonal`, and the
double-cover kernel over an algebraically closed field are the spin representations roadmap's.
This layer owns the general-field theory that roadmap does not develop: the graded centre over a
general field, the Clifford norm, the spinor norm, and the identification of the image of `Spin`
in `SO` at `K`-points.

**1A. The Clifford norm, with the two anti-involutions kept apart.** `N g := reverse g * g` for
`g` in `lipschitzGroup Q`, with: the theorem that the value is a scalar, giving a homomorphism
`N : lipschitzGroup Q →* Kˣ`; multiplicativity, from `reverse` being an anti-automorphism;
`N (λ • g) = λ² · N g`; and the value on a vector, `N (ι v) = Q v`, an **equality** with no sign
ambiguity, proved from `reverse_ι` and `ι_sq_scalar`. Beside it, the comparison with Mathlib's
`star = reverse ∘ involute`: the star norm takes the value `-Q v` on a vector, by `star_ι`; the
two norms agree on even homogeneous elements; and they differ by `(-1)^r` on a product of `r`
vectors. ⚠ The comparison is a milestone and not a remark, because the difference survives passage
to square classes: `[Q v]` and `[-Q v]` differ by `[-1]`, which is nontrivial over ℚ and over
`ℚ_p`. A development that silently switches anti-involutions computes a different function on
`O(Q)`, agreeing with this one only on `SO(Q)`. Mathlib's `pinGroup Q` is cut out by the *star*
norm being one, since it is an intersection with `unitary`, so the relation between that membership
condition and `N` is part of this milestone rather than an identification assumed.

**1B. ⚠ The graded centre over a general field, and the scalar subgroup.** This is the hardest
item in Layers 0 to 3 and everything after it in this layer rests on it. The spin representations
roadmap's Clifford structure theorem is stated over an algebraically closed field, so it does not
supply what is needed here, and this roadmap owns the general-field statement rather than waiting
on one. For nondegenerate `Q` on a space of dimension `n` over a field of characteristic not two,
with `ω` the product of an orthogonal basis: the centre of `CliffordAlgebra Q` is `K` when `n` is
even and `K ⊕ K·ω` when `n` is odd, while the **graded** centre, the centralizer for the twisted
product, is `K` in both parities. The proof runs through an orthogonal basis (consumed from the
quadratic form invariants roadmap), the induced basis of the Clifford algebra, and the commutation
of a basis monomial with each `ι e_i`.

Two objects are defined here rather than left as existential statements inside the algebra, since
later statements quantify over them: the **scalar-unit homomorphism**
`scalarUnits : Kˣ →* lipschitzGroup Q`, injective, landing in the centre; and its range as a
subgroup. Every "the kernel consists of the nonzero scalars" claim below is an equality of
subgroups against `scalarUnits.range`, never an existential equality between Clifford elements.

**1C. The vector representation.** Twisted conjugation gives a group homomorphism
`lipschitzGroup Q →* O(Q)`, using Mathlib's `conjAct_smul_range_ι` and
`involute_act_ι_mem_range_ι` together with the spin representations roadmap's `ιRangeEquiv`, and
proving that the resulting linear map is an isometry. An anisotropic `v` acts as `τ_v` exactly,
with no sign, which is the twisted-conjugation convention paying for itself. For nondegenerate `Q`
on a finite-dimensional space the homomorphism is **surjective**, by Cartan–Dieudonné; and its
kernel is exactly `scalarUnits.range`, by 1B. Compatibility with field extension and with
`QuadraticMap.Equivalent`, the latter through `CliffordAlgebra.equivOfIsometry`, which is the only
declaration turning an isometry of forms into an isomorphism of Clifford algebras.

**1D. The spinor norm.** For `Q` nondegenerate on a finite-dimensional space, both hypotheses
carried explicitly because the construction uses both, `θ : O(Q) → Kˣ/(Kˣ)²` by
`θ(τ_{v₁} ⬝⬝⬝ τ_{v_r}) = [Q v₁ ⬝⬝⬝ Q v_r]`. **Well-definedness is the milestone**: two reflection
factorizations of the same `g` lift, by 1C, to Lipschitz elements with the same image, so by 1B
they differ by an element of `scalarUnits.range`, that is by a scalar `λ`; and
`N (λ • x) = λ² · N x`, so the two products of norms agree modulo squares. The `reverse` norm of
1A is what makes the products come out as `∏ Q(vᵢ)` with no residual sign. Then `θ` is a group
homomorphism; `θ(τ_v) = [Q v]`; `θ` is invariant under `QuadraticMap.Equivalent` and compatible
with field extension; its restriction along `specialOrthogonalToOrthogonal`, which is the one the
arithmetic uses; and its behaviour on an orthogonal direct sum. Defining `θ` through reflections
rather than as a quotient by the image of `Spin` is what makes it computable on a lattice
stabilizer, one reflection at a time.

**1E. The comparison sequence, with its dimension branches.** The maps, each named: the inclusion
`μ₂(K) → Spin(Q)(K)`, the accepted `spinToSpecialOrthogonal Q`, the inclusion
`specialOrthogonalToOrthogonal`, and `θ`. Then, for nondegenerate `Q` on a space of **positive**
dimension: the kernel of `spinToSpecialOrthogonal Q` is the image of `μ₂(K)`, of order two; and
the **image** of `spinToSpecialOrthogonal Q` is exactly the kernel of `θ` restricted along
`specialOrthogonalToOrthogonal`, the **spinor kernel**, which is the object the integral lattices
roadmap's spinor genera are built from. Dimension zero is stated separately, where the kernel is
trivial rather than of order two and the sequence degenerates.

⚠ The sequence is exact at `Spin` and at `SO`, and `θ` need not be surjective, so nothing here is
a short exact sequence and none of it is written as one. Where `θ` is surjective the sequence
extends by `→ 1` on the right, and Layer 2 proves exactly which local fields and dimensions those
are. The distinction being tested is between a central isogeny of groups, which is surjective as a
map of algebraic groups, and surjectivity on `K`-points, which is what `θ` measures.

**1F. Low rank, arithmetically, with the split and nonsplit cases separated.** The exceptional
isomorphisms over an algebraically closed field are the spin representations roadmap's Layer 6.
⚠ Those do not classify the rational forms, so the twisted forms are targets here and are not
consumed from there. For a nondegenerate quadratic space over a field `K` of characteristic not
two:

- **Dimension 3.** The even Clifford algebra is a quaternion algebra over `K`, `Spin(Q)` is its
  group of norm-one elements, and `SO(Q)` is its unit group modulo the centre. This is the
  dictionary quaternionic arithmetic runs on, which is why it is stated over a general field.
- **Dimension 4.** The centre of the even Clifford algebra is the **discriminant quadratic étale
  algebra** `E = K[X]/(X² − d)` for `d` the discriminant, and the two cases are genuinely
  different groups:
  - `E ≅ K × K` split: the even Clifford algebra is a product of two quaternion algebras over `K`
    and `Spin(Q)` has two `K`-almost-simple factors, each of `K`-rank one;
  - `E` a quadratic field: the even Clifford algebra is a quaternion algebra over `E`, and
    `Spin(Q)` is the restriction of scalars from `E` to `K` of its norm-one group, which is
    `K`-almost-simple and **not** a product of two `K`-factors.
  Conflating the two is conflating geometric factors with `K`-almost-simple factors, which is
  exactly the distinction Layer 4's hypothesis turns on.
- **Dimensions 5 and 6.** The identifications with a symplectic group in four variables and with a
  special linear group in four variables over the discriminant algebra, stated over `K` with the
  same split and nonsplit branches recorded in dimension 6.

### Layer 2: local topology, transvections, and local spinor norms

**Direct prerequisites.** Mathlib: `Padic` with its `ProperSpace` instance, the matrix and
endomorphism topology instances, `Module.End`. Spin Representations Layer 0:
finite-dimensionality of `CliffordAlgebra Q`. Quadratic Form Invariants Layers 3 and 6: the
classification over `ℚ_p` by `(dim, d, s)`. Local Fields Layer 0: local compactness and `𝒪[K]`
compact open; Layer 1: `U(K, 2e+1) ⊆ (Kˣ)²`. Internal: 0B, 0C, 0D, 1A, 1C, 1D, 1E.

`K` is `ℝ` or `ℚ_p` throughout, and each statement is proved uniformly in the local field where
the proof is uniform, so that a later development over a general local field can reuse it.

**2A. ⚠ The topology is constructed, not assumed.** A finite-dimensional vector space over a local
field carries no `TopologicalSpace` instance on its own, and the phrase "the topology from
`Module.End K V ≅ K^{n²}`" names a transport along a chosen basis rather than a canonical object.
The design, fixed here and used everywhere below: transport the product topology through a basis;
prove that two basis-induced topologies coincide, because every change-of-basis map and its
inverse are continuous; conclude that the resulting topology on `V`, on `Module.End K V`, on
`V ≃ₗ[K] V` and on `CliffordAlgebra Q` is independent of the basis, and is Hausdorff. The Clifford
case additionally needs finite-dimensionality of `CliffordAlgebra Q`, which is the
Poincaré–Birkhoff–Witt statement `dim = 2^n`, recorded in the dependency table as an input rather
than assumed.

**2B. Point groups as topological groups.** `O(Q)(K)` is a topological group in the topology of 2A
and is **closed** in `Module.End K V`, being cut out by polynomial equations; `SO(Q)(K)` is closed
and, since the determinant is continuous with discrete image, also open in `O(Q)(K)`. Local
compactness of both follows from closedness inside a finite-dimensional space over a locally
compact field. `Spin(Q)(K)` is a topological group in the topology induced from the Clifford
algebra, closed, and locally compact. Continuity of the determinant, of the vector representation,
of `spinToSpecialOrthogonal` and of the base-change maps of Layer 0B.

**2C. Eichler transvections and their Spin lifts.** Stated here, before anything uses them. For an
isotropic vector `u` and a vector `w` orthogonal to `u`,
`E_{u,w}(x) = x + B(x,u) w − B(x,w) u − Q(w) B(x,u) u` is a proper isometry of `Q`; `w ↦ E_{u,w}`
is a homomorphism from the additive group of `u^⊥ / K u` into `SO(Q)`; the conjugation law under
`O(Q)`; base change and continuity; and the spinor norm of a transvection is trivial, so
transvections lie in the spinor kernel. ⚠ That last fact says each transvection *has* a lift to
`Spin`, and existence of individual lifts is not a subgroup. The milestone is therefore an
**explicit canonical Clifford lift** `w ↦ Ẽ_{u,w}` written down inside the even Clifford algebra,
with its own additive composition law in `w`, and with `spinToSpecialOrthogonal ∘ Ẽ_{u,·} = E_{u,·}`
proved. These are the unipotent one-parameter subgroups of `Spin` that Layer 4 generates with;
without the lift as a homomorphism, Layer 4 has no root subgroups to work with.

**2D. Compactness, stated sharply.** `O(Q)(ℝ)` is compact if and only if `Q` is definite, and
`O(Q)(ℚ_p)` is compact if and only if `Q` is anisotropic over `ℚ_p`. The forward direction uses
2C: an isotropic vector gives an unbounded one-parameter family of transvections. The converse
bounds the matrix entries of an isometry of a definite or anisotropic form. The same statements
for `SO`. ⚠ For `Spin` the corresponding statement is **not** a formal consequence of having a
continuous map with finite kernel onto a compact group, so it is a separate milestone: prove that
`spinToSpecialOrthogonal` is proper on local points, or obtain compactness from the affine
group-scheme comparison of Layer 3A. These criteria are what give Layer 4's noncompactness
hypothesis content, and what decide which genera Layer 5's volume theorem says anything
interesting about.

**2E. Continuity of the spinor norm.** ⚠ Discreteness of `Kˣ/(Kˣ)²`, which follows from openness
of `(Kˣ)²`, shows only that a *continuous* map into it is locally constant; it does not make an
arbitrary map continuous. The milestone is therefore that `ker θ` is **open** in `O(Q)(K)`,
obtained by factoring `θ` through the continuous Clifford norm of 1A and the open quotient map
`Kˣ → Kˣ/(Kˣ)²`, with every step named: continuity of `N` on `lipschitzGroup Q`, openness of the
quotient map, and the descent of `θ` along the surjection of 1C.

**2F. Local spinor norms, in every dimension.** The image of `θ` on `O(V_p)` and on `SO(V_p)`,
computed from the classification of forms over `ℚ_p` supplied by the quadratic form invariants
roadmap, enumerated rather than gestured at: dimension `0`, where both groups are trivial;
dimension `1`, where `O` is `{±1}` and `θ(O) = [Q(v)]`; dimension `2`, where the image depends on
whether the form is isotropic and is computed through the norm group of the discriminant algebra;
and dimension `≥ 3`, where `θ(SO(V_p)) = ℚ_p^×/(ℚ_p^×)²`. The local spinor kernel, the image of
`Spin(V_p) → SO(V_p)`, is identified as `ker θ|_{SO(V_p)}` in each case and its index computed.
These are exactly the statements the integral lattices roadmap's Layer 4C needs before it can
compute `θ_p(K_p⁺(L))` from Jordan data.

**2G. The real place.** `θ(SO(V_ℝ))` is trivial when `Q` is definite and all of `ℝˣ/(ℝˣ)²` when `Q`
is indefinite; `Spin(V_ℝ)` is compact exactly when `Q` is definite, through 2D. That is everything
the later layers use from the real place; the connected-component theory of `O(p,q)` is outside
this roadmap.

**2H. Localization of factorizations.** A reflection factorization over ℚ base changes to one over
`ℚ_v` at every place, `θ` commutes with the base-change maps `O(V) → O(V_v)` of Layer 0B, and the
diagram relating the global and local spinor norms commutes. This is what makes the adelic spinor
norm of Layer 3 agree with the rational one on diagonal elements.

### Layer 3: the algebraic-group comparison, and adelic points

**Direct prerequisites.** Mathlib: `RestrictedProduct` with its topology,
`isOpenEmbedding_structureMap`, `locallyCompactSpace_of_group`, `FiniteAdeleRing`. Reductive
Groups Layers 0, 3, 6, 7: the functor of points, smoothness, semisimplicity, simple
connectedness, central isogenies, and the `K`-almost-simple decomposition. Internal: all of
Layer 2, and 1F for the dimension-four factor structure.

**3A. The affine group schemes, as a prerequisite and not an aside.** Layers 4 and 5 quantify over
`ℚ`-almost-simple factors, use simple connectedness of `Spin`, use a central isogeny of algebraic
groups, and use invariant differential forms. None of that is available for a bare point group, so
the comparison with affine group schemes is a genuine prerequisite of this roadmap and is built
here, against the [reductive algebraic groups roadmap](../ReductiveGroups/README.md)'s functor of
points and its structure theory. The targets:

1. the affine group schemes `O_Q`, `SO_Q` and `Spin_Q` over a field of characteristic not two,
   together with the integral models needed at almost all primes;
2. the identification of their `K`-points with the abstract point groups of Layers 0 to 2, as
   group isomorphisms, and as homeomorphisms for local `K` against the topology of 2A;
3. smoothness in characteristic not two;
4. the central morphism `Spin_Q → SO_Q` with kernel `μ₂`;
5. connectedness and semisimplicity of `SO_Q` and `Spin_Q` in the stated dimensions;
6. simple connectedness of `Spin_Q` as an algebraic group;
7. the decomposition into `K`-almost-simple factors, including the dimension-four split and
   nonsplit cases of 1F;
8. compatibility of all of it with base change.

**3B. The generic restricted product.** For a family of locally compact topological groups `G_i`
with chosen compact open subgroups `K_i`, built on Mathlib's `RestrictedProduct`: the evaluation
homomorphisms, continuous; the everywhere-integral part as an actual **subgroup**, proved open and
compact, rather than as a set; local compactness of the whole, from
`locallyCompactSpace_of_group`; and functoriality along a family of continuous homomorphisms
`G_i → H_i` carrying `K_i` into `L_i`.

⚠ One item is not plumbing. Mathlib's `RestrictedProduct` has **no congruence API**: `map`,
`mapAlong` and their monoid- and ring-hom versions are one-directional, and nothing produces an
equivalence from componentwise data. So the comparison of the restricted products for two families
`K_i` and `K'_i` agreeing at all but finitely many `i` has to be proved here, and as a **named
canonical** equivalence induced by the identity on coordinates, with its evaluation formula, its
inverse, continuity in both directions, and compatibility with the structure maps. A bare
existence statement is not enough: the arithmetic needs to know which map it is holding.

**3C. Compatible compact-open data.** ⚠ A single family `U_p ≤ O(V_p)` does not determine the
reference subgroups for the other two groups or for the square-class codomain, so the parameter is
a **compatible tuple** `(U_p^O, U_p^{SO}, U_p^{Spin})` carrying its compatibility hypotheses, with:
`U_p^{SO} = U_p^O ∩ SO(V_p)`, proved compact open; an explicit compact open subgroup of
`Spin(V_p)` mapping into `U_p^{SO}`, constructed rather than obtained as a preimage, since a
preimage of a compact set under `Spin → SO` is compact only once properness is known (2D); and the
reference subgroup `θ_p(U_p^{SO})` in the local square-class group.

**3D. The three adelic point groups.** For each of `O`, `SO` and `Spin`, and with the index type
of finite places and the type of places both pinned in Lean rather than written informally:
finite adelic points relative to a compatible tuple; points away from a finite set `S` of places;
and full adelic points, over ℚ concretely as the real point group times the finite adelic group.
Then the restriction and projection maps between the three, and the identification of the
away-`{∞}` object with the finite adelic object. The componentwise maps
`Spin(V)(𝔸_•) → SO(V)(𝔸_•) → O(V)(𝔸_•)` follow from 3B's functoriality.

**3E. ⚠ Diagonal points: discrete in the full adeles, dense in the finite adeles.** The diagonal
map is well defined only once one knows that a given rational isometry lies in `U_p` for all but
finitely many `p`, which is a theorem. Both forms are milestones: the **relative** one, for a
tuple satisfying "every element of `O(V)(ℚ)` lies in `U_p^O` for almost all `p`" as an explicit
hypothesis, which is the form the integral lattices roadmap discharges for its lattice
stabilizers; and the **absolute** one, discharging that hypothesis for the stabilizers of the
`ℤ`-span of a chosen basis of `V`, by clearing denominators in the matrix of a rational isometry
and of its inverse. The second exists so the roadmap's own objects rest on something; it develops
no lattice arithmetic.

Then, and the contrast is the point: `G(ℚ)` is **discrete in `G(𝔸)`**, the full adeles, once the
real place is included, and this is the statement every use of a fundamental domain or a covolume
in Layer 5 is made against. It is **not** discrete in `G(𝔸_f)`, and the roadmap records the
counterexample rather than leaving the distinction to be discovered: for a split rational
quadratic space of dimension at least three, take integral `u` and `w` and the rational
one-parameter family `t ↦ E_{u,tw}` of 2C; inside any basic finite-adelic neighbourhood of the
identity, a nonzero integer `t` divisible by a high enough power of each of the finitely many
constrained primes gives a transvection that is integral at every other prime and arbitrarily
close to the identity at the constrained ones. So the diagonal image accumulates at the identity.
This is consistent with Layer 4, which asserts density of exactly this image.

**3F. The adelic spinor norm.** The restricted product of the local square-class groups relative
to the reference subgroups `θ_p(U_p^{SO})` of 3C, the theorem that the componentwise local spinor
norms induce a continuous homomorphism into it, and the **adelic spinor kernel** as the kernel of
that map. ⚠ There is no such thing as "the restricted product of the local square-class groups"
until the reference subgroups are fixed; several inequivalent choices exist, and the one used here
is pinned above.

**3G. Double cosets, with the maps stated separately.** The set `G(ℚ) \ G(𝔸_f) / U`, with three
distinct comparison statements rather than one blanket change-of-`U` map, since eventually equal
reference families give canonically equivalent ambient groups but do **not** automatically give a
canonical bijection of double-coset sets: an inclusion `U ≤ U'` of compact opens induces a
surjection of double-coset sets in the corresponding direction; conjugate compact opens induce a
canonical bijection; and a componentwise equivalence carrying one tuple to another transports the
double-coset set along 3B's canonical equivalence. Finiteness of the set is not claimed here.

### Layer 4: strong approximation for Spin

**Direct prerequisites.** Internal: 2C for the transvections and their Spin lifts, 2D for
noncompactness, 3A items 5 to 7 for semisimplicity and the factor decomposition, 3D for `𝔸^S`,
3E for the diagonal map, 3F for the adelic spinor kernel, 1F for dimension four. External:
strong approximation for the additive group `𝔸` relative to ℚ, and the Kneser–Tits generation
input named in 4A.

⚠ This is a **noncompact-place** theorem, not literally an indefinite one: the hypothesis is that
each `ℚ`-almost-simple factor of `Spin(V)` is noncompact at some place of `S`, which a positive
definite form can satisfy at a finite place. The indefinite statement is the corollary at
`S = {∞}`, and that corollary is what Eichler's theorem on lattice classes runs on. Layer 5 does
not use this layer.

**4A. The generation theorem.** The step "generated by transvection subgroups, hence reduce to
additive approximation" hides the main local input, so it is stated: the subgroup of `Spin(V)(K)`
generated by the canonical transvection lifts of 2C, over a local or global field `K`, is the
elementary subgroup; the theorem identifying it with the whole group, or with a subgroup of
controlled finite index, for `V` isotropic of dimension at least three; and the Kneser–Tits input
that supplies it, cited by name. Without this, Layer 4 has no reduction.

**4B. The isotropic case.** For `V` containing a hyperbolic plane, the subgroup of `Spin(V)(𝔸^S)`
generated by the adelic points of the transvection subgroups is dense, reducing approximation to
strong approximation for the additive group `𝔸` relative to ℚ, which is stated explicitly with its
source rather than gestured at.

**4C. The general case, by one fixed route.** The route of record is Kneser's dimension induction
in the form presented in Platonov–Rapinchuk, Chapter 7: reduce a general `V` of dimension at least
three to the isotropic case of 4B by splitting off a hyperbolic plane after enlarging the set of
places, and control the anisotropic kernel through the finiteness of the class number. Its lemmas
are listed as sub-items. No alternative route is offered, because an implementer must not have to
choose a proof architecture.

**4D. The factor condition.** The hypothesis is stated with `ℚ`-almost-simple **normal** factors,
supplied by 3A item 7, and the theorem that the decomposition used in the statement is that one.
For dimension four this is where 1F's split and nonsplit branches do their work: in the split case
there are two `ℚ`-almost-simple factors and each must be noncompact at a place of `S`; in the
nonsplit case there is one factor, a restriction of scalars, and the condition is a condition at
the places of the discriminant field above `S`. Noncompactness of `Spin(V)(ℝ)` alone does not
imply either.

**4E. The theorem.** Let `V` be a nondegenerate quadratic space over ℚ with `dim V ≥ 3`, and let
`S` be a finite nonempty set of places of ℚ such that every `ℚ`-almost-simple factor of `Spin(V)`
is noncompact at some place of `S`. Then the diagonal image of `Spin(V)(ℚ)` is dense in
`Spin(V)(𝔸^S)`. ⚠ The reformulation `Spin(V)(𝔸^S) = Spin(V)(ℚ) · U` for every compact open `U`
needs `𝔸^S` totally disconnected, so over ℚ it carries the additional hypothesis `∞ ∈ S`; for
general `S` density is stated against arbitrary nonempty open sets. The equivalence of the two,
under `∞ ∈ S`, is proved. The corollary the lattice side uses is stated separately: for
`S = {∞}` and `V` indefinite, `Spin(V)(𝔸_f) = Spin(V)(ℚ) · U` for every compact open
`U ≤ Spin(V)(𝔸_f)`.

⚠ **Dimension 2 is excluded**, not deferred: `Spin(V)` is a one-dimensional torus and the theorem
is false. The binary theory belongs to the integral lattices roadmap, through quadratic orders and
their class groups.

**4F. What happens in `SO`, exactly.** The continuous image of a dense set is dense in the image,
not in the ambient group, so the transported statement is about the adelic spinor kernel of 3F and
not about `SO(V)(𝔸^S)`. The milestone: the closure of the diagonal image of `Spin(V)(ℚ)` inside
`SO(V)(𝔸^S)` is the adelic spinor kernel; equivalently the obstruction to strong approximation for
`SO` is measured by the adelic spinor norm, and it is stated as that cokernel rather than as a
blanket failure, since in special cases the obstruction vanishes. This is the exact reason spinor
genera exist.

### Layer 5: Tamagawa measures, and the orthogonal volume theorem

**Direct prerequisites.** Mathlib: `haarMeasure`, `haarScalarFactor`, `IsFundamentalDomain`,
`QuotientMeasureEqMeasurePreimage`, `covolume`. Internal: 3A for the group schemes and their
invariant differentials, 3D for the full adelic points, 3E for discreteness of the rational
points in `G(𝔸)`, 2F and 3F for the local and adelic spinor norms. External: Hilbert reciprocity
from Global Class Field Theory Layer 11, and the product formula. **Not** Layer 4.

⚠ This layer is independent of Layer 4. Strong approximation is a noncompact-place statement about
`Spin` used for class numbers; the volume theorem has no isotropy hypothesis and is what the mass
formula of positive definite genera consumes. No proof here uses Layer 4, and the integral lattices
roadmap consumes the two separately. Nor does any proof here consume the mass formula: the
implication runs from the volume theorem to the mass formula and not back, and the analytic route
to the mass formula is outside both roadmaps.

The layer has two halves. 5A to 5E are general Tamagawa theory for connected linear algebraic
groups, written to be independent of quadratic forms so that they can be lifted into a roadmap of
their own without rewriting; 5F to 5I are the orthogonal specialization, which is all this roadmap
is really about.

**5A. Gauge forms and local measures.** Invariant top-degree differential forms on a smooth affine
algebraic group; the local measure attached to a rational gauge form at each place, through the
absolute value of the form in local coordinates; and the behaviour under rescaling the form by a
rational scalar. ⚠ The normalization is **not** pinned by Haar existence and uniqueness together
with isometry invariance, since every scalar multiple of an invariant measure is again invariant:
what pins it is the choice of gauge form, and the fact that the *global product* is independent of
that choice, because rescaling by `c ∈ ℚˣ` changes the local factors by `|c|_v` and the product
formula `∏_v |c|_v = 1` kills it. That argument, and not an appeal to uniqueness, is what makes
the Tamagawa measure canonical, and it is stated here in that form.

**5B. Convergence.** The convergence factors needed when the naive product of local volumes
diverges, the convergence theorem in the cases used, and the statement that no convergence factors
are needed for a semisimple group. The low-rank tori that appear in dimension two are covered here
with their factors, since they are the case where this cannot be skipped.

**5C. Adelic points and the product measure.** Full adelic points of the group, consumed from
Layer 3D; the product Haar measure; discreteness of the rational points, consumed from Layer 3E;
the fundamental-domain and quotient-measure API against Mathlib's
`QuotientMeasureEqMeasurePreimage` and `covolume`. ⚠ Three upstream constraints shape this
subsection and are stated rather than discovered: `covolume` is `ℝ≥0∞`-valued and returns `0` when
no fundamental domain exists; `haarMeasure_quotient` requires the subgroup countable and the
quotient measure finite; and Mathlib has no `IsUnimodular` class, so unimodularity is carried as
left-invariance together with right-invariance and proved for each group used.

**5D. Finiteness, then the number.** Finiteness of the Tamagawa volume, as its own milestone
preceding any computation of it, and the definition of the Tamagawa number.

**5E. Central isogenies and `τ(G) = 1`.** The comparison of Tamagawa measures under a central
isogeny, with the kernel and cokernel contributions at each place and globally, in the form
Ono's relative theory gives; and the theorem `τ(G) = 1` for a connected simply connected
semisimple group, with a fixed proof route and its prerequisites listed. This is the deepest
statement the roadmap depends on, and it is stated as a target here rather than assumed.

**5F. The orthogonal specialization.** The gauge forms on `O_Q`, `SO_Q` and `Spin_Q` from 3A, the
resulting local and global measures, and their invariance under isometry of quadratic spaces.

**5G. Comparison with the lattice-relative normalization.** The volume of a compact open subgroup
in the canonical normalization, stated for an arbitrary compact open subgroup rather than for a
lattice, since the integral lattices roadmap's Layer 7C identifies its local densities with
canonical Haar volumes of stabilizers and needs a form it can quote.

**5H. The isogeny computation for `Spin_Q → SO_Q`.** Consuming 5E: the central kernel `μ₂`
contributes its own factor; the local connecting maps are identified with the local spinor norms
of 2F, and the global one with the adelic spinor norm of 3F; the resulting global-to-local
square-class exact sequence is stated, with Hilbert reciprocity `∏_v (a,b)_v = 1` consumed from the
global class field theory roadmap as the input that makes it exact; and every kernel and cokernel
cardinality in the computation is evaluated.

**5I. The theorem, by dimension.** `τ(SO_Q) = 2` for `dim V ≥ 3`, derived from `τ(Spin_Q) = 1` by
5H. The remaining dimensions are stated separately rather than folded into a phrase: dimension `0`
and dimension `1`, where the value is `1`, which is the guard the integral lattices roadmap's
Conway–Sloane normalization records in its own low-rank branch; and dimension `2`, where `SO_Q` is
a torus, the computation is the one in 5B with its convergence factors, and the value depends on
whether the discriminant algebra is split. The two roadmaps state the same exceptions.

## Required basic API

"Build the library, don't race to the theorem" applies per object. Each object this roadmap owns
carries the same seven-part checklist, and a milestone is not discharged until all seven exist:
**constructors and the defining characterization**; **extensionality**, that is a usable criterion
for two elements to be equal; **functoriality** in the quadratic space, along isometries;
**base change**, along a field extension for the field-level objects and along a ring map for the
bilinear ones; **comparison lemmas** against the neighbouring object, which is the row below or
above it here; **edge cases**, meaning dimension zero, dimension one, and the degenerate form
wherever a statement is claimed without nondegeneracy; and the **downstream interface**, the
handful of lemmas the consuming layer actually calls.

The objects, in dependency order: `orthogonalDet` and the `specialOrthogonalWithin` interface
(0A); the bilinear-form isometry group and the dictionary (0C); the reflection with its
determinant and conjugation law (0D); the scalar-unit homomorphism and the Clifford norm (1A, 1B);
the spinor norm (1D); the local topological point groups (2A, 2B); the transvections and their
Spin lifts (2C); the compatible compact-open data and the three adelic point groups (3C, 3D); the
adelic spinor norm and the adelic spinor kernel (3F); and the orthogonal gauge forms with their
measures (5F).

## Worked examples (acceptance criteria)

Discharge these alongside their layers. Each catches a vacuous definition, a wrong sign, or a
convention drift.

- The two reflection spellings agree: `B x v / Q v = 2 · B x v / B v v` for `Q v ≠ 0`, and
  `τ_v v = -v` computed from either. The mixed form `2 · B x v / Q v` gives `-3v`, and that is the
  error the convention table warns against (Layer 0D).
- `Q = x²` in dimension 1: `O(Q) = {±1}`, `SO(Q)` trivial, `-1` is the reflection in any `v ≠ 0`,
  and `θ(-1) = [Q v]`, which is **not** `[1]` in general. Together with the Clifford-norm
  comparison this is the acceptance check that the square class detects `-1` (Layers 0, 1).
- The hyperbolic plane over any `K`: `SO(H) ≅ Kˣ` through the diagonal torus and `θ` on that torus
  is the square class of the parameter, so `θ : SO(H)(K) → Kˣ/(Kˣ)²` is **surjective**; the image
  of `Spin(H)(K) → SO(H)(K)` is the square-parameter subgroup, which is `ker θ`, so
  `Spin(H)(K) → SO(H)(K)` is **not** surjective. The sequence of 1E extended by `→ 1` is therefore
  exact here, and what fails is the naive expectation that a central isogeny is onto on `K`-points
  (Layers 0, 1).
- The sum of three squares over ℚ: the central map from the norm-one Hamilton quaternions to
  `SO(Q)` is an isogeny of algebraic groups with kernel `±1`, and its image on rational points is
  the spinor kernel, strictly smaller than `SO(Q)(ℚ)`. Stating it as "`SO(Q)(ℚ)` is the quotient of
  `Spin(Q)(ℚ)` by `±1`" is exactly the error the previous item is designed to catch (Layer 1F).
- `O(Q)(ℝ)` for a definite `Q` is compact and agrees with the Euclidean orthogonal group of
  `TauCeti/LinearAlgebra/OrthogonalGroup.lean`; for `Q = x² − y²` it is not compact, exhibited by
  the transvection family of 2C (Layers 2B, 2D).
- A rational isometry lies in the stabilizer of the standard `ℤ`-span at all but finitely many
  primes, exhibited for one explicit non-integral rational isometry (Layer 3E).
- **Non-discreteness in the finite adeles**: for a split rational `V` of dimension at least three,
  the transvections `E_{u,tw}` with `t` a highly divisible integer accumulate at the identity in
  `SO(V)(𝔸_f)`, so the diagonal image is not discrete there, while it is discrete in `SO(V)(𝔸)`.
  This is the acceptance check for 3E and for the compatibility of 3E with Layer 4 (Layer 3).
- Two compatible tuples differing at one prime give a canonical isomorphism of restricted products,
  computed on coordinates, and the induced comparison of double-coset sets is the one 3G names
  rather than a bijection (Layer 3).
- Dimension four, split against nonsplit: a quaternary form with split discriminant algebra, whose
  `Spin` has two `ℚ`-almost-simple factors, beside one whose discriminant algebra is a quadratic
  field, whose `Spin` has one. The factor condition of 4D is checked in both, which is what tests
  the distinction 1F draws (Layer 4).

## Ordering and parallelism

Layer 0 rests on the two sibling roadmaps that own its objects, and within it 0A to 0D are
independent while 0E and 0F follow 0D. Layer 1's order is forced: 1B before 1C, and 1C before 1D
and 1E; 1A is independent of 1B and can be built alongside it; 1F depends on 1C and is otherwise
independent, so it can be built in parallel with the spinor norm.

Layer 2 needs Layers 0 and 1 and the local classification. Within it, 2A is a self-contained piece
of topology that depends on nothing else here and is the best independent starting point for a
contributor who would rather do topology than quadratic forms; 2C depends only on Layer 0 and 1C
and is needed by 2D, which is why it sits before it.

Layer 3A, the affine group-scheme comparison, is the prerequisite that Layers 4 and 5 both rest
on, and it can be built as soon as Layer 1 exists. Layer 3B is again independent of everything else
in this roadmap. Layers 3C to 3G need Layer 2.

Layers 4 and 5 both consume Layer 3 and neither consumes the other, which is the second
load-bearing distinction made structural. Within Layer 5, the general machinery 5A to 5E needs only
3A and 3D and can proceed in parallel with the whole of Layer 4; 5F to 5H then need 2F and 3F; and
5E is the long pole.

The shortest route to something the integral lattices roadmap can use is `0 → 1 → 2`, which
supplies its spinor-norm interface; the shortest route to its adelic interface is
`0 → 1 → 2 → 3`.

## References

- E. Artin, *Geometric Algebra*, Interscience (1957). Chapter III for reflections, the
  transitivity computation of 0E and Cartan–Dieudonné.
- O. T. O'Meara, *Introduction to Quadratic Forms*, Grundlehren 117, Springer (1963; corrected
  1973), PRIMARY. §43 the orthogonal group and reflections; §55 the spinor norm, its
  well-definedness and the local computations of 2F, with 55:6 the local surjectivity in dimension
  at least three; §101 the adelic setting; 104:4 strong approximation for the spin group, which is
  4E. ⚠ His Hasse symbol convention is `∏_{i≤j}`, translated per the quadratic form invariants
  roadmap's table. (104:5, Eichler's theorem for lattice classes, is the integral lattices
  roadmap's.)
- C. Chevalley, *The Algebraic Theory of Spinors*, Columbia (1954); reprinted in *Collected Works*
  vol. 2, Springer (1997). Chapter II for the Lipschitz group, the vector representation, the
  centre and graded centre computation of 1B, and the Clifford norm of 1A.
- N. Bourbaki, *Algèbre*, Chapitre 9, *Formes sesquilinéaires et formes quadratiques*, Hermann
  (1959). §9 for the Clifford group, the spinor norm and the exact sequence of 1E, in the
  conventions closest to Mathlib's.
- M.-A. Knus, *Quadratic and Hermitian Forms over Rings*, Grundlehren 294, Springer (1991).
  Chapter IV for the Clifford algebra, its centre, the discriminant quadratic étale algebra of a
  quaternary form and the split/nonsplit dichotomy of 1F.
- M.-A. Knus, A. Merkurjev, M. Rost, J.-P. Tignol, *The Book of Involutions*, AMS Colloquium
  Publications 44 (1998). §15 for the low-rank exceptional isomorphisms **over a general field**,
  with the twisted forms, which is what 1F needs and what the algebraically closed statements do
  not give.
- W. Scharlau, *Quadratic and Hermitian Forms*, Grundlehren 270, Springer (1985). Chapter 9 for the
  spinor norm and the Clifford invariant with the sign conventions stated explicitly, against which
  1A's `reverse`-versus-`star` comparison is checked.
- T. Y. Lam, *Introduction to Quadratic Forms over Fields*, GSM 67, AMS (2005). Chapter I for
  reflections (I.7), Witt theory and the extension theorem (I.4.9), in the conventions the
  quadratic form invariants roadmap adopts.
- M. Eichler, *Quadratische Formen und orthogonale Gruppen*, Grundlehren 63, Springer (1952; 2nd
  ed. 1974). The origin of the transvections of 2C and of the approximation argument.
- M. Kneser, *Quadratische Formen* (revised with R. Scharlau), Springer (2002). Strong
  approximation and the spinor-genus apparatus in the form Layer 4 states.
- V. Platonov, A. Rapinchuk, *Algebraic Groups and Number Theory*, Academic Press (1994), PRIMARY
  for Layers 3 to 5. Chapter 3 for adelic groups of algebraic groups and the discreteness and
  reduction theory of 3E; Chapter 5 for Tamagawa measures and numbers, its §5.3 for the gauge-form
  normalization and the product-formula argument of 5A; Chapter 7 for strong approximation, with
  Theorem 7.12 the statement 4E follows and §7.4 the dimension induction 4C fixes as its route;
  and its Kneser–Tits discussion for the generation theorem of 4A.
- A. Weil, *Adeles and Algebraic Groups*, Progress in Mathematics 23, Birkhäuser (1982). The
  Tamagawa measure, and `τ(G) = 1` for the simply connected classical groups, which is 5E.
- T. Ono, *On the relative theory of Tamagawa numbers*, Ann. of Math. 82 (1965) 88–111. The
  behaviour of Tamagawa numbers under a central isogeny, which is the computation 5E and 5H run.
- J. G. M. Mars, *Les nombres de Tamagawa de certains groupes algébriques*, Séminaire Bourbaki
  exp. 351 (1968/69). The orthogonal and spin Tamagawa numbers surveyed, with the derivation of
  `τ(SO) = 2` from `τ(Spin) = 1` that 5H formalizes.
- J. W. S. Cassels, A. Fröhlich (eds.), *Algebraic Number Theory*, Academic Press (1967). The
  adelic background of Layers 3 and 5, and the product formula 5A uses.
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter IV. The local and global
  square-class background in the form the sibling roadmaps use.
