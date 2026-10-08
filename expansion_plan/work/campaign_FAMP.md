# Campaign FAMP: functional analysis, operator algebras, spectral theory, mathematical physics

Phase-2 slate, 2026-10-07. Machine-readable twin: `slate_FAMP.json` (20 roadmaps). Mapping script and
working files: `scratchpad/p2-famp/`.

## 1. Scope

**Classes.** math.FA, math.OA, math.SP, math-ph (tagged math.MP). The campaign covers Banach-space geometry and
operator theory beyond the single self-adjoint operator, C*- and von Neumann algebras with their K-theory and
free probability, spectral theory of unbounded and Schrödinger operators, and rigorous quantum theory
(quantum information, many-body systems, quantum lattice systems, axiomatic QFT).

**Demand** (`needs_all.jsonl`, `campaign == FAMP`): 135 needs touching 67 OpenAI families.

| goal | gap | oai-lean | mathlib | open-pr | tauceti-roadmap | birkbeck | tauceti-code | total |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| OpenAI | 66 | 28 | 18 | 14 | 2 | 2 | 1 | 131 |
| Annals | 1 (#100) | | | 2 (#92, #99) | 1 (#86) | | | 4 |
| LMFDB | | | | | | | | 0 |

By class: math.OA 53, math.MP 39, math.FA 32, math.SP 11. By source: openai_analysis 70, openai_probability_physics 52,
algebra 5, geometry 4, annals_52_100 4. A further 100 rows name FAMP as secondary (OpenAI 90, Annals 8, LMFDB 2;
from PRDS 34, GEO 25, ALG 9, ANA 9, COMB 8, LTCS 8, TOP 4, NT 3).

**Boundary moves (BOUNDARIES.md).** 13 primary rows leave: 12 classical lattice and continuum
statistical-mechanics rows (#215, #216, #218, #223, #225, #228, #232, #233, #237: Gibbs measures, O(n)/XY,
transfer matrices, Peierls/reflection positivity, planar Ising, six-vertex/Bethe ansatz, continuum Gibbs) go to
PRDS ("Gibbs measures … even when the source paper is math-ph"; IntegrableLatticeModels follows them because all
five consumer families are math.PR), and Annals #86 (Laplace–Beltrami) goes to GEO. Nine rows come in: operator
K-theory and L²-Betti rows tagged math.KT/math.AT (#285 ×3, #307, #315), quantum Shannon theory (#273, #276),
mutually unbiased bases (#266), and strong convergence (Annals #99, tagged math.PR). **Net territory: 131 needs
(127 OpenAI, 4 Annals: #92, #99 ×2, #100), 65 gaps; the slate absorbs 63, 2 are frontier.** LMFDB enters only
through NT's Maass-form rows, which consume SpectralTheory.

## 2. Existing supply

- **OneParameterSemigroups** (main, math.FA): C₀-semigroups, Hille–Yosida, Stone for unbounded generators, Bochner
  on LCA groups. STATUS 2026-10-05: all parts done, one optional item open. Supplies Stone to ModularTheory,
  SchrodingerOperators, AxiomaticQFT. *Leave; archive.* Trotter and positivity go to SchrodingerOperators, Markov
  semigroups to PRDS.
- **OperatorTheory, PR #126** (open, `awaiting-review` since 2026-07-31, math.FA; 8 sub-roadmaps, ≈830 target items,
  ported from Kitware's Apache-2.0 DKPS code): polar decomposition, majorization, Schatten classes, Borel calculus,
  PVMs, unbounded spectral theorem, Kato–Rellich. 14 needs name it as owner (Annals #92; #082, #144, #261–263, #267,
  #270, #275, #278, #287, #307); the Annals report adds #70, #86, #99, #100. *Merge soon: the most important step
  for this campaign. Ask the author to add the trace on S₁, B(H)_* ≅ S₁, K(H)* ≅ S₁, Lidskii and Fredholm
  determinants to OperatorIdeals, and to host the two roadmaps of §3.4.*
- **RandomMatrices, PR #397** (open, math.PR): M6 owns C*-level free probability (freeness, free cumulants and
  convolution, R/S-transforms, reduced free products, asymptotic freeness in moments) and excludes strong
  convergence and Brown measures. 21 needs name it (here Annals #99, #287, #298). *Merge soon; FreeProbability
  starts where M6 stops.*
- **Completed/OrthogonalL2Bases** (Hermite functions, OPRL), **RepresentationTheory/SpinRepresentations,
  CompactGroups, LieGroups** (algebraic Fock model, SU(2) spins, Poincaré and Möbius groups), **PDE** (Sobolev on
  domains, Rellich), **TemperleyLieb #58** and **PivotalSpherical #57** (index theorem, sector categories): *leave;
  consumed.* **Quantum walks #258/#259** (math.CO): no FAMP action.
- **Birkbeck campaign**: no FAMP roadmap, but NT's AutomorphicSpectralTheory **AS.0** builds direct integrals,
  trace-class integral operators and unbounded-operator extensions, and MetaplecticAutomorphicForms **MP.1** builds
  Stone–von Neumann. *Consolidate (§4.4 rule 3): VN Layer 0 and UnboundedOperators own the generic layer, AS.0
  consumes by alias; MP.1 and ManyBody share one Stone–von Neumann statement.* No explorer draft exists here;
  `opportunities.json` lists operator algebras as uncovered.
- **Code.** Tau Ceti: `Analysis/Fredholm`, `Analysis/Semigroups` (Stone), `Complex/Herglotz`, `Complex/Pick`
  (Nevanlinna), `LinearPMap/SelfAdjoint`. Mathlib: CFC, GNS, `CompletelyPositiveMap`, `CStarMatrix`, Hilbert
  C*-modules, WOT, `VonNeumannAlgebra`/`WStarAlgebra` (definitions only), `StandardSubspace`, RKHS,
  `GeneralSchauderBasis`, `UniformConvexSpace`, Mazur–Ulam, Fredholm operators; no trace class, partial trace or
  quantum entropy. OAI Lean (Apache-2.0) is large but ad hoc (`CuntzSubequiv`, `IsNuclear`, `TracialState` each
  defined in 3+ directories): use it and `ComparatorChallenges` as statement templates and coordinate with OpenAI
  before integrating anything; likewise Lean-QuantumInfo (Meiburg) and PhysLean (Tooby-Smith).

## 3. The slate

Twenty roadmaps: four families (RepresentationTheory model) and a two-roadmap extension of #126, i.e. five
review units. Goal refs are OAI family numbers unless marked Annals.

### 3.1 OperatorAlgebras (math.OA): family of 7, ≈1,570 PRs

C*- and von Neumann algebras beyond Mathlib's definitions. Single-operator theory is #126; unbounded operators are SpectralTheory; CCR/CAR and quasi-local algebras are QuantumTheory; amenability and (T) are ALG's.

**1. `OperatorAlgebras/VonNeumannAlgebras`** — math.OA, L (≈300 PRs), wave A.

*Scope.* This roadmap builds the structure theory of von Neumann algebras from Mathlib's bicommutant definition to the toolkit of II₁ factor theory. It starts with completed and infinite tensor products, direct integrals and the trace class as predual of B(H), proves the bicommutant and Kaplansky density theorems, and identifies `WStarAlgebra` with `VonNeumannAlgebra` (Sakai). It develops comparison and type theory, the center-valued trace, tracial algebras and L²(M,τ), conditional expectations and Jones index, group and group-measure-space algebras, the hyperfinite II₁ factor, ultraproducts and property Γ, MASAs, bimodules, injectivity, and the derivation, cohomology and perturbation theorems. Weights and type III are ModularTheory; free products are FreeProbability; L²-invariants are L2Invariants.

*Objects.* σ-weak topologies, M_*; ∼, ≼; types I/II/III; ctr; (M,τ), L²(M,τ), J; E_N, ⟨M,e_N⟩, [M:N]; L(G), L^∞(X)⋊G; R; M^t; M^ω; Γ; MASAs; bimodules, ≺_M; H^n(M,M). *Milestones.* (1) bicommutant, Kaplansky density, abelian algebras ≅ L^∞; Sakai; (2) comparison theorem, type decomposition; center-valued trace; M′ = JMJ; (3) Jones: [M:N] ∈ {4cos²(π/n)} ∪ [4,∞]; (4) ICC ⇔ L(G) factor; uniqueness of R; R ≅ L^∞(𝕋)⋊_θℤ; (5) L(F₂) lacks Γ, so L(F₂) ≇ R; hypertrace ⇔ injective; Connes' theorem stated; (6) Popa's intertwining theorem; Kadison–Sakai, Ringrose, Johnson–Kadison–Ringrose, Christensen; Kadison–Singer from paving.

*Prerequisites.* Mathlib VonNeumannAlgebra/WOT; #126 (Borel calculus, OperatorIdeals) from the type layer on; TemperleyLieb #58; NuclearCStarAlgebras (cb maps); ALG AmenabilityAndPropertyT; COMB ExpanderGraphs (MSS paving). *Goals.* OpenAI 10: #280, #282, #286, #287, #288, #289, #293, #295, #296, #300; Annals: #100.

*Porting.* OAI Analysis/{OperatorAlgebra, FactorGeneration, FiniteFactor, BoundedHochschild, KadisonKastler, IrrationalRotation}, ComparatorChallenges/InterpolatedFactors. *Formalizability.* High; Connes' theorem stays a statement.

**2. `OperatorAlgebras/ModularTheory`** — math.OA, L (≈220 PRs), wave B.

*Scope.* This roadmap develops Tomita–Takesaki theory and the structure of non-tracial von Neumann algebras, building on Mathlib's `StandardSubspace`. It builds normal semifinite weights, the modular operator and conjugation, the modular group and the KMS condition, Connes cocycles, the standard form, conditional expectations and operator-valued weights, crossed products by locally compact abelian groups with Takesaki duality, and the continuous core. It classifies type III_λ factors by Connes' invariants, constructs Powers and Araki–Woods factors, defines the flow of weights, and proves Borchers' theorem and the half-sided modular inclusion theorem abstractly. Tracial theory is VonNeumannAlgebras; KMS states of lattice systems are QuantumSpinSystems; Bisognano–Wichmann is AxiomaticQuantumFieldTheory.

*Objects.* weights; S = JΔ^{1/2}; σ^φ; KMS; (Dψ:Dφ)_t; standard form; operator-valued weights; M⋊_σℝ; S(M), T(M); R_λ; flow of weights. *Milestones.* (1) Tomita's theorem; Takesaki's KMS uniqueness; Pedersen–Takesaki; (2) Connes cocycle theorem; Haagerup's uniqueness of the standard form; Takesaki's expectation criterion; (3) Takesaki duality; semifiniteness of the core; (4) Connes' III_λ classification; Powers factors distinct; (5) Borchers; half-sided modular inclusions (Wiesbrock, Araki–Zsido); bicentralizer problem stated.

*Prerequisites.* VonNeumannAlgebras; #126 (closed operators); OneParameterSemigroups; Mathlib StandardSubspace. *Goals.* OpenAI 3: #280, #282, #290.

*Porting.* OAI Analysis/{ModularTheory, ModularRecovery}; Takesaki II, Strătilă; coordinate with the StandardSubspace author. *Formalizability.* Medium; closed antilinear operators are the cost.

**3. `OperatorAlgebras/NuclearCStarAlgebras`** — math.OA, L (≈280 PRs), wave A.

*Scope.* This roadmap develops C*-algebras through their maps, tensor products and standard constructions. It adds irreducible representations and Kadison transitivity, universal C*-algebras on generators and relations and the enveloping von Neumann algebra, then the theory of completely positive and completely bounded maps (operator systems and spaces, Stinespring, Arveson extension, Wittstock and Haagerup–Paulsen factorization, the similarity problem). It treats minimal and maximal tensor products, nuclearity and exactness, full and reduced group C*-algebras, discrete crossed products, inductive limits and the standard examples (AF, UHF, Cuntz, irrational rotation, dimension-drop and Jiang–Su algebras, amalgamated free products, HNN extensions), and norm ultrapowers. Amenability and property (T) are ALG's; comparison and absorption are CStarRegularity; K-theory is OperatorKTheory; CAR and CCR algebras are ManyBodyQuantumMechanics.

*Objects.* universal C*-algebras; A**; operator systems/spaces; cp, cb maps; ⊗_min, ⊗_max; nuclear, exact; C*(G), C*_r(G); A⋊G; Bratteli diagrams; UHF, O_n, A_θ, Z; A^ω. *Milestones.* (1) Kadison transitivity; irreducible algebras meeting K(H) contain it; (2) Stinespring, Choi, Arveson extension, Wittstock; Haagerup's similarity theorem; Kirchberg's derivation–similarity equivalence; (3) Choi–Effros and Kirchberg characterizations of nuclearity and exactness; (4) Hulanicki–Lance; Powers: C*_r(F₂) simple with unique trace; (5) Glimm's UHF classification; O_n simple purely infinite; Jiang–Su; Kazhdan projections; Kirchberg's O₂ theorems stated.

*Prerequisites.* Mathlib CStarAlgebra (CP maps, CStarMatrix, GNS, Hilbert modules); VonNeumannAlgebras (A**); ALG AmenabilityAndPropertyT. *Goals.* OpenAI 7: #285, #288, #291, #292, #294, #297, #302.

*Porting.* OAI Analysis/{Nuclearity, NuclearUltrapower, Naimark, Cuntz, CStarAlgebra}, ComparatorChallenges/KadisonSimilarity. *Formalizability.* High.

**4. `OperatorAlgebras/CStarRegularity`** — math.OA, L (≈200 PRs), wave B.

*Scope.* This roadmap develops the comparison theory of positive elements and the regularity properties of the Elliott programme. It builds Cuntz subequivalence and the Cuntz semigroup, dimension functions and 2-quasitraces, stable and real rank, proper and pure infiniteness, strict comparison, almost unperforation, the radius of comparison, tracial weights and trace cones, central sequence algebras, order-zero maps, nuclear dimension, strongly self-absorbing algebras with the Z-, O₂- and O_∞-absorption theorems, and cocycle conjugacy and equivariant absorption as definitions. The classification theorem, the Toms–Winter conjecture and Haagerup's quasitrace theorem are stated with precise invariants. Examples are NuclearCStarAlgebras'; K-theoretic invariants are OperatorKTheory's.

*Objects.* ≾; W(A), Cu(A); 2-quasitraces; sr, RR; strict comparison; rc(A); T(A); A_ω ∩ A′; order-zero maps; dim_nuc; strongly self-absorbing D. *Milestones.* (1) Coward–Elliott–Ivanescu; Blackadar–Handelman; (2) Rørdam: Z-stable ⇒ almost unperforated, strict comparison; (3) Toms–Winter central-sequence criterion; Kirchberg–Rørdam pure infiniteness and O_∞; (4) Winter–Zacharias; dim_nuc C(X) = dim X; (5) Matui–Sato, Winter, Kirchberg–Phillips, the classification theorem and Haagerup's theorem stated.

*Prerequisites.* NuclearCStarAlgebras; OperatorKTheory. *Goals.* OpenAI 6: #291, #294, #299, #301, #302, #303.

*Porting.* OAI Analysis/{JiangSu, TracialSplitting, Quasitrace, Kaplansky, WeakInfiniteness, OInfinity, PureInfiniteness, CharacterCriterion, TraceCone}. *Formalizability.* Medium; deep classification stays stated.

**5. `OperatorAlgebras/OperatorKTheory`** — math.OA, L (≈220 PRs), wave B.

*Scope.* This roadmap develops the K-theory of C*-algebras and its pairings, ending with the assembly maps of higher index theory stated precisely. It builds K₀ and K₁, half-exactness, stability and continuity, Bott periodicity, the six-term sequence with index maps matched to Tau Ceti's Fredholm index, the trace pairing, Swan's identification of K₀(C(X)), Elliott's AF classification, the K-theory of Cuntz and rotation algebras, and Pimsner–Voiculescu; then Fredholm modules and analytic K-homology, the Baum–Connes map for torsion-free groups with finite classifying space, Roe algebras and coarse assembly. KK- and E-theory are not included. Spaces' K-theory and classifying spaces are TOP's. Topic math.OA, secondary math.KT.

*Objects.* K₀, K₁; Bott map; index/exponential maps; dimension groups; Fredholm modules, K^*(A); μ: K_*(BG) → K_*(C*_rG); Roe algebras. *Milestones.* (1) Bott periodicity; six-term sequence; (2) Elliott's AF classification; (3) K_*(O_n) = (ℤ/(n−1), 0); trace range ℤ+θℤ on K₀(A_θ); (4) Pimsner–Voiculescu; C*_r(F_n) has no nontrivial projections; (5) Toeplitz index; Baum–Connes and coarse Baum–Connes stated.

*Prerequisites.* NuclearCStarAlgebras; Tau Ceti Analysis/Fredholm; ClassifyingSpaces #437; TOP topological K-theory; GEO elliptic operators (Dirac on 𝕋²). *Goals.* OpenAI 4: #285, #301, #302, #307.

*Porting.* no OAI Lean for #285; Rørdam–Larsen–Laustsen, Blackadar, Higson–Roe, Willett–Yu. *Formalizability.* Medium-high; K-homology is the cost.

**6. `OperatorAlgebras/FreeProbability`** — math.OA, L (≈230 PRs), wave B.

*Scope.* This roadmap develops free probability at the von Neumann level and its uses for free group factors and strong convergence. Starting where RandomMatrices #397 M6 stops (C*-level freeness, cumulants, transforms), it builds tracial reduced free products, the full Fock space with semicircular systems, free group factors and their compressions, interpolated free group factors, freeness with amalgamation, Haagerup's inequality, the Brown measure, free Fisher information and free entropy. It ends with strong convergence: definition, linearization, and the Haagerup–Thorbjørnsen, Collins–Male and Bordenave–Collins theorems via the Chen–Garza-Vargas–Tropp–van Handel method, with Friedman's theorem as a corollary. Matrix models and concentration are imported from #397 and PRDS.

*Objects.* tracial free products; full Fock space; L(F_n), L(F_r); B-valued semicircular elements; Δ_FK, Brown measure; Φ*, χ, χ*, δ₀; strong asymptotic freeness. *Milestones.* (1) free semicircular systems generate L(F_n); L(G)*L(H) ≅ L(G*H); (2) compression formula; Dykema–Rădulescu dichotomy; (3) Haagerup's inequality; Brown measure; (4) Biane–Capitaine–Guionnet χ ≤ χ*; no-Cartan and primeness of L(F_n) stated; (5) Haagerup–Thorbjørnsen (Ext(C*_rF₂) not a group); Bordenave–Collins; Friedman λ₂ ≤ 2√(d−1)+ε.

*Prerequisites.* VonNeumannAlgebras; RandomMatrices #397; NuclearCStarAlgebras; PRDS ConcentrationAndFunctionalInequalities. *Goals.* OpenAI 3: #287, #288, #298; Annals: #99.

*Porting.* OAI Analysis/{FreeEntropy, FreeGroupFactor, InterpolatedFactors, BrownMeasure, FreeWords}, ComparatorChallenges/FiniteEntropySeparation. *Formalizability.* Medium-high.

**7. `OperatorAlgebras/L2Invariants`** — math.OA, M (≈120 PRs), wave B.

*Scope.* This roadmap treats the operator algebras of a discrete group as carriers of L²-invariants. From ℓ²(G), L(G) and C*_r(G) with the canonical trace it builds Hilbert L(G)-modules and von Neumann dimension, Lück's dimension for all L(G)-modules, the Fuglede–Kadison determinant, L²-Betti numbers of free cocompact G-CW complexes and of groups, L²-torsion, and ℓ¹(G), with the standard computations and the approximation and vanishing theorems. Cellular chains and classifying spaces are TOP's; Kaplansky's stable finiteness of ℂ[G] is here, the zero-divisor and unit conjectures are ALG's GroupRings.

*Objects.* Hilbert L(G)-modules; dim_{L(G)}; Δ_FK; β^{(2)}_n; L²-torsion; ℓ¹(G). *Milestones.* (1) properties of von Neumann dimension; Lück's dimension function; (2) β^{(2)} of finite groups, ℤⁿ, F_n, surface groups; Euler–Poincaré; (3) Cheeger–Gromov vanishing for amenable groups; Lück approximation; (4) Kaplansky stable finiteness; Atiyah and Singer conjectures stated.

*Prerequisites.* VonNeumannAlgebras; NuclearCStarAlgebras; ClassifyingSpaces #437; AlgebraicTopology (main); ALG AmenabilityAndPropertyT. *Goals.* OpenAI 3: #197, #207, #315.

*Porting.* OAI Analysis/GroupDeterminants. *Formalizability.* High.

### 3.2 SpectralTheory (math.SP): family of 4, ≈710 PRs

Unbounded self-adjoint and Schrödinger operators, from where #126 SelfAdjointSpectralTheory stops. Laplace–Beltrami is GEO's; graph Laplacians COMB's; Maass forms NT's; domain PDE ANA's.

**8. `SpectralTheory/UnboundedOperators`** — math.SP, L (≈220 PRs), wave B.

*Scope.* This roadmap develops the general spectral theory of unbounded self-adjoint operators, starting where #126 SelfAdjointSpectralTheory stops (spectral theorem, Stone, Kato–Rellich). It builds von Neumann's extension theory, closed semibounded forms, KLMN and the Friedrichs extension, min–max, discrete and essential spectrum with Weyl's criterion and perturbation theorem, compact resolvents, the pp/ac/sc decomposition and RAGE, Kato's analytic perturbation theory, rank-one perturbations and Herglotz boundary values, trace ideals in spectral theory (trace, Lidskii, Fredholm determinants, Birman–Schwinger), and wave operators. Concrete operators are the sibling sub-roadmaps; if #126's OperatorIdeals gains the trace and determinants first, this roadmap consumes them.

*Objects.* deficiency indices; closed forms; Friedrichs extension; σ_disc, σ_ess; H_pp, H_ac, H_sc; analytic families; Borel transforms; det(1+A); Ω±. *Milestones.* (1) von Neumann extension theorem; KLMN; Friedrichs; (2) min–max; Weyl's criterion and theorem; RAGE; (3) Kato–Rellich analytic perturbation; (4) Aronszajn–Donoghue; Simon–Wolff; (5) Lidskii; Birman–Schwinger; Kato–Rosenblum.

*Prerequisites.* #126 (SelfAdjointSpectralTheory, OperatorIdeals); OneParameterSemigroups; Tau Ceti Herglotz, Pick/Nevanlinna, Fredholm. *Goals.* OpenAI 7: #261, #262, #263, #267, #270, #275, #278.

*Porting.* OAI Analysis/LiebThirring/{QuadraticForms, DiscreteSpectrum}. *Formalizability.* High.

**9. `SpectralTheory/SchrodingerOperators`** — math.SP, L (≈250 PRs), wave B.

*Scope.* This roadmap develops Schrödinger operators −Δ+V on ℝ^d and ℤ^d and the standard theorems on their spectra and eigenfunctions. It builds Kato's inequality, Kato-class and L^p+L^∞ potentials, Hardy and Sobolev form bounds, self-adjointness of Coulomb Hamiltonians, magnetic operators and the diamagnetic inequality, Trotter's formula and positivity-improving semigroups, ground-state uniqueness, Dirichlet–Neumann bracketing and Weyl asymptotics, HVZ, Agmon and Combes–Thomas decay, IMS localization, the CLR and Lieb–Thirring inequalities, and Floquet–Bloch theory with Thomas' theorem. Many-particle applications are ManyBodyQuantumMechanics; the line is SturmLiouvilleAndJacobiOperators; random potentials are RandomSchrodingerOperators; Sobolev spaces on domains come from PDE.

*Objects.* −Δ+V, Kato class; magnetic operators; e^{−tH}; Dirichlet/Neumann Laplacians; N-body cluster decompositions; Agmon metric; N(H), Σ|λ_j|^γ; Bloch fibres. *Milestones.* (1) Kato–Rellich for Coulomb; KLMN for form-bounded V; (2) ground state simple and positive; Weyl law by bracketing; (3) HVZ; Agmon decay; IMS; (4) CLR and Lieb–Thirring (Rumin); (5) Floquet–Bloch; Thomas: periodic operators have purely absolutely continuous spectrum.

*Prerequisites.* UnboundedOperators; PDE (main); OneParameterSemigroups; Mathlib Fourier and Sobolev; Tau Ceti Fredholm. *Goals.* OpenAI 7: #261, #262, #263, #267, #270, #275, #278; Annals: #92.

*Porting.* OAI Analysis/{LiebThirring, CoulombIonization}, MathematicalPhysics/{Coulomb, ContinuumCoulomb, BFSS}. *Formalizability.* High (textbook).

**10. `SpectralTheory/SturmLiouvilleAndJacobiOperators`** — math.SP, M (≈130 PRs), wave B.

*Scope.* This roadmap develops self-adjoint operators on the line and half-line, continuum and discrete: Weyl's limit-point/limit-circle alternative, Weyl–Titchmarsh m-functions and spectral measures, Jacobi matrices with orthogonal polynomials and Favard's theorem, transfer matrices, Gilbert–Pearson subordinacy, Wigner–von Neumann embedded eigenvalues, and Floquet theory of periodic operators. Quasi-periodic operators enter through the almost Mathieu operator and Aubry–André duality, with Kotani theory and the Ten Martini theorem stated. Lyapunov exponents use Furstenberg–Kesten from PRDS; random one-dimensional operators are RandomSchrodingerOperators.

*Objects.* limit point/circle; m(z); Jacobi matrices, OPRL; transfer matrices; subordinate solutions; Floquet discriminant; almost Mathieu operator. *Milestones.* (1) Weyl alternative; Weyl–Titchmarsh–Kodaira; (2) Favard; Gilbert–Pearson; Jitomirskaya–Last; (3) band structure of periodic operators; (4) Aubry–André duality; Kotani and Ten Martini stated.

*Prerequisites.* UnboundedOperators; Tau Ceti Herglotz, Pick; Completed/OrthogonalL2Bases; PRDS ErgodicTheory. *Goals.* OpenAI 1: #261; Annals: #92.

*Porting.* Teschl (Jacobi operators), Simon (Szegő's theorem and its descendants), Damanik–Fillman. *Formalizability.* High.

**11. `SpectralTheory/RandomSchrodingerOperators`** — math.SP, M (≈110 PRs), wave C.

*Scope.* This roadmap develops random Schrödinger operators following Aizenman–Warzel: ergodic operator families and Pastur's almost-sure spectrum, the integrated density of states, the Wegner estimate, Combes–Thomas bounds, and the fractional-moment proof of spectral and dynamical localization at large disorder and band edges, with Simon–Wolff from UnboundedOperators. It proves one-dimensional localization (Kunz–Souillard) and states Klein's Bethe-lattice theorem and Lifshitz tails. Random matrices and random graphs are PRDS's.

*Objects.* ergodic families; Anderson model; IDS; fractional moments; eigenfunction correlators. *Milestones.* (1) Pastur; existence of the IDS; Wegner; (2) Aizenman–Molchanov localization; dynamical localization; (3) Kunz–Souillard; Klein stated.

*Prerequisites.* SchrodingerOperators; SturmLiouvilleAndJacobiOperators; PRDS ErgodicTheory. *Goals.* OpenAI 2: #219, #261.

*Porting.* OAI MathematicalPhysics/{Anderson, PlanarAnderson}. *Formalizability.* High; the source is self-contained.

### 3.3 QuantumTheory (math.MP): family of 4, ≈930 PRs

Quantum information, many-body quantum mechanics, quantum lattice systems, axiomatic QFT. Quantum computation is LTCS's; classical statistical mechanics, including exactly solved models, is PRDS's.

**12. `QuantumTheory/QuantumInformationTheory`** — math.MP, L (≈260 PRs), wave A.

*Scope.* This roadmap develops quantum information theory following Watrous, Wilde and Holevo. It builds finite-dimensional states, measurements and partial traces, channels in Kraus, Stinespring and Choi form, the diamond norm, trace distance and fidelity, and entanglement theory (separability, PPT, entanglement-breaking channels, LOCC, distillable entanglement and key, Nielsen's theorem, mutually unbiased bases). It develops von Neumann, relative and Rényi entropies with strong subadditivity, data processing and continuity bounds, quantum Shannon theory (typical subspaces, Schumacher, Holevo, HSW, capacities), and bosonic Gaussian states and channels. Classical Shannon theory is LTCS's; circuits and nonlocal games are LTCS's QuantumComputation, which imports channels from here.

*Objects.* density matrices, POVMs; CPTP maps, Choi matrix; ‖·‖_⋄; fidelity; SEP, PPT, EB, LOCC; E_D, K_D; MUBs; S, D(ρ‖σ), Rényi; χ, C(N); Gaussian channels. *Milestones.* (1) Kraus–Stinespring–Choi; Uhlmann; Fuchs–van de Graaf; (2) Peres–Horodecki; Horodecki–Shor–Ruskai; Nielsen; (3) Lieb–Ruskai SSA; Lindblad–Uhlmann; Fannes–Audenaert, Alicki–Fannes–Winter; (4) Holevo bound; Schumacher; HSW; (5) Gaussian entropy maximality; entropy photon-number inequality stated.

*Prerequisites.* Mathlib CompletelyPositiveMap, CFC; OperatorConvexityAndTraceInequalities; #126 Majorization; ManyBodyQuantumMechanics (bosonic layer); LTCS ShannonInformationTheory. *Goals.* OpenAI 6: #265, #266, #272, #273, #276, #277.

*Porting.* OAI InformationTheory/{AmplitudeDamping, Entanglement, SecretKey, PhotonNumber, SoftChannel}, Analysis/MutuallyUnbiased; Lean-QuantumInfo (A. Meiburg): coordinate first. *Formalizability.* High.

**13. `QuantumTheory/ManyBodyQuantumMechanics`** — math.MP, L (≈250 PRs), wave C.

*Scope.* This roadmap develops nonrelativistic many-body quantum mechanics following Lieb–Seiringer and Bratteli–Robinson. It builds symmetric and antisymmetric N-particle spaces with spin, reduced density matrices, bosonic and fermionic Fock spaces with second quantization, the CAR and Weyl CCR algebras and their Fock representations, quasi-free states and Bogoliubov transformations, and the lowest Landau level. It proves Zhislin's theorem, Lieb's ionization bound, the Lieb–Thirring and Lieb–Oxford inequalities, Thomas–Fermi theory and stability of matter, the Hartree–Fock and density-functional variational principles, the dilute Bose gas energy, and the basics of Bogoliubov Hamiltonians and Laughlin states. One-body theory is SpectralTheory's; lattice systems are QuantumSpinSystems.

*Objects.* ⊗ⁿ_s, ⊗ⁿ_a; γ^{(k)}; Fock spaces, a, a*, Γ, dΓ, W(f); CAR(H), CCR(H,σ); quasi-free states; Coulomb H_{N,Z}; TF and Levy–Lieb functionals. *Milestones.* (1) CAR(H) ≅ M_{2^∞}; Slawny; Stone–von Neumann; Shale; (2) Coleman; Lieb's variational principle; Lieb's DFT; (3) Zhislin; Lieb's N < 2Z+1; (4) Lieb–Thirring kinetic energy; Lieb–Oxford; Lieb–Simon; stability of matter; (5) Lieb–Yngvason 4πρa; Laughlin zero modes.

*Prerequisites.* SchrodingerOperators; VonNeumannAlgebras (Hilbert tensor products); NuclearCStarAlgebras (UHF); RepresentationTheory/SpinRepresentations; #126 OperatorIdeals. *Goals.* OpenAI 7: #263, #267, #269, #273, #275, #278, #297.

*Porting.* OAI Analysis/{Laughlin, LaughlinFock, CoulombIonization}, MathematicalPhysics/{Fock, Coulomb}; Lieb–Seiringer, Bratteli–Robinson II; PhysLean: coordinate. *Formalizability.* Medium-high.

**14. `QuantumTheory/QuantumSpinSystems`** — math.MP, L (≈220 PRs), wave B.

*Scope.* This roadmap develops quantum lattice systems following Nachtergaele–Sims–Young, Tasaki and Bratteli–Robinson. In finite volume it builds local Hamiltonians with SU(2) spin operators, frustration-free models and spectral gaps, matrix-product and PEPS states, AKLT, and the Heisenberg models with the Lieb–Mattis, Lieb–Schultz–Mattis, Dyson–Lieb–Simon and random-loop results. In infinite volume it builds the quasi-local algebra, Lieb–Robinson bounds and dynamics, KMS and ground states, exponential clustering, entanglement entropy and the 1D area law, and automorphic equivalence of gapped phases. Classical reflection positivity is PRDS LatticeGibbsMeasures'; the Bethe ansatz is PRDS IntegrableLatticeModels'.

*Objects.* local interactions; frustration-free H; MPS/PEPS, parent Hamiltonians; quasi-local algebra; τ_t; KMS and ground states; AGSP; quasi-adiabatic flow. *Milestones.* (1) Knabe; martingale method; AKLT gap; finitely correlated states; (2) Lieb–Mattis; LSM; Dyson–Lieb–Simon; (3) Lieb–Robinson; infinite-volume dynamics; exponential clustering; (4) 1D area law (Arad–Kitaev–Landau–Vazirani); automorphic equivalence.

*Prerequisites.* QuantumInformationTheory; NuclearCStarAlgebras; ModularTheory (KMS); RepresentationTheory/CompactGroups; PRDS LatticeGibbsMeasures. *Goals.* OpenAI 3: #265, #268, #271.

*Porting.* OAI MathematicalPhysics/{Heisenberg, TensorNetwork, PEPSFilters, PEPSMove, PEPSSubvolume}. *Formalizability.* High in finite volume; medium for the dynamics.

**15. `QuantumTheory/AxiomaticQuantumFieldTheory`** — math.MP, L (≈200 PRs), wave C.

*Scope.* This roadmap develops the axiomatic frameworks of relativistic quantum field theory and their reconstruction theorems. It builds the Poincaré group and its positive-energy representations (Wigner's classification), the Wightman axioms with reconstruction, Reeh–Schlieder and Källén–Lehmann, the free scalar field, the Osterwalder–Schrader axioms with reconstruction and its lattice transfer-matrix form, Haag–Kastler nets with Bisognano–Wichmann and Borchers, and conformal nets on S¹ with DHR sectors and their index. Construction of interacting models is not included. Modular theory, Fock space and reflection positivity are imported; tensor categories and vertex algebras are ALG's.

*Objects.* Poincaré group, positive-energy representations; Wightman and Schwinger functions; free field; nets 𝒜(O); conformal nets; DHR endomorphisms; Jones–Kosaki index. *Milestones.* (1) Wightman reconstruction; Reeh–Schlieder; Källén–Lehmann; (2) OS reconstruction; lattice version with mass gap; (3) Bisognano–Wichmann for the free field; Borchers; (4) DHR braided category and KLM μ-index stated.

*Prerequisites.* ModularTheory; ManyBodyQuantumMechanics; RepresentationTheory/LieGroups; Mathlib distributions; PRDS LatticeGibbsMeasures; PivotalSpherical #57. *Goals.* OpenAI 3: #215, #280, #282.

*Porting.* Streater–Wightman, Haag, Glimm–Jaffe, Longo's notes; PhysLean (Lorentz group): coordinate. *Formalizability.* Medium.

### 3.4 Extension of OperatorTheory #126 (math.FA): 2 roadmaps, ≈320 PRs

One PR adding two sub-roadmaps to #126's family after it merges; two top-level siblings if the author declines.

**16. `NonselfadjointOperatorTheory`** — math.FA, L (≈220 PRs), wave A.

*Scope.* This roadmap develops operators that are not normal: contractions and their dilations with von Neumann's and Ando's inequalities, the Sz.-Nagy–Foias model, H²(𝔻) with the shift and Beurling's theorem, Toeplitz and Hankel operators with their Fredholm index, spectral and complete spectral sets with Arveson's dilation theorem, numerical ranges and Crouzeix–Palencia, reproducing kernel spaces and Nevanlinna–Pick interpolation for complete Pick kernels, invariant and hyperinvariant subspaces, reflexive algebras and weighted shifts. Normal operators are #126's; H^p boundary values for p ≠ 2, ∞ are ANA's; the Brown measure is FreeProbability's. Proposed as OperatorTheory/NonselfadjointOperators if #126's author accepts.

*Objects.* dilations; characteristic function; H²(𝔻), inner functions; T_φ, H_φ; K-spectral sets; W(T); RKHS, Pick kernels; Lat T; reflexive algebras. *Milestones.* (1) Sz.-Nagy dilation; von Neumann; Ando; Parrott; (2) Beurling; Brown–Halmos; Toeplitz index; Nehari; (3) Toeplitz–Hausdorff; Crouzeix–Palencia; (4) Pick; Agler–McCarthy; Arveson dilation; (5) Lomonosov; Arveson density and distance.

*Prerequisites.* #126; NuclearCStarAlgebras (cb maps); Mathlib RKHS; Tau Ceti Pick, Fredholm; ConformalMapping (main). *Goals.* OpenAI 4: #288, #293, #325, #369.

*Porting.* OAI Analysis/{NumericalRange, Crouzeix, DirectCrouzeix, HilbertCrouzeix, StructuralCrouzeix, Hyperinvariant, BackwardIntertwiners}. *Formalizability.* High.

**17. `OperatorConvexityAndTraceInequalities`** — math.FA, M (≈100 PRs), wave A.

*Scope.* This roadmap develops the matrix analysis of functions of operators: operator monotone and convex functions with Löwner's theorem via Pick functions, the Hansen–Pedersen Jensen inequality, the Daleckii–Krein formula, Kubo–Ando means, and the trace inequalities of Klein, Peierls–Bogoliubov, Golden–Thompson, Araki–Lieb–Thirring, Lieb, Ando and Epstein, in finite dimension and for bounded operators under trace-class hypotheses. Majorization is #126's; entropy theory is QuantumInformationTheory's. Proposed as OperatorTheory/OperatorConvexity if #126's author accepts.

*Objects.* operator monotone/convex functions; divided differences; operator means A#B; Tr f(A). *Milestones.* (1) Löwner; Hansen–Pedersen; Daleckii–Krein; Kubo–Ando; (2) Golden–Thompson; Araki–Lieb–Thirring; (3) Lieb concavity; Ando convexity; Epstein.

*Prerequisites.* Mathlib CFC; #126 (Majorization, OperatorIdeals); Tau Ceti Pick/Nevanlinna. *Goals.* OpenAI 6: #082, #262, #265, #273, #276, #277.

*Porting.* OAI Analysis/{Matrix, QuantumTrace, StrictMeans}. *Formalizability.* High.

### 3.5 BanachSpaceTheory (math.FA): family of 3, ≈670 PRs

Isomorphic, local and nonlinear theory of Banach spaces. Convex bodies are GEO's ConvexBodies; finite metric embeddings as algorithms are LTCS's MetricEmbeddings.

**18. `BanachSpaceTheory/BasesAndClassicalSpaces`** — math.FA, L (≈220 PRs), wave A.

*Scope.* This roadmap develops the isomorphic theory of Banach spaces: reflexivity as a predicate with weak compactness (Eberlein–Šmulian, James), bases and basic sequences on Mathlib's `GeneralSchauderBasis`, block bases and Bessaga–Pełczyński, the structure of c₀, ℓ_p and L_p, complemented subspaces, Rosenthal's ℓ₁ theorem, the Dunford–Pettis property, the approximation properties, w*-basic sequences and Josefson–Nissenzweig, and Banach ultrapowers. Type, cotype and Dvoretzky are LocalTheory; Lipschitz geometry is NonlinearGeometry; convex bodies are GEO's.

*Objects.* reflexivity; Schauder and unconditional bases; c₀, ℓ_p, L_p; complemented subspaces; DPP; AP, BAP; w*-basic sequences; X^𝒰. *Milestones.* (1) Eberlein–Šmulian; James; (2) Bessaga–Pełczyński; James' basis criteria; (3) Pitt; Pełczyński decomposition; Kadec–Pełczyński; (4) Sobczyk; Phillips; Rosenthal ℓ₁; (5) Grothendieck's AP criteria, Enflo stated; Josefson–Nissenzweig.

*Prerequisites.* Mathlib (weak topologies, GeneralSchauderBasis, Lp). *Goals.* OpenAI 7: #094, #098, #322, #323, #326, #328, #330.

*Porting.* OAI Analysis/{SeparableQuotients, SphereIsometry, Nonexpansive, Cotype}. *Formalizability.* High.

**19. `BanachSpaceTheory/LocalTheory`** — math.FA, L (≈250 PRs), wave B.

*Scope.* This roadmap develops the local and asymptotic theory of Banach spaces and metric fixed-point theory: finite representability and local reflexivity, type and cotype with Kahane–Khintchine, Kwapień and Maurey–Pisier, K-convexity, uniform convexity and smoothness, superreflexivity and martingale renormings, Dvoretzky's theorem, Banach–Mazur distance, absolutely summing operators and Grothendieck's inequality, asymptotic moduli and the Daugavet property, and the fixed-point theorems of Kirk, Goebel–Karlovitz and Darbo. John's ellipsoid comes from GEO and sphere concentration from PRDS.

*Objects.* finite representability; type, cotype; K-convexity; δ_X, ρ_X; d(X,Y); π_p; asymptotic moduli; normal structure; measure of noncompactness. *Milestones.* (1) Kahane–Khintchine; Kwapień; Maurey–Pisier; Pisier K-convexity; (2) Enflo and Pisier renormings; (3) Dvoretzky; Grothendieck; Pietsch; (4) Kirk; Goebel–Karlovitz; Darbo.

*Prerequisites.* BasesAndClassicalSpaces; Mathlib martingales; GEO ConvexBodies; PRDS ConcentrationAndFunctionalInequalities. *Goals.* OpenAI 6: #322, #326, #327, #328, #329, #331.

*Porting.* OAI Analysis/{Cotype, MarkovType, Nonexpansive, Daugavet, TreePotential, MetricEntropy}. *Formalizability.* High.

**20. `BanachSpaceTheory/NonlinearGeometry`** — math.FA, L (≈200 PRs), wave B.

*Scope.* This roadmap develops Banach spaces as metric spaces: Mankiewicz's theorem on top of Mathlib's Mazur–Ulam, Lipschitz extension (McShane, Kirszbraun, Ball), Lipschitz-free spaces with Godefroy–Kalton lifting and Aharoni's theorem, approximation properties of free spaces, Ribe and Heinrich–Mankiewicz, Bourgain's tree theorem, Johnson–Schechtman diamonds, Markov type and metric Markov cotype, metric cotype, and coarse embeddings. Finite metric embeddings as algorithmic tools are LTCS's MetricEmbeddings, which imports this roadmap; expanders are COMB's.

*Objects.* Lipschitz-free spaces F(M); distortion; Markov type, metric (Markov) cotype; diamond and tree graphs; coarse embeddings. *Milestones.* (1) Mankiewicz; Kirszbraun; Ball extension; (2) Godefroy–Kalton; Aharoni; (3) Ribe; Heinrich–Mankiewicz; (4) Bourgain trees; Johnson–Schechtman; (5) Naor–Peres–Schramm–Sheffield; Mendel–Naor stated.

*Prerequisites.* BasesAndClassicalSpaces; LocalTheory; PRDS MarkovChainsAndMixing; COMB ExpanderGraphs. *Goals.* OpenAI 5: #324, #327, #330, #331, #332.

*Porting.* OAI Analysis/{LipschitzEquivalence, LipschitzFree, C0Absorption, MarkovType, DiamondDistortion}. *Formalizability.* High.


## 4. Needs not absorbed

| need | refs | reason |
|---|---|---|
| O(n)/XY/Villain duality, transfer matrices, Peierls, reflection positivity, chessboard, infrared bounds, Mermin–Wagner | #215 ×3, #216, #225, #232, #237 | PRDS LatticeGibbsMeasures; QSS and QFT import reflection positivity |
| Planar Ising exact solution; six-vertex, Yang–Baxter, Bethe ansatz, BKW | #218, #223, #225, #233 | PRDS IntegrableLatticeModels (all consumers math.PR) |
| Popa deformation/rigidity, W*- and Margulis superrigidity | #286 | frontier; VN supplies bimodules and intertwining, ALG lattices |
| Classification of nuclear C*-algebras (Gabe, KK) | #301 | frontier; CStarRegularity states the theorem, KK excluded |
| Equivariant Z-stability theorems | #291 | frontier beyond CStarRegularity's definitions |
| Small cancellation; property (T), Kazhdan constants | #285, #292, #247 | ALG |
| Marcus–Spielman–Srivastava paving; expanders, Benjamini–Schramm limits | #300, #330 | COMB, PRDS; VN proves Kadison–Singer from paving |
| Forcing; mean dimension; complex cobordism | #323, #302 | LTCS; PRDS; TOP |
| Laplace–Beltrami spectrum on manifolds | Annals #86 | GEO, consuming UnboundedOperators |
| VOAs ↔ conformal nets; block RG, BKT, positive-T BEC, QMA gadgets | #280, #282, #215, #216, #267, #275 | frontier research inputs |
| Quantum circuits, nonlocal games, query complexity; relativity | #274, #277, #279, #283, #284; #260, #264 | LTCS QuantumComputation; GEO, ANA |

Nothing is left as "add to existing roadmap X" except the #126 OperatorIdeals extension (§2), which
UnboundedOperators absorbs if the author declines.

## 5. Cross-campaign interface

**Imports.** *ALG*: AmenabilityAndPropertyT → NUC, VN, L2 (the algebra report's AmenableGroupsAndGrowth is the same
concept; ALG should merge them); TemperleyLieb #58 → VN; tensor categories #57 and VOAs → QFT. *PRDS*: RandomMatrices
#397 → FP; ConcentrationAndFunctionalInequalities → FP, LocalTheory; ErgodicTheory → SLJ, RND; LatticeGibbsMeasures
(reflection positivity, chessboard, infrared bounds) → QSS, QFT; MarkovChainsAndMixing → NonlinearGeometry. *COMB*:
ExpanderGraphs (MSS interlacing) → VN, NonlinearGeometry. *TOP*: ClassifyingSpaces #437, cellular chains,
topological K-theory → L2, KT. *GEO*: ConvexBodies (John) → LocalTheory; Dirac operator on 𝕋² → KT. *ANA*: PDE,
distributions → SCH, QFT; ConformalMapping and any Hardy-space roadmap → NSA. *LTCS*: ShannonInformationTheory → QIT.

**Exports.** *NT*: UnboundedOperators (Friedrichs extension, essential spectrum) → Maass forms and
AutomorphicSpectralTheory (LMFDB `maass`, Annals #13); VN Layer 0 → AS.0; Stone–von Neumann → MP.1. *GEO*:
UnboundedOperators → SpectralGeometry (Annals #86, #336, #350, #361). *ANA*: SpectralTheory → Neumann problems
(#369), dispersive PDE; OperatorConvexity → #082. *PRDS*: FreeProbability (strong convergence) → random-matrix
work. *COMB*: Friedman's theorem → ExpanderGraphs (#174, #178); MUBs → #266. *LTCS*: QIT (channels, diamond norm)
→ QuantumComputation; BanachSpaceTheory (Lipschitz extension, Markov type, Grothendieck's inequality) →
MetricEmbeddings and convex relaxations (#089, #094, #098, #099, #307). *ALG*: L2Invariants → GroupRings (#196,
#197, #207). *TOP*: assembly maps → coarse geometry (#307); L²-Betti numbers → #315.

## 6. Order and people

**Prerequisite action:** get #126 reviewed and merged. It is a prerequisite of 10 of the 20 roadmaps, directly or
through UnboundedOperators; for the wave-A ones (VN, QIT, NSA, OCT) only of later layers.

**First five drafting units** (demand × unblocking):
1. **OperatorAlgebras tranche 1** (umbrella, VonNeumannAlgebras, NuclearCStarAlgebras): wave A, 16 OAI families
   and Annals #100; supplies the other five OperatorAlgebras sub-roadmaps and QSS, MB, QFT.
2. **SpectralTheory tranche 1** (umbrella, UnboundedOperators, SchrodingerOperators): Annals #92 and 7 OAI
   families; unblocks ManyBody, RandomSchrodinger and the NT, GEO, ANA consumers. Draft now, file when #126 merges.
3. **#126 extension** (OperatorConvexityAndTraceInequalities, NonselfadjointOperatorTheory): drafting can start
   now, filing waits for #126 unless they go top-level; OCT gates QIT's entropy layer and #262; NSA serves 4 families.
4. **QuantumTheory tranche 1** (umbrella, QuantumInformationTheory, QuantumSpinSystems): 8 OAI families plus LTCS's
   QuantumComputation.
5. **BanachSpaceTheory** (whole family): wave A; the 11 FA families plus #094, #098.

Then OperatorAlgebras tranche 2 (17 OAI families, 9 untouched by tranche 1, plus Annals #99), QuantumTheory tranche
2 (ManyBody, AxiomaticQFT), SpectralTheory tranche 2 (SturmLiouvilleAndJacobi, RandomSchrodinger).

**People.** Lead: an operator algebraist fluent in Mathlib's C*-API. Reviewers: operator algebras (II₁ and
C*-classification), Lieb-school mathematical physics, quantum spin systems and quantum information, Banach-space
geometry. First contacts: authors of the Mathlib files the slate builds on (Loreaux, CFC; Dupuis, CP maps, WOT,
Hilbert modules; Tanimoto, StandardSubspace; Bannon et al., Fredholm), the #126 author, Lean-QuantumInfo and PhysLean.

**Open questions for the owner.**
- **Q1.** Strong convergence: the Annals report filed it as math.PR; BOUNDARIES gives free probability to FAMP and
  #397 excludes it, so this slate puts it in FreeProbability. PRDS should not plan StrongConvergenceOfRandomMatrices.
- **Q2.** Exactly solved models, lattice and continuum Gibbs systems go to PRDS by the Gibbs-measure rule; nobody
  plans the quantum XXZ Bethe ansatz. Confirm.
- **Q3.** OperatorKTheory topic: math.OA (secondary math.KT) inside the family, though the needs rows say math.KT.
- **Q4.** NT's AS.0 and MP.1 build generic FAMP material; rule 3 says they consume FAMP. Needs a hub ruling and
  Chris Birkbeck's agreement.
- **Q5.** Fredholm determinants: #397 M8 and UnboundedOperators (or an OperatorIdeals extension) both need them;
  fix one owner first.
- **Q6.** Family PRs run 250–600 KB of README. Review in two tranches, or tranche 2 as follow-up PRs into the family?

## 7. Totals

| | roadmaps | L | M | est. PRs |
|---|---:|---:|---:|---:|
| OperatorAlgebras | 7 | 6 | 1 | 1,570 |
| SpectralTheory | 4 | 2 | 2 | 710 |
| QuantumTheory | 4 | 4 | 0 | 930 |
| #126 extension | 2 | 1 | 1 | 320 |
| BanachSpaceTheory | 3 | 3 | 0 | 670 |
| **total** | **20** | **16** | **4** | **≈4,200** |

Waves A 6, B 11, C 3 (RandomSchrodinger, ManyBody, AxiomaticQFT); five review units. Existing supply in the
territory: ≈860 PR-equivalents, almost all #126 (≈830 target items, partly ported code) plus #397 M6 (≈30);
OneParameterSemigroups is finished. New surface is about five times present supply.
