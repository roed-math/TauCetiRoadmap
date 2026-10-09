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
*Headlines:* Borcherds identity and reconstruction; Virasoro; Heisenberg, affine and lattice VOAs; V_Leech holomorphic with dim V_1 = 24; Zhu's algebra; Zhu and Huang stated. *Needs:* KacMoodyAlgebras; Completed/IntegralLattices; Rank24LatticeConstructions #219; ModularForms; TensorCategories. *Serves:* OpenAI 1 (#280); Annals 1 (#61). *Port:* OAI RepresentationTheory/VertexAlgebra (36k, low reuse). *Formalizability:* textbook (Kac, Frenkel-Ben-Zvi).

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

## 8. References by roadmap

36 roadmap records, 391 listings, 342 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_ALG.json` and the `references` fields of `slate_ALG.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (252 of 342: zbMATH stopped early; see master (d)). A title is given at a work's first citation in this section only. Pointers are the compilers' and are unverified.

**Conventions and notes.** Theorem numbers appear only where a campaign README fixes them (SR, DDPA); chapter pointers come from the local PDFs (Brown, Webb, Serre's *Local Fields*) or are certain, else book level. Five RepresentationTheory members reuse that family's citations (Serre GTM 42, Isaacs, Curtis–Reiner, Assem–Simson–Skowroński, Kac, Fulton, Fulton–Harris, Bonnafé, Humphreys) and its conventions: left modules; the bilinear character pairing; ModularInduction's `G₀` as exact `K₀` and its reduction mod ℓ. The DeformationAndDerivedPatchingAlgebra promotion record overlaps NT unit U27 (both kept; master (d8)).

**GeometricGroupTheory** (umbrella, wave A)
- primary: Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature*, Part I, Part II (?); Druţu–Kapovich 2018, *Geometric Group Theory* (?); de la Harpe 2000, *Geometric Group Theory* (?)
- conventions: Ghys–de la Harpe 1990, *Sur les groupes hyperboliques d'après…* (?); Geoghegan 2008, *Topological Methods in Group Theory* (?)
- formal: Mathlib `Geometry/Group/{WordMetric, Growth/}`

**RepresentationsOfReductiveGroups** (umbrella, wave A)
- primary: Jantzen 2003, *Representations of Algebraic Groups*, Part II (?); Digne–Michel 2020, *Representations of Finite Groups of Lie…* (?); Casselman 1995, *Theory of admissible representations of…* (?); Bernstein 1992, *Representations of p-adic groups* (?); Renard 2010, *Représentations des groupes réductifs…* (?); Chriss–Ginzburg 1997, *Representation Theory and Complex…* (?)
- conventions: Milne 2017, *Algebraic Groups* (?)

**CommutativeAlgebra** (umbrella, wave A)
- primary: Matsumura 1986, *Commutative Ring Theory* (?); Bruns–Herzog 1998, *Cohen–Macaulay Rings* (?); Eisenbud 1995, *Commutative Algebra with a View Toward…* (?); Serre 2000, *Local Algebra* (?)
- conventions: Stacks Project 2026, *Stacks Project*
- formal: Mathlib `RingTheory/{Regular/RegularSequence, Depth/Rees, …}`

**CombinatorialGroupTheory** (wave A)
- primary: Lyndon–Schupp 1977, *Combinatorial Group Theory* (?); Rotman 1995, *Theory of Groups* (?); Cannon–Floyd–Parry 1996, *Introductory notes on Richard…* (?)
- theorem: Bridson 2002, *Geometry of the word problem* (?); Ol'shanskii 1991, *Geometry of Defining Relations in Groups* (?); Collins–Huebschmann 1982, *Spherical diagrams and identities among…* (?); Fox 1953, *Free differential calculus. I*; Klyachko 1993, *Funny property of sphere and equations…* (?); Boone–Higman 1974, *Algebraic characterization of groups…* (?); Brin 2004, *Higher dimensional Thompson groups* (?); Ollivier 2006, *Small cancellation theorem of Gromov* (?)
- statement: Gerstenhaber–Rothaus 1962, *Solution of sets of equations in groups* (?)
- formal: Mathlib `GroupTheory/{PresentedGroup, FinitelyPresentedGroup, …}`; Tau Ceti `GroupTheory/Presentation`; OAI `Geometry/HyperbolicGroups`; OAI `GroupTheory/{Kervaire (relative pictures), Thompson, …}`

**GroupsActingOnTrees** (wave A)
- primary: Serre 1980, *Trees*, Ch. I, Ch. II (?); Dicks–Dunwoody 1989, *Groups Acting on Graphs* (?)
- conventions: Bass 1993, *Covering theory for graphs of groups* (?)
- statement: Dunwoody 1985, *Accessibility of finitely presented…* (?)
- formal: Mathlib `Combinatorics/SimpleGraph/Acyclic`

**CoarseGeometryAndHyperbolicGroups** (wave A)
- primary: Bridson–Haefliger 1999 (?); Ghys–de la Harpe 1990 (?); Druţu–Kapovich 2018 (?)
- conventions: Väisälä 2005, *Gromov hyperbolic spaces* (?)
- theorem: Bowditch 2012, *Relatively hyperbolic groups* (?); Osin 2016, *Acylindrically hyperbolic groups* (?)
- statement: Bowditch 1998, *Topological characterisation of…* (?); Bestvina–Mess 1991, *Boundary of negatively curved groups* (?)
- formal: Mathlib `Geometry/Group/{WordMetric, Growth/}`; Tau Ceti `Topology/MetricSpace/Length`; OAI `GroupTheory/Hyperbolic`; OAI `Geometry/HyperbolicGroups`; OAI `GroupTheory/PolycyclicRecognition`; OAI `Topology/ArtinGroups`

**NonpositiveCurvature** (wave A)
- primary: Bridson–Haefliger 1999, Part II (?); Abramenko–Brown 2008, *Buildings* (?); Davis 2008, *Geometry and Topology of Coxeter Groups* (?); Sageev 2014, *CAT(0) cube complexes and groups* (?)
- theorem: Haglund–Wise 2008, *Special cube complexes* (?); Charney 2007, *Right-angled Artin groups* (?); Wise 2012, *From Riches to Raags* (?)
- statement: Wise 2021, *Structure of Groups with a Quasiconvex…* (?); Groves–Manning) 2013, *Virtual Haken conjecture* (?)
- formal: Tau Ceti `Topology/MetricSpace/Length`; Tau Ceti `GroupTheory/Coxeter`; OAI `GroupTheory/{ArtinCAT0, RightAngledArtin}`

