# Phase 2: campaign slates (shared instructions)

You are the planner for one campaign of the Tau Ceti expansion. Phase 1 produced demand-side
reports (what the three goals need) and supply-side reports. Your job is to turn them into **one
deduplicated slate of roadmaps for your campaign**: what exists, what to add, in what order.

## Read first

1. `BRIEF.md` (context, data locations, constraints — still binding: no GitHub writes, no ssh,
   read-only on `.lake`, write only your own output files in this directory).
2. `BOUNDARIES.md` — the ten campaigns, their arXiv classes, and pre-decided owners for concepts
   that several phase-1 reports proposed under different names. Plan within these.
3. `coordination.md` §3 (overlap audit, foundations owned by other fields) and §4.2–4.6 (lanes,
   registry, boundary rules, naming, promotion gates).
4. `capacity.md` §2.2 (size classes: S ≈ 40 PRs, M ≈ 110, L ≈ 250, XL family ≈ 1,000–1,700 as an
   umbrella README with sub-roadmaps like RepresentationTheory) and §4 (human roadmap review is the
   binding constraint; the project needs *large* well-specified surface).

All paths are relative to `/Users/roed/claude/TauCetiRoadmap/expansion_plan/work/`.

## Inputs

- `needs_all.jsonl`: every need from phase 1 (1,700+ rows), with `campaign` (primary, from the
  arXiv tag) and `secondary_campaigns`. Your rows: `campaign == <YOUR CODE>`; also read rows whose
  `secondary_campaigns` include your code (interface needs) and rows elsewhere whose
  `proposed_roadmap` falls in your territory under BOUNDARIES.md. Fields: goal, ref, concept,
  kind, level, arxiv, coverage, owner, proposed_roadmap, notes, file.
- Phase-1 reports (markdown, with the reasoning and the proposed-roadmap scope paragraphs):
  `lmfdb.md`, `annals_1_51.md`, `annals_52_100.md`, `openai_number_theory.md`,
  `openai_algebraic_geometry.md`, `openai_analysis.md`, `openai_probability_physics.md`,
  `openai_combinatorics_tcs.md`, `openai_geometry_topology_dynamics.md`,
  `openai_algebra_groups_logic.md`. Read the ones relevant to your campaign in full; grep the rest.
- Supply: `supply_by_arxiv.md`, `supply_all_by_arxiv.json`, `supply_tauceti_main.json`,
  `supply_open_prs.json`, `supply_birkbeck_campaign.json`, and the READMEs themselves via git /
  the explorer clone (see BRIEF). The explorer also has draft roadmaps outside number theory under
  `research/blueprint/roadmaps/*.json` in the clone at
  `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/explorer/`
  (e.g. RiemannianGeometry, SeveralComplexVariablesKahlerGeometry, SymplecticContactGeometry):
  treat them as prior drafts to reuse, not as owners.
- `openai_families.json` for family titles and subjects.

## What to produce

**`campaign_<CODE>.md`** (at most ~45 KB) with these sections:

1. **Scope.** Your arXiv classes, the subject in two sentences, and the size of the demand
   (needs by goal and coverage, from `needs_all.jsonl`).
2. **Existing supply.** One line per existing roadmap in your territory (Tau Ceti main, completed,
   open PR, Birkbeck campaign, explorer draft): what it covers, what it contributes to the three
   goals, and the recommended action (merge soon because N needs wait on it / extend with X /
   consolidate with Y / leave).
3. **The slate.** A single deduplicated list of NEW roadmaps. Several phase-1 reports proposed
   overlapping roadmaps under different names; merge them into coherent units with non-overlapping
   boundaries. **Prefer broad roadmaps (L) and umbrella families (XL family) over many small
   ones**: each roadmap costs one human review, and the README says broad is usually better. A
   roadmap is S/M only when its subject is genuinely narrow. For each roadmap:
   - name (CamelCase, describes content; no "PartII", no category prefix);
   - arXiv topic; size class with estimated PRs;
   - scope paragraph (4–8 sentences, written as the roadmap's own opening paragraph, stating the
     boundary: what is in, what is explicitly left to which neighbor);
   - key objects; headline theorems (as milestones, foundations first);
   - prerequisites: existing roadmaps by name, other proposals (any campaign);
   - goals served: counts by goal with the refs (e.g. "OpenAI 9: OAI#213, #221, …; Annals: #97");
   - porting sources (OAI Lean directories, external Lean projects), with the README's
     "coordinate first" rule in mind;
   - wave: **A** = startable now on Mathlib + Tau Ceti + merged roadmaps; **B** = needs a wave-A
     roadmap or an open PR to merge first; **C** = deeper;
   - one-line formalizability note.
4. **Needs not absorbed.** Every `gap` need in your campaign that the slate does not cover, with
   the reason: frontier research (name it), owned by another campaign (name the roadmap), or too
   small and better added to existing roadmap X (say what to add).
5. **Cross-campaign interface.** What you import from other campaigns (their existing or proposed
   roadmaps) and what you export to them.
6. **Order and people.** The first five roadmaps to draft and why (demand × unblocking); the
   expertise a campaign lead and its reviewers need; any open question for the owner.
7. **Totals.** New roadmaps by size class, estimated PRs, and the PRs already available in
   existing supply in your territory.

**`slate_<CODE>.json`**: a JSON list with one object per proposed roadmap: `name`, `campaign`,
`topic`, `size`, `est_prs`, `wave`, `scope` (the paragraph), `prerequisites` (list),
`goals` (object: `{"LMFDB": [...refs], "Annals": [...], "OpenAI": [...]}`), `porting` (list),
`replaces` (list of phase-1 proposal names merged into it).

Style: concise, factual, mathematician-to-mathematician, American spelling, no praise or filler.
Finish with a 10-line summary in your final message.
