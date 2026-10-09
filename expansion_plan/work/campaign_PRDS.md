# Campaign PRDS (probability and dynamics): slate, 2026-10-07

Sources: `needs_all.jsonl`, the phase-1 reports (probability/physics in full; geometry–dynamics, combinatorics–TCS,
number theory, algebra, analysis and Annals 52–100 for their PRDS parts), the supply indexes, the READMEs of #397,
#417, #449, #480 and #151, Birkbeck stages PM.2/PM.4, GN.4, DY.*, AC.2–AC.3, the 2026-10-07 completion audits,
Mathlib `6b7abb3c`, Tau Ceti `a91d3aafa`. The need-to-roadmap mapping is `scratchpad/p2-prds/map_needs.py`.

## 1. Scope

PRDS owns math.PR, math.ST and math.DS: probability and stochastic processes, statistical mechanics as probability
(Gibbs measures, percolation, spin glasses, SLE, the GFF, per BOUNDARIES.md), random discrete structures, and
dynamical systems with ergodic theory. Statistics proper has one need among the three goals.

| Goal | rows | gap | open-pr | mathlib | tauceti-code | oai-lean | other |
|---|---:|---:|---:|---:|---:|---:|---|
| OpenAI | 201 | 146 | 25 | 16 | 10 | 3 | 1 tauceti-roadmap |
| Annals | 5 | 4 | – | – | – | – | 1 birkbeck-campaign |
| LMFDB | 0 | | | | | | |

