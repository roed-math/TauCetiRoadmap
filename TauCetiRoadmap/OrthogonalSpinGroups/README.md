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
their symmetric spaces are outside. **Automorphic representations, the Weil representation, and the
Siegel–Weil formula as an identity between a theta integral and an Eisenstein series** are outside;
the adelic Poisson-summation identity that drives Weil's induction in Layer 5E is in scope and is
named there. **Hermitian and unitary groups as a subject** — their classification, their Witt
theory and their invariants — **quadratic forms over division algebras, and orthogonal groups of
forms over rings of integers of number fields** are outside. ⚠ The boundary is narrower than it
sounds in one place, and the exception is deliberate rather than an oversight: in dimensions five
and six `Spin_Q` **is** a symplectic or unitary group of an involution on the even Clifford algebra,
so 1F names those groups and 5E computes their Tamagawa numbers. What is excluded is developing
them for their own sake, not naming the group `Spin_Q` turns out to be.

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
- **The module topology:** `Mathlib/Topology/Algebra/Module/ModuleTopology.lean` has
  `moduleTopology R A`, the finest topology making the module operations continuous, the class
  `IsModuleTopology R A` recording that a supplied instance is that one, `eq_moduleTopology`,
  `IsModuleTopology.iso` for transport along a continuous linear equivalence, and
  `IsTopologicalSemiring.toIsModuleTopology`. This is the canonical topology Layer 2 uses, so no
  private basis-transport construction is introduced. `Mathlib/Analysis/Normed/Module/FiniteDimension.lean`
  has `LinearMap.continuous_of_finiteDimensional`, the archimedean half of the continuity input.
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
  at most `n` reflections; its Layer 3 `discr` and `signedDiscr`; its 6C `hilbertSymbol`,
  `localHasse` and `hasseInvariant_eq_localHasse`, and its 6D classification of forms over a finite
  extension of `ℚ_p` by `(dim, d, s)`, which is what makes the local spinor-norm images of Layer 2
  computable. Its standing `[Invertible (2 : K)]` is this roadmap's too.

  ⚠ That roadmap is **local**: it stops at forms over a nonarchimedean local field. The
  Hasse–Minkowski principle that Layer 5H needs is global and is not among its milestones; the
  supplier table records that row as unowned rather than pointing it at Layer 6.
- **The [local fields roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/2)**, for the local
  structure Layer 2 needs: local compactness of a nonarchimedean local field with `𝒪[K]` compact
  open and `Kˣ` locally compact (its Layer 0), and its `square_eq_range_powMonoidHom` with the
  square-class counts `card_squareClasses_of_isUnit` and `card_squareClasses_dyadic`, which give
  finiteness of `Kˣ/(Kˣ)²`. That roadmap does not state openness of `(Kˣ)²` on its own, and
  openness is what makes the square-class group discrete and hence the spinor norm continuous;
  `unitFiltration_le_range_powMonoidHom_two`, which is `U(K, 2e+1) ⊆ (Kˣ)²` at the `e` of
  `absoluteRamificationIndex`, supplies it since the unit filtration is open, and Layer 2 below
  cites it in that form. Its companion `not_unitFiltration_le_range_powMonoidHom_two` is the
  sharpness, and is what stops the bound being read one step too far.
- **The [global class field theory
  roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/6)**, for two declarations. Its 11.4
  `hilbertProductFormula`, Hilbert reciprocity `∏_v (a,b)_v = 1`: Layer 5's passage from the local
  spinor-norm quotients to the global one is exactly a reciprocity statement, and it is consumed
  from there rather than reproved. This is the same theorem, under the same name, that the integral
  lattices roadmap consumes. And its 2A.3 `denseRange_algebraMap_finiteAdeleRing`, additive strong
  approximation, which Layer 4B reduces adelic approximation to. ⚠ The second is **not** that
  roadmap's Layer 0 weak approximation, which an earlier revision of this document cited; its own
  note says strong approximation is a different statement.
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

