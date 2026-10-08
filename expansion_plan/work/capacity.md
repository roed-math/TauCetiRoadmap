# Capacity model: how much roadmap surface $3M of inference needs

2026-10-07. Read-only analysis. All $ are Anthropic list-price API dollars. "PR" means a merged TauCeti PR.
Scratch data and scripts: `/private/tmp/claude-501/-Users-roed-claude-TauCetiRoadmap/8bd6ed9b-a8af-40d5-a0d7-c23d9ecfc489/scratchpad/agent-capacity/`.

## 1. Bottom line

- At a central **$25 per merged PR** (all-in), $3M buys about **100k PRs**. Today the whole project
  merges about **2,300 PRs/week**. So the credits equal about 43 weeks of the project's current total output.
- Known supply covers about **23k PRs**: what is left on the active roadmaps, plus the open roadmap PRs,
  plus Birkbeck's 152-roadmap campaign once it is expanded. The fleets running today would use that
  up in about **10 weeks** with no new money. The active roadmaps on main alone last under 3 weeks.
- So $3M needs roughly **900 new medium roadmaps, or 375 large ones, or about 70 umbrella families**
  the size of RepresentationTheory. Over a 6-month spend, that is **about 34 new medium roadmaps
  approved per week**. Another ~21 per week are needed just to keep today's fleets fed.
  Today about 3 per week are approved.
- **Human roadmap review binds first.** It is followed by the GitHub write budget per identity and
  then by the merge pipeline. Money and CI runners are not the binding constraints.

## 2. Measured inputs

### 2.1 Throughput (TauCeti main, first-parent log at `47bda78`; gh search cross-check)

| week of | 08-03 | 08-10 | 08-17 | 08-24 | 08-31 | 09-07 | 09-14 | 09-21 | 09-28 | 10-05 (2.3 d) |
|---|---|---|---|---|---|---|---|---|---|---|
| merged PRs | 609 | 901 | 693 | 858 | 552 | 671 | 1,062 | 1,654 | 2,263 | 791 |

- `gh` reports 2,267 merged PRs in the week of 09-28.
- On 10-05..07, GitHub merged 544 PRs and 82 more closed as "[Merged by Bors]".
- 14–22 distinct authors per week.
- roed-math (squash author "David Roe") merged 700 in the week of 09-28, 48–158 per day. It
  opened 744 PRs that week and 731 of them merged (98%).
- Closed-unmerged PRs, excluding Bors merges, ran 4–10 per week from 08-31 to 10-04. So wasted
  attempts rarely become PRs. They are rounds that end without a PR.
- **Open now: 304 PRs.** By label: 178 `ready-to-merge`, 70 `awaiting-author`, 32 draft,
  14 `merge-conflict`, 8 `awaiting-review`, 5 `awaiting-CI`, 5 `needs-human-review`.
  roed-math has 64 open, 62 of them `ready-to-merge`. The merge pipeline, not authoring, is
  holding roed-math's work.

### 2.2 What a roadmap costs in PRs

The 20 completed roadmaps: 6 archived under `Completed/`, plus 14 top-level roadmaps rated COMPLETE or COMPLETE EXCEPT
TRIVIA in `~/claude/handoffs/roadmap-completion-audit-2026-10-07/`. The audit's fifteenth,
RepresentationTheory/SemisimpleAlgebras, is left out because its PRs are counted under the umbrella. OneParameterSemigroups is
excluded because its audit says INCOMPLETE. Together they used 2,546 labelled PRs, a median of 98,
for 140 layers. Per-roadmap PR counts are the `roadmap/<Name>` labels in the explorer's
`tauceti-progress.json`. About 11% of PRs carry no label, so these counts are floors.

The 13 completed roadmaps added since the fleets started (08-13 onward):

| roadmap | days, merged to done | PRs | layers | Suggested.lean decls |
|---|---|---|---|---|
| RestrictedProducts / ProfiniteArithmetic | 10 / 8 | 21 / 32 | 4 / 4 | 76 / 147 |
| HodgeStructures / IntegralLattices (v1) | 54 / 26 | 69 / 107 | 4 / 5 | 56 / 136 |
| AlgebraicCodingTheory / HopfRinow / PolynomialGaloisGroups | 20 / 48 / 49 | 87 / 96 / 95 | 7 / 5 / 8 | 149 / 1 / 48 |
| Chebotarev / DenseGraphLimits / ArithmeticDirichletSeries / NumberFieldArithmetic | 49 / 48 / 49 / 48 | 98 / 110 / 125 / 132 | 14 / 13 / 11 / 8 | 62 / 163 / 76 / 96 |
| StandardDistributions / ProfiniteProPGroups | 43 / 51 | 180 / 256 | 7 / 12 | 204 / 135 |

