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
**Strong approximation for `Spin` is an indefinite theorem**: it needs a place at which the group
is noncompact, and it is what Eichler's theorem on lattice classes runs on. **The Tamagawa volume
theorem for `SO` is a separate global theorem**, with no isotropy hypothesis, and it is the input
to the mass formula of positive definite genera. Neither is a corollary of the other, no proof
here derives one from the other, and no ordering statement below puts one after the other.

**Scope exclusions** (choices, not omissions; each names its owner). **Reductive group schemes**,
representability, root data and the classification of reductive groups belong to the [reductive
algebraic groups roadmap](../ReductiveGroups/README.md), and nothing here depends on it: this
roadmap works with point groups, explicit Clifford constructions and restricted products of
topological groups throughout. Layer 3 states the identification with the points of a general
affine group scheme as a milestone, so the boundary is a theorem someone can prove rather than an
unspoken gap. **The Clifford algebra, the Pin and Spin groups, the orthogonal group of a quadratic
form and the low-rank exceptional isomorphisms** belong to the [spin representations
roadmap](../RepresentationTheory/SpinRepresentations/README.md) and are consumed here by name, not
rebuilt. **Reflections, Cartan–Dieudonné, Witt decomposition, Witt cancellation, Witt's extension
theorem, square classes, Hasse invariants, the Hilbert symbol and the classification of forms over
local fields** belong to the [quadratic form invariants
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/4). **Lattice stabilizers and their
arithmetic**, isometry classes, genera, spinor genera, Eichler's theorem for lattice classes,
local densities and the mass formula belong to the [integral lattices
roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7); Layer 3 constructs the `ℤ`-span of a
chosen basis, and nothing more, so that the diagonal embedding of rational points has a
compact-open family to be stated against, and it proves no arithmetic about that span.
**Characteristic two** is excluded: every field here has `2` invertible, and the Dickson invariant,
which is what defines `SO` correctly in characteristic two, is not developed. **The connected
components of the real orthogonal groups**, their maximal compacts and their symmetric spaces are
not targets; Layer 2 proves exactly the two topological facts the later layers consume.
**Automorphic representations, the Weil representation and Siegel–Weil** are outside: Layer 5
proves its volume theorem by the adelic route, not by the theta-and-Eisenstein-series route.
**Tamagawa theory for general algebraic groups**, convergence factors for arbitrary reductive
groups and the Weil conjecture in its general form are outside; Layer 5 normalizes measures for
the orthogonal and spin groups of a quadratic space concretely. **Hermitian and unitary groups**,
forms over division algebras, and orthogonal groups of forms over rings of integers of number
fields are a natural extension nobody is asking for here; the places where a proof is generic in
the base field are flagged so a later development can reuse them.

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
- **⚠ The reflection formula.** For `v` with `Q v ≠ 0`,

      τ_v (x) = x - (B x v / Q v) • v,

  **not** `x - (2 · B x v / B v v) • v`. The second is what a half-polar source writes, and
  transcribing it against Mathlib's `polar` gives `τ_v v = -3v`. The form above is the quadratic
  form invariants roadmap's, and it is also exactly what Mathlib's `Module.reflection` wants:
  that takes `f : V →ₗ[K] K` and `x : V` with `f x = 2` and returns `y ↦ y - f y • x`, and
  `f := (Q v)⁻¹ • polarBilin Q v` has `f v = B v v / Q v = 2` on the nose.
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
  with, one reflection at a time. ⚠ Sources differ by a sign in the Clifford norm, and since
  `[−1]` is a square class in its own right, a formula that is right up to sign is not right; the
  sign is pinned in Layer 1 against Mathlib's `reverse` and `star_ι`.
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

Checked at the roadmap pin `9caeba1000` (2026-06-03), and the 19 commits touching these
directories between the pin and master on 2026-08-07 were read: all are refactors or chores except
`#42134` (`IsApply` for `QuadraticMap`) and `#40535` (notation for adele rings), and none of them
adds anything named below as missing. `#37381` deprecates `IsOrtho` on sesquilinear forms and
`#40451` rewrites the definitional guts of `CliffordAlgebra` from `RingQuot` to `RingCon.Quotient`;
both want re-checking at the next toolchain bump.

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
  `QuadraticForm.sigPos` does not exist. Re-check at the next bump.
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
  roadmap states surjectivity of the double cover over ℂ and identifies the general-field
  obstruction as the spinor norm without developing it. **This roadmap develops it**, over the
  fields the arithmetic needs, and adds the theory of `O(Q)` that the representation theory has no
  reason to prove: the determinant, base change, and the bilinear dictionary.
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
- **`TauCeti/FieldTheory/SquareClassGroup.lean`** (landed): `TauCeti.SquareClassGroup` as a
  `ZMod 2`-vector space with `squareClass` and its characterizations, which is the spinor norm's
  codomain.
