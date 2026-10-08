# OpenAI release: probability, statistical mechanics, mathematical physics. Prerequisite plan

Share of goal 3 (OpenAI, 2026-10-06 release). It covers the families whose `subject` is "Probability and statistical mechanics" (#211–#239) or "Mathematical physics" (#260–#284) in `expansion_plan/work/openai_families.json`. The needs file is `needs_openai_probability_physics.jsonl`, with 231 lines.

**Method.**
- I read every family summary and abstract.
- I read 51 manuscripts (introduction, preliminaries, main statements, cited inputs), covering 48 of the 54 families. #218, #226, #232, #233, #236 and #237 are classified from their abstracts, plus the Lean doc page for #218, #236 and #237.
- I surveyed the OAI Lean tree (`lean/OAI/Probability`, `lean/OAI/MathematicalPhysics`, and the quantum/relativity directories elsewhere) and the family pages under `lean/docs/`.
- Supply checks were run against Tau Ceti main (roadmaps and code at a91d3aafa), all open TauCetiRoadmap PRs, the Birkbeck campaign index, and Mathlib 6b7abb3c.

## (a) Statistics

| | Probability & stat. mech. | Mathematical physics | Total |
|---|---|---|---|
| Families | 29 | 25 | 54 |
| Manuscripts | 105 | 59 | 164 |
| Manuscripts flagged `formalized` in the index | 11 (8 families) | 7 (6 families) | 18 |
| Families with a `lean/docs/NNN.md` page (comparator statements) | 19 | 17 | 36 |
| Families classified `elementary` | 0 | 1 | 1 |
| Families classified `needs …` (reducible to roadmaps) | 10 | 16 | 26 |
| Families classified `frontier` | 19 | 8 | 27 |

**Observations.**
- **The Birkbeck campaign is irrelevant to this share.** Its only probability roadmap is ProbabilisticAndMetricNumberTheory (11K).
- **Tau Ceti main has four probability roadmaps:** StandardDistributions, Exchangeability, DenseGraphLimits and OptimalTransport. None of them reaches what these papers use.
- **Four open PRs matter:**
  - RandomMatrices #397. Its Milestone 10 includes Itô calculus, but only for Dyson Brownian motion.
  - PointProcesses #417: Poisson processes, Mecke, Palm, Voronoi.
  - OperatorTheory #126: unbounded self-adjoint operators, Kato–Rellich, Stone.
  - SchurWeyl (on main) supplies Specht modules.
- **Every other cluster below is a gap.** That includes all of stochastic calculus, percolation, Gibbs measures, spin glasses, SLE/GFF, quantum information, many-body quantum mechanics and relativity. The explorer already lists "Stochastic processes and stochastic calculus" as uncovered.
- **The `formalized` flag undercounts the Lean.** 36 families have comparator statements. These are often supporting lemmas rather than main theorems, though; for example, #211 formalizes only the q>4 CRT limit and #222 only the spherical formula and a finiteness lemma.
- **Research-level inputs drive the frontier count.** Recent research papers enter as black boxes: Hutchcroft for #213/#214; Duminil-Copin et al. 2017–2026 for #223/#225; Huang–Yau and Landon–Sosoe–Yau for #219; Lopatto 2026 for #217; Panchenko and Mourrat for #222; CKLW, Huang and Gui for #280.
- **Unrefereed OpenAI companion preprints are used as premises** in #215, #216, #227 (cutoff rests on the companion gap), #260, #264 and #267.
- **Six families rest on computer certificates:** #222, #229, #266, #268, #269 and #272.

## (b) Prerequisite clusters and coverage

The coverage column gives the strongest existing owner. "→" means a new roadmap is proposed in §(c); "cross-share" means the roadmap probably belongs to another subject's plan (listed at the end of §(c)). The level column says whether a cluster is needed for statements (S), proofs (P) or both.

| Cluster | Families | arXiv | Level | Coverage | Owner / proposal |
|---|---|---|---|---|---|
| Markov chains: stationarity, renewal, generators, Dirichlet forms, TV mixing, coupling, spectral gap, cutoff, Glauber dynamics | 220 227 238 | math.PR | S+P | gap (Tau Ceti has the path law only) | → MarkovChainsAndMixing |
| Random walks on finite groups (Diaconis–Shahshahani) over S_n representations | 238 265 | math.PR / math.RT | P | S_n reps: tauceti-roadmap; DS lemma: gap | SchurWeyl; → MarkovChainsAndMixing |
| Concentration, Poincaré/log-Sobolev, hypercontractivity, Gaussian IBP and comparison, Brascamp–Lieb, Talagrand, matrix Bernstein | 217 219 221 227 234 235 238 239 261 283 | math.PR | P | gap (Mathlib sub-Gaussian; Tau Ceti McDiarmid) | → ConcentrationAndFunctionalInequalities |
| Weak convergence, Prokhorov, Skorokhod | 211 218 223 230 | math.PR | S+P | mathlib (Skorokhod absent) | Mathlib; Skorokhod → BrownianMotion |
| Poisson point processes, Mecke, Voronoi, Palm | 219 224 235 271 | math.PR | S+P | open-pr | PointProcesses #417 |
| Brownian motion: strong Markov, reflection, LIL, Donsker, bridges/excursions, planar potential theory, Feynman–Kac | 211 220 230 267 | math.PR | P | mathlib partial (`IsBrownianReal`, Kolmogorov) | → BrownianMotion |
| Stochastic calculus: semimartingales, Itô, Girsanov, Dubins–Schwarz/Knight, SDEs, Bessel; Föllmer drift, filtering, stochastic localization | 211 219 222 223 227 230 231 | math.PR | P | open-pr partial (#397 M10) | → StochasticCalculus |
| Bernoulli percolation: FKG/BK/Russo/OSSS, sharpness, uniqueness, planar RSW/arms, p_u | 212 213 214 224 236 267 | math.PR | S+P | gap | → BernoulliPercolation |
| Transitive graphs, mass transport, unimodularity, random walks and networks, UST/USF, Galton–Watson, tree broadcast, strongly Rayleigh/DPP | 211 213 214 229 231 236 271 | math.PR | S+P | gap (#397/#417 determinantal kernels only) | → ProbabilityOnTreesAndNetworks |
| Amenability, Cheeger, Kesten criterion; Gromov/Trofimov polynomial growth | 213 214 | math.GR | P | oai-lean (external `Aaron1011/gromov`) | → AmenableGroupsAndGrowth (cross-share) |
| Sparse random graphs, local weak limits, random k-SAT, SBM | 219 229 231 235 | math.PR | S | gap (Mathlib `binomialRandom` only) | → RandomGraphsAndConstraintSatisfaction |
| Random media: FPP shape theorem and Busemann functions; RWRE regeneration and 0–1 laws | 212 220 | math.PR | S | gap | → RandomMedia |
| Kingman subadditive theorem; factors of IID | 212 220 228 231 236 | math.DS | S+P | gap (Tau Ceti Birkhoff L^p only) | → ErgodicTheory (cross-share) |
| Random trees, Aldous CRT, GHP, planar-map bijections | 211 | math.PR | S | gap (Mathlib has Gromov–Hausdorff space) | → RandomTreesAndMaps |
| Wigner/GOE, Haar conjugation, free probability, Marchenko–Pastur | 219 222 227 234 239 | math.PR | S+P | open-pr | RandomMatrices #397 |
| Local laws, DBM universality, Sine₁ | 219 | math.PR | P | open-pr partial; remainder frontier | #397 (excludes universality) |
| Loewner chains, SLE_κ, CLE, convergence of curves | 211 218 223 226 230 232 | math.PR | S | gap | → SchrammLoewnerEvolution |
| Conformal boundary behavior: Carathéodory, prime ends, Koebe, kernel theorem | 224 230 | math.CV | P | tauceti-roadmap partial (ConformalMapping) | → GeometricFunctionTheory (cross-share) |
| Hausdorff gauges, Frostman, Minkowski content | 223 230 | math.CA | S | mathlib partial (`mkMetric`) | → FractalGeometry (cross-share) |
| Gaussian free field, local sets, GMC/LQG | 211 216 223 225 226 232 233 | math.PR | S | gap | → GaussianFreeField |
| Negative-order Sobolev/Besov spaces | 216 225 | math.AP | S | mathlib partial; PDE roadmap | → RealHarmonicAnalysis (cross-share) |
| Lattice random walks: LCLT, Green function, Beurling, LERW; discrete complex analysis; self-avoiding walk | 211 218 223 224 237 | math.PR | P | gap | → LatticeRandomWalks |
| Lattice Gibbs measures: DLR, pressure, GKS/Ginibre/FKG/Lee–Yang, FK and Edwards–Sokal, Peierls, reflection positivity, O(n)/XY duality, transfer operators | 211 215 216 218 223 225 232 233 236 237 | math.PR / math.MP | S+P | gap | → LatticeGibbsMeasures |
| Dimers (Kasteleyn, Temperley), Kac–Ward, six-vertex and Bethe ansatz, BKW | 218 223 225 226 233 | math.MP | S+P | gap | → IntegrableLatticeModels |
| Mean-field spin glasses: Guerra, ASS, RPC, GG, ultrametricity, Parisi functional, diluted models, TAP/AMP | 217 221 222 227 234 235 281 | math.PR | S+P | gap | → MeanFieldSpinGlasses |
| Classical continuum particle systems (stability, thermodynamic limit) | 228 | math.MP | S | open-pr partial (#417 GNZ) | → ContinuumGibbsSystems |
| Classical information theory (entropy, Fano, Pinsker, Shearer) | 213 220 229 277 | cs.IT | P | mathlib partial (KL, binary entropy) | → ShannonInformationTheory (cross-share) |
| Schrödinger operators: forms, min–max, essential spectrum, spectral types, rank-one perturbation, HVZ, Agmon, IMS, Lieb–Thirring | 261 262 263 267 270 275 278 | math.SP | S+P | open-pr partial (#126) | → SchrodingerOperators |
| Matrix analysis (operator means, trace inequalities) | 262 273 276 277 283 | math.FA | P | open-pr partial (#126) | OperatorTheory #126 |
| Random Schrödinger operators (Wegner, fractional moments, Simon–Wolff) | 219 261 | math.MP | S | gap | → RandomSchrodingerOperators |
| N-body QM, Thomas–Fermi, stability of matter, Fock space/CCR/CAR, Bose gas, lowest Landau level | 263 267 269 273 275 278 | math.MP | S+P | gap (Tau Ceti has the algebraic fermionic Fock model only) | → ManyBodyQuantumMechanics |
| Quantum spin systems, Lieb–Robinson, KMS, area laws, MPS/PEPS, Heisenberg | 265 268 271 | math.MP | S | gap (Mathlib C*-algebras) | → QuantumSpinSystems |
| Quantum information: states, channels, entanglement, entropies, HSW/capacities, bosonic channels, MUBs | 265 266 272 273 276 277 | math.MP / cs.IT | S | mathlib partial (`CompletelyPositiveMap`) | → QuantumInformationTheory |
| Quantum circuits, BQP/QMA, local Hamiltonians, query complexity, nonlocal games | 274 275 277 279 281 283 284 | cs.CC | S | gap (#258/#259 are quantum walks) | → QuantumComputation (shared with TCS) |
| Boolean-function analysis | 274 284 | cs.CC | P | gap | → BooleanFunctionAnalysis (cross-share) |
| Lorentzian causality, initial data sets, ADM mass, MOTS, PMT/Penrose statements | 260 264 | math.DG | S | gap | → MathematicalRelativity |
| Riemannian hypersurface geometry (scalar/mean curvature) | 260 | math.DG | S | tauceti-roadmap partial | → RiemannianGeometry (cross-share) |
| Elliptic regularity, geometric measure theory | 260 278 | math.AP | P | tauceti-roadmap partial (PDE) | PDE + cross-share |
| Einstein Cauchy problem, Kerr stability | 264 | math.AP | P | gap | frontier |
| OS/Wightman/Haag–Kastler axioms, conformal nets | 215 280 282 | math.MP | S | gap | → AxiomaticQuantumFieldTheory |
| Tomita–Takesaki modular theory | 280 282 | math.OA | P | mathlib partial (vN algebra definition) | → VonNeumannAlgebras (cross-share) |
| Vertex operator algebras, modular tensor categories | 280 | math.QA | S | mathlib partial (`Algebra/Vertex`); #57 | → VertexOperatorAlgebras (cross-share) |
| Certified exact/interval computation | 222 229 266 268 269 272 | math.NA | P | gap | computation shares |
| Geometry of numbers, discriminant forms, reverse Minkowski | 239 | math.NT | P | tauceti-roadmap (IntegralLattices) | reverse Minkowski is a research input |

## (c) Proposed roadmaps

**Tiers:**
- **Tier 1:** broad demand, textbook-level, highly formalizable.
- **Tier 2:** clear demand, but sits above Tier 1.
- **Tier 3:** few families, or mostly statement-level for frontier work.

Each entry is written in the voice of a roadmap's opening paragraph.

### Tier 1

**MarkovChainsAndMixing** (math.PR; L)
- **Scope.** This roadmap develops Markov chains on countable and finite state spaces. It starts from the path law Tau Ceti already builds (`Probability/Process/MarkovChain`) and reaches the quantitative theory of convergence to equilibrium:
  - recurrence and transience, stationary laws, the convergence and ergodic theorems for chains;
  - renewal and regenerative processes;
  - continuous-time chains from generators;
  - reversibility and Dirichlet forms;
  - mixing: total-variation distance, coupling, strong stationary times, spectral gap and relaxation time, comparison of discrete and continuous clocks, and cutoff;
  - Glauber (heat-bath) dynamics of finite Gibbs measures;
  - random walks on finite groups through the Diaconis–Shahshahani upper-bound lemma.

  Log-Sobolev and hypercontractivity belong to ConcentrationAndFunctionalInequalities.
- **Objects:** `tvDist`, `mixingTime`, couplings of chains, Q-matrices/generators, Dirichlet form, relaxation time, the heat-bath kernel of a finite spin system, random walk on a finite group.
- **Headlines:**
  - convergence theorem for irreducible aperiodic chains;
  - renewal theorem and renewal SLLN, including infinite mean;
  - t_mix ≤ t_rel·log(4/π_min) and the matching lower bound;
  - the coupling inequality;
  - the Diaconis–Shahshahani lemma, with random-transposition cutoff at ½ n log n;
  - lazy hypercube cutoff;
  - Dobrushin/path-coupling O(n log n) mixing for high-temperature Glauber dynamics.
- **Prerequisites:** Mathlib kernels and Ionescu–Tulcea; Tau Ceti Markov path law; SchurWeyl (Specht modules) for the group layer.
- **Families:** 227 (8 manuscripts), 238 (12), 220.
- **Formalizability:** high (Levin–Peres–Wilmer, Norris). OAI defines `totalVariation` about 30 times and `mixingTime` about 15 times; one API removes that duplication.

**ConcentrationAndFunctionalInequalities** (math.PR; L)
- **Scope.** This roadmap develops concentration of measure and the functional inequalities behind it, for product, Gaussian and log-concave measures:
  - the variance and entropy methods: Efron–Stein, tensorization, the Herbst argument;
  - Talagrand's convex-distance inequality;
  - Gaussian integration by parts and the Gaussian Poincaré and log-Sobolev inequalities;
  - Gaussian concentration of Lipschitz functions;
  - Slepian, Sudakov–Fernique and Gordon comparison;
  - Prékopa–Leindler and Brascamp–Lieb;
  - the Bakry–Émery criterion;
  - hypercontractivity of the Ornstein–Uhlenbeck semigroup and of the discrete cube;
  - matrix Bernstein and Khintchine inequalities.

  Mixing of chains is MarkovChainsAndMixing; spectral-norm bounds for structured random matrices stay in RandomMatrices.
- **Headlines:** Efron–Stein; Gross's Gaussian log-Sobolev; Tsirelson–Ibragimov–Sudakov; Sudakov–Fernique; Talagrand's convex distance; Prékopa–Leindler; the Brascamp–Lieb variance inequality; Bakry–Émery; Bonami–Beckner; Tropp's matrix Bernstein.
- **Prerequisites:** Mathlib Gaussian measures and sub-Gaussian API; Tau Ceti McDiarmid; OneParameterSemigroups; OperatorTheory #126 for matrix functions.
- **Families:** 217 219 221 227 234 235 238 239 261 283 (10 families, 35 manuscripts), plus broad cross-share use.
- **Formalizability:** high (Boucheron–Lugosi–Massart). OAI `SKGap/Gaussian` rebuilds Gaussian IBP locally.

**BernoulliPercolation** (math.PR; L)
- **Scope.** This roadmap develops Bernoulli bond and site percolation on locally finite graphs. One graph encoding with multi-edges carries:
  - the product measures and the monotone coupling; clusters, θ(p), χ(p), p_c and p_u;
  - Harris–FKG, BK and Reimer, Russo–Margulis, the OSSS inequality;
  - sharpness of the transition, by the Duminil-Copin–Tassion argument;
  - uniqueness on amenable transitive graphs (Burton–Keane), Newman–Schulman's 0/1/∞, Häggström–Peres monotonicity of uniqueness;
  - the planar theory on ℤ² and the triangular lattice: duality, RSW, Kesten's p_c = ½, θ(p_c) = 0, arm events and quasi-multiplicativity.
- **Headlines:** Harris–FKG; BK; Russo's formula; OSSS; Duminil-Copin–Tassion sharpness on transitive graphs; Burton–Keane; Newman–Schulman; Harris–Kesten; RSW.
- **Prerequisites:** Mathlib infinite product measures; ProbabilityOnTreesAndNetworks (mass transport) for transitive graphs.
- **Families:** 212 213 214 224 236 267. The ℤ³ part of #213 is formalized in OAI.
- **Formalizability:** high (Grimmett; Duminil-Copin's lecture notes). The #213 paper cites external Lean developments of θ(p_c)=0 on ℤ^d, d ≥ 2: Leder (Aug 2026, `anthropics/formal-math/percolation`) and a Sept 2026 site-percolation development. I have not checked either; both are porting candidates.

**ProbabilityOnTreesAndNetworks** (math.PR; L–XL)
- **Scope.** This roadmap follows Lyons–Peres. It develops:
  - random walks on infinite graphs as electrical networks: effective resistance, Rayleigh monotonicity, the Thomson and Dirichlet principles, Nash-Williams, transience criteria;
  - uniform spanning trees and forests: Kirchhoff, Wilson's algorithm, the transfer-current theorem, wired and free USF;
  - Galton–Watson trees and branching processes: extinction, Kesten–Stigum, size-biased trees, branching number, percolation and biased walks on trees;
  - broadcasting and reconstruction on trees, with the Kesten–Stigum bound;
  - transitive graphs: Aut(G) as a locally compact group, Haar measure, unimodularity, the mass-transport principle, Kesten's amenability criterion;
  - unimodular random graphs;
  - determinantal and strongly Rayleigh measures.
- **Headlines:** Rayleigh monotonicity; Pólya via resistance; the matrix-tree theorem; Wilson's algorithm; Burton–Pemantle; WUSF = FUSF on amenable graphs; Kesten–Stigum; Lyons's br(T) theorems; Evans–Kenyon–Peres–Schulman; the mass-transport principle; Kesten's criterion; Lyons's DPP existence; Borcea–Brändén–Liggett negative association.
- **Prerequisites:** Mathlib Haar measure and `SimpleGraph`; MarkovChainsAndMixing for chain basics.
- **Families:** 211 213 214 229 231 236 271.
- **Formalizability:** high.

**LatticeGibbsMeasures** (math.PR / math.MP; XL)
- **Scope.** This roadmap follows Friedli–Velenik and Georgii. It develops lattice spin systems with general single-spin spaces:
  - finite-volume Gibbs measures, specifications and the DLR equations; existence by compactness, extremal decomposition, translation-invariant states;
  - the pressure and its van Hove thermodynamic limit;
  - the Ising, Potts, O(n), XY/Villain and discrete Gaussian models;
  - correlation inequalities: GKS, Ginibre, FKG, Lee–Yang;
  - the random-cluster model, Edwards–Sokal, comparison inequalities, planar duality and the self-dual point;
  - the random-current representation;
  - Peierls; reflection positivity, chessboard estimates and infrared bounds; Mermin–Wagner;
  - Dobrushin uniqueness;
  - transfer matrices and the mass, defined by subadditivity;
  - spin/height duality for XY/Villain;
  - gradient models and height functions as definitions;
  - as top layer, FK box-crossing estimates for q ≤ 4.

  If size demands, split along "general theory and classical models" versus "FK, random currents and planar FK".
- **Headlines:** existence and extremal decomposition of DLR states; GKS/Ginibre; FKG; Lee–Yang; Edwards–Sokal; Peierls for Ising (d ≥ 2); the Fröhlich–Simon–Spencer phase transition for O(n) in d ≥ 3; Mermin–Wagner; Dobrushin uniqueness; Aizenman's random-current continuity for Ising; the self-dual point p_c = √q/(1+√q) for FK on ℤ² (q ≥ 1).
- **Prerequisites:** BernoulliPercolation; Mathlib product measures and compactness of probability measures.
- **Families:** 211 215 216 218 223 225 232 233 236 237 (10 families, 49 manuscripts).
- **Formalizability:** high for the classical core; the planar FK layer is lecture-note level.

**MeanFieldSpinGlasses** (math.PR; L)
- **Scope.** This roadmap follows Talagrand and Panchenko. It develops:
  - the SK and mixed p-spin models;
  - Gaussian interpolation and Guerra's broken-replica bound; the Aizenman–Sims–Starr scheme;
  - Ruelle probability cascades;
  - Ghirlanda–Guerra identities by perturbation, the Dovbysh–Sudakov representation, Panchenko's ultrametricity;
  - the Parisi formula;
  - the Parisi functional: Auffinger–Chen strict convexity and uniqueness, the zero-temperature formula;
  - spherical models and the Crisanti–Sommers formula;
  - the replica-symmetric regime, TAP equations and AMP state evolution;
  - diluted models (Franz–Leone bounds) and perceptron definitions.
- **Headlines:** Guerra's bound; Talagrand–Panchenko's Parisi formula; ultrametricity; Auffinger–Chen uniqueness; Crisanti–Sommers; Franz–Leone; Bolthausen's AMP convergence.
- **Prerequisites:** ConcentrationAndFunctionalInequalities; StochasticCalculus (for the control representation only).
- **Families:** 217 221 222 227 234 235 281.
- **Formalizability:** high for Panchenko's book; frontier above it (the Mourrat Hamilton–Jacobi approach and Lopatto's support results).

**BrownianMotion** (math.PR; L)
- **Scope.** This roadmap follows Mörters–Peres, starting from Mathlib's `IsBrownianReal`. It develops:
  - multidimensional Brownian motion with continuous paths, via Kolmogorov–Chentsov;
  - the Markov and strong Markov properties, Blumenthal's 0–1 law, the reflection principle;
  - the LIL, Lévy's modulus, nowhere differentiability;
  - Brownian bridge and excursions;
  - Donsker's invariance principle and Skorokhod embedding;
  - potential theory: Kakutani's solution of the Dirichlet problem, harmonic measure, recurrence by dimension, Green functions;
  - Lévy's conformal invariance of planar Brownian motion;
  - Feynman–Kac for killed motion;
  - Hausdorff dimension of the range and the zero set.
- **Headlines:** strong Markov; the reflection principle; Khinchin's LIL; Lévy's modulus; Donsker; Skorokhod embedding; Kakutani; conformal invariance; dim B[0,1] = 2 in d ≥ 2.
- **Prerequisites:** Mathlib Brownian motion and Kolmogorov; FractalGeometry (cross-share) for the dimension layer.
- **Families:** 220 230 267, and every SLE/LQG family through SchrammLoewnerEvolution.
- **Formalizability:** high. OAI `SLE/BrownianStrongMarkov` and `StrongRayleigh/{PreBrownianExistence,BrownianKolmogorov}` are porting candidates.

**StochasticCalculus** (math.PR; L)
- **Scope.** This roadmap follows Le Gall and Revuz–Yor. It develops:
  - continuous-time martingales and stopping, extending Mathlib's discrete-time theory;
  - local martingales and quadratic variation;
  - the Itô integral against continuous semimartingales, and the multidimensional Itô formula;
  - Lévy's characterization, Dubins–Schwarz and Knight, Burkholder–Davis–Gundy;
  - Girsanov with Novikov's criterion;
  - Lipschitz SDEs (strong existence, uniqueness, Markov property);
  - Bessel processes;
  - stochastic Fubini;
  - as top layer, the Föllmer drift and Boué–Dupuis formula, and the innovations theorem of nonlinear filtering.

  The roadmap is the intended consumer-side owner of the Itô calculus that RandomMatrices #397 M10 needs. The explorer lists this area as uncovered.
- **Headlines:** Itô isometry and formula; Lévy; Dubins–Schwarz; BDG; Girsanov; strong solutions of Lipschitz SDEs; squared-Bessel comparison; Boué–Dupuis.
- **Prerequisites:** BrownianMotion; Mathlib martingales and filtrations.
- **Families:** 211 219 222 223 227 230 231 (30 manuscripts).
- **Formalizability:** high. The OAI SLE directory builds `ItoIsometry`, `StochasticIntegrals` and `StochasticFubini` ad hoc.

**SchrodingerOperators** (math.SP; L)
- **Scope.** This roadmap consumes OperatorTheory #126's unbounded self-adjoint theory. It develops:
  - closed semibounded forms, KLMN and the Friedrichs extension;
  - min–max and Dirichlet–Neumann bracketing;
  - discrete and essential spectrum, Weyl's criterion and relative compactness;
  - the Lebesgue decomposition of spectral measures into pp, ac and sc parts, and RAGE;
  - rank-one perturbations (Aronszajn–Donoghue, Simon–Wolff) and Herglotz boundary values;
  - Kato analytic perturbation;
  - Schrödinger operators −Δ+V on ℝ^d and on graphs: Hardy and Sobolev form bounds, Combes–Thomas and Agmon decay, IMS localization, HVZ;
  - Birman–Schwinger, CLR and Lieb–Thirring inequalities;
  - positivity of ground states.
- **Headlines:** KLMN; min–max; Weyl's criterion; RAGE; Simon–Wolff; Kato–Rellich applications to Coulomb operators; HVZ; Agmon decay; CLR; Lieb–Thirring with Rumin's proof.
- **Prerequisites:** #126 SelfAdjointSpectralTheory; PDE (Sobolev); Tau Ceti Fredholm.
- **Families:** 261 262 263 267 270 275 278.
- **Formalizability:** high (Teschl, Reed–Simon, Lieb–Loss). OAI `Analysis/LiebThirring/{SchrodingerOperator,QuadraticForms,DiscreteSpectrum}` are porting candidates.

**QuantumInformationTheory** (math.MP; secondary cs.IT, math.OA; L–XL)
- **Scope.** This roadmap follows Watrous, Wilde and Holevo. It develops:
  - states and effects on finite-dimensional Hilbert spaces, partial trace;
  - CP and CPTP maps (Kraus, Stinespring, Choi–Jamiołkowski), measurements and instruments;
  - trace distance and fidelity (Uhlmann, Fuchs–van de Graaf);
  - separability, PPT and range criteria; entanglement-breaking channels; LOCC as a formal protocol class;
  - von Neumann and Umegaki relative entropy, Klein's inequality, strong subadditivity, Lieb concavity, data processing, Fannes–Audenaert/AFW continuity;
  - majorization and Nielsen's theorem; mutually unbiased bases;
  - a Shannon layer: typical subspaces, the Holevo bound, HSW, Holevo and regularized capacity, minimum output entropy;
  - a continuous-variable layer: bosonic modes, coherent/thermal/Gaussian states, beam splitters and attenuators.
- **Headlines:** Stinespring; Choi; Peres–Horodecki; Lieb–Ruskai SSA; data processing; Holevo bound; HSW; Nielsen's theorem.
- **Prerequisites:** Mathlib `CompletelyPositiveMap`, CFC, KL divergence; #126 Majorization; ManyBodyQuantumMechanics (analytic Fock space) for the bosonic layer.
- **Families:** 265 266 272 273 276 277.
- **Formalizability:** high. OAI `InformationTheory/AmplitudeDamping/{Holevo,Naimark,Pinching,TypicalProjectors}` are porting candidates.

### Tier 2

**SchrammLoewnerEvolution** (math.PR; secondary math.CV; L)
- **Scope.** This roadmap follows Lawler and Kemppainen. It develops:
  - the chordal and radial Loewner equations, half-plane capacity and hydrodynamic normalization;
  - Loewner chains driven by continuous functions; SLE_κ;
  - the conformal Markov characterization;
  - phases via Bessel processes;
  - the Rohde–Schramm trace (κ ≠ 8);
  - locality (κ = 6), restriction (κ = 8/3), SLE(κ,ρ);
  - the one-point Green function and the dimension upper bound 1+κ/8;
  - the space of curves modulo reparametrization, Kemppainen–Smirnov tightness and Carathéodory kernel convergence;
  - Cardy's formula for SLE₆;
  - CLE and imaginary-geometry definitions (statement level).
- **Prerequisites:** StochasticCalculus; BrownianMotion; ConformalMapping; GeometricFunctionTheory (Koebe, prime ends; cross-share).
- **Families:** 211 218 223 226 230 232 (25 manuscripts). Every main theorem in these families is frontier, but all of them need this roadmap to be stated.
- **Formalizability:** medium-high. OAI `Probability/SLE/Loewner/*` has capacity and hydrodynamic lemmas.

**GaussianFreeField** (math.PR; L)
- **Scope.** This roadmap develops:
  - the discrete GFF on graphs: Markov property, random-walk representation;
  - the continuum Dirichlet GFF as a random distribution in H^{-s}_loc, with its Cameron–Martin space H¹₀;
  - domain Markov decomposition, circle averages and thick points;
  - convergence of lattice GFFs to the continuum field; the whole-plane GFF modulo constants;
  - Gaussian multiplicative chaos (Kahane; Berestycki's proof), the Liouville measure and quantum-sphere definitions;
  - local sets and level lines at statement level, with the Schramm–Sheffield SLE₄ coupling.
- **Prerequisites:** Mathlib Gaussian processes and distributions; PDE (Dirichlet Green function); RealHarmonicAnalysis (cross-share) for negative-regularity topologies.
- **Families:** 211 216 223 225 226 232 233.
- **Formalizability:** medium-high.

**LatticeRandomWalks** (math.PR; L)
- **Scope.** This roadmap develops:
  - simple random walk on ℤ^d and planar lattices as potential theory, following Lawler–Limic: the LCLT with error terms, Green function and potential-kernel asymptotics, gambler's ruin, harmonic measure, the Beurling estimate, loop-erased walk;
  - discrete complex analysis: discrete harmonic and holomorphic functions on square and isoradial lattices, discrete Cauchy and Green formulas, Harnack, convergence of discrete Poisson kernels and harmonic measure (the Chelkak–Smirnov toolbox), s-holomorphicity;
  - self-avoiding walk: connective constant, Hammersley–Welsh, bridges, and the Duminil-Copin–Smirnov honeycomb constant via the parafermionic observable.
- **Families:** 211 218 223 224 237.
- **Formalizability:** high.

**RandomTreesAndMaps** (math.PR; L)
- **Scope.** This roadmap develops:
  - plane trees and size-conditioned Galton–Watson and simply generated trees;
  - Łukasiewicz paths, contour and height functions, the cyclic lemma, the Vervaat transform;
  - convergence of conditioned walks to the Brownian excursion;
  - real trees coded by continuous functions, and Aldous's CRT theorem;
  - the Gromov–Hausdorff–Prokhorov topology on compact metric measure spaces;
  - planar maps: Tutte decomposition, and the Schaeffer/CVS and Mullin/Bernardi/Sheffield bijections;
  - the Brownian map theorem as a statement.
- **Prerequisites:** BrownianMotion (Donsker); Mathlib Gromov–Hausdorff space.
- **Families:** 211 (7 manuscripts; the q>4 CRT result is formalized in OAI `Probability/FKMaps`), plus cross-share combinatorics.
- **Formalizability:** high.

**RandomGraphsAndConstraintSatisfaction** (math.PR; secondary math.CO, cs.DM; L)
- **Scope.** This roadmap develops:
  - the Erdős–Rényi phase transition by branching comparison;
  - the configuration model and random regular graphs: simplicity probability, Poisson short cycles, switchings;
  - local weak (Benjamini–Schramm) convergence and unimodularity;
  - the Kesten–McKay law;
  - random k-SAT and k-XORSAT: first and second moments, Friedgut's sharp threshold, Franz–Leone and Bayati–Gamarnik–Tetali interpolation for existence of free-energy limits;
  - the stochastic block model and the Kesten–Stigum threshold, as statements.

  Coordinate with the combinatorics share's probabilistic-combinatorics plan.
- **Families:** 219 229 231 235.
- **Formalizability:** high.

**ManyBodyQuantumMechanics** (math.MP; L)
- **Scope.** This roadmap follows Lieb–Seiringer. It develops:
  - N-body spaces as symmetric and antisymmetric tensor powers with spin, and reduced density matrices;
  - bosonic and fermionic Fock space with CCR/CAR, number operators and quasi-free states;
  - Bargmann space and the lowest Landau level;
  - Coulomb Hamiltonians as closed forms;
  - Zhislin's theorem and Lieb's ionization bound;
  - the Lieb–Thirring kinetic-energy inequality and Lieb–Oxford;
  - Thomas–Fermi theory (Lieb–Simon) and stability of matter;
  - the dilute Bose gas: scattering length, Dyson lemma, Lieb–Yngvason energy, BEC definitions;
  - Bogoliubov quadratic Hamiltonians.
- **Prerequisites:** SchrodingerOperators; #126.
- **Families:** 263 267 269 273 275 278.
- **Formalizability:** medium-high.

**QuantumSpinSystems** (math.MP; L)
- **Scope.** This roadmap follows Nachtergaele–Sims–Young, Tasaki and Bratteli–Robinson II. It develops:
  - local Hamiltonians on ⊗ℂ^d and SU(2) spin operators;
  - spectral gaps of frustration-free models (Knabe, martingale method);
  - AKLT and matrix-product states with parent Hamiltonians;
  - the quasi-local C*-algebra on ℤ^d, Lieb–Robinson bounds, infinite-volume dynamics, KMS and ground states, thermodynamic limits of states;
  - entanglement entropy, the 1D area law and the detectability lemma;
  - Heisenberg models: Lieb–Mattis, Marshall sign, Dyson–Lieb–Simon infrared bounds, Lieb–Schultz–Mattis, random-loop representations.
- **Prerequisites:** QuantumInformationTheory (entropy); Mathlib C*-algebras.
- **Families:** 265 268 271.
- **Formalizability:** high for finite volume; medium for the C*-dynamics.

**QuantumComputation** (cs.CC; secondary math.MP; L; overlaps the TCS share)
- **Scope.** This roadmap develops:
  - the circuit model over gate sets and uniform families; universality and Solovay–Kitaev; Bennett reversibility;
  - the QFT, phase estimation and Shor's algorithm; Grover and amplitude amplification;
  - the diamond norm;
  - BQP and QMA with amplification; Kitaev's local-Hamiltonian theorem;
  - query complexity (polynomial and adversary methods; Forrelation);
  - QAC⁰;
  - nonlocal games (CHSH, Tsirelson, entangled value) and parallel-repetition statements.
- **Families:** 274 275 277 279 281 283 284.
- **Formalizability:** high.

### Tier 3

**RandomMedia** (math.PR; M)
- **Scope.** First-passage percolation on ℤ^d:
  - time constant via Kingman, the Cox–Durrett shape theorem, Kesten's concentration;
  - Busemann functions and geodesics.

  Random walk in random environment:
  - Solomon's 1D theory;
  - the Kalikow and Zerner–Merkl 0–1 laws;
  - Sznitman–Zerner regeneration and the LLN, ballisticity conditions;
  - the environment seen from the particle.
- **Prerequisites:** ErgodicTheory (cross-share); MarkovChainsAndMixing (renewal); BernoulliPercolation.
- **Families:** 212 220.

**ContinuumGibbsSystems** (math.MP; M)
- **Scope.** Classical particles in ℝ^d with pair potentials, following Ruelle:
  - stability and superstability;
  - canonical and grand-canonical partition functions; existence and convexity of thermodynamic limits; equivalence of ensembles by Legendre–Fenchel duality;
  - Mayer expansion at low activity; the Kac/Lebowitz–Penrose limit;
  - infinite-volume Gibbs point processes via DLR.

  It could instead become an extension of PointProcesses #417 once that merges.
- **Families:** 228 (formalized in OAI `Probability/{ContinuumTransition,RadialTransition}`), 267 partially.

**RandomSchrodingerOperators** (math.MP; M)
- **Scope.** Following Aizenman–Warzel:
  - ergodic operator families; Pastur's almost-sure spectrum and spectral types;
  - IDS; the Wegner estimate; Combes–Thomas;
  - fractional-moment localization at large disorder and band edges; Simon–Wolff; dynamical localization;
  - the Anderson model on trees (Klein) and 1D localization, as statements.
- **Prerequisites:** SchrodingerOperators.
- **Families:** 219 261. The two #261 results are self-contained modulo Teschl, so this is their whole gap.

**IntegrableLatticeModels** (math.MP; L)
- **Scope.**
  - The dimer model: Kasteleyn's Pfaffian theorem, the Temperley bijection, Kenyon's local statistics, double-dimer loops.
  - Planar Ising via Kac–Ward and Pfaffians; Onsager's free energy; Yang's magnetization.
  - The six-vertex model: ice rule and height function, transfer-matrix commutation via Yang–Baxter, the algebraic Bethe ansatz, Lieb's square-ice entropy.
  - The Baxter–Kelland–Wu correspondence and the Ashkin–Teller relation.
- **Families:** 218 223 225 226 233.

**MathematicalRelativity** (math.DG; secondary math.MP, math.AP; L)
- **Scope.**
  - Lorentzian manifolds, time orientation, causal structure, global hyperbolicity and Cauchy surfaces.
  - The Einstein and constraint equations for initial data sets (M, g, K); the dominant energy condition.
  - Asymptotically flat and hyperbolic ends; ADM energy–momentum (Bartnik's invariance).
  - The Schwarzschild, Reissner–Nordström, Kerr and Kerr–Newman families.
  - Null expansions, MOTS and trapped surfaces.
  - Statements of the positive mass theorem, the Riemannian Penrose inequality and the Choquet-Bruhat–Geroch maximal development.
- **Prerequisites:** RiemannianGeometry (cross-share); DifferentialGeometry.
- **Families:** 260 (13 manuscripts) and 264. All main theorems are frontier; this roadmap makes them statable.

**AxiomaticQuantumFieldTheory** (math.MP; secondary math.OA; L)
- **Scope.**
  - Schwinger functions, the OS axioms and OS reconstruction, including the lattice transfer-matrix version and the mass gap.
  - Källén–Lehmann.
  - The Wightman axioms and reconstruction; Reeh–Schlieder.
  - Haag–Kastler nets; Borchers' theorem and Bisognano–Wichmann as statements.
  - Conformal nets on S¹: Möbius covariance, DHR sectors, index.
- **Prerequisites:** VonNeumannAlgebras (Tomita–Takesaki; cross-share); LatticeGibbsMeasures for the lattice layer.
- **Families:** 215 280 282.

### Cross-share needs (registered in the JSONL; roadmap probably owned by another subject plan)

| Name | arXiv | Needed here for | Families |
|---|---|---|---|
| ShannonInformationTheory | cs.IT | entropy, Fano, Pinsker, Shearer, data processing (OAI defines `entropy` dozens of times) | 213 220 229 277 |
| BooleanFunctionAnalysis | cs.CC | Walsh expansion, influences, Bonami, polynomial approximation | 274 284 |
| AmenableGroupsAndGrowth | math.GR | Følner, Kesten criterion, Gromov/Trofimov (port `Aaron1011/gromov`) | 213 214 |
| ErgodicTheory | math.DS | Kingman's subadditive theorem, factors of IID | 212 220 228 231 236 |
| FractalGeometry | math.CA | gauge Hausdorff measures, Frostman, Minkowski content | 223 230 |
| GeometricFunctionTheory | math.CV | Koebe, area theorem, kernel theorem, prime ends | 224 230 |
| RealHarmonicAnalysis | math.CA | Besov/negative-order spaces, Calderón–Zygmund | 216 225 261 |
| RiemannianGeometry | math.DG | hypersurface geometry, scalar curvature | 260 |
| VonNeumannAlgebras | math.OA | Tomita–Takesaki, half-sided modular inclusions | 280 282 |
| VertexOperatorAlgebras | math.QA | VOA axioms, modules, Zhu algebra, rationality | 280 |
| LargeDeviations | math.PR | Laplace principle / Boué–Dupuis (only direct use here: 222) | 222 |

## (d) Family-by-family classification

`elementary` means Mathlib plus a short special-purpose development. `needs X` means the proofs reduce to the named roadmaps plus paper-specific argument. `frontier` names the research-level theory that a roadmap would not reasonably contain. "Lean" marks a `lean/docs/NNN.md` page.

| # | Short title | arXiv primary | Mss | Lean | Classification | Key statement-level needs |
|---|---|---|---|---|---|---|
| 211 | The geometric phase diagram, diffusion, and spectra of random… | math.PR | 7 | yes | frontier (LQG metric, mating of trees, CLE on LQG); the q>4 CRT result needs RandomTreesAndMaps | planar maps, FK weights, GHP, Brownian CRT, LQG sphere/metric, Liouville BM |
| 212 | Planar first-passage geometry and the absence of bigeodesics | math.PR | 2 | yes | frontier (Ahlberg-Hoffman coalescing geodesics) | FPP, shape theorem, Busemann functions |
| 213 | Critical percolation on every quasi-transitive graph | math.PR | 2 | yes | frontier (Hutchcroft theta(p_c)=0 under exponential growth; Tessera-Tointon); the Z^3 result needs BernoulliPercolation | quasi-transitive graphs, p_c, FKG/BK, polynomial growth |
| 214 | The Benjamini–Schramm nonuniqueness conjecture | math.PR | 1 | yes | frontier (Hutchcroft nonunimodular operator theorem, Haggstrom-Peres-Schonmann) | p_u, Cheeger constant, mass transport, OSSS, triangle condition |
| 215 | Canonical O(3) continuum limit and exact O(4) mass asymptotics | math.MP | 5 | yes | frontier (block RG with cluster expansion; OS reconstruction with mass gap) | O(n) Gibbs states, transfer gap, OS axioms |
| 216 | Critical and near-critical XY scaling and BKT universality | math.MP | 6 |  | frontier (Brydges-type RG; van Engelenburg-Lis dichotomy) | XY/Villain duality, GFF, BKT |
| 217 | The low-temperature Sherrington–Kirkpatrick fluctuation law | math.PR | 2 |  | frontier (Lopatto/Aronow-Lopatto Parisi-measure support, 2026) | SK free energy, Parisi functional, Brascamp-Lieb |
| 218 | Conformal universality for weakly interacting and random-bond… | math.PR | 6 | yes | frontier (Ising fermionic observables, SLE_3 convergence, quenched disorder) | planar Ising, FK coupling, SLE_3 |
| 219 | GOE bulk universality for regular graphs with weak Anderson disorder | math.PR | 2 |  | frontier (Huang-Yau fixed-d local law, Landon-Sosoe-Yau universality) | random regular graphs, Kesten-McKay, GOE bulk |
| 220 | Directional zero–one laws beyond iid environments and iid ballisticity | math.PR | 3 | yes | needs RandomMedia, ErgodicTheory, MarkovChainsAndMixing (renewal); self-contained modulo textbooks | RWRE, regeneration, renewal, ergodic theorems |
| 221 | The Mézard–Parisi formula for diluted spin glasses | math.PR | 1 | yes | needs MeanFieldSpinGlasses, ConcentrationAndFunctionalInequalities | diluted spin glasses, hierarchical cavity |
| 222 | Perceptron free energies and microscopic jamming exponents | math.PR | 4 | yes | frontier (Panchenko ultrametricity plus Mourrat Hamilton-Jacobi enrichment); needs MeanFieldSpinGlasses | perceptron free energy, RPC, Boue-Dupuis |
| 223 | Random-cluster interfaces: critical, disordered, thermal, and… | math.PR | 6 |  | frontier (FK crossing estimates, CLE and imaginary geometry, six-vertex GFF) | FK interfaces, SLE_kappa, CLE_kappa |
| 224 | Critical and quenched near-critical universality for… | math.PR | 3 |  | frontier (Tassion, Ahlberg-Griffiths-Morris-Tassion, Vanneuville crossing estimates) | Poisson-Voronoi percolation, Cardy formula |
| 225 | Gaussian free field limits throughout the balanced six-vertex regime | math.PR | 1 |  | frontier (Bethe-root condensation, DKKMT 2026) | six-vertex height function, GFF |
| 226 | The double-dimer loop ensemble converges to CLE4 | math.PR | 1 |  | frontier (CLE_4 and GFF local-set uniqueness) | double dimers, CLE_4 |
| 227 | Critical SK autocorrelation processes and dynamics across the… | math.PR | 8 | yes | frontier (stochastic localization spectral gap, Wang 2026); critical results need MarkovChainsAndMixing | Glauber dynamics, TV mixing, cutoff, Poincare |
| 228 | Continuum phase transitions for radial pair potentials | math.MP | 2 | yes | needs ContinuumGibbsSystems (self-contained) | canonical free energy, stability, thermodynamic limit |
| 229 | Exact three- and four-state reconstruction thresholds and… | math.PR | 3 | yes | needs ProbabilityOnTreesAndNetworks, ShannonInformationTheory; SBM corollary frontier (Mossel-Sly-Sohn) | broadcasting on trees, Kesten-Stigum |
| 230 | Exact Hausdorff gauges for SLE | math.PR | 2 | yes | frontier (Rohde-Schramm, Lawler-Werness multipoint Green functions) | SLE, Hausdorff gauges |
| 231 | The free uniform spanning forest is a factor of IID | math.PR | 1 | yes | needs ProbabilityOnTreesAndNetworks, StochasticCalculus, ErgodicTheory | FUSF, factors of IID, strongly Rayleigh |
| 232 | Gaussian fields and interfaces for triangular-lattice Lipschitz… | math.PR | 3 |  | frontier (reflection-positivity sum rules, SLE_4 level lines) | Lipschitz heights, GFF, SLE_4 |
| 233 | The joint critical Ashkin–Teller current limit | math.PR | 1 |  | frontier (two-valued local sets; six-vertex/Ashkin-Teller) | Ashkin-Teller currents, GFF local sets |
| 234 | All-temperature pressure of orthogonally invariant Ising spin glasses | math.PR | 1 | yes | needs MeanFieldSpinGlasses, RandomMatrices (#397) | orthogonally invariant couplings, Parisi formula |
| 235 | Limiting random SAT thresholds, sharp variance and computability | math.PR (cs.DM) | 4 | yes | needs RandomGraphsAndConstraintSatisfaction, ConcentrationAndFunctionalInequalities | random k-SAT thresholds |
| 236 | The exact factor-of-IID threshold for free Ising spins on trees | math.PR | 1 | yes | needs ProbabilityOnTreesAndNetworks, LatticeGibbsMeasures, ErgodicTheory | Ising on trees, factors of IID |
| 237 | The three-quarter exponent for honeycomb self-avoiding walk | math.PR | 13 | yes | frontier (extended parafermionic/cylinder transfer analysis of honeycomb SAW) | self-avoiding walk, O(n) loop model |
| 238 | Optimal logarithmic mixing of the Thorp shuffle | math.PR | 12 | yes | needs MarkovChainsAndMixing (+ SchurWeyl); self-contained | card shuffling, Fourier on S_n |
| 239 | Sharp singularity rates for symmetric random sign matrices | math.PR (math.CO) | 2 |  | needs ConcentrationAndFunctionalInequalities, RandomMatrices (#397); one research input (reverse Minkowski) | symmetric random sign matrices, lattices |
| 260 | Spacetime Penrose inequalities: enclosing area, charge, rotation,… | math.DG (gr-qc) | 13 | yes | frontier (Riemannian Penrose in all dimensions, generalized Jang equation, GMT regularity) | initial data, ADM mass, MOTS, Penrose inequality |
| 261 | Localization and delocalization in the Anderson model | math.MP | 2 | yes | needs RandomSchrodingerOperators, SchrodingerOperators (self-contained modulo Teschl) | Anderson model, spectral types |
| 262 | Sharp finite-matrix Lieb–Thirring inequalities and all equality cases | math.SP | 3 | yes | needs SchrodingerOperators (+ matrix analysis) | Lieb-Thirring constants |
| 263 | The ionization and generalized ionization conjectures | math.MP | 3 | yes | needs ManyBodyQuantumMechanics, SchrodingerOperators | Coulomb N-body binding, Thomas-Fermi |
| 264 | Strong cosmic censorship near two-ended Kerr data | math.AP (gr-qc) | 3 |  | frontier (near-Kerr evolution, Kerr stability) | MGHD, C^1 extensions, Kerr |
| 265 | Area laws and tensor networks for two-dimensional gapped systems | math.MP (quant-ph) | 2 |  | needs QuantumSpinSystems, QuantumInformationTheory (+ SchurWeyl) | gapped ground states, entanglement entropy, PEPS |
| 266 | Exactly three mutually unbiased bases in dimension six | math.MP (quant-ph) | 2 | yes | elementary (exact certificates; binary64 pipeline for N(6)<=3) | MUBs, complex Hadamard matrices |
| 267 | Positive-temperature Bose–Einstein condensation and exact quantum… | math.MP | 5 | yes | frontier (companion lattice-skeleton bound; Lieb-Seiringer-Yngvason) | Bose gas, condensate fraction |
| 268 | The spin-one Haldane gap | math.MP | 2 |  | needs QuantumSpinSystems (+ certified computation) | Heisenberg chain spectral gap, MPS |
| 269 | Uniform Laughlin gap and stability under bounded scalar disorder | math.MP | 2 | yes | needs ManyBodyQuantumMechanics (fermionic Fock, LLL); self-contained | Laughlin state, pseudopotentials |
| 270 | Threshold and positive-energy bound states of the BFSS matrix model | math.MP (hep-th) | 2 |  | needs SchrodingerOperators (self-contained) | BFSS supercharges, index |
| 271 | Bloch's law, its lattice correction, and the spherical… | math.MP | 4 | yes | needs QuantumSpinSystems, ProbabilityOnTreesAndNetworks, PointProcesses (#417) | KMS states, random loops, Bloch law |
| 272 | Entanglement without distillable secret key | math.MP (quant-ph) | 1 | yes | needs QuantumInformationTheory (+ Galois theory in Mathlib) | PPT, distillable key, EB channels |
| 273 | The entropy photon-number inequality | cs.IT (quant-ph) | 1 | yes | needs QuantumInformationTheory (Shannon and bosonic layers), ManyBodyQuantumMechanics (Fock space) | bosonic channels, entropy photon number |
| 274 | Parity is not in QAC0 | cs.CC (quant-ph) | 2 | yes | needs QuantumComputation (+ BooleanFunctionAnalysis for corollaries) | QAC0 circuits, parity |
| 275 | QMA-hardness of continuum Coulomb energy | cs.CC (quant-ph) | 2 | yes | frontier (Cubitt-Montanaro-Piddock QMA-hardness via perturbative gadgets) | QMA, Coulomb Hamiltonian |
| 276 | Classical capacity of generalized amplitude damping | cs.IT (quant-ph) | 1 | yes | needs QuantumInformationTheory (Shannon layer) | classical capacity, Holevo quantity |
| 277 | Threshold repetition for entangled games | cs.CC (quant-ph) | 1 | yes | needs QuantumComputation (nonlocal games), ShannonInformationTheory; one research input (Song's conditioning lemma) | entangled games, parallel repetition |
| 278 | Failure of Kohn–Sham ensemble representation | math.MP | 1 |  | needs SchrodingerOperators, ManyBodyQuantumMechanics; one research input (Fournais-Sorensen) | Kohn-Sham representability |
| 279 | Exact quantum factoring over a fixed finite gate set | cs.CC (quant-ph) | 1 | yes | needs QuantumComputation (self-contained) | Shor, exact amplitude amplification |
| 280 | Unitary vertex operator algebras and conformal nets | math.QA (math.OA) | 1 | yes | frontier (Huang modularity, CKLW, Gui, Carpi-Weiner-Xu) | unitary VOAs, conformal nets |
| 281 | QAOA attains the SK optimum in the thermodynamic-first limit | math.MP (quant-ph) | 2 | yes | frontier (zero-temperature Parisi formula, BFMVZ tree identity) | QAOA, Parisi ground state |
| 282 | From scale symmetry to local conformal symmetry in… | math.MP (hep-th) | 1 |  | frontier (half-sided modular inclusions, Bisognano-Wichmann, Mack representations) | Wightman/Haag-Kastler, Ward identities |
| 283 | Polynomial-time unitary synthesis from a Boolean oracle | cs.CC (quant-ph) | 1 |  | needs QuantumComputation, ConcentrationAndFunctionalInequalities (matrix Khintchine) | oracle circuits, diamond norm |
| 284 | The optimal quartic separation between randomized and quantum queries | cs.CC | 1 |  | frontier (Bansal-Sinha k-fold Forrelation lower bound) | query complexity separations |

## (e) Reusable OAI Lean infrastructure worth porting

The OAI Lean tree (`lean/OAI/`, Apache-2.0, depends on Tau Ceti) is overwhelmingly paper-specific. It builds fresh local models per paper: three incompatible percolation-graph encodings (`UnimodularPercolation/Graph/Basic.BondGraph`, `CriticalZ3/Model`, `CriticalZ3/HyperedgeComparison.Hypergraph`), and about 30 definitions of `totalVariation`, about 15 of `mixingTime`, three of `partialTrace`, and dozens of `entropy`/`gibbs`/`partitionFunction`. That duplication is the strongest evidence for the Tier 1 roadmaps above. Candidates to port, as sources of lemmas rather than of APIs:

| OAI path | General content | Target roadmap |
|---|---|---|
| `Probability/SLE/{BrownianStrongMarkov,ItoIsometry,StochasticIntegrals,StochasticFubini,ExponentialMartingales,OptionalStopping}.lean`; `Probability/StrongRayleigh/{PreBrownianExistence,BrownianKolmogorov,BrownianContinuability,BrownianBridge}.lean` | strong Markov property of Mathlib's `IsBrownianReal`, Brownian existence with continuous paths, Itô isometry, stochastic Fubini, exponential martingales, bridges | BrownianMotion, StochasticCalculus |
| `Probability/SLE/Loewner/*` (`Capacity*`, `Hydrodynamic*`) | half-plane capacity, hydrodynamic normalization, Loewner flow estimates | SchrammLoewnerEvolution |
| `Probability/UnimodularPercolation/{Graph/*,ProductMeasure/Association,Kernel/RussoRows,Transport/{Haar,InvariantRoot},Cayley/Folner}`; `BenjaminiSchramm/GhostFanBK`; `CriticalZ3/Peierls` | locally finite bond graphs with automorphism topology, Harris–FKG, Russo, BK, mass transport via Haar measure, Følner sets, Peierls | BernoulliPercolation, ProbabilityOnTreesAndNetworks |
| `Probability/CriticalPercolation/{Harmonic,GraphTopology,Classification}/*` with the external `Aaron1011/gromov` dependency | Poincaré/Caccioppoli on graphs, finite dimensionality of polynomial-growth harmonic functions, compact-open topology on Aut(G), virtually nilpotent quotients | AmenableGroupsAndGrowth (cross-share) |
| `Probability/StrongRayleigh/{FiniteDPPExistence,DeterminantalUniqueness,FiniteDPPWeights}`; `Probability/SpanningForest/{FiniteUSTMeasure,USTFiniteDeterminantal,GraphFUSFLaw}` | finite determinantal processes, UST as a DPP, FUSF law | ProbabilityOnTreesAndNetworks |
| `Probability/FKMaps/{PlaneTrees,ConditionedTrees,Vervaat,ExcursionLaw,PathCLT,GHPBounds,CanonicalBijection}` | plane trees, Vervaat transform, conditioned-walk CLT, GHP bounds, CRT convergence (q>4 FK maps) | RandomTreesAndMaps |
| `Probability/SKGap/Gaussian/*` | Gaussian integration by parts, Stein identities, GOE row/norm tails, sub-Gaussian tails | ConcentrationAndFunctionalInequalities |
| `Probability/ThorpShuffle/{Specht,Polytabloids,Tableaux,FourierBounds,Walsh}` | Specht modules, polytabloids, Fourier bounds on S_n | SchurWeyl (reps), MarkovChainsAndMixing (upper-bound lemma) |
| `InformationTheory/AmplitudeDamping/{Channel,Holevo,HolevoInformation,Naimark,Pinching,TypicalProjectors,EntropyContinuity}`; `InformationTheory/PhotonNumber/{Gibbs,GibbsVariational,Entropy}`; `MathematicalPhysics/Fock/{Operators,Beam}` | qubit channels, Holevo quantity, Naimark dilation, pinching, typical projectors, Gibbs variational principle, bosonic operators and beam splitters | QuantumInformationTheory |
| `InformationTheory/QuantumCircuit/{Circuit,Toffoli,PauliBasis,PauliExpansion,Measurement}`; `Computability/QuantumFactoring` | circuit model, Pauli expansion, exact Shor-type factoring | QuantumComputation |
| `Analysis/LiebThirring/{SchrodingerOperator,QuadraticForms,DiscreteSpectrum,SobolevBound,EigenvalueSum}` | 1D Schrödinger operators via forms, discrete spectrum, eigenvalue sums | SchrodingerOperators |
| `Analysis/Laughlin/Fock/{Creation,Annihilation,Hamiltonian,SpinRepresentation}` | fermionic Fock space over SU(2) irreps, pair projectors | ManyBodyQuantumMechanics |
| `MathematicalPhysics/Heisenberg/*` (`IsKMS`, `gibbsState`) | finite-volume quantum Gibbs/KMS states on spin lattices | QuantumSpinSystems |
| `Probability/{ContinuumTransition,RadialTransition}` | canonical partition function and free-energy limit for pair potentials | ContinuumGibbsSystems |
| `RepresentationTheory/VertexAlgebra/*` (own `VertexAlgebra`, `IrreducibleConformalNetStructure`) | minimal VOA and conformal-net structures | VertexOperatorAlgebras / AxiomaticQuantumFieldTheory (low reuse; Mathlib has `Algebra/Vertex`) |
| `Geometry/Relativity/*` (336 files) | CKS initial data, Schwarzschild algebra | low reuse; MathematicalRelativity may take the Schwarzschild definitions |
| External, cited by the #213 paper: Leder's `anthropics/formal-math/percolation` (θ(p_c)=0 on ℤ^d) and the Sept 2026 site-percolation Lean development; `Aaron1011/gromov` (an OAI lakefile dependency) | critical percolation on ℤ^d; Gromov's polynomial-growth theorem | BernoulliPercolation; AmenableGroupsAndGrowth |
