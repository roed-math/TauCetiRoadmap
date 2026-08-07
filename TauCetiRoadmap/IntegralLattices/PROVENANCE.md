# Provenance and coordination

This file is not part of the specification. `README.md` is the roadmap. Nothing recorded
here is a prerequisite for a milestone. This file holds information that changes with
time: which Mathlib version the roadmap was checked against, which external work overlaps
it, and which upstream data model it serves. Each entry carries the date it was checked.

## Mathlib version checked

Checked on 2026-08-07 against the Mathlib release `v4.32.2` (2026-07-28).

Method: the release source tree was indexed by declaration name, and every declaration
that `README.md` and `Suggested.lean` cite was looked up in that index.

Results:

- Every cited declaration exists, in the file the roadmap names, with one path change:
  `Mathlib/Data/Matrix/Cartan.lean` is now a deprecated module that re-exports
  `Mathlib/LinearAlgebra/Matrix/Cartan.lean`. The roadmap cites the new path.
- `sigPos` and `sigNeg` are still in the root namespace, although the file documents them
  as `QuadraticForm.sigPos`. The convention table records this.
- `QuadraticMap.associated` now carries `[Invertible (2 : Module.End R N)]` instead of
  `[Invertible (2 : R)]`. The new form is satisfied for `R = ℤ` and `N = ℝ`, and is not
  satisfied for `R = N = ℤ`, so the bilinear-first convention is unchanged.
- `QuadraticForm.toMatrix`, `QuadraticForm.discr` and `QuadraticForm.baseChange` still
  carry `[Invertible (2 : R)]`.
- `LinearMap.BilinForm.baseChange` carries no invertibility hypothesis.
- `IsZLattice` still takes a `Submodule ℤ E`.
- The searches `IsUnimodular`, `IntegralLattice`, `discriminantGroup` and `thetaSeries`
  return no declaration. Mathlib has no integral-lattice arithmetic.

## Open Mathlib work that touches the same material

None of these is a prerequisite. Each records an overlap and the decision it forces. The
roadmap builds what it needs and adopts a Mathlib design if that design lands.

| Mathlib pull request | Subject | Overlap and decision |
| --- | --- | --- |
| #35812 (open 2026-08-06) | successive minima, directional basis | Overlaps milestone 2F. The roadmap names its objects as this pull request does, so a later swap is an import. |
| #41867 (open 2026-07-24) | `ZLattice` generalized to `AddSubgroupClass` | Touches milestones 2D and 8A. The roadmap states its covolume use through `ZLattice.covolume`. |
| #42157 (open 2026-07-31) | generalized E-type Cartan matrices | Touches milestone 0G, which cites `CartanMatrix.E₈`. |
| #38194 (open 2026-07-18) | an `IndefiniteMetric` structure | No mathematical overlap. It uses naming space for indefinite forms. |
| #39460, #10345 (drafts) | `ZLattice` torus quotients, Voronoi domains | No current overlap. |
| #42134 (merged 2026-07-31) | `IsApply` for `QuadraticMap` | Merged after `v4.32.2`. It changes no cited statement. |

There are no open or 2026-merged Mathlib pull requests on unimodular or integral lattices,
discriminant groups, theta series of lattices, Witt rings, or Hermite normal form.

## External formalizations with overlapping content

No contact has been made with either project. Proposed ownership is a proposal only.

**thefundamentaltheor3m/Sphere-Packing-Lean**, revision
`bad3de916074748eb88b7d1ee6dbf9494361ad17` (2026-08-05), licence Apache-2.0, maintainers
C. Birkbeck, S. Hariharan, B. Mehta, Seewoo Lee, project paper arXiv:2604.23468.

- Overlap: an explicit `E₈` in `SpherePacking/Basic/E8.lean`, sorry-free, with the
  even-coordinate model `Submodule.E8`, the basis matrix `E8Matrix`, unimodularity,
  integrality, evenness, minimal norm `√2`, and covolume 1; a statement of Poisson
  summation for a `ZLattice` in `CohnElkies/Prereqs.lean`, still `sorry` in their main
  branch and proved in their open pull request #341.
- Proposal: their analytic `E₈` model stays theirs. The L-functions roadmap owns the
  shared Poisson and theta transformation. This roadmap owns the arithmetic invariants.
- Milestone 6F proves that the two `E₈` models defined inside this roadmap are isometric.
  It does not depend on their repository. If the two projects later agree to share one
  `E₈`, the same isometry proof applies to their model.
- Copying code from that repository requires the authors' agreement, and a licence review.

**math-inc/Sphere-Packing-Lean**, revision `1e98fb493088948ca7bbf47d7faed49cc5b39fc4`
(2026-03-02), licence Apache-2.0.

- Overlap: a dimension-24 development with an explicit Leech generator matrix, theta
  machinery (`thetaShell`, `thetaCoeff`), discriminant pairings, and an argument that a
  rootless Niemeier lattice is the Leech lattice. All of it is written for
  `EuclideanSpace ℝ (Fin 24)`.
- Proposal: cite as prior art. Milestone 6E defines its own rank-24 reference rows and
  proves their invariants. It claims no completeness theorem and no rootless uniqueness
  theorem, so it needs nothing from that repository.

## The LMFDB lattice section, as observed on 2026-08-07

The roadmap's milestone 3I states what the stored columns assert. The data model itself is
outside the roadmap and is recorded here.

- The section holds positive definite integral lattices. A large part comes from the
  Catalogue of Lattices.
- The label has five components: `dim.det.level.class_number.index`.
- Stored columns: the Gram matrix, the list of genus representatives, the minimum, the
  kissing number, the automorphism group order, the density, the Hermite invariant, and
  the first theta series coefficients.
- Conway–Sloane genus symbols are not stored. Genus data is stored as a list of Gram
  matrices, one per class.
- The fifth label component separates records that agree in the first four components. Its
  value follows from the order in which records were added. Milestone 3I gives it no
  mathematical meaning.

## Consumers

The LMFDB lattice section and the K3 surface pipeline motivated the layer boundaries. They
impose no convention beyond the Conway–Sloane genus symbols, which the convention table
fixes. The K3 pipeline uses milestones 5G to 5I, milestone 5E, and the mass certificates
of Layer 7.
