# Provenance

This file is not normative. `README.md` is the definitive roadmap; this file records dated
evidence, audit results, and decisions, so that reviewers can check the roadmap's claims
without redoing the searches, and so that stale facts can be re-verified against their
dates.

## Mathlib pin audit

Pin `9caeba1000` (2026-06-03), audited 2026-08-08 by grep over the checked-out package.

Present, load-bearing (see README §What Mathlib supplies for the full table):
`Equiv.Perm` cycle theory with `Equiv.Perm.partition` (pads with `1`s; bare `cycleType`
does not), `MulAction.IsBlock`/`IsBlockSystem`/`IsPreprimitive` and the Jordan theorems,
Burnside (`MulAction.sum_card_fixedBy_eq_card_orbits_mul_card_group`), `FreeGroup` with
`FreeGroupBasis` and `PresentedGroup`, `IsCoveringMap` (moved to
`Mathlib/Topology/Covering/Basic.lean`; the old path is a deprecated forwarder),
`IsCoveringMap.monodromy` + `monodromyFunctor` + `monodromy_trans_apply`
(`Mathlib/Topology/Homotopy/Lifting.lean`), the lifting criterion
`existsUnique_continuousMap_lifts_of_range_le`, `isCoveringMap_exp` /
`isCoveringMapOn_zpow` (`Mathlib/Analysis/Complex/CoveringMap.lean`),
`CategoryTheory/Galois/*` including the profinite topology on `Aut F` and the equivalence
`functorToContAction` (`Equivalence.lean`) and `IsFundamentalGroup`,
`ProfiniteGrp.profiniteCompletion` with `eta`/`lift`/adjunction (`Completion.lean`),
`ContinuousMulEquiv`, `modularCyclotomicCharacter` and `cyclotomicCharacter`
(`Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean`; the `ℓ`-adic one takes `L`
explicitly, is stated on `L ≃+* L`, and carries no continuity statement),
`Field.absoluteGaloisGroup` (a `def` with derived `Group`/`TopologicalSpace` instances),
`OnePoint ℂ` with `OnePoint.equivProjectivization` and the `GL(2)` action,
`analyticOrderAt`, `MeromorphicNFAt`, `IsManifold 𝓘(ℂ) ω` (sole nontrivial complex
manifold instance: `ℍ`), `Geometry/Manifold/Complex.lean` maximum-principle corollaries.

Absent (verified by search, multiple spellings): any semilocal simple connectivity class,
any topological Seifert–van Kampen, covering-space classification/deck groups/universal
covers, `ẑ`, procyclic predicates, `Out G` or any outer-automorphism carrier, a topology
on automorphism groups of topological groups (the `Galois/Topology.lean` construction for
`Aut F` is the pattern to copy), étale fundamental groups (the `Scheme.Etale` category
exists; nobody proves it Galois), a named `ℙ¹` scheme, Riemann surfaces, Riemann–Roch,
Riemann–Hurwitz, divisors in `AlgebraicGeometry`, triangle groups, ribbon graphs,
dessins, hypermaps. `CircularOrder` exists but connects to nothing about `Equiv.Perm`;
ribbon-graph rotations use `Equiv.Perm.IsCycleOn` instead.

Conventions verified in source, 2026-08-08 (these justify the pinned product relation):
`End.mul_def : xs * ys = ys ≫ xs` and `Aut_mul_def : f * g = g.trans f`
(`Mathlib/CategoryTheory/Endomorphism.lean`), and
`monodromy_trans_apply : cov.monodromy (γ.trans γ') e = cov.monodromy γ' (cov.monodromy γ e)`.
Together they make the fiber monodromy a `MonoidHom` and force
`σinf * σ1 * σ0 = 1` as the relation matching "γ0 then γ1 then γ∞ nullhomotopic".

## Supplier state

Dated 2026-08-08. The README cites layers, which are specifications; this records what is
implemented or pinned today.

- **CharacterTheory** (merged): Layers 0–2 implemented in TauCeti
  (`TauCeti/RepresentationTheory/CharacterTable/`); Layer 3 (character table,
  orthogonality) and Layer 4 (central characters) specified but not implemented. The
  conversion `ω_χ(K_j) = |C_j|χ(g_j)/χ(1)` is Layer-4 prose with no pinned Lean name. The
  Frobenius product-one formula appears nowhere in the family — confirmed by grep — hence
  the ownership decision in README §Boundaries.
