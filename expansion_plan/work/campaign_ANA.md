# Campaign ANA: analysis and PDE — phase-2 slate (2026-10-07)

## 1. Scope

**Classes:** math.CA, math.CV, math.AP, math.NA, math.OC. Real and harmonic analysis, geometric measure theory, one- and several-variable complex analysis, nonlinear PDE, optimization and validated numerics. Elliptic operators on compact manifolds (GEO), complex analytic spaces and Kähler/Hodge theory (AG), spectral theory (FAMP), polyhedral combinatorics (COMB) and qualitative ODE (PRDS, see §6) are outside by BOUNDARIES.md.

**Demand** (`needs_all.jsonl`, `campaign == ANA`): 190 needs on 87 OpenAI families, 9 Annals definitions (#71, #84–#91) and one LMFDB section (`hgm`). By class: CA 68, AP 51, CV 49, OC 16, NA 6. Another 110 rows elsewhere name ANA as secondary (GEO 45, PRDS 28, AG 17, TOP 7, NT 4, LTCS 4, COMB 4, FAMP 1).

| goal | gap | mathlib | tauceti-code | tauceti-roadmap | open-pr | birkbeck | oai-lean | total |
|---|---|---|---|---|---|---|---|---|
| OpenAI | 100 | 20 | 16 | 17 | 8 | 3 | 14 | 178 |
| Annals | 8 | – | 1 | 1 | 1 | – | – | 11 |
| LMFDB | 1 | – | – | – | – | – | – | 1 |

The slate absorbs 93 of the 109 gap needs; §4 places the other 16.

## 2. Existing supply

| roadmap | covers | goals served | action |
|---|---|---|---|
| PDE (main, AP) | Euclidean linear elliptic/parabolic lanes; Lane D done; Lane B (CZ, Riesz–Thorin, BMO) not begun | Annals #86 (Dirichlet); OAI#091, 260, 278, 369, 370 | **extend**: merge #93; add Neumann problems and spectrum to Lane D (OAI#369); move the Strichartz and quasilinear stretch goals to Dispersive and NonlinearElliptic; vendor Lane B from `carleson` (critical path for HarmonicAnalysis) |
| PR #93 (PDE fix) | ABP, Krylov–Safonov, non-divergence track; defers viscosity solutions to "a separate roadmap" | prerequisite of NonlinearEllipticEquations | **merge soon** |
| ConformalMapping (main, CV) | RMT, Carathéodory (Jordan), reflection, Schwarz–Christoffel; all seven layers have their central theorems | OAI#071, 072, 224, 230, 325, 369 (partial) | **leave**; GeometricFunctionTheory and QC maps start where it stops |
| FuchsianOrbifolds (main, CV) | Fuchsian groups, quotient Riemann surfaces, X(1) ≅ P¹ | NT consumers | leave |
| OptimalTransport (main, OC) | couplings to Gromov–Wasserstein; real Monge–Ampère (L6), MTW; L6–7, 9–11, 14–16 untouched | Annals #91 (real case); OAI#091, 101, 353, 360, 373, 374 | leave; largest supplier in the territory |
| Completed ContourIntegration (CV), OrthogonalL2Bases (CA) | residues, homology Cauchy; L² polynomial bases | consumed | leave |
| IncompressibleFlows #237 (AP) | NS/Euler on 𝕋ᵈ and ℝᵈ, Leray–Hopf, CKN, Fujita–Kato; Layer 10 general Littlewood–Paley, Besov, paraproducts; DiPerna–Lions transport | Annals #90; OAI#376, 363, 371 | **merge soon**: prerequisite of RealVariableHarmonicAnalysis, Dispersive, Kinetic, ConvexIntegration |
| ComplexManifolds #279 (CV) | charts, quotients, gluing, holomorphic bundles, Riemann sphere | OAI#042, 046, 050, 060, 338 | **merge soon**: carrier for SCV's Stein layer, Oka, Pluripotential and AG's Kähler roadmaps |
| ComplexTori #280 (CV) | complex-torus families, log transforms | AG (Albanese, OAI#057) | merge after #279 |
| LaguerreJacobi #117 (CA) | Laguerre/Jacobi polynomials and L² bases | consumed by ClassicalFourierAnalysis, LinearDifferentialEquations… | merge; add Gegenbauer as the Jacobi specialization |
| StructuredBlockOperators #260 (NA) | exact block-constant operators, certified complexity | none | leave; disjoint from ValidatedNumerics |
| Birkbeck ComplexComparisonPartII | coherent analytic sheaves, GAGA | AG | AG's; its C0 consumes SCV's ℂ{z}, Weierstrass and Oka coherence |
| Birkbeck ExponentialSumsAndCircleMethod | ES.2 Vinogradov via decoupling | NT | decoupling layer → Decoupling (coordination §3.3) |
| explorer drafts SeveralComplexVariablesKahlerGeometry, ConformalMappingPartII | SCV + Kähler; CDT disc coverings, Schwarzians, ₂F₁ | – | CV.0–3 → SCV, CV.4–6 → AG; O0/S0/H0 → LinearDifferentialEquations…, U0 → QC maps; rest NT |
| Lean: `carleson`, `rellich-kondrachov`, `leancert`, `lana-agents/oka` (OAI deps) | Lorentz/CZ/tiles/Carleson–Hunt; Sobolev on manifolds; intervals; Oka | – | porting sources (RVHA/TFA, GEO, ValidatedNumerics, Oka); coordinate first |

## 3. The slate

28 new roadmaps: four XL families with sub-roadmaps (the RepresentationTheory model) and two standalone M. Names below are sub-directories of their family (`HarmonicAnalysis/Decoupling`, …). Goals list the needs a roadmap serves directly or as named supplier of another campaign's roadmap.

### HarmonicAnalysis — XL family (math.CA), 6 sub-roadmaps, ≈1,180 PRs

Starts above PDE Lane B (maximal inequality, interpolation, CZ, Mihlin, BMO) and #237 Layer 10 (Littlewood–Paley, Besov, paraproducts), which it consumes; members run from classical to curvature-dependent.

**ClassicalFourierAnalysis** — math.CA, L ≈250, wave A. This roadmap builds the classical Fourier analysis of the circle, the torus, the disc and Euclidean space that Mathlib's Fourier transform and Fourier coefficients leave open. On 𝕋ⁿ it covers kernels, summability, divergence phenomena, the conjugate function and inequalities for trigonometric polynomials. On the disc and half-plane it covers the Hardy spaces H^p, p ≠ 2, ∞, with boundary values and factorization, consuming FAMP's H²(𝔻) and H^∞ carriers. On ℝⁿ it covers the Hilbert transform, Paley–Wiener theory, radial Fourier transforms, spherical harmonics and the cosine and Funk transforms. Higher-dimensional singular integrals are RealVariableHarmonicAnalysis's, a.e. convergence of Fourier series TimeFrequencyAnalysis's, and Bessel asymptotics LinearDifferentialEquationsAndSpecialFunctions'.

- *Objects:* Fejér/Poisson kernels, conjugate function, H^p(𝔻), spherical harmonics, cosine transform. *Milestones:* Kolmogorov L¹ divergence; M. Riesz; Fatou and Riesz factorization; Paley–Wiener; Funk–Hecke.
- *Prereqs:* Mathlib Fourier; OrthogonalL2Bases; #117; FAMP NonselfadjointOperatorTheory. *Goals:* OpenAI 5: #075, 076, 088, 090, 369. *Porting:* OAI Analysis/Littlewood; carleson DirichletKernel. *Note:* high, textbook.

**RealVariableHarmonicAnalysis** — math.CA, L ≈250, wave A. This roadmap develops the real-variable theory of operators and function spaces on ℝⁿ, 𝕋ⁿ, ℤⁿ and spaces of homogeneous type, starting where PDE Lane B stops and consuming IncompressibleFlows Layer 10. It builds Lorentz and Orlicz spaces with real and complex interpolation of Banach couples, maximal operators beyond Hardy–Littlewood, real Hardy spaces with H¹–BMO duality and tent spaces, and Muckenhoupt weights with extrapolation and sparse domination. It develops vector-valued and non-doubling Calderón–Zygmund theory, the T(1) and T(b) theorems, Calderón commutators and Coifman–Meyer multipliers, variation norms, Triebel–Lizorkin and negative-order Besov spaces on domains, and discrete analogues on ℤⁿ. Modulation-invariant operators are TimeFrequencyAnalysis's, curvature FourierRestriction's, and singular integrals on rectifiable sets QuantitativeRectifiability's.

- *Objects:* Lorentz/Orlicz spaces, interpolation functors, H¹ and BMO, A_p weights, sparse operators, variation norms. *Milestones:* Stein interpolation; spherical maximal theorem; H¹–BMO duality; A₂ theorem; T(1) (David–Journé, NTV); Coifman–McIntosh–Meyer.
- *Prereqs:* PDE Lane B; #237 Layer 10. *Goals:* OpenAI 8: #075, 078, 081, 083, 085, 216, 225, 261. *Porting:* carleson (Lorentz, interpolation, CZ decomposition); OAI DiskMaximal, RieszRectifiability. *Note:* high; carleson already has the Lorentz layer.

**TimeFrequencyAnalysis** — math.CA, L ≈200, wave B. This roadmap treats operators invariant under modulations as well as translations and dilations, analyzed by phase-space decompositions into tiles. It builds tile structures, trees, forests and antichains with the size and density lemmas in the doubling-metric generality of the Carleson project, and proves the metric Carleson and Carleson–Hunt theorems with extrapolation near L¹. It then proves boundedness of the bilinear Hilbert transform, the variational Carleson theorem and the Lacey–Li and Bateman–Thiele theorems on Hilbert transforms along vector fields, and develops heat-flow methods for multilinear forms. Coifman–Meyer multipliers are RealVariableHarmonicAnalysis's and Gowers-norm inverse theorems COMB's; trilinear Hilbert transforms and Lipschitz vector fields enter only as statements.

- *Objects:* tiles, trees, forests, Carleson operator, bilinear and directional Hilbert transforms. *Milestones:* metric Carleson; Carleson–Hunt; Lacey–Thiele; variational Carleson; Lacey–Li.
- *Prereqs:* RealVariableHarmonicAnalysis. *Goals:* OpenAI 4: #075, 082, 083, 086. *Porting:* carleson (coordinate with van Doorn–Thiele); OAI TriangularHilbert. *Note:* very high for Carleson–Hunt, already in Lean.

**FourierRestriction** — math.CA, L ≈250, wave A. This roadmap develops Fourier analysis with curvature: oscillatory integrals and the restriction, Bochner–Riesz, local-smoothing and Schrödinger-maximal problems. It builds stationary phase in ℝⁿ, oscillatory integral operators, surface measures on curved hypersurfaces with their Fourier decay, and extension operators, and proves the classical linear theorems before the wave-packet, multilinear and polynomial-partitioning methods. Kakeya and Brascamp–Lieb inputs are KakeyaAndBrascampLieb's, decoupling is Decoupling's, Strichartz estimates for evolution equations are DispersiveEquations', and the polynomial ham-sandwich theorem is COMB's. One-variable exponential sums stay with NT's ExponentialSumsAndCircleMethod, which consumes the stationary-phase layer.

- *Objects:* oscillatory integral operators, surface measures, extension operators, Bochner–Riesz means, wave packets. *Milestones:* Stein–Tomas; Carleson–Sjölin and the ball multiplier; BCT multilinear restriction; Guth's ℝ³ estimate; Du–Guth–Li.
- *Prereqs:* RealVariableHarmonicAnalysis; KakeyaAndBrascampLieb; COMB DiscreteGeometryAndIncidences. *Goals:* Annals 1: #89; OpenAI 5: #073, 077, 078, 079, 080. *Porting:* none in Lean; OAI comparator statements. *Note:* medium; multilinear layers wait on Kakeya.

**Decoupling** — math.CA, M ≈110, wave B. This roadmap proves ℓ² and ℓ^p decoupling inequalities and their standard applications. It builds decoupling constants, parabolic rescaling and the Bourgain–Guth multilinear-to-linear reduction, and runs induction on scales for curved hypersurfaces, the cone and nondegenerate curves. Its applications are Vinogradov's mean value theorem, exported to NT's ExponentialSumsAndCircleMethod (ES.2), Strichartz estimates on tori and local smoothing. Small-cap decoupling and sharp local smoothing are stated. Multilinear restriction and Kakeya are consumed from FourierRestriction and KakeyaAndBrascampLieb.

- *Objects:* decoupling constants, caps, nondegenerate curves, Vinogradov integrals. *Milestones:* Bourgain–Guth reduction; Bourgain–Demeter; Bourgain–Demeter–Guth; Vinogradov mean value theorem.
- *Prereqs:* FourierRestriction; KakeyaAndBrascampLieb. *Goals:* Annals 1: #89; OpenAI 2: #077, 079. *Porting:* none; Demeter's book. *Note:* medium; induction on scales.

**KakeyaAndBrascampLieb** — math.CA, M ≈120, wave A. This roadmap develops the geometry of tubes in ℝⁿ that controls restriction theory. It constructs Besicovitch sets, proves the planar Kakeya theorems, formulates the Kakeya set and maximal conjectures with their implications, and proves the bush and hairbrush bounds. It builds Brascamp–Lieb inequalities with Lieb's theorem and the Bennett–Carbery–Christ–Tao finiteness criterion, and proves multilinear Kakeya with Guth's endpoint; the Wang–Zahl three-dimensional theorem is stated. Polynomial partitioning, ham sandwich and finite-field Kakeya are COMB's DiscreteGeometryAndIncidences, Milnor–Thom bounds AG's, Furstenberg sets and projections FractalGeometry's, and the Brascamp–Lieb variance inequality PRDS's.

- *Objects:* Besicovitch sets, δ-tubes, Kakeya maximal function, Brascamp–Lieb data. *Milestones:* Davies; Córdoba; hairbrush; BCCT finiteness; multilinear Kakeya with Guth's endpoint.
- *Prereqs:* Mathlib dimH; COMB DiscreteGeometryAndIncidences; AG Milnor–Thom. *Goals:* Annals 1: #89; OpenAI 2: #074, 078. *Porting:* OAI MeasureTheory/Falconer (fixed-scale Kakeya). *Note:* medium–high.

### GeometricMeasureTheory — XL family (math.CA), 5 sub-roadmaps, ≈970 PRs

On Mathlib's Hausdorff measure, Rademacher, covering theorems and Jacobian change of variables and Tau Ceti's Sobolev spaces; GEO's MinimalSubmanifolds and GeometricFlows consume it.

**RectifiabilityAndBV** — math.CA, L ≈250, wave A. This roadmap develops rectifiability and functions of bounded variation in ℝⁿ (Federer, Evans–Gariepy, Ambrosio–Fusco–Pallara, Maggi). It proves the area and coarea formulas, builds rectifiable sets and measures with densities and approximate tangent planes, and proves the rectifiable half of the Besicovitch–Federer theorem. It develops BV(Ω), sets of finite perimeter with De Giorgi's structure theorem, Gauss–Green and the sharp isoperimetric inequality, and SBV with Ambrosio compactness and Mumford–Shah existence. Currents and varifolds are CurrentsAndVarifolds', regularity of minimizers MinimalBoundariesAndIsoperimetry's, the unrectifiable half of Besicovitch–Federer FractalGeometry's, and one-variable BV Mathlib's.

- *Objects:* rectifiable sets and measures, BV(Ω), reduced boundary, SBV. *Milestones:* area and coarea formulas; De Giorgi structure theorem; isoperimetric inequality; Mumford–Shah existence.
- *Prereqs:* Mathlib Hausdorff measure, Rademacher; Tau Ceti Sobolev. *Goals:* Annals 1: #71; OpenAI 5: #071, 085, 337, 354, 366. *Porting:* OAI CircleDomains/Sobolev, Perimeter, CAT0Fillings. *Note:* medium–high; coarea is the long pole.

**CurrentsAndVarifolds** — math.CA, L ≈250, wave B. This roadmap builds the two weak notions of submanifold in geometric measure theory and their compactness theory (Federer, Simon, Ambrosio–Kirchheim). For currents it develops mass, boundary and flat norm, normal, rectifiable and integral currents, Federer–Fleming compactness, the deformation theorem, slicing and the Plateau problem, and Ambrosio–Kirchheim currents in metric spaces. For varifolds it develops first variation, the monotonicity formula, and Allard's compactness and regularity theorems. Regularity of area-minimizing hypersurfaces is MinimalBoundariesAndIsoperimetry's; min–max and the smooth theory of minimal submanifolds are GEO's MinimalSubmanifolds, and Brakke flow is GEO's GeometricFlows.

- *Objects:* normal, rectifiable and integral currents, flat norm, metric currents, varifolds. *Milestones:* Federer–Fleming compactness; deformation theorem; Plateau existence; monotonicity; Allard regularity.
- *Prereqs:* RectifiabilityAndBV; DifferentialGeometry. *Goals:* Annals 2: #71, #85; OpenAI 3: #337, 346, 349. *Porting:* OAI IntegralFillings, CAT0Fillings, Varifold. *Note:* medium; Allard is the hardest proof.

**MinimalBoundariesAndIsoperimetry** — math.CA, M ≈130, wave B. This roadmap develops the regularity theory of perimeter minimizers and the isoperimetric problem (Giusti, Maggi). It proves density and monotonicity estimates, De Giorgi's ε-regularity, minimizing tangent cones and Federer's dimension reduction in an abstract form that free-boundary problems reuse. It proves Simons' classification of stable cones, the minimality of the Simons cone, the n − 8 bound on singular sets and Bernstein's theorem, exporting them to GEO's MinimalSubmanifolds. It proves existence and regularity of isoperimetric regions in compact manifolds and flat tori with their constant-mean-curvature boundaries. Almgren's higher-codimension regularity is stated, and index and min–max theory are GEO's.

- *Objects:* perimeter minimizers, tangent cones, singular sets, Simons cone, isoperimetric profile. *Milestones:* ε-regularity; dimension reduction; Simons and BDG; Bernstein (n ≤ 8); isoperimetric regions.
- *Prereqs:* RectifiabilityAndBV; CurrentsAndVarifolds. *Goals:* OpenAI 7: #260, 278, 336, 337, 354, 367, 375. *Porting:* OAI Perimeter, CubicTorus, StableBernstein. *Note:* medium; Giusti is a complete route.

**QuantitativeRectifiability** — math.CA, M ≈120, wave B. This roadmap develops quantitative rectifiability of sets and measures (David–Semmes, Tolsa). It builds Ahlfors–David regular measures, Jones β-numbers and Menger curvature, proves the analyst's traveling salesman theorem, and characterizes uniform rectifiability by big pieces of Lipschitz images and by the Carleson β² condition. It proves that odd Calderón–Zygmund kernels are bounded on uniformly rectifiable sets and the Mattila–Melnikov–Verdera theorem, and states Nazarov–Tolsa–Volberg, Tolsa's semiadditivity and the harmonic-measure characterization, with the four-corner Cantor set as counterexample. Qualitative rectifiability is RectifiabilityAndBV's and non-doubling Calderón–Zygmund theory RealVariableHarmonicAnalysis's.

- *Objects:* AD-regular measures, β-numbers, Menger curvature, uniformly rectifiable sets. *Milestones:* traveling salesman theorem; UR ⇔ Carleson β²; CZ bounds on UR sets; Mattila–Melnikov–Verdera.
- *Prereqs:* RectifiabilityAndBV; RealVariableHarmonicAnalysis. *Goals:* Annals 1: #84; OpenAI 1: #081. *Porting:* OAI RieszRectifiability/Foundations. *Note:* medium; NTV and Tolsa stay statements.

**FractalGeometry** — math.CA, L ≈220, wave A. This roadmap develops the dimension theory of sets and measures in Euclidean and metric spaces (Falconer, Mattila, Bishop–Peres). It builds box, packing, Assouad and Fourier dimensions, gauge Hausdorff measures, Riesz energies and capacities, Frostman's lemma and the dimensions of measures. It proves the Marstrand–Kaufman–Mattila projection and slicing theorems and the classical bounds for Falconer's distance problem and Furstenberg sets, with recent projection and Furstenberg theorems stated. It develops iterated function systems, self-similar measures and Bernoulli convolutions, consuming entropy from PRDS's ErgodicTheory. Kakeya is KakeyaAndBrascampLieb's and rectifiability RectifiabilityAndBV's.

- *Objects:* box, packing, Assouad and Fourier dimensions, energies, capacities, IFS, self-similar measures. *Milestones:* Frostman; Marstrand–Kaufman–Mattila; Wolff–Erdoğan; Feng–Hu; Erdős's Pisot theorem.
- *Prereqs:* Mathlib dimH; PRDS ErgodicTheory (entropy layer). *Goals:* OpenAI 5: #073, 148, 153, 223, 230. *Porting:* OAI Falconer/Frostman, SelfSimilar. *Note:* high for classical layers.

### ComplexAnalysis — XL family (math.CV), 6 sub-roadmaps, ≈1,250 PRs

Starts where ConformalMapping and ContourIntegration stop, on ComplexManifolds #279; complex spaces and Kähler/Hodge theory are AG's, Calabi–Yau metrics GEO's, Teichmüller theory TOP's, Nevanlinna theory Mathlib's.

**GeometricFunctionTheory** — math.CV, L ≈250, wave A. This roadmap develops univalent functions and the boundary behavior of conformal maps, starting where ConformalMapping stops. It builds the classes S and Σ with their coefficient and distortion theory, Löwner chains and the chordal and radial Loewner equations through de Branges' theorem, and prime ends with Carathéodory's general correspondence and Kellogg–Warschawski regularity. It develops logarithmic potential theory in the plane, harmonic measure and integral-means spectra. SLE and planar Brownian motion are PRDS's and consume the Loewner and harmonic-measure layers; Riesz energies in ℝⁿ are FractalGeometry's, and value distribution is Mathlib's.

- *Objects:* S, Σ, Löwner chains, prime ends, logarithmic capacity, harmonic measure, integral-means spectra. *Milestones:* Koebe one-quarter and distortion; Loewner equation; de Branges; Kellogg–Warschawski; Beurling projection.
- *Prereqs:* ConformalMapping; ContourIntegration; PDE Lane C. *Goals:* OpenAI 8: #072, 218, 223, 224, 230, 232, 267, 325. *Porting:* OAI IntegralMeans; Tau Ceti Conformal code. *Note:* high; conformal library is mature.

**QuasiconformalMapsAndUniformization** — math.CV, L ≈250, wave A. This roadmap develops quasiconformal maps, extremal length and the uniformization of plane domains and Riemann surfaces. It builds the modulus of curve families, the equivalent definitions of K-quasiconformality, the Beurling transform and the measurable Riemann mapping theorem with parameters, and quasisymmetry with the Beurling–Ahlfors extension. It proves Koebe's uniformization of finitely connected domains by circle domains, removability theorems, the circle-packing theorem with Rodin–Sullivan convergence, and the Koebe–Poincaré uniformization theorem for Riemann surfaces, which no roadmap owns today. Teichmüller spaces are TOP's, and quasisymmetric analysis on metric spaces beyond the plane is GEO's.

- *Objects:* modulus, K-qc maps, Beltrami coefficients, quasicircles, circle domains, circle packings. *Milestones:* Ahlfors–Bers; Beurling–Ahlfors; Koebe circle domains; Koebe–Andreev–Thurston; Koebe–Poincaré uniformization.
- *Prereqs:* ConformalMapping; Tau Ceti Sobolev; PDE Lanes B–C; UniversalCovers. *Goals:* Annals 1: #72; OpenAI 2: #071, 246. *Porting:* OAI CircleDomains (211k lines). *Note:* high.

**LinearDifferentialEquationsAndSpecialFunctions** — math.CA, M ≈130, wave A. This roadmap develops linear ordinary differential equations in the complex domain and the special functions they define. It builds monodromy of holomorphic linear systems, regular singular points with Fuchs' criterion and the Frobenius method, the Gauss and generalized hypergeometric equations with Schwarz's list, and the identification of hypergeometric monodromy with NT's hypergeometric groups. For irregular singular points it develops sectorial asymptotic expansions and applies them to the confluent hypergeometric, Whittaker and Bessel equations. Real ODE existence is Mathlib's, orthogonal polynomials LaguerreJacobi's (#117), and Levelt's theorem, the Beukers–Heckman criteria and hypergeometric motives NT's HypergeometricMotives.

- *Objects:* monodromy representations, regular singular points, ₂F₁ and pFq equations, Whittaker and Bessel functions. *Milestones:* Fuchs criterion; Riemann's characterization of ₂F₁; Schwarz's list; sectorial asymptotics; Bessel asymptotics.
- *Prereqs:* Mathlib besselJ, hypergeometric series; ContourIntegration; #117; NT HypergeometricMotives. *Goals:* LMFDB 2: hgm, maass. *Porting:* explorer ConformalMappingPartII O0, S0, H0. *Note:* high, classical.

**SeveralComplexVariables** — math.CV, L ≈250, wave A. This roadmap develops holomorphic functions of several variables and the function theory of domains and Stein manifolds (Hörmander, Gunning–Rossi). It builds Hartogs phenomena, the ring ℂ{z} with Weierstrass preparation and division, germs of analytic sets, and Oka's and Cartan's coherence theorems on ℂⁿ. It develops plurisubharmonic functions and pseudoconvexity, Hörmander's L² solution of ∂̄ and the Levi problem, Stein manifolds with Cartan's Theorems A and B and the embedding theorem, Bergman kernels, and automorphisms of bounded domains. Global complex spaces are AG's ComplexAnalyticSpaces, closed positive currents PluripotentialTheory's, and complex manifolds and bundles ComplexManifolds #279's.

- *Objects:* ℂ{z}, analytic germs, coherent sheaves on domains, psh functions, Stein manifolds, Bergman kernels. *Milestones:* Hartogs; Weierstrass preparation; Oka coherence; Hörmander ∂̄ and the Levi problem; Cartan A/B.
- *Prereqs:* Tau Ceti CauchyIntegralPolydisc; ComplexManifolds #279 (Stein layer); DifferentialGeometry. *Goals:* OpenAI 8: #032, 042, 046, 058, 059, 064, 338, 359. *Porting:* explorer SCV draft CV.0–CV.3; OAI HypersurfaceGerms, SymmetricDomains. *Note:* high.

**OkaTheoryAndHyperbolicity** — math.CV, M ≈120, wave B. This roadmap develops holomorphic maps into complex manifolds from the two opposite ends, rigidity and flexibility. It builds the Kobayashi pseudodistance, the Ahlfors–Schwarz lemma and Brody's lemma and theorem, and hyperbolic embeddedness of hyperplane complements. On the flexible side it builds sprays, the convex approximation property and Oka manifolds, and proves the Oka–Grauert and Gromov Oka principles and Forstnerič's equivalence of CAP with the Oka property, with the standard examples. Stein manifolds are SeveralComplexVariables', K3 surfaces AG's, and Green–Griffiths–Lang is stated only.

- *Objects:* Kobayashi pseudodistance, Brody curves, sprays, Oka manifolds. *Milestones:* Ahlfors–Schwarz; Brody; Oka–Grauert; Gromov's Oka principle; CAP ⇔ Oka.
- *Prereqs:* SeveralComplexVariables; #279. *Goals:* OpenAI 2: #042, 051. *Porting:* lana-agents/oka (coordinate first). *Note:* medium.

**PluripotentialTheory** — math.CV, L ≈250, wave B. This roadmap develops pluripotential theory on domains of ℂⁿ and on complex manifolds (Demailly, Guedj–Zeriahi). It builds closed positive currents, quasi-plurisubharmonic functions, Lelong numbers with Siu's theorem, and the Bedford–Taylor complex Monge–Ampère operator with capacities, pluripolar sets and the Siciak extremal function. On complex manifolds it develops Demailly regularization, singular Hermitian metrics, analytic multiplier ideals with Nadel vanishing, the Ohsawa–Takegoshi extension theorem, and the Monge–Ampère operator on compact Kähler manifolds with Kołodziej's estimate. Yau's theorem and Kähler–Einstein metrics are GEO's CalabiYauAndComplexMongeAmpere, algebraic multiplier ideals AG's VanishingTheorems, and real Monge–Ampère OptimalTransport's.

- *Objects:* closed positive currents, quasi-psh functions, Lelong numbers, (dd^c u)^n, multiplier ideals. *Milestones:* Siu; Bedford–Taylor; Demailly regularization; Nadel; Ohsawa–Takegoshi; Kołodziej.
- *Prereqs:* SeveralComplexVariables; AG KahlerManifolds; #279. *Goals:* Annals 2: #76, #91; OpenAI 10: #033, 034, 036, 041, 051, 057, 062, 068, 087, 342. *Porting:* OAI TamingCompatibility. *Note:* medium; compact-Kähler layers wait on AG.

### NonlinearPDE — XL family (math.AP), 9 sub-roadmaps, ≈1,570 PRs

Above the linear PDE roadmap (with #93) and beside #237 and OptimalTransport; elliptic theory on compact manifolds and geometric flows are GEO's, Schrödinger operators FAMP's, SPDE PRDS's.

**NonlinearEllipticEquations** — math.AP, L ≈250, wave B. This roadmap develops nonlinear second-order elliptic equations beyond the linear PDE roadmap; PR #93 names it as the separate roadmap viscosity solutions need. It builds viscosity solutions with comparison, Perron's method and stability, and the Caffarelli–Cabré regularity theory of fully nonlinear equations on #93's ABP and Krylov–Safonov. It treats the infinity Laplacian, semilinear equations (moving planes, Pohozaev identities, Liouville theorems), quasilinear equations of p-Laplacian type, and first-order Hamilton–Jacobi equations. Real Monge–Ampère is OptimalTransport's, free boundaries FreeBoundariesAndPhaseTransitions', and complex Monge–Ampère PluripotentialTheory's and GEO's.

- *Objects:* viscosity solutions, Pucci operators, Δ_∞ and AMLE, p-Laplacian, Hamilton–Jacobi equations. *Milestones:* Jensen–Ishii comparison; Evans–Krylov; Evans–Savin; Gidas–Ni–Nirenberg; Gidas–Spruck.
- *Prereqs:* PDE with #93; CalculusOfVariations. *Goals:* OpenAI 4: #367, 370, 375, 377. *Porting:* none. *Note:* medium–high.

**FreeBoundariesAndPhaseTransitions** — math.AP, M ≈130, wave B. This roadmap develops free-boundary problems and the Allen–Cahn equation. It proves Caffarelli's regularity theory for the obstacle problem and the Alt–Caffarelli theory of the one-phase Bernoulli problem through Weiss monotonicity, De Silva's flatness theorem and dimension bounds for singular sets. For Allen–Cahn it proves Modica's estimate, De Giorgi's conjecture in dimensions 2 and 3, and Savin's flat-level-set theorem. Classification of stable free-boundary cones is stated as frontier. Γ-convergence is CalculusOfVariations', viscosity methods NonlinearEllipticEquations', and minimal cones MinimalBoundariesAndIsoperimetry's.

- *Objects:* obstacle problem, one-phase functional, Weiss energy, Allen–Cahn solutions. *Milestones:* Caffarelli obstacle regularity; Alt–Caffarelli; De Silva flatness; Ambrosio–Cabré; Savin.
- *Prereqs:* NonlinearEllipticEquations; CalculusOfVariations; MinimalBoundariesAndIsoperimetry. *Goals:* OpenAI 2: #367, 375. *Porting:* none. *Note:* medium; Savin is the long pole.

**CalculusOfVariations** — math.AP, L ≈220, wave A. This roadmap develops the direct method for integral functionals on Sobolev spaces and its vector-valued and variational-limit theory (Dacorogna, Giusti, Braides). It proves lower semicontinuity and existence, the convexity hierarchy with Morrey's theorem, weak continuity of Jacobians, and the existence theories of nonlinear and linear elasticity with Korn's inequalities. It proves regularity of minimizers of convex scalar functionals (Hilbert's 19th problem) with De Giorgi's vectorial counterexample, Γ-convergence with Modica–Mortola, free-discontinuity functionals, and critical-point theory. Minimal surfaces are GMT's and GEO's, and harmonic maps GEO's.

- *Objects:* quasiconvex integrands, null Lagrangians, Lamé system, Γ-limits, Palais–Smale sequences. *Milestones:* Morrey; weak continuity of determinants; Ball; Korn; Hilbert's 19th problem; Modica–Mortola.
- *Prereqs:* PDE; RealVariableHarmonicAnalysis (H¹); RectifiabilityAndBV (SBV). *Goals:* OpenAI 4: #366, 368, 372, 375. *Porting:* none. *Note:* high.

**DispersiveEquations** — math.AP, L ≈250, wave A. This roadmap develops linear and nonlinear Schrödinger and wave equations on ℝⁿ and 𝕋ⁿ (Tao, Cazenave, Linares–Ponce), replacing the PDE roadmap's Strichartz stretch goal. It builds the free propagators, dispersive and Strichartz estimates with the Keel–Tao endpoint, and local well-posedness in Sobolev spaces by Duhamel and contraction arguments. It proves conservation laws, global well-posedness and scattering for defocusing subcritical equations, virial blow-up, Bourgain-space theory on tori, and the fundamental solutions and energy estimates of the wave equation. Restriction and decoupling estimates are HarmonicAnalysis', and quasilinear hyperbolic systems HyperbolicSystemsAndConservationLaws'.

- *Objects:* propagators, Strichartz pairs, X^{s,b}, conserved quantities, wave fundamental solutions. *Milestones:* Strichartz and Keel–Tao; subcritical LWP; defocusing GWP and scattering; Glassey blow-up; Bourgain L⁴(𝕋²).
- *Prereqs:* PDE; #237 (periodic H^s); RealVariableHarmonicAnalysis. *Goals:* OpenAI 4: #079, 080, 362, 371. *Porting:* OAI DefocusingNLS (191k lines). *Note:* high for subcritical theory.

**KineticEquations** — math.AP, M ≈130, wave B. This roadmap develops transport equations in phase space (Glassey, Villani, Cercignani–Illner–Pulvirenti). It builds characteristics and velocity averaging, the Vlasov–Poisson and relativistic Vlasov–Maxwell systems with their global and continuation theorems, and mean-field limits in Wasserstein distance. It develops the Boltzmann collision operator, the H-theorem and DiPerna–Lions renormalized solutions on #237's renormalized transport, and the BBGKY hierarchy with Lanford's theorem; fluctuations beyond Lanford's time are stated. Incompressible fluids are IncompressibleFlows', and wave fundamental solutions DispersiveEquations'.

- *Objects:* velocity averages, Vlasov–Poisson and Vlasov–Maxwell, collision operators, BBGKY marginals. *Milestones:* averaging lemmas; Pfaffelmoser; Glassey–Strauss; DiPerna–Lions Boltzmann; Lanford.
- *Prereqs:* #237; OptimalTransport; DispersiveEquations. *Goals:* OpenAI 3: #362, 363, 364. *Porting:* OAI VlasovMaxwell, Boltzmann. *Note:* medium.

**HyperbolicSystemsAndConservationLaws** — math.AP, L ≈220, wave A. This roadmap develops first-order hyperbolic systems and nonlinear wave equations (Dafermos, Bressan, Majda, Sogge). It proves the entropy theory of scalar conservation laws, Lax's solution of the Riemann problem and Glimm's existence theorem for systems, and Kato's local well-posedness of quasilinear symmetric hyperbolic systems. It proves local well-posedness of quasilinear wave equations, John's blow-up and Klainerman's null-condition theorem, and treats compressible Euler with Sideris's blow-up. Non-uniqueness is ConvexIntegration's, and the Einstein equations are EinsteinEvolutionEquations', which consume the quasilinear wave layer.

- *Objects:* entropy solutions, Riemann problem, symmetric hyperbolic systems, quasilinear waves, null forms. *Milestones:* Kružkov; Lax; Glimm; Kato quasilinear LWP; Klainerman null condition; Sideris.
- *Prereqs:* PDE Lanes A and F. *Goals:* Annals 2: #87, #88. *Porting:* none. *Note:* medium–high; Glimm is the long pole.

**EinsteinEvolutionEquations** — math.AP, M ≈130, wave C. This roadmap develops the Cauchy problem for the Einstein equations (Ringström, Choquet-Bruhat). It builds initial data sets with the constraint equations and the conformal method, wave gauge and the reduced equations, Choquet-Bruhat's local existence with geometric uniqueness, and the Choquet-Bruhat–Geroch maximal globally hyperbolic development. It proves Birkhoff's theorem and treats the scalar-field and Maxwell couplings; stability of Minkowski and Kerr spacetimes and strong cosmic censorship are stated. Lorentzian geometry, causality and the explicit black-hole families are GEO's LorentzianGeometry, and positive mass and Penrose inequalities GEO's.

- *Objects:* initial data sets, constraint equations, wave gauge, maximal globally hyperbolic developments. *Milestones:* conformal method; Choquet-Bruhat local existence; geometric uniqueness; MGHD; Birkhoff.
- *Prereqs:* GEO LorentzianGeometry; HyperbolicSystemsAndConservationLaws; GEO EllipticOperatorsOnManifolds. *Goals:* Annals 1: #87; OpenAI 1: #264. *Porting:* none. *Note:* medium; global results are statements.

**ConvexIntegration** — math.AP, M ≈110, wave B. This roadmap develops convex integration for fluid equations and its non-uniqueness theorems. It builds Tartar's subsolution framework, Λ-convex hulls and iterative schemes with Mikado flows. It proves De Lellis–Székelyhidi wild solutions of Euler, Chiodaroli–De Lellis–Kreml non-uniqueness for compressible Euler, Isett's flexible half of Onsager's conjecture and Buckmaster–Vicol non-uniqueness for Navier–Stokes; Albritton–Brué–Colombo is stated. Leray–Hopf theory and Onsager's rigid half are IncompressibleFlows', and Nash–Kuiper is GEO's IsometricEmbeddings.

- *Objects:* subsolutions, Λ-convex hulls, Reynolds stress, Mikado flows. *Milestones:* De Lellis–Székelyhidi; Chiodaroli–De Lellis–Kreml; Isett; Buckmaster–Vicol.
- *Prereqs:* #237; HyperbolicSystemsAndConservationLaws. *Goals:* Annals 2: #88, #90. *Porting:* none. *Note:* medium–low; long estimates.

**UniqueContinuationAndInverseProblems** — math.AP, M ≈130, wave B. This roadmap develops unique continuation for elliptic equations and its use in Calderón-type inverse problems. It proves Carleman estimates, strong unique continuation, frequency-function doubling, three-ball inequalities and Runge approximation. It builds Dirichlet-to-Neumann maps for conductivities, metrics with connections and the Lamé system, and proves boundary determination, Sylvester–Uhlmann uniqueness through complex geometrical optics, Lee–Uhlmann, partial-data uniqueness and isotropic elasticity near constant coefficients. Elliptic theory on manifolds with boundary and the DN map as an operator are consumed from GEO's EllipticOperatorsOnManifolds, and Neumann eigenvalues of Euclidean domains are the PDE roadmap's.

- *Objects:* Carleman weights, frequency function, DN maps, CGO solutions. *Milestones:* Aronszajn–Cordes; Garofalo–Lin; Kohn–Vogelius; Sylvester–Uhlmann; Kenig–Sjöstrand–Uhlmann.
- *Prereqs:* PDE; GEO EllipticOperatorsOnManifolds; CalculusOfVariations (Lamé). *Goals:* OpenAI 3: #350, 365, 372. *Porting:* OAI Conductivity. *Note:* medium.

### Standalone

**ConicOptimizationAndSpectrahedra** — math.OC, M ≈100, wave A. This roadmap develops the convex-analytic and real-algebraic theory of conic optimization (Ben-Tal–Nemirovski, Blekherman–Parrilo–Thomas). It builds conic programs with strong duality and facial reduction, the semidefinite and second-order cones, spectrahedra and their shadows, and hyperbolic polynomials with their cones. It proves the Positivstellensätze used in optimization with convergence of the Lasserre hierarchy, and states Helton–Vinnikov, the generalized Lax conjecture and Scheiderer's theorem. LP duality and polyhedra are COMB's PolyhedralCombinatorics, real stable polynomials COMB's, and rounding, sum-of-squares proof systems and the ellipsoid method LTCS's, which import SDP duality from here.

- *Objects:* conic programs, PSD cone, spectrahedra and shadows, hyperbolic polynomials, moment matrices. *Milestones:* conic strong duality; Gårding; spectrahedra are hyperbolicity cones; Putinar; Lasserre convergence.
- *Prereqs:* Mathlib cones; Tau Ceti Analysis/Convex; RealAlgebraicGeometry; COMB PolyhedralCombinatorics. *Goals:* OpenAI 5: #095, 102, 117, 122, 126. *Porting:* OAI HyperbolicCones. *Note:* high; low demand, drafted late.

**ValidatedNumerics** — math.NA, M ≈110, wave A. This roadmap develops the mathematics of computer-assisted proofs with rigorous real and complex enclosures. It builds interval and ball arithmetic with the fundamental theorem of interval arithmetic, Taylor models, and enclosures of elementary and Gamma functions. It proves the Moore–Krawczyk existence-and-uniqueness theorem, verified eigenvalue and linear-system enclosures, rigorous quadrature and a posteriori enclosures of ODE flows, and the soundness of branch-and-bound certificates for inequalities on boxes, each with a verified executable procedure. p-adic precision and L-value approximation stay with NT's computational roadmaps, exact finite linear algebra with StructuredBlockOperators (#260), and sum-of-squares certificates with ConicOptimizationAndSpectrahedra.

- *Objects:* intervals and balls, Taylor models, Krawczyk operator, enclosures, box certificates. *Milestones:* fundamental theorem of interval arithmetic; Moore–Krawczyk; Rump enclosures; a posteriori Picard–Lindelöf.
- *Prereqs:* Mathlib Taylor, Picard–Lindelöf, Gershgorin. *Goals:* OpenAI 7: #090, 222, 229, 266, 268, 269, 272. *Porting:* alerad/leancert (coordinate first). *Note:* high; precedent #717.

## 4. Needs not absorbed

| gap need (ref) | reason |
|---|---|
| compact complex spaces: Remmert, Grauert, Fujiki C, Douady (OAI#033, 034, 041, 046, 056) | AG ComplexAnalyticSpaces (BOUNDARIES); consumes SCV |
| Bott–Chern/Aeppli, ∂∂̄-lemma (OAI#036); holomorphic foliations and Frobenius (OAI#052 ×2) | AG KahlerManifolds |
| elliptic operators on compact manifolds, Hodge theorem (Annals #86); H¹, H^{1/2} traces and the Dirichlet problem on manifolds with boundary (OAI#365) | GEO EllipticOperatorsOnManifolds; it must cover manifolds with boundary and the DN map (§6) |
| ellipsoid/GLS and volume algorithms (OAI#114) | LTCS CombinatorialAlgorithms (per COMB's slate); volume algorithms are frontier |
| configuration LP (OAI#118); extended formulations, PSD rank (OAI#126) | COMB PolyhedralCombinatorics (LP, Rothvoss) and LTCS (SOS) |
| Wang–Zahl Kakeya, sticky Kakeya (OAI#074); Ren–Wang Furstenberg (OAI#077) | frontier (2023–25); stated in KakeyaAndBrascampLieb and FractalGeometry |
| stable free-boundary cones, Jerison–Savin, De Silva–Jerison (OAI#367) | frontier; stated in FreeBoundariesAndPhaseTransitions |

Frontier parts of absorbed needs stay statements (OAI#078, 079, 080, 081, 264, 364, 366, 371). OAI#369's Neumann eigenfunctions go to PDE Lane D, `hgm` Bézout data and Beukers–Heckman to NT HypergeometricMotives, and the continuous Gowers inverse theorem (OAI#086) to COMB AdditiveCombinatorics.

## 5. Cross-campaign interface

**Imports.**
- **GEO:** EllipticOperatorsOnManifolds (UniqueContinuation, Einstein, Pluripotential), LorentzianGeometry (Einstein), RiemannianGeometry (isoperimetry).
- **AG:** KahlerManifolds (Pluripotential), Milnor–Thom/Warren (Kakeya), RealAlgebraicGeometry (ConicOptimization).
- **COMB:** DiscreteGeometryAndIncidences (ham sandwich, partitioning, Borsuk–Ulam), PolyhedralCombinatorics (LP duality), AdditiveCombinatorics.
- **FAMP:** H²(𝔻), H^∞, Kirszbraun, #126. **PRDS:** ErgodicTheory (entropy). **NT:** HypergeometricMotives (Levelt). **TOP:** UniversalCovers.

**Exports.**
- **AG:** SCV (ℂ{z}, Weierstrass, Cartan A/B; prerequisite of ComplexAnalyticSpaces and SingularityTheory); Pluripotential (analytic multiplier ideals, Ohsawa–Takegoshi, current positivity, as VanishingTheorems and AsymptoticPositivity expect); regular singular points (VariationsOfHodgeStructure).
- **GEO:** varifolds, Allard, Simons/Bernstein (MinimalSubmanifolds, GeometricFlows); Bedford–Taylor and Kołodziej (CalabiYauAndComplexMongeAmpere); Evans–Krylov; quasilinear waves; spherical harmonics and cosine transform (ConvexBodies); radial Fourier and certificates (PackingCoveringEnergy); unique continuation (SpectralGeometry).
- **PRDS:** Loewner equation and harmonic measure (SLE, BrownianMotion); Brascamp–Lieb.
- **NT:** Vinogradov mean value (ES.2); stationary phase (ES.0); K-Bessel and Whittaker functions (Maass, Bianchi); Koecher's principle; CN.4 real numerics.
- **TOP:** quasiconformal maps (Teichmüller). **FAMP:** H^p for p ≠ 2, ∞; interpolation of Banach couples. **LTCS:** SDP duality (assigned to ANA by MetricEmbeddingsAndConvexRelaxations).

## 6. Order and people

**First five to draft** (demand × unblocking):
1. **HarmonicAnalysis index + RealVariableHarmonicAnalysis.** 8 OAI families directly. It unblocks TimeFrequency, Restriction, QuantitativeRectifiability, QC maps (Beurling transform), CalculusOfVariations (H¹) and Dispersive. `carleson` is ready to port.
2. **GeometricMeasureTheory index + RectifiabilityAndBV.** Annals #71 and 5 OAI families. It unblocks Currents and Varifolds (Annals #85), QuantitativeRectifiability (#84), MinimalBoundaries (7 OAI) and GEO's minimal-surface and flow roadmaps.
3. **ComplexAnalysis index + SeveralComplexVariables.** 8 OAI families. Prerequisite of AG's ComplexAnalyticSpaces and SingularityTheory, of Pluripotential (10 OAI, plus Annals #76 and #91 through GEO) and of Oka.
4. **FourierRestriction.** Annals #89 and 5 OAI families. With Kakeya it unblocks Decoupling, which NT's ES.2 waits on.
5. **NonlinearPDE index + HyperbolicSystemsAndConservationLaws.** Annals #88. It unblocks Einstein (#87) and ConvexIntegration (#88, #90).

Next: GeometricFunctionTheory (ConformalMapping is finished, so workers can start at once; 8 OAI incl. SLE), CurrentsAndVarifolds, CalculusOfVariations, Dispersive, FractalGeometry, Kakeya, QC maps. Merge first: #237, #93, #279, #117.

**People.**
- *Lead:* a harmonic analyst or geometric measure theorist with Lean experience; the `carleson` community (van Doorn, Thiele's group), whom the README requires us to consult anyway, is the natural pool.
- *Reviewers:* harmonic analysis and GMT; complex analysis (one and several variables); elliptic and variational PDE; evolution PDE. The two standalone roadmaps need an optimization/numerics reader from outside the campaign.

**Open questions for the owner.**
1. **Oka coherence.** AG's ComplexAnalyticSpaces lists "Oka's coherence theorem". Cartan A/B in SCV needs coherence of 𝒪_{ℂⁿ} and of ideal sheaves, so this plan gives those local theorems to SCV and coherence on singular spaces to AG.
2. **Simons classification and Bernstein's theorem.** Planned in GMT's MinimalBoundariesAndIsoperimetry (Giusti's route). GEO's MinimalSubmanifolds would consume them; GEO may want them instead.
3. **Bessel and Whittaker functions.** Planned in LinearDifferentialEquationsAndSpecialFunctions (math.CA), but NT's Maass sub-roadmap lists K-Bessel functions. The hypergeometric groups, Levelt and Beukers–Heckman stay with NT's HypergeometricMotives as its slate says.
4. **QualitativeODE goes to PRDS.** Its content (Poincaré–Bendixson, limit cycles, bifurcation, reaction networks) is math.DS, and its needs are math.DS rows. ANA keeps complex linear ODE only.
5. **FractalGeometry is ANA's**, including self-similar measures and Bernoulli convolutions (BOUNDARIES: fractal dimension theory). PRDS supplies entropy.
6. **GEO's EllipticOperatorsOnManifolds must include manifolds with boundary** (traces, Dirichlet/Neumann, the DN map). Otherwise UniqueContinuationAndInverseProblems has to take a manifold-with-boundary layer.
7. **Existing roadmaps under the umbrellas.** Should the families adopt existing top-level roadmaps as members (ConformalMapping and ContourIntegration under ComplexAnalysis; PDE and IncompressibleFlows under NonlinearPDE), or only link them?
8. **`carleson`.** Vendor it into Tau Ceti or depend on it? It is pinned in the OAI lakefile but no OAI file imports it.

## 7. Totals

| | roadmaps | L | M | est. PRs |
|---|---|---|---|---|
| HarmonicAnalysis | 6 | 4 | 2 | 1,180 |
| GeometricMeasureTheory | 5 | 3 | 2 | 970 |
| ComplexAnalysis | 6 | 4 | 2 | 1,250 |
| NonlinearPDE | 9 | 4 | 5 | 1,570 |
| standalone (OC, NA) | 2 | – | 2 | 210 |
| **new** | **28** (4 XL families) | **15** | **13** | **≈5,180** |

**Existing supply in the territory:** ≈1,050 PRs remaining, estimated at about 14 PRs per remaining layer.
- On main, ≈560: PDE with #93 ~210, OptimalTransport ~300, FuchsianOrbifolds ~40, ConformalMapping ~10.
- In open PRs, ≈490: #237 ~200, #279 ~90, #280 ~80, #117 ~70, #260 ~50.