Where the supplier has fixed a Lean name at its current head, the **Consumed** column gives that
name and the row is an exact contract. Where the supplier has fixed a milestone but no name, the
row gives the milestone in the supplier's own citation form, and any provisional name both
roadmaps use is marked with an asterisk. A subject is never a row: "Hilbert reciprocity" is not
one, `hilbertProductFormula` is.

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
| the landed `TauCeti.SquareClassGroup` with `TauCeti.squareClass_eq_zero_iff`, and the multiplicative avatar `Kˣ ⧸ Subgroup.square Kˣ` with its `ZMod 2`-module dictionary, pushforward and finiteness transfer, from the milestone `0: square-class interop`; and the Kummer comparison `kummerSquareClassEquiv` with `kummerSquareClassEquiv_kummerClass`. ⚠ `SquareClassGroup` is landed Tau Ceti code, not a target of that roadmap; what it supplies is the interop | Quadratic Form Invariants, Layer 0 | Layers 1, 2, 5 |
| the Hilbert symbol `hilbertSymbol`, with `hilbertSymbol_comm`, `hilbertSymbol_mul`, `hilbertSymbol_unramified` and `exists_hilbertSymbol_eq_neg_one`; the local Hasse invariant `localHasse` with `hasseInvariant_eq_localHasse`; the plain discriminant of Layer 3; and, as a milestone, `6D: the classification` — two regular forms over a nonarchimedean local field are isometric exactly when `(dim, d, s)` agree | Quadratic Form Invariants, Layers 3, 6C, 6D | Layer 2 |
| `normalizedValuation` with `normalizedValuation_surjective` and `normalizedValuation_eq_one_iff`; `unitFiltration` with `unitFiltration_antitone` and `iInf_unitFiltration`; the square subgroup `square_eq_range_powMonoidHom` with the square-class counts `card_squareClasses_of_isUnit` and `card_squareClasses_dyadic`; and the deep-squares pair `unitFiltration_le_range_powMonoidHom_two` and `not_unitFiltration_le_range_powMonoidHom_two`, which is `U(K,2e+1) ⊆ (Kˣ)²` **with its sharpness**; plus `absoluteRamificationIndex` for the `e` in that bound. ⚠ The bound is indexed by the prime, because "the absolute ramification index" is not a number attached to `K` alone | Local Fields, Layers 0, 1 | Layers 2, 3 |
| local compactness of `K` and compact-openness of `𝒪[K]`, as `Layer 0: the valuation ring and its topology` | Local Fields, Layer 0 | Layers 2, 3 |
| `hilbertProductFormula`\*, Hilbert reciprocity `∏_v (a,b)_v = 1` over ℚ, with the finite symbols from the consumed `hilbertSymbol` and the real one from that roadmap's 2C.8 | Global Class Field Theory, 11.4 | Layer 5H |
| the functor of points of an affine group scheme, and morphisms of such | Reductive Groups, Layer 0 | Layer 3A |
| smoothness, connectedness, semisimplicity, simple connectedness, central isogenies | Reductive Groups, Layers 3, 6 | Layer 3A |
| the decomposition of a semisimple group into `K`-almost-simple factors | Reductive Groups, Layer 7 | Layers 3A, 4D |
| finite-dimensionality of `CliffordAlgebra Q`, that is `dim = 2^n` | Spin Representations, Layer 0 | Layer 2A |
| the multiplicative square-class avatar `Kˣ ⧸ Subgroup.square Kˣ` and its additive comparison | Quadratic Form Invariants, Layer 0 | Layers 1D, 2F, 3F |
| the Hasse–Minkowski principle over ℚ: locally isometric forms of equal dimension are isometric. ⚠ **No supplier owns this.** The Quadratic Form Invariants roadmap stops at forms over a nonarchimedean local field, and its Layer 6D classification is local; Hasse–Minkowski is global and appears nowhere in it, nor in Global Class Field Theory. Layer 5H needs it, so either that roadmap takes it as a milestone or this one does, and until it is placed the row is an **open prerequisite** and not a contract | *unowned* | Layer 5H (`Ш¹(ℚ, SO_Q) = 1`) |
| `denseRange_algebraMap_finiteAdeleRing`, additive strong approximation: `K` is dense in its **finite** adeles. ⚠ Not the weak approximation of that roadmap's 0.2, whose own note says strong approximation is a different statement, and not the discreteness of `K` in the full adele ring, where no density statement can hold | Global Class Field Theory, 2A.3 | Layer 4B |

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
upstream, and the orthogonal specialization: the finite, away-`S` and full adelic points of all
three groups, the maps between them, and the diagonal rational points of each. Eichler
transvections and strong approximation for `Spin`, together with the reduction theory both later
layers consume and the two literature inputs Layer 4C names, namely the openness of the closure of
a nondiscrete Zariski-dense subgroup of a local point group and `SK₁ = 1` for a central division
algebra over a `p`-adic field. Canonical Haar measures at every place with their invariance and
product, finiteness of the adelic covolume, the measure comparison along `Spin → SO`, and the
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
- **Dimension 5.** The even Clifford algebra `C₀` is a central simple `K`-algebra of degree four
  carrying its canonical **symplectic** involution `σ`, and `Spin(Q) ≅ Sp(C₀, σ)`, the symplectic
  group of that involution, which is `Sp₄` exactly when `C₀` splits. ⚠ Recording only the split
  identification `Spin₅ ≅ Sp₄` would leave the twisted forms unnamed, and they are precisely what
  Layer 5E needs at this dimension; type `C₂` is not covered by any special linear group.
- **Dimension 6.** The even Clifford algebra is a central simple algebra of degree four over the
  discriminant quadratic étale algebra `E`, with its canonical **unitary** involution, and
  `Spin(Q) ≅ SU(C₀, σ)`. The two branches again: for `E ≅ K × K` this is `SL₁` of a degree-four
  central simple `K`-algebra, hence `SL₄` in the split case; for `E` a quadratic field it is the
  special unitary group of a hermitian form over `E/K` and is not a special linear group over `K`.

### Layer 2: local topology, transvections, and local spinor norms

**Direct prerequisites.** Mathlib: `Padic` with its `ProperSpace` instance, the matrix and
endomorphism topology instances, `Module.End`. Spin Representations Layer 0:
finite-dimensionality of `CliffordAlgebra Q`. Quadratic Form Invariants Layer 3, the plain
discriminant, and Layers 6C and 6D: `hilbertSymbol`, `localHasse`, `hasseInvariant_eq_localHasse`,
and the classification over `ℚ_p` by `(dim, d, s)`. Local Fields Layer 0: local compactness and `𝒪[K]`
compact open; Layer 1: `square_eq_range_powMonoidHom`, `card_squareClasses_of_isUnit`,
`card_squareClasses_dyadic`, and the deep-squares pair `unitFiltration_le_range_powMonoidHom_two`
with `not_unitFiltration_le_range_powMonoidHom_two`, which is `U(K, 2e+1) ⊆ (Kˣ)²` together with
its sharpness, at the `e` of `absoluteRamificationIndex`. Internal: 0B, 0C, 0D, 1A, 1C, 1D, 1E.

`K` is `ℝ` or `ℚ_p` throughout, and each statement is proved uniformly in the local field where
the proof is uniform, so that a later development over a general local field can reuse it.

**2A. The topology is Mathlib's `moduleTopology`, and the milestone is that it applies.** A
finite-dimensional space over a local field carries no `TopologicalSpace` instance on its own, and
"the topology from `Module.End K V ≅ K^{n²}`" names a transport along a chosen basis rather than a
canonical object. Mathlib already has the canonical one:
`moduleTopology K V`, the finest topology making the module operations continuous, with the class
`IsModuleTopology K V` recording that a supplied instance is that one, and `eq_moduleTopology`
converting between them. That is the vocabulary used here, and no private basis-transport
construction is introduced.

The milestones are consequently about *applying* it rather than building it: that for `K` a local
field and `V` finite-dimensional the module topology is the basis transport, so `IsModuleTopology`
holds for the product topology through any basis and basis-independence is a corollary rather than
a separate theorem; that `Module.End K V`, `V ≃ₗ[K] V` and `CliffordAlgebra Q` carry it, the last
needing finite-dimensionality of the Clifford algebra, that is the Poincaré–Birkhoff–Witt
statement `dim = 2^n`, recorded in the dependency table as an input; that it is Hausdorff and
locally compact in this setting; and that every linear map between finite-dimensional spaces is
continuous for it, which is what makes base change and change of basis continuous.

