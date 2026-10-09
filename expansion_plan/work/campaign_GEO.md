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

## 8. References by roadmap

26 roadmap records, 289 listings, 234 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_GEO.json` and the `references` fields of `slate_GEO.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (185 of 234: zbMATH stopped early; see master (d)). Pointers are the compilers' and are unverified.

**Conventions and notes.** Curvature as Tau Ceti/Lee: R(X,Y)Z = ∇_X∇_Y Z − ∇_Y∇_X Z − ∇_[X,Y]Z, sec(u,v) = ⟨R(u,v)v,u⟩/|u∧v|², Ric(u,v) = tr(w ↦ R(w,u)v); do Carmo, Gallot–Hulin–Lafontaine, Milnor and O'Neill use −R. Δ = div ∘ grad ≤ 0 (DifferentialGeometry, Mathlib, PDE), spectra of −Δ; Warner, Lawson–Michelsohn and Berline–Getzler–Vergne use nonnegative Laplacians. H = tr_g II (Lee divides by n). ι_{X_H}ω = dH, ω_can = −dλ_can, g = ω(·, J·) (#480, #655, Tau Ceti). Lorentzian signature (−,+,…,+). Kähler ω = g(J·,·). No GEO book is held in full locally; some Tau Ceti READMEs hold extracts only.

