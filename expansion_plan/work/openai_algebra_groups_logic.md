# OpenAI release: Algebra, Group theory, Mathematical logic (families 193–210, 240–259)

Prerequisite analysis for the 38 result families whose `subject` is Algebra (18), Group theory (14)
or Mathematical logic (6) in `openai_families.json`. Needs file:
`needs_openai_algebra_groups_logic.jsonl` (136 lines). Evidence: abstracts for all 59 manuscripts;
all 59 PDFs downloaded and converted to text, and the introductions and preliminaries of 40 of
them read or searched for proof inputs (193, 194, 195, 196, 197b–c, 198, 199b, 200a, 201, 202,
203a, 204, 205a, 206b, 207a–b, 208, 209b, 210a, 240b, 241, 243a, 244, 245, 246, 247b, 248, 249,
250a, 251a–b, 252, 253, 254a, 255, 256b, 257, 258b, 259); the 41 Lean comparator statements and
`lean/docs/*.md` for these families; the OAI Lean tree under `lean/OAI/`; Mathlib `6b7abb3c`; Tau
Ceti `a91d3aafa`; TauCetiRoadmap `upstream/main`, the 78 open-PR heads and the Birkbeck campaign.

## (a) Statistics

| | Algebra | Group theory | Logic | Total |
|---|---|---|---|---|
| Families / manuscripts | 18 / 29 | 14 / 22 | 6 / 8 | 38 / 59 |
| Manuscripts flagged `formalized` in `formalization.yaml` | 10 (7 fam.) | 8 (7 fam.) | 5 (5 fam.) | 23 (19 fam.) |
| Families with a Lean comparator statement (yaml flag, `lean/docs` or `ComparatorChallenges`) | 9 | 12 | 6 | 27 |
| Classification `elementary` / `needs` / `frontier` | 2 / 11 / 5 | 0 / 9 / 5 | 0 / 4 / 2 | 2 / 24 / 12 |

Coverage of the 136 needs (strongest owner): mathlib 42, gap 35, tauceti-code 23,
birkbeck-campaign 12, oai-lean 11, tauceti-roadmap 9, open-pr 4. Most "mathlib" lines are
statement vocabulary (presentations, group algebras, Turing reducibility, model-theoretic
structures) with the theory itself missing; those carry a `proposed_roadmap`.

The headline: **geometric and combinatorial group theory, set theory/forcing, computability
beyond Turing reducibility, classical model theory, λ-calculus, local commutative algebra
(depth/CM/multiplicity) and modular representation theory have no owner anywhere** (no Tau Ceti
roadmap, no open PR, no campaign roadmap). The OAI Lean tree has already built large ad hoc
fragments of several of them (forcing, Slaman–Woodin, type systems, Salvetti complexes, FP_n),
all Apache-2.0.

## (b) Prerequisite clusters and coverage

Level: s = needed to state a result, p = needed to prove one. "Proposal" names the roadmap in (c)
that should own the missing part.

**Commutative algebra and K-theory**

