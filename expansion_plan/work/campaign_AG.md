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

## 8. References by roadmap

54 roadmap records, 638 listings, 488 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_AG.json` and the `references` fields of `slate_AG.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (298 of 488: zbMATH stopped early; see master (d)). A title is given at a work's first citation in this section only. Pointers are the compilers' and are unverified.

**Conventions and notes.** Hodge family: the Completed/HodgeStructures signs (Q(y,x) = (−1)^n Q(x,y), i^{p−q}Q(v,v̄) > 0, cup-product factor (−1)^{n(n−1)/2}) and Deligne's Corvallis convention h(z)|V^{p,q} = z^{−p}z̄^{−q} (Hodge II uses the opposite sign). Intersection theory: Chow groups graded by dimension, s(E) = c(E)^{−1} (Fulton), P(E) = Proj Sym E (EGA/Stacks); Fulton's line-convention formulas transported through E ↦ E^∨. Birational family: Kollár–Mori §2.3 discrepancies as in #545, log discrepancy A = a + 1. Sheaf family: BBD perversity (L[d] perverse on smooth X of dimension d), DR(M) = Ω ⊗ M[d_X] (Hotta–Takeuchi–Tanisaki). Moduli family: the Stacks Project's definitions of algebraic spaces and stacks. Promotion units list what their member READMEs cite, plus a primary marked "added" where they name none. Stacks tags are given only where an existing README cites them; the restriction-of-scalars tag (05YC/05YF vs 05Y8) is unresolved (master (d6)).

**ModuliTheory** (umbrella, wave A)
- primary: Stacks Project 2026, *Stacks Project*; Olsson 2016, *Algebraic Spaces and Stacks*; Laumon–Moret-Bailly 2000, *Champs algébriques*; Fantechi et al. 2005, *Fundamental Algebraic Geometry*; Mumford–Fogarty–Kirwan 1994, *Geometric Invariant Theory*; Alper 2025, *Stacks and Moduli* (?)

**AlgebraicSpaces** (wave A)
- primary: Stacks Project 2026; Olsson 2016; Vistoli 2005, *Grothendieck topologies, fibered…*
- theorem: Knutson 1971, *Algebraic Spaces*; Grothendieck–Raynaud 1971, *Revêtements étales et groupe…*, Exp. VIII; Bosch–Lütkebohmert–Raynaud 1990, *Néron Models*, Ch. 6, §7.6; Artin 1974, *Versal deformations and algebraic stacks*; Grothendieck 1968, *Le groupe de Brauer III*, §11; Milne 1980, *Étale Cohomology*, Ch. II–III; Milne 2006, *Arithmetic Duality Theorems*, Ch. III; Bhatt–Mathew 2021, *Arc-topology*; Rydh 2010, *Submersions and effective descent of…*
- formal: Mathlib `AlgebraicGeometry/Sites`; Mathlib `CategoryTheory/Sites/Descent`; Mathlib `AlgebraicGeometry/Morphisms`; Tau Ceti `AlgebraicGeometry/Quotient`

**AlgebraicStacks** (wave B)
- primary: Stacks Project 2026; Olsson 2016; Laumon–Moret-Bailly 2000; Alper 2025 (?)
- theorem: Deligne–Mumford 1969, *Irreducibility of the space of curves…* (?); Artin 1974; Keel–Mori 1997, *Quotients by groupoids*; Conrad 2005, *Keel–Mori theorem via stacks* (?); Abramovich–Corti–Vistoli 2003, *Twisted bundles and admissible covers*; Behrend 1993, *Lefschetz trace formula for algebraic…* (?); Lang 1956, *Algebraic groups over finite fields* (?)
- formal: Mathlib `CategoryTheory/Sites/Descent`

**HilbertQuotAndPicardSchemes** (wave A)
- primary: Fantechi et al. 2005; Sernesi 2006, *Deformations of Algebraic Schemes*; Kollár 1996, *Rational Curves on Algebraic Varieties*, Ch. I–II
- conventions: Grothendieck–Dieudonné 1960, *Éléments de géométrie algébrique I–IV*, §4 (?); Stacks Project 2026
- theorem: Grothendieck 1961, *Techniques de construction et théorèmes…* (?); Mumford 1966, *Curves on an Algebraic Surface*; Kleiman 2005, *Picard scheme*; Berthelot et al. 1971, *Théorie des intersections et théorème…*, Exp. XIII (?); Fogarty 1968, *Algebraic families on an algebraic…*; Schlessinger 1968, *Functors of Artin rings*; Artin 1969, *Algebraization of formal moduli I*; Bosch–Lütkebohmert–Raynaud 1990, Ch. 8; Huybrechts–Lehn 2010, *Geometry of Moduli Spaces of Sheaves*, §2.2
- formal: Mathlib `AlgebraicGeometry/ProjectiveSpectrum`; Tau Ceti `AlgebraicGeometry/PicardFunctor`; Tau Ceti `AlgebraicGeometry/VectorBundle`; OAI `AlgebraicGeometry/RelativeTriviality`

**GeometricInvariantTheory** (wave A)
- primary: Mumford–Fogarty–Kirwan 1994; Dolgachev 2003, *Invariant Theory* (?); Mukai 2003, *Invariants and Moduli* (?)
- theorem: Hilbert 1890, *Über die Theorie der algebraischen…* (?); Nagata 1964, *Invariants of a group in an affine ring* (?); Seshadri 1977, *Geometric reductivity over arbitrary…* (?); Kempf–Ness 1979, *Length of vectors in representation…* (?); King 1994, *Moduli of representations of finite…* (?); Nakajima 1994, *Instantons on ALE spaces, quiver…* (?); Ginzburg 2012, *Nakajima's quiver varieties*; Procesi 1976, *Invariant theory of n×n matrices* (?); Donkin 1992, *Invariants of several matrices* (?); Lubotzky–Magid 1985, *Varieties of representations of…* (?); Alper 2013, *Good moduli spaces for Artin stacks*; Alper–Hall–Rydh 2020, *Luna étale slice theorem for algebraic…*
- statement: Haboush 1975, *Reductive groups are geometrically…* (?)
- formal: OAI `AlgebraicGeometry/CharacterVarieties`; Tau Ceti `AlgebraicGeometry/AffineGroupScheme/Reductive`

