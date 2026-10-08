# OpenAI release, Combinatorics and Theoretical computer science: prerequisite theory

Scope: the 77 families of `openai_families.json` with subject "Combinatorics" (37 families, 155–192 without 163) or
"Theoretical computer science" (40 families, 102–142 without 123). Companion needs file:
`needs_openai_combinatorics_tcs.jsonl` (272 lines, `"goal":"OpenAI"`). Prepared 2026-10-07.

## (a) Stats and headline findings

- **Size.** 77 families, 123 manuscripts (50 Combinatorics, 73 TCS).
- **Lean material.** 48 manuscripts are flagged `formalized` in `openai_families.json`, but Lean material reaches further:
  - 65 of 77 families have a `lean/docs/NNN.md` scope note with comparator statements (127 comparator files, read with `git -C …/oaimath show HEAD:lean/…`).
  - 37 families have at least one comparator listed as a main result in `formalization.yaml`.
  - 12 families have no Lean material at all: 103, 109, 120, 136, 137, 138, 141, 142, 164, 166, 171, 178.
- **Classification** (section d): 7 elementary, 50 needs a named roadmap, 20 frontier.
- **PDFs read:** 92, at introduction, overview, preliminaries and black-box level. I read 15 myself and three subagents read 77.
  - 61 families had at least one PDF read.
  - The other 16 were classified from abstracts plus Lean scope notes and comparators: 111, 115, 125, 127, 128, 130, 132, 156, 158, 160, 172, 173, 185, 187, 190, 192.