| Cluster | Coverage (strongest owner) | Families | arXiv | Level | Proposal |
|---|---|---|---|---|---|
| Regular local rings, Tor, length, regular sequences | mathlib (`RingTheory/RegularLocalRing`, `RegularSequence`) | 193, 200, 209 | math.AC | s | — |
| Depth, CM and Gorenstein rings/modules, local cohomology, canonical modules | birkbeck-campaign, partial (DeformationAndDerivedPatchingAlgebra R03.3; Mathlib has only Rees' Ext-depth theorem `RingTheory/Depth/Rees`) | 193, 194, 195 | math.AC | s/p | CohenMacaulayRings |
| Hilbert–Samuel multiplicity; Serre's χ(M,N); Dutta/Hilbert–Kunz | tauceti-code, partial (`RingTheory/RegularLocalRing/Intersection`: lengths on regular surfaces only) | 193, 194 | math.AC | s/p | MultiplicitiesAndIntersections |
| Hilbert functions, graded Betti numbers, lex ideals, Gröbner/gin | gap (Mathlib `HilbertPoly`, `MonomialOrder`) | 200 | math.AC | s/p | GradedFreeResolutions |
| Perfectoid algebras, almost purity, big CM algebras | birkbeck-campaign (PerfectoidSpaces) | 193, 194 | math.AG | p (frontier) | — |
| Quillen K/G-theory, finite coefficients, Gersten complex | birkbeck-campaign (GeneralAlgebraicKTheory, SchemeKTheoryOperations) | 193, 209 | math.KT | s/p | — |
| Truncating invariants, Land–Tamme descent | gap | 193 | math.KT | p (frontier) | — |
| Blowups, regular models, Cohen factorization | tauceti-code, partial (`AlgebraicGeometry/Blowup`) | 194, 195 | math.AG | p | — |
| Algebraic surfaces: Chern numbers, Hodge index, Bogomolov | gap | 195 | math.AG | p | AlgebraicAndComplexSurfaces (AG share) |

**Noncommutative algebra and representation theory**

| Cluster | Coverage | Families | arXiv | Level | Proposal |
|---|---|---|---|---|---|
| Projective dimension, Ext | mathlib | 198 | math.RA | s | — |
| Bound quiver algebras, almost split sequences | tauceti-roadmap (QuiverRepresentations) | 198, 199 | math.RT | p | — |
| Self-injective/symmetric algebras, stable categories | tauceti-code (`Algebra/Algebra/Frobenius`), StablePeriodicCurved | 199 | math.RT | s | — |
| Gorenstein-projective modules, totally acyclic complexes | tauceti-code (`Algebra/Homology/TotallyAcyclic`); #323 GorensteinHomologicalAlgebra | 199 | math.RA | s | — |
| Finitistic/dominant dimension, tilting, trivial extensions, homological conjectures | gap | 198, 199 | math.RT | s/p | TiltingAndHomologicalDimensions |
| Central simple, cyclic and symbol algebras | tauceti-code (`Algebra/CentralSimple`, `CrossedProduct`) | 201 | math.RA | s/p | — |
| PI theory, nil algebras, Kurosh problems, Golod–Shafarevich | tauceti-code, partial (`RingTheory/Ideal/GolodShafarevich`) | 201, 247 | math.RA | s/p | NoncommutativeRingTheory |
| Group rings: Kaplansky conjectures, Hattori–Stallings trace, K_0 | tauceti-code, partial (`Algebra/MonoidAlgebra`); KTheoryLowDegrees (campaign) for K_0 | 196, 197, 207 | math.RA | s | GroupRings |
| Group von Neumann algebra, trace, FK determinant, ℓ¹(G) | mathlib, partial (`Analysis/VonNeumannAlgebra/Basic` is a definition) | 197, 207 | math.OA | s/p | GroupVonNeumannAlgebras |
| Blocks, Brauer characters, defect groups, weights | gap (RepresentationTheory README: "the modular theory proper … is out of scope") | 202, 203 | math.RT | s/p | ModularRepresentationTheory |
| Deligne–Lusztig theory, ℓ-adic sheaves on flag varieties | gap | 203 | math.RT | p (frontier) | — |
| CFSG list; O'Nan–Scott and Aschbacher classes | tauceti-roadmap (CFSGStatement, #446/#447/#599/#697/#698); maximal-subgroup theory gap | 203, 206 | math.GR | p | — |
| Finite and symmetric tensor categories, Ver_p, fiber functors | open-pr, partial (#57 PivotalSpherical is fusion-level) | 208 | math.QA | s/p | FiniteTensorCategories |
| SL₂ tilting modules in characteristic p | open-pr, partial (#58 TemperleyLieb) | 208 | math.RT | p | — |
| Specht modules, Kronecker coefficients, Schur functors | tauceti-code (`RepresentationTheory/Symmetric/Specht`); SchurWeyl, CharacterTheory, ClassicalGroups | 205, 210 | math.RT | s/p | — (plethysm should be added to ClassicalGroups) |
| Highest weights, spin representations | tauceti-roadmap (LieHighestWeight, SpinRepresentations, RootSystems) | 204 | math.RT | s | — |
| Crystals, Littelmann path model | gap | 204 | math.RT | p | CrystalBases |
| Universal algebra, congruence lattices | gap (Mathlib `Con` for `Mul`, lattices, `ModelTheory`) | 206 | math.RA | s/p | UniversalAlgebra |

**Group theory**

| Cluster | Coverage | Families | arXiv | Level | Proposal |
|---|---|---|---|---|---|
| Presentations, amalgams/HNN, Bass–Serre, van Kampen diagrams, small cancellation, one-relator groups, Mal'cev, Higman embedding | mathlib, vocabulary only (`PresentedGroup`, `IsFinitelyPresented`, `PushoutI`, `HNNExtension`, `ResiduallyFinite`) | 196, 197, 247, 250, 252, 253, 256, 257, 258 | math.GR | s/p | CombinatorialGroupTheory |
| Quasi-isometry, Švarc–Milnor, hyperbolic groups, Gromov boundary | mathlib, partial (`Geometry/Group/WordMetric`, `Growth`) | 246, 252, 254, 255, 257, 258 | math.GR | s/p | HyperbolicGroups |
| CAT(κ) spaces, flat torus, cube complexes, RAAG Salvetti complexes, specialness | gap | 249, 252, 254, 257, 258 | math.GR | s/p | NonpositiveCurvature |
| K(G,1) recognition and construction | tauceti-code (`AlgebraicTopology/EilenbergMacLane`); #437 ClassifyingSpaces | 196, 249, 254 | math.AT | s | — |
| cd, gd, FP_n, F_n, Eilenberg–Ganea, Brown's criterion, Bestvina–Brady | gap (Tau Ceti's cohomological dimension is profinite) | 196, 249, 250 | math.GR | s/p | GroupCohomologyFiniteness |
| Artin–Tits groups, Garside theory, Salvetti complex, parabolics | tauceti-code, partial (`GroupTheory/Coxeter/Artin`, `Parabolic`, `Matsumoto`) | 254 | math.GR | s/p | ArtinGroupsAndGarside |
| Amenable and sofic groups, cellular automata, unitarizability | mathlib, partial (`MeasureTheory/Group/FoelnerFilter`) | 197, 248, 251, 253 | math.GR | s/p | AmenableGroupsAndGrowth (shared with probability share) |
| Gromov's polynomial growth theorem | gap | 255 | math.GR | p | AmenableGroupsAndGrowth |
| Nilpotent/polycyclic groups, lattices in solvable Lie groups | tauceti-roadmap, partial (RepresentationTheory/LieGroups) | 255 | math.GR | s/p | NilpotentAndPolycyclicGroups |
| Cost, graphings, orbit equivalence | gap | 259 | math.DS | s/p | MeasuredGroupTheory |
| Thompson and Brin–Thompson groups | gap | 248, 250 | math.GR | s/p | CombinatorialGroupTheory (examples) |
| Steinberg groups St_n(R), K_2 | birkbeck-campaign (K2SymbolsBrauer T.1) | 247 | math.KT | s | — |
| Isometries of H³ | open-pr (#432 KleinianGroups) | 246 | math.GT | s | — |
| Property (T) | gap | 247 | math.GR | p | — (one corollary) |
| Frontier inputs: Bonk–Kleiner/Sullivan–Tukia; Wise–Agol hierarchy; coarse differentiation; topological full groups | gap or oai-lean | 246, 258, 255, 253 | math.GR/MG | p | — |

**Logic**

| Cluster | Coverage | Families | arXiv | Level | Proposal |
|---|---|---|---|---|---|
| Turing jump, arithmetical hierarchy, degree theory, Π⁰₁ classes | mathlib, partial (`Computability/TuringDegree`, `RecursiveIn`) | 241, 242, 250 | math.LO | s/p | ComputabilityTheory |
| MRDP theorem | birkbeck-campaign (LogicAndDefinabilityInNumberTheory LD.4); Mathlib `Dioph`, `pow_dioph` | 206, 242 | math.LO | p | — |
| Slaman–Woodin representation theorem | oai-lean (`Computability/DegreeRigidity`) | 241 | math.LO | p (frontier) | — |
| Types, ω-stability, EM models, Erdős–Rado, Morley, AECs | mathlib, partial (`ModelTheory`); #41 excludes EM/Erdős–Rado/Morley–Hanf | 240 | math.LO | s/p | ClassicalModelTheory |
| ZF metatheory, L, forcing, symmetric extensions | oai-lean (`SetTheory/PartitionConsistency`); Mathlib `SetTheory/ZFC` only | 240, 241, 244 | math.LO | s/p | ForcingAndIndependence |
| λ-calculus, pure type systems, normalization | oai-lean (`Computability/TypeSystem`) | 245 | cs.LO | s/p | LambdaCalculusAndTypeTheory |
| Finite model theory, choiceless polynomial time | oai-lean (`ModelTheory/Choiceless`) | 243 | cs.LO | s/p | DescriptiveComplexity |

## (c) Proposed roadmaps

Twenty-three proposals owned here, plus three names aligned with other shares
(AmenableGroupsAndGrowth with probability, AlgebraicAndComplexSurfaces with algebraic geometry,
VonNeumannAlgebras with physics) that these families also consume. Sizes: M ≈ one semester,
L ≈ a graduate course, XL ≈ more than one course.

### Commutative algebra

**CohenMacaulayRings** (math.AC; secondary math.AG). *This roadmap develops the homological theory
of Noetherian local rings beyond regularity: depth, Cohen–Macaulay and Gorenstein rings and modules,
and the local cohomology that measures them. It starts from Mathlib's regular sequences, `Ext`,
Krull dimension, regular local rings and Rees' Ext characterization of depth, and ends at canonical
modules and local duality.* Objects: `depth`, systems of parameters, `IsCohenMacaulay` (ring, module),
maximal Cohen–Macaulay modules, Koszul homology, local cohomology `H^i_𝔪`, injective dimension,
Gorenstein local rings, canonical modules, Serre's conditions (R_k), (S_k). Headlines:
Auslander–Buchsbaum formula; Auslander–Buchsbaum–Serre (regular ⇔ finite global dimension);
CM ⇔ unmixedness theorem; CM passes along flat local maps with CM fibers and to completions;
Grothendieck vanishing and nonvanishing; Bass (Gorenstein ⇔ finite injective dimension);
existence of canonical modules for quotients of Gorenstein rings; local duality; Serre's normality
criterion; complete local domains of dimension ≤ 2 have MCM modules. Prerequisites: Mathlib; the
Birkbeck stage R03.3 should consume this rather than build its own. Serves 193, 194, 195 (and 200's
complete intersections). Size L. Formalizability: textbook (Bruns–Herzog Ch. 1–3, Matsumura Ch. 6–8)
and aligned with active Mathlib work on depth.

**MultiplicitiesAndIntersections** (math.AC; math.AG). *Hilbert–Samuel theory of a Noetherian local
ring and module, multiplicities of ideals, and Serre's homological intersection multiplicity, up to
the cases Serre settled.* Objects: Hilbert–Samuel function and polynomial, `e(𝔮, M)`, associated
graded ring and Rees algebra, reductions and integral closure of ideals, Serre's
`χ(M,N) = Σ (-1)^i ℓ(Tor_i)`, Hilbert–Kunz multiplicity, Dutta multiplicity of short complexes.
Headlines: dimension theorem (degree of the Hilbert–Samuel polynomial = Krull dimension = least
length of a system of parameters); associativity formula; Serre's `e(x; M) = χ(Koszul)`; Nagata's
`e(R) = 1` characterization of regularity for unmixed rings; Rees' theorem on reductions; Lech's
inequality and `e(R) ≤ e(S)` for flat maps with dim R ≤ 2; Serre's dimension inequality, vanishing
and positivity of χ in equicharacteristic and unramified regular rings (reduction to the diagonal);
Monsky's existence of Hilbert–Kunz multiplicity. Boundary: statements that need K-theory with
supports or alterations (Roberts, Gillet–Soulé, Gabber) are outside. Prerequisites:
CohenMacaulayRings; Mathlib `HilbertPoly`; Tau Ceti `RingTheory/Intersection` (to be generalized).
Serves 193, 194. Size L. Formalizability: Serre's *Local Algebra* II and V, Huneke–Swanson Ch. 11;
OAI `RingTheory/Multiplicity` has Čech complexes, coefficient fields and Dutta multiplicity.

**GradedFreeResolutions** (math.AC; math.CO). *Finite graded modules over a polynomial ring, their
Hilbert functions and minimal free resolutions, and the extremal theory of Hilbert functions and
Betti numbers.* Objects: Hilbert function and series, minimal graded free resolutions, graded Betti
numbers `β_{i,j}`, Castelnuovo–Mumford regularity, monomial, lex-segment, strongly stable and
Borel-fixed ideals, Gröbner bases, initial and generic initial ideals. Headlines: Hilbert syzygy
theorem; Hilbert–Serre rationality; Macaulay's characterization of Hilbert functions; Gotzmann
persistence; Green's hyperplane restriction theorem; Eliahou–Kervaire resolution;
Bigatti–Hulett–Pardue (lex ideals maximize Betti numbers); Galligo/Bayer–Stillman (generic initial
ideals are Borel-fixed); Clements–Lindström. Prerequisites: Mathlib `MvPolynomial`, `MonomialOrder`,
`HilbertPoly`, `Tor`; CohenMacaulayRings for regular sequences. Serves 200. Size L.
Formalizability: combinatorial and finite (Herzog–Hibi *Monomial Ideals*, Eisenbud Ch. 15).

### Noncommutative algebra and representation theory

**TiltingAndHomologicalDimensions** (math.RT; math.RA). *Homological dimensions of
finite-dimensional algebras and the tilting theory that relates them, culminating in the precise
statements and standard implications of the homological conjectures.* Objects: global, finitistic
(little and big), dominant and self-injective dimensions; self-orthogonal modules; tilting and
cotilting modules; trivial extension algebras `A ⋉ DA`; Auslander algebras; Auslander–Gorenstein
and gendo-symmetric algebras. Headlines: Brenner–Butler tilting theorem; Happel's theorem (tilting
gives a derived equivalence); Morita–Tachikawa correspondence; Müller's characterization of dominant
dimension; Auslander's correspondence for representation-finite algebras; finiteness of the
finitistic dimension for monomial and radical-cube-zero algebras (Igusa–Todorov functions);
trivial extensions are symmetric; the implications among the Nakayama, generalized Nakayama,
Auslander–Reiten, Tachikawa and Wakamatsu statements. Prerequisites: QuiverRepresentations (path
algebras, AR theory), StablePeriodicCurved, #323 GorensteinHomologicalAlgebra, GrothendieckEulerForms.
Serves 198, 199. Size L. Formalizability: finite-dimensional linear algebra; OAI built 135 k lines of
explicit resolutions for these two families.

**NoncommutativeRingTheory** (math.RA). *The structure theory of noncommutative rings beyond
semisimplicity: radicals, primitive and prime rings, polynomial identities, and algebraic and nil
algebras, including the Golod–Shafarevich counterexamples to the Kurosh and Burnside problems.*
Objects: Jacobson, Levitzki and Köthe radicals; primitive, prime and semiprime rings; PI algebras
and the standard polynomial; algebraic algebras; Golod–Shafarevich graded algebras; Goldie rings.
Headlines: Jacobson density theorem; Levitzki's theorem; Amitsur–Levitzki; Kaplansky's PI theorem;
local finiteness of algebraic PI algebras (Kaplansky–Jacobson); Posner's theorem; Goldie's theorem;
Golod's finitely generated infinite-dimensional nil algebra and infinite finitely generated
p-groups; Amitsur's algebraicity over uncountable fields; Cartan–Brauer–Hua. Prerequisites:
Mathlib (`Ring.jacobson`, `OreLocalization`), Tau Ceti `GolodShafarevich`, SemisimpleAlgebras.
Serves 201, 247. Size L.

**GroupRings** (math.RA; math.GR, math.KT). *Group algebras of infinite groups and Kaplansky's
problems about them.* Objects: `MonoidAlgebra K G`, supports, unique-product and orderable groups,
the canonical trace, Hattori–Stallings rank on `K_0(K[G])`, direct and stable finiteness. Headlines:
zero-divisor and unit conjectures for unique-product groups and their failure for the
Promislow group; Kaplansky's trace theorem `0 < τ(e) < 1` and stable finiteness of `ℂ[G]`
(Kaplansky–Montgomery); Zalesskii's rationality of `τ(e)`; Passman–Connell semiprimeness and
primeness criteria; the Bass trace conjecture statement and Linnell's restriction to finite-order
classes; the Dykema–Juschenko matrix-to-scalar transfer. Prerequisites: GroupVonNeumannAlgebras
(traces), AmenableGroupsAndGrowth (Elek–Szabó lives there), a K_0 owner (KTheoryLowDegrees in the
campaign, or a minimal K_0 layer here). Serves 196, 197, 207. Size M.

**GroupVonNeumannAlgebras** (math.OA; math.GR, math.FA). *The operator algebras of a discrete group
and the L²-invariants they carry.* Objects: `ℓ²(G)`, the left regular representation, `N(G)` and
`C*_r(G)`, the canonical trace, Hilbert `N(G)`-modules and von Neumann dimension, the
Fuglede–Kadison determinant, L²-Betti numbers of free G-CW complexes, the Banach algebra `ℓ¹(G)`.
Headlines: faithful normal trace; additivity of von Neumann dimension; multiplicativity of the FK
determinant; L²-Betti numbers of finite groups, free groups and amenable groups (Cheeger–Gromov);
Lück's approximation theorem for residually finite groups; Kaplansky's trace positivity.
Prerequisites: VonNeumannAlgebras (physics share), Mathlib `VonNeumannAlgebra`, continuous
functional calculus; #437 ClassifyingSpaces. Serves 197, 207 (and 251). Size L.

**ModularRepresentationTheory** (math.RT; math.GR). *Representations of finite groups in
characteristic dividing the group order: Brauer characters, blocks and their defect groups, and
the local–global correspondences of Brauer and Green.* Objects: splitting p-modular systems
`(K, O, k)`, reduction mod p, Brauer characters, decomposition and Cartan matrices, the cde
triangle, block idempotents, defect groups, Brauer correspondence and Brauer pairs, vertices and
sources, p-weights, Morita equivalence of blocks, basic algebras. Headlines: number of simple
kG-modules = number of p-regular classes; `C = DᵀD`; Brauer's first, second and third main theorems;
Higman's criterion and Green correspondence; characters of p-defect zero; Brauer–Feit bound;
Knörr–Robinson reformulation of the weight conjecture; Kessar's reduction of Donovan's conjecture
to Cartan bounds and Morita–Frobenius numbers. Prerequisites: CharacterTheory, InductionRestriction,
ModularInduction, SemisimpleAlgebras; Tau Ceti `RingTheory/CentralIdempotent`, `Morita/Corner`.
Serves 202, 203. Size XL (natural split: Brauer characters and blocks; then Green theory and
Morita classes). Formalizability: Navarro *Characters and Blocks*, Linckelmann vols. I–II.

**FiniteTensorCategories** (math.QA; math.CT, math.RT). *Non-semisimple finite tensor categories and
symmetric tensor categories in every characteristic.* Objects: (multi)tensor categories, finite
tensor categories, exact module categories, Frobenius–Perron dimension, symmetric tensor categories
of moderate growth, semisimplification by negligible morphisms, super vector spaces, `Ver_p`,
fiber functors, the Frobenius functor. Headlines: exactness of ⊗ from rigidity; FP dimension of a
finite tensor category and its projective generator; `Ver_p` as the semisimplification of
`Rep(ℤ/p)`; Deligne's theorem in characteristic 0; Ostrik's theorem (symmetric fusion categories
fiber over `Ver_p`); the Etingof–Ostrik Frobenius functor and its exactness criterion.
Prerequisites: #57 PivotalSpherical, Mathlib monoidal/rigid/braided categories, ReductiveGroups
(Tannakian reconstruction). Serves 208. Size L. Formalizability: EGNO *Tensor Categories*.

**CrystalBases** (math.RT; math.CO, math.QA). *Combinatorial crystals and the Littelmann path model
for a symmetrizable Kac–Moody root datum restricted to the finite type.* Objects: abstract and
seminormal crystals, morphisms, the tensor product rule (convention pinned), highest-weight crystals
`B(λ)`, type-A tableau crystals, Littelmann paths, LS paths, root operators. Headlines: character of
the path crystal = Weyl character; Littelmann's generalized Littlewood–Richardson rule; Stembridge's
local axioms; uniqueness of normal crystals with given character; RSK as a crystal isomorphism.
Prerequisites: RootSystems, LieHighestWeight, SchurWeyl. Serves 204. Size M. Formalizability:
Bump–Schilling *Crystal Bases*; avoids quantum groups.

**UniversalAlgebra** (math.RA; math.LO). *Algebras of an arbitrary signature, their congruence
lattices and varieties.* Objects: algebras over a functional `FirstOrder.Language` (defer to
Mathlib's vocabulary), congruences, `Con(A)` as an algebraic lattice, subdirect products, varieties,
free algebras, clones and Mal'cev terms, subgroup intervals of finite groups. Headlines: `Con(A)` is
algebraic; Birkhoff's subdirect representation and HSP theorems; Mal'cev's congruence-permutability
criterion; Jónsson's lemma; Grätzer–Schmidt (every algebraic lattice is a congruence lattice);
Pálfy–Pudlák (finite representability ⇔ subgroup interval). Prerequisites: Mathlib `ModelTheory`,
`Order`. Serves 206. Size M.

### Group theory

**CombinatorialGroupTheory** (math.GR; math.GT). *Groups given by generators and relations and the
diagrammatic, tree and algorithmic methods for studying them.* Objects: presentations and Tietze
moves, presentation complexes, van Kampen diagrams and pictures (also relative to a free factor),
aspherical presentations, small cancellation conditions (classical and graphical), one-relator
groups, Baumslag–Solitar groups, graphs of groups and Bass–Serre trees, residually finite and
Hopfian groups, word problems, Thompson's groups F, T, V. Headlines: van Kampen's lemma; Lyndon's
asphericity and the torsion theorem for one-relator groups; Magnus' Freiheitssatz and solvable word
problem; Greendlinger's lemma and Dehn's algorithm for C′(1/6); Bass–Serre structure theorem;
Kurosh subgroup theorem; Mal'cev (finitely generated linear ⇒ residually finite ⇒ Hopfian);
Gerstenhaber–Rothaus; Novikov–Boone; Higman's embedding theorem; the classical Boone–Higman
theorem; finite presentation of F and simplicity of [F,F], T, V. Prerequisites: Mathlib
presentations, `PushoutI`, `HNNExtension`; ComputabilityTheory; AlgebraicTopology and #437.
Serves 196, 197, 247, 248, 250, 252, 253, 256, 257, 258. Size XL (Bass–Serre theory can be its own
roadmap). Formalizability: Lyndon–Schupp, Serre *Trees*; OAI built pictures and relative
presentations ad hoc for 196, 256, 257.

**HyperbolicGroups** (math.GR; math.MG). *Coarse geometry of finitely generated groups and Gromov's
hyperbolic groups.* Objects: quasi-isometries and coarse equivalences, geodesic and quasi-geodesic
spaces, Gromov product, δ-hyperbolic spaces, hyperbolic groups, Gromov boundary and visual metrics,
Dehn presentations, Rips complexes, quasiconvex subgroups. Headlines: Švarc–Milnor; Morse lemma;
quasi-isometry invariance of hyperbolicity; hyperbolic ⇔ linear isoperimetric inequality ⇔ Dehn
presentation; the boundary is compact metrizable and a QI induces a homeomorphism; contractibility
of the Rips complex (finite K(G,1) when torsion-free; finitely many conjugacy classes of finite
subgroups); virtually cyclic centralizers; Gromov's classification of isometries and ping-pong.
Prerequisites: Mathlib `WordMetric`, Cayley graphs; CombinatorialGroupTheory (diagrams); #437.
Serves 246, 252, 254, 255, 257, 258. Size L. Formalizability: Bridson–Haefliger III.H, Ghys–de la Harpe.

**NonpositiveCurvature** (math.GR; math.MG, math.GT). *CAT(κ) geometry and the groups acting on
nonpositively curved spaces, including cube complexes.* Objects: CAT(κ) spaces, comparison
triangles, M_κ-polyhedral complexes and links, geometric actions, semisimple isometries and
translation length, flats, CAT(0) cube complexes and hyperplanes, Salvetti complexes of right-angled
Artin groups, special cube complexes. Headlines: Cartan–Hadamard; Bruhat–Tits fixed point theorem;
CAT(0) groups are finitely presented with quadratic Dehn function; flat torus theorem; solvable
subgroup theorem; Gromov's link condition; RAAGs have finite locally CAT(0) classifying spaces;
Haglund–Wise (special ⇔ local isometry to a RAAG Salvetti complex); Sageev's construction.
Prerequisites: HyperbolicGroups (QI layer), AlgebraicTopology, #437. Serves 249, 252, 254, 257, 258.
Size L. Formalizability: Bridson–Haefliger I–II, Sageev's PCMI notes.

**GroupCohomologyFiniteness** (math.GR; math.AT). *Cohomological and geometric dimension and the
homological and homotopical finiteness properties of discrete groups.* Objects: `cd_R G`, `gd G`,
types FP_n, FP_∞, FL, F_n, F_∞, Euler characteristic, duality and Poincaré duality groups, free
G-CW complexes, Bestvina–Brady height kernels. Headlines: finite cd ⇒ torsion-free; Serre's
finite-index theorem; Eilenberg–Ganea (gd = cd when cd ≥ 3); F_n ⇔ FP_n + finitely presented;
Brown's filtration criterion; Bestvina–Brady Morse theory; Brown–Geoghegan (F is F_∞);
multiplicativity of χ; Stallings–Swan (cd 1 ⇔ free) as the final layer, through the Bass–Serre
layer of CombinatorialGroupTheory. Prerequisites: Mathlib `groupCohomology`, #437 ClassifyingSpaces,
NonpositiveCurvature (cube complexes). Serves 196, 249, 250, 254, 255, 257. Size L.
Formalizability: Brown *Cohomology of Groups* VIII, Geoghegan *Topological Methods*.

**ArtinGroupsAndGarside** (math.GR; math.GT). *Artin–Tits groups of arbitrary Coxeter matrices, their
Garside theory in spherical type, and their Salvetti complexes.* Objects: Artin–Tits groups and
positive monoids (Tau Ceti's `Coxeter/Artin`), Garside monoids and normal forms, spherical-type
Artin groups, Salvetti and Deligne complexes, standard parabolic subgroups, pure Artin groups.
Headlines: positive monoids embed (Paris); Garside normal form and solvable word problem;
Brieskorn–Saito centers; Deligne's K(π,1) theorem for spherical type; van der Lek on parabolic
subgroups and their intersections; Charney–Davis for FC type via the CAT(0) Deligne complex.
Prerequisites: Tau Ceti Coxeter theory, RootSystems, NonpositiveCurvature, #437. Serves 254, 249.
Size L. Formalizability: Dehornoy et al. *Foundations of Garside Theory*; OAI
`Topology/ArtinGroups` (82 k lines) contains a Salvetti cover in `TopCat` and Coxeter parabolic API.

**AmenableGroupsAndGrowth** (math.GR; math.DS, math.FA) — name and core already proposed by the
probability share (Følner, Kesten, Gromov polynomial growth). These families add: Tarski's theorem;
elementary amenable groups; cellular automata, the Garden of Eden theorem and Gottschalk
surjunctivity; sofic groups and Elek–Szabó stable finiteness; Dixmier unitarizability of amenable
groups and Kazhdan's ε-representations; extensive amenability and the Juschenko–Monod theorem as the
summit. Serves 197, 248, 251, 253, 255, 259. Size L. Formalizability: Ceccherini-Silberstein–Coornaert
*Cellular Automata and Groups*, Juschenko *Amenability of Discrete Groups by Examples*.

**MeasuredGroupTheory** (math.DS; math.GR). *Measure-preserving actions of countable groups through
their orbit equivalence relations.* Objects: standard probability spaces, p.m.p. and essentially
free actions, countable Borel equivalence relations, full groups, graphings and treeings, cost,
hyperfinite relations, Bernoulli actions, fixed price. Headlines: Feldman–Moore; Dye's theorem;
Ornstein–Weiss/Connes–Feldman–Weiss (amenable ⇒ hyperfinite); Levitt–Gaboriau (cost of a treeing is
its measure; F_n has fixed price n); cost of amalgams over amenable subgroups; cost ≤ rank.
Prerequisites: ErgodicTheory (probability share), AmenableGroupsAndGrowth, Mathlib measure theory.
Serves 259. Size M. Formalizability: Kechris–Miller *Topics in Orbit Equivalence*.

**NilpotentAndPolycyclicGroups** (math.GR; math.DG). *Structure of nilpotent and polycyclic groups
and their realization as lattices in solvable Lie groups.* Objects: polycyclic and virtually
polycyclic groups, Hirsch length, Fitting subgroup, Mal'cev bases and completions, simply connected
nilpotent and solvable Lie groups, uniform lattices. Headlines: polycyclic ⇔ solvable with max;
invariance of Hirsch length; Auslander–Swan (polycyclic groups are ℤ-linear); Mal'cev's
embedding of torsion-free nilpotent groups as lattices and the rational-structure-constant
criterion; Mostow (lattices in solvable Lie groups are polycyclic and uniform); Bass–Guivarc'h
growth formula. Prerequisites: RepresentationTheory/LieGroups, AmenableGroupsAndGrowth (Gromov),
Mathlib nilpotent/solvable groups. Serves 255. Size L. Formalizability: Segal *Polycyclic Groups*,
Raghunathan Ch. II–IV; OAI `PolycyclicRecognition/Lattices` is a source.

### Logic

**ComputabilityTheory** (math.LO; cs.LO). *Relative computability and the structure of the Turing
degrees, from Mathlib's oracle computations to the basic constructions of degree theory.* Objects:
oracle machines (`RecursiveIn`), Turing degrees, join, jump, arithmetical hierarchy, c.e. degrees,
Π⁰₁ classes, decidable predicates on words. Headlines: jump theorem; Post's theorem; Kleene–Post;
Friedberg–Muchnik (finite-injury priority); Spector's exact pairs and minimal degrees; Friedberg jump
inversion; low basis and cone-avoidance theorems; undecidability of the word problem bridge
(Novikov–Boone in CombinatorialGroupTheory consumes it). MRDP is consumed from LogicAndDefinability
LD.4. Serves 241, 242, 250, 206. Size L. Formalizability: Soare *Turing Computability*; OAI
`DegreeRigidity/Computability` has arithmetic-hierarchy syntax.

**ClassicalModelTheory** (math.LO). *Stability-theoretic model theory of first-order theories and the
categoricity theorems, with abstract elementary classes as the non-elementary extension.* Objects:
types and type spaces (Mathlib), saturated and homogeneous models, ω-stable theories, Morley rank,
indiscernible sequences and Ehrenfeucht–Mostowski models, Erdős–Rado partition relations, Hanf
numbers, abstract elementary classes and LS numbers. Headlines: existence of saturated models;
Ehrenfeucht–Mostowski; Erdős–Rado; Morley's omitting-types bound (Hanf number of ω₁ ↾ ℶ_{ω₁});
Morley's categoricity theorem; Baldwin–Lachlan; Shelah's presentation theorem for AECs.
Prerequisites: Mathlib `ModelTheory`, #41 InfinitaryLogic (it excludes exactly the EM/Erdős–Rado/
Morley–Hanf layer). Serves 240. Size L. Formalizability: Marker Ch. 4–6, Baldwin *Categoricity*.

**ForcingAndIndependence** (math.LO). *Axiomatic set theory as a first-order theory, inner models
and forcing, through the classical independence results.* Objects: ZF/ZFC as `FirstOrder` theories,
relativization, absoluteness, transitive and countable transitive models, the constructible
universe, posets, dense sets, generic filters, P-names, the forcing relation, ccc, Cohen and
product forcing, symmetric extensions. Headlines: Mostowski collapse; Gödel (Con ZF ⇒ Con ZFC+GCH
via L); the generic model theorem and forcing theorem; Δ-system lemma and preservation of cardinals
by ccc forcing; Cohen (Con ZFC ⇒ Con ZFC+¬CH); Cohen's symmetric model (Con ZF ⇒ Con ZF+¬AC).
Prerequisites: Mathlib `SetTheory/ZFC`, cardinals, `ModelTheory`. Serves 244, 240, 241. Size XL.
Formalizability: Kunen; prior art Flypitch (Lean 3) and OAI `SetTheory/PartitionConsistency`.

**LambdaCalculusAndTypeTheory** (cs.LO; math.LO). *Untyped and typed λ-calculi and the metatheory of
pure type systems.* Objects: λ-terms with de Bruijn binding, substitution, β-reduction, pure type
systems `(S, A, R)`, legal terms and contexts, weak and strong normalization. Headlines:
Church–Rosser (Tait–Martin-Löf); standardization; thinning, substitution and subject reduction for
PTS; strong normalization of the simply typed calculus and System F by reducibility candidates;
the Barendregt cube; Girard–Hurkens paradox. Prerequisites: Mathlib relations
(`Relation.ReflTransGen`). Serves 245. Size M. Formalizability: Barendregt, Sørensen–Urzyczyn;
OAI `Computability/TypeSystem` (30 k lines).

**DescriptiveComplexity** (cs.LO; math.LO, cs.CC). *Logics on finite structures and the
correspondence between definability and complexity.* Objects: finite relational structures,
first-order, fixed-point and counting logics, k-pebble games and Weisfeiler–Leman equivalence,
CFI graphs, hereditarily finite sets over a structure, choiceless polynomial time. Headlines:
Fagin's theorem; Immerman–Vardi on ordered structures; pebble games characterize counting-logic
equivalence; Cai–Fürer–Immerman (FPC ≠ PTIME); BGS definition of CPT and its polynomial-time
upper bound. Prerequisites: Mathlib `ModelTheory`, `Computability`; ResourceBoundedComputation
(CS share) for PTIME. Serves 243. Size M.

## (d) Family-by-family

| # | Short title | arXiv primary (theory) | Classification | Key needs |
|---|---|---|---|---|
| 193 | Serre positivity | math.AC | frontier (perfectoid normalized length, almost purity, Land–Tamme descent) | MultiplicitiesAndIntersections (statement), CohenMacaulayRings, PerfectoidSpaces, GeneralAlgebraicKTheory |
| 194 | Lech's conjecture | math.AC | frontier (perfectoid normalized lengths in mixed characteristic) | MultiplicitiesAndIntersections (Hilbert–Samuel, Dutta), Cohen factorization, blowups |
| 195 | No small CM module | math.AC | needs CohenMacaulayRings, AlgebraicAndComplexSurfaces | Bogomolov inequality, Hodge index, regular models |
| 196 | Kaplansky zero divisor | math.GR | needs CombinatorialGroupTheory, GroupCohomologyFiniteness, #437 | pictures, asphericity, finite 2-dim K(G,1) |
| 197 | Direct finiteness, determinant | math.RA | needs GroupRings, AmenableGroupsAndGrowth, GroupVonNeumannAlgebras | sofic groups, Elek–Szabó, FK determinant, finite presentations |
| 198 | Infinite finitistic dimension | math.RT | elementary (Mathlib projective dimension; explicit bound-quiver algebra) | TiltingAndHomologicalDimensions for the named invariant |
| 199 | Auslander–Reiten, Tachikawa | math.RT | needs TiltingAndHomologicalDimensions | #323 Gorenstein-projective, symmetric algebras, trivial extensions |
| 200 | EGH and lex-plus-powers | math.AC | needs GradedFreeResolutions | Macaulay, Clements–Lindström, Betti bounds for stable ideals |
| 201 | Kurosh division ring | math.RA | elementary (statement in Mathlib; proof uses Tau Ceti cyclic algebras plus paper-specific series) | NoncommutativeRingTheory for context |
| 202 | Blockwise Alperin weights | math.RT | needs ModularRepresentationTheory, AlgebraicCurves | blocks, Brauer characters, weights; inseparable genus estimate |
| 203 | Donovan's conjecture | math.RT | frontier (Deligne–Lusztig/ℓ-adic flag varieties, CFSG reduction) | ModularRepresentationTheory, CFSGStatement |
| 204 | Spin(2n) saturation | math.RT | needs LieHighestWeight, SpinRepresentations, CrystalBases | Littelmann paths; KLM buildings as input |
| 205 | Saxl, tensor squares | math.RT | needs SchurWeyl, CharacterTheory (existing) | Kronecker coefficients, polytabloids |
| 206 | Finite lattice representation | math.RA | frontier (O'Nan–Scott/Aschbacher maximal-subgroup theory after CFSG) | UniversalAlgebra, MRDP |
| 207 | ℓ¹-Bass, Kaplansky idempotents | math.RA | needs GroupRings, GroupVonNeumannAlgebras | Hattori–Stallings, K_0, ℓ¹(G) |
| 208 | Symmetric tensor categories | math.QA | frontier (higher Verlinde categories, abelian envelopes) | FiniteTensorCategories, SL₂ tilting in char p |
| 209 | Integral Gersten counterexamples | math.KT | needs GeneralAlgebraicKTheory, SchemeKTheoryOperations (campaign) | G-theory with finite coefficients, Bott/Steinberg lifts |
| 210 | Foulkes, quadratic stabilization | math.RT | needs ClassicalGroups, SchurWeyl (existing; plethysm missing) | Schur positivity, Foulkes–Howe map |
| 240 | Eventual categoricity | math.LO | frontier (Shelah's AEC classification theory) | ClassicalModelTheory; ForcingAndIndependence for the CH corollary |
| 241 | Rigidity of Turing degrees | math.LO | frontier (Slaman–Woodin representation theorem) | ComputabilityTheory, Cohen forcing over ω-models, Baire category |
| 242 | Single-fold Diophantine | math.LO | needs MRDP (campaign LD.4) | ComputabilityTheory |
| 243 | Choiceless polynomial time | cs.LO | needs DescriptiveComplexity | HF sets, counting logics |
| 244 | Partition Principle ⇏ AC | math.LO | needs ForcingAndIndependence | symmetric extensions, product forcing, L |
| 245 | WN ⇒ SN for PTS | cs.LO | needs LambdaCalculusAndTypeTheory | reducibility candidates, Girard–Hurkens |
| 246 | Cannon's conjecture | math.GR | frontier (Bonk–Kleiner uniformization, combinatorial modulus, Sullivan–Tukia) | HyperbolicGroups, #432 KleinianGroups |
| 247 | f.p. residually finite 2-group | math.GR | needs NoncommutativeRingTheory, CombinatorialGroupTheory, Steinberg groups (campaign) | nil graded algebras; property (T) for the corollary |
| 248 | Thompson's F nonamenable | math.GR | needs AmenableGroupsAndGrowth (Følner's theorem) | Thompson's F; Benyamini–Sternfeld (proved in paper) |
| 249 | Eilenberg–Ganea counterexample | math.GR | needs GroupCohomologyFiniteness, NonpositiveCurvature, #437 | RAAG cube complexes, Bestvina–Brady |
| 250 | Boone–Higman with F_∞ | math.GR | frontier (twisted Brin–Thompson groups, Zaremsky's finiteness criterion) | CombinatorialGroupTheory, ComputabilityTheory, GroupCohomologyFiniteness |
| 251 | Unitarizability, Ulam stability | math.GR | needs AmenableGroupsAndGrowth | invariant means, bounded operator cocycles |
| 252 | Hyperbolic, not residually finite | math.GR | needs HyperbolicGroups, NonpositiveCurvature, CombinatorialGroupTheory | Euclidean triangle complexes, Mal'cev |
| 253 | f.p. simple amenable group | math.GR | frontier (topological full groups, extensive amenability) | AmenableGroupsAndGrowth |
| 254 | Artin K(π,1), parabolics, CAT(0) | math.GR | needs ArtinGroupsAndGarside, NonpositiveCurvature, HyperbolicGroups, #437 | Salvetti complex, Deligne's theorem |
| 255 | QI rigidity of polycyclic groups | math.GR | frontier (coarse differentiation, Shalom's measured couplings) | NilpotentAndPolycyclicGroups, Gromov growth, LieGroups |
| 256 | Kervaire, nonsingular systems | math.GR | needs CombinatorialGroupTheory | pictures over free products |
| 257 | Hyperbolic, no CAT(0) action | math.GR | needs HyperbolicGroups, NonpositiveCurvature, CombinatorialGroupTheory | linear filling, geometric actions |
| 258 | One-relator Gersten, specialness | math.GR | frontier (Wise's quasiconvex hierarchy, Agol, negative immersions) | CombinatorialGroupTheory, HyperbolicGroups, NonpositiveCurvature |
| 259 | Group without fixed price | math.DS | needs MeasuredGroupTheory | cost, graphings, Bernoulli actions |

## (e) Reusable OAI Lean infrastructure worth porting

`lean/` is Apache-2.0 and depends on Tau Ceti, so adaptation is licence-compatible; the porting
rules of the README still apply (coordinate, specify the mathematics, improve rather than canonize).
Most files are paper-specific; the general layers worth extracting are:

| OAI path (files / lines) | General content | Target roadmap |
|---|---|---|
| `SetTheory/PartitionConsistency` (75 / 32.6 k) | set-theoretic language and proof calculus, countable ground models, generic filters (`ForcingQuotient.GenericFilter`, `IsGeneric`), forcing names and truth, Cohen/product forcing, symmetric names and support filters | ForcingAndIndependence |
| `Computability/DegreeRigidity` (975 / 84 k) | arithmetic-hierarchy syntax, oracle enumeration, Cohen forcing over countable models, constructibility hierarchy, Slaman–Woodin representation (complete) | ComputabilityTheory, ForcingAndIndependence |
| `Computability/TypeSystem` (33 / 29.5 k) | PTS syntax, β-reduction, `WeaklyNormalizing`/`StronglyNormalizing`, PTS metatheory | LambdaCalculusAndTypeTheory |
| `ModelTheory/Choiceless`, `Computability/WitnessedChoice` (53 / 44.8 k) | hereditarily finite sets over atoms, CPT interpretation semantics | DescriptiveComplexity |
| `ModelTheory/Categoricity`, `AbstractElementary` (16 / 5.3 k) | AEC structure, LS number, categoricity in a cardinal | ClassicalModelTheory |
| `GroupTheory/FiniteType` (136 / 45 k) | CW homotopy extension and cylinders, Whitehead-type extension (`CWWhitehead`), cellular homology of CW complexes, classifying spaces, `HasTypeFInfty` | #437 ClassifyingSpaces, AlgebraicTopology, GroupCohomologyFiniteness |
| `GroupTheory/PolycyclicRecognition/Finiteness` (267 files) | `TypeFP n`, complete cohomology, Poincaré duality for groups, finite projective presentations | GroupCohomologyFiniteness |
| `GroupTheory/PolycyclicRecognition/Lattices`, `/Analysis` (650 files) | lattices in nilpotent and solvable Lie groups, Mal'cev realization, approximate invariant means, coarse equivalences of groups | NilpotentAndPolycyclicGroups, HyperbolicGroups, AmenableGroupsAndGrowth |
| `Topology/ArtinGroups` (881 / 82 k) | `SalvettiCover` as a `TopCat`, Coxeter parabolic and reduced-word API, parabolic closures | ArtinGroupsAndGarside |
| `GroupTheory/ArtinCAT0`, `RightAngledArtin` | `CAT0` predicate, RAAG presentations | NonpositiveCurvature |
| `Geometry/HyperbolicGroups` (422 / 57 k), `GroupTheory/Kervaire` (47 / 11 k) | finite complexes and asphericity, disk diagrams and pictures, relative pictures over free products | CombinatorialGroupTheory |
| `RingTheory/BassTrace` (73 / 24 k) | `ModuleK0`, Hattori–Stallings trace into `ConjClasses G →₀ ℂ` | GroupRings |
| `RingTheory/DirectFiniteness`, `Algebra/OddKaplansky` | Dykema–Juschenko transfer, matrix units in group algebras | GroupRings |
| `Analysis/GroupDeterminants` (34 / 3.3 k) | FK determinant via `τ(log T*T)` on `ℓ²(G)ⁿ` | GroupVonNeumannAlgebras |
| `Analysis/Unitarizability` (39 / 4.1 k) | amenability by invariant means, similarity of bounded representations | AmenableGroupsAndGrowth |
| `RingTheory/Multiplicity` (278 / 54 k) | Čech complexes, coefficient fields of complete local rings, associated-graded reduction, additive lengths, Dutta multiplicity | MultiplicitiesAndIntersections |
| `Algebra/Finitistic`, `AuslanderReiten`, `FinitisticAsymmetry`, `RingTheory/Tachikawa` (1351 / 135 k) | `GorensteinProjective`, `TotallyAcyclic`, explicit resolutions over bound quiver algebras, trivial extensions | TiltingAndHomologicalDimensions |
| `RepresentationTheory/AlperinWeights`, `Block` | block idempotents, coefficient restriction, Brauer block induction (statement level) | ModularRepresentationTheory |
| `RepresentationTheory/RestrictedTilting` (116 / 15.8 k) | SL₂ tilting modules in characteristic p | FiniteTensorCategories |
| `RepresentationTheory/Saxl`, `UniversalSquare`, `FoulkesHowe` | Kronecker coefficients, polytabloid computations, Foulkes–Howe map | SchurWeyl, ClassicalGroups |
| `GroupTheory/PeriodicGroups/Steinberg` | `Steinberg n R` over an arbitrary ring | K2SymbolsBrauer (campaign) |
| `NumberTheory/SingleFold` (28 / 7.6 k) | Diophantine coding of r.e. sets | MRDP owner (LD.4) |

Caveats observed while reading: several comparator statements define standard objects ad hoc
(hyperbolicity through Cayley-graph walks, the Gromov boundary as a quotient of rays with a
pointwise topology, amenability as a `Finset` Følner condition, Turing degrees as an
`Antisymmetrization`). A roadmap should fix one Mathlib-shaped definition and prove these
equivalent to it rather than import them.
