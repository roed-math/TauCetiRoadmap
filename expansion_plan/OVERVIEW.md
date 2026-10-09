# Tau Ceti expansion plan: roadmaps for the LMFDB, the Annals definitions and the OpenAI papers

Draft for refinement, 2026-10-07; revised the same day for a **6-month spend**. Prepared by Claude with 23 subagents; every number below is traceable to a
file in [`work/`](work/) (index in §13). Supply was read at TauCetiRoadmap `upstream/main` `b4f19703`, the 78 open
PR heads, Tau Ceti code `a91d3aafa` (10-05), Mathlib `6b7abb3c` (09-28), the tauceti-explorer clone `4689b24`, and
openai/math at its 10-06 release.

## 0. Summary

**What the goals need.** Read against everything that exists or is planned, the three goals decompose into
**1,741 concrete needs** (a definition or theory that must exist in Lean). **861 of them (49%) have no owner** in
Mathlib, Tau Ceti, an open roadmap PR, Chris Birkbeck's number-theory campaign, or OpenAI's Lean library.

| goal | needs | owned | unowned | shape of the gap |
|---|---:|---:|---:|---|
| LMFDB (29 sections) | 161 | 105 | 56 | object-level arithmetic: Galois images, abelian varieties over 𝔽_q, Artin representations, quaternion orders, genus 2, Sato–Tate groups, hypergeometric motives, the non-classical modular forms, and the LMFDB labels themselves |
| Annals (100 definitions) | 125 | 82 | 43 | birational geometry, stacks and moduli, sheaf theory, and almost everything outside algebraic geometry and number theory: Riemannian and symplectic geometry, GMT, operator algebras, dynamics |
| OpenAI (372 families, 722 papers) | 1,455 | 693 | 762 | mostly outside NT: complexity theory, probability, ergodic theory, operator algebras, harmonic analysis, group theory, logic, and birational, complex and Hodge geometry |

**What exists is lopsided.** Of the ~254 roadmaps on Tau Ceti main, in open PRs and in the Birkbeck campaign,
163 are math.NT or math.AG. Analysis, probability, combinatorics, logic, dynamics and mathematical physics together
have about twenty, most of them open PRs. The OpenAI corpus is the reverse: 82% of its families lie outside NT/AG.

**The plan.** Ten campaigns, one per cluster of arXiv classes, each with a deduplicated slate (§5). Together they
propose **≈265 new roadmap READMEs in 37 umbrella families plus standalone roadmaps, ≈57,700 PRs of work**, plus
consolidation of the 152 campaign roadmaps into ≈60 promotion units (≈21,500 PRs at Tau Ceti standard), on top of
≈13,300 PRs left in existing roadmaps and open PRs. **Total ≈ 92,000 PRs (±50%)**: ≈$2.3M of implementation at
$25 per PR, plus ≈$0.3M of roadmap authoring and review rounds.

**The money and the clock.** The cost per merged PR is now measured on the current fleet ([calibration](work/cost_calibration.md)).

- **Price:** **≈$10.35 all-in** (range $9.40–11.30) per merged PR, on `claude-opus-5-5` at high effort; ≈$6.50 of that
  is authoring.
- **What $3M buys:** after ≈$0.4M for roadmap authoring, review and operations, ≈250,000 merged PRs.
- **What 26 weeks would take at that price:**
  - ≈13,000 PRs a week, 5.7× today's ≈2,300;
  - about sixteen more fleet-sized GitHub identities;
  - ≈1,900 merges a day;
  - ≈310,000 PRs of surface if today's fleets keep running on the same roadmaps, against ≈130–165k from the three
    goals plus the second tier.

At today's efficiency, the money cannot all go into PR count within six months, and it should not: review, merges and
surface would not keep up.

**Recommended operating point: ≈$20 per merged PR, ≈8,000 PRs a week (3.5× today).** Half the extra spend goes into
throughput, half into the difficulty and quality of each PR:
- **Harder material.** The new slates are deeper than today's mix. Measure how much that raises the cost per PR on the
  first wave-A roadmaps; expect 1.3–2×.
- **Second review and cleanup.** Every PR gets a second, independent review by a different model or configuration,
  and every merged file gets a cleanup, generalization and documentation pass (+$3–5 per PR).
- **Retries.** Items that fail once get maximum effort and best-of-n attempts (+$1–3 per PR).
- **An expensive second tier.** It leans toward costly, high-value work: proofs of the OpenAI papers' main theorems
  against Tau Ceti, and porting OpenAI's existing formalizations.

Measure the value of the quality spend as it runs (review findings per PR, later fixes to merged code), and move money
back into throughput if it buys little.

**What the operating point needs.**
- **Surface:** ≈130,000 PRs from the $3M. Today's fleets need another ≈60,000 if they keep drawing on the same roadmaps
  (§10, item 8). The three goals give ≈92,000, and the second tier (§7.6) ≈40–75k.
- **Three changes, all in the first three weeks:**
  1. **Roadmap review must go from ≈3 approvals a week to ≈20–25.**
     - Every tier-1 roadmap must be approved by about week 18 to leave time to implement it: ≈370 reviews in 17 weeks.
     - Today almost all approvals come from Chris Birkbeck and Kim Morrison.
     - This needs a policy decision by the Tau Ceti humans (§7.1), not only more reviewers.
  2. **Write capacity must grow by about eight fleet-sized identities.** Each gives ≈700 PRs/week at the owner's
     30 writes/hour gate. In practice this means the GitHub App route, not more personal accounts.
  3. **Merges must reach ≈1,150 a day** (today ≈400). That needs multi-PR Bors batches and runner capacity.

**Twelve recommendations.**

1. **Organize as ten campaigns with seventeen lanes, not thirty per-label forks** (§6). A per-class fork would leave
   most of them with no lead, no reviewer and no supply.
2. **Hub and spokes.** One registry in a hub explorer repository (agreed with Chris). TauCetiRoadmap stays the only
   normative repository and the only claim system workers read. Forks author roadmaps as
   `research/blueprint/roadmaps/<Id>.json`, **not** in `content/campaign/`, which is a build output (§6.1).
3. **Week 1: unblock suppliers.**
   - Find an adopter for **PR #196** (CohomologicalPointCounting: étale cohomology). It owns Annals #3 and #45,
     15 campaign roadmaps build on it, and its change requests have gone unaddressed since August.
   - Review the ≈45 open roadmap PRs, starting with #545, #126, #397, #248 → #253, #286, #287, #437, #66, #444 and
     #271. They are ≈4,000 PRs of surface available almost at once.
4. **Ask the Tau Ceti humans for a review fast track** (§7.1): campaign leads as reviewers on appointment, umbrella
   review with lighter member review behind machine pre-review, or an "approved for implementation" state. Without
   one of these, six months is not reachable.
5. **Write broad roadmaps and umbrella families,** reviewed as an umbrella README plus tranches of two or three
   members. This turns ≈370 reviews into ≈150 review events.
6. **Draft at scale from week 1.** Each campaign's wave A by week 6 (≈125 roadmaps), wave B by week 12, wave C by
   week 16. Authoring agents produce a first draft in hours, so human time goes to review alone.
7. **Start the empty campaigns at once with their wave-A foundations**: complexity foundations, Riemannian geometry
   and elliptic operators on manifolds, stochastic processes and ergodic theory, operator algebras, geometric group
   theory, harmonic analysis, graph theory. These have high demand, no dependencies and no competing owner.
8. **Promote Birkbeck's campaign early.** Its consolidated units (≈60, from 152 roadmaps) already have reviewed
   blueprints, so they are the fastest source of reviewed surface. Every merge or rename needs Chris's agreement.
   Run the LMFDB lane inside NT under the owner's direction (§5.1).
9. **Scale writes and merges in weeks 1–3:** the GitHub App (or about eight more identities at the 30/hour gate) and
   Bors batching to ≈1,150 merges a day.
10. **Open the second tier by week 8,** so the last eight weeks have work that needs finished foundations rather than
    new roadmaps (§7.6).
