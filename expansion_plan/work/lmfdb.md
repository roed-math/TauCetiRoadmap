# LMFDB: the definitions to formalize, who owns them, and the roadmaps still needed

Snapshot 2026-10-07. Goal 1 of the expansion plan: every LMFDB object type and every displayed
invariant or label should be a precisely stated Lean definition. Companion data:
`needs_lmfdb.jsonl` (161 needs, one per concept cluster per section).

## 0. Sources and method

- **LMFDB code**: `/Users/roed/claude/lmfdb`, read at `upstream/main` = `009463ed2` (2026-10-02).
  The clone's checkout is on `shimura_curves_working`, so I read through git refs. In-development
  sections come from branches `origin/shimura_curves`, `origin/hmsurfaces`, `origin/eisenstein` and
  `origin/abvar` (all 2026-08-04). The section list comes from `lmfdb/homepage/sidebar.yaml`.
- **Knowl ids**: I grepped every dotted string literal in `lmfdb/**/*.py|html|yaml` and kept those
  that are real knowl ids. **1,089 of the 1,725 "normal" knowls** are referenced from code.
  Per-directory lists are in the scratch file `refs_by_dir.json`.
- **Knowl titles**: two index pages of `www.lmfdb.org/knowledge/` supplied the titles of all 1,725
  normal knowls (reviewed and beta) and of 3,580 column/table knowls (3,432 DB columns in 148
  tables). The column names show exactly what each table stores.
- **Knowl contents**: I fetched raw content via `/knowledge/content/<id>` at 1.1 s spacing. After
  4 successful fetches `www.lmfdb.org` answered every request with a **reCAPTCHA challenge**.
  I stopped: 71 requests in total, and I did not try to get around the challenge (no beta host,
  no other route). The analysis therefore rests on titles, column names and source code. The
  brief anticipated this: titles almost always identify the concept.
