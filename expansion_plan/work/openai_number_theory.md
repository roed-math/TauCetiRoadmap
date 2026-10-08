# OpenAI release, number theory share: prerequisite theory and roadmap gaps

Scope: the 31 families with `subject = "Number theory"` in `openai_families.json` (OAI#001–#031).
Needs file: `needs_openai_number_theory.jsonl` (158 lines; by coverage: campaign 60, mathlib 23, oai-lean 23, gap 21, tauceti-roadmap 15, open-pr 8, tauceti-code 8). Scratch work (PDF text of all 58
manuscripts, extraction scripts): `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/agent-oai-nt/`.

## (a) Statistics

| | count |
|---|---|
| families | 31 |
| manuscripts | 58 |
| manuscripts flagged `formalized` (from `formalization.yaml` sources) | 7, in 6 families (003 ×2, 008, 020, 021, 025, 028) |
| families with a Lean scope page `lean/docs/NNN.md` and comparator statements | **16**: 003 005 007 008 009 012 013 015 017 020 021 023 024 025 026 028 |
| families with only preliminary OAI files (no headline theorem) | 3: 011 (`TotientFibers`), 022 (`DuffinSchaeffer`), 027 (`NumberField`) |
| size of the 16 formalized NT trees | ≈23,500 files, ≈3.0 M lines; every tree has 0 `sorry` and 0 `axiom` |
| PDFs read (introduction + method sections) | 19 in depth (001, 002_0, 003_0, 004_0, 005, 006_0, 008, 009_2, 010_2, 013, 015_0, 016_0, 017, 018_1, 019_1, 027, 029_0, 030, 031) plus named-tool scans of all 58 |

The `formalized` flag undercounts: the docs pages show 16 families with complete comparator
theorems. Partial scopes: 009 formalizes only injectivity of the Bogomolov–Pop map; 015 only the
prime-degree paper; 026 only the corollary on `p_n/n`; 017 omits Flint–Hills; 003 omits the 11/12
companion.

Classification: **5 elementary** (005, 017, 020, 025, 028), **16 needs-roadmaps**, **10 frontier**
(001, 002, 004, 006, 010, 014, 016, 018, 019, 030).

Dependencies of the OAI number-theory trees (from their imports): Mathlib;
PrimeNumberTheoremAnd at `c39a751` (Wiener, Perron formula, zeta bounds, rectangle residue
calculus, Selberg sieve, `MertensClassical`, and modules named `SiegelZeros.HadamardSupport`,
`Erdos970.*`, `Catalan.Consequences`); StrongPNT (zero-free region, log-derivative bounds);
n-yamaguchi/ClassFieldTheory (only `DukePrimeDegree`: ray-class Artin map, Frobenius); and,
oddly, rellich-kondrachov (Sobolev, imported by `CubicMoment` and `DirichletL`) and
AbsorptionCutoff (`Jacobsthal`). **No number-theory file imports Tau Ceti or AINTLIB**; the only
Tau Ceti imports in all of OAI are five SLE files using `TauCeti.Analysis.Complex.Conformal.*`.

## (b) Prerequisite clusters and coverage

Coverage is the strongest owner (mathlib > tauceti-code > tauceti-roadmap > open-pr >
birkbeck-campaign > lmfdb-plan > oai-lean > gap). "Campaign" means Chris Birkbeck's 152
roadmaps; I grepped each README for the concept rather than trusting names. Many campaign stages
are one-line curricula ("Develop mean values, Halasz-type results, pretentious distances, smooth
numbers…", AN.5); I count a concept as campaign-covered only when such a line names it.

| # | Cluster | arXiv | Families | Level | Coverage (strongest) | Owner(s) | Gap / action |
|---|---|---|---|---|---|---|---|
| K1 | Dirichlet and finite-order Hecke L-functions: continuation, FE | math.NT | 003 015 023 029 | stmt | mathlib / open-pr | Mathlib `DirichletCharacter.LFunction`; LFunctions (#248); Tau Ceti `HeckeCharacter` code | none |
| K2 | Zero-free regions with exceptional-zero disjunction, explicit formula, PNT with error term | math.NT | 003 012 029 | proof | open-pr | ZerosOfLFunctions (#253) | none |
| K3 | Exceptional zeros and uniformity in the modulus: Landau–Page, Siegel, Siegel–Walfisz, Deuring–Heilbronn, Linnik, Brun–Titchmarsh, Stark's effective Brauer–Siegel | math.NT | 003 011 012 013 015 021 026 029 | proof | oai-lean | #253 *excludes* Siegel's theorem and all conductor-uniform estimates; campaign AN.2 only "labels" exceptional zeros | **propose SiegelZerosAndPrimesInProgressions** |
| K4 | Sieve methods: Brun, Selberg, linear sieve, large sieve, Bombieri–Vinogradov, Maynard, Chen-type | math.NT | 004 011 012 013 020 021 024 025 026 029 | proof | mathlib (partial) / campaign | Mathlib `SelbergSieve`; SieveMethodsAndPrimePatterns SV.0–SV.5 | extend campaign SV: larger sieve, long gaps (Erdős–Rankin, Ford–Green–Konyagin–Maynard–Tao), squarefree values of polynomials, Hooley/Heath-Brown for Artin |
| K5 | Multiplicative functions in short intervals and correlations: Halász, Shiu, Matomäki–Radziwiłł, MRT, Tao's entropy decrement | math.NT | 007 011 012 015 | proof | campaign (Halász only) / oai-lean | AN.5 names Halász and pretentious distance; nothing names MR, MRT, Tao, Shiu | **propose MultiplicativeFunctionsInShortIntervals** |
| K6 | Anatomy of integers: Mertens, Turán–Kubilius, Erdős–Kac, smooth numbers and Dickman ρ, Poisson–Dirichlet law, totient values | math.NT (PR) | 007 011 012 021 024 025 | stmt+proof | campaign (partial) | AN.5 ("smooth numbers"), PM.1 (Turán–Kubilius, Erdős–Kac); Mathlib `SmoothNumbers` (sets only) | **propose AnatomyOfIntegers**; PD(θ) itself to StandardDistributions |
| K7 | Metric Diophantine approximation: Gallagher 0–1, Duffin–Schaeffer (Koukoulopoulos–Maynard) | math.NT | 022 | proof | mathlib / campaign | Mathlib `addWellApproximable_ae_empty_or_univ`; PM.3 | none |
| K8 | Irrationality and transcendence methods: Padé/hypergeometric approximants, interpolation determinants, zero estimates, Baker over ℂ_p | math.NT | 005 017 031 | proof | open-pr | LinearFormsInLogarithms (#451); DT.0, DT.3, DT.5 | none (OAI's interpolation-determinant code is a porting source) |
| K9 | Power residue symbols, power reciprocity, Gauss and Jacobi sums of order n, Stickelberger | math.NT | 003 023 029 | stmt | oai-lean | Tau Ceti ClassFieldTheory *excludes* "explicit power-reciprocity laws beyond quadratic reciprocity"; campaign CA.1 one clause | **propose PowerReciprocityLaws** |
| K10 | Metaplectic theta and Gauss-sum analysis: Kubota covers, Patterson's cubic theta, Heath-Brown–Patterson, Kazhdan–Patterson, power-residue large sieves | math.NT (RT) | 003 013 023 029 | proof | oai-lean | campaign MetaplecticAutomorphicForms covers only the double cover and says higher-degree covers "require a separately sourced extension" | **propose GaussSumsAndMetaplecticTheta** |
| K11 | Homogeneous dynamics: entropy, leafwise measures, Mautner, nondivergence, Einsiedler–Katok–Lindenstrauss, ELMV torus packets | math.DS | 015 | proof | oai-lean | campaign GN.4 one line ("separately schedule ergodic/mixing, unipotent-flow and nondivergence proofs"); explorer lists ergodic theory as unmapped; Mathlib has topological, not metric, entropy | **propose HomogeneousDynamics** |
| K12 | Elliptic curves: Selmer, Sha, BSD quotient, twists, 2-descent, Cassels | math.NT | 002 004 006 030 | stmt | tauceti-roadmap | EllipticCurves (Layers 4, 6, 7, stretch 9); code: weak Mordell–Weil, Tate module | none |
| K13 | L(E,s) and its continuation; modularity over ℚ and imaginary quadratic fields; Serre's conjecture | math.NT | 002 004 006 030 | stmt+proof | campaign | RankZeroOneBSD BSD.0, EllipticCurveModularity, ClassicalSerreModularity, GL2AutomorphicRepresentationsAndTransfer, PotentialAutomorphyInfrastructure | frontier |
| K14 | Gross–Zagier, Kolyvagin, Kato, main conjectures, Selmer complexes, Selmer statistics | math.NT | 002 004 006 | proof | campaign | RankZeroOneBSD, GrossZagierAndArithmeticHeights, KatoEulerSystems, ModularIwasawaMainConjectures, SelmerIwasawaCohomology, ArithmeticStatistics | Smith's 2^∞-Selmer distribution not named: extend ArithmeticStatistics |
| K15 | Galois representations, p-adic Hodge theory, deformations, completed cohomology, p-adic local Langlands | math.NT | 001 010 030 | stmt+proof | campaign | ArithmeticGaloisRepresentations, PadicHodgeTheory, GlobalGaloisDeformations, CompletedCohomology…, PadicLocalLanglandsForGL2Qp | frontier |
| K16 | Abelian varieties: cohomological realizations, Hodge/Lefschetz/Weil classes, CM, integral models | math.AG | 001 004 016 | stmt+proof | campaign | AbelianSchemesAndArithmeticModuli, MotivesAndAlgebraicCycles, CrystallineCohomology, ShimuraVarieties; lmfdb-plan AbelianVarieties (W2, undrafted); Tau Ceti HodgeStructures (linear algebra only) | frontier |
| K17 | Heights and unlikely intersections: Néron–Tate, Faltings height, Vojta–Rémond, Mordell–Lang, o-minimality, G-functions | math.NT (AG, LO) | 004 016 | proof | open-pr / campaign | ArithmeticHeights (#287, Weil heights); HeightsRationalPointsAndObstructions, FaltingsFiniteness…, LD.6, DT.5 | Zilber–Pink named nowhere; frontier |
| K18 | Anabelian geometry of fields: decomposition groups from group theory, Neukirch–Uchida, Bogomolov–Pop, birational section conjecture | math.NT (AG) | 009 019 031 | proof | gap | campaign NC.0 (sections), NC.1 (Mochizuki's curve theorem only); BelyiMaps puts "anabelian reconstruction" out of scope | **propose BirationalAnabelianGeometry** |
| K19 | Grothendieck–Teichmüller theory: graded free Lie algebras, t_n, grt_1, associators, KZ associator | math.QA | 008 | stmt+proof | mathlib (FreeLieAlgebra only) / oai-lean | BelyiMaps and PeripheralActions put GT theory out of scope; campaign PS.9 owns MZVs | **propose GrothendieckTeichmuller** |
| K20 | Algebraic groups over global fields: Tits index, strong approximation, Margulis normal subgroup theorem, congruence subgroup problem | math.GR (AG, NT) | 018 | stmt+proof | campaign | ReductiveGroupsPartII, AdelicAlgebraicGroups AA.4; Tau Ceti ReductiveGroups (algebraically closed/split); CFSGStatement | Margulis NST and Kneser–Tits named nowhere; frontier |
| K21 | Function-field and geometric Langlands | math.AG (RT) | 014 | stmt+proof | campaign | GlobalShtukasAndFunctionFieldLanglands, ExcursionOperatorsAndSpectralAction, EtaleDualityAndPerverseSheaves | restricted geometric Langlands, Arthur SL₂: frontier |
| K22 | Character varieties and matrix invariants | math.AG (RT, GT) | 027 | stmt | gap | named nowhere (ClassicalGroups only cites Procesi's book) | **propose CharacterVarieties** |
| K23 | Computability and Diophantine definability (MRDP) | math.LO | 004 | stmt+proof | mathlib (statement) / campaign | Mathlib `Computability`, `Dioph`, `pow_dioph`; LD.4 | none |
| K24 | Number-field and CFT substrate: orders, ray classes, Kummer, Chebotarev, Dedekind zeta residue | math.NT | 009 015 020 029 031 | stmt+proof | mathlib / tauceti-code | Mathlib `DedekindZeta`, Kummer; Tau Ceti Chebotarev, ClassFieldTheory, NumberFieldArithmetic, LocalGaloisGroups | none |
| K25 | Poisson–Dirichlet distribution PD(θ), GEM | math.PR | 011 | stmt | gap | StandardDistributions has finite Dirichlet laws and stick-breaking only | extend StandardDistributions |

## (c) Proposed roadmaps

Nine new roadmaps. Five are math.NT and belong with the campaign fork; one each is math.DS,
math.QA, math.AG and (as an extension) math.PR. Four campaign extensions follow.

### 1. PowerReciprocityLaws — math.NT — size L

*Scope.* This roadmap builds the `n`-th power residue symbol of a number field containing the
`n`-th roots of unity and proves the reciprocity laws it satisfies. The symbol `(a/𝔭)_n` is
defined from the residue field, extended multiplicatively to ideals prime to `n·a`, and identified
with the local Hilbert symbol of degree `n` that ClassFieldTheory constructs from Kummer classes;
the product formula then gives the general power reciprocity law, and the explicit laws are proved
as its instances: cubic and biquadratic reciprocity with their supplementary laws for primary
elements, Eisenstein reciprocity, and sextic reciprocity over `ℚ(ζ₃)`. Alongside the symbols it
builds Gauss and Jacobi sums of order `n` over finite fields and over residue fields of number
fields: absolute values, the Hasse–Davenport relation, Stickelberger's factorization of the
Gauss-sum ideal, and Weil's theorem that Jacobi sums define Hecke characters.

- Objects: `powerResidueSymbol`, primary elements of `ℤ[ζ_n]`, order-`n` Gauss and Jacobi sums.
- Headlines: general power reciprocity; Eisenstein reciprocity; cubic, biquadratic and sextic laws with supplements; Stickelberger; Hasse–Davenport; Jacobi-sum Hecke characters.
- Prerequisites: ClassFieldTheory (Hilbert symbol, product formula, Kummer theory), NumberFieldArithmetic, GlobalNumberFields (Hecke characters); Mathlib `GaussSum`, `JacobiSum`, `MulChar`, cyclotomic fields.
- Families: 003, 023, 029. The LMFDB character pages will want it too.
- Formalizability: high. The only deep input is ClassFieldTheory's Hilbert symbol. OAI's ad hoc cubic symbol over `ℤ[ω]` (`CubicGauss`, `CubicGram`) can serve as a cross-check.

### 2. GaussSumsAndMetaplecticTheta — math.NT (secondary math.RT) — size XL

*Scope.* This roadmap develops the analytic theory of `n`-th order Gauss sums through the
metaplectic forms whose Fourier coefficients they are. For a number field `F` containing `μ_n`
it builds Kubota's `n`-fold cover of `SL₂` over `F` from the Kubota symbol, the metaplectic
Eisenstein series on the cover with its constant term and meromorphic continuation, and the theta
function as its residue at the first pole. Over `F = ℚ(ζ₃)`, acting on hyperbolic 3-space through
the Bianchi group, it proves Patterson's theorem that the Fourier coefficients of the cubic theta
function are cubic Gauss sums, deduces the continuation of `∑ g(c) N(c)^{-s}` (Kubota–Patterson)
and the Heath-Brown–Patterson equidistribution of cubic Gauss-sum arguments. A second strand
proves the large-sieve inequalities for power-residue characters that these arguments use:
Heath-Brown's quadratic large sieve over `ℚ` and its number-field form (Goldmakher–Louvel), and
Heath-Brown's cubic large sieve. The Kazhdan–Patterson theta representations of the `n`-fold
covers of `GL_r` are the final layer. The double cover and the Weil representation are not
built here; they belong to the campaign's MetaplecticAutomorphicForms, and the boundary between
the two roadmaps is the degree of the cover.

- Objects: Kubota symbol and cocycle, `n`-fold metaplectic `SL₂`, metaplectic Eisenstein series, cubic theta function, Kazhdan–Patterson theta representation.
- Headlines: continuation and residue of metaplectic Eisenstein series; Patterson's coefficient theorem; Kubota–Patterson Dirichlet series; Heath-Brown–Patterson; Heath-Brown's quadratic and cubic large sieves.
- Prerequisites: PowerReciprocityLaws; KleinianGroups (#432: `H³`, `PSL₂(ℤ[ω])`); LFunctions (#248); ThetaSeries (#286); ContourIntegration (completed); Mathlib Fourier analysis and Poisson summation; the campaign's SV.2 for the classical large sieve.
- Families: 003, 013 (quadratic large sieve), 023, 029.
- Formalizability: medium. OAI has the `ℚ(ζ₃)` case worked out: `CubicMoment`, with 3,549 files and 296k lines, including 1,476 cubic-theta files on `ℂ×ℝ`. It is organized by paper, not as a library. The Kazhdan–Patterson layer is the hardest.

### 3. SiegelZerosAndPrimesInProgressions — math.NT — size L

*Scope.* This roadmap owns the theory of the possible exceptional zero and every prime estimate
that is uniform in the modulus. It starts from the zero-free regions with their exceptional-zero
disjunction proved in ZerosOfLFunctions, and proves:

- Landau–Page;
- Siegel's ineffective bound `L(1,χ) ≫_ε q^{-ε}` and its zero form;
- Deuring–Heilbronn repulsion;
- the Siegel–Walfisz theorem, with its quantifiers in `A` and `q ≤ (log x)^A`;
- Linnik's theorem on the least prime in a progression, by log-free zero density;
- the Brun–Titchmarsh inequality in Montgomery–Vaughan form;
- Stark's effective Brauer–Siegel bound for number fields without quadratic subfields, with its exceptional-zero descent.

It exports conductor-uniform prime counts for Dirichlet characters and for the ray-class
characters of a fixed number field. Bombieri–Vinogradov stays with the campaign's sieve roadmap
(SV.3), which takes Siegel–Walfisz from here.

- Prerequisites: ZerosOfLFunctions (#253), LFunctions (#248), Mathlib Dirichlet L-functions, campaign SV.2 (large sieve) for Montgomery–Vaughan.
- Families: 003, 011, 012, 013, 015, 021, 026, 029.
- Formalizability: high, from Davenport chapters 14–22 and Iwaniec–Kowalski chapters 5 and 18. OAI already has Siegel–Walfisz (`Ostmann`, `Jacobsthal`), conductor-uniform real-zero exclusion (`SiegelZeros`) and Stark descent (`DukePrimeDegree`).

### 4. MultiplicativeFunctionsInShortIntervals — math.NT — size L

*Scope.* This roadmap develops the mean values of bounded multiplicative functions over short
intervals and progressions, and their binary correlations. It begins with Halász's theorem in
the quantitative Montgomery–Tenenbaum form, the Granville–Soundararajan pretentious distance and
its triangle inequality, and Shiu's Brun–Titchmarsh bound for nonnegative multiplicative
functions in short progressions. It then proves the Matomäki–Radziwiłł theorem: a real bounded
multiplicative function has almost all of its short averages close to its long average. Next
comes the Matomäki–Radziwiłł–Tao bound for exponential sums of multiplicative functions over
almost all short intervals. The roadmap ends with Tao's logarithmically averaged binary Elliott
theorem via the entropy decrement argument, which includes the two-point logarithmic Chowla
conjecture.

- Prerequisites: Tau Ceti ArithmeticDirichletSeries (Dirichlet series, Perron) and LSeries; Mathlib Dirichlet characters; Tau Ceti InformationTheory (Shannon entropy); mean values of Dirichlet polynomials (built here).
- Overlap: the campaign's AN.5 names Halász and pretentious distances without targets. AN.5 should cite this roadmap for them.
- Families: 007, 011, 012, 015 (Shiu).
- Formalizability: high to medium. OAI `TwoPoint` (1,465 files) and `OrdinaryCorrelations` carry Halász-type lemmas and the MR and MRT inputs.

### 5. AnatomyOfIntegers — math.NT (secondary math.PR) — size L

*Scope.* This roadmap describes the multiplicative structure of a random integer up to `x` and of
a random shifted prime `p − 1`: how many prime factors it has, how large they are, and what that
forces on arithmetic functions built from them. It proves:

- Mertens' theorems, Hardy–Ramanujan, the Turán–Kubilius inequality, the Erdős–Kac theorem and the Sathe–Selberg asymptotics for `ω` and `Ω`;
- the theory of smooth numbers through the Dickman function: the Dickman–de Bruijn asymptotic, Hildebrand's uniform range, Rankin's trick, and smooth numbers in short intervals and among shifted primes;
- the Poisson–Dirichlet limit law for the normalized logarithms of the prime factors (Billingsley, Knuth–Trabb Pardo);
- the distribution of values of Euler's and Carmichael's functions: Erdős–Wintner, Pomerance's fiber bounds, and Ford's structure theorem for the count `V(x)` of totients.

- Prerequisites: Tau Ceti prime ideal theorem (ArithmeticDirichletSeries); ZerosOfLFunctions (#253) for error terms; SiegelZerosAndPrimesInProgressions (shifted primes); campaign SV.1 (Brun, Selberg); StandardDistributions extended with PD(θ); Mathlib `SmoothNumbers`.
- Overlap: AN.5 ("smooth numbers") and PM.1 (Turán–Kubilius, Erdős–Kac) should cite this roadmap.
- Families: 007, 011, 012, 021, 024, 025.
- Formalizability: high. OAI `JointDickman` defines `ρ` by its delay equation; `TotientAsymptotic` (810 files) formalizes Ford's structure theory; Mertens is in PNT+.

### 6. HomogeneousDynamics — math.DS (secondary math.NT, math.GR) — size XL

*Scope.* This roadmap builds measure-theoretic dynamics on homogeneous spaces `G/Γ`, with the
space of unimodular lattices `SL_n(ℤ)\SL_n(ℝ)` as the running example. It goes as far as the
measure classification for higher-rank diagonal actions and its arithmetic applications. It
develops:

- ergodic decomposition and conditional measures;
- Kolmogorov–Sinai entropy with the Abramov–Rokhlin formula;
- leafwise measures along unipotent foliations and the entropy–leafwise-measure relation;
- the Mautner phenomenon and Howe–Moore mixing;
- Mahler's compactness criterion and quantitative nondivergence (Dani–Margulis, Kleinbock–Margulis).

It proves the Einsiedler–Katok–Lindenstrauss theorem that ergodic measures invariant under the
full diagonal group with positive entropy are algebraic. It applies this through the
Einsiedler–Lindenstrauss–Michel–Venkatesh counting-to-rigidity scheme to the equidistribution,
without escape of mass, of packets of periodic torus orbits attached to ideal classes of totally
real fields of prime degree. Unipotent rigidity (Ratner's theorems) is not built here.

- Prerequisites: Mathlib ergodic theory, Haar measure, conditional kernels and Lie groups; NumberFieldArithmetic; SiegelZerosAndPrimesInProgressions (Stark) for packet counts.
- Families: 015. Other OAI subjects (dynamics) and the Annals set likely add consumers.
- Formalizability: medium. OAI `DukePrimeDegree` already contains a complete EKL-type rigidity argument (`Entropy/` 212 files, `Dynamics/` 240 files). It is the strongest single porting source in this share.

### 7. BirationalAnabelianGeometry — math.NT (secondary math.AG) — size L

*Scope.* This roadmap reconstructs fields from their Galois groups. Its local theory reads
valuations off group theory, in three steps:

- decomposition and inertia groups of Krull valuations;
- the detection of valuations from commuting-liftable pairs in the maximal pro-`ℓ` abelian-by-central quotient (Bogomolov–Tschinkel, Engler–Koenigsmann, Topaz);
- Neukirch's group-theoretic characterization of decomposition groups of primes in the absolute Galois group of a number field.

Its global theory proves:

- the Neukirch–Uchida theorem for absolute and for solvably closed Galois groups of number fields;
- Uchida's theorem on open homomorphisms;
- the Bogomolov–Pop reconstruction of function fields of transcendence degree at least two over algebraically closed fields, from their abelian-by-central pro-`ℓ` Galois groups, by way of Kummer duality, curve subfields and the fundamental theorem of projective geometry.

Étale fundamental groups of curves, Galois sections and Mochizuki's theorem are not built here;
they stay with the campaign's AnabelianGeometryAndNonabelianChabauty. The boundary is fields
versus schemes.

- Prerequisites: ClassFieldTheory, LocalGaloisGroups, ProfiniteProPGroups, Chebotarev, AlgebraicCurves (Riemann–Hurwitz); Mathlib `ValuationSubring.decompositionSubgroup`; LinearFormsInLogarithms (#451, `ℓ`-adic logarithm rank for Uchida); campaign K2SymbolsBrauer for the Milnor-K variant.
- Families: 009, 019 (birational input), 031.
- Formalizability: medium to high. Neukirch–Uchida is in NSW chapter XII. Bogomolov–Pop is research-level, but the OAI manuscripts give complete proofs, and OAI `BogomolovPop` formalizes injectivity.

### 8. GrothendieckTeichmuller — math.QA (secondary math.NT, math.GR) — size L

*Scope.* This roadmap builds the Grothendieck–Teichmüller Lie algebra and the associators it acts
on. It supplies:

- graded free Lie algebras with Hall and Lyndon bases and Witt's dimension formula;
- the Drinfeld–Kohno Lie algebras `t_n`;
- the Lie algebra `grt₁` cut out by antisymmetry, the three-term relation and the pentagon in `t₄`, with the Ihara bracket, and the prounipotent group `GRT₁`.

It constructs Drinfeld associators and the Knizhnik–Zamolodchikov associator by regularized
holonomy, with its coefficients expressed in multiple zeta values. It proves that rational
associators exist and that `GRT₁` acts simply transitively on them. It constructs the odd-weight
elements `σ_{2k+1}` with nonzero depth-one coefficient, and ends with the Deligne–Drinfeld theorem
that `grt₁` is free on them. A last layer defines the profinite group `GT^` and the map from
`G_ℚ` into it (Belyi, Drinfeld, Ihara), the object BelyiMaps and PeripheralActions name and
exclude.

- Prerequisites: Mathlib `FreeLieAlgebra`, `FreeAlgebra`, universal enveloping algebra; campaign PeriodsAndSpecialValues PS.9 (MZVs, iterated integrals); PeripheralActions and ProfiniteProPGroups for the `GT^` layer.
- Families: 008.
- Formalizability: high for the algebra, medium for associator analysis. OAI `Algebra/Drinfeld` (21 files, 30k lines) is a complete proof of the endpoint, including a regularized-ODE associator.

### 9. CharacterVarieties — math.AG (secondary math.RT, math.GT) — size L

*Scope.* This roadmap builds representation and character varieties of finitely generated groups.
For a finitely presented group `Γ` and `G = GL_r, SL_r` over `ℤ`, it constructs:

- the representation scheme `Hom(Γ, G)` as an affine `ℤ`-scheme;
- the character variety as the spectrum of conjugation invariants, with the first fundamental theorem for matrix invariants (Procesi in characteristic zero, Donkin over `ℤ`), so that characters are trace functions;
- the identification of geometric points with semisimple representations up to conjugacy;
- relative character varieties with prescribed conjugacy classes at the boundary loops of punctured surfaces, and `SL₂` trace coordinates.

Its arithmetic endpoint is potential Zariski density of integral points on `SL_r` character
varieties of curves, with quasi-unipotent boundary classes.

- Prerequisites: Mathlib schemes and fundamental groups; Tau Ceti ReductiveGroups; RepresentationTheory/ClassicalGroups; PlanarTopology/SurfaceTopology (#271) for surface-group presentations.
- Families: 027. Geometric-topology families elsewhere in the release are likely consumers.
- Formalizability: medium. Donkin's theorem over `ℤ` is the hard step; the characteristic-zero theory is standard.

### Extensions to existing roadmaps (not new roadmaps)

- **StandardDistributions** (Tau Ceti, math.PR): Poisson–Dirichlet `PD(θ)`, GEM, Ewens sampling formula (011).
- **SieveMethodsAndPrimePatterns** (campaign SV): Gallagher's larger sieve (013); long gaps (Erdős–Rankin, Ford–Green–Konyagin–Maynard–Tao, positive proportion of large gaps) (021, 026); squarefree values of polynomials (Hooley, Erdős, Ekedahl–Poonen) (020); Hooley's conditional Artin theorem and the Gupta–Murty/Heath-Brown unconditional results (029).
- **ArithmeticStatistics** (campaign ST.5): Smith's distribution of `2^∞`-Selmer coranks in quadratic twist families (002, 006).
- **AnalyticNumberTheory** (campaign AN.5/PM.1): replace the Halász, pretentious-distance, smooth-number and Erdős–Kac clauses by citations of roadmaps 4 and 5.

Not proposed, though the concept is named nowhere: Zilber–Pink (016), the Margulis normal
subgroup theorem and Kneser–Tits over global fields (018), and the restricted geometric
Langlands equivalence and Arthur parameters (014). All are frontier, and none has a roadmap-size
classical core that is missing from the campaign.

## (d) Families

Lean: F = complete OAI formalization of the headline (scope page plus sorry-free tree), P =
preliminary files only, blank = none.

| # | Short title | Paper primary | Lean | Classification | Key needs |
|---|---|---|---|---|---|
| 001 | Milne rationality for abelian varieties | math.AG | | frontier (absolute Hodge, Blasius–Wintenberger, Kisin–Zhou CM lifting) | abelian-variety cohomology (Betti/ℓ-adic/crystalline), Hodge and Lefschetz classes, weakly admissible filtrations |
| 002 | Full BSD from Selmer corank ≤ 1 | math.NT | | frontier (modularity, Gross–Zagier–Kolyvagin, Kato, main conjectures) | statement: EllipticCurves (Selmer, Sha, BSD quotient) + RankZeroOneBSD BSD.0 for `L(E,s)` |
| 003 | Quasi-RH (zero-free `Re s > 7/8`), Landau–Siegel | math.NT | F | needs GaussSumsAndMetaplecticTheta, PowerReciprocityLaws, SiegelZerosAndPrimesInProgressions, LFunctions (#248) | cubic theta and Gauss sums over `ℚ(ζ₃)`, sextic large sieve, Hecke L over `ℚ(√−3)` |
| 004 | Hilbert's tenth problem over ℚ | math.NT (LO) | | frontier (QM abelian surfaces, Faltings heights, Serre modularity) | statement: Mathlib computability; MRDP (LD.4), rank-one elliptic curves, prime-pattern sieve |
| 005 | Catalan's constant irrational | math.NT | F | elementary | moments and determinants, `lcm(1..n)` from PNT (Tau Ceti), Padé context (DT) |
| 006 | Goldfeld densities and mean analytic rank | math.NT | | frontier (2-converse via Heegner and Kato, Smith's distribution) | quadratic twists, Cassels–Tate, analytic rank of twists |
| 007 | Two-point Chowla, corrected Elliott | math.NT | F | needs MultiplicativeFunctionsInShortIntervals | Halász, pretentious distance, MR, MRT, entropy decrement |
| 008 | Deligne–Drinfeld conjecture | math.QA | F | needs GrothendieckTeichmuller | graded free Lie algebras, `t₄`, `grt₁`, Ihara bracket, KZ associator |
| 009 | Bogomolov–Pop / Milnor-K reconstruction | math.AG (NT) | F (injectivity only) | needs BirationalAnabelianGeometry, K2SymbolsBrauer | commuting pairs to valuations, Kummer duality, projective geometry, Milnor K mod ℓ |
| 010 | 2-adic pro-modularity, Fontaine–Mazur at 2 | math.NT | | frontier (completed cohomology, pseudodeformations, p-adic local Langlands at 2) | Galois representations, de Rham, completed Hecke algebras |
| 011 | Prime factors of `p−1`: PD law, totient fibers | math.NT | P | needs AnatomyOfIntegers, SiegelZerosAndPrimesInProgressions, campaign SV.3/SV.5, StandardDistributions (PD) | Poisson–Dirichlet, smooth shifted primes, Bombieri–Vinogradov, Chen-type sieve |
| 012 | Joint Dickman law for `n`, `n+1` | math.NT | F | needs AnatomyOfIntegers, MultiplicativeFunctionsInShortIntervals | Dickman ρ, smooth numbers, MR inputs, PNT with error (#253) |
| 013 | Ostmann's inverse Goldbach | math.NT | F | needs GaussSumsAndMetaplecticTheta (quadratic large sieve), SiegelZerosAndPrimesInProgressions, campaign SV.2 | large and larger sieve, Weil bound, Siegel–Walfisz |
| 014 | Restricted geometric Langlands, generic Ramanujan | math.AG (RT) | | frontier (restricted GLC, Lafforgue, Arthur parameters) | `Bun_G`, perverse sheaves, excursion operators |
| 015 | Torus-packet equidistribution (prime, quartic, sextic) | math.DS (NT) | F (prime degree) | needs HomogeneousDynamics, SiegelZerosAndPrimesInProgressions (Stark), MultiplicativeFunctionsInShortIntervals (Shiu) | entropy, EKL rigidity, ELMV, Dedekind zeta residue |
| 016 | Abelian Zilber–Pink; curves in `A₂` | math.NT (AG) | | frontier (Vojta–Rémond and Mordell–Lang, o-minimality, G-functions) | Néron–Tate heights, `A₂`, Pila–Wilkie, Masser–Wüstholz |
| 017 | Irrationality exponent of π is 2 | math.NT | F | elementary (self-contained; transcendence tools from #451/DT) | interpolation determinants, zero estimates, Bézout and blowups |
| 018 | Margulis–Platonov over global fields | math.GR | | frontier (Margulis NST, CFSG, classification of forms) | Tits index, strong approximation, metaplectic kernel |
| 019 | Local p-adic section conjecture | math.AG (NT) | | frontier (birational p-adic section conjecture, Berkovich covers) | étale π₁ and sections (campaign), StableReduction, BirationalAnabelianGeometry |
| 020 | Squarefree quartics, power-free values | math.NT | F | elementary | determinant method (ES.5), squarefree sieve (SV extension) |
| 021 | Quadratic bound for Jacobsthal's function | math.NT | F | needs campaign SV.1/SV.5, SiegelZerosAndPrimesInProgressions, AnatomyOfIntegers | linear sieve, Brun–Titchmarsh, Siegel–Walfisz, Mertens, long-gap constructions |
| 022 | Weak inhomogeneous Duffin–Schaeffer | math.NT | P | needs campaign PM.3 (Koukoulopoulos–Maynard) | limsup sets, Gallagher (Mathlib), GCD graphs |
| 023 | Patterson's first moment of cubic Gauss sums | math.NT | F | needs PowerReciprocityLaws, GaussSumsAndMetaplecticTheta | cubic symbol, Patterson's theorem, Heath-Brown–Patterson, cubic large sieve, KleinianGroups (#432) |
| 024 | Asymptotic for the number of totients | math.NT | F | needs AnatomyOfIntegers | Ford's structure theory of `V(x)` |
| 025 | Short Egyptian fractions | math.NT | F | elementary | PNT, smooth numbers |
| 026 | Positive lower density of large prime gaps | math.NT | F (corollary) | needs campaign SV.3/SV.4 plus long-gap extension | Maynard weights, FGKMT, Bombieri–Vinogradov |
| 027 | Integral points on character varieties of curves | math.AG | P | needs CharacterVarieties | representation schemes, matrix invariants over `ℤ`, surface groups |
| 028 | Gaussian moat (bounded components) | math.NT | F | elementary | Gaussian primes, periodic sieve, entropy and Pinsker |
| 029 | Artin's conjecture, infinitude for every base | math.NT | | needs GaussSumsAndMetaplecticTheta, PowerReciprocityLaws, LFunctions (#248), SV extension | Kazhdan–Patterson theta, sextic reciprocity, number-field quadratic large sieve, Kummer-field Chebotarev |
| 030 | Modularity of elliptic curves over imaginary quadratic fields | math.NT | | frontier (potential automorphy over CM fields, torsion classes) | EllipticCurves local parameters; Bianchi newforms (campaign GL2…, lmfdb-plan W3) |
| 031 | Uchida's conjecture (open homomorphisms) | math.NT | | needs BirationalAnabelianGeometry, LinearFormsInLogarithms (#451) | Neukirch–Uchida, local CFT, Chebotarev, ℓ-adic Waldschmidt–Masser |

## (e) Reusable OAI Lean infrastructure worth porting

Apache-2.0. Every tree below is sorry-free and axiom-free. The code is organized paper by paper
(declaration names such as `OAI.Erdos970.*` and `OAI.CubicFirstMoment.cubicThetaActualCuspCoefficient`).
The roadmaps should specify the mathematics and cite these trees as provenance, per README
"Porting existing work". None of the trees uses Tau Ceti, so each port also needs a re-basing
onto Tau Ceti carriers (`HeckeCharacter`, `ArithmeticDirichletSeries`, Chebotarev).

| OAI tree (lean/OAI/…) | Size | General content not in Mathlib or Tau Ceti | Target roadmap |
|---|---|---|---|
| `NumberTheory/DukePrimeDegree/Entropy`, `/Dynamics` (+ `PrimePackets`) | 212 + 240 files (whole tree 886 files / 88k lines; PrimePackets 143 / 59k) | metric entropy and conditional information, leafwise and conditional measures, Mautner-type arguments, EKL-type measure classification on `SL_n(ℤ)\SL_n(ℝ)`, torus-packet adelic realization | HomogeneousDynamics |
| `NumberTheory/CubicMoment` (+ `CubicGauss`, `CubicGram`) | 3,549 + 75 files / 312k lines | Eisenstein-integer arithmetic, cubic residue symbol, cube decomposition, cubic Gauss sums, Kubota–Patterson cubic theta on `ℂ×ℝ` with cusp expansions (1,476 files), cubic large sieve, Kloosterman-type estimates | PowerReciprocityLaws; GaussSumsAndMetaplecticTheta |
| `NumberTheory/DirichletL` | 2,926 files / 487k lines | Hecke L-functions over `ℚ(√−3)` via products of Hurwitz theta pairs (`WeakFEPair.product`, `rescale`), Gauss-sum reciprocity phase, cubic and quadratic sieves, Poisson representations | LFunctions (#248) cross-check; GaussSumsAndMetaplecticTheta |
| `NumberTheory/SiegelZeros` | 306 files / 70k lines | conductor-uniform exclusion of real zeros (imports a PNT+ `SiegelZeros.HadamardSupport` module) | SiegelZerosAndPrimesInProgressions |
| `NumberTheory/Ostmann` | 7,716 files / 609k lines | multiplicative and shifted large sieves, Heath-Brown quadratic large sieve, Siegel–Walfisz (≈1,050 files mention it), "without Siegel" variants | SiegelZerosAndPrimesInProgressions; GaussSumsAndMetaplecticTheta; campaign SV.2 |
| `NumberTheory/TwoPoint`, `OrdinaryCorrelations`, `TwoPointCorrelations` | 2,319 files / 232k lines | Halász-type mean values, pretentious distance, Matomäki–Radziwiłł and MRT inputs, entropy-type correlation arguments | MultiplicativeFunctionsInShortIntervals |
| `NumberTheory/JointDickman` | 1,502 files / 119k lines | Dickman ρ as solution of `uρ'(u) = −ρ(u−1)` (`DelayConstruction`), smooth-number asymptotics, Selberg-sieve and MR inputs | AnatomyOfIntegers |
| `NumberTheory/TotientAsymptotic` | 810 files / 73k lines | Ford's structure theory for totient values | AnatomyOfIntegers |
| `NumberTheory/Jacobsthal` | 819 files / 152k lines | linear sieve and fundamental lemma, Brun–Titchmarsh, Vaughan, Mertens, Dickman | campaign SV; AnatomyOfIntegers |
| `NumberTheory/PrimeGaps` | 56 files / 23k lines | Bombieri–Vinogradov usage, Maynard-type weights for large gaps | campaign SV.4 extension |
| `NumberTheory/PowerFree` | 63 files / 23k lines (no external imports) | determinant method with adaptive auxiliary primes, power-free values of polynomials | campaign ES.5 / SV extension |
| `NumberTheory/PiExponent` | 869 files / 95k lines (no external imports) | weighted multivariable interpolation with prescribed jets, interpolation-determinant estimates, irrationality-exponent framework | campaign DT.0–DT.3; LinearFormsInLogarithms (#451) neighbour |
| `NumberTheory/Catalan` | 981 files / 574k lines | moment determinants, potential-theoretic energy bounds, integral Chebyshev rows | campaign DT (mostly paper-specific) |
| `Algebra/Drinfeld` | 21 files / 30k lines | truncated free algebras, nilpotent filtrations, KZ-type associator by regularized ODE, `t₄`, `grt₁`, Ihara bracket, weight grading on `FreeLieAlgebra` | GrothendieckTeichmuller |
| `Algebra/BogomolovPop` | 5 files / 3k lines | pro-`ℓ` abelian-by-central quotients, closed `Γ₃`, perfect-closure isomorphism classes modulo Frobenius | BirationalAnabelianGeometry |
| `NumberTheory/EgyptianFractions`, `ShortEgyptian`, `GaussianMoat` | 465 files / 65k lines | elementary; little reusable beyond the theorems | none |

Also relevant for porting: the PNT+ revision `c39a751` that OAI pins carries modules (`Erdos970.*`,
`SiegelZeros.*`, `IEANTN.Mertens`, `Mathlib/NumberTheory/Sieve/Selberg`) that Tau Ceti lacks.
Mertens' theorems in particular are in neither Mathlib nor Tau Ceti.
