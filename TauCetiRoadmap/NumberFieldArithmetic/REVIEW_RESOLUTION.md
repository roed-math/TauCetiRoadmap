# Review resolution — PR #9 Number Field Arithmetic

Second review pass. The first pass removed the general integral Artin conductor and narrowed
the LMFDB label API; that correction was not carried through consistently, and the review
found two further mathematical problems. Both are fixed here, together with the rest of the
list. The roadmap was rewritten rather than patched, so the diff is large.

## Mathematical corrections

- **No Frobenius in the absolute Galois group.** The "required profinite-packaging milestone"
  claimed a canonical Frobenius class in `Gal(K̄/K)`. There is none: the canonical object is
  arithmetic Frobenius in `D_v/I_v ≅ Gal(k̄_v/k_v)`, and a lift to `D_v` is well defined only
  modulo inertia, so compatible classes in the finite quotients do not assemble. The milestone
  is deleted, a conventions-table row records that every Frobenius statement here is
  finite-level, and §Explicit scope exclusions states the form a future ArtinRepresentations
  roadmap actually needs (a finite-image representation unramified at `v` kills `I_v`, so the
  image of any lift is well defined up to conjugacy).
- **Complex conjugation is not a Frobenius.** The "Frobenius at a real place" milestone is
  renamed and restated as the canonical element of the order-2 stabilizer at a ramified real
  place, via `ComplexEmbedding.IsConj`/`IsCMField.complexConj`, with an explicit note that
  there is no residue field and no `q`-power congruence at an infinite place.
- **The layers are now a genuine dependency order.** The old text advertised "the dependency
  order, with two flagged back-edges", which is not a dependency order. The completion
  dictionary moved ahead of the ramification consequences (old Layer 6 is now Layer 5, old
  Layer 5 is now Layer 6), the exact tame/wild different exponents moved out of Layer 4 into
  Layer 6 because their proofs complete, and the index material moved out of Layer 7 into
  Layer 3 because Dedekind's theorem needs it. The word "back-edge" is gone.
- **The Local Fields dependency is now layer-accurate.** Layer 5 consumes their Layers 0–2;
  Layer 6, which is the only layer needing the lower filtration, `v(𝔡) = Σ(#G_i − 1)`, and the
  tame/wild exponents, consumes their **Layer 3**. Ownership is stated once: PR #2 owns local
  ramification theory, PR #9 owns the canonical completion maps and the global comparison. The
  global filtration is defined as a comparison-facing object and the comparison theorem is its
  central API; no second lower-ramification theory is built here.
- **Conductor-free, except the order conductor.** Removed the stale "Artin-conductor
  bookkeeping and both conductor–discriminant statements" sentence, the generic `f_𝔭(χ)`
  localization clause, the "gated milestone" language in provenance, and the cyclotomic
  conductor-product target from `Suggested.lean`. The `ℚ(ζ₅)` and quadratic conductor examples
  are marked as cross-checks consumed from PR #6 once it proves them. The permutation milestone
  is restated as a direct discriminant-exponent formula,
  `e(Q/𝔮)·v_𝔮(𝔇_{M/K}) = Σ_{i≥0}(#G_i − #(G_i ⊓ H))`, whose two sides are integers and which
  mentions no conductor.
- **One ideal Artin map, one owner, one carrier.** Layer 2 now builds
  `artinHomUnramified : J^S →* (L ≃ₐ[K] L)` where `S` is the set of primes dividing
  `relDiscr (𝓞 K) (𝓞 L)` and `J^S` is the subgroup of `(FractionalIdeal (𝓞 K)⁰ K)ˣ` of
  fractional ideals with zero exponent on `S`, which is literally PR #6's `J^{𝔪₀}` carrier. The
  integral-ideal monoid hom is a corollary. PR #6 consumes this map and owns all reciprocity.
- **The Dedekind layer is exact.** The index prerequisites now precede the exported theorem:
  the power-basis index, `disc(minpoly θ) = index(θ)²·discr K`,
  `p ∣ index θ ↔ p ∣ RingOfIntegers.exponent θ`, and therefore
  `p ∤ disc(minpoly θ) → p ∤ exponent θ`, which is the implication the polynomial-side
  corollary uses. The index is defined on an `IntegralPrimitiveElement K` subtype, so a
  non-generator cannot produce Mathlib's junk value `0`. Dedekind's criterion is stated exactly
  and over `ℤ`: `¬ p ∣ index θ ↔ ∀ i, eᵢ = 1 ∨ ¬ φᵢ ∣ H̄`, with monic lifts, the coefficientwise
  divisibility of `f − ∏ Φᵢ^{eᵢ}` by `p`, and independence of the lifts as named milestones.
