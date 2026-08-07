# Provenance for the pro-p and Demushkin groups roadmap

**This file is not normative.** `README.md` is the specification. Nothing here is a
prerequisite of a milestone, and no milestone waits for anything recorded here. This file
holds three kinds of information that go stale: the state of other projects, the state of
Mathlib work in progress, and the record of material that a contributor may adapt.

Each record states evidenced status on the date given. A missing revision, licence or
contact does not stand for permission.

## Mathlib work to watch

None of these is a prerequisite. If one lands with a compatible object, the roadmap keeps
its statements and gains a comparison isomorphism, or deletes a local definition.

- Continuous cohomology. The carrier the roadmap uses is
  `Mathlib/Algebra/Category/ContinuousCohomology/Basic.lean` (R. Hill, A. Yang), which is
  present at the repository pin with `continuousCohomology` in every degree and an explicit
  description in degree 0 only. A second line of work,
  `Mathlib/RepresentationTheory/Homological/ContCohomology/`, appears in release `v4.32.2`
  (R. Hill, A. Yang, E. Xie; PRs #41144 and #41309). Neither has explicit `H¹` or `H²` or a
  cup product; Layer 5 owns those and states the comparison. If the two lines are unified
  upstream, the comparison milestone is restated against the survivor.
- Cup products for continuous cohomology exist in the FLT staging repository
  (`FLT/Mathlib/.../ContCohomology/CupProduct.lean`, E. Xie, FLT#1098, 2026-07-10), and not
  in Mathlib.
- Mathlib #35603, Frattini extras for finite `p`-groups, including the elementary abelian
  Frattini quotient. That is the finite half of Layer 3.
- Mathlib #42200, `IsMulFG` unification (T. Browning), the substrate on which a
  Mathlib-native "topologically finitely generated" would sit.
- Mathlib #41961, the Iwasawa algebra of measures on profinite groups (D. Loeffler), and Jz
  Pan's `lean-iwasawa`. Both are adjacent to the completed group algebra of the Layer 9
  prerequisites.
- The `ProfiniteGrp` line: #16648, #16992, #16993, #20740, #34893 (completion, A. Topaz),
  #35540 (residual finiteness) and #39973 (additivization, T. Browning).

Audit performed on 2026-07-30 against Mathlib master `ccedd50412`, and repeated on
2026-08-07 against release `v4.32.2`: there is no pro-`p` predicate, no supernatural order
or index, no profinite Sylow theory, no topological finite generation, no pro-`p` Frattini
theory, no free profinite group, no profinite presentation, and no Demushkin theory. The
search for "Demushkin" returns no pull request in any state. The Zulip archive shows no one
building or claiming this material; the only pro-`p` design artifact there is a sketch of a
pro-`p` `GroupFilterBasis` in the December 2024 thread "Refactor `krullTopology`?", which
never landed.

## Migration source

`roed-math/gq2-lean`, revision `d0714a7c431b64e18c422fb16cb5e93d79e5be25`, Apache-2.0, same
repository owner, so there is no licensing obstacle. It contains working single-instance
implementations of parts of Layers 0, 3 to 5, and 7 and 8, against a June 2026 Mathlib. The
roadmap specifies the mathematics intrinsically; this map is for orientation, and none of
these files' choices, such as universe placements, `Nat.card` dimension encodings, or marked
generators, is prescriptive.

- `GQ2/ProfiniteQuotient.lean` → Layer 0, quotients by closed normal subgroups.
- `GQ2/MaxProP.lean` → Layer 3, `IsProP`, `proPKernel` and the universal property.
- `GQ2/FinitelyGenerated.lean` → Layer 3, the shape of `IsTopologicallyFinitelyGenerated`
  and its stability under surjections.
- `GQ2/FrattiniCriterion.lean` and `GQ2/FrattiniNongen.lean` → Layer 3, index-`p` detection
  and the Burnside surjectivity criterion.
- `GQ2/FreeProfinite.lean` and `GQ2/ProfinitePresentation.lean` → Layers 4 and 5, free
  profinite groups by completion, and presentations by closed normal closure.
- `GQ2/Zhat.lean` → Layers 0 to 2 as stress objects, and the exponentiation calculus that
  belongs with Layer 4.
- `GQ2/Demushkin.lean` → Layer 7, an `IsDemushkin` structure with `Nat.card` clauses against
  a project-local cohomology API. Its `demushkinQ` counts torsion and has no `q = 0` case;
  the roadmap's convention corrects that, so port the statement and not the convention.
- `GQ2/Orientation.lean` and the axiom `B3c` in `GQ2/Foundations/Axioms.lean` → the Layer 11
  instance for `ℚ₂`. That axiom bundles the values of Labute Thm 4, the identification of
  the dualizing character with the cyclotomic one, and a marked-isomorphism normalization.
  Layers 7, 9 and 11 make the first two into theorems. The third, that is the choice of
  marked generators `A, S, Y`, stays in `gq2`.
- `GQ2/Roe/Labute/{TwoCentralTower,Levelwise,StageLemma,SpanFoundation,GradedLie/*,Assembly}.lean`
  and `GQ2/Reconstruction.lean` → Layer 8. This is the completed single-instance rank-3
  classification at `q = 2`: the lower 2-central tower with openness and cofinality,
  levelwise comparison sets with a character condition, span and stage lemmas along `gr`,
  the König assembly `exists_contSurj_of_levelwise_nonempty`, the two epimorphisms, and the
  Hopf property. Layer 8 is its abstraction, and Layer 9 is the general theorem that it
  instantiated. Its graded-Lie span arguments are the seed of the approximation argument of
  Layer 9.
- `GQ2/Devissage*.lean` is **not** in scope: it is self-duality machinery for the word
  complex of the `gq2` paper, cited here only to delimit the migration.

## Other implementations, audit only

- `davidturturean/gq2-lean-turturean`, GPL-3.0, with no immutable revision pinned in that
  branch. It contains a from-scratch maximal pro-2 quotient
  (`Q2Presentation/Boundary/MaximalPro2.lean`) and consumes the classification as an axiom
  (`labute_GQ2_maxPro2_marked` in `Local/LabuteClassification.lean`). It is useful as an
  independent decomposition cross-check for Layers 3 and 11. **No code may be copied into
  Apache-licensed Tau Ceti without an explicit licensing decision.** Cite it; do not port
  it.
- `n-yamaguchi-0729/ProCGroups`, Apache-2.0, created 2026-07-28, AI-generated, unreviewed,
  and unannounced on Zulip, with no immutable revision pinned here. It claims free pro-`C`
  groups with a universal property, maximal pro-`C` quotients, completed group algebras, Fox
  calculus, Reidemeister–Schreier, and profinite Crowell exact sequences, which overlap
  Layers 3 to 5 and the Layer 9 prerequisites. It has no Demushkin content. Audit it
  declaration by declaration and contact the author before any reuse. Independent
  development with citation is the default, and no milestone depends on the outcome.

## Coordination

The `ProfiniteGrp` line in Mathlib is the work of Nailin Guan, Yuyang Zhao and Jujian Zhang,
with Adam Topaz on the completion and Thomas Browning on residual finiteness and
additivization. Contact them before touching those files, and follow their category
conventions for `Hom` wrappers. The continuous-cohomology line is the work of Richard Hill,
Andrew Yang and Edison Xie, and the Profinite Cohomology roadmap coordinates with it.
D. Loeffler's `p`-adic measure work and Jz Pan's `lean-iwasawa` border the completed group
algebra of Layer 9. Register intentions through this repository's claims process before
substantial work.

## Keeping the interface table in step

The interface table under "Ordering and parallelism" also appears in the Local Fields
roadmap. The two copies are kept identical by hand, and the names in them are provisional
until each supplier lands its declaration. Compare the two blocks whenever either roadmap
changes: extract the block from each file, from the heading to the sentence before the next
heading, and compare the two hashes.

The same applies to the local carriers. When the Profinite Cohomology roadmap or Mathlib
supplies a carrier and the comparison isomorphism of Layer 5 is proved, the local
definitions in `Suggested.lean` become redundant, and a contributor rewrites the consumers
along the isomorphism and removes them.

## Ecosystem note on the Mathlib release

At the time of the audit the current Mathlib release was `v4.32.2`, which is later than the
repository pin. The roadmap is written against the pin. Bumping the pin is a repository-level
change: at `v4.32.2` the whole repository builds except for two files of another roadmap,
`TauCetiRoadmap/RepresentationTheory/{LieHighestWeight,SpinRepresentations}/Suggested.lean`,
because Mathlib no longer provides the `LieRing (Matrix (Fin n) (Fin n) K)` instance.