⚠ Every topological statement in Layers 2 and 3 carries `IsModuleTopology` as a hypothesis rather
than an arbitrary `TopologicalSpace` instance, and `IsModuleTopology` **on its own is not enough**.
Each statement also carries the separation, the local compactness and the openness of the squares
that its proof uses, and one that omits them is not a weaker theorem but a wrong one. Two
counterexamples pin why, and both live at the same place: `K` with the indiscrete topology is a
topological field, and the indiscrete topology on a finite-dimensional space over it *is* the
module topology, so `IsModuleTopology` holds and rules nothing out.

- **Separation.** Take `K` indiscrete and `Q x = x²` in dimension one. The isometry set inside
  `Module.End K K = K` is `{±1}`, a nonempty proper subset of an indiscrete space, hence not
  closed. So 2B's closedness needs `{0}` closed, that is `T2Space K`, which is exactly what makes
  the equalizer of two continuous maps into `K` closed.
- **Openness of the squares.** Same topology, `Q x = a x²` with `a` a nonsquare. Then `O(Q)` is
  `{±1}` with the indiscrete topology and `ker θ` is the trivial subgroup, nonempty and proper and
  not open. So 2E needs `(Kˣ)²` open in `Kˣ`; that is the local-field input cited from the local
  fields roadmap's Layer 1, and it does not follow from the module topology.

Local compactness of the point groups is carried the same way, as `LocallyCompactSpace K`. Over `ℝ`
and over `ℚ_p` all three hold, so no generality is lost; what is gained is that the hypotheses are
the ones the proofs consume, and a later development over another local field can read off exactly
what it has to supply.

**2B. Point groups as topological groups, in one canonical topology.** `Module.End K V` carries the
module topology of 2A, and `V ≃ₗ[K] V` carries the topology induced by `f ↦ (f, f⁻¹)` into
`Module.End K V × Module.End K V`, the coarsest one making composition and inversion continuous.
⚠ That is **the** topology of this roadmap and it is declared once, as an instance: every subgroup
of `V ≃ₗ[K] V` carries the subspace topology from it, so `O(Q)(K)`, `SO(Q)(K)` and every compact
open subgroup of either are topologized by that single declaration, as are the restricted products
of Layer 3. No statement in Layers 2 to 5 quantifies over a topology, carries one as data, or
supplies one of its own, and consequently there is never a gap between the topology a subgroup is
proved compact open in and the topology the restricted product containing it is formed with.
`Spin(Q)(K)` is topologized the same way, from the module topology on `CliffordAlgebra Q`.

The milestones: `V ≃ₗ[K] V` is a topological group in it; `O(Q)(K)` is **closed** in
`Module.End K V`, being cut out by the polynomial equations `Q (f x) = Q x`; `SO(Q)(K)` is closed
in `O(Q)(K)` and, the determinant being continuous with image in the discrete `μ₂`, also open in
it; both are locally compact, from closedness inside a finite-dimensional space over a locally
compact field; `Spin(Q)(K)` is a closed, locally compact topological group. Continuity of the
determinant, of the vector representation, of `spinToSpecialOrthogonal` and of the base-change maps
of Layer 0B.

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
a **compatible tuple** `(U_p^O, U_p^{SO}, U_p^{Spin})`. Every openness and compactness statement in
it is against the one canonical topology of 2B, so the tuple carries no topology of its own; a
structure that spoke of compact open subgroups while storing its own topology would prove nothing
about the restricted products built from it. Two families are supplied:

- `U_p^O ≤ O(V_p)`, compact and open at every finite place;
- `U_p^{Spin} ≤ Spin(V_p)`, compact and open at every finite place, supplied rather than obtained
  as a preimage, since a preimage of a compact set under `Spin → SO` is compact only once
  properness is known (2D);

together with two integrality hypotheses, which are what make the diagonal maps of 3E well defined:
every element of `O(V)(ℚ)` lies in `U_p^O` for almost all `p`, and every element of `Spin(V)(ℚ)`
lies in `U_p^{Spin}` for almost all `p`.

The third member is **derived, and its properties are proved rather than assumed**:
`U_p^{SO} := U_p^O ∩ SO(V_p)` as a named definition, with the theorems that it is open in `SO(V_p)`
(from openness of `U_p^O` and continuity of the inclusion) and compact (from closedness of
`SO(V_p)` in `O(V_p)`, 2B), and with the integrality hypothesis for `SO` derived from the one for
`O` rather than assumed, since a rational proper isometry lying in `U_p^O` lies in the
intersection. The compatibility that ties the tuple together is that `U_p^{Spin}` maps into
`U_p^{SO}`, and it is stated that way rather than as "maps into `U_p^O`": it is what the adelic map
`Spin(V)(𝔸_f) → SO(V)(𝔸_f)` of 3D is built from, and the weaker statement does not give it.
Beside them the reference subgroup `θ_p(U_p^{SO})` in the local square-class group, defined as the
image of `U_p^{SO}` under the local spinor norm and not as a further parameter.

**3D. The three adelic point groups.** The index conventions are pinned in Lean rather than written
informally: the finite places are indexed by the primes; the archimedean place is carried by a
product decomposition rather than by a dependent type of places, so that `G(𝔸) = G(ℝ) × G(𝔸_f)` is
a definition and not a theorem; and for a finite set `S` of places with `∞ ∈ S`, `G(𝔸^S)` is the
restricted product over the finite places outside `S`, so that at `S = {∞}` it is `G(𝔸_f)` on the
nose rather than up to an identification. For **each** of `O`, `SO` and `Spin`, relative to a
compatible tuple: finite adelic points, points away from `S`, and full adelic points. Then the
restrictions `G(𝔸_f) → G(𝔸^S)`, the projections out of `G(𝔸)`, and the componentwise maps
`Spin(V)(𝔸_•) → SO(V)(𝔸_•) → O(V)(𝔸_•)` in all three flavours, obtained from 3B's functoriality
applied to `spinToSpecialOrthogonal` and `specialOrthogonalToOrthogonal` with 3C's compatibility.
⚠ All three groups are built and not just `O`. Layer 4 is a theorem about `Spin` transported to
`SO`, and Layer 5 measures `SO`; a development that constructs only `O` has nothing to state either
of them in, and an `O`-statement carrying the name of a `Spin` theorem is not the theorem.