- **UniversalCovers** (merged): its `Suggested.lean` has no named declarations; delivered
  `TauCeti.*` names include `deckFundamentalGroupEquiv` (lands in `(π₁)ᵐᵒᵖ`),
  `fiberEquivQuotientRange`, `basepointChangeSubgroup`, and the two
  classification criteria. Open as of today: the correspondence is not yet onto
  (`subgroupQuotientProj` not known to be a covering map), and `Deck ≅ N(H)/H` is
  unproved. Layer 6.3 here cites the milestone, and Layer 6.2's associated cover
  `(Ũ × S)/π₁` supplies the constructive direction independently — it needs only the
  universal cover and free proper discontinuity, both of which that roadmap has, and takes
  the covering property from Mathlib's `IsQuotientCoveringMap`. So nothing here waits on
  those two gaps.
- **ConformalMapping** (merged): `TauCeti.exists_localDegree` and the branch-root API are
  delivered. Its L0–L3 are declared temporary shims to be deleted when mathlib4#33505
  lands; Layer 8.2's consumption of L0 inherits that refactor obligation, which is a
  rename, not a mathematical dependency.
- **ModularForms** (merged): Layer 10B specifies the compact-Riemann-surface cohomology
  chain (Forster §§14–17 route) in prose for general compact Riemann surfaces; its
  `Suggested.lean` pins no Riemann-surface carrier (verified by grep), which is why this
  roadmap owns the carrier conventions (README §Boundaries).
- **AlgebraicCurves** (open PR, branch `roadmap/algebraic-curves`, head `ff1a984`):
  Layers 0–5 partially prototyped in its `Suggested.lean`; Layers 6–8 and 12
  (ramification, the different, Riemann–Hurwitz, the scheme dictionary) are README-only.
  Its contract table already names BelyiMaps as consumer of Layers 6–8 and 12.
- **PolynomialGaloisGroups** (open PR, branch `roadmap/polynomial-galois-groups`, head
  `edc908b`): `fullCycleType` (whose definition the local stand-in here mirrors exactly),
  `TransitiveGroupIndex`, `referenceSubgroup`, `TransitiveGroupLabel` all pinned in its
  `Suggested.lean`/`TransitiveGroupData.lean`.
- **ProPGroups** (open PR, branch `roadmap/pro-p-demushkin`, head `62017de`):
  `freeProfiniteGroup`, `proPKernel`, `maximalProPQuotient`, the universal properties, and
  kernel characteristicity under `ContinuousMulEquiv` all pinned; `zHat` is a stress-test
  object there. Its exponentiation stops at abelian pro-`p` groups (Layer 4,
  existence-form), and its own `PROVENANCE.md` notes an ambition to absorb a
  `ẑ`-exponentiation calculus into Layer 4 — but no such milestone is on its README, and
  "a statement that is not a row is not an interface" is that roadmap's own rule. Hence
  the ownership decision here: BelyiMaps Layer 12.1 owns the calculus, in the generic
  namespace, and a future ProPGroups revision absorbing it would be a rename.
  **Owner ruling (2026-08-08): the dependency is one-directional.** BelyiMaps cites
  ProPGroups; ProPGroups gains no row, no citation, and no dependency pointing here. Its
  files are therefore untouched by this roadmap, and Layer 12.1 is written so that
  ProPGroups never needs it.

## Decisions of record

1. **The product relation is `σinf * σ1 * σ0 = 1`**, where the implementation plan this
   roadmap started from prescribed `σ0 * σ1 * σinf = 1`. The plan licensed a documented
   change when the API audit forces one, and it does: with Mathlib's `End`-multiplication
   and covariant monodromy (verified above), the plan's relation would make every
   monodromy correspondence an antihomomorphism or force inverses through Layers 6–13,
   including a spurious inverse in the branch-cycle exponent.

   ⚠ **The LMFDB agrees typographically and disagrees mathematically**, and an earlier
   draft of this file got that backwards. Its knowl displays `σ_∞σ_1σ_0 = 1` (fetched
   2026-08-08), but its stored triples are Magma-computed with left-to-right composition,
   so as functions they satisfy `σ0 ∘ σ1 ∘ σinf = id` — verified below against frozen
   records, not read off the display. So the roadmap's relation and the LMFDB's stored data
   are related by the componentwise-inversion involution of Layer 0.1, which is exactly why
   that involution is a Layer 0 milestone.
2. **The carrier is named `PermutationTriple`**, not the plan's `BelyiTriple`: "permutation
   triple" is the term of the LMFDB knowl and of Musty–Schiavone–Sijsling–Voight, and the
   object carries no Belyi structure.
