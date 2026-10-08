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
