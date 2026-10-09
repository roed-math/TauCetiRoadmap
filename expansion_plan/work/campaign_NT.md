# Campaign NT (math.NT): slate, ownership and promotion order

Phase 2, 2026-10-07. Machine version with full scope paragraphs: `slate_NT.json` (the paragraphs below are
condensed). Demand tables and scripts: scratchpad `p2-nt/` (`campaign_demand.json`, `units.json`, `slate_goals.json`).

## 1. Scope

**Classes:** math.NT. **Subject:** the arithmetic of number fields, local fields and function fields, of their Galois
groups, L-functions and automorphic forms, and of the Diophantine geometry (curves, abelian varieties, Shimura
varieties, heights) whose questions are arithmetic. Theory whose arXiv home is elsewhere (étale and p-adic
cohomology, schemes, abelian schemes, p-adic representations, K-theory, ergodic theory) is imported; "arithmetic X"
stays here as a consumer (coordination §4.4 rule 4).

**Demand.** 268 primary needs (LMFDB 134, OpenAI 122, Annals 12) plus 87 rows elsewhere that list math.NT as
secondary (AG 37, ALG 15, TOP 10, LTCS 8, PRDS 5, COMB 5, GEO 4, ANA 3).

By coverage: mathlib 35, tauceti-code 20, tauceti-roadmap 35, open-pr 17, birkbeck-campaign 80, oai-lean 17, gap 64
(LMFDB 47, OpenAI 15, Annals 2). LMFDB gaps sit in sections with no owner (av.fq, st_group, smf, maass, hmf, bmf, hgm, labels); OpenAI gaps cluster in
multiplicative number theory and anabelian geometry; `oai-lean` rows have sorry-free paper proofs but no library owner;
the 80 campaign rows are promissory (11 KB READMEs, distance 3–10).

## 2. Existing supply

### 2.1 Tau Ceti main, completed and open PRs

Remaining PRs from the explorer progress snapshot; "Needs" = rows of `needs_all.jsonl` naming the roadmap as owner.