3. **`C := (T * P)⁻¹`** (so `C·T·P = 1`), matching the topological relation; a source or
   consumer with `P·T·C = 1` names the conjugate `P⁻¹·C·P`, and Layer 13.3's remark
   records the two-line transfer.
4. **Layer 12 is field-theoretic**: `π₁ᵍᵉᵒ := Gal(Ω/ℚ̄(t))` for `Ω` the maximal extension
   unramified outside the three marked places, so the carrier is Mathlib Galois theory
   plus AlgebraicCurves ramification, and no étale-π₁-of-schemes development is needed.
   The scheme-theoretic comparison is an explicit scope exclusion.
5. **Geometry type lives in Layer 0** (an order-triple invariant), with the
   triangle-group trichotomy in Layer 4; the plan had it in its passport layer. The LMFDB
   audit confirms the choice: its `geomtype` is a function of `abc` alone, agreeing with
   `1/a + 1/b + 1/c` against `1` on all 1111 records, and is independent of the genus.

9. **The generic profinite exponentiation calculus opens Layer 12**, as milestones 12.1 and
   12.2, rather than sitting in Layer 13. It was in Layer 13 in the first draft, which made
   12.9 and 12.10 depend forwards on it — the only forward edge in the roadmap. Moving it
   makes every prerequisite point strictly backwards in document order, which a mechanical
   check now confirms (99 milestones, headings ascending, no forward or self references).
   The calculus depends on nothing else in this roadmap, so it can still be built first.
6. **The graph-cover engine is stated over a wedge of `k` circles**, so `k = 1` yields
   the punctured-disc classification (Layer 7.1) and `k = 2` the three-point theory, one
   construction serving both.
7. **No topological orientation theory**: Layer 7.2 delivers a charted topological
   surface; orientation content rides on the Layer 8.5 complex structure. The plan's
   "oriented topological surface" clause is discharged there.
8. **Compact-Riemann-surface cohomology is consumed from ModularForms 10B**, not built:
   the plan predated that roadmap's 10B chain and asked for the substrate here; the audit
   found 10B supplies it for general compact Riemann surfaces.

## External consumer note

