# Provenance for the local fields roadmap

This file is a dated survey of the ecosystem around
[the local fields roadmap](README.md). It is **not normative**. Nothing recorded here is a
prerequisite of a milestone. The roadmap states its prerequisites itself, and admits three kinds
only:

- a declaration of the required Mathlib version;
- an accepted Tau Ceti declaration;
- an earlier milestone of the roadmap.

Three kinds of information are collected here:

- the state of Lean work outside Mathlib that covers part of the same mathematics, with the
  conditions that apply to reuse of the code;
- open Mathlib work and recorded design decisions that the roadmap follows for the shape of its
  statements;
- which development is expected to discharge each field of the three hypothesis structures, and
  the name it currently uses for it.

An open Mathlib pull request is never a reason to wait. Build the object in Tau Ceti now, with
the name and the shape that the pull request uses. If it lands, delete the Tau Ceti copy and
import Mathlib's.

## Lean projects outside Mathlib

Checked on 2026-08-06. No author was contacted, and no agreement is claimed. Public repositories
and pull-request metadata were inspected.

### `kbuzzard/ClassFieldTheory`

Kevin Buzzard, Yunzhou "Edison" Xie, and contributors. This is the 2025 Clay Summer School
project.

- **Revision:**
  [`ccc3323c6750`](https://github.com/kbuzzard/ClassFieldTheory/commit/ccc3323c6750abca25b49b35106f54eb3a398509),
  2026-07-31, the head of `main` on the snapshot date.
- **Licence:** Apache-2.0.
- **Overlap:** the local-field instances and the valuation sequence of Layer 0; the finite class
  formations, the Herbrand quotient, and abstract reciprocity of Layers 5 and 6.
- **Status at that revision, abstract half, sorry-free:** Tate cohomology, since upstreamed to
  Mathlib; the `FiniteClassFormation` class with the abstract Tate–Nakayama `reciprocityIso`
  (`Cohomology/SplittingModule.lean`). Layer 5 here defines `FiniteClassFormation` with five
  fields, and `Nat.card H` as the order of `H²(H, M)`. Comparing the two interfaces field by
  field is an explicit obligation of that milestone, before their vocabulary is adopted. Check in
  particular which of `Nat.card H` and `[G : H]` their order field uses: only the first is
  correct, because `H = 1` refutes the second; the Herbrand-quotient calculus
  (`Cohomology/FiniteCyclic/HerbrandQuotient/`); `localInv` (`Cohomology/LocalInv.lean`); the
  valuation sequence `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0`
  (`IsNonarchimedeanLocalField/ValuationExactSequence.lean`); the canonical
  `UnramifiedExtension K n` with its universal property and `maximalUnramified`
  (`IsNonarchimedeanLocalField/Unramified.lean`); the Teichmüller character
  (`LocalCFT/Teichmuller.lean`); and `IsNonarchimedeanLocalField ℚ_[p]` (`Qp.lean`).
- **Status at that revision, local half, open:** positive-degree vanishing of
  `Hⁱ(Gal(L/K), 𝒪[L]ˣ)` for unramified `L/K` (`UnramifiedCohomology.lean`); the local-unit
  Herbrand quotient `h(𝒪[L]ˣ) = 1` (`IsNonarchimedeanLocalField/HerbrandQuotient.lean`); the
  fundamental class; and the Artin map. Each is one explicit `sorry`, or has no file yet.
- **Contact status:** not contacted. No ownership agreement is recorded.
- **Plan:** consume the results of that project which have landed in Mathlib. Prove the Tau Ceti
  milestones independently against the same public interfaces, with three standing obligations.
  1. *Interface alignment.* The `FiniteClassFormation` interface, the Herbrand-quotient
     convention, and the `IsNonarchimedeanLocalField` vocabulary are adopted as they stand, so
     that statements are mutually translatable.
  2. *Citation.* The theorem sequence of their blueprint (`blueprint/src/_3_local.tex`) is the
     finite-level skeleton that Layers 5 and 6 follow.
  3. *Replacement on landing.* If their local half lands in Mathlib, the corresponding milestones
     become comparison-and-consume tasks.
- **Code transfer:** contact the maintainers, and record the outcome, before any adaptation of
  code that has not landed, of proof structure, or of a shared statement. Until then only the
  public API and the mathematical statements may be consulted.

### `Akwardbro/RamificationGroup`

Junjie Bai, Jiedong Jiang, Prowler99, Yicheng Tao, and contributors.

- **Revision:**
  [`c3fd8515a8e3`](https://github.com/Akwardbro/RamificationGroup/commit/c3fd8515a8e35c2876057ab59f4751be6638f3ab),
  2026-03-01.
- **Licence:** no licence file was found in the check of 2026-08-06.
- **Overlap:** the lower numbering, the upper numbering, and the Herbrand functions of Layer 3.
- **Status at that revision:** lower-numbering ramification groups, `AlgEquiv.lowerIndex`, the
  Herbrand functions, and the upper numbering, aimed at Kronecker–Weber. It is built on the
  `mariainesdff` stack, and not on `IsNonarchimedeanLocalField`. Development stopped in March
  2026, with sorries in roughly 27 of 41 files, and no Mathlib pull request has come out of it.
- **Contact status:** not contacted.
- **Plan:** prove Layer 3 independently, from the cited mathematics, in the
  `IsNonarchimedeanLocalField` substrate. Their file layout
  (`LowerNumbering`, `HerbrandFunction`, `UpperNumbering`) and their lemma granularity are useful
  prior art, and Layer 3 cites the repository.
- **Code transfer:** no code, comment, or project-specific organization of statements may be
  transferred, unless the licence is clarified and the authors agree.

### `mariainesdff/LocalClassFieldTheory`

María Inés de Frutos-Fernández and Filippo A. E. Nuccio, arXiv:2310.01998.

- **Revision:**
  [`9ebdafa0b464`](https://github.com/mariainesdff/LocalClassFieldTheory/commit/9ebdafa0b464df096037c10a2597c40f7e046602),
  2025-07-02.
- **Licence:** no licence file was found in the check of 2026-08-06.
- **Overlap:** the finite-extension valuation layer that has not landed upstream, which is prior
  art for the construction milestone of Layer 0. Their spectral-norm work and valuation-algebra
  work did land in Mathlib, and the roadmap consumes those directly.
- **Status at that revision:** complete-DVR local fields in both characteristics; the unique
  extension of a valuation to a finite extension (`DiscreteValuationRing/Extensions.lean`); an
  empty `ClassFormation.lean`; and no Lubin–Tate theory. Development stopped in July 2025.
- **Contact status:** not contacted.
- **Plan:** consume only their work that landed in Mathlib, and prove the intrinsic milestone
  independently.
- **Code transfer:** no transfer of code that has not landed, without clarification of the
  licence and recorded permission.

### `davidturturean/gq2-lean-turturean`

Licence GPL-3.0. This is an audit and comparison source only. The licence is not compatible with
reuse of code in Tau Ceti.

### The `p = 2` formalization behind the downstream table

The consumer labels `B1`, `B5`, `B6`, `B7`, `B10`, and `B11a` in the roadmap are acceptance
targets of `gq2-lean` (Apache-2.0, `github.com/roed-math/gq2-lean`), in
`GQ2/Foundations/Axioms.lean`. Files there that are worth adapting, and that must never be
treated as prescriptive, where they match the intrinsic statements:

- `UnitFiltration*.lean`, `UnitNormIndex.lean`, and `TeichmullerLift.lean`, for Layer 1;
- `UnramifiedBridge.lean`, `UnramifiedModel.lean`, `UnramifiedNorm.lean`, and `Zhat.lean`, for
  Layer 2;
- `Tame*.lean`, for Layer 4;
- `LocalKummer.lean` and `MuN.lean`, for Layer 5;
- `Reciprocity.lean`, for the statement forms of Layer 7;
- `TateDuality.lean` and `EulerCharacteristic.lean`, for the statement forms of Layer 8.

Three encoding decisions there are repaired in the roadmap, and not inherited: duality for each
`n` without compatibility across `n`, which Layer 8 names as a milestone; the unnormalized
invariant map, whose normalization Layer 5 fixes; and the geometric `ν_ur` as the primary
convention, which is a translation lemma here.

## Open Mathlib work

Surveyed in 2026-07, against the `ValuativeRel` and `RamificationInertia` areas.

- The `ValuativeRel` wave: #26886, #26885, and #26827 (pechersky: follow-ups for
  `ValuativeRel ℚ_[p]`, `ValuativeTopology 𝒪[K]`, normed-field helpers); #40309, #36769, and
  #40315 (jjdishere: `Normed → IsValuativeTopology`, instances on completions); #30135 (erdOne:
  `ValuativeRel` on subrings); #27181 and #27180 (ADedecker: the `ValueGroupWithZero` refactor);
  #38009 (CBirkbeck: the valuation spectrum).
- The `RamificationInertia` refactor wave: #41591, #35808, #36843, #35991, #36733, and #37031
  (xroblot: ring-level decomposition and inertia predicates, splitting in the inertia ring,
  compositum results); #40955, #40387, and #40952 (tb65536: Galois groups generated by inertia,
  inertia of quotient groups).