- **Supply side.** Almost nothing in this area is owned yet.
  - Tau Ceti has DenseGraphLimits (code; archived by #721) and AlgebraicCodingTheory (#724).
  - Open PRs: #444 GraphConnectivityAndFlows, #66 Regularity, #258 SpectralQuantumWalks, #257 EquitableOperatorReduction, #397 RandomMatrices (owns Hoeffding/Azuma/McDiarmid/Talagrand concentration), #271 PlanarTopology (Jordan curve, tameness of graphs in surfaces) and #717 (uses `TM2ComputableInPolyTime` only).
  - Birkbeck's campaign has AdditiveCombinatorics, ExponentialSumsAndCircleMethod and ComputationalNumberTheory.
  - The explorer index (`supply_birkbeck_campaign.json`, `roadmap-summaries.json`) has nothing else on graphs, complexity, Markov chains, Boolean functions or matroids. The explorer's own opportunity list names exactly these gaps: graph theory, extremal/probabilistic combinatorics, enumeration and matroids, algorithms and complexity.
- **Mathlib coverage.**
  - Has: substantial finite combinatorics (`SimpleGraph` with Szemerédi regularity, Turán, Erdős–Stone, Tutte's theorem, Hall, colourings, Hamiltonian; `Matroid` with duality, minors and rank; `SetFamily`; additive combinatorics; Hales–Jewett; Hindman; `ValuedCSP`; binomial random graph definition; stochastic matrices).
  - Has: computability (TM0/TM2, `Partrec`, DFA/NFA, Myhill–Nerode, `TM2ComputableInPolyTime`).
  - Has: KL divergence with chain rule and data processing, and binary entropy.
  - Missing: P, NP, reductions, randomized or RAM models, polytime composition, Shannon entropy and mutual information, Boolean Fourier analysis, Markov-chain mixing, expanders, polyhedra, graph minors, planarity and drawings.

**Finding 1: the complexity foundation is the binding gap.**
- 28 families (26 of the 40 TCS families plus 174 and 178) cannot be stated without a model of resource-bounded computation and complexity classes.
- The OAI comparators work around this. Each defines its own encoding, its own randomized TM or word RAM, and its own `GapReduction`/`NPVerifier` structure on top of Mathlib's `Turing.TM2ComputableInPolyTime`, patching a Mathlib gap with a private `FiniteAlphabet` predicate: `FinTM2` forces only `Γ k₀` finite.
- The proofs duplicate infrastructure at scale. The six hardness projects (UniqueGames, MaxCut, VertexCover, MinUncut, DirectedFeedback, BinPacking; 66k–190k lines each, about 900k in total) each carry a private TM2 machine library and their own copy of the PCP machinery.
- Cook–Levin is proved three times (DirectedFeedback/CookLevin, BinPacking/CookLevin, KMedian/CookLevin), parallel repetition at least four times, and Walsh–Fourier analysis at least five times.
- A Tau Ceti foundation (ResourceBoundedComputation, ComplexityClasses, HardnessOfApproximation) would make all of this one library.

**Finding 2: combinatorics needs five broad textbook roadmaps, not paper-specific ones.**
- The five: BooleanFunctionAnalysis, ProbabilisticMethod, StructuralGraphTheory, Ramsey/extremal theory and DiscreteGeometryAndIncidences.
- Many headline results are counterexamples or constructions with elementary proofs, which become formalizable once their statements' vocabulary exists. Examples: 155, 156, 158, 161, 162, 165, 173, 179, 185, 187, 189 and 190, mostly formalized already.

**Finding 3: frontier families depend on research theory, usually outside math.CO/cs.\***
- Families: 102, 103, 105, 108, 114, 120, 136, 139, 142, 157, 159, 164, 166, 167, 168, 169, 170 (s ≥ 6 only), 177, 178 and 188. Also partly frontier: the minimality part of 155 and Austin's junta theorem in 106.
- The research theory they depend on: Khot–Minzer–Safra Grassmann expansion; quantitative property (T); Severi varieties in characteristic p; Lorentzian polynomials and volume algorithms; almost-linear max-flow; the Leng–Sah–Sawhney inverse theorem; the GTZ inverse theorem with IP recurrence; Guth–Katz plus Hilbert-function bounds; Nie–Wang Zariski-closure bounds; Elias–Williamson; scattering diagrams; cosystolic expansion of coset complexes; Joos–Kühn.
- Two families rest on companion OpenAI claims of zero-free regions that the literature does not support. 142 assumes a uniform zero-free strip for Hecke L-functions, and 182_2 assumes Re s > 7/8 for Dirichlet L-functions. Any roadmap must treat these as unverified external inputs.

## (b) Prerequisite clusters and coverage

Coverage is the strongest existing owner, ordered mathlib > tauceti-code > tauceti-roadmap > open-pr > birkbeck > oai-lean > gap. "S" means the cluster is needed to state a result, "P" to prove one.

| Cluster | arXiv | Coverage (owner) | Families | S/P | Roadmap |
|---|---|---|---|---|---|
| Machine models with cost (multitape TM, word RAM, randomized and oracle machines), encodings, polytime composition, simulations, time hierarchy | cs.CC | mathlib, partial (`TM2ComputableInPolyTime` only) | 102 103 104 109 110 112 113 115 116 120–122 124 125 128 133 138 142 174 178 | S | **ResourceBoundedComputation** |
| P, NP, coNP, PH, PSPACE, EXPTIME, #P, PP, CH, TFNP/PPAD; reductions; Cook–Levin; Karp catalogue; gap problems; FPRAS/PTAS definitions; ETH and sparsification | cs.CC | gap (oai-lean private copies) | 102 105 106 112–118 121 125 128 133 136 138 141 | S | **ComplexityClasses** |
| L, NL, RL, BPL; Savitch, Immerman–Szelepcsényi; Nisan, Reingold; time–space simulation | cs.CC | gap | 103 137 | S/P | **SpaceBoundedComputationAndDerandomization** |
| PCP theorem (Dinur), Label Cover, parallel repetition, Håstad 3-bit test, long code, UG reductions, low-degree testing | cs.CC | oai-lean only (6 private copies); AlgebraicCodingTheory has codes only | 102 105 106 117 118 125 136 | P | **HardnessOfApproximation** |
| Grassmann expansion, 2-to-2 games | cs.CC | oai-lean (complete proof, UniqueGames/Inverse) | 102 105 | P | frontier; HardnessOfApproximation final milestone or follow-on |
| Arithmetic circuits, ABPs, tensor and border rank, ω, laser method, determinantal complexity, PIT, linear DFT circuits | cs.CC | gap (oai-lean MatrixMultiplication, 83k lines) | 107 108 109 116 130 135 141 | S/P | **AlgebraicComplexityTheory** |
| Boolean circuits and lower bounds, restrictions, branching programs | cs.CC | gap | 112 140 | S/P | **BooleanCircuitComplexity** |
| Fourier–Walsh analysis, hypercontractivity, KKL, juntas, sharp thresholds, invariance principle, query measures, PTFs | math.CO | gap (oai-lean, ≥5 private copies) | 102 105 106 119 126 127 132 175 186 192 | S/P | **BooleanFunctionAnalysis** |
| Shannon entropy, mutual information, Shearer, Fano, Pinsker, strong data processing | math.IT | mathlib, partial (KL divergence, `binEntropy`) | 102 113 119 122 139 140 157 167 170 | S/P | **ShannonInformationTheory** |
| Finite Markov chains: mixing, spectral gap, comparison, coupling; approximate counting and sampling | math.PR | mathlib, partial (stochastic matrices) | 103 113 114 115 131 | S/P | **MarkovChainMixing** |
| Expanders: mixing lemma, Cheeger, zig-zag, MSS interlacing, nonbacktracking, high-dimensional expanders | math.CO | gap; #258/#257 cover spectra only | 120 126 136 174 177 178 | S/P | **ExpanderGraphs** |
| Probabilistic method: LLL, second moment, random graphs, thresholds and spread, nibble, containers, DE method | math.CO | mathlib, partial (G(n,p) definition); concentration in #397 | 112 134 157 160 170 171 175 176 178 181 184 188 191 | S/P | **ProbabilisticMethod** |
| Ramsey numbers, arithmetic and Euclidean Ramsey theory | math.CO | mathlib, partial (Hales–Jewett, Hindman) | 106 160 164 170 171 172 189 | S/P | **RamseyTheory** |
| Turán and independence bounds, decompositions, ordered patterns, hypergraph covers | math.CO | mathlib, partial (Turán, Erdős–Stone, Zarankiewicz) | 162 171 181 184 190 | S/P | **ExtremalGraphTheory** |
| Homomorphism densities, graphons | math.CO | tauceti-code (DenseGraphLimits) | 161 | S | none |
| Regularity and removal | math.CO | mathlib (+ #66) | 157 190 | S/P | none |
| Minors, list/fractional/correspondence colouring, Colin de Verdière, planar maps, drawings, treewidth, general matching, tree packing, Hamiltonicity | math.CO | partial: Mathlib colouring/Tutte; #271 topology; #444 excludes these explicitly | 113 120 133 157 165 174 180 183 184 | S/P | **StructuralGraphTheory** |
| Flows, Menger | math.CO | open-pr #444 | 180 (and the algorithms) | P | none |
| Matroid intersection/union, polymatroids, submodularity, infinite matroids, Lorentzian polynomials | math.CO | mathlib, partial | 111 114 174 185 | S/P | **MatroidsAndSubmodularity** |
| Polyhedra, LP duality, TU, matching polytope, extended formulations, PSD rank, configuration LP, GLS | math.OC | mathlib, partial (cone Farkas, Birkhoff) | 113 114 118 125 126 | S/P | **PolyhedralCombinatorics** |
| SDP relaxations, GW, SOS, metric embeddings, HST/FRT | cs.DS | gap | 102 110 117 122 126 | S/P | **ConvexRelaxationsAndMetricEmbeddings** |
| Incidences, polynomial method, k-sets, tilings, unit-distance graphs, Borsuk, Heilbronn | math.CO | mathlib, partial (UnitDistance, Tiling definitions) | 155 156 158 166 167 170 183 191 | S/P | **DiscreteGeometryAndIncidences** |
| Two-way automata, finite monoids, star height | cs.LO | mathlib, partial (one-way automata) | 129 134 | S/P | **AutomataAndFiniteSemigroups** |
| Games on graphs, Maker–Breaker | cs.GT | gap | 104 187 | S/P | **GamesOnGraphs** |
| Online algorithms, prophet inequalities | cs.DS | gap | 110 111 | S/P | **OnlineAlgorithms** |
| Weisfeiler–Leman, pebble games, CFI | cs.LO | gap; #257 excludes WL | 133 | S/P | **WeisfeilerLemanAndCountingLogics** |
| Algorithms with running-time proofs (graphs, flows, matching, DP, approximation) | cs.DS | gap (#444 excludes algorithmic bounds) | 120 121 124 125 128 138 | P | **CombinatorialAlgorithms** |
| Fast multiplication, FFT, factorization over 𝔽_p | cs.DS | birkbeck, partial (ComputationalNumberTheory CN.0–1) | 109 130 142 | P | **FastAlgebraicAlgorithms** |
| Finite geometry, designs, Hadamard matrices, forms over 𝔽_q, cyclotomic descent | math.CO | mathlib, partial (projective planes) | 161 162 170 179 | S/P | **CombinatorialDesignsAndFiniteGeometry** |
| Symmetric/quasisymmetric functions | math.CO | tauceti-roadmap, partial (SchurWeyl) | 169 | S | **SymmetricFunctions** |
| Bruhat order, Hecke algebras, KL polynomials | math.RT | tauceti-roadmap, partial (RootSystems) | 168 | S | **HeckeAlgebrasAndKazhdanLusztigTheory** |
| Higher-order Fourier analysis | math.CO | birkbeck AdditiveCombinatorics (quantitative LSS is frontier) | 159 164 | P | none |
| Circle method | math.NT | birkbeck ExponentialSumsAndCircleMethod | 182 | P | none |
| Concentration inequalities | math.PR | open-pr #397 | 113 157 161 | P | none |
| Real algebraic geometry | math.AG | tauceti-roadmap RealAlgebraicGeometry (no critical-point method) | 141 | P | none |
| Curves over 𝔽_q, function fields | math.AG | tauceti-roadmap AlgebraicCurves (no towers or Jacobian arithmetic) | 117 142 | P | none |
| Heights and the product formula | math.NT | open-pr #287 | 167 | P | none |
| Zero-free regions | math.NT | open-pr #253; 142 and 182_2 claims unverified | 142 182 | P | none |
| Certified finite computation | cs.LO | Lean core (`decide`, LRAT, `bv_decide`) | 107 119 158 187 189 | P | tooling only |

Cross-domain gaps that frontier families need (for the planners of those categories, not proposed here):
- **KazhdanPropertyT** (math.RT): 103, 136.
- **IntersectionTheory** and Hilbert functions (math.AG): 108, 166, 170.
- **PlaneCurveSingularities**, i.e. Severi varieties (math.AG): 108.
- **StochasticCalculus** (math.PR): 139.
- **ErgodicRamseyTheory**, nilpotent IP recurrence (math.DS): 164.
- **SoergelBimodules** (math.RT): 168.
- **ScatteringDiagrams** (math.AG): 169.
- **BuildingsAndCosetComplexes** (math.GR): 177.

## (c) Proposed roadmaps

The roadmaps fall into three tiers:
- **Tier 1** is foundations, each unlocking ten or more families.
- **Tier 2** is broad graduate subjects.
- **Tier 3** covers narrow but coherent subjects.

Sizes run M < L < XL, with L about one graduate course. Every proposal fills a gap confirmed by grepping main, the 78 open PRs and the Birkbeck index.

### Tier 1

**ResourceBoundedComputation** (cs.CC; secondary cs.LO, cs.DS). Size L.
- **Scope.** This roadmap makes "computable in time T", "in polynomial time" and "in logarithmic space" usable statements about Mathlib's machines. It fixes encodings (canonical binary encodings of ℕ, ℤ, ℚ, lists, finite graphs, matrices and formulas, compatible with `Computability.Encoding`).
- **Models.** It equips Mathlib's TM2 with finite alphabets on every stack, with time and space cost. It adds:
  - a logarithmic-word RAM with unit-cost arithmetic;
  - randomized machines that read fair coins and are bounded on every random tape;
  - oracle machines;
  - a structured stack-program language compiled to TM2 with exact cost, for programming without hand-built transition tables.
- **Headline theorems.**
  - Polynomial-time and log-space functions are closed under composition.
  - Polynomial-time simulation between the word RAM and multitape TMs.
  - Quadratic simulation of multitape machines by one-tape machines, and Hennie–Stearns.
  - Deterministic time and space hierarchy theorems.
  - The class FP is independent of the model.
- **Prerequisites.** Mathlib `Computability`.
- **Families.** The 20 families listed in (b).
- **Formalizability.** High. OAI's `Computability/Superstring/{Instructions,Clock,PolynomialTime}.lean` already proves composition for such a block language and certifies it to `TM2ComputableInPolyTime` with finite alphabets.

**ComplexityClasses** (cs.CC). Size XL.
- **Scope.** Decision, promise and search problems over binary encodings.
- **Classes.** P, NP in verifier form, coNP, PH, PSPACE, EXPTIME, BPP, RP, ZPP, #P, PP and the counting hierarchy. Also P/poly with Boolean circuits as a nonuniform model, and TFNP with PLS and PPAD via End-of-Line. L, NL, RL and BPL are defined here, and their theorems live in SpaceBoundedComputationAndDerandomization.
- **Reductions.** Karp, log-space and Turing reductions, with hardness and completeness.
- **Approximation vocabulary.** Approximation ratio, PTAS/FPTAS, FPRAS/FPAUS, gap problems and gap-preserving reductions.
- **Hypotheses.** ETH and SETH as named hypotheses (not axioms).
- **Headline theorems.**
  - Cook–Levin.
  - Karp's catalogue: 3SAT, CLIQUE, IS, VC, 3-COL, HAM-CYCLE, SUBSET-SUM, PARTITION, BIN-PACKING, MAX-CUT, SET-COVER.
  - Amplification for BPP and RP; Adleman, BPP ⊆ P/poly; Sipser–Gács–Lautemann.
  - Valiant's #P-completeness of the permanent.
  - The IPZ sparsification lemma.
  - Succinct-encoding EXPTIME-completeness.
- **Prerequisites.** ResourceBoundedComputation.
- **Families.** 102 105 106 112–118 121 125 128 133 136 138 141.
- **Formalizability.** High. There are three existing Lean proofs of Cook–Levin on TM2, and the NP-verifier template is in comparator `DirectedFeedback.lean`.

**BooleanFunctionAnalysis** (math.CO; secondary cs.CC, math.PR). Size L.
- **Scope.** O'Donnell's book.
  - Fourier–Walsh expansion on {±1}ⁿ and on 𝔽₂ⁿ, and p-biased bases.
  - Influences and total influence, the noise operator and stability, Efron–Stein decomposition.
  - Bonami lemma, Bonami–Beckner hypercontractivity and the log-Sobolev inequality on the cube.
  - KKL, Friedgut's junta theorem, FKN, Margulis–Russo, and the Friedgut–Kalai and Bourgain sharp-threshold theorems.
  - BLR linearity testing.
  - Complexity measures: sensitivity, block sensitivity, certificate, degree, decision-tree depth (Nisan–Szegedy, Huang's sensitivity theorem).
  - Polynomial threshold functions.
  - Gaussian space: Hermite analysis, the invariance principle (Mossel–O'Donnell–Oleszkiewicz), Borell isoperimetry, Majority is Stablest.
- **Prerequisites.** Mathlib Gaussian measures; StandardDistributions.
- **Families.** 102 105 106 119 126 127 132 175 186 192; also 112 and 176 indirectly.
- **Formalizability.** High. OAI holds `Combinatorics/SharpThreshold/Fourier*.lean` (hypercontractive and noise estimates), `GotsmanLinial/Walsh*.lean` and `VertexCover/Fourier`. Austin's continuous junta theorem (106) is research-level and would be a final milestone.

**ProbabilisticMethod** (math.CO; secondary math.PR). Size XL.
- **Scope.** Alon–Spencer and Janson–Łuczak–Ruciński.
  - Linearity of expectation, alterations, second moment, Janson inequalities.
  - Lovász local lemma: symmetric, asymmetric and lopsided, plus algorithmic Moser–Tardos.
  - Dependent random choice; the method of conditional expectations.
  - Random graphs G(n,p) and G(n,m) on Mathlib's definition: appearance thresholds of fixed subgraphs (Bollobás), Bollobás–Thomason thresholds, expectation thresholds and the Park–Pham theorem (spread lemma).
  - Hypergraph containers (Balogh–Morris–Samotij / Saxton–Thomason); entropy compression.
  - The Rödl nibble and Pippenger–Spencer; the differential-equations method (Wormald) with the triangle-free and triangle-removal processes at the level of their basic trajectories.
  - Johansson's triangle-free colouring bound.
- **Prerequisites.** RandomMatrices (#397) for concentration; BooleanFunctionAnalysis for sharp thresholds; ShannonInformationTheory.
- **Families.** 112 134 157 160 170 171 175 176 178 181 184 188 191.
- **Formalizability.** Medium–high. Statements are elementary, and OAI has finite-LLL files (`ProgressionColoring/FiniteLocalLemma*.lean`, `BalancedRyser/Local`).

**ShannonInformationTheory** (math.IT; secondary cs.IT, math.PR). Size M.
- **Scope.**
  - Entropy of discrete random variables; joint and conditional entropy; mutual information and conditional mutual information.
  - Chain rules; Han's and Shearer's inequalities; Fano; Pinsker and the Hellinger and total-variation comparisons (on Mathlib's KL divergence); data processing.
  - Differential entropy of densities on ℝᵈ; maximum-entropy distributions and their convex duality.
  - Entropy counting in combinatorics: Brégman via Radhakrishnan, Shearer-type subgraph counts.
  - Strong data-processing coefficients and their contraction under noise channels.
- **Prerequisites.** Mathlib `InformationTheory/KullbackLeibler`.
- **Families.** 102 113 119 122 139 140 157 167 170.
- **Formalizability.** High. The PFR project's entropy library (Apache-2.0) and OAI `VertexCover/Information/{ChainRule,Pinsker,Tensorization}.lean` are porting sources, subject to coordination.

**StructuralGraphTheory** (math.CO). Size XL.
- **Scope.** Diestel's chapters on matching, colouring, planarity, minors and Hamiltonicity, on Mathlib `SimpleGraph` and `Graph`.
  - General matching: Tutte–Berge, Gallai–Edmonds, the matching lattice consumed by PolyhedralCombinatorics.
  - Colouring: Brooks, Vizing, list colouring (Thomassen 5-choosability, Galvin), correspondence (DP) colouring, fractional chromatic number as an LP value.
  - Minors and contraction, Wagner and Kuratowski, Mader's and Kostochka–Thomason's density bounds, Hadwiger for t ≤ 4; tree decompositions, treewidth, brambles.
  - Planar graphs as combinatorial maps (rotation systems), Euler's formula, plane duality, triangulations, and the bridge to topological embeddings of PlanarTopology (#271).
  - Plane drawings, the crossing number, normalization to polygonal drawings.
  - Tutte's theorem on Hamiltonicity of 4-connected planar graphs, Grinberg.
  - Nash-Williams–Tutte tree packing; Kasteleyn's Pfaffian orientations of planar graphs.
  - Colin de Verdière's invariant (definition, minor-monotonicity, μ ≤ 3 iff planar).
- **Prerequisites.** #444, #271, MatroidsAndSubmodularity (for tree packing via matroid union).
- **Families.** 113 120 133 157 165 174 180 183 184.
- **Formalizability.** Medium. Planar maps and drawings are the expensive layer. OAI `Combinatorics/Crossing` (339 files) and `ListHadwiger/MinorModels` show workable encodings.

**MarkovChainMixing** (math.PR; secondary cs.DS). Size L.
- **Scope.** Levin–Peres–Wilmer, plus approximate counting.
  - Finite chains on Mathlib's stochastic matrices: irreducibility, aperiodicity, stationary laws, reversibility, total variation, mixing time.
  - Coupling and path coupling; strong stationary times.
  - Spectral gap and relaxation time, Dirichlet forms and Poincaré inequalities, conductance and Cheeger for reversible chains; canonical paths and multicommodity flows; comparison theorems (Diaconis–Saloff-Coste); block dynamics and product chains.
  - Coupling from the past.
  - Approximate counting: self-reducibility and the Jerrum–Valiant–Vazirani counting–sampling equivalence, FPRAS from rapid mixing, Jerrum–Sinclair monomer–dimer, Jerrum–Sinclair–Vigoda for the permanent.
  - Final milestone: spectral independence and log-concave polynomials for matroid bases (Anari–Liu–Oveis Gharan–Vinzant).
- **Prerequisites.** ComplexityClasses (FPRAS definitions); MatroidsAndSubmodularity (final milestone).
- **Families.** 103 113 114 115 131.
- **Formalizability.** High for the core. OAI `Probability/SwitchChain` (222 files) proves a full spectral-gap argument.

**ExpanderGraphs** (math.CO; secondary cs.CC, math.SP). Size L.
- **Scope.**
  - Spectral and combinatorial expansion of regular graphs and Cayley graphs; the expander mixing lemma; both directions of the discrete Cheeger inequality; Alon–Boppana.
  - Random walks on expanders, including the expander Chernoff bound.
  - Explicit families: Margulis–Gabber–Galil, and the zig-zag and replacement products.
  - Marcus–Spielman–Srivastava interlacing families: bipartite Ramanujan graphs of every degree, and Weaver/Kadison–Singer in the form used for thin trees.
  - Nonbacktracking operators and Ihara–Bass.
  - High-dimensional expanders: simplicial 𝔽₂-cochains, links, Garland's method, coboundary and cosystolic expansion as definitions with the basic theory.
  - Lubotzky–Phillips–Sarnak graphs, citing ModularForms and quaternion-algebra material as prerequisites.
- **Prerequisites.** #258 or Mathlib spectra; MarkovChainMixing.
- **Families.** 120 126 136 174 177 178; also the PCP chain (102 105 106).
- **Formalizability.** High except LPS. OAI `BinPacking/Expanders/ZigzagSpectral.lean` is a porting candidate.

### Tier 2

**HardnessOfApproximation** (cs.CC). Size XL.
- **Scope.**
  - CSPs (Mathlib `ValuedCSP`), projection games and Label Cover, gap problems.
  - Low-degree and linearity testing, Hadamard and long codes, folding.
  - Dinur's gap amplification giving the PCP theorem with perfect completeness, through assignment testers, composition and alphabet reduction.
  - Parallel repetition: Raz, Holenstein's information-theoretic proof, Rao's projection-game bound, Dinur–Steurer's analytic form.
  - Håstad's 3-bit test, with tight Max-3LIN and Max-3SAT (7/8).
  - Feige's ln n Set-Cover hardness.
  - Unique Games: the definition, KKMO Max-Cut hardness from UGC via Majority is Stablest, Khot–Regev vertex cover.
  - Final milestone: the Khot–Minzer–Safra Grassmann expansion theorem and 2-to-2 hardness, which OAI has proved in Lean (`UniqueGames/Inverse`).
- **Prerequisites.** ComplexityClasses, BooleanFunctionAnalysis, ExpanderGraphs, ShannonInformationTheory, AlgebraicCodingTheory.
- **Families.** 102 105 106 117 118 125 136.
- **Formalizability.** Proven feasible by OAI (six independent hardness developments). The roadmap's value is consolidation.

**AlgebraicComplexityTheory** (cs.CC; secondary math.AG). Size L.
- **Scope.** Bürgisser–Clausen–Shokrollahi.
  - Straight-line programs and arithmetic circuits and formulas over a field, ABPs, homogenization, Strassen's degree bound.
  - Bilinear complexity, tensor rank, border rank and degeneration; Strassen's algorithm and the exponent ω; Schönhage's asymptotic sum inequality; Strassen's asymptotic spectrum; the laser method with Coppersmith–Winograd tensors and Behrend sets.
  - Linear circuits and the DFT (Cooley–Tukey, Morgenstern).
  - Determinantal complexity, VP/VNP and Valiant's universality, the Mignon–Ressayre quadratic bound.
  - Partial-derivative and shifted-partial measures (Nisan's noncommutative ABP bound, depth-4 homogeneous lower bounds); Schwartz–Zippel and PIT.
  - Noncommutative formulas and their ABP conversion (Raz–Shpilka).
- **Prerequisites.** ResourceBoundedComputation for uniformity statements.
- **Families.** 107 108 109 116 130 135 141.
- **Formalizability.** High. OAI `LinearAlgebra/MatrixMultiplication` and `MatrixFields` (265k lines) already contain tensor degeneration and CW machinery.

**RamseyTheory** (math.CO). Size L.
- **Scope.** Monochromatic substructures in finite colourings.
  - Graph and hypergraph Ramsey numbers with the Erdős and Erdős–Szekeres bounds.
  - Off-diagonal r(3,t) and r(4,t) basics: Ajtai–Komlós–Szemerédi and Shearer upper bounds, random and algebraic lower-bound constructions.
  - Ramsey numbers of bounded-degree and sparse graphs (Chvátal–Rödl–Szemerédi–Trotter via #66; Conlon–Fox–Sudakov for cubes); Ramsey goodness (Burr–Erdős).
  - Arithmetic Ramsey theory: van der Waerden numbers with Berlekamp's lower bound, Rado, Folkman–Rado–Sanders, quantitative Hales–Jewett on Mathlib's qualitative versions.
  - Euclidean Ramsey theory: Frankl–Rödl, spherical and transitive sets, cospherical necessity.
- **Prerequisites.** ProbabilisticMethod; CombinatorialDesignsAndFiniteGeometry.
- **Families.** 106 160 164 170 171 172 189.

**ExtremalGraphTheory** (math.CO). Size L.
- **Scope.** Extremal values of graph parameters under forbidden substructures.
  - Turán, Erdős–Stone and Kővári–Sós–Turán (consuming Mathlib); supersaturation.
  - Independence-number bounds in sparse or clique-free graphs (Caro–Wei, Shearer).
  - Sidorenko's conjecture in its known cases, on DenseGraphLimits.
  - Lovász's path–cycle decomposition; sublinear expanders (Komlós–Szemerédi); cycle decompositions (Conlon–Fox–Sudakov).
  - Aharoni–Haxell hypergraph Hall; hypergraph matchings and covers (König, Ryser for r = 3).
  - Ordered graphs and 0-1 matrices (Füredi–Hajnal, Marcus–Tardos) with ordered removal.
- **Prerequisites.** ProbabilisticMethod; #66.
- **Families.** 162 171 181 184 190; also 157 and 161 through independence bounds and Sidorenko.
- **Boundary.** RamseyTheory owns colourings; this roadmap owns parameter extremes.

**DiscreteGeometryAndIncidences** (math.CO; secondary math.MG). Size L.
- **Scope.**
  - The crossing lemma, Szemerédi–Trotter and Pach–Sharir incidences, unit distances O(n^{4/3}) (Spencer–Szemerédi–Trotter).
  - Clarkson–Shor random sampling and cuttings, shallow cuttings.
  - Polynomial partitioning via polynomial ham sandwich (Stone–Tukey), Dvir's finite-field Kakeya and rich-line bounds.
  - Final milestone: the Guth–Katz distinct-distance theorem.
  - k-sets and halving lines (Lovász, Dey).
  - Helly, Radon, Carathéodory, Tverberg; ε-nets (on Mathlib's VC dimension).
  - Borsuk's problem and Kahn–Kalai; unit-distance graphs and the chromatic number of the plane.
  - Translational tilings of ℤᵈ (Newman's one-dimensional periodicity, Bhattacharya's planar theorem as final milestone, the Greenfeld–Tao encoding).
  - The Heilbronn problem (Komlós–Pintz–Szemerédi).
- **Prerequisites.** StructuralGraphTheory (drawings), ProbabilisticMethod, RealAlgebraicGeometry. The Borsuk–Ulam theorem, needed for polynomial ham sandwich, is absent from Mathlib, Tau Ceti and every roadmap source, so it is a target here.
- **Families.** 155 156 158 166 167 170 183 191.

**PolyhedralCombinatorics** (math.OC; secondary math.CO). Size L.
- **Scope.** Schrijver's *Combinatorial Optimization* core.
  - Polyhedra and polytopes (Minkowski–Weyl, faces, vertices, dimension); LP duality and complementary slackness on Mathlib's cone duality.
  - Integral polyhedra, total unimodularity, TDI systems; the bipartite matching polytope (Birkhoff, in Mathlib) and Edmonds' matching and perfect-matching polytopes.
  - The ellipsoid method and Grötschel–Lovász–Schrijver separation ⇔ optimization.
  - Extended formulations, slack matrices, Yannakakis' theorem, nonnegative and PSD rank, Gouveia–Parrilo–Thomas.
  - Final milestone: Rothvoss's exponential extension complexity of the matching polytope.
  - The Gilmore–Gomory configuration LP.
- **Prerequisites.** StructuralGraphTheory (matching); ResourceBoundedComputation (ellipsoid).
- **Families.** 113 114 118 125 126.

**MatroidsAndSubmodularity** (math.CO; secondary math.OC). Size L.
- **Scope.** On Mathlib `Matroid` (which allows infinite ground sets):
  - the greedy characterization, base exchange;
  - Edmonds' matroid intersection, Nash-Williams matroid union and partition, Rado;
  - packing and covering;
  - submodular functions, the Lovász extension, polymatroids and polymatroid intersection, matroid base and intersection polytopes (TDI);
  - representability and binary matroids; the Tutte polynomial;
  - infinite matroids: finitary and cofinitary classes, intersection and packing/covering in the known cases;
  - final milestone: Lorentzian polynomials (Brändén–Huh) and log-concavity of basis generating polynomials.
- **Prerequisites.** PolyhedralCombinatorics.
- **Families.** 111 114 174 185.

**ConvexRelaxationsAndMetricEmbeddings** (cs.DS; secondary math.MG, math.OC). Size L.
- **Scope.**
  - Semidefinite programming and duality on the PSD cone.
  - Goemans–Williamson Max-Cut rounding and α_GW; the Lovász theta function.
  - Sum-of-squares proofs and pseudo-expectations, with Grigoriev's Tseitin lower bound.
  - Finite metrics of negative type, ℓ₁ embeddings and the cut cone.
  - Bourgain's O(log n) embedding; Linial–London–Rabinovich (sparsest cut and multicommodity flow; #444 excludes multicommodity flows).
  - Arora–Rao–Vazirani as final milestone.
  - Johnson–Lindenstrauss; hierarchically separated trees and Fakcharoenphol–Rao–Talwar.
- **Prerequisites.** PolyhedralCombinatorics, BooleanFunctionAnalysis (Gaussian tools).
- **Families.** 102 110 117 122 126.

**CombinatorialAlgorithms** (cs.DS). Size L.
- **Scope.** Algorithms on the word RAM of ResourceBoundedComputation, each with a correctness proof and a running-time proof.
  - Sorting and searching; BFS/DFS, shortest paths, MST.
  - Max-flow algorithms (Edmonds–Karp, push–relabel; #444 owns the existence theory).
  - Bipartite and general maximum matching (Hopcroft–Karp, Edmonds' blossom algorithm).
  - Dynamic programming (edit distance, LCS, knapsack).
  - The isolation lemma; meet-in-the-middle and Schroeppel–Shamir; inclusion–exclusion algorithms; Karger's min-cut.
  - Approximation-algorithm templates: greedy set cover, LP rounding, primal–dual, and local search for k-median (Arya et al.).
  - Coffman–Graham two-processor scheduling.
- **Prerequisites.** ResourceBoundedComputation, PolyhedralCombinatorics.
- **Families.** 120 121 124 125 128 138.
- **Boundary.** Almost-linear max-flow (120) is frontier.

### Tier 3 (size M each)

- **SpaceBoundedComputationAndDerandomization** (cs.CC).
  - **Scope:** configuration graphs; Savitch; NL-completeness of reachability; Immerman–Szelepcsényi; Reingold's SL = L (consumes ExpanderGraphs); k-wise independence, small-bias spaces, Nisan's PRG for space, Saks–Zhou; Hopcroft–Paul–Valiant; Cook–Mertz tree evaluation; Williams' √(t log t) simulation.
  - **Families:** 103 137; also 112 and 116 for k-wise independence and hitting sets.
- **BooleanCircuitComplexity** (cs.CC).
  - **Scope:** Shannon–Lupanov counting; AC⁰, random restrictions and Håstad's switching lemma; Razborov–Smolensky; Paturi–Pudlák–Zane depth-3 bounds; Razborov's monotone clique bound; Khrapchenko and Nechiporuk; deterministic and randomized communication complexity with Karchmer–Wigderson; branching programs and streaming models.
  - **Families:** 112 140.
- **AutomataAndFiniteSemigroups** (cs.LO; secondary math.GR).
  - **Scope:** two-way automata (Shepherdson's crossing sequences, 2DFA = DFA); state complexity; syntactic monoids and recognition; Green's relations; Schützenberger's star-free theorem; Krohn–Rhodes; (generalized) star height and Eggan's theorem; relation and Brauer monoids.
  - **Families:** 129 134.
- **GamesOnGraphs** (cs.GT; secondary cs.LO).
  - **Scope:** arenas and strategies; positional determinacy of parity games (Emerson–Jutla) and mean-payoff games (Ehrenfeucht–Mycielski); energy games; Shapley discounted and stochastic games with Blackwell optimality; attractors, dominions and Zielonka's algorithm; strategy improvement; quasipolynomial parity algorithms (Calude–Jain–Khoussainov–Li–Stephan); Maker–Breaker games (Erdős–Selfridge, pairing strategies).
  - **Families:** 104 187.
- **OnlineAlgorithms** (cs.DS).
  - **Scope:** competitive analysis against oblivious and adaptive adversaries; Yao's principle; paging; k-server (the work-function algorithm, tree algorithms); metrical task systems on HSTs; prophet inequalities (Krengel–Sucheston, Samuel-Cahn); secretary problems including matroid secretary basics.
  - **Families:** 110 111.
- **WeisfeilerLemanAndCountingLogics** (cs.LO; secondary math.CO).
  - **Scope:** colour refinement and k-WL in both conventions, built on #257's equitable partitions; fractional isomorphism (Tinhofer); counting logics Cᵏ and Immerman–Lander; bijective pebble games (Hella); the Cai–Fürer–Immerman construction; homomorphism counts from bounded-treewidth graphs (Dvořák, Dell–Grohe–Rattan).
  - **Families:** 133, plus Logic-subject families such as choiceless polynomial time.
- **FastAlgebraicAlgorithms** (cs.DS; secondary math.NT).
  - **Scope:** Karatsuba, Toom–Cook, Schönhage–Strassen, and Harvey–van der Hoeven as final milestone; FFT algorithms (Cooley–Tukey, Bluestein, Rader, Nussbaumer); Newton division; fast CRT; polynomial factorization over finite fields (Berlekamp, Cantor–Zassenhaus).
  - **Boundary:** bit-cost models come from ResourceBoundedComputation. Birkbeck's ComputationalNumberTheory consumes it for number-theoretic algorithms.
  - **Families:** 109 130 142.
- **CombinatorialDesignsAndFiniteGeometry** (math.CO).
  - **Scope:** projective and affine geometries over 𝔽_q with incidence counts (on Mathlib's projective planes); block designs and Fisher's inequality; difference sets (Singer) and multiplier theorems; Bruck–Ryser–Chowla (consumes QuadraticFormInvariants for Hasse–Minkowski); Hadamard matrices (Sylvester, Paley); circulant Hadamard matrices via group rings and Turyn's and Schmidt's descent in cyclotomic integers; Barker sequences; rank and type counts of quadratic, symmetric and alternating forms over 𝔽_q and Lagrangian counts.
  - **Families:** 161 162 170 179.
- **SymmetricFunctions** (math.CO; secondary math.RT).
  - **Scope:** the ring Λ in infinitely many variables with bases m, e, h, p, s, ω and the Hall inner product, on SchurWeyl's finitely-many-variable theory; quasisymmetric functions and Gessel's fundamental basis; P-partitions; chromatic symmetric and quasisymmetric functions (Stanley, Shareshian–Wachs) with Gasharov's Schur-positivity. Elementary positivity of 169 itself is frontier.
  - **Families:** 169.
- **HeckeAlgebrasAndKazhdanLusztigTheory** (math.RT; secondary math.CO).
  - **Scope:** builds on RootSystems (strong exchange, Matsumoto) to give Bruhat order with the subword property, intervals and the Bruhat graph; Dyer's reflection subgroups and orders; the Iwahori–Hecke algebra of a Coxeter system; the bar involution; existence and uniqueness of the KL basis; R- and KL polynomials with their degree bounds and inversion formula; parabolic KL polynomials; combinatorial invariance for lower intervals. Positivity via Soergel bimodules is out of scope (frontier).
  - **Families:** 168.

**Suggested order.**
1. ResourceBoundedComputation, then ComplexityClasses.
2. In parallel: BooleanFunctionAnalysis, ShannonInformationTheory, ProbabilisticMethod, MarkovChainMixing, StructuralGraphTheory.
3. ExpanderGraphs and PolyhedralCombinatorics.
4. HardnessOfApproximation and AlgebraicComplexityTheory.
5. The rest.

## (d) Family-by-family classification

Abbreviations:
- RBC ResourceBoundedComputation; CCl ComplexityClasses; HoA HardnessOfApproximation; AlgC AlgebraicComplexityTheory.
- BFA BooleanFunctionAnalysis; BCC BooleanCircuitComplexity; Exp ExpanderGraphs; MCM MarkovChainMixing; SIT ShannonInformationTheory.
- PM ProbabilisticMethod; Ram RamseyTheory; Ext ExtremalGraphTheory; SGT StructuralGraphTheory; Mat MatroidsAndSubmodularity.
- Poly PolyhedralCombinatorics; CRME ConvexRelaxationsAndMetricEmbeddings; DGI DiscreteGeometryAndIncidences; Aut AutomataAndFiniteSemigroups.
- Games GamesOnGraphs; Onl OnlineAlgorithms; WL WeisfeilerLemanAndCountingLogics; Space SpaceBoundedComputationAndDerandomization.
- SymF SymmetricFunctions; HKL HeckeAlgebrasAndKazhdanLusztigTheory; Des CombinatorialDesignsAndFiniteGeometry; CAlg CombinatorialAlgorithms; FAlg FastAlgebraicAlgorithms.

The arXiv column is my assignment of the paper's primary category.

| # | Short title | arXiv | Class | Needs to state | Needs to prove | Note |
|---|---|---|---|---|---|---|
| 102 | Unique Games theorem; Max-Cut, VC, Min-UnCut, DFVS hardness | cs.CC | frontier | RBC, CCl, HoA, CRME | HoA, BFA, SIT | frontier (Khot–Minzer–Safra Grassmann expansion; Dinur–Steurer repetition; Håstad 3-LIN) |
| 103 | L = RL = BPL | cs.CC | frontier | Space, RBC | Space, KazhdanPropertyT, MCM | frontier (quantitative property (T) of SL_H(ℤ); ~100 pp new argument) |
| 104 | Quasipolynomial mean-payoff, stochastic, parity games | cs.GT | needs | Games, RBC | Games | needs GamesOnGraphs, ResourceBoundedComputation |
| 105 | 2-to-1 games with perfect completeness | cs.CC | frontier | CCl | HoA, BFA | frontier (Khot–Minzer–Safra Grassmann expansion) |
| 106 | 3-colourable graphs: no δn independent set | cs.CC | needs | CCl | HoA, BFA, Ram | needs HardnessOfApproximation; frontier input (Austin's continuous junta theorem) |
| 107 | Matrix multiplication ω ≤ 9/4 | cs.CC | needs | AlgC | AlgC, Mathlib | needs AlgebraicComplexityTheory (9/4 paper); 107b/c frontier (laser method + certificates) |
| 108 | Cubic permanent–determinant lower bound | cs.CC | frontier | AlgC | PlaneCurveSingularities, IntersectionTheory | frontier (Severi varieties in char p, scheme-theoretic curve singularities) |
| 109 | Integer multiplication below n log n | cs.DS | needs | RBC | FAlg, AlgC | needs ResourceBoundedComputation, FastAlgebraicAlgorithms; frontier base (Harvey–van der Hoeven) |
| 110 | O(log² k) randomized k-server | cs.DS | needs | Onl, RBC | CRME, Onl | needs OnlineAlgorithms, ConvexRelaxationsAndMetricEmbeddings |
| 111 | One-sample matroid prophet inequality | cs.DS | needs | Onl, Mat | Onl | needs OnlineAlgorithms, MatroidsAndSubmodularity |
| 112 | Depth-3 circuits beyond 2^√n | cs.CC | needs | CCl, RBC | BCC, CCl, PM | needs BooleanCircuitComplexity, ComplexityClasses |
| 113 | FPRAS for perfect matchings; matching-polytope entropy | cs.DS | needs | MCM, CCl, RBC, Poly | MCM, SGT, SIT, #397 | needs MarkovChainMixing, PolyhedralCombinatorics, ShannonInformationTheory |
| 114 | FPRAS for common (poly)matroid bases | cs.DS | frontier | MCM, CCl, Mat | MCM, Mat, Poly | frontier (Lorentzian polynomials, convex-body volume algorithms, GLS) |
| 115 | Contingency tables: exact sampling, FPRAS | cs.DS | needs | MCM, CCl, RBC | MCM | needs MarkovChainMixing, ResourceBoundedComputation |
| 116 | Noncommutative identity testing across characteristics | cs.CC | needs | AlgC, RBC | AlgC, Mathlib | needs AlgebraicComplexityTheory (116c also cyclic division algebras) |
| 117 | Uniform sparsest cut: hardness and SDP gaps | cs.CC | needs | CCl, CRME | CRME, AlgebraicCurves, HoA | needs ComplexityClasses, ConvexRelaxationsAndMetricEmbeddings; 117a also function-field towers |
| 118 | Bin packing: unbounded configuration-LP gaps, additive hardness | cs.DS | needs | Poly, CCl | Poly, HoA | needs PolyhedralCombinatorics; hardness half needs HardnessOfApproximation |
| 119 | Courtade–Kumar and Hellinger conjectures | cs.IT | needs | SIT, BFA | SIT, BFA, Mathlib | needs BooleanFunctionAnalysis, ShannonInformationTheory |
| 120 | Almost-linear exact matching in general graphs | cs.DS | frontier | RBC | SGT, CAlg, Exp | frontier (almost-linear max-flow, dynamic min-ratio cycles) |
| 121 | Almost-linear (1+ε) edit distance | cs.DS | needs | RBC, CCl | CAlg | needs ResourceBoundedComputation, CombinatorialAlgorithms (paper-specific beyond) |
| 122 | Trace reconstruction bounds and uniform decoder | cs.IT | needs | RBC | SIT, CRME | needs ShannonInformationTheory, ConvexRelaxationsAndMetricEmbeddings (SOS moments); research-level self-contained |
| 124 | Three-machine unit-job scheduling in P | cs.DS | elementary | RBC | CAlg | elementary (self-contained DP); needs ResourceBoundedComputation to state |
| 125 | Metric k-median threshold 1+2/e | cs.DS | needs | RBC, CCl | CAlg, Poly, HoA | needs CombinatorialAlgorithms, PolyhedralCombinatorics, HardnessOfApproximation (lower bound) |
| 126 | Exponential PSD rank of the matching polytope | math.OC | needs | Poly | CRME, BFA, SchurWeyl, Exp | needs PolyhedralCombinatorics, ConvexRelaxationsAndMetricEmbeddings (SOS), BooleanFunctionAnalysis |
| 127 | Average sensitivity of PTFs (Gotsman–Linial) | cs.CC | needs | BFA | BFA | needs BooleanFunctionAnalysis |
| 128 | 2-approximation for shortest common superstring | cs.DS | elementary | RBC, CCl | CAlg | elementary; needs ResourceBoundedComputation to state |
| 129 | Exponential state costs for two-way automata | cs.LO | needs | Aut | Aut | needs AutomataAndFiniteSemigroups |
| 130 | Exact DFT below n log n | cs.CC | needs | AlgC | AlgC, FAlg | needs AlgebraicComplexityTheory, FastAlgebraicAlgorithms |
| 131 | Switch chain mixes for every degree sequence | math.PR | needs | MCM | MCM | needs MarkovChainMixing |
| 132 | Superquadratic sensitivity vs block sensitivity | cs.CC | needs | BFA | BFA | needs BooleanFunctionAnalysis (query measures) |
| 133 | Complexity of Weisfeiler–Leman refinement | cs.CC | needs | WL, RBC, CCl | WL, RBC, SGT | needs WeisfeilerLemanAndCountingLogics, ResourceBoundedComputation, ComplexityClasses |
| 134 | Generalized star height at most 3 | cs.LO | needs | Aut | Aut, PM | needs AutomataAndFiniteSemigroups (+ local lemma) |
| 135 | Homogeneous depth-5 lower bounds for IMM | cs.CC | needs | AlgC | AlgC | needs AlgebraicComplexityTheory |
| 136 | Quasilinear PCP theorem for PPAD | cs.CC | frontier | CCl | HoA, Exp, KazhdanPropertyT | frontier (Helfgott, Bourgain–Gamburd, property (T) for EL_r) |
| 137 | One-tape time T in T^{2/5} space | cs.CC | needs | Space | Space | needs SpaceBoundedComputationAndDerandomization |
| 138 | Subset Sum in O(2^{0.49n}) | cs.DS | needs | RBC, CCl | CAlg | needs ResourceBoundedComputation, CombinatorialAlgorithms (isolation lemma) |
| 139 | Subpolynomial queries for log-concave sampling | math.PR | frontier | Mathlib | StochasticCalculus, SIT | frontier (stochastic calculus, high-order Gaussian tensor estimates) |
| 140 | Memory–sample lower bounds for Gaussian regression | cs.IT | needs | BCC, Mathlib | SIT | needs ShannonInformationTheory, BooleanCircuitComplexity (streaming model); research-level |
| 141 | Existential–universal reals in the counting hierarchy | cs.CC | needs | CCl, AlgC | RealAlgebraicGeometry | needs ComplexityClasses, RealAlgebraicGeometry, AlgebraicComplexityTheory |
| 142 | Deterministic polynomial factorization over 𝔽_p | cs.DS | frontier | RBC | FAlg, AlgebraicCurves, #253, Mathlib | frontier (companion uniform Hecke zero-free strip; Jacobians of superelliptic curves) |
| 155 | No periodic tiling in dimension 3 | math.CO | needs | DGI | DGI | needs DiscreteGeometryAndIncidences; minimality part frontier (Bhattacharya) |
| 156 | Borsuk fails in dimension 9 | math.MG | elementary | DGI | — | elementary (finite configuration + linear algebra) |
| 157 | Hadwiger and Colin de Verdière counterexamples; linear list Hadwiger | math.CO | frontier | SGT | PM, SIT, #66, #397 | frontier (new constructions; Reed–Seymour, Girão–Narayanan, Bollobás–Thomason) |
| 158 | The plane is not 5-colourable | math.CO | elementary | DGI | Mathlib | elementary + certified finite computation |
| 159 | Erdős reciprocal sums; quasipolynomial Szemerédi | math.CO | frontier | — | AdditiveCombinatorics | frontier (Leng–Sah–Sawhney inverse theorem, Green–Tao nilsequence equidistribution) |
| 160 | Superexponential van der Waerden numbers | math.CO | needs | Ram | PM | needs RamseyTheory, ProbabilisticMethod |
| 161 | Sidorenko and forcing counterexamples | math.CO | needs | DenseGraphLimits | Des, #397 | needs DenseGraphLimits (statement), CombinatorialDesignsAndFiniteGeometry |
| 162 | Ryser covering counterexamples | math.CO | needs | Ext | Des | needs CombinatorialDesignsAndFiniteGeometry |
| 164 | Hindman finite sums and products | math.CO | frontier | Ram | AdditiveCombinatorics, ErgodicRamseyTheory | frontier (GTZ inverse theorem, Tao–Ziegler concatenation, nilpotent IP recurrence) |
| 165 | Harary–Hill and Zarankiewicz crossing numbers | math.CO | needs | SGT | SGT | needs StructuralGraphTheory (drawings); elementary otherwise |
| 166 | Higher-dimensional distinct distances | math.CO | frontier | — | DGI, IntersectionTheory | frontier (Guth–Katz machinery, Hilbert-function bounds) |
| 167 | Weak pinned distances; unit-distance power saving | math.CO | frontier | — | DGI, SIT, #287 | frontier (new; needs DiscreteGeometryAndIncidences, ShannonInformationTheory, heights) |
| 168 | Combinatorial invariance of KL polynomials | math.CO | frontier | HKL | SoergelBimodules | frontier (Elias–Williamson, Fiebig moment graphs) |
| 169 | Shareshian–Wachs e-positivity | math.CO | frontier | SymF | ScatteringDiagrams | frontier (quantum tori, scattering diagrams) |
| 170 | Sharp log exponents for r(s,t) | math.CO | frontier | Ram | PM, SIT, Des, DGI, IntersectionTheory | frontier for s ≥ 6 (Nie–Wang); s = 5 needs RamseyTheory, ProbabilisticMethod, finite geometry |
| 171 | Hypercube Ramsey number Θ(2ⁿ) | math.CO | needs | Ram | PM, Ext | needs RamseyTheory, ProbabilisticMethod (no research black boxes; very long) |
| 172 | Classification of Euclidean Ramsey configurations | math.CO | needs | Ram | Ram | needs RamseyTheory (Euclidean) |
| 173 | Seymour's second-neighbourhood conjecture | math.CO | elementary | Mathlib | — | elementary |
| 174 | Strong thin trees, deterministic construction | math.CO | needs | SGT, RBC | SGT, Mat, Exp | needs StructuralGraphTheory, ExpanderGraphs (MSS), spectral graph theory |
| 175 | Expectation thresholds and discrete convexity | math.CO | needs | PM | PM, BFA | needs ProbabilisticMethod, BooleanFunctionAnalysis (p-biased) |
| 176 | Second Kahn–Kalai conjecture | math.CO | needs | PM | PM | needs ProbabilisticMethod |
| 177 | Bounded-degree coboundary expanders | math.CO | frontier | Exp | BuildingsAndCosetComplexes, Exp | frontier (cosystolic expansion of coset complexes, twin buildings, pro-stability) |
| 178 | Deterministic nonbipartite Ramanujan graphs | math.CO | frontier | Exp, RBC | Exp, PM | frontier-level new analysis; needs ExpanderGraphs, ResourceBoundedComputation |
| 179 | Circulant Hadamard and Barker conjectures | math.CO | needs | Des | Des | needs CombinatorialDesignsAndFiniteGeometry (cyclotomic descent) |
| 180 | Barnette's Hamiltonian-cycle conjecture | math.CO | needs | SGT | SGT, #444 | needs StructuralGraphTheory (planar maps); proofs elementary |
| 181 | Erdős–Gallai cycle decomposition | math.CO | needs | — | Ext, PM | needs ExtremalGraphTheory, ProbabilisticMethod |
| 182 | Power savings for polynomial differences | math.CO | needs | — | ExponentialSumsAndCircleMethod, #253 | needs circle method (Birkbeck); 182_2 frontier (claimed zero-free half-plane) |
| 183 | Halving lines O(n^{4/3−ε}) | math.CO | needs | DGI | DGI, SGT | needs DiscreteGeometryAndIncidences; new limiting argument |
| 184 | Correspondence colouring with forbidden subgraph; AEKS | math.CO | needs | SGT | PM, Ext | needs ProbabilisticMethod (nibble, LLL), StructuralGraphTheory (colouring variants) |
| 185 | Infinite matroid intersection/packing counterexamples | math.CO | needs | Mat | Mat | needs MatroidsAndSubmodularity (infinite matroids); elementary |
| 186 | Friedgut–Kalai threshold widths | math.CO | needs | BFA | BFA | needs BooleanFunctionAnalysis |
| 187 | Snaky in 21 Maker moves | math.CO | elementary | Games | Mathlib | elementary + certified finite computation |
| 188 | Sharp terminal leave in random triangle removal | math.CO | frontier | PM | PM | frontier (Joos–Kühn early-prefix control via differential-equations method) |
| 189 | Cycle–clique Ramsey numbers | math.CO | elementary | Ram | Mathlib | elementary + certified computation (3,099 cases) |
| 190 | Polynomial removal fails for ordered binary matrices | math.CO | needs | Ext, #66 | — | needs ExtremalGraphTheory (ordered patterns); construction elementary |
| 191 | Heilbronn triangle power improvement | math.CO | needs | DGI | PM | needs ProbabilisticMethod, DiscreteGeometryAndIncidences; self-contained |
| 192 | Square-root degree bound violated | math.CO | needs | BFA | BFA | needs BooleanFunctionAnalysis |

Counts: 7 elementary (124, 128, 156, 158, 173, 187, 189), 50 needs, 20 frontier.

"Elementary" means the proof uses no named theory beyond Mathlib and the vocabulary to state it is small. Several families classed "needs" have elementary proofs once their statement vocabulary exists: 129, 132, 134, 135, 165, 185, 190, 192. Their roadmap is a statement-level need.

## (e) Reusable OAI Lean infrastructure worth porting

All paths are under `oaimath/lean/OAI/`, Apache-2.0. Porting means re-specifying the mathematics in a roadmap and using these files as provenance, not copying the project structure. Most items exist in several private copies, so the first job of the corresponding roadmap is consolidation.

| Infrastructure | Where | For roadmap |
|---|---|---|
| Structured stack-program language with exact cost, compiled to Mathlib TM2 with finite alphabets; `RunsInPolyTime.comp` | `Computability/Superstring/{Instructions,Clock,PolynomialTime,Combinators,Computable}.lean` | ResourceBoundedComputation |
| Finite-alphabet invariant for `Turing.FinTM2` (Mathlib forces only `Γ k₀` finite) | `…/Machines/MachineFiniteAlphabet.lean` in UniqueGames and others; every comparator's `FiniteAlphabet` | ResourceBoundedComputation |
| Hand-built TM2 libraries: copy, compare, binary parsing, arithmetic, table emission, loop and runtime lemmas | `UniqueGames/Machines` (144 files), `IndependentSets/Machines`, `PerfectCompleteness/Machines`, `MaxCut/Machines`, `MinUncut/Machines`, `DirectedFeedback/Machines`, `BinPacking/Computation` | ResourceBoundedComputation (consolidate) |
| Word-RAM and multitape-TM models with time; randomized coin-reading TM0 machines; FPRAS statement template | comparators `WeisfeilerLeman.lean`, `EditApproximation.lean`, `MatchingFPRAS.lean`, `ContingencyTables.lean`, `CommonBasesFPRAS.lean` | ResourceBoundedComputation, ComplexityClasses |
| `NPVerifier`/`InNP`, `GapReduction`, 3SAT encoding and decoder | comparators `DirectedFeedback.lean`, `BinPackingGap.lean`, `VertexCover.lean` | ComplexityClasses |
| Cook–Levin on TM2: tableau and window semantics; circuit encoding of bounded execution | `Computability/DirectedFeedback/CookLevin/NPTableau.lean`; `Computability/BinPacking/CookLevin` (27 files); `Combinatorics/KMedian/CookLevin` | ComplexityClasses |
| Dinur gap amplification, expander tables, alphabet reduction, assignment testers, all with explicit TM2 reductions | `Computability/UniqueGames/PCP` (and copies in MaxCut, MinUncut, VertexCover, BinPacking, IndependentSets) | HardnessOfApproximation |
| Parallel repetition (Holenstein; projection games) | `Computability/VertexCover/Repetition/Holenstein.lean`, `UniqueGames/Repetition`, `PerfectCompleteness/Repetition`, `MaxCut/Games` | HardnessOfApproximation |
| Håstad 3-bit test, long-code folding, Fourier decoding | `Computability/VertexCover/Fourier/{ThreeBitTest,Folding,Walsh,Decoder}.lean` | HardnessOfApproximation |
| Khot–Minzer–Safra Grassmann expansion and the inverse shortcode theorem | `Computability/UniqueGames/Inverse` (KMS*.lean, ShortcodeTheorem.lean) | HardnessOfApproximation (final milestone) |
| Walsh–Fourier basis, noise operator, hypercontractive estimates, Boolean derivatives | `Combinatorics/SharpThreshold/Fourier*.lean`, `GotsmanLinial/Walsh*.lean`, `BooleanFunctions/Walsh.lean` | BooleanFunctionAnalysis |
| Discrete information theory: chain rule, Pinsker, tensorization, log-sum | `Computability/VertexCover/Information`, `UniqueGames/Foundations/PinskerLemmas.lean` | ShannonInformationTheory |
| Zig-zag spectral bound, spectral cuts; TM-generated explicit expander families | `Computability/BinPacking/Expanders`, `UniqueGames/Machines/MachineExpanderFamily*.lean` | ExpanderGraphs |
| Spectral-gap and mixing argument for a Markov chain on graphs | `Probability/SwitchChain` (222 files) | MarkovChainMixing |
| Tensor degeneration, Coppersmith–Winograd tensors, arithmetic programs with cost | `LinearAlgebra/MatrixMultiplication` (509 files), `LinearAlgebra/MatrixFields` (354 files); comparator `MatrixMultiplication.lean` (`Program F Input r`) | AlgebraicComplexityTheory |
| Plane drawings with continuous arcs, polygonal normalization, crossing counts | `Combinatorics/Crossing` (339 files), `Combinatorics/CompleteCrossing` | StructuralGraphTheory |
| Clique-minor models, list-colouring machinery | `Combinatorics/ListHadwiger/{MinorModels,Basic}.lean` | StructuralGraphTheory |
| Finite Lovász local lemma (measure form) | `Combinatorics/ProgressionColoring/FiniteLocalLemma*.lean`, `BalancedRyser/Local` | ProbabilisticMethod |
| Filtered nilmanifolds, Mal'cev/BCH coordinates, nilsequence tests | `Combinatorics/Progressions/Nilpotent` (139 files) | Birkbeck AdditiveCombinatorics AC.3 |
| Two-way automata semantics; relation and Brauer monoid arguments | `Combinatorics/TwoWayAutomata`, `Combinatorics/Automata` | AutomataAndFiniteSemigroups |
| Mean-payoff game arenas, positional strategies, energy and box fixed points | `Computability/MeanPayoff` (72 files) | GamesOnGraphs |
| WL refinement in both conventions, CFI-style parity lifts | `Combinatorics/VariableWL`, `Combinatorics/ParityLifts`, `Computability/WeisfeilerLeman`, `Computability/WLIdentification` | WeisfeilerLemanAndCountingLogics |
| Infinite partitional matroids on Mathlib `Matroid` | `Combinatorics/InfiniteMatroid` | MatroidsAndSubmodularity |
| Hecke-algebra, Bruhat-interval and Bott–Samelson constructions (stated not to prove Elias–Williamson) | `RepresentationTheory/KazhdanLusztig` (34 files, 43k lines) | HeckeAlgebrasAndKazhdanLusztigTheory |
| Certified case analyses | `Combinatorics/Ramsey/CycleClique` (2.8M generated lines), comparator `SnakyCertificate.lean`, `Geometry/PlaneColoring` | tooling precedent (shows the cost of certificate expansion) |

Two cautions.
- **Status is uneven.** `formalization.yaml` declares overall status "Partial progress", and only 37 of these families have a catalogued main result. The KL files say explicitly that they do not prove the Elias–Williamson input.
- **Size reflects private duplication.** The code is organized per paper, with private copies of shared theory, and is optimized for a single theorem. A Tau Ceti roadmap should specify the general statements (Cook–Levin for all NP languages, the PCP theorem as a gap-preserving reduction from 3SAT, composition of polytime functions) and cite these files only as provenance.
