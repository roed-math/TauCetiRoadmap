# Zeros of L-functions: provenance, ecosystem audit, and coordination

Supporting material for [`README.md`](README.md), which is the specification. Nothing here
is a completion criterion. This file records what the surrounding Lean ecosystem contained
when the roadmap was written, whose work it sits next to, and what has to be settled with
whom. All of it goes stale; the README does not depend on any of it.

Audit date **2026-08-07**, against the project pin
`9caeba1000ef8f302920981f4a08651d325abc81` (Mathlib, 2026-06-03).

## Coordination ledger

Each row is an obligation across roadmap boundaries, not a target.

- **The L-functions roadmap's Layer 7.6 is consumed here and is not listed there.** Layer 8
  of this roadmap consumes the ideal von Mangoldt weight `Λ_K` and the identity
  `−L'/L(χ, s) = LSeries (idealCoeffOfWeight (χ · Λ_K)) s`, which that roadmap builds as its
  Layer 7.6 but does not name under its *Interfaces supplied to other roadmaps*. The
  boundary should be symmetric: that list wants a row for 7.6. The same holds for its Layer
  1.4 (the Euler product, nonvanishing on `Re s > 1`, and the abscissa of absolute
  convergence), which Layer 4.7 here uses for the lower bound Jensen's formula needs, and for
  its Layer 4 completed factorizations, which two worked examples here use.
- **The contour integration roadmap builds no rectangle contour, and its exact general-cycle
  theorem is its Layer 4.** Its pinned `argumentPrinciple` and `classicalResidueTheorem_circle`
  are circle-only; its README defers the general null-homologous cycle to "Layer 3+", and the
  first exact statement covering one is `hungerbuhlerWasem_residueTheorem`. Layer 7.2 here
  therefore consumes that theorem, not the circle ones, and `Suggested.lean` imports
  `TauCetiRoadmap.ContourIntegration.Suggested` so the contract is machine-checked. ⚠ That
  import is the first cross-roadmap import in the repository; if the project would rather keep
  the `Suggested.lean` files independent, the alternative is for the contour roadmap to add a
  named general-cycle residue theorem and for this roadmap to cite it by name without
  importing. The rectangle boundary, its winding numbers, its null-homology, and the continuous
  argument lift are owned here and exported under *Interfaces supplied to other roadmaps*; a
  future consolidation into the contour roadmap would be a deletion plus an import here, which
  is why the statements are phrased in its vocabulary.
- **Two of that supplier's hypotheses shaped Layer 7, and both are worth flagging to it.**
  `IsPwC1ImmersionOn` requires a non-vanishing one-sided derivative on every breakpoint-free
  piece, which makes the boundary of a degenerate rectangle inadmissible and is why
  `Rect.Nondegenerate` exists here and is separate from `Rect.Valid`. And
  `hungerbuhlerWasem_residueTheorem` takes `DifferentiableOn ℂ f (U \ ↑S)` over an explicit
  finite `S`, not `MeromorphicOn` plus a divisor — a gap that is real rather than cosmetic,
  since a meromorphic representative may be redefined at an isolated point without changing any
  order. Layer 7.2a is the bridge, under the hypothesis that every point of nonnegative order
  is a point of analyticity. Two things that roadmap could add and this one would then delete:
  a `HasCauchyPV`-to-interval-integral lemma under continuity on the curve (Layer 7.2b here),
  and the canonical-representative bridge itself, which is generic complex analysis and not
  L-function mathematics.
- **The modular forms roadmap's analytic conductor.** Both roadmaps pin Iwaniec–Kowalski
  (5.7), and Layer 2.4 here proves the agreement rather than assuming it. The two
  conventions differ in presentation, not in value: that roadmap writes the newform quantity
  in the arithmetic normalization at the central point `k/2`, this one writes it in the
  analytic normalization at `1/2`, and the equality is the normalization translation of
  Layer 2.3. ⚠ The paired-shift form is load-bearing here: writing a `Gammaℂ(s + ν)` factor
  as `(|s + ν| + 3)^2` instead of `(|s + ν| + 3)(|s + ν + 1| + 3)` would make the two agree
  only up to a bounded ratio, and Layer 2.4 would be false as stated.

- **The supplier's normalization signs were corrected while this roadmap was being written.**
  An earlier head of the L-functions roadmap displayed `gammaR = arithmetic.gammaR.map (· − w/2)`
  in its README while its Lean prototype had `+ w/2`. Its current head has `+ w/2` in both,
  which is the convention Layer 2.3 here needs and states: with the opposite sign the conductor
  translation and the modular-forms agreement are both false. If that roadmap's signs move
  again, Layer 2.3 and its two instance tests are the first things to re-check.
- **Theorem numbering in the printed sources, now pinned except for one source.** The
  *Sources for the hard milestones* table in the README fixes, for each hard milestone, the
  exact source location, its hypotheses, the translation into this roadmap's normalization,
  the dependence of every constant, and — where no single source proves the displayed theorem
  — the additional steps as milestones. The numbers were checked against copies of the
  sources, not recalled: Kadiri Theorem 1.1 with its two displayed regions (1.7) and (1.8) and
  Corollary 1.2; Titchmarsh Lemma 3.12 (3.12.1), §9.2 and Theorem 9.2, §9.3 and Theorem 9.3
  with (9.3.1) and (9.3.2), and Theorem 9.4 with (9.4.2) and (9.4.3); Lang ch. XVII §3
  Theorem 3.1 and Theorem 3.2, the Barner conditions (a), (b), (c) as that section states
  them, and ch. XV §§4–5; and Davenport's third-edition section numbering (§13 to §21).
  ⚠ Two corrections came out of that check and are now in the README: Davenport §19 is *The
  Explicit Formula for `ψ(x,χ)`*, so the `exp(−c√log x)` shape is §18 and §20 rather than
  §§18–19; and Kadiri's Theorem 1.1 is two statements, "no zeros" for `|Im s| ≥ 1` and "at most
  one, real and simple" for `|Im s| ≤ 1`, which the earlier row conflated into one.
  **Still open:** Iwaniec–Kowalski's within-chapter theorem numbers. The chapter-5 section
  numbering is exact (§5.1 to §5.14 and §5.A, with §5.3 the zero-counting section), but no
  accessible copy of the body was found, so the two rows citing it cite the section. Neither
  row's proof route depends on the number. Someone with a physical copy should finish this one
  item.