- **`TauCeti/LinearAlgebra/OrthogonalGroup.lean`** (landed):
  `orthogonalGroupToLinearIsometryEquiv`, the Euclidean orthogonal group as linear isometries.
  Layer 0's comparison for a positive definite real form lands next to it, and Layer 2's
  compactness statement at the real place uses it.
- **The [integral lattices roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/7)** is the
  consumer, not a dependency. It takes four interfaces, named here so the two documents can be
  checked against each other: the spinor norm on `O(V_p)` with `Spin → SO` and its image (Layers 1
  and 2), finite adelic restricted products of the three point groups (Layer 3), strong
  approximation for `Spin(V)` with `V` indefinite of dimension at least 3 (Layer 4), and canonical
  local Haar measures with `vol(SO(V)(ℚ) \ SO(V)(𝔸)) = 2` (Layer 5).

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
| Hilbert reciprocity `∏_v (a,b)_v = 1` over ℚ | Global Class Field Theory, Layer 11 | Layer 5 |

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

The objects are the spin representations roadmap's `orthogonalGroup Q` and
`specialOrthogonalGroup Q`, and the reflections are the quadratic form invariants roadmap's. This
layer proves what neither states.

**0A. The determinant.** `det : O(Q) →* Kˣ`, the restriction of `LinearEquiv.det`. For
nondegenerate `Q`, `(det g)² = 1`, proved from the Gram congruence `Mᵀ G M = G` and `det G ≠ 0`,
so the determinant lands in `μ₂` and `SO(Q) = ker det` has index dividing 2. For nondegenerate `Q`
with `dim V ≥ 1` the index is exactly 2, since such a form has an anisotropic vector and hence an
improper reflection. Dimension 0 is stated separately: both groups are trivial, and no statement
below silently assumes `dim V ≥ 1`.

**0B. Functoriality and base change.** An isometry `Q ≃qᵢ Q'` induces `O(Q) ≃* O(Q')`, so `O` is an
invariant of `QuadraticMap.Equivalent`; a field extension `K → L` induces an injective
`O(Q) →* O(Q ⊗ L)`, compatible with composition of extensions; an orthogonal direct sum gives
`O(Q₁) × O(Q₂) ↪ O(Q₁ ⊞ Q₂)`, with the obstruction to equality identified. Each carries its
determinant compatibility, so the same statements hold for `SO`. This is the machinery every later
layer localizes with.

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
than a private definition. What that roadmap does not state, and Layer 1 needs: `det τ_v = -1`
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

### Layer 1: the spinor norm and the Clifford comparison

The Pin and Spin groups, the maps `pinToOrthogonal` and `spinToSpecialOrthogonal`, and the kernel
`{±1}` are the spin representations roadmap's. This layer builds the spinor norm, which nobody
has, and identifies the image of the double cover over a general field, which that roadmap
explicitly leaves open.

**1A. The Clifford norm.** `pinGroup Q` is already defined as an intersection with `unitary`, so
membership encodes `reverse (involute x) * x = 1`; the Clifford norm is the same expression read
on the whole Lipschitz group. Milestones: `N g := reverse g * g` is a scalar for `g` in
`lipschitzGroup Q`, giving a homomorphism `N : lipschitzGroup Q →* Kˣ`; multiplicativity, from
`reverse` being an anti-automorphism; `N (λ • g) = λ² · N g`; and the value on a vector,
`N (ι v) = ± Q v`, with the sign pinned by unfolding `star_ι : star (ι Q m) = -ι Q m` and stated
once. `[N (ι v)] = [Q v]` in `Kˣ/(Kˣ)²` for either sign, so the spinor norm does not see the
sign, but the integral normalizations of Layer 5 do; that is why it is pinned rather than absorbed.

