# OpenAI release, analysis share: prerequisites and proposed roadmaps

Scope: the 62 families of `openai_families.json` whose subject is Real and complex analysis (16),
Functional analysis (11), Operator algebras (19) or Partial differential equations (16).
Needs file: `needs_openai_analysis.jsonl` (185 lines, one per need, `"goal":"OpenAI"`).
Supply checked against Mathlib `6b7abb3c`, Tau Ceti code `a91d3aafa`, `upstream/main`, the open PR
heads `upstream-pr/<N>` (grepped only in each PR's own directories), the Birkbeck campaign and the
explorer's `opportunities.json`. Working files (PDF text, comparator copies, scripts):
`/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/agent-oai-analysis/`.

## (a) Statistics

| subject | families | manuscripts | flagged `formalized` | families with `lean/docs/NNN.md` |
| --- | --- | --- | --- | --- |
| Real and complex analysis | 16 | 26 | 7 | 9 |
| Operator algebras | 19 | 31 | 6 | 14 |
| Functional analysis | 11 | 19 | 16 | 10 |
| PDE | 16 | 29 | 3 | 11 |
| **total** | **62** | **105** | **32** | **44** |

- The `formalized` flag (from `formalization.yaml`) undercounts Lean work: 44 families have a
  `lean/docs` scope page and comparator statements, and the OAI library holds large developments
  for unflagged families (e.g. `Analysis/KadisonKastler` 181k lines, `Analysis/CircleDomains` 211k,
  `Analysis/LipschitzHilbert` 186k, `MathematicalPhysics/DefocusingNLS` 191k,
  `MathematicalPhysics/Boltzmann` 160k). The 18 families with no Lean at all are the restriction /
  Kakeya / Bochner–Riesz / local-smoothing / Schrödinger cluster (074, 075, 077–080, 086), 285,
  286, 300–302, 332, 364, 366, 368, 375, 377: a fair proxy for "prerequisites far from Mathlib".
- PDFs read (introduction, conventions, reference list): 56 manuscripts covering 54 families;
  the other 8 families were classified from abstracts and their Lean comparator statements.
- Classification: **3 elementary** (076, 084, 329), **39 needs** (3 of them met by existing
  supply alone: 373, 374 by OptimalTransport, 376 by IncompressibleFlows #237), **20 frontier**.
- Coverage of the 185 needs: gap 92, oai-lean 41, mathlib 17, tauceti-code 13, tauceti-roadmap 10,
  open-pr 8, birkbeck-campaign 4. The analysis side of Tau Ceti (PDE, Sobolev, conformal mapping,
  semigroups, optimal transport) is strong; operator algebras, Banach-space geometry, harmonic
  analysis beyond PDE Lane B, geometric measure theory and kinetic/dispersive PDE have no owner.

## (b) Prerequisite clusters and coverage

Owner category is that of the prerequisite theory. "S" = needed to state, "P" = needed to prove.

| # | cluster | coverage today | families | arXiv | S/P |
| --- | --- | --- | --- | --- | --- |
| 1 | Sobolev spaces on domains, elliptic regularity, potential theory | Mathlib (Bessel `MemSobolev`, GNS inequality, Lax–Milgram); TauCeti code (`Wkp`, Rellich for `W^{1,p}_0`, Morrey, De Giorgi `n≥3`, Perron, Green kernels, Hopf); PDE (main); PR #93 adds ABP and Krylov–Safonov | 085, 365 (Euclidean part), 366, 367, 369, 370, 372 | math.AP | S+P, covered (trace/extension pending in Lane A) |
| 2 | Maximal function, interpolation, Calderón–Zygmund, BMO | TauCeti code (maximal inequality, Marcinkiewicz); PDE Lane B owns Riesz–Thorin, CZ, Mihlin, BMO; `carleson` project (external) | 075, 081–086 | math.CA | P, partial |
| 3 | Littlewood–Paley blocks, Bernstein, square function, Besov, paraproducts | PR #237 IncompressibleFlows Layer 10 | 079, 083 | math.CA | P, open PR |
| 4 | Classical harmonic analysis beyond Lane B (Lorentz spaces, Stein interpolation, `H^1`, `A_p`, Fourier-series a.e. convergence, variation norms, Calderón commutator) | gap; `carleson` has Lorentz spaces, real interpolation, Carleson–Hunt | 075, 078, 081, 083, 085 | math.CA | P |
| 5 | Time–frequency analysis, multilinear singular integrals | gap; `carleson` has tiles, forests, antichains | 075, 082, 083, 086 | math.CA | S+P |
| 6 | Oscillatory integrals, Fourier restriction, Bochner–Riesz, decoupling, local smoothing, Schrödinger maximal | gap (Birkbeck ExponentialSums: 1-D stationary phase for sums) | 073, 077–080 | math.CA | S+P |
| 7 | Fractal geometry: Frostman, energies, projections, Kakeya, Furstenberg, polynomial method | gap (Mathlib `dimH`, `hausdorffMeasure`; RealAlgebraicGeometry has CAD only; no Borsuk–Ulam) | 073, 074, 077, 078 | math.CA | S+P (frontier inputs) |
| 8 | Geometric measure theory: rectifiability, area/coarea, BV and perimeter, minimal cones, uniform rectifiability | gap (BV only in 1-D) | 071, 081, 085, 366, 367, 375 | math.CA | P |
| 9 | Conformal mapping | TauCeti code + ConformalMapping (main): RMT, Montel, Hurwitz, Carathéodory, Schwarz–Pick, reflection, arc removability | 071, 072, 325, 369 | math.CV | P, covered |
| 10 | Univalent functions, quasiconformal maps, extremal length, circle-domain uniformization | gap | 071, 072, 325, 368 | math.CV | S+P |
| 11 | Hilbert-space operator theory (spectral theorem, Borel calculus, PVMs, operator ideals, majorization) | Mathlib CFC; PR #126 OperatorTheory; TauCeti `LinearPMap`, Stone | 082, 287, 293, 325 | math.FA | P, open PR |
| 12 | Nonselfadjoint operator theory: dilations, spectral sets, numerical range, invariant subspaces, Pick interpolation | gap | 288, 293, 325, 369 | math.FA | S+P |
| 13 | C*-algebra basics | Mathlib (`CStarAlgebra`, CFC, GNS, positive and completely positive maps, `CStarMatrix`, multipliers, WOT) | all of OA | math.OA | S, covered |
| 14 | von Neumann algebras: topologies, bicommutant, traces, type theory, II₁ factors, ultraproducts, Γ, derivations, bounded cohomology | gap (Mathlib `VonNeumannAlgebra` is a bare bicommutant structure; Birkbeck AutomorphicSpectralTheory has direct integrals) | 286–289, 293, 295, 296, 300 | math.OA | S+P |
| 15 | Modular theory, type III, continuous core | gap | 289, 290 | math.OA | S+P |
| 16 | Nuclear C*-algebras: CB maps, tensor products, nuclearity/exactness, group C*-algebras, crossed products, AF/Cuntz/Jiang–Su, property (T) | gap (OAI has ad hoc versions) | 285, 288, 291, 292, 294, 297, 302 | math.OA | S+P |
| 17 | Cuntz semigroup, (quasi)traces, comparison, pure infiniteness, central sequences, `Z`/`O_∞` absorption | gap | 291, 294, 299, 301–303 | math.OA | S+P |
| 18 | Operator K-theory, K-homology, assembly map | gap (PR #437 ClassifyingSpaces for `BG`; TauCeti Fredholm index) | 285, 301, 302 | math.KT | S+P |
| 19 | Free probability at von Neumann level, free group factors, free entropy | partial: PR #397 RandomMatrices M6 (C*-level freeness, free products with state, R-transform) | 287, 288, 298 | math.OA | S+P |
| 20 | Banach-space geometry (linear) | gap (Mathlib `UniformConvexSpace`, `GeneralSchauderBasis`, Mazur–Ulam; no reflexivity predicate) | 322, 323, 326–331 | math.FA | S+P |
| 21 | Nonlinear Banach geometry, metric embeddings | gap (no Kirszbraun, no Lipschitz-free spaces) | 324, 327, 330–332 | math.FA | S+P |
| 22 | Viscosity solutions, fully nonlinear, semilinear Liouville theorems, Allen–Cahn, free boundaries | gap (PR #93 explicitly excludes viscosity solutions) | 367, 370, 375, 377 | math.AP | P |
| 23 | Calculus of variations and elasticity | gap (PDE roadmap is scalar) | 366, 368, 372, 375 | math.AP | S+P |
| 24 | Dispersive equations | gap (Strichartz is a PDE "stretch goal", not a milestone) | 079, 080, 362, 371 | math.AP | S+P |
| 25 | Kinetic equations | gap (PR #237 owns DiPerna–Lions transport; OptimalTransport cites Vlasov mean-field prior art) | 362–364 | math.AP | S+P |
| 26 | Incompressible fluids | PR #237 | 376 | math.AP | S, open PR |
| 27 | Optimal transport | TauCeti code (`OptimalTransport/Brenier`, `MultiMarginal`, Wasserstein) + OptimalTransport (main) | 373, 374 | math.OC | S+P, covered |
| 28 | Elliptic theory on compact manifolds | gap (DifferentialGeometry stops at classical Laplace–Beltrami; `rellich-kondrachov` external) | 365 | math.AP | S+P |
| 29 | Inverse boundary problems | gap | 365, 372 | math.AP | S+P |
| 30 | Outside analysis (other shares) | gap: forcing and measurable cardinals (323), mean dimension (302), graphical small cancellation (285), Marcus–Spielman–Srivastava paving (300), expanders (330), Borsuk–Ulam (074), complex cobordism (302) | — | math.LO, math.DS, math.GR, math.CO, math.AT | P |

## (c) Proposed roadmaps

Twenty-one gaps, grouped by owning category. Sizes: M ≈ one graduate topic, L ≈ a graduate course,
XL ≈ more than one course. Every proposal cites the existing Tau Ceti roadmaps it consumes; none
duplicates PDE Lane B, PR #237 Layer 10, PR #126 or PR #397.

### math.CA

**1. RealHarmonicAnalysis** (math.CA) — L.
*Scope.* This roadmap develops the real-variable harmonic analysis on `ℝⁿ` and `𝕋ⁿ` that sits
above the PDE roadmap's Lane B (maximal function, Marcinkiewicz, Riesz–Thorin, Calderón–Zygmund
decomposition and operators, Mihlin, BMO) and beside IncompressibleFlows' Littlewood–Paley layer:
the function spaces, interpolation methods and classical convergence theorems that every modern
estimate uses. Boundary: no modulation-invariant operators (TimeFrequencyAnalysis) and no
curvature (FourierRestriction).
*Objects.* Decreasing rearrangement, Lorentz spaces `L^{p,q}`, Orlicz `L log L`; Stein's interpolation
for analytic families; atomic `H^1` and `H^1`–BMO duality; `A_p` weights; sparse operators;
conjugate function and Hilbert transform on `𝕋` and `ℝ`; Dirichlet, Fejér, Poisson kernels;
lacunary and spherical maximal operators; variation and jump norms; Calderón commutators;
Calderón–Zygmund operators with respect to a general Radon measure.
*Headline theorems.* M. Riesz `L^p` boundedness of the conjugate function; Fejér and Lebesgue
summability; Kolmogorov's divergent `L^1` Fourier series; Fefferman `H^1`–BMO duality;
Muckenhoupt and Coifman–Fefferman weighted theorems; Lerner sparse domination; Stein's spherical
maximal theorem (`n ≥ 3`); Lépingle's inequality; Calderón's first commutator; Kinnunen's
`W^{1,p}` boundedness of the maximal function.
*Prerequisites.* PDE (Lane B), IncompressibleFlows #237 (Layer 10), Mathlib Fourier analysis.
*Families.* 075, 076, 078, 081, 083, 085 (and indirectly all of 073–086).
*Formalizability.* High: `fpvandoorn/carleson` already has Lorentz spaces, real interpolation and
rearrangements in Lean (Apache-2.0); coordinate with van Doorn–Thiele before porting.

**2. TimeFrequencyAnalysis** (math.CA) — L.
*Scope.* Operators invariant under modulation as well as translation and dilation, analysed by
phase-space decompositions into tiles. The roadmap builds tiles, trees, forests and the
size/density lemmas in the doubling-metric generality of the Carleson project, and applies them
to Carleson's operator, the bilinear Hilbert transform and directional Hilbert transforms.
*Objects.* Grids and tile structures, trees, forests, antichains; the Carleson operator;
bilinear and triangular Hilbert transforms; multilinear singular forms; Hilbert transforms along
vector fields.
*Headline theorems.* Carleson–Hunt (a.e. convergence of Fourier series in `L^p`, `1<p<∞`),
metric Carleson theorem; Lacey–Thiele boundedness of the bilinear Hilbert transform; Coifman–Meyer
multilinear multipliers; Lacey–Li `L^2` bound for Hilbert transforms along `C^{1+ε}` vector fields;
Bateman–Thiele one-variable vector fields; Kovač's twisted paraproduct.
*Prerequisites.* RealHarmonicAnalysis.
*Families.* 075, 082, 083, 086.
*Formalizability.* Very high for Carleson–Hunt (already in Lean); BHT is a natural follow-on on the
same tile machinery.

**3. FourierRestriction** (math.CA) — XL.
*Scope.* Fourier analysis with curvature: oscillatory integrals, Fourier transforms of surface
measures, and the restriction, Bochner–Riesz, local-smoothing and Schrödinger-maximal problems,
through the wave-packet, multilinear and decoupling methods. Geometric inputs (Kakeya,
projections, Furstenberg sets) are consumed from KakeyaAndProjections.
*Objects.* Non-stationary and stationary phase in `ℝⁿ`; surface measure of compact hypersurfaces
with nonvanishing Gaussian curvature and its Fourier decay; extension operators; Knapp examples;
Bochner–Riesz means; half-wave and Schrödinger propagators; wave packets; multilinear extension;
`ℓ^2` decoupling norms.
*Headline theorems.* Stein–Tomas; Fefferman–Stein and Zygmund planar restriction; Carleson–Sjölin
and Córdoba (planar Bochner–Riesz); Fefferman's ball-multiplier theorem; Tao's
Bochner–Riesz⇒restriction; Bennett–Carbery–Tao multilinear restriction; Bourgain–Guth reduction;
Guth's `ℝ³` restriction via polynomial partitioning; Bourgain–Demeter decoupling (paraboloid,
cone); local smoothing from decoupling; Dahlberg–Kenig necessity and Du–Guth–Li planar
Schrödinger maximal estimate.
*Prerequisites.* RealHarmonicAnalysis, KakeyaAndProjections, DifferentialGeometry (hypersurfaces),
RealAlgebraicGeometry (main), DispersiveEquations (propagators, Strichartz).
*Families.* 073, 077, 078, 079, 080. The families' own theorems are frontier; this roadmap is the
textbook layer below them (Mattila, Demeter, Stein).
*Formalizability.* Medium: long but elementary estimates; decoupling induction-on-scales is the
hardest milestone.

**4. KakeyaAndProjections** (math.CA; secondary math.MG, math.CO) — XL.
*Scope.* The geometric measure theory of fractal sets in Euclidean space: Frostman measures,
energies and Fourier dimension; orthogonal and radial projections; Kakeya and Furstenberg sets;
the Falconer distance problem; and the polynomial method used to bound incidences of tubes.
*Objects.* Hausdorff content, Frostman measures, `s`-energies, capacity, Fourier dimension,
`δ`-discretized sets and tubes, Kakeya sets and the Kakeya maximal function, Furstenberg
`(s,t)`-sets, distance sets, polynomial partitions.
*Headline theorems.* Frostman's lemma; Marstrand projection theorem and Kaufman's bound;
Bourgain's discretized projection theorem; Mattila's integral and the Wolff/Erdoğan Falconer
bounds; Davies (planar Kakeya sets have dimension 2); Córdoba's planar Kakeya maximal bound;
Wolff's hairbrush `(n+2)/2`; Guth's endpoint multilinear Kakeya; Wolff's Furstenberg bound;
polynomial ham sandwich and Guth–Katz partitioning, with the Milnor–Thom/Warren component bound.
*Prerequisites.* Mathlib Hausdorff measure, RealAlgebraicGeometry (main); Borsuk–Ulam (no owner:
AlgebraicTopology share).
*Families.* 073, 074, 077, 078 (their headline inputs, Ren–Wang Furstenberg and Wang–Zahl Kakeya,
remain frontier).
*Formalizability.* Medium–high; OAI's `MeasureTheory/Falconer` (191k lines) claims a Lean proof of
the Ren–Wang input and is the porting reference.

**5. GeometricMeasureTheory** (math.CA; secondary math.AP, math.DG) — XL.
*Scope.* Rectifiability and functions of bounded variation in `ℝⁿ`, with the variational and
quantitative consequences analysts use: area and coarea formulas, sets of finite perimeter,
monotonicity and dimension reduction for minimizers, and uniform rectifiability of
Ahlfors-regular sets.
*Objects.* Lipschitz images, rectifiable sets and measures, approximate tangent planes, densities;
`BV`, `SBV`, perimeter, reduced boundary; Ahlfors–David regular measures, β-numbers, uniform
rectifiability; area-minimizing boundaries, minimal cones.
*Headline theorems.* Area and coarea formulas; Besicovitch–Federer structure (statement and the
rectifiable half); De Giorgi structure theorem and Gauss–Green for finite perimeter sets;
isoperimetric inequality; Ambrosio SBV compactness and De Giorgi–Carriero–Leaci existence for
Mumford–Shah; De Giorgi `ε`-regularity for minimizing boundaries; Simons-cone minimality
(Bombieri–De Giorgi–Giusti); Federer dimension reduction; Bernstein's theorem in `ℝ^{n≤8}`;
David–Semmes characterizations and Jones's traveling-salesman theorem.
*Prerequisites.* Mathlib measure theory; TauCeti Sobolev; DifferentialGeometry for smooth
hypersurfaces.
*Families.* 071, 081, 085, 366, 367, 375 (and 368).
*Formalizability.* Medium; coordinate with the geometry share (OAI has `Geometry/Varifold`,
`Perimeter`, `StableBernstein`).

### math.CV

**6. UnivalentFunctionsAndQuasiconformalMaps** (math.CV) — L.
*Scope.* The geometric function theory beyond the Riemann mapping theorem: the coefficient and
distortion theory of univalent functions, integral means, quasiconformal maps and the measurable
Riemann mapping theorem, extremal length, removability, and uniformization of multiply connected
domains by circle domains.
*Objects.* Classes `S`, `Σ`; Löwner chains; integral-means spectra; Bloch space; quasiconformal maps
(analytic definition via `W^{1,2}_loc` and the Beltrami equation); Beurling transform; modulus of
curve families; conformally removable sets; circle domains; circle packings.
*Headline theorems.* Area theorem, Bieberbach `|a₂| ≤ 2`, Koebe one-quarter, growth and distortion
theorems, Grunsky inequalities; Löwner's `|a₃| ≤ 3`; Pommerenke/Makarov integral-means bounds;
Kellogg–Warschawski; Ahlfors–Bers measurable Riemann mapping theorem; Koebe's uniformization of
finitely connected domains by circle domains; Koebe–Andreev–Thurston.
*Prerequisites.* ConformalMapping (main), PDE Lane A, RealHarmonicAnalysis (Beurling transform as a
CZ operator).
*Families.* 071, 072, 325, 368 (369 uses its boundary theory).
*Formalizability.* High: Tau Ceti's conformal library is mature; OAI's `IntegralMeans` and
`CircleDomains` are porting references.

### math.OA and math.KT

**7. VonNeumannAlgebras** (math.OA) — XL.
*Scope.* The structure theory of von Neumann algebras up to type II₁ classification tools:
operator topologies, the bicommutant and density theorems, normal functionals, projections and
type decomposition, traces, factors, the hyperfinite factor, tensor products and ultraproducts, and
the automatic-continuity and cohomology results that recur in perturbation theory.
*Objects.* SOT/WOT/σ-weak/σ-strong topologies; predual and normal states; Murray–von Neumann
comparison; types I/II/III, center-valued trace; tracial von Neumann algebras and `L^2(M,τ)`;
trace-preserving conditional expectations; group von Neumann algebras `L(G)` and twisted versions;
amplifications and fundamental group; MASAs; tracial ultraproducts; property Γ; injectivity;
bounded Hochschild cohomology; Jones basic construction.
*Headline theorems.* Bicommutant theorem; Kaplansky density; Sakai's characterization of W*-algebras;
type decomposition; existence and uniqueness of the center-valued trace; ICC ⇒ factor; uniqueness of
the hyperfinite II₁ factor (Murray–von Neumann); Kadison–Sakai (derivations inner); Ringrose
automatic continuity; Kadison–Ringrose vanishing for hyperfinite algebras; Christensen's
near-inclusion theorems; Connes' theorem (injective ⇔ hyperfinite) stated and the II₁ half proved.
*Prerequisites.* Mathlib C*-algebras and WOT; OperatorTheory #126 (Borel calculus, PVMs);
Birkbeck AutomorphicSpectralTheory for direct integrals.
*Families.* 286, 287, 288, 289, 293, 295, 296, 300.
*Formalizability.* High for the core (Mathlib's C* API is strong); Connes' theorem is the long pole.

**8. ModularTheoryAndTypeIII** (math.OA) — L.
*Scope.* Tomita–Takesaki theory and its consequences for non-tracial von Neumann algebras: modular
automorphism groups, KMS states, Connes cocycles, crossed products by `ℝ` and the continuous core,
Takesaki duality, and the type III classification.
*Objects.* Standard form, modular operator and conjugation, modular group `σ^φ`, KMS condition,
Connes cocycle `(Dψ:Dφ)_t`, faithful normal conditional expectations and operator-valued weights,
`M ⋊_σ ℝ`, flow of weights, Connes `S` and `T` invariants, bicentralizer.
*Headline theorems.* Tomita's theorem; Takesaki's theorem on expectations; Connes' Radon–Nikodym
cocycle theorem; Takesaki duality; Connes' classification of type III_λ; Haagerup's
standard-form uniqueness; Haagerup's bicentralizer characterization (statement).
*Prerequisites.* VonNeumannAlgebras, OneParameterSemigroups (unitary groups, Stone).
*Families.* 289, 290.
*Formalizability.* Medium: unbounded operator calculus is the main cost (PR #126 supplies it).

**9. NuclearCStarAlgebras** (math.OA) — XL.
*Scope.* Completely positive and completely bounded maps, C*-tensor products, nuclearity and
exactness, and the standard examples: group C*-algebras, crossed products, AF, UHF, Cuntz and
Jiang–Su algebras; with the analytic properties of discrete groups (amenability, property (T))
that control them.
*Objects.* Operator spaces and cb maps; Stinespring dilation; Arveson extension; minimal and maximal
tensor products; nuclear, exact, CPAP; full and reduced group C*-algebras; reduced and full crossed
products, `C(X) ⋊ ℤ`; inductive limits, Bratteli diagrams; `O_n`, CAR algebra, dimension-drop
algebras, `Z`; norm ultrapowers; amenable groups, Kazhdan property (T).
*Headline theorems.* Stinespring; Arveson extension; Wittstock and Haagerup–Paulsen cb
factorization; Paulsen's similarity criterion; Takesaki's minimality of the spatial norm;
Choi–Effros and Kirchberg characterizations of nuclearity; Hulanicki (amenable ⇔ full = reduced);
Powers (simplicity and unique trace of `C*_r(F_2)`); Glimm's UHF classification; simplicity and
pure infiniteness of `O_n`; Jiang–Su's construction and strong self-absorption of `Z`; Kazhdan's
theorem for `SL₃(ℤ)`; Kirchberg's `O_2 ⊗ A ≅ O_2` for unital simple separable nuclear `A`.
*Prerequisites.* Mathlib C*-algebras, CP maps, `CStarMatrix`.
*Families.* 285, 288, 291, 292, 294, 297, 302.
*Formalizability.* High for maps, tensor products and examples; OAI's `Nuclearity`, `JiangSu`,
`NuclearUltrapower`, `Naimark` are porting references.

**10. CStarComparisonAndRegularity** (math.OA) — L.
*Scope.* The comparison theory of positive elements and the regularity properties of the
Elliott classification programme: Cuntz semigroups, traces and quasitraces, strict comparison,
pure infiniteness, central sequence algebras, and tensorial absorption of `Z`, `O_2`, `O_∞`.
*Objects.* Cuntz subequivalence, `Cu(A)`, functionals and dimension functions, lower-semicontinuous
tracial weights and their cone; quasitraces; stable rank, real rank, stable finiteness, proper
infiniteness; radius of comparison; central sequence algebra `A_ω ∩ A'`; order-zero maps; nuclear
dimension; strongly and weakly purely infinite algebras.
*Headline theorems.* Coward–Elliott–Ivanescu (`Cu` is a Cu-semigroup); Blackadar–Handelman
(dimension functions from quasitraces); Rørdam (`Z`-stable ⇒ almost unperforated, strict
comparison); Toms–Winter strongly self-absorbing theory; Kirchberg–Rørdam central-sequence
criteria; Matui–Sato (strict comparison ⇒ `Z`-stability, finite extreme boundary); Winter
(finite nuclear dimension ⇒ `Z`-stability); Kirchberg–Rørdam pure infiniteness and `O_∞`
absorption; Haagerup (quasitraces on exact algebras are traces) stated.
*Prerequisites.* NuclearCStarAlgebras.
*Families.* 291, 294, 299, 301, 302, 303.
*Formalizability.* Medium; the deep classification theorems (Gabe, CETWW) stay out of scope.

**11. OperatorKTheory** (math.KT; secondary math.OA, math.AT) — L.
*Scope.* K-theory of C*-algebras and its pairing with traces and K-homology, ending with the
Baum–Connes assembly map for discrete groups stated precisely.
*Objects.* `K_0`, `K_1` via projections and unitaries; suspensions; Bott map; six-term sequence;
trace pairing; Fredholm modules and K-homology; topological K-homology with compact supports of
`BG`; the reduced assembly map.
*Headline theorems.* Bott periodicity; six-term exact sequence; Elliott's AF classification via
`K_0`; Cuntz's computation of `K_*(O_n)`; Pimsner–Voiculescu; Kadison–Kaplansky for groups
satisfying Baum–Connes surjectivity (trace integrality) stated with the torsion-free proof for
free groups; Atiyah–Singer index of the Dirac operator on `𝕋²` as the K-homology class used in 285.
*Prerequisites.* NuclearCStarAlgebras, ClassifyingSpaces (PR #437), TauCeti Fredholm index.
*Families.* 285, 301, 302.
*Formalizability.* Medium; KK-theory is not included.

**12. FreeProbabilityAndFreeGroupFactors** (math.OA; secondary math.PR) — L.
*Scope.* Voiculescu's free probability at the von Neumann algebra level: reduced free products,
free semicircular and Haar systems generating free group factors, the compression and
interpolation calculus, and free entropy. Algebraic and C*-level freeness, cumulants and
R-transforms are consumed from RandomMatrices (PR #397, Milestone 6).
*Objects.* Reduced free products of tracial von Neumann algebras; `L(F_n)` and its free generators;
interpolated free group factors `L(F_r)`; free Fisher information and conjugate variables; `χ`, `χ*`,
`δ`, `δ_0`.
*Headline theorems.* Voiculescu: free semicircular `n`-tuples generate `L(F_n)`; compression formula
`L(F_n)_{1/k} ≅ L(F_{1+k²(n−1)})`; Dykema–Rădulescu interpolation and the all-isomorphic-or-all-distinct
dichotomy; Haagerup's inequality; Ricard–Xu free Khintchine; Biane–Capitaine–Guionnet `χ ≤ χ*`;
Voiculescu: `χ` of a free semicircular family.
*Prerequisites.* VonNeumannAlgebras, RandomMatrices (#397).
*Families.* 287, 288, 298.
*Formalizability.* Medium–high; OAI's `InterpolatedFactors` and `FreeEntropy` give statement-level
templates.

### math.FA

**13. NonselfadjointOperatorTheory** (math.FA; secondary math.OA, math.CV) — L.
*Scope.* Operators that are not normal: contractions and their dilations, spectral and numerical-range
bounds for functional calculi, Hardy-space models, interpolation in reproducing kernel spaces, and
invariant-subspace theory.
*Objects.* Unitary and isometric dilations; spectral and `K`-spectral sets, complete versions;
numerical range; `H^2` of the disc, shift, inner and outer functions, Toeplitz operators; RKHS,
complete Nevanlinna–Pick kernels; weighted shifts; invariant, hyperinvariant subspaces; transitive
algebras; hyperreflexivity.
*Headline theorems.* Sz.-Nagy dilation and von Neumann's inequality; Ando; Parrott's counterexample;
Arveson's dilation theorem for complete spectral sets; Toeplitz–Hausdorff; Crouzeix–Palencia
(`1+√2`); Beurling's theorem; Nevanlinna–Pick and Agler–McCarthy; Lomonosov; Arveson's density
theorem and distance formula.
*Prerequisites.* OperatorTheory (#126), NuclearCStarAlgebras (cb maps), ConformalMapping.
*Families.* 288, 293, 325, 369.
*Formalizability.* High.

**14. BanachSpaceGeometry** (math.FA) — XL.
*Scope.* The isomorphic and local theory of Banach spaces: bases and basic sequences, reflexivity,
classical sequence spaces, approximation properties, type and cotype, uniform convexity and
superreflexivity, asymptotic structure, ultrapowers, and metric fixed-point theory.
*Objects.* Reflexivity, weak compactness; Schauder and unconditional bases (consume Mathlib
`GeneralSchauderBasis`); `c_0`, `ℓ^p`, `L^p`; complemented subspaces; AP and BAP; Rademacher type
and cotype, K-convexity, B-convexity; moduli of convexity and smoothness; finite representability;
Banach ultrapowers; asymptotic moduli and AUC renormings; Daugavet property; covering numbers of
convex bodies; normal structure, nonexpansive maps, Kuratowski measure of noncompactness.
*Headline theorems.* Eberlein–Šmulian; James (reflexivity via sup-attaining functionals, statement
and separable proof); Bessaga–Pełczyński; Pitt; Pełczyński decomposition; Grothendieck's AP
criteria and Enflo's counterexample (statement); Kahane–Khintchine; Maurey–Pisier; Pisier's
K-convexity theorem; Dvoretzky (Milman's proof); John's theorem; Enflo and Pisier renorming of
superreflexive spaces; local reflexivity; Kirk's fixed-point theorem, Goebel–Karlovitz; Darbo's
theorem; Johnson–Rosenthal separable quotients of duals.
*Prerequisites.* Mathlib normed spaces, weak topologies, probability.
*Families.* 322, 323, 326, 327, 328, 329, 330, 331.
*Formalizability.* High; OAI `Cotype`, `MarkovType`, `Nonexpansive`, `SphereIsometry` are templates.

**15. NonlinearBanachGeometry** (math.FA; secondary math.MG) — L.
*Scope.* Banach spaces as metric spaces: Lipschitz and uniform classification, Lipschitz-free
spaces, Lipschitz extension, and the Ribe programme's metric invariants (Markov type and cotype,
tree and diamond distortion).
*Objects.* Lipschitz-free (Arens–Eells) spaces; Lipschitz retractions; Markov type, metric Markov
cotype, metric cotype; distortion; diamond and binary-tree graphs.
*Headline theorems.* Mazur–Ulam (consume), Mankiewicz; Kirszbraun and McShane; Ribe's theorem;
Heinrich–Mankiewicz; Godefroy–Kalton lifting; Aharoni's `c_0` universality; Bourgain's tree
characterization of superreflexivity; Johnson–Schechtman diamonds; Ball's Lipschitz extension
theorem; Naor–Peres–Schramm–Sheffield Markov type of uniformly smooth spaces.
*Prerequisites.* BanachSpaceGeometry.
*Families.* 322, 324, 327, 330, 331, 332.
*Formalizability.* High; coordinate with the combinatorics/TCS share on `L^1` embeddings of graphs.

### math.AP

**16. NonlinearEllipticPDE** (math.AP) — XL.
*Scope.* Nonlinear second-order elliptic equations beyond the PDE roadmap's linear theory: viscosity
solutions and fully nonlinear equations, semilinear equations (symmetry and Liouville theorems,
phase transitions), and one-phase free-boundary problems.
*Objects.* Viscosity sub/supersolutions, semijets; the infinity Laplacian and absolutely minimizing
Lipschitz extensions; Pucci operators; moving planes; Pohozaev and Rellich identities; Allen–Cahn
stable and monotone solutions; Alt–Caffarelli functional, blow-ups, Weiss energy.
*Headline theorems.* Jensen–Ishii lemma and comparison; Perron for viscosity solutions; Jensen's
uniqueness for infinity-harmonic functions, comparison with cones, Evans–Savin `C^{1,α}` in the
plane; Caffarelli `C^{1,α}`/`C^{2,α}` and Evans–Krylov; Gidas–Ni–Nirenberg; Gidas–Spruck Liouville;
Modica's gradient estimate; Ghoussoub–Gui and Ambrosio–Cabré (De Giorgi in `ℝ², ℝ³`); Savin's flat
level sets theorem; Alt–Caffarelli regularity, Weiss monotonicity, De Silva's flatness theorem,
Caffarelli–Jerison–Kenig in `ℝ³`.
*Prerequisites.* PDE (main + #93 Krylov–Safonov/ABP), GeometricMeasureTheory (dimension reduction).
*Families.* 367, 370, 375, 377.
*Formalizability.* Medium–high.

**17. CalculusOfVariations** (math.AP; secondary math.OC) — L.
*Scope.* The direct method for integral functionals on Sobolev spaces, the convexity notions that
make it work for vector-valued maps, Γ-convergence, and the existence theory of linear and
nonlinear elasticity.
*Objects.* Lower semicontinuity, coercivity; convex, polyconvex, quasiconvex, rank-one convex
integrands; null Lagrangians and weak continuity of determinants; Sobolev homeomorphisms;
Γ-convergence; linear elasticity (Lamé system, Korn inequalities); free-discontinuity functionals.
*Headline theorems.* Tonelli; Morrey's quasiconvexity theorem; Ball's existence theorem for
polyconvex elasticity; Müller's `det Du ∈ L log L`; Korn's first and second inequalities and
well-posedness of the Lamé system; Modica–Mortola; Γ-convergence compactness; Hencl–Pratelli planar
diffeomorphic approximation (statement).
*Prerequisites.* PDE (main), GeometricMeasureTheory (SBV for free discontinuities).
*Families.* 366, 368, 372, 375.
*Formalizability.* High.

**18. DispersiveEquations** (math.AP) — XL.
*Scope.* Linear and nonlinear Schrödinger and wave equations on `ℝⁿ` and `𝕋ⁿ`: dispersive and
Strichartz estimates, local and global well-posedness in Sobolev spaces, conservation laws, and the
basic blow-up and scattering theory. It replaces the PDE roadmap's Strichartz stretch goal.
*Objects.* Free propagators `e^{itΔ}`, `e^{it√−Δ}`; Duhamel formula; Strichartz pairs; Bourgain
spaces `X^{s,b}`; mass, energy, momentum; virial identities; Morawetz estimates; retarded
fundamental solution of the wave equation.
*Headline theorems.* Dispersive decay; Strichartz via `TT*` and Keel–Tao endpoint; local
well-posedness of NLS/NLW in `H^s` (subcritical, Sobolev-algebra `H^k(𝕋^d)`, `k > d/2`); global
`H^1` theory for defocusing energy-subcritical NLS; Glassey's virial blow-up; Bourgain's periodic
`L^4` Strichartz; Ginibre–Velo scattering; Kirchhoff formula and energy estimates for waves.
*Prerequisites.* PDE (main), IncompressibleFlows #237 (periodic `H^s`), RealHarmonicAnalysis.
*Families.* 079, 080, 362, 371.
*Formalizability.* High for linear and subcritical theory.

**19. KineticEquations** (math.AP; secondary math-ph) — XL.
*Scope.* Transport equations in phase space: Vlasov–Poisson and Vlasov–Maxwell, the Boltzmann
equation, and the derivation of Boltzmann from particle systems.
*Objects.* Free transport and characteristics; velocity averaging; Vlasov–Poisson and relativistic
Vlasov–Maxwell systems; collision kernels, Boltzmann collision operator (hard spheres, cutoff
potentials), Maxwellians, entropy, renormalized solutions; BBGKY hierarchy, Boltzmann–Grad scaling.
*Headline theorems.* Velocity averaging lemmas (Golse–Lions–Perthame–Sentis); Pfaffelmoser and
Lions–Perthame global classical Vlasov–Poisson in 3-D; Glassey–Strauss continuation criterion for
Vlasov–Maxwell; DiPerna–Lions weak solutions (Vlasov–Maxwell, Boltzmann); Boltzmann H-theorem and
Carleman representation; Lanford's short-time theorem; Dobrushin mean-field stability (consuming
OptimalTransport).
*Prerequisites.* IncompressibleFlows #237 (DiPerna–Lions transport), OptimalTransport (main),
DispersiveEquations (wave fundamental solution), PDE.
*Families.* 362, 363, 364.
*Formalizability.* Medium; OAI `VlasovMaxwell` (formalized) and `Boltzmann` are references.

**20. EllipticTheoryOnManifolds** (math.AP; secondary math.DG, math.SP) — L.
*Scope.* Elliptic boundary-value theory on compact Riemannian manifolds with boundary: Sobolev
spaces, traces, the Dirichlet and Neumann problems for the Laplace–Beltrami operator, regularity,
spectral theory, unique continuation and the Dirichlet-to-Neumann map.
*Objects.* `H^s(M)`, `H^{1/2}(∂M)`; weak Laplace–Beltrami problems; Dirichlet and Neumann
eigenvalues; DN map; Carleman weights.
*Headline theorems.* Rellich–Kondrachov on compact manifolds; trace theorem; existence, uniqueness
and elliptic regularity for the Dirichlet problem; DN map as a self-adjoint operator
`H^{1/2} → H^{−1/2}`; Weyl law (statement and proof via Dirichlet–Neumann bracketing); Aronszajn–Cordes
unique continuation; Courant nodal theorem.
*Prerequisites.* DifferentialGeometry (main, layer 12), PDE (main).
*Families.* 365 (and 369 for the planar Neumann problem).
*Formalizability.* High; port `abenenson/rellich-kondrachov` (H¹/H² and Rellich on closed
Riemannian manifolds, an OAI dependency). Coordinate with the geometry share (Hodge theory).

**21. InverseBoundaryProblems** (math.AP) — M.
*Scope.* Uniqueness in Calderón-type inverse problems: recovering coefficients, metrics and
connections from boundary measurements.
*Objects.* Conductivity, anisotropic (metric) and elastic DN maps; partial-data DN maps; complex
geometrical optics solutions; Runge approximation.
*Headline theorems.* Kohn–Vogelius boundary determination; Sylvester–Uhlmann global uniqueness for
`C²` conductivities (`n ≥ 3`); Lee–Uhlmann for real-analytic metrics; Astala–Päivärinta in the plane
(statement); Kenig–Sjöstrand–Uhlmann partial data; Nakamura–Uhlmann/Eskin–Ralston for isotropic
elasticity near constant coefficients.
*Prerequisites.* EllipticTheoryOnManifolds, CalculusOfVariations (Lamé), PDE.
*Families.* 365, 372.
*Formalizability.* Medium.

## (d) Family-by-family classification

Abbreviations: RHA RealHarmonicAnalysis, TFA TimeFrequencyAnalysis, FR FourierRestriction, KP
KakeyaAndProjections, GMT, UQ UnivalentFunctionsAndQuasiconformalMaps, VN VonNeumannAlgebras, MOD
ModularTheoryAndTypeIII, NUC NuclearCStarAlgebras, REG CStarComparisonAndRegularity, KT
OperatorKTheory, FP FreeProbabilityAndFreeGroupFactors, NSA NonselfadjointOperatorTheory, BSG
BanachSpaceGeometry, NLB NonlinearBanachGeometry, NLE NonlinearEllipticPDE, CV
CalculusOfVariations, DISP DispersiveEquations, KIN KineticEquations, MAN EllipticTheoryOnManifolds,
INV InverseBoundaryProblems; CM ConformalMapping, OT OptimalTransport, IF IncompressibleFlows (#237).
"L" marks families with a Lean scope page.

| # | short title | arXiv | classification | key needs |
| --- | --- | --- | --- | --- |
| 071 L | Koebe circle domains, He–Schramm rigidity | math.CV | needs UQ, GMT (+CM) | circle domains, removability, finitely connected uniformization, extremal length, coarea |
| 072 L | Brennan, integral-means spectrum | math.CV | needs UQ (+CM) | class S, distortion, area theorem, integral means |
| 073 L | Falconer distance conjecture | math.CA | frontier: radial projections, planar Furstenberg (Ren–Wang); needs KP, FR | Frostman, energies, spherical decay, stationary phase |
| 074 | Kakeya ℝ³ maximal, ℝ⁴ dimension | math.CA | frontier: Wang–Zahl Kakeya, sticky Kakeya; needs KP | Kakeya maximal function, multilinear Kakeya, polynomial method |
| 075 | L log L Fourier convergence | math.CA | needs TFA, RHA | Carleson–Hunt, Antonov/Sjölin–Soria, Orlicz spaces |
| 076 L | Ultraflat real Littlewood polynomials | math.CA | elementary | trigonometric polynomials, Bernstein inequality |
| 077 | Restriction for curved surfaces | math.CA | frontier: wave packets + Furstenberg; needs FR, KP | extension operator, BCT, decoupling, partitioning |
| 078 | 3-D Bochner–Riesz | math.CA | frontier; needs FR, KP, RHA | BR multipliers, Stein interpolation |
| 079 | 3-D local smoothing | math.CA | frontier; needs FR, DISP | half-wave propagator, decoupling, square functions |
| 080 | Sobolev endpoint Schrödinger convergence | math.CA | frontier: Du–Guth–Li–Zhang theory; needs FR, DISP | `e^{itΔ}` on `H^s`, Strichartz, fractal `L^2` |
| 081 L | Riesz transforms and rectifiability | math.CA | frontier: NTV reflectionless measures; needs GMT, RHA | AD-regular, uniform rectifiability, CZ on measures, Brouwer |
| 082 L | Triangular Hilbert transform | math.CA | needs TFA, RHA (+#126) | variation norms, heat-flow method, trace inequalities |
| 083 L | Hilbert transform along Lipschitz directions | math.CA | needs TFA, RHA | tiles/trees, Calderón commutator, variational inequalities |
| 084 L | Erdős similarity, geometric case | math.CA | elementary | Cantor-type constructions |
| 085 L | Centered disk maximal `W^{1,1}` bound | math.CA | needs RHA, GMT (+PDE) | `W^{1,1}`, Kinnunen, coarea |
| 086 | `L^3` trilinear Hilbert transform | math.CA | frontier: continuous Gowers inverse theory; needs TFA | trilinear forms, Weyl alternative |
| 285 | Baum–Connes / Kadison–Kaplansky counterexamples | math.OA | frontier: graphical small cancellation; needs NUC, KT | `C*_r G`, assembly map, K-homology, `BG` (#437) |
| 286 | Lattice von Neumann algebras | math.OA | frontier: Popa deformation/rigidity, superrigidity | twisted `L(G)`, bimodules, property (T) |
| 287 L | Free group factors isomorphic | math.OA | needs VN, FP (+#126, #397) | `L(F_n)`, interpolated factors, freeness, Borel calculus |
| 288 L | Kadison similarity | math.OA | needs VN, NUC, FP, NSA | cb maps, Kirchberg criterion, Γ, ultraproducts |
| 289 L | Strong Kadison–Kastler stability | math.OA | needs VN | KK distance, perturbation theory, injectivity |
| 290 L | Relative bicentralizers | math.OA | needs MOD, VN | continuous core, expectations, Haagerup, Popa MASA |
| 291 L | Toms–Winter, equivariant `Z`-stability | math.OA | frontier: Matui–Sato, uniform property Γ; needs REG, NUC | `Z`, `Cu(A)`, strict comparison, nuclear dimension |
| 292 L | Kirchberg `O_2` ultrapower problem | math.OA | needs NUC | norm ultrapowers, full group C*-algebras, property (T) |
| 293 L | Hyperinvariant subspaces | math.OA | needs NSA, VN | weighted shifts, crossed product, Arveson density |
| 294 L | Kaplansky quasitrace conjecture | math.OA | needs NUC, REG | quasitraces, stable finiteness, `C*_r(F_2)` |
| 295 L | Kadison–Ringrose cohomology | math.OA | needs VN, NUC | bounded Hochschild cohomology, cb maps, Kadison–Sakai |
| 296 L | Generator problem for II₁ factors | math.OA | needs VN | II₁ factors, separable predual, Baire category |
| 297 L | ZFC Naimark counterexample | math.OA | needs NUC | irreducible representations, CAR, HNN, inductive limits |
| 298 L | Free entropies differ | math.OA | needs FP | `χ`, `χ*`, free Fisher information, BCG |
| 299 L | Kirchberg–Rørdam character criterion | math.OA | needs REG | central sequence algebras, `Z`-stability |
| 300 | Quadratic strong-operator paving | math.OA | needs VN + MSS paving (combinatorics share) | MASAs, paving, interlacing polynomials |
| 301 | Trace cones, Razak–Jacelon | math.OA | frontier: classification of nuclear C*-algebras | tracial weight cones, `W` |
| 302 | Radius of comparison = mdim/2 | math.OA | frontier: mean dimension, complex cobordism | crossed products, radius of comparison |
| 303 L | Weak pure infiniteness | math.OA | needs REG | proper infiniteness, `O_∞` absorption |
| 322 L | Tingley's problem | math.FA | needs BSG | Mazur–Ulam (Mathlib), ultrapowers, Darbo |
| 323 L | Separable quotient independence | math.FA | frontier: forcing, real-valued measurable cardinals; needs BSG | w*-basic sequences |
| 324 L | Lipschitz ≠ linear isomorphism | math.FA | needs NLB | Lipschitz-free spaces, Aharoni |
| 325 L | Complete Crouzeix | math.FA | needs NSA, UQ (+CM) | numerical range, spectral sets, convex-domain Riemann maps |
| 326 L | Cotype–cotype under AP | math.FA | needs BSG | type/cotype, K-convexity, AP |
| 327 L | Markov type ⇒ superreflexive | math.FA | needs BSG, NLB | Markov type, martingale renorming |
| 328 L | Kirk: nonexpansive fixed points | math.FA | needs BSG | reflexivity, normal structure, Goebel–Karlovitz |
| 329 L | Metric-entropy duality counterexample | math.FA | elementary | covering numbers, polar bodies |
| 330 L | Lipschitz-free AP without BAP | math.FA | needs NLB, BSG (+expanders) | free spaces, AP/BAP, Godefroy–Ozawa |
| 331 L | Reflexive midpoint convexity, diamonds | math.FA | needs BSG, NLB | asymptotic moduli, Daugavet, diamond distortion |
| 332 | Metric Markov cotype of `ℓ_1` | math.FA | needs NLB | metric Markov cotype, Ball extension, Kirszbraun |
| 362 L | Relativistic Vlasov–Maxwell | math.AP | needs KIN, DISP | Glassey–Strauss, retarded fields |
| 363 L | Boltzmann nonuniqueness | math.AP | needs KIN (+IF) | collision operator, renormalized solutions |
| 364 | Boltzmann–Grad limit, fluctuations | math.AP | frontier: Bodineau–Gallagher–Saint-Raymond–Simonella theory; needs KIN | BBGKY, Lanford |
| 365 L | Metric + connection from one patch | math.AP | needs MAN, INV | DN map on manifolds, unique continuation, Runge |
| 366 | Planar Mumford–Shah regularity | math.AP | frontier: David/Bonnet regularity; needs GMT, CV | SBV, monotonicity |
| 367 L | Bernoulli critical dimension 7 | math.AP | frontier: stable free-boundary cones; needs NLE, GMT | Alt–Caffarelli, Weiss, dimension reduction |
| 368 | Ball–Evans approximation in 3-D | math.AP | frontier: 3-manifold taming, Hencl–Pratelli; needs CV | Sobolev homeomorphisms, Moise/Bing |
| 369 L | Hot spots, simply connected | math.AP | needs PDE (Neumann), NSA, CM | Neumann eigenfunctions, Pick kernels |
| 370 L | Lane–Emden / Hénon–Lane–Emden | math.AP | needs NLE (+PDE Lane C) | Newton potentials, Pohozaev identities |
| 371 L | Stable NLS blowup on `𝕋^{12}` | math.AP | frontier: self-similar blowup stability; needs DISP | `H^k` LWP, mode stability |
| 372 L | Isotropic elasticity uniqueness | math.AP | needs INV, CV | Lamé DN map, Carleman, CGO |
| 373 L | Three-marginal Coulomb Monge | math.AP | needs OT (existing) | multi-marginal OT |
| 374 L | One-third stability of Brenier maps | math.AP | needs OT (existing) | Brenier, semi-discrete OT |
| 375 | De Giorgi conjecture in ℝ⁸ | math.AP | frontier: Savin, stable Bernstein in ℝ⁷; needs NLE, GMT | Allen–Cahn, minimal cones |
| 376 L | Universal computation in forced NS | math.AP | needs IF (#237) (+Mathlib Turing machines) | forced NS on `𝕋³`, Lagrangian paths |
| 377 | `C^{1,α}` infinity-harmonic | math.AP | needs NLE | viscosity solutions, comparison with cones |

## (e) OAI Lean: external dependencies and infrastructure worth porting

**External dependencies.**
- `carleson` (fpvandoorn, pinned `306ae5b`) is required in `lean/lakefile.lean` but **no OAI file
  imports it** (`grep -rE '^(public )?import Carleson'` over `lean/` returns 0). What it provides:
  doubling metric measure spaces; Hardy–Littlewood maximal function on doubling spaces; weak-type
  and Lorentz seminorms and spaces; real interpolation (Marcinkiewicz, Lorentz interpolation);
  decreasing rearrangement; Calderón–Zygmund decomposition (`TwoSidedCarleson/WeakCalderonZygmund`);
  Hilbert kernel and its strong type; Dirichlet kernel; Hölder van der Corput; grid and tile
  structures, forests, antichains; the metric Carleson theorem and classical Carleson–Hunt.
  Natural home: RealHarmonicAnalysis and TimeFrequencyAnalysis (and PDE Lane B's CZ items).
- `rellich-kondrachov` (abenenson, pinned `70f85d4`) is imported by 9 files, none in this share
  (`NumberTheory/CubicMoment`, `NumberTheory/DirichletL`, `MathematicalPhysics/ContinuumCoulomb`,
  `Geometry/EinsteinFour`). It provides `H^1`/`H^2` on `ℝⁿ`, Fréchet–Kolmogorov `L^2` compactness,
  Rellich on `ℝⁿ`, chart-based `H^1`/`H^2` on compact Riemannian manifolds, Rellich–Kondrachov on
  compact Riemannian manifolds, Riemannian volume measure. Euclidean parts overlap Tau Ceti's own
  Sobolev/Rellich; the manifold parts belong in EllipticTheoryOnManifolds.
- Tau Ceti itself is imported by only 5 OAI files (all `Probability/SLE`: conformal Montel,
  Hurwitz, normal families, simple connectivity, inverse functions). `fixed-point-theorems`
  (Brouwer) is imported in this share by `Analysis/RieszRectifiability` and
  `MathematicalPhysics/DefocusingNLS`.

**Infrastructure in neither Mathlib nor Tau Ceti** (Apache-2.0; mostly ad hoc and duplicated, so
these are references for roadmap specifications rather than code to vendor):
- *von Neumann algebras*: `Analysis/OperatorAlgebra` (GNS cyclic representations and standard
  form, bicommutant theorem in strong-* form, preduals of finite operators, Hilbert–Schmidt actions);
  `ComparatorChallenges/InterpolatedFactors.lean` (`L(G)` as the bicommutant of left translations on
  `ℓ²(G)`, ultraweak topology, corners, amplification, normal trace-preserving isomorphisms);
  `Analysis/FactorGeneration` (II₁ factor, separable predual, `W*`-generation); `Analysis/BoundedHochschild`
  (Hochschild cochains, cb maps, central decomposition); `Analysis/ModularTheory` (crossed products,
  dual actions, continuous-core fragments); `Analysis/KadisonSimilarity` (free products, Arveson
  distance formula, hyperreflexivity).
- *C*-algebras*: `Analysis/Nuclearity` (spatial minimal tensor product, cp extensions);
  `Analysis/JiangSu` (Cuntz subequivalence and semigroup, dimension-drop algebras, central sequences,
  quasitraces); `Analysis/NuclearUltrapower` (norm ultrapowers, min/max tensor norms, full group
  algebras, `O_2` relations, Kazhdan gap); `Analysis/Naimark` (CAR algebra, Fock spaces, inductive
  limits, HNN); `Analysis/WeakInfiniteness`, `OInfinity`. `CuntzSubequiv`, `IsNuclear`,
  `TracialState` and Banach ultraquotients are each defined in three or more directories.
- *free probability*: `Analysis/FreeEntropy` and `ComparatorChallenges/FiniteEntropySeparation.lean`
  (conjugate systems, free Fisher information, microstates `χ` with cutoff, `χ*`) in about 5 KB of
  statement code — a ready template for FreeProbabilityAndFreeGroupFactors' `Suggested.lean`.
- *Banach spaces*: `Analysis/Cotype` (`HasType`, `HasCotype`, `KConvex`, `BConvex`,
  `ApproximationProperty`); `Analysis/MarkovType` (`HasMarkovType`, martingales and stopping times,
  equivalent uniformly convex/smooth norms, `CanonicallyReflexive`); `Analysis/Nonexpansive`
  (fixed-point property, weak compactness); `Analysis/SphereIsometry` (Banach ultrapowers);
  `Analysis/MetricEntropy` (covering numbers); `Analysis/LipschitzEquivalence` (Lipschitz-free space,
  `c_0(H)`); `Analysis/NumericalRange` (Bloch space, numerical range).
- *real analysis / GMT*: `Analysis/RieszRectifiability/Foundations` (`ADRegular`,
  `UniformlyRectifiable`, truncated Riesz transforms); `MeasureTheory/Falconer/Frostman` (Hausdorff
  content, capacity trees) and the Furstenberg campaign; `Analysis/IntegralMeans` (schlicht class,
  integral means); `Analysis/CircleDomains/Sobolev` and `Modulus` (ACL characterization, coarea
  identities, modulus); `Analysis/DiskMaximal` (weak gradients, `W^{1,1}_loc`).
- *PDE*: `Analysis/VlasovMaxwell` (system, classical solutions, phase flows; formalized);
  `MathematicalPhysics/Boltzmann` (collision operator); `MathematicalPhysics/NavierStokes` (forced
  NS on `𝕋³`); `MathematicalPhysics/DefocusingNLS` (NLS on tori); `Analysis/Conductivity` (DN
  operator for bounded measurable conductivities).
- The comparator files (`lean/ComparatorChallenges/*.lean`, 811 files in git, not checked out in the
  sparse clone; read with `git show HEAD:lean/ComparatorChallenges/<X>.lean`) state each headline
  result against Mathlib in 1–35 KB and are the cheapest source of statement-level signatures for
  new roadmaps.

**Caveats.** Porting must follow the README's porting rules: specify the mathematics, coordinate
with the authors (OpenAI for `lean/`, van Doorn–Thiele for `carleson`, Benenson for
`rellich-kondrachov`), and keep any file map in a secondary provenance section. Several proposals
touch other shares: GeometricMeasureTheory and EllipticTheoryOnManifolds (geometry),
NonlinearBanachGeometry (TCS metric embeddings), property (T) inside NuclearCStarAlgebras (group
theory), and the out-of-analysis needs in cluster 30.
