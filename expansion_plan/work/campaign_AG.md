# Campaign AG (math.AG): slate

2026-10-07. Machine version: `slate_AG.json`, which carries the full 4–8-sentence scope paragraphs, key objects, porting sources and merged proposals; below, scopes are abridged to their opening and boundary sentences. Scripts and counts: scratchpad `p2-ag/`.

## 1. Scope

**arXiv:** math.AG. Schemes, spaces, stacks and moduli; birational geometry; complex-analytic and Hodge-theoretic geometry of varieties; intersection theory; coherent, constructible and D-module sheaf theory; étale, p-adic and motivic cohomology. Per BOUNDARIES, SCV, pluripotential theory and Oka theory go to ANA, elliptic operators and Kähler–Einstein/Calabi–Yau metrics to GEO, motivic and chromatic homotopy to TOP, LMFDB semantics and "arithmetic X" to NT.

**Demand** (`campaign == AG`): 254 rows, 125 gap.

| goal | rows | distinct refs | gap | campaign | TC roadmap | open PR | TC code | Mathlib |
|---|---|---|---|---|---|---|---|---|
| OpenAI | 194 | 58 families | 111 | 49 | 11 | 14 | 5 | 4 |
| Annals | 48 | 41 entries | 10 | 13 | 12 | 8 | 4 | 1 |
| LMFDB | 12 | 5 sections | 4 | 2 | 4 | 0 | 2 | 0 |

142 rows are statement-level (61 gap), 112 proof-level (64 gap). 91 rows elsewhere list AG as secondary (NT 30, TOP 16, ANA 15, ALG 14, GEO 8, LTCS 5, COMB 3); 25 ANA/GEO rows propose roadmaps BOUNDARIES puts here. 26 of the 36 OpenAI AG families are frontier, so statement-level coverage is the target.

## 2. Existing supply

Rows = needs naming the roadmap as owner; remaining PRs by capacity.md's formula.

