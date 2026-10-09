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

## 8. References by roadmap

32 roadmap records, 343 listings, 295 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_ANA.json` and the `references` fields of `slate_ANA.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (233 of 295: zbMATH stopped early; see master (d)). A title is given at a work's first citation in this section only. Pointers are the compilers' and are unverified.

**Conventions and notes.** Fourier transform: Mathlib's 𝓕 (`Real.fourier_eq`, `Real.fourierChar`), 𝓕f(ξ) = ∫ e^{−2πi⟨x,ξ⟩} f(x) dx, no Plancherel constants, ∂ⱼ ↦ 2πiξⱼ (Grafakos, Stein–Weiss, Mattila agree; Evans's unitary e^{−ix·ξ} estimates are restated, not copied). Fourier series: `fourierCoeff` on `AddCircle T` with probability Haar measure, T = 1 canonical; 2π-periodic statements (Katznelson, Zygmund) transported along T = 2π. Laplacian Δ = Σ∂ᵢ² (symbol −4π²|ξ|²). Sobolev: W^{k,p} by weak derivatives (Tau Ceti `W1p`, `Wkp`); whole-space H^{s,p} is Mathlib's `MemSobolev` with Bessel symbol (1+‖ξ‖²)^{s/2}, periodic H^s uses (1+4π²|k|²)^{s/2} (#237): equivalent norms, different constants, so estimates name the scale. BV and perimeter as Evans–Gariepy and Maggi (outer normal; Ambrosio–Fusco–Pallara's inner normal is −ν_E). Hausdorff measure: `μH[d]` unnormalized, `μHE[d]` normalized (Federer's ℋ^d) for area, coarea, perimeter, currents and varifolds. Also: H^p(𝔻) with dθ/2π; Beltrami μ = f_z̄/f_z; chordal Loewner hcap(K_t) = 2t; (dd^c log|z|)ⁿ = δ₀; NLS iu_t + Δu = μ|u|^{p−1}u with μ = +1 defocusing; special functions as in DLMF.

**HarmonicAnalysis** (umbrella, wave A)
- primary: Grafakos 2014, *Classical Fourier Analysis*, Ch. 1, Ch. 2, Ch. 5 (?); Grafakos 2014, *Modern Fourier Analysis*, Ch. 1, Ch. 2, Ch. 3 (?); Stein 1993, *Harmonic Analysis* (?); Stein–Weiss 1971, *Fourier Analysis on Euclidean Spaces*, Ch. IV (?); Muscalu–Schlag 2013, *Classical and Multilinear Harmonic…* (?)
- conventions: Mathlib `Analysis/Fourier`
- formal: `fpvandoorn/carleson`

**HarmonicAnalysis/ClassicalFourierAnalysis** (wave A)
- primary: Katznelson 2004, *Harmonic Analysis*, Chs. I–III (?); Zygmund 2002, *Trigonometric Series, Vols. I & II*, Ch. VII, Ch. VIII (?); Grafakos 2014, Chs. 3–4 (?); Duren 1970, *Theory of H^p Spaces* (?); Garnett 2007, *Bounded Analytic Functions*, Ch. II (?); Stein–Weiss 1971, Ch. IV (?)
- conventions: Mathlib `Analysis/Fourier`
- theorem: Rudin 1987, *Real and Complex Analysis*, Ch. 19, Ch. 17 (?); Groemer 1996, *Geometric Applications of Fourier…* (?)
- formal: `fpvandoorn/carleson`; OAI `Analysis/Littlewood`; OAI `Geometry/ProjectionBodies`

**HarmonicAnalysis/RealVariableHarmonicAnalysis** (wave A)
- primary: Grafakos 2014, Ch. 1, Ch. 5, Ch. 7 (?); Grafakos 2014, Ch. 1, Ch. 2, Ch. 3 (?); Stein 1993, Chs. III–IV, Ch. V (?); Bergh–Löfström 1976, *Interpolation Spaces* (?); Triebel 1983, *Theory of Function Spaces* (?)
- theorem: Coifman–Meyer–Stein 1985, *Some new function spaces and their…* (?); Stein 1976, *Maximal functions. I. Spherical means* (?); Lerner–Nazarov 2019, *Intuitive dyadic calculus* (?); David–Journé 1984, *Boundedness criterion for generalized…* (?); Nazarov–Treil–Volberg 2003, *Tb-theorem on non-homogeneous spaces* (?); Coifman–McIntosh–Meyer 1982, *L'intégrale de Cauchy définit un…* (?); Jones–Seeger–Wright 2008, *Strong variational and jump…* (?); Kinnunen 1997, *Hardy–Littlewood maximal function of a…* (?)
- formal: `fpvandoorn/carleson`; OAI `Analysis/DiskMaximal`

**HarmonicAnalysis/TimeFrequencyAnalysis** (wave B)
- primary: Grafakos 2014, Ch. 6 (?); Thiele 2006, *Wave Packet Analysis* (?); Muscalu–Schlag 2013, Vol. II (?)
- theorem: Becker et al. 2024, *Carleson operators on doubling metric…* (?); Antonov 1996, *Convergence of Fourier series* (?); Lacey–Thiele 1999, *Calderón's conjecture* (?); Oberlin et al. 2012, *Variation norm Carleson theorem* (?); Lacey–Li 2010, *Conjecture of E. M. Stein on the…* (?); Bateman–Thiele 2013, *L^p estimates for the Hilbert…* (?); Kovač 2012, *Boundedness of the twisted paraproduct* (?)
- statement: OpenAI 2026, *Uniform Hilbert transform estimate for…* (OAI#083); OpenAI 2026, *L³ bound for the trilinear Hilbert…* (OAI#086)
- formal: `fpvandoorn/carleson`; OAI `Analysis/TriangularHilbert`

**HarmonicAnalysis/FourierRestriction** (wave A)
- primary: Stein 1993, Chs. VIII–IX (?); Demeter 2020, *Fourier Restriction, Decoupling, and…* (?); Mattila 2015, *Fourier Analysis and Hausdorff Dimension* (?); Łaba–Shubin) 2003, *Harmonic Analysis* (?); Sogge 2017, *Fourier Integrals in Classical Analysis* (?)
- theorem: Tao 1999, *Bochner–Riesz conjecture implies the…* (?); Bennett–Carbery–Tao 2006, *Multilinear restriction and Kakeya…* (?); Bourgain–Guth 2011, *Bounds on oscillatory integral…* (?); Guth 2016, *Restriction estimate using polynomial…* (?); Du–Guth–Li 2017, *Sharp Schrödinger maximal estimate in ℝ²* (?)
- statement: OpenAI 2026, *Diagonal Fourier extension for…* (OAI#077); OpenAI 2026, *Bochner–Riesz multipliers in three…* (OAI#078); OpenAI 2026, *Critical local smoothing for the…* (OAI#079); OpenAI 2026, *Endpoint pointwise convergence for the…* (OAI#080)

**HarmonicAnalysis/Decoupling** (wave B)
- primary: Demeter 2020 (?)
- theorem: Bourgain–Demeter 2015, *Proof of the ℓ² decoupling conjecture* (?); Bourgain–Demeter–Guth 2016, *Proof of the main conjecture in…*; Bourgain–Guth 2011 (?); Wolff 2000, *Local smoothing type estimates on L^p…* (?); Bourgain 1993, *Fourier transform restriction phenomena…* (?)
- statement: Demeter–Guth–Wang 2020, *Small cap decouplings* (?); Guth–Wang–Zhang 2020, *Sharp square function estimate for the…* (?)

**HarmonicAnalysis/KakeyaAndBrascampLieb** (wave A)
- primary: Łaba–Shubin) 2003 (?); Mattila 2015 (?); Guth 2016, *Polynomial Methods in Combinatorics* (?)
- theorem: Wolff 1995, *Improved bound for Kakeya type maximal…* (?); Lieb 1990, *Gaussian kernels have only Gaussian…* (?); Bennett et al. 2008, *Brascamp–Lieb inequalities* (?); Bennett–Carbery–Tao 2006 (?); Guth 2010, *Endpoint case of the…* (?); Wongkew 1993, *Volumes of tubular neighbourhoods of…* (?)
- statement: Wang–Zahl 2025, *Volume estimates for unions of convex…* (?); OpenAI 2026, *Kakeya maximal conjecture in three…* (OAI#074)
- formal: OAI `MeasureTheory/Falconer`

**GeometricMeasureTheory** (umbrella, wave A)
- primary: Federer 1969, *Geometric Measure Theory*, Ch. 4 (?); Evans–Gariepy 2015, *Measure Theory and Fine Properties of…*, Ch. 3, Ch. 5 (?); Mattila 1995, *Geometry of Sets and Measures in…* (?); Simon 1983, *Geometric Measure Theory* (?); Ambrosio–Fusco–Pallara 2000, *Functions of Bounded Variation and Free…* (?); Maggi 2012, *Sets of Finite Perimeter and Geometric…* (?)
- conventions: Mathlib `MeasureTheory/Measure/Hausdorff`; Mathlib `Topology/EMetricSpace/BoundedVariation`

**GeometricMeasureTheory/RectifiabilityAndBV** (wave A)
- primary: Federer 1969 (?); Evans–Gariepy 2015, Ch. 3, Ch. 5 (?); Ambrosio–Fusco–Pallara 2000, Chs. 3–4 (?); Maggi 2012, Part II (?); Mattila 1995 (?)
- formal: Mathlib `MeasureTheory/Measure/Hausdorff`; Tau Ceti `Analysis/Sobolev`; OAI `Analysis/CircleDomains`; OAI `Geometry/Perimeter`; OAI `Geometry/CAT0Fillings`

**GeometricMeasureTheory/CurrentsAndVarifolds** (wave B)
- primary: Federer 1969, Ch. 4 (?); Simon 1983 (?); Krantz–Parks 2008, *Geometric Integration Theory* (?)
- theorem: Federer–Fleming 1960, *Normal and integral currents* (?); Allard 1972, *First variation of a varifold* (?); Ambrosio–Kirchheim 2000, *Currents in metric spaces* (?); Wenger 2005, *Isoperimetric inequalities of Euclidean…* (?)
- formal: OAI `Geometry/CAT0Fillings`; OAI `Geometry/Varifold`

**GeometricMeasureTheory/MinimalBoundariesAndIsoperimetry** (wave B)
- primary: Giusti 1984, *Minimal Surfaces and Functions of…*, Part I (?); Maggi 2012, Part III (?); Simon 1983 (?)
- theorem: Simons 1968, *Minimal varieties in Riemannian…* (?); Bombieri–De Giorgi–Giusti 1969, *Minimal cones and the Bernstein problem* (?); Morgan 2003, *Regularity of isoperimetric…* (?); Ros 2005, *Isoperimetric problem* (?)
- statement: Almgren 2000, *Almgren's Big Regularity Paper* (?)
- formal: OAI `Geometry/Perimeter`; OAI `Geometry/StableBernstein`

**GeometricMeasureTheory/QuantitativeRectifiability** (wave B)
- primary: David–Semmes 1993, *Analysis of and on Uniformly…* (?); Tolsa 2014, *Analytic Capacity, the Cauchy…* (?); Mattila 1995 (?)
- theorem: David–Semmes 1991, *Singular integrals and rectifiable sets…* (?); Jones 1990, *Rectifiable sets and the traveling…* (?); Okikiolu 1992, *Characterization of subsets of…* (?); Mattila–Melnikov–Verdera 1996, *Cauchy integral, analytic capacity, and…* (?)
- statement: Nazarov–Tolsa–Volberg 2014, *Uniform rectifiability of AD-regular…* (?); Tolsa 2003, *Painlevé's problem and the…* (?); Azzam et al. 2016, *Rectifiability of harmonic measure* (?); OpenAI 2026, *Riesz transforms and uniform…* (OAI#081)
- formal: OAI `Analysis/RieszRectifiability`

**GeometricMeasureTheory/FractalGeometry** (wave A)
- primary: Falconer 2014, *Fractal Geometry*, Ch. 9 (?); Mattila 1995 (?); Mattila 2015 (?); Bishop–Peres 2017, *Fractals in Probability and Analysis* (?)
- theorem: Feng–Hu 2009, *Dimension theory of iterated function…* (?); Erdős 1939, *Family of symmetric Bernoulli…* (?); Garsia 1962, *Arithmetic properties of Bernoulli…* (?); Wolff 1999, *Recent work connected with the Kakeya…* (?)
- statement: Ren–Wang 2023, *Furstenberg sets estimate in the plane* (?); OpenAI 2026, *Falconer distance conjecture in all…* (OAI#073)
- formal: OAI `MeasureTheory/Falconer`; OAI `MeasureTheory/SelfSimilar`

**ComplexAnalysis** (umbrella, wave A)
- primary: Ahlfors 1979, *Complex Analysis* (?); Conway 1978, *Functions of One Complex Variable I* (?); Conway 1995, *Functions of One Complex Variable II*, Ch. 17 (?); Hörmander 1990, *Complex Analysis in Several Variables* (?); Forster 1981, *Riemann Surfaces*, §27
- formal: Mathlib `Analysis/Complex`; Tau Ceti `Analysis/Complex/Conformal`; Tau Ceti `Analysis/Contour`

**ComplexAnalysis/GeometricFunctionTheory** (wave A)
- primary: Duren 1983, *Univalent Functions*, Ch. 2, Ch. 3 (?); Pommerenke 1992, *Boundary Behaviour of Conformal Maps*, Ch. 2, Ch. 3 (?); Pommerenke 1975, *Univalent Functions* (?); Garnett–Marshall 2005, *Harmonic Measure* (?); Ransford 1995, *Potential Theory in the Complex Plane* (?); Lawler 2005, *Conformally Invariant Processes in the…* (?)
- theorem: Conway 1995, Ch. 17 (?); de Branges 1985, *Proof of the Bieberbach conjecture* (?)
- formal: Tau Ceti `Analysis/Complex/Conformal`; OAI `Analysis/IntegralMeans`

**ComplexAnalysis/QuasiconformalMapsAndUniformization** (wave A)
- primary: Ahlfors 2006, *Quasiconformal Mappings*, Ch. IV, Ch. V (?); Lehto–Virtanen 1973, *Quasiconformal Mappings in the Plane* (?); Astala–Iwaniec–Martin 2009, *Elliptic Partial Differential Equations…* (?); Ahlfors 1973, *Conformal Invariants* (?); Stephenson 2005, *Circle Packing* (?)
- theorem: Goluzin 1969, *Geometric Theory of Functions of a…* (?); Rodin–Sullivan 1987, *Convergence of circle packings to the…* (?); Forster 1981, §27
- formal: OAI `Analysis/CircleDomains`; Tau Ceti `Analysis/Sobolev`

**ComplexAnalysis/LinearDifferentialEquationsAndSpecialFunctions** (wave A)
- primary: Hille 1976, *Ordinary Differential Equations in the…* (?); Iwasaki et al. 1991, *From Gauss to Painlevé* (?); Olver 1974, *Asymptotics and Special Functions* (?); Wasow 1965, *Asymptotic Expansions for Ordinary…* (?); Watson 1944, *Treatise on the Theory of Bessel…* (?)
- conventions: Olver et al. 2010, *NIST Digital Library of Mathematical…*, Ch. 10, Ch. 13, Ch. 15 (?); Roberts–Rodriguez Villegas 2022, *Hypergeometric motives*
- theorem: Beukers–Heckman 1989, *Monodromy for the hypergeometric…*; Calegari–Dimitrov–Tang 2024, *Unbounded denominators conjecture*
- formal: Mathlib `Analysis/SpecialFunctions`; `CBirkbeck/tauceti-explorer`

**ComplexAnalysis/SeveralComplexVariables** (wave A)
- primary: Hörmander 1990, Ch. IV, Ch. V, Ch. VI (?); Gunning–Rossi 1965, *Analytic Functions of Several Complex…* (?); Krantz 1992, *Function Theory of Several Complex…* (?); Grauert–Remmert 1979, *Theory of Stein Spaces* (?); Demailly 2012, *Complex Analytic and Differential…*, Chs. I–II (?); Lebl n.d., *Tasty Bits of Several Complex Variables* (?)
- theorem: Andreotti–Frankel 1959, *Lefschetz theorem on hyperplane sections* (?)
- formal: Tau Ceti `Analysis/Complex/CauchyIntegralPolydisc`; OAI `Geometry/HypersurfaceGerms`; OAI `Analysis/SymmetricDomains`

**ComplexAnalysis/OkaTheoryAndHyperbolicity** (wave B)
- primary: Forstnerič 2017, *Stein Manifolds and Holomorphic Mappings* (?); Kobayashi 1998, *Hyperbolic Complex Spaces* (?); Lang 1987, *Complex Hyperbolic Spaces* (?)
- theorem: Brody 1978, *Compact manifolds and hyperbolicity* (?); Grauert 1958, *Analytische Faserungen über…* (?); Gromov 1989, *Oka's principle for holomorphic…* (?); Forstnerič 2006, *Runge approximation on convex sets…* (?)
- statement: Green–Griffiths 1980, *Two applications of algebraic geometry…* (?)
- formal: `lana-agents/oka`

**ComplexAnalysis/PluripotentialTheory** (wave B)
- primary: Demailly 2012, Ch. III, Ch. VIII (?); Demailly 2012, *Analytic Methods in Algebraic Geometry* (?); Guedj–Zeriahi 2017, *Degenerate Complex Monge–Ampère…* (?); Klimek 1991, *Pluripotential Theory* (?)
- theorem: Bedford–Taylor 1982, *New capacity for plurisubharmonic…* (?); Siu 1974, *Analyticity of sets associated to…* (?); Ohsawa–Takegoshi 1987, *Extension of L² holomorphic functions* (?); Kołodziej 1998, *Complex Monge–Ampère equation* (?)
- formal: OAI `Geometry/TamingCompatibility`

**NonlinearPDE** (umbrella, wave A)
- primary: Evans 2010, *Partial Differential Equations*, Ch. 5, Chs. 3, 10, Ch. 8 (?); Gilbarg–Trudinger 2001, *Elliptic Partial Differential Equations…*, Ch. 3, Ch. 8, Ch. 9 (?); Taylor 2011, *Partial Differential Equations I–III* (?); Tao 2006, *Nonlinear Dispersive Equations* (?); Bahouri–Chemin–Danchin 2011, *Fourier Analysis and Nonlinear Partial…* (?)
- conventions: Mathlib `Analysis/InnerProductSpace/Laplacian`; Mathlib `Analysis/Distribution`; Tau Ceti `Analysis/Sobolev`
- formal: Tau Ceti `Analysis/PDE`

**NonlinearPDE/NonlinearEllipticEquations** (wave B)
- primary: Caffarelli–Cabré 1995, *Fully Nonlinear Elliptic Equations* (?); Crandall–Ishii–Lions 1992, *User's guide to viscosity solutions of…* (?); Gilbarg–Trudinger 2001, Ch. 17 (?); Lindqvist 2016, *Infinity Laplace Equation* (?)
- theorem: Jensen 1993, *Uniqueness of Lipschitz extensions* (?); Evans–Savin 2008, *C^{1,α} regularity for infinity…* (?); Gidas–Ni–Nirenberg 1979, *Symmetry and related properties via the…* (?); Gidas–Spruck 1981, *Global and local behavior of positive…* (?); Caffarelli–Gidas–Spruck 1989, *Asymptotic symmetry and local behavior…* (?); DiBenedetto 1983, *C^{1+α} local regularity of weak…* (?); Crandall–Lions 1983, *Viscosity solutions of Hamilton–Jacobi…*, Ch. 10 (?)

**NonlinearPDE/FreeBoundariesAndPhaseTransitions** (wave B)
- primary: Petrosyan et al. 2012, *Regularity of Free Boundaries in…* (?); Caffarelli–Salsa 2005, *Geometric Approach to Free Boundary…* (?); Velichkov 2023, *Regularity of the One-Phase Free…* (?)
- theorem: Caffarelli–Jerison–Kenig 2004, *Global energy minimizers for free…* (?); Modica 1985, *Gradient bound and a Liouville theorem…* (?); Ghoussoub–Gui 1998, *Conjecture of De Giorgi and some…* (?); Ambrosio–Cabré 2000, *Entire solutions of semilinear elliptic…* (?); Savin 2009, *Regularity of flat level sets in phase…* (?)
- statement: Jerison–Savin 2015, *Some remarks on stability of cones for…* (?); De Silva–Jerison 2009, *Singular energy minimizing free boundary* (?); OpenAI 2026, *Critical dimension for one-phase…* (OAI#367); OpenAI 2026, *Positive resolution of De Giorgi's…* (OAI#375)

**NonlinearPDE/CalculusOfVariations** (wave A)
- primary: Dacorogna 2008, *Direct Methods in the Calculus of…* (?); Giusti 2003, *Direct Methods in the Calculus of…* (?); Braides 2002, *Γ-convergence for Beginners* (?); Ciarlet 1988, *Mathematical Elasticity, Vol. I* (?); Struwe 2008, *Variational Methods* (?); Ambrosio–Fusco–Pallara 2000 (?)
- theorem: Ball 1977, *Convexity conditions and existence…* (?); Müller 1990, *Higher integrability of determinants…* (?); Modica–Mortola 1977, *Un esempio di Γ⁻-convergenza* (?)
- formal: `scottnarmstrong/DeGiorgi`; Tau Ceti `Analysis/Sobolev`

**NonlinearPDE/DispersiveEquations** (wave A)
- primary: Tao 2006, Chs. 2–3 (?); Cazenave 2003, *Semilinear Schrödinger Equations* (?); Linares–Ponce 2015, *Nonlinear Dispersive Equations* (?); Sogge 2008, *Non-Linear Wave Equations* (?)
- conventions: Mathlib `Analysis/Fourier`
- theorem: Keel–Tao 1998, *Endpoint Strichartz estimates* (?); Ginibre–Velo 1985, *Scattering theory in the energy space…* (?); Glassey 1977, *Blowing up of solutions to the Cauchy…* (?); Bourgain 1993 (?)
- statement: Merle et al. 2022, *Blow up for the energy super critical…* (?); OpenAI 2026, *Stable self-similar blowup for a…* (OAI#371)
- formal: OAI `MathematicalPhysics/DefocusingNLS`

**NonlinearPDE/KineticEquations** (wave B)
- primary: Glassey 1996, *Cauchy Problem in Kinetic Theory* (?); Villani 2002, *Review of mathematical topics in…* (?); Gallagher et al. 2013, *From Newton to Boltzmann* (?)
- theorem: Golse et al. 1988, *Regularity of the moments of the…* (?); Pfaffelmoser 1992, *Global classical solutions of the…* (?); Glassey–Strauss 1986, *Singularity formation in a…* (?); DiPerna–Lions 1989, *Cauchy problem for Boltzmann equations* (?); Dobrushin 1979, *Vlasov equations* (?)
- statement: Bodineau et al. 2023, *Statistical dynamics of a hard sphere…* (?); OpenAI 2026, *Hard-sphere fluctuations on the regular…* (OAI#364)
- formal: OAI `Analysis/VlasovMaxwell`; OAI `MathematicalPhysics/Boltzmann`

**NonlinearPDE/HyperbolicSystemsAndConservationLaws** (wave A)
- primary: Dafermos 2016, *Hyperbolic Conservation Laws in…* (?); Bressan 2000, *Hyperbolic Systems of Conservation Laws* (?); Majda 1984, *Compressible Fluid Flow and Systems of…* (?); Sogge 2008 (?); Hörmander 1997, *Nonlinear Hyperbolic Differential…* (?)
- theorem: Kružkov 1970, *First order quasilinear equations in…* (?); Glimm 1965, *Solutions in the large for nonlinear…* (?); Kato 1975, *Cauchy problem for quasi-linear…* (?); John 1981, *Blow-up for quasilinear wave equations…* (?); Klainerman 1986, *Null condition and global existence to…* (?); Sideris 1985, *Formation of singularities in…* (?)

**NonlinearPDE/EinsteinEvolutionEquations** (wave C)
- primary: Ringström 2009, *Cauchy Problem in General Relativity* (?); Choquet-Bruhat 2009, *General Relativity and the Einstein…* (?)
- theorem: Fourès-Bruhat 1952, *Théorème d'existence pour certains…* (?); Choquet-Bruhat–Geroch 1969, *Global aspects of the Cauchy problem in…* (?); Sbierski 2016, *Existence of a maximal Cauchy…* (?); Bartnik–Isenberg 2004, *Constraint equations* (?)
- statement: Christodoulou–Klainerman 1993, *Global Nonlinear Stability of the…* (?); Giorgi–Klainerman–Szeftel 2022, *Wave equations estimates and the…* (?); Dafermos–Luk 2017, *Interior of dynamical vacuum black… I* (?); OpenAI 2026, *Generic C¹ future inextendibility near…* (OAI#264)

**NonlinearPDE/ConvexIntegration** (wave B)
- primary: Buckmaster–Vicol 2019, *Convex integration and phenomenologies…* (?); De Lellis–Székelyhidi 2017, *High dimensionality and h-principle in…* (?)
- theorem: Tartar 1979, *Compensated compactness and…* (?); De Lellis–Székelyhidi 2009, *Euler equations as a differential…* (?); Chiodaroli–De Lellis–Kreml 2015, *Global ill-posedness of the isentropic…* (?); Daneri–Székelyhidi 2017, *Non-uniqueness and h-principle for…* (?); Isett 2018, *Proof of Onsager's conjecture* (?); Buckmaster–Vicol 2019, *Nonuniqueness of weak solutions to the…* (?)
- statement: Albritton–Brué–Colombo 2022, *Non-uniqueness of Leray solutions of…* (?)

**NonlinearPDE/UniqueContinuationAndInverseProblems** (wave B)
- primary: Isakov 2017, *Inverse Problems for Partial…* (?); Uhlmann 2009, *Electrical impedance tomography and…* (?)
- theorem: Aronszajn 1957, *Unique continuation theorem for…* (?); Garofalo–Lin 1986, *Monotonicity properties of variational…* (?); Kohn–Vogelius 1984, *Determining conductivity by boundary…* (?); Sylvester–Uhlmann 1987, *Global uniqueness theorem for an…* (?); Lee–Uhlmann 1989, *Determining anisotropic real-analytic…* (?); Kenig–Sjöstrand–Uhlmann 2007, *Calderón problem with partial data* (?); Nakamura–Uhlmann 1994, *Global uniqueness for an inverse…* (?); Eskin–Ralston 2002, *Inverse boundary value problem for…* (?)
- formal: OAI `Analysis/Conductivity`; `abenenson/rellich-kondrachov`

**ConicOptimizationAndSpectrahedra** (wave A)
- primary: Ben-Tal–Nemirovski 2001, *Modern Convex Optimization* (?); Blekherman–Parrilo–Thomas 2013, *Semidefinite Optimization and Convex…* (?); Marshall 2008, *Positive Polynomials and Sums of Squares* (?)
- theorem: Borwein–Wolkowicz 1981, *Facial reduction for a cone-convex…* (?); Gårding 1959, *Inequality for hyperbolic polynomials* (?); Renegar 2006, *Hyperbolic programs, and their…* (?); Putinar 1993, *Positive polynomials on compact…* (?); Lasserre 2001, *Global optimization with polynomials…* (?)
- statement: Helton–Vinnikov 2007, *Linear matrix inequality representation…* (?); Scheiderer 2018, *Spectrahedral shadows* (?)
- formal: OAI `Analysis/HyperbolicCones`; Tau Ceti `Analysis/Convex`

**ValidatedNumerics** (wave A)
- primary: Moore–Kearfott–Cloud 2009, *Interval Analysis* (?); Tucker 2011, *Validated Numerics* (?); Neumaier 1990, *Interval Methods for Systems of…* (?); Rump 2010, *Verification methods* (?)
- conventions: Society 2015, *IEEE Standard for Interval Arithmetic…* (?)
- theorem: Krawczyk 1969, *Newton-Algorithmen zur Bestimmung von…* (?); Makino–Berz 2003, *Taylor models and other validated…* (?); Johansson 2017, *Arb: efficient arbitrary-precision…*
- formal: `alerad/leancert`; OAI `Analysis/PlanarPacking`; Melquiond 2008, *Proving bounds on real-valued functions…* (?); Mathlib `Analysis/ODE`

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Mattila 1995, *Geometry of Sets and Measures in…* [4] ★; Ambrosio–Fusco–Pallara 2000, *Functions of Bounded Variation and Free…* [3] ★; Federer 1969, *Geometric Measure Theory* [3] ★; Grafakos 2014, *Classical Fourier Analysis* [3] ★; Grafakos 2014, *Modern Fourier Analysis* [3] ★; Maggi 2012, *Sets of Finite Perimeter and Geometric…* [3] ★; Mattila 2015, *Fourier Analysis and Hausdorff Dimension* [3] ★; Stein 1993, *Harmonic Analysis* [3] ★; Bourgain 1993, *Fourier transform restriction phenomena…* [2] ★; Conway 1995, *Functions of One Complex Variable II* [2] ★; Demeter 2020, *Fourier Restriction, Decoupling, and…* [2] ★; Evans–Gariepy 2015, *Measure Theory and Fine Properties of…* [2] ★; Gilbarg–Trudinger 2001, *Elliptic Partial Differential Equations…* [2] ★; Hörmander 1990, *Complex Analysis in Several Variables* [2] ★; Łaba–Shubin) 2003, *Harmonic Analysis* [2] ★; Muscalu–Schlag 2013, *Classical and Multilinear Harmonic…* [2] ★; Sogge 2008, *Non-Linear Wave Equations* [2] ★; Stein–Weiss 1971, *Fourier Analysis on Euclidean Spaces* [2] ★; Tao 2006, *Nonlinear Dispersive Equations* [2] ★; Ahlfors 1973, *Conformal Invariants* [1] ★; Ahlfors 1979, *Complex Analysis* [1] ★; Ahlfors 2006, *Quasiconformal Mappings* [1] ★; Astala–Iwaniec–Martin 2009, *Elliptic Partial Differential Equations…* [1] ★; Bahouri–Chemin–Danchin 2011, *Fourier Analysis and Nonlinear Partial…* [1] ★; Bergh–Löfström 1976, *Interpolation Spaces* [1] ★; Bishop–Peres 2017, *Fractals in Probability and Analysis* [1] ★; Blekherman–Parrilo–Thomas 2013, *Semidefinite Optimization and Convex…* [1] ★; Braides 2002, *Γ-convergence for Beginners* [1] ★; Bressan 2000, *Hyperbolic Systems of Conservation Laws* [1] ★; Cazenave 2003, *Semilinear Schrödinger Equations* [1] ★; Ciarlet 1988, *Mathematical Elasticity, Vol. I* [1] ★; Conway 1978, *Functions of One Complex Variable I* [1] ★; Dacorogna 2008, *Direct Methods in the Calculus of…* [1] ★; Dafermos 2016, *Hyperbolic Conservation Laws in…* [1] ★; Duren 1970, *Theory of H^p Spaces* [1] ★; Duren 1983, *Univalent Functions* [1] ★; Evans 2010, *Partial Differential Equations* [1] ★; Falconer 2014, *Fractal Geometry* [1] ★; Garnett 2007, *Bounded Analytic Functions* [1] ★; Garnett–Marshall 2005, *Harmonic Measure* [1] ★; Giusti 2003, *Direct Methods in the Calculus of…* [1] ★; Goluzin 1969, *Geometric Theory of Functions of a…* [1] ★; Grauert–Remmert 1979, *Theory of Stein Spaces* [1] ★; Groemer 1996, *Geometric Applications of Fourier…* [1] ★; Gunning–Rossi 1965, *Analytic Functions of Several Complex…* [1] ★; Guth 2016, *Polynomial Methods in Combinatorics* [1] ★; Hille 1976, *Ordinary Differential Equations in the…* [1] ★; Hörmander 1997, *Nonlinear Hyperbolic Differential…* [1] ★; Iwasaki et al. 1991, *From Gauss to Painlevé* [1] ★; Katznelson 2004, *Harmonic Analysis* [1] ★; Krantz 1992, *Function Theory of Several Complex…* [1] ★; Lawler 2005, *Conformally Invariant Processes in the…* [1] ★; Lehto–Virtanen 1973, *Quasiconformal Mappings in the Plane* [1] ★; Linares–Ponce 2015, *Nonlinear Dispersive Equations* [1] ★; Majda 1984, *Compressible Fluid Flow and Systems of…* [1] ★; Marshall 2008, *Positive Polynomials and Sums of Squares* [1] ★; Moore–Kearfott–Cloud 2009, *Interval Analysis* [1] ★; Neumaier 1990, *Interval Methods for Systems of…* [1] ★; Olver 1974, *Asymptotics and Special Functions* [1] ★; Pommerenke 1975, *Univalent Functions* [1] ★; Pommerenke 1992, *Boundary Behaviour of Conformal Maps* [1] ★; Ransford 1995, *Potential Theory in the Complex Plane* [1] ★; Rudin 1987, *Real and Complex Analysis* [1] ★; Sogge 2017, *Fourier Integrals in Classical Analysis* [1] ★; Stephenson 2005, *Circle Packing* [1] ★; Struwe 2008, *Variational Methods* [1] ★; Taylor 2011, *Partial Differential Equations I–III* [1] ★; Triebel 1983, *Theory of Function Spaces* [1] ★; Tucker 2011, *Validated Numerics* [1] ★; Wasow 1965, *Asymptotic Expansions for Ordinary…* [1] ★; Watson 1944, *Treatise on the Theory of Bessel…* [1] ★; Zygmund 2002, *Trigonometric Series, Vols. I & II* [1] ★.

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