- **Supply side**: a local corpus of 321 roadmap READMEs, grepped term by term (`tgrep.py`).
  It covers main (65 incl. RepresentationTheory sub-roadmaps), the 7 completed ones, the heads of
  open PRs, and the 152 Birkbeck campaign roadmaps. I also grepped a declaration index of Mathlib
  `6b7abb3c` and Tau Ceti `a91d3aafa` (390k declarations). Scratch directory:
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/agent-lmfdb/`.

**A finding worth acting on outside the roadmaps.** LMFDB knowls already cite Mathlib. Since Oct
2025 (D. Roe, commits `8794e4a9e`, `1fa76e401`), `lmfdb/knowledge/knowl.py:external_definition_link`
supports `{{DEFINES("…", mathlib="NumberTheory/ModularForms/Basic.html#CuspForm")}}`. Ten knowls
have "(mathlib)" in their titles: `cmf.*_mathlib_def` (7), `nf.degree_mathlib_def`,
`ring.field_of_fractions_mathlib` and `group.group_mathlib_defn`. The four whose content I could
read (`cmf.cusp_form`, `space`, `q-expansion` and `dimension`) use the macro, and each records how
the LMFDB definition differs from Mathlib's. Example
from `cmf.cusp_form_mathlib_def`: Mathlib's `CuspForm Γ k` allows any `Γ ≤ GL₂(ℝ)` and `k ∈ ℤ`,
while the LMFDB takes Γ of finite index in SL₂(ℤ) and k > 0. Another, from
`cmf.space_mathlib_def`: the LMFDB's `M_k(N, χ)` carries a character, and Mathlib's
`ModularForm Γ k` does not.

Adding a `tauceti=` site to `external_definition_link` would let knowls point at Tau Ceti
declarations as they land. That is a one-function LMFDB change. It is the natural delivery
channel for this whole goal, but it is not roadmap material.

**Existing label practice in Tau Ceti.** Labels are stated as predicates on intrinsic data only:
- `TauCeti/NumberTheory/NumberField/IntrinsicLabel.lean` defines `HasLMFDBIntrinsicLabel K d r D`
  (NumberFieldArithmetic Layer 8.1);
- `GroupTheory/Perm/TransitiveGroupLabel/` covers nTj for n ≤ 5;
- `Combinatorics/PermutationTriple/Passport/Label.lean` covers Belyi passports.

Each file deliberately stops before the enumerative index. In the words of the number-field file,
the index "depends on an external ordering of a certified complete list — and nothing here defines
or approximates it". The `LMFDBLabelsAndCompleteness` proposal (§3, P1) fills exactly that hole.

## 1. Section inventory

The count columns are:
- *code* = distinct knowls referenced from the section's code;
- *own* = how many of those carry the section's own prefix;
- *cat* = knowls in the section's category;
- *cols* = documented DB columns of its tables.

Status: P = production, β = beta in the sidebar, D = in development on a branch, F = future
(data and knowls exist, no live section). Owner abbreviations: EC = EllipticCurves,
MF = ModularForms, MC = ModularCurves, AC = AlgebraicCurves, NFA = NumberFieldArithmetic,
GNF = GlobalNumberFields, PGG = PolynomialGaloisGroups, LFR = LocalFieldsRamification,
IL = IntegralLattices, cb: = Birkbeck campaign, #N = open PR.

| Section | Object | St | code/own | cat | cols | Concept clusters | Owners (strongest first) | Gaps → proposal |
|---|---|---|---|---|---|---|---|---|
| `lfunction` (+zeros, riemann) | L-functions | P | 56/31 | 71 | 146 | data model (degree, conductor, Γ-factors, weight, sign, normalization); Euler products; instances; zeros/analytic conductor/GRH; special values; Selberg class, Sym^n, Rankin–Selberg; Hasse–Weil L; labels | Mathlib LSeries; ArithmeticDirichletSeries; #248 LFunctions; #253 ZerosOfLFunctions; cb:AutomorphicLFunctionsAndLocalFactors, cb:NeronModels R11.5 | Selberg class (extend #248); labels → P1 |
| `cmf` (+Eisenstein D) | classical newforms and spaces | P | 94/73 | 127 | 500 | spaces/dims/Sturm; Hecke, newforms, AL; coefficient fields, orbits, twists, CM/RM, Satake; L-function; Galois reps, ST, weight-1 Artin data; Eisenstein newforms; Stark units; Shimura correspondence; labels | Mathlib; MF (main, much in code); cb:AutomorphicGaloisRepresentations | Eisenstein newforms, minimal twists (extend MF); weight 1 → P7; ST → P8; half-integral → P17; labels → P1 |
| `maass` | Maass newforms on Γ₀(N) | P | 19/10 | 23 | 19 | Laplacian, spectral parameter; Whittaker/K-Bessel expansions; Hecke, symmetry; exceptional eigenvalues, Weyl law; L-functions; rigor data | cb:AutomorphicSpectralTheory (adelic) | **P16 MaassForms**; K-Bessel absent from Mathlib |
| `hmf` | Hilbert newforms | P | 24/7 | 9 | 27 | Hilbert modular groups; HMF of weight vector, q-expansions; Hecke at primes; JL/Brandt; base change, CM; labels | cb:HilbertModularVarietiesAndShimuraCurves, cb:GL2AutomorphicRepresentationsAndTransfer | **P12**; Brandt → P6 |
| `hmsurface` | Hilbert modular surfaces | D | 25/14 | 18 | 37 | cusps and resolutions, elliptic points; χ, e, K², h^{p,q}, Kodaira dimension | cb:HilbertModularVarieties (moduli only) | **P13** |
| `bmf` | Bianchi newforms | P | 23/12 | 17 | 34 | Bianchi groups, ℍ³; cuspidal H¹ with Hecke; Fourier–Bessel; sign, rank; base change, CM, EC over K | #432 KleinianGroups (two smallest discriminants); cb:ArithmeticLocallySymmetricSpaces | **P14** |
| `smf` | Siegel modular forms | β | 5/4 | 58 | 237 | ℍ_g, Sp₄(ℤ), weights (k,j), Koecher, Φ; Eisenstein/Klingen; Igusa rings; paramodular K(N); Hecke, spinor L; lifts; theta series | cb:MetaplecticAutomorphicForms MP.8 (Jacobi forms) only | **P15** |
| `mf.half_integral` | half-integral weight forms | F | 2/2 | 5 | 8 | θ multiplier, Kohnen plus space, Shimura decomposition; θ, η; Jacobi forms | cb:MetaplecticAutomorphicForms MP.7; #286 ThetaSeries; MF (η) | **P17** |
| `ec` | elliptic curves over ℚ | P | 105/88 | 138 | 103 | models; local data; MW, heights, regulator; Selmer/Sha, BSD data; isogeny class and graph; modular parametrization, degree, Manin constant; Faltings height; Galois images; CM; modularity; ST; Iwasawa; abc/Szpiro; labels | Mathlib; EC (Layers 1–8, much in code); cb:RankZeroOneBSD, cb:ModularCurvesPartII R14.5, cb:Arakelov R35.3, cb:EllipticCurveModularity, cb:Iwasawa roadmaps | images, isogeny classes → **P9**; Manin constant, modular degree, optimality, analytic Sha → **P11**; ST → P8; local root numbers → P7; labels → P1 |
| `ecnf` | elliptic curves over number fields | P | 71/48 | (shared) | 61 | minimal models, obstruction class; conductor ideal; MW over K; periods over K; base change, ℚ-curves, CM; modularity over K; images; labels | EC 4.5a–b (code); cb:CM, cb:ModularCurvesPartII R12.1 | periods/BSD over K → P11; ℚ-curves → P4; labels → P1 |
| `g2c` (+cluster pictures) | genus 2 curves over ℚ | P | 80/58 | 63 | 186 | models, Igusa(-Clebsch)/G2 invariants, Aut; Jacobian conductor, Euler factors, L; End algebras; MW, 2-Selmer, BSD data; rational points, local solvability; ST (52); GSp₄ images; cluster pictures; paramodular link | AC Layer 10; JacobianChallenge; cb:AbelianSchemes, cb:NeronModels, cb:HeightsRationalPoints | **P5 HyperellipticCurves**; End → P4; ST → P8; GSp₄ → P9; paramodular → P15 |
| `modcurve` | modular curves X_H, H ≤ GL₂(Ẑ) | β | 78/54 | 89 | 217 | level, index, genus, cusps, widths, elliptic points; moduli of X_H over ℚ, j-map, CM and isolated points; models and gonality; J_H decomposition, rank; entanglements, Gassmann classes, twists, obstructions; RSZB labels | MF Layer 10; FuchsianOrbifolds; MC (prime-level diamond quotients); cb:ModularCurvesPartII (general level, A_f) | **P9 AdelicImagesAndModularCurves**; models and gonality → **P10**; labels → P1 |
| `hgcwa` | higher genus families with automorphisms | P | 28/14 | 18 | 41 | signature, generating vectors, Riemann existence; braid/topological equivalence, refined passports; Hurwitz bound; group-algebra decomposition of Jacobians | BelyiMaps; FuchsianOrbifolds; AC Layer 11; #271 SurfaceTopology | **P19** |
| `av.fq` | isogeny classes of AVs over 𝔽_q | P | 48/29 | 66 | 160 | Weil polynomials, angles, Newton polygon, p-rank; Frobenius, Tate, Honda–Tate, End invariants, decomposition; point counts, Jacobians, polarizations; orders ℤ[F,V], weak equivalence, Picard; labels | (none beyond JacobianChallenge and NumberFieldOrder.conductor in code) | **P2 + P3**; labels → P1 |
| `belyi` | Belyi maps | P | 27/18 | 18 | 101 | triples, passports, monodromy; covers, fields of moduli; labels | BelyiMaps (much in code) | orbit-letter index → P1 |
| `nf` | number fields | P | 77/56 | 104 | 75 | degree…index; class groups (narrow, relative); units, regulator, unit signature rank, G-module of units; Galois group, siblings, arithmetic equivalence; primes, Frobenius; rd, grd, Odlyzko; CM, reflex, abelian conductor; Weil height; labels, polredabs, completeness, GRH | Mathlib; NFA, GNF, PGG, ClassFieldTheory (code); #253; #287; cb:CM.0 | Gassmann, unit Galois module → **P20**; grd → P22; polredabs, index, completeness, GRH flags → **P1** |
| `lf` (+families) | p-adic fields and families | P | 61/53 | 72 | 94 | e, f, discriminant, residue field; Galois group, ramification filtrations, slopes, Herbrand; Eisenstein, Newton and ramification polygons, residual polynomials, indices of inseparability, jump sets; families, packets, masses; root number; labels, Galois splitting models | Mathlib (IsEisensteinAt, IsKrasner); LFR, LocalGaloisGroups (code); #226 MassFormula | **P22 PadicExtensionFamilies**; root number → P7; labels → P1 |
| `character.dirichlet` | Dirichlet characters | P | 38/29 | 42 | 37 | conductor, parity, order, Gauss/Jacobi sums; Legendre/Jacobi/Kronecker, Kloosterman; orbits, value and fixed fields; Conrey labels | Mathlib; MF Layer 9; ClassFieldTheory | Kronecker symbol, Kloosterman sums (small, unowned) |
| `character.hecke` | Hecke characters | F | — | 1 | — | conductor, infinity type, L-function | GNF `HeckeCharacter` (code); #248 | — |
| `artin` | Artin representations | P | 35/21 | 22 | 37 | invariants (det, parity, FS indicator, projective image, fields); conductor; L-function, Brauer, root number, Artin conjecture; labels | RepresentationTheory (FS indicator in code); cb:ArithmeticGaloisRepresentations R01.3 | **P7 ArtinRepresentations** (named by #248 and NFA) |
| `hgm` | hypergeometric motives | β | 32/23 | 30 | 142 | (α, β) data, Hodge vector, zigzag; finite hypergeometric sums, Euler factors; monodromy (Levelt, Beukers–Heckman), Bézout; conductor, tame/wild | Mathlib gaussSum; cb:FiniteFieldsAndCharacterSums FF.1 | **P18** |
| `gg` | transitive groups | P | 47/25 | 32 | 51 | nTj, primitivity, parity, blocks; resolvents; Malle a, b; arithmetic equivalence; character tables, integral reps; classification to degree 47 | Mathlib; PGG (n ≤ 5 in code); RepresentationTheory; #717 CertifiedPermutationComputation | Malle constants, Gassmann, ℤ[G]-lattices → **P20**; degree ≥ 6 → P1 |
| `group.abstract` | abstract groups, subgroups, characters, classes | P | 134/124 | 205 | 436 | basic invariants; Fitting, socle, chief series, supersolvable, …, isoclinism, Möbius; rational tables, Schur index; Schur multiplier; Lie type, sporadic; labels and small-group IDs; finite subgroups of GL_n | Mathlib; RepresentationTheory (code); CFSGStatement; #447 ChevalleyGroups; #599 SporadicOrders | **P20 FiniteGroupInvariants**; IDs → P1 |
| `st_group` | Sato–Tate groups | P | 39/29 | 34 | 41 | axioms, identity and component groups; moments; classification g = 1, 2; equidistribution; labels | RepresentationTheory/CompactGroups, LieGroups | **P8** |
| `lattice` | integral lattices | β | 27/22 | 62 | 144 | Gram, det, level, dual, discriminant group, genus; class number, mass, spinor genus, neighbors; theta, kissing, roots, Niemeier; automorphisms; covering radius, Hermite, perfect, designs, universality; labels | IL (main + completed; code); #286; #219; #287 | mass → OrthogonalTamagawaAndLatticeMass (named, unwritten); geometric invariants → **P21**; labels → P1 |
| `shimcurve` | Shimura curves X(D;N) over ℚ | D | 40/21 | 34 | 65 | quaternion algebras; Eichler and polarized orders, enhanced groups; genus, elliptic points, AL quotients; models, gonality, points; labels | Mathlib ℍ[R,a,b]; QuadraticFormInvariants; cb:HilbertModularVarietiesAndShimuraCurves; FuchsianOrbifolds | **P6 QuaternionArithmetic**; models → P10 |
| `modlgal` | mod-ℓ Galois representations | F | 37/30 | 35 | 53 | image, index, irreducibility, determinant; conductor; Frobenius matrices, splitting and projective fields | cb:ArithmeticGaloisRepresentations R01.3–4 | finite-image layer of **P7** |
| `modlmf`, `hecke_algebras` | mod-ℓ forms, Hecke algebras | F | 8/1 | 1 | 13 | mod-ℓ eigenforms, Hecke algebras | cb:AlgebraicModularFormsAndSerreWeights | — |
| `noncong` | noncongruence subgroups and forms | F | 0/0 | 1 | 36 | permutation pairs (S, T), Wohlfahrt level, congruence test; forms, unbounded denominators | FuchsianOrbifolds, BelyiMaps; Mathlib `ModularForm Γ k` | **P23** |

Other sidebar sections are "future" with no data or knowls: genus 3 curves, abelian surfaces,
K3 surfaces, Calabi–Yau, Shimura varieties, global/local function fields, Weil–Deligne,
automorphic, Jacobi and G₂ motives, GL(3) Maass, U(2,1). I did not inventory them. There are two
exceptions:
- Weil–Deligne representations already have an owner, cb:ArithmeticGaloisRepresentations R01.2.
- K3 surfaces have local preparatory work (`~/claude/k3s-lmfdb`). Their lattice side is IL's
  Nikulin theory.

The `crystals` module (Littelmann paths, 3 knowls) has no data and I skip it. The generic `ag.*`
(61) and `ring.*` (23) knowls are cross-section vocabulary; they are counted inside the clusters
above.

**Coverage tally of the 161 needs** (strongest owner): mathlib 18, tauceti-code 18,
tauceti-roadmap 28, open-pr 10, birkbeck-campaign 31, gap 56. Many needs owned by the campaign
are only *partly* covered: the campaign targets FLT/BSD-style proofs, not database invariants.
Those carry a `proposed_roadmap` for the remainder.

**Explicit disowning by existing roadmaps.** These items are LMFDB needs that existing roadmaps
name as someone else's:
- EllipticCurves Layer 8 names "a Faltings height, a modular degree, a Manin constant, analytic Ш
  data and Galois-image data" as belonging elsewhere.
- AlgebraicCurves names future *CurvesOverFiniteFields*, *AbelianVarieties* and
  *HyperellipticCurves* roadmaps.
- NumberFieldArithmetic excludes "the LMFDB ordering and the canonical-polynomial certificate" and
  "arithmetic equivalence and Gassmann triples".
- PolynomialGaloisGroups excludes transitive groups of degree 6–11 and stored tables.
- LFunctions (#248) names a future *ArtinRepresentations*.
- IntegralLattices names *OrthogonalTamagawaAndLatticeMass* for the mass formula.

None of these named successors exists yet.

## 2. Update to the July plan (`lmfdb_background_plan.md`, 2026-07-30)

| July proposal | Status 2026-10-07 |
|---|---|
| W1 GlobalClassFieldTheory | **Realized**: ClassFieldTheory + GlobalNumberFields (main), with ray class groups, Hecke characters and the Artin map in code. Chebotarev is its own roadmap (main; archive PR #722). |
| W1 AlgebraicCurves | **Realized** (main). It does not cover zeta functions, hyperelliptic invariants or Jacobians. |
| W1 NumberFieldArithmetic | **Realized** (main; discharged, archive PR #726). The LMFDB index and polredabs are excluded → P1. |
| W1 PolynomialGaloisGroups | **Realized** (main; deg ≤ 5 with labels in code). Degrees ≥ 6 → P1 with #717. |
| W1 LFunctions | **Open PR #248**, plus ArithmeticDirichletSeries (main) and **#253** ZerosOfLFunctions. It excludes Artin L-functions → P7. |
| W1 IntegralLattices | **Realized**: completed + expanded on main; GlobalQuadraticForms (main); #286 ThetaSeries; #219 Rank24LatticeConstructions. The mass formula went to the unwritten OrthogonalTamagawaAndLatticeMass. |
| W2 AbelianVarieties | **Basics covered by the campaign** (AbelianSchemesAndArithmeticModuli A1–A6; NeronModels; Heights RP.0–1 for Mordell–Weil). The endomorphism-algebra theory is still a gap → **P4**. |
| W2 CurvesOverFiniteFields | **Gap.** cb:WeilConjectures proves the general cohomological statements, not Stepanov–Bombieri or Weil-polynomial combinatorics → **P2**. |
| W2 HyperellipticCurves | **Gap** (named by AlgebraicCurves) → **P5**. |
| W2 QuaternionArithmetic | **Gap.** Hasse–Minkowski moved to GlobalQuadraticForms and is now consumed. No roadmap mentions Eichler orders → **P6**. |
| W2 ArtinRepresentations | **Gap** apart from conductors (cb:ArithmeticGaloisRepresentations R01.3) → **P7**. |
| W2 SatoTateGroups | **Gap** → **P8**. |
| W2 BelyiMaps | **Realized** (main; passports and labels in code). |
| W3 Hilbert / Bianchi / Siegel / half-integral / Maass | Campaign covers only geometric or adelic substrates: HilbertModularVarieties (moduli), ArithmeticLocallySymmetricSpaces (cohomology), MetaplecticAutomorphicForms (adelic half-integral weight, Jacobi forms for BFH), AutomorphicSpectralTheory (L² spectrum). Classical theories and data semantics are gaps → **P12–P17**. #432 KleinianGroups supplies the ℍ³ geometry. |
| W3 EichlerShimuraModularAV | **Mostly campaign**: ModularCurvesPartII R14 (Hecke correspondences, A_f, modular parametrization), EllipticCurveModularity, RankZeroOneBSD. Manin constant, modular degree, optimality and periods over K are left → **P11**. |
| W3 FiniteHypergeometricSums | **Gap**. Gauss/Jacobi sums are in Mathlib and cb:FF.1 → broadened to **P18**. |
| W3 GaloisRepresentationsModL | **Campaign** for the theory (ArithmeticGaloisRepresentations R01.3–R01.5). Data layer → **P7**; images → **P9**. |
| W3 Zeros program | **#253**. |
| (July: modular curves = PR #81) | Now ModularCurves (main) for Katz–Mazur, and FuchsianOrbifolds + MF Layer 10 for Γ\ℍ. The LMFDB's X_H for arbitrary open H ≤ GL₂(Ẑ) and RSZB labels are new → **P9, P10**. |
| (July: decision 3, Hasse–Minkowski placement) | Settled: GlobalQuadraticForms. |
| (July: decision 5, AbelianVariety ownership) | Still open in a new form. If the campaign's AbelianSchemesAndArithmeticModuli is not imported into TauCetiRoadmap, P4 must own rigidity, duals and polarizations over a field. |

New since July and not in that plan: **P1** (labels and completeness), **P9** (adelic images; the
modular-curves section went live as beta), **P10**, **P13**, **P19–P23**.

## 3. Proposed roadmaps

Sizes: M ≈ one semester course, L ≈ a graduate textbook, XL ≈ more than one book. Each scope
paragraph is written as the roadmap's opening.

### P1. LMFDBLabelsAndCompleteness — math.NT (sec. math.GR, cs.LO) — L
*Serves:* every section (24 needs). *Prerequisites:* NumberFieldArithmetic, PolynomialGaloisGroups,
ModularForms Layer 9, EllipticCurves Layer 8, BelyiMaps, IntegralLattices, LocalFieldsRamification,
#226 MassFormula, #717 CertifiedPermutationComputation; cb:ComputationalNumberTheory CN.5 as the
certificate-schema neighbor if the campaign is imported.

An LMFDB label names an isomorphism class by a tuple of invariants followed by an index into a
finite list sorted by a fixed rule. Tau Ceti's object roadmaps already state the intrinsic half as
predicates (the number-field prefix `d.r.D`, nTj for n ≤ 5, Belyi passports, the newform prefix
`N.k.a`), and each stops at the index because the index depends on a complete list. This roadmap
owns the second half.

1. **A generic carrier for labelled finite enumeration.** It consists of:
   - a finite set of classes;
   - a computable complete invariant with a total order;
   - the proof that the order separates classes;
   - the resulting bijection with an initial segment of ℕ;
   - the base-26 letter codes (`a…z, ba, …`) used for isogeny classes and Galois orbits.
2. **The canonical normal forms that pick representatives:**
   - polredabs (a T₂-minimal defining polynomial with the LMFDB tie-break);
   - Hermite-normal-form ideal labels and prime labels in number fields;
   - the trace-vector ordering of Galois orbits of newforms;
   - the a_p-ordering of isogeny classes;
   - the RSZB ordering of open subgroups of GL₂(Ẑ);
   - the p-adic field and family label schemes;
   - L-function labels;
   - small-group identifiers, treated as data. The GAP SmallGroup numbering is not an invariant.
     A label is a certified match against a stored generator list.
3. **Completeness theorems that make an enumeration exhaustive:**
   - the Hunter–Pohst bound for number fields of given degree and discriminant bound;
   - Krasner's lemma with Serre's mass formula for extensions of ℚ_p of given degree;
   - dimension formula plus Sturm bound for newform lists;
   - the transitive-group classification degree by degree as a checked certificate;
   - Cremona-style completeness by conductor, conditional on modularity as a named hypothesis.
4. **Data conventions that silently change meaning between systems,** fixed once:
   - Permutation composition. The Belyi audit (`handoffs/BELYI_LMFDB_AUDIT.md`) found that the
     stored σ∞σ₁σ₀ = 1 is Mathlib's σ₀σ₁σ∞ = 1.
   - The order of Weierstrass coefficients.
   - L-polynomial versus characteristic polynomial of Frobenius.
   - Arithmetic versus analytic normalization.
   - Conrey versus Mathlib characters.
   - The order of complex embeddings in embedding labels.
5. **Conditional data stated as hypotheses rather than facts:**
   - class groups "assuming GRH", as implications from a GRH statement through Bach's bound;
   - analytic ranks as proved upper bounds;
   - "analytic Ш" as the rounding of a real number defined by the BSD quotient;
   - rigorous versus heuristic numerical fields.

The intrinsic invariants themselves stay with their object roadmaps. Searching for objects and
storing tables are outside this roadmap.

### P2. CurvesOverFiniteFields — math.NT (sec. math.AG) — L
*Serves:* av.fq, g2c (Euler factors), modcurve/shimcurve point counts. *Prerequisites:*
AlgebraicCurves (the finite-constant-field layers), Mathlib finite fields, power series, `RatFunc`.

Let F/𝔽_q be a function field in one variable with full constant field 𝔽_q.

- **Zeta function.** This roadmap defines Z(F, T) as a series over effective divisors and proves
  rationality and the functional equation from Riemann–Roch (consumed from AlgebraicCurves). It
  identifies the numerator L_F(T), of degree 2g, with the class number h = L_F(1) and with the
  point counts N_r of the constant-field extensions.
- **The Riemann hypothesis for curves**, proved by the Stepanov–Bombieri method. This route is
  elementary and self-contained. It is independent of the étale cohomology that cb:WeilConjectures
  uses for varieties in general.
- **Consequences:** the Hasse–Weil and Serre bounds, Ihara's bound, and the relations among the
  N_r.
- **Weil polynomials**, developed as a standalone combinatorial theory. This is the shape of the
  av/𝔽_q search space:
  - q-Weil numbers;
  - finiteness of Weil polynomials of given degree;
  - real Weil polynomials;
  - Newton polygons at p and the p-rank;
  - ordinary, supersingular and almost-ordinary polynomials;
  - Frobenius angles and angle rank;
  - the Galois group and splitting field of a Weil polynomial.

  None of this refers to abelian varieties.

### P3. AbelianVarietiesOverFiniteFields — math.NT (sec. math.AG, math.RA) — XL
*Serves:* av.fq (its core). *Prerequisites:* P2, P4, an abelian-variety supplier
(JacobianChallenge's type with cb:AbelianSchemesAndArithmeticModuli A1–A3, or P4's fallback),
ClassFieldTheory (local invariants of division algebras), cb:ComplexMultiplication CM.0–CM.2 (for
Honda's direction), NumberFieldArithmetic (orders).

For an abelian variety A over 𝔽_q, this roadmap develops the theory in four parts.

1. **Frobenius and its characteristic polynomial.** The roadmap attaches the q-Frobenius π_A and
   the characteristic polynomial P_A of degree 2g on the ℓ-adic Tate module. It proves:
   - P_A ∈ ℤ[T], independently of ℓ;
   - |π| = √q, by Rosati positivity (consumed from P4);
   - #A(𝔽_{q^r}) = ∏(1 − π_i^r);
   - Tate's theorem Hom(A, B) ⊗ ℤ_ℓ ≅ Hom_Gal(T_ℓA, T_ℓB).
2. **Isogeny classes:**
   - A ~ B if and only if P_A = P_B;
   - End⁰(A) of a simple A is a division algebra over ℚ(π) with Tate's local invariants;
   - the Honda–Tate bijection between simple isogeny classes and conjugacy classes of q-Weil
     numbers. Tate's injectivity is proved here; Honda's existence comes from CM liftings, cited
     from the CM supplier.
3. **The data-bearing refinements:**
   - decomposition into simple and geometrically simple factors, and the geometric extension
     degree;
   - twists;
   - the Newton polygon, the p-rank and supersingularity of A;
   - the group structure of A(𝔽_q).
4. **Isomorphism classes inside an isogeny class:**
   - Deligne modules for ordinary classes, and Centeleghe–Stix for q = p;
   - the order-theoretic invariants the LMFDB records: the orders ℤ[π, q/π], Bass and Gorenstein
     orders, conductors, weak equivalence classes of fractional ideals (Marseglia), Picard groups
     and Cohen–Macaulay type;
   - polarizations and principal polarizability (Howe, ordinary case);
   - which isogeny classes of dimension 2 contain Jacobians (Howe–Nart–Ritzenthaler), as a
     statement with the needed elementary cases proved.

### P4. EndomorphismAlgebrasOfAbelianVarieties — math.AG (sec. math.NT) — L
*Serves:* g2c endomorphism data, ecnf ℚ-curves, modcurve/shimcurve Jacobian decompositions, P3, P8,
P19. *Prerequisites:* an abelian-variety supplier (as for P3), RepresentationTheory/SemisimpleAlgebras,
ClassFieldTheory (division algebras over number fields).

Over a field k, Hom(A, B) is a finitely generated free ℤ-module, and End⁰(A) is a
finite-dimensional semisimple ℚ-algebra. This roadmap proves:
- Poincaré complete reducibility;
- the decomposition A ~ ∏A_i^{n_i}, and the corresponding product decomposition of End⁰;
- positivity of the Rosati involution of a polarization;
- Albert's classification of division algebras with positive involution (types I–IV, with the
  numerical constraints in characteristic 0).

It then develops the invariants the databases display:
- End over k versus over k̄, and the endomorphism field;
- the real endomorphism algebra End⁰ ⊗ ℝ, which is the input to Sato–Tate classification;
- simple, geometrically simple, squarefree and primitive abelian varieties;
- GL₂-type abelian varieties and ℚ-curves (Ribet);
- real multiplication, quaternionic multiplication and CM abelian surfaces;
- the Galois action on End(A_k̄). In dimension 2 this gives the dictionary to the Galois
  endomorphism types of Fité–Kedlaya–Rotger–Sutherland.

If no supplier in TauCetiRoadmap provides rigidity, duals and polarizations over a field, those
form this roadmap's Layer 0.

### P5. HyperellipticCurves — math.AG (sec. math.NT) — L
*Serves:* g2c, cluster pictures, parts of hgcwa. *Prerequisites:* AlgebraicCurves Layer 10,
EllipticCurves (for the style of minimal-model arguments), LocalFieldsRamification, JacobianChallenge;
it consumes Néron models and component groups from cb:NeronModels as interfaces.

A hyperelliptic curve over a field k is a smooth projective curve with a degree-2 map to ℙ¹. In
any characteristic it has a model y² + h(x)y = f(x). This roadmap builds the following.

- **Models and their symmetries:** the weighted-projective model and the action of GL₂(k) × k^× on
  models; the hyperelliptic involution and Weierstrass points; twists; the discriminant of a model,
  valid in characteristic 2.
- **Genus-2 invariants:**
  - the Igusa–Clebsch invariants, Igusa's characteristic-free J₂,…,J₁₀, and the absolute G2
    invariants;
  - the theorem that equal invariants characterize k̄-isomorphism;
  - Mestre's obstruction for descent to the field of moduli;
  - the classification of genus-2 automorphism groups.
- **Minimal models:** minimal equations over discrete valuation rings, global minimal equations
  over ℤ, and the minimal discriminant (Liu).
- **Cluster pictures** of Dokchitser–Dokchitser–Maistret–Morgan for p odd: the semistability
  criterion, and the dictionary to the special fibre, Tamagawa numbers, root numbers and conductor
  exponents.
- **Arithmetic of the Jacobian and the curve:** 2-descent for the Jacobian through the étale
  algebra k[x]/(f) and the 2-torsion field, the 2-Selmer group, local solvability, and the explicit
  genus-2 Euler factors at good primes.

### P6. QuaternionArithmetic — math.NT (sec. math.RA) — L
*Serves:* shimcurve, hmf (Brandt modules), the quaternionic side of bmf/hmsurface.
*Prerequisites:* Mathlib `QuaternionAlgebra`, QuadraticFormInvariants, GlobalQuadraticForms,
ClassFieldTheory, NumberFieldArithmetic, FuchsianOrbifolds, OrthogonalSpinGroups (strong
approximation), P10.

Quaternion algebras over a number field F are classified by their ramification sets: finite sets of
noncomplex places of even cardinality. This roadmap builds the arithmetic of quaternion algebras and
their orders, on the model of Voight's book:
- local algebras and Hilbert-symbol invariants;
- the classification, via Hilbert reciprocity and Hasse–Minkowski, both consumed;
- reduced norm and trace forms;
- orders, their discriminants and levels; maximal, Eichler, Gorenstein and Bass orders;
- ideals, class sets and type numbers;
- the Eichler mass formula, and Eichler's class-number theorem for indefinite algebras;
- optimal embeddings of quadratic orders and embedding numbers;
- Brandt matrices.

Over ℚ, with B indefinite of discriminant D, the units of norm 1 in an Eichler order of level N form
an arithmetic Fuchsian group. For that group the roadmap proves:
- cocompactness for D > 1;
- Shimizu's covolume formula;
- the genus of X(D;N), and its elliptic points of orders 2 and 3, from embedding numbers;
- the Atkin–Lehner group and the quotients X*(D;N);
- the theory of polarized orders, Aut_{±μ}(O) and the enhanced groups by which the LMFDB indexes
  Shimura curves.

The moduli interpretation by QM abelian surfaces is cb:HilbertModularVarietiesAndShimuraCurves,
consumed as an interface.

### P7. ArtinRepresentations — math.NT (sec. math.RT) — L
*Serves:* artin, modlgal, cmf (weight one, Stark units), lf and ec (local root numbers).
*Prerequisites:* RepresentationTheory (CharacterTheory, InductionRestriction), LocalFieldsRamification,
ClassFieldTheory, #248 LFunctions, Chebotarev; cb:ArithmeticGaloisRepresentations R01.3 for
conductors. If that campaign roadmap is not imported, conductors are this roadmap's Layer 1.

An Artin representation is a continuous ρ: Gal(K̄/K) → GL_n(ℂ); its image is finite.

- **Local part:**
  - the Artin conductor;
  - the Langlands–Deligne local constants ε(ρ, ψ), characterized by inductivity in degree 0 and
    the abelian case (existence cited);
  - local root numbers, including Rohrlich's formulas for elliptic curves and the root number of a
    p-adic field.
- **Global part:**
  - Artin L-functions with Euler factors on inertia invariants;
  - invariance under induction and inflation, and ζ_L = ∏L(s, χ)^{χ(1)};
  - Brauer induction (consumed), and through it meromorphic continuation and the functional
    equation from #248's Hecke L-functions;
  - the global root number and the conductor–discriminant formula;
  - the Artin conjecture as a statement, with the known solvable cases cited;
  - the weight-one dictionary with classical newforms, stated;
  - Stark's conjecture at s = 0, stated.
- **The invariants the LMFDB records:** determinant, parity, Frobenius–Schur indicator, trace of
  complex conjugation, projective image and its type (dihedral, A₄, S₄, A₅), stem, Artin and
  projective fields, and Galois conjugates.
- **A final layer on finite-image representations into GL_n(𝔽̄_ℓ):** image, determinant,
  conductor prime to ℓ, Frobenius characteristic polynomials and their Chebotarev recognition, and
  the splitting and projective-kernel fields.

### P8. SatoTateGroups — math.NT (sec. math.RT, math.PR) — L
*Serves:* st_group and the ST columns of ec, g2c, cmf. *Prerequisites:*
RepresentationTheory/CompactGroups, LieGroups, ClassicalGroups; P4; #248 (CM case).

A Sato–Tate group of weight w and degree d is a compact subgroup of USp(d) (w odd) or O(d) (w even)
that satisfies the Fité–Kedlaya–Rotger–Sutherland axioms.

- **The objects:** the roadmap defines the axioms, the identity component and component group, and
  the pushforward of Haar measure to characteristic polynomials.
- **The statistics:** moment sequences, trace and a₂ moments, moment matrices, event probabilities
  and trace-zero density, computed by the Weyl integration formula.
- **The classifications:** proved in degree 2 (SU(2), U(1), N(U(1))) and for the 52 groups of
  degree 4 with their subgroup lattice. The degree-6 classification is stated as checked data with
  LMFDB labels.
- **Arithmetic:** the Sato–Tate group of an abelian variety (Zariski closure of the ℓ-adic image,
  algebraic Sato–Tate conjecture stated) and of a newform; the dictionary from P4's Galois
  endomorphism types in dimension 2; equidistribution as a statement, proved for CM elliptic
  curves from Hecke L-functions.

### P9. AdelicImagesAndModularCurves — math.NT (sec. math.GR, math.AG) — XL
*Serves:* modcurve, ec/ecnf Galois images and isogeny classes, g2c (GSp₄ layer). *Prerequisites:*
ProfiniteProPGroups, ModularForms Layer 10, FuchsianOrbifolds, EllipticCurves (Tate-module
representation, in code), ModularCurves, ClassFieldTheory; cb:ModularCurvesPartII (R13.4a, R14.5)
as interfaces; P10.

For E/ℚ the torsion representation is ρ_E: G_ℚ → GL₂(Ẑ). This roadmap builds the group theory,
arithmetic and moduli that the LMFDB uses to describe its image.

- **Group side:**
  - open subgroups H of GL₂(Ẑ), with level and index;
  - Γ_H = H ∩ SL₂(ℤ) and its genus, cusps, cusp widths and elliptic points;
  - surjective determinant and −I;
  - Dickson's classification of subgroups of GL₂(𝔽_ℓ): Borel, split and nonsplit Cartan subgroups
    and their normalizers, and the exceptional groups;
  - Serre's lifting lemma, entanglement, and the index-2 commutator obstruction.
- **Arithmetic side:**
  - mod-N, ℓ-adic and adelic images; adelic index and Serre invariants;
  - Serre's open image theorem for non-CM curves, as a theorem, with the CM counterpart from class
    field theory;
  - Mazur's torsion and isogeny theorems and Kenku's bound, as cited statements, with their
    consequences for isogeny classes and the isogeny graph over ℚ.
- **Moduli side:**
  - the modular curve X_H over ℚ for open H with surjective determinant;
  - its rational points as elliptic curves with image in H up to conjugacy, with the −I and
    j ∈ {0, 1728} caveats;
  - the j-map, cusps and their fields of definition, CM points and isolated points;
  - fiber products, Gassmann-equivalent subgroups, minimal twists and local obstructions;
  - J_H up to isogeny as a product of newform quotients A_f.
- **Final layer:** the analogous group theory for GSp₄(Ẑ).

### P10. CanonicalModelsAndGonality — math.AG — M
*Serves:* modcurve, shimcurve, g2c, hgcwa, and the `ag.*` knowls. *Prerequisites:* AlgebraicCurves
(Riemann–Roch, Layer 12 dictionary).

For a smooth projective curve X/k of genus g ≥ 2, the canonical map is an embedding exactly when X
is not hyperelliptic. This roadmap proves that theorem (Noether) and builds what follows:
- canonical models and Petri's description of their equations (low genus proved, general
  statement);
- plane models and the genus–degree formula for nodal plane models;
- gonality over k and over k̄, with the bound gon ≤ ⌊(g+3)/2⌋ over algebraically closed fields
  (Brill–Noether existence stated);
- the Castelnuovo–Severi inequality;
- bielliptic and cyclic-trigonal curves, and quotient curves by automorphism groups;
- Abramovich's gonality bound for modular curves and Frey's degree-gonality criterion, as
  statements consuming Faltings from the campaign;
- low-degree and isolated points.

### P11. EllipticCurvePeriodsAndModularParametrizations — math.NT — M
*Serves:* ec, ecnf (BSD data). *Prerequisites:* EllipticCurves, ModularForms,
cb:ModularCurvesPartII R12.1 and R14.5, cb:EllipticCurveModularity and cb:RankZeroOneBSD as
interfaces, P9.

The boundary: invariants of an elliptic curve built from its periods or from X₀(N).

- **Periods:** the period lattice of E over a number field K at each complex and real place, the
  global period Ω_{E/K}, and the BSD quotient over K. EllipticCurves stops at the real period
  over ℚ.
- **Analytic Ш:** the analytic order of Ш over ℚ and over K, defined as a real number by the BSD
  quotient. It uses L*(E, 1) from RankZeroOneBSD, and over K a continuation hypothesis pinned as
  EllipticCurves pins it.
- **The modular parametrization** φ: X₀(N) → E:
  - X₀(N)-optimal and Γ₁(N)-optimal curves;
  - the modular degree, and its relation to ⟨f, f⟩ and to the congruence modulus;
  - the Manin constant c, with φ*ω = c·2πi f(τ)dτ. The integrality results (Edixhoven; later
    work) are recorded as cited statements, and Manin's conjecture c = 1 is stated;
  - Stevens' conjecture, stated;
  - Cremona's convention placing the optimal curve first, as P1's interface.

### P12. HilbertModularForms — math.NT — L
*Serves:* hmf, ecnf modularity links. *Prerequisites:* GlobalNumberFields (totally real fields,
narrow class groups), ModularForms, #248, P6; cb:HilbertModularVarieties as the geometric neighbor.

Let F be a totally real field of degree n. This roadmap develops classical Hilbert modular forms on
ℍⁿ:
- the Hilbert modular group and Γ₀(𝔫) on each narrow-class component;
- weights k ∈ ℤⁿ with the parity condition, and the slash action;
- Koecher's principle for n ≥ 2;
- Fourier expansions over totally positive elements of the inverse different;
- cusp forms and finite dimensionality;
- Hecke operators T_𝔭 at prime ideals, newforms and strong multiplicity one;
- L-functions in #248's data model;
- base change from ℚ (Doi–Naganuma for real quadratic F; general base change stated);
- CM forms from Hecke characters of CM extensions;
- the Jacquet–Langlands transfer to definite quaternion algebras, stated. This is the route by
  which the LMFDB computes these forms through P6's Brandt modules.

### P13. HilbertModularSurfaces — math.AG (sec. math.NT) — M
*Serves:* hmsurface. *Prerequisites:* P12, cb:HilbertModularVarieties, AlgebraicVectorBundles or
JacobianChallenge for coherent cohomology.

For F real quadratic, Γ\ℍ² is a normal complex surface with finitely many cusps and quotient
singularities. This roadmap:
- compactifies it at the cusps;
- resolves the cusp singularities by Hirzebruch's cycles of rational curves (continued fractions)
  and the quotient singularities by Hirzebruch–Jung strings;
- counts elliptic points by type from class numbers of imaginary quadratic orders;
- computes the Euler number from ζ_F(−1) together with the elliptic and cusp contributions;
- computes the arithmetic genus χ, K², the Hodge numbers and the Kodaira dimension;
- works out the classification of the surfaces Y₀(𝔫)_𝔟 for small discriminants (van der Geer)
  as worked examples.

### P14. BianchiModularForms — math.NT (sec. math.GT) — L
*Serves:* bmf, ecnf over imaginary quadratic fields. *Prerequisites:* #432 KleinianGroups,
GlobalNumberFields, cb:ArithmeticLocallySymmetricSpaces, P16 (K-Bessel functions), #248.

Let K be imaginary quadratic. The roadmap covers the following.
- **Definitions:** weight-2 Bianchi modular forms for Γ₀(𝔫), defined as the LMFDB defines them —
  classes in H¹_cusp(Γ₀(𝔫), ℂ) — and also as vector-valued harmonic functions on ℍ³ with
  Fourier–Bessel expansions. The Eichler–Shimura–Harder comparison relates the two.
- **Hecke theory:** Hecke operators at prime ideals, including the class-group subtleties for
  nonprincipal primes; newforms; the sign of the functional equation and the analytic rank.
- **Constructions and links:** base change from classical newforms; CM forms; the
  rational-newform ↔ elliptic-curve correspondence over K, stated.
- **Worked examples:** Swan and Cremona fundamental domains for the class-number-one fields.

### P15. SiegelModularForms — math.NT — XL
*Serves:* smf, g2c (paramodular conjecture). *Prerequisites:* Mathlib `symplecticGroup`,
ModularForms, #286 ThetaSeries, P17 (Jacobi forms), #248.

Siegel modular forms of degree g are holomorphic functions on ℍ_g, automorphic for Sp_{2g}(ℤ) or a
congruence or paramodular subgroup, with values in Sym^j ⊗ det^k. This roadmap does degree 2 in
full, and general degree where that costs nothing:
- the symplectic action and slash operators;
- Koecher's principle;
- Fourier expansions over half-integral positive semidefinite matrices;
- Siegel's Φ-operator and cusp forms;
- Siegel and Klingen–Eisenstein series, and finite dimensionality;
- Igusa's structure theorem for degree-2 forms, and the Γ₀(2), Γ₀(3), Γ₀(4) ring theorems the
  LMFDB records, stated;
- paramodular groups K(N) and Roberts–Schmidt newforms;
- Hecke operators, and spinor and standard L-functions with Satake parameters;
- the Saito–Kurokawa/Maass lift, proved; the Gritsenko, Ikeda and Miyawaki lifts, stated;
- Siegel theta series of lattices;
- the paramodular conjecture, stated.

### P16. MaassForms — math.NT (sec. math.SP, math.CA) — L
*Serves:* maass, bmf (Bessel functions). *Prerequisites:* FuchsianOrbifolds, ModularForms
(congruence subgroups, characters), cb:AutomorphicSpectralTheory as neighbor, #248.

A Maass cusp form for Γ₀(N) with character χ is an automorphic eigenfunction of the hyperbolic
Laplacian, of moderate growth, with vanishing constant terms. This roadmap builds the classical
theory:
- the Laplace–Beltrami operator and its self-adjointness on L²(Γ\ℍ);
- the K-Bessel function K_{ir} (absent from Mathlib) with its asymptotics;
- Fourier–Whittaker expansions;
- spectral parameter and eigenvalue λ = ¼ + r²;
- Hecke and reflection operators, even/odd symmetry, Fricke eigenvalues;
- Selberg's bound λ₁ ≥ 3/16 for congruence groups, via Weil's bound for Kloosterman sums, with
  Selberg's ¼ conjecture stated;
- Weyl's law, stated;
- L-functions of Hecke–Maass newforms;
- Maass forms on PSL₂(ℤ[i]) acting on ℍ³.

### P17. HalfIntegralWeightModularForms — math.NT — M
*Serves:* mf.half_integral, cmf (Shimura correspondence, plus space), P15. *Prerequisites:*
ModularForms, #286 ThetaSeries.

Shimura's forms of weight k + ½ live on Γ₀(4N) with the theta multiplier. This roadmap covers:
- the multiplier systems of θ and η;
- the spaces M_{k+½}(4N, χ) and Hecke operators T_{p²};
- the Kohnen plus space;
- the Shimura lift through Niwa's theta kernel, and the Shintani lift;
- the Kohnen–Zagier and Waldspurger formulas, stated;
- the Serre–Stark basis theorem in weight ½;
- theta series of odd-rank lattices, and eta quotients;
- Eichler–Zagier Jacobi forms, with the isomorphism J_{k,1} ≅ M⁺_{k−½}(4).

### P18. HypergeometricMotives — math.NT (sec. math.CA, math.AG) — L
*Serves:* hgm. *Prerequisites:* Mathlib `gaussSum`, Galois theory of cyclotomic fields, #248's
data model; cb:FiniteFieldsAndCharacterSums FF.1 as neighbor.

Hypergeometric data are disjoint, Galois-stable multisets α, β ⊂ ℚ/ℤ (equivalently, cyclotomic
parameter vectors).
- **Monodromy:** hypergeometric groups generated by companion matrices, Levelt's rigidity theorem,
  the Beukers–Heckman finite-monodromy criterion by interlacing, the invariant Hermitian form and
  its signature, Bézout matrices and their determinants, imprimitivity.
- **Hodge theory:** the Hodge vector by the zigzag procedure, and the weight.
- **Point counts:** the finite hypergeometric sums of Katz, Greene and Beukers–Cohen–Mellit
  expressed through Gauss sums, and their rationality for data defined over ℚ.
- **The L-function:** Euler factors at good primes defined from those sums; tame and wild primes;
  the tame conductor formulas of Roberts–Rodriguez-Villegas, stated; the identification with point
  counts of Katz's motive, cited.

### P19. GroupActionsOnRiemannSurfaces — math.AG (sec. math.GT, math.GR) — M
*Serves:* hgcwa. *Prerequisites:* BelyiMaps (Riemann existence), FuchsianOrbifolds, AlgebraicCurves
Layer 11, #271 SurfaceTopology (mapping class groups), P4.

A finite group G acts on a compact Riemann surface of genus g ≥ 2 with signature
(h; m₁,…,m_r) exactly when G has a generating vector with the product relation and the prescribed
orders that satisfies Riemann–Hurwitz. This roadmap proves that criterion, then covers:
- quotient genus;
- the Hurwitz and Wiman bounds;
- topological equivalence of actions through Aut(G) and the braid/mapping-class action on
  generating vectors;
- refined passports;
- the dimension 3h − 3 + r of a family;
- Singerman's list of signatures whose full automorphism group is larger;
- hyperelliptic and cyclic-trigonal actions;
- the group-algebra decomposition of the Jacobian (Kani–Rosen, Lange–Recillas).

### P20. FiniteGroupInvariants — math.GR (sec. math.RT) — L
*Serves:* group.abstract, gg, nf (Gassmann, unit modules). *Prerequisites:* Mathlib GroupTheory,
the RepresentationTheory family, PolynomialGaloisGroups.

The finite-group vocabulary that group databases display and Mathlib lacks:
- **Subgroups and series:** the Fitting and generalized Fitting subgroups, socle, chief series
  with multiplicities, Hall subgroups and Hall's theorem.
- **Classes of groups:** supersolvable, metabelian, metacyclic, monomial, A- and Z-groups
  (consuming Mathlib's `IsZGroup`), quasisimple, almost simple and perfect groups.
- **Automorphisms and commutators:** outer automorphism groups, commutator length, isoclinism and
  stem groups.
- **Lattice and class invariants:** the Möbius function of the subgroup lattice; autjugacy classes
  and divisions.
- **Representations:** rational character tables and Schur indices (Brauer–Speiser), and minimal
  faithful degrees.
- **Arithmetic applications:** Gassmann triples and arithmetic equivalence of number fields
  (Perlis); Malle's constants a(G), b(G).
- **Integral representations:** indecomposable ℤ[C_p]-lattices (Diederichsen–Reiner) and the
  Galois-module types of unit groups in the biquadratic case.
- **Finite matrix groups:** finite subgroups of GL_n(ℤ) (proved for n ≤ 3, data beyond), GL_n(ℚ)
  and GL_n(ℂ).

### P21. LatticePackingsAndPerfectForms — math.MG (sec. math.NT) — M
*Serves:* lattice. *Prerequisites:* IntegralLattices, #286 ThetaSeries, #287 ArithmeticHeights
(successive minima), #219, GlobalQuadraticForms.

The geometric invariants of positive-definite lattices:
- minimum, kissing number, packing and center density;
- the Hermite invariant, and the Hermite constant γ_n with its small values proved;
- covering radius and Voronoi cells;
- successive minima (consumed) and well-rounded lattices;
- perfect and eutactic forms, Voronoi's theorem (extreme ⇔ perfect and eutactic), and the
  finiteness of perfect forms up to similarity;
- spherical designs, and Venkov's theorem on shells of extremal even unimodular lattices;
- universality and the 15 and 290 theorems, stated;
- tensor decompositions, and the Festi–Veniani index.

### P22. PadicExtensionFamilies — math.NT — L
*Serves:* lf (polygons, families), nf (Galois root discriminant). *Prerequisites:*
LocalFieldsRamification, LocalGaloisGroups, #226 MassFormula, Mathlib `IsEisensteinAt`, `IsKrasner`.

A totally ramified extension of a p-adic field is generated by a root of an Eisenstein polynomial,
and much of its ramification is visible on that polynomial. This roadmap covers:
- the Newton polygon over a valued field (absent from Mathlib) and its slope factorization;
- ramification polygons and residual polynomials (Greve–Pauli), with the theorem relating their
  slopes to the lower ramification breaks, and through it to Artin/Swan slopes and the Herbrand
  function;
- indices of inseparability (Fried, Heiermann) and jump sets;
- the canonical unramified–tame–wild tower, visible and hidden slopes, slope content and Galois
  mean slope;
- Krasner bounds, and the finiteness of extensions of given degree;
- families of Eisenstein polynomials with a fixed ramification polygon (Pauli–Sinclair, Monge),
  their packets, and their masses compared with #226;
- the Galois root discriminant as a product of local mean-slope factors.

### P23. NoncongruenceSubgroups — math.NT (sec. math.GR) — M
*Serves:* noncong (future). *Prerequisites:* FuchsianOrbifolds, BelyiMaps, ModularForms.

Finite-index subgroups of PSL₂(ℤ) correspond to transitive pairs (S, T) with S² = (ST)³ = 1. This
roadmap covers:
- the dictionary between subgroups and pairs (S, T);
- cusp widths, elliptic points and genus read from the permutations;
- the Wohlfahrt level, Wohlfahrt's congruence criterion and Hsu's permutation test, with index 7
  as the smallest noncongruence worked example;
- modular forms for noncongruence groups, via Mathlib's `ModularForm Γ k`;
- the unbounded-denominators theorem (Calegari–Dimitrov–Tang) and the Atkin–Swinnerton-Dyer
  congruences, stated.

### Named elsewhere, still unwritten
- **OrthogonalTamagawaAndLatticeMass** (math.NT, L) is named by IntegralLattices and
  OrthogonalSpinGroups. It would own the Smith–Minkowski–Siegel mass formula and Eichler's
  cls⁺ = spn⁺ theorem in indefinite rank ≥ 3. It serves `lattice.mass` and `lattice.class_number`.

### Extensions of existing roadmaps (too small to stand alone)
- **ModularForms:** the Eisenstein space basis E_k^{χ,ψ} and Eisenstein newforms (beta table
  `mf_newforms_eis`); minimal twists and twist multiplicity.
- **#248 LFunctions:** the Selberg class axioms as a predicate on its records.
- **#253 ZerosOfLFunctions:** Hardy's Z-function.
- **GlobalNumberFields:** unit signature rank.
- **Multiquadratic:** the Kronecker symbol (D/·).
- **cb:FiniteFieldsAndCharacterSums FF.1:** Kloosterman sums.

### Where label and data semantics should live
In its own roadmap, P1, not spread over the object roadmaps and not in the campaign. Three reasons.

1. The object roadmaps have, by design, already taken the intrinsic predicates. All of them stop
   at the enumerative index, which is the same mathematical problem everywhere: a certified
   complete list plus a total order.
2. Completeness theorems (Hunter–Pohst, Krasner + mass, Sturm + dimension, transitive-group
   certificates) and data conventions (composition order, normalizations) cut across sections.
   Duplicated per roadmap, they would drift.
3. cb:ComputationalNumberTheory CN.5 states the right principle — "an LMFDB label or CAS result
   supplies data to verify, not a theorem". But it is 6 KB and generic. P1 is its LMFDB-specific
   instance and should consume its certificate schema when available.

Boundary rule for reviewers: if a predicate is invariant under isomorphism, it belongs to the object
roadmap; if it depends on an ordering, a normal form, a stored list or a convention, it belongs to
P1.

## 4. Dependencies and order

```text
AlgebraicCurves ─┬─ P2 CurvesOverFF ─ P3 AVoverFF ─┐
                 ├─ P5 Hyperelliptic                 ├─ (campaign AbelianSchemes / JacobianChallenge)
                 └─ P10 CanonicalModels               P4 EndAlgebras ─ P8 SatoTate (+CompactGroups)
