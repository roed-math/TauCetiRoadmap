# Campaign COMB: combinatorics (math.CO, cs.DM)

Phase-2 slate, 2026-10-07. Machine-readable form: `slate_COMB.json` (families carry their sub-roadmaps under `subroadmaps`).

## 1. Scope

**Classes:** math.CO, cs.DM. Combinatorics studies finite and countable discrete structures (graphs, hypergraphs, set systems, matroids, designs, polytopes, configurations of points) through their extremal, probabilistic, structural, algebraic and enumerative behaviour. In Tau Ceti terms it is the campaign of `SimpleGraph`, `Finset`, `Matroid` and finite Fourier analysis, where Mathlib is already strong and most roadmaps can start at once.

**Demand** (`needs_all.jsonl`):

| | rows | refs | gap | mathlib | open-pr | tauceti-roadmap | birkbeck | tauceti-code |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| COMB primary | 109 | 58 | 62 | 34 | 8 | 2 | 2 | 1 |
| by goal | OpenAI 108, Annals 1 (#94), LMFDB 0 | | | | | | | |

- 99 rows come from `openai_combinatorics_tcs.md`; 64 are proof needs, 45 statement needs; the 62 gap rows span 39 refs.
- Interface demand: 55 rows of other campaigns list COMB as secondary (47 refs); 14 more rows propose a roadmap that BOUNDARIES.md assigns here (PolyhedralCombinatorics ×7 tagged math.OC, BooleanFunctionAnalysis ×5 tagged cs.CC, CombinatorialDesignsAndFiniteGeometry ×1, Borsuk–Ulam ×1 tagged math.AT).
- LMFDB needs nothing from COMB. Annals needs #94 (expanders, spectral gap) and, through ExpanderGraphs, feeds #86 and #99.

## 2. Existing supply

| Roadmap | Covers | Goal contribution | Action |
|---|---|---|---|
| DenseGraphLimits (main; archive PR #721, awaiting-author) | graphons, cut distance, homomorphism densities, sampling, exchangeable graph laws | statement vocabulary of OAI#161 (Sidorenko, forcing) | finish #721; ExtremalGraphTheory's Sidorenko layer consumes it |
| AlgebraicCodingTheory (main; archive #724, awaiting-review; math.IT, so LTCS owns) | codes, MacWilliams, Golay codes; excludes designs | input to designs | merge #724; Designs consumes it (Assmus–Mattson, Witt designs) |
| GraphConnectivityAndFlows (#444, no label, opened 09-24) | blocks, ears, Menger, max-flow/min-cut, circulations, Gomory–Hu, bipartite matching and edge-colouring, orientations | OAI#180, #089; supplier of #271's planarity layer and of four slate roadmaps | **put to review and merge soon**. Its exclusions go to: general matching → Matchings; general edge-colouring → Coloring; Dilworth → Enumerative; tree packing, arborescences → Matroids; min-cost flows, Nash-Williams orientation → Polyhedral; treewidth, drawings → Structural; multicommodity flows → LTCS |
| Regularity (#66, awaiting-review since 07-08, the oldest COMB PR) | finite weak, strong graph, and arity-3 hypergraph regularity with counting | OAI#157, #190; RamseyTheory (Chvátal–Rödl–Szemerédi–Trotter) and ExtremalGraphTheory (induced removal) consume it | **merge soon**; then **extend** to arbitrary-arity hypergraph regularity, counting and removal (~100 PRs), which AdditiveCombinatorics needs for Szemerédi's theorem |
| EquitableOperatorReduction (#257, awaiting-author, S) | equitable partitions as matrix intertwiners | LTCS's WeisfeilerLemanAndCountingLogics (OAI#133) | merge after revision; SpectralGraphTheory does not depend on it |
| SpectralQuantumWalks (#258), DiscreteQuantumWalks (#259) (awaiting-author, S each) | continuous- and discrete-time quantum-walk dynamics; despite #258's title, little static spectral theory | none of the three goals | consolidate into one QuantumWalks roadmap consuming GraphTheory/SpectralGraphTheory; low priority; topic (math.CO or FAMP) for the authors to settle |
| PlanarTopology + SurfaceTopology (#271, awaiting-review; math.GT, TOP owns) | Jordan, Schoenflies, Radó; **SurfaceTopology layers 5 and 10**: rotation systems, Heffter–Edmonds–Ringel, Euler's formula, minors, Kuratowski, Wagner, wheel theorem, Whitney, Mac Lane, Fáry, Tutte's spring embedding, five-colour theorem | OAI#165, #180, #183, #211 | **merge soon**: seven slate roadmaps consume layers 5 and 10, which go well beyond the Jordan-curve side. Its exclusion Grötzsch → GraphColoring; graphs on general surfaces and Robertson–Seymour stay unowned |
| AdditiveCombinatorics (Birkbeck campaign; AC.0–AC.5, ~6 KB stub) | sumsets, BSG/Freiman, Roth/Szemerédi, Gowers norms, transference, linear equations in primes | OAI#159, #164 (frontier parts), ANA's OAI#086 | **split by stage** (coordination §3.3): AC.0–AC.3 become COMB's AdditiveCombinatorics (slate), AC.4–AC.5 stay NT; coordinate with Birkbeck first |
| Neighbours: RandomMatrices #397 (PRDS) | Talagrand, McDiarmid | supplier | merge; ProbabilisticMethod's nibble layer uses it |

No explorer draft (`research/blueprint/roadmaps/*.json`) falls in math.CO.

## 3. The slate

Three umbrella families on the RepresentationTheory model and four standalone L roadmaps; 18 roadmaps in 7 review units. Every gap need of the campaign maps to one of them (§4 lists the parts that do not). Sizes follow capacity.md §2.2. Object and milestone lists below are abridged (milestones: first four and last three); the JSON has them in full, with the phase-1 proposals each roadmap replaces. OAI paths are under `lean/OAI/` (C = Combinatorics, Cmp = Computability).

### GraphTheory — math.CO, XL family (~950 PRs, 5 sub-roadmaps), wave A (sub-roadmaps A/B)

A family of roadmaps for the structure of finite graphs on Mathlib's `SimpleGraph` and `Graph`: matchings and factors, colouring, minors with tree decompositions, Hamiltonicity and drawings, spectra, and expansion. Connectivity, Menger and flows are GraphConnectivityAndFlows (#444); planarity, Euler's formula, Kuratowski–Wagner, plane duality and the five-colour theorem are SurfaceTopology layer 10 (#271); regularity is Regularity (#66); graph limits are DenseGraphLimits; extremal and Ramsey problems are the ExtremalAndProbabilisticCombinatorics family; random graphs are PRDS's. The umbrella pins shared conventions: `SimpleGraph V` with `[Fintype V]` as the primary carrier, Mathlib's `Graph α β` for multigraph statements, matrices as adapters, and the American spelling of Mathlib (`Coloring`).

- *Family goals:* OpenAI 21 distinct families; Annals: Annals#94.

#### GraphTheory/MatchingsAndFactors — math.CO, M (~130 PRs), wave A (Kasteleyn layer B: SurfaceTopology #271)

This roadmap develops matching theory in general graphs from Mathlib's perfect matchings and Tutte's theorem: the Tutte–Berge formula and the Gallai–Edmonds structure theorem, factor-critical graphs, f-factors and b-matchings, and stable matchings. It treats the matching polynomial (Godsil's path tree, Heilmann–Lieb), Pfaffian orientations with Kasteleyn's theorem for planar graphs and the Temperley bijection, and upper and lower bounds for permanents. Bipartite matching, Kőnig and Hall come from Mathlib and GraphConnectivityAndFlows; matching polytopes are PolyhedralCombinatorics'; the van der Waerden bound is LogConcavityAndStablePolynomials'; algorithms with running times are LTCS's CombinatorialAlgorithms.

- *Objects:* deficiency; Gallai–Edmonds decomposition; factor-critical graph; f-factor; stable matching. *Milestones:* Tutte–Berge; Gallai–Edmonds; Petersen; Lovász ear decomposition of factor-critical graphs; Kasteleyn for planar graphs; Temperley bijection; Brégman–Minc and Schrijver's lower bound.
- *Prerequisites:* Mathlib SimpleGraph.Tutte, Hall; GraphConnectivityAndFlows (#444); SurfaceTopology (#271) layers 5 and 10 for plane maps. *Goals:* OpenAI 4: 113, 120, 218, 226.
- *Porting:* OAI C/{PerfectMatching,MatchingCount,Permanent,PortMatching}. *Formalizability:* High; Kasteleyn needs faces of plane maps from #271.

#### GraphTheory/GraphColoring — math.CO, L (~200 PRs), wave A (Thomassen and Grötzsch layers B: #271)

This roadmap develops vertex, edge, list, correspondence and fractional colouring beyond Mathlib's `SimpleGraph.Coloring`: the classical bounds (Brooks, Gallai–Roy, Hajnal–Szemerédi), the Mycielski and Hajós constructions, the chromatic polynomial, perfect graphs, Grötzsch's theorem, edge colouring of simple graphs and multigraphs, list colouring by the Combinatorial Nullstellensatz and by kernels, planar choosability, DP-colouring, and the fractional chromatic number with its LP dual. Kőnig's bipartite edge-colouring theorem is GraphConnectivityAndFlows'; the five-colour theorem is SurfaceTopology's; probabilistic colouring bounds are ProbabilisticMethod's; Lovász's Kneser theorem is DiscreteGeometryAndIncidences'.

- *Objects:* degeneracy; chromatic polynomial; perfect graph; kernel; list assignment and choosability. *Milestones:* degeneracy bounds and Brooks; Gallai–Roy; Mycielski and Hajós; Hajnal–Szemerédi; Thomassen 5-choosability and Erdős–Rubin–Taylor; DP-colouring basics; fractional chromatic number and LP duality, Kneser graphs.
- *Prerequisites:* Mathlib SimpleGraph.Coloring, Combinatorics/Nullstellensatz; GraphConnectivityAndFlows (#444); SurfaceTopology (#271) layer 10; PolyhedralCombinatorics (LP duality layer). *Goals:* OpenAI 4: 106, 157, 158, 184.
- *Porting:* OAI C/ListHadwiger/{Basic,ColorBins}. *Formalizability:* High; Grötzsch (Thomassen's proof) is the long layer.

#### GraphTheory/StructuralGraphTheory — math.CO, L (~250 PRs), wave B (SurfaceTopology #271, GraphConnectivityAndFlows #444)

This roadmap develops graph structure under minors and decompositions, Hamiltonicity, and drawings with crossings. It takes minors, Kuratowski and Wagner from SurfaceTopology and connectivity and Menger from GraphConnectivityAndFlows, and builds the extremal theory of complete minors, tree decompositions, treewidth and brambles, the excluded grid theorem, linkage, the Colin de Verdière invariant, sufficient conditions for Hamiltonicity including Tutte's theorem on 4-connected planar graphs, crossing numbers with good-drawing normalization, and tournaments. Tree packing is MatroidsAndSubmodularity's and the crossing lemma DiscreteGeometryAndIncidences'; the Robertson–Seymour structure and well-quasi-ordering theorems are not part of this roadmap.

- *Objects:* minor model and Hadwiger number; tree decomposition, treewidth, bramble; linkage; Colin de Verdière invariant; Hamiltonian closure. *Milestones:* Mader and Kostochka–Thomason; Hadwiger for t ≤ 4; Seymour–Thomas treewidth–bramble duality; treewidth of grids and the excluded grid theorem; crossing and rectilinear crossing numbers, good-drawing normalization; Zarankiewicz and Harary–Hill upper bounds, Kleitman parity; Rédei and Camion.
- *Prerequisites:* SurfaceTopology and PlanarTopology (#271); GraphConnectivityAndFlows (#444); MatroidsAndSubmodularity (tree packing). *Goals:* OpenAI 7: 089, 133, 157, 165, 174, 180, 183.
- *Porting:* OAI C/{Crossing (339 files),CompleteCrossing,ListHadwiger/MinorModels,HadwigerMatching,TreewidthL1,PlanarL1,Hamiltonian}. *Formalizability:* Medium; drawings and the excluded grid theorem are the expensive layers.

#### GraphTheory/SpectralGraphTheory — math.CO, M (~140 PRs), wave A

This roadmap develops the spectral theory of finite graphs on Mathlib's `adjMatrix` and `lapMatrix`: adjacency and Laplacian spectra, interlacing, Perron–Frobenius, eigenvalue bounds on independence and chromatic numbers, the Lovász theta function, strongly regular graphs, the matrix-tree theorem, effective resistance on finite networks, and the nonbacktracking operator with the Ihara–Bass formula. Expansion is ExpanderGraphs'; random walks on infinite networks and uniform spanning trees are PRDS's ProbabilityOnTreesAndNetworks; quantum-walk dynamics are #258/#259; the semidefinite formulation of ϑ is LTCS's ConvexRelaxationsAndMetricEmbeddings.

- *Objects:* normalized Laplacian; interlacing; Perron vector; Lovász ϑ; strongly regular graph. *Milestones:* Perron–Frobenius for connected graphs and bipartite symmetry; Courant–Fischer, Cauchy and Haemers interlacing; spectra of standard families and products; Hoffman ratio and Delsarte–Hoffman bounds; matrix-tree (all minors); Foster, Thomson and Dirichlet principles, Rayleigh monotonicity; Ihara–Bass.
- *Prerequisites:* Mathlib AdjMatrix, LapMatrix, Matrix.IsHermitian spectral theorem. *Goals:* OpenAI 5: 174, 178, 214, 231, 271; Annals: Annals#94.
- *Porting:* OAI C/GraphSpectrum; OAI Probability/SpanningForest (matrix-tree parts); Graphplay (cited by #258). *Formalizability:* High.

#### GraphTheory/ExpanderGraphs — math.CO, L (~230 PRs), wave A (MSS layer B: LogConcavityAndStablePolynomials; property-(T) family B: ALG AmenabilityAndPropertyT)

This roadmap develops expansion of finite graphs and its high-dimensional analogue: edge, vertex and spectral expansion, the Cheeger inequalities, the expander mixing lemma, Alon–Boppana, random walks on expanders, Ramanujan graphs, explicit families (algebraic, from property (T), zig-zag, 2-lifts, interlacing families), and simplicial high-dimensional expanders with local-to-global theorems and coboundary expansion. It consumes SpectralGraphTheory for spectra and LogConcavityAndStablePolynomials for interlacing families. The Ramanujan property of the Lubotzky–Phillips–Sarnak and Margulis graphs is NT's (it rests on the Ramanujan–Petersson bound); Friedman's second-eigenvalue theorem is not part of this roadmap; metric-embedding consequences are GEO's MetricEmbeddings.

- *Objects:* Cheeger constant; (n,d,λ)-graph; Ramanujan graph; zig-zag product; 2-lift. *Milestones:* Cheeger inequalities (both directions); expander mixing lemma and Bilu–Linial converse; Alon–Boppana; expander hitting and Chernoff bounds; Garland and Oppenheim trickle-down; local-to-global theorem for up–down walks; coboundary and cosystolic expansion basics.
- *Prerequisites:* GraphTheory/SpectralGraphTheory; LogConcavityAndStablePolynomials (interlacing families); ALG AmenabilityAndPropertyT (Margulis construction). *Goals:* OpenAI 6: 120, 126, 136, 174, 177, 178; via consumer roadmaps 094, 102, 103, 105, 106, 285, 307, 330; Annals: Annals#94, Annals#86 (feeds), Annals#99 (feeds).
- *Porting:* OAI Cmp/BinPacking/Expanders (ZigzagSpectral); OAI Cmp/UniqueGames/Machines/MachineExpanderFamily*; OAI C/Coboundary; OAI Geometry/Coboundary; OAI C/ThinTrees. *Formalizability:* High; cosystolic expansion is medium.

### ExtremalAndProbabilisticCombinatorics — math.CO, XL family (~830 PRs, 4 sub-roadmaps), wave A

A family for extremal problems on graphs, hypergraphs and set systems and for the probabilistic method that drives them. Mathlib supplies Turán, Erdős–Stone, Zarankiewicz, Szemerédi regularity, triangle removal, Hales–Jewett, Hindman, LYM, Kruskal–Katona, Erdős–Ko–Rado, Sauer–Shelah, Hoeffding, Azuma and the `binomialRandom` measure; Regularity (#66) supplies weak, strong and arity-3 hypergraph regularity; DenseGraphLimits supplies homomorphism densities. General concentration inequalities and the structure of random graphs are PRDS's; Fourier-analytic threshold theorems are BooleanFunctionAnalysis'; additive problems are AdditiveCombinatorics'.

- *Family goals:* OpenAI 21 distinct families.

#### ProbabilisticMethod — math.CO, L (~270 PRs), wave A (nibble/Kim–Vu layer uses RandomMatrices #397 for Talagrand)

This roadmap develops the probabilistic method as finite tools on Mathlib's probability spaces and `binomialRandom`: moments and alterations, Janson's inequalities, the local lemma with Moser–Tardos and entropy compression, dependent random choice, correlation inequalities, polynomial concentration, discrepancy, thresholds of monotone properties of product measures (through Park–Pham), hypergraph containers, the nibble and the differential-equations method. Sharp-threshold theorems are BooleanFunctionAnalysis'; the structure of random graphs (phase transition, configuration model, random regular graphs) is PRDS's RandomGraphsAndConstraintSatisfaction; concentration inequalities beyond Mathlib's Hoeffding and Azuma are PRDS's.

- *Objects:* local-lemma dependency graph; spread family; expectation threshold; container family; nibble. *Milestones:* Erdős lower bound and alterations; Janson inequalities (both tails, Suen); LLL (symmetric, asymmetric, lopsided) and Moser–Tardos; entropy compression; Pippenger–Spencer; Wormald DE theorem with the triangle-free and triangle-removal processes; Johansson–Molloy.
- *Prerequisites:* Mathlib Hoeffding, Azuma, binomialRandom, four-functions theorem; ExtremalSetTheory (spread families); RandomMatrices (#397) for Talagrand. *Goals:* OpenAI 13: 112, 134, 157, 160, 170, 171, 175, 176, 178, 181, 184, 188, 191; via consumer roadmaps 219, 235, 285.
- *Porting:* OAI C/{ProgressionColoring/FiniteLocalLemma*,BalancedRyser/Local,ExpectationThreshold,GraphThreshold,DiscreteConvexity}; LeanCamCombi (Cambridge combinatorics courses; coordinate). *Formalizability:* Medium–high; the differential-equations method is the long layer.

#### ExtremalGraphTheory — math.CO, L (~220 PRs), wave A (removal layers B: Regularity #66)

This roadmap develops extremal problems for graphs and hypergraphs on Mathlib's Turán, Erdős–Stone–Simonovits and Zarankiewicz API: supersaturation, bipartite Turán numbers with their algebraic constructions, cycles and paths, independence-number bounds in sparse graphs, Sidorenko's conjecture in its known cases, graph decompositions, hypergraph Turán densities, matchings and covers, ordered graphs and 0–1 matrices, the blow-up lemma and induced removal. Ramsey problems are RamseyTheory's; set systems are ExtremalSetTheory's; regularity itself is Regularity (#66).

- *Objects:* extremal number; supersaturation; norm graph; Turán density; hypergraph cover number τ. *Milestones:* supersaturation; Kővári–Sós–Turán with projective-plane and norm-graph sharpness; Bondy–Simonovits; Erdős–Gallai; Füredi–Hajnal and Marcus–Tardos; blow-up lemma; induced removal (Alon–Fischer–Krivelevich–Szegedy).
- *Prerequisites:* Mathlib Turán, Erdős–Stone, Zarankiewicz, regularity; DenseGraphLimits; Regularity (#66); CombinatorialDesignsAndFiniteGeometry (constructions); ProbabilisticMethod; DiscreteGeometryAndIncidences (Sperner/KKM). *Goals:* OpenAI 7: 157, 161, 162, 171, 181, 184, 190.
- *Porting:* OAI C/{Sidorenko,CliqueFree,CycleDecomposition,MatrixRemoval,Ryser,BalancedRyser,TriangleRemoval}; LeanCamCombi. *Formalizability:* High.

#### RamseyTheory — math.CO, L (~220 PRs), wave A (bounded-degree layer B: Regularity #66)

This roadmap develops Ramsey theory for graphs, hypergraphs, arithmetic and Euclidean configurations; Mathlib has Hales–Jewett and Hindman but no finite graph Ramsey theorem. It covers Ramsey numbers and their classical bounds, stepping-up, canonical Ramsey, the off-diagonal numbers r(3,t) and r(4,t), the exponential improvement for diagonal numbers, bounded-degree graphs and Ramsey goodness, van der Waerden and Rado-type partition regularity, and Euclidean Ramsey theory. Density theorems (Szemerédi, density Hales–Jewett) are AdditiveCombinatorics' and PRDS's ErgodicRamseyTheory.

- *Objects:* Ramsey number r(H₁,…,H_k); hypergraph Ramsey number; van der Waerden number; partition-regular system; Ramsey configuration in ℝⁿ. *Milestones:* Ramsey (finite and infinite) and Erdős–Szekeres; Erdős–Hajnal stepping-up; Erdős–Rado canonical Ramsey; AKS/Shearer and Kim bounds for r(3,t); Schur and Rado; Folkman–Rado–Sanders and Deuber; Frankl–Rödl and Kříž.
- *Prerequisites:* Mathlib HalesJewett, Hindman; ProbabilisticMethod; ExtremalGraphTheory (independence bounds); Regularity (#66); CombinatorialDesignsAndFiniteGeometry (Mattheus–Verstraëte construction). *Goals:* OpenAI 7: 106, 160, 164, 170, 171, 172, 189.
- *Porting:* OAI C/{Ramsey,RamseyFive,SharpRamsey,EuclideanRamsey,SphericalRamsey}; Mehta's Lean 3 formalization of the exponential diagonal Ramsey bound (coordinate); LeanCamCombi. *Formalizability:* High; Kim and CGMS are long but have literature-level detail and, for CGMS, a Lean 3 precedent.

#### ExtremalSetTheory — math.CO, M (~120 PRs), wave A

This roadmap develops extremal set theory beyond Mathlib's Sperner, LYM, Kruskal–Katona, Erdős–Ko–Rado, Harris–Kleitman and Sauer–Shelah material: intersection theorems through Ahlswede–Khachatrian, the linear-algebra method, sunflowers and spread families, VC-dimension beyond Sauer–Shelah, Kleitman's diameter theorem and union-closed families. It exports the Frankl–Wilson theorems that DiscreteGeometryAndIncidences uses for the chromatic number of ℝⁿ and the Kahn–Kalai counterexamples. Slice rank and cap sets are AdditiveCombinatorics'; designs are CombinatorialDesignsAndFiniteGeometry's.

- *Objects:* t-intersecting family; sunflower; spread family; VC-dimension; union-closed family. *Milestones:* Hilton–Milner; Katona t-intersection and Ahlswede–Khachatrian; Frankl–Wilson and Ray-Chaudhuri–Wilson; Oddtown and Bollobás set pairs (exterior algebra); Haussler packing and dual VC-dimension; Kleitman diameter; Gilmer union-closed.
- *Prerequisites:* Mathlib Combinatorics/SetFamily; Mathlib binEntropy (Gilmer). *Goals:* OpenAI 3: 156, 175, 176.
- *Porting:* LeanCamCombi (source of Mathlib's Kruskal–Katona and Ahlswede–Zhang). *Formalizability:* High.

### EnumerativeAndAlgebraicCombinatorics — math.CO, XL family (~790 PRs, 5 sub-roadmaps), wave A

A family for exact counting and for algebraic structures in combinatorics: enumeration and posets, symmetric functions, log-concavity and stable polynomials, matroids, and designs and finite geometries. It extends Mathlib's `Combinatorics/Enumerative`, `Matroid`, `Configuration` and `HadamardMatrix` material and consumes RepresentationTheory/SchurWeyl (tableaux, RSK, Schur polynomials in finitely many variables) and AlgebraicCodingTheory (codes and weight enumerators). Coxeter combinatorics and Kazhdan–Lusztig theory are ALG's; q-series with modular content stay with NT.

- *Family goals:* OpenAI 17 distinct families; Annals: Annals#94.

#### EnumerativeCombinatorics — math.CO, L (~200 PRs), wave A (Quillen fiber lemma layer uses AlgebraicTopology; maps layer uses #271)

This roadmap develops enumerative combinatorics in the scope of Stanley's EC1 and EC2 chapters 5–6, on Mathlib's `PowerSeries` and `Combinatorics/Enumerative`: generating functions and the exponential formula, Lagrange inversion, rational, algebraic and D-finite series, the transfer-matrix method, lattice paths, Pólya–Redfield counting, permutation statistics, q-analogues, tree and planar-map enumeration with the classical map bijections, and posets (Möbius inversion, distributive lattices, chain and antichain theorems, order complexes). Symmetric functions are SymmetricFunctions'; random maps and scaling limits are PRDS's RandomTreesAndMaps; q-series with modular content are NT's.

- *Objects:* exponential formula; D-finite series; transfer matrix; Möbius function; order complex. *Milestones:* exponential formula; Lagrange inversion (one and several variables); closure of rational, algebraic, D-finite series; transfer-matrix method; Rota crossbar/closure, Birkhoff representation; Dilworth, Mirsky, Greene–Kleitman; P. Hall μ = χ̃ and Quillen fiber lemma (homology).
- *Prerequisites:* Mathlib PowerSeries, Combinatorics/Enumerative; SurfaceTopology (#271) rotation systems; AlgebraicTopology (main) simplicial homology. *Goals:* OpenAI 2: 211, 310.
- *Porting:* Mathlib Combinatorics/Enumerative; Tau Ceti TauCeti/Combinatorics/Enumerative. *Formalizability:* High.

#### SymmetricFunctions — math.CO, M (~130 PRs), wave A

This roadmap develops the ring Λ of symmetric functions in infinitely many variables, the graded inverse limit of Mathlib's symmetric `MvPolynomial`s: the classical bases, the Hall inner product and ω, the Cauchy identities, the Littlewood–Richardson rule, plethysm, Hall–Littlewood and Macdonald polynomials, quasisymmetric and noncommutative symmetric functions, P-partitions, and chromatic symmetric and quasisymmetric functions. It extends RepresentationTheory/SchurWeyl's finite-variable Schur polynomials and Frobenius characteristic. Specht modules, Schur functors and Kronecker coefficients are RepresentationTheory's; positivity theorems resting on geometry (Haiman's n! theorem) are not part of this roadmap.

- *Objects:* Λ and its bases; Hall inner product; Littlewood–Richardson coefficient; plethysm; Macdonald polynomial. *Milestones:* bases m, e, h, p, s and ω; Hall inner product and Cauchy identities; Littlewood–Richardson rule (jeu de taquin); Pieri and Jacobi–Trudi in Λ; QSym–NSym duality, Gessel fundamental basis; Stanley P-partitions; chromatic symmetric/quasisymmetric functions and Gasharov.
- *Prerequisites:* RepresentationTheory/SchurWeyl (main); Tau Ceti TauCeti/Combinatorics/Young; EnumerativeCombinatorics. *Goals:* OpenAI 2: 169, 210.
- *Porting:* OAI C/Chromatic (549 files); Tau Ceti Young tableaux and RSK code. *Formalizability:* High.

#### LogConcavityAndStablePolynomials — math.CO, M (~130 PRs), wave A (Mason layer uses MatroidsAndSubmodularity)

This roadmap develops real-rootedness, log-concavity and stability of polynomials as tools for combinatorics: interlacing and interlacing families, real stable polynomials and the barrier method with the Marcus–Spielman–Srivastava theorem on Weaver's KS₂, real-rooted independence and matching polynomials, strongly Rayleigh measures, Gurvits' capacity, and Lorentzian polynomials with the log-concavity theorems for matroids. Hyperbolic polynomials in Gårding's generality, hyperbolicity cones and spectrahedra are ANA's ConvexAlgebraicGeometry; the operator-algebra form of Kadison–Singer is FAMP's; determinantal point processes are PRDS's.

- *Objects:* interlacing family; real stable polynomial; barrier function; strongly Rayleigh measure; capacity. *Milestones:* Newton inequalities and log-concavity closure; common interlacers and interlacing families; real stable polynomials, closure, determinantal pencils; barrier method and MSS KS₂; Gurvits capacity and van der Waerden; Brändén–Huh Lorentzian polynomials; Mason ultra-log-concavity and basis-generating log-concavity.
- *Prerequisites:* Mathlib Polynomial, Matrix.PosSemidef; MatroidsAndSubmodularity; GraphTheory/MatchingsAndFactors (Heilmann–Lieb). *Goals:* OpenAI 6: 114, 174, 178, 231, 271, 300; Annals: Annals#94.
- *Porting:* OAI Probability/StrongRayleigh (133 files); OAI C/{ThinTrees,MatroidCounting}. *Formalizability:* High.

#### MatroidsAndSubmodularity — math.CO, L (~200 PRs), wave A

This roadmap develops matroid theory on Mathlib's `Matroid` (arbitrary ground sets, duality, minors): exchange and greedy characterizations, geometric lattices, connectivity, binary and representable matroids, graphic matroids, Edmonds' intersection and Nash-Williams' union theorems with their packing, covering, tree-packing and arborescence corollaries, submodular functions and polymatroids, the Tutte and characteristic polynomials, and infinite matroids. Matroid polytopes are PolyhedralCombinatorics'; Lorentzian log-concavity is LogConcavityAndStablePolynomials'; algorithms are LTCS's.

- *Objects:* geometric lattice; binary/regular matroid; matroid union; polymatroid; Lovász extension. *Milestones:* Rado–Edmonds greedy, strong and multiple exchange; flats and geometric lattices; connectivity and 2-sums; Tutte's binary excluded minor, Fano/non-Fano; Tutte polynomial universality and specializations; characteristic polynomial via lattice of flats; finitary/cofinitary classes and Bowler–Carmesin intersection and packing/covering.
- *Prerequisites:* Mathlib Combinatorics/Matroid; EnumerativeCombinatorics (Möbius functions); SurfaceTopology (#271) 2-isomorphism theorem. *Goals:* OpenAI 4: 111, 114, 174, 185.
- *Porting:* apnelson1/Matroid (origin of Mathlib's Matroid and Graph; coordinate); OAI C/{InfiniteMatroid,MatroidCounting}. *Formalizability:* High.

#### CombinatorialDesignsAndFiniteGeometry — math.CO, M (~130 PRs), wave A

This roadmap develops designs and finite geometries: projective and affine spaces over 𝔽_q on Mathlib's `Projectivization` and `Configuration`, projective planes and their classical substructures, block and t-designs, Latin squares, difference sets, Hadamard matrices (real, circulant, complex), mutually unbiased bases, association schemes with Delsarte's bound, and counts of forms over 𝔽_q by rank and type. It consumes AlgebraicCodingTheory for the Golay codes, QuadraticFormInvariants for Bruck–Ryser–Chowla and NumberFieldArithmetic for cyclotomic descent. Coding theory is AlgebraicCodingTheory's; existence of designs by absorption (Keevash) is not part of this roadmap.

- *Objects:* t-design; symmetric design; MOLS; difference set; Hadamard matrix. *Milestones:* subspace counts via Gaussian binomials; Bruck–Ryser, ovals and Segre; Hermitian unital and classical generalized quadrangles; Fisher and Bruck–Ryser–Chowla; Butson Hadamard and MUBs in prime-power dimension; Bose–Mesner algebra and Delsarte LP bound; form counts over 𝔽_q and Lagrangian counts.
- *Prerequisites:* Mathlib Configuration, Projectivization, Matrix.IsHadamard, QuadraticForm; AlgebraicCodingTheory (main); QuadraticFormInvariants (main); NumberFieldArithmetic (main) cyclotomic integers; EnumerativeCombinatorics (q-analogues). *Goals:* OpenAI 5: 161, 162, 170, 179, 266.
- *Porting:* Mathlib HadamardMatrix; Tau Ceti TauCeti/InformationTheory/Coding. *Formalizability:* High.

### BooleanFunctionAnalysis — math.CO, L (~240 PRs), wave A

This roadmap develops the analysis of Boolean functions in the scope of O'Donnell's book, on Mathlib's finite abelian Fourier transform and Gaussian measures: Walsh and p-biased Fourier analysis, influences, noise stability, hypercontractivity on the cube and on finite product spaces, junta and sharp-threshold theorems, linearity testing, query-complexity measures, polynomial threshold functions, and Gaussian analysis through the invariance principle and Majority is Stablest. The Gaussian isoperimetric inequality in measure form and general log-Sobolev theory are PRDS's; PCP and hardness reductions are LTCS's HardnessOfApproximation; Austin's continuous junta theorem is not part of this roadmap.

- *Objects:* Walsh character; influence; noise operator T_ρ; p-biased basis; sensitivity/block sensitivity. *Milestones:* Walsh, p-biased and Efron–Stein expansions; influences and noise stability; Bonami lemma and Bonami–Beckner on cube and product spaces; cube log-Sobolev; Hermite analysis and Ornstein–Uhlenbeck; Mossel–O'Donnell–Oleszkiewicz invariance; Borell noise stability and Majority is Stablest.
- *Prerequisites:* Mathlib finite abelian Fourier, Gaussian measures, CLT; StandardDistributions (main). *Goals:* OpenAI 13: 099, 102, 105, 106, 119, 126, 127, 132, 175, 186, 192, 274, 284.
- *Porting:* OAI C/{SharpThreshold (78 files),GotsmanLinial,BooleanFunctions,Sensitivity}; OAI Cmp/VertexCover/Fourier; OAI Walsh copies under Computability/UniqueGames. *Formalizability:* High; five private OAI Walsh libraries show the core is routine.

### DiscreteGeometryAndIncidences — math.CO, L (~260 PRs), wave A (crossing lemma B: #271; polynomial partitioning and Guth–Katz C: AG inputs)

This roadmap develops discrete and combinatorial geometry: convexity theorems of Helly–Radon–Tverberg type, topological methods (Sperner, Tucker, Borsuk–Ulam, ham sandwich, Kneser), ε-nets and cuttings, incidence bounds, k-sets, the polynomial method and polynomial partitioning through the Guth–Katz distinct-distance theorem, distance and colouring problems in ℝᵈ, and translational tilings of ℤᵈ. Euclidean Kakeya and restriction are ANA's; convex bodies are GEO's; Brouwer's fixed-point theorem is DifferentialGeometry's; Milnor–Thom bounds and ruled-surface theory are AG's.

- *Objects:* Tverberg partition; ε-net; cutting; halving line; partitioning polynomial. *Milestones:* Tverberg, colorful Carathéodory and Helly, fractional Helly, centerpoints; Erdős–Szekeres happy ending; Sperner, KKM, Tucker; Borsuk–Ulam and Lyusternik–Shnirelman; Kahn–Kalai; Komlós–Pintz–Szemerédi Heilbronn; Newman and Bhattacharya tilings.
- *Prerequisites:* Mathlib Radon/Helly/Carathéodory, UnitDistance, Tiling, simplicial complexes; SurfaceTopology (#271) noncrossing drawings; RealAlgebraicGeometry plus the AG targets of §4; ExtremalSetTheory; RamseyTheory; ProbabilisticMethod. *Goals:* OpenAI 11: 073, 074, 077, 155, 156, 158, 166, 167, 170, 183, 191.
- *Porting:* OAI C/{HalvingLines,Distances,Crossing}; OAI Geometry/{PinnedDistances,UnitDistances,PlaneColoring,PeriodicTiling,Borsuk,HeilbronnTriangle}. *Formalizability:* Medium; Guth–Katz is the hardest layer and needs AG inputs.

### PolyhedralCombinatorics — math.CO, L (~220 PRs), wave A

This roadmap develops polyhedra and polyhedral combinatorics on Mathlib's `PointedCone` (`FG`, `DualFG`, faces) and Tau Ceti's `IsConvexPolyhedron`: Minkowski–Weyl, face lattices and f-vectors of polytopes, linear-programming duality, total unimodularity and total dual integrality (with min-cost and submodular flows), polyhedral descriptions of matchings, T-joins, flows, matroids and stable sets, extended formulations through Rothvoss's theorem, and Ehrhart theory. The ellipsoid method and the Grötschel–Lovász–Schrijver theorem are LTCS's CombinatorialAlgorithms; SDP and sum-of-squares are LTCS's ConvexRelaxationsAndMetricEmbeddings; convex bodies are GEO's.

- *Objects:* polyhedron/polytope; face lattice; f-vector; TU matrix; TDI system. *Milestones:* Minkowski–Weyl; face lattice, Bruggesser–Mani, Euler–Poincaré, Dehn–Sommerville; cyclic polytopes and McMullen's upper bound theorem; Balinski and Steinitz; Yannakakis, nonnegative and PSD rank; Rothvoss; Ehrhart, Ehrhart–Macdonald reciprocity, Pick.
- *Prerequisites:* Mathlib PointedCone (DualFG, faces), Birkhoff, IsTotallyUnimodular; Tau Ceti IsConvexPolyhedron, Stiemke; GraphConnectivityAndFlows (#444); MatroidsAndSubmodularity; GraphTheory/GraphColoring (perfect graphs); SurfaceTopology (#271) for Steinitz. *Goals:* OpenAI 6: 089, 113, 114, 118, 125, 126.
- *Porting:* OAI C/{MatchingPSD,PerfectMatching}; Mathlib polyhedral-cone work by M. Winter (defer to its shape). *Formalizability:* High; Rothvoss is the long final layer.

### AdditiveCombinatorics — math.CO, L (~220 PRs), wave A (Szemerédi layer B: Regularity extension; Green–Tao–Ziegler C)

This roadmap develops additive combinatorics in abelian groups on Mathlib's sumset, Plünnecke–Ruzsa, Freiman-homomorphism, energy, Cauchy–Davenport, Behrend and corners material: Balog–Szemerédi–Gowers, Freiman-type inverse theorems including polynomial Freiman–Ruzsa in bounded torsion, Bohr sets, sum–product estimates, Roth's theorem with the Kelley–Meka bound, cap sets, Szemerédi's theorem, and higher-order Fourier analysis through the Green–Tao–Ziegler inverse theorem. Transference to the primes and linear equations in primes are NT's; ergodic proofs and IP recurrence are PRDS's ErgodicRamseyTheory; continuous Gowers norms are ANA's.

- *Objects:* sumset and doubling constant; Freiman homomorphism; Bohr set; Gowers U^k norm; nilsequence. *Milestones:* Balog–Szemerédi–Gowers; Green–Ruzsa Freiman; PFR in bounded torsion (GGMT); Bogolyubov–Ruzsa and Chang; U² and U³ inverse theorems over 𝔽_pⁿ and ℤ/N; nilmanifolds, Mal'cev bases, polynomial nilsequences; Green–Tao–Ziegler.
- *Prerequisites:* Mathlib Combinatorics/Additive; Regularity (#66) extended to arbitrary arity; DiscreteGeometryAndIncidences (Szemerédi–Trotter for Elekes); BooleanFunctionAnalysis (Fourier on 𝔽₂ⁿ). *Goals:* OpenAI 4: 013, 086, 159, 164.
- *Porting:* LeanAPAP (Kelley–Meka; coordinate); PFR project (Apache-2.0; coordinate); Lean 3 cap-set formalization (Dahmen–Hölzl–Lewis); OAI C/{Progressions/Nilpotent (139 files),SumProduct}. *Formalizability:* High through U³; Green–Tao–Ziegler is very long.

## 4. Needs not absorbed

Every gap row maps to a slate roadmap; what remains are frontier inputs inside those rows and parts owned elsewhere (OAI#173 is elementary on Mathlib `Digraph`).

| Need (refs) | Reason | Owner or action |
|---|---|---|
| Khot–Minzer–Safra Grassmann expansion, 2-to-2 games (102, 105) | LTCS-tagged | LTCS HardnessOfApproximation, final milestone |
| distinct distances in higher dimension, Hilbert-function bounds (166); Nie–Wang bounds for r(s,t), s ≥ 6 (170) | frontier | AG IntersectionTheory for the inputs |
| pinned distances, unit-distance power saving (167) | frontier (new) | needs ArithmeticHeights #287 |
| Austin's continuous junta theorem (102, 106); Joos–Kühn prefix control (188) | frontier | none |
| Leng–Sah–Sawhney inverse theorem (159); Green–Tao–Ziegler with nilpotent IP recurrence (164) | frontier | IP recurrence: PRDS ErgodicRamseyTheory |
| e-positivity input of 169 (scattering diagrams) | frontier | AG ScatteringDiagrams |
| combinatorial invariance of KL polynomials (168) | math.RT | ALG HeckeAlgebrasAndKazhdanLusztigTheory, SoergelBimodules |
| cosystolic expansion of coset complexes (177) | frontier | ALG BuildingsAndCosetComplexes |
| Friedman's theorem; deterministic nonbipartite Ramanujan graphs (178; FAMP's 330; Annals #99) | frontier-scale (Bordenave's proof) | propose as final milestone of PRDS's RandomGraphsAndConstraintSatisfaction |
| Ramanujan property of Lubotzky–Phillips–Sarnak and Margulis graphs | arithmetic (rule 4) | NT: QuaternionArithmetic with Ramanujan–Petersson for weight 2 |
| almost-linear max-flow (120) | frontier | LTCS |
| dimer statistics beyond Kasteleyn and Temperley (226) | math-ph | FAMP IntegrableLatticeModels |
| FK-weighted maps, Sheffield's bijection, scaling limits (211) | math.PR | PRDS RandomTreesAndMaps |
| Quillen's poset of p-subgroups (310) | finite group theory | ALG; the homotopy-level fiber lemma is TOP's |
| quantum-information use of MUBs (266); paving of MASAs (300) | math-ph, math.OA | FAMP QuantumInformationTheory, VonNeumannAlgebras |
| metric half of 099; multicommodity flow–cut gaps (089) | math.MG, cs.DS | GEO MetricEmbeddings, LTCS ConvexRelaxationsAndMetricEmbeddings |
| local laws of random regular graphs (178) | math.PR | PRDS (#397, RandomGraphsAndConstraintSatisfaction) |
| arbitrary-arity hypergraph regularity and removal | too small for a roadmap | extend Regularity (#66) |
| Milnor–Thom/Warren bound; Cayley–Salmon flecnode theorem | math.AG prerequisites of DiscreteGeometryAndIncidences' last layers | ask AG to add them (RealAlgebraicGeometry, or a surfaces roadmap) |

## 5. Cross-campaign interface

**Imports.** TOP: SurfaceTopology/PlanarTopology #271 (plane maps, minors, drawings), AlgebraicTopology (simplicial homology for Quillen's fiber lemma). NT: QuadraticFormInvariants (Bruck–Ryser–Chowla), NumberFieldArithmetic (cyclotomic descent). ALG: RepresentationTheory/SchurWeyl, AmenabilityAndPropertyT (Margulis expanders). PRDS: RandomMatrices #397 (Talagrand). AG: RealAlgebraicGeometry plus the two targets of §4. LTCS: AlgebraicCodingTheory.

**Exports.**
- LTCS: BooleanFunctionAnalysis → HardnessOfApproximation, BooleanCircuitComplexity, query complexity; ExpanderGraphs → HardnessOfApproximation (PCP), SpaceBoundedComputationAndDerandomization (Reingold); PolyhedralCombinatorics and MatroidsAndSubmodularity → ConvexRelaxationsAndMetricEmbeddings, CombinatorialAlgorithms, OnlineAlgorithms; StructuralGraphTheory (treewidth) → WeisfeilerLemanAndCountingLogics; SpectralGraphTheory (ϑ) → ConvexRelaxationsAndMetricEmbeddings.
- PRDS: SpectralGraphTheory (matrix-tree, effective resistance) and LogConcavityAndStablePolynomials (strongly Rayleigh) → ProbabilityOnTreesAndNetworks; ProbabilisticMethod and BooleanFunctionAnalysis (thresholds) → RandomGraphsAndConstraintSatisfaction; EnumerativeCombinatorics (maps) → RandomTreesAndMaps; ExpanderGraphs (local-to-global) → MarkovChainsAndMixing.
- FAMP: MatchingsAndFactors (Kasteleyn, Temperley) → IntegrableLatticeModels; LogConcavityAndStablePolynomials (KS₂) → VonNeumannAlgebras; CombinatorialDesignsAndFiniteGeometry (MUBs, complex Hadamard) → QuantumInformationTheory.
- GEO: ExpanderGraphs, BooleanFunctionAnalysis → MetricEmbeddings (089, 094, 099, 307).
- ANA: DiscreteGeometryAndIncidences (polynomial partitioning, Borsuk–Ulam, finite-field Kakeya, joints) → KakeyaAndProjections (073, 074, 077); AdditiveCombinatorics → TimeFrequencyAnalysis (086).
- ALG: ExpanderGraphs and ProbabilisticMethod (local lemma) → CombinatorialGroupTheory (graphical small cancellation, 285); SymmetricFunctions → representation-theoretic plethysm (210).
- NT: AdditiveCombinatorics → AC.4–AC.5 and sieve roadmaps; EnumerativeCombinatorics (q-analogues) → QSeriesPartitionsAndMockModularForms.

**Boundary decisions taken here** (rule 3, most foundational owner):
- **Borsuk–Ulam belongs to COMB**, in DiscreteGeometryAndIncidences' topological layer, proved through Tucker's lemma on an antipodally symmetric triangulation and stated on Mathlib's `Metric.sphere` in `EuclideanSpace ℝ (Fin (n+1))`. Its consumers are combinatorial or harmonic-analytic (ham sandwich and polynomial partitioning for 166 and 170, ANA's Kakeya families 073/074/077, Kneser, necklace splitting). The Tucker route needs only finite simplicial complexes and compactness, all in Mathlib, so it is wave A. The homological route needs the cohomology ring of ℝPⁿ or a degree theorem for odd maps, which neither AlgebraicTopology nor DifferentialGeometry lists. arXiv practice (Matoušek's *Using the Borsuk–Ulam theorem* and its literature) is math.CO. TOP keeps equivariant index theory and may add the degree-theoretic proof as a cross-check.
- Thresholds of monotone properties of product measures (Bollobás–Thomason, subgraph appearance, Park–Pham) are COMB's; random-graph structure is PRDS's.
- Kirchhoff's theorem and effective resistance on finite networks are COMB's (SpectralGraphTheory); PRDS's network theory starts at infinite graphs and spanning-tree measures.
- Kasteleyn's theorem and the Temperley bijection are COMB's (MatchingsAndFactors).
- Strongly Rayleigh measures and real stable polynomials are COMB's; Gårding hyperbolic polynomials and spectrahedra are the proposed ConvexAlgebraicGeometry's (math.OC, so ANA).
- Brégman–Minc is COMB's; LTCS's ShannonInformationTheory owns entropy and Shearer's inequality and may cite Brégman as an application.

## 6. Order and people

**First five to draft** (demand × unblocking, within the WIP cap of three open PRs):
1. **GraphTheory umbrella with SpectralGraphTheory and ExpanderGraphs**: the only Annals need (#94), six OAI families directly, and eight more through LTCS, GEO, ALG and FAMP roadmaps; wave A.
2. **BooleanFunctionAnalysis**: 13 OAI families; prerequisite of LTCS's HardnessOfApproximation; replaces five private OAI Walsh libraries.
3. **ExtremalAndProbabilisticCombinatorics umbrella with ProbabilisticMethod and RamseyTheory**: 13 and 7 OAI families; supplies ALG and PRDS.
4. **PolyhedralCombinatorics**: 6 OAI families; prerequisite of three LTCS roadmaps and of matroid polytopes.
5. **EnumerativeAndAlgebraicCombinatorics umbrella with MatroidsAndSubmodularity and LogConcavityAndStablePolynomials**: feeds ExpanderGraphs' interlacing-family layer, OAI 111/114/174/178/300 and PRDS.

Then the other sub-roadmaps, DiscreteGeometryAndIncidences and AdditiveCombinatorics (after Birkbeck agrees). Before any of this, push #66, #444 and #271 through review: ten slate roadmaps cite them.

**Expertise.** Lead: a combinatorialist spanning graph theory and extremal/probabilistic combinatorics who writes idiomatic Mathlib (`Finset`, `Finpartition`, `SimpleGraph.Walk`, `Matroid`), since most of the campaign extends existing Mathlib APIs. Reviewers: structural graph theory and drawings (shared with #271/#444, authors mccorvie and fzaiser), extremal/probabilistic (cameronfreer, #66), algebraic combinatorics (symmetric functions, matroids), a TCS-facing analyst for BooleanFunctionAnalysis and ExpanderGraphs (shared with LTCS), and a discrete geometer (shared with ANA's Kakeya roadmap). Coordinate before porting with LeanCamCombi, LeanAPAP, PFR, Mehta's exponential-Ramsey formalization, apnelson1/Matroid and the OAI release.

**Open questions for the owner.**
1. Is an umbrella with five 60–120 KB sub-READMEs really one review? Proposed: land each umbrella with two sub-roadmaps, then add the rest as sub-roadmap PRs.
2. BOUNDARIES.md does not list additive combinatorics under COMB; coordination §3.3 assigns AC.0–AC.3 to math.CO. Planned here as COMB pending Birkbeck's agreement.
3. Confirm the four boundary decisions of §5 that cut across PRDS and FAMP proposals (thresholds, Kirchhoff, Kasteleyn, strongly Rayleigh).
4. Who settles the topic of #257–#259: math.CO, or FAMP's quantum lane?

## 7. Totals

| | count | est. PRs |
|---|---:|---:|
| XL families (umbrellas) | 3 | 2,570 |
| — sub-roadmaps L / M | 8 / 6 | |
| standalone L | 4 | 940 |
| **new roadmaps** | **18 (12 L, 6 M) in 7 review units** | **3,510** |
| extension of Regularity (#66) | 1 | ~100 |
| existing supply in territory, open PRs (#444, #66, #257–#259) | 5 | ~430 |
| existing supply, complete (DenseGraphLimits; AlgebraicCodingTheory, LTCS-owned) | 2 | 0 remaining |

The slate serves 69 OpenAI families directly and 7 more through consumer roadmaps, plus Annals #94 (#86 and #99 as feeds). Of COMB's 58 primary refs, only OAI#173 (elementary) needs no roadmap.
