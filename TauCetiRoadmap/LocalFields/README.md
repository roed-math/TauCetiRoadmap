# Roadmap: local fields, ramification, and local class field theory

Mathlib now has a definition of a nonarchimedean local field — the class
[`IsNonarchimedeanLocalField`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LocalField/Basic.html)
in `Mathlib/NumberTheory/LocalField/Basic.lean` (Andrew Yang, 2025), built on the `ValuativeRel`
framework: a topological field whose topology comes from its valuation class, locally compact and
nondiscrete. At the pin this is one thin file, but a well-chosen one: it derives
`IsDiscreteValuationRing 𝒪[K]`, `Finite 𝓀[K]`, compactness of `𝒪[K]`, and the value-group
isomorphism `ValueGroupWithZero K ≃*o ℤᵐ⁰` from the definition, and it is the vocabulary the
active class-field-theory formalization ([kbuzzard/ClassFieldTheory](https://github.com/kbuzzard/ClassFieldTheory))
has adopted. Beyond the definition, almost the entire arithmetic of local fields is missing
upstream: there is no unit-filtration theory, no unramified-extension theory with Frobenius, no
higher ramification (the pin's `RingTheory/Valuation/RamificationGroup.lean` has only
decomposition and inertia groups, with an explicit `TODO: Define higher ramification groups in
lower numbering`), no tame quotient, no Herbrand quotient, no invariant map, no fundamental
classes, no reciprocity map, no local Tate duality, no Euler characteristic. This roadmap builds
that arithmetic: the structure theory of local fields and their extensions, the ramification
filtration in both numberings, the tame quotient of the absolute Galois group, and local class
field theory through duality, the Euler characteristic, and the topological finite generation of
`G_K` — each layer with its complete basic theory, not just the headline theorems.

Local class field theory is being formalized right now in `kbuzzard/ClassFieldTheory` (the 2025
Clay Summer School project, currently maintained by Yunzhou "Edison" Xie), whose abstract half —
Tate cohomology (now upstreamed to Mathlib master), the Herbrand-quotient calculus, a
`FiniteClassFormation` interface with a sorry-free abstract reciprocity isomorphism — is done,
and whose local half (unramified-unit cohomology, the local-unit Herbrand quotient, fundamental
classes, the Artin map) is open as of 2026-07-26. Ramification filtrations have a partial,
stalled formalization in [Akwardbro/RamificationGroup](https://github.com/Akwardbro/RamificationGroup)
(Junjie Bai, Jiedong Jiang, et al., following Serre *Local Fields* IV; last activity 2026-03-01).
This roadmap develops the same mathematics **independently in Tau Ceti**, in Mathlib's
`IsNonarchimedeanLocalField`/`ValuativeRel` vocabulary, citing and staying
convention-compatible with both projects (§Provenance): the interfaces are aligned so that
milestones can refactor onto their work if it lands in Mathlib, and so that results proved here
are usable by their consumers (the [FLT](https://github.com/ImperialCollegeLondon/FLT) blueprint
explicitly consumes local reciprocity as a `\notready` input).

Suggested home: `TauCeti/NumberTheory/LocalField/`, mirroring the Mathlib path that owns the
`IsNonarchimedeanLocalField` class, with subdirectories per layer (`Basic/`, `UnitFiltration/`,
`Unramified/`, `Ramification/`, `TameQuotient/`, `Cohomology/`, `ClassFormation/`,
`Reciprocity/`, `Duality/`, `FiniteGeneration/`). Keeping the Tau Ceti path parallel to the
Mathlib one makes eventual upstreaming a file move, not a renaming.

This roadmap is one of four coordinated developments. It **consumes**
[continuous cohomology of profinite groups](../ProfiniteCohomology/README.md) (roadmap in
preparation) for all cohomological machinery — low-degree theory, restriction/inflation/
corestriction, cup products, long exact sequences, Shapiro, colimits over open subgroups — and
[pro-p groups](../ProPGroups/README.md) (roadmap in preparation) for profinite Sylow theory and
the Frattini generation criterion. It **supplies** the duality and Euler-characteristic layer
that the pro-p roadmap's "`G_K(p)` is Demushkin" theorem consumes, and the mod-2 duality bridge
at which [quadratic form invariants](../QuadraticFormInvariants/README.md) (roadmap in
preparation) meets local duality (Layer 8). The neighboring
[adic-spaces roadmap (PR #80)](https://github.com/TauCetiProject/TauCetiRoadmap/pull/80)
shares only the `ValuativeRel` substrate: it develops valuation *spectra* and Huber/Tate rings
toward the Fargues–Fontaine curve and does not touch local-field arithmetic (ramification, unit
filtrations, reciprocity), so the boundary is clean.

## Standing hypotheses

The standing setting is a field `K` with `[Field K] [ValuativeRel K] [TopologicalSpace K]
[IsNonarchimedeanLocalField K]`, and for extensions a second such field `L` with
`[Algebra K L] [ValuativeExtension K L]` and finiteness `[Module.Finite K L]`. Spell these out;
do not bundle them into a new class. Where a statement needs completeness, add the uniform
hypotheses `[UniformSpace K] [IsUniformAddGroup K]` as Mathlib's own `CompleteSpace` instances
do. Do not fix `p` prime or `K/ℚ_p` finite in the general layers: everything through Layer 8
holds for local fields of either characteristic (residue characteristic `p`), and
positive-characteristic `K = 𝔽_q((t))` is a worked example, not an exclusion. Only Layer 9
(finite generation, `d(G_K) ≤ [K:ℚ_p] + 2`) and the `ℚ_p`-specific worked examples restrict to
mixed characteristic. ⚠ Never assume `p ≠ 2`: every downstream consumer of this roadmap lives
at `p = 2`, and the literature is full of odd-`p` shortcuts (NSW's (7.5.14) subsection assumes
`p ≠ 2`; tame arguments silently assume `p ∤ e`). Statements must carry their true hypotheses.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| valuation, multiplicative | Mathlib's canonical `ValuativeRel.valuation K` into `ValueGroupWithZero K ≃*o ℤᵐ⁰`; `v(π) = exp (−1)` for a uniformizer `π` (so `v < 1` on `𝓂[K]`), matching `Padic.mulValuation x = exp (−x.valuation)` | `Mathlib/NumberTheory/Padics/PadicNumbers.lean`, `Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean` |
| valuation, normalized additive | `v_K : K → ℤᵐ⁰ → ℤ` via `WithZero.log`; `v_K(π) = 1`, `v_K` surjective onto `ℤ` on `Kˣ`, `v_K(unit) = 0` | this roadmap (Layer 0); translation `v_K = −log ∘ valuation` is a named lemma |
| absolute value | `‖x‖_K = q^{−v_K(x)}` with `q = Nat.card 𝓀[K]`; this is what makes the Euler characteristic read `‖#M‖_K` (Layer 8) and matches `Padic.norm_eq_zpow_neg_valuation` | Layer 0 |
| residue field, integers | `𝒪[K]`, `𝓂[K]`, `𝓀[K]` — the `ValuativeRel`-scoped notations (`Valuation.integer (valuation K)` etc.); never a rival valuation-subring | `Mathlib/Topology/Algebra/Valued/ValuativeRel.lean` |
| unit filtration | `U(K, 0) = 𝒪[K]ˣ`, `U(K, i) = 1 + 𝓂[K]^i` for `i ≥ 1`, as a decreasing family of open subgroups of `Kˣ` (literature `U_K^{(i)}`) | Layer 1 |
| Frobenius | **arithmetic** Frobenius `x ↦ x^q` on residue fields is the distinguished generator; "Frobenius" unqualified always means arithmetic; geometric Frobenius is its inverse and is always named `geometric` | Layer 2 |
| reciprocity normalization | `Art_K : Kˣ →* G_K^{ab}` sends **uniformizers to arithmetic Frobenius**; equivalently `ν_K ∘ Art_K = v_K` with `ν_K : G_K^{ab} →* Ẑ` the unramified coordinate normalized by `ν_K(Frob) = 1` (the Neukirch/NSW convention). The geometric normalization `Art_K^{geo} = Art_K ∘ (·)⁻¹` is a definition plus a translation lemma, never a second convention | Layer 7 |
| unramified coordinate target | `ν_K` targets `Ẑ` (profinite), **never** `ℤ`: a continuous homomorphism from the compact `G_K^{ab}` to discrete `ℤ` is trivial, so the `ℤ`-valued version of the normalization is *inconsistent*, not just inconvenient | Layer 2/7 (⚠ trap) |
| invariant map | `inv_{L/K} : H²(Gal(L/K), Lˣ) ≃ (1/[L:K])ℤ/ℤ` for the unramified case normalized by Frobenius-evaluation: under `H²(Ẑ-quotient, ℤ) ≅ H¹(·, ℚ/ℤ) = Hom(·, ℚ/ℤ)`, the class maps to evaluation at **arithmetic** Frobenius; `inv_K(u_{L/K}) = 1/[L:K]` for the fundamental class | Layer 5 |
| Herbrand quotient | `h(G, M) = #H²(G, M) / #H¹(G, M)` for finite cyclic `G` (equivalently `#Ĥ⁰/#Ĥ¹`); `h(Gal(L/K), Lˣ) = [L:K]`, `h(Gal(L/K), 𝒪[L]ˣ) = 1` | Layer 5; matches `herbrandQuotient` in kbuzzard/ClassFieldTheory |
| tame relation | `σ τ σ⁻¹ = τ^q` with `σ` an **arithmetic** Frobenius lift and `τ` a topological generator of tame inertia `I_t ≅ Ẑ^{(p')}(1)`; the `(1)` records that the `G_K`-action on `I_t ≅ lim_{p∤m} μ_m` is the cyclotomic one — the same statement as the relation. The geometric-`σ` presentation (`σ⁻¹ τ σ = τ^q`, used by gq2) is an isomorphic presentation via `σ ↦ σ⁻¹`, provided as a translation lemma | Layer 4 |
| ramification filtration | lower numbering `G_i` for `i ≥ −1` with `G_{−1} = G`, `G_0` = inertia, `G_1` = wild inertia (Serre LF IV §1); Herbrand functions `φ_{L/K}, ψ_{L/K}`; upper numbering `G^u = G_{ψ(u)}` | Layer 3 |
| Tate dual | per-`n`: for an `n`-torsion finite discrete `G_K`-module `M`, the dual is `Hom(M, μ_n)` with conjugation action; the compatibility of the pairings along `μ_n ⊆ μ_{nm}` is a **named milestone**, not an omission (it is the flagged deviation in gq2's B6 encoding, repaired here) | Layer 8 |
| class formation interface | finite level: align with kbuzzard/ClassFieldTheory's sorry-free `FiniteClassFormation` (a distinguished class `σ ∈ H²(G, M)` with `H¹`-vanishing on subgroups and `H²`-generation hypotheses) — that design is settled and proven; the profinite-level formation `(G_K, K̄^{sep,×})` with compatible invariants is stated NSW-style on top of it | Layer 5/6 |

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:" flags material that landed after
the pin, to be consumed on the next toolchain bump rather than rebuilt.

- **The local-field class:** `Mathlib/NumberTheory/LocalField/Basic.lean` —
  `IsNonarchimedeanLocalField`, with instances `IsTopologicalDivisionRing K`,
  `CompactSpace 𝒪[K]`, `IsDiscreteValuationRing 𝒪[K]`, `Finite 𝓀[K]`,
  `ValuativeRel.IsDiscrete K`, `IsRankLeOne K`, `IsCyclic (ValueGroupWithZero K)ˣ`, the
  isomorphism `valueGroupWithZeroIsoInt : ValueGroupWithZero K ≃*o ℤᵐ⁰`, and (under uniform
  hypotheses) `CompleteSpace K`, `CompleteSpace 𝒪[K]`, `IsAdicComplete 𝓂[K] 𝒪[K]`.
- **The valuative framework:** `Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean`
  (`ValuativeRel`, the canonical `valuation`, `Valuation.Compatible`, `ValuativeExtension`,
  `IsNontrivial`, `IsRankLeOne`), `Mathlib/RingTheory/Valuation/DiscreteValuativeRel.lean`
  (`IsDiscrete` via `ℤᵐ⁰`-compatibility), `Mathlib/Topology/Algebra/Valued/ValuativeRel.lean`
  (`IsValuativeTopology`, the `𝒪[K]/𝓂[K]/𝓀[K]` notations),
  `Mathlib/Topology/Algebra/Valued/LocallyCompact.lean` (`compactSpace_iff_completeSpace_and_
  isDiscreteValuationRing_and_finite_residueField` and the closed-ball API).
- **`ℚ_p`:** `Mathlib/NumberTheory/Padics/` — `PadicInt` with `unitCoeff`, Hensel's lemma
  (`Hensel.lean`), `ProperSpace ℚ_[p]`, `Padic.valuation`/`addValuation`, and
  `Padic.mulValuation : Valuation ℚ_[p] ℤᵐ⁰` with the instances `ValuativeRel ℚ_[p]`,
  `Valuation.Compatible`, `IsNontrivial`, `IsRankLeOne` (`Padics/ValuativeRel.lean`). ⚠ The pin
  has **no** `IsValuativeTopology ℚ_[p]` and hence no `IsNonarchimedeanLocalField ℚ_[p]`; that
  instance is Layer 0's first milestone (it exists sorry-free in kbuzzard/ClassFieldTheory's
  `IsNonarchimedeanLocalField/Qp.lean` — coordinate, don't copy).
- **Valuation extension:** `Mathlib/RingTheory/Valuation/Extension.lean` (the
  valuation-extension typeclass, equivalence-not-equality by design, with the uniformizer-vs-`p`
  normalization discussion in its docstring), `Mathlib/RingTheory/Valuation/AlgebraInstances.lean`
  and `Minpoly.lean` (de Frutos-Fernández–Nuccio), the spectral norm
  (`Mathlib/Analysis/Normed/Unbundled/SpectralNorm.lean`) and **Krasner's lemma**
  (`Mathlib/Analysis/Normed/Field/Krasner.lean`).
- **Dedekind-level ramification:** `Mathlib/NumberTheory/RamificationInertia/` —
  `Ideal.ramificationIdx`, `Ideal.inertiaDeg`, `sum_ramification_inertia`
  (`∑ e_P f_P = [L:K]`, `Basic.lean`), transitivity of the Galois action on `primesOver`
  and the well-defined `ramificationIdxIn`/`inertiaDegIn` (`Galois.lean`), decomposition and
  inertia **fields** as `IsDecompositionField`/`IsInertiaField` classes (`HilbertTheory.lean`),
  compatibility with valuations (`Valuation.lean`). `Mathlib/RingTheory/Invariant/Basic.lean`
  has Hilbert's residue-action machinery at ring level: `Ideal.inertia G P` (kernel of the
  action on `S/P`, defined in `RingTheory/Ideal/Defs.lean`) and the isomorphism
  `stabilizer G Q ⧸ inertia G Q ≃* Gal(residue extension)`.
- **Decomposition/inertia for valuation subrings:**
  `Mathlib/RingTheory/Valuation/RamificationGroup.lean` — `ValuationSubring.decompositionSubgroup`
  (stabilizer), `inertiaSubgroup` (kernel of the residue action), and nothing else; the file's
  own TODO asks for higher ramification groups.
- **Unramifiedness, algebraic:** `Mathlib/RingTheory/Unramified/` (`Algebra.FormallyUnramified`,
  `Unramified/Field.lean`, `Locus.lean` with `Algebra.IsUnramifiedAt`), `Mathlib/RingTheory/Etale/`.
  These are the formal/étale notions; the arithmetic notion for local fields (`e = 1` plus
  residue separability) is built in Layer 2 and *related* to them, not duplicated.
- **Galois theory of infinite extensions:** `Mathlib/FieldTheory/KrullTopology.lean`,
  `Mathlib/FieldTheory/Galois/Profinite.lean` (`CompactSpace Gal(K/k)`, `profiniteGalGrp`),
  `Mathlib/FieldTheory/AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup`,
  `absoluteGaloisGroupAbelianization` — the topological abelianization),
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` (the `IsGaloisGroup` class the
  Hilbert-theory files use), `Mathlib/Topology/Algebra/Category/ProfiniteGrp/` (limits,
  `profiniteCompletion` — the home of `Ẑ`).
- **Discrete group cohomology:** `Mathlib/RepresentationTheory/Homological/GroupCohomology/` —
  `Basic/LowDegree` (explicit `H0/H1/H2`, cocycles, `H1IsoOfIsTrivial`), `Hilbert90.lean`
  (`groupCohomology.H1ofAutOnUnitsUnique`: `H¹(Gal(L/K), Lˣ) = 0` for finite Galois `L/K`, plus
  Noether's cocycle version), `LongExactSequence.lean`, `Shapiro.lean`, `Functoriality.lean`,
  and `FiniteCyclic.lean` (periodicity `Hⁱ` of a finite cyclic group via the norm/`ρ(g) − 1`
  bicomplex — exactly the Herbrand-quotient engine). **master:**
  `RepresentationTheory/Homological/TateCohomology/Basic.lean` (Tate cohomology, upstreamed
  from the CFT project as PR #38553, merged 2026-06-09) and
  `RepresentationTheory/Homological/ContCohomology/` (`Basic/Functoriality/LowDegree`,
  continuous cochain cohomology; R. Hill, A. Yang, E. Xie; redefined in PR #41144, merged
  2026-07-02) landed after the pin. ⚠ The continuous theory's categorical carrier (`TopRep`)
  is under open design debate on Zulip as of 2026-07 (threads "Continuous cohomology" and
  "Understanding ContCohomology and TopRep": whether objects should require joint continuity
  of `G × V → V`, with Brasca proposing the strong condition and Hill defending the weak one
  for resolution-stability) — a risk tracked by the
  [ProfiniteCohomology](../ProfiniteCohomology/README.md) sibling, which this roadmap consumes
  through; the discrete-module/open-stabilizer case used here is stable under every proposal
  on the table. No cup products anywhere at the pin (FLT stages them for the continuous
  theory; the sibling owns them for this program).
- **Cyclotomic and Teichmüller:** `Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean`
  (`cyclotomicCharacter`, values in `ℤ_[p]ˣ`), `Mathlib/RingTheory/Teichmuller.lean`
  (`Perfection.teichmuller₀ : Perfection (R ⧸ I) p →*₀ R` for `I`-adically complete `R` —
  the engine for Layer 1's multiplicative section), `Mathlib/FieldTheory/Finite/`
  (finite-field Frobenius, `GaloisField`), `Mathlib/RingTheory/Henselian.lean`
  (`HenselianLocalRing`), `Mathlib/RingTheory/Perfection.lean`.
- **Eisenstein polynomials:** `Mathlib/RingTheory/Polynomial/Eisenstein/` (`IsEisensteinAt`,
  irreducibility, `IsIntegrallyClosed` consequences) — the algebraic half of Layer 3's
  totally-ramified correspondence.

### What is in motion elsewhere (checked 2026-07-30; coordinate, cite, do not fork)

- **kbuzzard/ClassFieldTheory** (`main` = `4100479`, 2026-07-26; active maintainer Yunzhou
  "Edison" Xie). Sorry-free and directly relevant: the `FiniteClassFormation` class with the
  abstract Tate–Nakayama `reciprocityIso` (`Cohomology/SplittingModule.lean`); the
  Herbrand-quotient calculus (`Cohomology/FiniteCyclic/HerbrandQuotient/`); `localInv`
  (`Cohomology/LocalInv.lean`); the valuation short exact sequence
  `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0` (`IsNonarchimedeanLocalField/ValuationExactSequence.lean`); the
  canonical `UnramifiedExtension K n` with its universal property and `maximalUnramified`
  (`IsNonarchimedeanLocalField/Unramified.lean`); the Teichmüller character
  (`LocalCFT/Teichmuller.lean`); `IsNonarchimedeanLocalField ℚ_[p]` (`Qp.lean`). Open there
  as of today, each a single explicit `sorry` or not started: positive-degree vanishing of
  `Hⁱ(Gal(L/K), 𝒪[L]ˣ)` for unramified `L/K` (`UnramifiedCohomology.lean`), the local-unit
  Herbrand quotient `h(𝒪[L]ˣ) = 1` (`HerbrandQuotient.lean`, "hard work"), the fundamental-class
  construction, and the Artin map (no files yet). This updates the gq2 planning document's
  §7.2 gap list: all four gaps are still gaps, and the abstract machinery above is new since
  that survey. Owner override to that document's §7.1/§21: this roadmap develops local CFT **in
  Tau Ceti**, not as contributions into ClassFieldTheory; the alignment obligations
  (§Provenance) remain.
- **Akwardbro/RamificationGroup** (Junjie Bai, Jiedong Jiang, Prowler99, Yicheng Tao; last
  commit 2026-03-01, stalled; builds on the dormant mariainesdff stack, not on
  `IsNonarchimedeanLocalField`): lower-numbering ramification groups, `AlgEquiv.lowerIndex`,
  Herbrand `φ`/`ψ`, upper numbering, aimed at Kronecker–Weber; ~27 of 41 files still carry
  sorries; no Mathlib PRs have come out of it. Layer 3 is an independent development in the
  pin's vocabulary; cite this repo and Serre LF IV, and coordinate with the authors before any
  code reuse.
- **mariainesdff/LocalClassFieldTheory** (de Frutos-Fernández–Nuccio, arXiv:2310.01998; dormant
  since 2025-07-02): complete-DVR local fields in both characteristics, unique valuation
  extension to finite extensions (`DiscreteValuationRing/Extensions.lean` — **not** yet in
  Mathlib), empty `ClassFormation.lean`, no Lubin–Tate. Their spectral-norm and
  valuation-algebra layers *did* land in Mathlib (see the consume list) and are consumed here.
- **Mathlib open PRs shaping the substrate** (2026-07): the `ValuativeRel` wave — #26886/#26885/
  #26827 (pechersky: `ValuativeRel ℚ_[p]` follow-ups, `ValuativeTopology 𝒪[K]`, normed-field
  helpers), #40309/#36769/#40315 (jjdishere: `Normed → IsValuativeTopology`, instances on
  completions), #30135 (erdOne: `ValuativeRel` on subrings), #27181/#27180 (ADedecker:
  `ValueGroupWithZero` refactor), #38009 (CBirkbeck: valuation spectrum, the PR #80 substrate);
  the `RamificationInertia` refactor wave — #41591/#35808/#36843/#35991/#36733/#37031 (xroblot:
  ring-level decomposition/inertia predicates, splitting in the inertia ring, compositum
  results), #40955/#40387/#40952 (tb65536: Galois groups generated by inertia, inertia of
  quotient groups); and WenrongZou's `FormalGroup` series #38213/#36167/#41710 (formal group
  homomorphisms — the seed of any future Lubin–Tate development; this roadmap's reciprocity
  route deliberately does not depend on it, see Layer 6, matching Buzzard–Hill's 2025-04
  decision to "define the Artin map via the group cohomology approach" and not via Lubin–Tate).
  No open Mathlib PR on higher ramification groups, Herbrand quotients, class formations, or
  reciprocity exists today.
- **The `erd1/LCFT` interface** (erdOne's mathlib4 branch, file
  `Mathlib/NumberTheory/ClassFieldTheory/Local/Basic.lean`; per Andrew Yang's FLT update of
  2026-07-27, this is the exact statement his four-axiom modularity-lifting artifact assumes
  as its local-CFT axiom — he "tried (and failed) to get it into mathlib last year"). Shape:
  `SatisfiesLocalExistenceTheorem K` (open finite-index subgroups of `Kˣ` are exactly norm
  subgroups) plus `LocalArtinMapData K` (compatible isomorphisms
  `Kˣ ⧸ normSubgroup K L ≃* Gal(L/K)` for finite abelian `L/K`, **arithmetic-Frobenius
  normalization** at uniformizers in unramified extensions via `IsArithFrobAt`, tower
  compatibility), bundled as `SatisfiesLocalClassFieldTheory K`. Layer 7's finite-level
  packaging is aligned with this shape (same normalization, same norm-subgroup lattice), so
  that a Tau Ceti proof discharges the FLT axiom by direct translation.
- **Zulip decisions in force** (see §Provenance for the threads): `ValuativeRel` is slated to
  replace `Valued` (deprecation project opened 2026-03-23 by Jiedong Jiang; "there is an
  ongoing refactor to remove `Valued` from Mathlib in favor of `ValuativeRel`", de
  Frutos-Fernández, 2026-04-20) — ⚠ nothing in this roadmap may be stated against `Valued`;
  the unramified-extension API direction (thread of 2025-10-20: unramifiedness for valued
  fields = bijective on value groups + separable residue extension) fixes Layer 2's predicate
  spelling.

## What is missing (build here)

Everything specific to the arithmetic of local fields. The normalized `ℤ`-valued valuation and
`‖·‖_K`. The unit filtration `U(K,i)` with its graded pieces `𝒪[K]ˣ/U(K,1) ≅ 𝓀[K]ˣ` and
`U(K,i)/U(K,i+1) ≅ 𝓀[K]⁺`, the Teichmüller section `𝓀[K]ˣ →* 𝒪[K]ˣ`, the structure
`Kˣ ≅ πᶻ × μ_{q−1} × U(K,1)` with `U(K,1)` pro-`p`, and the finiteness of `Kˣ/(Kˣ)ⁿ`. The
theory of finite extensions at local-field level: `e` and `f` defined intrinsically,
`e · f = [L:K]`, the local-field instance on `L`. Unramified extensions with the residue
correspondence and Frobenius, existence and uniqueness per degree, the maximal unramified
extension with `Gal(K^{ur}/K) ≅ Ẑ`, and norm surjectivity on units. Totally ramified =
Eisenstein; tame versus wild; the full lower-numbering filtration `G_i`, its subgroup
compatibility, the embeddings `G_0/G_1 ↪ 𝓀ˣ` and `G_i/G_{i+1} ↪ 𝓀⁺`; Herbrand `φ/ψ`, upper
numbering, Herbrand's quotient-compatibility theorem, Hasse–Arf. The tame quotient
`1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1` with Frobenius splitting and `στσ⁻¹ = τ^q`. On the
cohomological side (consuming the sibling): Kummer theory `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)`, the
Herbrand quotient computations `h(Lˣ) = [L:K]` and `h(𝒪[L]ˣ) = 1`, cohomological triviality of
unramified units, `H²(unramified) ≅ (1/n)ℤ/ℤ`, the invariant map `inv_K : Br(K) ≅ ℚ/ℤ`,
fundamental classes, the class-formation package, Tate–Nakayama at the needed degrees,
finite-level reciprocity with tower functoriality, the limit Artin map with its normalizations,
norm groups and the existence theorem, local Tate duality with all finiteness statements, the
Euler characteristic, and the `d(G_K) ≤ [K:ℚ_p] + 2` generation theorem. None of this exists
upstream as stated.

---

## The build, in layers

The ordering below is the dependency order. Layers 0–4 are cohomology-free and can start now;
Layers 5–9 consume the [ProfiniteCohomology](../ProfiniteCohomology/README.md) sibling as
flagged. As each layer makes the next layer's types expressible, its milestones are added to
`Suggested.lean` with `sorry`.

### Layer 0: the local-field package

- **`ℚ_p` is a local field.** Prove `IsValuativeTopology ℚ_[p]` (the valuation topology is the
  norm topology) and derive `IsNonarchimedeanLocalField ℚ_[p]`. ⚠ Instance hygiene: `ℚ_[p]`
  carries a metric `UniformSpace`; the compatibility with `IsTopologicalAddGroup.rightUniformSpace`
  must be a lemma, not an accident, or the `CompleteSpace` instances will not fire. The same
  statement is sorry-free in kbuzzard/ClassFieldTheory (`Qp.lean`); coordinate (§Provenance).
- **The normalized valuation.** `v_K : Kˣ →* ℤ` (or `K → ℤᵐ⁰` at zero) via
  `valueGroupWithZeroIsoInt` and `WithZero.log`, with `v_K(π) = 1` for any irreducible
  `π : 𝒪[K]`, surjectivity, `v_K = 0` exactly on `𝒪[K]ˣ`; the absolute value
  `‖x‖_K = q^{−v_K(x)}`, `q = Nat.card 𝓀[K]`, and its agreement with the `Padic` norm on
  `ℚ_[p]`. ⚠ The multiplicative/additive sign: Mathlib's canonical valuation has `v(π) = exp(−1)`
  (so integers are `v ≤ 1`); every statement mixing the two carries the `−log` translation
  explicitly. Also basic openness/compactness API: `𝒪[K]` open compact, `𝓂[K]^i` a
  neighborhood basis of `0`, `Kˣ` locally compact with `𝒪[K]ˣ` compact open.
- **Finite extensions are local fields.** For `L/K` finite with `[ValuativeExtension K L]`:
  `IsNonarchimedeanLocalField L`, uniqueness of the compatible valuation class on `L`
  (consume the spectral-norm/`Extension.lean` layer; ⚠ existence of the `ValuativeRel L`
  instance itself — i.e. putting a canonical valuation on an abstract finite extension — is
  part of this milestone, since downstream layers quantify over intermediate fields of
  `AlgebraicClosure K`), completeness, and the bridge instances `Algebra 𝒪[K] 𝒪[L]`,
  `𝒪[L]` finite free over `𝒪[K]`, `Algebra 𝓀[K] 𝓀[L]`.
- **`e`, `f`, and `e · f = n`.** Define `e L/K = v_L(algebraMap K L π_K)` and
  `f L/K = Module.finrank 𝓀[K] 𝓀[L]`; prove `e · f = Module.finrank K L`, multiplicativity in
  towers, and the reconciliation lemmas with the Dedekind-level `Ideal.ramificationIdx`/
  `Ideal.inertiaDeg` of the pin (at a local field `primesOver 𝓂[K] 𝒪[L] = {𝓂[L]}` is a
  singleton — prove that bridging lemma once; ⚠ do not re-derive the Dedekind theory, and do
  not force every consumer through `Ideal.ramificationIdx`'s `sSup`).

### Layer 1: units, the filtration, and the multiplicative group

- **The unit filtration.** `U(K, i) : Subgroup Kˣ` per the pinned convention; each `U(K,i)`
  open compact, `⋂ U(K,i) = 1`, and the filtration is a neighborhood basis of `1`.
- **Graded pieces.** `𝒪[K]ˣ/U(K,1) ≃* 𝓀[K]ˣ` (reduction) and, for `i ≥ 1`,
  `U(K,i)/U(K,i+1) ≃* 𝓀[K]⁺` via `1 + x ↦ x mod 𝓂^{i+1}` (Serre LF IV §2 Prop. 6;
  the counts `q − 1` and `q` follow). ⚠ The depth-0 piece is multiplicative, the deep pieces
  additive; keep the two isomorphisms separate, they do not assemble into one statement.
- **Teichmüller.** The multiplicative section `ω : 𝓀[K]ˣ →* 𝒪[K]ˣ` of the reduction, its
  uniqueness among sections with `(q−1)`-torsion image, and `μ_{q−1}(K) ≅ 𝓀[K]ˣ`. Build it
  from `Perfection.teichmuller₀` (a finite field is perfect and `𝒪[K]` is `𝓂[K]`-adically
  complete) or by Hensel on `X^{q−1} − 1`; pick the Hensel route if the `Perfection`-bridge
  (`Perfection 𝓀[K] p ≃ 𝓀[K]` for perfect `𝓀[K]`) costs more than it saves, and record the
  choice.
- **Structure of `Kˣ`.** The (choice-of-`π`-dependent) topological isomorphism
  `Kˣ ≃ ℤ × 𝒪[K]ˣ` and `𝒪[K]ˣ ≃ μ_{q−1} × U(K,1)`; `U(K,1)` is pro-`p`
  (inverse limit of the `p`-groups `U(K,1)/U(K,i)`; the pro-`p` *vocabulary* is the
  [ProPGroups](../ProPGroups/README.md) sibling's, consumed here); torsion of `Kˣ` is
  `μ(K)` finite. In mixed characteristic additionally `U(K,i) ≃ ℤ_p^{[K:ℚ_p]}` (additively,
  via `exp`/`log`) for `i > e/(p−1)` — state the precise threshold, this is the deep-unit
  isomorphism the finite-generation layer needs (NSW's (7.4.4) input).
- **Finiteness of `Kˣ/(Kˣ)ⁿ`.** `Nat.card (Kˣ ⧸ (powMonoidHom n).range) =
  n · #μ_n(K) · ‖n‖_K⁻¹` (the standard index formula, e.g. `n/‖n‖` times `#μ_n(K)`; state it
  as the exact cardinality, not just finiteness). Squares of `ℚ_2` as the worked instance
  (order 8). `U(K, 2e+1) ⊆ (Kˣ)²` in residue characteristic 2 (the deep-square bound; gq2's
  `sq_of_near_one`).

### Layer 2: unramified extensions and Frobenius

- **The arithmetic predicate.** `IsUnramified K L` for finite extensions of local fields,
  spelled as the 2025-10-20 Zulip consensus for valued fields: the value-group map is
  bijective (equivalently here, `e L/K = 1`) and the residue extension `𝓀[L]/𝓀[K]` is
  separable (automatic for finite residue fields; carry it anyway so the statement matches
  the general definition and survives generalization). Relate it once to the pin's
  `Algebra.IsUnramifiedAt`/`FormallyUnramified` over `𝒪[K]` (a comparison theorem, so the
  étale library becomes usable, not a redefinition).
- **Residue correspondence.** For unramified `L/K` Galois: `Gal(L/K) ≃* Gal(𝓀[L]/𝓀[K])`
  (through the pin's `RingTheory/Invariant` stabilizer machinery: inertia is trivial). The
  **Frobenius element** `Frob L/K ∈ Gal(L/K)`: the preimage of `x ↦ x^q`, a canonical
  generator; `Gal(L/K)` cyclic of order `f`.
- **Existence and uniqueness.** For each `f ≥ 1` a canonical unramified extension of degree
  `f` (adjoin `μ_{q^f−1}`, i.e. the splitting field of `X^{q^f} − X`); uniqueness up to a
  *unique* unramified `K`-isomorphism commuting with Frobenius; the compositum of unramified
  is unramified; inside a fixed `AlgebraicClosure K`, the lattice of unramified subextensions
  is `ℕ` ordered by divisibility. (kbuzzard/ClassFieldTheory's `Unramified.lean` proves this
  shape sorry-free; align statement forms.)
- **The maximal unramified extension.** `K^{ur} ⊆ AlgebraicClosure K` as the union/compositum;
  `Gal(K^{ur}/K) ≅ Ẑ` carrying Frobenius to the canonical topological generator `1`;
  `Ẑ ≅ lim ℤ/n` built on `ProfiniteGrp`'s completion API. The unramified coordinate of any
  `G_K`-quotient statement is expressed through this isomorphism (⚠ target `Ẑ`, never `ℤ` —
  see the convention table).
- **Norms.** For `L/K` unramified: `N_{L/K}(𝒪[L]ˣ) = 𝒪[K]ˣ` (norm surjectivity on units:
  Serre LF V §2; by the filtration, surjectivity on each graded piece plus completeness) and
  `N_{L/K}(Lˣ) = π^{fℤ} × 𝒪[K]ˣ`. This is the concrete half of "units are universal norms in
  the unramified tower" that both the fundamental-class layer and the gq2 B10 orientation
  clauses consume.

### Layer 3: ramification: totally ramified, tame/wild, and the filtration

- **Totally ramified = Eisenstein.** `e = [L:K]` iff `L = K(π_L)` with `π_L` a root of an
  Eisenstein polynomial over `𝒪[K]`; conversely Eisenstein polynomials are irreducible and
  generate totally ramified extensions with the root a uniformizer (consume
  `RingTheory/Polynomial/Eisenstein/`). Unramified/totally-ramified factorization of any
  finite `L/K`: `L/L_0/K` with `L_0/K` the maximal unramified subextension, `L/L_0` totally
  ramified of degree `e`.
- **Tame and wild.** `IsTamelyRamified` (`p ∤ e`) and totally wildly ramified (`e` a power of
  `p`); a tame totally ramified extension of degree `e` is `K(π^{1/e})` for some uniformizer
  `π` (Kummer-style, needs `μ_e ⊆ K^{ur}`-descent — state it for `L/K` with `𝓀` large enough
  first, then descend); tame subextension tower `L/L_1/L_0/K`. ⚠ In residue characteristic 2
  every quadratic totally ramified extension is *wild*; keep the dyadic examples in the test
  suite so no `p ∤ e` hypothesis sneaks into a "tame" statement that is used at `p = 2`.
- **The lower-numbering filtration.** For `L/K` finite Galois with group `G`:
  `G_i = {σ | ∀ x : 𝒪[L], v_L(σ x − x) ≥ i + 1}` (Serre LF IV §1, via the pin's
  `𝒪[L]`-action; equivalently `σ` acts trivially on `𝒪[L]/𝓂[L]^{i+1}`), a decreasing chain of
  normal subgroups of `G` with `G_{−1} = G`, `G_0` = inertia (reconcile with
  `ValuationSubring.inertiaSubgroup` and `Ideal.inertia` — one comparison lemma each),
  `G_i = 1` for large `i`. **Compatibility with subgroups**: `H_i = H ∩ G_i` for
  `H = Gal(L/K')`. ⚠ Lower numbering is **not** compatible with quotients — record this as a
  stated non-theorem with the standard counterexample so nobody "fixes" it.
- **The quotient embeddings.** `G_0/G_1 ↪ 𝓀[L]ˣ` (hence cyclic, order prime to `p`) and
  `G_i/G_{i+1} ↪ 𝓀[L]⁺` for `i ≥ 1` (hence elementary abelian `p`); consequently `G_1` is the
  (unique, normal) `p`-Sylow of `G_0` — **wild inertia at finite level** — and `G_0` is
  `p`-solvable with cyclic tame quotient `G_0/G_1`. The action formula: for `σ ∈ G_0`,
  `τ ∈ G_i/G_{i+1}`, `στσ⁻¹ = θ_0(σ)^i · τ` (the `𝓀ˣ`-twist of the deeper pieces by the tame
  character `θ_0 : G_0/G_1 ↪ 𝓀[L]ˣ`) — this is the finite-level germ of the `(1)`-twist in
  Layer 4's tame sequence.
- **Herbrand functions and upper numbering.** `φ_{L/K}(u) = ∫_0^u dt/[G_0 : G_t]` (piecewise
  linear, concave, explicit as a finite sum), `ψ = φ⁻¹`; upper numbering `G^u = G_{ψ(u)}`;
  **Herbrand's theorem**: `(G/H)^u = G^u H/H` (quotient compatibility; Serre LF IV §3),
  transitivity `φ_{L/K} = φ_{L'/K} ∘ φ_{L/L'}`. Upper numbering enters *here* — it is needed
  in Layer 7 for the reciprocity/filtration compatibility and the conductor, and its
  definition is pure Layer-3 material; do not defer it past this layer.
- **Hasse–Arf.** For `G` abelian the jumps of the upper-numbering filtration are integers
  (Serre LF V §7). Sequenced last in this layer (it needs the norm computations on the unit
  filtration from Serre LF V §§2–6, which are also the input to Layer 5's Herbrand-quotient
  computations — build them once, here, as "the norm map on the filtration": for `L/K` cyclic
  of prime degree, the explicit behavior of `N_{L/K}` on `U(L,i)` versus `U(K,j)`).
- **The different and discriminant** (supporting, for conductors and Layer 8's dualizing
  module): `𝔡_{L/K}` via the trace form on `𝒪[L]`, `v_L(𝔡) = ∑_{i≥0} (#G_i − 1)` for Galois
  `L/K` (Serre LF IV §1 Prop. 4), `𝔡 = 1` iff unramified; tame ⇒ `v_L(𝔡) = e − 1`.

### Layer 4: the tame quotient of the absolute Galois group

- **Infinite Galois bookkeeping.** `G_K = Gal(AlgebraicClosure K / K)` with the Krull topology
  (in char `p > 0` use the separable closure; state which closure each theorem uses); the
  inertia subgroup `I_K = Gal(K̄/K^{ur})` (closed, normal), the exact sequence
  `1 → I_K → G_K → Ẑ → 1` from Layer 2, and arithmetic Frobenius lifts.
- **Wild inertia.** `P_K = Gal(K̄/K^{t})` where `K^{t} = ⋃ K^{ur}(π^{1/m})` (`p ∤ m`) is the
  maximal tamely ramified extension; `P_K` is the inverse limit of the finite-level `G_1`'s, a
  closed normal pro-`p` subgroup of `G_K`, and it is the **unique maximal** one inside `I_K`
  (the pro-`p` Sylow of `I_K`; profinite Sylow theory is the
  [ProPGroups](../ProPGroups/README.md) sibling's — consume `Sylow`-existence/conjugacy for
  profinite groups from there, prove the *identification* with `Gal(K̄/K^t)` here).
- **The tame character and the twist.** `I_K/P_K ≅ lim_{p∤m} μ_m(K̄) = Ẑ^{(p')}(1)` via
  `σ ↦ (σ(π^{1/m})/π^{1/m})_m`, independence of choices, and `G_K`-equivariance: conjugation
  acts through the cyclotomic action on the right side. ⚠ `Ẑ^{(p')}(1)` is notation to be
  *defined* here (the prime-to-`p` Tate module of `μ`), not assumed; as a profinite group it
  is `∏_{ℓ ≠ p} ℤ_ℓ`, and the `(1)` is the statement of equivariance.
- **The Iwasawa presentation.** The tame quotient `G_K^{t} = G_K/P_K` sits in a split exact
  sequence `1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1`; a Frobenius lift `σ` and a topological
  generator `τ` of the kernel satisfy `σ τ σ⁻¹ = τ^q`, and `G_K^t` is the profinite group on
  `σ, τ` with that single relation (NSW (7.5.2)/(7.5.3), Iwasawa). "Presented profinite group"
  vocabulary: state via the universal property (continuous surjection from the free profinite
  group on two generators, kernel the closed normal closure of the relator) — coordinate the
  free-profinite-group dependency with [ProPGroups](../ProPGroups/README.md), which owns free
  pro-`p`/profinite constructions.
- **Orientation lemmas.** The two translation lemmas of the convention table: geometric-`σ`
  presentation (`σ ↦ σ⁻¹`) and the finite-level compatibility (restriction of the sequence to
  finite tame quotients recovers Layer 3's `G_0/G_1`-twist formula). The reciprocity-facing
  orientation clauses ("units land in inertia, uniformizer at Frobenius coordinate") are
  **Layer 7** consequences, not axioms here; this layer only supplies the group-theoretic
  frame they are stated in. This layer's summit is the intrinsic form of gq2's **B10**.

### Layer 5: cohomology of local fields I — the invariant map and the class formation

Everything from here on consumes the [ProfiniteCohomology](../ProfiniteCohomology/README.md)
sibling for continuous cohomology of `G_K` (low-degree explicit theory, res/inf/cores, cup
products, LES, Shapiro, and the colimit description `H^i(G_K, M) = colim H^i(Gal(L/K), M^{G_L})`
over finite Galois `L/K`). Finite-level statements use Mathlib's discrete `groupCohomology`
(and, after the next bump, `TateCohomology`) directly — that part is pin-expressible and can
proceed **in parallel with** the sibling.

- **Hilbert 90, both levels.** Finite level is Mathlib's (`H1ofAutOnUnitsUnique`); restate as
  `H¹(Gal(L/K), Lˣ) = 0` in the chosen cohomology API, and derive the continuous
  `H¹(G_K, K̄^{sep,×}) = 0` by colimit (sibling).
- **Kummer theory.** For `n` with `μ_n ⊆ K` (and in general with the `μ_n`-twist):
  `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)` via the Kummer cocycle `a ↦ (σ ↦ σ(a^{1/n})/a^{1/n})`, from the
  `n`-th-power sequence and Hilbert 90. With Layer 1's index formula this computes
  `#H¹(G_K, μ_n)`.
- **The Herbrand quotient.** `h(G, M) = #H²/#H¹` for finite cyclic `G` (definition on top of
  Mathlib's `FiniteCyclic` periodicity; after the bump, restate against `TateCohomology`):
  multiplicativity in short exact sequences, `h = 1` on finite modules, and the two
  computations `h(Gal(L/K), Lˣ) = [L:K]` and `h(Gal(L/K), 𝒪[L]ˣ) = 1` for cyclic `L/K` (the
  second via Layer 3's norm-on-filtration analysis plus a cohomologically trivial open
  submodule — the `lem:serre_approx` route in the ClassFieldTheory blueprint; both are *open
  sorries there today*, so this is live coordination territory, not duplication of finished
  work).
- **Unramified cohomology.** For `L/K` unramified (cyclic, `Frob`-generated):
  `Hⁱ(Gal(L/K), 𝒪[L]ˣ) = 0` for `i ≥ 1` (filtration + finite-field vanishing + completeness),
  hence `H²(Gal(L/K), Lˣ) ≅ H²(Gal(L/K), ℤ) ≅ ℤ/[L:K]` via the valuation sequence
  `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0`; the **unramified invariant map** normalized per the convention
  table, compatible with inflation up the unramified tower, giving
  `H²(Gal(K^{ur}/K), (K^{ur})ˣ) ≅ ℚ/ℤ`.
- **`Br(K)` is unramified.** Every class in `H²(G_K, K̄ˣ)` is inflated from the unramified
  tower: `H²(G_K, K̄ˣ) ≅ ℚ/ℤ` — the **invariant map** `inv_K`. Route: the counting argument
  `#H²(Gal(L/K), Lˣ) ≤ [L:K]` for all finite Galois `L/K` (from `h(Lˣ) = [L:K]` in the cyclic
  case, induction via inflation–restriction for the solvable/general case) together with the
  unramified lower bound. Functoriality: `inv_{K'} ∘ res = [K':K] · inv_K`, and
  `inv ∘ cores = inv`.
- **Fundamental classes and the class formation.** `u_{L/K} ∈ H²(Gal(L/K), Lˣ)` the class
  with `inv = 1/[L:K]`; the pair (`H¹ = 0`, `H²` cyclic of the right order with compatible
  invariants) packaged as **the class-formation structure** on `(G_K, K̄ˣ)`. Interface: at a
  single finite level adopt the shape of ClassFieldTheory's `FiniteClassFormation` (a
  distinguished `σ ∈ H²` plus `H¹`-vanishing and `H²`-generation over subgroups — settled,
  sorry-free design); the profinite-level formation (all layers at once, invariants valued in
  `ℚ/ℤ`, NSW II §1-style) is stated on top of the finite-level instances. Record explicitly
  which of the two shapes each later theorem consumes.

### Layer 6: Tate–Nakayama and finite-level reciprocity

- **Tate–Nakayama, pinned scope.** State the abstract theorem for a finite group `G` and a
  distinguished class `σ ∈ H²(G, M)` satisfying the class-formation hypotheses, in the form:
  cup product with `σ` induces isomorphisms `Ĥ^{r}(H, ℤ) ≅ Ĥ^{r+2}(H, M)` for all subgroups
  `H ≤ G` and all `r`. **Pinned decision**: formalize the full all-degrees statement (it is
  already sorry-free in ClassFieldTheory's `SplittingModule.lean` via dimension shifting —
  the "splitting module" route of Artin–Tate; independent development here follows the same
  route rather than the cyclic-case-only shortcut), but *consume* it only at `r = −2`:
  `G^{ab} = Ĥ^{−2}(G, ℤ) ≅ Ĥ⁰(G, M) = M^G/N_G M`. Rationale: the all-degrees form is what the
  duality layer and the sibling's Demushkin consumers want to cite, and the marginal cost over
  the two-degree version is the dimension-shifting API, which is generic.
- **Finite-level reciprocity.** For every finite Galois `L/K`:
  `Gal(L/K)^{ab} ≃ Kˣ/N_{L/K} Lˣ` (Tate–Nakayama at `u_{L/K}`), written as the **norm-residue
  isomorphism** `θ_{L/K} : Kˣ/N Lˣ ≅ Gal(L/K)^{ab}` in the direction and normalization of the
  convention table: for `L/K` unramified, `θ(π) = Frob` (this is the compatibility
  `inv(u) = 1/n` ↔ normalization statement — prove it as its own lemma, it is where a sign
  error would hide).
- **Functoriality.** In towers `M/L/K`: the projection `Kˣ/N_M Mˣ → Kˣ/N_L Lˣ` matches
  `Gal(M/K)^{ab} → Gal(L/K)^{ab}`; base change `K'/K`: inclusion `Kˣ ⊆ K'ˣ` matches transfer
  (Verlagerung) `Gal(·/K)^{ab} → Gal(·/K')^{ab}`, and norm `N_{K'/K}` matches the natural map
  on abelianizations; compatibility with `res`/`cores`/`inf` throughout. These are the
  compatibilities the limit in Layer 7 needs — state them all at finite level first.

### Layer 7: the Artin map, norm groups, and the existence theorem

- **The limit.** `Art_K : Kˣ →* G_K^{ab}` as the limit of `θ_{L/K}` over finite abelian `L/K`
  (Mathlib's `absoluteGaloisGroupAbelianization` is the target; the limit exists by Layer 6's
  tower compatibility): continuous, injective, **dense image**, an isomorphism onto its image
  from the profinite completion side `Art_K : (Kˣ)^∧ ≅ G_K^{ab}` (the completion is along
  finite-index open subgroups; ⚠ `Kˣ` itself is not compact and `Art_K` is not surjective —
  `Nat.card`-style statements about `G_K^{ab}` are traps).
- **Normalizations, as theorems.** `ν_K ∘ Art_K = v_K` (unramified coordinate, valued in `Ẑ`);
  `Art_K(𝒪[K]ˣ) =` the inertia subgroup of `G_K^{ab}`, an isomorphism `𝒪[K]ˣ ≅ I(G_K^{ab})`
  (units are universal norms in no nontrivial unramified direction — consume Layer 2's norm
  computation); the **cyclotomic orientation** `χ_cyc(Art_K(u)) = u⁻¹` for `u ∈ 𝒪[K]ˣ` in
  mixed characteristic (Dwork/Lubin–Tate normalization check; for `K = ℚ_p` this is Serre LF
  XIV §7's computation on `ℚ_p(μ_{p^∞})` — with the arithmetic-Frobenius convention the unit
  action is by `u⁻¹`, and this sign is exactly gq2's B5 clause (c), so prove it as a named
  theorem, not a remark). The geometric-normalization translation lemmas
  (`Art^{geo} = Art ∘ inv`, `ν^{geo} = −ν`) close the layer.
- **Ramification compatibility.** `Art_K(U(K, n))` is dense in the upper-numbering ramification
  subgroup `(G_K^{ab})^{(n)}` (Neukirch ANT V (6.2)-shape, finite-abelian-level statement:
  `θ_{L/K}(U(K,n) N Lˣ/N Lˣ) = Gal(L/K)^{(n)}`); requires Layer 3's Hasse–Arf. The
  **conductor** of a finite abelian `L/K` and `f(L/K) = 𝓂^n` iff `U(K,n) ⊆ N Lˣ ⊊ U(K,n−1)`-
  style characterizations.
- **Norm groups and the existence theorem.** `NormGroup L/K := (N_{L/K})(Lˣ)` for finite
  abelian `L/K`; the lattice anti-isomorphism between finite abelian extensions and their norm
  groups (`N` of the compositum is the intersection, containment reverses); **the existence
  theorem**: a subgroup of `Kˣ` is a norm group iff it is open of finite index. ⚠ This is
  genuinely independent of the reciprocity core and *later than it*: reciprocity gives the
  index/quotient identification for extensions that exist; existence manufactures extensions
  for subgroups (route: reduce to `(Kˣ)^n ·U(K,m)`-shaped subgroups by openness, realize those
  by Kummer towers over cyclotomic layers — or, classically, by Lubin–Tate; **pinned**: the
  Kummer/compactness route, so this roadmap has no formal-group dependency; if Mathlib's
  nascent `FormalGroup` grows a Lubin–Tate theory, a refactor note in §Provenance applies).
  Corollary package: `⋂` of all norm groups is trivial; `Kˣ/N Lˣ` finite for every finite
  (not necessarily abelian) `L/K` with `N Lˣ = N (L^{ab-part})ˣ` (norm limitation).
- **The FLT-facing bundle.** Package the finite-abelian-level isomorphisms, the
  arithmetic-Frobenius normalization, the tower compatibility, and the existence theorem in
  the shape of the `erd1/LCFT` interface (`LocalArtinMapData` + `SatisfiesLocalExistenceTheorem`
  — see §What is in motion), and prove the translation to it as a milestone: this is the
  statement a confirmed downstream consumer (FLT's modularity-lifting artifact) axiomatizes
  today.
- This layer's summit is the intrinsic form of gq2's **B5**, and (with Layer 4) the
  orientation clauses of **B10**.

### Layer 8: local Tate duality and the Euler characteristic

Sequence within the layer (gq2 §12.2's order, adopted): invariant map on finite coefficients →
duality → Euler characteristic.

- **`H²(G_K, μ_n) ≅ ℤ/n`.** From `inv_K` and the Kummer sequence on `K̄ˣ` (`Br(K)[n]`);
  finiteness and computation of `H^i(G_K, μ_n)` for `i = 0, 1, 2` (Layer 5 + Layer 1's index
  formula), and `H^i = 0` for `i ≥ 3` — record `cd(G_K) = 2` here, *stated* with the
  cohomological-dimension vocabulary of the [ProfiniteCohomology](../ProfiniteCohomology/README.md)
  sibling (the theorem is local; the `cd` machinery is theirs). ⚠ In char `p`: `cd_p` behaves
  differently; the duality theorems below are stated for `#M` prime to `char K` (vacuous in
  mixed characteristic).
- **Local Tate duality.** For finite discrete `G_K`-modules `M` with `#M` invertible in `K`,
  `n`-torsion, and dual `M' = Hom(M, μ_n)` (conjugation action): the cup pairing
  `H^i(G_K, M') × H^{2−i}(G_K, M) → H²(G_K, μ_n) ≅ ℤ/n` is a **perfect pairing of finite
  groups** for `i = 0, 1, 2` — with the finiteness of all six groups part of the statement
  (NSW (7.2.6), Milne ADT I.2.3; route: dévissage to `M = μ_n`-type modules over the layers
  where `G_L` acts trivially, via res/cores and Shapiro from the sibling). Cross-`n`
  compatibility of the pairings (`μ_n ⊆ μ_{nm}`) is a named milestone (see the convention
  table). The unramified complement: for `M` unramified with `p ∤ #M`, the annihilator of
  `H¹_{ur}(K, M')` is `H¹_{ur}(K, M)` (the input for global dualities and for Demushkin-type
  computations at the boundary of the tame range).
- **The local Euler characteristic.** For all finite discrete `M`:
  `#H⁰(G_K, M) · #H²(G_K, M) / #H¹(G_K, M) = ‖#M‖_K` (Tate; NSW (7.3.1)); in the mixed-
  characteristic normalization `‖#M‖_K = (#(M[p^∞]))^{−[K:ℚ_p]}`-shaped — state the exact
  `q`/`p`-power form and derive the `𝔽_p`-dimension corollary
  `dim H¹ = dim H⁰ + dim H² + [K:ℚ_p]·dim M` for `𝔽_p`-modules, which is the form every
  counting application (and gq2 §9.2) uses. Route: dévissage to `M = ℤ/p` and `μ_p` via the
  multiplicativity of `χ` in exact sequences; `χ = 1` for `#M` prime to `p` (via tame/
  unramified reduction).
- **The mod-2 Hilbert-symbol bridge (named meeting point).** At `n = 2` (and `char K ≠ 2`),
  under Kummer `Kˣ/(Kˣ)² ≅ H¹(G_K, μ_2)`, the duality pairing
  `H¹(G_K, μ_2) × H¹(G_K, μ_2) → H²(G_K, μ_2) ≅ ℤ/2` **is the classical Hilbert-symbol
  pairing** `(a, b)_K` — the pairing with the norm-form criterion
  `(a,b)_K = 1 ↔ b ∈ N(K(√a)ˣ) ↔ ∃ x y, b = x² − a·y²` — as the
  [QuadraticFormInvariants](../QuadraticFormInvariants/README.md) roadmap
  (in preparation) defines it. One named theorem (suggested name:
  `hilbertSymbol_eq_tateDuality_pairing`), stated here, consumed there; its nondegeneracy is
  then a corollary of duality rather than an independent computation (FV IV §5, O'Meara 63:13).
  This is the single statement at which the two roadmaps must agree, and it is the intrinsic
  form of gq2's **B11a**-adjacent pairing content; gq2's **B6**/**B7** acceptance shapes are
  the two milestones above.

### Layer 9: topological finite generation of `G_K`

For `K/ℚ_p` finite of degree `N`. Sequenced after Layers 7–8 (the route consumes reciprocity,
the unit structure, and `scd(G_K) = 2`).

- **`H¹`-dimension counts.** `dim_{𝔽_ℓ} H¹(G_K, 𝔽_ℓ)` for every prime `ℓ`: equals
  `N + 1 + dim H⁰(μ_p)` at `ℓ = p` and `≤ 2` at `ℓ ≠ p` (Kummer + Layer 1's index formula +
  duality). ⚠ The naive criterion "all `H¹(G, 𝔽_ℓ)` finite ⇒ `G` topologically finitely
  generated" is **false** for profinite groups (`∏_ℕ A₅` has `H¹(−, 𝔽_ℓ) = 0` for every `ℓ`
  — each factor is perfect — yet is not topologically finitely generated, since
  `d(A₅^m) → ∞`); the route below is why the theorem is true anyway, and this trap is why
  route (c) of the gq2 planning document §13.1 (bounded-degree extension finiteness + a
  generic criterion) was **rejected**: no such generic criterion exists at this generality.
- **The tame frame.** `G_K^{t}` is topologically 2-generated (Layer 4's presentation), and
  `P_K` is pro-`p` (Layer 4); by the **pro-`p` Frattini generation criterion** (consumed from
  [ProPGroups](../ProPGroups/README.md): a subset generates a pro-`p` group iff it generates
  its Frattini quotient; plus the relative form for a closed normal pro-`p` subgroup), finite
  generation of `G_K` reduces to finite generation of the `ℤ_p[[G_K^t]]`-coinvariant data of
  `P_K^{ab}(p)`.
- **The multiplicative-group module.** The reciprocity-side input (NSW VII §4): the
  `ℤ_p`-completed `A(L) = lim Lˣ/(Lˣ)^{p^m} ≅ G_L^{ab}(p)` (Layer 7), the `ℚ_p[G]`-module
  structure `A(L) ⊗ ℚ ≅ ℚ_p[G]^N ⊕ ℚ_p` for `L/K` Galois with group `G` (deep-unit `log`
  isomorphism + normal basis — Layer 1's threshold statement), and cohomological triviality
  of `U(L,1)/p`-type modules in tame extensions (NSW (7.4.3)).
- **The generator bound.** `G_K` is topologically generated by `N + 2` elements
  (NSW (7.4.1)); route: the relation-module bookkeeping of NSW VII §4 (free presentation of
  the tame quotient, `scd = 2` comparison of 2-cocycles, lift along the Frattini reduction).
  State the sharp `N + 2`; the weaker "topologically finitely generated" corollary is the
  gq2 **B1** acceptance shape (at `K = ℚ_2`: generated by 3 elements). A complement worth
  stating as its own milestone (it is where `μ_p` matters): if `μ_p ⊄ K` then `N + 1`
  generators suffice (NSW (7.4.2)(i)).

### Long horizon (direction, not this roadmap's deliverables)

Lubin–Tate formal groups and totally ramified maximal abelian towers (once Mathlib's
`FormalGroup` matures), explicit local reciprocity (Dwork/Hazewinkel formulas), higher-unit
duality refinements, the full `Gal(K^{ab}/K) ≅ (Kˣ)^∧` as a topological-group statement with
its two topologies compared, and Jannsen–Wingberg's full presentation of `G_K`
(`p` odd) / Diekert–Zelvenskii's dyadic case. These set direction; Layers 0–9 are the roadmap.

## Worked examples (acceptance criteria)

Discharge alongside the layers; each catches a specific class of error (vacuous instance,
sign flip, wrong normalization, dropped dyadic case).

- **`ℚ_p` and `𝔽_q((t))` are local fields; `ℚ` and `ℂ` are not** (Layer 0). Non-vacuity plus
  the negative instances (`ℚ` with any `p`-adic valuation class is incomplete, hence not
  locally compact; for `ℂ` no valuation class and compatible topology qualify at all — a
  nonarchimedean local field is never algebraically closed).
- **`v_2`, `‖·‖`, `q` on `ℚ_2`** (Layer 0): `v(2) = 1`, `‖2‖ = 1/2`, `q = 2`; on
  `K = ℚ_2(√2)`: `e = 2`, `f = 1`, `v_K(2) = 2`.
- **`ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (Layer 1), with basis the classes of `−1, 2, 5`
  (`5 ≡ −3 mod (ℚ_2ˣ)²`); `ℚ_pˣ/(ℚ_pˣ)²` has order 4 for odd `p`. The deep-square bound:
  `1 + 8ℤ_2 ⊆ (ℤ_2ˣ)²` sharply (`U(2e+1) = U(3)` at `K = ℚ_2`).
- **Teichmüller on `ℚ_2` is `±1`** (Layer 1): `μ_{q−1}(ℚ_2) = {1}` — degenerate on purpose;
  the honest torsion is `μ(ℚ_2) = {±1}` living in `U(1) \ U(2)`. On `ℚ_5`: `μ_4 ⊆ ℤ_5ˣ`.
- **The unramified quadratic extension of `ℚ_2` is `ℚ_2(√5) = ℚ_2(μ_3)`** (Layer 2): `f = 2`,
  Frobenius squares on `μ_3`; **every unit of `ℤ_2ˣ` is a norm**: `∀ u : ℤ_2ˣ, ∃ x y,
  u = x² − 5y²`; and `N(ℚ_2(√5)ˣ) = ⟨4⟩ × ℤ_2ˣ` (index 2, missing `2` itself).
- **Ramification filtration of `ℚ_2(μ_8)/ℚ_2`** (Layer 3): group `(ℤ/8)ˣ ≅ (ℤ/2)²`,
  `G_0 = G_1 = G`, `G_2 = G_3 = ⟨σ_5⟩` (the `ζ ↦ ζ⁵` direction), `G_4 = 1` — computed from
  Serre LF IV §4's cyclotomic recipe via `i_G(σ_a) = v_L(ζ^a − ζ)`; the Herbrand transform
  puts the upper-numbering jumps at `1` and `2` (`φ(1) = 1`, `φ(3) = 2`), integers as
  Hasse–Arf demands. A tame contrast: `ℚ_3(3^{1/2})/ℚ_3` has `G_0 = ℤ/2`, `G_1 = 1`.
- **The tame relation over `ℚ_3`** (Layer 4): in `G_{ℚ_3}^{t}`, `στσ⁻¹ = τ³` for the
  arithmetic Frobenius lift; at finite level in `Gal(ℚ_3(μ_8, 3^{1/8})/ℚ_3)` the conjugation
  formula is checkable by hand (the σ-action on `μ_8`-indexed roots of `3`).
- **Hilbert symbols on `ℚ_2`** (Layers 7–8): `(−1,−1)_2 = −1` (equivalently: `−1` is not a
  sum of two squares in `ℚ_2`), `(2,5)_2 = −1`, `(2,−1)_2 = +1`, `(5,5)_2 = +1` — the table
  that seeds gq2's initial form `α² + βγ + γβ`.
- **`Art_{ℚ_2}` on `−1, 2, 5`** (Layer 7): `ν(Art(2)) = 1, ν(Art(−1)) = ν(Art(5)) = 0`;
  `χ_cyc(Art(−1)) = −1`, `χ_cyc(Art(5)) = 5⁻¹`, `χ_cyc(Art(2)) = 1`. (In gq2's geometric
  `ν_ur` these read `−1, 0, 0` — the translation lemma in action, matching its eq. (13) row
  `ν_ur(ā, s̄, ȳ) = (−2, 1, 0)` after its `ā = rec(−4), s̄ = rec(2)⁻¹, ȳ = rec(−3)`
  dictionary.)
- **Euler characteristic of `μ_2` over `ℚ_2`** (Layer 8): `#H⁰ = 2`, `#H² = 2`, so the formula
  forces `#H¹(G_{ℚ_2}, μ_2) = 8` — consistent with Kummer + the order-8 square-class group.
  This single example crosses Layers 1, 5, and 8 and is the designated smoke test for the
  normalization `‖#M‖_K`.
- **Duality at `n = 2` over `ℚ_2`** (Layer 8): the pairing matrix of the Hilbert symbol on the
  basis `{−1, 2, 5}` is nondegenerate mod 2 — the bridge statement instantiated.

## Ordering and parallelism

Layers 0–2 are sequential and first. Layer 3 (ramification filtration) and Layer 4 (tame
quotient) depend on Layers 0–2 but not on each other's summits (Layer 4 needs only the
tame/wild vocabulary of Layer 3's start, not Herbrand/Hasse–Arf). Layer 5's finite-level lane
(Herbrand quotient, unramified cohomology, fundamental classes) needs Layers 2–3 and Mathlib's
discrete group cohomology only — it can run **before or in parallel with** the
[ProfiniteCohomology](../ProfiniteCohomology/README.md) sibling; Layer 5's continuous
assembly, and all of Layers 6–9's absolute-group statements, block on the sibling. Layer 6
follows Layer 5; Layer 7 follows Layer 6 (its ramification-compatibility milestone also needs
Layer 3's Hasse–Arf); Layer 8 needs Layers 5 and 7 (invariant map, Kummer, and the unit index
formula) and supplies the [ProPGroups](../ProPGroups/README.md) roadmap's Demushkin
prerequisites; Layer 9 is last, consuming Layers 4, 7, 8 and the sibling's Frattini criterion.
The worked examples are spread across all layers and none is deferrable to "the end".

## References

- J.-P. Serre, *Local Fields*, GTM 67 (1979) — the primary source: Ch. I §§1–8 (DVRs,
  Frobenius substitution), Ch. III §5 (unramified), Ch. IV (ramification groups, lower/upper
  numbering, Herbrand `φ/ψ`), Ch. V (the norm on the filtration; §7 Hasse–Arf), Ch. VIII
  (Tate cohomology of finite groups, Herbrand quotient), Ch. IX (Tate–Nakayama), Ch. X–XI
  (Galois cohomology, class formations, existence theorem), Ch. XII–XIII (Brauer group of a
  local field, local CFT), Ch. XIV (local symbols, `(a,b)`, existence theorem, `ℚ_pᵃᵇ`),
  Ch. XV (ramification/norm-group numerics).
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed. (NSW) —
  Ch. VII: (7.1.x) class formation, (7.2.6) local Tate duality, (7.3.1) Euler characteristic,
  §7.4 (Galois module structure of `Kˣ`; (7.4.1) the `N + 2` generator theorem — the pinned
  Layer-9 route), (7.5.2)/(7.5.3) the tame quotient (Iwasawa), (7.5.11) Demushkin (the
  ProPGroups consumer).
- J. Neukirch, *Algebraic Number Theory* — Ch. II (valuations, completions, unit structure,
  unramified/tame), Ch. IV (abstract class field theory, the Neukirch Frobenius-lift method),
  Ch. V (local CFT; V (1.2) units-are-norms; V §6 the reciprocity/upper-numbering
  compatibility — Layer 7's shape).
- I. B. Fesenko, S. V. Vostokov, *Local Fields and Their Extensions*, 2nd ed. — Ch. I–III
  (unit filtrations, the norm map, Hasse–Herbrand without ramification groups — an
  alternative route worth tracking for Layer 3's norm analysis), Ch. IV (local CFT via
  Neukirch and Hazewinkel maps simultaneously; §5 the Hilbert pairing — Layer 8's bridge),
  Ch. VII–VIII (explicit formulas, Lubin–Tate — long horizon).
- J. Milne, *Arithmetic Duality Theorems*, 2nd ed. — Ch. I §§1–2: the primary shape source
  for Layer 8 (I.2.1/I.2.3 duality, I.2.8 Euler characteristic).
- J.-P. Serre, *Galois Cohomology* — Ch. I–II (profinite cohomology conventions, II §5.2
  duality, II §5.7 Euler characteristic; the `𝔽_p`-dimension exercise behind the counting
  corollary).
- J.-P. Serre, *A Course in Arithmetic* — Ch. II–III (`ℚ_p`, squares, the Hilbert-symbol
  table used by the worked examples).
- U. Jannsen, K. Wingberg, *Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper*
  (Invent. Math. 70, 1982); V. Diekert; I. G. Zelvenskii — the full-presentation long
  horizon and the dyadic case (also the `N + 3` fallback bound, Jannsen Satz 3.2).
- M. Hazewinkel, *Local class field theory is easy* (Adv. Math. 18, 1975) — the
  Hazewinkel-map alternative to the Neukirch route; consulted for Layer 6/7 design.
- Not held locally at the time of writing (listed for acquisition): Cassels–Fröhlich (eds.),
  *Algebraic Number Theory* (Serre's "Local class field theory" chapter); Artin–Tate, *Class
  Field Theory* (the splitting-module Tate–Nakayama route Layer 6 pins); Iwasawa, *Local
  Class Field Theory* (1986); Harari, *Galois Cohomology and Class Field Theory*; Lubin–Tate,
  *Formal complex multiplication in local fields* (1965).

## Provenance and coordination

- **kbuzzard/ClassFieldTheory** (Apache-2.0; Kevin Buzzard, Yunzhou "Edison" Xie, and the 2025
  Clay school contributors). This roadmap develops the same finite-level CFT independently in
  Tau Ceti (owner decision, overriding the gq2 planning document's "contribute there"
  recommendation), with three standing obligations: (i) interface alignment — the
  `FiniteClassFormation` shape, the Herbrand-quotient convention, and the
  `IsNonarchimedeanLocalField` vocabulary are adopted as-is so statements are mutually
  translatable; (ii) citation — the blueprint (`blueprint/src/_3_local.tex`) theorem sequence
  is the finite-level skeleton Layers 5–6 follow; (iii) refactor-on-landing — if their local
  half (the four open items) lands in Mathlib, the corresponding Tau Ceti milestones become
  comparison-and-consume tasks, and a maintainer note to that effect belongs on each affected
  milestone at implementation time. Contact before starting Layers 5–6, and again before any
  statement-level divergence.
- **Akwardbro/RamificationGroup** (Junjie Bai, Jiedong Jiang, Prowler99, Yicheng Tao):
  cite on Layer 3 throughout; the development here is independent (different substrate:
  `IsNonarchimedeanLocalField` vs their mariainesdff-stack) but their file layout
  (`LowerNumbering`/`HerbrandFunction`/`UpperNumbering`) and lemma granularity are useful
  prior art. Coordinate with the authors before reusing any statement shapes; no code copying
  without license check and agreement.
- **mariainesdff/LocalClassFieldTheory** (M. I. de Frutos-Fernández, F. A. E. Nuccio;
  arXiv:2310.01998): their Mathlib-landed layers (spectral norm, valuation algebra instances,
  Minpoly) are consumed directly; their unlanded `DiscreteValuationRing/Extensions.lean` is
  prior art for Layer 0's extension milestone — coordinate before overlapping, and prefer
  helping their remaining upstreaming over re-deriving where the statements already match the
  pin's vocabulary.
- **ImperialCollegeLondon/FLT**: downstream consumer (their blueprint's
  `local_class_field_theory` assumption is `K^× ≅ W_K^{ab}`-shaped and `\notready`); the
  Weil-group packaging is *not* in this roadmap's scope, but Layer 7's `Art_K` with dense
  image is the substance of it — flag to FLT when Layer 7 lands.
- **gq2-lean** (Apache-2.0, same owner; `github.com/roed-math/gq2-lean`): the acceptance
  targets B1/B5/B6/B7/B10 of `GQ2/Foundations/Axioms.lean` are the late-layer worked examples
  above, *stated intrinsically* — this roadmap specifies the mathematics, not that code.
  Migration candidates, to be adapted (not canonized) where they match the intrinsic
  statements: `UnitFiltration*.lean`/`UnitNormIndex.lean` (Layer 1), `TeichmullerLift.lean`
  (Layer 1), `UnramifiedBridge/UnramifiedModel/UnramifiedNorm.lean` (Layer 2),
  `Zhat.lean` (Layer 2's `Ẑ`), `Tame*.lean` (Layer 4), `LocalKummer.lean`/`MuN.lean`
  (Layer 5), `Reciprocity.lean` (Layer 7 statement shapes), `TateDuality.lean`/
  `EulerCharacteristic.lean` (Layer 8 statement shapes). Known deviations in those encodings
  that this roadmap **repairs** rather than inherits: per-`n` duality without cross-`n`
  compatibility (Layer 8 names it), the unnormalized `inv` (Layer 5 pins it), the geometric
  `ν_ur` as primary (here a translation lemma).
- **davidturturean/gq2-lean-turturean** (GPL-3.0): audit/comparison source only; the license
  is incompatible with code reuse here.
- **Adic-spaces roadmap (TauCetiRoadmap PR #80, C. Birkbeck)**: shared `ValuativeRel`
  substrate, disjoint content (see the opening); if both land, `ℚ_p`-instance work in Layer 0
  should be checked against its Layer-0 examples for duplication.
- **Zulip** (audited 2026-07-30; load-bearing threads): the `IsNonarchimedeanLocalField`
  design history — PR #27465 (erdOne, merged 2025-10; Oxford CFT-workshop origin; the
  `TopologicalSpace`-not-`UniformSpace` decision after Gouëzel's locally-compact-completeness
  point) is in [maths > "Local fields in Lean 4"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Local.20fields.20in.20Lean.204/near/530522781)
  and [mathlib4 > "Finite extensions of Q_p"](https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/topic/Finite.20extensions.20of.20Q_p/near/501395419)
  (also the "Artin map via group cohomology, not Lubin–Tate" route decision); the
  `Valued`-deprecation project is [PR reviews > "Project: Deprecate `Valued`"](https://leanprover.zulipchat.com/#narrow/channel/144837-PR-reviews/topic/Project.3A.20Deprecate.20.60Valued.60/near/581079158)
  (Jiedong Jiang, 2026-03-23); the unramified-API direction is
  ["unramified extensions of local fields"](https://leanprover.zulipchat.com/#narrow/channel/217875-Is-there-code-for-X.3F/topic/unramified.20extensions.20of.20local.20fields/near/546006441)
  (2025-10-20); the ramification-filtration design thread is
  [maths > "Formalizing Ramification Groups"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Formalizing.20Ramification.20Groups/near/426788185)
  (2024-03, Jiedong Jiang, Topaz, Buzzard); the FLT local-CFT axiom announcement is
  [FLT > "update"](https://leanprover.zulipchat.com/#narrow/channel/416277-FLT/topic/update/near/613077432)
  (A. Yang, 2026-07-27); the open `TopRep` debate is
  [maths > "Continuous cohomology"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Continuous.20cohomology/near/610038284)
  (2026-07). ⚠ The ClassFieldTheory project's day-to-day channel is **private** (created for
  the 2025 Clay workshop; access by DM to Buzzard), so repository sorry-state is the best
  public proxy for its progress — confirm anything decision-critical in `#maths` or by
  requesting access. Announce intentions (per the root README's claims process) before
  starting Layer 0 and again before Layers 5–6.