The dyadic instance (Layer 13.4) is sized for the `gq2` project's axiom B8
(`GQ2.PeripheralCyclotomicAction` in `roed-math/gq2-lean`, inspected 2026-08-08):
`GQ2.Delta = maxProPQuotient 2 (FreeProfiniteGroup (Fin 2))` matches `Δ_2`;
`GQ2.deltaP/T` match `P_2, T_2`; `GQ2.deltaC = (P·T)⁻¹` is the conjugate `P⁻¹·C_2·P` of
this roadmap's `C_2`, handled by the Layer 13.3 transfer remark; the bundle's conjugation
convention `x ^ c = c⁻¹xc` matches the statement here; and the bundle's `ι`-pinning
(`hι_proj`: the `ẑ → ℤ_2` projection of the exponent is the unit) corresponds to the
Layer 12.2 component comparison. The bundle's citation of record — Stix, ASPM 63 (2012),
§3.3 and Definition 37, with Deligne (MSRI 16, 1989) as the classical origin, and the
all-units form needing cyclotomic surjectivity — is decomposed here as
Layer 12.10 (Stix's action) + Layer 13.2 (surjectivity). An adapter producing the `gq2`
bundle from Layer 13.4 is packaging, not mathematics, and lives outside this repository.

## Sources, verified

Read directly and checked against the README's citations, 2026-08-08. A fuller transcript
with verbatim quotations is in the session handoff notes.

**Köck, "Belyi's theorem revisited"** (local PDF, `references/`; arXiv:math/0108222).
Belyi's theorem is **(3.3) Theorem** — also stated unnumbered in the introduction, so a
citation to "Theorem 1.1" is wrong. Degree reduction is **(3.5) Lemma**, whose well-founded
measure is `#S` for `S` closed under conjugation over `ℚ`, *not* a field degree. The Belyi
polynomial is **(3.6) Lemma**, `q₁(z) = ((m+n)^{m+n}/(m^m n^n)) z^m (1−z)^n`. He **does**
prove the descent direction, via (3.1) → (3.2) → (2.2), and does so through the **relative**
field of moduli `M(X, t)` of the pair, which is how he avoids his Theorem (1.8) — the one
result the paper cites without proof. README Layer 10.7 records why this roadmap pins the
specialization route instead.

⚠ Two gaps in Köck that the roadmap must discharge rather than cite: (3.6) applies the
induction hypothesis without showing the cardinality has dropped, and its hypothesis
`T ⊆ ℚ` does not match the `Crit(p) ∪ p(S) ⊆ ℚ ∪ {∞}` supplied to it. Both are recorded at
README Layer 10.2.

**Stix, "On cuspidal sections of algebraic fundamental groups"**, ASPM 63 (2012), 519–563.
The cyclotomic action on cuspidal inertia is **Definition 37(i)**, in **§7 "Orientation and
degree"** — a commutative square which for a decomposition-group element reads
`γ x γ⁻¹ = x^{χ(γ)}`, the exponent **not** inverted. ⚠ Three traps: it is not in §3.3, which
only sets up inertia and decomposition groups and contains no cyclotomic formula; the
numbering exists only in the published ASPM version, the arXiv preprint (0809.0017) carrying
the same content as unnumbered text in §7.1; and Stix's `π₁` is the opposite group of
`Aut(Ũ/U)` (§3.1), compensated by the inverse in his Definition 10, so the pair of
conventions cancels and the exponent is unaffected. Stix does not write `σ(ζ) = ζ^{χ(σ)}`
explicitly; it is pinned by his §7 definition of `Ẑ(1)` and by Definition 38, which makes
the standard orientation the tame character `σ ↦ σ(ⁿ√f)/ⁿ√f`.

**Fried**, Comm. Algebra 5 (1977): the branch cycle lemma is **(5.2)**, with exponent
`−c_γ` in his normalization (`γ(ζ_N) = ζ_N^{c_γ}`), the conjugation landing in
`N_{S_n}(G)`, and the statement relating **conjugacy classes only**, never representatives.
⚠ Völklein's restatement (p. 39) uses the opposite sign again. The roadmap's Layer 12.10 is
pinned by its own Kummer identity for exactly this reason.

**Lando–Zvonkin**, *Graphs on Surfaces*: the genus statement is **Proposition 1.5.3**
(p. 44), `χ(H) = c(σ) + c(α) + c(φ) − n = 2 − 2g`, for a hypermap = 3-constellation
(Definition 1.5.1), which is a transitive product-one triple by Definition 1.1.1.
⚠ **Their proof is topological**, so `χ ≤ 2` and the parity come there from the surface's
existence — the roadmap's Layer 0.6 deliberately proves them combinatorially instead, and
says so. Earlier drafts of this file cited "Theorem 1.3.10" and "1.2.20": both exist but are
the wrong results (the Euler characteristic of a *map*, and Construction 1.2.20 =
Riemann–Hurwitz).

**Couveignes**, "Calcul et rationalité de fonctions de Belyi en genre 0", Ann. Inst.
Fourier 44 (1994), open access on Numdam: **Théorème 3** ("Critère de Weil", p. 22) is the
accessible form of Weil's descent criterion (Köck cites Weil's original as his Theorem 1);
**Théorème 8** descends a genus-zero Belyi map whose automorphism group is cyclic of odd
order — trivial included — to the field of moduli, ⚠ **but on a conic, not necessarily on
`ℙ¹`**; §8.3 gives the Hilbert-symbol obstruction in the cyclic even-order case. README
Layer 11.6 carries the conic caveat.

Still to locate for numbering: Girondo–González-Diez (LMS ST 79), Szamuely (CSAM 117),
Forster (GTM 81), Serre (*Topics in Galois Theory*), Deligne (MSRI 16), MSSV (ANTS XIII),
Dixon–Mortimer (GTM 163), Katok (*Fuchsian Groups*).

## LMFDB state

Two independent retrievals, both 2026-08-08: the JSON API
(`https://www.lmfdb.org/api/belyi_galmaps/?_format=json&...`), and the LMFDB source
together with a full read-only pass over the `belyi_*` tables of the project's own dev
mirror. The source is `github.com/LMFDB/lmfdb` **main at `e2039c3`** (2026-08-07); the
`lmfdb/belyi/` and `scripts/belyi/` trees were verified byte-identical to it. Table sizes:
`belyi_galmaps` 1111 rows, `belyi_passports` 1007, `belyi_galmap_portraits` 915,
`belyi_specializations` 5106 (the last referenced by no application code).

⚠ The in-repo `scripts/belyi/Schema.md` is stale and must not be used: it omits
`is_primitive`, `primitivization`, the `plane_*` columns and others. The column lists below
come from `information_schema`, not from it.