Totals for these 13: **1,408 PRs, 102 layers, 1,349 Suggested declarations.** That is **about 14 PRs
per layer and about 1.0 PR per stated target**; the target ratio ranges from 0.2 to 2.0.

The GQ2 target list (`~/claude/tauceti-fleet/targets/gq2_axiom_targets.md`, 347 milestone items)
lands an item as 3–4 partial PRs. An item takes 3–14 h, median about 7 h, and almost all of that
is serial (`~/claude/handoffs/TAUCETI_LOOKAHEAD_AUTHORING_HANDOFF.md`).

**Size classes used below:**

| class | layers | targets | README | PRs (range) | time to finish at 25–60 PRs/wk | examples |
|---|---|---|---|---|---|---|
| S | ≤5 | ≤60 | 10–40 KB | 40 (20–70) | 1–2 wk | RestrictedProducts, ProfiniteArithmetic, Hodge |
| M | 6–10 | 60–150 | 30–80 KB | 110 (85–135) | 2–5 wk | Chebotarev, ADS, NFA, PGG, DGL |
| L | 11–15 | 150–250 | 80–160 KB | 250 (180–300) | 4–10 wk | ProfiniteProPGroups, ClassFieldTheory |
| XL family | 50–110 sub-layers | — | umbrella | 1,000–1,700 | 3–6 months | RepresentationTheory (1,328 so far), ReductiveGroups (1,115) |

**How fast one roadmap can absorb work.** In the week of 09-28, 50 roadmaps absorbed 2,128
labelled PRs: a median of 32 each, a mean of 43, a p25 of 23. The largest was the
RepresentationTheory umbrella at 247. The cap comes from dependency structure: the GQ2 list
has "at most ~6 items workable at once" and "an 11-step critical path" across 8 roadmaps.
The model uses **a = 35 PRs/week per active roadmap**.

### 2.3 Remaining supply

| source | PR-equivalents | basis |
|---|---|---|
| Active roadmaps on main | ~6,100 (4–10k) | progress board, 64 rows / 565 layers: 274 done, 211 partial, 67 untouched, 13 unassessed. Remaining = PRs so far × (1−f)/f with f = (done + ½·partial)/L. Largest: ReductiveGroups ~600, ModularForms ~440, DGAInfinity ~410, EllipticCurves ~390 |
| Open roadmap PRs | ~4,000 | ~45 of the 78 open PRs add or expand a roadmap; × ~90 |
| Birkbeck campaign | ~13,000 | 152 roadmaps × ~85. Their READMEs have a median of 11 KB and 8 stages, against 45 KB and 10 stages for Tau Ceti roadmaps (atlas). Each needs expanding to Tau Ceti standard first, which costs review |
| **K, total known** | **~23,000 (15–35k)** | 10 weeks at today's 2,300/wk |

### 2.4 Cost data

- **No per-round $ exists locally.** Since worker `eb4c650` (2026-10-05), each round writes
  `cost_usd` to `state/<id>/rounds.jsonl`, but only on mimir. The fleets run on subscription
  accounts. claudeF burned 19% of a weekly Claude window in 8 h, and 56-h slots routinely drain an
  account to 0% (memory: `tauceti-second-fleet-claudeM.md`).
- Failed lookahead sessions cost **about $1 each**. Pilot sessions ran 9–17 agent-minutes and
  45–57 turns. An author writes the next PR 20–50 min after the previous merge (lookahead pilot
  report and handoff).
- **Local Claude Code transcripts.** I priced the transcript token usage myself: 59 sessions in
  this project from 08-07 to 10-07 total **$6.6k**.
  - Cache reads are about 70% of the cost of an agent turn. The same tokens cost $0.241/turn at
    Opus 5 prices and $0.125 at Opus 5.5, so **model choice moves C by about 2×**.
  - Roadmap work as examples: the GQ2 gap-fix campaign (plan, ~7 roadmap PRs, their review rounds)
    cost $1.8k. One review-round response costs $3–60, median about $15. The Belyi roadmap cost
    about $400.

