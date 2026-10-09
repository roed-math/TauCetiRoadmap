# Annals definitions #52–#100: owners and proposed roadmaps

Source: `/Users/roed/claude/handoffs/definitions_100_tauceti.md`, entries #52–#100, with their Mathlib
status at `7d32461ad2` and Tau Ceti code status at `1b4794c`. Supply read on 2026-10-07: TauCetiRoadmap
`upstream/main` at `b4f19703`; open PR heads `upstream-pr/<N>`; the Birkbeck campaign (Sept 2026
explorer); Tau Ceti code at `a91d3aafa`; Mathlib at `6b7abb3c`. A code grep at `a91d3aafa` found nothing
for these 49 concepts beyond what the source file lists.

**Coverage levels.** *Nearly full*: an existing roadmap targets the concept and nearly all of its sample
API. *Partial*: a roadmap or the code owns a special case, the foundation, or part of the API; the row
says which. *None*: nothing beyond Mathlib ingredients. "Code" means Tau Ceti declarations, (B) marks a
Birkbeck campaign roadmap, and "A #n" is a definition in the companion report on #1–51.

**Tally.** Nearly full: 2 (#58, #90). Partial: 28. None: 19 (#53, 56, 57, 68, 70, 71, 76, 81, 82, 84,
85, 87, 88, 89, 94, 96, 97, 98, 100). No entry is fully owned. §2 proposes 47 new roadmaps, plus a new
layer of DGAInfinity and a generalization of #196 Layer 5.

## 1. Ownership table