11. **Treat OpenAI's Lean library as statement templates and porting sources, after coordinating with OpenAI** (§8).
    It has 121,734 files under Apache-2.0, and it re-builds its foundations per paper (Cook–Levin three times, total
    variation about thirty times), so the value is in consolidation.
12. **Measure goal 3 by statability first.** 141 of the 372 OpenAI families rest on research-level theory. The slates
    make most of them statable, but proofs of their main theorems are not a 6-month target.

## 1. The goals and what "needed" means

- **LMFDB.** Every LMFDB object type and displayed invariant or label, as a precise Lean definition, with the
  theorems a definition needs to be well defined (e.g. Mordell–Weil before the rank). Source: the LMFDB code at
  `009463ed2`, 1,089 knowls referenced from code, the titles of all 1,725 knowls and 3,432 documented columns. Knowl
  *contents* could not be read: lmfdb.org served a reCAPTCHA after a few fetches and the agent stopped, as it should.
  A knowl export would let the audit be finished per knowl (§10).
- **Annals.** The 100 definitions of `~/claude/handoffs/definitions_100_tauceti.md`, each with its sample API
  (examples, counterexamples, target theorems).
- **OpenAI.** Everything needed to *state* and *prove* the results of the 722 manuscripts: their definitions and the
  general theory beneath them, not their paper-specific arguments. Formalizing the papers themselves is a downstream
  consumer of the roadmaps, not roadmap material.

A *need* is one definition or theory cluster required by one goal item, tagged with the arXiv class of the
**prerequisite theory** (étale cohomology is math.AG even when a math.NT paper needs it), its strongest existing
owner, and a proposed owner if none exists. Seven phase-1 agents read about 350 of the 722 PDFs at
introduction-and-preliminaries depth, keyword-scanned most of the rest, and classified every family; two read all
100 Annals entries against the three supply sources; one read the LMFDB.

## 2. Where we stand: supply

| arXiv | Tau Ceti main | completed | open PRs | Birkbeck campaign | total |
|---|---:|---:|---:|---:|---:|
| math.NT | 16 | 2 | 8 | 78 | 104 |
| math.AG | 9 | 1 | 2 | 47 | 59 |
| math.KT | 0 | 0 | 1 | 14 | 15 |
| math.GR | 6 | 0 | 6 | 2 | 14 |
| math.RT | 4 | 0 | 1 | 3 | 8 |
| math.GT, AT, CT, SG | 5 | 1 | 9 | 2 | 17 |
| math.CV, DG, AP, CA, FA, OC, IT, NA | 8 | 2 | 6 | 1 | 17 |
| math.CO, PR, DS, LO, QA, RA, AC | 3 | 0 | 12 | 4 | 19 |

([full table](work/supply_by_arxiv.md); Tau Ceti topics from `metadata.toml`, campaign classes from the explorer's
zbMATH MSC mapped to arXiv.)