**1B. The vector representation, over a general field.** Twisted conjugation gives
`lipschitzGroup Q →* O(Q)`, using Mathlib's `conjAct_smul_range_ι` and
`involute_act_ι_mem_range_ι` together with the spin representations roadmap's `ιRangeEquiv`, and
proving the resulting linear map is an isometry. An anisotropic `v` acts as `τ_v` exactly, with no
sign, which is the twisted-conjugation convention paying for itself. With Cartan–Dieudonné the
homomorphism is **surjective**, and **its kernel is exactly the nonzero scalars**. ⚠ That kernel
statement is the linchpin of the layer and it is not a formality: the classical proof computes the
centre of `CliffordAlgebra Q` for nondegenerate `Q`, which is `K` in even dimension and `K ⊕ K·ω`
in odd dimension for `ω` the product of an orthogonal basis, while the graded centre is `K` in
both parities. It is stated here as its own theorem, cited from the spin representations roadmap's
structure theorem if that supplies it and proved here otherwise, and either way it is the item to
expect to spend the longest on in Layers 0 to 3. Determinant one for the Spin action follows from
the even grading and 0F.

**1C. The spinor norm.** `θ : O(Q) → Kˣ/(Kˣ)²` by `θ(τ_{v₁} ⬝⬝⬝ τ_{v_r}) = [Q v₁ ⬝⬝⬝ Q v_r]`.
**Well-definedness is the milestone**: two reflection factorizations of the same `g` lift to
Lipschitz elements with the same image under 1B, so by the kernel theorem they differ by a scalar
`λ`, and `N (λ • x) = λ² N x`, so the two products of norms agree modulo squares. Then `θ` is a
group homomorphism; `θ(τ_v) = [Q v]`; `θ` is invariant under `QuadraticMap.Equivalent` (through
`CliffordAlgebra.equivOfIsometry`) and compatible with field extension; its restriction to `SO(Q)`,
which is the one the arithmetic uses; and its behaviour on an orthogonal direct sum. Defining `θ`
through reflections rather than as a quotient by the image of `Spin` is what makes it computable
on a lattice stabilizer, one reflection at a time.

**1D. The comparison sequence.** Assemble

    1 → μ₂(K) → Spin(Q)(K) → SO(Q)(K) → Kˣ/(Kˣ)²

with each map named and each claim of exactness proved at `K`-points rather than asserted: the
kernel of `Spin(Q)(K) → SO(Q)(K)` is `μ₂(K)`, and the image is exactly the kernel of `θ` restricted
to `SO(Q)`, which is the **spinor kernel** and is the object the integral lattices roadmap's spinor
genera are built from. ⚠ The last map is not surjective in general, so this is not a short exact
sequence and is never written as one. The hypotheses under which `θ : SO(Q)(K) → Kˣ/(Kˣ)²` is onto
are stated separately here and proved in Layer 2 for the local fields where they hold.

**1E. Low rank, arithmetically.** The exceptional isomorphisms are the spin representations
roadmap's Layer 6. This layer states only the arithmetic instances Layers 4 and 5 consume, and
coordinates rather than duplicating: for a nondegenerate ternary `Q` over a number field or a
local field, `Spin(Q)` is the norm-one group of the even Clifford algebra, which is a quaternion
algebra, and `SO(Q)` is its unit group modulo centre; for a quaternary `Q` the even Clifford
algebra is a quaternion algebra over the discriminant étale quadratic algebra, so `Spin(Q)`
acquires two rank-one factors and is **not almost simple**. The second statement is load-bearing
twice: it is a base case of Layer 5E, and it is what gives the dimension-4 hypothesis of Layer 4
content. The ternary case is also the dictionary quaternionic arithmetic runs on, which is why it
is stated over a general field and not only over ℚ.

### Layer 2: local point groups and their topology

`K` is `ℝ` or `ℚ_p` throughout, and each statement is proved uniformly in the local field where the
proof is uniform, so that a later development over a general local field can reuse it.