**3E. ⚠ Diagonal points: discrete in the full adeles, not generally discrete in the finite
adeles.** Density in the finite adeles is not a Layer 3 statement at all: it holds for `Spin`
under Layer 4's hypotheses and is proved there. The diagonal
map is well defined only once one knows that a given rational isometry lies in `U_p` for all but
finitely many `p`, which is a theorem. Both forms are milestones: the **relative** one, for a
tuple satisfying "every element of `O(V)(ℚ)` lies in `U_p^O` for almost all `p`" as an explicit
hypothesis, which is the form the integral lattices roadmap discharges for its lattice
stabilizers; and the **absolute** one, discharging that hypothesis for the stabilizers of the
`ℤ`-span of a chosen basis of `V`, by clearing denominators in the matrix of a rational isometry
and of its inverse. The second exists so the roadmap's own objects rest on something; it develops
no lattice arithmetic. The diagonal map is built for each of the three groups, and for each of the
three flavours of 3D: for `O` and for `Spin` from the two integrality hypotheses of 3C, and for
`SO` from `O`'s, since a rational proper isometry lying in `U_p^O` lies in `U_p^{SO}`. Each comes
with its evaluation rule and its injectivity, and the square
`Spin(V)(ℚ) → Spin(V)(𝔸_f) → SO(V)(𝔸_f)` against `Spin(V)(ℚ) → SO(V)(ℚ) → SO(V)(𝔸_f)` commutes,
which is what lets Layer 4F speak of "the image of the rational spin points in adelic `SO`" without
saying which of the two routes is meant.

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

**3F. The adelic spinor norm, on `SO`.** The restricted product of the local square-class groups
relative to the reference subgroups `θ_p(U_p^{SO})` of 3C; the theorem that the componentwise local
spinor norms induce a continuous homomorphism `SO(V)(𝔸_f) → ∏' ℚ_p^×/(ℚ_p^×)²` into it,
**together with its evaluation rule**, that the `p`-component of the value is the local spinor norm
of the `p`-component of the argument; and the **adelic spinor kernel** as its kernel. Three things
are pinned here rather than left to an implementer.

- There is no such thing as "the restricted product of the local square-class groups" until the
  reference subgroups are fixed; several inequivalent choices exist, and the one used here is
  `θ_p(U_p^{SO})`.
- ⚠ The domain is adelic **`SO`**, not adelic `O`. The reference subgroups are the images of the
  `U_p^{SO}`, and an improper element of `U_p^O` has no reason to have local spinor norm inside
  `θ_p(U_p^{SO})`, so a map out of adelic `O` would not land in the stated codomain.
- ⚠ The evaluation rule is part of the milestone. A homomorphism into that restricted product with
  no rule relating its components to the local spinor norms is satisfied by the trivial
  homomorphism, and every theorem stated about its kernel would then be a theorem about the whole
  group.

**3G. Double cosets, with the maps stated separately.** The set `G(ℚ) \ G(𝔸_f) / U`, with three
distinct comparison statements rather than one blanket change-of-`U` map, since eventually equal
reference families give canonically equivalent ambient groups but do **not** automatically give a
canonical bijection of double-coset sets: an inclusion `U ≤ U'` of compact opens induces a
surjection of double-coset sets in the corresponding direction; conjugate compact opens induce a
canonical bijection; and a componentwise equivalence carrying one tuple to another transports the
double-coset set along 3B's canonical equivalence. Finiteness of the set is not claimed here.

**3H. Reduction theory, as the input Layers 4 and 5 share.** Both later layers need one theorem
about the size of the arithmetic subgroups, and it is stated here so that neither consumes the
other. For `G` either `SO_Q` or `Spin_Q`, and `S` a finite set of places containing `∞`, with
`G(ℤ_S)` the `S`-integral points for the `ℤ`-span of the chosen basis of 3E:

1. the **norm-one subgroup** `G(𝔸)¹`, cut out by `|χ(x)|_𝔸 = 1` for every rational character
   `χ ∈ X(G) ⊗ ℚ`, together with the theorem that `G(𝔸)¹ = G(𝔸)` when `X(G) ⊗ ℚ = 0`, in
   particular for `G` semisimple, which is every case except `SO_Q` in dimension two;
2. `G(ℤ_S)` is a **discrete** subgroup of `G_S = ∏_{v ∈ S} G(ℚ_v)`, and `G(ℚ)` is discrete in
   `G(𝔸)`, which is 3E;
3. the quotient `G_S / G(ℤ_S)` carries a **finite** invariant measure for a Haar measure on `G_S`,
   and likewise `G(ℚ) \ G(𝔸)¹` for a Haar measure on `G(𝔸)¹`. ⚠ It is `G(𝔸)¹` and not `G(𝔸)`:
   in dimension two `SO_Q` is a torus, `G(𝔸)/G(ℚ)` has infinite volume, and the finiteness that
   does hold is the classical finiteness of the volume of the norm-one idele class group;
4. the **density theorem**: if `G_S` is noncompact then `G(ℤ_S)` is Zariski dense in `G`, which
   follows from 3 together with the `ℚ`-almost-simplicity supplied by 3A.

This is Borel and Harish-Chandra's reduction theory, in the `S`-arithmetic form of
Platonov–Rapinchuk Chapter 5. ⚠ It is stated for *some* Haar measure and is therefore independent
of Layer 5's normalization: Layer 5D's finiteness of the Tamagawa volume is item 3 applied to the
Tamagawa measure, and Layer 4C consumes items 3 and 4, so the two layers stay independent of each
other. ⚠ The boundary with the integral lattices roadmap is that nothing here is a statement about
classes: no finiteness of a class number, no genus, no mass. Those are that roadmap's, and they
consume this one.

### Layer 4: strong approximation for Spin

**Direct prerequisites.** Internal: 2C for the transvections and their Spin lifts, 2D for
noncompactness, 3A items 5 to 7 for semisimplicity and the factor decomposition, 3D for `𝔸^S`,
3E for the diagonal maps, 3F for the adelic spinor kernel, 3H for reduction theory, 1F for
dimension four. External: `denseRange_algebraMap_finiteAdeleRing` of global class field theory
2A.3, the Kneser–Tits generation input named in 4A, and the two literature inputs named in 4C.

⚠ This is a **noncompact-place** theorem, not literally an indefinite one: the hypothesis is that
each `ℚ`-almost-simple factor of `Spin(V)` is noncompact at some place of `S`, which a positive
definite form can satisfy at a finite place. The indefinite statement is the corollary at
`S = {∞}`, and that corollary is what Eichler's theorem on lattice classes runs on. Layer 5 does
not use this layer.