**ModuliOfCurvesAndStableMaps** (wave B)
- primary: Arbarello–Cornalba–Griffiths 2011, *Geometry of Algebraic Curves II* (?); Harris–Morrison 1998, *Moduli of Curves* (?); Stacks Project 2026
- theorem: Deligne–Mumford 1969 (?); Knudsen 1983, *Projectivity of the moduli space of… II*; Behrend–Manin 1996, *Stacks of stable maps and Gromov–Witten…*; Fulton–Pandharipande 1997, *Stable maps and quantum cohomology*; Keel 1992, *Intersection theory of moduli space of…* (?); Mumford 1983, *Towards an enumerative geometry of the…* (?); Arbarello–Cornalba 1996, *Combinatorial and algebro-geometric…* (?); Kollár 1990, *Projectivity of complete moduli* (?)
- statement: Pandharipande–Pixton–Zvonkine 2015, *Relations on M̄_{g,n} via 3-spin…*
- formal: Tau Ceti `AlgebraicGeometry/Curves/StableReduction`

**ModuliOfSheavesAndHiggsBundles** (wave B)
- primary: Huybrechts–Lehn 2010, Ch. 3; Le Potier 1997, *Vector Bundles* (?)
- theorem: Rudakov 1997, *Stability for an abelian category* (?); André 2009, *Slope filtrations* (?); Okonek–Schneider–Spindler 1980, *Vector Bundles on Complex Projective…* (?); Hitchin 1987, *Self-duality equations on a Riemann…* (?); Hitchin 1987, *Stable bundles and integrable systems* (?); Nitsure 1991, *Moduli space of semistable pairs on a…* (?); Beauville–Narasimhan–Ramanan 1989, *Spectral curves and the generalised…* (?)
- statement: Narasimhan–Seshadri 1965, *Stable and unitary vector bundles on a…* (?); Simpson 1992, *Higgs bundles and local systems* (?); Simpson 1994, *Moduli of representations of the… II* (?); de Cataldo–Hausel–Migliorini 2012, *Topology of Hitchin systems and Hodge…* (?); Maulik–Shen 2022, *P = W conjecture for GL_n*; Hausel et al. 2022, *P = W via H_2*

**BirationalGeometry** (umbrella, wave A)
- primary: Kollár–Mori 1998, *Birational Geometry of Algebraic…*, §2.3 (?); Lazarsfeld 2004, *Positivity in Algebraic Geometry I* (?); Lazarsfeld 2004, *Positivity in Algebraic Geometry II* (?); Kollár 2013, *Singularities of the Minimal Model…* (?); Fujino 2017, *Foundations of the Minimal Model Program* (?); Debarre 2001, *Higher-Dimensional Algebraic Geometry* (?); Debarre n.d., *Higher-dimensional algebraic geometry…*, Ch. 2–4 (?)
- conventions: Jonsson–Mustață 2012, *Valuations and asymptotic invariants…*

**ResolutionOfSingularities** (wave A)
- primary: Kollár 2007, *Resolution of Singularities*; Cutkosky 2004, *Resolution of Singularities* (?)
- theorem: Hironaka 1964, *Resolution of singularities of an… II* (?); Bierstone–Milman 1997, *Canonical desingularization in…* (?); Włodarczyk 2005, *Simple Hironaka resolution in…*; Kempf et al. 1973, *Toroidal Embeddings I* (?); de Jong 1996, *Smoothness, semi-stability and…* (?); Abramovich et al. 2002, *Torification and factorization of…*; Włodarczyk 2003, *Toroidal varieties and the weak…* (?)
- formal: OAI `AlgebraicGeometry/Seshadri`; Tau Ceti `AlgebraicGeometry/Blowup`; Mathlib `AlgebraicGeometry`

**SingularitiesOfPairs** (wave B)
- primary: Kollár–Mori 1998, Ch. 2, §2.3, Ch. 5 (?); Kollár 2013 (?); Lazarsfeld 2004, Ch. 9 (?)
- conventions: Mascharak 2026, *AbundanceStatement roadmap…*; Fujino 2004, *Higher direct images of log canonical…* (?)
- theorem: Kollár 1997, *Singularities of pairs*; Corti 2007, *Flips for 3-folds and 4-folds* (?); Birkar–Zhang 2016, *Effectivity of Iitaka fibrations and…*; Jonsson–Mustață 2012; Boucksom et al. 2015, *Valuation spaces and multiplier ideals…* (?); Li 2018, *Minimizing normalized volumes of…*
- formal: OAI `AlgebraicGeometry/NumericalDimension`; OAI `AlgebraicGeometry/CartierSections`; OAI `AlgebraicGeometry/LogKodaira`; Tau Ceti `AlgebraicGeometry/WeilDivisor`; Tau Ceti `AlgebraicGeometry/AdicSpace`

**AsymptoticPositivity** (wave B)
- primary: Lazarsfeld 2004, Ch. 2, Ch. 5 (?); Lazarsfeld 2004, Ch. 6–7 (?)
- theorem: Ueno 1975, *Classification Theory of Algebraic…* (?); Nakayama 2004, *Zariski-Decomposition and Abundance* (?); Ein et al. 2006, *Asymptotic invariants of base loci* (?); Zariski 1962, *Theorem of Riemann–Roch for high…* (?); Fujita 1994, *Approximating Zariski decomposition of…* (?); Lazarsfeld–Mustață 2009, *Convex bodies associated to linear…*; Kaveh–Khovanskii 2012, *Newton–Okounkov bodies, semigroups of…* (?); Campana 2004, *Orbifolds, special varieties and…* (?); Blum–Jonsson 2020, *Thresholds, valuations, and K-stability*; Jouanolou 1983, *Théorèmes de Bertini et applications* (?); Hartshorne 1977, *Algebraic Geometry*
- statement: Nagata 1959, *14-th problem of Hilbert* (?)
- formal: OAI `AlgebraicGeometry/Seshadri`; OAI `AlgebraicGeometry/SectionFields`; OAI `Geometry/QuadricBundles`

**VanishingTheorems** (wave B)
- primary: Esnault–Viehweg 1992, *Vanishing Theorems* (?); Lazarsfeld 2004, Ch. 4 (?); Lazarsfeld 2004, Ch. 9 (?)
- theorem: Kollár–Mori 1998, Ch. 2, Ch. 5 (?); Deligne–Illusie 1987, *Relèvements modulo p² et décomposition…* (?); Illusie 2002, *Frobenius and Hodge degeneration* (?); Kawamata 1982, *Generalization of Kodaira–Ramanujam's…* (?); Viehweg 1982, *Vanishing theorems* (?); Kollár 1986, *Higher direct images of dualizing… I* (?); Grauert–Riemenschneider 1970, *Verschwindungssätze für analytische…* (?); Reider 1988, *Vector bundles of rank 2 and linear…* (?); Raynaud 1978, *Contre-exemple au « vanishing theorem »…* (?)
- statement: Angehrn–Siu 1995, *Effective freeness and point separation…* (?)
- formal: Mathlib `AlgebraicGeometry/SpreadingOut`; Mathlib `RingTheory/DividedPowers`; Tau Ceti `AlgebraicGeometry/Cohomology`