FuchsianOrbifolds + MF L10 + ModularCurves ─ P9 AdelicImages ─ P11 Periods/ModParam
QFI + GQF + CFT + Fuchsian ─ P6 Quaternion ─ P12 HMF ─ P13 HMSurfaces
#248 + RepTheory ─ P7 Artin            #432 + P16 Maass ─ P14 Bianchi
MF + #286 ─ P17 HalfIntegral ─ P15 Siegel        LFR + #226 ─ P22 PadicFamilies
Mathlib GroupTheory + RepTheory ─ P20 FiniteGroupInvariants      BelyiMaps ─ P19, P23
all object roadmaps ─ P1 LMFDBLabelsAndCompleteness (framework layer starts now)
```

Recommended order, by LMFDB coverage gained per prerequisite already on main:

1. **Startable now:** P9 (group side), P2, P22, P20, P6, P5, P1 (framework, number fields, lf,
   gg), P7 (once #248 merges), P21.
2. **Gated on an abelian-variety supplier in TauCetiRoadmap:** P4, P3, P8 (its group-theoretic
   half can start now), P19, P11, P10.
3. **Automorphic extensions:** P12, P13, P14, P16, P17, P15, P18, P23.

Decision for the owner: whether the campaign's AbelianSchemesAndArithmeticModuli and
NeronModelsAndSemistableAbelianVarieties are imported into TauCetiRoadmap. If not, P4 needs a
Layer 0, and P3/P5 need Néron-model interfaces stated against nothing.

## 5. Caveats
- Knowl *contents* were unavailable (CAPTCHA). Cluster boundaries come from titles and column names.
  A few concepts may be defined differently in the knowl text than I assume. Examples:
  `cmf.plus_space`, `hgm.rotation_number`, `av.fq.is_zfvconductor_sum`.
- Coverage marks a roadmap as owner when its README names the concept. "tauceti-code" means a
  declaration exists in Tau Ceti `a91d3aafa`; it does not mean the whole cluster is done.
- Campaign roadmaps are ~10–25 KB specifications at distance 5–9 from Mathlib. "birkbeck-campaign"
  coverage is promissory, and only for the parts their milestones name.