- **The arbitrary-monic corollary is proved, not assumed.** PR #10 consumes the statement on
  reducible `f` (it derives the mod-`p` irreducibility criterion from it), so the reduction to
  the distinct `ℤ`-irreducible factors is spelled out as five named lemmas: separability from
  `p ∤ f.discr`, the discriminant/resultant factorization, the disjoint union of root sets,
  additivity of the full cycle type and of the factor-degree multiset, and one Frobenius
  restricting to all factors at once. The `NumberField f.SplittingField` instance is now an
  explicit prerequisite milestone.
- **Ramified data are not cycle types.** For `3.1.23.1` the unramified primes `2, 3, 5, 7, 59`
  are listed as Dedekind-theorem instances and `23` is listed separately as Kummer–Dedekind and
  different data, with a note that no Frobenius class exists there. "`59` is the least totally
  split prime" is weakened to "`59` splits completely", since no milestone checks the smaller
  primes.
- **Explicit units are certified, not asserted.** Mathlib's Dirichlet theorem does not prove
  that a named unit has index one, so the exact regulator claims previously had no proof route.
  Layer 7 gains an explicit unit certification milestone: the rank-one criterion, the finiteness
  making it checkable (`NumberField.Embeddings.finite_of_norm_le`, reduced to a finite search
  over bounded integral minimal polynomials), and the consequence via
  `regOfFamily_div_regulator`. `2.2.5.1` and `3.1.23.1` now state their certification before
  their regulator, and the cubic's unit is pinned by `θ·(θ² − θ) = −1`. Decimals are labeled as
  orientation only and are never theorem targets.
- **The global–local statements use canonical objects.** The canonical continuous `K_v → L_w`
  is now a milestone with a uniqueness statement, and every theorem in Layer 5 is about it;
  where an `Algebra` instance is still assumed in `Suggested.lean`, two hypotheses (continuity
  and compatibility with `K → L`) pin it to the canonical one, and they disappear when the
  construction lands. Also pinned: the semilocal index type, the norm and trace equations with
  every map written out, the Galois hypothesis on `D_Q ≅ Gal(L_w/K_v)`, the different
  localization through the actual ideal map, the residue-degree-weighted discriminant valuation
  `v_𝔭(relDiscr) = Σ_{P∣𝔭} f(P/𝔭)·v_P(𝔡)`, a single multiplicity normalization in which `v_P(e)`
  is defined, and `ℕ`-indexed ramification groups with the decomposition group named separately.
- **The LMFDB claim is narrowed.** The mission is now the core intrinsic arithmetic invariants
  and their relations, not "everything on an LMFDB number-field page". Layer 8 keeps
  `HasLMFDBIntrinsicLabel K d r D` for `d.r.|D|`, says that full labels are external names for
  the examples, and replaces "nothing unaccounted" with a page-datum/owner/status table in which
  the `.i` coordinate, the normalized defining polynomial, bounded-list completeness, sibling
  fields, and Artin conductors are listed `out of scope`.
- **Narrow class group ownership** points at PR #6 Layer 1, per the current family contract;
  Multiquadratic consumes it, and Layer 8's page map consumes it from PR #6.
