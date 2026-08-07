# Provenance and coordination

Non-normative. `README.md` is the roadmap and the only document a contributor is held to; this
file carries the dated and revisable material that would otherwise make the roadmap untimeless:
the Mathlib pin and when it was inspected, the upstream pull requests being tracked, the
re-check-at-the-next-bump notes, and the coordination obligations with sibling roadmaps.

## Mathlib

Pin `9caeba1000ef8f302920981f4a08651d325abc81` (2026-06-03), as recorded in `lake-manifest.json`.
Toolchain `leanprover/lean4:v4.31.0-rc1`. Licence Apache-2.0.

The capability statements in `README.md`'s "What Mathlib already has" section were verified
against that pin on 2026-08-07 by reading the source, and the commits touching the four relevant
directories between the pin and master on that date were read as well. Those directories are
`LinearAlgebra/CliffordAlgebra/`, `Topology/Algebra/RestrictedProduct/`,
`LinearAlgebra/QuadraticForm/` and `NumberTheory/NumberField/AdeleRing.lean`, and the window
contains 19 commits. All are refactors or chores except `#42134` (`IsApply` for `QuadraticMap`)
and `#40535` (notation for adele rings), and none of them adds anything the roadmap names as
missing.

Two want re-checking at the next toolchain bump, because they move ground the roadmap stands on
without changing what is available:

- `#37381` deprecates `IsOrtho` and its lemmas on sesquilinear forms.
- `#40451` rewrites the definitional guts of `CliffordAlgebra` from `RingQuot` to
  `RingCon.Quotient`.

Three names in the roadmap are in the **root** namespace rather than where their file's
documentation suggests, which is a recurring source of `unknown identifier` errors and is worth
re-checking whenever the pin moves: `lipschitzGroup`, `pinGroup` and `spinGroup` are not under
`CliffordAlgebra`, and `sigPos` and `sigNeg` are not under `QuadraticForm`.

Mathlib owns its API decisions. Where this roadmap names an object the way an open Mathlib pull
request does, the intent is that adopting the upstream version later is a deletion and an import
rather than a rewrite. Nothing here is held back for upstream, and nothing here is waiting on it.

## Sibling roadmaps, and what is owed

- **Spin Representations** (accepted, `TauCetiRoadmap/RepresentationTheory/SpinRepresentations/`).
  Supplies `orthogonalGroup`, `specialOrthogonalGroup`, `ιRangeEquiv`, `pinToOrthogonal`,
  `spinToSpecialOrthogonal`, the double-cover kernel, the Clifford structure theorem over an
  algebraically closed field, and the low-rank exceptional isomorphisms over an algebraically
  closed field. **Owed there:** an edit recording that the general-field spinor-norm image theorem
  is `OrthogonalSpinGroups`', so that the two documents do not both claim it. Its Layer 2 currently
  says the general-field result should be stated as the spinor-norm exact sequence, while its
  standing conventions say "if at all"; either way the ownership sentence belongs there and the
  theorem belongs here.
- **Quadratic Form Invariants.** Supplies reflections, Cartan–Dieudonné, Witt theory, orthogonal
  bases, the square-class calculus with its multiplicative avatar, and the local classification.
  Its reflection formula and this roadmap's agree exactly.
- **Local Fields.** Supplies local compactness and the power-class cardinality formula. It does not
  state openness of `(Kˣ)²` on its own; its instance `U(K, 2e+1) ⊆ (Kˣ)²` supplies it, and Layer 2E
  cites it in that form.
- **Global Class Field Theory.** Supplies Hilbert reciprocity, consumed by Layer 5H alone.
- **Reductive Groups** (accepted). Supplies the functor of points and the structure theory that
  Layer 3A specializes. **Owed there, if its accepted text does not already expose them:** the
  point-functor, semisimplicity, simple-connectedness and central-isogeny interfaces Layer 3A names.
  Where it does not, Layer 3A owns the specialized versions for `O_Q`, `SO_Q` and `Spin_Q`.
- **Integral Lattices.** The consumer. **Owed there:** its dependency table should gain a row for
  Layer 0C, the identification of the automorphism group of a symmetric bilinear form with that of
  its quadratic form, which is what places its bilinear-first `O(L)` inside the quadratic-form
  group `O(V_p)` its `K_p(L)` is defined in; and its consume bullet should attribute `O(Q)`,
  `SO(Q)` and the `Spin → SO` map to Spin Representations and Cartan–Dieudonné to Quadratic Form
  Invariants, rather than to this roadmap.

## Merge order

The quadratic form invariants, local fields and global class field theory roadmaps are cited by
pull-request link rather than by relative path, because they are not yet accepted and a relative
link to a file that does not exist would not resolve. When each is accepted, its citation here
becomes a relative link and the exact consumed declarations replace the layer references. This
roadmap is not gap-free until those three are accepted, and that is a merge-order obligation rather
than a defect in the specification.

## The general Tamagawa machinery

Layer 5A to 5E is general Tamagawa theory for connected linear algebraic groups and is deliberately
written to be independent of quadratic forms. It is kept in this roadmap so that Layer 5I rests on
stated targets rather than on an assumed future document. Lifting it into a roadmap of its own is a
clean follow-up and would need no mathematical rewriting: Layer 5F to 5I would then cite it, and
this roadmap would keep only the orthogonal specialization.