**2A. Topological groups.** `O(Q)(K)` is a topological group in the subspace topology from
`Module.End K V ≅ K^{n²}`, and is closed there, being cut out by polynomial equations. The
topology goes on the subgroup of `V ≃ₗ[K] V` directly and not through `Matrix.orthogonalGroup`,
which carries no topology instance at the pin and is not known compact. `SO(Q)(K)` is closed and
also open in `O(Q)(K)`, since the determinant is continuous with discrete image.
`Spin(Q)(K)` is a topological group in the topology induced from the Clifford algebra, and the
vector representation `Spin(Q)(K) → SO(Q)(K)` is continuous. Continuity of the determinant, of the
Spin action, and of the spinor norm, the last using that `(Kˣ)²` is open so that `Kˣ/(Kˣ)²` is
discrete: over ℝ that is elementary, and over `ℚ_p` it is the local fields roadmap's
`U(K, 2e+1) ⊆ (Kˣ)²` together with openness of the unit filtration. Local compactness of all three
groups, which is what Layer 3's restricted product needs.

**2B. ⚠ Compactness, stated sharply.** `O(Q)(ℝ)` is compact if and only if `Q` is definite, and
`O(Q)(ℚ_p)` is compact if and only if `Q` is anisotropic over `ℚ_p`. Both directions: an isotropic
vector generates an unbounded one-parameter family of isometries (the Eichler transvections of
Layer 4, already useful here), and conversely a definite or anisotropic form bounds the matrix
entries of an isometry. The same statements for `SO`, and for `Spin` through the vector
representation and its finite kernel. These give the "noncompact at some place" hypothesis of Layer
4 its content, and they decide which genera Layer 5's volume theorem says something interesting
about.

**2C. Local spinor norms.** The image of `θ` on `O(V_p)` and on `SO(V_p)`, computed from the
classification of forms over `ℚ_p` supplied by the quadratic form invariants roadmap: for
`dim V ≥ 3`, `θ(SO(V_p)) = ℚ_p^×/(ℚ_p^×)²`, with the low-dimensional cases stated with their
exceptions rather than excluded. The local spinor kernel, that is the image of
`Spin(V_p) → SO(V_p)`, is identified as `ker θ|_{SO(V_p)}` and its index computed. These are
precisely the statements the integral lattices roadmap's Layer 4C needs before it can compute
`θ_p(K_p⁺(L))` from Jordan data.

**2D. The real place.** `θ(SO(V_ℝ))` is trivial when `Q` is definite and all of `ℝˣ/(ℝˣ)²` when `Q`
is indefinite; `Spin(V_ℝ)` is compact exactly when `Q` is definite. That is everything the later
layers use from the real place. The connected-component theory of `O(p,q)` is not developed, and
the exclusions paragraph says so.

**2E. Localization of factorizations.** A reflection factorization over ℚ base changes to one over
`ℚ_v` at every place, `θ` commutes with the base-change maps `O(V) → O(V_v)` of 0B, and the diagram
relating the global and local spinor norms commutes. This is small, and it is what makes the adelic
spinor norm of Layer 3 agree with the rational one on diagonal elements.

### Layer 3: finite adelic point groups

**3A. The generic restricted product.** For a family of locally compact topological groups `G_i`
with chosen compact open subgroups `K_i`, build on Mathlib's `RestrictedProduct` the API the adelic
theory needs: the evaluation homomorphisms, continuous and surjective; the inclusion of `∏ K_i`
with openness and compactness (`isOpenEmbedding_structureMap` supplies the first); local
compactness of the whole, from `locallyCompactSpace_of_group`; functoriality along a family of
continuous homomorphisms `G_i → H_i` carrying `K_i` into `L_i`; and the compatibility of all of it
with finite products and with restriction to a cofinite subset of the index set.

⚠ One item is not plumbing. Mathlib's `RestrictedProduct` has **no congruence API**: `mapAlong` and
its monoid- and ring-hom versions are one-directional, and there is no `MulEquiv` or `Homeomorph`
induced by componentwise equivalences. So **the comparison of the restricted products for two
families `K_i` and `K'_i` agreeing at all but finitely many `i`, as an isomorphism of topological
groups, has to be proved here.** It is the most-used lemma of the layer and the thing a consumer
needs in order to substitute its own compact opens, so it is named as its own milestone rather than
assumed. This subsection is about topological groups only and belongs in a general namespace.

**3B. Orthogonal, special orthogonal and spin adelic groups.** For a nondegenerate quadratic space
`V` over ℚ and a family of compact open subgroups `U_p ≤ O(V_p)` **as a parameter**, the groups
`O(V)(𝔸_f)`, `SO(V)(𝔸_f)` and `Spin(V)(𝔸_f)` as the corresponding restricted products with their
topologies; the componentwise maps `Spin(V)(𝔸_f) → SO(V)(𝔸_f) → O(V)(𝔸_f)` from 3A's
functoriality; and the adelic spinor norm, valued in the restricted product of the local
square-class groups. Everything is stated for the parametrized family, so that the integral
lattices roadmap instantiates it with lattice stabilizers and inherits the whole API.