- Smaller corrections: no Tau Ceti `IsUnramifiedIn` clone (pointwise quantification now,
  refactor onto master's `Algebra.IsUnramifiedIn` on bump); the "never modified" claim about
  landed TauCeti files is replaced by an explicit narrowly scoped public-API amendment to
  `SplitsCompletely.lean`; the Artin symbol is indexed by a prime ideal of `𝓞 K` with the
  rational-prime form as a corollary; the monogenicity predicate's namespace and carrier are
  pinned; the quadratic Frobenius hypotheses are written out in full; pseudo-future language
  ("may add corollaries", "to be added") is gone from numbered layers; and the nonexistent
  `§Still-wanted references` cross-reference now points at `§References`.

## Presentation

The roadmap was also rewritten for tone: no em-dashes (the previous version had 177, far above
every sibling roadmap), and no "connective tissue", "workhorse", "spine", "engine", "first
stone", "goldmine", "smoke test", or "flagship". The mathematics and the citations are
unchanged by that pass.

## Files changed

- `TauCetiRoadmap/NumberFieldArithmetic/README.md`
- `TauCetiRoadmap/NumberFieldArithmetic/Suggested.lean`
- `TauCetiRoadmap/NumberFieldArithmetic/REVIEW_RESOLUTION.md`

## `Suggested.lean` deltas

Removed: the cyclotomic conductor-product example; the raw `Nat.card` index expression.
Added: the relative and base-`ℚ` Artin symbols; the `J^S` Artin homomorphism in PR #6's
carrier; the complex-conjugation element at a real place; `IntegralPrimitiveElement`, `index`,
the index formula, the index/exponent comparison and the checkable `p ∤ disc → p ∤ exponent`
implication; Dedekind's criterion over `ℤ`; the `NumberField f.SplittingField` instance; the
common-index-divisor counting obstruction; the full `IsNonarchimedeanLocalField` target in place
of the weak local-compactness example; the canonical completion map with uniqueness; the
semilocal decomposition; the decomposition-group/completion equivalence; the
residue-degree-weighted discriminant valuation; the `ℕ`-indexed global ramification group with
its `G 0 = inertia` reconciliation; the different-exponent formula; the wild bounds; the
permutation-action discriminant formula; the monogenicity predicate; the three explicit unit
certification targets; `HasLMFDBIntrinsicLabel` with sign recovery; and the `2.0.4.1 = ℚ(i)`
worked section. The `3.1.23.1` section now separates unramified from ramified data.

## Mathematical choices

- General Artin conductors are not represented by ordinary ideals before exponent integrality,
  and this roadmap forms no conductor object other than the order conductor.
- Hermite finiteness is not treated as a canonical database ordering.
- PR #9 owns the Frobenius/Dedekind supplier theorem including the reducible case; PR #10 owns
  the consumer-side `fullCycleType` abbreviation and the certificate logic.
- PR #9 owns the ideal Artin map's construction; PR #6 owns its reciprocity properties.
- PR #2 owns local ramification theory; PR #9 owns the completion comparison and the global
  ideal-theoretic corollaries.

## Checks

Run from this branch at `9d89ea2` + these commits, toolchain `leanprover/lean4:v4.31.0-rc1`.

- `lake build TauCetiRoadmap.NumberFieldArithmetic.Suggested` — **passed**, `sorry` warnings
  only (86 of them, one per suggested target).
- `lake build` — **passed**. The only non-`sorry` warnings are the pre-existing
  `linter.overlappingInstances` ones in `TauCetiRoadmap/RepresentationTheory/LieGroups`, which
  this branch does not touch.
- `git diff --check` — **passed**, no output.
- Handoff consistency grep over `TauCetiRoadmap/NumberFieldArithmetic` for
  `everything on|nothing unaccounted|d\.r\.\|D\|\.i|Artin-conductor|both conductor|gated milestone|profinite-packaging|Frobenius at a real place|to be added|Still-wanted|back-edge|may add corollaries|never .*modified`
  — the only surviving matches are in this file, describing the corrections.
- Grep for `Local Fields.*Layers 0.?2` — the three matches are Layer 5's own dependency
  statement and the two ordering sentences that contrast it with Layer 6's dependency on their
  Layer 3.
- Sibling links to PRs #2, #6, #8 and #10 checked by hand.

## Rebase and integration

The branch sits on `main` at `9d89ea2`, which is the current family-integration base; no rebase
was needed. Family index `23` is preserved, matching the sibling branches' assignments (#1–#10
take 15–24 in the proposed landing order), and the single global import in `TauCetiRoadmap.lean`
is unchanged.

## Remaining coordination

- Re-check mathlib #41591 at the toolchain bump and consume the ring-level API when it lands.
- Co-review Layer 5's four boundary statements with the Local Fields authors, and Layer 2's
  `J^S` carrier with the Global Class Field Theory authors, before either layer starts.
- Coordinate the `SplitsCompletely.lean` visibility change with that file's authors.
- Obtain an explicit licence and permission, and agree a certification interface, before
  adapting anything from `CertifyingInvariantsNF`.
</content>
