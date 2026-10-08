# Boundary pass over the ten campaign slates (2026-10-07)

Inputs: `slate_*.json`, `campaign_*.md` §3–§5, `roadmap_leaves.json`, BOUNDARIES.md, the supply indexes, Birkbeck stage
headings. Scripts: scratchpad `p3-boundary/` (`g.py` grep, `prq.py` prerequisite resolver, `cyc.py` graph and waves).
The 280 slate items carry 850 prerequisite strings: 421 tokens resolve to proposals, 244 to main, 15 to Completed, 137
to open PRs, 17 to Birkbeck roadmaps, 54 to nothing (about 20 are prose). Data caveats: NT's 44 promotion units
(≈16,100 PRs) are missing from `roadmap_leaves.json` although AG's 15 are there; NT sub-roadmaps there have empty
scope and wave `?`. Owners follow BOUNDARIES, then prerequisite theory, most general form, "arithmetic X consumes X".
"md" marks evidence only in the campaign markdown (GEO's JSON has no milestones).

## 1. Double ownership

| # | Object(s) | A | B | Evidence A | Evidence B | Owner, reason |
|---|---|---|---|---|---|---|
| D1 | Finite-metric embeddings: Fréchet, Bourgain, JL, cut cone, flow–cut gap, Enflo, Brinkman–Charikar, Assouad | GEO MetricEmbeddings | LTCS Algorithms/MetricEmbeddingsAndConvexRelaxations | "Fréchet, Bourgain and Johnson–Lindenstrauss, L₁ as the cut cone" | "Fréchet, Bourgain; Johnson–Lindenstrauss; ℓ₁ = cut cone"; "Enflo; Assouad; Brinkman–Charikar" | LTCS: BOUNDARIES assigns it; LTCS already merged GEO's proposal. GEO keeps doubling/quasisymmetric geometry (M) |
| D2 | McShane, Kirszbraun, coarse embeddings | GEO MetricEmbeddings | FAMP BanachSpaceTheory/NonlinearGeometry | "Lipschitz extension … coarse embeddings" | "Lipschitz extension (McShane, Kirszbraun, Ball) … coarse embeddings" | FAMP: Banach geometry pre-decided; ANA already cites FAMP for Kirszbraun |
| D3 | Strong convergence (Haagerup–Thorbjørnsen, Collins–Male, Bordenave–Collins), Friedman | FAMP OperatorAlgebras/FreeProbability | PRDS StrongConvergenceOfRandomMatrices | "It ends with strong convergence … Friedman's theorem as a corollary" | "Haagerup–Thorbjørnsen; Collins–Male; polynomial method; Bordenave–Collins; Friedman" | PRDS: exists for this (sibling of #397, whose boundary excludes it); random-matrix proofs. FAMP consumes |
| D4 | Chern–Weil forms; Beauville–Bogomolov statement | AG KahlerManifolds; K3AndHyperkahler | GEO ConnectionsAndCharacteristicClasses; KahlerGeometry | "Chern connection and curvature, Griffiths and Nakano positivity, Chern–Weil forms"; "Beauville–Bogomolov decomposition is stated" | "holonomy and Chern–Weil theory"; md "Statements: Bogomolov decomposition" | GEO (GEO assigns the Chern connection to AG as consumer of Chern–Weil; BB rests on holonomy). Rest of the Kähler split is consistent |
| D5 | Principal G-bundles; signature theorem; Rokhlin; Chern–Gauss–Bonnet | TOP CharacteristicClassesAndCobordism; SurgeryTheoryAndFourManifolds | GEO Connections…; DiracOperatorsAndIndexTheory | "Vector and principal bundles, their classifying spaces"; "the signature theorem"; "prove Whitehead–Milnor, Rokhlin" | "principal bundles with Lie structure group"; "corollaries Chern–Gauss–Bonnet, the signature theorem"; md "Rokhlin" | TOP: topological bundles, BG, classes, σ = ⟨L,[M]⟩; GEO refines the carrier, proves Chern–Weil = TOP classes, Dirac aliases σ. Rokhlin: GEO Dirac. CGB once, in Connections |
| D6 | Allard, monotonicity, ε-regularity, dimension reduction, Simons cone, Bernstein, isoperimetric/CMC regularity | GEO GlobalAnalysisOnManifolds/MinimalSubmanifolds | ANA GMT/CurrentsAndVarifolds, MinimalBoundariesAndIsoperimetry | "Allard regularity, De Giorgi ε-regularity … the Simons cone and Bernstein's theorem" | "minimality of the Simons cone … Bernstein's theorem, exporting them to GEO"; "Allard's … regularity theorems" | ANA (BOUNDARIES). GEO keeps index, calibrations, Weierstrass, Douglas–Radó, SSY, μ-bubbles. Align "n ≤ 7" vs "n ≤ 8" |
| D7 | Oka and Cartan coherence on ℂⁿ | AG ComplexAnalyticSpaces | ANA SeveralComplexVariables | milestone "Oka coherence" | "Oka's and Cartan's coherence theorems on ℂⁿ" | ANA (SCV pre-decided; AG says it consumes SCV) |
| D8 | Multiplier ideals, Nadel vanishing | AG VanishingTheorems | ANA PluripotentialTheory | "algebraic multiplier ideals … with Nadel and local vanishing" | "analytic multiplier ideals with Nadel vanishing" | Nadel for ℚ-divisors stated once (AG); ANA proves the psh form and J(D) = J(φ_D) |
| D9 | K-Bessel, Whittaker functions | NT ClassicalAutomorphicForms | ANA LinearDifferentialEquationsAndSpecialFunctions | "K-Bessel functions, Fourier-Whittaker expansions" | "Whittaker functions; Bessel J, Y, I, K"; replaces "MaassForms… (NT; K-Bessel layer)" | ANA; NT consumes |
| D10 | Stone–von Neumann | NT MetaplecticFormsAndTheta | FAMP ManyBodyQuantumMechanics | "metaplectic groups over local fields, Stone-von Neumann, Weil indices" | "Slawny; Stone–von Neumann; Shale" | FAMP, Mackey's LCA form, in a wave-A/B FAMP roadmap (ManyBody is C, NT's consumer B) |
| D11 | RH for curves (Stepanov–Bombieri) | NT ArithmeticOfFiniteFields | AG WeilConjecturesAndWeights (P3) | "proves the Riemann hypothesis by Stepanov-Bombieri" | "the curve case also by Stepanov–Bombieri as an independent route" | NT (NT's stated ruling; wave A vs C) |
| D12 | Hyperelliptic models, Igusa invariants, genus-2 Aut | NT HyperellipticCurves | AG GeometryOfCurves | md "genus-2 invariants (Igusa–Clebsch, J₂…J₁₀, G2) with the isomorphism theorem" | "Igusa invariants characterizing k̄-isomorphism, with genus-two automorphism groups" | AG over k̄; NT keeps twists, Mestre, minimal models, clusters |
| D13 | CM types, CM abelian varieties | AG AbelianVarieties | NT unit U16 (CM…ExplicitReciprocity) | "CM types and CM abelian varieties" | Birkbeck: "treats CM types, orders, ideal actions, class polynomials" | AG over ℂ; U16 reflex norms, Shimura–Taniyama, class fields |
| D14 | Siegel sets; Mahler; Howe–Moore, Mautner | NT AdelicAlgebraicGroups; ALG Lattices…, AmenabilityAndPropertyT | PRDS HomogeneousDynamics | NT "Siegel sets, Borel-Harish-Chandra finiteness"; ALG "Mahler's criterion and Siegel sets for SL_n(Z)"; "Howe-Moore and Mautner" | "Mahler; Howe–Moore; Furstenberg unique ergodicity" | Siegel sets NT (ALG drops its SL_n(ℤ) copy); Mahler, Howe–Moore ALG; PRDS consumes |
| D15 | Nilpotent Lie groups, lattices, Mal'cev bases | ALG NilpotentSolvableAndLinearGroups | COMB AdditiveCombinatorics; PRDS ErgodicRamseyTheory | "Mal'cev completions and bases, torsion-free nilpotent groups as lattices" | "nilmanifolds, Mal'cev bases, polynomial nilsequences"; "nilsystems … Host–Kra" | ALG; PRDS nilsystem dynamics; COMB polynomial sequences |
| D16 | Szemerédi's theorem | COMB AdditiveCombinatorics | PRDS ErgodicRamseyTheory | "cap sets, Szemerédi's theorem" | "Furstenberg–Zimmer; Szemerédi; Furstenberg–Katznelson" | COMB states; PRDS proves recurrence and derives into it |
| D17 | Borsuk–Ulam, (polynomial) ham sandwich, Lovász–Kneser | TOP TopologicalCombinatorics | COMB DiscreteGeometryAndIncidences | "Borsuk–Ulam in its equivalent forms, ham-sandwich and polynomial ham-sandwich, Lovász–Kneser" | "Borsuk–Ulam and Lyusternik–Shnirelman"; "Lovász–Kneser (Greene)" | R6: TOP, by COMB's Tucker route; COMB keeps Sperner/KKM/Tucker and applications. COMB argued the opposite |
| D18 | Quillen fiber lemma; p-subgroup posets | TOP TopologicalCombinatorics | COMB EnumerativeCombinatorics; ALG StructureOfFiniteGroups | "Quillen's fiber lemma … Quillen's theorems on p-subgroup posets" | "Quillen fiber lemma (homology)"; "Brown-Quillen homotopy equivalence" | TOP (homotopy form implies homology form); ALG keeps group theory |
| D19 | Borel equivariant cohomology, topological localization | AG EquivariantCohomologyAndLocalization | TOP TransformationGroups | "Borel equivariant cohomology of spaces with actions of compact Lie groups" | "Borel cohomology, Smith theory, the Borel–Atiyah–Segal–Quillen localization theorem" | TOP (it says AG consumes these layers); AG keeps Chow versions, BB, GKM |
| D20 | GW axioms, quantum cohomology, QH(Pⁿ) | AG GromovWittenTheory | GEO PseudoholomorphicCurves | "Kontsevich–Manin axioms … small and big quantum cohomology and WDVV" | "genus-zero Gromov–Witten invariants and quantum cohomology"; md "QH(CPⁿ)" | One axioms ⇒ quantum-product layer, GEO (wave B vs C); both constructions verify it |
| D21 | Complex Bott periodicity | TOP TopologicalKTheory | FAMP OperatorKTheory | "complex Bott periodicity (Atiyah–Bott)" | "stability and continuity, Bott periodicity" | FAMP (all C*-algebras; FAMP already proves Swan); TOP derives |
| D22 | K₀, Hattori–Stallings trace (both port OAI `BassTrace`) | ALG GroupRings | TOP ClassicalKTheory | "Hattori-Stallings rank on K_0(K[G])" | "rank, determinant, Pic and the Hattori–Stallings trace" | TOP; ALG keeps the Bass conjecture |
| D23 | Margulis lemma, thick–thin; Mostow | ALG LatticesInSemisimpleGroups | TOP HyperbolicManifolds | "Margulis lemma, thick-thin stated"; "Mostow rigidity" | "the Margulis lemma with thick–thin and cusps … Mostow rigidity" | ALG proves Kazhdan–Margulis for Lie groups; TOP specializes, proves Mostow |
| D24 | Liouville–Arnold | GEO SymplecticManifolds | PRDS TwistMapsBilliardsAndKAM | "toric domains, and Liouville–Arnold" | "It proves the Liouville–Arnold theorem and the KAM theorems" | GEO; PRDS keeps KAM |
| D25 | GHP topology | GEO MetricGeometry | PRDS RandomTreesAndMaps | md "mGH, GHP; asymptotic cones" | "Gromov–Hausdorff–Prokhorov topology, which it builds on compact metric measure spaces" | GEO (pointed measured GH is general); PRDS asked for this assent |
| D26 | Isotropic position; Prékopa–Leindler; slicing | GEO ConvexBodies | PRDS GaussianAnalysisAndLogConcaveMeasures | "John ellipsoid, isotropic position"; md "log-BM, slicing" | "Prékopa–Leindler (from #287) … isotropic position" | P–L per GEO's #287 alias rule; bodies GEO, measures PRDS; slicing stated once (PRDS) |
| D27 | Chordal Loewner equation | ANA GeometricFunctionTheory | PRDS SchrammLoewnerEvolution | "the chordal and radial Loewner equations" | "chordal and radial Loewner chains driven by continuous functions" | ANA (deterministic theory); PRDS builds SLE |
| D28 | Bernoulli convolutions: Feng–Hu, Erdős–Pisot, Garsia | ANA FractalGeometry | PRDS EntropyAndThermodynamicFormalism | "Feng–Hu", "Erdős Pisot; Garsia" | "Feng–Hu; Erdős Pisot; Garsia"; replaces "dynamical part of FractalGeometry" | ANA; Feng–Hu to PRDS (entropy). Removes cycle C5 |
| D29 | Harris–FKG, BK, Russo–Margulis, OSSS | PRDS BernoulliPercolation | COMB ProbabilisticMethod; BooleanFunctionAnalysis | "Harris–FKG; BK; Russo–Margulis; OSSS" | "Harris–FKG and Kleitman"; "Margulis–Russo, Friedgut–Kalai" | COMB (pre-decided); percolation consumes |
| D30 | Hypercontractivity, Bonami–Beckner, cube LSI, OU | PRDS ConcentrationAndFunctionalInequalities | COMB BooleanFunctionAnalysis | "Gross LSI ⇔ hypercontractivity; Bonami–Beckner" | "Bonami–Beckner on cube and product spaces", "cube log-Sobolev" | PRDS (functional inequalities pre-decided) |
| D31 | Kasteleyn, Temperley | PRDS IntegrableLatticeModels | COMB MatchingsAndFactors | "Kasteleyn; Temperley; Kenyon local statistics" | replaces "Kasteleyn/Temperley part of IntegrableLatticeModels" | COMB (its boundary decision) |
| D32 | Strongly Rayleigh, BBL; finite networks (Rayleigh, Thomson) | PRDS RandomWalksOnGraphsAndNetworks | COMB LogConcavity…; SpectralGraphTheory | "Rayleigh; Nash-Williams; Wilson; … Borcea–Brändén–Liggett" | "Borcea–Brändén–Liggett negative association"; "Rayleigh monotonicity" | COMB finite, PRDS infinite; OAI `StrongRayleigh` (both port it) → COMB |
| D33 | Planar-map enumeration, bijections | PRDS RandomTreesAndMaps | COMB EnumerativeCombinatorics | "proves the enumeration and the classical bijections" | "Tutte's rooted planar maps, Mullin, Cori–Vauquelin–Schaeffer" | COMB |
| D34 | ϑ; BLR; Brégman; Delsarte bound; MUBs; diamond norm | COMB Spectral…, BooleanFunction…, Matchings…, Designs… | LTCS MetricEmbeddings…, PCP…, InformationAndCoding…, QuantumComputation; FAMP QIT; GEO Packing… | "ϑ(C₅)=√5"; "BLR"; "Brégman–Minc"; "Delsarte LP bound"; "MUBs in prime-power dimension" | "Lovász θ"; "BLR linearity"; "Brégman via entropy"; "Delsarte LP bound"; "mutually unbiased bases"; "the diamond norm" (both) | COMB for the first five (LTCS keeps SDP form of ϑ; GEO the spherical bound); diamond norm FAMP |
| D35 | Initial data sets, constraint equations | GEO LorentzianGeometry | ANA EinsteinEvolutionEquations | "initial data sets with the constraint equations" | "builds initial data sets with the constraint equations" | GEO defines; ANA conformal method, Cauchy problem, MGHD |
| D36 | Cosine transform, Funk–Hecke | GEO ConvexBodies | ANA ClassicalFourierAnalysis | md "cosine-transform injectivity" | "the cosine and Funk transforms" | ANA (GEO built it only if ANA did not) |
| D37 | Stationary phase | NT unit U2 (ES.0) | ANA FourierRestriction | ES.0 "van der Corput, stationary phase" | "It builds stationary phase in ℝⁿ" | ANA; U2 consumes |
| D38 | Local stages of AutomorphicSpectralTheory, EndoscopicTransfer | NT units U18, U19 | ALG RepresentationsOfReductiveGroups (md §2) | "AutomorphicSpectralTheory AS.0–AS.4"; "AS.5–6; EndoscopicTransfer…" | "the generic orbital-integral, character and Plancherel stages" | Split by stage: local harmonic analysis ALG, global NT |
| D39 | Patching algebra R03.6, P7, P9 | NT unit U27 | ALG CommutativeAlgebra (no leaf) | "R03.5–6, P7–9" | "(R03.1-R03.4, R03.6, P7, P9) promoted as a member" | ALG; NT keeps R03.5, P8 |
| D40 | VStackSheavesAndLisseCategories | NT unit U33 | AG P8 SixOperationsForDiamonds | U33 lists it | P8 replaces it | AG; U33 consumes |
| D41 | K(𝔽_q) (L.1) | NT unit U43 | TOP HigherAlgebraicKTheory | U43 lists all of KTheoryFiniteLocalFields | replaces "KTheoryFiniteLocalFields L.1" | TOP |

Lower priority: Floquet's theorem (PRDS QualitativeODE vs FAMP SturmLiouville) → PRDS. Weyl law (GEO SpectralGeometry,
manifolds; FAMP Schrödinger, domains) → one statement API. Unique continuation (GEO EllipticOperators md vs ANA) → ANA.
Koecher's principle (ANA §5 export vs NT S11) → NT. Formal group laws (NT S14 vs TOP ComplexCobordism) → NT owns the
law/height API, TOP Lazard and MU. Duistermaat–Heckman (AG states, GEO proves) → GEO.

Within campaigns: ALG Tits alternative (CoarseGeometry…, NilpotentSolvable…); AG Kodaira vanishing (KahlerManifolds,
VanishingTheorems); GEO Chern–Gauss–Bonnet (Connections, Dirac), de Rham decomposition (Connections, SymmetricSpaces);
FAMP Lieb–Thirring (Schrödinger, ManyBody); PRDS Feynman–Kac (BrownianMotion, StochasticCalculus); NT dynamical
canonical heights (S18, U17); COMB Szemerédi split in RamseyTheory's scope.

Checked, not double: PRDS ContinuumGibbsSystems vs FAMP ManyBody (classical vs quantum); PRDS IntegrableLatticeModels vs
FAMP (FAMP hands classical models to PRDS; the real double is D31).

## 2. Dangling prerequisites

**Renamed proposals:**

| Cited name | Cited by | Real target |
|---|---|---|
| AmenableGroupsAndGrowth | PRDS BernoulliPercolation, ErgodicTheory, MeasuredGroupTheory, RandomWalks…; TOP HyperbolicManifolds | ALG AmenabilityAndPropertyT (growth: CoarseGeometry…) |
| BuildingsAndCosetComplexes | TOP TopologicalCombinatorics; COMB §4 | ALG NonpositiveCurvature (Solomon–Tits); coset complexes unowned (frontier) |
| CalabiYauAndComplexMongeAmpere | AG K3AndHyperkahler; ANA PluripotentialTheory | GEO KahlerGeometry |
| EllipticOperatorsOnManifolds | AG KahlerManifolds; ANA EinsteinEvolution…, UniqueContinuation… | GEO GlobalAnalysisOnManifolds/EllipticOperators |
| FreeProbabilityAndFreeGroupFactors | PRDS StrongConvergence… | FAMP OperatorAlgebras/FreeProbability |
| GlobalRiemannianGeometry | PRDS SmoothErgodicTheory; TOP §5 | GEO ComparisonGeometry, VariationalTheoryOfGeodesics |
| GroupCohomologyFiniteness | TOP SurgeryTheoryAndFourManifolds | ALG FinitenessPropertiesOfGroups |
| InvariantDescriptiveSetTheory | PRDS MeasuredGroupTheory | LTCS MathematicalLogic/DescriptiveSetTheory |
| KahlerManifoldsAndHodgeTheory | GEO KahlerGeometry | AG HodgeTheory/KahlerManifolds |
| PositivityOfLineBundles | NT ArakelovGeometry | AG AsymptoticPositivity |
| RealHarmonicAnalysis | PRDS GaussianFreeField | ANA RealVariableHarmonicAnalysis |
| ShannonInformationTheory | FAMP QIT; PRDS (4); COMB | LTCS InformationAndCodingTheory |
| UnivalentFunctionsAndQuasiconformalMaps | PRDS SchrammLoewnerEvolution | ANA GeometricFunctionTheory (+ QuasiconformalMaps…) |
| PositiveCurrentsAndMongeAmpere | AG §5; GEO KahlerGeometry | ANA PluripotentialTheory |
| ConvexAlgebraicGeometry | COMB LogConcavity… | ANA ConicOptimizationAndSpectrahedra |
| KakeyaAndProjections | TOP §5; COMB §5 | ANA KakeyaAndBrascampLieb |
| PseudoholomorphicCurveModuli | AG GromovWittenTheory | GEO PseudoholomorphicCurves |
| GroupActionsOnRiemannSurfaces; CanonicalModelsAndGonality | TOP TeichmullerTheory; NT §3–4 | AG GeometryOfCurves |
| DerivedCategoriesAndStability | TOP §5 | AG DerivedCategoriesOfCoherentSheaves |
| FiniteGroupInvariants | NT §3, §5 | ALG StructureOfFiniteGroups + RationalAndIntegralRepresentations |
| LatticePackingsAndPerfectForms | NT §3 | GEO PackingCoveringAndEnergy |
| GroupVonNeumannAlgebras | TOP §4–5 | FAMP L2Invariants |
| FourManifoldTopology; SymplecticTopology | GEO §5; TOP §5 | TOP SurgeryTheoryAndFourManifolds; GEO SymplecticAndContactGeometry |
| LogConcaveMeasures | GEO §5 | PRDS GaussianAnalysisAndLogConcaveMeasures |
| NonlinearEllipticPDE | GEO §4 | ANA FreeBoundariesAndPhaseTransitions |
| ClassicalModelTheory; AutomataAndFiniteSemigroups | ALG UniversalAlgebra | LTCS FirstOrderModelTheory; AutomataLogicAndGames |
| HardnessOfApproximation, BooleanCircuitComplexity, SpaceBoundedComputationAndDerandomization, ConvexRelaxationsAndMetricEmbeddings, WeisfeilerLemanAndCountingLogics | COMB scopes, §4–5 | LTCS PCP…, BooleanCircuitsAndCommunication, SpaceAndPseudorandomness, MetricEmbeddingsAndConvexRelaxations, DescriptiveComplexity |
| ProbabilityOnTreesAndNetworks; MarkovChainMixing | COMB; LTCS | PRDS RandomWalksOnGraphsAndNetworks (+ RandomTreesAndMaps); MarkovChainsAndMixing |
| "FAMP IntegrableLatticeModels"; "TOP OperatorKTheory"; "ANA PolyhedralCombinatorics" | COMB §4–5; LTCS §5; LTCS CombinatorialAlgorithms, MetricEmbeddings… | PRDS; FAMP; COMB |
| formal-groups owner | TOP ComplexCobordism, Chromatic… | NT FormalGroupsAndLubinTateTheory |
| K2SymbolsBrauer T.1, KTheoryLowDegrees | ALG AmenabilityAndPropertyT, GroupRings; NT BirationalAnabelian… | TOP ClassicalKTheory |
| Birkbeck AdditiveCombinatorics | PRDS ErgodicRamseyTheory | COMB AdditiveCombinatorics |
| Birkbeck GN.4 (Siegel mean value) | PRDS HomogeneousDynamics | NT AdelicAlgebraicGroups/TamagawaMeasures |
| ReductiveGroupsPartII as "ALG" | NT §5 | AG BruhatTitsTheory + ReductiveGroupSchemes |
| MetaplecticAutomorphicForms MP.1 | FAMP ManyBody | NT MetaplecticFormsAndTheta |
| AbelianSchemesAndArithmeticModuli | NT ArakelovGeometry, ArithmeticOfFiniteFields | AG AbelianVarieties (A0–A5); A6 unclaimed |

**Aimed at the wrong roadmap:** AG EquivariantCohomology's "#437 (extended to compact Lie groups)" → TOP
CharacteristicClassesAndCobordism (owns BG for non-discrete G). FAMP VonNeumannAlgebras' "COMB ExpanderGraphs (MSS
paving)" → COMB LogConcavity…. PRDS RandomTreesAndMaps' "COMB StructuralGraphTheory" → COMB EnumerativeCombinatorics.
ANA FractalGeometry's "PRDS ErgodicTheory (entropy)" → PRDS EntropyAndThermodynamicFormalism (cycle C5). COMB
ProbabilisticMethod's "#397 for Talagrand" → PRDS Concentration…. Family citations ("GeometricMeasureTheory (ANA)",
"GEO RiemannianGeometry") should name members. LTCS §5's "GEO plans no separate MetricEmbeddings" is false.