**3C. ⚠ The diagonal embedding, and what it needs.** The map `O(V)(ℚ) → O(V)(𝔸_f)` is well defined
only once one knows that a given rational isometry lies in `U_p` for all but finitely many `p`,
and that is a theorem, not a formality. Both forms are milestones:

1. **Relative.** For a family `U_p` satisfying "every element of `O(V)(ℚ)` lies in `U_p` for almost
   all `p`", carried as an explicit hypothesis, the diagonal map is a well-defined injective group
   homomorphism, and likewise for `SO` and `Spin`. This is the form a consumer uses, and the
   integral lattices roadmap discharges the hypothesis for its lattice stabilizers.
2. **Absolute.** The hypothesis holds for the family of stabilizers of the `ℤ`-span of a chosen
   basis of `V`, proved by clearing denominators in the matrix of a rational isometry and in the
   matrix of its inverse. This construction exists so that the roadmap's own objects rest on
   something rather than on a hypothesis nobody discharges; it develops no arithmetic of that
   `ℤ`-span, which is the integral lattices roadmap's subject.

With the embedding: the diagonal image is discrete; the adelic spinor norm agrees with the rational
one on diagonal elements, by 2E; and the double coset set `G(ℚ) \ G(𝔸_f) / U` is defined, with the
change-of-`U` comparison map from 3A's congruence milestone and the functoriality in `G`.
Finiteness of that set is not claimed here in general.

**3D. Interoperability with affine group schemes.** A milestone, not a prerequisite: the statement
that the point groups built here agree with the points of the corresponding affine group scheme,
for whatever formulation of affine group schemes exists when someone wants the identification.
Nothing in Layers 0 to 5 depends on it, and it is listed so that the boundary with the reductive
groups roadmap is a theorem somebody can prove rather than an unspoken gap.

### Layer 4: strong approximation for Spin

This layer proves one theorem and the reductions it needs. It is an **indefinite** theorem,
requiring a place at which the group is noncompact, and it is what Eichler's theorem on lattice
classes runs on. Layer 5 does not use it.

**4A. Eichler transvections.** For an isotropic vector `u` and a vector `w` orthogonal to `u`, the
transvection `E_{u,w}(x) = x + B(x,u) w − B(x,w) u − Q(w) B(x,u) u` is a proper isometry of `Q`;
the composition law in `w`, making `w ↦ E_{u,w}` a homomorphism from the additive group of
`u^⊥ / K u` into `SO(Q)`; the spinor norm of a transvection is trivial, so transvections lie in the
spinor kernel and lift to `Spin`; and the conjugation law under `O(Q)`. These unipotent
one-parameter subgroups are the mechanism of the whole layer, and their triviality under `θ` is why
the theorem is about `Spin` and not `SO`.

**4B. The isotropic case.** For `V` containing a hyperbolic plane, the subgroup of `Spin(V)(𝔸^S)`
generated by the adelic points of the transvection subgroups is dense, which reduces approximation
to strong approximation for the additive group `𝔸` relative to ℚ, that is the Chinese remainder
theorem in adelic clothing. The additive statement being consumed is stated explicitly with its
source rather than gestured at.

**4C. The general case.** Reduction of the anisotropic case to 4B, by base change to a field where
the form becomes isotropic together with a descent, or by the classical dimension induction. Name
the reduction being formalized; "and similarly in general" is not a milestone.

**4D. The theorem.** Let `V` be a nondegenerate quadratic space over ℚ with `dim V ≥ 3`, and let `S`
be a finite nonempty set of places of ℚ such that every almost-simple factor of `Spin(V)` is
noncompact at some place of `S`. Then the diagonal image of `Spin(V)(ℚ)` is dense in
`Spin(V)(𝔸^S)`; equivalently, `Spin(V)(𝔸^S) = Spin(V)(ℚ) · U` for every compact open subgroup `U`
of `Spin(V)(𝔸^S)`. The equivalence of the two forms is proved, not asserted. The corollary the
lattice side uses is stated separately: for `S = {∞}` and `V` indefinite,
`Spin(V)(𝔸_f) = Spin(V)(ℚ) · U` for every compact open `U ≤ Spin(V)(𝔸_f)`.