⚠ The API rate-limits to a CAPTCHA challenge after roughly six requests in a minute;
pacing at one request per 75–90 seconds runs clean. It also requires typed query values
(`deg=i4`, not `deg=4`), ignores `_limit`, and paginates by `_offset` in pages of 100.

### The composition convention, verified

The knowl `belyi.permutation_triple` (fetched 2026-08-08) defines a permutation triple as
`σ = (σ_0, σ_1, σ_∞) ∈ S_d³` with `σ_∞σ_1σ_0 = 1`, and states no composition order. The
order is settled by the stored data. Reading `triples_cyc` as cycle notation and composing
in Mathlib's convention `(f * g)(x) = f (g x)`:

| record | `σ0` | `σ1` | `σinf` | `σ0 ∘ σ1 ∘ σinf` | `σinf ∘ σ1 ∘ σ0` |
| --- | --- | --- | --- | --- | --- |
| `3T2-3_2.1_2.1-a` | `(1,2,3)` | `(2,3)` | `(1,2)` | `id` | `1 ↦ 3` |
| `4T3-4_2.2_2.1.1-a` | `(1,2,3,4)` | `(1,2)(3,4)` | `(1,3)` | `id` | `1 ↦ 3` |
| `4T5-4_3.1_2.1.1-a` | `(1,2,3,4)` | `(2,4,3)` | `(1,2)` | `id` | `1 ↦ 4` |

So the stored triples satisfy **`σ0 * σ1 * σinf = 1`** in Mathlib's multiplication: the
LMFDB composes left to right, as its Magma provenance implies. The roadmap's relation
(`σinf * σ1 * σ0 = 1`) is therefore the componentwise inverse of the stored one, which is
Layer 0.1's involution, and Layer 14.2's translation lemma is exactly that involution.

**Checked exhaustively, not sampled.** Over all 4734 stored triples of `belyi_galmaps`,
`σ0 ∘ σ1 ∘ σinf = id` holds in **4734 of 4734**; the reverse order holds in only 18 (those
being the records symmetric under the swap). The two `decide`-checked `example`s in
`Suggested.lean` reproduce one instance of this in Lean.

⚠ The LMFDB source contains **no comment, docstring, or identifier anywhere** stating the
composition convention — a grep over `*.py`, `*.m`, `*.md`, `*.html` for `convention`,
`compose`, `left to right` and the like turns up nothing relevant. The convention is
recoverable only from the data, which is why it is recorded here as a computation.

⚠ Records whose data is symmetric under the swap do not discriminate — `2T1-2_2_1.1-a`
(`σ1 = σ0`, `σinf = 1`) and every `[n]/[n]/[1ⁿ]` record satisfy both orders. A convention
check must use a record with three distinct non-commuting entries; the three above are
recorded because they do.

The one-line `triples` and the cycle `triples_cyc` agree: `[2,3,4,1]` is the image list
`1↦2, 2↦3, 3↦4, 4↦1`, that is `(1,2,3,4)`.

### Schema

`belyi_galmaps` columns: `BelyiDB_label, BelyiDB_plabel, a_s, abc, aut_group, b_s,
base_field, base_field_label, c_s, curve, curve_label, deg, embeddings, friends, g,
geomtype, group, group_num, id, is_primitive, label, lambdas, map, orbit_size, pass_size,
plabel, plane_constant, plane_map_constant_factored, plane_model, primitivization, triples,
triples_cyc`.

`belyi_passports` columns: `BelyiDB_plabel, a_s, abc, aut_group, b_s, c_s, deg, g,
geomtype, group, group_num, id, is_primitive, lambdas, maxdegbf, num_orbits, pass_size,
plabel, primitivization, triples`. There is no `base_field`, `curve`, `map`, `friends` or
`orbit_size` at passport level, and `maxdegbf` exists only there.

Four schema facts that a Lean-side record type must respect:

1. **`curve_label` is absent, not null**, on records with no curve friend. The option must
   be keyed on key-presence.