- **Tau Ceti main:** 51 active and 6 completed roadmaps, with 8 more archive PRs open (#719–#726). About 6,100 PRs of
  work remain on the active ones; at today's rate that is under three weeks.
- **Open roadmap PRs:** about 45 of the 78 add or expand a roadmap, roughly 4,000 PRs of work. Many have waited over a
  month (31 awaiting review, median age 31 days).
- **Birkbeck campaign:** 152 roadmaps (one retired), a connected account of modern number theory and its
  arithmetic-geometry interfaces. The READMEs are thin (median 11 KB against Tau Ceti's 45 KB), with no
  `Suggested.lean` or `metadata.toml`; they are backed by much larger reviewed blueprints (median ~190 KB). There is
  **no pipeline into TauCetiRoadmap**: the explorer treats Tau Ceti roadmaps as read-only, and 163 confirmed findings
  about Tau Ceti roadmaps sit in its `UPSTREAM_NOTES.md`. Its September overlap reconciliation predates eight main
  roadmaps and about 40 PRs, so several campaign roadmaps now duplicate Tau Ceti material
  ([coordination §3.2](work/coordination.md)).
- **Earlier LMFDB plan** (`lmfdb_background_plan.md`, 07-30). Wave 1 is realized: ClassFieldTheory, AlgebraicCurves,
  NumberFieldArithmetic, PolynomialGaloisGroups, IntegralLattices and BelyiMaps, plus LFunctions #248 and
  ZerosOfLFunctions #253. Waves 2 and 3 were never drafted. This is the "local second stage": no drafts exist, only
  the plan. The NT slate's LMFDB lane supersedes it.
- **OpenAI Lean library:** 121,734 files, Apache-2.0, organized like Mathlib. Its lakefile pins Tau Ceti, but almost
  no file imports it. The catalogue flags 162 manuscripts as formalized, and agents found Lean scope notes for many
  more families (for example, 65 of 77 in combinatorics/TCS), often covering supporting lemmas rather than main
  theorems (§8).

## 3. What the goals need: demand

| campaign | needs | of which gaps | LMFDB (gaps) | Annals (gaps) | OpenAI (gaps) |
|---|---:|---:|---|---|---|
| NT | 268 | 64 | 134 (47) | 12 (2) | 122 (15) |
| AG | 254 | 125 | 12 (4) | 48 (10) | 194 (111) |
| PRDS | 206 | 150 | – | 5 (4) | 201 (146) |
| ANA | 190 | 109 | 1 (1) | 11 (8) | 178 (100) |
| LTCS | 176 | 89 | – | 1 (1) | 175 (88) |
| ALG | 166 | 59 | 12 (4) | 18 (7) | 136 (48) |
| GEO | 152 | 97 | 1 (0) | 15 (6) | 136 (91) |
| FAMP | 135 | 67 | – | 4 (1) | 131 (66) |
| COMB | 109 | 62 | – | 1 (1) | 108 (61) |
| TOP | 85 | 39 | 1 (0) | 10 (3) | 74 (36) |

([`work/needs_all.jsonl`](work/needs_all.jsonl), merged by `work/merge_needs.py`.)

**LMFDB** ([report](work/lmfdb.md)). There are 29 sections (18 production, 4 beta, 2 in development, 5 future with
data). Coverage of the 161 concept clusters: Mathlib 18, Tau Ceti code 18, Tau Ceti roadmaps 28, open PRs 10, the
campaign 31 (mostly partial, because it targets FLT/BSD-style proofs rather than database invariants), gap 56.
Existing roadmaps name LMFDB-facing successors that no one has written:

- EllipticCurves leaves out the Faltings height, modular degree, Manin constant, analytic Ш and Galois images;
- AlgebraicCurves names CurvesOverFiniteFields, AbelianVarieties and HyperellipticCurves;
- NumberFieldArithmetic leaves out polredabs and Gassmann equivalence;
- PolynomialGaloisGroups stops at transitive groups of degree 5;
- LFunctions names ArtinRepresentations;
- IntegralLattices names OrthogonalTamagawaAndLatticeMass.

LMFDB knowls already link to Mathlib through `DEFINES(…, mathlib=…)`. Adding a `tauceti=` target is a one-function
LMFDB change, and it is the natural delivery channel.

**Annals** ([#1–51](work/annals_1_51.md), [#52–100](work/annals_52_100.md)).

- **#1–51:** 23 fully owned, 22 partial, 6 unowned (D-modules, Arthur parameters, K-stability, Mumford–Tate groups,
  slope stability, valuation spaces). Fifteen of the fully owned ones are owned only by campaign roadmaps at
  distance 7–10, so the work is promoting their foundations early.
- **#52–100:** none fully owned, 28 partial, 19 unowned. Three of the unowned are explicit refusals by existing
  roadmaps: Kac–Moody and Brauer blocks (RepresentationTheory), Borel reducibility (#41) and strong convergence
  (#397).
- **The largest structural gap is elliptic theory on closed manifolds.** DifferentialGeometry hands analysis of Δ to
  PDE, and PDE treats only domains in ℝⁿ. Six definitions wait on it.

**OpenAI** (seven reports; see §13). Of the 372 families, **23 are elementary** (statable and provable from Mathlib
and Tau Ceti with modest additions), **208 need named roadmaps**, and **141 are frontier**: they rest on
research-level theory, often recent papers used as black boxes or unrefereed OpenAI companion preprints. Six
families depend on computer certificates, and two rest on unverified zero-free-region claims for L-functions.
Notable gaps by share:

- **TCS:** complexity theory cannot even be *stated*; 28 families have no formal statement possible in Mathlib.
- **Probability and math-ph:** almost all of it is a gap; 27 of 54 families are frontier.
- **Algebraic geometry:** 26 of 36 families are frontier, but 33 become statable with the slate.
- **Geometry:** Tau Ceti stops one layer short (no comparison geometry, analysis on closed manifolds, convex bodies
  or ergodic theory).
- **Group theory and logic:** no owner anywhere.

## 4. Capacity and the binding constraints

From [`work/capacity.md`](work/capacity.md), measured where possible:

- **Throughput.** Tau Ceti merged 2,263 PRs in the week of 09-28, up from 550–900 a week in August. roed-math
  accounted for 700 of them, with a 98% merge rate.
- **Per-roadmap cost.** The 13 roadmaps completed since the fleets started took 1,408 PRs for 102 layers: about
  14 PRs per layer and one PR per stated target. Size classes: S ≈ 40 PRs, M ≈ 110, L ≈ 250, an XL family
  1,000–1,700.
- **Cost per PR, measured** ([cost_calibration.md](work/cost_calibration.md)): ≈$10.35 all-in per merged PR (range
  $9.40–11.30) on claudeF's fleet over 2.6 days (`claude-opus-5-5`, high effort): $1,797 of recorded Claude spend,
  488 review rounds whose spend is estimated, 103 Codex rounds priced at Claude rates, and 257 PRs opened. The
  capacity model's bottom-up estimate was ≈$20 at Opus 5 prices. Authoring roadmaps costs $200–1,000 per medium
  roadmap.
- **Supply.** Known supply was ≈23k PRs. The slates in §5 raise it to ≈92k, which is enough.
- **Binding order:**
  1. roadmap review (≈3 approvals a week; the 6-month plan needs ≈20–25);
  2. the write budget per GitHub identity (≈700 PRs/week per fleet, so 3–6 more fleet-sized identities are needed,
     depending on a 12- or 6-month pace;
     the GitHub App route in `~/claude/handoffs/GITHUB_APP_FEASIBILITY.md` is the scalable one);
  3. the merge pipeline;
  4. width inside a roadmap (a median of 32 PRs/week, so 100–200 roadmaps must be active at once);
  5. waste from duplicates (1.4–4%, more on a thin frontier) and Mathlib bumps.

  Money and CI do not bind.
- **Six-month requirements.** These assume a six-week linear ramp, then 20 weeks at full rate, with $2.6M of
  implementation budget. "Surface" is shown with and without the ≈60k PRs that today's fleets consume if they keep
  drawing on the same roadmaps.

  | cost per PR | PRs bought | extra PRs/week | total PRs/week (× today) | extra identities | merges/day | roadmaps active | surface (with / without today's fleets) |
  |---|---:|---:|---:|---:|---:|---:|---:|
  | $10.35 (measured) | 251k | 10,900 | 13,200 (5.7×) | 16 | 1,890 | ≈380 | 311k / 251k |
  | $15 | 173k | 7,500 | 9,800 (4.3×) | 11 | 1,400 | ≈280 | 233k / 173k |
  | **$20 (recommended)** | **130k** | **5,650** | **7,950 (3.5×)** | **8** | **1,140** | **≈230** | **190k / 130k** |
  | $25 | 104k | 4,500 | 6,800 (3.0×) | 6–7 | 970 | ≈195 | 164k / 104k |

  Tier-1 surface (the slates plus promotion plus existing) is ≈92k PRs; §7.6 sizes the second tier at ≈40–75k.

- **Spend profile:**
  - Month 1: ≈$0.25M, for the ramp and front-loaded authoring.
  - Months 2–6: ≈$0.55M each, about $130k a week.
  - Roadmap authoring and review rounds (≈$0.3M) fall almost entirely in months 1–4.
- **GitHub limits.** GitHub documents a secondary limit of 80 content-generating requests a minute and 500 an hour per
  identity (`~/claude/handoffs/GITHUB_APP_FEASIBILITY.md`; whether it applies per App installation is not documented).
  The owner's 30/hour gate sits far below it. The plan keeps every identity at that gate and scales through the
  GitHub App, not by raising the gate.

## 5. The plan: ten campaigns

Campaign boundaries and pre-decided owners for contested concepts: [`work/BOUNDARIES.md`](work/BOUNDARIES.md). Each
campaign has a full slate (`work/campaign_<CODE>.md`, with scope paragraphs, milestones, prerequisites, goals served,
porting sources and open questions) and a machine-readable `work/slate_<CODE>.json`. Counts below are from
`work/normalize_slates.py`.

| campaign | arXiv classes | new READMEs | families | new PRs | wave A | existing supply left | campaign promotion |
|---|---|---:|---:|---:|---:|---:|---:|
| **NT** | NT | 33 | 5 | 7,300 | ≈17 | ≈2,750 | 44 units, ≈16,100 |
| **AG** | AG | 35 | 4 | 9,010 | 10 | ≈2,490 | 15 units, ≈5,350 |
| **ALG** | AC, RA, GR, RT, QA | 31 | 4 | 7,070 | 20 | ≈1,900 | SR, DDPA stages |
| **TOP** | AT, GT, CT, KT, GN | 27 (+2 indexes) | 2 | 5,990 | 7 | ≈2,160 | 9 K-theory roadmaps absorbed |
| **GEO** | DG, SG, MG | 23 | 3 | 4,980 | 8 | ≈800 | – |
| **ANA** | CA, CV, AP, NA, OC | 28 | 4 | 5,180 | 15 | ≈1,050 | ES decoupling layer |
| **FAMP** | FA, OA, SP, math-ph | 20 | 5 | 4,200 | 6 | ≈860 | – |
| **PRDS** | PR, ST, DS | 28 | 4 | 6,250 | 12 | ≈675 | PM, GN.4 stages |
| **COMB** | CO, cs.DM | 18 | 3 | 3,510 | 17 | ≈430 | AC.0–AC.3 |
| **LTCS** | LO, cs.CC/DS/LO/GT/IT, IT | 20 | 3 | 4,210 | 14 | ≈185 | LD.4, LD.6 |
| **total** | | **≈265** | **37** | **≈57,700** | **≈126** | **≈13,300** | **≈21,500** |

Each subsection names the families (members in parentheses), the standalone roadmaps, the first five to draft, and
what to do with existing supply. Waves: **A** startable now, **B** after a wave-A roadmap or an open PR merges,
**C** deeper.

### 5.1 NT: number theory, including the LMFDB lane ([slate](work/campaign_NT.md))

Supply is already large here, so the job is ownership and ordering.

- **LMFDB lane, nine standalone roadmaps:** LMFDBLabelsAndCompleteness, HyperellipticCurves, QuaternionArithmetic,
  ArtinRepresentations, SatoTateGroups, AdelicImagesAndModularCurves,
  EllipticCurvePeriodsAndModularParametrizations, HypergeometricMotives, PadicExtensionFamilies. The family
  **ArithmeticOfFiniteFields** (character sums, curves over 𝔽_q, abelian varieties over 𝔽_q) also belongs to the
  lane. All 23 proposals of the LMFDB report are placed; five geometric ones go to AG, ALG and GEO.
- **Other families:**
  - **ClassicalAutomorphicForms** (Maass, Hilbert, Bianchi, Siegel, noncongruence);
  - **MetaplecticFormsAndTheta** (finite quadratic modules and the Weil representation, half-integral weight, theta
    correspondence, higher metaplectic covers);
  - **AdelicAlgebraicGroups** (strong approximation, reduction theory, adelic Fourier analysis, Tamagawa measures,
    the lattice mass formula; it uses the five successor names already reserved by RestrictedProducts,
    IntegralLattices and OrthogonalSpinGroups);
  - **MultiplicativeNumberTheory** (primes in progressions and Siegel zeros, multiplicative functions in short
    intervals, anatomy of integers).
- **Standalone outside the LMFDB lane:** FormalGroupsAndLubinTateTheory, which fills the unowned Lubin–Tate
  prerequisite and feeds TOP's chromatic theory; PowerReciprocityLaws; BirationalAnabelianGeometry; ArakelovGeometry.
- **Campaign consolidation:** of the 109 arithmetic campaign roadmaps, 96 go into 44 promotion units in six lanes, each
  with a demand score; 6 are absorbed by the slate (AnalyticNumberTheory and GeometryOfNumbers dissolve) and 7 go to
  other campaigns.
  Promote first: ArithmeticGaloisRepresentations, ArithmeticGaloisDuality, PadicMeasures, SieveMethods, ShimuraData.
  Four duplicates inside the campaign itself are marked: Selmer vs Poitou–Tate, Hida theory twice, function-field
  zeta, and theta/Jacobi forms three times.
- **Merge first:** #286 → #248 → #253, then #287, #432, #226, #451. Together they gate 11 of the 18 slate units.
- **Draft first:** AdelicAlgebraicGroups, ArithmeticOfFiniteFields, ClassicalAutomorphicForms,
  MultiplicativeNumberTheory (it can port about a million sorry-free OAI lines), LMFDBLabelsAndCompleteness.

### 5.2 AG: algebraic geometry ([slate](work/campaign_AG.md))

- **Families:**
  - **ModuliTheory** (algebraic spaces, algebraic stacks, Hilbert/Quot/Picard schemes, GIT, curves and stable maps,
    sheaves and Higgs bundles);
  - **BirationalGeometry** (resolution, singularities of pairs, asymptotic positivity, vanishing, MMP, rational
    curves and Fano varieties, K-stability);
  - **HodgeTheory** (complex analytic spaces, Kähler manifolds, Hodge theory of varieties, VHS, Mumford–Tate groups,
    K3/hyperkähler);
  - **SheafTheory** (coherent duality, derived categories, perverse sheaves, D-modules, microlocal sheaves).
- **Standalone:** IntersectionTheory, EquivariantCohomologyAndLocalization, GromovWittenTheory, ToricVarieties,
  FlagVarieties, AffineGrassmannians, ReductiveGroupSchemes, GeometryOfCurves, AbelianVarieties, SingularityTheory,
  AlgebraicSurfaces.
- **Campaign consolidation:** 34 campaign roadmaps (étale and ℓ-adic, Weil conjectures, motives, perfectoid and
  diamonds, crystalline and prismatic, Fargues–Fontaine, Habiro) go into 15 units, for example Weil 3 → 1 and
  diamonds/six operations 7 → 2. The 17 arithmetic math.AG-primary roadmaps (Shimura, PEL, Néron, Arakelov) go to NT.
- **Before drafting:** adopt #196. Merge #545, which 28 needs name as owner, after reconciling it with OAI's
  `NumericalDimension` (29k lines building the same divisor and discrepancy layer).
- **Draft first:** IntersectionTheory, ResolutionOfSingularities, HilbertQuotAndPicardSchemes, SingularitiesOfPairs,
  AlgebraicSpaces.

### 5.3 ALG: algebra ([slate](work/campaign_ALG.md))

- **Families:**
  - **GeometricGroupTheory** (combinatorial group theory, groups acting on trees, coarse geometry and hyperbolic
    groups, nonpositive curvature, Artin groups and Garside, finiteness properties, nilpotent/solvable/linear groups,
    amenability and property (T), group rings). At ≈2,000 PRs it should land in two batches.
  - **RepresentationsOfReductiveGroups** (Hecke algebras and Kazhdan–Lusztig, Soergel bimodules, finite groups of Lie
    type, rational representations, Springer theory and localization, types and supercuspidals). Birkbeck's
    SmoothRepresentationsOfLocalGroups becomes its p-adic foundation.
  - **CommutativeAlgebra** (Cohen–Macaulay rings, multiplicities, graded free resolutions, locally nilpotent
    derivations).
  - Five new members of the **existing RepresentationTheory family** (modular representation theory, Kac–Moody,
    crystal bases, tilting, rational and integral representations). These need its maintainers to lift two stated
    exclusions.
- **Standalone:** LatticesInSemisimpleGroups, StructureOfFiniteGroups, NoncommutativeRingTheory, UniversalAlgebra,
  TensorCategories, VertexAlgebras, GrothendieckTeichmuller.
- **Merge soon:** #446/#698, #447/#697, #57, #437.
- **Draft first:** AmenabilityAndPropertyT, CoarseGeometryAndHyperbolicGroups, CombinatorialGroupTheory,
  ModularRepresentationTheory, HeckeAlgebrasAndKazhdanLusztigTheory.

### 5.4 TOP: topology, categories, K-theory ([slate](work/campaign_TOP.md))

- **Families:**
  - **StableHomotopyTheory** (spectra, infinite loop spaces and ring spectra, Steenrod algebra and Adams spectral
    sequence, topological K-theory, complex cobordism, chromatic homotopy, equivariant stable homotopy);
  - **AlgebraicKTheory** (classical, higher, of schemes, trace methods, Hermitian and L-theory, motivic homotopy, the
    norm residue theorem). It absorbs eight Birkbeck K-theory roadmaps and EnhancedDerivedSheaves.
- **Standalone:** UnstableHomotopyTheory, HomotopicalAlgebra, InfinityCategories, StrictHigherCategories,
  CharacteristicClassesAndCobordism, KhovanovHomology, HyperbolicManifolds, TeichmullerTheory, ThreeManifoldTopology,
  SurgeryTheoryAndFourManifolds, TransformationGroups, TopologicalSixOperations, TopologicalCombinatorics.
- **Ownership fixes:**
  - Spectra get one owner, since #284 and Birkbeck's StableHomotopyKTheory both claimed them.
  - KhovanovHomology owns Rasmussen's s, which GeometricTopology expected from CombinatorialHeegaardFloer.
- **Merge first:** #435, #436, #437, #284, #432, #271.
- **Draft first:** UnstableHomotopyTheory, HomotopicalAlgebra, KhovanovHomology, StableHomotopyTheory with Spectra,
  TopologicalSixOperations.

### 5.5 GEO: geometry ([slate](work/campaign_GEO.md))

- **Families:**
  - **RiemannianGeometry** (curvature and submanifolds, comparison geometry, symmetric spaces, variational theory of
    geodesics, Ricci curvature and limit spaces, isometric embeddings);
  - **GlobalAnalysisOnManifolds** (elliptic operators, spectral geometry, Dirac operators and index theory, minimal
    submanifolds, geometric flows, gauge theory);
  - **SymplecticAndContactGeometry** (symplectic manifolds, contact geometry, pseudoholomorphic curves, Floer theory).
- **Standalone:** ConnectionsAndCharacteristicClasses, LorentzianGeometry, KahlerGeometry, MetricGeometry,
  MetricEmbeddings, ConvexBodies, PackingCoveringAndEnergy.
- **EllipticOperators is the wave-A priority:** it is the single owner of analysis on closed manifolds.
- **Existing supply:** close #334, which DifferentialGeometry superseded. Merge #480, #655 and #723.
- **Draft first:** EllipticOperators, RiemannianGeometry with its first two members,
  ConnectionsAndCharacteristicClasses, ContactGeometry with SymplecticManifolds, ConvexBodies.

### 5.6 ANA: analysis and PDE ([slate](work/campaign_ANA.md))

- **Families:**
  - **HarmonicAnalysis** (classical Fourier, real-variable, time-frequency, restriction, decoupling, Kakeya and
    Brascamp–Lieb);
  - **GeometricMeasureTheory** (rectifiability and BV, currents and varifolds, minimal boundaries and isoperimetry,
    quantitative rectifiability, fractal geometry);
  - **ComplexAnalysis** (geometric function theory, quasiconformal maps, linear ODE and special functions, several
    complex variables, Oka theory, pluripotential theory);
  - **NonlinearPDE** (nonlinear elliptic, free boundaries, calculus of variations, dispersive, kinetic, hyperbolic
    systems, Einstein evolution, convex integration, unique continuation and inverse problems).
- **Standalone:** ConicOptimizationAndSpectrahedra, ValidatedNumerics.
- **Porting:** the `carleson` project is ready to port, under the "coordinate first" rule with its authors.
- **Merge first:** #237, #93, #279, #117.
- **Draft first:** HarmonicAnalysis with RealVariableHarmonicAnalysis, GMT with RectifiabilityAndBV, ComplexAnalysis
  with SeveralComplexVariables, FourierRestriction, NonlinearPDE with HyperbolicSystemsAndConservationLaws.

### 5.7 FAMP: functional analysis, operator algebras, spectral theory, mathematical physics ([slate](work/campaign_FAMP.md))

- **Families:**
  - **OperatorAlgebras** (von Neumann algebras, modular theory, nuclear C*-algebras, C*-regularity, operator
    K-theory, free probability, L² invariants);
  - **SpectralTheory** (unbounded operators, Schrödinger, Sturm–Liouville and Jacobi, random Schrödinger);
  - **QuantumTheory** (quantum information, many-body QM, quantum spin systems, axiomatic QFT);
  - **BanachSpaceTheory** (bases and classical spaces, local theory, nonlinear geometry);
  - a two-member extension to the operator-theory family of **PR #126**.
- **#126 is the most important single step:** 10 of the 20 roadmaps depend on it, and it has awaited review since
  07-31.
- **Draft first:** VonNeumannAlgebras with NuclearCStarAlgebras, SpectralTheory tranche 1, the #126 extension,
  QuantumInformationTheory with QuantumSpinSystems, BanachSpaceTheory.

### 5.8 PRDS: probability and dynamics ([slate](work/campaign_PRDS.md))

- **Families:**
  - **StochasticProcesses** (Markov chains and mixing, Brownian motion, stochastic calculus, concentration and
    functional inequalities, Gaussian analysis and log-concave measures, large deviations);
  - **StatisticalMechanics** (Bernoulli percolation, lattice Gibbs measures, random-cluster and random currents,
    mean-field spin glasses, lattice random walks, SLE, Gaussian free field, integrable lattice models, random media,
    continuum Gibbs systems; covers Annals #97);
  - **RandomDiscreteStructures** (random walks on graphs and networks, random trees and maps, random graphs and
    constraint satisfaction);
  - **DynamicalSystems** (ergodic theory, entropy and thermodynamic formalism, smooth ergodic theory, homogeneous
    dynamics, measured group theory, ergodic Ramsey theory, twist maps/billiards/KAM, qualitative ODE and
    bifurcations; covers Annals #93, #95, #96).
- **Standalone:** StrongConvergenceOfRandomMatrices (Annals #99; FAMP's FreeProbability also claimed it, and §9
  ruling 4 gives it to PRDS).
- **One definition each:** total variation lives in MarkovChainsAndMixing, against the ~30 OAI copies. PRDS claims
  Harris–FKG, BK, Russo–Margulis and cube hypercontractivity, which COMB's BooleanFunctionAnalysis would consume.
- **Merge soon:** #397 RandomMatrices (30 needs wait on it), with the slate generalizing its concentration,
  large-deviation and Itô declarations in place by alias; #417 PointProcesses (its "ergodic-theory roadmap" becomes
  ErgodicTheory). Extend #449 with a Poisson–Dirichlet/GEM/Ewens layer. Archive Exchangeability.
- **Coordinate first** with the Degenne et al. Brownian-motion Lean project.
- **Draft first:** ErgodicTheory, ConcentrationAndFunctionalInequalities, MarkovChainsAndMixing, LatticeGibbsMeasures,
  then StochasticCalculus with BrownianMotion.

### 5.9 COMB: combinatorics ([slate](work/campaign_COMB.md))

- **Families:**
  - **GraphTheory** (matchings and factors, coloring, structural graph theory, spectral graph theory, expanders;
    covers Annals #94);
  - **ExtremalAndProbabilisticCombinatorics** (probabilistic method, extremal graph theory, Ramsey theory, extremal
    set theory);
  - **EnumerativeAndAlgebraicCombinatorics** (enumeration, symmetric functions, log-concavity and stable polynomials,
    matroids and submodularity, designs and finite geometry).
- **Standalone:** BooleanFunctionAnalysis; DiscreteGeometryAndIncidences (it owns Borsuk–Ulam via Tucker's lemma);
  PolyhedralCombinatorics; AdditiveCombinatorics (Birkbeck's stages AC.0–AC.3).
- **Merge soon:** #66, #444, #271. #271 already has Euler's formula, Kuratowski, Wagner and the five-color theorem,
  so StructuralGraphTheory builds on it.

### 5.10 LTCS: logic, computation and information ([slate](work/campaign_LTCS.md))

- **Families:**
  - **ComputationalComplexity** (machine models, complexity classes, space and pseudorandomness, circuits and
    communication, PCP and hardness of approximation, algebraic complexity, descriptive complexity);
  - **Algorithms** (combinatorial, algebraic, online, metric embeddings and convex relaxations);
  - **MathematicalLogic** (proof theory, computability, model theory including o-minimality, set theory and forcing,
    descriptive set theory for Annals #98, λ-calculus and type theory).
- **Standalone:** QuantumComputation, InformationAndCodingTheory, AutomataLogicAndGames.
- **Design pin (§3.0 of the slate):** problems are over `List Bool`. Time is measured on Mathlib's `FinTM2` with every
  alphabet finite, and upper bounds are proved through a structured bit-stack language compiled with exact cost
  (after OAI's `Superstring`). Current Mathlib names (corrected in the slate's §8):
  - `TM2ComputableInPolyTime` takes encodings `Encoding α Γ` with `[Fintype Γ]`; `FinEncoding` is a deprecated alias.
  - The composition theorem is still only a `proof_wanted`, now under `Wanted/`. Simulation theorems make P, FP and PSPACE model-independent; P ≠ NP, ETH and UGC are
  named propositions used only as hypotheses.
- **Reconcile #717's Layer 1** (polynomial-time composition) with MachineModels before #717 merges.
- **Draft first:** ComputationalComplexity with MachineModels and ComplexityClasses (this makes 28 OAI families
  statable and consolidates six OAI hardness projects), InformationAndCodingTheory, MathematicalLogic with
  DescriptiveSetTheory and ComputabilityTheory.

## 6. Coordination model

From [`work/coordination.md`](work/coordination.md), which also covers the explorer's build, the overlap audit and
the full protocol.

### 6.1 The owner's suggestion: per-arXiv-label forks of tauceti-explorer

Spokes are right as a **drafting** layer. Four corrections:

1. **Ten forks, not thirty.** math.NT and math.AG are too big for one lead and need lanes (NT 6, including the LMFDB
   lane; AG 3). Most other arXiv classes are too small for a lead of their own and are grouped. That gives ten
   campaigns and seventeen lanes.
2. **`content/campaign/` is an output of the explorer build, not an input.** The snapshot build needs files that are
   not in the repository (`EDITION.json`, `campaign/MANIFEST.json`, the graph indexes), so editing `content/campaign/`
   in a fork changes nothing. Forks should add roadmaps the way the explorer already adds new ones: one
   `research/blueprint/roadmaps/<Id>.json` per roadmap plus its packets. 32 such drafts already exist, several
   outside number theory (RiemannianGeometry, SymplecticContactGeometry, SeveralComplexVariablesKahlerGeometry);
   the slates reuse them. Alternatively, Chris publishes the snapshot inputs.
3. **One hub regenerates the atlas.** Forks commit only per-roadmap source files. Roadmap IDs are reserved centrally,
   because the build fails on a duplicate ID and silently passes the same mathematics under two IDs. Distances must be
   recomputed at the hub, since each fork rescales to its own farthest roadmap.
4. **GitHub allows one fork of a repository per account**, so ten spokes need ten owners or organizations, or plain
   copies. GitHub also disables Actions and issues on forks by default, so the explorer's planning swarm must be
   re-enabled per spoke.

### 6.2 Protocol

- **Precedence.** TauCetiRoadmap `main` is normative, then the hub registry, then the spoke. Fleets implement only
  merged roadmaps; consumers may work ahead on lookahead branches against sorry'd stubs.
- **Registry.** The hub holds `data/campaigns.toml`: every campaign (leads, classes, MSC codes) and every *planned*
  roadmap (owner, status, a 30-day renewable claim, `requires`, `exports`). It is the claim system for roadmap
  *authorship*; Tau Ceti's claims stay the system for code. Hub CI rejects unregistered IDs, topics outside a
  campaign's classes, and duplicate names against TauCetiRoadmap.
- **Boundary rules.**
  - A concept is owned by the campaign of the prerequisite theory, in the most general form its consumers need.
  - Ties are broken by arXiv practice.
  - "Arithmetic X" stays a consumer of X.
  - A roadmap that straddles two campaigns is split by stage, never duplicated.
  - A "Part II" inherits its parent's topic only if the parent's author accepts it; otherwise it is a sibling roadmap
    with its own topic.
  - A boundary dispute goes to a hub issue, which the two leads settle within seven days.
- **Names** describe content: no "PartII", no category prefix, no `Campaign` namespace.
- **Promotion gates into TauCetiRoadmap:**
  1. registry reservation;
  2. blueprint with independent review;
  3. drift check against Tau Ceti main and every open PR;
  4. condense to a 40–90 KB TauCetiRoadmap-shaped README;
  5. a `Suggested.lean` that builds;
  6. `metadata.toml`;
  7. suppliers merged first;
  8. a reverse-import build (main plus this PR alone);
  9. a human poster who has read it.
- **Caps.** At most three open new-roadmap PRs per campaign, and none while one of its PRs has been awaiting the
  author for more than seven days. Each wave of promotions gets a family review, and each campaign PR gets a reviewer
  from outside its campaign.
- **Duplicates.**
  - Planning layer: boundary jobs over campaign pairs that share MSC codes or reserved terms, and a re-run of the
    explorer's 33 restructure families against current main and open PRs.
  - Code layer: one claim namespace, claims that last the life of the PR, and a merged-twin check.

## 7. Sequencing: 26 weeks

The window fixes the shape:
- A roadmap approved after about week 18 cannot be implemented in time, so all tier-1 authoring and review falls in
  weeks 0–18.
- Fleet throughput ramps to full by week 6.
- The last eight weeks are absorbed by second-tier work, which needs finished foundations rather than new roadmaps.

### 7.1 Week 0–1: decisions and the review fast track

- **Settle the decisions in §10, items 1–6:** hub and leads, the fast track, the #196 adopter, boundary rulings, the
  operating point, write identities.
- **Propose a fast track for campaign roadmaps to @TauCetiProject/humans.** It changes TauCetiRoadmap policy, so it is
  their call. Three options, which combine:
  - (a) campaign leads join roadmap-reviewers on appointment rather than after two merged roadmaps, and each campaign
    PR needs one approval from a reviewer outside its campaign;
  - (b) an umbrella README gets full review, and its members merge with one approval once machine pre-review passes
    (the README checklist, a `Suggested.lean` build, a drift check against Tau Ceti main and open PRs, and a
    duplicate check against the registry);
  - (c) an "approved for implementation" state: fleets start after one approval while a second review continues,
    and corrections land as roadmap edits.
- **Also this week:**
  - Apply the boundary rulings to the slate files.
  - Instrument the review engine's spend and authoring rounds' PR numbers (the cost per PR is already measured).
  - Start the GitHub App work.
  - Propose a "Planned roadmap" issue template, so planned roadmaps are visible where workers look (precedent: hold
    #525).

### 7.2 Weeks 1–6: ramp

- **Review the backlog:** the ≈45 open roadmap PRs (≈4,000 PRs of surface), the eight archive PRs, and the supplier
  list in §0 item 3.
- **Draft wave A.** Each campaign drafts its first five in weeks 1–2 and the rest of its wave A by week 6: ≈125
  roadmaps, as ≈50 umbrella-and-tranche reviews.
- **Promote campaign units.** NT and AG condense and promote their first 10–15 units; the blueprints already exist.
- **Bring extra fleets online as identities arrive:** three more by week 2, eight by week 6. Target ≈8,000 PRs/week
  by week 6 and ≈$0.25M spent in month 1.
- **Turn on the quality spend** (second independent review, cleanup passes, best-of-n retries) from week 2, and
  measure its value weekly alongside the cost per PR.

### 7.3 Weeks 6–12: wave B and the second tier

- Draft and approve wave B (≈95 roadmaps) and the remaining promotion units.
- **By week 8**, conclude coordination with OpenAI. The paper-formalization and porting lanes start on families whose
  wave-A foundations have landed.
- Hold ≈$130k/week.

### 7.4 Weeks 12–18: last approvals

- Approve wave C (≈30) and the last promotion units by week 18. No tier-1 roadmap is approved after that.
- Start completion audits on wave-A roadmaps.

### 7.5 Weeks 18–26: drain

- Fleets finish the wave-B and wave-C roadmaps; slack goes to the second tier.
- Run a final completion audit per campaign, followed by archive PRs.

### 7.6 Closing the surface gap: the second tier

| sink | rough size (PRs) | roadmap review | window | notes |
|---|---:|---|---|---|
| Formalize the OpenAI papers against Tau Ceti | 15–30k | none, if it lives outside TauCetiRoadmap | weeks 8–26 | 23 elementary families now; the 208 families that need roadmaps as their foundations land. OAI's comparator statements are the acceptance tests. Where it lives is a decision (§10). |
| Port OpenAI's existing formalizations onto Tau Ceti definitions | 10–20k | registry only | weeks 6–20 | Needs OpenAI's agreement. Replaces per-paper copies of foundations (TM2 libraries, total variation, curvature in charts) with Tau Ceti's definitions. Apache-2.0. |
| Certified LMFDB data | 5–10k | inside LMFDBLabelsAndCompleteness | weeks 10–26 | Lean certificates for LMFDB tables (small-conductor curves, transitive groups, number fields), extending Birkbeck's CertifyingInvariantsNF. |
| Areas the slates left out | 10–15k (40–60 L roadmaps) | full | weeks 4–16 | PRDS: complex and Berkovich dynamics, statistics, SPDE, Lévy processes. FAMP: integrable quantum models. ANA: numerical analysis, control. The explorer's unmapped statistical inference and optimization. LMFDB future sections (genus 3, abelian surfaces, K3, Calabi–Yau, Shimura varieties, function fields, Weil–Deligne, GL(3) Maass, U(2,1)). The 25 Annals reserve definitions. Lower priority than tier 1, since it competes for review. |
| Quality spend per PR | ≈$5–8 per PR (≈30–40% of spend at the recommended operating point) | none | from week 2 | A second, independent review per PR; a cleanup, generalization and documentation pass per merged file; best-of-n and maximum effort on items that failed once. The measured ≈$10 per PR leaves room for this; track review findings and later fixes to judge its value. |
| **total** | **≈40–75k** | | | |

Tier 1 (≈92k) plus the second tier gives ≈130–165k PRs of surface. At the recommended $20 per PR that covers the
$3M's ≈130k PRs, and covers today's fleets as well (≈190k) only at the top of the second tier's range, so item 8 of
§10 matters. The sizes in this table are planning estimates; re-derive them once the slates' own cost per PR has
been measured.

## 8. OpenAI's Lean library

- **Size:** 121,734 Lean files, organized like Mathlib. The largest trees are Analysis (26k files), NumberTheory (24k),
  Combinatorics (16k), Geometry (14k) and Probability (13k). License Apache-2.0.
- **Dependencies:** it depends on Tau Ceti, CBirkbeck/AINTLIB, a ClassFieldTheory repository, carleson, StrongPNT,
  sphere-eversion, gromov and others. In practice almost no file imports Tau Ceti (5 files, all in SLE), and the
  number-theory files use PrimeNumberTheoremAnd and StrongPNT.
- **Formalization coverage:** the catalogue flags 162 manuscripts. Lean scope pages with comparator statements exist
  for many more families (NT 16/31, combinatorics/TCS 65/77, probability 36/54, geometry 40/74). These are often
  supporting lemmas, not main theorems.
- **The infrastructure is re-built per paper.** Six hardness projects (~900k lines) each carry a private TM2 library
  and their own PCP proof, and Cook–Levin is proved three times. Total variation is defined ~30 times, mixing time
  ~15 times, and curvature in charts in six or more directories; operator-algebra notions are each redefined three or
  more times.
- **Policy recommendation:**
  - Use the comparator statements as **statement templates and acceptance tests**: a family's roadmap is done when
    its statement can be written against Tau Ceti's definitions and is proved equal to OAI's comparator.
  - Port reusable developments only after **coordinating with OpenAI** (README: "coordinate first"). The licence
    permits adaptation, but Tau Ceti fixes one Mathlib-shaped definition and proves equivalence rather than vendoring
    ad hoc encodings.
- **Highest-value porting sources by campaign:**
  - NT: MultiplicativeNumberTheory (~1M sorry-free lines), `DukePrimeDegree`;
  - AG: `Seshadri` (56k: Rees blowups, Bertini, surface intersection theory);
  - ALG: `RingTheory/BassTrace`, `Multiplicity`, `PolycyclicRecognition`;
  - TOP: strict ω-categories and Thomason;
  - GEO: `RCD`, `CAT0Fillings`;
  - PRDS: `SLE` (Brownian strong Markov, Itô isometry), `UnimodularPercolation`;
  - COMB: `SharpThreshold`, `Crossing`;
  - LTCS: `Superstring`, `CookLevin`, `PartitionConsistency` (forcing), `DegreeRigidity` (84k).
- **OpenAI claims Lean proofs of frontier results** (the Unique Games theorem, Slaman–Woodin). Whether such proofs
  become final milestones once they check against Tau Ceti's definitions is a separate decision (§10).

## 9. Cross-campaign boundary questions to rule

The planners ran in parallel under the pre-decided owners in `work/BOUNDARIES.md`. A final pass over all ten slates
([`work/boundary_pass.md`](work/boundary_pass.md)) found the following:

- 41 cross-campaign double ownerships, each with quotes from both sides and a recommended owner;
- about 45 dangling prerequisite names, mostly renamed proposals;
- twelve concepts with no owner at all;
- 29 hand-offs that no receiving slate absorbed, several bouncing between two campaigns;
- three dependency cycles: VonNeumannAlgebras ↔ NuclearCStarAlgebras, two inside COMB, and ANA FractalGeometry ↔
  PRDS entropy;
- eleven wave inversions, plus 50 wave-A roadmaps that depend on unmerged open PRs;
- four Birkbeck roadmaps or stage groups counted by two campaigns:
  - VStackSheavesAndLisseCategories (NT and AG);
  - K(𝔽_q) (NT and TOP);
  - the patching-algebra stages (NT and ALG);
  - the local stages of AutomorphicSpectralTheory and EndoscopicTransfer (NT and ALG).

Its 25 rulings are in §5 of that file. The ones that change slates materially:

1. **Néron models and p-divisible groups** are orphans that seven NT items and AG's AbelianVarieties import. Make them
   one AG promotion unit, with Birkbeck's AbelianSchemesAndArithmeticModuli and NeronModels promoted early. The NT and
   AG planners both recommend this.
2. **#196 and the merge-first list.** Name #196's adopter now. Then either merge #437, #126, #397, #271, #444, #66,
   #248 and #286, or relabel their wave-A dependents as wave B.
3. **Metric embeddings.** GEO and LTCS both slated a roadmap. Split three ways: LTCS takes finite metric spaces and
   embeddings, FAMP takes Lipschitz extension and coarse embeddings, GEO keeps an M roadmap on doubling and
   quasisymmetric geometry. This removes about 150 duplicated PRs.
4. **Strong convergence (Annals #99).** It goes to PRDS's StrongConvergenceOfRandomMatrices; FAMP's FreeProbability
   drops its last layer.
5. **Geometric measure theory regularity** (De Giorgi, Simons cone, Bernstein) goes to ANA; GEO's MinimalSubmanifolds
   keeps the smooth theory.
6. **Topological combinatorics.** TOP owns Borsuk–Ulam, ham sandwich and Lovász–Kneser. COMB keeps
   Sperner/KKM/Tucker and withdraws its Borsuk–Ulam claim.
7. **Correlation and functional inequalities.**
   - Hypercontractivity, log-Sobolev and Ornstein–Uhlenbeck go to PRDS.
   - Harris–FKG, BK, Russo–Margulis and OSSS go to COMB.
   - In general, finite deterministic structures are COMB's and random or infinite ones are PRDS's.
   - Each OAI porting directory gets one owner; both had listed `StrongRayleigh`.
8. **Bundles and characteristic classes.** TOP owns the topological carriers and theorems; GEO owns connections and
   the Chern–Weil comparison. For Kähler geometry, confirm the drafted split: AG owns the Kähler condition and Hodge
   theory, GEO owns the canonical metrics.
9. **K-theory.** Bott periodicity goes to FAMP; K₀, the Hattori–Stallings trace and K(𝔽_q) go to TOP.
10. **Analysis that NT consumes.** ANA owns K-Bessel and Whittaker functions, stationary phase and Levelt's theorem;
    NT's HypergeometricMotives consumes them, which fixes a wave inversion. Stone–von Neumann goes to FAMP, in an early
    slot.
11. **Curves and abelian varieties.**
    - The Riemann hypothesis for curves is NT's (ArithmeticOfFiniteFields), and AG's WeilConjectures consumes it.
    - Hyperelliptic geometry over an algebraically closed field is AG's.
    - CM over ℂ is AG's.
12. **Birkbeck promotion conflicts.**
    - VStackSheaves goes to AG.
    - The local AutomorphicSpectralTheory and EndoscopicTransfer stages go to ALG.
    - ALG adds SmoothRepresentationsOfLocalGroups as the first member of RepresentationsOfReductiveGroups; its
      HeckeAlgebras member needs SR.1.
13. **Orphans, assigned:**
    - Hilbert modular surfaces and the Habiro pair → NT;
    - the remainder of EnhancedDerivedSheaves → AG SheafTheory;
    - Gleason–Yamabe → ALG;
    - Milnor–Thom/Warren bounds → a new AG successor of RealAlgebraicGeometry;
    - higher Chow groups → AG;
    - nonlinear parabolic PDE → ANA;
    - translation surfaces → TOP;
    - the ellipsoid method → LTCS;
    - FPRAS and simulated annealing → PRDS;
    - the LPS Ramanujan property → NT.
14. **Two decisions that are not boundaries** but must be pinned before drafting:
    - the point-set model of spectra (TOP recommends symmetric spectra of simplicial sets);
    - the reference model of computation (LTCS's design pin, §5.10).
15. **Consent required.** Every stage moved out of the Birkbeck campaign needs Chris's agreement (§5 and
    `coordination.md` §3.3). ALG's five additions to RepresentationTheory need its maintainers to lift that family's
    modular and Kac–Moody exclusions.

Applying these rulings is the next step before any slate roadmap is drafted. They are edits to the ten slate files,
followed by re-running `normalize_slates.py`; they change totals by a few percent, not the plan's shape.

## 10. Decisions for the owner

Items 1–6 are needed in week 1; the window does not allow them to wait.

1. **Accept ten campaigns and seventeen lanes** in place of one fork per arXiv label, and **settle the hub with
   Chris**: location, governance, publishing the snapshot inputs, consolidating and renaming his roadmaps.
2. **Name the ten campaign leads** (with the owner steering NT's LMFDB lane) and the first reviewers.
3. **Take the review fast track (§7.1) to the Tau Ceti humans.** This is the decision the 6-month window depends on
   most.
4. **Name an adopter for PR #196,** and set the order of the backlog reviews.
5. **Rule the boundary questions in §9,** starting with Néron models and abelian schemes (1) and metric embeddings (3).
6. **Choose the operating point.** The measured cost is ≈$10.35 per PR; the recommendation is ≈$20 by design, with
   the quality share listed in §7.6. Instrument the review engine's spend and authoring rounds' PR numbers, and turn
   on `rounds.jsonl` for gqm and gqw, so the cost can be re-measured weekly (`work/cost_calibration.md`).
7. **Write capacity:** the GitHub App within three weeks, and how many interim identities to run at the 30/hour gate.
   Every identity stays well under GitHub's secondary limits.
8. **Today's fleets:** do they keep drawing on the same roadmaps? At the recommended operating point, surface demand
   is ≈190k PRs if they do and ≈130k if the $3M fleets replace them; only the second figure fits comfortably in tier 1
   plus the second tier.
9. **The second tier:** where the OpenAI paper formalizations live (a Tau Ceti area, a separate repository consuming
   Tau Ceti, or with OpenAI), and engaging OpenAI on porting and consolidation, including whether their claimed
   frontier proofs become milestones.
10. **Get an LMFDB knowl export,** so the per-knowl audit can be finished.
11. **Decide whether each campaign's slate goes into the explorer as blueprint drafts** (`research/blueprint/roadmaps/`)
    or straight to TauCetiRoadmap PRs after condensation. Under the 6-month window, small campaigns should go
    straight to PRs.
12. **References (§11):**
    - Allow the zbMATH verification to resume; it stopped on an HTTP 502 with 2,024 works unchecked.
    - Fetch the 683 freely available works into `references/` from legitimate sources.
    - Arrange library access for the library-only works, wave A first.

## 11. References for the roadmaps

Every proposed roadmap, umbrella family and campaign promotion unit now carries a reference list: 360 records, 3,804
citations, **3,063 distinct works**. Of these, 2,547 are books, papers and notes; 433 are code and formal sources;
58 are OpenAI manuscripts cited as statement sources; the rest are Tau Ceti roadmap READMEs and web resources.

**What a list contains.** Each roadmap's list gives:
- its primary texts (graduate books or monographs with complete proofs);
- a source for each headline theorem those texts do not prove;
- the source whose **conventions** the roadmap should pin, wherever standard texts disagree;
- its formal sources: Mathlib and Tau Ceti files, OpenAI `lean/OAI` directories, external Lean projects;
- for frontier milestones, the paper whose result the roadmap states.

The campaigns' pinned conventions are at the head of each campaign's §8. Examples:
- Lee's sign for curvature and Δ = div grad ≤ 0;
- Mathlib's e^{−2πi⟨x,ξ⟩} Fourier transform, and normalized Hausdorff measure;
- Fulton's grading of Chow groups by dimension, with Proj Sym E for projective bundles;
- Deligne's Corvallis convention for the Deligne torus;
- symmetric spectra of simplicial sets;
- Levin–Peres for mixing times.

**Where the lists live:**
- `campaign_<CODE>.md` §8: short citations per roadmap, plus the campaign's acquisition list (18–46 KB each);
- `refs_<CODE>.json` and the `references` field of each `slate_<CODE>.json` entry: full records, each with
  `master_key` and `verified`;
- [`work/references_master.md`](work/references_master.md) / `.json`: the deduplicated bibliography, with
  - (a) a summary;
  - (b) the acquisition list;
  - (c) the 100 most-used works;
  - (d) items for a human to check;
  - (e) code sources by repository;
  - (f) full entries.

**Most-used works** (number of roadmaps):
- the Stacks Project (15);
- Weibel's *K-book* (8);
- Khare–Wintenberger, *Serre's modularity conjecture II* (7);
- Scholze, *Étale cohomology of diamonds* (7);
- Arora–Barak (6);
- at 5 each: Allen et al., *Potential automorphy over CM fields*; Bridson–Haefliger; Bruns–Herzog; Fargues–Scholze;
  Hartshorne; Lyons–Peres; Petersen; Platonov–Rapinchuk; Rodrigues Jacinto–Williams; Serre, *Local Fields*.

By the earliest wave that needs it, 1,582 works serve wave A, 1,034 wave B and 447 wave C.

**Acquisition.** Excluding code and manuscripts, works not held locally fall into three groups:
- **683 freely available:** a download list with URLs, ordered by wave and use. They should go into `references/`
  only from legitimate sources, as the July batch did.
- **1,762 library-only.**
- **54 to purchase,** such as Arora–Barak.

Only 48 works are already held locally, mostly in the gq2 and July LMFDB collections.

**Verification is partial.** The lists were compiled from local sources and knowledge, then checked in a single
polite pass:
- **Verified:** 197 works against the explorer's catalogue of sources its workers read, 182 on zbMATH, 94 on arXiv,
  20 on Crossref, 100 against local copies, and 394 code paths against the local checkouts.
- **zbMATH stopped** with an HTTP 502 at request 203, and the pass stopped using it, as its rule requires. **2,024
  works remain unverified.** Re-running the pass resumes from its cache without repeating a request.
- **760 corrections were made.** They include four wrong identifiers (an arXiv ID and three DOIs that pointed to other
  works). 318 "free" claims were downgraded to library; only 41 of those were checked online, and the other 277 await
  the resumed pass.
- **Not checked at all:** chapter and section pointers recalled rather than read (HTT, Milnor–Stasheff,
  Goerss–Jardine, Farb–Margalit, Walters, Dembo–Zeitouni, Lyons–Peres and others). Two conflicting Stacks Project
  tags were left for a human.

Section (d) of the master lists everything above.

The compilers also found two errors in the slates, both now fixed:
- the Leech lattice VOA has dim V₁ = 24, not V₁ = 0;
- LTCS's design pin used outdated Mathlib names (§5.10).

## 12. Caveats

- **PR estimates are ±50%.** They rest on the measured ratio of about 14 PRs per layer and about one per target, and
  that ratio is drifting upward as fleets split milestones.
- **The cost per PR is measured on one fleet over 2.6 days,** with review spend estimated
  (`work/cost_calibration.md`). The slates' deeper material will likely cost more per PR. The 6-month numbers assume
  a six-week linear ramp and 35 PRs/week per active roadmap.
- **arXiv tags on OpenAI families are inferred,** since the release gives none.
- **About 370 of the 722 papers were classified from abstracts, keyword scans and Lean scope pages** rather than
  read at introduction depth.
- **LMFDB coverage rests on knowl titles and column names,** not knowl contents.
- **The planners ran in parallel.** The boundary pass (§9) found 41 cross-campaign conflicts; its rulings are not
  yet applied to the slate files, and finer overlaps inside individual slates remain likely.
- **`roadmap_leaves.json` leaves out NT's 44 promotion units** (added separately in §0 and §5), and NT's sub-roadmaps
  there have no wave or scope; read NT's numbers from `campaign_NT.md`.
- **Explorer data is the 09-14 snapshot plus later blueprints;** Tau Ceti main moves daily.

## 13. File index ([`work/`](work/))

| file | content |
|---|---|
| `BRIEF.md`, `PHASE2.md`, `BOUNDARIES.md` | the subagents' instructions and the pre-decided boundary table |
| `boundary_pass.md` | cross-slate audit: double ownership, dangling prerequisites, cycles, orphans, 25 rulings |
| `REFS_BRIEF.md`, `REFS_VERIFY_BRIEF.md` | instructions for compiling and verifying the references |
| `references_master.md`, `references_master.json` | deduplicated bibliography: acquisition list, most-used works, checks for a human, full entries |
| `refs_<CODE>.json` (10) | per-roadmap reference lists, with master keys and verification status |
| `capacity.md` | throughput, cost and constraint model |
| `cost_calibration.md` | measured cost per merged PR from the mimir fleet logs |
| `coordination.md` | campaign format, explorer build, overlap audit, protocol |
| `lmfdb.md`, `annals_1_51.md`, `annals_52_100.md` | goals 1 and 2: section/definition inventories and ownership |
| `openai_*.md` (7) | goal 3 by subject group: family tables, clusters, proposals, porting sources |
| `campaign_<CODE>.md`, `slate_<CODE>.json` (10 each) | the campaign slates |
| `needs_*.jsonl`, `needs_all.jsonl` | every need, with coverage and proposed owner (1,741 rows) |
| `roadmap_leaves.json` | all proposed roadmaps flattened (from `normalize_slates.py`) |
| `supply_*.json`, `supply_by_arxiv.md` | supply indexes: Tau Ceti main, open PRs, Birkbeck campaign |
| `openai_families.json` | the 372 families with manuscripts, abstracts and formalization flags |
| explorer `opportunities.json`, `roadmap-classification.json`, `roadmap-summaries.json`, `explorer_bibliography.json` | copied explorer data |