| # | Definition | Owners and coverage | Proposed |
|---:|---|---|---|
| 52 | Hecke algebra of a reductive p-adic group | **Partial.** SmoothRepresentationsOfLocalGroups (B) SR.1 (H(G,K) over rings, e_U, smooth ≃ nondegenerate modules), SR.4 (Satake, unramified G, hyperspecial K); ReductiveGroupsPartII (B) RG2.3–2.4 (parahorics, Iwahori–Bruhat); AutomorphicFormsOnReductiveGroups (B) AF.3/AF.5 (Hecke operators on automorphic forms). Code: `IntegralHeckeRing` (GL_n/ℚ). Missing: Iwahori–Hecke algebra, its Bernstein presentation and centre, non-commutativity (API 5). | HeckeAlgebrasOfCoxeterGroups |
| 53 | Springer correspondence, nilpotent orbits | **None.** Code has only the sl₂-triple API. AdoIwasawa avoids Jacobson–Morozov. EndoscopicTransfer (B) ET.2b has *affine* Springer fibres, a different object. | NilpotentOrbitsAndSpringerTheory |
| 54 | Deligne–Lusztig varieties, Green functions | **Partial (one case).** CharacterTheory L9 and code (`GL2CuspidalVirtualCharacter`): the GL₂(𝔽_q) table by classical methods (API 1). Inputs: ChevalleyGroups (#447) for G(𝔽_q) and Steinberg maps; #196 for compactly supported ℓ-adic cohomology and the trace formula. No DL varieties, R_T^θ or Green functions. | RepresentationsOfFiniteGroupsOfLieType |
| 55 | Affine Grassmannian, loop group | **Partial (different setting).** GeometricSatakeAndFusion (B) GS0: B_dR/Witt-vector Grassmannians as v-sheaves, Schubert cells. EndoscopicTransfer (B) ET.2b: equal-characteristic affine Grassmannians and affine Springer fibres. No ind-schemes over a field, lattice model, ind-projectivity, central extension or MV Satake. | AffineGrassmannians |
| 56 | Affine Kac–Moody algebra, critical level | **None.** RepresentationTheory excludes "affine or general Kac-Moody theory"; code has affine Dynkin types only. | AffineLieAlgebras |
| 57 | Brauer p-block, defect group, height | **None.** RepresentationTheory puts "Brauer characters, decomposition matrices, blocks with defect" out of scope everywhere. Code has semisimple central idempotents only. | ModularRepresentationTheory |
| 58 | Hochschild cohomology, A∞/DG categories | **Nearly full.** DGAInfinity (main): L1–2 DG/A∞ categories and modules; L5 pretriangulated envelope; L8 Hochschild chains/cochains, braces, Gerstenhaber bracket, HH²/HH³; L9 Serre/CY. Code: `DGCategory`, `AInfinityAlgebra`. RefinedTraceMethods (B) RT.1: HH_* with HKR. Missing: HKR for HH^* (API 2), DG enhancements and the non-enhanceable example (API 5), semi-orthogonal decompositions. | DGAInfinity (new layer) |
| 59 | Symmetric tensor category, fiber functor | **Partial.** ReductiveGroups L1 (Tannakian reconstruction; code `fgPointTensorIsoEquiv`); PivotalSpherical (#57) L6 (FPdim for fusion categories in characteristic 0); MotivesAndAlgebraicCycles (B) MC.6 (neutral Tannakian categories). No pre-Tannakian categories, sVec, Deligne's theorem, Ver_p or Rep(GL_t). | SymmetricTensorCategories |
| 60 | Supercuspidal representation, BK type | **Partial.** SmoothRepresentationsOfLocalGroups (B) SR.2–SR.3 (Jacquet functors, supercuspidality, Bernstein decomposition and centre); EndoscopicTransfer (B) ET.6 (types and segments for GL_m); GL2AutomorphicRepresentations (B) R16.2 (explicit GL₂). No Moy–Prasad filtrations, depth-zero types, covers for general G, or Yu's construction. | TypesAndSupercuspidalRepresentations |
| 61 | Vertex operator algebra | **Partial (one stage).** QSeriesPartitionsAndMockModularForms (B) QM.6 takes the moonshine VOA as "owned constructions within this stage" (specification only). | VertexAlgebras |
| 62 | Curvature tensors | **Partial (main objects in code).** Code: `curvatureTensor`, `sectionalCurvature`, `ricciTensor`, `scalarCurvature`. Owner: GeometricTopology L7, on HopfRinow L1's Levi-Civita connection (HopfRinow is being archived, #723). Missing: curvature-bound predicates, model spaces (API 1), Bishop–Gromov (API 5). | ComparisonGeometry |
| 63 | Hyperbolic manifold, limit set, convex cocompactness | **Partial.** Code: `HyperbolicMetric`, `IsHyperbolic`. GeometricTopology L7 (hyperbolic structures, volume, Mostow target); KleinianGroups (#432) L0–2 (ℍ³, discrete groups, covolume); FuchsianOrbifolds (ℍ²). Missing: ℍⁿ, Isom(ℍⁿ) ≅ PO(n,1), limit sets, convex cores, geometric finiteness, totally geodesic submanifolds. | HyperbolicManifolds |
| 64 | Kähler manifold, Kähler–Einstein metric | **Partial (code only).** Code: compatible triples (`AlmostComplexStructure`). ComplexManifolds (#279) supplies holomorphic bundles. No roadmap owns the Kähler condition, potentials, psh functions, the Ricci form, or KE metrics. | KahlerGeometry; CalabiYauAndComplexMongeAmpere |
| 65 | Lattice in a semisimple Lie group | **Partial.** FuchsianOrbifolds (PSL(2,ℝ); code `IsCofinite`); KleinianGroups (#432) L1 (PSL(2,ℂ)); AdelicAlgebraicGroups (B) AA.3 (Siegel sets, finite volume, compactness for anisotropic G); ArithmeticLocallySymmetricSpaces (B) ALS.0. Missing: general lattice API, SL_n(ℤ) via Mahler, Borel density, Margulis lemma, statements of arithmeticity and the normal subgroup theorem. | LatticesInSemisimpleGroups |
| 66 | Gromov–Witten invariants, quantum cohomology | **Partial (inputs only).** StableReduction L10–11: stable maps, explicitly no moduli object ("Those are the next roadmap"). HeegaardFloer F2: genus-0 fixed-domain J-curves, "no Deligne–Mumford". | ModuliOfStableMaps → GromovWittenTheory; PseudoholomorphicCurveModuli |
| 67 | Local system, monodromy | **Partial (main object in code).** Code: `LocalCoefficientSystem`, `monodromyRepresentation`, `twistedCohomology`. #196 ComplexComparison L5: locally constant sheaves of *finite* Λ-modules ≃ π₁-actions. AlgebraicTopology Stages 5–6; DGFloer (#655) L3 (DG local systems). Missing: arbitrary coefficients, ℓ-adic lisse sheaves, Katz rigidity (API 3–4). | generalize #196 L5; CharacterVarietiesAndRigidLocalSystems |
| 68 | Second fundamental form, minimal submanifold stability | **None.** | MinimalSubmanifolds |
| 69 | Symplectic manifold, Ham(M,ω) | **Partial.** Code: `IsSymplectic`. HamiltonianSystems (#480) L1–3 (X_H, Poisson bracket, symplectomorphisms, moment maps); HeegaardFloer F2.1 (Darboux, Moser); DGFloer (#655) L6 (T*Q, Liouville domains, HZ capacity). Missing: Symp and Ham as groups, monotonicity, capacity axioms, non-squeezing (API 4). | SymplecticRigidity |
| 70 | Amenability, property (T) | **None.** Mathlib has `IsFoelner.amenable` (measure-space actions). PointProcesses (#417) defers Følner sequences and amenable groups to "an ergodic-theory roadmap" that does not exist. | AmenabilityAndPropertyT |
| 71 | Integral current, set of finite perimeter | **None.** Mathlib: BV on ℝ, Hausdorff measure. | GeometricMeasureTheory |
| 72 | Teichmüller space, mapping class group | **Partial.** SurfaceTopology (#271) L9 (mapping class groups, Dehn twists, Dehn–Lickorish); code diffeomorphism groups (GeometricTopology L3). FuchsianOrbifolds excludes Teichmüller theory. | TeichmullerTheory |
| 73 | Hamiltonian Floer homology, spectral invariants | **Partial.** DGFloer (#655) L7 on HeegaardFloer F0–F2: Floer complex for closed aspherical manifolds, action filtration, FH ≅ H, SH of Liouville domains. Missing: PSS, spectral invariants, spectral norm, monotone case. | SymplecticRigidity; PseudoholomorphicCurveModuli |
| 74 | Knot concordance, sliceness, knot homologies | **Partial (main object in code).** Code: `IsSmoothlySlice`, `Concordance`, grid homology for one diagram. GeometricTopology L4 (Jones polynomial), L6 (concordance group, topological slice, Tristram–Levine); CombinatorialHeegaardFloer Lane G (grid invariance, τ). Missing: Khovanov homology and Rasmussen's s, which GT L6 expects from CombinatorialHF, which does not build them. | KhovanovHomology |
| 75 | Pointed GH limits, tangent cones, singular strata | **Partial (thin).** Mathlib: GH for compact spaces. OptimalTransport L14: Sturm's D, CD/RCD stability. Missing: pointed/measured GH, Gromov precompactness, tangent cones, strata. | ComparisonGeometry |
| 76 | Calabi–Yau manifold | **None.** | CalabiYauAndComplexMongeAmpere |
| 77 | Locally symmetric space, arithmetic quotient | **Partial.** ArithmeticLocallySymmetricSpaces (B) ALS.0–3 (G/K, components of X_K, Borel–Serre, Hecke action); LieGroups L9 (Cartan/Iwasawa/KAK); FuchsianOrbifolds and code (Γ\ℍ). Missing: Riemannian geometry of G/K (curvature, rank, flats), thick–thin for non-arithmetic lattices. | LatticesInSemisimpleGroups |
| 78 | Ring spectra, chromatic localization, motivic SH | **Partial (foundation).** StableHomotopyKTheory (B) H.5 (spectra, stable homotopy category, smash product); EnhancedDerivedSheaves (B) E5; RefinedTraceMethods (B) RT.2 (THH); HomotopySpheres (#284) (stable stems through π₆^S). Missing: MU, Quillen's theorem, BP⟨n⟩, K(n), Bousfield localization, SH(k). | ChromaticHomotopyTheory; MotivicHomotopyTheory |
| 79 | Connection on a principal bundle, gauge equivalence | **Partial (code only).** Code: curvature of vector-bundle connections, with Bianchi. #334 §10 builds Lie-algebra-valued forms and leaves connection forms downstream. | ConnectionsAndCharacteristicClasses |
| 80 | Contact structure, Legendrian, Reeb flow | **Partial (thin).** Code: `standardContactDistribution`. CombinatorialHeegaardFloer Lane G item 11 (Legendrian grid invariants); DGFloer L6 (contact-type hypersurfaces). | ContactGeometry |
| 81 | Mean curvature flow, Ricci flow | **None.** | GeometricFlows |
| 82 | Quasi-isometry, growth of groups | **Partial (Mathlib).** Mathlib `Geometry/Group/WordMetric.lean`, `Growth/`. No roadmap. | GeometricGroupTheory |
| 83 | Pseudoholomorphic curve, moduli space | **Partial.** Code: `IsPseudoholomorphic`, energy. HeegaardFloer F0–F2: Fredholm theory, Sard–Smale, compactness and gluing for genus-0 disks, strips and spheres; "no varying-domain stable maps", no virtual techniques. Missing: closed curves of any genus, the c₁ index formula (API 2), virtual classes. | PseudoholomorphicCurveModuli |
| 84 | Uniform rectifiability, Jones β-numbers | **None.** | QuantitativeRectifiability |
| 85 | Varifold, first variation | **None.** | GeometricMeasureTheory |
| 86 | Laplace eigenvalues, spectral gap | **Partial.** Code: `IsDirichletEigenvalue`. PDE Lane D item 19 (Dirichlet spectrum on Ω ⊂ ℝⁿ); DifferentialGeometry L12 (Laplace–Beltrami, Green); Mathlib `SimpleGraph.lapMatrix`. Missing: manifold spectrum, Neumann, Weyl's law, nodal sets, Cheeger. | SpectralGeometry; EllipticOperatorsOnManifolds |
| 87 | Lorentzian spacetime, Einstein equations | **None.** | LorentzianGeometry; EinsteinEvolutionEquations |
| 88 | Compressible Euler, shocks, Riemann problem | **None.** | HyperbolicConservationLaws; ConvexIntegration |
| 89 | Fourier restriction, decoupling | **None.** PDE Lane B supplies inputs (maximal function, interpolation, CZ theory). | FourierRestrictionAndDecoupling |
| 90 | Leray–Hopf solutions of Navier–Stokes | **Nearly full.** IncompressibleFlows (#237) L5–7 (Leray–Hopf, energy inequality), L9 (weak–strong uniqueness), L11 (suitable solutions, CKN). It excludes non-uniqueness and convex integration (API 4–5). | ConvexIntegration |
| 91 | Monge–Ampère, Alexandrov and viscosity solutions | **Partial (real case full).** OptimalTransport L6: Aleksandrov measure, Aleksandrov–viscosity bridge, Dirichlet and second boundary problems, Caffarelli theory and counterexamples, MTW. Missing: complex Monge–Ampère. | CalabiYauAndComplexMongeAmpere |
| 92 | Schrödinger operator, a.c. spectrum, Bloch–Floquet | **Partial (foundation).** OperatorTheory (#126) SelfAdjointSpectralTheory: PVMs, unbounded self-adjoint operators, Kato–Rellich, Stone. Code: Herglotz functions. Missing: −Δ+V, spectral types, Floquet–Bloch, m-functions. | SchrodingerOperators |
| 93 | Lyapunov exponents, Pesin theory | **Partial (code, tangential).** Code: local stable manifolds of hyperbolic ODE equilibria. | NonuniformHyperbolicity |
| 94 | Expander graph, spectral gap of a graph | **None.** Mathlib adjacency/Laplacian matrices; SpectralQuantumWalks (#258) has no expansion. | ExpanderGraphs |
| 95 | Unipotent flows, equidistribution | **Partial (one sentence).** GeometryOfNumbersAndQuadraticArithmetic (B) GN.4 schedules "unipotent-flow and nondivergence proofs"; ProbabilisticAndMetricNumberTheory (B) PM.2 (Weyl equidistribution). | HomogeneousDynamics |
| 96 | KS entropy, equilibrium states, transfer operators | **None.** Mathlib: topological entropy, Birkhoff. | EntropyAndThermodynamicFormalism |
| 97 | Gibbs measure, DLR equations | **None.** PointProcesses (#417) excludes infinite-volume Gibbs processes. | GibbsMeasuresAndSpinSystems |
| 98 | Borel reducibility, Borel completeness | **None.** InfinitaryLogic (#41) supplies Scott analysis and excludes invariant descriptive set theory. | InvariantDescriptiveSetTheory |
| 99 | Free probability, strong convergence | **Partial.** RandomMatrices (#397) M6 (NC probability, freeness, free cumulants and convolution, asymptotic freeness in moments), M4 (Bai–Yin). It excludes strong asymptotic freeness; no L(F_d). | StrongConvergenceOfRandomMatrices |
| 100 | II₁ factor, L(Γ), amenable traces | **None.** Mathlib `VonNeumannAlgebra`; #126 for bounded operators. | VonNeumannAlgebrasAndII1Factors |

## 2. Proposed roadmaps

Each entry gives category (secondaries), size, what it delivers, prerequisites, tier, then a scope
paragraph. Tier **0** can start on main and Mathlib; tier **1** waits for one open PR or one tier-0
proposal; tiers **2** and **3** are deeper (§2.7).

**Extensions, not new roadmaps.** *DGAInfinity, new layer* (#58): HKR for HH^* of smooth algebras over a
ℚ-algebra; DG enhancements, with the Lunts–Orlov uniqueness statement and the Rizzardo–Van den
Bergh–Neeman counterexample; semi-orthogonal decompositions. *#196 ComplexComparison L5* (#67): state the
locally-constant-sheaf ≃ π₁-representation equivalence for arbitrary coefficient rings and compare it
with `LocalCoefficientSystem`.

### 2.1 Algebra and representation theory

**P1 HeckeAlgebrasOfCoxeterGroups.** math.RT (math.CO, math.NT). L. Delivers #52 (Iwahori part); feeds #54, #60. Prereqs: Mathlib `CoxeterSystem`, code Tits systems, ReductiveGroupsPartII (B) RG2.4, SR.1 (B). Tier 0.
This roadmap develops Iwahori–Hecke algebras of Coxeter systems with unequal parameters: the T_w basis,
the Kazhdan–Lusztig basis and polynomials, and specializations. For affine Weyl groups it proves the
Iwahori–Matsumoto and Bernstein presentations and Z ≅ ℤ[X]^W. It identifies them with H(G, I) for an
Iwahori subgroup of a split p-adic group, which is not commutative, and with End_G(Ind_B^G 1) for a
finite BN-pair.

**P2 RepresentationsOfFiniteGroupsOfLieType.** math.RT (math.GR, math.AG). XL; splits into a Harish-Chandra half and a Deligne–Lusztig half. Delivers #54; feeds #60, #57. Prereqs: ChevalleyGroups (#447), ReductiveGroups, CharacterTheory, InductionRestriction, P1, #196. Tier 2.
This roadmap follows Digne–Michel. It covers Lang–Steinberg, F-stable tori classified by F-conjugacy in
W, Harish-Chandra induction, cuspidal representations and Howlett–Lehrer algebras. It then constructs
Deligne–Lusztig varieties and their ℓ-adic cohomology, R_T^θ with its character and orthogonality
formulas, Green functions with Q_T(1) = |G^F|_{p'}/|T^F|, exhaustion and the Steinberg character. It
recovers the GL₂(𝔽_q) table of CharacterTheory L9.

**P3 NilpotentOrbitsAndSpringerTheory.** math.RT (math.AG). L–XL. Delivers #53. Prereqs: ReductiveGroups, LieHighestWeight, #196, A #41 (perverse sheaves, decomposition theorem), A #42. Tier 3.
This roadmap covers the nilpotent cone and Jacobson–Morozov–Kostant theory. It classifies orbits by
weighted Dynkin diagrams and by partitions for gl_n and the classical types, with the closure order and
dimension formulas. It constructs the Springer resolution T*(G/B) → 𝒩, Springer fibres and the W-action
on their cohomology. It proves the Springer correspondence combinatorially for gl_n, and in general via
the decomposition theorem.

**P4 AffineGrassmannians.** math.AG (math.RT). XL. Delivers #55. Prereqs: ReductiveGroups, AlgebraicVectorBundles, RG2.3–2.4 (B), A #6 (ind-schemes, stacks), A #41 and A #26 for Satake. Tier 2.
This roadmap covers ind-schemes, the loop groups LG and L⁺G, and Beauville–Laszlo gluing. It proves that
Gr_G is ind-projective, with the lattice model for GL_n and π₀(Gr_G) = π₁(G). It constructs Schubert
varieties of dimension ⟨2ρ,λ⟩, the affine flag variety, and the determinant line bundle with the central
extension. Its summit is the Mirković–Vilonen Satake equivalence. ET.2b (B) consumes it and GS0 (B)
compares with it.

**P5 AffineLieAlgebras.** math.RT (math.QA). L. Delivers #56; feeds #61. Prereqs: RootSystems, LieHighestWeight, code `AffineDynkinType`. Tier 0.
This roadmap covers Kac–Moody algebras of generalized Cartan matrices, their real and imaginary roots and
Weyl groups, and the loop model ĝ_κ with its cocycle κ(x,y)Res(f dg). It covers levels, vacuum and
smooth modules, integrable modules, the Weyl–Kac and Macdonald identities, Sugawara and Virasoro. It
proves the scalar-versus-large dichotomy of the centre at the critical level, and states Feigin–Frenkel.

**P6 ModularRepresentationTheory.** math.RT (math.GR). L–XL. Delivers #57. Prereqs: SemisimpleAlgebras, CharacterTheory, ModularInduction, QuiverRepresentations L3. Tier 0.
This roadmap works over a p-modular system. It covers blocks of 𝒪G and kG, Brauer characters, the
decomposition and Cartan matrices, Higman's criterion, vertices and Green correspondence, defect groups,
Brauer's three main theorems, heights and Brauer's divisibility, and defect-zero blocks. It computes all
blocks of S₃, S₄ and A₅. Height zero and Alperin–McKay are stated.

**P7 SymmetricTensorCategories.** math.RT (math.CT, math.QA). L. Delivers #59. Prereqs: Mathlib monoidal categories, ReductiveGroups L1, PivotalSpherical (#57). Tier 1.
This roadmap covers pre-Tannakian categories, fiber functors to Vec and sVec, and supergroups with
super-Tannakian reconstruction. It covers moderate growth, FP dimension, Deligne's categories Rep(S_t) and
Rep(GL_t), and Ver_p via SL₂ tilting modules. It proves Deligne's characteristic-0 theorem and that Ver_p
has no fiber functor to sVec. The theorems of Ostrik and of Coulembier–Etingof–Ostrik are stated.

**P8 TypesAndSupercuspidalRepresentations.** math.RT (math.NT). XL. Delivers #60. Prereqs: SR.0–SR.3 (B), RG2.1–2.3 (B), P1, P2. Tier 3.
This roadmap covers Moy–Prasad filtrations, depth and unrefined minimal K-types. It constructs depth-zero
supercuspidals from cuspidal representations of parahoric quotients, Bushnell–Kutzko types and covers
with the Hecke-algebra criterion, simple types for GL_n, and Yu's construction. The exhaustion theorems of
Kim and Fintzen are stated with their residue-characteristic hypotheses.

**P9 VertexAlgebras.** math.QA (math.RT). XL. Delivers #61. Prereqs: P5, IntegralLattices (completed), Rank24LatticeConstructions (#219), ModularForms. Tier 2.
This roadmap covers locality, the Borcherds identity, reconstruction, and conformal vectors with the
Virasoro relations. It covers modules, the Lie algebra V₁, affine, Heisenberg and lattice VOAs (central
charge rank L), holomorphic VOAs and the cyclic orbifold. It proves that V_Leech is holomorphic with
dim V₁ = 24 (its V₁ is the rank-24 Heisenberg algebra), and states Zhu's modularity theorem.

### 2.2 Riemannian, Kähler and Lie-group geometry

**P10 ComparisonGeometry.** math.DG (math.MG). L–XL. Delivers #62 (bounds, model spaces, Bishop–Gromov) and #75. Prereqs: HopfRinow, GeometricTopology L7, code curvature, Mathlib GH. Tier 0.
This roadmap covers model spaces, Jacobi fields and second variation. It proves Rauch, Hessian and
Laplacian comparison, Bishop–Gromov, Myers, Cartan–Hadamard, Toponogov and Cheeger–Gromoll splitting. It
develops pointed and measured GH convergence, Gromov precompactness, tangent cones and the strata S_k with
dim S_k ≤ k. Cheeger–Colding codimension two is stated.

**P11 HyperbolicManifolds.** math.GT (math.DG, math.GR). L. Delivers #63. Prereqs: GeometricTopology L7, KleinianGroups (#432), FuchsianOrbifolds, P10. Tier 1.
This roadmap covers the models of ℍⁿ, Isom(ℍⁿ) ≅ PO(n,1) and ∂ℍⁿ. For discrete groups it covers limit
sets, convex cores, convex cocompactness, geometric finiteness and Schottky groups. It proves the
Margulis lemma with thick–thin, treats totally geodesic submanifolds and ℍⁿ/Γ, and supplies the proof of
the Mostow rigidity that GeometricTopology L7 states.

**P12 KahlerGeometry.** math.DG (math.CV, math.AG). L. Delivers #64, except existence of KE metrics. Prereqs: ComplexManifolds (#279), DifferentialGeometry and #334, P27, P32, HodgeStructures. Tier 2.
This roadmap covers Hermitian metrics and the Kähler condition, proving its equivalence with ∇J = 0 and
with local potentials. It covers psh functions, Fubini–Study, the Ricci form representing 2πc₁, and the KE
and cscK conditions. It proves the Kähler identities, the Hodge decomposition and the ∂∂̄-lemma. The
Kodaira–Thurston manifold is the non-Kähler example.

**P13 CalabiYauAndComplexMongeAmpere.** math.DG (math.AP, math.CV). L. Delivers #76, the complex part of #91, and KE existence for #64. Prereqs: P12, OptimalTransport L6, PDE Lane E, A #7. Tier 3.
This roadmap covers (ω + i∂∂̄φ)^n, Kołodziej's L^∞ bound, Yau's estimates and the continuity method. It
proves the Calabi–Yau and Aubin–Yau theorems, and relates trivial K_X, c₁ = 0 and Ricci-flatness. Its
examples are elliptic curves, K3 surfaces and the quintic. The Bogomolov decomposition and the Fano case
via A #39 are stated.

**P14 LatticesInSemisimpleGroups.** math.GR (math.DG, math.NT). XL. Delivers #65 and the Riemannian side of #77. Prereqs: LieGroups L9, ReductiveGroups, FuchsianOrbifolds, KleinianGroups (#432), AA.3 (B), P10, P21. Tier 1.
This roadmap follows Witte Morris and Raghunathan. It covers lattices and covolume, Mahler's criterion,
Siegel sets for SL_n(ℤ), arithmetic groups, the real Borel–Harish-Chandra theorem (from AA.3), Borel
density, and the Margulis lemma. For G/K it covers non-positive curvature, rank, flats and the rank-one
list. Superrigidity, arithmeticity and the normal subgroup theorem are stated.

**P15 ModuliOfStableMaps.** math.AG. L. Delivers the moduli input to #66. Prereqs: StableReduction, A #6, A #9. Tier 2.
This roadmap is the successor that StableReduction's boundary section names. It constructs the moduli of
n-pointed genus-g stable maps of class β to a projective scheme. It proves this is a proper DM stack with
projective coarse space, and builds the evaluation, forgetful, stabilization and gluing maps. Smoothness
of M̄_{0,n}(ℙ^r,d) is an acceptance test.

**P16 GromovWittenTheory.** math.AG (math.SG). XL. Delivers #66. Prereqs: P15, A #33, cotangent complex. Tier 3.
This roadmap covers Behrend–Fantechi obstruction theories and the virtual class. It defines GW invariants
with the Kontsevich–Manin axioms, the Novikov ring, small and big QH with WDVV, and quantum K-theory.
Acceptance tests are QH(ℙⁿ) = ℤ[h,q]/(h^{n+1} − q), Kontsevich's count of rational plane curves, and
degree-0 invariants equal to classical intersections.

**P17 PseudoholomorphicCurveModuli.** math.SG (math.DG). XL. Delivers #83, the symplectic route to #66, and the PSS input for #73. Prereqs: HeegaardFloer F0–F2, P32, StableReduction. Tier 2.
This roadmap extends HeegaardFloer F0–F2 to closed J-curves of any genus in semipositive manifolds,
following McDuff–Salamon. It covers varying domains, the index (n−3)(2−2g) + 2c₁(A), transversality for
simple curves, Gromov compactness to stable maps, and pseudocycle GW invariants and QH. It shows that
transversality fails for multiple covers. Virtual techniques are out of scope.

**P18 CharacterVarietiesAndRigidLocalSystems.** math.AG (math.RT, math.AT). L. Delivers #67 (rigidity, Betti moduli). Prereqs: #196 L5 (generalized), QuiverRepresentations, A #25. Tier 2.
This roadmap covers representation and character varieties, and local systems on ℙ¹ minus points as
tuples with product 1. It proves Katz's rigidity criterion and builds middle convolution with Katz's
algorithm. It solves Deligne–Simpson via Crawley-Boevey's root criterion, and states the
Hausel–Rodriguez-Villegas E-polynomials.

**P19 MinimalSubmanifolds.** math.DG (math.AP). L. Delivers #68; feeds #81, #85. Prereqs: HopfRinow, code curvature, P32. Tier 1.
This roadmap covers the second fundamental form, mean curvature, the Gauss and Codazzi equations, first
and second variation, the Jacobi operator, stability, Morse index, Simons' identity and monotonicity. Its
examples are great spheres, the index-5 Clifford torus and the catenoid. It proves Bernstein's theorem for
n ≤ 7 and that the Simons cone is area-minimizing.

**P20 SymplecticRigidity.** math.SG. L–XL. Delivers #69, #73. Prereqs: HamiltonianSystems (#480), DGFloer (#655) L6–7, HeegaardFloer F2, P17. Tier 2.
This roadmap covers Symp, Symp₀ and Ham with flux, monotone manifolds, and the Hofer norm. It treats
capacities axiomatically and proves non-squeezing via J-spheres. It builds spectral invariants and the
spectral norm from the Floer action filtration, and proves the Arnold conjecture in the aspherical case.
The monotone case and PSS rest on P17. The Viterbo counterexample is a worked example.

**P21 AmenabilityAndPropertyT.** math.GR (math.FA, math.OA). L. Delivers #70; feeds #94, #95, #100 and #417's ergodic theorems. Prereqs: Mathlib `FoelnerFilter`, Haar measure, OperatorTheory (#126). Tier 0.
This roadmap follows Bekka–de la Harpe–Valette. It covers invariant means, the Følner and Reiter
conditions, Tarski's theorem, Kesten's criterion and the closure properties. It treats weak containment,
Kazhdan pairs and Delorme–Guichardet, and proves inheritance of (T) by lattices and (T) for SL₃(ℤ) (with
a sum-of-squares route). It proves that amenable plus (T) implies compact, and the amenable mean ergodic
theorem.

### 2.3 Topology, symplectic and contact geometry, GMT

**P22 GeometricMeasureTheory.** math.CA (math.AP, math.DG). XL. Delivers #71, #85; feeds #84. Prereqs: Mathlib Hausdorff measure, PDE Lane A. Tier 0.
This roadmap follows Federer, Simon and Maggi. It covers the area and coarea formulas, rectifiable sets,
BV in ℝⁿ, finite perimeter with De Giorgi's structure theorem, and the isoperimetric inequality. It treats
currents with mass, boundary and flat norm, Federer–Fleming compactness, varifolds, first variation,
monotonicity, and Allard regularity.

**P23 TeichmullerTheory.** math.GT (math.CV, math.DG). XL. Delivers #72. Prereqs: SurfaceTopology (#271), FuchsianOrbifolds, P11, ConformalMapping, ComplexManifolds (#279). Tier 2.
This roadmap covers Teich(S) via marked hyperbolic structures, Fenchel–Nielsen coordinates and the Fricke
theorem. It proves that Mod(S) acts properly discontinuously, with the torus case Teich = ℍ and Mod =
SL₂(ℤ). It covers quasiconformal maps and Teichmüller's theorems, quadratic differentials, the
Weil–Petersson metric and Nielsen–Thurston.

**P24 KhovanovHomology.** math.GT. L. Delivers #74 (Khovanov homology, s). Prereqs: GeometricTopology L4 and L6. Tier 0.
This roadmap builds the cube of resolutions and proves Reidemeister invariance and that the Euler
characteristic is the Jones polynomial of GT L4. It covers Bar-Natan's local theory, the Lee spectral
sequence, and Rasmussen's s with |s| ≤ 2g₄ and s(T_{p,q}) = (p−1)(q−1). It supplies the s that GT L6
imports.

**P25 ChromaticHomotopyTheory.** math.AT. XL. Delivers #78 (chromatic part). Prereqs: the spectra owner fixed in §3, E5 (B), Mathlib Lazard ring. Tier 2.
This roadmap covers E_n ring spectra, Thom spectra, MU and Quillen's theorem, BP and BP⟨n⟩, Landweber
exactness, Morava K(n), Bousfield localization and the chromatic tower. It computes π_*S through degree 7
with the Adams spectral sequence. Nilpotence, thick subcategories and the failure of the telescope
conjecture are stated.

**P26 MotivicHomotopyTheory.** math.AG (math.AT, math.KT). XL. Delivers #78 (motivic part). Prereqs: P25, A #35, A #33, A #14, MotivicEtaleKTheory (B). Tier 3.
This roadmap covers the Nisnevich site, 𝔸¹-localization and SH(k), the spectra KGL, MGL and motivic
cohomology, the six operations on SH(−), and the Chow t-structure.

**P27 ConnectionsAndCharacteristicClasses.** math.DG. L. Delivers #79; feeds #64, #76. Prereqs: DifferentialGeometry, #334, LieGroups. Tier 1.
This roadmap follows Tu. It covers principal bundles, connection 1-forms, curvature with Bianchi, the
gauge group action, holonomy and flat connections, and the Chern–Weil homomorphism with Chern, Pontryagin
and Euler classes. It computes the Hopf bundle's Euler number and covers the Yang–Mills equations.

**P28 ContactGeometry.** math.SG (math.GT). L. Delivers #80. Prereqs: DifferentialGeometry, HamiltonianSystems (#480). Tier 1.
This roadmap covers contact forms, Reeb flows, the contact Darboux and Gray theorems, symplectization and
the standard structures. For Legendrian knots it covers fronts, tb and rot, and Bennequin's inequality. It
covers overtwisted discs and Weinstein, Stein and exact Lagrangian fillings.

**P29 GeometricFlows.** math.DG (math.AP). XL, with an MCF lane and a Ricci-flow lane. Delivers #81. Prereqs: P19, P10, P32, PDE Lane F. Tier 3.
This roadmap covers short-time existence via DeTurck, evolution of curvature, maximum principles and
avoidance. It covers shrinkers, translators and Huisken monotonicity, and proves Huisken's convex theorem
and Hamilton's Ric > 0 theorem in dimension 3. It treats ancient solutions and Perelman's entropy with no
local collapsing.

**P30 GeometricGroupTheory.** math.GR (math.MG). L. Delivers #82. Prereqs: Mathlib `WordMetric` and `Growth`, P21. Tier 0.
This roadmap covers Cayley graphs, quasi-isometries and Švarc–Milnor, growth types including Grigorchuk's
group and Milnor–Wolf, hyperbolic groups, Dehn functions and compression. It proves QI invariance of
these properties and of amenability. Gromov's polynomial growth theorem is the summit (Kleiner route).

**P31 QuantitativeRectifiability.** math.CA (math.MG). L. Delivers #84. Prereqs: P22, PDE Lane B. Tier 1.
This roadmap covers Ahlfors regularity, β-numbers, the travelling salesman theorem, Menger curvature, and
big pieces of Lipschitz images. It proves that uniform rectifiability is equivalent to the Carleson β²
condition, with the four-corner Cantor set as counterexample. The Riesz-transform characterization
(David–Semmes, Nazarov–Tolsa–Volberg) is stated.

### 2.4 Analysis and PDE

**P32 EllipticOperatorsOnManifolds.** math.AP (math.DG). L–XL. Substrate for #86, #64, #68, #79, #81, #83. Prereqs: PDE Lanes A and E, DifferentialGeometry. Tier 0.
This roadmap covers Sobolev spaces of sections with Rellich, principal symbols, Gårding and elliptic
regularity, and the Fredholm property. It proves that self-adjoint elliptic operators have discrete
spectrum, proves the Hodge theorem, constructs the Laplace–Beltrami heat kernel, and treats Dirichlet and
Neumann problems.

**P33 SpectralGeometry.** math.SP (math.DG). L. Delivers #86. Prereqs: P32, P10, DifferentialGeometry L12, P41. Tier 2.
This roadmap covers Dirichlet and Neumann spectra, min–max, and explicit spectra. It proves Weyl's law,
Courant's nodal theorem, Cheeger and Buser, Lichnerowicz, Li–Yau and Faber–Krahn, and Milnor's
isospectral tori. It treats hyperbolic surfaces, with Selberg's 3/16 stated.

**P34 LorentzianGeometry.** math.DG (math.MP). L. Delivers #87 (causal part). Prereqs: DifferentialGeometry; an indefinite-metric connection, which HopfRinow does not build; P19. Tier 1.
This roadmap follows O'Neill and Hawking–Ellis. It covers causal futures and the causal ladder, and
proves Geroch splitting with Cauchy surfaces. It covers the Minkowski, Schwarzschild and Kerr spacetimes,
null expansions, trapped surfaces, null infinity and event horizons, and proves the Penrose singularity
theorem.

**P35 EinsteinEvolutionEquations.** math.AP (math.DG, math.MP). XL. Delivers #87 (Einstein part). Prereqs: P34, P36. Tier 2.
This roadmap covers the vacuum and scalar-field equations, the constraints, wave coordinates and
quasilinear wave theory. It proves Choquet-Bruhat local existence, the Choquet-Bruhat–Geroch maximal
development and Birkhoff's theorem. Minkowski stability, cosmic censorship and naked singularities are
stated.

**P36 HyperbolicConservationLaws.** math.AP (math.MP). L. Delivers #88. Prereqs: PDE Lane A. Tier 1.
This roadmap covers weak solutions, Rankine–Hugoniot, Kružkov's theorem and Burgers. For systems it covers
Lax shocks and rarefactions, Lax's Riemann solver, symmetric hyperbolic well-posedness, and compressible
Euler with its acoustical metric. It proves Sideris's blow-up theorem.

**P37 FourierRestrictionAndDecoupling.** math.CA. L. Delivers #89. Prereqs: PDE Lane B, Mathlib Fourier. Tier 1.
This roadmap covers surface-measure decay, Stein–Tomas and Knapp, Littlewood–Paley square functions, wave
packets, Kakeya with Córdoba's planar bound, and multilinear Kakeya and restriction. It proves
Bourgain–Demeter decoupling for the paraboloid, and states the cone square-function implication to local
smoothing.

**P38 ConvexIntegration.** math.AP. L. Delivers #90 (API 4–5) and the non-uniqueness half of #88. Prereqs: IncompressibleFlows (#237), P36. Tier 2.
This roadmap covers the Tartar framework, De Lellis–Székelyhidi wild Euler solutions and Isett's Onsager
theorem. It proves Buckmaster–Vicol Navier–Stokes non-uniqueness and Chiodaroli–De Lellis–Kreml
compressible non-uniqueness. Albritton–Brué–Colombo is stated.

**P39 SchrodingerOperators.** math.SP (math.MP). L. Delivers #92. Prereqs: OperatorTheory (#126), code Herglotz. Tier 1.
This roadmap covers −Δ + V, the spectral types, RAGE and Weyl's criterion, Weyl–Titchmarsh m-functions,
Jacobi and transfer matrices, subordinacy, Floquet–Bloch bands and Wigner–von Neumann examples. Ten
Martini is stated.

### 2.5 Probability, dynamics and combinatorics

**P40 NonuniformHyperbolicity.** math.DS. L. Delivers #93. Prereqs: P43, Mathlib ergodic theory. Tier 2.
This roadmap covers Kingman, Furstenberg–Kesten and Oseledets, hyperbolic measures and Pesin sets, the
Pesin stable manifold theorem and absolute continuity. It proves Ruelle's inequality, Pesin's formula and
Katok's horseshoes.

**P41 ExpanderGraphs.** math.CO. L. Delivers #94; feeds #86 (graphs) and #99 (Friedman). Prereqs: Mathlib `SimpleGraph` spectra, #258, P21. Tier 0.
This roadmap covers Cheeger constants and both Cheeger inequalities, expander mixing and Alon–Boppana. It
covers Ramanujan graphs (LPS stated; Marcus–Spielman–Srivastava), explicit expanders, mixing times, and
high-dimensional expanders with Garland's method and trickle-down.

**P42 HomogeneousDynamics.** math.DS (math.GR, math.NT). L. Delivers #95. Prereqs: P14, P21, Mathlib quotient Haar measure. Tier 3.
This roadmap covers Mautner, Howe–Moore, and the geodesic and horocycle flows. It proves Furstenberg's
unique ergodicity, Dani's SL₂ classification, Dani–Margulis non-divergence, Ratner in the SL₂ case (stated
in general), and the Oppenheim conjecture.

**P43 EntropyAndThermodynamicFormalism.** math.DS. L. Delivers #96; feeds #93, #97. Prereqs: Mathlib ergodic theory and topological entropy. Tier 0.
This roadmap covers KS entropy, the generator theorem, Shannon–McMillan–Breiman and Abramov. It proves the
variational principle. It covers pressure and equilibrium states, subshifts of finite type, the
Ruelle–Perron–Frobenius theorem and Bowen's Gibbs measures.

**P44 GibbsMeasuresAndSpinSystems.** math.PR (math.MP). L. Delivers #97. Prereqs: Mathlib kernels, P43. Tier 0.
This roadmap follows Georgii. It covers specifications, DLR, the Gibbs simplex and Dobrushin uniqueness.
For Ising it proves 1-d uniqueness and the 2-d Peierls transition. It covers GKS and FKG, infinite-volume
limits, and the Griffiths–Pearce example.

### 2.6 Logic and operator algebras

**P45 InvariantDescriptiveSetTheory.** math.LO. L. Delivers #98. Prereqs: InfinitaryLogic (#41), Mathlib `StandardBorelSpace`. Tier 1.
This roadmap covers Polish group actions, Mod(L) and López-Escobar, Borel reducibility, E₀ with
Glimm–Effros/HKL, and Silver's dichotomy. It proves Borel completeness of graphs, linear orders and
fields, that isomorphism is non-Borel, and that abelian p-groups are not Borel complete. It builds the
Friedman–Stanley jump.

**P46 StrongConvergenceOfRandomMatrices.** math.PR (math.OA). L. Delivers #99 (strong convergence). Prereqs: RandomMatrices (#397) M2/M4/M6, P47, P41. Tier 2.
This roadmap covers C*_r(F_d) with Haagerup's inequality, and linearization. It proves
Haagerup–Thorbjørnsen, Collins–Male and Bordenave–Collins, covers the polynomial method of
Chen–Garza-Vargas–Tropp–van Handel, and proves Friedman's theorem.

**P47 VonNeumannAlgebrasAndII1Factors.** math.OA. L–XL. Delivers #100; feeds #99. Prereqs: Mathlib `VonNeumannAlgebra`, #126, P21. Tier 1.
This roadmap follows Anantharaman–Popa. It covers the bicommutant theorem, normal traces, Murray–von
Neumann comparison and types, L(Γ) with ICC, uniqueness of R, crossed products, amenable traces and
injectivity. It proves L(F₂) ≇ R, and states Connes' theorem and W*-superrigidity.

### 2.7 Dependency order of the proposals

- **Tier 0:** P1, P5, P6, P10, P21, P22, P24, P30, P32, P41, P43, P44.
- **Tier 1:** P7 (#57), P11 (#432), P14, P19, P27 (#334), P28 (#480), P31, P34, P36, P37, P39 (#126),
  P45 (#41), P47 (#126).
- **Tier 2:** P2 (#447, #196), P4, P9 (#219), P12 (#279), P15, P17, P18, P20 (#655), P23 (#271), P25,
  P33, P35, P38 (#237), P40, P46 (#397).
- **Tier 3:** P3, P8, P13, P16, P26, P29, P42.

By paper count the first ten to draft are P10 (#62: 13 papers; #75: 7), P11 (13), P12 (11), P14 (#65:
10; #77: 6), P19 (9), P20 (#69: 9; #73: 7), P33 (9), P40 (9), P21 (8) and P22 (#71: 8). P10, P21 and P22
are tier 0, and they unblock P11, P14, P19, P31, P33 and P42.

## 3. Priorities and duplication risks

### 3.1 Existing work on the critical path of several definitions

- **HeegaardFloer F0–F2 (main).** J-curve analysis for #83, #73, #69, #66 and #80, via P17, P20 and
  DGFloer.
- **DifferentialGeometry L0–1 and #334.** Forms for #79, #64, #69, #80, #87 and #76.
- **GeometricTopology L7, and HopfRinow (being archived, #723).** Curvature and Levi-Civita for #62,
  #63, #68, #75, #81, #86 and #87.
- **OperatorTheory (#126).** The only bounded-operator foundation, needed by #92, #100, #99, #70 and #86;
  merging it unblocks P39, P47 and P46.
- **PDE (main).** Needed by #86, #88, #89, #90, #81, #87 and #91, but it stops at domains in ℝⁿ.
  **Nothing owns elliptic theory on closed manifolds.** DifferentialGeometry L12 hands analysis of Δ to
  PDE, which has no manifold lane. P32 is the main new geometric substrate.
- **SmoothRepresentationsOfLocalGroups and ReductiveGroupsPartII (B).** Needed by #52, #60 and #55 (and
  A #43, #23, #26). They come early in the campaign order, and are where the p-adic side should start.
- **ChevalleyGroups (#447) and CohomologicalPointCounting (#196).** Needed by #54, #60, #53 and #67.
- **KleinianGroups (#432)** for #63, #65 and #77. **RandomMatrices (#397)** for #99 and #94.
  **PointProcesses (#417)** names an ergodic-theory roadmap that does not exist; P21 and P43 fill it.

### 3.2 Duplication risks

1. **Spectra.** HomotopySpheres (#284) "owns stable homotopy"; StableHomotopyKTheory (B) H.5 builds
   spectra and the stable homotopy category; E5 (B) builds stable ∞-categories. Fix one owner before P25.
2. **Hochschild chains.** DGAInfinity L8 and RefinedTraceMethods (B) RT.1 both build them. One owner,
   with RT.1 consuming.
3. **Loop groups.** GS0 (B) and ET.2b (B) each build them, and GS warns against identifying the two. P4
   should own the algebraic equal-characteristic version.
4. **Tannakian reconstruction.** Two code versions, ReductiveGroups L1, MC.6 (B) and GS4 (B). P7
   consumes L1 and supplies the formalism to MC.6 and GS4.
5. **VOAs.** QM.6 (B) owns the moonshine VOA "within this stage"; P9 should own VOAs, with QM.6
   consuming.
6. **Types.** SR.3, ET.6 (GL_n types) and R16.2 (B) against P8; ET.6's type theory should be stated
   against P8.
7. **Lattices.** AA.3 (B), the PSL₂ covolume predicates of FuchsianOrbifolds and KleinianGroups, ALS.0
   (B) and LieGroups L9. P14 needs one `IsLattice` that specializes the PSL₂ predicates.
8. **Symplectic foundations** are split between HeegaardFloer F2.1 (Darboux, Moser), #480 (X_H) and
   DGFloer L6 (T*Q, HZ capacity). P20 owns only the capacity axioms and Ham.
9. **Local systems.** Code (groupoid functors), #196 L5 (sheaves), DGFloer L3 and AlgebraicTopology; #196
   L5 should own the comparison.
10. **Stable maps.** StableReduction's algebraic stable maps and P17's symplectic ones need one
    dual-graph and stabilization API.
11. **Free probability.** #397 M6 owns NC probability spaces; P46 and P47 consume them. L(F_d) belongs to
    P47.
12. **Concordance.** GT L6 expects s from CombinatorialHeegaardFloer; P24 should be named as its source.
13. **Monge–Ampère.** OptimalTransport L6 owns the real equation; P13 owns only the complex one.
14. **Graph spectra.** Mathlib `lapMatrix`, #258, #86 and #94; P41 owns graph spectral gaps.
15. **Companion report (#1–51).** Overlaps: P15 with A #9; P3 and P4 with A #6 and A #41; P13 with A #7
    and A #39; P12 with A #2 (the VHS successor of HodgeStructures); P26 with A #14 and A #33. Merge the
    two plans before drafting these.
