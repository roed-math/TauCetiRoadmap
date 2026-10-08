# Campaigns and boundary decisions for phase 2 (2026-10-07)

Ten campaigns (spokes), following `coordination.md` §4.2, with one change: math.SP joins the
functional-analysis / mathematical-physics campaign rather than analysis.

| Campaign | Code | arXiv classes |
|---|---|---|
| Number theory | NT | math.NT |
| Algebraic geometry | AG | math.AG |
| Algebra | ALG | math.AC, math.RA, math.GR, math.RT, math.QA |
| Topology, categories, K-theory | TOP | math.AT, math.GT, math.CT, math.KT, math.GN |
| Geometry | GEO | math.DG, math.SG, math.MG |
| Analysis and PDE | ANA | math.CA, math.CV, math.AP, math.NA, math.OC |
| Functional analysis, operator algebras, spectral theory, mathematical physics | FAMP | math.FA, math.OA, math.SP, math-ph (math.MP) |
| Probability and dynamics | PRDS | math.PR, math.ST, math.DS |
| Combinatorics | COMB | math.CO, cs.DM |
| Logic, computation and information | LTCS | math.LO, cs.LO, cs.CC, cs.DS, cs.GT, cs.IT, math.IT |

General rule (coordination §4.4): a concept is owned by the campaign of the *prerequisite theory*,
in the most general form all consumers need; "arithmetic X" stays a consumer of X.

## Pre-decided owners for concepts several phase-1 reports proposed

Each planner must respect these; if you disagree, say so in your report's open-questions
section, but plan as decided.

| Concept / proposed roadmap(s) | Owner | Notes |
|---|---|---|
| Measure-preserving systems, ergodic theorems, entropy, mixing, thermodynamic formalism, smooth ergodic theory, Pesin theory | PRDS | one ErgodicTheory umbrella; NT's ProbabilisticAndMetricNumberTheory consumes it |
| Homogeneous dynamics (unipotent flows, Ratner, measure rigidity) | PRDS | consumes ALG's lattices |
| Markov chains and mixing times | PRDS | consumed by COMB and LTCS |
| Brownian motion, stochastic calculus, SDE/SPDE | PRDS | |
| Concentration inequalities, functional inequalities, large deviations | PRDS | |
| Percolation, Gibbs measures, spin glasses, SLE, GFF, random graphs | PRDS | even when the source paper is math-ph |
| Quantum spin systems, many-body quantum mechanics, quantum information theory, axiomatic QFT | FAMP | |
| Quantum computation (as computation) | LTCS | |
| Schrödinger operators (deterministic and random), spectral theory of unbounded operators | FAMP | |
| C*-algebras, von Neumann algebras, group von Neumann algebras, II₁ factors, free probability, operator K-theory | FAMP | |
| Banach space geometry (linear and nonlinear) | FAMP | LTCS's metric embeddings consume it |
| Real harmonic analysis, singular integrals, time-frequency, Fourier restriction, decoupling, Kakeya | ANA | |
| Geometric measure theory (rectifiability, currents, varifolds as objects, finite perimeter), fractal dimension theory | ANA | GEO's minimal-submanifold theory consumes it |
| Several complex variables, pluripotential theory, positive currents, Lelong numbers, Oka theory, univalent functions, quasiconformal maps | ANA | |
| Nonlinear elliptic/parabolic PDE, calculus of variations, dispersive, kinetic, fluid PDE, conservation laws, Einstein *evolution* equations | ANA | |
| Elliptic operators on compact manifolds (Hodge theorem, Laplace–Beltrami spectrum, index-theory basics) | GEO | substrate for AG's Hodge theory and for spectral geometry |
| Riemannian comparison geometry, Gromov–Hausdorff limits, minimal submanifolds, geometric flows, Kähler–Einstein and Calabi–Yau *metrics*, Lorentzian geometry and causality, convex geometry (Brunn–Minkowski, Mahler), symplectic and contact geometry, pseudoholomorphic curves | GEO | |
| Complex analytic spaces, Kähler manifolds and Hodge theory, variations of Hodge structure, Mumford–Tate groups, surfaces, K3/hyperkähler, Fano/rational curves | AG | |
| Birational geometry (pairs, singularities, positivity, vanishing, MMP, K-stability), moduli (stacks, GIT, good moduli, stable curves), intersection theory and Chow groups, algebraic Gromov–Witten and virtual classes, derived categories and stability, D-modules, perverse sheaves, character varieties | AG | |
| Scheme/stack foundations, étale and p-adic cohomology, motives | AG | coordinate with the Birkbeck campaign lanes (coordination §3.3) |
| Motivic homotopy, chromatic homotopy, ring spectra, classifying spaces, algebraic K-theory | TOP | |
| Mapping class groups, Teichmüller theory, hyperbolic 3-manifolds, knot homologies (Khovanov), Heegaard Floer | TOP | |
| Hyperbolic groups, CAT(0)/nonpositive curvature, growth, amenability and property (T) of groups, lattices in Lie groups, Artin groups, combinatorial group theory, group rings | ALG | FAMP consumes amenability for C*-algebras |
| Representations of p-adic groups (Hecke algebras, types, supercuspidals), Springer theory, Deligne–Lusztig, Coxeter groups, Kazhdan–Lusztig, Soergel bimodules, Kac–Moody and affine Lie algebras, vertex algebras, tensor categories, Grothendieck–Teichmüller | ALG | Birkbeck's SmoothRepresentationsOfLocalGroups is the math.RT seed |
| Commutative algebra (Cohen–Macaulay, multiplicities, free resolutions), noncommutative ring theory, homological dimensions, tilting | ALG | |
| Expander graphs, Boolean function analysis, probabilistic method, extremal/structural graph theory, Ramsey theory, matroids, polyhedral combinatorics, symmetric functions, designs, discrete geometry and incidences | COMB | |
| Models of computation, complexity classes, hardness of approximation, PCP, circuit/algebraic complexity, algorithms, metric embeddings and convex relaxations (as algorithms), automata, descriptive complexity | LTCS | |
| Shannon information theory, coding beyond AlgebraicCodingTheory | LTCS | |
| Set theory, forcing, descriptive set theory, Borel reducibility, model theory, computability | LTCS | |
| LMFDB object and label semantics (LMFDBLabelsAndCompleteness and the per-object LMFDB roadmaps) | NT | an "LMFDB lane" inside NT |