**4A. The generation theorem.** The step "generated by transvection subgroups, hence reduce to
additive approximation" hides the main local input, so it is stated: the subgroup of `Spin(V)(K)`
generated by the canonical transvection lifts of 2C is the **elementary subgroup** `E(V)(K)`, and
the target is the equality `E(V)(K) = Spin(V)(K)`, not a finite-index approximation to it, in each
of the two cases 4B and 4C meet: `K` a local field of characteristic zero with `V ⊗ K` isotropic
of dimension at least three, and `K = ℚ` with `V` isotropic of dimension at least three. That
equality is the Kneser–Tits property for the simply connected isotropic group `Spin(V)`, which
holds because `Spin(V)` is `K`-isotropic of `K`-rank at least one and simply connected; the input
is Platonov–Rapinchuk §7.2. The `K`-anisotropic case is not claimed: over a local field the
equality is false there, which is exactly why the places at which `Spin(V)` is compact have to be
handled separately in 4C. Stating a finite-index variant instead would leave an implementer with
two targets and no criterion for choosing.

**The corollary the general case runs on**: for `K` local of characteristic zero and `V ⊗ K`
isotropic of dimension at least three, `Spin(V)(K)` has **no proper subgroup of finite index**.
It needs nothing beyond the equality above and 2C: a subgroup of index `m` contains a normal
subgroup of index dividing `m!` and therefore contains `g^{m!}` for every `g`, while the additive
composition law of 2C makes every transvection lift `Ẽ_{u,w}` equal to `(Ẽ_{u,w/m!})^{m!}`. So
every generator lies in the subgroup, and the subgroup is everything.

**4B. The case of a `ℚ`-isotropic space.** When `V` is isotropic **over ℚ** the theorem has a short
proof, and it is a milestone in its own right because everything it runs on is needed anyway. The
statements, in order:

1. **Splitting a hyperbolic plane.** For `V` isotropic over ℚ, `V ≅ H ⊥ V₀` with `H` hyperbolic
   and `dim V₀ = dim V − 2`, and the transvection subgroups attached to the isotropic vectors of
   `H` are the ones 4A generates with.
2. **Density of the adelic transvection subgroups.** The subgroup of `Spin(V)(𝔸^S)` generated by
   the adelic points of the transvection subgroups of 2C is dense, which reduces approximation to
   `denseRange_algebraMap_finiteAdeleRing`, additive strong approximation for `𝔸` relative to `ℚ`,
   consumed by name from global class field theory 2A.3. ⚠ That declaration says `ℚ` is dense in
   the **finite** adeles. It is not that roadmap's weak approximation, 0.2, whose own note records
   that strong approximation is a different statement, and it is not the discreteness of `ℚ` in the
   full adele ring, where no density statement can hold. An earlier revision of the supplier table
   cited Layer 0 for this, which was the wrong milestone.
3. **The rank-one base case.** `dim V = 3` with `V` isotropic, where `Spin(V) ≅ SL₂` over ℚ by 1F,
   and strong approximation for `SL₂` is the classical statement.
4. **The induction step.** Approximating in `Spin(H ⊥ V₀)` from approximation in the transvection
   subgroups together with the case of `V₀`, using 4A's generation theorem at each place of `S`.

⚠ This settles the `ℚ`-isotropic case and nothing else, and 4C does not run through it.

**4C. The general case, by one fixed route.** ⚠ There is no reduction of the general case to 4B.
Local isotropy at a place of `S` does not split a hyperbolic plane over ℚ, so 4B never applies to a
`ℚ`-anisotropic space, and the anisotropic case is not a corollary of the isotropic one. Nor is it
a small residue. `x² + y² − 3z²` is indefinite over ℝ and anisotropic over ℚ, since `x² + y² = 3z²`
in coprime integers forces `3 ∣ x` and `3 ∣ y`, hence `9 ∣ 3z²` and `3 ∣ z`; and every positive
definite form is anisotropic over ℚ while being isotropic over every `ℚ_p` once `dim V ≥ 5`. So the
`ℚ`-anisotropic case carries the theorem in every dimension, and in particular it carries the
`S = {∞}` indefinite corollary that the integral lattices roadmap consumes.

The route of record is the characteristic-zero proof of Platonov–Rapinchuk Theorem 7.12,
specialized to `Spin_Q` through 3A. No alternative route is offered, because an implementer must
not have to choose a proof architecture. The intermediate statements, in the order the proof uses
them:

1. **Reduction to almost-simple factors.** Strong approximation for `Spin(V)` with respect to `S`
   holds exactly when it holds for each `ℚ`-almost-simple factor, by 3A item 7; this is where 4D's
   hypothesis is used factor by factor.
2. **Reduction to `S`-arithmetic density.** Density of the diagonal image of `Spin(V)(ℚ)` in
   `Spin(V)(𝔸^S)` is equivalent to density of `Spin(V)(ℤ_{S ∪ S₁})` in `∏_{v ∈ S₁} Spin(V)(ℚ_v)`
   for every finite set `S₁` of places disjoint from `S`, because a basic open set of `𝔸^S` is an
   open set at finitely many places times the integral subgroup everywhere else.
3. **The compact places.** The set `S_c` of finite places at which `Spin(V)(ℚ_p)` is compact,
   which by 2D is the set of `p` with `V ⊗ ℚ_p` anisotropic. It is finite, and by the local
   classification it is **empty** once `dim V ≥ 5`, so only dimensions three and four have any.
4. **No proper subgroup of finite index**, which is 4A's corollary, available at every place
   outside `S ∪ S_c`.
5. **One place at a time.** For `v ∉ S ∪ S_c`, `Spin(V)(ℤ_{S ∪ {v}})` is dense in
   `Spin(V)(ℚ_v)`. This is where reduction theory enters: 3H item 3 makes the closure nondiscrete
   with a finite-covolume quotient, 3H item 4 makes it Zariski dense, so it is **open**, because
   the closure of a nondiscrete Zariski-dense subgroup of the `p`-adic point group of an
   almost-simple group is open; and then 4 turns an open subgroup of finite index into the whole
   group. The openness step is Cartan's theorem that a closed subgroup of a `p`-adic Lie group is
   a Lie subgroup, applied to the closure.