- The `FormalGroup` series #38213, #36167, and #41710 (WenrongZou: homomorphisms of formal
  groups). This is the seed of any future Lubin–Tate development. The reciprocity of the roadmap
  does not depend on it. That matches the decision of Buzzard and Hill in 2025-04, to define the
  Artin map through group cohomology and not through Lubin–Tate theory.
- No open Mathlib pull request on higher ramification groups, Herbrand quotients, class
  formations, or reciprocity was found in that survey.

## The interface assumed by a modularity-lifting artifact

The branch `erd1/LCFT` of erdOne carries the exact statement that the four-axiom
modularity-lifting artifact of the FLT project assumes as its local class field theory axiom. The
file is `Mathlib/NumberTheory/ClassFieldTheory/Local/Basic.lean`. This is per the FLT update of
A. Yang of 2026-07-27. The statement has two parts. The first is
`SatisfiesLocalExistenceTheorem K`: the open subgroups of finite index of `Kˣ` are exactly the
norm subgroups. The second is `LocalArtinMapData K`: compatible isomorphisms
`Kˣ ⧸ normSubgroup K L ≃* Gal(L/K)` for finite abelian `L/K`, with the arithmetic-Frobenius
normalization at uniformizers in unramified extensions through `IsArithFrobAt`, and with tower
compatibility. The two are assembled as `SatisfiesLocalClassFieldTheory K`. Step 9 of Layer 7 is
the same structure, so that a Tau Ceti proof translates directly.