By class: math.PR 151 rows (105 gap), math.DS 54 (44 gap), math.ST 1 (gap); 97 statement-level, 109 proof-level; the
150 gap rows are 88 distinct concepts. They cite 69 OpenAI families (probability #211–#239, dynamics #143–#154, six
convex-geometry families #087–#101, seven TCS families, fifteen others) and Annals #93, #95, #96, #97, #99. Another
89 rows name PRDS as secondary (COMB 26, LTCS 21, FAMP 19, ALG 13, ANA 5, NT 4, GEO 1), and the slate also absorbs
15 rows filed elsewhere (FAMP's lattice, integrable and continuum-Gibbs rows, COMB's dimer and planar-map rows,
GEO's GHP row). It serves 66 of the 69 families (#164 through its inputs) and all five Annals definitions; #011 goes
to PR #449, and #140 and #327 are covered by Mathlib.

## 2. Existing supply

- **StandardDistributions** (main; audit COMPLETE EXCEPT TRIVIA; #449 extends Layers 0–6 to 0–15): laws used by #096,
  #097, #139, #140. *Merge #449* after adding a GEM / PD(θ) / Ewens layer (OAI #011, NT AnatomyOfIntegers);
  then archive v1.
- **Exchangeability** (main; COMPLETE EXCEPT TRIVIA; #641 docs, #234 three new targets): no goal need, but its
  Aldous–Hoover arrays feed MeanFieldSpinGlasses and its `Probability/Ergodic` code is ErgodicTheory's base. *Merge
  #641, decide #234 on its merits, archive.*
- **RandomMatrices** (#397, open): 30 needs (28 OpenAI, Annals #99 in part). *Merge soon.* It overlaps the slate in
  M2 (generic Poincaré/log-Sobolev, Herbst, Talagrand, Efron–Stein → ConcentrationAndFunctionalInequalities), M9
  (LDP framework → LargeDeviations) and M10 (Itô integral, SDE existence → StochasticCalculus). Recommended: merge as
  is; the new roadmaps generalize those declarations in place by alias. Add matrix Khintchine to M2 (#283).
- **PointProcesses** (#417, open): 9 needs (#219, #224, #228, #231, #235, #271; Annals #70, #97). *Merge soon.* Its
  pointer to "an ergodic-theory roadmap" becomes ErgodicTheory; its excluded renewal theorem, infinite-volume Gibbs
  processes and discrete determinantal measures go to MarkovChainsAndMixing, ContinuumGibbsSystems and
  RandomWalksOnGraphsAndNetworks.
- **RestrictedThreeBody** (#151, open, math.DS): no goal need, no overlap with TwistMapsBilliardsAndKAM. *Leave.*
- **HamiltonianSystems** (#480, open, GEO's): leaves Liouville–Arnold, action-angle variables and KAM to "a roadmap on
  them [that] consumes Layers 1 and 2"; TwistMapsBilliardsAndKAM is that roadmap.
- **Suppliers on main, leave:** OptimalTransport (couplings, Wasserstein, Caffarelli L6C, Fokker–Planck L11,
  Gromov–Wasserstein L15), OneParameterSemigroups (audit INCOMPLETE; Markov semigroups, Herglotz/Bochner),
  DenseGraphLimits (dense limits only). ArithmeticHeights #287 C.3 (Prékopa) is cited by #087, #091, #093, #101.
- **Birkbeck campaign:** generic ergodic theory of PM.2/PM.4 → ErgodicTheory and EntropyAndThermodynamicFormalism
  (PM keeps Weyl, discrepancy, Gauss-map statistics); GN.4's homogeneous dynamics → HomogeneousDynamics (GN.4 keeps
  lattice counting and the Siegel transform); ArithmeticDynamics' complex and Berkovich dynamics → PRDS, not slated
  (§6); AC.2–AC.3's ergodic route and nilsystems → ErgodicRamseyTheory.
- **Explorer drafts:** none; ergodic theory, stochastic processes and statistical inference are its unmapped areas.

## 3. The slate

Twenty-eight new roadmaps: four umbrella families on the RepresentationTheory model (an index README plus sub-roadmaps, landed in tranches of two to four) and one standalone roadmap. Twenty-four are L and four M, ordered by dependency inside each family. Wave A means the foundation layers start on Mathlib, Tau Ceti and merged roadmaps; later layers may import another wave-A roadmap. Porting paths: `P/` = `lean/OAI/Probability`, `D/` = `lean/OAI/Dynamics` in the OpenAI release; "by alias" means the new roadmap generalizes the open PR's declarations in place (supplier-ward move, reducible alias).

### Family StochasticProcesses (XL family, 6 roadmaps, 1,360 PRs)

Topic math.PR. Markov chains, Brownian motion, stochastic calculus and SDEs, and the concentration, Gaussian and large-deviation inequalities they rest on. Tranche 1: MarkovChainsAndMixing, ConcentrationAndFunctionalInequalities, BrownianMotion; tranche 2: the rest. The existing math.PR roadmaps stay top-level and are linked from the index.

**1. MarkovChainsAndMixing** — L, 260 PRs, wave A

This roadmap develops Markov chains on countable state spaces, in discrete and continuous time, from Tau Ceti's `markovChainLaw` and Mathlib's kernel invariance, reversibility and irreducibility. It fixes the library's one total-variation distance and one mixing-time API. It covers recurrence, renewal theory, Q-matrices and Dirichlet forms, and mixing by coupling, stopping times, spectral gap, conductance and comparison, with Glauber dynamics and walks on finite groups as model families. Functional inequalities come from ConcentrationAndFunctionalInequalities; approximate counting is LTCS's; walks on infinite graphs are RandomWalksOnGraphsAndNetworks'.

*Milestones.* tvDist and maximal coupling; convergence theorem; renewal theorem; t_mix vs t_rel; path coupling; Jerrum–Sinclair; comparison; Diaconis–Shahshahani cutoff; Propp–Wilson.
*Prerequisites.* Tau Ceti Probability/Process/MarkovChain; OptimalTransport; RepresentationTheory/SchurWeyl; ConcentrationAndFunctionalInequalities. *Goals.* OpenAI 8: #103, #113, #114, #115, #131, #220, #227, #238.
*Porting.* P/{SwitchChain, ThorpShuffle, CubeShuffle, Renewal}; replaces ~30 OAI totalVariation and ~15 mixingTime definitions. *Formalizability.* high (Levin–Peres–Wilmer). *Replaces:* MarkovChainMixing.

**2. BrownianMotion** — L, 220 PRs, wave A

This roadmap develops Brownian motion as a random continuous path, from Mathlib's `IsBrownianReal` and Kolmogorov condition, following Mörters–Peres. It constructs d-dimensional Brownian motion with continuous paths and proves the strong Markov property, the classical path theorems, the invariance principle and Skorokhod embedding. It builds Brownian potential theory, through Feynman–Kac and planar conformal invariance, and the dimension of the range and zero set, with dimension of measures from ANA's FractalGeometry. Stochastic integration is StochasticCalculus'; excursion codings of trees are RandomTreesAndMaps'.

*Milestones.* continuous paths; strong Markov; reflection; LIL; Lévy modulus; Donsker; Skorokhod embedding; Kakutani; recurrence iff d ≤ 2; conformal invariance; dim B[0,1] = 2.
*Prerequisites.* Mathlib BrownianMotion, Process/Kolmogorov; ConformalMapping; PDE; ANA FractalGeometry. *Goals.* OpenAI 3: #220, #230, #267.
*Porting.* P/SLE/BrownianStrongMarkov; P/StrongRayleigh/{PreBrownianExistence, BrownianKolmogorov}; Degenne et al. brownian-motion project (coordinate first). *Formalizability.* high (Mörters–Peres).

**3. StochasticCalculus** — L, 300 PRs, wave A

This roadmap develops stochastic calculus for continuous semimartingales and SDEs, following Le Gall and Revuz–Yor. It extends Mathlib's filtrations, predictability and martingales to continuous time and builds the Itô integral and its calculus. Its SDE layers prove existence, uniqueness and the Markov and Feller properties of solutions, with generators, Kolmogorov equations, one-dimensional diffusions and Bessel processes, and its top layers are the Föllmer drift, nonlinear filtering and stochastic localization. It owns the general Itô calculus of RandomMatrices (#397) Milestone 10 and generalizes those declarations in place; point-process intensities stay in PointProcesses (#417).

*Milestones.* Doob in continuous time; Itô formula; Lévy; Dubins–Schwarz; BDG; Tanaka; Girsanov; Lipschitz SDEs; Yamada–Watanabe; martingale problem; Feynman–Kac; Boué–Dupuis; Fujisaki–Kallianpur–Kunita.
*Prerequisites.* BrownianMotion; OneParameterSemigroups; PDE; OptimalTransport; RandomMatrices #397. *Goals.* OpenAI 8: #139, #211, #219, #222, #223, #227, #230, #231.
*Porting.* Degenne et al. brownian-motion project (stochastic integral, Itô formula, Doob–Meyer; coordinate first, #417 already defers to it); P/SLE/{ItoIsometry, StochasticIntegrals, StochasticFubini}; P/SKGap/Localization. *Formalizability.* high; filtering and localization medium.

**4. ConcentrationAndFunctionalInequalities** — L, 240 PRs, wave A

This roadmap develops concentration of measure on product spaces and the functional inequalities of Markov semigroups. It covers the variance and entropy methods, bounded differences (from Tau Ceti's McDiarmid), Talagrand's convex distance and transportation-cost inequalities. For symmetric Markov semigroups it develops Poincaré and (modified) log-Sobolev inequalities, hypercontractivity and the Bakry–Émery calculus, with the Ornstein–Uhlenbeck semigroup and the discrete cube as model cases. Gaussian comparison and log-concave measures are GaussianAnalysisAndLogConcaveMeasures', matrix concentration stays in RandomMatrices (#397) M2, and the generic items of M2 are generalized here by alias.

*Milestones.* Efron–Stein; Herbst; Talagrand convex distance; Marton/T2; Gross LSI ⇔ hypercontractivity; Bonami–Beckner; Bakry–Émery; Holley–Stroock; Brascamp–Lieb variance; Caffarelli.
*Prerequisites.* Tau Ceti McDiarmid; OneParameterSemigroups; OptimalTransport; LTCS ShannonInformationTheory; RandomMatrices #397. *Goals.* OpenAI 14: #091, #093, #101, #113, #157, #161, #219, #221, #227, #235, #238, #239, #261, #283.
*Porting.* P/SKGap/Gaussian; OAI Computability/VertexCover/Information/Tensorization.lean. *Formalizability.* high (Boucheron–Lugosi–Massart).

**5. GaussianAnalysisAndLogConcaveMeasures** — L, 220 PRs, wave A

This roadmap develops Gaussian analysis and the measure-theoretic side of convexity. Its Gaussian layers cover integration by parts, comparison, suprema of processes, isoperimetry and correlation inequalities, and characterizations of the Gaussian law. Its log-concave layers cover Prékopa–Leindler (from #287), Borell's s-concave measures, isotropic position and log-concave densities, stating the KLS, thin-shell and (B) conjectures. Semigroup proofs come from ConcentrationAndFunctionalInequalities; convex bodies as geometric objects are GEO's ConvexBodies.

*Milestones.* Gaussian IBP; Slepian; Sudakov–Fernique; Gordon; Dudley; majorizing measures; Borell–TIS; Gaussian isoperimetry; Ehrhard; Royen; Banaszczyk; Cramér decomposition; Prékopa–Leindler; Borell.
*Prerequisites.* StandardDistributions; ConcentrationAndFunctionalInequalities; ArithmeticHeights #287; GEO ConvexBodies; Hadamard factorization (ANA or #253). *Goals.* OpenAI 10: #087, #091, #093, #096, #097, #101, #217, #220, #227, #234.
*Porting.* P/{GaussianPropeller, GaussianReplacement, LogConcave/Analysis, SKGap/Gaussian}. *Formalizability.* high (Ledoux–Talagrand). *Replaces:* LogConcaveMeasures; the Gaussian-analysis cluster of ConcentrationAndFunctionalInequalities.

**6. LargeDeviations** — M, 120 PRs, wave A

This roadmap develops large deviations following Dembo–Zeitouni. It defines large-deviation principles with good rate functions on topological spaces, exponential tightness and exponential equivalence, and proves the transfer theorems and the classical principles for sums, empirical measures, paths and projective limits. It owns the LDP framework that RandomMatrices (#397) Milestone 9 introduces and generalizes those declarations in place; the log-gas and largest-eigenvalue principles stay in #397. Boué–Dupuis is StochasticCalculus', and the Gibbs roadmaps consume Sanov and Varadhan for their variational principles.

*Milestones.* contraction principle; Varadhan and Bryc; Cramér in ℝ^d; Sanov; Gärtner–Ellis; Mogulskii; Schilder; Dawson–Gärtner.
*Prerequisites.* LTCS ShannonInformationTheory; BrownianMotion; RandomMatrices #397. *Goals.* OpenAI 1: #222.
*Porting.* #397 M9 by alias. *Formalizability.* high. Direct demand is thin; it gives #397 and the Gibbs roadmaps one LDP owner.

### Family StatisticalMechanics (XL family, 10 roadmaps, 2,130 PRs)

Topic math.PR. Lattice and continuum models and their scaling limits; per BOUNDARIES.md it owns Gibbs measures even where the literature is math-ph. Tranches: (BernoulliPercolation, LatticeGibbsMeasures, LatticeRandomWalks), (RandomClusterAndRandomCurrents, MeanFieldSpinGlasses, GaussianFreeField, IntegrableLatticeModels), (SchrammLoewnerEvolution, RandomMedia, ContinuumGibbsSystems).

**7. BernoulliPercolation** — L, 250 PRs, wave A

This roadmap develops Bernoulli bond and site percolation on locally finite graphs with one graph encoding. Its first layer is the correlation theory of product measures, built on Mathlib's Harris–Kleitman and four-functions theorems and exported to COMB. It develops the phase transition and its sharpness, uniqueness on transitive graphs, and the planar theory, stating Kesten's scaling relations and Smirnov's theorem. Mass transport comes from RandomWalksOnGraphsAndNetworks and amenability from ALG; dependent percolation is RandomClusterAndRandomCurrents', first passage RandomMedia's.

*Milestones.* Harris–FKG; BK; Russo–Margulis; OSSS; Duminil-Copin–Tassion sharpness; Burton–Keane; Newman–Schulman; Häggström–Peres; RSW; Harris–Kesten p_c = 1/2; quasi-multiplicativity of arm events.
*Prerequisites.* Mathlib FourFunctions, HarrisKleitman; RandomWalksOnGraphsAndNetworks; ALG AmenableGroupsAndGrowth. *Goals.* OpenAI 6: #212, #213, #214, #224, #236, #267.
*Porting.* P/{UnimodularPercolation, CriticalZ3, BenjaminiSchramm/GhostFanBK}; the percolation developments cited by #213 (unchecked). *Formalizability.* high (Grimmett); unifies three OAI graph encodings.

**8. LatticeGibbsMeasures** — L, 260 PRs, wave A

This roadmap develops classical lattice spin systems, following Georgii and Friedli–Velenik. It builds specifications and the DLR equations, the Gibbs simplex, translation-invariant states, pressure and the variational principle, and uniqueness criteria. It defines the Ising, Potts, O(n), XY/Villain and gradient models and proves the correlation inequalities and the classical transition and no-transition theorems. Graphical representations are RandomClusterAndRandomCurrents', solvable models IntegrableLatticeModels', continuum systems ContinuumGibbsSystems', quantum spin systems FAMP's.

*Milestones.* DLR existence and extremal decomposition; variational principle; Dobrushin; GKS; FKG; Lee–Yang; Peierls; Fröhlich–Simon–Spencer; Mermin–Wagner; Griffiths–Pearce.
*Prerequisites.* LargeDeviations; ErgodicTheory. *Goals.* OpenAI 7: #215, #216, #218, #225, #232, #236, #237; Annals: #97.
*Porting.* P/{Ising, ClassicalON, InvariantIsing/Pressure, FKPressure}; replaces dozens of OAI gibbs/partitionFunction definitions. *Formalizability.* high (Georgii). *Replaces:* GibbsMeasuresAndSpinSystems (Annals P44); FAMP-tagged lattice-model needs.

**9. RandomClusterAndRandomCurrents** — L, 220 PRs, wave B

This roadmap develops the graphical representations of lattice spin models. It constructs the random-cluster model with its coupling to Potts, comparison inequalities, infinite-volume measures, planar duality and the self-dual point. It develops random currents and the switching lemma, the loop O(n) representation, and spin/height duality for XY and Villain models. Its top layer is the planar FK theory for 1 ≤ q ≤ 4 (box crossings and continuity), with discontinuity for q > 4 stated. Spin-system foundations are LatticeGibbsMeasures', Bernoulli percolation BernoulliPercolation's, scaling limits SchrammLoewnerEvolution's.

*Milestones.* Edwards–Sokal; FK comparison; self-dual p_c on ℤ²; Duminil-Copin–Raoufi–Tassion sharpness; switching lemma; continuity of Ising in d ≥ 3; McBryan–Spencer; Duminil-Copin–Sidoravicius–Tassion for q ≤ 4.
*Prerequisites.* LatticeGibbsMeasures; BernoulliPercolation. *Goals.* OpenAI 6: #211, #215, #216, #218, #223, #233; Annals: #97.
*Porting.* P/{FKPressure, ClassicalON, FKMaps}. *Formalizability.* high to medium. *Replaces:* the FK/current split of LatticeGibbsMeasures.

**10. MeanFieldSpinGlasses** — L, 260 PRs, wave B

This roadmap develops mean-field spin glasses following Talagrand and Panchenko. It defines the SK, mixed p-spin, spherical, perceptron and diluted models. It proves the interpolation bounds, the cavity scheme, Ruelle cascades, Ghirlanda–Guerra, ultrametricity and the Parisi formula, taking Dovbysh–Sudakov from Tau Ceti's Aldous–Hoover theory, and treats the Parisi functional, TAP and AMP. Gaussian tools come from GaussianAnalysisAndLogConcaveMeasures; random CSP thresholds are RandomGraphsAndConstraintSatisfaction's.

*Milestones.* Guerra; Aizenman–Sims–Starr; Ruelle cascades; Ghirlanda–Guerra; ultrametricity; Parisi formula; Auffinger–Chen; Crisanti–Sommers; Franz–Leone; Bolthausen AMP.
*Prerequisites.* GaussianAnalysisAndLogConcaveMeasures; ConcentrationAndFunctionalInequalities; StochasticCalculus; Exchangeability; RandomMatrices #397. *Goals.* OpenAI 7: #217, #221, #222, #227, #234, #235, #281.
*Porting.* P/{SKGap, SKValue, ParisiFinite, DilutedSpin, Perceptron/{Cascade, Control}}. *Formalizability.* high through the Parisi formula.

**11. LatticeRandomWalks** — L, 220 PRs, wave A

This roadmap develops simple random walk on ℤ^d and planar lattices as potential theory, following Lawler–Limic. It builds discrete complex analysis on square and isoradial lattices, the Chelkak–Smirnov toolbox and s-holomorphicity, as the source of the observables used in scaling-limit proofs. It constructs loop-erased walk and the random-walk loop soup, and develops self-avoiding walk through the connective constant and the parafermionic observable. Walks on general graphs and Wilson's algorithm are RandomWalksOnGraphsAndNetworks'; scaling limits to SLE are SchrammLoewnerEvolution's.

*Milestones.* LCLT; Green-function asymptotics; Beurling; LERW; discrete Cauchy formula; convergence of discrete harmonic measure; Hammersley–Welsh; Duminil-Copin–Smirnov.
*Prerequisites.* MarkovChainsAndMixing; ConformalMapping. *Goals.* OpenAI 5: #211, #218, #223, #224, #237.
*Porting.* P/Honeycomb (minor). *Formalizability.* high (Lawler–Limic).

**12. SchrammLoewnerEvolution** — L, 250 PRs, wave C

This roadmap develops Loewner evolution and SLE following Lawler and Kemppainen. It builds chordal and radial Loewner chains driven by continuous functions and defines SLE_κ and SLE(κ, ρ) with their phases, trace, locality, restriction and Green function. It develops the space of curves with the tightness criteria that carry discrete interfaces to SLE. Conformal loop ensembles and imaginary geometry enter as definitions with their main theorems stated. Univalent-function theory (Koebe, distortion, radial chains of class S) is ANA's UnivalentFunctionsAndQuasiconformalMaps, and Bessel processes come from StochasticCalculus.

*Milestones.* Loewner transform; phases; Rohde–Schramm; locality and restriction; Green function and dim ≤ 1 + κ/8; Cardy for SLE_6; Kemppainen–Smirnov.
*Prerequisites.* StochasticCalculus; BrownianMotion; LatticeRandomWalks; ConformalMapping; ANA UnivalentFunctionsAndQuasiconformalMaps, FractalGeometry. *Goals.* OpenAI 6: #211, #218, #223, #226, #230, #232.
*Porting.* P/SLE/Loewner/*, P/SLE/LoewnerCharts, P/SLEGauge. *Formalizability.* medium-high; makes six frontier families statable.

**13. GaussianFreeField** — L, 220 PRs, wave B

This roadmap develops the Gaussian free field. It builds the discrete field on graphs with its Markov property and random-walk representation, and the continuum Dirichlet and whole-plane fields as random distributions with domain Markov decomposition, circle averages, thick points, conformal invariance and lattice-to-continuum convergence. It constructs Gaussian multiplicative chaos and the Liouville measure and defines quantum spheres and disks. Local sets, level lines, two-valued sets and the SLE_4 coupling are stated, and the LQG metric and mating of trees are frontier. Negative-order Sobolev spaces come from ANA's RealHarmonicAnalysis.

*Milestones.* discrete Markov property; continuum GFF and Cameron–Martin space; domain Markov; thick points; lattice convergence; GMC (Kahane, Berestycki); Liouville measure.
*Prerequisites.* GaussianAnalysisAndLogConcaveMeasures; LatticeRandomWalks; BrownianMotion; PDE; ANA RealHarmonicAnalysis; SchrammLoewnerEvolution (SLE_4 layer). *Goals.* OpenAI 7: #211, #216, #223, #225, #226, #232, #233.
*Porting.* P/SLE/GreenCovariance; P/LatticeSurface. *Formalizability.* medium-high.

**14. IntegrableLatticeModels** — L, 200 PRs, wave B

This roadmap develops exactly solvable planar lattice models. For dimers it builds Pfaffian methods, Temperley's bijection, local statistics and double dimers, stating Kenyon's fluctuation and lozenge-universality theorems. It solves the planar Ising model by Kac–Ward and Pfaffian formulas. For the six-vertex model it develops transfer matrices, Yang–Baxter and the algebraic Bethe ansatz, and the correspondences with random-cluster and Ashkin–Teller models. Gibbs theory is LatticeGibbsMeasures', spanning trees RandomWalksOnGraphsAndNetworks'; quantum integrable systems and quantum groups are FAMP's and ALG's.

*Milestones.* Kasteleyn; Temperley; Kenyon local statistics; Kac–Ward; Onsager; Yang magnetization; Yang–Baxter; Bethe ansatz; Lieb square ice; Baxter–Kelland–Wu.
*Prerequisites.* LatticeGibbsMeasures; RandomWalksOnGraphsAndNetworks; RandomClusterAndRandomCurrents. *Goals.* OpenAI 5: #218, #223, #225, #226, #233; Annals: #97.
*Porting.* none identified. *Formalizability.* high; Bethe ansatz medium. *Replaces:* IntegrableLatticeModels (FAMP- and COMB-tagged needs).

**15. RandomMedia** — M, 130 PRs, wave B

This roadmap develops random walks and growth in random media. For first-passage percolation on ℤ^d it proves the time constant, the shape theorem and concentration, and develops Busemann functions and geodesics. For random walk in random environment it covers the one-dimensional theory, the 0-1 laws, regeneration, ballisticity and the environment seen from the particle. Random Schrödinger operators are FAMP's; percolation clusters are BernoulliPercolation's.

*Milestones.* time constant; Cox–Durrett; Kesten concentration; Solomon; Kalikow and Zerner–Merkl 0-1 laws; Sznitman–Zerner LLN.
*Prerequisites.* ErgodicTheory; BernoulliPercolation; MarkovChainsAndMixing; ConcentrationAndFunctionalInequalities. *Goals.* OpenAI 2: #212, #220.
*Porting.* P/{FirstPassage, LatticePassage, Ballisticity, DirectionalWalk}. *Formalizability.* high.

**16. ContinuumGibbsSystems** — M, 120 PRs, wave B

This roadmap develops classical continuum particle systems following Ruelle. It treats stable and superstable pair potentials, canonical and grand-canonical ensembles, their thermodynamic limits and the equivalence of ensembles. It proves convergence of the Mayer expansion, the Kac/Lebowitz–Penrose limit, and existence of infinite-volume Gibbs point processes by DLR and Georgii–Nguyen–Zessin. It extends PointProcesses (#417), whose boundary excludes infinite-volume Gibbs processes; quantum particle systems are FAMP's.

*Milestones.* superstability; thermodynamic limits; equivalence of ensembles; Mayer expansion; Lebowitz–Penrose; DLR existence.
*Prerequisites.* PointProcesses #417; LatticeGibbsMeasures; LargeDeviations. *Goals.* OpenAI 2: #228, #267.
*Porting.* P/{ContinuumTransition, RadialTransition}. *Formalizability.* high; #228 is formalized in OAI. *Replaces:* ContinuumGibbsSystems (FAMP-tagged).

### Family RandomDiscreteStructures (XL family, 3 roadmaps, 710 PRs)

Topic math.PR. Random walks on infinite graphs, branching, random trees and maps, sparse random graphs and CSPs; one tranche. COMB keeps G(n,p) subgraph thresholds, the local lemma, the nibble and expansion.

**17. RandomWalksOnGraphsAndNetworks** — L, 260 PRs, wave A

This roadmap develops random walks on infinite graphs and groups following Lyons–Peres. It treats electrical networks, uniform spanning trees and forests, and determinantal and strongly Rayleigh measures on countable sets. It develops transitive graphs with unimodularity and mass transport, unimodular random graphs, heat-kernel bounds, and entropy and the Liouville property of walks on groups. Amenability and Kesten's criterion come from ALG; branching is RandomTreesAndMaps', local weak limits RandomGraphsAndConstraintSatisfaction's.

*Milestones.* Rayleigh; Nash-Williams; Wilson; transfer-current; WUSF = FUSF on amenable graphs; Lyons DPP; Borcea–Brändén–Liggett; mass transport; Varopoulos–Carne; Kaimanovich–Vershik.
*Prerequisites.* MarkovChainsAndMixing; ALG AmenableGroupsAndGrowth; LTCS ShannonInformationTheory. *Goals.* OpenAI 4: #213, #214, #231, #271; Annals: #96.
*Porting.* P/{StrongRayleigh, SpanningForest, UnimodularPercolation/Transport}. *Formalizability.* high (Lyons–Peres). *Replaces:* ProbabilityOnTreesAndNetworks (graph part).

**18. RandomTreesAndMaps** — L, 230 PRs, wave B

This roadmap develops branching processes, random trees and random planar maps. It treats Galton–Watson processes, branching on trees and broadcasting and reconstruction on trees. It codes conditioned Galton–Watson and simply generated trees by paths and proves Aldous's continuum-random-tree theorem in the Gromov–Hausdorff–Prokhorov topology, which it builds on compact metric measure spaces. For planar maps it proves the enumeration and the classical bijections and states the Brownian-map theorem. Combinatorial maps as rotation systems come from COMB's StructuralGraphTheory; Liouville quantum gravity is GaussianFreeField's.

*Milestones.* Kesten–Stigum (growth and reconstruction); branching number; Vervaat; Aldous CRT; GHP; Tutte; Cori–Vauquelin–Schaeffer; Sheffield bijection.
*Prerequisites.* BrownianMotion; RandomWalksOnGraphsAndNetworks; LatticeGibbsMeasures; COMB StructuralGraphTheory. *Goals.* OpenAI 3: #211, #229, #236.
*Porting.* P/FKMaps (plane trees, Vervaat, excursion law, GHP bounds); P/ThreeState. *Formalizability.* high. *Replaces:* ProbabilityOnTreesAndNetworks (trees); COMB-tagged planar maps; GEO-tagged GHP.

**19. RandomGraphsAndConstraintSatisfaction** — L, 220 PRs, wave B

This roadmap develops sparse random graphs and random constraint satisfaction. It proves the Erdős–Rényi transition and builds the configuration model, random regular graphs, Benjamini–Schramm limits and the Kesten–McKay law. For random k-SAT, XORSAT and colorings it develops moment methods, sharp thresholds and interpolation, stating the large-k k-SAT threshold, and it treats the stochastic block model up to the Kesten–Stigum threshold. Fixed-subgraph thresholds, Janson, the local lemma and the nibble are COMB's ProbabilisticMethod; dense limits are DenseGraphLimits'; spectral expansion is COMB's ExpanderGraphs.

*Milestones.* giant component; configuration model; Kesten–McKay; Benjamini–Schramm limits; sharp k-SAT thresholds; Franz–Leone; Bayati–Gamarnik–Tetali; XORSAT; SBM below Kesten–Stigum.
*Prerequisites.* RandomTreesAndMaps; RandomWalksOnGraphsAndNetworks; MeanFieldSpinGlasses; ConcentrationAndFunctionalInequalities; COMB BooleanFunctionAnalysis, ProbabilisticMethod. *Goals.* OpenAI 4: #219, #229, #231, #235.
*Porting.* P/{RandomSAT, SATVariance, SATComputability, BenjaminiSchramm}. *Formalizability.* high.

### Standalone roadmap (130 PRs)

Topic math.PR (secondary math.OA); a sibling of RandomMatrices (#397), whose boundary excludes strong asymptotic freeness.

**20. StrongConvergenceOfRandomMatrices** — M, 130 PRs, wave C

This roadmap develops strong asymptotic freeness: convergence of operator norms of noncommutative polynomials in random matrices to those of the limiting free operators. It treats Gaussian, Haar-unitary and random-permutation models, with Friedman's theorem as the graph-theoretic consequence. Moment convergence and C*-level freeness are imported from RandomMatrices (#397) Milestone 6; C*_r(F_d), Haagerup's inequality and free group factors are FAMP's; Ramanujan graphs are COMB's ExpanderGraphs. Operator-algebra applications (Hayes's route to Peterson–Thom) are stated.

*Milestones.* linearization; Haagerup–Thorbjørnsen; Collins–Male; polynomial method; Bordenave–Collins; Friedman 2√(d−1) + o(1).
*Prerequisites.* RandomMatrices #397; FAMP FreeProbabilityAndFreeGroupFactors, VonNeumannAlgebras; COMB ExpanderGraphs; RandomGraphsAndConstraintSatisfaction. *Goals.* Annals: #99.
*Porting.* none identified. *Formalizability.* medium. *Replaces:* StrongConvergenceOfRandomMatrices (Annals P46).

### Family DynamicalSystems (XL family, 8 roadmaps, 1,920 PRs)

Topic math.DS. One ErgodicTheory foundation, as BOUNDARIES.md requires, under entropy, smooth, homogeneous, group-action, recurrence and conservative dynamics and qualitative ODE. Tranches: (ErgodicTheory, QualitativeODEAndBifurcations), (EntropyAndThermodynamicFormalism, MeasuredGroupTheory, ErgodicRamseyTheory, TwistMapsBilliardsAndKAM), (SmoothErgodicTheory, HomogeneousDynamics).

**21. ErgodicTheory** — L, 260 PRs, wave A

This roadmap develops measure-preserving dynamics beyond Mathlib's ergodicity, mean ergodic theorem and Krylov–Bogolyubov and Tau Ceti's Koopman results. It proves the pointwise and subadditive ergodic theorems for ℤ-, ℝ- and amenable-group actions and builds Lebesgue spaces, conditional measures and ergodic decomposition. It develops mixing, Koopman spectral theory, factors, joinings and extensions, and supplies the group-action ergodic theorems to which PointProcesses (#417) defers. Entropy is EntropyAndThermodynamicFormalism's, recurrence ErgodicRamseyTheory's, orbit equivalence MeasuredGroupTheory's.

*Milestones.* maximal ergodic lemma; Birkhoff; Kingman; Lindenstrauss; ergodic decomposition; Rokhlin; Kac; weak mixing; Halmos–von Neumann; Furstenberg disjointness.
*Prerequisites.* Tau Ceti Probability/Ergodic; ALG AmenableGroupsAndGrowth; OneParameterSemigroups; OperatorTheory #126. *Goals.* OpenAI 8: #144, #145, #150, #152, #154, #212, #220, #228.
*Porting.* D/{MultipleMixing, ThreeTorus}; Tau Ceti Probability/Ergodic (built for Exchangeability). *Formalizability.* high (Walters, Einsiedler–Ward). *Replaces:* PM.2/PM.4 ergodic theory.

**22. EntropyAndThermodynamicFormalism** — L, 280 PRs, wave B

This roadmap develops entropy theory and thermodynamic formalism. It builds measure-theoretic entropy on LTCS's Shannon entropy and the topological theory on Mathlib's topological entropy, including mean dimension. It develops subshifts of finite type, pressure, equilibrium states, transfer operators, Gibbs measures (identified with LatticeGibbsMeasures' DLR measures on ℤ) and the dimension theory of dynamically defined measures. Dimension of sets and measures is ANA's FractalGeometry; smooth entropy formulas are SmoothErgodicTheory's.

*Milestones.* Kolmogorov–Sinai; Shannon–McMillan–Breiman; Abramov; Pinsker; variational principle; mean dimension; RPF; Bowen Gibbs measures; Bowen's equation; Feng–Hu; Erdős Pisot; Garsia.
*Prerequisites.* ErgodicTheory; LTCS ShannonInformationTheory; LatticeGibbsMeasures; ANA FractalGeometry. *Goals.* OpenAI 9: #015, #145, #146, #148, #151, #152, #153, #302, #339; Annals: #96.
*Porting.* D/{StandardMap, EntropyCounterexample}; OAI MeasureTheory/SelfSimilar, NumberTheory/DukePrimeDegree/Entropy. *Formalizability.* high. *Replaces:* dynamical part of FractalGeometry.

**23. SmoothErgodicTheory** — L, 280 PRs, wave C

This roadmap develops hyperbolic smooth dynamics and its ergodic theory, following Katok–Hasselblatt and Barreira–Pesin. It treats linear cocycles and random matrix products, Lyapunov exponents, and uniformly hyperbolic sets and Anosov systems with their symbolic codings, absolute continuity and the Hopf argument. Its nonuniform layers develop hyperbolic measures and the link between exponents and entropy; Ledrappier–Young and Katok's entropy-rigidity conjecture are stated. Local theory at fixed points is QualitativeODEAndBifurcations' and Tau Ceti code, and the Riemannian geometry of geodesic flows is GEO's.

*Milestones.* Oseledets; Furstenberg positivity; hyperbolic stable manifolds; shadowing; Markov partitions; Hopf–Anosov ergodicity; Ruelle inequality; Pesin formula; Katok horseshoes.
*Prerequisites.* ErgodicTheory; EntropyAndThermodynamicFormalism; QualitativeODEAndBifurcations; DifferentialGeometry; GEO GlobalRiemannianGeometry. *Goals.* OpenAI 4: #144, #146, #152, #339; Annals: #93.
*Porting.* D/{StandardMap (Lyapunov predicates), SmoothObstruction}. *Formalizability.* medium-high; stable manifolds are heavy. *Replaces:* NonuniformHyperbolicity (Annals P40).

**24. HomogeneousDynamics** — L, 300 PRs, wave C

This roadmap develops dynamics on homogeneous spaces G/Γ, with SL₂(ℝ)/SL₂(ℤ) and SL_n(ℤ)\SL_n(ℝ) as running examples. It proves mixing and Howe–Moore, the theory of horocycle and geodesic flows, nondivergence, Ratner theory for SL₂(ℝ) with the general statements, and Oppenheim. Its rigidity layers develop the entropy and leafwise-measure theory behind the measure classification of diagonal actions and the equidistribution of periodic torus packets. Lattices and arithmetic groups come from ALG and Siegel's mean-value theorem from the Birkbeck GeometryOfNumbers roadmap; arithmetic applications stay with NT consumers.

*Milestones.* Mahler; Howe–Moore; Furstenberg unique ergodicity; Dani; Dani–Margulis; Ratner for SL₂(ℝ); Oppenheim; Einsiedler–Katok–Lindenstrauss; ELMV torus packets.
*Prerequisites.* ErgodicTheory; EntropyAndThermodynamicFormalism; ALG LatticesInSemisimpleGroups, AmenabilityAndPropertyT; RepresentationTheory/LieGroups; NumberFieldArithmetic; Birkbeck GN.4. *Goals.* OpenAI 1: #015; Annals: #95.
*Porting.* OAI NumberTheory/DukePrimeDegree (~600 files, a complete EKL-type argument). *Formalizability.* medium; strongest porting source. *Replaces:* GN.4 and PM.4 dynamics.

**25. MeasuredGroupTheory** — L, 200 PRs, wave B

This roadmap develops p.m.p. actions of countable groups through their orbit equivalence relations, following Kechris–Miller and Gaboriau. It treats Bernoulli shifts and factors of IID on groups and transitive graphs. It develops full groups, graphings and treeings, hyperfiniteness and cost. Borel equivalence relations without measure are LTCS's InvariantDescriptiveSetTheory; amenability is ALG's; group von Neumann algebras and W*-rigidity are FAMP's.

*Milestones.* factors of IID; Dye; Ornstein–Weiss and Connes–Feldman–Weiss; Levitt; Gaboriau fixed price for F_n; amalgam formula.
*Prerequisites.* ErgodicTheory; ALG AmenableGroupsAndGrowth; LTCS InvariantDescriptiveSetTheory; RandomWalksOnGraphsAndNetworks. *Goals.* OpenAI 4: #212, #231, #236, #259.
*Porting.* none identified. *Formalizability.* high (Kechris–Miller). *Replaces:* factors-of-IID cluster (probability share).

**26. ErgodicRamseyTheory** — L, 220 PRs, wave B

This roadmap develops ergodic Ramsey theory. It proves the correspondence principle and multiple recurrence through the Furstenberg–Zimmer structure theory, with topological, polynomial and IP recurrence. It develops nilsystems and the Host–Kra theory of multiple ergodic averages. Gowers norms, inverse theorems and quantitative nilsequences belong to the Birkbeck AdditiveCombinatorics roadmap (math.CO), which consumes this one; joinings and extensions are ErgodicTheory's.

*Milestones.* correspondence principle; Furstenberg–Zimmer; Szemerédi; Furstenberg–Katznelson; Bergelson–Leibman; Leibman; Host–Kra; IP recurrence.
*Prerequisites.* ErgodicTheory; RepresentationTheory/LieGroups. *Goals.* OpenAI 3: #145, #154, #164.
*Porting.* D/MultipleMixing. *Formalizability.* medium-high.

**27. TwistMapsBilliardsAndKAM** — L, 200 PRs, wave B

This roadmap develops low-dimensional conservative dynamics. It extends Mathlib's rotation number of circle maps and treats area-preserving twist maps, their periodic orbits, invariant circles and Aubry–Mather sets. It proves the Liouville–Arnold theorem and the KAM theorems, and develops convex and polygonal billiards. The Hamiltonian formalism comes from HamiltonianSystems (#480), which leaves Liouville–Arnold and KAM unowned; Teichmüller dynamics of translation surfaces is TOP's.

*Milestones.* Denjoy; Poincaré–Birkhoff; Birkhoff graph theorem; Aubry–Mather; Liouville–Arnold; KAM; Moser twist; Lazutkin; Zemlyakov–Katok.
*Prerequisites.* ErgodicTheory; HamiltonianSystems #480; QualitativeODEAndBifurcations; TOP TeichmullerTheory. *Goals.* OpenAI 3: #146, #147, #150; Annals: #93.
*Porting.* D/{StandardMap, TriangleBilliards}. *Formalizability.* medium-high. *Replaces:* AreaPreservingMapsAndBilliards; Liouville–Arnold and KAM left unowned by #480.

**28. QualitativeODEAndBifurcations** — L, 180 PRs, wave A

This roadmap develops the qualitative theory of autonomous ODE beyond Mathlib's flow API and Tau Ceti's flows, ω-limit sets and local stable manifolds. It covers stability, local linearization and invariant manifolds, periodic orbits and return maps, planar theory and limit cycles, local bifurcations, and mass-action reaction networks. Dulac's finiteness theorem, Peixoto's theorem and Hilbert's sixteenth problem are stated. Hyperbolic sets are SmoothErgodicTheory's; PDE are ANA's.

*Milestones.* LaSalle; Hartman–Grobman; center manifold; Floquet; Poincaré–Bendixson; Dulac; Liénard; Hopf bifurcation; Bautin; deficiency zero.
*Prerequisites.* Tau Ceti Analysis/ODE, Dynamics/Flow; DifferentialGeometry. *Goals.* OpenAI 3: #143, #149, #352.
*Porting.* OAI Analysis/{LienardCycles, MassAction}. *Formalizability.* high. *Replaces:* QualitativeODE.

## 4. Needs not absorbed

Every PRDS gap row is assigned; four are not absorbed by the slate.

| Need | Reason |
|---|---|
| OAI #011 Poisson–Dirichlet PD(1), GEM | too small: add GEM / PD(θ) / Ewens sampling as a layer of StandardDistributions (#449) |
| OAI #148 IFS, Hutchinson attractors, Moran–Hutchinson | ANA's FractalGeometry; EntropyAndThermodynamicFormalism consumes it |
| OAI #150 Forni–Moll angular Fourier analysis | frontier (cohomological equation for flat geodesic flows) |
| OAI #164 IP polynomial recurrence on nilmanifolds | frontier; ErgodicRamseyTheory supplies Bergelson–Leibman and Furstenberg–Katznelson |

*Frontier inputs in absorbed rows, stated not proved:* LQG metric (#211), Ahlberg–Hoffman (#212), Hutchcroft
(#213, #214), renormalization group (#215, #216), Lopatto (#217), Huang–Yau–Landon–Sosoe (#219), Mourrat (#222),
local-set uniqueness and Bethe-root condensation (#223–#226, #233), Chen–Eldan (#227), Mossel–Sly–Sohn (#229),
Ilyashenko–Écalle (#143), billiard rigidity (#147), Katok's conjecture (#339).

*Interface rows owned elsewhere:* approximate counting (LTCS; #113–#115, #131); amenability, Kesten, Gromov growth
(ALG AmenableGroupsAndGrowth); Boolean functions, probabilistic method, expanders (COMB); random Schrödinger
operators, quantum spin systems, free probability, Banach and Markov-type geometry (FAMP); kinetic theory and
variational inequalities (ANA); Shannon theory (LTCS); the PD law of prime factors (NT, via #449). The one math.ST
need (SBM, #229) is absorbed at statement level; no statistics roadmap is proposed.

## 5. Cross-campaign interface

Short names abbreviate slate entries.

| Campaign | PRDS imports | PRDS exports |
|---|---|---|
| ALG | AmenableGroupsAndGrowth → ErgodicTheory, RandomWalksOnGraphsAndNetworks, BernoulliPercolation, MeasuredGroupTheory; LatticesInSemisimpleGroups, AmenabilityAndPropertyT → HomogeneousDynamics | walks on groups (Kaimanovich–Vershik); cost; homogeneous dynamics |
| ANA | FractalGeometry → BrownianMotion, SLE, Entropy; UnivalentFunctionsAndQuasiconformalMaps → SLE; RealHarmonicAnalysis → GFF; Hadamard factorization → GaussianAnalysis | Brownian potential theory, Feynman–Kac, large deviations |
| FAMP | FreeProbabilityAndFreeGroupFactors, VonNeumannAlgebras → StrongConvergence; OperatorTheory #126 → ErgodicTheory | classical Gibbs measures, reflection positivity, transfer matrices; ergodic operator families; random-loop tools (#271) |
| COMB | BooleanFunctionAnalysis, ProbabilisticMethod → RandomGraphs; StructuralGraphTheory → RandomTreesAndMaps; ExpanderGraphs → StrongConvergence | Harris–FKG, BK, Russo–Margulis, OSSS; cube hypercontractivity; mixing bounds; Kesten–McKay; Friedman; Furstenberg correspondence and nilsystems |
| LTCS | ShannonInformationTheory → Entropy, Concentration, LargeDeviations, RandomWalks; InvariantDescriptiveSetTheory → MeasuredGroupTheory | total variation and mixing times; stochastic localization (#139); CSP thresholds |
| GEO | ConvexBodies → GaussianAnalysis; GlobalRiemannianGeometry → SmoothErgodicTheory; HamiltonianSystems #480 → TwistMaps | GHP topology; Gaussian and log-concave inequalities; smooth ergodic theory (#339) |
| TOP, NT | TeichmullerTheory (statements) → TwistMaps; #287, NumberFieldArithmetic, Birkbeck GN.4 → GaussianAnalysis, HomogeneousDynamics | ergodic theory to PM.2/PM.4, homogeneous dynamics to GN.4 and #015 |

Two boundaries need the neighbors' assent: Loewner chains (ANA keeps radial chains of class S; SLE builds chains
driven by continuous functions) and GHP (RandomTreesAndMaps builds compact GHP; GEO's pointed measured GH proves the
comparison).

## 6. Order and people

**First five to draft.**
1. **ErgodicTheory**: 8 families; under all eight DynamicalSystems roadmaps and RandomMedia; fills #417's pointer
   and NT's PM/GN stages; no open dependencies.
2. **ConcentrationAndFunctionalInequalities**: widest demand (14 families, incl. TCS and COMB); feeds spin glasses,
   random graphs and Gaussian analysis; settles the #397 M2 overlap while #397 is in review.
3. **MarkovChainsAndMixing**: 8 families in probability and TCS; one TV and mixing API before more duplicates land.
4. **LatticeGibbsMeasures**: 7 families and Annals #97; base of four StatisticalMechanics roadmaps and the Gibbs
   bridge in EntropyAndThermodynamicFormalism.
5. **StochasticCalculus** (BrownianMotion in parallel): 8 families; prerequisite of SLE, GFF and the spin-glass
   control representation; coordination with the Degenne et al. project and #397 M10 is the long pole.

Under the WIP cap of three, the first PRs are StochasticProcesses tranche 1 (MarkovChainsAndMixing,
ConcentrationAndFunctionalInequalities, BrownianMotion), DynamicalSystems tranche 1 (ErgodicTheory,
QualitativeODEAndBifurcations) and StatisticalMechanics tranche 1
(BernoulliPercolation, LatticeGibbsMeasures, LatticeRandomWalks); StochasticCalculus opens the next tranche.

**People.** Lead: a probabilist spanning stochastic analysis and statistical mechanics; co-lead for
DynamicalSystems: an ergodic theorist. Reviewers for stochastic calculus, mixing (TCS-literate), percolation and
Ising/FK, spin glasses, SLE/GFF, entropy, hyperbolic, homogeneous and conservative dynamics. Lean side: Mathlib's
probability maintainers and the #397 and #417 authors.

**Open questions for the owner.**
1. IntegrableLatticeModels and ContinuumGibbsSystems are planned here (math.PR) under the BOUNDARIES Gibbs row;
   FAMP may file them as math-ph.
2. #397: merge as is and generalize M2/M9/M10 by alias (recommended), or ask #397 to drop them first (delays 30 needs).
3. Harris–FKG, BK, Russo–Margulis, OSSS and cube hypercontractivity are claimed here as the general owner; COMB's
   BooleanFunctionAnalysis would consume them. Needs the COMB lead.
4. Total variation is defined in MarkovChainsAndMixing; LTCS proves Pinsker against it.
5. Howe–Moore: ALG's AmenabilityAndPropertyT, or HomogeneousDynamics by default.
6. Owned but not slated (no goal demand): DynamicsOfRationalMaps (coordination §3.3; touched by Annals #93/#96
   example papers), mathematical statistics, SPDE, Lévy processes. Draft when ArithmeticDynamics is promoted.
7. Review shape: ten tranche PRs of two to four roadmaps (plus four index READMEs), or 28 single-roadmap PRs.

## 7. Totals

| | roadmaps | est. PRs |
|---|---:|---:|
| StochasticProcesses (XL family) | 6 (5 L, 1 M) | 1,360 |
| StatisticalMechanics (XL family) | 10 (8 L, 2 M) | 2,130 |
| RandomDiscreteStructures (XL family) | 3 L | 710 |
| DynamicalSystems (XL family) | 8 L | 1,920 |
| StrongConvergenceOfRandomMatrices | 1 M | 130 |
| **New, total** | **28 (24 L, 4 M)** | **6,250** |

By wave: A 12 roadmaps (2,790 PRs), B 12 (2,500), C 4 (960). Existing supply still to build in the territory:
#397 ≈ 250, #417 ≈ 250, #449 expansion ≈ 130, #151 ≈ 40, #234 ≈ 5 (StandardDistributions and Exchangeability on main
are complete except trivia): about 675 PRs, a tenth of the new surface.

## 8. References by roadmap

32 roadmap records, 312 listings, 272 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_PRDS.json` and the `references` fields of `slate_PRDS.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (197 of 272: zbMATH stopped early; see master (d)). Pointers are the compilers' and are unverified.

**Conventions and notes.** No probability or dynamics text is held in the local PDF collections; local paths are code. The Degenne et al. Brownian-motion project is identified from #397 `SOURCES.md` and #417 (repository `RemyDegenne/brownian-motion`; paper arXiv:2511.20118, title confirmed by arXiv); the repository was not inspected. The ConcentrationAndFunctionalInequalities porting path is `lean/OAI/Computability/VertexCover/Information/Tensorization.lean` (corrected in `slate_PRDS.json`; §3 still shows the short form).

**StochasticProcesses** (umbrella, wave A)
- primary: Kallenberg 2021, *Foundations of Modern Probability* (?); Durrett 2019, *Probability* (?)
- formal: Mathlib `Probability`; Tau Ceti `Probability`; `RemyDegenne/brownian-motion`; Tau Ceti 2026, *RandomMatrices roadmap (open PR #397)*; Tau Ceti 2026, *PointProcesses roadmap (open PR #417)*

**MarkovChainsAndMixing** (wave A)
- primary: Levin–Peres 2017, *Markov Chains and Mixing Times* (?); Norris 1997, *Markov Chains* (?); Aldous–Fill 2002, *Reversible Markov Chains and Random…* (?)
- theorem: Diaconis 1988, *Group Representations in Probability…* (?); Diaconis–Shahshahani 1981, *Generating a random permutation with…* (?); Asmussen 2003, *Applied Probability and Queues* (?)
- formal: Tau Ceti `Probability/Process/MarkovChain`; Mathlib `Probability/Kernel/Invariance`; OAI `Probability/SwitchChain`; OAI `Probability/ThorpShuffle`; OAI `Probability/Renewal`

**BrownianMotion** (wave A)
- primary: Mörters–Peres 2010, *Brownian Motion* (?); Revuz–Yor 1999, *Continuous Martingales and Brownian…* (?); Karatzas–Shreve 1991, *Brownian Motion and Stochastic Calculus* (?)
- formal: Mathlib `Probability/BrownianMotion`; Mathlib `Topology/MetricSpace/HausdorffDimension`; `RemyDegenne/brownian-motion`; Degenne et al. 2025, *Formalization of Brownian motion in Lean*; OAI `Probability/SLE/BrownianStrongMarkov`

**StochasticCalculus** (wave A)
- primary: Le Gall 2016, *Brownian Motion, Martingales, and…* (?); Revuz–Yor 1999, *Continuous Martingales and Brownian…* (?); Karatzas–Shreve 1991, *Brownian Motion and Stochastic Calculus* (?); Bain–Crisan 2009, *Fundamentals of Stochastic Filtering* (?)
- theorem: Stroock–Varadhan 1979, *Multidimensional Diffusion Processes* (?); Boué–Dupuis 1998, *Variational representation for certain…* (?); Lehec 2013, *Representation formula for the entropy…* (?); Eldan 2013, *Thin shell implies spectral gap up to…* (?)
- formal: `RemyDegenne/brownian-motion`; Mathlib `Probability/Martingale`; Tau Ceti 2026, *RandomMatrices roadmap (open PR #397)*; OAI `Probability/SLE/ItoIsometry`; OAI `Probability/SKGap/Localization`

**ConcentrationAndFunctionalInequalities** (wave A)
- primary: Boucheron–Lugosi–Massart 2013, *Concentration Inequalities* (?); Bakry–Gentil–Ledoux 2014, *Analysis and Geometry of Markov…* (?); Ledoux 2001, *Concentration of Measure Phenomenon* (?)
- conventions: Villani 2009, *Optimal Transport* (?)
- theorem: Caffarelli 2000, *Monotonicity properties of optimal…* (?)
- formal: Tau Ceti `Probability/McDiarmid`; Mathlib `Probability/Moments/SubGaussian`; Tau Ceti 2026, *RandomMatrices roadmap (open PR #397)*; `Lean-MoDS/StatsMLlib`; OAI `Computability/VertexCover/Information/Tensorization`; OAI `Probability/SKGap/Gaussian`

**GaussianAnalysisAndLogConcaveMeasures** (wave A)
- primary: Ledoux–Talagrand 1991, *Probability in Banach Spaces* (?); Talagrand 2021, *Upper and Lower Bounds for Stochastic…* (?); Bogachev 1998, *Gaussian Measures* (?); Brazitikos et al. 2014, *Geometry of Isotropic Convex Bodies* (?)
- theorem: Ehrhard 1983, *Symétrisation dans l'espace de Gauss* (?); Royen 2014, *Simple proof of the Gaussian…* (?); Banaszczyk 1998, *Balancing vectors and Gaussian measures…* (?); Cramér 1936, *Über eine Eigenschaft der normalen…* (?)
- statement: Kannan–Lovász–Simonovits 1995, *Isoperimetric problems for convex…* (?); Cordero-Erausquin et al. 2004, *(B) conjecture for the Gaussian measure…* (?)
- formal: Mathlib `Probability/Distributions/Gaussian`; Tau Ceti `Probability/Distributions`; OAI `Probability/SKGap/Gaussian`; OAI `Probability/LogConcave/Analysis`; OAI `Probability/GaussianPropeller`; OAI `Probability/GaussianReplacement`

**LargeDeviations** (wave A)
- primary: Dembo–Zeitouni 1998, *Large Deviations Techniques and…*, Ch. 2, Ch. 4, Ch. 5 (?); Deuschel–Stroock 1989, *Large Deviations* (?); den Hollander 2000, *Large Deviations* (?)
- formal: Mathlib `Probability/Moments/SubGaussian`; Mathlib `InformationTheory/KullbackLeibler`; Tau Ceti 2026, *RandomMatrices roadmap (open PR #397)*

**StatisticalMechanics** (umbrella, wave A)
- primary: Friedli–Velenik 2018, *Statistical Mechanics of Lattice Systems* (?); Georgii 2011, *Gibbs Measures and Phase Transitions* (?); Grimmett 2018, *Probability on Graphs* (?)
- formal: OAI `Probability`

**BernoulliPercolation** (wave A)
- primary: Grimmett 1999, *Percolation* (?); Bollobás–Riordan 2006, *Percolation* (?); Duminil-Copin 2018, *Bernoulli percolation* (?); Lyons–Peres 2016, *Probability on Trees and Networks*, Chs. 7–8 (?)
- theorem: Nolin 2008, *Near-critical percolation in two…* (?)
- statement: Kesten 1987, *Scaling relations for 2D-percolation* (?); Smirnov 2001, *Critical percolation in the plane* (?)
- formal: Mathlib `Combinatorics/SetFamily/HarrisKleitman`; OAI `Probability/UnimodularPercolation`; OAI `Probability/CriticalZ3`; OAI `Probability/BenjaminiSchramm/GhostFanBK`; anthropics/formal-math/percolation

**LatticeGibbsMeasures** (wave A)
- primary: Georgii 2011, *Gibbs Measures and Phase Transitions* (?); Friedli–Velenik 2018, *Statistical Mechanics of Lattice Systems* (?); Simon 1993, *Statistical Mechanics of Lattice Gases… I* (?)
- theorem: Ruelle 2004, *Thermodynamic Formalism* (?); van Enter–Fernández–Sokal 1993, *Regularity properties and pathologies…* (?)
- formal: Mathlib `Probability/Kernel/Invariance`; OAI `Probability/Ising`

**RandomClusterAndRandomCurrents** (wave B)
- primary: Grimmett 2006, *Random-Cluster Model* (?); Duminil-Copin 2020, *Ising and Potts models on the…* (?); Peled–Spinka 2019, *Spin and loop O(n) models* (?)
- theorem: Beffara–Duminil-Copin 2012, *Self-dual point of the two-dimensional…* (?); Duminil-Copin–Raoufi–Tassion 2019, *Sharp phase transition for the…* (?); Aizenman et al. 2015, *Random currents and continuity of Ising…* (?); McBryan–Spencer 1977, *Decay of correlations in…* (?); Duminil-Copin et al. 2017, *Continuity of the phase transition for…* (?)
- statement: Duminil-Copin et al. 2021, *Discontinuity of the phase transition…* (?)
- formal: OAI `Probability/Ising`; OAI `Probability/FKMaps`

**MeanFieldSpinGlasses** (wave B)
- primary: Panchenko 2013, *Sherrington–Kirkpatrick Model* (?); Talagrand 2011, *Mean Field Models for Spin Glasses…* (?)
- conventions: Kallenberg 2005, *Probabilistic Symmetries and Invariance…* (?)
- theorem: Auffinger–Chen 2015, *Parisi formula has a unique minimizer* (?); Talagrand 2006, *Free energy of the spherical mean field…* (?); Franz–Leone 2003, *Replica bounds for optimization…* (?); Bolthausen 2014, *Iterative construction of solutions of…* (?); Bayati–Montanari 2011, *Dynamics of message passing on dense…* (?)
- formal: Tau Ceti `Probability/Exchangeability/Arrays/AldousHoover`; OAI `Probability/SKGap`; OAI `Probability/DilutedSpin`

**LatticeRandomWalks** (wave A)
- primary: Lawler–Limic 2010, *Random Walk* (?); Madras–Slade 1993, *Self-Avoiding Walk* (?)
- theorem: Chelkak–Smirnov 2011, *Discrete complex analysis on isoradial…* (?); Smirnov 2010, *Conformal invariance in random cluster…* (?); Duminil-Copin–Smirnov 2012, *Connective constant of the honeycomb…* (?); Lawler–Trujillo Ferreras 2007, *Random walk loop soup* (?)
- formal: Tau Ceti `Probability/Process/MarkovChain`; OAI `Probability/Honeycomb`

**SchrammLoewnerEvolution** (wave C)
- primary: Kemppainen 2017, *Schramm–Loewner Evolution* (?); Lawler 2005, *Conformally Invariant Processes in the…* (?)
- theorem: Kemppainen–Smirnov 2017, *Random curves, scaling limits and…* (?)
- statement: Beffara 2008, *Dimension of the SLE curves* (?); Sheffield–Werner 2012, *Conformal loop ensembles* (?); Miller–Sheffield 2016, *Imaginary geometry I* (?)
- formal: Mathlib `MeasureTheory/Measure/Prokhorov`; OAI `Probability/SLE/Loewner`

**GaussianFreeField** (wave B)
- primary: Berestycki–Powell 2025, *Gaussian Free Field and Liouville…* (?); Werner–Powell 2021, *Gaussian Free Field* (?); Sheffield 2007, *Gaussian free fields for mathematicians* (?)
- conventions: Duplantier–Sheffield 2011, *Liouville quantum gravity and KPZ* (?)
- statement: Schramm–Sheffield 2009, *Contour lines of the two-dimensional…* (?); Schramm–Sheffield 2013, *Contour line of the continuum Gaussian…* (?); Gwynne–Miller 2021, *Existence and uniqueness of the…* (?); Duplantier–Miller–Sheffield 2021, *Liouville quantum gravity as a mating…* (?)
- formal: OAI `Probability/SLE/GreenCovariance`

**IntegrableLatticeModels** (wave B)
- primary: Baxter 1982, *Exactly Solved Models in Statistical…* (?); Kenyon 2009, *Dimers* (?); McCoy–Wu 1973, *Two-Dimensional Ising Model* (?)
- theorem: Kenyon–Propp–Wilson 2000, *Trees and matchings* (?); Kac–Ward 1952, *Combinatorial solution of the…* (?); Duminil-Copin et al. 2022, *Six-vertex model's free energy* (?)
- statement: Kenyon 2001, *Dominos and the Gaussian free field* (?); Aggarwal 2023, *Universality for lozenge tiling local…* (?)

**RandomMedia** (wave B)
- primary: Auffinger–Damron–Hanson 2017, *50 Years of First-Passage Percolation* (?); Zeitouni 2004, *Random walks in random environment* (?)
- statement: Ahlberg–Hoffman 2016, *Random coalescing geodesics in…* (?)
- formal: OAI `Probability/FirstPassage`; OAI `Probability/Ballisticity`

**ContinuumGibbsSystems** (wave B)
- primary: Ruelle 1969, *Statistical Mechanics* (?); Dereudre 2019, *Theory of Gibbs point processes* (?)
- conventions: Last–Penrose 2018, *Poisson Process* (?)
- theorem: Ruelle 1970, *Superstable interactions in classical…* (?); Lebowitz–Penrose 1966, *Rigorous treatment of the van der…* (?); Georgii 1995, *Equivalence of ensembles for classical…* (?); Poghosyan–Ueltschi 2009, *Abstract cluster expansion with…* (?)
- formal: Tau Ceti 2026, *PointProcesses roadmap (open PR #417)*; OAI `Probability/ContinuumTransition`

**RandomDiscreteStructures** (umbrella, wave A)
- primary: Lyons–Peres 2016, *Probability on Trees and Networks* (?); Janson–Łuczak–Ruciński 2000, *Random Graphs* (?); van der Hofstad 2017, *Random Graphs and Complex Networks…* (?)
- formal: Mathlib `Probability/Combinatorics/BinomialRandomGraph/Defs`; OAI `Probability/BenjaminiSchramm`

**RandomWalksOnGraphsAndNetworks** (wave A)
- primary: Lyons–Peres 2016, *Probability on Trees and Networks*, Ch. 14 (?); Woess 2000, *Random Walks on Infinite Graphs and…* (?); Barlow 2017, *Random Walks and Heat Kernels on Graphs* (?)
- theorem: Lyons 2003, *Determinantal probability measures* (?); Borcea–Brändén–Liggett 2009, *Negative dependence and the geometry of…* (?); Aldous–Lyons 2007, *Processes on unimodular random networks* (?)
- formal: OAI `Probability/StrongRayleigh`; OAI `Probability/UnimodularPercolation/Transport`

**RandomTreesAndMaps** (wave B)
- primary: Lyons–Peres 2016, *Probability on Trees and Networks*, Chs. 5, 12 (?); Le Gall 2005, *Random trees and applications* (?); Evans 2008, *Probability and Real Trees* (?)
- theorem: Aldous 1993, *Continuum random tree. III* (?); Abraham–Delmas–Hoscheit 2013, *Note on the Gromov–Hausdorff–Prokhorov…* (?); Janson 2012, *Simply generated trees, conditioned…* (?); Evans et al. 2000, *Broadcasting on trees and the Ising…* (?); Tutte 1963, *Census of planar maps* (?); Chassaing–Schaeffer 2004, *Random planar lattices and integrated…* (?); Sheffield 2016, *Quantum gravity and inventory…* (?)
- statement: Le Gall 2013, *Uniqueness and universality of the…* (?)
- formal: Mathlib `Topology/MetricSpace/GromovHausdorff`; OAI `Probability/FKMaps`; OAI `Probability/ThreeState`

**RandomGraphsAndConstraintSatisfaction** (wave B)
- primary: Janson–Łuczak–Ruciński 2000, *Random Graphs* (?); van der Hofstad 2017, *Random Graphs and Complex Networks…* (?); van der Hofstad 2024, *Random Graphs and Complex Networks…* (?); Mézard–Montanari 2009, *Information, Physics, and Computation* (?)
- conventions: Lovász 2012, *Large Networks and Graph Limits*, Part 4 (?)
- theorem: McKay 1981, *Expected eigenvalue distribution of a…* (?); Friedgut 1999, *Sharp thresholds of graph properties…* (?); Achlioptas–Peres 2004, *Threshold for random k-SAT is 2^k log 2…* (?); Bayati–Gamarnik–Tetali 2013, *Combinatorial approach to the…* (?); Franz–Leone 2003, *Replica bounds for optimization…* (?); Pittel–Sorkin 2016, *Satisfiability threshold for k-XORSAT* (?); Mossel–Neeman–Sly 2015, *Reconstruction and estimation in the…* (?)
- statement: Ding–Sly–Sun 2022, *Proof of the satisfiability conjecture…* (?)
- formal: Mathlib `Probability/Combinatorics/BinomialRandomGraph/Defs`; OAI `Probability/RandomSAT`; OAI `Probability/BenjaminiSchramm`

**StrongConvergenceOfRandomMatrices** (wave C)
- primary: Mingo–Speicher 2017, *Free Probability and Random Matrices* (?); Anderson–Guionnet–Zeitouni 2010, *Random Matrices*, §§5.2–5.4 (?); Chen et al. 2026, *New approach to strong convergence* (?)
- theorem: Haagerup–Thorbjørnsen 2005, *New application of random matrices* (?); Collins–Male 2014, *Strong asymptotic freeness of Haar and…* (?); Bordenave–Collins 2019, *Eigenvalues of random lifts and…* (?); Friedman 2008, *Proof of Alon's second eigenvalue…* (?); Bordenave 2020, *New proof of Friedman's second…* (?)
- statement: Hayes 2022, *Random matrix approach to the…* (?)
- formal: Tau Ceti 2026, *RandomMatrices roadmap (open PR #397)*

**DynamicalSystems** (umbrella, wave A)
- primary: Katok–Hasselblatt 1995, *Modern Theory of Dynamical Systems* (?); Walters 1982, *Ergodic Theory* (?); Einsiedler–Ward 2011, *Ergodic Theory with a view towards…* (?)
- formal: Mathlib `Dynamics`; Tau Ceti `Probability/Ergodic`; Tau Ceti `Dynamics/Flow`; OAI `Dynamics`

**ErgodicTheory** (wave A)
- primary: Einsiedler–Ward 2011, *Ergodic Theory with a view towards…* (?); Walters 1982, *Ergodic Theory* (?); Glasner 2003, *Ergodic Theory via Joinings* (?); Kerr–Li 2016, *Ergodic Theory* (?)
- theorem: Steele 1989, *Kingman's subadditive ergodic theorem* (?); Lindenstrauss 2001, *Pointwise theorems for amenable groups* (?); Rokhlin 1962, *Fundamental ideas of measure theory* (?)
- formal: Mathlib `Dynamics/Ergodic`; Tau Ceti `Probability/Ergodic`; OAI `Dynamics/MultipleMixing`; OAI `Dynamics/ThreeTorus`

**EntropyAndThermodynamicFormalism** (wave B)
- primary: Walters 1982, *Ergodic Theory*, Chs. 4, 7 (?); Bowen 1975, *Equilibrium States and the Ergodic…* (?); Downarowicz 2011, *Entropy in Dynamical Systems* (?); Lind–Marcus 1995, *Symbolic Dynamics and Coding* (?); Ruelle 2004, *Thermodynamic Formalism* (?); Pesin 1997, *Dimension Theory in Dynamical Systems* (?)
- theorem: Lindenstrauss–Weiss 2000, *Mean topological dimension* (?); Feng–Hu 2009, *Dimension theory of iterated function…* (?); Erdős 1939, *Family of symmetric Bernoulli…* (?); Garsia 1962, *Arithmetic properties of Bernoulli…* (?)
- formal: Mathlib `Dynamics/TopologicalEntropy`; OAI `MeasureTheory/SelfSimilar`; OAI `NumberTheory/DukePrimeDegree/Entropy`; OAI `Dynamics/EntropyCounterexample`

**SmoothErgodicTheory** (wave C)
- primary: Katok–Hasselblatt 1995, *Modern Theory of Dynamical Systems* (?); Barreira–Pesin 2007, *Nonuniform Hyperbolicity* (?); Viana 2014, *Lyapunov Exponents* (?)
- statement: Ledrappier–Young 1985, *Metric entropy of diffeomorphisms… II* (?); Katok 1982, *Entropy and closed geodesics* (?)
- formal: Tau Ceti `Dynamics/Flow`; OAI `Dynamics/StandardMap`; OAI `Dynamics/SmoothObstruction`

**HomogeneousDynamics** (wave C)
- primary: Einsiedler–Ward 2011, *Ergodic Theory with a view towards…* (?); Morris 2005, *Ratner's Theorems on Unipotent Flows* (?); Bekka–Mayer 2000, *Ergodic Theory and Topological Dynamics…* (?); Einsiedler–Lindenstrauss 2010, *Diagonal actions on locally homogeneous…* (?); Eskin 2010, *Unipotent flows and applications* (?)
- theorem: Kleinbock–Margulis 1998, *Flows on homogeneous spaces and…* (?); Dani 1981, *Invariant measures and minimal sets of…* (?); Margulis 1989, *Discrete subgroups and ergodic theory* (?); Einsiedler et al. 2006, *Invariant measures and the set of…* (?); Einsiedler et al. 2011, *Distribution of periodic torus orbits…* (?)
- statement: Ratner 1991, *Raghunathan's measure conjecture* (?)
- formal: Mathlib `MeasureTheory/Measure/Haar/Quotient`; OAI `NumberTheory/DukePrimeDegree`

**MeasuredGroupTheory** (wave B)
- primary: Kechris–Miller 2004, *Orbit Equivalence* (?); Kechris 2010, *Global Aspects of Ergodic Group Actions* (?); Kerr–Li 2016, *Ergodic Theory* (?)
- theorem: Gaboriau 2000, *Coût des relations d'équivalence et des…* (?); Lyons 2017, *Factors of IID on trees* (?); Lyons–Nazarov 2011, *Perfect matchings as IID factors on…* (?)
- formal: Mathlib `Dynamics/Ergodic`

**ErgodicRamseyTheory** (wave B)
- primary: Furstenberg 1981, *Recurrence in Ergodic Theory and…* (?); Host–Kra 2018, *Nilpotent Structures in Ergodic Theory* (?); Einsiedler–Ward 2011, *Ergodic Theory with a view towards…* (?); Tao–Vu 2006, *Additive Combinatorics*
- theorem: Bergelson–Leibman 1996, *Polynomial extensions of van der…* (?); Furstenberg–Katznelson 1985, *Ergodic Szemerédi theorem for…* (?)
- formal: Mathlib `Combinatorics/HalesJewett`; OAI `Dynamics/MultipleMixing`

**TwistMapsBilliardsAndKAM** (wave B)
- primary: Katok–Hasselblatt 1995, *Modern Theory of Dynamical Systems* (?); Siburg 2004, *Principle of Least Action in Geometry…* (?); Arnold 1989, *Mathematical Methods of Classical…* (?); Tabachnikov 2005, *Geometry and Billiards* (?)
- theorem: Brown–Neumann 1977, *Proof of the Poincaré–Birkhoff fixed…* (?); Pöschel 2001, *Lecture on the classical KAM theorem* (?); Moser 1962, *Invariant curves of area-preserving…* (?); Lazutkin 1973, *Existence of caustics for a billiard…* (?); Zemlyakov–Katok 1975, *Topological transitivity of billiards…* (?)
- statement: Bialy–Mironov 2022, *Birkhoff–Poritsky conjecture for…* (?)
- formal: Mathlib `Dynamics/Circle/RotationNumber/TranslationNumber`; OAI `Dynamics/StandardMap`; OAI `Dynamics/TriangleBilliards`

**QualitativeODEAndBifurcations** (wave A)
- primary: Perko 2001, *Differential Equations and Dynamical…* (?); Chicone 2006, *Ordinary Differential Equations with…* (?); Guckenheimer–Holmes 1983, *Nonlinear Oscillations, Dynamical…* (?); Feinberg 2019, *Foundations of Chemical Reaction…* (?)
- conventions: Kuznetsov 2004, *Applied Bifurcation Theory* (?)
- theorem: Carr 1981, *Applications of Centre Manifold Theory* (?); Roussarie 1998, *Bifurcations of Planar Vector Fields…* (?)
- statement: Ilyashenko 1991, *Finiteness Theorems for Limit Cycles* (?); Écalle 1992, *Introduction aux fonctions analysables…* (?); Peixoto 1962, *Structural stability on two-dimensional…* (?)
- formal: Mathlib `Dynamics/Flow`; Tau Ceti `Dynamics/Flow`; OAI `Analysis/LienardCycles`; OAI `Analysis/MassAction`

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Einsiedler–Ward 2011, *Ergodic Theory with a view towards…* [4] ★; Katok–Hasselblatt 1995, *Modern Theory of Dynamical Systems* [3] ★; Walters 1982, *Ergodic Theory* [3] ★; Georgii 2011, *Gibbs Measures and Phase Transitions* [2] ★; Janson–Łuczak–Ruciński 2000, *Random Graphs* [2] ★; Karatzas–Shreve 1991, *Brownian Motion and Stochastic Calculus* [2] ★; Kerr–Li 2016, *Ergodic Theory* [2] ★; Revuz–Yor 1999, *Continuous Martingales and Brownian…* [2] ★; Ruelle 2004, *Thermodynamic Formalism* [2] ★; Asmussen 2003, *Applied Probability and Queues* [1] ★; Bain–Crisan 2009, *Fundamentals of Stochastic Filtering* [1] ★; Bakry–Gentil–Ledoux 2014, *Analysis and Geometry of Markov…* [1] ★; Barlow 2017, *Random Walks and Heat Kernels on Graphs* [1] ★; Bogachev 1998, *Gaussian Measures* [1] ★; Bollobás–Riordan 2006, *Percolation* [1] ★; Boucheron–Lugosi–Massart 2013, *Concentration Inequalities* [1] ★; Brazitikos et al. 2014, *Geometry of Isotropic Convex Bodies* [1] ★; Carr 1981, *Applications of Centre Manifold Theory* [1] ★; Chicone 2006, *Ordinary Differential Equations with…* [1] ★; Dembo–Zeitouni 1998, *Large Deviations Techniques and…* [1] ★; Deuschel–Stroock 1989, *Large Deviations* [1] ★; Écalle 1992, *Introduction aux fonctions analysables…* [1] ★; Feinberg 2019, *Foundations of Chemical Reaction…* [1] ★; Le Gall 2016, *Brownian Motion, Martingales, and…* [1] ★; Glasner 2003, *Ergodic Theory via Joinings* [1] ★; Grimmett 1999, *Percolation* [1] ★; Guckenheimer–Holmes 1983, *Nonlinear Oscillations, Dynamical…* [1] ★; den Hollander 2000, *Large Deviations* [1] ★; Ilyashenko 1991, *Finiteness Theorems for Limit Cycles* [1] ★; Kallenberg 2021, *Foundations of Modern Probability* [1] ★; Kuznetsov 2004, *Applied Bifurcation Theory* [1] ★; Lawler–Limic 2010, *Random Walk* [1] ★; Ledoux 2001, *Concentration of Measure Phenomenon* [1] ★; Ledoux–Talagrand 1991, *Probability in Banach Spaces* [1] ★; Madras–Slade 1993, *Self-Avoiding Walk* [1] ★; Norris 1997, *Markov Chains* [1] ★; Perko 2001, *Differential Equations and Dynamical…* [1] ★; Roussarie 1998, *Bifurcations of Planar Vector Fields…* [1] ★; Simon 1993, *Statistical Mechanics of Lattice Gases… I* [1] ★; Stroock–Varadhan 1979, *Multidimensional Diffusion Processes* [1] ★; Talagrand 2021, *Upper and Lower Bounds for Stochastic…* [1] ★; Villani 2009, *Optimal Transport* [1] ★; Woess 2000, *Random Walks on Infinite Graphs and…* [1] ★.

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