**ArtinGroupsAndGarside** (wave B)
- primary: Dehornoy et al. 2015, *Foundations of Garside Theory* (?)
- conventions: Kassel–Turaev 2008, *Braid Groups* (?)
- theorem: Paris 2002, *Artin monoids inject in their groups* (?); Brieskorn–Saito 1972, *Artin-Gruppen und Coxeter-Gruppen* (?); Deligne 1972, *Les immeubles des groupes de tresses…* (?); van der Lek 1983, *Homotopy type of complex hyperplane…* (?); Salvetti 1987, *Topology of the complement of real…* (?); Charney–Davis 1995, *K(π,1)-problem for hyperplane…* (?)
- statement: Paris 2014, *K(π,1) conjecture for Artin groups* (?); OpenAI 2026, *Harmonic heights and the Artin K(π,1)…* (OAI#254)
- formal: Tau Ceti `GroupTheory/Coxeter`; OAI `Topology/ArtinGroups`

**FinitenessPropertiesOfGroups** (wave B)
- primary: Brown 1982, *Cohomology of Groups*, Chs. VIII–IX; Geoghegan 2008 (?)
- theorem: Swan 1969, *Groups of cohomological dimension one* (?); Bestvina–Brady 1997, *Morse theory and finiteness properties…* (?)
- statement: Eckmann–Müller 1980, *Poincaré duality groups of dimension two* (?); Fluch et al. 2013, *Brin–Thompson groups sV are of type F∞* (?)
- formal: Mathlib `RepresentationTheory/Homological/GroupCohomology`; OAI `GroupTheory/FiniteType`; OAI `GroupTheory/PolycyclicRecognition`

**NilpotentSolvableAndLinearGroups** (wave A)
- primary: Segal 1983, *Polycyclic Groups* (?); Raghunathan 1972, *Discrete Subgroups of Lie Groups*, Ch. II (?); Clement–Majewicz–Zyman 2017, *Theory of Nilpotent Groups* (?); Druţu–Kapovich 2018 (?)
- theorem: Wehrfritz 1973, *Infinite Linear Groups* (?); Alperin 1987, *Elementary account of Selberg's lemma* (?); Kleiner 2010, *New proof of Gromov's theorem on groups…* (?)
- statement: Trofimov 1985, *Graphs with polynomial growth* (?)
- formal: `Aaron1011/gromov`; OAI `Probability/CriticalPercolation/{Harmonic, …}`; OAI `GroupTheory/PolycyclicRecognition`; Mathlib `GroupTheory/{Nilpotent, Solvable}`

**AmenabilityAndPropertyT** (wave A)
- primary: Ceccherini-Silberstein–Coornaert 2010, *Cellular Automata and Groups* (?); Bekka–de la Harpe–Valette 2008, *Kazhdan's Property (T)* (?); Juschenko 2022, *Amenability of Discrete Groups by…* (?)
- theorem: Kesten 1959, *Symmetric random walks on groups* (?); Pisier 2001, *Similarity Problems and Completely…* (?); Ershov–Jaikin-Zapirain 2010, *Property (T) for noncommutative…* (?); Milnor 1971, *Algebraic K-Theory* (?); Lubotzky 1994, *Discrete Groups, Expanding Graphs and…* (?)
- statement: Shalom 1999, *Bounded generation and Kazhdan's…* (?)
- formal: Mathlib `MeasureTheory/Group/FoelnerFilter`; OAI `{Analysis/Unitarizability, GroupTheory/SimpleAmenable, …}`

**GroupRings** (wave A)
- primary: Passman 1977, *Algebraic Structure of Group Rings* (?); Lück 2002, *L²-Invariants* (?)
- conventions: Weibel 2013, *K-book*, Ch. II
- theorem: Promislow 1988, *Simple example of a torsion-free, non…* (?); Gardam 2021, *Counterexample to the unit conjecture…* (?); Bass 1976, *Euler characteristics and characters of…* (?); Dykema–Juschenko 2015, *Stable finiteness of group rings* (?)
- statement: Linnell 1993, *Division rings and group von Neumann…* (?); OpenAI 2026, *Torsion-free group algebra with zero…* (OAI#196); OpenAI 2026, *Torsion-free group algebra that is not…* (OAI#197); OpenAI 2026, *Bass trace conjecture for complex group…* (OAI#207)
- formal: Mathlib `Algebra/MonoidAlgebra`; OAI `{RingTheory/BassTrace, RingTheory/DirectFiniteness, …}`

**LatticesInSemisimpleGroups** (wave B)
- primary: Witte Morris 2015, *Arithmetic Groups*; Raghunathan 1972 (?)
- theorem: Bekka–de la Harpe–Valette 2008 (?); Elstrodt–Grunewald–Mennicke 1998, *Groups Acting on Hyperbolic Space*; Katok 1992, *Fuchsian Groups*; Voight 2021, *Quaternion Algebras*
- statement: Margulis 1991, *Discrete Subgroups of Semisimple Lie…* (?); Borel–Harish-Chandra 1962, *Arithmetic subgroups of algebraic groups*; Mostow 1973, *Strong Rigidity of Locally Symmetric…* (?); Platonov–Rapinchuk 1994, *Algebraic Groups and Number Theory*
- formal: Mathlib `MeasureTheory/Group/FundamentalDomain`

**StructureOfFiniteGroups** (wave A)
- primary: Isaacs 2008, *Finite Group Theory* (?); Kurzweil–Stellmacher 2004, *Theory of Finite Groups* (?); Aschbacher 2000, *Finite Group Theory*; Dixon–Mortimer 1996, *Permutation Groups* (?); Smith 2011, *Subgroup Complexes* (?)
- conventions: LMFDB 2026, *L-functions and modular forms database…*
- theorem: Huppert 1967, *Endliche Gruppen I* (?); Doerk–Hawkes 1992, *Finite Soluble Groups* (?); Hall 1940, *Classification of prime-power groups* (?); Hall 1936, *Eulerian functions of a group* (?); Perlis 1977, *Equation ζ_K(s) = ζ_K'(s)* (?); Malle 2002, *Distribution of Galois groups* (?)
- statement: Kleidman–Liebeck 1990, *Subgroup Structure of the Finite…* (?); Liebeck et al. 2010, *Ore conjecture* (?); OpenAI 2026, *Rational homology and Quillen's…* (OAI#310)
- formal: Tau Ceti `GroupTheory/{Frattini, Transfer, FrobeniusKernel, …}`; OAI `GroupTheory/FiniteLattice`

**ModularRepresentationTheory** (wave A)
- primary: Webb 2016, *Finite Group Representation Theory*, Ch. 7, Ch. 9, Ch. 10; Navarro 1998, *Characters and Blocks of Finite Groups* (?); Linckelmann 2018, *Block Theory of Finite Group Algebras…* (?)
- conventions: Serre 1977, *Linear Representations of Finite Groups*, Part III
- theorem: Knörr–Robinson 1989, *Some remarks on a conjecture of Alperin* (?)
- statement: Alperin 1987, *Weights for finite groups* (?); Malle et al. 2024, *Brauer's height zero conjecture* (?); OpenAI 2026, *Blockwise Alperin weight conjecture* (OAI#202); OpenAI 2026, *Donovan's conjecture over algebraic…* (OAI#203)
- formal: Tau Ceti `RepresentationTheory/GrothendieckGroup`; OAI `RepresentationTheory/{AlperinWeights, Block}`

**KacMoodyAlgebras** (wave A)
- primary: Kac 1990, *Infinite Dimensional Lie Algebras*, Chs. 1–2, Ch. 3, Ch. 4 (?); Carter 2005, *Lie Algebras of Finite and Affine Type* (?)
- conventions: Kac 1990 (?)
- theorem: Moody–Pianzola 1995, *Lie Algebras with Triangular…* (?); Gabber–Kac 1981, *Defining relations of certain…* (?); Macdonald 1972, *Affine root systems and Dedekind's…* (?); Kac–Raina 1987, *Bombay Lectures on Highest Weight…* (?); Frenkel–Kac 1980, *Basic representations of affine Lie…* (?); Frenkel 2007, *Langlands Correspondence for Loop Groups* (?)
- statement: Feigin–Frenkel 1992, *Affine Kac–Moody algebras at the…* (?)
- formal: Mathlib `Algebra/Lie/{Killing, Free, UniversalEnveloping}`

**CrystalBases** (wave A)
- primary: Bump–Schilling 2017, *Crystal Bases* (?)
- conventions: Bump–Schilling 2017 (?)
- theorem: Littelmann 1994, *Littlewood–Richardson rule for…* (?); Littelmann 1995, *Paths and root operators in…* (?); Stembridge 2003, *Local characterization of simply-laced…* (?); Hong–Kang 2002, *Quantum Groups and Crystal Bases* (?); Fulton 1997, *Young Tableaux* (?)
- formal: Mathlib `Combinatorics/Young`

**TiltingAndHomologicalDimensions** (wave A)
- primary: Assem–Simson–Skowroński 2006, *Representation Theory of Associative…*, Ch. VI (?); Auslander–Reiten–Smalø 1995, *Representation Theory of Artin Algebras* (?)
- theorem: Happel 1988, *Triangulated Categories in the…* (?); Angeleri Hügel–Happel–Krause 2007, *Handbook of Tilting Theory* (?); Igusa–Todorov 2005, *Finitistic global dimension conjecture…* (?); Tachikawa 1973, *Quasi-Frobenius Rings and…* (?); Müller 1968, *Classification of algebras by dominant…* (?); Skowroński–Yamagata 2011, *Frobenius Algebras I* (?); Auslander–Reiten 1991, *Applications of contravariantly finite…* (?)
- statement: Rickard 1989, *Morita theory for derived categories* (?); OpenAI 2026, *Algebra of infinite little finitistic…* (OAI#198); OpenAI 2026, *Explicit counterexample to the…* (OAI#199)
- formal: Tau Ceti `RepresentationTheory/Quiver`; OAI `{Algebra/Finitistic, Algebra/AuslanderReiten, …}`

**RationalAndIntegralRepresentations** (wave A)
- primary: Curtis–Reiner 1981, *Methods of Representation Theory, Vol. I* (?); Isaacs 1976, *Character Theory of Finite Groups*, Ch. 10 (?)
- conventions: LMFDB 2026
- theorem: Serre 1977, Part III, §12; Yamada 1974, *Schur Subgroup of the Brauer Group* (?); Gille–Szamuely 2006, *Central Simple Algebras and Galois…*; Serre 1979, *Local Fields*, Ch. XII; Reiner 1975, *Maximal Orders* (?); Newman 1972, *Integral Matrices* (?); Kuzmanovich–Pavlichenkov 2002, *Finite groups of matrices whose entries…* (?); Tahara 1971, *Finite subgroups of GL(3, Z)* (?); Springer 1977, *Invariant Theory* (?)
- formal: Tau Ceti `RepresentationTheory/{CharacterTable/, GaloisLattice/, …}`

**HeckeAlgebrasAndKazhdanLusztigTheory** (wave A)
- primary: Björner–Brenti 2005, *Combinatorics of Coxeter Groups* (?); Humphreys 1990, *Reflection Groups and Coxeter Groups*, Ch. 7 (?); Lusztig 2003, *Hecke Algebras with Unequal Parameters* (?)
- conventions: Soergel 1997, *Kazhdan–Lusztig polynomials and a…* (?)
- theorem: Kazhdan–Lusztig 1979, *Representations of Coxeter groups and…* (?); Geck–Pfeiffer 2000, *Characters of Finite Coxeter Groups and…* (?); Curtis–Reiner 1987, *Methods of Representation Theory, Vol… II* (?); Iwahori–Matsumoto 1965, *Some Bruhat decomposition and the…* (?); Lusztig 1989, *Affine Hecke algebras and their graded…* (?); Haines–Kottwitz–Prasad 2010, *Iwahori–Hecke algebras* (?); Dyer 1990, *Reflection subgroups of Coxeter systems* (?); Brenti–Caselli–Marietti 2006, *Special matchings and Kazhdan–Lusztig…* (?)
- formal: Mathlib `GroupTheory/Coxeter`; Tau Ceti `GroupTheory/Coxeter`; OAI `RepresentationTheory/KazhdanLusztig`

**SoergelBimodules** (wave C)
- primary: Elias et al. 2020, *Soergel Bimodules* (?)
- conventions: Soergel 1997 (?)
- theorem: Soergel 2007, *Kazhdan–Lusztig-Polynome und…* (?); Elias–Williamson 2014, *Hodge theory of Soergel bimodules* (?); Elias–Williamson 2016, *Soergel calculus* (?); Libedinsky 2008, *Sur la catégorie des bimodules de…* (?)
- statement: Fiebig 2008, *Sheaves on moment graphs and a…* (?); Braden–MacPherson 2001, *From moment graphs to intersection…* (?); Jensen–Williamson 2017, *P-canonical basis for Hecke algebras* (?); Kontorovich et al. 2017, *Schubert calculus and torsion explosion* (?)
- formal: OAI `RepresentationTheory/KazhdanLusztig`

**RepresentationsOfFiniteGroupsOfLieType** (wave B)
- primary: Digne–Michel 2020 (?); Carter 1985, *Finite Groups of Lie Type* (?); Geck–Malle 2020, *Character Theory of Finite Groups of…* (?)
- conventions: Digne–Michel 2020 (?)
- theorem: Deligne–Lusztig 1976, *Representations of reductive groups…* (?); Green 1955, *Characters of the finite general linear…* (?); Bonnafé 2011, *Representations of SL2(F_q)* (?); Fulton–Harris 1991, *Representation Theory* (?)
- statement: Lusztig 1984, *Characters of Reductive Groups over a…* (?); Broué 1990, *Isométries parfaites, types de blocs…* (?)

**RationalRepresentationsOfReductiveGroups** (wave B)
- primary: Jantzen 2003, Part II (?); Humphreys 2006, *Modular Representations of Finite…* (?)
- conventions: Jantzen 2003 (?)
- theorem: Brion–Kumar 2005, *Frobenius Splitting Methods in Geometry…* (?)
- statement: Mathieu 1990, *Filtrations of G-modules* (?); Lusztig 1980, *Some problems in the representation…* (?); Andersen–Jantzen–Soergel 1994, *Representations of quantum groups at a…* (?); Kontorovich et al. 2017 (?)
- formal: OAI `RepresentationTheory/RestrictedTilting`

**SpringerTheoryAndLocalization** (wave B)
- primary: Chriss–Ginzburg 1997 (?); Hotta–Takeuchi–Tanisaki 2008, *D-Modules, Perverse Sheaves, and…* (?); Collingwood–McGovern 1993, *Nilpotent Orbits in Semisimple Lie…* (?)
- conventions: Borho–MacPherson 1981, *Représentations des groupes de Weyl et…* (?)
- theorem: Jantzen 2004, *Nilpotent orbits in representation…* (?)
- statement: Brylinski–Kashiwara 1981, *Kazhdan–Lusztig conjecture and…* (?)

**TypesAndSupercuspidalRepresentations** (wave C)
- primary: Bushnell–Kutzko 1998, *Smooth representations of reductive…* (?); Bushnell–Kutzko 1993, *Admissible Dual of GL(N) via Compact…* (?)
- conventions: Moy–Prasad 1994, *Unrefined minimal K-types for p-adic…* (?); Fintzen–Kaletha–Spice 2023, *Twisted Yu construction, Harish-Chandra…* (?); Casselman 1995 (?)
- theorem: Moy–Prasad 1994 (?); Moy–Prasad 1996, *Jacquet functors and unrefined minimal…* (?); Morris 1999, *Level zero G-types* (?); Borel 1976, *Admissible representations of a…* (?); Yu 2001, *Construction of tame supercuspidal…* (?); Fintzen 2021, *Types for tame p-adic groups*; Bushnell–Henniart 2006, *Local Langlands Conjecture for GL(2)* (?)
- statement: Kim 2007, *Supercuspidal representations* (?)

**CohenMacaulayRings** (wave A)
- primary: Bruns–Herzog 1998, Ch. 1, Ch. 2, Ch. 3 (?); Matsumura 1986 (?)
- conventions: Bruns–Herzog 1998 (?)
- theorem: Eisenbud 1995 (?); Iyengar et al. 2007, *Twenty-Four Hours of Local Cohomology* (?); Leuschke–Wiegand 2012, *Cohen–Macaulay Representations* (?)
- formal: Mathlib `RingTheory/{Regular/RegularSequence, Depth/Rees, …}`; OAI `RingTheory/Multiplicity`

**MultiplicitiesAndIntersections** (wave B)
- primary: Serre 2000, Ch. II, Ch. III, Ch. V (?); Huneke–Swanson 2006, *Integral Closure of Ideals, Rings, and…*, Ch. 11 (?)
- theorem: Bruns–Herzog 1998, Ch. 4 (?); Roberts 1998, *Multiplicities and Chern Classes in…* (?); Nagata 1962, *Local Rings* (?); Lech 1964, *Inequalities related to certain couples…* (?); Monsky 1983, *Hilbert–Kunz function* (?)
- formal: Mathlib `RingTheory/{Polynomial/HilbertPoly, ReesAlgebra}`; OAI `RingTheory/Multiplicity`

**GradedFreeResolutions** (wave A)
- primary: Peeva 2011, *Graded Syzygies* (?); Herzog–Hibi 2011, *Monomial Ideals* (?); Eisenbud 1995, Ch. 15 (?)
- theorem: Bruns–Herzog 1998, Ch. 4 (?); Eisenbud 2005, *Geometry of Syzygies* (?); Green 1998, *Generic initial ideals* (?); Pardue 1996, *Deformation classes of graded modules…* (?); Bayer–Stillman 1987, *Criterion for detecting m-regularity* (?); Clements–Lindström 1969, *Generalization of a combinatorial…* (?)
- formal: Mathlib `RingTheory/MvPolynomial/{MonomialOrder, Groebner}`

**LocallyNilpotentDerivations** (wave A)
- primary: Freudenburg 2017, *Algebraic Theory of Locally Nilpotent…* (?); van den Essen 2000, *Polynomial Automorphisms and the…* (?)
- theorem: Rentschler 1968, *Opérations du groupe additif sur le…* (?); Makar-Limanov 1996, *Hypersurface x + x²y + z² + t³ = 0 in…* (?); Abhyankar–Eakin–Heinzer 1972, *Uniqueness of the coefficient ring in a…* (?)
- statement: Shestakov–Umirbaev 2004, *Tame and the wild automorphisms of…* (?); Abhyankar–Moh 1975, *Embeddings of the line in the plane* (?); Fujita 1979, *Zariski problem* (?); Miyanishi–Sugie 1980, *Affine surfaces containing cylinderlike…* (?); Gupta 2014, *Cancellation problem for the affine…* (?)
- formal: Mathlib `RingTheory/{Derivation/, Kaehler/}`; OAI `{Algebra/AffineCancellation, …}`

**NoncommutativeRingTheory** (wave A)
- primary: Lam 2001, *Noncommutative Rings* (?); McConnell–Robson 2001, *Noncommutative Noetherian Rings* (?); Goodearl–Warfield 2004, *Noncommutative Noetherian Rings* (?)
- theorem: Rowen 1980, *Polynomial Identities in Ring Theory* (?); Drensky–Formanek 2004, *Polynomial Identity Rings* (?); Krause–Lenagan 2000, *Growth of Algebras and Gelfand–Kirillov…* (?); Golod 1964, *Nil-algebras and finitely approximable…* (?); Ershov 2012, *Golod–Shafarevich groups* (?)
- formal: Mathlib `RingTheory/{Jacobson/Radical, OreLocalization/}`; OAI `{RingTheory/Kurosh, …}`

**UniversalAlgebra** (wave A)
- primary: Burris–Sankappanavar 1981, *Universal Algebra* (?); McKenzie–McNulty–Taylor 1987, *Algebras, Lattices, Varieties, Vol. I* (?)
- conventions: Bergman 2015, *Invitation to General Algebra and…* (?)
- theorem: Birkhoff 1935, *Structure of abstract algebras* (?); Jónsson 1967, *Algebras whose congruence lattices are…* (?); Grätzer–Schmidt 1963, *Characterizations of congruence…* (?); Pálfy–Pudlák 1980, *Congruence lattices of finite algebras…* (?)
- statement: OpenAI 2026, *Negative solution to the finite lattice…* (OAI#206)
- formal: Mathlib `ModelTheory`; OAI `GroupTheory/FiniteLattice`

**TensorCategories** (wave B)
- primary: Etingof et al. 2015, *Tensor Categories* (?)
- conventions: Etingof et al. 2015 (?); Deligne–Milne 1982, *Tannakian categories* (?)
- theorem: Deligne 1990, *Catégories tannakiennes* (?); Deligne 2002, *Catégories tensorielles* (?); Deligne 2007, *La catégorie des représentations du…* (?); Georgiev–Mathieu 1992, *Catégorie de fusion pour les groupes de…* (?); Ostrik 2020, *Symmetric fusion categories in positive…* (?); Etingof–Ostrik 2021, *Frobenius functor for symmetric tensor…* (?); Coulembier–Etingof–Ostrik 2023, *Frobenius exact symmetric tensor…* (?)
- statement: Benson–Etingof–Ostrik 2023, *New incompressible symmetric tensor…* (?); OpenAI 2026, *Fiber functors for finite symmetric…* (OAI#208)
- formal: Mathlib `CategoryTheory/Monoidal/{Rigid, Braided}`; OAI `Algebra/FiniteTensor`; OAI `RepresentationTheory/RestrictedTilting`

**VertexAlgebras** (wave B)
- primary: Kac 1998, *Vertex Algebras for Beginners* (?); Frenkel–Ben-Zvi 2004, *Vertex Algebras and Algebraic Curves* (?); Lepowsky–Li 2004, *Vertex Operator Algebras and Their…* (?)
- conventions: Kac 1998 (?)
- theorem: Frenkel–Lepowsky–Meurman 1988, *Vertex Operator Algebras and the Monster* (?); Dong 1993, *Vertex algebras associated with even…* (?); Zhu 1996, *Modular invariance of characters of…* (?); Conway–Sloane 1999, *Sphere Packings, Lattices and Groups*
- statement: Huang 2008, *Rigidity and modularity of vertex…* (?)
- formal: Mathlib `Algebra/Vertex/{VertexOperator, HVertexOperator}`; OAI `RepresentationTheory/VertexAlgebra`

**GrothendieckTeichmuller** (wave A)
- primary: Reutenauer 1993, *Free Lie Algebras* (?); Drinfeld 1991, *Quasitriangular quasi-Hopf algebras and…* (?); Fresse 2017, *Homotopy of Operads and…* (?)
- conventions: Drinfeld 1991 (?)
- theorem: Furusho 2010, *Pentagon and hexagon equations* (?); Bar-Natan 1998, *Associators and the… I* (?); Ihara 1991, *Braids, Galois groups, and some…* (?); Ihara 1989, *Galois representation arising from P¹ −…* (?); Brown 2012, *Mixed Tate motives over Z*; OpenAI 2026, *Deligne–Drinfeld conjecture* (OAI#008); Schneps 1997, *Grothendieck–Teichmüller group GT-hat* (?); Belyi 1979, *Galois extensions of a maximal…* (?); Szamuely 2009, *Galois Groups and Fundamental Groups*, §4.7; Ribes–Zalesskii 2010, *Profinite Groups*
- formal: Mathlib `Algebra/{Lie/Free, FreeAlgebra, Lie/UniversalEnveloping}`; OAI `Algebra/Drinfeld`

**SmoothRepresentationsOfLocalGroups** (promotion unit, wave A)
- primary: Casselman 1995, §§2–9 (?); Bernstein 1992 (?); Vignéras 1996, *Représentations l-modulaires d'un…* (?); Cartier 1979, *Representations of p-adic groups* (?)
- conventions: Gross 1998, *Satake isomorphism* (?)
- theorem: Bernstein 1987, *Second adjointness for representations…* (?); Bernstein 1984, *Le « centre » de Bernstein* (?); Helm 2016, *Bernstein center of the category of…* (?); Dat et al. 2022, *Finiteness for Hecke algebras of p-adic…*, Theorem 1.7
- formal: leanprover-community/mathlib4 PR #43087

**DeformationAndDerivedPatchingAlgebra (generic stages R03.1–R03.4, R03.6, P7, P9)** (promotion unit, wave A)
- primary: Schlessinger 1968, *Functors of Artin rings*; Bruns–Herzog 1998 (?); Stacks Project 2026
- theorem: Khare–Wintenberger 2009, *Serre's modularity conjecture (II)*, §10; Diamond 1997, *Taylor-Wiles construction and…*; Kisin 2009, *Moduli of finite flat group schemes and…*; Calegari–Geraghty 2018, *Modularity lifting beyond the…*; Allen et al. 2023, *Potential automorphy over CM fields*, §6.3.4, §§6.2–6.4

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Bruns–Herzog 1998, *Cohen–Macaulay Rings* [5] ★; Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature* [3] ★; Druţu–Kapovich 2018, *Geometric Group Theory* [3] ★; Eisenbud 1995, *Commutative Algebra with a View Toward…* [3] ★; Chriss–Ginzburg 1997, *Representation Theory and Complex…* [2] ★; Digne–Michel 2020, *Representations of Finite Groups of Lie…* [2] ★; Geoghegan 2008, *Topological Methods in Group Theory* [2] ★; Ghys–de la Harpe 1990, *Sur les groupes hyperboliques d'après…* [2] ★; Jantzen 2003, *Representations of Algebraic Groups* [2] ★; Matsumura 1986, *Commutative Ring Theory* [2] ★; Raghunathan 1972, *Discrete Subgroups of Lie Groups* [2] ★; Serre 1977, *Linear Representations of Finite Groups* [2] ★; Serre 2000, *Local Algebra* [2] ★; Soergel 1997, *Kazhdan–Lusztig polynomials and a…* [2] ★; Abramenko–Brown 2008, *Buildings* [1] ★; Angeleri Hügel–Happel–Krause 2007, *Handbook of Tilting Theory* [1] ★; Assem–Simson–Skowroński 2006, *Representation Theory of Associative…* [1] ★; Auslander–Reiten–Smalø 1995, *Representation Theory of Artin Algebras* [1] ★; Bergman 2015, *Invitation to General Algebra and…* [1] ★; Björner–Brenti 2005, *Combinatorics of Coxeter Groups* [1] ★; Bump–Schilling 2017, *Crystal Bases* [1] ★; Carter 2005, *Lie Algebras of Finite and Affine Type* [1] ★; Ceccherini-Silberstein–Coornaert 2010, *Cellular Automata and Groups* [1] ★; Clement–Majewicz–Zyman 2017, *Theory of Nilpotent Groups* [1] ★; Curtis–Reiner 1981, *Methods of Representation Theory, Vol. I* [1] ★; Curtis–Reiner 1987, *Methods of Representation Theory, Vol… II* [1] ★; Davis 2008, *Geometry and Topology of Coxeter Groups* [1] ★; Dicks–Dunwoody 1989, *Groups Acting on Graphs* [1] ★; Dixon–Mortimer 1996, *Permutation Groups* [1] ★; Doerk–Hawkes 1992, *Finite Soluble Groups* [1] ★; Drensky–Formanek 2004, *Polynomial Identity Rings* [1] ★; Eisenbud 2005, *Geometry of Syzygies* [1] ★; van den Essen 2000, *Polynomial Automorphisms and the…* [1] ★; Frenkel 2007, *Langlands Correspondence for Loop Groups* [1] ★; Fresse 2017, *Homotopy of Operads and…* [1] ★; Freudenburg 2017, *Algebraic Theory of Locally Nilpotent…* [1] ★; Fulton 1997, *Young Tableaux* [1] ★; Geck–Pfeiffer 2000, *Characters of Finite Coxeter Groups and…* [1] ★; Goodearl–Warfield 2004, *Noncommutative Noetherian Rings* [1] ★; Happel 1988, *Triangulated Categories in the…* [1] ★; de la Harpe 2000, *Geometric Group Theory* [1] ★; Herzog–Hibi 2011, *Monomial Ideals* [1] ★; Hong–Kang 2002, *Quantum Groups and Crystal Bases* [1] ★; Humphreys 1990, *Reflection Groups and Coxeter Groups* [1] ★; Huppert 1967, *Endliche Gruppen I* [1] ★; Isaacs 1976, *Character Theory of Finite Groups* [1] ★; Isaacs 2008, *Finite Group Theory* [1] ★; Iyengar et al. 2007, *Twenty-Four Hours of Local Cohomology* [1] ★; Juschenko 2022, *Amenability of Discrete Groups by…* [1] ★; Kac 1990, *Infinite Dimensional Lie Algebras* [1] ★; Kac–Raina 1987, *Bombay Lectures on Highest Weight…* [1] ★; Kleidman–Liebeck 1990, *Subgroup Structure of the Finite…* [1] ★; Krause–Lenagan 2000, *Growth of Algebras and Gelfand–Kirillov…* [1] ★; Kurzweil–Stellmacher 2004, *Theory of Finite Groups* [1] ★; Lam 2001, *Noncommutative Rings* [1] ★; Leuschke–Wiegand 2012, *Cohen–Macaulay Representations* [1] ★; Linckelmann 2018, *Block Theory of Finite Group Algebras…* [1] ★; Lubotzky 1994, *Discrete Groups, Expanding Graphs and…* [1] ★; Lück 2002, *L²-Invariants* [1] ★; Lyndon–Schupp 1977, *Combinatorial Group Theory* [1] ★; McConnell–Robson 2001, *Noncommutative Noetherian Rings* [1] ★; McKenzie–McNulty–Taylor 1987, *Algebras, Lattices, Varieties, Vol. I* [1] ★; Milne 2017, *Algebraic Groups* [1] ★; Milnor 1971, *Algebraic K-Theory* [1] ★; Moody–Pianzola 1995, *Lie Algebras with Triangular…* [1] ★; Navarro 1998, *Characters and Blocks of Finite Groups* [1] ★; Newman 1972, *Integral Matrices* [1] ★; Ol'shanskii 1991, *Geometry of Defining Relations in Groups* [1] ★; Passman 1977, *Algebraic Structure of Group Rings* [1] ★; Peeva 2011, *Graded Syzygies* [1] ★; Pisier 2001, *Similarity Problems and Completely…* [1] ★; Reiner 1975, *Maximal Orders* [1] ★; Renard 2010, *Représentations des groupes réductifs…* [1] ★; Reutenauer 1993, *Free Lie Algebras* [1] ★; Rotman 1995, *Theory of Groups* [1] ★; Rowen 1980, *Polynomial Identities in Ring Theory* [1] ★; Segal 1983, *Polycyclic Groups* [1] ★; Serre 1980, *Trees* [1] ★; Skowroński–Yamagata 2011, *Frobenius Algebras I* [1] ★; Smith 2011, *Subgroup Complexes* [1] ★; Springer 1977, *Invariant Theory* [1] ★; Tachikawa 1973, *Quasi-Frobenius Rings and…* [1] ★; Vignéras 1996, *Représentations l-modulaires d'un…* [1] ★; Wehrfritz 1973, *Infinite Linear Groups* [1] ★; Wise 2012, *From Riches to Raags* [1] ★; Wise 2021, *Structure of Groups with a Quasiconvex…* [1] ★; Yamada 1974, *Schur Subgroup of the Brauer Group* [1] ★.

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