- **The L-functions roadmap is not yet merged, and that is the last blocker.** Every
  declaration name this roadmap cites from it (`AnalyticLFunctionData`,
  `HasMeromorphicContinuation` and its `regular_away` field, `NormalizationTranslation`,
  `idealCoeff`, `idealVonMangoldt`, `riemannZetaData`, and the rest) is pinned against that
  roadmap's prototype rather than against an accepted file, and `Suggested.lean` here cannot
  import it. The dependency table now names each crossing exactly and marks *unnamed* every
  crossing that roadmap states as an anonymous `example`; those marks are the list of names
  owed there, and they are as much a blocker as the merge, since an anonymous example is not a
  declaration contract. When it lands, the following are added to `Suggested.lean` and are the
  exact remaining Lean work:
  - generic `entireCompletion` over the record, replacing the ζ-only existential;
  - generic `invGammaFactor` and the regularized `continuedL`, with the order formula, the
    analyticity clause, and the ζ value test;
  - `dualData`, and the functional equation of `continuedL` against it — ⚠ that record is an
    object the L-functions roadmap should own, since it names `dualCompleted` but no dual
    record; it is built here so that nothing waits, and it is a candidate to move there;
  - `IsFiniteOrder`, record-level `analyticConductorAt`, and the normalization transport of
    both the conductor and `continuedL` (Layer 2.3);
  - the Dedekind and Hecke instance bridges of Layer 1.6, which are the two comparison
    theorems that cannot be stated at all until that roadmap names its continued objects.

## What is in motion elsewhere

Coordinate and cite; do not fork.

- **Mathlib's `Analysis/Complex/ValueDistribution/`** (Stefan Kebekus, with Matteo
  Cipollina) is six files and about 1500 lines carrying Nevanlinna's proximity, log-counting,
  and characteristic functions and the First Main Theorem in both parts. Nothing else in
  Mathlib imports it. It is not consumed here, for the reasons in the README's audit section
  (log-weighted, `ℝ`-valued, hard-coded at the origin, discs rather than rectangles), and
  Layer 4.11 states the comparison lemmas instead. The directory's own TODOs — Cartan's
  formula, monotonicity of the characteristic, the Second Main Theorem, the lemma on the
  logarithmic derivative — mark where that development is going, and the unintegrated
  counting function `n(r,f)` that Layer 4 builds is the object it lacks.
- **`Analysis/Complex/BorelCaratheodory.lean`** (Maksym Radziwill) is new at the pin and is
  the engine for the hard half of Hadamard's theorem (Layer 5.6). It arrived after the
  earlier draft of this roadmap was written, which is why the audit lists it explicitly.
- **`Analysis/Complex/BranchLogRoot.lean`** supplies continuous logarithms on simply
  connected sets. Three separate layers here (1.1, 5.5, 7.3) consume it, and each needs the
  same upgrade from continuity to holomorphy; if that upgrade lands in Mathlib, all three
  consume it instead.
- **PrimeNumberTheoremAnd** (AlexKontorovich/PrimeNumberTheoremAnd) contains
  `MediumPNT` (`ψ(x) = x + O(x·exp(−c (log x)^{1/10}))`) and an in-progress `StrongPNT` port.
  Layer 8.5 here states the classical `exp(−c√log x)` error for a general number field with
  the exceptional-zero term explicit; the `K = ℚ` case should be matched against that project
  before it is built, and its zero-free-region and Perron-formula infrastructure read.
- **The valence formula** in the modular forms roadmap is the other consumer of the contour
  integration roadmap's argument principle. The two consumers want different contours — a
  fundamental domain with indented elliptic points there, a rectangle here — which is why
  neither generalization belongs to the supplier by default. Worth one message before Layer 7
  starts, so that a single rectangle-and-cycle interface lands rather than two.

## Lines of work this roadmap continues

- **The Kebekus line** (Jensen's formula, divisors of meromorphic functions, value
  distribution). Layers 4 and 5 sit directly on `JensenFormula.lean` and
  `Meromorphic/Divisor.lean`. Two additions here are natural companions to that work: the
  trailing-coefficient variant of `AnalyticOnNhd.sum_divisor_le`, which drops the hypothesis
  `f c ≠ 0` (Layer 4.5), and the unintegrated counting function with the
  `n`-versus-`N` comparison (Layer 4.11). Talk to that line before both.
- **The Birkbeck line** (`ContourIntegration`, `ConformalMapping`, and the AINTLIB migration
  behind them). Layer 7 is a consumer, and the rectangle interface above is the thing to
  agree on.
- **Sibling Tau Ceti roadmaps.** The [L-functions roadmap](../LFunctions/README.md) supplies
  everything arithmetic; the [contour integration roadmap](../ContourIntegration/README.md)
  supplies the residue calculus; the [modular forms roadmap](../ModularForms/README.md)
  shares the analytic-conductor convention. Nothing here is consumed by another roadmap yet,
  so the *Interfaces supplied* list is a standing offer rather than a live obligation.