Three hypotheses carry their own statements, and none is a footnote:

- ⚠ **Dimension 4.** `Spin(V)` is not almost simple there: by 1E it acquires two rank-one factors
  over the discriminant quadratic algebra. The noncompactness hypothesis is a condition on both
  factors and is **not** implied by noncompactness of `Spin(V)(ℝ)`. The dimension-4 case is stated
  explicitly, with the condition in terms of the discriminant algebra.
- ⚠ **Dimension 2 is excluded.** `Spin(V)` is a one-dimensional torus there and strong
  approximation is false, so `dim V ≥ 3` is a hypothesis of the theorem and not a convenience. The
  binary theory is the integral lattices roadmap's, handled through quadratic orders and their
  class groups, and nothing here is proved about it.
- ⚠ **`SO` does not satisfy strong approximation.** The image of a dense set is dense, so the
  theorem transports along `Spin → SO` to give density of the image of `Spin(V)(ℚ)`, which is
  strictly weaker than density of `SO(V)(ℚ)`. The gap is measured exactly by the spinor norm, and
  that is why spinor genera exist. Both the correct transported statement and the reason the naive
  one fails are stated.

### Layer 5: Haar normalization and the orthogonal Tamagawa theorem

⚠ This layer is independent of Layer 4. Strong approximation is an indefinite statement about
`Spin` used for class numbers; the volume theorem here has no isotropy hypothesis and is what the
mass formula of positive definite genera consumes. No proof here uses Layer 4, and the integral
lattices roadmap consumes the two separately. Nor does any proof here consume the mass formula: the
implication runs from the volume theorem to the mass formula and not back, and the analytic route
to the mass formula is outside both roadmaps.

**5A. Canonical local measures.** A Haar measure on `SO(V_v)` at every place, normalized
intrinsically from the quadratic space rather than from a chosen basis or lattice. Existence comes
from Mathlib's `haarMeasure`, which needs only local compactness (2A), and uniqueness up to a
scalar from `haarScalarFactor`. Required beside them: the proof that the chosen normalization is
invariant under isometry of quadratic spaces, which is what makes it canonical; **unimodularity
of `SO(V_v)`**, stated explicitly as left-invariance together with right-invariance, since Mathlib
has no `IsUnimodular` class and the quotient API of 5C demands both; and the corresponding measures
on `O(V_v)` and `Spin(V_v)`, with the relation between them across the finite-index inclusion and
the finite-kernel covering.

**5B. Comparison with the lattice-relative normalization.** The volume of a compact open subgroup
in the canonical normalization, and the statement relating it to the normalization a local density
is computed against. The integral lattices roadmap's Layer 7C identifies its local densities with
canonical Haar volumes of stabilizers, and that identification is meaningful only if the
normalization here is pinned in a form it can quote. This is the interface, and it is stated for an
arbitrary compact open subgroup, not for a lattice.

**5C. The adelic measure and the covolume.** The product measure on `SO(V)(𝔸)`, with convergence of
the product of local volumes over the compact opens stated and proved; discreteness of the diagonal
`SO(V)(ℚ)` and the existence of a fundamental domain, which is what `covolume` needs to be anything
other than zero; and the covolume `vol(SO(V)(ℚ) \ SO(V)(𝔸))` through Mathlib's quotient-measure
API. ⚠ **Finiteness of the covolume is its own milestone and precedes any computation of it**: the
upstream `covolume` is `ℝ≥0∞`-valued and returns `0` when no fundamental domain exists, and
`haarMeasure_quotient` wants the subgroup countable and the quotient measure finite, so those
hypotheses are established here rather than assumed.

**5D. The comparison along `Spin → SO`.** The canonical measures on `Spin(V)(𝔸)` and `SO(V)(𝔸)`
correspond under the covering map, with the contribution of the central kernel `μ₂` computed
exactly, and the resulting relation between the two covolumes. Then the arithmetic: the local
spinor-norm quotients of 2C, the global square-class quotient, and the index measuring the failure
of `SO(V)(ℚ)` to be covered by `Spin`. The global input is Hilbert reciprocity `∏_v (a,b)_v = 1`
over ℚ, consumed from the global class field theory roadmap, which is what makes the global
quotient computable from the local ones.

