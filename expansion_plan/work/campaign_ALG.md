# Campaign ALG: algebra (math.AC, math.RA, math.GR, math.RT, math.QA)

Phase-2 slate, 2026-10-07. Machine-readable twin: `slate_ALG.json` (34 objects: 3 umbrella indexes,
31 roadmaps; full milestone lists and the phase-1 names each roadmap absorbs are there).

## 1. Scope

Groups (finite and infinite, through presentations, actions, geometry and representations),
associative, commutative and universal algebras, and the Lie-, Hecke- and tensor-categorical
structures of representation theory. Logic leaves for LTCS; group von Neumann algebras for FAMP.

Demand (`needs_all.jsonl`, `campaign == ALG`): **166 needs** over 64 OAI families, 15 Annals entries
and 3 LMFDB sections; another 116 rows in other campaigns list ALG as secondary.

| goal | needs | gap | mathlib | tc-code | tc-roadmap | open-pr | birkbeck | oai-lean |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| OpenAI | 136 | 48 | 39 | 18 | 14 | 4 | 6 | 7 |
| Annals | 18 | 7 | 1 | 4 | 0 | 0 | 6 | 0 |
| LMFDB | 12 | 4 | 2 | 2 | 3 | 1 | 0 | 0 |

By class: GR 78 (33 gap), RT 47 (22), AC 19 (2), RA 15 (2), QA 7 (0). Most `mathlib` rows are
statement vocabulary (`PresentedGroup`, word metric, `FoelnerFilter`, `MonoidAlgebra`) with the
theory absent: nothing in Mathlib or Tau Ceti defines quasi-isometry, hyperbolic groups, CAT(0),
amenable groups, depth or Cohen–Macaulay rings (grep at `6b7abb3c` / `a91d3aafa`).

## 2. Existing supply

