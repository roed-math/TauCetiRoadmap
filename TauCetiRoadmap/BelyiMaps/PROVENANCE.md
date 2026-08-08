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
  unproved. Layer 6.3 here cites the milestone, and Layer 5.4's engine supplies the
  constructive direction independently, so nothing here waits on those gaps.
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
  the ownership decision here: BelyiMaps Layer 13.1 owns the calculus, in the generic
  namespace, and a future ProPGroups revision absorbing it would be a rename. Flagged for
  the owner: whether to add a BelyiMaps consumer row to ProPGroups' interface table when
  both PRs are open (a cross-PR edit this roadmap does not make unilaterally).

## Decisions of record

1. **The product relation is `σinf * σ1 * σ0 = 1`**, where the implementation plan this
   roadmap started from prescribed `σ0 * σ1 * σinf = 1`. The plan licensed a documented
   change when the API audit forces one, and it does: with Mathlib's `End`-multiplication
   and covariant monodromy (verified above), the plan's relation would make every
   monodromy correspondence an antihomomorphism or force inverses through Layers 6–13,
   including a spurious inverse in the branch-cycle exponent. The chosen display also
   coincides with the LMFDB knowl (fetched 2026-08-08: "σ_∞σ_1σ_0 = 1"). The
   componentwise-inversion involution (Layer 0.1) is the exact translation to the rival
   convention.
2. **The carrier is named `PermutationTriple`**, not the plan's `BelyiTriple`: "permutation
   triple" is the term of the LMFDB knowl and of Musty–Schiavone–Sijsling–Voight, and the
   object carries no Belyi structure.
3. **`C := (T * P)⁻¹`** (so `C·T·P = 1`), matching the topological relation; a source or
   consumer with `P·T·C = 1` names the conjugate `P⁻¹·C·P`, and Layer 13.5's remark
   records the two-line transfer.
4. **Layer 12 is field-theoretic**: `π₁ᵍᵉᵒ := Gal(Ω/ℚ̄(t))` for `Ω` the maximal extension
   unramified outside the three marked places, so the carrier is Mathlib Galois theory
   plus AlgebraicCurves ramification, and no étale-π₁-of-schemes development is needed.
   The scheme-theoretic comparison is an explicit scope exclusion.
5. **Geometry type lives in Layer 0** (an order-triple invariant), with the
   triangle-group trichotomy in Layer 4; the plan had it in its passport layer.
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

The dyadic instance (Layer 13.6) is sized for the `gq2` project's axiom B8
(`GQ2.PeripheralCyclotomicAction` in `roed-math/gq2-lean`, inspected 2026-08-08):
`GQ2.Delta = maxProPQuotient 2 (FreeProfiniteGroup (Fin 2))` matches `Δ_2`;
`GQ2.deltaP/T` match `P_2, T_2`; `GQ2.deltaC = (P·T)⁻¹` is the conjugate `P⁻¹·C_2·P` of
this roadmap's `C_2`, handled by the Layer 13.5 transfer remark; the bundle's conjugation
convention `x ^ c = c⁻¹xc` matches the statement here; and the bundle's `ι`-pinning
(`hι_proj`: the `ẑ → ℤ_2` projection of the exponent is the unit) corresponds to the
Layer 13.2 component comparison. The bundle's citation of record — Stix, ASPM 63 (2012),
§3.3 and Definition 37, with Deligne (MSRI 16, 1989) as the classical origin, and the
all-units form needing cyclotomic surjectivity — is decomposed here as
Layer 12.8 (Stix's action) + Layer 13.4 (surjectivity). An adapter producing the `gq2`
bundle from Layer 13.6 is packaging, not mathematics, and lives outside this repository.

## Sources

In the owner's `references/` collection (main checkout, `references/MANIFEST.md`):
Köck, "Belyi's theorem revisited" (arXiv:math/0108222 PDF, 13 pp) — the Layer 10 route.

To acquire or locate before the exact-theorem-number pass (each README citation that
names no theorem number is blocked on its source): Girondo–González-Diez (LMS ST 79),
Lando–Zvonkin (EMS 141), Cori–Machì (Exposition. Math. 10), Szamuely (CSAM 117), Serre
(*Topics in Galois Theory*), Stix (ASPM 63; also arXiv), Deligne (MSRI 16; the volume is
online at MSRI), Fried (Comm. Algebra 5), Weil (Amer. J. Math. 78), MSSV (ANTS XIII, OBS
2, open access), Sijsling–Voight (Publ. Math. Besançon, open access), Dixon–Mortimer
(GTM 163), Katok (*Fuchsian Groups*).

## LMFDB state

- Knowl `belyi.permutation_triple` fetched 2026-08-08: a permutation triple is
  `σ = (σ_0, σ_1, σ_∞) ∈ S_d³` with `σ_∞σ_1σ_0 = 1`; the page does not state its
  composition convention. The convention behind the *stored* `triples`/`triples_cyc`
  strings must be pinned from the MSSV paper and the LMFDB source before Layer 14.2's
  translation lemma is stated in final form; until then the README treats the translation
  as a theorem to prove, not an identity to assume.
- The passport- and orbit-level field lists in the implementation plan (`plabel`, `group`,
  `abc`, `g`, `deg`, `geomtype`, `lambdas`, `pass_size`, `num_orbits`, `maxdegbf`,
  `is_primitive`, `primitivization`; `label`, `triples`, `orbit_size`, `base_field`,
  `embeddings`, `curve`, `map`, `plane_model`, `curve_label`, `friends`) are recorded
  here as *unverified* until the dated schema snapshot (LMFDB source commit + retrieval
  date) is frozen into this file, together with the Layer 14.5 acceptance records.

## Open items tracked here

- Exact theorem numbers for: the Lando–Zvonkin/Cori–Machì genus inequality (Layer 0.6);
  Girondo–González-Diez's Riemann-existence chapter (Layers 7–9); Köck's numbered
  statements for 10.2–10.7; Szamuely's chapter-3/4 statements backing Layer 12's route;
  Stix §3.3/Definition 37 against Layer 12.8's normalization; Fried's branch-cycle lemma
  statement; Weil's descent criterion against Layer 11.4.
- The LMFDB schema snapshot and frozen acceptance records (Layers 14.1, 14.5).
- The stored-triple composition convention (Layer 14.2), from MSSV and the LMFDB source.
- Owner decisions: a ProPGroups interface-table row (above); whether to file an upstream
  intention issue before the pull request opens.
