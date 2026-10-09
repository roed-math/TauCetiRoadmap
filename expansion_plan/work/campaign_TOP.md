# Campaign TOP: topology, categories, K-theory — phase-2 slate (2026-10-07)

Machine-readable slate: `slate_TOP.json` (27 roadmaps plus 2 family umbrellas whose `est_prs` is 0; the
sub-roadmaps carry the PRs).

## 1. Scope

Classes math.AT, math.GT, math.CT, math.KT, math.GN. The subject is the homotopy theory of spaces and spectra,
manifolds in low and high dimension, higher and homotopical category theory, and algebraic K-theory with its
hermitian, trace and motivic relatives. Its demand is mostly *foundational*: 12 of the 18 OpenAI Topology families
(304–321) are frontier, so the slate delivers their statements and the reusable theory beneath them.

- **Primary needs: 85.** OpenAI 74 (47 families), Annals 10 (#16, #58, #63, #67, #72, #74, #78), LMFDB 1 (hgcwa).
  By class: AT 50, GT 18, KT 13, CT 4, GN 0. By coverage: gap 39 (OpenAI 36, Annals 3), open PR 14, Tau Ceti
  roadmap 14, Birkbeck campaign 9, Tau Ceti code 7, Mathlib 2.
- **Interface needs: 84** with a TOP secondary class (ALG 39, AG 16, GEO 11, COMB 8, other 10), plus the Annals#78
  motivic need (filed under AG) that BOUNDARIES assigns to TOP.
- **Campaign supply in the territory:** 14 Birkbeck math.KT roadmaps (8 general, 6 arithmetic), EnhancedDerivedSheaves
  (math.CT) and the knot-invariant stages of ArithmeticQuantumTopology (math.GT); consolidated in §2.2.

## 2. Existing supply

### 2.1 Tau Ceti main and open PRs

Remaining-PR figures are capacity.md's estimates (floors).

| Roadmap | State | Contribution | Action |
|---|---|---|---|
| AlgebraicTopology (main, AT) | Stages 1, 3 done; 8 untouched; ≈70 left | 10 needs: OAI#151, 196, 249, 254, 310, 312, 317, 321, 345, 347; substrate of every TOP roadmap | Fleet priority on Stage 8 and the Serre spectral sequence: #437, #284, UnstableHomotopyTheory wait on them. Merge #436. |
| GeometricTopology (main, GT) | L3 done, L9 untouched; ≈260 | 12 needs: Annals#62, 63, 74; OAI#306, 333, 334, 335, 339, 345, 358, 368 (statements) | Merge #435. **Rasmussen's s:** lines 577, 602, 618, 1134 expect s from CombinatorialHeegaardFloer, which never builds it; the KhovanovHomology PR repoints them to KhovanovHomology. |
| CombinatorialHeegaardFloer (main, GT) | all lanes partial or untouched; ≈325 | 2 needs: τ for Annals#74; #80 | Leave. Commutation invariance (Lane G) is the bottleneck for τ. |
| HeegaardFloer (main, SG) | ≈290 | 11 needs (Annals#69, 74, 80, 83; OAI#087, 342, 343), mostly GEO | Leave (GEO topic); Lane M Morse homology feeds #284 and DGFloer. |
| DGAInfinity (main, CT) | L0–4 partial, 5–11 untouched; ≈410 | 1 need: Annals#58 | Extend by one layer: HKR for HH^*, DG enhancements (Lunts–Orlov stated, the Rizzardo–Van den Bergh–Neeman non-enhanceable example), semi-orthogonal decompositions. TraceMethods consumes its Hochschild complex. |
| GrothendieckEulerForms (main, RT) | L0–2, 7 done; ≈40 | exact categories, categorical K₀ | Leave; add math.KT as secondary topic. KTheoryLowDegrees becomes ClassicalKTheory, a sibling, not a Part II. |
| StablePeriodicCurved (RT), FuchsianOrbifolds (CV) | ≈75, ≈55 | FuchsianOrbifolds: 6 needs (Annals#63, 65; LMFDB hgcwa, modcurve, noncong, shimcurve) | Leave; ℍ² feeds HyperbolicManifolds and TeichmullerTheory. |
| Completed/UniversalCovers (AT) | done | OAI#046, 052, 057, 058 with #279 | Consumed. |
| ClassifyingSpaces #437 (S ≈40) | open | 12 needs: OAI#196, 249, 254, 285, 315, 321, 335; AG's 040, 044, 053, 065, 068 | Merge soon, after #435 and #436. StableHomotopyKTheory H.1's BG yields to it. |
| HomotopySpheres #284 (L ≈250) | open | 3 needs: Annals#78 (low stems), OAI#305, 320; supplier of both families | Merge soon. It keeps stems, EHP, Toda brackets, real Bott, BSO, J, framed bordism, L_n(ℤ); spectra go to StableHomotopyTheory, settling the three-way claim (#284, Birkbeck H.5, EDS E5). |
| KleinianGroups #432 (M ≈110) | open | 5 needs: Annals#63, 65; OAI#023, 246; LMFDB bmf | Merge soon; HyperbolicManifolds and NT's BianchiModularForms wait. |
| PlanarTopology + SurfaceTopology #271 (2 × L ≈400) | open | 9 needs: Annals#72; LMFDB hgcwa; OAI#027, 089, 165, 180, 183 | Merge soon; TeichmullerTheory and ThreeManifoldTopology wait. |
| #435, #436 (fixes) | open | prerequisites of #437 | Merge first. |
| DGFloer #655 (SG) | open | — | Layers 1–2 claim K(A,n), Whitehead towers, Serre classes, Hurewicz fibrations; UnstableHomotopyTheory consumes them if #655 merges first. |
| OrthogonalFactorization #341, CommRingFactorizationSystems #453 (CT), HopfologicalAlgebra #222 (KT) | open, M each | none | Merge on review (#341 before #453). |
| PivotalSpherical #57, TemperleyLieb #58 (QA) | open | ALG's | Leave to ALG; optional input to KhovanovHomology. |
| CohomologicalPointCounting #196 (AG) | open | — | ComplexComparison L5–L7 is TopologicalSixOperations' base; merge before TSO is drafted. |

The explorer has no draft roadmap in TOP territory.

### 2.2 Consolidation of the Birkbeck K-theory and higher-categorical roadmaps

Demand = needs whose `owner` names the roadmap. Order = promotion order of the resulting unit.

| Campaign roadmap (MSC, distance) | Stage → TOP promotion unit | Demand | Order | Overlap with Tau Ceti / open PRs |
|---|---|---|---|---|
| KTheoryLowDegrees (19A, 4) | Z, U → ClassicalKTheory (arithmetic S-integer theorems to NT) | 1: OAI#207 | 1 | GrothendieckEulerForms L0–2 (explorer already narrowed); Mathlib PicardGroup, StablyFree; OAI BassTrace |
| K2SymbolsBrauer (19C, 5) | T.1–T.6 → ClassicalKTheory; T.7 → NT ArithmeticKTheory | 2: OAI#009, 247 | 1 | Tau Ceti GaloisCohomology/Steinberg; QuadraticFormInvariants (Hilbert symbols) |
| GeneralAlgebraicKTheory (19D, 7) | K.1–K.7 → HigherAlgebraicKTheory | 4: OAI#193, 209 ×2, 340 | 2 | exact categories: GrothendieckEulerForms |
| K3BlochGroups (19D, 7) | V.1–V.4 → HigherAlgebraicKTheory; V.5–V.6 → NT | 0 | 2 | — |
| KTheoryFiniteLocalFields (19D, 9) | L.1 (K(𝔽_q)) → HigherAlgebraicKTheory; rest stays NT | 0 | 2 | trace foundations already moved to RT |
| StableHomotopyKTheory (19D/55P, 5) | H.1 BG → #437; H.1 nerves, H.2 → HomotopicalAlgebra; H.3 → UnstableHomotopyTheory; H.4 → InfiniteLoopSpacesAndRingSpectra; H.5–H.6 → Spectra | 5: Annals#78; OAI#193, 209 ×2, 308 | 1–2 | **H.1 duplicates #437**; H.2's Kan/topological comparison is AlgebraicTopology Stage 8.2; H.5 overlaps #284 Stage 3; H.6 spectral sequences: Mathlib `SpectralObject` |
| SchemeKTheoryOperations (19E, 8) | S.1–S.7 → KTheoryOfSchemes | 4: Annals#10; OAI#193, 209 ×2 | 4 | Perf: AlgebraicVectorBundles, AG CoherentDuality, DGAInfinity L5–7; Chow/GRR: AG |
| RefinedTraceMethods (19D, 10) | RT.1–RT.3 → TraceMethods; RT.4:topological → TopologicalKTheory; RT.4:q-Hodge/Habiro, RT.5–6 → AG Habiro lane | 1: Annals#58 | 5 | **RT.1 duplicates DGAInfinity L8** (Hochschild complex); RT.4 overlaps #284 Stage 4 |
| MotivicEtaleKTheory (19E, 9) | M.1–M.3, M.8 → NT; M.4 cycles → AG, comparison and M.5a, M.6 → MotivicHomotopyTheory; M.5b–d, M.7 → NormResidueTheorem | 1: Annals#14 | 6–7 | ProfiniteCohomology, #196 étale, ArithmeticGaloisDuality (campaign) |
| EnhancedDerivedSheaves (18N, 8) | E0, E3, E5:abstract/presentability → InfinityCategories; E1, E2, E4, E5:animation → AG (content-named, consumer); E5:spectra-comparison → Spectra | 2: OAI#069 ×2 | InfinityCategories first | DGAInfinity (DG categories); Mathlib quasicategories; ∞-cosmos project |
| ArithmeticKTheory, BorelRegulators, Polylogarithms, EllipticRegulators, EllipticKTheory, HabiroNumberFields (19D–F) | stay NT, consumers of the family | 0 each | after family | — |
| ArithmeticQuantumTopology (57K, 9) | QT.0–QT.4 → a later GT unit on quantum invariants of 3-manifolds (after #57, #58 and ALG tensor categories); QT.5–7 stay NT | 0 | last | GT L4–L5; #58 (Jones–Wenzl); Tau Ceti `KnotTheory/PDCode` |

Net: the 9 campaign roadmaps routed to TOP (plus stages of KTheoryFiniteLocalFields and ArithmeticQuantumTopology)
become 6 AlgebraicKTheory sub-roadmaps, 3 StableHomotopyTheory sub-roadmaps, InfinityCategories, and stages of
HomotopicalAlgebra and UnstableHomotopyTheory; the arithmetic K-theory roadmaps (six math.KT plus
HabiroNumberFields) stay in NT. Chris Birkbeck authored these blueprints, so the units should be condensed in his
pipeline with the TOP lead reviewing (coordinate first).

## 3. The slate

27 new roadmaps: 13 standalone and 14 sub-roadmaps of two umbrella families. Wave A starts now on Mathlib, Tau Ceti
and merged roadmaps; B needs a wave-A roadmap or an open PR; C is deeper. Prerequisite names inside a family are
short (Spectra = StableHomotopyTheory/Spectra); `#N` is a TauCetiRoadmap PR; *Note* is the formalizability note.

### 3.1 Homotopy and higher-categorical foundations

**UnstableHomotopyTheory** — math.AT — L ≈250 — wave A. Homotopy theory of spaces past AlgebraicTopology's Hurewicz and Whitehead theorems: fibrations, Eilenberg–MacLane spaces, Postnikov and Whitehead towers, obstruction theory, the plus construction, Serre classes, localization and completion of nilpotent spaces, and rational homotopy theory. Mapping and loop spaces use the compactly generated carrier of #284 (Stage 3A); the Serre spectral sequence is AlgebraicTopology's. It owns K(A,n) for all n and A (K(G,1) of discrete groups is #437's). Stems and EHP stay with #284, spectra and the Steenrod algebra with StableHomotopyTheory. If DGFloer (#655) merges first, its Layer 1–2 items are consumed here. *Milestones:* H^n(X;A) ≅ [X,K(A,n)]; Hurewicz mod a Serre class; Serre finiteness for π_*(S^n); fracture squares; rational homotopy groups from minimal models; cat(X) ≥ cup length. *Prereqs:* AlgebraicTopology, #284, #437, UniversalCovers, #655 L1–L2 if merged first. *Goals:* OpenAI 3: OAI#321, #347, #345. *Porting:* OAI Topology/Homotopy; OAI GroupTheory/FiniteType (CWWhitehead, cylinders). *Replaces:* StableHomotopyKTheory H.2 (homotopy fibres), H.3; DGFloer L1 items 2, 4 (ownership). *Note:* Hatcher ch. 4, May–Ponto, Félix–Halperin–Thomas; classical. Mapping-space layers start once #284 merges.

**HomotopicalAlgebra** — math.AT — L ≈220 — wave A. Model-category and simplicial homotopy theory past Mathlib's model-category and Kan-complex files: the Kan–Quillen model structure and its Quillen equivalence with spaces, cofibrantly generated and combinatorial model categories, transfer, left Bousfield localization, Reedy and projective diagram structures, homotopy (co)limits and simplicial model categories. It owns the homotopy theory of small categories: nerves, Quillen's Theorems A and B, Thomason's homotopy-colimit theorem and Thomason's model structure on Cat. It follows Mathlib's design where Mathlib work is in progress, without waiting. Quasicategories are InfinityCategories, strict n-categories StrictHigherCategories, spectra StableHomotopyTheory. *Milestones:* Kan–Quillen; |−| ⊣ Sing; Smith recognition; transfer; left Bousfield localization; Quillen A and B; Thomason's theorem and model structure. *Prereqs:* Mathlib ModelCategory, SimplicialSet, Presentable, AlgebraicTopology Stage 8. *Goals:* OpenAI 4: OAI#312, #317, #193, #209. *Porting:* OAI CategoryTheory/Thomason (Sd², Ex²); Mathlib model-category work (coordinate). *Replaces:* ModelCategoriesAndStrictHigherCategories (model part); StableHomotopyKTheory H.1 (nerves), H.2 (Quillen A/B). *Note:* Goerss–Jardine, Hirschhorn, Hovey; long but standard.

**CharacteristicClassesAndCobordism** — math.AT — L ≈230 — wave B. Vector and principal bundles, their classifying spaces, characteristic classes in singular cohomology, and the cobordism theorems characteristic numbers detect. It extends #284's Grassmannians, BSO and stable classification to unstable classification by BO(n), BU(n), BSp(n) and to principal G-bundles with Milnor's EG → BG (it owns BG for non-discrete G; #437 owns discrete G). It constructs Stiefel–Whitney, Chern, Pontryagin and Euler classes and the Thom isomorphism, and its cobordism layers prove Pontryagin–Thom for unoriented and oriented bordism, Thom's computation of MO_*, rational oriented bordism and the signature theorem. Chern–Weil forms are GEO's, Chow-group Chern classes AG's. *Milestones:* Whitney duality; H*(BU(n)), H*(BO(n);F₂), H*(BG;Q) = H*(BT;Q)^W; Wu formula; Thom's MO_*; Ω^SO⊗Q; signature theorem. Statements: Rokhlin, Milnor spheres. *Prereqs:* AlgebraicTopology, #284 Stages 4–5, GeometricTopology L1, DifferentialGeometry, SteenrodAlgebraAndAdams (last layers), RepresentationTheory/LieGroups. *Goals:* Annals 1: Annals#79 (interface); OpenAI 2: OAI#345, #335. *Replaces:* new (the Thom-isomorphism need was mis-assigned to AlgebraicTopology, which excludes bordism). *Note:* Milnor–Stasheff, Husemoller; standard.

**InfinityCategories** — math.CT — L ≈250 — wave A. The quasicategory model of (∞,1)-categories, as far as stable and presentable ∞-categories, symmetric monoidal structures and Ind-completion. On Mathlib's quasicategories it builds the Joyal model structure (with HomotopicalAlgebra's tools), mapping spaces, limits, Kan extensions, adjunctions, cartesian fibrations with straightening for the shapes consumers use, presentability, stable ∞-categories with t-structures, ∞-operads, and the dg nerve from DGAInfinity's pretriangulated DG categories. It replaces EnhancedDerivedSheaves E0, E3 and E5:abstract/presentability; that roadmap's sheaf-theoretic remainder moves to AG as a consumer. *Milestones:* Joyal structure; restricted straightening; adjoint functor theorem; triangulated ho of a stable ∞-category; dg nerve; symmetric monoidal ∞-categories. *Prereqs:* Mathlib Quasicategory, HomotopicalAlgebra, DGAInfinity. *Goals:* Annals 2: Annals#58, Annals#78; OpenAI 2: OAI#069, #014. *Porting:* Lean ∞-cosmos project (Riehl–Verity): coordinate first. *Replaces:* EnhancedDerivedSheaves E0, E3, E5:abstract, E5:presentability. *Note:* Lurie HTT/HA, Cisinski; straightening is the long pole.

**StrictHigherCategories** — math.CT — M ≈120 — wave B. Strict globular n- and ω-categories and their homotopy theory, up to Thomason-type model structures and the statement of Grothendieck's homotopy hypothesis: polygraphs, Street's orientals and nerve, Steiner complexes, the Gray tensor product, coherators and globular ∞-groupoids. It consumes HomotopicalAlgebra (transfer, Kan–Quillen, Thomason on Cat) and builds no quasicategory theory. The homotopy hypothesis is stated; its general proof is open. OAI's `CategoryTheory/Thomason` (225 files) and `Globular` are the porting source, coordinate first. *Milestones:* Steiner's theorem; folk model structure; Ara–Maltsiniotis Thomason structures (OAI#317). Statements: homotopy hypothesis, Henry's semi-model structures. *Prereqs:* HomotopicalAlgebra. *Goals:* OpenAI 2: OAI#312, #317. *Porting:* OAI CategoryTheory/Thomason, Globular. *Replaces:* ModelCategoriesAndStrictHigherCategories (strict part). *Note:* medium; the OAI port lowers the cost.

### 3.2 Geometric and low-dimensional topology, sheaves, transformation groups

**KhovanovHomology** — math.GT — L ≈180 — wave A. Khovanov homology of oriented links and its concordance invariants. On GeometricTopology Layer 4 and Tau Ceti's PD codes, Kauffman bracket and Jones polynomial, it builds the cube of resolutions over ℤ, proves Reidemeister invariance and χ = Jones, develops Bar-Natan's local theory as the computational engine, and reaches Lee's spectral sequence and Rasmussen's s with |s| ≤ 2g₄ and the Milnor conjecture. It owns s: its PR corrects the four GeometricTopology lines that expect s from CombinatorialHeegaardFloer, which keeps τ. sl(N) homologies and Khovanov homotopy types are out of scope. *Milestones:* Reidemeister invariance; χ = Jones; Lee homology; s(T_{p,q}) = (p−1)(q−1); alternating knots thin. Statement: unknot detection. *Prereqs:* GeometricTopology L4, L6, Tau Ceti KnotTheory, #58 (optional). *Goals:* Annals 1: Annals#74. *Replaces:* KhovanovHomology (Annals P24). *Note:* finite and combinatorial; best payoff per PR in the campaign.

**HyperbolicManifolds** — math.GT — L ≈250 — wave B. Hyperbolic n-space and the geometry and rigidity of its discrete isometry groups: models, Isom(ℍⁿ) ≅ PO(n,1), limit sets, convex cores, geometric finiteness, Schottky groups, the Margulis lemma with thick–thin and cusps, arithmetic groups of simplest type, and Mostow rigidity by the Gromov–Thurston route, with ℓ¹-homology, simplicial volume and bounded cohomology of groups and spaces developed for it. Dimension 3 is #432, curvature and volume GeometricTopology Layer 7, dimension 2 FuchsianOrbifolds, lattices in Lie groups ALG's. Hyperbolic Dehn filling and Jørgensen–Thurston are stated. *Milestones:* Margulis lemma; Gromov's mapping theorem, amenable vanishing; ‖M‖ = vol(M)/v_n; Mostow rigidity (closed, then finite volume). *Prereqs:* GeometricTopology L7, #432, FuchsianOrbifolds, GEO RiemannianGeometry, ALG AmenableGroupsAndGrowth. *Goals:* LMFDB 1: bmf (via #432); Annals 1: Annals#63; OpenAI 4: OAI#335, #246, #358, #023. *Replaces:* HyperbolicManifolds (Annals P11); BoundedCohomology (geometry report). *Note:* Ratcliffe, Benedetti–Petronio, Frigerio; classical.

**TeichmullerTheory** — math.GT — L ≈280 — wave B. Teichmüller and moduli spaces of hyperbolic surfaces and their mapping class groups, starting where SurfaceTopology (#271 Layer 9: curves, Dehn twists, Dehn–Lickorish) stops: marked hyperbolic structures, Fenchel–Nielsen coordinates, proper discontinuity of Mod(S), Dehn–Nielsen–Baer, the Birman exact sequence, the symplectic representation, and Nielsen–Thurston via measured laminations. The quasiconformal layers (Teichmüller's theorems, quadratic differentials, Bers embedding) consume ANA's quasiconformal-maps roadmap; Weil–Petersson is defined with Wolpert's formula. Braid and Hurwitz actions on generating vectors go to AG's GroupActionsOnRiemannSurfaces. *Milestones:* Teich(S) ≅ ℝ^{6g−6+2n}; Dehn–Nielsen–Baer; Birman sequence; Sp(2g,ℤ) surjectivity; Nielsen–Thurston. Statements: finite presentation, Masur–Minsky. *Prereqs:* #271, FuchsianOrbifolds, HyperbolicManifolds, ConformalMapping, #279, ANA quasiconformal maps (qc layers). *Goals:* LMFDB 1: hgcwa; Annals 1: Annals#72; OpenAI 1: OAI#027. *Replaces:* TeichmullerTheory (Annals P23). *Note:* Farb–Margalit, Hubbard; qc layers wave C.

**ThreeManifoldTopology** — math.GT — L ≈250 — wave B. Proofs of the classical topology of 3-manifolds whose statements GeometricTopology gives: Moise's theorem on PlanarTopology's PL toolkit (#271), the Kneser–Milnor prime decomposition, Dehn's lemma and the loop and sphere theorems, incompressible surfaces and Haken hierarchies, normal surfaces with Haken's unknot algorithm, Seifert fibered spaces, Waldhausen's theorem and the JSJ decomposition. Geometrization stays a GeometricTopology Layer 8 statement; Heegaard splittings stay in Layer 9, Dehn surgery in Layer 5. *Milestones:* Moise; uniqueness of prime decomposition; sphere theorem; Haken's algorithm; Waldhausen; JSJ. *Prereqs:* #271 PlanarTopology, GeometricTopology L1, L5, L8, L11, AlgebraicTopology, ALG CombinatorialGroupTheory. *Goals:* OpenAI 3: OAI#368, #358, #306. *Replaces:* new. *Note:* Hempel, Jaco, Moise; long classical proofs.

**SurgeryTheoryAndFourManifolds** — math.GT — L ≈250 — wave C. Surgery beyond the simply connected case and the topology of 4-manifolds. It extends #284 Stage 7 with Whitehead torsion and the s-cobordism theorem, normal invariants, Poincaré complexes and the Spivak fibration, Wall's exact sequence with L_n(ℤπ) from HermitianKTheoryAndLTheory, the finiteness obstruction in K̃₀(ℤπ), and assembly with Farrell–Jones and Borel stated. Its 4-dimensional layers prove Whitehead–Milnor, Rokhlin and Davis's reflection construction, set up Kirby calculus and Kirby–Siebenmann, and state Freedman, Donaldson, disc embedding, good groups and the D(2) problem. *Milestones:* s-cobordism; surgery exact sequence; Whitehead–Milnor; Rokhlin; Davis manifolds. *Prereqs:* #284, HermitianKTheoryAndLTheory, ClassicalKTheory, CharacteristicClassesAndCobordism, #437, ALG GroupCohomologyFiniteness, NonpositiveCurvature. *Goals:* OpenAI 4: OAI#305, #320, #321, #315. *Replaces:* FourManifoldTopology (geometry report). *Note:* Wall, Ranicki; 4D theorems are statements (frontier).

**TransformationGroups** — math.AT — L ≈200 — wave B. Compact and finite group actions on spaces and manifolds and the equivariant cohomology that controls them: G-CW complexes, classifying spaces for families E_F G, orbit types, the slice and principal-orbit theorems, Borel cohomology, Smith theory, the Borel–Atiyah–Segal–Quillen localization theorem, Newman's theorem, and covering and cohomological dimension. Gleason–Yamabe and Montgomery–Zippin are ALG's, consumed to state the reduction of Hilbert–Smith to ℤ_p-actions. Equivariant Chow groups and GKM stay in AG's EquivariantCohomologyAndLocalization, which consumes these layers. *Milestones:* slice theorem; Smith theory; localization theorem; Newman. Statements: Hilbert–Smith, Yang, Pardon. *Prereqs:* CharacteristicClassesAndCobordism, TopologicalSixOperations, #437, RepresentationTheory/LieGroups, ALG locally compact groups. *Goals:* OpenAI 8: OAI#304, #315, #345, #040, #044, #053, #065, #068. *Replaces:* TransformationGroups (geometry report) minus Hilbert's fifth problem. *Note:* Bredon, tom Dieck; standard.

**TopologicalSixOperations** — math.AT — L ≈250 — wave B. Sheaves on locally compact Hausdorff spaces with the six operations. From #196 ComplexComparison L5–L7 (local systems, sheaf versus singular cohomology, j_! and Rf_! for triangulated spaces) it extends Rf_! to all locally proper maps with proper base change and the projection formula, constructs f^!, and proves Verdier and Poincaré–Verdier duality with Borel–Moore homology. It owns local systems over arbitrary rings, c-soft resolutions, cohomological dimension, and constructible complexes for semialgebraic and complex-algebraic stratifications. #196's Rf_! is its restriction. Perverse sheaves, microsupport and D-modules are AG consumers. *Milestones:* proper base change; Verdier duality; Poincaré–Verdier; constructibility under the six operations. *Prereqs:* #196 ComplexComparison L5–L7, RealAlgebraicGeometry, AlgebraicTopology. *Goals:* Annals 5: Annals#16, Annals#5, Annals#67, Annals#41 (via AG), Annals#15 (via AG); OpenAI 1: OAI#304. *Replaces:* TopologicalSixOperations (Annals); foundation of MicrolocalSheafTheory asked by OAI#304. *Note:* Kashiwara–Schapira, Iversen; standard.

**TopologicalCombinatorics** — math.AT — M ≈110 — wave A. Topological methods for combinatorial and group-theoretic problems: order complexes, nerves, free ℤ/2- and ℤ/p-spaces and their index. It proves the nerve theorem, Quillen's fiber lemma, discrete Morse theory, shellability, Borsuk–Ulam in its equivalent forms, ham-sandwich and polynomial ham-sandwich, Lovász–Kneser, topological Tverberg for primes, and Quillen's theorems on p-subgroup posets. Solomon–Tits comes from ALG's buildings; incidence applications stay in COMB's DiscreteGeometryAndIncidences, which consumes this roadmap. *Milestones:* nerve theorem; fiber lemma; Borsuk–Ulam; Stone–Tukey; Lovász–Kneser; Tverberg (p prime); S_p(G) ≃ A_p(G). *Prereqs:* AlgebraicTopology, GeometricTopology L11 (#435), ALG BuildingsAndCosetComplexes. *Goals:* OpenAI 3: OAI#166, #310, #074. *Replaces:* Borsuk–Ulam target of COMB DiscreteGeometryAndIncidences; poset topology (unowned). *Note:* Matoušek, Kozlov; accessible.

### 3.3 StableHomotopyTheory (XL family, math.AT, ≈1,490 PRs)

Umbrella for the stable homotopy category and its computational machinery, from spectra to the chromatic filtration; PR estimates are carried by its seven sub-roadmaps (≈1,490). It is the single owner of spectra: #284 keeps stems as colimit groups, Freudenthal, EHP, Toda brackets, real Bott, stable J and framed Pontryagin–Thom, all consumed; StableHomotopyKTheory H.4–H.6 and EnhancedDerivedSheaves E5:spectra-comparison are absorbed. The point-set model of spectra is fixed once, in Spectra. *Family goals:* Annals 1: Annals#78; OpenAI 10: OAI#285, #302, #308, #309, #311, #313, #314, #316, #318, #319. *Replaces:* StableHomotopyTheory and ChromaticHomotopyTheory (geometry report); ChromaticHomotopyTheory (Annals P25); StableHomotopyKTheory H.4–H.6.

**Spectra** — math.AT — L ≈230 — wave B. Spectra and the stable homotopy category. It fixes one model (recommended: symmetric spectra of simplicial sets, compared with sequential spectra and #284's suspension spectra), builds the triangulated SHC with smash product and function spectra, and identifies π_*𝕊 with #284's stems. It proves Brown representability, constructs Eilenberg–MacLane and Moore spectra, Postnikov towers, the Atiyah–Hirzebruch spectral sequence, rationalization, p-completion and Bousfield localization, and compares spectra with the stabilization of spaces in InfinityCategories. *Milestones:* Brown representability; Spanier–Whitehead duality; AHSS; π_*𝕊⊗Q; Bousfield localization exists. *Prereqs:* HomotopicalAlgebra, UnstableHomotopyTheory, #284, InfinityCategories (last layer). *Goals:* Annals 1: Annals#78; OpenAI 5: OAI#308, #309, #316, #193, #209. *Replaces:* StableHomotopyKTheory H.5:spectra, H.6; EnhancedDerivedSheaves E5:spectra-comparison. *Note:* Adams, Hovey–Shipley–Smith, Schwede; standard.

**InfiniteLoopSpacesAndRingSpectra** — math.AT — L ≈200 — wave B. From spaces with coherent multiplications to spectra, and structured ring spectra: Γ-spaces, the group completion theorem, the recognition principle, little-cubes operads with May's approximation theorem, A_∞/E_∞ ring spectra, modules, relative smash products and Thom spectra as E_∞-rings, compared with InfinityCategories' ∞-operads. HigherAlgebraicKTheory uses its group completion theorem to identify the plus construction with the group completion of projective modules. *Milestones:* group completion; recognition principle; Ω^nΣ^n X ≃ C_n X; MU as E_∞-ring. *Prereqs:* Spectra, UnstableHomotopyTheory, InfinityCategories. *Goals:* Annals 1: Annals#78; OpenAI 2: OAI#193, #209. *Replaces:* StableHomotopyKTheory H.4, H.5:S-delooping (multiplicative part). *Note:* May, Segal, EKMM; standard.

**SteenrodAlgebraAndAdamsSpectralSequence** — math.AT — L ≈230 — wave B. Cohomology operations and the Adams spectral sequence: Steenrod squares and powers on spaces with Cartan and Adem relations, the Steenrod algebra and Milnor's dual, H*(K(ℤ/p,n)), the Adams spectral sequence with convergence, Ext over the mod-2 Steenrod algebra through t − s ≤ 13 (consistent with #284), the May spectral sequence and Lambda algebra, Hopf invariant one, Kervaire classes and Browder's theorem. Its squares feed the Wu formula and Thom's computation in CharacteristicClassesAndCobordism. *Milestones:* Adem relations; H*(K(Z/p,n)); Adams convergence; Hopf invariant one; Browder. Statements: HHR, Curtis. *Prereqs:* Spectra, UnstableHomotopyTheory, #284. *Goals:* Annals 1: Annals#78; OpenAI 3: OAI#309, #316, #319. *Replaces:* StableHomotopyTheory (geometry report), Steenrod/Adams part. *Note:* Mosher–Tangora, McCleary, Ravenel; standard.

**TopologicalKTheory** — math.AT — L ≈200 — wave B. Complex and real topological K-theory: K⁰ and KO⁰ from vector bundles, complex Bott periodicity (Atiyah–Bott) with real periodicity from #284 Stage 4B, KU, KO, ku, ko, Adams operations, the Chern character, the K-theory Thom isomorphism, Hopf invariant one via Adams operations, vector fields on spheres, the e-invariant and image of J, and KU-homology. Operator K-theory and analytic K-homology are FAMP's OperatorKTheory, which identifies K₀(C(X)) with K⁰(X) against this roadmap; index theory is GEO's. *Milestones:* Bott periodicity; Hopf invariant one via ψ^k; vector fields on spheres; image of J. Statements: Adams conjecture, Atiyah–Segal. *Prereqs:* Spectra, CharacteristicClassesAndCobordism, #284 Stage 4, RepresentationTheory/SpinRepresentations. *Goals:* OpenAI 1: OAI#285. *Replaces:* RefinedTraceMethods RT.4:topological. *Note:* Atiyah, Karoubi, Adams; standard.

**ComplexCobordism** — math.AT — L ≈200 — wave C. Complex-oriented cohomology theories and their formal groups: formal group laws and Lazard's theorem (on Mathlib's `FormalGroup`), complex orientations, MU and Quillen's theorem, MU_*MU and BP_*BP, BP and BP⟨n⟩, the Adams–Novikov spectral sequence, Landweber exactness and Conner–Floyd, Morava K(n) and E-theories, and the chromatic spectral sequence through the α-family. Height and Lubin–Tate deformation come from the formal-groups owner (§6). *Milestones:* Lazard; Quillen; Landweber exactness; Conner–Floyd; α-family. *Prereqs:* Spectra, InfiniteLoopSpacesAndRingSpectra, SteenrodAlgebraAndAdams, formal-groups owner. *Goals:* Annals 1: Annals#78; OpenAI 3: OAI#302, #308, #319. *Replaces:* MU/BP parts of StableHomotopyTheory (geometry report) and ChromaticHomotopyTheory (Annals P25). *Note:* Ravenel's green book; standard.

**ChromaticHomotopyTheory** — math.AT — L ≈230 — wave C. The chromatic filtration: Bousfield classes, L_n and L_K(n), fracture squares, the Morava stabilizer group with continuous cohomology (from ProfiniteCohomology) and change of rings, Lubin–Tate spectra, the smash-product theorem, the thick subcategory theorem from nilpotence, v_n-self maps and telescopes. It owns Balmer's tensor-triangular spectrum in general, with finite spectra and Thomason's perfect complexes as worked cases. Nilpotence, periodicity, Devinatz–Hopkins, Goerss–Hopkins–Miller, chromatic convergence and splitting, Hovey–Strickland and the telescope disproof are stated. *Milestones:* change of rings; smash-product theorem; thick subcategory theorem from nilpotence; Balmer spectrum of SH^c_(p). *Prereqs:* ComplexCobordism, ProfiniteCohomology, formal-groups owner. *Goals:* Annals 1: Annals#78; OpenAI 7: OAI#308, #309, #311, #313, #314, #318, #319. *Replaces:* ChromaticHomotopyTheory (geometry report; Annals P25). *Note:* statements reachable; headline proofs frontier.

**EquivariantStableHomotopyTheory** — math.AT — L ≈200 — wave C. Genuine equivariant stable homotopy theory for finite groups: genuine G-spectra, Mackey functors, Bredon and RO(G)-graded cohomology, categorical, geometric and homotopy fixed points, the Tate construction, tom Dieck splitting, Wirthmüller and Adams isomorphisms, the HHR norm and the Balmer–Sanders spectrum. It supplies genuine C_p-spectra and Tate constructions to TraceMethods and consumes TransformationGroups' G-CW complexes; the Segal conjecture and HHR detection are stated. *Milestones:* tom Dieck splitting; Wirthmüller and Adams isomorphisms; Tate diagram; norms. *Prereqs:* Spectra, TransformationGroups. *Goals:* OpenAI 2: OAI#314, #309. *Replaces:* layer for family 314 in ChromaticHomotopyTheory (geometry report). *Note:* LMS, HHR, Schwede; standard.

### 3.4 AlgebraicKTheory (XL family, math.KT, ≈1,660 PRs)

Umbrella for algebraic K-theory of rings, exact categories and schemes, trace methods, hermitian K- and L-theory, and the motivic machinery that computes K-groups of fields; PR estimates are carried by its seven sub-roadmaps (≈1,660). It consolidates the Birkbeck campaign's general K-theory roadmaps; the arithmetic ones stay in NT as consumers. Categorical K₀ is GrothendieckEulerForms', Hochschild cochains DGAInfinity's, spectra StableHomotopyTheory's. *Family goals:* Annals 4: Annals#10, Annals#14, Annals#58, Annals#78; OpenAI 9: OAI#009, #193, #207, #209, #247, #304, #305, #320, #340. *Replaces:* StableHomotopyKTheory; GeneralAlgebraicKTheory; SchemeKTheoryOperations; KTheoryLowDegrees; K2SymbolsBrauer; K3BlochGroups; RefinedTraceMethods; MotivicEtaleKTheory.

**ClassicalKTheory** — math.KT — L ≈230 — wave A. K₀, K₁, K₂ of rings by algebraic means and Milnor K-theory of fields: K₀ from projectives and idempotents (compared with GrothendieckEulerForms' split K₀) with rank, determinant, Pic and the Hattori–Stallings trace; K₁ with the Whitehead lemma, SK₁, relative groups, Milnor squares and Wh(π); K₂ through Steinberg groups over arbitrary rings and Matsumoto; tame symbols, reciprocity laws, Bass–Tate, K₂(ℚ) and the low-degree fundamental theorem. Bass–Milnor–Serre and Merkurjev–Suslin are stated; Tate's comparison with Hilbert symbols stays in NT. *Milestones:* Whitehead lemma; Milnor Mayer–Vietoris; K₂ = H₂(E(R)); Matsumoto; Bass–Tate; K₂(ℚ). *Prereqs:* GrothendieckEulerForms, Mathlib PicardGroup, Transvection. *Goals:* OpenAI 5: OAI#207, #247, #009, #196, #197. *Porting:* OAI RingTheory/BassTrace (ModuleK0); OAI GroupTheory/PeriodicGroups/Steinberg. *Replaces:* KTheoryLowDegrees (Z, U); K2SymbolsBrauer T.1–T.6. *Note:* Milnor, Weibel K-book I–III; accessible.

**HigherAlgebraicKTheory** — math.KT — L ≈250 — wave B. Quillen and Waldhausen K-theory: K(R) via the plus construction and via group completion, the Q-construction with Q = +, resolution, dévissage, additivity and localization, G-theory and the fundamental theorem, Waldhausen's S• with approximation and fibration theorems, nonconnective K-theory, products, Quillen's K(𝔽_q), and K₃ of fields with the Bloch group and Suslin's sequence. A-theory is defined and the stable parametrized h-cobordism theorem stated; arithmetic computations stay in NT. *Milestones:* plus = group completion; Q = +; dévissage, localization; approximation; K(𝔽_q); Suslin's sequence. *Prereqs:* ClassicalKTheory, UnstableHomotopyTheory, HomotopicalAlgebra, Spectra, InfiniteLoopSpacesAndRingSpectra, TopologicalKTheory (Brauer lifting). *Goals:* OpenAI 3: OAI#193, #209, #340. *Replaces:* GeneralAlgebraicKTheory K.1–K.7; K3BlochGroups V.1–V.4; KTheoryFiniteLocalFields L.1. *Note:* Weibel K-book IV; classical.

**KTheoryOfSchemes** — math.KT — L ≈230 — wave C. K-theory of schemes after Thomason–Trobaugh: perfect complexes, K and G and the Cartan map, supports and localization, Nisnevich descent, homotopy invariance and the projective bundle formula, the Gersten conjecture for smooth varieties, Bloch's formula, λ- and Adams operations, KH and Riemann–Roch without denominators. Land–Tamme for truncating invariants and cdh descent are stated. Perfect complexes come from AG (CoherentDuality, AlgebraicVectorBundles); Chow groups and GRR are AG's. *Milestones:* Thomason–Trobaugh localization; projective bundle formula; Gersten; Bloch's formula. *Prereqs:* HigherAlgebraicKTheory, AG CoherentDuality, AlgebraicVectorBundles. *Goals:* Annals 1: Annals#10; OpenAI 2: OAI#193, #209. *Replaces:* SchemeKTheoryOperations S.1–S.7. *Note:* Thomason–Trobaugh; waits on AG foundations.

**TraceMethods** — math.KT — L ≈220 — wave C. Hochschild and cyclic homology on DGAInfinity Layer 8's complex (HC, HC⁻, HP, SBI, Morita invariance, HKR for homology, Goodwillie's theorem), then THH of ring spectra, cyclotomic spectra (Nikolaus–Scholze), TC, TC⁻, TP, Bökstedt periodicity, the Dennis and cyclotomic traces and Dundas–Goodwillie–McCarthy. Refined TC and Habiro comparisons stay in the AG Habiro lane. *Milestones:* HKR; Goodwillie; THH(𝔽_p) = 𝔽_p[u]; DGM. Statement: Land–Tamme. *Prereqs:* DGAInfinity L8, HigherAlgebraicKTheory, InfiniteLoopSpacesAndRingSpectra, EquivariantStableHomotopyTheory. *Goals:* Annals 1: Annals#58; OpenAI 1: OAI#193. *Replaces:* RefinedTraceMethods RT.1–RT.3. *Note:* Loday, Nikolaus–Scholze; topological half frontier-adjacent.

**HermitianKTheoryAndLTheory** — math.KT — L ≈180 — wave A. Forms over rings with involution and their K- and L-theories: Witt groups extending Tau Ceti's Witt ring of fields, Grothendieck–Witt groups, Wall's L-groups (quadratic and symmetric) with Ranicki's algebraic surgery and the identification of L_n(ℤ) with #284's groups, L-groups of finite groups in low degrees, and Balmer's Witt groups of triangulated categories with duality. Karoubi periodicity is stated. Geometric surgery is SurgeryTheoryAndFourManifolds; NT's GN.6 consumes these groups. *Milestones:* L_n(ℤ) agrees with #284; Balmer localization sequence. *Prereqs:* Tau Ceti QuadraticForm/Witt, QuadraticFormInvariants, #284 Stage 7. *Goals:* OpenAI 3: OAI#304, #305, #320. *Replaces:* new (Witt groups of triangulated categories were unowned). *Note:* Ranicki, Balmer, Knus; algebraic.

**MotivicHomotopyTheory** — math.KT — L ≈300 — wave C. Unstable and stable 𝔸¹-homotopy theory over a field: Nisnevich topology, H(k), motivic spheres, SH(k), sheaves with transfers and DM(k) with cancellation, motivic cohomology compared with higher Chow groups (cycle complexes from AG) and with Milnor K-theory, KGL, MGL, HZ, the slice tower and motivic spectral sequence, and Morel's π₀𝕊_k = GW(k). The motivic Steenrod algebra, six operations on SH(−) and the Chow t-structure are stated; AG's MotivesAndAlgebraicCycles consumes DM(k). *Milestones:* cancellation; H^{p,q} = higher Chow; H^{n,n} = K^M_n; π₀𝕊_k = GW(k). *Prereqs:* KTheoryOfSchemes, HomotopicalAlgebra, Spectra, AG cycle complexes. *Goals:* Annals 2: Annals#78, Annals#14. *Replaces:* MotivicHomotopyTheory (Annals P26); MotivicEtaleKTheory M.4 (comparison), M.5a, M.6. *Note:* Morel–Voevodsky, Mazza–Voevodsky–Weibel; large.

**NormResidueTheorem** — math.KT — L ≈250 — wave C. The proof of K^M_n(F)/ℓ ≅ H^n(F, μ_ℓ^{⊗n}) following Haesemeyer–Weibel: motivic operations, norm varieties and Rost's degree formulas, the Rost motive, Hilbert 90 for Milnor K-theory, prime powers and general fields, with Merkurjev–Suslin, the Milnor conjecture and Quillen–Lichtenbaum as consequences. Applications to number rings stay in NT. *Milestones:* Rost's degree formula; Hilbert 90 for K^M; norm residue theorem; Quillen–Lichtenbaum. *Prereqs:* MotivicHomotopyTheory, ProfiniteCohomology. *Goals:* OpenAI 1: OAI#009 (Merkurjev–Suslin, statement). *Replaces:* MotivicEtaleKTheory M.5a–d, M.7. *Note:* book-length; demand only from NT consumers.

## 4. Needs not absorbed

All 39 TOP gap needs were checked; 33 lines are absorbed by the slate. The rest:

- **Owned by FAMP's OperatorKTheory:** OAI#285 (Baum–Connes assembly; C*-algebra K-theory, Pimsner–Voiculescu,
  trace integrality; the analytic side of K-homology and the Dirac class of 𝕋²) and OAI#307 (Roe algebras, coarse
  assembly). TOP supplies BG (#437), E_FIN G (TransformationGroups) and KU-homology (TopologicalKTheory).
- **Owned by FAMP's GroupVonNeumannAlgebras:** OAI#315 (L²-Betti numbers, Singer conjecture statement); TOP supplies
  G-CW complexes and #437.
- **Owned by AG's SingularityTheory:** OAI#059 (simple fibred links and open books, Levine–Durfee–Kato), using
  h-cobordism from #284 and Seifert forms from GeometricTopology L4.
- **Owned by ALG:** the Gleason–Yamabe / Montgomery–Zippin part of OAI#304 (structure of locally compact groups).
- **Frontier, stated only:** the proofs in families 302 (smash powers of MU), 305/320 (Freedman–Quinn surgery),
  308, 309, 311, 313, 314, 316, 318, 319 (chromatic and Adams computations), 312 (homotopy hypothesis), 340 (stable
  parametrized h-cobordism) and Land–Tamme descent (193). The slate states each.
- **Mis-owned non-gap needs, corrected:** OAI#345's Thom isomorphism (AlgebraicTopology excludes it) →
  CharacteristicClassesAndCobordism; Annals#67's arbitrary-coefficient local systems (#196 L5 has finite Λ only) →
  TopologicalSixOperations; OAI#368's Moise triangulation (GeometricTopology L11 is partial) → ThreeManifoldTopology.

## 5. Cross-campaign interface

**Imports.**
- AG: #196 ComplexComparison L5–L7 (TopologicalSixOperations); CoherentDuality and AlgebraicVectorBundles (perfect
  complexes for KTheoryOfSchemes); cycle complexes and Chow groups (MotivicHomotopyTheory, KTheoryOfSchemes);
  RealAlgebraicGeometry (semialgebraic stratifications).
- ALG: GroupCohomologyFiniteness and NonpositiveCurvature (Surgery/4-manifolds); AmenableGroupsAndGrowth (bounded
  cohomology); locally compact group structure (TransformationGroups); BuildingsAndCosetComplexes (Solomon–Tits);
  CombinatorialGroupTheory (ThreeManifoldTopology); one `IsLattice`; RepresentationTheory/LieGroups, CompactGroups,
  SpinRepresentations; ProfiniteCohomology (Morava stabilizer group, NormResidueTheorem).
- ANA: quasiconformal maps (Teichmüller). GEO: comparison geometry, DifferentialGeometry, DGFloer L1–L2.
- NT: formal groups and Lubin–Tate deformation in all heights (ComplexCobordism, Chromatic).

**Exports.**
- FAMP: TopologicalKTheory (K⁰, KU, KU-homology; Swan comparison done on their side), #437 and E_FIN G to
  OperatorKTheory; G-CW complexes to GroupVonNeumannAlgebras.
- GEO: CharacteristicClassesAndCobordism to ConnectionsAndCharacteristicClasses (Chern–Weil) and index theory;
  TopologicalKTheory to index theory; LS category and loop-space homology (UnstableHomotopyTheory) to
  SymplecticTopology and GlobalRiemannianGeometry.
- AG: TopologicalSixOperations to PerverseSheavesOnComplexVarieties, MicrolocalSheafTheory, AlgebraicDModules
  (Annals#41, #15, #5); TransformationGroups to EquivariantCohomologyAndLocalization; InfinityCategories to the
  EnhancedDerivedSheaves remainder, DerivedCategoriesAndStability and geometric Langlands; DM(k) to
  MotivesAndAlgebraicCycles; Chern character to intersection theory.
- ALG: ClassicalKTheory (K₀, Hattori–Stallings, Wh) to GroupRings; G-CW complexes and E_F G to
  GroupCohomologyFiniteness and ArtinGroupsAndGarside (Salvetti complexes); TopologicalCombinatorics to OAI#310.
- COMB and ANA: Borsuk–Ulam and (polynomial) ham-sandwich to DiscreteGeometryAndIncidences and KakeyaAndProjections.
- NT: the AlgebraicKTheory family to the seven arithmetic K-theory roadmaps; #432 and HyperbolicManifolds to
  BianchiModularForms; HermitianKTheoryAndLTheory to GeometryOfNumbersAndQuadraticArithmetic GN.6.

## 6. Order and people

**Merge first** (thirteen slate roadmaps consume them): #435, #436, then #437; #284; #432; #271; #196 (AG).

**First five to draft.**
1. *UnstableHomotopyTheory* (A): unblocks the Steenrod sub-roadmap, HigherAlgebraicKTheory (plus construction) and
   CharacteristicClassesAndCobordism, and fixes the DGFloer overlap before it spreads; OAI#321, 347.
2. *HomotopicalAlgebra* (A): unblocks Spectra, HigherAlgebraicKTheory (Quillen A/B) and StrictHigherCategories
   (OAI#312, 317, with a 225-file OAI port); needs early coordination with Mathlib's model-category work.
3. *KhovanovHomology* (A): Annals#74, closes GeometricTopology's dangling s, small dependency surface, Tau Ceti knot
   code ready.
4. *StableHomotopyTheory* umbrella with *Spectra* (B): the umbrella names the single owner of spectra now; Annals#78
   and ten OpenAI families wait on it.
5. *TopologicalSixOperations* (B on #196): Annals#16, #5, #67, OAI#304, and three AG roadmaps behind it.

Next: AlgebraicKTheory with ClassicalKTheory and HermitianKTheoryAndLTheory (A, via Birkbeck's pipeline),
CharacteristicClassesAndCobordism (B, after #284), then HyperbolicManifolds and TeichmullerTheory after #432 and #271.

**People.** Lead: a homotopy theorist (stable homotopy, some K-theory) who writes or reviews Lean. Reviewers: a
chromatic homotopy theorist, an algebraic K-theorist (shared with Birkbeck's campaign), a low-dimensional topologist,
a higher-category theorist, a sheaf theorist (shared with AG). Coordinate with Mathlib's model-category maintainers,
the ∞-cosmos project and Chris Birkbeck.

**Open questions for the owner.**
1. *Spectra model.* Recommended: symmetric spectra of simplicial sets on HomotopicalAlgebra's stable model
   structure; genuine G-spectra in the matching equivariant model; the ∞-categorical Sp compared at the end of
   Spectra. Alternative: orthogonal spectra on #284's compactly generated carrier (better for equivariance, heavier
   point-set topology).
2. *Motivic homotopy.* BOUNDARIES gives it to TOP although the Annals report tagged it math.AG; it is placed in the
   AlgebraicKTheory family as math.KT. NormResidueTheorem has no direct goal demand: keep in wave C or defer?
3. *Formal groups.* One owner for formal group laws, height and Lubin–Tate deformation in all heights: NT's
   algebraic lane (also serving local CFT and Coleman power series) is recommended; otherwise layer 0 of
   ComplexCobordism.
4. *TransformationGroups vs ALG.* Hilbert's fifth problem goes to ALG; the actions, Smith theory and equivariant
   cohomology stay in TOP. Needs the ALG planner's agreement.
5. *EnhancedDerivedSheaves split* between InfinityCategories (TOP) and an AG consumer: needs Chris and the AG lead.
6. *Tensor-triangular geometry* is placed in ChromaticHomotopyTheory as its general owner; a separate math.CT roadmap
   is the alternative if AG or ALG demand grows.

## 7. Totals

| | roadmaps | est. PRs |
|---|---|---|
| Standalone L | 11 | 2,610 |
| Standalone M | 2 | 230 |
| StableHomotopyTheory family (7 L) | 1 umbrella | 1,490 |
| AlgebraicKTheory family (7 L) | 1 umbrella | 1,660 |
| **New, total** | **27 roadmaps** (29 READMEs with the two umbrella indexes; 15 review units) | **≈5,990** |
| by wave | A 7 / B 12 / C 8 | 1,420 / 2,690 / 1,880 |

Existing supply in the territory: ≈1,070 PRs left on TOP-topic main roadmaps (AlgebraicTopology ≈70, GeometricTopology
≈260, CombinatorialHeegaardFloer ≈325, DGAInfinity ≈410), ≈460 on adjacent RT/SG/CV roadmaps, and ≈1,090 in open PRs
(#271 ≈400, #284 ≈250, #432 ≈110, #222, #341, #453 ≈100 each, #437 ≈40). The nine campaign roadmaps routed to TOP
(≈765 PR-equivalents at 85 each) are absorbed into the slate, not additional.

## 8. References by roadmap

29 roadmap records, 349 listings, 315 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_TOP.json` and the `references` fields of `slate_TOP.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (242 of 315: zbMATH stopped early; see master (d)). A title is given at a work's first citation in this section only. Pointers are the compilers' and are unverified.

**Conventions and notes.** Spectra are symmetric spectra of simplicial sets (Hovey–Shipley–Smith), carried into the equivariant (Mandell; Hausmann) and motivic (Jardine) layers; ∞-categories follow HTT's definitions; K-theory follows the K-book's numbering; L-groups follow Ranicki; the six operations follow Kashiwara–Schapira's sign and shift conventions. Theorem numbers are given only where reused from a Tau Ceti README or certain.

**UnstableHomotopyTheory** (wave A)
- primary: Hatcher 2002, *Algebraic Topology*, §4.2–4.3, §4.3, Thm 4.57 (?); May–Ponto 2012, *More Concise Algebraic Topology* (?); Whitehead 1978, *Homotopy Theory* (?); Félix–Halperin–Thomas 2001, *Rational Homotopy Theory* (?)
- conventions: Steenrod 1967, *Convenient category of topological…*
- theorem: Serre 1953, *Groupes d'homotopie et classes de…* (?); Sullivan 1977, *Infinitesimal computations in topology* (?); Hilton–Mislin–Roitberg 1975, *Localization of Nilpotent Groups and…* (?); Bousfield–Kan 1972, *Homotopy Limits, Completions and…* (?); Cornea et al. 2003, *Lusternik–Schnirelmann Category* (?); Weibel 2013, *K-book*, Ch. IV §1
- formal: Tau Ceti `AlgebraicTopology/EilenbergMacLane`; Mathlib `Topology/Homotopy`; OAI `Topology/Homotopy`

**HomotopicalAlgebra** (wave A)
- primary: Hovey 1999, *Model Categories*, §2.1, §2.4, Ch. 3 (?); Goerss–Jardine 2009, *Simplicial Homotopy Theory*, Ch. I §11, Ch. II, Ch. VII; Hirschhorn 2003, *Model Categories and Their Localizations*, Ch. 3–4, Ch. 15, Ch. 18–19 (?); Riehl 2014, *Categorical Homotopy Theory* (?)
- theorem: Quillen 1967, *Homotopical Algebra* (?); Lurie 2009, *Higher Topos Theory*, App. A.2–A.3 (?); Beke 2000, *Sheafifiable homotopy model categories* (?); Quillen 1973, *Higher algebraic K-theory*, §1 (?); Thomason 1979, *Homotopy colimits in the category of…* (?); Thomason 1980, *Cat as a closed model category* (?)
- formal: Mathlib `AlgebraicTopology/ModelCategory`; OAI `CategoryTheory/Thomason`

**CharacteristicClassesAndCobordism** (wave B)
- primary: Milnor–Stasheff 1974, *Characteristic Classes*, §5–7, §8, §9 (?); Husemoller 1994, *Fibre Bundles* (?); Steenrod 1951, *Topology of Fibre Bundles* (?); Stong 1968, *Cobordism Theory* (?)
- theorem: Milnor 1956, *Construction of universal bundles, II* (?); Borel 1953, *Sur la cohomologie des espaces fibrés…* (?); Thom 1954, *Quelques propriétés globales des…*; Pontryagin 1959, *Smooth manifolds and their applications…* (?); Hirzebruch 1966, *Topological Methods in Algebraic…* (?)
- statement: Milnor 1956, *Manifolds homeomorphic to the 7-sphere* (?)
- formal: Mathlib `Topology/FiberBundle`

**InfinityCategories** (wave A)
- primary: Lurie 2009, §2.2.5, §2.2.1, §3.2 (?); Lurie 2017, *Higher Algebra*, §1.1, §1.2, §1.3 (?); Cisinski 2019, *Higher Categories and Homotopical…* (?); Lurie n.d., *Kerodon: an online resource for…*; Riehl–Verity 2022, *∞-Category Theory*
- theorem: Joyal 2002, *Quasi-categories and Kan complexes* (?); Joyal 2008, *Theory of quasi-categories and its…* (?); Liu–Zheng 2012, *Enhanced six operations and base change…*, §2 (?)
- formal: Mathlib `AlgebraicTopology/Quasicategory`; `emilyriehl/infinity-cosmos`; McKoen 2026, *Formalization of Functor…* (?)

**StrictHigherCategories** (wave B)
- primary: Ara et al. 2025, *Polygraphs* (?)
- conventions: Maltsiniotis 2010, *Grothendieck ∞-groupoids, and still…* (?)
- theorem: Street 1987, *Algebra of oriented simplexes* (?); Steiner 2004, *Omega-categories and chain complexes* (?); Lafont–Métayer–Worytkiewicz 2010, *Folk model structure on omega-cat* (?); Ara–Maltsiniotis 2014, *Vers une structure de catégorie de…* (?); Ara–Maltsiniotis 2020, *Joint et tranches pour les ∞-catégories…* (?); Ara 2013, *Homotopy theory of Grothendieck…* (?)
- statement: Grothendieck 1983, *Pursuing Stacks (À la poursuite des…* (?); Henry 2020, *Weak model categories in classical and…* (?); OpenAI 2026, *Grothendieck homotopy hypothesis via…* (OAI#312); OpenAI 2026, *Thomason Model Structures in Every…* (OAI#317)
- formal: OAI `CategoryTheory/Thomason`

**KhovanovHomology** (wave A)
- primary: Khovanov 2000, *Categorification of the Jones polynomial*; Bar-Natan 2002, *Khovanov's categorification of the…*; Bar-Natan 2005, *Khovanov's homology for tangles and…*; Turner 2017, *Five lectures on Khovanov homology* (?)
- conventions: Viro 2004, *Khovanov homology, its definitions and…* (?); Lickorish 1997, *Knot Theory* (?)
- theorem: Lee 2005, *Endomorphism of the Khovanov invariant*; Rasmussen 2010, *Khovanov homology and the slice genus*; Lee 2002, *Support of the Khovanov's invariants…* (?)
- statement: Kronheimer–Mrowka 2011, *Khovanov homology is an unknot-detector*
- formal: Tau Ceti `KnotTheory/PDCode`

**HyperbolicManifolds** (wave B)
- primary: Ratcliffe 2019, *Foundations of Hyperbolic Manifolds*, Thm 11.8.5 (?); Benedetti–Petronio 1992, *Hyperbolic Geometry* (?); Kapovich 2001, *Hyperbolic Manifolds and Discrete Groups* (?); Frigerio 2017, *Bounded Cohomology of Discrete Groups* (?); Witte Morris 2015, *Arithmetic Groups*
- theorem: Gromov 1982, *Volume and bounded cohomology* (?); Thurston 1980, *Geometry and Topology of Three-Manifolds*, Ch. 6 (?); Haagerup–Munkholm 1981, *Simplices of maximal volume in…* (?); Mostow 1973, *Strong Rigidity of Locally Symmetric…* (?); Prasad 1973, *Strong rigidity of Q-rank 1 lattices* (?); Bowditch 1993, *Geometrical finiteness for hyperbolic…* (?)
- statement: OpenAI 2026, *Modulus Proof of Cannon's Conjecture* (OAI#246); OpenAI 2026, *Integral scalar curvature bound for…* (OAI#335)

**TeichmullerTheory** (wave B)
- primary: Farb–Margalit 2012, *Primer on Mapping Class Groups*, Ch. 4, Ch. 6, Ch. 8 (?); Buser 1992, *Geometry and Spectra of Compact Riemann…* (?); Hubbard 2006, *Teichmüller Theory and Applications to…* (?); Imayoshi–Taniguchi 1992, *Teichmüller Spaces* (?)
- conventions: Wolpert 1983, *Symplectic geometry of deformations of…* (?)
- theorem: Ahlfors 2006, *Quasiconformal Mappings* (?); Fathi–Laudenbach–Poénaru 2012, *Thurston's Work on Surfaces* (?)
- statement: Masur–Minsky 1999, *Geometry of the complex of curves I* (?); Hatcher–Thurston 1980, *Presentation for the mapping class…* (?)

**ThreeManifoldTopology** (wave B)
- primary: Hempel 1976, *3-Manifolds*, Ch. 3, Ch. 4 (?); Jaco 1980, *Three-Manifold Topology* (?); Hatcher n.d., *Basic 3-Manifold Topology* (?); Matveev 2007, *Algorithmic Topology and Classification…* (?)
- theorem: Moise 1977, *Geometric Topology in Dimensions 2 and 3* (?); Milnor 1962, *Unique decomposition theorem for…* (?); Papakyriakopoulos 1957, *Dehn's lemma and the asphericity of…* (?); Waldhausen 1968, *Irreducible 3-manifolds which are…* (?); Jaco–Shalen 1979, *Seifert fibered spaces in 3-manifolds* (?); Johannson 1979, *Homotopy Equivalences of 3-Manifolds…* (?); Haken 1961, *Theorie der Normalflächen* (?); Scott 1983, *Geometries of 3-manifolds* (?)
- formal: Tau Ceti `LowDimTopology`

**SurgeryTheoryAndFourManifolds** (wave C)
- primary: Wall 1999, *Surgery on Compact Manifolds* (?); Ranicki 2002, *Algebraic and Geometric Surgery* (?); Cohen 1973, *Simple-Homotopy Theory* (?); Brown 1982, *Cohomology of Groups*, Ch. VIII; Gompf–Stipsicz 1999, *4-Manifolds and Kirby Calculus* (?)
- theorem: Milnor 1966, *Whitehead torsion* (?); Kervaire 1965, *Le théorème de Barden–Mazur–Stallings* (?); Wall 1965, *Finiteness conditions for CW-complexes* (?); Spivak 1967, *Spaces satisfying Poincaré duality* (?); Kirby 1989, *Topology of 4-Manifolds* (?); Davis 2008, *Geometry and Topology of Coxeter Groups* (?)
- statement: Lück–Reich 2005, *Baum–Connes and the Farrell–Jones…* (?); Freedman–Quinn 1990, *Topology of 4-Manifolds* (?); Behrens et al. 2021, *Disc Embedding Theorem* (?); Donaldson 1983, *Application of gauge theory to…* (?); OpenAI 2026, *Boundary-only obstruction to…* (OAI#305); OpenAI 2026, *Nonhomeomorphic closed aspherical…* (OAI#320); OpenAI 2026, *Counterexample to Wall's D(2) Problem* (OAI#321)

**TransformationGroups** (wave B)
- primary: Bredon 1972, *Compact Transformation Groups* (?); tom Dieck 1987, *Transformation Groups* (?); Allday–Puppe 1993, *Cohomological Methods in Transformation…* (?); Lück 2005, *Survey on classifying spaces for…* (?); Bredon 1997, *Sheaf Theory* (?)
- theorem: Hsiang 1975, *Cohomology Theory of Topological…* (?); Quillen 1971, *Spectrum of an equivariant cohomology… II* (?); Borel 1960, *Seminar on Transformation Groups* (?); Smith 1938, *Transformations of finite period* (?); Newman 1931, *Theorem on periodic transformations of…* (?)
- statement: Yang 1960, *p-adic transformation groups* (?); Pardon 2013, *Hilbert–Smith conjecture for…* (?); OpenAI 2026, *Hilbert–Smith conjecture in every…* (OAI#304)

**TopologicalSixOperations** (wave B)
- primary: Kashiwara–Schapira 1990, *Sheaves on Manifolds*, Ch. II, Ch. III, Ch. VIII (?); Iversen 1986, *Cohomology of Sheaves* (?); Bredon 1997 (?); Dimca 2004, *Sheaves in Topology* (?); Schürmann 2003, *Topology of Singular Spaces and…* (?)
- theorem: Verdier 1965, *Dualité dans la cohomologie des espaces…* (?); Spaltenstein 1988, *Resolutions of unbounded complexes* (?); Kashiwara–Schapira 2006, *Categories and Sheaves*; Borel–Moore 1960, *Homology theory for locally compact…* (?)
- formal: Mathlib `Topology/Sheaves`

**TopologicalCombinatorics** (wave A)
- primary: Matoušek 2003, *Using the Borsuk–Ulam Theorem*, Ch. 2 (?); Kozlov 2008, *Combinatorial Algebraic Topology* (?); Björner 1995, *Topological methods* (?); Wachs 2007, *Poset topology* (?); Smith 2011, *Subgroup Complexes* (?)
- theorem: Quillen 1978, *Homotopy properties of the poset of…* (?); Forman 1998, *Morse theory for cell complexes* (?); Lovász 1978, *Kneser's conjecture, chromatic number…* (?); Bárány–Shlosman–Szűcs 1981, *Topological generalization of a theorem…* (?); Stone–Tukey 1942, *Generalized "sandwich" theorems* (?); Brown 1975, *Euler characteristics of groups* (?)
- statement: Aschbacher–Smith 1993, *Quillen's conjecture for the…* (?); OpenAI 2026, *Rational homology and Quillen's…* (OAI#310)

**StableHomotopyTheory** (umbrella, wave B)
- primary: Adams 1974, *Stable Homotopy and Generalised Homology*, Part III (?); Ravenel 1986, *Complex Cobordism and Stable Homotopy…* (?); Barnes–Roitzheim 2020, *Foundations of Stable Homotopy Theory* (?); Lurie 2017 (?)
- conventions: Hovey–Palmieri–Strickland 1997, *Axiomatic stable homotopy theory* (?); Hovey–Shipley–Smith 2000, *Symmetric spectra* (?)

**StableHomotopyTheory/Spectra** (wave B)
- primary: Schwede 2012, *Symmetric Spectra* (?); Adams 1974 (?); Barnes–Roitzheim 2020 (?)
- conventions: Hovey–Shipley–Smith 2000 (?)
- theorem: Bousfield–Friedlander 1978, *Homotopy theory of Γ-spaces, spectra…* (?); Mandell et al. 2001, *Model categories of diagram spectra* (?); Brown 1962, *Cohomology theories* (?); Spanier–Whitehead 1955, *Duality in homotopy theory* (?); Atiyah–Hirzebruch 1961, *Vector bundles and homogeneous spaces* (?); Bousfield 1979, *Localization of spectra with respect to…* (?); Serre 1953 (?); Lurie 2017, §1.4 (?)
- formal: Mathlib `CategoryTheory/Triangulated`

**StableHomotopyTheory/InfiniteLoopSpacesAndRingSpectra** (wave B)
- primary: May 1972, *Geometry of Iterated Loop Spaces* (?); Adams 1978, *Infinite Loop Spaces* (?); Elmendorf et al. 1997, *Rings, Modules, and Algebras in Stable…* (?)
- conventions: Hovey–Shipley–Smith 2000 (?)
- theorem: Segal 1974, *Categories and cohomology theories* (?); McDuff–Segal 1976, *Homology fibrations and the…* (?); Boardman–Vogt 1973, *Homotopy Invariant Algebraic Structures…* (?); Schwede–Shipley 2000, *Algebras and modules in monoidal model…* (?); Lurie 2017, Ch. 5 (?); Ando et al. 2014, *∞-categorical approach to R-line…* (?)

**StableHomotopyTheory/SteenrodAlgebraAndAdamsSpectralSequence** (wave B)
- primary: Steenrod–Epstein 1962, *Cohomology Operations* (?); Mosher–Tangora 1968, *Cohomology Operations and Applications…* (?); Hatcher 2002, §4. (?); Ravenel 1986, Ch. 2, Ch. 3 (?)
- theorem: Milnor 1958, *Steenrod algebra and its dual* (?); Adem 1952, *Iteration of the Steenrod squares in…* (?); Serre 1953, *Cohomologie modulo 2 des complexes…* (?); Adams 1958, *Structure and applications of the…* (?); Adams 1960, *Non-existence of elements of Hopf…* (?); Browder 1969, *Kervaire invariant of framed manifolds…*
- statement: Hill–Hopkins–Ravenel 2016, *Nonexistence of elements of Kervaire…* (?); OpenAI 2026, *Kervaire invariant problem at the prime…* (OAI#309); OpenAI 2026, *Stable Hurewicz Image of the Sphere at…* (OAI#316)

**StableHomotopyTheory/TopologicalKTheory** (wave B)
- primary: Atiyah 1967, *K-Theory* (?); Karoubi 1978, *K-Theory: An Introduction* (?); Hatcher 2017, *Vector Bundles and K-Theory*
- theorem: Atiyah–Bott 1964, *Periodicity theorem for complex vector…* (?); Bott 1959, *Stable homotopy of the classical groups*; Atiyah–Bott–Shapiro 1964, *Clifford modules* (?); Adams–Atiyah 1966, *K-theory and the Hopf invariant* (?); Adams 1962, *Vector fields on spheres* (?); Adams 1963, *Groups J(X) I–IV* (?)
- statement: Quillen 1971, *Adams conjecture* (?); Atiyah–Segal 1969, *Equivariant K-theory and completion* (?)

**StableHomotopyTheory/ComplexCobordism** (wave C)
- primary: Ravenel 1986, App. A2, Ch. 4, Ch. 5 (?); Adams 1974, Part II (?); Lurie 2010, *Chromatic Homotopy Theory (Math 252x…* (?)
- theorem: Lazard 1955, *Sur les groupes de Lie formels à un…*; Milnor 1960, *Cobordism ring Ω* and a complex… I* (?); Quillen 1969, *Formal group laws of unoriented and…* (?); Brown–Peterson 1966, *Spectrum whose Z_p cohomology is the…* (?); Landweber 1976, *Homological properties of comodules…* (?); Conner–Floyd 1966, *Relation of Cobordism to K-Theories* (?); Miller–Ravenel–Wilson 1977, *Periodic phenomena in the Adams–Novikov…* (?)
- statement: Hahn–Wilson 2022, *Redshift and multiplication for…* (?); OpenAI 2026, *Finite Smith–Toda Complexes at Varying…* (OAI#308)
- formal: Mathlib `RingTheory/FormalGroup/Basic`

**StableHomotopyTheory/ChromaticHomotopyTheory** (wave C)
- primary: Ravenel 1992, *Nilpotence and Periodicity in Stable…* (?); Hovey–Strickland 1999, *Morava K-theories and localisation* (?); Lurie 2010 (?); Barthel–Beaudry 2020, *Chromatic structures in stable…* (?)
- theorem: Ravenel 1984, *Localization with respect to certain…* (?); Hopkins–Smith 1998, *Nilpotence and stable homotopy theory II* (?); Balmer 2005, *Spectrum of prime ideals in tensor…* (?); Thomason 1997, *Classification of triangulated…* (?)
- statement: Devinatz–Hopkins–Smith 1988, *Nilpotence and stable homotopy theory I* (?); Devinatz–Hopkins 2004, *Homotopy fixed point spectra for closed…* (?); Goerss–Hopkins 2004, *Moduli spaces of commutative ring…* (?); Burklund et al. 2023, *K-theoretic counterexamples to…* (?); OpenAI 2026, *Stabilizer orbits and thick tensor…* (OAI#311); OpenAI 2026, *Finite generation for the K(n)-local…* (OAI#313); OpenAI 2026, *Filtered chromatic splitting at generic…* (OAI#318)

**StableHomotopyTheory/EquivariantStableHomotopyTheory** (wave C)
- primary: Lewis–May–Steinberger 1986, *Equivariant Stable Homotopy Theory* (?); May 1996, *Equivariant Homotopy and Cohomology…* (?); Hill–Hopkins–Ravenel 2021, *Equivariant Stable Homotopy Theory and…* (?)
- conventions: Mandell 2004, *Equivariant symmetric spectra* (?); Hausmann 2017, *G-symmetric spectra, semistability and…* (?)
- theorem: Mandell–May 2002, *Equivariant orthogonal spectra and…* (?); Greenlees–May 1995, *Generalized Tate cohomology* (?); tom Dieck 1975, *Orbittypen und äquivariante Homologie II* (?); Balmer–Sanders 2017, *Spectrum of the equivariant stable…* (?)
- statement: Carlsson 1984, *Equivariant stable homotopy and Segal's…* (?); Hill–Hopkins–Ravenel 2016 (?); OpenAI 2026, *Cyclic length and chromatic fixed-point…* (OAI#314)

**AlgebraicKTheory** (umbrella, wave A)
- primary: Weibel 2013, Ch. II, Ch. III, Ch. IV–V; Friedlander–Grayson 2005, *Handbook of K-Theory*; Srinivas 1996, *Algebraic K-Theory* (?); Rosenberg 1994, *Algebraic K-Theory and Its Applications* (?)
- theorem: Quillen 1973 (?)

**AlgebraicKTheory/ClassicalKTheory** (wave A)
- primary: Weibel 2013, Ch. I, Ch. II, Ch. III; Milnor 1971, *Algebraic K-Theory* (?); Bass 1968, *Algebraic K-Theory* (?); Gille–Szamuely 2006, *Central Simple Algebras and Galois…*, Ch. 6, Ch. 7
- theorem: Milnor 1970, *Algebraic K-theory and quadratic forms*; Matsumoto 1969, *Sur les sous-groupes arithmétiques des…* (?); Bass–Tate 1973, *Milnor ring of a global field* (?); Bass 1976, *Euler characteristics and characters of…* (?); Dennis–Stein 1973, *K₂ of radical ideals and semi-local…* (?); Milnor 1966 (?)
- statement: Bass–Milnor–Serre 1967, *Solution of the congruence subgroup…*; Merkurjev–Suslin 1982, *K-cohomology of Severi–Brauer varieties…* (?); OpenAI 2026, *Bass trace conjecture and the…* (OAI#207)
- formal: Tau Ceti `CategoryTheory/GrothendieckGroup`; Mathlib `RingTheory/PicardGroup`; OAI `{RingTheory/BassTrace, RingTheory/DirectFiniteness, …}`; OAI `GroupTheory/PeriodicGroups/Steinberg`

**AlgebraicKTheory/HigherAlgebraicKTheory** (wave B)
- primary: Weibel 2013, Ch. IV, Ch. V, Ch. VI §5; Schlichting 2011, *Higher algebraic K-theory (after…* (?)
- theorem: Quillen 1973 (?); Grayson 1976, *Higher algebraic K-theory* (?); Waldhausen 1985, *Algebraic K-theory of spaces* (?); Schlichting 2006, *Negative K-theory of derived categories*; Thomason–Trobaugh 1990, *Higher algebraic K-theory of schemes…*, §1; Quillen 1972, *Cohomology and K-theory of the general…* (?); McDuff–Segal 1976 (?); Suslin 1991, *K₃ of a field and the Bloch group* (?)
- statement: Waldhausen–Jahren–Rognes 2013, *Spaces of PL Manifolds and Categories…* (?)

**AlgebraicKTheory/KTheoryOfSchemes** (wave C)
- primary: Thomason–Trobaugh 1990; Weibel 2013, Ch. V; Fulton–Lang 1985, *Riemann–Roch Algebra* (?)
- theorem: Quillen 1973, §7 (?); Bloch 1974, *K₂ and algebraic cycles* (?); Soulé 1985, *Opérations en K-théorie algébrique*; Weibel 1989, *Homotopy algebraic K-theory* (?)
- statement: Panin 2003, *Equicharacteristic case of the Gersten…* (?); Land–Tamme 2019, *K-theory of pullbacks* (?); Kerz–Strunk–Tamme 2018, *Algebraic K-theory and descent for…* (?); OpenAI 2026, *Integral counterexample to Gersten's…* (OAI#209)

**AlgebraicKTheory/TraceMethods** (wave C)
- primary: Loday 1998, *Cyclic Homology* (?); Weibel 1994, *Homological Algebra*, Ch. 9; Nikolaus–Scholze 2018, *Topological cyclic homology*; Dundas–Goodwillie–McCarthy 2013, *Local Structure of Algebraic K-Theory* (?)
- theorem: Hochschild–Kostant–Rosenberg 1962, *Differential forms on regular affine…* (?); Goodwillie 1985, *Cyclic homology, derivations, and the…* (?); Goodwillie 1986, *Relative algebraic K-theory and cyclic…* (?); Bökstedt–Hsiang–Madsen 1993, *Cyclotomic trace and algebraic K-theory…* (?); Bökstedt 1985, *Topological Hochschild homology* (?); Hesselholt–Madsen 1997, *K-theory of finite algebras over Witt…* (?); Antieau et al. 2022, *Beilinson fiber square*
- statement: Land–Tamme 2019 (?); Hahn–Wilson 2022 (?)

**AlgebraicKTheory/HermitianKTheoryAndLTheory** (wave A)
- primary: Ranicki 1992, *Algebraic L-Theory and Topological…* (?); Wall 1999 (?); Knus 1991, *Quadratic and Hermitian Forms over Rings* (?); Balmer 2005, *Witt groups* (?); Milnor–Husemoller 1973, *Symmetric Bilinear Forms*; Lam 2005, *Quadratic Forms over Fields*; Elman–Karpenko–Merkurjev 2008, *Algebraic and Geometric Theory of…*
- theorem: Ranicki 1980, *Algebraic theory of surgery I, II* (?); Balmer 2000, *Triangular Witt groups. Part I* (?); Schlichting 2017, *Hermitian K-theory, derived…* (?)
- statement: Karoubi 1980, *Le théorème fondamental de la K-théorie…* (?)
- formal: Tau Ceti `LinearAlgebra/QuadraticForm/Witt`

**AlgebraicKTheory/MotivicHomotopyTheory** (wave C)
- primary: Morel–Voevodsky 1999, *A¹-homotopy theory of schemes* (?); Mazza–Voevodsky–Weibel 2006, *Motivic Cohomology*; Voevodsky–Suslin–Friedlander 2000, *Cycles, Transfers, and Motivic Homology…* (?)
- conventions: Jardine 2000, *Motivic symmetric spectra* (?)
- theorem: Voevodsky 1998, *A¹-homotopy theory* (?); Voevodsky 2010, *Cancellation theorem* (?); Voevodsky 2002, *Motivic cohomology groups are…* (?); Bloch 1986, *Algebraic cycles and higher K-theory* (?); Nesterenko–Suslin 1989, *Homology of the general linear group…* (?); Morel 2004, *Motivic π₀ of the sphere spectrum* (?); Levine 2008, *Homotopy coniveau tower* (?); Friedlander–Suslin 2002, *Spectral sequence relating algebraic…* (?)
- statement: Voevodsky 2003, *Reduced power operations in motivic…*; Cisinski–Déglise 2019, *Triangulated Categories of Mixed Motives*; Bachmann et al. 2022, *Chow t-structure on the ∞-category of…* (?)

**AlgebraicKTheory/NormResidueTheorem** (wave C)
- primary: Haesemeyer–Weibel 2019, *Norm Residue Theorem in Motivic…* (?); Weibel 2009, *Norm residue isomorphism theorem* (?); Gille–Szamuely 2006, Ch. 8; Mazza–Voevodsky–Weibel 2006
- conventions: Serre 1997, *Galois Cohomology*
- theorem: Voevodsky 2003, *Motivic cohomology with Z/2-coefficients* (?); Voevodsky 2011, *Motivic cohomology with Z/l-coefficients*; Voevodsky 2003; Suslin–Joukhovitski 2006, *Norm varieties* (?); Suslin–Voevodsky 2000, *Bloch–Kato conjecture and motivic…* (?); Merkurjev–Suslin 1982 (?)

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Quillen 1973, *Higher algebraic K-theory* [4] ★; Merkurjev–Suslin 1982, *K-cohomology of Severi–Brauer varieties…* [2] ★; Milnor 1966, *Whitehead torsion* [2] ★; Serre 1953, *Groupes d'homotopie et classes de…* [2] ★; Wall 1999, *Surgery on Compact Manifolds* [2] ★; Bass 1968, *Algebraic K-Theory* [1] ★; Bousfield–Kan 1972, *Homotopy Limits, Completions and…* [1] ★; Cornea et al. 2003, *Lusternik–Schnirelmann Category* [1] ★; Félix–Halperin–Thomas 2001, *Rational Homotopy Theory* [1] ★; Friedlander–Grayson 2005, *Handbook of K-Theory* [1] ★; Goerss–Jardine 2009, *Simplicial Homotopy Theory* [1] ★; Hilton–Mislin–Roitberg 1975, *Localization of Nilpotent Groups and…* [1] ★; Hirschhorn 2003, *Model Categories and Their Localizations* [1] ★; Hovey 1999, *Model Categories* [1] ★; Knus 1991, *Quadratic and Hermitian Forms over Rings* [1] ★; Kozlov 2008, *Combinatorial Algebraic Topology* [1] ★; Lickorish 1997, *Knot Theory* [1] ★; Matoušek 2003, *Using the Borsuk–Ulam Theorem* [1] ★; Milnor 1971, *Algebraic K-Theory* [1] ★; Milnor–Husemoller 1973, *Symmetric Bilinear Forms* [1] ★; Quillen 1967, *Homotopical Algebra* [1] ★; Ranicki 1992, *Algebraic L-Theory and Topological…* [1] ★; Rosenberg 1994, *Algebraic K-Theory and Its Applications* [1] ★; Smith 2011, *Subgroup Complexes* [1] ★; Srinivas 1996, *Algebraic K-Theory* [1] ★; Whitehead 1978, *Homotopy Theory* [1] ★; Adams 1974, *Stable Homotopy and Generalised Homology* [3]; Ravenel 1986, *Complex Cobordism and Stable Homotopy…* [3]; Barnes–Roitzheim 2020, *Foundations of Stable Homotopy Theory* [2]; Bredon 1997, *Sheaf Theory* [2]; McDuff–Segal 1976, *Homology fibrations and the…* [2].

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