**Genuinely unowned:**

| Cited name | Cited by | Status |
|---|---|---|
| NeronModelsAndSemistableAbelianVarieties | NT HyperellipticCurves; NT §5 | NT hands it to AG; AG lists it as "left to NT" |
| EnhancedDerivedSheaves E1, E2, E4, E5:animation | AG SixOperationsForDiamonds, PrismaticCohomology | TOP sends the remainder "to AG as a consumer"; AG routes the roadmap to TOP |
| AG Milnor–Thom/Warren | ANA KakeyaAndBrascampLieb; COMB DiscreteGeometry… | no AG roadmap |
| AG cycle complexes | TOP MotivicHomotopyTheory | AG Motives only states the higher-Chow comparison |
| ALG locally compact groups | TOP TransformationGroups | no Gleason–Yamabe/Montgomery–Zippin anywhere |
| Hadamard factorization "(ANA or #253)" | PRDS GaussianAnalysis… | #253 excludes "Hadamard's theorem beyond order 1"; Cramér needs order 2 |
| SmoothRepresentationsOfLocalGroups | ALG HeckeAlgebras…, Types…, family; NT Metaplectic… | ALG: "promoted as a member", but no leaf, size or wave |
| HilbertModularSurfaces | AG §4 | NT S11: "Hilbert modular surfaces are AG's" |
| ScatteringDiagrams | COMB §4 | AG: frontier, "no supplier anywhere" |
| PeriodsAndSpecialValues PS.9 | ALG GrothendieckTeichmuller | Birkbeck; NT unit U42, tier 3 |
| StandardDistributions "PD extension" | NT MultiplicativeNumberTheory | only a request to #449 |
| TOP TeichmullerTheory (translation surfaces) | PRDS TwistMaps… | no such layer |