**MinimalModelProgram** (wave C)
- primary: Kollár–Mori 1998, Ch. 1, Ch. 3, Ch. 6–7 (?); Fujino 2017 (?)
- theorem: Kawamata–Matsuda–Matsuki 1987, *Minimal model problem* (?); Birkar et al. 2010, *Existence of minimal models for…*; Corti 2007 (?); Mori 1988, *Flip theorem and the existence of…* (?); Kollár 1992, *Flips and Abundance for Algebraic…* (?); Kawamata 1998, *Subadjunction of log canonical divisors… II* (?); Fujino–Mori 2000, *Canonical bundle formula* (?); Ambro 2005, *Moduli b-divisor of an lc-trivial…* (?)
- statement: Birkar 2019, *Anti-pluricanonical systems on Fano…*; Birkar 2021, *Singularities of linear systems and…*

**RationalCurvesAndFanoVarieties** (wave B)
- primary: Kollár 1996, Ch. II–V; Debarre 2001 (?)
- theorem: Mori 1979, *Projective manifolds with ample tangent…* (?); Mori 1982, *Threefolds whose canonical bundles are…* (?); Miyaoka–Mori 1986, *Numerical criterion for uniruledness* (?); Kollár–Miyaoka–Mori 1992, *Rationally connected varieties* (?); Kollár–Miyaoka–Mori 1992, *Rational connectedness and boundedness…* (?); Campana 1992, *Connexité rationnelle des variétés de…* (?); Graber–Harris–Starr 2003, *Families of rationally connected…*; Cho–Miyaoka–Shepherd-Barron 2002, *Characterizations of projective space…* (?); Kebekus 2002, *Characterizing the projective space…* (?); Hwang 2001, *Geometry of minimal rational curves on…* (?); Kebekus et al. 2000, *Projective contact manifolds* (?)
- formal: OAI `Geometry/SplitTangent`

**KStabilityOfFanoVarieties** (wave C)
- primary: Xu 2021, *K-stability of Fano varieties*
- theorem: Tian 1997, *Kähler–Einstein metrics with positive…* (?); Donaldson 2002, *Scalar curvature and stability of toric…* (?); Fujita 2019, *Valuative criterion for uniform…*; Li 2017, *K-semistability is equivariant volume…*; Blum–Jonsson 2020; Li–Xu 2014, *Special test configuration and…* (?); Odaka 2013, *GIT stability of polarized varieties…* (?); Wang–Zhu 2004, *Kähler–Ricci solitons on toric…* (?)

**HodgeTheory** (umbrella, wave A)
- primary: Voisin 2002, *Hodge Theory and Complex Algebraic… I* (?); Voisin 2003, *Hodge Theory and Complex Algebraic… II* (?); Griffiths–Harris 1978, *Principles of Algebraic Geometry* (?); Huybrechts 2005, *Complex Geometry* (?); Peters–Steenbrink 2008, *Mixed Hodge Structures* (?); Carlson–Müller-Stach–Peters 2017, *Period Mappings and Period Domains* (?)
- conventions: Tau Ceti 2026, *Completed/HodgeStructures roadmap README*; Deligne 1979, *Variétés de Shimura*
- formal: Tau Ceti `Geometry/Hodge`

**ComplexAnalyticSpaces** (wave B)
- primary: Grauert–Remmert 1984, *Coherent Analytic Sheaves* (?); Fischer 1976, *Complex Analytic Geometry* (?); Neeman 2007, *Algebraic and Analytic Geometry* (?)
- theorem: Serre 1956, *Géométrie algébrique et géométrie…*; Grothendieck–Raynaud 1971, Exp. XII; Remmert 1957, *Holomorphe und meromorphe Abbildungen…* (?); Remmert–Stein 1953, *Über die wesentlichen Singularitäten…* (?); Grauert 1960, *Ein Theorem der analytischen…* (?); Chow 1949, *Compact complex analytic varieties* (?); Artin 1970, *Algebraization of formal moduli II* (?); Ueno 1975 (?); Douady 1966, *Le problème des modules pour les…* (?); Fujiki 1978, *Closedness of the Douady spaces of…* (?)
- formal: OAI `Geometry/HypersurfaceGerms`

