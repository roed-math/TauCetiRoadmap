# OpenAI release: geometry, topology and dynamics share (2026-10-07)

Scope: the 74 result families of `openai_families.json` whose subject is Differential geometry (29),
Topology (18), Convex and metric geometry (15) or Dynamical systems and ergodic theory (12);
124 manuscripts. Needs: `needs_openai_geometry_topology_dynamics.jsonl` (256 lines). Generator
`gen.py` and PDF text `txt/` are in this session's scratchpad `agent-oai-geom/`.

## (a) Statistics and method

- **Reading.** Every abstract and family summary; the introduction, proof overview and bibliography
  of 60 PDFs covering 59 families (087, 088, 090, 091, 093, 095, 097, 101, 143–154 except 152,
  304–307, 309–313, 315–317, 320, 321, 333, 335–358, 360). Lean: `lean/docs/NNN.md` for all
  families, `formalization.yaml`, the comparator configs, and the definition files of the relevant
  `lean/OAI/` directories.
- **Formalization coverage.** 40 of the 74 families have a Lean docs page (`lean/docs/NNN.md`);
  the `formalized` flag in `openai_families.json` marks only 22, so it under-reports. Family 357 has
  a large unconditional formalization (`OAI/Geometry/RCD`, `OAI/Analysis/RCDHeat`) that no docs page
  lists; 340 has partial code (`OAI/Geometry/NearbyLagrangian`, no main theorem).
- **Classification** (one line per family in section (d)):

  | Subject | elementary | needs | frontier |
  |---|---|---|---|
  | Convex and metric geometry (15) | 2 | 13 | 0 |
  | Dynamical systems and ergodic theory (12) | 1 | 9 | 2 |
  | Differential geometry (29) | 0 | 17 | 12 |
  | Topology (18) | 0 | 6 | 12 |
  | **Total (74)** | **3** | **45** | **26** |

  "Frontier" means the proof rests on research-level theory that no roadmap could own as library
  material (Almgren–De Lellis regularity, Ricci-flow singularity analysis, instanton Floer theory,
  chromatic computations, Freedman–Quinn 4-manifold topology). Every frontier family still has
  statement-level needs, listed in the table.
- **Needs by coverage** (256 lines): gap 164, Tau Ceti roadmap 28, Mathlib 21, open PR 21, Tau Ceti
  code 15, Birkbeck campaign 6, OAI Lean 1. Statement-level needs are a gap in 75 of 125 lines; only
  17 families (096, 097, 100, 151, 306, 321, 333, 334, 340, 342, 343, 345, 347, 348, 356, 358, 360)
  can be *stated* from existing or planned material today, several of those only through partial
  owners.
- **Headline finding.** Tau Ceti's geometry is foundational but stops one layer short of what these
  papers use. It has the Levi-Civita connection, curvature, sectional/Ricci/scalar curvature,
  geodesics, the exponential map, Hopf–Rinow and Riemannian volume (code), forms and Stokes
  (roadmap), optimal transport through MTW and RCD (roadmap), and J-holomorphic curves (roadmap).
  It has no comparison geometry, no analysis on closed manifolds beyond Green's identities, no
  convex-body theory, no ergodic theory beyond the mean ergodic theorem, no smooth dynamics, no
  geometric measure theory, no stable homotopy theory, and no Kähler or several-complex-variables
  geometry. The OAI Lean library shows the same gap: at least six paper directories re-define
  curvature in charts on top of Mathlib's `ContMDiffRiemannianMetric`.

## (b) Prerequisite clusters and coverage

Families are OAI family numbers. S/P: needed to state / to prove. Proposed names in **bold** are
specified in section (c); names marked (sib.) are proposed by a sibling share and are adopted here
for consistency (coordination notes at the end of (c)).