## 3. Cycles and wave inconsistencies

**Cycles** (renames applied): C1 FAMP VonNeumannAlgebras ↔ NuclearCStarAlgebras ("NuclearCStarAlgebras (cb maps)" vs
"VonNeumannAlgebras (A**)"), both wave A; fix by layer pins (NUC cb maps → VN → NUC A**). C2 COMB ExtremalGraphTheory →
DiscreteGeometry… (Sperner/KKM) → RamseyTheory → ExtremalGraphTheory. C3 COMB GraphColoring ↔ PolyhedralCombinatorics
(LP duality vs perfect graphs). C4 NT AdelicAlgebraicGroups ↔ ArtinRepresentations at family level only (S5 needs sub 3;
subs 4–5 need S5). C5 latent ANA FractalGeometry ↔ PRDS EntropyAndThermodynamicFormalism, once ANA's misdirected
prerequisite is corrected; fixed by D28. C6 artifact: family citations give ANA MinimalBoundaries → GEO RicciCurvature…
→ GEO SpectralGeometry → ANA GMT; vanishes when members are named. No other cross-campaign cycle.

**Earlier wave citing a later-wave proposal:**

| Roadmap (wave) | Prerequisite (wave) | Note |
|---|---|---|
| ANA LinearDifferentialEquations… (A) | NT HypergeometricMotives (B), "Levelt, consumed" | reverse it (R13) |
| ALG GrothendieckTeichmuller (A) | PS.9 in NT unit U42 (tier 3) | MZV relations unavailable |
| ALG HeckeAlgebras… (A) | AG BruhatTitsTheory (B); unpromoted SR.1 | Iwahori layer |
| ALG GroupRings (A) | FAMP L2Invariants (B) | trace layer |
| ANA RectifiabilityAndBV (A) | FAMP NonlinearGeometry (B) | McShane suffices for the core |
| LTCS DescriptiveComplexity (A); QuantumComputation (A) | LTCS ComplexityClasses (B); COMB StructuralGraphTheory (B) | later layers |
| FAMP QuantumInformationTheory (A) | FAMP ManyBody… (C) | bosonic layer |
| AG CrystallineCohomology P10 (A) | AG VanishingTheorems (B) | Cartier isomorphism |
| AG HabiroCohomology, MumfordTateGroups, GeometryOfCurves, GIT (A) | PrismaticCohomology; ReductiveGroupSchemes, VHS; AbelianVarieties; AlgebraicStacks (B/C) | later layers |
| PRDS GaussianFreeField (B) | PRDS SchrammLoewnerEvolution (C) | SLE₄ layer |