6. **Assembling the places of `S₁`.** The two-factor density criterion, Platonov–Rapinchuk Lemma
   7.4: a subgroup of `B₁ × B₂` that projects densely to `B₁` and meets each member of a
   neighbourhood basis of subgroups of `B₁` in something projecting densely to `B₂` is dense.
   With 5 and 4 this proves 2, and hence 4E, whenever `S ⊇ S_c ∪ {∞}`.
7. **Weak approximation for `Spin(V)`**, which is what removes `S_c` from `S`: `Spin(V)(ℚ)` is
   dense in `∏_{v ∈ T} Spin(V)(ℚ_v)` for every finite set `T` of places. `Spin_Q` is unirational
   over ℚ, so the closure of the rational points is open in the product and the quotient by it is
   discrete; 3H item 3 makes that quotient of finite measure, hence finite; and 4 kills it, except
   at a place of `S_c`, where the local group is compact and is the reduced-norm-one group of a
   central simple algebra over `ℚ_v`, and the input is instead `SK₁ = 1` over a `p`-adic field.
8. **Removing `S_c`.** `S_c` is finite and `∏_{v ∈ S_c} Spin(V)(ℚ_v)` is compact with a
   neighbourhood basis of open subgroups of finite index, so 7 and 6 descend the conclusion from
   `S ∪ S_c` to `S`, using that `Spin(V)(𝔸^{S ∪ S_c})` has no proper closed subgroup of finite
   index because none of its local factors does, by 4.
9. **Removing the archimedean place**, for an `S` that does not contain `∞`. The remaining factor
   is `Spin(V)(ℝ)`, which is connected because `Spin(V)` is simply connected and semisimple. The
   connected component of the closure of the `S`-integral points there is normalized by the
   rational points, which are dense by 7, so it is a normal connected subgroup and hence a
   sub-product of the factors; 3H item 3 together with Cartan's theorem over ℝ forbids it from
   being a proper one. ⚠ This is the only step that uses connectivity of the real point group, and
   it is why 4E states general-`S` density against arbitrary nonempty open sets while the
   `Spin(V)(ℚ) · U` reformulation carries `∞ ∈ S`.

⚠ Items 5, 7 and 9 are the deep ones, and none has an upstream source: 5 and 9 need the Lie theory
behind Cartan's theorem, over `ℚ_p` and over ℝ, and 7 needs `SK₁ = 1` for a central division
algebra over a `p`-adic field. All are targets here, cited in the references, and all are what a
phrase like "reduce to the isotropic case" would have hidden.

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
`SO(V)(𝔸^S)`, along either leg of the commuting square of 3E, is the adelic spinor kernel of 3F;
equivalently the obstruction to strong approximation for
`SO` is measured by the adelic spinor norm, and it is stated as that cokernel rather than as a
blanket failure, since in special cases the obstruction vanishes. This is the exact reason spinor
genera exist.

### Layer 5: Tamagawa measures, and the orthogonal volume theorem

**Direct prerequisites.** Mathlib: `haarMeasure`, `haarScalarFactor`, `IsFundamentalDomain`,
`QuotientMeasureEqMeasurePreimage`, `covolume`. Internal: 3A for the group schemes and their
invariant differentials, 3D for the full adelic points, 3E for discreteness of the rational
points in `G(𝔸)`, 3H for finiteness of the covolume, 2F and 3F for the local and adelic spinor
norms. External: `hilbertProductFormula` of global class field theory 11.4, and the product
formula. ⚠ The Hasse principle that 5H's `Ш¹ = 1` **is** has no supplier; see 5H. **Not** Layer 4.

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

**5B. Convergence, with the factors named, in both torus cases.** For a **semisimple** group the
product of local volumes converges with no convergence factors, and that statement is the milestone
for `Spin_Q` and `SO_Q` in dimension at least three. For a **torus**, which is what dimension two
produces, it does not converge, and the factors are the local Artin `L`-factors of the character
module: `λ_v = L_v(1, X(T) ⊗ ℚ)`. The global compensating constant is

    ρ(T) = lim_{s → 1} (s − 1)^{r(T)} · L(s, X(T) ⊗ ℚ),

where `r(T)` is the rank of the Galois invariants of `X(T)`, equivalently the ℚ-rank of the maximal
ℚ-split subtorus of `T`. The theorem to state is that `∏_v λ_v⁻¹ · vol(T(ℚ_v), U_v)` converges and
that the resulting measure is independent of the choice of factors up to `ρ(T)`. ⚠ For
`T = R¹_{E/ℚ}𝔾_m`, the norm-one torus of a quadratic étale algebra `E`, the **two cases of `E` are
genuinely different and both are stated**:

- `E` a quadratic **field**: `T` is anisotropic, `X(T)` is `ℤ` with the nontrivial Galois action,
  `L(s, X(T)) = L(s, χ_E)` is the Dirichlet `L`-function of the quadratic character attached to
  `E`, `r(T) = 0`, and `ρ(T) = L(1, χ_E)`, which is finite and nonzero because `χ_E` is a
  nontrivial quadratic character.
- `E ≅ ℚ × ℚ` **split**: `T ≅ 𝔾_m`, `X(T)` is `ℤ` with the *trivial* action, `L(s, X(T)) = ζ(s)`,
  and `r(T) = 1`. There is no finite value `L(1, χ_E)` to use, because `ζ` has a simple pole at
  `s = 1`; the normalization goes through `ρ(T) = Res_{s=1} ζ(s)` instead. Writing the split case
  with a finite `L`-value is the error this subsection exists to prevent.

⚠ The split case also changes what the volume is taken of. `𝔾_m` has a nontrivial group of rational
characters, so `T(𝔸)/T(ℚ)` has infinite volume and the Tamagawa number is the volume of
`T(𝔸)¹/T(ℚ)`, where `T(𝔸)¹` is cut out by `|χ(x)|_𝔸 = 1` for every `χ ∈ X(T) ⊗ ℚ`. That
subgroup is 3H item 1, and it is where the theorem that it is all of `G(𝔸)` for a semisimple `G`
is stated. Nothing in dimension at least three uses this subsection, since `Spin_Q` and
`SO_Q` are semisimple there and have no nontrivial rational characters.

