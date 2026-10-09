# Brief: consolidate and verify the roadmap references (2026-10-08)

Ten agents have compiled references per roadmap, one per campaign, without network access (see `REFS_BRIEF.md`).
You merge them into one master list, verify every distinct work at a polite rate, apply the corrections everywhere,
and regenerate the per-campaign reference sections in one uniform format. All paths are relative to
`/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/`. The constraints of `BRIEF.md` still bind: no GitHub writes,
no ssh, read-only on `.lake`. Scratch directory:
`/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/r-verify/`.

## Inputs

- `refs_<CODE>.json` for NT, AG, ALG, TOP, GEO, ANA, FAMP, PRDS, COMB, LTCS. Each is a list of
  `{roadmap, campaign, kind, references: [...]}`, with the reference fields of `REFS_BRIEF.md`.
- The same lists are embedded as a `references` field in `slate_<CODE>.json`, and rendered as `## 8. References by
  roadmap` at the end of `campaign_<CODE>.md`.
- Waves come from `roadmap_leaves.json` (field `wave`; NT sub-roadmaps have none, so use their family's wave from
  `campaign_NT.md`).

## Step 1: merge and deduplicate

- **Normalize.** Treat two records as one work when they share a DOI, arXiv ID, ISBN or zbMATH ID. Failing that,
  match on a normalized first-author surname plus normalized title (lowercase; strip accents, punctuation, subtitles
  after a colon, and edition words). Keep distinct editions distinct only when a roadmap's pointers depend on the
  edition.
- **Assign master keys** of the form `Surname[Surname…]YYYYword`, unique across the master list.
- **Merge fields,** preferring high-confidence and identifier-bearing records.
- **Track usage:** for each work, the list of (campaign, roadmap, role, serves) and the best (earliest) wave among
  its users.
- **Code references** (`type: code` or `access: code`) are verified differently; see step 2.
- **OpenAI paths.** References into the OpenAI release with a `local` path inside the session scratchpad must get a
  stable URL of the form `https://github.com/openai/math/tree/main/<path>`, and the scratchpad `local` path is
  dropped. Scratchpad paths will not survive the session.

## Step 2: verify, politely

Use only these services, with a cache file in your scratch directory so nothing is requested twice. Make no retries:
on any HTTP 429, 403, 5xx, an empty body, or a timeout, stop using that service for the rest of the run and record the
remaining works as `unverified (service stopped)`.

1. **arXiv** (works with an arXiv ID).
   - Endpoint: `https://export.arxiv.org/api/query?id_list=<id1>,<id2>,…&max_results=<n>`. Always https; plain http
     costs two requests.
   - Batch up to 100 IDs per request, at most one request every 3 seconds, on one connection.
   - Total budget: 15 requests. Check title and first author.
2. **zbMATH Open** (books and papers without arXiv IDs).
   - Endpoint: `https://api.zbmath.org/v1/document/_search?search_string=<query>&page=0&results_per_page=3`, where the
     query is `ti:"<distinctive title words>" au:<surname>` (URL-encoded).
   - At most one request every 1.5 seconds. Record the zbMATH document ID, the corrected year/venue/edition, and the
     DOI if zbMATH lists one.
   - Budget: one request per work, plus at most one reformulated query for a miss.
3. **Crossref** (only for a DOI that a record already carries and zbMATH did not confirm).
   - Endpoint: `https://api.crossref.org/works/<doi>`, at most one request per second, with no email or personal data
     in headers or query.
4. **Code references.** Do not fetch.
   - Check local paths exist: the Mathlib and Tau Ceti checkouts named in `BRIEF.md`, and the OpenAI sparse clone in
     the scratchpad (`oaimath/lean/...`).
   - For a GitHub repository URL, accept it as given and mark it `code (not fetched)`.

Each work gets `verified` set to one of `zbmath:<id>`, `arxiv:<id>`, `doi:<doi>`, `local:<path>`, `code-local`,
`code (not fetched)`, `not found`, `ambiguous (<candidates>)`, or `unverified (service stopped)`. Apply the corrections
(authors, title, venue, year, edition) and keep a log of every change.

**Access upgrades.** Mark a work `free` only with evidence, never by assumption:
- zbMATH lists an open-access link;
- the work is on arXiv;
- it is in a known open archive that zbMATH links (Numdam, EuDML, Project Euclid open, the AMS open backfile, the
  Elsevier open archive).

Otherwise keep the compiler's access value. Before the network pass, report in your scratch log how many requests you
plan per service. If the zbMATH plan exceeds 2,500 requests, verify wave-A works first and stop at 2,500.

## Step 3: write the master files

- `references_master.json`: one object per distinct work. Fields: the merged reference fields, the master key, the
  `verified` value, the change log, and `used_by` (a list of {campaign, roadmap, role, serves}), `n_roadmaps`,
  `best_wave`.
- `references_master.md` (no size cap; it is the full bibliography):
  - (a) Summary: number of works, verification outcome counts, access counts, how many are held locally, and the
    counts of corrections made.
  - (f) The **full bibliography**, alphabetical by master key, with complete entries, identifiers, the verification
    status and the roadmaps that use each work.
  - (b) The **acquisition list**, prioritized: needed by a wave-A roadmap, then by the most roadmaps. Split into:
    - free and not held (with URLs: a download list for later);
    - library-only;
    - purchase.
  - (c) The 100 most-used works, with the roadmaps that use them.
  - (d) Works marked `not found`, `ambiguous` or low-confidence, for a human to check.
  - (e) Code and formal sources grouped by repository.

## Step 4: propagate to the planning documents

For each campaign:

1. Rewrite `refs_<CODE>.json` with corrected fields, adding `master_key` and `verified` to every reference.
2. Rewrite the `references` fields in `slate_<CODE>.json` the same way, changing nothing else. Families may be nested
   under `subroadmaps` / `sub_roadmaps`; keep the JSON valid.
3. Regenerate `## 8. References by roadmap` in `campaign_<CODE>.md` in one uniform, **compact** format. The current
   §8 sections run 40–113 KB and make the campaign files hard to read. Full bibliographic entries belong once, in
   `references_master.md`; §8 cites by short form.
   - **Notes.** If the existing §8 has campaign notes before its first roadmap block (pinned conventions; LTCS's
     corrections to §3.0), keep them, condensed to their substance, as a "Conventions and notes" paragraph at the
     top.
   - **One short block per roadmap**, in slate order: the roadmap name, then the references grouped by role, each as a
     short citation `Surname[–Surname] Year, *Short title*` followed by its chapter pointer if any. Example:
     "primary: Lazarsfeld 2004, *Positivity I*, Ch. 1–2; Kollár–Mori 1998, *Birational Geometry*; theorem: …".
     Mark unverified works with "(?)".
   - **The campaign's acquisition list**, as short citations.
   - **A pointer** to `references_master.md` for full entries.

   Target 8–25 KB per campaign. Replace the old §8 completely; leave §1–§7 untouched.

Finish with a summary in your final message:
- works and listings;
- verification outcome counts and requests made per service;
- corrections made, and the most important ones;
- the acquisition-list sizes;
- anything that needs a human.