- **AbundanceStatement (PR #545; 29.5 KB; opened 09-30, unreviewed).** Divisors, K_X, klt for (X, 0), N¹/N₁, cone of curves, Kleiman, semiampleness. Largest AG supplier: 28 rows (Annals #7, #12, #18, #22, #48, #49; OAI 033–039, 041, 056, 062, 063, 066–068). **Merge soon**, after reconciling with OAI `NumericalDimension` (29k lines, same divisor/discrepancy layer) so both name one carrier. L4D's curve tests stay; general intersection numbers go to IntersectionTheory.
- **CohomologicalPointCounting (PR #196; family of 7; 176 KB).** Étale coefficients, base change, Rf_!, Artin comparison, ℓ-adic realization, Grothendieck–Lefschetz. 13 rows (Annals #3, #5, #16, #45, #67; OAI 032–034, 041, 046, 056, 060, 065), and 15 campaign READMEs build on it. **Stalled:** changes requested by CBirkbeck (08-17) and kim-em (09-10: 15 items open, all seven `Suggested.lean` empty); no substantive commit since 08-21. **Adopt it:** ask bwangpj to hand over; an AG lead answers the review, writes the `Suggested.lean` bridges, and keeps the family form only if the umbrella is reviewed first (else seven PRs in order). The campaign's highest-value action.
- **ReductiveGroups** (main; 1,115 PRs, ≈600 left; L8 untouched). 15 rows (Annals #4, #8, #35, #52, #59; OAI 014, 018, 043, 062, 067, 069, 203, 208). ReductiveGroupSchemes makes L8 definite as a sibling (in-place edits reset progress).
- **StableReduction** (main; no layer complete; ≈310 left). 13 rows (Annals #9, #10, #12, #16, #42, #66; OAI 019, 039, 053, 063, 065, 194, 195). L4 stays the one owner of blowups (land OAI `Seshadri/Blowup` there).
- **JacobianChallenge** (main; A done, B–F partial; ≈120 left). 7 rows (Annals #1, #10, #16, #17, #49; OAI 040; av.fq). CoherentDuality generalizes B, HilbertQuot D; AbelianVarieties consumes E by alias.
- **AlgebraicCurves** (main; L0–L7 done; ≈40 left). 6 rows (OAI 009, 117, 142, 202; g2c, hgcwa). GeometryOfCurves starts where it stops.
- **AlgebraicVectorBundles** (main; L0 partial, L1–L2 mostly untouched; ≈220 left). 1 row, but its two named successors become HilbertQuot L0 and IntersectionTheory.
- **AdicSpaces** (main; ≈230 left). 3 rows (Annals #38; OAI 193, 194). P5 and P7 are siblings.
- **AnalyticToricGeometry** (main; ≈25 left). 1 row (Annals #28). ToricVarieties consumes its cone-to-fan layer.
- **BelyiMaps** (main; L7–L14 untouched; ≈200 left). 5 rows (belyi, hgcwa, noncong). GeometryOfCurves consumes Riemann existence.
- **RealAlgebraicGeometry** (main; ≈40 left). 4 rows (OAI 058, 095, 141, 304). Supplies stratifications to PerverseSheaves, Microlocal.
- **Completed/HodgeStructures.** 4 rows (Annals #2; OAI 001, 032, 054). Successors: VariationsOfHodgeStructure (issue #167), KahlerManifolds.
- **ComplexManifolds #279, ComplexTori #280** (math.CV, ANA's; awaiting-author). 10 + 4 rows; prerequisites of the HodgeTheory family.
- Interfaces: ClassifyingSpaces #437, ChevalleyGroups #447/#697, HamiltonianSystems #480 (§5).

### Birkbeck campaign: consolidation of the AG lanes

Demand = rows whose owner names the roadmap or its stage prefix. → = into a new roadmap (§3.1); P# = promotion unit (§3.2).

| Campaign roadmap (MSC, distance) | Demand | Destination | Overlap with Tau Ceti |
|---|---|---|---|
| AlgebraicModuliForArithmeticGeometry (14D, 6) | 27 (A5 O22) | → AlgebraicSpaces (R09.3), AlgebraicStacks (R09.4–5), HilbertQuot (R09.1–2, R09.6, A0-ext), Resolution (R09.7) | R09.7a re-specifies StableReduction L4 |
| SchemeAndStackFoundations (14A, 6) | 19 (A4 O15) | → AlgebraicSpaces (SF.1), CoherentDuality (SF.2), HilbertQuot (SF.3–4), IntersectionTheory (SF.5); SF.6 to P1–P3 | **duplicate**: SF.0 of Mathlib/AVB, SF.2 of #196, SF.3 of JacobianChallenge C–D and #545 |
| AbelianSchemesAndArithmeticModuli (14K, 6) | 8 (A2 L1 O5) | A0–A5 → AbelianVarieties; A6 → NT | A1–A2 overlap JacobianChallenge E |
| ComplexComparisonPartII (32C, 6) | 7 (A1 O6) | C0–C4 → ComplexAnalyticSpaces; C5 → HodgeTheoryOfAlgebraicVarieties | sibling of #196 ComplexComparison |
| MotivesAndAlgebraicCycles (14C, 8) | 6 (A3 O3) | P4; MC.0 → IntersectionTheory | MC.0 duplicates SF.5 |
| EtaleDualityAndPerverseSheaves (14F, 9) | 5 (A3 O2) | P1 | rests on unmerged #196 |
| LefschetzPencilsAndVanishingCycles (14F, 8) | 4 (A1 O3) | P2 | rests on #196 |
| WeilConjectures, DeligneWeightsAndPurity, WeightsInEtaleCohomology (14G/14F, 9) | 0 | P3 (three → one) | WC.1 rests on #196 TraceFormula |
| AdicSpacesPartII (14G, 7), AdicEtaleGeometry (14G, 8) | 3 (A3), 0 | P5 | extend AdicSpaces |
| ClassicalAdicEtaleCohomology (14F, 8) | 1 | P6 | |
| PerfectoidSpaces (14G, 8), PerfectoidQuotients (9), DiamondsAndVStacks (8) | 5, 1, 0 | P7 | |
| DiamondEtaleCohomology, DiamondSixOperations, VStackSheavesAndLisseCategories, AdicCoefficientsAndComparisons (9–10) | 0 | P8 | AdicCoefficients L2 re-specifies #196's Nagata compactification |
| FarguesFontaineDiamonds, RelativeFarguesFontaine, VectorBundlesAndIsocrystals (9–10) | 0, 0, 2 | P9 | extend AdicSpaces L6; VBI's HN formalism → ModuliOfSheaves |
| CrystallineCohomology (8) | 2 | P10 | |
| PadicDifferentialEquationsAndRigidCohomology (9) | 0 | P11 | |
| PrismaticCohomology (10), DerivedDeRhamCohomology (8), AInfCohomology (9), CohomologyComparisons (10) | 1, 1, 0, 1 | P12 | |
| HabiroCohomologyFoundations (14F, 10), HabiroRings (13F), HabiroCyclotomicCompletions (13J, 2) | 0 | P13 | |
| TropicalAndBerkovichArithmetic (14G, 7) | 3 (A2 O1) | P14 (TB.0–5); TB.6–7 → NT | |
| ReductiveGroupsPartII (20G, 7) | 6 (A3 O3) | P15 (RG2.1–4); RG2.0a, RG2.5 → ReductiveGroupSchemes | RG2.3, RG2.5 overlap ChevalleyGroups #447 |
| InverseGaloisAndArithmeticFundamentalGroups (12F), EnhancedDerivedSheaves (18N) | 2, 2 | NT; TOP (math.CT) | IG.0 duplicates #196 ConstructibleEtale L3 |
| **17 math.AG-primary roadmaps left to NT**: ShimuraData 9, ShimuraVarieties 8, PadicHodgeTheory 7, HeightsRationalPoints 6, NeronModels 4, ArakelovGeometry 4, FaltingsFiniteness 2, PerfectoidShimuraVarieties 2, FiniteFlatGroups 2, PELModuli 1, AnabelianGeometry 1, GeometricSatake 1, HeckeStacks 1; BunG, AutomorphicBundles, HodgeTateAndCanonicalSubgroups, ShimuraCompactifications 0 | 48 | NT lanes | ShimuraData D3 must consume VHS, D1 MumfordTateGroups' torus |

AG takes 34 campaign roadmaps (30 math.AG-primary, ComplexComparisonPartII, two math.AC Habiro roadmaps, ReductiveGroupsPartII): 4 dissolve into new roadmaps, 30 become 15 promotion units. Direct demand for the cohomology and p-adic lanes is thin (≈35 rows); they matter as NT's suppliers. **Promotion order:** #196 (adopt) → P5 formal-scheme layers and P14 (wave A; Annals #34, #47) → P1, P2 once #196 merges → P7 perfectoid rings and P12's δ-ring/prism layer (Annals #27, #51) → P13 cyclotomic completions (Birkbeck focus) → P3, P4, P10, P11 → P6, P8, P9 (no direct demand; geometric-Langlands consumers).

**Explorer drafts** (reused, not owners): HodgeStructuresPartII → VHS + ModuliOfSheaves; SeveralComplexVariablesKahlerGeometry → ANA SCV + KahlerManifolds; StableReductionPartII → ModuliOfCurvesAndStableMaps; JacobianChallengePartII → AbelianVarieties, HilbertQuot (Faltings–Zhang to NT); GenericDoublePointInterpolation stays a narrow S; AnalyticStacks → TOP/CT; AbelianSchemesPartII, NeronModelsPartII, AbelianVarietiesIsogenousToNoJacobian → NT; HyperbolicCurveVolumesAndGonality → ANA.

## 3. The slate

### 3.1 New roadmaps: 35, as four families and 11 standalone roadmaps

**Merges.** OAI's 20 AG proposals, 28 from the Annals reports and LMFDB's 5 math.AG ones become 35. PairsAndKodairaDimension splits into pairs (with SingularitiesOfPairs, ValuationSpacesOfVarieties) and κ (with PositivityOfLineBundles); PositivityAndVanishing into AsymptoticPositivity and VanishingTheorems (= KodairaVanishingTheorems); KahlerManifoldsAndHodgeTheory into analytic and algebraic halves. SlopeStability + HiggsBundles; GIT + GoodModuliSpaces + CharacterVarieties; ModuliOfStableCurves + ModuliOfStableMaps; VirtualClasses + GromovWittenTheory; PicardSchemes into HilbertQuot; EndomorphismAlgebras into AbelianVarieties; CanonicalModelsAndGonality + GroupActionsOnRiemannSurfaces + the geometric half of HyperellipticCurves → GeometryOfCurves; PlaneCurveSingularities into SingularityTheory; Katz rigidity into PerverseSheaves. **Handed off:** SeveralComplexVariables, PositiveCurrentsAndMongeAmpere, OkaTheoryAndHyperbolicity → ANA; LocallyNilpotentDerivations, BeilinsonBernsteinLocalization → ALG; TopologicalSixOperations, MotivicHomotopyTheory → TOP; the metric half of KahlerGeometry and CalabiYauAndComplexMongeAmpere → GEO; HilbertModularSurfaces, HyperellipticCurves (arithmetic), CurvesOverFiniteFields, AbelianVarietiesOverFiniteFields, ArakelovIntersectionTheory → NT.

### Family ModuliTheory — XL family (≈1,550 PRs, 6 sub-roadmaps)

Umbrella (math.AG): parameter spaces over an arbitrary base — algebraic spaces and stacks, Hilbert/Quot/Picard schemes, quotients by group actions, and moduli of curves, maps, sheaves and Higgs bundles. Intersection theory on moduli is IntersectionTheory/GromovWittenTheory; arithmetic moduli (Shimura, PEL, Néron) are NT; derived and higher stacks are outside.

**1. AlgebraicSpaces** — L (250), wave A; formalizability high. This roadmap develops the Grothendieck topologies on schemes and the descent theory they support, and builds algebraic spaces on them. Étale cohomology with torsion coefficients belongs to CohomologicalPointCounting; stacks belong to AlgebraicStacks. *Milestones:* effective fpqc descent; fppf vs étale cohomology for smooth commutative group schemes; Hilbert 90 in the flat topology; X/G an algebraic space for free finite G. *Prereqs:* Mathlib AlgebraicGeometry/Sites; ModularCurves L0E; ReductiveGroups L3; CohomologicalPointCounting #196. *Goals:* Annals 35, 6 (base), 9 (base), 25 (base).

**2. AlgebraicStacks** — L (250), wave B; formalizability high. Fibred categories and stacks over (Sch)_fppf; algebraic (Artin) stacks with representable diagonal and smooth atlas and Deligne–Mumford stacks with étale atlas; quotient stacks [U/G] and BG … Specific moduli problems are the later members of the family, good moduli spaces are GeometricInvariantTheory, and derived or higher stacks are outside. *Milestones:* DM criterion via the diagonal; valuative criteria; Keel–Mori; groupoid point counts. *Prereqs:* AlgebraicSpaces; ReductiveGroups; HilbertQuotAndPicardSchemes. *Goals:* OAI 069, 053/063/065 (via moduli of curves); Annals 6, 25 (coarse half), 9 (base).

**3. HilbertQuotAndPicardSchemes** — L (250), wave A; formalizability high. This roadmap constructs the projective parameter spaces of algebraic geometry. It starts with projective, Grassmann and flag bundles of locally free sheaves and their tautological bundles … JacobianChallenge's rigidified Picard functor of curves is specialized, not redefined; moduli stacks are AlgebraicStacks. *Milestones:* representability of Hilb and Quot; Fogarty; representability of Pic_{X/S}; theorem of the base. *Prereqs:* AlgebraicVectorBundles; JacobianChallenge B–D; AbundanceStatement #545 L4B; Mathlib ProjectiveSpectrum, flatness. *Goals:* OAI 040, 050, 053, 065, Hom schemes for 051, 052, 062, 063, 067; Annals 49.

**4. GeometricInvariantTheory** — L (250), wave A; formalizability high. Mumford's geometric invariant theory over a field and its stack-theoretic form. Linearly reductive group schemes and Reynolds operators; finite generation of invariants … Reductive groups come from ReductiveGroups and symplectic moment maps from HamiltonianSystems; moduli of sheaves and curves are later members of the family. *Milestones:* Hilbert–Nagata finite generation; Hilbert–Mumford criterion; Kempf–Ness; King's theorem. *Prereqs:* ReductiveGroups L6; HamiltonianSystems #480; RepresentationTheory; AlgebraicStacks. *Goals:* OAI 027, 043, 044, 054/055 (via moduli of sheaves); Annals 25.

**5. ModuliOfCurvesAndStableMaps** — L (300), wave B; formalizability medium. The moduli stacks M̄_{g,n} of stable pointed curves and M̄_{g,n}(X, β) of stable maps to a projective scheme. Algebraicity through tri-canonical embeddings and Hilbert schemes … Virtual classes are GromovWittenTheory; level structures and arithmetic models are NT. *Milestones:* M̄_{g,n} smooth proper DM of dimension 3g−3+n; normal-crossings boundary; stable maps proper DM; Keel's presentation. *Prereqs:* StableReduction; AlgebraicStacks; HilbertQuotAndPicardSchemes; IntersectionTheory. *Goals:* OAI 053, 063, 065; Annals 9, 66 (moduli half).

**6. ModuliOfSheavesAndHiggsBundles** — L (250), wave B; formalizability medium-high. Stability and moduli of coherent sheaves and Higgs bundles. An abstract slope formalism on abelian and exact categories with Harder–Narasimhan and Jordan–Hölder filtrations … Bridgeland stability is DerivedCategoriesOfCoherentSheaves; Betti moduli are GeometricInvariantTheory. *Milestones:* existence and uniqueness of HN filtrations; Bogomolov inequality; projective moduli of semistable sheaves; Hitchin map proper. *Prereqs:* GeometricInvariantTheory; HilbertQuotAndPicardSchemes; IntersectionTheory; JacobianChallenge B. *Goals:* OAI 043, 057, 058 (statements), 054/055 (Bogomolov input); Annals 44, 36.

### Family BirationalGeometry — XL family (≈1,850 PRs, 7 sub-roadmaps)

Umbrella (math.AG): birational geometry of varieties in characteristic zero unless stated — resolution, singularities of pairs, asymptotic positivity, vanishing, the MMP, rational curves and K-stability. It sits on AbundanceStatement (#545) for divisors, K_X, klt for (X,0) and nefness. Current-theoretic positivity is ANA's; Kähler and characteristic-p MMP are frontier.

**7. ResolutionOfSingularities** — L (300), wave A; formalizability medium. Resolution of singularities and the models built from it. Starting from StableReduction's blowups of quasi-coherent ideals (consumed, not rebuilt), it develops strict and total transforms … Resolution in positive characteristic beyond surfaces is outside; discrepancies are SingularitiesOfPairs. *Milestones:* principalization; embedded resolution (char 0); log resolution of pairs; KKMS semistable reduction. *Prereqs:* StableReduction L4; Mathlib Normalization, Birational; ToricVarieties. *Goals:* OAI 033, 034, 037, 038, 039, 041, 042, 054, 064, 194, 195; Annals 42.

**8. SingularitiesOfPairs** — L (250), wave B; formalizability high. Singularities of the minimal model program for pairs (X, Δ), with X normal over a field of characteristic zero and Δ an effective ℝ-Weil divisor with K_X + Δ ℝ-Cartier … Iitaka dimension is AsymptoticPositivity; vanishing and rational singularities are VanishingTheorems. *Milestones:* log-resolution criterion and its independence; adjunction; rationality of lct; A_X(v) lower semicontinuous with lct = inf A/v. *Prereqs:* AbundanceStatement #545 L0–L3; ResolutionOfSingularities; Tau Ceti ValuationSpectrum / AdicSpaces L1; ToricVarieties. *Goals:* OAI 033, 034, 035, 036, 037, 038, 056, 066; Annals 7, 18, 48, 50.

**9. AsymptoticPositivity** — L (250), wave B; formalizability high. Asymptotic invariants of line bundles, ℝ-divisors and vector bundles on projective varieties (Lazarsfeld's Positivity I–II), on top of the nef/ample/semiample layer of AbundanceStatement. Kodaira dimension of compact complex manifolds uses ComplexAnalyticSpaces; current-theoretic positivity is ANA's. *Milestones:* Iitaka fibration; κ(X×Y)=κ(X)+κ(Y); continuity of vol and Big = int Psef; Fujita approximation. *Prereqs:* AbundanceStatement #545 L4–L5; IntersectionTheory; HilbertQuotAndPicardSchemes; SingularitiesOfPairs. *Goals:* OAI 033, 034, 035, 036, 038, 039, 048, 050, 057, 060, 067; Annals 22, 39 (S-invariant).

**10. VanishingTheorems** — L (200), wave B; formalizability medium-high. The cohomology vanishing theorems of birational geometry, proved algebraically. The Cartier isomorphism for smooth schemes in characteristic p and the Deligne–Illusie decomposition of the de … Serre and Grothendieck duality are imported from CoherentDuality; analytic multiplier ideals and Ohsawa–Takegoshi are ANA's. *Milestones:* Deligne–Illusie; KAN; Kawamata–Viehweg; Nadel. *Prereqs:* CoherentDuality; SingularitiesOfPairs; ResolutionOfSingularities; Mathlib SpreadingOut, Witt vectors. *Goals:* OAI 034, 036, 037, 038, 066; Annals 18 (rational singularities), 46 (degeneration route).

**11. MinimalModelProgram** — XL (400), wave C; formalizability low-medium. The main theorems of the minimal model program in characteristic zero. Cone, contraction, rationality and basepoint-free theorems for klt and lc pairs; extremal rays, flips and flops … General abundance, the characteristic-p MMP and the Kähler MMP are outside. *Milestones:* cone theorem with length bound; contraction and basepoint-free theorems; BCHM; finite generation. *Prereqs:* VanishingTheorems; SingularitiesOfPairs; AsymptoticPositivity; RationalCurvesAndFanoVarieties. *Goals:* OAI 033, 034, 036, 037, 056, 066, 068.

**12. RationalCurvesAndFanoVarieties** — L (250), wave B; formalizability medium-high. Rational curves on algebraic varieties (Kollár; Debarre). Deformation theory of morphisms from curves and dimension estimates for Hom schemes … The cone theorem itself is MinimalModelProgram; homogeneous examples come from FlagVarieties. *Milestones:* bend-and-break; Mori's theorem; MRC fibration; GHS. *Prereqs:* HilbertQuotAndPicardSchemes; AbundanceStatement #545; Mathlib SpreadingOut; FlagVarieties. *Goals:* OAI 051, 052, 062, 063, 067, 034/057 (proofs).

**13. KStabilityOfFanoVarieties** — L (200), wave C; formalizability medium-high. Log Fano pairs and their K-stability in the valuative and test-configuration forms: β = A − S on divisors over X, the stability threshold δ, K-(semi/poly)stability and uniform K-stability … Existence of Kähler–Einstein metrics (YTD) is GEO's; the K-moduli space is outside. *Milestones:* Fujita–Li equivalence; K-ss ⇒ klt; δ(P^n)=1; toric barycentre criterion. *Prereqs:* SingularitiesOfPairs; AsymptoticPositivity; ToricVarieties; HilbertQuotAndPicardSchemes. *Goals:* Annals 39.

### Family HodgeTheory — XL family (≈1,410 PRs, 6 sub-roadmaps)

Umbrella (math.AG, sec. math.CV): compact complex spaces, Kähler manifolds and the Hodge theory of complex varieties, from Dolbeault cohomology to variations of Hodge structure, Mumford–Tate groups and K3/hyperkähler manifolds; Completed/HodgeStructures is its linear-algebra base. SCV and pluripotential theory are ANA's; elliptic operators on compact manifolds and Kähler–Einstein/Calabi–Yau metrics are GEO's.

**14. ComplexAnalyticSpaces** — L (250), wave B; formalizability medium. Global complex-analytic geometry of complex spaces. Reduced and nonreduced complex spaces, analytic subsets and dimension, irreducible components, normalization, Oka's coherence theorem … It generalizes the analytification of CohomologicalPointCounting/ComplexComparison and consumes several complex variables (Weierstrass, C{z}, Cartan A/B) from ANA rather than proving them. *Milestones:* Oka coherence; Remmert proper mapping; Grauert direct images; GAGA. *Prereqs:* ANA SeveralComplexVariables; ComplexManifolds #279; CohomologicalPointCounting #196 ComplexComparison L2. *Goals:* OAI 032, 033, 034, 041, 046, 056.

**15. KahlerManifolds** — L (300), wave B; formalizability medium. Complex differential geometry and Hodge theory of compact complex and Kähler manifolds (Griffiths–Harris ch. 0–1, Huybrechts, Voisin I). Kähler–Einstein, cscK and Calabi–Yau metrics are GEO's; plurisubharmonic analysis is ANA's. *Milestones:* holomorphic Frobenius; Kähler identities; Hodge decomposition; hard Lefschetz and HR relations. *Prereqs:* ComplexManifolds #279; DifferentialGeometry; GEO EllipticOperatorsOnManifolds; Completed/HodgeStructures. *Goals:* OAI 032, 036, 041, 050, 051, 052, 054, 057, 068, 338, 347, 359; Annals 64 (Kähler part; KE existence is GEO).

**16. HodgeTheoryOfAlgebraicVarieties** — L (250), wave C; formalizability medium. Hodge theory of complex algebraic varieties. Algebraic de Rham cohomology, the Hodge filtration and Grothendieck's algebraic de Rham–Betti comparison; the cycle class map to Betti cohomology … Analytic foundations are KahlerManifolds; motives are MotivesAndAlgebraicCycles. *Milestones:* de Rham–Betti comparison; Lefschetz (1,1); Deligne's MHS and strictness; Hodge numbers of hypersurfaces. *Prereqs:* KahlerManifolds; ComplexAnalyticSpaces; CohomologicalPointCounting #196 ComplexComparison; ResolutionOfSingularities. *Goals:* OAI 032, 043 (MHS), 051, 057, 001 (Weil classes); Annals 46 (complex part).

**17. VariationsOfHodgeStructure** — L (250), wave C; formalizability medium-low at Schmid. The successor named by Completed/HodgeStructures. Local systems and flat bundles; variations of (polarized) Hodge structure with Griffiths transversality … ShimuraData's homogeneous VHS must consume this carrier; Saito's Hodge modules are outside. *Milestones:* Griffiths transversality of geometric VHS; curvature of period domains; theorem of the fixed part; semisimplicity. *Prereqs:* KahlerManifolds; HodgeTheoryOfAlgebraicVarieties; Completed/HodgeStructures; FlagVarieties. *Goals:* OAI 032, 033, 041, 043; Annals 2.

**18. MumfordTateGroups** — M (110), wave A; formalizability high. Hodge tensors and the Mumford–Tate group of a ℚ-Hodge structure as the smallest ℚ-subgroup of GL(V) × G_m containing the image of the Deligne torus … The Deligne torus comes from Weil restriction in ReductiveGroupSchemes; Shimura data are NT's. *Milestones:* Tannakian description; reductivity for polarizable V; CM ⇔ torus; generic MT group locally constant off a countable union. *Prereqs:* Completed/HodgeStructures; ReductiveGroups L4–L6; Tau Ceti Tannakian reconstruction; ReductiveGroupSchemes. *Goals:* OAI 032, 001; Annals 40.

**19. K3AndHyperkahlerManifolds** — L (250), wave C; formalizability medium. K3 surfaces and irreducible holomorphic symplectic manifolds (Huybrechts' Lectures on K3; Gross–Huybrechts–Joyce). The K3 lattice from IntegralLattices and Hodge structures of K3 type … The Beauville–Bogomolov decomposition is stated, its holonomy input belonging to GEO; hyperkähler metrics are GEO's. *Milestones:* global Torelli; surjectivity of the period map; Kuga–Satake; BBF form and Fujiki relation. *Prereqs:* AlgebraicSurfaces; KahlerManifolds; VariationsOfHodgeStructure; IntegralLattices. *Goals:* OAI 032, 041, 042, 054, 055.

### Family SheafTheory — XL family (≈1,200 PRs, 5 sub-roadmaps)

Umbrella (math.AG): derived sheaf theory on varieties — coherent duality, derived categories of coherent sheaves and stability conditions, constructible and perverse sheaves on complex varieties, D-modules, microlocal sheaf theory. Étale/ℓ-adic sheaves are CohomologicalPointCounting and its successors; sheaves on locally compact spaces and Verdier duality are TOP's TopologicalSixOperations.

**20. CoherentDuality** — L (250), wave A; formalizability medium. Derived categories of quasi-coherent sheaves on schemes: D_qc, D^b_coh and Perf, with Perf ⊆ D^b_coh and equality exactly for regular schemes; Grothendieck coherence of Rf_∗ for proper maps … Nagata compactification is consumed from CohomologicalPointCounting/CompactSupport. *Milestones:* Perf = D^b_coh iff regular; coherence of Rf_∗; Grothendieck duality with base change; Serre duality for projective CM schemes. *Prereqs:* Mathlib DerivedCategory, Triangulated; Tau Ceti QuasicoherentSheaf / FinitelyPresentedSheaf; JacobianChallenge B; StableReduction L2. *Goals:* OAI 040, 060 (Serre duality, Hodge numbers; proofs); Annals 10, 16 (coherent).

**21. DerivedCategoriesOfCoherentSheaves** — L (250), wave B; formalizability medium. D^b(Coh X) for smooth projective X: Serre functors, exceptional collections and semiorthogonal decompositions (Beilinson on P^n, Kuznetsov components of cubic fourfolds and Fano threefolds) … DG enhancements come from DGAInfinity; slope stability and the Bogomolov inequality come from ModuliOfSheavesAndHiggsBundles. *Milestones:* Beilinson's collection; Orlov's theorem; Bondal–Orlov; Bridgeland deformation theorem. *Prereqs:* CoherentDuality; ModuliOfSheavesAndHiggsBundles; GrothendieckEulerForms; DGAInfinity. *Goals:* OAI 040, 054, 055, 043 (proof); Annals 58 (with TOP).

**22. PerverseSheavesOnComplexVarieties** — L (250), wave B; formalizability medium. Constructible and perverse sheaves on complex algebraic varieties. Complex-algebraic and semialgebraic stratifications … Sheaves on locally compact spaces and Verdier duality come from TOP's TopologicalSixOperations; ℓ-adic perverse sheaves are EtaleDualityAndPerverseSheaves. *Milestones:* constructibility of six operations; perverse t-structure and IC; decomposition theorem over ℂ; Katz's rigidity criterion. *Prereqs:* TOP TopologicalSixOperations; CohomologicalPointCounting #196 ComplexComparison; EtaleDualityAndPerverseSheaves; RealAlgebraicGeometry. *Goals:* OAI 043 (perverse filtration); Annals 41, 67, 5 (stratified part).

**23. AlgebraicDModules** — L (250), wave B; formalizability medium. Rings of differential operators D_X on smooth varieties in characteristic zero; coherent D-modules, good filtrations and characteristic varieties; Bernstein's inequality; holonomic modules … Saito's Hodge modules and D-modules on Bun_G are outside. *Milestones:* Bernstein inequality; Kashiwara equivalence; stability of holonomicity; existence of b-functions. *Prereqs:* CoherentDuality; AlgebraicVectorBundles; PerverseSheavesOnComplexVarieties; ComplexAnalyticSpaces. *Goals:* OAI 069 (algebraic layer); Annals 15.

**24. MicrolocalSheafTheory** — L (200), wave B; formalizability medium. Kashiwara–Schapira microlocal sheaf theory on real manifolds: the microsupport SS(F) ⊆ T∗M of F ∈ D^b(k_M), the non-characteristic deformation lemma, the microlocal Morse lemma … Beilinson's singular support of étale sheaves is NT/AG consumer material; subanalytic geometry has no supplier and is outside. *Milestones:* microlocal Morse lemma; functorial bounds; involutivity; Lagrangian microsupport of ℝ-constructible sheaves. *Prereqs:* TOP TopologicalSixOperations; DifferentialGeometry; RealAlgebraicGeometry. *Goals:* OAI 304; Annals 5 (microsupport).

### Standalone roadmaps

**25. IntersectionTheory** — L (300), wave A; formalizability high. Fulton's intersection theory over a field, on Mathlib's AlgebraicCycle and OrderOfVanishing. Rational equivalence and Chow groups, proper pushforward and flat pullback … Equivariant Chow groups are EquivariantCohomologyAndLocalization; motives are MotivesAndAlgebraicCycles. *Milestones:* intersection with divisors and commutativity; Chern classes and splitting principle; refined Gysin maps; projection formula. *Prereqs:* AlgebraicVectorBundles; HilbertQuotAndPicardSchemes; AbundanceStatement #545 L1, L4A; StableReduction L4. *Goals:* OAI 017, 032, 039, 040, 053, 055, 067, 108, 166, 170; Annals 12, 33, 14/22/24/49 (supplier).

**26. EquivariantCohomologyAndLocalization** — L (200), wave B; formalizability medium-high. Borel equivariant cohomology of spaces with actions of compact Lie groups and tori; Edidin–Graham equivariant Chow groups and equivariant Chern classes … The classifying spaces of compact Lie groups are imported from TOP; virtual localization is GromovWittenTheory. *Milestones:* localization theorem (topological and Chow); BB decomposition; GKM for toric and flag varieties. *Prereqs:* IntersectionTheory; TOP ClassifyingSpaces #437; ReductiveGroups; ToricVarieties. *Goals:* OAI 040, 044, 053, 065, 068.

**27. GromovWittenTheory** — XL (400), wave C; formalizability low-medium. Algebraic Gromov–Witten theory. Cone stacks and the intrinsic normal cone, perfect obstruction theories and virtual fundamental classes (Behrend–Fantechi, Li–Tian) … The symplectic construction is GEO's PseudoholomorphicCurveModuli. *Milestones:* existence of virtual classes; virtual localization; Kontsevich–Manin axioms; WDVV and associativity of QH. *Prereqs:* ModuliOfCurvesAndStableMaps; IntersectionTheory; EquivariantCohomologyAndLocalization; AlgebraicStacks. *Goals:* OAI 040, 053, 063, 065; Annals 66.

**28. ToricVarieties** — L (250), wave A; formalizability high. Normal toric varieties X_Σ over an arbitrary base ring from arbitrary rational polyhedral fans, generalizing AnalyticToricGeometry's algebraic cone-to-fan layer, which is consumed. Analytic realizations stay with AnalyticToricGeometry; toroidal compactifications of Shimura varieties are NT's. *Milestones:* orbit–cone correspondence; smoothness and completeness criteria; Pic via support functions; ampleness by strict convexity. *Prereqs:* AnalyticToricGeometry L0; AbundanceStatement #545 L1; IntersectionTheory. *Goals:* OAI 039/041 (toroidal models); Annals 28, examples for 18, 22, 39.

**29. FlagVarieties** — L (200), wave A; formalizability high. Projective homogeneous varieties: G/P for a parabolic subgroup of a reductive group as a smooth projective variety, Borel's fixed-point theorem … Affine flag varieties are AffineGrassmannians; equivariant cohomology is EquivariantCohomologyAndLocalization. *Milestones:* G/P projective; Bruhat decomposition; Borel–Weil–Bott; Chevalley's formula. *Prereqs:* ReductiveGroups L3, L7; RepresentationTheory/LieHighestWeight; HilbertQuotAndPicardSchemes; IntersectionTheory. *Goals:* OAI 043, 044, 062, 067; Annals 15/53 (via ALG).

**30. AffineGrassmannians** — XL (350), wave C; formalizability medium. Ind-schemes, loop groups LG and L⁺G and Beauville–Laszlo gluing; the affine Grassmannian Gr_G over a field as an ind-projective ind-scheme with the lattice model for GL_n and π₀(Gr_G) = π₁(G) … CB GeometricSatakeAndFusion (Witt-vector and B_dR Grassmannians) compares with it and CB EndoscopicTransfer ET.2b consumes it. *Milestones:* ind-projectivity; π₀(Gr_G) = π₁(G); dimension of Schubert varieties; MV geometric Satake. *Prereqs:* ReductiveGroupSchemes; AlgebraicVectorBundles; AlgebraicStacks; PerverseSheavesOnComplexVarieties. *Goals:* OAI 044 (BFN input); Annals 55.

**31. ReductiveGroupSchemes** — L (250), wave B; formalizability medium. SGA 3 XIX–XXVI made definite as the successor of ReductiveGroups' over-a-base layer: reductive group schemes over an arbitrary base, maximal tori étale-locally … Groups over local fields and buildings are BruhatTitsTheory. *Milestones:* tori étale-locally; Demazure existence and isomorphism; forms ↔ Out-torsors; Langlands dual over ℤ. *Prereqs:* ReductiveGroups L6–L9; ChevalleyGroups #447/#697; AlgebraicSpaces. *Goals:* OAI 014, 018; Annals 8 (base), 26.

**32. GeometryOfCurves** — L (250), wave A; formalizability high. Projective geometry of curves beyond Riemann–Roch, starting where AlgebraicCurves stops. Noether's theorem that the canonical map embeds non-hyperelliptic curves … Minimal models over DVRs, cluster pictures and LMFDB labels remain NT's HyperellipticCurves and LMFDB lane. *Milestones:* Noether and Petri; Clifford; Brill–Noether existence; Castelnuovo–Severi. *Prereqs:* AlgebraicCurves; JacobianChallenge; BelyiMaps; FuchsianOrbifolds. *Goals:* OAI 108 (plane curves); Annals 17 (Torelli); LMFDB g2c, hgcwa, modcurve, shimcurve.

**33. AbelianVarieties** — L (300), wave B; formalizability high. Abelian varieties and abelian schemes, built once over a base and specialized to fields. Rigidity, the theorem of the cube, dual abelian schemes through the Picard scheme … JacobianChallenge Layer E's dual and polarizations are consumed by alias where they land first; Tate's isogeny theorem, Honda–Tate, Néron models and moduli of abelian varieties are NT's. *Milestones:* theorem of the cube; dual abelian scheme; Poincaré reducibility; Rosati positivity. *Prereqs:* JacobianChallenge E; HilbertQuotAndPicardSchemes; AlgebraicSpaces; ComplexTori #280. *Goals:* OAI 001, 016, 032, 040; Annals 1, 49 (abelian case); LMFDB g2c (End data), ecnf, av.fq (via NT).

**34. SingularityTheory** — L (250), wave B; formalizability medium. Singularities of hypersurfaces and surfaces. Milnor and Tjurina numbers, the Milnor fibration and bouquet theorem, monodromy and Seifert forms, Brieskorn–Pham examples … High-dimensional fibred links and their classification by Seifert forms belong to TOP; SCV comes from ANA. *Milestones:* Milnor fibration theorem; bouquet theorem; Zariski equisingularity of plane curves; Lê–Ramanujam. *Prereqs:* ANA SeveralComplexVariables; ResolutionOfSingularities; DifferentialGeometry; GeometricTopology. *Goals:* OAI 048, 059, 064, 108, 037 (proof).

**35. AlgebraicSurfaces** — L (250), wave B; formalizability medium-high for the algebraic classification. Smooth projective and compact complex surfaces (Beauville; Barth–Hulek–Peters–Van de Ven). Noether's formula, Castelnuovo's contractibility criterion and minimal models … Hilbert modular surfaces are NT's worked examples; K3 surfaces are K3AndHyperkahlerManifolds. *Milestones:* Castelnuovo contraction; minimal model uniqueness for κ ≥ 0; Castelnuovo rationality; Enriques–Kodaira (algebraic, char 0). *Prereqs:* IntersectionTheory; ResolutionOfSingularities; HilbertQuotAndPicardSchemes; AsymptoticPositivity. *Goals:* OAI 042, 060, 195, 039/040/048 (proofs); LMFDB hmsurface (via NT).

**Porting sources.** OAI `lean/OAI` (Apache-2.0): every AG development imports Mathlib only and re-defines its carriers, so each port follows the README's "coordinate first" rule and lands on the slate's carrier.

| OAI directory (lines, family) | Target |
|---|---|
| AlgebraicGeometry/Seshadri (56.6k, 039): Blowup/ · Bertini/, Projective/ · Intersection/ · Cohomology/ | StableReduction L4 (blowup owner), then Resolution · AsymptoticPositivity · IntersectionTheory · CoherentDuality |
| NumericalDimension (29.0k, 036) | #545 L1–L3 and SingularitiesOfPairs; reconcile with #545 before either proceeds |
| LogKodaira (4.6k), SectionFields (5.1k), CartierSections (3.4k) | SingularitiesOfPairs, AsymptoticPositivity |
| PlaneCurves (37.0k, 039); RelativeTriviality (4.6k, 067) | GeometryOfCurves, IntersectionTheory; HilbertQuot |
| CharacterVarieties (29.6k, 027); SurfaceCones (44.4k, 195); Stability (0.6k, 055) | GIT; AlgebraicSurfaces; DerivedCategories |
| Geometry/KahlerSplitting (15.0k), SplitTangent (32.0k), QuadricBundles (12.3k) (050, 052) | KahlerManifolds; RationalCurves; AsymptoticPositivity (ample bundles) |
| Geometry/Anticanonical (4.4k), HypersurfaceGerms (5.1k), Analysis/SymmetricDomains (50.9k) | ANA (#279, SCV), SingularityTheory, RealAlgebraicGeometry, NT ShimuraData D2 |
| AffineCancellation, CommutingDerivations, AbhyankarSathaye (9.2k, 047, 049) | ALG LocallyNilpotentDerivations |


### 3.2 Promotion units (campaign roadmaps consolidated for TauCetiRoadmap)

Each unit is one TauCetiRoadmap roadmap condensed from campaign READMEs and blueprints under coordination §4.6 (drift check, 40–90 KB README, building `Suggested.lean`); scopes and prerequisites are in `slate_AG.json`.

| # | Unit | Lane | Size (PRs) | Wave | Direct demand | Content |
|---|---|---|---|---|---|---|
| P1 | EtaleDualityAndPerverseSheaves | cohomology | L (250) | B | 5 rows: Annals #3, #16, #41; OAI #014, #043 | Exceptional inverse image, Verdier duality, smooth traces, relative purity and Poincaré duality for ℓ-adic and torsion étale sheaves on … |
| P2 | LefschetzPencilsAndVanishingCycles | cohomology | L (250) | B | 4 rows: Annals #41; OAI #059, #064 | Nearby and vanishing cycles for étale sheaves over henselian traits, inertia and the monodromy operator … |
| P3 | WeilConjecturesAndWeights | cohomology | XL (400) | C | 0 direct rows | Rationality and functional equation of zeta functions from TraceFormula and Poincaré duality … |
| P4 | MotivesAndAlgebraicCycles | cohomology | L (250) | C | 6 rows: Annals #14, #33, #59; OAI #001, #032 | Adequate equivalence relations, pure Chow and numerical motives with Tate twists, realizations and compatibility of cycle classes … |
| P5 | FormalAndRigidAnalyticGeometry | p-adic | XL (350) | A | 3 rows: Annals #34, #38 | Formal schemes, Spf, formal completion, the theorem on formal functions and formal GAGA (wave A) … |
| P6 | EtaleCohomologyOfAdicSpaces | p-adic | L (250) | C | 1 row: OAI #001 | Huber's étale cohomology of analytic adic spaces: étale sheaves, direct images, nearby cycles from formal models … |
| P7 | PerfectoidSpacesAndDiamonds | p-adic | XL (400) | A | 6 rows: Annals #27; OAI #001, #193, #194, #311, #313 | Perfectoid rings and fields, tilting and untilting, almost mathematics and almost purity … |
| P8 | SixOperationsForDiamonds | p-adic | XL (450) | C | 0 direct rows | Étale sheaves on diamonds and small v-stacks with the four and then six operations, proper base change … |
| P9 | FarguesFontaineCurve | p-adic | XL (400) | C | 2 rows: OAI #311, #313 | The Fargues–Fontaine curve as an adic space (from AdicSpaces L6) and as a diamond, its relative version over perfectoid bases … |
| P10 | CrystallineCohomology | p-adic | L (300) | A | 2 rows: Annals #46; OAI #001 | Divided-power envelopes, the crystalline site, crystals, crystalline cohomology with base change, finiteness and Frobenius … |
| P11 | RigidCohomologyAndPadicDifferentialEquations | p-adic | L (250) | B | 0 direct rows | Dagger algebras, Robba rings, p-adic differential modules and Frobenius slopes, local monodromy and the p-adic local monodromy theorem … |
| P12 | PrismaticCohomology | p-adic | XL family (700) | B | 3 rows: Annals #46, #51 | Family of two sub-roadmaps: (i) cotangent complex, derived de Rham cohomology and quasisyntomic descent; (ii) δ-rings and prisms (wave A) … |
| P13 | HabiroCohomology | p-adic | XL family (600) | A | 0 direct rows | Cyclotomic completions and classical Habiro rings (wave A, distance 2), relative Habiro rings of étale algebras with Frobenius lifts and … |
| P14 | BerkovichAndTropicalGeometry | p-adic | L (250) | A | 3 rows: Annals #47, #24 (NT part); OAI #019 | Berkovich spectra and analytification, the Berkovich line and its point types, discs, annuli and metric trees … |
| P15 | BruhatTitsTheory | foundations | L (250) | B | 6 rows: Annals #23, #26, #43; OAI #014, #018 | Reductive groups over nonarchimedean local fields: relative roots and Tits indices, valued root data, the Bruhat–Tits building … |

## 4. Needs not absorbed

Every AG `gap` row maps to a slate roadmap except these:

| Need (ref) | Reason |
|---|---|
| motivic SH(k), Chow t-structure (Annals #78) | TOP MotivicHomotopyTheory |
| Hilbert modular surface invariants (LMFDB hmsurface) | NT HilbertModularSurfaces, on AlgebraicSurfaces |
| hgcwa family labels and passports | NT LMFDBLabelsAndCompleteness |
| Saito's Hodge modules (OAI #034) | frontier; successor of AlgebraicDModules + VHS |
| char-p threefold MMP (OAI #035), Kähler MMP (OAI #056) | frontier |
| scattering diagrams (OAI #169) | frontier (GHKK); no supplier anywhere |
| fundamental theorem of projective geometry (OAI #009) | NT BirationalAnabelianGeometry (small) |
| restricted geometric Langlands (OAI #014) | frontier (NT) |

Statements only: nonabelian Hodge and P = W (OAI #043, #057, #058) in ModuliOfSheavesAndHiggsBundles; Beauville–Bogomolov (OAI #041, #062) in K3AndHyperkahler, its holonomy input unowned (GEO). Elsewhere or frontier: BFN Coulomb branches (#044, ALG), D-modules on Bun_G (#069), high-dimensional fibred links (#059, TOP), Kudla–Millson lifts (#032, NT). Small orphans placed: Albert classification (Annals #1) in AbelianVarieties, Torelli (#17) in GeometryOfCurves, Moy–Prasad (#23) in P15, arc topology (#35) in AlgebraicSpaces.

## 5. Cross-campaign interface

**Imports.**
- ANA: SeveralComplexVariables for ComplexAnalyticSpaces, SingularityTheory, KahlerManifolds; #279, #280; PositiveCurrentsAndMongeAmpere compares its multiplier ideals with VanishingTheorems'.
- GEO: EllipticOperatorsOnManifolds (Hodge theorem) for KahlerManifolds; Yau's theorem for K3; Berger holonomy (unowned).
- TOP: TopologicalSixOperations (locally compact spaces, Verdier duality) for PerverseSheaves, Microlocal, D-modules; ClassifyingSpaces #437 extended to compact Lie groups for EquivariantCohomology; DGAInfinity, EnhancedDerivedSheaves for DG enhancements.
- ALG: LieHighestWeight, quivers (GIT, FlagVarieties); CohenMacaulayRings, MultiplicitiesAndIntersections (IntersectionTheory, VanishingTheorems); ChevalleyGroups #447.
- NT: ShimuraData D2 (ball quotients for OAI #046, #058); LocalFieldsRamification (P15); PadicHodgeTheory (P12).

**Exports.**
- NT: IntersectionTheory (Arakelov), AbelianVarieties (over finite fields, Faltings, Néron, CM), GeometryOfCurves (HyperellipticCurves, modular-curve gonality, hgcwa), stacks and HilbertQuot (Shimura, PEL), MumfordTateGroups and VHS (ShimuraData D1, D3), AlgebraicSurfaces (Hilbert modular surfaces), ToricVarieties (toroidal compactifications), AffineGrassmannians (GS0, ET.2b), Hitchin base and HN formalism (ET.2b, Bun_G), #196 and P1–P3 (Weil bounds), the p-adic lane.
- ALG: FlagVarieties and D-modules (Beilinson–Bernstein), PerverseSheaves (Springer, Kazhdan–Lusztig), #196 (Deligne–Lusztig), GIT.
- GEO: KahlerManifolds (KE/cscK/CY metrics, Kähler cuts), K3, MicrolocalSheafTheory, GromovWittenTheory (vs PseudoholomorphicCurveModuli).
- LTCS: GIT, FlagVarieties (border rank, orbit closures); RealAlgebraicGeometry (o-minimality). COMB: ToricVarieties, IntersectionTheory (Bézout), P14 (tropical).

## 6. Order and people

**Actions before drafting:** adopt #196; review and merge #545 after the `NumericalDimension` reconciliation; ask ANA to land #279. Draft each family's umbrella README before its first member, so that internal boundaries are fixed once.

**First five drafts** (demand × unblocking):
1. **IntersectionTheory**: 12 refs (Annals #12, #33; ten OpenAI families), supplier to ten slate roadmaps, P4 and NT's Arakelov theory; wave A; AlgebraicVectorBundles names it as successor.
2. **ResolutionOfSingularities**: 12 refs (Annals #42; eleven OpenAI families); every birational roadmap and VHS use log resolutions; wave A; promotes R09.7.
3. **HilbertQuotAndPicardSchemes**: base of ModuliTheory, Hom schemes for RationalCurves, Pic for AbelianVarieties; the campaign stages it replaces are named by 27 rows; wave A.
4. **SingularitiesOfPairs**: 12 refs (Annals #7, #18, #48, #50; eight OpenAI families), statement-level and highly formalizable; on #545, with lookahead on stubs while #545 is open.
5. **AlgebraicSpaces**, then AlgebraicStacks: Annals #6, #35 and every moduli consumer in AG and NT; wave A.

Next: AsymptoticPositivity, KahlerManifolds (after #279), CoherentDuality, MumfordTateGroups, GeometryOfCurves.

**People.** A lead fluent in moduli/stacks and birational geometry who knows Mathlib's AlgebraicGeometry tree. Reviewers per family: birational (Kollár–Mori, BCHM, K-stability), moduli (Stacks Project, Alper), Hodge and complex (Voisin, Grauert–Remmert), sheaves (Kashiwara–Schapira, BBD), ℓ-adic (SGA 4½, Weil II; CBirkbeck and kim-em already review #196), p-adic (Birkbeck's campaign); plus a Lean reviewer from the JacobianChallenge/StableReduction implementers to catch parallel carriers.

**Open questions for the owner.**
1. The 17 arithmetic math.AG-primary campaign roadmaps and AbelianSchemes A6 are planned as NT; AbelianSchemes A0–A5 as AG (AbelianVarieties). The NT planner must agree.
2. TopologicalSixOperations is planned as TOP's (prerequisite-theory rule); AG takes it if TOP declines.
3. Bruhat–Tits theory (P15): AG per coordination §3.3, or ALG (math.GR)?
4. Habiro: P13 holds three; HabiroNahmSeries and HabiroNumberFields stay NT. Coordination §3.3 says keep all five together; that would file NT content under math.AG.
5. Who adopts #196, and in which form.
6. GEO's KahlerGeometry (Annals 52–100 P12) is folded into KahlerManifolds; GEO keeps the metric PDE. To confirm with GEO.
7. Families: the plan assumes each sub-roadmap still needs its own review, the umbrella review fixing boundaries.

## 7. Totals

| | roadmaps | L | XL (single, 350–450) | M | XL family | est. PRs |
|---|---|---|---|---|---|---|
| New (§3.1) | 35 (24 in 4 families + 11 standalone) | 31 | 3 | 1 | 4 umbrellas | ≈ 9,010 |
| Promotion units (§3.2) | 15 (replace 34 campaign roadmaps) | 8 | 5 | 0 | 2 | ≈ 5,350 |
| **Total** | **50** | 39 | 8 | 1 | 6 | **≈ 14,360** |

Waves of the new roadmaps: A 10, B 18, C 7. **Existing supply in the territory:** ≈1,780 PRs left on the nine AG roadmaps on main (ReductiveGroups 600, StableReduction 310, AdicSpaces 230, AlgebraicVectorBundles 220, BelyiMaps 200, JacobianChallenge 120, three others 110), ≈600 in #196 and ≈110 in #545; the 34 campaign roadmaps taken here are ≈2,900 PR-equivalents at snapshot size (the same material the promotion units expand).