2. **`(a_s, b_s, c_s)` is `abc` sorted ascending** — verified 1111/1111, and `abc`
   itself is *not* sorted: it is `(ord σ0, ord σ1, ord σinf)` in that order, and 1022 of
   1111 rows are not ascending while 555 are not monotone in either direction
   (`5T5-4.1_2.2.1_3.2-a` has `abc = [4,2,6]`). The `a_s`/`b_s`/`c_s` columns exist only to
   serve search (`query_convert_abc_list` sorts the user's input before matching) and are
   never displayed. ⚠ An earlier draft of this file said "reversed", inferred from two
   records that happened to be descending; the sorted reading is the one that holds on all
   1111.
3. **`geomtype` is not a function of `g`.** `4T4-3.1_3.1_3.1-a` has `g = 0` and
   `geomtype = "E"`; `4T5-4_4_3.1-a` has `g = 1` and `geomtype = "H"`. The field records
   the orbifold trichotomy from `1/a + 1/b + 1/c` against `1`, exactly Layer 0.7's
   `geometryType`, and never the genus.
4. **`pass_size` counts isomorphism classes, and is not a count of stored rows.** It
   appears on both record levels and means the passport's size on both; `orbit_size` is the
   individual map's Galois orbit size; `num_orbits` is passport-only. Verified over the
   whole table:

   | claim | holds |
   | --- | --- |
   | `pass_size` = number of simultaneous-`S_d`-conjugacy classes among `passport.triples` | **1007 / 1007** |
   | `num_orbits` = number of galmap rows with that `plabel` | **1007 / 1007** |
   | `maxdegbf` = max `orbit_size` over the passport's galmaps | **1007 / 1007** |
   | `len(galmap.triples)` = `galmap.orbit_size` | **1111 / 1111** |
   | `Σ orbit_size` over a passport's galmaps = `pass_size` | 1005 / 1007 |
   | `len(galmap.triples)` = `pass_size` | 923 / 1111 |

   ⚠ **`Σ orbit_size = pass_size` is NOT an identity** and must not be asserted as one. It
   fails exactly when a Galois orbit's per-embedding triples are simultaneously conjugate to
   one another — the two witnesses are `8T37-4.4_4.4_3.3.1.1` (two stored triples, one
   class, `pass_size = 1`) and `8T37-4.4_3.3.1.1_3.3.1.1` (four stored, two classes,
   `pass_size = 2`). An earlier draft of this file and of README Layer 14.3 asserted the
   identity; both are corrected.

   The knowl `belyi.pass_size` reads "The number of isomorphism classes of Belyi maps
   belonging to a given passport", which is exactly Layer 1.2's `passportSize`, and an
   independent exhaustive enumeration confirms it: for every passport of degree ≤ 7,
   `pass_size` equals the number of transitive product-one triples of the prescribed
   ramification type with monodromy in the given `dTt` class, up to simultaneous
   conjugation — 251 of 251, with the degree-8 and degree-9 checks agreeing once transitive
   classes of equal order are separated.

5. **`maxdegbf` means maximum orbit size**, despite the name suggesting a base-field
   degree; the interface labels it "Maximum orbit size". It coincides with the maximum
   base-field degree on 1003 of 1007 rows only.

6. **`triples_cyc` omits fixed points** — cycle-notation strings with no 1-cycles, the
   identity written `"()"`. Recovering `lambdas` from `triples_cyc` therefore requires
   padding, which is Layer 0.5's `fullCycleType` trap in database form. `triples` is
   one-line image notation, 1-indexed.

7. **`embeddings` is indexed against `triples`/`triples_cyc` position by position**, and
   the application relies on it: the `i`-th embedding is substituted for the base-field
   generator when rendering the `i`-th triple's curve and map. Layer 14.2's embeddings
   statement is about that correspondence, not about the values.

### Frozen acceptance records (Layer 14.5)

Five records, covering genus zero, positive genus, primitive, imprimitive, a
multiple-orbit passport, and links to both an elliptic and a genus-two curve.

1. **`4T1-4_4_1.1.1.1-a`** — genus 0, imprimitive. `deg 4`, `g 0`, `group "4T1"`,
   `abc [4,4,1]`, `lambdas [[4],[4],[1,1,1,1]]`, `geomtype "S"`, `is_primitive false`,
   `primitivization "2T1-2_2_1.1-a"`, `base_field_label "1.1.1.1"`, `orbit_size 1`,
   `pass_size 1`, `curve "PP1"`, `map "-1/(x^4-1)"`,
   `triples_cyc [["(1,2,3,4)","(1,4,3,2)","()"]]`, `friends []`.
2. **`3T2-3_2.1_2.1-a`** — genus 0, primitive. `deg 3`, `g 0`, `abc [3,2,2]`,
   `lambdas [[3],[2,1],[2,1]]`, `geomtype "S"`, `is_primitive true`,
   `base_field_label "1.1.1.1"`, `map "1/2/(x^3-3/4*x+1/4)"`,
   `triples_cyc [["(1,2,3)","(2,3)","(1,2)"]]`.
3. **`3T1-3_3_3-a`** — genus 1, primitive, linked elliptic curve over a number field.
   `deg 3`, `g 1`, `abc [3,3,3]`, `lambdas [[3],[3],[3]]`, `geomtype "E"`,
   `base_field [1,-1,1]` (that is `x² − x + 1`, so `ℚ(ζ₆)`), `base_field_label "2.0.3.1"`,
   `embeddings [[0.5, 0.8660254037844387]]`, `curve "y^2=x^3+1"`,
   `curve_label "2.0.3.1-144.1-CMa1"`, `friends ["EllipticCurve/2.0.3.1/144.1/CMa/1"]`,
   `triples_cyc [["(1,2,3)","(1,2,3)","(1,2,3)"]]`. The smallest record whose base field is
   not `ℚ`.
4. **`5T1-5_5_5-a`, `-b`, `-c` and the passport `5T1-5_5_5`** — genus 2, primitive, a
   passport with three Galois orbits. Passport: `num_orbits 3`, `pass_size 3`,
   `maxdegbf 1`, `lambdas [[5],[5],[5]]`, `geomtype "H"`, and `triples` listing exactly the
   three galmaps' triples. The three galmaps have `orbit_size 1` each and
   `base_field_label "1.1.1.1"`, with curves `y^2=x^6+2*x`, `y^2=x^6-2*x`,
   `y^2=4*x^5+1/4` and `triples_cyc` respectively
   `[["(1,2,3,4,5)","(1,4,2,5,3)","(1,2,3,4,5)"]]`,
   `[["(1,2,3,4,5)","(1,2,3,4,5)","(1,4,2,5,3)"]]`,
   `[["(1,2,3,4,5)","(1,3,5,2,4)","(1,3,5,2,4)"]]`. This is the roadmap's witness that a
   passport is not a Galois orbit.
5. **`6T6-6_6_3.3-a`** — genus 2, imprimitive, linked genus-2 curve. `deg 6`, `g 2`,
   `abc [6,6,3]`, `lambdas [[6],[6],[3,3]]`, `geomtype "H"`, `is_primitive false`,
   `primitivization "3T1-3_3_3-a"` (record 3 above, so the pair also freezes the
   primitivization relation), `curve "y^2=x^6+4*x^4+6*x^2+3"`,
   `curve_label "1728.b.442368.1"`, `friends ["Genus2Curve/Q/1728/b/442368/1"]`,
   `triples_cyc [["(1,6,2,4,3,5)","(1,3,5,4,6,2)","(1,3,5)(2,4,6)"]]`.

Other multiple-orbit passports available if a different witness is wanted:
`5T4-5_5_3.1.1` (2 orbits, size 2), `6T12-5.1_5.1_3.3` (2, 2), `6T15-5.1_4.2_4.2` (2, 4),
`6T15-5.1_5.1_4.2` (2, 8), `6T15-5.1_5.1_5.1` (4, 8), `6T16-5.1_3.2.1_3.2.1` (2, 7),
`6T16-6_6_5.1` (2, 7). The `6T15` family is where base fields become interesting:
`6T15-5.1_5.1_4.2-a` has `base_field_label "4.0.14400.3"` and `-b` has `"4.2.24000.2"`,
two different quartic fields inside one passport.

### The complete degree ≤ 4 table (Layer 3.5)

Thirteen galmaps and thirteen passports, in bijection: every passport at these degrees has
`num_orbits = 1`, `pass_size = 1`, `orbit_size = 1`, `maxdegbf = 1`. Confirmed three ways —
per-degree queries returning 1, 1, 3, 8 with exhausted pagination; the label-ordered first
page; and the passport listing.

| label | deg | g | group | abc | lambdas | geomtype | prim | base field | primitivization |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `1T1-1_1_1-a` | 1 | 0 | 1T1 | [1,1,1] | [[1],[1],[1]] | S | yes | 1.1.1.1 | self |
| `2T1-2_2_1.1-a` | 2 | 0 | 2T1 | [2,2,1] | [[2],[2],[1,1]] | S | yes | 1.1.1.1 | self |
| `3T1-3_3_1.1.1-a` | 3 | 0 | 3T1 | [3,3,1] | [[3],[3],[1,1,1]] | S | yes | 1.1.1.1 | self |
| `3T1-3_3_3-a` | 3 | 1 | 3T1 | [3,3,3] | [[3],[3],[3]] | E | yes | 2.0.3.1 | self |
| `3T2-3_2.1_2.1-a` | 3 | 0 | 3T2 | [3,2,2] | [[3],[2,1],[2,1]] | S | yes | 1.1.1.1 | self |
| `4T1-4_4_1.1.1.1-a` | 4 | 0 | 4T1 | [4,4,1] | [[4],[4],[1,1,1,1]] | S | no | 1.1.1.1 | `2T1-2_2_1.1-a` |
| `4T1-4_4_2.2-a` | 4 | 1 | 4T1 | [4,4,2] | [[4],[4],[2,2]] | E | no | 1.1.1.1 | `2T1-2_2_1.1-a` |
| `4T2-2.2_2.2_2.2-a` | 4 | 0 | 4T2 | [2,2,2] | [[2,2],[2,2],[2,2]] | S | no | 1.1.1.1 | `2T1-2_2_1.1-a` |
| `4T3-4_2.2_2.1.1-a` | 4 | 0 | 4T3 | [4,2,2] | [[4],[2,2],[2,1,1]] | S | no | 1.1.1.1 | `2T1-2_2_1.1-a` |
| `4T4-3.1_3.1_2.2-a` | 4 | 0 | 4T4 | [3,3,2] | [[3,1],[3,1],[2,2]] | S | yes | 1.1.1.1 | self |
| `4T4-3.1_3.1_3.1-a` | 4 | 0 | 4T4 | [3,3,3] | [[3,1],[3,1],[3,1]] | E | yes | 1.1.1.1 | self |
| `4T5-4_3.1_2.1.1-a` | 4 | 0 | 4T5 | [4,3,2] | [[4],[3,1],[2,1,1]] | S | yes | 1.1.1.1 | self |
| `4T5-4_4_3.1-a` | 4 | 1 | 4T5 | [4,4,3] | [[4],[4],[3,1]] | H | yes | 1.1.1.1 | self |

Their `triples_cyc`, in the same order, are: `["()","()","()"]`;
`["(1,2)","(1,2)","()"]`; `["(1,2,3)","(1,3,2)","()"]`; `["(1,2,3)","(1,2,3)","(1,2,3)"]`;
`["(1,2,3)","(2,3)","(1,2)"]`; `["(1,2,3,4)","(1,4,3,2)","()"]`;
`["(1,2,3,4)","(1,2,3,4)","(1,3)(2,4)"]`; `["(1,4)(2,3)","(1,2)(3,4)","(1,3)(2,4)"]`;
`["(1,2,3,4)","(1,2)(3,4)","(1,3)"]`; `["(1,2,3)","(1,2,4)","(1,3)(2,4)"]`;
`["(1,2,3)","(1,3,4)","(2,4,3)"]`; `["(1,2,3,4)","(2,4,3)","(1,2)"]`;
`["(1,2,3,4)","(1,3,4,2)","(1,3,4)"]`.

Two facts worth stating as acceptance properties of Layer 3.5: exactly four of the thirteen
are imprimitive, and **all four primitivize to `2T1-2_2_1.1-a`**; and the two records with
`g = 1` at degree 4 (`4T1-4_4_2.2-a`, `4T5-4_4_3.1-a`) have friends
`EllipticCurve/Q/32/a/3` and `EllipticCurve/Q/48/a/6` respectively, so Layer 10.8's
genus-one acceptance example can be taken from frozen data rather than constructed.

⚠ The table is the roadmap's *comparison target*, not evidence of completeness. Layer 3.5
proves its own classification and checks that each frozen record matches exactly one
enumerated class and distinct records match distinct classes; that every class appears in
the database is not claimed, and Layer 14 excludes completeness by name.

## Open items tracked here

- Exact theorem numbers still outstanding: Girondo–González-Diez's Riemann-existence
  chapter (Layers 7–9); Forster's numbered statements for Layers 8.2, 8.3, 8.5 and 9.2–9.3
  (cited by section today); Szamuely's chapter-3/4 statements backing Layer 12's route;
  Katok's matrices for Layer 4.5. Köck, Stix, Fried, Lando–Zvonkin, Couveignes and Weil are
  done — see §Sources, verified.
- The LMFDB source commit behind the frozen schema above: the records were taken from the
  live API, so the column lists are dated rather than pinned to a `github.com/LMFDB/lmfdb`
  revision. Pinning one would let Layer 14.1's certificate cite a source file.
- Whether the MSSV paper states the composition order in words, which would let Layer 14.2
  cite a sentence in addition to the frozen-record computation above.