The blueprint of `ImperialCollegeLondon/FLT` states its local class field theory assumption in a
form shaped like `K^× ≅ W_K^{ab}` and marks it `\notready`. The packaging with Weil groups is
outside the scope of the roadmap. The Artin map of Layer 7, with dense image, is its substance.

## Design decisions recorded on the Lean Zulip

Audited on 2026-08-06.

- The design history of `IsNonarchimedeanLocalField`, in Mathlib pull request #27465 (erdOne,
  merged 2025-10, out of the Oxford class field theory workshop). It includes the decision to use
  `TopologicalSpace` and not `UniformSpace`, after the point of Gouëzel about completeness for
  locally compact groups. See
  [maths > "Local fields in Lean 4"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Local.20fields.20in.20Lean.204/near/530522781)
  and
  [mathlib4 > "Finite extensions of Q_p"](https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/topic/Finite.20extensions.20of.20Q_p/near/501395419).
  The second topic also carries the decision to define the Artin map through group cohomology.
- The project to deprecate `Valued` in favour of `ValuativeRel`, opened 2026-03-23 by Jiedong
  Jiang, in
  [PR reviews > "Project: Deprecate `Valued`"](https://leanprover.zulipchat.com/#narrow/channel/144837-PR-reviews/topic/Project.3A.20Deprecate.20.60Valued.60/near/581079158).
  Nothing in the roadmap is stated against `Valued`.
- The direction of the unramified-extension API, in
  ["unramified extensions of local fields"](https://leanprover.zulipchat.com/#narrow/channel/217875-Is-there-code-for-X.3F/topic/unramified.20extensions.20of.20local.20fields/near/546006441),
  2025-10-20: for valued fields, unramifiedness is bijectivity on value groups plus separability
  of the residue extension. That fixes the predicate of Layer 2.
- The design thread for ramification filtrations,
  [maths > "Formalizing Ramification Groups"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Formalizing.20Ramification.20Groups/near/426788185),
  2024-03, Jiedong Jiang, Topaz, Buzzard.
- The open debate on the categorical carrier `TopRep` of continuous cohomology, in
  [maths > "Continuous cohomology"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Continuous.20cohomology/near/610038284),
  2026-07: whether an object should require joint continuity of `G × V → V`. The discrete-module
  case with open stabilizers, which the roadmap uses, is stable under every proposal in that
  thread.
- The day-to-day channel of the ClassFieldTheory project is private. It was created for the 2025
  Clay workshop, and access is by direct message to Buzzard. The sorry state of the repository is
  therefore the best public measure of its progress.

## Neighbouring roadmap

The adic spaces roadmap shares the `ValuativeRel` substrate, and nothing else. It develops
valuation spectra and Huber and Tate rings, towards the Fargues–Fontaine curve, and does not
touch the arithmetic of local fields: ramification, unit filtrations, and reciprocity are absent
from it. If both are accepted, the work on the `ℚ_p` instance in Layer 0 should be checked
against its Layer-0 examples, for duplication.

## Keeping the shared interface table in step

The subsection "Interface table: Local Fields and Pro-`p` Groups" of [`README.md`](README.md)
also exists in the Pro-`p` Groups roadmap. The two copies are kept identical, wording included,
so an edit to one is an edit to the other. The check is a byte comparison of the two sections,
from the heading to the next heading of the same level. The version in this repository was taken
from the Pro-`p` Groups copy on 2026-08-07.

The table is a coordination record, and not a dependency. The roadmap needs no row of it to
start work: a milestone that uses an operation from either side carries that operation as an
explicit hypothesis, and the table records who is expected to prove it.

## Who is expected to discharge each hypothesis

Checked on 2026-08-07 against the current heads of the sibling pull requests. These roadmaps are
under review, so nothing below is a prerequisite, and none of the names is fixed.

| structure and field of `Suggested.lean` | expected supplier | its current name |
|---|---|---|
| `ProPOps.exists_isProPSylow` and the three other Sylow fields | Pro-`p` Groups Layer 2 | anonymous `example`s; the predicate is `TauCetiRoadmap.ProPGroups.IsProPSylow` |
| `ProPOps.freeProfiniteGroupLift` | Pro-`p` Groups Layer 4 | anonymous `example`; the object is `TauCetiRoadmap.ProPGroups.freeProfiniteGroup` |
| `ProPOps.rank_le_of_surjective`, `ProPOps.rank_le_of_isOpen` | Pro-`p` Groups Layer 3 | anonymous `example`s; the rank is `TauCetiRoadmap.ProPGroups.topologicalGeneratorRankNat` |
| `ProPOps.topologicallyGenerates_iff_frattiniQuotient` | Pro-`p` Groups Layer 3 | anonymous `example`; the Frattini subgroup is `TauCetiRoadmap.ProPGroups.proPFrattini` |
| the three fields of `ProPRankInputs` | Pro-`p` Groups Layer 11 | fields of `TauCetiRoadmap.ProPGroups.LocalFieldInputs`, and its Demushkin instance |
| `CohomologyOps.tensorObj`, `CohomologyOps.cup` | Profinite Cohomology Layer 8 | its low-degree cup product |
| `CohomologyOps.coeff` | Mathlib | `ContinuousCohomology.cochainsMap` at the identity group homomorphism |
| corestriction, Mackey, Shapiro, the finite-quotient colimit | Profinite Cohomology Layers 4, 6, 7 | these occur in no statement of this roadmap, only in proofs |

Two mismatches with the current heads are recorded, and neither blocks anything here.

- The Pro-`p` Groups head states its Layer 2 and Layer 3 theorems as anonymous `example`s, so
  there is no declaration name to cite for them yet. The **definitions** do have names, and the
  copies in `Supplied` have the same bodies, so those transport by `rfl`.
- The Profinite Cohomology head prototypes a cup product against its own low-degree carrier,
  while this roadmap uses Mathlib's `continuousCohomology`. A term of `CohomologyOps` therefore
  needs the comparison between the two carriers, which is that roadmap's Layer 3.

## Ownership, where two roadmaps touch the same mathematics

- The **continuous-cohomology carrier** is Mathlib's `continuousCohomology`. This roadmap states
  nothing against a private carrier and builds none.
- The **normalized valuation, the unit filtration, and local square classes** are Layers 0 and 1
  here, and every later layer of this roadmap rests on them. The position of this roadmap is that
  it owns them and that a local toolkit elsewhere should consume them, because a second normalized
  valuation would need a comparison lemma at every use site. The Quadratic Form Invariants roadmap
  currently declares a `LocalFieldToolkit` that covers part of the same ground. Adopting the
  objects here is a change to that roadmap, and this one is not blocked by it.
- The **Hilbert symbol** is stated here by the norm criterion, which is characteristic-free and
  needs no object from another roadmap. The `{±1}`-valued dictionary, quaternion algebras, the
  quadratic defect, and the classification of forms are the Quadratic Form Invariants roadmap's.
  This roadmap defines no quadratic form and no quaternion algebra.

At the date of this file, the roadmaps named above are the pull requests
[#1](https://github.com/roed-math/TauCetiRoadmap/pull/1),
[#2](https://github.com/roed-math/TauCetiRoadmap/pull/2),
[#3](https://github.com/roed-math/TauCetiRoadmap/pull/3), and
[#4](https://github.com/roed-math/TauCetiRoadmap/pull/4) of `roed-math/TauCetiRoadmap`.
