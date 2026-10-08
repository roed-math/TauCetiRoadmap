# Coordinating the expansion: per-category campaigns on the tauceti-explorer model

Evidence base (all local, 2026-10-07): explorer clone at `4689b24` (scratchpad `explorer/`; sparse
checkout extended to `scripts/`, `.github/`, `research/blueprint/*.{md,py,json}`, `research/expansion/`,
`data/restructure/`, `data/links/`), TauCetiRoadmap `upstream/main` (`b4f19703`) and the 66 open-PR roadmap
READMEs (`upstream-pr/<N>`), the supply indexes in this directory, and the owner's memory notes on claims,
fleets, lookahead, drift, topics, group review and merge order.

**Verdict.** Per-category forks work as a *drafting* layer, not as independent atlases. They need one hub
registry, source-only contributions back to the hub, and TauCetiRoadmap as the only normative repository
and the only claim system workers read. Group the arXiv classes into about 10 forks. math.NT and math.AG
need sub-campaigns (lanes). The binding constraint is human review in TauCetiRoadmap, not drafting
capacity, and the protocol below is built around that.

---

## 1. Campaign format compared with TauCetiRoadmap

### 1.1 What a campaign roadmap is

| | Birkbeck campaign (`content/campaign/<Name>/README.md`) | TauCetiRoadmap roadmap |
|---|---|---|
| Files | README.md only. **0 of 152** dirs bundle a `Suggested.lean`, although 107 READMEs mention one. **0** carry `metadata.toml`. | `README.md` (normative), `Suggested.lean` (built in CI), `metadata.toml` with one arXiv `topic` (CI-enforced since #518), machine `STATUS.md`/`PROGRESS.md` |
| Size | median **11.3 KB** (range 5.1–27.2 KB) | median **45 KB** over the 60 bundled copies |
| Unit | "stages" (`GN.0`…) with *Construct and export / Inputs / Acceptance / Source route / Execution state* | layers and milestones with pinned conventions, named declarations, worked examples |
| Classification | primary + secondary MSC from zbMATH lookups of the references (`data/roadmap-classification.json`), placed in one of 28 MSC "galaxies" | one arXiv class |
| Dependencies | machine stage IDs (`Area:Stage`), external contracts `UPSTREAM:<roadmap>` (85 of them, including open PRs #196, #279, #280, #287, #323) | prose "Dependencies" and `Suggested.lean` imports |
| Status vocabulary | `needs_source_decomposition`, `not_certified_implemented`, four separate progress dimensions | none in the README (README rule: timeless, no process) |

Reviewed **blueprints** carry the explorer's live planning state: `research/blueprint/packets|readmes|suggested`,
promoted into `data/blueprints/`. They supersede the frozen campaign READMEs for the layers they cover.
They also run the other way on size: across the 125 blueprint readmes I could size, the median is
**≈190 KB**. `GeometryOfNumbersAndQuadraticArithmetic.md` is 443 KB and `DirichletPadicLFunctions--L3.md`
is 6.25 MB. Neither the 11 KB snapshot nor the 190 KB blueprint is a TauCetiRoadmap-shaped document.

Several snapshot READMEs break the TauCetiRoadmap README checklist outright:

- 25 cite stages of the retired `FoundationsAndLibraryIntegration` (retired 2026-09-16, `data/roadmap-retirements.json`) as inputs;
- 21 contain campaign process text ("Execution state", "campaign execution protocol");
- 11 use "optional", "deferred" or "for later";
- the namespace convention is `TauCetiRoadmap.Campaign` (CONVENTIONS.md);
- the coverage atlas assigns MSC 11R and 11S (global and local arithmetic) to the retired roadmap, so those two families currently have no live campaign owner.

### 1.2 What the guides require (one line each)

- **AI_EXECUTION**:
  - pin the commits;
  - confirm that the target "has been adopted" upstream **before starting new declarations**;
  - read the full source proof (at least two independent sources per roadmap, legally obtainable);
  - search existing code;
  - decompose into leaves;
  - match every producer/consumer signature;
  - only then write Lean;
  - axioms limited to the three standard ones;
  - four separate state dimensions (knowledge, source, specification, implementation);
  - one owner per shared foundation.
- **WORKER_BRIEF**: a reusable dispatch prompt plus a JSON result record (sources read, leaves, reused declarations, new prerequisites, conversions, build/axiom evidence).
- **CONVENTIONS**:
  - one canonical owner per definition family;
  - integral statements are first-class;
  - explicit conventions (Frobenius, twists, normalizations);
  - EnhancedDerivedSheaves owns enhancements, StableHomotopyKTheory owns spectra;
  - scheme étale cohomology comes from **open PR #196**;
  - `Suggested.lean` seeds may contain `sorry`;
  - edition freezing and stage aliases.
- **DEPENDENCIES**: a shared-ownership table (about 35 theory → supplier rows), six construction waves, early/late splits (Weil, K-theory, Habiro) and non-circular routes. It states that an acyclic graph does not certify completeness.
- **IMPLEMENTATION_ORDER**: 1,312 *preparation* rows. It starts with FoundationsAndLibraryIntegration LI.0, which is now retired. It lists eight parallel tracks. A proof worker may take a leaf only once its prerequisites are built on the target pin.
- **SCOPE_AND_COMPLETENESS**: three completion tests (coverage/ownership, proof-plan closure, formal completion). It says only the first was attempted. It excludes "all of algebraic geometry".
- **COVERAGE_ATLAS**: 296 MSC 11xxx codes, each assigned to an owning roadmap. It is NT-only.
- **GRAPH_AUDIT**: 1,079 stages, 0 stage-level cycles, one area-level SCC of ~110 roadmaps, per-area producer/incoming/internal counts.
- **EXTENSION_SOURCES**: 29 source families. Most entries read "identity verified; full proof decomposition required".
- **DIAMONDS_\***: conventions, dependency order and source contracts for the diamonds/FS branch.

### 1.3 Is there a promotion pipeline?

**No.** No guide says how a campaign roadmap becomes a TauCetiRoadmap PR, and nothing lets workers implement it directly:

- AI_EXECUTION step 1 makes upstream adoption a precondition: "this local document does not publish a roadmap change".
- The explorer's own protocol (research/blueprint/PROTOCOL.md §10, §15; WORKERS.md) treats Tau Ceti roadmaps as read-only. Problems found there go into `research/blueprint/UPSTREAM_NOTES.md` "for the maintainer to pass upstream". That file now holds **163 independently confirmed notes** about Tau Ceti roadmaps (for example JacobianChallenge's degree defined before H¹ finiteness, OneParameterSemigroups' false closure claim).
- `scripts/promote.py` promotes reviewed work into the *atlas* (`data/`), not into TauCetiRoadmap.
- On the Tau Ceti side, the owner's memory records that TauCeti `AGENTS.md` forbids agents opening TauCetiRoadmap PRs or issues, and CONTRIBUTING says nobody posts a roadmap they have not read. Every promotion is therefore a human act.

The explorer also runs its own planning swarm: GitHub issues on CBirkbeck/tauceti-explorer, `/claim` comments, `swarm-intake` every 2 h, independent-review gating. Its queue has 4,040 jobs (2,163 done, 1,523 pending). It writes plans, reviews, red-team findings and suggested Lean files, and never TauCeti code.

---

## 2. How the explorer is built, and what forks would change

### 2.1 Ingestion

1. **Snapshot** (`scripts/snapshot/build_data.py`). It needs inputs that are **not in the repository**:
   - `EDITION.json`, `campaign/MANIFEST.json`, `WORK_QUEUE.json`, `STAGE_CATALOGUE.json`, `EXTERNAL_CONTRACTS.json`;
   - a graph directory with `NODE_INDEX.json` and `EDGE_INDEX.json`;
   - a TauCetiRoadmap checkout.

   It writes `data/atlas.json` (14 MB) and `content/`. The 10 NT groups and a hard-coded `GROUP_FOR` table place Tau Ceti roadmaps. It fails on duplicate roadmap or stage IDs and on any cycle in the combined stage graph. **`content/campaign/` is an output of this step, not an input**: editing it in a fork changes nothing on the map.
2. **New Tau Ceti roadmaps** (`scripts/tauceti_progress.py`). It reads the Tau Ceti site's `progress.json`, adds `tauceti:<path>` roadmaps from their READMEs (`data/tauceti-new-roadmaps.json`) and places them by `data/tauceti-placements.json`, then title, then cited roadmaps.
3. **New proposed roadmaps and blueprints**:
   - a roadmap is `research/blueprint/roadmaps/<Id>.json` (id, title, `area` = galaxy, readme, prerequisites, stages, sources);
   - plus packet, readme and suggested Lean;
   - an independent review job, then `promote.py`, which copies into `data/blueprints/` and refuses anything that breaks the build;
   - 32 such roadmaps already exist, several outside NT: RiemannianGeometry, SeveralComplexVariablesKahlerGeometry, SymplecticContactGeometry, ConformalMappingPartII, HodgeStructuresPartII, SemisimpleAlgebrasPartII.
4. **Restructure and retire.** `data/restructure/RS-NN.result.json` (33 accepted families) narrows or drops layers and re-titles extensions "<Tau Ceti roadmap>, Part II". `data/roadmap-retirements.json` removes roadmaps and *drops* every link through them; links are not rerouted.
5. **Placement.**
   - `classification.py` takes zbMATH MSC of the references and maps them to 28 galaxies (`data/galaxies.json`, MSC-keyed; one "analysis" galaxy spans MSC 26–65).
   - `measure_distances.py` computes `w_T ln(1+T) + w_D D` over the prerequisite closure, with weights fitted to pairwise judgements (Bradley–Terry), then rescales so that **10 = the farthest roadmap in this atlas**.
   - `radial_layout.py` places galaxies by shared prerequisites.

### 2.2 What a per-arXiv-category fork would have to change

- **Authoring path.** Author new roadmaps as `research/blueprint/roadmaps/<Id>.json` plus packets, not in `content/campaign/`. Alternatively Chris publishes the private snapshot inputs so a fork can regenerate. Without one of these, a fork's `content/campaign/` is decoration.
- **Galaxies.** Add galaxies for the category (`data/galaxies.json`; the non-NT galaxies are coarse) and an arXiv → galaxy map. The atlas classifies by MSC; TauCetiRoadmap topics are arXiv, decided by arXiv practice for content-matched papers (#517 ruling).
- **Swarm.** Recreate it: issues, labels, `swarm-*` workflows, an intake bot token, the focus list, and an independent reviewer pool. GitHub disables Actions and issues on forks by default.
- **Forks per account.** GitHub gives an account or organization one fork of a repository (to my knowledge), so ten forks need ten owners or orgs, or plain copies instead of forks.
- **Generated files.** Never commit them in a fork. `atlas.json`, `promotions.json`, `queue.json`, `library-coverage.json` (4 MB) and `source-issues.json` (28 MB) conflict on every merge.

### 2.3 Can the forks later merge into one atlas?

Yes, under five conditions:

1. Roadmap IDs are globally unique, reserved in a hub registry before drafting. IDs are bare CamelCase, and stage IDs are `<Id>:<key>`.
2. Forks contribute only per-roadmap source files (`roadmaps/<Id>.json`, `packets/<Id>.json`, readmes, suggested, links).
3. The hub alone regenerates `data/`.
4. Cross-fork links cite stage IDs of registered roadmaps.
5. The hub re-runs restructure and link jobs on every cross-fork family.

Distances computed inside separate forks are not comparable, because each rescales to its own farthest roadmap. They must be recomputed at the hub.

### 2.4 What breaks if two forks define overlapping roadmaps

- **Same ID.** The snapshot build stops ("Duplicate imported roadmap IDs/stage IDs"). In the blueprint path, file-per-roadmap collisions become merge conflicts or a silent overwrite.
- **Different IDs, same mathematics.**
  - No check catches it. Overlaps surface only in a link job that examines both roadmaps, or in a restructure family the orchestrator defines.
  - Both are drawn, both inflate distances, and consumers in each fork cite different owners.
  - If both reach TauCetiRoadmap, the review ruling from the 2026-08-09 group review applies: being dependency-closed is no defence against duplicate ownership, and a duplicate of a Tau Ceti object is rejected even with a comparison isomorphism (`roadmap-tauceti-drift-check`).
  - If both merge anyway, fleets build two copies.
- **Mutual dependencies across forks.** The combined graph closes a cycle. `promote.py` and `restructure.py` drop the later links and only record it, so the second fork silently loses prerequisites.
- **Divergent retirements and placements** between forks.

---

## 3. Overlap audit

### 3.1 What the explorer has already reconciled (against TauCetiRoadmap main of 14 September plus #81, and PR #196)

The 33 accepted restructure families made **22 campaign roadmaps "Part II" extensions of a Tau Ceti roadmap**. They narrowed 359 layers and dropped 7. The narrowing is applied at build time, so the `content/campaign/` READMEs still restate the narrowed material; only the blueprints are narrowed.

| Campaign roadmap | Extends (Tau Ceti; parent topic) |
|---|---|
| AbelianSchemesAndArithmeticModuli | JacobianChallenge (AG) |
| AdicSpacesPartII, FarguesFontaineDiamonds, RelativeFarguesFontaine | AdicSpaces (AG) |
| AlgebraicModularFormsAndSerreWeights, ModularSymbolsPadicLFunctions, GL2AutomorphicRepresentationsAndTransfer | ModularForms (NT) |
| AnalyticNumberTheory (AN.0 dropped; AN.1 dropped to Mathlib; AN.6 dropped) | ArithmeticDirichletSeries (NT) |
| ArithmeticGaloisDuality | ProfiniteCohomology (**GR**) |
| EllipticKTheory, RankZeroOneBSD | EllipticCurves (NT) |
| FiniteFlatGroupsAndIntegralPadicHodgeTheory, ModularCurvesPartII | ModularCurves (NT) |
| FunctionFieldArithmetic | AlgebraicCurves (AG) |
| HigherLocalFieldsAndHigherClassFieldTheory | ClassFieldTheory (NT) |
| InverseGaloisAndArithmeticFundamentalGroups | BelyiMaps (**AG**) |
| KTheoryLowDegrees | GrothendieckEulerForms (**RT**) |
| PadicMeasuresIwasawaAlgebras | ProfiniteProPGroups (**GR**) |
| ReductiveGroupsPartII | ReductiveGroups (AG) |
| ShimuraCompactifications | AnalyticToricGeometry (AG) |
| StableHomotopyKTheory | AlgebraicTopology (AT) |

Two more extensions are internal to the campaign: AutomorphicPadicLFunctions extends DirichletPadicLFunctions, and CompletedCohomologyPartII extends ArithmeticLocallySymmetricSpaces. WeightsInEtaleCohomology extends DeligneWeightsAndPurity.

**Consumers.** 48 campaign roadmaps have layers narrowed onto Tau Ceti layers, so they are consumers. The heaviest dependencies:

- EllipticCurves and ModularForms: 10 consumers each;
- ModularCurves: 9;
- ClassFieldTheory and GlobalNumberFields: 6 each;
- AdicSpaces, JacobianChallenge, ProfiniteCohomology and StableReduction: 5 each;
- AlgebraicTopology: 3;
- PR #196: 3 by narrowed layer, 15 by README mention.

The bolded parent topics show that a "Part II" often crosses arXiv classes: NT content hung on GR, AG or RT parents. TauCetiRoadmap files a sub-roadmap under its parent's topic, so these extensions must be sibling roadmaps with their own topic, not sub-directories (§4.5).

### 3.2 Overlaps the explorer has not reconciled (Tau Ceti material it has not caught up with)

Since that snapshot, TauCetiRoadmap main gained AlgebraicVectorBundles, DifferentialGeometry, LocalGaloisGroups, OrthogonalSpinGroups, PeripheralActions, ProfiniteArithmetic, RealAlgebraicGeometry, RestrictedProducts and the 182 KB IntegralLattices expansion. About 40 open PRs add roadmaps. None of these appears in any `data/restructure` file.

| Campaign roadmap (stages) | Tau Ceti material | Relation | Evidence |
|---|---|---|---|
| GeometryOfNumbersAndQuadraticArithmetic GN.1–GN.3 | IntegralLattices (main, active: L2 reduction, L3 genus, L4 spinor genera and Eichler, L7 masses and local densities, L8 theta handoff); ThetaSeries #286; ArithmeticHeights #287 (successive minima, Minkowski II); GlobalQuadraticForms, QuadraticFormInvariants, OrthogonalSpinGroups | **duplicate** for GN.1–GN.3; GN.4 (homogeneous dynamics), GN.5 and GN.6 (Grothendieck–Witt) are new | The 443 KB blueprint treats only *Completed*/IntegralLattices (duality, discriminant, gluing) as existing and plans "genera/spinor genera, dyadic…" as new work |
| AnalyticNumberTheory AN.3, AN.4 | LFunctions #248 (Dedekind zeta, Hecke and Grössencharacter L-functions, Gauss sums, root numbers, nonvanishing on Re s = 1); ZerosOfLFunctions #253 (zero-free regions, counting, explicit formula) | **duplicate**; AN.5 and AN.7–AN.9 are extensions | RS-07 saw only ADS and Chebotarev |
| AutomorphicLFunctionsAndLocalFactors | LFunctions #248 | overlap on GL₁; extension for GLₙ | |
| DiophantineApproximationAndTranscendence DT.0, DT.3 | ArithmeticHeights #287 (absolute heights, Northcott, Siegel's lemma); LinearFormsInLogarithms #451 (Baker over ℂ and ℂ_p) | **duplicate** for DT.0 and DT.3; DT.1, DT.2 and DT.5 are new | neither PR is cited |
| HeightsRationalPointsAndObstructions RP.0 | ArithmeticHeights #287 | partial duplicate | RP.0 is narrowed onto Mathlib heights only. Only GrossZagierAndArithmeticHeights cites #287 |
| ComputationalNumberTheory CN.1 | ECM #419 | partial duplicate | |
| AdelicAlgebraicGroups AA.0, AA.4 | RestrictedProducts (main); OrthogonalSpinGroups (strong approximation for spin); GlobalNumberFields (`denseRange_algebraMap_finiteAdeleRing`) | **duplicate** for AA.0; overlap on AA.4 | |
| ArithmeticGaloisRepresentations R01.2–R01.3 | LocalGaloisGroups (main), NumberFieldArithmetic (Artin conductor), EllipticCurves (conductor), LocalFieldsRamification | partial duplicate and consumer | |
| ArithmeticGaloisDuality | ClassFieldTheory, ProfiniteCohomology, LocalGaloisGroups (local Tate duality) | partial on local duality; Poitou–Tate is new (no Tau Ceti roadmap mentions it) | |
| LocalGaloisDeformationRings, PhiGammaModulesAndIwasawaCohomology | LocalGaloisGroups | consumer, not cited | |
| StableHomotopyKTheory H.1 | ClassifyingSpaces #437 (simplicial and cellular BG, group homology) | **duplicate** | |
| ReductiveGroupsPartII RG2.3, RG2.5 | ChevalleyGroups #447/#697 (Chevalley–Demazure group schemes) | partial duplicate | |
| SchemeAndStackFoundations SF.0, SF.2, SF.5 | AlgebraicVectorBundles (main: QCoh, relative Spec; Chow groups as roadmap-for-a-roadmap); PR #196 (sites, base change, Rf_!, compact support); JacobianChallenge C; StableReduction 2 | partial duplicate; SF.1 (spaces, stacks) and SF.4 are new | |
| WeilConjectures WC.1; DeligneWeights; EtaleDuality; Lefschetz | PR #196 (FrobeniusGeometry, TraceFormula: cohomological rationality) | declared consumer of an **unmerged** PR | 15 campaign READMEs cite #196 |
| ComplexComparisonPartII | PR #196 ComplexComparison; ComplexManifolds #279; HodgeStructures (completed) | declared extension | |
| FiniteFieldsAndCharacterSums FF.1, FF.4 | AlgebraicCodingTheory (main); Gauss sums in NumberFieldArithmetic, Multiquadratic, #248 | **duplicate** for FF.4; partial for FF.1 | |
| ClassicalArithmeticCompletion CA.1, CA.5 | Mathlib reciprocity, QuadraticFormInvariants (Hilbert symbols), NumberFieldArithmetic | partial duplicate | |
| AdditiveCombinatorics AC.1–AC.2 | Regularity #66 (graph and arity-3 hypergraph regularity, removal, Gowers), DenseGraphLimits | partial duplicate | |
| LogicAndDefinabilityInNumberTheory LD.6 | RealAlgebraicGeometry (quantifier elimination, CAD, o-minimal) | overlap at the boundary | |
| MetaplecticAutomorphicForms | ThetaSeries #286 (transformation laws, lattice Gauss sums) | partial | |
| InverseGalois…, PadicMeasuresIwasawaAlgebras | ProfiniteArithmetic (ẑ, profinite powers), PeripheralActions | consumer, not cited (post-snapshot supplier) | |
| ArithmeticStatistics; QSeriesPartitions…; ArakelovGeometry… | MassFormula #226; ThetaSeries #286; StableReduction L4 and #287 | consumer | |
| ColemanPowerSeries | none: ClassFieldTheory explicitly excludes Lubin–Tate formal groups | **unowned prerequisite**. Lubin–Tate theory needs an owner (NT·algebraic) | |

### 3.3 Campaign roadmaps that are foundations of other fields

Rule used: the category of the prerequisite theory, with the tiebreak "arXiv practice for papers matching the content" (the #517 ruling). Where a roadmap straddles, split by stage.

| Campaign roadmap | Proposed owner | Notes |
|---|---|---|
| SchemeAndStackFoundations, AlgebraicModuliForArithmeticGeometry | math.AG (foundations lane) | Both claim algebraic spaces and stacks: merge into one owner. Strip SF.0/SF.2 against AlgebraicVectorBundles and PR #196 |
| ComplexComparisonPartII | math.AG | sibling of PR #196 ComplexComparison (GAGA) |
| EtaleDualityAndPerverseSheaves, LefschetzPencilsAndVanishingCycles, DeligneWeightsAndPurity (+ WeightsInEtaleCohomology), WeilConjectures, AdicCoefficientsAndComparisons, ClassicalAdicEtaleCohomology, MotivesAndAlgebraicCycles | math.AG (cohomology and motives lane) | all stacked on PR #196; it should merge first |
| PerfectoidSpaces, DiamondsAndVStacks, Adic*, Diamond*, VStackSheaves…, Crystalline, DerivedDeRham, Prismatic, AInf, CohomologyComparisons, PadicDifferentialEquationsAndRigidCohomology, VectorBundlesAndIsocrystals, Fargues–Fontaine ×2, TropicalAndBerkovichArithmetic, the Habiro cluster | math.AG (p-adic geometry lane) | AdicSpaces is math.AG on main. Keep the five Habiro roadmaps together. ArithmeticQuantumTopology's knot-invariant layers go to math.GT |
| EnhancedDerivedSheaves | math.CT | boundary with DGAInfinity (CT) and StablePeriodicCurved |
| GeneralAlgebraicKTheory, SchemeKTheoryOperations, MotivicEtaleKTheory, K2SymbolsBrauer, K3BlochGroups, RefinedTraceMethods, KTheoryLowDegrees | math.KT | KTheoryLowDegrees should be a math.KT sibling of GrothendieckEulerForms, not its Part II. The arithmetic K-theory roadmaps (ArithmeticKTheory, BorelRegulators, Polylogarithms, EllipticRegulators, KTheoryFiniteLocalFields, EllipticKTheory, HabiroNumberFields) stay in NT as consumers |
| StableHomotopyKTheory | math.AT | true Part II of AlgebraicTopology; H.1 yields to ClassifyingSpaces #437 |
| SmoothRepresentationsOfLocalGroups | math.RT | generic harmonic-analysis layers of AutomorphicSpectralTheory and EndoscopicTransfer (Hecke algebras, orbital integrals, Plancherel) also go to math.RT. Annals #43, #52, #60 need them |
| ReductiveGroupsPartII | math.AG (parent's topic) | buildings could argue for GR; reconcile with ChevalleyGroups #447 |
| DeformationAndDerivedPatchingAlgebra | math.AC | the patching-module stages (R03.5, P8) stay in NT·Galois |
| AdditiveCombinatorics | math.CO for AC.0–AC.3 | AC.4–AC.5 (transference, linear equations in primes) stay in NT·analytic. Coordinate with Regularity #66 |
| ExponentialSumsAndCircleMethod | math.NT | the decoupling layer (Bourgain–Demeter–Guth) goes to math.CA, which Annals #89 also needs |
| ProbabilisticAndMetricNumberTheory | math.NT | generic ergodic theory (PM.2 equidistribution, PM.4 Gauss-map ergodicity) and GN.4 homogeneous dynamics go to math.DS (Annals #93, #95, #96) |
| LogicAndDefinabilityInNumberTheory | math.LO | o-minimal structures go to LO; semialgebraic sets stay with RealAlgebraicGeometry (AG) |
| FiniteFieldsAndCharacterSums FF.4 | math.IT, owner AlgebraicCodingTheory | |
| ComputationalNumberTheory CN.0, CN.4 | cs.DS / math.NA | the rest stays NT |
| ArithmeticDynamics | math.NT consumer | generic complex and Berkovich dynamics go to math.DS |
| QSeriesPartitionsAndMockModularForms | math.NT | q-identities (05A) go to CO; affine characters (17B) go to RT |
| TorsionCohomologyInfrastructure | math.NT (Galois and modularity lane) | despite the name, not a foundation of another field |

---

## 4. Protocol

### 4.1 Shape: hub and spokes

- **Normative:** TauCetiRoadmap `main`. It holds accepted roadmaps and is the only place workers take work from. Open TauCetiRoadmap PRs are proposals.
- **Hub:** one explorer repository, CBirkbeck/tauceti-explorer or a TauCetiProject-owned successor agreed with Chris. It holds the registry, the combined atlas and every cross-campaign check, and it alone regenerates `data/`.
- **Spokes:** one fork per campaign, owned by the campaign lead. They hold drafts and blueprints (`research/blueprint/roadmaps/<Id>.json` and packets), PR source files to the hub at least weekly, and run their own swarm or fleet. A spoke never publishes an atlas of its own.
- **Conflicts** resolve toward TauCetiRoadmap, then the hub registry, then the spoke.

Chris's campaign is the NT spoke, and the hub is presumably his repository. README "Porting existing work → coordinate first" applies, and so does his `focus.json` (Habiro, K-theory, Serre modularity, Caraiani–Newton on top).

### 4.2 Campaigns and sizing

Supply is counted as (main + open PR + campaign), from `supply_by_arxiv.md`. Demand comes from the OpenAI families by subject and the sections of the Annals 100.

| Fork / lane | arXiv classes | Supply | Demand signal | Verdict |
|---|---|---|---|---|
| **NT**: 6 lanes, galaxy-aligned: classical-analytic (elementary, computational, finite fields, analytic: 9 campaign); algebraic (number fields, local fields, CFT, forms and lattices, function fields: 6 + 12 main); arithmetic geometry (16); automorphic (15); Galois reps and Langlands (19 + 6 geometric Langlands); Iwasawa, special values and arithmetic K-theory (22 + 7) | math.NT | 16 + 8 + 78 | OAI 31, Annals ~25 of #1–51 | **too big**: lanes with their own leads |
| **AG**: 3 lanes: foundations, moduli and birational (3 campaign + 9 main + Abundance #545); cohomology and motives (9 + #196's 7 subs); p-adic geometry and Habiro (≈26) | math.AG | 9 + 2 + 47 | OAI 36, Annals ~25 (stacks, klt, K-stability, Higgs, Hodge) | **too big**. The foundations lane is nearly empty against heavy demand |
| **Algebra** | math.AC, RA, GR, RT, QA | ≈ 30 | OAI 18 + 14; Annals #52–61, #70, #82 | one fork, sub-leads for GR and RT |
| **Topology and categories** | math.AT, GT, CT, KT, GN | ≈ 29 | OAI 18; Annals #63, #72, #74, #78 | one fork |
| **Geometry** | math.DG, SG, MG | 5 + explorer drafts | OAI 29 + 15; Annals #62–69, #73, #75–76, #79–85 | one fork; supply is near zero |
| **Analysis and PDE** | math.CA, CV, AP, NA, SP, OC | 14 | OAI 16 + 16; Annals #84–92 | one fork |
| **FA, operator algebras, math-ph** | math.FA, OA, MP | 2 | OAI 11 + 19 + 25; Annals #92, #99, #100 | one fork, or a lane of Analysis while small |
| **Probability and dynamics** | math.PR, ST, DS | 6 | OAI 29 + 12; Annals #93–97 | one fork |
| **Combinatorics** | math.CO, cs.DM (+ math.IT codes) | 7 | OAI 37; Annals #94 | one fork |
| **Logic and TCS** | math.LO, cs.LO, cs.CC, cs.DS, cs.GT, cs.IT | 1 | OAI 40 + 6; Annals #98 | one fork |
| none | math.HO, math.GM | — | — | no campaign |

That gives 10 forks and 17 lanes. Thirty forks, one per arXiv class, would leave most of them with no lead, no reviewers and no supply.

### 4.3 Ownership registry

The registry is one machine-checked file in the hub, `data/campaigns.toml`, edited only by PR to the hub. It lists campaigns and every *planned* roadmap name, so it is the claim system for **roadmap authorship**.

```toml
[campaign."NT/classical-analytic"]
leads = ["<handle>"]; fork = "github.com/<handle>/tauceti-explorer"
arxiv = ["math.NT"]; galaxies = ["elementary","computational","finitefields","analytic"]
msc = ["11A","11B","11J","11K","11L","11M","11N","11P","11T","11Y","11Z"]

[roadmap.ExponentialSumsAndCircleMethod]
campaign = "NT/classical-analytic"; topic = "math.NT"
status = "blueprinted"   # reserved|drafting|blueprinted|hub-reviewed|upstream-pr|merged|retired
claimed = { by = "<handle>", until = "2026-11-07" }     # 30-day TTL, renewable
upstream = { pr = 0, dir = "" }                           # set when the TauCetiRoadmap PR opens
shared = false            # true = foundation consumed by ≥ 2 campaigns (stricter change rule)
exports = ["ES.2", "ES.3"] # stages other campaigns may cite
requires = ["tauceti:ArithmeticDirichletSeries", "tauceti-pr:248/LFunctions", "AdditiveCombinatorics:AC.3"]
```

- Every MSC code and arXiv class has exactly one owning lane. The COVERAGE_ATLAS rows become registry rows, and 11R/11S are reassigned off the retired roadmap to NT/algebraic.
- Every key definition the explorer has reserved (`research/blueprint/reserved-ids.json`, `data/keydefs/`) names one owning roadmap. A packet in another campaign that *defines* a reserved object fails the hub check.
- The hub CI rejects:
  - a roadmap file whose ID is not registered to the submitting campaign;
  - a topic outside the campaign's classes;
  - a duplicate ID or name, including against TauCetiRoadmap directory names on main and in open PRs.

### 4.4 Boundary rules

1. **Prerequisite theory, not consumer.** Étale cohomology is AG even when only NT uses it.
2. **Tiebreak by arXiv practice** for papers whose content matches the roadmap, as #517 did. MSC is only the scaffold.
3. **Most general form, most foundational owner.** A concept needed by two campaigns is planned once, in the general form all uses need (PROTOCOL §15), by the campaign whose subject it is. Ownership does not go to the first campaign that needs it.
4. **"Arithmetic X" stays a consumer.** Arithmetic K-theory, arithmetic dynamics and arithmetic statistics live in NT and import X from X's owner.
5. **Split by stage**, never duplicate a roadmap, when one straddles two campaigns (§3.3).
6. **A Part II inherits its parent's topic only if it is a true continuation the parent's author accepts.** Otherwise it is a sibling roadmap with its own topic and an explicit "starts where X stops" dependency.
7. **A boundary dispute** goes to a hub issue labelled `boundary`. The two leads decide within 7 days; failing that, the hub maintainer decides. The ruling is recorded in the registry so that it outlives the thread.

### 4.5 Naming

- TauCetiRoadmap directory names form one flat namespace (plus sub-directories). Campaign names must be unique against it and against the registry.
- Name roadmaps by content: no `PartII`, no category prefix, no "Campaign" namespace (README: roadmaps are timeless). For example, ModularCurvesPartII becomes a content-named sub-roadmap such as `ModularCurves/IntegralModels` if the ModularCurves authors accept it, otherwise a sibling named for its content. ArithmeticGaloisDuality keeps its name as a math.NT sibling of ProfiniteCohomology.
- The Lean namespace on promotion is `TauCetiRoadmap.<Name>`, not `TauCetiRoadmap.Campaign`.
- The explorer needs a `promoted.json` alias table: campaign ID → `tauceti:` ID. Links then *rewrite* when a roadmap lands upstream. Retirement currently *drops* them, so without the table a campaign roadmap and its promoted copy coexist on the map.

### 4.6 How campaign roadmaps enter TauCetiRoadmap

Gates, in order:

1. **Registry reservation** (§4.3).
2. **Blueprint** under the explorer protocol: sources, closure, independent review, red team.
3. **Promotion candidate**, a hub check plus one human:
   - (a) a **drift check** against Tau Ceti *main* (not only the pin) and every open TauCetiRoadmap PR, applying `roadmap-tauceti-drift-check`: consume existing objects by reducible alias, never add a parallel object;
   - (b) **condense** to a TauCetiRoadmap-shaped README of about 40–90 KB from the ≈190 KB blueprint: layers, pinned conventions, named declarations, worked examples, references; no execution states, no retired inputs, no "optional";
   - (c) a `Suggested.lean` that builds against TauCetiRoadmap's own Tau Ceti and Mathlib pins, with stand-ins only for objects nobody has built;
   - (d) `metadata.toml` set by §4.4;
   - (e) **suppliers first**: every cross-roadmap dependency is on main, or in an open PR, in which case add the `awaiting-dependencies` label;
   - (f) a **reverse-import build**: main plus this PR alone, over every roadmap that imports it (`roadmap-stacked-merge-order`);
   - (g) a named subject-area expert (CONTRIBUTING).
4. **Announcement in TauCetiRoadmap.** The intention template's `area` dropdown lists only existing roadmaps, so there is no claim for a roadmap *being written*. Two options:
   - near term: a Meta issue per campaign wave, plus the PR itself;
   - better: the owner proposes a "Planned roadmap" issue template, which needs @humans because it touches `.github/`. Planned roadmaps would then be visible in the repository workers already read. The Hasse–Minkowski hold #525 is the precedent.
5. **Human-posted PR** labelled `awaiting-review`, stating the models used. The poster has read it (CONTRIBUTING; agents may not open TauCetiRoadmap PRs). Review responses go as one comment per round (`roadmap-review-responses-as-comments`).
6. **Review** by roadmap-reviewers, then merge.

**Rate limits.** The measured bottleneck: TauCetiRoadmap merged 14, 14, 26 and 15 new roadmap READMEs in June to September (sub-roadmaps included). It has **57 open roadmap PRs, 31 awaiting review, median age 31 days, oldest 102 days**. 183 campaign plus explorer roadmaps at that rate is about a year of the whole pipeline. So:

- **Consolidate before promoting.** The campaign's granularity is roughly a third of a TauCetiRoadmap roadmap; the README itself prefers broad roadmaps. Target about 60–80 promoted roadmaps, not 183. For example: diamonds and six operations 7 → 2; K-theory 15 → 5; Iwasawa and Euler systems 22 → 8; Shimura 6 → 2.
- **WIP cap:** a campaign may have at most 3 new-roadmap PRs open, and none while one of its PRs has sat `awaiting-author` for more than 7 days. Above the present backlog, at most 15 campaign PRs open across all campaigns.
- **Order by demand times supplier position:**
  - foundations the goal lists need (LMFDB, Annals, OpenAI) come first: AG foundations, PR #196's family, LFunctions #248, Lubin–Tate, local Langlands for GLₙ;
  - frontier consumers come last, for example the ModularityAndLanglands endpoints (distance 10).
- **Grow reviewers by the existing rule** (two merged roadmap PRs → roadmap-reviewers). Every campaign lead should first land two roadmaps of ordinary size. Each campaign PR should get one reviewer from outside its campaign, to catch cross-campaign duplicates.
- **Never batch GitHub writes** across PRs from one account; keep each account well under GitHub's secondary limits.

### 4.7 How implementation fleets pick work

- Fleets implement **only merged TauCetiRoadmap roadmaps**. AI_EXECUTION step 1 already demands this. The one sanctioned exception is TauCeti's scope rubric, which accepts a prerequisite stage "on main or in an open PR".
- Each campaign runs a target list derived from its merged roadmaps, in the `tauceti-fleet` style. It claims targets through TauCeti's claim machinery and puts cross-campaign *supplier* items first (critical path).
- A consumer campaign may work ahead of an in-flight supplier through **lookahead branches** proved against sorry'd stubs, ported once the supplier merges (`tauceti-lookahead-authoring`). This is how campaigns overlap in time without waiting.
- The campaign's own WORK_QUEUE, swarm jobs and WORKER_BRIEF stay *planning* tools. Their output becomes TauCeti targets only through a merged README.

### 4.8 How duplicates are prevented

- **Planning layer.** Use the registry, reserved key definitions, the hub's "never duplicate" check, and *boundary jobs*: link and restructure jobs over every pair of campaigns that share MSC codes or reserved terms. Re-run all 33 restructure families against Tau Ceti main and open PRs: §3.2 shows the September restructure is already stale.
- **Roadmap layer.**
  - Run a family review for each promotion wave, read as one family, not as N documents (the 2026-08-09 group review).
  - Move names supplier-ward, then consume by reducible alias, and make each contract a closed `example` with no `sorry`.
  - Use one reviewer outside the campaign per PR.
- **Code layer.** Adopt the fixes the owner measured as missing (1.4% of TauCeti PRs were closed as duplicates):
  - one claim namespace;
  - host-side claims for agent-chosen targets;
  - claims that last the life of the PR;
  - a merged-twin check in housekeeping.

  Campaign fleets must not run their own claim store.

### 4.9 How cross-campaign dependencies are declared and checked

- **Declare in three places:**
  - README prose ("Dependencies", naming the supplier roadmap and layer);
  - the registry `requires` and `exports`;
  - explorer link files (`research/blueprint/links/`, quoted evidence from both sides, PROTOCOL §10).
- **The hub CI extends GRAPH_AUDIT to campaigns:**
  1. unique IDs and names;
  2. every cross-campaign stage edge resolves to a registered roadmap's **exported** stage, a `tauceti:` layer, or a `tauceti-pr:` layer;
  3. the combined stage graph is acyclic, and a cycle-closing link fails the submitting PR instead of being silently dropped, as `promote.py` does today;
  4. supplier-before-consumer: no roadmap reaches `upstream-pr` before its suppliers;
  5. a per-campaign table of incoming and outgoing edges, with a report of stages consumed by other campaigns that are not marked `exports`;
  6. edges to retired or renamed roadmaps fail.
- **A `shared = true` roadmap** may change exported stages only with a notice to consuming campaigns (a hub issue) and a re-run of check 2.

### 4.10 Risks

1. **Review capacity.** 150 roadmaps "landing at once" in a repository whose README requires human review would bury the queue (§4.6). The WIP cap and consolidation are the mitigation. Drafting more does not help.
2. **Source of truth drift.**
   - The explorer snapshot is three weeks old;
   - its restructure ignores 8 main roadmaps and about 40 PRs;
   - content/campaign READMEs still restate narrowed material;
   - 163 confirmed findings about Tau Ceti roadmaps sit in `UPSTREAM_NOTES.md` without reaching TauCetiRoadmap.

   Mitigation: §4.1's precedence order, the drift gate, and routing UPSTREAM_NOTES as TauCetiRoadmap *Roadmap issues*, human-filtered and posted at a slow cadence.
3. **Critical path on unmerged PRs.** Fifteen campaign roadmaps rest on #196, others on #248, #279, #280 and #287. Merging these suppliers is worth more than any new draft.
4. **Document size.** 190 KB to 6 MB blueprints cannot be human-read. Promotion must condense them, not copy.
5. **Cross-class Part IIs** silently re-file NT content under GR, RT or AG topics (§3.1). Rule 6 fixes it.
6. **Progress resets.** Editing an existing README re-keys `readme_sha` and has blanked assessments before (the 10-02 wipe of 59 layers; TauCeti#10736). Prefer new siblings over in-place expansion of others' roadmaps.
7. **Fragmented swarms.** Ten independent planning swarms on ten forks would repeat Tau Ceti's claim-namespace problem one level up. Keep one claim namespace per layer (hub registry for authorship, TauCeti claims for code).
8. **Single-maintainer hub.** The hub depends on one person's repository and tooling, including the private snapshot inputs. Agree governance and ask that the snapshot inputs be published before ten forks depend on them.

### 4.11 Decisions needed from the owner

- (a) Hub location and governance, with Chris.
- (b) Accept about 10 forks and 17 lanes (§4.2) rather than one fork per class.
- (c) Propose the "Planned roadmap" issue template to @humans.
- (d) WIP caps and consolidation target.
- (e) Who drafts the drift re-run of the 33 restructure families against current main and open PRs. GeometryOfNumbers, AnalyticNumberTheory, AdelicAlgebraicGroups and StableHomotopyKTheory are the first four.