**Bottom-up estimate of C ($ per merged PR, Opus 5 prices):**
- An author round runs about 90 turns at about 80k context: cache reads 7.2M × $0.50 = $3.6,
  output 45k × $25 = $1.1, cache writes 0.15M × $6.25 = $0.9, so **about $5.6**.
- A fix round is about $3 and a review round about $2.
- Per merged PR: 1.5 author rounds (this covers declines and failed builds) = $8.4, plus
  1.5 fix rounds = $4.5, plus 2 review rounds = $4. Add 15% for curate, decide, progress,
  survey, duplicates and bump churn. **About $20.**
- **The model uses C = $25, range $12–50.** $12 is Opus 5.5 with lean rounds; $50 is long contexts
  and many retries.

**Authoring cost (inference):** A ≈ $500 per M roadmap (range $200–1,000), $1,500 per L,
$8,000 per XL family. That is 8–27% of a roadmap's execution cost. It is not negligible, but it
does not drive the model.

## 3. The model

```
B_eff            = $3.0M × 0.97                      (3% for progress reports, audits, fleet ops)
cost(class)      = PRs(class) × C + A(class)         (S 40/$300, M 110/$500, L 250/$1,500, XL 1,300/$8,000)
roadmaps needed  = B_eff / cost(class)
PR rate (incr.)  = roadmaps × PRs(class) / H
concurrency      = PR rate / a                       (a = 35 PRs/week per active roadmap)
approvals/week   = roadmaps / H
base demand      = 2,300 PRs/wk ÷ 110 = 21 new M/wk once K is gone (week ~10)
```

**Realistic assumption:** the existing fleets keep running at about 2,300/week and use up K
first, so every $3M-funded PR needs new surface. If the $3M workers got K instead, subtract
about 180 M roadmaps at C = $25.

**Roadmaps the $3M needs, if built in one class:**

| C | $ per M (all-in) | S | M | L | XL family | PRs bought |
|---|---|---|---|---|---|---|
| $12 | $1,820 | 3,730 | 1,600 | 650 | 120 | 176k |
| **$25** | **$3,250** | **2,240** | **895** | **375** | **72** | **98k** |
| $50 | $6,000 | 1,270 | 485 | 210 | 40 | 53k |

**By horizon at C = $25** (98k PRs; spend $224k, $112k or $56k per week):

| horizon | extra PRs/wk | total PRs/wk (vs 2,300 today) | roadmaps active at once (extra + base) | new M approvals/wk (extra + base) |
|---|---|---|---|---|
| 3 months | 7,580 | 9,880 (**4.3×**) | 216 + 66 | 69 + 21 |
| 6 months | 3,790 | 6,090 (**2.6×**) | 108 + 66 | 34 + 21 |
| 12 months | 1,890 | 4,190 (**1.8×**) | 54 + 66 | 17 + 21 |

- At **C = $12**, every rate column roughly doubles: 6.9×, 3.9× and 2.5× today, and 123, 61 and
  31 new M per week.
- At **C = $50**, it roughly halves: 2.8×, 1.9× and 1.4× today, and 37, 19 and 9 new M per week.

## 4. Binding constraints, in order

1. **Roadmap supply, gated by human review (binds first, within weeks).**
   - 74 roadmap-adding PRs merged since June. Median time from open to merge was 6.7 days
     (p75 17, max 73). Large roadmaps took 17–42 days.
   - Approvals: CBirkbeck 29, kim-em 20, amlicata 4, everyone else 1 each.
   - Net new roadmaps since mid-August: about 2–4 per week. 78 roadmap PRs are open.
   - Need: 17–69 new M-equivalents per week for the $3M plus about 21 for the base. That is
     **10–30× today's approval rate.**
   - Levers:
     - Fewer, bigger units: one XL family costs one review and replaces about 12 M roadmaps.
     - A reviewer per arXiv category, through the per-category explorer forks.
     - Machine pre-review against the "Writing a roadmap" checklist, plus a Suggested.lean
       bridge check before a human looks.
     - Expand the 152 campaign roadmaps in bulk.