**RiemannianGeometry** (umbrella, wave A)
- primary: Lee 2018, *Riemannian Manifolds*, Chs. 4–5 (?); Petersen 2016, *Riemannian Geometry*, Chs. 3–4, Chs. 6–7, 12, Ch. 10 (?); do Carmo 1992, *Riemannian Geometry*, Ch. 5, Ch. 6, Ch. 9 (?)
- conventions: Tau Ceti `Geometry/Manifold/VectorBundle/CovariantDerivative/Curv…`; Tau Ceti 2026, *RiemannianGeometry blueprint draft…*; Tau Ceti 2026, *DifferentialGeometry roadmap…*
- formal: Tau Ceti 2026, *HopfRinow roadmap (Levi-Civita…*, Ch. 7 §2, Ch. 9 §2; Tau Ceti `Geometry/Manifold/Riemannian`; Mathlib `Geometry/Manifold/VectorBundle/{Riemannian, …}`

**RiemannianGeometry/CurvatureAndSubmanifolds** (wave A)
- primary: Lee 2018, *Riemannian Manifolds*, Ch. 7, Ch. 8, Ch. 9 (?); Petersen 2016, *Riemannian Geometry*, Chs. 3–4 (?); Besse 1987, *Einstein Manifolds*, Ch. 1 (?)
- conventions: Tau Ceti `Geometry/Manifold/VectorBundle/CovariantDerivative/Curv…`
- theorem: do Carmo 1976, *Differential Geometry of Curves and…* (?); Milnor 1976, *Curvatures of left invariant metrics on…* (?)
- formal: Tau Ceti `Geometry/Manifold/VectorBundle/CovariantDerivative`; OAI `lean/OAI` (release tree)

**RiemannianGeometry/ComparisonGeometry** (wave A)
- primary: Petersen 2016, *Riemannian Geometry*, Chs. 6–7 and 12 (?); Lee 2018, *Riemannian Manifolds*, Chs. 10–12 (?); Cheeger–Ebin 1975, *Comparison Theorems in Riemannian…*, Ch. 1, Ch. 2, Ch. 8 (?); Ballmann 2016, *Riccati Equation and Volume Estimates*, Lemma 3.3, §5, Cor. 5.4
- conventions: Tau Ceti 2026, *RiemannianGeometry blueprint draft…*; Tau Ceti 2026, *OptimalTransport roadmap (L6…*
- statement: Cheeger–Gromoll 1972, *Structure of complete manifolds of…* (?); Brendle–Schoen 2009, *Manifolds with 1/4-pinched curvature…* (?)
- formal: OAI `lean/OAI` (release tree)

**RiemannianGeometry/SymmetricSpaces** (wave B)
- primary: Helgason 1978, *Differential Geometry, Lie Groups, and…*, Chs. IV–VII, Ch. X (?); Eberlein 1996, *Geometry of Nonpositively Curved…* (?); Petersen 2016, *Riemannian Geometry*, Ch. 10 (?)
- conventions: Knapp 2002, *Lie Groups Beyond an Introduction* (?)
- theorem: Kobayashi–Nomizu 1969, *Foundations of Differential Geometry… II*, Vol. II, Ch. XI (?); Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature* (?)
- formal: Tau Ceti 2026, *RepresentationTheory/LieGroups roadmap…*; Tau Ceti `Geometry/Manifold/Riemannian`

**RiemannianGeometry/VariationalTheoryOfGeodesics** (wave B)
- primary: Milnor 1963, *Morse Theory*, Part III, Part IV (?); Klingenberg 1978, *Closed Geodesics* (?); Besse 1978, *Manifolds All of Whose Geodesics Are…* (?); Ballmann 2015, *Critical Point Theory of the Energy…*, Prop. 3.7, §6, Cor. 6.5 (?)
- conventions: Tau Ceti 2026, *HamiltonianSystems roadmap, open PR…*
- theorem: Paternain 1999, *Geodesic Flows* (?)
- statement: Grayson 1989, *Shortening embedded curves* (?); Gromoll–Meyer 1969, *Periodic geodesics on compact…* (?); Bangert 1993, *Existence of closed geodesics on…* (?); Franks 1992, *Geodesics on S² and periodic points of…* (?)
- formal: Tau Ceti `Geometry/Manifold/Morse`

**RiemannianGeometry/RicciCurvatureAndLimitSpaces** (wave C)
- primary: Cheeger 2001, *Degeneration of Riemannian Metrics…* (?); Cheeger–Colding 1996, *Lower bounds on Ricci curvature and the…* (?); Cheeger–Colding 1997, *Structure of spaces with Ricci… III* (?)
- conventions: Tau Ceti 2026, *OptimalTransport roadmap (L6…*
- theorem: Villani 2009, *Optimal Transport*, Ch. 29 (?)
- statement: Cheeger–Naber 2015, *Regularity of Einstein manifolds and…* (?); Cheeger–Jiang–Naber 2021, *Rectifiability of singular sets of…* (?); De Philippis–Gigli 2018, *Non-collapsed spaces with Ricci…* (?)
- formal: OAI `lean/OAI` (release tree)

**RiemannianGeometry/IsometricEmbeddings** (wave B)
- primary: Han–Hong 2006, *Isometric Embedding of Riemannian…* (?); Eliashberg–Mishachev 2002, *H-Principle* (?); Gromov 1986, *Partial Differential Relations* (?)
- theorem: Conti–De Lellis–Székelyhidi 2012, *h-principle and rigidity for C^{1,α}…* (?); Günther 1989, *Zum Einbettungssatz von J. Nash* (?); do Carmo 1976, *Differential Geometry of Curves and…*, §5 (?)
- statement: Nirenberg 1953, *Weyl and Minkowski problems in…* (?)
- formal: `leanprover-community/sphere-eversion`; Massot–van Doorn–Nash 2023, *Formalising the h-principle and sphere…* (?); OAI `lean/OAI` (release tree)

**GlobalAnalysisOnManifolds** (umbrella, wave A)
- primary: Taylor 2011, *Partial Differential Equations I*, Ch. 4, Ch. 5 (?); Nicolaescu 2021, *Geometry of Manifolds* (?); Aubin 1998, *Some Nonlinear Problems in Riemannian…* (?)
- conventions: Tau Ceti 2026, *DifferentialGeometry roadmap…*; Tau Ceti 2026, *PDE roadmap (Δ sign and 2π…*; Warner 1983, *Foundations of Differentiable Manifolds…* (?)
- formal: Tau Ceti `Analysis/Sobolev`

**GlobalAnalysisOnManifolds/EllipticOperators** (wave A)
- primary: Taylor 2011, *Partial Differential Equations I*, Ch. 4, Ch. 5 (?); Warner 1983, *Foundations of Differentiable Manifolds…*, Ch. 6 (?); Lawson–Michelsohn 1989, *Spin Geometry*, Ch. III (?)
- conventions: Tau Ceti 2026, *DifferentialGeometry roadmap…*; Tau Ceti 2026, *PDE roadmap (Δ sign and 2π…*
- theorem: Gilbarg–Trudinger 2001, *Elliptic Partial Differential Equations…*, Ch. 6, Ch. 9 (?); Schwarz 1995, *Hodge Decomposition — A Method for…* (?); Petersen 2016, *Riemannian Geometry*, Ch. 9 (?); Aronszajn 1957, *Unique continuation theorem for…* (?); Lee–Uhlmann 1989, *Determining anisotropic real-analytic…* (?)
- formal: Tau Ceti `Analysis/Sobolev`; `abenenson/rellich-kondrachov`; OAI `lean/OAI` (release tree)

**GlobalAnalysisOnManifolds/SpectralGeometry** (wave B)
- primary: Chavel 1984, *Eigenvalues in Riemannian Geometry* (?); Berger–Gauduchon–Mazet 1971, *Le spectre d'une variété riemannienne* (?); Schoen–Yau 1994, *Differential Geometry* (?); Li 2012, *Geometric Analysis* (?)
- theorem: Sunada 1985, *Riemannian coverings and isospectral…* (?); Brüning 1978, *Über Knoten von Eigenfunktionen des…* (?)
- statement: Donnelly–Fefferman 1988, *Nodal sets of eigenfunctions on…* (?); Logunov 2018, *Nodal sets of Laplace eigenfunctions* (?); Colding–Minicozzi 1997, *Harmonic functions on manifolds* (?)
- formal: OAI `lean/OAI` (release tree)

**GlobalAnalysisOnManifolds/DiracOperatorsAndIndexTheory** (wave B)
- primary: Berline–Getzler–Vergne 1992, *Heat Kernels and Dirac Operators* (?); Lawson–Michelsohn 1989, *Spin Geometry*, Chs. I–IV (?); Roe 1998, *Elliptic Operators, Topology and…* (?)
- conventions: Tau Ceti 2026, *OrthogonalSpinGroups roadmap (Clifford…*
- theorem: Gilkey 1995, *Invariance Theory, the Heat Equation…* (?); Hitchin 1974, *Compact four-dimensional Einstein…* (?)
- statement: Atiyah–Singer 1968, *Index of elliptic operators I, III* (?); Gromov–Lawson 1980, *Classification of simply connected…* (?); Atiyah–Singer 1971, *Index of elliptic operators IV* (?)
- formal: Mathlib `LinearAlgebra/CliffordAlgebra`

**GlobalAnalysisOnManifolds/MinimalSubmanifolds** (wave B)
- primary: Colding–Minicozzi 2011, *Minimal Surfaces* (?); Simon 1983, *Geometric Measure Theory* (?); Giusti 1984, *Minimal Surfaces and Functions of…* (?); Maggi 2012, *Sets of Finite Perimeter and Geometric…* (?)
- conventions: Lee 2018, *Riemannian Manifolds*, Ch. 8 (?)
- theorem: Harvey–Lawson 1982, *Calibrated geometries* (?); Urbano 1990, *Minimal surfaces with low index in the…* (?); Schoen–Yau 1979, *Structure of manifolds with positive…* (?); Gromov 2018, *Metric inequalities with scalar…* (?)
- statement: Chodosh–Li 2024, *Stable minimal hypersurfaces in R⁴* (?); Pitts 1981, *Existence and Regularity of Minimal…* (?); Marques–Neves 2014, *Min-max theory and the Willmore…* (?)
- formal: OAI `lean/OAI` (release tree)

**GlobalAnalysisOnManifolds/GeometricFlows** (wave C)
- primary: Chow–Knopf 2004, *Ricci Flow* (?); Topping 2006, *Ricci Flow* (?); Mantegazza 2011, *Mean Curvature Flow* (?)
- theorem: Brakke 1978, *Motion of a Surface by Its Mean…* (?); Eells–Sampson 1964, *Harmonic mappings of Riemannian…* (?); Cao 1985, *Deformation of Kähler metrics to…* (?); Chen–He 2008, *Calabi flow* (?)
- statement: Perelman 2003, *Ricci flow with surgery on…*; Morgan–Tian 2007, *Ricci Flow and the Poincaré Conjecture*; Bamler–Kleiner 2022, *Uniqueness and stability of Ricci flow…* (?); Colding–Minicozzi 2012, *Generic mean curvature flow I* (?)

**GlobalAnalysisOnManifolds/GaugeTheory** (wave C)
- primary: Donaldson–Kronheimer 1990, *Geometry of Four-Manifolds* (?); Freed–Uhlenbeck 1991, *Instantons and Four-Manifolds* (?); Morgan 1996, *Seiberg–Witten Equations and…* (?); Wehrheim 2004, *Uhlenbeck Compactness* (?)
- theorem: Uhlenbeck–Yau 1986, *Existence of Hermitian–Yang–Mills…* (?); Hitchin 1987, *Self-duality equations on a Riemann…* (?)
- statement: Floer 1988, *Instanton-invariant for 3-manifolds* (?); Donaldson 1990, *Polynomial invariants for smooth…* (?); Kronheimer–Mrowka 2007, *Monopoles and Three-Manifolds* (?)

**SymplecticAndContactGeometry** (umbrella, wave A)
- primary: McDuff–Salamon 2017, *Symplectic Topology*; McDuff–Salamon 2012, *J-holomorphic Curves and Symplectic…* (?); Cannas da Silva 2001, *Symplectic Geometry* (?); Geiges 2008, *Contact Topology* (?)
- conventions: Tau Ceti 2026, *HamiltonianSystems roadmap, open PR…*; Tau Ceti 2026, *DGFloer roadmap, open PR #655 (sign…*; Tau Ceti `Geometry/Symplectic`; Tau Ceti 2026, *SymplecticContactGeometry blueprint…*
- formal: Tau Ceti 2026, *HeegaardFloer roadmap (Lanes M, F0–F3*

**SymplecticAndContactGeometry/SymplecticManifolds** (wave B)
- primary: McDuff–Salamon 2017, *Symplectic Topology*, Ch. 3, Ch. 5, Ch. 7; Cannas da Silva 2001, *Symplectic Geometry*, §§18 (?); Audin 2004, *Torus Actions on Symplectic Manifolds* (?)
- conventions: Tau Ceti 2026, *SymplecticContactGeometry blueprint…*; Tau Ceti 2026, *HamiltonianSystems roadmap, open PR…*
- theorem: Delzant 1988, *Hamiltoniens périodiques et images…*, Thm 2.1, Prop. 4.1; Lerman 1995, *Symplectic cuts* (?); Arnold 1989, *Mathematical Methods of Classical…* (?); Gutt–Hutchings 2018, *Symplectic capacities from positive…* (?)
- formal: OAI `lean/OAI` (release tree)

**SymplecticAndContactGeometry/ContactGeometry** (wave A)
- primary: Geiges 2008, *Contact Topology*, Ch. 2, Ch. 3, Ch. 4 (?); Geiges 2006, *Contact geometry*, §2.1, Thm 2.20; Ozbagci–Stipsicz 2004, *Surgery on Contact 3-Manifolds and…* (?)
- conventions: Tau Ceti 2026, *SymplecticContactGeometry blueprint…*
- theorem: Etnyre 2005, *Legendrian and transversal knots* (?); Cieliebak–Eliashberg 2012, *From Stein to Weinstein and Back* (?)
- statement: Eliashberg 1989, *Classification of overtwisted contact…* (?); Gromov 1985, *Pseudoholomorphic curves in symplectic…* (?); Giroux 2002, *Géométrie de contact* (?); Taubes 2007, *Seiberg–Witten equations and the…* (?); Borman–Eliashberg–Murphy 2015, *Existence and classification of…* (?)
- formal: Tau Ceti `Geometry/Manifold/Distribution`; Tau Ceti 2026, *DGFloer roadmap, open PR #655 (sign…*

**SymplecticAndContactGeometry/PseudoholomorphicCurves** (wave B)
- primary: McDuff–Salamon 2012, *J-holomorphic Curves and Symplectic…*, Ch. 2, Ch. 3, Ch. 4 (?); Wendl 2010, *Holomorphic Curves in Symplectic and…* (?); Audin–Lafontaine 1994, *Holomorphic Curves in Symplectic…* (?)
- conventions: Tau Ceti `Geometry/Symplectic`
- statement: McDuff 1990, *Structure of rational and ruled…* (?)
- formal: Tau Ceti 2026, *HeegaardFloer roadmap (Lanes M, F0–F3*; `t4v1/damian_formalizare`

**SymplecticAndContactGeometry/FloerTheoryAndSymplecticRigidity** (wave B)
- primary: McDuff–Salamon 2017, *Symplectic Topology*, Ch. 9, Ch. 10, Ch. 11; McDuff–Salamon 2012, *J-holomorphic Curves and Symplectic…*, Ch. 8, Ch. 12 (?); Hofer–Zehnder 1994, *Symplectic Invariants and Hamiltonian…* (?); Polterovich 2001, *Geometry of the Group of Symplectic…* (?)
- conventions: Tau Ceti 2026, *DGFloer roadmap, open PR #655 (sign…*
- theorem: Schwarz 2000, *Action spectrum for closed…* (?); Oh 2005, *Construction of spectral invariants of…* (?); Rudyak–Oprea 1999, *Lusternik–Schnirelmann category of…* (?); Viterbo 1992, *Symplectic topology as the geometry of…* (?); Laudenbach–Sikorav 1985, *Persistance d'intersection avec la…* (?)
- statement: Abouzaid 2012, *Nearby Lagrangians with vanishing…* (?); Kragh 2013, *Parametrized ring-spectra and the…* (?); OpenAI 2026, *Counterexample to the nearby Lagrangian…* (OAI#340); McDuff–Polterovich 1994, *Symplectic packings and algebraic…* (?); OpenAI 2026, *Symplectic Ball Packings in Higher…* (OAI#343); Hutchings 2014, *Embedded contact homology* (?)
- formal: OAI `lean/OAI` (release tree)

**ConnectionsAndCharacteristicClasses** (wave A)
- primary: Kobayashi–Nomizu 1963, *Foundations of Differential Geometry… I*, Vol. I, Chs. II–III, Ch. IV (?); Kobayashi–Nomizu 1969, *Foundations of Differential Geometry… II*, Vol. II, Ch. XII (?); Tu 2017, *Differential Geometry* (?)
- conventions: Tau Ceti `Geometry/Manifold/VectorBundle/CovariantDerivative`
- theorem: Milnor–Stasheff 1974, *Characteristic Classes*, Appendix C (?); Bott–Tu 1982, *Differential Forms in Algebraic Topology* (?); Chern–Simons 1974, *Characteristic forms and geometric…* (?); Belavin et al. 1975, *Pseudoparticle solutions of the…* (?); Joyce 2007, *Riemannian Holonomy Groups and…* (?)
- statement: Berger 1955, *Sur les groupes d'holonomie homogène…* (?)
- formal: Tau Ceti 2026, *DifferentialGeometry roadmap…*, §10; `urkud/DeRhamCohomology`

**LorentzianGeometry** (wave B)
- primary: O'Neill 1983, *Semi-Riemannian Geometry with…*, Ch. 14 (?); Beem–Ehrlich–Easley 1996, *Global Lorentzian Geometry* (?); Hawking–Ellis 1973, *Large Scale Structure of Space-Time* (?); Wald 1984, *General Relativity* (?)
- conventions: Tau Ceti `Geometry/Manifold/VectorBundle/CovariantDerivative/Curv…`
- theorem: Minguzzi 2019, *Lorentzian causality theory* (?); Choquet-Bruhat 2009, *General Relativity and the Einstein…* (?); Bernal–Sánchez 2003, *Smooth Cauchy hypersurfaces and…* (?); Bernal–Sánchez 2007, *Globally hyperbolic spacetimes can be…* (?); Bartnik 1986, *Mass of an asymptotically flat manifold* (?)
- statement: Schoen–Yau 1979, *Proof of the positive mass conjecture…* (?); Huisken–Ilmanen 2001, *Inverse mean curvature flow and the…* (?); OpenAI 2026, *Spacetime Penrose inequality and…* (OAI#260); Choquet-Bruhat–Geroch 1969, *Global aspects of the Cauchy problem in…* (?)
- formal: OAI `lean/OAI` (release tree)

**KahlerGeometry** (wave C)
- primary: Székelyhidi 2014, *Extremal Kähler Metrics* (?); Tian 2000, *Canonical Metrics in Kähler Geometry* (?); Ballmann 2006, *Kähler Manifolds* (?); Joyce 2007, *Riemannian Holonomy Groups and…* (?)
- conventions: Huybrechts 2005, *Complex Geometry* (?)
- theorem: Hitchin et al. 1987, *Hyperkähler metrics and supersymmetry* (?); Lu 1968, *Holomorphic mappings of complex…* (?)
- statement: Beauville 1983, *Variétés kähleriennes dont la première…* (?); Mori 1979, *Projective manifolds with ample tangent…* (?); Siu–Yau 1980, *Compact Kähler manifolds of positive…* (?)
- formal: Tau Ceti 2026, *ComplexManifolds roadmap, open PR #279…*; OAI `lean/OAI` (release tree)

**MetricGeometry** (wave A)
- primary: Burago–Burago–Ivanov 2001, *Metric Geometry* (?); Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature*, Part I, Part II (?); Alexander–Kapovitch–Petrunin 2024, *Alexandrov Geometry* (?)
- conventions: Tau Ceti 2026, *OptimalTransport roadmap (L6…*
- theorem: Burago–Gromov–Perelman 1992, *A. D. Alexandrov spaces with curvature…* (?); van den Dries–Wilkie 1984, *Gromov's theorem on groups of…* (?); Sturm 2006, *Geometry of metric measure spaces I*
- statement: Kapovitch 2007, *Perelman's stability theorem* (?)
- formal: Mathlib `Topology/MetricSpace/GromovHausdorff`; Tau Ceti `Geometry/Manifold/Riemannian`; OAI `lean/OAI` (release tree)

**MetricEmbeddings** (wave A)
- primary: Matoušek 2002, *Discrete Geometry*, Ch. 15 (?); Ostrovskii 2013, *Metric Embeddings* (?); Heinonen 2001, *Analysis on Metric Spaces* (?); Deza–Laurent 1997, *Geometry of Cuts and Metrics* (?)
- theorem: Benyamini–Lindenstrauss 2000, *Geometric Nonlinear Functional…* (?); Brinkman–Charikar 2005, *Impossibility of dimension reduction in…* (?); Dranishnikov et al. 2002, *Uniform embeddings into Hilbert space…* (?)
- statement: Gupta et al. 2004, *Cuts, trees and ℓ₁-embeddings of graphs* (?); Cheeger–Kleiner 2010, *Differentiating maps into L¹, and the…* (?); Bonk–Kleiner 2005, *Conformal dimension and Gromov…* (?); OpenAI 2026, *Modulus Proof of Cannon's Conjecture* (OAI#246)
- formal: Mathlib `Topology/MetricSpace/Lipschitz`; OAI `lean/OAI` (release tree)

**ConvexBodies** (wave A)
- primary: Schneider 2014, *Convex Bodies*, Ch. 4, Ch. 5, Ch. 7 (?); Gardner 2006, *Geometric Tomography* (?); Artstein-Avidan et al. 2015, *Asymptotic Geometric Analysis, Part I* (?)
- conventions: Tau Ceti 2026, *ArithmeticHeights roadmap, open PR #287…*
- theorem: Bombieri–Gubler 2006, *Heights in Diophantine Geometry*, App. C.3; Shenfeld–van Handel 2023, *Extremals of the Alexandrov–Fenchel…* (?); Cheng–Yau 1976, *Regularity of the solution of the…* (?); Brazitikos et al. 2014, *Geometry of Isotropic Convex Bodies* (?)
- statement: Bourgain–Milman 1987, *New volume ratio properties for convex…* (?); Iriyeh–Shibata 2020, *Symmetric Mahler's conjecture for the…* (?); OpenAI 2026, *Mahler Conjecture for General Convex…* (OAI#087); Böröczky et al. 2012, *Log-Brunn–Minkowski inequality* (?); OpenAI 2026, *Logarithmic Brunn–Minkowski conjecture* (OAI#091); Klartag–Lehec 2024, *Affirmative resolution of Bourgain's…* (?)
- formal: Mathlib `Analysis/Convex/Body`; OAI `lean/OAI` (release tree)

**PackingCoveringAndEnergy** (wave B)
- primary: Conway–Sloane 1999, *Sphere Packings, Lattices and Groups*, Chs. 1–4, Ch. 9, Ch. 13; Zong 1999, *Sphere Packings* (?); Martinet 2003, *Perfect Lattices in Euclidean Spaces* (?); Rogers 1964, *Packing and Covering* (?); Borodachov–Hardin–Saff 2019, *Discrete Energy on Rectifiable Sets* (?)
- conventions: Tau Ceti 2026, *IntegralLattices roadmap (completed*; LMFDB 2026, *L-functions and modular forms database…*
- theorem: Fejes Tóth (G. Fejes Tóth et al. 2023, *Lagerungen* (?); Venkov 2001, *Réseaux et designs sphériques* (?); Cohn–Elkies 2003, *New upper bounds on sphere packings I* (?); Cohn–Kumar 2007, *Universally optimal distribution of…* (?)
- statement: Viazovska 2017, *Sphere packing problem in dimension 8* (?); Cohn et al. 2017, *Sphere packing problem in dimension 24* (?); Cohn et al. 2022, *Universal optimality of the E₈ and…* (?)
- formal: Tau Ceti 2026, *ThetaSeries roadmap, open PR #286…*; `math-inc/Sphere-Packing-Lean`; OAI `lean/OAI` (release tree)

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Petersen 2016, *Riemannian Geometry* [5] ★; Lee 2018, *Riemannian Manifolds* [4] ★; McDuff–Salamon 2012, *J-holomorphic Curves and Symplectic…* [3] ★; McDuff–Salamon 2017, *Symplectic Topology* [3] ★; Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature* [2] ★; do Carmo 1976, *Differential Geometry of Curves and…* [2] ★; Geiges 2008, *Contact Topology* [2] ★; Joyce 2007, *Riemannian Holonomy Groups and…* [2] ★; Kobayashi–Nomizu 1969, *Foundations of Differential Geometry… II* [2] ★; Lawson–Michelsohn 1989, *Spin Geometry* [2] ★; Taylor 2011, *Partial Differential Equations I* [2] ★; Warner 1983, *Foundations of Differentiable Manifolds…* [2] ★; Artstein-Avidan et al. 2015, *Asymptotic Geometric Analysis, Part I* [1] ★; Aubin 1998, *Some Nonlinear Problems in Riemannian…* [1] ★; Benyamini–Lindenstrauss 2000, *Geometric Nonlinear Functional…* [1] ★; Besse 1987, *Einstein Manifolds* [1] ★; Bombieri–Gubler 2006, *Heights in Diophantine Geometry* [1] ★; Bott–Tu 1982, *Differential Forms in Algebraic Topology* [1] ★; Brazitikos et al. 2014, *Geometry of Isotropic Convex Bodies* [1] ★; Burago–Burago–Ivanov 2001, *Metric Geometry* [1] ★; Cheeger–Ebin 1975, *Comparison Theorems in Riemannian…* [1] ★; Cieliebak–Eliashberg 2012, *From Stein to Weinstein and Back* [1] ★; Deza–Laurent 1997, *Geometry of Cuts and Metrics* [1] ★; do Carmo 1992, *Riemannian Geometry* [1] ★; Gardner 2006, *Geometric Tomography* [1] ★; Gilbarg–Trudinger 2001, *Elliptic Partial Differential Equations…* [1] ★; Heinonen 2001, *Analysis on Metric Spaces* [1] ★; Kobayashi–Nomizu 1963, *Foundations of Differential Geometry… I* [1] ★; Matoušek 2002, *Discrete Geometry* [1] ★; Milnor–Stasheff 1974, *Characteristic Classes* [1] ★; Ostrovskii 2013, *Metric Embeddings* [1] ★; Ozbagci–Stipsicz 2004, *Surgery on Contact 3-Manifolds and…* [1] ★; Schneider 2014, *Convex Bodies* [1] ★; Schwarz 1995, *Hodge Decomposition — A Method for…* [1] ★; Tu 2017, *Differential Geometry* [1] ★.

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
