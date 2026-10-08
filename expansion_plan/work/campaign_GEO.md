# Campaign GEO: geometry (math.DG, math.SG, math.MG) — phase-2 slate (2026-10-07)

Inputs: `needs_all.jsonl`, the geometry and Annals 52–100 reports, the relevant parts of the AG, probability,
analysis and LMFDB reports; supply from `upstream/main`, `upstream-pr/<N>`, Tau Ceti `a91d3aafa` and three explorer
drafts. Machine version: `slate_GEO.json` (`replaces` lists the phase-1 proposals each roadmap absorbs).

## 1. Scope

GEO owns math.DG, math.SG and math.MG: Riemannian, Lorentzian and Kähler-metric geometry, global analysis on
manifolds (elliptic operators, spectra, minimal submanifolds, flows, gauge theory), symplectic and contact
geometry, and metric and convex geometry. It owns the *analysis of geometric operators and metrics*; complex
manifolds, Kähler manifolds as complex objects and Hodge theory are AG's, geometric measure theory as a theory of
objects and Euclidean PDE are ANA's, CAT(0) group theory is ALG's (BOUNDARIES.md).

| goal | needs | gap | TC code | TC roadmap | open PR | Mathlib | OAI Lean | distinct refs |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| OpenAI | 136 | 91 | 9 | 14 | 10 | 11 | 1 | 59 families |
| Annals | 15 | 6 | 7 | 1 | 1 | 0 | 0 | 14 definitions (#62–#91) |
| LMFDB | 1 | 0 | 0 | 0 | 1 | 0 | 0 | `lattice` |
| **total** | **152** | **97** | 16 | 15 | 12 | 11 | 1 | |

By class: math.DG 93 (69 gap), math.MG 42 (27 gap), math.SG 17 (1 gap; symplectic needs are partly owned by open
PRs). 87 of the 152 are statement-level. The 14 Annals definitions are each needed by 4–13 papers (#62 curvature
13, #64 Kähler–Einstein 11, #68, #69, #86 9 each, #87 8, #73, #75 7, #76, #77 6, #79, #80, #81, #91 5, #83 4).
Another 110 rows in other campaigns name GEO as secondary (ANA 39, ALG 17, PRDS 16, AG 14, FAMP 11, COMB 10, TOP
3); five of them (OAI#365 ×3, Annals#86 ×2) are elliptic or spectral theory on manifolds and are absorbed here.

## 2. Existing supply

| Roadmap (where) | Covers | Contribution | Action |
|---|---|---|---|
| DifferentialGeometry (main, DG) | forms, d, orientations, flows, Frobenius, Stokes, de Rham, Poincaré duality, degree; L12 Laplace–Beltrami and Green | statements of OAI 341, 342; substrate of every GEO roadmap | leave; its "PDE owns everything analytic about Δ beyond 12.5" becomes EllipticOperators; L0–L2, L5, L6, L12 gate three wave-A roadmaps |
| HopfRinow (main; archive PR #723) | distance, geodesics, exp, Gauss lemma, Hopf–Rinow, first variation; all layers done | Annals #62 substrate | merge #723; consumed by CurvatureAndSubmanifolds, ComparisonGeometry |
| GeometricTopology L7 (main, GT) | curvature tensors (code), Riemannian volume, hyperbolic structures | Annals #62 "main object defined" | leave; GEO extends curvature without redefining it |
| OptimalTransport (main, OC) | L6 real Monge–Ampère, L7 cut locus and injectivity radius, L8 CBB(κ), L12 CAT(0)/Hadamard predicate, L14 CD/RCD | OAI 091, 353, 356, 357, 360 | leave; L7 should consume ComparisonGeometry's conjugate points (cycle risk); ALG should consume L12's predicate |
| HeegaardFloer (main, SG) | Morse homology, Fredholm/Sard–Smale, CR package, genus-0 J-curves with boundary, Darboux–Moser (F2.1), exact Lagrangian Floer | OAI 087, 343 statements | leave; PseudoholomorphicCurves adds the closed-curve theory F2 excludes |
| RepresentationTheory/LieGroups (main, RT) | exp, Ad, Cartan/Iwasawa/KAK | OAI 255 | leave; consumed by SymmetricSpaces, Connections, SymplecticManifolds |
| IntegralLattices (main and Completed, NT) | minimum, kissing number, Minkowski and Hermite bounds | LMFDB `lattice` in part | leave; PackingCoveringAndEnergy consumes 2B, 2E |
| PDE, FuchsianOrbifolds, AnalyticToricGeometry (main); UniversalCovers, HodgeStructures (completed); #151, #432 (open) | Euclidean PDE; Γ\ℍ; toric varieties; covers; Hodge algebra; three-body; Kleinian groups | inputs or consumers | leave |
| #334 Differential forms and flows (open) | split proposal of an earlier DG draft | none beyond main | **close as superseded** by DifferentialGeometry L0–L3; its §10 (Lie-algebra-valued forms) moves to Connections |
| #480 HamiltonianSystems (open, SG) | X_H, Poisson bracket, symplectomorphisms, infinitesimal moment maps | Annals #69, OAI 347 | **merge soon**: three SG/DG roadmaps, #655, #151 and PRDS's billiards wait on it |
| #655 DGFloer (open, SG) | DG Morse/Floer; L6 Liouville domains, T*Q, HZ capacity; L7 aspherical Floer homology, SH | Annals #73, OAI 340, 343, 347 | **merge**; mark T*Q and Liouville domains as shared foundation (SymplecticManifolds, ContactGeometry alias them) |
| #279/#280 ComplexManifolds/ComplexTori (open, CV) | holomorphic atlases, bundles, quotients | OAI 338 statement | merge (ANA); KahlerGeometry consumes via AG |
| #287 ArithmeticHeights (open, NT) | C.3 Brunn–Minkowski, Prékopa–Leindler | OAI 087, 088, 091, 101 | merge soon; C.3 is convex geometry: whichever of C.3 and ConvexBodies lands first owns it, the other aliases |
| #286 ThetaSeries (open, NT) | theta series of lattices | packing examples | merge; PackingCoveringAndEnergy consumes |
| Birkbeck campaign | no GEO roadmap; ALS.0 (G/K), GeometryOfNumbers… | consumers | cite SymmetricSpaces, ConvexBodies, Packing |
| Explorer drafts | RiemannianGeometry RG.0–5; SymplecticContactGeometry SC.0–7; SCV/Kähler CV.0–6 | partial blueprints, none compiled | reuse RG.0–4, RG.5, SC.0–2, SC.3–7 as marked in §3; CV.0–3 go to ANA, CV.4–6 to AG |
| Tau Ceti code | curvature, geodesics, isometries, volume, compatible J, J-holomorphic maps, Morse, Fredholm, Sobolev, compact spectra | 16 needs | consumed, never redefined |

## 3. The slate

Twenty-three roadmaps: three umbrella families with sixteen sub-roadmaps, and seven standalone roadmaps. Each
entry: topic, size, PRs, wave, then the scope paragraph as the roadmap's own opening. *Serves* lists the needs
assigned to it from `needs_all.jsonl`; substrate roles are in the scope paragraphs and §5.

#### RiemannianGeometry

Umbrella, XL family, math.DG, ~1,050 PRs, on Tau Ceti's connection, curvature, geodesics and volume (never redefined); the umbrella fixes the curvature sign and curvature-bound predicates once.

**RiemannianGeometry/CurvatureAndSubmanifolds** (math.DG, L ~200, wave A). This roadmap develops the algebra of the curvature tensor and the geometry of Riemannian submanifolds, on Tau Ceti's Levi-Civita connection and curvature tensors, which it consumes and never redefines. It covers the Weyl–Schouten decomposition (with Λ⁺ ⊕ Λ⁻ in dimension four), Einstein metrics, conformal and warped-product formulas, the constant-curvature models, and the Christoffel presentation onto which chart-based work ports. For submanifolds it builds the second fundamental form, mean curvature, normal connection and the Gauss, Codazzi and Ricci equations, through Gauss–Bonnet for surfaces. Jacobi fields are ComparisonGeometry's, minimal submanifolds MinimalSubmanifolds', principal connections ConnectionsAndCharacteristicClasses', indefinite metrics LorentzianGeometry's.
- *Milestones:* Bianchi identities, R = W + S ⊙ g, W± and Einstein in dimension 4; constant curvature ⇔ R = κ g ⊙ g, Schur; curvature of Sⁿ(r), ℍⁿ, tori, warped products (Annals #62 API); conformal flatness; Milnor's left-invariant metrics; Gauss–Codazzi–Ricci; Theorema Egregium; local Bonnet theorem; umbilic hypersurfaces; Gauss–Bonnet with boundary.
- *Prereqs:* Tau Ceti curvature code (GeometricTopology L7); HopfRinow (#723); DifferentialGeometry L0–L5, L12; RepresentationTheory/LieGroups. *Serves:* Annals 2 (#62, #68); OpenAI 3 (#260, #334, #348). *Port:* OAI Geometry/EinsteinFour; the ≥6 OAI chart-level curvature definitions, via the coordinate bridge. *Formalizability:* high (Lee, Petersen); algebraic.

**RiemannianGeometry/ComparisonGeometry** (math.DG, L ~250, wave A). This roadmap develops Jacobi fields and second variation and derives the comparison theorems and their global consequences for complete manifolds with curvature bounds. It consumes HopfRinow's geodesics, exponential map and first variation and OptimalTransport Layer 7's injectivity radius and cut-locus measure theory, and supplies the conjugate-point theory those rest on. It covers Rauch, Hessian, Laplacian and volume comparison, Toponogov, Bonnet–Myers, Cartan–Hadamard, Synge, Preissmann, the splitting theorem and Milnor's growth bound. Gromov–Hausdorff convergence is MetricGeometry's, Ricci limits RicciCurvatureAndLimitSpaces', Morse theory of energy VariationalTheoryOfGeodesics'.
- *Milestones:* Jacobi fields ↔ geodesic variations; Jacobi's criterion; Klingenberg's cut-point lemma; index lemma; Rauch; Hessian and Laplacian comparison (also barrier sense); Bonnet–Myers, Cheng rigidity; Cartan–Hadamard; Synge, Preissmann; Bishop–Gromov (Annals #62 API); Toponogov, so sec ≥ κ ⇒ CBB(κ) in OptimalTransport L8's sense; Cheeger–Gromoll splitting; Milnor's bound; sec ≤ κ ⇒ local triangle comparison. Statements: sphere, soul theorems.
- *Prereqs:* HopfRinow; Tau Ceti curvature code; OptimalTransport L7, L8; UniversalCovers; PDE (strong maximum principle). *Serves:* Annals 1 (#62); OpenAI 7 (#335, #337, #338, #344, #358, #360, #361). *Port:* OAI Geometry/ConjugatePoints, NegativeCurvature; explorer draft RiemannianGeometry RG.0–RG.4. *Formalizability:* high (do Carmo, Petersen); parallel-frame bridge and barrier comparison are the hard nodes.

**RiemannianGeometry/SymmetricSpaces** (math.DG, L ~180, wave B). This roadmap develops the Riemannian geometry of homogeneous and symmetric spaces: reductive homogeneous spaces, Cartan's characterization of locally symmetric spaces, symmetric pairs and R(X,Y)Z = −[[X,Y],Z], duality, rank and maximal flats, the de Rham decomposition, and the rank-one spaces with their pinching. It consumes RepresentationTheory/LieGroups (Cartan, Iwasawa, KAK), holonomy from ConnectionsAndCharacteristicClasses and Cartan–Hadamard from ComparisonGeometry. Lattices and Γ\G/K are the algebra campaign's LatticesInSemisimpleGroups and ℍⁿ/Γ the topology campaign's HyperbolicManifolds; both consume this roadmap.
- *Milestones:* Killing–Hopf classification of space forms; ∇R = 0 ⇔ symmetries are isometries; Cartan–Ambrose–Hicks; curvature sign by type, duality; noncompact type is Hadamard; maximal flats K-conjugate; rank-one spaces (−4 ≤ K ≤ −1), CROSSes, Wolf spaces; SL_n(ℝ)/SO(n), Siegel space. Statements: Cartan's classification, Cayley plane.
- *Prereqs:* RepresentationTheory/LieGroups; ConnectionsAndCharacteristicClasses; RiemannianGeometry/ComparisonGeometry. *Serves:* Annals 1 (#77); OpenAI 3 (#062, #339, #344). *Port:* none in OAI; coordinate with Birkbeck ArithmeticLocallySymmetricSpaces ALS.0, FuchsianOrbifolds, KleinianGroups. *Formalizability:* medium-high (Helgason, Eberlein).

**RiemannianGeometry/VariationalTheoryOfGeodesics** (math.DG, M ~110, wave B). This roadmap studies geodesics as critical points of energy on path and loop spaces. It builds Milnor's broken-geodesic approximation, proves the Morse index theorem, and derives the topology of path spaces and the existence of closed geodesics. It treats manifolds all of whose geodesics are closed, Blaschke manifolds with the Berger–Kazdan inequality, and the geodesic flow with its Liouville measure. Conjugate points are ComparisonGeometry's and Morse homology HeegaardFloer Lane M's; Hilbert-manifold loop spaces are not used.
- *Milestones:* Morse index theorem; CW type of ΩM; Lyusternik–Fet; Birkhoff min–max on S²; Bott–Samelson; Berger–Kazdan; geodesic flow as Hamiltonian flow, Liouville invariance. Statements: Lyusternik–Schnirelmann, Gromoll–Meyer, Bangert–Franks.
- *Prereqs:* RiemannianGeometry/ComparisonGeometry; AlgebraicTopology; HamiltonianSystems (#480). *Serves:* OpenAI 2 (#344, #345). *Port:* explorer draft RiemannianGeometry RG.5; Tau Ceti Geometry/Manifold/Morse. *Formalizability:* medium-high (Milnor; Besse).

**RiemannianGeometry/RicciCurvatureAndLimitSpaces** (math.DG, L ~200, wave C). This roadmap develops manifolds with Ricci curvature bounded below and their Gromov–Hausdorff limits: the Abresch–Gromoll estimate, segment and Poincaré inequalities, Cheeger–Colding almost splitting and 'volume cone implies metric cone', volume convergence, tangent cones (also at infinity) and their cone structure when noncollapsed, and the singular strata with dim S^k ≤ k. It consumes MetricGeometry, ComparisonGeometry, SpectralGeometry and OptimalTransport Layer 14, to which it supplies 'Ricci limits are RCD'. Rectifiability and the codimension-two and -four theorems are stated.
- *Milestones:* Gromov precompactness under Ric ≥ −(n−1); Abresch–Gromoll; Buser Poincaré, doubling; almost splitting; volume cone ⇒ metric cone; volume convergence; noncollapsed tangent cones are metric cones; dim S^k ≤ k (Annals #75). Statements: Cheeger–Colding–Naber, Cheeger–Naber, Cheeger–Jiang–Naber, De Philippis–Gigli.
- *Prereqs:* RiemannianGeometry/ComparisonGeometry; MetricGeometry; GlobalAnalysisOnManifolds/SpectralGeometry; OptimalTransport L14. *Serves:* Annals 1 (#75); OpenAI 2 (#357, #361). *Port:* OAI Geometry/RCD; OAI Analysis/RCDHeat; OAI Geometry/HarmonicGrowth. *Formalizability:* medium (Cheeger's notes); long but elementary given the inputs.

**RiemannianGeometry/IsometricEmbeddings** (math.DG, M ~110, wave B). This roadmap covers isometric immersions and embeddings into Euclidean space and the h-principle behind them: Nash–Kuiper by convex integration, Nash's C^∞ theorem in Günther's form, Janet–Cartan, and the rigidity side (Darboux equation, Hilbert's theorem, Liebmann). It consumes CurvatureAndSubmanifolds and Euclidean PDE, and ports the local h-principle for open ample relations from the sphere-eversion project. Convex integration for fluids is the analysis campaign's ConvexIntegration.
- *Milestones:* local h-principle; Smale–Hirsch (statement); Nash–Kuiper; Nash–Günther; Janet–Cartan; Darboux equation; Hilbert's theorem; Liebmann. Statements: Efimov, Weyl problem.
- *Prereqs:* RiemannianGeometry/CurvatureAndSubmanifolds; PDE; sphere-eversion (port). *Serves:* OpenAI 2 (#333, #334). *Port:* OAI Geometry/SurfaceImmersion, IsometricImmersion; sphere-eversion local h-principle. *Formalizability:* high for Nash–Kuiper, medium for Nash–Günther.

#### GlobalAnalysisOnManifolds

Umbrella, XL family, math.DG (sec. math.AP, math.SP), ~1,470 PRs; EllipticOperators is the substrate of the other five; Δ = div ∘ grad as in DifferentialGeometry.

**GlobalAnalysisOnManifolds/EllipticOperators** (math.DG, L ~280, wave A). This roadmap develops linear elliptic theory for differential operators between vector bundles over compact manifolds with and without boundary: Sobolev and Hölder spaces of sections, symbols and adjoints, Gårding's inequality, interior and boundary regularity, the Fredholm property and spectral theory of self-adjoint elliptic operators, with the Hodge theorem, the Bochner technique, the Dirichlet and Neumann problems and the Dirichlet-to-Neumann map as applications. It starts where DifferentialGeometry Layer 12 stops and works in charts on the PDE roadmap's Euclidean estimates. It is the single owner of elliptic theory on manifolds, consumed by the analysis campaign's boundary problems and the algebraic-geometry campaign's Hodge theory. Pseudodifferential calculus, index theorems and heat asymptotics are not here.
- *Milestones:* chart-independent H^s, W^{k,p}, C^{k,α} of sections; Sobolev, Rellich–Kondrachov, trace; Gårding; Sobolev and Schauder regularity; Fredholm, index invariance; discrete spectrum, eigenbasis; Hodge decomposition, H^k ≅ H^k_dR; b±, signature in dimension 4; elliptic complexes; Weitzenböck, Bochner; Dirichlet, Neumann, DN map; Green's function; unique continuation; heat kernel.
- *Prereqs:* DifferentialGeometry L0–L8, L12; PDE (Lanes A, D, E); Tau Ceti Sobolev, Fredholm and compact self-adjoint spectral code. *Serves:* Annals 1 (#86); OpenAI 4 (#341, #342, #348, #365). *Port:* abenenson/rellich-kondrachov; OAI Geometry/Riemannian/HarmonicCore; OAI Geometry/TamingCompatibility. *Formalizability:* high, large (Warner ch. 6; Taylor).

**GlobalAnalysisOnManifolds/SpectralGeometry** (math.DG, L ~220, wave B). This roadmap studies Laplace eigenvalues and eigenfunctions and harmonic functions on complete manifolds: Dirichlet and Neumann spectra, min–max and explicit spectra, Weyl's law, heat-kernel asymptotics and spectral invariants, isospectrality, curvature and isoperimetric eigenvalue bounds, nodal sets, and gradient estimates and Liouville theorems under Ric ≥ 0. It consumes EllipticOperators, ComparisonGeometry and the analysis campaign's symmetrization. Automorphic spectral theory is the number-theory campaign's, Schrödinger operators FAMP's, graph spectra COMB's.
- *Milestones:* min–max; spectra of Sⁿ, tori, CPⁿ (Annals #86 API); Weyl's law; Minakshisundaram–Pleijel; Milnor's isospectral tori, Sunada; Lichnerowicz–Obata; Cheeger, Buser; Faber–Krahn; Li–Yau; Cheng–Yau, Liouville; Courant nodal theorem; Brüning–Yau. Statements: Donnelly–Fefferman, Logunov–Malinnikova, Colding–Minicozzi.
- *Prereqs:* GlobalAnalysisOnManifolds/EllipticOperators; RiemannianGeometry/ComparisonGeometry; GeometricMeasureTheory (ANA). *Serves:* Annals 1 (#86); OpenAI 4 (#336, #348, #350, #361). *Port:* OAI Geometry/NodalSets, SmoothYau, HarmonicGrowth; OAI Analysis/NodalLength. *Formalizability:* high (Chavel; Schoen–Yau).

**GlobalAnalysisOnManifolds/DiracOperatorsAndIndexTheory** (math.DG, L ~250, wave B). This roadmap builds Clifford modules, spin structures and Dirac operators and proves the Atiyah–Singer index theorem for Dirac operators by the heat-kernel method: Lichnerowicz and Weitzenböck formulas, McKean–Singer, Getzler rescaling, the local index theorem, and the corollaries Chern–Gauss–Bonnet, the signature theorem, the Â obstruction to positive scalar curvature and Hitchin–Thorpe. It consumes OrthogonalSpinGroups, ConnectionsAndCharacteristicClasses and EllipticOperators. K-theoretic and families index theorems are stated; holomorphic Riemann–Roch is the algebraic-geometry campaign's consumer.
- *Milestones:* spin structures; Dirac operators; Lichnerowicz, no harmonic spinors under PSC; McKean–Singer; local index theorem; index = ∫Â ∧ ch; Chern–Gauss–Bonnet; signature theorem; Â = 0 under PSC; Hitchin–Thorpe; Rokhlin. Statements: general Atiyah–Singer, Gromov–Lawson.
- *Prereqs:* GlobalAnalysisOnManifolds/EllipticOperators; ConnectionsAndCharacteristicClasses; OrthogonalSpinGroups. *Serves:* OpenAI 2 (#335, #336). *Port:* none in OAI. *Formalizability:* medium; Getzler's proof is the long pole.

**GlobalAnalysisOnManifolds/MinimalSubmanifolds** (math.DG, L ~250, wave B). This roadmap develops minimal submanifolds and the regularity of stationary and minimizing varifolds and currents: variations, stability and index, Simons' identity, monotonicity, calibrations, minimal surfaces in ℝ³ and spheres, the Plateau problem; then Allard regularity, De Giorgi ε-regularity for minimizing and almost-minimizing boundaries (hence isoperimetric and CMC regularity), dimension reduction, the Simons cone and Bernstein's theorem. It consumes the objects and compactness theorems of the analysis campaign's GeometricMeasureTheory and CurvatureAndSubmanifolds. Min–max, Schoen–Yau descent and μ-bubbles have their smooth core proved and regularity-heavy endpoints stated.
- *Milestones:* Clifford torus index 5 (Annals #68 API); Simons identity and gap; Takahashi; Weierstrass; calibrated ⇒ minimizing; monotonicity; Allard; ε-regularity; dimension reduction; Simons cone; Bernstein n ≤ 7; Schoen–Simon–Yau; Douglas–Radó; Schoen–Yau descent; μ-bubbles. Statements: stable Bernstein, Almgren–Pitts, Marques–Neves.
- *Prereqs:* RiemannianGeometry/CurvatureAndSubmanifolds; GlobalAnalysisOnManifolds/EllipticOperators; GeometricMeasureTheory (ANA). *Serves:* Annals 1 (#68); OpenAI 5 (#335, #336, #346, #349, #375). *Port:* OAI Geometry/StableBernstein, Varifold, HypersurfaceGerms; OAI Geometry/Perimeter, CubicTorus. *Formalizability:* smooth part high; GMT regularity medium and long (Simon).

**GlobalAnalysisOnManifolds/GeometricFlows** (math.DG, L ~250, wave C). This roadmap develops Ricci flow, mean curvature flow, the Kähler–Ricci and Calabi flows and the harmonic map heat flow: their shared parabolic theory on closed manifolds (short-time existence, DeTurck's trick, scalar and tensor maximum principles), curvature evolution, and the monotonicity formulas that control singularities, with the classical convergence theorems as milestones. It consumes EllipticOperators, MinimalSubmanifolds, KahlerGeometry and the analysis campaign's parabolic PDE. Singularity theory beyond the classical results is stated.
- *Milestones:* DeTurck short-time existence; Hamilton's maximum principle; Shi estimates; Hamilton's Ric > 0 theorem; Perelman's W and no local collapsing; Huisken's convex theorem and monotonicity; shrinkers (Annals #81 API); Brakke flows; Eells–Sampson; Cao's Kähler–Ricci flow; Calabi flow existence. Statements: geometrization, Bamler–Kleiner, Colding–Minicozzi.
- *Prereqs:* GlobalAnalysisOnManifolds/EllipticOperators; GlobalAnalysisOnManifolds/MinimalSubmanifolds; KahlerGeometry; PDE (Lane F). *Serves:* Annals 1 (#81); OpenAI 5 (#338, #341, #351, #352, #355). *Port:* none in OAI. *Formalizability:* statements cheap; classical proofs medium.

**GlobalAnalysisOnManifolds/GaugeTheory** (math.DG, L ~220, wave C). This roadmap develops the analysis of gauge-theoretic equations over compact manifolds: Yang–Mills, anti-self-dual connections, Uhlenbeck gauge fixing and compactness, instanton moduli spaces, Seiberg–Witten, and Hermitian–Yang–Mills on Kähler manifolds. Its milestones are Donaldson's diagonalization theorem, Witten's vanishing under positive scalar curvature and Donaldson–Uhlenbeck–Yau. It consumes ConnectionsAndCharacteristicClasses, EllipticOperators, DiracOperatorsAndIndexTheory and the algebraic-geometry campaign's stable bundles. Floer homologies and Donaldson invariants are stated.
- *Milestones:* Uhlenbeck compactness; removable singularities; ASD deformation complex; Donaldson diagonalization; SW compactness and PSC vanishing; DUY; Hitchin's equations defined.
- *Prereqs:* ConnectionsAndCharacteristicClasses; GlobalAnalysisOnManifolds/DiracOperatorsAndIndexTheory. *Serves:* OpenAI 1 (#306). *Port:* none. *Formalizability:* medium-low; lowest priority.

#### SymplecticAndContactGeometry

Umbrella, XL family, math.SG, ~930 PRs, on Tau Ceti's symplectic code, HeegaardFloer, #480 and #655, with their shared signs (ι_{X_H}ω = dH, ω_can = −dλ_can).

**SymplecticAndContactGeometry/SymplecticManifolds** (math.SG, L ~220, wave B). This roadmap develops symplectic manifolds between the local normal forms and Floer theory: cotangent bundles, Lagrangian and coisotropic submanifolds and Weinstein's neighbourhood theorems, Liouville volume, Symp and Ham with flux, Hamiltonian Lie group actions and reduction, convexity and the Delzant classification, blow-up and cuts, toric domains, and Liouville–Arnold. It consumes HeegaardFloer Lane F2.1 (Darboux, Moser), HamiltonianSystems (#480) and RepresentationTheory/LieGroups. Pseudoholomorphic curves and what needs them are later sub-roadmaps; KAM and twist maps are the dynamics campaign's.
- *Milestones:* T*Q and surfaces symplectic, S⁴ not (Annals #69 API); Weinstein neighbourhood theorems; flux and Calabi homomorphisms; coadjoint orbits; reduction in stages; AGS convexity; Delzant; Duistermaat–Heckman; blow-up, cuts, toric domains; Liouville–Arnold; Kodaira–Thurston.
- *Prereqs:* HeegaardFloer F2.1; HamiltonianSystems (#480); RepresentationTheory/LieGroups; DifferentialGeometry. *Serves:* Annals 1 (#69); OpenAI 2 (#343, #347). *Port:* OAI Geometry/Symplectic, BallPacking; explorer draft SymplecticContactGeometry SC.3–SC.7. *Formalizability:* high; needs smooth quotients by free proper actions (supplier gap).

**SymplecticAndContactGeometry/ContactGeometry** (math.SG, L ~180, wave A). This roadmap develops contact geometry in all odd dimensions with the three-dimensional theory of Legendrian knots and tightness: contact forms, Reeb flows, contact Hamiltonians, the Darboux and Gray theorems, Legendrian neighbourhoods, symplectization, fronts with Thurston–Bennequin and rotation numbers, overtwisted discs, Lutz–Martinet existence, and symplectic fillings. It consumes DifferentialGeometry and shares Liouville domains with DGFloer (#655) Layer 6. Contact homology is not here; Eliashberg's classification, Giroux's correspondence and the Weinstein conjecture are stated.
- *Milestones:* standard structures, Reeb flow on S³ = Hopf flow (Annals #80 API); Darboux; Gray; J¹L neighbourhoods; tb, rot; Bennequin inequality; Lutz–Martinet; fillings defined. Statements: Eliashberg, Gromov–Eliashberg, Giroux, Taubes.
- *Prereqs:* DifferentialGeometry; GeometricTopology (surgery); Liouville domains: DGFloer (#655) L6 if merged first, else defined here and aliased there. *Serves:* Annals 1 (#80). *Port:* explorer draft SymplecticContactGeometry SC.0–SC.2; Tau Ceti standard contact distribution. *Formalizability:* high (Geiges).

**SymplecticAndContactGeometry/PseudoholomorphicCurves** (math.SG, L ~280, wave B). This roadmap extends HeegaardFloer Lanes F0–F2 (genus zero, fixed domains, Lagrangian boundary) to closed pseudoholomorphic curves in closed symplectic manifolds, following McDuff–Salamon: simple curves, the index n(2−2g) + 2c₁(A), generic transversality, pseudocycles, Gromov compactness to genus-zero stable maps, semipositive genus-zero Gromov–Witten invariants and quantum cohomology, and nonsqueezing. It consumes HeegaardFloer's Fredholm and Cauchy–Riemann package, SymplecticManifolds, and StableReduction's dual graphs. Virtual classes are out of scope; algebraic Gromov–Witten theory is the algebraic-geometry campaign's.
- *Milestones:* lines in Pⁿ with Grassmannian moduli (Annals #83 API); somewhere injectivity; Riemann–Roch index; transversality; pseudocycles; genus-0 compactness; GW axioms; QH(CPⁿ); nonsqueezing. Statements: higher-genus compactness, Ruan–Tian, McDuff's ruled surfaces.
- *Prereqs:* HeegaardFloer F0–F2; SymplecticAndContactGeometry/SymplecticManifolds; StableReduction. *Serves:* Annals 1 (#83); OpenAI 2 (#087, #343). *Port:* Tau Ceti Geometry/Symplectic/JHolomorphic; McDuff–Salamon. *Formalizability:* medium; transversality and gluing are the long poles.

**SymplecticAndContactGeometry/FloerTheoryAndSymplecticRigidity** (math.SG, L ~250, wave B). This roadmap develops symplectic rigidity: capacities and embedding obstructions, Hofer geometry, monotone Hamiltonian Floer homology with the PSS isomorphism, spectral invariants and norm, the Arnold conjecture in its cup-length form, and exact Lagrangians in cotangent bundles through generating functions. It consumes DGFloer (#655) Layers 6–7 (aspherical Floer complex, action filtration, Hofer–Zehnder capacity), HeegaardFloer Lane F3 and PseudoholomorphicCurves. Fukaya categories and ECH are stated where needed, not built.
- *Milestones:* capacity axioms; capacities of balls, ellipsoids, polydiscs; packing volume obstruction; energy–capacity and Hofer nondegeneracy; monotone Floer homology, PSS; spectral norm; Arnold (aspherical, cup-length); Conley–Zehnder; generating functions, Laudenbach–Sikorav. Statements: Abouzaid–Kragh, McDuff–Polterovich, ECH.
- *Prereqs:* DGFloer (#655); HamiltonianSystems (#480); HeegaardFloer F3; SymplecticAndContactGeometry/PseudoholomorphicCurves. *Serves:* Annals 2 (#69, #73); OpenAI 4 (#087, #340, #343, #347). *Port:* OAI Geometry/BallPacking, PolarProducts, Arnold, NearbyLagrangian. *Formalizability:* medium (McDuff–Salamon; Polterovich).

#### Standalone roadmaps

**ConnectionsAndCharacteristicClasses** (math.DG, L ~200, wave A). This roadmap develops principal bundles with Lie structure group, connections, curvature, holonomy and Chern–Weil theory: associated and frame bundles, reductions of structure group, connection forms and the structure equation, induced covariant derivatives matched with Tau Ceti's, gauge transformations, holonomy and Ambrose–Singer, flat connections, Chern, Pontryagin and Euler forms, Chern–Simons forms, and Riemannian holonomy (de Rham decomposition, Berger's list). It consumes DifferentialGeometry and RepresentationTheory/LieGroups. Gauge-theoretic analysis is GaugeTheory's; the Chern connection of a Hermitian holomorphic bundle belongs to the algebraic-geometry campaign's Kähler roadmap, which consumes this one.
- *Milestones:* connection form ↔ horizontal distribution ↔ covariant derivative; F = dA + ½[A∧A], Bianchi; holonomy, Ambrose–Singer; flat ↔ Hom(π₁, G)/G; Chern–Weil and transgression; Hopf bundle Euler number (Annals #79 API); Chern–Gauss–Bonnet; Yang–Mills and ASD equations, BPST; de Rham decomposition; special holonomy and Ricci consequences (Berger stated).
- *Prereqs:* DifferentialGeometry L0–L6; RepresentationTheory/LieGroups; UniversalCovers. *Serves:* Annals 1 (#79); OpenAI 4 (#062, #306, #341, #348). *Port:* DifferentialGeometry PR #334 §10 design; Tau Ceti CovariantDerivative code; Tu; Kobayashi–Nomizu. *Formalizability:* high.

**LorentzianGeometry** (math.DG, L ~200, wave B). This roadmap develops semi-Riemannian geometry with emphasis on Lorentzian causal structure: the Levi-Civita connection and curvature of nondegenerate metrics, time orientations, the causal ladder through global hyperbolicity, Cauchy surfaces and Geroch splitting, maximal causal geodesics, the Raychaudhuri equation, and the Hawking and Penrose singularity theorems. It covers the standard spacetimes, initial data sets with the constraint equations and energy conditions, ADM energy–momentum and trapped surfaces. Einstein evolution is the analysis campaign's EinsteinEvolutionEquations; the positive mass theorem, Penrose inequality and maximal development are stated.
- *Milestones:* semi-Riemannian Levi-Civita agreeing with Tau Ceti's; reverse triangle inequality; causal ladder; global hyperbolicity ⇔ causal + compact diamonds; Geroch; Avez–Seifert; Raychaudhuri; Hawking, Penrose; Schwarzschild–Kruskal, Kerr solve Einstein (Annals #87 API); constraints, ADM mass. Statements: PMT, Penrose inequality, Choquet-Bruhat–Geroch.
- *Prereqs:* DifferentialGeometry; HopfRinow (template); RiemannianGeometry/CurvatureAndSubmanifolds. *Serves:* Annals 1 (#87); OpenAI 2 (#260, #264). *Port:* OAI Geometry/Relativity; O'Neill; Hawking–Ellis. *Formalizability:* high.

**KahlerGeometry** (math.DG, L ~250, wave C). This roadmap studies Kähler metrics as Riemannian objects: holomorphic sectional and bisectional curvature, Kähler–Einstein, cscK and extremal metrics with the Futaki invariant and Matsushima's obstruction, symmetry reductions (Calabi ansatz, toric metrics, Kähler cuts), hyperkähler metrics, and Yau's solution of the Calabi conjecture with the Aubin–Yau theorem. It consumes Kähler manifolds, the Chern connection, the Ricci form and the ∂∂̄-lemma from the algebraic-geometry campaign's KahlerManifoldsAndHodgeTheory, with EllipticOperators and ConnectionsAndCharacteristicClasses. Pluripotential theory and weak solutions are the analysis campaign's PositiveCurrentsAndMongeAmpere; K-stability and Chen–Donaldson–Sun are the algebraic-geometry campaign's.
- *Milestones:* Fubini–Study KE (Annals #64 API); Yau's theorem via C⁰, C² and Calabi C³ estimates; Aubin–Yau; Ricci-flat metrics with SU(n) holonomy, CY examples (Annals #76 API); Futaki, Matsushima; extremal metrics; Calabi ansatz; Abreu's equation; Kähler cuts; hyperkähler triples. Statements: Bogomolov decomposition, Mori–Siu–Yau.
- *Prereqs:* KahlerManifoldsAndHodgeTheory (AG proposal); GlobalAnalysisOnManifolds/EllipticOperators; ConnectionsAndCharacteristicClasses; ComplexManifolds (#279). *Serves:* Annals 3 (#64, #76, #91); OpenAI 8 (#041, #062, #338, #341, #343, #347, #352, #359). *Port:* OAI Geometry/PrescribedRicci; OAI Geometry/Kahler, KahlerSplitting. *Formalizability:* medium-high; Calabi's C³ route avoids Evans–Krylov.

**MetricGeometry** (math.MG, L ~250, wave A). This roadmap develops the geometry of metric spaces through lengths, curvature comparison and convergence: length and geodesic spaces, metric Hopf–Rinow, model spaces, comparison triangles and Alexandrov angles, pointed and measured Gromov–Hausdorff convergence with Gromov's precompactness, ultralimits and asymptotic cones, metric cones, and Alexandrov spaces of curvature bounded below through Toponogov globalization and Burago–Gromov–Perelman. It consumes Mathlib's Gromov–Hausdorff space and extends OptimalTransport Layer 8's CBB(κ) predicate. CAT(κ) spaces are the algebra campaign's NonpositiveCurvature, which consumes the comparison layer here; RCD spaces stay with OptimalTransport Layer 14.
- *Milestones:* Hopf–Rinow–Cohn-Vossen; laws of cosines in M²_κ; angles, first variation; cones and joins; Gromov precompactness; mGH, GHP; asymptotic cones; Riemannian rescalings converge to ℝⁿ (Annals #75 API); Toponogov globalization; Bishop–Gromov for CBB; BGP dimension and tangent cones. Statement: Perelman stability.
- *Prereqs:* Mathlib GromovHausdorff; Tau Ceti length-space code; OptimalTransport L8; HopfRinow (normal coordinates). *Serves:* Annals 1 (#75); OpenAI 4 (#211, #337, #356, #357). *Port:* OAI Geometry/RCD, CAT0Fillings; Burago–Burago–Ivanov. *Formalizability:* high.

**MetricEmbeddings** (math.MG, L ~200, wave A). This roadmap studies bi-Lipschitz, coarse and quasisymmetric embeddings of metric spaces: distortion, Lipschitz extension, Fréchet, Bourgain and Johnson–Lindenstrauss, L₁ as the cut cone and negative type, Poincaré inequalities as obstructions (Enflo, expanders, Brinkman–Charikar), doubling spaces and Assouad, coarse embeddings, and quasisymmetric maps with conformal dimension and combinatorial modulus. It consumes Mathlib's L^p spaces and GraphConnectivityAndFlows (#444). LP/SDP relaxations and rounding are the logic-and-computation campaign's, Banach-space invariants (type, cotype, Ribe, Markov type) FAMP's; both consume this roadmap.
- *Milestones:* Kirszbraun, McShane; Fréchet; Bourgain; JL; ℓ₁ = cut cone; flow–cut gap; expander lower bounds; Enflo; Brinkman–Charikar; Assouad; coarse non-embeddability; Tukia–Väisälä, modulus. Statements: Cheeger–Kleiner, Bonk–Kleiner, Cannon's conjecture.
- *Prereqs:* Mathlib L^p, SimpleGraph; GraphConnectivityAndFlows (#444) and PlanarTopology (#271), for the flow–cut and planar layers only. *Serves:* OpenAI 8 (#089, #094, #098, #099, #110, #117, #246, #307). *Port:* OAI Combinatorics/PlanarL1, TreewidthL1, EditDistance; OAI Analysis/LpDimension; OAI Geometry/DoublingHilbert, Cannon. *Formalizability:* high (Matoušek ch. 15; Heinonen).

**ConvexBodies** (math.MG, L ~250, wave A). This roadmap builds the Brunn–Minkowski theory of convex bodies in Euclidean space: support functions, mixed volumes and the Steiner formula, the Brunn–Minkowski, Minkowski and Aleksandrov–Fenchel inequalities with equality cases, the Minkowski problem, polarity and Blaschke–Santaló, projection and centroid bodies with the cosine transform, symmetrization, the affine invariants (John ellipsoid, isotropic position, affine surface area) and the L_p theory. It consumes Mathlib's ConvexBody and shares Brunn–Minkowski and Prékopa–Leindler with ArithmeticHeights (#287) C.3. Log-concave measures are the probability campaign's, packings PackingCoveringAndEnergy's, Monge–Ampère regularity OptimalTransport Layer 6's.
- *Milestones:* Steiner; Brunn–Minkowski equality; Minkowski inequalities; Aleksandrov–Fenchel; Minkowski problem; Cauchy formula; cosine-transform injectivity; Blaschke–Santaló; planar Mahler; Petty, Busemann–Petty; John, Löwner; affine isoperimetric inequality, affine normal; L_p Brunn–Minkowski–Firey. Statements: Mahler, log-BM, slicing.
- *Prereqs:* Mathlib Analysis/Convex/Body; ArithmeticHeights (#287) C.3 if merged first, else proved here and aliased there; OptimalTransport L6. *Serves:* OpenAI 5 (#087, #088, #091, #101, #353). *Port:* OAI Analysis/Mahler; OAI Geometry/Convex/GeneralMahler, ProjectionBodies, LogVolume, Zonotope. *Formalizability:* high (Schneider).

**PackingCoveringAndEnergy** (math.MG, L ~180, wave B). This roadmap studies packings, coverings and point energies: packing and covering densities of convex bodies, the geometric invariants of positive-definite lattices (covering radius, Voronoi cells, Hermite constant, kissing configurations, well-roundedness), Voronoi's perfect and eutactic forms, spherical codes and designs with Delsarte's bounds and Venkov's theorem, Minkowski–Hlawka, Rogers' bound, the Cohn–Elkies bound and energies for completely monotone, Coulomb and Riesz potentials. It consumes IntegralLattices, ThetaSeries (#286), Mathlib Fourier analysis and ConvexBodies. Arithmetic of quadratic forms stays with IntegralLattices; Viazovska's theorems are stated.
- *Milestones:* periodic packings suffice; Thue, Fejes Tóth; Hermite constants; Voronoi's theorem; Delsarte, kissing numbers 8 and 24; Venkov; Minkowski–Hlawka; Rogers; Cohn–Elkies; Cohn–Kumar framework. Statements: Viazovska, universal optimality.
- *Prereqs:* IntegralLattices; ThetaSeries (#286); ConvexBodies. *Serves:* OpenAI 2 (#090, #092); LMFDB 1 (lattice). *Port:* OAI Analysis/Triangular, PlanarPacking; OAI Geometry/LatticeCovering, TranslativeCovering; sphere-packing project. *Formalizability:* high; certificates need interval arithmetic.

## 4. Needs not absorbed

90 of the 97 gap needs map to the slate. The other seven, and the parts of absorbed needs that stay out:

- **Owned by AG (KahlerManifoldsAndHodgeTheory)**, by BOUNDARIES ("Kähler manifolds and Hodge theory"): OAI 041,
  050, 051, 052, 057, 068 — Hermitian and Kähler metrics on holomorphic bundles, Chern connection, Griffiths and
  Nakano positivity. Tagged math.DG in phase 1; KahlerGeometry consumes them.
- **Owned by ALG (NonpositiveCurvature):** OAI 358 flat torus and solvable subgroup theorems; the CAT(κ) half of
  OAI 337 (MetricGeometry supplies triangles and angles, ComparisonGeometry the Riemannian bridge).
- **Owned by ANA:** objects of GMT for OAI 336, 337, 354 (finite perimeter, currents, isoperimetric existence);
  MinimalSubmanifolds supplies only their regularity. Allen–Cahn and Savin (OAI 375) are ANA's NonlinearEllipticPDE.
- **Owned by NT:** the arithmetic part of LMFDB P21 (universality, 15 and 290 theorems, Festi–Veniani tensor index)
  stays with IntegralLattices; thick–thin for non-arithmetic lattices (Annals #77) goes to ALG's lattices.
- **Frontier proofs** (statements absorbed): μ-bubble descent (335, 336), noncompact Kähler–Ricci flow (338),
  entropy rigidity (339, PRDS), parametrized h-cobordism (340, TOP), hypersymplectic flow (341), loop-space
  resonance (345), Almgren–De Lellis–Spadaro (346), min–max (349), Ricci-flow singularities (351), Bamler–Kleiner
  (355), second-order RCD calculus (356, 357), instanton Floer theory (306).

## 5. Cross-campaign interface

**Imports.** ANA: PDE, GeometricMeasureTheory (objects, compactness), parabolic PDE, OptimalTransport
L6/L7/L8/L14, PositiveCurrentsAndMongeAmpere, ComplexManifolds #279, spherical harmonics if planned (else
ConvexBodies builds the Funk–Hecke slice it needs). AG: KahlerManifoldsAndHodgeTheory (Kähler
condition, Chern connection, Ricci form, ∂∂̄), StableReduction (dual graphs), stable bundles. ALG: LieGroups,
OrthogonalSpinGroups (Clifford algebras, spin groups). TOP: AlgebraicTopology, UniversalCovers, GeometricTopology
L7, HeegaardFloer. NT: IntegralLattices, ThetaSeries #286, ArithmeticHeights #287. COMB: GraphConnectivityAndFlows
#444. FAMP: nothing (Tau Ceti's compact self-adjoint spectral theory suffices).

**Exports.** AG: EllipticOperators (Hodge theorem, Dolbeault complex), Connections (Chern–Weil), KahlerGeometry
(Calabi–Yau and KE metrics), Dirac (Riemann–Roch–Hirzebruch), PseudoholomorphicCurves (symplectic GW).
ANA: EllipticOperators (boundary problems and the DN map, OAI 365), MinimalSubmanifolds (CMC and isoperimetric
regularity), LorentzianGeometry (for EinsteinEvolutionEquations). ALG: SymmetricSpaces (G/K for lattices),
MetricGeometry (triangles, angles, asymptotic cones), ComparisonGeometry ("sec ≤ κ ⇒ locally CAT(κ)", Milnor).
TOP: SymmetricSpaces (ℍⁿ for HyperbolicManifolds), GeometricFlows (geometrization statement), Dirac and
GaugeTheory (Rokhlin, Donaldson for FourManifoldTopology), ContactGeometry (Legendrian knots). PRDS:
ComparisonGeometry and VariationalTheoryOfGeodesics (Jacobi fields, geodesic flow for SmoothErgodicTheory),
SymplecticManifolds (Liouville–Arnold), ConvexBodies (LogConcaveMeasures), MetricGeometry (GHP). LTCS and FAMP: MetricEmbeddings.
NT: SymmetricSpaces (ALS), PackingCoveringAndEnergy (LMFDB `lattice`), ConvexBodies (geometry of numbers).

## 6. Order and people

**First five to draft** (demand × unblocking; the WIP cap allows three at once):

1. **GlobalAnalysisOnManifolds/EllipticOperators** (with the umbrella). The gap both reports name. Direct: OAI
   341, 342, 348, 365, Annals #86; unblocks five GAM siblings, KahlerGeometry, AG's Hodge theory. Wave A.
2. **RiemannianGeometry** umbrella with **CurvatureAndSubmanifolds** and **ComparisonGeometry**. Annals #62 (13
   papers), #68, #75; OAI 10 families; unblocks four siblings and ALG's CAT(κ) bridge; RG.0–RG.4 is a head start.
3. **ConnectionsAndCharacteristicClasses**. Annals #79 (feeds #64, #76); OAI 062, 306, 341, 348; small footprint;
   unblocks Dirac, GaugeTheory, SymmetricSpaces and AG's Chern–Weil.
4. **SymplecticAndContactGeometry** umbrella with **ContactGeometry** (wave A) and **SymplecticManifolds** (once
   #480 merges). Annals #69, #73, #80, #83 (25 papers); OAI 087, 340, 343, 347.
5. **ConvexBodies**. OAI 087, 088, 091, 092, 101, 353; no GEO prerequisite, a separate reviewer pool; unblocks
   Packing and PRDS's LogConcaveMeasures. MetricEmbeddings (8 OAI families) is sixth.

**Expertise.** Lead: a geometric analyst (Riemannian geometry, elliptic PDE) fluent in Mathlib's manifold API.
Reviewers: a symplectic topologist, a convex/metric geometer, a Kähler geometer, a relativist, a minimal-surface
analyst. Coordinate first with Mathlib's Riemannian-metric authors, sphere-eversion, the sphere-packing project, and
the OptimalTransport and HeegaardFloer authors.

**Open questions for the owner.**

1. *CAT(κ).* Planned as decided (ALG), but CAT(κ) metric theory (Bridson–Haefliger II.1–5) is math.MG and shares
   its comparison layer with Alexandrov spaces; alternative: MetricGeometry owns it, ALG keeps group actions.
2. *MetricEmbeddings.* BOUNDARIES puts "metric embeddings and convex relaxations (as algorithms)" in LTCS. This
   slate reads "as algorithms" literally: the embedding theory (OAI tags all eight families math.MG) is GEO's,
   rounding algorithms LTCS's, Banach invariants FAMP's. Needs the LTCS and FAMP leads' agreement.
3. *Kähler split.* With the Kähler condition, Ricci form and Chern connection in AG, KahlerGeometry (Annals #64,
   #76, #91: 22 papers) is wave C behind AG's roadmap, which itself waits on EllipticOperators. Alternative: move
   "Kähler metrics, potentials, Ricci form, Fubini–Study" into KahlerGeometry, making it wave B.
4. *GMT boundary.* ANA's GMT proposals list the Simons cone, Bernstein and Allard regularity; this slate takes all
   regularity (Allard, ε-regularity, dimension reduction, isoperimetric/CMC) into MinimalSubmanifolds and leaves ANA
   the objects. Confirm with the ANA lead.
5. Is an umbrella family one review unit? The PR estimates assume yes (10 reviews for 23 roadmaps).
6. GaugeTheory has thin direct demand (one frontier OAI family plus AG/TOP interfaces). Keep it in the slate as
   wave C (as here) or defer it.

## 7. Totals

| | count | PRs |
|---|---:|---:|
| XL families (umbrellas) | 3 (RiemannianGeometry 1,050; GlobalAnalysisOnManifolds 1,470; SymplecticAndContactGeometry 930) | 3,450 |
| standalone L | 7 | 1,530 |
| all roadmaps (sub-roadmaps counted) | 23: 21 L, 2 M; waves A 8, B 11, C 4 | **≈ 4,980** |
| review units | 10 (3 umbrellas + 7 standalones) | |

Existing supply in GEO territory, as remaining PRs by size class: DifferentialGeometry ≈ 250, HeegaardFloer
≈ 200 (F1–F4), DGFloer #655 ≈ 250, HamiltonianSystems #480 ≈ 100, HopfRinow 0 (done), #334 0 (superseded): about
**800**, all of it foundations that the slate consumes. Geometry layers inside OptimalTransport (ANA) and
GeometricTopology L7 (TOP) are counted by their campaigns.
