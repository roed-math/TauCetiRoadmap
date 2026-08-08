# Provenance and coordination: global class field theory

**This file is not normative and it is not part of the roadmap.** `README.md` is the definitive
document. Nothing here is a prerequisite of any milestone, and no milestone waits on anything
recorded here. This file records who else works on the same mathematics, what state their work
was in when it was last checked, and what a Tau Ceti implementor should do about it.

Every entry carries the date on which it was checked. Treat an entry older than a few weeks as
history, and check again before acting on it.

## Prior formalization work

- **mariainesdff/ideles** (Lean 3; ITP 2022; arXiv:2203.16344). Checked 2026-08-07: revision
  `b85d242f18cb`, unchanged since 2023-10-05. It defines the idele class group of a global
  field, states the main theorems of global class field theory, and proves that `ClassGroup` is
  an explicit quotient of the idele class group. Its adelic substrate was ported and is today's
  Mathlib stack; the class field theory statements were not. Licence Apache-2.0. Contact the
  author before any migration; otherwise reprove independently and cite the exact source.
- **kbuzzard/ClassFieldTheory.** Checked 2026-08-07: `main` at `ccc3323c6750`, top commit
  2026-07-31. The global chapter is blueprint only: `blueprint/src/_4_global.tex` develops the
  idele-class Herbrand quotient through `S`-ideles and the unit lattice, a density route to the
  upper bound, solvable induction, and fundamental classes by cyclotomic splitting. The Lean
  tree has `Cohomology/`, `IsNonarchimedeanLocalField/` and `LocalCFT/`, and no global code.
  Licence Apache-2.0. Their finite-level abstract machinery is the natural comparison for
  Layers 5 and 11. Coordinate before implementing Layer 11; cite the blueprint; port neither
  prose nor code without agreement.
- **ImperialCollegeLondon/FLT.** Checked 2026-08-07: revision `d18b563029f3`. It proves,
  sorry-free, `NumberField.AdeleRing.discrete` and `NumberField.AdeleRing.cocompact`, and
  Fujisaki's lemma in `FLT/DivisionAlgebra/Finiteness.lean`. Milestones 2A.3 and 2A.5 are the
  same mathematics. Licence Apache-2.0. Coordinate with the maintainers before implementing
  those two milestones. An independent proof is allowed with a recorded reason, and code is not
  copied without agreement.

## Mathlib work in flight

None of these is a prerequisite. Where one lands, adopt its names and delete the Tau Ceti copy.

- **PR #40735** (T. Browning), the idele class group. Checked 2026-08-07: open, head
  `ba5cc4688489`, updated 2026-08-05. It defines `NumberField.IdeleGroup`,
  `IdeleGroup.principalSubgroup`, `IdeleClassGroup`, and the maps from local units. Layer 2A
  defines the same objects. Contact the author before implementing Layer 2A, and match his
  names and shapes so that a later swap is an import change.
- **PR #40661** (F. A. E. Nuccio), a `theorem_wanted` file for the Hilbert class field. Checked
  2026-08-07: open, head `184a5900ddc0`, updated 2026-07-16. It contains Kronecker–Weber, a
  conductor-as-least-cyclotomic-level statement, and the Hilbert class field with
  `Gal ≃* ClassGroup (𝓞 K)`, unramifiedness, maximality, and the principal ideal theorem
  through `ClassGroup.extendedHom = 1`. Layers 8 and 9 prove statements of those shapes.
- **PRs #36404 and #36275** (S. Mercuri), local compactness of `𝔸_K` and the finite-adele norm.
  Checked 2026-08-07: open, heads `fca3a6af67b8` and `df510478253d`. Milestones 2A.2 and 2A.4
  overlap with them.
- **PRs #40848 and #40791**, `S`-integers as a localization, and Dirichlet's `S`-unit theorem.
  Checked 2026-08-07: open, heads `1386a3f5a528` and `6c4013931e7a`. Milestone 5.2 proves the
  `S`-unit statement it needs.
- **PR #41591** (X. Roblot), the ring-level decomposition and inertia refactor. Checked
  2026-08-07: open, head `9a76f0e50eee`. Follow the direction it takes when it lands.
- **Dirichlet density, PR #41765** (R. Brasca). Checked 2026-08-07: closed unmerged on
  2026-08-07. Density is outside this roadmap either way.
- **PR #42130**, instance transparency. Checked 2026-08-07: closed unmerged 2026-08-06. Do not
  plan against it.

## Earlier drafts of this roadmap

Recorded because a reader of the history will find these layers and would otherwise look for them
in `README.md`. The README carries the final boundary only.

- Checked 2026-08-08. Drafts before this one were dependency-closed: they built local class field
  theory and the generic finite-group Tate machinery inside this roadmap, as a Layer T (Tate
  cohomology in all degrees, functoriality, periodicity and the Herbrand quotient, cup products,
  class formations and Tate-Nakayama) and a Layer I (a `LocalCFT` package class stating the local
  theory, its construction, and the cyclotomic orientation over `ℚ_p`). Both are gone. The Local
  Fields roadmap owns that material and this roadmap consumes it by the declaration table in
  `README.md`. What survives here is Layer D: the completion dictionary at a finite place, the
  ideal-theoretic Artin map, the finite-level cyclotomic orientation, and the local
  conductor-discriminant formula. The quadratic Hilbert symbol left with the local theory, to the
  Quadratic Form Invariants roadmap.