| Cluster | Strongest existing coverage | Missing part goes to | Families | arXiv | S/P |
|---|---|---|---|---|---|
| Riemannian metric, connection, curvature tensors, geodesics, exp, Hopf–Rinow, volume | Tau Ceti code (`Geometry/Manifold/Riemannian`, `VectorBundle/CovariantDerivative/Curvature/{Tensor,Ricci,Sectional,Scalar}`) | — | 333–335, 339, 345, 358 | math.DG | S |
| Curvature algebra, Weyl decomposition, Einstein metrics, submanifolds, Jacobi fields, comparison | partial: Tau Ceti tensors; OptimalTransport L7 (cut locus) | **RiemannianGeometry** | 334, 337, 344, 348, 349, 358, 360 | math.DG | S, P |
| Volume/triangle comparison, splitting, Bochner, Chern–Gauss–Bonnet, geodesic Morse theory, CROSSes | gap | **GlobalRiemannianGeometry** | 335, 338, 339, 344, 345, 348, 361 | math.DG | P |
| Elliptic theory and Hodge theorem on closed manifolds | gap (PDE is Euclidean only; DifferentialGeometry L12 stops at Green) | **EllipticOperatorsOnManifolds** | 341, 342, 348 | math.DG | P |
| Laplace spectrum, eigenfunctions, nodal sets, harmonic functions of polynomial growth | gap | **SpectralGeometry** (sib. Annals) | 336, 350, 361 | math.DG | S, P |
| Optimal transport: Brenier, Monge–Ampère/Caffarelli, MTW, cut locus | Tau Ceti roadmap OptimalTransport L5–L7 (Brenier in code) | — | 091, 101, 353, 360 | math.OC | S, P |
| RCD/CD spaces, Cheeger energy, heat flow | Tau Ceti roadmap OptimalTransport L14 | — | 356, 357 | math.MG | S, P |
| Ricci-limit spaces, Cheeger–Colding, tangent cones | gap | **RicciLimitSpaces** | 357, 361 | math.DG | S, P |
| CAT(κ), Alexandrov (CBB) spaces, cube and Davis complexes | partial: OptimalTransport L8 (CBB predicate); Tau Ceti length spaces | **AlexandrovAndCATSpaces** | 305, 320, 337, 356, 358 | math.MG | S, P |
| Rectifiability, currents, BV and finite perimeter, isoperimetric regions | gap | GeometricMeasureTheory (sib. analysis) | 336, 337, 354 | math.CA | S, P |
| Varifolds, minimal submanifolds, min–max, PSC descent and μ-bubbles | gap | **MinimalSubmanifolds** (sib. Annals) | 335, 336, 346, 349 | math.DG | S, P |
| Ricci, mean-curvature, Kähler–Ricci, Calabi, hypersymplectic flows | gap | **GeometricFlows** (sib. Annals) | 338, 341, 351, 352, 355 | math.DG | S, P |
| Nash–Kuiper, Nash, Janet–Cartan, Darboux equation | partial: sphere-eversion local h-principle (OAI dependency) | **IsometricEmbeddings** | 333, 334 | math.DG | P |
| Kähler metrics: curvature, Calabi ansatz, toric, hyperkähler | gap | **KahlerGeometry**; Hermitian/Chern/Hodge part to KahlerManifoldsAndHodgeTheory (sib. AG) | 338, 341, 343, 347, 352, 359 | math.DG | S, P |
| Several complex variables, psh functions, bounded domains | gap (ComplexManifolds #279 gives carriers) | SeveralComplexVariables (sib. AG) | 338, 359 | math.CV | S, P |
| Pluripotential theory, positive currents, Lelong numbers | gap | PositiveCurrentsAndMongeAmpere (sib. AG) | 087, 342 | math.CV | P |
| Symplectic manifolds, almost complex structures, J-curves, Darboux/Moser | Tau Ceti code `Geometry/Symplectic`; roadmap HeegaardFloer F0–F2 | — | 087, 342, 343 | math.SG | S, P |
| Hamiltonian flows; Floer homology, Hofer–Zehnder capacity, cotangent bundles | open PRs HamiltonianSystems #480, DGFloer #655 | — | 340, 347 | math.SG | S, P |
| Capacities, Gromov width, packings, cuts, toric, Lagrangians in T*Q, LS category | partial: DGFloer #655 | **SymplecticTopology** | 087, 340, 343, 347 | math.SG | S, P |
| Convex bodies: mixed volumes, polarity, projection bodies, isotropic position | Mathlib `ConvexBody`; Brunn–Minkowski/Prékopa in open PR #287 | **ConvexBodies** | 087, 088, 091, 092, 101, 353 | math.MG | S, P |
| Log-concave measures, Gaussian convex-set inequalities | partial: PR #287 (Prékopa) | **LogConcaveMeasures** | 087, 091, 093, 096, 097, 101 | math.PR | S, P |
| Poincaré/log-Sobolev, Bakry–Émery, Brascamp–Lieb, Caffarelli contraction | gap | ConcentrationAndFunctionalInequalities (sib. probability) | 091, 093, 101 | math.PR | S, P |
| Metric embeddings, distortion, cut cone, expanders, doubling spaces | gap | **MetricEmbeddings** | 089, 094, 098, 099, 307 | math.MG | S, P |
| Packing/covering densities, LP bounds, energy of configurations | gap (theta series: PR #286) | **PackingCoveringEnergy** | 090, 092 | math.MG | S, P |
| Hyperbolic polynomials, spectrahedra, semidefinite lifts | gap (RealAlgebraicGeometry substrate) | **ConvexAlgebraicGeometry** | 095 | math.OC | S, P |
| Ergodic theorems, mixing, spectral theory, joinings, Lebesgue spaces | Mathlib ergodicity + mean ergodic theorem | **ErgodicTheory** (same name in probability share) | 144, 145, 150, 152, 154 | math.DS | S, P |
| Kolmogorov–Sinai entropy, SMB, variational principle | Mathlib topological entropy only | **EntropyAndThermodynamicFormalism** (sib. Annals) | 145, 146, 148, 152, 153, 339 | math.DS | S, P |
| Multiple recurrence, Furstenberg–Zimmer, characteristic factors | gap | ErgodicRamseyTheory (sib. combinatorics) | 145, 154 | math.DS | P |
| Oseledets, Pesin theory, Anosov systems, Hopf argument | gap (Tau Ceti local stable manifolds) | **SmoothErgodicTheory** | 146, 152, 339 | math.DS | P |
| Twist maps, KAM/Aubry–Mather, convex and polygonal billiards | gap | **AreaPreservingMapsAndBilliards** | 146, 147, 150 | math.DS | S, P |
| IFS, self-similar measures, dimension of measures, Bernoulli convolutions | Mathlib Hausdorff dimension of sets | **FractalGeometry** (same name in probability share) | 148, 153 | math.DS | S, P |
| Planar ODE, limit cycles, Liénard, reaction networks | Tau Ceti ODE/flows substrate | **QualitativeODE** | 143, 149 | math.DS | S, P |
| Singular (co)homology, cup products, local coefficients | Tau Ceti roadmap AlgebraicTopology (+ code) | — | 151, 310, 321, 345, 347 | math.AT | S, P |
| K(G,1), group (co)homology | open PR ClassifyingSpaces #437 | — | 315, 321, 335 | math.AT | S, P |
| Dehn surgery; JSJ/Seifert/graph manifolds | Tau Ceti roadmap GeometricTopology L5, L8 | — | 306, 358 | math.GT | S, P |
| Stable homotopy category, Steenrod algebra, Adams SS, MU/BP, ANSS | partial: Birkbeck StableHomotopyKTheory H.5 (spectra); PR #284 (EHP stems) | **StableHomotopyTheory** | 308, 309, 316, 319 | math.AT | S, P |
| Morava K/E, Lubin–Tate, stabilizer group, K(n)-localization, tt-geometry | partial: Birkbeck p-divisible groups, Fargues–Fontaine | **ChromaticHomotopyTheory** (same name in Annals share) | 308, 309, 311, 313, 314, 318, 319 | math.AT | S, P |
| Model categories, Kan–Quillen, strict ω-categories, coherators | partial: Mathlib model categories, Kan complexes | **ModelCategoriesAndStrictHigherCategories** | 312, 317 | math.AT | S, P |
| Topological 4-manifolds, disc embedding, nonsimply connected surgery | partial: PR #284 (simply connected surgery) | **FourManifoldTopology** | 305, 320 | math.GT | S, P |
| Hyperbolic groups, convergence groups | gap | HyperbolicGroups (sib. algebra/groups) | 315, 320 | math.GR | S, P |
| Poincaré duality groups, cohomological dimension | gap | GroupCohomologyFiniteness (sib. algebra/groups) | 305, 315 | math.GR | S |
| L²-Betti numbers | gap | GroupVonNeumannAlgebras (sib. algebra/groups) | 315 | math.AT | S |
| Bounded cohomology, simplicial volume | gap | **BoundedCohomology** | 335 | math.GT | S |
| Operator K-theory, Roe algebras, coarse assembly | gap (Mathlib C*-algebras) | OperatorKTheory (sib. analysis), coarse layer | 307 | math.KT | S |
| Gauge theory (instantons, Seiberg–Witten, instanton Floer) | gap | **GaugeTheory** | 306 | math.DG | P |
| Transformation groups, Hilbert's fifth problem, Smith theory | gap | **TransformationGroups** | 304 | math.GT | S |
| Sheaves on locally compact spaces, Verdier duality | gap (Birkbeck: étale only) | MicrolocalSheafTheory (sib. Annals) | 304 | math.AT | P |
| Waldhausen K-theory of spaces, parametrized h-cobordism | partial: Birkbeck GeneralAlgebraicKTheory | — (frontier) | 340 | math.KT | P |
| o-minimal/subanalytic geometry | partial: Birkbeck LogicAndDefinabilityInNumberTheory | — (frontier) | 143 | math.LO | P |

## (c) Proposed roadmaps

Ordered by reach. Size: M ≈ one graduate course, L ≈ two, XL ≈ a monograph. In headline lists,
"Statements:" marks research-level theorems the roadmap states without proof; the rest are proved.

### Tier 1: foundational, three or more families each

**RiemannianGeometry** — math.DG — L.
This roadmap develops the local and semi-global theory of Riemannian manifolds between the
Levi-Civita connection and global comparison theorems: the algebra of the curvature tensor,
Riemannian submanifolds, Jacobi fields and the second variation of energy, and the comparison
theorems that follow from them. It consumes Tau Ceti's connection, curvature tensors, parallel transport,
geodesics, exponential map and Hopf–Rinow.
*Objects:* Bianchi identities; Weyl decomposition and the Λ⁺⊕Λ⁻ splitting in dimension 4; Einstein
metrics; second fundamental form, Gauss–Codazzi–Ricci, first variation of area; Jacobi fields,
conjugate and focal points, index form; Hessian and Laplacian of distance functions.
*Headline:* Theorema Egregium; Jacobi's criterion (no geodesic minimizes past a conjugate point);
Rauch, Hessian and Laplacian comparison; Bonnet–Myers; Cartan–Hadamard; Synge; Preissmann;
Killing–Hopf classification of complete space forms; Gauss–Bonnet for closed surfaces.
*Prerequisites:* Tau Ceti Riemannian code; HopfRinow (archived, PR #723); DifferentialGeometry;
cut locus and injectivity radius are OptimalTransport L7's (consume).
*Families:* 334, 337, 344, 348, 349, 358, 360; substrate for 335, 339, 345, 361.
*Formalizability:* high (Lee, *Introduction to Riemannian Manifolds*); port `OAI/Geometry/ConjugatePoints`.

**GlobalRiemannianGeometry** — math.DG — L.
Global consequences of curvature bounds: volume and triangle comparison, splitting and rigidity,
the Bochner technique, Chern–Weil formulas, Morse theory of the energy functional, and the rank-one
symmetric spaces that appear as rigidity models.
*Headline:* Bishop–Gromov and Gromov precompactness (consume Mathlib's Gromov–Hausdorff space);
Toponogov; Busemann functions and the Cheeger–Gromoll splitting theorem; Milnor's growth bound for
π₁ under Ric ≥ 0; Bochner's theorem (Ric > 0 ⇒ b₁ = 0) and Weitzenböck formulas for forms;
Lichnerowicz–Obata; Chern–Weil forms and Chern–Gauss–Bonnet; the Hitchin–Thorpe inequality; the
Morse index theorem and Morse theory of geodesics through broken-geodesic finite-dimensional
approximation (Milnor); Lyusternik–Fet; Riemannian symmetric spaces and compact rank-one symmetric
spaces; the Berger–Kazdan inequality for Blaschke manifolds. Statements: soul theorem,
Gromoll–Meyer, sphere theorems.
*Prerequisites:* RiemannianGeometry; EllipticOperatorsOnManifolds (Hodge theorem for Bochner);
AlgebraicTopology (Thom isomorphism, cell attachment); RepresentationTheory/LieGroups.
*Families:* 335, 338, 339, 344, 345, 348, 361.
*Formalizability:* high; Milnor's approximation avoids Hilbert manifolds. OAI `Geometry/EinsteinFour`'s
`…Input` structures (Gursky–LeBrun, Derdzinski, Hatcher) list results this roadmap must supply.

**EllipticOperatorsOnManifolds** — math.DG (sec. math.AP) — L. Also proposed by the Annals share
(same name) and the analysis share (`EllipticTheoryOnManifolds`); one roadmap.
Linear elliptic theory on closed manifolds: Sobolev spaces of sections, elliptic regularity and
Fredholm theory for elliptic operators between vector bundles, the Hodge theorem, and the
four-dimensional splitting of 2-forms.
*Headline:* Sobolev embedding and Rellich on closed manifolds; Gårding inequality and elliptic
regularity; Fredholm alternative; Hodge decomposition and Hodge theorem (harmonic forms ≅ de Rham);
b⁺/b⁻ and self-dual harmonic forms in dimension 4; discreteness of the Laplace spectrum; sharp
Sobolev inequality under positive Ricci (statement).
*Prerequisites:* PDE (Euclidean estimates); DifferentialGeometry (forms, Hodge star, L12);
Mathlib vector bundles.
*Families:* 341, 342, 348; prerequisite of SpectralGeometry (336, 350, 361) and of 338.
*Formalizability:* high, large; port from `OAI/Geometry/TamingCompatibility`.

**SpectralGeometry** — math.DG (sec. math.SP, math.AP) — L. Name proposed by the Annals share; this
share is its main consumer.
Laplace–Beltrami eigenvalues and eigenfunctions, and harmonic functions on complete manifolds.
*Headline:* min–max; Weyl law; Cheeger and Lichnerowicz eigenvalue bounds; heat kernel and its
small-time asymptotics; unique continuation; Courant nodal domain theorem; Brüning–Yau lower bound
for nodal length on surfaces; Yau gradient estimate, Cheng–Yau and the Liouville theorem under
Ric ≥ 0; harmonic functions of polynomial growth and Colding–Minicozzi finite dimensionality
(statement); Donnelly–Fefferman and Logunov–Malinnikova nodal bounds (statements).
*Prerequisites:* EllipticOperatorsOnManifolds; GlobalRiemannianGeometry.
*Families:* 336, 350, 361 (and the heat-kernel comparison in 090).
*Formalizability:* high; port `OAI/Geometry/NodalSets`, `OAI/Analysis/NodalLength`.

**ConvexBodies** — math.MG (sec. math.FA) — L.
This roadmap builds the Brunn–Minkowski theory of convex bodies in finite-dimensional real inner
product spaces: support functions, Minkowski addition and mixed volumes, the Brunn–Minkowski and
Minkowski inequalities with their equality cases, surface area measures and the Minkowski problem,
polarity and the Blaschke–Santaló inequality, projection and centroid bodies, symmetrization, and
the affine invariants (John ellipsoid, isotropic position) of asymptotic convex geometry.
*Headline:* Steiner formula; Brunn–Minkowski with equality (consume PR #287 for the inequality);
Minkowski's first and quadratic inequalities; Aleksandrov–Fenchel; Minkowski existence and
uniqueness theorem; Cauchy projection formula; Aleksandrov's projection-body injectivity (spherical
harmonics layer); Blaschke–Santaló with equality; Mahler's planar theorem; Petty projection and
Busemann–Petty centroid inequalities; John's theorem; Klartag's reduction of the nonsymmetric
Mahler inequality to the simplex bound for L_K. Statements: symmetric and general Mahler
conjectures, log-Brunn–Minkowski.
*Prerequisites:* Mathlib convexity and measure; PR #287; a spherical-harmonics layer.
*Families:* 087, 088, 091, 092, 101, 353 (John ellipsoid); also 097, 100.
*Formalizability:* high (Schneider, *Convex Bodies*); OAI defines these objects ad hoc in
`Analysis/Mahler`, `Geometry/ProjectionBodies`, `Geometry/LogVolume`.

**LogConcaveMeasures** — math.PR (sec. math.FA, math.MG) — M.
Log-concave and s-concave measures as the measure-theoretic side of convex bodies, and the
Gaussian-measure inequalities for convex sets.
*Headline:* Borell's characterization of s-concave measures; Prékopa's theorem (consume PR #287);
Borell's lemma and exponential tails; differential entropy and covariance of log-concave densities;
Borell–Sudakov–Tsirelson Gaussian isoperimetry; Ehrhard's inequality; Royen's Gaussian correlation
inequality; Banaszczyk's vector-balancing theorem; isotropic log-concave measures and the link to
L_K. Statements: KLS and thin-shell bounds (Klartag–Lehec), the (B)-conjecture.
*Prerequisites:* ConvexBodies; Mathlib Gaussians; ConcentrationAndFunctionalInequalities
(probability share; owns Poincaré, log-Sobolev, Bakry–Émery, Brascamp–Lieb, Caffarelli contraction).
*Families:* 087 (functional Mahler), 091, 093, 096, 097, 101.
*Formalizability:* high.

**MetricEmbeddings** — math.MG (sec. cs.DS, math.FA) — L.
Bi-Lipschitz and coarse embeddings of metric spaces into Banach spaces: finite metrics, L₁ and the
cut cone, negative type, Poincaré inequalities and expanders as obstructions, doubling spaces, and
the Banach-space invariants that control embeddability.
*Headline:* Kirszbraun and McShane extension; Fréchet and Bourgain O(log n) embeddings;
Johnson–Lindenstrauss; finite L₁ metrics are nonnegative combinations of cut metrics; the
Linial–London–Rabinovich flow–cut gap; expanders need Ω(log n) distortion into L₁ and L₂; Enflo's
cube bound; Assouad's embedding of snowflakes of doubling spaces; Brinkman–Charikar dimension lower
bound in ℓ₁; type, cotype and basic sequences. Statements: Dvoretzky, Ribe, the
Gupta–Newman–Rabinovich–Sinclair conjectures.
*Prerequisites:* Mathlib L^p spaces and normed spaces; GraphConnectivityAndFlows (#444) for flows;
PlanarTopology (#271) for planar graphs.
*Families:* 089, 094, 098, 099, 307 (expanders).
*Formalizability:* high. The combinatorics share proposes `ConvexRelaxationsAndMetricEmbeddings`;
recommended split: geometry here, SDP/LP rounding there.

**ErgodicTheory** — math.DS (sec. math.PR) — L. Same name in the probability share; merge.
Measure-preserving dynamics beyond the mean ergodic theorem: pointwise theorems, ergodic
decomposition, Lebesgue spaces, mixing, Koopman spectral theory, factors and joinings.
*Headline:* maximal ergodic lemma and Birkhoff's pointwise theorem for ℤ- and ℝ-actions; Kingman
(shared with probability); ergodic decomposition on standard Borel spaces; Kac and Rokhlin lemmas;
weak mixing equivalences; Halmos–von Neumann discrete-spectrum theorem; spectral types, multiplicity
and Lebesgue spectrum; k-fold mixing; joinings, disjointness (Furstenberg), relatively independent
joinings, compact group extensions; suspension flows and induced maps.
*Prerequisites:* Mathlib `Dynamics/Ergodic`, Tau Ceti `Probability/Ergodic`; Mathlib spectral theory.
*Families:* 144, 145, 150, 152, 154; substrate for 146, 148, 339.
*Formalizability:* high; Walters, Glasner, Einsiedler–Ward.

**EntropyAndThermodynamicFormalism** — math.DS — L. Name proposed by the Annals share; this share
needs its entropy half.
*Requirements from this share:* Kolmogorov–Sinai entropy via partitions and the generator theorem;
conditional entropy calculus; Shannon–McMillan–Breiman; Abramov; entropy of Bernoulli and Markov
shifts; Pinsker factor and K-systems; the variational principle (consuming Mathlib's topological
entropy); measures of maximal entropy; Ornstein's isomorphism theorem (statement).
*Families:* 145, 146, 148, 152, 153, 339.

**SmoothErgodicTheory** — math.DS (sec. math.DG) — L. Subsumes the Annals share's
`NonuniformHyperbolicity`.
Lyapunov exponents, uniform and nonuniform hyperbolicity, stable manifolds, absolute continuity and
the Hopf argument, and the entropy formulas of Pesin and Ruelle.
*Headline:* Oseledets multiplicative ergodic theorem; Ruelle inequality; Pesin entropy formula
(Mañé's proof); Pesin stable manifolds; stable manifold theorem for hyperbolic sets; Anosov closing
and shadowing; absolute continuity of stable foliations; Hopf argument and Anosov's theorem
(ergodicity of geodesic flows in negative curvature); Bowen's measure of maximal entropy.
Statements: structural stability, Katok entropy conjecture, Besson–Courtois–Gallot,
Benoist–Foulon–Labourie.
*Prerequisites:* ErgodicTheory; EntropyAndThermodynamicFormalism; Tau Ceti `Dynamics/Flow/Stable`,
`Analysis/ODE/LyapunovPerron`; RiemannianGeometry (Jacobi fields for geodesic flows).
*Families:* 146, 152, 339; also 144.
*Formalizability:* medium–high; Katok–Hasselblatt, Barreira–Pesin.

**SymplecticTopology** — math.SG — L.
Global symplectic geometry between the linear theory and Floer homology: neighborhood theorems,
constructions, capacities and embeddings, Lagrangians in cotangent bundles, fixed-point bounds.
*Headline:* Liouville volume; Weinstein Lagrangian neighborhood theorem; symplectic blowup and
blowdown; symplectic cuts; Delzant's classification of toric symplectic manifolds; capacity axioms,
Gromov width and Gromov nonsqueezing (from HeegaardFloer F2's J-curves); volume obstruction to ball
packings; cup-length and LS-category bounds for Hamiltonian fixed points on tori; exact Lagrangians
in T*Q up to Hamiltonian isotopy and generating families quadratic at infinity. Statements:
McDuff–Polterovich packing/blowup correspondence, Biran packing stability, nearby Lagrangian
conjecture and Abouzaid–Kragh, Arnold conjecture variants, Taubes' Seiberg–Witten = Gromov.
*Prerequisites:* Tau Ceti `Geometry/Symplectic`; HeegaardFloer F0–F2 (Darboux, Moser, J-curves);
HamiltonianSystems (#480, moment maps); DGFloer (#655, Hofer–Zehnder capacity, cotangent bundles);
DifferentialGeometry.
*Families:* 087, 340, 343, 347; statement of 342.
*Formalizability:* high; nonsqueezing waits on HeegaardFloer F2. The Annals share's
`SymplecticRigidity` should be a layer here or a declared neighbour.

**AlexandrovAndCATSpaces** — math.MG (sec. math.GR) — L.
Synthetic sectional-curvature bounds: CAT(κ) spaces and groups acting on them, Alexandrov spaces
of curvature bounded below, and their polyhedral sources.
*Headline:* Alexandrov angles; Cartan–Hadamard for metric spaces (Alexander–Bishop); Bruhat–Tits
fixed point; flat torus and solvable subgroup theorems; Gromov's link condition for cube complexes;
the Davis complex and the reflection-group trick (Moussong's theorem for right-angled Coxeter
groups; general case statement); Riemannian manifolds with sec ≤ κ are locally CAT(κ); Toponogov
globalization for CBB spaces; Burago–Gromov–Perelman dimension and tangent cones; Perelman
stability (statement).
*Prerequisites:* Tau Ceti length spaces; Mathlib Gromov–Hausdorff; OptimalTransport L8 (owns the
CBB predicate; this roadmap supplies its structure theory); RepresentationTheory/RootSystems
(Coxeter groups); RiemannianGeometry.
*Families:* 305, 320, 337, 356, 358.
*Formalizability:* high; Bridson–Haefliger, Burago–Burago–Ivanov.

**StableHomotopyTheory** — math.AT — XL.
The stable homotopy category and its machinery: spectra with a symmetric monoidal smash product,
the Steenrod algebra and Adams spectral sequence, complex cobordism and the Adams–Novikov spectral
sequence.
*Headline:* Brown representability; Steenrod algebra (Adem relations, Milnor basis, Cartan
formula); construction and convergence of the Adams spectral sequence; Adams' Hopf invariant one
theorem (K-theory proof); Thom's computation of MO_*; Milnor–Novikov π_*MU; Quillen's theorem
(MU_* is the Lazard ring); BP and the Adams–Novikov spectral sequence; Browder's theorem on the
Kervaire invariant. Statements: Hill–Hopkins–Ravenel; Curtis and Kervaire problems.
*Prerequisites:* AlgebraicTopology; Birkbeck StableHomotopyKTheory H.5 and EnhancedDerivedSheaves
(choose the spectra model once); HomotopySpheres (#284) for EHP stems.
*Families:* 308, 309, 316, 319; substrate for all chromatic families.
*Formalizability:* hard foundations, large payoff.

**ChromaticHomotopyTheory** — math.AT (sec. math.NT, math.AG) — XL. Same name in the Annals share.
The chromatic filtration of the stable homotopy category.
*Headline:* Landweber exact functor theorem; Morava K(n) and E_n; Lubin–Tate deformation theory of
height-n formal groups; the Morava stabilizer group and Morava's change of rings; Bousfield
localization, L_n, L_{K(n)}, chromatic fracture squares; Devinatz–Hopkins homotopy fixed points
E_n^{hG}; the Balmer spectrum of finite spectra (from the thick subcategory theorem); genuine
equivariant spectra and geometric fixed points (layer for 314). Statements: nilpotence, thick
subcategory and periodicity theorems, Goerss–Hopkins–Miller, chromatic convergence, chromatic
splitting, Hovey–Strickland, Hahn–Wilson.
*Prerequisites:* StableHomotopyTheory; Birkbeck FiniteFlatGroupsAndIntegralPadicHodgeTheory
(p-divisible/formal groups), VectorBundlesAndIsocrystals and PerfectoidSpaces (Fargues–Fontaine
input for 311, 313); ClassFieldTheory (height-one Lubin–Tate); ProfiniteCohomology (continuous
cohomology of G_n).
*Families:* 308, 309, 311, 313, 314, 318, 319.
*Formalizability:* statements reachable after StableHomotopyTheory; proofs frontier.

**GeometricFlows** — math.DG (sec. math.AP) — L. Same name in the Annals share.
Ricci, mean curvature and Kähler flows, from short-time existence and maximum principles to the
monotonicity formulas that govern singularities.
*Headline:* DeTurck short-time existence on closed manifolds; Shi estimates; Hamilton's tensor
maximum principle; Hamilton's theorem on 3-manifolds with Ric > 0; Perelman's W-entropy and no local
collapsing; Huisken's theorem for convex hypersurfaces; Huisken monotonicity; shrinking spheres and
cylinders as self-shrinkers; Brakke flows (definition); Cao's Kähler–Ricci flow existence; Calabi
flow short-time existence. Statements: Colding–Minicozzi entropy and generic singularities,
Bamler–Kleiner multiplicity one, Bamler's bounded-scalar-curvature theory.
*Prerequisites:* RiemannianGeometry; EllipticOperatorsOnManifolds; PDE (parabolic lane);
KahlerGeometry.
*Families:* 338, 341, 351, 352, 355.
*Formalizability:* statements cheap after RiemannianGeometry; proofs frontier except 352.

**MinimalSubmanifolds** — math.DG — L. Same name in the Annals share; this share adds varifolds and
the scalar-curvature layer.
*Requirements from this share:* first and second variation, stability and index; Simons' identity,
the Simons cone and Bernstein's theorem (Bombieri–De Giorgi–Giusti as statement); monotonicity;
stationary integral varifolds, Allard regularity and compactness; minimal hypersurfaces in spheres
(Clifford hypersurfaces, Lawson); Almgren–Pitts min–max and Marques–Neves Willmore (statements);
Schoen–Yau descent and μ-bubbles for positive scalar curvature; Urysohn width and macroscopic
dimension (definitions, Gromov's conjectures as statements).
*Families:* 335, 336, 346, 349. Prerequisite: GeometricMeasureTheory (analysis share).

### Tier 2: one or two families each, coherent subjects

**KahlerGeometry** — math.DG (sec. math.CV, math.SG) — L. Same name in the Annals share; the AG
share's `KahlerManifoldsAndHodgeTheory` owns Hermitian metrics, the Chern connection and Hodge
theory, and this roadmap consumes it.
Kähler metrics as Riemannian objects: curvature conditions, extremal metrics, symmetry reductions,
hyperkähler 4-manifolds.
*Headline:* holomorphic sectional and bisectional curvature and their relations; Calabi's
extremal-metric equation and the Calabi functional; the Calabi ansatz for U(n)-invariant metrics on
CPⁿ and line bundles; Guillemin's toric metric and Abreu's equation; Kähler cuts
(Burns–Guillemin–Lerman); hyperkähler triples on 4-manifolds. Statements: Frankel and Mori–Siu–Yau,
Calabi–Yau and Kähler–Einstein existence (the AG share's `CalabiYauAndComplexMongeAmpere`).
*Families:* 341, 343, 352; with KahlerManifoldsAndHodgeTheory also 338, 347, 359.

**FractalGeometry** — math.DS (sec. math.MG, math.CA) — L. Same name in the probability share.
*Requirements from this share:* box, packing and lower/local dimensions of measures; Frostman and
mass distribution; iterated function systems, Hutchinson attractors and self-similar measures; open
set condition and the Moran–Hutchinson formula; exact dimensionality (Feng–Hu); Bernoulli
convolutions with Erdős's Pisot singularity theorem and Garsia's entropy criterion; Solomyak,
Hochman and Varjú theorems (statements). *Families:* 148, 153.

**AreaPreservingMapsAndBilliards** — math.DS (sec. math.SG) — M.
Area-preserving twist maps, their periodic orbits and invariant circles, and billiards in convex
and polygonal tables.
*Headline:* Poincaré–Birkhoff; Birkhoff periodic orbits of every rational rotation number; Birkhoff's
graph theorem for invariant circles; Aubry–Mather sets by the variational method; the billiard map
as a twist map, caustics and Lazutkin's theorem; integrability of elliptic billiards; unfolding of
rational polygons to translation surfaces; Zemlyakov–Katok transitivity. Statements: Moser twist
theorem, Kerckhoff–Masur–Smillie, Birkhoff conjecture, standard-map positive-entropy conjecture.
*Prerequisites:* ErgodicTheory; HamiltonianSystems (#480); Tau Ceti flows.
*Families:* 146, 147, 150. (HamiltonianSystems lists KAM and integrable systems as unowned.)

**QualitativeODE** — math.DS (sec. math.CA) — M.
Qualitative theory of autonomous ODE in the plane and of polynomial vector fields.
*Headline:* Poincaré–Bendixson; return maps and limit cycles; Dulac–Bendixson criteria; Lyapunov
functions and LaSalle invariance; index theory in the plane; Liénard's uniqueness theorem; Hopf
bifurcation; Bautin's theorem; mass-action reaction networks and the Horn–Jackson–Feinberg
deficiency-zero theorem. Statements: Dulac finiteness (Ilyashenko, Écalle), Hilbert's sixteenth
problem.
*Prerequisites:* Mathlib ODE; Tau Ceti `Analysis/ODE`, `Dynamics/Flow`, ω-limit sets.
*Families:* 143, 149.

**PackingCoveringEnergy** — math.MG (sec. math.NT, math.CA) — M.
Densities of packings and coverings by translates of a convex body and energies of point
configurations in Euclidean space.
*Headline:* packing and covering densities (periodic configurations suffice); Thue and
Fejes Tóth in the plane; Minkowski–Hlawka via the Siegel mean value theorem; Rogers' covering bound;
the Cohn–Elkies linear-programming bound; energies for completely monotone potentials and the
Cohn–Kumar framework; renormalized Coulomb/jellium energy (Sandier–Serfaty). Statements: Viazovska
(dimensions 8, 24), Cohn–Kumar–Miller–Radchenko–Viazovska universal optimality.
*Prerequisites:* ConvexBodies; Mathlib Fourier and Poisson summation; Tau Ceti
`Analysis/CompletelyMonotone`; IntegralLattices; ThetaSeries (#286).
*Families:* 090, 092. The LMFDB share proposes `LatticePackingsAndPerfectForms`; keep Voronoi theory
there and the analytic bounds here.

**IsometricEmbeddings** — math.DG (sec. math.AP) — M.
Isometric immersions and embeddings in Euclidean space.
*Headline:* Nash–Kuiper C¹ embedding by convex integration; Nash's smooth embedding theorem (Günther's
proof); Janet–Cartan local analytic embedding; the Darboux equation and Hilbert's theorem (no
complete immersion of the hyperbolic plane in ℝ³); Smale–Hirsch immersion theorem. Statements:
Efimov, Weyl problem (Nirenberg, Pogorelov).
*Prerequisites:* RiemannianGeometry; the sphere-eversion project's local h-principle (port); PDE.
*Families:* 333, 334.

**RicciLimitSpaces** — math.DG (sec. math.MG) — M.
Gromov–Hausdorff limits of manifolds with Ricci bounded below and noncollapsed RCD spaces.
*Headline:* pointed measured Gromov–Hausdorff convergence; Cheeger–Colding almost splitting and
"volume cone implies metric cone" for smooth manifolds; existence of tangent cones and their
conical structure in the noncollapsed case; Colding volume convergence. Statements:
Cheeger–Colding–Naber codimension-two, De Philippis–Gigli noncollapsed RCD theory.
*Prerequisites:* GlobalRiemannianGeometry; OptimalTransport L14.
*Families:* 357, 361 (tangent cones at infinity), 356. Port `OAI/Geometry/RCD`.

**FourManifoldTopology** — math.GT — L.
Topology of 4-manifolds and the surgery framework for aspherical manifolds.
*Headline:* intersection forms and Whitehead–Milnor (homotopy type of simply connected closed
4-manifolds); Wall's surgery exact sequence and L-groups of group rings (statements for dimension
≥ 5); Davis' aspherical manifolds by the reflection trick; Poincaré duality groups and complexes.
Statements: Freedman's classification, Donaldson's theorem, the disc embedding theorem
(Behrens–Kalmár–Kim–Powell–Ray), good groups, Farrell–Jones and Borel conjectures, Wall's D(2)
problem.
*Prerequisites:* GeometricTopology L1–L2, L6; HomotopySpheres (#284, simply connected surgery);
ClassifyingSpaces (#437); AlexandrovAndCATSpaces.
*Families:* 305, 320 (and 315, 321 statements). Proofs of these families are frontier.

**ModelCategoriesAndStrictHigherCategories** — math.AT (sec. math.CT) — L.
Combinatorial model category theory and the homotopy theory of strict higher categories.
*Headline:* the Kan–Quillen model structure and the Quillen equivalence with spaces (completing
Mathlib's Kan-complex and model-category files); the small object argument and Kan's recognition of
cofibrantly generated structures; Smith's theorem for combinatorial model structures; transferred
structures; Thomason's model structure on Cat; Street's orientals and nerve; Steiner's augmented
directed complexes; the Gray tensor product; Ara–Maltsiniotis Thomason structures on strict
n-categories; Grothendieck coherators and globular ∞-groupoids. Statement: the homotopy hypothesis.
*Prerequisites:* Mathlib `AlgebraicTopology/ModelCategory`, `SimplicialSet`,
`CategoryTheory/Presentable`.
*Families:* 312, 317. OAI's `CategoryTheory/Thomason` (160k lines) is a direct porting source.

**TransformationGroups** — math.GT (sec. math.GR) — L.
Continuous actions of locally compact groups on manifolds.
*Headline:* Gleason–Yamabe and Montgomery–Zippin (Hilbert's fifth problem); groups without small
subgroups are Lie; Bochner–Montgomery; the slice theorem for compact group actions; Smith theory for
ℤ/p-actions; Newman's theorem. Statements: Yang's cohomological-dimension theorem for ℤ_p-actions,
the Hilbert–Smith conjecture, Pardon's dimension-3 theorem.
*Prerequisites:* Mathlib locally compact groups and Haar measure; RepresentationTheory/LieGroups;
AlgebraicTopology; MicrolocalSheafTheory (Annals share) for sheaf-theoretic Smith theory.
*Families:* 304.

### Tier 3: single-family or frontier-only

**BoundedCohomology** — math.GT (sec. math.GR) — M. Bounded cohomology of groups and spaces and
simplicial volume: Gromov's mapping theorem, vanishing for amenable groups, duality between ℓ¹-seminorms
and bounded cohomology, simplicial volume of surfaces, Gromov–Thurston positivity for hyperbolic
manifolds, proportionality (statement). Prerequisites: AlgebraicTopology, ClassifyingSpaces,
AmenableGroupsAndGrowth (algebra share). Family: 335.

**ConvexAlgebraicGeometry** — math.OC (sec. math.AG) — M. Hyperbolic polynomials and hyperbolicity
cones (Gårding, Renegar derivatives), real stable polynomials, spectrahedra and linear matrix
inequalities, semidefinite duality, spectrahedral shadows. Statements: Helton–Vinnikov, the
generalized Lax conjecture, Scheiderer's non-representability theorem. Prerequisite:
RealAlgebraicGeometry. Family: 095. Coordinate with the combinatorics share's SDP material.

**GaugeTheory** — math.DG (sec. math.GT) — XL. Connections on principal bundles, anti-self-dual
instantons, Uhlenbeck compactness, Donaldson and Seiberg–Witten invariants, instanton Floer homology.
Family: 306 (frontier). Low priority here; the analytic counterpart of HeegaardFloer.

### Requirements on roadmaps owned by sibling shares

- *ConcentrationAndFunctionalInequalities* (probability): Brascamp–Lieb variance inequality,
  Bakry–Émery with anisotropic curvature, Herbst, Caffarelli contraction (091, 093, 101).
- *ErgodicRamseyTheory* (combinatorics): Furstenberg correspondence, Furstenberg–Zimmer structure,
  characteristic factors, norm convergence of multiple averages (145, 154).
- *GeometricMeasureTheory* (analysis): Ambrosio–Kirchheim metric currents and integral fillings;
  existence and regularity of isoperimetric regions in compact manifolds; CMC regularity and
  stability (336, 337, 354).
- *SeveralComplexVariables*, *PositiveCurrentsAndMongeAmpere*, *KahlerManifoldsAndHodgeTheory* (AG):
  bounded domains and bounded holomorphic coordinates; psh exhaustions; Siciak extremal function;
  positive currents on almost complex manifolds and Harvey–Lawson; bisectional curvature
  (087, 338, 342, 359).
- *HyperbolicGroups*, *GroupCohomologyFiniteness*, *GroupVonNeumannAlgebras* (algebra/groups):
  convergence groups and Bowditch boundaries; Poincaré duality groups; L²-Betti numbers of
  CW complexes and the Singer conjecture (305, 315, 320).
- *OperatorKTheory* (analysis): a coarse layer with Roe algebras, coarse K-homology and the coarse
  assembly map (307).
- *MicrolocalSheafTheory* (Annals): sheaves on locally compact spaces, compactly supported
  cohomology, Verdier duality (304).
- Left unowned (one paper each, small): Witt groups of triangulated categories (304), affine maximal
  hypersurfaces (353), poset topology of p-subgroups (310).

## (d) Family-by-family classification

Classification: `elementary`, `needs <roadmaps>` or `frontier (<theory>)`; proof-level roadmaps are named there. "Lean (OAI)" is the scope of `lean/docs/NNN.md` (or code found without a docs page). The last column lists owners of statement-level needs (TC = Tau Ceti code, BK = Birkbeck campaign). Per-need detail is in the JSONL file.

| # | Family | arXiv | Classification (proof-level needs) | Lean (OAI) | Owners of statement-level needs |
|---|---|---|---|---|---|
| 087 | Mahler conjectures; polar-product Gromov width | math.MG | needs ConvexBodies, SymplecticTopology (symplectic route); PositiveCurrentsAndMongeAmpere for the pluripotential route | all three | ConvexBodies, LogConcaveMeasures, Mathlib ConvexBody, SymplecticTopology |
| 088 | Petty projection inequality n>=4; simplex counterexample | math.MG | needs ConvexBodies | both | ConvexBodies |
| 089 | L1 embeddings of planar and bounded-treewidth graphs | math.MG | needs MetricEmbeddings | both | #444/#271 graphs, MetricEmbeddings |
| 090 | Triangular-lattice universal optimality; Coulomb/Riesz energies | math.MG | needs PackingCoveringEnergy (+ interval-arithmetic certificates) | 2 of 4 | PackingCoveringEnergy |
| 091 | Logarithmic and L_p Brunn-Minkowski; B-conjecture | math.MG | needs ConvexBodies, LogConcaveMeasures, ConcentrationAndFunctionalInequalities, OptimalTransport L6 | yes | ConvexBodies, LogConcaveMeasures |
| 092 | Optimal order n log n of covering density | math.MG | needs ConvexBodies, PackingCoveringEnergy | yes | Mathlib ConvexBody, PackingCoveringEnergy |
| 093 | Dimension-free LSI for subgaussian log-concave measures | math.PR | needs ConcentrationAndFunctionalInequalities, LogConcaveMeasures, OptimalTransport L11 | - | ConcentrationAndFunctionalInequalities, LogConcaveMeasures |
| 094 | Subpolynomial dimension reduction in L_p | math.MG | needs MetricEmbeddings | yes | MetricEmbeddings |
| 095 | Hyperbolicity cones without semidefinite lifts | math.OC | needs ConvexAlgebraicGeometry | 1 of 3 | ConvexAlgebraicGeometry |
| 096 | Gaussian propeller bound | math.PR | elementary (Gaussian measure + calculus of variations) | yes | Mathlib Gaussian |
| 097 | Euclidean Steinitz-Bergstrom bound | math.MG | needs LogConcaveMeasures (Gaussian correlation, Gaussian convex bodies) | yes | Mathlib Gaussian |
| 098 | Compact doubling sets with no bi-Lipschitz embedding | math.MG | needs MetricEmbeddings | yes | MetricEmbeddings |
| 099 | Edit distance into ell_1: exp(sqrt(log d log log d)) | math.MG | needs MetricEmbeddings | all three | MetricEmbeddings |
| 100 | Cylinder coverings below the half-area bound | math.MG | elementary | all four | Mathlib ConvexBody |
| 101 | Simplex maximizes the isotropic constant; sharp entropy bound | math.MG | needs ConvexBodies, LogConcaveMeasures, ConcentrationAndFunctionalInequalities, OptimalTransport L5 | - | ConvexBodies, LogConcaveMeasures |
| 143 | Hilbert 16 uniform bound; quintic Lienard | math.DS | frontier (Ilyashenko-Ecalle finiteness, subanalytic geometry); Lienard part needs QualitativeODE | Lienard only | QualitativeODE |
| 144 | Smooth T^3 diffeomorphism with simple Lebesgue spectrum | math.DS | needs ErgodicTheory (spectral theory), SmoothErgodicTheory (smooth realization) | yes | ErgodicTheory, Mathlib ergodic, Mathlib manifolds |
| 145 | Mixing implies mixing of all orders (Rokhlin) | math.DS | needs ErgodicTheory, ErgodicRamseyTheory | yes | ErgodicTheory |
| 146 | Positive metric entropy of the standard map | math.DS | needs EntropyAndThermodynamicFormalism, SmoothErgodicTheory, AreaPreservingMapsAndBilliards | yes | AreaPreservingMapsAndBilliards, EntropyAndThermodynamicFormalism |
| 147 | Near-boundary Birkhoff conjecture for convex billiards | math.DS | frontier (billiard rigidity via caustic foliations and analytic continuation) | - | AreaPreservingMapsAndBilliards |
| 148 | Entropy-rate dimension formula for self-similar measures | math.DS | needs FractalGeometry, EntropyAndThermodynamicFormalism (Shannon entropy calculus) | yes | FractalGeometry, Mathlib Hausdorff |
| 149 | Permanence of weakly reversible mass-action systems | math.DS | elementary (ODE + polytopes + graph combinatorics) | boundedness/persistence | QualitativeODE |
| 150 | Ergodicity and weak mixing of irrational triangular billiards | math.DS | needs ErgodicTheory, AreaPreservingMapsAndBilliards; frontier: cohomological equation for flat geodesic flows | ergodicity | AreaPreservingMapsAndBilliards, ErgodicTheory |
| 151 | C^1 counterexample to Shub's entropy conjecture | math.DS | needs AlgebraicTopology | yes | AlgebraicTopology, Mathlib manifolds, Mathlib top. entropy |
| 152 | Zero-entropy system without smooth positive-volume model | math.DS | needs EntropyAndThermodynamicFormalism, ErgodicTheory, SmoothErgodicTheory | finite-entropy version | EntropyAndThermodynamicFormalism, ErgodicTheory |
| 153 | Arithmetic classification of singular Bernoulli convolutions | math.DS | needs FractalGeometry (+ algebraic number theory) | - | FractalGeometry, Mathlib number fields |
| 154 | Pointwise multiple ergodic averages for mixing transformations | math.DS | needs ErgodicTheory, ErgodicRamseyTheory | - | ErgodicTheory |
| 304 | Hilbert-Smith conjecture in all dimensions | math.GT | frontier (sheaf-theoretic Witt-group obstruction); needs TransformationGroups, MicrolocalSheafTheory (Verdier duality) | - | TransformationGroups |
| 305 | 4D disc embedding fails; PD4 group without manifold model | math.GT | frontier (Freedman-Quinn 4-manifold topology); needs FourManifoldTopology, GroupCohomologyFiniteness, AlexandrovAndCATSpaces | - | FourManifoldTopology, GroupCohomologyFiniteness |
| 306 | Purely cosmetic surgery conjecture | math.GT | frontier (instanton Floer theory, PU(2) monopoles); statement covered by GeometricTopology L5 | - | GeometricTopology L5 |
| 307 | Coarse Novikov and maximal coarse assembly fail | math.KT | needs OperatorKTheory (Roe-algebra layer), MetricEmbeddings (expanders) | reduced version | OperatorKTheory |
| 308 | Finite Smith-Toda complexes at every height | math.AT | frontier (chromatic constructions) | - | StableHomotopyTheory |
| 309 | Kervaire invariant problem at p=3 | math.AT | frontier (Adams/Adams-Novikov computations, EO theories) | - | StableHomotopyTheory |
| 310 | Quillen conjecture in rational homology | math.GR | needs CFSGStatement, ChevalleyGroups (#447), poset topology | - | poset topology (gap) |
| 311 | Chai and Hovey-Strickland conjectures | math.AT | frontier (Lubin-Tate + Fargues-Fontaine + tt-geometry) | - | ChromaticHomotopyTheory |
| 312 | Grothendieck homotopy hypothesis | math.AT | needs ModelCategoriesAndStrictHigherCategories | elementary-expansion theorem | ModelCategoriesAndStrictHigherCategories |
| 313 | Finite generation of homotopy of the K(n)-local sphere | math.AT | frontier (Devinatz-Hopkins + Fargues-Fontaine geometry) | - | ChromaticHomotopyTheory |
| 314 | Chromatic fixed-point loss = cyclic length | math.AT | frontier (equivariant chromatic homotopy) | - | ChromaticHomotopyTheory |
| 315 | Four-dimensional Singer conjecture | math.GT | needs GroupVonNeumannAlgebras (L2-Betti layer), HyperbolicGroups, GroupCohomologyFiniteness, ClassifyingSpaces | - | GroupCohomologyFiniteness, GroupVonNeumannAlgebras |
| 316 | Curtis conjecture (stable Hurewicz image at 2) | math.AT | frontier (Adams spectral sequence, Lambda algebra) | - | StableHomotopyTheory |
| 317 | Thomason model structures on strict n-categories | math.AT | needs ModelCategoriesAndStrictHigherCategories | yes | ModelCategoriesAndStrictHigherCategories |
| 318 | Chromatic splitting: filtrations and counterexamples | math.AT | frontier | - | ChromaticHomotopyTheory |
| 319 | Hahn-Wilson conjecture fails at height 2 | math.AT | frontier | - | ChromaticHomotopyTheory, StableHomotopyTheory |
| 320 | Homotopy-equivalent non-homeomorphic aspherical 4-manifolds | math.GT | frontier (4D surgery + Davis reflection); needs FourManifoldTopology, HyperbolicGroups, AlexandrovAndCATSpaces | - | FourManifoldTopology, HyperbolicGroups |
| 321 | Counterexample to Wall's D(2) problem | math.AT | needs AlgebraicTopology, ClassifyingSpaces | - | AlgebraicTopology |
| 333 | Closed surfaces isometrically immerse in R^4 | math.DG | needs IsometricEmbeddings | yes | Mathlib manifolds, TC Riemannian/curvature |
| 334 | Smooth surface metric with no local isometric immersion in R^3 | math.DG | needs RiemannianGeometry, IsometricEmbeddings | yes | TC Riemannian/curvature |
| 335 | Gromov integral scalar-curvature bound; PSC rational inessentiality | math.DG | frontier (torical-band/mu-bubble descent); needs BoundedCohomology, MinimalSubmanifolds | - | BoundedCohomology, ClassifyingSpaces #437, TC Riemannian/curvature |
| 336 | Spectral scalar curvature, Urysohn width, macroscopic dimension | math.DG | frontier (mu-bubbles); needs MinimalSubmanifolds, GeometricMeasureTheory | - | MinimalSubmanifolds, SpectralGeometry |
| 337 | Cartan-Hadamard isoperimetry; sharp fillings in CAT(0) | math.DG | needs GeometricMeasureTheory, AlexandrovAndCATSpaces, RiemannianGeometry | CAT(0) fillings | AlexandrovAndCATSpaces, GeometricMeasureTheory |
| 338 | Yau uniformization conjecture | math.DG | frontier (Kahler-Ricci flow on noncompact manifolds); needs KahlerManifoldsAndHodgeTheory, SeveralComplexVariables, GeometricFlows | - | ComplexManifolds #279, KahlerManifoldsAndHodgeTheory |
| 339 | Katok entropy rigidity in negative curvature | math.DG | frontier; needs SmoothErgodicTheory, GlobalRiemannianGeometry | - | EntropyAndThermodynamicFormalism, TC Riemannian/curvature |
| 340 | Counterexample to the nearby Lagrangian conjecture | math.SG | frontier (stable parametrized h-cobordism); statement needs SymplecticTopology | partial code (Geometry/NearbyLagrangian), no main theorem | DGFloer #655, SymplecticTopology |
| 341 | Donaldson hypersymplectic deformation conjecture | math.DG | frontier (hypersymplectic flow); needs GeometricFlows, EllipticOperatorsOnManifolds, KahlerGeometry | - | DifferentialGeometry, KahlerGeometry |
| 342 | Tamed-to-compatible on 4-manifolds | math.SG | needs PositiveCurrentsAndMongeAmpere, EllipticOperatorsOnManifolds (statement from Tau Ceti symplectic code) | yes | DifferentialGeometry, TauCeti Geometry/Symplectic/Manifold |
| 343 | Symplectic ball packing in dimension >= 6 | math.SG | needs SymplecticTopology, KahlerGeometry | yes | SymplecticTopology |
| 344 | Metric Blaschke conjecture | math.DG | needs RiemannianGeometry, GlobalRiemannianGeometry (frontier volume comparison) | - | GlobalRiemannianGeometry, RiemannianGeometry |
| 345 | Infinitely many closed geodesics on spheres and 3-manifolds | math.DG | frontier (equivariant loop-space Morse theory, resonance) | - | TC Riemannian/curvature |
| 346 | Singular sets of stationary integral varifolds | math.DG | frontier (Almgren-De Lellis-Spadaro regularity) | - | Mathlib Hausdorff, MinimalSubmanifolds |
| 347 | Counterexamples to stable-Morse and strong Arnold bounds | math.SG | needs SymplecticTopology, HamiltonianSystems (#480); nondegenerate examples also KahlerManifoldsAndHodgeTheory, DGFloer | quadric example | HamiltonianSystems #480, SymplecticTopology |
| 348 | Einstein 4-manifolds of nonnegative curvature; L2 gap | math.DG | needs RiemannianGeometry, GlobalRiemannianGeometry, EllipticOperatorsOnManifolds | positive sectional | RiemannianGeometry |
| 349 | Solomon-Yau least-volume theorem | math.DG | frontier (min-max theory); needs MinimalSubmanifolds, GeometricMeasureTheory | - | RiemannianGeometry |
| 350 | Yau nodal bounds on surfaces; counterexamples in dims 3-5 | math.DG | needs SpectralGeometry | all three | Mathlib Hausdorff, SpectralGeometry |
| 351 | Ricci flow extension under bounded scalar curvature (dim 4) | math.DG | frontier (Ricci flow singularity analysis) | - | GeometricFlows |
| 352 | Finite-time singularity of Calabi flow on CP^10 | math.DG | needs KahlerGeometry, GeometricFlows (+ validated ODE numerics) | - | GeometricFlows |
| 353 | Affine Bernstein in dimensions 3-9; dimension-10 counterexample | math.DG | needs OptimalTransport L6, ConvexBodies | Euclidean-complete case | affine maximal (gap) |
| 354 | Isoperimetric profile of the cubic 3-torus | math.DG | needs GeometricMeasureTheory (isoperimetric regions, CMC regularity) | yes | GeometricMeasureTheory |
| 355 | Unique tangent flows at first surface MCF singularity | math.DG | frontier (Bamler-Kleiner multiplicity one, Lojasiewicz) | - | GeometricFlows |
| 356 | Gigli's characterization of Alexandrov curvature | math.DG | needs OptimalTransport L14, AlexandrovAndCATSpaces; frontier: second-order RCD calculus | weak-Hessian theorem | AlexandrovAndCATSpaces, OptimalTransport L14 |
| 357 | Bi-Lipschitz charts at regular noncollapsed RCD points | math.DG | frontier (Cheeger-Colding theory for RCD); needs RicciLimitSpaces, OptimalTransport L14 | code present (Geometry/RCD, Analysis/RCDHeat), not in docs | Mathlib GH, OptimalTransport L14, RicciLimitSpaces |
| 358 | 3-manifold with no conjugate points but no NPC metric | math.DG | needs RiemannianGeometry, GeometricTopology L8, AlexandrovAndCATSpaces | yes | RiemannianGeometry, TC Riemannian/curvature |
| 359 | Negatively pinched Kahler domain without bounded coordinates | math.DG | needs KahlerManifoldsAndHodgeTheory, SeveralComplexVariables | pinched example | KahlerManifoldsAndHodgeTheory, SeveralComplexVariables |
| 360 | Weak MTW gives convex injectivity domains and Holder transport | math.DG | needs OptimalTransport L6D-L7, RiemannianGeometry | both | OptimalTransport L6D-7 |
| 361 | Integer-degree harmonic dimension comparison fails | math.DG | needs GlobalRiemannianGeometry, SpectralGeometry; tangent cones from RicciLimitSpaces | dimension-16 example | GlobalRiemannianGeometry, SpectralGeometry |

## (e) Reusable OAI Lean infrastructure worth porting

Paths under `lean/OAI/` (Apache-2.0; built on Mathlib `d13f23b` and Tau Ceti `3bed7e3`). The code
is written per paper with ad hoc definitions; listed are the parts whose definitions and general
lemmas match a roadmap above. Directories that package cited theorems as `Published…Input` or
`…Obligation` structures thereby inventory the classical results a roadmap must supply.

| OAI path (files, lines) | Reusable content | Target roadmap |
|---|---|---|
| `Analysis/RCDHeat` (78) + `Geometry/RCD` (2889, 227k) + `Geometry/WeakHessian` (542, 66k) | honest `NoncollapsedRCD` (CD(K,N) via Rényi entropy + quadratic Cheeger energy), test plans, weak upper gradients, Cheeger energy, Laplacian, weak Hessian, heat flow and EVI, pointed rescalings, tangent cones, regular points; unconditional proof of family 357 | OptimalTransport L14; RicciLimitSpaces |
| `Geometry/CAT0Fillings` (330, 50k), `Geometry/IntegralFillings` (112) | metric currents as multilinear functionals, mass, integer-rectifiable and integral currents, `IsCAT0`, slicing, Euclidean BV/Sobolev, sharp filling constant | GeometricMeasureTheory; AlexandrovAndCATSpaces |
| `Geometry/Perimeter` (176, 34k), `Geometry/CubicTorus` (162, 140k) | locally finite perimeter, perimeter minimizers, blow-ups, C¹/C^{1,1} boundary regularity, CMC equations, flux and coarea identities | GeometricMeasureTheory (isoperimetric layer) |
| `Geometry/TamingCompatibility` (582, 83k) | chart-level 2-forms, Hodge star, Λ⁺ projection on 4-manifolds, heat smoothing, positive-current concentration, almost complex structures | EllipticOperatorsOnManifolds; PositiveCurrentsAndMongeAmpere |
| `Geometry/NodalSets` (1068, 75k), `Analysis/NodalLength` (59, 32k), `Geometry/SmoothYau` (436) | Laplace eigenfunctions on surfaces, isothermal charts, Hausdorff measure of zero sets, explicit eigenfunction families | SpectralGeometry |
| `Geometry/EinsteinFour` (407, 208k) | curvature arrays, Weyl blocks W±, Bianchi identities in coordinates, CP² geometry; `…Input` structures naming Gursky–LeBrun, Derdzinski, Hatcher Euler-characteristic facts | RiemannianGeometry; GlobalRiemannianGeometry |
| `Geometry/ConjugatePoints` (19, 25k) | Jacobi fields, conjugate points, index form, nonpositive-curvature predicates | RiemannianGeometry |
| `Geometry/WeakMTW` (210), `Analysis/BiholderTransport` (645, 74k) | Riemannian geodesic existence/uniqueness in coordinates, cut points, semiconcave c-convex potentials, MTW tensor | OptimalTransport L6D–L7 |
| `Geometry/SurfaceImmersion` (2050, 173k), `Geometry/IsometricImmersion` (447) | Nash-type correction with finite derivative loss; relative immersions via sphere-eversion's local h-principle; Gauss and Darboux equations | IsometricEmbeddings |
| `Geometry/BallPacking` (207, 107k), `Geometry/PolarProducts` (46), `Geometry/Symplectic` (30), `Geometry/Arnold` (36) | explicit symplectic embeddings and Hamiltonian flows in ℝ²ⁿ, toric domains, relative Moser, cup-length bounds | SymplecticTopology |
| `Geometry/SingularHomology` (81), `AlgebraicTopology/IntegralHomology` (31) | barycentric subdivision, simplicial Mayer–Vietoris, homology of finite covers, induced maps and their eigenvalues, Thom-space pieces | AlgebraicTopology (Stages 3, 5) |
| `Dynamics/StandardMap` (274), `Dynamics/SmoothObstruction` (53), `Dynamics/MultipleMixing` (13, 28k), `Dynamics/ThreeTorus` (37), `Dynamics/TriangleBilliards` (39) | partition and KS entropy, Bernoulli components, Lyapunov-exponent predicates, measurable conjugacy modulo null sets, k-fold mixing, Koopman spectral constructions, polygon billiard flow off a null set | EntropyAndThermodynamicFormalism; ErgodicTheory; SmoothErgodicTheory; AreaPreservingMapsAndBilliards |
| `MeasureTheory/SelfSimilar` (64) | IFS systems, laws, Shannon entropy of laws, lower Hausdorff dimension of measures | FractalGeometry |
| `Topology/CoarseAssembly` (334, 34k) | Roe algebras, K₁ and controlled K-theory, coarse K-homology for graph unions | OperatorKTheory (coarse layer) |
| `CategoryTheory/Thomason` (225, 160k), `CategoryTheory/Globular` (58) | strict ω-categories, orientals, Steiner complexes, Gray cylinders, Street nerve, Ex²/Sd², coherators, globular homotopy groups | ModelCategoriesAndStrictHigherCategories |
| `Analysis/Mahler` (243), `Geometry/ProjectionBodies` (33), `Geometry/LogVolume`, `Geometry/Convex/GeneralMahler`, `Geometry/LatticeCovering`, `Geometry/TranslativeCovering` | Hanner polytopes, polar duality, volume product, projection-body volume, Wulff and logarithmic combinations, lattice covering density | ConvexBodies; PackingCoveringEnergy |
| `Analysis/Triangular` (276, 69k), `Analysis/PlanarPacking` (562, 916k, mostly certificate data) | Gaussian Fourier minorants, Cohn–Elkies certificates (interval arithmetic via `leancert`) | PackingCoveringEnergy |
| `Combinatorics/PlanarL1`, `Combinatorics/TreewidthL1`, `Combinatorics/EditDistance`, `Analysis/LpDimension`, `Geometry/DoublingHilbert` | distortion, L₁ embeddings, tree decompositions, doubling subsets of Hilbert space | MetricEmbeddings |
| `Analysis/HyperbolicCones` (101) | hyperbolic polynomials, normalized pencils, spectral splitting | ConvexAlgebraicGeometry |
| `Analysis/LienardCycles`, `Analysis/MassAction` | planar return maps, Liénard systems, mass-action networks | QualitativeODE |
| `Geometry/Kahler` (119), `Geometry/KahlerSplitting` (46) | Kähler metrics from potentials, curvature tensors in coordinates, psh base potentials | KahlerManifoldsAndHodgeTheory; SeveralComplexVariables |

Main caveats: the RCD code must be reconciled with OptimalTransport L14's pinned CD/CD*
conventions; TamingCompatibility's chart-level forms duplicate DifferentialGeometry L0–L1 and should
be ported after those land; EinsteinFour and NodalSets work in coordinates rather than Tau Ceti's
tensor API; CoarseAssembly and Thomason keep some cited results as `Published…Input` hypotheses at
intermediate stages.

**External dependencies.** *sphere-eversion*: local h-principle for open ample relations
(`SphereEversion.Local.HPrinciple`), used once (`Geometry/SurfaceImmersion/Whitney/RelativeImmersionHPrinciple.lean`);
IsometricEmbeddings should port it. *schoenflies-lean*: the Jordan–Schoenflies theorem, used by
`Probability/SLE` and `Analysis/CircleDomains` (not this share); PlanarTopology (#271) should consume
or port it. *gromov* (Aaron1011): Gromov's polynomial-growth theorem, used by
`GroupTheory/PolycyclicRecognition`; relevant to the algebra share's AmenableGroupsAndGrowth and to
the growth step in family 335.