**5C. Adelic points, the product measure, and the norm-one subgroup.** Full adelic points of the
group, consumed from Layer 3D; the product Haar measure; discreteness of the rational points,
consumed from Layer 3E; the fundamental-domain and quotient-measure API against Mathlib's
`QuotientMeasureEqMeasurePreimage` and `covolume`; and the norm-one subgroup `G(𝔸)¹` of 3H item 1.
⚠ It is `G(𝔸)¹`, not `G(𝔸)`, that every volume statement below is taken in; the two coincide in
dimension at least three, and 5B's split binary case is where they do not. ⚠ Three upstream
constraints shape this subsection and are
stated rather than discovered: `covolume` is `ℝ≥0∞`-valued and returns `0` when no fundamental
domain exists; `haarMeasure_quotient` requires the subgroup countable and the quotient measure
finite; and Mathlib has no `IsUnimodular` class, so unimodularity is carried as left-invariance
together with right-invariance and proved for each group used.

**5D. Finiteness, then the number.** Finiteness of the Tamagawa volume of `G(ℚ) \ G(𝔸)¹`, as its
own milestone preceding any computation of it, which is 3H item 3 applied to the Tamagawa measure
of 5A once that measure is shown to be a Haar measure; and the definition of the Tamagawa number.

**5E. Central isogenies, and `τ(Spin_Q) = 1` by one named route.** Two things. First, the
comparison of Tamagawa measures under a central isogeny, in the form Ono's relative theory gives,
with the local and global contributions of the kernel identified; this is the general statement 5H
instantiates. Second, `τ(G) = 1` for `G` connected, simply connected and semisimple, which for
`G = Spin_Q` is the deepest input the roadmap has. The route of record is Weil's, in *Adeles and
Algebraic Groups*, and its steps are:

1. `τ(SL_n) = 1`, by explicit reduction theory and the Iwasawa decomposition.
2. `τ(SL₁(A)) = 1` for `A` a central simple algebra, from 1 by Ono's isogeny method, `SL₁(A)` being
   an inner form of `SL_n`.
3. `τ(Sp_{2n}) = 1`, by reduction theory for the symplectic group, and `τ(Sp(A, σ)) = 1` for `A`
   central simple with a symplectic involution, from it by Ono's method. ⚠ This is a separate
   family and **not** a consequence of 1 and 2: dimension five is type `C₂`, where 1F gives
   `Spin_Q ≅ Sp(C₀, σ)` for the degree-four even Clifford algebra, which is `Sp₄` only when that
   algebra splits and is in no case an `SL₁(A)`, a product of two of them, or a restriction of
   scalars of one.
4. `τ(SU(A, σ)) = 1` for `A` central simple over a quadratic étale algebra with a unitary
   involution, needed at dimension six when the discriminant algebra is a field.
5. `τ(G₁ × G₂) = τ(G₁) · τ(G₂)` and `τ(R_{E/ℚ} G) = τ(G)`, the two compatibilities that assemble
   the low-dimensional cases.
6. `τ(Spin_Q) = 1` for `3 ≤ dim V ≤ 6`, from 1F together with 1 to 5: dimension three gives
   `SL₁` of a quaternion algebra, dimension four a product of two such or a restriction of scalars
   of one along the discriminant algebra, dimension five the symplectic case of 3, and dimension
   six either `SL₁` of a degree-four algebra or the unitary case of 4.
7. `τ(Spin_Q) = 1` in general, by Weil's induction on the dimension of the quadratic space.

⚠ Step 7 is where the analytic input of Weil's argument sits, in the adelic Poisson-summation
identity of *Adeles and Algebraic Groups*, and it is worth being explicit that this does **not**
make the roadmap circular with the integral lattices roadmap. That roadmap derives the
Smith–Minkowski–Siegel mass formula *from* the volume theorem and proves no analytic identity of
its own; the implication runs one way, and nothing here consumes the mass formula.

**5F. The orthogonal specialization.** The gauge forms on `O_Q`, `SO_Q` and `Spin_Q` from 3A, the
resulting local and global measures, and their invariance under isometry of quadratic spaces.

**5G. Comparison with the lattice-relative normalization.** The volume of a compact open subgroup
in the canonical normalization, stated for an arbitrary compact open subgroup rather than for a
lattice, since the integral lattices roadmap's Layer 7C identifies its local densities with
canonical Haar volumes of stabilizers and needs a form it can quote.

**5H. The isogeny computation, displayed.** The identity being instantiated is Ono's, for a
connected semisimple group:

    τ(G) = |Pic(G)| / |Ш¹(ℚ, G)|.

For `G = SO_Q` with `dim V ≥ 3` the two terms are computed separately, and each is a milestone:

- `Pic(SO_Q) ≅ ℤ/2`, of order **2**, because `Spin_Q → SO_Q` is a central isogeny with kernel `μ₂`
  and `Spin_Q` is simply connected, so the Picard group is the character group of the kernel.
- `Ш¹(ℚ, SO_Q) = 1`, of order **1**. ⚠ This is not a formality: it is exactly the Hasse principle
  for quadratic forms, that two forms of the same dimension over ℚ which are isometric over every
  `ℚ_v` are isometric over ℚ, since `H¹(k, SO_Q)` classifies forms of the same dimension and
  discriminant.

  ⚠ **It has no supplier.** The quadratic form invariants roadmap stops at forms over a
  nonarchimedean local field: its Layer 6D classification is local, and Hasse–Minkowski appears
  nowhere in it, nor in global class field theory. An earlier revision of the supplier table
  cited "Quadratic Form Invariants, Layer 6" for it, which is the local classification and a
  different theorem. Until the statement is placed — in that roadmap, which is its natural home,
  or here — this is an **open prerequisite** of 5H, and the supplier table says so rather than
  naming an owner that does not own it.

Beside those, the local and global square-class bookkeeping the comparison runs on, displayed
rather than described: the exact sequence of pointed sets

    1 → μ₂(ℚ) → Spin_Q(ℚ) → SO_Q(ℚ) --θ--> ℚˣ/(ℚˣ)² → H¹(ℚ, Spin_Q)

together with its local analogue at every place, the compatibility of the two under the
restriction maps of 2H, and the theorem that the image of `∏_v` on square classes is cut out by
`hilbertProductFormula`, Hilbert reciprocity `∏_v (a,b)_v = 1`, consumed by name from global class
field theory 11.4. The
connecting map `θ` in that sequence is the spinor norm of Layer 1D, which is what ties this layer
to the rest of the roadmap.