**Wave A on unmerged open PRs** (50 roadmaps): #196, stalled since 08-21 (AG AlgebraicSpaces, CoherentDuality); #437 (ALG
CombinatorialGroupTheory, CoarseGeometry…, NonpositiveCurvature; TOP UnstableHomotopyTheory); #126 (ALG Amenability…,
FAMP QIT, PRDS ErgodicTheory); #397 (PRDS Concentration…, LargeDeviations, StochasticCalculus; COMB ProbabilisticMethod);
#271/#444 (six COMB roadmaps, GEO MetricEmbeddings); #66 (COMB Extremal…, Ramsey…, Additive…); #248/#253/#286/#432/#226/
#717/#451 (NT S1, S6, S10–S13, S16, S17); #287 (PRDS Gaussian…, GEO ConvexBodies); #237, #117, #279 (ANA, 5); #545 (AG,
3); #284 (TOP, 2); #480, #655, #41, #257, #58, #223, #323 (one or two each). TOP's and LTCS's definitions make these B.

## 4. Needs handed off but not absorbed

| Need | From → to | Receiver |
|---|---|---|
| Néron models | NT → AG | "left to NT" |
| p-divisible groups, Dieudonné (R07.1–2) | NT U27, S14 → AG | AG leaves FiniteFlatGroups to NT |
| Hilbert modular surfaces (`hmsurface`, P13) | NT → AG; AG → NT | AlgebraicSurfaces: "NT's worked examples" |
| HabiroNahmSeries, HabiroNumberFields | NT → AG | AG and TOP: "stay NT" |
| EnhancedDerivedSheaves remainder | TOP → AG | AG routes it to TOP |
| Valued fields, definable integration (LD beyond LD.4, LD.6) | NT → LTCS | "stay with LogicAndDefinabilityInNumberTheory" |
| ArithmeticQuantumTopology QT.0–4 | NT → TOP | "a later GT unit"; not slated |
| R06.5 applications of comparison theorems | NT U26 → AG | P12 replaces CohomologyComparisons only |
| AbelianSchemes A6 (Weil restriction, moduli export) | AG → NT | absent from NT units |
| GN.6 hermitian K-theory | NT → TOP | absorbed by HermitianKTheory…, which still calls it NT's; fix `replaces` |
| SmoothRepresentations…; R03.1–R03.4 | NT → ALG | umbrella text only, no leaf |
| Gleason–Yamabe, Montgomery–Zippin (OAI#304) | TOP → ALG | none |
| Simple fibred links, open books (OAI#059) | TOP → AG SingularityTheory | AG: "belong to TOP" |
| Continuous Gowers inverse theorem (OAI#086) | ANA → COMB | COMB: "continuous Gowers norms are ANA's" |
| Ellipsoid method, GLS (OAI#114) | COMB, ANA → LTCS CombinatorialAlgorithms | not in milestones |
| FPRAS constructions, annealing (OAI#113–115, #131) | LTCS → PRDS MarkovChains… | PRDS: "approximate counting is LTCS's"; only CFTP, Jerrum–Sinclair |
| Milnor–Thom/Warren, Cayley–Salmon, critical points (∃ℝ ⊆ PSPACE) | COMB, ANA, LTCS → AG | none |
| Higher Chow groups | TOP → AG | statements only |
| Translation surfaces | PRDS → TOP | none |
| Ramanujan property of LPS/Margulis graphs | COMB → NT QuaternionArithmetic | none |
| Nonlinear parabolic PDE; symmetrization (Pólya–Szegő) | GEO GeometricFlows, SpectralGeometry → ANA | ANA has neither (BOUNDARIES assigns parabolic to ANA) |
| Hadamard factorization, order 2 | PRDS → ANA or #253 | neither |
| GEM, PD(θ), Ewens; arbitrary-arity regularity | PRDS, NT → #449; COMB → #66 | requests to open-PR authors only |
| Reflection positivity, chessboard, transfer matrices | FAMP → PRDS LatticeGibbsMeasures | implicit (Fröhlich–Simon–Spencer) |
| Quantum integrable systems (XXZ, Bethe for Hamiltonians) | PRDS → FAMP | FAMP claims none |
| 15 and 290 theorems, Festi–Veniani index (P21) | GEO → IntegralLattices | not in IntegralLattices |
| CN.0 representations and bit complexity | NT U5 → LTCS/ANA | LTCS only "coordinates" (CN.4 absorbed by ANA ValidatedNumerics) |
| Deterministic nonbipartite Ramanujan graphs (OAI#178) | COMB → PRDS | frontier; Friedman only |

Absorbed as handed off (spot-checked): Mumford–Tate (AG), Malle/Gassmann (ALG), perfect forms (GEO), Morava E (TOP),
Procesi–Donkin (AG), fundamental theorem of projective geometry (NT S16), Chern connection (AG), flat torus (ALG),
Laplace–Beltrami spectrum (GEO), IFS (ANA), Khot–Minzer–Safra (LTCS), motivic SH(k) (TOP), Berger's list (GEO, stated).

## 5. Rulings needed

1. **Néron models, p-divisible groups** (orphans; S3, S8, S18, U12, U14, U26, U27 import them). AG, per NT's own ruling
   that abelian schemes and Néron models are math.AG: one AG promotion unit, wave B after AbelianVarieties.
2. **#196 and the merge-first list.** Name #196's adopter now; merge #437, #126, #397, #271, #444, #66, #248, #286 first,
   or relabel their wave-A dependents B.
3. **Metric embeddings (D1, D2).** LTCS finite metrics; FAMP Lipschitz extension and coarse embeddings; GEO keeps an M
   roadmap on doubling and quasisymmetric geometry. Removes ≈150 duplicated PRs.
4. **Strong convergence (D3).** PRDS; FAMP FreeProbability drops its last layer and Annals #99.
5. **GMT regularity (D6).** ANA; GEO MinimalSubmanifolds keeps the smooth theory.
6. **Topological combinatorics (D17, D18).** TOP owns the topology; COMB keeps Sperner/KKM/Tucker; ALG the group theory.
   COMB's §5 decision must be withdrawn or TOP's roadmap shrunk to poset topology.
7. **Boolean and functional inequalities (D29, D30).** Hypercontractivity, LSI, OU to PRDS; Harris–FKG, BK,
   Russo–Margulis, OSSS to COMB.
8. **Finite vs infinite discrete structures (D31–D33).** COMB finite and deterministic, PRDS random and infinite; one
   porting owner per OAI directory.
9. **Bundles and equivariant cohomology (D5, D19).** TOP topological carriers and theorems; GEO connections and the
   Chern–Weil comparison; Rokhlin to GEO; AG consumes for spaces.
10. **Kähler (D4).** Confirm the drafted split; Chern–Weil and the BB statement to GEO.
11. **Quantum cohomology (D20).** One axioms ⇒ product layer in GEO; AG verifies it.
12. **K-theory (D21, D22, D41).** Bott periodicity FAMP; K₀ and Hattori–Stallings TOP; K(𝔽_q) TOP.
13. **Analysis for NT (D9, D37).** ANA owns K-Bessel/Whittaker and stationary phase; Levelt's theorem moves to ANA so NT
    HypergeometricMotives consumes it (fixes the A → B inversion).
14. **Stone–von Neumann (D10).** FAMP, Mackey form, early slot; else NT builds and FAMP aliases.
15. **Curves and abelian varieties (D11–D13).** RH for curves NT; hyperelliptic geometry over k̄ AG; CM over ℂ AG.
16. **Homogeneous dynamics inputs (D14, D15).** Siegel sets and Siegel mean value NT S13; Mahler, Howe–Moore, Mal'cev ALG.
17. **Analysis–dynamics (D16, D24–D28).** Liouville–Arnold, GHP to GEO; Loewner, Bernoulli convolutions to ANA; Feng–Hu,
    slicing to PRDS; Szemerédi statement to COMB.
18. **Birkbeck promotion conflicts (D38–D40).** VStackSheaves to AG P8; local AS/ET stages to ALG; ALG adds leaves for
    SmoothRepresentationsOfLocalGroups (first member, since HeckeAlgebras needs SR.1) and the patching-algebra member.
19. **Ping-pong orphans.** Hilbert modular surfaces → NT (layer of S11 or U12); Habiro pair → NT; EnhancedDerivedSheaves
    remainder → AG SheafTheory; valued fields → LTCS (later member); fibred links (OAI#059) → AG SingularityTheory;
    continuous Gowers norms → COMB (all LCA groups); ArithmeticQuantumTopology → TOP, wave C after #57/#58.
20. **New small owners.** Gleason–Yamabe → ALG (M); Milnor–Thom/Warren, Cayley–Salmon, critical points → AG (M successor
    of RealAlgebraicGeometry); higher Chow → AG Motives; nonlinear parabolic PDE and symmetrization → ANA member;
    Hadamard factorization → ANA GeometricFunctionTheory; translation surfaces → TOP Teichmüller; ellipsoid/GLS → LTCS;
    FPRAS and annealing → PRDS MarkovChains…; LPS Ramanujan → NT S4; 15/290 → NT; reflection positivity named in PRDS.
21. **Open-PR requests.** Ask #449 (PD/GEM/Ewens) and #66 (any arity); on refusal PRDS and COMB own them.
22. **Cycles and waves (§3).** Layer-pin C1–C3; Cartier isomorphism into AG P10 or P10 to B; GrothendieckTeichmuller to
    B unless it builds its MZV relations.
23. **Name hygiene (§2).** ≈45 names to fix before drafting; LTCS withdraws its MetricEmbeddings note.
24. **Small batch (D34–D36, lower-priority list).** Accept §1 owners as one ruling.
25. **Within-campaign duplicates and D23.** One owner each; ALG proves Kazhdan–Margulis, TOP proves Mostow.
