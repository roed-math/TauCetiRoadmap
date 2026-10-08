# Cost per merged PR, measured on mimir (2026-10-07)

Read-only pull, with the owner's authorization, of `~/TauCetiWorker-v2/state/*/rounds.jsonl` and
`~/.tauceti-fleet/usage-history.jsonl` from the three fleet accounts. Raw copies are in the session scratchpad
(`scratchpad/mimir/`).

## Coverage

- **Only claudeF (fleet `gq2`) writes `rounds.jsonl`.** claudeM (`gqm`) and claudeW (`gqw`) have worker state but no
  rounds logs (their usage histories have one line each), so the measurement is one fleet.
- **Window:** 2026-10-05 09:55 to 10-08 01:07 UTC (2.63 days).
- **Rounds:** 2,561 from 11 workers.
- **Model:** `claude-opus-5-5`, `claude_effort = "high"`.
- **Work mix:**
  - by round kind: 1,293 `outside` (fallback authoring on roadmaps beyond the GQ2 list), 834 `shared`, 434 `target`;
  - PRs: 257 opened by `roed-math` in the window, all on `roadmap/*-gq2-*` branches; 192 merged (including Bors
    merges), 60 open, 5 closed.

## Recorded Claude spend: $1,797 ($682 a day)

| stage | Claude rounds | $ | $ per round |
|---|---:|---:|---:|
| roadmap (authoring) | 333 | 1,421 | 4.27 |
| fix | 340 | 271 | 0.80 |
| progress | 59 | 56 | 0.96 |
| curate | 58 | 21 | 0.35 |
| fix-ci | 27 | 14 | 0.52 |
| rebase | 23 | 10 | 0.43 |
| decide | 7 | 4 | 0.55 |

- **Authoring rounds** average 8.8M cache-read tokens, 179k cache-write tokens and 53k output tokens. Cost deciles run
  from $0.40 to $9.03.
- **Rounds with no provider** and a median duration of 0–3 s are no-ops; they are not counted.

## What the record leaves out, and how it is estimated

- **Review rounds.** 488 ran (median 372 s, mostly rc 0). They default to Claude (`work_model = "claude"` in the
  worker), but the review engine runs inside the sandbox and its spend is not captured in `rounds.jsonl`. Since they
  last about as long as fix rounds ($0.80), they are estimated at $0.50–1.50 each.
- **Codex rounds.** 61 authoring and 42 fix-type rounds had no recorded cost (subscription). They are priced at the
  Claude averages: $4.27 per authoring round, $0.80 per fix round, ≈$290 in all.

## Result

| review $/round | all-in $ | per expected merged PR |
|---:|---:|---:|
| 0.50 | 2,334 | $9.37 |
| **1.00** | **2,578** | **$10.35** |
| 1.50 | 2,822 | $11.33 |

"Expected merged" = 192 merged + 95% of the 60 open, matching the historical 98% merge rate. Per merged PR this is
about:
- $6.50 of authoring (≈1.5 Claude authoring rounds per PR);
- $1.15 of fixes, rebases and CI repair;
- ≈1.9 review rounds;
- $0.30 of overhead (progress, curate, decide).

**Caveats.**
- One fleet, 2.6 days.
- Review spend is estimated, not recorded.
- Fix rounds in the window also served PRs opened before it.
- The work mix is the GQ2 list plus fallback authoring on existing roadmaps, which is probably easier per PR than the
  new slates' deeper material.
- Prices are those Claude Code reports (`total_cost_usd`).

**Usage-history conversion** (with caution, since the fleet leases a pool of login chains): `used` rose 106 points
over the window, with one claimed reset. That is ≈$17 of recorded Claude spend per 1% of the weekly window.

## Recommended instrumentation

- Capture the review engine's spend in `rounds.jsonl`.
- Record the PR number on authoring rounds.
- Turn on `rounds.jsonl` for gqm and gqw.

With these, C can be re-measured weekly per campaign, as harder slates come online.