**5E. The Tamagawa number of `Spin`.** `τ(Spin(V)) = 1` for a nondegenerate quadratic space `V`
over ℚ of dimension at least 3. This is Weil's theorem for a simply connected group and it is the
deepest single statement in this roadmap, so it is decomposed rather than hedged: the
low-dimensional cases through 1E, where the statement becomes the Tamagawa number of the norm-one
group of a quaternion algebra, of a product of two such, of a symplectic group in four variables,
or of a special linear group in four variables over an étale quadratic algebra, each with a
classical proof by reduction theory; and the general case by the induction on dimension that Weil's
argument runs, whose steps, the fibration over the isotropic vectors, the treatment of the
anisotropic kernel, and the convergence of the resulting integrals, are the named sub-items.

**5F. The theorem.** For `V` a nondegenerate quadratic space over ℚ in the stated dimension range,
the canonically normalized covolume of `SO(V)(ℚ)` in `SO(V)(𝔸)` is `2`, derived from 5E by the
computation of 5D. Every dimension restriction and low-dimensional exception is part of the
statement: in dimension at most 1 the value is 1, not 2, which is the guard the integral lattices
roadmap's Conway–Sloane normalization records in its own low-rank branch, and the two documents
state the same exceptions. The statement is recorded with its normalization attached, since a
covolume without a normalization is not a number.

## Worked examples (acceptance criteria)

Discharge these alongside their layers. Each catches a vacuous definition, a wrong sign, or a
convention drift.

- `Q = x²` in dimension 1: `O(Q) = {±1}`, `SO(Q)` trivial, and `−1` is the reflection `τ_v` in any
  `v ≠ 0`, with `θ(−1) = [1]` (Layers 0, 1).
- The reflection formula against a worked Gram matrix: for `Q = x² + y²` and `v = (1,0)`,
  `τ_v(x, y) = (−x, y)`, computed from the pinned formula. This is the acceptance check for the
  factor-of-2 warning in the conventions table (Layer 0D).
- The hyperbolic plane over any `K`: `SO(Q) ≅ Kˣ` through the diagonal torus, and `θ` on that torus
  is the square class of the parameter, so `θ : SO(Q) → Kˣ/(Kˣ)²` is onto with kernel the squares.
  This is the smallest example where the comparison sequence of 1D fails to be exact on the right,
  and it is the acceptance check for the warning attached to that milestone (Layers 0, 1).
- The sum of three squares over ℚ: `Spin(Q)` is the norm-one group of the Hamilton quaternions,
  `SO(Q)` its quotient by `±1`, and the vector representation is the classical rotation action
  (Layer 1E).
- `O(Q)(ℝ)` for a definite `Q` is compact and agrees with the Euclidean orthogonal group of
  `TauCeti/LinearAlgebra/OrthogonalGroup.lean`; for `Q = x² − y²` it is not compact, exhibited by an
  explicit unbounded one-parameter family (Layers 0B, 2B).
- A rational isometry lies in the stabilizer of the standard `ℤ`-span at all but finitely many
  primes, exhibited for one explicit non-integral rational isometry. This is the acceptance check
  for 3C (Layer 3).
- Two compact-open families differing at one prime give isomorphic restricted products, checked
  explicitly, which is the acceptance check for the congruence milestone of 3A (Layer 3).
- Dimension 4: an explicit quaternary form whose `Spin` has a compact factor at every finite place
  while `Spin(V)(ℝ)` is noncompact, so that the naive reading of the strong-approximation
  hypothesis fails and the corrected one is visible (Layer 4D).

## Ordering and parallelism

Layer 0 rests on the two sibling roadmaps that own its objects, and within it 0A to 0D are
independent of each other while 0E and 0F follow 0D. Layer 1 needs Cartan–Dieudonné from the
quadratic form invariants roadmap and 0D to 0F from here. Inside Layer 1 the order is forced: 1B is
the prerequisite for 1C and 1D, while 1A is independent of 1B and can be built alongside it, and 1E
depends on 1B alone, so it can be built in parallel with the spinor norm.

Layer 2 needs Layers 0 and 1 together with the local classification. **Layer 3's generic
restricted-product API, 3A, depends on nothing else in this roadmap at all**, and is the best
independent starting point for a contributor who would rather do topology than quadratic forms;
3B and 3C then need Layer 2.