**Tau Ceti main.**
- **RepresentationTheory** (13 members, ≈83% of layers done, ≈270 PRs left; serves OAI#126, 198, 199, 204, 205, 210, 238, 265, Annals#54, LMFDB group.abstract/artin/st_group). *Extend:* amend its exclusions to host §3.3; finish LieGroups L6–L9 (Weyl integration for NT's SatoTateGroups, KAK for Lattices) and QuiverRepresentations L6 (AR sequences for Tilting); add the plethysm character of Sym^a(Sym^b V) to ClassicalGroups (OAI#210).
- **ReductiveGroups** (math.AG; ≈600 PRs left; 21 needs). Supplier of §3.4 and Lattices; ALG asks that L7 land early. *Leave* with AG.
- **CFSGStatement** (8/9). *Finish*; StructureOfFiniteGroups states CFSG consequences against it.
- **ProfiniteCohomology** (4/14): NT's Galois-cohomology base, no ALG demand; *leave* in NT's lane.
- **ProfiniteProPGroups**, **ProfiniteArithmetic** (complete except trivia), **RestrictedProducts** (complete, #720). *Archive.*
- **PeripheralActions** (5/6). *Leave*; GrothendieckTeichmuller's GT-hat layer consumes it.
- **GrothendieckEulerForms** (4/8), **StablePeriodicCurved** (1/9). *Leave*; Tilting consumes both. **ZigzagPreprojective** (3/9): *leave*, no goal demand.
- **PolynomialGaloisGroups** (complete except trivia): degree ≥ 6 transitive groups go to NT's LMFDBLabelsAndCompleteness via #717.

**Open PRs.**
- **#446/#698 CFSGBasicProperties**, **#447/#697 ChevalleyGroups**: *merge soon* (OAI#018, 203, 206, 310, Annals#8, LMFDB group.abstract; RepresentationsOfFiniteGroupsOfLieType and AG's ReductiveGroupSchemes build on #447).
- **#599 SporadicOrders** (S): *merge* (LMFDB group.abstract). **#717 CertifiedPermutationComputation** (opened today): *review* (LMFDB gg, degrees 6–47).
- **#57 PivotalSpherical**: *merge soon* (Annals#59, OAI#208, 280; TensorCategories and FAMP's AQFT wait). **#58 TemperleyLieb**: *merge* (OAI#208; FAMP's Jones index).
- **#323 GorensteinHomologicalAlgebra** (awaiting-author; no `metadata.toml`, topic should be math.RA): *unblock* (OAI#199, Tilting).
- **#222 HopfologicalAlgebra** (math.KT), **#223 McKaySkewGroup**: *leave*, no goal demand.
- **#437 ClassifyingSpaces** (TOP's): *merge soon*; five GGT members and 12 needs cite it.

**Birkbeck campaign and explorer drafts.**
- **SmoothRepresentationsOfLocalGroups** (22E): *promote into RepresentationsOfReductiveGroups* as its p-adic foundation (coordination §3.3), with the generic orbital-integral, character and Plancherel stages of AutomorphicSpectralTheory and EndoscopicTransfer; SR.5–SR.6 stay NT-facing. Serves Annals#43, 52, 60, OAI#014, 030.
- **DeformationAndDerivedPatchingAlgebra** (13D): *promote* R03.1–R03.4, R03.6, P7, P9 into CommutativeAlgebra; R03.5, P8 stay NT; R03.3's depth consumes CohenMacaulayRings. Its explorer continuation (Kawasaki CM blowups) stays NT-facing.
- **ReductiveGroupsPartII**, **AdelicAlgebraicGroups** (MSC 20G, hence tallied math.GR): AG's BruhatTitsTheory and ReductiveGroupSchemes absorb RG2; AA stays NT and exports AA.3 to Lattices.
- **KTheoryLowDegrees**, **K2SymbolsBrauer** (KT): GroupRings imports K_0; AmenabilityAndPropertyT imports Steinberg groups.
- **HabiroRings**, **HabiroCyclotomicCompletions** (13F/13J): AG's HabiroCohomology family.
- Explorer drafts SemisimpleAlgebrasPartII, InductionRestrictionPartII, ClassicalGroupsPartII: NT-driven extensions of existing members; *leave*.

## 3. The slate

**Shape.** Three umbrella families (GeometricGroupTheory, RepresentationsOfReductiveGroups,
CommutativeAlgebra), five new members of RepresentationTheory, seven standalone roadmaps: 31
roadmaps (24 L, 7 M) absorbing 49 phase-1 proposal names. Boundary decisions taken here:
MeasuredGroupTheory → PRDS (BOUNDARIES assigns measure-preserving systems there; fallback: a GGT
member); AffineGrassmannians → AG (ind-scheme foundations; matches `slate_AG.json`);
TransformationGroups and BoundedCohomology → TOP, importing amenability; AlexandrovAndCATSpaces
splits (upper curvature bounds, cube and Davis complexes → NonpositiveCurvature; CBB → GEO);
abstract buildings → NonpositiveCurvature, the building of G(K) and Moy–Prasad → AG's
BruhatTitsTheory; Procesi–Donkin invariants → AG's GeometricInvariantTheory; group von Neumann
algebras → FAMP's L2Invariants (GroupRings imports its trace).
Abbreviations below: CB = Birkbeck campaign, TC = Tau Ceti, RT/ = RepresentationTheory/; sizes are
estimated PRs; goal refs are OAI families, Annals entries and LMFDB sections.

### 3.1 GeometricGroupTheory family (math.GR)

**GeometricGroupTheory** (umbrella index; members ≈ 2000 PRs). An umbrella for infinite discrete groups studied through presentations, actions and geometry. Its members share one vocabulary, pinned in the index: Mathlib's word metric and Cayley graphs, one quasi-isometry structure, one hyperbolicity predicate, one CAT(0) predicate, one amenability predicate and the finiteness types F_n/FP_n.

**1. CombinatorialGroupTheory** — math.GR; L ≈ 250; wave A.
This roadmap develops groups given by generators and relations and the diagrammatic and algorithmic methods for studying them. It starts from Mathlib's `PresentedGroup`, `IsFinitelyPresented`, `CoprodI`, `PushoutI`, `HNNExtension` and Nielsen-Schreier and from Tau Ceti's presentation files, and it ends at Higman's embedding theorem and the finitely presented simple Thompson groups. Diagrams and pictures use one combinatorial planar-map model. Graphs of groups are GroupsActingOnTrees; quasi-isometry invariance of Dehn functions is CoarseGeometryAndHyperbolicGroups; Turing machines and undecidability are imported from LTCS's ComputabilityTheory; linear groups and Mal'cev's residual finiteness are NilpotentSolvableAndLinearGroups.
*Headlines:* van Kampen's lemma; pictures; C'(1/6) small cancellation; one-relator groups (Freiheitssatz, Lyndon, torsion theorem); Klyachko; Novikov-Boone; Higman embedding; Thompson F, T, V, nV. *Needs:* AlgebraicTopology (presentation complex); TOP ClassifyingSpaces #437 (asphericity); LTCS ComputabilityTheory. *Serves:* OpenAI 11 (#196, #197, #247, #248, #250, #252, #253, #256, #257, #258, #285). *Port:* OAI Geometry/HyperbolicGroups (57k lines), GroupTheory/{Kervaire, Thompson, BooneHigman}. *Formalizability:* textbook; the diagram model is the design risk.

**2. GroupsActingOnTrees** — math.GR; M ≈ 120; wave A.
Bass-Serre theory: groups acting without inversion on simplicial trees, graphs of groups and their fundamental groups, and the structure theorems they give. It consumes CombinatorialGroupTheory's amalgams and HNN normal forms and Mathlib's trees, and it ends at Stallings' ends theorem, whose corollary cd 1 implies free is proved in FinitenessPropertiesOfGroups. R-trees and hyperbolicity are CoarseGeometryAndHyperbolicGroups; the tree of SL2 over a local field is the worked example, and buildings in general are NonpositiveCurvature.
*Headlines:* Bass-Serre structure theorem; Kurosh; subgroups of amalgams and HNN extensions; property FA; SL2(Z) as an amalgam; Ihara's theorem; Freudenthal-Hopf ends; Stallings' ends theorem. *Needs:* CombinatorialGroupTheory. *Serves:* OpenAI 3 (#196, #256, #258). *Formalizability:* textbook (Serre, Trees).

**3. CoarseGeometryAndHyperbolicGroups** — math.GR; L ≈ 280; wave A.
Coarse geometry of metric spaces and finitely generated groups, and Gromov hyperbolicity. It fixes one definition of each notion the OpenAI formalizations define ad hoc (quasi-isometry; hyperbolic space by the four-point Gromov-product condition; hyperbolic group via any finite generating set; Gromov boundary by sequences converging at infinity) and proves them equivalent to thin triangles, linear isoperimetry and the Cayley-walk and geodesic-ray formulations of the OAI comparators. It starts from Mathlib's word metric, Cayley graphs and growth files. Polynomial growth is NilpotentSolvableAndLinearGroups; CAT(0) geometry is NonpositiveCurvature; quasisymmetric uniformization (Bonk-Kleiner, Cannon's conjecture) is GEO frontier.
*Headlines:* Svarc-Milnor; QI invariants; Grigorchuk's group; Morse lemma; hyperbolic iff linear isoperimetric; Rips complex; Tits alternative; quasiconvexity; boundary and visual metrics; relative and acylindrical hyperbolicity. *Needs:* CombinatorialGroupTheory; TOP ClassifyingSpaces #437 (K(G,1) corollary). *Serves:* OpenAI 8 (#246, #252, #254, #255, #257, #258, #315, #320); Annals 1 (#82). *Port:* OAI GroupTheory/Hyperbolic, Geometry/HyperbolicGroups/Basic, PolycyclicRecognition/Analysis (unify their definitions). *Formalizability:* textbook (Bridson-Haefliger, Ghys-de la Harpe).

**4. NonpositiveCurvature** — math.GR; L ≈ 300; wave A.
CAT(kappa) metric spaces, the polyhedral complexes that carry them, and groups acting geometrically on them: cube complexes, Coxeter-Davis complexes and buildings. It starts from Tau Ceti's length spaces and ends at Haglund-Wise specialness and the flat torus theorem. Alexandrov spaces of curvature bounded below, Toponogov and the theorem that Riemannian manifolds with sec <= kappa are locally CAT(kappa) are GEO's. Abstract buildings, including BN-pair buildings and Euclidean buildings as CAT(0) spaces, are here; the Bruhat-Tits building of a p-adic reductive group is AG's BruhatTitsTheory, which consumes them. Artin groups beyond the right-angled case are ArtinGroupsAndGarside.
*Headlines:* Cartan-Hadamard; Bruhat-Tits fixed point; link condition; Sageev; Salvetti and Davis complexes, Moussong; Haglund-Wise; flat torus theorem; BN-pair and Euclidean buildings. *Needs:* RT/RootSystems; CoarseGeometryAndHyperbolicGroups; TOP ClassifyingSpaces #437. *Serves:* OpenAI 10 (#177, #249, #252, #254, #257, #258, #305, #320, #337, #358). *Port:* OAI GroupTheory/{ArtinCAT0, RightAngledArtin}, Geometry/CAT0Fillings. *Formalizability:* textbook (Bridson-Haefliger, Abramenko-Brown, Sageev).

**5. ArtinGroupsAndGarside** — math.GR; M ≈ 150; wave B.
Artin-Tits groups of arbitrary Coxeter matrices: positive monoids, Garside theory in spherical type, parabolic subgroups, and the Salvetti and Deligne complexes that carry the K(pi,1) problem. It extends Tau Ceti's `GroupTheory/Coxeter/Artin` and parabolic API and ends at Deligne's theorem in spherical type and Charney-Davis for FC type. Right-angled Artin groups and their cube complexes are NonpositiveCurvature; braid groups as mapping class groups are TOP.
*Headlines:* Paris embedding; Garside normal form and word problem; Brieskorn-Saito center; van der Lek parabolics; Salvetti complex; Deligne's theorem; Charney-Davis for FC type. *Needs:* RT/RootSystems; NonpositiveCurvature; TOP ClassifyingSpaces #437. *Serves:* OpenAI 2 (#249, #254). *Port:* OAI Topology/ArtinGroups (82k: SalvettiCover, parabolic API). *Formalizability:* textbook (Dehornoy et al.).

**6. FinitenessPropertiesOfGroups** — math.GR; L ≈ 220; wave B.
Cohomological and geometric dimension and the homological and homotopical finiteness properties of discrete groups. It starts from Mathlib's `groupCohomology`, Tau Ceti's asphericity recognition and ClassifyingSpaces (#437), whose K(G,1) and identification of singular homology with group homology it consumes, and it ends at Bestvina-Brady Morse theory, Brown-Geoghegan and Poincare duality groups. Profinite cohomological dimension stays in ProfiniteProPGroups; L2-Betti numbers are FAMP's L2Invariants; aspherical manifolds and surgery are TOP.
*Headlines:* finite cd implies torsion-free; Serre; Stallings-Swan; Eilenberg-Ganea; F_n iff FP_n plus finite presentation; Euler characteristics; PD groups; Brown's criterion; Bestvina-Brady; F is F_infty. *Needs:* TOP ClassifyingSpaces #437; AlgebraicTopology; GroupsActingOnTrees; NonpositiveCurvature (cube complexes); CombinatorialGroupTheory. *Serves:* OpenAI 5 (#196, #249, #250, #305, #315). *Port:* OAI GroupTheory/FiniteType (45k), PolycyclicRecognition/Finiteness. *Formalizability:* textbook (Brown, Geoghegan).

**7. NilpotentSolvableAndLinearGroups** — math.GR; L ≈ 260; wave A.
Structure of nilpotent, polycyclic and finitely generated linear groups, and the theory of growth they culminate in. It starts from Mathlib's nilpotent and solvable groups and Tau Ceti's Fitting and Frattini files and ends at Gromov's polynomial growth theorem by Kleiner's route. Mal'cev's embedding of torsion-free nilpotent groups as lattices uses RepresentationTheory/LieGroups for the exponential map; lattices in semisimple groups are LatticesInSemisimpleGroups; growth functions and their QI invariance are CoarseGeometryAndHyperbolicGroups.
*Headlines:* Hirsch length; Mal'cev completions and lattices; Auslander-Swan; Mal'cev residual finiteness; Selberg; Tits alternative; Milnor-Wolf; Bass-Guivarc'h; Kleiner's harmonic functions; Gromov's polynomial growth theorem. *Needs:* RT/LieGroups L0-L4; CoarseGeometryAndHyperbolicGroups (growth); ReductiveGroups (Zariski closure). *Serves:* OpenAI 3 (#213, #252, #255). *Port:* Aaron1011/gromov (OAI dependency; coordinate first); OAI Probability/CriticalPercolation/Harmonic, PolycyclicRecognition/Lattices. *Formalizability:* textbook; an external Lean proof of Gromov exists.

**8. AmenabilityAndPropertyT** — math.GR; L ≈ 300; wave A.
Amenability and Kazhdan's property (T) for discrete and locally compact groups, following Bekka-de la Harpe-Valette and Ceccherini-Silberstein-Coornaert. It fixes one definition of amenability (an invariant mean) with equivalences to Mathlib's `FoelnerFilter`, the Finset Folner condition of the OAI comparators, Reiter, Kesten and Tarski. It develops unitary representations of locally compact groups as far as (T) needs: weak containment, the Fell topology, Howe-Moore and Mautner. FAMP's operator-algebra roadmaps, COMB's expander layer and PRDS import it; cost and orbit equivalence are PRDS; bounded cohomology is TOP.
*Headlines:* Folner-Reiter-Tarski; Kesten; Garden of Eden; Elek-Szabo; Dixmier; Juschenko-Monod; Delorme-Guichardet; Howe-Moore; (T) for SL_n(Z), n >= 3, and lattices; Ershov-Jaikin-Zapirain. *Needs:* OperatorTheory #126 (spectral calculus); CoarseGeometryAndHyperbolicGroups; KT CB K2SymbolsBrauer T.1 (Steinberg groups). *Serves:* OpenAI 12 (#103, #136, #197, #213, #214, #247, #248, #251, #253, #286, #292, #307); Annals 1 (#70). *Port:* OAI Analysis/Unitarizability, GroupTheory/SimpleAmenable (85k), Probability/BenjaminiSchramm. *Formalizability:* textbook (BdlHV, Juschenko).

**9. GroupRings** — math.GR; M ≈ 120; wave A.
Group algebras K[G] of infinite groups and Kaplansky's problems about them. It starts from Mathlib's `MonoidAlgebra` and Tau Ceti's augmentation and projective-trace files. It imports the canonical trace and Kaplansky's stable finiteness of C[G] from FAMP's L2Invariants, soficity and Elek-Szabo from AmenabilityAndPropertyT, and K_0 from the KT campaign's KTheoryLowDegrees, building a minimal K_0 layer only if that has not landed. It ends at the Bass trace conjecture and its known cases, Zalesskii's theorem, and Gardam's counterexample to the unit conjecture as a checked computation. The topic is math.GR, following arXiv practice for these problems.
*Headlines:* UP and orderable groups; zero-divisor and unit conjectures for UP groups; Gardam's counterexample; Zalesskii; Connell and Passman criteria; Hattori-Stallings rank; Bass trace conjecture stated; Dykema-Juschenko transfer. *Needs:* FAMP OperatorAlgebras/L2Invariants; AmenabilityAndPropertyT; KT CB KTheoryLowDegrees. *Serves:* OpenAI 3 (#196, #197, #207). *Port:* OAI RingTheory/{BassTrace (24k), DirectFiniteness}, Algebra/{OddKaplansky, GroupRing}. *Formalizability:* textbook plus Gardam's computation.

### 3.2 Standalone group theory (math.GR)

**10. LatticesInSemisimpleGroups** — math.GR; L ≈ 260; wave B.
Lattices in locally compact groups, with semisimple Lie groups and their arithmetic subgroups as the main case, following Raghunathan and Witte Morris. Its one `IsLattice` predicate specializes FuchsianOrbifolds' `IsCofinite` and the covolume predicates of KleinianGroups (#432). It builds Mahler's criterion and Siegel sets for SL_n(Z) directly and imports finite covolume of general arithmetic groups from the NT campaign's AdelicAlgebraicGroups AA.3. The Riemannian geometry of G/K is GEO's and its CAT(0) structure is NonpositiveCurvature; (T) and Howe-Moore come from AmenabilityAndPropertyT; homogeneous dynamics is PRDS, which consumes this roadmap.
*Headlines:* Mahler; Siegel sets for SL_n(Z); Borel density; Kazhdan-Margulis; Moore ergodicity; (T) in higher rank; Mostow, superrigidity, arithmeticity, NST stated. *Needs:* RT/LieGroups L9; ReductiveGroups; FuchsianOrbifolds; KleinianGroups #432; CB AdelicAlgebraicGroups AA.3; AmenabilityAndPropertyT; NonpositiveCurvature; NilpotentSolvableAndLinearGroups (Selberg); GEO RiemannianGeometry. *Serves:* OpenAI 2 (#018, #286); Annals 2 (#65, #77). *Formalizability:* textbook (Witte Morris); rigidity theorems stated.

**11. StructureOfFiniteGroups** — math.GR; L ≈ 230; wave A.
The structure theory of finite groups beyond Mathlib's Sylow, nilpotent and solvable groups: characteristic subgroups and series, classes of groups, local analysis, primitive permutation groups, and the invariants that group databases display. CFSG enters only through CFSGStatement's named proposition, so results that need it carry it as a hypothesis. Character-theoretic invariants (rational tables, Schur indices, faithful degrees) are RationalAndIntegralRepresentations; LMFDB labels and SmallGroup identifiers are NT's LMFDBLabelsAndCompleteness; certified permutation-group algorithms are #717.
*Headlines:* F*(G) and Bender; chief series; Hall; classes of groups; isoclinism; Mobius function; Gassmann triples; Malle constants; O'Nan-Scott; Quillen's poset; conditional CFSG consequences. *Needs:* CFSGStatement; CFSGBasicProperties #446/#698. *Serves:* OpenAI 4 (#018, #203, #206, #310); LMFDB 3 (group.abstract, gg, nf). *Port:* OAI GroupTheory/FiniteLattice. *Formalizability:* textbook (Isaacs, Kurzweil-Stellmacher, Dixon-Mortimer).

### 3.3 New members of the RepresentationTheory family (math.RT)

**12. ModularRepresentationTheory** — math.RT; L ≈ 270; wave A.
Representations of finite groups over fields of characteristic p dividing |G| and over complete discrete valuation rings: Brauer characters, blocks and defect groups, and the local-global correspondences of Brauer and Green. It starts from SemisimpleAlgebras, CharacterTheory, InductionRestriction and ModularInduction (G_0(k[G]), reduction modulo l) and ends at Brauer's main theorems, Green correspondence and the statements of the block conjectures. Rational representations of algebraic groups in characteristic p are RationalRepresentationsOfReductiveGroups; the modular theory of symmetric groups is outside.
*Headlines:* Brauer characters; C = D^T D; blocks and defect groups; Green correspondence; Brauer's three main theorems; Brauer-Feit; block conjectures stated; blocks of S3, S4, A5. *Needs:* RT/{SemisimpleAlgebras, CharacterTheory, InductionRestriction, ModularInduction}. *Serves:* OpenAI 2 (#202, #203); Annals 1 (#57). *Port:* OAI RepresentationTheory/{AlperinWeights, Block}. *Formalizability:* textbook (Navarro, Linckelmann, Webb).

**13. KacMoodyAlgebras** — math.RT; L ≈ 260; wave A.
Kac-Moody algebras of symmetrizable generalized Cartan matrices, their integrable highest-weight modules, and affine algebras as central extensions of loop algebras, following Kac. It extends RootSystems and LieHighestWeight beyond finite type and Tau Ceti's affine Dynkin types, and it ends at the Weyl-Kac character formula, the Macdonald identities, the Sugawara construction and the center at the critical level. Vertex algebras are VertexAlgebras; quantum groups are outside; affine Grassmannians are AG's.
*Headlines:* Gabber-Kac; real and imaginary roots; Weyl-Kac character formula; loop realization of affine algebras; Macdonald identities; Sugawara; critical-level center; Frenkel-Kac. *Needs:* RT/{RootSystems, LieHighestWeight}. *Serves:* Annals 2 (#56, #61). *Formalizability:* textbook (Kac).

**14. CrystalBases** — math.RT; M ≈ 120; wave A.
Combinatorial crystals for a root datum of finite type and the Littelmann path model, as a theory independent of quantum groups. It consumes RootSystems, LieHighestWeight's characters and SchurWeyl's tableaux and RSK, and it ends at Littelmann's generalized Littlewood-Richardson rule and the identification of type-A tableau crystals with B(lambda). Kashiwara's crystal bases of quantized enveloping algebras are outside; symmetric functions in infinitely many variables are COMB's.
*Headlines:* Stembridge axioms; B(lambda); LS paths and root operators; character formula; generalized LR rule; tableau crystals and RSK. *Needs:* RT/{RootSystems, LieHighestWeight, SchurWeyl}. *Serves:* OpenAI 1 (#204). *Formalizability:* textbook (Bump-Schilling).

**15. TiltingAndHomologicalDimensions** — math.RT; L ≈ 230; wave A.
Homological dimensions of finite-dimensional algebras and the tilting theory relating them, up to the precise statements and known implications of the homological conjectures. It continues QuiverRepresentations (path algebras, Auslander-Reiten theory) and uses StablePeriodicCurved (self-injective algebras), GorensteinHomologicalAlgebra (#323) and GrothendieckEulerForms. Derived categories of coherent sheaves are AG and DG enhancements are DGAInfinity.
*Headlines:* Brenner-Butler; Happel; Igusa-Todorov; trivial extensions symmetric; Auslander correspondence; Morita-Tachikawa; Muller; the homological conjectures and their implications. *Needs:* RT/QuiverRepresentations (L6); StablePeriodicCurved; GorensteinHomologicalAlgebra #323; GrothendieckEulerForms. *Serves:* OpenAI 2 (#198, #199). *Port:* OAI Algebra/{Finitistic, AuslanderReiten, FinitisticAsymmetry}, RingTheory/Tachikawa (135k). *Formalizability:* textbook (ARS, ASS).

**16. RationalAndIntegralRepresentations** — math.RT; M ≈ 140; wave A.
Representations of finite groups over non-closed fields and over Z: rational character tables, Schur indices, minimal faithful degrees, ZG-lattices, and finite subgroups of GL_n over Z, Q and C, as group databases display them. It extends CharacterTheory (indicators, Galois action on characters), SemisimpleAlgebras (central simple algebras, Brauer group) and InductionRestriction. Galois modules of number-field units are NT consumers.
*Headlines:* rational character tables; Brauer-Speiser and Benard-Schacher; minimal faithful degrees; Jordan-Zassenhaus; Diederichsen-Reiner; finite subgroups of GL_n(Z), GL_n(Q), SL_2(C). *Needs:* RT/{CharacterTheory, SemisimpleAlgebras, InductionRestriction}; NumberFieldArithmetic (class numbers); McKaySkewGroup #223 (finite subgroups of SU(2)). *Serves:* LMFDB 3 (group.abstract, gg, nf). *Formalizability:* textbook (Curtis-Reiner, Isaacs).

### 3.4 RepresentationsOfReductiveGroups family (math.RT)

**RepresentationsOfReductiveGroups** (umbrella index; members ≈ 1580 PRs). An umbrella for representations of G(F) when G is reductive and F is a finite or non-archimedean local field, for rational representations of reductive groups in positive characteristic, and for the Coxeter, Hecke and geometric machinery these share. It starts where RepresentationTheory (finite and compact groups, characteristic-zero Lie theory) and ReductiveGroups (the groups themselves) stop.

**17. HeckeAlgebrasAndKazhdanLusztigTheory** — math.RT; L ≈ 260; wave A.
Iwahori-Hecke algebras of Coxeter systems with unequal parameters, the Kazhdan-Lusztig basis and polynomials, cells, and affine Hecke algebras of extended affine Weyl groups. It builds on RootSystems and Tau Ceti's Coxeter code (strong exchange, Matsumoto, Bruhat order, parabolics). It identifies the generic algebra with End_G(Ind_B^G 1) for a finite BN-pair (Tau Ceti's Tits systems) and with H(G, I) for an Iwahori subgroup of a split p-adic group, through SmoothRepresentationsOfLocalGroups SR.1 and AG's BruhatTitsTheory. Positivity of KL polynomials is SoergelBimodules; the KL conjecture is SpringerTheoryAndLocalization.
*Headlines:* KL basis and polynomials; W-graphs; parabolic KL; cells; Bernstein presentation and center; Iwahori's theorem; H(G, I) noncommutative. *Needs:* RT/RootSystems; CB SmoothRepresentationsOfLocalGroups SR.1; AG BruhatTitsTheory (Iwahori subgroups). *Serves:* OpenAI 1 (#168); Annals 1 (#52). *Port:* OAI RepresentationTheory/KazhdanLusztig (43k). *Formalizability:* textbook (Bjorner-Brenti, Lusztig).

**18. SoergelBimodules** — math.RT; L ≈ 240; wave C.
Soergel bimodules of a realization of a Coxeter system, their categorification of the Hecke algebra, and the Elias-Williamson Hodge theory that proves positivity of Kazhdan-Lusztig polynomials for every Coxeter system, following Elias-Makisumi-Thiel-Williamson. It consumes HeckeAlgebrasAndKazhdanLusztigTheory and Mathlib's graded modules. The perverse-sheaf proof for Weyl groups is a statement in SpringerTheoryAndLocalization; general combinatorial invariance is frontier.
*Headlines:* Soergel's categorification theorem; diagrammatic Hecke category and light leaves; hard Lefschetz and Hodge-Riemann; positivity of KL polynomials for all Coxeter groups. *Needs:* HeckeAlgebrasAndKazhdanLusztigTheory. *Serves:* OpenAI 1 (#168). *Port:* OAI RepresentationTheory/KazhdanLusztig (Bott-Samelson, graded sheaves). *Formalizability:* recent textbook (EMTW), long.

**19. RepresentationsOfFiniteGroupsOfLieType** — math.RT; L ≈ 300; wave B.
Complex representations of finite reductive groups G^F by Harish-Chandra theory and Deligne-Lusztig theory, following Digne-Michel and Carter. The groups and Steinberg endomorphisms come from ChevalleyGroups (#447) and ReductiveGroups; compactly supported l-adic cohomology and the Lefschetz trace formula come from AG's #196 CohomologicalPointCounting. It recovers CharacterTheory's GL2(F_q) table. Lusztig's classification and the l-modular theory are statements.
*Headlines:* Lang-Steinberg; Harish-Chandra series; Steinberg character; R_T^theta; Green functions; Alvis-Curtis duality; GL2, SL2, GL3 tables. *Needs:* ChevalleyGroups #447/#697; ReductiveGroups L7; RT/{CharacterTheory, InductionRestriction}; HeckeAlgebrasAndKazhdanLusztigTheory; AG CohomologicalPointCounting #196; NonpositiveCurvature (buildings). *Serves:* OpenAI 1 (#203); Annals 1 (#54). *Formalizability:* textbook (Digne-Michel); DL half waits on #196.

**20. RationalRepresentationsOfReductiveGroups** — math.RT; L ≈ 240; wave B.
Rational representations of split reductive groups over fields of characteristic p, following Jantzen part II: induced and Weyl modules, simple modules, Frobenius kernels and tilting modules. It consumes ReductiveGroups (comodules, Borel subgroups, root data) and AG's FlagVarieties (line bundles on G/B, for Kempf vanishing); characteristic-zero highest-weight theory is LieHighestWeight. Its SL2 layer is complete and supplies TensorCategories' construction of Ver_p.
*Headlines:* Kempf vanishing; Weyl and simple modules; Steinberg tensor product theorem; linkage; tilting modules; SL2 complete. *Needs:* ReductiveGroups L1-L7; AG FlagVarieties; RT/LieHighestWeight; TemperleyLieb #58 (comparison). *Serves:* OpenAI 1 (#208); Annals 1 (#59). *Port:* OAI RepresentationTheory/RestrictedTilting (16k). *Formalizability:* textbook (Jantzen II).

**21. SpringerTheoryAndLocalization** — math.RT; L ≈ 280; wave B.
Nilpotent orbits of reductive Lie algebras, the Springer resolution and correspondence, and Beilinson-Bernstein localization: the geometric representation theory of a semisimple Lie algebra in characteristic zero on the flag variety and its cotangent bundle. Orbit classification is algebraic and starts from ReductiveGroups and LieHighestWeight's sl2 theory; flag varieties come from AG's FlagVarieties, twisted differential operators from AG's AlgebraicDModules, and perverse sheaves and the decomposition theorem from AG's PerverseSheavesOnComplexVarieties. Affine Springer fibres and geometric Satake are AG's AffineGrassmannians.
*Headlines:* Jacobson-Morozov-Kostant; orbit classification and closures; Springer resolution and fibres; Springer correspondence; Beilinson-Bernstein; KL conjecture chain stated. *Needs:* ReductiveGroups; RT/LieHighestWeight; AG FlagVarieties; AG AlgebraicDModules; AG PerverseSheavesOnComplexVarieties; HeckeAlgebrasAndKazhdanLusztigTheory. *Serves:* OpenAI 3 (#014, #062, #069); Annals 2 (#15, #53). *Formalizability:* textbook (Chriss-Ginzburg, HTT); geometric layers wave C.

**22. TypesAndSupercuspidalRepresentations** — math.RT; L ≈ 260; wave C.
Construction and exhaustion of supercuspidal representations of p-adic reductive groups through types. It consumes SmoothRepresentationsOfLocalGroups SR.0-SR.3 (smooth category, Hecke algebras, Jacquet functors, Bernstein decomposition), AG's BruhatTitsTheory (buildings, parahorics, Moy-Prasad filtrations), RepresentationsOfFiniteGroupsOfLieType (cuspidal representations of reductive quotients) and HeckeAlgebrasAndKazhdanLusztigTheory (affine Hecke algebras). Local Langlands correspondences stay with NT.
*Headlines:* unrefined minimal K-types; depth-zero supercuspidals; Bushnell-Kutzko types and covers; Iwahori block; simple types for GL_n; Yu's construction; exhaustion stated. *Needs:* CB SmoothRepresentationsOfLocalGroups; AG BruhatTitsTheory; RepresentationsOfFiniteGroupsOfLieType; HeckeAlgebrasAndKazhdanLusztigTheory. *Serves:* Annals 1 (#60). *Formalizability:* monographs and papers; feasible once suppliers land.

### 3.5 CommutativeAlgebra family (math.AC)

**CommutativeAlgebra** (umbrella index; members ≈ 810 PRs). An umbrella for Noetherian commutative algebra beyond Mathlib's Krull dimension, regular sequences, regular local rings and Rees' Ext-depth theorem: homological local algebra, multiplicities, graded resolutions and affine algebra. Its members are CohenMacaulayRings, MultiplicitiesAndIntersections, GradedFreeResolutions and LocallyNilpotentDerivations, plus the generic stages of the Birkbeck campaign's DeformationAndDerivedPatchingAlgebra (R03.1-R03.4, R03.6, P7, P9) promoted as a member, whose depth material yields to CohenMacaulayRings.

**23. CohenMacaulayRings** — math.AC; L ≈ 260; wave A.
The homological theory of Noetherian local rings beyond regularity: depth, Cohen-Macaulay and Gorenstein rings and modules, and the local cohomology that measures them. It starts from Mathlib's regular sequences, `Ext`, Krull dimension, regular local rings, local cohomology and Rees' theorem, and ends at canonical modules and local duality. The Birkbeck stage R03.3 and NT's orders (CM type, Gorenstein and Bass orders) consume it rather than build their own.
*Headlines:* Auslander-Buchsbaum(-Serre); unmixedness; Cohen structure; Matlis and local duality; Bass; canonical modules; Serre's criterion. *Needs:* Mathlib and Tau Ceti only. *Serves:* OpenAI 4 (#193, #194, #195, #200); LMFDB 1 (av.fq). *Port:* OAI RingTheory/Multiplicity (Cech complexes, coefficient fields). *Formalizability:* textbook (Bruns-Herzog); aligned with Mathlib depth work.

**24. MultiplicitiesAndIntersections** — math.AC; L ≈ 230; wave B.
Hilbert-Samuel theory of Noetherian local rings and modules, multiplicities of ideals, and Serre's homological intersection multiplicity up to the cases Serre settled. It consumes CohenMacaulayRings and Mathlib's Hilbert polynomials and generalizes Tau Ceti's regular-surface intersection lengths. Statements needing K-theory with supports or alterations (Roberts, Gillet-Soule, Gabber) and perfectoid methods are outside.
*Headlines:* dimension theorem; associativity; Rees; e = chi(Koszul); Nagata; Lech in dimension <= 2; Serre's chi (unramified); Dutta, Hilbert-Kunz. *Needs:* CohenMacaulayRings. *Serves:* OpenAI 2 (#193, #194). *Port:* OAI RingTheory/Multiplicity (54k). *Formalizability:* textbook (Serre, Local Algebra).

**25. GradedFreeResolutions** — math.AC; L ≈ 210; wave A.
Finite graded modules over a polynomial ring, their Hilbert functions and minimal free resolutions, and the extremal theory of Hilbert functions and Betti numbers. It starts from Mathlib's `MvPolynomial`, `MonomialOrder`, `HilbertPoly`, `Tor` and Kruskal-Katona, with regular sequences from CohenMacaulayRings. Symmetric-function combinatorics is COMB; intersection theory on schemes is AG.
*Headlines:* Hilbert syzygy theorem; Buchberger; Macaulay; Gotzmann; Green; Eliahou-Kervaire; Bigatti-Hulett-Pardue; generic initial ideals; Clements-Lindstrom. *Needs:* CohenMacaulayRings. *Serves:* OpenAI 1 (#200). *Formalizability:* combinatorial and finite (Herzog-Hibi, Peeva).

**26. LocallyNilpotentDerivations** — math.AC; M ≈ 110; wave A.
Locally nilpotent derivations and G_a-actions on affine varieties in characteristic zero, the Makar-Limanov invariant, and the classical cancellation and coordinate theorems for affine spaces of dimension at most three. It starts from Mathlib's derivations, `MvPolynomial` and Kahler differentials and uses GroupsActingOnTrees for Jung-van der Kulk. Logarithmic Kodaira dimension and the geometric proofs of cancellation in dimension two are AG and appear here as statements.
*Headlines:* slice theorem; Makar-Limanov invariant; Rentschler; Jung-van der Kulk; Abhyankar-Eakin-Heinzer; Russell cubic; AMS and cancellation in dimension two stated. *Needs:* GroupsActingOnTrees. *Serves:* OpenAI 2 (#047, #049). *Port:* OAI Algebra/AffineCancellation, AlgebraicGeometry/{CommutingDerivations, AbhyankarSathaye}. *Formalizability:* textbook (Freudenburg); OAI proofs use Mathlib only.

### 3.6 Noncommutative and universal algebra (math.RA)

**27. NoncommutativeRingTheory** — math.RA; L ≈ 230; wave A.
The structure theory of noncommutative rings beyond semisimplicity: radicals, primitive and prime rings, Noetherian rings and Goldie's theorem, polynomial identities, and algebraic and nil algebras, including the Golod-Shafarevich counterexamples to the Kurosh and Burnside problems. It starts from Mathlib's `Ring.jacobson` and `OreLocalization`, Tau Ceti's Golod-Shafarevich inequality and SemisimpleAlgebras. Central simple and division algebras over fields are SemisimpleAlgebras and NT; group rings are GroupRings; finite-dimensional algebras are TiltingAndHomologicalDimensions.
*Headlines:* Jacobson density; Goldie; Amitsur-Levitzki; Kaplansky PI; Posner; Golod's nil algebra and infinite f.g. p-groups. *Needs:* RT/SemisimpleAlgebras. *Serves:* OpenAI 2 (#201, #247). *Port:* OAI RingTheory/Kurosh, GroupTheory/PeriodicGroups (38k). *Formalizability:* textbook (Lam, Rowen).

**28. UniversalAlgebra** — math.RA; M ≈ 110; wave A.
Algebras of an arbitrary signature, their congruence lattices and varieties. It defers to Mathlib's functional `FirstOrder.Language` structures and lattice theory, and it ends at Gratzer-Schmidt and the Palfy-Pudlak reduction of finite lattice representation to subgroup intervals. Model theory is LTCS's ClassicalModelTheory; finite semigroups and automata are LTCS's AutomataAndFiniteSemigroups.
*Headlines:* Con(A) algebraic; Birkhoff subdirect and HSP theorems; Mal'cev; Jonsson; Gratzer-Schmidt; Palfy-Pudlak. *Needs:* Mathlib and Tau Ceti only. *Serves:* OpenAI 1 (#206). *Port:* OAI Algebra/Universal, GroupTheory/FiniteLattice. *Formalizability:* textbook (Burris-Sankappanavar).

### 3.7 Quantum algebra (math.QA)

**29. TensorCategories** — math.QA; L ≈ 300; wave B.
Finite tensor categories and symmetric tensor categories in every characteristic, following Etingof-Gelaki-Nikshych-Ostrik. It starts from Mathlib's monoidal, rigid and braided categories, #57 PivotalSpherical (pivotal and spherical structures, fusion categories, semisimple FP dimension) and the Tannakian reconstruction of ReductiveGroups L1. It ends at Deligne's theorem in characteristic zero, Ostrik's theorem in characteristic p and the Etingof-Ostrik Frobenius functor. Temperley-Lieb categories are #58, Hopf-algebra stable categories are #222, and modular tensor categories of vertex algebras are statements in VertexAlgebras.
*Headlines:* FP dimension; exact module categories; super-Tannakian reconstruction; Deligne categories; Ver_p; Deligne's and Ostrik's theorems; Frobenius functor. *Needs:* PivotalSpherical #57; ReductiveGroups L1; RationalRepresentationsOfReductiveGroups (SL2 tilting); RT/SchurWeyl. *Serves:* OpenAI 2 (#208, #280); Annals 1 (#59). *Port:* OAI Algebra/FiniteTensor (16k). *Formalizability:* textbook (EGNO).

**30. VertexAlgebras** — math.QA; L ≈ 300; wave B.
Vertex algebras and vertex operator algebras: axioms, modules, the standard constructions and the representation-theoretic finiteness conditions. It starts from Mathlib's `Algebra/Vertex` vertex operators and Hahn series, takes affine algebras from KacMoodyAlgebras and lattices from IntegralLattices and #219, and ends at the holomorphic Leech lattice VOA and the statements of Zhu's modularity and Huang's modular tensor category theorems. The moonshine module is consumed by the NT campaign's QSeriesPartitionsAndMockModularForms QM.6; conformal nets are FAMP's.
*Headlines:* Borcherds identity and reconstruction; Virasoro; Heisenberg, affine and lattice VOAs; V_Leech holomorphic with V_1 = 0; Zhu's algebra; Zhu and Huang stated. *Needs:* KacMoodyAlgebras; Completed/IntegralLattices; Rank24LatticeConstructions #219; ModularForms; TensorCategories. *Serves:* OpenAI 1 (#280); Annals 1 (#61). *Port:* OAI RepresentationTheory/VertexAlgebra (36k, low reuse). *Formalizability:* textbook (Kac, Frenkel-Ben-Zvi).

**31. GrothendieckTeichmuller** — math.QA; L ≈ 230; wave A.
The Grothendieck-Teichmuller Lie algebra and the Drinfeld associators it acts on. It builds graded free Lie algebras with Hall and Lyndon bases on Mathlib's `FreeLieAlgebra`, the Drinfeld-Kohno Lie algebras t_n, grt_1 with the Ihara bracket, associators and the KZ associator by regularized holonomy, and ends at the Deligne-Drinfeld theorem and the profinite group GT-hat receiving G_Q. Arithmetic of multiple zeta values is the NT campaign's PeriodsAndSpecialValues PS.9; BelyiMaps and PeripheralActions supply the profinite side they explicitly leave to this roadmap.
*Headlines:* Hall bases and Witt's formula; grt_1 and the Ihara bracket; KZ associator; GRT_1 torsor of associators; Deligne-Drinfeld; G_Q -> GT-hat. *Needs:* CB PeriodsAndSpecialValues PS.9; PeripheralActions; ProfiniteProPGroups; BelyiMaps. *Serves:* OpenAI 1 (#008). *Port:* OAI Algebra/Drinfeld (30k, complete endpoint). *Formalizability:* algebra high, associator analysis medium; complete Lean proof exists.

## 4. Needs not absorbed

50 of the 59 gap rows are covered above. The other nine:
- **OAI#044** (2 rows, BFN Coulomb branches): frontier; substrate is AG's AffineGrassmannians and EquivariantCohomologyAndLocalization.
- **OAI#204** (saturation via buildings, Klyachko, Kapovich–Leeb–Millson): frontier; inputs CrystalBases and NonpositiveCurvature.
- **OAI#203** (Deligne–Lusztig tilting on flag varieties for Cartan bounds): frontier beyond RepresentationsOfFiniteGroupsOfLieType.
- **OAI#018** (Margulis–Platonov over global fields): frontier; Lattices states the normal subgroup theorem, AG/NT supply strong approximation.
- **OAI#258** (Wise hierarchy, Agol, negative immersions): frontier; stated in NonpositiveCurvature.
- **OAI#285** (Gromov–Osajda monsters): frontier; graphical C'(1/6) is in CombinatorialGroupTheory, expanders in COMB's GraphTheory.
- **OAI#027** (Procesi–Donkin matrix invariants): owned by AG's GeometricInvariantTheory.
- **LMFDB group.abstract** (SmallGroup IDs, labels): owned by NT's LMFDBLabelsAndCompleteness.

Frontier inputs of served families: OAI#250 (twisted Brin–Thompson), #253, #255 (coarse
differentiation), #246 (Bonk–Kleiner), #103/#136 (quantitative Kazhdan constants), #177
(homological stability of coset complexes).

## 5. Cross-campaign interface

**Imports.** TOP: ClassifyingSpaces #437, AlgebraicTopology. AG: ReductiveGroups, FlagVarieties,
AlgebraicDModules, PerverseSheavesOnComplexVarieties, BruhatTitsTheory, #196. GEO:
RiemannianGeometry. FAMP: OperatorTheory #126, L2Invariants. NT/Birkbeck: AA.3, PS.9,
NumberFieldArithmetic, SR (promoted). KT: KTheoryLowDegrees, K2SymbolsBrauer. LTCS: ComputabilityTheory.

**Exports.** FAMP: AmenabilityAndPropertyT (three FAMP roadmaps cite it by this name; FAMP's
"AmenableGroupsAndGrowth: unitarizability" is its Dixmier layer), TensorCategories, VertexAlgebras.
COMB: (T) for Margulis expanders, buildings for high-dimensional expanders, Coxeter/KL theory.
PRDS: amenability and Kesten (trees and networks, MeasuredGroupTheory, ErgodicTheory), Lattices and
Howe–Moore (HomogeneousDynamics). GEO: NonpositiveCurvature, Lattices. TOP: coarse and hyperbolic
geometry, finiteness, NPC (aspherical 4-manifolds), amenability (BoundedCohomology). AG:
CohenMacaulayRings. NT: StructureOfFiniteGroups and RationalAndIntegralRepresentations (LMFDB,
ArtinRepresentations), CM type and Bass orders (AbelianVarietiesOverFiniteFields), Hecke/Types/SR,
KacMoodyAlgebras and VertexAlgebras (QSeries QM.6), GrothendieckTeichmuller, CompactGroups/LieGroups
(SatoTateGroups).

## 6. Order and people

**First five to draft** (demand × unblocking; one PR per lane under the WIP cap of 3):
1. **AmenabilityAndPropertyT**: 13 refs (Annals#70, 12 OAI) and a named supplier in the FAMP and COMB
   slates and the phase-1 probability report; wave A.
2. **CoarseGeometryAndHyperbolicGroups**, with the GeometricGroupTheory index: pins the
   quasi-isometry and hyperbolicity definitions seven OAI families define ad hoc; Annals#82.
3. **CombinatorialGroupTheory**: 11 OAI families; supplier of four GGT members.
4. **ModularRepresentationTheory**: Annals#57, OAI#202–203; extends the family that absorbs the most
   PRs per week (247 in the week of 09-28).
5. **HeckeAlgebrasAndKazhdanLusztigTheory**, with the RepresentationsOfReductiveGroups index:
   Annals#52, OAI#168, 43k OAI lines to port; supplier of four members.

Then NonpositiveCurvature (10 OAI), CohenMacaulayRings with the CommutativeAlgebra index, and
StructureOfFiniteGroups (LMFDB). Wave B waits mainly on #437, #447, #57 and AG's FlagVarieties,
AlgebraicDModules and BruhatTitsTheory.

**People.** Lead: a geometric group theorist (hyperbolic, CAT(0), cube complexes). Sub-lead: a
representation theorist (finite groups of Lie type, modular, Hecke). Reviewers: a commutative
algebraist; a tensor-category/VOA specialist; a p-adic representation theorist coordinating with
Chris Birkbeck; a Mathlib metric-geometry maintainer for the QI, CAT(0) and hyperbolicity designs.

**Open questions for the owner.**
- Will RepresentationTheory's maintainers lift two exclusions (modular theory; Kac–Moody and
  finite-type crystals) for §3.3, or should those five be siblings with the same names?
- GeometricGroupTheory is ≈2,000 PRs, above the XL range: land it in two batches (index + first
  three members, then the rest), or take AmenabilityAndPropertyT and GroupRings out as standalone?
- SR and the generic harmonic-analysis stages of AS/ET move to the ALG spoke: needs Chris's assent.
- ProfiniteCohomology, ProfiniteProPGroups and PeripheralActions are math.GR by topic, NT by
  purpose: which lead owns them?

## 7. Totals

| | roadmaps | L | M | est. PRs |
|---|---:|---:|---:|---:|
| GeometricGroupTheory family | 9 | 6 | 3 | 2,000 |
| standalone math.GR | 2 | 2 | 0 | 490 |
| RepresentationTheory additions | 5 | 3 | 2 | 1,020 |
| RepresentationsOfReductiveGroups family | 6 | 6 | 0 | 1,580 |
| CommutativeAlgebra family | 4 | 3 | 1 | 810 |
| math.RA and math.QA standalone | 5 | 4 | 1 | 1,170 |
| **total** | **31** | **24** | **7** | **7,070** |

Plus three umbrella indexes. By wave: A 20 roadmaps (≈4,290 PRs), B 9 (≈2,280), C 2 (≈500). The
slate cites 52 OAI families, 13 Annals entries and 4 LMFDB sections.

Existing supply in the territory: ≈700 PRs left on main (RepresentationTheory ≈270,
ProfiniteCohomology ≈150, StablePeriodicCurved ≈100, ZigzagPreprojective ≈80,
GrothendieckEulerForms ≈60, CFSGStatement and PeripheralActions ≈35), plus ReductiveGroups ≈600
(math.AG); ≈900 in nine open-PR roadmaps; ≈330 in promoted campaign stages (SR expanded ≈250, DDPA
generic ≈80). About 2,500 in all, 1,900 without ReductiveGroups.
