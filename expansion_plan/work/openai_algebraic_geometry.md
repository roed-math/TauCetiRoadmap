# OpenAI release, "Algebraic and complex geometry": prerequisite roadmaps

Scope: the 36 families with `subject = "Algebraic and complex geometry"` in
`openai_families.json` (#032–#069 minus #045/#061). Needs file:
`needs_openai_algebraic_geometry.jsonl` (217 lines, `"goal":"OpenAI"`).

## (a) Stats and method

- 36 families, 89 manuscripts. 7 manuscripts in 6 families are flagged `formalized` (039×2, 047, 049,
  050, 052, 058); `lean/docs/*.md` exist for those families and for 033. In addition
  the OAI library holds *partial, unflagged* developments for 033 (`AlgebraicGeometry/LogKodaira`),
  034 (`SectionFields`), 036 (`NumericalDimension`), 055 (`Stability`), 059 (`Geometry/HypersurfaceGerms`),
  066 (`CartierSections`), 067 (`RelativeTriviality`) and 068 (`Geometry/Anticanonical`).
  Flagged formalized: 039 Nagata, 039 Seshadri on surfaces, 047 cancellation, 049 noncoordinate
  polynomial, 050 Griffiths counterexample, 052 Kähler universal-cover splitting (plus the
  rationally-connected integrability statement in the same doc), 058 semialgebraic bounded domains.
- **Every OAI AG/complex-geometry development imports Mathlib only — none imports Tau Ceti.** Each
  re-defines complex projective varieties, line bundles, cohomology (via `Ext`), Kähler metrics in
  charts, etc. inside the comparator file.
- PDFs read (introduction and/or table of contents, via pdftotext): 29 manuscripts — 032_2, 033_0,
  034_3, 037_0, 038_0, 039_0, 040_0, 041_0, 041_1, 042_0, 043_0, 044_0, 046_0, 046_1, 048_0, 051_0,
  053_0, 054_0, 055_1, 057_0, 059_1, 060_0, 062_0, 063_0, 064_0, 065_1, 067_0, 068_0, 069_0. All 89
  were keyword-scanned for ~90 named tools (Kawamata–Viehweg, BCHM, Lelong, GAGA, Bogomolov, …).
- Classification (one per family): **elementary 2** (047, 049), **needs 8** (038, 039, 046, 048, 050,
  052, 058, 059), **frontier 26**. The frontier count is honest: most of these papers resolve named
  conjectures (abundance, Hodge for CM abelian varieties, P=W, Virasoro, Bloch, Campana abelianity)
  with proofs that sit on top of BCHM, Schmid/CKS, virtual classes, nonabelian Hodge or Hwang–Mok.
  **Statement-level coverage is the achievable goal**: with the proposals below plus existing
  owners, 33 of 36 families become statable; the exceptions are 043 (Higgs moduli/nonabelian Hodge),
  044 (BFN Coulomb branches) and 069 (D-modules on Bun_G). (062's Riemannian corollary also needs
  Berger holonomy, which nobody owns.)
- Coverage of the 217 needs: gap 142, Birkbeck campaign 34, open PR 21, Tau Ceti roadmap 8,
  Mathlib 7, Tau Ceti code 3, OAI Lean only 2.

## (b) Prerequisite clusters and coverage

S = needed to state some family's main result; P = needed for proofs. "Partial" means the owner
covers part; the missing part is assigned to a proposal in (c).

| Cluster | Coverage (strongest owner) | Families | arXiv | S/P |
|---|---|---|---|---|
| Weil/Q-Cartier divisors, K_X, boundary-free klt, N¹/N₁, NE-bar, nef/ample/semiample, Kleiman, NS finiteness | open PR: AbundanceStatement #545 | 034–038, 041, 056, 062, 063, 066–068 | AG | S |
| Pairs with boundary, log discrepancies, lc/dlt/plt/terminal, lct, generalized pairs, slc | gap (beyond #545) → **PairsAndKodairaDimension** | 033–038, 056, 066 | AG | S |
| Iitaka/Kodaira dim (log, compact-complex), ν, κ_σ, big/psef cones, Campana specialness, normalized volume | gap → **PairsAndKodairaDimension** | 033–037, 048, 057, 060 | AG | S |
| SNC divisors, log resolutions, Hironaka in char 0 | Birkbeck: AlgebraicModuli R09.7 (Bierstone–Milman) | almost all birational families | AG | S/P |
| Blowups (Rees), exceptional divisors | Tau Ceti code (affine Rees charts, `AlgebraicGeometry/Blowup`); StableReduction L4; R09.7a | 039, 038, 048 | AG | S |
| Coherent cohomology of proper schemes, base change | Tau Ceti roadmap: JacobianChallenge B–C | 040, many P | AG | S/P |
| Serre duality in dim > 1, Hodge numbers h^q(Ω^p) | gap (curves only in JacobianChallenge B) → **PositivityAndVanishing** L0 | 040, 060, P everywhere | AG | P |
| Chow groups, intersection products, Chern classes, GRR, surface RR, Hodge index | Birkbeck: SchemeAndStackFoundations SF.5 | 032, 039, 040, 053, 055, 067 | AG | S |
| Hilbert/Quot/Hom schemes; projective bundles, Grassmannians | Birkbeck: AlgebraicModuli R09.1–R09.2 | 040, 050, 053, 063–067 | AG | S/P |
| Algebraic DM stacks, coarse spaces | Birkbeck: AlgebraicModuli R09.4–R09.5 | 053, 063, 065, 069 | AG | S |
| Complex analytic spaces, analytification | open PR #196 ComplexComparison L2 (local category only) | 033, 041, 046, 056 | CV | S |
| Coherent analytic sheaves, GAGA, Chow's theorem; dR–Betti | Birkbeck: ComplexComparisonPartII C0–C5 | 032, 041, P | CV/AG | P |
| Compact complex spaces: proper mapping, direct images, Fujiki class C, Kähler spaces, Douady | gap (partial in #196/C0) → **ComplexAnalyticSpaces** | 033, 034, 036, 041, 046, 056 | CV | S |
| Complex manifolds, holomorphic bundles, canonical bundle | open PR #279 ComplexManifolds | 042, 046, 050, 052, 060 | CV | S |
| Universal cover with lifted complex structure | Tau Ceti roadmap: UniversalCovers (Completed) + #279 M4 | 046, 052, 057, 058 | AT | S |
| SCV: C{z}, Weierstrass, Hartogs, pseudoconvexity, Stein, Cartan A/B, ∂̄ (Hörmander) | gap → **SeveralComplexVariables** | 042, 046, 058, 059, 064 | CV | S/P |
| Kähler/Hermitian metrics, Chern curvature, Griffiths positivity, Dolbeault, Hodge decomposition, hard Lefschetz, Kodaira embedding, Lefschetz (1,1), Bott–Chern | gap (HodgeStructures supplies linear algebra) → **KahlerManifoldsAndHodgeTheory** | 032, 036, 041, 050–052, 054, 057, 068 | AG/DG | S |
| Hodge structures (linear algebra) | Tau Ceti code: HodgeStructures (Completed) | 032, 054 | AG | S |
| Cycle class map, Hodge classes, Hodge-conjecture statement | Birkbeck: MotivesAndAlgebraicCycles MC.2/MC.7 (Hodge type needs Kähler cluster) | 032, 040 | AG | S |
| VHS, period maps, Griffiths curvature, Schmid, Deligne MHS, f_*ω semipositivity, weak positivity | gap (ShimuraData D3: homogeneous VHS only) → **VariationsOfHodgeStructure** | 032, 033, 034, 041, 043, 057 | AG | S/P |
| psh functions, positive currents, Lelong numbers, singular metrics, OT extension, Monge–Ampère, Calabi–Yau | gap → **PositiveCurrentsAndMongeAmpere** | 033, 034, 036, 041, 051, 056, 057, 062, 068 | CV/DG | P |
| KV/Nadel vanishing (algebraic), multiplier ideals, Seshadri constants, volumes, Okounkov bodies, ample vector bundles | gap → **PositivityAndVanishing** | 034, 036–039, 050, 066, 067 | AG | S/P |
| Cone/contraction theorems, flips, BCHM, canonical bundle formula, complements | gap → **MinimalModelProgram** | 033–037, 056, 066, 068 | AG | P (S for 056, 066) |
| Kähler MMP; char-p threefold MMP | gap, frontier | 056; 035 | AG | P |
| Surfaces: minimal models, Enriques–Kodaira, elliptic fibrations, class VII | gap (SF.5 surface RR; #280 log transforms) → **AlgebraicAndComplexSurfaces** | 040, 042, 046, 060 | AG | S/P |
| K3 surfaces, Torelli, Kuga–Satake, IHS manifolds, BBF form, cubic fourfolds | gap (IntegralLattices, OrthogonalSpinGroups supply algebra) → **K3AndHyperkahlerManifolds** | 032, 041, 042, 054, 055 | AG | S |
| Complex abelian varieties ↔ polarizable Hodge structures | Birkbeck: AbelianSchemes A5; ComplexTori #280 (tori only) | 032 | AG | S |
| CM abelian varieties, CM types; Mumford–Tate, Weil classes | Birkbeck: ComplexMultiplication… (CM types); MT/Weil classes not targeted | 032 | AG/NT | S |
| Albanese variety | Tau Ceti code (`AbelianVariety/Albanese.lean`, universal property); existence via AbelianSchemes A2; analytic version gap | 032, 040, 057 | AG | S |
| Rational curves, bend-and-break, RC/uniruled, VMRT, Fano manifolds, contact Fano | gap (Hom schemes in R09.2) → **RationalCurvesAndFanoVarieties** | 051, 052, 062, 063, 067 | AG | S/P |
| G/P, Borel–Weil, adjoint varieties | gap (ReductiveGroups L7: parabolic subgroups only) → **FlagVarieties** | 043, 044, 062, 067 | AG/RT | S |
| Simple Lie algebras | Tau Ceti roadmap: LieHighestWeight; Mathlib Killing | 062, 069 | RT | S |
| GIT, Kempf–Ness, quiver/Nakajima varieties, character varieties | gap → **GeometricInvariantTheory** | 043, 044 | AG | S |
| M̄_{g,n}, tautological ring | gap (StableReduction: curves/maps, no moduli) → **ModuliOfStableCurves** | 053, 063, 065 | AG | S |
| Virtual classes, GW invariants, quantum cohomology | gap → **VirtualClassesAndGromovWitten** | 040, 053, 063, 065 | AG | S/P |
| Equivariant cohomology/Chow, torus localization | gap (ClassifyingSpaces #437 discrete only) → **EquivariantCohomologyAndLocalization** | 040, 044, 053, 063, 065, 068 | AG/AT | S/P |
| D^b(Coh), Fourier–Mukai, SODs, Bridgeland stability, BG inequality | gap (Mathlib abstract derived cats; GrothendieckEulerForms) → **DerivedCategoriesAndStability** | 040, 054, 055 | AG | S |
| Perverse sheaves, decomposition theorem | Birkbeck: EtaleDualityAndPerverseSheaves (étale) | 043 | AG | S |
| Higgs bundles, nonabelian Hodge; BFN; D-modules on Bun_G; Hodge modules | gap, frontier (no proposal) | 043, 044, 069, 034 | AG/RT | S/P |
| Milnor fibrations, Seifert forms, μ-constant, surface singularities, high-dim fibred links | gap → **SingularityTheory** | 048, 059, 064 | AG/GT | P (S for 064) |
| Oka manifolds; Kobayashi/Brody hyperbolicity | gap → **OkaTheoryAndHyperbolicity** | 042, 051 | CV | S |
| Semialgebraic sets; bounded symmetric domains; ball quotients | Tau Ceti roadmap: RealAlgebraicGeometry L3; Birkbeck ShimuraData D2, ShimuraVarieties | 032, 046, 058 | AG | S |
| LNDs, Makar-Limanov invariant, coordinates | OAI Lean only → **LocallyNilpotentDerivations** | 047, 049 | AC | P |
| Quaternionic-Kähler / Berger holonomy (062 corollary; Bogomolov decomposition) | gap, Riemannian geometry (outside this share) | 041, 062 | DG | S/P |

## (c) Proposed roadmaps

Twenty proposals. Tiers: **T1** statement-level foundations, formalizable now; **T2** standard
graduate theory used in proofs; **T3** deep (decade-scale).

### 1. PairsAndKodairaDimension — math.AG — L — T1
This roadmap builds the vocabulary of birational geometry that AbundanceStatement leaves out: pairs
with boundary, their log discrepancies over all models, the singularity classes of the minimal model
program, and the Iitaka–Kodaira dimension theory of line bundles, divisors, pairs, open varieties and
compact complex manifolds. Every definition needed to state abundance, subadditivity, termination,
complement and boundedness theorems for pairs is constructed and compared with its standard
alternatives; structural theorems provable from first principles are milestones. Vanishing theorems
and the MMP are outside it.
- Objects: R-divisors and |mD|; pairs (X,Δ); a(E;X,Δ); terminal/canonical/klt/plt/dlt/lc, ε-lc, lc
  centres, lct; SNC/log smooth pairs; b-divisors and generalized pairs (X,B+M); demi-normal schemes and
  slc; κ(X,L), κ(X), κ̄(U), κ of compact complex manifolds; ν, κ_σ; big and pseudo-effective cones,
  volume; Fano/CY/general type, Mori fibre space, (good) minimal model as predicates; Campana orbifold
  base and special varieties; A_X(v), vol(v), normalized volume.
- Theorems: Iitaka fibration theorem; birational invariance of plurigenera and κ; κ̄ independent of
  SNC compactification; κ(X×Y)=κ(X)+κ(Y); smooth ⇒ terminal; klt for (X,0) agrees with #545; lct of SNC
  divisors; κ of curves, P^n, abelian varieties.
- Prereqs: AbundanceStatement (#545), JacobianChallenge B, R09.7 (log resolutions), ComplexManifolds
  (#279), ComplexAnalyticSpaces (analytic κ).
- Families: 033–038, 048, 056, 057, 060, 066 (+ statement layers of 041, 068).
- Formalizability: high. Note OAI `NumericalDimension` (29k lines) already builds Q-Weil divisors,
  canonical divisors from rational top forms, discrepancies and klt members — coordinate with #545.

### 2. PositivityAndVanishing — math.AG — XL (splits as VanishingTheorems + AsymptoticPositivity) — T2
This roadmap develops positivity of line bundles and vector bundles on projective varieties and the
vanishing theorems that drive it, following Lazarsfeld's *Positivity I–II* and Esnault–Viehweg. It
owns Serre duality in arbitrary dimension, Kodaira–Akizuki–Nakano and Kawamata–Viehweg vanishing in
characteristic zero by the Deligne–Illusie route (spreading out, W₂-liftings), algebraic multiplier
ideals and Nadel vanishing, asymptotic invariants, and ample/nef vector bundles. The MMP and
current-theoretic positivity are outside it.
- Objects: dualizing sheaf; h^{p,q}, p_g, q, plurigenera; asymptotic RR, volume, stable/augmented base
  loci; Seshadri constants (single, multipoint, at very general points); J(X,Δ), J(‖L‖), lct; Okounkov
  bodies; ample/nef/Q-twisted vector bundles; Castelnuovo–Mumford regularity.
- Theorems: Serre duality for projective CM schemes; Deligne–Illusie degeneration ⇒ KAN; KV; Nadel;
  local vanishing; Seshadri ampleness criterion; continuity/log-concavity of vol; Fujita
  approximation; Angehrn–Siu; Mumford regularity; Hartshorne's criteria for ample bundles; Le Potier.
- Prereqs: #545, PairsAndKodairaDimension, JacobianChallenge B–C, R09.1, R09.7, SF.5, blowups (R09.7a /
  StableReduction L4), Mathlib `SpreadingOut`, Witt vectors.
- Families: 038, 039, 050, 066, 067 (S/P); proof input to 034, 036, 037, 068.
- Formalizability: medium-high; entirely algebraic.

### 3. MinimalModelProgram — math.AG — XL — T3
This roadmap proves the main theorems of the minimal model program in characteristic zero: cone,
contraction, rationality and basepoint-free theorems for klt and lc pairs; existence of flips and
termination with scaling for klt pairs with big boundary (BCHM) and finite generation of klt log
canonical rings; the MMP and abundance for surfaces and the terminal MMP for threefolds; the canonical
bundle formula for lc-trivial fibrations; and the theory of complements and Fano type pairs. General
abundance, characteristic-p MMP and the Kähler MMP are outside it.
- Objects: extremal rays/faces, contractions, flips/flops, MMP with scaling, Mori fibre spaces, dlt
  modifications, lc-trivial fibrations with discriminant and moduli b-divisors, n-complements.
- Theorems: cone theorem with length bound; contraction theorem; BCHM (minimal models for klt pairs of
  log general type; finite generation); special termination; threefold terminal MMP; surface
  abundance; Ambro/Kawamata canonical bundle formula.
- Prereqs: PositivityAndVanishing, PairsAndKodairaDimension, RationalCurvesAndFanoVarieties
  (bend-and-break), R09.7.
- Families: 033–037, 056, 064, 066, 068.
- Formalizability: low-medium (BCHM is a long induction) but it is the single largest reuse hub.

### 4. SeveralComplexVariables — math.CV — L — T1
Holomorphic functions of several variables and the analytic theory of domains and Stein manifolds:
Cauchy integrals on polydiscs, Hartogs extension, Weierstrass preparation and division, the local
ring C{z} (Noetherian, factorial, Henselian), analytic germs and the Rückert Nullstellensatz,
plurisubharmonic functions and pseudoconvexity, Hörmander's L² solution of ∂̄, domains of holomorphy
and the Levi problem, Stein manifolds, Cartan's theorems A and B, Oka–Weil approximation, holomorphic
convexity and Remmert reduction, and the Andreotti–Frankel theorem on the homotopy type of Stein
manifolds.
- Prereqs: Mathlib several-variable analyticity, PDE (L² methods), ContourIntegration, DifferentialGeometry
  (forms), Tau Ceti Morse theory (`Geometry/Manifold/Morse`).
- Families: 042, 046, 058, 059, 064 (S); 057 (P). Explorer opportunity `unmapped:complex-geometry`.
- Formalizability: high (Hörmander, Gunning–Rossi).

### 5. ComplexAnalyticSpaces — math.CV — L — T1
Global complex-analytic geometry of complex spaces beyond the analytifications of PR #196 and
ComplexComparisonPartII: reduced and nonreduced complex spaces, analytic subsets and dimension theory,
irreducible components, normalization, Oka's coherence theorem, Remmert's proper mapping theorem,
Remmert–Stein, Grauert's direct image theorem and Cartan–Serre finiteness, meromorphic functions and
maps, algebraic dimension, Moishezon spaces, Fujiki class C, compact Kähler spaces, and the Douady
space of a compact complex space.
- Prereqs: SeveralComplexVariables; PR #196 L2 (shared category); ComplexComparisonPartII C0 (this
  roadmap generalizes its coherent-module layer — coordinate one carrier).
- Families: 033, 034, 036, 041, 046, 056, 058.
- Formalizability: medium.

### 6. KahlerManifoldsAndHodgeTheory — math.AG (sec. math.DG, math.CV) — XL — T1
Complex differential geometry and Hodge theory of compact complex and Kähler manifolds
(Griffiths–Harris ch. 0–1, Huybrechts, Voisin I): holomorphic tangent bundle and (p,q)-forms,
Dolbeault cohomology and Dolbeault's theorem, holomorphic distributions and the holomorphic Frobenius
theorem, Hermitian metrics on holomorphic bundles, Chern connection and curvature, Griffiths and
Nakano positivity, Kähler metrics and the Kähler identities, elliptic theory of Laplacians on compact
manifolds and the Hodge theorem, Hodge decomposition and symmetry, hard Lefschetz and the
Hodge–Riemann relations producing polarized Hodge structures in the HodgeStructures carrier, the
∂∂̄-lemma, Bott–Chern cohomology, Bochner–Kodaira–Nakano and Kodaira vanishing, the Kodaira embedding
theorem, Lefschetz (1,1), analytic Serre duality, Chern–Weil forms, and the Picard and Albanese tori.
This is the "geometric engine" HodgeStructures names as producing instances.
- Prereqs: ComplexManifolds (#279), DifferentialGeometry (forms, de Rham, Laplace–Beltrami), PDE
  (Sobolev, elliptic regularity), HodgeStructures, ComplexTori (#280), SeveralComplexVariables, PR #196
  (sheaf vs singular cohomology).
- Families: 032, 036, 041, 050, 051, 052, 054, 057, 068 (S), and the Hodge-type half of every
  Hodge-conjecture statement (with MotivesAndAlgebraicCycles MC.7).
- Formalizability: medium; the elliptic core is substantial but textbook.

### 7. VariationsOfHodgeStructure — math.AG — XL — T2
The successor named in HodgeStructures: local systems and flat bundles, variations of (polarized)
Hodge structure with Griffiths transversality, period domains as complex manifolds and period maps,
the Gauss–Manin connection and the VHS of a smooth projective family, Griffiths' curvature computation
and the Hodge metric, Deligne semisimplicity and the theorem of the fixed part, quasi-unipotence of
monodromy, Schmid's nilpotent orbit theorem (one variable), Deligne's mixed Hodge structure on the
cohomology of smooth quasi-projective varieties via log de Rham complexes, semipositivity of f_*ω
(Fujita–Kawamata) and Viehweg's weak positivity.
- Prereqs: KahlerManifoldsAndHodgeTheory, HodgeStructures, ShimuraData D3 (share the VHS carrier),
  PR #196 (local systems), ComplexComparisonPartII C5, R09.7d (SNC compactifications),
  PositivityAndVanishing.
- Families: 032, 033, 034, 036, 041, 043, 057.
- Formalizability: medium-low (Schmid).

### 8. PositiveCurrentsAndMongeAmpere — math.CV (sec. math.DG) — XL — T2
Pluripotential theory on complex manifolds (Demailly's book; Guedj–Zeriahi): quasi-psh functions,
currents and closed positive currents, Lelong numbers and Siu's analyticity theorem, Siu decomposition,
singular Hermitian metrics and pseudo-effectivity, analytic multiplier ideal sheaves and coherence,
analytic Nadel vanishing, Demailly regularization, Ohsawa–Takegoshi extension, Bergman kernels,
Bedford–Taylor Monge–Ampère operator, and Yau's solution of the Calabi conjecture with Aubin–Yau
Kähler–Einstein metrics.
- Prereqs: SeveralComplexVariables, KahlerManifoldsAndHodgeTheory, PDE, PositivityAndVanishing
  (comparison of multiplier ideals).
- Families: 033, 034, 036, 041, 051, 056, 057, 060, 062, 068 (all P).
- Formalizability: medium.

### 9. AlgebraicAndComplexSurfaces — math.AG (sec. math.CV) — XL — T2
Compact complex surfaces and smooth projective surfaces (Beauville; BHPV): intersection form and
Noether's formula, Castelnuovo's contractibility criterion and minimal models, ruled and rational
surfaces with Castelnuovo's rationality criterion, the Enriques–Kodaira classification of minimal
surfaces (algebraic first, then compact complex, including "Kähler iff b₁ even"), elliptic
fibrations with Kodaira's fibre classification and canonical bundle formula, surfaces of general
type, class VII surfaces (Hopf, Inoue, Enoki, Kato) and global spherical shells.
- Prereqs: SF.5 (surface RR, Hodge index), StableReduction L4–L5, PairsAndKodairaDimension,
  KahlerManifoldsAndHodgeTheory, ComplexAnalyticSpaces, ComplexTori (#280), Albanese.
- Families: 040, 042, 046, 060 (S/P); 039, 048 (P).
- Formalizability: medium-high for the algebraic classification.

### 10. K3AndHyperkahlerManifolds — math.AG — XL — T2
K3 surfaces and irreducible holomorphic symplectic manifolds (Huybrechts, *Lectures on K3*;
Gross–Huybrechts–Joyce): the K3 lattice (from IntegralLattices) and Hodge structures of K3 type,
Picard and transcendental lattices, the period domain, global Torelli and surjectivity of the period
map, Kähler and ample cones and (−2)-classes, elliptic K3s, the Kuga–Satake construction (even
Clifford algebra from OrthogonalSpinGroups), Hilbert schemes of points on K3s (Beauville), the
Beauville–Bogomolov–Fujiki form and Fujiki relation, Matsushita's theorem on Lagrangian fibrations,
cubic fourfolds with the Fano variety of lines (Beauville–Donagi) and Hassett's special divisors.
The Beauville–Bogomolov decomposition needs de Rham decomposition and Berger's holonomy theorem,
which no roadmap owns; a Riemannian-holonomy roadmap must supply them or this one must.
- Prereqs: AlgebraicAndComplexSurfaces, KahlerManifoldsAndHodgeTheory, HodgeStructures,
  IntegralLattices, OrthogonalSpinGroups, PositiveCurrentsAndMongeAmpere (Calabi–Yau), R09.2,
  AbelianSchemes A5.
- Families: 032, 041, 042, 054, 055.

### 11. RationalCurvesAndFanoVarieties — math.AG — XL — T2
Rational curves on algebraic varieties (Kollár; Debarre): deformation theory of morphisms from curves,
dimension estimates for Hom schemes (from R09.2), bend-and-break via reduction mod p, Mori's theorem
producing rational curves when K_X is not nef, free and very free curves, uniruled and rationally
(chain) connected varieties, the MRC fibration, Kollár–Miyaoka–Mori boundedness of smooth Fanos,
Graber–Harris–Starr, Picard number and pseudoindex, families of minimal rational curves and VMRTs,
Mori's characterization of P^n and Cho–Miyaoka–Shepherd-Barron, Fano manifolds with nef tangent
bundle in low dimension, and complex contact Fano manifolds and their lines (KPSW).
- Prereqs: R09.2, JacobianChallenge C, #545 (cone of curves), SF.4 (deformations), Mathlib
  `SpreadingOut`, FlagVarieties, PairsAndKodairaDimension.
- Families: 051, 052, 062, 063, 067 (S/P); 034, 057 (P).

### 12. FlagVarieties — math.AG (sec. math.RT) — L — T1
Projective homogeneous varieties: G/P for a parabolic subgroup as a smooth projective variety (Borel
fixed point theorem, Chevalley), Bruhat decomposition and Schubert cells, Pic(G/P) and line bundles
L_λ, Borel–Weil–Bott, the tangent bundle and its global generation, Grassmannians and partial flag
varieties of GL_n (matching R09.1), Schubert classes and Chevalley's formula, minuscule varieties, and
adjoint varieties P(O_min) ⊂ P(𝔤) with their contact structure.
- Prereqs: ReductiveGroups L3–L8, LieHighestWeight, R09.1, SF.5.
- Families: 043, 044, 062, 067. Formalizability: high.

### 13. GeometricInvariantTheory — math.AG (sec. math.RT, math.SG) — L — T1
Mumford's GIT over a field: reductive actions on affine and projective schemes, finite generation of
invariants (Hilbert, Nagata, Haboush), good and geometric quotients, linearizations, (semi)stability
and the Hilbert–Mumford criterion, group-level moment maps for compact Lie group actions and the
Kempf–Ness theorem (HamiltonianSystems #480 excludes group-level moment maps and reduction, so they are built here),
King stability and moduli of quiver representations, Nakajima quiver varieties, character varieties
Hom(π,G)//G, and moduli of semistable bundles on curves.
- Prereqs: ReductiveGroups (L6), R09.5, HamiltonianSystems (#480), RepresentationTheory/LieGroups,
  QuiverRepresentations, R09.2.
- Families: 043, 044 (S); 054, 055 (moduli of sheaves). Confirmed unowned: PELModuli calls GIT
  "unbuilt"; McKaySkewGroup (#223) lists GIT quotients and Nakajima varieties as out of scope.

### 14. ModuliOfStableCurves — math.AG — XL — T2
M̄_{g,n} as a smooth proper Deligne–Mumford stack (completing StableReduction's valuative
interface), forgetful, clutching and gluing maps, boundary strata indexed by stable graphs, the coarse
space, tautological classes ψ, κ, λ, the tautological ring and strata algebra, Keel's presentation of
A^*(M̄_{0,n}), Mumford's formula, string and dilaton, and Pixton's relations as statements.
- Prereqs: StableReduction, R09.4–R09.5, SF.5 (rational Chow of DM stacks), SF.4.
- Families: 053, 063, 065.

### 15. VirtualClassesAndGromovWitten — math.AG (sec. math.SG) — XL — T3
Cone stacks and the intrinsic normal cone, perfect obstruction theories and virtual classes
(Behrend–Fantechi, Li–Tian), virtual pullback, virtual localization (Graber–Pandharipande), moduli of
stable maps with their obstruction theory, GW and descendant invariants, Kontsevich–Manin axioms,
quantum cohomology and WDVV, and Quot-scheme obstruction theories on surfaces.
- Prereqs: ModuliOfStableCurves, StableReduction (stable maps), EquivariantCohomologyAndLocalization,
  SF.5 (refined Gysin), R09.2, R09.4.
- Families: 040, 053, 063, 065.

### 16. EquivariantCohomologyAndLocalization — math.AG (sec. math.AT) — L — T2
Borel equivariant cohomology, Edidin–Graham equivariant Chow groups and Chern classes,
Atiyah–Bott/Berline–Vergne and Chow-theoretic localization for torus actions, Białynicki-Birula
decompositions and equivariant formality, GKM descriptions of toric and flag varieties.
- Prereqs: AlgebraicTopology (+ ClassifyingSpaces #437), SF.5, ReductiveGroups (tori), FlagVarieties,
  AnalyticToricGeometry.
- Families: 040, 044, 053, 063, 065, 068.

### 17. DerivedCategoriesAndStability — math.AG (sec. math.CT) — XL — T2
D^b(Coh X) for smooth projective X on Mathlib's derived categories: Serre functors, exceptional
collections and semiorthogonal decompositions (Beilinson; Kuznetsov components of Fano
hypersurfaces), Fourier–Mukai transforms (Orlov's theorem), spherical twists, slope/Gieseker
stability and Harder–Narasimhan filtrations, Bogomolov–Gieseker on surfaces, numerical Grothendieck
groups (from GrothendieckEulerForms), tilting, Bridgeland stability conditions with the support
property and Bridgeland's deformation theorem, stability on surfaces and tilt stability on threefolds.
- Prereqs: Mathlib triangulated/derived categories, JacobianChallenge, SF.5, GrothendieckEulerForms,
  AlgebraicAndComplexSurfaces, PositivityAndVanishing (Serre duality).
- Families: 054, 055 (S); 040, 043 (P).

### 18. SingularityTheory — math.AG (sec. math.GT) — L — T2
Isolated hypersurface singularities: Milnor and Tjurina numbers, the Milnor fibration and bouquet
theorems, monodromy and Seifert forms, Brieskorn–Pham examples, plane curve singularities (Puiseux,
Zariski equisingularity), μ-constant families and Lê–Ramanujam, Whitney stratifications and
Teissier's μ* criterion; normal surface singularities: minimal resolution, dual graphs,
Mumford/Grauert contractibility, rational singularities and geometric genus; Artin approximation;
classification of high-dimensional simple fibred links by Seifert forms (Levine, Durfee, Kato).
- Prereqs: SeveralComplexVariables, DifferentialGeometry (Ehresmann, Morse), GeometricTopology
  (h-cobordism), R09.7/StableReduction, R09.6.
- Families: 048, 059, 064; P-input to 037.

### 19. OkaTheoryAndHyperbolicity — math.CV — L — T2
Holomorphic maps into complex manifolds from both ends: Kobayashi pseudodistance and hyperbolicity,
Brody's lemma and Brody hyperbolicity, Ahlfors–Schwarz and negatively curved examples; Gromov sprays,
Oka manifolds, equivalence of the convex approximation property with the Oka principle (Forstnerič),
and the standard examples (complex Lie groups, homogeneous spaces, complements of codimension-two
algebraic sets).
- Prereqs: SeveralComplexVariables, ConformalMapping, KahlerManifoldsAndHodgeTheory.
- Families: 042, 051.

### 20. LocallyNilpotentDerivations — math.AC (sec. math.AG) — L — T2
G_a-actions on affine varieties (Freudenburg): LNDs and exponential automorphisms, kernels, slices
and the slice theorem, degree functions, Makar-Limanov and Derksen invariants, Danielewski surfaces
and the Koras–Russell cubic, coordinates and stable coordinates, triangular and tame automorphisms,
Jung–van der Kulk.
- Prereqs: Mathlib. Families: 047, 049 (ports ~9k lines of OAI Lean).

Not proposed (frontier, single-family): Higgs bundles/nonabelian Hodge (043), BFN Coulomb branches
(044), D-modules on Bun_G and Whittaker categories (069), Saito Hodge modules (034), char-p threefold
MMP (035), Kähler MMP (056), weak factorization (054; natural late layer for the R09.7 owner),
Kudla–Millson theta lifting (032; campaign MetaplecticAutomorphicForms is the nearest owner).

## (d) Families

S: statement needs; P: proof needs. Owners in parentheses; **bold** = proposal.

| # | Short title | arXiv | Class | Key needs |
|---|---|---|---|---|
| 032 | Hodge for CM abelian varieties, K3 products, Kuga–Satake | math.AG | frontier (Kähler Hodge theory + unitary theta lifting + p-adic weak admissibility) | S: Chow (SF.5), Hodge decomposition (**Kähler**), cycle class (MC.7), CM AVs (campaign), **K3**. P: Lefschetz (1,1), ball quotients (ShimuraVarieties), theta lifts, PadicHodgeTheory |
| 033 | Orbifold/log Iitaka subadditivity | math.AG | frontier (Schmid/CKS curvature, weak positivity, canonical bundle formula) | S: **Pairs** (κ, κ̄, Campana base), SNC (R09.7), Fujiki C (**ComplexAnalyticSpaces**). P: **VHS**, **MMP** (cbf), **PositiveCurrents**. OAI LogKodaira partial |
| 034 | Log abundance (char 0, Kähler), uniform Iitaka/indices | math.AG | frontier (BCHM, Hodge modules, currents) | S: **Pairs**, #545, Kähler spaces. P: **MMP**, **PositivityAndVanishing**, Hodge modules, **PositiveCurrents**. OAI SectionFields partial |
| 035 | Char-p threefold abundance, ν=1 | math.AG | frontier (char-p threefold MMP) | S: **Pairs** (char-free), #545. P: char-p MMP |
| 036 | Numerical semiampleness, generalized pairs | math.AG | frontier (generalized-pair MMP) | S: **Pairs** (b-divisors, κ_σ), Bott–Chern (**Kähler**). P: **MMP**, **PositiveCurrents**. OAI NumericalDimension partial |
| 037 | ODP normalized-volume gap | math.AG | frontier (Li–Blum–Xu normalized volume theory) | S: **Pairs** (klt germs, normalized volume). P: **PositivityAndVanishing**, **MMP**, R09.7 |
| 038 | Fujita freeness | math.AG | needs **PositivityAndVanishing**, **Pairs**, R09.7 | S: #545 only. P: KV vanishing, lc thresholds, Okounkov-type bodies, principalization |
| 039 | Nagata; maximal Seshadri constants | math.AG | needs **PositivityAndVanishing** (statement); 2/4 formalized | S: blowups (Tau Ceti code/R09.7a), Seshadri constants, very general. P: surface intersection (SF.5), theta bases; higher-dim/char-p parts use degenerations |
| 040 | Bloch's conjecture, p_g=0 | math.AG | frontier (virtual localization on derived Quot schemes) | S: CH₀ (SF.5), Albanese (Tau Ceti code + A2), p_g, q (JacobianChallenge B). P: R09.2, **VirtualClasses**, **Equivariant** |
| 041 | Hyperkähler SYZ; P^n bases | math.AG | frontier (Matsushita/Verbitsky, collapsing hyperkähler metrics) | S: **K3AndHyperkahler** (IHS, BBF), **Kähler**, #545. P: Torelli, **PositiveCurrents** (Calabi–Yau), **VHS** |
| 042 | K3 surfaces are Oka | math.CV | frontier (spray constructions, K3 period dynamics) | S: #279 + simply connected + trivial K (nearly covered); **Oka**. P: **Surfaces**, **K3**, **SCV** |
| 043 | P=W fixed determinant | math.AG | frontier (nonabelian Hodge, decomposition theorem) | S: **GIT** (Higgs moduli, character varieties), perverse filtration (campaign, étale), MHS (**VHS**). P: nonabelian Hodge (none) |
| 044 | Equivariant Hikita | math.RT | frontier (BFN Coulomb branches) | S: **GIT** (Nakajima), **Equivariant**, BFN (none) |
| 046 | Shafarevich counterexamples | math.CV | needs **SCV**, **ComplexAnalyticSpaces**, UniversalCovers | S: universal cover (UniversalCovers + #279), Stein/holomorphic convexity. P: Andreotti–Frankel, complex hyperbolic arrangements (ShimuraVarieties) |
| 047 | Affine-space cancellation fails | math.AC | elementary (formalized) | S: Mathlib. P: **LocallyNilpotentDerivations** (port) |
| 048 | Lipman–Zariski counterexample | math.AG | needs **SingularityTheory** | S: Mathlib (`KaehlerDifferential`, `IsRegularLocalRing`). P: normal surface singularities, Artin algebraization (R09.6) |
| 049 | Stable coordinate / Abhyankar–Sathaye | math.AC | elementary (1/2 formalized) | S: Mathlib. P: **LocallyNilpotentDerivations** |
| 050 | Griffiths positivity counterexample | math.CV | needs **Kähler** (statement); formalized | S: #279 bundles, Hermitian metric + Griffiths positivity (**Kähler**), ample vector bundles (**PositivityAndVanishing**) |
| 051 | Kobayashi canonical ampleness | math.CV | frontier (extremal discs + Ou/Cao–Höring) | S: **Oka/Hyperbolicity**, **Kähler** (Kodaira embedding). P: **PositiveCurrents**, **RationalCurves** |
| 052 | Tangent splittings ⇒ product universal cover | math.AG | needs **Kähler**, **RationalCurves**; formalized | S: Kähler metric, holomorphic Frobenius, universal cover, rational connectedness |
| 053 | Pixton completeness fails in Chow | math.AG | frontier (Chow of M̄_{g,n} + virtual classes) | S: **ModuliOfStableCurves**, SF.5. P: **VirtualClasses**, R09.2, **Equivariant** |
| 054 | Irrational cubic fourfolds with K3 category | math.AG | frontier (weak factorization, Hassett lattice theory) | S: **DerivedCategories** (Kuznetsov component), **K3** (Hassett divisors), H^{2,2} (**Kähler**). P: weak factorization |
| 055 | Gepner and large-volume Bridgeland conditions | math.AG | frontier (BMT-type inequalities) | S: **DerivedCategories**, SF.5 (Chern characters). OAI Stability partial |
| 056 | Termination of fourfold (Kähler) MMP | math.AG | frontier (special termination, Kähler MMP) | S: **MMP** (flips), **Pairs**, Kähler spaces. P: **MMP**, Kähler MMP |
| 057 | Campana abelianity for special manifolds | math.AG | frontier (L² Dolbeault on covers, Corlette–Simpson) | S: **Pairs** (specialness), universal cover, **Kähler**. P: **PositiveCurrents**, Albanese torus |
| 058 | Kollár–Pardon semialgebraic universal covers | math.AG | needs RealAlgebraicGeometry + ShimuraData D2 (058_1 formalized); 058_0 frontier (Shafarevich/harmonic maps) | S: semialgebraic sets, bounded symmetric domains, universal covers |
| 059 | Zariski multiplicity counterexamples | math.AG | needs **SingularityTheory** (+ high-dim fibred links) | S: Mathlib-level germs; C{z} (**SCV**). OAI HypersurfaceGerms partial |
| 060 | Global spherical shells, class VII | math.CV | frontier (class VII theory) | S: **Surfaces**, κ of compact surfaces (**Pairs**), Betti numbers (#196) |
| 062 | Contact Fano / LeBrun–Salamon | math.DG | frontier (Hwang–Mok VMRT, Beauville's characterization) | S: contact structures (**RationalCurves**), adjoint varieties (**FlagVarieties**), LieHighestWeight; QK holonomy (none) |
| 063 | Generalized Mukai conjecture | math.AG | frontier (quantum cohomology/descendants) | S: #545 (Fano, ρ) + rational curves (**RationalCurves**) — nearly covered. P: **VirtualClasses**, **ModuliOfStableCurves** |
| 064 | μ-constant surface singularities | math.AG | frontier (Fernández de Bobadilla–Pełka Floer input, semistable log models) | S: Milnor number (**SingularityTheory**, **SCV**). P: Lê–Ramanujam, Teissier, R09.7 |
| 065 | Virasoro for complete intersections, P(E) towers | math.AG | frontier (descendant GW theory) | S: **VirtualClasses** (GW), **ModuliOfStableCurves** (ψ). P: **Equivariant**, R09.1 |
| 066 | Bounded klt complements | math.AG | frontier (Birkar's complements/BAB) | S: **Pairs** (ε-lc, Fano type), **MMP** (complements). OAI CartierSections partial |
| 067 | Campana–Peternell in dimension 6 | math.AG | frontier (Hwang–Mok, CMSB) | S: **FlagVarieties**, nef tangent bundle (R09.1 + #545). P: **RationalCurves** (VMRT), SF.5. OAI RelativeTriviality partial |
| 068 | Anticanonical nonvanishing | math.AG | frontier (Bergman metrics, DPS structure of nef −K) | S: **Kähler** (semipositive metric), #545. P: **PositiveCurrents**, **Equivariant**, **MMP**. OAI Anticanonical partial |
| 069 | Global quantum geometric Langlands, irrational level | math.AG | frontier (twisted D-modules on Bun_G, ∞-categories) | S: Bun_G (R09.4), D-modules (none), EnhancedDerivedSheaves |

arXiv primaries are inferred from content (the release gives none); 046_0 carries MSC 32Q30.

## (e) OAI Lean infrastructure worth porting

All Apache-2.0 (`lean/LICENSE`), all Mathlib-only. The roadmap rule "coordinate first, improve rather
than canonize" applies; sizes are line counts.

| OAI directory (family) | Lines | General content beyond Mathlib/Tau Ceti | Target |
|---|---|---|---|
| `AlgebraicGeometry/Seshadri` (039) | 56.6k | Point blowups via Rees algebras with universal property and uniqueness (`Blowup/ReesAlgebra`, `LocalUniversal`, `Uniqueness`, `SchemeHartogs`); Bertini (generic smoothness, generic hyperplanes, `Bertini/*`); Čech computations and finiteness of H^i on curves/surfaces; Euler characteristics and intersection numbers on smooth projective surfaces via χ (`Intersection/*`); ampleness from covers and powers; multipoint Seshadri constants | **PositivityAndVanishing**; blowups to R09.7a/StableReduction L4 (Tau Ceti has only affine Rees charts) |
| `AlgebraicGeometry/PlaneCurves` (039) | 37.0k | Multiplicity of plane curves, effective cycles ↔ homogeneous forms, Zariski-closed configuration loci, multiplicative theta products and Laurent bases | PositivityAndVanishing (examples); theta part to an NT owner |
| `AlgebraicGeometry/NumericalDimension` (036) | 29.0k | `ComplexProjectiveVariety`, Weil and Q-Weil divisors, canonical divisors from rational top forms, Cartier pullback, algebraic multiplier ideals/sheaves, discrepancies, klt members, terminal models, normal crossings | AbundanceStatement (#545) Layers 1–3 and **PairsAndKodairaDimension** — direct overlap with #545, coordinate before either proceeds |
| `AlgebraicGeometry/LogKodaira` (033) | 4.6k | SNC boundaries as ideal-sheaf families, log pluriforms, log Kodaira dimension via algebraic independence, very-general predicate | **PairsAndKodairaDimension** (replace the algebraic-independence κ by the Iitaka-dimension definition and prove agreement) |
| `AlgebraicGeometry/SectionFields` (034) | 5.1k | Q-Cartier divisors, geometric generic fibre, Galois/flat descent of sections, effective Iitaka systems | **PairsAndKodairaDimension** |
| `AlgebraicGeometry/RelativeTriviality` (067) | 4.6k | Čech cohomology of relative P¹, locally free sheaves, fibrewise triviality ⇒ triviality near a fibre | JacobianChallenge C / R09.1 |
| `AlgebraicGeometry/CartierSections` (066) | 3.4k | Monomial valuations and extensions, formal coordinates in étale charts, normalized cones | **PairsAndKodairaDimension** (valuations) |
| `Geometry/KahlerSplitting` (052) | 15.0k | Kähler metrics in charts, holomorphic projections and integrability, plaque charts, holomorphic Frobenius, product decomposition of universal covers | **KahlerManifoldsAndHodgeTheory** (Layer 0, holomorphic foliations) |
| `Geometry/SplitTangent` (052) | 32.0k | Holomorphic foliations and leaves, leaf quotients, rational curves on projective manifolds, jets along leaves | **KahlerManifoldsAndHodgeTheory**, **RationalCurvesAndFanoVarieties** |
| `Geometry/QuadricBundles` (050) | 12.3k | Rank-two bundles by transition matrices, Hermitian metrics, Chern curvature in charts, Griffiths positivity, ampleness via embeddings, psh averages | **KahlerManifoldsAndHodgeTheory** (Chern curvature), **PositivityAndVanishing** (ample bundles) |
| `Geometry/Anticanonical` (068) | 4.4k | Canonical/anticanonical bundles of complex manifolds as Mathlib `ContMDiff` bundles, product decompositions, naturality of sections | ComplexManifolds (#279) Milestone 7 |
| `Geometry/HypersurfaceGerms` (059) | 5.1k | Weierstrass-type preparation, orders and multiplicities of germs | **SeveralComplexVariables**, **SingularityTheory** |
| `Analysis/SymmetricDomains` (058) | 50.9k | Semialgebraic sets in C^n, Nash functions, Tarski queries and Hermite signatures, Bishop discs, Cartan uniqueness, bounded symmetric domains | RealAlgebraicGeometry (Tarski/semialgebraic overlap), **SeveralComplexVariables**, ShimuraData D2 |
| `Algebra/AffineCancellation`, `AlgebraicGeometry/CommutingDerivations`, `AbhyankarSathaye` (047, 049) | 9.2k | LNDs, exponential automorphisms, graded/Rees reductions, explicit polynomial-ring isomorphisms | **LocallyNilpotentDerivations** |
| `AlgebraicGeometry/Stability` (055) | 0.6k | Numerical twisted Chern characters and tilt-wall inequalities | **DerivedCategoriesAndStability** (small) |

Coordination points: (1) OAI `NumericalDimension` vs AbundanceStatement #545 (same divisor/canonical/
discrepancy layer, built independently); (2) resolution, GAGA, Chow, Hilbert schemes and stacks are
campaign-owned (R09.x, SF.5, ComplexComparisonPartII) and the proposals above consume them rather than
duplicate; (3) Riemannian holonomy (Bogomolov decomposition, quaternionic-Kähler) is unowned in all
three supply sources.