Layers 4 and 5 both consume Layer 3 and neither consumes the other, which is the second
load-bearing distinction made structural. Within Layer 5, 5A and 5B need only Layer 2 and can start
early; 5C needs 3B; 5D needs 5C, 2C and the global class field theory roadmap; and 5E is the long
pole, whose low-dimensional cases need only 1E and can begin as soon as that is done.

The shortest route to something the integral lattices roadmap can use is `0 → 1 → 2`, which
supplies its spinor-norm interface; the shortest route to its adelic interface is `0 → 1 → 2 → 3`.

## References

- E. Artin, *Geometric Algebra*, Interscience (1957). Chapter III for reflections, the transitivity
  computation of 0E, and Cartan–Dieudonné with its sharp bound.
- O. T. O'Meara, *Introduction to Quadratic Forms*, Grundlehren 117, Springer (1963; corrected
  1973), PRIMARY. §43 the orthogonal group and reflections; §55 the spinor norm, its
  well-definedness and the local computations of 2C; §101 the adelic setting; 104:4 strong
  approximation for the spin group, which is 4D. His Hasse symbol convention is `∏_{i≤j}`,
  translated per the quadratic form invariants roadmap's convention table. (104:5, Eichler's
  theorem for lattice classes, is the integral lattices roadmap's, not this one's.)
- C. Chevalley, *The Algebraic Theory of Spinors*, Columbia (1954); reprinted in *Collected Works*
  vol. 2, Springer (1997). The Clifford-theoretic development of Layer 1: the Lipschitz group, the
  vector representation, the centre computation behind 1B, and the Clifford norm of 1A.
- N. Bourbaki, *Algèbre*, Chapitre 9, *Formes sesquilinéaires et formes quadratiques*, Hermann
  (1959). The reference presentation of Clifford algebras, the Lipschitz group and the spinor norm,
  in the conventions closest to Mathlib's.
- M.-A. Knus, *Quadratic and Hermitian Forms over Rings*, Grundlehren 294, Springer (1991). Chapter
  IV for the Clifford algebra, its centre and the Pin and Spin groups, in the generality that makes
  the base-change statements of Layers 0 and 1 come out uniformly.
- W. Scharlau, *Quadratic and Hermitian Forms*, Grundlehren 270, Springer (1985). Chapter 9 for the
  spinor norm and the Clifford invariant with the sign conventions stated explicitly, which is what
  1A's pinned sign is checked against.
- T. Y. Lam, *Introduction to Quadratic Forms over Fields*, GSM 67, AMS (2005). The field-level
  background in the conventions the quadratic form invariants roadmap adopts: Chapter I for
  reflections (I.7), Witt theory and the extension theorem (I.4.9).
- M. Eichler, *Quadratische Formen und orthogonale Gruppen*, Grundlehren 63, Springer (1952; 2nd
  ed. 1974). The origin of the transvections of 4A and of the approximation argument.
- M. Kneser, *Quadratische Formen* (revised with R. Scharlau), Springer (2002). Strong
  approximation and the spinor-genus apparatus in the form Layer 4 states.
- V. Platonov, A. Rapinchuk, *Algebraic Groups and Number Theory*, Academic Press (1994). Chapter 5
  for adelic groups and Tamagawa numbers, Chapter 7 for strong approximation. The reference for the
  shape of 4D's hypotheses, including the almost-simple-factor condition that dimension 4 makes
  nontrivial.
- A. Weil, *Adeles and Algebraic Groups*, Progress in Mathematics 23, Birkhäuser (1982). The
  Tamagawa measure and the theorem `τ(Spin) = 1` that 5E targets, with the induction whose steps 5E
  decomposes.
- J. G. M. Mars, *Les nombres de Tamagawa de certains groupes algébriques*, Séminaire Bourbaki exp.
  351 (1968/69). The orthogonal and spin Tamagawa numbers surveyed, with the derivation of
  `τ(SO) = 2` from `τ(Spin) = 1` that 5D formalizes.
- J. W. S. Cassels, A. Fröhlich (eds.), *Algebraic Number Theory*, Academic Press (1967). The
  adelic background of Layers 3 and 5.
- J.-P. Serre, *A Course in Arithmetic*, GTM 7, Springer (1973), Chapter IV. The local and global
  square-class background in the form the sibling roadmaps use.
