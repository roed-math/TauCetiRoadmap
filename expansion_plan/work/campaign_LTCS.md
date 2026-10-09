# Campaign LTCS: logic, computation and information — phase-2 slate

2026-10-07. Machine-readable slate: `slate_LTCS.json`.

## 1. Scope

**Classes:** math.LO, cs.LO, cs.CC, cs.DS, cs.GT, cs.IT, math.IT.

**Subject.** Mathematical logic (proof theory, computability, model theory, set theory, descriptive set theory, λ-calculus)
and theoretical computer science (machine models, complexity, algorithms, automata and games, quantum computation,
information and coding). The campaign owns the vocabulary for "NP-hard", "time O(n log n)", "Borel complete" and
"independent of ZF", and the theory used to prove such statements.

**Demand.** 176 needs: OpenAI 175, Annals 1 (#98), LMFDB 0. They come from 76 OAI families: 40 TCS, 6 logic, and 30
from ten other subjects (mathematical physics 9, mostly quantum computation; combinatorics 8; number theory 4; probability 3).

| coverage | gap | mathlib | oai-lean | birkbeck | tauceti-roadmap | open-pr | tauceti-code |
|---|---|---|---|---|---|---|---|
| needs | 89 | 43 | 30 | 8 | 2 | 2 | 2 |

- By class: cs.CC 93, math.LO 23, cs.DS 22, cs.LO 16, math.IT 13, cs.IT 6, cs.GT 3. By level: statement 91, proof 85.
- 52 more needs elsewhere carry an LTCS secondary class. Of these, GEO's 9 metric-embedding needs move here under BOUNDARIES.
- Mathlib cannot state 28 OAI families (26 TCS, 174, 178). Its only polynomial-time notion is `TM2ComputableInPolyTime`, with no composition
  theorem, NP, reductions, or space, RAM, randomized or circuit models.
- Tau Ceti has nothing on computation, set theory or descriptive set theory.
- OAI's Lean tree has about 1.8M lines in `Computability`, `SetTheory`, `ModelTheory` and `InformationTheory`, organized
  per paper: Cook–Levin appears 3×, the PCP machinery 6×, Walsh analysis ≥5× and entropy dozens of times.

## 2. Existing supply

| Supply | Covers | Action |
|---|---|---|
| Mathlib | `Computability` (TM0–TM2, `TM2ComputableInPolyTime`, `Partrec`, `REPred`, Rice, `TuringDegree`, many-one degrees, automata); `ModelTheory` (Łoś, compactness, type spaces, ACF); `ZFSet`, cardinals, clubs; Polish and standard Borel spaces; KL divergence, Kraft–McMillan; `pow_dioph`; `ValuedCSP` | consume by name |
| Tau Ceti code | `InformationTheory/KullbackLeibler`, `InformationTheory/Coding` | consume |
| AlgebraicCodingTheory (main, audited complete, archive PR #724; math.IT) | linear codes, MacWilliams, Golay, Construction A. It excludes decoding, bounds and RS/BCH codes | leave; InformationAndCodingTheory starts where it stops |
| #41 InfinitaryLogic (open since 06-27; math.LO) | Lω₁ω, Karp, Scott analysis. It excludes invariant DST and categoricity | **merge soon**: DescriptiveSetTheory waits on it; sibling (or, if its author agrees, member) of MathematicalLogic |
| #717 CertifiedPermutationComputation (open since 10-07; math.GR) | permutation-group certificates with a TM2 polynomial-time verifier. Its Layer 1 proves polynomial-time composition and clocked loops | **reconcile before merge**: composition is stated once, in MachineModels, which #717 cites (or which consumes #717 Layer 1 by alias) |
| #257 EquitableOperatorReduction; #258/#259 quantum walks (math.CO) | equitable partitions without WL; walk dynamics | DescriptiveComplexity builds WL on #257; QuantumComputation consumes #258/#259 |
| #419 ECM; #260 StructuredBlockOperators | no running times; structured-matrix arithmetic costs | leave (NT; an instance of straight-line programs) |
| RealAlgebraicGeometry (main; math.AG) | CAD, real quantifier elimination | supplier: o-minimality of ℝ, ∃ℝ |
| Birkbeck LogicAndDefinabilityInNumberTheory (math.LO under coordination §3.3) | LD.0–LD.6: valued fields, motivic integration, MRDP, o-minimality | **split by stage**: LD.4 → ComputabilityTheory; LD.6 foundations and Pila–Wilkie → FirstOrderModelTheory; LD.0 consumes Mathlib; LD.1–LD.3, LD.5 stay as a consumer (ValuedFieldsAndMotivicIntegration) |
| Birkbeck ComputationalNumberTheory CN.0 (cs.DS) | bit, precision and randomness models | consume MachineModels; CN.1 consumes AlgebraicAlgorithms |

Supply in territory still to be implemented: about 185 PRs (#41 ~60, #717 ~40, LD ~85). There are no explorer drafts in LTCS
territory.

## 3. The slate

### 3.0 Design pin: one model of computation

**Question.** Which model makes "X is NP-hard" and "no polynomial-time algorithm unless P = NP" statable once, robustly,
and usable everywhere?

**What exists.**
- **Mathlib.** `Turing.FinTM2` is a multi-stack machine whose input alphabet `Γ k₀` alone must be finite;
  `TM2ComputableInTime`/`TM2ComputableInPolyTime` measure time as a `Polynomial ℕ`; the compilations TM2→TM1→TM0 and
  Partrec→TM2 carry no time bounds; `FinEncoding` covers `List Bool` and pairs (#32367). #7172 (2025) added
  `proof_wanted TM2ComputableInPolyTime.comp` (run one machine, copy its output, run the next); the pinned Mathlib has
  neither it nor the theorem. (No local Zulip archive exists; this is from Mathlib's git history.)
- **OAI.** `Superstring/BitCode` is a structured `Block` language over `List Bool` registers with cost semantics `Exec`;
  `RunsInPolyTime.comp` proves composition and `certificate` compiles to `TM2ComputableInPolyTime` with finite alphabets.
  The hardness comparators each redefine `FiniteAlphabet`, `NPVerifier`, `InNP` and `GapReduction`. Cook–Levin is proved
  three times; `DirectedFeedback/CookLevin/NPTableau` does it directly on TM2 by window locality of stack configurations,
  so TM2 serves as the reduction model.
  `WeisfeilerLeman.lean` has an O(log n)-word RAM, `Logspace` a read-only-input machine with a coin tape, and
  `EditApproximation.lean` value-and-work pairs.
- **#717 Layer 1:** TM2 composition and clocked loops.
- **Precedents:** Isabelle AFP *Cook_Levin* (Balbach 2023; multitape TMs with combinators); Coq's weak call-by-value
  λ-calculus as a reasonable model (Forster–Kunze–Roth 2020), with Cook–Levin through it (Gäher–Kunze 2021).

**Recommendation.** Pin this in the ComputationalComplexity index and in MachineModels.
1. **Problems** live on `List Bool`, reached through Mathlib `FinEncoding`. MachineModels proves that classes closed under
   FP preprocessing are invariant under polynomially inter-convertible encodings.
2. **Time model:** Mathlib `FinTM2` and `TM2ComputableIn(Poly)Time`, with the side condition `∀ k, Finite (tm.Γ k)`.
   - OAI's statements and #717 then match by unfolding.
   - If Mathlib strengthens `FinTM2`, the side condition is deleted.
   - Fine-grained bounds use `Asymptotics.IsBigO` along `atTop`.
3. **Programming layer:** a bit-stack block language with cost semantics, compiled with exact overhead.
   - Every upper-bound proof goes through it.
   - Composition and clocked loops are proved once.
   - An interpreter gives universal machines.
4. **Space and fine-grained models.**
   - A Tau Ceti multitape machine: finite alphabet; two-way read-only input; work tapes on `Turing.Tape`; optional
     output, oracle and read-once random tapes; a nondeterministic variant.
   - It and TM2 simulate each other in linear time, so P agrees. L, NL, RL, BPL and PSPACE live on it, and the one-tape
     machine is its k = 1 case.
   - A word RAM with word size ≥ log₂ n and a coin instruction, polynomially equivalent to TM2, carries algorithm bounds.
   - Bit complexity is stated on the multitape machine; operation counts on straight-line programs.
5. **Randomness** is an explicit polynomial-length uniform string, with the time bound on every string (#717's seed
   contract). Space-bounded randomness reads the string once.
6. **Circuits:** Boolean circuits (MachineModels), arithmetic circuits (AlgebraicComplexity) and quantum circuits
   (QuantumComputation), each made uniform through FP.
7. **ComplexityClasses** defines classes and reductions once.
   - "NP-hard" means every NP language Karp-reduces to the problem.
   - "Unless P = NP" is the implication `X ∈ P → P = NP`.
   - P ≠ NP, ETH, SETH and UGC are `Prop`-valued definitions, used as hypotheses, never axioms.
8. **Robustness milestones:** FP agrees for TM2, multitape, one-tape, word RAM and block programs; encoding and alphabet
   invariance; FP ⊆ Mathlib `Computable`.

**Neighbours.**
- Cost-annotated functional code (OAI's work counters, Lean cost monads) is a usable front end once compiled to the word
  RAM.
- The λ-calculus route is equally sound.
- TM2 is chosen because Mathlib's polynomial-time vocabulary and every complexity statement in reach (OAI, #717) already
  use it.

### 3.1 Overview

Three XL families and three L roadmaps. A family is an index README with member roadmaps, like RepresentationTheory. Each
index lands with its first members in one PR; later members are reviewed against the index's boundaries.

| # | Roadmap | Topic | Size | PRs | Wave | OAI fams |
|---|---|---|---|---|---|---|
| 1 | ComputationalComplexity | cs.CC | XL family | 1530 | A | 35 |
| 1.1 | ↳ MachineModels | cs.CC | L | 250 | A | 20 |
| 1.2 | ↳ ComplexityClasses | cs.CC | L | 280 | B | 17 |
| 1.3 | ↳ SpaceAndPseudorandomness | cs.CC | M | 140 | B | 4 |
| 1.4 | ↳ BooleanCircuitsAndCommunication | cs.CC | L | 180 | B | 2 |
| 1.5 | ↳ PCPAndHardnessOfApproximation | cs.CC | L | 320 | C | 7 |
| 1.6 | ↳ AlgebraicComplexity | cs.CC | L | 220 | A | 7 |
| 1.7 | ↳ DescriptiveComplexity | cs.CC | M | 140 | A | 2 |
| 2 | Algorithms | cs.DS | XL family | 750 | A | 20 |
| 2.1 | ↳ CombinatorialAlgorithms | cs.DS | L | 250 | B | 6 |
| 2.2 | ↳ AlgebraicAlgorithms | cs.DS | M | 130 | B | 3 |
| 2.3 | ↳ OnlineAlgorithms | cs.DS | M | 110 | A | 2 |
| 2.4 | ↳ MetricEmbeddingsAndConvexRelaxations | cs.DS | L | 260 | A | 10 |
| 3 | MathematicalLogic | math.LO | XL family | 1230 | A | 12 + Annals #98 |
| 3.1 | ↳ FirstOrderProofTheory | math.LO | M | 110 | A | 2 |
| 3.2 | ↳ ComputabilityTheory | math.LO | L | 220 | A | 6 |
| 3.3 | ↳ FirstOrderModelTheory | math.LO | L | 260 | A | 4 |
| 3.4 | ↳ SetTheoryAndForcing | math.LO | L | 300 | A | 4 |
| 3.5 | ↳ DescriptiveSetTheory | math.LO | L | 220 | A | 1 + Annals #98 |
| 3.6 | ↳ LambdaCalculusAndTypeTheory | math.LO | M | 120 | A | 1 |
| 4 | QuantumComputation | cs.CC | L | 220 | A | 7 |
| 5 | InformationAndCodingTheory | cs.IT | L | 250 | A | 18 |
| 6 | AutomataLogicAndGames | cs.LO | L | 230 | A | 4 |

Waves: **A** startable on Mathlib, Tau Ceti and merged roadmaps; **B** needs a wave-A roadmap (any campaign) or an open PR
first; **C** deeper. A roadmap's wave is set by its first layers; later layers that cite a sibling or another campaign's
proposal show it under Prerequisites.

### 3.2 Roadmaps

#### 1. `ComputationalComplexity` — cs.CC · XL family · ~1530 PRs · wave A

This family develops computational complexity on Mathlib's `Computability`: machine models, complexity classes, space and pseudorandomness, circuits and communication, PCPs and hardness of approximation, algebraic complexity, and descriptive complexity. Its index pins the conventions of §3.0, so 'polynomial time' and 'NP-hard' are defined once for every campaign. Algorithms, quantum computation and automata are separate roadmaps. Boolean Fourier analysis, expanders and polyhedra are imported from COMB and ANA.

- **Members:** MachineModels (L, 250), ComplexityClasses (L, 280), SpaceAndPseudorandomness (M, 140), BooleanCircuitsAndCommunication (L, 180), PCPAndHardnessOfApproximation (L, 320), AlgebraicComplexity (L, 220), DescriptiveComplexity (M, 140).
- **Goals (union of members):** OpenAI 35.

#### 1.1 `ComputationalComplexity/MachineModels` — cs.CC · L · ~250 PRs · wave A

*Merges:* ResourceBoundedComputation.

This roadmap makes 'computable in time T', 'in polynomial time' and 'in space S' usable statements. It fixes canonical binary encodings through Mathlib's `FinEncoding` and adopts Mathlib's `FinTM2` with `TM2ComputableInTime`/`TM2ComputableInPolyTime`, every alphabet finite, as the time model. It supplies a structured bit-stack language compiled to `FinTM2` with exact cost, in which every upper bound is proved. It defines the multitape machine with read-only input (space, oracle, nondeterministic and random-tape variants), the one-tape machine, the word RAM and uniform Boolean circuits, and proves the simulations that make FP, P and PSPACE model-independent. Other classes belong to ComplexityClasses and algorithms to the Algorithms family.

- **Milestones:** (1) encoding invariance; binary arithmetic, comparison and parsing in polynomial time; (2) compiler correctness with exact cost; FP closed under composition and clocked loops; (3) TM2 ↔ multitape in linear time; one-tape O(T²); Hennie–Stearns O(T log T); (4) word RAM ↔ TM2 polynomially, so FP is model-independent; (5) circuit evaluation in P; uniform O(T²)-size circuits for time-T machines; (6) universal machine; time and space hierarchy theorems; FP ⊆ Mathlib `Computable`.
- **Prerequisites:** Mathlib Computability. **Goals:** OpenAI 20: 102–104, 109, 110, 112, 113, 115, 116, 120–122, 124, 125, 128, 133, 138, 142, 174, 178.
- **Porting:** OAI Computability/Superstring (block language, composition, TM2 certificate); the private TM2 libraries of the six OAI hardness projects (consolidate); OAI comparator WeisfeilerLeman.lean (word RAM), Computability/Logspace; #717 Layer 1. **Formalizability:** High: OAI already compiles a block language into TM2ComputableInPolyTime.

#### 1.2 `ComputationalComplexity/ComplexityClasses` — cs.CC · L · ~280 PRs · wave B

This roadmap defines the classes and reductions of structural complexity theory on MachineModels, for decision, promise, search and counting problems. The classes are P, NP, coNP, PH, PSPACE, EXP, NEXP, BPP, RP, ZPP, P/poly, #P, PP, ⊕P, IP, TFNP with PLS, PPA and PPAD, and ∃ℝ. The reductions are Karp, log-space, Turing, parsimonious and gap-preserving, and the approximation vocabulary is PTAS, FPTAS, APX, FPRAS and FPAUS. P ≠ NP, ETH, SETH and the Unique Games Conjecture are named `Prop`s used only as hypotheses. L and NL are defined here and developed in SpaceAndPseudorandomness. PCP-based hardness is PCPAndHardnessOfApproximation, and rapid-mixing FPRAS constructions are PRDS's.

- **Milestones:** (1) Cook–Levin for SAT, 3SAT and circuit-SAT; Karp's catalogue (CLIQUE, IS, VC, 3-COL, HAM-CYCLE, SUBSET-SUM, PARTITION, BIN-PACKING, MAX-CUT, SET-COVER, EXACT-COVER); (2) TQBF PSPACE-complete; succinct EXP/NEXP-completeness; Ladner; Baker–Gill–Solovay; (3) BPP/RP amplification; Adleman; Sipser–Gács–Lautemann; Karp–Lipton; Valiant–Vazirani; (4) #P-completeness of the 0-1 permanent; JVV counting–sampling equivalence; (5) IPZ sparsification and ETH lower bounds; End-of-Line and Sperner in PPAD; NP ⊆ ∃ℝ; (6) IP = PSPACE; Toda's theorem.
- **Prerequisites:** ComputationalComplexity/MachineModels; Mathlib ValuedCSP; RealAlgebraicGeometry. **Goals:** OpenAI 17: 102, 105, 106, 112–115, 117, 118, 121, 125, 128, 131, 133, 136, 138, 141.
- **Porting:** OAI comparators DirectedFeedback, BinPackingGap, VertexCover (NPVerifier, GapReduction), MatchingFPRAS; the three OAI Cook–Levin proofs (DirectedFeedback, BinPacking, KMedian). **Formalizability:** High: three Lean proofs of Cook–Levin on TM2 exist.

#### 1.3 `ComputationalComplexity/SpaceAndPseudorandomness` — cs.CC · M · ~140 PRs · wave B

*Merges:* SpaceBoundedComputationAndDerandomization.

This roadmap develops space-bounded computation on the multitape machine and the pseudorandomness that derandomizes it. Its objects are configuration graphs, the classes L, NL, RL and BPL, k-wise independent families, ε-biased spaces, extractors, and pseudorandom generators for space-bounded machines. It ends with time–space simulations. Expander constructions are imported from COMB's ExpanderGraphs; cryptographic pseudorandomness is outside the family.

- **Milestones:** (1) Savitch; NL-completeness of reachability; Immerman–Szelepcsényi; (2) BPL ⊆ L²; leftover hash lemma; Nisan and INW generators; Saks–Zhou; (3) Reingold SL = L; (4) Hopcroft–Paul–Valiant; Cook–Mertz tree evaluation; Williams' √(t log t) simulation.
- **Prerequisites:** ComputationalComplexity/ComplexityClasses; COMB ExpanderGraphs (proposed). **Goals:** OpenAI 4: 103, 112, 116, 137.
- **Porting:** OAI Computability/Logspace. **Formalizability:** High; Reingold needs the zig-zag spectral bound.

#### 1.4 `ComputationalComplexity/BooleanCircuitsAndCommunication` — cs.CC · L · ~180 PRs · wave B

*Merges:* BooleanCircuitComplexity.

This roadmap proves lower bounds for nonuniform and communication models. The models are the circuit classes NCⁱ, ACⁱ, ACC⁰ and TC⁰ with their uniform variants, monotone circuits, formulas, branching programs, finite-memory streaming models, and deterministic, nondeterministic and randomized two-party protocols. Its methods are counting, random restrictions, polynomial approximation, the approximation method, rank, discrepancy and information complexity. Decision-tree and sensitivity measures are COMB's BooleanFunctionAnalysis.

- **Milestones:** (1) Shannon–Lupanov; Håstad's switching lemma and the optimal depth-d parity bound; (2) Razborov–Smolensky; Paturi–Pudlák–Zane depth-3 bounds; (3) Razborov monotone clique; Andreev; Khrapchenko; Nechiporuk; shrinkage; Barrington; (4) rank, fooling-set and discrepancy bounds; disjointness via information complexity; Karchmer–Wigderson; (5) Razborov–Rudich natural proofs.
- **Prerequisites:** ComputationalComplexity/MachineModels; InformationAndCodingTheory; COMB BooleanFunctionAnalysis (proposed). **Goals:** OpenAI 2: 112, 140.
- **Porting:** OAI Computability/DepthThree (25k lines), GeneralizedCircuits. **Formalizability:** High; combinatorial throughout.

#### 1.5 `ComputationalComplexity/PCPAndHardnessOfApproximation` — cs.CC · L · ~320 PRs · wave C

*Merges:* HardnessOfApproximation.

This roadmap proves the PCP theorem and the classical inapproximability results as gap-preserving reductions in ComplexityClasses' sense. Its objects are constraint satisfaction problems on Mathlib's `ValuedCSP` vocabulary, projection games and Label Cover, Hadamard and long codes, assignment testers and unique games. Its tools are property testing, gap amplification, parallel repetition and Fourier analysis of tests; UGC-conditional results are implications from the named hypothesis. Fourier analysis and expanders come from COMB, codes from InformationAndCodingTheory.

- **Milestones:** (1) BLR linearity and Reed–Muller low-degree tests; (2) PCP theorem with perfect completeness by Dinur gap amplification; (3) parallel repetition: Raz, Holenstein, Rao, Dinur–Steurer; (4) Håstad 3-bit test: Max-3LIN, Max-3SAT 7/8; Feige ln n Set Cover; (5) UGC ⇒ KKMO Max-Cut and Khot–Regev Vertex Cover; (6) Khot–Minzer–Safra Grassmann expansion and 2-to-2 hardness (final).
- **Prerequisites:** ComputationalComplexity/ComplexityClasses; InformationAndCodingTheory; COMB BooleanFunctionAnalysis, ExpanderGraphs (proposed). **Goals:** OpenAI 7: 102, 105, 106, 117, 118, 125, 136.
- **Porting:** OAI UniqueGames/PCP and its five copies; OAI VertexCover/Repetition, VertexCover/Fourier, UniqueGames/Inverse (KMS). **Formalizability:** Proven feasible by OAI six times; the value is consolidation.

#### 1.6 `ComputationalComplexity/AlgebraicComplexity` — cs.CC · L · ~220 PRs · wave A

*Merges:* AlgebraicComplexityTheory.

This roadmap develops algebraic complexity over a commutative ring or field. Its models are straight-line programs, arithmetic circuits and formulas, and algebraic branching programs. It covers bilinear complexity and tensor rank with the exponent ω of matrix multiplication, linear circuits for the DFT, VP and VNP, partial-derivative measures, and polynomial identity testing. Uniformity statements use MachineModels; Boolean counting complexity is ComplexityClasses; fast algorithms with bit-cost bounds are Algorithms/AlgebraicAlgorithms.

- **Milestones:** (1) homogenization and division elimination; Baur–Strassen; VSBR depth reduction; (2) Strassen; Schönhage τ-theorem; asymptotic spectrum; laser method with Coppersmith–Winograd tensors; (3) Cooley–Tukey; Morgenstern's bounded-coefficient bound; (4) Valiant's VNP-completeness of the permanent; Mignon–Ressayre; (5) Nisan's noncommutative ABP theorem; homogeneous depth-4 bounds; Raz–Shpilka PIT.
- **Prerequisites:** Mathlib MvPolynomial, TensorProduct, SchwartzZippel; ComputationalComplexity/MachineModels (uniformity layer). **Goals:** OpenAI 7: 107–109, 116, 130, 135, 141.
- **Porting:** OAI LinearAlgebra/MatrixMultiplication (83k lines), LinearAlgebra/MatrixFields (182k); OAI Computability/FourierCircuit, RationalHitting. **Formalizability:** High; OAI holds the tensor and Coppersmith–Winograd machinery.

#### 1.7 `ComputationalComplexity/DescriptiveComplexity` — cs.CC · M · ~140 PRs · wave A

*Merges:* WeisfeilerLemanAndCountingLogics.

This roadmap relates definability on finite structures to complexity, on Mathlib's `FirstOrder.Language`. Its objects are finite structures and their encodings, first-order, fixed-point, transitive-closure and counting logics, Ehrenfeucht–Fraïssé and bijective pebble games, and the Weisfeiler–Leman algorithm in both conventions, built on #257's equitable partitions. It also covers Cai–Fürer–Immerman graphs and choiceless polynomial time over hereditarily finite sets. Model theory of infinite structures is MathematicalLogic.

- **Milestones:** (1) EF games; Gaifman and Hanf locality; the 0–1 law; (2) Fagin; Immerman–Vardi; FO(TC) = NL on ordered structures; (3) Cᵏ ↔ pebble games ↔ WL (Immerman–Lander); Tinhofer; Dvořák and Dell–Grohe–Rattan; (4) Cai–Fürer–Immerman; Blass–Gurevich–Shelah CPT ⊆ P.
- **Prerequisites:** Mathlib ModelTheory; ComputationalComplexity/ComplexityClasses (from Fagin on); #257 EquitableOperatorReduction; COMB StructuralGraphTheory (treewidth; proposed). **Goals:** OpenAI 2: 133, 243.
- **Porting:** OAI Combinatorics/VariableWL, ParityLifts, Computability/WeisfeilerLeman, WLIdentification; OAI ModelTheory/Choiceless, Computability/WitnessedChoice. **Formalizability:** High; OAI has WL in both conventions and CFI-type lifts.

#### 2. `Algorithms` — cs.DS · XL family · ~750 PRs · wave A

This family develops algorithms with correctness and running-time proofs. It has four members: combinatorial, algebraic and online algorithms, and the metric embeddings and convex relaxations behind approximation algorithms. Every running-time claim names its MachineModels model (word RAM by default) and is a theorem about code in MachineModels' program layer. Existence theorems are imported: flows from #444, matching from COMB, LP duality and polyhedra from ANA. Hardness belongs to ComputationalComplexity.

- **Members:** CombinatorialAlgorithms (L, 250), AlgebraicAlgorithms (M, 130), OnlineAlgorithms (M, 110), MetricEmbeddingsAndConvexRelaxations (L, 260).
- **Goals (union of members):** OpenAI 20.

#### 2.1 `Algorithms/CombinatorialAlgorithms` — cs.DS · L · ~250 PRs · wave B

This roadmap develops combinatorial algorithms on the word RAM, each with a correctness and a running-time theorem. It covers data structures with amortized bounds, sorting and selection, graph search and shortest paths, minimum spanning trees, and flow and matching algorithms on #444's existence theory. It continues with dynamic programming, randomized and exponential-time techniques, and the standard approximation-algorithm templates. Almost-linear max-flow is outside the family.

- **Milestones:** (1) heaps, search trees, union–find (inverse Ackermann); Ω(n log n) sorting; linear selection; (2) BFS/DFS, SCC, Dijkstra, Bellman–Ford, Floyd–Warshall, MST; (3) Edmonds–Karp, Dinic, push–relabel, min-cost flow; Hopcroft–Karp; Edmonds' blossom; (4) edit distance, LCS, knapsack, Bellman–Held–Karp; Freivalds; Karger; MVV isolation lemma; colour coding; Schroeppel–Shamir; (5) greedy Set Cover H_n; LP rounding and primal–dual; Christofides; k-median local search; Coffman–Graham.
- **Prerequisites:** ComputationalComplexity/MachineModels; #444 GraphConnectivityAndFlows; COMB StructuralGraphTheory (proposed); ANA PolyhedralCombinatorics (proposed). **Goals:** OpenAI 6: 120, 121, 124, 125, 128, 138.
- **Porting:** OAI comparators EditDistance, EditApproximation, TreeEdit; OAI Computability/Scheduling, DeterministicSum, Combinatorics/KMedian. **Formalizability:** High once the word-RAM program layer exists.

#### 2.2 `Algorithms/AlgebraicAlgorithms` — cs.DS · M · ~130 PRs · wave B

*Merges:* FastAlgebraicAlgorithms.

This roadmap develops fast exact algorithms for integers and polynomials. Bit-complexity bounds are on the multitape machine and operation counts are in AlgebraicComplexity's model. It covers fast multiplication and FFTs, Newton iteration and division, evaluation, interpolation and remaindering, fast GCD, and factorization over finite fields. Number-theoretic algorithms (primality, ECM, class groups) are NT's and consume this roadmap.

- **Milestones:** (1) Karatsuba, Toom–Cook, Schönhage–Strassen; (2) Cooley–Tukey, Bluestein, Rader, Nussbaumer; Newton division; multipoint evaluation; fast CRT; half-GCD; (3) distinct-degree, Berlekamp, Cantor–Zassenhaus; Hensel lifting; Bareiss; (4) Harvey–van der Hoeven O(n log n) multiplication (final).
- **Prerequisites:** ComputationalComplexity/MachineModels; ComputationalComplexity/AlgebraicComplexity. **Goals:** OpenAI 3: 109, 130, 142.
- **Porting:** OAI Computability/FourierCircuit; coordinate with Birkbeck ComputationalNumberTheory CN.0–CN.1. **Formalizability:** High; the final milestone is long.

#### 2.3 `Algorithms/OnlineAlgorithms` — cs.DS · M · ~110 PRs · wave A

This roadmap develops competitive analysis and online decision-making. It covers online algorithms against oblivious and adaptive adversaries, Yao's principle, paging, k-server and metrical task systems, online primal–dual and matching, and optimal stopping with secretary problems and prophet inequalities. Minimax comes from AutomataLogicAndGames, FRT trees from MetricEmbeddingsAndConvexRelaxations, and probability and matroids from Mathlib.

- **Milestones:** (1) Yao's principle; ski rental; Sleator–Tarjan; marking H_k; (2) double coverage on trees; work-function algorithm 2k−1; HST-based randomized k-server and MTS; (3) online primal–dual; RANKING 1−1/e; (4) secretary 1/e; Krengel–Sucheston–Garling; Samuel-Cahn; Kleinberg–Weinberg matroid prophet inequality.
- **Prerequisites:** Mathlib probability, Matroid; AutomataLogicAndGames (minimax); Algorithms/MetricEmbeddingsAndConvexRelaxations (FRT). **Goals:** OpenAI 2: 110, 111.
- **Porting:** none known. **Formalizability:** High; finite probability.

#### 2.4 `Algorithms/MetricEmbeddingsAndConvexRelaxations` — cs.DS · L · ~260 PRs · wave A

*Merges:* ConvexRelaxationsAndMetricEmbeddings, MetricEmbeddings (GEO report).

This roadmap develops the geometry behind approximation algorithms. Its metric side covers embeddings of finite metric spaces: distortion, ℓ₁ and the cut cone, negative type, dimension reduction, hierarchically separated trees, Poincaré-inequality obstructions and doubling spaces. Its relaxation side covers the LP, SDP and sum-of-squares relaxations these embeddings round, and their integrality gaps. Banach-space invariants (type, cotype, Ribe) are FAMP's; LP and SDP duality are ANA's.

- **Milestones:** (1) Fréchet, Bourgain; Johnson–Lindenstrauss; ℓ₁ = cut cone; (2) Poincaré inequalities, expanders Ω(log n), Enflo; Assouad; Brinkman–Charikar; FRT; (3) Linial–London–Rabinovich flow–cut gap; (4) Goemans–Williamson α_GW; Lovász θ; Karger–Motwani–Sudan; (5) SOS proofs and pseudo-expectations; Grigoriev's 3XOR bound; (6) Arora–Rao–Vazirani (final).
- **Prerequisites:** Mathlib normed spaces, Lp, PosSemidef; #444; COMB ExpanderGraphs (proposed); ANA PolyhedralCombinatorics, convex optimization (proposed). **Goals:** OpenAI 10: 089, 094, 098, 099, 102, 110, 117, 122, 126, 307.
- **Porting:** OAI comparators BoundedTreewidthL1, MatchingPSD. **Formalizability:** High; ARV is long but classical.

#### 3. `MathematicalLogic` — math.LO · XL family · ~1230 PRs · wave A

This family develops mathematical logic downstream of Mathlib's `ModelTheory`, `Computability` and `SetTheory`: proof theory, computability, model theory, set theory and forcing, descriptive set theory, and the λ-calculus. Its index pins the conventions. Theories are written in Mathlib's `FirstOrder.Language` syntax, with no private formula types, and models of set theory are structures on transitive subsets of `ZFSet`. Gödel numbering goes through `Primcodable`, and relative consistency is stated both by `IsSatisfiable` and proof-theoretically. Infinitary logic is the sibling #41; finite model theory is DescriptiveComplexity.

- **Members:** FirstOrderProofTheory (M, 110), ComputabilityTheory (L, 220), FirstOrderModelTheory (L, 260), SetTheoryAndForcing (L, 300), DescriptiveSetTheory (L, 220), LambdaCalculusAndTypeTheory (M, 120).
- **Goals (union of members):** OpenAI 12; Annals #98.

#### 3.1 `MathematicalLogic/FirstOrderProofTheory` — math.LO · M · ~110 PRs · wave A

This roadmap gives Mathlib's first-order syntax a proof calculus and develops its metatheory. It covers derivations, soundness and completeness, cut elimination and its corollaries, and arithmetization of syntax. It treats Robinson's Q and Peano arithmetic, representability, and the incompleteness and undefinability theorems. Ordinal analysis is outside the family.

- **Milestones:** (1) soundness; Gödel completeness by Henkin in every cardinality; (2) cut elimination; Herbrand; Craig interpolation; Beth; (3) Σ₁-completeness of Q; representability; Gödel I and Rosser; (4) derivability conditions; Gödel II; Löb; Tarski; Church.
- **Prerequisites:** Mathlib ModelTheory, Computability. **Goals:** OpenAI 2: 240, 244.
- **Porting:** coordinate with FormalizedFormalLogic/Foundation (Lean 4); Flypitch (Lean 3). **Formalizability:** High; a complete Lean 4 precedent exists outside Mathlib.

#### 3.2 `MathematicalLogic/ComputabilityTheory` — math.LO · L · ~220 PRs · wave A

*Merges:* LogicAndDefinabilityInNumberTheory LD.4.

This roadmap develops relative computability and degree theory from Mathlib's `Nat.RecursiveIn` and `TuringDegree`. It covers the jump and the arithmetical hierarchy, many-one and one-one degrees, priority constructions, the structure of the Turing degrees, and Π⁰₁ classes with basis theorems. It also covers Diophantine sets with Hilbert's tenth problem and undecidable combinatorial problems. Word problems for groups are ALG's CombinatorialGroupTheory, which consumes this roadmap.

- **Milestones:** (1) jump theorem; Kleene normal form; Σₙ₊₁ = c.e. in ∅⁽ⁿ⁾; (2) Myhill isomorphism; creative and simple sets; (3) Kleene–Post; Friedberg–Muchnik; Sacks splitting; Spector minimal degree; exact pairs; Friedberg jump inversion; (4) low, hyperimmune-free and cone-avoiding basis theorems; (5) MRDP from Mathlib `pow_dioph`; Post correspondence and Post–Markov; Partrec ↔ Turing machines.
- **Prerequisites:** Mathlib Computability, NumberTheory/Dioph. **Goals:** OpenAI 6: 004, 206, 241, 242, 250, 376.
- **Porting:** OAI Computability/DegreeRigidity (84k lines); Coq Library of Undecidability Proofs; Isabelle MRDP (precedents); Birkbeck LD.4. **Formalizability:** High; Mathlib already has the hardest MRDP step.

#### 3.3 `MathematicalLogic/FirstOrderModelTheory` — math.LO · L · ~260 PRs · wave A

*Merges:* ClassicalModelTheory, LogicAndDefinabilityInNumberTheory LD.6 (foundations).

This roadmap develops the model theory of first-order theories on Mathlib's `ModelTheory`. It covers types, countable and saturated models, quantifier elimination, ω-stability and Morley rank, indiscernibles, categoricity, and abstract elementary classes. It ends with o-minimal structures through the Pila–Wilkie counting theorem. Infinitary logic is #41; valued fields and motivic integration stay with LogicAndDefinabilityInNumberTheory; real quantifier elimination is RealAlgebraicGeometry.

- **Milestones:** (1) omitting types; Ryll-Nardzewski; Vaught; prime and saturated models; QE for DLO and ACF; (2) ω-stability and Morley rank; EM models via Erdős–Rado; Morley–Hanf bound; (3) Morley categoricity; Baldwin–Lachlan; Shelah's presentation theorem for AECs; (4) monotonicity, cell decomposition, dimension, definable choice; ℝ o-minimal; Pila–Wilkie (final).
- **Prerequisites:** Mathlib ModelTheory; RealAlgebraicGeometry; MathematicalLogic/SetTheoryAndForcing (Erdős–Rado). **Goals:** OpenAI 4: 004, 016, 143, 240.
- **Porting:** OAI ModelTheory/Categoricity, AbstractElementary; Birkbeck LD.6. **Formalizability:** High (Marker, van den Dries); Pila–Wilkie is long.

#### 3.4 `MathematicalLogic/SetTheoryAndForcing` — math.LO · L · ~300 PRs · wave A

*Merges:* ForcingAndIndependence.

This roadmap develops axiomatic set theory as a first-order theory, combinatorial set theory, inner models and forcing through the classical independence results. Its objects are ZF and ZFC as Mathlib theories, absoluteness and countable transitive models in `ZFSet`, the constructible universe, posets, names and generic extensions, symmetric extensions, and measurable cardinals. It covers Cohen, random, product and finite-support iterated forcing. Relative consistency is stated model-theoretically and, through FirstOrderProofTheory, proof-theoretically.

- **Milestones:** (1) Fodor on Mathlib's stationary sets; Δ-system; Erdős–Rado; (2) reflection; Mostowski collapse; L ⊨ AC + GCH; (3) forcing theorem; generic model theorem; ccc preservation; (4) Con(ZFC + ¬CH) by Cohen forcing; random forcing; Cohen's symmetric model of ZF + ¬AC; (5) MA + ¬CH by finite-support iteration; ultrapowers; Scott's V ≠ L.
- **Prerequisites:** Mathlib SetTheory, ModelTheory; MathematicalLogic/FirstOrderProofTheory (proof-theoretic statements). **Goals:** OpenAI 4: 240, 241, 244, 323.
- **Porting:** OAI SetTheory/PartitionConsistency (33k lines), PartitionPrinciple (234k, mostly paper-specific), Computability/DegreeRigidity; Flypitch; Isabelle/ZF forcing. **Formalizability:** High; three formalizations of forcing exist.

#### 3.5 `MathematicalLogic/DescriptiveSetTheory` — math.LO · L · ~220 PRs · wave A

*Merges:* InvariantDescriptiveSetTheory.

This roadmap develops classical and invariant descriptive set theory on Mathlib's Polish spaces and `StandardBorelSpace`. The classical part covers the Borel and projective pointclasses, regularity properties, and infinite games with determinacy. The invariant part covers Polish group actions, the space Mod(L) of countable structures with the logic action, Borel reducibility, countable Borel equivalence relations, and Borel completeness with the Friedman–Stanley jump. Measure-theoretic orbit equivalence is PRDS's MeasuredGroupTheory.

- **Milestones:** (1) Borel hierarchy with universal sets; perfect set theorem for analytic sets; Π¹₁ ranks; (2) Kuratowski–Ulam; Gale–Stewart; Martin's Borel determinacy; (3) Becker–Kechris; López-Escobar (from #41); (4) Silver; Glimm–Effros and Harrington–Kechris–Louveau; Feldman–Moore; hyperfiniteness; (5) Friedman–Stanley: graphs, linear orders, groups and fields Borel complete, isomorphism not Borel, the jump; Ulm invariants.
- **Prerequisites:** Mathlib Polish spaces, StandardBorelSpace, Baire, SetTheory/Descriptive; #41 InfinitaryLogic. **Goals:** OpenAI 1: 241; Annals #98.
- **Porting:** no Lean source known (Kechris; Gao). **Formalizability:** High; Mathlib's Polish-space library carries the first layers, and only the López-Escobar layer waits on #41.

#### 3.6 `MathematicalLogic/LambdaCalculusAndTypeTheory` — math.LO · M · ~120 PRs · wave A

This roadmap develops untyped and typed λ-calculi and the metatheory of pure type systems. It covers binding and substitution, reduction and confluence, λ-definability, normalization of typed calculi by reducibility, the λ-cube and Curry–Howard. Lean's own kernel metatheory is outside the family.

- **Milestones:** (1) de Bruijn substitution lemmas; Church–Rosser; standardization; (2) λ-definable = Mathlib `Partrec`; (3) Tait strong normalization; System F by Girard's candidates; (4) PTS thinning, substitution, subject reduction, uniqueness of types; λ-cube; Girard–Hurkens.
- **Prerequisites:** Mathlib Relation, Partrec. **Goals:** OpenAI 1: 245.
- **Porting:** OAI Computability/TypeSystem (30k lines). **Formalizability:** High (Barendregt; Sørensen–Urzyczyn).

#### 4. `QuantumComputation` — cs.CC · L · ~220 PRs · wave A

This roadmap develops quantum computation in the circuit model on Mathlib's finite-dimensional Hilbert spaces, with states and channels from FAMP's QuantumInformationTheory. It covers gate sets, circuits, measurement and the diamond norm, universality and approximation, and the standard algorithms. It then treats BQP, QMA and local Hamiltonians, quantum query complexity, and nonlocal games. Uniformity is MachineModels'; entropies and capacities are FAMP's; quantum walks are #258/#259.

- **Milestones:** (1) reversible simulation; universality of {H, T, CNOT}; Solovay–Kitaev; (2) Deutsch–Jozsa, Simon; QFT, phase estimation, Shor; Grover and exact amplitude amplification; (3) BPP ⊆ BQP ⊆ PP; Marriott–Watrous; Kitaev local Hamiltonian; perturbative gadgets; QAC⁰; (4) polynomial and adversary methods; Forrelation; (5) CHSH, Tsirelson's bound, entangled value.
- **Prerequisites:** Mathlib matrices and unitary groups; ComputationalComplexity/ComplexityClasses (BQP, QMA layer); FAMP QuantumInformationTheory (channel layer; proposed); COMB BooleanFunctionAnalysis (query layer; proposed). **Goals:** OpenAI 7: 274, 275, 277, 279, 281, 283, 284.
- **Porting:** OAI InformationTheory/QuantumCircuit; OAI Computability/QuantumFactoring (54k lines). **Formalizability:** High; finite-dimensional linear algebra.

#### 5. `InformationAndCodingTheory` — cs.IT · L · ~250 PRs · wave A

*Merges:* ShannonInformationTheory.

This roadmap develops Shannon theory and error-correcting codes beyond AlgebraicCodingTheory. Its information side covers information measures of discrete and continuous random variables on Mathlib's KL divergence, their inequalities and strong data-processing constants, typicality, the source and channel coding theorems, and entropy counting. Its coding side covers the classical code bounds, the standard algebraic and combinatorial code families, and unique, list and local decoding. Quantum information is FAMP's; ergodic-theoretic entropy is PRDS's.

- **Milestones:** (1) chain rules; Shearer; Fano; Pinsker; data processing; Rényi; (2) SDPI for BSC and BEC; differential entropy; maximum entropy; EPI; (3) AEP; source coding (Kraft–McMillan, Huffman); channel coding theorem and converse; Brégman via entropy; (4) Singleton, Hamming, Plotkin, GV, Elias–Bassalygo, Johnson; Delsarte LP bound; (5) RS, RM, BCH, concatenated, Justesen, expander codes; Berlekamp–Welch; Guruswami–Sudan; local decoding.
- **Prerequisites:** Mathlib InformationTheory, binEntropy; AlgebraicCodingTheory (completed); Tau Ceti InformationTheory/KullbackLeibler. **Goals:** OpenAI 18: 007, 028, 074, 102, 113, 117, 119, 122, 136, 139, 140, 157, 167, 170, 213, 220, 229, 277.
- **Porting:** PFR entropy library (coordinate first); OAI VertexCover/Information, InformationTheory/{BooleanNoise,SoftChannel}. **Formalizability:** High; mature sources exist.

#### 6. `AutomataLogicAndGames` — cs.LO · L · ~230 PRs · wave A

*Merges:* AutomataAndFiniteSemigroups, GamesOnGraphs.

This roadmap develops automata, their algebra and logic, and games on graphs, on Mathlib's `DFA`, `NFA` and regular expressions. Its automata part covers two-way automata and state complexity, syntactic monoids and Green's relations, logical characterizations of regular and star-free languages, star height, and ω-automata with determinization. Its games part covers finite zero-sum games, arenas and strategies, parity, mean-payoff, energy and stochastic games, and Maker–Breaker games. Borel determinacy is DescriptiveSetTheory's.

- **Milestones:** (1) Shepherdson 2DFA = DFA with state bounds; determinization state complexity; (2) Schützenberger; McNaughton–Papert; Büchi–Elgot–Trakhtenbrot; Krohn–Rhodes; Eggan; generalized star height; (3) Büchi complementation; McNaughton and Safra determinization; (4) von Neumann minimax; positional determinacy of parity (Zielonka) and mean-payoff games; Shapley; Blackwell; (5) strategy improvement; Calude–Jain–Khoussainov–Li–Stephan quasipolynomial parity; Erdős–Selfridge.
- **Prerequisites:** Mathlib Computability; ComputationalComplexity/MachineModels (running times). **Goals:** OpenAI 4: 104, 129, 134, 187.
- **Porting:** OAI Combinatorics/TwoWayAutomata, Combinatorics/Automata, Computability/StarHeight, Computability/MeanPayoff. **Formalizability:** High (Grädel–Thomas–Wilke; Pin).


## 4. Needs not absorbed

Every gap need is absorbed except these:

| Need (refs) | Rows | Reason |
|---|---|---|
| Query measures, sensitivity, PTFs (#127, #132); Walsh analysis (#274, #284) | 5 | COMB BooleanFunctionAnalysis (pre-decided); imported by BooleanCircuits, PCP, QuantumComputation |
| Quantum Shannon theory (#273, #276) | 2 | FAMP QuantumInformationTheory (pre-decided) |
| Approximate counting (#113–#115, #131) | 4 | Split: JVV and the FPRAS/FPAUS definitions go to ComplexityClasses; rapid-mixing FPRAS, annealing and CFTP go to PRDS MarkovChainMixing |
| Almost-linear max-flow (#120) | 1 | frontier (Chen–Kyng–Liu–Peng–Probst Gutenberg–Sachdeva) |
| Shelah's AEC classification: good frames, tameness (#240) | 1 | frontier; FirstOrderModelTheory stops at the presentation theorem |
| Real-valued measurable cardinals (#323) | 1 | frontier input; SetTheoryAndForcing supplies random forcing and measurables |

Also recorded: Khot–Minzer–Safra (#102, #105) is PCP's final milestone; Slaman–Woodin (#241) is frontier, with a full OAI
Lean proof (§6 Q3); certified computation (#107, #119, #158, #187, #189) is Lean tooling; ∃ℝ ⊆ PSPACE for #141 needs the
critical-point method, to be requested from AG as an extension of RealAlgebraicGeometry.

## 5. Cross-campaign interface

**Imports.**
- COMB:
  - BooleanFunctionAnalysis goes into PCP, BooleanCircuits and QuantumComputation.
  - ExpanderGraphs goes into Space (Reingold), PCP (Dinur) and MetricEmbeddings.
  - StructuralGraphTheory (matching, treewidth) and #444 flows go into CombinatorialAlgorithms, DescriptiveComplexity and
    MetricEmbeddings.
- ANA: PolyhedralCombinatorics and SDP duality go into CombinatorialAlgorithms and MetricEmbeddings.
- FAMP: QuantumInformationTheory goes into QuantumComputation. Banach-space geometry (type, cotype, Ribe, Heisenberg
  non-embedding) is the boundary of MetricEmbeddings.
- AG: RealAlgebraicGeometry goes into FirstOrderModelTheory and ComplexityClasses.
- PRDS: concentration (#397) goes into randomized algorithms.

**Exports.**
- MachineModels and ComplexityClasses go to every campaign stating complexity results: COMB 174 and 178; NT
  ComputationalNumberTheory and #419; PRDS MarkovChainMixing (FPRAS, JVV); ALG certified group computation (#717).
- InformationAndCodingTheory goes to PRDS (finite chain rules for EntropyAndThermodynamicFormalism, OAI#145–153;
  broadcasting, #229 and #236; differential entropy), COMB (157, 167, 170) and FAMP (the classical layer).
- ComputabilityTheory goes to ALG CombinatorialGroupTheory (word problems, #250).
- DescriptiveSetTheory goes to PRDS MeasuredGroupTheory and ErgodicTheory (CBERs, #212, #231, #236, #259).
- FirstOrderModelTheory goes to NT (Pila–Zannier, the LD remainder) and ALG UniversalAlgebra.
- MetricEmbeddings goes to GEO (089, 094, 098, 099) and TOP OperatorKTheory (307).

**Boundaries to confirm:** GEO plans no separate MetricEmbeddings (doubling spaces and Assouad are here); COMB owns
decision-tree and sensitivity measures; PRDS consumes ComplexityClasses' FPRAS definitions.

## 6. Order and people

**First five units,** ranked by demand × unblocking under the cap of three open campaign PRs:
1. **ComputationalComplexity index + MachineModels + ComplexityClasses:** makes 28 OAI families statable, consolidates six
   OAI hardness projects, settles the #717 overlap.
2. **InformationAndCodingTheory:** 18 families in six subjects; supplier to PRDS, COMB, FAMP and PCP; wave A.
3. **MathematicalLogic index + DescriptiveSetTheory + ComputabilityTheory:** the only Annals need (#98), MRDP, supplies
   ALG; wave A, one layer waits on #41.
4. **Algorithms index + MetricEmbeddingsAndConvexRelaxations + CombinatorialAlgorithms:** 16 families, GEO's 5 included.
5. **AlgebraicComplexity and PCPAndHardnessOfApproximation:** 7 families each; the first is wave A, the second is the largest
   consolidation of OAI code.

Then: QuantumComputation, AutomataLogicAndGames, SpaceAndPseudorandomness, BooleanCircuits, DescriptiveComplexity, and the
remaining logic and algorithms members.

**Expertise.**
- **Lead:** a complexity theorist fluent in Lean's Turing-machine library.
- **Reviewers:** (a) structural complexity and PCP; (b) algorithms and approximation; (c) logic, probably two people (set
  theory and DST; model theory and computability); (d) information and coding theory; (e) quantum computation.
- **Coordinate first with:** Bolton Bailey (#7172), Tanner Duve and Elan Roth (Turing degrees), Aaron Anderson (model
  theory), Violeta Hernández Palacios (set theory), Cameron Freer (#41), vincentqb (#717), the OpenAI Lean authors, the PFR
  authors, and FormalizedFormalLogic/Foundation and Flypitch.

**Open questions for the owner.**
1. **The §3.0 pin.** Should Mathlib `FinTM2` with a finite-alphabet condition be the time reference model, rather than a Tau
   Ceti multitape model for time and space?
2. **#717 Layer 1.** Who owns composition and clocked loops? Recommended: MachineModels.
3. **OAI's claimed proofs.** OAI marks "The Unique Games Theorem" (102) and Slaman–Woodin (241) as formalized. The slate
   treats UGC as a hypothesis and stops PCP at Khot–Minzer–Safra. Adopting OAI's proofs as final milestones, once they
   check against these definitions, is the owner's call.
4. **Granularity.** Three XL families (7 + 4 + 6 members) or 17 separate roadmaps? Recommended: families.
5. **Birkbeck.** Agree the LD stage split with him.
6. **BOUNDARIES.** No disagreement. GEO should note that metric embeddings, including their geometric layer, are LTCS's.

## 7. Totals

| | count | est. PRs |
|---|---|---|
| XL families (index READMEs; PRs counted in members) | 3 | 3,510 |
| L roadmaps (11 members + 3 standalone) | 14 | 3,460 |
| M roadmaps (members) | 6 | 750 |
| **New roadmap READMEs** | **20 + 3 indexes** | **4,210** |
| Existing territory supply to implement (#41, #717, Birkbeck LD) | 3 | ~185 |

- The slate covers 75 OAI families and Annals #98.
- The 6 primary families it leaves out belong to COMB, FAMP or tooling.
- An umbrella row's `est_prs` in the JSON is the sum of its members.

## 8. References by roadmap

23 roadmap records, 232 listings, 206 distinct works; full entries, identifiers, access and verification are in `references_master.md` (cited here by short form) and `references_master.json`; the machine records are `refs_LTCS.json` and the `references` fields of `slate_LTCS.json`, each carrying `master_key` and `verified`. (?) marks a work not verified in the 2026-10-08 pass (154 of 206: zbMATH stopped early; see master (d)). Pointers are the compilers' and are unverified.

**Conventions and notes.** Corrections to §3.0 found while pinning the formal sources: the pinned Mathlib carries `proof_wanted TM2ComputableInPolyTime.comp` (Bailey, #7172), moved by #42284 to `Wanted/Computability/TuringMachine/Computable.lean` outside `Mathlib/`, and the theorem itself is absent; `FinEncoding` is no longer a structure (#37928 unbundled the alphabet to `Encoding α Γ` with `[Fintype Γ]`, leaving `FinEncoding` a deprecated alias, and #34779 made `TM2ComputableInPolyTime` take encoding functions `α → List αΓ`), so §3.0 item 1 should read "through Mathlib `Encoding α Γ` with `[Fintype Γ]`"; `FinTM2` requires `[Fintype (Γ k₀)]` only, and TM files now live in `Mathlib/Computability/TuringMachine/` (#35608; old paths deprecated by #35609). No LTCS book or paper is held locally.

**ComputationalComplexity** (umbrella, wave A)
- primary: Arora–Barak 2009, *Computational Complexity*, Ch. 1, Ch. 2, Ch. 4 (?); Goldreich 2008, *Computational Complexity* (?)
- conventions: van Emde Boas 1990, *Machine models and simulations* (?)
- formal: Mathlib `Computability/TuringMachine/{Computable, …}`; Mathlib `Computability/Encoding`; leanprover-community/mathlib4 PR #7172

**ComputationalComplexity/MachineModels** (wave A)
- primary: Arora–Barak 2009, *Computational Complexity*, Ch. 1, Ch. 3, Ch. 4 (?)
- conventions: van Emde Boas 1990, *Machine models and simulations* (?); Hagerup 1998, *Sorting and searching on the word RAM* (?)
- theorem: Hennie–Stearns 1966, *Two-tape simulation of multitape Turing…* (?); Cook–Reckhow 1973, *Time bounded random access machines* (?)
- formal: Mathlib `Computability/TuringMachine/{Computable, …}`; Mathlib `Computability/Encoding`; leanprover-community/mathlib4 PR #7172; leanprover-community/mathlib4 PR #32367; leanprover-community/mathlib4 PR #34779; leanprover-community/mathlib4 PR #37928; OAI `Computability/Superstring`; OAI `Computability/DirectedFeedback/CookLevin`; OAI `Computability/Logspace/Deterministic`; OAI `ComparatorChallenges/WeisfeilerLeman`; Tau Ceti 2026, *CertifiedPermutationComputation, Layer…*; AFP `Cook_Levin`; Forster–Kunze–Roth 2020, *Weak call-by-value λ-calculus is…* (?)

**ComputationalComplexity/ComplexityClasses** (wave B)
- primary: Arora–Barak 2009, *Computational Complexity*, Ch. 2, Ch. 3, Ch. 4 (?); Papadimitriou 1994, *Computational Complexity* (?)
- conventions: Goldreich 2008, *Computational Complexity* (?); Ausiello et al. 1999, *Complexity and Approximation* (?); Impagliazzo–Paturi 2001, *Complexity of k-SAT* (?); Schaefer 2010, *Complexity of some geometric and…* (?)
- theorem: Garey–Johnson 1979, *Computers and Intractability* (?); Jerrum–Valiant–Vazirani 1986, *Random generation of combinatorial…* (?); Impagliazzo–Paturi–Zane 2001, *Which problems have strongly…* (?); Papadimitriou 1994, *Complexity of the parity argument and…* (?); Johnson et al. 1988, *How easy is local search?* (?)
- formal: OAI `ComparatorChallenges/{DirectedFeedback, BinPackingGap, …}`; OAI `Computability/DirectedFeedback/CookLevin`; AFP `Cook_Levin`; Gäher–Kunze 2021, *Mechanising complexity theory* (?)

**ComputationalComplexity/SpaceAndPseudorandomness** (wave B)
- primary: Arora–Barak 2009, *Computational Complexity*, Ch. 4, Ch. 21 (?); Vadhan 2012, *Pseudorandomness* (?)
- theorem: Nisan 1992, *Pseudorandom generators for…* (?); Impagliazzo–Nisan–Wigderson 1994, *Pseudorandomness for network algorithms* (?); Saks–Zhou 1999, *BP_H SPACE(S) ⊆ DSPACE(S^{3/2})* (?); Hopcroft–Paul–Valiant 1977, *Time versus space* (?); Cook–Mertz 2024, *Tree evaluation is in space O(log n ·…* (?); Williams 2025, *Simulating time with square-root space* (?)
- formal: OAI `Computability/Logspace/Deterministic`

**ComputationalComplexity/BooleanCircuitsAndCommunication** (wave B)
- primary: Jukna 2012, *Boolean Function Complexity* (?); Arora–Barak 2009, *Computational Complexity*, Ch. 6, Ch. 13, Ch. 14 (?); Kushilevitz–Nisan 1997, *Communication Complexity* (?); Rao–Yehudayoff 2020, *Communication Complexity and…* (?)
- theorem: Mix Barrington 1989, *Bounded-width polynomial-size branching…* (?)
- formal: OAI `Computability/DepthThree`

**ComputationalComplexity/PCPAndHardnessOfApproximation** (wave C)
- primary: Arora–Barak 2009, *Computational Complexity*, Ch. 11, Ch. 22 (?); O'Donnell 2014, *Analysis of Boolean Functions*, Ch. 1, Ch. 7, Ch. 11 (?)
- conventions: Khot 2002, *Power of unique 2-prover 1-round games* (?)
- theorem: Rubinfeld–Sudan 1996, *Robust characterizations of polynomials…* (?); Dinur 2007, *PCP theorem by gap amplification* (?); Raz 1998, *Parallel repetition theorem* (?); Holenstein 2009, *Parallel repetition* (?); Rao 2011, *Parallel repetition in projection games…* (?); Dinur–Steurer 2014, *Analytical approach to parallel…* (?); Håstad 2001, *Some optimal inapproximability results* (?); Feige 1998, *Threshold of ln n for approximating set…* (?); Khot et al. 2007, *Optimal inapproximability results for…* (?); Khot–Regev 2008, *Vertex cover might be hard to…* (?); Dinur et al. 2018, *Towards a proof of the 2-to-1 games…* (?); Khot–Minzer–Safra 2023, *Pseudorandom sets in Grassmann graph…* (?)
- statement: OpenAI 2026, *The-Unique-Games-Theorem-September-23-20…* (OAI#102), §6
- formal: Mathlib `Combinatorics/Optimization/ValuedCSP`; OAI `Computability/UniqueGames/{PCP, Inverse}`; OAI `Computability/VertexCover/{Repetition, Fourier, …}`

**ComputationalComplexity/AlgebraicComplexity** (wave A)
- primary: Bürgisser–Clausen–Shokrollahi 1997, *Algebraic Complexity Theory* (?); Bürgisser 2000, *Completeness and Reduction in Algebraic…* (?); Shpilka–Yehudayoff 2010, *Arithmetic circuits* (?); Saptharishi 2021, *Survey of lower bounds in arithmetic…* (?)
- theorem: Strassen 1988, *Asymptotic spectrum of tensors* (?); Mignon–Ressayre 2004, *Quadratic bound for the determinant and…* (?); Nisan 1991, *Lower bounds for non-commutative…* (?); Raz–Shpilka 2005, *Deterministic polynomial identity…* (?)
- formal: Mathlib `Algebra/MvPolynomial/SchwartzZippel`; OAI `LinearAlgebra/MatrixMultiplication`; OAI `Computability/FourierCircuit`; OAI `Computability/RationalHitting`

**ComputationalComplexity/DescriptiveComplexity** (wave A)
- primary: Libkin 2004, *Finite Model Theory* (?); Immerman 1999, *Descriptive Complexity* (?); Grohe 2017, *Descriptive Complexity, Canonisation…* (?)
- theorem: Cai–Fürer–Immerman 1992, *Optimal lower bound on the number of…* (?); Blass–Gurevich–Shelah 1999, *Choiceless polynomial time* (?); Dvořák 2010, *Recognizing graphs by numbers of…* (?); Dell–Grohe–Rattan 2018, *Lovász meets Weisfeiler and Leman* (?); Scheinerman–Ullman 1997, *Fractional Graph Theory* (?)
- formal: Mathlib `ModelTheory`; OAI `Combinatorics/{VariableWL, ParityLifts}`; OAI `ModelTheory/Choiceless`

**Algorithms** (umbrella, wave A)
- primary: Cormen et al. 2022, *Algorithms* (?); Williamson–Shmoys 2011, *Design of Approximation Algorithms* (?); Motwani–Raghavan 1995, *Randomized Algorithms* (?)
- formal: Mathlib `Computability/AkraBazzi`

**Algorithms/CombinatorialAlgorithms** (wave B)
- primary: Cormen et al. 2022, *Algorithms*, Chs. 8–9, Ch. 14, Ch. 16 (?); Schrijver 2003, *Combinatorial Optimization* (?); Williamson–Shmoys 2011, *Design of Approximation Algorithms* (?); Motwani–Raghavan 1995, *Randomized Algorithms* (?); Cygan et al. 2015, *Parameterized Algorithms* (?)
- theorem: Schroeppel–Shamir 1981, *T = O(2^{n/2}), S = O(2^{n/4})…* (?); Coffman–Graham 1972, *Optimal scheduling for two-processor…* (?); Grötschel–Lovász–Schrijver 1988, *Geometric Algorithms and Combinatorial…* (?)
- formal: OAI `ComparatorChallenges/{EditDistance, EditApproximation, …}`; OAI `Computability/{Scheduling, DeterministicSum}`

**Algorithms/AlgebraicAlgorithms** (wave B)
- primary: von zur Gathen–Gerhard 2013, *Modern Computer Algebra*, Ch. 8, Ch. 9, Ch. 10 (?); Shoup 2009, *Computational Introduction to Number…*; Knuth 1997, *Art of Computer Programming, Vol. 2*, §4.3.3 (?)
- theorem: Nussbaumer 1982, *Fast Fourier Transform and Convolution…* (?); Bareiss 1968, *Sylvester's identity and multistep…* (?); Harvey–van der Hoeven 2021, *Integer multiplication in time O(n log…* (?)
- formal: OAI `Computability/FourierCircuit`

**Algorithms/OnlineAlgorithms** (wave A)
- primary: Borodin–El-Yaniv 1998, *Online Computation and Competitive…* (?); Buchbinder–Naor 2009, *Design of competitive online algorithms…* (?)
- theorem: Koutsoupias–Papadimitriou 1995, *K-server conjecture* (?); Bartal et al. 1997, *Polylog(n)-competitive algorithm for…* (?); Bansal et al. 2015, *Polylogarithmic-competitive algorithm…* (?); Karp–Vazirani–Vazirani 1990, *Optimal algorithm for on-line bipartite…* (?); Ferguson 1989, *Who solved the secretary problem?* (?); Samuel-Cahn 1984, *Comparison of threshold stop rules and…* (?); Kleinberg–Weinberg 2019, *Matroid prophet inequalities and…* (?)

**Algorithms/MetricEmbeddingsAndConvexRelaxations** (wave A)
- primary: Matoušek 2002, *Discrete Geometry*, Ch. 15 (?); Matoušek 2013, *Metric embeddings* (?); Deza–Laurent 1997, *Geometry of Cuts and Metrics* (?); Williamson–Shmoys 2011, *Design of Approximation Algorithms*, Ch. 6, Chs. 8 and 15 (?); Barak–Steurer 2016, *Proofs, beliefs, and algorithms through…* (?)
- theorem: Linial–London–Rabinovich 1995, *Geometry of graphs and some of its…* (?); Fakcharoenphol–Rao–Talwar 2004, *Tight bound on approximating arbitrary…* (?); Brinkman–Charikar 2005, *Impossibility of dimension reduction in…* (?); Heinonen 2001, *Analysis on Metric Spaces* (?); Grigoriev 2001, *Linear lower bound on degrees of…* (?); Arora–Rao–Vazirani 2009, *Expander flows, geometric embeddings…* (?)
- formal: OAI `ComparatorChallenges/{BoundedTreewidthL1, MatchingPSD}`

**MathematicalLogic** (umbrella, wave A)
- primary: Shoenfield 1967, *Mathematical Logic* (?); Barwise 1977, *Handbook of Mathematical Logic* (?)
- formal: Mathlib `ModelTheory`; Mathlib `SetTheory/{ZFC, Cardinal, Ordinal}`; Mathlib `Computability/{Partrec, PartrecCode, Primrec, Halting, …}`

**MathematicalLogic/FirstOrderProofTheory** (wave A)
- primary: Shoenfield 1967, *Mathematical Logic* (?); Ebbinghaus–Flum–Thomas 2021, *Mathematical Logic* (?); Troelstra–Schwichtenberg 2000, *Basic Proof Theory* (?); Hájek–Pudlák 1993, *Metamathematics of First-Order…* (?)
- formal: `FormalizedFormalLogic/Foundation`; Han–van Doorn 2020, *Formal proof of the independence of the…* (?); Mathlib `ModelTheory`

**MathematicalLogic/ComputabilityTheory** (wave A)
- primary: Soare 2016, *Turing Computability* (?); Soare 1987, *Recursively Enumerable Sets and Degrees* (?); Lerman 1983, *Degrees of Unsolvability* (?)
- theorem: Jockusch–Soare 1972, *Π⁰₁ classes and degrees of theories* (?); Matiyasevich 1993, *Hilbert's Tenth Problem* (?); Davis 1958, *Computability and Unsolvability* (?)
- statement: OpenAI 2026, *Rigidity-of-the-Turing-degrees-September…* (OAI#241)
- formal: Mathlib `Computability/{Partrec, PartrecCode, Primrec, Halting, …}`; OAI `Computability/DegreeRigidity`; Forster et al. 2020, *Coq library of undecidable problems* (?); Bayer et al. 2019, *DPRM theorem in Isabelle (short paper)* (?)

**MathematicalLogic/FirstOrderModelTheory** (wave A)
- primary: Marker 2002, *Model Theory* (?); Tent–Ziegler 2012, *Model Theory* (?); Baldwin 2009, *Categoricity* (?); van den Dries 1998, *Tame Topology and o-minimal Structures* (?); Pila 2022, *Point-Counting and the Zilber-Pink…*
- theorem: Pila–Wilkie 2006, *Rational points of a definable set* (?)
- formal: Mathlib `ModelTheory`; OAI `ModelTheory/Categoricity`

**MathematicalLogic/SetTheoryAndForcing** (wave A)
- primary: Kunen 1980, *Set Theory*, Ch. II, Chs. III–VI, Ch. VII (?); Jech 2003, *Set Theory*, Ch. 8, Ch. 9, Ch. 10 (?); Jech 1973, *Axiom of Choice* (?)
- formal: Han–van Doorn 2020, *Formal proof of the independence of the…* (?); Independence of the continuum…; OAI `SetTheory/PartitionConsistency`; OAI `Computability/DegreeRigidity`; Mathlib `SetTheory/{ZFC, Cardinal, Ordinal}`

**MathematicalLogic/DescriptiveSetTheory** (wave A)
- primary: Kechris 1995, *Classical Descriptive Set Theory*, §20 (?); Gao 2009, *Invariant Descriptive Set Theory* (?); Becker–Kechris 1996, *Descriptive Set Theory of Polish Group…* (?); Kechris–Miller 2004, *Orbit Equivalence* (?)
- conventions: Moschovakis 2009, *Descriptive Set Theory* (?)
- theorem: Friedman–Stanley 1989, *Borel reducibility theory for classes…* (?)
- statement: Paolini–Shelah 2024, *Torsion-free abelian groups are Borel…* (?); Thomas 2003, *Classification problem for torsion-free…* (?)
- formal: Mathlib `Topology/MetricSpace/Polish`

**MathematicalLogic/LambdaCalculusAndTypeTheory** (wave A)
- primary: Barendregt 1984, *Lambda Calculus* (?); Barendregt 1992, *Lambda calculi with types* (?); Sørensen–Urzyczyn 2006, *Curry–Howard Isomorphism* (?); Girard–Lafont–Taylor 1989, *Proofs and Types* (?)
- conventions: de Bruijn 1972, *Lambda calculus notation with nameless…* (?)
- theorem: Takahashi 1995, *Parallel reductions in λ-calculus* (?); Hurkens 1995, *Simplification of Girard's paradox* (?)
- formal: OAI `Computability/TypeSystem`

**QuantumComputation** (wave A)
- primary: Nielsen–Chuang 2010, *Quantum Computation and Quantum…*, Ch. 4, Ch. 5, Ch. 6 (?); Kitaev–Shen–Vyalyi 2002, *Classical and Quantum Computation* (?)
- conventions: Watrous 2018, *Theory of Quantum Information* (?)
- theorem: Adleman–DeMarrais–Huang 1997, *Quantum computability* (?); Marriott–Watrous 2005, *Quantum Arthur–Merlin games* (?); Kempe–Kitaev–Regev 2006, *Complexity of the local Hamiltonian…* (?); Beals et al. 2001, *Quantum lower bounds by polynomials* (?); Ambainis 2002, *Quantum lower bounds by quantum…* (?); Aaronson–Ambainis 2018, *Forrelation* (?); Cleve et al. 2004, *Consequences and limits of nonlocal…* (?)
- formal: OAI `InformationTheory/QuantumCircuit`; OAI `Computability/QuantumFactoring`; Lean-QuantumInfo (Lean 4 library for…

**InformationAndCodingTheory** (wave A)
- primary: Cover–Thomas 2006, *Information Theory*, Ch. 2, Ch. 3, Ch. 5 (?); Csiszár–Körner 2011, *Information Theory* (?); Guruswami–Rudra–Sudan 2023, *Essential Coding Theory*; MacWilliams–Sloane 1977, *Theory of Error-Correcting Codes* (?)
- conventions: Polyanskiy–Wu 2025, *Information Theory* (?)
- theorem: Chung et al. 1986, *Some intersection theorems for ordered…* (?); Radhakrishnan 1997, *Entropy proof of Bregman's theorem* (?)
- formal: `teorth/pfr`; Mathlib `InformationTheory/KullbackLeibler`; Tau Ceti `InformationTheory/{KullbackLeibler/{Convex, Tilted}`; OAI `Computability/VertexCover/Information`

**AutomataLogicAndGames** (wave A)
- primary: Grädel–Thomas–Wilke 2002, *Automata, Logics, and Infinite Games* (?); Pin 2020, *Mathematical Foundations of Automata…* (?); Straubing 1994, *Finite Automata, Formal Logic, and…* (?); Perrin–Pin 2004, *Infinite Words* (?); Filar–Vrieze 1997, *Competitive Markov Decision Processes* (?); Beck 2008, *Combinatorial Games* (?)
- theorem: Shepherdson 1959, *Reduction of two-way automata to…* (?); Krohn–Rhodes 1965, *Algebraic theory of machines. I. Prime…* (?); Eggan 1963, *Transition graphs and the star-height…* (?); Ehrenfeucht–Mycielski 1979, *Positional strategies for mean payoff…* (?); Calude et al. 2022, *Deciding parity games in…* (?)
- formal: Mathlib `Computability/{Language, DFA, NFA, EpsilonNFA, …}`; Mathlib `Topology/Sion`; OAI `Combinatorics/{TwoWayAutomata, Automata}`

**Acquisition list** (not free and not held locally; books needed by a wave-A roadmap, and any work needed by two or more roadmaps of this campaign; journal papers otherwise left to library access, all listed in master (b2); roadmap count in brackets; ★ = wave A): Arora–Barak 2009, *Computational Complexity* [6] ★; Cormen et al. 2022, *Algorithms* [2] ★; van Emde Boas 1990, *Machine models and simulations* [2] ★; Goldreich 2008, *Computational Complexity* [2] ★; Motwani–Raghavan 1995, *Randomized Algorithms* [2] ★; Shoenfield 1967, *Mathematical Logic* [2] ★; Baldwin 2009, *Categoricity* [1] ★; Barendregt 1984, *Lambda Calculus* [1] ★; Barwise 1977, *Handbook of Mathematical Logic* [1] ★; Beck 2008, *Combinatorial Games* [1] ★; Becker–Kechris 1996, *Descriptive Set Theory of Polish Group…* [1] ★; Borodin–El-Yaniv 1998, *Online Computation and Competitive…* [1] ★; Bürgisser 2000, *Completeness and Reduction in Algebraic…* [1] ★; Bürgisser–Clausen–Shokrollahi 1997, *Algebraic Complexity Theory* [1] ★; Cover–Thomas 2006, *Information Theory* [1] ★; Csiszár–Körner 2011, *Information Theory* [1] ★; Davis 1958, *Computability and Unsolvability* [1] ★; Deza–Laurent 1997, *Geometry of Cuts and Metrics* [1] ★; van den Dries 1998, *Tame Topology and o-minimal Structures* [1] ★; Ebbinghaus–Flum–Thomas 2021, *Mathematical Logic* [1] ★; Filar–Vrieze 1997, *Competitive Markov Decision Processes* [1] ★; Gao 2009, *Invariant Descriptive Set Theory* [1] ★; Grädel–Thomas–Wilke 2002, *Automata, Logics, and Infinite Games* [1] ★; Grohe 2017, *Descriptive Complexity, Canonisation…* [1] ★; Hájek–Pudlák 1993, *Metamathematics of First-Order…* [1] ★; Heinonen 2001, *Analysis on Metric Spaces* [1] ★; Immerman 1999, *Descriptive Complexity* [1] ★; Jech 1973, *Axiom of Choice* [1] ★; Jech 2003, *Set Theory* [1] ★; Kechris 1995, *Classical Descriptive Set Theory* [1] ★; Kechris–Miller 2004, *Orbit Equivalence* [1] ★; Kitaev–Shen–Vyalyi 2002, *Classical and Quantum Computation* [1] ★; Kunen 1980, *Set Theory* [1] ★; Lerman 1983, *Degrees of Unsolvability* [1] ★; Libkin 2004, *Finite Model Theory* [1] ★; MacWilliams–Sloane 1977, *Theory of Error-Correcting Codes* [1] ★; Marker 2002, *Model Theory* [1] ★; Matiyasevich 1993, *Hilbert's Tenth Problem* [1] ★; Matoušek 2002, *Discrete Geometry* [1] ★; Nielsen–Chuang 2010, *Quantum Computation and Quantum…* [1] ★; Perrin–Pin 2004, *Infinite Words* [1] ★; Pila 2022, *Point-Counting and the Zilber-Pink…* [1] ★; Polyanskiy–Wu 2025, *Information Theory* [1] ★; Soare 1987, *Recursively Enumerable Sets and Degrees* [1] ★; Soare 2016, *Turing Computability* [1] ★; Sørensen–Urzyczyn 2006, *Curry–Howard Isomorphism* [1] ★; Straubing 1994, *Finite Automata, Formal Logic, and…* [1] ★; Tent–Ziegler 2012, *Model Theory* [1] ★; Troelstra–Schwichtenberg 2000, *Basic Proof Theory* [1] ★.

Full bibliographic entries, identifiers, access evidence and verification status: `references_master.md`.
