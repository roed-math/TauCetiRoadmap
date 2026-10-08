# Shared brief for the Tau Ceti expansion-planning subagents (2026-10-07)

## Mission

The Tau Ceti project (an AI-welcome Lean 4 library downstream of Mathlib, steered by human-written
*roadmaps* in the TauCetiRoadmap repo) has received a large block of inference credits and must
expand its roadmaps so that automated workers have enough well-specified, non-overlapping work.
We are writing a **strategic plan of which roadmaps we need**, covering three goals:

1. **LMFDB**: everything needed to formalize the definitions used in the L-functions and Modular
   Forms Database (lmfdb.org).
2. **Annals**: everything needed for the 100 definitions in
   `/Users/roed/claude/handoffs/definitions_100_tauceti.md` (drawn from 157 Annals papers 2020–2026).
3. **OpenAI**: everything needed to formalize the 722 manuscripts (372 result families, 17 subjects)
   released at https://github.com/openai/math on 2026-10-06.

"Everything needed" means: the definitions needed to *state* the results, and the general theory
(named theorems, standard tools) needed to *prove* them. Paper-specific arguments are not roadmap
material; the reusable theory beneath them is.

Coordination proposal from the owner: one fork of `CBirkbeck/tauceti-explorer` per arXiv subject
category, each carrying a `content/campaign/` folder of roadmaps for that category (Chris
Birkbeck's existing campaign is essentially the math.NT one). So **tag every need and every
proposed roadmap with the arXiv category that would own it** (the category of the *prerequisite
theory*, not of the paper that uses it: étale cohomology is math.AG even when a math.NT paper needs it).

## Roadmap ground rules (from TauCetiRoadmap/README.md, normative)

Read `/Users/roed/claude/TauCetiRoadmap/README.md` section "Writing a roadmap" once. In short:
build the library (complete basic theory, not just the headline lemma); no gaps (every milestone
rests on Mathlib, Tau Ceti, earlier layers, or a cited roadmap); unambiguous items; clear,
non-overlapping boundaries; definite scope (nothing "optional"/"deferred"); timeless wording;
reusable material; Mathlib vocabulary; defer to Mathlib's design but never wait for it, never push
work to Mathlib. A good roadmap is *broad* (a graduate course's worth or more) and has a coherent
boundary that a reader can apply in few words.

## Where the supply side lives (what already exists or is planned)

All paths local. **Prefer local files and local git over network calls.**

- **Tau Ceti roadmaps on main** (51 active + 6 completed). Index with arXiv topic + summary:
  `/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/supply_tauceti_main.json`.
  Read one: `git -C /Users/roed/claude/TauCetiRoadmap show upstream/main:TauCetiRoadmap/<Name>/README.md`
  (completed ones under `upstream/main:Completed/<Name>/README.md`). Search all:
  `git -C /Users/roed/claude/TauCetiRoadmap grep -i -l '<term>' upstream/main -- 'TauCetiRoadmap/*/README.md' 'Completed/*/README.md'`.
  Each roadmap may have `STATUS.md` (machine-written progress) and `Suggested.lean`.
- **Open TauCetiRoadmap PRs** (78; ~45 add or expand roadmaps). Index:
  `/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/supply_open_prs.json` (fields `pr`, `dirs`,
  `title`, `body`). Every head is fetched locally as `upstream-pr/<N>`:
  `git -C /Users/roed/claude/TauCetiRoadmap show upstream-pr/<N>:TauCetiRoadmap/<Dir>/README.md`.
- **Chris Birkbeck's number-theory campaign** (152 roadmaps, not yet in TauCetiRoadmap; Sept 2026
  edition of the explorer). Sparse clone:
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/explorer/`
  — roadmaps at `content/campaign/<Name>/README.md` (long: ~40 KB each; grep rather than read
  whole), guides at `content/campaign-guide/`, copies of the Tau Ceti roadmaps it ingested at
  `content/tau-ceti/`. Index with summary, primary/secondary MSC and "distance from Mathlib" (0–10):
  `/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/supply_birkbeck_campaign.json`.
  The explorer's own list of 16 uncovered areas: `.../expansion_plan/work/opportunities.json`.
- **Earlier LMFDB plan** (2026-07-30, partly executed: its Wave 1 became ClassFieldTheory,
  AlgebraicCurves, NumberFieldArithmetic, PolynomialGaloisGroups, IntegralLattices (completed),
  LFunctions (PR #248), BelyiMaps; its Wave 2/3 was never drafted):
  `/Users/roed/claude/TauCetiRoadmap/lmfdb_background_plan.md`.
- **Tau Ceti code** (10,890 Lean files, commit a91d3aafa, 2026-10-05), read-only:
  `/Users/roed/claude/tauceti-archive-base/.lake/packages/TauCeti/TauCeti/`.
  **Mathlib** (6b7abb3c, 2026-09-28), read-only: `/Users/roed/claude/tauceti-archive-base/.lake/packages/mathlib/Mathlib/`.
- **OpenAI release**, sparse clone (no PDFs locally):
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/oaimath/`
  — `CONTENTS.md` (every family summary + every manuscript abstract, 640 KB), `overview.tex`
  (family summaries grouped by the 17 subjects via `\cataloguesection{Subject}{n}` and
  `\resultentry{NNN}{title}{summary}{links}`), `lean/formalization.yaml` (162 papers with a Lean
  formalization; Apache-2.0), `lean/OAI/` (121,734 Lean files of paper formalizations, organised like
  Mathlib; it **depends on Tau Ceti**, CBirkbeck/AINTLIB, a ClassFieldTheory repo, carleson,
  StrongPNT, sphere-eversion and others — see `lean/lakefile.lean` via `git -C ... show HEAD:lean/lakefile.lean`).
  To read a paper: `curl -sL "https://raw.githubusercontent.com/openai/math/main/preprints/<Dir>/<file>.pdf" -o /tmp/x.pdf && pdftotext -layout /tmp/x.pdf - | head -400`
  (the PDF name is in the link in `CONTENTS.md`; use your own scratch dir, not /tmp, if you have one).

## Hard constraints

- **No GitHub writes of any kind** (no comments, PRs, issues, pushes). Keep `gh api` reads under
  ~50 per agent; everything you need is local.
- No ssh, no passwords, no logins. Modest web fetching only (LMFDB pages, arXiv abstracts,
  raw.githubusercontent.com); at most one request per second to any host.
- Never write or delete inside any `.lake/` directory (they are shared symlinked stores).
- Do not modify the TauCetiRoadmap git repo; write only your assigned output file(s) under
  `/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/`.

## arXiv categories to use for tagging

math.AG, math.AC, math.AT, math.AP, math.CA, math.CO, math.CT, math.CV, math.DG, math.DS,
math.FA, math.GM, math.GN, math.GR, math.GT, math.HO, math.IT, math.KT, math.LO, math.MG,
math.MP (= math-ph), math.NA, math.NT, math.OA, math.OC, math.PR, math.QA, math.RA, math.RT,
math.SG, math.SP, math.ST; and for theoretical computer science cs.CC, cs.DS, cs.DM, cs.IT, cs.LO, cs.GT.

## Common output: the needs file (JSON Lines)

Besides your markdown report, write one JSON object per line, one per *need* (a definition or
theory cluster that must exist in Lean for some goal item):

```json
{"goal": "LMFDB|Annals|OpenAI", "ref": "e.g. 'ec' section / 'Annals#11' / 'OAI#087'",
 "concept": "short noun phrase, e.g. 'Néron model of an abelian variety'",
 "kind": "definition|theory|theorem",  "level": "statement|proof",
 "arxiv": "math.AG", "secondary_arxiv": ["math.NT"],
 "coverage": "mathlib|tauceti-code|tauceti-roadmap|open-pr|birkbeck-campaign|lmfdb-plan|oai-lean|gap",
 "owner": "roadmap name (and PR number / campaign) that covers it, or null",
 "proposed_roadmap": "CamelCase name of the roadmap you propose if coverage is gap/partial, else null",
 "notes": "one line"}
```

Use the coverage value of the *strongest* existing owner (mathlib > tauceti-code >
tauceti-roadmap > open-pr > birkbeck-campaign > lmfdb-plan > oai-lean > gap). A need covered only
partially gets the owner plus a `proposed_roadmap` for the missing part and says so in `notes`.
Before marking anything `gap`, grep the three roadmap sources and the explorer index for it.

## Style for reports

Concise, factual, mathematician-to-mathematician. No praise, no filler. Cite paths. When unsure,
say so in one clause rather than guessing. Use American spelling.