**KahlerManifolds** (wave B)
- primary: Griffiths–Harris 1978, Ch. 0–1 (?); Huybrechts 2005 (?); Voisin 2002 (?); Demailly 2012, *Complex Analytic and Differential…* (?)
- conventions: Tau Ceti 2026
- theorem: Kobayashi 1987, *Differential Geometry of Complex Vector…* (?); Deligne et al. 1975, *Real homotopy theory of Kähler manifolds* (?); Kodaira 1953, *Differential-geometric method in the…* (?); Kodaira 1954, *Kähler varieties of restricted type (an…* (?)
- formal: Tau Ceti `Geometry/Hodge`; Mathlib `Geometry/Manifold/Complex`; OAI `Geometry/KahlerSplitting`; OAI `Geometry/QuadricBundles`; OAI `Geometry/SplitTangent`; OAI `Geometry/Anticanonical`

**HodgeTheoryOfAlgebraicVarieties** (wave C)
- primary: Voisin 2002 (?); Voisin 2003 (?); Peters–Steenbrink 2008 (?)
- theorem: Grothendieck 1966, *De Rham cohomology of algebraic…* (?); Hartshorne 1975, *De Rham cohomology of algebraic…* (?); Deligne 1971, *Théorie de Hodge II*; Deligne 1974, *Théorie de Hodge III* (?); Guillén et al. 1988, *Hyperrésolutions cubiques et descente…* (?); Griffiths 1969, *Periods of certain rational integrals… II* (?); Deligne et al. 1982, *Hodge Cycles, Motives, and Shimura…* (?); van Geemen 1994, *Hodge conjecture for abelian varieties* (?)
- statement: Deligne 2006, *Hodge conjecture* (?)
- formal: Tau Ceti `Geometry/Hodge`; Tau Ceti `AlgebraicGeometry/AbelianVariety`

**VariationsOfHodgeStructure** (wave C)
- primary: Carlson–Müller-Stach–Peters 2017 (?); Voisin 2003 (?)
- conventions: Tau Ceti 2026
- theorem: Griffiths 1968, *Periods of integrals on algebraic… II* (?); Griffiths–Schmid 1969, *Locally homogeneous complex manifolds* (?); Deligne 1970, *Équations différentielles à points…* (?); Katz–Oda 1968, *Differentiation of de Rham cohomology…* (?); Deligne 1971, §4; Schmid 1973, *Variation of Hodge structure* (?); Landman 1973, *Picard–Lefschetz transformation for…* (?); Fujita 1978, *Kähler fiber spaces over curves* (?); Viehweg 1983, *Weak positivity and the additivity of…* (?)
- formal: Tau Ceti `Geometry/Hodge`

**MumfordTateGroups** (wave A)
- primary: Moonen 2004, *Mumford–Tate groups* (?); Green–Griffiths–Kerr 2012, *Mumford–Tate Groups and Domains* (?)
- conventions: Deligne 1979; Milne 2005, *Shimura varieties*
- theorem: Mumford 1966, *Families of abelian varieties* (?); Deligne et al. 1982 (?); Cattani–Deligne–Kaplan 1995, *Locus of Hodge classes* (?)
- formal: Tau Ceti `Geometry/Hodge`; Tau Ceti `CategoryTheory/Action/Tannaka`; `thebookersmith/pure-hodge-structures-lean4`; leanprover-community/mathlib4 PR #40975

**K3AndHyperkahlerManifolds** (wave C)
- primary: Huybrechts 2016, *K3 Surfaces*, Ch. 4 (?); Barth et al. 2004, *Compact Complex Surfaces*, Ch. VIII (?); Gross–Huybrechts–Joyce 2003, *Calabi–Yau Manifolds and Related…* (?)
- theorem: Piatetski-Shapiro–Shafarevich 1971, *Torelli theorem for algebraic surfaces…* (?); Burns–Rapoport 1975, *Torelli problem for kählerian K-3…* (?); Looijenga–Peters 1981, *Torelli theorems for Kähler K3 surfaces* (?); Siu 1983, *Every K3 surface is Kähler* (?); Todorov 1980, *Applications of the…* (?); Kuga–Satake 1967, *Abelian varieties attached to polarized…* (?); Deligne 1972, *La conjecture de Weil pour les surfaces…* (?); Beauville 1983, *Variétés kähleriennes dont la première…* (?); Fujiki 1987, *De Rham cohomology group of a compact…* (?); Matsushita 1999, *Fibre space structures of a projective…* (?); Beauville–Donagi 1985, *La variété des droites d'une…* (?); Hassett 2000, *Special cubic fourfolds* (?); Huybrechts 2023, *Geometry of Cubic Hypersurfaces* (?)

**SheafTheory** (umbrella, wave A)
- primary: Kashiwara–Schapira 1990, *Sheaves on Manifolds* (?); Stacks Project 2026; Huybrechts 2006, *Fourier–Mukai Transforms in Algebraic…* (?); Dimca 2004, *Sheaves in Topology* (?)
- conventions: Beilinson–Bernstein–Deligne 1982, *Faisceaux pervers*; Hotta–Takeuchi–Tanisaki 2008, *D-Modules, Perverse Sheaves, and…* (?)

**CoherentDuality** (wave A)
- primary: Stacks Project 2026; Hartshorne 1966, *Residues and Duality* (?); Lipman 2009, *Derived functors and Grothendieck…* (?)
- theorem: Conrad 2000, *Grothendieck Duality and Base Change* (?); Neeman 1996, *Grothendieck duality theorem via…* (?); Thomason–Trobaugh 1990, *Higher algebraic K-theory of schemes…*; Bondal–van den Bergh 2003, *Generators and representability of…* (?); Conrad 2007, *Deligne's notes on Nagata…* (?); Grothendieck–Dieudonné 1960, §3 (?); Hartshorne 1977
- formal: Mathlib `Algebra/Homology/DerivedCategory`; Tau Ceti `AlgebraicGeometry/Modules/Quasicoherent`; Tau Ceti `AlgebraicGeometry/Cohomology`; OAI `AlgebraicGeometry/Seshadri`

**DerivedCategoriesOfCoherentSheaves** (wave B)
- primary: Huybrechts 2006 (?); Macrì–Schmidt 2017, *Bridgeland stability*
- theorem: Bondal–Kapranov 1989, *Representable functors, Serre functors…* (?); Beilinson 1978, *Coherent sheaves on P^n and problems of…* (?); Mukai 1981, *Duality between D(X) and D(X̂) with its…* (?); Orlov 1997, *Equivalences of derived categories and…*; Bondal–Orlov 2001, *Reconstruction of a variety from the…*; Seidel–Thomas 2001, *Braid group actions on derived…*; Kuznetsov 2010, *Derived categories of cubic fourfolds*; Bridgeland 2007, *Stability conditions on triangulated…*; Bridgeland 2008, *Stability conditions on K3 surfaces*; Arcara–Bertram 2013, *Bridgeland-stable moduli spaces for…* (?)
- statement: Bayer–Macrì–Toda 2014, *Bridgeland stability conditions on… I*
- formal: Mathlib `Algebra/Homology/DerivedCategory`; OAI `AlgebraicGeometry/Stability`

**PerverseSheavesOnComplexVarieties** (wave B)
- primary: Beilinson–Bernstein–Deligne 1982, §6; Dimca 2004 (?); Kashiwara–Schapira 1990, Ch. VIII–X (?)
- theorem: Deligne 1977, *Cohomologie étale (SGA 4½)* (?); Goresky–MacPherson 1983, *Intersection homology II* (?); de Cataldo–Migliorini 2009, *Decomposition theorem, perverse sheaves…*; Katz 1996, *Rigid Local Systems* (?); Dettweiler–Reiter 2000, *Algorithm of Katz and its application…* (?)
- formal: Mathlib `Algebra/Homology/DerivedCategory`

**AlgebraicDModules** (wave B)
- primary: Hotta–Takeuchi–Tanisaki 2008 (?); Borel 1987, *Algebraic D-Modules* (?)
- theorem: Bernstein 1972, *Analytic continuation of generalized…* (?); Kashiwara 1976, *B-functions and holonomic systems* (?); Kashiwara 1984, *Riemann–Hilbert problem for holonomic…* (?); Mebkhout 1984, *Une autre équivalence de catégories* (?); Beilinson–Bernstein 1981, *Localisation de g-modules* (?)

**MicrolocalSheafTheory** (wave B)
- primary: Kashiwara–Schapira 1990, Ch. V–IX (?)
- theorem: Kashiwara–Schapira 1985, *Microlocal study of sheaves* (?); Guillermou 2023, *Sheaves and symplectic geometry of…*; Beilinson 2016, *Constructible sheaves are holonomic*
- formal: Mathlib `Algebra/Homology/DerivedCategory`

**IntersectionTheory** (wave A)
- primary: Fulton 1998, *Intersection Theory*, Ch. 1–8, Ch. 15 (?); Eisenbud–Harris 2016, *3264 and All That* (?); Stacks Project 2026
- conventions: Berthelot et al. 1971 (?)
- theorem: Borel–Serre 1958, *Le théorème de Riemann–Roch* (?); Hartshorne 1977, Ch. V, App. A; Kleiman 1966, *Toward a numerical theory of ampleness* (?); Vistoli 1989, *Intersection theory on algebraic stacks…* (?); Mumford 1968, *Rational equivalence of 0-cycles on…* (?)
- formal: Mathlib `AlgebraicGeometry/AlgebraicCycle`; Tau Ceti `AlgebraicGeometry/WeilDivisor`; Tau Ceti `AlgebraicGeometry/VectorBundle`; OAI `AlgebraicGeometry/Seshadri`; OAI `AlgebraicGeometry/PlaneCurves`

**EquivariantCohomologyAndLocalization** (wave B)
- primary: Anderson–Fulton 2023, *Equivariant Cohomology in Algebraic…* (?)
- theorem: Edidin–Graham 1998, *Equivariant intersection theory*; Edidin–Graham 1998, *Localization in equivariant…* (?); Atiyah–Bott 1984, *Moment map and equivariant cohomology* (?); Berline–Vergne 1982, *Classes caractéristiques équivariantes…* (?); Quillen 1971, *Spectrum of an equivariant cohomology… II* (?); Białynicki-Birula 1973, *Some theorems on actions of algebraic…* (?); Goresky–Kottwitz–MacPherson 1998, *Equivariant cohomology, Koszul duality…* (?); Brion 1998, *Equivariant cohomology and equivariant…*
- statement: Duistermaat–Heckman 1982, *Variation in the cohomology of the…* (?)

**GromovWittenTheory** (wave C)
- primary: Cox–Katz 1999, *Mirror Symmetry and Algebraic Geometry* (?); Fulton–Pandharipande 1997
- theorem: Behrend–Fantechi 1997, *Intrinsic normal cone*; Li–Tian 1998, *Virtual moduli cycles and Gromov–Witten…*; Behrend 1997, *Gromov–Witten invariants in algebraic…* (?); Manolache 2012, *Virtual pull-backs*; Graber–Pandharipande 1999, *Localization of virtual classes*; Kontsevich–Manin 1994, *Gromov–Witten classes, quantum…*; Kontsevich 1995, *Enumeration of rational curves via…*; Oprea–Pandharipande 2021, *Quot schemes of curves and surfaces*
- statement: Givental 2001, *Gromov–Witten invariants and…*; Eguchi–Hori–Xiong 1997, *Quantum cohomology and Virasoro algebra* (?)

**ToricVarieties** (wave A)
- primary: Cox–Little–Schenck 2011, *Toric Varieties*, Chs. 1–12 (?); Fulton 1993, *Toric Varieties* (?); Oda 1988, *Convex Bodies and Algebraic Geometry*, Ch. I (?)
- theorem: Demazure 1970, *Sous-groupes algébriques de rang…* (?); Kempf et al. 1973 (?); Danilov 1978, *Geometry of toric varieties* (?)
- formal: Tau Ceti `Geometry/Toric`; `YaelDillies/Toric`

**FlagVarieties** (wave A)
- primary: Jantzen 2003, *Representations of Algebraic Groups*, Part II (?); Brion–Kumar 2005, *Frobenius Splitting Methods in Geometry…* (?); Fulton 1997, *Young Tableaux* (?)
- theorem: Milne 2017, *Algebraic Groups* (?); Bott 1957, *Homogeneous vector bundles* (?); Demazure 1976, *Very simple proof of Bott's theorem* (?); Chevalley 1994, *Sur les décompositions cellulaires des…* (?); Beauville 1998, *Fano contact manifolds and nilpotent…* (?)
- statement: Ramanan–Ramanathan 1985, *Projective normality of flag varieties…* (?)
- formal: Tau Ceti `AlgebraicGeometry/AffineGroupScheme/Reductive`

**AffineGrassmannians** (wave C)
- primary: Zhu 2017, *Affine Grassmannians and the geometric…*; Baumann–Riche 2018, *Geometric Satake equivalence*
- theorem: Beauville–Laszlo 1995, *Un lemme de descente* (?); Beauville–Laszlo 1994, *Conformal blocks and generalized theta…* (?); Faltings 2003, *Algebraic loop groups and moduli spaces…* (?); Pappas–Rapoport 2008, *Twisted loop groups and their affine…*; Kazhdan–Lusztig 1988, *Fixed point varieties on affine flag…* (?); Lusztig 1983, *Singularities, character formulas, and…* (?); Ginzburg 1995, *Perverse sheaves on a loop group and…*; Mirković–Vilonen 2007, *Geometric Langlands duality and…*

**ReductiveGroupSchemes** (wave B)
- primary: Demazure–Grothendieck 1970, *Schémas en groupes (SGA 3)*, Exp. XIX–XXVI (?); Conrad 2014, *Reductive group schemes* (?); Milne 2017 (?)
- theorem: Bosch–Lütkebohmert–Raynaud 1990, §7.6; Stacks Project 2026; Deligne 1979
- formal: Tau Ceti `AlgebraicGeometry/AffineGroupScheme/Reductive`

**GeometryOfCurves** (wave A)
- primary: Arbarello et al. 1985, *Geometry of Algebraic Curves I* (?); Hartshorne 1977, Ch. IV; Fulton 2008, *Algebraic Curves*
- theorem: Stichtenoth 2009, *Algebraic Function Fields and Codes*, §I, §V; Saint-Donat 1973, *Petri's analysis of the linear system…* (?); Kleiman–Laksov 1972, *Existence of special divisors* (?); Igusa 1960, *Arithmetic variety of moduli for genus…*; Bolza 1887, *Binary sextics with linear…* (?); Breuer 2000, *Characters and Automorphism Groups of…* (?); Broughton 1991, *Classifying finite group actions on…* (?); Girondo–González-Diez 2012, *Compact Riemann Surfaces and Dessins…*; Forster 1981, *Riemann Surfaces*; Kani–Rosen 1989, *Idempotent relations and factors of…* (?); Birkenhake–Lange 2004, *Complex Abelian Varieties* (?); Andreotti 1958, *Theorem of Torelli* (?); Milne 2008, *Abelian Varieties*
- formal: OAI `AlgebraicGeometry/PlaneCurves`; Tau Ceti `FieldTheory/FunctionField`

**AbelianVarieties** (wave B)
- primary: Mumford 1974, *Abelian Varieties*; Milne 2008; Edixhoven–van der Geer–Moonen n.d., *Abelian Varieties*; Birkenhake–Lange 2004 (?)
- theorem: Mumford–Fogarty–Kirwan 1994, Ch. 6; Faltings–Chai 1990, *Degeneration of Abelian Varieties*, Ch. I; Mumford 1966, *Equations defining abelian varieties I* (?); Oort 1966, *Commutative Group Schemes* (?); Shimura 1998, *Abelian Varieties with Complex…* (?); Bosch–Lütkebohmert–Raynaud 1990, Ch. 8
- statement: Messing 1972, *Crystals Associated to Barsotti–Tate…* (?); Katz 1981, *Serre–Tate local moduli* (?)
- formal: Tau Ceti `AlgebraicGeometry/AbelianVariety`; Tau Ceti `AlgebraicGeometry/PicardFunctor`; Tau Ceti `Geometry/Hodge`

**SingularityTheory** (wave B)
- primary: Milnor 1968, *Singular Points of Complex Hypersurfaces* (?); Greuel–Lossen–Shustin 2007, *Singularities and Deformations* (?); Wall 2004, *Singular Points of Plane Curves* (?)
- theorem: Arnold–Gusein-Zade–Varchenko 1985, *Singularities of Differentiable Maps I… II* (?); Laufer 1971, *Normal Two-Dimensional Singularities* (?); Tráng–Ramanujam 1976, *Invariance of Milnor's number implies…* (?); Teissier 1973, *Cycles évanescents, sections planes et…* (?); Zariski 1965, *Studies in equisingularity I–III* (?); Whitney 1965, *Tangents to an analytic variety* (?); Mumford 1961, *Topology of normal singularities of an…* (?); Grauert 1962, *Über Modifikationen und exzeptionelle…* (?); Artin 1962, *Some numerical criteria for…* (?); Artin 1966, *Isolated rational singularities of…* (?); Artin 1969, *Algebraic approximation of structures…* (?)
- formal: OAI `Geometry/HypersurfaceGerms`

**AlgebraicSurfaces** (wave B)
- primary: Beauville 1996, *Complex Algebraic Surfaces* (?); Barth et al. 2004 (?); Bădescu 2001, *Algebraic Surfaces* (?)
- theorem: Hartshorne 1977, Ch. V; Mumford 1969, *Enriques' classification of surfaces in…* (?); Kodaira 1963, *Compact analytic surfaces II, III* (?); Hirzebruch 1983, *Arrangements of lines and algebraic…* (?); Buchdahl 1999, *Compact Kähler surfaces* (?); Lamari 1999, *Courants kählériens et surfaces…* (?)
- statement: Bombieri–Mumford 1977, *Enriques' classification of surfaces in… II* (?); Miyaoka 1977, *Chern numbers of surfaces of general…* (?); Yau 1977, *Calabi's conjecture and some new…* (?); Inoue 1974, *Surfaces of class VII_0* (?); Kato 1978, *Compact complex manifolds containing… I* (?)
- formal: OAI `AlgebraicGeometry/SurfaceCones`

**EtaleDualityAndPerverseSheaves** (promotion unit, wave B)
- primary: Artin–Grothendieck–Verdier 1972, *Théorie des topos et cohomologie étale…*, §§4–5, §§1–3 (?); Deligne 1977 (?); Beilinson–Bernstein–Deligne 1982, Ch. 1–2, Ch. 5
- theorem: Deligne–Katz 1973, *Groupes de monodromie en géométrie…*, §§1–4; Deligne 1974, *La conjecture de Weil I*, §2, §§2; Deligne 1980, *La conjecture de Weil II*
- formal: Mathlib `AlgebraicGeometry/Sites`; CBirkbeck/WeilConjectures (private Lean…

**LefschetzPencilsAndVanishingCycles** (promotion unit, wave B)
- primary: Deligne–Katz 1973, §§1–2, §§1–4, §6
- theorem: Grothendieck 1972, *Groupes de monodromie en géométrie…*, Exp. I (?); Deligne 1977 (?); Deligne 1974, §7.1, §5.8; Deligne 1980, §§1.6–1.7; Illusie 1994, *Autour du théorème de monodromie locale*; Beilinson–Bernstein–Deligne 1982; Huber 1996, *Étale Cohomology of Rigid Analytic…*, §§3.5
- formal: CBirkbeck/WeilConjectures (private Lean…

**WeilConjecturesAndWeights** (promotion unit, wave C)
- primary: Deligne 1974, §§2–3, Thm 3.2, Cor. 3.8; Deligne 1980, §§1–4; Freitag–Kiehl 1988, *Étale Cohomology and the Weil Conjecture* (?)
- theorem: Deligne 1977 (?); Deligne–Katz 1973; Artin–Grothendieck–Verdier 1972 (?); Milne 1980; Deligne 1969, *Formes modulaires et représentations…*, §3; Weil 1948, *Sur les courbes algébriques et les…* (?); Bombieri 1973, *Counting points on curves over finite…*
- formal: CBirkbeck/WeilConjectures (private Lean…

**MotivesAndAlgebraicCycles** (promotion unit, wave C)
- primary: Stacks Project 2026; André 2004, *Une introduction aux motifs (motifs…* (?); Murre–Nagel–Peters 2013, *Theory of Pure Motives* (?); Mazza–Voevodsky–Weibel 2006, *Motivic Cohomology*
- theorem: Jannsen 1992, *Motives, numerical equivalence, and…*; Huber–Müller-Stach 2014, *Relation between Nori motives and…*; Voevodsky 2002, *Motivic cohomology groups are…* (?); Bloch 1986, *Algebraic cycles and higher K-theory* (?); Elman–Karpenko–Merkurjev 2008, *Algebraic and Geometric Theory of…*, Part 3
- statement: Kleiman 1968, *Algebraic cycles and the Weil…* (?); Grothendieck 1969, *Standard conjectures on algebraic cycles* (?); Cisinski–Déglise 2019, *Triangulated Categories of Mixed Motives*; Kontsevich–Zagier 2001, *Periods* (?)

**FormalAndRigidAnalyticGeometry** (promotion unit, wave A)
- primary: Huber 1996; Huber 1994, *Generalization of formal schemes and…*; Grothendieck–Dieudonné 1960, §10, §§4–5 (?); Bosch 2014, *Formal and Rigid Geometry* (?)
- conventions: Wedhorn 2019, *Adic Spaces*
- theorem: Scholze 2017, *Étale cohomology of diamonds*, §§3; Kedlaya–Liu 2015, *Relative p-adic Hodge theory*; Kedlaya–Liu 2016, *Relative p-adic Hodge theory, II*; Fargues–Scholze 2021, *Geometrization of the local Langlands…*; Scholze 2013, *p-adic Hodge theory for rigid-analytic…*, Prop. 3.8; Bhatt–Morrow–Scholze 2018, *Integral p-adic Hodge theory*, §8; Kiehl 1967, *Der Endlichkeitssatz für eigentliche…* (?)
- formal: Tau Ceti `AlgebraicGeometry/AdicSpace`; `CBirkbeck/AINTLIB`; leanprover-community/mathlib4 PR #42312

**EtaleCohomologyOfAdicSpaces** (promotion unit, wave C)
- primary: Huber 1996, §§3.1–3.6, §4.2
- theorem: Scholze 2017, §§25; Scholze 2012, *Perfectoid spaces*; Lütkebohmert n.d., *work cited as [Lüt95, Theorem 5.3]…*, Theorem 5.3 (?)
- formal: Tau Ceti `AlgebraicGeometry/AdicSpace`

**PerfectoidSpacesAndDiamonds** (promotion unit, wave A)
- primary: Scholze 2012, §§3; Kedlaya–Liu 2015; Scholze 2017, §§2–15
- theorem: Fontaine 2013, *Perfectoïdes, presque pureté et…* (?); Gabber–Ramero 2003, *Almost Ring Theory*; Hochster 1969, *Prime ideal structure in commutative…* (?); Bhatt–Scholze 2022, *Prisms and prismatic cohomology*, §7; Hansen–Johansson 2025, *Perfectoid Shimura varieties and the…*, §5
- formal: Mathlib `RingTheory/Perfection`; leanprover-community/mathlib4 PR #42312; Buzzard–Commelin–Massot 2020, *Formalising perfectoid spaces*; `CBirkbeck/AINTLIB`

**SixOperationsForDiamonds** (promotion unit, wave C)
- primary: Scholze 2017, §§14–27, §§26–27; Fargues–Scholze 2021
- theorem: Clausen–Scholze 2019, *Condensed mathematics* (?); Scholze 2019, *Analytic Geometry* (?); Huber 1993, *Étale cohomology of Henselian rings and…* (?); Scheiderer 1992, *Quasi-augmented simplicial spaces, with…*, Cor. 4.6 (?); de Jong 1996 (?); Stacks Project 2026
- formal: Mathlib `Condensed`

**FarguesFontaineCurve** (promotion unit, wave C)
- primary: Fargues–Scholze 2021; Fargues–Fontaine 2018, *Courbes et fibrés vectoriels en théorie…*; Scholze–Weinstein 2020, *Berkeley Lectures on p-adic Geometry*, §6.3, §§11.2–11.3, §13.5
- theorem: Kedlaya–Liu 2015, §§5–8; Scholze 2017; Beauville–Laszlo 1995 (?); Manin 1963, *Theory of commutative formal groups…* (?)
- formal: Tau Ceti `AlgebraicGeometry/AdicSpace`; `CBirkbeck/AINTLIB`; Mathlib `RingTheory/DividedPowers`

**CrystallineCohomology** (promotion unit, wave A)
- primary: Berthelot–Ogus 1978, *Crystalline Cohomology*, §§3–8, Appendix B; Berthelot 1974, *Cohomologie cristalline des schémas de…*, Ch. VI–VII (?); Stacks Project 2026
- theorem: Bhatt 2012, *p-adic derived de Rham cohomology*, §3.3; Bhatt–Morrow–Scholze 2018, §§10–14, Thm 1.8; Bhatt–Lurie–Mathew 2021, *Revisiting the de Rham–Witt complex*, §§2–5; Langer–Zink 2004, *De Rham–Witt cohomology for a proper…*, §§1–3; Ekedahl 1984, *Multiplicative properties of the de… I* (?); Kato 1989, *Logarithmic structures of…*, §§1–6; Hyodo–Kato 1994, *Semi-stable reduction and crystalline…*, §§1–5 (?); Koshikawa 2020, *Logarithmic prismatic cohomology I*, Appendix A, §§2–4; Česnavičius–Koshikawa 2019, *A_inf-cohomology in the semistable case*, §§5
- formal: Mathlib `RingTheory/DividedPowers`

**RigidCohomologyAndPadicDifferentialEquations** (promotion unit, wave B)
- primary: Kedlaya 2010, *p-adic Differential Equations* (?); Le Stum 2007, *Rigid Cohomology* (?)
- theorem: Berthelot 1997, *Finitude et pureté cohomologique en…* (?); Kedlaya 2006, *Finiteness of rigid cohomology with…*; Kedlaya 2006, *Fourier transforms and p-adic 'Weil II'*
- statement: Kedlaya 2004, *P-adic local monodromy theorem*; André 2002, *Filtrations de type Hasse–Arf et…* (?); Mebkhout 2002, *Analogue p-adique du théorème de…* (?)

**PrismaticCohomology** (promotion unit, wave B)
- primary: Bhatt–Scholze 2022, §§2–3, §4, §§5–6; Bhatt–Morrow–Scholze 2018, §§3–14
- theorem: Bhatt–Morrow–Scholze 2019, *Topological Hochschild homology and…*, §4, §§10–11; Bhatt 2012, §§2–3; Illusie 1971, *Complexe cotangent et déformations I, II* (?); Bhatt–Lurie 2022, *Absolute prismatic cohomology*; Bhatt–Scholze 2023, *Prismatic F-crystals and crystalline…*, §§2–7, Thm 5.6; Antieau et al. 2022, *Beilinson fiber square*, Thm 6.17; Koshikawa 2020, §§2–6, App. A; Koshikawa–Yao 2023, *Logarithmic prismatic cohomology II*, §§2–8; Česnavičius–Koshikawa 2019; Hyodo–Kato 1994, §§3–5 (?); Bhatt–Lurie–Mathew 2021, §§2; Berthelot–Ogus 1978, Appendix B; Scholze 2013; Scholze 2017
- formal: Mathlib `RingTheory/DividedPowers`

**HabiroCohomology** (promotion unit, wave A)
- primary: Habiro 2004, *Cyclotomic completions of polynomial…*, §§7.3–7.4; Wagner 2025, *q-Hodge complexes over the Habiro ring*, §§2–3, App. A, Thm 2.9
- theorem: Wagner 2024, *q-Witt vectors*, §1.3, §3.11; Wagner 2025, *ku and q-de Rham cohomology*, Thm 1.2; Wagner 2026, *PhD thesis on q-de Rham and Habiro…* (?); Garoufalidis et al. 2024, *Habiro ring of a number field*
- statement: Scholze 2025, *Habiro cohomology (course announcement…* (?)

**BerkovichAndTropicalGeometry** (promotion unit, wave A)
- primary: Berkovich 1990, *Spectral Theory and Analytic Geometry…* (?); Baker–Rumely 2010, *Potential Theory and Dynamics on the…* (?); Baker–Payne–Rabinoff 2016, *Nonarchimedean geometry…*; Maclagan–Sturmfels 2015, *Tropical Geometry* (?)
- theorem: Baker–Norine 2007, *Riemann–Roch and Abel–Jacobi theory on…* (?); Baker 2008, *Specialization of linear systems from…* (?); Huber 1996
- formal: Tau Ceti `AlgebraicGeometry/AdicSpace`

**BruhatTitsTheory** (promotion unit, wave B)
- primary: Bruhat–Tits 1972, *Groupes réductifs sur un corps local I* (?); Bruhat–Tits 1984, *Groupes réductifs sur un corps local II* (?)
- conventions: Kaletha–Prasad 2023, *Bruhat–Tits Theory* (?)
- theorem: Casselman 1995, *Theory of admissible representations of…*, §1 (?); Stacks Project 2026; Tits 1966, *Classification of algebraic semisimple…* (?); Moy–Prasad 1994, *Unrefined minimal K-types for p-adic…* (?); Moy–Prasad 1996, *Jacquet functors and unrefined minimal…* (?)
- formal: Tau Ceti `AlgebraicGeometry/AffineGroupScheme/Reductive`

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Hartshorne 1977, *Algebraic Geometry* [5] ★; Bosch–Lütkebohmert–Raynaud 1990, *Néron Models* [4] ★; Huber 1996, *Étale Cohomology of Rigid Analytic…* [4] ★; Kollár–Mori 1998, *Birational Geometry of Algebraic…* [4] ★; Lazarsfeld 2004, *Positivity in Algebraic Geometry II* [4] ★; Deligne 1979, *Variétés de Shimura* [3] ★; Kashiwara–Schapira 1990, *Sheaves on Manifolds* [3] ★; Lazarsfeld 2004, *Positivity in Algebraic Geometry I* [3] ★; Mumford–Fogarty–Kirwan 1994, *Geometric Invariant Theory* [3] ★; Olsson 2016, *Algebraic Spaces and Stacks* [3] ★; Voisin 2002, *Hodge Theory and Complex Algebraic… I* [3] ★; Voisin 2003, *Hodge Theory and Complex Algebraic… II* [3] ★; Berthelot et al. 1971, *Théorie des intersections et théorème…* [2] ★; Berthelot–Ogus 1978, *Crystalline Cohomology* [2] ★; Birkenhake–Lange 2004, *Complex Abelian Varieties* [2] ★; Carlson–Müller-Stach–Peters 2017, *Period Mappings and Period Domains* [2] ★; Debarre 2001, *Higher-Dimensional Algebraic Geometry* [2] ★; Deligne et al. 1982, *Hodge Cycles, Motives, and Shimura…* [2] ★; Dimca 2004, *Sheaves in Topology* [2] ★; Fantechi et al. 2005, *Fundamental Algebraic Geometry* [2] ★; Fujino 2017, *Foundations of the Minimal Model Program* [2] ★; Griffiths–Harris 1978, *Principles of Algebraic Geometry* [2] ★; Hotta–Takeuchi–Tanisaki 2008, *D-Modules, Perverse Sheaves, and…* [2] ★; Huybrechts 2005, *Complex Geometry* [2] ★; Huybrechts 2006, *Fourier–Mukai Transforms in Algebraic…* [2] ★; Huybrechts–Lehn 2010, *Geometry of Moduli Spaces of Sheaves* [2] ★; Hyodo–Kato 1994, *Semi-stable reduction and crystalline…* [2] ★; de Jong 1996, *Smoothness, semi-stability and…* [2] ★; Kempf et al. 1973, *Toroidal Embeddings I* [2] ★; Kollár 2013, *Singularities of the Minimal Model…* [2] ★; Laumon–Moret-Bailly 2000, *Champs algébriques* [2] ★; Milne 1980, *Étale Cohomology* [2] ★; Milne 2017, *Algebraic Groups* [2] ★; Peters–Steenbrink 2008, *Mixed Hodge Structures* [2] ★; Arbarello et al. 1985, *Geometry of Algebraic Curves I* [1] ★; Baker–Rumely 2010, *Potential Theory and Dynamics on the…* [1] ★; Berkovich 1990, *Spectral Theory and Analytic Geometry…* [1] ★; Berthelot 1974, *Cohomologie cristalline des schémas de…* [1] ★; Bosch 2014, *Formal and Rigid Geometry* [1] ★; Breuer 2000, *Characters and Automorphism Groups of…* [1] ★; Brion–Kumar 2005, *Frobenius Splitting Methods in Geometry…* [1] ★; Conrad 2000, *Grothendieck Duality and Base Change* [1] ★; Cox–Little–Schenck 2011, *Toric Varieties* [1] ★; Cutkosky 2004, *Resolution of Singularities* [1] ★; Dolgachev 2003, *Invariant Theory* [1] ★; Eisenbud–Harris 2016, *3264 and All That* [1] ★; Fulton 1993, *Toric Varieties* [1] ★; Fulton 1997, *Young Tableaux* [1] ★; Fulton 1998, *Intersection Theory* [1] ★; Green–Griffiths–Kerr 2012, *Mumford–Tate Groups and Domains* [1] ★; Hartshorne 1966, *Residues and Duality* [1] ★; Jantzen 2003, *Representations of Algebraic Groups* [1] ★; Knutson 1971, *Algebraic Spaces* [1] ★; Lubotzky–Magid 1985, *Varieties of representations of…* [1] ★; Maclagan–Sturmfels 2015, *Tropical Geometry* [1] ★; Mukai 2003, *Invariants and Moduli* [1] ★; Mumford 1966, *Curves on an Algebraic Surface* [1] ★; Oda 1988, *Convex Bodies and Algebraic Geometry* [1] ★; Sernesi 2006, *Deformations of Algebraic Schemes* [1] ★; Deligne 1977, *Cohomologie étale (SGA 4½)* [4]; Deligne–Katz 1973, *Groupes de monodromie en géométrie…* [3]; Artin–Grothendieck–Verdier 1972, *Théorie des topos et cohomologie étale…* [2]; Barth et al. 2004, *Compact Complex Surfaces* [2]; Beauville–Laszlo 1995, *Un lemme de descente* [2]; Corti 2007, *Flips for 3-folds and 4-folds* [2]; Ueno 1975, *Classification Theory of Algebraic…* [2].

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