**5I. The theorem, by dimension, with every value stated.** From 5E and 5H:

- `dim V ≥ 3`: `τ(SO_Q) = 2`.
- `dim V = 2`: `SO_Q` is the norm-one torus `R¹_{E/ℚ}𝔾_m` of the discriminant quadratic étale
  algebra `E` of 1F, and the value is **2** when `E` is a field and **1** when `E ≅ ℚ × ℚ` is
  split, in which case `SO_Q ≅ 𝔾_m` and the volume is taken in `SO_Q(𝔸)¹`, not `SO_Q(𝔸)`. The
  computation is Ono's formula again, with the convergence factors of 5B and, in the split case,
  the residue normalization rather than a finite `L`-value; `Spin_Q` is a torus here too, so 5E
  does not apply and this case is proved directly.
- `dim V = 1`: `SO_Q` is trivial and `τ(SO_Q) = 1`.
- `dim V = 0`: `SO_Q` is trivial and `τ(SO_Q) = 1`.

The dimension `0` and `1` values are the guard the integral lattices roadmap's Conway–Sloane
normalization records in its own low-rank branch, and the two documents state the same exceptions.

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
- Dimension one, `Q x = a x²` for `a ∈ Kˣ`: `O(Q) = {±1}`, `SO(Q)` is trivial, `-1` is the
  reflection in any `v ≠ 0`, and `θ(-1) = [a]`, which is nontrivial exactly when `a` is not a
  square. ⚠ The scalar has to be carried: for `Q x = x²` one gets `Q v = v²` and `θ(-1) = [1]`,
  so that instance is the degenerate one and tests nothing. With `a` a nonsquare this is the
  acceptance check that the square class detects `-1` and hence that the `reverse` and `star`
  norms of 1A really do differ on `O(Q)` (Layers 0, 1).
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
- **Indefinite does not mean isotropic over ℚ**: `x² + y² − 3z²` has signature `(2,1)` and is
  anisotropic over ℚ, so it satisfies the hypothesis of 4E at `S = {∞}` while 4B says nothing about
  it. Exhibiting it is the acceptance check that Layer 4's route does not pass through a global
  hyperbolic plane, and that the corollary the lattice side consumes really needs 4C (Layer 4).
- **The split binary torus**: for `Q = xy` the discriminant algebra is `ℚ × ℚ`, `SO_Q ≅ 𝔾_m`, and
  `SO_Q(𝔸)/SO_Q(ℚ)` has infinite volume, so the Tamagawa number is a volume in `SO_Q(𝔸)¹` and the
  convergence factors are normalized by the residue of `ζ` and not by a value of a Dirichlet
  `L`-function. Beside it a form with `E` a quadratic field, where `L(1, χ_E)` is the constant.
  Running the field case's normalization on the split one is the error 5B exists to prevent
  (Layers 5B, 5I).
- **Dimension five is symplectic**: for a five-dimensional `Q` the even Clifford algebra has degree
  four, `Spin(Q) ≅ Sp(C₀, σ)`, and in the split case `Spin₅ ≅ Sp₄`, which is not a special linear
  group of any central simple algebra. This is the acceptance check that 5E's case list covers type
  `C₂` (Layers 1F, 5E).

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
in this roadmap. Layers 3C to 3G need Layer 2, and 3H needs 3A and 3E.

Layers 4 and 5 both consume Layer 3, 3H included, and neither consumes the other, which is the
second load-bearing distinction made structural. Within Layer 5, the general machinery 5A to 5E
needs only 3A, 3D and 3H and can proceed in parallel with the whole of Layer 4; 5F to 5H then need
2F and 3F; and 5E is the long pole. Within Layer 4, 4A and 4B can be built as soon as Layer 2C and
Layer 3D exist, while 4C is the long pole and is the only place the two literature inputs it names
are needed.

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
  for Layers 3 to 5. Chapter 3 for adelic groups of algebraic groups and the discreteness of 3E;
  Theorem 5.5 and the surrounding reduction theory for 3H; Chapter 5 for Tamagawa measures and
  numbers, its §5.3 for the gauge-form normalization and the product-formula argument of 5A;
  Chapter 7 for strong approximation, with Theorem 7.12 the statement 4E follows and its
  characteristic-zero proof the route 4C fixes, Lemma 7.4 the two-factor density criterion of 4C
  item 6, §7.2 the Kneser–Tits generation theorem of 4A, and its computation of `SK₁` over a local
  field the input to 4C item 7.
- A. Rapinchuk, *Strong approximation for algebraic groups*, in *Thin Groups and Superstrong
  Approximation*, MSRI Publications 61, Cambridge (2014), 269–298. The proof of Theorem 7.12
  written out with its ingredients separated, which is the decomposition 4C follows step by step.
- J.-P. Serre, *Lie Algebras and Lie Groups*, Lecture Notes in Mathematics 1500, Springer (1992).
  Part II for `p`-adic analytic groups and Cartan's theorem that a closed subgroup of a `p`-adic Lie
  group is a Lie subgroup, which is the openness input of 4C items 5 and 9.
- A. Weil, *Adeles and Algebraic Groups*, Progress in Mathematics 23, Birkhäuser (1982). The
  Tamagawa measure, and `τ(G) = 1` for the simply connected classical groups, which is 5E,
  including the symplectic and unitary families its items 3 and 4 need and the adelic
  Poisson-summation identity behind its item 7.
- T. Ono, *On the relative theory of Tamagawa numbers*, Ann. of Math. 82 (1965) 88–111. The
  behaviour of Tamagawa numbers under a central isogeny, which is the computation 5E and 5H run.
- J. G. M. Mars, *Les nombres de Tamagawa de certains groupes algébriques*, Séminaire Bourbaki
  exp. 351 (1968/69). The orthogonal and spin Tamagawa numbers surveyed, with the derivation of
  `τ(SO) = 2` from `τ(Spin) = 1` that 5H formalizes.
- J. W. S. Cassels, A. Fröhlich (eds.), *Algebraic Number Theory*, Academic Press (1967). The
  adelic background of Layers 3 and 5, and the product formula 5A uses.
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter IV. The local and global
  square-class background in the form the sibling roadmaps use.