## Sibling Tau Ceti roadmaps

Local Fields and Quadratic Form Invariants are not alignments. They are prerequisites, and
`README.md` names every declaration this roadmap takes from them. The rest below are alignments.

- **Local Fields.** The supplier of local class field theory and of the generic finite-group Tate
  and class-formation machinery. Checked 2026-08-08 against its Layers 0 to 8 and its
  `Suggested.lean`: every declaration and milestone that `README.md` cites exists there. One gap
  found, and handled here rather than pushed back: that roadmap fixes the conductor of an abelian
  *extension*, `c(L/K)` and `𝔣(L/K)`, and exports no conductor of a continuous character of `Kˣ`.
  Milestone D.4 therefore defines the character exponent itself, on that roadmap's `unitFiltration`
  and on no filtration of its own. Two further citations are to milestones that roadmap states
  without a Lean name, `θ(π) = Frob` and `c(L/K)`; those rows cite the milestone, not a declaration.
- **Quadratic Form Invariants.** The supplier of the quadratic Hilbert symbol that 11.4 multiplies
  at the finite places, through its Layer 6C `hilbertSymbol`. Its Lean module is not imported by
  `Suggested.lean`, so 11.4 has no prototype here rather than a faked one.
- **Number Field Arithmetic.** Checked 2026-08-07: head `9b63e874e391`. Plans the decomposition,
  inertia and Frobenius API, and the ideal-theoretic Artin map `artinHomAway S hur` on the same
  `(FractionalIdeal (𝓞 K)⁰ K)ˣ` carrier as D.2. Compared at that head: the carrier and the
  unramifiedness hypothesis agree, and the abelian hypothesis is packaged differently. That
  declaration takes `[IsGalois K L]` with a commutativity argument where D.2 takes
  `[IsAbelianGalois K L]`, and the universe binders differ. If it merges, replace D.2 through
  that short transport; deletion alone does not typecheck.
- **Profinite Cohomology.** Checked 2026-08-07: head `ac180b5a3ab3`. Plans continuous cohomology of
  `G_K` with colimits over finite
  quotients. Milestone 11.2 states the small part of that theory which Layer 11 uses.
- **L-functions.** Consumes the Hecke characters of Layer 3 and owns everything analytic,
  including Chebotarev and density. This roadmap is density-free so that the dependency runs in
  one direction only.
- **Multiquadratic (merged).** Consumes the narrow class group of 1.8 and the genus-field
  compatibility of 8.2.
- **Wave-2 consumers.** Quaternion arithmetic consumes 11.4. Honda–Tate consumes 11.3. Complex
  multiplication consumes 10A.3 and 10C.1. Each of those is a numbered milestone, so a later
  roadmap can cite the exact target.

## Outreach status

Checked 2026-08-07: no outreach has been performed. No ownership has been agreed with any
project or author named above. The contact steps recorded here are part of the corresponding
milestone, and not work delegated to a future implementor.

Named authors whose work this roadmap touches: T. Browning (idele class group), S. Mercuri
(adele topology and norm), F. A. E. Nuccio (wanted statements, and the Lean 3 ideles project),
M. I. de Frutos-Fernández (Lean 3 ideles, and the Mathlib adelic substrate), X. Roblot
(cyclotomic Galois theory, ramification refactor), F. Barroero (places and the product
formula), R. Brasca (`ClassGroup.extendedHom`), D. Angdinata (`S`-integers).

## Zulip decisions in force

- The 2020 `maths > "Ideal class group"` thread (Baanen, Buzzard, Best) fixed the
  fractional-ideal design of `ClassGroup` that Layers 1 and 7 build on, and already discussed
  idele-class compactness as the unifying statement.
- The `ValuativeRel`-replaces-`Valued` refactor threads. Milestone D.1 follows them: state no
  new lemma against `Valued`.
- Checked 2026-07-30 and again 2026-08-07: the Zulip archive has no thread on ray class groups,
  Hecke characters, or global reciprocity in Lean. Announce the intention before starting
  Layers 0 and 6.

## Directions beyond this roadmap

This section is not normative, and it is not work to attempt now. It records where the material
of `README.md` leads, so that a later roadmap can pick a direction without rereading the layers.

- Poitou–Tate duality and the full cohomology of number fields, on top of Layer 11.
- Explicit reciprocity laws and power-residue symbols.
- The Grunwald–Wang phenomenon. The claim "an element that is an `n`-th power locally everywhere
  is a global `n`-th power" fails when `8 ∣ n`. The standard example is `16`: it is an `8`-th
  power in `ℝ` and in `ℚ_p` for every **odd** `p`, and it is not an `8`-th power in `ℚ`. It is
  also not an `8`-th power in `ℚ₂`, because `v₂(16) = 4` is not divisible by `8`, so the failure
  is at `2` alone. Source: Milne, *Class Field Theory*, Ch. VIII, Example 1.2(i) and
  Exercise 1.3.
- Tate's thesis and the analytic theory.
- The function-field and geometric theory.
- Explicit class field theory beyond complex multiplication.
