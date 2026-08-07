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
- **The contour integration roadmap builds no rectangle contour.** Its Layers 0–3 supply
  `windingNumber`, `residue`, the argument principle (pinned on a circle in its
  `Suggested.lean`), and the homology form of Cauchy's theorem. The positively oriented
  boundary of a rectangle, its winding numbers, its null-homology, and the continuous
  argument lift along a nonvanishing image curve are none of these, and Layer 7.1–7.3 here
  owns them, listed under *Interfaces supplied to other roadmaps* so that no second
  construction appears. If that roadmap adds a rectangle interface, this one consumes it and
  deletes its own; that swap is a deletion plus an import, which is why the statements here
  are phrased in its vocabulary.
- **The modular forms roadmap's analytic conductor.** Both roadmaps pin Iwaniec–Kowalski
  (5.7), and Layer 2.4 here proves the agreement rather than assuming it. The two
  conventions differ in presentation, not in value: that roadmap writes the newform quantity
  in the arithmetic normalization at the central point `k/2`, this one writes it in the
  analytic normalization at `1/2`, and the equality is the normalization translation of
  Layer 2.3. ⚠ The paired-shift form is load-bearing here: writing a `Gammaℂ(s + ν)` factor
  as `(|s + ν| + 3)^2` instead of `(|s + ν| + 3)(|s + ν + 1| + 3)` would make the two agree
  only up to a bounded ratio, and Layer 2.4 would be false as stated.

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
