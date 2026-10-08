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