| Roadmap | Covers | Needs | Action |
|---|---|---|---|
| ArithmeticDirichletSeries, Chebotarev | Dirichlet series, Perron, prime ideal theorem; Chebotarev; all layers done | 3 / 3 | archive (#725, #722); S17 builds on them |
| ClassFieldTheory | class formations, local/global CFT, Hilbert symbol, Weil group; ~290 left | 9 | leave; exclusions → S14, S15, U8 |
| EllipticCurves | AEC I–X, Tate's algorithm, Mordell–Weil, Selmer; ~390 left | 20 | leave; what Layer 8 disowns → S18, S8, S7 |
| GlobalNumberFields, GlobalQuadraticForms | adeles, ray classes, Hecke characters; Hasse–Minkowski; ~75 left | 3 / 0 | leave; S4 consumes GQF |
| IntegralLattices | genus, spinor genus, local densities, Nikulin; ~230 left | 9 | leave; names seven successors, S12–S13 absorb six |
| LocalFieldsRamification, LocalGaloisGroups | filtrations, Herbrand; G_K, Demushkin, local duality; ~80 left | 2 / 2 | leave; S10, S14 build on them |
| ModularCurves | Katz–Mazur moduli; 9/11 layers untouched, ~140 left | 3 | leave; campaign U11 continues it as content-named sub-roadmaps |
| ModularForms | nebentypus, Hecke, newforms, L-functions, LMFDB layer; ~440 left | 11 | leave; Eisenstein newforms, minimal twists later (mind `readme_sha`) |
| Multiquadratic, NumberFieldArithmetic, PolynomialGaloisGroups | done | 0 / 5 / 3 | archive (#719, #726; PGG held for a pin bump); LMFDB index, degree ≥ 6 → S1 |
| OrthogonalSpinGroups, QuadraticFormInvariants | Spin, spinor norm; local invariants; ~150 left | 4 / 1 | leave; OSG names S13's successors; S4 consumes QFI |
| **#248 LFunctions** | Hecke/Grössencharacter L-functions, FE; waiting since 08-17 | 6 | **merge soon**: prerequisite of S5, S6, S9, S11, S12, S13, S17 |
| **#253 ZerosOfLFunctions** | zero-free regions, explicit formula, PNT; excludes Siegel | 7 | **merge after #248**: blocks S17 sub 1 |
| **#286 ThetaSeries** | Poisson summation, lattice theta series, Hecke–Schoeneberg | 2 | **merge first** (#248 imports it); prerequisite of S11 (Siegel theta) and S12 |
| **#287 ArithmeticHeights** | heights, Northcott, successive minima, Siegel's lemma; no review label | 10 | **merge soon**: prerequisite of S18 and U3 |
| #451 LinearFormsInLogarithms | Baker over ℂ and ℂ_p; awaiting author | 2 | merge after revision (S16, U3) |
| #226 MassFormula | Serre's mass formulas | 1 | merge (S10, S1) |
| Adjacent: FuchsianOrbifolds (CV, main), #432 KleinianGroups (GT), #717 CertifiedPermutationComputation (GR) | Γ\ℍ; ℍ³ and Bianchi groups; certified nTj | 6 / 5 / 1 | #432 merge soon (S11, S12); #717 feeds S1 |

Also #219 Rank24LatticeConstructions and #419 ECM (merge when reviewed) and completed EffectiveBounds. Main remaining in
math.NT ≈ 1,800 PRs; the eight NT PRs ≈ 950.

### 2.2 Unwritten successors already named on main

RestrictedProducts, IL and OSG name AlgebraicGroupStrongApproximation, ArithmeticReductionTheory, TamagawaMeasures,
AdelicFourierAnalysis, OrthogonalTamagawaAndLatticeMass (→ S13); IL also names FiniteQuadraticModuleWittTheory and
IndefiniteThetaAndSiegelWeil (→ S12) and IndefiniteLatticeAutomorphisms (left to the lattice authors), and lists the Weil
representation and half-integral weight as unowned (→ S12); AlgebraicCurves names CurvesOverFiniteFields,
HyperellipticCurves (→ S2, S3) and AbelianVarieties (AG); #248 names ArtinRepresentations (→ S5); CFT excludes Lubin–Tate
theory and power reciprocity (→ S14, S15).

### 2.3 Birkbeck campaign: consolidation into promotion units

The six NT lanes of coordination §4.2 (1 classical-analytic, 2 algebraic, 3 arithmetic geometry, 4 automorphic, 5 Galois
and Langlands, 6 Iwasawa, special values and arithmetic K-theory) hold the 78 math.NT-primary campaign roadmaps plus 31
whose primary MSC is outside 11 (14, 13D, 19, 20G, 22E, 37P) but whose subject and consumers are arithmetic (Shimura varieties, heights, Faltings,
anabelian, p-adic Hodge, geometric Langlands, arithmetic K-theory, adelic groups, automorphic representations,
endoscopy). 96 of these 109 form **44 promotion units**; 6 are absorbed by the slate and 7 handed off
(AdditiveCombinatorics splits between U1 and COMB). Demand = deduplicated need rows (all goals and campaigns) whose
`owner` names a member; it undercounts pure suppliers, so the order also weighs distance and what each unit unblocks.
Order tier 1 = now (distance ≤ 6 or a slate item waits), 2 = after the §5 suppliers, 3 = frontier (distance 9–10).
PRs at Tau Ceti standard (a campaign README expands about 3×).

**Absorbed by the slate:** AdelicAlgebraicGroups (S13), MetaplecticAutomorphicForms (S12), ArakelovGeometryAndAbelianHeights
(S18), FiniteFieldsAndCharacterSums (S2); AnalyticNumberTheory dissolves (AN.0–1 Mathlib/ADS, AN.2 and AN.5 → S17, AN.3–4
duplicate #248/#253, AN.7 → U20, AN.8 → U4, AN.9 frontier), as does GeometryOfNumbersAndQuadraticArithmetic (GN.0–3
duplicate IL, #286, #287, GQF, QFI, OSG; GN.4 → PRDS; GN.5 → U5; GN.6 → TOP/ALG). **Handed off:**
AbelianSchemesAndArithmeticModuli, NeronModelsAndSemistableAbelianVarieties (AG; demand 7, 4), AdditiveCombinatorics
AC.0–3 (COMB), LogicAndDefinabilityInNumberTheory (LTCS; demand 5), HabiroNahmSeries, HabiroNumberFields (AG Habiro
cluster), ArithmeticQuantumTopology (TOP/AG).


| U (order) | Unit (lane) | Campaign members | Demand (L/A/O) | PRs | Narrow |
|---|---|---|---|---|---|
| U25 (1.1) | ArithmeticGaloisRepresentations (5) | = | 8 (5/1/2) | 200 | R01.2–3 vs LGG, NFA, EC; R01.3 → S5 |
| U7 (1.2) | ArithmeticGaloisDuality (2) | ArithmeticGaloisDuality; SelmerIwasawaCohomology L0–L2 | 2 (0/1/1) | 250 | local duality is LGG's; Selmer L0–L2 = R02.4–5 |
| U36 (1.3) | PadicMeasuresAndIwasawaAlgebras (6) | PadicMeasuresIwasawaAlgebras; LocallyAnalyticDistributions | 2 (0/2/0) | 250 | L1 must use Tau Ceti completedGroupAlgebra |
| U1 (1.4) | SieveMethodsAndPrimePatterns (1) | SieveMethodsAndPrimePatterns; AdditiveCombinatorics AC.4–5 | 13 (0/0/13) | 300 | AC.0–3 → COMB; extend per §4 |
| U12 (1.5) | ShimuraVarieties family (3) | ShimuraData, ShimuraVarieties, PELModuli, HilbertModularVarietiesAndShimuraCurves | 15 (3/2/10) | 500 | D0–D2 first; AG/GEO boundary |
| U16 (1.6) | ComplexMultiplicationAndExplicitReciprocity (3) | = | 5 (3/0/2) | 220 | CM.3 vs CFT ring class fields; CM.4 vs GNF |
| U11 (1.7) | ModularCurvesPartII → ModularCurves subs (3) | R12–R14 | 4 (4/0/0) | 300 | R12.3 vs FuchsianOrbifolds; rename |
| U37 (1.8) | CyclotomicIwasawaTheory (6) | DirichletPadicLFunctions, ColemanPowerSeries, IntegralIwasawaTheory, EulerSystemsCyclotomicMainConjecture, ColemanIntegration | 4 (2/1/1) | 600 | DPL L0 vs Mathlib; consume S14 |
| U6 (1.9) | ClassicalArithmeticCompletion (1) | = | 1 (0/0/1) | 100 | CA.1 → S15; CA.5 = NFA |
| U5 (1.10) | CertifiedArithmeticComputation (1) | ComputationalNumberTheory, EffectiveDiophantineMethods | 3 (0/0/3) | 200 | CN.0, CN.4 → LTCS/ANA; CN.1 vs #419 |
| U3 (2.1) | DiophantineApproximationAndTranscendence (1) | DiophantineApproximationAndTranscendence; PM.3, PM.5 | 6 (0/0/6) | 220 | DT.0, DT.3 = #287, #451; PM.0–1 → S17; PM.2, PM.4 → PRDS |
| U18 (2.2) | AutomorphicFormsAndSpectralDecomposition (4) | AutomorphicFormsOnReductiveGroups; AutomorphicSpectralTheory AS.0–AS.4 | 10 (2/4/4) | 450 | extend: GL_n multiplicity one |
| U21 (2.3) | GL2AutomorphicRepresentationsAndTransfer (4) | = | 5 (2/2/1) | 400 | — |
| U22 (2.4) | ArithmeticLocallySymmetricSpaces (4) | = | 2 (1/1/0) | 220 | — |
| U26 (2.5) | PadicGaloisRepresentations (5) | PadicHodgeTheory R06.1–4, R06.6; PhiGammaModulesAndIwasawaCohomology | 5 (0/1/4) | 450 | R06.5, P8 → AG |
| U27 (2.6) | GaloisDeformationTheory (5) | GlobalGaloisDeformations, LocalGaloisDeformationRings; DeformationAndDerivedPatchingAlgebra R03.5–6, P7–9; FiniteFlatGroups… R07.3–6 | 6 (0/1/5) | 500 | R03.1–4 → ALG; R07.1–2 → AG |
| U20 (2.7) | AutomorphicLFunctions (4) | AutomorphicLFunctionsAndLocalFactors AL.2–5 | 2 (1/1/0) | 250 | GL₁ = #248; AL.0–1 → S13; extend: Selberg class |
| U4 (2.8) | ArithmeticStatistics (1) | ArithmeticStatistics; AN.8 | 1 (0/0/1) | 250 | extend: Smith (ST.5) |
| U2 (2.9) | ExponentialSumsAndCircleMethod (1) | = | 3 (0/0/3) | 200 | decoupling → ANA |
| U10 (2.10) | InverseGaloisAndArithmeticFundamentalGroups (2) | = | 2 (0/1/1) | 220 | IG.0–1 consume #196 |
| U14 (2.11) | FaltingsFinitenessAndRationalPoints (3) | FaltingsFinitenessAndIsogenyTheorems; HeightsRationalPointsAndObstructions RP.1–6 | 7 (2/1/4) | 300 | RP.0 → S18; extend: Zilber–Pink statement |
| U24 (2.12) | QSeriesPartitionsAndMockModularForms (4) | = | 1 (0/1/0) | 200 | QM.1 vs MF, #286, S12 |
| U38 (2.13) | EulerAndKolyvaginSystems (6) | EulerSystemsAndKolyvaginSystems; SelmerIwasawaCohomology L3–4 | 1 (0/0/1) | 250 | — |
| U13 (3.1) | ShimuraCompactificationsAndAutomorphicBundles (3) | ShimuraCompactifications; AutomorphicBundles | 0 (0/0/0) | 300 | — |
| U28 (3.2) | GaloisRepresentationsOfModularForms (5) | AutomorphicGaloisRepresentations; IntegralHeckeAndGaloisDeterminants; AlgebraicModularFormsAndSerreWeights | 3 (2/0/1) | 400 | — |
| U19 (3.3) | TraceFormulasAndEndoscopy (4) | AutomorphicSpectralTheory AS.5–6; EndoscopicTransferAndUnitaryTraceComparison | 5 (0/5/0) | 500 | extend per §4 (Annals #19, #31) |
| U39 (3.4) | HeegnerPointsAndGrossZagier (6) | HeegnerPointEulerSystems; GrossZagierAndArithmeticHeights; GeneralizedHeegnerCycles | 3 (1/0/2) | 600 | GZ.1 vs S18 |
| U40 (3.5) | PadicLFunctionsOfModularForms (6) | ModularSymbolsPadicLFunctions; AutomorphicPadicLFunctions; KatoEulerSystems | 3 (0/1/2) | 500 | — |
| U41 (3.6) | MainConjecturesAndBSD (6) | ModularIwasawaMainConjectures; AutomorphicCongruences; RankZeroOneBSD | 6 (2/0/4) | 600 | — |
| U29 (3.7) | ModularityLiftingOverQ (5) | GL2ModularityLifting; OrdinaryAutomorphicFormsAndModularityLifting; SerreWeightAndLevelOptimisation; PotentialModularityAndCompatibleSystems | 2 (1/0/1) | 600 | R21.1–2 = PadicFamilies L0 |
| U30 (3.8) | SerreModularityAndEllipticCurveModularity (5) | ClassicalSerreModularity, SmallRamificationAndAbelianVarietyBaseCases, EllipticCurveModularity | 4 (1/0/3) | 500 | — |
| U31 (3.9) | CompletedCohomologyAndPadicLocalLanglands (5) | CompletedCohomologyAndLocalGlobalCompatibility; CompletedCohomologyPartII; PadicLocalLanglandsForGL2Qp | 2 (0/0/2) | 500 | — |
| U23 (3.10) | PadicFamiliesOfAutomorphicForms (4) | PadicFamilies; OverconvergentAutomorphicForms | 1 (0/0/1) | 400 | — |
| U42 (3.11) | SpecialValueConjectures (6) | PeriodsAndSpecialValues; SpecialValuesBirchTate; NoncommutativeAndEquivariantIwasawa | 2 (0/0/2) | 500 | — |
| U43 (3.12) | KTheoryOfNumberFields (6) | ArithmeticKTheory; BorelRegulators; KTheoryFiniteLocalFields | 0 (0/0/0) | 450 | — |
| U44 (3.13) | RegulatorsAndPolylogarithms (6) | Polylogarithms; EllipticRegulators; EllipticKTheory; PadicHodgeRegulators | 0 (0/0/0) | 500 | — |
| U32 (3.14) | HigherRankGaloisRepresentationsAndPotentialAutomorphy (5) | AutomorphicGaloisRepresentationsPartII, TorsionCohomologyInfrastructure, IgusaVarietiesAndTorsionConcentration, PotentialAutomorphyInfrastructure, ModularityAndLanglandsExtensions, PerfectoidShimuraVarieties, HodgeTateAndCanonicalSubgroups | 3 (0/0/3) | 800 | split at promotion |
| U33 (3.15) | GeometrizationOfLocalLanglands (5) | BunGAndNewtonStrata; HeckeStacksAndLocalShtukas; GeometricSatakeAndFusion; VStackSheavesAndLisseCategories | 2 (0/1/1) | 600 | — |
| U34 (3.16) | SpectralActionAndLanglandsParameters (5) | LanglandsParameterStacks; ExcursionOperatorsAndSpectralAction | 1 (0/0/1) | 300 | — |
| U35 (3.17) | GlobalShtukasAndFunctionFieldLanglands (5) | = | 1 (0/0/1) | 300 | — |
| U8 (3.18) | FunctionFieldArithmetic (2) | FunctionFieldArithmetic FA.2–4, FA.6–7; DrinfeldModulesAndTModules | 0 (0/0/0) | 350 | FA.0–1 = AlgebraicCurves; FA.5 → S2 |
| U15 (3.19) | AnabelianGeometryAndNonabelianChabauty (3) | = | 1 (0/0/1) | 200 | fields → S16 |
| U17 (3.20) | ArithmeticDynamics (3) | = | 0 (0/0/0) | 200 | generic dynamics → PRDS |
| U9 (3.21) | HigherLocalFieldsAndHigherClassFieldTheory (2) | = | 0 (0/0/0) | 200 | — |

Notes. U1's own demand is 10 rows over 7 OpenAI families (3 more name AC.3, COMB's). U12 has the largest demand (15
rows: Hermitian domains, Shimura data); only ShimuraData D0–D2 is promotable before AG's abelian schemes. Campaign-internal
duplicates beyond coordination §3.2: SelmerIwasawaCohomology L0–L2 vs R02.4–R02.5; PadicFamilies L0 vs R21.1–R21.2; FA.5
vs S2; MP.7–MP.8 vs QM.1. Blueprint-only roadmaps in `focus.json` (EllipticCurveModularityImaginaryQuadratic,
MordellLawrenceVenkatesh, …) join U30, U32, U14; the explorer's top focus (Caraiani–Newton, OAI#030) is a tier-3
endpoint whose suppliers U25, U22, U27 are promoted early anyway. Units total ≈ 16,100 PRs (≈ 8,200 at 85 each).

## 3. The slate

Eighteen new roadmaps: 13 standalone, 5 umbrella families with 20 sub-roadmaps (33 READMEs, 18 reviews). They absorb
the 16 math.NT LMFDB proposals plus P5 and the arithmetic half of P4, the 6 math.NT OpenAI proposals, the 4 math.NT
Annals proposals (two as layers of U19), the successors of §2.2 and the 6 campaign roadmaps above. Abbreviations:
NFA, PGG, MF, EC, IL, LFR, LGG, CFT, GNF, QFI, GQF, OSG, ADS = the main roadmaps of §2.1.

**LMFDB lane, P1–P23 of `lmfdb.md`:** P1 → S1; P2, P3 → S2; P4 split (Poincaré, Rosati, Albert → AG; database
invariants → S6); P5 → S3 (kept in NT, imports AG curves and Néron models); P6–P9 → S4, S5, S6, S7; P10 → AG
(CanonicalModelsAndGonality); P11 → S8; P12, P14, P15, P16, P23 → S11; P13 → AG (surfaces); P17 → S12; P18 → S9; P19 →
AG; P20 → ALG (FiniteGroupInvariants); P21 → GEO (LatticePackingsAndPerfectForms); P22 → S10;
OrthogonalTamagawaAndLatticeMass → S13. Small extensions instead of roadmaps: Eisenstein newforms and minimal twists
(ModularForms, later layer), Selberg-class predicate (U20), Hardy's Z (#253), unit signature rank (GNF), Kronecker symbol
(S15), Kloosterman sums (S2).

**OpenAI:** PowerReciprocityLaws → S15; GaussSumsAndMetaplecticTheta → S12; SiegelZeros…, MultiplicativeFunctions…,
AnatomyOfIntegers → S17; BirationalAnabelianGeometry → S16; HomogeneousDynamics → PRDS; GrothendieckTeichmuller → ALG;
CharacterVarieties → AG. **Annals:** MaassFormsAndSpectralTheory → S11; ArakelovIntersectionTheory → S18 (math.NT by
rule 4: it consumes AG's IntersectionTheory); RelativeTraceFormulas, ArthurParameters → layers of U19 (one Annals entry
each on a distance-10 stack).


### 3.1 LMFDB lane

**S1. LMFDBLabelsAndCompleteness** — math.NT · L, ~250 PRs · wave A

An LMFDB label is a tuple of isomorphism invariants followed by an index into a finite list sorted by a fixed rule; object roadmaps state the invariants and stop at the index, which this roadmap owns. It builds a carrier for labelled finite enumeration, the normal forms that pick representatives (polredabs, ideal labels, newform-orbit and isogeny-class orders, RSZB, p-adic, Artin, Sato–Tate, lattice and L-function labels), and the completeness theorems that make lists exhaustive (Hunter–Pohst, Krasner with Serre's mass formula, Sturm bounds, completeness by conductor under modularity as a named hypothesis). It fixes the conventions that differ between systems and states conditional data (GRH class groups, analytic ranks, analytic Ш) as implications. Orderings, normal forms, stored lists and conventions belong here; isomorphism invariants stay with object roadmaps.

- *Milestones:* enumeration carrier → nf (Hunter–Pohst) → lf (Krasner + Serre) → gg (#717) → cmf (Sturm) → other sections as their roadmaps land. *Prerequisites:* NFA, PGG, MF, EC, BelyiMaps, IL, LFR, #226, #717; each LMFDB-lane roadmap; U5. *Goals:* LMFDB 24 sections (every labelled section); 24 need rows.
- *Porting:* Tau Ceti IntrinsicLabel, TransitiveGroupLabel, Passport/Label; LMFDB label code as specification. *Replaces:* P1; CN.5 (LMFDB instance). *Formalizability:* high; the risk it removes is convention drift.

**S2. ArithmeticOfFiniteFields** — math.NT · XL family (M 120 + L 230 + L 300), ~650 PRs · wave A (subs 1-2), B (sub 3)

Arithmetic over 𝔽_q around point counts and the Weil bounds. CharacterSumsOverFiniteFields: Gauss and Jacobi sums of all orders, Hasse–Davenport, Kloosterman and Salié sums, Weil bounds for character sums and Kloosterman sums. CurvesOverFiniteFields: zeta functions of function fields, rationality and functional equation, the Riemann hypothesis by Stepanov–Bombieri, Hasse–Weil/Serre/Ihara, Weil polynomials as combinatorics. AbelianVarietiesOverFiniteFields: Frobenius, Tate's isogeny theorem, Honda–Tate, and isomorphism classes in an isogeny class (Deligne modules, Centeleghe–Stix, ℤ[π, q/π], weak equivalence, polarizations). Higher-dimensional Weil conjectures are AG's and consume the curve case.

- *Milestones:* RH for curves (Stepanov–Bombieri) → Weil bounds → Hasse–Weil/Serre/Ihara → Weil-polynomial finiteness → Tate isogeny theorem → Honda–Tate → Deligne modules. *Prerequisites:* AlgebraicCurves, JacobianChallenge, CFT, NFA, AG abelian varieties, U16 (Honda), Mathlib GaussSum/JacobiSum. *Goals:* LMFDB 5 sections (av.fq, character.dirichlet, g2c, modcurve, shimcurve); OpenAI #013; 6 need rows.
- *Porting:* none beyond Mathlib Gauss/Jacobi sums and EllipticCurves L3. *Replaces:* P2, P3; campaign FF.0–FF.3, FF.5; FA.5. *Formalizability:* high for subs 1–2; sub 3 waits for an abelian-variety supplier.

**S3. HyperellipticCurves** — math.NT · L, ~220 PRs · wave A

Curves y² + h(x)y = f(x) over any field: models, twists, discriminant; genus-2 invariants (Igusa–Clebsch, J₂…J₁₀, G2) with the isomorphism theorem, Mestre's obstruction, automorphism groups; minimal models over DVRs and ℤ; cluster pictures (odd p) with semistability, Tamagawa numbers, root numbers, conductors; 2-descent and good Euler factors. Curves and Jacobians come from AlgebraicCurves and JacobianChallenge, Néron models from AG.

- *Milestones:* Igusa invariants characterize isomorphism → Mestre obstruction → minimal models → cluster semistability, Tamagawa and conductor → 2-descent → good Euler factors. *Prerequisites:* AlgebraicCurves L10, JacobianChallenge, EC, LFR, S2, AG Néron models. *Goals:* LMFDB 1 section (g2c); 5 need rows.
- *Replaces:* P5 (named by AlgebraicCurves). *Formalizability:* high; finite algebra plus Galois cohomology on main.

**S4. QuaternionArithmetic** — math.NT · L, ~250 PRs · wave A

Quaternion algebras over number fields and their orders, after Voight: local invariants, classification by ramification (Hilbert reciprocity and Hasse–Minkowski consumed), norm forms, maximal, Eichler, Gorenstein and Bass orders, class sets and type numbers, the Eichler mass formula and class-number theorem, optimal embeddings, Brandt matrices. Over ℚ: the arithmetic Fuchsian groups of Eichler orders, Shimizu's volume, genus and elliptic points of X(D;N), Atkin–Lehner quotients, polarized orders and the groups indexing LMFDB Shimura curves. QM moduli are U12's; models and gonality AG's.

- *Milestones:* classification by ramification → Eichler mass formula → Eichler class-number theorem → embedding numbers → Brandt matrices → Shimizu volume → genus of X(D;N). *Prerequisites:* QFI, GQF, CFT, NFA, GNF, FuchsianOrbifolds, OSG, S13 (strong approximation), Mathlib QuaternionAlgebra. *Goals:* LMFDB 2 sections (hmf, shimcurve); 4 need rows.
- *Porting:* Voight's book (no Lean). *Replaces:* P6 (July W2). *Formalizability:* high; indefinite class numbers use S13's strong approximation.

**S5. ArtinRepresentations** — math.NT · L, ~240 PRs · wave B (#248)

Complex representations of local and global Galois groups (finite image). Local: Artin and Swan conductors (Hasse–Arf), Langlands–Deligne constants of Weil–Deligne representations (existence cited), root numbers including Rohrlich's for elliptic curves. Global: Artin L-functions and formalism, continuation and functional equation via Brauer induction and #248, the conductor–discriminant formula; Artin's conjecture, the weight-one dictionary and Stark at s = 0 stated. The LMFDB invariants (determinant, parity, Frobenius–Schur, projective image, fields) and finite-image mod-ℓ representations with Chebotarev recognition. ℓ-adic representations stay with U25, which consumes the conductors.

- *Milestones:* Hasse–Arf → inductivity of local constants → Artin formalism → continuation via Brauer → conductor–discriminant → Chebotarev recognition mod ℓ. *Prerequisites:* #248, RepresentationTheory (characters, induction), LFR, LGG, CFT, Chebotarev, S13's AdelicFourierAnalysis. *Goals:* LMFDB 5 sections (artin, cmf, ec, lf, modlgal); 10 need rows.
- *Replaces:* P7 (named by #248); campaign R01.3 and the finite-image part of R01.4–R01.5. *Formalizability:* high; Deligne's existence of local constants cited.

**S6. SatoTateGroups** — math.NT · L, ~220 PRs · wave A (group side), B (arithmetic)

Sato–Tate groups: the Fité–Kedlaya–Rotger–Sutherland axioms, component groups, moments by Weyl integration, the classifications in degree 2 and degree 4 (52 groups), degree 6 as checked data. Arithmetic half: End over k and k̄, the endomorphism field, End⁰ ⊗ ℝ, Galois endomorphism types in dimension 2, GL₂-type varieties and ℚ-curves; ST(A) and ST(f) from ℓ-adic images (algebraic Sato–Tate stated); equidistribution stated, proved for CM elliptic curves. Poincaré reducibility, Rosati and Albert come from AG.

- *Milestones:* Weyl-integration moments → degree-2 and degree-4 classifications → Galois types ↔ ST groups in dimension 2 → equidistribution for CM elliptic curves. *Prerequisites:* RepresentationTheory (compact/Lie/classical groups), #248, U25, AG abelian varieties, JacobianChallenge. *Goals:* LMFDB 4 sections (ec, ecnf, g2c, st_group); 7 need rows.
- *Replaces:* P8; arithmetic half of P4. *Formalizability:* high for compact groups; arithmetic layers wait for the AV supplier.

**S7. AdelicImagesAndModularCurves** — math.NT · L, ~300 PRs · wave A (group side), B (moduli side)

Images of ρ_E: G_K → GL₂(Ẑ). Group side: open H ≤ GL₂(Ẑ), level, index, Γ_H invariants, Dickson, Serre's lifting lemma, entanglement, GSp₄ analogues. Arithmetic side: adelic images, Serre's open image theorem, the CM case, Mazur and Kenku cited, isogeny classes and graphs. Moduli side: X_H over K and its points, j-map, cusps, CM and isolated points, fiber products, Gassmann pairs, minimal twists, J_H as a product of A_f. Katz–Mazur moduli are ModularCurves' and U11's; gonality is AG's.

- *Milestones:* Dickson → Serre lifting → genus/cusp formulas for Γ_H → Serre open image → X_H(K) moduli bijection → decomposition of J_H. *Prerequisites:* ProfiniteProPGroups, MF L10, FuchsianOrbifolds, EC, ModularCurves, CFT, U11 (R13.4a, R14.5). *Goals:* LMFDB 4 sections (ec, ecnf, g2c, modcurve); 8 need rows.
- *Porting:* RSZB data as tests. *Replaces:* P9. *Formalizability:* high for the group side; open image is long but classical.

**S8. EllipticCurvePeriodsAndModularParametrizations** — math.NT · M, ~110 PRs · wave B

Invariants of elliptic curves from periods or X₀(N): period lattices over a number field K, Ω_{E/K} and the BSD quotient over K, analytic Ш over ℚ and K (L* from RankZeroOneBSD, over K under a pinned hypothesis); optimal curves, the modular degree and the congruence modulus, the Manin constant (integrality cited, c = 1 stated), Stevens' conjecture, Cremona's optimal-first convention for S1. Modularity, A_f and Hecke correspondences are U11/U30's.

- *Milestones:* period lattices and Ω over K → BSD quotient over K → optimality → modular degree via Petersson norm → Manin constant (cited). *Prerequisites:* EC, MF, S7, U11 (R12.1, R14.5), U30 and U41 interfaces. *Goals:* LMFDB 2 sections (ec, ecnf); 4 need rows.
- *Replaces:* P11; July W3 EichlerShimuraModularAV (invariant layer). *Formalizability:* medium; deep statements cited with pinned hypotheses.

**S9. HypergeometricMotives** — math.NT · L, ~200 PRs · wave B

Hypergeometric data α, β ⊂ ℚ/ℤ: monodromy (Levelt, Beukers–Heckman, invariant forms, Bézout matrices), the zigzag Hodge vector, finite hypergeometric sums (Katz, Greene, Beukers–Cohen–Mellit) and their rationality, and the L-function: good Euler factors, tame and wild primes, Roberts–Rodriguez-Villegas conductors stated, Katz's motive cited. Gauss sums from S2; ℓ-adic sheaves are AG's.

- *Milestones:* Levelt rigidity → Beukers–Heckman → zigzag Hodge numbers → BCM rationality → good Euler factors. *Prerequisites:* S2, #248, Mathlib cyclotomic fields. *Goals:* LMFDB 1 section (hgm); 4 need rows.
- *Replaces:* P18; July W3 FiniteHypergeometricSums. *Formalizability:* high; the motive identification is cited.

**S10. PadicExtensionFamilies** — math.NT · L, ~200 PRs · wave A

Ramification read off Eisenstein polynomials: Newton and ramification polygons, residual polynomials and their relation to breaks, Swan slopes and the Herbrand function, indices of inseparability, visible and hidden slopes and the Galois mean slope, Krasner bounds and finiteness, families with fixed ramification polygon with packets and masses compared with #226, and the Galois root discriminant. Ramification groups are LFR's, G_K is LGG's, counting is #226's.

- *Milestones:* slope factorization → polygon-to-break theorem → Krasner finiteness → family masses vs Serre → Galois root discriminant. *Prerequisites:* LFR, LGG, #226, Mathlib IsEisensteinAt and Krasner. *Goals:* LMFDB 2 sections (lf, nf); 3 need rows.
- *Porting:* Pauli–Sinclair algorithms as specification. *Replaces:* P22. *Formalizability:* high; valuation algebra on main.

### 3.2 Automorphic lane

**S11. ClassicalAutomorphicForms** — math.NT · XL family (L 250 + L 250 + L 220 + L+ 400 + M 90), ~1210 PRs · wave A (Maass, noncongruence), B (Hilbert, Bianchi, Siegel)

Automorphic forms on arithmetic groups acting on classical domains, done classically (slash operators, expansions, Hecke operators, newforms, L-functions in #248's data model); ModularForms stays separate. MaassFormsAndSpectralTheory: Laplacian on Γ\ℍ, Eisenstein series, K-Bessel functions, Hecke–Maass newforms, Selberg's spectral decomposition, λ₁ ≥ 3/16, Maass forms for PSL₂(ℤ[i]). HilbertModularForms: weight k ∈ ℤⁿ on ℍⁿ, Koecher, Hecke operators at primes, newforms, base change, CM. BianchiModularForms: weight 2 as cuspidal H¹ and harmonic forms on ℍ³, Hecke theory, signs, base change. SiegelModularForms: degree 2 in full, paramodular newforms, spinor L-functions, Saito–Kurokawa, Siegel theta. NoncongruenceModularForms: permutation pairs, Wohlfahrt, unbounded denominators stated. Half-integral weight is S12's, adelic theory U18/U19's, Hilbert modular varieties U12's.

- *Milestones:* Selberg decomposition and λ₁ ≥ 3/16 → Koecher → finite dimensionality → Hecke theory and newforms per kind → Eichler–Shimura–Harder → Saito–Kurokawa. *Prerequisites:* MF, FuchsianOrbifolds, #432, GNF, #248, #286, S2, S4, S12, U22, FAMP unbounded operators. *Goals:* LMFDB 7 sections (bmf, ecnf, g2c, hmf, maass, noncong, smf); Annals #13; 23 need rows.
- *Porting:* LMFDB and Booker–Strömbergsson–Then data as tests. *Replaces:* P12, P14, P15, P16, P23; Annals MaassFormsAndSpectralTheory. *Formalizability:* medium-high; inputs are the self-adjoint Laplacian and K-Bessel asymptotics.

**S12. MetaplecticFormsAndTheta** — math.NT · XL family (M 100 + L 180 + L 300 + L 300), ~880 PRs · wave A (subs 1-2), B (subs 3-4)

Theta functions and the metaplectic covers on which they live. FiniteQuadraticModulesAndWeilRepresentation: finite quadratic modules, Witt group, Milgram, the Weil representation of Mp₂(ℤ) on ℂ[A], vector-valued forms. HalfIntegralWeightModularForms: θ and η multipliers, Kohnen plus space, Shimura and Shintani lifts, Jacobi forms and J_{k,1} ≅ M⁺_{k−1/2}(4). WeilRepresentationAndThetaCorrespondence: metaplectic groups over local fields, Stone–von Neumann, dual pairs, theta lifts, Siegel–Weil, Siegel–Narain theta. HigherMetaplecticCoversAndGaussSums: Kubota's n-fold covers, metaplectic Eisenstein series, Patterson's cubic theta theorem, Heath-Brown–Patterson, the cubic large sieve, Kazhdan–Patterson. Lattice theta series of integral weight are #286's, power residue symbols S15's, quadratic large sieves U1's.

- *Milestones:* Milgram → Shimura lift → J_{k,1} isomorphism → Stone–von Neumann → Siegel–Weil → Patterson → Heath-Brown–Patterson. *Prerequisites:* #286, IL, MF, S13, S15, #432, #248, ALG SmoothRepresentations. *Goals:* LMFDB 3 sections (cmf, mf.half_integral, smf); OpenAI #003, #023, #029, #032; 10 need rows.
- *Porting:* OAI CubicMoment, CubicGauss, CubicGram, DirichletL (Apache-2.0, re-base on Tau Ceti carriers). *Replaces:* P17; OAI GaussSumsAndMetaplecticTheta; campaign MetaplecticAutomorphicForms; IL's FiniteQuadraticModuleWittTheory, IndefiniteThetaAndSiegelWeil. *Formalizability:* medium; n-fold covers rest on OAI's paper-shaped ℚ(ζ₃) development.

**S13. AdelicAlgebraicGroups** — math.NT · XL family (L 200 + L 200 + M 110 + L 220 + L 220), ~950 PRs · wave A (subs 1–3), B (subs 4–5: S5)

Algebraic groups over number fields and their adelic points through Tamagawa numbers and the mass formula, under the five names main reserves. AlgebraicGroupStrongApproximation: G(𝔸_F), weak and strong approximation, class numbers. ArithmeticReductionTheory: Siegel sets, Borel–Harish-Chandra, finite covolume, Godement. AdelicFourierAnalysis: Schwartz–Bruhat functions, adelic Poisson summation, Tate's zeta integrals and GL₁ local constants. TamagawaMeasures: gauge forms, convergence factors, Ono's formula, τ(SL_n) = 1 via Siegel's mean value theorem. OrthogonalTamagawaAndLatticeMass: strong approximation for Spin, τ(SO_Q) = 2, Eichler's cls⁺ = spn⁺, Smith–Minkowski–Siegel. Structure theory is ReductiveGroups', ℤ-models #447's, automorphic forms U18's.

- *Milestones:* strong approximation → Borel–Harish-Chandra → adelic Poisson → Tate local constants → Ono → τ(SL_n) = 1 → τ(SO_Q) = 2 → Smith–Minkowski–Siegel. *Prerequisites:* RestrictedProducts, GNF, ReductiveGroups, OSG, IL, #447, #248, S5 (subs 4–5 only), Mathlib Haar measure. *Goals:* LMFDB 1 section (lattice); Annals #4, #65; OpenAI #018, #092; 5 need rows.
- *Porting:* none; Platonov–Rapinchuk, Weil's Adeles as sources. *Replaces:* campaign AA.1–AA.5 (AA.0 duplicates RestrictedProducts), AL.0–AL.1; the five main-named successors. *Formalizability:* medium-high; gated by reductive groups over number fields.

### 3.3 Algebraic lane

**S14. FormalGroupsAndLubinTateTheory** — math.NT · L, ~200 PRs · wave A

Formal group laws over commutative rings, extending Mathlib's FormalGroup: homomorphisms, logarithms, height and the classification over separably closed fields, formal O-modules. Lubin–Tate theory: Lubin–Tate series, torsion points and K_{π,n}, Gal(K_π/K) ≅ O^×, the explicit local Artin map and its agreement with ClassFieldTheory's, local Kronecker–Weber. Lubin–Tate deformation theory and Coleman's norm operator. Elliptic formal groups are EllipticCurves', p-divisible groups AG's, Morava E-theory TOP's (it consumes the deformation layer), cyclotomic Iwasawa theory U37's.

- *Milestones:* logarithm → height classification → Lubin–Tate lemma → Gal(K_π/K) ≅ O^× → agreement with CFT → local Kronecker–Weber → Lubin–Tate deformation → Coleman power series. *Prerequisites:* Mathlib FormalGroup, LFR, CFT, LGG, ProfiniteArithmetic. *Goals:* OpenAI #309, #311, #313, #318; 4 need rows.
- *Replaces:* unowned prerequisite (CFT excludes it; coordination §3.2). *Formalizability:* high; power-series algebra on main and Mathlib.

**S15. PowerReciprocityLaws** — math.NT · L, ~200 PRs · wave A

The n-th power residue symbol of a number field containing μ_n, identified with ClassFieldTheory's degree-n Hilbert symbol, the general reciprocity law from the product formula, and the explicit laws as instances: Jacobi and Kronecker symbols, cubic, biquadratic and sextic reciprocity with supplements, Eisenstein reciprocity; Stickelberger and Weil's Jacobi-sum Hecke characters. Finite-field Gauss sums are S2's, Hecke characters GNF's, Artin–Hasse formulas S14's.

- *Milestones:* symbol = Hilbert symbol → general reciprocity → cubic, biquadratic, sextic laws with supplements → Eisenstein → Stickelberger → Jacobi-sum Hecke characters. *Prerequisites:* CFT, NFA, GNF, S2, Mathlib cyclotomic fields. *Goals:* OpenAI #003, #023, #029; 3 need rows.
- *Porting:* OAI CubicGauss, CubicGram (cross-check). *Replaces:* OAI PowerReciprocityLaws; CA.1; Kronecker symbol. *Formalizability:* high; one deep input, already on main.

**S16. BirationalAnabelianGeometry** — math.NT · L, ~220 PRs · wave A (local theory), B (Uchida: #451)

Fields reconstructed from Galois groups. Local theory: decomposition and inertia groups of valuations, valuations from commuting-liftable pairs in abelian-by-central pro-ℓ quotients, Neukirch's characterization of decomposition groups, the valuative birational p-adic section conjecture. Global theory: Neukirch–Uchida, Uchida's open-homomorphism theorem with Hoshi's criterion, Bogomolov–Pop in transcendence degree ≥ 2. Curves, sections and Mochizuki's theorem stay with U15: fields versus schemes.

- *Milestones:* valuations from commuting pairs → Neukirch characterization → Neukirch–Uchida → Uchida open homomorphisms → Bogomolov–Pop. *Prerequisites:* CFT, LGG, ProfiniteProPGroups, Chebotarev, AlgebraicCurves, #451, TOP K2SymbolsBrauer. *Goals:* OpenAI #009, #019, #031; 5 need rows.
- *Porting:* OAI Algebra/BogomolovPop (injectivity). *Replaces:* OAI BirationalAnabelianGeometry. *Formalizability:* medium-high; NSW XII plus complete OAI manuscripts.

### 3.4 Classical-analytic lane

**S17. MultiplicativeNumberTheory** — math.NT · XL family (L 250 + L 250 + L 200), ~700 PRs · wave A (subs 2-3), B (sub 1: #253)

Primes uniformly in the modulus, and multiplicative functions, from where ArithmeticDirichletSeries and #253 stop. PrimesInArithmeticProgressions: Landau–Page, Siegel, Deuring–Heilbronn, Siegel–Walfisz, Linnik, Brun–Titchmarsh, Stark's effective Brauer–Siegel, with conductor-uniform prime counts exported. MultiplicativeFunctionsInShortIntervals: Halász, pretentious distance, Shiu, Matomäki–Radziwiłł, MRT, Tao's two-point logarithmic Chowla. AnatomyOfIntegers: Mertens, Turán–Kubilius, Erdős–Kac, smooth numbers and Dickman ρ, the Poisson–Dirichlet law, totient fibers and Ford's V(x). Sieves and Bombieri–Vinogradov are U1's; the PD(θ) law is PRDS's.

- *Milestones:* Siegel–Walfisz → Linnik → Stark | Halász → Matomäki–Radziwiłł → two-point Chowla | Erdős–Kac → Dickman → Ford's V(x). *Prerequisites:* ADS, #253, #248, Chebotarev, U1 (SV.1–SV.3), Tau Ceti InformationTheory, PRDS StandardDistributions. *Goals:* OpenAI #003, #007, #011, #012, #013, #015, #021, #024, #025; 18 need rows.
- *Porting:* OAI SiegelZeros, Ostmann, Jacobsthal, DukePrimeDegree, TwoPoint, JointDickman, TotientAsymptotic; PNT+ (coordinate first). *Replaces:* OAI SiegelZeros…, MultiplicativeFunctions…, AnatomyOfIntegers; AN.2, AN.5; PM.0–PM.1. *Formalizability:* high; complete textbook sources and sorry-free OAI proofs.

### 3.5 Arithmetic-geometry lane

**S18. ArakelovGeometry** — math.NT · L, ~300 PRs · wave B (#287, AG IntersectionTheory)

Heights through hermitian and adelic metrics: hermitian bundles on Spec O_K, adelically metrized line bundles, heights of points and subvarieties, the height machine extending #287, canonical and Néron–Tate heights, arithmetic intersection on arithmetic surfaces and Deligne pairings, arithmetic positivity and Northcott, the stable Faltings height and its isogeny variation. It consumes AG's IntersectionTheory and positivity (rule 4); ℙⁿ heights are #287's, arithmetic surfaces StableReduction's, Faltings' theorems U14's.

- *Milestones:* height machine → canonical heights → arithmetic intersection on surfaces → Northcott for ample adelic bundles → stable Faltings height → isogeny estimate. *Prerequisites:* #287, EC L6, StableReduction L4, AG IntersectionTheory and Positivity, AG abelian schemes, GNF. *Goals:* LMFDB 2 sections (ec, g2c); Annals #24; OpenAI #004, #016; 5 need rows.
- *Replaces:* Annals ArakelovIntersectionTheory; campaign R35.1–R35.5, RP.0. *Formalizability:* medium; adelic metrics need care.

## 4. Needs not absorbed by the slate

Of the 64 math.NT `gap` rows, 56 land in S1–S18 (S1 18, S11 13, S6 5, S16 4, S17 4, S2, S5, S7, S9 2 each, S3, S4,
S12, S15 1 each). The other eight:

| Need | Disposition |
|---|---|
| Annals #19 relative trace formulas | **Add to U19**: symmetric pairs, relative orbital integrals, Jacquet–Rallis RTFs for U(n)×U(n+1) vs GL_n×GL_{n+1}, fundamental lemma stated, small rank proved |
| Annals #31 Arthur parameters | **Add to U19** (statements): parameters via twisted GL_N, φ_ψ, S_ψ, A-packets, multiplicity formula; tests SL₂/PGL₂ |
| LMFDB shimcurve models, gonality, points | AG's CanonicalModelsAndGonality; rational points and obstructions U14 |
| OAI#016 abelian Zilber–Pink | frontier; **add the statement** to U14 (RP.5) |
| OAI#020 squarefree values | **Add to U1**: Hooley/Erdős squarefree sieve, Ekedahl–Poonen |
| OAI#021 long prime gaps | **Add to U1**: Erdős–Rankin and Ford–Green–Konyagin–Maynard–Tao; positive proportion of large gaps (OAI#026) |
| OAI#029 (2 rows) | **Add to U1**: Hooley's conditional Artin theorem, Gupta–Murty/Heath-Brown; quadratic large sieves (Heath-Brown over ℚ, OAI#013; Goldmakher–Louvel over number fields) |

Also: Smith's 2^∞-Selmer distribution (OAI#002, #006) → add to U4; the Poisson–Dirichlet law (OAI#011) splits between
S17 and PRDS's StandardDistributions. Secondary-NT gaps owned elsewhere: Mumford–Tate groups, Hilbert modular surfaces →
AG; Malle constants, Gassmann triples → ALG; perfect forms, packing (OAI#092) → GEO; Bernoulli convolutions → PRDS;
Morava E-theory → TOP, consuming S14.

## 5. Cross-campaign interface

**Imports.** *AG:* abelian varieties over a base with duals, polarizations, Poincaré reducibility, Rosati, Albert (S2,
S3, S6, S8, S18, U12, U14); Néron models (S3, S8, U14); IntersectionTheory and PositivityOfLineBundles (S18); PR #196
étale cohomology (U10, U28); the p-adic lane: perfectoid spaces, diamonds, crystalline comparison, p-divisible groups
(U26, U27, U32, U33); Hodge theory and stacks (U12, U13); AG's LMFDB roadmaps (P10, P13, P19). *ALG:* SmoothRepresentationsOfLocalGroups (U18–U21, S12), ReductiveGroupsPartII (U12, U19),
ChevalleyGroups #447 (S13), FiniteGroupInvariants (S1, U4), DeformationAndDerivedPatchingAlgebra R03.1–R03.4 (U27).
*TOP:* K-theory (U9, U43, U44, S16), #432, #271 (S11, S12). *FAMP/ANA/GEO:* unbounded self-adjoint operators,
SCV for Koecher (S11), decoupling (U2), Hermitian domains (U12). *PRDS:* ergodic theory, homogeneous dynamics, PD(θ).
*LTCS/COMB:* o-minimality (U14), MRDP; AC.0–AC.3 (U1).

**Exports.** S14 Lubin–Tate deformation and height → TOP ChromaticHomotopyTheory, AG p-divisible groups; S13 reduction
theory and Siegel's mean value theorem → ALG LatticesInSemisimpleGroups, PRDS HomogeneousDynamics, GEO packing; S13 strong
approximation → ALG (OAI#018); S2 Weil bounds and point counts → COMB expanders and designs, LTCS codes, AG
WeilConjectures (curve case); S4 quaternion orders → COMB Ramanujan graphs, GT Kleinian groups; S18 heights → AG, U14;
PS.9 multiple zeta values (U42) → ALG GrothendieckTeichmuller.

**Boundary rulings assumed (for the hub registry):** Shimura varieties (U12, U13), p-adic Galois representations (U26)
and geometric Langlands (U33, U34) are math.NT; geometric comparison theorems (R06.5), abelian schemes and Néron models
are math.AG; the Riemann hypothesis for curves is proved once, in S2, and AG's WeilConjectures consumes it; adelic groups
and Tamagawa numbers (S13) are math.NT, not math.GR as MSC 20G suggests.

## 6. Order and people

**Merge first:** #286 → #248 → #253 (each imports the previous), then #287, #432, #226, #451. They gate 11 of the 18
slate items and units U3, U20.

**First five slate roadmaps to draft.**
1. **S13 AdelicAlgebraicGroups**: five names reserved by three main roadmaps; unblocks the lattice mass formula, Annals
   #4 and #65, OAI#018, U18–U21, S12's theta correspondence and U12. Wave A.
2. **S2 ArithmeticOfFiniteFields**: av.fq is an LMFDB section with no owner; its Weil and Kloosterman bounds feed S3,
   S9, S11 (λ₁ ≥ 3/16) and OAI#013. Wave A for two subs.
3. **S11 ClassicalAutomorphicForms**: largest demand (23 rows); Maass and noncongruence subs are wave A.
4. **S17 MultiplicativeNumberTheory**: 18 rows over nine OpenAI families and about a million lines of sorry-free OAI Lean
   to port; two subs are wave A.
5. **S1 LMFDBLabelsAndCompleteness**: 24 rows; its framework layer fixes the conventions the other LMFDB-lane roadmaps
   use, so it should be reviewed before S3–S10 are written.
Then S14 (unowned prerequisite, exports to TOP), S4, S7, S15, S18. **First campaign units:** U25, U7, U36, U1, U12
(ShimuraData first): distance 4–6, 40 demand rows, all suppliers of later units.

**Expertise.** A lead fluent in class field theory and automorphic forms; reviewers in analytic NT (S17, U1–U3),
automorphic forms (S11, S12, U18–U24), algebraic groups (S13), heights (S18, U14–U16), p-adic Galois representations and
Iwasawa theory (U26–U27, U36–U41). The owner-steered LMFDB lane needs LMFDB section editors as reviewers. Every campaign
promotion needs Chris Birkbeck's agreement to the consolidation and renaming (README "coordinate first").

**Open questions for the owner.**
1. Promote AbelianSchemesAndArithmeticModuli and NeronModelsAndSemistableAbelianVarieties early as AG roadmaps? S2 (sub 3),
   S3, S6, S8, S18, U12, U14 import them; otherwise S6 carries Poincaré/Rosati/Albert as Layer 0 and S3/S8 state Néron
   interfaces against stand-ins. Recommendation: yes, in AG's first wave.
2. Should the LMFDB lane own every LMFDB-facing roadmap regardless of arXiv class? This plan follows BOUNDARIES (P4 core,
   P10, P13, P19 → AG; P20 → ALG; P21 → GEO; P5 stays).
3. Accept the §5 boundary rulings, or send them to the hub `boundary` process with the AG lead.
4. Keep the main-reserved names as S13's sub-roadmaps (recommended: existing references stay valid).
5. Coordination §3.3 lists HabiroNumberFields under both NT and the AG Habiro cluster; this plan keeps the cluster in AG.
6. The explorer's focus (Caraiani–Newton) is promoted supplier-first; its endpoints (U30, U32) come last.
7. Label semantics: S1 assumes the mathematics is roadmap material and delivery is an LMFDB-side `tauceti=` link
   (lmfdb.md §0).

## 7. Totals

| | count | est. PRs |
|---|---|---|
| New standalone roadmaps | 13 (12 L, 1 M) | 2,910 |
| New umbrella families (XL) | 5 (20 subs: 15 L, 4 M, 1 L+) | 4,390 |
| **Slate** | **18 reviews, 33 READMEs** | **≈ 7,300** |
| Campaign promotion units | 44 (96 campaign roadmaps) | ≈ 16,100 (≈ 8,200 at 85 each) |
| Tau Ceti main, math.NT, remaining | 16 | ≈ 1,800 |
| Open math.NT PRs | 8 | ≈ 950 |
| **Territory** | | **≈ 26,000** |

At 35 PRs/week per active roadmap the slate keeps 33 roadmaps busy for six to seven weeks; the whole NT territory is
about a quarter of the ~100k PRs the credits buy.

## 8. References by roadmap

82 roadmap records, 686 listings, 553 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_NT.json` and the `references` fields of `slate_NT.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (179 of 553: zbMATH stopped early; see master (d)). A title is given at a work's first citation in this section only. Pointers are the compilers' and are unverified.

**Conventions and notes.** Promotion units U1–U44 list the sources their member campaign READMEs cite (README aliases such as KW2, CSnc, RJW decoded); theorem locators appear only where a README or a pinned Tau Ceti roadmap gives them. Units are listed in §2.3 order; their wave in `references_master` is the order tier (1 = A, 2 = B, 3 = C). Umbrellas carry the family-wide primaries. U27 shares five works with ALG's DeformationAndDerivedPatchingAlgebra promotion record (master (d8)).

**S1 LMFDBLabelsAndCompleteness** (wave A)
- primary: Cohen 1993, *Computational Algebraic Number Theory*
- conventions: LMFDB 2026, *L-functions and modular forms database…*; Jones–Roberts 2014, *Database of number fields*; Jones–Roberts 2006, *Database of local fields*; Best et al. 2021, *Computing classical modular forms*; Cremona 1997, *Algorithms for Modular Elliptic Curves*; Rouse et al. 2022, *l-adic images of Galois for elliptic…* (?)
- theorem: Pohst 1982, *Computation of number fields of small…*; Serre 1978, *Une "formule de masse" pour les…*; Krasner 1966, *Nombre des extensions d'un degré donné…*; Sturm 1987, *Congruence of modular forms*; Bach 1990, *Explicit bounds for primality testing…*
- formal: Tau Ceti `NumberTheory/NumberField/IntrinsicLabel`; Tau Ceti `NumberTheory/ModularForms/SturmBound`

**S2 ArithmeticOfFiniteFields** (umbrella, wave A)
- primary: Lidl–Niederreiter 1997, *Finite Fields*; Stichtenoth 2009, *Algebraic Function Fields and Codes*, Ch. V; Milne 2008, *Abelian Varieties*

**S2.1 CharacterSumsOverFiniteFields** (wave A)
- primary: Berndt–Evans–Williams 1998, *Gauss and Jacobi Sums*; Ireland–Rosen 1990, *Classical Introduction to Modern Number…*; Iwaniec–Kowalski 2004, *Analytic Number Theory*, Ch. 11; Lidl–Niederreiter 1997; Kowalski 2021, *Exponential sums over finite fields*
- theorem: Weil 1948, *Some exponential sums*; Bombieri 1973, *Counting points on curves over finite…*
- formal: Mathlib `NumberTheory/GaussSum`

**S2.2 CurvesOverFiniteFields** (wave A)
- primary: Stichtenoth 2009, Ch. V; Rosen 2002, *Number Theory in Function Fields*; Serre 2020, *Rational Points on Curves over Finite…*
- conventions: Dupuy et al. 2021, *Isogeny classes of abelian varieties…*
- theorem: Bombieri 1973; Serre 1983, *Sur le nombre des points rationnels…*; Ihara 1981, *Some remarks on the number of rational…*
- formal: Tau Ceti `AlgebraicGeometry/EllipticCurve/HasseBound`

**S2.3 AbelianVarietiesOverFiniteFields** (wave B)
- primary: Milne 2008; Mumford 1974, *Abelian Varieties*
- conventions: Dupuy et al. 2021
- theorem: Tate 1966, *Endomorphisms of abelian varieties over…*; Honda 1968, *Isogeny classes of abelian varieties…*; Chai–Conrad–Oort 2014, *Complex Multiplication and Lifting…* (?); Waterhouse 1969, *Abelian varieties over finite fields*; Waterhouse–Milne 1971, *Abelian varieties over finite fields*; Deligne 1969, *Variétés abéliennes ordinaires sur un…* (?); Centeleghe–Stix 2015, *Categories of abelian varieties over… I* (?); Marseglia 2021, *Computing square-free polarized abelian…* (?); Howe–Nart–Ritzenthaler 2009, *Jacobians in isogeny classes of abelian…* (?)

**S3 HyperellipticCurves** (wave A)
- primary: Cassels–Flynn 1996, *Prolegomena to a Middlebrow Arithmetic…*; Liu 2002, *Algebraic Geometry and Arithmetic Curves*
- conventions: Booker et al. 2016, *Database of genus-2 curves over the…*
- theorem: Igusa 1960, *Arithmetic variety of moduli for genus…*; Mestre 1991, *Construction de courbes de genre 2 à…*; Cardona–Quer 2005, *Field of moduli and field of definition…*; Liu 1994, *Modèles minimaux des courbes de genre…*; Liu 1994, *Conducteur et discriminant minimal de…*; Dokchitser et al. 2023, *Arithmetic of hyperelliptic curves over…*; Brumer–Kramer 1994, *Conductor of an abelian variety*; Stoll 2001, *Implementing 2-descent for Jacobians of…*; Poonen–Schaefer 1997, *Explicit descent for Jacobians of…*

**S4 QuaternionArithmetic** (wave A)
- primary: Voight 2021, *Quaternion Algebras*; Vignéras 1980, *Arithmétique des Algèbres de Quaternions*; Alsina–Bayer 2004, *Quaternion Orders, Quadratic Forms, and…*; Katok 1992, *Fuchsian Groups*
- theorem: Shimizu 1965, *Zeta functions of quaternion algebras*; Pizer 1980, *Algorithm for computing modular forms…*
- formal: Tau Ceti `Algebra/Quaternion`; Mathlib `Algebra/Quaternion`

**S5 ArtinRepresentations** (wave B)
- primary: Serre 1979, *Local Fields*, Ch. VI; Neukirch 1999, *Algebraic Number Theory*, Ch. VII; Martinet 1977, *Character theory and Artin L-functions* (?); Serre 1977, *Linear Representations of Finite Groups*
- conventions: Deligne 1973, *Les constantes des équations…*; Tate 1979, *Number theoretic background* (?)
- theorem: Tate 1977, *Local constants*; Rohrlich 1994, *Elliptic curves and the Weil-Deligne…* (?); Deligne–Serre 1974, *Formes modulaires de poids 1* (?); Langlands 1980, *Base Change for GL(2)*; Tunnell 1981, *Artin's conjecture for representations…*
- statement: Tate 1984, *Les Conjectures de Stark sur les…* (?)
- formal: Tau Ceti `NumberTheory/LocalField/Herbrand`

**S6 SatoTateGroups** (wave A)
- primary: Sutherland 2019, *Sato-Tate distributions*; Serre 2012, *N_X(p)*; Bump 2013, *Lie Groups*
- conventions: Fité et al. 2012, *Sato-Tate distributions and Galois…*
- theorem: Fité–Kedlaya–Sutherland 2023, *Sato-Tate groups of abelian threefolds*; Banaszak–Kedlaya 2015, *Algebraic Sato-Tate group and Sato-Tate…*; Serre 1968, *Abelian l-adic Representations and…*; Ribet 2004, *Abelian varieties over Q and modular…* (?); Mumford 1974

**S7 AdelicImagesAndModularCurves** (wave A)
- primary: Serre 1972, *Propriétés galoisiennes des points…*; Diamond–Shurman 2005, *Modular Forms*, Ch. 3; Shimura 1971, *Arithmetic Theory of Automorphic…*; Deligne–Rapoport 1973, *Les schémas de modules de courbes…*
- theorem: Dickson 1901, *Linear Groups with an Exposition of the…*; Rouse et al. 2022 (?); Rouse–Zureick-Brown 2015, *Elliptic curves over Q and 2-adic…* (?); Zywina 2015, *Possible images of the mod l…* (?); Sutherland 2016, *Computing images of Galois…*; Mazur 1977, *Modular curves and the Eisenstein ideal*; Mazur 1978, *Rational isogenies of prime degree*; Kenku 1982, *Number of Q-isomorphism classes of…*

**S8 EllipticCurvePeriodsAndModularParametrizations** (wave B)
- primary: Cremona 1997; Silverman 2009, *Arithmetic of Elliptic Curves*, Ch. VI (?); Diamond–Shurman 2005
- conventions: Tate 1966, *Conjectures of Birch and…* (?)
- theorem: Manin 1972, *Parabolic points and zeta functions of…* (?); Zagier 1985, *Modular parametrizations of elliptic…* (?); Edixhoven 1991, *Manin constants of modular elliptic…* (?); Agashe–Ribet–Stein 2006, *Manin constant* (?); Watkins 2002, *Computing the modular degree of an…* (?)
- statement: Stevens 1989, *Stickelberger elements and modular…* (?)

**S9 HypergeometricMotives** (wave B)
- primary: Beukers–Heckman 1989, *Monodromy for the hypergeometric…*; Katz 1990, *Exponential Sums and Differential…* (?)
- conventions: Roberts–Rodriguez Villegas 2022, *Hypergeometric motives*; LMFDB 2026
- theorem: Levelt 1961, *Hypergeometric Functions* (?); Greene 1987, *Hypergeometric functions over finite…*; Beukers–Cohen–Mellit 2015, *Finite hypergeometric functions*; Corti–Golyshev 2011, *Hypergeometric equations and weighted…* (?); Fedorov 2018, *Variations of Hodge structures for…* (?); Berndt–Evans–Williams 1998

**S10 PadicExtensionFamilies** (wave A)
- primary: Serre 1979, Ch. I and IV
- conventions: Jones–Roberts 2006
- theorem: Ore 1928, *Newtonsche Polygone in der Theorie der…*; Guàrdia–Montes–Nart 2012, *Newton polygons of higher order in…*; Greve–Pauli 2012, *Ramification polygons, splitting…*; Heiermann 1996, *De nouveaux invariants numériques pour…*; Keating 2015, *Indices of inseparability in towers of…*; Krasner 1966; Serre 1978; Pauli–Sinclair 2017, *Enumerating extensions of (π)-adic…*; Monge 2014, *Family of Eisenstein polynomials…*
- formal: Tau Ceti `NumberTheory/LocalField/Eisenstein`; Mathlib `Analysis/Normed/Field/Krasner`

**S11 ClassicalAutomorphicForms** (umbrella, wave A)
- primary: Bump 1997, *Automorphic Forms and Representations*; Miyake 1989, *Modular Forms*; Shimura 1971

**S11.1 MaassFormsAndSpectralTheory** (wave A)
- primary: Iwaniec 2002, *Spectral Methods of Automorphic Forms*; Bump 1997; Hejhal 1983, *Selberg Trace Formula for PSL(2,R)…* (?); Elstrodt–Grunewald–Mennicke 1998, *Groups Acting on Hyperbolic Space*
- conventions: Booker et al. 2006, *Effective computation of Maass cusp…*
- theorem: Selberg 1965, *Estimation of Fourier coefficients of…*; Weil 1948; Booker–Strömbergsson–Then 2013, *Bounds and algorithms for the K-Bessel…*

**S11.2 HilbertModularForms** (wave B)
- primary: Freitag 1990, *Hilbert Modular Forms* (?); Garrett 1990, *Holomorphic Hilbert Modular Forms* (?); van der Geer 1988, *Hilbert Modular Surfaces* (?)
- conventions: Dembélé–Voight 2013, *Explicit methods for Hilbert modular…* (?)
- theorem: Shimura 1978, *Special values of the zeta functions…* (?)
- statement: Jacquet–Langlands 1970, *Automorphic Forms on GL(2)*; Langlands 1980

**S11.3 BianchiModularForms** (wave B)
- primary: Elstrodt–Grunewald–Mennicke 1998; Cremona 1984, *Hyperbolic tessellations, modular…* (?); Şengün 2014, *Arithmetic aspects of Bianchi groups* (?)
- theorem: Harder 1987, *Eisenstein cohomology of arithmetic…* (?)

**S11.4 SiegelModularForms** (wave B)
- primary: van der Geer 2008, *Siegel modular forms and their…*; Freitag 1983, *Siegelsche Modulfunktionen* (?); Klingen 1990, *Siegel Modular Forms* (?)
- theorem: Igusa 1962, *Siegel modular forms of genus two* (?); Andrianov 1974, *Euler products corresponding to Siegel…* (?); Roberts–Schmidt 2007, *Local Newforms for GSp(4)* (?); Eichler–Zagier 1985, *Theory of Jacobi Forms*; Maass 1979, *Über eine Spezialschar von Modulformen…* (?); Poor–Yuen 2015, *Paramodular cusp forms* (?)
- statement: Brumer–Kramer 2014, *Paramodular abelian varieties of odd…* (?)

**S11.5 NoncongruenceModularForms** (wave A)
- primary: Diamond–Shurman 2005
- theorem: Wohlfahrt 1964, *Extension of F. Klein's level concept*; Hsu 1996, *Identifying congruence subgroups of the…*
- statement: Atkin–Swinnerton-Dyer 1971, *Modular forms on noncongruence subgroups*; Calegari–Dimitrov–Tang 2024, *Unbounded denominators conjecture*
- formal: Mathlib `NumberTheory/ModularForms`

**S12 MetaplecticFormsAndTheta** (umbrella, wave A)
- primary: Bump 1997; Gelbart 1976, *Weil's Representation and the Spectrum…*

**S12.1 FiniteQuadraticModulesAndWeilRepresentation** (wave A)
- primary: Milnor–Husemoller 1973, *Symmetric Bilinear Forms*; Nikulin 1979, *Integral symmetric bilinear forms and…*
- conventions: Bruinier 2002, *Borcherds Products on O(2,l) and Chern…*
- theorem: Wall 1963, *Quadratic forms on finite groups, and…*; Scheithauer 2009, *Weil representation of SL2(Z) and some…* (?); Strömberg 2013, *Weil representations associated with…*

**S12.2 HalfIntegralWeightModularForms** (wave A)
- primary: Koblitz 1993, *Elliptic Curves and Modular Forms*, Ch. IV; Iwaniec 1997, *Classical Automorphic Forms*
- theorem: Shimura 1973, *Modular forms of half integral weight*; Kohnen 1980, *Modular forms of half-integral weight…*; Niwa 1975, *Modular forms of half integral weight…*; Shintani 1975, *Construction of holomorphic cusp forms…*; Serre–Stark 1977, *Modular forms of weight 1/2*; Eichler–Zagier 1985
- statement: Waldspurger 1981, *Sur les coefficients de Fourier des…*; Kohnen–Zagier 1981, *Values of L-series of modular forms at…*

**S12.3 WeilRepresentationAndThetaCorrespondence** (wave B)
- primary: Weil 1964, *Sur certains groupes d'opérateurs…* (?); Mœglin–Vignéras–Waldspurger 1987, *Correspondances de Howe sur un Corps…* (?); Kudla 1996, *Local theta correspondence*
- theorem: Ranga Rao 1993, *Some explicit formulas in the theory of…* (?); Kudla–Rallis 1988, *Weil-Siegel formula* (?); Bruinier 2002

**S12.4 HigherMetaplecticCoversAndGaussSums** (wave B)
- primary: Kubota 1969, *Automorphic Functions and the…* (?); Kazhdan–Patterson 1984, *Metaplectic forms* (?)
- theorem: Patterson 1977, *Cubic analogue of the theta series I, II* (?); Heath-Brown–Patterson 1979, *Distribution of Kummer sums at prime…* (?); Heath-Brown 2000, *Kummer's conjecture for cubic Gauss sums* (?)
- statement: OpenAI 2026, *An-unconditional-first-moment-for-cubic…* (OAI#023)
- formal: OAI `NumberTheory/CubicMoment`

**S13 AdelicAlgebraicGroups** (umbrella, wave A)
- primary: Platonov–Rapinchuk 1994, *Algebraic Groups and Number Theory*; Weil 1982, *Adeles and Algebraic Groups*; Borel 1969, *Introduction aux Groupes Arithmétiques*

**S13.1 AlgebraicGroupStrongApproximation** (wave A)
- primary: Platonov–Rapinchuk 1994, Ch. 7; Conrad 2012, *Weil and Grothendieck approaches to…*
- theorem: Kneser 1966, *Strong approximation*; Rapinchuk 2014, *Strong approximation for algebraic…*
- formal: Tau Ceti `Topology/Algebra/RestrictedProduct`

**S13.2 ArithmeticReductionTheory** (wave A)
- primary: Borel 1969; Platonov–Rapinchuk 1994
- theorem: Borel–Harish-Chandra 1962, *Arithmetic subgroups of algebraic groups*

**S13.3 AdelicFourierAnalysis** (wave A)
- primary: Tate 1967, *Fourier analysis in number fields and…*; Ramakrishnan–Valenza 1999, *Fourier Analysis on Number Fields*; Weil 1974, *Basic Number Theory*; Kudla 2004, *Tate's thesis*
- conventions: Tate 1977

**S13.4 TamagawaMeasures** (wave B)
- primary: Weil 1982; Platonov–Rapinchuk 1994
- theorem: Ono 1963, *Tamagawa number of algebraic tori* (?); Ono 1965, *Relative theory of Tamagawa numbers* (?); Siegel 1945, *Mean value theorem in geometry of…* (?); Langlands 1966, *Volume of the fundamental domain for…* (?)
- statement: Kottwitz 1988, *Tamagawa numbers* (?)

**S13.5 OrthogonalTamagawaAndLatticeMass** (wave B)
- primary: O'Meara 1963, *Quadratic Forms*; Kneser 2002, *Quadratische Formen (revised with R…* (?); Kitaoka 1993, *Arithmetic of Quadratic Forms* (?)
- conventions: Gan–Yu 2000, *Group schemes and local densities*, Thm 7.3 (?)
- theorem: Siegel 1935, *Über die analytische Theorie der…* (?); Mars 1969, *Les nombres de Tamagawa de certains…* (?); Weil 1982; Cho 2015, *Group schemes and local densities of…*, Thm 5.2 (?); Conway–Sloane 1988, *Low-dimensional lattices IV*; Conway–Sloane 1999, *Sphere Packings, Lattices and Groups*, Ch. 16

**S14 FormalGroupsAndLubinTateTheory** (wave A)
- primary: Hazewinkel 1978, *Formal Groups and Applications*; Milne 2020, *Class Field Theory*, Ch. I; Cassels–Fröhlich 1967, *Algebraic Number Theory*; Neukirch 1999, Ch. V
- conventions: Serre 1979
- theorem: Lubin–Tate 1965, *Formal complex multiplication in local…*; Lubin–Tate 1966, *Formal moduli for one-parameter formal…*; Lazard 1955, *Sur les groupes de Lie formels à un…*; Coleman 1979, *Division values in local fields*; de Shalit 1987, *Iwasawa Theory of Elliptic Curves with…*, Ch. I; Iwasawa 1986, *Local Class Field Theory*
- formal: Mathlib `RingTheory/FormalGroup/Basic`; Tau Ceti `AlgebraicGeometry/EllipticCurve/FormalGroup`

**S15 PowerReciprocityLaws** (wave A)
- primary: Lemmermeyer 2000, *Reciprocity Laws*; Ireland–Rosen 1990; Neukirch 1999
- conventions: Serre 1979
- theorem: Artin–Tate 2009, *Class Field Theory*, Ch. XII; Washington 1997, *Cyclotomic Fields*; Weil 1952, *Jacobi sums as "Grössencharaktere"*
- formal: Tau Ceti `NumberTheory/HilbertSymbol`; OAI `NumberTheory/CubicMoment`

**S16 BirationalAnabelianGeometry** (wave A)
- primary: Neukirch–Schmidt–Wingberg 2008, *Cohomology of Number Fields*, Ch. XII; Engler–Prestel 2005, *Valued Fields*
- theorem: Neukirch 1969, *Kennzeichnung der p-adischen und der…*; Uchida 1976, *Isomorphisms of Galois groups*; Uchida 1977, *Isomorphisms of Galois groups of…*; Engler–Koenigsmann 1998, *Abelian subgroups of pro-p Galois groups*; Topaz 2017, *Commuting-liftable subgroups of Galois… II*; Bogomolov–Tschinkel 2008, *Reconstruction of function fields*; Pop 2012, *Birational anabelian program initiated… I*; Pop–Stix 2017, *Arithmetic in the fundamental group of…*; OpenAI 2026, *Reconstruction-of-Function-Fields-from-M…* (OAI#009); OpenAI 2026, *The-p-adic-section-conjecture-September…* (OAI#019); OpenAI 2026, *Open-Homomorphisms-of-Global-Solvably-Cl…* (OAI#031)
- formal: OAI `Algebra/BogomolovPop`

**S17 MultiplicativeNumberTheory** (umbrella, wave A)
- primary: Davenport 2000, *Multiplicative Number Theory*; Montgomery–Vaughan 2007, *Multiplicative Number Theory I…*; Iwaniec–Kowalski 2004; Tenenbaum 2015, *Analytic and Probabilistic Number Theory*; Koukoulopoulos 2019, *Distribution of Prime Numbers*

**S17.1 PrimesInArithmeticProgressions** (wave B)
- primary: Davenport 2000; Montgomery–Vaughan 2007; Koukoulopoulos 2019
- theorem: Heath-Brown 1992, *Zero-free regions for Dirichlet…* (?); Montgomery–Vaughan 1973, *Large sieve* (?); Stark 1974, *Some effective cases of the…* (?); Lagarias–Odlyzko 1977, *Effective versions of the Chebotarev…* (?)
- statement: OpenAI 2026, *Uniform-exclusion-of-Landau-Siegel-zeros…* (OAI#003)
- formal: OAI `NumberTheory/SiegelZeros`; `AlexKontorovich/PrimeNumberTheoremAnd`

**S17.2 MultiplicativeFunctionsInShortIntervals** (wave A)
- primary: Koukoulopoulos 2019; Tenenbaum 2015
- theorem: Halász 1968, *Über die Mittelwerte multiplikativer…*; Shiu 1980, *Brun-Titchmarsh theorem for…*; Matomäki–Radziwiłł 2016, *Multiplicative functions in short…*; Matomäki–Radziwiłł–Tao 2015, *Averaged form of Chowla's conjecture*; Tao 2016, *Logarithmically averaged Chowla and…*
- statement: OpenAI 2026, *Ordinary-two-point-correlations-of-multi…* (OAI#007)
- formal: OAI `NumberTheory/SiegelZeros`

**S17.3 AnatomyOfIntegers** (wave A)
- primary: Tenenbaum 2015; Koukoulopoulos 2019
- theorem: Hardy–Ramanujan 1917, *Normal number of prime factors of a…*; Erdős–Kac 1940, *Gaussian law of errors in the theory of…*; Erdős–Wintner 1939, *Additive arithmetical functions and…*; Selberg 1954, *Note on a paper by L. G. Sathe*; Hildebrand 1986, *Number of positive integers <= x and…*; Hildebrand–Tenenbaum 1993, *Integers without large prime factors*; Billingsley 1972, *Distribution of large prime divisors*; Ford 1998, *Distribution of totients*
- formal: OAI `NumberTheory/SiegelZeros`; Mathlib `NumberTheory/SelbergSieve`; `AlexKontorovich/PrimeNumberTheoremAnd`

**S18 ArakelovGeometry** (wave B)
- primary: Bombieri–Gubler 2006, *Heights in Diophantine Geometry*; Moriwaki 2014, *Arakelov Geometry* (?); Soulé et al. 1992, *Arakelov Geometry* (?)
- conventions: Deligne 1985, *Preuve des conjectures de Tate et…* (?)
- theorem: Faltings 1984, *Calculus on arithmetic surfaces* (?); Gillet–Soulé 1990, *Arithmetic intersection theory* (?); Zhang 1995, *Small points and adelic metrics* (?); Zhang 1995, *Positive line bundles on arithmetic…* (?); Call–Silverman 1993, *Canonical heights on varieties with…* (?); Deligne 1987, *Le déterminant de la cohomologie* (?); Faltings 1983, *Endlichkeitssätze für abelsche…*; Raynaud 1985, *Hauteurs et isogénies* (?); Pazuki 2012, *Theta height and Faltings height* (?)
- formal: ArithmeticHeights roadmap and its Lean…

**SieveMethodsAndPrimePatterns** (unit, order ?)
- primary: Kedlaya 2025, *Analytic number theory*, Chs. 11-18; Tao–Vu 2006, *Additive Combinatorics*
- theorem: Maynard 2015, *Small gaps between primes*, Chs. 20-21; Green–Tao 2008, *Primes contain arbitrarily long…*; Green–Tao 2010, *Linear equations in primes*; Green–Tao 2012, *Möbius function is strongly orthogonal…*; Green–Tao–Ziegler 2012, *Inverse theorem for the Gowers…*; Hooley 1967, *Artin's conjecture*; Heath-Brown 1986, *Artin's conjecture for primitive roots*; Heath-Brown 1995, *Mean value estimate for real character…*; Ford et al. 2018, *Long gaps between primes*; Poonen 2003, *Squarefree values of multivariable…*
- formal: Mathlib `NumberTheory/SelbergSieve`

**ExponentialSumsAndCircleMethod** (unit, order ?)
- primary: Vaughan 1997, *Hardy-Littlewood Method*; Kedlaya 2025
- theorem: Bourgain–Demeter–Guth 2016, *Proof of the main conjecture in…*

**DiophantineApproximationAndTranscendence** (unit, order ?)
- primary: Waldschmidt 2000, *Diophantine Approximation on Linear…*; Schmidt 1980, *Diophantine Approximation* (?); Kubilius 1964, *Probabilistic Methods in the Theory of…* (?); Kuipers–Niederreiter 1974, *Uniform Distribution of Sequences* (?); Bombieri–Gubler 2006; Baker 1975, *Transcendental Number Theory* (?)
- theorem: Roth 1955, *Rational approximations to algebraic…* (?); Koukoulopoulos–Maynard 2020, *Duffin-Schaeffer conjecture*

**ArithmeticStatistics** (unit, order ?)
- theorem: Bhargava–Shankar 2015, *Ternary cubic forms having bounded…*; Bhargava–Shankar 2015, *Binary quartic forms having bounded…*; Davenport–Heilbronn 1971, *Density of discriminants of cubic… II* (?); Bhargava 2005, *Density of discriminants of quartic…* (?); Smith 2023, *Distribution of l^infinity-Selmer… II*
- statement: Cohen–Lenstra 1984, *Heuristics on class groups of number…* (?)

**CertifiedArithmeticComputation** (unit, order ?)
- primary: Shoup 2009, *Computational Introduction to Number…*; Cohen 1993; de Weger 1989, *Algorithms for Diophantine Equations*
- theorem: Tzanakis–de Weger 1989, *Practical solution of the Thue equation*; Balakrishnan et al. 2023, *Quadratic Chabauty for modular curves*

**ClassicalArithmeticCompletion** (unit, order ?)
- primary: Shoup 2009; Kedlaya 2021, *Class field theory* (?); Smyth 2008, *Mahler measure of algebraic numbers*; Fröhlich 1983, *Galois Module Structure of Algebraic…*
- theorem: Dobrowolski 1979, *Question of Lehmer and the number of…*

**ArithmeticGaloisDuality** (unit, order ?)
- primary: Neukirch–Schmidt–Wingberg 2008; Milne 2006, *Arithmetic Duality Theorems*; Rodrigues Jacinto–Williams 2023, *P-adic L-functions*, Sec. 10.5; Rubin 2000, *Euler Systems*
- theorem: Khare–Wintenberger 2009, *Serre's modularity conjecture (II)*; Mazur 1989, *Deforming Galois representations*; Greenberg 1989, *Iwasawa theory for p-adic…*; Bloch–Kato 1990, *L-functions and Tamagawa numbers of…*

**FunctionFieldArithmetic** (unit, order ?)
- primary: Rosen 2002, Chs. 5-9 and 12; Weil 1974; Tate 1967; Drinfeld 1974, *Elliptic modules*
- theorem: Anderson 1986, *t-motives*; Pink 2013, *Compactification of Drinfeld modular…*; Taguchi 1995, *Tate conjecture for t-motives* (?); Taelman 2012, *Special L-values of Drinfeld modules*; Papanikolas 2008, *Tannakian duality for Anderson-Drinfeld…*

**HigherLocalFieldsAndHigherClassFieldTheory** (unit, order ?)
- primary: Fesenko–Kurihara 2000, *Invitation to Higher Local Fields*
- theorem: Kato 2000, *Existence theorem for higher local…*

**InverseGaloisAndArithmeticFundamentalGroups** (unit, order ?)
- primary: Grothendieck–Raynaud 1971, *Revêtements étales et groupe…*; Serre 2008, *Galois Theory* (?); Malle–Matzat 2018, *Inverse Galois Theory*

**ModularCurvesPartII** (unit, order ?)
- primary: Katz–Mazur 1985, *Arithmetic Moduli of Elliptic Curves*; Deligne–Rapoport 1973; Shimura 1971; Loeffler 2014, *Modular Curves* (?)
- theorem: Serre 1956, *Géométrie algébrique et géométrie…*; Conrad 2007, *Arithmetic moduli of generalized…*; Česnavičius 2017, *Modular description of X_0(n)*; Deligne 1969, *Formes modulaires et représentations…*; Ribet 1990, *Modular representations of Gal(Qbar/Q)…*; Diamond 1997, *Taylor-Wiles construction and…*
- formal: `CBirkbeck/AINTLIB`

**ShimuraVarieties** (unit, order ?)
- primary: Deligne 1979, *Variétés de Shimura*; Milne 2005, *Shimura varieties*, Secs. 1-5; Lan 2013, *Arithmetic Compactifications of…*, Chs. 1-2; Faltings–Chai 1990, *Degeneration of Abelian Varieties*
- theorem: Deligne 1971, *Travaux de Shimura*; Milne 1983, *Action of an automorphism of C on a…*; Milne 1999, *Descent for Shimura varieties*; Baily–Borel 1966, *Compactification of arithmetic…*; Borel 1972, *Some metric properties of arithmetic…*; Carayol 1986, *Sur la mauvaise réduction des courbes…*; Boutot–Carayol 1991, *Uniformisation p-adique des courbes de…*; Rapoport 1978, *Compactifications de l'espace de…*; Saito 2009, *Hilbert modular forms and p-adic Hodge…*; Birkbeck–Heuer–Williams 2023, *Overconvergent Hilbert modular forms…*, Secs. 5

**ShimuraCompactificationsAndAutomorphicBundles** (unit, order ?)
- primary: Ash et al. 2010, *Smooth Compactifications of Locally…* (?); Pink 1990, *Arithmetical Compactification of Mixed…*; Faltings–Chai 1990; Lan 2013; Milne 1990, *Canonical models of (mixed) Shimura…*
- theorem: Harris 1985, *Arithmetic vector bundles and… I* (?)

**FaltingsFinitenessAndRationalPoints** (unit, order ?)
- primary: Faltings–Chai 1990; Poonen 2017, *Rational Points on Varieties*, Secs. 5.7, Ch. 8, Sec. 9.5 (?); Milne 2006
- theorem: Faltings 1983; Zarhin 1985, *Finiteness theorem for unpolarized…* (?); Zhang 1998, *Equidistribution of small points on…* (?); Ullmo 1998, *Positivité et discrétion des points…*
- statement: Pila 2022, *Point-Counting and the Zilber-Pink…*; OpenAI 2026, *The-Abelian-Zilber-Pink-Conjecture-Septe…* (OAI#016)

**AnabelianGeometryAndNonabelianChabauty** (unit, order ?)
- theorem: Mochizuki 1996, *Profinite Grothendieck conjecture for…* (?); Kim 2009, *Unipotent Albanese map and Selmer…*; Balakrishnan–Dogra 2018, *Quadratic Chabauty and rational points I*; Balakrishnan–Dogra 2021, *Quadratic Chabauty and rational points… II*

**ComplexMultiplicationAndExplicitReciprocity** (unit, order ?)
- primary: Milne 2020, *Complex Multiplication*, Secs. 1-4 (?); Silverman 1994, *Advanced Topics in the Arithmetic of…*, Ch. II
- theorem: Milne 2007, *Fundamental theorem of complex…*

**ArithmeticDynamics** (unit, order ?)
- primary: Silverman 2007, *Arithmetic of Dynamical Systems* (?); Silverman 2012, *Moduli Spaces and Arithmetic Dynamics* (?)
- theorem: Call–Silverman 1993, Thm 1.1, Prop. 1.2, Cor. 1.1.1 (?)

**AutomorphicFormsAndSpectralDecomposition** (unit, order ?)
- primary: Borel–Jacquet 1979, *Automorphic forms and automorphic…* (?); Langlands 1979, *Notion of an automorphic representation* (?); Arthur 2005, *Trace formula*, Secs. 1-23; Mœglin–Waldspurger 1995, *Spectral Decomposition and Eisenstein…* (?)
- theorem: Franke 1998, *Harmonic analysis in weighted L2-spaces*, Secs. 1-2 (?); Bernstein–Krötz 2014, *Smooth Fréchet globalizations of…*, Thm 1.1 (?); Borel–Wallach 2000, *Continuous Cohomology, Discrete…* (?); Arthur 1978, *Trace formula for reductive groups I* (?); Langlands 1976, *Functional Equations Satisfied by…* (?)

**TraceFormulasAndEndoscopy** (unit, order ?)
- primary: Harris–Taylor 2001, *Geometry and Cohomology of Some Simple…* (?)
- theorem: Caraiani–Scholze 2024, *Generic part of the cohomology of…*, Sec. 5; Shin 2011, *Galois representations arising from…* (?); Shin 2009, *Counting points on Igusa varieties* (?); Ngô 2010, *Le lemme fondamental pour les algèbres…* (?); Langlands–Shelstad 1987, *Definition of transfer factors*, Secs. 3-6 (?); Kottwitz–Shelstad 1999, *Foundations of twisted endoscopy* (?); Waldspurger 1997, *Le lemme fondamental implique le…* (?); Scholze 2013, *Local Langlands correspondence for GL_n…* (?); Jacquet–Rallis 2011, *Gross-Prasad conjecture for unitary…* (?)
- statement: Arthur 2013, *Endoscopic Classification of…* (?); Mok 2015, *Endoscopic classification of…*

**AutomorphicLFunctions** (unit, order ?)
- primary: Tate 1967; Godement–Jacquet 1972, *Zeta Functions of Simple Algebras* (?)
- theorem: Jacquet et al. 1983, *Rankin-Selberg convolutions* (?); Jacquet 2009, *Archimedean Rankin-Selberg integrals* (?)
- statement: Selberg 1992, *Old and new conjectures and results…* (?)

**GL2AutomorphicRepresentationsAndTransfer** (unit, order ?)
- primary: Jacquet–Langlands 1970; Bushnell–Henniart 2006, *Local Langlands Conjecture for GL(2)* (?)
- theorem: Langlands 1980; Arthur–Clozel 1989, *Simple Algebras, Base Change, and the…*; Tunnell 1981; Rohrlich–Tunnell 1997, *Elementary case of Serre's conjecture*; Wiese 2004, *Dihedral Galois representations and…*

**ArithmeticLocallySymmetricSpaces** (unit, order ?)
- primary: Borel–Serre 1973, *Corners and arithmetic groups*, Secs. 4-11 (?)
- theorem: Allen et al. 2023, *Potential automorphy over CM fields*, Secs. 2.1-2.4; Franke 1998 (?)

**PadicFamiliesOfAutomorphicForms** (unit, order ?)
- primary: Hida 1993, *Elementary Theory of L-functions and…* (?); Bellaïche 2021, *Eigenbook* (?); Rodrigues Jacinto–Williams 2023
- theorem: Hida 1986, *Galois representations into…* (?); Coleman 1997, *p-adic Banach spaces and families of…*; Coleman–Mazur 1998, *Eigencurve* (?); Buzzard 2007, *Eigenvarieties* (?); Pollack–Stevens 2011, *Overconvergent modular symbols and…*; Birkbeck–Heuer–Williams 2023, Secs. 3-4; Andreatta–Iovita–Pilloni 2016, *Overconvergent Hilbert modular cusp…* (?); Hida 2005, *p-adic automorphic forms on reductive…*, Secs. 2 (?); Boxer–Pilloni 2021, *Higher Coleman theory*

**QSeriesPartitionsAndMockModularForms** (unit, order ?)
- primary: Zwegers 2002, *Mock Theta Functions*; Andrews 1976, *Theory of Partitions* (?)
- theorem: Rademacher 1937, *Partition function p(n)* (?); Bruinier–Funke 2004, *Two geometric theta lifts*; Frenkel–Lepowsky–Meurman 1988, *Vertex Operator Algebras and the Monster* (?); Borcherds 1992, *Monstrous moonshine and monstrous Lie…*

**ArithmeticGaloisRepresentations** (unit, order ?)
- conventions: Deligne 1973
- theorem: Serre 1987, *Sur les représentations modulaires de…*; Khare–Wintenberger 2009, *Serre's modularity conjecture (I)*; Khare–Wintenberger 2009

**PadicGaloisRepresentations** (unit, order ?)
- primary: Fontaine 1994, *Le corps des périodes p-adiques* (?)
- conventions: Lei–Loeffler–Zerbes 2011, *Coleman maps and the p-adic regulator*
- theorem: Fontaine–Laffaille 1982, *Construction de représentations…*, Sec. 0.9, Thm 8.4; Kisin 2008, *Potentially semi-stable deformation…*; Saito 2009; Kedlaya 2004, *P-adic local monodromy theorem*; Fontaine 1990, *Représentations p-adiques des corps… I* (?); Cherbonnier–Colmez 1998, *Représentations p-adiques…* (?); Herr 1998, *Sur la cohomologie galoisienne des…* (?); Berger 2004, *Limites de représentations cristallines*; Kedlaya–Pottharst–Xiao 2014, *Cohomology of arithmetic families of…*

**GaloisDeformationTheory** (unit, order ?)
- primary: Mazur 1989
- theorem: Khare–Wintenberger 2009; Kisin 2008; Kisin 2009, *Moduli of finite flat group schemes and…*; Kisin 2009, *Modularity of 2-adic Barsotti-Tate…*; Savitt 2005, *Conjecture of Conrad, Diamond, and…*; Diamond 1997; Calegari–Geraghty 2018, *Modularity lifting beyond the…*; Fontaine–Laffaille 1982; Liu 2013, *Correspondence between Barsotti-Tate…*; Allen et al. 2023

**GaloisRepresentationsOfModularForms** (unit, order ?)
- primary: Katz 1973, *p-adic properties of modular schemes…*
- theorem: Deligne 1969; Deligne–Serre 1974 (?); Carayol 1986, *Sur les représentations l-adiques…*; Saito 2009; Khare–Wintenberger 2009; Chenevier 2014, *P-adic analytic space of…*; Scholze 2015, *Torsion in the cohomology of locally…*, Secs. 4.3; Allen et al. 2023, Secs. 2.3-2.4; Dasgupta et al. 2023, *Residually indistinguishable case of…* (?); Serre 1987; Edixhoven 1992, *Weight in Serre's conjectures on…*

**ModularityLiftingOverQ** (unit, order ?)
- theorem: Kisin 2009; Kisin 2009, *Fontaine-Mazur conjecture for GL_2* (?); Diamond 1997; Khare–Wintenberger 2009; Hida 1986 (?); Skinner–Wiles 2001, *Nearly ordinary deformations of…*; Ribet 1990; Diamond 1995, *Refined conjecture of Serre* (?); Taylor 2002, *Remarks on a conjecture of Fontaine and…*; Moret-Bailly 1989, *Groupes de Picard et problèmes de… II* (?); Gee 2011, *Automorphic lifts of prescribed types*; Pan 2022, *Fontaine-Mazur conjecture in the…*; Dieulefait–Pacetti 2023, *Simplified proof of Serre's conjecture*; Emerton 2011, *Local-global compatibility in the…* (?)

**SerreModularityAndEllipticCurveModularity** (unit, order ?)
- theorem: Khare 2006, *Serre's modularity conjecture*; Khare–Wintenberger 2009; Tate 1994, *Non-existence of certain Galois…*; Fontaine 1985, *Il n'y a pas de variété abélienne sur Z*; Schoof 2005, *Abelian varieties over Q with bad…*; Rosser–Schoenfeld 1962, *Approximate formulas for some functions…* (?); Dieulefait–Pacetti 2023; Rohrlich–Tunnell 1997; Kisin 2009; Faltings 1983; Shimura 1971
- statement: Serre 1987

**CompletedCohomologyAndPadicLocalLanglands** (unit, order ?)
- primary: Calegari–Emerton 2012, *Completed cohomology - a survey* (?)
- theorem: Emerton 2011 (?); Emerton 2006, *Interpolation of systems of eigenvalues…* (?); Scholze 2015, Sec. 4.2; Colmez 2010, *Représentations de GL_2(Q_p) et…* (?); Paškūnas 2015, *Breuil-Mézard conjecture*; Paškūnas 2016, *2-dimensional 2-adic Galois…*; Hu–Tan 2015, *Breuil-Mézard conjecture for non-scalar…* (?); Tung 2021, *Automorphy of 2-dimensional potentially…*

**HigherRankGaloisRepresentationsAndPotentialAutomorphy** (unit, order ?)
- theorem: Shin 2011, Secs. 5-7 (?); Chenevier–Harris 2013, *Construction of automorphic Galois… II* (?); Harris et al. 2016, *Rigid cohomology of certain Shimura…*, Thm 7.13, Cor. 7.14 (?); Caraiani 2012, *Local-global compatibility and the…*; Caraiani–Scholze 2017, *Generic part of the cohomology of…*; Caraiani–Scholze 2024; Scholze 2015; Allen et al. 2023; Calegari–Geraghty 2018; Newton–Thorne 2021, *Symmetric power functoriality for…*; Hansen–Johansson 2025, *Perfectoid Shimura varieties and the…*; Boxer–Pilloni 2021, Sec. 4.4
- statement: Arthur 2013 (?); Mok 2015

**GeometrizationOfLocalLanglands** (unit, order ?)
- primary: Fargues–Scholze 2021, *Geometrization of the local Langlands…*; Scholze–Weinstein 2020, *Berkeley Lectures on p-adic Geometry*, Secs. 19-24; Scholze 2017, *Étale cohomology of diamonds*; Clausen–Scholze 2019, *Condensed mathematics* (?)
- theorem: Bhatt–Scholze 2017, *Projectivity of the Witt vector affine…*; Zhu 2017, *Affine Grassmannians and the geometric…*; Kottwitz 1985, *Isocrystals with additional structure* (?)

**SpectralActionAndLanglandsParameters** (unit, order ?)
- primary: Fargues–Scholze 2021
- theorem: Dat et al. 2020, *Moduli of Langlands parameters* (?); Laumon–Rapoport–Stuhler 1993, *D-elliptic sheaves and the Langlands…*; Hausberger 2005, *Uniformisation des variétés de…*; Lafforgue 2018, *Chtoucas pour les groupes réductifs et…*

**GlobalShtukasAndFunctionFieldLanglands** (unit, order ?)
- primary: Lafforgue 2018
- theorem: Lafforgue 2002, *Chtoucas de Drinfeld et correspondance…* (?); Mirković–Vilonen 2007, *Geometric Langlands duality and…*; Drinfeld 1974

**PadicMeasuresAndIwasawaAlgebras** (unit, order ?)
- primary: Rodrigues Jacinto–Williams 2023, Thm 3.43; Washington 1997
- theorem: Mahler 1958, *Interpolation series for continuous…*; Amice 1964, *Interpolation p-adique*; Amice–Vélu 1975, *Distributions p-adiques associées aux…*; Višik 1976, *Non-archimedean measures connected with…* (?)
- formal: Tau Ceti `Topology/Algebra/Group/Profinite/ProP`

**CyclotomicIwasawaTheory** (unit, order ?)
- primary: Rodrigues Jacinto–Williams 2023, Secs. 2-8; Washington 1997, Sec. 7.5; Besser 2012, *Heidelberg lectures on Coleman…*
- theorem: Coleman 1979; Lang 1990, *Cyclotomic Fields I and II (with an…*; Rubin 2000; Mazur–Wiles 1984, *Class fields of abelian extensions of Q*; Wiles 1990, *Iwasawa conjecture for totally real…*; Greither 1992, *Class groups of abelian fields, and the…*, Thm 3.2; Kurihara 2025, *Class groups and Iwasawa modules of…*, Sec. 4; Dasgupta–Kakde 2023, *Brumer-Stark conjecture*; Coleman 1985, *Torsion points on curves and p-adic…*

**EulerAndKolyvaginSystems** (unit, order ?)
- primary: Mazur–Rubin 2004, *Kolyvagin Systems*; Rubin 2000
- theorem: Mazur–Rubin 2016, *Controlling Selmer groups in the higher…* (?); Burns–Sakamoto–Sano 2018, *Theory of higher rank Euler, Kolyvagin… II*; Kolyvagin 1990, *Euler systems*

**HeegnerPointsAndGrossZagier** (unit, order ?)
- theorem: Kolyvagin 1990; Howard 2004, *Heegner point Kolyvagin system*, Secs. 1.1-1.7 (?); Zhang 2014, *Selmer groups and the indivisibility of…*, Secs. 3-11; Burungale et al. 2026, *Non-vanishing of Kolyvagin systems and…*, Secs. 1-2; Cornut–Vatsal 2005, *CM points and quaternion algebras* (?); Rubin 1987, *Tate-Shafarevich groups and L-functions…*; Gross–Zagier 1986, *Heegner points and derivatives of…*, Chs. II-IV; Yuan–Zhang–Zhang 2013, *Gross-Zagier Formula on Shimura Curves*, Chs. 1-8; Zhang 2001, *Heights of Heegner points on Shimura…*, Secs. 3-7 (?); Conrad 2004, *Gross-Zagier revisited*, Secs. 2-10; Cai–Shu–Tian 2014, *Explicit Gross-Zagier and Waldspurger…* (?); Castella–Hsieh 2018, *Heegner cycles and p-adic L-functions*; Longo–Vigni 2019, *Kolyvagin systems and Iwasawa theory of…*; Bertolini–Darmon–Prasanna 2013, *Generalized Heegner cycles and p-adic…* (?)

**PadicLFunctionsOfModularForms** (unit, order ?)
- primary: Rodrigues Jacinto–Williams 2023
- theorem: Pollack–Stevens 2011; Kato 2004, *p-adic Hodge theory and values of zeta…*; Hsieh 2014, *Special values of anticyclotomic…* (?); Eischen–Wan 2016, *p-adic Eisenstein series and…*, Secs. 1.3; Eischen et al. 2020, *p-adic L-functions for unitary groups*; Ribet 1976, *Modular construction of unramified…* (?); Deligne–Ribet 1980, *Values of abelian L-functions at…* (?); Wan 2015, *Iwasawa main conjecture for Hilbert…* (?)

**MainConjecturesAndBSD** (unit, order ?)
- theorem: Skinner–Urban 2014, *Iwasawa main conjectures for GL_2* (?); Fouquet–Wan 2021, *Iwasawa main conjecture for universal…*; Kato 2004; Wan 2015 (?); Jetchev–Skinner–Wan 2017, *Birch and Swinnerton-Dyer formula for…*; Burungale et al. 2024, *Zeta elements for elliptic curves and…*; Castella et al. 2022, *Anticyclotomic Iwasawa theory of…*; Keller–Yin 2024, *Anticyclotomic Iwasawa theory of…*; Castella 2018, *P-part of the Birch-Swinnerton-Dyer…*; Kobayashi 2003, *Iwasawa theory for elliptic curves at…* (?); Lei–Loeffler–Zerbes 2011; Gross–Zagier 1986; Kolyvagin 1990

**SpecialValueConjectures** (unit, order ?)
- theorem: Huber–Müller-Stach 2014, *Relation between Nori motives and…*; Burns–Venjakob 2006, *Leading terms of zeta isomorphisms and…*; Brown 2012, *Mixed Tate motives over Z*; Ihara–Kaneko–Zagier 2006, *Derivation and double shuffle relations…* (?); Coates et al. 2005, *GL_2 main conjecture for elliptic…*; Kakde 2013, *Main conjecture of Iwasawa theory for…*; Ritter–Weiss 2011, *"main conjecture" of equivariant…*; Kolster 1989, *Relation between the 2-primary parts of…*
- statement: Deligne 1979, *Valeurs de fonctions L et périodes…* (?); Bloch–Kato 1990; Burns–Flach 2001, *Tamagawa numbers for motives with…* (?); Fukaya–Kato 2006, *Formulation of conjectures on p-adic…* (?)

**KTheoryOfNumberFields** (unit, order ?)
- primary: Weibel 2013, *K-book*, Chs. IV, VI; Friedlander–Grayson 2005, *Handbook of K-Theory*; Bloch 2000, *Higher Regulators, Algebraic K-Theory…*, Lectures 1-7
- theorem: Quillen 1972, *Cohomology and K-theory of the general…* (?); Borel 1974, *Stable real cohomology of arithmetic…*, Prop. 12.2 (?); Soulé 1979, *K-théorie des anneaux d'entiers de…* (?); Rognes–Weibel 2000, *Two-primary algebraic K-theory of rings…* (?); Hesselholt–Madsen 2003, *K-theory of local fields*; Suslin 1983, *K-theory of algebraically closed fields* (?); Tate 1976, *Relations between K2 and Galois…*

**RegulatorsAndPolylogarithms** (unit, order ?)
- primary: Friedlander–Grayson 2005; Bloch 2000; Weibel 2013, Chs. V, VI
- theorem: Goncharov 1995, *Geometry of configurations…*; Goncharov–Rudenko 2018, *Motivic correlators, cluster varieties…*, Sec. 2; Beilinson 1985, *Higher regulators and values of…* (?); Beilinson 1986, *Higher regulators of modular curves* (?); Thomason–Trobaugh 1990, *Higher algebraic K-theory of schemes…*; Garoufalidis et al. 2024, *Habiro ring of a number field*, Sec. 3.1, Thm 9; Huber–Kings 2011, *P-adic analogue of the Borel regulator…*; Besser–de Jeu 2003, *Syntomic regulator for the K-theory of…*
- statement: Zagier 1991, *Polylogarithms, Dedekind zeta functions…* (?)

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Koukoulopoulos 2019, *Distribution of Prime Numbers* [4] ★; Platonov–Rapinchuk 1994, *Algebraic Groups and Number Theory* [4] ★; Shimura 1971, *Arithmetic Theory of Automorphic…* [4] ★; Bump 1997, *Automorphic Forms and Representations* [3] ★; Diamond–Shurman 2005, *Modular Forms* [3] ★; Tenenbaum 2015, *Analytic and Probabilistic Number Theory* [3] ★; Weil 1982, *Adeles and Algebraic Groups* [3] ★; Berndt–Evans–Williams 1998, *Gauss and Jacobi Sums* [2] ★; Borel 1969, *Introduction aux Groupes Arithmétiques* [2] ★; Cohen 1993, *Computational Algebraic Number Theory* [2] ★; Davenport 2000, *Multiplicative Number Theory* [2] ★; Deligne–Rapoport 1973, *Les schémas de modules de courbes…* [2] ★; Eichler–Zagier 1985, *Theory of Jacobi Forms* [2] ★; Elstrodt–Grunewald–Mennicke 1998, *Groups Acting on Hyperbolic Space* [2] ★; Ireland–Rosen 1990, *Classical Introduction to Modern Number…* [2] ★; Krasner 1966, *Nombre des extensions d'un degré donné…* [2] ★; Lidl–Niederreiter 1997, *Finite Fields* [2] ★; Montgomery–Vaughan 2007, *Multiplicative Number Theory I…* [2] ★; Mumford 1974, *Abelian Varieties* [2] ★; Rosen 2002, *Number Theory in Function Fields* [2] ★; Serre 1978, *Une "formule de masse" pour les…* [2] ★; Tate 1977, *Local constants* [2] ★; Weil 1948, *Some exponential sums* [2] ★; Weil 1974, *Basic Number Theory* [2] ★; Alsina–Bayer 2004, *Quaternion Orders, Quadratic Forms, and…* [1] ★; Artin–Tate 2009, *Class Field Theory* [1] ★; Bump 2013, *Lie Groups* [1] ★; Cassels–Flynn 1996, *Prolegomena to a Middlebrow Arithmetic…* [1] ★; Engler–Prestel 2005, *Valued Fields* [1] ★; Gelbart 1976, *Weil's Representation and the Spectrum…* [1] ★; Hazewinkel 1978, *Formal Groups and Applications* [1] ★; Hejhal 1983, *Selberg Trace Formula for PSL(2,R)…* [1] ★; Iwaniec 1997, *Classical Automorphic Forms* [1] ★; Iwaniec 2002, *Spectral Methods of Automorphic Forms* [1] ★; Iwasawa 1986, *Local Class Field Theory* [1] ★; Katok 1992, *Fuchsian Groups* [1] ★; Koblitz 1993, *Elliptic Curves and Modular Forms* [1] ★; Lemmermeyer 2000, *Reciprocity Laws* [1] ★; Liu 2002, *Algebraic Geometry and Arithmetic Curves* [1] ★; Milnor–Husemoller 1973, *Symmetric Bilinear Forms* [1] ★; Miyake 1989, *Modular Forms* [1] ★; Ramakrishnan–Valenza 1999, *Fourier Analysis on Number Fields* [1] ★; Serre 1968, *Abelian l-adic Representations and…* [1] ★; Serre 2012, *N_X(p)* [1] ★; Serre 2020, *Rational Points on Curves over Finite…* [1] ★; de Shalit 1987, *Iwasawa Theory of Elliptic Curves with…* [1] ★; Vignéras 1980, *Arithmétique des Algèbres de Quaternions* [1] ★; Diamond 1997, *Taylor-Wiles construction and…* [3]; Faltings–Chai 1990, *Degeneration of Abelian Varieties* [3]; Kolyvagin 1990, *Euler systems* [3]; Arthur 2013, *Endoscopic Classification of…* [2]; Bloch 2000, *Higher Regulators, Algebraic K-Theory…* [2]; Bloch–Kato 1990, *L-functions and Tamagawa numbers of…* [2]; Bombieri–Gubler 2006, *Heights in Diophantine Geometry* [2]; Call–Silverman 1993, *Canonical heights on varieties with…* [2]; Deligne–Serre 1974, *Formes modulaires de poids 1* [2]; Drinfeld 1974, *Elliptic modules* [2]; Franke 1998, *Harmonic analysis in weighted L2-spaces* [2]; Friedlander–Grayson 2005, *Handbook of K-Theory* [2]; Gross–Zagier 1986, *Heegner points and derivatives of…* [2]; Hida 1986, *Galois representations into…* [2]; Kisin 2008, *Potentially semi-stable deformation…* [2]; Shin 2011, *Galois representations arising from…* [2]; Wan 2015, *Iwasawa main conjecture for Hilbert…* [2].

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
