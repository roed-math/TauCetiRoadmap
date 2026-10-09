# Brief: references for every proposed roadmap (2026-10-08)

You compile the **references needed to write and implement each roadmap** in one campaign's slate, and add them to
that campaign's planning documents. Read `BRIEF.md` (constraints still binding: no GitHub writes, no ssh, read-only
on `.lake`) and `PHASE2.md` (what a slate is) first. All paths are relative to
`/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/`.

## What "references needed" means

For each roadmap, give the sources a roadmap author needs in order to pin definitions, conventions and numbered
theorem statements, and that an implementer needs to follow proofs. Tau Ceti reviews demand exact theorem numbers, and
a wrong number is worse than a right chapter: give chapter/section pointers only where you are confident, otherwise
the chapter.

Per roadmap, typically 4–10 references, chosen as follows:

- **Primary** (1–3): the standard graduate textbooks or monographs whose scope matches the roadmap. Prefer sources
  with complete proofs. Where two standard texts differ in conventions, list both and say which one the roadmap
  should adopt.
- **Theorem** (as needed): for each headline milestone not proved in a primary source, the original paper or the
  standard modern treatment.
- **Conventions**: the source whose normalization the roadmap should pin, if it is not a primary source. Examples:
  the Hodge-structure sign, Frobenius arithmetic vs geometric, the Fourier transform's 2π.
- **Formal**: existing Lean (or other prover) developments the roadmap should port from or coordinate with,
  including Mathlib files and Mathlib PRs, Tau Ceti files, OpenAI `lean/OAI` directories, and external Lean
  projects. These are already partly listed in each slate's `porting` field; reuse them.
- **Statement** (frontier milestones only): the paper that states a result the roadmap states but does not prove,
  including OpenAI manuscripts (cite as `OAI:<directory>` with the family number).

Do not list background reading that serves no milestone, and do not label anything "optional".

## Where to look first

- The slate itself: `slate_<CODE>.json` (scope, milestones, porting) and `campaign_<CODE>.md`.
- The phase-1 reports, which often name sources: `openai_*.md`, `annals_*.md`, `lmfdb.md`.
- `definitions_100_tauceti.md` (in `/Users/roed/claude/handoffs/`) for the Annals entries.
- **Existing Tau Ceti roadmap READMEs**, which carry reference sections: reuse their citations and their pinned
  conventions verbatim where your roadmap builds on them. Read them with
  `git -C /Users/roed/claude/TauCetiRoadmap show upstream/main:TauCetiRoadmap/<Name>/README.md`.
- **Birkbeck campaign READMEs**, which give a source route per stage, at
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/explorer/content/campaign/<Name>/README.md`,
  plus `explorer_bibliography.json` (46 works mapped to campaign roadmaps).
- **Local PDF collections.** Record a local path whenever a reference is already held:
  - `/Users/roed/claude/TauCetiRoadmap/references/` (see `MANIFEST.md`, `PUBLISHERS.md`);
  - `/Users/roed/claude/references/`;
  - `/Users/roed/claude/gq2-paper/references/` (with `DOWNLOAD-LIST.md`, `PROVENANCE.md`).
- `/Users/roed/claude/TauCetiRoadmap/lmfdb_background_plan.md` §6 (61 references with free-availability notes).

## No network verification in this pass

To avoid ten agents hammering arXiv, zbMATH and Crossref at once, **do not fetch anything over the network**.
Bibliographic details come from local sources and your knowledge. Record your confidence honestly:

- **high**: certain of authors, title, venue/series and year;
- **medium**: one detail may be off, such as the year or edition;
- **low**: you believe the work exists but are unsure of details.

Never invent an identifier: include a DOI, arXiv ID, ISBN or zbMATH number only when you are certain of it, else
leave it null. A later single pass deduplicates and verifies every reference at a polite rate.

## Record format

`refs_<CODE>.json`: a JSON list, one object per roadmap. This covers each leaf roadmap, each umbrella family (the
umbrella gets the family-wide primary texts; members list their own), and for NT and AG each **campaign promotion
unit**:

```json
{"roadmap": "<name exactly as in slate_<CODE>.json, or the unit id>", "campaign": "<CODE>", "kind": "new|umbrella|promotion",
 "references": [
   {"key": "Lazarsfeld2004a", "role": "primary|theorem|conventions|formal|statement",
    "authors": "R. Lazarsfeld", "title": "Positivity in Algebraic Geometry I: Classical Setting: Line Bundles and Linear Series",
    "type": "book|paper|notes|survey|code", "venue": "Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 48, Springer",
    "year": 2004, "edition": null,
    "ids": {"doi": null, "arxiv": null, "isbn": null, "zbmath": null, "url": null},
    "serves": "Layers 1–3: ample/nef cones, Kleiman, Nakai–Moishezon (Ch. 1)",
    "access": "free|arxiv|library|purchase|code", "local": "<path or null>", "confidence": "high|medium|low"}
 ]}
```

Rules for the record:

- **Keys.** Use `FirstAuthorYearSuffix` and reuse the same key for the same work across roadmaps within your file.
- **Access.**
  - `free` means legitimately free from the author, publisher or archive. Never shadow libraries.
  - `code` is for Lean repositories and files.
- **Promotion units** (NT: the 44 units in
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/p2-nt/units.json`
  and `campaign_NT.md` §2; AG: the 15 entries in `slate_AG.json` whose `origin` is not `new`). Extract the sources
  their member campaign READMEs cite, rather than compiling anew. Add a primary text only where the READMEs name
  none.

## Changes to the planning documents (your campaign's files only)

1. Add a `references` field (the same list) to each matching object in `slate_<CODE>.json`. Families nested under
   `subroadmaps` or `sub_roadmaps` get it on the nested objects. Keep every other field unchanged and keep the file
   valid JSON.
2. Append a section **`## 8. References by roadmap`** to `campaign_<CODE>.md`.
   - One compact block per roadmap: its name, then one line per reference, in the form
     `role · Authors, *Title*, venue, year [access; local] — serves`.
   - End with a short **acquisition list** for the campaign: works needed by two or more roadmaps or by any wave-A
     roadmap that are neither free nor held locally.
   - This section may take the file past 45 KB; keep it compact.
3. Write `refs_<CODE>.json`.

Finish with a short summary in your final message: roadmaps covered, references listed (total, unique), counts by
access type, the number held locally, the low-confidence count, and the five works most often needed.