2. **GitHub write budget per identity.**
   - The owner's gate is 30 writes/h per fleet (90 across the three roed-math fleets).
   - One merged PR costs about 7 writes: author 2 claims + push + PR, then one fix round of
     2 claims + push (pilot table). So 720 writes/day caps a fleet at about 100 PRs/day, about
     700/week. roed-math hit exactly that: 700 in the week of 09-28, with peaks of 150–158/day only while
     fleets overlapped.
   - +3,800/wk needs about 5–6 more fleet-sized write budgets; +7,600/wk needs about 11. They
     cannot all sit on one account; each identity stays at the 30/hour gate, well under GitHub's secondary limits.
   - The installation-token App route in `~/claude/handoffs/GITHUB_APP_FEASIBILITY.md` is the
     path that scales.
3. **Merge pipeline.**
   - 178 PRs are `ready-to-merge` but not merged today; that is about half a day of merges.
   - Today: about 320–470 merges per day. 2.6–4.3× means 850–1,400 per day, one every 1–2 min.
     That needs multi-PR Bors batches and a low batch-failure rate.
   - Stalls already happen: on 10-05 the queue stalled 3.5 h while hosted runners were not
     acquired, and backend switches refuse admission while they drain (memory:
     `tauceti-merge-pipeline.md`).
4. **Width inside roadmaps.**
   - Serial items mean one roadmap absorbs a median of 32 PRs/week, and only an umbrella gets
     past 100.
   - This, not total size, is why the plan needs 100–280 roadmaps active at once.
   - Lookahead authoring (stub-first branches) halves item latency where it applies.
5. **Waste multipliers.**
   - Duplicates: 1.4% overall, 2–3% in busy weeks, 4.1% for roed-math. Claims miss them across two
     namespaces, through failed in-bubble claims (433/433 failed), and because the dedup sweep runs
     every ~6 h while PRs now merge about 2 h after opening (memory: `tauceti-duplicate-work-claims.md`).
     With more workers on a thin frontier, expect 5–10% unless claims move to one namespace and
     surface grows with concurrency.
   - Mathlib/toolchain bumps: 3–10 bump-type commits per week on main. Each bump rebases the open
     pool and sends PRs to the fixer. Assumed 5–10% of fixer spend; this is inside C.
6. **CI.**
   - Runner minutes scale linearly with PR rate and are paid for.
   - The hard limit is the **16 GB memory per job**. #11179 peaked at 20.6 GB, was killed with
     exit 143 and no status, and sat at `awaiting-CI` for 4 days.
   - Rare; TauCetiWorker#240 routes such PRs to fix-ci.
7. **Money.** It does not bind. $3M cannot be spent productively at C ≈ $25 until surface and
   write identities grow about 10×.

**Practical consequence:** spending the $3M in 3 months is not feasible; it would take about 70 new
M roadmaps per week plus 11 extra write identities. A 9–12-month spend is feasible if the roadmap
pipeline is rebuilt first:
- Months 1–2 at $100–150k/month, while known supply lasts and review is scaled.
- After that, $250–350k/month.

## 5. Calibration: what to pull from mimir

C is the parameter everything scales with. Pull these as claudeF, claudeM and claudeW:

1. `~/TauCetiWorker-v2/state/*/rounds.jsonl`, all workers, since 2026-10-05. Fields: `stage`,
   `kind` (target/outside/shared), `provider`, `cost_usd`, `started_at`, `ended_at`.
   - Sum Claude `cost_usd` by stage.
   - Count rounds that ended without a PR. That gives the 1.5× attempt factor.
2. roed-math's merged PRs over the same window: `gh search prs --author roed-math --merged`, plus
   closed PRs titled "[Merged by Bors]". Then **C = Σ Claude cost_usd ÷ PRs merged from Claude
   rounds**.
   - Codex rounds log tokens with `cost_usd` null. Price them at Opus rates if API Claude will
     replace them.
3. `<fleet home>/usage-history.jsonl` against that `cost_usd`. This gives API $ per 1% of a weekly
   window, so the subscription burn so far can be read as dollars.
4. One run of `tauceti-fleet` per fleet with the round mix: author / fix / review / curate /
   decide / progress shares. This checks the 1.5 / 1.5 / 2 round counts per PR.

## 6. Assumptions to revisit

- **PRs per target (about 1.0) is not a fixed constant.** Fleets now split milestones into 3–4
  partial PRs, so PR counts per roadmap may rise. Read the M class as "about 100 stated targets",
  not "110 PRs".
- "Done" layers on the board are generous; STATUS.md has overstated before. The remaining-supply
  figure is ±50%.
- The 2,300/week base assumes the other operators' fleets (about 1,600/week) keep running; their
  consumption is half the surface problem either way.
